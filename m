Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405E0C65BAE
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 06:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA08920873
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 06:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DvUpcVEK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA08920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbeLMGWS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 01:22:18 -0500
Received: from mail-eopbgr70075.outbound.protection.outlook.com ([40.107.7.75]:58881
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726542AbeLMGWR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Dec 2018 01:22:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9PjC6aXpb3Ulw9veAsp3U8QjuYpp9OpqITy71HhzFc=;
 b=DvUpcVEKIbwW/NFA6OTIoTvv5yTT3gPhSux/SPUNnHwEiaYSyLx7ykGMe++FPNqEE5h9MKo+WM3GooVBu18MSekp473LMj890Ar4lo8GspkB+H3ohxT+B661AjmGGPUYrdEdN5DJKeawPTThtpycQsW1PMPV7ZQuYjy5+wTvj8s=
Received: from AM0PR0402MB3570.eurprd04.prod.outlook.com (52.133.46.11) by
 AM0PR0402MB3588.eurprd04.prod.outlook.com (52.133.46.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Thu, 13 Dec 2018 06:22:13 +0000
Received: from AM0PR0402MB3570.eurprd04.prod.outlook.com
 ([fe80::94f8:5fdd:f384:8af8]) by AM0PR0402MB3570.eurprd04.prod.outlook.com
 ([fe80::94f8:5fdd:f384:8af8%8]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 06:22:13 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH] PCI: imx: make msi work without pcieportbus
Thread-Topic: [PATCH] PCI: imx: make msi work without pcieportbus
Thread-Index: AQHUkqwvGziAch1e1EiTcyWLiZ4Kew==
Date:   Thu, 13 Dec 2018 06:22:13 +0000
Message-ID: <1544681043-3792-1-git-send-email-hongxing.zhu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2P15301CA0018.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::28) To AM0PR0402MB3570.eurprd04.prod.outlook.com
 (2603:10a6:208:1c::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hongxing.zhu@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR0402MB3588;6:vnx3CVMqsN4A7w39NHHzzv/MGsPC3DHj8sjewpwZUQIXBv7LrGDjpZu4db3X0fVEkI7XcrauzuOsSxyGRy2E5ej/A2ecpGEeTCqB4bwESTneLbSPcBgNtYN9VvQOhLl2woAuJ22XQmOzJHzNqmcO0hW0umX951UzIV77ACL/27+r1L6wLNPErn8GX4Z8Yba6gYHgxYeqyHyGxiRzgZlwI9VoMUhy8pohI534/s3hYgILs13wkL8F0J8U5o7gDc/pBZyC45sZSQkv4GPy5zxsSzumgrefG8TjvCoh7PouHIZTkHYVlQeVYHCQ8PKmqeP7aZAH8oiNSY7h8Z/ex0ePJe/+h1ftLNOCZLaFQxyvazHDEtl9qSCjKr0DI3jj0b7bXNMvsLdT2bwzJ8rMvH/Ug5mpezQe0U6S2XqhB6lqokEnQS9daG/b9r0YyoKloawgrIiPWWzwGewMlQb+aTKJpw==;5:thbBAn6qZJFL5SrE+KjpsYTZuV5OslokJe2hLa/qFAML2Wq6hVJyUkZWwmeffCLdaSRteD/B4p1Mcxwvteyw5hQHbbsLJUDp7aP6ZNVFOMV8zcey0YUGzUuvoK9/9OHqwWd5Sl+QuS6+L44gw94g6rfixT47e2ic3CStFoPz5/8=;7:t/d4iKCg+YKRo4czaRSecRxwPQR+Pwkb1g7KbauIpZeP+KCldiwbjkaKt1YWe9emhZSfHIKd3RvuynYZtLPTcActx3lbeypYOzvpnwNqxTb7vQ5PxrFvRnqpfOn9c2plT9fBIRZiTCVU+58rve2POw==
x-ms-office365-filtering-correlation-id: 901b02a4-5d71-4063-11bf-08d660c351e8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3588;
x-ms-traffictypediagnostic: AM0PR0402MB3588:
x-microsoft-antispam-prvs: <AM0PR0402MB3588E89490FDA02E4EFCD2478CA00@AM0PR0402MB3588.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM0PR0402MB3588;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3588;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(366004)(136003)(189003)(199004)(68736007)(26005)(6506007)(52116002)(14444005)(386003)(256004)(6512007)(53936002)(5660300001)(71190400001)(102836004)(71200400001)(4326008)(6116002)(3846002)(2906002)(2201001)(478600001)(39060400002)(575784001)(25786009)(105586002)(86362001)(106356001)(486006)(14454004)(2616005)(305945005)(81166006)(99286004)(476003)(8676002)(8936002)(36756003)(50226002)(81156014)(7736002)(6486002)(66066001)(97736004)(2501003)(6436002)(316002)(110136005)(186003)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3588;H:AM0PR0402MB3570.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: j89R61eOJJ3GLd5n6gKV0hGQbzgdiUa0E1DgD+iu1YWZJ3k1zMvuQLBO/X+6I9AG6MyTePNqDpGfOaXe1wk+DS9gSiA8IRWDPmRcex0AsVeyqHxiU38a5vrf0jDfwIoDZZuZfQ7oPAJcGuI6RoAX/N/5Bs0Z76jXGraTfQldoMAJ5cOzDF432PjMGvqOVzitfpaJygYU1yQvfVszi01oAHtQPP0BIfKzXWIVkwjNQyoij6HyJkBdQzTDAPVEPdPVX/1GLQCJfP0glu5rWZUnUbGzEeuriPTWm/GtyyLm1HNjMSf5NfPHhQDzorXcG81L
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901b02a4-5d71-4063-11bf-08d660c351e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 06:22:13.2649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3588
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

MSI_EN of iMX PCIe RC would be asserted when
PCIEPORTBUS driver is selected.
Thus, the MSI works fine on iMX PCIe before.
Make a double check on this bit, and assert it
when it is not set and MSI is supported.
Otherwise, the MSI wouldn't be triggered although
the EP is present and the MSIs are assigned.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller=
/dwc/pci-imx6.c
index 26087b3..6c3e56b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -74,6 +74,7 @@ struct imx6_pcie {
 #define PHY_PLL_LOCK_WAIT_USLEEP_MAX	200
=20
 /* PCIe Root Complex registers (memory-mapped) */
+#define PCI_MSI_CAP				0x50
 #define PCIE_RC_LCR				0x7c
 #define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1	0x1
 #define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2	0x2
@@ -926,6 +927,7 @@ static int imx6_pcie_probe(struct platform_device *pdev=
)
 	struct resource *dbi_base;
 	struct device_node *node =3D dev->of_node;
 	int ret;
+	u16 val;
=20
 	imx6_pcie =3D devm_kzalloc(dev, sizeof(*imx6_pcie), GFP_KERNEL);
 	if (!imx6_pcie)
@@ -1070,6 +1072,14 @@ static int imx6_pcie_probe(struct platform_device *p=
dev)
 	ret =3D imx6_add_pcie_port(imx6_pcie, pdev);
 	if (ret < 0)
 		return ret;
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		val =3D dw_pcie_readw_dbi(pci, PCI_MSI_CAP + PCI_MSI_FLAGS);
+		if ((val & PCI_MSI_FLAGS_ENABLE) =3D=3D 0) {
+			val |=3D PCI_MSI_FLAGS_ENABLE;
+			dw_pcie_writew_dbi(pci, PCI_MSI_CAP +
+					PCI_MSI_FLAGS, val);
+		}
+	}
=20
 	return 0;
 }
--=20
2.7.4

