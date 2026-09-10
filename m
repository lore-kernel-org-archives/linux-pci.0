Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DC23D6CD5;
	Thu, 10 Sep 2026 07:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024142; cv=fail; b=HxBZJyhgh8Fmy1hql0Zo8V+f1BqLk0VZUqpYh171xrPMHTKLNRcTBkQ+/j92gV4qxoLWei2JfsrL/tbvxjeMiEp+wjAwjyP0vDMMJ5stH6P1CWrjOy7wkcZ3YucIOXtxrOlVtK/ciimKtOmlf5EppSpV29pXDPKKArQ0oE3nZR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024142; c=relaxed/simple;
	bh=w0whY3U+VLOLI0wYseFKdOkzY6erucqlE/X5mgbnA5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AnAAmicpm2BmYQR2a6cG41U99I89VWdQuH6e3ZIRmG/Q2nAAzdzhP+/u1QVazMX79/MAuch7JD7uRaHmwdO4KTKjbNhPwtXszhho+LLyVgXVq/REQ1QOluKB3/hsLw6iPrFg420AVdLRCoiARYeYovO0C5s3OUEjT36l/ynqFSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dYytggJE; arc=fail smtp.client-ip=52.101.53.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dYytggJE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2WwPWDYSicUQS7pggHRsOyt+HMtU9/I8CGsPtCd9lRF5LvIih8jqzb7aYhHa2wtX+5adWjbLHAgaqK1yVAk+06w2QhUHt3+LNwWz+R5OyYBXwAIjh8zNdotJcawfIT0zWywlX47K2p2N2KEhjAOMS4F77CBRcYn26o7G7BPUx2PxixSCQXtbn30WPnlnOaigpSJbDSF1bckd7CdqtfOR9BjK8w4N/3RbKZUd+r+MFrcnATdyPWI9ZFCRwoj6Cti3agjjeyIR2Utb/WBVB119oB1Mv11uffqyIkkdz0GWciJJqr3+2s1SeR0y41mQqWrbdb+laa1lJ/ZWZrknz+kgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8utneEjzS9agij4qHoIzJ59iLbQgcFD3hqoT9bH07oo=;
 b=dddwhdrLtWx/l3pHSgS/6zkJqhR1Hg1pRYhip/BELGL2BhiU3KlI+qdqRgj2LgUc6hhXok6oW+vIsqLvzH/R+F1EAfX4T6DnD7QoP80gcnMHk5Nu7xXq/VPa8OZnwnHWDJM7iiJuqPqTw9bLX4dJ44VP/35H+6DEdS0LviHr5hONAaHwhXwQEhiUjc+qVrHHtGYa2J1DzPh2uvBv7d9zBRM2TUwvOpNmvOSG7nBCt6CQf3uRX2JCtdKBPjUdhEWDViPD6OWdm1bTxwP6wYK3AJZX/WuCSR7Llw9TPqrpXTy5m1VOTQIDFM+6akTGBzqKctHt0Ql4qYoWeVJevyNvcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8utneEjzS9agij4qHoIzJ59iLbQgcFD3hqoT9bH07oo=;
 b=dYytggJE5eA26+oUiD+LXh42z8wLz4GaL5oyVAwHmJgX56k096vFE76NRdJPQ5nqjxG/WJHAFyes3xMvv6b93VpVV1PJkz6WknuOwmCgSQnU1vtyMf4ILEAQWAh3DyXdO6NYmBWCXSgbFANsaUssY9rc/LedEJHw/D2VcN3HqLuk2UgmFFOM2BL9EAk+zR9gI5yqdwFO1sulLqfKA52NcCR8aDrwy424hiECVQG2NzvPElvLDj55a7xtQOQh9xBAOLJQtz/Tflgy8ZGSzU6Ub3CVr0xUg2MaYL7MaHQu0vTmuKDYi01GqRaHHiRVmDSUuQz1Sb98+XdtXhgaaHEMWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by IA1PR12MB6210.namprd12.prod.outlook.com (2603:10b6:208:3e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 07:08:48 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 07:08:48 +0000
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
Subject: [PATCH v12 08/12] PCI/CXL: Reject CXL Reset on multifunction devices
Date: Thu, 10 Sep 2026 07:08:04 +0000
Message-ID: <20260910070808.1444264-9-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910070808.1444264-1-smadhavan@nvidia.com>
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::35) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|IA1PR12MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: 468ea9ac-7d99-4273-d6a9-08df0f0a5c2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	arLOoS/nzZxbYSup49ensa3RQjQ/LwClcaM/72Gxqi3OCep+YnD2t+6NJK9QFbkpMgFyE5shAzFtr4b4+cUqKQ+wxD0BaxOdzgVs4/spurjIMPsK5KzigfO2mtdnvwCQZYtWw8bIRui60s61SncN4KZ/FwuJXedlgGw4cBO4TJ07+ZNEDqGQgM74Nbx/8aVU7AzAWkAJ72tb1ZEE09G1FG+784zNsrospmJ4f+pVRVGmoWPBalaDscUOLVnGPKviOPt1ghjkZkTwWbGimQOIprGfsz6fGVzcgmhRLl3lQ0ZrjOxpmzWvwALrobVXJVEBs2RwAsiEUzyCTyg7iWGSVBVZr92rv3wAIp0AloDFgyJhlSgWmUmFw93MBD/qqnpwfqRg33tzIBd9dvDW+cGA1Rmcc5+eVPoQDaF/d4EQ/Q7lsWGzv4A2gCMP5yIjc6/UwXSTIjhZH13hBK3+g85CWvVxIo9E+EZGzM/2YsF79TedSuwkDzADwOKfuvcQaYc+oe7F55OYPHNiD4gRArrVRovIhk6qI7P8Mr8dFtKItUu1qzNkdrBWa+/tfJtOgTMJ2YZSAOUdtYHzjSwkDclG01cgYosTSa6vd0HUw/J4E//Sj5hT+uJ4KPwirKhp0qctPO2hGhZPQjjVgTFxoeLMIwbHROUehwEjiv35NAojUsgVQgu3T2tEUujxVcELwjos8eoMYRKIZbD5yKmgx2y4Rw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?akQFnFPE2TrMFNhBhkLOhnlSX9tf8dtYf6a7hSWZhs12KTsTIOcFmRblPuP/?=
 =?us-ascii?Q?EYjeiqWfvXItYSAwQZNtbcqbPSxhJZXyV+/9rasp/iKhG8maJY7Tlaw+gi53?=
 =?us-ascii?Q?3OBmGB7Sf+VxGwqs/ccDnw35us20dNS9JdYT7c4BM5uIKatcgCVock64yyA/?=
 =?us-ascii?Q?Ewom4fBq1xj86542hJaAZkncLpExbxBuQgLvhfewfKC4RbUgPo9jMhU1+ZZr?=
 =?us-ascii?Q?R2LhqMqe26ebcJY5vVQhhPxcBfOqMA0KU5zH3vFw1nTCFflgc0Zk18wJrY54?=
 =?us-ascii?Q?v/sqNp8ISEiiNWgsOR6ae6XsA7NrNhUKl62+4iLHQDwN1jO0Im0+l6dp+WMW?=
 =?us-ascii?Q?w9VRudIMR3ZP6fXPgAr3wHiBbGQZJTZYW/9LI7XOrmCVj86oFZYUs5qh3b8f?=
 =?us-ascii?Q?W7hPgPPziAo+NT7TH35/W9nrRwJOA231UaJ3no/qHN8rmiuG44hV3SocOUlV?=
 =?us-ascii?Q?lG+X/icd+bFo8Gh4vGORXx+1cyuqYYlEtiORey46V8ozUIqHBL7Wa4OlwLho?=
 =?us-ascii?Q?Of9PglvuL54OezSwBk6BE+YFQ2r17c4abjJ4LoDfbVe7j0C747esELPvjFD+?=
 =?us-ascii?Q?7mW3XQ/LwjIzJWxjI17TNpeMR9IPuaY1Zqtyu8M4toKgiTE+PS+w1ugweQDU?=
 =?us-ascii?Q?doL5sNqqme0whxn2TWxAW+42Rw6q8TvI9rB/vbY7Q1G6oWk+2ajT6d++hHE/?=
 =?us-ascii?Q?ySa/n0Zesx3EQnI/zWX7q0kKWU4xWFznmk6vHl+dcsgiJ0Xw0vLqLOaj5jtY?=
 =?us-ascii?Q?nWhxzhpF5dakyyKvy1cBIOjG9gUrmyKFTu8m4iIbd2jkbrHZ43shNso4hO8R?=
 =?us-ascii?Q?Yzz7eQEXDQ1tjvUAupBtxcIPiSSgRUtLadWN0sOUira30cGOTOWqgCBUie3N?=
 =?us-ascii?Q?5pA26r+35oqVyDnFjatTLg/shnkur/kmB3Zf25W4/gt3xJhrtNYEkDGgcQ5P?=
 =?us-ascii?Q?t36AVuwKD91f+Nbppu4Gi0eD8RZJ9Ibvjp07iffZxyBopxpcvBl2tQZEn4G2?=
 =?us-ascii?Q?NPNqmGBHOG3BpYKZ6doNPNXbdNfhQ+XRQruvvdHB2TNdKdYMBVXKEvzFx7s7?=
 =?us-ascii?Q?o4FhDxBKDcAnp9Oqof+Nz9YvqzQcTn/VkmGxEFadBR1P5R6gW/6gHQeVheHb?=
 =?us-ascii?Q?M4bGaYaH4/eA4DqhtBydDdz/gqlpyJgYKA9pLc5UGAbqZeyNyhHGR2iHc4wB?=
 =?us-ascii?Q?31Ofzqtoz8z2jmD2sQr5ex4S6b/pi/TvZOncFB3n7vm3xzBphKQfwLGAYDMw?=
 =?us-ascii?Q?fgEuv67w0LFXTkro+kyyccRTBs/4+Yit0jK8Na4WjdIUOvK5PVO8/0EjkmU9?=
 =?us-ascii?Q?W8ADXVS7HuHUw7at7Why+yPPBWlsy3YaqDGjzHAfqUWZaK+y5tS+/FULDu/m?=
 =?us-ascii?Q?JvwKpac5Z9SHg6SJ3ii9v6YWVLMmAiLb2aRpKBBIEKRRQ7uWFTy3IA6yP9R6?=
 =?us-ascii?Q?hUAW+23gjCqk+y1Fo7uhqOAp9qHh01t/2SC6KHCcvGVkJ7QloLRoMbWmaCo4?=
 =?us-ascii?Q?9YrJSe09fwID7N/TQy3i0/ceY2BwXLuQEIDWk3hNsjBNLziqrn/yYUzO8hyM?=
 =?us-ascii?Q?npdjuqY0LoqTRVWtUH0n1Kbeb2+HAaATBsiOPQTzT44Yusqa4RC8IGWEQokk?=
 =?us-ascii?Q?kQVFMv0RglRx+RNmMweORYDwheVz71apl53Uc4aRKN7looZ2DUfzbEokEfxA?=
 =?us-ascii?Q?1J3z2Wk/2u/AiQzC9PiGZ6/vb5V8LPwcVH9lHnkflbV/7N83xKahrNRdtrBo?=
 =?us-ascii?Q?FK1kgo7ZTw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 468ea9ac-7d99-4273-d6a9-08df0f0a5c2e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 07:08:48.1729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZ49PusNi1R5CDNqJ2bCqiY3IJoGs1itya1IXbbg+9neS7n/dvvXh1hoYDR2/5i32wgiqHZCLbFurMbLRIMqVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6210

CXL Reset can be exposed as a PCI function reset method only when the
reset is function-scoped. PCI reset-method probing runs during
enumeration, so walking sibling functions there can race with functions
that have not been added to the bus yet.

Reject multifunction devices and devices with enabled VFs instead of
trying to infer reset scope from sibling state. Check both conditions on
each invocation because VF enablement can change after reset-method
probing. Systems that can prove a multifunction device has
function-scoped CXL Reset can be enabled later.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/resource.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index 7e4eee3e50c0..ac0284fec51e 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -979,6 +979,9 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 	if (dvsec < 0)
 		return dvsec;
 
+	if (pdev->multifunction || pci_num_vf(pdev))
+		return -ENOTTY;
+
 	if (probe)
 		return 0;
 
-- 
2.43.0

