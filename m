Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E01C43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E749D2086A
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HHfr8uvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfCKJdq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:33:46 -0400
Received: from mail-eopbgr70089.outbound.protection.outlook.com ([40.107.7.89]:55200
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727091AbfCKJdq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 05:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFq5S7SuaSi6j1HeK7buuJeG8wLjCiZSFq8eSwJLtys=;
 b=HHfr8uvcqMkUjS4MPLZgRkGYJpR+6iWk32aUMCg0vDkrpj68GqAMUrJVO7b9GSNFzmtLicUJHwUK4xj8PIKNCAMnt9gDag+xCM3nCdoLG4MX1xJ4rXFenKQoI6n+r+XgYSN2YeiduicPeTtgv01FsBVAKwZ99CQW29t425JeVXc=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB6150.eurprd04.prod.outlook.com (20.179.6.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 09:33:40 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 09:33:40 +0000
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
Subject: [PATCHv4 27/28] arm64: dts: freescale: lx2160a: add pcie DT nodes
Thread-Topic: [PATCHv4 27/28] arm64: dts: freescale: lx2160a: add pcie DT
 nodes
Thread-Index: AQHU1+2DZMvSNaCO8UigSIZD6qGo0g==
Date:   Mon, 11 Mar 2019 09:33:40 +0000
Message-ID: <20190311093130.7209-28-Zhiqiang.Hou@nxp.com>
References: <20190311093130.7209-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190311093130.7209-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:203:2e::27) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:ad::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a7c29d3-37a5-417d-3e8f-08d6a604a516
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6150;
x-ms-traffictypediagnostic: AM6PR04MB6150:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB6150;23:+PKeJXscydKLxTgh458P3ap8al0ofnWaplnuDqQ?=
 =?iso-8859-1?Q?M/Rm2Hf1kI1O/ZJaPN5tAsGDL9WZ9X4bskdouHUxUuliRHT+ZJuh92MDbE?=
 =?iso-8859-1?Q?tJEev3vYovr6b3E2ImlRN9aji3oFYpvrDYifMGAHMjCkI6hRXmv+Z5mM5O?=
 =?iso-8859-1?Q?0SNsx0umzHpFf+jKnKl4UASp9fN9w8TIDdQ7MjtyH9JtjqwNk0RCddmOMg?=
 =?iso-8859-1?Q?EFTphjrmysm4kTmPOZ2UbAvvIfGDDISIhTNDqUtHYuU95l7+zs1JPq0z79?=
 =?iso-8859-1?Q?HogDCMWIfU475PXi4EPnq+J82Epvt1TK73lx5DtRIqxFr4zp8IYxtWk0+f?=
 =?iso-8859-1?Q?NhUq1gjokIZzmCnXexxuVC3qzikr1uagJWJmFlKFZIdCp7rHH6U5PU+vAU?=
 =?iso-8859-1?Q?pEqUiBXUR0uFYL7/D2u1fwNIG02tmdEqB0acQaiRkQxqTFpSP3TvhxQkwM?=
 =?iso-8859-1?Q?O3QwXm1rUqgQ2a+A4wrMMbXByhCS24htKY2M/4lbpWAHoYeZ701A1PTiXs?=
 =?iso-8859-1?Q?4JzUXoVN1U00y20j1dCyOv3z4qMkLTdLnEG+wSLdMRPVwbLm5FMgEa+kVU?=
 =?iso-8859-1?Q?qbG+oH8XMnkvaZBzIBMZv/gwplVHedJ58ekQPv6/u8eJGLyW+DoDWbhqfl?=
 =?iso-8859-1?Q?XGTmeuuOFJJC29XqJ1bt0Xx/nkCks9rkEioRvq30+WCthFYX//ZRsDmSur?=
 =?iso-8859-1?Q?OYwkncY4n+ktHpIFeuCHGMJbiROb5lgdbbMq9W/hJh7i7NVbAIGA0L493k?=
 =?iso-8859-1?Q?jduXF2cBOFS3R6RHIi2+nfX6z4pWJ3jMvnCihkMuxpGNVBYLY+p+2of7nz?=
 =?iso-8859-1?Q?urVr67aRU/Zwj+7+5Dhgci2UsG4tpd8psLgiIVX5+AHABRbCTxWze/EqcH?=
 =?iso-8859-1?Q?7SSqtNddDYcX6WO7hqd8d4s2V2w1CWzfKJ4J7qtXRTwPPmTDRJ3v8l4m45?=
 =?iso-8859-1?Q?wcolay63rna3uX6rTTbQJOyG8j9hqfFmq0o39FpdEt0AnHyGplCAgLe9in?=
 =?iso-8859-1?Q?wbPlzzRKDk7zVaKD7Qs9s2Q/Errf/cal+k56VJQn2Tb0C+PDhecO1fAyp4?=
 =?iso-8859-1?Q?GPhmTkntr1m69ql4NvXAS7mr2rSps8nXA/2vEBANpJL9MXiL0If9xaBp+w?=
 =?iso-8859-1?Q?uc923qbh6joDuvi7g1/8Gfe+RrnfDxuewyVzXvh95fTSgDTfvnzlAOzCAL?=
 =?iso-8859-1?Q?ccoMV+1M7OguOZiizIpd+BVsXKCLNbYksCc/5gp9ygMt5gdVgWtaVaD8eI?=
 =?iso-8859-1?Q?HIuMEw7kDKHktdzpxwaELSQhOeY+D6yFJmDCgj9cbzCYf5xr/G2Ptl06yd?=
 =?iso-8859-1?Q?Ls9thKGllQBAd0JW8WmDh+d/MjSK6jKnfohxfUl+2HG9jMYB+T7qeWdPBD?=
 =?iso-8859-1?Q?Bs2KcghY=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB615062888B57C6DCF0F6BD8984480@AM6PR04MB6150.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(346002)(396003)(366004)(199004)(189003)(86362001)(54906003)(110136005)(6506007)(386003)(52116002)(99286004)(102836004)(316002)(4326008)(2201001)(50226002)(2501003)(97736004)(2906002)(66066001)(186003)(26005)(5660300002)(11346002)(76176011)(446003)(6486002)(36756003)(6436002)(25786009)(81166006)(81156014)(8676002)(478600001)(476003)(1076003)(7416002)(105586002)(305945005)(2616005)(71190400001)(71200400001)(3846002)(68736007)(6512007)(6116002)(8936002)(53936002)(7736002)(486006)(14454004)(14444005)(256004)(106356001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6150;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Eam34eUbrM0aUdLgcWoaaBw4gLHGcxbCum0e3jF0atbVNfUem71TIOVSiJ0+oq/IgjEa2kbH3+4hRHmBvjAeb4pkBFG8UGSUyg0iwPwawCxOAb5LE4QYi4iJoC6cW+/28dku9nmQjpRuDSbqEUL9z4ycBYb8Ih3YbHnwtSgspJbzuaHaP+D/zo5Db3HRKzKQWvcLU9fFKCpDQ3fgAyhrQquoTxMBmnD11y6YwFI1trjeeankiOKTvlpYxmglcozfgXocdyGas1pog28PJ3Glbzqr7E4q3hx0/2M72XUiNAyD5AQZ6p57RC9pgo3/O2AlC+DkOGGk2nFtgqOSX+gy2sfyrGgo6X4RFhloAe1Kb0ROdlgCJjYsfRS3pEO+1F0gkzx9lZE7UMKjsTJkkvg4rw3r38Knf2fK5uVaZvA6d5M=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7c29d3-37a5-417d-3e8f-08d6a604a516
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 09:33:40.7047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6150
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The LX2160A integrated 6 PCIe Gen4 controllers.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
V4:
 - no change

 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 163 ++++++++++++++++++
 1 file changed, 163 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-lx2160a.dtsi
index fe87204850b5..3a64f6eb8ce9 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -895,5 +895,168 @@
 				};
 			};
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
+			apio-wins =3D <256>;
+			ppio-wins =3D <24>;
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
+			apio-wins =3D <256>;
+			ppio-wins =3D <24>;
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

