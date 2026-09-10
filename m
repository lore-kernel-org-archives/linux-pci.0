Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011066.outbound.protection.outlook.com [52.101.52.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6354DF59;
	Thu, 10 Sep 2026 23:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789082270; cv=fail; b=LUpO9aQb/I19UcBYOnX/7y7qUOuh8Kpv41RqtajT9+FS5chyXkqjK54h7ef6+m9VJjVRaZn/Gsv0IjSYjrikHUz+0y8TeM5969ZP8oDU1DIZM/nUP3h4IawK4WVGFGdWtlzaHoyqqWD1wzY0FR+vC197GrXYVg8ODa8mBuloY6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789082270; c=relaxed/simple;
	bh=uPRmoxosqkKVVyt6hBrhQuk5ZGAiDgoyummf99yWhKs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oQnTCbPnHuPjc5/8uLSUXtxzNUl6O5tKac9I8QJje6aQ69g3zr9qp15bYDyIieasp8pLOOOMrpGIFyyvtLD4PlrkvwQeOPeJjMoU+XIbqHjXGrluQjlmqcxJBZV/GPqzL++13tvXnIIP52l1zKwAHDSMXKspy/UBa3UGXHCnWbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NboMZFP3; arc=fail smtp.client-ip=52.101.52.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NboMZFP3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+/4mmRSvY/FbcbJKamoILEDSxsYktrskbuix6KCIv0mZzk6BskvU2SRm5UB3IvO3faNwBOVregHRQ7FQf+Y+Z5TrYh3KcVjYX5WBtdEflKGQm4lLODT7YRcJgvqRVvWq3OwTRg5U78R+gxfr69IttOZXmFP/x6K2TXtJjFf/9DLd3li2EtjEpkrhh04wmsFQofqpZOOUa/IEiAWjTHBDs2X1piYvpTpPlgz4N7oZAO9Wifmu1klLj9NlRZnbdCSwKErs74PkXWDlhMwohbfHYHyAIvsM9RmG3a4IhNpwh4tBLqlN7aCZCcZSmy7YDzCBHbSOnFEtaWPDIAOvDLpoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsG6L24DUeRIu/bfGtboC5/j6gajsUqBfCeh1V5mLk4=;
 b=O4pFULBWTzXJdurHowHHE8YHdj4wQlc6BXMwTfsBgKqvrANDmOFfDOJgdM+Nq9BMeBRqfWTxCiSza3uD9Mm2TknB5z5MADKxkOX7JPdAixTDVOC0FebJJph0ruSB0wcjhhsOpAieNPhXkueoWMNTH7dRj+7XtI5O5wHf2UprHjSWpXcJFs97eOrQZoSX7/Ihf5ChSoKFT3CgUsnb/FN4opyHt9WL/s9Gdud6AQNSEGq8LGJ5DJnpg7xdbYT+BrXHBw9PGYm5JIdTKv2PUXcZ8v5q+mY0DrxkWOcRUcAV2u6+2RYBx93j0aRjqnP7YjBviwJOMsAa3QJ3s69IbYtChA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsG6L24DUeRIu/bfGtboC5/j6gajsUqBfCeh1V5mLk4=;
 b=NboMZFP3JukXqnm8Q4wcC5rTxb6bOY2dL58Pz9/7TVn9Bo9uWda6+xqC3yAVP2IhedQUVawyo9a3xU8bnbk0Rt/wc1YFFSON8TtvmuaexX4omxID5+KOE3FMPaYYXrJxsQeriQy8H1Sek0uZ/LZrbRsKsD6jGb1pXP61MsFtOItUmLlEn0kn3CVlRbr1WWGjJactxMj3Xqft9WoV8UihWVyVXp2Sp/sPIJ7ViJk94yoMBkZDG9dCfAKA7tly8DTF2q5TAVMP7k0PpKwkDHrF3Kn61SJFmut1ru3QQorLSTjZ/sMyqRd4EIW5RWVTu7l20HGiNGlvl1E0uTzz4vYuWQ==
Received: from SJ0PR05CA0154.namprd05.prod.outlook.com (2603:10b6:a03:339::9)
 by SA3PR12MB8047.namprd12.prod.outlook.com (2603:10b6:806:31b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 23:17:43 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:339:cafe::3) by SJ0PR05CA0154.outlook.office365.com
 (2603:10b6:a03:339::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.3 via Frontend Transport; Thu, 10
 Sep 2026 23:17:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 23:17:42 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 16:17:23 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 16:17:22 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Thu, 10 Sep 2026 16:17:22 -0700
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
Subject: [PATCH v4 01/15] iommu/arm-smmu-v3: Disable the impl before disabling the SMMU on shutdown
Date: Thu, 10 Sep 2026 16:16:53 -0700
Message-ID: <61536b87c45164b1f581ee4358574ee7822e212d.1789081084.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|SA3PR12MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: aadb92ee-9d15-4a1a-3b6b-08df0f91b750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|82310400026|23010399003|1800799024|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	iJE6u2y3JgUa6cnxTE5W+kNbJEW+V2NdvKBX0knlASnwSsGbS8QeU7hRjdPhxh/Ht1j/qByPfcH/mNUJk8jYI556E3yT8j+P8VJQ4rhXub2JcmaLxTwKs37JIyyPuXcomTbouvt9rO2VLGIYz8mi3bpZMqcQSUDq7cCSprZ6DwOvlvNr8QLSLTZvhiHpWvFMv0mTEkzk6ZCduD9B9gBMDf+gX+rYPQgfJwvZ2BAFVld1zLsnq7/jBVCXK2UKwTvsuqzz4+0JZr2kBZ4VbZ4BJeD6zMdSpdmeZCYFNqv0djJe5Jkpd5hNqLyJO3LO5/R9hU5AGdsqPo4a1tdDKQG9z9ZvQFjQS7HRObl3kz+YCjWiMBUGqNAYSyDj8tKwdQBEd7wpk5OewlAVy7CH8qgjR5v+J9h/SE7DWsuXqheCyqJ6PoM0IPOqEyR6O8V8q54H/rtCVjF9+7jdRR8x3ax9rKDwbOcJ8FRP5Knx4ZJWf+sLMo2JQ4jX8eRraKq/RzCGpnMYECD0shhPFN1LApYwUJumDNuzmmODcjnd6jzzKmf8x98BzDr8SJXHnKFOaPzVOV4SUPr10uIjR3DgfkaD1QfRjcd5ZvTFdPlp86zyRz9KeF6DIdbytqBCK3Ge9sB76/Rw0ZEfScbJ9asSiFJTwNXAGnqxLt5NljlXk6zAyI9tFvEtTF4glqG2XDPZYTBhnykFfQefcjOcr7L7ssVrRw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(82310400026)(23010399003)(1800799024)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rFWhug6jkeR1ZdCXFWvHf0FE/rxI8juCfdiV4MpxXEdocx6jfFFoSEAEl5DaXnGdjKHJL31OhVddV6mGFcj7ycdq4bmhFye+anX8fUUurR2cguhYZxYxayvj+t0JgUhvr6/j43a91gH808GhRm79ZnlrWumc8ekx3VrrkY3JdaIggoY+dSxwmSAYogFuznaMrqAXYycs33IWZMkvBLDWEE+UAWlHNa5nYvDwYyfQBAuudyQlFAKyZ3/cgye1Vm0BUq1Daz4wW8Pwe3pRj1m+I8o7PLvxv4OBWqkKgzaKnb/abVslHg9vG0Yemx921xUE8EhTUEcySEjtW9rssApoKOMeynVFHeM4L8FY+WnwaC/eYzOSB/0Kzre9FF3gmmclGo2LkRDDEl1KZLL3OunjiuiSUxJYe9KxnCFqQ6TemoDOO3d15ZsiNR0ittN9Yeg0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 23:17:42.9661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aadb92ee-9d15-4a1a-3b6b-08df0f91b750
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8047

arm_smmu_device_shutdown() only calls arm_smmu_device_disable(), and never
the impl_ops->device_disable() hook. On tegra241-cmdqv, that hook quiesces
every VINTF through tegra241_vintf_hw_deinit(), which issues a CMD_SYNC on
the shared CMDQ while it is still enabled.

arm_smmu_disable_action() already runs this hook before disabling the SMMU,
to cover an unbind or a probe failure, and no devres release ever follows a
reboot or a kexec to run it again. Have arm_smmu_device_shutdown() call it
directly, instead of reimplementing part of what it already does.

Fixes: 9ff145a25c5c ("iommu/tegra241-cmdqv: Fix CMD_SYNC use-after-free on teardown")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5732f3ba0122d..81baafaffc410 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5633,7 +5633,7 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
-	arm_smmu_device_disable(smmu);
+	arm_smmu_disable_action(smmu);
 }
 
 static const struct of_device_id arm_smmu_of_match[] = {
-- 
2.43.0

