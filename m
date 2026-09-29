Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011019.outbound.protection.outlook.com [40.93.194.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1A054CF4D;
	Tue, 29 Sep 2026 17:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703257; cv=fail; b=eJaMIUl/YlKdo9PT/0Z2gCgm9IrbMCWCcXfoRHMYAelbrL9FnttVvwzA/xt5Gzmzo5wkwzv83d36u3EMm8ilZxm/ocEeP2rwLMrWDGvBa78daaFxOjXcsWwW8NLi3dQpBwo3M4So6qHU7gyuWDGMp9ZjRbvxNcQfvK+/vnm4vH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703257; c=relaxed/simple;
	bh=ZJChICPqvTmqqdRNI3K3jFSXPAWi9Rg7wCFF5pQ9b/o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QzbyjHNtiz0It+RLTD0LaN7rfbxm/IDQddzGo6CgBdnZr4ny3yqXI/JAnLjuavjuzljQwzvHBUT2MY/6A/J+nCd72fculWaYIW3I2XBKS+ZXKL3JO70tFrhyW5khZjarjwALFid+PO6nOc3pHmQP/JATZbqlVC5mt8B50uNumUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LCH/dU0+; arc=fail smtp.client-ip=40.93.194.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LCH/dU0+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSGtXk5lwjRNCdRQPcUqbqRHAmr0S+v9jho13THGGq8AKo1YYCVHWqoNagYxrNG3nrSpGwjIeLYoFoLtCl+DwhWuO/HhPjT4fBoaKlG9RwspqUUqBct2eT2kdZy4VYKefSLcLVDldMLCb3f5Ks5Q3oIRNR+phMULCXKqt0+3Cr1QK6jh7bhcJ+IZStgfjMXV5FApRcFkepDsyAPkEMu95tCKafzmTXr5g9eRfDhvD4oa+fOCUgsSeLAz8H3bHCzXW5GMcZ4IBvOpfvtICcLs83q3/5TphmHeVAh55xM5B/YmluR3sjjnQAXrE6mWlXS04Z5ZHM+Wgt+R0aIBSnLbBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnEdaYoD+2Aa0wOjXTj5c9i5vrzyDSdBuGqiUPHa9/I=;
 b=nwBKijkxHKQZ+wWBw5Q+w4lLE87/HXYTb93U+NZPQdcTdIIJBDJf/FJB0L6JRRr3jLEBI8MVlYZia9BXdY4dh4UDhtX+d7CrxtzPndZM0QuiTFetklZMK4n7NwfAsiuDGLfd7bNhT1LjwMHI+v8No8kX5gNtWHtOhQaSja4p/OYxUHbPk0TpURXWNEH3UPdG9Y5GO3bZYy0cLmaMLtgSXhtNrYHbttF2favNzhifVFC3XuInD/kOuCymdxu1xZlbphyXtOltS5CWrhUZsNaBYfr+pMDrgmCXVkyGlwXHqvGSVJEECTAQlL+3jTDGWEbb5Zl5j7iWAHFRh6I9gDQcZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnEdaYoD+2Aa0wOjXTj5c9i5vrzyDSdBuGqiUPHa9/I=;
 b=LCH/dU0+ngTtQ2IKpzm68RyNeqX608m14urCrxp5NGpRyhYybNDIXOcEshaTC12tViIfTYurRowymQED8O3u7ecgpbk5Vo/bZpjGDx2im6vsdLF8UbPAFKhUjhlvXMyDCYj8+7m0DkBG6GB1mjyungqRIdtS6hPY/RQfz/iwP5DMvO1BUCiDxKRvb+iq+RSDFXw3HDrPc5ozV9fDUb0ZPD+JpgVTknsj/dWbC45JBA3x/B2ORPbKlIg4TvRuscJnHvpzk+7pWxDzpsyiPz+IQKUg8JcvP8o44qQYkSsFxQqY+eRyDbESMztPpBIW5iuaRyi43/WD6roF/RfD8ftpYw==
Received: from MW3PR06CA0005.namprd06.prod.outlook.com (2603:10b6:303:2a::10)
 by PH7PR12MB7186.namprd12.prod.outlook.com (2603:10b6:510:202::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 17:34:12 +0000
Received: from BY1PEPF000264B0.namprd02.prod.outlook.com
 (2603:10b6:303:2a:cafe::9d) by MW3PR06CA0005.outlook.office365.com
 (2603:10b6:303:2a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Tue,
 29 Sep 2026 17:34:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF000264B0.mail.protection.outlook.com (10.167.242.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 17:34:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 10:33:42 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 10:33:39 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v2 05/16] vfio/pci: Fail BAR faults while access is blocked
Date: Tue, 29 Sep 2026 18:32:54 +0100
Message-ID: <20260929173305.204856-6-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929173305.204856-1-skolothumtho@nvidia.com>
References: <20260929173305.204856-1-skolothumtho@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B0:EE_|PH7PR12MB7186:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bef6aca-3cf9-47a5-d505-08df1e4fdffa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	40s9l5GGnZENYhKRho6lMRyDde2dtzy8v5RpBUxQU5ElxWRvhGuF3Y87ZVCdjGkG9Ib2h1mi7dxHHTRDVtqHLNbue9ZkhP4ZFQE9PYAlLTKzmyfYNSh0/Q9azUxdjjfO59bXVC/9jRe6E+eu8FuodpBs/GSZsw4i/35buy2LZurQhoD6mC1wp9oqqtIU7R2iXMJIXH+lyDCB3O/x/QfWM4IY4qMv2fhYBLynHxPnIQKbwvIWRKnwquON5VL2JWEsW5wqJtiEHQlvXxnEdeLSNQTETvpjQzl4vX2Q4c1wHxZy8Son5r6qSCODD1n0zU3Fij3U/meacNnrCNN339O0TMk5wEb+Wpjsyz6mIDwe3VGZ3PdQgcmhF7bYf2/IAV2fBtgk5HxdwEkEtwGpAebXAu8ZJnqNRDLGvu8X7kdz1SE/UuC4hlyhFzSIyTbwUZ2WzF6lW3CDfIcyDhf0sbKaBWA5Pztvr6pqvIqGb0ckrN4Ehmozk6ai3lMVa2Jyfrw3uZoDHhGFu67pr1fVLUsTFRheUmDMO8/Av84MPhwWSWzC4arJ3BeCd3NsymdJqLKsCSLXUzLcTblXv5qA1X48HaflP/ErFu4+5ot8nlGawnFk2xTp1oft+I4nyR+ST8ki0MwOEpXP9ZEWPX+xCsIe6b9TLLvq9qRPPNlpOyoQmQNq1N2JFvK57LTO0kKjMnH/Vb7uRkYewH8uYoF16Gj2jA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cufHd2yJ+qK8sAssmT9PYeGB0TmHclhBdvi7qCVpU9QkEZ/t/nBvLIY4i2x3U4S641oGyAx6qVL7ROWlgpWyC2nD/EoSBCfbsSUI6/G1IBGbRoViCHs00sbtS/q1f1AKcrnkFg4HmV7VciyWUiEBynvq3TD8xRFr2oMZaY8Ny9WQ5Q5owCV3o0TpRzIsMAaDZK4SvWoSpabGH4COIxsyQEVSaYyxmG+y2wyi6Mx0I5p+d/hal50S82A6bZjqRd8aWcXCgZ/qlx/FMv+9m8BmlZrN0LheKi+nwkUrF1TsJj6OginWu1ore5TcVz+8Kwlj0DDQN8aNWq8PNMRJLqo5NVMV5F1t9ly5fdH2GMYZ7aITsQUytfzWmCa7Ajg+cFW16+/PeiECJneb62N2BKE5rvWrVwsWDBlrcp8oPlhfaYpXMSEnrMCp91BhVDaBuPxK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:34:11.7525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bef6aca-3cf9-47a5-d505-08df1e4fdffa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7186

Hold access_srcu across PFN insertion in the BAR fault handler. This
ensures recovery waits for an insertion before revoking the mapping.

Return VM_FAULT_SIGBUS rather than wait for recovery in the fault
handler when access is blocked. Whether userspace can handle the
resulting failure depends on the architecture and KVM fault-reporting
path.

Assisted-by: LLM
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 323038cd0ca5..1c8e39f3f509 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1842,8 +1842,19 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
 	vm_fault_t ret = VM_FAULT_FALLBACK;
 
 	if (is_aligned_for_order(vma, addr, pfn, order)) {
+		int idx;
+
+		/*
+		 * Hold access_srcu across PFN insertion so recovery cannot
+		 * finish revoking mappings before this insertion completes.
+		 */
+		idx = vfio_pci_core_access_begin(vdev);
+		if (idx < 0)
+			return VM_FAULT_SIGBUS;
+
 		scoped_guard(rwsem_read, &vdev->memory_lock)
 			ret = vfio_pci_vmf_insert_pfn(vdev, vmf, pfn, order);
+		vfio_pci_core_access_end(vdev, idx);
 	}
 
 	dev_dbg_ratelimited(&vdev->pdev->dev,
-- 
2.43.0

