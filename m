Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020122.outbound.protection.outlook.com [52.101.228.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBB233B96B;
	Tue, 24 Mar 2026 08:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774341515; cv=fail; b=i5gW+xmUkmhtLNmWD3DYsrWf/ELa4GUYpAIW/eu8QhGwlo1SYrH7oivyHhUhxklSamEm/D31Rhdwb+gzvddTX9LhAc0asaMYZ8oRRLqzC4Rvo5fUax2/yynYYSjJ++PtpXATdpsVcKRNK6F2CGZg3a4uUwsnFKsy87xkUEeZoZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774341515; c=relaxed/simple;
	bh=Hd0OQVvgV+FRrpd5o1Ro3HiWAoJB+zHoECF/fTkrB4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q+oO8i/55mDyRu/BJuh6mnjupoEXEN9z4epQNuxyIXnZOqb6cBgsR88cslTFVNtBeIG08IWdfTqwAIFFUuZcC+3Pk0/UBLVRzhF5XIqCuKkygIUxbtYFhHRa51x4rqaMwSXHt9Ly+0LvEFQZAhsM2vj+Kxa+m8DLxhikD+f9MuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=sU4qNLmn; arc=fail smtp.client-ip=52.101.228.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="sU4qNLmn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sx+d+i/gh9qkC2hk+P22qoda3G7nNwqXAez7MT/sOM3bExKzIt6DDPjzz/1W7yMsO02Xi9J3gkmnRFEQIC71VDVG1TtKnWYIA6VbvArNjSqQmXxWoW8zQcd2MeVgQjnt7WiT3SA5tQmE8eGaTXPGvpr0SsJ7BOeinjw9xsjdmNB3ahyHGx3N0bOcbm5pdR1iS1q6+ERQ7T6sEA0ycUz2mnt/f2BUL5NyC1thDH9npWiM6nnxdKywdsTd7aqyfR5G/iMRQRtvWEjsHP3/aGDpQzK/GDcMSevaoT12cImblLneBopPQIBH4PtTFk79qz9WbwtCuRCDp99C0mj7rFAtWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5uHtBMuSv0SsYrCxx5y8gccqSa7xSRgUDGPhiUGDrI=;
 b=vxAJOIRGUGFipkG7bhbknhpPDHZYVbUwj43mX4r5HP6o/Ss6Hnhg8DiskIC00pTzGhTNFDddTCM0gKp2SWbu6fXp59yVFTgF6lhzgO9rum6KNMDg0hJ0kTshQ6OHPnup0rnFGqdbzBr19Fuv8hkZQDMG8cOfq7Tw6l7h81zE44gKTJqeQZ+iKIs8K4WzDMPj4buyYUtVKFVrjbqpibtLtqSUfaVUBB5GGc69zn49UyNrrbPyh7HK7CuhL8Xt+NAcwLvVwjvj7onxooWab4wh19te8i8lsaoMimtigtCzwE3tstC61k/5tZzwbp+tNSAlCQMxbV7EOpZbNAgtoILaGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5uHtBMuSv0SsYrCxx5y8gccqSa7xSRgUDGPhiUGDrI=;
 b=sU4qNLmnqEJzvg6sFyGC2Od9/lPUjrf61WVAfO+abpqbE6Z8FSeISclrbLYCKcdJJVgKuMu0DevuikP0u3NvhVroBZr/pMksdLZxpyA/2xSWyDuNaU4pv9o6rIcORmxLyn5R4kLI527+UOo6ZivArYiaN6/6jp2nE5VjgAgFP7Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6981.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:414::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 08:38:18 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 08:38:18 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v11 2/7] PCI: dwc: Record integrated eDMA register window
Date: Tue, 24 Mar 2026 17:37:23 +0900
Message-ID: <20260324083728.3744734-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260324083728.3744734-1-den@valinux.co.jp>
References: <20260324083728.3744734-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0018.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f4b2951-afe5-4ee9-ed56-08de8980b2b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	z2ejO697XCyksM9TQ+kxAmiglqtfktwEARMjkGGQQngOo3PJj1CyseXTjD0BzWXShJWYw2FcstLm3x1PEFnkg/ZQquqO6VWsmq8b4SrIRmum5pndoDoUlGqtoF6IUy14XxaKPgn5JVrxmCGe+SJIeLxiKXbtsC0faq9PGNQLQXUdTKTCj4hSWVQhcCE6B9ucgs0jeUpI30AmVT3QyDsFhwAXe9mIciOGoONT0FG4fuYygXf+vN3+/IumA7C7t3GptuIUPdT3W2SXpjMw8UTRLfch+a1Kgv7UufjfrE4SUkKjYMBj7x10Pgwllbhqoe9PcekFwSZzSoj+qAIXmy+7lex0TWHPhi1yraLbo0iVjx2ypb/k5msCNAGLQIuhfa9tLx3hl5HE7ja7KJISQA6HIklg84PxyD/mAWOGuRJNthztaBGEaql41D8lzibLg4N7Rqpk6OZf+3KOlkpAM5yyP7L0pW7Ao6YriBUKaqTMs/Vk1QWV2ShdADyUst5rE2dV4J/n8gvtgCi/ta8IkTdZbgAz6hyD/MyRMq9PSZowgc5H59fvsl4KiWXdoPrRsum1QRe9kjWCjeDoVrZ7pMYmS7PcTJ2Z6hKANhaNfQDVP8F2uLvUzjZ+dv0gtNPh66JI00ztbR13wDCR68eUCV2v9gfubiN8cd+R8TQRRvwEYcpLUj207tSsRgtyg6TyzKUI/ZKRZKrk9bFQYhGTk0tmIdVV6z8oqx/uYRl5plr/gahAvu214iP+FVWKAHpD4Cx+p/pXiGK2a9sq4M6vfuxGFg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JdDw/SqcGeMaEqHM+kc80nklfGeXyytjBrEE2JYkYmffYVUSSVVMh8VFitUG?=
 =?us-ascii?Q?CDLUoXq8JlzcS5wYtIhx27nxiE3nIhtOgbBM8v1t3IxqDI3/TEN1dR3x6f1T?=
 =?us-ascii?Q?PkBz0T8O55t2ZnLvC7PMf+aZjL6EhbbCEj4hW8bYOj6QO4Jwsyp9O+tW+i0x?=
 =?us-ascii?Q?qsN+5ogp0LRyyrY+EFjPzX2Lrk+HDLUSvHT5GidXPjZmHxxNkCHYWlCk3yzp?=
 =?us-ascii?Q?Y3WxWqs1Gq/m2MXZcK8N+N7Ms+HJOwFKpwbxtg09e/9Uw8iXUlmeBh1a+fo4?=
 =?us-ascii?Q?965rQ5bkaLX4aQhB0NVOL4QDtNShf9Vr8Lo1/H/jdHy+utU+g5zaqw0+hiED?=
 =?us-ascii?Q?cog1xfJe2/eVO0/xjw/m3zNrxH55ScV3IBs/LFNWf8pF4sHGD/OcYAYw2jW8?=
 =?us-ascii?Q?QkG8u1CuXh0PfTDedExKLj69C68lyFy1LLr0ZmZpxt3Uq7U+AptHjrEoAj1m?=
 =?us-ascii?Q?heMVTZC0IuSc6kUkcARB4f1UtL/geQvoJs7kcFc/1NHzLBVm0L6zJBADbZMe?=
 =?us-ascii?Q?nhlczT2tJwCwlX1NoCXnezFlx5kQYlZi+UCPTstk1UjVtwYyxnaQJ+14IOn8?=
 =?us-ascii?Q?0OgZV8I4sUcoOaDbWdWh3NsFDN+d6/sYVSZ7aUaUR7s/izZO2pyF0BpYOZ3v?=
 =?us-ascii?Q?vyi0t/RmYLUB57b/3/UTY8s4PDDPqvi/4PJLKlo1KfScG+LvGMnGwxM6Tq7I?=
 =?us-ascii?Q?eK08hluU2mrAUpDT34oJpsXa/mbwvUKeZ0XwlcV0YaEFslSt1zIXycS+pCzf?=
 =?us-ascii?Q?k03k4HgTSXIFcXJDTF2TEJhZ5s/Mp0kM5CyLyFd+d2xXsJZleLx0fwd/F0FX?=
 =?us-ascii?Q?vQyhrtEfsNiM7ggAIg8AWpkpvx0LQqXeISR16W7NquFMRmEK5v5BHbSPrXuS?=
 =?us-ascii?Q?CQb55eWYvfgp1GHbEPgCMetz6EHNb+FCr7KcuNTBa7fa+8mfLUPIjppA0bf7?=
 =?us-ascii?Q?5/Wkuy30nlSpeWWoJXEibQ9RHRNfrFnzDjYj7UvZhj+9/HZaULQ3F5N/IzLA?=
 =?us-ascii?Q?fCIFZMfxWC22wQcliXzkeQUhOOdVQoXVQ1p3ZSey4k1FWoreJTtwnC5hlEXo?=
 =?us-ascii?Q?rNxNGRLkrNLKbpndYPHkL4nc73TCXwn1Gj3xdmgH1o8Trex25t0SAsMJL23E?=
 =?us-ascii?Q?mTqnrN5mlT81I2gR5X/DrkHr4d2IYFUTW6Vf3XLutT+Ya9ipktG11YdK7kFS?=
 =?us-ascii?Q?xbLP+Q/cd1Rky+SWztUROLghuRXTherbZBfDV1lo3X8JI7glFiJL9TfTDXLm?=
 =?us-ascii?Q?ttyiM0wK7brKJI7gq+ToebTCKeqPoR8h6A6mEECxoDFjp5lZjr3nW2O1S3kz?=
 =?us-ascii?Q?WL4YO+z51qnj+0ty073sIpNI7t78vlOI2Wkk6LyTeTsGyMzfh0OLcPVximd+?=
 =?us-ascii?Q?OLsPphH5VoS6tsLTXcIfVHWFr9gGc43sxaLyAmcuZ3sqGChKbfR31MuRIMvb?=
 =?us-ascii?Q?r5CBsWpz7TnVEKkNyFSXwgjBMblGuiT1538QPN+SjVnECxbq9FmP+50m8Ft4?=
 =?us-ascii?Q?UBLp9l4n7UCmsrvRHHNRaeiuy9DA0B3nqFYR+yHH8CtSvKtwhmtFA8RuGyvP?=
 =?us-ascii?Q?JFk4a7fNXJvYK9DowmAVStm9PhrgwMIaCH1gFM1g+/E40/DplUOVaokfdRZ/?=
 =?us-ascii?Q?gFPBh8B+hpHfj3XGvuiru4hRvE0eE9lUzpqvKDpNgidRUK1rybNf5glzpOOL?=
 =?us-ascii?Q?i1XCqLyvUrhHNEm36wwQgBtTIl/+0+1rJvXUxZl4adQPygL8oxQpOvbl2Cx6?=
 =?us-ascii?Q?hPJvz92wLAOZmwSYTQ9+H23rgZw0gt/58p6io8p1IC9KjALNK618?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4b2951-afe5-4ee9-ed56-08de8980b2b9
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 08:38:18.1103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZ3lifSrKsEUxc11T6aOqdVrKYQWz6OrJcTRd6os9lIhNKIflY2zEiVqwn5vQHuCy/YsasqsRWWxCIihEjkgpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6981

Some DesignWare PCIe controllers integrate an eDMA block whose registers
are located in a dedicated register window.

The EP-side aux-resource code exposes an interrupt-emulation doorbell
register (DOORBELL_MMIO) from that window. Its location is derived from
the start of the eDMA register window plus the doorbell offset already
provided by dw-edma, and the window size is used to validate the
computed register location.

Record the physical base and size of the integrated eDMA register window
in struct dw_pcie so the EP-side DesignWare aux-resource provider can
construct that doorbell resource.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v11:
  - Revise the commit message to better explain the purpose.

 drivers/pci/controller/dwc/pcie-designware.c | 4 ++++
 drivers/pci/controller/dwc/pcie-designware.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 5741c09dde7f..f82ed189f6ae 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -162,8 +162,12 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
 			pci->edma.reg_base = devm_ioremap_resource(pci->dev, res);
 			if (IS_ERR(pci->edma.reg_base))
 				return PTR_ERR(pci->edma.reg_base);
+			pci->edma_reg_phys = res->start;
+			pci->edma_reg_size = resource_size(res);
 		} else if (pci->atu_size >= 2 * DEFAULT_DBI_DMA_OFFSET) {
 			pci->edma.reg_base = pci->atu_base + DEFAULT_DBI_DMA_OFFSET;
+			pci->edma_reg_phys = pci->atu_phys_addr + DEFAULT_DBI_DMA_OFFSET;
+			pci->edma_reg_size = pci->atu_size - DEFAULT_DBI_DMA_OFFSET;
 		}
 	}
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ae6389dd9caa..52f26663e8b1 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -541,6 +541,8 @@ struct dw_pcie {
 	int			max_link_speed;
 	u8			n_fts[2];
 	struct dw_edma_chip	edma;
+	phys_addr_t		edma_reg_phys;
+	resource_size_t		edma_reg_size;
 	bool			l1ss_support;	/* L1 PM Substates support */
 	struct clk_bulk_data	app_clks[DW_PCIE_NUM_APP_CLKS];
 	struct clk_bulk_data	core_clks[DW_PCIE_NUM_CORE_CLKS];
-- 
2.51.0

