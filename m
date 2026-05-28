Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013009.outbound.protection.outlook.com [40.93.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBC1367B6E;
	Thu, 28 May 2026 08:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779955237; cv=fail; b=p/H3YzNibrj6nvqfQIyRPnciE2jvY7QleYdp2HYbUKvxzlKkG4CIjPFOD05opglqmsgvpEBtFwhb+XgONO2VEPBCudodojFDnOnXlqHpK1AzvUtq67u2VWMJyub47zO+9Egv+Wod1fB9KU2Dg1T0gDR9Vp3Kv9WOp7IeXlpzaeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779955237; c=relaxed/simple;
	bh=6FVY2xfyK1iumfg29MAZ6k+bic87RK0jjI/WCwzU7l0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K7pseTiwxh4L0B+a8Yy009tMw9PGC1Z1xHPCvwxfg4G3x7sfjN+2n0JitceJubMNM4uf4IpkuyIlRqqNodjCgW9wK3DGvuW6rEyxQlBsN4E/wpGoTkn16O0qMuHtePH/bCmsG4gyYmd5TTR38t5k7gGjymFRp7eXPwrdhvSf10s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VbNLH7BW; arc=fail smtp.client-ip=40.93.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VbNLH7BW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgve/rXmHqndB6QiiyFfK6fzC0y97uGTx2tIADsFltj30hEyGu4uXoBvsCPPoh+J/oReP55/LOurvzFO+AQfN3NifxtChO6+mCTaL/+pmxBm9IUVgEiB7CLyOqOJrsMhcMFpr/BDduavUYK24fmXGsKkA3lz+m4jjxN6qCa9dq6R2Nn4tpZA8SplRU2T0asc3VDlmAbQ4fNln/dEw4osOavcB3ry5xiCrXVGYluiR1XJfq3DrB0vP77Cj5GDQVCIV3tjSosvFfP9Dc1U8Y1JkGbH9oKRNpr3iVFO5OeHMm7BS7P0yia/N0wyLv/g3sE/WZGwbxm4oPmogYmRu0EFVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bx2UFZLw29cKMkC7aOF7XpFva0R8UknvWWtY06QewIY=;
 b=ZSUYBggON5Vd1uo7uq8seswapMFpGrGUFTLbS65ld4ZwOk7WhwCgyM1JH167EVfDh8SQdgPw3vJ5bZwD4tMzaxavZvcCe16ESsQNjj3/xGPKFTlOtkel6knlC6jkvH70UZDJUK2G7qDyMmm5SC6hWHpXMdS/gvjXkk6MQ+jqRSDMfcgDRSI1MUKAc5xZHoqSP0BHWu635uAKdrrpsxqw6adz2Dylq/QmAM/89+35oqDCtcGHOz7yFwvGfvNHDnGymhlcKYkZsb8AHWmSntQWgVn0PBHe8V2RG2b14CDjqHOdcXX8ggzdOw6LhXjup7FrI93Uck91jIJ0JFdZFNmH9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bx2UFZLw29cKMkC7aOF7XpFva0R8UknvWWtY06QewIY=;
 b=VbNLH7BWofbQYT+M9tRdnZfuHVObab40EdLigMAZlHdV3RAdoV/txqE2szEDYtaTSSVFvNlr36tVuihjUhx0hxkpO0RdFPAPN8HpPrvUNaHGT98BZSA1zwzmeIBe870LCcAqQpJ/KjNQ8MTnK3kLTMrI1u2jDZbGy/hUJiusHeCyC8BSvyT95LquhqWtPpizjW47oD8//aFsj2yv6xSZT+bBdLAxKfyjKmwDAiM1Rte8PMk8c/LXr8QA73DRm+y39VAgEoffW4f2dkQbZywwlQMNPe64gk0p8svrESxv7lOTyCu8DBdI0Qb3q7TUadXB3B+5oJHzWOLyjKDf0Xsz5g==
Received: from PH8PR02CA0049.namprd02.prod.outlook.com (2603:10b6:510:2da::25)
 by DS0PR12MB9060.namprd12.prod.outlook.com (2603:10b6:8:c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 08:00:28 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:2da:cafe::5d) by PH8PR02CA0049.outlook.office365.com
 (2603:10b6:510:2da::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.14 via Frontend Transport; Thu, 28
 May 2026 08:00:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 08:00:28 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 01:00:06 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 01:00:04 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 28 May 2026 01:00:03 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>
Subject: [PATCH v2 05/11] iommu/arm-smmu-v3: Submit CMDQ_OP_PRI_RESP for IOPF event
Date: Thu, 28 May 2026 00:59:33 -0700
Message-ID: <6c713c724fa09bf5a1b5e2247c633e516036f079.1779944354.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779944354.git.nicolinc@nvidia.com>
References: <cover.1779944354.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|DS0PR12MB9060:EE_
X-MS-Office365-Filtering-Correlation-Id: bf200c17-b657-4b52-35b3-08debc8f2eab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|22082099003|18002099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	eKzt/ohtnNotZbklKEBrgqzxt9T4N+7nPF+bVjZsdEKk8MbAwSGVKb5qy8mm94Cfp/IN/qWkH1Skbxdt9GA8JLQWUT23rioCU7eeClyQzAAAkTPvUwKRWLiDvZTLPDUoVp43Y5PPxAHEoqxCy8Ag7FbNa4mB9mr3PaQuOl5nfbBj7yr4WhIeLZFnhQ+jbMtjY+xoNwZIsoo8WwFUo9VaxxmIt9AG8+FeXGHlQXeHj6cXtWh3oZS1fjKXji5VJXbeLzGH795Smupzo8c9dqcbY/+NM/nyfithfonLHptQ+709lFoNKAD4k3iFzLYD0Dwn0tAEs4cMLXVTC8JG6U22Py3yirTgFlj+5VWlr1nW7y8mBprA51UHs0K7UnpVh2Bq4qPdEsswzfpqzivcpxloB1uTbnKbaNKx2PxxYcN5htWOB/4di+EWvXPEwsBjeT4F43epgxsJAl70OlZMfAH2CWHgZVmuLnMjOh8S72UnWJQ0oaBie3mfdhU9hHZIhRQj+zcKG38o5DVORgaupXjwoqr18FTsVups0Xv+ccO7Y9PxGH+1NQ9DiNuWoXuW+jdpLRUl1V63lkEl/xHB2+GRKF97HpVBC4oUZjT5f4PCYT83mtLtZH58/K8AJWSHZ/hH/J2GsJXOZh7OsKEwVw07Yo4yY6cMODkCjtpA15+oINUw3ODrCQUhvOhhaPxDFWZfSn135CZPEj98VOYJhTBk6pNOvR+uPLDSMYzc89iFUrg=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(22082099003)(18002099003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Z0Y+PH2XxW7paP5Lsc70oC45C5DbgRv8tR654t3oWzh6n2vf/m9/XuiFdUJ+REVHnzIp4GSTn2zzEmOJ9yu5gJmL3llmAk3q19zdlrjt8D5EdFoG2Q3xTtkH3XRGyDqV6lleju6wFwPhnBg2nqFLQXfzMPqosUPm9dOmU5Wue7GyYehm8FXpv6zAmnV3JKy8LZzd+Pqsm/33nLHGnkCXXHRiLVblHKMHTDI/bkUGC30DuRE4CyySmzB6yZvbiZ3XeUrT5MF23DGBTni3YdLHVPpJxvphRGZ/I4HWAkgXWL/9ZzcbLt+DJg9QatHUZEbS4TILftt3TCHwUjVTmQ0J2POMgyDPy0H5XiAcudRV3tZfCGIHzMOoNGPf+4Pxbe8/44AwehrF4+AOtr9P6KgVozrzXK4FZQDILysjYvBjMCBCiZrGie33TiacCJLemZf4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:00:28.1055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf200c17-b657-4b52-35b3-08debc8f2eab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9060

From: Malak Marrid <mmarrid@nvidia.com>

To handle IOMMU_FAULT_PAGE_REQ from the PRI queue, arm_smmu_page_response()
must issue a CMDQ_OP_PRI_RESP back to the SMMU.

However, either a stall event in the EVTQ or a PRI request in the PRIQ can
surface to the IOPF infrastructure with fault.type == IOMMU_FAULT_PAGE_REQ,
and a single master can in principle be both stall-capable and PRI-capable
(e.g. FEAT_STALL_FORCE on a PCIe device with PRI), so master state is not a
reliable discriminator.

Add IOMMU_FAULT_PAGE_REQUEST_STALLS_TRANS to the generic flags so the fault
reporter can mark a page request that is holding the device's transaction:
    arm_smmu_handle_event() sets it on STALL events
    arm_smmu_handle_ppr() leaves it clear for PRI events

Note: streams[0].id remains the RID because arm_smmu_enable_iopf() rejects
num_streams != 1.

Co-developed-by: Barak Biber <bbiber@nvidia.com>
Signed-off-by: Barak Biber <bbiber@nvidia.com>
Co-developed-by: Stefan Kaestle <skaestle@nvidia.com>
Signed-off-by: Stefan Kaestle <skaestle@nvidia.com>
Signed-off-by: Malak Marrid <mmarrid@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 include/linux/iommu.h                       |  1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 75 +++++++++++++++------
 3 files changed, 58 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 2bb810e4d5fce..1083621705f16 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1007,6 +1007,7 @@ struct arm_smmu_master {
 	/* Locked by the iommu core using the group mutex */
 	struct arm_smmu_ctx_desc_cfg	cd_table;
 	unsigned int			num_streams;
+	bool				pri_enabled : 1;
 	bool				ats_enabled : 1;
 	bool				ste_ats_enabled : 1;
 	bool				stall_enabled;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e587d4ac4d331..83c4dfcf20637 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -76,6 +76,7 @@ struct iommu_fault_page_request {
 #define IOMMU_FAULT_PAGE_REQUEST_PASID_VALID	(1 << 0)
 #define IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE	(1 << 1)
 #define IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID	(1 << 2)
+#define IOMMU_FAULT_PAGE_REQUEST_STALLS_TRANS	(1 << 3)
 	u32	flags;
 	u32	pasid;
 	u32	grpid;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ffc9621cd2288..061f1d46fda0d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -921,32 +921,68 @@ static int arm_smmu_drain_queue_for_iopf(struct arm_smmu_device *smmu,
 	return ret;
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
+	if (evt->fault.prm.flags & IOMMU_FAULT_PAGE_REQUEST_STALLS_TRANS) {
+		u8 resume_resp;
+
+		if (WARN_ON_ONCE(!master->stall_enabled))
+			return;
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
+	} else {
+		enum pri_resp pri_resp;
+		bool ssv;
+
+		if (WARN_ON_ONCE(!master->pri_enabled))
+			return;
+		/* PCIe allows only one PRG Response per group */
+		if (!(evt->fault.prm.flags &
+		      IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE))
+			return;
+		switch (resp->code) {
+		case IOMMU_PAGE_RESP_SUCCESS:
+			pri_resp = PRI_RESP_SUCC;
+			break;
+		case IOMMU_PAGE_RESP_FAILURE:
+			pri_resp = PRI_RESP_FAIL;
+			break;
+		case IOMMU_PAGE_RESP_INVALID:
+			pri_resp = PRI_RESP_DENY;
+			break;
+		default:
+			WARN_ON(true);
+			return;
+		}
+		ssv = !!(evt->fault.prm.flags &
+			 IOMMU_FAULT_PAGE_REQUEST_PASID_VALID);
+		cmd = arm_smmu_make_cmd_pri_resp(sid, resp->pasid, ssv,
+						 resp->grpid, pri_resp);
 	}
 
-	arm_smmu_cmdq_issue_cmd(master->smmu,
-				arm_smmu_make_cmd_resume(master->streams[0].id,
-							 resp->grpid,
-							 resume_resp));
+	arm_smmu_cmdq_issue_cmd(master->smmu, cmd);
 	/*
 	 * Don't send a SYNC, it doesn't do anything for RESUME or PRI_RESP.
 	 * RESUME consumption guarantees that the stalled transaction will be
@@ -2081,7 +2117,8 @@ static int arm_smmu_handle_event(struct arm_smmu_device *smmu, u64 *evt,
 
 		flt->type = IOMMU_FAULT_PAGE_REQ;
 		flt->prm = (struct iommu_fault_page_request){
-			.flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE,
+			.flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE |
+				 IOMMU_FAULT_PAGE_REQUEST_STALLS_TRANS,
 			.grpid = event->stag,
 			.perm = perm,
 			.addr = event->iova,
-- 
2.43.0

