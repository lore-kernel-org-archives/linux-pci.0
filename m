Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:33633 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755153Ab3IYM3n (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Sep 2013 08:29:43 -0400
Received: by mail-wg0-f53.google.com with SMTP id x12so6024553wgg.8
        for <linux-pci@vger.kernel.org>; Wed, 25 Sep 2013 05:29:42 -0700 (PDT)
Message-ID: <5242D734.7020800@linaro.org>
Date: Wed, 25 Sep 2013 14:29:40 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Aaron Lu <aaron.lwe@gmail.com>
CC: Hans de Bruin <jmdebruin@xmsnet.nl>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Linux-pm mailing list <linux-pm@vger.kernel.org>
Subject: Re: Bisected 3.12.0-rc1 Laptop screen goes blank during kernelboot
References: <523C8238.3000200@xmsnet.nl> <523E51A9.8050609@gmail.com>
In-Reply-To: <523E51A9.8050609@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/22/2013 04:10 AM, Aaron Lu wrote:
> Add linux-pm.
> 
> -Aaron
> 
> On 09/21/2013 01:13 AM, Hans de Bruin wrote:
>> During boot time my laptop screen goes blank when de kernel switches the 
>> screen to another resolution. The backlight is on. Eventually a kde 
>> login box appears out of the blackness. Swiching to a lower resolution 
>> gives me a black screen again. After testing the 
>> intel-gfx@lists.freedesktop.org developers test-tree problem less they 
>> sugested a bisect. That bisect ended in:
>>
>>
>> commit 137b944e100278d696826cf25c83014ac17473fe
>> Author: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Date:   Wed Jun 12 15:08:48 2013 +0200
>>
>>    cpuidle: Make it clear that governors cannot be modules
>>
>>    cpufreq governors are defined as modules in the code, but the Kconfig
>>    options do not allow them to be built as modules.  This is not really
>>    a problem, but the cpuidle init ordering is: the cpuidle init
>>    functions (framework and driver) and then the governors.  That leads
>>    to some weirdness in the cpuidle framework.
>>
>>    Namely,  cpuidle_register_device() calls cpuidle_enable_device() which
>>    fails at the first attempt, because governors have not been registered
>>    yet.  When a governor is registered, the framework calls
>>    cpuidle_enable_device() again which runs __cpuidle_register_device()
>>    only then.  Of course, for that to work, the cpuidle_enable_device()
>>    return value has to be ignored by cpuidle_register_device().
>>
>>      Instead of having this cyclic call graph and relying on a positive
>>      side effects of the hackish back and forth cpuidle_enable_device()
>>      calls it is better to fix the cpuidle init ordering.
>>
>>      To that end, replace the module init code with postcore_initcall()
>>      so we have:
>>
>>       * cpuidle framework : core_initcall
>>       * cpuidle governors : postcore_initcall
>>       * cpuidle drivers   : device_initcall
>>
>>      and remove the corresponding module exit code as it is dead anyway
>>      (governors can't be built as modules).
>>
>>      [rjw: Changelog]
>>      Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>      Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> :040000 040000 45e7cb28411864c00b62296a7ff239f9f139d5d9 
>> 86a36b01dee52a77cfbab41a973b7a2bfa44ce34 M      drivers
>>
>>
>>
>> Reverting it makes the problem go away.

Ok, can you give more informations about it, I don't see the connection
between screen resolution and cpuidle.

It would be interesting here to understand the root problem.

Can you give the cpuidle configuration (used governor and driver) ? If
you don't revert the patch but disable cpuidle (eg. cpuidle.off=1 or
don't compile it in the kernel), does the bug issue still occur ?

Thanks
  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

