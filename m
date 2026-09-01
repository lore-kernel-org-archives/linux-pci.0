Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011057.outbound.protection.outlook.com [40.93.194.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15803793A2;
	Tue,  1 Sep 2026 00:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222888; cv=fail; b=GljwTfepV2bYEnf21RKK5LVxuVShhNcvhhuvqmUEurHUAgSJ6Ow9koEq+21dJtGTfrVIwEJvBawLApwhksfMhm91/ZG5wkcFK/3Pc6zNDwUgDqo13D9JKIzlQrpIYku1ITkP3VrwWgk4h7uAnV3b7Y44DTYIsYuVS3vWxLralHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222888; c=relaxed/simple;
	bh=uThBMHS7gsfSNZrCnj6Z1j//GX4aM0OHFD+27Lj93z0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VKYOY56EDWLbF1L2/xvr60Vo4kHoAFqbnSDr8faKsN2CzZCbK3JaY4bjzZSZv/wQmlI2sIMNU8kLFOSl+HbKldEkgZSyxS1y8xmA6hydC9NKJvqEl1zmR5O7/buIiuUi24c3nx972dpg4x4EzA26SpKwpeajamfAx8wT0I9VoIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t/rfDSej; arc=fail smtp.client-ip=40.93.194.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t/rfDSej"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IEsYuJqwZ4CmcmgguRj6YDDqSgmub0kidKOGsD2K/d7LJg/9z+YnPeLi+fUfDEx4nYysIMN+La1JXi+eeIWhePssF+VdOb1MfIhTkduZDSNzoX6NgVx7yWUqTqUMxOxD+BH9w7n42df3n9BqDwWPjV9/AJROl6D0t0TKcDcg5NRNnFoCWro6t7GY/Ra/k3uV1N8szbDilAT+v8GYfLnNJY2T5mXIJahDNAp3MeuB0J76ZWbjO7D4ZUEk7+Dq49J8GLQjEmvqJporS5I0G5WroEBtBSxHAWhQokrlnUc0X6oE/8Map5gdbZ6NHMIXQIGKlPoB+IQxjCyoxKtxz6YY7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JltQqqbAIHaQqL0+0XCyLgjRKUs6AFh9kmMTMnuoqE=;
 b=Qp2S3+Whu8GKDm+kzyqtv1kIbOQSOBhOclQch3BbMmRD5vBMx8VrUaAqxhFkQdC+xXvLRXQ77cSYNQ34DVP92q98BtLyOwxM3gNuBN7QzHo09T4UXD7b4ZpTFt9L9U0vbnwbWc0/yg8TM8wMeTPOnDKTGhrYxargbBZO5ifE6DdXSqFER61Y6u/whOfxtolpigNUcHGWCB7L+9KQtF7wnZSHvC5bd4iVpbDCLRbiXPZOREmgWdJUXZza3/zABCN7Uj8X02xVhDN6EBH4l5mBEz//bqX7uSDP9Gc1h/sbsZ2Bnv0f8ha0juJ7DSF1ZOQwJbRTvDXYKEKUzOTOAs/Q3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JltQqqbAIHaQqL0+0XCyLgjRKUs6AFh9kmMTMnuoqE=;
 b=t/rfDSejvnQiAzACdr00dhw0+fDQ4HtIDYQAe/YGJPa8JWm8DdVMN14ndwsLLVqGNy0TEL1hpGNm0GwEApUwqv6K7o+c8IMFD1RNSGorqHWhUhRg1KdBdqHcBbA6QTbWkZShhV1Ow0WokjyWZ/sQKMjwV8ElSS5SGQFsFTSHDSeNZvqLG/N5xAF44lDmM1ElagY/6X9bco1QNhOX4ma3HhyaECjt/tJMKBR/1M5Tdd+8loBLxbbJH1dU2Oa3nq2BKZtebGc6okHyWMaoc0kRnf6Ba4vom/X9hboUfh2tZvnm4tstNxVVWNi/HOkXWAlPtW3p6N+wyRGjWcmvLVbXng==
Received: from CH2PR16CA0016.namprd16.prod.outlook.com (2603:10b6:610:50::26)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 00:34:38 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::a) by CH2PR16CA0016.outlook.office365.com
 (2603:10b6:610:50::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 00:34:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 00:34:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 17:34:15 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 17:34:14 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 17:34:13 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: [PATCH v3 09/13] iommu/arm-smmu-v3: Support PRI Page Request in arm_smmu_handle_ppr()
Date: Mon, 31 Aug 2026 17:33:34 -0700
Message-ID: <0fe5f381aae307045e4cab97f8000c575f34a9ee.1788222486.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: 581265a7-13e6-47c7-92c9-08df07c0ce68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|82310400026|376014|36860700016|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	hxNTsQl79WvODWvuvi9d2IxRUHjqcVsip5ujP1lSygKSmHOqinXzg7iiBhTUbiit7tkytgFtqGgZw7prIyRAawLdm19IhSLqImrZ7yMmBSXpUE+SrYorpyF+RcoI+amEScXWu6B9uPpVFeSDrqw/18oYaRDt8nfBnlxHoxUVnrh3P/UNSo8EqvRBa+dAy1aCgeIslq6AgynpmSAOgmS+o4pCFuvs/pwYfXuldcQuVTiFttcf8q7RXlZ77hCu7ZYMt/X86Q7touBU8GNIas8ZvWOjZ3B4O6SPSYrp1wOdxNN0soVk6kgRk6yMth5tdruJWwBV3A2rKup6xcHA4dMb8VVeC88KG0fs6NDXBWRJfXIWPLiMBLIobfeNLBWrms/bJzswlmKMvgGC/KgLX5KuyvCXZ6iVWJgZlmO61nQDq8WZ76aJLHbeuhudIhnxn1o3yxKQ3E4PIgtnNbskUeCPIyoEUCVgz2UVg7+Aru/53YkDbvW+tkKBqlxw04hN4GVZfKpWOkT71qeV35CsZCD5urIztjsKF8zXAm7KUgQ7PbjyeUhIBmnYqGKrorJes+M4BCFGa7V02sYkyK+YNV+Mhn7mp6MDXDLO/vIQRcTrCbe1ntNvJwOQM0zT1kECqFpyoFzQrTnoP6j+BnngxHZZv2dtEQIwJNwb8mqLw7Kjwat98szwhdB+cWEMw8X+IJfzmtKBzzYpDInxIKZd6gODgQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mmzEbGdAtb57C3JoGDaoIWSB7v5BzUYHNcxpZZFCHyEtc0yjxIcJdVW0LoxHaqx6lM9psrhYfqMyTshF9qlR0NyLlFThc1PE+AUMqiA+6/aerKG7HaCCOKv5ldvBDwjBywju57WzDWeGuihYHlFUD2qx7WdVQn3fYE7isVsz1PpVWLcHVlm7oDntyydzQuotIjZTX0q5gnem0i/fxDBoPECDEmcF7edTeHNTRDonsrYXAVel6YsJ0m0t9d/cOFVN+f2gelq9niyb6RfyO/XyaBUzBLVEq+EWIYSSjNoX1FPm3LaXWipEB/mIZX8nHg3LuYCyHtJPZPdAfRspc2FCyIa+r35c/ETexLGiRVVMi3xFzRwPogUZ441cyNzURIO//YAmzNGURWn1BXj2PqR2JRExLqnJ2blLrgC1XSzf+nCgvnU+1dy/3SPD9K4aqiEe
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 00:34:38.6382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 581265a7-13e6-47c7-92c9-08df07c0ce68
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8989

Now, arm_smmu_page_response() can issue CMDQ_OP_PRI_RESP for page requests
from the IOPF infrastructure. Forward PRI requests from the priq into the
IOPF infrastructure for PRI-enabled masters by building an iopf_fault from
the priq entry and calling iommu_report_device_fault().

For an unrecognised StreamID or a master without master->pri_enabled, fall
through to the existing "unexpected PRI request" log + LAST-page DENY path
to release the credit per the PCIe PRI spec. Merge its two info prints in
the path into one single ratelimited line, as a malfunctioning device can
spam unrecognised requests and easily flood the kernel log.

Discard any PASID Stop Marker (LRW = 0b100) prior to the fault report and
the DENY fallback both, because a Stop Marker does not expect a response.
The IOPF infrastructure requires the driver to discard it, as per the doc
at iommu_report_device_fault(). This also matches the intel-iommu code.

Note that master->pri_enabled will only be set by a later change, once all
the PRI paths are ready.

On PRIQ overflow, partial requests stored via report_partial_fault() whose
LAST-page entry was lost stay in iopf_param->partial. Drop them by calling
iopf_queue_discard_partial(), matching intel-iommu's handling. Do it after
the queue is fully drained, since the visible entries all precede the loss
point: a group whose LAST-page entry is still in the queue gets assembled
before the discard, rather than losing its stored partials to it. Nor can
a new arrival race against the discard, since an active overflow inhibits
new entries from being written to the PRI queue (IHI0070 8.1), up until a
final CONS write acknowledges it.

Co-developed-by: Barak Biber <bbiber@nvidia.com>
Signed-off-by: Barak Biber <bbiber@nvidia.com>
Co-developed-by: Stefan Kaestle <skaestle@nvidia.com>
Signed-off-by: Stefan Kaestle <skaestle@nvidia.com>
Signed-off-by: Malak Marrid <mmarrid@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 59 +++++++++++++++++++--
 1 file changed, 55 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 60f21591de9e8..502b5c7673bc9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2368,6 +2368,7 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 
 static void arm_smmu_handle_ppr(struct arm_smmu_device *smmu, u64 *evt)
 {
+	struct arm_smmu_master *master;
 	u32 sid, ssid;
 	u16 grpid;
 	bool ssv, last;
@@ -2378,9 +2379,47 @@ static void arm_smmu_handle_ppr(struct arm_smmu_device *smmu, u64 *evt)
 	last = FIELD_GET(PRIQ_0_PRG_LAST, evt[0]);
 	grpid = FIELD_GET(PRIQ_1_PRG_IDX, evt[1]);
 
-	dev_info(smmu->dev, "unexpected PRI request received:\n");
-	dev_info(smmu->dev,
-		 "\tsid 0x%08x.0x%05x: [%u%s] %sprivileged %s%s%s access at iova 0x%016llx\n",
+	/*
+	 * A PASID Stop Marker (LRW = 0b100) does not expect a response and
+	 * must be discarded before fault reporting: see the documentation
+	 * at iommu_report_device_fault().
+	 */
+	if (last && !(evt[0] & (PRIQ_0_PERM_READ | PRIQ_0_PERM_WRITE)))
+		return;
+
+	mutex_lock(&smmu->streams_mutex);
+	master = arm_smmu_find_master(smmu, sid);
+	if (master && master->pri_enabled) {
+		struct iopf_fault iopf_fault = {};
+		struct iommu_fault *fault = &iopf_fault.fault;
+
+		fault->type = IOMMU_FAULT_PAGE_REQ;
+		if (last)
+			fault->prm.flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
+		if (ssv) {
+			fault->prm.flags |=
+				IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+			fault->prm.pasid = ssid;
+		}
+		fault->prm.grpid = grpid;
+		if (evt[0] & PRIQ_0_PERM_READ)
+			fault->prm.perm |= IOMMU_FAULT_PERM_READ;
+		if (evt[0] & PRIQ_0_PERM_WRITE)
+			fault->prm.perm |= IOMMU_FAULT_PERM_WRITE;
+		if (evt[0] & PRIQ_0_PERM_EXEC)
+			fault->prm.perm |= IOMMU_FAULT_PERM_EXEC;
+		if (evt[0] & PRIQ_0_PERM_PRIV)
+			fault->prm.perm |= IOMMU_FAULT_PERM_PRIV;
+		fault->prm.addr = FIELD_GET(PRIQ_1_ADDR_MASK, evt[1]) << 12;
+
+		iommu_report_device_fault(master->dev, &iopf_fault);
+		mutex_unlock(&smmu->streams_mutex);
+		return;
+	}
+	mutex_unlock(&smmu->streams_mutex);
+
+	dev_info_ratelimited(smmu->dev,
+		 "unexpected PRI request: sid 0x%08x.0x%05x: [%u%s] %sprivileged %s%s%s access at iova 0x%016llx\n",
 		 sid, ssid, grpid, last ? "L" : "",
 		 evt[0] & PRIQ_0_PERM_PRIV ? "" : "un",
 		 evt[0] & PRIQ_0_PERM_READ ? "R" : "",
@@ -2400,15 +2439,27 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
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

