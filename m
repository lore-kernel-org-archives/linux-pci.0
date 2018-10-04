Return-Path: <SRS0=kgUF=MQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08B3C64EBC
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 16:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4E420877
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 16:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lYKEOPxb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4E420877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbeJDX2x (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:28:53 -0400
Received: from mail-eopbgr80058.outbound.protection.outlook.com ([40.107.8.58]:50486
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727810AbeJDX2w (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Oct 2018 19:28:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTbqyO0fLgcear2T3IwYWkna0x3/qAXQuYdQ+1SYwcw=;
 b=lYKEOPxbvFgKAOKDLDKzHV9cPzU9qzapv/1QcvC+KWNiUy8WL8u+AuaWPIBNHzrObWI5E0KQuUuUMnwOQstG4r2wsv2XTBaaR5DghisQdhsF1Rp6myZGOWlSlM+7HrWm/Z0q499eM1aQd5/TPjDCLQbLQ3pU8/7E1l7MG2w7kF4=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB5266.eurprd04.prod.outlook.com (20.177.42.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.25; Thu, 4 Oct 2018 16:34:30 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1207.022; Thu, 4 Oct 2018
 16:34:30 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Richard Zhu <hongxing.zhu@nxp.com>
CC:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/4] PCI: imx: Add PME_Turn_Off support
Thread-Topic: [PATCH v2 4/4] PCI: imx: Add PME_Turn_Off support
Thread-Index: AQHUXAAfuxXhw+LsYE6gE8iU25MszA==
Date:   Thu, 4 Oct 2018 16:34:30 +0000
Message-ID: <37d60fe2119361381a6a81f439fa1c3ad29db45e.1538670431.git.leonard.crestez@nxp.com>
References: <cover.1538670431.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1538670431.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: DB6PR02CA0003.eurprd02.prod.outlook.com
 (2603:10a6:6:15::16) To AM0PR04MB4290.eurprd04.prod.outlook.com
 (2603:10a6:208:67::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5266;6:+j2bP5nHl86TuqUfHVN+QnNatU5a5HlzBKqQgfyAOmYVI/dxjGWbUulPdqkDLGwsJEq4fEG2DyOTuv7LczA9z+olxoZ7DthgfhA6umuGly8K/JJSeRLT5ljYJaI/11K7kRa4lpF0azQ9MdZ1r2asvTVNidpT2+UJo4X9qtXe7A8lDWMO2/X0SE5OUgDizxuWihaPFwUv6bO8AiZAMup+7W2QnAA6oAJ50J/AcSECf6XBfzKUmdjSzFChJHx652dtUwGtTt/RhIXb+HxEx6nVPD4S44uAXvHJdGUpThkc+FRrqnzro6hURlmQbTrESxsvGlgnC1f/BScxepa75EN97L3EZZ3HTLQYv+8qws2B2SEu3rIEBMmhChoNbLqbpUNWmy5NKfxwNROivKOM/vWE/6FLzJVNVi8klY0t6ZE1BKOtCG/d7f/MHNwrrSOCtjZS0GLCFQ9hwCVWN/acTxkl+w==;5:TjO851GbQYD7U3m72ZGKmZdb8/48sF/VfeDWWGmszNAE+SMgxiz6FJSqOsyO+gNVZNaNJ37XynDmfoqQrRsPwSZYJQXobrpgvuc/S+ahuy8QNavUXeuV9Kj6jqIGuq2c515lQ29v5hG2RDqYrygja9W1h14lkIZwMaCpKMIILlE=;7:F6AvALCK++s4HDDfOKXdDGz0qpYp/JNEDX22R0MPSPpre+NBpM5+qh6bmPw8WYR691mffQ8AOIEzkjHzkebA8ttGX5h+4iy5GTY2p+E4ZmrfpxIb7u7pVlNuCTQAz0NC+mQYugtawN5pkJNEvasxYldQQdduV5cyA43mAXQN+62ZONzJI+amk41SrOrGqzV2DtUNxVr/7Wbm+ESDQtRwGjqYUNG4ndd91nIKMQa/jIDD8uMPar2A15UdesbSpCS2
x-ms-office365-filtering-correlation-id: 6a17609b-d0a5-4356-1e5c-08d62a1741f9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5266;
x-ms-traffictypediagnostic: AM0PR04MB5266:
x-microsoft-antispam-prvs: <AM0PR04MB52668405AEF2FAA0298BDBC2EEEA0@AM0PR04MB5266.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051);SRVR:AM0PR04MB5266;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5266;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(39860400002)(346002)(376002)(199004)(189003)(86362001)(66066001)(14454004)(50226002)(39060400002)(4326008)(6436002)(14444005)(256004)(8936002)(106356001)(81156014)(81166006)(5660300001)(105586002)(316002)(2906002)(68736007)(478600001)(476003)(2616005)(44832011)(36756003)(26005)(3846002)(486006)(6116002)(11346002)(446003)(186003)(2900100001)(102836004)(8676002)(6506007)(386003)(54906003)(76176011)(53936002)(71200400001)(71190400001)(52116002)(97736004)(99286004)(6512007)(6636002)(118296001)(7416002)(110136005)(5250100002)(25786009)(7736002)(305945005)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5266;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KXPGTBxcpyNaDCpVCzrQxQP3Xd9xd6p+R7jIdwfz3FhTGtjqRFhBnF8EWRDNj9kY3tCiTuXZa7B/9aLRX8xvGgjhO41bH8uf1tADKU6fSEjaQne/Xv5fX8KJedUwgqvH0bZ90W8DgJshvOBBrzg43vMD5SYfK7Ou1dTKE2dSvE8pOiCQmwxoWQopv+Bv2bu074h8EXxW1/9UbTHf6hhQ3RjAfd7VKKfKaVCUS1RPpVWH2etCi6PCE/ZHjA/86pw69gZvC76ttBwTMv5WODwi3pygHpvk10dJPNu0H2HofibMu40ne6EkVmkUsjmuXFZs1bcICe+StdRwCPjhlGV4KFR+0Jlg8YQgqEZYbwyx8YU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a17609b-d0a5-4356-1e5c-08d62a1741f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 16:34:30.2135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5266
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When the root complex suspends it must send a PME_Turn_Off TLP.
Implement this by asserting the "turnoff" reset.

On imx7d this functionality is part of the SRC and exposed through the
linux reset-controller subsystem. On imx6 equivalent bits are in the
IOMUXC GPR area which the imx6-pcie driver accesses directly.

This is only for imx7d right now but it's deliberately implemented as an
optional reset, ignoring the chip variant:
* Older dtbs won't have this reset so it will be ignored.
* Future chips might also expose this as a reset controller.

For example imx8m (not yet supported) has the exact same
PCIE_CTRL_APPS_TURNOFF bit in the same location.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller=
/dwc/pci-imx6.c
index 6ba16fd1373c..2bf80f1ad852 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -50,10 +50,11 @@ struct imx6_pcie {
 	struct clk		*pcie_inbound_axi;
 	struct clk		*pcie;
 	struct regmap		*iomuxc_gpr;
 	struct reset_control	*pciephy_reset;
 	struct reset_control	*apps_reset;
+	struct reset_control	*turnoff_reset;
 	enum imx6_pcie_variants variant;
 	u32			tx_deemph_gen1;
 	u32			tx_deemph_gen2_3p5db;
 	u32			tx_deemph_gen2_6db;
 	u32			tx_swing_full;
@@ -812,10 +813,25 @@ static void imx6_pcie_ltssm_disable(struct device *de=
v)
 	default:
 		dev_err(dev, "ltssm_disable not supported\n");
 	}
 }
=20
+static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
+{
+	reset_control_assert(imx6_pcie->turnoff_reset);
+	reset_control_deassert(imx6_pcie->turnoff_reset);
+
+	/*
+	 * Components with an upstream port must respond to
+	 * PME_Turn_Off with PME_TO_Ack but we can't check.
+	 *
+	 * The standard recommends a 1-10ms timeout after which to
+	 * proceed anyway as if acks were received.
+	 */
+	usleep_range(1000, 10000);
+}
+
 static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
 {
 	clk_disable_unprepare(imx6_pcie->pcie);
 	clk_disable_unprepare(imx6_pcie->pcie_phy);
 	clk_disable_unprepare(imx6_pcie->pcie_bus);
@@ -832,10 +848,11 @@ static int imx6_pcie_suspend_noirq(struct device *dev=
)
 	struct imx6_pcie *imx6_pcie =3D dev_get_drvdata(dev);
=20
 	if (imx6_pcie->variant !=3D IMX7D)
 		return 0;
=20
+	imx6_pcie_pm_turnoff(imx6_pcie);
 	imx6_pcie_clk_disable(imx6_pcie);
 	imx6_pcie_ltssm_disable(dev);
=20
 	return 0;
 }
@@ -959,10 +976,17 @@ static int imx6_pcie_probe(struct platform_device *pd=
ev)
 		break;
 	default:
 		break;
 	}
=20
+	/* Grab turnoff reset */
+	imx6_pcie->turnoff_reset =3D devm_reset_control_get_optional_exclusive(de=
v, "turnoff");
+	if (IS_ERR(imx6_pcie->turnoff_reset)) {
+		dev_err(dev, "Failed to get TURNOFF reset control\n");
+		return PTR_ERR(imx6_pcie->turnoff_reset);
+	}
+
 	/* Grab GPR config register range */
 	imx6_pcie->iomuxc_gpr =3D
 		 syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
 	if (IS_ERR(imx6_pcie->iomuxc_gpr)) {
 		dev_err(dev, "unable to find iomuxc registers\n");
--=20
2.17.1

