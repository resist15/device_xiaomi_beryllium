/*
 *  Poco Extras Settings Module
 *  Made by @shivatejapeddi 2019
 *  rewriten by @resist15 2022
 */

package com.xiaomi.settings;

import android.app.ActionBar;
import android.app.ActivityManager;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.Dialog;
import android.app.DialogFragment;
import android.content.Context;
import android.content.DialogInterface;
import android.content.SharedPreferences;
import android.content.Intent;
import android.os.Bundle;
import androidx.preference.PreferenceFragment;
import androidx.preference.PreferenceManager;
import androidx.preference.SwitchPreference;
import androidx.preference.Preference;
import androidx.preference.PreferenceCategory;
import androidx.preference.SwitchPreference;
import com.xiaomi.settings.kcal.KCalSettingsActivity;
import com.xiaomi.settings.FileUtil;
import androidx.preference.TwoStatePreference;
import com.xiaomi.settings.fpsinfo.FPSInfoService;
import com.xiaomi.settings.SecureSettingListPreference;
import com.xiaomi.settings.CustomSeekBarPreference;
import com.xiaomi.settings.Utils;
import android.os.FileUtils;
import com.xiaomi.settings.VibratorStrengthPreference;
import android.provider.Settings;
import android.view.Menu;
import android.os.UserHandle;
import android.content.ContentResolver;
import android.view.MenuItem;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Locale;
import java.util.Date;
import android.util.Slog;
import android.util.Log;
import android.os.SystemProperties;
import java.io.*;
import android.widget.Toast;

import com.xiaomi.settings.R;

public class PocoPrefSettings extends PreferenceFragment implements
        Preference.OnPreferenceChangeListener {
	private static final boolean DEBUG = false;
	private static final String TAG = "PocoPref";
    public static final String PREF_DEVICE_KCAL = "device_kcal";
    public static final String CATEGORY_DISPLAY = "display";    
    public static final String DEFAULT_PERF_PROFILE = "default_perf_profile";
    public static final String PERFORMANCE_SYSTEM_PROPERTY = "persist.perf.default";
    public static final String DEFAULT_THERMAL_PROFILE = "default_therm_profile";
    public static final String THERMAL_SYSTEM_PROPERTY = "persist.therm.default";
    public static final String KEY_VIBSTRENGTH = "vib_strength";
    public static final String KEY_WAVEFORM = "vib_waveform";
    public static final String DEFAULT_KEY_WAVEFORM = "3e 3e 3e 3e be be a0 90";        
    public static final String SMART_CHARGING_PATH = "/sys/class/power_supply/battery/input_suspend";    
    public static final String KEY_FPS_INFO = "fps_info";

    public static final String KEY_WAVEFORM_PATH = "/sys/devices/platform/soc/c440000.qcom,spmi/spmi-0/spmi0-03/c440000.qcom,spmi:qcom,pmi8998@3:qcom,haptics@c000/leds/vibrator/effect_samp";    
    
    private Context mContext;
    private Preference mThermPref;
    private Preference mPerfPref;
    private Preference mKcal;
    private SecureSettingListPreference mDefaultPerfProfile;
    private SecureSettingListPreference mDefaultThermProfile;
    private VibratorStrengthPreference mVibratorStrength;
    private SecureSettingListPreference mWaveForm;    
    private SharedPreferences prefs; 
    private String mWaveFormValue;
    private CustomSeekBarPreference mSeekBarPreference;
    
    @Override
    public void onCreatePreferences(Bundle savedInstanceState, String rootKey) {
        setPreferencesFromResource(R.xml.poco_settings, rootKey);	
        mContext = this.getContext();
        prefs = PreferenceManager.getDefaultSharedPreferences(mContext);

        PreferenceCategory displayCategory = (PreferenceCategory) findPreference(CATEGORY_DISPLAY);

        mKcal = findPreference(PREF_DEVICE_KCAL);

        mKcal.setOnPreferenceClickListener(preference -> {
            Intent intent = new Intent(getActivity().getApplicationContext(), KCalSettingsActivity.class);
            startActivity(intent);
            return true;
        });		
		
             mThermPref = findPreference("therm_display");
                mThermPref.setOnPreferenceClickListener(new Preference.OnPreferenceClickListener() {
                     @Override
                     public boolean onPreferenceClick(Preference preference) {
                         Intent intent = new Intent(getContext(), ThermalActivity.class);
                         startActivity(intent);
                         return true;
                     }
                });
             mPerfPref = findPreference("perf_display");
                mPerfPref.setOnPreferenceClickListener(new Preference.OnPreferenceClickListener() {
                     @Override
                     public boolean onPreferenceClick(Preference preference) {
                         Intent intent = new Intent(getContext(), PerformanceActivity.class);
                         startActivity(intent);
                         return true;
                     }
                });



            mDefaultPerfProfile = (SecureSettingListPreference) findPreference(DEFAULT_PERF_PROFILE);
            mDefaultPerfProfile.setValue(FileUtil.getStringProp(PERFORMANCE_SYSTEM_PROPERTY, "0"));
            mDefaultPerfProfile.setOnPreferenceChangeListener(this);            

            mDefaultThermProfile = (SecureSettingListPreference) findPreference(DEFAULT_THERMAL_PROFILE);
            mDefaultThermProfile.setValue(FileUtil.getStringProp(THERMAL_SYSTEM_PROPERTY, "0"));
            mDefaultThermProfile.setOnPreferenceChangeListener(this);
	        	
            SwitchPreference fpsInfo = (SwitchPreference) findPreference(KEY_FPS_INFO);
            fpsInfo.setChecked(isFPSOverlayRunning());
            fpsInfo.setOnPreferenceChangeListener(this);

        mVibratorStrength = (VibratorStrengthPreference) findPreference(KEY_VIBSTRENGTH);
        if (mVibratorStrength != null) {
            mVibratorStrength.setEnabled(VibratorStrengthPreference.isSupported());
        }

		
        mWaveFormValue = prefs.getString(KEY_WAVEFORM, DEFAULT_KEY_WAVEFORM);  
        mWaveForm = (SecureSettingListPreference) findPreference(KEY_WAVEFORM);
        mWaveForm.setValue(mWaveFormValue);
        mWaveForm.setOnPreferenceChangeListener(this);       

     }

    public static void restore(Context context) {
       String profile = PreferenceManager
              .getDefaultSharedPreferences(context).getString(PocoPrefSettings.KEY_WAVEFORM, DEFAULT_KEY_WAVEFORM);
             try {
            FileUtils.stringToFile(KEY_WAVEFORM_PATH, profile);
            } catch (IOException e) {
            Slog.e(TAG, "Error writing ", e);
            }                          
     }
                    
    private boolean isFPSOverlayRunning() {
        ActivityManager am = (ActivityManager) getContext().getSystemService(
                Context.ACTIVITY_SERVICE);
        for (ActivityManager.RunningServiceInfo service :
                am.getRunningServices(Integer.MAX_VALUE))
            if (FPSInfoService.class.getName().equals(service.service.getClassName()))
                return true;
        return false;
   }

    @Override
    public void onResume() {
        super.onResume();
        final SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(getContext());
        SwitchPreference fpsInfo = (SwitchPreference) findPreference(KEY_FPS_INFO);
        fpsInfo.setChecked(isFPSOverlayRunning());
    }

    @Override
    public boolean onPreferenceChange(Preference preference, Object value) {

        final String key = preference.getKey();      
        switch (key) {




            case KEY_WAVEFORM:
            mWaveFormValue = value.toString();
            prefs.edit().putString(KEY_WAVEFORM, mWaveFormValue).commit();            
            try {
            FileUtils.stringToFile(KEY_WAVEFORM_PATH, mWaveFormValue);
            } catch (IOException e) {
            Slog.e(TAG, "Error writing ", e);
            }
                break;
            case DEFAULT_PERF_PROFILE:
                mDefaultPerfProfile.setValue((String) value);
                FileUtil.setStringProp(PERFORMANCE_SYSTEM_PROPERTY, (String) value);
                break;
                
            case DEFAULT_THERMAL_PROFILE:
                mDefaultThermProfile.setValue((String) value);
                FileUtil.setStringProp(THERMAL_SYSTEM_PROPERTY, (String) value);
                break;      
				
            default:
                break;

            case KEY_FPS_INFO:
                boolean enabled = (Boolean) value;
                Intent fpsinfo = new Intent(this.getContext(), FPSInfoService.class);
                if (enabled) {
                    this.getContext().startService(fpsinfo);
                } else {
                    this.getContext().stopService(fpsinfo);
                }
                break;
        }
        return true;
    }

  
}
