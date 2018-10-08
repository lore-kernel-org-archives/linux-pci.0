Return-Path: <SRS0=j7M/=MU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D28C677D4
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 17:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 056C7213A2
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 17:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R81MvGoX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 056C7213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbeJIAv0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:51:26 -0400
Received: from mail-eopbgr40085.outbound.protection.outlook.com ([40.107.4.85]:22630
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726458AbeJIAv0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Oct 2018 20:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HP4g4zxVjQ8KR7f/XE6V7hH9QR/i939e9aNlvZf+o64=;
 b=R81MvGoXihsK3rhA6d+kEOgQApVflXOTYyqT3zS4TgTQtaWf8l5nbFlWsh66/drympJNX+ZSxzCvWHqN8pUcmjtWV6iudIvK+3LGIuQoSWAUwywgTq1ySVjl+Nzusu7iJPimAdqR+J9pQugEVw4M2pB3r/NqcK/SnVwzc5aMMhA=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4417.eurprd04.prod.outlook.com (52.135.148.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.26; Mon, 8 Oct 2018 17:38:35 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 17:38:35 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: [PATCH] PCI: imx: Add imx6sx suspend/resume support
Thread-Topic: [PATCH] PCI: imx: Add imx6sx suspend/resume support
Thread-Index: AQHUXy28c0CMdC4ep0yd8bBw3iPcCA==
Date:   Mon, 8 Oct 2018 17:38:34 +0000
Message-ID: <e57884e2dbc429918db81662ddbafe22c472385c.1539019758.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: AM3PR05CA0141.eurprd05.prod.outlook.com
 (2603:10a6:207:3::19) To AM0PR04MB4290.eurprd04.prod.outlook.com
 (2603:10a6:208:67::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4417;6:3k/kD/MOK9DyFGtPG+OK0epOTvKWsDO1ot8oHLSaiE3Lt/r1f1wkyP5p71IA2blWA88VEDAhCn2ba96LvkbBNB0zOeTNtcymU/1TETkR2rsZ7IzOFV48LA7M2NNzWWEmfXn+46anb30dVyR1r58OQwqSHRCGux9UMoiXq/d7O2BYTZs83meyOxPqIfiC7ZodIiIX0WIgh01vPv+oVbkB9AQ0XXeLBFIvFPx/qiQPKdeZUhdcofUCNZbcnCG+dZaL8OABOR1Mdt3OYaU3FzgB2FKMUR0CAv7jlY8ODsre6jBieZcxW93p1Ar8ggAfwWtt99kaA9OtHJ2B/pi044sRzQkHHaQcTp7gXfdk90DjEJS+BdeNaSlxSKezWbOxWDTC3HrwIbm+wExgULU31iwq7xdeC+IL7vh2hVt3Q5pWh0yOjxw4Vw0eKnqeWrOaCBSlxU7VGICUSLBobWLYe2ZVqQ==;5:eMwLThZvSybDPbWa94w2s+jpFJnMAiaRkan3oDC4Oxqap8/XurQuAUx+CeGQ/88eROQuyJ19eOBxuMv/hiVFzeARlU0j3Z3EfwW7zelenL62wzmUcM5/AhHQXFF9lH/x2wMP2v2/trUJ0NleNLXdjP2nvwQF0rVmzTXO6INbNDE=;7:E1QsgP8iZRv7YPFGDl45o6erxu1zl3ebgYMOk9JPj5dx3ZPP7yE9CLuAW9aNMak9LAlNjm3ZodT5OmpRUJs7+bM7jDk9jE9EIH4JH7MPA6kTJ5an5N0a4HHPlCYbfOAXuKy9gEfngXXv9B57Izxeq5NJITZd1O6Ll+PrQQuWenSiVqGtzTpp68SJedG1aaRvVMCV9cbCVcA+gIjoWoNtBbr8NzwWcQp1bYxzEJNF+DdlPe8WoSLgsHxrToUhUGmB
x-ms-office365-filtering-correlation-id: 29959289-660d-4cf5-c3fb-08d62d44df2c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4417;
x-ms-traffictypediagnostic: AM0PR04MB4417:
x-microsoft-antispam-prvs: <AM0PR04MB4417E553750039AA1C8AD608EEE60@AM0PR04MB4417.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:AM0PR04MB4417;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4417;
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(136003)(396003)(376002)(189003)(199004)(6116002)(3846002)(25786009)(52116002)(186003)(6506007)(71200400001)(316002)(14454004)(97736004)(71190400001)(6512007)(478600001)(966005)(5250100002)(2501003)(6306002)(106356001)(386003)(102836004)(26005)(105586002)(8936002)(99286004)(8676002)(81156014)(81166006)(50226002)(54906003)(486006)(66066001)(476003)(256004)(44832011)(2616005)(14444005)(39060400002)(1857600001)(5660300001)(2900100001)(118296001)(7416002)(6436002)(4326008)(15650500001)(305945005)(86362001)(7736002)(36756003)(110136005)(68736007)(53936002)(2906002)(6486002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4417;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: i1U8bowq3UIht9YOQIANblMtnbdESAQ/+6zlPuR3Qo5KaZhJ/hASrc/nmpkuvVVDBsEz7+dAmt9iLmkihl1lvnpbgRf8tBK+pYjR011KaXGBj9Zuf22xBvwzta5FiI9jT3yrS8IN7TmndeXZQTIv2hsCJudpWSux6hyDBLGZoeOEVntSZ5KPMit7CIDVq63tgPtErvz3CWkv/vo0OpynYoRlxr1pBGwEBC/oQ7s7b9JhRkAEyKJLC8nrJhjvLuMP08tgQS7hv5WGjMWm9bewjtLkddvO6f6sp05kGSR29I/VJuo+AUNQ/ZYkKEwjG4W1FyCCn+qg5oJoZfrAMGzzfg5ee4mB3hMqVGoeVh7hf54=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29959289-660d-4cf5-c3fb-08d62d44df2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 17:38:34.9766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4417
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable PCI suspend/resume support on imx6sx socs. This is similar to
imx7d with a few differences:

* The PM_Turn_Off bit is exposed through an IOMUX GPR, like all other
pcie control bits on 6sx.
* The pcie_inbound_axi clk needs to be turned off in suspend. On resume
it is restored via resume -> deassert_core_reset -> enable_ref_clk.

Most of the resume logic is shared with the initial reset after probe.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c       | 40 ++++++++++++++++++---
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h |  1 +
 2 files changed, 36 insertions(+), 5 deletions(-)

Patch is again linux-next, meant to apply here:
 https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/log/?h=
=3Dpci/dwc

This is quite an old patch, mostly did it to prove that imx7d suspend
support is indeed generic.

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller=
/dwc/pci-imx6.c
index 2cbef2d7c207..6171171db1fc 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -771,12 +771,29 @@ static void imx6_pcie_ltssm_disable(struct device *de=
v)
 	}
 }
=20
 static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
 {
-	reset_control_assert(imx6_pcie->turnoff_reset);
-	reset_control_deassert(imx6_pcie->turnoff_reset);
+	struct device *dev =3D imx6_pcie->pci->dev;
+
+	/*
+	 * Some variants have a turnoff reset in DT while
+	 * others poke at iomuxc registers.
+	 */
+	if (imx6_pcie->turnoff_reset) {
+		reset_control_assert(imx6_pcie->turnoff_reset);
+		reset_control_deassert(imx6_pcie->turnoff_reset);
+	} else if (imx6_pcie->variant =3D=3D IMX6SX) {
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				IMX6SX_GPR12_PCIE_PM_TURN_OFF,
+				IMX6SX_GPR12_PCIE_PM_TURN_OFF);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				IMX6SX_GPR12_PCIE_PM_TURN_OFF, 0);
+	} else {
+		dev_err(dev, "PME_Turn_Off not implemented\n");
+		return;
+	}
=20
 	/*
 	 * Components with an upstream port must respond to
 	 * PME_Turn_Off with PME_TO_Ack but we can't check.
 	 *
@@ -790,22 +807,35 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *i=
mx6_pcie)
 {
 	clk_disable_unprepare(imx6_pcie->pcie);
 	clk_disable_unprepare(imx6_pcie->pcie_phy);
 	clk_disable_unprepare(imx6_pcie->pcie_bus);
=20
-	if (imx6_pcie->variant =3D=3D IMX7D) {
+	switch (imx6_pcie->variant) {
+	case IMX6SX:
+		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
+		break;
+	case IMX7D:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
+		break;
+	default:
+		break;
 	}
 }
=20
+static inline bool imx6_pcie_supports_suspend(struct imx6_pcie *imx6_pcie)
+{
+	return (imx6_pcie->variant =3D=3D IMX7D ||
+		imx6_pcie->variant =3D=3D IMX6SX);
+}
+
 static int imx6_pcie_suspend_noirq(struct device *dev)
 {
 	struct imx6_pcie *imx6_pcie =3D dev_get_drvdata(dev);
=20
-	if (imx6_pcie->variant !=3D IMX7D)
+	if (!imx6_pcie_supports_suspend(imx6_pcie))
 		return 0;
=20
 	imx6_pcie_pm_turnoff(imx6_pcie);
 	imx6_pcie_clk_disable(imx6_pcie);
 	imx6_pcie_ltssm_disable(dev);
@@ -817,11 +847,11 @@ static int imx6_pcie_resume_noirq(struct device *dev)
 {
 	int ret;
 	struct imx6_pcie *imx6_pcie =3D dev_get_drvdata(dev);
 	struct pcie_port *pp =3D &imx6_pcie->pci->pp;
=20
-	if (imx6_pcie->variant !=3D IMX7D)
+	if (!imx6_pcie_supports_suspend(imx6_pcie))
 		return 0;
=20
 	imx6_pcie_assert_core_reset(imx6_pcie);
 	imx6_pcie_init_phy(imx6_pcie);
 	imx6_pcie_deassert_core_reset(imx6_pcie);
diff --git a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h b/include/linux/mf=
d/syscon/imx6q-iomuxc-gpr.h
index 6c1ad160ed87..c1b25f5e386d 100644
--- a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
+++ b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
@@ -438,10 +438,11 @@
 #define IMX6SX_GPR5_DISP_MUX_DCIC1_LCDIF1		(0x0 << 1)
 #define IMX6SX_GPR5_DISP_MUX_DCIC1_LVDS			(0x1 << 1)
 #define IMX6SX_GPR5_DISP_MUX_DCIC1_MASK			(0x1 << 1)
=20
 #define IMX6SX_GPR12_PCIE_TEST_POWERDOWN		BIT(30)
+#define IMX6SX_GPR12_PCIE_PM_TURN_OFF			BIT(16)
 #define IMX6SX_GPR12_PCIE_RX_EQ_MASK			(0x7 << 0)
 #define IMX6SX_GPR12_PCIE_RX_EQ_2			(0x2 << 0)
=20
 /* For imx6ul iomux gpr register field define */
 #define IMX6UL_GPR1_ENET1_CLK_DIR		(0x1 << 17)
--=20
2.17.1

