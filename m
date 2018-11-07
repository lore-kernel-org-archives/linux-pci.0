Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4102CC0044C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 05:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044F22086B
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 05:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oV14rnYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044F22086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeKGPEF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 10:04:05 -0500
Received: from mail-eopbgr60054.outbound.protection.outlook.com ([40.107.6.54]:10955
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727296AbeKGPEE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Nov 2018 10:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lG1ICF7FHqK9dk7cg82ukVA+kTJnf+Z+7PG0cCFH65c=;
 b=oV14rnYEGg5JH3kqJNY0/tOPpLeZ10bZIYeuc0Jp6OpzLOD/A52QcsimwFLMcM7EONF9zwc4eoTVD/8L6n8S6BhraAKM6GmiqwAJ6r3RtWufQWPBx9pUZBZiZheh1/kuoeB5sbmrTH3kAv0UggVYJIVBsw4yH1EJwuY4w+JZ4x4=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB4152.eurprd04.prod.outlook.com (52.135.168.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Wed, 7 Nov 2018 05:35:13 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00%3]) with mapi id 15.20.1273.035; Wed, 7 Nov 2018
 05:35:13 +0000
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
Subject: [PATCHv3 0/4] dts/layerscape-pci: removed unsuitable compatible
 string
Thread-Topic: [PATCHv3 0/4] dts/layerscape-pci: removed unsuitable compatible
 string
Thread-Index: AQHUdlunYAybYVfa/kC2NPAi8G0Pag==
Date:   Wed, 7 Nov 2018 05:35:12 +0000
Message-ID: <20181107053500.13575-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0034.apcprd03.prod.outlook.com
 (2603:1096:203:2f::22) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:aa::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4152;6:MqGN5rtiUAoyNvuLPf+sVkqULRmxhOfOgXPHMlPnIjT/flopW2aB2PLizzmfZBlFVFdvxiwP0eDeZtWnlNjHlgZ/0TatswVktN2UiqabYgh0gkhu0blqTSHt7sEM/BYui8f1oFgHk3hHIIZTo4Owcc0gIuStDt8h+hDsdFtD44VcUYLoVdvGIYPOVO0PIbkve3gPFfn4/d8FUCiG6uLsWnhU1+rP8H1CZFLBLeEv/TkGz2Nh+vxOOaM4JmQx0drYkxZgjfkYJMu6LiJ0Dve2uwmP84BS8lDybDCVft9iu0OrMBNC6dX3tkSx10F7ogziZi3d1JREuwEDdcCEZI2XOlFu/KTBg111vmGHY002bzA8/q4/82FJiECO9o1RNHFEL7+vjqhr2TroMS/hY3knglKaK6dlvPnAJh8gMbd/TyFOl/2XT+DY0hB6bmGnqjJL1cS6c62jPagCI2OlwW3Ctg==;5:KtJNYmv1EoR3cXeEx91vV1HktNSkOKBaFSfjhwnZtuCgLtzDrCrosgFJV7evQHSvAHh7awugmU12+X9RH0hzEmZyUygT2GGS728pUzSv+BRit2la9kY0E9xG9X7lukpuCFOQ3RL+q9RAlkoCxyJP5bJ39ddk4x3zZqMw2vMZ3wg=;7:FX2WJwmghD/tMzOn9SBu6RIhG04FJVvlv9+u97gfIol3fEMisaWz9jwMumL6QeqI0IldNy0Z5UAQvOGFbe6Rxoz3RGEIp+etf/s6XVjfjKoqLm/57sGUXVLOq90NktUW+iAaQo1OyT3gFFBS3FaE6w==
x-ms-office365-filtering-correlation-id: f8c4068c-7e15-43a9-978c-08d64472c9f2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4152;
x-ms-traffictypediagnostic: AM6PR04MB4152:
x-microsoft-antispam-prvs: <AM6PR04MB41522BC0472114F12BE0EFBC84C40@AM6PR04MB4152.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4152;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4152;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(81166006)(106356001)(81156014)(2616005)(6636002)(6486002)(105586002)(14454004)(2501003)(476003)(68736007)(8676002)(6512007)(8936002)(478600001)(53936002)(6436002)(52116002)(256004)(97736004)(4326008)(71200400001)(71190400001)(66066001)(99286004)(486006)(86362001)(6506007)(386003)(186003)(102836004)(5660300001)(26005)(2201001)(305945005)(316002)(3846002)(110136005)(36756003)(1076002)(2906002)(7736002)(6116002)(2900100001)(25786009)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4152;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ahc/MUZ7NOPzrGo7e69hKXAtTV/2nZU4JE69nnrR2nqTszlAYMJa/K/CGnaz5oL375Qo+MAzJbQocuIYJ5dAY30p9Qu4VAO54txAdbUwnMy5BEpKC3pr9Y64h642PDzm2CAj/lr5KUqFRdmq8Xr0XBl0/+ea+JLdpS8X69sGYYUnHrnUn7E2C6l3IS3Jxc3Hmf4YQICJMxhsymOqzamcBSECCuXCnPpxxQnLGG7Wmde3EPDyjgSwfcwmyiliO8G8B9h2NG7JA/rOY1c8st5nPB2cI/4qQe189vhR/lCqIaeVMw0adD+5AEOReL0lu5J9oPoekMDBebQCU30oBYxmECAtoPKOhbU+m3GgTmk0IS4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c4068c-7e15-43a9-978c-08d64472c9f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 05:35:12.9857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4152
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
  ARM: dts: ls1021a: removed compatible string "snps,dw-pcie"
  arm64: dts: layerscape: removed compatible string "snps,dw-pcie"

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

