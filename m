Return-Path: <SRS0=ZQO4=QM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA23BC282CB
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 17:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E732081B
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 17:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbfBERnZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Feb 2019 12:43:25 -0500
Received: from foss.arm.com ([217.140.101.70]:44368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbfBERnZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Feb 2019 12:43:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35961EBD;
        Tue,  5 Feb 2019 09:43:24 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 888A93F557;
        Tue,  5 Feb 2019 09:43:21 -0800 (PST)
Date:   Tue, 5 Feb 2019 17:43:16 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Cc:     "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv3 01/27] PCI: mobiveil: uniform the register accessors
Message-ID: <20190205174316.GA12956@e107981-ln.cambridge.arm.com>
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
 <20190129080926.36773-2-Zhiqiang.Hou@nxp.com>
 <CAFZiPx0wA5=juO0PnuMKY_mJSPD12W09Vy+buW_EyQAKzZkjKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFZiPx0wA5=juO0PnuMKY_mJSPD12W09Vy+buW_EyQAKzZkjKw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 05, 2019 at 11:09:19AM +0530, Subrahmanya Lingappa wrote:
> Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>

I have a feeling you do not read what I write. Please never top-post.

Read this, especially the email etiquette section:

https://kernelnewbies.org/PatchCulture

> 
> 
> 
> On Tue, Jan 29, 2019 at 1:38 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
> >
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >
> > It's confused that R/W some registers by csr_readl()/csr_writel(),
> > while others by read_paged_register()/write_paged_register().
> > Actually the low 3KB of 4KB PCIe configure space can be accessed
> > directly and high 1KB is paging area. So this patch uniformed the
> > register accessors to csr_readl() and csr_writel() by comparing
> > the register offset with page access boundary 3KB in the accessor
> > internal.
> >
> > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> > ---
> > V3:
> >  - No change
> >
> >  drivers/pci/controller/pcie-mobiveil.c | 179 +++++++++++++++++--------
> >  1 file changed, 124 insertions(+), 55 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> > index 77052a0712d0..d55c7e780c6e 100644
> > --- a/drivers/pci/controller/pcie-mobiveil.c
> > +++ b/drivers/pci/controller/pcie-mobiveil.c
> > @@ -47,7 +47,6 @@
> >  #define  PAGE_SEL_SHIFT        13
> >  #define  PAGE_SEL_MASK         0x3f
> >  #define  PAGE_LO_MASK          0x3ff
> > -#define  PAGE_SEL_EN           0xc00
> >  #define  PAGE_SEL_OFFSET_SHIFT 10
> >
> >  #define PAB_AXI_PIO_CTRL       0x0840
> > @@ -117,6 +116,12 @@
> >  #define LINK_WAIT_MIN  90000
> >  #define LINK_WAIT_MAX  100000
> >
> > +#define PAGED_ADDR_BNDRY                       0xc00
> > +#define OFFSET_TO_PAGE_ADDR(off)               \
> > +       ((off & PAGE_LO_MASK) | PAGED_ADDR_BNDRY)
> > +#define OFFSET_TO_PAGE_IDX(off)                        \
> > +       ((off >> PAGE_SEL_OFFSET_SHIFT) & PAGE_SEL_MASK)
> > +
> >  struct mobiveil_msi {                  /* MSI information */
> >         struct mutex lock;              /* protect bitmap variable */
> >         struct irq_domain *msi_domain;
> > @@ -145,15 +150,119 @@ struct mobiveil_pcie {
> >         struct mobiveil_msi msi;
> >  };
> >
> > -static inline void csr_writel(struct mobiveil_pcie *pcie, const u32 value,
> > -               const u32 reg)
> > +/*
> > + * mobiveil_pcie_sel_page - routine to access paged register
> > + *
> > + * Registers whose address greater than PAGED_ADDR_BNDRY (0xc00) are paged,
> > + * for this scheme to work extracted higher 6 bits of the offset will be
> > + * written to pg_sel field of PAB_CTRL register and rest of the lower 10
> > + * bits enabled with PAGED_ADDR_BNDRY are used as offset of the register.
> > + */
> > +static void mobiveil_pcie_sel_page(struct mobiveil_pcie *pcie, u8 pg_idx)
> >  {
> > -       writel_relaxed(value, pcie->csr_axi_slave_base + reg);
> > +       u32 val;
> > +
> > +       val = readl(pcie->csr_axi_slave_base + PAB_CTRL);
> > +       val &= ~(PAGE_SEL_MASK << PAGE_SEL_SHIFT);
> > +       val |= (pg_idx & PAGE_SEL_MASK) << PAGE_SEL_SHIFT;
> > +
> > +       writel(val, pcie->csr_axi_slave_base + PAB_CTRL);
> >  }
> >
> > -static inline u32 csr_readl(struct mobiveil_pcie *pcie, const u32 reg)
> > +static void *mobiveil_pcie_comp_addr(struct mobiveil_pcie *pcie, u32 off)
> >  {
> > -       return readl_relaxed(pcie->csr_axi_slave_base + reg);
> > +       if (off < PAGED_ADDR_BNDRY) {
> > +               /* For directly accessed registers, clear the pg_sel field */
> > +               mobiveil_pcie_sel_page(pcie, 0);
> > +               return pcie->csr_axi_slave_base + off;
> > +       }
> > +
> > +       mobiveil_pcie_sel_page(pcie, OFFSET_TO_PAGE_IDX(off));
> > +       return pcie->csr_axi_slave_base + OFFSET_TO_PAGE_ADDR(off);
> > +}
> > +
> > +static int mobiveil_pcie_read(void __iomem *addr, int size, u32 *val)
> > +{
> > +       if ((uintptr_t)addr & (size - 1)) {
> > +               *val = 0;
> > +               return PCIBIOS_BAD_REGISTER_NUMBER;
> > +       }
> > +
> > +       switch (size) {
> > +       case 4:
> > +               *val = readl(addr);
> > +               break;
> > +       case 2:
> > +               *val = readw(addr);
> > +               break;
> > +       case 1:
> > +               *val = readb(addr);
> > +               break;
> > +       default:
> > +               *val = 0;
> > +               return PCIBIOS_BAD_REGISTER_NUMBER;
> > +       }
> > +
> > +       return PCIBIOS_SUCCESSFUL;
> > +}
> > +
> > +static int mobiveil_pcie_write(void __iomem *addr, int size, u32 val)
> > +{
> > +       if ((uintptr_t)addr & (size - 1))
> > +               return PCIBIOS_BAD_REGISTER_NUMBER;
> > +
> > +       switch (size) {
> > +       case 4:
> > +               writel(val, addr);
> > +               break;
> > +       case 2:
> > +               writew(val, addr);
> > +               break;
> > +       case 1:
> > +               writeb(val, addr);
> > +               break;
> > +       default:
> > +               return PCIBIOS_BAD_REGISTER_NUMBER;
> > +       }
> > +
> > +       return PCIBIOS_SUCCESSFUL;
> > +}
> > +
> > +static u32 csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)
> > +{
> > +       void *addr;
> > +       u32 val;
> > +       int ret;
> > +
> > +       addr = mobiveil_pcie_comp_addr(pcie, off);
> > +
> > +       ret = mobiveil_pcie_read(addr, size, &val);
> > +       if (ret)
> > +               dev_err(&pcie->pdev->dev, "read CSR address failed\n");
> > +
> > +       return val;
> > +}
> > +
> > +static void csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off, size_t size)
> > +{
> > +       void *addr;
> > +       int ret;
> > +
> > +       addr = mobiveil_pcie_comp_addr(pcie, off);
> > +
> > +       ret = mobiveil_pcie_write(addr, size, val);
> > +       if (ret)
> > +               dev_err(&pcie->pdev->dev, "write CSR address failed\n");
> > +}
> > +
> > +static u32 csr_readl(struct mobiveil_pcie *pcie, u32 off)
> > +{
> > +       return csr_read(pcie, off, 0x4);
> > +}
> > +
> > +static void csr_writel(struct mobiveil_pcie *pcie, u32 val, u32 off)
> > +{
> > +       csr_write(pcie, val, off, 0x4);
> >  }
> >
> >  static bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie)
> > @@ -342,45 +451,6 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
> >         return 0;
> >  }
> >
> > -/*
> > - * select_paged_register - routine to access paged register of root complex
> > - *
> > - * registers of RC are paged, for this scheme to work
> > - * extracted higher 6 bits of the offset will be written to pg_sel
> > - * field of PAB_CTRL register and rest of the lower 10 bits enabled with
> > - * PAGE_SEL_EN are used as offset of the register.
> > - */
> > -static void select_paged_register(struct mobiveil_pcie *pcie, u32 offset)
> > -{
> > -       int pab_ctrl_dw, pg_sel;
> > -
> > -       /* clear pg_sel field */
> > -       pab_ctrl_dw = csr_readl(pcie, PAB_CTRL);
> > -       pab_ctrl_dw = (pab_ctrl_dw & ~(PAGE_SEL_MASK << PAGE_SEL_SHIFT));
> > -
> > -       /* set pg_sel field */
> > -       pg_sel = (offset >> PAGE_SEL_OFFSET_SHIFT) & PAGE_SEL_MASK;
> > -       pab_ctrl_dw |= ((pg_sel << PAGE_SEL_SHIFT));
> > -       csr_writel(pcie, pab_ctrl_dw, PAB_CTRL);
> > -}
> > -
> > -static void write_paged_register(struct mobiveil_pcie *pcie,
> > -               u32 val, u32 offset)
> > -{
> > -       u32 off = (offset & PAGE_LO_MASK) | PAGE_SEL_EN;
> > -
> > -       select_paged_register(pcie, offset);
> > -       csr_writel(pcie, val, off);
> > -}
> > -
> > -static u32 read_paged_register(struct mobiveil_pcie *pcie, u32 offset)
> > -{
> > -       u32 off = (offset & PAGE_LO_MASK) | PAGE_SEL_EN;
> > -
> > -       select_paged_register(pcie, offset);
> > -       return csr_readl(pcie, off);
> > -}
> > -
> >  static void program_ib_windows(struct mobiveil_pcie *pcie, int win_num,
> >                 int pci_addr, u32 type, u64 size)
> >  {
> > @@ -397,19 +467,19 @@ static void program_ib_windows(struct mobiveil_pcie *pcie, int win_num,
> >         pio_ctrl_val = csr_readl(pcie, PAB_PEX_PIO_CTRL);
> >         csr_writel(pcie,
> >                 pio_ctrl_val | (1 << PIO_ENABLE_SHIFT), PAB_PEX_PIO_CTRL);
> > -       amap_ctrl_dw = read_paged_register(pcie, PAB_PEX_AMAP_CTRL(win_num));
> > +       amap_ctrl_dw = csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
> >         amap_ctrl_dw = (amap_ctrl_dw | (type << AMAP_CTRL_TYPE_SHIFT));
> >         amap_ctrl_dw = (amap_ctrl_dw | (1 << AMAP_CTRL_EN_SHIFT));
> >
> > -       write_paged_register(pcie, amap_ctrl_dw | lower_32_bits(size64),
> > -                               PAB_PEX_AMAP_CTRL(win_num));
> > +       csr_writel(pcie, amap_ctrl_dw | lower_32_bits(size64),
> > +                  PAB_PEX_AMAP_CTRL(win_num));
> >
> > -       write_paged_register(pcie, upper_32_bits(size64),
> > -                               PAB_EXT_PEX_AMAP_SIZEN(win_num));
> > +       csr_writel(pcie, upper_32_bits(size64),
> > +                  PAB_EXT_PEX_AMAP_SIZEN(win_num));
> >
> > -       write_paged_register(pcie, pci_addr, PAB_PEX_AMAP_AXI_WIN(win_num));
> > -       write_paged_register(pcie, pci_addr, PAB_PEX_AMAP_PEX_WIN_L(win_num));
> > -       write_paged_register(pcie, 0, PAB_PEX_AMAP_PEX_WIN_H(win_num));
> > +       csr_writel(pcie, pci_addr, PAB_PEX_AMAP_AXI_WIN(win_num));
> > +       csr_writel(pcie, pci_addr, PAB_PEX_AMAP_PEX_WIN_L(win_num));
> > +       csr_writel(pcie, 0, PAB_PEX_AMAP_PEX_WIN_H(win_num));
> >  }
> >
> >  /*
> > @@ -437,8 +507,7 @@ static void program_ob_windows(struct mobiveil_pcie *pcie, int win_num,
> >         csr_writel(pcie, 1 << WIN_ENABLE_SHIFT | type << WIN_TYPE_SHIFT |
> >                         lower_32_bits(size64), PAB_AXI_AMAP_CTRL(win_num));
> >
> > -       write_paged_register(pcie, upper_32_bits(size64),
> > -                               PAB_EXT_AXI_AMAP_SIZE(win_num));
> > +       csr_writel(pcie, upper_32_bits(size64), PAB_EXT_AXI_AMAP_SIZE(win_num));
> >
> >         /*
> >          * program AXI window base with appropriate value in
> > --
> > 2.17.1
> >
