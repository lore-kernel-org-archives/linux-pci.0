Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012066.outbound.protection.outlook.com [40.107.200.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A10131326A;
	Fri,  3 Jul 2026 04:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051692; cv=fail; b=bJoCFu0vCUSRfBv6I7oqDStp1WzFY6KClYKZKh8AoGGTxBFzt8Wp0WIp1WdT8RJKHPyROUY0iMZfLhJk2X+SSgmf7W6N3XG5ThRqs1v7OUR3TjsgfCM2gzstQ8CGAnXq1Jy9QIugzEtll/UMhgwQgwQ+OAhoNDopXUyjFYDgMrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051692; c=relaxed/simple;
	bh=QJN8OObWBbnrYQxgqgilzL8gpoPbQ1sXVJlY4V8LWho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=taxo24gy/XHe5+O04dBLNSQWKiVVWr+4370pnIujyIQUSwABnWSNjLQFY2z7NIs3/EUZsLzglyGwmOBKcwTwk7zbL89K9fJQ1XBKe9E8CLLHWnd1xx/Fj/8QF54qX+iYvE8b4ZkKXlIHg0n3AQ18MzL7XXKr4HzwY7yBIqC1HPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dTSjz1hd; arc=fail smtp.client-ip=40.107.200.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dTSjz1hd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZS5tBC8r1EaJF/CIxKE2a7e6jIY9reiwIlcqKHiIF2kZ5IFdEkxDKx/uGT+VDcBekjIcJUU77AEqiw4CJybpEa9+qW064+fD3pyD4PMy/6CQzIgsbw39JX9rJ5WsbAJ/P8mRBeiWMZ7xJNfg/OBKJC7ZeSHewQt3WpMTKdOS1Zc+aJWfCmsQ2tY1kBoZGbJ4OujMYMCxluiIDlDpNvyo44NURrCoVA9duwC+0cczzfo7Mwmt+N0MxrjHFsVWHqLpQ3Lvv1mcnTJXO7XVN20ePtaoDli9GT9UvuLLPlKfn6DQJAgiUCWh4P8VayMurdyjp56DANEuW2okmD+7dlWvcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWjvPTK+LOAMAQ/lKaUKPgmeTqqJ7RUwLLJsqJwZmnc=;
 b=Pr8MmkrXn+Ly9Mu6kmUWB/MZ4Zl1IsknyAGWU8bTrgm7cJAQ57EYdejePixE+lBLt/8FKvzV9EekZ0VZxzqBIvlJuniZ/5rxhSwGr3eD2E+krj+Uh9BkuMCb3xCgbPhYVo9OcXKnzuT26Ku3R0I0AOUpHIUoGtvZl5MZaHfBzHztmWu4DdsWpCEDBC+KYGMULSAjCeVn4texHACUMXJoz3ocWCpc1NURsgAHlNl9EgphdYf35sQtsY9SxKG2fp5sUeRJ6sqCWhPx0bSBxCLsvvr+sGVGHvr04tWg9/2QUZwlx0eC9Io1dm/O06ytqjAOQ1bHHamfWPgBv4aq9Vlkyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWjvPTK+LOAMAQ/lKaUKPgmeTqqJ7RUwLLJsqJwZmnc=;
 b=dTSjz1hdML+R6e0yZCGWCAkdN3CNT8OmkD2zUYjqxUSnboA/Yj2c1XsaVRbKoPoOcPnFZnxUOXwOF5LLTUKlaqlintjgmEfOh/9T2RFDPGP2A+bQ5KUGdo5UD+M4af2rIx84uDa1lKs0mTbXjKM9cQVnwL1di8DqiJxVj47L8Hn5YugTV6eJJOKK6f648C8Qr8lG12+xXWQXQc6YLdf8DQW44NiV3Csouq9HKnPJamOdQkBjVYVQuhjnlfQvjydrVc5jsfdevG3Pu37SNJh8Mah1qFHTeCRB86aabjaEHMTUFvAXTQtMoZFOgycELKZf4s6yrav7ZYWQheVwIJY/Mg==
Received: from PH8P221CA0058.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::7)
 by DS4PR12MB9636.namprd12.prod.outlook.com (2603:10b6:8:27f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 04:07:50 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:510:349:cafe::6a) by PH8P221CA0058.outlook.office365.com
 (2603:10b6:510:349::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 04:07:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 04:07:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:33 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:33 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Jul 2026 21:07:32 -0700
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
Subject: [PATCH v5 02/18] PCI/CXL: Probe the underlying bus reset in cxl_reset_bus_function()
Date: Thu, 2 Jul 2026 21:06:27 -0700
Message-ID: <eb77bc0422c77158f48f370c3f7c1b937c319894.1783044582.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783044582.git.nicolinc@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|DS4PR12MB9636:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cb0c625-c4ea-44b2-b2bf-08ded8b8a55c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|7416014|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6J7zd8eK1fiUdNoKt9WifVLsZD0Tj5aVMYndYPaAEJImEuKZe8nClg1Vjc+rMhlj+o4+W7E18uHl/FTFuarD0HD/7HsM0Fvz82Gxq9l6jKFVB62L/Dew3VBlApjhiCyD3OabLdLWuPhxAPt0kmfwWgYQXW3RH042t5V/yhtIElpOZqBfMM/j8KYDHMlpq29/NAeLMaiRIhvDUA67/+Y/BEZxkaSJgR+rZNNaF0MCUKmGdSUCb1NcsM2EnBBq0xjVILdSbe2JyL45CNPwq+dfQ+j2d3069+hLvZVzF4+auAYPhSJSy7lML/v4Y1QpuVTNFfOocnr0zRpMem6Bp2SQEq3lZ5Cd+gEupkQmyh3RaTPKSPTezGdt83xGBVfZlIME1T4U8fvxRfSy3ziz2Is5IpxtiIdI8c/1jeEiSYHq1Rx49Pxfnk1YBkVjoIDGI0YlpV0HokazkG0GVwutz44P8oLZKsz2/vsUK3etNILGsLuSrH1lXKrwUHxLQGRoUEpPD0+QE4QXR7+FwMiPlhYUBGMCLXQ9bgh11hLFpjy/YuXcv1Os/ebgSRWyhjJ21UJV+xsG9YR9IGvUk6VJtRp2mxQH6HS2CshtX6BGYnpQjWb1dRjklxsUsu8dcse9w+Em2gCfK2+Pjz0Kb511s0nXsRE5CTSngNJehZndIIaWtApy8P9FIhXUnO878D5/b585
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(7416014)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ozAhWa4Ho904Lm3A8qtAmGC0EKZ+nrefV58XPIYHp3e4i0tCYIROJp8ohQJodAvywnO4VGQCYsO39lBb8EqE2mTD/8e3gkZEXxgVSCBD0fa3hT/2d7DRqDUtmmFSbt6L/orbID7RbgYQM8QNmTLz0yWbVMsfiN18ki6wzVWX64PVY6oB35DPnCBm2ACCwYK8i+X1NwcnM0Hz3WFNlwB2vXp2+oXj2bhFbCae4nNS2MMTKXtN7nCJYc+O57XdiutNAtStcLOTdb9gHrL2hZvmhM+jIAF8JRF9wQScP3FPPQU7dv77UN37Lp2fu4Q+YfiSHYUP2tF6HMyR43v1OvViOjnNX26mufE/TKvH03nGKhap/MCKp/2sIcKViAScuA5eHBpztXhBKW8toBX5sEfcmPbAsL6MvEyAwqZ0I73fX5DMll1rW/P24pbXPlMIWbZN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 04:07:49.1692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb0c625-c4ea-44b2-b2bf-08ded8b8a55c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9636

cxl_reset_bus_function() reports "supported" to a probe after checking only
that the upstream bridge carries a CXL port DVSEC. The underlying bus reset
can still be unavailable, e.g. on a bus shared with other devices, so both
the reset_methods[] array and the reset_method sysfs node end up listing a
"cxl_bus" that is guaranteed to fail with -ENOTTY when it is attempted.

Probe the underlying pci_dev_reset_slot_function() and then, if it is not
applicable, pci_parent_bus_reset(). These are the same two checks that the
actual reset runs, so a shared-bus CXL device no longer advertises a method
that can never succeed.

Probing via pci_reset_bus_function() would not work: its cxl_sbr_masked()
check rejects every CXL port with a masked SBR, while the do-reset path in
this function unmasks the SBR before resetting. Such a port would wrongly
probe as unsupported.

Also pass an explicit PCI_RESET_DO_RESET at the do-reset call site, since
probe is always false at that point.

Fixes: 53c49b6e6dd2e ("PCI/CXL: Add 'cxl_bus' reset method for devices below CXL Ports")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/pci/pci.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 01cf310540561..8102989673333 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4979,8 +4979,16 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 	if (!dvsec)
 		return -ENOTTY;
 
-	if (probe)
-		return 0;
+	/*
+	 * Do not probe via pci_reset_bus_function(), which would reject a
+	 * masked SBR that the do-reset path below unmasks before resetting.
+	 */
+	if (probe) {
+		rc = pci_dev_reset_slot_function(dev, PCI_RESET_PROBE);
+		if (rc != -ENOTTY)
+			return rc;
+		return pci_parent_bus_reset(dev, PCI_RESET_PROBE);
+	}
 
 	rc = pci_read_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
 	if (rc)
@@ -5000,7 +5008,7 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 				      val);
 	}
 
-	rc = pci_reset_bus_function(dev, probe);
+	rc = pci_reset_bus_function(dev, PCI_RESET_DO_RESET);
 
 	if (reg != val)
 		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
-- 
2.43.0

