Return-Path: <SRS0=hk3Y=RB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D422AC43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 07:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D87D2173C
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 07:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QM627r7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfBZHHm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Feb 2019 02:07:42 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46430 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfBZHHl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Feb 2019 02:07:41 -0500
Received: by mail-io1-f65.google.com with SMTP id k21so9656934ior.13;
        Mon, 25 Feb 2019 23:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vgutUn3USCpiM7ZE91/qs/JSiFYUWNv+dmlPn+k9J/M=;
        b=QM627r7xJJlouh6zrgruLQIwds4eKcmriAar6ie0idWkJnB0RiJXQf0LtxZng+0Vm9
         eSl22cUyonKT0oPbov/vi8FLx80sW7S9xXgBB/7GLr3IIxRUKxui2hFG0/Y2tZGpXkIT
         tLNJK7gNrlMU4EJRZD8sGRLUlAbA5p+dyWyGPEmdE4Poqm4PeJbHyJ+nhV/IJhghJroI
         8nEGf3GXKP5pFMEWlOBjRRmrxYywi7zTqOzp2q3pFDoDh+ysxK0wYyVzrm33zHTBJYBL
         sat7q3p5QIzrLYVwmINeoGwa2VL5W5oWnbRETHhhkE3agyD9TN+xdQhOqM69Mpgd6oSX
         fgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vgutUn3USCpiM7ZE91/qs/JSiFYUWNv+dmlPn+k9J/M=;
        b=rYPuJ3+o0/pVzn004XOrS5X0WYalMzyPKtx1gw8FXK/hK7MamHOzVPc9htyjdBdieT
         LwPyPDg2vbBOgQKF1GPazck0SmQcg+6WIzXpTb3G8X1qiDg91mh1MO6PzJutUwpt7Bmw
         lQGZ7fA+o+K2/fdO8RWDtFM2toMcFKRZUBhZ7m6R2kXScpSNg9VOnYPZxF+RMMVdHGt2
         ehdvd6sp3qrPzK4gu4W9X6a9AKgHFBvqqt3TTHZRU428yXrze2lZZLwpAGhwQF56VmqX
         FkDS+WWG05VFeMQLEfMTHOEH3CF3dZtLkx7qCyqPmcRkxAHcM1EaRTY1uWxGeGV+7WmB
         bV9Q==
X-Gm-Message-State: AHQUAuZ0Dc72nil1Xpnos/LNdCSmsD54rK3zG623OokSg7ITiPUhdtXY
        3J/Np7wcOpi/JBNvG05q2lWmPg32i72zZQpfp3PGRG5O
X-Google-Smtp-Source: AHgI3IZTs2HHx6PXmWZBSS9uv6deRWYcUIe0HOT4aKDdiDVWgyOaQwlxWIXj6QakjEHwDKErvys+OibIJ7Vly9WuoeM=
X-Received: by 2002:a6b:b214:: with SMTP id b20mr11593885iof.130.1551164860190;
 Mon, 25 Feb 2019 23:07:40 -0800 (PST)
MIME-Version: 1.0
References: <1550157638-25112-1-git-send-email-ley.foon.tan@intel.com>
 <1550157638-25112-2-git-send-email-ley.foon.tan@intel.com>
 <20190219162313.GB21833@e107981-ln.cambridge.arm.com> <1551087307.2534.16.camel@intel.com>
In-Reply-To: <1551087307.2534.16.camel@intel.com>
From:   Ley Foon Tan <lftan.linux@gmail.com>
Date:   Tue, 26 Feb 2019 15:07:29 +0800
Message-ID: <CAFiDJ59U2eJPhbh9AK_N6v8rtV1XdRZek1e9sdt6BqdOBtR=LA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] PCI: altera: Add Stratix 10 PCIe support
To:     Ley Foon Tan <ley.foon.tan@intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org,
        linux-pci <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 25, 2019 at 5:35 PM Ley Foon Tan <ley.foon.tan@intel.com> wrote:
>
> On Tue, 2019-02-19 at 16:23 +0000, Lorenzo Pieralisi wrote:
> > On Thu, Feb 14, 2019 at 11:20:36PM +0800, Ley Foon Tan wrote:
> > >
> > > Add PCIe Root Port support for Stratix 10 device.
> > >
> > > Main differences:
> > Main differences with what ? We need to rewrite this commit log.
> Differences compare with Cyclone V and Arria 10 devices.
> I will rewrite this.
> >
> > >
> > > - HIP interface to access Root Port configuration register.
> > > - TLP programming flow:
> > >   - One REG0 register
> > >   - Don't need to check alignment
> > >
> > > Signed-off-by: Ley Foon Tan <ley.foon.tan@intel.com>
> > > ---
> > >  drivers/pci/controller/pcie-altera.c |  246
> > > ++++++++++++++++++++++++++++++----
> > >  1 files changed, 222 insertions(+), 24 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/pcie-altera.c
> > > b/drivers/pci/controller/pcie-altera.c
> > > index 7d05e51..76bb6a6 100644
> > > --- a/drivers/pci/controller/pcie-altera.c
> > > +++ b/drivers/pci/controller/pcie-altera.c
> > > @@ -11,6 +11,7 @@
> > >  #include <linux/irqchip/chained_irq.h>
> > >  #include <linux/init.h>
> > >  #include <linux/of_address.h>
> > > +#include <linux/of_device.h>
> > >  #include <linux/of_irq.h>
> > >  #include <linux/of_pci.h>
> > >  #include <linux/pci.h>
> > > @@ -37,7 +38,12 @@
> > >  #define RP_LTSSM_MASK                      0x1f
> > >  #define LTSSM_L0                   0xf
> > >
> > > -#define PCIE_CAP_OFFSET                    0x80
> > > +#define S10_RP_TX_CNTRL                    0x2004
> > > +#define S10_RP_RXCPL_REG           0x2008
> > > +#define S10_RP_RXCPL_STATUS                0x200C
> > > +#define S10_RP_CFG_ADDR(pcie, reg) \
> > > +   (((pcie)->hip_base) + (reg) + (1 << 20))
> > > +
> > >  /* TLP configuration type 0 and 1 */
> > >  #define TLP_FMTTYPE_CFGRD0         0x04    /*
> > > Configuration Read Type 0 */
> > >  #define TLP_FMTTYPE_CFGWR0         0x44    /*
> > > Configuration Write Type 0 */
> > > @@ -49,18 +55,19 @@
> > >  #define RP_DEVFN                   0
> > >  #define TLP_REQ_ID(bus, devfn)             (((bus) << 8) |
> > > (devfn))
> > >  #define TLP_CFGRD_DW0(pcie, bus)
> > > \
> > > -    ((((bus == pcie->root_bus_nr) ? TLP_FMTTYPE_CFGRD0
> > >     \
> > > -                               : TLP_FMTTYPE_CFGRD1) << 24) |
> > >     \
> > > -     TLP_PAYLOAD_SIZE)
> > > +   ((((bus == pcie->root_bus_nr) ? pcie->pcie_data->cfgrd0
> > >     \
> > > +                           : pcie->pcie_data->cfgrd1) << 24)
> > > |   \
> > > +                           TLP_PAYLOAD_SIZE)
> > >  #define TLP_CFGWR_DW0(pcie, bus)
> > > \
> > > -    ((((bus == pcie->root_bus_nr) ? TLP_FMTTYPE_CFGWR0
> > >     \
> > > -                               : TLP_FMTTYPE_CFGWR1) << 24) |
> > >     \
> > > -     TLP_PAYLOAD_SIZE)
> > > +   ((((bus == pcie->root_bus_nr) ? pcie->pcie_data->cfgwr0
> > >     \
> > > +                           : pcie->pcie_data->cfgwr1) << 24)
> > > |   \
> > > +                           TLP_PAYLOAD_SIZE)
> > >  #define TLP_CFG_DW1(pcie, tag, be) \
> > > -    (((TLP_REQ_ID(pcie->root_bus_nr,  RP_DEVFN)) << 16) | (tag <<
> > > 8) | (be))
> > > +   (((TLP_REQ_ID(pcie->root_bus_nr,  RP_DEVFN)) << 16) | (tag
> > > << 8) | (be))
> > >  #define TLP_CFG_DW2(bus, devfn, offset)    \
> > >                             (((bus) << 24) | ((devfn) << 16) |
> > > (offset))
> > >  #define TLP_COMP_STATUS(s)         (((s) >> 13) & 7)
> > > +#define TLP_BYTE_COUNT(s)          (((s) >> 0) & 0xfff)
> > >  #define TLP_HDR_SIZE                       3
> > >  #define TLP_LOOP                   500
> > >
> > > @@ -69,14 +76,43 @@
> > >
> > >  #define DWORD_MASK                 3
> > >
> > > +#define S10_TLP_FMTTYPE_CFGRD0             0x05
> > > +#define S10_TLP_FMTTYPE_CFGRD1             0x04
> > > +#define S10_TLP_FMTTYPE_CFGWR0             0x45
> > > +#define S10_TLP_FMTTYPE_CFGWR1             0x44
> > > +
> > > +enum altera_pcie_version {
> > > +   ALTERA_PCIE_V1 = 0,
> > > +   ALTERA_PCIE_V2,
> > > +};
> > > +
> > >  struct altera_pcie {
> > >     struct platform_device  *pdev;
> > > -   void __iomem            *cra_base;      /* DT Cra */
> > > +   void __iomem            *cra_base;
> > > +   void __iomem            *hip_base;
> > >     int                     irq;
> > >     u8                      root_bus_nr;
> > >     struct irq_domain       *irq_domain;
> > >     struct resource         bus_range;
> > >     struct list_head        resources;
> > > +   const struct altera_pcie_data   *pcie_data;
> > > +};
> > > +
> > > +struct altera_pcie_data {
> > > +   int (*tlp_read_pkt)(struct altera_pcie *pcie, u32 *value);
> > > +   void (*tlp_write_pkt)(struct altera_pcie *pcie, u32
> > > *headers,
> > > +                         u32 data, bool align);
> > > +   bool (*get_link_status)(struct altera_pcie *pcie);
> > > +   int (*rp_read_cfg)(struct altera_pcie *pcie, int where,
> > > +                      int size, u32 *value);
> > > +   int (*rp_write_cfg)(struct altera_pcie *pcie, u8 bus, int
> > > where,
> > > +                       int size, u32 value);
> > > +   enum altera_pcie_version version;
> > > +   u32 cap_offset;         /* PCIe capability
> > > structure register offset */
> > This is a duplication of struct pci_dev.pcie_cap right ?
>
> This is register offset in PCIe Rootport IP to access PCIe Cap
> structure register of directly RP. This allow us to access PCIe cap
> struct register without pci_dev.
>
> >
> > >
> > > +   u32 cfgrd0;
> > > +   u32 cfgrd1;
> > > +   u32 cfgwr0;
> > > +   u32 cfgwr1;
> > >  };
> > >
> > >  struct tlp_rp_regpair_t {
> > > @@ -101,6 +137,15 @@ static bool altera_pcie_link_up(struct
> > > altera_pcie *pcie)
> > >     return !!((cra_readl(pcie, RP_LTSSM) & RP_LTSSM_MASK) ==
> > > LTSSM_L0);
> > >  }
> > >
> > > +static bool s10_altera_pcie_link_up(struct altera_pcie *pcie)
> > > +{
> > > +   void __iomem *addr = S10_RP_CFG_ADDR(pcie,
> > > +                              pcie->pcie_data->cap_offset +
> > > +                              PCI_EXP_LNKSTA);
> > > +
> > > +   return !!(readw(addr) & PCI_EXP_LNKSTA_DLLLA);
> > > +}
> > > +
> > >  /*
> > >   * Altera PCIe port uses BAR0 of RC's configuration space as the
> > > translation
> > >   * from PCI bus to native BUS.  Entire DDR region is mapped into
> > > PCIe space
> > > @@ -128,12 +173,18 @@ static void tlp_write_tx(struct altera_pcie
> > > *pcie,
> > >     cra_writel(pcie, tlp_rp_regdata->ctrl, RP_TX_CNTRL);
> > >  }
> > >
> > > +static void s10_tlp_write_tx(struct altera_pcie *pcie, u32 reg0,
> > > u32 ctrl)
> > > +{
> > > +   cra_writel(pcie, reg0, RP_TX_REG0);
> > > +   cra_writel(pcie, ctrl, S10_RP_TX_CNTRL);
> > > +}
> > > +
> > >  static bool altera_pcie_valid_device(struct altera_pcie *pcie,
> > >                                  struct pci_bus *bus, int dev)
> > >  {
> > >     /* If there is no link, then there is no device */
> > >     if (bus->number != pcie->root_bus_nr) {
> > > -           if (!altera_pcie_link_up(pcie))
> > > +           if (!pcie->pcie_data->get_link_status(pcie))
> > >                     return false;
> > >     }
> > >
> > > @@ -183,6 +234,46 @@ static int tlp_read_packet(struct altera_pcie
> > > *pcie, u32 *value)
> > >     return PCIBIOS_DEVICE_NOT_FOUND;
> > >  }
> > >
> > > +static int s10_tlp_read_packet(struct altera_pcie *pcie, u32
> > > *value)
> > > +{
> > > +   int i;
> > > +   u32 ctrl;
> > > +   u32 comp_status;
> > > +   u32 dw[4];
> > > +   u32 count = 0;
> > > +
> > > +   for (i = 0; i < TLP_LOOP; i++) {
> > > +           ctrl = cra_readl(pcie, S10_RP_RXCPL_STATUS);
> > > +           if (!(ctrl & RP_RXCPL_SOP))
> > > +                   continue;
> > > +
> > > +           /* Read first DW */
> > > +           dw[count++] = cra_readl(pcie, S10_RP_RXCPL_REG);
> > > +
> > > +           /* Poll for EOP */
> > > +           for (i = 0; i < TLP_LOOP; i++) {
> > > +                   ctrl = cra_readl(pcie,
> > > S10_RP_RXCPL_STATUS);
> > > +                   dw[count++] = cra_readl(pcie,
> > > S10_RP_RXCPL_REG);
> > I think you'd better add a check on count lest it can overflow dw[].
> Okay, will check that.
> >
> > >
> > > +                   if (ctrl & RP_RXCPL_EOP) {
> > > +                           comp_status =
> > > TLP_COMP_STATUS(dw[1]);
> > > +                           if (comp_status)
> > > +                                   return
> > > PCIBIOS_DEVICE_NOT_FOUND;
> > > +
> > > +                           if (value &&
> > > +                               TLP_BYTE_COUNT(dw[1]) ==
> > > sizeof(u32) &&
> > > +                               count >= 3)
> > > +                                   *value = dw[3];
> > > +
> > > +                           return PCIBIOS_SUCCESSFUL;
> > > +                   }
> > > +           }
> > > +
> > > +           udelay(5);
> > > +   }
> > > +
> > > +   return PCIBIOS_DEVICE_NOT_FOUND;
> > > +}
> > > +
> > >  static void tlp_write_packet(struct altera_pcie *pcie, u32
> > > *headers,
> > >                          u32 data, bool align)
> > >  {
> > > @@ -210,6 +301,15 @@ static void tlp_write_packet(struct
> > > altera_pcie *pcie, u32 *headers,
> > >     tlp_write_tx(pcie, &tlp_rp_regdata);
> > >  }
> > >
> > > +static void s10_tlp_write_packet(struct altera_pcie *pcie, u32
> > > *headers,
> > > +                            u32 data, bool dummy)
> > > +{
> > > +   s10_tlp_write_tx(pcie, headers[0], RP_TX_SOP);
> > > +   s10_tlp_write_tx(pcie, headers[1], 0);
> > > +   s10_tlp_write_tx(pcie, headers[2], 0);
> > > +   s10_tlp_write_tx(pcie, data, RP_TX_EOP);
> > > +}
> > > +
> > >  static int tlp_cfg_dword_read(struct altera_pcie *pcie, u8 bus,
> > > u32 devfn,
> > >                           int where, u8 byte_en, u32 *value)
> > >  {
> > > @@ -219,9 +319,9 @@ static int tlp_cfg_dword_read(struct
> > > altera_pcie *pcie, u8 bus, u32 devfn,
> > >     headers[1] = TLP_CFG_DW1(pcie, TLP_READ_TAG, byte_en);
> > >     headers[2] = TLP_CFG_DW2(bus, devfn, where);
> > >
> > > -   tlp_write_packet(pcie, headers, 0, false);
> > > +   pcie->pcie_data->tlp_write_pkt(pcie, headers, 0, false);
> > >
> > > -   return tlp_read_packet(pcie, value);
> > > +   return pcie->pcie_data->tlp_read_pkt(pcie, value);
> > >  }
> > >
> > >  static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus,
> > > u32 devfn,
> > > @@ -236,11 +336,11 @@ static int tlp_cfg_dword_write(struct
> > > altera_pcie *pcie, u8 bus, u32 devfn,
> > >
> > >     /* check alignment to Qword */
> > >     if ((where & 0x7) == 0)
> > > -           tlp_write_packet(pcie, headers, value, true);
> > > +           pcie->pcie_data->tlp_write_pkt(pcie, headers,
> > > value, true);
> > >     else
> > > -           tlp_write_packet(pcie, headers, value, false);
> > > +           pcie->pcie_data->tlp_write_pkt(pcie, headers,
> > > value, false);
> > >
> > > -   ret = tlp_read_packet(pcie, NULL);
> > > +   ret = pcie->pcie_data->tlp_read_pkt(pcie, NULL);
> > >     if (ret != PCIBIOS_SUCCESSFUL)
> > >             return ret;
> > >
> > > @@ -254,6 +354,53 @@ static int tlp_cfg_dword_write(struct
> > > altera_pcie *pcie, u8 bus, u32 devfn,
> > >     return PCIBIOS_SUCCESSFUL;
> > >  }
> > >
> > > +static int s10_rp_read_cfg(struct altera_pcie *pcie, int where,
> > > +                      int size, u32 *value)
> > > +{
> > > +   void *addr = S10_RP_CFG_ADDR(pcie, where);
> > > +
> > > +   switch (size) {
> > > +   case 1:
> > > +           *value = readb(addr);
> > > +           break;
> > > +   case 2:
> > > +           *value = readw(addr);
> > > +           break;
> > > +   default:
> > > +           *value = readl(addr);
> > > +           break;
> > > +   }
> > This boilerplace could be avoided if you used generic config
> > accessors (ie pci_generic_config_read()/write()).
> Okay. I will change this.
I just remembered that, we can't use pci_generic_config_read/write()
here because we need access to
Root port PCIe capabilities struct register to retrain PCIe link
before struct pci_bus *bus is available.
pci_generic_config_read/write() function needs struct pci_bus *bus.


Regards
Ley Foon
