Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011047.outbound.protection.outlook.com [40.107.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4595837DAD0;
	Tue,  4 Aug 2026 19:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785871842; cv=fail; b=DIopZPY0hEeZ9uDm3yFv5jApZ60nWdSbi8TXZLEjFxBN4SssYktEaN7K/2+uNbpYHuAzlZaF8qlKE/Mmny1CUkJbMAt+nafD64mT9Kyb3qrpD8sjYKOd8r68SF74kNGL+r/TZcCHZ/K125HUiIkA8xdMV0HcFYg+4DGM9x/1ar4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785871842; c=relaxed/simple;
	bh=Yc7GStOXxG/hHxHeIyYWowi0Yp2OxacitJpfGMe8hbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DjYMKl4btw+xnLitn3bDHxd45lhjOhQsQ4U4VT6/WuMvc94E5SJAnD3o80axEhBIu8VrFYEDa2Sz7yHENH//8boutAe1YzmAAzqmF/s96zHJLWgR8tKPMDh238aaqEXjqGWMwtOfkJuWJZUr39CVNgZDI64T/u9pwtVHg03qbPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AcN98JMU; arc=fail smtp.client-ip=40.107.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AcN98JMU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFzmojb/uBV92Iot/aHieHGlZovFQFLiBgoYJ1wtxKJnDXzxt4Aue1NMnrQMvby+E1rOlIxrk5MprhjkVlDOcQwHeMp8wCuCyFUuYAbPGFYuRM/x5+6APflVo+bM6+P0I6YTe7OJjlh65UKejJSGgxqgWpfbaSIglBxtvhAHgx9ucMA59ysggoPXI5yS8Wq2QXIwrZq1btpHuuEwd8dljp16klOFWE8rtJnyEe+tW4ugQCYbWgm5gPfyXMCAlcJFpNP41Si89XNbxw2kAJjxhiZM9WCGSk0iuGY73q2Ubhgm7muouzh+9EennSpFKJAp+QDBO0+cIFn7ZTbfgHQ1cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcBLBzYzuAPK15+KgXQ0gAG1LfurR/evS2iQaAjgeKg=;
 b=jB6TzPuPkKviG76NvH8JTNE01dJbMVaB21GgbmErY1OMt1nhK6tFj+viNgOH1FL/CAJ6bp9OW7Oju8ElOE5hCip9acyzZN/obWNi+vv8w6lyLAU/w6e+PlyN6E2rwr4ZeK/a3+4GQy+PXpSFLNX6+vOYplsB5VgdbngIlbPtKolBbrrF10taelMC10M6sggnRelAPMHFQv9fKM/ILgDiZn8U44FMe7XRIIwIl7Bsg4CZRcmi9PuUSpCowvSoQcXxkwfhj7qDVdXEdOPduE+TyYRDchIb/3Tn66IhRspQuZiBjX+N+tI+pDx3keKIjdumMwu67JW1uDnMo0xi7sbzkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcBLBzYzuAPK15+KgXQ0gAG1LfurR/evS2iQaAjgeKg=;
 b=AcN98JMUspVeEDQi3wEGY70V1i2fproIWa2fkTKQP0yejZgxMT7IPOMXuxK/nJD7KSh0v0AUooXJd2EjqfLc0FcT+uMoyfg3bMS5geP7+au30PT4YFr8cGiDi9r+Y9fS+ypdvdLxyc/c2VKBw0Bgh6a52AWIMbWwcxkbzwL0OOSuemKlEpVgMFewxIyfecqatZIF3hxLv+qCWqR//VPwj23nFBL+sJIiBp7UZ56Al3sbdXAC9ItPE8ew9dysDUBlcE1Lp8aNw0kuowFwB4uVndB6GEtrv76pmDj1Do96cUm5/Gl/Id1sVnM5H6kXCk/3jU9R+b6ySrA3PkauU2Rj2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by SJ0PR12MB6759.namprd12.prod.outlook.com (2603:10b6:a03:44b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 19:30:34 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 19:30:34 +0000
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
Subject: [PATCH v10 08/12] cxl: Reject CXL Reset on multifunction devices
Date: Tue,  4 Aug 2026 19:29:54 +0000
Message-ID: <20260804192958.1823952-9-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804192958.1823952-1-smadhavan@nvidia.com>
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::6) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|SJ0PR12MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d7e124-53f5-4c22-c62f-08def25eda92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|56012099006|10067099003|11063799006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	sRKlxMsRXyKVzlY1fiKuw78rfPOTV+0O+Rt1XICRiyYXbcn+sPY7LbvnGAmUMn/ztiMM8DG3/HFQq9oRCkDHI2lq4DhfJ+f0lftIanjuiSsmSQz4CnegZBQHIxQ7t8EVXs3LQllhszyyf7eFopEhmE75oK84h9QdLBMT/jvfL/T0K+ziBMTuUfVvIR1yYmzHzqhD85bEgsHpQhZFdKASSx//Ghnwy+U3enZdJy9IId8Bop9Zm6whIfgGN1+rGJW53w80fOjTKrLr7whFNr0s/P7/uyRE405LsVxEeZ8BBjB7aMu1BiSnnh2BIb85BCwNN3MAPRSn8zOXAZsj5afFzGP98G1N233DE0OUM7aJWjgwnjwbO0j918Ax9t/WBUUn4fI3XZJNyGq00moTuB2cuvVvXzsP+AV1InNVKGlD364Wlz46nDb7FdjPdrntAV6w0NqeYoTL5xcj9kMpQF3vRSHR9w4eZKDu98TBf8eYmxp/PZvxvYmQR5nECVMzvFaAfZrOR1st/u8I9uloKtDYg/PSRp6rNwHwNWTN4OyGdC1a1PjJSdSN4FiEh6LBgQTCVj0oRPI4E3mdjESYQVx4WvpLaPtDLBiwTEeWafOQMIL7KhwmxtYcFK3vxlegLqdmdQ1xzBL37uUEkBK5GvpGdISs3hOTHEdT2f4Nns58tkDOL+9xyXNItKu6nIaV/9jK+a2RJ3CodnYYH0H59h89rw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GjmUrngAL+1i2NC54xM3WB2dlpB46035c3CyT+9UH+W+2PXSXK7JmFxMFoFi?=
 =?us-ascii?Q?Dp/uVm/lvE7WnrPcoxF4W67heD0V+3WUQ2ZC4+/Yj7NMzBncJg9WQ+ptEYrs?=
 =?us-ascii?Q?m3KMjUHAGC1F0yHvilMUlL77FTpw96UG3aQrqWbkMokpXTbmKZp496tPfiSC?=
 =?us-ascii?Q?wiB3oKiTMUH8HVnFFS1qHEBAKu5m0tXOZz+6Q9JltntwxjOQeH7brDIFpMIz?=
 =?us-ascii?Q?NSMaI0/doOc1983i77c+G8A/J1DgyAt1lmF1WerTwJMtyWY0jcLDrEwGBdKS?=
 =?us-ascii?Q?uowQ2w4/NYBhoULYnB3XStsb1vM36Ts0CbsfZXgfXOAcWc7kJ/URoA2CdV7x?=
 =?us-ascii?Q?KbiUd2QyBZp5VYhyQdkDRIqVT/cjYW9Kn9PQ7uTCAvrpThislhy2vQdxyD3w?=
 =?us-ascii?Q?fnGLu8Up8Ihy1xvV/okj8ZFbJT6t+pPGNAd52FpyM+VrkY2M7V8TrH7UEDeJ?=
 =?us-ascii?Q?ivuoNiwX/cr2XKvN6LXV08zpO/KzBpXaDaGvnbs4JdD3xjkIY0BgjPNNTVDX?=
 =?us-ascii?Q?hXa3QQqbJFq5NSFjRfBmFlGoRjrad5cwHE0Mi5CXO8Lx9mjonQWGqFDZCntM?=
 =?us-ascii?Q?h0RpYgzaWfd85/+fOKZH+V2W3NG8gofc72lm6rdKnG6GrZ39JDZSdZeCQRFJ?=
 =?us-ascii?Q?wFekbNtaPOJUZoi85st5/JVl3VsEcy5lWvCkc+91x5Np0SKMLBmUyB00YR49?=
 =?us-ascii?Q?CS4HvZ+YAe8aJUee+hpZ/+Mtui7gS25nuoXo7tFlRTHy9wrQjAdU8jOXdfll?=
 =?us-ascii?Q?KaZTGDOdv6KgV0nDvAOUD0WijlKhjT18/6ZnZ0JMf+DqK6vYLLhjov5SQ6sc?=
 =?us-ascii?Q?RiXvVvS0GtIiKv6D3w04RTQ/n4Hl+eITk0NobqZY2hQqfat5w75U05Jx7tCP?=
 =?us-ascii?Q?TqGpLKqyfp4GlXePerfgcSVg+zYxwklgER0qYHUGwPHI+rdPaapvBcztIGg4?=
 =?us-ascii?Q?EyuufkAjSPJwfFG7H5kL8zvUMaSa3x5l41EZPQpI70x+5kqTqGE8LfsCUVAr?=
 =?us-ascii?Q?5eObS3kJKx+glRBuQvSNLISpnniYVZVgXG3o0iWLnXvClRcI1HT87Q6YHlwP?=
 =?us-ascii?Q?TP2VUR7wKaNAEv//7l0hduU7D4gBk/WfSvhByz9RsYCDRsmAosNHUl4jgTMA?=
 =?us-ascii?Q?BhRIOITLL+xg1Y0Q51yC2GdLLaFfZSOnvHWdXZiAz6H6s2abzsiNGrXpFAR5?=
 =?us-ascii?Q?ciXAuk0xs/HzAN0Jtsqk4XIvCT+dCWWWVF2lg4D34G0EWp3w0gwJ7NkehHNI?=
 =?us-ascii?Q?QJNtO52brH0xH2YX6FdBXh1N24p3REfAumgSVci+Z9diyk37y/0cwt2ZXyE3?=
 =?us-ascii?Q?EFWkhPTC9Hb5uTgB8J/BRGMzqQjR8fBw3ISfnb3MFEmjtVi/IZdoYFKBv25e?=
 =?us-ascii?Q?0gnUQFfcmUyPx0wdQnC4loi+IO0e3JfeNzBC3WZyyZe1PBb2bbljD6d1NEc9?=
 =?us-ascii?Q?Z9Yni2hvSqf3v5Vz32FWc0zP+5LI5BWs7lvcfdyxj+TUbLcDlPWbU8okHtVn?=
 =?us-ascii?Q?Zh3XLMtbVi7poVc//+mKSDeUp+lskl8lrKwyvB4SnJo7vHTa0Yif5Iz94VRd?=
 =?us-ascii?Q?OxkwJ8aaupbvBQUOfhKwFmZzqLOWqrfM+Br0O5u4tf2t+yeuQt8ZrZHryyFT?=
 =?us-ascii?Q?z5EGm9KXovhBetqU2kAZpnO+60rpShl4OleUM65arwj7+t2splrNcEmiwc70?=
 =?us-ascii?Q?9zKCRNBmXIVut6GVpyEpndrpYKgAnG5zFq1IeQ5OIYwj34X0E++WQWVGVoRj?=
 =?us-ascii?Q?Q0MazkagAQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d7e124-53f5-4c22-c62f-08def25eda92
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 19:30:34.3377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S7dWDei9VPGRdwsfOVUSkeAskYtTylFt0YMCk0OotgVxs/Jif7Kf+lp7uu+aQB3NNzhoja4vv6uGVL7kDjbC4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6759

CXL Reset can be exposed as a PCI function reset method only when the
reset is function-scoped. PCI reset-method probing runs during
enumeration, so walking sibling functions there can race with functions
that have not been added to the bus yet.

Reject multifunction devices for now instead of trying to infer reset
scope from sibling state. Systems that can prove a multifunction device
has function-scoped CXL Reset can be enabled later.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/resource.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index 6d4528f77c53..464ca9bdae05 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -979,6 +979,9 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 	if (dvsec < 0)
 		return dvsec;
 
+	if (pdev->multifunction)
+		return -ENOTTY;
+
 	if (probe)
 		return 0;
 
-- 
2.43.0

