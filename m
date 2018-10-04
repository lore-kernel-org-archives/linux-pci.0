Return-Path: <SRS0=kgUF=MQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4864C64EB8
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 16:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C592082A
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 16:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EdQwizzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C592082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeJDX2e (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:28:34 -0400
Received: from mail-eopbgr80058.outbound.protection.outlook.com ([40.107.8.58]:50486
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727813AbeJDX2e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Oct 2018 19:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qn4hBjO7NrJFEg/Ip7ptTelJJHAA8a9JWtALIk5oNmY=;
 b=EdQwizzdANMuhjWSMAHg5as7y072zS+nv79yXZZmZ7VEazYU8vHmHFN2b8i3PkObcRXk43cgAfs5HM/bpMjpgorqle6mcN65iZOFHlavrpmZ4yXcqzGSfF3Xe0YeEn0zR0xH2+433Rx+NzKyNiPFs3cikkEOYLHEIYHgo8+Ncdc=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB5266.eurprd04.prod.outlook.com (20.177.42.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.25; Thu, 4 Oct 2018 16:34:28 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1207.022; Thu, 4 Oct 2018
 16:34:28 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Richard Zhu <hongxing.zhu@nxp.com>
CC:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/4] ARM: dts: imx7d: Add turnoff reset
Thread-Topic: [PATCH v2 3/4] ARM: dts: imx7d: Add turnoff reset
Thread-Index: AQHUXAAe8hWKFiAorkay2cnqivCEnQ==
Date:   Thu, 4 Oct 2018 16:34:28 +0000
Message-ID: <5f80136e703a35193d5e33168c1a66593bd8f96f.1538670431.git.leonard.crestez@nxp.com>
References: <cover.1538670431.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1538670431.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: DB6PR02CA0003.eurprd02.prod.outlook.com
 (2603:10a6:6:15::16) To AM0PR04MB4290.eurprd04.prod.outlook.com
 (2603:10a6:208:67::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5266;6:kx58aaJKwnUudsYhpdnjbG1qWgVWnvzWRRliaj1uMBwvjif4X3ULuJAEwaI79t7mUdhgOJY3yG2oiTf88wHpgY6Ne1kSlAOzYAe/pEWRdoWOgshhUZ3KToPxtGWZ7LyGlW+Ke0QJ3FwgC1TrvEFJYxuJ+UrVGgBI72hf+E+HFgsUHtlezeBBZvPE7AD2rdwafCmPxsLTYkb8ATZet+HGIaKZLPOv1Gb4tiu3s2HWA+H1lchOovSNaeka/Vqisxs4ZX2hrh969HP77zLcqFOfadTdRZkIQwEjQV5GsHpPcn/OPHWcXGyi1gvGtf68m9lw7n1SIpXtgBNoF5BTH32sfMoKvOOdwZ2b11lnetsQrbdYxaW9U6C6HIsaAt3ftZ/UHPuW4kwz3W/2bdR+IxgOCvd62aEENfc33CzXCjBD4MJXDST6gt5RujYdsvVzJFOOG3xqzI4I0tYIAE2w2kPNwQ==;5:BLwLTdONmykZS8evRMJakZk6v9cZTnClfo4ow2xFrrA3KpsY5wLPek9kaBW8CECLBBYoIIvT81ZmCtOXl6aqfW5LkyNwETqT/FEPCefcC0aFncZl+ellsSa2+mWsk0rb8uqSp1XgOvpnyKratruDY+/d92HDF1QDE3YMbmvkuWs=;7:Wu7OIzWqI/QQy+jOBHh1og7EA2o4EBuPBfPSPbDnVPk0khIHy5jeb+g1l5IqAT5mQux92G1dvW2cyXe8gQg9dnhAk/VSkDPqqd92m25m1N14ynVRKROXdRv3DRGOagzLCMNz03KmyUGCBDUiQV+n1UNXwJqsQffn5xEtXqPTL1FEzwzhi99bUTlGWuYOywg54vJ9mEKFaDl7CeCDIn+ktrn7EacH27JvU1y0xdTUwjf4LcvhGv4pB+OU1gVEW9MA
x-ms-office365-filtering-correlation-id: 774d40b3-5305-4581-fcf2-08d62a174100
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5266;
x-ms-traffictypediagnostic: AM0PR04MB5266:
x-microsoft-antispam-prvs: <AM0PR04MB5266553090B70F41F4547F8AEEEA0@AM0PR04MB5266.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051);SRVR:AM0PR04MB5266;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5266;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(39860400002)(346002)(376002)(199004)(189003)(86362001)(66066001)(14454004)(50226002)(39060400002)(4326008)(6436002)(14444005)(256004)(8936002)(106356001)(81156014)(81166006)(5660300001)(105586002)(316002)(2906002)(68736007)(478600001)(476003)(2616005)(44832011)(36756003)(26005)(3846002)(486006)(6116002)(11346002)(446003)(186003)(2900100001)(102836004)(8676002)(6506007)(386003)(54906003)(76176011)(53936002)(71200400001)(71190400001)(52116002)(97736004)(99286004)(6512007)(6636002)(118296001)(7416002)(110136005)(5250100002)(25786009)(7736002)(305945005)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5266;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zRAmaI7/eIPmvfGrJpupypCJADHBbpGtnljmJigiOHl+a7Q5UDa2wFajdOy34VnqGQ6yXeVc/QClleZVlH9POY2BKo9drfGoj3zADJyS1dFuyaOadbQqK3/A6SAXXUUEYozsE3Fcu8ahbcLnAg70L+7UI7t0334cXxt0cDUZwgiC5Pd/GjVlmlXz+jrI/PlxbpeSNVrN4L7NwHaKTct/kxCk4Z/gaGqGmh8fpQjfCoicnbyuJ1ywu793RRxyk0UvRieag70PVA5KccXO5Ws9qnDJHD7bBI/fdRI+/DVyWIxaR1NT8YRuoG12Ki44D/dAGSLwjorTPy6jdM3UjRYKd68EhKH3xfZK2rB+my+CjNw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 774d40b3-5305-4581-fcf2-08d62a174100
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 16:34:28.6844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5266
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is required for the imx pci driver to send the PME_Turn_Off TLP.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Acked-by: Shawn Guo <shawnguo@kernel.org>
---
 arch/arm/boot/dts/imx7d.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 73c35939e07c..826224bf7f4f 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -147,12 +147,13 @@
 					 <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
=20
 		fsl,max-link-speed =3D <2>;
 		power-domains =3D <&pgc_pcie_phy>;
 		resets =3D <&src IMX7_RESET_PCIEPHY>,
-			 <&src IMX7_RESET_PCIE_CTRL_APPS_EN>;
-		reset-names =3D "pciephy", "apps";
+			 <&src IMX7_RESET_PCIE_CTRL_APPS_EN>,
+			 <&src IMX7_RESET_PCIE_CTRL_APPS_TURNOFF>;
+		reset-names =3D "pciephy", "apps", "turnoff";
 		status =3D "disabled";
 	};
 };
=20
 &ca_funnel_in_ports {
--=20
2.17.1

