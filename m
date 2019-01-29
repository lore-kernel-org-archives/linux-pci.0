Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F063EC282C7
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DD82177E
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sgEjzDtJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbfA2IKz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:10:55 -0500
Received: from mail-eopbgr20046.outbound.protection.outlook.com ([40.107.2.46]:13024
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727599AbfA2IKx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 03:10:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i57eLhu1gSG894+3Og8uPuG1ib/zZBt1UPBxJiNBkKY=;
 b=sgEjzDtJXKKLNh57jAy+8Z2CmoA+mwU6qWA8uk/sFAgvnz+nlbnptZN4bMAZk1XxG0jH+uNntjtEZIEXRGFm2DAtOqzIwk+6yy6neRSDEGhtsiQAFJ5AP/VZSc+tZqWSka6ghK5LfdvBm0m/FxfybZ8GmNc1d9/orPus3B6O6MA=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB6117.eurprd04.prod.outlook.com (20.179.7.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Tue, 29 Jan 2019 08:10:49 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:10:49 +0000
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
Subject: [PATCHv3 22/27] dt-bindings: pci: Add NXP Layerscape SoCs PCIe Gen4
 controller
Thread-Topic: [PATCHv3 22/27] dt-bindings: pci: Add NXP Layerscape SoCs PCIe
 Gen4 controller
Thread-Index: AQHUt6okOxbMujwBKEGpZZeZBxLQnQ==
Date:   Tue, 29 Jan 2019 08:10:49 +0000
Message-ID: <20190129080926.36773-23-Zhiqiang.Hou@nxp.com>
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:203:36::20) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:ad::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB6117;6:BCKZPIT6SPvbzFrl8W8R9nqi1fNMQYQ02i71xF/obdC+h0gHRW8u9VG+FSL7lJINml4qkt6PLaJ/6N03Fs2PVcBOw2zhiCU/PE1f/6Era2FVncncDCKp9ZDLyQM8viBStJmAhvv1FVzdu7gK+sPNGIhjULIs3ZQ4MG0jMgjAwhQHfDX9ihRDflmi8KvZPf38dDUOjG5f12Y59rYZYGG+7J68ZrWyxmkauBUvdeCT4dBYGFomdUqAgYkgeIOrgvBmh7sweEgAXY2EjNd1ZRW5lTCqKRjk/coQ87T67Xy5Et+MA9Iu47VZJCyqYwOg1DqIt9YUANXbg3CG6rEoQiAQt/47u6VPhtsrUI5Bn0IrFtoUNsH+UEGe7vk7SYyMPaWUwh61H6bFyu4ctjjPIA3gN58LoFdheveEBMQ6f78SD9GW4s5pVJ0adATehelUG0In7U7qGJxQxl80J3+CgvoAMA==;5:DGJxnOsnLGWbOhVioQBN1ZrusmAgl0dRfaYQHAy9xVR7Zp8yeLRFyLTU24sI5LsyQcLyv5U2CtB1HaHUyfqoZt8ciDmE7LkJ0BEjp/H4721LmfmhM/Qr/bpWlIz9eyGySwimnAluUpIVeNiUTYH2VC1YtHO32bY4JukVL6LInOPWWo9hK6vY/lWF4YSD+pJEpmgkWNqp3j11z8zgNTuIxg==;7:/aNN86MPXyBeaM20/ZRocpzt4ZHldTsGazr9ltUYTPp/dB3bxhpFIqAtaMd5L9gNbrFEexXw3ZC/rxcOnEXORTtF5Jsh1Qm6ZhuQe0BMgFzPqRei+KjTne4owA32KZksFEaGzBETMsZw1xO0H4xnSQ==
x-ms-office365-filtering-correlation-id: 51979c69-a84e-47bd-e487-08d685c14712
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6117;
x-ms-traffictypediagnostic: AM6PR04MB6117:
x-microsoft-antispam-prvs: <AM6PR04MB6117A1B0A14B3FF9952BFFCC84970@AM6PR04MB6117.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(396003)(366004)(346002)(376002)(39860400002)(136003)(199004)(189003)(3846002)(6116002)(486006)(81166006)(81156014)(8676002)(7416002)(106356001)(14454004)(478600001)(386003)(446003)(11346002)(186003)(102836004)(476003)(6506007)(8936002)(50226002)(105586002)(68736007)(71190400001)(2906002)(2616005)(71200400001)(36756003)(2501003)(66066001)(97736004)(26005)(4326008)(25786009)(6436002)(6486002)(53936002)(6512007)(256004)(54906003)(7736002)(14444005)(99286004)(305945005)(76176011)(2201001)(110136005)(1076003)(316002)(86362001)(52116002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6117;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: J19CwNJ3Kl4A+ahzVZTzvy1DIx6/v9ie/5LG2IRmruf3KBPe2I8W3+trscToRlGJn8B3Xs5u6SpOjf++36eDULbeZL+fbpEZdtWxEpMsc4q4DJ8FyhYmXk/Gy6XxIvmiY2mD4wPWxKWQA88Az6o+d79JJZHhdZj1WvjXQBmVma3mfdU/lH0n4xM6/X8aZlvbMd4wnlffGbW9PRGyP773ttl1L4+XsSsLeKveygaywy4+Z1XvikD8VKi5u/m8ejZWh9rG43qjVMXfFeTc2tRZNs1iS9kwFkBgj9Dh8W8A2TkKuDdYX5gRk9pn6Vsedz1g9yjTL6yEWeV8tKIjjPbruW39qLMf8ntpCvXXAOJRHKSzP2UcmClKc+m4ylRTl0tFQmzAKpNP5jze85/EWphpKvGB88DYdYKqfy7a5NdZV/k=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51979c69-a84e-47bd-e487-08d685c14712
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:10:43.1012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6117
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add PCIe Gen4 controller DT bindings of NXP Layerscape SoCs.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V3:
 - Change back to use an new doc for Layerscape PCIe Gen4 DT bindings.
 - Switch the order of "csr_axi_slave" and "config_axi_slave".

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
index 3bca9642b08b..16b9f56fadba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11667,6 +11667,14 @@ L:	linux-arm-kernel@lists.infradead.org
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

