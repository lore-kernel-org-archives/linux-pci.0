Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012055.outbound.protection.outlook.com [40.93.195.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9036A466B40;
	Tue, 20 Jan 2026 22:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768948046; cv=fail; b=VnAaA1NCNFgg1IbJ1lx2xbfeuC7MFN6zpBpBWfC2+PD/41sQwJo5jnPXERkdHkad3YJLtqCyR/3txeBjsVK7yV51V/IpcaYBDmKqc0dhCF9LJwkEBQHZ33v136SpZYqPvdS/B9uhZWvpTsq0oaV8TLVOtkuiry8Vtf89PzF82wE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768948046; c=relaxed/simple;
	bh=MTgI/yee9rpqzJhWNiKzPRga34sN5VzyxSY6Oeuy8hc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EshQwLEKMKLB7DufBlGFNEGrsvwuGqyoLXW5cV/ayjp0kzNK8fFbv5jdyUgqhcGb02KXVwwq2sFC7BE5JJKv2ZoyQMpmhgYhtZjT8wNu2ScrxLuX7A3m640WJnivgH4OZce8qg96e2URvHqo4RinM1Hf/r1OF6Pbymi8FpgyK4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aooUJm+H; arc=fail smtp.client-ip=40.93.195.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aooUJm+H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkKqqbn1Kl2oRmXZhTkp22lnK6af8RJxRwaXoAHY3WnLpp1FuGJNXrSgbWGZaWrlmiUoD595hlbNyIN2D1LDdcsHdra9cM565QhizO0E0cjJ432sGamWVqFWaPjxBawf/R7NsCwO5KzSYF/mOA2z4QFBbwIb04ZDSD9EW9PhqgFMaQb1tqY60WTZ3i8pU9onH607FFA27R4bNM5vhzKYJDRtXdIJDu/rIfF6CPVOElA7YKY8yI6mj7iz945NM1/LkJZJI9TI3Psr8Qmm1ZLDPplUsp7hfhz0Q9VxjQgBKs53XTAhIfkEnDYhW3A+xw3Vt/+C1aCaky2ZGPosWuiP6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sktNLtToq6y8KxLKjZNl7UM+g6TCaZTtI6A2ZdeZwdY=;
 b=dSBGuxcyYe3NKOLzbJBu1lxhrLNTH8Qc7fTXgQTBnXMoR3KfDzhJVhPB2cfdCuh2wA+a/BhR90vm3/D33oBiFaFs7nO8ZoOD9g/GhbbSD1TUjZ1jb1MCNXrTmsZcrKbnaj5W9FMfiTzQ9W+mSQeBxsnh8OFPJ7rRMM/BVH1liq+mKiRnL/1xFhbio6hCbbz9ia7WOsAplYep8nc2X2ohQ/LLbyPZ3makhUoQdOe9lfHqI1pq1riMRyEnk2je9XpSstRPNVYZG53GI1hDK9PyarucFwmow76wGdAKC6eUbYpqldGhAfLcAa8kRf7CtuvIfZQnVNIP+q/IRoEHtCwDlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sktNLtToq6y8KxLKjZNl7UM+g6TCaZTtI6A2ZdeZwdY=;
 b=aooUJm+Hv6YYU3FNdYeaTtpG7Fvbd96ASibMDre7QO9C3Ht5fl4PdWUC+jaWWYpQ0Oy+9Fm6J8PMsylj5tggf+vD0FXSJZ2AqFN1h8jSMimoQjV110xL3SAQH2+zJ3hHqAfW5w5ty/Ml4m6Z6ucXFvPyRf+hzjRfNo87TKrU+h53y3sM1m6SpdDmuXLHPdYJ5fz/Am18viNs4rbFeO0W3iH9xBbUkAjjJi/E4+fmgZ9bdcSIU68BSBL/pvY6/DwnojG8dmeMs6oYQa4gfhnY35KLNv+sNfVoDhPEb6y8tv+Nx4viaLqJLR2hw50BopfeVCuJ0AXipTwgaa0K3NE/9g==
Received: from MW4PR04CA0319.namprd04.prod.outlook.com (2603:10b6:303:82::24)
 by MN0PR12MB6151.namprd12.prod.outlook.com (2603:10b6:208:3c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 22:27:09 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:82:cafe::3c) by MW4PR04CA0319.outlook.office365.com
 (2603:10b6:303:82::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 22:27:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Tue, 20 Jan 2026 22:27:08 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 14:26:41 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 14:26:41 -0800
Received: from build-smadhavan-jammy-20251112.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 20 Jan 2026 14:26:39 -0800
From: <smadhavan@nvidia.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <ming.li@zohomail.com>,
	<rrichter@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<huaisheng.ye@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <smadhavan@nvidia.com>, <vaslot@nvidia.com>, <vsethi@nvidia.com>,
	<sdonthineni@nvidia.com>, <vidyas@nvidia.com>, <mochs@nvidia.com>,
	<jsequeira@nvidia.com>
Subject: [PATCH v4 09/10] PCI: save/restore CXL config around reset
Date: Tue, 20 Jan 2026 22:26:09 +0000
Message-ID: <20260120222610.2227109-10-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260120222610.2227109-1-smadhavan@nvidia.com>
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|MN0PR12MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: aa2c3636-066d-4141-d03d-08de58730c87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jtjNw6PkOihJFnF6FD3ZSvWoQxiEmAOvBCXbelm2/ikT9amxbMiWWPfWU1Hg?=
 =?us-ascii?Q?g6T1mM+had5ZZNubzxuESAMCBVvBEFbq2NFbYuOhgVhXw/lnjAz2mf67zrkG?=
 =?us-ascii?Q?20s4xn+3ONV0A7lCVYkpafyR1FIzegdB6IJIXcYbk5fsEvaavn/O4nQv8H+A?=
 =?us-ascii?Q?QpQlfWp9PCTdKVyXTNrGdc4ldaPXA3b6QOb/Jr6E8cuJDADWtMw8II1xiZhg?=
 =?us-ascii?Q?E6arOg6Ug74qtiCRKa61d+zUfBImCBrKFbq55NaROwLaCbN3U9APiWXoEU9e?=
 =?us-ascii?Q?SXhXB9BNZgvaLIbymMGLkKZ+/lrKSBjFzo7NEiyPtHszPYkmKXwWPkksXr1e?=
 =?us-ascii?Q?AouXlhJsamB+ipEHydssgRYHNyV+AwNyjdDK6Udp2alUcZ1KmDLCIRLJLoxw?=
 =?us-ascii?Q?f05w3J8ZuhtlYu6fduPblA8an8kHeRvWvSNbbmiu251pCjQfcSIA0Bian+Yp?=
 =?us-ascii?Q?MWeTyoGtO5R74QMKC15x30vn7IloBtm+MoFy0bVKHVs7Wq+cqPdK+sSwpJpJ?=
 =?us-ascii?Q?yPxw+1Ee280CuujHXdBieOfybOPhvoQa+oOuuxeV+gDuPbecNJjgmfye/4Ey?=
 =?us-ascii?Q?QXSFhPFcXzK93Oe0tUaA5miCYJ85gpBZAVFCgPjFcUnJn3lDtj4HACk4tUoZ?=
 =?us-ascii?Q?otQbPJFSCIfCBCRJmgfwwpzexUoHj7JHzHuIcQv/9yPbZ6h0r/niNhIEjUHa?=
 =?us-ascii?Q?iBgt1AYi6SYDK3Fu/jI/Of4snm2x1plWTzBehSJoW0Kq44GWmmWKVHgAlRcZ?=
 =?us-ascii?Q?ex1JxaRaI90LUX9C4xb6gXSJgqyvY9RfT5lKyZS8s9kfgvaCW7IA5LwcsVmS?=
 =?us-ascii?Q?Xr34abZfe+tM3gfrlWzKvUepCp3ArISSduvWGhaAQXGBXsDb+poYvYCYBNoA?=
 =?us-ascii?Q?3EqcEg1ubiibWo0K9nZWk6/Eg4CyXBggnMn/pj8PvZ2PYly9Lc7psrAwwpQx?=
 =?us-ascii?Q?BVnlJ03KB0jCcjVd/a6EfEgtEa7i+wraRTG/k6ujALnfMZ0zRa/10XAJ251w?=
 =?us-ascii?Q?jNxlXEAoP/TROSovJ8No+h7DjuCRr/aqA6fxDrfa+WkPHOjs2iVa0vbdEkoO?=
 =?us-ascii?Q?yjAvKzifdxm4tp1NQr0BI5XzjT8Le/2Qwe4bQdiH9/jOi0XWYDgXEuqzdxOE?=
 =?us-ascii?Q?ta6U2AHS1YRO+Q5Fxo/9Xr5bf4lN2DprW35rCaSGs2z9zbK7GcxXFnzOTJuu?=
 =?us-ascii?Q?v9Nys25aRs4JDfgmIjNWCDCjzpO2XhFzFL0UV56t1WoQeOGROx4DD6zq0u4b?=
 =?us-ascii?Q?sLcXLzrjK5nY5n7UnEgO8utUuLacPRzXu4WItZ7Gsu8inlqGjVif2xvmzLFQ?=
 =?us-ascii?Q?skxZIS9UZWKFvHlcZp6Bcnlyr3l/ITiicSaio39JypZasUuU8PMylijktzpk?=
 =?us-ascii?Q?BCfwJq1OHioxBUFNrKpOlkYue/0E4uV1KVgMZ3qHlIzmq7v2ZWXw8i5HkZt4?=
 =?us-ascii?Q?itf3eM99JC0T0PdGN/DZ+ahOeCGeGPMmu7VSMdlKXgg8uMH0ZVFMIBdFYvoY?=
 =?us-ascii?Q?SASKG347agB/fUODltPvAmNOISxB/59suy2HtxspIK8FuPOCahjSIy1+zJKq?=
 =?us-ascii?Q?GGkzfKbRmtrwM29wgIAtxXThP4KriZPlwytmWzW9xM41Ho2SYHlLDa2rnJA0?=
 =?us-ascii?Q?zYyr+PUKL8iHb2cMpXfTkMRt+FHKT4JVOJsU/1bqLans?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 22:27:08.6935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2c3636-066d-4141-d03d-08de58730c87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6151

From: Srirangan Madhavan <smadhavan@nvidia.com>

Save PCI and CXL configuration state before cxl_reset and restore it
after reset completes. This preserves DVSEC state alongside standard
PCI state and avoids losing reset-sensitive CXL configuration.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/pci/pci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 18047c893b0c..0bc85c4cc5fd 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4960,6 +4960,7 @@ static int cxl_reset_init(struct pci_dev *dev, u16 dvsec)
  */
 static int cxl_reset(struct pci_dev *dev, bool probe)
 {
+	struct cxl_type2_saved_state cxl_state;
 	u16 dvsec, reg;
 	int rc;

@@ -4989,6 +4990,11 @@ static int cxl_reset(struct pci_dev *dev, bool probe)
 	if (probe)
 		return 0;

+	pci_save_state(dev);
+	rc = cxl_config_save_state(dev, &cxl_state);
+	if (rc)
+		pci_warn(dev, "Failed to save CXL config state: %d\n", rc);
+
 	/*
 	 * CXL-reset-specific preparation: validate memory offline,
 	 * tear down regions, flush device caches.
@@ -5004,10 +5010,16 @@ static int cxl_reset(struct pci_dev *dev, bool probe)
 	if (rc)
 		goto out_cleanup;

+	pci_restore_state(dev);
+	rc = cxl_config_restore_state(dev, &cxl_state);
+	if (rc)
+		pci_warn(dev, "Failed to restore CXL config state: %d\n", rc);
+
 	cxl_reset_cleanup_device(dev);
 	return 0;

 out_cleanup:
+	pci_restore_state(dev);
 	cxl_reset_cleanup_device(dev);
 	return rc;
 }
--
2.34.1

