Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010017.outbound.protection.outlook.com [52.101.85.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2117D3B6343;
	Thu, 10 Sep 2026 23:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789082282; cv=fail; b=O1Lvm8ybwv4O2DO7asAMbwDCBF052+FVpvRslv2Gp+x9mwbTO21M7hHKaNU/MT4s7Lh0T5lRkJoj+wzqWCCJbwPZFeC3q6RWKD4dXKgEA8x5+JRGQPxYHGgec2qJZxRVdmo0/0lacV/oXcMGukqF11IKhDo4H5o0EUiZpIWA8BA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789082282; c=relaxed/simple;
	bh=uau5GPmVOM4SqDWU+wb0M5nWN76Ko+9v5gTJPS9M7aM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=srNTSRnaWkPgNKX5K/DcmCrIxhZbZeMJCdLeZ8fQen/GVc6Ui9PpSR83DnjyEd/3VRXHrtD/CYHTtF8a+wjxaczPeX1ecePp20QtgGxUrN1ulSsSStzhcry9mebh009K5Y5X10pt5ajb9BDsHqrrFRkIcpNeXWX/ts14X1Yws34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y2pgj4Oi; arc=fail smtp.client-ip=52.101.85.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y2pgj4Oi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HvttlmvXtbuXMx27eMuDyQxRxmbkp7qv3vV1MZ4Vj/NBwDfRGoRQCghFLVJq5I6oKwznCjx4rlWo58V/psYfm5LMUh3sf6bTnPceo07k7wiRwIKFS6Z9oQrgp1QFGCBhKt0Hpj2hfTAweMLPiEcs4bgyS4a5DlJIeUTKGhU8EqOYGao29r7CBxAGxueyS8w+4J/JQSRjtJSxnplfGiHe6VqoEg9rHyNcIIeNfCHj23PFK16Gg3Q0ETH65blCN0qWvthLoI+w0rMYLN/ZU7Zb/BoqCEdFRk7G2bz8yFWugIllMfcOt5RDfbhhUYZONUvu8mGLMo3RXcDUywxQVfZhsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJ2zjsLNBXMB3BbHlmasWmDwYhJjNRSFDtOa2eTDCv4=;
 b=pl8p6prGk0SJDqsOrr0Om4ERjXYbD9MlqNLwDsvvKnuTeXhUYHF0soo7W7W2bdR0Sn+JEGcc5SehirMYkKD1iPCWU2fepIy3DRd6wCgMReCwhVhMeG5pEbbDAFBd4DUTaG+XzXmvjkilB34DxCff6LMBDUACuEU9rVqX21NJDbK9L+cgGTLml+KJrFqpDbXVNskRkW29JBn3Ql5cR91/Ru1PFz2nIUiINzx4jVjl1eoBl9d+D78Jt13p5sfMy35Zb1pMGPH+5JF8/M8D5hODnxop258XEVrkSnSEt7B9RRVFaUkRwEmJkHPs/jrBqq4yEfxgmCL/YHXDZC5U6NGy6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJ2zjsLNBXMB3BbHlmasWmDwYhJjNRSFDtOa2eTDCv4=;
 b=Y2pgj4OijKFE/zw9++JKxlEjOFrXriHpssDVR3ekgkSebCYTjy9RkVN1DFqWesUwIwLOnPereevJsSxwWjVTLdbbngJC4dnczWHtquIJxxbc9sfxtKPnslFCAhAMgyvaOgToTv0u5h/ADysPbrDaihSlgWnmhJVQqNGCkYsk2uAFbwwjel/9iSQy1R6k/tYgdDLZ4AkNckxf5zSBwd0ZYi4L6IbaEwtzkz87jErLgg05t5Ga087y3CTM8TV2TSsbIozerPTA5KrDzh3P/tvEaWLa//tU0OzBPdDF9RTpiA/tKJc9uPoEhyYh7DC5T2Sswng7VIc0Q1hBzmo4Ul63RQ==
Received: from MN2PR01CA0039.prod.exchangelabs.com (2603:10b6:208:23f::8) by
 SA3PR12MB7880.namprd12.prod.outlook.com (2603:10b6:806:305::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 23:17:56 +0000
Received: from BN2PEPF0000A890.namprd04.prod.outlook.com
 (2603:10b6:208:23f:cafe::38) by MN2PR01CA0039.outlook.office365.com
 (2603:10b6:208:23f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.8 via Frontend Transport; Thu, 10
 Sep 2026 23:17:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000A890.mail.protection.outlook.com (10.167.248.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 23:17:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 16:17:35 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 16:17:35 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Thu, 10 Sep 2026 16:17:34 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>, "Jonathan
 Cameron" <jonathan.cameron@oss.qualcomm.com>
CC: <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, Jean-Philippe Brucker <jpb@kernel.org>, "Eric
 Auger" <eric.auger@redhat.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: [PATCH v4 11/15] iommu/arm-smmu-v3: Discard partial PRI faults on PRIQ overflow
Date: Thu, 10 Sep 2026 16:17:03 -0700
Message-ID: <1c274d8836e59c549130170d5794d22e9b8c7d7a.1789081084.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789081084.git.nicolinc@nvidia.com>
References: <cover.1789081084.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A890:EE_|SA3PR12MB7880:EE_
X-MS-Office365-Filtering-Correlation-Id: e45dfe2c-b333-4376-4aac-08df0f91bf55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|7416014|82310400026|1800799024|11063799006|5023799004|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ZciwzAF251EHodFR4NheNOaBLr7+Nb4NxtDN7ubZ/7XMbEQGTXDHBFRC2wIFIEu8AgKe5tR4BX0SYPOA/HWEV0I6yfUjaq0NPAytwStDSuVqqUPgVI5X+QWMirLtDhXy/o2WxC0FcMMwC4pKzErYBAEcfTx5YxjTEPrAUWOJsTrCwXB/T9kNMYU2gJXGoBrvCrWh1PEPB9hjcjwy4TMWXVwSVXzAN+MzKNVmbR83/nmQ8oMxxCN3B/cNymeOQMLGeRVYaKhT4LhW96tMFR15qOZeuDuj9v6sFyb1nE8NQNGlBgFQQZJTln75zFi3o9NWdsrfcRmmyN8Gma5rUHvkBtLbvwhhsikCnF6prf6ySDNTiqhXKV/xZraS+E6OWyC5Ds9Cd5SmSvNH0xHR/AYQ1SYllRlvkZt7wOPHQ4OOpQ1XWewz5ut16oemwojaViho7PoL+UX/jkCBvdfBl7mp4tCeFG4XUKHXOAxQpfxB8ovcf2d9Lr7NwmEVRVRV22wsdFVXEYZmqi9QoO3LzuwDsn20Ls9axogq7yJnTBjcb8k8HNnUzND2J20gRWLG8j+waBiqjAIZop/8n0msj43Focw5nPHIOY8y7j9WHabD4a8d8UUpRCeBE8EW7o8Qh9Is0XcOiLclSQSiVNtQ5+1tgjgtP33kG8GYtUOJtLN38dhM664nrtujFMOEpxA7IrStWY57Cs4Yyo5gPXxwQBoqAg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(82310400026)(1800799024)(11063799006)(5023799004)(10067099003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PFhk9DjnzPHw5wBPfhsxxbuic0t3D1UKigshU4KSGNi7h+khfLyhKcFVcfAgR2h6SjrDUhkigG+2NpxWn7qGcdrgF+x3Y1Td1r8zMhqPcjyZ2rBZ0fLrKZ+/LX48xSySqX4aHTGzzgycWjnVnT68KIlSzLi3/BFtCrTtmudFvvcjOMzRjVgJV05bSSmtq5uXdKj9/F1+rifgp4bMzQzPMPG30IRQT/Ac81tysJyCn9+9PN29MxZJd30AglogyGZE1DKKyA1CimcHmRus2CYfd+z1X1qL7kJZofHqHxz+fmOzubFav1Tc4yzCjq8c9H4dMcwf08NnsiW3iEFsPW6C/zSIwJ4sL/8PQm14ymKfB6OxVBml6BwBHq+MN7QAHGko0wNizHUDverx41RSOYTi1ytuteqUSh+NWvSeDrSInoVMAvJNJP0bhtZk7jaxoZgh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 23:17:56.2813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e45dfe2c-b333-4376-4aac-08df0f91bf55
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A890.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7880

On PRIQ overflow, partial requests stored via report_partial_fault() whose
LAST-page entry was lost stay in iopf_param->partial. Drop them by calling
iopf_queue_discard_partial(), matching intel-iommu's handling.

Do it only after the queue is fully drained, since the visible entries all
precede the loss point: a group whose LAST-page entry is still in the queue
gets assembled before the discard, rather than losing its stored partials
to it.

Nothing can arrive in between, as an active overflow inhibits new entries
from being written to the PRI queue until a final CONS write acknowledges
it (IHI0070 8.1).

Suggested-by: Harsha Vardhan V <harsha.v@oss.qualcomm.com>
Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c631c6344685d..0a15556c9a558 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2441,15 +2441,27 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 	struct arm_smmu_queue *q = &smmu->priq.q;
 	struct arm_smmu_ll_queue *llq = &q->llq;
 	u64 evt[PRIQ_ENT_DWORDS];
+	bool overflow = false;
 
 	do {
 		while (!queue_remove_raw(q, evt))
 			arm_smmu_handle_ppr(smmu, evt);
 
-		if (queue_sync_prod_in(q) == -EOVERFLOW)
+		if (queue_sync_prod_in(q) == -EOVERFLOW) {
 			dev_err(smmu->dev, "PRIQ overflow detected -- requests lost\n");
+			overflow = true;
+		}
 	} while (!queue_empty(llq));
 
+	/*
+	 * Discard the partial faults after the drain, so any group with its
+	 * LAST-page entry visible in the queue gets assembled beforehand. An
+	 * active overflow condition inhibits new entries from being written
+	 * to the PRI queue, until it gets acknowledged below.
+	 */
+	if (overflow)
+		iopf_queue_discard_partial(smmu->evtq.iopf);
+
 	/* Sync our overflow flag, as we believe we're up to speed */
 	queue_sync_cons_ovf(q);
 	return IRQ_HANDLED;
-- 
2.43.0

