Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0129.outbound.protection.outlook.com ([65.55.169.129]:26281
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750762AbcCaN0o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 31 Mar 2016 09:26:44 -0400
Message-ID: <1459430795.1998.11.camel@rtd-VirtualBox>
Subject: PCI IRQ issue since 4.2 kernel
From: Rob Groner <rgroner@rtd.com>
To: <linux-pci@vger.kernel.org>
CC: <jiang.liu@linux.intel.com>, <bhelgaas@google.com>,
	<tglx@linutronix.de>
Date: Thu, 31 Mar 2016 09:26:35 -0400
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Greetings,

We became aware of an issue with our Linux drivers when used with a 4.4
kernel.  These drivers had worked previously from 2.6.35 to 4.2 kernels.
The symptoms were that, even though the request_irq() call was
successful, we did not receive any IRQs.  IRQs did arrive on a different
IRQ line, however, and the kernel disabled that line because there was
no handler.

I can elaborate on this more if you'd like.

With Greg K-H's help, I found the commit where this issue first appears.
He told me to email the people listed in the commit and the pci mailing
list.

Is there something different I need to be doing when I request an IRQ
for my PCI device driver?  I checked the 4.2, 4.3, and 4.4 kernel change
logs and did not see anything obvious about the IRQ request process
changing.

Please let me know how to proceed next.

Thank you,

Rob

 -----------------------------------------------------------------------
 rtd@kernel-dev:~/git/kernels/linux$ git bisect good
 991de2e59090e55c65a7f59a049142e3c480f7bd is the first bad commit
 commit 991de2e59090e55c65a7f59a049142e3c480f7bd
 Author: Jiang Liu <jiang.liu@linux.intel.com>
 Date:   Wed Jun 10 16:54:59 2015 +0800
 
     PCI, x86: Implement pcibios_alloc_irq() and pcibios_free_irq()
     
     To support IOAPIC hotplug, we need to allocate PCI IRQ resources on
 demand
     and free them when not used anymore.
     
     Implement pcibios_alloc_irq() and pcibios_free_irq() to dynamically
     allocate and free PCI IRQs.
     
     Remove mp_should_keep_irq(), which is no longer used.
     
     [bhelgaas: changelog]
     Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
     Acked-by: Thomas Gleixner <tglx@linutronix.de>
 
 :040000 040000 765e2d5232d53247ec260b34b51589c3bccb36ae
 f680234a27685e94b1a35ae2a7218f8eafa9071a M    arch
 :040000 040000 d55a682bcde72682e883365e88ad1df6186fd54d
 f82c470a04a6845fcf5e0aa934512c75628f798d M    drivers
 ----------------------------------------------------------------

