Return-Path: <SRS0=cv1o=P5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EA9C3712F
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jan 2019 22:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45172089F
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jan 2019 22:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZxciCHeb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfAUWuP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Jan 2019 17:50:15 -0500
Received: from mail-eopbgr130045.outbound.protection.outlook.com ([40.107.13.45]:22368
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727166AbfAUWuO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Jan 2019 17:50:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79pfXeP5i6jnruNbkOwI/Y5CEkeP4ptLmQyPBOtIdk0=;
 b=ZxciCHebneHMQzg/rtu6CykYKbldYT9j/NSK/lDOZj4BgAP3JRcE6OXGp3l9tnvrZ0X8KJXged3QwWJ2OA6K60SncCRZQtuQLy3GXiii8+kxV7DPR1R4Inc2a9/Lp61xxZ0bsBhPEFe/Ggx3EzP8XXRgaCV7mZs+UoeqF5TqQTs=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB5983.eurprd04.prod.outlook.com (20.178.123.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Mon, 21 Jan 2019 22:50:05 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::92d:bf44:9c1d:b907]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::92d:bf44:9c1d:b907%6]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 22:50:05 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Lukas F . Hartmann" <lukas@mntmn.com>,
        Lucas Stach <l.stach@pengutronix.de>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 2/2] PCI: imx: Fix checking pd_pcie_phy device_link
Thread-Topic: [PATCH 2/2] PCI: imx: Fix checking pd_pcie_phy device_link
Thread-Index: AQHUsdumLb5Dn4fO6kGAXVWrfR34gQ==
Date:   Mon, 21 Jan 2019 22:50:05 +0000
Message-ID: <8911de1e25f5c7d8ce328b623a980f2746787a87.1548110502.git.leonard.crestez@nxp.com>
References: <cover.1548110502.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1548110502.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: AM5PR0701CA0051.eurprd07.prod.outlook.com
 (2603:10a6:203:2::13) To VI1PR04MB5533.eurprd04.prod.outlook.com
 (2603:10a6:803:d2::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5983;6:7t1e3MKFsE9Qwoh3sFXV+q0u255YYvwKFEquvY49bdhZcTmFNZy0jSJldm2gsUuRiDlRQEcLiwXT/F5ZC3+iLJoAEQcUqZfkHTdrxtzy4HFPNN9EIw8TCAR/mVlGiEWUtHEXpd/33DRHh+vbgxYdmo9XXVRQaC53xO6PdPye11hDWpfgi0s6NYdByF88FCTi1Z9uOQAqhc1TavYyqfL13HfCQaBxf14ATWu2U+7DNK1RNsY2Q3mJ/tUTRfdrlmEbVZCAfhcjn8GtkgPKz35l1QVYY1yi0dgAoUAIyjbSPI2ESB00NPzKhRFsX/m5l3hGex53zBy0X09K2adotRbtX9EtZcGzBdJROmaQkrnYIv8UyBX+Xgynulcf9rVsZyctnMdC/kTuq6MQCAPJO2GAN5xxJ/cUMbB3N8qzghffVoyS15hEPsHvkxh9Xc4NrkDaLhU0MePefiynD1sI8Cv1OQ==;5:IaJNOlqgLgtrFT9QVog6MIU7VEma75FXNSXSezSGADQ68ksm+KCjx5c20FQNt/LF11EgWbOcPDBvAVwgkzztfPoKSDKwzuuQ6xUu7+5q3sYoPhBwK1W5m5bCZ2oOafrbWwke8uYOPnwgXU7NSXbBWLldwSsenuKFM/WgRWNJ+ajEM8E35ttBvERBUfwkTQ7H2O5838SbK8vJS+PM6o/IRA==;7:K1MHbGKsUM/3G7j5+jD80RALbO3tPFsEnr5Urc5usS8t0ziF7fUTrRaDIr+8vrwnLoFKBwtA7O1xJ07VXL5YBjCZF539ZM6FK8Zmentd0JyiljbFutrXgbS6oT/SEM2tJz8ItLAKkHaxovLxqHph/A==
x-ms-office365-filtering-correlation-id: 1f072b45-2107-4a58-39bf-08d67ff2c8f7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5983;
x-ms-traffictypediagnostic: VI1PR04MB5983:
x-microsoft-antispam-prvs: <VI1PR04MB598388B64D4516619FF45594EE9F0@VI1PR04MB5983.eurprd04.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(4326008)(99286004)(478600001)(71190400001)(71200400001)(76176011)(5024004)(256004)(52116002)(68736007)(6436002)(25786009)(6486002)(386003)(106356001)(53936002)(66066001)(50226002)(6506007)(36756003)(186003)(97736004)(102836004)(26005)(8676002)(305945005)(54906003)(11346002)(6512007)(8936002)(446003)(486006)(316002)(44832011)(6116002)(118296001)(110136005)(476003)(86362001)(2616005)(14454004)(2906002)(3846002)(81166006)(81156014)(7736002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5983;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tOXcUpF3ZqwXzXORk9TPPbqIgcERuafrXRoKshHuWYx3EqXd0N/AUi+wMSE1Q8pnbXYET9EeqIRsWcAPzpnmYI8iVF/QieNap+x74FrdkT0uVmyVW3Wyv5qw6UclHi5NV2kHyNDxNbru1IPuS4r8PfWf/KDv4H/4WpyaeVny3BVoBFiug3Fyn2wVv04z50CpN1yrm12U1EM455/sNOp5srVtl/2eA49GxSLYuzCJQFZ8x8lWCUoKb2/2C/fZvscWE2PzhAXExHRekTpUkcEYNmL4tMkJugUTDRsWfBXr0jT8jGOYqFW0HOi+IJwczQ42XrsRI7Io/f+IV5H8VEZBLzK8yU+372w77e8PY4zUdqBgAcTkLdQJ/3eynqt87AdEerktifTgu+fpkKYidDA8PySbvjt08jVIBJiPh5Emfuw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f072b45-2107-4a58-39bf-08d67ff2c8f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 22:50:04.2827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5983
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This check was completely wrong. It doesn't break anything specific
because adding the second device_link can't fail.

Fixes: 3f7cceeab895 ("PCI: imx: Add multi-pd support")

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller=
/dwc/pci-imx6.c
index ac5f6ae0b254..80f843030e36 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -324,17 +324,17 @@ static int imx6_pcie_attach_pd(struct device *dev)
=20
 	imx6_pcie->pd_pcie_phy =3D dev_pm_domain_attach_by_name(dev, "pcie_phy");
 	if (IS_ERR(imx6_pcie->pd_pcie_phy))
 		return PTR_ERR(imx6_pcie->pd_pcie_phy);
=20
-	device_link_add(dev, imx6_pcie->pd_pcie_phy,
+	link =3D device_link_add(dev, imx6_pcie->pd_pcie_phy,
 			DL_FLAG_STATELESS |
 			DL_FLAG_PM_RUNTIME |
 			DL_FLAG_RPM_ACTIVE);
-	if (IS_ERR(link)) {
-		dev_err(dev, "Failed to add device_link to pcie_phy pd: %ld\n", PTR_ERR(=
link));
-		return PTR_ERR(link);
+	if (!link) {
+		dev_err(dev, "Failed to add device_link to pcie_phy pd.\n");
+		return -EINVAL;
 	}
=20
 	return 0;
 }
=20
--=20
2.17.1

