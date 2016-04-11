Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36432 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531AbcDKV50 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2016 17:57:26 -0400
Received: by mail-pa0-f42.google.com with SMTP id bx7so112982184pad.3
        for <linux-pci@vger.kernel.org>; Mon, 11 Apr 2016 14:57:26 -0700 (PDT)
Subject: Re: [PATCH 1/2] PCI: iproc: Support DT property for ignoring aborts
 when probing
To: Ray Jui <ray.jui@broadcom.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Jon Mason <jonmason@broadcom.com>
References: <1460238624-2086-1-git-send-email-zajec5@gmail.com>
 <79DC79A7-D4CE-4983-B1C5-CBD2E9CBBFB9@gmail.com>
 <4768648c-841b-490d-a752-f31cba545f74@broadcom.com>
Cc: linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
	linux-arm-kernel@lists.infradead.org,
	Hauke Mehrtens <hauke@hauke-m.de>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <570C1D47.7010102@gmail.com>
Date: Mon, 11 Apr 2016 14:55:19 -0700
MIME-Version: 1.0
In-Reply-To: <4768648c-841b-490d-a752-f31cba545f74@broadcom.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/04/16 13:06, Ray Jui wrote:
> 
> 
> On 4/10/2016 6:43 PM, Florian Fainelli wrote:
>> On April 9, 2016 2:50:23 PM PDT, "Rafał Miłecki" <zajec5@gmail.com>
>> wrote:
>>> Some devices (e.g. Northstar ones) may have bridges that forward
>>> harmless errors to the ARM core. In such case we need an option to
>>> add a handler ignoring them.
>>>
>>> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
>>> ---
>>
>>> +- brcm,pcie-hook-abort-handler: During PCI bus probing (device
>>> enumeration)
>>> +  there can be errors that are expected and harmless. Unfortunately
>>> some bridges
>>> +  can't be configured to ignore them and they forward them to the ARM
>>> core
>>> +  triggering die().
>>> +  This property should be set in such case, it will make driver add
>>> its own
>>> +  handler ignoring such errors.
>>
>> The property is named after the function that allows you to catch
>> abort handlers, whereas you should be describing the HW here.
>> Something like brcm,bridge-error-forward or a better name even would
>> be preferable.
>>
>>> +#ifdef CONFIG_ARM
>>> +static int iproc_pcie_abort_handler(unsigned long addr, unsigned int
>>> fsr,
>>> +                    struct pt_regs *regs)
>>> +{
>>> +    if (fsr == 0x1406)
>>> +        return 0;
>>> +
>>> +    return 1;
>>
>> As you later noted this prevents this driver from being a module now.
>> Since the expectation is that either a fixed bootloader or a platform
>> should enot produce these data aborts, or allow them to be ignored,
>> why not just put this code back where it belongs in the machine
>> specific file which kills many birds with the same stone:
>>
> 
> I assume the module compile issue can be simply fixed by exporting
> symbol of "hook_fault_code"?

I do not think it is desireable for this symbol to be exported in the
first place, also last I looked, this was a one time registration thing,
you cannot undo the hook you installed, but everything can be fixed.

> 
> I believe ARM64 based NS2 that uses the same iProc PCIe driver might
> also need something like this (I'm still waiting for Jon Mason to give
> me some more information on the NS2 errors that he saw, which is likely
> related to this). I assume there will be something similar to the ARM
> specific "hook_fault_code" for ARM64, but then ARM64 does not have any
> "mach" specific directory. Where can this type of hook be installed for
> ARM64 based platforms if not in the PCIe driver?

OK, that is a fair point, then maybe have a two stage process, where we
make sure that the part that installs the hook is always available and
built-into the kernel, but let the iProc PCIe driver remain a module?

> 
>> - code is ways built-in, and hook_fault_code is installed prior to
>> PCIe loading (function is marked with __init)
>> - platforms which do not need that, just do not install it for that
>> specific code
>> - it is clear which platforms need it and which do not, yet the driver
>> remains agnostic
> 
> It's actually unclear to me which iProc platforms need this.
> - We know NS needs it
> - Someone mentioned NSP does not need this? But where does the
> information come from? Do we have similar PCIe connection configuration
> on NSP as NS?
> - I cannot confirm whether Cygnus needs this or not since we do not have
> similar board configurations on Cygnus (on Cygnus each host is always
> connected to a single device). I can check with the ASIC team, but that
> will be a very lengthy process and I'm not sure when I can get the
> answer we need (and yes I do work at Broadcom, :))
> - Jon Mason reported similar abort issues on NS2 when an externally
> connected, multi function device is used. I'm still waiting for him to
> send me the error log and see if it's the same type of data abort.

Is there really no way to flip some chicken bits to prevent the PCIe
root complex from forwarding some of these errors?

Also, sorry if this is repeating information, but how can we generate
spurious aborts if we are scanning the PCIe bus, are we possibly trying
to access the RC's config space before it is set up (this should not
fail), or something else?

Thanks!

> 
>>
>> NB: there could be other platforms some day needing that which also
>> propagate the error differently, forcing you to add more and more of
>> these codes in the PCIe driver.
>>
> 
> Yes, at this point, we are unsure whether the same or different code is
> used among different platforms.
> 
> Thanks,
> 
> Ray


-- 
Florian
