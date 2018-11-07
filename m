Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A2CC0044C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 13:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 758652086C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 13:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vyc2rRlR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758652086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeKGX1h (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:27:37 -0500
Received: from mail-ve1eur01on0075.outbound.protection.outlook.com ([104.47.1.75]:26720
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727168AbeKGX1h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Nov 2018 18:27:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q05Dq3gkR/z0OGy1+Hjulq0e1qoXPCN/P+vGGw8lOUw=;
 b=Vyc2rRlRxp/dKC5MoCQBDvTHJEExsoJXiBKLL5116wjgya90Ot8ejmuNQ4CAN/m9RlHRPKeAUjT7A7EOOo5U71PuZheGaIz1f8jCiyeloJQFxSQIirMENzxxHbvqlQ+dism80YK5g3sFo26Iv8x9MdTtn+gF9JikdIeKRWMGJvg=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB3953.eurprd04.prod.outlook.com (52.134.90.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Wed, 7 Nov 2018 13:57:03 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::a059:70be:9c00:a3c4]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::a059:70be:9c00:a3c4%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 13:57:03 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: [PATCH v2] PCI: imx: Add imx6sx suspend/resume support
Thread-Topic: [PATCH v2] PCI: imx: Add imx6sx suspend/resume support
Thread-Index: AQHUdqHC7PN/F4fnp0uUaWOgv2Ss9Q==
Date:   Wed, 7 Nov 2018 13:57:03 +0000
Message-ID: <984fcef6d928632241a4a3bce41e2645a304d335.1541598751.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: AM5PR0201CA0022.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::32) To AM0PR04MB4290.eurprd04.prod.outlook.com
 (2603:10a6:208:67::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB3953;6:j1mJfWv926zHWmZZBCD3EgWQJ3AnG2UtZ5dFDoyBflN5zzj/MSsffv0KPpMmf2pGvds9KytzI3uBL6kiYWgLI8YZ6s4L1+qQxXyfIUAoz96YfTULgZS4/xCEyFd2oxO0DiGpoAprOBuk4gTbQpq/alj+lxri4iPfd9TJhFFsh2Whvmfk9nplDPVqya9BBgZORbY/zckQHRIC3PO4AJHA+VoeZ+3XJbxlzz/VOtqIaY0pCumjRyKteZ0OVc9pwXRHOGvxao7f6DcFJ4g5d/PzeBDkDJJtc6/ksG7Q1rm7Imeb3b9IHwIvWDGNAWRoAuEtFJDb/8WPWo98pcdBX4tq3n8Su3uUBQHAGOxyXZtYZ1a/O3q33E/uy3GTsdfIoO+X46udR0wXFiYet7MZoHxDYtetjP+1cH0eKYay+79tdq8VoEvKShW6XieXJnCdDctnkfDzoESkM0QBtZNpW/5QRw==;5:+PcPiBBTrezcAIjE7duvxHuwFwvgZiC0qjEVkT3YRnpPFHAqqgl5Dp7GJbD2U1cxJKwwGJKuYdRW1eZZV3IVcjFkQXS5rTZjnxEPEgorMd/gBORyRR4vqLIwwShqHWlEEikB13eCloTivGLRyxOj2/d/Y++gHjZv9SHxzILC9to=;7:W/NVLF6TPqJyUcOH1bseSUvZ4RWS0d4WPbQHYGwdkRsowd3RS4ayYxYk7ZQnwP4fX781BO5NEHfd1RmUNGqoC5Y5JmD2G1xPfM+8xYC1oMLSo9Smczs4ZvtEb8CxruuWKMDZIBx7VxisSAmAS8EYLA==
x-ms-office365-filtering-correlation-id: f36a4f9f-9732-4f26-9c49-08d644b8e52b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB3953;
x-ms-traffictypediagnostic: AM0PR04MB3953:
x-microsoft-antispam-prvs: <AM0PR04MB3953636CF1D5A9818D62691BEEC40@AM0PR04MB3953.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB3953;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB3953;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(396003)(39860400002)(376002)(199004)(189003)(8676002)(14454004)(5660300001)(966005)(52116002)(99286004)(118296001)(2900100001)(478600001)(575784001)(86362001)(6506007)(15650500001)(186003)(110136005)(54906003)(386003)(66066001)(102836004)(316002)(7736002)(2906002)(7416002)(305945005)(36756003)(4326008)(6486002)(25786009)(39060400002)(105586002)(106356001)(8936002)(97736004)(26005)(50226002)(14444005)(256004)(81166006)(44832011)(71190400001)(71200400001)(53936002)(6306002)(81156014)(6116002)(6436002)(476003)(3846002)(6512007)(486006)(68736007)(2616005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB3953;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: p2IxmzKcENiJV+EWskTwGjtSqHhNTw014XuuknVBWwoURtgq03/5ygpe0zGPHeaNjf77Rp18NSQ4Mk8VXV4qdpRmuaMHrCdoJ9hI7JBEymDmIaw1VBooYyj47izlmtZY+ybd2ZGsxJM797phN29BNtyq4gJhU3bQWgCNj2YpkKhEYl1+NSeYGLDONLcBLp8TvBttscIuDz3368Ghknppj+/xO0EKPZoELMldYfNXIWE1vKTymISPaYGwdaRk/+mhqBw58iMPFZ0+Og3WWduVnmzYaDciBaeQHtj435tXXX+pa/2ByZj8vwUVbbCrIAnFtMk8jXR8Nj+XjWeECIeZXeOdq0stNFtVVKvYYvkEc+c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f36a4f9f-9732-4f26-9c49-08d644b8e52b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 13:57:03.2453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB3953
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
Changes since v1:
* Use a switch statement in imx6_pcie_pm_turnoff. The DT-based turnoff
path is still an if statement.
* Did not split imx6_pcie_clk_disable or call it from other paths, this
would bring complications and is somewhat unrelated.
* See v1 comments: https://lore.kernel.org/patchwork/patch/996806/

 drivers/pci/controller/dwc/pci-imx6.c       | 44 ++++++++++++++++++---
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h |  1 +
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller=
/dwc/pci-imx6.c
index 2cbef2d7c207..54625569d0bc 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -771,41 +771,75 @@ static void imx6_pcie_ltssm_disable(struct device *de=
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
+	/* Some variants have a turnoff reset in DT */
+	if (imx6_pcie->turnoff_reset) {
+		reset_control_assert(imx6_pcie->turnoff_reset);
+		reset_control_deassert(imx6_pcie->turnoff_reset);
+		goto pm_turnoff_sleep;
+	}
+
+	/* Others poke directly at IOMUXC registers */
+	switch (imx6_pcie->variant) {
+	case IMX6SX:
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				IMX6SX_GPR12_PCIE_PM_TURN_OFF,
+				IMX6SX_GPR12_PCIE_PM_TURN_OFF);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				IMX6SX_GPR12_PCIE_PM_TURN_OFF, 0);
+		break;
+	default:
+		dev_err(dev, "PME_Turn_Off not implemented\n");
+		return;
+	}
=20
 	/*
 	 * Components with an upstream port must respond to
 	 * PME_Turn_Off with PME_TO_Ack but we can't check.
 	 *
 	 * The standard recommends a 1-10ms timeout after which to
 	 * proceed anyway as if acks were received.
 	 */
+pm_turnoff_sleep:
 	usleep_range(1000, 10000);
 }
=20
 static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
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
@@ -817,11 +851,11 @@ static int imx6_pcie_resume_noirq(struct device *dev)
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

