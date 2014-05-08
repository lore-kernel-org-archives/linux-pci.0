Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:50234 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257AbaEHJRG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 May 2014 05:17:06 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	'Jason Gunthorpe' <jgunthorpe@obsidianresearch.com>,
	'Marek Vasut' <marex@denx.de>, devicetree@vger.kernel.org,
	balajitk@ti.com, linux-doc@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	'Mohit Kumar' <mohit.kumar@st.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	linux-omap@vger.kernel.org, rogerq@ti.com,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'Thierry Reding' <treding@nvidia.com>
Subject: Re: [PATCH 05/17] pci: host: pcie-dra7xx: add support for pcie-dra7xx controller
Date: Thu, 08 May 2014 11:16:16 +0200
Message-ID: <4266819.iBi1FzBIBZ@wuerfel>
In-Reply-To: <000101cf6a9b$6c96c8d0$45c45a70$%han@samsung.com>
References: <1399383244-14556-1-git-send-email-kishon@ti.com> <5525000.bPgPLB3ZrT@wuerfel> <000101cf6a9b$6c96c8d0$45c45a70$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 08 May 2014 17:56:38 Jingoo Han wrote:
> On Wednesday, May 07, 2014 6:26 PM, Arnd Bergmann wrote:
> > On Wednesday 07 May 2014 14:52:47 Kishon Vijay Abraham I wrote:
> > > On Tuesday 06 May 2014 10:05 PM, Jason Gunthorpe wrote:
> > > > On Tue, May 06, 2014 at 07:03:51PM +0530, Kishon Vijay Abraham I wrote:
> > > >> +Example:
> > > >> +pcie@51000000 {
> > > >> +    compatible = "ti,dra7xx-pcie";
> > > >> +    reg = <0x51002000 0x14c>, <0x51000000 0x2000>;
> > > >> +    reg-names = "ti_conf", "rc_dbics";
> > > >> +    interrupts = <0 232 0x4>, <0 233 0x4>;
> > > >> +    #address-cells = >;
> > > >> +    #size-cells = <2>;
> > > >> +    device_type = "pci";
> > > >> +    ti,device_type = >;
> > > >> +    ranges = <0x00000800 0 0x20001000 0x20001000 0 0x00002000  /* Configuration Space */
> > > >
> > > > Configuration space should not show up in the ranges, please don't
> > > > copy that mistake from other drivers, put it in reg.
> > >
> > > But then it needs pcie-designware.c to be modified and it will be breaking
> > > other platforms no?
> > 
> > I think the pcie-designware driver should be changed to allow either way.
> > Ideally we would deprecate the existing method in a way that for new front-ends
> > it doesn't work, but the old front-ends can still deal with it but also work
> > if you put it into the reg property.
> 
> (+cc Pratyush Anand, Thierry Reding)
> 
> Hi Arnd,
> 
> Thank you for your comment.
> Do you mean the case of Tegra PCIe as below?
> 
> ./arch/arm/boot/dts/tegra20.dts
>         pcie-controller@80003000 {
>                 ...
>                 reg = <0x80003000 0x00000800   /* PADS registers */
>                          0x80003800 0x00000200   /* AFI registers */
>                          0x90000000 0x10000000>; /* configuration space */
>                 ...
>                 ranges = <0x82000000 0 0x80000000 0x80000000 0 0x00001000   /* port 0 registers */
>                         0x82000000 0 0x80001000 0x80001000 0 0x00001000   /* port 1 registers */
>                         0x81000000 0 0          0x82000000 0 0x00010000   /* downstream I/O */
>                         0x82000000 0 0xa0000000 0xa0000000 0 0x08000000   /* non-prefetchable memory */
>                         0xc2000000 0 0xa8000000 0xa8000000 0 0x18000000>; /* prefetchable memory */
>                 ...
> 
> ./drivers/pci/host/pci-tegra.c
>         /* request configuration space, but remap later, on demand */
>         res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cs");
>         ...
>         pcie->cs = devm_request_mem_region(pcie->dev, res->start,
>                                                 resource_size(res), res->name);

Yes, that is how the config space should be handled normally.

	Arnd
