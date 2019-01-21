Return-Path: <SRS0=cv1o=P5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537DBC3713C
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jan 2019 22:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145762089F
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jan 2019 22:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aSsD9COW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfAUWuN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Jan 2019 17:50:13 -0500
Received: from mail-eopbgr130045.outbound.protection.outlook.com ([40.107.13.45]:22368
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726244AbfAUWuN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Jan 2019 17:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eOzHYqrmOBXlJY7gn9eTJFUeKWzm3jQXusDybGcOX4=;
 b=aSsD9COWKXM7XwsH0MyaOK+gHbnTny/drFTVSfOVKY6cKNCNLht83BP/ajZ93j/0piuk+rid9fkLdSjsIjVURQpYhgWk+Juc9FiV/GUWrQFZEsxn2B03BDr5bAHJZGNjP+eKLnjytgy5cf8RR/E0XnO9cE9VCylPD4EMyR5mIKs=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB5983.eurprd04.prod.outlook.com (20.178.123.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Mon, 21 Jan 2019 22:50:04 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::92d:bf44:9c1d:b907]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::92d:bf44:9c1d:b907%6]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 22:50:04 +0000
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
Subject: [PATCH 1/2] PCI: imx: Fix probe failure without power domain
Thread-Topic: [PATCH 1/2] PCI: imx: Fix probe failure without power domain
Thread-Index: AQHUsdumnhpLtdU11UCqN+1L30Gg6Q==
Date:   Mon, 21 Jan 2019 22:50:04 +0000
Message-ID: <375a852ae9170a5f8f53fdd364a7fb7ea642e89c.1548110502.git.leonard.crestez@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5983;6:xpvHiiygtrTJpMunqQwxNDslS/gA9flwsUmmkbE8mMx1laICzaQFW9UP6naTHKNo5fB7yrPAe9bcA2ToIFrqkDo4J0edKyFKy4gq1gMh217k5kAV2TgWBttkbwjXvnwwVdGJnaVR2Uto65kNAhqVjgqOXBMtAWeDGsJ89xoWPRb63CAdXZB03hUjjwL+6q6NXQ67gs8Rb3wyqUEbmRsLJr9aQ3IVkPu0zq2FguwhMu6/8OOt+Juzs4wYfVF08l5XV4wj7RuGDMfRYSxG+BwWKt4ZkAaQSKrUjnGdWMDcU23jbrOhZnc7v3/qHB76DHEz5P7CoYXklF4Qw+OQNOpCDigyAQNi43enlbnM0wX64TOJqzsMTR63pd2WC7d1sddg2p5Nu9IEUfyJCwRPQ+I2BNwas6I9BCtk+fyMWRCQrPhQpGHu0HMfovo6hCKQabM3IWwCZom1wgvVqE9ZEhZS4w==;5:eGTjx6pPm8lwsqp6yVdfSXPGdYTAf9F71TeKi78o6pmlSph4z5LTeWRuZ5drRCwFWgofFzWBOLUuJRzklTObVOSxiulREVEgcvjbZylNP58g043Z0zPd6wkeQQE3tCFL3cFnJGSDMoiIms/6TPOQ1PQID2PZLdgHmeLRf9fChAErCznzrvkXaltT9qMFyVG+TI1Pv84qmQh4Shof5nBUNg==;7:WL4EHmklM6UKMDcjV3muyW+ZV9FEcBPleJEDnszjmNw5O6/S8AMUXm5I0rmEWn7Du5fWZ7gq2WN1tRQ/qQplCZsAQtWSd+qTZETw/fdnXRjG6CWER+hOCv55AmbRyC7YlYFoMxKRpuJAeRrxpTpcjA==
x-ms-office365-filtering-correlation-id: 351c1547-00ba-4181-e170-08d67ff2c858
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5983;
x-ms-traffictypediagnostic: VI1PR04MB5983:
x-microsoft-antispam-prvs: <VI1PR04MB598349EB41938FC386AE02EDEE9F0@VI1PR04MB5983.eurprd04.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(4326008)(99286004)(478600001)(71190400001)(71200400001)(76176011)(5024004)(256004)(52116002)(68736007)(6436002)(25786009)(6486002)(386003)(106356001)(53936002)(66066001)(50226002)(6506007)(36756003)(186003)(97736004)(102836004)(26005)(8676002)(305945005)(54906003)(11346002)(6512007)(8936002)(446003)(486006)(316002)(44832011)(6116002)(118296001)(110136005)(476003)(86362001)(2616005)(14454004)(2906002)(3846002)(81166006)(81156014)(7736002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5983;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: v/aAnTqVn6dRzIP5LzBP0D8nr4IjG6kXT0+uHc612fC326H1s0UA8OSmS7rNFYdR5vX6ueAyV/LSPaJ1NM8cINBm2gVOc8vHL2etzUT+CZN0buF+e32fDKQqtE6JMtpaBTm9FAUWm+769qEhb+1s+aTcNUgzfO8ghL9ogpvtalo/dVG+3F4lQFr/EaKZITYjK79lcd5wk+JuCNxn/gQkVdHEvmxpxy04K2yBK89Y1dg4bdMsxj4Duflwm15f+Mdr3QhSWm4hqCdRuP9X2Yb7sg1ZkhNEhICWk5UNgRkKoNB6TDY/uzN1er5bvyRDSBC9pCHQ1PAy/ja+P7WgYCKMHA1PwKjHUp0SizGcpKxbg4Lt8GKpGwI4U69xVBvo59t8L36EhhNrqQHNkvuxLrAb4ilMduA2mS2OAMJf1Jxx5Qo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 351c1547-00ba-4181-e170-08d67ff2c858
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 22:50:03.2450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5983
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On chips without a separate power domain for PCI (such as 6q/6qp) the
imx6_pcie_attach_pd function incorrectly returns an error.

Fix by returning 0 if dev_pm_domain_attach_by_name doesn't find
anything.

Fixes: 3f7cceeab895 ("PCI: imx: Add multi-pd support")
Reported-by: Lukas F.Hartmann <lukas@mntmn.com>
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller=
/dwc/pci-imx6.c
index 52e47dac028f..ac5f6ae0b254 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -308,10 +308,13 @@ static int imx6_pcie_attach_pd(struct device *dev)
 		return 0;
=20
 	imx6_pcie->pd_pcie =3D dev_pm_domain_attach_by_name(dev, "pcie");
 	if (IS_ERR(imx6_pcie->pd_pcie))
 		return PTR_ERR(imx6_pcie->pd_pcie);
+	/* Do nothing when power domain missing */
+	if (!imx6_pcie->pd_pcie)
+		return 0;
 	link =3D device_link_add(dev, imx6_pcie->pd_pcie,
 			DL_FLAG_STATELESS |
 			DL_FLAG_PM_RUNTIME |
 			DL_FLAG_RPM_ACTIVE);
 	if (!link) {
--=20
2.17.1

