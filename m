Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47780 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933506AbaKNLmH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 14 Nov 2014 06:42:07 -0500
Message-ID: <1415965321.4445.4.camel@pengutronix.de>
Subject: Re: [PATCH v2] PCI: designware: Add support 4 ATUs assignment
From: Lucas Stach <l.stach@pengutronix.de>
To: "Mingkai.Hu@freescale.com" <Mingkai.Hu@freescale.com>
Cc: "Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Srikanth Thokala <sriku.linux@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Roy Zang <tie-fei.zang@freescale.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Date: Fri, 14 Nov 2014 12:42:01 +0100
In-Reply-To: <ceb189ef55cf44588b212cc44bb19ef5@BN3PR0301MB1249.namprd03.prod.outlook.com>
References: <1415682444-24911-1-git-send-email-Minghuan.Lian@freescale.com>
	 <CA+mB=1+4Dzxhbin6z0PUENvjUz-y8bq-K09FXTnSepFvVfe9HQ@mail.gmail.com>
	 <546308DD.40109@freescale.com>
	 <CA+mB=1K=Oyzdb2yfBvPRG9DHi-PFjRPtVS_dY9JMOz6dQog8QQ@mail.gmail.com>
	 <546331E7.5060003@freescale.com>
	 <CA+mB=1KObT9O783SMcvHy8nJGQPnxyKgP332r5bHx-K_D+LhVg@mail.gmail.com>
	 <1415809929.2876.5.camel@pengutronix.de> <546481A3.5050700@freescale.com>
	 <1415874015.2420.5.camel@pengutronix.de> <54648D61.6050704@freescale.com>
	 <1415876988.2420.7.camel@pengutronix.de> <5465C19D.3060801@freescale.com>
	 <1415959338.4445.1.camel@pengutronix.de>
	 <ceb189ef55cf44588b212cc44bb19ef5@BN3PR0301MB1249.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Freitag, den 14.11.2014, 11:30 +0000 schrieb
Mingkai.Hu@freescale.com:
> 
> 
> > -----Original Message-----
> > From: Lucas Stach [mailto:l.stach@pengutronix.de]
> > Sent: Friday, November 14, 2014 6:02 PM
> > To: Lian Minghuan-B31939
> > Cc: Srikanth Thokala; Lian Minghuan-B31939; linux-pci@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; Zang Roy-R61911; Hu Mingkai-B21284;
> > Bjorn Helgaas
> > Subject: Re: [PATCH v2] PCI: designware: Add support 4 ATUs assignment
> > 
> > Am Freitag, den 14.11.2014, 16:47 +0800 schrieb Lian Minghuan-B31939:
> > > Hi Lucas and all,
> > >
> > > On 2014年11月13日 19:09, Lucas Stach wrote:
> > > > Am Donnerstag, den 13.11.2014, 18:52 +0800 schrieb Lian Minghuan-
> > B31939:
> > > >> Hi Lucas,
> > > >>
> > > >> On 2014年11月13日 18:20, Lucas Stach wrote:
> > > >>> Am Donnerstag, den 13.11.2014, 18:02 +0800 schrieb Lian Minghuan-
> > B31939:
> > > >>>> Hi Lucas,
> > > >>>>
> > > >>>> Please see my comments inline.
> > > >>>>
> > > >>>> Thanks,
> > > >>>> Minghuan
> > > >>>>
> > > >>>> On 2014年11月13日 00:32, Lucas Stach wrote:
> > > >>>>> Am Mittwoch, den 12.11.2014, 21:53 +0530 schrieb Srikanth Thokala:
> > > >>>>>> Hi Minghuan,
> > > >>> [...]
> > > >>>
> > > >>>>> Using a smaller type complicates the DT for little to no
> > > >>>>> benefit. I think it's ok to use u32 here, which is a common
> > > >>>>> standard for integer values in DT.
> > > >>>>>
> > > >>>>> Though this discussion lead me to the question if we even need
> > > >>>>> to have this property in the DT at all. Isn't this a property
> > > >>>>> that is fixed for a specific silicon implementation of the DW
> > > >>>>> core? In that case we could just infer the number of ATUs from
> > > >>>>> the DT compatible, so this should probably just be added to
> > > >>>>> struct pcie_port and properly initialized by the SoC glue drivers.
> > > >>>> [Minghuan]  As far as I know, exynos implements only 2 ATUs, this
> > > >>>> is why pcie-designware only supports 2 ATU. iMX implements 4 ATUs
> > > >>>> and LS1021A implements 6 ATUs.
> > > >>>>
> > > >>> Right so we don't need an additional property in the DT at all.
> > > >>> The number of ATUs is fixed for a specific core compatible and can
> > > >>> be passed in by the respective exynos, imx and ls1021 glue drivers.
> > > >>>
> > > >>> You may ask the Keystone and Spear maintainers to get the correct
> > > >>> number of ATUs for those implementations.
>  > >>>
> > > >>> Regards,
> > > >>> Lucas
> > > >> [Minghuan] Yes. This a way that specific core driver passes the ATU
> > > >> number to pci-designware. But I perfer to adding dts node for the
> > > >> following reasons:
> > > >> 1. ATU number is hardware attribute, so it can be added to DTS.
> > > > But it is a duplication of information that can be inferred from the
> > > > DT compatible alone, which is usually frowned upon.
> > > >
> > > > Also in contrast to the num-lanes property I don't see a use-case to
> > > > reduce the number of used ATUs in a specific system, so num-atus is
> > > > basically fixed for a specific implementation.
> > > [Minghuan] 4ATUs provides better support for multiple-function and
> > > SR-IOV PCIe devices.
> > > Can anyone tell me if there is the company will increase ATUs number?
> > > If yes, we should avoid the following code:
> > >
> > > if (of_device_is_compatible(pcie->dev->of_node, "xxx,r1-pcie"))
> > >      atu_num = 2;
> > >
> > > if (of_device_is_compatible(pcie->dev->of_node, "xxx,r2-pcie"))
> > >      atu_num = 4;
> > >
> > The number of ATUs is fixed for a specific implementation. If the number
> > of ATUs changes in a newer implementation of a SoC then the silicon
> > implementation of the DW PCIe core changed, so it should get a new
> > compatible anyway.
> > 
> 
> If there are multiple platforms to use the same SoC driver, there will be
> multiple cases for different platforms as Minghuan has pointed out.
> 
> For the platform that only has 2 ATUs, ATU0 is used for CFG0 and MEM and
> there will be conflict when MEM and CFG0 are accessed simultaneously which
> has cause the SATA link issue. I think more ATUs will be added in the 
> future design, then one driver maybe need to handle multiple platforms.
> 
> DTS is designed for to describe the hardware property, it's a general way
> to put hardware related property into DTS.
> 
If another platform uses the same driver you should still have a
specific compatible for that platform. Exactly to differentiate those
silicon implementation differences.

If you add 2 more ATUs to the layerscape pcie in a future design it is
not fsl,ls1021a-pcie anymore, but for example fsl,ls1100-pcie. Also you
don't need the code construct as seen above. The number of ATU can be
added to implementation specific data.
Please look at the Tegra PCI driver and especially struct
tegra_pcie_soc_data on how to properly abstract properties that are
defined by a specific silicon implementation of a core.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

