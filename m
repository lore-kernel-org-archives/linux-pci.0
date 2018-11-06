Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B1AC32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457D020869
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EOFm4ihN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 457D020869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388065AbeKFWqG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:46:06 -0500
Received: from mail-he1eur01on0070.outbound.protection.outlook.com ([104.47.0.70]:42149
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388116AbeKFWqG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Nov 2018 17:46:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9Hurid/k7/Pgj2dGKpxEOVwgz+HQchMrr/nZNew0hs=;
 b=EOFm4ihNVQSLyrPM2WoZMitAL8C5w38Gxl720DiyludNHizOdEvMGc/sQLr3R4o8NXjZVCpHD9MVcs5YJ3jaclGTJhlhSVSPhA6/p9PlubkeRThXl1DcGBwQUpEpl5XrBhA2/Ej0yhQKW0EcdYzRqBH/vS7TNoY1ACjUbXhfsDI=
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com (10.162.155.27) by
 DB5PR04MB1414.eurprd04.prod.outlook.com (10.162.221.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Tue, 6 Nov 2018 13:20:48 +0000
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb]) by DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb%2]) with mapi id 15.20.1273.035; Tue, 6 Nov 2018
 13:20:48 +0000
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
Subject: [PATCH 16/23] PCI: mobiveil: refactor the Mobiveil driver
Thread-Topic: [PATCH 16/23] PCI: mobiveil: refactor the Mobiveil driver
Thread-Index: AQHUddOINdoJDe12wkCn0hB7BBKcqw==
Date:   Tue, 6 Nov 2018 13:20:48 +0000
Message-ID: <20181106131807.29951-17-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;DB5PR04MB1414;6:4wS7LkQk/P3sHDFUvB8ZBVo0yg9duqQwTBdWBSnNyxSm5OAbtG0XSF6wbbkt553BAX95cZ5MBot8404CNTOTukcJIVmjHH8LtJGGB5+NUzioH20Vehzjwy2LsdQM/sIZrVwcUh38uEmyvLOj68XNiR4C6CWn4sTJSTQ7D03852p6cAPCT5mWqnD3sb3l0rVED5sAXALAm2mueQwciOamRxdmUuGbEOKOx7oCtSABrgqvEOCnblpYQzEAba3lrCmlMChoDQH95/jigWyAs3ftWaxfyBXxQDbh8Y7hPTh9qBKUaFt6/r+DLEViqwdTuNg8mD79sKRA3/X/7qnm+iOSFVEBJdU5NbmHtahojKK8i/+Gr8/qot4WD/3N+NbL23DJ3p0AiyhTGz9rNRTf1ik4yTs8lkiPdTRuWYFM/fLwDEMF6E5hJ+A+mmumlSNNTV3t3ohdNj6eR13SSjPEdrTXXA==;5:j+d7YlKCUDs7PeCOv3apLZrZed7RAhvaXonOsTLVTf+WRWSmyW9YZVOKZAl/OGTAPdYYoWfBircToebhGM50pjlJRpc0Tve4Tuu2odvDVE0qsiIEoYbOwB0R3LL310CAm29BrmV9aorz7CKhlsB47KfaveadrShS4O6z2HBfzrY=;7:oj/VSssSqlnU0Cc3MwQCYL3a2x8S00etwZggoa08RzHcwAAqvpkEOGJSSMBb7icpv6R8C2wd1eP7lRANwRMD1zpboDF1XPbnnSYj5uDpmCmZfsKgrOy7Vqd16HSi7T1nys5SCywBi2EbKnhAea6N8A==
x-ms-office365-filtering-correlation-id: 49f69f3d-7081-4df5-890b-08d643eaaa5f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1414;
x-ms-traffictypediagnostic: DB5PR04MB1414:
x-microsoft-antispam-prvs: <DB5PR04MB1414401C21D359F6B23E176A84CB0@DB5PR04MB1414.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(269456686620040)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB5PR04MB1414;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1414;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(97736004)(66066001)(8936002)(81156014)(81166006)(7416002)(8676002)(5660300001)(4744004)(71200400001)(71190400001)(478600001)(6486002)(6116002)(2900100001)(1076002)(53946003)(53936002)(6436002)(6512007)(305945005)(4326008)(25786009)(7736002)(105586002)(106356001)(68736007)(2906002)(3846002)(256004)(26005)(5024004)(14444005)(486006)(2501003)(14454004)(99286004)(52116002)(76176011)(36756003)(110136005)(386003)(6506007)(102836004)(54906003)(86362001)(186003)(446003)(575784001)(11346002)(316002)(2616005)(476003)(2201001)(921003)(1121003)(579004)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1414;H:DB5PR04MB1221.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: P4r49eiQ2eSurlRDpyBOWPImV4ftP0yNnwHUMdjvuHtCEWLcaWa9NmeS1lYgtNC154xWQEy5CoktCyUyug657bzjUYOU5KT2Hg6Y4jCoiIc8oqnCN37bwFxuUYXd9506+yDgNpuIKUpxtfGqCyRKAAl6aPTszhFtXHeVySYDHBtp02pIBkpJlWODrXMhfJSWTzt4iDu8lLi5gdk54GatVzMvLmVc2Vlr4fBoZFVQVDW/LDqiUIDbAAyfjcl/tLphijqBMM1OYB9qUJ4dOH6FrpR300Kpr7OAC0QSrkh+zjr0ZGyttc+wPXMOi71Ov4+z+y4I8FgdWf3zWkbfpasZf4isH1Ep4/BJ0NmB4Iq2QeU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f69f3d-7081-4df5-890b-08d643eaaa5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 13:20:48.5574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1414
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

As the Mobiveil PCIe controller support RC&EP DAUL mode, and to
make Platforms which integrated the Mobiveil PCIe IP more easy
to add their drivers, this patch moved the Mobiveil driver to
a new directory 'drivers/pci/controller/mobiveil' and refactored
it to different file according to the abstraction of RC&EP(TODO).

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 MAINTAINERS                                   |   2 +-
 drivers/pci/controller/Kconfig                |  11 +-
 drivers/pci/controller/Makefile               |   2 +-
 drivers/pci/controller/mobiveil/Kconfig       |  24 +
 drivers/pci/controller/mobiveil/Makefile      |   4 +
 .../pcie-mobiveil-host.c}                     | 520 +++---------------
 .../controller/mobiveil/pcie-mobiveil-plat.c  |  54 ++
 .../pci/controller/mobiveil/pcie-mobiveil.c   | 227 ++++++++
 .../pci/controller/mobiveil/pcie-mobiveil.h   | 187 +++++++
 9 files changed, 582 insertions(+), 449 deletions(-)
 create mode 100644 drivers/pci/controller/mobiveil/Kconfig
 create mode 100644 drivers/pci/controller/mobiveil/Makefile
 rename drivers/pci/controller/{pcie-mobiveil.c =3D> mobiveil/pcie-mobiveil=
-host.c} (55%)
 create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
 create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.c
 create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e8e817818656..0c57ccff3188 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11294,7 +11294,7 @@ M:	Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.=
in>
 L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
-F:	drivers/pci/controller/pcie-mobiveil.c
+F:	drivers/pci/controller/mobiveil/pcie-mobiveil*
=20
 PCI DRIVER FOR MVEBU (Marvell Armada 370 and Armada XP SOC support)
 M:	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfi=
g
index 028b287466fb..e06c386405ad 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -239,16 +239,6 @@ config PCIE_MEDIATEK
 	  Say Y here if you want to enable PCIe controller support on
 	  MediaTek SoCs.
=20
-config PCIE_MOBIVEIL
-	bool "Mobiveil AXI PCIe controller"
-	depends on ARCH_ZYNQMP || COMPILE_TEST
-	depends on OF
-	depends on PCI_MSI_IRQ_DOMAIN
-	help
-	  Say Y here if you want to enable support for the Mobiveil AXI PCIe
-	  Soft IP. It has up to 8 outbound and inbound windows
-	  for address translation and it is a PCIe Gen4 IP.
-
 config PCIE_TANGO_SMP8759
 	bool "Tango SMP8759 PCIe controller (DANGEROUS)"
 	depends on ARCH_TANGO && PCI_MSI && OF
@@ -279,4 +269,5 @@ config VMD
 	  module will be called vmd.
=20
 source "drivers/pci/controller/dwc/Kconfig"
+source "drivers/pci/controller/mobiveil/Kconfig"
 endmenu
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makef=
ile
index d56a507495c5..b79a615041a0 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -26,11 +26,11 @@ obj-$(CONFIG_PCIE_ROCKCHIP) +=3D pcie-rockchip.o
 obj-$(CONFIG_PCIE_ROCKCHIP_EP) +=3D pcie-rockchip-ep.o
 obj-$(CONFIG_PCIE_ROCKCHIP_HOST) +=3D pcie-rockchip-host.o
 obj-$(CONFIG_PCIE_MEDIATEK) +=3D pcie-mediatek.o
-obj-$(CONFIG_PCIE_MOBIVEIL) +=3D pcie-mobiveil.o
 obj-$(CONFIG_PCIE_TANGO_SMP8759) +=3D pcie-tango.o
 obj-$(CONFIG_VMD) +=3D vmd.o
 # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
 obj-y				+=3D dwc/
+obj-y				+=3D mobiveil/
=20
=20
 # The following drivers are for devices that use the generic ACPI
diff --git a/drivers/pci/controller/mobiveil/Kconfig b/drivers/pci/controll=
er/mobiveil/Kconfig
new file mode 100644
index 000000000000..64343c07bfed
--- /dev/null
+++ b/drivers/pci/controller/mobiveil/Kconfig
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menu "Mobiveil PCIe Core Support"
+	depends on PCI
+
+config PCIE_MOBIVEIL
+	bool
+
+config PCIE_MOBIVEIL_HOST
+        bool
+	depends on PCI_MSI_IRQ_DOMAIN
+        select PCIE_MOBIVEIL
+
+config PCIE_MOBIVEIL_PLAT
+	bool "Mobiveil AXI PCIe controller"
+	depends on ARCH_ZYNQMP || COMPILE_TEST
+	depends on OF
+	select PCIE_MOBIVEIL_HOST
+	help
+	  Say Y here if you want to enable support for the Mobiveil AXI PCIe
+	  Soft IP. It has up to 8 outbound and inbound windows
+	  for address translation and it is a PCIe Gen4 IP.
+
+endmenu
diff --git a/drivers/pci/controller/mobiveil/Makefile b/drivers/pci/control=
ler/mobiveil/Makefile
new file mode 100644
index 000000000000..9fb6d1c6504d
--- /dev/null
+++ b/drivers/pci/controller/mobiveil/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_PCIE_MOBIVEIL) +=3D pcie-mobiveil.o
+obj-$(CONFIG_PCIE_MOBIVEIL_HOST) +=3D pcie-mobiveil-host.o
+obj-$(CONFIG_PCIE_MOBIVEIL_PLAT) +=3D pcie-mobiveil-plat.o
diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/mobiveil/pcie-mobiveil-host.c
similarity index 55%
rename from drivers/pci/controller/pcie-mobiveil.c
rename to drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
index 8d6a1e98f655..383b2f3947a5 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -4,9 +4,9 @@
  *
  * Copyright (c) 2018 Mobiveil Inc.
  * Author: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
+ * Refactor: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
  */
=20
-#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -23,275 +23,21 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
=20
-#include "../pci.h"
-
-/* register offsets and bit positions */
-
-/*
- * translation tables are grouped into windows, each window registers are
- * grouped into blocks of 4 or 16 registers each
- */
-#define PAB_REG_BLOCK_SIZE		16
-#define PAB_EXT_REG_BLOCK_SIZE		4
-
-#define PAB_REG_ADDR(offset, win)	\
-	(offset + (win * PAB_REG_BLOCK_SIZE))
-#define PAB_EXT_REG_ADDR(offset, win)	\
-	(offset + (win * PAB_EXT_REG_BLOCK_SIZE))
-
-#define LTSSM_STATUS			0x0404
-#define  LTSSM_STATUS_L0_MASK		0x3f
-#define  LTSSM_STATUS_L0		0x2d
-
-#define PAB_CTRL			0x0808
-#define  AMBA_PIO_ENABLE_SHIFT		0
-#define  PEX_PIO_ENABLE_SHIFT		1
-#define  PAGE_SEL_SHIFT			13
-#define  PAGE_SEL_MASK			0x3f
-#define  PAGE_LO_MASK			0x3ff
-#define  PAGE_SEL_OFFSET_SHIFT		10
-
-#define PAB_AXI_PIO_CTRL		0x0840
-#define  APIO_EN_MASK			0xf
-
-#define PAB_PEX_PIO_CTRL		0x08c0
-#define  PIO_ENABLE_SHIFT		0
-
-#define PAB_INTP_AMBA_MISC_ENB		0x0b0c
-#define PAB_INTP_AMBA_MISC_STAT		0x0b1c
-#define  PAB_INTP_INTX_MASK		0x01e0
-#define  PAB_INTP_MSI_MASK		0x8
-
-#define PAB_AXI_AMAP_CTRL(win)		PAB_REG_ADDR(0x0ba0, win)
-#define  WIN_ENABLE_SHIFT		0
-#define  WIN_TYPE_SHIFT			1
-#define  WIN_TYPE_MASK			0x3
-#define  WIN_SIZE_SHIFT			10
-#define  WIN_SIZE_MASK			0x3fffff
-
-#define PAB_EXT_AXI_AMAP_SIZE(win)	PAB_EXT_REG_ADDR(0xbaf0, win)
-
-#define PAB_EXT_AXI_AMAP_AXI_WIN(win)	PAB_EXT_REG_ADDR(0x80a0, win)
-#define PAB_AXI_AMAP_AXI_WIN(win)	PAB_REG_ADDR(0x0ba4, win)
-#define  AXI_WINDOW_ALIGN_MASK		3
-
-#define PAB_AXI_AMAP_PEX_WIN_L(win)	PAB_REG_ADDR(0x0ba8, win)
-#define  PAB_BUS_SHIFT			24
-#define  PAB_DEVICE_SHIFT		19
-#define  PAB_FUNCTION_SHIFT		16
-
-#define PAB_AXI_AMAP_PEX_WIN_H(win)	PAB_REG_ADDR(0x0bac, win)
-#define PAB_INTP_AXI_PIO_CLASS		0x474
-
-#define PAB_PEX_AMAP_CTRL(win)		PAB_REG_ADDR(0x4ba0, win)
-#define  AMAP_CTRL_EN_SHIFT		0
-#define  AMAP_CTRL_TYPE_SHIFT		1
-#define  AMAP_CTRL_TYPE_MASK		3
-
-#define PAB_EXT_PEX_AMAP_SIZEN(win)	PAB_EXT_REG_ADDR(0xbef0, win)
-#define PAB_EXT_PEX_AMAP_AXI_WIN(win)	PAB_EXT_REG_ADDR(0xb4a0, win)
-#define PAB_PEX_AMAP_AXI_WIN(win)	PAB_REG_ADDR(0x4ba4, win)
-#define PAB_PEX_AMAP_PEX_WIN_L(win)	PAB_REG_ADDR(0x4ba8, win)
-#define PAB_PEX_AMAP_PEX_WIN_H(win)	PAB_REG_ADDR(0x4bac, win)
-
-/* starting offset of INTX bits in status register */
-#define PAB_INTX_START			5
-
-/* supported number of MSI interrupts */
-#define PCI_NUM_MSI			16
-
-/* MSI registers */
-#define MSI_BASE_LO_OFFSET		0x04
-#define MSI_BASE_HI_OFFSET		0x08
-#define MSI_SIZE_OFFSET			0x0c
-#define MSI_ENABLE_OFFSET		0x14
-#define MSI_STATUS_OFFSET		0x18
-#define MSI_DATA_OFFSET			0x20
-#define MSI_ADDR_L_OFFSET		0x24
-#define MSI_ADDR_H_OFFSET		0x28
-
-/* outbound and inbound window definitions */
-#define WIN_NUM_0			0
-#define WIN_NUM_1			1
-#define CFG_WINDOW_TYPE			0
-#define IO_WINDOW_TYPE			1
-#define MEM_WINDOW_TYPE			2
-#define IB_WIN_SIZE			((u64)256 * 1024 * 1024 * 1024)
-#define MAX_PIO_WINDOWS			8
-
-/* Parameters for the waiting for link up routine */
-#define LINK_WAIT_MAX_RETRIES		10
-#define LINK_WAIT_MIN			90000
-#define LINK_WAIT_MAX			100000
-
-#define PAGED_ADDR_BNDRY		0xc00
-#define OFFSET_TO_PAGE_ADDR(off)	\
-	((off & PAGE_LO_MASK) | PAGED_ADDR_BNDRY)
-#define OFFSET_TO_PAGE_IDX(off)		\
-	((off >> PAGE_SEL_OFFSET_SHIFT) & PAGE_SEL_MASK)
-
-struct mobiveil_msi {			/* MSI information */
-	struct mutex lock;		/* protect bitmap variable */
-	struct irq_domain *msi_domain;
-	struct irq_domain *dev_domain;
-	phys_addr_t msi_pages_phys;
-	int num_of_vectors;
-	DECLARE_BITMAP(msi_irq_in_use, PCI_NUM_MSI);
-};
-
-struct mobiveil_pcie {
-	struct platform_device *pdev;
-	struct list_head resources;
-	void __iomem *config_axi_slave_base;	/* endpoint config base */
-	void __iomem *csr_axi_slave_base;	/* root port config base */
-	void __iomem *apb_csr_base;	/* MSI register base */
-	phys_addr_t pcie_reg_base;	/* Physical PCIe Controller Base */
-	struct irq_domain *intx_domain;
-	raw_spinlock_t intx_mask_lock;
-	int irq;
-	int apio_wins;
-	int ppio_wins;
-	int ob_wins_configured;		/* configured outbound windows */
-	int ib_wins_configured;		/* configured inbound windows */
-	struct resource *ob_io_res;
-	char root_bus_nr;
-	struct mobiveil_msi msi;
-};
-
-/*
- * mobiveil_pcie_sel_page - routine to access paged register
- *
- * Registers whose address greater than PAGED_ADDR_BNDRY (0xc00) are paged=
,
- * for this scheme to work extracted higher 6 bits of the offset will be
- * written to pg_sel field of PAB_CTRL register and rest of the lower 10
- * bits enabled with PAGED_ADDR_BNDRY are used as offset of the register.
- */
-static void mobiveil_pcie_sel_page(struct mobiveil_pcie *pcie, u8 pg_idx)
-{
-	u32 val;
-
-	val =3D readl(pcie->csr_axi_slave_base + PAB_CTRL);
-	val &=3D ~(PAGE_SEL_MASK << PAGE_SEL_SHIFT);
-	val |=3D (pg_idx & PAGE_SEL_MASK) << PAGE_SEL_SHIFT;
-
-	writel(val, pcie->csr_axi_slave_base + PAB_CTRL);
-}
-
-static void *mobiveil_pcie_comp_addr(struct mobiveil_pcie *pcie, u32 off)
-{
-	if (off < PAGED_ADDR_BNDRY) {
-		/* For directly accessed registers, clear the pg_sel field */
-		mobiveil_pcie_sel_page(pcie, 0);
-		return pcie->csr_axi_slave_base + off;
-	}
-
-	mobiveil_pcie_sel_page(pcie, OFFSET_TO_PAGE_IDX(off));
-	return pcie->csr_axi_slave_base + OFFSET_TO_PAGE_ADDR(off);
-}
-
-static int mobiveil_pcie_read(void __iomem *addr, int size, u32 *val)
-{
-	if ((uintptr_t)addr & (size - 1)) {
-		*val =3D 0;
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-	}
-
-	switch (size) {
-	case 4:
-		*val =3D readl(addr);
-		break;
-	case 2:
-		*val =3D readw(addr);
-		break;
-	case 1:
-		*val =3D readb(addr);
-		break;
-	default:
-		*val =3D 0;
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-	}
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int mobiveil_pcie_write(void __iomem *addr, int size, u32 val)
-{
-	if ((uintptr_t)addr & (size - 1))
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-
-	switch (size) {
-	case 4:
-		writel(val, addr);
-		break;
-	case 2:
-		writew(val, addr);
-		break;
-	case 1:
-		writeb(val, addr);
-		break;
-	default:
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-	}
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static u32 csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)
-{
-	void *addr;
-	u32 val;
-	int ret;
-
-	addr =3D mobiveil_pcie_comp_addr(pcie, off);
-
-	ret =3D mobiveil_pcie_read(addr, size, &val);
-	if (ret)
-		dev_err(&pcie->pdev->dev, "read CSR address failed\n");
-
-	return val;
-}
-
-static void csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off, size_t=
 size)
-{
-	void *addr;
-	int ret;
-
-	addr =3D mobiveil_pcie_comp_addr(pcie, off);
-
-	ret =3D mobiveil_pcie_write(addr, size, val);
-	if (ret)
-		dev_err(&pcie->pdev->dev, "write CSR address failed\n");
-}
-
-static u32 csr_readl(struct mobiveil_pcie *pcie, u32 off)
-{
-	return csr_read(pcie, off, 0x4);
-}
-
-static void csr_writel(struct mobiveil_pcie *pcie, u32 val, u32 off)
-{
-	csr_write(pcie, val, off, 0x4);
-}
-
-static bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie)
-{
-	return (csr_readl(pcie, LTSSM_STATUS) &
-		LTSSM_STATUS_L0_MASK) =3D=3D LTSSM_STATUS_L0;
-}
+#include "pcie-mobiveil.h"
=20
 static bool mobiveil_pcie_valid_device(struct pci_bus *bus, unsigned int d=
evfn)
 {
 	struct mobiveil_pcie *pcie =3D bus->sysdata;
=20
 	/* Only one device down on each root port */
-	if ((bus->number =3D=3D pcie->root_bus_nr) && (devfn > 0))
+	if ((bus->number =3D=3D pcie->rp.root_bus_nr) && (devfn > 0))
 		return false;
=20
 	/*
 	 * Do not read more than one device on the bus directly
 	 * attached to RC
 	 */
-	if ((bus->primary =3D=3D pcie->root_bus_nr) && (devfn > 0))
+	if ((bus->primary =3D=3D pcie->rp.root_bus_nr) && (devfn > 0))
 		return false;
=20
 	return true;
@@ -311,7 +57,7 @@ static void __iomem *mobiveil_pcie_map_bus(struct pci_bu=
s *bus,
 		return NULL;
=20
 	/* RC config access */
-	if (bus->number =3D=3D pcie->root_bus_nr)
+	if (bus->number =3D=3D pcie->rp.root_bus_nr)
 		return pcie->csr_axi_slave_base + where;
=20
 	/*
@@ -326,7 +72,7 @@ static void __iomem *mobiveil_pcie_map_bus(struct pci_bu=
s *bus,
=20
 	csr_writel(pcie, value, PAB_AXI_AMAP_PEX_WIN_L(WIN_NUM_0));
=20
-	return pcie->config_axi_slave_base + where;
+	return pcie->rp.config_axi_slave_base + where;
 }
=20
 static struct pci_ops mobiveil_pcie_ops =3D {
@@ -340,7 +86,7 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
 	struct mobiveil_pcie *pcie =3D irq_desc_get_handler_data(desc);
 	struct device *dev =3D &pcie->pdev->dev;
-	struct mobiveil_msi *msi =3D &pcie->msi;
+	struct mobiveil_msi *msi =3D &pcie->rp.msi;
 	u32 msi_data, msi_addr_lo, msi_addr_hi;
 	u32 intr_status, msi_status;
 	unsigned long shifted_status;
@@ -365,7 +111,7 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
 		shifted_status >>=3D PAB_INTX_START;
 		do {
 			for_each_set_bit(bit, &shifted_status, PCI_NUM_INTX) {
-				virq =3D irq_find_mapping(pcie->intx_domain,
+				virq =3D irq_find_mapping(pcie->rp.intx_domain,
 							bit + 1);
 				if (virq)
 					generic_handle_irq(virq);
@@ -428,10 +174,10 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pci=
e *pcie)
 	/* map config resource */
 	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
 					   "config_axi_slave");
-	pcie->config_axi_slave_base =3D devm_pci_remap_cfg_resource(dev, res);
-	if (IS_ERR(pcie->config_axi_slave_base))
-		return PTR_ERR(pcie->config_axi_slave_base);
-	pcie->ob_io_res =3D res;
+	pcie->rp.config_axi_slave_base =3D devm_pci_remap_cfg_resource(dev, res);
+	if (IS_ERR(pcie->rp.config_axi_slave_base))
+		return PTR_ERR(pcie->rp.config_axi_slave_base);
+	pcie->rp.ob_io_res =3D res;
=20
 	/* map csr resource */
 	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
@@ -441,12 +187,6 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie=
 *pcie)
 		return PTR_ERR(pcie->csr_axi_slave_base);
 	pcie->pcie_reg_base =3D res->start;
=20
-	/* map MSI config resource */
-	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "apb_csr");
-	pcie->apb_csr_base =3D devm_pci_remap_cfg_resource(dev, res);
-	if (IS_ERR(pcie->apb_csr_base))
-		return PTR_ERR(pcie->apb_csr_base);
-
 	/* read the number of windows requested */
 	if (of_property_read_u32(node, "apio-wins", &pcie->apio_wins))
 		pcie->apio_wins =3D MAX_PIO_WINDOWS;
@@ -454,118 +194,15 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pc=
ie *pcie)
 	if (of_property_read_u32(node, "ppio-wins", &pcie->ppio_wins))
 		pcie->ppio_wins =3D MAX_PIO_WINDOWS;
=20
-	pcie->irq =3D platform_get_irq(pdev, 0);
-	if (pcie->irq <=3D 0) {
-		dev_err(dev, "failed to map IRQ: %d\n", pcie->irq);
-		return -ENODEV;
-	}
-
 	return 0;
 }
=20
-static void program_ib_windows(struct mobiveil_pcie *pcie, int win_num,
-			       u64 cpu_addr, u64 pci_addr, u32 type, u64 size)
-{
-	u32 value;
-	u64 size64 =3D ~(size - 1);
-
-	if (win_num >=3D pcie->ppio_wins) {
-		dev_err(&pcie->pdev->dev,
-			"ERROR: max inbound windows reached !\n");
-		return;
-	}
-
-	value =3D csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
-	value &=3D ~(AMAP_CTRL_TYPE_MASK << AMAP_CTRL_TYPE_SHIFT);
-	value |=3D (type << AMAP_CTRL_TYPE_SHIFT) | (1 << AMAP_CTRL_EN_SHIFT) |
-		 (lower_32_bits(size64) & WIN_SIZE_MASK << WIN_SIZE_SHIFT);
-	csr_writel(pcie, value, PAB_PEX_AMAP_CTRL(win_num));
-
-	csr_writel(pcie, upper_32_bits(size64),
-		   PAB_EXT_PEX_AMAP_SIZEN(win_num));
-
-	csr_writel(pcie, lower_32_bits(cpu_addr),
-		   PAB_PEX_AMAP_AXI_WIN(win_num));
-	csr_writel(pcie, upper_32_bits(cpu_addr),
-		   PAB_EXT_PEX_AMAP_AXI_WIN(win_num));
-
-	csr_writel(pcie, lower_32_bits(pci_addr),
-		   PAB_PEX_AMAP_PEX_WIN_L(win_num));
-	csr_writel(pcie, upper_32_bits(pci_addr),
-		   PAB_PEX_AMAP_PEX_WIN_H(win_num));
-
-	pcie->ib_wins_configured++;
-}
-
-/*
- * routine to program the outbound windows
- */
-static void program_ob_windows(struct mobiveil_pcie *pcie, int win_num,
-			       u64 cpu_addr, u64 pci_addr, u32 type, u64 size)
-{
-
-	u32 value;
-	u64 size64 =3D ~(size - 1);
-
-	if (win_num  >=3D pcie->apio_wins) {
-		dev_err(&pcie->pdev->dev,
-			"ERROR: max outbound windows reached !\n");
-		return;
-	}
-
-	/*
-	 * program Enable Bit to 1, Type Bit to (00) base 2, AXI Window Size Bit
-	 * to 4 KB in PAB_AXI_AMAP_CTRL register
-	 */
-	value =3D csr_readl(pcie, PAB_AXI_AMAP_CTRL(win_num));
-	value &=3D ~(WIN_TYPE_MASK << WIN_TYPE_SHIFT |
-		 WIN_SIZE_MASK << WIN_SIZE_SHIFT);
-	value |=3D 1 << WIN_ENABLE_SHIFT | type << WIN_TYPE_SHIFT |
-		 (lower_32_bits(size64) & WIN_SIZE_MASK << WIN_SIZE_SHIFT);
-	csr_writel(pcie, value, PAB_AXI_AMAP_CTRL(win_num));
-
-	csr_writel(pcie, upper_32_bits(size64), PAB_EXT_AXI_AMAP_SIZE(win_num));
-
-	/*
-	 * program AXI window base with appropriate value in
-	 * PAB_AXI_AMAP_AXI_WIN0 register
-	 */
-	csr_writel(pcie, lower_32_bits(cpu_addr) & (~AXI_WINDOW_ALIGN_MASK),
-		   PAB_AXI_AMAP_AXI_WIN(win_num));
-	csr_writel(pcie, upper_32_bits(cpu_addr),
-		   PAB_EXT_AXI_AMAP_AXI_WIN(win_num));
-
-	csr_writel(pcie, lower_32_bits(pci_addr),
-		   PAB_AXI_AMAP_PEX_WIN_L(win_num));
-	csr_writel(pcie, upper_32_bits(pci_addr),
-		   PAB_AXI_AMAP_PEX_WIN_H(win_num));
-
-	pcie->ob_wins_configured++;
-}
-
-static int mobiveil_bringup_link(struct mobiveil_pcie *pcie)
-{
-	int retries;
-
-	/* check if the link is up or not */
-	for (retries =3D 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
-		if (mobiveil_pcie_link_up(pcie))
-			return 0;
-
-		usleep_range(LINK_WAIT_MIN, LINK_WAIT_MAX);
-	}
-
-	dev_err(&pcie->pdev->dev, "link never came up\n");
-
-	return -ETIMEDOUT;
-}
-
 static void mobiveil_pcie_enable_msi(struct mobiveil_pcie *pcie)
 {
 	phys_addr_t msg_addr =3D pcie->pcie_reg_base;
-	struct mobiveil_msi *msi =3D &pcie->msi;
+	struct mobiveil_msi *msi =3D &pcie->rp.msi;
=20
-	pcie->msi.num_of_vectors =3D PCI_NUM_MSI;
+	msi->num_of_vectors =3D PCI_NUM_MSI;
 	msi->msi_pages_phys =3D (phys_addr_t)msg_addr;
=20
 	writel_relaxed(lower_32_bits(msg_addr),
@@ -627,20 +264,24 @@ static int mobiveil_host_init(struct mobiveil_pcie *p=
cie)
 	 */
=20
 	/* config outbound translation window */
-	program_ob_windows(pcie, WIN_NUM_0, pcie->ob_io_res->start, 0,
-			   CFG_WINDOW_TYPE, resource_size(pcie->ob_io_res));
+	program_ob_windows(pcie, WIN_NUM_0, pcie->rp.ob_io_res->start, 0,
+			   CFG_WINDOW_TYPE, resource_size(pcie->rp.ob_io_res));
=20
 	/* memory inbound translation window */
 	program_ib_windows(pcie, WIN_NUM_0, 0, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
=20
 	/* Get the I/O and memory ranges from DT */
 	resource_list_for_each_entry(win, &pcie->resources) {
-		if (resource_type(win->res) =3D=3D IORESOURCE_MEM)
+		if (resource_type(win->res) =3D=3D IORESOURCE_MEM) {
 			type =3D MEM_WINDOW_TYPE;
-		else if (resource_type(win->res) =3D=3D IORESOURCE_IO)
+		} else if (resource_type(win->res) =3D=3D IORESOURCE_IO) {
 			type =3D IO_WINDOW_TYPE;
-		else
+		} else if (resource_type(win->res) =3D=3D IORESOURCE_BUS) {
+			pcie->rp.root_bus_nr =3D win->res->start;
 			continue;
+		} else {
+			continue;
+		}
=20
 		/* configure outbound translation window */
 		program_ob_windows(pcie, pcie->ob_wins_configured,
@@ -655,9 +296,6 @@ static int mobiveil_host_init(struct mobiveil_pcie *pci=
e)
 	value |=3D (PCI_CLASS_BRIDGE_PCI << 16);
 	csr_writel(pcie, value, PAB_INTP_AXI_PIO_CLASS);
=20
-	/* setup MSI hardware registers */
-	mobiveil_pcie_enable_msi(pcie);
-
 	return 0;
 }
=20
@@ -670,11 +308,11 @@ static void mobiveil_mask_intx_irq(struct irq_data *d=
ata)
=20
 	pcie =3D irq_desc_get_chip_data(desc);
 	mask =3D 1 << ((data->hwirq + PAB_INTX_START) - 1);
-	raw_spin_lock_irqsave(&pcie->intx_mask_lock, flags);
+	raw_spin_lock_irqsave(&pcie->rp.intx_mask_lock, flags);
 	shifted_val =3D csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
 	shifted_val &=3D ~mask;
 	csr_writel(pcie, shifted_val, PAB_INTP_AMBA_MISC_ENB);
-	raw_spin_unlock_irqrestore(&pcie->intx_mask_lock, flags);
+	raw_spin_unlock_irqrestore(&pcie->rp.intx_mask_lock, flags);
 }
=20
 static void mobiveil_unmask_intx_irq(struct irq_data *data)
@@ -686,11 +324,11 @@ static void mobiveil_unmask_intx_irq(struct irq_data =
*data)
=20
 	pcie =3D irq_desc_get_chip_data(desc);
 	mask =3D 1 << ((data->hwirq + PAB_INTX_START) - 1);
-	raw_spin_lock_irqsave(&pcie->intx_mask_lock, flags);
+	raw_spin_lock_irqsave(&pcie->rp.intx_mask_lock, flags);
 	shifted_val =3D csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
 	shifted_val |=3D mask;
 	csr_writel(pcie, shifted_val, PAB_INTP_AMBA_MISC_ENB);
-	raw_spin_unlock_irqrestore(&pcie->intx_mask_lock, flags);
+	raw_spin_unlock_irqrestore(&pcie->rp.intx_mask_lock, flags);
 }
=20
 static struct irq_chip intx_irq_chip =3D {
@@ -758,7 +396,7 @@ static int mobiveil_irq_msi_domain_alloc(struct irq_dom=
ain *domain,
 					 unsigned int nr_irqs, void *args)
 {
 	struct mobiveil_pcie *pcie =3D domain->host_data;
-	struct mobiveil_msi *msi =3D &pcie->msi;
+	struct mobiveil_msi *msi =3D &pcie->rp.msi;
 	unsigned long bit;
=20
 	WARN_ON(nr_irqs !=3D 1);
@@ -785,7 +423,7 @@ static void mobiveil_irq_msi_domain_free(struct irq_dom=
ain *domain,
 {
 	struct irq_data *d =3D irq_domain_get_irq_data(domain, virq);
 	struct mobiveil_pcie *pcie =3D irq_data_get_irq_chip_data(d);
-	struct mobiveil_msi *msi =3D &pcie->msi;
+	struct mobiveil_msi *msi =3D &pcie->rp.msi;
=20
 	mutex_lock(&msi->lock);
=20
@@ -806,9 +444,9 @@ static int mobiveil_allocate_msi_domains(struct mobivei=
l_pcie *pcie)
 {
 	struct device *dev =3D &pcie->pdev->dev;
 	struct fwnode_handle *fwnode =3D of_node_to_fwnode(dev->of_node);
-	struct mobiveil_msi *msi =3D &pcie->msi;
+	struct mobiveil_msi *msi =3D &pcie->rp.msi;
=20
-	mutex_init(&pcie->msi.lock);
+	mutex_init(&msi->lock);
 	msi->dev_domain =3D irq_domain_add_linear(NULL, msi->num_of_vectors,
 						&msi_domain_ops, pcie);
 	if (!msi->dev_domain) {
@@ -835,15 +473,15 @@ static int mobiveil_pcie_init_irq_domain(struct mobiv=
eil_pcie *pcie)
 	int ret;
=20
 	/* setup INTx */
-	pcie->intx_domain =3D irq_domain_add_linear(node, PCI_NUM_INTX,
-						  &intx_domain_ops, pcie);
+	pcie->rp.intx_domain =3D irq_domain_add_linear(node, PCI_NUM_INTX,
+						     &intx_domain_ops, pcie);
=20
-	if (!pcie->intx_domain) {
+	if (!pcie->rp.intx_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
 		return -ENOMEM;
 	}
=20
-	raw_spin_lock_init(&pcie->intx_mask_lock);
+	raw_spin_lock_init(&pcie->rp.intx_mask_lock);
=20
 	/* setup MSI */
 	ret =3D mobiveil_allocate_msi_domains(pcie);
@@ -853,24 +491,54 @@ static int mobiveil_pcie_init_irq_domain(struct mobiv=
eil_pcie *pcie)
 	return 0;
 }
=20
-static int mobiveil_pcie_probe(struct platform_device *pdev)
+static int mobiveil_pcie_interrupt_init(struct mobiveil_pcie *pcie)
+{
+	struct device *dev =3D &pcie->pdev->dev;
+	struct resource *res;
+	int ret;
+
+	if (pcie->rp.ops->interrupt_init)
+		return pcie->rp.ops->interrupt_init(pcie);
+
+	/* map MSI config resource */
+	res =3D platform_get_resource_byname(pcie->pdev, IORESOURCE_MEM,
+					   "apb_csr");
+	pcie->apb_csr_base =3D devm_pci_remap_cfg_resource(dev, res);
+	if (IS_ERR(pcie->apb_csr_base))
+		return PTR_ERR(pcie->apb_csr_base);
+
+	/* setup MSI hardware registers */
+	mobiveil_pcie_enable_msi(pcie);
+
+	pcie->rp.irq =3D platform_get_irq(pcie->pdev, 0);
+	if (pcie->rp.irq <=3D 0) {
+		dev_err(dev, "failed to map IRQ: %d\n", pcie->rp.irq);
+		return -ENODEV;
+	}
+
+	/* initialize the IRQ domains */
+	ret =3D mobiveil_pcie_init_irq_domain(pcie);
+	if (ret) {
+		dev_err(dev, "Failed creating IRQ Domain\n");
+		return ret;
+	}
+
+	irq_set_chained_handler_and_data(pcie->rp.irq,
+					 mobiveil_pcie_isr, pcie);
+
+	return 0;
+}
+
+int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
 {
-	struct mobiveil_pcie *pcie;
 	struct pci_bus *bus;
 	struct pci_bus *child;
 	struct pci_host_bridge *bridge;
-	struct device *dev =3D &pdev->dev;
+	struct device *dev =3D &pcie->pdev->dev;
 	resource_size_t iobase;
 	int ret;
=20
-	/* allocate the PCIe port */
-	bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
-	if (!bridge)
-		return -ENOMEM;
-
-	pcie =3D pci_host_bridge_priv(bridge);
-
-	pcie->pdev =3D pdev;
+	INIT_LIST_HEAD(&pcie->resources);
=20
 	ret =3D mobiveil_pcie_parse_dt(pcie);
 	if (ret) {
@@ -878,7 +546,10 @@ static int mobiveil_pcie_probe(struct platform_device =
*pdev)
 		return ret;
 	}
=20
-	INIT_LIST_HEAD(&pcie->resources);
+	/* allocate the PCIe port */
+	bridge =3D devm_pci_alloc_host_bridge(dev, 0);
+	if (!bridge)
+		return -ENOMEM;
=20
 	/* parse the host bridge base addresses from the device tree file */
 	ret =3D devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
@@ -898,15 +569,12 @@ static int mobiveil_pcie_probe(struct platform_device=
 *pdev)
 		goto error;
 	}
=20
-	/* initialize the IRQ domains */
-	ret =3D mobiveil_pcie_init_irq_domain(pcie);
+	ret =3D mobiveil_pcie_interrupt_init(pcie);
 	if (ret) {
-		dev_err(dev, "Failed creating IRQ Domain\n");
+		dev_err(dev, "Interrupt init failed\n");
 		goto error;
 	}
=20
-	irq_set_chained_handler_and_data(pcie->irq, mobiveil_pcie_isr, pcie);
-
 	ret =3D devm_request_pci_bus_resources(dev, &pcie->resources);
 	if (ret)
 		goto error;
@@ -915,7 +583,7 @@ static int mobiveil_pcie_probe(struct platform_device *=
pdev)
 	list_splice_init(&pcie->resources, &bridge->windows);
 	bridge->dev.parent =3D dev;
 	bridge->sysdata =3D pcie;
-	bridge->busnr =3D pcie->root_bus_nr;
+	bridge->busnr =3D pcie->rp.root_bus_nr;
 	bridge->ops =3D &mobiveil_pcie_ops;
 	bridge->map_irq =3D of_irq_parse_and_map_pci;
 	bridge->swizzle_irq =3D pci_common_swizzle;
@@ -943,25 +611,3 @@ static int mobiveil_pcie_probe(struct platform_device =
*pdev)
 	pci_free_resource_list(&pcie->resources);
 	return ret;
 }
-
-static const struct of_device_id mobiveil_pcie_of_match[] =3D {
-	{.compatible =3D "mbvl,gpex40-pcie",},
-	{},
-};
-
-MODULE_DEVICE_TABLE(of, mobiveil_pcie_of_match);
-
-static struct platform_driver mobiveil_pcie_driver =3D {
-	.probe =3D mobiveil_pcie_probe,
-	.driver =3D {
-		.name =3D "mobiveil-pcie",
-		.of_match_table =3D mobiveil_pcie_of_match,
-		.suppress_bind_attrs =3D true,
-	},
-};
-
-builtin_platform_driver(mobiveil_pcie_driver);
-
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("Mobiveil PCIe host controller driver");
-MODULE_AUTHOR("Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>");
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c b/drivers=
/pci/controller/mobiveil/pcie-mobiveil-plat.c
new file mode 100644
index 000000000000..216c62f35568
--- /dev/null
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe host controller driver for Mobiveil PCIe Host controller
+ *
+ * Copyright (c) 2018 Mobiveil Inc.
+ * Author: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
+ * Refactor: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_pci.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "pcie-mobiveil.h"
+
+static int mobiveil_pcie_probe(struct platform_device *pdev)
+{
+	struct mobiveil_pcie *pcie;
+	struct device *dev =3D &pdev->dev;
+
+	pcie =3D devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	pcie->pdev =3D pdev;
+
+	return mobiveil_pcie_host_probe(pcie);
+}
+
+static const struct of_device_id mobiveil_pcie_of_match[] =3D {
+	{.compatible =3D "mbvl,gpex40-pcie",},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, mobiveil_pcie_of_match);
+
+static struct platform_driver mobiveil_pcie_driver =3D {
+	.probe =3D mobiveil_pcie_probe,
+	.driver =3D {
+		.name =3D "mobiveil-pcie",
+		.of_match_table =3D mobiveil_pcie_of_match,
+		.suppress_bind_attrs =3D true,
+	},
+};
+
+builtin_platform_driver(mobiveil_pcie_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Mobiveil PCIe host controller driver");
+MODULE_AUTHOR("Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>");
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.c b/drivers/pci/=
controller/mobiveil/pcie-mobiveil.c
new file mode 100644
index 000000000000..a25ebdd23592
--- /dev/null
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe host controller driver for Mobiveil PCIe Host controller
+ *
+ * Copyright (c) 2018 Mobiveil Inc.
+ * Author: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
+ * Refactor: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+
+#include "pcie-mobiveil.h"
+
+/*
+ * mobiveil_pcie_sel_page - routine to access paged register
+ *
+ * Registers whose address greater than PAGED_ADDR_BNDRY (0xc00) are paged=
,
+ * for this scheme to work extracted higher 6 bits of the offset will be
+ * written to pg_sel field of PAB_CTRL register and rest of the lower 10
+ * bits enabled with PAGED_ADDR_BNDRY are used as offset of the register.
+ */
+static void mobiveil_pcie_sel_page(struct mobiveil_pcie *pcie, u8 pg_idx)
+{
+	u32 val;
+
+	val =3D readl(pcie->csr_axi_slave_base + PAB_CTRL);
+	val &=3D ~(PAGE_SEL_MASK << PAGE_SEL_SHIFT);
+	val |=3D (pg_idx & PAGE_SEL_MASK) << PAGE_SEL_SHIFT;
+
+	writel(val, pcie->csr_axi_slave_base + PAB_CTRL);
+}
+
+static void *mobiveil_pcie_comp_addr(struct mobiveil_pcie *pcie, u32 off)
+{
+	if (off < PAGED_ADDR_BNDRY) {
+		/* For directly accessed registers, clear the pg_sel field */
+		mobiveil_pcie_sel_page(pcie, 0);
+		return pcie->csr_axi_slave_base + off;
+	}
+
+	mobiveil_pcie_sel_page(pcie, OFFSET_TO_PAGE_IDX(off));
+	return pcie->csr_axi_slave_base + OFFSET_TO_PAGE_ADDR(off);
+}
+
+static int mobiveil_pcie_read(void __iomem *addr, int size, u32 *val)
+{
+	if ((uintptr_t)addr & (size - 1)) {
+		*val =3D 0;
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+
+	switch (size) {
+	case 4:
+		*val =3D readl(addr);
+		break;
+	case 2:
+		*val =3D readw(addr);
+		break;
+	case 1:
+		*val =3D readb(addr);
+		break;
+	default:
+		*val =3D 0;
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int mobiveil_pcie_write(void __iomem *addr, int size, u32 val)
+{
+	if ((uintptr_t)addr & (size - 1))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	switch (size) {
+	case 4:
+		writel(val, addr);
+		break;
+	case 2:
+		writew(val, addr);
+		break;
+	case 1:
+		writeb(val, addr);
+		break;
+	default:
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+u32 csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)
+{
+	void *addr;
+	u32 val;
+	int ret;
+
+	addr =3D mobiveil_pcie_comp_addr(pcie, off);
+
+	ret =3D mobiveil_pcie_read(addr, size, &val);
+	if (ret)
+		dev_err(&pcie->pdev->dev, "read CSR address failed\n");
+
+	return val;
+}
+
+void csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off, size_t size)
+{
+	void *addr;
+	int ret;
+
+	addr =3D mobiveil_pcie_comp_addr(pcie, off);
+
+	ret =3D mobiveil_pcie_write(addr, size, val);
+	if (ret)
+		dev_err(&pcie->pdev->dev, "write CSR address failed\n");
+}
+
+bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie)
+{
+	if (pcie->ops->link_up)
+		return pcie->ops->link_up(pcie);
+
+	return (csr_readl(pcie, LTSSM_STATUS) &
+		LTSSM_STATUS_L0_MASK) =3D=3D LTSSM_STATUS_L0;
+}
+
+void program_ib_windows(struct mobiveil_pcie *pcie, int win_num, u64 cpu_a=
ddr,
+			u64 pci_addr, u32 type, u64 size)
+{
+	u32 value;
+	u64 size64 =3D ~(size - 1);
+
+	if (win_num >=3D pcie->ppio_wins) {
+		dev_err(&pcie->pdev->dev,
+			"ERROR: max inbound windows reached !\n");
+		return;
+	}
+
+	value =3D csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
+	value &=3D ~(AMAP_CTRL_TYPE_MASK << AMAP_CTRL_TYPE_SHIFT);
+	value |=3D (type << AMAP_CTRL_TYPE_SHIFT) | (1 << AMAP_CTRL_EN_SHIFT) |
+		 (lower_32_bits(size64) & WIN_SIZE_MASK << WIN_SIZE_SHIFT);
+	csr_writel(pcie, value, PAB_PEX_AMAP_CTRL(win_num));
+
+	csr_writel(pcie, upper_32_bits(size64),
+		   PAB_EXT_PEX_AMAP_SIZEN(win_num));
+
+	csr_writel(pcie, lower_32_bits(cpu_addr),
+		   PAB_PEX_AMAP_AXI_WIN(win_num));
+	csr_writel(pcie, upper_32_bits(cpu_addr),
+		   PAB_EXT_PEX_AMAP_AXI_WIN(win_num));
+
+	csr_writel(pcie, lower_32_bits(pci_addr),
+		   PAB_PEX_AMAP_PEX_WIN_L(win_num));
+	csr_writel(pcie, upper_32_bits(pci_addr),
+		   PAB_PEX_AMAP_PEX_WIN_H(win_num));
+
+	pcie->ib_wins_configured++;
+}
+
+/*
+ * routine to program the outbound windows
+ */
+void program_ob_windows(struct mobiveil_pcie *pcie, int win_num, u64 cpu_a=
ddr,
+			u64 pci_addr, u32 type, u64 size)
+{
+
+	u32 value;
+	u64 size64 =3D ~(size - 1);
+
+	if (win_num  >=3D pcie->apio_wins) {
+		dev_err(&pcie->pdev->dev,
+			"ERROR: max outbound windows reached !\n");
+		return;
+	}
+
+	/*
+	 * program Enable Bit to 1, Type Bit to (00) base 2, AXI Window Size Bit
+	 * to 4 KB in PAB_AXI_AMAP_CTRL register
+	 */
+	value =3D csr_readl(pcie, PAB_AXI_AMAP_CTRL(win_num));
+	value &=3D ~(WIN_TYPE_MASK << WIN_TYPE_SHIFT |
+		 WIN_SIZE_MASK << WIN_SIZE_SHIFT);
+	value |=3D 1 << WIN_ENABLE_SHIFT | type << WIN_TYPE_SHIFT |
+		 (lower_32_bits(size64) & WIN_SIZE_MASK << WIN_SIZE_SHIFT);
+	csr_writel(pcie, value, PAB_AXI_AMAP_CTRL(win_num));
+
+	csr_writel(pcie, upper_32_bits(size64), PAB_EXT_AXI_AMAP_SIZE(win_num));
+
+	/*
+	 * program AXI window base with appropriate value in
+	 * PAB_AXI_AMAP_AXI_WIN0 register
+	 */
+	csr_writel(pcie, lower_32_bits(cpu_addr) & (~AXI_WINDOW_ALIGN_MASK),
+		   PAB_AXI_AMAP_AXI_WIN(win_num));
+	csr_writel(pcie, upper_32_bits(cpu_addr),
+		   PAB_EXT_AXI_AMAP_AXI_WIN(win_num));
+
+	csr_writel(pcie, lower_32_bits(pci_addr),
+		   PAB_AXI_AMAP_PEX_WIN_L(win_num));
+	csr_writel(pcie, upper_32_bits(pci_addr),
+		   PAB_AXI_AMAP_PEX_WIN_H(win_num));
+
+	pcie->ob_wins_configured++;
+}
+
+int mobiveil_bringup_link(struct mobiveil_pcie *pcie)
+{
+	int retries;
+
+	/* check if the link is up or not */
+	for (retries =3D 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
+		if (mobiveil_pcie_link_up(pcie))
+			return 0;
+
+		usleep_range(LINK_WAIT_MIN, LINK_WAIT_MAX);
+	}
+
+	dev_err(&pcie->pdev->dev, "link never came up\n");
+
+	return -ETIMEDOUT;
+}
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/=
controller/mobiveil/pcie-mobiveil.h
new file mode 100644
index 000000000000..eb4cb61291a8
--- /dev/null
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
@@ -0,0 +1,187 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PCIe host controller driver for Mobiveil PCIe Host controller
+ *
+ * Copyright (c) 2018 Mobiveil Inc.
+ * Author: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
+ * Refactor: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
+ */
+
+#ifndef _PCIE_MOBIVEIL_H
+#define _PCIE_MOBIVEIL_H
+
+#include <linux/pci.h>
+#include <linux/irq.h>
+#include <linux/msi.h>
+#include "../../pci.h"
+
+/* register offsets and bit positions */
+
+/*
+ * translation tables are grouped into windows, each window registers are
+ * grouped into blocks of 4 or 16 registers each
+ */
+#define PAB_REG_BLOCK_SIZE		16
+#define PAB_EXT_REG_BLOCK_SIZE		4
+
+#define PAB_REG_ADDR(offset, win)	\
+	(offset + (win * PAB_REG_BLOCK_SIZE))
+#define PAB_EXT_REG_ADDR(offset, win)	\
+	(offset + (win * PAB_EXT_REG_BLOCK_SIZE))
+
+#define LTSSM_STATUS			0x0404
+#define  LTSSM_STATUS_L0_MASK		0x3f
+#define  LTSSM_STATUS_L0		0x2d
+
+#define PAB_CTRL			0x0808
+#define  AMBA_PIO_ENABLE_SHIFT		0
+#define  PEX_PIO_ENABLE_SHIFT		1
+#define  PAGE_SEL_SHIFT			13
+#define  PAGE_SEL_MASK			0x3f
+#define  PAGE_LO_MASK			0x3ff
+#define  PAGE_SEL_OFFSET_SHIFT		10
+
+#define PAB_AXI_PIO_CTRL		0x0840
+#define  APIO_EN_MASK			0xf
+
+#define PAB_PEX_PIO_CTRL		0x08c0
+#define  PIO_ENABLE_SHIFT		0
+
+#define PAB_INTP_AMBA_MISC_ENB		0x0b0c
+#define PAB_INTP_AMBA_MISC_STAT		0x0b1c
+#define  PAB_INTP_INTX_MASK		0x01e0
+#define  PAB_INTP_MSI_MASK		0x8
+
+#define PAB_AXI_AMAP_CTRL(win)		PAB_REG_ADDR(0x0ba0, win)
+#define  WIN_ENABLE_SHIFT		0
+#define  WIN_TYPE_SHIFT			1
+#define  WIN_TYPE_MASK			0x3
+#define  WIN_SIZE_SHIFT			10
+#define  WIN_SIZE_MASK			0x3fffff
+
+#define PAB_EXT_AXI_AMAP_SIZE(win)	PAB_EXT_REG_ADDR(0xbaf0, win)
+
+#define PAB_EXT_AXI_AMAP_AXI_WIN(win)	PAB_EXT_REG_ADDR(0x80a0, win)
+#define PAB_AXI_AMAP_AXI_WIN(win)	PAB_REG_ADDR(0x0ba4, win)
+#define  AXI_WINDOW_ALIGN_MASK		3
+
+#define PAB_AXI_AMAP_PEX_WIN_L(win)	PAB_REG_ADDR(0x0ba8, win)
+#define  PAB_BUS_SHIFT			24
+#define  PAB_DEVICE_SHIFT		19
+#define  PAB_FUNCTION_SHIFT		16
+
+#define PAB_AXI_AMAP_PEX_WIN_H(win)	PAB_REG_ADDR(0x0bac, win)
+#define PAB_INTP_AXI_PIO_CLASS		0x474
+
+#define PAB_PEX_AMAP_CTRL(win)		PAB_REG_ADDR(0x4ba0, win)
+#define  AMAP_CTRL_EN_SHIFT		0
+#define  AMAP_CTRL_TYPE_SHIFT		1
+#define  AMAP_CTRL_TYPE_MASK		3
+
+#define PAB_EXT_PEX_AMAP_SIZEN(win)	PAB_EXT_REG_ADDR(0xbef0, win)
+#define PAB_EXT_PEX_AMAP_AXI_WIN(win)	PAB_EXT_REG_ADDR(0xb4a0, win)
+#define PAB_PEX_AMAP_AXI_WIN(win)	PAB_REG_ADDR(0x4ba4, win)
+#define PAB_PEX_AMAP_PEX_WIN_L(win)	PAB_REG_ADDR(0x4ba8, win)
+#define PAB_PEX_AMAP_PEX_WIN_H(win)	PAB_REG_ADDR(0x4bac, win)
+
+/* starting offset of INTX bits in status register */
+#define PAB_INTX_START			5
+
+/* supported number of MSI interrupts */
+#define PCI_NUM_MSI			16
+
+/* MSI registers */
+#define MSI_BASE_LO_OFFSET		0x04
+#define MSI_BASE_HI_OFFSET		0x08
+#define MSI_SIZE_OFFSET			0x0c
+#define MSI_ENABLE_OFFSET		0x14
+#define MSI_STATUS_OFFSET		0x18
+#define MSI_DATA_OFFSET			0x20
+#define MSI_ADDR_L_OFFSET		0x24
+#define MSI_ADDR_H_OFFSET		0x28
+
+/* outbound and inbound window definitions */
+#define WIN_NUM_0			0
+#define WIN_NUM_1			1
+#define CFG_WINDOW_TYPE			0
+#define IO_WINDOW_TYPE			1
+#define MEM_WINDOW_TYPE			2
+#define IB_WIN_SIZE			((u64)256 * 1024 * 1024 * 1024)
+#define MAX_PIO_WINDOWS			8
+
+/* Parameters for the waiting for link up routine */
+#define LINK_WAIT_MAX_RETRIES		10
+#define LINK_WAIT_MIN			90000
+#define LINK_WAIT_MAX			100000
+
+#define PAGED_ADDR_BNDRY		0xc00
+#define OFFSET_TO_PAGE_ADDR(off)	\
+	((off & PAGE_LO_MASK) | PAGED_ADDR_BNDRY)
+#define OFFSET_TO_PAGE_IDX(off)		\
+	((off >> PAGE_SEL_OFFSET_SHIFT) & PAGE_SEL_MASK)
+
+struct mobiveil_pcie;
+
+struct mobiveil_msi {			/* MSI information */
+	struct mutex lock;		/* protect bitmap variable */
+	struct irq_domain *msi_domain;
+	struct irq_domain *dev_domain;
+	phys_addr_t msi_pages_phys;
+	int num_of_vectors;
+	DECLARE_BITMAP(msi_irq_in_use, PCI_NUM_MSI);
+};
+
+struct mobiveil_rp_ops {
+	int (*interrupt_init)(struct mobiveil_pcie *pcie);
+};
+
+struct root_port {
+	u8 root_bus_nr;
+	void __iomem *config_axi_slave_base;	/* endpoint config base */
+	struct resource *ob_io_res;
+	struct mobiveil_rp_ops *ops;
+	int irq;
+	raw_spinlock_t intx_mask_lock;
+	struct irq_domain *intx_domain;
+	struct mobiveil_msi msi;
+};
+
+struct mobiveil_pab_ops {
+	int (*link_up)(struct mobiveil_pcie *pcie);
+};
+
+struct mobiveil_pcie {
+	struct platform_device *pdev;
+	struct list_head resources;
+	void __iomem *csr_axi_slave_base;	/* PAB registers base */
+	phys_addr_t pcie_reg_base;	/* Physical PCIe Controller Base */
+	void __iomem *apb_csr_base;	/* MSI register base */
+	u32 apio_wins;
+	u32 ppio_wins;
+	u32 ob_wins_configured;		/* configured outbound windows */
+	u32 ib_wins_configured;		/* configured inbound windows */
+	const struct mobiveil_pab_ops *ops;
+	struct root_port rp;
+};
+
+int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie);
+bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie);
+int mobiveil_bringup_link(struct mobiveil_pcie *pcie);
+void program_ob_windows(struct mobiveil_pcie *pcie, int win_num, u64 cpu_a=
ddr,
+			u64 pci_addr, u32 type, u64 size);
+void program_ib_windows(struct mobiveil_pcie *pcie, int win_num, u64 cpu_a=
ddr,
+			u64 pci_addr, u32 type, u64 size);
+u32 csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size);
+void csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off, size_t size);
+
+static inline u32 csr_readl(struct mobiveil_pcie *pcie, u32 off)
+{
+	return csr_read(pcie, off, 0x4);
+}
+
+static inline void csr_writel(struct mobiveil_pcie *pcie, u32 val, u32 off=
)
+{
+	csr_write(pcie, val, off, 0x4);
+}
+
+#endif /* _PCIE_MOBIVEIL_H */
--=20
2.17.1

