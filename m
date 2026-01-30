Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC981E4AF;
	Fri, 30 Jan 2026 11:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769774141; cv=fail; b=DkSXu6DQt2HWLi1yQ5JpdPk66DL8lkVa5yUxchWTe0fmcdpMGMHDwyAjk6+k7DWTeiulaHgLy9PAZF+eMhGhNUgynQaMbQj7ZyyT9Kp8rKBqTQ8nuA4j9u+LEGkwWwYOCEB06Smy3LkLB5cSVAiQA+yd6MHroVu2fwKPcHsJQA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769774141; c=relaxed/simple;
	bh=bsYwCZ9BuKmoQyXibzW95YrBYz5+Xz2NFFT4nffoqHE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VuboIwxRUIRBEEVt3t4kHomPdT0DpDuwvKPUvD578D94HmOqncJx9yfMcFlKiOFqW8nLYLvZJQ1a78rb2e6p6E/0CxNYjwmK8ZIwbPHdtLMHFwaAM2B8912hd91b1ooGsgABepkf5310F/OR07bNWYeHsg0nIuU+aGkCNyNNHjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GtJYm79G; arc=fail smtp.client-ip=52.101.62.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GtJYm79G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ig3t1HweU7cl239CRAstORK2DBxKSU+wb4IJvG5taJ7z6CP5Ey6uya9RDnmDh2vigrvUCLCsFfCSmlFkVKr+QeCXXfZ4GIY+xJRerTT7dYehFZ5jigu0uJPVFzTQ9GKgY4dLsG0v/ITdPCvCP810Fgph15LTguhZoZXzIjDMPKUT7b50V5RgKzXyhmLkOZoIda0CT5hNMCxJ5PM57hAv/rirdBybPmG6h5MoC728gXPTbRu6Cm5Ryt69Hj+VAJgLc640KL78r3uto9uq8TOcxm3iITD6xZmwThmC3wz/sskeU1HsuD6sjypkSCFD2pWWhqmR2EcfKNgO7odl474NYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVKnmmVqfFnVvMxr7iaP7N1+OH7UwiI7sT/BN0qqEQU=;
 b=eJZLILQpl9/qzrAsJVZcxQh+w2Ywnuq8JtdE+QVyuJB8WJHTaGsTF/HhwVnyDM0S1nmIS2qIxXCLxyCCNeSdBlPB/yvOn19M2vNg8rq+5lk2PwShRhi8QwZAoCKLjfZKRWzXXbEeTUXAjBx+xO4weev2uxMsPD4TkzpMx7EbeH5vSBFIlEIYeUffCz5jErBRgBfygB3V2MyI+zGLot5UEFmPYIciqKip8m9ONYfqWuVQGw3rSqjK76/qE4+P2OB8Buhc+oZQf8kWLK8q268da7fBRahHk3qSFq/OZhg0d+c8GTusPjTYAx4a3DS1U5QAPlHEqCbLuPFXowju7/P+Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVKnmmVqfFnVvMxr7iaP7N1+OH7UwiI7sT/BN0qqEQU=;
 b=GtJYm79G5hPZmTxakgu4d+nqkfsz90POTRNxVhxLNZIh+ncruN1S8Rn0Xc37wcY3+gzJwW+GpEZRBXVTE/U9DSTuXC9UFzutXgEiRRwqwW67y+HHcyX7LqSZK2WwISVUv5RfS3abzoCqhAnt4pCK4f5CZTVtzdfueKmHdoEwc2s=
Received: from BY5PR17CA0006.namprd17.prod.outlook.com (2603:10b6:a03:1b8::19)
 by CH3PR10MB6740.namprd10.prod.outlook.com (2603:10b6:610:144::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 11:55:36 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::99) by BY5PR17CA0006.outlook.office365.com
 (2603:10b6:a03:1b8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Fri,
 30 Jan 2026 11:55:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 11:55:36 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 05:55:35 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 05:55:35 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 30 Jan 2026 05:55:35 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60UBtIu31665999;
	Fri, 30 Jan 2026 05:55:31 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <cassel@kernel.org>, <Zhiqiang.Hou@nxp.com>,
	<gustavo.pimentel@synopsys.com>, <den@valinux.co.jp>
CC: <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>, Aksh Garg <a-garg7@ti.com>
Subject: [PATCH v5 3/3] PCI: dwc: ep: Add comment explaining controller-level PTM access
Date: Fri, 30 Jan 2026 17:25:16 +0530
Message-ID: <20260130115516.515082-4-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260130115516.515082-1-a-garg7@ti.com>
References: <20260130115516.515082-1-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|CH3PR10MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cd4d47c-00ec-4aca-bd34-08de5ff67b3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iS/cPyqh4CDBimlUW8tFbNlVnU44CUaDw7LDsPQprDOR3mPLQAkrB0pjdqFz?=
 =?us-ascii?Q?JrrqaCPBz7SwsQ/4192x5cgGbNDkKUL2KHN7aPnvH6i+UZ72KQWiCUgFhWyH?=
 =?us-ascii?Q?AuLTU0jklzWzjGEYw6kEQ3iXuIkmE59Z8cgFJJgsOElfi3gm1/WDoQGWb4dX?=
 =?us-ascii?Q?/oIqDMoGw5oIvIWxM9DPl8M4P68ElP8D1j+g3xym2dTxxmIYMG8TjPVB6yAW?=
 =?us-ascii?Q?k+Ad3+sKzUsB0OH6PopazZDrCOXFoR2Y8PDkRrvqt9/YTiry9Ran6A+3e0Hk?=
 =?us-ascii?Q?E9zl5ziJkPGW/qgAMnggjeMeyjGuF6WW0WLjVIwLKn6YM3zP4EpbuI/bhd1n?=
 =?us-ascii?Q?7lIiQ+gJjW5D+hbhISD/1FoETkv2qyuXGnECFIFArC24cSWMsHH4AZLumVNw?=
 =?us-ascii?Q?TlqA0M2/+qEX9ONb/6aNg1HEG3i/o2/h5DHjQOUg2Xp2wNVB2sumZtfrWh+B?=
 =?us-ascii?Q?kMdDrMhI4o0NHG/qnOSAarjKNJZIBXFshHWHtO8UJxfRlFEnNubKO+4eRreP?=
 =?us-ascii?Q?QC8HmgcYSrfQTHukhL4FocUQdZpvmAmR8W2vkcJmG8IdFh/jjZWaXZOck7aN?=
 =?us-ascii?Q?2e9NQYoaQhMH66p4DrdxZN0FDVJ/hnM2hBuh38u3t9Ey93pHsuaLFlf+c84N?=
 =?us-ascii?Q?BuxwSki3mgjzZ9hQqE9ze1pL5ufcEvS3aqNzlr2B4x7isOlUMgTeKjIERfGV?=
 =?us-ascii?Q?JDoXeTGeMIQ102vzOE6zwXVghD77Znpz22w4UY0uECkXJMPno4Lb+9trPPuG?=
 =?us-ascii?Q?hBstiKzo0jPk9JrknZ4iMo7dauZPjLFboJ3sH1Qt8OG+VMYMjAnrpVlmNejX?=
 =?us-ascii?Q?OJPhvW2T9CTdXd1zWmHQoySPGI2Odf9UbM9voP3BbTH61rPvAf+hIHuTpNuS?=
 =?us-ascii?Q?1bjqhlg1is+QykTBl5W7XIy62M7d30/CE9nMCb6RxGrV0kFemkx7Jm8hwfTW?=
 =?us-ascii?Q?kMHSz49lIscSr8wu9sTGyzU3A8FEYbndEpi/rhekjXpBFnBQRsEy4FGt62Po?=
 =?us-ascii?Q?1W8L4wF9ySNYrFWI1w99emS0lxqqP+JdwcYy00CrAB/MuGX2jvlbaiQgTihO?=
 =?us-ascii?Q?HvFT+2OcUIu+8IN/xuYp1QfcxlozPDkynoW01PsN6alDnryyGzgNr3blcvpX?=
 =?us-ascii?Q?jz1v+ojsFxJvzJRPYT/v645ahOnfufGS5OjCRm5in3LkiM1aMCqAVyKUtOr4?=
 =?us-ascii?Q?h6G6uMYYfuL02m+ljhwCNxiXFpjheZ25+YpD+Hl1KpaLQRJ3aCG4zDbFR4o/?=
 =?us-ascii?Q?ZAiU19fMLe6HSfh+klH58ryYSnCj5vucLCHdO7+a3ByyJCEimbPZrbQDlN3d?=
 =?us-ascii?Q?qlq8eJ1LMW/ukeWQg/+y3YHN0DJ17yEJoh5BPJdYbl1B9hGS6pYQMy1/sxkT?=
 =?us-ascii?Q?SMQrwDHDKLjj9we5e/najjNkSdkpC+3vQ1XYH3BxYxQ5k84Xdj1Gfb9E0PWa?=
 =?us-ascii?Q?eTeC3Ll2JXAbJt/q/HLhv+MZudfWFUI1OIWuDiXMsUBkeYjhzRtU4x1cTlqJ?=
 =?us-ascii?Q?bOAXGnXUwg1zECFaq6MF8+uvoywtkkwT9Ov/KE1/kyhus1/B3Ksj7VZOJMGj?=
 =?us-ascii?Q?GhyfVp/AKTjNBiNCGNp8Zxxwxm04L/093SPyTRhUx4rRPhT9cVfNUp6XonG/?=
 =?us-ascii?Q?QV3u1Jmy278WfLhlPm7ZKATF1xWFZytZ/hjPipNL4VeoFP3C4sQ8iij6AOjD?=
 =?us-ascii?Q?ptfZYbTTpICL6KOmeGaEBu0RWzU=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1kR+a0ZhAKckMtZ+erjgXnqhpsY8RckJvorZd+ng5+YYfVNJSRTrShe9uZJp8fMrRbnPw9Y8eK+uVXqEIhzUhkW8QxK1PtID9/ZgxTfFfTKuMyMy6fqiw81/AyLQ+MtjzMLXNT2fKfrG0MB9FBwmy+CQOZ8Nl9WMQNla4SPkF+3Bhx8aPRxzTAUYQ2gRSvseVEZIYkQTJvgNnAYtfPhqtaEnwhIaL/NbOUgkMUORVF3fiFd2qZ06fgY6yy8dsw0EQM/7ud8agWTAM0pIhTwBubZvEtoUCm85B1QrxsZsMRPeCWIgCAJ7Yt70K8qIh5GuiLvet7ZBTf/jlSAK77Pf+CEcKHU6w82NbZvG9XbrIHRFQCaOdRcMKNHgwk20W68pXIXDFYgTK1ZrYFtlOgIavMKatdPg6Y3IDquTbl1a2Q1ZZ5QRcdLvsC2bi3kZY89P
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 11:55:36.6256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd4d47c-00ec-4aca-bd34-08de5ff67b3f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6740

PCIe r6.0, section 7.9.15 requires PTM capability in exactly one
function to control all PTM-capable functions. This makes PTM registers
controller-level rather than per-function.

Add a comment explaining why PTM capability registers are accessed
using the standard DBI accessors instead of func_no indexed
per-function accessors.

Suggested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Aksh Garg <a-garg7@ti.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---

Changes from v4 to v5:
- None

Changes from v3 to v4:
- Rebase

Changes from v2 to v3:
- Fixed the suggested nits

v4: https://lore.kernel.org/all/20260129091753.490167-4-a-garg7@ti.com/
v3: https://lore.kernel.org/all/20260127085010.446116-4-a-garg7@ti.com/
v2: https://lore.kernel.org/all/20260122082538.309122-4-a-garg7@ti.com/

 drivers/pci/controller/dwc/pcie-designware-ep.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 6d3c35dd280f..dd48e60b513c 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -1187,6 +1187,16 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 	if (ep->ops->init)
 		ep->ops->init(ep);
 
+	/*
+	 * PCIe r6.0, section 7.9.15 states that for endpoints that support PTM,
+	 * this capability structure is required in exactly one function, which
+	 * controls the PTM behavior of all PTM capable functions. This indicates
+	 * the PTM capability structure represents controller-level registers
+	 * rather than per-function registers.
+	 *
+	 * Therefore, PTM capability registers are configured using the standard DBI
+	 * accessors, instead of func_no indexed per-function accessors.
+	 */
 	ptm_cap_base = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
 
 	/*
-- 
2.34.1

