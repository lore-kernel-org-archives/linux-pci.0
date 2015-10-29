Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:36481 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753388AbbJ2Pxg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2015 11:53:36 -0400
Received: by lbjm5 with SMTP id m5so31703839lbj.3
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2015 08:53:34 -0700 (PDT)
Subject: Re: [PATCH V1 11/11] arm64, pci, acpi: Support for ACPI based PCI
 hostbridge init
To: Sinan Kaya <okaya@codeaurora.org>, bhelgaas@google.com,
	arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
	rjw@rjwysocki.net, hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
 <1445963922-22711-12-git-send-email-tn@semihalf.com>
 <5631180D.2000902@codeaurora.org> <563131B0.9060305@codeaurora.org>
 <56320538.6000905@semihalf.com> <563234E6.4050109@codeaurora.org>
Cc: jiang.liu@linux.intel.com, robert.richter@caviumnetworks.com,
	Narinder.Dhillon@caviumnetworks.com, ddaney@caviumnetworks.com,
	Liviu.Dudau@arm.com, tglx@linutronix.de, wangyijing@huawei.com,
	Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <563240F6.2060209@semihalf.com>
Date: Thu, 29 Oct 2015 16:53:26 +0100
MIME-Version: 1.0
In-Reply-To: <563234E6.4050109@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 29.10.2015 16:01, Sinan Kaya wrote:
>
>
> On 10/29/2015 7:38 AM, Tomasz Nowicki wrote:
>> On 28.10.2015 21:36, Sinan Kaya wrote:
>>> 1. ACPI code is unable to discover the interrupt numbers when objects
>>> are ordered as follows in the ACPI file
>>>
>>> PNP0A08 object
>>> PNP0C0F INTA object
>>> PNP0C0F INTB object
>>> PNP0C0F INTC object
>>> PNP0C0F INTD object
>>>
>>> This gives me invalid link context error.
>>>
>>> pci 0000:00:00.0: PCI INT A: no GSI
>>> pci 0000:01:00.0: Derived GSI for 0000:01:00.0 INT A from 0000:00:00.0
>>> acpi PNP0C0F:00: Invalid link context
>>>
>>> If I order it like this in the ACPI file,
>>>
>>> PNP0C0F INTA object
>>> PNP0C0F INTB object
>>> PNP0C0F INTC object
>>> PNP0C0F INTD object
>>> PNP0A08 object
>>>
>>> then, the legacy interrupt numbers can be discovered properly.
>>
>> Can you show full content of your PNP0C0F and PNP0A08 objects?
>>
>
> ACPI table is considered proprietary. I don't think I can get the legal
> approval in time. I can give you pieces though.
>
> Here is the _PRT
> Device (PCI0) { // PCIe port 0
>      Name(_HID, EISAID("PNP0A08"))    // PCI express
>      Name(_CID, EISAID("PNP0A03"))    // Compatible PCI Root Bridge
> {
>      ....
>      Name(_PRT, Package(){
>          Package(){0x0FFFF, 0, \_SB.LN0A, 0},  // Slot 0, INTA
>          Package(){0x0FFFF, 1, \_SB.LN0B, 0},  // Slot 0, INTB
>          Package(){0x0FFFF, 2, \_SB.LN0C, 0},  // Slot 0, INTC
>          Package(){0x0FFFF, 3, \_SB.LN0D, 0}   // Slot 0, INTD
>      })
> }
>
> Here is the PNP0C0F
>
> Device(LN0A){
>      Name(_HID, EISAID("PNP0C0F")) // PCI interrupt link
>      Name(_UID, 1)
>      Name(_PRS, ResourceTemplate(){
>      Interrupt(ResourceProducer, Level, ActiveHigh, Exclusive, , ,) {0xE8}
>      })
>      Method(_DIS) {}
>      Method(_CRS) { Return (_PRS) }
>      Method(_SRS, 1) {}
> }
>

Can you please apply patch below:

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index fec1c91..fe34415 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -48,10 +48,19 @@ resource_size_t pcibios_align_resource(void *data, 
const struct resource *res,
   */
  int pcibios_enable_device(struct pci_dev *dev, int mask)
  {
+       int ret;
+
         if (pci_has_flag(PCI_PROBE_ONLY))
                 return 0;

-       return pci_enable_resources(dev, mask);
+       ret = pci_enable_resources(dev, mask);
+       if (ret < 0)
+               return ret;
+#ifdef CONFIG_ACPI
+       if (!dev->msi_enabled)
+               return acpi_pci_irq_enable(dev);
+#endif
+       return 0;
  }

  /*
@@ -61,10 +70,6 @@ int pcibios_add_device(struct pci_dev *dev)
  {
         if (acpi_disabled)
                 dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
-#ifdef CONFIG_ACPI
-       else
-               acpi_pci_irq_enable(dev);
-#endif

         return 0;
  }

and let me know if the order still matter?

Regards,
Tomasz
