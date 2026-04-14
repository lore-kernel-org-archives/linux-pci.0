Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020133.outbound.protection.outlook.com [52.101.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAFF31159C;
	Tue, 14 Apr 2026 14:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176192; cv=fail; b=CgB+qOVCpLHzQzVfJCGxK25afT6moclExouJ9aJZQJ8WnBbyTTHrGnWGW0kLtsbndSgxp5JuttpsAxIjeQdy677MTAMzuUGXsvuMbyszVAPCcpqulPnPPeO0khg1I6M0GY3nu5E5EFehVoAiGN2gsN4WG271THjGYJrZHzkOCUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176192; c=relaxed/simple;
	bh=7W7EAIrRY8jLga8ADH/lj9w0euD505H+9+XgdpG2QbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mHoTlxCaWeOFHLNpE/kAVgeR4AHTsM2pw6nxC6+nHZIvmVQU3ImuAEKioO4KJ1owu3qaE2QOVKV2vZ0wEeTx+g4jVxaPlft73EshrQHPIrj0ZoRoPB7L6cEsw0CEHwlzuat9d5zV27ueoq2lTp0SaD+4WX4qnDccQCULaTRJeus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=X1gOPnNq; arc=fail smtp.client-ip=52.101.228.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="X1gOPnNq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUVxsCvIpsc/7olVSsey5YoN3tqa2We+PACA2zZ0bmj5Qidm9w0mX0LVuh9CVePTAdhZEFHZ9rkCoS3gwjyfVGuRGvEKmF4hPfcKeRbXA/APi6RPI43MRFyoE+K/tX3EDpYYe9w5yVikfsFXvwTmSSdpuPBfmCOpWXCqcGStTg9r5wpdtkyT1YbUI/RxVAqUZKw0cZaTwadPEWTky9oSv+bfYE46AzqcORi07FqLn01JL9aFcnrIvall/p8SoKmgxZW0ifwP+NJ6ECj/tsD0NBbhmhvi0FbBlcjXm7qwS/QEMFkem7RAJFoJWUAGaHr1CULQ2U9tYPVpOuY/nibZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfCIC7CzZdwcLUlJhEa1n8/0yHBVwev+g2VgjAz+QQ8=;
 b=f/voevavIyofUZnd4+RCdZQICdnQamrppVfS9yR+PJAsYEVFgdMO2V4JV6RSCc/X9526iQQNjkt2PfPlx0Y1/5VQe9g+h+MV4EmmG6J9krRakq+u/x+yl0TA28Rxg3Oa0STzJ0JYQOwdWWfKreIU7H++RZf2/0SRMIEQGbzHi7FbbnHXw62Uc+OrxD44Ay8Jwyx/IgYeYrtDL6iRPLawBjgnirGjE3ro1P9+YBsiObnh7nG5JkJNjuS5Bjr4wuEdJneF/+5lRDfe5NIkv3sCsNg1N4RTx2SMN9YLSZrtmGjvhkL46WrhGDgDaFqhjawCFHeXzZ+7iQ7/Gbg5PFVZzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfCIC7CzZdwcLUlJhEa1n8/0yHBVwev+g2VgjAz+QQ8=;
 b=X1gOPnNq22nka587Kp0BG4RwlhqHveLw3ZDhJdiq2MXtjFmahRs6lZ2PyMJHMF1qqcEPz/rsrrW8K8kEVOA4JnvuVYCZngtMpcjPi5A4Cub7FvFJHBsdY9ja0G+VBu/WowJB8Pug2fMNBEJQ7xAW0IvPY2O92Al+mjkh84cOT3E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2529.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:222::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 14:16:24 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 14:16:24 +0000
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
Subject: [PATCH v14 2/7] PCI: dwc: Record integrated eDMA register window
Date: Tue, 14 Apr 2026 23:15:09 +0900
Message-ID: <20260414141514.1341429-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260414141514.1341429-1-den@valinux.co.jp>
References: <20260414141514.1341429-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0060.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2529:EE_
X-MS-Office365-Filtering-Correlation-Id: de7d6df7-3235-49d2-f180-08de9a3068e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EtGop2xaHSk3kzn7PvR6dqehgv5xbFHoVUuoNdJZsUmW9QtyArodHbWaTOpt98ZsPZLWUg4kTGNdvqj3hBxtgaTGH8DLjq9sfgD26T0O3JTJcEOl5GL/CXDvuMQxyqU+GVI57rCmdVbBUsM/VTrD9NQvhVmNTJtQ8mF5xrtCr2lDG4EMmk06JMG1Qe2KWg+UQr2JjItkvf/q/SxVTbVPzyAcWA4jqh4wZqgGG1uCXrtA/vwhaJarKgfX0N9Cjr53Z4Mv5hzuYHzJQmSj2KL5Z3czVK+7L/Ix2/pXm+yl9b8zf2dkMyV6wV6jVAc8+v6NnreWCl+BnYY2V6Hv/fUpg1zno9Bt5VD8AMOMWI6BrXryTOUWb+Q5GHAEAq5SOdU+iVyLBL4dxpGnaeHos0JZbQMvOEIQn56geNhCRcFv0hNnfZg0RKbfNfI0oUySd/SSbD04hLGwpPgYBBghaggSUofBNiNhFLRHUU7a4koPTkoxcvzTotZsv7uM5Wb5Be7+Af5XXCwvam77/S8SHFdBZxZh0dPl9uz7X7DRESECb8/6R9D0/Y21P1fvoNoTk/ciPrtiAjlbfPlVyrjtWVulCqLxGYORYIuNtzcXZoTPsrYSo+W/3BgcT2VWT3QyyEWhu+99aaRdbytMrlySnYKf2/PKKIpwNtHGLO45/vYA+PnhHi/7BQRVoTRDSJgswfs//5Sqp+865nNDHmAJe5HBZZQBHpT/Pq4NmqD+yqQorEAC1a9Z9E59bP0lc9M+Sn0tirk069P9WKVCH3dxwDVPPQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kZLumd3rLHIO7KgSglzfzSl8p80FWnjfCCcFMwZCe6UHkjAIdznXnARPaKif?=
 =?us-ascii?Q?00gHI9zpVssNVZOxsE+IuGOkRzy2aEWhMxrr1MVbHlEufYPZ4mf3zYTv79fg?=
 =?us-ascii?Q?SwzEkjTVzD8y6uVK2jbMBkbHNET0DKJqhP/z4xKbCjPDBx7uTh6RC/ZzbUZ2?=
 =?us-ascii?Q?j50IUKOI1Xr6A6PmrylO0y9xV0xNrHwjAxN3bqQGNLhmB3/9p+Ylop1EkDcK?=
 =?us-ascii?Q?cHIT2NQ6+39v2teKEmO/+QB+nFK60uXc8UfEVRHWByey52nmeXUt9oCSl4dm?=
 =?us-ascii?Q?woInpO+v7JADn2/jRIFJt56U4pQcDUdBdKmsJCeXduOFE6nVuQhqi0ycmlq2?=
 =?us-ascii?Q?JLiumetHVEOVoZJDu99GVATCMN7beugfiHLgIum84cYwT7gORY6YENKIjbaL?=
 =?us-ascii?Q?GAXnCEJ5GD+niIOK6K+URlwfNPO+FSgJLM1Sz9Oxl2ViOQp3B/971nl1TTx9?=
 =?us-ascii?Q?tyNZGeVnzVq4Iy3+oM+1aIesoCtjIhpl8L1VTw9AwAt1hmZF92kjcjp4b2Hj?=
 =?us-ascii?Q?kwYemvkBrZsDOw8zQ728LfMs3wttvfVOcA4QjxYrHZxpOKchyujjZQfq3rJC?=
 =?us-ascii?Q?zMI5RQRMN2iO5Sxj92YESJ7m8h7sfMXVc/xWzNt6p0OgtyNIeGt9GxsBo8oZ?=
 =?us-ascii?Q?bugXheSGwellfeshHzu6MRawAZDcl6XH1UUjr5bM86L2puTfgKonm5nahJk4?=
 =?us-ascii?Q?3/QL3bRiVGE3xrQ+3PZtuRaS35MPxcN6BvIist9hYfihiHSni1zImXhBxtYz?=
 =?us-ascii?Q?sGbSJ5vWcNy7YI33EDktqNw6R8TvCo5vXRvAbPCbfhLJeI2kYgLRVbGdAEKt?=
 =?us-ascii?Q?HGP2PHHr6EMSWrPSKJpavw8oxYgL9/3H4VthwLx6LlMtpsvQjGEHJxI6m32S?=
 =?us-ascii?Q?A+xu70idoJxdiFS/Tyc/1F+mtIWBC1+lBjY3Pl0n3j7aQ+sLGyvmiPuX1W+/?=
 =?us-ascii?Q?qmhYToAcRRB1ZWebb6gGQo+UPJhFLAneHPBxP+ZlbUpV4xARpPXHVIH7tEpX?=
 =?us-ascii?Q?Gd8jVhKMy8LHGa4oYtHrEv60zNL90IN+KTtyptswRZAOQuURFVwFT0zRSokw?=
 =?us-ascii?Q?EZnetwhTmGuA4P/T7BSSGIPNsDYLpBSklEj+0Sgcn8UWJCcWH9EYwnVnIpJ8?=
 =?us-ascii?Q?ocmsHRYMi/OT8wGc/+RzsDSYJTLd8Pp1K1Ka1a1o5tO1/Xy1JAEdJetFxTqs?=
 =?us-ascii?Q?WVkv5r/+Wt/eoFfVMgMCFULPlXqOnB0gZHJst5AB2f44aVzypQ/fcia/ZHoH?=
 =?us-ascii?Q?SFSwpAhWF9z7oa5Vy6XEAkebmFsQRo1oVbt9lGiDf/QowPgXfhtuPPA/B2ax?=
 =?us-ascii?Q?vh2+7sh9APyhc+37WSMq6UNgvS3Rgze3f6kaS37Z7vspPO8GzfPNduE88X0r?=
 =?us-ascii?Q?kLg/RWYAwAb8CwGOoMKfVUG/TJtkrrjc8J+OLdRmKv3SGnc7hCapVsU2ODJp?=
 =?us-ascii?Q?hmkHGrylqm39FqY2lLNn1YenFHKzD1Gk2pROxOPs87yeEdb4Eu/R7trmMWAK?=
 =?us-ascii?Q?MeO9mgRuNA7JfHhq2EKrijtqCFTy53dsaay8N+ZNr/eh3qQkGUtVsX8ys+Vb?=
 =?us-ascii?Q?2fgIM3BVwqJxsFIc0TkXj822Me43kb4caF9qDMLkoQSDMHiox10J7ABUFmX7?=
 =?us-ascii?Q?CeEnjsMLZF4NDelmk8ihVCUc5SZ3Gf5QEY96uwudreeVzmp8x7t5f37VEoO3?=
 =?us-ascii?Q?3SJy3GHEQuJhsXgNMA3DueW4tduoQntDa8rZJSgvlGYDYDqMiQ07rB0WYymw?=
 =?us-ascii?Q?yOlOUZEtDrZQYp8jxM2s+drZNZv9Fum8UbvvH+r7Suy8ZWO4NmvB?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: de7d6df7-3235-49d2-f180-08de9a3068e4
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 14:16:24.2616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZHtga2G9ll8a5LKlBzo3WWdUR2nQyStXA7aZKTHEX6l7BjDjBeoJhZ2iIbSZYjZ97AzWNHSY5wys/JPSy3Hgzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2529

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

