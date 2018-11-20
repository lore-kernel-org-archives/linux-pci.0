Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C186C18DF5
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4976A2075B
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FTZ51UYF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4976A2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbeKTTyq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:54:46 -0500
Received: from mail-eopbgr70059.outbound.protection.outlook.com ([40.107.7.59]:1760
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726716AbeKTTyp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 14:54:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uv7d7aRXjXXLBi9qVH1Wav4d3eWy/uugc2EqsvYzyEA=;
 b=FTZ51UYFEgObqFMWFXxhlUEUD8GpPFqB5fEE91COPITjonqbeefl5cqBInaHbNE+w7NAHrz7BEr3aK4nSs1codoVYZE5GWEjdnVhzzuPkpxM/4XAViOEd2rqi1P+yLtiIScWGTTvDiulK+NB0od7yfdufhegD0UNECQ2zMV3W6M=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB5269.eurprd04.prod.outlook.com (20.177.35.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.21; Tue, 20 Nov 2018 09:26:31 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c%4]) with mapi id 15.20.1339.026; Tue, 20 Nov 2018
 09:26:31 +0000
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
Subject: [PATCHv2 09/25] PCI: mobiveil: correct inbound/outbound window setup
 routines
Thread-Topic: [PATCHv2 09/25] PCI: mobiveil: correct inbound/outbound window
 setup routines
Thread-Index: AQHUgLMfzg72EygTE02IZiCF1pLIHA==
Date:   Tue, 20 Nov 2018 09:26:31 +0000
Message-ID: <20181120092615.11680-10-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5269;6:WdihQqDyxyYuH7aSwHQii/wp1jq+OZkim/hFXtCPUkKfij2ske73pXxJfgR60gDpxmYvm5XQe7fL9fHh+f6AsDnIFKWvoo2RXUfqKjqLoRQs7xN0eZ/BATsKJ5h+/5wVguYBX2h7UUiTvsU9dezt22FVQNSR9rqU+d6XbC6HMRG5jlifpQ6GFMBd+FKrEZq+DYM3HekYzS30fiau8V/kOlBllfHgRcUTQYEvqRkjjL16lkM7h0Pq1xhaWBI4QPpPfxQsjrAG6ifiAHbr1mGJw6KfWqyP3HhXmlfpPH6ikQeZ+ZV4ceyFkTE0LbhdVZdD5xlsN0fA0pSw36jClFe9EQ+lEbtRVpVDLGui5lB2q9PNvVp6/1GZzWLtqcgoJRR9srcgTCG2NSZm2hY3YqpeQ716QgvBeTUoCj/K5RRLakd9ZX4iNtfbPnSR+ulyFyR7CFljHy4fbT03dYarxvT8+A==;5:SjRq9rCtQ1XGsKI0AJICR32/bNLto1KIvhcVrV5EOLMCR+HeHCdAU2f3xpHqs5lssuIpdZJDkIE3+J0H2Qh++gFz43DOAg9GLNnxm9FlkmFPw9JRdsUkoedS2MPmaIDB2GT1SMkEgnpVRq9dbWfptqpx0HNV8FhHgbIVc63U9Kw=;7:HtrVDOLkg21ns8xCN68u/AxwAZtv4+iPJ89fqieSXdEA9NL9JBTU9Cgh35Zjyk0t6n/E6iMq55hZhhVtDGZAo5Fn+ejoITP96LvhvUtBvOX3PEd7NYpDuSsAW2nBueE5tMIPzA2H1dCtGhQJtIpYow==
x-ms-office365-filtering-correlation-id: 5d824447-a65f-4cea-2c15-08d64eca41dd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5269;
x-ms-traffictypediagnostic: AM6PR04MB5269:
x-microsoft-antispam-prvs: <AM6PR04MB5269BFEDDB9216C3AE0080D284D90@AM6PR04MB5269.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5269;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5269;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(346002)(376002)(136003)(396003)(366004)(39860400002)(189003)(199004)(305945005)(7736002)(36756003)(5660300001)(7416002)(68736007)(2906002)(4326008)(8936002)(14454004)(256004)(54906003)(53936002)(6436002)(71200400001)(110136005)(71190400001)(6512007)(316002)(2616005)(476003)(446003)(11346002)(486006)(25786009)(2501003)(2201001)(86362001)(575784001)(52116002)(76176011)(6506007)(102836004)(386003)(186003)(106356001)(26005)(2900100001)(81156014)(81166006)(105586002)(6486002)(8676002)(99286004)(66066001)(6116002)(3846002)(1076002)(478600001)(97736004)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5269;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: daiOWTPkIPX/bIFZdU6bXfx5GdfC5WRlZmQ41Us9isdyxo+xZ0Bsf287+j4hC7Oe+Hn+R99+9u1k9xxCLDAQtVxlS03u0mdAzdWknaEEFgdlsZaqS0A2wvg0id33HybBJ7lwYzKtSb2YmJImQQoVTw2U4KWj5KY11Wr6UFmo3lvmnEIzWIgQWQX/M9HFwqazTyNrovdFUjtkBqRLp8D17Dlxck5fTtmFty3URbANDHSh5xV3u8K39YJDy6NcYmuVsNH+WOytYBmdsdV+yAlP5roONrkjGWOIW87fm1+GqpT0WH/FIMJ13Cnqvw/2K82HQf4BcDPc9pDq5tLI735JDBkgFJLw1Ckjh1RldrPp7og=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d824447-a65f-4cea-2c15-08d64eca41dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 09:26:31.8002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5269
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Outbound window routine:
 - Removed unused var definition and register read operations.
 - Added the upper 32-bit cpu address setup of the window.
 - Instead of blindly write, only change the fields specified.
 - Masked the lower bits of window size in case override the
   control bits.
 - Check if the passing window number is available, instead of
   the total number of the initialized windows.

Inbound window routine:
 - Added parameter 'u64 cpu_addr' to specify the cpu address
   of the window instead of using 'pci_addr'.
 - Changed 'int pci_addr' to 'u64 pci_addr', and added setup
   of the upper 32-bit pci address of the window.
 - Moved the PCIe PIO master enablement to mobiveil_host_init().
 - Instead of blindly write, only change the fields specified.
 - Masked the lower bits of window size in case override the
   control bits.
 - Check if the passing window number is available, instead of
   the total number of the initialized windows.
 - And added the statistic of initialized inbound windows.

Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host
Bridge IP driver")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - Inbound window setup rountine: clear the size field before set it.

 drivers/pci/controller/pcie-mobiveil.c | 70 +++++++++++++++-----------
 1 file changed, 42 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index e88afc792a5c..4ba458474e42 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -65,9 +65,13 @@
 #define PAB_AXI_AMAP_CTRL(win)		PAB_REG_ADDR(0x0ba0, win)
 #define  WIN_ENABLE_SHIFT		0
 #define  WIN_TYPE_SHIFT			1
+#define  WIN_TYPE_MASK			0x3
+#define  WIN_SIZE_SHIFT			10
+#define  WIN_SIZE_MASK			0x3fffff
=20
 #define PAB_EXT_AXI_AMAP_SIZE(win)	PAB_EXT_REG_ADDR(0xbaf0, win)
=20
+#define PAB_EXT_AXI_AMAP_AXI_WIN(win)	PAB_EXT_REG_ADDR(0x80a0, win)
 #define PAB_AXI_AMAP_AXI_WIN(win)	PAB_REG_ADDR(0x0ba4, win)
 #define  AXI_WINDOW_ALIGN_MASK		3
=20
@@ -82,8 +86,10 @@
 #define PAB_PEX_AMAP_CTRL(win)		PAB_REG_ADDR(0x4ba0, win)
 #define  AMAP_CTRL_EN_SHIFT		0
 #define  AMAP_CTRL_TYPE_SHIFT		1
+#define  AMAP_CTRL_TYPE_MASK		3
=20
 #define PAB_EXT_PEX_AMAP_SIZEN(win)	PAB_EXT_REG_ADDR(0xbef0, win)
+#define PAB_EXT_PEX_AMAP_AXI_WIN(win)	PAB_EXT_REG_ADDR(0xb4a0, win)
 #define PAB_PEX_AMAP_AXI_WIN(win)	PAB_REG_ADDR(0x4ba4, win)
 #define PAB_PEX_AMAP_PEX_WIN_L(win)	PAB_REG_ADDR(0x4ba8, win)
 #define PAB_PEX_AMAP_PEX_WIN_H(win)	PAB_REG_ADDR(0x4bac, win)
@@ -455,49 +461,51 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pci=
e *pcie)
 }
=20
 static void program_ib_windows(struct mobiveil_pcie *pcie, int win_num,
-			       int pci_addr, u32 type, u64 size)
+			       u64 cpu_addr, u64 pci_addr, u32 type, u64 size)
 {
-	int pio_ctrl_val;
-	int amap_ctrl_dw;
+	u32 value;
 	u64 size64 =3D ~(size - 1);
=20
-	if ((pcie->ib_wins_configured + 1) > pcie->ppio_wins) {
+	if (win_num >=3D pcie->ppio_wins) {
 		dev_err(&pcie->pdev->dev,
 			"ERROR: max inbound windows reached !\n");
 		return;
 	}
=20
-	pio_ctrl_val =3D csr_readl(pcie, PAB_PEX_PIO_CTRL);
-	pio_ctrl_val |=3D 1 << PIO_ENABLE_SHIFT;
-	csr_writel(pcie, pio_ctrl_val, PAB_PEX_PIO_CTRL);
-
-	amap_ctrl_dw =3D csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
-	amap_ctrl_dw |=3D (type << AMAP_CTRL_TYPE_SHIFT) |
-			(1 << AMAP_CTRL_EN_SHIFT) |
-			lower_32_bits(size64);
-	csr_writel(pcie, amap_ctrl_dw, PAB_PEX_AMAP_CTRL(win_num));
+	value =3D csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
+	value &=3D ~(AMAP_CTRL_TYPE_MASK << AMAP_CTRL_TYPE_SHIFT |
+		 WIN_SIZE_MASK << WIN_SIZE_SHIFT);
+	value |=3D (type << AMAP_CTRL_TYPE_SHIFT) | (1 << AMAP_CTRL_EN_SHIFT) |
+		 (lower_32_bits(size64) & WIN_SIZE_MASK << WIN_SIZE_SHIFT);
+	csr_writel(pcie, value, PAB_PEX_AMAP_CTRL(win_num));
=20
 	csr_writel(pcie, upper_32_bits(size64),
 		   PAB_EXT_PEX_AMAP_SIZEN(win_num));
=20
-	csr_writel(pcie, pci_addr, PAB_PEX_AMAP_AXI_WIN(win_num));
+	csr_writel(pcie, lower_32_bits(cpu_addr),
+		   PAB_PEX_AMAP_AXI_WIN(win_num));
+	csr_writel(pcie, upper_32_bits(cpu_addr),
+		   PAB_EXT_PEX_AMAP_AXI_WIN(win_num));
+
+	csr_writel(pcie, lower_32_bits(pci_addr),
+		   PAB_PEX_AMAP_PEX_WIN_L(win_num));
+	csr_writel(pcie, upper_32_bits(pci_addr),
+		   PAB_PEX_AMAP_PEX_WIN_H(win_num));
=20
-	csr_writel(pcie, pci_addr, PAB_PEX_AMAP_PEX_WIN_L(win_num));
-	csr_writel(pcie, 0, PAB_PEX_AMAP_PEX_WIN_H(win_num));
+	pcie->ib_wins_configured++;
 }
=20
 /*
  * routine to program the outbound windows
  */
 static void program_ob_windows(struct mobiveil_pcie *pcie, int win_num,
-			       u64 cpu_addr, u64 pci_addr,
-			       u32 config_io_bit, u64 size)
+			       u64 cpu_addr, u64 pci_addr, u32 type, u64 size)
 {
=20
-	u32 value, type;
+	u32 value;
 	u64 size64 =3D ~(size - 1);
=20
-	if ((pcie->ob_wins_configured + 1) > pcie->apio_wins) {
+	if (win_num >=3D pcie->apio_wins) {
 		dev_err(&pcie->pdev->dev,
 			"ERROR: max outbound windows reached !\n");
 		return;
@@ -507,10 +515,12 @@ static void program_ob_windows(struct mobiveil_pcie *=
pcie, int win_num,
 	 * program Enable Bit to 1, Type Bit to (00) base 2, AXI Window Size Bit
 	 * to 4 KB in PAB_AXI_AMAP_CTRL register
 	 */
-	type =3D config_io_bit;
 	value =3D csr_readl(pcie, PAB_AXI_AMAP_CTRL(win_num));
-	csr_writel(pcie, 1 << WIN_ENABLE_SHIFT | type << WIN_TYPE_SHIFT |
-		   lower_32_bits(size64), PAB_AXI_AMAP_CTRL(win_num));
+	value &=3D ~(WIN_TYPE_MASK << WIN_TYPE_SHIFT |
+		 WIN_SIZE_MASK << WIN_SIZE_SHIFT);
+	value |=3D 1 << WIN_ENABLE_SHIFT | type << WIN_TYPE_SHIFT |
+		 (lower_32_bits(size64) & WIN_SIZE_MASK << WIN_SIZE_SHIFT);
+	csr_writel(pcie, value, PAB_AXI_AMAP_CTRL(win_num));
=20
 	csr_writel(pcie, upper_32_bits(size64), PAB_EXT_AXI_AMAP_SIZE(win_num));
=20
@@ -518,11 +528,10 @@ static void program_ob_windows(struct mobiveil_pcie *=
pcie, int win_num,
 	 * program AXI window base with appropriate value in
 	 * PAB_AXI_AMAP_AXI_WIN0 register
 	 */
-	value =3D csr_readl(pcie, PAB_AXI_AMAP_AXI_WIN(win_num));
-	csr_writel(pcie, cpu_addr & (~AXI_WINDOW_ALIGN_MASK),
+	csr_writel(pcie, lower_32_bits(cpu_addr) & (~AXI_WINDOW_ALIGN_MASK),
 		   PAB_AXI_AMAP_AXI_WIN(win_num));
-
-	value =3D csr_readl(pcie, PAB_AXI_AMAP_PEX_WIN_H(win_num));
+	csr_writel(pcie, upper_32_bits(cpu_addr),
+		   PAB_EXT_AXI_AMAP_AXI_WIN(win_num));
=20
 	csr_writel(pcie, lower_32_bits(pci_addr),
 		   PAB_AXI_AMAP_PEX_WIN_L(win_num));
@@ -604,6 +613,11 @@ static int mobiveil_host_init(struct mobiveil_pcie *pc=
ie)
 	value |=3D APIO_EN_MASK;
 	csr_writel(pcie, value, PAB_AXI_PIO_CTRL);
=20
+	/* Enable PCIe PIO master */
+	value =3D csr_readl(pcie, PAB_PEX_PIO_CTRL);
+	value |=3D 1 << PIO_ENABLE_SHIFT;
+	csr_writel(pcie, value, PAB_PEX_PIO_CTRL);
+
 	/*
 	 * we'll program one outbound window for config reads and
 	 * another default inbound window for all the upstream traffic
@@ -616,7 +630,7 @@ static int mobiveil_host_init(struct mobiveil_pcie *pci=
e)
 			   CFG_WINDOW_TYPE, resource_size(pcie->ob_io_res));
=20
 	/* memory inbound translation window */
-	program_ib_windows(pcie, WIN_NUM_0, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
+	program_ib_windows(pcie, WIN_NUM_0, 0, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
=20
 	/* Get the I/O and memory ranges from DT */
 	resource_list_for_each_entry(win, &pcie->resources) {
--=20
2.17.1

