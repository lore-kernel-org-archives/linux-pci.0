Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:40779 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755448AbbBCLho (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Feb 2015 06:37:44 -0500
Message-ID: <54D0B2FA.9080600@arm.com>
Date: Tue, 03 Feb 2015 11:37:30 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: "linux-arm-kernel@lists.infradead.org"
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
References: <1422456683-797-1-git-send-email-marc.zyngier@arm.com> <4145359.V8A0ARGtXz@wuerfel> <54D0A521.7030405@arm.com> <4324891.mqG6Yyfi6J@wuerfel>
In-Reply-To: <4324891.mqG6Yyfi6J@wuerfel>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/02/15 11:31, Arnd Bergmann wrote:
> On Tuesday 03 February 2015 10:38:25 Marc Zyngier wrote:
>>
>> That's exactly what I thought until Lorenzo reported kvmtool falling
>> over because of this write. Obviously, some platforms must actually
>> require this (possibly for bridges that are not known by the firmware).
> 
> This sounds much like a bug in kvmtool.

Lorenzo and I just came to a similar conclusion, given that the HW
should never use that information.

>> Entirely removing that code solves my problem too, but that'd cannot be
>> the right solution...
> 
> The comment in pdev_fixup_irq() says 
> 
>         /* Always tell the device, so the driver knows what is
>            the real IRQ to use; the device does not use it. */
> 
> which I read to mean that there are drivers that incorrectly use
> 'pci_read_config_byte(dev, PCI_INTERRUPT_LINE)' as the number
> they pass into request_irq, rather than using dev->irq.
> However, this means that your patch is actually wrong, because
> what the driver cares about is the virtual irq number (which
> request_irq expects), not the number relative to some interrupt
> controller.

Yes, I now realise that. That makes a lot more sense actually, because I
was getting very confused about how the HW should interpret that number.

Side question: In the probe-only case, should we still allow this write
to happen?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
