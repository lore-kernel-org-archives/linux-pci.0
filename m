Return-Path: <SRS0=lIFx=RP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DCAC43381
	for <linux-pci@archiver.kernel.org>; Tue, 12 Mar 2019 09:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5581F214D8
	for <linux-pci@archiver.kernel.org>; Tue, 12 Mar 2019 09:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LFiMaENv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfCLJj0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:39:26 -0400
Received: from mail-eopbgr80072.outbound.protection.outlook.com ([40.107.8.72]:50144
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725882AbfCLJj0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Mar 2019 05:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lb7htEtqi1o9B5lUU67XIGaa5ieZnfaoxXOq5SnWnaE=;
 b=LFiMaENvXxfCCJQBC3Jx9EifMHHgibTZYJAyvPL+WRjUHLI9Au734opbTlWTABI7SkCe+kYMvDPmXdFQiugeUyHHyF4tUYrbQuo9unonPeMJlxBVb3xy4INoLNZWKa85sKp68O7Q/8JkdZIRqGucT51paREoUlJEy2BEelRMJuk=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB4054.eurprd04.prod.outlook.com (52.135.167.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 12 Mar 2019 09:38:42 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1686.021; Tue, 12 Mar 2019
 09:38:42 +0000
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
Subject: [PATCHv4 23/28] dt-bindings: pci: Add NXP Layerscape SoCs PCIe Gen4
 controller
Thread-Topic: [PATCHv4 23/28] dt-bindings: pci: Add NXP Layerscape SoCs PCIe
 Gen4 controller
Thread-Index: AQHU2Ldhf3SuhL3GWEqHqXQEPNGBYA==
Date:   Tue, 12 Mar 2019 09:38:42 +0000
Message-ID: <20190312093929.29533-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::14) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:ad::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4271e34-7a85-43c1-ebf2-08d6a6ce838e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4054;
x-ms-traffictypediagnostic: AM6PR04MB4054:
x-microsoft-antispam-prvs: <AM6PR04MB40545E421C93C622CC9EED3884490@AM6PR04MB4054.eurprd04.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(376002)(136003)(366004)(346002)(39860400002)(396003)(189003)(199004)(110136005)(26005)(54906003)(2501003)(478600001)(66066001)(316002)(8676002)(81156014)(81166006)(71200400001)(7736002)(305945005)(6436002)(6486002)(4326008)(97736004)(1076003)(14454004)(71190400001)(106356001)(6512007)(53936002)(105586002)(8936002)(186003)(68736007)(50226002)(256004)(7416002)(2616005)(476003)(486006)(99286004)(2201001)(36756003)(86362001)(3846002)(6116002)(102836004)(25786009)(386003)(6506007)(2906002)(52116002)(5660300002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4054;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PgbqdZt0ea0amAs6l7ekudwJK6Cn0gcWaBcXDEyKJGiSDYapI2S8UljZ/elvA+9dtExoaXZ0WXmy4ptHMncsfsRIgvz23TO67osYCgmqGBThwtr6YMp1JMPdhB1CqO05FYq7d1C75WyhBRyBxiByWIbf/EC+R/qCrJgbMVnxANWi5auekOIeEtnuskPl3CAKtLj0AYuQ8mM4xJEC41AkTaITHNQJ3okZdWe/dkn9f949twhGS6miO/hIhIS68YBw1k7VyXrGGbSe9dZAs6vm+wgj+Fi3e0geAWq3SSNulDjEmmh4ABodUehE1Qkycoe+zzgffnwEfSS61akf3Uk7XCF3sjHH8N3vUF8n1mchE62+wNr0HZeYLW8YnaFNM2oDHKpG4JcMLbGoFHG1wMFN1NiXKrEuAvsdx9QxB/OEPt4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4271e34-7a85-43c1-ebf2-08d6a6ce838e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 09:38:42.2511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4054
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add PCIe Gen4 controller DT bindings of NXP Layerscape SoCs.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
V4:
 - no change

 .../bindings/pci/layerscape-pci-gen4.txt      | 52 +++++++++++++++++++
 MAINTAINERS                                   |  8 +++
 2 files changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/layerscape-pci-ge=
n4.txt

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci-gen4.txt =
b/Documentation/devicetree/bindings/pci/layerscape-pci-gen4.txt
new file mode 100644
index 000000000000..b40fb5d15d3d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci-gen4.txt
@@ -0,0 +1,52 @@
+NXP Layerscape PCIe Gen4 controller
+
+This PCIe controller is based on the Mobiveil PCIe IP and thus inherits al=
l
+the common properties defined in mobiveil-pcie.txt.
+
+Required properties:
+- compatible: should contain the platform identifier such as:
+  "fsl,lx2160a-pcie"
+- reg: base addresses and lengths of the PCIe controller register blocks.
+  "csr_axi_slave": Bridge config registers
+  "config_axi_slave": PCIe controller registers
+- interrupts: A list of interrupt outputs of the controller. Must contain =
an
+  entry for each entry in the interrupt-names property.
+- interrupt-names: It could include the following entries:
+  "intr": The interrupt that is asserted for controller interrupts
+  "aer": Asserted for aer interrupt when chip support the aer interrupt wi=
th
+	 none MSI/MSI-X/INTx mode,but there is interrupt line for aer.
+  "pme": Asserted for pme interrupt when chip support the pme interrupt wi=
th
+	 none MSI/MSI-X/INTx mode,but there is interrupt line for pme.
+- dma-coherent: Indicates that the hardware IP block can ensure the cohere=
ncy
+  of the data transferred from/to the IP block. This can avoid the softwar=
e
+  cache flush/invalid actions, and improve the performance significantly.
+- msi-parent : See the generic MSI binding described in
+  Documentation/devicetree/bindings/interrupt-controller/msi.txt.
+
+Example:
+
+	pcie@3400000 {
+		compatible =3D "fsl,lx2160a-pcie";
+		reg =3D <0x00 0x03400000 0x0 0x00100000   /* controller registers */
+		       0x80 0x00000000 0x0 0x00001000>; /* configuration space */
+		reg-names =3D "csr_axi_slave", "config_axi_slave";
+		interrupts =3D <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
+			     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
+			     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+		interrupt-names =3D "aer", "pme", "intr";
+		#address-cells =3D <3>;
+		#size-cells =3D <2>;
+		device_type =3D "pci";
+		apio-wins =3D <8>;
+		ppio-wins =3D <8>;
+		dma-coherent;
+		bus-range =3D <0x0 0xff>;
+		msi-parent =3D <&its>;
+		ranges =3D <0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>;
+		#interrupt-cells =3D <1>;
+		interrupt-map-mask =3D <0 0 0 7>;
+		interrupt-map =3D <0000 0 0 1 &gic 0 0 GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+				<0000 0 0 2 &gic 0 0 GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+				<0000 0 0 3 &gic 0 0 GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+				<0000 0 0 4 &gic 0 0 GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 1013e74b14f2..2d18c7213991 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11835,6 +11835,14 @@ L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
 F:	drivers/pci/controller/dwc/*layerscape*
=20
+PCI DRIVER FOR NXP LAYERSCAPE GEN4 CONTROLLER
+M:	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
+L:	linux-pci@vger.kernel.org
+L:	linux-arm-kernel@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/layerscape-pci-gen4.txt
+F:	drivers/pci/controller/mobibeil/pci-layerscape-gen4.c
+
 PCI DRIVER FOR GENERIC OF HOSTS
 M:	Will Deacon <will.deacon@arm.com>
 L:	linux-pci@vger.kernel.org
--=20
2.17.1

