Return-Path: <SRS0=dd4N=OL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69E7C04EB8
	for <linux-pci@archiver.kernel.org>; Sun,  2 Dec 2018 13:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB6E20834
	for <linux-pci@archiver.kernel.org>; Sun,  2 Dec 2018 13:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KzCs0hHr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB6E20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbeLBNdy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 2 Dec 2018 08:33:54 -0500
Received: from mail-eopbgr50064.outbound.protection.outlook.com ([40.107.5.64]:17152
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725857AbeLBNdx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 2 Dec 2018 08:33:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34wU4g63xDBylNt0gGWE0ENUJC1rIQ35o1hi8ISM2mU=;
 b=KzCs0hHrdzr7IbOd3ujXBq3dcT+md/zKSBFXU/+dRJZpnpSf6vMv+ICE1CA1W91zNs8Zhh9g62pW4UEs4iC2Z2c2gf5xhl5+Ez4QSZoyOQr1Ygbv5+Qb+gVAWcWNVitTnIWVMzLy/0t5Hh0aiY0QnfnCRSSHNzXdrP3i0bItpro=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB4999.eurprd04.prod.outlook.com (20.177.33.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Sun, 2 Dec 2018 13:32:54 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c%5]) with mapi id 15.20.1382.020; Sun, 2 Dec 2018
 13:32:54 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>
CC:     Leo Li <leoyang.li@nxp.com>, "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCH 1/2] PCI: mobiveil: ls_pcie_g4: add Workaround for A-011577
Thread-Topic: [PATCH 1/2] PCI: mobiveil: ls_pcie_g4: add Workaround for
 A-011577
Thread-Index: AQHUikOAkcx6YJU/RkGCnKBgiBSiJg==
Date:   Sun, 2 Dec 2018 13:32:42 +0000
Message-ID: <20181202133303.33988-2-Zhiqiang.Hou@nxp.com>
References: <20181202133303.33988-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181202133303.33988-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0210.apcprd02.prod.outlook.com
 (2603:1096:201:20::22) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:aa::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4999;6:T7/aM8/QO8Uq+AD+RGgnunQHbi0UOwkTdpRER/tfeFyZYv+gzjNRybPowcvVSPcgyhYThSQgl4KMnLsUFVa1+CMK6kLLukFoJbSiNHf/BKmF0sdmFcVKPwWdnQ2Q3H2vMNSNyllVRxy6sQ+3ktO+E9HKZEdy94Gd/A+34trbBS14sF/L6NK1ZRQIMc0aufaWmEmP+xy+i+mpYWUoKb3hbOABpbQzEC2iUvly7+3k6FRdZv+IycqR4r6Ig4iGI5mg0KM4zX7NoDfT9lQbAVnyxukWjPUKogZawQMK1MfvkTGQjvpMz1ViweQAXXInU1AnxWZbHmickpJF8P+LozrtPNTM3U6/XRs/4LheIdfW1PunEsZBm2m+DP+7jbEObp2Q8nBUGXUFwSEmC+EBWHCoh6wq9BbLdQZFdYM6gXCYDzlicLg+TrXsOgWn74BYGXpE87gpOw7AGvqBSpfjvq6w5w==;5:rVZRIz7rbaUYuYOvc8W4qSwXkQ4vllxQgrjfDeJbw1gHk6EYZ403bCAdVUfSXYVO04ICPBiW6dMCFPhh8BtGS7GdLiNe1p4POZcCgyLD0aqiwdDvnI2BQ738qt0GTheFaKd/Qi7Etakrl6Yqr6z0WRONerkxQdK3aY5ELIk2kh0=;7:StxIOm4/JN6Q2/yneIiqK/8NPLDRgIcsPS42Z9vVrIvzWMYr8D7s8J7ozqwkRkBZk3tROusTwCBpU9nNmAHnvjTmsB9z+fbdAIh7sr/vQOWIyHeCiFd/XX4rvxBdte/ymBvDZeqpkiGGztXPNpka/Q==
x-ms-office365-filtering-correlation-id: 278bf841-2a5a-435d-9e09-08d6585aa2bc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4999;
x-ms-traffictypediagnostic: AM6PR04MB4999:
x-microsoft-antispam-prvs: <AM6PR04MB499909ED05ED2A3D336B331B84AD0@AM6PR04MB4999.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501489)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4999;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4999;
x-forefront-prvs: 087474FBFA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(396003)(136003)(376002)(199004)(189003)(256004)(99286004)(14444005)(186003)(52116002)(53936002)(36756003)(4326008)(76176011)(25786009)(446003)(66066001)(6436002)(2201001)(6486002)(486006)(5660300001)(11346002)(478600001)(86362001)(14454004)(476003)(2616005)(26005)(6512007)(2501003)(106356001)(105586002)(2906002)(1076002)(8936002)(7736002)(81166006)(81156014)(110136005)(6116002)(3846002)(8676002)(71190400001)(71200400001)(6666004)(102836004)(386003)(6506007)(97736004)(54906003)(305945005)(68736007)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4999;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NGhjuSNIjdLAJTKrajGQAi9O5xMKRTR41JZ2lB1ABnxQmKHwMigLe11+vYi01Qnn65s4spiDCfB+IGOAOo1C30FC15HhWMznUJqUSAzHvirP0yMNWWYGZ7LcQ2A28hszDHm9sGO0Zmyx3tiNtPQJf/ztZRvZF+3SXBFwtexEkymzd0SLyC9E6gphTlIvZuGkIsCSRS+j8caqXXkYX9rAMEwuboSviAd8LKsDYpBi+pamMQjNaMJjYs+sGYuJNTeBWJAszffyWHXsV10WmZCoddetRulDiBxbyZzUE1DN1aSPqGmOd5/OBGgOwF7hy+7g69dS+7U1VSIx5VdhtNAia96XFiuwLm18dYNJFzEEHBA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 278bf841-2a5a-435d-9e09-08d6585aa2bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2018 13:32:42.3167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4999
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
 .../controller/mobiveil/pci-layerscape-gen4.c | 24 +++++++++++++++++++
 .../controller/mobiveil/pcie-mobiveil-host.c  | 13 +++++++++-
 .../pci/controller/mobiveil/pcie-mobiveil.h   |  2 ++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c b/driver=
s/pci/controller/mobiveil/pci-layerscape-gen4.c
index 174cbcac4059..1fe56532b288 100644
--- a/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
+++ b/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
@@ -24,6 +24,9 @@
=20
 /* LUT and PF control registers */
 #define PCIE_LUT_OFF			(0x80000)
+#define PCIE_LUT_GCR			(0x28)
+#define PCIE_LUT_GCR_RRE		(0)
+
 #define PCIE_PF_OFF			(0xc0000)
 #define PCIE_PF_INT_STAT		(0x18)
 #define PF_INT_STAT_PABRST		(31)
@@ -188,8 +191,29 @@ static void ls_pcie_g4_reset(struct work_struct *work)
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
+	if (where =3D=3D PCI_VENDOR_ID)
+		ls_pcie_g4_lut_writel(pcie, PCIE_LUT_GCR,
+				      0 << PCIE_LUT_GCR_RRE);
+
+	ret =3D pci_generic_config_read(bus, devfn, where, size, val);
+
+	if (where =3D=3D PCI_VENDOR_ID)
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
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers=
/pci/controller/mobiveil/pcie-mobiveil-host.c
index c85f00d3cfcf..8b6db38320d7 100644
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
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/=
controller/mobiveil/pcie-mobiveil.h
index 0ccd6cee5f8f..ef93b41f4419 100644
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
--=20
2.17.1

