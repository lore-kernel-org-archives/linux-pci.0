Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5]:37246 "EHLO
	e28smtp05.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755594AbaHHBUw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Aug 2014 21:20:52 -0400
Received: from /spool/local
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Fri, 8 Aug 2014 06:50:50 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id 6182CE0018
	for <linux-pci@vger.kernel.org>; Fri,  8 Aug 2014 06:52:43 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s781LAcS59441366
	for <linux-pci@vger.kernel.org>; Fri, 8 Aug 2014 06:51:10 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s781KluZ015595
	for <linux-pci@vger.kernel.org>; Fri, 8 Aug 2014 06:50:48 +0530
Date: Fri, 8 Aug 2014 09:20:17 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Matthew Minter <matthew_minter@xyratex.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 01/22] Added some infrastructure to allow assigning PCI
 device IRQs at device enable time and removed pci_fixup_irqs as the other
 change obsolites it.
Message-ID: <20140808012017.GA11712@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
 <1407255083-9356-2-git-send-email-matthew_minter@xyratex.com>
 <20140807034338.GA13444@richard>
 <CAFJTrDuzdoOPoQ_rpNsYU+OeE380sY37aQaMSudhu_MVKo352g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFJTrDuzdoOPoQ_rpNsYU+OeE380sY37aQaMSudhu_MVKo352g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 07, 2014 at 12:35:41PM +0100, Matthew Minter wrote:
>Just to confirm, are you saying that:
>
>>+
>>+      pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
>>+      pdev_assign_irq(dev, hbrg->swizzle_irq, hbrg->map_irq);
>>+
>
>Should become:
>
>>+
>>+     pdev_assign_irq(dev, hbrg->swizzle_irq, hbrg->map_irq);
>>+     pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
>>+
>
>So that we read the config byte after running the assignment and fixup?
>
>I had not thought about the case where the fixup changes the
>PCI_INTERRUPT_PIN value.
>It looks to me like you are correct there and this should indeed be fixed.
>I can certainly swap those around for the next patch revision if that
>is what you are suggesting?
>

Yes, pci_read_config_byte() should be called after pdev_assign_irq().

>I will give that a quick test but it sounds like you are correct.

I am willing to know the result, especially in the original one, what pin
value you retrieved from pci_dev.

>
>Many thanks,
>Matthew
>
>On 7 August 2014 04:43, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
>> On Tue, Aug 05, 2014 at 05:11:02PM +0100, matthew_minter@xyratex.com wrote:
>>>From: matthew_minter <matthew_minter@xyratex.com>
>>>
>>>---
>>> drivers/pci/Makefile      | 15 ++-------------
>>> drivers/pci/host-bridge.c |  2 +-
>>> drivers/pci/pci.c         |  6 +++++-
>>> drivers/pci/pci.h         |  1 +
>>> drivers/pci/probe.c       | 12 ------------
>>> drivers/pci/setup-irq.c   | 25 +++++++++----------------
>>> include/linux/pci.h       |  8 ++++----
>>> 7 files changed, 22 insertions(+), 47 deletions(-)
>>>
>>>diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
>>>index e04fe2d..38c4cb0 100644
>>>--- a/drivers/pci/Makefile
>>>+++ b/drivers/pci/Makefile
>>>@@ -4,7 +4,8 @@
>>>
>>> obj-y         += access.o bus.o probe.o host-bridge.o remove.o pci.o \
>>>                       pci-driver.o search.o pci-sysfs.o rom.o setup-res.o \
>>>-                      irq.o vpd.o setup-bus.o vc.o
>>>+                      irq.o vpd.o setup-bus.o vc.o setup-irq.o
>>>+
>>> obj-$(CONFIG_PROC_FS) += proc.o
>>> obj-$(CONFIG_SYSFS) += slot.o
>>>
>>>@@ -31,18 +32,6 @@ obj-$(CONFIG_PCI_ATS) += ats.o
>>> obj-$(CONFIG_PCI_IOV) += iov.o
>>>
>>> #
>>>-# Some architectures use the generic PCI setup functions
>>>-#
>>>-obj-$(CONFIG_ALPHA) += setup-irq.o
>>>-obj-$(CONFIG_ARM) += setup-irq.o
>>>-obj-$(CONFIG_UNICORE32) += setup-irq.o
>>>-obj-$(CONFIG_SUPERH) += setup-irq.o
>>>-obj-$(CONFIG_MIPS) += setup-irq.o
>>>-obj-$(CONFIG_TILE) += setup-irq.o
>>>-obj-$(CONFIG_SPARC_LEON) += setup-irq.o
>>>-obj-$(CONFIG_M68K) += setup-irq.o
>>>-
>>>-#
>>> # ACPI Related PCI FW Functions
>>> # ACPI _DSM provided firmware instance and string name
>>> #
>>>diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
>>>index 0e5f3c9..8ed186f 100644
>>>--- a/drivers/pci/host-bridge.c
>>>+++ b/drivers/pci/host-bridge.c
>>>@@ -16,7 +16,7 @@ static struct pci_bus *find_pci_root_bus(struct pci_bus *bus)
>>>       return bus;
>>> }
>>>
>>>-static struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus)
>>>+struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus)
>>> {
>>>       struct pci_bus *root_bus = find_pci_root_bus(bus);
>>>
>>>diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>index 63a54a3..d51d076 100644
>>>--- a/drivers/pci/pci.c
>>>+++ b/drivers/pci/pci.c
>>>@@ -1197,10 +1197,15 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
>>>       int err;
>>>       u16 cmd;
>>>       u8 pin;
>>>+      struct pci_host_bridge *hbrg = find_pci_host_bridge(dev->bus);
>>>
>>>       err = pci_set_power_state(dev, PCI_D0);
>>>       if (err < 0 && err != -EIO)
>>>               return err;
>>>+
>>>+      pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
>>>+      pdev_assign_irq(dev, hbrg->swizzle_irq, hbrg->map_irq);
>>>+
>>>       err = pcibios_enable_device(dev, bars);
>>>       if (err < 0)
>>>               return err;
>>>@@ -1209,7 +1214,6 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
>>>       if (dev->msi_enabled || dev->msix_enabled)
>>>               return 0;
>>>
>>>-      pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
>>
>> Not sure why you move this up.
>>
>> Before your change, the call flow would be like this:
>>
>> | scan_bus
>> |   + pci_fixup_irqs
>> |      +    pci_dev->irq and PCI_INTERRUPT_PIN assigned with correct number
>> |
>> | pci_enable_device, called from driver
>> |   + do_pci_enable_device, read the pin from pci_dev
>>
>> As my understanding, this ensures the pin read from hardware is fixuped. While
>> after your change, the pci_fixup_irqs is removed and the pin will be assigned
>> in pdev_assign_irq() after you fix it properly.
>>
>> Do I missed something?
>>
>>>       if (pin) {
>>>               pci_read_config_word(dev, PCI_COMMAND, &cmd);
>>>               if (cmd & PCI_COMMAND_INTX_DISABLE)
>>
>> --
>> Richard Yang
>> Help you, Help me
>>
>
>-- 
>
>
>------------------------------
>For additional information including the registered office and the treatment of Xyratex confidential information please visit www.xyratex.com
>
>------------------------------

-- 
Richard Yang
Help you, Help me

