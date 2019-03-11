Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC86C43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF16020879
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dzhZM+vs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfCKJdb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:33:31 -0400
Received: from mail-eopbgr70059.outbound.protection.outlook.com ([40.107.7.59]:4503
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727141AbfCKJd3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 05:33:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCujfAVAR0+e0LhiMltBI07/ARcHfZEoOLM2FMrtt3I=;
 b=dzhZM+vsJjE3OSJsMLuDaa7U+wbSdmM9WEpF3EGD3GTL09do6kVNidt20Djc0hEeEWl+TMsiBYtEhP9nlaTcz584qqZxOhwysPvnytgLdH0Z+yeUwAxchFqzf2ALltQJNmMrEWK+QTkOlGBoTDNkknK6UB2ZGla1U/isTfjuS/Y=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB6150.eurprd04.prod.outlook.com (20.179.6.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 09:33:23 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 09:33:23 +0000
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
Subject: [PATCHv4 25/28] PCI: mobiveil: ls_pcie_g4: add Workaround for
 A-011577
Thread-Topic: [PATCHv4 25/28] PCI: mobiveil: ls_pcie_g4: add Workaround for
 A-011577
Thread-Index: AQHU1+14+TCeS3tabUCUvLQeJSezBA==
Date:   Mon, 11 Mar 2019 09:33:23 +0000
Message-ID: <20190311093130.7209-26-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: d4743724-3a80-421c-aa65-08d6a6049ad7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6150;
x-ms-traffictypediagnostic: AM6PR04MB6150:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB6150;23:uSlOiEeHCDzmfSZPbNkuQRUu4o+sI23MPIft6rn?=
 =?iso-8859-1?Q?LrE0XnGv0DMOV6n0q84sjBQ7nnd+VReCRMZN6D1u8Xj03Sl5Ojjl1jsR+A?=
 =?iso-8859-1?Q?YjH2OnECtBDy6F1u9iNdlN5jRDN3ccXootFe88DQFu7YsCMyP+dVUxOB7K?=
 =?iso-8859-1?Q?1e9DxaDKOQQ+iUqG+X6uCboznRrsRTGTADVjXTxsTCmIfwduwt1TJdNMp2?=
 =?iso-8859-1?Q?oTEAm2Y/96Uqb3CCgEk0OAQRREKVr2MVnOXHrqIrEU7HV+sAVoG8cohkA+?=
 =?iso-8859-1?Q?gNaZLRoG0gzYBBdg9ahqMjGTTLWQ4/PTEIf6H+0KLNhCZ+RXv9oizpfzek?=
 =?iso-8859-1?Q?F9mDiLHPRNIrP8P02m7IhR7xc0BcvO1SLCOdLONdU5W6oS63u0DQ9F4Lrc?=
 =?iso-8859-1?Q?koMos1VE69hkGOK5Zz1H3fzCnnk1qcN5jiEO7L7Lhoe/2NliUuaEs8glEW?=
 =?iso-8859-1?Q?uh2XXq8FmVo2RIVTMdqCbFwvQSqxXMlT8NfzjtDItJUXfv3wcDJm2zrlQG?=
 =?iso-8859-1?Q?CJCLYHjGUHWPbU4kbxR4+p7r06vlp+HyI9KKOxPOTH9ekNVYdpDPq7ZgGE?=
 =?iso-8859-1?Q?tV2KZ88igyc1e1O0EiZGYUqGpjxS2V39auoQscjctVmlCnYhHR3CwfBYcO?=
 =?iso-8859-1?Q?RwzKvTIE3+ylOk+QUPxNHM86Bf8bWrcU8HVMI4E/d0AW3vo9G/RMP0ubZ/?=
 =?iso-8859-1?Q?qy9E/Ht+InojP3ebsfCEQPK3NPn/zTXfQOPFYgsrnN5sy9iH3CY2ktvcfI?=
 =?iso-8859-1?Q?R8HiqfrP7NQMp6d6tNG3G17YZgOcHihOeZmjjZ2ir8W2xF3Dr4It0nXrTn?=
 =?iso-8859-1?Q?+hyUultJs+fsAwaznV2OSy0w9q09LONS+c+85UhZYq4jp2WJd9BfnYu4oI?=
 =?iso-8859-1?Q?LdoTNjKjXGjxV3Ga7gAUJaQBBow4d3qosHFhWkE6Ah0PNyp09ecZXnoNVt?=
 =?iso-8859-1?Q?xHIiondKMJ1Mz/kuVU9oSv8HYhbU3E/K/OXdY9XQ1hBq93uMheDc7rrg6+?=
 =?iso-8859-1?Q?xFXaNhxPeG4PvWBpH0qoKh1jR5VZOPtnDRmOP0GsYj9Ofb5fzXVJFj884g?=
 =?iso-8859-1?Q?nMFP59HKfrgSmv8MXeHxn6EmKWPCCqRezrqISXPuWsRCK37f9RaEFlJgyf?=
 =?iso-8859-1?Q?wZ06gmggdiqP5hKAZaAkwQ5tTBPXe02aJi7K2PeJdGQK/X/uDpwXdUUviK?=
 =?iso-8859-1?Q?DscfBOwBe/cTLF2zSIGx0M0JTbZ6Xw4RXwZOkYdxUfQAH5bPJj8nACRFhe?=
 =?iso-8859-1?Q?2xEZrIg9fQZostyWV7vb/84nUJTIrS71E3Xm3KVBeydFpQBr7l1CZ3nsi6?=
 =?iso-8859-1?Q?PCscSekcxciuiKrDuZxfgODaFLpiRpxyMK/HQobDECSHlYE3F44Vcqh7nt?=
 =?iso-8859-1?Q?xXcdyhCU=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB61507EF267928764FB52774284480@AM6PR04MB6150.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(346002)(396003)(366004)(199004)(189003)(86362001)(54906003)(110136005)(6506007)(386003)(52116002)(99286004)(102836004)(316002)(4326008)(2201001)(50226002)(2501003)(97736004)(2906002)(66066001)(186003)(26005)(5660300002)(11346002)(76176011)(446003)(6486002)(36756003)(6436002)(25786009)(81166006)(81156014)(8676002)(478600001)(476003)(1076003)(7416002)(105586002)(305945005)(2616005)(71190400001)(71200400001)(3846002)(68736007)(6512007)(6116002)(8936002)(53936002)(7736002)(486006)(14454004)(14444005)(256004)(106356001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6150;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aeikiPdgOrm2uWNn3xczUhMbvEU83A0IRuN0DVmjjQgo8NJ0fGHOztTc8HWj67tTXW0zXU1FKpOe/+y3JO4lWHd/n7OoP5X9Q5yphcUyspwR4EOlqPMfoS48JXFHIpRxNrQMZ6hAW5m4GDxirmx0h1Xlhtw7iTP+EHOOY4iFU86QNq63j5FkhoSbFcXAflbvkaJROLSa6evrwTMwhdAOSoyngo1Ip5AypkqCDPowPAHs8AdII0d0RqLf5YDbkj+h2KGNZ9z6ka6KuAZBwtzOd0U5BmCYo0vcWWC5QaoG6jtYGUyprGwKsosVjBYXG+jCJNmf6RShCpUWYCz1uUuJ8ad+VbN0Klanhy3/BxI+3Uw+Nwna7JvfGhzZDP5jYMaZUe3vCZcfEhntq/aUHbkkkXWFYqEK/WvigNYj4AeKd5I=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4743724-3a80-421c-aa65-08d6a6049ad7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 09:33:23.0541
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

PCIe configuration access to non-existent function triggered
SERROR interrupt exception.

Workaround:
Disable error reporting on AXI bus during the Vendor ID read
transactions in enumeration.

This ERRATA is only for LX2160A Rev1.0, and it will be fixed
in Rev2.0.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V4:
 - no change

 .../controller/mobiveil/pci-layerscape-gen4.c | 37 +++++++++++++++++++
 .../controller/mobiveil/pcie-mobiveil-host.c  | 17 ++++++++-
 .../pci/controller/mobiveil/pcie-mobiveil.h   |  3 ++
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c b/driver=
s/pci/controller/mobiveil/pci-layerscape-gen4.c
index 174cbcac4059..d2c5dbbd5e3c 100644
--- a/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
+++ b/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
@@ -22,8 +22,13 @@
=20
 #include "pcie-mobiveil.h"
=20
+#define REV_1_0				(0x10)
+
 /* LUT and PF control registers */
 #define PCIE_LUT_OFF			(0x80000)
+#define PCIE_LUT_GCR			(0x28)
+#define PCIE_LUT_GCR_RRE		(0)
+
 #define PCIE_PF_OFF			(0xc0000)
 #define PCIE_PF_INT_STAT		(0x18)
 #define PF_INT_STAT_PABRST		(31)
@@ -41,6 +46,7 @@ struct ls_pcie_g4 {
 	struct mobiveil_pcie *pci;
 	struct delayed_work dwork;
 	int irq;
+	u8 rev;
 };
=20
 static inline u32 ls_pcie_g4_lut_readl(struct ls_pcie_g4 *pcie, u32 off)
@@ -76,6 +82,15 @@ static bool ls_pcie_g4_is_bridge(struct ls_pcie_g4 *pcie=
)
 	return header_type =3D=3D PCI_HEADER_TYPE_BRIDGE;
 }
=20
+static int ls_pcie_g4_host_init(struct mobiveil_pcie *pci)
+{
+	struct ls_pcie_g4 *pcie =3D to_ls_pcie_g4(pci);
+
+	pcie->rev =3D csr_readb(pci, PCI_REVISION_ID);
+
+	return 0;
+}
+
 static int ls_pcie_g4_link_up(struct mobiveil_pcie *pci)
 {
 	struct ls_pcie_g4 *pcie =3D to_ls_pcie_g4(pci);
@@ -188,12 +203,34 @@ static void ls_pcie_g4_reset(struct work_struct *work=
)
 	ls_pcie_g4_reinit_hw(pcie);
 }
=20
+static int ls_pcie_g4_read_other_conf(struct pci_bus *bus, unsigned int de=
vfn,
+				   int where, int size, u32 *val)
+{
+	struct mobiveil_pcie *pci =3D bus->sysdata;
+	struct ls_pcie_g4 *pcie =3D to_ls_pcie_g4(pci);
+	int ret;
+
+	if (pcie->rev =3D=3D REV_1_0 && where =3D=3D PCI_VENDOR_ID)
+		ls_pcie_g4_lut_writel(pcie, PCIE_LUT_GCR,
+				      0 << PCIE_LUT_GCR_RRE);
+
+	ret =3D pci_generic_config_read(bus, devfn, where, size, val);
+
+	if (pcie->rev =3D=3D REV_1_0 && where =3D=3D PCI_VENDOR_ID)
+		ls_pcie_g4_lut_writel(pcie, PCIE_LUT_GCR,
+				      1 << PCIE_LUT_GCR_RRE);
+
+	return ret;
+}
+
 static struct mobiveil_rp_ops ls_pcie_g4_rp_ops =3D {
 	.interrupt_init =3D ls_pcie_g4_interrupt_init,
+	.read_other_conf =3D ls_pcie_g4_read_other_conf,
 };
=20
 static const struct mobiveil_pab_ops ls_pcie_g4_pab_ops =3D {
 	.link_up =3D ls_pcie_g4_link_up,
+	.host_init =3D ls_pcie_g4_host_init,
 };
=20
 static int __init ls_pcie_g4_probe(struct platform_device *pdev)
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers=
/pci/controller/mobiveil/pcie-mobiveil-host.c
index e8d0c4989013..5f51bc2dd6d7 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -79,9 +79,20 @@ static void __iomem *mobiveil_pcie_map_bus(struct pci_bu=
s *bus,
 	return pcie->rp.config_axi_slave_base + where;
 }
=20
+static int mobiveil_pcie_config_read(struct pci_bus *bus, unsigned int dev=
fn,
+				     int where, int size, u32 *val)
+{
+	struct mobiveil_pcie *pcie =3D bus->sysdata;
+	struct root_port *rp =3D &pcie->rp;
+
+	if (bus->number > rp->root_bus_nr && rp->ops->read_other_conf)
+		return rp->ops->read_other_conf(bus, devfn, where, size, val);
+
+	return pci_generic_config_read(bus, devfn, where, size, val);
+}
 static struct pci_ops mobiveil_pcie_ops =3D {
 	.map_bus =3D mobiveil_pcie_map_bus,
-	.read =3D pci_generic_config_read,
+	.read =3D mobiveil_pcie_config_read,
 	.write =3D pci_generic_config_write,
 };
=20
@@ -309,6 +320,10 @@ int mobiveil_host_init(struct mobiveil_pcie *pcie, boo=
l reinit)
 	value |=3D (PCI_CLASS_BRIDGE_PCI << 16);
 	csr_writel(pcie, value, PAB_INTP_AXI_PIO_CLASS);
=20
+	/* Platform specific host init */
+	if (pcie->ops->host_init)
+		return pcie->ops->host_init(pcie);
+
 	return 0;
 }
=20
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/=
controller/mobiveil/pcie-mobiveil.h
index 0ccd6cee5f8f..ab43de5e4b2b 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
@@ -145,6 +145,8 @@ struct mobiveil_msi {			/* MSI information */
=20
 struct mobiveil_rp_ops {
 	int (*interrupt_init)(struct mobiveil_pcie *pcie);
+	int (*read_other_conf)(struct pci_bus *bus, unsigned int devfn,
+			       int where, int size, u32 *val);
 };
=20
 struct root_port {
@@ -160,6 +162,7 @@ struct root_port {
=20
 struct mobiveil_pab_ops {
 	int (*link_up)(struct mobiveil_pcie *pcie);
+	int (*host_init)(struct mobiveil_pcie *pcie);
 };
=20
 struct mobiveil_pcie {
--=20
2.17.1

