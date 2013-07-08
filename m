Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:31306 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183Ab3GHFGU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Jul 2013 01:06:20 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Pratyush Anand' <pratyush.anand@st.com>,
	'Mohit KUMAR' <Mohit.KUMAR@st.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	'Kukjin Kim' <kgene.kim@samsung.com>,
	'Arnd Bergmann' <arnd@arndb.de>,
	'Sean Cross' <xobs@kosagi.com>,
	'SRIKANTH TUMKUR SHIVANAND' <ts.srikanth@samsung.com>,
	linux-kernel@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>
References: <000201ce7959$bf0fb150$3d2f13f0$@samsung.com>
 <51D6A370.7060604@st.com>
In-reply-to: <51D6A370.7060604@st.com>
Subject: Re: [PATCH] pci: exynos: split into two parts such as Synopsys part
 and Exynos part
Date: Mon, 08 Jul 2013 14:06:18 +0900
Message-id: <002801ce7b98$e1520f60$a3f62e20$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, July 05, 2013 7:44 PM, Pratyush Anand wrote:
> On 7/5/2013 1:59 PM, Jingoo Han wrote:
> > Exynos PCIe IP consists of Synopsys specific part and Exynos
> > specific part. Only core block is a Synopsys designware part;
> > other parts are Exynos specific.
> > Also, the Synopsys designware part can be shared with other
> > platforms; thus, it can be split two parts such as Synopsys
> > designware part and Exynos specific part.
> >
> 
> A quick and nice job :)
> Just few minor comments.

Thank you.
Without your comment, it could be done. :)

> 
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > Cc: Pratyush Anand <pratyush.anand@st.com>
> > Cc: Mohit KUMAR <Mohit.KUMAR@st.com>
> > ---
> >   drivers/pci/host/Makefile          |    1 +
> >   drivers/pci/host/pcie-designware.c |  907 +++++++-----------------------------
> >   drivers/pci/host/pcie-designware.h |   72 +++
> >   drivers/pci/host/pcie-exynos.c     |  619 ++++++++++++++++++++++++
> >   4 files changed, 862 insertions(+), 737 deletions(-)
> >   create mode 100644 drivers/pci/host/pcie-designware.h
> >   create mode 100644 drivers/pci/host/pcie-exynos.c
> >
> 
> [...]
> 
> 
> > -
> > -struct pcie_port {
> > -       struct device           *dev;
> > -       u8                      controller;
> > -       u8                      root_bus_nr;
> > -       void __iomem            *dbi_base;
> > -       void __iomem            *elbi_base;
> > -       void __iomem            *phy_base;
> > -       void __iomem            *purple_base;
> 
> Just for knowledge, what is the purple_base. It might not be needed by
> all vendors. Can we explain the name in comment or can give some generic
> name?

purple_base is a register to control PCIe block.

For example, controlling various reset control signals, 
PLL lock indication, etc.

Generic name would be 'block_base' or 'misc_base'?


> 
> > -       u64                     cfg0_base;
> > -       void __iomem            *va_cfg0_base;
> > -       u64                     cfg1_base;
> > -       void __iomem            *va_cfg1_base;
> > -       u64                     io_base;
> > -       u64                     mem_base;
> > -       spinlock_t              conf_lock;
> > -       struct resource         cfg;
> > -       struct resource         io;
> > -       struct resource         mem;
> > -       struct pcie_port_info   config;
> > -       struct clk              *clk;
> > -       struct clk              *bus_clk;
> > -       int                     irq;
> > -       int                     reset_gpio;
> > -};
> > -
> 
> [...]
> 
> > -
> > -static inline void readl_rc(struct pcie_port *pp, void *dbi_base, u32 *val)
> > +static inline void dw_pcie_readl_rc(struct pcie_port *pp, void *dbi_base,
> > +                               u32 *val)
> 
> dbi_base is part of pp. So why to pass 3 args?

OK, I see.
I will use 2 args.

Best regards,
Jingoo Han



