Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526DAC43613
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 04:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240F021855
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 04:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qXCwJ3Sf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbeLREUU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 23:20:20 -0500
Received: from mail-eopbgr60046.outbound.protection.outlook.com ([40.107.6.46]:52304
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726296AbeLREUT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Dec 2018 23:20:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsuyWdJkNxk6PApjsWCbCwRzy+IG8RnH5hWgdRKeS7o=;
 b=qXCwJ3Sf6aqF7G8KwcCy4UntfW/iOs6ZCldtyAiEqZ6Q8yQF+6brYdskpufrXjad6S7My6z19vzs9NggSYvkf/NUVOksYnuxkO3ERO4bUukxpRqMvkkgxN/YtQ9X6Hh0as8xQmhMKq3aw7Xs0Wrid8EJBYsvFbcLlQ5wpMnKl/0=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB4102.eurprd04.prod.outlook.com (52.135.167.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Tue, 18 Dec 2018 04:19:48 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::4d2e:cf15:fcf7:56b2]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::4d2e:cf15:fcf7:56b2%5]) with mapi id 15.20.1446.015; Tue, 18 Dec 2018
 04:19:48 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        Leo Li <leoyang.li@nxp.com>
CC:     Roy Zang <roy.zang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCHv3 5/5] PCI: dwc: add prefetchable memory range support
Thread-Topic: [PATCHv3 5/5] PCI: dwc: add prefetchable memory range support
Thread-Index: AQHUlojqcT/kWN1oFkqB3BqcFGu4pA==
Date:   Tue, 18 Dec 2018 04:19:48 +0000
Message-ID: <20181218041956.41809-6-Zhiqiang.Hou@nxp.com>
References: <20181218041956.41809-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181218041956.41809-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0075.apcprd03.prod.outlook.com
 (2603:1096:203:72::15) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:aa::16)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4102;6:7hm1NPNbRBKuvSBMoSehlmtz7pdDKvd1WfKhvSeeJLmhub7SjdKli7uGqkd7slvhfPnUdnDyzNLzZ6ViE/Gnh/nSEd5GTJrSeQQZ0UWDoA5DomA0YB5LOAHzAirOA4rpWwJBAgRitnrEdeoRRzqTOQvsoFW2G63Bjp/s+3jvtoJ7xv7w6VxPROg7QFATAZGKFpMG5hzH/UteFDXT/YLN+By6xQq5/H64OTX3Dck4CEhuRT6LbYIghHNXF9PHXvxO65hT47/uCFBn1MyNN8m5+u9K+YGIth1+Wy4XSfMYRHQq3Bp5OL/ZI7zNUP2QcWxtvnykgrLZXZMYfTZtKC4dmM7sdsNsxETU/mJq9VFlXxMNOPKNLvgLTgtMc5momHo7y1x6wVX/d+wAkuf0xgzxMW5ok4133adKVjJUgY64chdq0zhrn9Zqpcepm4m11zLn/fp5DuB649krfjxeKq2AHw==;5:44R9MnZIOxg2STiPR1yVJ1BO6ervQ3fhBDxSkg9z8m4pna9PIyyeNhKia6cDNNCq6gkd23gbe7yCq/grtsxF+A254creBlfu9bEgTtyBGZlpCM+pBslJgFtf169MBQtCawEMwks2DKh5iak/PUU9YH7OyminOSHmIlaLpDEJMw8=;7:seqLMJXUscFKnpZVE2H5ErlkN8GBYn3FEnu8EfpfHm+PQ84TwpNjwVqIu732Zq0ghpK2YuwaUQ7XXp0Jw3MBF4fzjN+oFtSJXsA3O/Q+m88/+Y0JiUB2Zw65LxxqgPKINdAzTpH9EDSePslucz64YA==
x-ms-office365-filtering-correlation-id: ac83a572-9716-45e9-30cc-08d664a00c6f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4102;
x-ms-traffictypediagnostic: AM6PR04MB4102:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-microsoft-antispam-prvs: <AM6PR04MB4102976A5435EBB20E2C497184BD0@AM6PR04MB4102.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4102;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4102;
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(52116002)(7736002)(97736004)(7416002)(68736007)(25786009)(4326008)(36756003)(316002)(106356001)(102836004)(6636002)(105586002)(99286004)(2616005)(71200400001)(486006)(305945005)(11346002)(186003)(6506007)(386003)(110136005)(54906003)(76176011)(6486002)(1076003)(5660300001)(71190400001)(446003)(476003)(26005)(2501003)(2906002)(2201001)(86362001)(6436002)(256004)(14444005)(3846002)(6116002)(39060400002)(81166006)(66066001)(8936002)(81156014)(8676002)(478600001)(6512007)(53936002)(14454004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4102;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aCvTiePjbLbAyk08w9s/7mSaypvs8541EydryMQop4IZ910YYI2s1hQrYjg8A69kXFKf0/ymq3nJTsr4nZSM3JF32Kj318jOmEICB/4+Dup3bPWmmly/G3ClPYFnW4sg7Kz+dbwLLw+rEzDNOtMm9P2n6uwWa3jQWth4BUWd26+xBESYvxFHqR9cJQdedzLXMtJt31juY8lUKXg8RAIQzdHsrXQuUm5n3SyDyW1XjhFg3gVtAttR/Cg3d905NvN2H5mQVnGzW65MlYkjWOsn2vcfGSy/sreerJaW9qblOuvLlM/+u49l9zJb0PHCu+Co
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac83a572-9716-45e9-30cc-08d664a00c6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 04:19:48.8534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4102
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
V3:
 - Changed back to get num-viewport from DTS.
 - Added print info upon non-pref memory truncated.
 - Corrected typo.

 .../pci/controller/dwc/pcie-designware-host.c | 107 +++++++++++++++---
 drivers/pci/controller/dwc/pcie-designware.h  |   7 ++
 2 files changed, 97 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pc=
i/controller/dwc/pcie-designware-host.c
index 33b5a3815d24..2d1dd3dba1ba 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -346,6 +346,28 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		dev_err(dev, "Missing *config* reg space\n");
 	}
=20
+	ret =3D of_property_read_u32(np, "num-viewport", &pci->num_viewport);
+	if (ret || pci->num_viewport < 2)
+		pci->num_viewport =3D 2;
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
 	bridge =3D devm_pci_alloc_host_bridge(dev, 0);
 	if (!bridge)
 		return -ENOMEM;
@@ -377,10 +399,20 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			}
 			break;
 		case IORESOURCE_MEM:
-			pp->mem =3D win->res;
-			pp->mem->name =3D "MEM";
-			pp->mem_size =3D resource_size(pp->mem);
-			pp->mem_bus_addr =3D pp->mem->start - win->offset;
+			if (win->res->flags & IORESOURCE_PREFETCH) {
+				pp->mem_pref =3D win->res;
+				pp->mem_pref->name =3D "MEM pref";
+				pp->mem_pref_size =3D resource_size(pp->mem_pref);
+				pp->mem_pref_bus_addr =3D pp->mem_pref->start -
+							win->offset;
+				pp->mem_pref_base =3D pp->mem_pref->start;
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
@@ -405,8 +437,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		}
 	}
=20
-	pp->mem_base =3D pp->mem->start;
-
 	if (!pp->va_cfg0_base) {
 		pp->va_cfg0_base =3D devm_pci_remap_cfgspace(dev,
 					pp->cfg0_base, pp->cfg0_size);
@@ -527,12 +557,12 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp=
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
@@ -566,12 +596,12 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp=
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
@@ -645,6 +675,9 @@ static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *p=
ci)
 void dw_pcie_setup_rc(struct pcie_port *pp)
 {
 	u32 val, ctrl, num_ctrls;
+	u64 unmapped_size, base, win_size;
+	phys_addr_t bus_addr;
+	int i;
 	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
=20
 	dw_pcie_setup(pci);
@@ -693,13 +726,53 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 		dev_dbg(pci->dev, "iATU unroll: %s\n",
 			pci->iatu_unroll_enabled ? "enabled" : "disabled");
=20
+		/*
+		 * The maximum region size is 4 GB, and a region
+		 * must not cross a 4 GB boundary.
+		 */
+		win_size =3D SZ_4G - (pp->mem_base & (SZ_4G - 1));
+		win_size =3D min(win_size, pp->mem_size);
+		if (win_size < pp->mem_size)
+			dev_info(pci->dev,
+				 "iATU: non-pref MEM size is truncated to 0x%llx\n",
+				 win_size);
+
 		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
 					  PCIE_ATU_TYPE_MEM, pp->mem_base,
-					  pp->mem_bus_addr, pp->mem_size);
-		if (pci->num_viewport > 2)
-			dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX2,
-						  PCIE_ATU_TYPE_IO, pp->io_base,
-						  pp->io_bus_addr, pp->io_size);
+					  pp->mem_bus_addr, win_size);
+		dev_dbg(pci->dev,
+			"iATU: non-pref MEM: win =3D %d: base =3D 0x%llx, bus_addr =3D %pa, siz=
e =3D 0x%llx\n",
+			0, pp->mem_base, &pp->mem_bus_addr, win_size);
+
+		/*
+		 * Prefetchable memory range can be 64bit space,
+		 * so may need multiple viewports.
+		 */
+		unmapped_size =3D pp->mem_pref_size;
+		base =3D pp->mem_pref_base;
+		bus_addr =3D pp->mem_pref_bus_addr;
+		for (i =3D PCIE_ATU_REGION_INDEX1;
+		     unmapped_size > 0 && i < pp->mem_wins; i++) {
+			win_size =3D SZ_4G - (base & (SZ_4G - 1));
+			win_size =3D min(win_size, unmapped_size);
+			dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_MEM,
+						  base, bus_addr, win_size);
+			dev_dbg(pci->dev,
+				"iATU: pref MEM: win =3D %d: base =3D 0x%llx, bus_addr =3D %pa, size =
=3D 0x%llx\n",
+				i, base, &bus_addr, win_size);
+
+			base +=3D win_size;
+			bus_addr +=3D win_size;
+			unmapped_size -=3D win_size;
+		}
+
+		if (unmapped_size > 0)
+			dev_info(pci->dev,
+				 "iATU: can't cover pref memory range\n");
+
+		dw_pcie_prog_outbound_atu(pci, pp->io_idx, PCIE_ATU_TYPE_IO,
+					  pp->io_base, pp->io_bus_addr,
+					  pp->io_size);
 	}
=20
 	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/con=
troller/dwc/pcie-designware.h
index 25604387d13e..1e87f18bc417 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -152,15 +152,22 @@ struct pcie_port {
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
+	phys_addr_t		mem_pref_base;
+	pci_bus_addr_t		mem_pref_bus_addr;
+	u64			mem_pref_size;
+	u32			mem_wins;
 	struct resource		*cfg;
 	struct resource		*io;
 	struct resource		*mem;
+	struct resource		*mem_pref;
 	struct resource		*busn;
 	int			irq;
 	const struct dw_pcie_host_ops *ops;
--=20
2.17.1

