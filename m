Return-Path: <SRS0=j7M/=MU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D57C677D4
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 18:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03E62145D
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 18:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="txUO29hh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B03E62145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbeJIBT1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:19:27 -0400
Received: from mail-he1eur01on0075.outbound.protection.outlook.com ([104.47.0.75]:22699
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726458AbeJIBT0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Oct 2018 21:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgpkZIpWxJFAJA7TB0jtCajuEm+sgeJ1lXTVJFdWclQ=;
 b=txUO29hhPQi14Tbd7BNICwE1K6Lmyi+s2AHqUcsy5p7vFvAgWSRDrN+yal53olQ4zK51lx7+U3OWUTrwJt499U/RF9//mi6mOUR4de6bMiXYwr260YrOQxbbDYrfh2lQzTp41RqhbA8e9LX41UwTjEQrAIh9hiK74ixCglER6Yc=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB5172.eurprd04.prod.outlook.com (20.177.42.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.22; Mon, 8 Oct 2018 18:06:21 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 18:06:21 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/4] PCI: imx: Add multi-pd support
Thread-Topic: [PATCH v2 3/4] PCI: imx: Add multi-pd support
Thread-Index: AQHUXzGe6SZqbrUj90aARl9niCeThw==
Date:   Mon, 8 Oct 2018 18:06:21 +0000
Message-ID: <ee0c4ecb4b6bd26f548096e7be90a07d181d50ee.1539020938.git.leonard.crestez@nxp.com>
References: <cover.1539020938.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1539020938.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: AM6PR0102CA0011.eurprd01.prod.exchangelabs.com
 (2603:10a6:209:14::24) To AM0PR04MB4290.eurprd04.prod.outlook.com
 (2603:10a6:208:67::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5172;6:GCa+V63Mn3Q1CXixI3YpB2f3Y2GRET9KrZEkxVAKwJY0zHV73j8/SZrR/uKXscBN0kNhINuRC9NFxMC3yN/QTvxxKF/aaoq27Uza3jJpeBji8bl5HjFeTSu05wistpr+mWsa2SbvenKxZcxDekE3i+/riWN8blJNWae1rbDsJqgFRkV8k4VF7l8rmyqoMl6w2dUJ+23QI1tmdBmrRE2fZA6ip2IlSfd1TTSbmYTHPzeeupepRuz95UsX8m2LIsLtfpDyFqsyO5SRPxsVg8QcIHV+tHp2FlKpc0zbY+F6X89NK9HGQxLFac2eNurcHwilAnOLS6P/VT5wScTw9bVuvEakaJP6WCoib8LoktuPafHv+gtdGJvEjgcuwN9EwdyI32Ag5vtIsTNJhYSDVeC2ZcVLDRwSwbKdR+JnC+ZZygQO3UifhYIr9UtPfzgukNyntMtCDNzSisqGf6wxcepH5w==;5:BKvFlCb1UfHKz7hBHVajWUFXWeWv/k6T7M83Pm02jE4fPO64BKoLo51i/LA/LFCZ+t6W7kv8dwp0gwPOl9yTdPp2IKQ919JlJPWSyfxhg+VOS9dLnO4pFRaoiNYl9xOD++sbKv5/L4rtyhZY0qhIRia/k6wRrCOzoWlC6DIQvG8=;7:KVc9YbsyF4h9hPiav5KhgmgR49ooJpFwlXPP6IoRBp+NnlPLS2LDAp9ulvxSdNUbu+fQN9JDORK39NNhyNThf9CyrxAgI3WKIyj/cPGjMjCdmeeUQS6y1a5ssn7qhb9/gn0yjkjalRZ1FKtJ1IBkDAZE5JLURaVohY83UdVuT3CC6NgnDTjd1UIQ+WHWhV8XGjAbzdh0wRLYFue7e//hNHW/JaSb8vfhjAEivOkM+TCDrJbs5KUQI8Qqk9J4o++i
x-ms-office365-filtering-correlation-id: 19faf96a-684d-4e03-68fb-08d62d48c0c9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5172;
x-ms-traffictypediagnostic: AM0PR04MB5172:
x-microsoft-antispam-prvs: <AM0PR04MB51722B965438E3865130CE30EEE60@AM0PR04MB5172.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:AM0PR04MB5172;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5172;
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(376002)(366004)(199004)(189003)(2906002)(54906003)(25786009)(2900100001)(186003)(14454004)(66066001)(110136005)(53936002)(6512007)(6436002)(36756003)(97736004)(71190400001)(26005)(102836004)(76176011)(6116002)(6486002)(3846002)(4326008)(86362001)(256004)(5024004)(14444005)(71200400001)(5250100002)(316002)(7736002)(446003)(105586002)(68736007)(7416002)(8936002)(118296001)(8676002)(81156014)(106356001)(478600001)(6636002)(5660300001)(44832011)(2616005)(476003)(486006)(305945005)(52116002)(6506007)(386003)(11346002)(81166006)(50226002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5172;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WFrNgwPoI5ToMbtWFIJkh0VvRXf0lkK+Xc/bU43rActH30b3kLPqFGc6oM82yozyoHCXw8J/gA0l2gglSUTFTKy4gSiQAfLgYj2dmqHNZVXbqXgHdJiIvYyE+mSqibZUQapvuaitc9zVoWQEUtYwsEl9SDRdYQ6EyoVM+amM7zfaCZ1cx1XjPPCoLn9nkd0grLL0aJshz5iBAQkDQ/UWSbOBCC1H1DPsbFDwsrnvLHOQ/p6afNKXFS+1cNtrHCAoNY4Zgkr0CKUTP9rfJ/x5txjrgsDLaceH7L1c4S39pIWL/9QPxdF7O2C0m75reY8hXNkAqC9BTqDrUuuLAomlEn1fh+8A5QZqZcvuowXZ4WI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19faf96a-684d-4e03-68fb-08d62d48c0c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 18:06:21.8176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5172
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On some chips the PCIE and PCIE_PHY blocks are in separate power domains
which can be power-gated independently. The pci driver needs to handle
this by keeping both domain active.

This is intended for imx6sx where PCIE is in DISPLAY and PCIE_PHY in
it's own domain. Defining the DISPLAY domain requires a way for pcie to
keep it active or it will break when displays are off.

The power-domains on imx6sx are meant to look like this:
	power-domains =3D <&pd_disp>, <&pd_pci>;
	power-domain-names =3D "pcie", "pcie_phy";

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pci/controller/dwc/pci-imx6.c | 48 +++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller=
/dwc/pci-imx6.c
index 6171171db1fc..a482f86b02e6 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -25,10 +25,12 @@
 #include <linux/resource.h>
 #include <linux/signal.h>
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/reset.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
=20
 #include "pcie-designware.h"
=20
 #define to_imx6_pcie(x)	dev_get_drvdata((x)->dev)
=20
@@ -57,10 +59,15 @@ struct imx6_pcie {
 	u32			tx_deemph_gen2_6db;
 	u32			tx_swing_full;
 	u32			tx_swing_low;
 	int			link_gen;
 	struct regulator	*vpcie;
+
+	/* power domain for pcie */
+	struct device		*pd_pcie;
+	/* power domain for pcie phy */
+	struct device		*pd_pcie_phy;
 };
=20
 /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
 #define PHY_PLL_LOCK_WAIT_MAX_RETRIES	2000
 #define PHY_PLL_LOCK_WAIT_USLEEP_MIN	50
@@ -290,10 +297,47 @@ static int imx6q_pcie_abort_handler(unsigned long add=
r,
 	}
=20
 	return 1;
 }
=20
+static int imx6_pcie_attach_pd(struct device *dev)
+{
+	struct imx6_pcie *imx6_pcie =3D dev_get_drvdata(dev);
+	struct device_link *link;
+
+	/* Do nothing when in a single power domain */
+	if (dev->pm_domain)
+		return 0;
+
+	imx6_pcie->pd_pcie =3D dev_pm_domain_attach_by_name(dev, "pcie");
+	if (IS_ERR(imx6_pcie->pd_pcie))
+		return PTR_ERR(imx6_pcie->pd_pcie);
+	link =3D device_link_add(dev, imx6_pcie->pd_pcie,
+			DL_FLAG_STATELESS |
+			DL_FLAG_PM_RUNTIME |
+			DL_FLAG_RPM_ACTIVE);
+	if (IS_ERR(link)) {
+		dev_err(dev, "Failed to add device_link to pcie pd: %ld\n", PTR_ERR(link=
));
+		return PTR_ERR(link);
+	}
+
+	imx6_pcie->pd_pcie_phy =3D dev_pm_domain_attach_by_name(dev, "pcie_phy");
+	if (IS_ERR(imx6_pcie->pd_pcie_phy))
+		return PTR_ERR(imx6_pcie->pd_pcie_phy);
+
+	device_link_add(dev, imx6_pcie->pd_pcie_phy,
+			DL_FLAG_STATELESS |
+			DL_FLAG_PM_RUNTIME |
+			DL_FLAG_RPM_ACTIVE);
+	if (IS_ERR(link)) {
+		dev_err(dev, "Failed to add device_link to pcie_phy pd: %ld\n", PTR_ERR(=
link));
+		return PTR_ERR(link);
+	}
+
+	return 0;
+}
+
 static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 {
 	struct device *dev =3D imx6_pcie->pci->dev;
=20
 	switch (imx6_pcie->variant) {
@@ -1013,10 +1057,14 @@ static int imx6_pcie_probe(struct platform_device *=
pdev)
 		imx6_pcie->vpcie =3D NULL;
 	}
=20
 	platform_set_drvdata(pdev, imx6_pcie);
=20
+	ret =3D imx6_pcie_attach_pd(dev);
+	if (ret)
+		return ret;
+
 	ret =3D imx6_add_pcie_port(imx6_pcie, pdev);
 	if (ret < 0)
 		return ret;
=20
 	return 0;
--=20
2.17.1

