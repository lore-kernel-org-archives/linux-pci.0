Return-Path: <SRS0=ZQO4=QM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F9DC282C4
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 00:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD57220821
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 00:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="cbdGrco8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfBEAR4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Feb 2019 19:17:56 -0500
Received: from mail-eopbgr800101.outbound.protection.outlook.com ([40.107.80.101]:19872
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725886AbfBEAR4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Feb 2019 19:17:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7RiZACcNA+wyuttLTr7HU4ezOYEzdjsUyq1kCjCgzc=;
 b=cbdGrco8gY55eSnVmEnAVl/6avBj18RkKr7Y2ZMOunZdwYNWVC+WnlRUZwc2DPCylYcJFZUZezsZKFpBDnTpLeiGcRCYnPosCKuy0CT9X4p9e9nftInlZkplKi2J0aAtWfJrGemPbfBCYwdKiYr7q7RKS3lOOFwoAFQjsXmft4o=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3722.namprd06.prod.outlook.com (10.167.236.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Tue, 5 Feb 2019 00:17:41 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85%5]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 00:17:41 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Trent Piepho <tpiepho@impinj.com>
Subject: [PATCH v2 3/3] PCI: imx: Add workaround for e10728, IMX7d PCIe PLL
 failure
Thread-Topic: [PATCH v2 3/3] PCI: imx: Add workaround for e10728, IMX7d PCIe
 PLL failure
Thread-Index: AQHUvOg1I9SIwv2NIEC65G+x/YIYYw==
Date:   Tue, 5 Feb 2019 00:17:41 +0000
Message-ID: <20190205001721.18639-4-tpiepho@impinj.com>
References: <20190205001721.18639-1-tpiepho@impinj.com>
In-Reply-To: <20190205001721.18639-1-tpiepho@impinj.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0078.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::19) To MWHPR0601MB3708.namprd06.prod.outlook.com
 (2603:10b6:301:7c::38)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.14.4
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3722;6:rScQydgHaMNq65zSLTOco5AsfA8mpCe1qbCPSkWbLyU9PPKIIUIgzFshDvf4OKIxH8cGyq3awXlZUBRnV3MzdOE7KzMxUWKAgpHAISdH7lobipEjjbTwoPStxAjLvH6l7yGFnhzaDCUOcEpC3cHmukZPs2jEbg532vcgTmW3c7OMhwZK9hciMq5BLOw+ehVa9jWwlq6KUvksnUlFForVu8jxGYxrR1dbON91ZV/hy47rIxO/9RV05p9GwXdD5E23fgsgY9Ys6ySg5vt5jqDr9mp5pRRdg7fffnmlkKTPEDCyDuKN8V1QVAd+yFRfaT1lKlDeadxFTMbUKErumnDvCdqoHd4k31bMGbO66FrezWPiQSrUdu53HK7dvzj4AkrnQvAZCx5jaION9c8BIms9HdkJlXs8LSShp2NGj6OXc6XXdB3a7Now4o/vbvHG9M8yeXglieiYDI5pF30N+XrzKg==;5:s8gdbLbt8ScHhRq+JQlF6sdCmP5lBICYUSO+eUO20iy8LX0NoluIAUUiKIBi/77R1MUE7V4ETsd6hmKwYxg/tc+fD/p0rBmw8zNLkQGFDBJAN0dqd9M/jfB8yhnJZTGDeb2oWKYchjidzGGbhAex/tE2nB7k4ZeCaz2hdQ5MVyxImoQvbdHZBQLqH9klrGuz5qr0V+3un9//18MAU/VsqQ==;7:9YK0uW2JOzBIKhSF6r5+QZoFLVCj85gSWwShCx8U9RqzJPgmPzowc7cHSzXDZ7qPW7u0KQq/61M5FyZ+tCQInQcuPSIjtOGmQugp6jNmKTikVoyG6D9MjDdFXa/iYyCVHtCeFT274Bh0yMyGY+dE/w==
x-ms-office365-filtering-correlation-id: 42d04db9-692d-422d-f194-08d68aff578d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3722;
x-ms-traffictypediagnostic: MWHPR0601MB3722:
x-microsoft-antispam-prvs: <MWHPR0601MB37226C47B7B646257A615FA3D36E0@MWHPR0601MB3722.namprd06.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(396003)(39850400004)(366004)(199004)(189003)(2616005)(476003)(105586002)(25786009)(305945005)(7736002)(2906002)(6116002)(107886003)(3846002)(11346002)(66066001)(486006)(86362001)(4326008)(97736004)(186003)(2351001)(446003)(1076003)(71190400001)(71200400001)(256004)(6486002)(102836004)(6436002)(26005)(50226002)(386003)(6506007)(53936002)(14454004)(6916009)(5640700003)(316002)(8936002)(478600001)(6512007)(76176011)(2501003)(99286004)(81166006)(81156014)(68736007)(14444005)(52116002)(54906003)(36756003)(106356001)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3722;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dZs41GfsuRSAtrtSxR7f+qgOVBlVbxSigREn5qHa7ms12i7H+4LCn0lzhEfm6F6g0xpKVyK0+oWgB0GjnVg5Zqj8KFHaVw4yXM9SQSxig+0M1cU6PKYH87heSYbiH5ZO+Q4hpcVCeRsgsxRmO8clJotPeRgoQhCg4OANEM11YP+S6M+VSOoXLw0VM8Wj7OlfgWol/Z7ICR/lahhcAi9IMY1QImM6ZXOkMfHO6WdAop99sLWoOey1UqrPsm1ELXlIFPl/vrjkKuKQSMld1vtdKtcntbWD2Aazmn/beWBa+FNrkIYFuNFSfZcaI8xII4iMK0jBbe+bJvk7i5qkObeoBFKIobIOXUTtfFhEM1xSLgwuagXM6pcfC+zNhSaNfAYJzMubTEGiWF3GeZcrfuFiBdqRXsbY3NSovQeXVt0yocg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d04db9-692d-422d-f194-08d68aff578d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 00:17:40.5774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3722
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This implements the workound described in the NXP IMX7d erratum e10728.

Initial VCO oscillation may fail under corner conditions such as cold
temperature.  It causes PCIe PLL to fail to lock in the initialization
phase, which results in the PCIe link failing to come up.

The workaround is to disable Duty-cycle Corrector (DCC) calibration
after G_RST.

To do this it is necessary to gain access to the undocumented and
currently unused PCIe PHY register bank.  A new device tree node of type
"fsl,imx7d-pcie-phy" is created for the PHY block and the existing PCIe
device uses a phandle named "fsl,imx7d-pcie-phy" to point to it.

Signed-off-by: Trent Piepho <tpiepho@impinj.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 57 +++++++++++++++++++++++++++++++=
++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller=
/dwc/pci-imx6.c
index 80f843030e36..06dd6aa927d4 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/of_gpio.h>
 #include <linux/of_device.h>
+#include <linux/of_address.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -61,6 +62,7 @@ struct imx6_pcie {
 	u32			tx_swing_low;
 	int			link_gen;
 	struct regulator	*vpcie;
+	void __iomem		*phy_base;
=20
 	/* power domain for pcie */
 	struct device		*pd_pcie;
@@ -117,6 +119,23 @@ struct imx6_pcie {
 #define PCIE_PHY_RX_ASIC_OUT 0x100D
 #define PCIE_PHY_RX_ASIC_OUT_VALID	(1 << 0)
=20
+/* iMX7 PCIe PHY registers */
+#define PCIE_PHY_CMN_REG4		0x14
+/* These are probably the bits that *aren't* DCC_FB_EN */
+#define PCIE_PHY_CMN_REG4_DCC_FB_EN	0x29
+
+#define PCIE_PHY_CMN_REG15	        0x54
+#define PCIE_PHY_CMN_REG15_DLY_4	BIT(2)
+#define PCIE_PHY_CMN_REG15_PLL_PD	BIT(5)
+#define PCIE_PHY_CMN_REG15_OVRD_PLL_PD	BIT(7)
+
+#define PCIE_PHY_CMN_REG24		0x90
+#define PCIE_PHY_CMN_REG24_RX_EQ	BIT(6)
+#define PCIE_PHY_CMN_REG24_RX_EQ_SEL	BIT(3)
+
+#define PCIE_PHY_CMN_REG26		0x98
+#define PCIE_PHY_CMN_REG26_ATT_MODE	0xBC
+
 #define PHY_RX_OVRD_IN_LO 0x1005
 #define PHY_RX_OVRD_IN_LO_RX_DATA_EN (1 << 5)
 #define PHY_RX_OVRD_IN_LO_RX_PLL_EN (1 << 3)
@@ -490,6 +509,26 @@ static void imx6_pcie_deassert_core_reset(struct imx6_=
pcie *imx6_pcie)
 	switch (imx6_pcie->variant) {
 	case IMX7D:
 		reset_control_deassert(imx6_pcie->pciephy_reset);
+
+		/* Workaround for ERR010728, failure of PCI-e PLL VCO to
+		 * oscillate, especially when cold.  This turns off "Duty-cycle
+		 * Corrector" and other mysterious undocumented things.
+		 */
+		if (likely(imx6_pcie->phy_base)) {
+			/* De-assert DCC_FB_EN */
+			writel(PCIE_PHY_CMN_REG4_DCC_FB_EN,
+			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG4);
+			/* Assert RX_EQS and RX_EQS_SEL */
+			writel(PCIE_PHY_CMN_REG24_RX_EQ_SEL
+				| PCIE_PHY_CMN_REG24_RX_EQ,
+			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG24);
+			/* Assert ATT_MODE */
+			writel(PCIE_PHY_CMN_REG26_ATT_MODE,
+			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG26);
+		} else {
+			dev_warn(dev, "DT lacks imx7d-pcie-phy, unable to apply ERR010728 worka=
round\n");
+		}
+
 		imx7d_pcie_wait_for_phy_pll_lock(imx6_pcie);
 		break;
 	case IMX6SX:
@@ -919,6 +958,7 @@ static int imx6_pcie_probe(struct platform_device *pdev=
)
 	struct device *dev =3D &pdev->dev;
 	struct dw_pcie *pci;
 	struct imx6_pcie *imx6_pcie;
+	struct device_node *np;
 	struct resource *dbi_base;
 	struct device_node *node =3D dev->of_node;
 	int ret;
@@ -939,6 +979,23 @@ static int imx6_pcie_probe(struct platform_device *pde=
v)
 	imx6_pcie->variant =3D
 		(enum imx6_pcie_variants)of_device_get_match_data(dev);
=20
+	/* Find the PHY if one is defined, only imx7d uses it */
+	np =3D of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
+	if (np) {
+		struct resource res;
+
+		ret =3D of_address_to_resource(np, 0, &res);
+		if (ret) {
+			dev_err(dev, "Unable to map PCIe PHY\n");
+			return ret;
+		}
+		imx6_pcie->phy_base =3D devm_ioremap_resource(dev, &res);
+		if (IS_ERR(imx6_pcie->phy_base)) {
+			dev_err(dev, "Unable to map PCIe PHY\n");
+			return PTR_ERR(imx6_pcie->phy_base);
+		}
+	}
+
 	dbi_base =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pci->dbi_base =3D devm_ioremap_resource(dev, dbi_base);
 	if (IS_ERR(pci->dbi_base))
--=20
2.14.4

