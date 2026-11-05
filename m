Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793905216;
	b=PUBPlXQO3z3L9PrZsT1TqsQsHDfAajCm72rC2Yb14W9dqzfFEFR5hsKci3ALNKgrNys1
	 ZeJcG/aD0yLxbK9I9ALSZbXZy9g0Fp3O5/yhPhD3HIGUSObp/ODIR/upk4XOBAFhN2WVK
	 mP11N1oWqwG4fpRoAlGj7R83cp3OwWb+RDdkzLgCWXezcKEMwSGh1IM8qxp1/gSjLeE00
	 0hg8OoOFBFoVnvIxpgISSZLUsHgRsytefhj6AhaRe01UVtK6sfIqVtNx68tUhFDiDVfdC
	 L3VwdtyYR436RaO9K1NDqh1N1lY2Yr+Tz+xGmpKeliQDb5gfzUFh1yzojp4eccXuwZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905216;
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
	bh=TyIl20EHtI+P5QoyK/yp5xBZO/ziWUXZRxXqzsoOAHI=;
	b=1YLJz8eqTV1CK/id44J6WpxxLxFktOobqSMKGAV8edtT8rcMPWrXBWQhN9+DVR64qyjm
	 4AgO0CknGm57EWjOKchO++bUq5RKIblZhd0kZ2oxLAHr7aQT2tU6jrXGd+MNMGjVb26Op
	 zlm2osuTFeOQXRQ8cJzWA4nKP/SU/CzM/uRJP3LPxZi3QkkrKi5Gv1AVzeuKYIc5Tz2RG
	 BkcYts7uYpX6X1URadOtUwB4F29GwcL+FmkiYGv37XQI4jVZiJuK567ESgSAt9ptIqz8l
	 IAjdPJcGXIatAmceNQfUw9ztzfF8sNnw9K0k5xyoKrd8UtS9wQ97aYAPNW/Nn4JAAXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="t/Xorv/g";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.56
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5FF6083630;
	Thu,  5 Nov 2026 19:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD5FF6083630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=t/Xorv/g
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZjXFYktpC+sQghhUnETwpA5PxtzoxydA8UxoZ2X3wJ1ndhXSCEe8S7HObQk0n6BoWclUAKIblUOxqTyQXLsaW5lf/Xiv2LfeACSw2AjzxeZZ6ptTNqS/99/SRSFvKuzsKLNmXaTd3yK4Z+FhhdjDstQ8wGisEb/Fquy4YPv1BrAwIkSUC+13ZIaWOXdEDObdI3ML9za9lNO6ElNv5BQlziM4ZPp6RtT1oxuHw7h9w8tEt0RxL9Qhj1RkYbm1JSX7WF1PCrgtNZVLuamKvYVDiiidZjU0jCYgLzNwNkDb9eWi2j6yUQlpIFBwVPoQZaBEJzRjzDgfoRHigpz/o3Weg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyIl20EHtI+P5QoyK/yp5xBZO/ziWUXZRxXqzsoOAHI=;
 b=b7D4UrKuMAz4wArDbQ9Iu4uiIu7WcjbP3nVTtyODSNrIEVxSE/9C0DTzRH9dEnBfCxkdTVOZcBPjdQn1eK3M+VZNyaOmUyzs2yPI2lw09DcENqqjHEN1JcbOT8srwM8b5bpHDsVD4yHG2yzV6ELosUkD0DByKGK6SkoZffZFXZmMQQhMjja4iU1ba4hpKrDZfJP+UPKrg7F37jwNBlZAIlDbFi6nPoQDDwhyO0AP2gIjuCebOCKp8Ynpkyr0zjdROM7DunoWj24HjJLWeEyzHa6Cj7ZTduGBa0SLjUF5B45wrp7HhlBrpzoBRs8MMYKbHD2tHn3aP3JZdtn2Mk2Uuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyIl20EHtI+P5QoyK/yp5xBZO/ziWUXZRxXqzsoOAHI=;
 b=t/Xorv/gX6WBr8RvVTG4Zox28mRD4nOYc23DJ56DXGWp3wwq4yz40sZ+/r1Gvgb8d3rfD8XaB99+NjZzjGu5ivzIVpxDiQAZB3L72tC88+WYQQDJiC6Xxxx14qlvAJp5fJZ0/a7R/JoVff2N0N17F6cHA/CQhjmLu54sMxtM0o5s8Jyh5u/qeqhWoPK5Q+qikq8c5kcjQ+dktW+OMuDIC6PNmnQ4u28/YFvi+tprcV0XGtEL6unsAqFzlNFzPBpzraX9Wt/w/fgyseIepF9DXmpkF3iSv6kNUhxylQdm7dF8ezE6EE7t+f1ub7EuAQ3K0PKjjf5rocIO21ni9YYkfA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by LV2PR12MB733495.namprd12.prod.outlook.com
 (2603:10b6:408:423::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 19:00:07 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 19:00:07 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <iweiny@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Ming <ming.li@zohomail.com>,
	Joshua Machauer <machaujo@amazon.de>,
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
Subject: [PATCH v17 18/19] PCI/CXL: Flush host and device caches for CXL bus reset
Date: Thu,  5 Nov 2026 18:59:16 +0000
Message-ID: <20261105185917.2667656-19-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105185917.2667656-1-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0198.namprd03.prod.outlook.com
 (2603:10b6:303:b8::23) To LY0PR12MB727857.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|LV2PR12MB733495:EE_
X-MS-Office365-Filtering-Correlation-Id: 1afd4922-4895-465c-8c77-08df3b6f026e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|921020|11063799006|5023799004|261026140227099003|56012099006|261021123027099003|261022105027099003|261021121427099003|261009223027099003|261022075727099003|261102123227099003|261026121527099003|261028144727099003|22082099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	VEpDBsjrInIv/R0iyFuIcD0BimZFYLAxp80x7IIn9F759knfyL01PFIGa2tYtdqx8Alq2rg9IkIgM/gKNKDw4PyzHU/pCrdos7jLypkY39IVEtoCqGJxX2CXd54O8uBXzKHa8v03NMMzeln4B2+5/Tot/iOwUmou1OD/GLzSWMwOsweuFgLImR0+RVvsBCH2+mbmChqjHZ4OTlhE+mUp68n4Lh/ihSJhvTVyQO58uSse5gnpN42/cbzV3C6b3eTa3uaaJwhe7jsbLpN+M6ThwDfnNCOwPoN+xwZ6gb1JojmA1WzemntTRz5/QjVb2twJXMyHQ/iF2+XfNl5KZOwop1XLN1z9pJui1ouOP/l2rhxVVt4Z9qSkxeZy3A1Y4hNOl+vhK7bVrTr9GRylFW0TfO4+tNeMIWO2105cZRlFYO/zGtDvo4Hq8qRdomt3m6ruDLNLDj2IIj4OcZRpTNarUrZEHfgv4Ov92AYbkE0tjpitOFsG3UPBMzppDgxx1JYIwSs43P9TfAuC10tmDPj4bWlb0ipOGC0EqwtZURA4viWLo1U4YYzWqkrhmIAMPLe+1h76nNNmg0a2AQhsVimAzHJuvCiXoMCfvQwuyoVMaDZvGbHrcDxbDysI+tuYFoEdxW6Gt0h6MA98K5AKTbk0aWh+DSOwFQzxr8lYjmfNgcnWCcUoB1H9aQ1s0rUQc/CglYLdCXcp0dWAserD2o6jHg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(921020)(11063799006)(5023799004)(261026140227099003)(56012099006)(261021123027099003)(261022105027099003)(261021121427099003)(261009223027099003)(261022075727099003)(261102123227099003)(261026121527099003)(261028144727099003)(22082099003)(18002099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jdkPsMQkb5GFZIjqk4aYm2EZvgHFm4wUMYBFmtrldKTn+8Xj9/PhW9EQCASu?=
 =?us-ascii?Q?GHdV9cd33d1HSAbKe2Gr4wmclh/g57O+b8yERTdsAs0swgXzJeFEnfkXp59A?=
 =?us-ascii?Q?2pQFoJ0KBhX28AzjPF47NJvmaRkFqIcpnPuE0ys3Zozl/ZA8F5fKKQrQQy0S?=
 =?us-ascii?Q?Eyl27MrNkgsRmlUsq41Q6h+gc/i4u4cdg5v1ksdkIwZK+Bi2mhZTX+nfgRuD?=
 =?us-ascii?Q?GVNMgmFAysfG+tzfmjdnZMNjxQ5ox4hwvKCFsmtMTHfE5dTXrYPY/GAJYpkC?=
 =?us-ascii?Q?7UF9Mt225PAh5ENFps7IuMf+CtAV9+DthehW2URdfUqMCSixq/CDO30xMjvi?=
 =?us-ascii?Q?ejmU6dbRW8BVkROSIv3GN2pTBoVPQg47qSzFq51pPnZnluaHgk+3ttieFPxq?=
 =?us-ascii?Q?PsdtKtnjcpz9yeP6WJMzCF1w3c0u2z8oJX1U6fZNXx8qBitsDi4v2WtUYh4a?=
 =?us-ascii?Q?WBBFPZbSg4InEzyIagd79OZk9fbO0NHg01JqTcWbD3TxdjnPeZL9kzTtfm6y?=
 =?us-ascii?Q?Of/CW1QXcdBO+KaR235sP77bQJ6LXaqSgjtRXjz/RdR11YEAoxJvhnOzlxDI?=
 =?us-ascii?Q?IxucHh0Nr+fBug/kEwWwqdQWwBj9xbiQwJx6sM7BmQaMsxQk9b9MfTZvJUiR?=
 =?us-ascii?Q?0yndnxHZppVkQCp/H59SeR3gcXNQcRTbnzAfokghDkOp1are2R2Qbwiq8jxg?=
 =?us-ascii?Q?UnwX7IiPEGhqFSoYlnYEbN6AD7O9l1Bc2JNsto7P1KC8y587mQ8zv4GfVQB5?=
 =?us-ascii?Q?mUaNWwJB4lrSaTDJ08CKzuswVKlGf1DVEr9v2Vsw0e7cw8sDQGta2ZamENdG?=
 =?us-ascii?Q?tl1noPI7wZ0lkIyd7PcTIRqdM1Fu6dZD5bkomQFMzfOFGe1tTuvYaJGjIjYc?=
 =?us-ascii?Q?Wc0Nx5Suxk9G6v9vFU5vQimSg89Vqz5/sjXsR1jEua7UlRIObs12FEIqUbLG?=
 =?us-ascii?Q?QBRiz4SeRjOBR4/sMTJqWhCz1wuC+aBf3sxeFhWDFPxCs6VwcLbKWEJCbyf1?=
 =?us-ascii?Q?vfEWnyP6wiRJ18F7Q7pV5LCvmtr0yUdEGQWT4FBmEafTHvWJXJKKz6N8GTiE?=
 =?us-ascii?Q?EV/4Olt+NZmrF6JkrRAAjmP1zuUEoZTsIjaxfw3nTtor4bt5GeQEFOokn36j?=
 =?us-ascii?Q?3GppCe5LjypTV0xN5CvvzRDKt2D8vXilZT468zLfyXzMMwlg0aBgXoapuXq7?=
 =?us-ascii?Q?BY1E8TBVjo70CZ3m9a0gaCBnsXUL4rhYhiCG71TlcgvoDWluB88zNzPm3KcU?=
 =?us-ascii?Q?WzmBVVLiBLsNOLXaFUepcwnrO0NSPx1YrjlsF2x5FCGNP1kIInn7hN+nF5B0?=
 =?us-ascii?Q?dSLi0zDBLW3lHWAF5qfKyoBuweDWP4u2tbAh4QlRgG1gMjyy2PuuI2AouZrg?=
 =?us-ascii?Q?mCFLbt5qk278AIsRAEvjRNBe51jgudN2qT0FyWu7p9CMpZ88XtbmhFiHDfOL?=
 =?us-ascii?Q?ByMHCtcy8ZrEQGITKE7HxvCdkAwSiFdBxlO1L/ojwwH1zzPdUSCKJ3MnLgop?=
 =?us-ascii?Q?G8z6kyH19Xtba1YijmPMDkp584LzlY7PfW8LT+PcsGFe3wPSzrenVqRCdVKG?=
 =?us-ascii?Q?2icH/rPuRUJpVIGt9oPoQIGlN5GJC3++MvcNw/o65nU/Bd4/k4UL6s26G7ZN?=
 =?us-ascii?Q?/7L+DNJYBYrvnL/foPIDUaezUTGCoJpzq0k8DJsGTrdM0Iys9jZMqOfpewuK?=
 =?us-ascii?Q?+bDK/ptqkVL2QwlowOhg5txyEiPnEsO45w6akbOXJ/9qPauSbSVXLEouTbgE?=
 =?us-ascii?Q?rxTHwuuR8w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1afd4922-4895-465c-8c77-08df3b6f026e
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 19:00:07.8881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5bB8I7XjHqqQAn9WP8ZqOl2WYSZMWe8XAYZ8RmowL8weCVBeVjOpPImz7wHxV8Z14zqsbEvwFC+M5kU5k7Nrzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB733495

CXL bus reset can reset a Type 2 device while its host and device caches
still contain data for the device's HDM ranges. Flush the host caches,
disable device caching, and trigger device cache writeback and
invalidation when supported before reset. Invalidate the host caches
again before ending IOMMU exclusion.

Hold the CXL region quiesce from snapshot through restoration so region
commit and teardown cannot change the decoder state while the reset is
in progress. Reserve the affected HPA ranges and preserve the device's
cache policy across the operation.

If reset was not attempted, undo preparation without changing the saved
PCI command unless cleanup fails. After an attempted reset, keep the
device disabled on recovery failure and do not re-enable caching against
unrestored HDM state. Enable bus mastering only after the IOMMU is
restored, so that no DMA request reaches the blocking domain.

If no cached HDM state exists, retain the existing CXL bus reset path.
For a device with cached state, reject the reset if its cache-maintenance
state cannot be safely prepared or restored. An invalidation provider is
required unless the existing test-only CXL_REGION_INVALIDATION_TEST bypass
is enabled.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

---
Changes in v17:
- New in this series: folded into the CXL reset series instead of being
  posted separately (Dave)
---
 drivers/pci/cxl.c | 166 +++++++++++++++++++++++++++++++++++++---------
 drivers/pci/pci.c |  11 +--
 drivers/pci/pci.h |  19 ++++--
 3 files changed, 154 insertions(+), 42 deletions(-)

diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
index a9aa2e1c631d..c5cdad4b0590 100644
--- a/drivers/pci/cxl.c
+++ b/drivers/pci/cxl.c
@@ -393,74 +393,174 @@ static int pci_cxl_restore_state(struct pci_dev *pdev,
 	return cxl_restore_state(pdev, snapshot);
 }
 
+static int cxl_reset_restore_cache_policy(struct pci_dev *pdev, int dvsec,
+					  u16 saved_ctrl2);
+static int cxl_reset_cache_prepare(struct pci_dev *pdev, int dvsec, u16 cap,
+				   const struct cxl_hdm_info *snapshot,
+				   struct cxl_pci_cache *cache);
+
 /**
- * pci_cxl_reset_prepare() - allocate HDM state storage ahead of a bus reset
+ * pci_cxl_reset_prepare() - prepare HDM state and caches before a bus reset
  * @pdev: device about to be reset
+ * @cachep: receives cache state owning the region quiesce on success
  *
- * Copy the cached HDM state before the reset, so that restoring cannot fail
- * for lack of memory. The decoder settings are refreshed when the state is
- * restored.
+ * Capture HDM state under the region quiesce, reserve its ranges, and complete
+ * host and device cache maintenance. Hold the quiesce through reset and
+ * cxl_restore_state_after_pci_reset(), which consumes *@cachep.
  *
- * Return: storage for cxl_restore_state_after_pci_reset(), to be freed with
- * kfree(); NULL when @pdev has no cached HDM state; or an ERR_PTR() on
- * failure.
+ * Return: snapshot to be freed with kfree(), NULL when no cached HDM state is
+ * present, or an ERR_PTR() on failure. A cached device without a valid DVSEC
+ * snapshot is rejected because its cache-maintenance scope is unknown.
+ * Only a successful non-NULL snapshot returns with the region quiesce held
+ * and *@cachep set. The caller must pass both to
+ * cxl_restore_state_after_pci_reset() even if reset is never attempted.
+ * The snapshot remains caller-owned. All other returns leave the quiesce
+ * unheld and *@cachep NULL.
  */
-struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev)
+struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev,
+					struct cxl_pci_cache **cachep)
 {
 	struct cxl_hdm_info *snapshot;
+	struct cxl_pci_cache *cache;
+	u16 dvsec, cap, command;
+	int rc;
 
 	device_lock_assert(&pdev->dev);
-	snapshot = cxl_hdm_cache_snapshot(&pdev->hdm);
-	if (IS_ERR(snapshot))
-		return PTR_ERR(snapshot) == -ENXIO ? NULL : snapshot;
+	*cachep = NULL;
+	if (!pdev->hdm)
+		return NULL;
 
+	rc = cxl_pci_device_dvsec(pdev, &dvsec, &cap);
+	if (rc == -ENOTTY)
+		return ERR_PTR(-ENODEV);
+	if (rc)
+		return ERR_PTR(rc);
 	/* Raw reset callers may not have saved the PCI state needed for restore. */
 	if (!pdev->state_saved) {
 		pci_err(pdev, "CXL bus reset requires saved PCI state\n");
-		kfree(snapshot);
 		return ERR_PTR(-EINVAL);
 	}
 
+	cache = kzalloc_obj(*cache);
+	if (!cache)
+		return ERR_PTR(-ENOMEM);
+	cxl_region_quiesce_lock();
+	snapshot = cxl_hdm_cache_snapshot(&pdev->hdm);
+	if (IS_ERR(snapshot)) {
+		rc = PTR_ERR(snapshot);
+		goto unlock;
+	}
+	if (!snapshot->dvsec_ctrl_valid) {
+		rc = -ENXIO;
+		goto free_snapshot;
+	}
+	if (cxl_hdm_cache_dvsec_decode(&pdev->hdm) ||
+	    (snapshot->dvsec_ctrl & PCI_DVSEC_CXL_CACHE_ENABLE &&
+	     !(cap & PCI_DVSEC_CXL_CACHE_WBI_CAPABLE))) {
+		rc = -EOPNOTSUPP;
+		goto free_snapshot;
+	}
+
+	if (cap & PCI_DVSEC_CXL_CACHE_CAPABLE) {
+		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2,
+					  &cache->saved_ctrl2);
+		if (rc || PCI_POSSIBLE_ERROR(cache->saved_ctrl2)) {
+			rc = rc ? pcibios_err_to_errno(rc) : -ENODEV;
+			goto free_snapshot;
+		}
+	}
+
+	rc = cxl_reset_cache_prepare(pdev, dvsec, cap, snapshot, cache);
+	if (rc) {
+		if (cache->cache_disabled)
+			goto finish;
+		pci_err(pdev, "failed to prepare CXL bus reset ranges: %d\n", rc);
+		cxl_hdm_quiesce_destroy(&cache->quiesce);
+		goto free_snapshot;
+	}
+	if (!pci_wait_for_pending_transaction(pdev)) {
+		rc = -ETIMEDOUT;
+		goto finish;
+	}
+	*cachep = cache;
 	return snapshot;
+
+finish:
+	rc = cxl_restore_state_after_pci_reset(pdev, snapshot, cache, false, rc,
+					       &command);
+	kfree(snapshot);
+	return ERR_PTR(rc);
+free_snapshot:
+	kfree(snapshot);
+unlock:
+	cxl_region_quiesce_unlock();
+	kfree(cache);
+	return ERR_PTR(rc);
 }
 
 /**
- * cxl_restore_state_after_pci_reset() - restore CXL state after a bus reset
+ * cxl_restore_state_after_pci_reset() - finish a prepared reset and release its quiesce
  * @pdev: device that was reset
  * @snapshot: storage from pci_cxl_reset_prepare()
+ * @cache: quiesce state from pci_cxl_reset_prepare()
+ * @reset_attempted: reset helper was invoked and may have affected hardware
+ * @rc: preparation or PCI reset result
  * @command: returns the saved PCI_COMMAND value to apply once the IOMMU is
  *	     restored
  *
- * Under the region quiesce, refresh the decoder settings in @snapshot from the
- * cache and restore: first the PCI configuration needed to reach HDM MMIO,
- * then the HDM decoder and CXL Device DVSEC state. Leave @pdev disabled on
- * failure.
+ * Restore state through pci_cxl_restore_state(), complete host invalidation,
+ * and restore the cache policy changed by planned-reset preparation. When
+ * @reset_attempted is false, undo preparation without changing the saved PCI
+ * command, unless cleanup itself fails. After an attempted reset, keep caching
+ * and the device disabled if state restoration or host invalidation fails.
+ * A reset-helper error does not prove that hardware was untouched.
+ * Unplanned recovery uses pci_cxl_restore_state() directly and owns its own
+ * quiesce and cache-maintenance sequencing.
  *
  * Bus mastering stays off, because the caller has not yet restored IOMMU
  * translation and a DMA request now would hit the blocking domain. The caller
  * calls cxl_restore_command_after_pci_reset() once the IOMMU is restored.
  *
- * Refresh the decoders now rather than rely on the copy taken before the
- * reset: a region commit or teardown during the reset has updated the cache,
- * and restoring older decoders would leave the device decoding ranges the
- * CXL core considers free.
+ * The quiesce blocks region commit and teardown throughout reset. Complete
+ * host cache invalidation before PCI operation resumes, then release the
+ * quiesce and free @cache on every exit. @snapshot remains caller-owned.
  */
 int cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
-				      struct cxl_hdm_info *snapshot,
-				      u16 *command)
+				      const struct cxl_hdm_info *snapshot,
+				      struct cxl_pci_cache *cache,
+				      bool reset_attempted, int rc, u16 *command)
 {
-	int rc;
+	int rc2, policy_rc = 0;
 
+	*command = 0;
+	if (!cache)
+		return rc;
 	device_lock_assert(&pdev->dev);
-	cxl_region_quiesce_lock();
-
-	rc = cxl_hdm_cache_copy_decoders(&pdev->hdm, snapshot);
-	if (!rc)
+	if (reset_attempted && !rc)
 		rc = pci_cxl_restore_state(pdev, snapshot, command);
-	if (rc)
-		cxl_reset_save_disabled_state(pdev);
 
+	/* Complete host invalidation before ending IOMMU exclusion. */
+	rc2 = cxl_hdm_quiesce_flush(&cache->quiesce);
+	if (rc2)
+		pci_err(pdev, "failed to invalidate CPU cache after CXL bus reset: %d\n", rc2);
+	/* Undo preparation on abort; enable caching after reset only if safe. */
+	if (cache->cache_disabled && (!reset_attempted || (!rc && !rc2)))
+		policy_rc = cxl_reset_restore_cache_policy(pdev, snapshot->dvsec,
+							  cache->saved_ctrl2);
+	if (reset_attempted) {
+		rc = rc ?: rc2 ?: policy_rc;
+		if (rc)
+			cxl_reset_save_disabled_state(pdev);
+	} else {
+		/* An aborted reset alone must not poison the saved PCI command. */
+		if (rc2 || policy_rc)
+			cxl_reset_save_disabled_state(pdev);
+		rc = rc ?: rc2 ?: policy_rc;
+	}
+
+	cxl_hdm_quiesce_destroy(&cache->quiesce);
 	cxl_region_quiesce_unlock();
+	kfree(cache);
 	return rc;
 }
 
@@ -594,7 +694,7 @@ static int cxl_reset_cache_prepare(struct pci_dev *pdev, int dvsec, u16 cap,
 	int rc;
 
 	rc = cxl_hdm_quiesce_prepare(&cache->quiesce, snapshot);
-	if (rc)
+	if (rc || !(cap & PCI_DVSEC_CXL_CACHE_CAPABLE))
 		return rc;
 
 	/* Track an attempted change so partial failures still restore policy. */
@@ -731,7 +831,9 @@ static int cxl_reset_quiesced(struct pci_dev *pdev, int dvsec, u16 cap)
 		rc = __cxl_reset_execute(pdev, dvsec, cap, snapshot, &cache.quiesce,
 					 &command);
 	/* Restore cache policy after any attempt to disable caching. */
-	rc2 = cxl_reset_restore_cache_policy(pdev, dvsec, cache.saved_ctrl2);
+	rc2 = 0;
+	if (cache.cache_disabled)
+		rc2 = cxl_reset_restore_cache_policy(pdev, dvsec, cache.saved_ctrl2);
 	cxl_hdm_quiesce_destroy(&cache.quiesce);
 	if (rc)
 		return rc;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1d4ba90a6976..b29a6a43249d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5015,6 +5015,7 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 {
 	struct cxl_hdm_info *snapshot __free(kfree) = NULL;
+	struct cxl_pci_cache *cache;
 	struct pci_dev *bridge;
 	u16 dvsec, reg, val;
 	u16 command;
@@ -5042,14 +5043,15 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 	if (rc)
 		return -ENOTTY;
 
-	snapshot = pci_cxl_reset_prepare(dev);
+	snapshot = pci_cxl_reset_prepare(dev, &cache);
 	if (IS_ERR(snapshot))
 		return PTR_ERR(snapshot);
 
 	rc = pci_dev_reset_iommu_prepare(dev);
 	if (rc) {
 		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", rc);
-		return rc;
+		return cxl_restore_state_after_pci_reset(dev, snapshot, cache,
+							 false, rc, &command);
 	}
 
 	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR) {
@@ -5066,8 +5068,9 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
 				      reg);
 
-	if (!rc && snapshot)
-		rc = cxl_restore_state_after_pci_reset(dev, snapshot, &command);
+	/* Reset-helper failure does not prove that no hardware reset occurred. */
+	rc = cxl_restore_state_after_pci_reset(dev, snapshot, cache, true, rc,
+					       &command);
 
 	pci_dev_reset_iommu_done(dev);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2f819e1fbead..7f6b81cf734b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -731,14 +731,17 @@ static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
 #endif
 
 struct cxl_hdm_info;
+struct cxl_pci_cache;
 #ifdef CONFIG_CXL_RESET
 void pci_cxl_hdm_cache_init(struct pci_dev *pdev);
 void pci_cxl_hdm_cache_release(struct pci_dev *pdev);
 int cxl_reset_function(struct pci_dev *pdev, bool probe);
-struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev);
+struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev,
+					struct cxl_pci_cache **cachep);
 int cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
-				      struct cxl_hdm_info *snapshot,
-				      u16 *command);
+				      const struct cxl_hdm_info *snapshot,
+				      struct cxl_pci_cache *cache,
+				      bool reset_attempted, int rc, u16 *command);
 int cxl_restore_command_after_pci_reset(struct pci_dev *pdev, u16 command);
 #else
 static inline void pci_cxl_hdm_cache_init(struct pci_dev *pdev) { }
@@ -748,16 +751,20 @@ static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
 	return -ENOTTY;
 }
 
-static inline struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev)
+static inline struct cxl_hdm_info *
+pci_cxl_reset_prepare(struct pci_dev *pdev, struct cxl_pci_cache **cachep)
 {
+	*cachep = NULL;
 	return NULL;
 }
 
 static inline int
 cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
-				  struct cxl_hdm_info *snapshot, u16 *command)
+				  const struct cxl_hdm_info *snapshot,
+				  struct cxl_pci_cache *cache,
+				  bool reset_attempted, int rc, u16 *command)
 {
-	return 0;
+	return rc;
 }
 
 static inline int cxl_restore_command_after_pci_reset(struct pci_dev *pdev,
-- 
2.43.0

