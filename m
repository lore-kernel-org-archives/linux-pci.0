Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp1.ispfabriek.nl ([37.251.0.168]:54414 "EHLO
	smtp1.ispfabriek.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393Ab3ITRWj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 20 Sep 2013 13:22:39 -0400
Message-ID: <523C8238.3000200@xmsnet.nl>
Date: Fri, 20 Sep 2013 19:13:28 +0200
From: Hans de Bruin <jmdebruin@xmsnet.nl>
MIME-Version: 1.0
To: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Bisected 3.12.0-rc1 Laptop screen goes blank during kernelboot
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

During boot time my laptop screen goes blank when de kernel switches the 
screen to another resolution. The backlight is on. Eventually a kde 
login box appears out of the blackness. Swiching to a lower resolution 
gives me a black screen again. After testing the 
intel-gfx@lists.freedesktop.org developers test-tree problem less they 
sugested a bisect. That bisect ended in:


commit 137b944e100278d696826cf25c83014ac17473fe
Author: Daniel Lezcano <daniel.lezcano@linaro.org>
Date:   Wed Jun 12 15:08:48 2013 +0200

   cpuidle: Make it clear that governors cannot be modules

   cpufreq governors are defined as modules in the code, but the Kconfig
   options do not allow them to be built as modules.  This is not really
   a problem, but the cpuidle init ordering is: the cpuidle init
   functions (framework and driver) and then the governors.  That leads
   to some weirdness in the cpuidle framework.

   Namely,  cpuidle_register_device() calls cpuidle_enable_device() which
   fails at the first attempt, because governors have not been registered
   yet.  When a governor is registered, the framework calls
   cpuidle_enable_device() again which runs __cpuidle_register_device()
   only then.  Of course, for that to work, the cpuidle_enable_device()
   return value has to be ignored by cpuidle_register_device().

     Instead of having this cyclic call graph and relying on a positive
     side effects of the hackish back and forth cpuidle_enable_device()
     calls it is better to fix the cpuidle init ordering.

     To that end, replace the module init code with postcore_initcall()
     so we have:

      * cpuidle framework : core_initcall
      * cpuidle governors : postcore_initcall
      * cpuidle drivers   : device_initcall

     and remove the corresponding module exit code as it is dead anyway
     (governors can't be built as modules).

     [rjw: Changelog]
     Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

:040000 040000 45e7cb28411864c00b62296a7ff239f9f139d5d9 
86a36b01dee52a77cfbab41a973b7a2bfa44ce34 M      drivers



Reverting it makes the problem go away.

-- 
Hans
