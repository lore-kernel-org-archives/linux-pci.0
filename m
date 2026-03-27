Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021142.outbound.protection.outlook.com [52.101.125.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3845D36C5BC;
	Fri, 27 Mar 2026 03:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774583673; cv=fail; b=P9EpfArqxtyIP5bL1BQIs6ARvyfTn4vtSlHWGveF/SThssNTCtb4XVGoUCUt9QnT3tFgZiGY3Vwx+/GXgqQjhQGfN6ILJ3xZBMxSByMMFsFsttXgYVndQjOBpe/wFgpgi/nmEmVVBDVVmSRhCQP7mPGJhBhqokpu8RZkcxWgrrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774583673; c=relaxed/simple;
	bh=7W7EAIrRY8jLga8ADH/lj9w0euD505H+9+XgdpG2QbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dyiw9xdU2SkrSaWj7V3KNyiQjbsL/cjJqAKRsIiD9XGkro9g5VPKg+FNe6naj9IUnG2fuCiKYmg+8vIsMbRja5xUbSyy8lTLQTvYaplaEaxnGK9bWSzQx1cuX4JkBbd/SbbZFKhrIVAyCRIQvSnnlaG6vZKMuQ9Xo7c6q4CCmZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Kvgu+wLd; arc=fail smtp.client-ip=52.101.125.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Kvgu+wLd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=teETyLYKLKBI6AiIEalzbmQ3gZ60SlF3JFnJTprJa0HavYuQ6BesCUpX8Ix9iLQaSWFzdDBpK7gZ+6LV5yEbuCyghDf0N6+dhjNKJfJeURsVbG4bewHzWWj4NGyCZMYOJlCceYUtbB1pqVOzZuco2nYEl5TCdXIDC36EHT/u00IRAwZu/YL3ph7j/+eZRHlKqxHRRnXgOslxUuDgTjTFe/AzYQA8x6h1wp3QKWOTqsOrzOYxsUB0PbR8lXOc0kam31fonHCQ6aouC/Eho6dcbJdOMmnC8mcHFxgmmCvzHxhDgVrZhoJ1iXblU+MK9WIwMhDMbWiCu7oApUo24mmV+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfCIC7CzZdwcLUlJhEa1n8/0yHBVwev+g2VgjAz+QQ8=;
 b=T5DsGmTIXQUBmcRtOMPhWUTHXCKR5q8eDVfiV/34FzUsbdKX/suN5q/jy/s6CYXDpwLny8AWyuXdp88+xK0BrAqGO3a9B8/YxgZmnzKeSzmQGwDtKobHPjLr+LSbTmiEBnE7nybSB5lNlI95Kr8rtzxqbkfzNrq749EiuphfQFGKqcDlyC2lu70Bzu0OiYM0zQ3UO/4se7rmc22B5cpat3x4/M/KGyGmWAlvYUH6Bz/cRi0GdAvZtA6WUUD3vftJBwnKNOVgXaNoDHIhleyLQJwDLc/mV/C3Va5+uGWlbULGrcEnipb0rW683byjO4M0VBch3J28GZ3bHTyWBvy5Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfCIC7CzZdwcLUlJhEa1n8/0yHBVwev+g2VgjAz+QQ8=;
 b=Kvgu+wLdkRyI6qilvvn0IXM1W3V9ftmUfRKHQiWBAnniH98ZwEAurpIVVdNzabDikeJeIrZ8+eA0ZRJTdWm9EXtKhin1r8gCNaJuvu2n6s9ieuo2uUyFI0t20E0j18pv/Y4XcIvDPWYjXDVWLt0zPRtrgWjcZlkd3WhtSRnZyG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB7090.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:323::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 03:54:26 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 03:54:26 +0000
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
Subject: [PATCH v12 2/7] PCI: dwc: Record integrated eDMA register window
Date: Fri, 27 Mar 2026 12:54:17 +0900
Message-ID: <20260327035422.4020455-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260327035422.4020455-1-den@valinux.co.jp>
References: <20260327035422.4020455-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0019.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f5e902-0219-4e59-c13e-08de8bb48a7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	s2PWmoHP4pHMo2abkEXldGK+XNPqLmXjta8gBK+cXEEu2QCTkoa4O6UL2U3RQiiQpR13xBZ4RlGQyDXJkxfjhyevXNpAsrytkSEc4N7/hPJwZXFbvpJikEwhivu9csIgFPEwjgU6Id2O3NO12+GYWkxm56HixECb9eW5d4nsM2F5ZfwIHzhB8v2bJOdpboCE0uRXI+Ux1VoDk2SeU0IZi3FHZdOXelCysblg7+Ztr2JFt4UZ7MOy35HtR9bSr6xMYEVyx+8303vAd5zvwwrHOjrpKZm+0cH1kaZsj6pTdbn/td9WfSU3pC2WVoj1Ldq/vZr0AeMKg1vAugveYd7lWX3ZDHg8q2hiO8HXdAzYyRKb9Sj1ukqGdNM1idnLqg5T6LdRU1qr71gWOuIkgBR8HTb8r+wuqUq217YURZfOJ5fZoB6rMRrK8OuJCLyBDErJtE6JgoUtiAP3cfMEMhpu6e3xdG+p8+asADVz0+YuQ2BDCUjtcCKWZ7rwCEx2FGnrHh2hcnxoGdrVjXoxnCXq+w1qWTNobhkDVs4U1pBiWY+KdJaqejDutUQPtOOfM9Qns6ciIvecrp7XqFkC3RVCWfpQLrh53aHjM/WfbvMQ/ulwctu6WtrtUOJoSygB7mi785Tz93x5iNwTC9egP23yYdjkWqBfyKlzHUiwLoTj95d35m1FA7HO2EpWQj9n3DC5XqQNW3vtPwWthChOCIy8tvE56ISKyj3R81M0+k3m1oAH8GHjIU3LFrIbonuCkl1yHMfP1kRSY6Kfv2gIVhPKqQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MGlMqALBgxHs1eEs8Gvr0HQldrT6ByfYHxqJAPRLe66wKEWuksd/iNHax6Hg?=
 =?us-ascii?Q?EECVz14ZudaPe9ZaI7kwjJFqwAtmZyDhVSiIClEHnrldNeh1Sz5OrkSBYbGl?=
 =?us-ascii?Q?QzMP2u2QVlY3IjMz69ZMrgqq9VScpyh7xyckFp35IwJYIZA0pB1efru9bO2A?=
 =?us-ascii?Q?ii4myYEo7Q8hce0CGwn5wSVGIQnV0g5jMB3nrPAZey1GkUPlR8VfApk5uYdv?=
 =?us-ascii?Q?IcRAsnGGHjTjOeMdwiASE04kPFzi/t0a7woQlhr3b9JRYfBiejJLdQ1a87sa?=
 =?us-ascii?Q?oVQddv7XGpdLCM3BiHN+ZJ+sV7d4l25DdrlD+5QlU8xPrfKie6SLV9vuFE8v?=
 =?us-ascii?Q?YWxGIgmaPbgsF8OHV0JCT4xMF5oUNykU1xQRToM9VpJKrqWK5vroUfHILsup?=
 =?us-ascii?Q?mWOl3L8FFhq34M1ICZdZgf8rKjaAXoC0dHN64qUqcZjb8EcEGOzqsh8o+cZW?=
 =?us-ascii?Q?ePuSu6SOBWk7dHrYK8mVYWUJ9pvVXwvYz3orsRSzhoq0yI8f8IhXJH0dPudl?=
 =?us-ascii?Q?yfxAFyOFjplDBO93IXS8eSRlyrgavEUDNF+AtTd5Sj40de1AUSI40GaB6clL?=
 =?us-ascii?Q?vyP3jY/d2yrLJQpXvxitT3ZHstE/RRzcFxVTVjysgpW87MdSELHw2QAaooOd?=
 =?us-ascii?Q?YeVEXp0WFMieiSv0kO+WV0Ng9kGFUL6fG2cNzSn+ZKsrnydKVYXJSX0edv06?=
 =?us-ascii?Q?TiP0Hicy4E33GKIELIoJrhHA9Vj+HFCS+dU35gVy1xzzEKfq/RrWMVkl0tUh?=
 =?us-ascii?Q?mXBDGp19TwT0AOoNfL1YGPaXi3DWw7gy3pqeU4YNt6KhvPvU7M+8raGyQvLO?=
 =?us-ascii?Q?20j0m74daj36TcoWmAUN613MsDAyUX4pxSRIT85RreGa56/tp8sKwISjIgE0?=
 =?us-ascii?Q?8q3UK99w9xEoJWZVY5Ncssqie0OG1j7gGFRORJayLz4Xq6HMvKvaGQumhVfc?=
 =?us-ascii?Q?l8rbngoNlPIhZh6Ai7GOKufszZXdMyWji18fdh35LHBQLPP4OYkp1RQXykJt?=
 =?us-ascii?Q?n+yIAqUxQHq9/90R9fWvBzvLcir355anxWJ32oTBMDpQrZjZTYJlemDhHzDD?=
 =?us-ascii?Q?GBW1Etk100gV94m9RxBp2jciN45tAUNGD6eK75CXsdFWfhFMfVWRnAvKV38Q?=
 =?us-ascii?Q?cZjw2yn6WyNrfqwSQ4jnDo4VBhuKDh0I6MyTYVt5qnVntJ5rzESCw3LS72O5?=
 =?us-ascii?Q?rJVHIQiqw9OOHDkaHVZKZvz+/O4rAka91qDKEO264zkxMVPOmH5fZvOUNAO+?=
 =?us-ascii?Q?iiukOuqTjS8uQUBQf2jV8jbGcOkavrZEQxP4KPLZSiN1HRmmJ2ju91CpQ+N7?=
 =?us-ascii?Q?a6bw+XdMDZ5wuszZ+WmLwY4IHeWQPKj3B5IxfEpVMH3Ppby2F66n00P6P7Sd?=
 =?us-ascii?Q?AxsRQNG409XsGHmnrYR6QJJBpSK3m7wQAbeiOX7QEeLPHxkFiDcBRgpHze3b?=
 =?us-ascii?Q?jJkadvPr1ash40cNr2eY2xG4yjEndwrZ/uua8WZriS3eDnmhD72nuYx055GQ?=
 =?us-ascii?Q?6n9s4+NRjA/ydHDtt9rNNoqWRCLC6Q2paABbg7EujuEXv/faBCZIBJNHsEHu?=
 =?us-ascii?Q?XCS0rnn36PpoBUACT/T1ybFudOUwAE7s5BWwiDUcby5WqZDvPMrcCBO/SNZ7?=
 =?us-ascii?Q?nCQyr2p2rbAHOPw8If6gXiRR8qkmOzYXvE1z78f5CR/mmt6G6EovGpKXncQs?=
 =?us-ascii?Q?sWQdmkMeAltQQbI0n8fruIsDpk6oIQe/LgcjiiQ+njs5gjgRgxWfMEVX9dZw?=
 =?us-ascii?Q?MGms5zJL7U7QZgPk/EMZgCtp0vkcRjqLyikEz7YfAy7i0S8Q3wqq?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f5e902-0219-4e59-c13e-08de8bb48a7a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 03:54:26.7476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wY/MP4J6njkJIqg6tAfOn9yP/V3oZ8tlSYqa0Ih75vkrE2TY36KqEHYmKKSU9qUxv1ba+jgYaw6ndm0yzIcSUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB7090

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

