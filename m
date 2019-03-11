Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E7AC43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006672086A
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cj0g/jvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfCKJdM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:33:12 -0400
Received: from mail-eopbgr70052.outbound.protection.outlook.com ([40.107.7.52]:11219
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727142AbfCKJdL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 05:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiRBbfaVqsMtqMMt0rjSLQ2wvRtVXSvzn2ROeF3OF4o=;
 b=cj0g/jvtVcwpL0rhzFS/Gy3VmmNG7Zw6ePreIg693z8L4GprC3dwZqMGSZDfG4YlRYjmySclECtZT648mLuq8Kv/6Y96fm2jRt7GinNSX/hFsRPIMK5EJ0DK/5gVTvcHLpAO9W/RSzqJsPjYnIRn6eKYGecS+yRgBXrq2d0OvxY=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB6150.eurprd04.prod.outlook.com (20.179.6.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 09:33:06 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 09:33:06 +0000
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
Thread-Index: AQHU1+1u2iPsWkLxw02FlhClA/G34A==
Date:   Mon, 11 Mar 2019 09:33:05 +0000
Message-ID: <20190311093130.7209-24-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: a549a305-a584-4795-aeec-08d6a6049016
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6150;
x-ms-traffictypediagnostic: AM6PR04MB6150:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB6150;23:CTLr0tQlzIXWEc2SKFypLhggX8qj1FtJwMXvl+L?=
 =?iso-8859-1?Q?D5h9qQ7djzkHNK2QB4iN1bxzO9sZGyiR4lIbd1GVnMWtYqe8HkS9jwBjR1?=
 =?iso-8859-1?Q?nlyvNFTk7X8pORBRS/Ky4I5py/LwRHhT4xD9iZQu43B6bBObe5f1LPlRrE?=
 =?iso-8859-1?Q?8RJYuge+j1mPi8heXP4YG7UYBIzB1bLXmb4ocanyq0nrWIKy0eRW7ijrjG?=
 =?iso-8859-1?Q?RH066Y8LCwS9fZDiN9NRB2vL2ZjtCA1suLsb8CVPpSHzM0E9C3LGxY25yx?=
 =?iso-8859-1?Q?csN83xS/DSNQXfVxFZdbdFMufBs/IFVE/Mlit9V+Wa2pf+t1fb0Tup/UXY?=
 =?iso-8859-1?Q?fGEBQiH0OWvsrmpKbfFnJdg6NWkkg+5hfIdabaZa63LeFnkOVag5NJkDNl?=
 =?iso-8859-1?Q?OATbZgXFOYvOJ/URyKgD1wPMZv14KM4mSmCpXyFztWIfE3n2heuS3x+OYA?=
 =?iso-8859-1?Q?sgTq3+dHfNS4iHgh6FytZTRjoDD3rTKcqwoOCQUrrklTdK8g7kGJI+NL6u?=
 =?iso-8859-1?Q?dzJtjzMKoVBkAFpTNqMwFYqkazdmMlezkOuCn51yR3fC7Pz7G4Do8Zt82q?=
 =?iso-8859-1?Q?JRNgoMFRc1jvVuKqpdH6C9Y9G6/0wIxdKNKCHYbiQUk5Qu9Zge+HEHDrIZ?=
 =?iso-8859-1?Q?w7jcivFC84fSmiZqirjUxMBRZckW5YVucIJx9NIc0f/xv7AsdJEdgPx/fF?=
 =?iso-8859-1?Q?/eRFjRxocqlJSdJ7AUTZMYLcAc5zQKIfbca3Hfo8uD2he+u7zU/F1CmLGX?=
 =?iso-8859-1?Q?02T3JpPEmhutG9FWUatDmAVlBTvPa39GqOYuKP280XIxJ04o5ybdo+5m3i?=
 =?iso-8859-1?Q?itv7tUm6s1upY/+NApnJhAGL0iZlqGyAGPajmvZGuQE9OmyG3RUwDZPSAN?=
 =?iso-8859-1?Q?WnhFXgHQKaNHYMduQkK02ZKRU6YgajqKVhbO5pchkJcHw5XKRGc16TxXqI?=
 =?iso-8859-1?Q?uOsR2D/4MvaoZQ5Tf99+Kt7pPgpzG2XNOTm6ci28AIo69Da9RDwdnuJg01?=
 =?iso-8859-1?Q?FnNG7TLcToU/n2m9BFsxZ+tvrJpRmgJMwUORPd4qs782wUsnvpoVKY5/UZ?=
 =?iso-8859-1?Q?VmkPsOI1t+mrBi+N8cyRq2Rx9KbumTOPsyAPDeOLZ0o3EleTSMF1N1tW0H?=
 =?iso-8859-1?Q?4KZ1yeZwk+P2hRJPi2H7UZX1enkZb/BUYu3uGija18NiZD4f2fQF62Zmxg?=
 =?iso-8859-1?Q?H4tOb7KPOnm/jSzf3RNDkgj29aNwpmjHHSFDX37DZ+bS2Cxn0Uz3HGN9sN?=
 =?iso-8859-1?Q?SK8Z/ei6+WGee7o83u/QqTuzGhBxmeQuLI4vbQP9pM0S41f14XUFoL+pw9?=
 =?iso-8859-1?Q?mGV5jTcoK4XWtXIsaG1q5hp1F8I5FrzXwdriKrRR3aObI+OwnNwcDMHteh?=
 =?iso-8859-1?Q?bFo6drFs=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB615018C2C206D63AC857C2D084480@AM6PR04MB6150.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(136003)(376002)(39860400002)(346002)(396003)(366004)(199004)(189003)(86362001)(54906003)(110136005)(6506007)(386003)(52116002)(99286004)(102836004)(316002)(4326008)(2201001)(50226002)(2501003)(97736004)(2906002)(66066001)(186003)(26005)(5660300002)(11346002)(76176011)(446003)(6486002)(36756003)(6436002)(25786009)(81166006)(81156014)(8676002)(478600001)(476003)(1076003)(7416002)(105586002)(305945005)(2616005)(71190400001)(71200400001)(3846002)(68736007)(6512007)(6116002)(8936002)(53936002)(7736002)(486006)(14454004)(256004)(106356001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6150;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XjUxmaFd/nk/lp+AvrhVrZ4S8vtuKKMdAa6uL2MeLEXvVkHbMDpdjv1Ufy88JMkdJfiEa0rgpHM2HeH/dyam9Iro1rnQVnHfbCKWSN7P7QdjY3uRLW+w3C9mVexJVgtd4DQGuroiSGVP2vN1LWH8TniQgX7bRssrgZ/EXaMRtplEvhCNbnp52e32/HR5J0VCC6ZPaJqGltwJyFT10o+MfEJypGALhW0vkWL4O13JKR0I6DFok8CK37oCse12q3cKaBl9pKf17GoHbjGfe7hT4l2Zesk5i7CZn7XlpaWrFiQHN6T3ucdPaLGN7cjWODhcCQLA1+yqvF8V2BCxNidjnpAmgA1fbAVl+sFPezndwHnVKciO11q16rsTKg2sU8Jenri5pRqiIORoL1k1Y95sTyn8JMjC8T0vpNW9XAijb/g=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a549a305-a584-4795-aeec-08d6a6049016
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 09:33:05.9238
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

Add PCIe Gen4 controller DT bindings of NXP Layerscape SoCs.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
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

