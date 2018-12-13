Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE67C65BAE
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 10:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3C520880
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 10:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sM9anPT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3C520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbeLMKnj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:43:39 -0500
Received: from mail-eopbgr20086.outbound.protection.outlook.com ([40.107.2.86]:19280
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727849AbeLMKnj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Dec 2018 05:43:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0T5hgUJYFckQxMcJOQM2Ua84q6eMhui/0oWz7NUgog=;
 b=sM9anPT18cO2Ku7eZuxdj6rncOigMxzwSFfL/r3LqudaT47TZRiGlVJSWhIRkVT6Pc1tXafBOYsB9jaUgs6SEq77w7fzBEtOOex/DEISggAq0R3HaAY9MzlDyOm16hUrss/aPmjzlC3pnDRL7Gbn2feksmoQpQoAwyCn7MVxJXs=
Received: from AM0PR0402MB3570.eurprd04.prod.outlook.com (52.133.46.11) by
 AM0PR0402MB3650.eurprd04.prod.outlook.com (52.133.38.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Thu, 13 Dec 2018 10:43:34 +0000
Received: from AM0PR0402MB3570.eurprd04.prod.outlook.com
 ([fe80::94f8:5fdd:f384:8af8]) by AM0PR0402MB3570.eurprd04.prod.outlook.com
 ([fe80::94f8:5fdd:f384:8af8%8]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 10:43:34 +0000
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
Subject: [v3] PCI: imx: make msi work without pcieportbus
Thread-Topic: [v3] PCI: imx: make msi work without pcieportbus
Thread-Index: AQHUktCyRGVvwC2XMkWenSTFQUhPMw==
Date:   Thu, 13 Dec 2018 10:43:34 +0000
Message-ID: <1544696723-1673-1-git-send-email-hongxing.zhu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::16) To AM0PR0402MB3570.eurprd04.prod.outlook.com
 (2603:10a6:208:1c::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hongxing.zhu@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR0402MB3650;6:aPcEzt95eqRaVchLRzvuhO/45R+mI3/K6N9UXoHPY+IuO9Xgygx0zvERDhdw6/ityu3bEuJWP0tYhk+kPx+cVWO8UTeVhrsUUs0Gkmb3k1PvpnKdwtqrXLXDbZ7yhkFL+/8S7Jjl2vaWmT9cVxXLB8WupR0MOnsI25ve2oYXXO1Y+5QHDPvEyhPW/+thpAf3wAkD7r9Ki8yBl9lYsm8/PuFb1PhSWcKaJrWw2Qt/gfn63/ULjMY/4sUG2edetdAc3TyaBpG99xyVSG95GGPQ8YhosAhRchTURwiZ4Ddtte+fflHP28tfcZFyYf1lcJXMe3OGEuaKI8zOJbwjkr4/FyWc4Mo7WIieBALImiYiOqL6rzyMYZsulW85mCQJ9GT4KBIN2UnOoG+Zpo0fwWs2UP8g7S2X6HgIKWHyAISHokTT8ORH1iwlZq2FMmhwUbs0FQ9dncbjIQo6hsoL7kxCSQ==;5:hxgylD/8GrHpfah6biYE0eiMhlGEC/sIfgNHfK1ikiCx5QqLUp9m9BJygqjs19rxXImfhFgcdS7tFzlOCK5PW0alOZX7s/vXnMRYxwC7XgkGnFmi75iz0bfRYMDhXutzqgTbkspM97fMQ8A9w/fZd9G53yTgfImLqFfgPPvmFso=;7:s6wNMu6X+9kEvFGRUtUCsz1ZhBXMT2p3y7uItZZBAwETJJbeyx87tvCtFLXrGohNfAvmljTUNPR8P9GM+x7wPsM3CJTxxuj3X3FScry4H4KNnLm39BY0FXrxVL3RKh67iDZHKMQjIkGIfUWRvc9Jpw==
x-ms-office365-filtering-correlation-id: 2dda1c00-6e07-45b1-02d4-08d660e7d4a7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3650;
x-ms-traffictypediagnostic: AM0PR0402MB3650:
x-microsoft-antispam-prvs: <AM0PR0402MB365009767CAF50043AC937D98CA00@AM0PR0402MB3650.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM0PR0402MB3650;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3650;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(136003)(366004)(346002)(199004)(189003)(256004)(66066001)(14444005)(7736002)(68736007)(476003)(6486002)(2616005)(71200400001)(71190400001)(186003)(6436002)(5660300001)(36756003)(26005)(25786009)(305945005)(575784001)(99286004)(102836004)(2906002)(486006)(52116002)(86362001)(2201001)(97736004)(4326008)(6116002)(3846002)(316002)(50226002)(106356001)(14454004)(105586002)(386003)(478600001)(39060400002)(8936002)(54906003)(110136005)(6512007)(2501003)(6506007)(8676002)(81156014)(53936002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3650;H:AM0PR0402MB3570.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3kwfNsfq9z6ZZQpu36d3pFIGJ49LY6we4ST5i5EB4BmeBflBxsx+OlbueqJvzZZmefsgtvfxvZsOnj/cdnfCxbqTvTN4/g4Z/jG3CM4sy0+I1k2n9EZnWBsYq/EchI5px5weytwgpzLl1ILBzl8B6kYcHGkffZPPdzPxMxarA9o5LBCTGahbZaD5ltLLXkwYIq9IBhXnnoz337B2OUFeaDoFcIJJQxRzkVuiKy0ts8QQ/o9OdbBqPSKh0C348pH+IuqcdnKZM+QqmAyH5yQVoaQ2x+xz+v8aW6o3/LMfafdHg/42nA4ZshWBefV+L0iQ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dda1c00-6e07-45b1-02d4-08d660e7d4a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 10:43:34.5723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3650
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

MSI_EN of iMX PCIe RC would be asserted when
PCIEPORTBUS driver is selected.
Thus, the MSI works fine on iMX PCIe before.
Assert it unconditionally when MSI is enabled.
Otherwise, the MSI wouldn't be triggered although
the EP is present and the MSIs are assigned.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
Changes v1 -> v2:
* Assert the MSI_EN unconditionally when MSI is supported.
Changes v2 -> v3:
* Remove the IS_ENABLED(CONFIG_PCI_MSI) since the driver
depends on PCI_MSI_IRQ_DOMAIN
* Extended with a check for pci_msi_enabled() to see
if the user explicitly want legacy IRQs
---
 drivers/pci/controller/dwc/pci-imx6.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller=
/dwc/pci-imx6.c
index 26087b3..1c59a93 100644
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
@@ -1071,6 +1073,12 @@ static int imx6_pcie_probe(struct platform_device *p=
dev)
 	if (ret < 0)
 		return ret;
=20
+	if (pci_msi_enabled()) {
+		val =3D dw_pcie_readw_dbi(pci, PCI_MSI_CAP + PCI_MSI_FLAGS);
+		val |=3D PCI_MSI_FLAGS_ENABLE;
+		dw_pcie_writew_dbi(pci, PCI_MSI_CAP + PCI_MSI_FLAGS, val);
+	}
+
 	return 0;
 }
=20
--=20
2.7.4

