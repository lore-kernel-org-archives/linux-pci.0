Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E30C169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADDB21841
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RQ6YSHhE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfA2IIk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:08:40 -0500
Received: from mail-eopbgr30089.outbound.protection.outlook.com ([40.107.3.89]:20736
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725468AbfA2IIk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 03:08:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YURbUw422ScAlv4SQ6d02/Q+xYwCuKhy824O9vETnG8=;
 b=RQ6YSHhEOgw5omCrqo4blcZ0spsUEWM40Rr+yWOI2r5vQpRTiKvDTCVacMPZ7DZQaKUYVZmqzS8IvstN/PwyzKfkUULq1Cxvj3Kzp0Loij77jI9HMlYJjAo59UbVPI1gxKfEzsdVk1LOhnmfJFTVW2bI8lL8nlvZzd5uCwCPODI=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5847.eurprd04.prod.outlook.com (20.179.3.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Tue, 29 Jan 2019 08:08:34 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:08:34 +0000
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
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCHv3 01/27] PCI: mobiveil: uniform the register accessors
Thread-Topic: [PATCHv3 01/27] PCI: mobiveil: uniform the register accessors
Thread-Index: AQHUt6nUdk4grkaopECRyHHb4VOFRQ==
Date:   Tue, 29 Jan 2019 08:08:34 +0000
Message-ID: <20190129080926.36773-2-Zhiqiang.Hou@nxp.com>
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:203:36::20) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:ad::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5847;6:pApE1Q8ldQUS8VpZ+P0lijVLKH4dwwg29XdlLDg5fZpufZJfjMFx8g3ecsTf9CwDcQ4547efq3Ufe0LM4Ul5li9h14V3rmJkK4g9eS18cvLfY2j01e5Wbu9W0laVkcCBwzgeQJ4KVYnRyqxce2lx/l1BUc4TMkLxAO5JFwjHid/3JQDh/tk8+DxSFknQuedj3LPVIiI0fsbQnKPi5oeuZDnT88aKTuDoD9/7zjCbWwdc3s+MFsAQI8vmLg8FwvXUU4BGW2tRJvaWhkjRafx884wAsi1PLNoLc+SFpMeVMyInMFzZtalyj6CQHzMP/gzjXd9pG4It0COk9HSz3rL9eixWfqOG/eFg6May1jX3Ir1u17/WAWuP8PFGF0FkMTmDxclxeOC4ViSInvw2kbR/ADqE8MRytUlxpKmZ+mGSROzWb3QwT8a9iPFhu5WtVPkS/UBU4kbQE6UjmA9vLyEWVg==;5:HJ/H5nxrNSccIQHaPFyb/NjMV73E0WJyK9Zmmc03lTNqhHkCaizVkoXlcCyGE1Nx/Hgb4mDHNmXmgQBhU17JE9YZZSA2d8wsNQWC4SCOgxBppK70TNz9M7uWfA4lhxcVKPc/82XPFFIHxHtvW+8Wy4FUD/wyKvOc759DhRZSRAnKJVUoJm2LQY0JT2J7DWImSwlZ/8gjt8JT6a6NuuzYhQ==;7:xgnVKJphIHgG8cBiRuvb4RkcOgXtdJLzrfuF89KPkGCwEZrN5aAxVOqvRSkFUFXrOJfTp3DU/eUMBFxREaCiA8SsPI4BRpWh3qNUvu+VdKWjx0Wp7p7Lj4Zs5Zu8mayEe5hHrfSkZgYEcWXlCd0pOw==
x-ms-office365-filtering-correlation-id: bd76ab15-84ee-4fb9-73cf-08d685c0f6f3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5847;
x-ms-traffictypediagnostic: AM6PR04MB5847:
x-microsoft-antispam-prvs: <AM6PR04MB5847B70925D763A14DC467C884970@AM6PR04MB5847.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(366004)(376002)(136003)(199004)(189003)(14444005)(14454004)(66066001)(478600001)(2616005)(6436002)(71200400001)(446003)(486006)(54906003)(11346002)(476003)(99286004)(110136005)(52116002)(256004)(6486002)(36756003)(6506007)(386003)(316002)(97736004)(26005)(102836004)(71190400001)(186003)(76176011)(81156014)(81166006)(7736002)(8676002)(3846002)(50226002)(305945005)(4326008)(7416002)(25786009)(1076003)(2906002)(53936002)(6116002)(86362001)(2201001)(105586002)(106356001)(8936002)(2501003)(68736007)(6512007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5847;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BlFymusaf79FmIAal+Vahf+ivz6tle722klMCWp7Tym8Gfi43vfctg41eOY4m2YVPrNjHVpqafy0IoRgSEoHs3wblL5Tm1OK7qfRnlr4S4guN+dd5iXh3gVpT12HEYKQHfhQ4KCD2dEUdJCPIpfdV2MaTYrhsG5yw2EbnXn3TX9TJ8VhhArPsTPVcLbt11Mk9WjMJOFy3ZAkFM9xc4GCY/eMy1QKsCqkEUPFc626ZAWTL1U67EYHAOj96SG0fFiDnJwgcK5fXohoKjk2a1G6pKImbFmfCUvGENBOnOsMZCyN4gzf3RWFPinQ5kUMUDdLJNQwCecnrON+RYAWkv9Laze5ezC46XSJVH2owdjlrUVoSmMQIumK5LnHCL4omSOWowXEzSSmcKR8GqTC+zBZVTGS53r2tWabJk5n1dPH+Kg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd76ab15-84ee-4fb9-73cf-08d685c0f6f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:08:28.6930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5847
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
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
V3:
 - No change

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

