Return-Path: <SRS0=18Ni=NF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F32C46475
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 09:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6870F20834
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 09:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IDdYtu76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6870F20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbeJYRyr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Oct 2018 13:54:47 -0400
Received: from mail-eopbgr30083.outbound.protection.outlook.com ([40.107.3.83]:23468
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726785AbeJYRyq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Oct 2018 13:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nkfQZl/cBzfEno5oHQWwPQaRwoPh/sKA6PawQmtZtM=;
 b=IDdYtu76bePFcgGDLdjgCidXQZ97+wp3bnRWRBNwb/Gr9aEvxrhoVseKYCAMLO2qRRNq1qABxep2LVv2igALUuVpzpCyqJ7ep1xLSiI82qzNzXmSSR7VzB/hG/wkBWbFAvvPbcfNbs5txgOXL9wEPknJ08SgIhfUr9wZTtw6J1A=
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com (10.162.155.27) by
 DB5PR04MB0952.eurprd04.prod.outlook.com (10.161.195.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Thu, 25 Oct 2018 09:22:50 +0000
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb]) by DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb%2]) with mapi id 15.20.1250.028; Thu, 25 Oct 2018
 09:22:50 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     Roy Zang <roy.zang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCH 4/4] PCI/dwc: Add more than 4GiB range support
Thread-Topic: [PATCH 4/4] PCI/dwc: Add more than 4GiB range support
Thread-Index: AQHUbERMuOPdoBqF20StZYHO34SK+Q==
Date:   Thu, 25 Oct 2018 09:22:50 +0000
Message-ID: <20181025092229.28413-5-Zhiqiang.Hou@nxp.com>
References: <20181025092229.28413-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181025092229.28413-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::22) To DB5PR04MB1221.eurprd04.prod.outlook.com
 (2a01:111:e400:51c2::27)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB5PR04MB0952;6:onz636fvb+t4WsseBBqScy1UExcduJVBLkY/DosHV9gb0ewx2zqMJWTfh22Z3yTpQ+jYRlHp8IuW17TUTwqSj1FMfY/rb+mY6oOjUVFGV+dxkkGo8EMa0aexHQI3v/ur+7s1HqRO6yxWjka2GtiR5GD3QZmTwVmIDENG6Ztc/gWlorpssL+OJUh9ByH7r8IE3UBdzT7NKusZAo52Ohp1/HWYMJKCr6OVh/sj2HdibCivbBPIeQHCrVoRyHupxz8+UvBbrGa3LNn1WajfYUczfKoPaAiCr95qzWJWfN1dU9qXKuFpYeUnS6bBdfZ9mDdM6vqxD7VWP5XzFI7XFNQP6IDLPdxTl+cfFhJJrlnN97Hu3B6VcJNXP24uRniJmztx7EALztoUwY8Y7JSpBHG/T3e2+rpL6GT3BOSEG3i/lbn5VHkw/GVWLo52LSJGPmUIEtks34Fki7ij+al7d1vOCA==;5:QjZzpPH8cdkyZNjfoYXOFSYUqmj7WWIwBoKTi/4Y8DWeSwXZwcgbOf7D26L5i5JH5/uMqQvAOOmwLVeC6l9Y9yQ6N5D4111nmvpg2PQOD/Efz8gy0cwR8DiUxB6KhOGwiENYWD97IKY1bRrNuQbZCirmioEck4jheaMr0yzKVz0=;7:qIjn1HAWzpb3pwuvcKXBOTxXwl+R1pORehgVBfHCBCzpVElT3gky68a+pxXRQV6FtczhwcqWPmJVcj9Cfx9K5sfdy6hxs5G6HUGPruizJznVb0XgT45wrm6Wn2kqAaszQ1hcWvHbeJj12a/FtNFYB7SV6/hA23HsOpeSADO+CIlfnqDACanEkStEdduZcSeaQF7hFYQV9U98xxZh/T/Uw7mEVKGMfu2zKMw3f36HW1xE1LB073HuheWqtA2w4u7e
x-ms-office365-filtering-correlation-id: 53693be8-6026-4e3a-c950-08d63a5b6f1e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB0952;
x-ms-traffictypediagnostic: DB5PR04MB0952:
x-microsoft-antispam-prvs: <DB5PR04MB0952C9A0D2BFB6E5575E795B84F70@DB5PR04MB0952.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB5PR04MB0952;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB0952;
x-forefront-prvs: 083691450C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(6512007)(6436002)(97736004)(6486002)(39060400002)(99286004)(81166006)(4326008)(81156014)(53936002)(106356001)(25786009)(105586002)(2900100001)(102836004)(11346002)(7736002)(8936002)(446003)(2616005)(14444005)(256004)(305945005)(476003)(186003)(478600001)(86362001)(8676002)(26005)(68736007)(2201001)(6346003)(486006)(6116002)(3846002)(386003)(6506007)(76176011)(66066001)(2906002)(5660300001)(36756003)(1076002)(14454004)(316002)(54906003)(110136005)(71200400001)(71190400001)(52116002)(2501003)(5250100002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB0952;H:DB5PR04MB1221.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-microsoft-antispam-message-info: byU5hhmjteYIuCHZ/QKbjUAaXGPUCGnAMcWk6TYviSM/JctsTMy1tD4ZCikJdwT8hvefYwB3Oiy7Hrv0PPZ6LnIBgJYHlOGaXGwo7NjLx7+WTcGfOTSsn7KcXHAchcwwAdmERXCqE58uhXOn4d0JPvNsSHRNO3uFLYJARwk2tM765xwVq4r0/w9foUrA4q/BkCKUvQPPNEZDNNcns7ZncZfboNff38Lz2MzoDQBcwas6DluII5+qG7vPbCplCd+FBQHkhJqDw88GzYpLMELNjJuS3BkjHZXfGE58CBp41sXTO6pDmcaz3zzYl+riux/ruxDzDcwF2GFDp0XJAPfi+yfcN2EcmcH0ljyBYXNY9b0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53693be8-6026-4e3a-c950-08d63a5b6f1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2018 09:22:50.5852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB0952
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

As each viewport support upto 4GiB, to support greater than 4GiB range
we need multiple viewport for MEM windows. And this patch explicitly
assigned the last (if there are only 2 viewports) or last 2 viewports
for CFG and IO windows and the rests for MEM windows.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 80 ++++++++++++++++---
 drivers/pci/controller/dwc/pcie-designware.h  |  3 +
 2 files changed, 70 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pc=
i/controller/dwc/pcie-designware-host.c
index ecacce016489..1b083873835e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -346,6 +346,35 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		dev_err(dev, "Missing *config* reg space\n");
 	}
=20
+	/*
+	 * If vendor's platform driver has set the num_viewport and it is
+	 * not less than 2, skip getting the num_viewport from DT here.
+	 */
+	if (pci->num_viewport < 2) {
+		ret =3D of_property_read_u32(np, "num-viewport",
+					   &pci->num_viewport);
+		if (ret || pci->num_viewport < 2)
+			pci->num_viewport =3D 2;
+	}
+
+	/*
+	 * if there are only 2 viewports, assign the last viewport for
+	 * both CFG and IO window, otherwise assign the last 2 viewport
+	 * for CFG and IO window specific. And the rest viewports are
+	 * assigned to MEM windows.
+	 */
+	if (pci->num_viewport =3D=3D 2) {
+		pp->cfg_idx =3D pp->io_idx =3D PCIE_ATU_REGION_INDEX1;
+		pp->mem_wins =3D 1;
+	} else {
+		pp->cfg_idx =3D pci->num_viewport - 1;
+		pp->io_idx =3D pci->num_viewport - 2;
+		pp->mem_wins =3D pci->num_viewport - 2;
+	}
+
+	dev_dbg(dev, "CFG window index: %d, IO window index: %d, Total MEM window=
 number: %d\n",
+		pp->cfg_idx, pp->io_idx, pp->mem_wins);
+
 	bridge =3D pci_alloc_host_bridge(0);
 	if (!bridge)
 		return -ENOMEM;
@@ -534,12 +563,12 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp=
, struct pci_bus *bus,
 		va_cfg_base =3D pp->va_cfg1_base;
 	}
=20
-	dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
+	dw_pcie_prog_outbound_atu(pci, pp->cfg_idx,
 				  type, cpu_addr,
 				  busdev, cfg_size);
 	ret =3D dw_pcie_read(va_cfg_base + where, size, val);
-	if (pci->num_viewport <=3D 2)
-		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
+	if (pp->cfg_idx =3D=3D pp->io_idx)
+		dw_pcie_prog_outbound_atu(pci, pp->io_idx,
 					  PCIE_ATU_TYPE_IO, pp->io_base,
 					  pp->io_bus_addr, pp->io_size);
=20
@@ -573,12 +602,12 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp=
, struct pci_bus *bus,
 		va_cfg_base =3D pp->va_cfg1_base;
 	}
=20
-	dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
+	dw_pcie_prog_outbound_atu(pci, pp->cfg_idx,
 				  type, cpu_addr,
 				  busdev, cfg_size);
 	ret =3D dw_pcie_write(va_cfg_base + where, size, val);
-	if (pci->num_viewport <=3D 2)
-		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
+	if (pp->cfg_idx =3D=3D pp->io_idx)
+		dw_pcie_prog_outbound_atu(pci, pp->io_idx,
 					  PCIE_ATU_TYPE_IO, pp->io_base,
 					  pp->io_bus_addr, pp->io_size);
=20
@@ -652,6 +681,9 @@ static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *p=
ci)
 void dw_pcie_setup_rc(struct pcie_port *pp)
 {
 	u32 val, ctrl, num_ctrls;
+	u64 remain_size, base, win_size;
+	phys_addr_t bus_addr;
+	int i;
 	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
=20
 	dw_pcie_setup(pci);
@@ -700,13 +732,35 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 		dev_dbg(pci->dev, "iATU unroll: %s\n",
 			pci->iatu_unroll_enabled ? "enabled" : "disabled");
=20
-		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
-					  PCIE_ATU_TYPE_MEM, pp->mem_base,
-					  pp->mem_bus_addr, pp->mem_size);
-		if (pci->num_viewport > 2)
-			dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX2,
-						  PCIE_ATU_TYPE_IO, pp->io_base,
-						  pp->io_bus_addr, pp->io_size);
+		remain_size =3D pp->mem_size;
+		base =3D pp->mem_base;
+		bus_addr =3D pp->mem_bus_addr;
+
+		for (i =3D 0; remain_size > 0 && i < pp->mem_wins; i++) {
+			/*
+			 * The maximum region size is 4 GB, and a region
+			 * must not cross a 4 GB boundary.
+			 */
+			win_size =3D SZ_4G - (base & (SZ_4G - 1));
+			win_size =3D min(win_size, remain_size);
+			dev_dbg(pci->dev, "iATU: MEM window %d: base =3D %llx, bus_addr =3D %ll=
x, size =3D %llx\n",
+				i, base, bus_addr, win_size);
+
+			dw_pcie_prog_outbound_atu(pci, i,
+						  PCIE_ATU_TYPE_MEM, base,
+						  bus_addr, win_size);
+
+			base +=3D win_size;
+			bus_addr +=3D win_size;
+			remain_size -=3D win_size;
+		}
+
+		if (remain_size > 0)
+			dev_info(pci->dev, "iATU: MEM window isn't enough\n");
+
+		dw_pcie_prog_outbound_atu(pci, pp->io_idx,
+					  PCIE_ATU_TYPE_IO, pp->io_base,
+					  pp->io_bus_addr, pp->io_size);
 	}
=20
 	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/con=
troller/dwc/pcie-designware.h
index a438c3879aa9..20146b8729b3 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -148,12 +148,15 @@ struct pcie_port {
 	u64			cfg1_base;
 	void __iomem		*va_cfg1_base;
 	u32			cfg1_size;
+	u32			cfg_idx;
 	resource_size_t		io_base;
 	phys_addr_t		io_bus_addr;
 	u32			io_size;
+	u32			io_idx;
 	u64			mem_base;
 	phys_addr_t		mem_bus_addr;
 	u64			mem_size;
+	u32			mem_wins;
 	struct resource		*cfg;
 	struct resource		*io;
 	struct resource		*mem;
--=20
2.17.1

