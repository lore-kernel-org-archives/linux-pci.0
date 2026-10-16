Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012066.outbound.protection.outlook.com [40.107.200.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7515349CD;
	Fri, 16 Oct 2026 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167701; cv=fail; b=ZUOJ1p+3RNyP4ltw6XwSr5PP6A/3Wf/TLuSoXnMObhPCqi3QoCKR58MCjlzmNtTDAQEUGXjYQLG5i2BZ784Xpa5yRz/FYBN+jwEqDw5b8UFaPeOGMo3eK181aWGRhIBoXO1q5mfnUllseNgP5TJHi2OqBWQntSMFWccMxpFpA4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167701; c=relaxed/simple;
	bh=sa4aZ/S9MAQwn9RrLlrHClAxiU0e7IztBo29bOPJJcU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WIybmnpLBV+fyP/RIWVGUvTBOMISRMCjtUwYJyZHTwOu5XMviHhMX2UFc4RBLz2O5iHYdBYwFU3pGLx3+xhPPbQ/7PV8VyHktaH/W58AHz8cjXRG9C+uwRoFPYVU+kOZzA/cd9+QAnmKDhQlfI/7qR8O2WDrS+E9vRmC3i3VZQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ml/f+v5m; arc=fail smtp.client-ip=40.107.200.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ml/f+v5m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8jOXOqpbvYzzMbl26sjnc4SjRAsGJfk454YZXMKa5NqKbNwUcQX8A3+rCsYomkcNRzLakXyGEGXIpDNXzBuGy1ppVeSnu62dQPlHFPhXIktqIK8sVu4MFAC4Ou5sdAqBAQyNJa0aBvOjl4pnYfpuar8CQGkuMIaH2d718LzW9WMavmuybG7Z+7lSkIW7fvbwJ6Z35JErtVR1pvxZbdu/1PAP2bmZm/UEIt0jJRA0ptOETFau9o9TPziC6oaMaqm7ZQ9iB1aZ7C+vZRXY3QW1hBTgDpFRaaa2JJh8xhYLeKs5xIp/Kk56kYI2iAhWp+nWgKRdJBsi8+8cbpgw5GJbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/y4+itg/8PcfYMYNlhf426J/E0r+SAL/84yKH4DrK98=;
 b=ym0yFHaO46HOZJli2RB+Q3LHQ5qkAlmmFT/rm2u0QnYtTMFLS3PxLRI8tgBYXJG1qeOh/sQfhlxtAmPSYY9NigIBu5NcpDXaYujbgp7pXLAhLKfRXepDUjV3FD6x8ydx26Y3WQRZTPdqXqT6nAaNYbBXoueN5Zf21+u57Elie8RvQKNTx4avnGqyaC1nni/DKazmEdEFllefH2z/B5UFEN1I5ev2mRcxXdL7Q0BjCy3GOfXwV12LJdOMwbKvJYQKwmOoGks2okycKo2oDQzw2xkxrhJAy7RjRH4dFcaz0M/c75w1dsSW6u00yd7yFlKqwWPvO6N3XqYuKaTHvEGv1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/y4+itg/8PcfYMYNlhf426J/E0r+SAL/84yKH4DrK98=;
 b=ml/f+v5meuWzIjmSWP5/mEya9DKLjr11h104EkYJZ/h+KWk5om3excj+1tXJ4ADH3RwDthDXE4SOH6wwSUhU9EecrZ9+RB7z9fIqY22T3cEkLPzr3jNjrqzKI6efg4tNdkpW5E+Ont0DG6Wew6eB7rAaN88DwP+RI0db33J3VTnokKu+2DGnH1m+IFfzy2TStBMh6ekh3pOOKMxMneWnTUa7sDrcUxwXOjR7NSGi+7FxDEfVVuVK3gkZIDuf+PwO3p+DnSrUtT0mctMy8zAoMFPWkkE+aKCFugQ8gZWts1G6kC7lmI4TC0CxtPkCjizelL90T6RKDaijBqoctYUX6w==
Received: from CH0PR03CA0420.namprd03.prod.outlook.com (2603:10b6:610:11b::25)
 by LV8PR12MB9668.namprd12.prod.outlook.com (2603:10b6:408:295::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 16:21:34 +0000
Received: from CH01EPF000BE94F.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::83) by CH0PR03CA0420.outlook.office365.com
 (2603:10b6:610:11b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 16:21:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH01EPF000BE94F.mail.protection.outlook.com (10.167.244.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 16:21:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 09:21:09 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 09:20:59 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <ankita@nvidia.com>,
	<jic23@kernel.org>, <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
	<smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
	<yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
	<bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
	<gustavoars@kernel.org>
CC: <cjia@nvidia.com>, <kjaju@nvidia.com>, <vsethi@nvidia.com>,
	<zhiw@nvidia.com>, <mhonap@nvidia.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: [PATCH v6 14/31] vfio/pci: Provide an opt-out for the CXL Type-2 extensions
Date: Fri, 16 Oct 2026 21:48:21 +0530
Message-ID: <20261016161839.2765592-15-mhonap@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016161839.2765592-1-mhonap@nvidia.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94F:EE_|LV8PR12MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: c8c96847-2ba9-41d4-0733-08df2ba18b82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|23010399003|1800799024|82310400026|56012099006|11063799006|261009223027099003|921020|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+gaZEkFDvHKC/Z+A0UMKQmCMDeeI2ZY9+pCFBqYW0nr3PMjCVu6QS2LgDbfb2zk4GBb5iJ1lEKsfxW1Alwnyvrr3tQgUEHJ3k2hWoll1LjRM0sToPjqjHOv9haFkKi160foIX4wgy1CztU0qZ+2PptPbF6QlYWj3wSbKJ1lhoIOAl9UKy3qZb3M76CyMifAEy4APSA+GAcvmYni5uVnJ/c8QvgFcdz671d5JZg2j9m+es8DMEY4nEhAF5YuARcAvuTJrJO4TrGvcUPkqXD5iOFu8FDrj9/CvHOIImF/mPQQ/Odjp/GhHTuLPuTMa6MKKrmXnZT6uTf33MByS+VTkvPCM2hd27C4K+cR8CBthnYY5r6j3iPOv+GOLH82yoc3hRm2Fdl1Qk+kufLR5pr7AuEDjjGYIDOrZArLGNfH7Lx0lTthO6yrpSKWvDLIiuo5gAyLPJp9EgH5pCQub5dzCnDSp4mnvQwJKvBkS5JUwpkl/nLRcbVO3ISZjadig24Dp/VOm0V3CJNYFSDTs0/bc3a9nkTNx44Z/S/HSJxq/c0cZjjXNmr4KCPCkxfFmHryCu8S1iFRGnjyDICZq6nIbga8frvtQhKCymXzM4cootBJH9o8ctAnP9zDqjCZ2jLC3fMb9RKvmOYMkHKKRO680m449LeevkIRshXpBXi2SxNaAEeVhT/JQxoAdIvxeLVS9h0Ozn6UqVchTr05zf2Z/o9itc8M3qIVbXQTn1xIssL5zS63W7rFs87wZ5PF/jcKk
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(23010399003)(1800799024)(82310400026)(56012099006)(11063799006)(261009223027099003)(921020)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	U8gKP49i+hMD0Ht0/YaIWfVPGE0FQ/fhHjHp050/1pJkCyouWTWVcp65VMbnTOAzlKkADU9mNkm9ZS1HTxZg8xPDmQGclD8hS2s0rIK5qFbdVo/3VYMAnMkM//bZQYr0nkCZDLfznsNLshHlQVitac/OWAfOmAR74ZKug0FXyWNUl8V/+XEoMvhg+uQxSbs7MP75WCM+xoLdWD6XQ0hgARFMobHobKBG26xqYeOftd/nh97Dy36TUDEkw8OQjm4gDDHmikr38R5MoBxzSBophAOq4Kw3udoK3KbB3VBSZGJEqgKJboBkuwkB1CtVy0dVtrNYwb5BAOdg8AnlIjoAWnrlooX5v3k3hDY0mqeEf4ENE3U5dEuOWNhd6lh4eH4ieK1wUbrkE+0fShinJmy8so+YFyVYijbAmyW1gQFSgjlo41vVQQFp353AFdPgWUmF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:21:33.8662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c96847-2ba9-41d4-0733-08df2ba18b82
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE94F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9668

From: Manish Honap <mhonap@nvidia.com>

Let an admin or a variant driver keep the CXL Type-2 extensions out of
the path and bind the device without them.

Add a vfio_pci.disable_cxl module parameter, and let a variant driver set
vdev->disable_cxl in its own init callback for per-device control. The
parameter is built only when the CXL provider is configured.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/vfio_pci.c      | 13 +++++++++++++
 drivers/vfio/pci/vfio_pci_core.c |  2 +-
 include/linux/vfio_pci_core.h    |  1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 286244059569..0ea349fb8d4a 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -60,6 +60,16 @@ static bool disable_denylist;
 module_param(disable_denylist, bool, 0444);
 MODULE_PARM_DESC(disable_denylist, "Disable use of device denylist. Disabling the denylist allows binding to devices with known errata that may lead to exploitable stability or security issues when accessed by untrusted users.");
 
+#if IS_ENABLED(CONFIG_VFIO_CXL)
+/*
+ * A variant driver may instead set vdev->disable_cxl in its own init callback
+ * for per-device control without this module-wide parameter.
+ */
+static bool disable_cxl;
+module_param(disable_cxl, bool, 0644);
+MODULE_PARM_DESC(disable_cxl, "Disable CXL Type-2 extensions for all devices bound to vfio-pci.");
+#endif
+
 static bool vfio_pci_dev_in_denylist(struct pci_dev *pdev)
 {
 	switch (pdev->vendor) {
@@ -142,6 +152,9 @@ static int vfio_pci_init_dev(struct vfio_device *core_vdev)
 #ifdef CONFIG_VFIO_PCI_VGA
 	vdev->disable_vga = disable_vga;
 #endif
+#if IS_ENABLED(CONFIG_VFIO_CXL)
+	vdev->disable_cxl = disable_cxl;
+#endif
 
 	return vfio_pci_core_init_dev(core_vdev);
 }
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index f1e1ec36eec7..1e0ac28b7564 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2466,7 +2466,7 @@ static int vfio_pci_core_cxl_init(struct vfio_pci_core_device *vdev)
 	const struct vfio_cxl_ops *ops;
 	int ret;
 
-	if (!vfio_pci_is_cxl_type2(vdev->pdev))
+	if (vdev->disable_cxl || !vfio_pci_is_cxl_type2(vdev->pdev))
 		return 0;
 
 	request_module("vfio-cxl");
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 881e51c42414..991a3fcd84eb 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -162,6 +162,7 @@ struct vfio_pci_core_device {
 	bool			disable_idle_d3:1;
 	bool			nointxmask:1;
 	bool			disable_vga:1;
+	bool			disable_cxl:1;
 	/* Flags modified at runtime - dedicated storage unit */
 	bool			needs_reset;
 	bool			pm_intx_masked;
-- 
2.53.0

