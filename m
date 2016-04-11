Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34549 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755184AbcDKWnO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2016 18:43:14 -0400
Received: by mail-pa0-f51.google.com with SMTP id ot11so444165pab.1
        for <linux-pci@vger.kernel.org>; Mon, 11 Apr 2016 15:43:14 -0700 (PDT)
Subject: Re: [PATCH 1/2] PCI: iproc: Support DT property for ignoring aborts
 when probing
To: Ray Jui <ray.jui@broadcom.com>,
	Scott Branden <scott.branden@broadcom.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Jon Mason <jonmason@broadcom.com>
References: <1460238624-2086-1-git-send-email-zajec5@gmail.com>
 <79DC79A7-D4CE-4983-B1C5-CBD2E9CBBFB9@gmail.com>
 <4768648c-841b-490d-a752-f31cba545f74@broadcom.com>
 <570C1D47.7010102@gmail.com>
 <ccabf53c-c035-be4b-a016-389bb7531557@broadcom.com>
 <570C24B3.4080104@broadcom.com>
 <18045be8-9ee3-7644-6fbb-d352e107d111@broadcom.com>
Cc: linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
	linux-arm-kernel@lists.infradead.org,
	Hauke Mehrtens <hauke@hauke-m.de>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <570C2806.8070700@gmail.com>
Date: Mon, 11 Apr 2016 15:41:10 -0700
MIME-Version: 1.0
In-Reply-To: <18045be8-9ee3-7644-6fbb-d352e107d111@broadcom.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/04/16 15:34, Ray Jui wrote:
> 
> 
> On 4/11/2016 3:26 PM, Scott Branden wrote:
>> One Comment below
>>
>> On 16-04-11 03:24 PM, Ray Jui wrote:
>>>
>>>
>>> On 4/11/2016 2:55 PM, Florian Fainelli wrote:
>>>> On 11/04/16 13:06, Ray Jui wrote:
>>>>>
>>>>>
>>>>> On 4/10/2016 6:43 PM, Florian Fainelli wrote:
>>>>>> On April 9, 2016 2:50:23 PM PDT, "Rafał Miłecki" <zajec5@gmail.com>
>>>>>> wrote:
>>>>>>> Some devices (e.g. Northstar ones) may have bridges that forward
>>>>>>> harmless errors to the ARM core. In such case we need an option to
>>>>>>> add a handler ignoring them.
>>>>>>>
>>>>>>> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
>>>>>>> ---
>>>>>>
>>>>>>> +- brcm,pcie-hook-abort-handler: During PCI bus probing (device
>>>>>>> enumeration)
>>>>>>> +  there can be errors that are expected and harmless. Unfortunately
>>>>>>> some bridges
>>>>>>> +  can't be configured to ignore them and they forward them to the
>>>>>>> ARM
>>>>>>> core
>>>>>>> +  triggering die().
>>>>>>> +  This property should be set in such case, it will make driver add
>>>>>>> its own
>>>>>>> +  handler ignoring such errors.
>>>>>>
>>>>>> The property is named after the function that allows you to catch
>>>>>> abort handlers, whereas you should be describing the HW here.
>>>>>> Something like brcm,bridge-error-forward or a better name even would
>>>>>> be preferable.
>>>>>>
>>>>>>> +#ifdef CONFIG_ARM
>>>>>>> +static int iproc_pcie_abort_handler(unsigned long addr, unsigned
>>>>>>> int
>>>>>>> fsr,
>>>>>>> +                    struct pt_regs *regs)
>>>>>>> +{
>>>>>>> +    if (fsr == 0x1406)
>>>>>>> +        return 0;
>>>>>>> +
>>>>>>> +    return 1;
>>>>>>
>>>>>> As you later noted this prevents this driver from being a module now.
>>>>>> Since the expectation is that either a fixed bootloader or a platform
>>>>>> should enot produce these data aborts, or allow them to be ignored,
>>>>>> why not just put this code back where it belongs in the machine
>>>>>> specific file which kills many birds with the same stone:
>>>>>>
>>>>>
>>>>> I assume the module compile issue can be simply fixed by exporting
>>>>> symbol of "hook_fault_code"?
>>>>
>>>> I do not think it is desireable for this symbol to be exported in the
>>>> first place, also last I looked, this was a one time registration
>>>> thing,
>>>> you cannot undo the hook you installed, but everything can be fixed.
>>>>
>>>
>>> Okay.
>>>
>>>>>
>>>>> I believe ARM64 based NS2 that uses the same iProc PCIe driver might
>>>>> also need something like this (I'm still waiting for Jon Mason to give
>>>>> me some more information on the NS2 errors that he saw, which is
>>>>> likely
>>>>> related to this). I assume there will be something similar to the ARM
>>>>> specific "hook_fault_code" for ARM64, but then ARM64 does not have any
>>>>> "mach" specific directory. Where can this type of hook be installed
>>>>> for
>>>>> ARM64 based platforms if not in the PCIe driver?
>>>>
>>>> OK, that is a fair point, then maybe have a two stage process, where we
>>>> make sure that the part that installs the hook is always available and
>>>> built-into the kernel, but let the iProc PCIe driver remain a module?
>>>>
>>>
>>> I guess we are sort of stuck on this. If "hook_fault_code" is not
>>> supposed to be used by any driver compiled as module like you described,
>>> then yes, I agree, I don't see how we can leave this in the iProc PCIe
>>> driver.
>>>
>> Why does thie PCI driver need to be compiled as module though?  Why
>> can't we limit it to being linked in the kernel?
>>
>> Regards,
>> Scott
> 
> There are minor benefits allowing this driver to be compiled as module,
> although in our use case (Cygnus and NS2), we always compile this driver
> as statically linked in the kernel. I'm not sure if NS/BCMA has any use
> case that requires this driver to be a module.
> 
> In fact, being able to compile this driver as a module and loaded after
> kernel init process is done just helped to confirm this imprecise abort
> issue to be PCIe specific, :)

For the STB platforms for instance, we actually like to have the PCIE RC
driver as a module (not iproc-pcie, still downstream for now) because it
allows us to put the entire set of EPs and RCs into the lowest power
state (L23 + turning off external regulators) without messing with PCI
bus scanning. In general, it seems like a good practice to allow this
since, that helps with distributions not having to ship gigantic kernels
that need this driver built in, and also helps us with development (when
faults are handled).

My suggestion about the PCIe-specific hook fault handler is to do
something like this: introduce a iproc-pcie-fault.c file which is
built-into the kernel if PCIE_IPROC=m || PCIE_IPROC=y and have it
contain a function which is hooked at arch_initcall level for instance,
so before module_init.

Of course, there could be different ways to solve that problem, it just
happens to be one of them.
-- 
Florian
