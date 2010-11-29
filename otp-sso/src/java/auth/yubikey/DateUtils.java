/*
 * Copyright 2008 Yubico
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); 
 * you may not use this file except in compliance with the License. 
 *
 * You may obtain a copy of the License at 
 *   http://www.apache.org/licenses/LICENSE-2.0 
 * 
 * Unless required by applicable law or agreed to in writing, software 
 * distributed under the License is distributed on an "AS IS" BASIS, 
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
 *
 * See the License for the specific language governing permissions and 
 * limitations under the License.
 *
 */
package auth.yubikey;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtils
{
  // private final static Logger log = Logger.getLogger(DateUtils.class);

  static String getTimeStamp ()
  {
    SimpleDateFormat sdf =
      new SimpleDateFormat ("yyyy-MM-dd'T'HH:mm:ss'Z'SSSS");
    Date tmp = new Date ();
      return sdf.format (tmp);
  }
}
