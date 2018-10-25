Return-Path: <SRS0=18Ni=NF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA62C46475
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 08:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B69C20824
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 08:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eIJmSpTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B69C20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbeJYRZf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Oct 2018 13:25:35 -0400
Received: from mail-eopbgr70079.outbound.protection.outlook.com ([40.107.7.79]:25279
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726497AbeJYRZf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Oct 2018 13:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6u/vd9XnRlzcWJoGqbjkfGFj9f32t51Rgskr3Yeed6c=;
 b=eIJmSpToK12RD6A30olk4TfYd9Skfq01guW1kzktFaenjB1xPlwxL4tGhn16LTeBHHGUbeDrAXrYkp8cO1w0CfjJbCfrZ7bLql2z32vx564IiWTPtBv9dwmoEBXy/1HSk06CfoVt2cE/15AdlbeUwkxhE2wRet610DjJAv0EN0k=
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com (10.162.155.27) by
 DB5PR04MB1352.eurprd04.prod.outlook.com (10.162.220.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.18; Thu, 25 Oct 2018 08:53:37 +0000
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb]) by DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb%2]) with mapi id 15.20.1250.028; Thu, 25 Oct 2018
 08:53:37 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     Roy Zang <roy.zang@nxp.com>, "M.h. Lian" <minghuan.lian@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCH] PCI/Layerscape: fix wrongly invoking of outbound window
 disable accessor
Thread-Topic: [PATCH] PCI/Layerscape: fix wrongly invoking of outbound window
 disable accessor
Thread-Index: AQHUbEA3bQ9DeLR/KUmsy7zvrJJQ8w==
Date:   Thu, 25 Oct 2018 08:53:37 +0000
Message-ID: <20181025085323.8819-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0011.apcprd03.prod.outlook.com
 (2603:1096:203:2e::23) To DB5PR04MB1221.eurprd04.prod.outlook.com
 (2a01:111:e400:51c2::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB5PR04MB1352;6:+wMFMmT7YHGO1hOQEgB5+2mJGAR/qpklfoXfrgBO3EpO1tc+WcxfTDM1tWVYIbP7p87cMpiIyxTYLOAMYe8wAml1OtE8X49ETRKxr5clCKFqjhm3sPXv99IvRyEW5YsxfhzYYNCYtiwt5MeFDf7tblbpug0To3GYKq0vM5A3QiG8U3M+f4QyKDAykHcgXd4FJT8BWFU8/VaJ7Ou5iyNfXvLQdvpuGYbxQtXDsLH1DmzeLjmBhXqHdHwUsOqwlvPFYSC+imwimbJzKquUrS+g3rv/XMiZiydmmJrZHyWiLkUlzL6KjoRZgY9T+5WTXDFVz1HePMIAWI1KQNhzDvIlRA83zJy2LqxvUPYhbuffH+B48/9vyurmWlhuAMDld51I1rDtJxzgp5CVe5CmiVjg5cuirpEYZ6db3eR2pCTjUn8gd9RY+db1Y93EQ6JyplHWXLIY1B7ol1NJldpZ6Kzx6w==;5:i33YPyRjeYUtpB8GQI4YG/e17NeDJsz7St+91f1BWdJxEGDh0M+VpwhU4WZ9pdUkXrrkyw+STeA4+r1cmtGIZqyIXrOG/ZwXcylSeKf+pE/666J5aZxBCzqfQo3APtxGKcgGJ7PT0eX/TN2ufqljKXISTZA3CV5ijNOmFIFv89g=;7:fvGIBf3u/8+HDgUNavqEZ6aWrb9WPxCRWfEAday0N1eVzVpJ2YpdJjcPNG/gYGs06+FzWjOGsyWAZl/+klsSknTcZQ9KCouOc6OsbdSAlS9IHQdmZgc26C4+qr20856CqaT5jljC/L51TLIUPe7fiw==
x-ms-office365-filtering-correlation-id: 2a476bd7-29d1-44f3-c9eb-08d63a5759d7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1352;
x-ms-traffictypediagnostic: DB5PR04MB1352:
x-microsoft-antispam-prvs: <DB5PR04MB1352C8B4734AB8A06E14774E84F70@DB5PR04MB1352.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB5PR04MB1352;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1352;
x-forefront-prvs: 083691450C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(376002)(396003)(346002)(199004)(189003)(110136005)(71190400001)(316002)(386003)(52116002)(6506007)(99286004)(36756003)(81156014)(68736007)(102836004)(66066001)(81166006)(8676002)(26005)(7736002)(305945005)(186003)(86362001)(2201001)(8936002)(71200400001)(2616005)(97736004)(4326008)(476003)(2501003)(478600001)(106356001)(1857600001)(6512007)(5250100002)(53936002)(486006)(5660300001)(105586002)(14444005)(6436002)(54906003)(14454004)(2900100001)(25786009)(6116002)(1076002)(6486002)(2906002)(256004)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1352;H:DB5PR04MB1221.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qF+tGcR77arf0j0d6yXdaCsqs3lyIVTXNThQPnu/VOKNDLlTMKwXWX/dpXJaKA/RqxblFbAs2GeFW0mJn1fmwGnQFARpEm2NIMYE2mSDbb92PzaRBRjJP/NatvP/1fiUUdukknjZrgAUmoIgT8r09eYAEqpf5OgKXlrudVsvy0KHvgmp540HcQ4ruAmgKrd4ecOU2tMjUbRP2XxW6OIqZgpVdiKQMXXh/2YUoxyamXNCfNqQBApr7NyRCcbriXY3+Wsv90Dneb/gdJA9IbTWpTvnEYAaozyMIpteM3IFA/eHo+Rwoxdzfd8gB+AvfBCJO0HUp1OXzpCTiYGk9iPBqhU5LhibSugejXRS8zC7AOk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a476bd7-29d1-44f3-c9eb-08d63a5759d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2018 08:53:37.4790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1352
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

This issue is introduced by commit 4a2745d760fac ("PCI: layerscape: Disable
outbound windows configured by bootloader").

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/pci/controller/dwc/pci-layerscape.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/cont=
roller/dwc/pci-layerscape.c
index 69f3f1a5a782..b2085988dbee 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -88,7 +88,7 @@ static void ls_pcie_disable_outbound_atus(struct ls_pcie =
*pcie)
 	int i;
=20
 	for (i =3D 0; i < PCIE_IATU_NUM; i++)
-		dw_pcie_disable_atu(pcie->pci, DW_PCIE_REGION_OUTBOUND, i);
+		dw_pcie_disable_atu(pcie->pci, i, DW_PCIE_REGION_OUTBOUND);
 }
=20
 static int ls1021_pcie_link_up(struct dw_pcie *pci)
--=20
2.17.1

