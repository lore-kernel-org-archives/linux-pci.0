Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:39822 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322Ab3I0HFo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Sep 2013 03:05:44 -0400
Received: by mail-we0-f174.google.com with SMTP id q58so2204790wes.19
        for <linux-pci@vger.kernel.org>; Fri, 27 Sep 2013 00:05:43 -0700 (PDT)
Message-ID: <52452E45.5000501@linaro.org>
Date: Fri, 27 Sep 2013 09:05:41 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Hans de Bruin <jmdebruin@xmsnet.nl>
CC: Aaron Lu <aaron.lwe@gmail.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Linux-pm mailing list <linux-pm@vger.kernel.org>
Subject: Re: Bisected 3.12.0-rc1 Laptop screen goes blank during kernelboot
References: <523C8238.3000200@xmsnet.nl> <523E51A9.8050609@gmail.com> <5242D734.7020800@linaro.org> <52447A4C.3020000@xmsnet.nl>
In-Reply-To: <52447A4C.3020000@xmsnet.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/26/2013 08:17 PM, Hans de Bruin wrote:

[ ... ]

> todays kernel with problem:
>
> #
> # CPU Idle
> #
> CONFIG_CPU_IDLE=y
> # CONFIG_CPU_IDLE_MULTIPLE_DRIVERS is not set
> CONFIG_CPU_IDLE_GOV_LADDER=y
> CONFIG_CPU_IDLE_GOV_MENU=y
> # CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
> CONFIG_INTEL_IDLE=y
>
>
> ==> /sys/devices/system/cpu/cpuidle/current_driver <==
> acpi_idle
>
> ==> /sys/devices/system/cpu/cpuidle/current_governor_ro <==
> menu
>
> [    0.056000] cpuidle: using governor ladder
> [    0.056000] cpuidle: using governor menu
>
>
>
> 3.8.0:
> bash-4.1# tail /sys/devices/system/cpu/cpuidle/*
> ==> /sys/devices/system/cpu/cpuidle/current_driver <==
> acpi_idle
>
> ==> /sys/devices/system/cpu/cpuidle/current_governor_ro <==
> menu
>
> [    1.759857] cpuidle: using governor ladder
> [    1.763849] scsi 0:0:0:0: Direct-Access     ATA      TOSHIBA MK4009GA
> BS11 PQ: 0 ANSI: 5
> [    1.767098] cpuidle: using governor menu

Thanks for the detailed information. Could you pastebin you kernel 
config file or send it to me privately so I can reproduce the problem ?


-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

