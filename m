Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C26C32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D942085B
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m/41wVvh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D942085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388298AbeKFWqr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:46:47 -0500
Received: from mail-db5eur01on0088.outbound.protection.outlook.com ([104.47.2.88]:27376
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388180AbeKFWqq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Nov 2018 17:46:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uH+NVtMyK88ERBuGiA3bleC7dKqchyffkOY+IM6SfLI=;
 b=m/41wVvheKP4mohlXq5KxKcew07MVGixcNINL6yeBli4W4c6Zb6Kk5A3IsbgP+YyghY3p+ro5/U97RfInloM9TJPCgTvEc8cYcKCKyoC+McNoX0794Kubf8BMYYsTOdEsk3LoLFqtTcJM2m6h56U6eg2+gbZMgc16AEtkRJb+wc=
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com (10.162.155.27) by
 DB5PR04MB2119.eurprd04.prod.outlook.com (10.166.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.28; Tue, 6 Nov 2018 13:21:31 +0000
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb]) by DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb%2]) with mapi id 15.20.1273.035; Tue, 6 Nov 2018
 13:21:31 +0000
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
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCH 23/23] arm64: dts: freescale: lx2160a: add pcie DT nodes
Thread-Topic: [PATCH 23/23] arm64: dts: freescale: lx2160a: add pcie DT nodes
Thread-Index: AQHUddOh0w0BqLXql0i/nqlyxcYYgg==
Date:   Tue, 6 Nov 2018 13:21:31 +0000
Message-ID: <20181106131807.29951-24-Zhiqiang.Hou@nxp.com>
References: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0008.apcprd03.prod.outlook.com
 (2603:1096:203:2e::20) To DB5PR04MB1221.eurprd04.prod.outlook.com
 (2a01:111:e400:51c2::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB5PR04MB2119;6:pKpXm3U9Rp7/iuw8MFd/5aZazFReMSkj38m1SnPpdfYKZyX45BcAJvghviQ3W4ZoS0L0tet4HSfBr3I1cobRKdA4O8yKBOdK1xNfXyVqcXo/D5I1Ej48T5GDUuHMpWw1f+32c7RZ1Z58Jcj1+AeMmKqLUhbpDNy0Ghv0WKYv/9Wi2rJKV6EI2RLnksYVXS2i+TTQHf8g3zDvuuGUPMstqwr7SKcUlbAFhXQSA6TsFL3YZlw3uu55SLxWSxRbAyqPXhmfO2OWBOIDCX+hzolr0rAb91XtDuj5LFX/SYw13A3X5KCfa3QzdWq+0SJGnR7+gm9SDgUrci/oCstZ9lOT85m5MjZWrl09+OwUasWPWww8L4BcxGRhK4PMP0XaQOlGLNkh+9LTi9t08zAALbI2qlM8cuYFFJ96bKA9A9U5lIVK2/dx+/U0mJAhrMocmOwA4d4Kc7ITRiIQBecbRgy8gw==;5:bC68TqHuRo6g1WWVQtnUtZ069OsfGUvt4RpOBBsBm/qLb1SgAnAOUw6iu5CFu0eZmgU8LfarE/fORYqwdXyenmOv1bnsxFotD92KAgsFqKmcTprcteJafzqTrWX+KNVfcAe4ZQy/4lAT4c5hCHET60nj5lmknv8KFtFPW6nqMVQ=;7:fz7YW1yZnHz2p4fg9/wUF1Uz+nGYQpTB8EYX5cfMWqm9a3cf24NMw2Byt64KqNNpUeX0hrOYlXWQ0dJIw7QaCB2G3SfXXtSzzM5O4XSLlWLRXEkpPJKMYsXbg+I51mkdduAC1oJIpRtwqgWcnrwiWw==
x-ms-office365-filtering-correlation-id: 02cdaa70-aea5-416f-209c-08d643eac3de
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB2119;
x-ms-traffictypediagnostic: DB5PR04MB2119:
x-microsoft-antispam-prvs: <DB5PR04MB2119F41CE2D188A4B0C2332B84CB0@DB5PR04MB2119.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231382)(944501410)(52105095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB5PR04MB2119;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB2119;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(346002)(376002)(396003)(136003)(39860400002)(366004)(189003)(199004)(81156014)(99286004)(2201001)(8936002)(86362001)(6486002)(68736007)(6436002)(5660300001)(478600001)(53936002)(6512007)(4326008)(25786009)(36756003)(14454004)(54906003)(186003)(316002)(110136005)(2906002)(2900100001)(1076002)(3846002)(6116002)(81166006)(8676002)(7416002)(256004)(14444005)(446003)(11346002)(486006)(476003)(2616005)(7736002)(305945005)(71190400001)(71200400001)(66066001)(97736004)(76176011)(52116002)(102836004)(106356001)(26005)(2501003)(105586002)(386003)(6506007)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB2119;H:DB5PR04MB1221.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9Lw/fxCGhNfATjJP0uA6I90xyikLpq2MNSQR5rG7YFnBQocLMyRah+IvM0JcgXLLjI3+9CdksER0eLVKC6UPUxw6q7y6KkVw86oe+SUDOyRNfHoU/YZNEoZ0qBajzlKdhfQGYxcBQWmrE8ZcHc30uoAQvcMu99Lo6lZj7sbxYqRe2jWR4qoUY59ZA816Xd8WilsbjG3RYN0MLf2Wb3wm5O0YlTAGi2pGESuVm99Ph7zNAF5IXtdcimFdsPbXojZRAFJmtOumZizhfC2PwGzGYmg7h/RF7yyVLoo5yut8KQU2rSYQumXuRMvAYQg00pTmg6ghnu/HH8b/R3aoFkk9QwFd48IRtTgtMrVc6By4EEE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02cdaa70-aea5-416f-209c-08d643eac3de
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 13:21:31.1390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB2119
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 157 ++++++++++++++++++
 1 file changed, 157 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-lx2160a.dtsi
index 6ba722e373ee..49dfaaf7560d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -953,5 +953,162 @@
 			clock-names =3D "fspi_en", "fspi";
 			status =3D "disabled";
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
+			interrupt-map =3D <0000 0 0 1 &gic 0 0 0 109 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 2 &gic 0 0 0 110 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic 0 0 0 111 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic 0 0 0 112 IRQ_TYPE_LEVEL_HIGH>;
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
+			interrupt-map =3D <0000 0 0 1 &gic 0 0 0 114 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 2 &gic 0 0 0 115 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic 0 0 0 116 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic 0 0 0 117 IRQ_TYPE_LEVEL_HIGH>;
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
+			interrupt-map =3D <0000 0 0 1 &gic 0 0 0 119 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 2 &gic 0 0 0 120 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic 0 0 0 121 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic 0 0 0 122 IRQ_TYPE_LEVEL_HIGH>;
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
+			interrupt-map =3D <0000 0 0 1 &gic 0 0 0 124 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 2 &gic 0 0 0 125 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic 0 0 0 126 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic 0 0 0 127 IRQ_TYPE_LEVEL_HIGH>;
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
+			interrupt-map =3D <0000 0 0 1 &gic 0 0 0 129 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 2 &gic 0 0 0 130 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic 0 0 0 131 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic 0 0 0 132 IRQ_TYPE_LEVEL_HIGH>;
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
+			interrupt-map =3D <0000 0 0 1 &gic 0 0 0 104 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 2 &gic 0 0 0 105 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic 0 0 0 106 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic 0 0 0 107 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 	};
 };
--=20
2.17.1

