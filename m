Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDF0C0044C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 05:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC91E20827
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 05:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qAKC9aR0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC91E20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387792AbeKGPE3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 10:04:29 -0500
Received: from mail-db5eur01on0059.outbound.protection.outlook.com ([104.47.2.59]:56648
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387568AbeKGPE3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Nov 2018 10:04:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWO+uVxxPqK+BFrntz+DEC7tUltabd7pAjAU+t3hllI=;
 b=qAKC9aR0vqpkzqmP01uaksa311n5Sfbx+3r6gPog5Xj24gdExUKQ9mwxQ2AKDNw0g8Q1VC/MLCCyCSuI5T+VqtehfVLrHhj+sUSkE8DWDQP+yqpAoR5r2cg7JrUtG+HlmPgelSVvv6PyebHobyzSXGdCbYf98lWOBe+wGAl1/rA=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB4152.eurprd04.prod.outlook.com (52.135.168.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Wed, 7 Nov 2018 05:35:32 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00%3]) with mapi id 15.20.1273.035; Wed, 7 Nov 2018
 05:35:32 +0000
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
Subject: [PATCHv3 4/4] arm64: dts: layerscape: removed compatible string
 "snps,dw-pcie"
Thread-Topic: [PATCHv3 4/4] arm64: dts: layerscape: removed compatible string
 "snps,dw-pcie"
Thread-Index: AQHUdluzeHaY/zpsFkmniwV/0S6BmQ==
Date:   Wed, 7 Nov 2018 05:35:32 +0000
Message-ID: <20181107053500.13575-5-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4152;6:e53cbwqLyybUVdvcFugXd2wkuIwJ8Zwh6sUVcRH6baB9dhncJ2mCVDrRE4FVaEtJ+ZW6eJXsgPb2tUpimwaXNFD/MLYQLeokonlbUSI6SI2yiNiPV4UIeZrNtSBkdtdaBOKf0ErSxJ8rk5ka/6u3lDC7Te9SJJNOt6/Xq/ijdvkP6irdWgs0qo7eAFdI9rG7Qtf2QNE/EQ33bNfYXLI+MA4ntfX/ZTAP6UGRrwcVmuXE1ArWJoHJL7BhYokTO05WAhlGGUDirKNI92zEy07+BpyQYtkV0CjfYde3qQ4umnKEQKh4SwBJYRLc+T7kOGqsADeUGd8DcJOfU+t6zJXyaV/i2bRdqQokOWP8bcwan5Y51uSA1AMe8yk46pFWpXoFeLLtBZvZDUNQxjBAdK8JfJEikbtI4dLRu585JKdy2QQhNOucW3aGLq5kZSx/rxpUwz0lELzTYLlmJo/gFsqqpg==;5:igGLwaFdYMYNZ3mlpIV9JgbMkreUzvAKDPjy3MWYtOEXI05phntcaDQKfVVEVgwZWE0dSYy+O0rk6ul13eUiNAGi94AG7SrsS8bX81tuUBmvIMR6dLOAHubh05990F2HUQ8IvMmnIgepYAedacw43TOjO/uBVaYa6/UTff0BPdU=;7:CmOxxqu6KooNo98ZXvVE48zmSrEhqcAsnpJRhUcYLwBHHQNEI3BfYVr/kLGurl3m2SOG5eix/K/GvGE5van8U3z3uahp5rw0AsFZkqRy/QK7+jVznTTf3eD1q3Tl1bF7zMbxPY/P+MI/nr/TPruVkg==
x-ms-office365-filtering-correlation-id: 7ced2fbe-002d-4ab0-e32f-08d64472d588
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4152;
x-ms-traffictypediagnostic: AM6PR04MB4152:
x-microsoft-antispam-prvs: <AM6PR04MB41527C576CA168F3C40BEEC284C40@AM6PR04MB4152.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4152;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4152;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(81166006)(106356001)(81156014)(2616005)(76176011)(6636002)(6486002)(105586002)(14454004)(2501003)(476003)(68736007)(8676002)(6512007)(8936002)(478600001)(53936002)(6436002)(52116002)(256004)(97736004)(4326008)(71200400001)(71190400001)(66066001)(99286004)(486006)(86362001)(6506007)(386003)(446003)(186003)(102836004)(5660300001)(26005)(2201001)(11346002)(305945005)(316002)(3846002)(110136005)(36756003)(1076002)(2906002)(7736002)(6116002)(2900100001)(25786009)(921003)(142933001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4152;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ynWZCpOF3UNE8f4PXb9vgEM3TJA9KzS126/On7xFbj+Rtd0gPnrCNCc+T/B6iWnCwl/ldqU5bIR5LmLj4RbEgXyw/8gEoDsdSnGqQHiIHvvS9YYT+RFVC9d0+PQ79Rx/n+0WCJ6CYUzNdQOI+GMgVLK6xO1Qrx3CyyEltR/sRTELLwzeGzRVWGD3vsik35RkYxLog9QVTBQfjPNKPocw6/r+lWI7FEOIkff70RzfqKorXUNSkgN5hLszQ5xBhf2E0e2PP2DSIdF1SIQLvsgnAIqs1Yo+BEAgYPZse+tQyZkb9pB15kA2kaH2b/C+4Hsp5gqGw3pM2P3de35qHBhron3ObCl64fljAiLULeDEN1A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ced2fbe-002d-4ab0-e32f-08d64472d588
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 05:35:32.5827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4152
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Removed the wrong compatible string "snps,dw-pcie", in case
match incorrect driver.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V3:
 - Reworded the subject.

 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |  6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |  6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |  6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi |  8 ++++----
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 12 ++++--------
 6 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-ls1012a.dtsi
index 5da732f82fa0..028a6daa5597 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -475,7 +475,7 @@
 		};
=20
 		pcie@3400000 {
-			compatible =3D "fsl,ls1012a-pcie", "snps,dw-pcie";
+			compatible =3D "fsl,ls1012a-pcie";
 			reg =3D <0x00 0x03400000 0x0 0x00100000   /* controller registers */
 			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names =3D "regs", "config";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-ls1043a.dtsi
index 3fed504b5381..5480d6c4c548 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -661,7 +661,7 @@
 		};
=20
 		pcie@3400000 {
-			compatible =3D "fsl,ls1043a-pcie", "snps,dw-pcie";
+			compatible =3D "fsl,ls1043a-pcie";
 			reg =3D <0x00 0x03400000 0x0 0x00100000   /* controller registers */
 			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names =3D "regs", "config";
@@ -686,7 +686,7 @@
 		};
=20
 		pcie@3500000 {
-			compatible =3D "fsl,ls1043a-pcie", "snps,dw-pcie";
+			compatible =3D "fsl,ls1043a-pcie";
 			reg =3D <0x00 0x03500000 0x0 0x00100000   /* controller registers */
 			       0x48 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names =3D "regs", "config";
@@ -711,7 +711,7 @@
 		};
=20
 		pcie@3600000 {
-			compatible =3D "fsl,ls1043a-pcie", "snps,dw-pcie";
+			compatible =3D "fsl,ls1043a-pcie";
 			reg =3D <0x00 0x03600000 0x0 0x00100000   /* controller registers */
 			       0x50 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names =3D "regs", "config";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-ls1046a.dtsi
index 51cbd50012d6..519315c5d507 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -630,7 +630,7 @@
 		};
=20
 		pcie@3400000 {
-			compatible =3D "fsl,ls1046a-pcie", "snps,dw-pcie";
+			compatible =3D "fsl,ls1046a-pcie";
 			reg =3D <0x00 0x03400000 0x0 0x00100000   /* controller registers */
 			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names =3D "regs", "config";
@@ -655,7 +655,7 @@
 		};
=20
 		pcie@3500000 {
-			compatible =3D "fsl,ls1046a-pcie", "snps,dw-pcie";
+			compatible =3D "fsl,ls1046a-pcie";
 			reg =3D <0x00 0x03500000 0x0 0x00100000   /* controller registers */
 			       0x48 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names =3D "regs", "config";
@@ -680,7 +680,7 @@
 		};
=20
 		pcie@3600000 {
-			compatible =3D "fsl,ls1046a-pcie", "snps,dw-pcie";
+			compatible =3D "fsl,ls1046a-pcie";
 			reg =3D <0x00 0x03600000 0x0 0x00100000   /* controller registers */
 			       0x50 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names =3D "regs", "config";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-ls1088a.dtsi
index a07f612ab56b..10b253c88a16 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -512,7 +512,7 @@
 		};
=20
 		pcie@3400000 {
-			compatible =3D "fsl,ls1088a-pcie", "snps,dw-pcie";
+			compatible =3D "fsl,ls1088a-pcie";
 			reg =3D <0x00 0x03400000 0x0 0x00100000   /* controller registers */
 			       0x20 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names =3D "regs", "config";
@@ -536,7 +536,7 @@
 		};
=20
 		pcie@3500000 {
-			compatible =3D "fsl,ls1088a-pcie", "snps,dw-pcie";
+			compatible =3D "fsl,ls1088a-pcie";
 			reg =3D <0x00 0x03500000 0x0 0x00100000   /* controller registers */
 			       0x28 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names =3D "regs", "config";
@@ -560,7 +560,7 @@
 		};
=20
 		pcie@3600000 {
-			compatible =3D "fsl,ls1088a-pcie", "snps,dw-pcie";
+			compatible =3D "fsl,ls1088a-pcie";
 			reg =3D <0x00 0x03600000 0x0 0x00100000   /* controller registers */
 			       0x30 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names =3D "regs", "config";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-ls2088a.dtsi
index 7c882da3f6b0..a5f668d786b8 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
@@ -119,7 +119,7 @@
 };
=20
 &pcie1 {
-	compatible =3D "fsl,ls2088a-pcie", "snps,dw-pcie";
+	compatible =3D "fsl,ls2088a-pcie";
 	reg =3D <0x00 0x03400000 0x0 0x00100000   /* controller registers */
 	       0x20 0x00000000 0x0 0x00002000>; /* configuration space */
=20
@@ -128,7 +128,7 @@
 };
=20
 &pcie2 {
-	compatible =3D "fsl,ls2088a-pcie", "snps,dw-pcie";
+	compatible =3D "fsl,ls2088a-pcie";
 	reg =3D <0x00 0x03500000 0x0 0x00100000   /* controller registers */
 	       0x28 0x00000000 0x0 0x00002000>; /* configuration space */
=20
@@ -137,7 +137,7 @@
 };
=20
 &pcie3 {
-	compatible =3D "fsl,ls2088a-pcie", "snps,dw-pcie";
+	compatible =3D "fsl,ls2088a-pcie";
 	reg =3D <0x00 0x03600000 0x0 0x00100000   /* controller registers */
 	       0x30 0x00000000 0x0 0x00002000>; /* configuration space */
=20
@@ -146,7 +146,7 @@
 };
=20
 &pcie4 {
-	compatible =3D "fsl,ls2088a-pcie", "snps,dw-pcie";
+	compatible =3D "fsl,ls2088a-pcie";
 	reg =3D <0x00 0x03700000 0x0 0x00100000   /* controller registers */
 	       0x38 0x00000000 0x0 0x00002000>; /* configuration space */
=20
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-ls208xa.dtsi
index d188774a36e8..80cc40f76a4a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -630,8 +630,7 @@
 		};
=20
 		pcie1: pcie@3400000 {
-			compatible =3D "fsl,ls2080a-pcie", "fsl,ls2085a-pcie",
-				     "snps,dw-pcie";
+			compatible =3D "fsl,ls2080a-pcie", "fsl,ls2085a-pcie";
 			reg-names =3D "regs", "config";
 			interrupts =3D <0 108 0x4>; /* Level high type */
 			interrupt-names =3D "intr";
@@ -651,8 +650,7 @@
 		};
=20
 		pcie2: pcie@3500000 {
-			compatible =3D "fsl,ls2080a-pcie", "fsl,ls2085a-pcie",
-				     "snps,dw-pcie";
+			compatible =3D "fsl,ls2080a-pcie", "fsl,ls2085a-pcie";
 			reg-names =3D "regs", "config";
 			interrupts =3D <0 113 0x4>; /* Level high type */
 			interrupt-names =3D "intr";
@@ -672,8 +670,7 @@
 		};
=20
 		pcie3: pcie@3600000 {
-			compatible =3D "fsl,ls2080a-pcie", "fsl,ls2085a-pcie",
-				     "snps,dw-pcie";
+			compatible =3D "fsl,ls2080a-pcie", "fsl,ls2085a-pcie";
 			reg-names =3D "regs", "config";
 			interrupts =3D <0 118 0x4>; /* Level high type */
 			interrupt-names =3D "intr";
@@ -693,8 +690,7 @@
 		};
=20
 		pcie4: pcie@3700000 {
-			compatible =3D "fsl,ls2080a-pcie", "fsl,ls2085a-pcie",
-				     "snps,dw-pcie";
+			compatible =3D "fsl,ls2080a-pcie", "fsl,ls2085a-pcie";
 			reg-names =3D "regs", "config";
 			interrupts =3D <0 123 0x4>; /* Level high type */
 			interrupt-names =3D "intr";
--=20
2.17.1

