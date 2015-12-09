Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:33122 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757AbbLIEtf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Dec 2015 23:49:35 -0500
MIME-Version: 1.0
In-Reply-To: <1449566630.3118.10.camel@pengutronix.de>
References: <1448027966-21610-1-git-send-email-grygorii.strashko@ti.com>
	<20151204184619.GD20125@localhost>
	<5662042A.3090809@ti.com>
	<20151208033300.GA1255@localhost>
	<1449566630.3118.10.camel@pengutronix.de>
Date: Wed, 9 Dec 2015 10:19:34 +0530
Message-ID: <CAHM4w1=52JGcO=fHjoxoubnV=NEGM63MhbQUzHQWX8rxoV6jYg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: dra7xx: mark dra7xx_pcie_msi irq as IRQF_NO_THREAD
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>, tony@atomide.com,
	nsekhar@ti.com, linux-omap@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Richard Zhu <Richard.Zhu@freescale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 8, 2015 at 2:53 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Hi Bjorn,
>
> Am Montag, den 07.12.2015, 21:33 -0600 schrieb Bjorn Helgaas:
>> [+cc Jingoo (exynos), Richard, Lucas (imx6), Pratyush (spear13xx)]
>>
>> On Fri, Dec 04, 2015 at 11:22:50PM +0200, Grygorii Strashko wrote:
>> > On 12/04/2015 08:46 PM, Bjorn Helgaas wrote:
>> > > Hi Grygorii,
> [...]
>> > >>
>> > >> +        /*
>> > >> +         * Mark dra7xx_pcie_msi IRQ as IRQF_NO_THREAD
>> > >> +         * On -RT and if kernel is booting with "threadirqs" cmd line parameter
>> > >> +         * the dra7xx_pcie_msi_irq_handler() will be forced threaded but,
>> > >> +         * in the same time, it's IRQ dispatcher and calls generic_handle_irq(),
>> > >> +         * which, in turn, will be resolved to handle_simple_irq() call.
>> > >> +         * The handle_simple_irq() expected to be called with IRQ disabled, as
>> > >> +         * result kernle will display warning:
>> > >> +         * "irq XXX handler YYY+0x0/0x14 enabled interrupts".
>> > >> +         */
>> > >>          ret = devm_request_irq(&pdev->dev, pp->irq,
>> > >> -                               dra7xx_pcie_msi_irq_handler, IRQF_SHARED,
>> > >> +                               dra7xx_pcie_msi_irq_handler,
>> > >> +                               IRQF_SHARED | IRQF_NO_THREAD,
>> > >>                                 "dra7-pcie-msi", pp);
>> > >
>> > > There's similar code in exynos_add_pcie_port(), imx6_add_pcie_port(),
>> > > and spear13xx_add_pcie_port().  Do they need similar changes?  If not,
>> > > why not?
>> > >
>> > > I see your discussion about DRA7 hardware design, but my impression is
>> > > that this problem affects anybody who calls dw_handle_msi_irq() from a
>> > > handler registered with IRQF_SHARED.
>> >
>> > Issue fixed by this patch is not related to IRQF_SHARED.
>> > It will happen on -RT or if kernel will boot with "threadirqs" cmd line parameter
>> > - in both cases these PCI IRQ handlers will be forced to be threaded and,
>> > as result, generic_handle_irq() will produce above backtrace.
>> >
>> > Personally, I don't have strong opinion about "should similar change be applied
>> > to other PCI drivers or not?" And I think, that owners of those driver should
>> > make such decision.
>>
>> If the same issue affects several drivers, I'd like to see them all
>> handle it the same way.  Otherwise, somebody coming along later will
>> wonder why they're different, and there won't be a good answer.
>>
>> I cc'd the other maintainers to see what they think.
>>

I too agree with the change for SPEAr13xx as well.

~Pratyush
