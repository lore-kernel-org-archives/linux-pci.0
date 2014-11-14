Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45657 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754830AbaKNKCX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 14 Nov 2014 05:02:23 -0500
Message-ID: <1415959338.4445.1.camel@pengutronix.de>
Subject: Re: [PATCH v2] PCI: designware: Add support 4 ATUs assignment
From: Lucas Stach <l.stach@pengutronix.de>
To: Lian Minghuan-B31939 <B31939@freescale.com>
Cc: Srikanth Thokala <sriku.linux@gmail.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 14 Nov 2014 11:02:18 +0100
In-Reply-To: <5465C19D.3060801@freescale.com>
References: <1415682444-24911-1-git-send-email-Minghuan.Lian@freescale.com>
	 <CA+mB=1+4Dzxhbin6z0PUENvjUz-y8bq-K09FXTnSepFvVfe9HQ@mail.gmail.com>
	 <546308DD.40109@freescale.com>
	 <CA+mB=1K=Oyzdb2yfBvPRG9DHi-PFjRPtVS_dY9JMOz6dQog8QQ@mail.gmail.com>
	 <546331E7.5060003@freescale.com>
	 <CA+mB=1KObT9O783SMcvHy8nJGQPnxyKgP332r5bHx-K_D+LhVg@mail.gmail.com>
	 <1415809929.2876.5.camel@pengutronix.de> <546481A3.5050700@freescale.com>
	 <1415874015.2420.5.camel@pengutronix.de> <54648D61.6050704@freescale.com>
	 <1415876988.2420.7.camel@pengutronix.de> <5465C19D.3060801@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Freitag, den 14.11.2014, 16:47 +0800 schrieb Lian Minghuan-B31939:
> Hi Lucas and all,
> 
> On 2014年11月13日 19:09, Lucas Stach wrote:
> > Am Donnerstag, den 13.11.2014, 18:52 +0800 schrieb Lian Minghuan-B31939:
> >> Hi Lucas,
> >>
> >> On 2014年11月13日 18:20, Lucas Stach wrote:
> >>> Am Donnerstag, den 13.11.2014, 18:02 +0800 schrieb Lian Minghuan-B31939:
> >>>> Hi Lucas,
> >>>>
> >>>> Please see my comments inline.
> >>>>
> >>>> Thanks,
> >>>> Minghuan
> >>>>
> >>>> On 2014年11月13日 00:32, Lucas Stach wrote:
> >>>>> Am Mittwoch, den 12.11.2014, 21:53 +0530 schrieb Srikanth Thokala:
> >>>>>> Hi Minghuan,
> >>> [...]
> >>>
> >>>>> Using a smaller type complicates the DT for little to no benefit. I
> >>>>> think it's ok to use u32 here, which is a common standard for integer
> >>>>> values in DT.
> >>>>>
> >>>>> Though this discussion lead me to the question if we even need to have
> >>>>> this property in the DT at all. Isn't this a property that is fixed for
> >>>>> a specific silicon implementation of the DW core? In that case we could
> >>>>> just infer the number of ATUs from the DT compatible, so this should
> >>>>> probably just be added to struct pcie_port and properly initialized by
> >>>>> the SoC glue drivers.
> >>>> [Minghuan]  As far as I know, exynos implements only 2 ATUs, this is why
> >>>> pcie-designware only supports 2 ATU. iMX implements 4 ATUs and LS1021A
> >>>> implements 6 ATUs.
> >>>>
> >>> Right so we don't need an additional property in the DT at all. The
> >>> number of ATUs is fixed for a specific core compatible and can be passed
> >>> in by the respective exynos, imx and ls1021 glue drivers.
> >>>
> >>> You may ask the Keystone and Spear maintainers to get the correct number
> >>> of ATUs for those implementations.
> >>>
> >>> Regards,
> >>> Lucas
> >> [Minghuan] Yes. This a way that specific core driver passes the ATU
> >> number to
> >> pci-designware. But I perfer to adding dts node for the following reasons:
> >> 1. ATU number is hardware attribute, so it can be added to DTS.
> > But it is a duplication of information that can be inferred from the DT
> > compatible alone, which is usually frowned upon.
> >
> > Also in contrast to the num-lanes property I don't see a use-case to
> > reduce the number of used ATUs in a specific system, so num-atus is
> > basically fixed for a specific implementation.
> [Minghuan] 4ATUs provides better support for multiple-function and 
> SR-IOV PCIe devices.
> Can anyone tell me if there is the company will increase ATUs number?
> If yes, we should avoid the following code:
> 
> if (of_device_is_compatible(pcie->dev->of_node, "xxx,r1-pcie"))
>      atu_num = 2;
> 
> if (of_device_is_compatible(pcie->dev->of_node, "xxx,r2-pcie"))
>      atu_num = 4;
> 
The number of ATUs is fixed for a specific implementation. If the number
of ATUs changes in a newer implementation of a SoC then the silicon
implementation of the DW PCIe core changed, so it should get a new
compatible anyway.

Regards,
Lucas 
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

