Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F548C43610
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F188A20671
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VCo/ZHKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F188A20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeKTTyv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:54:51 -0500
Received: from mail-eopbgr70045.outbound.protection.outlook.com ([40.107.7.45]:62088
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726716AbeKTTyu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 14:54:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkrwOlIe0p0nc1Q29ASMybBvLH+bLhdoWNV6ai411VA=;
 b=VCo/ZHKHfhPAQDTtMNdlDVPqbqu73t1LvjtuYsqbvpTKWdW68KbxFILotET6w+QGuxK5diOSzZ3z45wlUAXD7cH1yebrEitR/gxDU7pA3av5vOwvoP7SUncdeXPOXZ6VNkly/pzZK62rMI9XLkDeyQvKQwnTJ6QDHiMyNkE9uVA=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB5269.eurprd04.prod.outlook.com (20.177.35.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.21; Tue, 20 Nov 2018 09:26:37 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c%4]) with mapi id 15.20.1339.026; Tue, 20 Nov 2018
 09:26:37 +0000
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
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCHv2 10/25] PCI: mobiveil: fix the INTx process error
Thread-Topic: [PATCHv2 10/25] PCI: mobiveil: fix the INTx process error
Thread-Index: AQHUgLMjn4TF2XEFDkS2g0YPrTFmig==
Date:   Tue, 20 Nov 2018 09:26:37 +0000
Message-ID: <20181120092615.11680-11-Zhiqiang.Hou@nxp.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR03CA0050.apcprd03.prod.outlook.com
 (2603:1096:202:17::20) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:aa::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5269;6:WHslZZm6LZmy4Wso0xh4MoJrcgs/sQr3OVNBxXTQ9RwtzdTcFHUsdyuRPIA0I3rAVzA7Hsp7DOTn2eWMucARDy2s94U+cbyiiHsDBhdc/yvf84BQ74T6xxqIsboqd/GdZv4jnyzE4Yxxr2JNJwIoH8IqJmTqRdNtz4Rs3byTUdcyOp3wTT8qqtqKzKYTVlDQ3mkyUrWK77Y6/2lF0Py9KkQhY6/RvBAkLXeCYusFS5PEN3z8tccmd0Khl1awdih5PSffi1GG+4xlr8bgc6wZ+7ocEFM+RrLiKRnaneayM6A5xkcS8R/nTM2FIPE49WpJlkNhxut5AkPoJIXllpr9QipbFho0LGK/7w5N46P8bUWPHH8p4dxgN51nfBIANcfESHsktyAavp9DSF+tt/F8bM4q4LfvsfQnv7NdN37VmcWEk54LzUKYFwTHmE2FHQHCEZyaik9c1zOTxP7/xcgMPQ==;5:+dRr01V7TBlIlWvDiPhZq/jbJgqFE154U+LUyXv8Dzfj06x+2WFPtaR/l37mkcoaeTpMi2C44hAdWKEDbgheEIWM+51nZS9Ixac8Ye87IoaP26ddfonu35oHQV3ZRVTugq9Zh34Z5flGG+9IypRLd7q17LU2I8wNwopqZSb3t5U=;7:7d5gDRjYBcun5G2eq6DnRHj1UmOQplMQB9cHVLzVzAHcAyXdGDMZI9T0otQ8BSNUpZ4O1ooQOAYuX55gq4SKFU481rPXuvd7c+RyaRbkcCXp7Km1vx7ch9nw0H8aO5BOb4ZZIktZZAR2q5R6IWHuIw==
x-ms-office365-filtering-correlation-id: 9d8238e7-3aa1-40d4-6618-08d64eca4581
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5269;
x-ms-traffictypediagnostic: AM6PR04MB5269:
x-microsoft-antispam-prvs: <AM6PR04MB52690F28788586681796D92184D90@AM6PR04MB5269.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5269;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5269;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(366004)(39860400002)(189003)(199004)(305945005)(7736002)(36756003)(5660300001)(7416002)(68736007)(2906002)(4326008)(8936002)(14454004)(256004)(54906003)(53936002)(6436002)(71200400001)(110136005)(71190400001)(6512007)(316002)(2616005)(476003)(446003)(11346002)(486006)(25786009)(2501003)(2201001)(86362001)(52116002)(76176011)(6506007)(102836004)(386003)(186003)(106356001)(26005)(2900100001)(81156014)(81166006)(105586002)(6486002)(8676002)(99286004)(66066001)(6116002)(3846002)(1076002)(478600001)(97736004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5269;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: W9kncstN0BEKoexRNbyTetZD5MBYZUljUjhqurZxgWkxZ6K6vwVvc5NMZw4zYIQl2VvwfJPWAY7wf/10rcBesCe2OXbEES5MVfu7Y0xKE5VmjbDvbsaQV5HA5FSU0Ov1XaJfdxAd+4y/YVG0FIOR7/7/j4tl87QaQgIw3MJxuV52ycx1rLJFgF2vWNqtYJab+A8JvCbuysTctb9t99gb+ICMoc8swXRtJkiLssg2Rk+zVy0O4BV0NGgj23SDCHGbv5ihIDBmCItYQz1F9Dpkg1hxG0BX/cgPPhFqlmc6sD2xCWCGJjlyoBMhfYp31GKtp+1xy9/wH474dLQs7DxhAm95ywtkZ/jI2/y1EaKn4p8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8238e7-3aa1-40d4-6618-08d64eca4581
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 09:26:37.8472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5269
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

In the loop block, there is not code change the loop key,
this patch updated the loop key by re-read the INTx status
register.

This patch also change to clear the handled INTx status.

Note: Need MV to test this fix.

Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host
Bridge IP driver")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - Added fixes entry.

 drivers/pci/controller/pcie-mobiveil.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index 4ba458474e42..78e575e71f4d 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -361,6 +361,7 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
 	/* Handle INTx */
 	if (intr_status & PAB_INTP_INTX_MASK) {
 		shifted_status =3D csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT);
+		shifted_status &=3D PAB_INTP_INTX_MASK;
 		shifted_status >>=3D PAB_INTX_START;
 		do {
 			for_each_set_bit(bit, &shifted_status, PCI_NUM_INTX) {
@@ -372,12 +373,16 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
 					dev_err_ratelimited(dev, "unexpected IRQ, INT%d\n",
 							    bit);
=20
-				/* clear interrupt */
-				csr_writel(pcie,
-					   shifted_status << PAB_INTX_START,
+				/* clear interrupt handled */
+				csr_writel(pcie, 1 << (PAB_INTX_START + bit),
 					   PAB_INTP_AMBA_MISC_STAT);
 			}
-		} while ((shifted_status >> PAB_INTX_START) !=3D 0);
+
+			shifted_status =3D csr_readl(pcie,
+						   PAB_INTP_AMBA_MISC_STAT);
+			shifted_status &=3D PAB_INTP_INTX_MASK;
+			shifted_status >>=3D PAB_INTX_START;
+		} while (shifted_status !=3D 0);
 	}
=20
 	/* read extra MSI status register */
--=20
2.17.1

