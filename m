Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CCDC0044C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 05:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F22C20883
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 05:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="t3Il0D6C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F22C20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387574AbeKGPEO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 10:04:14 -0500
Received: from mail-db5eur01on0058.outbound.protection.outlook.com ([104.47.2.58]:26656
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387568AbeKGPEO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Nov 2018 10:04:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Fi686QGLxoIQWraehyiPW9VcyX2WY2ivIArYynjuts=;
 b=t3Il0D6CJrqprNrwg6w5B0PCYZf343xH8LLUBuuF9TrgI3jYImLywOJOYxJ0CtabKmsWUDkqcqwTjVxyxSjpo2aWNYuqO8csHJ9yOP85sW6G4kft9a4BRaNv3gN+mLfArpkRnNgW6gR/bp2hE0CL2iwraDBPlSGYDFQmnMz+e24=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB4152.eurprd04.prod.outlook.com (52.135.168.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Wed, 7 Nov 2018 05:35:22 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00%3]) with mapi id 15.20.1273.035; Wed, 7 Nov 2018
 05:35:22 +0000
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
Subject: [PATCHv3 2/4] dt-bindings: pci: layerscape-pci: removed compatible
 string "snps,dw-pcie"
Thread-Topic: [PATCHv3 2/4] dt-bindings: pci: layerscape-pci: removed
 compatible string "snps,dw-pcie"
Thread-Index: AQHUdlutnApng3sYX0yleIIlu07BcA==
Date:   Wed, 7 Nov 2018 05:35:22 +0000
Message-ID: <20181107053500.13575-3-Zhiqiang.Hou@nxp.com>
References: <20181107053500.13575-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181107053500.13575-1-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4152;6:yrxR2Lz9gErnTrr8iw+Tq9J6MBWXvOZv6fQjTGmXAyUgK+JQbVW00/I+JE3aL00onUpth+P6wjYV+co8jwPNlHnQPbg/oco2vwnKrcKg2V2w7z9dXWVPaGxr+haif94JSU6sP1Z6WXtE3z4e6mLAiyr1ntCDY4/8VyigLESTHJcBmyKQ00qY21Gcfu6eWrv78suZLQK9YWdnMXCvT6k6zk7295md4EP02aTRDcXptUTvbt9IvCI73RjfLu0swsvFeMcEi/WxzrwyMt2CsxzCW0b817oDwsXBh/sUv5mxcA6DkQ8BBGxV1V3oYUHNZduzhr/G86smTA1Wi8vKfJUVDf2MFZTg8KiEbSSP+WJT8W6ZYf+1i1FysATnAGzOcF/Kie70dO3VYI591h1yNLMDqhnTRrEPTAHhkznxL1XjgD/PJuRThCGbIBBYDTs6l3M5sklmMSwHFFuqJoEYA0UEuA==;5:XVdUOkCUR7Mf2nVIvr5NMgJj87+hOl+1dHMQGCv1vbPeU+S2rgQ8ybQYiM/O5lHzhNStE/wX61yMLBVJ6Ttbmz2+VKU7dTBDWDXhLlHmvc2hBSf5JehRrPAt9JKVF3B51hW/xe9ekBq5LbglI9z0EGCjN9JOdOAWuvHQjly/lTQ=;7:0SJNxNjKQtseGznkWFtOcOfFotgHkE3ffeBONMMst+LlaGVb3yIvZkxeWHPDsyiXt9SEZRo/cQ7XEXSxpRMfTDT13k83A2B3KzhIT0uAWx0eBj4I0POetAgJXQI9fwlILfoJVaYqKG8ZVqAIcsaoxg==
x-ms-office365-filtering-correlation-id: 4dd7a3f1-1941-4cb3-86fd-08d64472cfc5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4152;
x-ms-traffictypediagnostic: AM6PR04MB4152:
x-microsoft-antispam-prvs: <AM6PR04MB415229C820AC4C43719F14EC84C40@AM6PR04MB4152.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4152;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4152;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(81166006)(106356001)(81156014)(2616005)(76176011)(6636002)(6486002)(105586002)(14454004)(2501003)(476003)(68736007)(8676002)(6512007)(8936002)(478600001)(53936002)(6436002)(52116002)(256004)(97736004)(4326008)(71200400001)(71190400001)(66066001)(99286004)(486006)(86362001)(6506007)(386003)(446003)(186003)(102836004)(5660300001)(26005)(2201001)(11346002)(305945005)(316002)(3846002)(110136005)(36756003)(1076002)(2906002)(7736002)(6116002)(2900100001)(25786009)(921003)(142933001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4152;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CasbTN+N24JvBYuuH1Gs0rqmk98g9fP4rNBO40Fep5H94Rae/pKnQPG9PgNH+80PzlnTXEDhEf8/bRfmhowPUrWb9XERafRB9VxQ9NHld8iB0JC0+F1wArCYgdRGGBpMAdYAS7giXfojbccSq8cSDN0+Qwqyv3ljJHkiI+oP44qmxhKLH5KC8waPTYG4FBUWo1sbpYKTCzFdGGKqzUyfytKmP317CCxKXGyRDA2/68PIiBAxfEBTES0eK183sB5HhNJq9qtqjB78w8w65D88nj0GvU4C8yYLIsiZkI2/eindcbORwOjzQUXy7VGakxiH/muRLj1cy5zrBU03NVCzPitbykrNmZpveN1SCPJEKQ8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd7a3f1-1941-4cb3-86fd-08d64472cfc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 05:35:22.5865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4152
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Removed the compatible string "snps,dw-pcie", it is for the reference
platform driver for PCI RC IP Protoyping Kits based on the ARC SDP,
so it is not suitable for all platform with designware PCIe controller,
and platform vendors have themselves' drivers.

The compatible string "snsp,dw-pcie" was added by mistake and it's not
matched that time, but it is matched because PCIe drivers has been
collected recently.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
V3:
 - no change

 Documentation/devicetree/bindings/pci/layerscape-pci.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Doc=
umentation/devicetree/bindings/pci/layerscape-pci.txt
index 5eb1c202932f..9b2b8d66d1f4 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
@@ -13,8 +13,8 @@ information.
=20
 Required properties:
 - compatible: should contain the platform identifier such as:
-        "fsl,ls1021a-pcie", "snps,dw-pcie"
-        "fsl,ls2080a-pcie", "fsl,ls2085a-pcie", "snps,dw-pcie"
+        "fsl,ls1021a-pcie"
+        "fsl,ls2080a-pcie", "fsl,ls2085a-pcie"
         "fsl,ls2088a-pcie"
         "fsl,ls1088a-pcie"
         "fsl,ls1046a-pcie"
@@ -36,7 +36,7 @@ Required properties:
 Example:
=20
 	pcie@3400000 {
-		compatible =3D "fsl,ls1021a-pcie", "snps,dw-pcie";
+		compatible =3D "fsl,ls1021a-pcie";
 		reg =3D <0x00 0x03400000 0x0 0x00010000   /* controller registers */
 		       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
 		reg-names =3D "regs", "config";
--=20
2.17.1

