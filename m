Return-Path: <SRS0=kgUF=MQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FEFC64EB8
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 16:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF0F20877
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 16:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="duGyzMLq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF0F20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbeJDX2d (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:28:33 -0400
Received: from mail-db5eur01on0043.outbound.protection.outlook.com ([104.47.2.43]:38976
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727524AbeJDX2c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Oct 2018 19:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDrAp+cboQA/EoDak40SoOwiJpneIok3Dg+h6kIrRXA=;
 b=duGyzMLqXW9kQqa8iAcVU0oI7t1BP6IVizwnjr/NP4VLCB4IduPAPkdZUwmFTQTwK1CUHFRhwoOVw9JVxAFwJeTrbiJSFpdvRPfvH8fEtvOPzKovFsRB3ZKdExxSu1VYGMbbmCirQHximRy8iw9MHCiy1iW1QoATMtOS1r9MxQs=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4628.eurprd04.prod.outlook.com (52.135.149.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.24; Thu, 4 Oct 2018 16:34:25 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1207.022; Thu, 4 Oct 2018
 16:34:25 +0000
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
Subject: [PATCH v2 1/4] reset: imx7: Add PCIE_CTRL_APPS_TURNOFF
Thread-Topic: [PATCH v2 1/4] reset: imx7: Add PCIE_CTRL_APPS_TURNOFF
Thread-Index: AQHUXAAcrEeeoawteEW641mP0pOSYQ==
Date:   Thu, 4 Oct 2018 16:34:25 +0000
Message-ID: <c3a7dfd1395b12e170393a3da77e0d1602b9f542.1538670431.git.leonard.crestez@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4628;6:CxUD3TV2R+FHdmBa2iRTcNQXuY7dAlNqD8QHuCuH+5Mhqua0kfJoGvwABwvej8A15yoEjMyvXrvwl07ph8PBXj+9yXLe7J/xRpqWQCVkSznjHH6/6kHCknhbe9jLyEkFAAs21cEwQlvsJPczRqk+CdLrzAFeEi9kTZMKYD/qwp0AWijp6+owk1/f7FzPO5abklUFpzDb1t+XpHkOBc3jCkSWIHD4177toYt56hCpKXQPOVRbobI0pYUTTmch2RZc4EyGFDBVvD7awCLynfNkOHzoiKTKh/Ox029cswXrkezZ8sp2ZtkIfUoRtWXZq6Bg74lwhz0WjPkksOgsx9KmiMHgspg0rLsmiQnP1MPCTgc/cWAq4qp2MSS6wgBDoZ0JhB5vu07qZYWpKcaRWsUs8SXuSwY5xfp1nIZiJsIshP9DBqZGSF+DSxLIVzfq8D0l6FpUxXhhEzF889UAbt60yw==;5:DPZt+5XIlEdIqCaFEhcrrTQTzPoGDzTUxsi43TJX2/NPhYcAENOMYqsD7dF/74ThOfzb0YxbI9EHyWA1+QNo2tFUMG8HdJvyKUMixo4hwVhY/sfgaMALtS0wP9F0O62lZwWBK8kUqinWy0ui8G67HNcU5Ib9PEi4pRHWxaEP1T4=;7:XfJVw52o3xwX38iq1bSNACP4ujPvOwYJW4ZL+JepHOrnqFQeuLmxhb5axiUE1qpGuSh2/kTvxk0Wo58YoS7z4T6uSKG3ZCw2LATkJwUha9WKvSZ0GygWuN3BYnoY/cgFlmbOkJldOQmXi//YgOF4vJq+3Gcn95p4G0F+TXASWDs4PN/tzKcLhvmoURMEj0fQoDnaGvb6wR+AsyNG3OFBkxHwXFfUZH8jPWidJQRDQnI/suALcTKnTm9xAbmeiQ96
x-ms-office365-filtering-correlation-id: 4b26697f-5062-46e7-7b62-08d62a173f3b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4628;
x-ms-traffictypediagnostic: AM0PR04MB4628:
x-microsoft-antispam-prvs: <AM0PR04MB46289419EC23BB03B2995B8CEEEA0@AM0PR04MB4628.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:AM0PR04MB4628;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4628;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(376002)(39860400002)(136003)(189003)(199004)(39060400002)(6486002)(110136005)(54906003)(76176011)(25786009)(6512007)(4326008)(81156014)(81166006)(53936002)(6506007)(14454004)(478600001)(102836004)(6436002)(386003)(52116002)(86362001)(8676002)(7736002)(99286004)(118296001)(66066001)(316002)(305945005)(2906002)(8936002)(26005)(44832011)(186003)(3846002)(5250100002)(36756003)(106356001)(14444005)(71200400001)(6636002)(11346002)(256004)(71190400001)(6116002)(105586002)(486006)(50226002)(97736004)(68736007)(7416002)(5660300001)(2900100001)(446003)(476003)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4628;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: D9hX8HUVJmBc+3ek+g3qx/WMkpxya44Bfe3Vjc+DflCunzqOD2orBUoSOnD0vCTACd94qBXX3Sk1D/EA88MsWEwFGFqvN+tSdT0Aj9Z3NCSuzdl/8FLph24wqNDXfKM6afj2T3I95LN3INVY5iuXUu3UfkDz6hwNzNNKZ8xrrJj6KDShSh7okdiPpi8MbUtHZVTp/2m28l13N5/c2TnUoOZsLuBSPzzQdOP1pmtvC4fEWx4vB4FRdQcnNBWodYBzoDu7gDoDSzSGiDWqr2VsDZk/NpJtBDhPERYxSjgYBub8waVafpuJzSB8SH+pSLy80NP8F1RE/N0umNVKn9GSdvdU746HM/MZzm87HNRTX3Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b26697f-5062-46e7-7b62-08d62a173f3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 16:34:25.5743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4628
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is required for the imx pci driver to send the PME_Turn_Off TLP.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 drivers/reset/reset-imx7.c             | 1 +
 include/dt-bindings/reset/imx7-reset.h | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
index 97d9f08271c5..77911fa8f31d 100644
--- a/drivers/reset/reset-imx7.c
+++ b/drivers/reset/reset-imx7.c
@@ -65,10 +65,11 @@ static const struct imx7_src_signal imx7_src_signals[IM=
X7_RESET_NUM] =3D {
 	[IMX7_RESET_MIPI_PHY_MRST]	=3D { SRC_MIPIPHY_RCR, BIT(1) },
 	[IMX7_RESET_MIPI_PHY_SRST]	=3D { SRC_MIPIPHY_RCR, BIT(2) },
 	[IMX7_RESET_PCIEPHY]		=3D { SRC_PCIEPHY_RCR, BIT(2) | BIT(1) },
 	[IMX7_RESET_PCIEPHY_PERST]	=3D { SRC_PCIEPHY_RCR, BIT(3) },
 	[IMX7_RESET_PCIE_CTRL_APPS_EN]	=3D { SRC_PCIEPHY_RCR, BIT(6) },
+	[IMX7_RESET_PCIE_CTRL_APPS_TURNOFF] =3D { SRC_PCIEPHY_RCR, BIT(11) },
 	[IMX7_RESET_DDRC_PRST]		=3D { SRC_DDRC_RCR, BIT(0) },
 	[IMX7_RESET_DDRC_CORE_RST]	=3D { SRC_DDRC_RCR, BIT(1) },
 };
=20
 static struct imx7_src *to_imx7_src(struct reset_controller_dev *rcdev)
diff --git a/include/dt-bindings/reset/imx7-reset.h b/include/dt-bindings/r=
eset/imx7-reset.h
index 63948170c7b2..31b3f87dde9a 100644
--- a/include/dt-bindings/reset/imx7-reset.h
+++ b/include/dt-bindings/reset/imx7-reset.h
@@ -54,9 +54,11 @@
  */
 #define IMX7_RESET_PCIE_CTRL_APPS_EN	22
 #define IMX7_RESET_DDRC_PRST		23
 #define IMX7_RESET_DDRC_CORE_RST	24
=20
-#define IMX7_RESET_NUM			25
+#define IMX7_RESET_PCIE_CTRL_APPS_TURNOFF 25
+
+#define IMX7_RESET_NUM			26
=20
 #endif
=20
--=20
2.17.1

