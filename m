Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F45C10F06
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 18:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA3E206BA
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 18:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YPJ30NmA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfCKS7k (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:59:40 -0400
Received: from mail-eopbgr150074.outbound.protection.outlook.com ([40.107.15.74]:10614
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728250AbfCKS7h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 14:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6onypBbkH2t5lMbELoL+2z29LCAR0bYI9W8BQC3lnAk=;
 b=YPJ30NmAB6slrCThMxsTU1pyqFYK4nR6iqYO98Bb5wjBJLnGRH6cBdZZDPr8x0gwYgG4iralLVbYpsRcKOSjePQtQXVGWWkmMzytngMNXh428o2/eS3XY0NhTh62j+5t/J71GSvWkV/swEzUR9cALganbmrKRfhJ9ZPSBCpE6CA=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB4911.eurprd04.prod.outlook.com (20.177.49.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.16; Mon, 11 Mar 2019 18:59:28 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::35aa:e13a:52ea:e5e6]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::35aa:e13a:52ea:e5e6%3]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 18:59:28 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Trent Piepho <tpiepho@impinj.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: [PATCH] PCI: imx6: Simplify Kconfig depends on
Thread-Topic: [PATCH] PCI: imx6: Simplify Kconfig depends on
Thread-Index: AQHU2DyNuTuwA21czUeOVRo2YY20PA==
Date:   Mon, 11 Mar 2019 18:59:28 +0000
Message-ID: <e3fd8e88a22468be8bd8fce85dafcc14f2e6a618.1552330407.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: AM5P194CA0018.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::28) To VI1PR04MB5533.eurprd04.prod.outlook.com
 (2603:10a6:803:d2::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf8fbfbd-e58f-4ba5-5e5c-08d6a653afc0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4911;
x-ms-traffictypediagnostic: VI1PR04MB4911:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR04MB4911;23:PSL8QmQKbu0El7nhYwWNwf6EmZUefMlYravtXiU?=
 =?iso-8859-1?Q?QMudmQVzdpM08lrUEmFzg7MIJusixfWfEzi6swosEIHBaJyOihu2ltTZc4?=
 =?iso-8859-1?Q?tFbj0Yk3EqyGGXKN/uAIz78DKnWIsPUWC2NEDXy0rs0ggZyQHy8geXodBE?=
 =?iso-8859-1?Q?Dqp+4eoPQiRuJByhsi105UCQmTltU7qA4XX4USD2hcVLhmWaExay/ZaSdk?=
 =?iso-8859-1?Q?t5q9VUQJ0bmVvloW9FBVRKglnec8SDb8NVb5XtxaLQL2EYAdtMi422Smyl?=
 =?iso-8859-1?Q?gzwY/zr/IbTNW0KDpdgdTHk2ud/yVUqXtso4Kfi0GyIt0D//Wn40QpKM4g?=
 =?iso-8859-1?Q?3xIPcs5AEOJGl7H9y82CqjQgkbDUcrwQxN1qvchgprOjkrbiRoGRJdZXmH?=
 =?iso-8859-1?Q?Le3bsRAsDP7ihTOdJG49Lm8VF95k/1YNVAeEhW0Fs+fc6e4OGHqyMAhL+y?=
 =?iso-8859-1?Q?NRdYeEzDnbusl+XxhspxIbBSM4ZDG9wVCqhb2mhZbVRfeiY2deC+ScxQAQ?=
 =?iso-8859-1?Q?EdUT7M1wrd1vu1OIr9G7lYCd3Vb14TaCRztqA7gq1MEg7l1jlkdj9Y/AgQ?=
 =?iso-8859-1?Q?tGPnpV3pI+R0gk8Eq0IqFLFf6c/J2u4iS2DrCPnuUrzlP7QTqEYS4t7H78?=
 =?iso-8859-1?Q?Hlm5aFlVQKzmRT25Kro6dHef33E9fyJvpUF3ieSw1RgEP2IAPl6t6HaKx1?=
 =?iso-8859-1?Q?8CPAiwjI/V+GeGcVT4epCzWsnzWSmB2RxhhrVwt1MG9CpatUqwQREbonHK?=
 =?iso-8859-1?Q?bTKl7xlm2mHcvqRhiHdSC2cpoyqeNRh2erM4HI7w8oCjj0QV8iy4T9czP1?=
 =?iso-8859-1?Q?WJ7D0EsvvJB0FYf51AfxPIfq2dafOhobpJz0FPnDdqwsWtHeWkHjtA36BX?=
 =?iso-8859-1?Q?VlbnrO+FWw7KlgwZG5n9yUu8GY4D3ccN45DZQP8yu4lJ+AaCj+omQgt0+0?=
 =?iso-8859-1?Q?aEDywdPGVd4TfQMO7KIC3cHEQAqnW3jp3tXKIM4srXaISh5NOFrNVsWI0S?=
 =?iso-8859-1?Q?0UCz6kwfKM3IHJS4YqY2uwut5F6KLYXEL753z1aQHdAZP3lK1pGFb7vLLc?=
 =?iso-8859-1?Q?JOmNI3AXttuV2ON/jjITn/1SIjjoysuTNz3Zce3M8hx4nn+HhnZ+hPT1dD?=
 =?iso-8859-1?Q?a86Fs1bNgRrrG9QGjZuCJ5hwVcN8kX3nZYFa4BAMMn6zMp5JoqzeKCkChN?=
 =?iso-8859-1?Q?Kiq2hKd1MD0Kmx+XDzivMsDmmF8i8u2dhXQp23xPZPd0PJxxt+TMnru4WA?=
 =?iso-8859-1?Q?ict22jtGNgARqZXx3?=
x-microsoft-antispam-prvs: <VI1PR04MB4911F1891E5E6F7895AEC5E3EE480@VI1PR04MB4911.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(366004)(136003)(189003)(199004)(486006)(14444005)(256004)(44832011)(66066001)(5660300002)(68736007)(4744005)(478600001)(476003)(97736004)(6486002)(2616005)(86362001)(36756003)(105586002)(99286004)(4326008)(2906002)(25786009)(186003)(26005)(81156014)(81166006)(8936002)(71190400001)(8676002)(52116002)(305945005)(106356001)(50226002)(6436002)(71200400001)(6116002)(3846002)(118296001)(53936002)(102836004)(54906003)(14454004)(110136005)(316002)(7736002)(386003)(6506007)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4911;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ke1VpGG9p/SMY9gMXkfnkFjKQ0Wz1SIvrkjfS86zJ7hQTHmhps6UD5ceImkt0vICPVXdf0Pjn4kVA/LgdVeHfCg611e/i/mNiChga/RwVsjSszLSeNNHKLU3P6vYcCcCeBlzXhPIv8/HeWP9r3JNOvoKkZ65azZairXF/H//h7HQVCGYtGkd9jOCqcFbNfZG7WUohQyKJxkluclvEva4NG+8mWp3KESXYtRhksIpXBv5Nl7z7e4C/+6gs1UomHM44HHxoq56V6hsbTkFX6Opo4+Fsr8vghj7AQoJzwt8KWv/iNNXQvGPHNdiI8JzENlIz3BFcOIarz++Pcz7yvdBofJhf3KX3CuON0zMewwByyOLHRPImqYFZffjZLHJYj355wPRj/xqFE+hA3FXfVJpoZupqaVIUZaLKccdcuVPhIM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8fbfbd-e58f-4ba5-5e5c-08d6a653afc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 18:59:28.3462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4911
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In theory this driver can be used on imx6sx without enabling support for
imx6q or imx7d but the "depends on" condition doesn't allow that.

Instead of making the condition even longer just make it depend on
"ARCH_MXC || COMPILE_TEST" instead.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/pci/controller/dwc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dw=
c/Kconfig
index 6ea74b1c0d94..21747fd0e799 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -88,11 +88,11 @@ config PCI_EXYNOS
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
=20
 config PCI_IMX6
 	bool "Freescale i.MX6/7/8 PCIe controller"
-	depends on SOC_IMX6Q || SOC_IMX7D || (ARM64 && ARCH_MXC) || COMPILE_TEST
+	depends on ARCH_MXC || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
=20
 config PCIE_SPEAR13XX
 	bool "STMicroelectronics SPEAr PCIe controller"
--=20
2.17.1

