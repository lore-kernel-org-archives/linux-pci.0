Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F403C43610
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19AE20671
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DoYNentk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F19AE20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbeKTT4S (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:56:18 -0500
Received: from mail-eopbgr70089.outbound.protection.outlook.com ([40.107.7.89]:12064
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727728AbeKTT4S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 14:56:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrsGMBADIsqeEU4duNCkqzr5ye0dCRBHJDsrbmznpI4=;
 b=DoYNentknLCea+B03Mc2Y2lnydHXHpYKbaiuULDXggD42zaR7B2KDqbXtAgEu1pOx3/qOKa37YT2dJRMJl7Bpd/valK4kTCyx3KXwsJr4aZ7U+g5lzNrtGaKkNiXON4/SkA/dFyP+hEozOGTxG9fpW8L69HJdDYHvKpr8gTwW5E=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB4775.eurprd04.prod.outlook.com (20.177.32.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.21; Tue, 20 Nov 2018 09:28:03 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c%4]) with mapi id 15.20.1339.026; Tue, 20 Nov 2018
 09:28:03 +0000
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
Subject: [PATCHv2 24/25] arm64: dts: freescale: lx2160a: add pcie DT nodes
Thread-Topic: [PATCHv2 24/25] arm64: dts: freescale: lx2160a: add pcie DT
 nodes
Thread-Index: AQHUgLNW1TfB2GtMH0GXyxrHVyVRKg==
Date:   Tue, 20 Nov 2018 09:28:03 +0000
Message-ID: <20181120092615.11680-25-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4775;6:B+61WwH01BhOQvBjM9t2eSkCCF2UeWAvhzFzm4yGICRT7tM+kNE6+J466XX+bnjZevmkNS761ldCWJ5Wed6ne544ICDyzDzf/GtiVYnB82qWuupjY4G97ZustIpyQ7z3+hETfTXOprzUuoFcaFmLZcFMR4jhaUh57OA7rO6AJxbBfR0sWFRbqyHPhISti7h7cJ1je/THEryZmf4t66zcVSiMHk6fjSiNEMcnsLt0/D2gdutPIzj8dDXrFgDie0g2pVhxbSj7SFcHwHf6QXO2zjDGTIlFnISTYLS5Wn6GfkugC4yqqimMjWTmXcTAw74VyDFZVCeloM1pkjW9XgcTyLb5tpfTWAX04xxuwFjHG5M4t+18XJHbPH615cXKEEVNQhYIWxm7d5Eu/IERXDxKtQwLd3kztlfqMguJdvZcmCWVpVpArHKo2Uk5InYxXZhTp2eSJXXfir82kBvFUa7Jlg==;5:MvEgIVOfB/b8UQToi9wBiioCqZKgjQdwfLE0lqrABP7/dHV1Gp8TLhTz1T0IKRz6oNIxaHMaBx9mO1GN1rmJp5+JWmZDKut09qywVRPH9AaDDuGshkkkdlG5S6qWFd1HbCxVQmiSTPLAQu/yQgjSJOJgWOxKlrnWBWIyZOTADeA=;7:y8vRGBRLVEHWmmYlFy1dFiTjH+AjP4TzOwjuT5FLR3+DWADtwjNo2AnYLe0pWbG9fyHkk9t93u3AW/IsxGnzSdLUVByP1DGFUe8CXOxBbb+Tmi7RynUK1WTng2THoSBRIFZDkHuP+PdYWGnksBtaQw==
x-ms-office365-filtering-correlation-id: c1a2c36f-95c8-4f41-8eb7-08d64eca78ba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4775;
x-ms-traffictypediagnostic: AM6PR04MB4775:
x-microsoft-antispam-prvs: <AM6PR04MB4775B44F6D3493B8FEAFE6E084D90@AM6PR04MB4775.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231442)(944501410)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4775;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4775;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(376002)(396003)(346002)(189003)(199004)(66066001)(1076002)(2900100001)(68736007)(8676002)(6486002)(5660300001)(8936002)(6116002)(3846002)(2501003)(97736004)(81166006)(26005)(186003)(81156014)(105586002)(7416002)(102836004)(2906002)(386003)(6506007)(7736002)(305945005)(106356001)(6512007)(76176011)(36756003)(4326008)(99286004)(52116002)(14444005)(25786009)(110136005)(54906003)(2616005)(86362001)(53936002)(446003)(11346002)(256004)(2201001)(6436002)(486006)(71190400001)(71200400001)(478600001)(316002)(476003)(14454004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4775;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ba/f1I8T2tupY/jhvcak62sp4VKj7JpZZzW3wsrc5Kc9L3eH6syRwcod35uuqU1UHPNHZ8ITMI3Q9UycCMrWd0+77FcdShIwnhz1sqj3LyWkr7UcSI408Xaidpw/fXYbHkBoPM7feHRz+sCwKgGMwuimW90bt3T3+8mv+WcnAuQv0Meais7YMsHYfGEodmLo4JBy9ijnuEgrEUwj4glhOXt9Yw2tPc06Euh2IMI5HR4u4WMG2T6t/q1SEtxj85bVRTb7Jb/BdW0MMBi0SNoE8vJB4B3M+dzJJoRHe5weupamfHspd+w/8uESJGtY8+pjNg1u3cF5nhfn0A1Gep3gsKB+VLIADeRFySgBsqAUddU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a2c36f-95c8-4f41-8eb7-08d64eca78ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 09:28:03.7856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4775
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The LX2160A integrated 6 PCIe Gen4 controllers.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - Change the default status of PCIe DT nodes to disabled.

 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 163 ++++++++++++++++++
 1 file changed, 163 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-lx2160a.dtsi
index a79f5c1ea56d..3a098c462a25 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -762,5 +762,168 @@
 				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
 			dma-coherent;
 		};
+
+		pcie@3400000 {
+			compatible =3D "fsl,lx2160a-pcie";
+			reg =3D <0x00 0x03400000 0x0 0x00100000   /* controller registers */
+			       0x80 0x00000000 0x0 0x00001000>; /* configuration space */
+			reg-names =3D "csr_axi_slave", "config_axi_slave";
+			interrupts =3D <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
+				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
+				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+			interrupt-names =3D "aer", "pme", "intr";
+			#address-cells =3D <3>;
+			#size-cells =3D <2>;
+			device_type =3D "pci";
+			dma-coherent;
+			apio-wins =3D <8>;
+			ppio-wins =3D <8>;
+			bus-range =3D <0x0 0xff>;
+			ranges =3D <0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>; =
/* non-prefetchable memory */
+			msi-parent =3D <&its>;
+			#interrupt-cells =3D <1>;
+			interrupt-map-mask =3D <0 0 0 7>;
+			interrupt-map =3D <0000 0 0 1 &gic 0 0 GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>=
,
+					<0000 0 0 2 &gic 0 0 GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic 0 0 GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic 0 0 GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+			status =3D "disabled";
+		};
+
+		pcie@3500000 {
+			compatible =3D "fsl,lx2160a-pcie";
+			reg =3D <0x00 0x03500000 0x0 0x00100000   /* controller registers */
+			       0x88 0x00000000 0x0 0x00001000>; /* configuration space */
+			reg-names =3D "csr_axi_slave", "config_axi_slave";
+			interrupts =3D <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
+				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
+				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+			interrupt-names =3D "aer", "pme", "intr";
+			#address-cells =3D <3>;
+			#size-cells =3D <2>;
+			device_type =3D "pci";
+			dma-coherent;
+			apio-wins =3D <8>;
+			ppio-wins =3D <8>;
+			bus-range =3D <0x0 0xff>;
+			ranges =3D <0x82000000 0x0 0x40000000 0x88 0x40000000 0x0 0x40000000>; =
/* non-prefetchable memory */
+			msi-parent =3D <&its>;
+			#interrupt-cells =3D <1>;
+			interrupt-map-mask =3D <0 0 0 7>;
+			interrupt-map =3D <0000 0 0 1 &gic 0 0 GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>=
,
+					<0000 0 0 2 &gic 0 0 GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic 0 0 GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic 0 0 GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+			status =3D "disabled";
+		};
+
+		pcie@3600000 {
+			compatible =3D "fsl,lx2160a-pcie";
+			reg =3D <0x00 0x03600000 0x0 0x00100000   /* controller registers */
+			       0x90 0x00000000 0x0 0x00001000>; /* configuration space */
+			reg-names =3D "csr_axi_slave", "config_axi_slave";
+			interrupts =3D <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+			interrupt-names =3D "aer", "pme", "intr";
+			#address-cells =3D <3>;
+			#size-cells =3D <2>;
+			device_type =3D "pci";
+			dma-coherent;
+			apio-wins =3D <8>;
+			ppio-wins =3D <8>;
+			bus-range =3D <0x0 0xff>;
+			ranges =3D <0x82000000 0x0 0x40000000 0x90 0x40000000 0x0 0x40000000>; =
/* non-prefetchable memory */
+			msi-parent =3D <&its>;
+			#interrupt-cells =3D <1>;
+			interrupt-map-mask =3D <0 0 0 7>;
+			interrupt-map =3D <0000 0 0 1 &gic 0 0 GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>=
,
+					<0000 0 0 2 &gic 0 0 GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic 0 0 GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic 0 0 GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+			status =3D "disabled";
+		};
+
+		pcie@3700000 {
+			compatible =3D "fsl,lx2160a-pcie";
+			reg =3D <0x00 0x03700000 0x0 0x00100000   /* controller registers */
+			       0x98 0x00000000 0x0 0x00001000>; /* configuration space */
+			reg-names =3D "csr_axi_slave", "config_axi_slave";
+			interrupts =3D <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
+				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
+				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+			interrupt-names =3D "aer", "pme", "intr";
+			#address-cells =3D <3>;
+			#size-cells =3D <2>;
+			device_type =3D "pci";
+			dma-coherent;
+			apio-wins =3D <8>;
+			ppio-wins =3D <8>;
+			bus-range =3D <0x0 0xff>;
+			ranges =3D <0x82000000 0x0 0x40000000 0x98 0x40000000 0x0 0x40000000>; =
/* non-prefetchable memory */
+			msi-parent =3D <&its>;
+			#interrupt-cells =3D <1>;
+			interrupt-map-mask =3D <0 0 0 7>;
+			interrupt-map =3D <0000 0 0 1 &gic 0 0 GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>=
,
+					<0000 0 0 2 &gic 0 0 GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic 0 0 GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic 0 0 GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+			status =3D "disabled";
+		};
+
+		pcie@3800000 {
+			compatible =3D "fsl,lx2160a-pcie";
+			reg =3D <0x00 0x03800000 0x0 0x00100000   /* controller registers */
+			       0xa0 0x00000000 0x0 0x00001000>; /* configuration space */
+			reg-names =3D "csr_axi_slave", "config_axi_slave";
+			interrupts =3D <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
+				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
+				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+			interrupt-names =3D "aer", "pme", "intr";
+			#address-cells =3D <3>;
+			#size-cells =3D <2>;
+			device_type =3D "pci";
+			dma-coherent;
+			apio-wins =3D <8>;
+			ppio-wins =3D <8>;
+			bus-range =3D <0x0 0xff>;
+			ranges =3D <0x82000000 0x0 0x40000000 0xa0 0x40000000 0x0 0x40000000>; =
/* non-prefetchable memory */
+			msi-parent =3D <&its>;
+			#interrupt-cells =3D <1>;
+			interrupt-map-mask =3D <0 0 0 7>;
+			interrupt-map =3D <0000 0 0 1 &gic 0 0 GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>=
,
+					<0000 0 0 2 &gic 0 0 GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic 0 0 GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic 0 0 GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
+			status =3D "disabled";
+		};
+
+		pcie@3900000 {
+			compatible =3D "fsl,lx2160a-pcie";
+			reg =3D <0x00 0x03900000 0x0 0x00100000   /* controller registers */
+			       0xa8 0x00000000 0x0 0x00001000>; /* configuration space */
+			reg-names =3D "csr_axi_slave", "config_axi_slave";
+			interrupts =3D <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+			interrupt-names =3D "aer", "pme", "intr";
+			#address-cells =3D <3>;
+			#size-cells =3D <2>;
+			device_type =3D "pci";
+			dma-coherent;
+			apio-wins =3D <8>;
+			ppio-wins =3D <8>;
+			bus-range =3D <0x0 0xff>;
+			ranges =3D <0x82000000 0x0 0x40000000 0xa8 0x40000000 0x0 0x40000000>; =
/* non-prefetchable memory */
+			msi-parent =3D <&its>;
+			#interrupt-cells =3D <1>;
+			interrupt-map-mask =3D <0 0 0 7>;
+			interrupt-map =3D <0000 0 0 1 &gic 0 0 GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>=
,
+					<0000 0 0 2 &gic 0 0 GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic 0 0 GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic 0 0 GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			status =3D "disabled";
+		};
+
 	};
 };
--=20
2.17.1

