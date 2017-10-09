Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] pci: Fix a possible sleep-in-atomic bug in
 pci_set_power_state
To: Greg KH <gregkh@linuxfoundation.org>
Cc: patrik.r.jakobsson@gmail.com, airlied@linux.ie,
        bhelgaas@google.com, forest@alittletooquiet.net, simon@nikanor.nu,
        scott@matheina.com, tvboxspy@gmail.com, dan.a.cashman@gmail.com,
        golubev.mikhail@gmail.com, devel@driverdev.osuosl.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <1507536980-9345-1-git-send-email-baijiaju1990@163.com>
 <20171009081747.GA23371@kroah.com>
From: Jia-Ju Bai <baijiaju1990@163.com>
Message-ID: <511f30f4-1b9e-1b1a-aad8-6c0505b40e4e@163.com>
Date: Mon, 9 Oct 2017 16:32:33 +0800
MIME-Version: 1.0
In-Reply-To: <20171009081747.GA23371@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Oh, sorry, I will send the patches for each driver.


Thanks,
Jia-Ju Bai

On 2017/10/9 16:17, Greg KH wrote:
> On Mon, Oct 09, 2017 at 04:16:20PM +0800, Jia-Ju Bai wrote:
>> The drivers vt6655 and gma500 call pci_set_power_state under a spinlock, which may sleep.
>> The function call paths are:
>> gma_power_begin (acquire the spinlock) (drivers/gpu/drm/gma500/power.c)
>>    gma_resume_pci
>>      pci_set_power_state
>>        __pci_start_power_transition (drivers/pci/pci.c)
>>          msleep --> may sleep
>>
>> gma_power_begin (acquire the spinlock) (drivers/gpu/drm/gma500/power.c)
>>    gma_resume_pci
>>      pci_enable_device
>>        pci_enable_device_flags (drivers/pci/pci.c)
>>          do_pci_enable_device
>>            pci_set_power_state
>>              __pci_start_power_transition
>>                msleep --> may sleep
>>
>> vt6655_suspend (acquire the spinlock) (drivers/staging/vt6655/device_main.c)
>>    pci_set_power_state
>>      __pci_start_power_transition (drivers/pci/pci.c)
>>        msleep --> may sleep
>>
>> To fix these bugs, msleep is replaced with mdelay in __pci_start_power_transition
>>
>> These bugs are found by my static analysis tool and my code review.
> Wait, no, why not fix the callers to not have a spinlock.  Those are the
> only users of these calls that are doing so incorrectly, don't change
> the PCI core for the fault of 2 broken drivers.
>
> thanks,
>
> greg k-h
