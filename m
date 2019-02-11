Return-Path: <SRS0=XN0A=QS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB147C169C4
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 07:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F482084D
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 07:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmZtX/m3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfBKHaL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 02:30:11 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53750 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKHaL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Feb 2019 02:30:11 -0500
Received: by mail-it1-f196.google.com with SMTP id g85so23901029ita.3;
        Sun, 10 Feb 2019 23:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wCcorBFgjKupuXzhGdMDXqWaYLQ04IHxbBHl/8dIdqM=;
        b=UmZtX/m3OkKAzOPo3FkPhxpeesLd/2A1Ut/5AspOOIuIB6TgJFKxUxMfrfnquBzHmm
         zjDkPJ8sLvm5BS90upkZo1Y29pPUjC9Zi24Ddoeg3Esmn/tBPUEwXHNjI+epaE/wNdNv
         0towBTZymnhDyZ7M4zsHGvQzRDv30tgMTmCcQreJmezyS72eDjpD9jo63Z6q2OOfUeET
         gmaQEV6Ac7FFxtx8OayxBoGURVKN35x9G4Qzpz2iGy/3qsx8+If2F/t3EcJMi+GuwmlI
         yf1iJnl/Ht3MrEIohk7/iV5G1AfaDxvcfF0f3ASI4adOxNM2UtkFnHEo9XCEuPDVCbum
         iHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wCcorBFgjKupuXzhGdMDXqWaYLQ04IHxbBHl/8dIdqM=;
        b=i7JhTvSRQQT7B0dT37+Y5q8CsxsdMRid7AdafcPlm43nNObiw93K7iTRUID7aXuztf
         1KoCKqD3xzhRn7rP7VmCUwjcQvWdO3R35PqNOjc0hFFCgGHUgwV7IAwaS24KskjZoIRr
         oKZY77S3AmFMPJgwOR+wjKl8kUr+Ge3l1gc0mTH7cSAgBfKAbU5JvxcYT4rxlQgLxynz
         UcCgNMrqI+VpjzZwJJmJEbHM8HYdpreF15eniqFmRsgGRx84FPaE/jgW8ZE1sfxECXjt
         poYql+luk7Mcx6z9geBk4BpJVrTuZJy+h+VeW5hPWy8xw89SKwmJO1VET3sYN/Bcvcti
         4l/A==
X-Gm-Message-State: AHQUAuZNAtBa1ESl1T5eL7y/adn3AjUYw81ORGTVAsevMLTPU/qA8Lm0
        vUtcpGjMeFo7M2LTjMG4jxnoIYK5PR7XU5obTW0=
X-Google-Smtp-Source: AHgI3IYLAe22iIcag5/qdhwjes6Rfy+20nY09LrWWBS6ficCjpzJDm/5tM6M9V0CaBcNnHf2zOhRuCuXjI6yNo1PtJQ=
X-Received: by 2002:a24:32c2:: with SMTP id j185mr498296ita.33.1549870209636;
 Sun, 10 Feb 2019 23:30:09 -0800 (PST)
MIME-Version: 1.0
References: <1546409810-37630-1-git-send-email-ley.foon.tan@intel.com>
 <1546409810-37630-2-git-send-email-ley.foon.tan@intel.com> <20190208162929.GA21288@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190208162929.GA21288@e107981-ln.cambridge.arm.com>
From:   Ley Foon Tan <lftan.linux@gmail.com>
Date:   Mon, 11 Feb 2019 15:29:58 +0800
Message-ID: <CAFiDJ59EN59onA9SJwLkm8Ww4aBLuXk+HqooUJtEc2fmD6q2Jg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PCI: altera: Add Stratix 10 PCIe support
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Ley Foon Tan <ley.foon.tan@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org,
        linux-pci <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Feb 9, 2019 at 12:29 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> Apologies, I have dropped the ball on this one.
>
> On Wed, Jan 02, 2019 at 02:16:48PM +0800, Ley Foon Tan wrote:
> > Add PCIe Root Port support for Stratix 10 device.
> >
> > Main differences:
> > - HIP interface to access Root Port configuration register.
> > - TLP programming flow:
> >   - One REG0 register
> >   - Don't need to check alignment
> >
> > Signed-off-by: Ley Foon Tan <ley.foon.tan@intel.com>
> > ---
> >  drivers/pci/controller/Kconfig       |    2 +-
> >  drivers/pci/controller/pcie-altera.c |  246 ++++++++++++++++++++++++++++++----
> >  2 files changed, 223 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> > index 6671946..6012f30 100644
> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -175,7 +175,7 @@ config PCIE_IPROC_MSI
> >
> >  config PCIE_ALTERA
> >       bool "Altera PCIe controller"
> > -     depends on ARM || NIOS2 || COMPILE_TEST
> > +     depends on ARM || NIOS2 || ARM64 || COMPILE_TEST
>
> This is an unrelated change and should be a separate patch.
Noted.

>
> >       help
> >         Say Y here if you want to enable PCIe controller support on Altera
> >         FPGA.
> > diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
> > index 7d05e51..4c3b61b 100644
> > --- a/drivers/pci/controller/pcie-altera.c
> > +++ b/drivers/pci/controller/pcie-altera.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/irqchip/chained_irq.h>
> >  #include <linux/init.h>
> >  #include <linux/of_address.h>
> > +#include <linux/of_device.h>
> >  #include <linux/of_irq.h>
> >  #include <linux/of_pci.h>
> >  #include <linux/pci.h>
> > @@ -37,7 +38,12 @@
> >  #define RP_LTSSM_MASK                        0x1f
> >  #define LTSSM_L0                     0xf
> >
> > -#define PCIE_CAP_OFFSET                      0x80
> > +#define S10_RP_TX_CNTRL                      0x2004
> > +#define S10_RP_RXCPL_REG             0x2008
> > +#define S10_RP_RXCPL_STATUS          0x200C
> > +#define S10_RP_CFG_ADDR(pcie, reg)   \
> > +     (((pcie)->hip_base) + (reg) + (1 << 20))
> > +
> >  /* TLP configuration type 0 and 1 */
> >  #define TLP_FMTTYPE_CFGRD0           0x04    /* Configuration Read Type 0 */
> >  #define TLP_FMTTYPE_CFGWR0           0x44    /* Configuration Write Type 0 */
> > @@ -49,18 +55,19 @@
> >  #define RP_DEVFN                     0
> >  #define TLP_REQ_ID(bus, devfn)               (((bus) << 8) | (devfn))
> >  #define TLP_CFGRD_DW0(pcie, bus)                                     \
> > -    ((((bus == pcie->root_bus_nr) ? TLP_FMTTYPE_CFGRD0                       \
> > -                                 : TLP_FMTTYPE_CFGRD1) << 24) |      \
> > -     TLP_PAYLOAD_SIZE)
> > +     ((((bus == pcie->root_bus_nr) ? pcie->pcie_data->cfgrd0         \
> > +                             : pcie->pcie_data->cfgrd1) << 24) |     \
> > +                             TLP_PAYLOAD_SIZE)
> >  #define TLP_CFGWR_DW0(pcie, bus)                                     \
> > -    ((((bus == pcie->root_bus_nr) ? TLP_FMTTYPE_CFGWR0                       \
> > -                                 : TLP_FMTTYPE_CFGWR1) << 24) |      \
> > -     TLP_PAYLOAD_SIZE)
> > +     ((((bus == pcie->root_bus_nr) ? pcie->pcie_data->cfgwr0         \
> > +                             : pcie->pcie_data->cfgwr1) << 24) |     \
> > +                             TLP_PAYLOAD_SIZE)
> >  #define TLP_CFG_DW1(pcie, tag, be)   \
> > -    (((TLP_REQ_ID(pcie->root_bus_nr,  RP_DEVFN)) << 16) | (tag << 8) | (be))
> > +     (((TLP_REQ_ID(pcie->root_bus_nr,  RP_DEVFN)) << 16) | (tag << 8) | (be))
> >  #define TLP_CFG_DW2(bus, devfn, offset)      \
> >                               (((bus) << 24) | ((devfn) << 16) | (offset))
> >  #define TLP_COMP_STATUS(s)           (((s) >> 13) & 7)
> > +#define TLP_BYTE_COUNT(s)            (((s) >> 0) & 0xfff)
> >  #define TLP_HDR_SIZE                 3
> >  #define TLP_LOOP                     500
> >
> > @@ -69,14 +76,43 @@
> >
> >  #define DWORD_MASK                   3
> >
> > +#define S10_TLP_FMTTYPE_CFGRD0               0x05
> > +#define S10_TLP_FMTTYPE_CFGRD1               0x04
> > +#define S10_TLP_FMTTYPE_CFGWR0               0x45
> > +#define S10_TLP_FMTTYPE_CFGWR1               0x44
> > +
> > +enum altera_pcie_version {
> > +     ALTERA_PCIE_V1 = 0,
> > +     ALTERA_PCIE_V2,
> > +};
> > +
> >  struct altera_pcie {
> >       struct platform_device  *pdev;
> > -     void __iomem            *cra_base;      /* DT Cra */
> > +     void __iomem            *cra_base;
> > +     void __iomem            *hip_base;
> >       int                     irq;
> >       u8                      root_bus_nr;
> >       struct irq_domain       *irq_domain;
> >       struct resource         bus_range;
> >       struct list_head        resources;
> > +     const struct altera_pcie_data   *pcie_data;
> > +};
> > +
> > +struct altera_pcie_data {
> > +     int (*tlp_read_pkt)(struct altera_pcie *pcie, u32 *value);
> > +     void (*tlp_write_pkt)(struct altera_pcie *pcie, u32 *headers,
> > +                           u32 data, bool align);
> > +     bool (*get_link_status)(struct altera_pcie *pcie);
> > +     int (*rp_read_cfg)(struct altera_pcie *pcie, int where,
> > +                        int size, u32 *value);
> > +     int (*rp_write_cfg)(struct altera_pcie *pcie, u8 bus, int where,
> > +                         int size, u32 value);
> > +     enum altera_pcie_version version;
> > +     u32 cap_offset;         /* PCIe capability structure register offset */
> > +     u32 cfgrd0;
> > +     u32 cfgrd1;
> > +     u32 cfgwr0;
> > +     u32 cfgwr1;
> >  };
> >
> >  struct tlp_rp_regpair_t {
> > @@ -101,6 +137,15 @@ static bool altera_pcie_link_up(struct altera_pcie *pcie)
> >       return !!((cra_readl(pcie, RP_LTSSM) & RP_LTSSM_MASK) == LTSSM_L0);
> >  }
> >
> > +static bool s10_altera_pcie_link_up(struct altera_pcie *pcie)
> > +{
> > +     void __iomem *addr = S10_RP_CFG_ADDR(pcie,
> > +                                pcie->pcie_data->cap_offset +
> > +                                PCI_EXP_LNKSTA);
> > +
> > +     return !!(readw(addr) & PCI_EXP_LNKSTA_DLLLA);
> > +}
> > +
> >  /*
> >   * Altera PCIe port uses BAR0 of RC's configuration space as the translation
> >   * from PCI bus to native BUS.  Entire DDR region is mapped into PCIe space
> > @@ -128,12 +173,18 @@ static void tlp_write_tx(struct altera_pcie *pcie,
> >       cra_writel(pcie, tlp_rp_regdata->ctrl, RP_TX_CNTRL);
> >  }
> >
> > +static void s10_tlp_write_tx(struct altera_pcie *pcie, u32 reg0, u32 ctrl)
> > +{
> > +     cra_writel(pcie, reg0, RP_TX_REG0);
> > +     cra_writel(pcie, ctrl, S10_RP_TX_CNTRL);
> > +}
> > +
> >  static bool altera_pcie_valid_device(struct altera_pcie *pcie,
> >                                    struct pci_bus *bus, int dev)
> >  {
> >       /* If there is no link, then there is no device */
> >       if (bus->number != pcie->root_bus_nr) {
> > -             if (!altera_pcie_link_up(pcie))
> > +             if (!pcie->pcie_data->get_link_status(pcie))
> >                       return false;
> >       }
> >
> > @@ -183,6 +234,46 @@ static int tlp_read_packet(struct altera_pcie *pcie, u32 *value)
> >       return PCIBIOS_DEVICE_NOT_FOUND;
> >  }
> >
> > +static int s10_tlp_read_packet(struct altera_pcie *pcie, u32 *value)
> > +{
> > +     int i;
> > +     u32 ctrl;
> > +     u32 comp_status;
> > +     u32 dw[4];
> > +     u32 count = 0;
> > +
> > +     for (i = 0; i < TLP_LOOP; i++) {
> > +             ctrl = cra_readl(pcie, S10_RP_RXCPL_STATUS);
> > +             if (!(ctrl & RP_RXCPL_SOP))
> > +                     continue;
> > +
> > +             /* Read first DW */
> > +             dw[count++] = cra_readl(pcie, S10_RP_RXCPL_REG);
> > +
> > +             /* Poll for EOP */
> > +             for (i = 0; i < TLP_LOOP; i++) {
> > +                     ctrl = cra_readl(pcie, S10_RP_RXCPL_STATUS);
> > +                     dw[count++] = cra_readl(pcie, S10_RP_RXCPL_REG);
> > +                     if (ctrl & RP_RXCPL_EOP) {
> > +                             comp_status = TLP_COMP_STATUS(dw[1]);
> > +                             if (comp_status)
> > +                                     return PCIBIOS_DEVICE_NOT_FOUND;
> > +
> > +                             if (value &&
> > +                                 TLP_BYTE_COUNT(dw[1]) == sizeof(u32) &&
> > +                                 count >= 3)
> > +                                     *value = dw[3];
>
> Can you explain please the logic behind the loop ? In particular how
> count is managed.
Firstly, the loop is polling for SOP (start of packet) bit and it will
start poll for EOP (end of packet) if SOP is received.
The count is number of 32-bit data read from PCIe controller (TLP data).

>
> I am also a bit baffled by why you need to get into this inner loop
> to test the value pointer validity, whose assignment as far as I know is
> the only side effect of this call (ie if value is NULL, what's the point
> of executing this function at all ?).
There are 2 cases of read TLP packets transaction:
(1) Without response data
     - TLP completion header only, check TLP completion status for
success/fail. In this case, "value" is NULL.
(2) With response data
    - TLP completion header + data. Check TLP completion status for
success/fail. If status is success and have response data, then store
the data to "value". Usually, this is for config read.

>
> > +
> > +                             return PCIBIOS_SUCCESSFUL;
> > +                     }
> > +             }
> > +
> > +             udelay(5);
> > +     }
> > +
> > +     return PCIBIOS_DEVICE_NOT_FOUND;
> > +}
> > +
> >  static void tlp_write_packet(struct altera_pcie *pcie, u32 *headers,
> >                            u32 data, bool align)
> >  {
> > @@ -210,6 +301,15 @@ static void tlp_write_packet(struct altera_pcie *pcie, u32 *headers,
> >       tlp_write_tx(pcie, &tlp_rp_regdata);
> >  }
> >
> > +static void s10_tlp_write_packet(struct altera_pcie *pcie, u32 *headers,
> > +                              u32 data, bool dummy)
> > +{
> > +     s10_tlp_write_tx(pcie, headers[0], RP_TX_SOP);
> > +     s10_tlp_write_tx(pcie, headers[1], 0);
> > +     s10_tlp_write_tx(pcie, headers[2], 0);
> > +     s10_tlp_write_tx(pcie, data, RP_TX_EOP);
> > +}
> > +
> >  static int tlp_cfg_dword_read(struct altera_pcie *pcie, u8 bus, u32 devfn,
> >                             int where, u8 byte_en, u32 *value)
> >  {
> > @@ -219,9 +319,9 @@ static int tlp_cfg_dword_read(struct altera_pcie *pcie, u8 bus, u32 devfn,
> >       headers[1] = TLP_CFG_DW1(pcie, TLP_READ_TAG, byte_en);
> >       headers[2] = TLP_CFG_DW2(bus, devfn, where);
> >
> > -     tlp_write_packet(pcie, headers, 0, false);
> > +     pcie->pcie_data->tlp_write_pkt(pcie, headers, 0, false);
> >
> > -     return tlp_read_packet(pcie, value);
> > +     return pcie->pcie_data->tlp_read_pkt(pcie, value);
> >  }
> >
> >  static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus, u32 devfn,
> > @@ -236,11 +336,11 @@ static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus, u32 devfn,
> >
> >       /* check alignment to Qword */
> >       if ((where & 0x7) == 0)
> > -             tlp_write_packet(pcie, headers, value, true);
> > +             pcie->pcie_data->tlp_write_pkt(pcie, headers, value, true);
> >       else
> > -             tlp_write_packet(pcie, headers, value, false);
> > +             pcie->pcie_data->tlp_write_pkt(pcie, headers, value, false);
> >
> > -     ret = tlp_read_packet(pcie, NULL);
> > +     ret = pcie->pcie_data->tlp_read_pkt(pcie, NULL);
> >       if (ret != PCIBIOS_SUCCESSFUL)
> >               return ret;
> >
> > @@ -254,6 +354,53 @@ static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus, u32 devfn,
> >       return PCIBIOS_SUCCESSFUL;
> >  }
> >
> > +static int s10_rp_read_cfg(struct altera_pcie *pcie, int where,
> > +                        int size, u32 *value)
> > +{
> > +     void *addr = S10_RP_CFG_ADDR(pcie, where);
> > +
> > +     switch (size) {
> > +     case 1:
> > +             *value = readb(addr);
> > +             break;
> > +     case 2:
> > +             *value = readw(addr);
> > +             break;
> > +     default:
> > +             *value = readl(addr);
> > +             break;
> > +     }
> > +
> > +     return PCIBIOS_SUCCESSFUL;
> > +}
> > +
> > +static int s10_rp_write_cfg(struct altera_pcie *pcie, u8 bus, int where,
> > +                         int size, u32 value)
> > +{
> > +     void *addr = S10_RP_CFG_ADDR(pcie, where);
> > +
> > +     switch (size) {
> > +     case 1:
> > +             writeb(value, addr);
> > +             break;
> > +     case 2:
> > +             writew(value, addr);
> > +             break;
> > +     default:
> > +             writel(value, addr);
> > +             break;
> > +     }
> > +
> > +     /*
> > +      * Monitor changes to PCI_PRIMARY_BUS register on root port
> > +      * and update local copy of root bus number accordingly.
> > +      */
> > +     if (bus == pcie->root_bus_nr && where == PCI_PRIMARY_BUS)
> > +             pcie->root_bus_nr = (u8)(value);
>
> Mask it, don't cast it. I assume this primary bus tracking thing
> is to issue the right config type transactions.
Yes, will change to mask.

Regards
Ley Foon
