Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86717C4161B
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B293208E4
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rCtqvJKB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B293208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbeKTWA1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 17:00:27 -0500
Received: from mail-eopbgr70074.outbound.protection.outlook.com ([40.107.7.74]:19040
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729108AbeKTWA1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 17:00:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4/nhwaAiHQ4Fc82vpR+IkzqfJHHka0BsbsqoWc23lk=;
 b=rCtqvJKB54vbFluZGG5Dq+WnNdIQmzr8KY8hotOuZDhiPa1jTkRm/loDmSWGRKcutzj23+i15wPfH0qCRIW9E9hEDl7mdIR6uCqfcqJbg+Pg0FfEeupWlFR8WkjCmuQAAK+aUugMHlkm2SpBbCXycztk30auAbQF60rJ9twgYu0=
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com (10.168.32.20) by
 HE1PR0401MB2203.eurprd04.prod.outlook.com (10.166.76.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.23; Tue, 20 Nov 2018 11:31:38 +0000
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2]) by HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2%8]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 11:31:38 +0000
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
Subject: RE: [PATCHv2 22/25] dt-bindings: pci: Add NXP Layerscape SoCs PCIe
 Gen4 controller
Thread-Topic: [PATCHv2 22/25] dt-bindings: pci: Add NXP Layerscape SoCs PCIe
 Gen4 controller
Thread-Index: AQHUgLNPh3i36XmMUUCdDdr0q0lHU6VYh8Xw
Date:   Tue, 20 Nov 2018 11:31:38 +0000
Message-ID: <HE1PR0401MB223529A482909A952F38352CE8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-23-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181120092615.11680-23-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=minghuan.lian@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB2203;6:K2fn4MM4lRGl7zc6XqKe+q/OvuKFuVoX7x55wHYnU7Hy1RH9Q3X5KForeMXKVh5Zj8S8tP2xR9LyT1+DE5xJpDHfQq+rKHne+o7LDKaf/BMmfuG57wpJbvJ14KNy1LOLuOxMSBN3DivxgxJ6X0a4TMg/swV8vOhGDPAhC6TvTL0SGrTHDNjJFMNfep5MG8lAhyzmpft9OBR6oTX+dqpy52pIM74TqXuqn1OxbJJbv+wuH+uLlVdvRZe7TuxnfI+S/luwCW3AXN3qk4zuY7H841uG0VNQQvCNWCfXKE1ClJFAOVXqAii/Y6g2++uSJ21QrukAGN9P0WsaOekfFMSQqKVfzsk+9ad4KJMh6X3iY92kiIuM7YWUFjLzuGwAYMrl8aKIkDX4xeZ5ULettvkiJERrJR3dsbwNMX8TgGI4f4C6WHxoic73TJkKZwNIp3PrqClIRyQP1eUy47Y0k2XAobJ2Yvbk2g+1nzYKJecan+Q=;5:GJwz8mfHdZo0faKYtkMrlNoA0TMD0u6fI9ugtOTukvw4c4owS/hhG3npmcHUXObJpDvx0nBiygy3NanPsV+LK9P9bpwT17qPpE4hPqqYwt0X21vbqrKZc1IyKvCQwyD+m1DOQ6b+UTybdStppM/4p7fEccgVbVwrFwFW4mkwLqM=;7:B41+YB+o5lDyOyXSrsNudSyLaR6VYDJsusuwY70v89u57JY+ZELxd7s1MssQGjX+ZylL4xLi2ful2Wf3P9yALYSofGjZioNpanxAMh1kJFnPFpyGdvglsScFJ3RTmcCToU1mZ8dcuSmxFb9iBC3YuA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5d1551ea-0f44-40d7-a27c-08d64edbbc70
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2203;
x-ms-traffictypediagnostic: HE1PR0401MB2203:
x-microsoft-antispam-prvs: <HE1PR0401MB220334F2D325409B40C8D4D6E8D90@HE1PR0401MB2203.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(10201501046)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:HE1PR0401MB2203;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2203;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(396003)(346002)(376002)(366004)(136003)(39860400002)(189003)(199004)(13464003)(6116002)(54906003)(478600001)(97736004)(33656002)(8676002)(81156014)(81166006)(68736007)(8936002)(186003)(4326008)(110136005)(14454004)(3846002)(71190400001)(2906002)(316002)(71200400001)(25786009)(2501003)(6246003)(256004)(305945005)(76176011)(2201001)(7736002)(6436002)(6506007)(53546011)(74316002)(106356001)(105586002)(99286004)(7696005)(102836004)(476003)(486006)(9686003)(53936002)(2900100001)(26005)(229853002)(446003)(66066001)(86362001)(575784001)(11346002)(55016002)(5660300001)(7416002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2203;H:HE1PR0401MB2235.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fy9YSEJVOVeHbT0mbdA1DKlmsKi9i1Uk/4ahNEqX1QC2I9SFjtpnjNYKRNdBZvRDxk/EGo+CmpNiojB5rcbJNdR5rldGtANYoKihosALnftbm2VU2gG0M++PXIOkO5FTB0dbxvVGyLuQ9l6pfBdm+R+xo01q//kgSUEbf4s4ot9+55stOJv9W9i/RcCwv9agWGA+FlmbhYZRV9qjsKrORjSRPJP5mcP4gs0vz2UKREENQuxBjwRjEF+mTgBu1lrkLQhfkiKNZi1OkmzGAVLrKAaW8/u7Eo4+9OMeiN92M+JA7LeAQ0m67JuXXvVR9cWke9Frh+3Dj/iAZ4ioR7R3PoCz2uwHsc/KH/NU3qUs7mw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1551ea-0f44-40d7-a27c-08d64edbbc70
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 11:31:38.4087
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
> Subject: [PATCHv2 22/25] dt-bindings: pci: Add NXP Layerscape SoCs PCIe
> Gen4 controller
>=20
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>=20
> Add PCIe Gen4 controller DT bindings of NXP Layerscape SoCs.
>=20
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - Change to use the layerscape-pci.txt for PCIe Gen4 controller
>    dt-bindings
>=20
>  .../bindings/pci/layerscape-pci.txt           | 57 +++++++++++++++++++
>  MAINTAINERS                                   |  8 +++
>  2 files changed, 65 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> index 66df1e81e0b8..3ef8836b6e97 100644
> --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> @@ -1,4 +1,6 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  Freescale Layerscape PCIe controller
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>  This PCIe host controller is based on the Synopsys DesignWare PCIe IP  a=
nd
> thus inherits all the common properties defined in designware-pcie.txt.
> @@ -58,3 +60,58 @@ Example:
>  				<0000 0 0 3 &gic GIC_SPI 190
> IRQ_TYPE_LEVEL_HIGH>,
>  				<0000 0 0 4 &gic GIC_SPI 192
> IRQ_TYPE_LEVEL_HIGH>;
>  	};
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +NXP Layerscape PCIe Gen4 controller
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This PCIe controller is based on the Mobiveil PCIe IP and thus inherits
> +all the common properties defined in mobiveil-pcie.txt.
> +
> +Required properties:
> +- compatible: should contain the platform identifier such as:
> +  "fsl,lx2160a-pcie"
> +- reg: base addresses and lengths of the PCIe controller register blocks=
.
> +  "config_axi_slave": PCIe controller registers
> +  "csr_axi_slave": Bridge config registers
> +- interrupts: A list of interrupt outputs of the controller. Must
> +contain an
> +  entry for each entry in the interrupt-names property.
> +- interrupt-names: It could include the following entries:
> +  "intr": The interrupt that is asserted for controller interrupts
> +  "aer": Asserted for aer interrupt when chip support the aer interrupt =
with
> +	 none MSI/MSI-X/INTx mode,but there is interrupt line for aer.
> +  "pme": Asserted for pme interrupt when chip support the pme interrupt
> with
> +	 none MSI/MSI-X/INTx mode,but there is interrupt line for pme.
> +- dma-coherent: Indicates that the hardware IP block can ensure the
> +coherency
> +  of the data transferred from/to the IP block. This can avoid the
> +software
> +  cache flush/invalid actions, and improve the performance significantly=
.
> +- msi-parent : See the generic MSI binding described in
> +  Documentation/devicetree/bindings/interrupt-controller/msi.txt.
> +
> +Example:
> +
> +	pcie@3400000 {
> +		compatible =3D "fsl,lx2160a-pcie";
> +		reg =3D <0x00 0x03400000 0x0 0x00100000   /* controller
> registers */
> +		       0x80 0x00000000 0x0 0x00001000>; /* configuration
> space */
> +		reg-names =3D "csr_axi_slave", "config_axi_slave";
> +		interrupts =3D <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* AER
> interrupt */
> +			     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* PME
> interrupt */
> +			     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /*
> controller interrupt */
> +		interrupt-names =3D "aer", "pme", "intr";
> +		#address-cells =3D <3>;
> +		#size-cells =3D <2>;
> +		device_type =3D "pci";
> +		apio-wins =3D <8>;
> +		ppio-wins =3D <8>;
> +		dma-coherent;
> +		bus-range =3D <0x0 0xff>;
> +		msi-parent =3D <&its>;
> +		ranges =3D <0x82000000 0x0 0x40000000 0x80 0x40000000 0x0
> 0x40000000>;
> +		#interrupt-cells =3D <1>;
> +		interrupt-map-mask =3D <0 0 0 7>;
> +		interrupt-map =3D <0000 0 0 1 &gic 0 0 GIC_SPI 109
> IRQ_TYPE_LEVEL_HIGH>,
> +				<0000 0 0 2 &gic 0 0 GIC_SPI 110
> IRQ_TYPE_LEVEL_HIGH>,
> +				<0000 0 0 3 &gic 0 0 GIC_SPI 111
> IRQ_TYPE_LEVEL_HIGH>,
> +				<0000 0 0 4 &gic 0 0 GIC_SPI 112
> IRQ_TYPE_LEVEL_HIGH>;
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 084d225583e0..b59763e23392 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11405,6 +11405,14 @@ L:	linux-arm-kernel@lists.infradead.org
>  S:	Maintained
>  F:	drivers/pci/controller/dwc/*layerscape*
>=20
> +PCI DRIVER FOR NXP LAYERSCAPE GEN4 CONTROLLER
> +M:	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> +L:	linux-pci@vger.kernel.org
> +L:	linux-arm-kernel@lists.infradead.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/pci/layerscape-pci.txt
> +F:	drivers/pci/controller/mobibeil/pci-layerscape-gen4.c
> +
>  PCI DRIVER FOR GENERIC OF HOSTS
>  M:	Will Deacon <will.deacon@arm.com>
>  L:	linux-pci@vger.kernel.org
> --
> 2.17.1

