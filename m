Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C4836DA1C;
	Thu, 28 May 2026 08:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779955245; cv=fail; b=qnCnw8JIsQyB/S4zR/5+QxGqj8LjOdacWWnOjE/IKM/EHPKgVOdyMudUlbNuG4GHm+8xiYsLBKX4vzp5ZbM5va754CexzzO2thP1nk//iCMD9pK83dKjk2KSpEL/SgLP2m/JizxIEhEjYnSpASrfqJqXinC9rmgYqaJa3vP4pd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779955245; c=relaxed/simple;
	bh=eOxEG3FaPzcHMvg4JMVM6uJIeU+QjYXaon62aT+3hTs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uj3qGXZ9+yAOaUBh0NbCiKO8sXB+5VAY/aaMhb82LXi7LDzzLYs60twBIo/gwu4F98nNuCY8Z3M2Hu4kG/UUS1IvGIsGZgCH5s1dJBwP1CnDGF8LL7FTXUMM6aJJUQi5nKboR+VW5HXszpACjliERcRB71O1eTf7bxMcQP7a6V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f+JbJzHu; arc=fail smtp.client-ip=52.101.48.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f+JbJzHu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WB7iHCr7BjrbUfjQR1CpBpsNiRMA+9nkJl8sf5LgaNZkqhEVexbbmDAlUd52atkWjn6neJSjba9ssdcOSRGOk86Nz+GgH20vovh0BrluY5GYBfUw4Z6M4Qgyv7snS8zTpqhJGKZ/w+jyVO/6JIGfnsHfUUqNY5MKDJxSwnBZFwRrG7/HMWiiY9qurwwDnoZnM8f5pNHyKGSjf5nyHq8FmLpoeTakNurTvI1AeecBMhkfQzyzkV781AEPwsNwYZYivqyqn9/R7mwwXyU5CdAoCWfTN9ML+vUUnx/xGUKTLC8wb5mZ0MGodKaOBcMgrIrrt59wGmF457nH2mBc/PHjgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ws4VvRQSeEyiaLMO32ERf7G1k+ZOCYZoe9XJ0Gx40Jo=;
 b=NHAI11/ORig83+XJZ6fqQDcouk4y8XIbHNRImeFEG6lnjl9l9BePr3V1A7KES1aQyki0TQPjnMUO/4V6K/Yuw4BRzyYJ13OXoBpPgmWKv7R9mTxy0a6kUqtylJk+XpHqLmS2YdKHF9xAycz0/AMTfzUUmot6cWGqzbGomZ7KyzKSDDL8SM5GCZ8im3oNG5rIE8RklPLalTC2aYnc2v15JJVYblsAoPgRrEn9zYp+V4otGakXaPFCmfUi6PxFi0jh+vV5yyWhE9pM7y5RQFqlldiyA4x6FYmM08XQpq5fVdT5qipdMZTl0DTpuDOeEKtl1VSnTBNiYQCjiy7WTDyvog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ws4VvRQSeEyiaLMO32ERf7G1k+ZOCYZoe9XJ0Gx40Jo=;
 b=f+JbJzHuLBQw6BSGwGLsZCzpvn5+Ls1MjKAaylh5EbFcFrYQCK/dBEojAEsLi8ov3jDRKu46FuN1ujO6QqoeeMzl7r+l85Qm9TTKwPb9STZk0dkRcR+npMYkPvB1IJJwa2FX1ZNvgm2/Pwr9CJmAok4w2cpB5akJ5InlfxPOb3IMna7otFC5XtDurjhOcma9izjutG0RzvikxciN972z+QqHLMf+9NuLckkM1CBL7GaBf6fqK/UxKsAZdwsMIvd0QJwQFLcYJKeM4jhXneErzlSAgAR36FvIQgbOreS2G1NwIct+3m5txPpjOw520fN5iSR+oR54ueERfDTTvyge5w==
Received: from SJ2PR07CA0017.namprd07.prod.outlook.com (2603:10b6:a03:505::17)
 by DS4PR12MB9820.namprd12.prod.outlook.com (2603:10b6:8:2a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 08:00:39 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::36) by SJ2PR07CA0017.outlook.office365.com
 (2603:10b6:a03:505::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 08:00:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 08:00:39 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 01:00:14 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 01:00:11 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 28 May 2026 01:00:10 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>
Subject: [PATCH v2 09/11] PCI/ATS: Add PRI stubs
Date: Thu, 28 May 2026 00:59:37 -0700
Message-ID: <c0b1c3cfb88b5aabd57c8df729179e7d9a7f9404.1779944354.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|DS4PR12MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: 267a8c47-7925-4161-2583-08debc8f3541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|376014|82310400026|1800799024|56012099006|11063799006|6133799003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	4jTEMV9bgt/QThHPtmOs9brjqOIHL5isznyZffqT0xqEJucee+aOjx4W2bAKhbbskyt/YMTOmFPNncAxJSn91mt8Wd7hFvAtNfvx41nDmriBBpRCaFYrjBcAOavhV+Y8l7nl9Qimh5XPNF0ogRSr/e2hx/YypsCCMoy7m5QxV3K0CHDLluCGZML2usrrjueQNf++/0jR4NDSuSWDMflvEzExWbRL5MUTyQZsZpvop2ykvi9qHtSlSBSsmYHkuuICrjYGqR9G0YZM1KT1CRJgxe42OWAMHSR8N3imASgamBWBFyEGmViEyNsV9NpoliTLCjO0YCLxf0G6qEaAsUwA3LVxphKN2hsJ698rqHqnzHhkbkp+7LvuRMwLq+GcUqFra6Sa3fW0zTaLrsShIl21LafUyy49Zx2VH2HBdGLzmn0NBmWTfGr1/flK2mWI0RRrYg9ulVh3DERaPgN2CoxbQueZNp63/P6Bof0/X/TvCX69/mphSE9u5U7l1fKwKp6t92MqUWFOitHCTWr4KH/razYKrzBQsE4XGzeHXa6oHWtf75lR8OOnvDRem7lLXoHXhbbFpABJL8hTqm0CTx9QZXjsbnPRkZL1rottdc9UGK3XgHxXiRqqhMJdMyYWrYnJkGHpVZlWKlTAzfWz+4pMTiRCXp2DAO534zyO3bVuePbOSKqwm8ZO4yfiP07Y8RDlspTACGK8748WIY4ZEv42rNqFF0Pro7LClZ2jRIVnvV4=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RQ2kBt9N+uC/u0KILBGaphLHeqpUlCypxIhkoEnHLf5TF/o6hbPugLtXOzeGn5kfziS7gyou/6HG9VdTXYcPIcTFTy6D9etYq9y5x2lM9efENk2T18LGEKIeKQQats/slNUprN3M8R0m5jXdDZLITJCM5M88Cw3U6O5JVrpcwMDeRS1/InbWqX6rqgDTE7kK03HEyYLAXcnPqEpkVMAU8RR5iIxIGo1BkrVdc7jOu+ZhT77quDpIrtrqTX2PYTTgpqJunLJL/LaSZXcOX2xqVGOt3EYPcIM8DGFh2nkiAUL6fEapoXLR1HAt5nm8ckB2v3jHlDgp3gYU09dAhJLKwj41X7mlpC+yOPOaxNxDk4kc+lPdR8Ro6dF5q5tmcVL6Ex0SczvOTJKRm15qLHVlNZdB9hCREkIUFTJhpfBvSFGo4+dF4B3sbFQUjZFDE7Hv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:00:39.2609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 267a8c47-7925-4161-2583-08debc8f3541
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9820

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

The SMMUv3 driver, which can be built without CONFIG_PCI, will soon gain
support for PRI. Partially revert commit c6e9aefbf9db ("PCI/ATS: Remove
unused PRI and PASID stubs") to re-introduce the PRI stubs, and avoid
adding more #ifdefs to the SMMU driver.

Link: https://lore.kernel.org/iommu/20201112125519.3987595-8-jean-philippe@linaro.org/
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
[nicolinc: drop stale APIs]
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/pci-ats.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index 75c6c86cf09dc..a1b249fb38bb4 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -33,6 +33,11 @@ int pci_reset_pri(struct pci_dev *pdev);
 int pci_prg_resp_pasid_required(struct pci_dev *pdev);
 bool pci_pri_supported(struct pci_dev *pdev);
 #else
+static inline int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
+{ return -ENODEV; }
+static inline void pci_disable_pri(struct pci_dev *pdev) { }
+static inline int pci_reset_pri(struct pci_dev *pdev)
+{ return -ENODEV; }
 static inline bool pci_pri_supported(struct pci_dev *pdev)
 { return false; }
 #endif /* CONFIG_PCI_PRI */
-- 
2.43.0

