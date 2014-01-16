Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:55056 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbaAPRc7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jan 2014 12:32:59 -0500
Received: by mail-ie0-f177.google.com with SMTP id at1so1073241iec.8
        for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2014 09:32:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1401141336020.1310-100000@iolanthe.rowland.org>
References: <20140114181721.GC12126@xanatos> <Pine.LNX.4.44L0.1401141336020.1310-100000@iolanthe.rowland.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 16 Jan 2014 10:32:37 -0700
Message-ID: <CAErSpo6v-QLkthigN3HdLizCa_7QxOS+dZ61Fse2jz5KJRdh0Q@mail.gmail.com>
Subject: Re: EHCI host broken -- interrupts disabled
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	USB list <linux-usb@vger.kernel.org>,
	"Chen, Jamie" <jamie.chen@intel.com>,
	"Tsai, Gaggery" <gaggery.tsai@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci]

On Tue, Jan 14, 2014 at 11:47 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Tue, 14 Jan 2014, Sarah Sharp wrote:
>
>> Hi Alan,
>
> I'm not a good person to ask about this.  Maybe Bjorn can help.
>
>> All this info is second- or third-hand, so please excuse the extremely
>> vague bug report.
>>
>> A new Intel Atom system (Baytrail) comes with both an xHCI host and an
>> EHCI host, but the BIOS has an "EHCI only" option that hides the xHCI
>> host PCI device from the operating system.  It appears that when the
>> BIOS is in this mode, the EHCI PCI interrupt is disabled, and the host
>> simply doesn't work.
>>
>> Jamie and Gaggery have more details about the system and the exact
>> failure mode.  They can provide dmesg as well as a PCI register space
>> dump, if necessary.  (Jamie and Gaggery, please note, a publicly
>> archived mailing list is Cc'ed.)
>>
>> A customer reports that the following patch fixes the issue:
>>
>> diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
>> index 3e86bf4371b3..e77566a021ec 100644
>> --- a/drivers/usb/host/ehci-pci.c
>> +++ b/drivers/usb/host/ehci-pci.c
>> @@ -112,6 +112,9 @@ static int ehci_pci_setup(struct usb_hcd *hcd)
>>       case PCI_VENDOR_ID_INTEL:
>>               if (pdev->device == PCI_DEVICE_ID_INTEL_CE4100_USB)
>>                       hcd->has_tt = 1;
>> +             /* Baytrail BIOS in EHCI only mode fails to enable interrupts */
>> +             if (pdev->device == 0x0f34)
>> +                     pci_intx(pdev, 1);
>>               break;
>>       case PCI_VENDOR_ID_TDI:
>>               if (pdev->device == PCI_DEVICE_ID_TDI_EHCI)
>>
>> I looked through the USB PCI initialization code, and I can't find any
>> place where interrupts are enabled, so I assume the PCI core is supposed
>> to enable interrupts?  Or is it assumed that the system boots with all
>> PCI device interrupts enabled?  In that case, is it a BIOS issue?
>
> As I recall, the original PCI spec did not include any way to enable or
> disable interrupts -- a rather surprising omission.  It was added
> later on.
>
> Anyhow, this is all handled in the PCI core.  The device driver
> shouldn't need to do much more than pci_enable_device() (which handles
> power plus I/O and memory resources) and pci_set_master() (which
> handles DMA).  Nothing about enabling interrupt generation.
>
> A quick search did not show any place where the PCI core explicitly
> enables interrupts on new devices, so maybe it does assume that the
> firmware always enables them.  I don't know what guarantees (if any) a
> BIOS is supposed to fulfill.
>
> It seems like the best place to fix this is probably in the PCI core.

I think dev->irq is supposed to be valid after pci_enable_device(), so
it seems like it would make sense to clear PCI_COMMAND_INTX_DISABLE
there.

I don't know why a BIOS would leave PCI_COMMAND_INTX_DISABLE set for
the EHCI device.  Does it support MSI, and the BIOS assumes the OS
should use that?  I don't see any MSI support in the EHCI code.  In
any case, this doesn't seem like something we need to depend on the
BIOS to do for us.

Bjorn
