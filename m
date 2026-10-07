Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013024.outbound.protection.outlook.com [40.107.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8454DE721;
	Wed,  7 Oct 2026 19:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791401233; cv=fail; b=IDcrkJkzrWBxM/WB8ozZPA8NmAfCq4PI5zQxv6krjxVCSVNG4XWUvxe7Opeo99wdSABJUdVJTwPzxvKVaNOFHFOJlitQ1zpkR6FOkc2R3ezYTisrr/p9nzRDpVy2xrJPOnw/PXtM4okN7+1GICE/cIsvCjqPvporOd7VUOa9k14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791401233; c=relaxed/simple;
	bh=D9WIojUSHPnxJlxJF3R8xHyFv69ZXnuKkO1MpGmlM8Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CWaccocs3vEPrwRqbEXN1zPFWVItoBW01OET29owmspRJsMA2JxqfOTNuK5GKIxnlMZqi3vBJhi3rGoYGh0aGi5PCiPCEGUcVX/mh+LjVsfJEsA+cWtLbaKDK+d5dsjEZwpkXbh6GbrvEunBzHQO9OIsKzvA/+bFKPOrpKLefOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RVNxgfHq; arc=fail smtp.client-ip=40.107.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RVNxgfHq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KpP/e6LYSs4NbZ4sUTu146hlDnkiwa0fQmx5P6y8dbrh0EfCD5c7uGseV435e2gOUKKtkBAHfhoSq1Gs1mZ42VqejxyQSt77qXTINRb2koP8GFoRDRE1SMDJp7WwviEXO95sO6kQ0OwCTJAgvUxybfvM+tsSH0KL9ZQZB/PJFhPLu/S6df/Op3zr0AtvBLS1+vAK0DuFTpdpMXnAcwiLG2qyAHvrs9/BAmTFNK68spoAK9BGT14w9jxNVU6s+XJDqj65FAEM3dYElRUGkQn5UfnGYiU6696VqUrH50CYf+k/nk71O0ASnMONVE7E4hNqaaEbms4MXN1v2Qzk7mo9dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymrcxKAqF0CwlyOPMZOZInyYXoNnfGmU90dAuFsYJb4=;
 b=qfBmOIEsSeniric29Vgbe9ulJOm8GXWhwwRbGjH5/O5xJJSsu0kmdEGdmxZDnt07EhjzXLEtFNG4zBRjAlkLyPjtH6BVROlv7lgVqPC9Z1f2/ZPf0kIGpSf05jmLC0u5hr772jJ29bNprAYNPWWPsymYgjDxQLg22A5mAnUy5Q+riK2QBIxYeiWCnY7thXueGvr/LdkF2kTi9VOrXcz5E2u6qtXczOf+064pyCsPUqIH+TUedtJNwfN4h3agb79iXPJw29WpWNz7UT6ap+r9mlcc3/cW+eiN8z8m5XOlDlecqCWAwrHWh0gN7fUqHaV6Zhr3cVWjLkHoryVs4U3AJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymrcxKAqF0CwlyOPMZOZInyYXoNnfGmU90dAuFsYJb4=;
 b=RVNxgfHq/wkSXlgT4i0NYkFicnf8/w1s1CoyilbsuBygcbPm+UnvpSVuJgxgVtSd17jKfNmv7cKyGRXEgZHefGQDCBgtMkr/pMZYa9LSswfQJgzSFyqBOO3/L71+umgb/fvY9bIYaWabnpc1GKnjgRPlUCKpSMBu7pv8mBfxe4c=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by CY5PR12MB6382.namprd12.prod.outlook.com (2603:10b6:930:3e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 19:27:09 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%5]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 19:27:09 +0000
Message-ID: <bf41f28d-5fb0-4b10-b2f2-3c7dcefdda57@amd.com>
Date: Wed, 7 Oct 2026 14:27:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] PCI/CXL: Populate and insert/remove
 pdev->coh_resource[]
To: Ankit Agrawal <ankita@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, jgg@nvidia.com,
 aneesh.kumar@kernel.org, aik@amd.com, yilun.xu@linux.intel.com,
 iweiny@kernel.org, ming.li@zohomail.com, icheng@nvidia.com,
 bhelgaas@google.com, smadhavan@nvidia.com, ilpo.jarvinen@linux.intel.com,
 Smita.KoralahalliChannabasappa@amd.com, andriy.shevchenko@linux.intel.com,
 linux-coco@lists.linux.dev
References: <20261005070252.84810-1-ankita@nvidia.com>
 <20261005070252.84810-3-ankita@nvidia.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20261005070252.84810-3-ankita@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0066.namprd04.prod.outlook.com
 (2603:10b6:806:121::11) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|CY5PR12MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: ef6a1aec-1bb2-4681-d37a-08df24a8faab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|376014|366016|18002099003|22082099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	vBjn9+NHkGd0F53mxDbXqT59d3lPwW3Zc/Cy34DZlIONFXxi79xWYKjZVr5lwhbJlZhXgIw00GVNOLeE5RO94X+QlwmIFQFfdlpuZQxV+yEN3lxKcEZMw0SM9X3pGQk0HM79YvsM8Z5DEgQI8aX9QWTA5YVKjshtn4zV4aaEN2ZCDKL0Tuu7xaG+Zt0bVVOPZ4xvAEewI7vjSFdFC4t/Y2U7nXKIubuTqIwaFYZx7nbk/hOg98/Hr5qP9sworT/evUi5XemBX9JoyKP6CtWaPcIS9eU+Q50XrVyOt9olKzWCDB8u+gr5vowQ/5+4v68q7Z0Y0lcxZGJAOSiBPHIiVPVD5yS8G2LpjLbaMJCXXGB5NW5U4MUQy0Olbb3upx77jt124XyKWYBtNQDuJHNah9+5w1o6TsBVay3zlLxJn52YGoUjF/1/RaIgsplOn+XvVcQsyOt6NHDb1z+GrbaeNWgxUldRGihzJhGsWPN48TfE4IyMupJQzVF1yS7BmOHWfYyMAwtQuSwqpZI4Y71t4nTLx8rtNL2svjSEKxpAhsav/rL+Lnh8wezHLH4pr8LJUVaOF8BcBRffg114pDdD9ScpnC4r2mD9G61JSN7FxVAAUq9Dd+w//DvyTr/UBlCSKogRNThl9h3P9r/qG4FWy6lI83jDGgooLBjk1ezt0UA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(366016)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzVacDZiUU5Md0xpM0lwRUZtR1ZMRDZRV0NFNWVBTndYOFJuanBVamJZcG5F?=
 =?utf-8?B?OSs4akplaVRtQm1iVFdtcXYxdHlnemtxT05TVXI3cVVoR2JtS1g2SFJVSmRv?=
 =?utf-8?B?RHRYRUtqajJFSXo2M08vNmFjSmw1RzZmMVhmWFdLZTF3S1BOUWtKM2wrdTBs?=
 =?utf-8?B?QWVGUDhHUmQ2cjNsTHVnOU5PMnFrd1lXdHdsQmtBOERMakwvMjVEYVBiUElX?=
 =?utf-8?B?VUNiM1VsRCtwbjRSZVM0eTRrQWdERFBSU21VYXAxWjRMQlRhWlhJcEp2ZVJn?=
 =?utf-8?B?RGxTdDVRR1c5bllsbCszaGo0bGE0bzRXRzJ1NkZGais3Ti9tei9NT2RreWlY?=
 =?utf-8?B?SkhjY3M3Y01uNzkwclNUN1JVM2hPVHk3ZE5HcERrSzl3NWJGM3lyWVEvWEpM?=
 =?utf-8?B?VytiTHhPbTh6R0dvbkRWYkJ0Wk51clB2c0dTTHE2V2xpMGlQTjFab2tDQVRE?=
 =?utf-8?B?WTFTUkVzTTB0MzVNRFEvdmhocjFvWm0xajJFQmZRbHpkWUY3K0pPS05mb0dq?=
 =?utf-8?B?UVJHZnNRV3hLMTBlNlJmUDh6eFRBd2FTSWJtNVVPbzQwQnRlSmJXSmdtNWdB?=
 =?utf-8?B?R1EyQ3MwbVZaME14VHVjdzNOZm84S3BnenFhN0ZvTitobHdTMFRyYk9VWGo0?=
 =?utf-8?B?WFQxZlVlU0x0YnlLODd2MFNsK2NjTlZnTVpVUGx3VFdOcXpSeEFST0R1Qlhu?=
 =?utf-8?B?TjlsUlFlWHVmQnZGLzhlVTdzdlQ0Nm1yYzd1Zmp6KysyUTFjZmM4dkpMMnN4?=
 =?utf-8?B?bS9EdHBrcy92UTViZUNGNzlBdWY0UkFtSTV2K1FNcWYvVlZTSENFYnZRS0FC?=
 =?utf-8?B?eHpKcGQyd0J1M1lHMXF5d3dsMkxZT2U0MEFXVXRXTm4wc2ZpMGFNZUI5WUxj?=
 =?utf-8?B?Sjc1MVRrd01lbnNJSDg1MEJkdTQ2VmhKZ29ZRFBjMTF0dHR2MFBYS0ZiN3Uv?=
 =?utf-8?B?M0NwenRhbkRiSDRreXFSVVRJV1Vnb3hxRXhCNUZwSzl2VFJaUkxDaHRiTC95?=
 =?utf-8?B?dzRzcjJiYlZjMmhmRU5NcVRkZ1lpZHRPZEt6dk85VGhQZWt2WlE4NDZ4TFN1?=
 =?utf-8?B?RWtzMDgyWGt0MTIzZzQrR1hTckR1cUx4NTZOMFBBb0VsRmczbFZRRm5VdVpu?=
 =?utf-8?B?SURyYkV1L0FrR1RpWXg2VU9Bc3VrTXNzdEVJVFp3b21Kb2lnN3owNlZ1eEUw?=
 =?utf-8?B?MnVBTlRhSzk3QWN6RWtyT3p5ME1TR2IwUXpMaFEvYkN6NWlOY2FSaXFIcFlZ?=
 =?utf-8?B?aVFpTXNrVGVqNE9kOVZKZFVpc0hacnFnRlRvU0huMUwwZkZ5UTZ4eGNYSW9H?=
 =?utf-8?B?NUF4Rkp5ajdkdG5DV3dqOFR3cTZ5WndrdDJCZFZkQ0xLS3NVdVYva1ZWYVZp?=
 =?utf-8?B?TXM2TW9OWEtUZFlCeU16YTRzb2lSV1o1Y1R4MkZIdjVtNkpjdjBYSUI3c1Vl?=
 =?utf-8?B?YVNUSGw3alp4bTY4TklVMFRxYjhuc0FMQVpoOEZveFZMVDBSeFpkeGFpYm1j?=
 =?utf-8?B?SmZPMlBRUTFPTEJTOGozZmpuT0V3YXpKSWJSQy9UNXFxRVZ2Ujk5TmxHT3hJ?=
 =?utf-8?B?ek9UZTBhdUpFSXJWRDhGbituTnNsK2FRMlcrczI1emdaR3VXQkFTNlNrbG04?=
 =?utf-8?B?YlNMRzVFcy83bVloOExMaEVqamEvSkFNRk1MMkVadThVeGVQWGZWeCtTaS9Y?=
 =?utf-8?B?NitDYUhmdGZQY1RGUkRLNDBidmpzOXI4b3NYR3lmM2xxdWd5Tm9LUFlUMGpJ?=
 =?utf-8?B?MlZEVUwrNjhMUSt1djlhckJrSFREK0xscCtKc1FYbDFOdHhNd3JydFhBZTlT?=
 =?utf-8?B?cVhQWXNza3k4dWtDSVh0Q2xoeU5ia1gxZ0JGZzRqSVFpQk1aZVRtMkFRN1dk?=
 =?utf-8?B?QVhFYnY0UkJvWHFiMTdOWVN3a3kwNnAvWUE1cHZSVFppSW1PZmtnQXNJTFFQ?=
 =?utf-8?B?L0d5UWc2MWlRSGZUc0gzU2cza3pickMwWExFS29DcmhQOUI2TVA2c0M5UUJL?=
 =?utf-8?B?N1FZd3pmYllTeUtVdFVUalBSNXNROEVCVStHcmRtUlRjYlljeStMNk9Tc3Jt?=
 =?utf-8?B?ejBTNkF1azNiTnBNamkzK1FRdTFhcERPdjdsbldhUVJMN3dRK0hLd0VKZTht?=
 =?utf-8?B?ZVhRNk41MXJqUjZRNnNRaUgvbG1WaUMrN25RUjJqU0lLQk03dHVYdDV1UG41?=
 =?utf-8?B?VmxFQnpzbGdMS3hHR1k4YlYyME0yYnlpVk9iRDlJYlJpM3dLNTZUYUZrZzlY?=
 =?utf-8?B?M2F0WWxoNi9LQTEzU2h3SVpxK0hqSVQrTk1GZ2FheEZ0V09sdEZMM3p5MVNT?=
 =?utf-8?Q?G5B2TxgshD9bmNljs9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6a1aec-1bb2-4681-d37a-08df24a8faab
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 19:27:09.0764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k3+HIysp/MHBMDYpbLD0HfUg9ZfNT53cPdtoEniFko6vuq9bNFlerdCI6ASFyArmxlZjgzFea/9LORlJGQGbdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6382

On 10/5/2026 2:02 AM, Ankit Agrawal wrote:
> On systems with precommitted HDM decoders, the firmware programs
> the decoders before any software runs. This range also stays constant
> over the runs.
> 
> Snapshot precommitted CXL HDM decoder ranges into a new
> pdev->coh_resource[] array, so later code has a known-good source for
> a device coherent (CXL) windows without re-scanning decoder
> registers.
> 
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> Assisted-by: Claude:sonnet-5
> ---
>  drivers/cxl/core/resource.c | 52 ++++++++++++++++++++++++++++++++++++-
>  include/linux/pci.h         | 14 ++++++++++
>  2 files changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index 3422139ae3ab..4d2082c8e321 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ -404,6 +404,46 @@ static struct cxl_hdm_info *cxl_pci_hdm_read_info(struct pci_dev *pdev,
>  	return ERR_PTR(pcibios_err_to_errno(rc));
>  }
>  
> +/*
> + * Snapshot committed decoders into pdev->coh_resource[] which is called
> + * once per pdev before any driver can bind, so a populated entry is
> + * always firmware-committed and not driver-committed.
> + *
> + * Insert each entry into iomem_resource for /proc/iomem visibility and
> + * conflict detection.
> + */
> +static void cxl_populate_coh_resource(struct pci_dev *pdev,
> +				      struct cxl_hdm_info *info)
> +{
> +	int count = min(info->decoder_count, PCI_CXL_MAX_COHERENT_RANGES);
> +
> +	for (int i = 0; i < count; i++) {
> +		struct cxl_decoder_config *config = &info->settings[i].config;
> +		struct resource *res = &pdev->coh_resource[i];
> +		struct resource *conflict;
> +
> +		if (!(config->flags & CXL_DECODER_F_ENABLE))
> +			continue;
> +
> +		*res = DEFINE_RES_NAMED_DESC(config->hpa_range.start,
> +					     range_len(&config->hpa_range),
> +					     "CXL coherent memory",
> +					     IORESOURCE_MEM, IORES_DESC_NONE);
> +

On platforms using Normalized Addressing the Endpoint decoders contain DPA ranges. This 
patch will then record DPA ranges as a result. Translating this requires call to prm_cxl_dpa_spa() ?
The challenge is the PRM in drivers/cxl/core/atl.c may not be initialized this early.

> +		conflict = insert_resource_conflict(&iomem_resource, res);
> +		if (conflict) {
> +			pci_warn(pdev,
> +				 "CXL coherent range: decoder%d %pR conflicts with %s %pR, leaving unpopulated\n",
> +				 i, res, conflict->name, conflict);
> +			memset(res, 0, sizeof(*res));
> +			continue;
> +		}
> +


- Terry

> +		pci_info(pdev, "CXL coherent range: decoder%d precommitted, populated %pR\n",
> +			 i, res);
> +	}
> +}
> +
>  static int __pci_cxl_hdm_cache_init(struct pci_dev *pdev)
>  {
>  	struct cxl_register_map map = { };
> @@ -442,8 +482,10 @@ static int __pci_cxl_hdm_cache_init(struct pci_dev *pdev)
>  	struct cxl_hdm_info *info __free(kfree) = read_info;
>  	guard(rwsem_write)(&cxl_rwsem.dpa);
>  	/* Another initializer may have published while we read MMIO. */
> -	if (!pdev->hdm)
> +	if (!pdev->hdm) {
> +		cxl_populate_coh_resource(pdev, info);
>  		pdev->hdm = no_free_ptr(info);
> +	}
>  
>  	return 0;
>  }
> @@ -466,6 +508,14 @@ void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
>  	info = pdev->hdm;
>  	/* Unpublish before freeing so subsequent readers cannot use stale state. */
>  	pdev->hdm = NULL;
> +
> +	for (int i = 0; i < PCI_CXL_MAX_COHERENT_RANGES; i++) {
> +		struct resource *res = &pdev->coh_resource[i];
> +
> +		if (res->parent)
> +			remove_resource(res);
> +	}
> +
>  	kfree(info);
>  }
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index b00f5f38f77d..ce724d067fd2 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -148,6 +148,13 @@ enum {
>  	DEVICE_COUNT_RESOURCE = PCI_NUM_RESOURCES,
>  };
>  
> +/*
> + * Max CXL HDM decoders tracked per endpoint in pci_dev->coh_resource[].
> + * CXL 3.1 spec section 8.2.4.20.1 - CXL HDM Decoder Capability Register,
> + * mention a max of 10 decoders for a CXL device.
> + */
> +#define PCI_CXL_MAX_COHERENT_RANGES 10
> +
>  /**
>   * enum pci_interrupt_pin - PCI INTx interrupt values
>   * @PCI_INTERRUPT_UNKNOWN: Unknown or unassigned interrupt
> @@ -572,6 +579,13 @@ struct pci_dev {
>  #endif
>  #ifdef CONFIG_CXL_RESET
>  	struct cxl_hdm_info *hdm;	/* CXL HDM decoder state */
> +	/*
> +	 * Precommitted CXL HDM decoder coherent ranges, snapshotted before
> +	 * any driver binds. One entry per decoder index. Only written by
> +	 * pci_cxl_hdm_cache_init()/_release(), outside any bound driver's
> +	 * read window.
> +	 */
> +	struct resource coh_resource[PCI_CXL_MAX_COHERENT_RANGES];
>  #endif
>  #ifdef CONFIG_PCI_NPEM
>  	struct npem	*npem;		/* Native PCIe Enclosure Management */

