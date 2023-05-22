/*
 * Copyright (C) 2020 The LineageOS Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.xiaomi.settings;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.FileUtils;
import android.os.SystemProperties;
import android.os.UserHandle;
import android.util.Log;

import androidx.preference.PreferenceManager;

import java.io.IOException;

public final class PerformanceUtils {

    private static final String TAG = "PerformanceUtils";
    private static final String PERFORMANCE_CONTROL = "performance_control";

    protected static final int STATE_DEFAULT = 0;
    protected static final int STATE_PERFORMANCE = 1;
    protected static final int STATE_GAMING = 2;    
    protected static final int STATE_BATTERY = 3;
    protected static final int STATE_BALANCED2 = 4;    

    private static final String PERFORMANCE_STATE_DEFAULT = "0";
    private static final String PERFORMANCE_STATE_PERFORMANCE = "1";
    private static final String PERFORMANCE_STATE_GAMING = "2";
    private static final String PERFORMANCE_STATE_BATTERY = "3";
    private static final String PERFORMANCE_STATE_BALANCED2 = "4";        
    
    private static final String PERFORMANCE_PERFORMANCE = "performance.performance=";
    private static final String PERFORMANCE_GAMING = "performance.gaming=";    
    private static final String PERFORMANCE_BATTERY = "performance.battery=";
    private static final String PERFORMANCE_BALANCED2 = "performance.balanced2=";    


    private SharedPreferences mSharedPrefs;

    protected PerformanceUtils(Context context) {
        mSharedPrefs = PreferenceManager.getDefaultSharedPreferences(context);
    }

    public static void startService(Context context) {
        context.startServiceAsUser(new Intent(context, PerformanceService.class),
                UserHandle.CURRENT);
    }

    private void writeValue(String profiles) {
        mSharedPrefs.edit().putString(PERFORMANCE_CONTROL, profiles).apply();
    }

    private String getValue() {
        String value = mSharedPrefs.getString(PERFORMANCE_CONTROL, null);

        if (value == null || value.isEmpty()) {
            value = PERFORMANCE_PERFORMANCE + ":" + PERFORMANCE_GAMING + ":" + PERFORMANCE_BATTERY + ":" + PERFORMANCE_BALANCED2;
            writeValue(value);
        }
        return value;
    }

    protected void writePackage(String packageName, int mode) {
        String value = getValue();
        value = value.replace(packageName + ",", "");
        String[] modes = value.split(":");
        String finalString;

        switch (mode) {
            case STATE_PERFORMANCE:
                modes[0] = modes[0] + packageName + ",";
                break;
            case STATE_GAMING:
                modes[1] = modes[1] + packageName + ",";
                break;
            case STATE_BATTERY:
                modes[2] = modes[2] + packageName + ",";
                break;
            case STATE_BALANCED2:
                modes[3] = modes[3] + packageName + ",";
                break;                
        }

        finalString = modes[0] + ":" + modes[1] + ":" + modes[2] + ":" + modes[3];

        writeValue(finalString);
    }

    protected int getStateForPackage(String packageName) {
        String value = getValue();
        String[] modes = value.split(":");
        int state = STATE_DEFAULT;
        if (modes[0].contains(packageName + ",")) {
            state = STATE_PERFORMANCE;
        } else if (modes[1].contains(packageName + ",")) {
            state = STATE_GAMING;
        } else if (modes[2].contains(packageName + ",")) {
            state = STATE_BATTERY;
        } else if (modes[3].contains(packageName + ",")) {
            state = STATE_BALANCED2;            
        }

        return state;
    }

    protected void setPerformanceProfile(String packageName) {
        String value = getValue();
        String modes[];
        String state = getSystemPropertyString("persist.perf.default","0");

        if (value != null) {
            modes = value.split(":");

            if (modes[0].contains(packageName + ",")) {
                state = PERFORMANCE_STATE_PERFORMANCE;
            } else if (modes[1].contains(packageName + ",")) {
                state = PERFORMANCE_STATE_GAMING;
            } else if (modes[2].contains(packageName + ",")) {
                state = PERFORMANCE_STATE_BATTERY;
            } else if (modes[3].contains(packageName + ",")) {
                state = PERFORMANCE_STATE_BALANCED2;
            }
        }

        SystemProperties.set("persist.performance.profile",state);
    }

    private String getSystemPropertyString(String key, String def) {
        return SystemProperties.get(key,def);
    }
}
