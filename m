Return-Path: <SRS0=xyCL=RH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D18C43381
	for <linux-pci@archiver.kernel.org>; Mon,  4 Mar 2019 06:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0133B2082F
	for <linux-pci@archiver.kernel.org>; Mon,  4 Mar 2019 06:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfCDG4a (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Mar 2019 01:56:30 -0500
Received: from mga06.intel.com ([134.134.136.31]:15299 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfCDG4a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Mar 2019 01:56:30 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2019 22:55:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,439,1544515200"; 
   d="scan'208,223";a="325156338"
Received: from lftan-mobl.gar.corp.intel.com (HELO ubuntu) ([10.226.248.102])
  by fmsmga005.fm.intel.com with SMTP; 03 Mar 2019 22:55:55 -0800
Received: by ubuntu (sSMTP sendmail emulation); Mon, 04 Mar 2019 14:55:49 +0800
Message-ID: <1551682549.24631.24.camel@intel.com>
Subject: Re: [PATCH v6 1/3] PCI: altera: Add Stratix 10 PCIe support
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        lftan.linux@gmail.com
Date:   Mon, 04 Mar 2019 14:55:49 +0800
In-Reply-To: <20190301141516.GA4783@e107981-ln.cambridge.arm.com>
References: <1551351172-25424-1-git-send-email-ley.foon.tan@intel.com>
         <1551351172-25424-2-git-send-email-ley.foon.tan@intel.com>
         <20190228105612.GA31404@red-moon> <1551401448.24631.15.camel@intel.com>
         <20190301141516.GA4783@e107981-ln.cambridge.arm.com>
Content-Type: multipart/mixed; boundary="=-9hhI7CMo5Fjw/E4pBMop"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-9hhI7CMo5Fjw/E4pBMop
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-03-01 at 14:15 +0000, Lorenzo Pieralisi wrote:
> On Fri, Mar 01, 2019 at 08:50:48AM +0800, Ley Foon Tan wrote:
> >=20
> > On Thu, 2019-02-28 at 10:56 +0000, Lorenzo Pieralisi wrote:
> > >=20
> > > On Thu, Feb 28, 2019 at 06:52:50PM +0800, Ley Foon Tan wrote:
> > >=20
> > > [...]
> > >=20
> > > >=20
> > > >=20
> > > > +static int s10_tlp_read_packet(struct altera_pcie *pcie, u32
> > > > *value)
> > > > +{
> > > > +	int i;
> > > > +	u32 ctrl;
> > > > +	u32 comp_status;
> > > > +	u32 dw[4];
> > > > +	u32 count;
> > > > +
> > > > +	for (i =3D 0; i < TLP_LOOP; i++) {
> > > > +		ctrl =3D cra_readl(pcie, S10_RP_RXCPL_STATUS);
> > > > +		if (!(ctrl & RP_RXCPL_SOP)) {
> > > > +			udelay(5);
> > > > +			continue;
> > > > +		}
> > > > +
> > > > +		/* Read first DW */
> > > > +		dw[0] =3D cra_readl(pcie, S10_RP_RXCPL_REG);
> > > > +		count =3D 1;
> > > > +
> > > > +		/* Poll for EOP */
> > > > +		for (i =3D 0; i < TLP_LOOP && count <
> > > > ARRAY_SIZE(dw); i++) {
> > > > +			ctrl =3D cra_readl(pcie,
> > > > S10_RP_RXCPL_STATUS);
> > > > +			dw[count++] =3D cra_reeadl(pcie,
> > > > S10_RP_RXCPL_REG);
> > > > +			if (ctrl & RP_RXCPL_EOP) {
> > > > +				comp_status =3D
> > > > TLP_COMP_STATUS(dw[1]);
> > > > +				if (comp_status)
> > > > +					return
> > > > PCIBIOS_DEVICE_NOT_FOUND;
> > > > +
> > > > +				if (value &&
> > > > +				????????TLP_BYTE_COUNT(dw[1])
> > > > =3D=3D
> > > > sizeof(u32) &&
> > > > +				????????count =3D=3D 4)
> > > > +					*value =3D dw[3];
> > > > +
> > > > +				return PCIBIOS_SUCCESSFUL;
> > > > +			}
> > > Two more things.
> > >=20
> > > - Why don't you need a udelay() in the inner loop ?
> > It has received start of packet (SOP) when in the inner loop, next
> > DW
> > will come on next. So, I don't add udelay here.
> > >=20
> > > - I think that count >=3D ARRAY_SIZE(dw) in the inner loop is an
> > > error
> > > ?? condition and it should be flagged up with a warning before
> > > exiting.
> > Yes, please add this.
> > >=20
> > >=20
> > > I can make these changes if you let me know your thoughts on
> > > this.
> > Please go ahead and change this.
> I rewrote the loop.
>=20
> Please have a look at my branch not-to-merge/pci-altera, if that's
> OK and it passes the kbot tests I will try to get it upstream.
>=20
> Lorenzo
We need return error if (i >=3D TLP_LOOP). Other than that is okay.


+	if (i >=3D TLP_LOOP)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+

I also attached a patch in attachment to fix the Sparse warnings.
You can squash it to this patch.

Thanks.


Regards
Ley Foon

>=20
> >=20
> > Thanks.
> >=20
> > Regards
> > Ley Foon
> > >=20
> > >=20
> > > Lorenzo
> > >=20
> > > >=20
> > > >=20
> > > > +		}
> > > > +	}
> > > > +
> > > > +	return PCIBIOS_DEVICE_NOT_FOUND;
> > > > +}
> > > > +
> > > > ??static void tlp_write_packet(struct altera_pcie *pcie, u32
> > > > *headers,
> > > > ??			??????????u32 data, bool align)
> > > > ??{
> > > > @@ -210,6 +306,15 @@ static void tlp_write_packet(struct
> > > > altera_pcie *pcie, u32 *headers,
> > > > ??	tlp_write_tx(pcie, &tlp_rp_regdata);
> > > > ??}
> > > > ??
> > > > +static void s10_tlp_write_packet(struct altera_pcie *pcie, u32
> > > > *headers,
> > > > +				??u32 data, bool dummy)
> > > > +{
> > > > +	s10_tlp_write_tx(pcie, headers[0], RP_TX_SOP);
> > > > +	s10_tlp_write_tx(pcie, headers[1], 0);
> > > > +	s10_tlp_write_tx(pcie, headers[2], 0);
> > > > +	s10_tlp_write_tx(pcie, data, RP_TX_EOP);
> > > > +}
> > > > +
> > > > ??static int tlp_cfg_dword_read(struct altera_pcie *pcie, u8
> > > > bus,
> > > > u32 devfn,
> > > > ??			????????????int where, u8 byte_en,
> > > > u32 *value)
> > > > ??{
> > > > @@ -219,9 +324,9 @@ static int tlp_cfg_dword_read(struct
> > > > altera_pcie *pcie, u8 bus, u32 devfn,
> > > > ??	headers[1] =3D TLP_CFG_DW1(pcie, TLP_READ_TAG,
> > > > byte_en);
> > > > ??	headers[2] =3D TLP_CFG_DW2(bus, devfn, where);
> > > > ??
> > > > -	tlp_write_packet(pcie, headers, 0, false);
> > > > +	pcie->pcie_data->ops->tlp_write_pkt(pcie, headers, 0,
> > > > false);
> > > > ??
> > > > -	return tlp_read_packet(pcie, value);
> > > > +	return pcie->pcie_data->ops->tlp_read_pkt(pcie,
> > > > value);
> > > > ??}
> > > > ??
> > > > ??static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8
> > > > bus,
> > > > u32 devfn,
> > > > @@ -236,11 +341,13 @@ static int tlp_cfg_dword_write(struct
> > > > altera_pcie *pcie, u8 bus, u32 devfn,
> > > > ??
> > > > ??	/* check alignment to Qword */
> > > > ??	if ((where & 0x7) =3D=3D 0)
> > > > -		tlp_write_packet(pcie, headers, value, true);
> > > > +		pcie->pcie_data->ops->tlp_write_pkt(pcie,
> > > > headers,
> > > > +						????????value,
> > > > true);
> > > > ??	else
> > > > -		tlp_write_packet(pcie, headers, value, false);
> > > > +		pcie->pcie_data->ops->tlp_write_pkt(pcie,
> > > > headers,
> > > > +						????????value,
> > > > false);
> > > > ??
> > > > -	ret =3D tlp_read_packet(pcie, NULL);
> > > > +	ret =3D pcie->pcie_data->ops->tlp_read_pkt(pcie, NULL);
> > > > ??	if (ret !=3D PCIBIOS_SUCCESSFUL)
> > > > ??		return ret;
> > > > ??
> > > > @@ -254,6 +361,53 @@ static int tlp_cfg_dword_write(struct
> > > > altera_pcie *pcie, u8 bus, u32 devfn,
> > > > ??	return PCIBIOS_SUCCESSFUL;
> > > > ??}
> > > > ??
> > > > +static int s10_rp_read_cfg(struct altera_pcie *pcie, int
> > > > where,
> > > > +			??????int size, u32 *value)
> > > > +{
> > > > +	void *addr =3D S10_RP_CFG_ADDR(pcie, where);
> > > > +
> > > > +	switch (size) {
> > > > +	case 1:
> > > > +		*value =3D readb(addr);
> > > > +		break;
> > > > +	case 2:
> > > > +		*value =3D readw(addr);
> > > > +		break;
> > > > +	default:
> > > > +		*value =3D readl(addr);
> > > > +		break;
> > > > +	}
> > > > +
> > > > +	return PCIBIOS_SUCCESSFUL;
> > > > +}
> > > > +
> > > > +static int s10_rp_write_cfg(struct altera_pcie *pcie, u8
> > > > busno,
> > > > +			????????int where, int size, u32
> > > > value)
> > > > +{
> > > > +	void *addr =3D S10_RP_CFG_ADDR(pcie, where);
> > > > +
> > > > +	switch (size) {
> > > > +	case 1:
> > > > +		writeb(value, addr);
> > > > +		break;
> > > > +	case 2:
> > > > +		writew(value, addr);
> > > > +		break;
> > > > +	default:
> > > > +		writel(value, addr);
> > > > +		break;
> > > > +	}
> > > > +
> > > > +	/*
> > > > +	??* Monitor changes to PCI_PRIMARY_BUS register on
> > > > root
> > > > port
> > > > +	??* and update local copy of root bus number
> > > > accordingly.
> > > > +	??*/
> > > > +	if (busno =3D=3D pcie->root_bus_nr && where =3D=3D
> > > > PCI_PRIMARY_BUS)
> > > > +		pcie->root_bus_nr =3D value & 0xff;
> > > > +
> > > > +	return PCIBIOS_SUCCESSFUL;
> > > > +}
> > > > +
> > > > ??static int _altera_pcie_cfg_read(struct altera_pcie *pcie, u8
> > > > busno,
> > > > ??				??unsigned int devfn, int
> > > > where,
> > > > int size,
> > > > ??				??u32 *value)
> > > > @@ -262,6 +416,10 @@ static int _altera_pcie_cfg_read(struct
> > > > altera_pcie *pcie, u8 busno,
> > > > ??	u32 data;
> > > > ??	u8 byte_en;
> > > > ??
> > > > +	if (busno =3D=3D pcie->root_bus_nr && pcie->pcie_data-
> > > > >ops-
> > > > >=20
> > > > > rp_read_cfg)
> > > > +		return pcie->pcie_data->ops->rp_read_cfg(pcie,
> > > > where,
> > > > +							??size
> > > > ,
> > > > value);
> > > > +
> > > > ??	switch (size) {
> > > > ??	case 1:
> > > > ??		byte_en =3D 1 << (where & 3);
> > > > @@ -302,6 +460,10 @@ static int _altera_pcie_cfg_write(struct
> > > > altera_pcie *pcie, u8 busno,
> > > > ??	u32 shift =3D 8 * (where & 3);
> > > > ??	u8 byte_en;
> > > > ??
> > > > +	if (busno =3D=3D pcie->root_bus_nr && pcie->pcie_data-
> > > > >ops-
> > > > >=20
> > > > > rp_write_cfg)
> > > > +		return pcie->pcie_data->ops-
> > > > >rp_write_cfg(pcie,
> > > > busno,
> > > > +						??????????wher
> > > > e, size,
> > > > value);
> > > > +
> > > > ??	switch (size) {
> > > > ??	case 1:
> > > > ??		data32 =3D (value & 0xff) << shift;
> > > > @@ -365,7 +527,8 @@ static int altera_read_cap_word(struct
> > > > altera_pcie *pcie, u8 busno,
> > > > ??	int ret;
> > > > ??
> > > > ??	ret =3D _altera_pcie_cfg_read(pcie, busno, devfn,
> > > > -				????????PCIE_CAP_OFFSET +
> > > > offset,
> > > > sizeof(*value),
> > > > +				????????pcie->pcie_data-
> > > > >cap_offset +
> > > > offset,
> > > > +				????????sizeof(*value),
> > > > ??				????????&data);
> > > > ??	*value =3D data;
> > > > ??	return ret;
> > > > @@ -375,7 +538,8 @@ static int altera_write_cap_word(struct
> > > > altera_pcie *pcie, u8 busno,
> > > > ??				??unsigned int devfn, int
> > > > offset,
> > > > u16 value)
> > > > ??{
> > > > ??	return _altera_pcie_cfg_write(pcie, busno, devfn,
> > > > -				????????????PCIE_CAP_OFFSET +
> > > > offset,
> > > > sizeof(value),
> > > > +				????????????pcie->pcie_data-
> > > > >cap_offset
> > > > + offset,
> > > > +				????????????sizeof(value),
> > > > ??				????????????value);
> > > > ??}
> > > > ??
> > > > @@ -403,7 +567,7 @@ static void altera_wait_link_retrain(struct
> > > > altera_pcie *pcie)
> > > > ??	/* Wait for link is up */
> > > > ??	start_jiffies =3D jiffies;
> > > > ??	for (;;) {
> > > > -		if (altera_pcie_link_up(pcie))
> > > > +		if (pcie->pcie_data->ops-
> > > > >get_link_status(pcie))
> > > > ??			break;
> > > > ??
> > > > ??		if (time_after(jiffies, start_jiffies +
> > > > LINK_UP_TIMEOUT)) {
> > > > @@ -418,7 +582,7 @@ static void altera_pcie_retrain(struct
> > > > altera_pcie *pcie)
> > > > ??{
> > > > ??	u16 linkcap, linkstat, linkctl;
> > > > ??
> > > > -	if (!altera_pcie_link_up(pcie))
> > > > +	if (!pcie->pcie_data->ops->get_link_status(pcie))
> > > > ??		return;
> > > > ??
> > > > ??	/*
> > > > @@ -540,12 +704,20 @@ static int altera_pcie_parse_dt(struct
> > > > altera_pcie *pcie)
> > > > ??	struct device *dev =3D &pcie->pdev->dev;
> > > > ??	struct platform_device *pdev =3D pcie->pdev;
> > > > ??	struct resource *cra;
> > > > +	struct resource *hip;
> > > > ??
> > > > ??	cra =3D platform_get_resource_byname(pdev,
> > > > IORESOURCE_MEM,
> > > > "Cra");
> > > > ??	pcie->cra_base =3D devm_ioremap_resource(dev, cra);
> > > > ??	if (IS_ERR(pcie->cra_base))
> > > > ??		return PTR_ERR(pcie->cra_base);
> > > > ??
> > > > +	if (pcie->pcie_data->version =3D=3D ALTERA_PCIE_V2) {
> > > > +		hip =3D platform_get_resource_byname(pdev,
> > > > IORESOURCE_MEM, "Hip");
> > > > +		pcie->hip_base =3D devm_ioremap_resource(&pdev-
> > > > >dev,=C2=A0
> > > > hip);
> > > > +		if (IS_ERR(pcie->hip_base))
> > > > +			return PTR_ERR(pcie->hip_base);
> > > > +	}
> > > > +
> > > > ??	/* setup IRQ */
> > > > ??	pcie->irq =3D platform_get_irq(pdev, 0);
> > > > ??	if (pcie->irq < 0) {
> > > > @@ -562,6 +734,48 @@ static void altera_pcie_host_init(struct
> > > > altera_pcie *pcie)
> > > > ??	altera_pcie_retrain(pcie);
> > > > ??}
> > > > ??
> > > > +static const struct altera_pcie_ops altera_pcie_ops_1_0 =3D {
> > > > +	.tlp_read_pkt =3D tlp_read_packet,
> > > > +	.tlp_write_pkt =3D tlp_write_packet,
> > > > +	.get_link_status =3D altera_pcie_link_up,
> > > > +};
> > > > +
> > > > +static const struct altera_pcie_ops altera_pcie_ops_2_0 =3D {
> > > > +	.tlp_read_pkt =3D s10_tlp_read_packet,
> > > > +	.tlp_write_pkt =3D s10_tlp_write_packet,
> > > > +	.get_link_status =3D s10_altera_pcie_link_up,
> > > > +	.rp_read_cfg =3D s10_rp_read_cfg,
> > > > +	.rp_write_cfg =3D s10_rp_write_cfg,
> > > > +};
> > > > +
> > > > +static const struct altera_pcie_data altera_pcie_1_0_data =3D {
> > > > +	.ops =3D &altera_pcie_ops_1_0,
> > > > +	.cap_offset =3D 0x80,
> > > > +	.version =3D ALTERA_PCIE_V1,
> > > > +	.cfgrd0 =3D TLP_FMTTYPE_CFGRD0,
> > > > +	.cfgrd1 =3D TLP_FMTTYPE_CFGRD1,
> > > > +	.cfgwr0 =3D TLP_FMTTYPE_CFGWR0,
> > > > +	.cfgwr1 =3D TLP_FMTTYPE_CFGWR1,
> > > > +};
> > > > +
> > > > +static const struct altera_pcie_data altera_pcie_2_0_data =3D {
> > > > +	.ops =3D &altera_pcie_ops_2_0,
> > > > +	.version =3D ALTERA_PCIE_V2,
> > > > +	.cap_offset =3D 0x70,
> > > > +	.cfgrd0 =3D S10_TLP_FMTTYPE_CFGRD0,
> > > > +	.cfgrd1 =3D S10_TLP_FMTTYPE_CFGRD1,
> > > > +	.cfgwr0 =3D S10_TLP_FMTTYPE_CFGWR0,
> > > > +	.cfgwr1 =3D S10_TLP_FMTTYPE_CFGWR1,
> > > > +};
> > > > +
> > > > +static const struct of_device_id altera_pcie_of_match[] =3D {
> > > > +	{.compatible =3D "altr,pcie-root-port-1.0",
> > > > +	??.data =3D &altera_pcie_1_0_data },
> > > > +	{.compatible =3D "altr,pcie-root-port-2.0",
> > > > +	??.data =3D &altera_pcie_2_0_data },
> > > > +	{},
> > > > +};
> > > > +
> > > > ??static int altera_pcie_probe(struct platform_device *pdev)
> > > > ??{
> > > > ??	struct device *dev =3D &pdev->dev;
> > > > @@ -570,6 +784,7 @@ static int altera_pcie_probe(struct
> > > > platform_device *pdev)
> > > > ??	struct pci_bus *child;
> > > > ??	struct pci_host_bridge *bridge;
> > > > ??	int ret;
> > > > +	const struct of_device_id *match;
> > > > ??
> > > > ??	bridge =3D devm_pci_alloc_host_bridge(dev,
> > > > sizeof(*pcie));
> > > > ??	if (!bridge)
> > > > @@ -578,6 +793,12 @@ static int altera_pcie_probe(struct
> > > > platform_device *pdev)
> > > > ??	pcie =3D pci_host_bridge_priv(bridge);
> > > > ??	pcie->pdev =3D pdev;
> > > > ??
> > > > +	match =3D of_match_device(altera_pcie_of_match, &pdev-
> > > > >dev);
> > > > +	if (!match)
> > > > +		return -ENODEV;
> > > > +
> > > > +	pcie->pcie_data =3D match->data;
> > > > +
> > > > ??	ret =3D altera_pcie_parse_dt(pcie);
> > > > ??	if (ret) {
> > > > ??		dev_err(dev, "Parsing DT failed\n");
> > > > @@ -628,11 +849,6 @@ static int altera_pcie_probe(struct
> > > > platform_device *pdev)
> > > > ??	return ret;
> > > > ??}
> > > > ??
> > > > -static const struct of_device_id altera_pcie_of_match[] =3D {
> > > > -	{ .compatible =3D "altr,pcie-root-port-1.0", },
> > > > -	{},
> > > > -};
> > > > -
> > > > ??static struct platform_driver altera_pcie_driver =3D {
> > > > ??	.probe		=3D altera_pcie_probe,
> > > > ??	.driver =3D {
--=-9hhI7CMo5Fjw/E4pBMop
Content-Disposition: attachment; filename="0001-PCI-altera-Fixed-sparse-warning.patch"
Content-Type: text/x-patch; name="0001-PCI-altera-Fixed-sparse-warning.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSA1NDlkNjhmN2U4OTVkNzA0YTgzYzJmOTdiMzdiNGI2M2Y2OTQxNjg5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMZXkgRm9vbiBUYW4gPGxleS5mb29uLnRhbkBpbnRlbC5jb20+
CkRhdGU6IE1vbiwgNCBNYXIgMjAxOSAxNDoyODowMyArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIFBD
STogYWx0ZXJhOiBGaXhlZCBzcGFyc2Ugd2FybmluZwoKd2FybmluZzogaW5jb3JyZWN0IHR5cGUg
aW4gaW5pdGlhbGl6ZXIgKGRpZmZlcmVudCBhZGRyZXNzIHNwYWNlcykKClNpZ25lZC1vZmYtYnk6
IExleSBGb29uIFRhbiA8bGV5LmZvb24udGFuQGludGVsLmNvbT4KLS0tCiBkcml2ZXJzL3BjaS9j
b250cm9sbGVyL3BjaWUtYWx0ZXJhLmMgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJv
bGxlci9wY2llLWFsdGVyYS5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLWFsdGVyYS5j
CmluZGV4IDE0ZTVkOTUyNDE0Mi4uMTBlMmY5ZjAzODg4IDEwMDY0NAotLS0gYS9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL3BjaWUtYWx0ZXJhLmMKKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9w
Y2llLWFsdGVyYS5jCkBAIC0zNjcsNyArMzY3LDcgQEAgc3RhdGljIGludCB0bHBfY2ZnX2R3b3Jk
X3dyaXRlKHN0cnVjdCBhbHRlcmFfcGNpZSAqcGNpZSwgdTggYnVzLCB1MzIgZGV2Zm4sCiBzdGF0
aWMgaW50IHMxMF9ycF9yZWFkX2NmZyhzdHJ1Y3QgYWx0ZXJhX3BjaWUgKnBjaWUsIGludCB3aGVy
ZSwKIAkJCSAgIGludCBzaXplLCB1MzIgKnZhbHVlKQogewotCXZvaWQgKmFkZHIgPSBTMTBfUlBf
Q0ZHX0FERFIocGNpZSwgd2hlcmUpOworCXZvaWQgX19pb21lbSAqYWRkciA9IFMxMF9SUF9DRkdf
QUREUihwY2llLCB3aGVyZSk7CiAKIAlzd2l0Y2ggKHNpemUpIHsKIAljYXNlIDE6CkBAIC0zODcs
NyArMzg3LDcgQEAgc3RhdGljIGludCBzMTBfcnBfcmVhZF9jZmcoc3RydWN0IGFsdGVyYV9wY2ll
ICpwY2llLCBpbnQgd2hlcmUsCiBzdGF0aWMgaW50IHMxMF9ycF93cml0ZV9jZmcoc3RydWN0IGFs
dGVyYV9wY2llICpwY2llLCB1OCBidXNubywKIAkJCSAgICBpbnQgd2hlcmUsIGludCBzaXplLCB1
MzIgdmFsdWUpCiB7Ci0Jdm9pZCAqYWRkciA9IFMxMF9SUF9DRkdfQUREUihwY2llLCB3aGVyZSk7
CisJdm9pZCBfX2lvbWVtICphZGRyID0gUzEwX1JQX0NGR19BRERSKHBjaWUsIHdoZXJlKTsKIAog
CXN3aXRjaCAoc2l6ZSkgewogCWNhc2UgMToKLS0gCjIuMTkuMAoK


--=-9hhI7CMo5Fjw/E4pBMop--
