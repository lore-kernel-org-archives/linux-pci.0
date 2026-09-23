Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012068.outbound.protection.outlook.com [52.101.53.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C0F5803BE;
	Wed, 23 Sep 2026 20:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194381; cv=fail; b=iujHzaD1pbD0Dv3J6aQSuDpe2RIKCUt7KKzA2mULQ6qoXJdJQtC2iq05vibsAp7nwTnExBtq6WvuQIoMMt36b9nM4Z9Aq9H3WIBbdeb0NGgLF2qEgeE3MXbnbwxJJViDbWyivia3bKOR0XRgnTfQE52O4vMbR09OfqZ3xLKgvSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194381; c=relaxed/simple;
	bh=meLZ42H2Nckxgwei6R1UsIg6s97nKH2lPX+K9cIP870=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lSWblABCo+2bcOdul2/wPAsdeH78XwLIK0jVJG3+eGQhN4J4QsgM6FngiJmkLJuVYWFLofg6cyvwrREySOLLe01A2Tamaz/gBtSZJjhSCCLPDAqMWOyhBv08G4JGuRFgJiPOQw1qt5UQ2TXczhZaHzC2eBqXK0LiJgtMB+WN10k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ByGdt8dG; arc=fail smtp.client-ip=52.101.53.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ByGdt8dG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecRuTZWpTMsxWfOBO6XMtysHI+nLhtdhkf9qgCBu9izhXT20Moy4RdPfT7MVzlX8F/pEt4scBW8oYrTdHW2uBdh7lYkMBDzvavEyPuWi/YWT1f3g7oeFuGyfaHPsN1f66OsdeRTi7EWoMoAASzOrUn4ET9N2477V4vmBpF3hVbAbg6BC81z6C50AWZzuQcOgOp1UxWRFSbHfVIlg7H4SeHpj9fZZjwac8q3eGjf6/cqmucAng9uj9fX6b1RhsCJSX9bWN1hKZZ86TAT7cHq8nyuuH1pBo31wj3es+YwGyveWxzJ7ARb5PvZf6Jo4PJSssrPfwL7Bvwg+kcLn1jit9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zaV92e09m6jj8CC50ciRxAosC+BCO8CLiXdHTXL57A=;
 b=pvjMnvZezrvferRrT8KIayBQF0en5cK5lnwGsQZ3O0bH6l7KY7x5n4IMeHfG54cJ/8sEPZ6EnAUzak/9/AtXFhqwZdoDWXLp6zLoy3E7kLG4U403y1sHadw0LVeLS05ELD3psdGXZxswr7adAWCwEGZ5a+RF5x7ZEW6zQY6A39Rg7LHUCXAk38p87pHehZDtg4wOU5rQyo7aUBZaJbrILl60EayhKP3/KL+E3+F1BxUSogNm7RkqMCJ+ZZSOB8lw2ynutjHAh6sk8z1/S8rYV4Q8Ntyz2w93der+FQMJWrTs3TCzhcHYzlrx/2M+TXsgJhxkNHLa5SDONLSj0r0bzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zaV92e09m6jj8CC50ciRxAosC+BCO8CLiXdHTXL57A=;
 b=ByGdt8dGTMblfXpqBgB4jtPn3Y5NLvFxCMu9Px/uDhkpLHMWh8GNYYt+13oEemOHrxcKXTY9It21Yoaxk7UChpnMweLID1ID9pSU0OHG7yV+JCRCLcnfhEoQoGPlPkm7Ff5Wg+txqnV7REMohsSh0kTf+5ELJaddx83cXiQRSeR71DkFRZjjtuKgIlJaJLhF+FMcYidX2kKfixuWjXUh8az7kjIbfooa4Pk9UEg1HRdGb9h7wEweoCuWzExP2GgU7ZXFDawAYP8AcTA6Xx5mMdPimGGGayAfmbs7LDOQKwS5/VIdjp3xZsSrDejsJoMep1iVCAFr46+Fe47c1LLDXw==
Received: from MW4PR03CA0091.namprd03.prod.outlook.com (2603:10b6:303:b7::6)
 by IA1PR12MB9738.namprd12.prod.outlook.com (2603:10b6:208:465::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Wed, 23 Sep
 2026 20:12:32 +0000
Received: from CO1PEPF00012E63.namprd05.prod.outlook.com
 (2603:10b6:303:b7:cafe::4) by MW4PR03CA0091.outlook.office365.com
 (2603:10b6:303:b7::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 20:12:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E63.mail.protection.outlook.com (10.167.249.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 20:12:32 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:12:07 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:12:07 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 13:12:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<vsethi@nvidia.com>, Shuai Xue <xueshuai@linux.alibaba.com>
Subject: [PATCH v6 12/17] iommu/arm-smmu-v3: Introduce arm_smmu_cmdq_batch_issue() wrapper
Date: Wed, 23 Sep 2026 13:11:31 -0700
Message-ID: <234616c89cd2703e1d4682a22da46eff410f2607.1790188511.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790188510.git.nicolinc@nvidia.com>
References: <cover.1790188510.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E63:EE_|IA1PR12MB9738:EE_
X-MS-Office365-Filtering-Correlation-Id: d849fbde-5d4b-4e64-6d6a-08df19af0051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|23010399003|56012099006|10067099003|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	FpXT0BMscHzpk1DPkUOhNYP4/LFqaWSkRy4iXaSrgC893o6B2AJ6cBrB1QmGT8JusfYF4u862ALb6DOS43wNVleY8Vyi4E+8vCADre05K/kHslieGv7FIYwh4eSLwcAEgtBYPw8Nt5Bkxyenq4ZczsDW8/WG9G8qAsovjpv/bkGsQxP3eLFpRHN2H8y7YsG0hEjXXDwAjVSEMUUWuIiawN1k7lRxwszT2OuX1BVvrOHJ1Sg2E3Dg6CPp79HSonnSEwPLt7FqNCk1vUxFap39JxKyJaEvbtnzfXJOQNc73ocrcX2jjlAuJiQBvB/mnjp0EuptWOvEZHf6NA/exUoAMM/4vXAiez7Um1SHCd7MxUgnBx3rL89CaXSIDXSsrbrHMHX82qVJ7Q4YLbKDTwAExU4dKmbDby/iEkhVQg7BKy7jhAQj2MpZksHB28p6bhCvcRYYQrrE5ZFarTuNc2hIMttjEhpKHK6dk1f76waM6Zq+gKsb00l8bNMt/BW4LADuUb2mjmjq+wwgpfT9Zq1vhYHQGK+FlL9sfdeYJVYWF0a67vbHtBh8JltliMos0w9mnjY0300ACFwbZJ10TEKmPuwP0m6Ra7cWr/Js/eOGUy/Uy/fvnNlCyVU2w3yqY27d3NPBoZpNPLpGC4gAQNFyGcbXPJDnXMDCzELcxSgXdOWfuBpfE1XOWCKRgCQpxu0DADk3B+dpIy9zN9DrrjJf4g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(23010399003)(56012099006)(10067099003)(11063799006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PxF6dDa0Sb9a1yYwwCho41PiF+Q6sZ09vg5zO9sEMSgM536MgUoBvQ58Is706jztUZltZlmU2ttHXmzkQM6Ya+a2N6plwB8lS7i6iRbYCl+2j4rSqMwtgOkXQlMSDzgcN1oo5oTGSNrx2cNUOUJUrT1BO60zETIUIr27DLBwQBCwg2/nqJYSNYp42848NZ2PqryJAxr89iGa2l7/PkUUUbVQSW3w8Oxl7bstYJ4DPwoWK9ATOZp6MQaymxOS7vd9TSQ2tKljUg+OKwmwIhZBsCXzq5rpdwtUjOxyUM+2aiC9hXyIF+8dvZtZCdeHj6atFs/B1vl5ae76DIyPXJ82Vs9mRDHuxQlPY+MpBjfR7dE/5cUlr0duXQI4Ma3BcN4qvKSUjHusTOzdQ5JMUbMCs3oEYzA2SC4sCu72GNNQ7fIPvUBHNzlFTU5xS0LdOodV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 20:12:32.4155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d849fbde-5d4b-4e64-6d6a-08df19af0051
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9738

Both arm_smmu_cmdq_batch_submit() and arm_smmu_cmdq_batch_add_cmd_p() call
arm_smmu_cmdq_issue_cmdlist() to flush batches. A future change will retry
the issued commands on -EIO, using the arm_smmu_invs carried in the batch.
So, a single hook point is preferred.

Introduce an arm_smmu_cmdq_batch_issue() wrapper, so a retry logic will be
simply filled into the wrapper.

No functional changes.

Assisted-by: LLM
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3081ef407fd69..c3c31d4010a0a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -965,6 +965,14 @@ static void arm_smmu_cmdq_batch_init_cmd(struct arm_smmu_device *smmu,
 	cmds->cmdq = arm_smmu_get_cmdq(smmu, cmd);
 }
 
+static int arm_smmu_cmdq_batch_issue(struct arm_smmu_device *smmu,
+				     struct arm_smmu_cmdq_batch *cmds,
+				     bool sync)
+{
+	return arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
+					   cmds->num, sync);
+}
+
 static bool arm_smmu_cmdq_batch_force_sync(struct arm_smmu_device *smmu,
 					   struct arm_smmu_cmdq_batch *cmds,
 					   struct arm_smmu_cmd *cmd)
@@ -994,14 +1002,12 @@ static void arm_smmu_cmdq_batch_add_cmd_p(struct arm_smmu_device *smmu,
 					  struct arm_smmu_cmd *cmd)
 {
 	if (arm_smmu_cmdq_batch_force_sync(smmu, cmds, cmd)) {
-		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
-					    cmds->num, true);
+		arm_smmu_cmdq_batch_issue(smmu, cmds, true);
 		arm_smmu_cmdq_batch_init_cmd(smmu, cmds, cmd);
 	}
 
 	if (cmds->num == CMDQ_BATCH_ENTRIES) {
-		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
-					    cmds->num, false);
+		arm_smmu_cmdq_batch_issue(smmu, cmds, false);
 		arm_smmu_cmdq_batch_init_cmd(smmu, cmds, cmd);
 	}
 
@@ -1017,8 +1023,7 @@ static void arm_smmu_cmdq_batch_add_cmd_p(struct arm_smmu_device *smmu,
 static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
 				      struct arm_smmu_cmdq_batch *cmds)
 {
-	return arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
-					   cmds->num, true);
+	return arm_smmu_cmdq_batch_issue(smmu, cmds, true);
 }
 
 static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused,
-- 
2.43.0

