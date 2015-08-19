Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:33283 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbbHSBWj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Aug 2015 21:22:39 -0400
MIME-Version: 1.0
In-Reply-To: <CADhT+wfjYaEefScKNz-R5miA+_Ybm8PTHgG6jDT9ntb9e89twQ@mail.gmail.com>
References: <1439802579-22651-1-git-send-email-lftan@altera.com>
	<1439802579-22651-3-git-send-email-lftan@altera.com>
	<CADhT+wfjYaEefScKNz-R5miA+_Ybm8PTHgG6jDT9ntb9e89twQ@mail.gmail.com>
Date: Wed, 19 Aug 2015 09:22:36 +0800
Message-ID: <CAFiDJ5-_1QAfox_KTGf4mNCdN-fNm9L3jP=xAWmLvn66sYXfqA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] pci:host: Add Altera PCIe host controller driver
From: Ley Foon Tan <lftan@altera.com>
To: Dinh Nguyen <dinh.linux@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	linux-pci@vger.kernel.org,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Linux List <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Kumar Gala <galak@codeaurora.org>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 19, 2015 at 3:11 AM, Dinh Nguyen <dinh.linux@gmail.com> wrote:
>
> On Mon, Aug 17, 2015 at 4:09 AM, Ley Foon Tan <lftan@altera.com> wrote:
> > This patch adds the Altera PCIe host controller driver.
> >
> > Signed-off-by: Ley Foon Tan <lftan@altera.com>
> > ---
> >  drivers/pci/host/Kconfig       |   7 +
> >  drivers/pci/host/Makefile      |   1 +
> >  drivers/pci/host/pcie-altera.c | 543 +++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 551 insertions(+)
> >  create mode 100644 drivers/pci/host/pcie-altera.c
> >
> > diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> > index 675c2d1..4b4754a 100644
> > --- a/drivers/pci/host/Kconfig
> > +++ b/drivers/pci/host/Kconfig
> > @@ -145,4 +145,11 @@ config PCIE_IPROC_BCMA
> >           Say Y here if you want to use the Broadcom iProc PCIe controller
> >           through the BCMA bus interface
> >
>
> <snip>
>
> > +
> > +/* Address translation table entry size */
> > +#define ATT_ENTRY_SIZE         8
> > +
> > +#define DWORD_MASK             3
> > +
> > +struct altera_pcie {
> > +       struct platform_device  *pdev;
> > +       struct resource         *txs;
>
> You have "Txs" documented in the bindings document, you have a pointer
> here, but you've never used it
> anywhre in the code? What is it for?
Good catch. Forgot to remove this txs field here, we no longer require
to keep this in struct.

>
> > +       void __iomem            *cra_base;
> > +       int                     irq;
> > +       u8                      root_bus_nr;
> > +       struct irq_domain               *irq_domain;
> > +       struct resource         bus_range;
> > +       struct list_head                resources;
> > +};
> > +
>
> <snip>
>
> > +
> > +static int tlp_cfg_dword_read(struct altera_pcie *pcie, u8 bus, u32 devfn,
> > +                             int where, u32 *value)
> > +{
> > +       int ret;
> > +       u32 headers[TLP_HDR_SIZE];
> > +
> > +       if (bus == pcie->root_bus_nr)
> > +               headers[0] = TLP_CFG_DW0(TLP_FMTTYPE_CFGRD0);
> > +       else
> > +               headers[0] = TLP_CFG_DW0(TLP_FMTTYPE_CFGRD1);
> > +
> > +       headers[1] = TLP_CFG_DW1(TLP_REQ_ID(pcie->root_bus_nr, devfn),
> > +                                       TLP_READ_TAG);
> > +       headers[2] = TLP_CFG_DW2(bus, devfn, where);
> > +
> > +       tlp_write_packet(pcie, headers, 0);
> > +
> > +       ret = tlp_read_packet(pcie, value);
> > +       if (ret)
> > +               *value = ~0UL;  /* return 0xFFFFFFFF if error */
> > +
> > +       return ret;
> > +}
> > +
> > +static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus, u32 devfn,
> > +                              int where, u32 value)
> > +{
> > +       u32 headers[TLP_HDR_SIZE];
> > +
> > +       if (bus == pcie->root_bus_nr)
> > +               headers[0] = TLP_CFG_DW0(TLP_FMTTYPE_CFGWR0);
> > +       else
> > +               headers[0] = TLP_CFG_DW0(TLP_FMTTYPE_CFGWR1);
> > +
> > +       headers[1] = TLP_CFG_DW1(TLP_REQ_ID(pcie->root_bus_nr, devfn),
> > +                                       TLP_WRITE_TAG);
> > +       headers[2] = TLP_CFG_DW2(bus, devfn, where);
> > +
> > +       tlp_write_packet(pcie, headers, value);
> > +
> > +       tlp_read_packet(pcie, NULL);
>
> You need to check for the error here.
Okay.

>
> > +
> > +       /* Keep an eye out for changes to the root bus number */
> > +       if ((bus == pcie->root_bus_nr) && (where == PCI_PRIMARY_BUS))
> > +               pcie->root_bus_nr = (u8)(value);
> > +
> > +       return PCIBIOS_SUCCESSFUL;
> > +}
> > +
>
> <snip>
>
> > +
> > +static int altera_pcie_parse_dt(struct altera_pcie *pcie)
> > +{
> > +       struct resource *cra;
> > +       struct platform_device *pdev = pcie->pdev;
> > +
> > +       cra = platform_get_resource_byname(pdev, IORESOURCE_MEM, "Cra");
> > +       if (!cra) {
> > +               cra = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cra");
> > +               if (!cra) {
> > +                       dev_err(&pdev->dev,
> > +                               "no cra memory resource defined\n");
> > +                       return -ENODEV;
> > +               }
> > +       }
> > +
>
> What about "Txs"?
We doesn't need to get resource for "Txs" here. We use standard pci
binding with "ranges" dts parameter to map the pci memory region.
Our dts generator still will generate this "Txs" dts parameter,
because it is one of Avalon slave port of PCIe IP.


Regards
Ley Foon
