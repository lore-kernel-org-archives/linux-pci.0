Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E267C32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41BC62086C
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qyJGIfoR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41BC62086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388387AbeKFWpU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:45:20 -0500
Received: from mail-eopbgr20055.outbound.protection.outlook.com ([40.107.2.55]:14549
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388368AbeKFWpU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Nov 2018 17:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6A//kSWAA3pV67hmBpmbuxuzUfqX8FwkLzvfGvYX7M=;
 b=qyJGIfoRV861U7z3Jacv+piM5mOgmsR4n/yy99AmE1ZwpiHZqsv+ITZJ45h8wWhPmLeqB8C3zqarZ2BQp79RgEPPel+MB+lveBEFzoGSoxFcNaZkoTLQo3pPKg+46eBX9/jWg/jUY4L4DqOUcmFO4UNwUtcSi4Q+TAMFSqc1/I0=
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com (10.162.155.27) by
 DB5PR04MB1414.eurprd04.prod.outlook.com (10.162.221.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Tue, 6 Nov 2018 13:20:04 +0000
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb]) by DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb%2]) with mapi id 15.20.1273.035; Tue, 6 Nov 2018
 13:20:04 +0000
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
Subject: [PATCH 09/23] PCI: mobiveil: correct the inbound/outbound window
 setup routine
Thread-Topic: [PATCH 09/23] PCI: mobiveil: correct the inbound/outbound window
 setup routine
Thread-Index: AQHUddNtMbL21S1CEEC9/74fdJoQhg==
Date:   Tue, 6 Nov 2018 13:20:04 +0000
Message-ID: <20181106131807.29951-10-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;DB5PR04MB1414;6:CPGlyQvdVpjBxYKeB9J/1afP1M+njcCRB5tH/dfEyDUGhv1wc6B6hkkArRRxYJe5qbymWlaVpRsG0vtMtIhmIg7CXJimIuibZLzWEgkZAXdmDvs5rm9Lx0s9/E1VzD+WWuc9nFECdLrJR9sgMdyImKlTKDi/2jr0BWQqhWBvU+wxIGzcdC3dySlffudakEVCz/Rrg4eLIRG9wdMMaZyGLEB4lHheEPnACzx33/7R9KJajsoQy0YUF8J8zmg1JsL7Qj2FVsunAvGiNo0rFFWNdJWHescfeLqlTB7JyqCf357l8BnKvCmzpQQsWZ7d9GGrn1a8NW/AEJ29kBpc+RQatvEtTuz7DOyeRTR7XGGlu1FcoMiFlbrVZPntUZQ8GTYgnl6S04Gb8tJeirfj5lZBnhuxJpD8MuRdXT58i2KdKoxuWayJ0H1ln5X8pjmtNyyTXz60n8oO7JXQ4Qxes6IvHQ==;5:Lje3RB1Bim7DWFQiboROOLocAshuBh8mNa+Q/kwjYyKfHF5eIjylXFqoFuoaGq4HKQ5nAZnA85f3EFP19hR0OvhLjHTyehqXNJfRwlcP4jemvVP3tEiwwFsSx8x3x8RI9AXjrk7S/DIDMN6UxsECDRJZnaYGIOvdb8Gn0/MRDpo=;7:lHAlME0PxQEuIg688ONbqabB3f1tahbp3y/4kT3r8R+T4gLrJpFZEdUmJmxxE/nY/nBR48Wc0VTNrHm3oHMVEukDXY1N9LffAUqBTos2siekF+b8hlxTP8Wjpuqmtz+/rkDQ2knXuZ1e16xikIA5mw==
x-ms-office365-filtering-correlation-id: a803228c-7357-4991-e1ae-08d643ea902e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1414;
x-ms-traffictypediagnostic: DB5PR04MB1414:
x-microsoft-antispam-prvs: <DB5PR04MB141489A79EC9913DDEBED23684CB0@DB5PR04MB1414.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB5PR04MB1414;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1414;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(97736004)(66066001)(8936002)(81156014)(81166006)(7416002)(8676002)(5660300001)(71200400001)(71190400001)(478600001)(6486002)(6116002)(2900100001)(1076002)(53936002)(6436002)(6512007)(305945005)(4326008)(25786009)(7736002)(105586002)(106356001)(68736007)(2906002)(3846002)(256004)(26005)(486006)(2501003)(14454004)(99286004)(52116002)(76176011)(36756003)(110136005)(386003)(6506007)(102836004)(54906003)(86362001)(186003)(446003)(575784001)(11346002)(316002)(2616005)(476003)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1414;H:DB5PR04MB1221.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xgnRhqXvoq9gXtf5bXV35V0aGytEcLIcXiSpART+XynKjNgPgd+QsQ3Std2A4AiEUz2rL/EyJb+Ww3UIltIYj3FMA8ybEvMoouzsYJJp8UOxAI9PwYLHd7mnUdKPjruFbUq73ogoXQ6iSS5Wj63aHO1jowLn28OJ27G+wq5pjYejVZMUcngyl5ldrmFrdgmuHs3Bmf8q+gQ1iiNH70Hzfx+BGXJCcraLbUoF//2mzP8kq3AUiSpNIErPZXDHwL8mZxl+CrRUJYkZ4GFeqvP3DAIZM9EI/et36lU161cKmeFWL5QkPzSYjUEqZWUsVEP+p2jJjCsgsHxqlmODxbV5REEpgYxrk5Mw48u1ZDzeOuU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a803228c-7357-4991-e1ae-08d643ea902e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 13:20:04.4527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1414
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

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/pci/controller/pcie-mobiveil.c | 69 +++++++++++++++-----------
 1 file changed, 41 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index e88afc792a5c..d03392940944 100644
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
@@ -455,49 +461,50 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pci=
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
+	value &=3D ~(AMAP_CTRL_TYPE_MASK << AMAP_CTRL_TYPE_SHIFT);
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
+	if (win_num  >=3D pcie->apio_wins) {
 		dev_err(&pcie->pdev->dev,
 			"ERROR: max outbound windows reached !\n");
 		return;
@@ -507,10 +514,12 @@ static void program_ob_windows(struct mobiveil_pcie *=
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
@@ -518,11 +527,10 @@ static void program_ob_windows(struct mobiveil_pcie *=
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
@@ -604,6 +612,11 @@ static int mobiveil_host_init(struct mobiveil_pcie *pc=
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
@@ -616,7 +629,7 @@ static int mobiveil_host_init(struct mobiveil_pcie *pci=
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

