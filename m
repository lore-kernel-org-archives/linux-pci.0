Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EB3C46464
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E0C2085B
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ir9cl8ZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E0C2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbeKFWob (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:44:31 -0500
Received: from mail-ve1eur01on0077.outbound.protection.outlook.com ([104.47.1.77]:13585
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729728AbeKFWob (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Nov 2018 17:44:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JB1S9SmarCguAU4eQt5YuI7NtTxSkYTRWtQlAqJHzw=;
 b=Ir9cl8ZM/auvqPwgDwlV8ahOihtAbjDZLDOs7Pv3WtQaDXYjI3NpltFlyfqEpr/97JMbMTirpEi2bvLNnSWu69fN9aWKLGm0bm4iXZuHzWPTEMnDKMq/h3wIh09RoawVbZOx+vGdE6/rcMfZ0lGCM14O+yhD94yrbfdV8zAP9Ig=
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com (10.162.155.27) by
 DB5PR04MB0984.eurprd04.prod.outlook.com (10.161.196.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Tue, 6 Nov 2018 13:19:13 +0000
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb]) by DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb%2]) with mapi id 15.20.1273.035; Tue, 6 Nov 2018
 13:19:13 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCH 01/23] PCI: mobiveil: uniform the register accessors
Thread-Topic: [PATCH 01/23] PCI: mobiveil: uniform the register accessors
Thread-Index: AQHUddNPQtKfGnE9Y0iqnS6q0DlZPQ==
Date:   Tue, 6 Nov 2018 13:19:12 +0000
Message-ID: <20181106131807.29951-2-Zhiqiang.Hou@nxp.com>
References: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0008.apcprd03.prod.outlook.com
 (2603:1096:203:2e::20) To DB5PR04MB1221.eurprd04.prod.outlook.com
 (2a01:111:e400:51c2::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB5PR04MB0984;6:j9x4gbzeGYqdZu+D64E9XE6rW3NYSyuMFFQXtyu8xcmD3IFIdLw/o3bwWsSUBfd+aDA6draJvps0bGwgh2P1bm5rHxHaDuN2EgjS6jZcByx5pHSz9N3Ee3E78TzSN8XXPifrojkNqMAEQCP1rTy7aKwMA4Z53uhfvbeYOkYgQykO5U0U+60OKv7AZRNPsE0cUq/6N5i/SD7lmEPk2a6Z6L/Dhz87oZ7kFVjlPaxxzZkfSVpqhvnxrjsSi4j533gWev3/1ZsdK90YV9e8cGHwhbr3HNp9LH9nWOf6JsmWqSUpBFsVuIqgElok5oOsSSHtjUFFI8+TjM1F7G/2je3BgomJ7Rj/EJ4c6tR8l9ghR44x2pUYbooSmebt42V+fWrcYW2MvxcxmoC18WW5VKuFrvFzPsvioJtz6wgpuYot2Zex29WpUbe7FImzOEIZ2tV+tCt7LPfB9I/x4yRJwBNVrw==;5:I2X/vaBRmng0c4BM/4bVFw1LkTKuMfRG4FpXEzx6c1oRzng+YdKlfUpqVJafr6iblSfT80SrTNp7Kam9UnJQj6ALPue6CQyJiGG6G3Wv7hI+6paioTVfstCINU2FoAliWmp3khu9aUbHla59CbGv/wmzQXPIvnciePdh7c8Bzlk=;7:MxvyPmuMMFM03sDfXLD6Z/WReYjlpt8lkTC+B3G+PnXI5HR/wnCbnUiEvw2Z9GKaQEw+7ABIEUhIGTN1mMFgVqT8Fi12DJ6OcXG/OBZOyilaeEv5hOyELUlDSKCGB7A13MtQ/VU5EF64amOIkRrzdA==
x-ms-office365-filtering-correlation-id: 618cbdde-f96b-4359-ff95-08d643ea718a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB0984;
x-ms-traffictypediagnostic: DB5PR04MB0984:
x-microsoft-antispam-prvs: <DB5PR04MB098494974F956DEB44101B2284CB0@DB5PR04MB0984.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB5PR04MB0984;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB0984;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(366004)(136003)(396003)(199004)(189003)(68736007)(486006)(386003)(8936002)(3846002)(99286004)(71190400001)(81156014)(71200400001)(81166006)(53936002)(8676002)(105586002)(110136005)(54906003)(5660300001)(2616005)(446003)(11346002)(66066001)(97736004)(305945005)(7416002)(476003)(2900100001)(7736002)(106356001)(14444005)(2201001)(4326008)(2501003)(25786009)(1076002)(186003)(6486002)(26005)(2906002)(256004)(6512007)(575784001)(36756003)(6116002)(6436002)(316002)(102836004)(52116002)(6506007)(86362001)(14454004)(76176011)(478600001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB0984;H:DB5PR04MB1221.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: D0vuB2pui/Jc4ysGG0r4vdQgytmaAPfLx84qJT/sDOK+zrZ1IudeQwvVRN9a9qNwqsedKhJ6353A914EC3ed/tIim1Zm857yotbygiwI+lBgTqTWmoOgabmElzEEnf3TIYkcdpW9THfsZS3gogXCvvoMITpjn7gvwPAw9x0LcCBI5x3K1xJnuRuU4Cd88zmcL6Xh8etdHvN68Yj99HX4yoIjJ6A+VCVINRFCDfjxSuy14C7p0+CfXMmAAZZ7t7Lnj0vycbV77707v1kJKjSnOjPAHAFLLkMmthzbckPNHj4bZ27MqNdgbZb8vDoImDzif5+mO7OxtTyTWQVPcOMzbCXoNzSKKe09cKTAhKMpEHs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 618cbdde-f96b-4359-ff95-08d643ea718a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 13:19:13.0931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB0984
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

It's confused that R/W some registers by csr_readl()/csr_writel(),
while others by read_paged_register()/write_paged_register().
Actually the low 3KB of 4KB PCIe configure space can be accessed
directly and high 1KB is paging area. So this patch uniformed the
register accessors to csr_readl() and csr_writel() by comparing
the register offset with page access boundary 3KB in the accessor
internal.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/pci/controller/pcie-mobiveil.c | 179 +++++++++++++++++--------
 1 file changed, 124 insertions(+), 55 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index 77052a0712d0..d55c7e780c6e 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -47,7 +47,6 @@
 #define  PAGE_SEL_SHIFT	13
 #define  PAGE_SEL_MASK		0x3f
 #define  PAGE_LO_MASK		0x3ff
-#define  PAGE_SEL_EN		0xc00
 #define  PAGE_SEL_OFFSET_SHIFT	10
=20
 #define PAB_AXI_PIO_CTRL	0x0840
@@ -117,6 +116,12 @@
 #define LINK_WAIT_MIN	90000
 #define LINK_WAIT_MAX	100000
=20
+#define PAGED_ADDR_BNDRY			0xc00
+#define OFFSET_TO_PAGE_ADDR(off)		\
+	((off & PAGE_LO_MASK) | PAGED_ADDR_BNDRY)
+#define OFFSET_TO_PAGE_IDX(off)			\
+	((off >> PAGE_SEL_OFFSET_SHIFT) & PAGE_SEL_MASK)
+
 struct mobiveil_msi {			/* MSI information */
 	struct mutex lock;		/* protect bitmap variable */
 	struct irq_domain *msi_domain;
@@ -145,15 +150,119 @@ struct mobiveil_pcie {
 	struct mobiveil_msi msi;
 };
=20
-static inline void csr_writel(struct mobiveil_pcie *pcie, const u32 value,
-		const u32 reg)
+/*
+ * mobiveil_pcie_sel_page - routine to access paged register
+ *
+ * Registers whose address greater than PAGED_ADDR_BNDRY (0xc00) are paged=
,
+ * for this scheme to work extracted higher 6 bits of the offset will be
+ * written to pg_sel field of PAB_CTRL register and rest of the lower 10
+ * bits enabled with PAGED_ADDR_BNDRY are used as offset of the register.
+ */
+static void mobiveil_pcie_sel_page(struct mobiveil_pcie *pcie, u8 pg_idx)
 {
-	writel_relaxed(value, pcie->csr_axi_slave_base + reg);
+	u32 val;
+
+	val =3D readl(pcie->csr_axi_slave_base + PAB_CTRL);
+	val &=3D ~(PAGE_SEL_MASK << PAGE_SEL_SHIFT);
+	val |=3D (pg_idx & PAGE_SEL_MASK) << PAGE_SEL_SHIFT;
+
+	writel(val, pcie->csr_axi_slave_base + PAB_CTRL);
 }
=20
-static inline u32 csr_readl(struct mobiveil_pcie *pcie, const u32 reg)
+static void *mobiveil_pcie_comp_addr(struct mobiveil_pcie *pcie, u32 off)
 {
-	return readl_relaxed(pcie->csr_axi_slave_base + reg);
+	if (off < PAGED_ADDR_BNDRY) {
+		/* For directly accessed registers, clear the pg_sel field */
+		mobiveil_pcie_sel_page(pcie, 0);
+		return pcie->csr_axi_slave_base + off;
+	}
+
+	mobiveil_pcie_sel_page(pcie, OFFSET_TO_PAGE_IDX(off));
+	return pcie->csr_axi_slave_base + OFFSET_TO_PAGE_ADDR(off);
+}
+
+static int mobiveil_pcie_read(void __iomem *addr, int size, u32 *val)
+{
+	if ((uintptr_t)addr & (size - 1)) {
+		*val =3D 0;
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+
+	switch (size) {
+	case 4:
+		*val =3D readl(addr);
+		break;
+	case 2:
+		*val =3D readw(addr);
+		break;
+	case 1:
+		*val =3D readb(addr);
+		break;
+	default:
+		*val =3D 0;
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int mobiveil_pcie_write(void __iomem *addr, int size, u32 val)
+{
+	if ((uintptr_t)addr & (size - 1))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	switch (size) {
+	case 4:
+		writel(val, addr);
+		break;
+	case 2:
+		writew(val, addr);
+		break;
+	case 1:
+		writeb(val, addr);
+		break;
+	default:
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static u32 csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)
+{
+	void *addr;
+	u32 val;
+	int ret;
+
+	addr =3D mobiveil_pcie_comp_addr(pcie, off);
+
+	ret =3D mobiveil_pcie_read(addr, size, &val);
+	if (ret)
+		dev_err(&pcie->pdev->dev, "read CSR address failed\n");
+
+	return val;
+}
+
+static void csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off, size_t=
 size)
+{
+	void *addr;
+	int ret;
+
+	addr =3D mobiveil_pcie_comp_addr(pcie, off);
+
+	ret =3D mobiveil_pcie_write(addr, size, val);
+	if (ret)
+		dev_err(&pcie->pdev->dev, "write CSR address failed\n");
+}
+
+static u32 csr_readl(struct mobiveil_pcie *pcie, u32 off)
+{
+	return csr_read(pcie, off, 0x4);
+}
+
+static void csr_writel(struct mobiveil_pcie *pcie, u32 val, u32 off)
+{
+	csr_write(pcie, val, off, 0x4);
 }
=20
 static bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie)
@@ -342,45 +451,6 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie=
 *pcie)
 	return 0;
 }
=20
-/*
- * select_paged_register - routine to access paged register of root comple=
x
- *
- * registers of RC are paged, for this scheme to work
- * extracted higher 6 bits of the offset will be written to pg_sel
- * field of PAB_CTRL register and rest of the lower 10 bits enabled with
- * PAGE_SEL_EN are used as offset of the register.
- */
-static void select_paged_register(struct mobiveil_pcie *pcie, u32 offset)
-{
-	int pab_ctrl_dw, pg_sel;
-
-	/* clear pg_sel field */
-	pab_ctrl_dw =3D csr_readl(pcie, PAB_CTRL);
-	pab_ctrl_dw =3D (pab_ctrl_dw & ~(PAGE_SEL_MASK << PAGE_SEL_SHIFT));
-
-	/* set pg_sel field */
-	pg_sel =3D (offset >> PAGE_SEL_OFFSET_SHIFT) & PAGE_SEL_MASK;
-	pab_ctrl_dw |=3D ((pg_sel << PAGE_SEL_SHIFT));
-	csr_writel(pcie, pab_ctrl_dw, PAB_CTRL);
-}
-
-static void write_paged_register(struct mobiveil_pcie *pcie,
-		u32 val, u32 offset)
-{
-	u32 off =3D (offset & PAGE_LO_MASK) | PAGE_SEL_EN;
-
-	select_paged_register(pcie, offset);
-	csr_writel(pcie, val, off);
-}
-
-static u32 read_paged_register(struct mobiveil_pcie *pcie, u32 offset)
-{
-	u32 off =3D (offset & PAGE_LO_MASK) | PAGE_SEL_EN;
-
-	select_paged_register(pcie, offset);
-	return csr_readl(pcie, off);
-}
-
 static void program_ib_windows(struct mobiveil_pcie *pcie, int win_num,
 		int pci_addr, u32 type, u64 size)
 {
@@ -397,19 +467,19 @@ static void program_ib_windows(struct mobiveil_pcie *=
pcie, int win_num,
 	pio_ctrl_val =3D csr_readl(pcie, PAB_PEX_PIO_CTRL);
 	csr_writel(pcie,
 		pio_ctrl_val | (1 << PIO_ENABLE_SHIFT), PAB_PEX_PIO_CTRL);
-	amap_ctrl_dw =3D read_paged_register(pcie, PAB_PEX_AMAP_CTRL(win_num));
+	amap_ctrl_dw =3D csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
 	amap_ctrl_dw =3D (amap_ctrl_dw | (type << AMAP_CTRL_TYPE_SHIFT));
 	amap_ctrl_dw =3D (amap_ctrl_dw | (1 << AMAP_CTRL_EN_SHIFT));
=20
-	write_paged_register(pcie, amap_ctrl_dw | lower_32_bits(size64),
-				PAB_PEX_AMAP_CTRL(win_num));
+	csr_writel(pcie, amap_ctrl_dw | lower_32_bits(size64),
+		   PAB_PEX_AMAP_CTRL(win_num));
=20
-	write_paged_register(pcie, upper_32_bits(size64),
-				PAB_EXT_PEX_AMAP_SIZEN(win_num));
+	csr_writel(pcie, upper_32_bits(size64),
+		   PAB_EXT_PEX_AMAP_SIZEN(win_num));
=20
-	write_paged_register(pcie, pci_addr, PAB_PEX_AMAP_AXI_WIN(win_num));
-	write_paged_register(pcie, pci_addr, PAB_PEX_AMAP_PEX_WIN_L(win_num));
-	write_paged_register(pcie, 0, PAB_PEX_AMAP_PEX_WIN_H(win_num));
+	csr_writel(pcie, pci_addr, PAB_PEX_AMAP_AXI_WIN(win_num));
+	csr_writel(pcie, pci_addr, PAB_PEX_AMAP_PEX_WIN_L(win_num));
+	csr_writel(pcie, 0, PAB_PEX_AMAP_PEX_WIN_H(win_num));
 }
=20
 /*
@@ -437,8 +507,7 @@ static void program_ob_windows(struct mobiveil_pcie *pc=
ie, int win_num,
 	csr_writel(pcie, 1 << WIN_ENABLE_SHIFT | type << WIN_TYPE_SHIFT |
 			lower_32_bits(size64), PAB_AXI_AMAP_CTRL(win_num));
=20
-	write_paged_register(pcie, upper_32_bits(size64),
-				PAB_EXT_AXI_AMAP_SIZE(win_num));
+	csr_writel(pcie, upper_32_bits(size64), PAB_EXT_AXI_AMAP_SIZE(win_num));
=20
 	/*
 	 * program AXI window base with appropriate value in
--=20
2.17.1

