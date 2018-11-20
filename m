Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D479BC43610
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880BE208E4
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SdnxsQ1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 880BE208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeKTTx6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:53:58 -0500
Received: from mail-eopbgr10082.outbound.protection.outlook.com ([40.107.1.82]:5555
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727008AbeKTTx6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 14:53:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLTcpwun8vauetbG2lYFQO++8wm+IH1mKhk6LkHhDms=;
 b=SdnxsQ1lhwpmu4IiG8N2gw/jLmkdKUQpfwrN4IzGdI3+RZh8SBe3YortjHajm9OvJqF0/d7JkNY10PbfzXZEwwzpZW3Q8/1VNeYqmRT521aour2VpB8wA0gmNYjudomDdo5OO5UCjWCfphkxeDoKxLOeIBjVsApinKOGfFlDgFU=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB4871.eurprd04.prod.outlook.com (20.177.33.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.25; Tue, 20 Nov 2018 09:25:41 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c%4]) with mapi id 15.20.1339.026; Tue, 20 Nov 2018
 09:25:41 +0000
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
Subject: [PATCHv2 01/25] PCI: mobiveil: uniform the register accessors
Thread-Topic: [PATCHv2 01/25] PCI: mobiveil: uniform the register accessors
Thread-Index: AQHUgLMBpsVARsSl+E+erRC6ybL4qw==
Date:   Tue, 20 Nov 2018 09:25:41 +0000
Message-ID: <20181120092615.11680-2-Zhiqiang.Hou@nxp.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR03CA0050.apcprd03.prod.outlook.com
 (2603:1096:202:17::20) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:aa::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4871;6:XBRqgQc/59AcU//uDVu5nHKWDcz3e5KDsLoZ2ZN+Z+PMnMEC05s78wd+0XKP3ebY2zwFDGCkFW4B15+pz0dj0UScvoBE7gxHMiA4Fjl910/++keJanopBeKHf9ru/pzD77M0zsgqQNv38jhHThEICU/AQ2is7UsAmz9yXXky5/nAlRbO1J3JnmaNLuUuSqHF2YoQfcUGfyBRaMnfjz/oI0BdLv4Sie0p4JzjFs2ZRzzC8Blh1s/rKlxZI8jZ0BWeoAi028BDoxyQcYG6OZUwGocSo6oNjlaKv31fm9/9vxcViSt9DilCoDzHLuOJKh7rgBS+xL+BsHL2Cxkf1VOoYWI/bxcAZBoh6i4TKSAsZsjqu7abVAcGoOHowlOT44doGLr91c7FUmoNBtVeAZJVE4FZXqPkXjhfiALbNo93vl0S74B+lhYceCw7nGdKuJD0XltYF1GByOjzBarqbs2a/g==;5:B5/kboEOdtvZ+wpeTTGBk7WiDfb5FwuD9InKVA7dJlvNImOpQded96HuYLi9+YG0JeOvyL1XaJMetYlr0FIqSRBM+5mPuyDHhSYAzuiLHMNZndzT+JN0CJefJZPd2efMfcCl4E+izh8BsEUEuclc1EfFkrjkhJWoFOZVqP5afI8=;7:U48JJAssWLr59jUZh8r5pjEOK7FWtABeZpftOQPG6Zk0JrZdmXxP0TnspHSdWVHJ5ECiS50/A28u173MJy7rwNlPCy3x3M7dGPJX+xegnpUXhWeCVZLccKD5HcsrcmwD0IWJIHCK8y0rG9NcE1AmUw==
x-ms-office365-filtering-correlation-id: 29a67e3d-ee6d-42fa-24d6-08d64eca2406
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4871;
x-ms-traffictypediagnostic: AM6PR04MB4871:
x-microsoft-antispam-prvs: <AM6PR04MB48719BD47FFE090F00218A4784D90@AM6PR04MB4871.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4871;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4871;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(396003)(366004)(136003)(199004)(189003)(2501003)(97736004)(6486002)(256004)(6506007)(68736007)(386003)(14444005)(86362001)(575784001)(2906002)(7416002)(2201001)(478600001)(106356001)(71190400001)(71200400001)(305945005)(105586002)(6436002)(66066001)(8676002)(8936002)(7736002)(81156014)(81166006)(4326008)(102836004)(2900100001)(316002)(14454004)(53936002)(6512007)(186003)(26005)(25786009)(11346002)(446003)(2616005)(36756003)(99286004)(476003)(3846002)(110136005)(1076002)(52116002)(5660300001)(6116002)(76176011)(486006)(54906003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4871;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZVZmwjpVRXp9oxmNFg6BqLP+4oLObTKh4Kl5MxJJ9bw6tNpHYTEhTXsCHzvXq6GCbyAITKjCsibk6cgO+sMUakoN+CjDfNt5VzXvHA53+tdMnUTVdJs4b/ucDNKsqRsAn74ZPGayRDlTpxTR/bTYBSpHR8hXsBdSTFQm/ut+VqHRnfJrEnV59ke+WW3l+aaKf/VRYDgRusHUPdMuiEMOw1madwUzf5NgICfdQqtzsvJ4QbaHbzyXUeHylT4PLzvM1OI63nm7aFOgnIyG02fR8Pzw0OSyTVvDbIVcwPY32yQ7MaGwmfPj1S8uSqp/cWvy1Rs2tjsCzG+zncU3TxMFx9rGvX6guR2Cxqvg8qebtV4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a67e3d-ee6d-42fa-24d6-08d64eca2406
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 09:25:41.6746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4871
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
V2:
 - no change

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

