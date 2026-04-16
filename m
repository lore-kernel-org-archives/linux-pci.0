Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012002.outbound.protection.outlook.com [40.107.209.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2127138C41F;
	Thu, 16 Apr 2026 23:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776382188; cv=fail; b=AOKYROgxXqpCYv/r5V+1ak4jKse1ybgxkuP/Bf7IDsRD+MbKOnDEXrIch+X9Evqmd6Ibbas327Mw4nlZXr9G8frj157G9jMfOKDJpCu/0mLv/PvUGcHZUIv8krCrm9rZZ5wQtfwzyHMRMwiZvm0y4MHIBodbo1jm9c9mfZuosFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776382188; c=relaxed/simple;
	bh=XXUh+y3/8OyQPXHL0QzOy0R3knvPWP6MIGCHhfoxsrY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gvtbfMW/ReM4K9UneyNMa5Jx5mJsY/nGGse1fb8grMpQ/8UU0MXnjma05g7yBstZRVXM7d35OdoPcmSo+QhW/dsBtrjB6SZeuMKqdiKbzX3YoEtDXWSAt0bVMcm04TMQWb6z7n+E9i9FetfV/kg4vBow1lK4rV468M/IiTfl85Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YuyH4+yg; arc=fail smtp.client-ip=40.107.209.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YuyH4+yg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPAqDsnbnbGyScvT8bwuSC+yl8AIIz7gUmqOcsuQnL2dTcs2iiFBYILCDyD/xSO6z44EIFePJ8OU4a6zib+3ptNT+nb3nOBQyIiyKHhbWrvgC1cuvF4asjvQyqW2HYuLvv9hnyXDgGNMqKDSS0opesKdptKYD9bqiUkFlmg+RSNuKW/fdqMslPwRMSTa2EFldXeG1eoDUhzyqRQxjSqj1ZvkENS7mF7tUFbqUQAcyo6XxbHwv/lPQ9/II/ztqfI534XLAhTKAMV5gViZ8eEKvIEs5rTb9naA+HNdGK0LFjql+FFbzWya6CbtcMyo8LO4h7oiqLl80h7TcBMJ56GBxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IY1NeW5/0RvWAIXzUFDtCqp6HnN5qhaGganIRmSkw5s=;
 b=gpVZDnHpM/rMEvDPhcl77RvfIt7HYGm0bDbnJkzFMnb28EQPqvOZzqPSVYKB1Bwf5nxz0I4MfpIxd6zRhC04HDC0ORWXQ9wmMrRdO76Y6KPWLQdn81ZNNncrOujBxjDYPOplFITcgnM4XHF2iioFbeltzsXtp23XoJ6aESjjYMtjeIyUw42P2BG9QUTXXzbvFcn6sUQfWww/9GEwFbfyzsREHCw7GJ3dkh9EZKck0hcpOiLn8r/yXy66Nae9lpib7+4SfATObqMaqhVmNIdC3OUUr8+f4XNdk08jqMq+gD1nHI2rZhAs1aGSy/Es5Rqm1c1l5pqXQun3TYUz5DLntw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IY1NeW5/0RvWAIXzUFDtCqp6HnN5qhaGganIRmSkw5s=;
 b=YuyH4+yg0rEkUfyXC+ovoI8OKoEOH5orz5a4C/SmaCYZ3Hq52K4tFihyQffnAFsPjtuXzl4DyEF3ZOrs7iy1OX8CUdSgjmzWUI8mCpfIfrqwS+q28pPlj2cjB+2l1atxVukxJjDv7qpPahL0us7+brNqDPUkBzlhDRaeEjY30Tbb/A9f8BmmqjLTy0fl6IbG8ShRqqSE0xrS/AkczIp42hUlMm6fiAr9UAYx/TG5neFnaAZkNSy8EmJ2G+af55Hau5RA0JnSk7J/w/HISf01OF79PvGp38lQbb+1ke5d1ZhMv0QKsBXbHou/CWx8DN1KmbRZ3REx8UqDuli0W+3t9A==
Received: from SJ2PR07CA0016.namprd07.prod.outlook.com (2603:10b6:a03:505::16)
 by DM4PR12MB7767.namprd12.prod.outlook.com (2603:10b6:8:100::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 23:29:41 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::e1) by SJ2PR07CA0016.outlook.office365.com
 (2603:10b6:a03:505::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Thu,
 16 Apr 2026 23:29:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 23:29:41 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 16:29:20 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 16:29:20 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Apr 2026 16:29:16 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vsethi@nvidia.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>
Subject: [PATCH v3 08/11] iommu/arm-smmu-v3: Mark ATC invalidate timeouts via lockless bitmap
Date: Thu, 16 Apr 2026 16:28:37 -0700
Message-ID: <dc42b28c08606c29f6e30772a92cf9569910829f.1776381841.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1776381841.git.nicolinc@nvidia.com>
References: <cover.1776381841.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|DM4PR12MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e144c92-42d2-4ca5-4fc4-08de9c1008b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	U2GQvC/BxKQrEe2zoHXu1C9EZVSK4MslMTGshFTRvVcV7Jt3cUbXoyiYg3hUIXZMFFQpZJsM8ad4X6krKbGauosZ67ypSMke8Rbs1rmKmMJCvxyu8BcvzK10vuztam/JV5xLoVV9SyWaENARB+42AIRJkON4xmV4w/+OdhDGjJ6bMciMsIGDVoQsE4tqHbCRXOp6/CP7NVtuRb1zavo+64R8f7qtpMIOAhIc7Iq8wUp2Jk2WoJ6BGkE2UNkx65cZfmJufqg9D8iYEFj7SwDfmQ3DZZn/FlyYujGjhthkZ6wA6YX2uO/BqOiSUjyCxKLDaiWVTwEtlr80yZyRsq5D8rNlsU/bFlTHe/EzIlONunyAutjSUXdXirRk3TKYqG62UIAn2AIIyc/odKYOfixSLIQHaaz006PFaTE8XkmyNhXoYjrncXVzJzYOiCxz3BbJSNQI8mI6rmQJovRfz5IpXoTOSQJ5XMbiXRsTKMrBb0regB4JBk8qCCurfmMjEcXv8CczRtCBn/a3xhndnqhFxwCcLW58CxYt31NsOcGjJQE2rcB5oVKhvaL4KZqZCSBWeW2A/ZIjtJ6weojXPLhVS1dwUtIGTR2tbqNT//LSiUh3nG0IdmTlqwdzqnamzwYPc9bQC5xNPiNFSokUZQHDMz5mAiPkU+0EYnGGXY8NkMwFh17apWSFA92NTfd5K1+OlQUhaUShGOb3fw8Mf+Jvg45fcmLdltQTm7w+EudkC2TRuwYMqqHOdfPyQH+Hl63m+xaQQ2Wc6u6NzJZmSqcuNQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6gNiJ/WSBj7fASdxqiYq4MFzwtHWbeppqP6Q0ppTKIIMQ9tIG16wZKaw6ZtRHPB2TEhUxCyyAo1umgzTx02GmY3E/RWP/Snu3FKPx6Kz03WDhJBc5X9DRHW/NolyxtP6xJPyO6zHvd4L6Gb3/2SnyqAP7sOM/nabCRHeCv67fGkEahEHVn9KHEqXa6cZj2yM9DsnOWUrQFuzWzuFJ+UevrTFnXtdMrejl0QRgtQZwmWGXGSQm/DfPdfnceWtiTnandP7TYsovJbPK44l3Bc5SfZcB70dK1Fo2vb0qmcywJaO8Oui5I/QIFSMexQ4vaEe0etOg1oMNa3B/knCnW6LCElk9TW1q2dIClsz5VpgINxqAEIk7lTQOC3zUqszOfMfo6lk4XUBEIAlHqlwM7kxuUbXs1cmd9kt6085PNdZwLgDmfDUIXu6t4GS4iXthspn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 23:29:41.1687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e144c92-42d2-4ca5-4fc4-08de9c1008b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7767

An ATC invalidation timeout is a fatal error. While the SMMUv3 hardware is
aware of the timeout via a GERROR interrupt, the driver thread issuing the
commands lacks a direct mechanism to verify whether its specific batch was
the cause or not, as polling the CMD_SYNC status doesn't natively return a
failure code, making it very difficult to coordinate per-device recovery.

Introduce an atc_sync_timeouts bitmap in the cmdq structure to bridge this
gap. When the ISR detects an ATC timeout, set the bit corresponding to the
physical CMDQ index of the faulting CMD_SYNC command.

On the issuer side, after polling completes (or times out), test and clear
its dedicated bit. If set, return -EIO to trigger device quarantine.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 41 ++++++++++++++++++++-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ef42df4753ec4..1d72e5040ea97 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -633,6 +633,7 @@ struct arm_smmu_cmdq {
 	atomic_long_t			*valid_map;
 	atomic_t			owner_prod;
 	atomic_t			lock;
+	unsigned long			*atc_sync_timeouts;
 	bool				(*supports_cmd)(struct arm_smmu_cmdq_ent *ent);
 };
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f6901c5437edc..f47943f860f3d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -445,7 +445,10 @@ void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
 		 * at the CMD_SYNC. Attempt to complete other pending commands
 		 * by repeating the CMD_SYNC, though we might well end up back
 		 * here since the ATC invalidation may still be pending.
+		 *
+		 * Mark the faulty batch in the bitmap for the issuer to match.
 		 */
+		set_bit(Q_IDX(&q->llq, cons), cmdq->atc_sync_timeouts);
 		return;
 	case CMDQ_ERR_CERROR_ILL_IDX:
 	default:
@@ -895,9 +898,40 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 
 	/* 5. If we are inserting a CMD_SYNC, we must wait for it to complete */
 	if (sync) {
+		u32 sync_prod;
+
 		llq.prod = queue_inc_prod_n(&llq, n);
+		sync_prod = llq.prod;
+		/*
+		 * If there is an unhandled ATC timeout, we will have no choice
+		 * but to ignore it, since this was left on the ring buffer in
+		 * the last round. And we certainly don't want it to affect the
+		 * current issue.
+		 */
+		clear_bit(Q_IDX(&llq, sync_prod), cmdq->atc_sync_timeouts);
+
 		ret = arm_smmu_cmdq_poll_until_sync(smmu, cmdq, &llq);
-		if (ret) {
+
+		/*
+		 * Test atc_sync_timeouts first and see if there is ATC timeout
+		 * resulted from this cmdlist. Return -EIO to separate from the
+		 * ARM_SMMU_POLL_TIMEOUT_US software timeout.
+		 *
+		 * FIXME possible unhandled ATC invalidation timeout scenario:
+		 * PCI Completion Timeout can be set to a range longer than the
+		 * ARM_SMMU_POLL_TIMEOUT_US software timeout. -ETIMEDOUT can be
+		 * returned by arm_smmu_cmdq_poll_until_sync() while ATC timeout
+		 * might not be flagged on atc_sync_timeouts yet. In this case,
+		 * we can hardly do anything here since the command queue HW is
+		 * still pending on the ATC command.
+		 */
+		if (test_and_clear_bit(Q_IDX(&llq, sync_prod),
+				       cmdq->atc_sync_timeouts)) {
+			dev_err_ratelimited(smmu->dev,
+					    "CMD_SYNC for ATC_INV timeout at prod=0x%08x\n",
+					    sync_prod);
+			ret = -EIO;
+		} else if (ret) {
 			dev_err_ratelimited(smmu->dev,
 					    "CMD_SYNC timeout at 0x%08x [hwprod 0x%08x, hwcons 0x%08x]\n",
 					    llq.prod,
@@ -4458,6 +4492,11 @@ int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
 	if (!cmdq->valid_map)
 		return -ENOMEM;
 
+	cmdq->atc_sync_timeouts =
+		devm_bitmap_zalloc(smmu->dev, nents, GFP_KERNEL);
+	if (!cmdq->atc_sync_timeouts)
+		return -ENOMEM;
+
 	return 0;
 }
 
-- 
2.43.0

