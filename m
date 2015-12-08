Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47164 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932522AbbLHJYA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Dec 2015 04:24:00 -0500
Message-ID: <1449566630.3118.10.camel@pengutronix.de>
Subject: Re: [PATCH v2] PCI: dra7xx: mark dra7xx_pcie_msi irq as
 IRQF_NO_THREAD
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>, tony@atomide.com,
	nsekhar@ti.com, linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Pratyush Anand <pratyush.anand@gmail.com>
Date: Tue, 08 Dec 2015 10:23:50 +0100
In-Reply-To: <20151208033300.GA1255@localhost>
References: <1448027966-21610-1-git-send-email-grygorii.strashko@ti.com>
	 <20151204184619.GD20125@localhost> <5662042A.3090809@ti.com>
	 <20151208033300.GA1255@localhost>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Am Montag, den 07.12.2015, 21:33 -0600 schrieb Bjorn Helgaas:
> [+cc Jingoo (exynos), Richard, Lucas (imx6), Pratyush (spear13xx)]
> 
> On Fri, Dec 04, 2015 at 11:22:50PM +0200, Grygorii Strashko wrote:
> > On 12/04/2015 08:46 PM, Bjorn Helgaas wrote:
> > > Hi Grygorii,
[...]
> > >>   
> > >> +	/*
> > >> +	 * Mark dra7xx_pcie_msi IRQ as IRQF_NO_THREAD
> > >> +	 * On -RT and if kernel is booting with "threadirqs" cmd line parameter
> > >> +	 * the dra7xx_pcie_msi_irq_handler() will be forced threaded but,
> > >> +	 * in the same time, it's IRQ dispatcher and calls generic_handle_irq(),
> > >> +	 * which, in turn, will be resolved to handle_simple_irq() call.
> > >> +	 * The handle_simple_irq() expected to be called with IRQ disabled, as
> > >> +	 * result kernle will display warning:
> > >> +	 * "irq XXX handler YYY+0x0/0x14 enabled interrupts".
> > >> +	 */
> > >>   	ret = devm_request_irq(&pdev->dev, pp->irq,
> > >> -			       dra7xx_pcie_msi_irq_handler, IRQF_SHARED,
> > >> +			       dra7xx_pcie_msi_irq_handler,
> > >> +			       IRQF_SHARED | IRQF_NO_THREAD,
> > >>   			       "dra7-pcie-msi",	pp);
> > > 
> > > There's similar code in exynos_add_pcie_port(), imx6_add_pcie_port(),
> > > and spear13xx_add_pcie_port().  Do they need similar changes?  If not,
> > > why not?
> > > 
> > > I see your discussion about DRA7 hardware design, but my impression is
> > > that this problem affects anybody who calls dw_handle_msi_irq() from a
> > > handler registered with IRQF_SHARED.
> > 
> > Issue fixed by this patch is not related to IRQF_SHARED. 
> > It will happen on -RT or if kernel will boot with "threadirqs" cmd line parameter
> > - in both cases these PCI IRQ handlers will be forced to be threaded and,
> > as result, generic_handle_irq() will produce above backtrace.
> > 
> > Personally, I don't have strong opinion about "should similar change be applied
> > to other PCI drivers or not?" And I think, that owners of those driver should
> > make such decision.
> 
> If the same issue affects several drivers, I'd like to see them all
> handle it the same way.  Otherwise, somebody coming along later will
> wonder why they're different, and there won't be a good answer.
> 
> I cc'd the other maintainers to see what they think.
> 
Yes, this should absolutely be changed in all drivers, based on the DW
core. There were some patches for this already, but apparently they have
not been applied, because some review feedback wasn't taken care of.

I have a patch titled "PCI: designware: Mark the msi cascade handler
IRQF_NO_THREAD" in my inbox that did this, and I still think it's the
right thing to do.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

