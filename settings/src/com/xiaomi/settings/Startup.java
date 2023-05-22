/*
* Copyright (C) 2013 The OmniROM Project
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program. If not, see <http://www.gnu.org/licenses/>.
*
*/
package com.xiaomi.settings;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import com.xiaomi.settings.kcal.KCalSettings;
import com.xiaomi.settings.fpsinfo.FPSInfoService;
import com.xiaomi.settings.Utils;
import androidx.preference.PreferenceManager;
import android.provider.Settings;
import com.xiaomi.settings.VibratorStrengthPreference;
import com.xiaomi.settings.PocoPrefSettings;
import com.xiaomi.settings.dirac.DiracUtils;
import com.xiaomi.settings.doze.DozeUtils;

public class Startup extends BroadcastReceiver {

    private void restore(String file, boolean enabled) {
        if (file == null) {
            return;
        }
        if (enabled) {
            Utils.writeValue(file, "1");
        }
    }

    private void restore(String file, String value) {
        if (file == null) {
            return;
        }
        Utils.writeValue(file, value);
    }
        @Override
    public void onReceive(final Context context, final Intent bootintent) {
        // System
        VibratorStrengthPreference.restore(context);
        PocoPrefSettings.restore(context);
        PerformanceUtils.startService(context);
        KCalSettings.restore(context);
        ThermalUtils.startService(context);        
        DozeUtils.checkDozeService(context);
        DiracUtils.getInstance(context);
        SharedPreferences sharedPrefs = PreferenceManager.getDefaultSharedPreferences(context);
        //FPS
        boolean enabled = sharedPrefs.getBoolean(PocoPrefSettings.KEY_FPS_INFO, false);
        if (enabled) {
            context.startService(new Intent(context, FPSInfoService.class));

        }
    }
}
