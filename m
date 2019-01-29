Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42587C282C7
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E5A214DA
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="so85RMrY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfA2IJk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:09:40 -0500
Received: from mail-eopbgr50084.outbound.protection.outlook.com ([40.107.5.84]:39074
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725775AbfA2IJj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 03:09:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXs1eY0JXgsUFYdVarct8m0g+545mZKC3TxcZS29uUs=;
 b=so85RMrYlkjblyXCYTfB3DqdU2+xoRRVaTK5ydyMFMEbLu/cHQZUg5wyzxPOILJHdEeX6WADgAZrxFPQ+VNzwfuCtMQTUB4BKDGvqa+v4ecZuvt5eNqvvDzdzyVZimaFDqWLmQXtyTGj/cONwm8ytTirgt2W6AthaWKwLgwCEY0=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5784.eurprd04.prod.outlook.com (20.179.2.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Tue, 29 Jan 2019 08:09:32 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:09:32 +0000
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
Subject: [PATCHv3 10/27] PCI: mobiveil: fix the INTx process error
Thread-Topic: [PATCHv3 10/27] PCI: mobiveil: fix the INTx process error
Thread-Index: AQHUt6n275W+OwpbVU6CNVNwAnWSvQ==
Date:   Tue, 29 Jan 2019 08:09:32 +0000
Message-ID: <20190129080926.36773-11-Zhiqiang.Hou@nxp.com>
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:203:36::20) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:ad::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5784;6:lsqozMFvO8h8N/azT4Y8Sye3o//1TZJP23R+r5l3q+p5mVkY2uqeyXHbBWFVu6bLSYeo72mOqtwxrfiEXBNzTIjXcPxRylLCVdEjVpsoL2TCJBTJ9OKZyheBGASduzHFeWCL2TPHvQVVwm22AD6fWu68Xmfy0tvj0oSu4tBMSaaydEmBee4MJm3A2l2rNWAIheausuMKho4G3r14e32i6Ry5UH2ngsDJRoSujuFuAXEeOixqZ8zbNdv0h9pradOJlN/lPwyWxPxe+wuJTsnHevymjNzymWoX7mkvaHH68Yb+qy87vZgC0qC3dxzbwEiBL5A4kQ9ttE+9o3qIOX3ED2kF+82lMVW6kRiiTHOTpkv1Mzt+Y/BClCS3FVyDSkHqzBpV3v2JNZmu0WoWw0LbfhqduR5ha9skrx59HR+E2hxTTinluudk+jB8nKqQ6EvcJrvaYkhirQvSjB+OS1F75Q==;5:MW5GgaBYvDVZCQ7aTXdAR/zKCEogSkfzl0N9hDN4jd9ct0SgPnG/sOR2GS/p7/w6T9qH9AEx92PxbcROuUtEg8XZ3a85y3GTatjMpv9xwmbnt0u+9HOnVIx6HO31Dz1ctmLS16xm9GtMBNTASY/qjTxTbPio5rQMPOIkIjiITVqfug1CZlNLFUKS/PbF/0+GdCV+4dirbDfwitMqe61VqA==;7:EDqY3PrPPdWlzJKf5Ce4RdilJ+CxSNBHg2qkmZkLvImY7AYWxEWVFFk/Ii0CTjVeuBzsYkKQsweJ62dF6kja7XBmqsc6rdPAND+5+oclQu4dmxBQgOoWcsrkqNFF95MYlfxapO2F1P9EAjBfha+tjw==
x-ms-office365-filtering-correlation-id: 9035fb93-aefa-4732-4cf3-08d685c11945
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5784;
x-ms-traffictypediagnostic: AM6PR04MB5784:
x-microsoft-antispam-prvs: <AM6PR04MB57846DA3E9FF3A87210292D384970@AM6PR04MB5784.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(366004)(396003)(39860400002)(189003)(199004)(3846002)(105586002)(6506007)(386003)(71200400001)(71190400001)(26005)(305945005)(66066001)(7736002)(106356001)(4326008)(102836004)(68736007)(6116002)(2501003)(25786009)(8936002)(8676002)(81166006)(81156014)(50226002)(97736004)(486006)(256004)(476003)(99286004)(6436002)(186003)(6486002)(7416002)(2906002)(14454004)(110136005)(1076003)(2201001)(316002)(478600001)(86362001)(53936002)(446003)(36756003)(6512007)(54906003)(76176011)(2616005)(11346002)(52116002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5784;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nSJh4BsFTkalI82L0yM8l7fqcPTncZGqMhDDkAQgDpGZzg5tQYX2sopTVG5HinFumNbYDeeS39nFVJxocZFwyak2N4tNTO7KK+47hyocfYwJjMwZDtH6+b3DoyVeCpOZsCLTaOkhfbxx+9qDRU10w/Ec03sEOK1bLvybdLlNyZl6Axa6uqeVA/zrHdxe79K3K0AoWYmDbFx3pgtKRFg0t8x0fPuEBd8QNZ21JJpj/dbTYx6uNMSbNjzFBCCQl6rvAYyjVkzudtKmxbQgNJGrY1SfBfqwG/s/W/NkKp3mPiw/m+ItV1jlafnRXfLBTIM7bqB+yIizcS8fu63j2Nd7PpR2zqe80xJccGAw8g74uDvk9AaxMJFODQPcJ5swXhYzjv81loY3bs8kS5UJ6SMuVdFp15/RMSMoLqPjnSNulaw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9035fb93-aefa-4732-4cf3-08d685c11945
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:09:26.2720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5784
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
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
V3:
 - No change

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

