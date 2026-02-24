Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011057.outbound.protection.outlook.com [52.101.62.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CED366DB1;
	Tue, 24 Feb 2026 08:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771922316; cv=fail; b=u1nZXkWWx5RnpVBu4XiDX12UPJCuTLX+MF9qNk12DHDJIAKQkUjE9W9ZuRfNj6aQH+o/N6oTB4dNjHPJy5+4LFO5zvXfjOfPHYXoTHT3xXE43y7lC3TmgnOvVN0QNQzDlbxTEuz603eA4j9XF3th8F3om7PEpsvk6jhFneVOrbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771922316; c=relaxed/simple;
	bh=8LTgbylNGCHhFHvf+f2wL0Z1xChPEldpFw+DU/ZyrVg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pbrRfBNK2l8DvZQAuNSLaxqlVIWQGBps85DaPHJqQt2xjV9BoDdBQ1ZX5Buv3+54ow8nG3CFYsus6j4CEGNFDbFDOAuVfc4Zph3RYDmVXrg0WwC+jlBVyaoW2Wq3opx2tYmGihgrM2WE6Zd6vDdJexyYm+v9ApAmjlZktR1kuWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NVgSh+Rk; arc=fail smtp.client-ip=52.101.62.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NVgSh+Rk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgdAFvTb+JCCAbnNPbzCSUpKJdt3O2UkIrbDvRLr/xAxvvTvafyKRE1BLgzKB1eU07QDvgxzXNj2l+2xNxjIxwpU81IoAiGtkj2pzY0Frv93V9Cf9xgs5jv/UDvp7hxNa6rjey6ra8ZgsxgxzxU20I92LZnpoU6nVvvAdtiiIxE1arAkaN9s/68exLFRAtflV16yVqe9YSuXEyLLHgxTte2MGqZZj7InN1qXxHMmLDZQhch8YzxgpTjbaOe2121UWfEV9Rode/+DaFNQqzudPUKPSXQRBmfYHz6po9FN/WHE7mp9cLF87rNKYz+UnbdCsSxpwWX3RMeYNRl7DLUiSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDQwAkNJxMGCkzYXlJVBiC/julVkR3DTpimSxPfk/8o=;
 b=Ne5EGJri2o05YkeVcY7u+snNG06CBIEwpd9Uz+W7zgWPtBaMjXjn57f7savIlWSqqo4x9aGs6iALWKal1mcJRYQsf3wsdnh1yDeCszjnBGGVuVQ2FOlDfALFxNGAzJsYYcRJTJqxxgm44i53m6dSJaHuY21w6kDhEYsQe3N8PrDR9V495aYyC3b8wXtp2YsV7pdAXRQl5zBoo9YFD6nTkw0wSumOqVIW0X1eOswU1V5MseEXlFNGQOPKEvTLfeHy26Imkj6mHYlrEZz00xd+7shGwC3e3SoC8qE7/QxxTzkzP6df2ND4TaKUEC6gkDt0J4bBWiptc4d8aosfYy2+ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDQwAkNJxMGCkzYXlJVBiC/julVkR3DTpimSxPfk/8o=;
 b=NVgSh+RkMcGWppIfJUN04vfSULGRANFN3ZVM/u/aa6fWbhUryE/GUdDnsxzuKVARz6bMTJEKPXAJxfN0r0cq/yyTI/Lu/ebywoojGV64N7wOSz8fFIkfTsKlOzWVcf+7jMMZjQg7W31dxzNzJ9CaSR7SvtDWwSClqyPx+olx8rA=
Received: from BL0PR0102CA0018.prod.exchangelabs.com (2603:10b6:207:18::31) by
 PH7PR10MB7108.namprd10.prod.outlook.com (2603:10b6:510:27e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 08:38:32 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:207:18:cafe::f4) by BL0PR0102CA0018.outlook.office365.com
 (2603:10b6:207:18::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Tue,
 24 Feb 2026 08:38:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 08:38:30 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 02:38:30 -0600
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 02:38:30 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Feb 2026 02:38:30 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61O8cKBY2414416;
	Tue, 24 Feb 2026 02:38:25 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <yoshihiro.shimoda.uh@renesas.com>,
	<fancer.lancer@gmail.com>, <Zhiqiang.Hou@nxp.com>,
	<gustavo.pimentel@synopsys.com>, <cassel@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>, Aksh Garg <a-garg7@ti.com>
Subject: [PATCH v3 1/2] PCI: dwc: ep: Fix MSI-X configuration to write to correct physical function
Date: Tue, 24 Feb 2026 14:08:16 +0530
Message-ID: <20260224083817.916782-2-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260224083817.916782-1-a-garg7@ti.com>
References: <20260224083817.916782-1-a-garg7@ti.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|PH7PR10MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f864cf-11f2-4962-0d01-08de738016eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YvC+hgkZ1TOFFmYlv/BTtNmCpYeoz13hm1Fm75+TnKJdSK+RC8sBgiAcJOtz?=
 =?us-ascii?Q?py7W/XnkbAypGC4Y1zdcXAxnvrAyT4W5bwBJ3mpr/7xWZ1uR1P1SJjTAoIFA?=
 =?us-ascii?Q?M7oAOOjBOHqthQUsachXoH3afmCp3vHnAzeidSxyCFa1SmHPG+PMXsHu/GsT?=
 =?us-ascii?Q?rX9kfm4TO2mlyvpwg3XmavPkfGI1IpUScFQ6u2f4U4V1UyOj9jlbcanHomqN?=
 =?us-ascii?Q?sx+8fnyUPU8BRQRYh2yLbF4pF2WkpDfABNlEwaQhQq+zXgkgaP3xe1JArBYY?=
 =?us-ascii?Q?4Q8VgrrCtJBP8xf2Dd6lYaS5bJKRhgmYBVxPkBTWIyrlwOLqvuBJOLlbL6Nc?=
 =?us-ascii?Q?BhJqZZG2QGfE/M7tuXOd7uX8h4ZSG1cj/cfMyUa38Aigd6JzJvLFeCpjvA2A?=
 =?us-ascii?Q?osJIBi6VdPvwwU0rIb4JkiwrIlg1b415e/t8iaoC3bBNbmeXPKxyVlU0XAMD?=
 =?us-ascii?Q?lWctTbge9qo872gYoDh1MO/gPlMHV1+gQv/C+RAwdWsfeY1fRqLhAtp8FaF4?=
 =?us-ascii?Q?BFwaJrn3cIttWSBrtqQyHaPd4DtL8QmZLXbXMzQB5eeQi7luAzfzdTBNtXs3?=
 =?us-ascii?Q?ZSpL9Q9Pn6XmmA3a6CcZ8Ltv15omKUjloDamrKKT896WsbQf0Yfq0x9JmVdw?=
 =?us-ascii?Q?rhUjAnjETcfEMueKRWwce/7+ziws7fxwFQDbGYtg3QJS0EdOm6rBnB2VPzfJ?=
 =?us-ascii?Q?oQBfP3d2V40K1R+YswmJ8usQdEu85K1arqDZK0QpT6VxIxvAvMsCxrfboWJI?=
 =?us-ascii?Q?8icZW4ma5hy7oMW8E7VJCCaVWu9eIQYvlY8yHHF0YWdoBp/VF7czm6LgV+nq?=
 =?us-ascii?Q?ThLgN1i9EKr1nhHwt2+/yt/9urV+RmlWIRRNQTq772ivO+GevB8/nEShWKNg?=
 =?us-ascii?Q?KQm5s1oLMjL8hOs9qfn81JTQjq7AIF9HE2U1JVZCsmrqxqf6SocdFNAP9o8+?=
 =?us-ascii?Q?+9grem2yPYOmD7xoMzO03QlOfS3IaPI25NTYYJj8Dea8bHJhGf0TQNotsdZG?=
 =?us-ascii?Q?uy2ZkDnPbMvfXpSrvOGH/OizK+ImsPqqG3z2pXbg0P9A4kLSF4uYMzVCAYt2?=
 =?us-ascii?Q?zM1XKVxVys72wdu6nFLrsz2A/Ki+fzUDBpI24MxSWvtsrJGipR9HAgiM3ZUS?=
 =?us-ascii?Q?VXMjee++aNdYL9h4/Li6oz9At60QnImcCoMiEBfq7InStReaR0Hu4YedMV/1?=
 =?us-ascii?Q?ODiRIdvfiaNFFuNNRyEWV+iNi8CCqncYcWlEQfZF2guxsKjwu/hpiXHTKa2R?=
 =?us-ascii?Q?gU0Tc89DYvq619cJqz1yUcpG78WlJM+ZQLKo69Pdhu1byASKaTkwHtFRmxQU?=
 =?us-ascii?Q?0u5kRW+HGyqHaaT4KjxJU+ro6DV0/AYrwrZdNBpcajkBcttxaQpbgrzoWLXb?=
 =?us-ascii?Q?X6CR76xPk7+HI/9yLPg/a1oWtLZ51zIRNMYvE6Kh3EXnGqL8Ojf1nZMSSnsQ?=
 =?us-ascii?Q?RffYA0xpLtRLstVQH0Rq0GrGyLIMtzUoTeRh2nsiS2vGYa9+w7exqN8RlX5l?=
 =?us-ascii?Q?AicF2CZ6ves/8StkWb5niTh8Yq2z8yRHbtAb8K8lHJ40kLohCxqeQ3E7IFOd?=
 =?us-ascii?Q?Jy4bs8l7XRhZdlu/dGlmvhH2j+NiYmoM2/vVa6vxeGCqfCgUjWEuE6UbHk+M?=
 =?us-ascii?Q?jIzxWBDvbjr2zqBSgKP/hN5DXnPpvyVNtLt+5a4f+Zpz2PeNtuG9GuFjGNVn?=
 =?us-ascii?Q?/dtkGpSw//CHtKuektaxtf6yz/s=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sVX3bFTxg6K9IWPhtw+pJj2vZvijXfYyKVqrXl/4O73DlSJ9xbeP8+5NXJTgtGWg71cxgHRWaNBO24qsj1JEhaGbvGCrloWzyybsXtY7ggSzkgfWg5LWDOJsEJB89mz8ZmmnXBTdXGsrGoak5wJOJLpeXIbAd9cANU9gOkTHmTKNn1PhiWyw28CXfTL8CgCJIVazxhZ3A9NzaEwykU545DLVwRoRGRYFdQ9aajC5REkGqeCGzCqSYtiyfpUaLfTuIzv+q2aJmm42QschRIjT4JPhavU50tyzvp3XPSJ5ELadK6UBA9MRyZL1dWjQ3Yadwxo986xXXJYrSfgMMVn30hwB3sCufigg27uVVWhA/sQVC7MJ2LqSF/mr91xL23HS8HTQE2wy0rZpVKCqRc3m6d/FPd0LRFvbSW+2OImibouzSKh2RClGd6CLYGpfD0ez
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 08:38:30.9583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f864cf-11f2-4962-0d01-08de738016eb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7108

The MSI-X configuration code reads from the correct physical function's
register space using dw_pcie_ep_readw_dbi(), but writes back only to
PF0 using the old dw_pcie_writew_dbi() helper. This causes incorrect
MSI-X configuration for other PFs.

Fix this by using dw_pcie_ep_writew_dbi() to write to the correct PF's
register space, matching the read operation.

Fixes: 70fa02ca1446 ("PCI: dwc: Add dw_pcie_ep_{read,write}_dbi[2] helpers")
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Aksh Garg <a-garg7@ti.com>
---

Changes since v1:
- None

v1: https://lore.kernel.org/all/20260202072758.101845-2-a-garg7@ti.com/

 drivers/pci/controller/dwc/pcie-designware-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 7e7844ff0f7e..771241e1a2c9 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -745,7 +745,7 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	val = dw_pcie_ep_readw_dbi(ep, func_no, reg);
 	val &= ~PCI_MSIX_FLAGS_QSIZE;
 	val |= nr_irqs - 1; /* encoded as N-1 */
-	dw_pcie_writew_dbi(pci, reg, val);
+	dw_pcie_ep_writew_dbi(ep, func_no, reg, val);
 
 	reg = ep_func->msix_cap + PCI_MSIX_TABLE;
 	val = offset | bir;
-- 
2.34.1

