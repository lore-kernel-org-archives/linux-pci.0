Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2358C46465
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 10:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946C32086B
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 10:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oLcckoRa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 946C32086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbeKGTji (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:39:38 -0500
Received: from mail-eopbgr80071.outbound.protection.outlook.com ([40.107.8.71]:4671
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726411AbeKGTjh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Nov 2018 14:39:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2U9bTI06bt+YUlAqIRHbFrMn8xSfemDHPNYsvSM4Il0=;
 b=oLcckoRab2RsyFciBHHO8ZMMbbvvx9l6ZULRQIGRzO4AeHZ29N3yrAzzrRbS+CEPSkXLcaX6kaXuhCuxlwFn/epDt5KMTcgYkgxr1nYXQPSRf9pnPiRNjjK2KZXflc4vybRMDtNR8z6OdhWmSyaiQ8+Yz+QC9nYbast1qh62J8Y=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB5224.eurprd04.prod.outlook.com (20.177.35.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Wed, 7 Nov 2018 10:09:21 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00%3]) with mapi id 15.20.1273.035; Wed, 7 Nov 2018
 10:09:21 +0000
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
Subject: [PATCHv2 4/4] PCI: dwc: add prefetchable memory range support
Thread-Topic: [PATCHv2 4/4] PCI: dwc: add prefetchable memory range support
Thread-Index: AQHUdoHzO92qDxmIZkykN3HwHZxeDg==
Date:   Wed, 7 Nov 2018 10:09:21 +0000
Message-ID: <20181107100854.28389-5-Zhiqiang.Hou@nxp.com>
References: <20181107100854.28389-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181107100854.28389-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR04CA0023.apcprd04.prod.outlook.com
 (2603:1096:203:36::35) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:aa::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5224;6:apE9Sd9R3v87v81SY+ZBMv4f/xYIAssvGz8KUCBV80URINUosd8GyrkhpLFtd0FGUYslgJYxV29h3bBgpiJUZoWW7Km3ABX7RAXwYGwdAi2JtwEVIVwS2wehKAglDEnmY9AZuBLDM2wPPIur4dMirA+japOZtd4rDE9WYNss6PwlRXtSDnUXw92l0q4yvX2xwGvDZqMC2cSnpk+zg2yKoePLzfjvPiIX5b/kdeXh9w4x7c7P92rVGhxElT4atGJQiHJiw/SdG1huLmRDeVsSAG1p8OJZximvYeis6angZnKLX/GxU38Yjrig3nlQv/v+xtsHj0bK+HpGNikMTVHHqQp8lg4U21eYip0hhYdE0zuSWY+Sm/DZjHa6p8lZH17L+bT7pPDzzSIYcVU3RGrJ9MCJZz1lwoZ35wCK3W1G36+Whf2DuCnHy4M4n4IevK87rQk4eM4TG17yUnSb7nBwfA==;5:PCqbum8TRHPub+l1TI52AbWOB0V7wLyPNtnoolO1l4ychpVr9D5Nl55zial83Q7+C48NTuhGqK3v1Zn7EhQwdZcWIQZ2D4n4yXJs1NqoZd1MSrMhgjlTzpRxMJ2hJFYHjj8PDBzDHpwBFtesRU8V2qdloi7Io/LKu1uwqQFJ31w=;7:dwOdsYHqgZFr9NHqomjbutqZ9A2GVtfjIKC4pS1CzlHOKMniveUBLaA9W7r9dKayMARpBf9X2F6HTzdkLlDAxRI75IBuJCwqgojEuHZKfW1jrIlG5al7J0bafWXHegvdNJlv3QuqXYo5gqnOJWjRkA==
x-ms-office365-filtering-correlation-id: 32705812-5318-4915-c0ee-08d644991607
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5224;
x-ms-traffictypediagnostic: AM6PR04MB5224:
x-microsoft-antispam-prvs: <AM6PR04MB5224A0827F2C9216CCE7881884C40@AM6PR04MB5224.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5224;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5224;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39860400002)(376002)(346002)(189003)(199004)(71200400001)(71190400001)(39060400002)(5660300001)(305945005)(2501003)(25786009)(386003)(6506007)(6116002)(3846002)(102836004)(1076002)(8936002)(68736007)(81166006)(97736004)(81156014)(256004)(14444005)(2906002)(99286004)(186003)(66066001)(76176011)(52116002)(26005)(86362001)(54906003)(2201001)(6436002)(316002)(2900100001)(8676002)(446003)(53936002)(2616005)(486006)(11346002)(105586002)(478600001)(36756003)(106356001)(476003)(14454004)(7736002)(6512007)(110136005)(4326008)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5224;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2YjS3ID+xvPQCwTPsdRWANl2sHSZtfwvl7FcqSWSM6Ui3vvyypkoFlLErDySbM5axd3RvkRM0/eDKkw53rijE3Pk7j4d85i4uB0rH9j7nH0wHRuZgjQVGn/dcH17Y/4DroRltrwPPAKc4pToT1JfQRer9YYgIr7JVxosDzbxAixDitQjJT0EHjR43gyHBkvSfZbLtlKMGl7q5Sap00BcaBrgBU57p/Zc4ugHhz8rC4Jv05xLixOAGmUXF1zszHM8n1/yFpPemCcUr3ZPNzSH27GITV9pph8i7YKtOwYLcz1f6611xzmKIHiefbHaVjmrOb6/3xtM/93NVTl0RY8YPsY+/kuMZQ5eMkZeH5+LISU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32705812-5318-4915-c0ee-08d644991607
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 10:09:21.3178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5224
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The current code only support non-prefetchable memory range,
as the non-prefetchable memory range must not be greater than
4GiB, one viewport can cover it, which supports upto 4GiB.

To support prefetchable memory range, which is upto 64-bit
memory space and can be greater than 4GiB, so we need multiple
viewports. And added separate vars to store prefetchable memory
range info to prevent overriding the non-prefetchable memory
range info.

And this patch explicitly assigned the last (if there are only
2 viewports) or last 2 viewports for CFG and I/O windows and the
rests for MEM windows.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - Reworded the subject and commit description.
 - Fix the prefetchable memory range overriding non-perfetchable
   memory range issue by adding vars to store prefetchable memory
   range info.

 .../pci/controller/dwc/pcie-designware-host.c | 107 ++++++++++++++----
 drivers/pci/controller/dwc/pcie-designware.h  |   7 ++
 2 files changed, 95 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pc=
i/controller/dwc/pcie-designware-host.c
index ecacce016489..328aa40a6609 100644
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
+	dev_dbg(dev, "CFG win id: %d, I/O win id: %d, Total MEM win: %d\n",
+		pp->cfg_idx, pp->io_idx, pp->mem_wins);
+
 	bridge =3D pci_alloc_host_bridge(0);
 	if (!bridge)
 		return -ENOMEM;
@@ -377,10 +406,20 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			}
 			break;
 		case IORESOURCE_MEM:
-			pp->mem =3D win->res;
-			pp->mem->name =3D "MEM";
-			pp->mem_size =3D resource_size(pp->mem);
-			pp->mem_bus_addr =3D pp->mem->start - win->offset;
+			if (win->res->flags & IORESOURCE_PREFETCH) {
+				pp->mem_perf =3D win->res;
+				pp->mem_perf->name =3D "MEM perf";
+				pp->mem_perf_size =3D resource_size(pp->mem_perf);
+				pp->mem_perf_bus_addr =3D pp->mem_perf->start -
+							win->offset;
+				pp->mem_perf_base =3D pp->mem_perf->start;
+			} else {
+				pp->mem =3D win->res;
+				pp->mem->name =3D "MEM";
+				pp->mem_size =3D resource_size(pp->mem);
+				pp->mem_bus_addr =3D pp->mem->start - win->offset;
+				pp->mem_base =3D pp->mem->start;
+			}
 			break;
 		case 0:
 			pp->cfg =3D win->res;
@@ -406,8 +445,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		}
 	}
=20
-	pp->mem_base =3D pp->mem->start;
-
 	if (!pp->va_cfg0_base) {
 		pp->va_cfg0_base =3D devm_pci_remap_cfgspace(dev,
 					pp->cfg0_base, pp->cfg0_size);
@@ -534,12 +571,12 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp=
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
@@ -573,12 +610,12 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp=
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
@@ -652,6 +689,9 @@ static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *p=
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
@@ -700,13 +740,42 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
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
+		/*
+		 * The maximum region size is 4 GB, and a region
+		 * must not cross a 4 GB boundary.
+		 */
+		win_size =3D SZ_4G - (pp->mem_base & (SZ_4G - 1));
+		win_size =3D min(win_size, pp->mem_size);
+		dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_MEM,
+					  pp->mem_base, pp->mem_bus_addr,
+					  win_size);
+		dev_dbg(pci->dev,
+			"iATU: non-pref MEM: win =3D %d: base =3D %llx, bus_addr =3D %pa, size =
=3D %llx\n",
+			0, pp->mem_base, &pp->mem_bus_addr, win_size);
+
+		/* Prefetchable range can be 64bit space */
+		remain_size =3D pp->mem_perf_size;
+		base =3D pp->mem_perf_base;
+		bus_addr =3D pp->mem_perf_bus_addr;
+		for (i =3D 1; remain_size > 0 && i < pp->mem_wins; i++) {
+			win_size =3D SZ_4G - (base & (SZ_4G - 1));
+			win_size =3D min(win_size, remain_size);
+			dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_MEM,
+						  base, bus_addr, win_size);
+			dev_dbg(pci->dev, "iATU: pref MEM: win =3D %d: base =3D %llx, bus_addr =
=3D %pa, size =3D %llx\n",
+				i, base, &bus_addr, win_size);
+
+			base +=3D win_size;
+			bus_addr +=3D win_size;
+			remain_size -=3D win_size;
+		}
+
+		if (remain_size > 0)
+			dev_info(pci->dev, "iATU: MEM window isn't enough\n");
+
+		dw_pcie_prog_outbound_atu(pci, pp->io_idx, PCIE_ATU_TYPE_IO,
+					  pp->io_base, pp->io_bus_addr,
+					  pp->io_size);
 	}
=20
 	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/con=
troller/dwc/pcie-designware.h
index a438c3879aa9..0197f67f82b7 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -148,15 +148,22 @@ struct pcie_port {
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
+	u64			mem_perf_base;
+	phys_addr_t		mem_perf_bus_addr;
+	u64			mem_perf_size;
+	u32			mem_wins;
 	struct resource		*cfg;
 	struct resource		*io;
 	struct resource		*mem;
+	struct resource		*mem_perf;
 	struct resource		*busn;
 	int			irq;
 	const struct dw_pcie_host_ops *ops;
--=20
2.17.1

