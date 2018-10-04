Return-Path: <SRS0=kgUF=MQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACA6C64EB8
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 16:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB06E20877
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 16:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hlWg25UM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB06E20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbeJDX2a (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:28:30 -0400
Received: from mail-db5eur01on0043.outbound.protection.outlook.com ([104.47.2.43]:38976
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727415AbeJDX23 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Oct 2018 19:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhrXfF2Sqhqj/bwmtXdMnn4RlBajQiyyF4AK6VycCfo=;
 b=hlWg25UM+3Y4lHlbWLcLpojMMr7At10t0adCwTD77oEay9Rfz7zsdg6PYQnbDRVT91ZrOBTbZ31YZBp7W3dPAyIzzrmKj4s3qHmpA19Mn8fvgvH0l+FMHplm39/o2uQGpViEyXLKvIfUxHc01iwOrHd6pWm2QXPZxr2+Di+hi3o=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4628.eurprd04.prod.outlook.com (52.135.149.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.24; Thu, 4 Oct 2018 16:34:24 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1207.022; Thu, 4 Oct 2018
 16:34:24 +0000
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
Subject: [PATCH v2 0/4] PCI: imx: Add PME_Turn_Off support
Thread-Topic: [PATCH v2 0/4] PCI: imx: Add PME_Turn_Off support
Thread-Index: AQHUXAAbnC0dA4WwC0u/rEKwxgW4Zg==
Date:   Thu, 4 Oct 2018 16:34:24 +0000
Message-ID: <cover.1538670431.git.leonard.crestez@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4628;6:F0zOp8HDqc+RJjYBaiKDaSlSQZUHXHsugyQQPsumI8xUPY4d+Vwol5eo/BXdica15KtsNv6HNezBiWSOs4aL6gW8GcnOTyCGq6bvil63SJ7MVu9xypmA/T2EWHY9xYu+e0YqVqYUFy4rUbVzLDw1LvT/7RhNoUTgi6t3zjsdqq1QBQcgrFcC7kKK7UtqLumvyVU8dn3xbsejIl2wLKHGO5UVi3F7UFgbYWoPqU/KKAwlCjcrB8WAc9c8YnRh9YZFDGIBJF5SVpVI8Y7m29VvS4PcSGaYeJCA9yPQIZ8AvEqrLoR4HuPOfCzNfqIaEyTsfPat8TZ7DTX78ric+kjZ8WB8pmK4+WQInuQko4BNifM7Zcq5DlgSwGDhG1o4Eho5TePq5p81a7ZXIVBEqXdC1Sd44iTkEm6T9CzdY+Kx68C0XyqsIktgAppZSsJNGdYJq+gyPISx7Hm9FuOiQv7XQQ==;5:LWeJtg9weVppBiVbVajBGolQJgDnbHzx7djTgdAYzfU9r5xak7MTSfERWzUvhykvnm9NlArfpvscHVOKQcK+QYNCLqygzHdmFZpkzfc5xGDJm1tnBhogqAc+fgJasQCAs9FFqitvBZ0TYqw8+R6B3WJQM3OR1l+YALpR3VuBK1o=;7:EmV3cAapOATzUpznrCl5BJEA0m+AJV6h8yWdTKFUJ61DXbGAc/rRxKy18fUePEnModv0hW2GxfwiP3KSd/Z+tbLEQfEP9U4R5YlsruTwDkWYdtSaOAdJQe78X3mUHMTHgUFeCDsChNibNFVhjmoVxNK8XvqIc13b3ZnX6LG7liCHigPewqGzUoWLkVULoDIBSNMO5nlrdNch75X6KJVwF8oONah1fIFluu/8K/euIB1jma78hia5U5W8yXFxakxU
x-ms-office365-filtering-correlation-id: 7639160e-ef60-4201-eed0-08d62a173e47
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4628;
x-ms-traffictypediagnostic: AM0PR04MB4628:
x-microsoft-antispam-prvs: <AM0PR04MB46284855222B3A9CC5F1E5E4EEEA0@AM0PR04MB4628.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:AM0PR04MB4628;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4628;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(376002)(39860400002)(136003)(189003)(199004)(39060400002)(6486002)(110136005)(54906003)(25786009)(6306002)(6512007)(4326008)(81156014)(81166006)(53936002)(6506007)(14454004)(478600001)(102836004)(6436002)(386003)(52116002)(86362001)(8676002)(966005)(7736002)(99286004)(66066001)(316002)(305945005)(2906002)(8936002)(26005)(44832011)(186003)(3846002)(5250100002)(36756003)(106356001)(71200400001)(6636002)(256004)(71190400001)(6116002)(105586002)(486006)(50226002)(97736004)(68736007)(7416002)(5660300001)(2900100001)(476003)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4628;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9mxIxLp6KPeoJ3fZwsIyIMtRc9/L7LcdLVG6R/FVUZpbXNAyyk9B+VdJHT9VAE2CxwrtrdDxoxmxfnCMpqaRMP/+CRcHW3sB6iCUeW6YLdK7KoAzmH+qo05pMMDtLjWV6r9lGQaMLPs4F3LlF34sioLVI4grT0ygcLtsX3dbR5Op2ADcvsEtDxqHlYipcBuh9B4OHH29nGg8KPsXja7HjAI9HebhMyCKq4QxJRxXO1kfiguKwVHOb8vyvzPZ/AP2+AxsV0hSvTJTkXGNDdCuszuqnwdmFQwz6xkokHp2qWyGQODlHcEKrmyPx+9VWkhQeumVH/YrvoW1BK74oxlkgNlwxryfC4l6OfM/EGRQUJA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7639160e-ef60-4201-eed0-08d62a173e47
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 16:34:24.0872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4628
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When the root complex suspends it must send a PME_Turn_Off TLP.
Implement this by asserting the "turnoff" reset.

On imx7d this functionality is part of the SRC and exposed through the
linux reset-controller subsystem. On imx6 equivalent bits are in the
IOMUXC GPR area which the imx6-pcie driver accesses directly.

This is only for imx7d right now but it's deliberately implemented as an
optional reset, ignoring the chip variant:
* Older dtbs won't have this reset so it will be ignored.
* Future chips might also expose this as a reset controller.

For example imx8m (not yet supported) has the exact same
PCIE_CTRL_APPS_TURNOFF bit in the same location.

---
Changes since v1:
 * Add 1-10ms sleep after PME_Turn_Off, with explanation
 * Slight fix in commit msg (this is functionality is)
 * Link: https://lore.kernel.org/patchwork/cover/994076/

Leonard Crestez (4):
  reset: imx7: Add PCIE_CTRL_APPS_TURNOFF
  dt-bindings: imx6q-pcie: Add turnoff reset for imx7d
  ARM: dts: imx7d: Add turnoff reset
  PCI: imx: Add PME_Turn_Off support

 .../bindings/pci/fsl,imx6q-pcie.txt           |  1 +
 arch/arm/boot/dts/imx7d.dtsi                  |  5 ++--
 drivers/pci/controller/dwc/pci-imx6.c         | 24 +++++++++++++++++++
 drivers/reset/reset-imx7.c                    |  1 +
 include/dt-bindings/reset/imx7-reset.h        |  4 +++-
 5 files changed, 32 insertions(+), 3 deletions(-)

--=20
2.17.1

