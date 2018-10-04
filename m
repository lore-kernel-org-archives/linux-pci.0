Return-Path: <SRS0=kgUF=MQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F01C64EBC
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 16:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69372082A
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 16:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="yI8lAW74"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69372082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbeJDX2d (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:28:33 -0400
Received: from mail-eopbgr80058.outbound.protection.outlook.com ([40.107.8.58]:50486
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727415AbeJDX2c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Oct 2018 19:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyOr3KhjVhrtaIigEqzfqh2MmL6BiTpih628112q038=;
 b=yI8lAW745KstGC1PU0ocFI5rt0zm90LR3w34XIi10PlVryE+cL69+mb1/v5djbFbzAQlYrLXc9a83spzg9m01vRYa3uQOjNUwjx0U1JHhlot8gl2/D/k6vnADH8pkvvIBP0RZWnOwAbkWxVo93pmulAnRmzlbHdLmjxgdHXTle0=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB5266.eurprd04.prod.outlook.com (20.177.42.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.25; Thu, 4 Oct 2018 16:34:27 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1207.022; Thu, 4 Oct 2018
 16:34:27 +0000
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
Subject: [PATCH v2 2/4] dt-bindings: imx6q-pcie: Add turnoff reset for imx7d
Thread-Topic: [PATCH v2 2/4] dt-bindings: imx6q-pcie: Add turnoff reset for
 imx7d
Thread-Index: AQHUXAAdyMDIGjrm5kyzw/2wqGXRFg==
Date:   Thu, 4 Oct 2018 16:34:27 +0000
Message-ID: <19537dfb0750a342b1aa645934325d4c6a3176fb.1538670431.git.leonard.crestez@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5266;6:CjckKvNXTxFajzeNuBerbB54mrJk7YD9RFCgC+9y9v0A3ImhqdYLVVoSw6akX/yMiZMJWQeqwOtUAMDzfS6WW9UcAf9y/zHegGUHThvuoKZPfqz5hDqh/76Iy3spD9IImPCZfskKPUcBni6gRa5na4dcn9iqJAQy2e9V/HWLotzditm0UpuRVL4icIUcZyZcibmqRhfQ9n1kh5SdYJerZhvZViUI3r8dfHQSWmcYQ0TaqT3o9ifCq66a7NEA4+jJbufnGVclDkyDljuMQRrknEyUbTmvEvcuBZQEPKCyE4b4Jk7U7CWFH6R9jRL9wn74/E5u9/JZbXUHTlxEubv0NdW8AUa5exzzUlVPMVwkrMQYdohA4ZcGTwksh5Z14xdSLwMkV0ZKEUAFEK9wKJ4nA6IkXHvgYO4t0fxPmHspsQ37oqs4w2A3yhc8ovr67D0WCeS4lUeJbKGkU8CQoxGTXQ==;5:9eY3ERKYlGi+HtQqO90FpG3eVH6LcnY5BlKK3vPvrh6wv0pYX1z+wWH+8WdOCxIHUU8OlPWgbveQTiwHjU/oY7f9uKMBBuSOiZHRhbzvT5xUYhGa4UDT8slI3l5ahrDcGvR3LE9knZhFmIlSvzPyrV7DZlV/v0b7oRuQdNtAoCE=;7:whOgIEowZzb75zUzSc4uNbqI93XLsWj0NMVzGse/gZiDl0kEiDt6r50g+vsB8M42W/vqB6bchjNPtvq8eus6WzbG/gxCoBXLd049uIxKXhrlO2gbWFsrg6o83m9yvB5d/1SyGlhLX2+evR9n+qbJGvL0QFZVfjtTpk59UWzUWZmcKcKgXYpn5Wyl/WqExw8QIUliBoL+6wBV2QGvFSWLk+H/4tAgSjE6JmSQTvlAyDlTqJYSBWKK4tOkh90cJQBp
x-ms-office365-filtering-correlation-id: f51891de-e6d4-4ccb-0372-08d62a17401d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5266;
x-ms-traffictypediagnostic: AM0PR04MB5266:
x-microsoft-antispam-prvs: <AM0PR04MB52662020FB327E3A4E219311EEEA0@AM0PR04MB5266.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051);SRVR:AM0PR04MB5266;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5266;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(39860400002)(346002)(376002)(199004)(189003)(86362001)(66066001)(14454004)(50226002)(39060400002)(4326008)(6436002)(256004)(8936002)(106356001)(81156014)(81166006)(5660300001)(105586002)(316002)(2906002)(68736007)(478600001)(476003)(2616005)(44832011)(36756003)(26005)(3846002)(486006)(6116002)(11346002)(446003)(186003)(2900100001)(102836004)(8676002)(6506007)(386003)(54906003)(76176011)(53936002)(71200400001)(71190400001)(52116002)(97736004)(99286004)(6512007)(6636002)(118296001)(7416002)(110136005)(5250100002)(25786009)(7736002)(305945005)(6486002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5266;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OwRRQEH5RD9KkJv3ESHf6STJ1yL3P1C7OVlFviR/KHZtizTUryYh55AwDkr/mXtjeJz/aK9dyPlye6XgEifjqrq0vfSJLFMXmfWTDbpxlucnh0wi6N5p5koK2w9SMGrNpSQOjWTuvIzzqeheHbaJKrmd2sdibbXR2KFLPRGpTXCLalP8o1X9yBKGV6/OurvsVzrUPGGwHnXVx4fzoZkoR2sHLv3dOviWyDRcTiZDUwuOd1/DLD3rZK/AFNcE6GK0Bg6m+nRndpiVCvhLaqbhW3pnPLvZUHlFKRp/LzGIC7iarFDvQ0try3vFgtX9htbmSK108iOLBlDqSUb/rYB1A/RQqRIpdfmkL/yVYCf8hHg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f51891de-e6d4-4ccb-0372-08d62a17401d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 16:34:27.0673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5266
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is documented as "required" but won't be present in old dtbs.

These resets are also present on other imx chips but right now only
imx7d implements them through the reset controller subsystem.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Doc=
umentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index cb33421184a0..f37494d5a7be 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -48,10 +48,11 @@ Additional required properties for imx7d-pcie:
 - resets: Must contain phandles to PCIe-related reset lines exposed by SRC
   IP block
 - reset-names: Must contain the following entires:
 	       - "pciephy"
 	       - "apps"
+	       - "turnoff"
=20
 Example:
=20
 	pcie@01000000 {
 		compatible =3D "fsl,imx6q-pcie", "snps,dw-pcie";
--=20
2.17.1

