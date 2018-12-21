Return-Path: <SRS0=Xdj1=O6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8086C43387
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 04:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCE02186A
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 04:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YNmvigR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbeLUEd4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Dec 2018 23:33:56 -0500
Received: from mail-eopbgr70085.outbound.protection.outlook.com ([40.107.7.85]:31968
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727976AbeLUEd4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Dec 2018 23:33:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pvrTvDPlZ1AbzH6dOf6medo/eBpnpw/VonWXMEIc/w=;
 b=YNmvigR7BNtBMft6VBH0tG1d7ZJna3e33hVtzcbpMUPFRF/0r65O6vta+DwCDaU1Q/4rE0eL5cgJtDQEHxJiduBn03tl9COOprmaTzPGychkrNTvERD3znylgdPmg8LQNJf4JETDVxiVQn3K0C7Yw40RK4FaV9h/0vsyLV1COoQ=
Received: from AM6PR0402MB3573.eurprd04.prod.outlook.com (52.133.20.10) by
 AM6PR0402MB3557.eurprd04.prod.outlook.com (52.133.19.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.21; Fri, 21 Dec 2018 04:33:38 +0000
Received: from AM6PR0402MB3573.eurprd04.prod.outlook.com
 ([fe80::7862:1b29:2780:1864]) by AM6PR0402MB3573.eurprd04.prod.outlook.com
 ([fe80::7862:1b29:2780:1864%2]) with mapi id 15.20.1446.022; Fri, 21 Dec 2018
 04:33:38 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "TheSven73@googlemail.com" <TheSven73@googlemail.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: [v6] PCI: imx: make msi work without CONFIG_PCIEPORTBUS=y
Thread-Topic: [v6] PCI: imx: make msi work without CONFIG_PCIEPORTBUS=y
Thread-Index: AQHUmOZXutAsHiyvt06v7QdQeB+h1A==
Date:   Fri, 21 Dec 2018 04:33:38 +0000
Message-ID: <1545365708-13086-1-git-send-email-hongxing.zhu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0021.apcprd03.prod.outlook.com
 (2603:1096:203:2e::33) To AM6PR0402MB3573.eurprd04.prod.outlook.com
 (2603:10a6:209:8::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hongxing.zhu@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3557;6:6HUUWU7Ylyq83ygiwKaD0U/NMoCPnKQKCOFXIi0LxGENFizQLoAOEMXOzMDGcYjbeOYsaNFm8EdBa9OICDCcTAVsUTX9UiO1dpE+OtMrOzOlrkK1bE6aZqEGCioEFuXlsHJ/hLQonPvp/jE4haxuSZIy6a4PqFYkOhVzKharcTqGVJgL++U+NuTL2098AP2Jh0sGJMRNN5kUB4La3nZTsZjVRKbQ4+emVSPOUVUvLL2lBIrPP7/bZKQj+yGrpOup2eorMptrZYj0rp0XX46f0lTEOmwxMNBnxzG5pys6sscLpfxTyfzMvKJVAafgvjt5FSrBSU9dKgnf/NbbIrKAB/MwrDZk0CKIxjiVpajoPu9Igw716jkHuCU2YCJoqH9HZsU9pmnq4C4nJl3d4kqFnVcKAbq/fs0Nyaxep89Tg428gz15bglr5UDSXdzKJPrCQik7qMKuEd/4rV9PPq/8gQ==;5:yLlTR1V4xMBzQ/O66o/hoyp8FIEClY73DposvoFZ8YozUJ8qaPwfNfyGAJKQzZ8dSvrDqlHsEirqB0IpVUTBSKXp/sbcX7vXj1pE0/MhSi2RXWtnvas1BwY9BKnSIvxRpDrf1EYajdklfuEgnBz8jr5ibC75qUq1AxQBE82oXlU=;7:P9fO/HdDamyAZl8WVd4bTFYOPWKayvITFK7ylCO9SLqWX0Wub4McvTNxSxi8akH1s80c8XkAvHejG9w+ZxkIxewEOIRkOHpSYLkEasyakg1quISN5XO5VkXTP1wO0i9+uGLXua8jBaA6V7X4oZekGg==
x-ms-office365-filtering-correlation-id: 755169f7-ba2b-4033-8a54-08d666fd7a45
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3557;
x-ms-traffictypediagnostic: AM6PR0402MB3557:
x-microsoft-antispam-prvs: <AM6PR0402MB3557FC345822A6B23A5B97D68CB80@AM6PR0402MB3557.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3557;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3557;
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(376002)(346002)(39860400002)(189003)(199004)(3846002)(8676002)(6116002)(486006)(50226002)(7736002)(8936002)(81156014)(68736007)(81166006)(305945005)(99286004)(54906003)(110136005)(105586002)(106356001)(2501003)(316002)(5660300001)(6486002)(6436002)(97736004)(66066001)(6506007)(386003)(36756003)(478600001)(71200400001)(71190400001)(102836004)(39060400002)(4326008)(25786009)(2906002)(6512007)(26005)(14444005)(256004)(186003)(14454004)(53936002)(86362001)(575784001)(2616005)(476003)(2201001)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3557;H:AM6PR0402MB3573.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: oEEC6hoPDOztjoNWPp7IOgoVp340qKNqj5a9aBzosgEKCEgllAI4VHAlY+uZEkWVLiDkg5F2tQqX/O8iJUmeos1KvqbLwbz9F+ufzHg1jZ5uu9x+wFexiKjJp61VCk0Z4DKIVCvRKaZXXy7r3b6M3Mr/HF6NziaJhK7pgIZnMu+MN2C57SDKRXtSMT/XiU2ZEW5qvQ92tPulHA9EvtChWf+w4JgzVb5DQzE0dmjDvVOrhUqU792q7gUfWmmU/onzP4sCZglHtfM8Tl5TxkzjoCmLVuzEmvmdcqZiCjC54crd1I78f1OkaXvpOYHL3ELo
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 755169f7-ba2b-4033-8a54-08d666fd7a45
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 04:33:38.6921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3557
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The MSI Enable bit in the MSI Capability (PCIe r4.0, sec 7.7.1.2)
controls whether a Function can request service using MSI.

i.MX6 Root Ports implement the MSI Capability and may use MSI to
request service for events like PME, hotplug, AER, etc.  In
addition, on i.MX6, the MSI Enable bit controls delivery of MSI
interrupts from components below the Root Port.

Prior to commit f3fdfc4ac3a2 ("PCI: Remove host driver Kconfig selection
of CONFIG_PCIEPORTBUS"), enabling CONFIG_PCI_IMX6 automatically also
enabled CONFIG_PCIEPORTBUS, and when portdrv claimed the Root Ports,
it set the MSI Enable bit so it could use PME, hotplug, AER, etc.
As a side effect, that also enabled delivery of MSI interrupts from
downstream components.

After f3fdfc4ac3a2, the imx6q-pcie driver can operate without
portdrv, but that means imx6q-pcie must set the MSI Enable bit
itself if downstream components use MSI.

Fixes: f3fdfc4ac3a2 ("PCI: Remove host driver Kconfig selection of CONFIG_P=
CIEPORTBUS")

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Tested-by: Sven Van Asbroeck <TheSven73@googlemail.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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
Changes v5 -> v6:
* Update with Bjorn's commit.
* One "commit" added in "Prior to f3fdfc4ac3a2" refer to the complain of
checkpatch.pl.
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

