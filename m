Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012066.outbound.protection.outlook.com [40.93.195.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052774BA1C0;
	Tue, 15 Sep 2026 16:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789490373; cv=fail; b=CftJq2O7lwoRKJHWlprYFQVocmN8+J8+COm3n3j3ax7LpFOeiBVI0xB3hXNOVNguLIGhlPASdUrB6M+BaO0iGdcfBsijmzNZZLWYWxqjqt/zod/Lg4DZhLHmwydf+UYG3hBG6xynHLS7N9zYjSJ6c47MLl3aGQpmgWYxhk8fY70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789490373; c=relaxed/simple;
	bh=yUl41YnlGfqAp/RiDAA42ck00GVoqdCVjzS+GtGTmg0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MmGNZrdVWlnUXnXZ0vxa/KtoARAOCEbMpBCxNnJI63Cz+wu0T9AAuqzC0B9cK3wdArSyCZFWlvPhbINwieCDwFV3ER9eyjX7HEr2zIFiJfbTpVzOf9qMTldTP6Y3tK+e5KVJp5QcFoi7so6gLMQcSni2U9GTh0g5vrnvKQ7ekyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nlo4ntbR; arc=fail smtp.client-ip=40.93.195.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nlo4ntbR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8sXm5WG0ewdtwVkFv3IXtlTREWNhvS4ZCfJW0sEW729wj8NoLcqzfDkMAiHArZ3zYoX4WnQRk15o8AZ7MMznVU8QO8IRrLgJlVnN44fJR7ZbQd5EtYHRygne6ha4SY4IWAq74FFvegsyBmDCNjcsX723+pJjmc02JyTxkg+XQp594/1AkpdMa8vSqc3XZFYftcuqhDkYBzhLM5egvmhvIy+XxjWa6UtG4n7D0khg/+MFQYnp8Ql7etG1wab75V1A5B7kOKrjnL45QucqXpjACg23aWvI+As8czL+qM6wVWUDvCcc2c60T2JS0S3LHVu/zWxKL4u9PQknRjR15HmIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bragBSKKHgCpw7Rzzz0Fnfn5fAWRkUNFRfmCuucCH0=;
 b=XKhzgM/qDqM36NamNfb2fERx3t3l384CIX3QYkQVhd2Uk0knIZATArV0P6t/t6Tdy6KSNS5XJfqxEb3cR6CbWa1STJD2nJQhtPRNp3Qc1Hs1gev24l9CNaII55T8TKHh72gZtUDBPiK5UaG8LCb2u2ngTi/Uof7sr/+ZvIKgnp/347YLLwD2vKpaQBZ63Uke+FS6PNFhPXOl67kiHaiRoFS2d6YOs83J5TzGKZi2qULDhXZEPiDSbsZtbN32VrR0/wSznOBlbGRr2fHu9SbJs6MTMNFblmhO1uMT5uip/wiKZc4ZlP4p0IbW9/DY902zU/93Gm33MvIuUN9fDTEzkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bragBSKKHgCpw7Rzzz0Fnfn5fAWRkUNFRfmCuucCH0=;
 b=Nlo4ntbRzqu6vhAE955Dc8/frSGo03K02X7auK7IQFsbY0ScWxceYpScbDPL+0t8gFA8l1o5wDM+eHUjkGugkbcHgt3i2/S9rxhvMEm2W9lLEZmZ6r+NM76FQGhOXpOXwLevF2MlOKNAVmAvGHxTslKv2O7NyoR9K21asSipU6yeyK/2aXhHbm65B3D/9liELlyYCuCqwsCqMs9pNCveCwhHXQVnUQJXkZlTsPppjjld66Nbav57zlXmYDL5v1hV5MnSx+CmwvS3TJ2IfaBe09gmRoYt1MZcm4QlSP2/ydErMoKLxOjerZ9UZNbnT2ic5vyHHDRZ8sRgBbjVqkkn8Q==
Received: from LV3P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::12)
 by CYXPR12MB9441.namprd12.prod.outlook.com (2603:10b6:930:dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 16:39:15 +0000
Received: from BN1PEPF00018075.namprd04.prod.outlook.com
 (2603:10b6:408:234:cafe::2d) by LV3P220CA0011.outlook.office365.com
 (2603:10b6:408:234::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Tue,
 15 Sep 2026 16:39:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00018075.mail.protection.outlook.com (10.167.245.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 16:39:14 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 09:38:45 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 09:38:45 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 15 Sep 2026 09:38:44 -0700
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
Subject: [PATCH v5 10/15] iommu/arm-smmu-v3: Support PRI Page Request in arm_smmu_handle_ppr()
Date: Tue, 15 Sep 2026 09:38:22 -0700
Message-ID: <dd1ee0afb947b5f7c229c21b7fcff5d18f9bc326.1789446520.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00018075:EE_|CYXPR12MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: 427742b6-187a-4a6f-8724-08df1347e0e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700016|23010399003|1800799024|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	gbYnTlaMp3QjA+d2w6WnoE/eSh54cqTbc6IQlo4sUwlJGlPOtNZ+gS9KnLpfySB8zafhCOkJxR80kXhr59rnBlOcFj64kNsiB6UmaTcfKeL/CiKeysUxY2mX4HH/ObllDkhPcAX4doNF0maj9XJfi1pZ8qg3nTLAb50rb4X5gVQ+O54S4Tp8EIMFrdaqVyUYKm/wEgefizHKYM8FOTu3XP3isD4POWPzzTtJ1MlzJk5Y1yYfkkrWeouh8TDV20kI9pGf5fVVWoYml1Au25+Pa957Vr+2MU9TP8FC2fddy/SOPwWcxxkurpgw1m9gKoflD3+E14gmmpcFB7XALTPOF/QBSHUhyNzrxwYAzX8K7uyXXuiK+iNstnTgiptjkp78R0nGIUyOZvl5GytuAawKJmGrhlEYPGjWV+6HgJkzKJJPVv7JvxrVG5QUplQuYsrLNm2oE9GjxlNfcGsz9FRRLMsSMu0JctLHI6QERJfkSlPnT+uCEj9JdAfd9nlph+ltGwgt24P6z6VPP7bWKF1ncbOAoOBUXW5MDK3/aLotvaGGpLTbZ5nnSU9OJoYRmxdiv6JohETdqciKjcOM9BTU5aHBmJ/t0uZKrOudC5ZlN4ZOQuJPEZnkua7zmi+is0DSj+jbqrqc21/cpGwhscK4IYqTaclrn+AG5NwHdq9OMZFk1ZcqB2hjwYFn6x38hfkqsIV8LQidioIrb0T/vkvxVA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8fUWCbLt5s9nCKAof9+jMVuzjXLlq/woI+w+CGKrs8xysJQUtOELA9cEBeL3RilwO+N3GWX8OdBoANg+HKVQp+4R3heweJGpTwQk1Ykem2I/zTXfLyvae8t6NICnF4oYgAMNg8LlH037Onn/QPHU/H0zGrtvqO7JJ5GTHYzQdoingn5ssEpmYLUYCyJ0jdFjBFOsA8iFerLoJIxWMw+K+kV07Qg1fdAqQjYu3TX10oDZN3Sk/NKg8YeoGtWaxqL95fan5Q7bOJC7n3Uo/+z+/RdJxC6e2tQqNlx6Z2ZA0oOGa1nxRtQUenlpt+6VrwVeE9x6NyIE7nUCeOqn7EZDTLf4MaCyRPlEv94/2jigF9aubmW0WxsRKMNtLa65RuIJCZPyT2aHNxxCgCWnJdZG8hyRJWvk/e4IX/73ovyHCjScbH9Im4mdf+cCYUWjxFdH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 16:39:14.5113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 427742b6-187a-4a6f-8724-08df1347e0e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9441

For a PRI-enabled master, convert every PRIQ entry into an iopf_fault and
report it through iommu_report_device_fault().

For an unknown StreamID or a master without PRI enabled, keep the existing
LAST-page DENY path. Merge its two messages into one ratelimited line so a
faulty device cannot flood the kernel log.

Discard any PASID Stop Marker (LRW = 0b100) prior to the fault report and
the DENY fallback both, because a Stop Marker does not expect a response.
The IOPF infrastructure requires the driver to discard it, as per the doc
at iommu_report_device_fault(). This also matches the intel-iommu code.

When SSV is clear, the same LRW encoding is a PRI Page Request that expects
a response, so let it fall through.

Note that master->pri_enabled will only be set by a later change, once all
the PRI paths are ready.

Co-developed-by: Barak Biber <bbiber@nvidia.com>
Signed-off-by: Barak Biber <bbiber@nvidia.com>
Co-developed-by: Stefan Kaestle <skaestle@nvidia.com>
Signed-off-by: Stefan Kaestle <skaestle@nvidia.com>
Signed-off-by: Malak Marrid <mmarrid@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 50 +++++++++++++++++++--
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 40ea5bd382d89..17ca3fcd1b9c0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2378,6 +2378,7 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 
 static void arm_smmu_handle_ppr(struct arm_smmu_device *smmu, u64 *evt)
 {
+	struct arm_smmu_master *master;
 	u32 sid, ssid;
 	u16 grpid;
 	bool ssv, last;
@@ -2388,9 +2389,52 @@ static void arm_smmu_handle_ppr(struct arm_smmu_device *smmu, u64 *evt)
 	last = FIELD_GET(PRIQ_0_PRG_LAST, evt[0]);
 	grpid = FIELD_GET(PRIQ_1_PRG_IDX, evt[1]);
 
-	dev_info(smmu->dev, "unexpected PRI request received:\n");
-	dev_info(smmu->dev,
-		 "\tsid 0x%08x.0x%05x: [%u%s] %sprivileged %s%s%s access at iova 0x%016llx\n",
+	/*
+	 * A PASID Stop Marker (LRW = 0b100) does not expect a response and
+	 * must be discarded before fault reporting: see the documentation
+	 * at iommu_report_device_fault().
+	 *
+	 * Gate it on SSV, as without a PASID that same encoding is a PRI Page
+	 * Request and it does expect a response. So let it fall through and be
+	 * answered with a PRI_RESP_FAIL, since iommu_sva_handle_mm() rejects a
+	 * PASID-less fault, or by the PRI_RESP_DENY issued below.
+	 */
+	if (last && ssv && !(evt[0] & (PRIQ_0_PERM_READ | PRIQ_0_PERM_WRITE)))
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
-- 
2.43.0

