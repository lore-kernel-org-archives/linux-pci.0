Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011021.outbound.protection.outlook.com [40.93.194.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891094AFE3D;
	Tue, 15 Sep 2026 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789490368; cv=fail; b=ESbIAa2irCaBQ/lE6Qr8dzcWmlkkGcFZ12ioCzfPvpCdnwIdKOR/mEBYFX8ckg1LUW1qYRjGvm60fSHaMq/MvDIm/GUZgBLwnc++J6QYQK06SDy4ufLvC1B8ZkrtdPXIcha/9NpgkDvsauA0Yzjz8xPUZ6ER6XiB0UhWTEoEPX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789490368; c=relaxed/simple;
	bh=MCWradzktCwmkso9JuaDHnDm1C/oEI0KUcoImpbYMxo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ogp/M7rCCzG1opI4ck7Yyy4ES73bae74q+H0tWb5Y78T5I6WwIMyIzFfy3Y9Cr8mF172Vv78y1vw9/JLf0MWGdh/Mpk32PW9TVrdwP49770zzhfyW4C+p6Fu2ZKax/BD1dxXz5WeYbV/n0Ki96D5dgW+GjjRA1RtpBduEFdD6OE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V2mD8h55; arc=fail smtp.client-ip=40.93.194.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V2mD8h55"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XU/PXGv+Ct2Jx0hQv/T3gWNU55PBaw5MhcV8wEfx/daUoM0ixlr5NWSjNqRaoYEiDhCRGMuHZYE9qpSvZ4ro7jQtBraBGiBcrKzmbRxxdvNrzXfG8bsuU4AziPu8fdKRxGsG56okRuBdloRc7HvNH8RRrYAVcAN4vsu8K9Pau0ZE566plpmwgnm8Qb25sI0CG9RpZ3jXkdfJEnsYGvnoRn37AenMLFI+hPAaWclXS4FDMLFaaJdcug8J7H+atIaXBlvJXL6xJ9MwEpFPJSH5FAEJmFnfU4EGYUTbeQaMLzQBvM/YJJhSWm3b+UyFCQEDO3/jF5T5It7s4b7WXjISlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhYB9QcWbDucebqYt12sXFjQeXsxYCOlRllNFm6alFQ=;
 b=vskjoBp2HeA2vF2MAj734aj3QawttSPwkAgrBIE0pJa30Bc92SNQCRTZj9ati45uIEn+im7Tkfy4FW8RUI+XmJ7y7jKRHvkrbwgn9e/A4PpAf/cPzUakadW2AYdwUkscEOGjvENb0LeNwNDYS/fIRlSppC8BTUOo22IOpDDP1hQPLrziJpS9yiuKxFvp5hVUEQF5ph814wJ2uZnCCxYOjJDljWyAxcBSK2K+yAGnIszQovLDLEZGXb1ENI0ynb8FNIWgj1FuTH+F4okANONkZCmkAQ3veatZ4JGrR7HRErFrR4Vxt7Ujnwp24h7Nbw7XRSrvCg17f2DBdnlcOvhb2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhYB9QcWbDucebqYt12sXFjQeXsxYCOlRllNFm6alFQ=;
 b=V2mD8h55xEHdn46AKqIbe5WnSy2N8bgnXOFgpURaW/DGKKKO4yBSvuZFkUDOyjTThb8lzXzT9xuc+2ffxXjRFS0k0p8Ttcnm/D+iphqW8eYZewJpi05C+MkUWuaALEuRwsaw5jauhaTsCvYozxsolpJT4cZ4mQ65PP91mdUNLlCY18koq+YOE4xxzrJrGPffdit+pY8TyECkjREG3cq4W5n6jCLi1Q+ROS8JUObHa2Aqo/5b+NM+2zlCHT3jei2Wk1GrQHOok66y7pMkzasq0o0HzP6vlA4A+W07N4By+szZdxwkznwhvZaL4ZfWGGG6+dVHDJMb+p8c7nOapAUKlg==
Received: from CH3P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::22)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 16:39:15 +0000
Received: from BN2PEPF0000A7FF.namprd02.prod.outlook.com
 (2603:10b6:610:1e8:cafe::6e) by CH3P220CA0017.outlook.office365.com
 (2603:10b6:610:1e8::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 16:39:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF0000A7FF.mail.protection.outlook.com (10.167.245.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 16:39:13 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 09:38:42 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 09:38:42 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 15 Sep 2026 09:38:41 -0700
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
Subject: [PATCH v5 07/15] iommu/arm-smmu-v3: Submit CMDQ_OP_PRI_RESP for IOPF event
Date: Tue, 15 Sep 2026 09:38:19 -0700
Message-ID: <45d72c3be850a5dc29f7695b244ce0da97f97f9e.1789446520.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FF:EE_|BY5PR12MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: 56bafd4b-e4a4-4310-823a-08df1347e00a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|82310400026|1800799024|36860700016|5023799004|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sfM90WFAQJQhz71d44qVaK5cwpf5O8aO9l6Zk1ZLxAQoP5BqbjVkenapD8TwQ3G5pD4ZljiYmLQfGcGo1zhbUGZHx8yQMdpAS+eFQK/AANJTTvX+q6FvhXvMHLsqRrDuGjZTmPqD5Xit4tkdTQwl0dW19PEULk6NJ1KdC/tpr308KWa17beaB0roFAiNcIKsYWhE1NKLfMAIK8Jy3RndpSCv52kXkEQduiFOrF47Ij0zTQ2k3JH26t3CzTodhqnq3dDzObUoCd8AI89jAxbUQkr2V+Cf8khKfp/1XukEFGtkb1o3ExBMLW+oH3XlVDOM0+6utRMifJL9drHb4k4D39K/m4CScdxcLQ/c3vwELAtAcNftebRUTTmhIK4+cjTtBZo1QoeLgMUtonSFZvg5D54gZJATWRQtnvAFJqZK/3/Fi2VrlThmqrJkzM1wAWi/FmMVjD2x8LCUyTFD6WH187UwrGDVt3VW6OFa5DmeCwNRe2FcVzhj0kh5uyfZ6ZrY8fPxqCLlYcxz+rUSmO3nW6glPnMciYtwUoz/V3Xc4MbXcOJycXdpZve5D18SMHKSfdIrdjJLyPDBflsElEh2sC58H7Sf4rgRqB5LdZUw3+TT8RJ/Nn1SMK+7OjnSROqMuaGVi6IBdE2ZtSacG8cpSw610NytPTvSw/+K/jryHCtPrQEU38tZ6pQidz+uyZSAfFaa/ROYvEgj/rcl9+x5pg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(82310400026)(1800799024)(36860700016)(5023799004)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jhFz8SXhMXnWWDS8Lluzwe4aGdjpbfHpVZSmmDZ1Xec16QeRuxaLhuCnLvVbZ8qsmMjs7yQ3AbuVJXhYILR7XDqjIUWSDritS7tWejKJixc1CgnG0LY8BnLlJfunzhNuwKSvpOLLpwniCnR7nP0kzFkTplMzN4KtwvNjsTEmAEk+D+CCE8SBhgmKV1qb+g1mW1BQvM5YWF53ZfzNuOFG+epcNhF5LGjay6hq5TEq0zvpbOI6HS6etbZ8wHLZG6cxBD6fzPnMf6s09/C1crNjcRMC1rg5Bxj6gApsEilmEw1+XeiaxM5Mtp1WZUp1mf2054LNx7cMl5wpkBe5/HO7oGIYnIhe0liSB7XAS5BwzODVRdfonoBHZKhwEocS8f3TLEl0jfU4ROuZVMeWHnqNhGpgLweGmmn5buxG1lLHljgaGKK7SuvWAVXmzM6EunSp
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 16:39:13.0310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56bafd4b-e4a4-4310-823a-08df1347e00a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A7FF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307

From: Malak Marrid <mmarrid@nvidia.com>

To handle IOMMU_FAULT_PAGE_REQ from the PRI queue, arm_smmu_page_response()
must issue a CMDQ_OP_PRI_RESP back to the SMMU.

Both EVTQ stall events and PRIQ requests reach the IOPF layer with the same
IOMMU_FAULT_PAGE_REQ, but these two fault models are mutually exclusive. A
stalling master holds a transaction until CMDQ_OP_RESUME and has no reason
to send a page request. A later patch rejects PRI for such a master, so the
response command can be selected from stall_enabled or pri_enabled.

Note that a CMD_PRI_RESP.Resp encodes 0b00 as ResponseFailure (a permanent
non-paging error), 0b01 as InvalidRequest (page-in unsuccessful), and 0b10
as Success. So IOMMU_PAGE_RESP_FAILURE maps to PRI_RESP_DENY (0b00) while
IOMMU_PAGE_RESP_INVALID maps to PRI_RESP_FAIL (0b01), following the codes
rather than the similarity of the enum names.

Extend arm_smmu_enable_iopf() to also proceed for a PRI-enabled master, so
that attaching a fault-capable domain would set up IOPF for it. Note that
a later change will set master->pri_enabled, once all PRI paths are ready.

Note: streams[0].id remains the RID because arm_smmu_enable_iopf() rejects
num_streams != 1.

Co-developed-by: Barak Biber <bbiber@nvidia.com>
Signed-off-by: Barak Biber <bbiber@nvidia.com>
Co-developed-by: Stefan Kaestle <skaestle@nvidia.com>
Signed-off-by: Stefan Kaestle <skaestle@nvidia.com>
Signed-off-by: Malak Marrid <mmarrid@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 74 +++++++++++++++------
 2 files changed, 56 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 21b00b9296b31..558ba40f2f456 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1017,6 +1017,7 @@ struct arm_smmu_master {
 	/* Locked by the iommu core using the group mutex */
 	struct arm_smmu_ctx_desc_cfg	cd_table;
 	unsigned int			num_streams;
+	bool				pri_enabled : 1;
 	bool				ats_enabled : 1;
 	bool				ste_ats_enabled : 1;
 	bool				stall_enabled;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 0087a59da80de..9ebf3123e19d7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1039,32 +1039,68 @@ static int arm_smmu_wait_for_queue_drained(struct arm_smmu_device *smmu,
 	return -ETIMEDOUT;
 }
 
-static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused,
+static void arm_smmu_page_response(struct device *dev, struct iopf_fault *evt,
 				   struct iommu_page_response *resp)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
-	u8 resume_resp;
+	struct arm_smmu_cmd cmd;
+	int sid;
 
-	if (WARN_ON(!master->stall_enabled))
+	if (WARN_ON_ONCE(evt->fault.type != IOMMU_FAULT_PAGE_REQ))
 		return;
 
-	switch (resp->code) {
-	case IOMMU_PAGE_RESP_INVALID:
-	case IOMMU_PAGE_RESP_FAILURE:
-		resume_resp = CMDQ_RESUME_0_RESP_ABORT;
-		break;
-	case IOMMU_PAGE_RESP_SUCCESS:
-		resume_resp = CMDQ_RESUME_0_RESP_RETRY;
-		break;
-	default:
-		resume_resp = CMDQ_RESUME_0_RESP_TERM;
-		break;
+	/* IOPF is gated to num_streams == 1 in arm_smmu_enable_iopf() */
+	sid = master->streams[0].id;
+
+	if (master->stall_enabled) {
+		u8 resume_resp;
+
+		switch (resp->code) {
+		case IOMMU_PAGE_RESP_INVALID:
+		case IOMMU_PAGE_RESP_FAILURE:
+			resume_resp = CMDQ_RESUME_0_RESP_ABORT;
+			break;
+		case IOMMU_PAGE_RESP_SUCCESS:
+			resume_resp = CMDQ_RESUME_0_RESP_RETRY;
+			break;
+		default:
+			resume_resp = CMDQ_RESUME_0_RESP_TERM;
+			break;
+		}
+		cmd = arm_smmu_make_cmd_resume(sid, resp->grpid, resume_resp);
+	} else if (master->pri_enabled) {
+		struct iommu_fault_page_request *prm = &evt->fault.prm;
+		enum pri_resp pri_resp;
+		bool ssv;
+
+		/* PCIe allows only one PRG Response per group */
+		if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE))
+			return;
+		switch (resp->code) {
+		case IOMMU_PAGE_RESP_SUCCESS:
+			pri_resp = PRI_RESP_SUCC;
+			break;
+		case IOMMU_PAGE_RESP_FAILURE:
+			/* 0b00 ResponseFailure: a permanent non-paging error */
+			pri_resp = PRI_RESP_DENY;
+			break;
+		case IOMMU_PAGE_RESP_INVALID:
+			/* 0b01 InvalidRequest: page-in unsuccessful */
+			pri_resp = PRI_RESP_FAIL;
+			break;
+		default:
+			WARN_ON(true);
+			return;
+		}
+		ssv = !!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID);
+		cmd = arm_smmu_make_cmd_pri_resp(sid, resp->pasid, ssv,
+						 resp->grpid, pri_resp);
+	} else {
+		WARN_ON_ONCE(1);
+		return;
 	}
 
-	arm_smmu_cmdq_issue_cmd(master->smmu,
-				arm_smmu_make_cmd_resume(master->streams[0].id,
-							 resp->grpid,
-							 resume_resp));
+	arm_smmu_cmdq_issue_cmd(master->smmu, cmd);
 	/*
 	 * Don't send a SYNC, it doesn't do anything for RESUME or PRI_RESP.
 	 * RESUME consumption guarantees that the stalled transaction will be
@@ -3220,7 +3256,7 @@ static int arm_smmu_enable_iopf(struct arm_smmu_master *master,
 	 * device-specific fault handlers and don't need IOPF, so this is not a
 	 * failure.
 	 */
-	if (!master->stall_enabled)
+	if (!master->stall_enabled && !master->pri_enabled)
 		return 0;
 
 	/* We're not keeping track of SIDs in fault events */
-- 
2.43.0

