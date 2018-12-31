Return-Path: <SRS0=55Kx=PI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F19EC43387
	for <linux-pci@archiver.kernel.org>; Mon, 31 Dec 2018 02:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34C72080D
	for <linux-pci@archiver.kernel.org>; Mon, 31 Dec 2018 02:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbeLaCBM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 30 Dec 2018 21:01:12 -0500
Received: from mga14.intel.com ([192.55.52.115]:62809 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbeLaCBL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 30 Dec 2018 21:01:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Dec 2018 18:01:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,420,1539673200"; 
   d="scan'208";a="131787907"
Received: from lftan-mobl.gar.corp.intel.com (HELO ubuntu) ([10.226.248.241])
  by fmsmga004.fm.intel.com with SMTP; 30 Dec 2018 18:01:05 -0800
Received: by ubuntu (sSMTP sendmail emulation); Mon, 31 Dec 2018 10:01:01 +0800
Message-ID: <1546221660.30618.10.camel@intel.com>
Subject: Re: [PATCH 1/2] pci: altera: Add StratixXX PCIe support
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lftan.linux@gmail.com
Date:   Mon, 31 Dec 2018 10:01:00 +0800
In-Reply-To: <20181229031244.GB159477@google.com>
References: <1545844186-25305-1-git-send-email-ley.foon.tan@intel.com>
         <1545844186-25305-2-git-send-email-ley.foon.tan@intel.com>
         <20181229031244.GB159477@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2018-12-28 at 21:12 -0600, Bjorn Helgaas wrote:
> Run "git log --oneline drivers/pci/controller" and make your subject
> line
> match in style, phrasing, and capitalization.
> 
> On Thu, Dec 27, 2018 at 01:09:45AM +0800, Ley Foon Tan wrote:
> > 
> > Add PCIe rootport support for StratixXX device.
> s/rootport/Root Port/
Noted.
> 
> I don't know what the correct styling of "StratixXX" is.  You also
> have
> "Stratix xx" below.  Both (and the subject line) should probably
> match?
Will change it to Stratix10.
> 
> > 
> > Main differences:
> > - HIP interface
> > - TLP programming flow
> It'd be nice to elaborate on these differences a little bit.
Okay.
> 
> > 
> > Signed-off-by: Ley Foon Tan <ley.foon.tan@intel.com>
> > ---
> >  drivers/pci/controller/Kconfig       |    2 +-
> >  drivers/pci/controller/pcie-altera.c |  228
> > +++++++++++++++++++++++++++++++---
> >  2 files changed, 209 insertions(+), 21 deletions(-)
> >  mode change 100644 => 100755 drivers/pci/controller/Kconfig
> > 
> > diff --git a/drivers/pci/controller/Kconfig
> > b/drivers/pci/controller/Kconfig
> > old mode 100644
> > new mode 100755
> > index 6671946..6012f30
> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -175,7 +175,7 @@ config PCIE_IPROC_MSI
> >  
> >  config PCIE_ALTERA
> >  	bool "Altera PCIe controller"
> > -	depends on ARM || NIOS2 || COMPILE_TEST
> > +	depends on ARM || NIOS2 || ARM64 || COMPILE_TEST
> >  	help
> >  	  Say Y here if you want to enable PCIe controller support
> > on Altera
> >  	  FPGA.
> > diff --git a/drivers/pci/controller/pcie-altera.c
> > b/drivers/pci/controller/pcie-altera.c
> > index 7d05e51..b9d6eb2 100644
> > --- a/drivers/pci/controller/pcie-altera.c
> > +++ b/drivers/pci/controller/pcie-altera.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/irqchip/chained_irq.h>
> >  #include <linux/init.h>
> >  #include <linux/of_address.h>
> > +#include <linux/of_device.h>
> >  #include <linux/of_irq.h>
> >  #include <linux/of_pci.h>
> >  #include <linux/pci.h>
> > @@ -37,7 +38,12 @@
> >  #define RP_LTSSM_MASK			0x1f
> >  #define LTSSM_L0			0xf
> >  
> > -#define PCIE_CAP_OFFSET			0x80
> > +#define SXX_RP_TX_CNTRL			0x2004
> > +#define SXX_RP_RXCPL_REG		0x2008
> > +#define SXX_RP_RXCPL_STATUS		0x200C
> > +#define SXX_RP_CFG_ADDR(pcie, reg)	\
> > +	((pcie->hip_base) + (reg) + (1 << 20))
> > +
> >  /* TLP configuration type 0 and 1 */
> >  #define TLP_FMTTYPE_CFGRD0		0x04	/*
> > Configuration Read Type 0 */
> >  #define TLP_FMTTYPE_CFGWR0		0x44	/*
> > Configuration Write Type 0 */
> > @@ -49,18 +55,19 @@
> >  #define RP_DEVFN			0
> >  #define TLP_REQ_ID(bus, devfn)		(((bus) << 8) |
> > (devfn))
> >  #define TLP_CFGRD_DW0(pcie, bus)					
> > \
> > -    ((((bus == pcie->root_bus_nr) ? TLP_FMTTYPE_CFGRD0		
> > 	\
> > -				    : TLP_FMTTYPE_CFGRD1) << 24) |
> > 	\
> > +    ((((bus == pcie->root_bus_nr) ? pcie->pcie_data->cfgrd0	
> > 	\
> > +				  : pcie->pcie_data->cfgrd1) <<
> > 24) |	\
> >       TLP_PAYLOAD_SIZE)
> >  #define TLP_CFGWR_DW0(pcie, bus)					
> > \
> > -    ((((bus == pcie->root_bus_nr) ? TLP_FMTTYPE_CFGWR0		
> > 	\
> > -				    : TLP_FMTTYPE_CFGWR1) << 24) |
> > 	\
> > +    ((((bus == pcie->root_bus_nr) ? pcie->pcie_data->cfgwr0	
> > 	\
> > +				  : pcie->pcie_data->cfgwr1) <<
> > 24) |	\
> >       TLP_PAYLOAD_SIZE)
> >  #define TLP_CFG_DW1(pcie, tag, be)	\
> >      (((TLP_REQ_ID(pcie->root_bus_nr,  RP_DEVFN)) << 16) | (tag <<
> > 8) | (be))
> >  #define TLP_CFG_DW2(bus, devfn, offset)	\
> >  				(((bus) << 24) | ((devfn) << 16) |
> > (offset))
> >  #define TLP_COMP_STATUS(s)		(((s) >> 13) & 7)
> > +#define TLP_BYTE_COUNT(s)		(((s) >> 0) & 0xfff)
> >  #define TLP_HDR_SIZE			3
> >  #define TLP_LOOP			500
> >  
> > @@ -72,11 +79,30 @@
> >  struct altera_pcie {
> >  	struct platform_device	*pdev;
> >  	void __iomem		*cra_base;	/* DT Cra */
> > +	void __iomem		*hip_base;
> IIRC, the "DT Cra" comment was a hint about what DT property contains
> this data.  It'd be good to use the comment consistently (either
> always or never).
Will remove it.

> 
> > 
> >  	int			irq;
> >  	u8			root_bus_nr;
> >  	struct irq_domain	*irq_domain;
> >  	struct resource		bus_range;
> >  	struct list_head	resources;
> > +	const struct altera_pcie_data	*pcie_data;
> > +};
> > +
> > +struct altera_pcie_data {
> > +	int (*tlp_read_pkt)(struct altera_pcie *pcie, u32 *value);
> > +	void (*tlp_write_pkt)(struct altera_pcie *pcie, u32
> > *headers,
> > +			      u32 data, bool align);
> > +	bool (*get_link_status)(struct altera_pcie *pcie);
> > +	int (*rp_read_cfg)(struct altera_pcie *pcie, int where,
> > +			      int size, u32 *value);
> > +	int (*rp_write_cfg)(struct altera_pcie *pcie, u8 bus, int
> > where,
> > +			       int size, u32 value);
> > +	bool sxx_flag;		/* Stratix xx */
> > +	u32 cap_offset;		/* Capabilities register
> > offset */
> I guess this is the *PCIe* Capability?  There are lots of
> capabilities, so maybe the comment could be more specific.
Yes, It is PCIe capability structure register offset. 
Will update comment.
> 
> > 
> > +	u32 cfgrd0;
> > +	u32 cfgrd1;
> > +	u32 cfgwr0;
> > +	u32 cfgwr1;
> >  };
> >  
> >  struct tlp_rp_regpair_t {
> > @@ -101,6 +127,13 @@ static bool altera_pcie_link_up(struct
> > altera_pcie *pcie)
> >  	return !!((cra_readl(pcie, RP_LTSSM) & RP_LTSSM_MASK) ==
> > LTSSM_L0);
> >  }
> >  
> > +/* Instead of LTSSM state we use the link capabilities information
> > */
> > +static bool sxx_altera_pcie_link_up(struct altera_pcie *pcie)
> > +{
> > +	return !!(readw(SXX_RP_CFG_ADDR(pcie, pcie->pcie_data-
> > >cap_offset + PCI_EXP_LNKSTA))
> > +			& PCI_EXP_LNKSTA_DLLLA);
> > +}
> > +
> >  /*
> >   * Altera PCIe port uses BAR0 of RC's configuration space as the
> > translation
> >   * from PCI bus to native BUS.  Entire DDR region is mapped into
> > PCIe space
> > @@ -128,12 +161,18 @@ static void tlp_write_tx(struct altera_pcie
> > *pcie,
> >  	cra_writel(pcie, tlp_rp_regdata->ctrl, RP_TX_CNTRL);
> >  }
> >  
> > +static void sxx_tlp_write_tx(struct altera_pcie *pcie, u32 reg0,
> > u32 ctrl)
> > +{
> > +	cra_writel(pcie, reg0, RP_TX_REG0);
> > +	cra_writel(pcie, ctrl, SXX_RP_TX_CNTRL);
> > +}
> > +
> >  static bool altera_pcie_valid_device(struct altera_pcie *pcie,
> >  				     struct pci_bus *bus, int dev)
> >  {
> >  	/* If there is no link, then there is no device */
> >  	if (bus->number != pcie->root_bus_nr) {
> > -		if (!altera_pcie_link_up(pcie))
> > +		if (!pcie->pcie_data->get_link_status(pcie))
> >  			return false;
> >  	}
> >  
> > @@ -183,6 +222,46 @@ static int tlp_read_packet(struct altera_pcie
> > *pcie, u32 *value)
> >  	return PCIBIOS_DEVICE_NOT_FOUND;
> >  }
> >  
> > +static int sxx_tlp_read_packet(struct altera_pcie *pcie, u32
> > *value)
> > +{
> > +	int i;
> > +	u32 ctrl;
> > +	u32 comp_status;
> > +	u32 dw[4];
> > +	u32 count = 0;
> > +
> > +	for (i = 0; i < TLP_LOOP; i++) {
> > +		ctrl = cra_readl(pcie, SXX_RP_RXCPL_STATUS);
> > +		if (!(ctrl & RP_RXCPL_SOP))
> > +			continue;
> > +
> > +		/* read first DW */
> s/read/Read/ to match other comments.
Noted.
> 
> > 
> > +		dw[count++] = cra_readl(pcie, SXX_RP_RXCPL_REG);
> > +
> > +		/* Poll for EOP */
> > +		for (i = 0; i < TLP_LOOP; i++) {
> > +			ctrl = cra_readl(pcie,
> > SXX_RP_RXCPL_STATUS);
> > +			dw[count++] = cra_readl(pcie,
> > SXX_RP_RXCPL_REG);
> > +			if (ctrl & RP_RXCPL_EOP) {
> > +				comp_status =
> > TLP_COMP_STATUS(dw[1]);
> > +				if (comp_status)
> > +					return
> > PCIBIOS_DEVICE_NOT_FOUND;
> > +
> > +				if (value &&
> > +				    TLP_BYTE_COUNT(dw[1]) ==
> > sizeof(u32) &&
> > +				    count >= 3)
> > +					*value = dw[3];
> > +
> > +				return PCIBIOS_SUCCESSFUL;
> > +			}
> > +		}
> > +
> > +		udelay(5);
> > +	}
> > +
> > +	return PCIBIOS_DEVICE_NOT_FOUND;
> > +}
> > +
> >  static void tlp_write_packet(struct altera_pcie *pcie, u32
> > *headers,
> >  			     u32 data, bool align)
> >  {
> > @@ -210,6 +289,18 @@ static void tlp_write_packet(struct
> > altera_pcie *pcie, u32 *headers,
> >  	tlp_write_tx(pcie, &tlp_rp_regdata);
> >  }
> >  
> > +static void sxx_tlp_write_packet(struct altera_pcie *pcie, u32
> > *headers,
> > +				 u32 data, bool dummy)
> > +{
> > +	sxx_tlp_write_tx(pcie, headers[0], RP_TX_SOP);
> > +
> > +	sxx_tlp_write_tx(pcie, headers[1], 0);
> > +
> > +	sxx_tlp_write_tx(pcie, headers[2], 0);
> > +
> > +	sxx_tlp_write_tx(pcie, data, RP_TX_EOP);
> Blank lines seem superfluous since these are all parallel.
Will remove blank lines.

> +}
> > +
> >  static int tlp_cfg_dword_read(struct altera_pcie *pcie, u8 bus,
> > u32 devfn,
> >  			      int where, u8 byte_en, u32 *value)
> >  {
> > @@ -219,9 +310,9 @@ static int tlp_cfg_dword_read(struct
> > altera_pcie *pcie, u8 bus, u32 devfn,
> >  	headers[1] = TLP_CFG_DW1(pcie, TLP_READ_TAG, byte_en);
> >  	headers[2] = TLP_CFG_DW2(bus, devfn, where);
> >  
> > -	tlp_write_packet(pcie, headers, 0, false);
> > +	pcie->pcie_data->tlp_write_pkt(pcie, headers, 0, false);
> >  
> > -	return tlp_read_packet(pcie, value);
> > +	return pcie->pcie_data->tlp_read_pkt(pcie, value);
> >  }
> >  
> >  static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus,
> > u32 devfn,
> > @@ -236,11 +327,11 @@ static int tlp_cfg_dword_write(struct
> > altera_pcie *pcie, u8 bus, u32 devfn,
> >  
> >  	/* check alignment to Qword */
> >  	if ((where & 0x7) == 0)
> > -		tlp_write_packet(pcie, headers, value, true);
> > +		pcie->pcie_data->tlp_write_pkt(pcie, headers,
> > value, true);
> >  	else
> > -		tlp_write_packet(pcie, headers, value, false);
> > +		pcie->pcie_data->tlp_write_pkt(pcie, headers,
> > value, false);
> >  
> > -	ret = tlp_read_packet(pcie, NULL);
> > +	ret = pcie->pcie_data->tlp_read_pkt(pcie, NULL);
> >  	if (ret != PCIBIOS_SUCCESSFUL)
> >  		return ret;
> >  
> > @@ -254,6 +345,52 @@ static int tlp_cfg_dword_write(struct
> > altera_pcie *pcie, u8 bus, u32 devfn,
> >  	return PCIBIOS_SUCCESSFUL;
> >  }
> >  
> > +static int sxx_rp_read_cfg(struct altera_pcie *pcie, int where,
> > +				   int size, u32 *value)
> > +{
> > +	void *addr = SXX_RP_CFG_ADDR(pcie, where);
> > +
> > +	switch (size) {
> > +	case 1:
> > +		*value = readb(addr);
> > +		break;
> > +	case 2:
> > +		*value = readw(addr);
> > +		break;
> > +	default:
> > +		*value = readl(addr);
> > +		break;
> > +	}
> > +
> > +	return PCIBIOS_SUCCESSFUL;
> > +}
> > +
> > +static int sxx_rp_write_cfg(struct altera_pcie *pcie, u8 bus, int
> > where,
> > +				   int size, u32 value)
> > +{
> > +	void *addr = SXX_RP_CFG_ADDR(pcie, where);
> > +
> > +	switch (size) {
> > +	case 1:
> > +		writeb(value, addr);
> > +		break;
> > +	case 2:
> > +		writew(value, addr);
> > +		break;
> > +	default:
> > +		writel(value, addr);
> > +		break;
> > +	}
> > +
> > +	/* Monitor changes to PCI_PRIMARY_BUS register on root
> > port
> > +	* and update local copy of root bus number accordingly.
> > +	*/
> Multi-line comment style:
> 
> 	/*
> 	 * Monitor ...
> 	 */
Noted.
> 
> > 
> > +	if (bus == pcie->root_bus_nr && where == PCI_PRIMARY_BUS)
> > +		pcie->root_bus_nr = (u8)(value);
> > +
> > +	return PCIBIOS_SUCCESSFUL;
> > +}
> > +
> >  static int _altera_pcie_cfg_read(struct altera_pcie *pcie, u8
> > busno,
> >  				 unsigned int devfn, int where,
> > int size,
> >  				 u32 *value)
> > @@ -262,6 +399,9 @@ static int _altera_pcie_cfg_read(struct
> > altera_pcie *pcie, u8 busno,
> >  	u32 data;
> >  	u8 byte_en;
> >  
> > +	if (busno == pcie->root_bus_nr && pcie->pcie_data-
> > >rp_read_cfg)
> > +		return pcie->pcie_data->rp_read_cfg(pcie, where,
> > size, value);
> > +
> >  	switch (size) {
> >  	case 1:
> >  		byte_en = 1 << (where & 3);
> > @@ -302,6 +442,10 @@ static int _altera_pcie_cfg_write(struct
> > altera_pcie *pcie, u8 busno,
> >  	u32 shift = 8 * (where & 3);
> >  	u8 byte_en;
> >  
> > +	if (busno == pcie->root_bus_nr && pcie->pcie_data-
> > >rp_write_cfg)
> > +		return pcie->pcie_data->rp_write_cfg(pcie, busno,
> > where,
> > +							size,
> > value);
> > +
> >  	switch (size) {
> >  	case 1:
> >  		data32 = (value & 0xff) << shift;
> > @@ -365,7 +509,7 @@ static int altera_read_cap_word(struct
> > altera_pcie *pcie, u8 busno,
> >  	int ret;
> >  
> >  	ret = _altera_pcie_cfg_read(pcie, busno, devfn,
> > -				    PCIE_CAP_OFFSET + offset,
> > sizeof(*value),
> > +				    pcie->pcie_data->cap_offset +
> > offset, sizeof(*value),
> >  				    &data);
> >  	*value = data;
> >  	return ret;
> > @@ -375,7 +519,7 @@ static int altera_write_cap_word(struct
> > altera_pcie *pcie, u8 busno,
> >  				 unsigned int devfn, int offset,
> > u16 value)
> >  {
> >  	return _altera_pcie_cfg_write(pcie, busno, devfn,
> > -				      PCIE_CAP_OFFSET + offset,
> > sizeof(value),
> > +				      pcie->pcie_data->cap_offset
> > + offset, sizeof(value),
> >  				      value);
> >  }
> >  
> > @@ -403,7 +547,7 @@ static void altera_wait_link_retrain(struct
> > altera_pcie *pcie)
> >  	/* Wait for link is up */
> >  	start_jiffies = jiffies;
> >  	for (;;) {
> > -		if (altera_pcie_link_up(pcie))
> > +		if (pcie->pcie_data->get_link_status(pcie))
> >  			break;
> >  
> >  		if (time_after(jiffies, start_jiffies +
> > LINK_UP_TIMEOUT)) {
> > @@ -418,7 +562,7 @@ static void altera_pcie_retrain(struct
> > altera_pcie *pcie)
> >  {
> >  	u16 linkcap, linkstat, linkctl;
> >  
> > -	if (!altera_pcie_link_up(pcie))
> > +	if (!pcie->pcie_data->get_link_status(pcie))
> >  		return;
> >  
> >  	/*
> > @@ -540,12 +684,20 @@ static int altera_pcie_parse_dt(struct
> > altera_pcie *pcie)
> >  	struct device *dev = &pcie->pdev->dev;
> >  	struct platform_device *pdev = pcie->pdev;
> >  	struct resource *cra;
> > +	struct resource *hip;
> >  
> >  	cra = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > "Cra");
> >  	pcie->cra_base = devm_ioremap_resource(dev, cra);
> >  	if (IS_ERR(pcie->cra_base))
> >  		return PTR_ERR(pcie->cra_base);
> >  
> > +	if (pcie->pcie_data->sxx_flag) {
> > +		hip = platform_get_resource_byname(pdev,
> > IORESOURCE_MEM, "Hip");
> > +		pcie->hip_base = devm_ioremap_resource(&pdev->dev, 
> > hip);
> > +		if (IS_ERR(pcie->hip_base))
> > +			return PTR_ERR(pcie->hip_base);
> > +	}
> > +
> >  	/* setup IRQ */
> >  	pcie->irq = platform_get_irq(pdev, 0);
> >  	if (pcie->irq < 0) {
> > @@ -562,6 +714,40 @@ static void altera_pcie_host_init(struct
> > altera_pcie *pcie)
> >  	altera_pcie_retrain(pcie);
> >  }
> >  
> > +static struct altera_pcie_data pci_1_0_funcs = {
> "*_funcs" seems a little too specific since this contains several
> data items in addition to function pointers.
Will change "*_funcs" to "*_data".
> 
> > 
> > +	.tlp_read_pkt = tlp_read_packet,
> > +	.tlp_write_pkt = tlp_write_packet,
> > +	.get_link_status = altera_pcie_link_up,
> > 
> > +	.rp_read_cfg = NULL,
> > +	.rp_write_cfg = NULL,
> > +	.sxx_flag = false,
> Since the above items are all zero and will be automatically
> initialized that way, it's not necessary to mention them.  Personal
> preference, either way is fine by me.
Will remove these.

> 
> > 
> > +	.cap_offset = 0x80,
> > +	.cfgrd0 = TLP_FMTTYPE_CFGRD0,
> > +	.cfgrd1 = TLP_FMTTYPE_CFGRD1,
> > +	.cfgwr0 = TLP_FMTTYPE_CFGWR0,
> > +	.cfgwr1 = TLP_FMTTYPE_CFGWR1,
> > +};
> > +
> > +static struct altera_pcie_data pci_2_0_funcs = {
> > +	.tlp_read_pkt = sxx_tlp_read_packet,
> > +	.tlp_write_pkt = sxx_tlp_write_packet,
> > +	.get_link_status = sxx_altera_pcie_link_up,
> > +	.rp_read_cfg = sxx_rp_read_cfg,
> > +	.rp_write_cfg = sxx_rp_write_cfg,
> > +	.sxx_flag = true,
> > +	.cap_offset = 0x70,
> > +	.cfgrd0 = TLP_FMTTYPE_CFGRD1,
> > +	.cfgrd1 = TLP_FMTTYPE_CFGRD0,
> > +	.cfgwr0 = TLP_FMTTYPE_CFGWR1,
> > +	.cfgwr1 = TLP_FMTTYPE_CFGWR0,
> It's "interesting" that these type0/type1 values are exactly reversed
> from the 1.0 device.  I assume that's actually correct, but if so, I
> think the macros might be more confusing than just using bare
> numbers,
> because the macro names and comments end up being wrong for 2.0.  Or
> you could define SXX_TLP_FMTTYPE_* macros I guess.
Okay, will define new macros for these.
> 
> > 
> > +};
> > +
> > +static const struct of_device_id altera_pcie_of_match[] = {
> > +	{ .compatible = "altr,pcie-root-port-1.0", .data =
> > &pci_1_0_funcs },
> > +	{ .compatible = "altr,pcie-root-port-2.0", .data =
> > &pci_2_0_funcs },
> > +	{},
> > +};
> > +
> >  static int altera_pcie_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev = &pdev->dev;
> > @@ -570,6 +756,7 @@ static int altera_pcie_probe(struct
> > platform_device *pdev)
> >  	struct pci_bus *child;
> >  	struct pci_host_bridge *bridge;
> >  	int ret;
> > +	const struct of_device_id *match;
> >  
> >  	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
> >  	if (!bridge)
> > @@ -578,6 +765,12 @@ static int altera_pcie_probe(struct
> > platform_device *pdev)
> >  	pcie = pci_host_bridge_priv(bridge);
> >  	pcie->pdev = pdev;
> >  
> > +	match = of_match_device(altera_pcie_of_match, &pdev->dev);
> > +	if (!match)
> > +		return -ENODEV;
> > +
> > +	pcie->pcie_data = match->data;
> > +
> >  	ret = altera_pcie_parse_dt(pcie);
> >  	if (ret) {
> >  		dev_err(dev, "Parsing DT failed\n");
> > @@ -628,11 +821,6 @@ static int altera_pcie_probe(struct
> > platform_device *pdev)
> >  	return ret;
> >  }
> >  
> > -static const struct of_device_id altera_pcie_of_match[] = {
> > -	{ .compatible = "altr,pcie-root-port-1.0", },
> > -	{},
> > -};
> > -
> >  static struct platform_driver altera_pcie_driver = {
> >  	.probe		= altera_pcie_probe,
> >  	.driver = {
