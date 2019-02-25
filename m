Return-Path: <SRS0=2sVk=RA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926F2C43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Feb 2019 09:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FA92087C
	for <linux-pci@archiver.kernel.org>; Mon, 25 Feb 2019 09:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfBYJfN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Feb 2019 04:35:13 -0500
Received: from mga04.intel.com ([192.55.52.120]:49954 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbfBYJfM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Feb 2019 04:35:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2019 01:35:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,411,1544515200"; 
   d="scan'208";a="146291219"
Received: from lftan-mobl.gar.corp.intel.com (HELO ubuntu) ([10.226.248.73])
  by fmsmga002.fm.intel.com with SMTP; 25 Feb 2019 01:35:10 -0800
Received: by ubuntu (sSMTP sendmail emulation); Mon, 25 Feb 2019 17:35:08 +0800
Message-ID: <1551087307.2534.16.camel@intel.com>
Subject: Re: [PATCH v4 1/3] PCI: altera: Add Stratix 10 PCIe support
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        lftan.linux@gmail.com
Date:   Mon, 25 Feb 2019 17:35:07 +0800
In-Reply-To: <20190219162313.GB21833@e107981-ln.cambridge.arm.com>
References: <1550157638-25112-1-git-send-email-ley.foon.tan@intel.com>
         <1550157638-25112-2-git-send-email-ley.foon.tan@intel.com>
         <20190219162313.GB21833@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2019-02-19 at 16:23 +0000, Lorenzo Pieralisi wrote:
> On Thu, Feb 14, 2019 at 11:20:36PM +0800, Ley Foon Tan wrote:
> > 
> > Add PCIe Root Port support for Stratix 10 device.
> > 
> > Main differences:
> Main differences with what ? We need to rewrite this commit log.
Differences compare with Cyclone V and Arria 10 devices. 
I will rewrite this.
> 
> > 
> > - HIP interface to access Root Port configuration register.
> > - TLP programming flow:
> >   - One REG0 register
> >   - Don't need to check alignment
> > 
> > Signed-off-by: Ley Foon Tan <ley.foon.tan@intel.com>
> > ---
> >  drivers/pci/controller/pcie-altera.c |  246
> > ++++++++++++++++++++++++++++++----
> >  1 files changed, 222 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-altera.c
> > b/drivers/pci/controller/pcie-altera.c
> > index 7d05e51..76bb6a6 100644
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
> > +#define S10_RP_TX_CNTRL			0x2004
> > +#define S10_RP_RXCPL_REG		0x2008
> > +#define S10_RP_RXCPL_STATUS		0x200C
> > +#define S10_RP_CFG_ADDR(pcie, reg)	\
> > +	(((pcie)->hip_base) + (reg) + (1 << 20))
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
> > -     TLP_PAYLOAD_SIZE)
> > +	((((bus == pcie->root_bus_nr) ? pcie->pcie_data->cfgrd0	
> > 	\
> > +				: pcie->pcie_data->cfgrd1) << 24)
> > |	\
> > +				TLP_PAYLOAD_SIZE)
> >  #define TLP_CFGWR_DW0(pcie, bus)					
> > \
> > -    ((((bus == pcie->root_bus_nr) ? TLP_FMTTYPE_CFGWR0		
> > 	\
> > -				    : TLP_FMTTYPE_CFGWR1) << 24) |
> > 	\
> > -     TLP_PAYLOAD_SIZE)
> > +	((((bus == pcie->root_bus_nr) ? pcie->pcie_data->cfgwr0	
> > 	\
> > +				: pcie->pcie_data->cfgwr1) << 24)
> > |	\
> > +				TLP_PAYLOAD_SIZE)
> >  #define TLP_CFG_DW1(pcie, tag, be)	\
> > -    (((TLP_REQ_ID(pcie->root_bus_nr,  RP_DEVFN)) << 16) | (tag <<
> > 8) | (be))
> > +	(((TLP_REQ_ID(pcie->root_bus_nr,  RP_DEVFN)) << 16) | (tag
> > << 8) | (be))
> >  #define TLP_CFG_DW2(bus, devfn, offset)	\
> >  				(((bus) << 24) | ((devfn) << 16) |
> > (offset))
> >  #define TLP_COMP_STATUS(s)		(((s) >> 13) & 7)
> > +#define TLP_BYTE_COUNT(s)		(((s) >> 0) & 0xfff)
> >  #define TLP_HDR_SIZE			3
> >  #define TLP_LOOP			500
> >  
> > @@ -69,14 +76,43 @@
> >  
> >  #define DWORD_MASK			3
> >  
> > +#define S10_TLP_FMTTYPE_CFGRD0		0x05
> > +#define S10_TLP_FMTTYPE_CFGRD1		0x04
> > +#define S10_TLP_FMTTYPE_CFGWR0		0x45
> > +#define S10_TLP_FMTTYPE_CFGWR1		0x44
> > +
> > +enum altera_pcie_version {
> > +	ALTERA_PCIE_V1 = 0,
> > +	ALTERA_PCIE_V2,
> > +};
> > +
> >  struct altera_pcie {
> >  	struct platform_device	*pdev;
> > -	void __iomem		*cra_base;	/* DT Cra */
> > +	void __iomem		*cra_base;
> > +	void __iomem		*hip_base;
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
> > +			   int size, u32 *value);
> > +	int (*rp_write_cfg)(struct altera_pcie *pcie, u8 bus, int
> > where,
> > +			    int size, u32 value);
> > +	enum altera_pcie_version version;
> > +	u32 cap_offset;		/* PCIe capability
> > structure register offset */
> This is a duplication of struct pci_dev.pcie_cap right ?

This is register offset in PCIe Rootport IP to access PCIe Cap
structure register of directly RP. This allow us to access PCIe cap
struct register without pci_dev.

> 
> > 
> > +	u32 cfgrd0;
> > +	u32 cfgrd1;
> > +	u32 cfgwr0;
> > +	u32 cfgwr1;
> >  };
> >  
> >  struct tlp_rp_regpair_t {
> > @@ -101,6 +137,15 @@ static bool altera_pcie_link_up(struct
> > altera_pcie *pcie)
> >  	return !!((cra_readl(pcie, RP_LTSSM) & RP_LTSSM_MASK) ==
> > LTSSM_L0);
> >  }
> >  
> > +static bool s10_altera_pcie_link_up(struct altera_pcie *pcie)
> > +{
> > +	void __iomem *addr = S10_RP_CFG_ADDR(pcie,
> > +				   pcie->pcie_data->cap_offset +
> > +				   PCI_EXP_LNKSTA);
> > +
> > +	return !!(readw(addr) & PCI_EXP_LNKSTA_DLLLA);
> > +}
> > +
> >  /*
> >   * Altera PCIe port uses BAR0 of RC's configuration space as the
> > translation
> >   * from PCI bus to native BUS.  Entire DDR region is mapped into
> > PCIe space
> > @@ -128,12 +173,18 @@ static void tlp_write_tx(struct altera_pcie
> > *pcie,
> >  	cra_writel(pcie, tlp_rp_regdata->ctrl, RP_TX_CNTRL);
> >  }
> >  
> > +static void s10_tlp_write_tx(struct altera_pcie *pcie, u32 reg0,
> > u32 ctrl)
> > +{
> > +	cra_writel(pcie, reg0, RP_TX_REG0);
> > +	cra_writel(pcie, ctrl, S10_RP_TX_CNTRL);
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
> > @@ -183,6 +234,46 @@ static int tlp_read_packet(struct altera_pcie
> > *pcie, u32 *value)
> >  	return PCIBIOS_DEVICE_NOT_FOUND;
> >  }
> >  
> > +static int s10_tlp_read_packet(struct altera_pcie *pcie, u32
> > *value)
> > +{
> > +	int i;
> > +	u32 ctrl;
> > +	u32 comp_status;
> > +	u32 dw[4];
> > +	u32 count = 0;
> > +
> > +	for (i = 0; i < TLP_LOOP; i++) {
> > +		ctrl = cra_readl(pcie, S10_RP_RXCPL_STATUS);
> > +		if (!(ctrl & RP_RXCPL_SOP))
> > +			continue;
> > +
> > +		/* Read first DW */
> > +		dw[count++] = cra_readl(pcie, S10_RP_RXCPL_REG);
> > +
> > +		/* Poll for EOP */
> > +		for (i = 0; i < TLP_LOOP; i++) {
> > +			ctrl = cra_readl(pcie,
> > S10_RP_RXCPL_STATUS);
> > +			dw[count++] = cra_readl(pcie,
> > S10_RP_RXCPL_REG);
> I think you'd better add a check on count lest it can overflow dw[].
Okay, will check that.
> 
> > 
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
> > @@ -210,6 +301,15 @@ static void tlp_write_packet(struct
> > altera_pcie *pcie, u32 *headers,
> >  	tlp_write_tx(pcie, &tlp_rp_regdata);
> >  }
> >  
> > +static void s10_tlp_write_packet(struct altera_pcie *pcie, u32
> > *headers,
> > +				 u32 data, bool dummy)
> > +{
> > +	s10_tlp_write_tx(pcie, headers[0], RP_TX_SOP);
> > +	s10_tlp_write_tx(pcie, headers[1], 0);
> > +	s10_tlp_write_tx(pcie, headers[2], 0);
> > +	s10_tlp_write_tx(pcie, data, RP_TX_EOP);
> > +}
> > +
> >  static int tlp_cfg_dword_read(struct altera_pcie *pcie, u8 bus,
> > u32 devfn,
> >  			      int where, u8 byte_en, u32 *value)
> >  {
> > @@ -219,9 +319,9 @@ static int tlp_cfg_dword_read(struct
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
> > @@ -236,11 +336,11 @@ static int tlp_cfg_dword_write(struct
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
> > @@ -254,6 +354,53 @@ static int tlp_cfg_dword_write(struct
> > altera_pcie *pcie, u8 bus, u32 devfn,
> >  	return PCIBIOS_SUCCESSFUL;
> >  }
> >  
> > +static int s10_rp_read_cfg(struct altera_pcie *pcie, int where,
> > +			   int size, u32 *value)
> > +{
> > +	void *addr = S10_RP_CFG_ADDR(pcie, where);
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
> This boilerplace could be avoided if you used generic config
> accessors (ie pci_generic_config_read()/write()).
Okay. I will change this.
> 
> > 
> > +
> > +	return PCIBIOS_SUCCESSFUL;
> > +}
> > +
> > +static int s10_rp_write_cfg(struct altera_pcie *pcie, u8 bus, int
> > where,
> > +			    int size, u32 value)
> > +{
> > +	void *addr = S10_RP_CFG_ADDR(pcie, where);
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
> Ditto.
Noted.
> 
> > 
> > +
> > +	/*
> > +	 * Monitor changes to PCI_PRIMARY_BUS register on root
> > port
> > +	 * and update local copy of root bus number accordingly.
> > +	 */
> > +	if (bus == pcie->root_bus_nr && where == PCI_PRIMARY_BUS)
> > +		pcie->root_bus_nr = value & 0xff;
> > +
> > +	return PCIBIOS_SUCCESSFUL;
> > +}
> > +
> >  static int _altera_pcie_cfg_read(struct altera_pcie *pcie, u8
> > busno,
> >  				 unsigned int devfn, int where,
> > int size,
> >  				 u32 *value)
> > @@ -262,6 +409,9 @@ static int _altera_pcie_cfg_read(struct
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
> > @@ -302,6 +452,10 @@ static int _altera_pcie_cfg_write(struct
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
> > @@ -365,7 +519,8 @@ static int altera_read_cap_word(struct
> > altera_pcie *pcie, u8 busno,
> >  	int ret;
> >  
> >  	ret = _altera_pcie_cfg_read(pcie, busno, devfn,
> > -				    PCIE_CAP_OFFSET + offset,
> > sizeof(*value),
> > +				    pcie->pcie_data->cap_offset +
> > offset,
> > +				    sizeof(*value),
> >  				    &data);
> >  	*value = data;
> >  	return ret;
> > @@ -375,7 +530,8 @@ static int altera_write_cap_word(struct
> > altera_pcie *pcie, u8 busno,
> >  				 unsigned int devfn, int offset,
> > u16 value)
> >  {
> >  	return _altera_pcie_cfg_write(pcie, busno, devfn,
> > -				      PCIE_CAP_OFFSET + offset,
> > sizeof(value),
> > +				      pcie->pcie_data->cap_offset
> > + offset,
> > +				      sizeof(value),
> >  				      value);
> >  }
> >  
> > @@ -403,7 +559,7 @@ static void altera_wait_link_retrain(struct
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
> > @@ -418,7 +574,7 @@ static void altera_pcie_retrain(struct
> > altera_pcie *pcie)
> >  {
> >  	u16 linkcap, linkstat, linkctl;
> >  
> > -	if (!altera_pcie_link_up(pcie))
> > +	if (!pcie->pcie_data->get_link_status(pcie))
> >  		return;
> >  
> >  	/*
> > @@ -540,12 +696,20 @@ static int altera_pcie_parse_dt(struct
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
> > +	if (pcie->pcie_data->version == ALTERA_PCIE_V2) {
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
> > @@ -562,6 +726,38 @@ static void altera_pcie_host_init(struct
> > altera_pcie *pcie)
> >  	altera_pcie_retrain(pcie);
> >  }
> >  
> > +static struct altera_pcie_data pci_1_0_data = {
> > +	.tlp_read_pkt = tlp_read_packet,
> > +	.tlp_write_pkt = tlp_write_packet,
> > +	.get_link_status = altera_pcie_link_up,
> > +	.cap_offset = 0x80,
> > +	.version = ALTERA_PCIE_V1,
> > +	.cfgrd0 = TLP_FMTTYPE_CFGRD0,
> > +	.cfgrd1 = TLP_FMTTYPE_CFGRD1,
> > +	.cfgwr0 = TLP_FMTTYPE_CFGWR0,
> > +	.cfgwr1 = TLP_FMTTYPE_CFGWR1,
> > +};
> > +
> > +static struct altera_pcie_data pci_2_0_data = {
> > +	.tlp_read_pkt = s10_tlp_read_packet,
> > +	.tlp_write_pkt = s10_tlp_write_packet,
> > +	.get_link_status = s10_altera_pcie_link_up,
> > +	.rp_read_cfg = s10_rp_read_cfg,
> > +	.rp_write_cfg = s10_rp_write_cfg,
> > +	.version = ALTERA_PCIE_V2,
> > +	.cap_offset = 0x70,
> > +	.cfgrd0 = S10_TLP_FMTTYPE_CFGRD0,
> > +	.cfgrd1 = S10_TLP_FMTTYPE_CFGRD1,
> > +	.cfgwr0 = S10_TLP_FMTTYPE_CFGWR0,
> > +	.cfgwr1 = S10_TLP_FMTTYPE_CFGWR1,
> > +};
> I wonder if it is not better to have two different struct pci_ops
> (and
> have a pointer to them in struct altera_pcie_data) instead of all
> these
> parameters (most of which are there to differentiate struct pci_ops
> methods).
> 
> See also my comments above.
> 
> In the end I guess it depends on how many host bridges will be based
> on
> this IP as design, what you did is OK but it is worth thinking about
> it.
> 
We have 2 versions of HW based on this IP as for now. May have new
version in future.
I can move all callback functions to struct pci_ops and have a pointer
in struct altera_pcie_data.

Thanks.


Regards
Ley Foon
