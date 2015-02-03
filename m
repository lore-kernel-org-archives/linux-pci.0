Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:63186 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754689AbbBCLch (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Feb 2015 06:32:37 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andre Przywara <Andre.Przywara@arm.com>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Russell King <linux@arm.linux.org.uk>
Subject: Re: [PATCH] PCI: Fix pcibios_update_irq misuse of irq number
Date: Tue, 03 Feb 2015 12:31:43 +0100
Message-ID: <4324891.mqG6Yyfi6J@wuerfel>
In-Reply-To: <54D0A521.7030405@arm.com>
References: <1422456683-797-1-git-send-email-marc.zyngier@arm.com> <4145359.V8A0ARGtXz@wuerfel> <54D0A521.7030405@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 03 February 2015 10:38:25 Marc Zyngier wrote:
> 
> That's exactly what I thought until Lorenzo reported kvmtool falling
> over because of this write. Obviously, some platforms must actually
> require this (possibly for bridges that are not known by the firmware).

This sounds much like a bug in kvmtool.
 
> Entirely removing that code solves my problem too, but that'd cannot be
> the right solution...

The comment in pdev_fixup_irq() says 

        /* Always tell the device, so the driver knows what is
           the real IRQ to use; the device does not use it. */

which I read to mean that there are drivers that incorrectly use
'pci_read_config_byte(dev, PCI_INTERRUPT_LINE)' as the number
they pass into request_irq, rather than using dev->irq.
However, this means that your patch is actually wrong, because
what the driver cares about is the virtual irq number (which
request_irq expects), not the number relative to some interrupt
controller.

There is another comment in include/linux/pci.h that states
       /*
        * Instead of touching interrupt line and base address registers
        * directly, use the values stored here. They might be different!
        */
       unsigned int    irq;

so apparently this has been a cause for problems in the past,
and drivers that rely on the number are already broken.

I also checked ancient kernel versions from the 2.1 days when the
code was first added. And indeed at the time drivers used to read
the word, but now none of them use the number for anything real,
they were all fixed during linux-2.2 at the latest.

	Arnd
