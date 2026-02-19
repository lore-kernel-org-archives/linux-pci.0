Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021087.outbound.protection.outlook.com [40.107.74.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734B22D3ECF;
	Thu, 19 Feb 2026 08:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771488812; cv=fail; b=Y08V1WHvOciHE+q6avZHwLOVei6r/2iNPf5fBrN8F+qztI/kuGlUVh/eimoHsGOOdBjYitTxe+/XRUlSB6EBLZvmHt15mMaIbQZ5SpMEt1bU4ydpaNyDhB92c7JSmdCTgPeBFuADHw8+RASPNqDdFTVliHcg4MxBH0Qp9F7Kv2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771488812; c=relaxed/simple;
	bh=yYPpkjnhy0ZFLQ37LXaMIFbOH9NQvFdbcGMcU5dJDEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=by5TBOIumGpsgRBO8CwiiFPB3DbgFhLlJm4Qnq4VgQSNH8xosQFRRMz8oUyiU98eLYdKH2+K1iKY93KswkyjdXeyrHI8Cbp033KE6TPe9D0NE8D9OdlmwBY6mU4NWoEhuJKnNqPv2IELM0v7cZGeZkpE+bv5lF5z6H6xfQxphp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=SI1NLZsA; arc=fail smtp.client-ip=40.107.74.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="SI1NLZsA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNcR0HtBocgKC+xz//ex/UO5Jzf0L8Sx/23c52Fz4yAzXbuhRowc4akxrOqHQIqHfzns8NedACc50EdrisV2A1h6CL/FAUZxw84pfZ4cmuaNKeuRU7Rs0Gp8uSPdO4YWSjEJtPVeLyUfRJUlztc9MLwOEmz7E5qfoKBpEXztOQmI8caj5403VrUOYseWHVW87EstnDAtOBcDucRtTrO3XWrtambNHQFQwnWcKnC1feS5yDzRmn9p+LEKutnGcGwvUF/UXDPkn5U7adWHTzT7ukJUwqjWnML1NzHzmLAreXq3McqCU/LnbsI5ZZoRvzDxKBqhPHsxeikb6Zwnoa6smQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpMBWHmKo9m4Bn5DsWqxUnKAG8hRFfAVV32vx7GzjJU=;
 b=yekgu+820UJ+ctR1eYCJvKBM3MN68Qs1daBdChGFrFfdOaDp4RWLwvgJgghbAiHalupOY30HO8LoTyFKxhu0H0BY2Ekb3B5boBX4oeCkPvVnnusb7NtB9pr2ncIrK+u6loJZomcQ0n/o/HOkxFW2JNafUID9EDOwuhAQ6hGVZr6JaPeUEnB1KGKTXP31dQDbwLCY44n5kKDK5efHCF0DzL3eFD28vdh9TRCoTGBS0h84OaO5OGYDPyNymO5Hi/wUXQW5mdF4x/WV/TpZKRyWMtvZ566BstRYX19Al0c5kmvGKS71VowIoSptMGgAvIdZZMyUpoGl3AW54Y6omC827w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpMBWHmKo9m4Bn5DsWqxUnKAG8hRFfAVV32vx7GzjJU=;
 b=SI1NLZsAyqs/we7tespx1cs5m0rt6KO29Bm9Is+SO6DaOK0zBCOOeUQrbwAdyqvwEPB0EjUkkZkaB5Y5XL5hRbV99SEGegUASsfrW9ky54knt8n1n5C4/gaMgMRzG9uDj/hFo1SnfprL5mQWpQZK87sGZ0DajPhkqhPLTlY5xjE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5862.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:2ec::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 08:13:23 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 08:13:23 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	kishon@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	cassel@kernel.org,
	Frank.Li@nxp.com,
	shinichiro.kawasaki@wdc.com,
	christian.bruel@foss.st.com
Cc: mmaddireddy@nvidia.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v9 2/7] PCI: dwc: Record integrated eDMA register window
Date: Thu, 19 Feb 2026 17:13:13 +0900
Message-ID: <20260219081318.4156901-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260219081318.4156901-1-den@valinux.co.jp>
References: <20260219081318.4156901-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0333.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c3a65ab-8b2c-44e6-9fb4-08de6f8ebffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vn2Bo8o8F2HLxs2BnFYvEakXQYQs00nmbkNT4aNHWwLqBfMAoacO1imZFChM?=
 =?us-ascii?Q?MlXwqlgyaGM+VdBvzEBj1N8gTofFugGwA5eC85mcMNNi2W7QlRgKB7M1+iMt?=
 =?us-ascii?Q?71vlcT00QwpJ0qCU89QmqaYdulgSbbaN1k3PZdvQGsAsQkS5JxOOHWigNcjh?=
 =?us-ascii?Q?qFlGDBibBphFY/A+rihVcKpBEc2RLk+jG6oqpKbsqjtlIIlmpTRpy37KssOq?=
 =?us-ascii?Q?9WorwBk62VgBtNbKGMUBfJoyi9iyrvMiXiPGiO5VO9U8BxD4ogHZXx6bc4R/?=
 =?us-ascii?Q?SBdF7GWncfIwt5sPNPrcyNa5Cl+YFOdgzx1gJe1o/7pw0+9wOZANQiyVZHeu?=
 =?us-ascii?Q?d+Zzzj4hxbB8KCsrum90qzbUqfrHIXTVrEdCANjWcs3ubkSu32cPMulrViiv?=
 =?us-ascii?Q?ZCWYuyZnEFiI2Dcv8r9W+ZM73oSeadKFcRb8y8e2oNk69wsu7Jb5A2TWdC71?=
 =?us-ascii?Q?mgr09umcA8gWOPA+EE50Ft0K8eXciV0fTv4ImFq19PEezedF+7T5QrYzAHOz?=
 =?us-ascii?Q?Hl/+NtFbXAH7i90B7hHIqdZowqrF0YqCRypUUd6pICMV9S+3XLRF9C9WlkS4?=
 =?us-ascii?Q?e2chAKF28+sNxKhEc2nLKT34JtrGczScZLC5/5ml0KNVrfnkqyZ0RIhisn4J?=
 =?us-ascii?Q?g3uuXKW3baM6EYk7zXn0guyaOq3jDVJNhVookMaoI3LWhLeIJDlH31lKxbAB?=
 =?us-ascii?Q?5iGJ0/e8pkKhnPXxzLhOpiaTPqqQmq3IJK/k0y6OSY46ErpxkmxvXSlELcmi?=
 =?us-ascii?Q?AMFj7JeneILll4Wbc4qGsCnr4/Hoo0xk30Br4gusP2p0vDnG6UXKcfJ5Ucim?=
 =?us-ascii?Q?1jXoKcRzRhyHlJFUO8ic9C6cx7eNT0i6v6NtsyqbG9d4nHWeDfCjsh51JJ+9?=
 =?us-ascii?Q?Fx1qITwTAinrt13S/U6BTky/S++K0VXMV624/Kp2eVZHDBtz7lQXZkbEi5Go?=
 =?us-ascii?Q?bL7dPKilSdf3vgZzUBua51IjTstt3Wy94jyocqrddaVWv2igy4iq95rBIn9W?=
 =?us-ascii?Q?Jg1HShiBvydoLe30AIG0EpUcKopWTQCuwXbM8XH3gDZJHuowSC/iYzL+9LS8?=
 =?us-ascii?Q?Vi5Ow/gzeMdkiA3F9EXhaYtK3hbmSxPuDebudM+dcrks+Y9ttz6Y1FsGF+vi?=
 =?us-ascii?Q?4Gtv9RDfZCBalDuRjR7YnBIeZcgziYEcWV5iuf88wxiYgIyfhte/L4qyqKaj?=
 =?us-ascii?Q?Hr0xRCmEBLMC7p+L+XcoqLlevwHZvuaH6Ota2JKiztWbyvySlIHdz/HgRJS9?=
 =?us-ascii?Q?LT13hCCvPMH3YXi6ee7Ju6vkKDzIeRYAHHlsqphkHiKzv9NJmlocECIdussc?=
 =?us-ascii?Q?ohVes7pnmu8Vxguvk4YXP2TM5WxsJYxQb9AlUyFO0f3fNGgKJB0Op9Kvt1MQ?=
 =?us-ascii?Q?PMoLq0mKJMsRMe43UOCLb9h+TCSB9dLuNpL3+xlasaWF39vSLMCiBeLV/hkP?=
 =?us-ascii?Q?NStmN6kH/WjIfGiGqzpiPtZmUoLyOqy6MfEwKOCd+/pgf+FmD/qkAyLYqqxt?=
 =?us-ascii?Q?WYCW7wc/VuwzSW/P3HZt/BiXvt4tWqsbP7+80emrjOZSDwjUmNgIy4MnJfF7?=
 =?us-ascii?Q?ixg37qxv2wzmW72Ci+aMS+RzoCBtsI/EstYX1UO3v7WbmgfChuMntxVkT6BG?=
 =?us-ascii?Q?Uw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V1+NxHrQKt6HF+MpUCEs8LbXx4tmOUzFoVVC3WS/aZscgcU469v9uoYIfRUU?=
 =?us-ascii?Q?xV7Cw+CTvojIbAj39nNnhyffvVHfIBHtJnzUpb/XbwBTi7t1gujSy+QW7UhB?=
 =?us-ascii?Q?pdX74dWGgxSGipq5ns5YbrW8tlJ1vAiyZc5W7Czduv4I0w48gaNV6anElT//?=
 =?us-ascii?Q?fFD0K6M42wKRVG1t2nKDcQEP68DAZp7mPjSg8rLa9/+zPTyFl99KV+uZcxWl?=
 =?us-ascii?Q?2yjhZzuJk6h/yG/4krPk81P5CiZ42s1Qs8twlFHTKgh7EMmO9rimxi2YjKr5?=
 =?us-ascii?Q?GC3TLNYSWr1X6iCgJZxDbtC1w7JmvPI1zpgZNFxNklsdUqhWW01fx4E/UBcx?=
 =?us-ascii?Q?MV9PlNJaoz7HOZ2BxbguU0jk2EFdkaTcMpUqnNGYMl3zITI1nvCh0ds8gkfI?=
 =?us-ascii?Q?H8ZuARpx3KPjBD3U0KWpRL7wu2DUlumKX7hvOO234zpLY4vcDN77zeYN2TPK?=
 =?us-ascii?Q?t1P/AeAOZ8gfHD1umj8B+oO/bQTby4Sc+slF/jLf62stJhHFO11EKdRTShX0?=
 =?us-ascii?Q?pfCiBQYQxDsptMecrjRspjKgmjuTHnxquRaklQ9Eyc730Cw4++PVOMugWhiN?=
 =?us-ascii?Q?JtJjsBS/IcdMr2TVFCR4KMPL+SLxMdedIiaS2cilwn1Wtnr6WSzZIBWD8CpH?=
 =?us-ascii?Q?89cHqmeZKxtC35BBP/gPDaGts42hyBBHJLiD8myQEjApYIkb9wzN1nFOhZq3?=
 =?us-ascii?Q?fAz/ABcKTuKhgxRKI1fwIe04veZcMI/vKoqt4JHxy7wcLyfuQTli8DsKL+5/?=
 =?us-ascii?Q?BhaUJdIwXo42R25o6etmcPJeWeh2bM7JTyxu3f86/BwwVDeNAhuIEfjeK4EG?=
 =?us-ascii?Q?bOwEGDeY3XiT5e75n1e6/4SUJS2lDDDLaG0yhfEdAepUtRBBRexVeevm8fMb?=
 =?us-ascii?Q?OatsgxjiwVpwdHlJQ8n20avvnKHrWIJS6xOFLcUwzNrALzHEhyZiHzC1nnAe?=
 =?us-ascii?Q?xnf5SipxGIaxqntnzDVG6sq93M7mlSNWYD1gR4EBaNgYEHWS2dt9hKlmgXFy?=
 =?us-ascii?Q?ZXMl7nQ2rR50E1OHjIrB+IeEgYFk4PDlwCa7tyH8GJ+Qna2b4uVvfjhhRo14?=
 =?us-ascii?Q?0N5kVfndRiD+491Wt4l6LPFm7juQvgOc2pXLBK4EFwxqZUMcrLaarjPfgWKd?=
 =?us-ascii?Q?Mc8Yta8XTsSMmgTdrgAceGEjIHFRFSG2Fj95uvrs7VZV3vdHFA/TryQQyO4k?=
 =?us-ascii?Q?9FK1fBRVtVfJfcqgTpjinybC6im+9Imu84NqdLpWsEzopPVfQw9wAGwmPZVL?=
 =?us-ascii?Q?2OXI+Jk7t7zrHnT7w1ZdHtfZlrf0PJvwoV8Z8nB7wMmv6pa6c63jGder/gwN?=
 =?us-ascii?Q?L4bLCj1L+FeTnYj2e2qIDH6n53l8mKJak8zR1mW+BQ0xCSWojDobK22ALXEs?=
 =?us-ascii?Q?ceDp2GAOrxZVXm7jSlVpJxXvKAXdQcm7Wm56N0mrjwJ5CmOqCM6rJVf7DTcd?=
 =?us-ascii?Q?sRhPm+r1O9WRt5Mzow7POduUav5SKP6i0bYuGNI8apK8VaqTXDRjQml/5CjH?=
 =?us-ascii?Q?7RFf9zVIEpCYJBy1axpolG2M3swFMI4TPJxcZYNW5TiNXg8YoRfF12AOv1LR?=
 =?us-ascii?Q?uvbGM/vXKpD4a9Xy/kJoJxTmHPuRW4HcoThRbcNIFWcGtqfYlf3St0Puiuid?=
 =?us-ascii?Q?Z8FOVqvYNoKjFSeilDBfyKGwOhZQ1KHke3M/Is4V72i3KNC6ZkFYEz1qBs8n?=
 =?us-ascii?Q?2ne8E/9i8Hb4lGvxkrlbMxWyReoqos38kSeAvCfzNK16ULrDtoHcAFT4GlBy?=
 =?us-ascii?Q?g9pTVmfDwZ1fsL+SlUWIlpKqLf5fNtH4E4OZ4TNBzlrdqvZJNCfN?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3a65ab-8b2c-44e6-9fb4-08de6f8ebffb
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 08:13:23.0825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aCp7sRSQKsjsz/veocWWSmFSkDz6Ivo6w9jQ7/9DUZ4vzPD/so2XhgqEc746/7bNQ1tWjovhjgwx1jeHSHqlSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5862

Some DesignWare PCIe controllers integrate an eDMA block whose registers
are located in a dedicated register window. Endpoint function drivers
may need the physical base and size of this window to map/expose it to a
peer.

Record the physical base and size of the integrated eDMA register window
in struct dw_pcie.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
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

