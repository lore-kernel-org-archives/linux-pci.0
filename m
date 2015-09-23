Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:57384 "EHLO
	lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753291AbbIWQqr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2015 12:46:47 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"pratyush.anand@gmail.com" <pratyush.anand@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	Yuanzhichang <yuanzhichang@hisilicon.com>,
	Zhudacai <zhudacai@hisilicon.com>,
	zhangjukuo <zhangjukuo@huawei.com>,
	qiuzhenfa <qiuzhenfa@hisilicon.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
Subject: RE: [PATCH] PCI: Designware: make num-lanes an optional DT property
Date: Wed, 23 Sep 2015 16:46:35 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1622BCD1@lhreml503-mbb>
References: <1441904546-34591-1-git-send-email-gabriele.paoloni@huawei.com>
 <20150918225524.GP25767@google.com>
In-Reply-To: <20150918225524.GP25767@google.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
> Sent: Friday, September 18, 2015 11:55 PM
> To: Gabriele Paoloni
> Cc: jingoohan1@gmail.com; pratyush.anand@gmail.com; linux-
> pci@vger.kernel.org; Wangzhou (B); Yuanzhichang; Zhudacai; zhangjukuo;
> qiuzhenfa; Liguozhu (Kenneth)
> Subject: Re: [PATCH] PCI: Designware: make num-lanes an optional DT
> property
> 
> Hi Gabriele,
> 
> On Fri, Sep 11, 2015 at 01:02:26AM +0800, Gabriele Paoloni wrote:
> > From: gabriele paoloni <gabriele.paoloni@huawei.com>
> >
> > Currently num-lanes is read in dw_pcie_host_init().
> > for A SoC that performs the link-up operation in UEFI num-lanes
> > is not needed in the DTS but it has to be specified to any value;
> > otherwise dw_pcie_host_init will fail.
> > If the link is brought up in BIOS dw_pcie_setup_rc should not
> > be called.
> > This patch rework dw_pcie_host_init() so that, if num-lanes is
> > not specified, it sets pp->lanes = 0. If later on dw_pcie_setup_rc
> > is called and pp->num_lanes is not set to a valid value,
> > dw_pcie_setup_rc will send an error message and return.
> 
> Which systems don't call dw_pcie_setup_rc()?  I don't have time for an
> exhaustive search, but it looks like most or all designware drivers do
> call
> dw_pcie_setup_rc(), so if any left out num-lanes, they would report an
> error.

All of them currently call dw_pcie_setup_rc(), however the call is not needed
if the link-up is done in BIOS. For instance if you look at
exynos_pcie_establish_link(), you see that it will first check if the link is
already up; if so the function will return as the BIOS has already brought
up the link and dw_pcie_setup_rc is not called in this case. Therefore num-lanes
is not mandatory for a platform with link-up setup in BIOS.

> 
> > This patch is a follow-up of
> > http://www.spinics.net/lists/linux-pci/msg44394.html
> >
> > Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> > ---
> >  Documentation/devicetree/bindings/pci/designware-pcie.txt |  3 ++-
> >  drivers/pci/host/pcie-designware.c                        | 10
> ++++++----
> >  2 files changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/designware-
> pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> > index 9f4faa8..0036ab3 100644
> > --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> > +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> > @@ -14,7 +14,6 @@ Required properties:
> >  - interrupt-map-mask and interrupt-map: standard PCI properties
> >  	to define the mapping of the PCIe interface to interrupt
> >  	numbers.
> > -- num-lanes: number of lanes to use
> >  - clocks: Must contain an entry for each entry in clock-names.
> >  	See ../clocks/clock-bindings.txt for details.
> >  - clock-names: Must include the following entries:
> > @@ -22,6 +21,8 @@ Required properties:
> >  	- "pcie_bus"
> >
> >  Optional properties:
> > +- num-lanes: number of lanes to use (this property should be
> specified unless
> > +  the link is brought already up in BIOS)
> >  - reset-gpio: gpio pin number of power good signal
> >  - bus-range: PCI bus numbers covered (it is recommended for new
> devicetrees to
> >    specify this property, to keep backwards compatibility a range of
> 0x00-0xff
> > diff --git a/drivers/pci/host/pcie-designware.c
> b/drivers/pci/host/pcie-designware.c
> > index 52aa6e3..b0b40ed 100644
> > --- a/drivers/pci/host/pcie-designware.c
> > +++ b/drivers/pci/host/pcie-designware.c
> > @@ -482,10 +482,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >  		}
> >  	}
> >
> > -	if (of_property_read_u32(np, "num-lanes", &pp->lanes)) {
> > -		dev_err(pp->dev, "Failed to parse the number of lanes\n");
> > -		return -EINVAL;
> > -	}
> > +	ret = of_property_read_u32(np, "num-lanes", &pp->lanes);
> > +	if (ret)
> > +		pp->lanes = 0;
> >
> >  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> >  		if (!pp->ops->msi_host_init) {
> > @@ -764,6 +763,9 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
> >  	case 8:
> >  		val |= PORT_LINK_MODE_8_LANES;
> >  		break;
> > +	default:
> > +		dev_err(pp->dev, "invalid pp->lanes value\n");
> 
> Maybe print the invalid value here, labelled "num-lanes"?

Agreed, will fix in v2

> 
> Bjorn
> 
> > +		return;
> >  	}
> >  	dw_pcie_writel_rc(pp, val, PCIE_PORT_LINK_CONTROL);
> >
> > --
> > 1.9.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci"
> in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
