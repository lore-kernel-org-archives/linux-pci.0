Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A38442FB3;
	Wed, 26 Aug 2026 18:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787767826; cv=fail; b=F2jT9cIIyH2AmmrMWlQeObyOX1xsWH7hXkuCFLGB/gW+q1nn0k7ofakda+aQ5VhA0Wf3+qk4gA2AywUE64uaWysjKkW2oENfW+gt6Rtba848bK3zbvJNhrCscAG6wPZdHayl/mB0Ulbh+kBmjX1Gkp47gla+qH4STKwRcmsDQcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787767826; c=relaxed/simple;
	bh=b6Q1rs2ptem5o3XmIBwlj4fK9frPw9YP2fbnvKaIhC8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dr4+5+RpDt8TavgNUanuCA0bTmryelSrFckPG1x49O29Naowx4Dj5XhY0r1Z6mFziM6R3FNa0xkYclky6B344YFhJEEcMVQD4nc7RQMec0Ee1yB0uU9+Fzz1KscHH6tfQEHwmzdtUSQn8SFuQQspRhFIEqf4jxgZHC+sODaAJq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VSmEpkum; arc=fail smtp.client-ip=52.101.62.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VSmEpkum"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxaOYKHMMBUc2s9rhPwNrNYjwhfcmv/czS+fFR9swvOvnixd66I+er65twtQUjaMy1Alyf/94BuFxdLmDnTcPOEbTsu55vKOtUFZeFNZejvwZaGB9O0d9uHB7zURM2kMtu6QwEHTliPOpbW9qoioS+i2gGidhOoS4+BbZ8hcDuca9O7O/K2plqr7qQo2AOFICFckjBtwXWmE/TIY/F0t6qbm6Mw0Jlz8Fs41xjeMJKSiXjC9kC/g6uqiwgwo5/jVKyy+8L0gu2GSHiauihRU8l10aVCLCN7epxz5p9gnAJSWP6q+j0NlPAhC+i2yhq3IxxLeiJ4XlbZtbtXGeCHt8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysCSG+1+6z81mxaqPRH4uvJeUFtgv9cwfhGmmw+Td90=;
 b=u3zs7jh6oaiePHo91kHRueRmYYRzZR7u1hhQu12ycBOE5mEBidHy6gADW2WjGbbMuCpwoWBmT2C/KnI/LEep/D+TRxtLdmadqRps+fPJwrRLfdqq34gYzQ6wuRn2pAErm+jACkqg7jknCu9p9+am/DdlzE3sSCQZrRLiC0NKrpObaqxcE1Vb0GRHWI2UF7I5I1iFWnYj+JFI3QkQCjcy6nVBhJm5N1TM36k+jWJAb2Q/phrzOEIpxcnKksAY+HZeulizNSQGzosnEjOnrhhgie1qHsVBtP8GZNvEVLguYW+vFv3ejmsj+cNSHRhdnGymitRfv1X3wJtZyR4QpGTrjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysCSG+1+6z81mxaqPRH4uvJeUFtgv9cwfhGmmw+Td90=;
 b=VSmEpkumvKPqJR+CZBYuYPhcoxFLGjd1I/gDtBsw4tE+bp2rD03bdXFH4fsnLDYKm96inCzSvm24uyEjuF+YVGBAl/vZmKCrRfkVg1jH1gJUG30ufdeXni7U/C0ck6nAVHgE386Y0ML30dQPq78KFdZ0BrAgohvWsnceHV6GC7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 PH0PR12MB7984.namprd12.prod.outlook.com (2603:10b6:510:26f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.9; Wed, 26 Aug 2026 18:10:01 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%6]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 18:10:00 +0000
Message-ID: <ad7227ce-3b14-4350-b21c-3b3ac414f84e@amd.com>
Date: Wed, 26 Aug 2026 19:09:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 06/12] cxl: Add CXL Device Reset helper
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-7-smadhavan@nvidia.com>
Content-Language: en-GB
From: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
In-Reply-To: <20260804192958.1823952-7-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0083.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::16) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|PH0PR12MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de635a9-3388-49f8-5463-08df039d3e1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|921020|6133799003|4143699003|10067099003|56012099006|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	j2ZwFBOnzaFaRn640cr3AK81pndtBk6C+OA9F5s8Bs4M/fJSZPwbIXDNWz2I7ROlB9uzGSrK57SqGX/TJ2nltq+5RVVkeLFYpINkyaf/tAE/eaKQmo+/Sy99jisdHeOLhljMM/Brx62g/+8S2EDsmvBwa4zpW7BwtuyRbcTsX66/EanLg+jREy0BY1+9Rx/bUNS7NJAtLD330MWP4F3rfD9a/qdulekzjBFwaWBERyPtIjOHIth7XiNi9EoPesYGrTPAj/Bh+fqVmcU4Sz/Raa7q45otO6xqPzx7a4TlY9d7vstW8y4qxwxhUNnk6Zhsm9x3qk98fAp7/fxxyMxS1liUgZHbgjk6/s3HseGXqiQXpbb3gbvxy8DVjwPbGWg4yvnRzmKyBABvH21FSXEIVxwdlJBDFD5kyENqjOdwcu08dRhCHHd4khLQUtlWvHJdTrmGRKYqQ9DL0Ur+D51CbWftrXiclZ9bhSux6Z5Cw4PYoZl43BfD9oNch0OkclUsI9JWn6qB2w4gHmkHdgXq8q5wzwipZj4YDwJD9UWNsTURSsr/aDKRtt747fOjZCuB1GOyC7DT1CcaEo4jzMVHWNX4z/JAAHkGp0RJXO1tzqP4FIWtLc2tTSCs/h2V2rJHZ1fdzxaQ/WvZPdekyZVkpMzQZ2EuGEGxUUnxRDt9+FAEgQtUI2cXdYjUTiBYgK3QzHYWXAcsVUZypgZcxb96Lw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(921020)(6133799003)(4143699003)(10067099003)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b21nKzQxd0QrQm9PZktkb2ROdTIwaEk2eFlXcGNNTzJLNUlGSklpdGxyTGZi?=
 =?utf-8?B?TWpmaEVvT0lFZ1IyZlVNZGlleGphTThiWUlrNkdDaTljT0d1Y1ZHYnR4Tnlk?=
 =?utf-8?B?cElDTlBIY2tTL0ViVVBzZEhySDFkbDBIeFdyNllFNUJha2tncUZ3Ym9HOGpq?=
 =?utf-8?B?VlA4cGxVZzFaQ09jKzc4Z1NBejhNOUx6L2JGc2pza1FOUHlnZzlZNEtwQnc2?=
 =?utf-8?B?aGw4bDQvOFhTblc1dmVnZldyRzNqTmpSeEhySmJBMEwyczRham80MFduOXp0?=
 =?utf-8?B?cjVIZ0Z0V1hva3NSTk5lNHZXQ2xkYnZ6TEdFN080aVBhOEtoN0FQd3FrTmM2?=
 =?utf-8?B?V2cvR3FrTzVXajlQM1FobW5OZThMbmhmU3YrVlBXcHoydUtIS2p5QnZHeEFr?=
 =?utf-8?B?WWxkVmxRYTQ1amQ0QTE5c2Z4TGRkakZzZk81VG9zMVdJRjBtZVdjVkp5b0hI?=
 =?utf-8?B?TVpld1N1Mm5GNXRLZ3RzbFRhTUlQOFAyRHZHeDlCRWQ2YjcwZXE5cmtveFlr?=
 =?utf-8?B?SGFyaGpLaGZPbmhKY09mQzVjMzVnQnRhQ1AvVHBKbWNNbFNHbGNKaytXVFBv?=
 =?utf-8?B?bVRLKzZCNkcyOEl5SE9nT0JOWFlVMWJ1Tms2dENNME1JbUtRMjkxM2NBdS9r?=
 =?utf-8?B?ZzluV2NSYlNOSEVDYXExNE9aNmJwdTcyeTlqRFB3aU8rYUN4YVpudCtGSlhJ?=
 =?utf-8?B?Q3VGZWlnbjFUTGY2SzQxek5JbXZZaEw1enh0QzNZdTlnQXdkZ0VodURRNmxQ?=
 =?utf-8?B?MmtNRjBIZjFGNWZVQlgzTmFOMXVDV05PYU5MWnMzc2FtdGpMTU1nNkVlQXRG?=
 =?utf-8?B?RUhVUGxqUXlOZTh4Q1drMjRDVjdFcUZSTVRXUzJ5VXVOZkZ3K3E3UWdWSng3?=
 =?utf-8?B?WTNES21oaWFaRDNsUGc0NmhEa0VUSkJKcnI4SXJSeDJDNUZodzQxeUZNaDVx?=
 =?utf-8?B?cG9GY2x3WlhJQTJIVkgzL2xoeFp4YkNrK2RXNUh6OGNkQ09pYkJ2eEJ5YWRO?=
 =?utf-8?B?SUZDdGZHcndmZ1hZRytUakpYakFCZk44dUp5RTQ4OXNzTzhQL3NzRktrN3R4?=
 =?utf-8?B?TExaL1FOeTlGakc2c21ZaXpFQ2VCTVViRk5RTEtoa3ZTQkloT29rSnFzMkIv?=
 =?utf-8?B?bGNkSFNLK3hKK0dlWHBzT0g4MVB5S3VVRW5YbG9La21nbE14TDRwcnY1WWJE?=
 =?utf-8?B?YmJidytmUHZpSHRsQWJid1ozS1E4eEF0YUw5K0dGN0Y4OXpQaUdrYXZtczJq?=
 =?utf-8?B?UUlnRFFpWTZXMXdTclh0S3I0SzlwMnV4c0RTVVExdCs0dURJZVdTb1MxN3Rz?=
 =?utf-8?B?TFpNT0pBakdrMk0wTG5PYXM0UnFKTXFnS3JHV2ZTdUJBK2R3OS9MT2dlVnZk?=
 =?utf-8?B?bDN1YjFGeFZ1akVvWE1jTklFYnNCSUtDNnpQMFliTzl6L242ZHVhc3daVVFX?=
 =?utf-8?B?a3pWdnhESzZIRXpCRmc5cUo2Ui9FTFBwWUVORUZPc29HdnVUNy83NDZzcXdX?=
 =?utf-8?B?ZzB2aE5GbXhITDJlR24zLzZmRGJBZkFGdERybHNkWVdhWnZHU2hGSFRzVGRM?=
 =?utf-8?B?Vi9sT1RjS1o1MTJoa1VZdDRMMTladEFucU9zK2V6S1l1dHRrQ2FtU1ROT2Vw?=
 =?utf-8?B?OVdMeDBzU2grWnZFNmhtNXZpdmttYzdUNXZJSXZIK3FBdnZrK2Rmbi9zeFpz?=
 =?utf-8?B?SmZqUnk5bDU0b1dLUWpXMEt0NnhTZXdMRmNUWG9SditnSFlrSWZyMHY4aUZ4?=
 =?utf-8?B?MWZjQ2QwWGgzREppUFVHbGxOd3dKZ0hPeDJDVEFFczd0OW40MzZQdm9HRTNi?=
 =?utf-8?B?RURYVTRjTzJMbGpMQzhNcXVWWjhjMlhYLzJuL1FXSlRyZjgxcXAwNEREZGp3?=
 =?utf-8?B?UHRTaWFUTUh6bDFUT0YvZUxuMWlzUUl0OU1YbWdBTlVZV3Y2d3IxVHdLSjVJ?=
 =?utf-8?B?L3hhWmp6WHJzaGtKLzROeS9BbGpvVS9EUVFvamk3MEYzd2pjcjJlSFJybHNH?=
 =?utf-8?B?WlNFOXdxa2I1NGtEZ2I1cTZGNFJVeURjUi9VbDY5cFFEcEdSdDZDTllMS1ly?=
 =?utf-8?B?d1BMMnFrRnQrK3p6Mnd4QWRnTnJsUGNvTklIWEhzNVA1YmtIR05pdFJQazEz?=
 =?utf-8?B?YkE4QXNDUlczSUMzakVYaitLQVJlSFpEdDVYYlRlQlpWY2p0WkZGa2N5djNv?=
 =?utf-8?B?R2xoN1Q0WHpRbGIrZFBiN0dpamVGeTg4TzY5VThDeGErckRYMVNEdUc1UVNw?=
 =?utf-8?B?UDFETk9jNFc5Qlo0MWw3WWxrK0NzQTlQUGVTMzFUSlRIemJxMi9SWHhlRVUr?=
 =?utf-8?B?R2tFTUxZdEJlaW9aU0FyZHJDcDJCR1ZSTmdVR2VjOUMxbmRoUTk0dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de635a9-3388-49f8-5463-08df039d3e1a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 18:10:00.5692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwdVVPFk/88zUh6Jf4wKEQ+qFJP9ryxwxdiSLu1oEccxvu90dIgaGwE9OvdtV2VG9o7HuJrQ2un7KfeKKM0Xpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7984


On 04/08/2026 20:29, Srirangan Madhavan wrote:
> Add an internal CXL Device Reset helper for Type 2 functions that advertise
> CXL Reset in the CXL Device DVSEC. The helper disables CXL.cache, performs
> cache writeback when supported, initiates reset with Memory Clear disabled,
> waits for completion, and re-enables CXL.cache on exit.
>
> Leave the helper unregistered until range validation and reset-scope
> validation are in place.
>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>   drivers/cxl/core/resource.c   | 265 ++++++++++++++++++++++++++++++++++
>   include/cxl/cxl.h             |   7 +
>   include/uapi/linux/pci_regs.h |  14 ++
>   3 files changed, 286 insertions(+)
>
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index 7f5946d3f2c4..c10e84b240a0 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ -7,6 +7,8 @@
>   #include <linux/export.h>
>   #include <linux/io.h>
>   #include <linux/ioport.h>
> +#include <linux/iommu.h>
> +#include <linux/jiffies.h>
>   #include <linux/kernel.h>
>   #include <linux/pci.h>
>   #include <linux/slab.h>
> @@ -483,3 +485,266 @@ void pci_cxl_hdm_init(struct pci_dev *pdev)
>   	if (rc && rc != -ENOTTY && rc != -ENODEV)
>   		pci_dbg(pdev, "CXL HDM cache init failed: %d\n", rc);
>   }
> +
> +/*
> + * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
> + * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
> + * initiating CXL Reset, then limits software to CXL Status2 access until
> + * reset completion, timeout, or error.
> + */
> +#define CXL_RESET_RRS_WAIT_MS 100
> +#define CXL_RESET_STATUS_POLL_MS 20
> +static const u32 cxl_reset_timeout_ms[] = {
> +	10, 100, 1000, 10000, 100000,
> +};
> +
> +#define CXL_CACHE_WBI_TIMEOUT_US 100000
> +#define CXL_CACHE_WBI_POLL_US 100
> +
> +static int cxl_reset_dvsec(struct pci_dev *pdev, u16 *cap_out)
> +{
> +	int dvsec, rc;
> +	u16 cap, ctrl;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		return -ENOTTY;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
> +	    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE))
> +		return -ENOTTY;
> +
> +	if (!(cap & PCI_DVSEC_CXL_RST_CAPABLE))
> +		return -ENOTTY;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL, &ctrl);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	if (!(ctrl & PCI_DVSEC_CXL_CACHE_ENABLE) ||
> +	    !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
> +		return -ENOTTY;
> +
> +	*cap_out = cap;
> +	return dvsec;
> +}
> +
> +#define CXL_RESET_CTRL2_CMD_MASK \
> +	(PCI_DVSEC_CXL_INIT_CACHE_WBI | PCI_DVSEC_CXL_INIT_CXL_RST)
> +
> +static int cxl_reset_read_ctrl2(struct pci_dev *pdev, int dvsec, u16 *ctrl2)
> +{
> +	int rc;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	*ctrl2 &= ~CXL_RESET_CTRL2_CMD_MASK;
> +	return 0;
> +}
> +
> +static int cxl_reset_write_ctrl2(struct pci_dev *pdev, int dvsec, u16 ctrl2)
> +{
> +	int rc;
> +
> +	rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	return 0;
> +}
> +
> +static int cxl_reset_set_ctrl2(struct pci_dev *pdev, int dvsec, u16 set)
> +{
> +	u16 ctrl2;
> +	int rc;
> +
> +	rc = cxl_reset_read_ctrl2(pdev, dvsec, &ctrl2);
> +	if (rc)
> +		return rc;
> +
> +	ctrl2 |= set;
> +	return cxl_reset_write_ctrl2(pdev, dvsec, ctrl2);
> +}
> +
> +static int cxl_reset_clear_ctrl2(struct pci_dev *pdev, int dvsec, u16 clear)
> +{
> +	u16 ctrl2;
> +	int rc;
> +
> +	rc = cxl_reset_read_ctrl2(pdev, dvsec, &ctrl2);
> +	if (rc)
> +		return rc;
> +
> +	ctrl2 &= ~clear;
> +	return cxl_reset_write_ctrl2(pdev, dvsec, ctrl2);
> +}


These two functions are almost the same code. Merging them and using a 
bool for set or clear seems reasonable to me.


> +static int cxl_reset_enable_cache(struct pci_dev *pdev, int dvsec)
> +{
> +	return cxl_reset_clear_ctrl2(pdev, dvsec,
> +				     PCI_DVSEC_CXL_DISABLE_CACHING);
> +}
> +
> +static int cxl_reset_initiate(struct pci_dev *pdev, int dvsec)
> +{
> +	u16 ctrl2;
> +	int rc;
> +
> +	rc = cxl_reset_read_ctrl2(pdev, dvsec, &ctrl2);
> +	if (rc)
> +		return rc;
> +
> +	ctrl2 &= ~PCI_DVSEC_CXL_RST_MEM_CLR_EN;
> +	ctrl2 |= PCI_DVSEC_CXL_INIT_CXL_RST;
> +	return cxl_reset_write_ctrl2(pdev, dvsec, ctrl2);
> +}
> +
> +static int cxl_reset_wait_cache_wbi(struct pci_dev *pdev, int dvsec)
> +{
> +	unsigned long deadline;
> +	u16 status2;
> +	int rc;
> +
> +	rc = cxl_reset_set_ctrl2(pdev, dvsec, PCI_DVSEC_CXL_INIT_CACHE_WBI);
> +	if (rc)
> +		return rc;
> +
> +	deadline = jiffies + usecs_to_jiffies(CXL_CACHE_WBI_TIMEOUT_US);
> +	do {
> +		usleep_range(CXL_CACHE_WBI_POLL_US, CXL_CACHE_WBI_POLL_US + 1);
> +
> +		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
> +					  &status2);
> +		if (rc)
> +			return pcibios_err_to_errno(rc);
> +		if (status2 != U16_MAX && (status2 & PCI_DVSEC_CXL_CACHE_INV))
> +			return 0;
> +	} while (time_before(jiffies, deadline));
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int cxl_reset_disable_cache(struct pci_dev *pdev, int dvsec, u16 cap)
> +{
> +	int rc, rc2;
> +
> +	rc = cxl_reset_set_ctrl2(pdev, dvsec,
> +				 PCI_DVSEC_CXL_DISABLE_CACHING);
> +	if (rc)
> +		return rc;
> +
> +	if (!(cap & PCI_DVSEC_CXL_CACHE_WBI_CAPABLE))
> +		return 0;
> +
> +	rc = cxl_reset_wait_cache_wbi(pdev, dvsec);
> +	if (!rc)
> +		return 0;
> +
> +	rc2 = cxl_reset_enable_cache(pdev, dvsec);


Why do you re-enable the caching? I understand it needs to be disabled 
for safely doing the reset, but why to enable it?

If there is a reason, maybe adding a comment would help to future readers.


Thanks,

Alejandro


> +	if (rc2)
> +		pci_warn(pdev, "failed to re-enable CXL caching: %d\n", rc2);
> +
> +	return rc;
> +}
> +
> +static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
> +{
> +	unsigned long deadline;
> +	u32 timeout_ms;
> +	u16 status2;
> +	bool final = false;
> +	int idx, rc;
> +
> +	idx = FIELD_GET(PCI_DVSEC_CXL_RST_TIMEOUT, cap);
> +	if (idx >= ARRAY_SIZE(cxl_reset_timeout_ms)) {
> +		int last = ARRAY_SIZE(cxl_reset_timeout_ms) - 1;
> +
> +		pci_warn(pdev,
> +			 "unknown CXL reset timeout encoding %d; using %u ms\n",
> +			 idx, cxl_reset_timeout_ms[last]);
> +		idx = last;
> +	}
> +
> +	timeout_ms = max_t(u32, cxl_reset_timeout_ms[idx],
> +			   CXL_RESET_RRS_WAIT_MS);
> +	msleep(CXL_RESET_RRS_WAIT_MS);
> +	deadline = jiffies + msecs_to_jiffies(timeout_ms -
> +					      CXL_RESET_RRS_WAIT_MS);
> +
> +	do {
> +		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
> +					  &status2);
> +		if (!rc && status2 != U16_MAX) {
> +			if (status2 & PCI_DVSEC_CXL_RST_ERR)
> +				return -EIO;
> +
> +			if (status2 & PCI_DVSEC_CXL_RST_DONE)
> +				return 0;
> +		}
> +
> +		if (time_after_eq(jiffies, deadline)) {
> +			if (final)
> +				return -ETIMEDOUT;
> +			final = true;
> +			continue;
> +		}
> +
> +		msleep(CXL_RESET_STATUS_POLL_MS);
> +	} while (true);
> +}
> +
> +static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
> +{
> +	bool target_prepared = false;
> +	int rc, rc2;
> +
> +	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
> +	if (rc)
> +		return rc;
> +
> +	if (!pci_wait_for_pending_transaction(pdev))
> +		pci_err(pdev, "timed out waiting for pending transactions\n");
> +
> +	rc = pci_dev_reset_iommu_prepare(pdev);
> +	if (rc)
> +		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
> +	else
> +		target_prepared = true;
> +
> +	if (!rc)
> +		rc = cxl_reset_initiate(pdev, dvsec);
> +	if (!rc)
> +		rc = cxl_reset_wait_done(pdev, dvsec, cap);
> +
> +	rc2 = cxl_reset_enable_cache(pdev, dvsec);
> +	if (rc2 && rc)
> +		pci_warn(pdev, "failed to re-enable CXL caching: %d\n", rc2);
> +	else if (rc2)
> +		rc = rc2;
> +
> +	if (target_prepared)
> +		pci_dev_reset_iommu_done(pdev);
> +	return rc;
> +}
> +
> +int cxl_reset_function(struct pci_dev *pdev, bool probe)
> +{
> +	int dvsec;
> +	u16 cap;
> +
> +	dvsec = cxl_reset_dvsec(pdev, &cap);
> +	if (dvsec < 0)
> +		return dvsec;
> +
> +	if (probe)
> +		return 0;
> +
> +	return cxl_reset_execute(pdev, dvsec, cap);
> +}
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index a1fe8949f3f7..8645d0fbd273 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -9,6 +9,7 @@
>   #include <linux/node.h>
>   #include <linux/ioport.h>
>   #include <linux/range.h>
> +#include <linux/errno.h>
>   #include <cxl/mailbox.h>
>   
>   /**
> @@ -161,6 +162,7 @@ struct cxl_hdm_info {
>   #ifdef CONFIG_CXL_HDM
>   void pci_cxl_hdm_init(struct pci_dev *pdev);
>   void pci_cxl_hdm_release(struct pci_dev *pdev);
> +int cxl_reset_function(struct pci_dev *pdev, bool probe);
>   #else
>   static inline void pci_cxl_hdm_init(struct pci_dev *pdev)
>   {
> @@ -169,6 +171,11 @@ static inline void pci_cxl_hdm_init(struct pci_dev *pdev)
>   static inline void pci_cxl_hdm_release(struct pci_dev *pdev)
>   {
>   }
> +
> +static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
> +{
> +	return -ENOTTY;
> +}
>   #endif
>   
>   struct cxl_reg_map {
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index facaa324bd86..4f5942ebd29b 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1352,8 +1352,22 @@
>   #define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
>   #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
>   #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
> +#define   PCI_DVSEC_CXL_CACHE_WBI_CAPABLE		_BITUL(6)
> +#define   PCI_DVSEC_CXL_RST_CAPABLE			_BITUL(7)
> +#define   PCI_DVSEC_CXL_RST_TIMEOUT			__GENMASK(10, 8)
> +#define   PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE		_BITUL(11)
>   #define  PCI_DVSEC_CXL_CTRL				0xC
> +#define   PCI_DVSEC_CXL_CACHE_ENABLE			_BITUL(0)
>   #define   PCI_DVSEC_CXL_MEM_ENABLE			_BITUL(2)
> +#define  PCI_DVSEC_CXL_CTRL2				0x10
> +#define   PCI_DVSEC_CXL_DISABLE_CACHING			_BITUL(0)
> +#define   PCI_DVSEC_CXL_INIT_CACHE_WBI			_BITUL(1)
> +#define   PCI_DVSEC_CXL_INIT_CXL_RST			_BITUL(2)
> +#define   PCI_DVSEC_CXL_RST_MEM_CLR_EN			_BITUL(3)
> +#define  PCI_DVSEC_CXL_STATUS2				0x12
> +#define   PCI_DVSEC_CXL_CACHE_INV			_BITUL(0)
> +#define   PCI_DVSEC_CXL_RST_DONE			_BITUL(1)
> +#define   PCI_DVSEC_CXL_RST_ERR			_BITUL(2)
>   #define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)		(0x18 + (i * 0x10))
>   #define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)		(0x1C + (i * 0x10))
>   #define   PCI_DVSEC_CXL_MEM_INFO_VALID			_BITUL(0)
