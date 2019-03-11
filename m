Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5C2C43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA6B2084D
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AVZaeiFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfCKJbS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:31:18 -0400
Received: from mail-eopbgr130051.outbound.protection.outlook.com ([40.107.13.51]:7691
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727026AbfCKJbS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 05:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yE/+sI1z9N9q1s0rB4pdxVIkHsTsqWxTGUE8KouewAc=;
 b=AVZaeiFXB82kpqpEVlEhYMwIZA2doV51TH8GpAXXI2iT3mDC0YWpB2ZToZdZ8/s2yaLJyRlwokGNYpLpd954oluCrYokHDmS3pN5R75VLT6j5lG8JjP0xGrHz6RPRT3lT6grfJKm3yQVoqPZ4Ei8aV9B8Czo6moK516dxwcMD+I=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5592.eurprd04.prod.outlook.com (20.178.87.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 09:31:08 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 09:31:08 +0000
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
Subject: [PATCHv4 09/28] PCI: mobiveil: correct inbound/outbound window setup
 routines
Thread-Topic: [PATCHv4 09/28] PCI: mobiveil: correct inbound/outbound window
 setup routines
Thread-Index: AQHU1+0oL7MapNPz0EOtrgg+R8OzwA==
Date:   Mon, 11 Mar 2019 09:31:08 +0000
Message-ID: <20190311093130.7209-10-Zhiqiang.Hou@nxp.com>
References: <20190311093130.7209-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190311093130.7209-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:203:2e::27) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:ad::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1de001e-1211-4a93-bb5b-08d6a6044a60
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5592;
x-ms-traffictypediagnostic: AM6PR04MB5592:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB5592;23:rT0RigL4WQFb3f9uu2mpVC1M6dsmfI38lHrmkoY?=
 =?iso-8859-1?Q?tlaiPuZbjjdSOwmTv8/zC1FbFSunoI+lIGD+FRgn9cDGo09f9JIz4I1pmt?=
 =?iso-8859-1?Q?DV8SN+rIeGXkmUNgksdxemhxDr39GEeaKQdVxlppVIf/Ifb9VDj0VTxuSU?=
 =?iso-8859-1?Q?qL+y57YFrngt6LarhCmoY15wr5dWqsZMZeN6LrWengQ27zHGobO/jY8k1u?=
 =?iso-8859-1?Q?H9IPBjIO6w54MrK2ddA72FqLQ6nSurpMuYFM2mtXkJOewMeZuPpd9+VM5z?=
 =?iso-8859-1?Q?87hEhH77MoKJP+VJo0323m9aYu4AI9qyT0dQJKL/JrSlQaz91fCraeeaU+?=
 =?iso-8859-1?Q?+2WFJc9iIwBYaxqmLU8jkJrnL4uf5xwPvFwcjLFkGzAsGzFVqVRgCV2NVx?=
 =?iso-8859-1?Q?rctyV8LOmpjGZocYVEVyTejZ11rqZXhJuDSWJ3EOqwAAUETMNpr4jrTb9P?=
 =?iso-8859-1?Q?VmDrHwQSEaQJ07ugCLA/kw+fjsHDdyVAjmcjKR4ff3dLAF3dP+F93UHQfC?=
 =?iso-8859-1?Q?BTW6OycXyAn59D5nVGJc2MQve7xhyVrnqPFG7a2lffWsIb+7IXaawI4633?=
 =?iso-8859-1?Q?h9Cef/goiskDe1xrPLmdolCYzXFEx+UZJIyuZyFdEWyM2QoFKWIVJw70BQ?=
 =?iso-8859-1?Q?ZpUv1PEo6LVin2HY33H7GJRUv4KZLezJ9c+OA9J6EU5kH57bANl2AnqYe7?=
 =?iso-8859-1?Q?lRgMTxjcgH67ZrJz5PDRN8POW3fBzaEfb/iRHQUvl1C+F66VFGeMYtNLfJ?=
 =?iso-8859-1?Q?F4cyK1ObduGUbw0BzIAKRDXnd84RIz98sqcrht21cMgGlpj/AR4DDTVTHV?=
 =?iso-8859-1?Q?vSUS74aY7RcYiMMdAapdayiNdpfQEyuIwUiBz8LSR4ZyqEe5149bNqN98D?=
 =?iso-8859-1?Q?4/0pr7SG/dcLFGMqL9U86qqerq04RUivUu+UsyQHySd65AmVA8B1SsfNjo?=
 =?iso-8859-1?Q?7TThtBFW29nRgI0ECVp6wNu2atnvchMx3sqPuC8MWox3DX/ibiOQF4VMox?=
 =?iso-8859-1?Q?ewjVtE6ZPsZR2rhdgAHSGcFa9ciP7N2AkMit5CDdD1YHQbL4LLMb4Rp0za?=
 =?iso-8859-1?Q?sEqKvUuQU13dt8DnrN9zZJPvkywQlo5eXjMfSXyES2wueQyq0Y9KH788Ru?=
 =?iso-8859-1?Q?/lbwN4wK18LVWl9ezezSHFCfriJ0VXJjheBvdtekV+7RKktLend2TxxXSd?=
 =?iso-8859-1?Q?+uFmUui/pxEQOU+PDHLv9yU/VrGEzq5s+iAE0L/5mEjpTH3B1xkwfNwR+/?=
 =?iso-8859-1?Q?NcP2oVC+l2dLcuqBQ0gAeXe94HjFycoUhi9qj9wwIo4f3uFCd46NaLotCe?=
 =?iso-8859-1?Q?PZhAdGbCI7cWJdV3xvyErgk5yizdODUwEUEssz4v5KnWprJg3ZWJHqCSQo?=
 =?iso-8859-1?Q?dPxsYmKE=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB5592EAFB764151570AD5E15784480@AM6PR04MB5592.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(136003)(39860400002)(199004)(189003)(5660300002)(4326008)(2201001)(8676002)(478600001)(81166006)(81156014)(14454004)(86362001)(8936002)(50226002)(7416002)(256004)(1076003)(71200400001)(71190400001)(2616005)(476003)(486006)(11346002)(446003)(186003)(305945005)(7736002)(97736004)(68736007)(66066001)(36756003)(6486002)(105586002)(106356001)(6436002)(6512007)(110136005)(76176011)(54906003)(52116002)(99286004)(26005)(386003)(6506007)(3846002)(316002)(6116002)(102836004)(6346003)(25786009)(53936002)(2906002)(2501003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5592;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dqc7WT5TwWOtTXERj2W6Z5tbV8Dj0BitHONpzvgJGW8tU+74l7x6xnqLP6QX5ZYPIPhVpH5LZapzy3g4MBTniY5Pn9LJ0ylWoz+tlhhsijUUh0AtOx2d7xyN0lgSscbrcSkJUp3O3ldtWt/r0dWv8GFXLyyGUx7JZK1WMtnKqKxDaSUva89kCrtvriHdreo8a08/nogSeKd+S5hW7PXUWG0ZpNTWwcY6ag2LV2pRA6C4sfYQj/JMXDu0gSojgN2jOAYR2Dedtj2mOFK6WAaj+thjUYp7RSQnzmpY/ACexx4rQKSvyj4AznSX1X2nn7ygWdtS2gFQr5T7I01wCYVUTyilOUBIfadLaur1vyFJlpZavKKL80bblrXzH1BdWOKrR4Zz8A53lXS4HWGbSs+L/NMd1o1O8rYO/McaANMTX24=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1de001e-1211-4a93-bb5b-08d6a6044a60
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 09:31:08.2490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5592
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
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
V4:
 - no change

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

