Return-Path: <SRS0=4gsO=O4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCDCC43387
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 04:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2E8217D6
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 04:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qzazQAjQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbeLSEpK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Dec 2018 23:45:10 -0500
Received: from mail-eopbgr70058.outbound.protection.outlook.com ([40.107.7.58]:38322
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726614AbeLSEpK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Dec 2018 23:45:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9R2lMLyZWD4okQUX5naDOXa38kVgVX1tBO46aI1Xog=;
 b=qzazQAjQTKpRnk7ZE6MTMjePDL5jgTgZwjGfqbaeYLow0GjNXias5L1OrbeBp5ffK+5w2JE/2ruQYY1IF5cKMUFxIouDSWmG/i0eY5BSDUa/uyu17Tji4/tO/V5DtEkcjqzlqU3PVRsDzWevEEJ3lIRseG8Q1W5fY3fik861cWQ=
Received: from AM6PR0402MB3573.eurprd04.prod.outlook.com (52.133.20.10) by
 AM6PR0402MB3366.eurprd04.prod.outlook.com (52.133.18.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Wed, 19 Dec 2018 04:45:04 +0000
Received: from AM6PR0402MB3573.eurprd04.prod.outlook.com
 ([fe80::7862:1b29:2780:1864]) by AM6PR0402MB3573.eurprd04.prod.outlook.com
 ([fe80::7862:1b29:2780:1864%2]) with mapi id 15.20.1446.018; Wed, 19 Dec 2018
 04:45:04 +0000
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
Subject: [v5] PCI: imx: make msi work without CONFIG_PCIEPORTBUS=y
Thread-Topic: [v5] PCI: imx: make msi work without CONFIG_PCIEPORTBUS=y
Thread-Index: AQHUl1WbXQWlL+2nZEakdL9950YJ4A==
Date:   Wed, 19 Dec 2018 04:45:04 +0000
Message-ID: <1545193599-11604-1-git-send-email-hongxing.zhu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0074.apcprd03.prod.outlook.com
 (2603:1096:203:72::14) To AM6PR0402MB3573.eurprd04.prod.outlook.com
 (2603:10a6:209:8::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hongxing.zhu@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3366;6:NZzwKs6OKWPs+AL/kjRUOc+dD91hvwcDCBT/yQq1oMxTxT84quVMmes+uOWj8jFkzUuC6UXNXITLnYrkiPT+cafSN8Ziu93f6piqL0EYePskH+2Iczn2t03G5xvMN2jdMsdAKr73fYXwvAjikxXnF/QA4+49N1niYVTyJpc5sl6HazIv0LN9MGsYPXFK2DkEx0g/jyQiXJLVzKaBIfHQK62pysPGgIjinshALR06+V4bBjQGxoZg4m73xVtpr35qI/SL5ZbxJc251pWe8qdtWdJJ0kP9A5Prl48HobAca4reX4C+HshKO7x52sP4WwJtGdaQUV27/ZxR++RnAvoCrwXzuCGqBDfZTNSkkAhzpnb9YgBa8x24YtOU7PQyCMncuIPCgv/1Qhhc+0a91cmBpwS7MHNfvWjHGWmk84Jc9g59BMmrViFZBowsYbkdtPOoxD7eUgZDQR7DFGYDPrBzDw==;5:VaWZ1lTB5X/GQX/iSwj0JL3IMdTAKHnr+Hj7uCwaWa+Ftvrm0g5AXQxXblzZ8oR6MOPzXc0y9UfC4sFuMC6/CjbsuvTgeMhrNsqnLZ4oOcGH3Zc1srXNevKfm473CJI5ks623jEN4fre0vxJ7Wsswo/QNe7Dftjru9uHh7OuyiU=;7:807UXX+u303G/l4lctT5WqVQa+dl86IvdW4V6SMzSJVQ7mshF4ldVAvEg+pvreOZwvoi6Un5W0TfL44qijfBZKGJGsEuXkiplsKzhYlotqixQFrIKImbJR2tCNn2jO2AYOdvKeCB494Nkez8FR6E5w==
x-ms-office365-filtering-correlation-id: 970f17af-407d-4b1b-5f03-08d6656cbdd3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3366;
x-ms-traffictypediagnostic: AM6PR0402MB3366:
x-microsoft-antispam-prvs: <AM6PR0402MB3366B95BE477108548E6EE658CBE0@AM6PR0402MB3366.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3366;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3366;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(346002)(396003)(366004)(199004)(189003)(71200400001)(99286004)(14454004)(71190400001)(66066001)(4326008)(6436002)(105586002)(6486002)(97736004)(39060400002)(14444005)(26005)(256004)(305945005)(3846002)(186003)(68736007)(6116002)(7736002)(25786009)(2906002)(476003)(6512007)(8936002)(2616005)(316002)(486006)(2501003)(52116002)(50226002)(36756003)(2201001)(575784001)(86362001)(110136005)(478600001)(53936002)(54906003)(8676002)(81166006)(386003)(81156014)(6506007)(106356001)(102836004)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3366;H:AM6PR0402MB3573.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IkFP4YpKB6/lyvlQ5+tRSKpTMs44YAPlegYmkM6vTwwXkz1RZ4YSkaJuY8A6Za3/4J7FTyHZW0eGpJa3X9zxWCVi7JVx+UkFFThV4tC+snofio3RNu+Jk937V8aJMaWcMqhLGPz+MzcZYDwgWgWR7PUYS5mCTgVolWV8UF4SAqdYBJTrL+lHFR4sHp77ZidWccY1ckQzc0l7UBi4m+QluRgfbVo6UHa5T+pqZ43JZmkPm5LcnBipvK5aCUaM/b0TOEWRBIDxCCXCGD32lL7Qz1XpDVfUXOf6hYF/ccOwqDzo7Ipb+zfjaf9LAbCSIBPj
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 970f17af-407d-4b1b-5f03-08d6656cbdd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 04:45:04.4029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3366
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Assertion of the MSI Enable bit of RC's MSI CAP is mandatory required to
trigger MSI on i.MX6 PCIe.
This bit would be asserted when CONFIG_PCIEPORTBUS=3Dy.
Thus, the MSI works fine on i.MX6 PCIe before the commit "f3fdfc4".

Assert it unconditionally when MSI is enabled.
Otherwise, the MSI wouldn't be triggered although the EP is present and
the MSIs are assigned.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
Changes v1 -> v2:
* Assert the MSI_EN unconditionally when MSI is supported.
Changes v2 -> v3:
* Remove the IS_ENABLED(CONFIG_PCI_MSI) since the driver depends on
PCI_MSI_IRQ_DOMAIN
* Extended with a check for pci_msi_enabled() to see if the user
explicitly want legacy IRQs
Changes v3 -> v4:
* Refer to Bjorn's comments, refine the subject and commit log and change
the PCI_MSI_CAP to PCIE_RC_IMX6_MSI_CAP.
Changes v4 -> v5:
* Correct one spell mistake from PCIE_RC_MSI_IMX6_CAP to
PCIE_RC_IMX6_MSI_CAP.
---
 drivers/pci/controller/dwc/pci-imx6.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller=
/dwc/pci-imx6.c
index e563ca9..73542dd 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -82,6 +82,7 @@ struct imx6_pcie {
 #define PHY_PLL_LOCK_WAIT_USLEEP_MAX	200
=20
 /* PCIe Root Complex registers (memory-mapped) */
+#define PCIE_RC_IMX6_MSI_CAP			0x50
 #define PCIE_RC_LCR				0x7c
 #define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1	0x1
 #define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2	0x2
@@ -999,6 +1000,7 @@ static int imx6_pcie_probe(struct platform_device *pde=
v)
 	struct resource *dbi_base;
 	struct device_node *node =3D dev->of_node;
 	int ret;
+	u16 val;
=20
 	imx6_pcie =3D devm_kzalloc(dev, sizeof(*imx6_pcie), GFP_KERNEL);
 	if (!imx6_pcie)
@@ -1149,6 +1151,14 @@ static int imx6_pcie_probe(struct platform_device *p=
dev)
 	if (ret < 0)
 		return ret;
=20
+	if (pci_msi_enabled()) {
+		val =3D dw_pcie_readw_dbi(pci, PCIE_RC_IMX6_MSI_CAP +
+				PCI_MSI_FLAGS);
+		val |=3D PCI_MSI_FLAGS_ENABLE;
+		dw_pcie_writew_dbi(pci, PCIE_RC_IMX6_MSI_CAP +
+				PCI_MSI_FLAGS, val);
+	}
+
 	return 0;
 }
=20
--=20
2.7.4

