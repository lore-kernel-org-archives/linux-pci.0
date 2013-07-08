Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:25958 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753484Ab3GHGza (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Jul 2013 02:55:30 -0400
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
Date: Mon, 08 Jul 2013 15:55:23 +0900
Message-id: <002d01ce7ba8$1e532250$5af966f0$@samsung.com>
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

[...]

> > -static inline void readl_rc(struct pcie_port *pp, void *dbi_base, u32 *val)
> > +static inline void dw_pcie_readl_rc(struct pcie_port *pp, void *dbi_base,
> > +                               u32 *val)
> 
> dbi_base is part of pp. So why to pass 3 args?

Sorry, this variable does not mean dbi_base;
it means 'dbi_base + offset'.

dw_pcie_{readl/writel}_rc() are called as below:

  dw_pcie_readl_rc(pp, dbi_base + PCIE_PORT_LINK_CONTROL, &val);
  dw_pcie_writel_rc(pp, val, dbi_base + PCIE_PORT_LINK_CONTROL);

Thus, 'dbi_base' can be replaced with 'dbi_addr'.


Best regards,
Jingoo Han


> 
> >   {
> > -       exynos_pcie_sideband_dbi_r_mode(pp, true);
> > -       *val = readl(dbi_base);
> > -       exynos_pcie_sideband_dbi_r_mode(pp, false);
> > -       return;
> > +       if (pp->ops->readl_rc)
> > +               pp->ops->readl_rc(pp, dbi_base, val);
> 
> ditto
> 
> > +       else
> > +               *val = readl(dbi_base);
> >   }
> >
> > -static inline void writel_rc(struct pcie_port *pp, u32 val, void *dbi_base)
> > +static inline void dw_pcie_writel_rc(struct pcie_port *pp, u32 val,
> > +                               void *dbi_base)
> 
> ditto
> 
> >   {
> > -       exynos_pcie_sideband_dbi_w_mode(pp, true);
> > -       writel(val, dbi_base);
> > -       exynos_pcie_sideband_dbi_w_mode(pp, false);
> > -       return;
> > +       if (pp->ops->writel_rc)
> > +               pp->ops->writel_rc(pp, val, dbi_base);
> 
> ditto
> 
> > +       else
> > +               writel(val, dbi_base);
> >   }
> 
> 
> Regards
> Pratyush

