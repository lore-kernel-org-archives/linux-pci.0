Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29840C43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 04:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98AF217D9
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 04:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nHe/d31Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbeLRETZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 23:19:25 -0500
Received: from mail-eopbgr60063.outbound.protection.outlook.com ([40.107.6.63]:3763
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726305AbeLRETY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Dec 2018 23:19:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzI/nCuz55bqfsFMtFiv9Uqea3bAyZwK7ksZppW6xnw=;
 b=nHe/d31Q38a+rt4m1MNGAUBs9Xc4KQvob/4D2GfUALDYrmLmXDFRveB7XXJriXZ5JRoLu34geHvIC++xCjCqi0F4TUbVdKR8Qv6AOSl0UzvAutFUT6Fa2EyRZeze+7TRvlx+Zuc1r5xNqlokZ1sca+guIDtPRT6MhnUBUApQJFU=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB4102.eurprd04.prod.outlook.com (52.135.167.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Tue, 18 Dec 2018 04:19:20 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::4d2e:cf15:fcf7:56b2]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::4d2e:cf15:fcf7:56b2%5]) with mapi id 15.20.1446.015; Tue, 18 Dec 2018
 04:19:20 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        Leo Li <leoyang.li@nxp.com>
CC:     Roy Zang <roy.zang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCHv3 0/5] PCI: dwc: add prefetchable memory range support
Thread-Topic: [PATCHv3 0/5] PCI: dwc: add prefetchable memory range support
Thread-Index: AQHUlojZXjFwizzZ+EOqT/t43p0paw==
Date:   Tue, 18 Dec 2018 04:19:20 +0000
Message-ID: <20181218041956.41809-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0075.apcprd03.prod.outlook.com
 (2603:1096:203:72::15) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:aa::16)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4102;6:gNkM5LH9GKoBBDq0J84EQXGydUF8UA3XgUU8xQG4WIy/moRXcRVsjekf+iIMzsscp64ma+Soy6Wb/RzvQRp5E+Lvewanuwj9fxk9TvS10IgSm5Q+IrvKrjwboRx6W9z+ijHluRNfiYRtB5Vx6BBNYiRKQqm+jBRQ8K+s30v1ADybfqux3y2EullB9XpgXwpvr/VddwrbPcHqmEZJOFuxPCDjlIGy3KktQvmuLG14hDCzGoWbzq10sUzbxwYZd2ZXIcsoypICkvtM5s2B5t3N8ThjfwI7p3W+J5gBO/lkI9UzkvVEI7NQjcotV2rfZtmU9Eo2SqmAUFoBi7+dGmBuo5kJt2R5UkqTZxiH/b+OxPr+lMRKCqu2IAREj4LwwED/L40a9ZoORd34RFQFkzLzHURoLx0tuTNg1877RwV5UgUg0CaaUbVDlHxeIvNpaD164vQ+mK7noBYhQDbD6+C7dg==;5:cbyPpqoDTltITp660hUTerdYNo+O7fnuBgiF3rnjE4ftVDWa1SsUCE5I+QVqLxoVs8cJXKksDL5C1ZPdMBfsMbluw77mjGqX8aIfugyWEPZmtkCZMjbF0OXHAi9HcE9MSbi08pvb4Okg5yt3eqZQWyglfBrCMP0Vy6yOop67pb4=;7:sthorJED0sVTevEFpl39dW4yhAJYo6+7YYPCbe6MlwpwmfzJ0qfwnI/fuIpibkh3h5jW5Ha9NF/KJZQkXdxv1hBPqj/L7af6hryx2AGV0Ep6AidLxUaYBMPZPv7Giv2A41oK9TZzMjX9rTQ5ZjYEOA==
x-ms-office365-filtering-correlation-id: f5871973-7971-4aa3-08ad-08d6649ffb60
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4102;
x-ms-traffictypediagnostic: AM6PR04MB4102:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-microsoft-antispam-prvs: <AM6PR04MB41023C11268A593800E6DB7284BD0@AM6PR04MB4102.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4102;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4102;
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(52116002)(7736002)(97736004)(7416002)(68736007)(25786009)(4326008)(36756003)(316002)(106356001)(102836004)(6636002)(105586002)(99286004)(2616005)(71200400001)(486006)(305945005)(186003)(6506007)(386003)(110136005)(54906003)(6486002)(1076003)(5660300001)(71190400001)(476003)(26005)(2501003)(2906002)(2201001)(86362001)(6436002)(256004)(3846002)(6116002)(39060400002)(81166006)(66066001)(8936002)(81156014)(8676002)(478600001)(6512007)(53936002)(14454004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4102;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qkaWw/q90hSnwmozUg15vzOC9++v+ktdFGX5R4oRYTUK2nS/AyKts4Fz39iWyfthflUz1rhdlAY+QxDiyHzgXIPUuQy7zDtChWwrxk5Bf63X5eKvmM5P3cpeWH0ue4AjDhbe4g+Eg2k9nfRrxlc7VXmKkqR7S1/mVA002+/tVEtIYYb2tZxZF3REurn8a8R0jJLAbiUZIIPv8dR1wXpFbLEozTA9AWav8mJCKW0e/wc40WVOfARKgN95wwI+uMK75VhmnDDLCQ9xUlY+r5yBfcP6mwX0FVw4Lr0DRalP1tAZFx8WmBnUzLdxkcuMxYqs
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5871973-7971-4aa3-08ad-08d6649ffb60
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 04:19:20.6411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4102
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

This patch set is to add prefetchable memory range support, patch 5/5.
Patch 1/5 and 2/5 are to initialize the number of viewport for
layerscape PCIe.
BTW, fix 2 bugs, see patch 3/5 and 4/5.

Hou Zhiqiang (5):
  ARM: dts: ls1021a: add num-viewport property for PCIe DT nodes
  arm64: dts: layerscape: add num-viewport property for PCIe DT nodes
  PCI: dwc: fix potential memory leak
  PCI: dwc: fix 4GiB outbound window size truncated to zero issue
  PCI: dwc: add prefetchable memory range support

 arch/arm/boot/dts/ls1021a.dtsi                |   2 +
 .../arm64/boot/dts/freescale/fsl-ls1012a.dtsi |   1 +
 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi |   3 +
 .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi |   3 +
 .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi |   3 +
 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi |   4 +
 .../pci/controller/dwc/pcie-designware-host.c | 135 +++++++++++++-----
 drivers/pci/controller/dwc/pcie-designware.c  |   4 +-
 drivers/pci/controller/dwc/pcie-designware.h  |  11 +-
 9 files changed, 128 insertions(+), 38 deletions(-)

--=20
2.17.1

