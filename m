Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6F8C32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F06520869
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a4l3Teh+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F06520869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388553AbeKFWqh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:46:37 -0500
Received: from mail-he1eur01on0055.outbound.protection.outlook.com ([104.47.0.55]:17984
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388180AbeKFWqg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Nov 2018 17:46:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qP597ofFwARdfQvL84KaevQpoVSDnVSMVolceCG1SCk=;
 b=a4l3Teh+81ykvX9BXtB776NQ8GMhyztKhi2mprEcYVw9isu9Bo1DQ+PBIyQaEH5VUPniU8fFSgkmN6hyhRgQlzBuUC+ncRY89QHrzUcM8yYF+n4zWi1Od2+k9WkEZqeg3MAm3m+Tb7ld6PKTgbtw3zii1VzwOZEAeuxNbqdYg9c=
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com (10.162.155.27) by
 DB5PR04MB1414.eurprd04.prod.outlook.com (10.162.221.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Tue, 6 Nov 2018 13:21:19 +0000
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb]) by DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb%2]) with mapi id 15.20.1273.035; Tue, 6 Nov 2018
 13:21:19 +0000
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
Subject: [PATCH 21/23] dt-bindings: pci: Add NXP LX SoCs PCIe controller
Thread-Topic: [PATCH 21/23] dt-bindings: pci: Add NXP LX SoCs PCIe controller
Thread-Index: AQHUddOaH+hnWiOCjEOD1szvFZnE8w==
Date:   Tue, 6 Nov 2018 13:21:19 +0000
Message-ID: <20181106131807.29951-22-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;DB5PR04MB1414;6:6rU3Zv7RkXHN30u3w7re3eSTCE5TAFSxdNzw8wUcSj6FWo/xW3LPMXlUDeZO3qUc2KXET7SMRjyCV7qVLxmdEhWgSayVIGhCMHDRLAr6USxChXM7oAMJEJRGdqo93EHHs5+fAv+pLDWvUMnyf5kwm3bVFsflC+nHUpMv0GFnSoEpm5ENd4ojeVUHM1xQzZjY1TeWkveQzstVEzo7eoAcP+NeasxGQ0tdCmKP3pM9Vki8NesemPmAesNnvD2F6Axj/XOcV9NkQTm7pPwCSxX1j8lRoCJIm50nNTa/MAVEG3LY4y8hJy307bkBde51RS71ItLONpptTcBa05ZGKaKUyX30GZlIK3wreb00/8Tt2Wq4CxUndXBXy1kga2Xy0mGXakMNkT9P8vp5YPiQx/qLTy0TkWN3uGl8w7NlQEZvJJRgfLpX//b9Bf0H7+jdnOxXTHSwGpUDU4fTsiS/a+nobQ==;5:lE+GVPKhOZGuEnYO1CyV1MuZqR3jNIN/cnv8SD5+iqT61xVuF4TB94QmYKsX1otfdghuVcOo+oMOqyktRUcQ/cC61feV/gGFZuwldSsxITijNC3FNKEO7qQex644qbVM4U59G/f3S6F93baRmbzaJsG6QDUm1xFfi2sxP/m4QIQ=;7:C3JJh6AJ5tP9NJyb29Cpgq1q/vry05S63QpMVgAj4q8voVrHcNz7aETE9NT6bwik0rz0KPv815fcH28bVLXDh3/5ShvejO47D+12pNYvpT0S+8ECqTxit3tFVt1fvTxQZAtdiUs7VYJDtdISTZni/w==
x-ms-office365-filtering-correlation-id: 9bd9b119-0f31-466e-29ea-08d643eabcc5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1414;
x-ms-traffictypediagnostic: DB5PR04MB1414:
x-microsoft-antispam-prvs: <DB5PR04MB141426B977B499C448C002AD84CB0@DB5PR04MB1414.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(9452136761055)(185117386973197)(180628864354917);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB5PR04MB1414;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1414;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(97736004)(66066001)(8936002)(81156014)(81166006)(7416002)(8676002)(5660300001)(71200400001)(71190400001)(478600001)(6486002)(6116002)(2900100001)(1076002)(53936002)(6436002)(6512007)(305945005)(4326008)(25786009)(7736002)(105586002)(106356001)(68736007)(2906002)(3846002)(256004)(26005)(486006)(2501003)(14454004)(99286004)(52116002)(76176011)(36756003)(110136005)(386003)(6506007)(102836004)(54906003)(86362001)(186003)(446003)(11346002)(316002)(2616005)(476003)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1414;H:DB5PR04MB1221.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: huBlCRlRd3LVbAmFUTnZSDmM6weS34cb6TEbTn4aShacDveGqP/e9eqTTgREBZDP267rA/FFNhzQ55wAiqNnrj8/3xH0Y9N0QpG23A+dA1yyXGxFqWrBKbOPJpWk7y01t5r/eFr40VpVbQcXp0t8eFuFR8+D+uIbEDFqMInH3YGQKU1dRQihBKtAgl2WTfsuAmB3khDHGTciccflbi4HeLuSkHqEZXRpALW53XRsVr5RcvtW6X50IEi2AecvKWq1sZxgwj0klbEE01z+OcVuEHiyKQDWV2++PA6DZ8/g1+wuixMhrbBh6xDkHDOGZgemd42/6eyjGONr2pTbhwbwYHFXVFqUDpz63dSxGYmIFbM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd9b119-0f31-466e-29ea-08d643eabcc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 13:21:19.2013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1414
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add PCIe controller DT bindings of NXP LX series SoCs.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 .../devicetree/bindings/pci/lx-pci.txt        | 52 +++++++++++++++++++
 MAINTAINERS                                   |  8 +++
 2 files changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/lx-pci.txt

diff --git a/Documentation/devicetree/bindings/pci/lx-pci.txt b/Documentati=
on/devicetree/bindings/pci/lx-pci.txt
new file mode 100644
index 000000000000..dc602fef93b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/lx-pci.txt
@@ -0,0 +1,52 @@
+NXP LX PCIe controller
+
+This PCIe controller is based on the Mobiveil PCIe IP and thus inherits al=
l
+the common properties defined in mobiveil-pcie.txt.
+
+Required properties:
+- compatible: should contain the platform identifier such as:
+  "fsl,lx2160a-pcie"
+- reg: base addresses and lengths of the PCIe controller register blocks.
+  "config_axi_slave": PCIe controller registers
+  "csr_axi_slave": Bridge config registers
+- interrupts: A list of interrupt outputs of the controller. Must contain =
an
+  entry for each entry in the interrupt-names property.
+- interrupt-names: It could include the following entries:
+  "intr": The interrupt that is asserted for controller interrupts
+  "aer": Asserted for aer interrupt when chip support the aer interrupt wi=
th
+		 none MSI/MSI-X/INTx mode,but there is interrupt line for aer.
+  "pme": Asserted for pme interrupt when chip support the pme interrupt wi=
th
+		 none MSI/MSI-X/INTx mode,but there is interrupt line for pme.
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
+		interrupt-map =3D <0000 0 0 1 &gic GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+				<0000 0 0 2 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+				<0000 0 0 3 &gic GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+				<0000 0 0 4 &gic GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 0c57ccff3188..7da555c8e2f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11252,6 +11252,14 @@ L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
 F:	drivers/pci/controller/dwc/*layerscape*
=20
+PCI DRIVER FOR NXP LX
+M:	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
+L:	linux-pci@vger.kernel.org
+L:	linux-arm-kernel@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/lx-pci.txt
+F:	drivers/pci/controller/mobibeil/pci-lx.c
+
 PCI DRIVER FOR GENERIC OF HOSTS
 M:	Will Deacon <will.deacon@arm.com>
 L:	linux-pci@vger.kernel.org
--=20
2.17.1

