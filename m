Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4240AC43610
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B792075B
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XPaaKFI2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B792075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbeKTTzW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:55:22 -0500
Received: from mail-eopbgr70083.outbound.protection.outlook.com ([40.107.7.83]:29568
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727166AbeKTTzV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 14:55:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePwAFGVsVHvPO6KTDI1NHxc+DeJJ2cOiUT6B8wuQgBY=;
 b=XPaaKFI2ksHfY6yFcavIBQDjxdZzZhxMWeXUxHTVa4Pbm6iit7MLa/W1duaKLlu3g9Rhjyf5K0plEA2r4pxEhpL25rzmcnp9stLuBiumYccxGXaBgrqJQRSUwvPMeC05lyHLrI/yWQISTCdQxy2eNNt3Xc3kMHpKXfeXF1SLDHI=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB5269.eurprd04.prod.outlook.com (20.177.35.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.21; Tue, 20 Nov 2018 09:27:09 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c%4]) with mapi id 15.20.1339.026; Tue, 20 Nov 2018
 09:27:09 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCHv2 15/25] dt-bindings: pci: mobiveil: change gpio_slave and
 apb_csr to optional
Thread-Topic: [PATCHv2 15/25] dt-bindings: pci: mobiveil: change gpio_slave
 and apb_csr to optional
Thread-Index: AQHUgLM1AcYaMXR/GE2OPnFnxNzh5w==
Date:   Tue, 20 Nov 2018 09:27:08 +0000
Message-ID: <20181120092615.11680-16-Zhiqiang.Hou@nxp.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR03CA0050.apcprd03.prod.outlook.com
 (2603:1096:202:17::20) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:aa::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5269;6:JtaAMmW4X8RqcCxWDVZcz2ycan15HvhL4nYca6iVqUHk92KFN/ZCVJ/sa5UEzpCCckHLlUsnVxigOB20KNN3zFBWNjVNRYGQt8wcpt2YA7zhF9E75AJBXhRUzvOcc+pgl12cICvTTNzdbuIEdK9gnof0CcMjvPWQ0H9Sr2DL+inq8CfhrBcUJJq4NjCyQQm13dBI83kmW+ufuBThUkWzwqJl9oh0UUb1T0cKFQKAg7uxp18xxDHiehU4ScupVruC26ndBkHUomDyyOOwYfgXoxc7eJXVqff2siaM4jY1PsALhcE4yDulaxVLvzyF+tSY5F6uUA8d0AIneNGzpglRCrP9i2dgOqWBN1jC6k51kjoQw2wNSnT9TGIlT7yhBdNw7qKl4BJgphzk4FcR5+WVVS0Vg+wZw/U0SWCC+hO8PSuqvQITr8WJ6lPaBtjhGtKTLD7lf3kI8JaQ9Mt+MUf2aQ==;5:tAYpgP2L7p3O5/pLgDGQTYMxRSxBT9yI4tXcOVASiyIult/TjAm+Ej5LNEwqCMoMHpSCopls6chyZtCX8U0uFLGaUcrqYrCRGyCq5vmVcRhKCXDFMjg8gMIRDdslqcET6Rn9TnRv4LhqvuxKe/yfsZNj7YmZxRxa0hr5zFAfxyI=;7:bNQIvnLmRs4Lxhc4ESuaNQ3f2ueIDBJXOFez9iXiMTspZpvuml6BTJTkI0aOgxSHz7d6L3f/pONnlaEhPSAo79i1bdAl3vHr2zXxK2+3sTXOO2WTaRBCdWXR/m3+jlsWGLyXbE5AYNuoO5t7WrbjNQ==
x-ms-office365-filtering-correlation-id: f7e9de60-7c56-48bc-8525-08d64eca57f4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5269;
x-ms-traffictypediagnostic: AM6PR04MB5269:
x-microsoft-antispam-prvs: <AM6PR04MB5269A2607F8F67382488AFFB84D90@AM6PR04MB5269.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5269;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5269;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(366004)(39860400002)(189003)(199004)(305945005)(7736002)(36756003)(5660300001)(7416002)(68736007)(2906002)(4326008)(8936002)(14454004)(256004)(54906003)(53936002)(6436002)(71200400001)(110136005)(71190400001)(6512007)(316002)(2616005)(476003)(446003)(11346002)(486006)(25786009)(2501003)(2201001)(86362001)(52116002)(76176011)(6506007)(102836004)(386003)(186003)(106356001)(26005)(2900100001)(81156014)(81166006)(105586002)(6486002)(8676002)(99286004)(66066001)(6116002)(3846002)(1076002)(478600001)(97736004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5269;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vgUOUSkBwDtLQkUuLSzpQW5nHtUst7YdTPvIL5siIz1kx2H8qbI1Lbjlc5EYWzXC8aokz6QfiyJ3Mo87osUV3wTPc/fDWeC5R2w+zKEKevQcfhOtZ/XxJnh16J7fuCSAqXt1U/nX5JSzj8z6axsfyb7QNN89Uu8QmoinC67Sj6vMBeXixsvmr2bruQbuY/g/Pkv7tgdYHtm4S00HJYNx4j8OUSookV8pnDSP3b9pkWZkQxsafxzgTbGXKxkIVSyRqEHzZ7atk3+zBR3fFBvR24xaPn2bH+MDjb/zu5x52U5jX4Z2VAI/lFyBcXToomRHtYrqcgoSNm1MX4q7Q54gLf/99BnzcRibJsNul3fA11Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e9de60-7c56-48bc-8525-08d64eca57f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 09:27:09.0350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5269
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Change the "gpio_slave" and "apb_csr" to optional, the "gpio_slave"
is not used in current code, and "apb_csr" is not used by some
platforms.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Acked-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Acked-by: Rob Herring <robh@kernel.org>
---
V2:
 - no change

 Documentation/devicetree/bindings/pci/mobiveil-pcie.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt b/Docu=
mentation/devicetree/bindings/pci/mobiveil-pcie.txt
index a618d4787dd7..64156993e052 100644
--- a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
@@ -10,8 +10,10 @@ Required properties:
 	interrupt source. The value must be 1.
 - compatible: Should contain "mbvl,gpex40-pcie"
 - reg: Should contain PCIe registers location and length
+	Mandatory:
 	"config_axi_slave": PCIe controller registers
 	"csr_axi_slave"	  : Bridge config registers
+	Optional:
 	"gpio_slave"	  : GPIO registers to control slot power
 	"apb_csr"	  : MSI registers
=20
--=20
2.17.1

