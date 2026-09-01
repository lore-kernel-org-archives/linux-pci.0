Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010037.outbound.protection.outlook.com [52.101.56.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966FF366048;
	Tue,  1 Sep 2026 00:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222877; cv=fail; b=Ilt79OD8hRAKkBYkWUPR87sdzqPgNS9EXlC52mLYeUCUQ1yOqKviLSp2M4C/oK1y17gvAhD8Dos4ACJpPYnTMqK8QmsPl53Jfp8d0Pke83XbT5H7et/nxtSGHAtVLFfdSkG7aX0Tf7qA0iWjtkqUk2Q0zvCUAjep++l/GyBPn5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222877; c=relaxed/simple;
	bh=j4nbtHKrd8RfLmZ8ycnnGri0NnQqFCUKRWqnxAmZGjM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sxioXYSDmNm/CIHJKWGCMd5OgYdH0TL9X5mRx9WO0ka2xvEe3UPzxy2OFpy3cl8kJmLg222jpUwC7j8OS6Lq9uiih+MFqhjyMKyCUPoeLwIhPR8XRFnApS1oPKNdq1Jcm23G9tYKb8CkgHgUAQqRfvxOjJA3/QDrXopA21UajX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GsPydEXZ; arc=fail smtp.client-ip=52.101.56.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GsPydEXZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edDYKJ+NiYr8tTGpNhokp1ZvkR3Ayejj9PX9njK7iLTM05ckOTTVl47vB0OplHOqwVCgCl6qxZ2l2M9QXDv3wSXBota2/tU1reEL/bHYk+PRz8az/BZbkeeh0OaIyOKRBMH5kywYD5dVQzrPcOzYkxEtSNDSo0bE1tmlwNBWacx9rZV/Yy3uyPzkuyM1D+xLJr0v/Kqiv2/DQindaHu9lL9N/pb/gVjP4LrxcffLUoJfr8qaLPXoU2gxBQPyFO4hLMeUAGeQrVKqHNm+Tg5016MKFoK8+32s5BAfnFQz9Zi4zkOJRT5q9rS+zY7aqcEsY/z+nkmqcwEo1qd3xe0niQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GE6+sUTrUKGjU5q60SnNN9KJrcjIAr9RM39PeWvtrw=;
 b=FoEWHm0DDueYMTFerzNCAiO19rEaqdG2qhQ7dFfCDDANSwrByZ+Ci9LtSZIVC31GsXxygOJSVYMRTqCnayfnGZWO2tTMAVNFTQvm36L9yBxReejBh/G3UieGRI5JvsNGRkbATSCNSB/kKTFQPmrbgWWdb7+LSeGQZs39ajTUZwu30HZaBZI1y/8SMd00AO2VK/6oPVO26jdtJIgdUM0Gf4yiiCVkrShJFDgNHsRsCnP8mpQHLBbZ5pHplU6i2Z7hQllUwgMgvWjY+/+H4KMOGZBZGQQtO+hXsBFnXL88VWmZ9LFmhU5OnXL/bxoEtcCaBmPAH63TWxO6lVGFnO5SIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GE6+sUTrUKGjU5q60SnNN9KJrcjIAr9RM39PeWvtrw=;
 b=GsPydEXZBamYydgGuFNmD78qP/AOxfC4UBh3NYy5dGFTswU9TOEvHuaRsE00bMxwuYRXIyMYGyvdlUknVXiayEmg1CCeGp6l6rA7cCDU3qFg2Wqg9nRfV6sPFydwjRciGuKtooVdA56tdxAm5T4n9z5Gl50b09qVk68Ulgg8AnW+IO1eUPAbZvi6I/8KC+1sXYV1gkOimYU+U85lSsO1D7rRbGW/RIh4DyCNnU+Bt/SV8mnWWwD5UdhqB6wKPp4Pou+b1rPkrX+VyASYuSVzz6yfB6TZpXFIqHRtTz0SuuTrXXxrOZc7zL9oZia9c0yhrmVhwhevw7Ulwg1IMZB8qg==
Received: from BYAPR21CA0013.namprd21.prod.outlook.com (2603:10b6:a03:114::23)
 by CH2PR12MB4213.namprd12.prod.outlook.com (2603:10b6:610:a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 00:34:28 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:114:cafe::78) by BYAPR21CA0013.outlook.office365.com
 (2603:10b6:a03:114::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 00:34:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 00:34:28 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 17:34:11 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 17:34:10 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 17:34:09 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: [PATCH v3 06/13] iommu/arm-smmu-v3: Submit CMDQ_OP_PRI_RESP for IOPF event
Date: Mon, 31 Aug 2026 17:33:31 -0700
Message-ID: <9280aea7ae7197eca3f223ef5b998aa25afb29d6.1788222485.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788222485.git.nicolinc@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|CH2PR12MB4213:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f2692b-ad80-4957-4078-08df07c0c81d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|36860700016|82310400026|56012099006|10067099003|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	y8iz3Ksa9Tqiu8NGs9SK5AkQJkhOdDYf/XT8dW3wMxyBS33fcV2RV1oM44/P4NwUqnOlBRHj7OPeYtp52eLOyD3s9xD9WMWIQ2rON7nMmd58Dw0mYLyOuiBm+Yh0AB5f0W1K5FO0BWVcZM2VRnZXZmJJJ2bvXfwZOtFYAfKN2sxj/eHh0GfkUlxuf1cd2CdGpqxyiIKByT9eF1Y3AH32wtKvbdhro67Ih2VVlKVX0bMsEUGkC8LeUSqhhDVPGwQ3EJjQK495YmHbAGmUKeHJvzytnvbKyz5Vuu7QX/w3WPlJEAIjLaEl+lZI87bCrjLxGtjtNljeFa+ibfGqpzu7kYoBIaWo0dDnTodzik6yxlJvYrzKSsHu2O6kJFS2FPbO3QGpYAAr0Zh6dJYFt3oDrizBgHOfsWtzYOLlPZ12mqtKGa7uLbYUxzCJQRR3PLFBAZdPkFTG1Zmk0u750XDspCuCg4xfnhWl8sjyisaVqFDwzS24lhzJcvw5+GRsNoKxoz+0lSiDalrWzCYGnIvkNcZZIoVlcDqi9Gt2elz9ur2++rlBKIEzD/1xgapxp3k4f/zDglHQSg5VK530DU13gtO7lkmWnpJLKZspeNVD4SjtIvN2d2+ZxU6v4IrdfdulSsq6fkxFuL3HkBQqw7AtUn0s884/HCSfIFIcxhYm3QXHKYbwjbvbYQmwhM8KlbM5uoWHIfYAR8LPoU9cDCn8Jg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(36860700016)(82310400026)(56012099006)(10067099003)(11063799006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TCaaiFcAhn3TdYq3jzhI/xnjFN/zboTCJDAbFRFjokN8Gh2Lk30SgKMb1AdvJ4Fo3xWHkNZfDwEsGk3edddohaST3j6TGGpdd3IpHCmAUaF1YiZ+KuWYrm5fN0siPnO6JIsMOvZPcBredAtITo3okF/nj3fS7IKcJJGpjGdKJjxqYmolV2Jdl0Iw7dD/R+0SW6CszDpCuBBlOYoZUOJgjGajZXMuZxmLOlf6Wxer0L0gKX58KJvITvlIaBPBwpEeNjlfeRQ8teA+gxMPU4AVigUEwVHHxNZ+nhEyaYN8/o6XzUYpEnx66MAJLbyaioExvW3WWoM2mO4JOsCs2mLB8zSKTe6kqk9Uu4kZZpMpuQ44xJ1yl4QkGpvHAirs+VCaEYMxT2B5Dv1FWHS6VMJWDe54b48qPMtX9/OxhIbLNO4W1fb6PsgckAOJ5Jpbgfpv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 00:34:28.1246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f2692b-ad80-4957-4078-08df07c0c81d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4213

From: Malak Marrid <mmarrid@nvidia.com>

To handle IOMMU_FAULT_PAGE_REQ from the PRI queue, arm_smmu_page_response()
must issue a CMDQ_OP_PRI_RESP back to the SMMU.

A stall event in the EVTQ and a PRI request in the PRIQ both surface to the
IOPF infrastructure with fault.type == IOMMU_FAULT_PAGE_REQ. SMMUv3 forbids
the Stall model on PCIe streams (PCIe must use Terminate), and PRI is only
enabled on PCIe masters, so stall_enabled and pri_enabled never co-occur on
a single master. arm_smmu_page_response() can therefore key on the master
state: CMDQ_OP_RESUME for stall_enabled, CMDQ_OP_PRI_RESP for pri_enabled,
mapping IOMMU_PAGE_RESP_* to the PRI response codes.

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
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 75 +++++++++++++++------
 2 files changed, 57 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index de7e4284658a1..92d21ded07ae9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1015,6 +1015,7 @@ struct arm_smmu_master {
 	/* Locked by the iommu core using the group mutex */
 	struct arm_smmu_ctx_desc_cfg	cd_table;
 	unsigned int			num_streams;
+	bool				pri_enabled : 1;
 	bool				ats_enabled : 1;
 	bool				ste_ats_enabled : 1;
 	bool				stall_enabled;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 352c916b2a572..64540cfb73244 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1028,32 +1028,69 @@ static int arm_smmu_drain_queue(struct arm_smmu_device *smmu,
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
+		enum pri_resp pri_resp;
+		bool ssv;
+
+		/* PCIe allows only one PRG Response per group */
+		if (!(evt->fault.prm.flags &
+		      IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE))
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
+		ssv = !!(evt->fault.prm.flags &
+			 IOMMU_FAULT_PAGE_REQUEST_PASID_VALID);
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
@@ -3209,7 +3246,7 @@ static int arm_smmu_enable_iopf(struct arm_smmu_master *master,
 	 * device-specific fault handlers and don't need IOPF, so this is not a
 	 * failure.
 	 */
-	if (!master->stall_enabled)
+	if (!master->stall_enabled && !master->pri_enabled)
 		return 0;
 
 	/* We're not keeping track of SIDs in fault events */
-- 
2.43.0

