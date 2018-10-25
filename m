Return-Path: <SRS0=18Ni=NF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0513C46475
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 09:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6052064C
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 09:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="u9OYWxGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6052064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeJYSVb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Oct 2018 14:21:31 -0400
Received: from mail-eopbgr00043.outbound.protection.outlook.com ([40.107.0.43]:35232
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727202AbeJYSVb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Oct 2018 14:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IObrawiyrxVLq2uCsg6KCElWN671ETgbvjd8Pbsy984=;
 b=u9OYWxGELfcKakiTcZX6rWTghdolyun6g+YTHLyOMJJ36AW6UKW001KcR487shfI03KymAioAvfkiACcmh/QtsOySnKpWe10MYiIdDuXpAEb8L/Z7B2HpTsHR2JxSN4/5UR9/qKqMP4jPjLAV4fSj781TuQ4ylFqybuQACm56dA=
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com (10.162.155.27) by
 DB5PR04MB1208.eurprd04.prod.outlook.com (10.162.155.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Thu, 25 Oct 2018 09:49:29 +0000
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb]) by DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb%2]) with mapi id 15.20.1250.028; Thu, 25 Oct 2018
 09:49:29 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>
CC:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCH v2 0/4] dts/layerscape-pci: removed unsuitable compatible
 string
Thread-Topic: [PATCH v2 0/4] dts/layerscape-pci: removed unsuitable compatible
 string
Thread-Index: AQHUbEgFniJFKLh9FkarAkxj7ULwyA==
Date:   Thu, 25 Oct 2018 09:49:28 +0000
Message-ID: <20181025094929.29481-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0051.apcprd03.prod.outlook.com
 (2603:1096:203:52::15) To DB5PR04MB1221.eurprd04.prod.outlook.com
 (2a01:111:e400:51c2::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB5PR04MB1208;6:s8sNQ+XALCiMWBWSAkFqv9zaDqSD7uVyltJ6WE1coKy+7aRs+VmCKn0bYPrv5IcfofnQKKtbJEzChG5UrnINxXZF39HCGvpsrYmZ+3gJWfh4tO8sorEjuWuB7Yq6fF0QvI18DCCqd4/54tcDDK9o66+3G9vb0WJjBzhUV87gbLjw7/f9Kx2el1yVAqhDTH94C70TU3iFjjqeuP/EcS+rKsem4Dz62SHXqLStbT+5seTIkC47iiOGtit7j3jcba13qmK/E/qFSsiYbT8hHsOEVdAvino7loxijRheV64IIFtqDsH+2GgWNTnZZGrdRRDvYl9y6mX/fXmAdVkqTGyqNYbDKMkeDzpIHYDcWnroVlIC5QKkvsbySFGW8IGEz9XXf1pJsVDAJwrayjKnVO6dyT+ku8sUsSwFdxaLWtkaRgnAiDAgPd3mfC99Wa2s3hY3XBiy+O3fP2TWr71gXQrxwg==;5:HJOwPie6F1ljHow4tbE77ylpdMMz6W0UWTlUxDXteQ+Zuj9x+5gNvZD3B8Z3B3C78idxDdX2AJWfLBLoQ/or0hL/sCbVtQ2/KgOWl4peSDUh/Ge8suScl3wmnZzNd3QgDaHyVC/cTw2+J8WoXwwM2l5rJSPBsjZNGKUCXqEVR4s=;7:WtwAVY3EeAEkXx+F79/nuOiUdy7beFW5sNbUU9iuJajqj76iuUlQrbGeTSkMwBQelz6CsFxA83J8tOtK4zDenv28IXF3wgsheLfq/VaPF/PC4f3Yn2lxzZLGPXSgSFbLEJvLi6SRAb9QHEj++qmCaUR/D+NI2+6uKrNtb2pnTX9gyGmydv3d5GdxISvuvR5hNnbOwVK99jFn52gnuKTM/CSTZ6sBbrqfYL83I7raohwHL/7xaEHIBN/nzykTisij
x-ms-office365-filtering-correlation-id: 5034ffed-e810-4ca1-0024-08d63a5f27bc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1208;
x-ms-traffictypediagnostic: DB5PR04MB1208:
x-microsoft-antispam-prvs: <DB5PR04MB12088C63B3A4CAF1251256CC84F70@DB5PR04MB1208.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB5PR04MB1208;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1208;
x-forefront-prvs: 083691450C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(136003)(39860400002)(199004)(189003)(486006)(6116002)(3846002)(102836004)(5660300001)(6636002)(6506007)(386003)(256004)(99286004)(6486002)(1076002)(86362001)(110136005)(7736002)(305945005)(52116002)(2501003)(5250100002)(2201001)(26005)(71200400001)(71190400001)(316002)(478600001)(2900100001)(4326008)(25786009)(68736007)(97736004)(81156014)(53936002)(6512007)(8936002)(81166006)(6436002)(14454004)(105586002)(186003)(8676002)(2616005)(476003)(36756003)(66066001)(106356001)(2906002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1208;H:DB5PR04MB1221.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3dikEqVfCXLEh3HXJV+/eMmyrEmEiUTX1ZeCYbgFs0dOyOlTD++0HOnpvjdphjK27UkHG3ckjCWsAgAPDKwXe2zuqA+IrBtdVTAT5x9aqQhzuA4LzPusQjVzNn4e/AsOcZeSc2YG9WyIfU5kHX2la1fZLIfnpT34KN8IjwGpyS/IDP35sagIGqSGO9NGaPd75pwiOIZttuZGXnQNnzCXqxzgo+wy/RDepWN2JgXM7CLLnJCWimEOiGRC76rvcevuYzHn61k4fXaOd6LvZGknFv/9kLVvyVL4bfOQasIFdjKKuikcEEZyDkmfLGViU5n2G5o1P8yl2ZpeHW48j7uvwNndbbtzAk8YmN7xpey4cH0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5034ffed-e810-4ca1-0024-08d63a5f27bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2018 09:49:28.9784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1208
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Removed the compatible string "snps,dw-pcie" from FSL layerscape-pci compat=
ible
string list.

Hou Zhiqiang (4):
  dt-bindings: pci: layerscape-pci: add compatible strings
    "fsl,ls1043a-pcie"
  dt-bindings: pci: layerscape-pci: removed compatible string
    "snps,dw-pcie"
  dts/arm/ls1021a: Clean PCIe controller compatible strings
  dts/arm64/layerscape: Clean PCIe controller compatible strings

 .../devicetree/bindings/pci/layerscape-pci.txt       |  7 ++++---
 arch/arm/boot/dts/ls1021a.dtsi                       |  4 ++--
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi       |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi       |  6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi       |  6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi       |  6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi       |  8 ++++----
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi       | 12 ++++--------
 8 files changed, 24 insertions(+), 27 deletions(-)

--=20
2.17.1

