Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604B74F7CD7;
	Thu,  1 Oct 2026 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846597; cv=fail; b=W1xfbFAdjSRT8hlbQlYsAkXV+/9t29InjNlZCrNiPCalakrjRGOvcQA2DWg+b2V5i10rtUuXKSVicd/sQyLu+tzQk6uWor4P8cycsOpHDdDXM6akay2WEq+KzlwPvrl8+9dE9gqbMXT283tT9KSo9n4gQiszXBKxANXzQc0G4l0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846597; c=relaxed/simple;
	bh=oJuFHlqQSraZOpZ+4Oh1VGBMXWTkoLx7R3fsYcgmwDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TuQf6mleKcfOV/lwnFVBm6AKYpzvupOtod+JxLDEj1+KIlkdwPUIAKIGwMopUAFKCk9Bk0M94cLlGfAlnrcaSDoJzNS3MRTUw1kFYaHUO59qBeLTilXxiWHWchUNKnGpLO4r5eltEL2EpKni6vvBRQv1cQp6t/PxE1lAeya1oWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sPY9gq92; arc=fail smtp.client-ip=52.101.85.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sPY9gq92"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UrnwKWXsx/rPNADNQCnUAB3n1+hMh98xfDNH9Eb5Ofb7u5IhuQDYkrKRh8rTvOfkLGd+Dyw3jRQXpS7W2JUm/wNK79nNJuS7B0aE6gcg0QFuGDJIO9b/WS5JxPIqXdA1Bygl9fV+MPyTHY57WsVyqvLLfFFQHolo1cW6JkdMFoep6c5lPsRGFx/vm/RfaqiuGTXm3/97dM1XGMl3+auwcwohtvVsKr/bXV1tYF85YSKKHra/nMk8PpzklUDaPserdoISp3j+I66rhK7ytHJ34DOPDSQsOvRIJqSSQ6EvnUYeufjgT4JUrBKHAjMmijVMX7dFYDdLQVNRA2x1FAfFXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=niFifanlCptDIZuq9tW8g9lnO53L2JPlg3Ae/UpbhnA=;
 b=cZJFOV81JkEJNBdzadbZ6r6PBrjsZ/1F/gVykd4cr9gcEZopZ7WErpjfZfDZ6y2wZuwDz6RDtkpgsgYa3Xj2SSQ0lQRMu/F2hCjdNF0IcM661foqBh7S95cIDcXQSYY9pDVy9ZyPPHNQTq0Y2UTOMZmlWd0YX7C2zaPoQ5taWEYmz/lgf5lhI//Cq76siZS3jD2GekcMtRXhOLPNV8gecMnzoz9Rr3L29bbSrPpg4YFmkMIDFnOo9drzo3oc38tN/PofI9TB6kP23IiXYI+7lYc8zkyCxGWkNikksIhYho2QIL+VwG2zerbQfiiBR4iRUp1ZgquVFT1mDK/XUIEDlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niFifanlCptDIZuq9tW8g9lnO53L2JPlg3Ae/UpbhnA=;
 b=sPY9gq92naH9YUlH8VksgKKiBAcK2uRKFI7IUz/AnWB9a2MKQHSLLE4rf1uzsPBPRoQsq5r3l3lUneslQ2cHRIRqHLJi6dwg+dbv5P8e5s6ZS5nd4vYa2s4Pv01q1xypeRKEfEaOkc+E1QBTLbCBz+fd1Urwryv4JQPJiyDDZCfFSerDrhhYzmrAiMHdqnm8NX7he/ge6CcnhrJmQsgALuUgU5CnMcxb1KateS49mtCkJ8U6bch55DMPKyFqQCCa1NB06YsViS5JUQT5frpaibqqbdQr0t6yO1BVFmcLOp8B8JLOndse5jIdDjcssVvSkQoGV6xSZM+KjtQXZn7KqA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CY5PR12MB6300.namprd12.prod.outlook.com
 (2603:10b6:930:f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 09:23:08 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 09:23:08 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v14 13/16] PCI/CXL: Reject reset with unsafe function scope
Date: Thu,  1 Oct 2026 09:22:24 +0000
Message-ID: <20261001092227.3004747-14-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001092227.3004747-1-smadhavan@nvidia.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0045.namprd04.prod.outlook.com
 (2603:10b6:303:6a::20) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CY5PR12MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b8fe8f6-cb79-48e6-f72e-08df1f9d9b41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|56012099006|6133799003|921020|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YY0TmJI4qbjx40uXKARPqm1qBSUKYIFRhbXennrqrv0vNBc6lqwXwDBY5JMfTSuFJPLmKKUcykueQ7absEp8oU+/2uaWj8+4oIHUFodJeLOVwtB97CVCKlpxILsVbe99ZN+8VI+Yvaba3efMWmpV2NAdJcDYNNKxSZ6e0pCHfXNfi/Wmfnk/979OGXJxSw48gfk2dovxa3kGjnPMAmzTk9aIJvFNPjVMXDaco4UPClnQaqDt5M5yF9uB9wCakFGyQCRtMGAtwOo8tjCcgqdOeG1JpLI6oPGqnKckZM8pwoPf7a37PpdE13YIeVR6uS3vya7V380KGo2iwSwq8+tygeQ+h6ABRuYh5nXjQvJLVX5jdUquC0rAWgCIhDxan1kcRkSQgUbMveVYeh/xgB2AbU3FOiC9oj61v7eArfnIXW+cOvTQ2a/icn19xtMNDZmZpQz3G65hzCiyND8hlgBUTXL+6Z4GCEOAMDJJvXnOmNhuILdblEyA9WL1uJnXUa7X/BniGQCj0dqH9wRWmLCWDDC7NoTO3fhvA86L3CYzuBzpv6WeZW4OEA8CbLWjYG8GunLXrPQ2DS7DgU4muHaDumUaPQ6MCpW0sUe6+H6wNa1wWin/KTnBD3sokNMFq71rsqs6h+s4svr8xVgxFxhOYj6T3UB3UT6ljujw2tZ2PoQfmUEunAIIFR7JKavbQ5cHFxYwZvWISQFGoA4TdMVSpQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(56012099006)(6133799003)(921020)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g/c0SJHxiXmjsJAwdM6VXhbqJIH284sGzp4i/lrK+1H22X66KWxC0RK4BYMc?=
 =?us-ascii?Q?iZ/JwfCHszOqiw6qlJb07u8xPcewksuBkZN2x0UF7tf6O3rCSnN+CJM7ZnDf?=
 =?us-ascii?Q?6FfgEv5MYw7DkUErRDe5XX1NtWNs5dJN/MxQPPOeLS+R0Dm7EEym2dDBYRr0?=
 =?us-ascii?Q?0tZ6xKDgIhIdgQq7DAATX9N9WHpMKlKXkx13GnCpy8TeIjFj+X5uaUNT8v4+?=
 =?us-ascii?Q?H0VMmKBUjtex5WXeAeoQ+kWUzM8IXTfMVxAHMyEmGg4krv80IAL+98z+squ8?=
 =?us-ascii?Q?ZBAGlFJfXTQZlKJowKxn8hr54gU7GcElZtIAAxA9ALVzlsxUyhKWv5NWCs8O?=
 =?us-ascii?Q?M1v0NiKOdLdHFZZgRN9VJXN2PtaPHEeby0jIld069iQM4Hap8IM3hDAbkokc?=
 =?us-ascii?Q?w/m888nxZS8aHwXMF6yrjIHc8r1LNU49j0mq8ineQpAgvqBUNVvvQv25WQbC?=
 =?us-ascii?Q?kqCjjXe0PMy+1MparDfpa/OgPaCnnEasMpfEvry1tzf1jT8uFGVXIz1EtCMz?=
 =?us-ascii?Q?n8SZYSOjX4+/8UPsKktcfYhGoqoegl5ePAQq0dlb1e0p1rSZUyau9RJYuK5A?=
 =?us-ascii?Q?iD/OG1EBHTng3jrWJvF5yEOrEdQ5HU18saiK1jA7VTuQVlVqT+4upjePzP1Z?=
 =?us-ascii?Q?gkoEUmF1y9prKC6w//VV3CfpUXakRLV2MU0x+S8R93uAZqlL8BPfUX+dIQEg?=
 =?us-ascii?Q?31gGi7r+msuvo2xBHXXNVPfxaT8DIOk4oAOMDhxKm3bjUzh/AmVXkesoiHA+?=
 =?us-ascii?Q?rgPfOqme1kxr4BrkF2bREJjmGm6CHCYCutU3lo1DkqfzelytI1eLuRjBHFna?=
 =?us-ascii?Q?EXlMX6iqtBPE3z/IBjR4qBIHuC/L6UPPlD8TZ/YyQIJllRBto8t4tiTDrlTr?=
 =?us-ascii?Q?OgFBsKb04nuy7feer/sOg7husb2zGy0ZH64gyLtXMJsFKmODkuiF1xn77AHA?=
 =?us-ascii?Q?E7QqpwtX+RFZtvXqcCXZcKU7dImkWLPVwlA9syH7salEkftlEBvEWQHWaZZP?=
 =?us-ascii?Q?5R6f5zOLDV/wC/0L93Z8B3JNJbCczkCjp22QJCc95jHtxjXyEiOtD1BdtEnR?=
 =?us-ascii?Q?GjAEAZQuy0Hd1cEPn5BPnn8sjfhyeq1qc2u2T4JUiUdVIa5vHjV9cO1saMuk?=
 =?us-ascii?Q?Rebi37/noUWSS4leE9YZahybQ2i8pYBDtN98QpXpKeMIQQ2H9X48HnY5DSs1?=
 =?us-ascii?Q?war3DGYMCFgFi00yVz2bK84DZ6qa7uLQwue1Q7CWrqKAQC2EYcb7yk5z1d/5?=
 =?us-ascii?Q?NXasswWYoJ6HUEzqq6X5FFfhjXLAk9SDen58ZyvZdquE/2czhfskOaytahMq?=
 =?us-ascii?Q?1Gr8ztIUGxRjNKuyw/PgCKGmWNLd/DG7nIdiFHVB3NvmFSbG+HFoi8qONRqQ?=
 =?us-ascii?Q?qM8Jmx0iN1WZVu21KXMg4ac3NiXC8oP76hapBCJ6Fd2HWIgkudbW1SubHsFv?=
 =?us-ascii?Q?Z+BCXu2vFRUeoykFcsNU/B182PtVCA10b7hbDWxzSwwnfODFGeXLvMb2yCFk?=
 =?us-ascii?Q?ilPeSP3m2kvecMMf+Iv9ZECwRJj5uweFSD72und8YNs1C7+m6KrBp4ds5//R?=
 =?us-ascii?Q?YM6Axc9LHNVvg5B5ohysD0zvO8ff4IlH0+JjqVGjzh68mHZ8O67I2al+pqHC?=
 =?us-ascii?Q?O6OJDAao8WH6WneLetreFXY1xqwb8AhFf08oo6GDbFyvv1lUrOp3si5KpWiv?=
 =?us-ascii?Q?qlMqa79HfCT0BPH+9yHue5Z3geWNUkhj69yYIDqEV8l3qZDETGrWWy9b58do?=
 =?us-ascii?Q?7pYrg4guRw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8fe8f6-cb79-48e6-f72e-08df1f9d9b41
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 09:23:08.5651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vnZxtm2FausXa9Sg7rzsYSnJ+wuy70x7cc65wM7kFZp89NRUGaqQVcO3l4FJwrlkcuwHTu3RfrxXSMoNuGUjuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6300

The per-device PCI reset interface must not reset sibling functions.
Reject cxl_reset and cxl_bus for multifunction devices and PFs with
enabled VFs.

Suggested-by: Alex Williamson <alwilliamson@nvidia.com>
Link: https://lore.kernel.org/linux-cxl/20260626160846.426e71b6@nvidia.com/
Link: https://lore.kernel.org/linux-cxl/6a50441e2bb5e_3cabcb1003e@djbw-dev.notmuch/
Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/resource.c | 3 +++
 drivers/pci/pci.c           | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index 584b51cd9e28..679a605da24c 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -903,6 +903,9 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 	    !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
 		return -ENOTTY;
 
+	if (pdev->multifunction || pci_num_vf(pdev))
+		return -ENOTTY;
+
 	if (probe)
 		return 0;
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6be5f8..fe611340f5ab 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5026,6 +5026,9 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 	if (!dvsec)
 		return -ENOTTY;
 
+	if (dev->multifunction || pci_num_vf(dev))
+		return -ENOTTY;
+
 	if (probe)
 		return 0;
 
-- 
2.43.0

