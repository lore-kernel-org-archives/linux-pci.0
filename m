Return-Path: <SRS0=18Ni=NF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BF4C46475
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 09:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B634620840
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 09:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RkxFNjQa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B634620840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeJYSVl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Oct 2018 14:21:41 -0400
Received: from mail-eopbgr00089.outbound.protection.outlook.com ([40.107.0.89]:27552
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727355AbeJYSVl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Oct 2018 14:21:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3sBcy0FyCgsMSlgcsfprTXnhYDNAMWmsomWoAb3kxU=;
 b=RkxFNjQaf7E6AtUyv1FpU7NqRqdU7oxTnKAgSETcMF3KWXT4lMsAUyJIKFOdcJeU5xgywXU2q9S8UYm2XK2JlDbykqo0ifQeNckUUHcHwWxL1trrS2PaQmI8V8bWxYGktwJ3eoAivq5CXOdE37VtedmjTrJCklJvMdFxxQKfiwY=
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com (10.162.155.27) by
 DB5PR04MB1208.eurprd04.prod.outlook.com (10.162.155.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Thu, 25 Oct 2018 09:49:39 +0000
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb]) by DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb%2]) with mapi id 15.20.1250.028; Thu, 25 Oct 2018
 09:49:39 +0000
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
Subject: [PATCH v2 2/4] dt-bindings: pci: layerscape-pci: removed compatible
 string "snps,dw-pcie"
Thread-Topic: [PATCH v2 2/4] dt-bindings: pci: layerscape-pci: removed
 compatible string "snps,dw-pcie"
Thread-Index: AQHUbEgLa9gOTjLo+Ua7yCtmm3A8FQ==
Date:   Thu, 25 Oct 2018 09:49:39 +0000
Message-ID: <20181025094929.29481-3-Zhiqiang.Hou@nxp.com>
References: <20181025094929.29481-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181025094929.29481-1-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;DB5PR04MB1208;6:8QNqIiGnF4prT168jylOS8n6UQpinkfQurhMTLTdzeS7UHPt4dg5CgkHsOS+NzLlX4EZNNyzLMhYOkvGgwEE/RuTcvA7qTThZsowRQfxXmjPfxdyuLs2Yj+SpmWFqchW4hbkgb2BX2hbTg3cVbRxd+6lXPXeQYAZr+q4nBMw+78vu8wa2msWuivZ8cjm9mLLXEtU9u3pLfkww1O8ay5xfgA735FWlZ4dAYC6gEDh3lDLZt3t7/2M4e9Een0my73WfzlJcXmUl4FMWT3j3Mn/I4w1wc47VwFwBrhUn3M63eduq5F4uzayuVfq6wJ2+G4R7KCmCNBfAKFyJJblAUsONZ9Jq2DrMuCCl0CmWafBmB8iey+Sb5wjCQK+lj/V7qPbStPAqfUSwP4np0x2aYqlEjfXklrJG07zpeFuGyJLoJ5AgNA9O5JENuPw5A2AOEBhWOfK8PUfrUIlezqJJRJSKw==;5:LsxfRxwursoNt5H2iE7PdCofEZjlFoeugEG8q1gU4p434XM/RJ7ANrSAuebKSnS7XPmaz8VSPYgYruS4R209+00fiEgrwEClvfALlUhTAl6yMHoQEz3k3rKPYLJcsjhDT3DgHB9ER81005Kp/YHU0uxvCiGtA7Eia3h8ZlDqfSA=;7:4qlxu7M0rYZVx49bDPmDMCGZR01WPFTyu9OGlTgnAhVbBpXGn14riE7rG4ycvjJ738rVMjtnGg4sQgVMunPP6BL6hZTwoApB5dr6tZ1nYrs45x3I7je+zKaa73glfCj/t2mDXOYVrNp4We55u+igN1igxUWNm6mM+MrEqtbwhoo9Kudi6byNQ86pDc9w/zCMinsgtOZFOjf3pkKchRDD+d6n+oZqXl5kz11GDAYkfY77bX7h1IOip0g7vStEbKsz
x-ms-office365-filtering-correlation-id: de47aa52-8dd1-49ea-1421-08d63a5f2df7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1208;
x-ms-traffictypediagnostic: DB5PR04MB1208:
x-microsoft-antispam-prvs: <DB5PR04MB12083991F21E2B0D2C7A2F3D84F70@DB5PR04MB1208.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB5PR04MB1208;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1208;
x-forefront-prvs: 083691450C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(136003)(39860400002)(199004)(189003)(446003)(486006)(6116002)(3846002)(102836004)(5660300001)(6636002)(6506007)(386003)(256004)(99286004)(6486002)(1076002)(76176011)(86362001)(110136005)(7736002)(305945005)(52116002)(2501003)(5250100002)(2201001)(26005)(71200400001)(71190400001)(316002)(478600001)(2900100001)(4326008)(25786009)(68736007)(97736004)(81156014)(53936002)(6512007)(8936002)(81166006)(6436002)(14454004)(105586002)(186003)(8676002)(2616005)(11346002)(476003)(36756003)(66066001)(106356001)(2906002)(921003)(142933001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1208;H:DB5PR04MB1221.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ojuizyG4mh9Ov3EPDereVksyPirTxs1+mubp+spd59RqQh726YpASdq/iXcV+49w3GzxyB9O9EmYl+K0TCz1BM6kYV6D+d917JLmQjfoO9+/Gn/wtyv782EiwRWNr0XBQ1zqqdAGh12lG1gbQ2V2HB5RWE0RmFvqsOhsB/IFXqrFbvZb2Tz+Y2SeZQ4/OZUO2hLagVt4a3rgoXHrbgFegW3MACbjjfSKyymiTRYvp3u7hoQN0x0uusTUNoJvLhQDvwTxkdMgYdQKUba+mVcslSg8WJwrVFiTvsN3FQiqa4uGLZGGw5fm5vNlDarBq76xrt8rQhbMleCK0A1Tb6tuM1Agf2+/yTlmyhDk5MZ7xhA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de47aa52-8dd1-49ea-1421-08d63a5f2df7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2018 09:49:39.2131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1208
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
---
V2:
 - Improved the subject.

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

