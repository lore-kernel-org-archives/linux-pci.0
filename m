Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012025.outbound.protection.outlook.com [40.107.209.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4BA552943;
	Tue, 29 Sep 2026 17:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703306; cv=fail; b=ecW1H2yRJyh/FE3qoKva1fAtpuN52SSnaQL9MRPV2fWVPyVd/tM1c1BmjACV4TPhzQQGNBWt4n7MwXEYKdFJ8cV1kxXBRoHR205FOjXYA2vJ5ALVeTgq1z0NFxi/kTJLqVW4juhWv561iTpO8QNXVatQUl/BdbhkSpvtleSY1YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703306; c=relaxed/simple;
	bh=MdTF8zECPkLv0IGOlu2/3iokTg7WNGN/hY8lSxCkOBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rwwRDtIfMDF2HPEb8J/ku1djbxXleM7uoB615iwHu6wfZN8iMi3OLAsIbedLZw2Uj0TQi06rT3yPuVFVXvYYdj4fHPsgnXqzOl9tfr2WhLOTZGiXJSMVSOPdUbkZplOKAyRDKGoliKyGjZShur1nMeniMWFWPnq1L264USdqfOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GD1jMuAg; arc=fail smtp.client-ip=40.107.209.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GD1jMuAg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ln+HRwyo22F4HX/4mtrwKfWtzfAUz1BGUBZx5QPF3pPF/ZPUj1uxfQuTSxVXKziMNwuXLrbydLcr7T1BtRLUuLfTrhtJQYdqriqC/oR0g/B1R9SqBi4v7LhqafIxRT8+amovLFrtqdBCUC4nDnN1LWwPfzAA6xJHBOUYlA3tIKKIaEm2bI7+uNsUZcP2vw8+nuEpyKEQe53Ybq+AzEBbTKZn5iLjICgz4YinXn+T3xWrPAcnv0oAFQs8p9A8T3LSvZX+QKYgyd85isvWfYJ2SgmbvUCVYnS8Vy+B4pNAb23eM8iYYWRMarCky4Eva69D/d4Mi/lqeo/+oXSjLQ6Gdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbSe0041Lak4xhpObQui2WVCIU0+y0ZZy3GhHvIjQfQ=;
 b=jRz4FlO2DdCgn+A8EtI3Vm8m/tDon87J4lF7Z4cgKDyl5kIcSs1RmBwbXJY0UJuEUFTCNtttu4+4bEMsRSOUdmSXJ+5DoXSpdzv48X7REXRz66janBLuEaBYLX7rROUyfhjMEsznDiuonpc6sTTWwBNsdc4r+0ZdeDYMGgfUzKTumpuD8YUJXjDkK90ML5IB6qaaUQErABAUB4roYfANPLaelVxgpZF6WbNAhLQpHNxRnEQ+iYumwC0/TnY67Sjyi9XBWXK30Sd/Xuad6TrmbLBrtV6qWPSxtutpgu5xszZDTpP1OeTZ1TQa28OSc9azVyxa/DzQHk6q2Y0Ovc4U4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbSe0041Lak4xhpObQui2WVCIU0+y0ZZy3GhHvIjQfQ=;
 b=GD1jMuAg7o2hK8p8bpNpkMx2iaWQd5tGmLYUW2ORhDiqgIawumW5K9sqxdWTVPOFv1oSx6ybRnkZi2fxho7T63jQUZJzFUbJZQU8gM4jqvccNi0Kycx8+q1vfHrX44skNfXKUyAcFcV8WXLpOfDYPNrGZlZOo5kZRlhCM2SuxgKJJmfWRsLs4WTwwsKSYEb16bholhtWKRJSZf3JOBlc+CwPwtF58+ycVj/BHgFeX61KS36rjCNTpAR1XbJUHt1kV9vU65PY22vLZC1/SofMI1kO7CeKC+NqW/LFp9+Hj+dOO2qe/FlwPji4PR4DcOvkn9YRwxdi+SqZzmr8z4tTEg==
Received: from PH8P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::8)
 by PH7PR12MB7305.namprd12.prod.outlook.com (2603:10b6:510:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Tue, 29 Sep
 2026 17:34:56 +0000
Received: from BY1PEPF000264B5.namprd02.prod.outlook.com
 (2603:10b6:510:2db:cafe::66) by PH8P223CA0002.outlook.office365.com
 (2603:10b6:510:2db::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 17:34:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF000264B5.mail.protection.outlook.com (10.167.242.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 17:34:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 10:34:26 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 10:34:23 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v2 16/16] vfio/pci: Enable host PCI error recovery for vfio-pci
Date: Tue, 29 Sep 2026 18:33:05 +0100
Message-ID: <20260929173305.204856-17-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B5:EE_|PH7PR12MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e72dd4-89e6-40c5-22d5-08df1e4ffa76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tI9aeP2RVqwyA+11d0niVs5InsrWnoewePV22spFbx27DmRYti+zXrW8DD7GkkylJD+4hyRbeIfkAF6Bj85SVURtHH8Iinv57kI6zFzrZhV+Q3bXTBghWfqq+WbzshhEudcp9zuk394+Mkc3cYHuDjWFMfjWoLxR2mdPjBOz4dFLPvhjBpVn2xXVhIRGG/cqB3+Tau3jiMs8NaZ9Voa95z8sdX9PJ+NMPcGuBM7uYUQheV+HQ2taS/awFaNqXcpfjxJlaukvZf6UHjNipdaM+YCRxn/2MDhPj8eR7rR7+nIfFrHBwo5mqp0uS6SQ78DaUHE1oKb+2Ec0BHr/UcJrxljsT71vsKCRcKygLkSlFTe91tR8oebrUaFUQL+2SKc2+8BI8D+eZbVXYdoMtVjoqbZirjFduE5rjcPTi7QaytoDzeQmO5aAkwvZ5wqARYzSyyfloujonawzFTgboUxqNRUOe8BgUJcSrqouxrRc4y/VV/RYVo36RNjNlLJsawLbK/FOlfN6VIVlu2wUSBJjwM1k87m/8zkWpema5zTAxcgfx0gyLwlwGOQ0ioaQSIKMbiAfDHYYAKopLImV+DWZTFzHIgiLcxNx9ljakPl2Nww/5UBDeNEVZUJUk+C7rTMLZlY5gPZ5e3JpYLLfNDLaUl+cHLn8P/BUfaXri4ow17LBK72o5/cJ5HxIE3tfNmtT0eoxZDhIwoFa+hYvX8ey5g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	X/6J6t1jNPVO4OpJ3Ft2d82MR1mZko9Uryu5+gz2rOwYQTSQBP72sK6iy3uw/bQqDwI1aCvg6jqJSCwRZu2d2AR12YpC8crTF+BJRshrhM0FpiclzmC/Ig4ZnnsX6pVxD0Zg1QOnUvT7MAc+mb4/wn6Sic0R/N7DtFa+kJt/yD4+NfIu/ec356rCnd0cF6R6uBSqSoYC6sPSvEUxjn1WPhNfHsQgfp5+XTnS5i7bEoh4fnq3+xh7IooRmxicl1unelpKubQfEdhqmecSIqPFred/EI/Ab2MBIgjMzxjsskc7u0MUW6zri8J3pmU+MG7HpXLMumQ5ltSIzMB1qoFyQZT2oZYZBzYSI3oOiRKWuU0AuV5dXfOrAnrPf31hGFPkSyZg5nBl9yb5AQn6vidczKKCV8WhiaTJNCPp6blCG2tXU6xC8TSIDWAXO0gv82iP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:34:56.1585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e72dd4-89e6-40c5-22d5-08df1e4ffa76
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7305

Enable recovery support for generic vfio-pci. Userspace opts in through
VFIO_DEVICE_FEATURE_PCI_ERROR_RECOVERY. Open rejects an active host
recovery even without opt-in. Leave variant drivers disabled until their
access paths are covered.

Exclude CXL memory devices and s390: Restricted CXL Host (RCH) and s390
mediated recovery can omit completion callbacks. On s390, permanent-failure
notification also blocks config access, so draining SRCU can deadlock
with config readers.

Assisted-by: LLM
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 4887dd062c77..043371c2882c 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -129,6 +129,7 @@ static int vfio_pci_init_dev(struct vfio_device *core_vdev)
 {
 	struct vfio_pci_core_device *vdev =
 		container_of(core_vdev, struct vfio_pci_core_device, vdev);
+	struct pci_dev *pdev = to_pci_dev(core_vdev->dev);
 
 	/*
 	 * These behaviors originated in vfio-pci and moved into
@@ -139,6 +140,14 @@ static int vfio_pci_init_dev(struct vfio_device *core_vdev)
 	 */
 	vdev->nointxmask = nointxmask;
 	vdev->disable_idle_d3 = disable_idle_d3;
+	/*
+	 * CXL RCH and s390 mediated recovery can omit completion callbacks.
+	 * s390 also blocks config access across failure notification, which
+	 * prevents draining SRCU readers waiting for config access.
+	 */
+	if (!IS_ENABLED(CONFIG_S390) &&
+	    (pdev->class >> 8) != PCI_CLASS_MEMORY_CXL)
+		vdev->pci_recovery_supported = true;
 #ifdef CONFIG_VFIO_PCI_VGA
 	vdev->disable_vga = disable_vga;
 #endif
-- 
2.43.0

