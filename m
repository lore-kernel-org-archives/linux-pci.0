Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6B1C4161B
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C79F2075B
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="teeofgjY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C79F2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbeKTWB3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 17:01:29 -0500
Received: from mail-eopbgr70048.outbound.protection.outlook.com ([40.107.7.48]:40000
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729088AbeKTWB3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 17:01:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ef046tX0DATMSVRMHM+bIo80rmAELp4ear3rY98/1g4=;
 b=teeofgjY/eg4MeqVbH0LVS1d4WHo6pfFAay/IWEmD84kbHlFMlTMyYQLO/dnXCGBv5YjxawEINy0J9BUv9e+lnAXX2LP86t6eC9ipCHMWd+hc/OOefASMvDaT1IJJh6Mw98oH5Gp3iwoS5ErbDZ87hUTlRNnRB+vN8bmgyrAE60=
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com (10.168.32.20) by
 HE1PR0401MB2203.eurprd04.prod.outlook.com (10.166.76.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.23; Tue, 20 Nov 2018 11:32:37 +0000
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2]) by HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2%8]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 11:32:37 +0000
From:   "M.h. Lian" <minghuan.lian@nxp.com>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
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
CC:     Mingkai Hu <mingkai.hu@nxp.com>, Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [PATCHv2 24/25] arm64: dts: freescale: lx2160a: add pcie DT nodes
Thread-Topic: [PATCHv2 24/25] arm64: dts: freescale: lx2160a: add pcie DT
 nodes
Thread-Index: AQHUgLNWnvf3rghPTE+EulL4aQKwXaVYiAzg
Date:   Tue, 20 Nov 2018 11:32:36 +0000
Message-ID: <HE1PR0401MB22354DD78E9ACB940DBB01A0E8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-25-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181120092615.11680-25-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=minghuan.lian@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB2203;6:WpHUWnkpU/RIW92+HIGwQZzsk9azebu4JOGwGaa2i3v5wRNtGLM/S1xWPjl3LYhSHGyE73EwSlxc9C+18YrcHw18IGsCTgwp0TNt4Y4KH3A7gK+kGIZK0dL3FZMXC3AVJ3TvGmsotdMuDMBEUvt1zuYbqWYJp3gJOMKnm6KYAKdfpjdUV4Q/o0m24Z+RdYnrWtmESeDNf3r0FbfiphBBDViEpU7xJ0O3b5GsJlbZYwxnFPBPZkIbBI/D4wYWfG7TCokPub8SFAn7FGj7h3gNgvMGopKKx3EkTSwPK8pu3RMYZf3i3v/bpogUJfsvxnKfmGNE2PBWNBLFRht40BB/bky0z/YGBmUnDzehaC5+NNTS5xso0sH1Xn1oQbiIcIe/KFlo8sPToj8yFfculT0Fc+TY+qE3Q/EylHbPZA0A6dZCn+mnSFN3WszofPNpn/twkFt/m0BlHEL2YZR9GO96Zy0QTo+LFxkYal2FHZQsexc=;5:3sWnDKqwEv3iR0WPdXzOPunfWne0O4ZpCp1295+scCyTZLRBEHGXUJyphgu2rG+HXaxiGIV+kCYN0Q0jhj8E3eHLXGDo20rzLgYGCUfLcQlhk3mHDjDImLnCocfFBOe8vijukfZ0sfckKWw6cHcVhCfNtBsqsyyJsjAhVpJh/7w=;7:OAklfId7+6NxVtTZ+68MoqYh06BCLvEHBtmxCcCXXwprg6l5RY5uwt51EenjRyHC3qsL/p+wfc3tQoHwb/zSdZOSE84vuX282v1soomwc7zfAXwotyyAkekUILIdM7q899imPdu9FktFbknxqb5auQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 31dcbe8c-a025-4179-e259-08d64edbdf4e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2203;
x-ms-traffictypediagnostic: HE1PR0401MB2203:
x-microsoft-antispam-prvs: <HE1PR0401MB22038127FF9EC7A8B06D1239E8D90@HE1PR0401MB2203.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(10201501046)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:HE1PR0401MB2203;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2203;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(366004)(136003)(39860400002)(189003)(199004)(13464003)(6116002)(54906003)(478600001)(97736004)(33656002)(8676002)(81156014)(81166006)(68736007)(8936002)(186003)(4326008)(110136005)(14454004)(3846002)(71190400001)(2906002)(316002)(71200400001)(25786009)(2501003)(6246003)(256004)(305945005)(76176011)(2201001)(7736002)(6436002)(6506007)(53546011)(74316002)(106356001)(105586002)(99286004)(14444005)(7696005)(102836004)(476003)(486006)(9686003)(53936002)(2900100001)(26005)(229853002)(446003)(66066001)(86362001)(11346002)(55016002)(5660300001)(7416002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2203;H:HE1PR0401MB2235.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4LwQ73mr3CoYOly72fe7HPhDtUe29jwJB2qKDp903A3eJZS5WT6MhN5/QwJG2NqAIozZ5V69XZ6fsbGQ98uOL2+G8BEsRpLxxQwQGknKaKxnu2qkcwdsx97/sz3/y08GQ58FTSdR2ZLpflmrT/eT/Xqt6ARYaCtbS/giK1/CUzGeo0AzBY+VNVNCs9uX/l02hXCCyEfyXR7YnjWWB3Xpbv2G5zPlINXCnZ6t7vd9+aKk644Tzv6eSZ+K6Isrm23O2IfwKHW9vL9s+ohoahmfNr3UMW2bx1Y06vZC5uBSrHTBvYKLArkVS+fk6UXNN/RKIm4qS9TgU9MvSav3EIxZMMcRrhR6Fs2Z4bRgQfMGX2I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31dcbe8c-a025-4179-e259-08d64edbdf4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 11:32:36.9078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2203
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>

> -----Original Message-----
> From: Z.q. Hou
> Sent: Tuesday, November 20, 2018 5:28 PM
> To: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> bhelgaas@google.com; robh+dt@kernel.org; mark.rutland@arm.com;
> l.subrahmanya@mobiveil.co.in; shawnguo@kernel.org; Leo Li
> <leoyang.li@nxp.com>; lorenzo.pieralisi@arm.com;
> catalin.marinas@arm.com; will.deacon@arm.com
> Cc: Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian
> <minghuan.lian@nxp.com>; Xiaowei Bao <xiaowei.bao@nxp.com>; Z.q. Hou
> <zhiqiang.hou@nxp.com>
> Subject: [PATCHv2 24/25] arm64: dts: freescale: lx2160a: add pcie DT node=
s
>=20
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>=20
> The LX2160A integrated 6 PCIe Gen4 controllers.
>=20
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - Change the default status of PCIe DT nodes to disabled.
>=20
>  .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 163 ++++++++++++++++++
>  1 file changed, 163 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index a79f5c1ea56d..3a098c462a25 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -762,5 +762,168 @@
>  				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
>  			dma-coherent;
>  		};
> +
> +		pcie@3400000 {
> +			compatible =3D "fsl,lx2160a-pcie";
> +			reg =3D <0x00 0x03400000 0x0 0x00100000   /*
> controller registers */
> +			       0x80 0x00000000 0x0 0x00001000>; /*
> configuration space */
> +			reg-names =3D "csr_axi_slave", "config_axi_slave";
> +			interrupts =3D <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /*
> AER interrupt */
> +				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /*
> PME interrupt */
> +				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /*
> controller interrupt */
> +			interrupt-names =3D "aer", "pme", "intr";
> +			#address-cells =3D <3>;
> +			#size-cells =3D <2>;
> +			device_type =3D "pci";
> +			dma-coherent;
> +			apio-wins =3D <8>;
> +			ppio-wins =3D <8>;
> +			bus-range =3D <0x0 0xff>;
> +			ranges =3D <0x82000000 0x0 0x40000000 0x80
> 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +			msi-parent =3D <&its>;
> +			#interrupt-cells =3D <1>;
> +			interrupt-map-mask =3D <0 0 0 7>;
> +			interrupt-map =3D <0000 0 0 1 &gic 0 0 GIC_SPI 109
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 2 &gic 0 0 GIC_SPI 110
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 3 &gic 0 0 GIC_SPI 111
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 4 &gic 0 0 GIC_SPI 112
> IRQ_TYPE_LEVEL_HIGH>;
> +			status =3D "disabled";
> +		};
> +
> +		pcie@3500000 {
> +			compatible =3D "fsl,lx2160a-pcie";
> +			reg =3D <0x00 0x03500000 0x0 0x00100000   /*
> controller registers */
> +			       0x88 0x00000000 0x0 0x00001000>; /*
> configuration space */
> +			reg-names =3D "csr_axi_slave", "config_axi_slave";
> +			interrupts =3D <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>, /*
> AER interrupt */
> +				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>, /*
> PME interrupt */
> +				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>; /*
> controller interrupt */
> +			interrupt-names =3D "aer", "pme", "intr";
> +			#address-cells =3D <3>;
> +			#size-cells =3D <2>;
> +			device_type =3D "pci";
> +			dma-coherent;
> +			apio-wins =3D <8>;
> +			ppio-wins =3D <8>;
> +			bus-range =3D <0x0 0xff>;
> +			ranges =3D <0x82000000 0x0 0x40000000 0x88
> 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +			msi-parent =3D <&its>;
> +			#interrupt-cells =3D <1>;
> +			interrupt-map-mask =3D <0 0 0 7>;
> +			interrupt-map =3D <0000 0 0 1 &gic 0 0 GIC_SPI 114
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 2 &gic 0 0 GIC_SPI 115
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 3 &gic 0 0 GIC_SPI 116
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 4 &gic 0 0 GIC_SPI 117
> IRQ_TYPE_LEVEL_HIGH>;
> +			status =3D "disabled";
> +		};
> +
> +		pcie@3600000 {
> +			compatible =3D "fsl,lx2160a-pcie";
> +			reg =3D <0x00 0x03600000 0x0 0x00100000   /*
> controller registers */
> +			       0x90 0x00000000 0x0 0x00001000>; /*
> configuration space */
> +			reg-names =3D "csr_axi_slave", "config_axi_slave";
> +			interrupts =3D <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, /*
> AER interrupt */
> +				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, /*
> PME interrupt */
> +				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>; /*
> controller interrupt */
> +			interrupt-names =3D "aer", "pme", "intr";
> +			#address-cells =3D <3>;
> +			#size-cells =3D <2>;
> +			device_type =3D "pci";
> +			dma-coherent;
> +			apio-wins =3D <8>;
> +			ppio-wins =3D <8>;
> +			bus-range =3D <0x0 0xff>;
> +			ranges =3D <0x82000000 0x0 0x40000000 0x90
> 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +			msi-parent =3D <&its>;
> +			#interrupt-cells =3D <1>;
> +			interrupt-map-mask =3D <0 0 0 7>;
> +			interrupt-map =3D <0000 0 0 1 &gic 0 0 GIC_SPI 119
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 2 &gic 0 0 GIC_SPI 120
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 3 &gic 0 0 GIC_SPI 121
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 4 &gic 0 0 GIC_SPI 122
> IRQ_TYPE_LEVEL_HIGH>;
> +			status =3D "disabled";
> +		};
> +
> +		pcie@3700000 {
> +			compatible =3D "fsl,lx2160a-pcie";
> +			reg =3D <0x00 0x03700000 0x0 0x00100000   /*
> controller registers */
> +			       0x98 0x00000000 0x0 0x00001000>; /*
> configuration space */
> +			reg-names =3D "csr_axi_slave", "config_axi_slave";
> +			interrupts =3D <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, /*
> AER interrupt */
> +				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, /*
> PME interrupt */
> +				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>; /*
> controller interrupt */
> +			interrupt-names =3D "aer", "pme", "intr";
> +			#address-cells =3D <3>;
> +			#size-cells =3D <2>;
> +			device_type =3D "pci";
> +			dma-coherent;
> +			apio-wins =3D <8>;
> +			ppio-wins =3D <8>;
> +			bus-range =3D <0x0 0xff>;
> +			ranges =3D <0x82000000 0x0 0x40000000 0x98
> 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +			msi-parent =3D <&its>;
> +			#interrupt-cells =3D <1>;
> +			interrupt-map-mask =3D <0 0 0 7>;
> +			interrupt-map =3D <0000 0 0 1 &gic 0 0 GIC_SPI 124
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 2 &gic 0 0 GIC_SPI 125
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 3 &gic 0 0 GIC_SPI 126
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 4 &gic 0 0 GIC_SPI 127
> IRQ_TYPE_LEVEL_HIGH>;
> +			status =3D "disabled";
> +		};
> +
> +		pcie@3800000 {
> +			compatible =3D "fsl,lx2160a-pcie";
> +			reg =3D <0x00 0x03800000 0x0 0x00100000   /*
> controller registers */
> +			       0xa0 0x00000000 0x0 0x00001000>; /*
> configuration space */
> +			reg-names =3D "csr_axi_slave", "config_axi_slave";
> +			interrupts =3D <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>, /*
> AER interrupt */
> +				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>, /*
> PME interrupt */
> +				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>; /*
> controller interrupt */
> +			interrupt-names =3D "aer", "pme", "intr";
> +			#address-cells =3D <3>;
> +			#size-cells =3D <2>;
> +			device_type =3D "pci";
> +			dma-coherent;
> +			apio-wins =3D <8>;
> +			ppio-wins =3D <8>;
> +			bus-range =3D <0x0 0xff>;
> +			ranges =3D <0x82000000 0x0 0x40000000 0xa0
> 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +			msi-parent =3D <&its>;
> +			#interrupt-cells =3D <1>;
> +			interrupt-map-mask =3D <0 0 0 7>;
> +			interrupt-map =3D <0000 0 0 1 &gic 0 0 GIC_SPI 129
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 2 &gic 0 0 GIC_SPI 130
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 3 &gic 0 0 GIC_SPI 131
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 4 &gic 0 0 GIC_SPI 132
> IRQ_TYPE_LEVEL_HIGH>;
> +			status =3D "disabled";
> +		};
> +
> +		pcie@3900000 {
> +			compatible =3D "fsl,lx2160a-pcie";
> +			reg =3D <0x00 0x03900000 0x0 0x00100000   /*
> controller registers */
> +			       0xa8 0x00000000 0x0 0x00001000>; /*
> configuration space */
> +			reg-names =3D "csr_axi_slave", "config_axi_slave";
> +			interrupts =3D <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>, /*
> AER interrupt */
> +				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>, /*
> PME interrupt */
> +				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>; /*
> controller interrupt */
> +			interrupt-names =3D "aer", "pme", "intr";
> +			#address-cells =3D <3>;
> +			#size-cells =3D <2>;
> +			device_type =3D "pci";
> +			dma-coherent;
> +			apio-wins =3D <8>;
> +			ppio-wins =3D <8>;
> +			bus-range =3D <0x0 0xff>;
> +			ranges =3D <0x82000000 0x0 0x40000000 0xa8
> 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +			msi-parent =3D <&its>;
> +			#interrupt-cells =3D <1>;
> +			interrupt-map-mask =3D <0 0 0 7>;
> +			interrupt-map =3D <0000 0 0 1 &gic 0 0 GIC_SPI 104
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 2 &gic 0 0 GIC_SPI 105
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 3 &gic 0 0 GIC_SPI 106
> IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 4 &gic 0 0 GIC_SPI 107
> IRQ_TYPE_LEVEL_HIGH>;
> +			status =3D "disabled";
> +		};
> +
>  	};
>  };
> --
> 2.17.1

