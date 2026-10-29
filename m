Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793285888;
	b=jWEDICY4ZPfZ4aRHYKC3fUd0ddBdUJ3u2TyKU9qf3fRquWrF/aEdyk2TghQ88XBje84w
	 eyut8MfxJyd2LMpuOTuc13TJ9+WyaKuxBETebwjz8I8SZfvwVzZCY6me7tJSBBdN1ZL2B
	 cKs95vByLqgIIvaFL9aOaCqCnaJvwpsoXjknhkVGJn7qAfGQL6RYkGSCIwe6PfCgJGwAZ
	 TzwKA0BZIUylGU8rzANAVWNVa9ZROKPMdDAgUyB2Rz6lnx89V+xMGo/0AN/mPX+HjKWxy
	 AbdzIvUCvoh9UUjxuZTOmoiUDdEkTvBB5Niqgt2h1dhlylOSTerDmfS3u5qWXYh2Tqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285888;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=19iXfd7FDpu1mwKIoqDQDss/ykj/C0Ia6sabQJoWuRw=;
	b=ky97MqBPch8xXsxX5n6medXK6lD22ML+11RROoHocunLYZx/FBRHiXiqqXmlJAHOcRqT
	 FNiRrNu79Aik9H+JKj6F1X0B9STJlT6L8q/DJUhhFq9YAnWAZTO5zP/ONPkWLjwUHcjQd
	 e1iC3eh95yqFsrUXSAR9u1x2MG6NIblWZ6bsuy1IvYS8AYQUNINYcjtZrK3vH9Qh9B9HX
	 vEVeIHagxrfOmm1f7WdsUbKeb524EVw7rJRA4DUWRD/Ww9RzXvXRTcJ4amsp+tdxhR2J1
	 +XNUNbVN1jExvnxU147k7l4QzrLI1YJq/EbDT/3EWIT61MX/wFjqH7UOb9vzOE9ThNg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pzTrYXAZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.50
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011050.outbound.protection.outlook.com [52.101.52.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C3460A5BD3;
	Thu, 29 Oct 2026 14:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60C3460A5BD3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pzTrYXAZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jIRkczvMx9me9iMWqb3rc0g+w4IC72oVcfr3abC+1bNu6PZWr+S+jrz8quPQTcq8NQtvYGorX3dDY2hagtqETnSlbu5yTsJHqDW24qe1vMXr4s21/75+7CXfFqMPJwfDFfFeRs7ENwouCc/ey1rkp6YWy7OO/Focs7XJaf4dmGwBjU3e9d+igq7rZMas5g0Oh7LeHstc0gMLoqlm/qsvfqy9Mt0svZbaQf6zqnqdhL9Bw2eYXdzNDzp4MoBhh+URsXMXNRcuE4Xq/NHiZN34VUXFl4/ZSS+R1BBOFQvPajAVD5U5VvtojnAp5lvB127HvssQgoqkqxP2Y07SKi3Rkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19iXfd7FDpu1mwKIoqDQDss/ykj/C0Ia6sabQJoWuRw=;
 b=WDTkejB9rZSRg0u4ut76WjhzC+JjD5DHH5WXvAWZDdLSzxpT2zgrtgE5ltJsP656lo+n0LUSHiqiLpdfRVoOss56/xDh30CZ8UBB5mEVv6JPBCnawKocWwuljiD7AL/xfbXwdvOTbP14+q8o8R+01SB1HCmrgbIE8HGOj5XUztVwNhzCuGA+Ec7aLRpK/PvBeWWxZJi9ckOKgtQjRQN55HvI233cSrVw9OVIxhpyxiltvDnMYqnH7V0sW3inJ3A9IyB43chge82w8gpFbXQv1VXR+rQL4HVdxcAfabsXcSi9Md9ZmIKJ+QdfXYqApL+XMNaW+M0ScKzZrGH+Pidi4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19iXfd7FDpu1mwKIoqDQDss/ykj/C0Ia6sabQJoWuRw=;
 b=pzTrYXAZHn9If8vIgTBE5fDheeRQ0eCrJz/wqa5NNjlmdLE7myeG1xrydvsnVYL4exzOFeqAlUAP/KfTCLIMo1Z2BWzu0OcIjkRH8nXTSV9bT98iDvxqDF6QdLPonV69OQ15MmkBDmqB89vmuao0l/CND/jL3eU6AbGS64R8qQR3Im9xSGpvoeEgv/kBzzDGnnoyarOoF/YKPBCIEUa7trjHRyqOnh6fq5lFb2oBOfoMsIg15lfMVrHq5ATUgj4gL4I3GRiztm+xYLo3lBM8kAwdW4NV93cI+YZYjkTwLnFpbdoLI9BTL68uNIvkdKHLqMiGQRw8PdvpaHOzC3P6wQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by DM6PR12MB4105.namprd12.prod.outlook.com
 (2603:10b6:5:217::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 29 Oct
 2026 14:57:58 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 14:57:58 +0000
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
Cc: Li Ming <ming.li@zohomail.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v16 17/18] PCI/CXL: Restore CXL state after CXL bus reset
Date: Thu, 29 Oct 2026 14:57:02 +0000
Message-ID: <20261029145703.2185231-18-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029145703.2185231-1-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR02CA0027.namprd02.prod.outlook.com
 (2603:10b6:303:16d::32) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|DM6PR12MB4105:EE_
X-MS-Office365-Filtering-Correlation-Id: d3f671ff-0bad-4a2d-926c-08df35cd053d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|22082099003|18002099003|261028144727099003|921020|56012099006|5023799004|11063799006|261022105027099003|261026121527099003|261026140227099003|261009223027099003|261022075727099003|261021130227099003|261021133027099003|261021123027099003|261026130827099003|261022113327099003|261026135527099003|10067099003|261021135927099003|261022115727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	Zinl2kEKi8/qAtM1xa+bcDCsIUydQmepwGIj3Q7K9Cq3PnjCJwyanx87WPr2c8MpBMSLcU7j23oqo99WkuiLgKxwvMImqPcfnR2Zhn3IsBLU5pOF3gDtCWspA9w6vl7ENax90e0owI1+pcJfWLn5rnOS6pfDltPlvlxLJeztsuUYAtPQM7CkdGQ1ZMtOAiAxDSKBKSTTrfbOSfrAeGcD0MCoaRB4Y1Y3DjqPYKFCuXkq1pS+YRUmo/tEii6sHmX+IsymK1x5D3tp+h5Xu6yP9ps00Juf6igr5/en7DCi8W8ZGp0BE/OCW/l7NU7RHVi6xBPuAQo8n2wHcgLPGR+qXwEtkg+hijQ1ifIXPm+dqn64iEadiBbQ4qbw+7wZN14dIDOnkKRhzCB2c7pIYppVsPHzLutTw6TQ49mcRgJM3N7emP7J4qyU9kvHDEkds7vY7LAmeq8l6gxeJXnfiNfCBMPE0np1QiVuBIvc0hevhTu+LMFdNxRmrfJua1ZZFZLpoqWGq/WNG6pY3jOosOf447utF1WKgkC26BHde8FeBzPLQMpL16d4RAhCB3tcz246a85qV5epTQLA6S4ffkDryj28OONCIoMrFfcILdluQ+F8eiKUxAS3Kiug/CEAxetMM3QHa8eqWtjYdZ9aSG6d4HtJMH9b2Yh8pvHprji0fEVeKzp1YQ/37A/t7tdEEMzo05uzo+DRAAJyo5Mgq+rJ6A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(261028144727099003)(921020)(56012099006)(5023799004)(11063799006)(261022105027099003)(261026121527099003)(261026140227099003)(261009223027099003)(261022075727099003)(261021130227099003)(261021133027099003)(261021123027099003)(261026130827099003)(261022113327099003)(261026135527099003)(10067099003)(261021135927099003)(261022115727099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nLMqOD3waZgrhXk99qIB2RavgiX/Za2i6byctDi55cj+WzSqG1Dacpoht15W?=
 =?us-ascii?Q?h1dc7BCgwrUwu5rf8vXjtr1QC4Cc/HiRAtB8F+34ax9sDOCDDmPhU6HC2leP?=
 =?us-ascii?Q?nsJCAe6zKaA+fwOXTlY7ULyqnA7Z+C4BzMJ6abC3Hbje64ujGKRGFz4XaLZ7?=
 =?us-ascii?Q?nwZz8v7qrLYXeD4AVqtJxQs9qS6/Je4We0ym9KczMfCN63gh/Bo8z4izqOHd?=
 =?us-ascii?Q?hREklyC4i1LF+GErrN3q0z7ulPdbrJvLb83XJNbLxDYHKXknbC6iY+upPlai?=
 =?us-ascii?Q?YYhMzgjOtfhAHLuu0Emj8XSKD3lGo8K4dDgcof2f8Oom0PIWob6zaebCS5tG?=
 =?us-ascii?Q?qpRakEPGSeab/PU7xSVMBAXwHmBiElJEcMd0bYLzpvhkSPs9qJVLHsmyqd5p?=
 =?us-ascii?Q?XMhBx9R40JdhU/qvh/uH2oitHbpLO6xgW5ia26lEf/Lrd2G2hqWl8jBZTecN?=
 =?us-ascii?Q?kjW1tFWVYKM87D3vxOVDTQK0AiuRtRv8nRLoNW3vE5s/crQBCpVIeZ/5+OKh?=
 =?us-ascii?Q?l25ux07yztSQdEpCx3AtkZTqK9Tas5C0Ri8UsorZrKZs7phjNiGt3xa1Wa6d?=
 =?us-ascii?Q?q/TqJTzOPOc3BJzxbZvay6UDdW0z03PNl2uH0c2QM2gS5y6HLvHgfnl8e16u?=
 =?us-ascii?Q?teC49VtVfOnJ6/8sP5nVfkjmW0/1s4Rz5E7ruE1p2kpLrlw6UyRh54UiSHkt?=
 =?us-ascii?Q?WFrZ9icQTjf3cf55B2bQgNLwPENsgOSMYhG0QjcbMbS45fufbanzuhXWlKE3?=
 =?us-ascii?Q?XgF443KFl3Xuv//IOYg218LY1hfomTpTGYfyiHsFc/Uk/WVFRmQFUpa9bMYA?=
 =?us-ascii?Q?M4O8oPO28WQ96/pQM8ROb1Kk9RXjbGNxsSjfUOrEqWh/IfNV1U9q7uS6WZQv?=
 =?us-ascii?Q?4KLI8mF+MJJlpmWr6j4LkH6t2RZNvdkr+iqy8ofexflw3AE/kB72WiIHDXR9?=
 =?us-ascii?Q?1QyOYnSomqW4ou2+JybfEaUrAiaxH4mI4T9BVElR4NA5Euxfr/4EIPPZ8RPc?=
 =?us-ascii?Q?sBSe5Jgq+g5VyHjPKECPQ3lksRslK0HF83CYrO+pBP7ZRvYZu0WAqckvMXDn?=
 =?us-ascii?Q?j3IwN9ykF2SA8Jb9JfrKUSMoXfiqiDRu/opx114GBS0bTpw91Ft884/prnPk?=
 =?us-ascii?Q?8WynddZSQYkhMA8s3P8m9tvj19aloB5yM/AcmBuK6vJ0sm4PiWhBZtUnxMEB?=
 =?us-ascii?Q?7csvJ6qNqHxAvnAbuvEMszDVtpsUAD8biUazvcSrskvjUvecptBJCCb6PdDz?=
 =?us-ascii?Q?SgxO+7SQ2Hnf6dza9KLIrmRvSoehiGSy+LK7hOPkUF8oL0/NdApJn4TlGBS5?=
 =?us-ascii?Q?GLCW44fzgYI+cFhjjhSgHRrXseb2faFkTxDUWBBEzl8jZq7nHOnPEp3KpFrX?=
 =?us-ascii?Q?ELB4ISkYfHgKKKA9NQi5MlLUFu1Zxgr2z+1DsRH9lgZpQxZCn/Fiz0UBna2k?=
 =?us-ascii?Q?eF22V4lZ0tswQBJl6N9S3CWc9YVA3hSZNwMLda1/y44GEaRRYql7VwxEEtyY?=
 =?us-ascii?Q?IPS1aiDwwXrbwdPl2auzIHALHRNxuryeIvHFIzkQqJgFP380ZefcHabe4QjC?=
 =?us-ascii?Q?hvOLCelXO9RUgEISFoXr9YaSHN8F27beCnkBphXwn21dA2IWI+RINMMkem6c?=
 =?us-ascii?Q?7mVMhiUdZCUcQkgwl1mLVt7YVyrI+Fal1S1EAi5X4u+UzZJBanEOhgLIrnwD?=
 =?us-ascii?Q?a5u+sbsaeaRnlh0zavzFIqvw41faAG+jhDZR+WcO7+8yG5qhC677VIFvAeWT?=
 =?us-ascii?Q?2WT/IHxigA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f671ff-0bad-4a2d-926c-08df35cd053d
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 14:57:58.3158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ba+6+newyjciLgPFwoxJYMHd37U1iIhtE1aB0Ot66YrcaGaQsuaiHfTXIgLPGcFUYU64AmmQLV0AChygXNcwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105

CXL bus reset can clear HDM decoder programming and CXL Device DVSEC
control state. Restore the cached state after a successful cxl_bus reset
while IOMMU exclusion remains active.

Restore PCI configuration first so HDM MMIO is accessible, and preserve a
disabled state if restoration fails.

Copy the cached state before the reset, then refresh its decoder settings
from the cache under the CXL region quiesce once the reset completes. A
region decommit during the reset updates the cache, and restoring the
earlier decoders would leave the endpoint decoding an HPA range that the
CXL core considers free. Keep global and DVSEC control from before the
reset, since a refresh during the reset can read them as all-ones.

The prepare/restore interface and decoder-refresh structure follow Dave
Jiang's cxl-type2-reset reference branch.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com> # pci/pci.c
Assisted-by: LLM

---
Reference branch: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=b93f0c8e67b198a63786fd3721b7177ab9df60be
---
 drivers/cxl/core/hdm_state.c | 31 ++++++++++++++++
 drivers/pci/cxl.c            | 68 ++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.c            |  8 +++++
 drivers/pci/pci.h            | 16 +++++++++
 include/cxl/hdm.h            |  2 ++
 5 files changed, 125 insertions(+)

diff --git a/drivers/cxl/core/hdm_state.c b/drivers/cxl/core/hdm_state.c
index cb7ec0f86ab1..6b91721dbcd8 100644
--- a/drivers/cxl/core/hdm_state.c
+++ b/drivers/cxl/core/hdm_state.c
@@ -188,6 +188,37 @@ struct cxl_hdm_info *cxl_hdm_cache_snapshot(struct cxl_hdm_info *const *slot)
 	return copy;
 }
 
+/**
+ * cxl_hdm_cache_copy_decoders() - refresh the decoders of a snapshot
+ * @slot: cache pointer owned by the device
+ * @dst: snapshot of the same device from cxl_hdm_cache_snapshot()
+ *
+ * Copy only the per-decoder settings, which region commit and teardown keep
+ * current. Leave the rest of @dst, including global and DVSEC control, as
+ * captured: a refresh during a reset may have read those registers from a
+ * device that returned all-ones.
+ *
+ * Return: 0 on success, -ENXIO when nothing is published, or -EINVAL when
+ * @dst holds a different number of decoders.
+ */
+int cxl_hdm_cache_copy_decoders(struct cxl_hdm_info *const *slot,
+				struct cxl_hdm_info *dst)
+{
+	struct cxl_hdm_info *info;
+
+	lockdep_assert_held_write(&cxl_rwsem.region);
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+	info = *slot;
+	if (!info)
+		return -ENXIO;
+	if (info->decoder_count != dst->decoder_count)
+		return -EINVAL;
+
+	memcpy(dst->settings, info->settings,
+	       flex_array_size(info, settings, info->decoder_count));
+	return 0;
+}
+
 void cxl_region_quiesce_lock(void)
 	__acquires(cxl_region_quiesce)
 	__context_unsafe(token maps to cxl_rwsem.region)
diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
index 0c4ac0832b34..5aa97705a669 100644
--- a/drivers/pci/cxl.c
+++ b/drivers/pci/cxl.c
@@ -389,6 +389,74 @@ static int pci_cxl_restore_state(struct pci_dev *pdev,
 	return cxl_restore_state(pdev, snapshot);
 }
 
+/**
+ * pci_cxl_reset_prepare() - allocate HDM state storage ahead of a bus reset
+ * @pdev: device about to be reset
+ *
+ * Copy the cached HDM state before the reset, so that restoring cannot fail
+ * for lack of memory. The decoder settings are refreshed when the state is
+ * restored.
+ *
+ * Return: storage for cxl_restore_state_after_pci_reset(), to be freed with
+ * kfree(); NULL when @pdev has no cached HDM state; or an ERR_PTR() on
+ * failure.
+ */
+struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev)
+{
+	struct cxl_hdm_info *snapshot;
+
+	device_lock_assert(&pdev->dev);
+	snapshot = cxl_hdm_cache_snapshot(&pdev->hdm);
+	if (IS_ERR(snapshot))
+		return PTR_ERR(snapshot) == -ENXIO ? NULL : snapshot;
+
+	/* Raw reset callers may not have saved the PCI state needed for restore. */
+	if (!pdev->state_saved) {
+		pci_err(pdev, "CXL bus reset requires saved PCI state\n");
+		kfree(snapshot);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return snapshot;
+}
+
+/**
+ * cxl_restore_state_after_pci_reset() - restore CXL state after a bus reset
+ * @pdev: device that was reset
+ * @snapshot: storage from pci_cxl_reset_prepare()
+ *
+ * Under the region quiesce, refresh the decoder settings in @snapshot from the
+ * cache and restore: first the PCI configuration needed to reach HDM MMIO,
+ * then the HDM decoder and CXL Device DVSEC state. Leave @pdev disabled on
+ * failure.
+ *
+ * Refresh the decoders now rather than rely on the copy taken before the
+ * reset: a region commit or teardown during the reset has updated the cache,
+ * and restoring older decoders would leave the device decoding ranges the
+ * CXL core considers free.
+ */
+int cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
+				      struct cxl_hdm_info *snapshot)
+{
+	u16 command;
+	int rc;
+
+	device_lock_assert(&pdev->dev);
+	cxl_region_quiesce_lock();
+
+	rc = cxl_hdm_cache_copy_decoders(&pdev->hdm, snapshot);
+	if (!rc) {
+		rc = pci_cxl_restore_state(pdev, snapshot, &command);
+	}
+	if (rc)
+		cxl_reset_save_disabled_state(pdev);
+	else
+		rc = cxl_reset_save_restored_state(pdev, command);
+
+	cxl_region_quiesce_unlock();
+	return rc;
+}
+
 /*
  * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
  * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f5990d6cc51b..22f740417673 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5014,6 +5014,7 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 
 static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 {
+	struct cxl_hdm_info *snapshot __free(kfree) = NULL;
 	struct pci_dev *bridge;
 	u16 dvsec, reg, val;
 	int rc;
@@ -5036,6 +5037,10 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 	if (rc)
 		return -ENOTTY;
 
+	snapshot = pci_cxl_reset_prepare(dev);
+	if (IS_ERR(snapshot))
+		return PTR_ERR(snapshot);
+
 	rc = pci_dev_reset_iommu_prepare(dev);
 	if (rc) {
 		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", rc);
@@ -5056,6 +5061,9 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
 				      reg);
 
+	if (!rc && snapshot)
+		rc = cxl_restore_state_after_pci_reset(dev, snapshot);
+
 	pci_dev_reset_iommu_done(dev);
 	return rc;
 }
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 743e65abd758..476e8eefafb2 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -730,10 +730,14 @@ static inline void pci_doe_destroy(struct pci_dev *pdev) { }
 static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
 #endif
 
+struct cxl_hdm_info;
 #ifdef CONFIG_CXL_RESET
 void pci_cxl_hdm_cache_init(struct pci_dev *pdev);
 void pci_cxl_hdm_cache_release(struct pci_dev *pdev);
 int cxl_reset_function(struct pci_dev *pdev, bool probe);
+struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev);
+int cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
+				      struct cxl_hdm_info *snapshot);
 #else
 static inline void pci_cxl_hdm_cache_init(struct pci_dev *pdev) { }
 static inline void pci_cxl_hdm_cache_release(struct pci_dev *pdev) { }
@@ -741,6 +745,18 @@ static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
 {
 	return -ENOTTY;
 }
+
+static inline struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev)
+{
+	return NULL;
+}
+
+static inline int
+cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
+				  struct cxl_hdm_info *snapshot)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_PCI_NPEM
diff --git a/include/cxl/hdm.h b/include/cxl/hdm.h
index 80d6ebb9f4aa..090eea2c0b46 100644
--- a/include/cxl/hdm.h
+++ b/include/cxl/hdm.h
@@ -66,6 +66,8 @@ void cxl_hdm_cache_publish(struct cxl_hdm_info **slot,
 void cxl_hdm_cache_release(struct cxl_hdm_info **slot);
 bool cxl_hdm_cache_dvsec_decode(struct cxl_hdm_info *const *slot);
 struct cxl_hdm_info *cxl_hdm_cache_snapshot(struct cxl_hdm_info *const *slot);
+int cxl_hdm_cache_copy_decoders(struct cxl_hdm_info *const *slot,
+				struct cxl_hdm_info *dst);
 
 /*
  * Region quiesce blocks CXL region commit and teardown, and with them decoder
-- 
2.43.0

