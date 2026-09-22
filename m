Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012000.outbound.protection.outlook.com [52.101.48.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F8452F27C;
	Tue, 22 Sep 2026 08:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066402; cv=fail; b=CvjqYU77+mtu0F6/b6mmInvh2vyM/+6aNpMtuHg2XH2zRU5FcaIyAriEHjZhkMemkx0UrTW5KUqBKdioZuDk/hfnCH8eJRcKBlMz51iCulVvuZvHvUnTyB+3iIWgLkEl1rGi0LsT4ZOd/R3qWuYIYxzZ01uUMYkiMqjnXfff0Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066402; c=relaxed/simple;
	bh=vWHGp0AUE4YdpUNQ12fof+R4Dq0d5qmaOwWuRLQ3o6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HExFaHviR9OG1FqyWeq5l+HjoKSkukSRJMlcxHBTVVEyHdUo14K4j9iAUhf/h8Ps/meIioUNMmWd3e/GcAyQj4iJYhHttNZUsNdtRypCXZlEp1tv+E3RYnPUt3m9XTh0ew4qE4Lo/kTNWiz4lcS8etzogC27aXOH5n7FmYmDhUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tWAjqL7z; arc=fail smtp.client-ip=52.101.48.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tWAjqL7z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OC7VmlMRx4nrEd2pSCFNbCrvFZS6/KSL7IVgvIsYA2xnBgu6VADzIr3pzPlCgrgdd5/1Akbf+nFlYXbm8YCSputCEQS/fm2MRsYCSN2QPYBvAtzmUny2S9jj+Ujj9U5G62pwfRbKkzP2NJ8sfXPUWviSGoveMzQo/D0VHGKPvYiAi1Kl0mNqrUw/SW0BhVJGt71Qx9K3DcgP3P2p/1Po++Qx7rSxDxKcdEhmVbs+MFFzEQx9NEUlCd2I0VeHgxy2mYHTkfktMdKJolylM6xsf6sBCH/KzIZ9oi+o3oGrLVQr4VSWza54TDgmpOC13elfmsbnZxWdWvA2m0Zh4HReJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiFq0NntyQ8KMausetShLpY8v9ZsbCeV169YIcblJzU=;
 b=smwPWyN0P2MajIygdOltWbkToGDZ7eku+AwUhu2xbUsYDZ9iC0dPvr/j+vcgO7Ha0wwMPegQpmKEK8dMEeDdbwLgynuusV3Oq6Xviu92ohSrMMnD8Q1puB2q+878vcmOPYGJY8yNtWiLNQrxXVTayYOcu59YECYDGG4BgCgjjScRSQSnXlS1iN0PYk4JgsISTAUF56sBCKC1Bsl4cWaIk3UETxlAfO2+Sg3evdJrn07MODVWe7URQiOsVISct8AaTwLJxEC83MiNLBPTxtuVGzl6Y81MStPFZ2s0JkxqkfAlFJL3j28xGka3NZpOu2Q4zt6884WytMWzWoQnaXRfeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiFq0NntyQ8KMausetShLpY8v9ZsbCeV169YIcblJzU=;
 b=tWAjqL7zOqOTCcIAEn+YKWtF6P6WYLKokfk4Oq0Z9DVVTIO24KLf7HIJcVScs2CYC2Emyy8q4dVt8WXttciIdkFYJlEkBAZtLLcFOE9RircYly0u78vdHRY6dObTcgeAd9bQOL5T14IDNh9u+eJWaylgTO+lVmlxvuHuBqGW5IlS2y4ENSQM3W9QNcOp4Z3SW647NfH8UZyLZ5b6JRo/jJ6zf/8KIqUCdzuGxWYIjWIhvQqMBHdIr+tMp0kom3z8ehBORJnjLizADJxWj/VkuvAKa7REdidXKj29E//w3yv8wxtFWhfiZn0dlc+CaORi5FLSqSyjBDRIhIYTP5Z5KA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CHAPR12MB999223.namprd12.prod.outlook.com
 (2603:10b6:610:301::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 08:39:56 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 08:39:56 +0000
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
Subject: [PATCH v13 12/15] PCI/CXL: Reject reset with unsafe function scope
Date: Tue, 22 Sep 2026 08:39:21 +0000
Message-ID: <20260922083924.2451158-13-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922083924.2451158-1-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0061.namprd07.prod.outlook.com
 (2603:10b6:510:f::6) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CHAPR12MB999223:EE_
X-MS-Office365-Filtering-Correlation-Id: 19879a5c-a75a-4196-003f-08df188514bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|921020|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	p98LeSiG+AyDfE5mOA34jWkL1e+bijlrzqbNZyRt8VSJKUojfJeh7pXep4ApyaKiba0ZZ3+XXrXOMJMvl8TFAjNzrgOQwKM4aaNnQU/fLKZESdLUWYj0zZ/1apVHwLpdHgLyqwpA/Bn/tMpPZc+u86Td+jX+O1N97dTWbEj1xoLAcz1Rh0sCraGfhXIxufdJ+bM0G2/kQlrgc/9/RxFfxRUqNEMMwv+63knCJje9xx0lybe/Rx9IJjZCNKyUpxS1qzkimPo0CJvt3UaeFm1wqw6eLeo4qAVoMf0nkIiqXchxNofLK51rVjuf+z97rkvw99VFFCuYG16Kfm5qsNYBflP6Qj7hrM7SjZuJj2lIIO+i/UgI5cWcPdiD5ecIlJEWCbkx6Mn9mg3/yoJAXriARdPyAwd3jXmNl55jLk8H1+5PQvQrtwkmYHdl1/XetSslgfkSplv+0+KLk/Aas0eEea5eRGSvjnY7BOP/eiKSuFJVJ1kmRIGFaV/dglxgHJeS2QI1rklazvI46gbqlaGhGifLAkogzlP9iH/xoDmi4nn7pzyfcXd89U3MFNf0jwIGoeiqZ7vF97zJClO9lJnRUGI6fLBOcMonAvYJBBuCRfHt167NsvWKr3bKsNmkXwws1mDpLW8nXVSPdCyy2PYy1NaQknmMs2TLSlmWC/44hCKc6bKi8IkULQD29zXk6EUFpGbvU4x6axz6QvgPO7vUtw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(921020)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wyks2smM8Ll98BUAPHQv8bOynZ+nBrtcQTZmRuWrOEaGh4XZgO+vFfSuj0Au?=
 =?us-ascii?Q?7rnHk32n1f/F9UQB9OXDPAiHxZBvatVNNUI2chryINCIO0k6x/mhoDI9Mk6N?=
 =?us-ascii?Q?YrsEo9e02vLdI+TLyef1jKEBQRkkB96yv0Jo9rzIxaxbVvItkgxdilSaUyLN?=
 =?us-ascii?Q?RQfAgTSeADbzxqEvYxKFTHgvuF09vQNONZeD98ykL0/XDWGjZlyCSndOuzwf?=
 =?us-ascii?Q?AMnus36M2hT3AzEXwOwX8T0OWE0ZdNxp7d077ub0MDW+omhdvZ3ECKmRiHvQ?=
 =?us-ascii?Q?ujCmZh6XyKd1BMURCt1+Fs0SxZlz8hK84UzUq+HLNJmeOYXAprw17IDHQhBn?=
 =?us-ascii?Q?DF/FZvo5fPWF4YVwBBuXqW8BPDR7XN6dEWdkDm1b7KPk3Ffj49EX+Sr7hUh7?=
 =?us-ascii?Q?wJeVbeIJY0Hoa5NXpkeFbQzWxkLfiosvVFnQofo3KauOIm9Qxdm09Y+/bH1z?=
 =?us-ascii?Q?qxZhdIcdY4uN6+9j7zLP0r5+Pd0YPLjO30Ki7GS7l5mGOnUE9UIVgEaOpz7F?=
 =?us-ascii?Q?vtJfJmg9/HTu3AdxcvzNxfoPIqU+sed7PXUKMjES0i1TeMbPm4C8nhewZ4e3?=
 =?us-ascii?Q?mefBYXlscAZOc2UdolJ1aOc8ZTb5bZo0xqtVApSv8KpK06k7w95pM2QqMn2k?=
 =?us-ascii?Q?xzQM7x+tst0mERKRlASIwlvTTTyilU9EoyMmzjEY3RU9HExiKKOg6hx9/roT?=
 =?us-ascii?Q?+/gX0E4E43Ah9rxU6IuN4rcE/cSDB2r64Nt3FgjNQFJqEzCNQ6iDSB/RPZ0q?=
 =?us-ascii?Q?UCvRQRpcAaph+c7Q0znVG8+MGowhyBtunKSn8EnE98BNGoefyaQtGMDkX7jI?=
 =?us-ascii?Q?c/OdnkDzPBMoIgrgSDY8Ui+m8BHmFjGoGRXP/lDit7P4dbQuqEMmtgUJB9SF?=
 =?us-ascii?Q?SxmZCeZvkyIzSVrpem5W5g83ElIPFakhQ1cHXFRKwWzFrSNn8mcB524uo05U?=
 =?us-ascii?Q?M8YP/AgosdlYxIewhN/XdVDBGEuIg6XFrMVQ41AA/59qTlMPdCCGgudmiAOd?=
 =?us-ascii?Q?pq+ni+GU5d9zUKPY9gIrGDLENb9GVpg7jvcDzyUF8EV5k9Ry5THV+EYXv36m?=
 =?us-ascii?Q?+c8eDWlJyzeGkAW2FwslC+Jj1En4y9VjlpFSCV64ckpDD+6HFFq4xIcftE7Y?=
 =?us-ascii?Q?bpUV1TmtC2uG07sT1i4nd4XOeTb6+M9K7jrjzUhd87Mb3GLDkiuVMj6WeeOp?=
 =?us-ascii?Q?6Vnvmik2cWuNQ1EG1Jb8UrgE3z5tUgcLAHe7N4WStFpMqDvIDT38t00Ujex+?=
 =?us-ascii?Q?LA1n9QuzS4UHcRNgXURE90eUOxrXQNlg9vi7jEoyS1qnXD7GGMO02gdJhXCK?=
 =?us-ascii?Q?JEmccJGEdbnDJLnYr5Ri93qp0/VKbRodaRqLnduwAGalvIdERiSXWicu1p98?=
 =?us-ascii?Q?7sO0/6qJFw9YmAVPFW0LYcSil9TUuxZ6/Bp2o2nHBAwqtvOuJgJ5/uztr38+?=
 =?us-ascii?Q?c8zn7AJHFgktVAl3NhmXCxYU3CiKC5RdommYsIz4uR/fj41PzHAan/ES3aqN?=
 =?us-ascii?Q?Bg1GDRhxWOjtgF0Rc8U6aKpj6oe9zSwj7crVHSBMuixnuwhR2f/mVT5mDBmf?=
 =?us-ascii?Q?tjWRxS921QYlyez+NawP5lx1kek0UspqQ/+IrygBw3O+wm9KgpULY1n2+w4s?=
 =?us-ascii?Q?ra6ZYVmQlnIuLDJjFa4m1NP6UZhElLP9aK802LhVtQZq8uixaTs2oSuP1YL7?=
 =?us-ascii?Q?1dq6WyWNJ5fgoesqImtk1LnxZ69J/Ne79XTKFcAsoPFtv/FfNNbibKG79aRG?=
 =?us-ascii?Q?XPmgFmDcBA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19879a5c-a75a-4196-003f-08df188514bb
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 08:39:56.8001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQQ3XsxgDvRpxvaKDU7CXEkBP3XokDw69Z03S0VBbTNWmra+eX993ZFIa6dEIPqXKV8oBHYnUrxhMKnqJdnc0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999223

The per-device PCI reset interface must not reset sibling functions.
Reject cxl_reset and cxl_bus for multifunction devices and PFs with
enabled VFs.

Reported-by: Alex Williamson <alwilliamson@nvidia.com>
Link: https://lore.kernel.org/linux-cxl/20260626160846.426e71b6@nvidia.com/
Link: https://lore.kernel.org/linux-cxl/6a50441e2bb5e_3cabcb1003e@djbw-dev.notmuch/
Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/resource.c | 3 +++
 drivers/pci/pci.c           | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index 85a554b6236c..249b1280f3d3 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -859,6 +859,9 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
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

