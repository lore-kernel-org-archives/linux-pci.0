Return-Path: <SRS0=mLR+=OX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB41C67839
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 06:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CE320866
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 06:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WA2hL9u5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8CE320866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbeLNGoT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Dec 2018 01:44:19 -0500
Received: from mail-eopbgr60060.outbound.protection.outlook.com ([40.107.6.60]:36223
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727179AbeLNGoS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Dec 2018 01:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OulzC/eyu6I3AFh6MTraStAHRz2PIDcUqxH16bJ394Q=;
 b=WA2hL9u5JNHlHYqJDNxLvDsXKHaV6JR0exgI60ez3gosQxSfnieOCsDa/cUShv4GGtommwHTjpW3VfUF0qa5vaRrbsss2KeiYBYaIqX7d2JMBKdwFlikVuqlVucI2/OjXz3lG8z8OAiCq4FV6x50QHaMqt4jQncQ+4jSPq1ZIFw=
Received: from AM0PR0402MB3570.eurprd04.prod.outlook.com (52.133.46.11) by
 AM0PR0402MB3491.eurprd04.prod.outlook.com (52.133.45.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Fri, 14 Dec 2018 06:44:15 +0000
Received: from AM0PR0402MB3570.eurprd04.prod.outlook.com
 ([fe80::94f8:5fdd:f384:8af8]) by AM0PR0402MB3570.eurprd04.prod.outlook.com
 ([fe80::94f8:5fdd:f384:8af8%8]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 06:44:15 +0000
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
Subject: [v4] PCI: imx: make msi work without CONFIG_PCIEPORTBUS=y
Thread-Topic: [v4] PCI: imx: make msi work without CONFIG_PCIEPORTBUS=y
Thread-Index: AQHUk3htX9ByhenO70SYEZSF8G6UHg==
Date:   Fri, 14 Dec 2018 06:44:15 +0000
Message-ID: <1544768762-18124-1-git-send-email-hongxing.zhu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0063.apcprd04.prod.outlook.com
 (2603:1096:202:14::31) To AM0PR0402MB3570.eurprd04.prod.outlook.com
 (2603:10a6:208:1c::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hongxing.zhu@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR0402MB3491;6:6wa5B2/6CqFyOBHykD3HlrTb/GainQQqrCWPygJ3kc239L6re61wr88+10h+Hgvo97lop+JSK1raGreu4otIGT5hxmucWQsUDLDiuvgx0W9XyWZTQIHJLv1km/MnhvX1EVfNq63EA07gg0A75HE61nmEx+tqXwkYgxBp0Zu4X7wnCkxHYvqhJhZgCCheyLvKroOL2LpwpgGOFY4iNMLd2CtFtLq5PxgZ2FE02Itv4YZL7ItrI0aoC9GgAcd6/GGy8eLeyF+8fikJZxM+C6pRmtCyc+EA+1edhY5AZhJ1AYDHtNTY3tGudHbKjtI3i8YyanBds5WFaEax7W3aiHVK6ikfxAnZcjVCkhLsAdk/StlgYUKm3A/RkFwS8dOC2v5sGzQ/rFEKnijNDtHS5OGXmpko4wAwX6AJEyZAhYQQKLWzYVOQTBRKnKKaHjCBLgKapuDUljB0PTCcFuNhhK8OAg==;5:bZyOkIFMmkwLniQ/hspzAamJ4e083hDjchGGPWprpigvqpfISwDKvnaLHxFBbqL0VUEGUn6dcMk6rfkfS6ti6EqxYPQR7nhDPX/h4yeWU9q0+1Gjj9Yp8MMPr53TQU223c8Ps4JEH0RWXnCu3ezfv7xbu8FqQsdyVFKu7ekUBmE=;7:qGekjGcUDgUE2CGLKyork7Ndl3Ba1VfW+Fkn7AYkV89i+PbmafY1FywvVWiWzNZwJFHPnQ7UIkJjTqZaC2QLJiOS9KZrbem2fQG1bMv6eox1EHwpDC1brTD9vMbBkHJDWIjt+HIxMHKSp4w5kfrGpw==
x-ms-office365-filtering-correlation-id: d523edcb-6112-4472-be68-08d6618f9059
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3491;
x-ms-traffictypediagnostic: AM0PR0402MB3491:
x-microsoft-antispam-prvs: <AM0PR0402MB3491027BFAA55B64F09D924A8CA10@AM0PR0402MB3491.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM0PR0402MB3491;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3491;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(366004)(396003)(39860400002)(189003)(199004)(50226002)(3846002)(6116002)(486006)(2616005)(36756003)(2906002)(39060400002)(6512007)(476003)(2501003)(105586002)(8936002)(81156014)(8676002)(81166006)(53936002)(2201001)(106356001)(66066001)(478600001)(14454004)(25786009)(54906003)(110136005)(97736004)(316002)(52116002)(99286004)(186003)(6506007)(386003)(26005)(102836004)(86362001)(305945005)(7736002)(6436002)(6486002)(71200400001)(256004)(14444005)(575784001)(71190400001)(68736007)(4326008)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3491;H:AM0PR0402MB3570.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xuj7g8gtewbpRRiHj36As+BY4nsAWWecV6T4xXzeZpSBM8im4PMgL3KBLzIilYDYkoEQ3CR7bYEJKG1dPsrMPYY744pUjsDBctIiMaF0OX1rYboDvJ5ReFaRQDjHnBvIXxFgu6mrG+/a2lX6zKnwdJlzMxkkQHly0aKC5dFS8ss8n88k7HCkwt20N9jgeBuQDqGOWZ5HNY752qvkTsWKgSj5ysPlJ1dhZTAzA7IiDlJjvLjB4T12RGlwLhvcXAapamwv6sPf6O0b4ROkd8ZCHUb7IcGNwIuq7rTioqInbD+b/LKezxiczLIexrShNV8r
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d523edcb-6112-4472-be68-08d6618f9059
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 06:44:15.1613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3491
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
---
 drivers/pci/controller/dwc/pci-imx6.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller=
/dwc/pci-imx6.c
index 26087b3..639bb27 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -74,6 +74,7 @@ struct imx6_pcie {
 #define PHY_PLL_LOCK_WAIT_USLEEP_MAX	200
=20
 /* PCIe Root Complex registers (memory-mapped) */
+#define PCIE_RC_IMX6_MSI_CAP			0x50
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
@@ -1071,6 +1073,14 @@ static int imx6_pcie_probe(struct platform_device *p=
dev)
 	if (ret < 0)
 		return ret;
=20
+	if (pci_msi_enabled()) {
+		val =3D dw_pcie_readw_dbi(pci, PCIE_RC_IMX6_MSI_CAP +
+				PCI_MSI_FLAGS);
+		val |=3D PCI_MSI_FLAGS_ENABLE;
+		dw_pcie_writew_dbi(pci, PCIE_RC_MSI_IMX6_CAP +
+				PCI_MSI_FLAGS, val);
+	}
+
 	return 0;
 }
=20
--=20
2.7.4

