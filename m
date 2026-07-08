Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011042.outbound.protection.outlook.com [40.93.194.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79003B71B9
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 02:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783477540; cv=fail; b=GB2YFkp3YR9IRo0pLAuBAR+KG5gJmZOLqKfhLi14FMwfe+EQ2PpvCf3msQE5EjFXWldJWH9lSNEcI/syG7YtkEmHCjreLKul8mc0Iq3mBl5BFZl5hHgPMyxW0Zml74SwRb8xfoKjLELHOrPn3SfJFaOoTOhv7iCCGJ4c8QEzwuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783477540; c=relaxed/simple;
	bh=plCkd97bmokzbdM0++HunZE88FZbLmAzRlOo/n6WbGQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CpQ2RIMrxwfqk7mI2oGUryyDj6l6QD1ie9kRuFgbtXoJpVAHXCu+B2z3LXXPKo1A2izwKyjVttX/UYNnxS9pOAhuK4Kkc0Eu9DES2niHY+tZGJWq9wzeEOcXfEMZgeVNxx0Ho7vCJePgjPDziY8HMt/4Fze8GAWf7dGp+Ct8bVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wXejvucI; arc=fail smtp.client-ip=40.93.194.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wXejvucI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpqNocHdTUs73pWj65whNVq72y9n0fB7bzbVAuSTMmGkFvsEcGTmiX5QmSQ04XeyRpwMK13XvjgoZRJ8JuzMY/7ZQqt1FXVp6WiUMOEwyLWoP7jzGA1RfgzVEoxLy4ObgLjUdw8vqtBwPAVgnjnnJfVB418CqJlQx2PKfbQfVe7BwF85SQyl8d7WwtWlQnN6NuDuZtPBKfxDSv20NDxoMg9bprkrGshT/iZG5325hCZrLqSRDQ78p+19ObKZj09F4DYgRo1yCPjiR6kNry9ABiJhgNClGcdWwFrg4mkWGl5KdDyEsO7iotOHwxICyydcJKJcE6JHSmVhnnOrHzZhXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAkgZCtCeuvI9ahSt9HcXI50C1Km2c0KoV5p7e9z71I=;
 b=lrYyHX11uuTOeLLwQo+jBWpZ26viYuxrV9G2SN+qatcU57gwUGoUzrp4X4AfR3ureRvAQz9G7jiPfFyPEknrA5gcqVEfs+D7O5BHFt9Mbw/uItaK+B6ZWUiqMvYYmZozOmvxx5DOfYYKHQza0v6cz3eSED9ikDc8XKFw0jhcirnPdDA7eeu7H9mIsBk93Q3EctHdKoo0VbdM5IovZfEXPrbG/7M+Ugnla5gE212kA/+0qUAcgGnwIr3AwUCEeJYlALC4cOLceL2IRwUBQtnqqBED/nEgA1mVMassS1bmaFMFM6pRRBWoTITJJHjHzELhn28w+4b+4KM4l1xcoF9CnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAkgZCtCeuvI9ahSt9HcXI50C1Km2c0KoV5p7e9z71I=;
 b=wXejvucIePvGXf9W2F02M84opulAGJG2z1CBUSnQOa7bvG1xk9stx9CGC2n87Uul01pshG1t5OSuOdX/evFXJ4isLgoixbqLHFR1ejk7EAvpCsGwPeIJEXxs283uo1Jh9nRJCWhl5ZKO7+5D0B8NLBhEiWxy9O6kJDh1F/Ga8Uk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10) by SJ2PR12MB9242.namprd12.prod.outlook.com
 (2603:10b6:a03:56f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Wed, 8 Jul 2026
 02:25:35 +0000
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3]) by SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3%4]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 02:25:35 +0000
Message-ID: <ae911d3b-682f-4c92-8f8d-d0d667388740@amd.com>
Date: Wed, 8 Jul 2026 12:25:29 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] PCI/TSM: Add relative MMIO offset support?
To: Dan Williams <djbw@kernel.org>, linux-coco@lists.linux.dev
Cc: linux-pci@vger.kernel.org, driver-core@lists.linux.dev,
 ankita@nvidia.com, Xu Yilun <yilun.xu@linux.intel.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260705220819.2472765-16-djbw@kernel.org>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20260705220819.2472765-16-djbw@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0144.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:205::14) To SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB999228:EE_|SJ2PR12MB9242:EE_
X-MS-Office365-Filtering-Correlation-Id: ea70ae63-1a12-4c97-ed9e-08dedc9830f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	/UC464NknXF00aaq3ZPgFokMSMGThTzmA7tMD1jBU05PulEcztgMuZmHUK/rZR4MiDHmi1ol1xJhn2LPMokvo5iENep1iFU39Rpq+yDoFo9LMd8ZR25HMghkoJ/H2Ss2HJ3ElqlisqA/H4vvUSdOjA83btdkI0TT/DxRChOslsbQ+OX9mUm+qVTK7y2UE+Uwl70Ucg3RCfmHyCeiyUrPeGXzWCAuRgRtWG9owBPKRUDUgNsN1gtBM1v4k/OHc1KJHtYmDoxemE07hWmfJZRpqgP5FZl+azuMBwNapwvps5LvWzHwkIv3dk//lUh3KlKaqQQ4ZIJu3KI7FkQ5jgsaMvxRWPrAa39K/vBJfRubc/6BtFBoxrWiyW/c8d/9WOsfpzxNKQXH+xhzGpN/zqJElSJi/PY/G/xQG2bCzfnhtarGq2eVp292CCE3HwEEpnIPUASxNAigAurfAxJ4bub4Ujpn7aMAfqIz/AqS54BOgccGdUBa4xkcNJfpO8sSh63EBkhem3+4HbhzooU9xmp9Msd27pMEuURQeaQN0hxUQApVC9L4JDRx0aDYAkuD0f2Uy9I1CP1APXkLdq/tn5nNCE4qimNZKXUAFV/8iZ/82SUHX+RS0w4zoRjmDaRl1ZVhsBqZ56NMfhU8/nczFrBBYoR/1a2DUJSHm8+t/zRjOFM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB999228.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q29vUGJkUXBpd3cvcXJ1eDNBT080VEhkdVBQUE5lTGx0OURBM0lTVStJazIz?=
 =?utf-8?B?OW9pT3dQYjNjNEs5ck5GYlhCajdzNEw5Z3hFbWY4bzl3Y3U4WTlxVXFzQWJl?=
 =?utf-8?B?ZWRUUldKcjRtVnJNS01WUzBidmNLZGgzUEp4a1RCeFEzU0ppVklVajJrMW80?=
 =?utf-8?B?NWxHd0YrRS9kM2RjMjlzWTJDcW1hNkp4dzVHVkFhY0RQWHZ4NEx6aWpoRnRG?=
 =?utf-8?B?YTl0dTBHVFVFeW40MUZyKzBEYWVzcGRoWS81ZTg2U0Iyb1pqaEJRNW5BdTZY?=
 =?utf-8?B?eEZpOGhsSUZGODlZVHJFMHFjWU9Mei9RaWxZOEJRakY1RVlHdkFiNnBCQ0Zv?=
 =?utf-8?B?K0MxdjdXbGpjTVpqWXl0NWdjcHJ5ZnA4emEvWEJkKzZsMXh6bjJRcmtIa1Br?=
 =?utf-8?B?ZnNHYUcydEJqc0xoYW1XOWZWNTlTK0dqVkQveGhpakgxL0NqajRzeTJxdkp5?=
 =?utf-8?B?QlUvc1duc2dLVlVPOTFzL2NGeFBLUE16YmdrdmI0K1hIb3ZYeXllVlUxdEEx?=
 =?utf-8?B?ZlhaMFRLRG5zdXJqeDJIb2dtdjZ5eW42aERJelpza1RJQlI1cG81Rys3NndQ?=
 =?utf-8?B?NnQ2aFZkQmFRTDNwWWFMZmtPbzg3Q1pQSHoxU2ZyU3pqNVpFVERKcm41cXAz?=
 =?utf-8?B?OTlGcUphWnV4YWtUaGtWa3JxQ0J4RytyRmZBVWk5Y2NuRVBrV1V4YUNBMXNz?=
 =?utf-8?B?Rk1PellIOEtDNThJZGtOZGQ5ZnFBMncrTENDOC96S0U3Y0JRc2xzWkd1dUhZ?=
 =?utf-8?B?M0VnRGdrWitINFZXeUFIMUowM2Q3SnhlM2dCbVZjNGxhY0V4YU1lM3Q2bFFQ?=
 =?utf-8?B?QjZla0tJV2FXWUh1ODREcDJnZlhFOXRhbDVidTBCM0Q3RUhYbjBvbzlPcGx0?=
 =?utf-8?B?ajF3Vk5ZenN2Q2Rna01rdHg3blhTbUpJRmgwQ3l5RWJ4M0tyZkxvTGRXeUtI?=
 =?utf-8?B?a3Uyd3NyZVpnWnpNVzltMlVyV3g4NjRrdGV4emQ4RjVnbjNncXl3Q3hTVks0?=
 =?utf-8?B?M2wwdHZTaFdtSGM2cm4xYm5hWTJaemI1REJhQ3ZnS3VjNEN4YjNqU29MRS9X?=
 =?utf-8?B?ZHA2alE0UUQyNWxYTGliM3FNaEhlc0xvQ0VTUTM2SGp3emJSa1FwVGpqQmdY?=
 =?utf-8?B?Mmk5N0V3a01PeGpzU1NzMWdGYnRocGxKc2NDZWtEenVEVUF5UkpUaWpuWWpm?=
 =?utf-8?B?bFhHaHdJb3F6TFhKaCtzbW9SU0RUQk5oOFdsamJDU0ljbGZSQTUwOXIyQkVD?=
 =?utf-8?B?NTdGRWxZQVp5eXlxMEFzZHA2VDJtTVh0S1VWT1E1bHowNVd6ZkpaM3Y1WHlY?=
 =?utf-8?B?K29hU2tnVWdZaHoydVMzRTkxNXV0dHhpRmtWYTJmS2w1UVF4VGFBbE5jQXlZ?=
 =?utf-8?B?c0tkR2ZEWFZyaUs5RXg2TzJUdjByQjhRb1ZkcWlxV1RFMTJOTExqUThHWTFa?=
 =?utf-8?B?RkdmbytkOVlCWFdlckJZSDdWalFFK2ZSQWlwRUNqRGxXalJFMjN0T1QyUkJ1?=
 =?utf-8?B?QWI1WkM5NTBFMHhodVFkSmpIeXduS0dZeWQzZzUzZjdOWnVCL2dyRkpyMTJ2?=
 =?utf-8?B?YmczR0d1WFRyZ0FjM05WRUZkb3VxeVB0eE1NZ0FiciszMmgzM25BT3NmTlMy?=
 =?utf-8?B?aUF5YkplOUk1WEd0ek5FTWlDOVZlRy85eDJkdWV3REY5ZDJ3LzRyaUVudTl0?=
 =?utf-8?B?d21MTFNaWlR0RCsxQVozWDlYTVd5YS80SXpJdUpGYTRnOW9ibTkxcVFCYUZP?=
 =?utf-8?B?UitwUVhtUEdVY2pvRzFwbitjNmlwMS9uUE9KZmQ1WXdta2o2VGUrUDF1ejVF?=
 =?utf-8?B?UitxOHBXZnZ0R21sNi91cEZwQ3MyanowRmdoUWl2UDBUaXZRVVplNXNIZkVS?=
 =?utf-8?B?b2RzVE9ORHkwTW9McS9jcC93ZzJzaTRaUnZCTlJ3Rlo2Y0xoMmdmblViaHVo?=
 =?utf-8?B?blBJK1FYSHFJUlFyNUZuNWFFUFpHYkhTS0dvdlFSTHV6WUNrVHNNbHdNQTlK?=
 =?utf-8?B?amZ0bnl5MXBYY3YrTmJ2WE5oSzlRcmZ6Q1hCVnV4ZUVoVlFDS0RqV0tGTDZa?=
 =?utf-8?B?NDRkWHkrVlcwN1lJM2ozTUNMNXJ0b0FEQ0FIUUZ1RjhxRFFQTW1GMEFFQzNX?=
 =?utf-8?B?ZjBpOE5aTE5taTVkZ1RxR0Ewc3lIdU9wM0l4MER4OFUyTHZPZlpURFA5ODcw?=
 =?utf-8?B?VWZ1eUY3UDFIU2RHL2ZoOFQ2Qk9nZlRaaVdYMlFINTcxYnBGRE84ajF6alpz?=
 =?utf-8?B?SE1PMWd4MkdnYzhSdGtHck16M2xZOWwwVVNQdy84SXd6dGY0ZUdvcGZmR3lm?=
 =?utf-8?B?ZzJOeDBxYUtVZUJDeitkRmlZMkpubm9wSk0xKzNxNFJjWlBhLzNiZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea70ae63-1a12-4c97-ed9e-08dedc9830f0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB999228.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 02:25:34.9707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5JvBtBtVU+15kqwxccgLOrWZhBSM/1mHJJBxYaYV1l1tTC1F2SRArnQ3c+sviFvD/5c+IF40iS6ioZzumSiNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9242

On 6/7/26 08:08, Dan Williams wrote:
> The RMM specification, DEN0137-2.0-bet2 section A9.6.2 "Realm validation of
> device memory mappings" documents the expectation that the
> MMIO_REPORTING_OFFSET chosen for TDISP Interface Reports is always BAR
> aligned.
> 
> Ideally this change is not needed and all implementations share the same
> expectation.
> 
> If this semantic is already shipping in production and/or the PCI-SIG
> clarifies that an implementation can hold this assumption then Linux will
> need to ask the TSM drivers for this hint.

We are changing it on SEV-TIO such that the host os calculates the offset to allow TDISP_OFFSET_BAR_ALIGN and passes it to the PSP during TDI_BIND (==interface start), others did not need it in the first place so I guess we can drop this one. Thanks,


> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Xu Yilun <yilun.xu@linux.intel.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> ---
>   include/linux/pci-tsm.h | 15 ++++++++++++++-
>   drivers/pci/tsm/core.c  | 14 ++++++++++----
>   2 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> index 6d5fadd79360..be9f78ca2c1a 100644
> --- a/include/linux/pci-tsm.h
> +++ b/include/linux/pci-tsm.h
> @@ -296,7 +296,20 @@ struct pci_tsm_devsec *to_pci_tsm_devsec(struct pci_tsm *tsm);
>   int pci_tsm_mmio_setup(struct pci_dev *pdev, struct pci_tsm_mmio *mmio);
>   void pci_tsm_mmio_teardown(struct pci_tsm_mmio *mmio);
>   
> -struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev);
> +/**
> + * enum tdisp_offset_scheme - MMIO_REPORTING_OFFSET assumptions
> + * @TDISP_OFFSET_BAR_ALIGN: mask by bar size to recover offset
> + * @TDISP_OFFSET_RELATIVE: first mmio report per bar is bar-offset-0
> + *
> + * A TSM driver may know that the default TDISP_OFFSET_BAR_ALIGN
> + * assumption is being violated.
> + */
> +enum tdisp_offset_scheme {
> +	TDISP_OFFSET_BAR_ALIGN,
> +	TDISP_OFFSET_RELATIVE,
> +};
> +struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev,
> +					enum tdisp_offset_scheme scheme);
>   int pci_tsm_mmio_free(struct pci_dev *pdev, struct pci_tsm_mmio *mmio);
>   #else
>   static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
> diff --git a/drivers/pci/tsm/core.c b/drivers/pci/tsm/core.c
> index 9ac216ad896d..19ad35f2da4a 100644
> --- a/drivers/pci/tsm/core.c
> +++ b/drivers/pci/tsm/core.c
> @@ -643,13 +643,15 @@ struct pci_tsm_devif_report {
>   /**
>    * pci_tsm_mmio_alloc() - allocate encrypted MMIO range descriptor
>    * @pdev: device owner of MMIO ranges
> + * @scheme: allow the low level TSM driver to hint the offset calc scheme
>    *
>    * Return: the encrypted MMIO range descriptor on success, NULL on failure
>    *
>    * Assumes that this is called within the live lifetime of a PCI device's
>    * association with a low level TSM.
>    */
> -struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev)
> +struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev,
> +					enum tdisp_offset_scheme scheme)
>   {
>   	struct device_evidence *evidence = pdev->tsm->evidence;
>   	u64 reporting_bar_base, last_reporting_end;
> @@ -712,10 +714,14 @@ struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev)
>   			last_bar = bar;
>   
>   			/*
> -			 * Determine the obfuscated base of the BAR. BAR
> -			 * offsets are never obfuscated.
> +			 * Either the first range per bar always maps
> +			 * the start of the BAR, or the reporting_offset
> +			 * is BAR size aligned.
>   			 */
> -			reporting_bar_base = tsm_offset & ~mask;
> +			if (scheme == TDISP_OFFSET_RELATIVE)
> +				reporting_bar_base = tsm_offset;
> +			else
> +				reporting_bar_base = tsm_offset & ~mask;
>   		} else if (tsm_offset < last_reporting_end) {
>   			pci_dbg(pdev, "Reporting ranges within BAR not in ascending order\n");
>   			return NULL;

-- 
Alexey

