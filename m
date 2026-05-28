Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013029.outbound.protection.outlook.com [40.107.201.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6DF358D3D;
	Thu, 28 May 2026 11:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779966956; cv=fail; b=JYEIuD/DaDqxehhYyS9G0djpfRc7AtljIpNx5eMyF++PB2esfWrABHmX5wcCGxDQ6pYA/H0KMArHxkWEhh0TGM/aTkd2gQ9eVefAdgW7kXoOQaqZlDFHmchqrstGhfRj/LzaoycaHA9LtXKbum+iYWw0yhWw7Kb06xcTzOlagY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779966956; c=relaxed/simple;
	bh=qCk6cRNn0ex8GBY/LsBVAkuXJjDV5ziH9kXSivAzdeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PxSoMm8JDuZEsQH7b/PiCW/PmkGZlNnUBSunk7K+uwRGvfPOg74vHaSnTOLcLIB7Rj79WQQJIlQNraFCZOeZuG1PXl3OkeNV2KxtHITYJ57SVzIp2p2gOACgGaGb4gVaMGYiX1QvY1xDYn7dKOW3nY+IqxjDxK5FGVcMvj6wRJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=di5ZZJW/; arc=fail smtp.client-ip=40.107.201.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="di5ZZJW/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNo/coFmjX4MtFZjeQbKC1O0wAHi0VExwIS0FJWDMNs3TPw33tZbjBitplxBJHTmUhNdIYeV32786U5G/xD3qnqw41/UCvrNgQMlDLIu70pMFLQpsQS+3P0zEgH2kGce95AW2rCC6G6y7UcsbshHpfhzOrhFkcDDPYIAdL8lhFfs2NJYztFXoGza6AeaJfBqVuQeB69hhgeQRsuV1ifl495Dk3ezeaI8XhWF3fmQoQ53+E6p9mLYORThhDfKCOY7ZA8p+vTDxkiVzxLtNxhZBa3/Bygh+e3R5629Bb8mjfBC7xvDfpc0IiZvpe89BG4f1OD4lFtyMSN3vR6HuNMA+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhysSvf4OLLEjXloqyL4R2omHXkK2gSuY5LV/2f4+Hs=;
 b=xU5Wt5nVSUt230QCvHHTNsKMTRymVe78lrWyDf9vZyWQmP51x1GKUJcE35xsTWiCe+enXFFHIR+pGVunqVrBKVMQYeXTo8vBdgLXvnWGTVz5R+2GonL4XK+EWWgFAMgfmKnWFhmx8nPyER8ztLDNm/z7TFisQvF9bREWcEM0tgshLxoZW3d+SUSRSpbTOWKRurRKYrcNjs/Vn09h6IaFtzwb97gZvDdl+sHnMRgYcrteBIRt0AS787ImVFy8VP675/MgSnTsAT1dz4W5yY80aV8O+R6++CQjI5aw2lDrvG+GNKxDgBZU/I0YWL9Jn0h5RlSwWsVykEJcrDS4pEjbkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhysSvf4OLLEjXloqyL4R2omHXkK2gSuY5LV/2f4+Hs=;
 b=di5ZZJW/0TCiobl8Fen8/6Ne18FSnwamC+5dv0f8jp2LctbM4hfw76PDRttsjwOgDyK8T8pV9biUPa7Clr1Remq7qMUktJtw9w9p8eZ88XbhKLnIeyJPK0WTnJ1s3ZwXTEBFaVfj3ht+6ZnyUzllr7aRXDtVen3Wx8r4CuvV/1oqkN7jgybxPg979bpe8P2oFeVobT+Sm8o+uyFo7AqQyapWK2twYdRGPODyvIvyj970+vZMth3iJ7sL81tr9YfRAHo4O3xO/yEZfktYDLe77Ar+CGcmrunOTWboCku9As8uuN8So7/ETWECWgrjy13jjEaLDlTZhb9TSyo1Fx6bZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 28 May
 2026 11:15:51 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 11:15:51 +0000
Date: Thu, 28 May 2026 19:15:44 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, vsethi@nvidia.com, alwilliamson@nvidia.com, 
	Dan Williams <danwilliams@nvidia.com>, Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, 
	Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, 
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v6 4/9] PCI/CXL: Add sibling function coordination for
 reset
Message-ID: <ahgiY245F30Oc51e@MWDK4CY14F>
References: <20260528083154.137979-1-smadhavan@nvidia.com>
 <20260528083154.137979-5-smadhavan@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528083154.137979-5-smadhavan@nvidia.com>
X-ClientProxiedBy: KU1PR03CA0035.apcprd03.prod.outlook.com
 (2603:1096:802:19::23) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH2PR12MB4199:EE_
X-MS-Office365-Filtering-Correlation-Id: 01c534fa-c275-4a72-861b-08debcaa7a04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|6133799003|5023799004|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Xcj2QQfGeU3iwji/JRGeV0ZGKEq3bu8ZQBeahcVtSR23jqRTpGKFYPLk8pcA+ge5J0AZO4kTD0kMh8WHqKDsvBdVRsuB6p5GctkNugB8TL11csyxty2GMGbJDIKtDyxwTFQASunxElCTysCiRQ/7KB2Ld5MDOt1VJ7WGZW+MmhK9YQZtLs2grVcjeS2AywQ3iNSoIyJ7u6r4Ke4YuiV8eDIyK3hPyCClxsEcnY2PH8x5/8mfBUcGl3rUrwihP6PT5u6pfETMjamHzvdAP6rnDJhbchsTEg5roD+GeJHG9vSp+zGKiIRyYBJtE9AS/EaUtO8TTKhfsod+PPCwb42Wk+7+k+9aKJGo8xB9Z3GBWn5cUiRSMinl8Br8kVzVeYWbbstby+V0EAuveL/ngWKqo6Ix5bUjMY3UL93edhFpMDwuUeIqkz3GboDpOM56XIM7d+GySYzoEO7NihDHneHJqYs9uWZ0VWuNjMJV0Xe03B2wA5x5/Cis/l2ZdP63y1t733rq2Q8DXJtHrLW10lo/l5tdm5O/+TTWiHRgVT6805M/KkTJG9cTqfSPRIGFIBIGtvoBXc87uRA2nxZivpxvMM/jlQUO2t0YXK7Lpf6T15Jq6AAVDA1mOEaKU1goAKZ0DzJX4AaOLhoMtzW7scxcfFuSnDGarOWZIpSdw7vE8RqRrWYaTSoQKdT8RhwYtSQm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(6133799003)(5023799004)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wbnnUsi3+jt7L1X9/zRtgcb57BB9Ke8HFjmfy8/0jBpyIA/K62/qL8L7BbXP?=
 =?us-ascii?Q?EYA1AHbCVWrF0x6fe+L6K9lPIFsWQAAjO2o5vYLkdMKdUh9WlmUefcSAlavy?=
 =?us-ascii?Q?lyfQs/HhcAFP9WklGjUP4V8OJBEJAcAJeuV8EcNtdo87buaMU9iDWQIo/aXb?=
 =?us-ascii?Q?lqIy/B1OLaP7H8p7s4Fulnp3GFWCD3VuKy3XfvamAIF3JIzjnIyIPnS+nu6J?=
 =?us-ascii?Q?V5p4RHdPGrJI6g+vSmMCbEbwKMsWlrn8YD08Sm5/opIvEcBrjoeqvvBV4QoI?=
 =?us-ascii?Q?vyQ549sXyPA/aGzrZ1uLoscuidOkwxg2/TIAnIWJZbuHFSGtngFYJM6D1tp9?=
 =?us-ascii?Q?xpkBC64E69zzXc3CsYqLrmrqO/mzfc3vR7GmfZpCRpweFaKBYaqRAnBWFgXX?=
 =?us-ascii?Q?XcQP0+70yxxNVabU+CVk8uTF0j1q6+a18/FLVkX+rHtRiIpo6fiVQ8bZCnsN?=
 =?us-ascii?Q?i3hQ6gcrxDV68yUZpgB4sFS93/zhEFN7GDb3fpkQkmNw8hOM+hpYhNf8TZtm?=
 =?us-ascii?Q?U3GCwfyeFhFIxWrMMJLfLKe/nt4d7AI1h0Kw2bDv6vPGfAdqPv6R7KlcU11+?=
 =?us-ascii?Q?lgLIU9li+DEBD+78nwXe4X87/07Q44h2+slrQrjr4U/zLD0+2Kmqjk8H/P/D?=
 =?us-ascii?Q?x5AyNA/0enWySS5xaDAH40hG4dAlQsspV4cQTFpcLahfeqmhPanZ0RijomeW?=
 =?us-ascii?Q?sINWgDqG4LpulvyFsAyGq5vu0u+lxtlOnZ0YHTb9df1b2mRZr0G8dWOZJyYI?=
 =?us-ascii?Q?d1gvq2eR2y2mflH0hqOQ0f4vkuIqhVqhg+5ghvTWIT45shDnWEVcDBpyV+b1?=
 =?us-ascii?Q?v+qqP/aQn5CdUwd9+krQmeCyjiwVep/AC7FcGv0AhYPstgIup8TFzXAjZqCK?=
 =?us-ascii?Q?seqe0gFZwhbihXH1LPxziE80YcwgcsXNh3hFYHTMLLP6oh9XqcRF7THh5Ne7?=
 =?us-ascii?Q?ea4eUHzHvzm07mpLu/SrkfZNy/ttf1nfipST+DGiqmRywQIbeRUBzdSNhEH4?=
 =?us-ascii?Q?j+732SRVDn7CB+KH9QYhaXjdPDFvr9PwkGOqs7WHS/DgCi389fcPpR6ishQx?=
 =?us-ascii?Q?o7oK1iHq33B9IEGrMsFi9v/YqA4fzN2juoQjzYA1DQ8y+ZDaFTpzTYN6Xgnv?=
 =?us-ascii?Q?N/YQqpY5/8Gb/35vZvk0aKgAQ1Zw3AG4Fkb7+nsRHGRm+moRkfKOJTRhOQrS?=
 =?us-ascii?Q?m2AItfFeoGITEG7k7XtKKYhwpz9AsgEq42zbVGFT7ldetBtIt8pW/sy8qwdq?=
 =?us-ascii?Q?+XEtoQmvskOtqPY7ciYUAl/ddLSIBYaJDyvfSEfZKHbqcpjNYeDNh20zYJMC?=
 =?us-ascii?Q?HTzQ8hdWx28EMd+fGpXOJfP8DFcwTRrUa0Ka3dzkpW3QsOhhKwkdR79vyCdg?=
 =?us-ascii?Q?wSEpws7nisP/+JD+B8YeT71FL2Lm4pwGmrhRD2IGx2oDog9N8yRa8w5u/Wmd?=
 =?us-ascii?Q?4pkMwUFBeXhQOmnPvKFVnYnjJ/RrGWJwkBn9Bh1u6XtMPZLfklLyizRu/tws?=
 =?us-ascii?Q?a36jx1eHZqO172EkjK9ffBEkyTtHVQ1xuF+mkHLVEQsul/+JPtbPip4OhOJD?=
 =?us-ascii?Q?7nNNdA0CngWTb/R5+qD7yEKHqRSyEiUB9JZ9NiA2EPAA77WqDh6zQCqxZxQW?=
 =?us-ascii?Q?tLwdOoT8bQFNDC67Akat7oWtL5/CIfioNmppxazDCnqOaa6LmP02wk0IqnQe?=
 =?us-ascii?Q?t4C0QZllP8vbg1nS5ivQSb5EEuIekIcQ7VYhwrrRRoTlkO5wgs9fhkO3yIPG?=
 =?us-ascii?Q?SVGD2fK7wA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c534fa-c275-4a72-861b-08debcaa7a04
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 11:15:51.4020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K1pXHxDhfRa4TOLou/itOYchAGqr3qPsUHfzww46J6Tc7Npl3jdPtM01EsT62JZkdt82ZzbpbeM5t0jJ3IV+3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4199

On Thu, May 28, 2026 at 08:31:49AM +0800, Srirangan Madhavan wrote:
> Add helpers to collect CXL sibling PCI functions affected by a CXL reset
> and prepare them for reset by saving and disabling them. Restore those
> siblings and drop their references when reset coordination completes.
> 
> Use the Non-CXL Function Map DVSEC to exclude non-CXL functions, and
> filter remaining siblings to functions that advertise CXL.cache or
> CXL.mem capability.
> 
> Use pci_dev_trylock() for sibling locking and unwind on contention or
> allocation failure, so competing reset paths fail with an errno.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/pci.c        | 207 ++++++++++++++++++++++++++++++++++
>  include/uapi/linux/pci_regs.h |   2 +
>  2 files changed, 209 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 318744695f62..01effbb4e7cd 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1,9 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
>  #include <linux/units.h>
> +#include <linux/bitmap.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
> +#include <linux/iommu.h>
>  #include <linux/memregion.h>
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
> @@ -15,6 +17,10 @@
>  #include "core.h"
>  #include "trace.h"
>  
> +#define CXL_RESET_MAX_FUNCTIONS		256
> +#define CXL_RESET_FUNCTION_MAP_REGS	(CXL_RESET_MAX_FUNCTIONS / 32)
> +#define CXL_RESET_SIBLINGS_INIT		8
> +
>  /**
>   * DOC: cxl core pci
>   *
> @@ -1096,3 +1102,204 @@ cxl_reset_flush_cpu_caches(struct cxl_reset_region_context *ctx)
>  
>  	return 0;
>  }
> +
> +struct cxl_reset_context {
> +	struct pci_dev *target;
> +	struct pci_dev **siblings;
> +	int nr_siblings;
> +	int sibling_capacity;
> +	int nr_siblings_prepared;
> +};
> +
> +struct cxl_reset_walk_ctx {
> +	struct cxl_reset_context *ctx;
> +	unsigned long *non_cxl_func_map;
> +	int rc;
> +};
> +
> +static void
> +cxl_reset_read_non_cxl_func_map(struct pci_dev *pdev,
> +				unsigned long *non_cxl_func_map)
> +{
> +	u32 map[CXL_RESET_FUNCTION_MAP_REGS] = {};
> +	u16 dvsec;
> +	int rc, i;
> +
> +	bitmap_zero(non_cxl_func_map, CXL_RESET_MAX_FUNCTIONS);
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_FUNCTION_MAP);
> +	if (!dvsec)
> +		return;
> +
> +	for (i = 0; i < CXL_RESET_FUNCTION_MAP_REGS; i++) {
> +		rc = pci_read_config_dword(pdev,
> +					   dvsec + PCI_DVSEC_CXL_FUNCTION_MAP_REG +
> +					   i * sizeof(map[i]), &map[i]);
> +		if (rc) {
> +			pci_warn(pdev,
> +				 "failed to read CXL Function Map; treating all siblings as CXL: %d\n",
> +				 rc);
> +			bitmap_zero(non_cxl_func_map, CXL_RESET_MAX_FUNCTIONS);
> +			return;
> +		}
> +	}
> +
> +	bitmap_from_arr32(non_cxl_func_map, map, CXL_RESET_MAX_FUNCTIONS);
> +}
> +
> +static bool cxl_reset_is_cxl_sibling(struct pci_dev *pdev,
> +				     struct pci_dev *sibling,
> +				     unsigned long *non_cxl_func_map)
> +{
> +	if (sibling == pdev || sibling->bus != pdev->bus)
> +		return false;
> +
> +	if (pci_ari_enabled(pdev->bus))
> +		return !test_bit(sibling->devfn, non_cxl_func_map);
> +
> +	if (PCI_SLOT(sibling->devfn) != PCI_SLOT(pdev->devfn))
> +		return false;
> +
> +	return !test_bit(PCI_FUNC(sibling->devfn) * 32 +
> +			 PCI_SLOT(sibling->devfn), non_cxl_func_map);
> +}
> +

Acked on sashiko-bot's finding, and even more, since the function already
does the check of whether sibling devfn is equal to the device's devfn slot or not,
PCI_SLOT(sibling->devfn) is guaranteed equal to the target's slot. It's a constant.

According to the spec, the Non-CXL Function Map is one bit per function within the same
multi-function device. I think the following change would be reasonable
"""
return !test_bit(PCI_FUNC(sibling->devfn), non_cxl_func_map);
"""

and besides the false-negative case, I think the more common case would be false positive, e.g.
F>=1 reads bits 32, 64, ... in the reserved portion of the 256-bit map, which are almost always
clear, so non-CXL siblings get pulled into the CXL reset path.

Best regards,
Richard Cheng.

> +static bool cxl_reset_has_cache_or_mem(struct pci_dev *pdev)
> +{
> +	u16 dvsec, cap;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		return false;
> +
> +	if (pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap))
> +		return false;
> +
> +	return cap & (PCI_DVSEC_CXL_CACHE_CAPABLE | PCI_DVSEC_CXL_MEM_CAPABLE);
> +}
> +
> +static int cxl_reset_add_sibling(struct cxl_reset_context *ctx,
> +				 struct pci_dev *sibling)
> +{
> +	struct pci_dev **siblings;
> +	int capacity;
> +
> +	if (ctx->nr_siblings < ctx->sibling_capacity)
> +		goto add;
> +
> +	capacity = ctx->sibling_capacity ? ctx->sibling_capacity * 2 :
> +		   CXL_RESET_SIBLINGS_INIT;
> +	siblings = krealloc(ctx->siblings, capacity * sizeof(*siblings),
> +			    GFP_KERNEL);
> +	if (!siblings)
> +		return -ENOMEM;
> +
> +	ctx->siblings = siblings;
> +	ctx->sibling_capacity = capacity;
> +
> +add:
> +	pci_dev_get(sibling);
> +	ctx->siblings[ctx->nr_siblings++] = sibling;
> +	return 0;
> +}
> +
> +static int cxl_reset_collect_sibling(struct pci_dev *sibling, void *data)
> +{
> +	struct cxl_reset_walk_ctx *wctx = data;
> +	struct cxl_reset_context *ctx = wctx->ctx;
> +	struct pci_dev *pdev = ctx->target;
> +
> +	if (!cxl_reset_is_cxl_sibling(pdev, sibling, wctx->non_cxl_func_map))
> +		return 0;
> +
> +	if (!cxl_reset_has_cache_or_mem(sibling))
> +		return 0;
> +
> +	wctx->rc = cxl_reset_add_sibling(ctx, sibling);
> +	return wctx->rc;
> +}
> +
> +static int cxl_reset_collect_siblings(struct cxl_reset_context *ctx)
> +{
> +	DECLARE_BITMAP(non_cxl_func_map, CXL_RESET_MAX_FUNCTIONS);
> +	struct cxl_reset_walk_ctx wctx = {
> +		.ctx = ctx,
> +		.non_cxl_func_map = non_cxl_func_map,
> +	};
> +
> +	cxl_reset_read_non_cxl_func_map(ctx->target, non_cxl_func_map);
> +	pci_walk_bus(ctx->target->bus, cxl_reset_collect_sibling, &wctx);
> +	return wctx.rc;
> +}
> +
> +static void cxl_pci_functions_reset_done(struct cxl_reset_context *ctx)
> +{
> +	int i;
> +
> +	for (i = ctx->nr_siblings_prepared - 1; i >= 0; i--) {
> +		struct pci_dev *sibling = ctx->siblings[i];
> +
> +		pci_dev_reset_iommu_done(sibling);
> +		pci_dev_restore(sibling);
> +		pci_dev_unlock(sibling);
> +	}
> +
> +	for (i = 0; i < ctx->nr_siblings; i++)
> +		pci_dev_put(ctx->siblings[i]);
> +
> +	kfree(ctx->siblings);
> +	ctx->siblings = NULL;
> +	ctx->nr_siblings = 0;
> +	ctx->sibling_capacity = 0;
> +	ctx->nr_siblings_prepared = 0;
> +}
> +
> +static int __maybe_unused
> +cxl_pci_functions_reset_prepare(struct cxl_reset_context *ctx)
> +{
> +	int rc, i;
> +
> +	ctx->siblings = NULL;
> +	ctx->nr_siblings = 0;
> +	ctx->sibling_capacity = 0;
> +	ctx->nr_siblings_prepared = 0;
> +
> +	rc = cxl_reset_collect_siblings(ctx);
> +	if (rc)
> +		goto err;
> +
> +	for (i = 0; i < ctx->nr_siblings; i++) {
> +		struct pci_dev *sibling = ctx->siblings[i];
> +
> +		if (!pci_dev_trylock(sibling)) {
> +			rc = -EAGAIN;
> +			goto err;
> +		}
> +
> +		pci_dev_save_and_disable(sibling);
> +		rc = pci_dev_reset_iommu_prepare(sibling);
> +		if (rc) {
> +			pci_err(sibling,
> +				"failed to block IOMMU for CXL reset: %d\n",
> +				rc);
> +			/*
> +			 * Undo save_and_disable() for this sibling. IOMMU
> +			 * prepare failed, so this sibling is not counted in
> +			 * nr_siblings_prepared and must not get iommu_done().
> +			 */
> +			pci_dev_restore(sibling);
> +			pci_dev_unlock(sibling);
> +			goto err;
> +		}
> +
> +		ctx->nr_siblings_prepared++;
> +	}
> +
> +	return 0;
> +
> +err:
> +	cxl_pci_functions_reset_done(ctx);
> +	return rc;
> +}
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 14f634ab9350..fa1fcd26af01 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1349,6 +1349,7 @@
>  /* CXL r4.0, 8.1.3: PCIe DVSEC for CXL Device */
>  #define PCI_DVSEC_CXL_DEVICE				0
>  #define  PCI_DVSEC_CXL_CAP				0xA
> +#define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
>  #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
>  #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
>  #define  PCI_DVSEC_CXL_CTRL				0xC
> @@ -1366,6 +1367,7 @@
>  
>  /* CXL r4.0, 8.1.4: Non-CXL Function Map DVSEC */
>  #define PCI_DVSEC_CXL_FUNCTION_MAP			2
> +#define  PCI_DVSEC_CXL_FUNCTION_MAP_REG			0x0C
>  
>  /* CXL r4.0, 8.1.5: Extensions DVSEC for Ports */
>  #define PCI_DVSEC_CXL_PORT				3
> -- 
> 2.43.0
> 
