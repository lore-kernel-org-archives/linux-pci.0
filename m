Return-Path: <SRS0=XjPq=NT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E199ECDE4B
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 21:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BC420840
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 21:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PU07YfsJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22BC420840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbeKIHGq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:06:46 -0500
Received: from mail-eopbgr60087.outbound.protection.outlook.com ([40.107.6.87]:14496
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725882AbeKIHGp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Nov 2018 02:06:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFb5Ga54tpAxdNapXn4d4PxtEy0JhCXNk8KroqXdbcA=;
 b=PU07YfsJ/s8FDWn3FMr9Mv43iCmjqgKwF14RlcDQBB+LZ4l9mwhjMHaMa0mUvP3WfSbcyRxYqa7EO8W5UrK5YHnE9cWyFljtl3OZZw/w3S07SLbzJDAYUyguvn47LI1lzFFzS6DhAKgKhJuNJoXprXlgVXf9gVRQKRPiNRYZJNk=
Received: from AM6PR04MB5863.eurprd04.prod.outlook.com (20.179.3.87) by
 AM6PR04MB4071.eurprd04.prod.outlook.com (52.135.167.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.25; Thu, 8 Nov 2018 21:29:04 +0000
Received: from AM6PR04MB5863.eurprd04.prod.outlook.com
 ([fe80::8997:7719:b47f:d7dd]) by AM6PR04MB5863.eurprd04.prod.outlook.com
 ([fe80::8997:7719:b47f:d7dd%2]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 21:29:04 +0000
From:   Leo Li <leoyang.li@nxp.com>
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
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [PATCH 21/23] dt-bindings: pci: Add NXP LX SoCs PCIe controller
Thread-Topic: [PATCH 21/23] dt-bindings: pci: Add NXP LX SoCs PCIe controller
Thread-Index: AQHUddOb6NF1nSu2a02ug+wCobpaOKVGZgTg
Date:   Thu, 8 Nov 2018 21:29:04 +0000
Message-ID: <AM6PR04MB58639AF03E732FCF491113728FC50@AM6PR04MB5863.eurprd04.prod.outlook.com>
References: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
 <20181106131807.29951-22-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181106131807.29951-22-Zhiqiang.Hou@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4071;6:fhOGIdFqTXncxuTUdbvsxkmhoez+O5lUiwGeEkldEXr4UVq/xB5kkqa4giKqit0wqlKxYjeFqzsJtizLyIvx4l40rCN3C1UcQsDFOam7o+D8hKEo20MxI+YNRmeBpI1t+rA28mmlMVzs06g05vwSo/vUX7a+niQ9Bx+dK+yt5SeIrHJpyl0GQ1OPD2DXtipJSqrH7a5X36JAaTOzOYZLE5/Z9IKdu9FIl4NxoohfViieI5yba/rJf6Tk3wZyFrBLjmFV+gSo7YThwWtXWzBkyUs6waBkzlQ3bIamEwDZgexUB0GHDLOTXPad/Exk5F6Tl821iBp/tgXlaa76Pw6NZE4hefilGobEU1F04ZyWKC9yi960+cuEYlpwGi9tvZZMg2k3qOPskQdcfiJD2WHjlh+6aNsq8QkhvjeOfGcPXyZsD1i1CIGrBhY1qwFUPtU0xvBdk9z+ggE3fOWbtioMhQ==;5:G2avCJEkjsEyMwdaIE9In0JzBUGOI0PQo39BKhVnLyX3pP777V7dJm1115YNKL/ByBGHkGMqTSfRnltKAeMNANOJU64J9WSxm27b8ATYAu7RjTGxMv8v0lMHxx4zW5jhYfUN9Xjo35HILSPdtULI5fBlvSgbUD9lq1zyaloEZL4=;7:gNql69Qi30GLZLTH7o5wKSxpgKPsa8bU/BViojY1a9TlUhSNQTTo+Q0vnx7rBw5JuxNFSsBVsHCxBgNkFoxGy746t6noV0Hpq+A5JfJF5i6nlwnmfa4LwF9nd9t2XDxuIhkRHyMJTeSX6iz6m7m2gg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 94a9d7a4-16c0-401f-b4b7-08d645c13589
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4071;
x-ms-traffictypediagnostic: AM6PR04MB4071:
x-microsoft-antispam-prvs: <AM6PR04MB4071DA933AB0762DDF8930A98FC50@AM6PR04MB4071.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335)(211936372134217)(180628864354917)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4071;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4071;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(376002)(346002)(136003)(396003)(366004)(39860400002)(13464003)(189003)(199004)(55016002)(476003)(9686003)(99286004)(186003)(2906002)(71190400001)(71200400001)(53936002)(66066001)(6246003)(6436002)(11346002)(446003)(86362001)(33656002)(3846002)(6116002)(486006)(478600001)(102836004)(4326008)(2201001)(26005)(25786009)(6506007)(14454004)(7696005)(7416002)(76176011)(229853002)(256004)(68736007)(53546011)(5660300001)(105586002)(7736002)(2900100001)(106356001)(74316002)(81156014)(54906003)(305945005)(8676002)(2501003)(110136005)(81166006)(8936002)(97736004)(316002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4071;H:AM6PR04MB5863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pb8EKmiZePiKD0jHOPkeGLbteFNuslA11b3xHMCmTRxgn3kU3e8brupVcj9ipjN/9MK2TUTN2VwDiJMJEdPoY5KQqEh617ZJbYr1nB9j/HS3YpdmdHW6kAzDKpzCUFRnLcLHo+92WazmdyUL18o4HZCK7IZDjALVxAjErTq28oe/GATre0JO6BkQOfMjxbeqyVmyuVQOfYI7uXhBN+dMOHIVHIzFora4hTBS4TOaTK+/ld/T+vhyECbcV9AgvKdfTIG4in96FqsIm3Si3NnQWV8ZSdI0cyDVgjmqa8Z+5UKLyL5ElGjnoqDAsJ39J7X5Ql+RCdLYaN6IkaKDn+hkAurFjowkdLmYKwvCCRqesmE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a9d7a4-16c0-401f-b4b7-08d645c13589
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 21:29:04.7134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4071
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Z.q. Hou
> Sent: Tuesday, November 6, 2018 7:21 AM
> To: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> bhelgaas@google.com; robh+dt@kernel.org; mark.rutland@arm.com;
> l.subrahmanya@mobiveil.co.in; shawnguo@kernel.org; Leo Li
> <leoyang.li@nxp.com>; lorenzo.pieralisi@arm.com
> Cc: Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian
> <minghuan.lian@nxp.com>; Xiaowei Bao <xiaowei.bao@nxp.com>; Z.q. Hou
> <zhiqiang.hou@nxp.com>
> Subject: [PATCH 21/23] dt-bindings: pci: Add NXP LX SoCs PCIe controller
>=20
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>=20
> Add PCIe controller DT bindings of NXP LX series SoCs.

I'm not sure if this is a good idea to name this controller LX PCIe control=
ler.  Right now, it could be true that it is only used on LX series SoCs.  =
But I'm not sure if the LS series will not use this controller or LX series=
 will only use this controller in the future.

Since the LX series is still using the layerscape branding, so probably we =
should keep using the layerscape-pci.txt and define the PCIe Gen4 variant?

Same comment for other places using the LX naming in this driver.

>=20
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  .../devicetree/bindings/pci/lx-pci.txt        | 52 +++++++++++++++++++
>  MAINTAINERS                                   |  8 +++
>  2 files changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/lx-pci.txt
>=20
> diff --git a/Documentation/devicetree/bindings/pci/lx-pci.txt
> b/Documentation/devicetree/bindings/pci/lx-pci.txt
> new file mode 100644
> index 000000000000..dc602fef93b0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/lx-pci.txt
> @@ -0,0 +1,52 @@
> +NXP LX PCIe controller
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
> +		 none MSI/MSI-X/INTx mode,but there is interrupt line for
> aer.
> +  "pme": Asserted for pme interrupt when chip support the pme interrupt
> with
> +		 none MSI/MSI-X/INTx mode,but there is interrupt line for
> pme.
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
> +		interrupt-map =3D <0000 0 0 1 &gic GIC_SPI 109
> IRQ_TYPE_LEVEL_HIGH>,
> +				<0000 0 0 2 &gic GIC_SPI 110
> IRQ_TYPE_LEVEL_HIGH>,
> +				<0000 0 0 3 &gic GIC_SPI 111
> IRQ_TYPE_LEVEL_HIGH>,
> +				<0000 0 0 4 &gic GIC_SPI 112
> IRQ_TYPE_LEVEL_HIGH>;
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0c57ccff3188..7da555c8e2f5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11252,6 +11252,14 @@ L:	linux-arm-kernel@lists.infradead.org
>  S:	Maintained
>  F:	drivers/pci/controller/dwc/*layerscape*
>=20
> +PCI DRIVER FOR NXP LX
> +M:	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> +L:	linux-pci@vger.kernel.org
> +L:	linux-arm-kernel@lists.infradead.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/pci/lx-pci.txt
> +F:	drivers/pci/controller/mobibeil/pci-lx.c
> +
>  PCI DRIVER FOR GENERIC OF HOSTS
>  M:	Will Deacon <will.deacon@arm.com>
>  L:	linux-pci@vger.kernel.org
> --
> 2.17.1

