Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013061.outbound.protection.outlook.com [40.93.196.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D7E1946DA
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 07:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772523453; cv=fail; b=sXUGYYFeI+uuszkEEGQvgxl49hkAj7ulSkpDoGgO5HcCusOl/TiyHArMgwO98sRRRbdZTZ8QLsVKBWZkFPg4QFbpH/ncNeDOjx2yRtQtH0ec6YuR7FcJEbJ5xkLK3C7AQ6WT6hXum3/5v23I99qUJ3xG9uXvdYdkN4ThrUSNPRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772523453; c=relaxed/simple;
	bh=SKKIr/XWFXt+ycOrVhs8H6tv9R4UHYpdQVzOpPq+b1c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cobs7uwxueRKyCeOZ59cCy+R7RyRrJNuYnlKrBYjNde2FTEwOn0nVjTPsNKxzh7TcS5UhW9Nzco58nO/wkUodUNk0Vp2TdsVHURTFT5h7ZXgW+wYctCbyC9EEIh5d2nW5XLuTRjB7gUgTnUwwEcL8DitHJjvROwR3FZLqMZdaIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eE0f+Mw3; arc=fail smtp.client-ip=40.93.196.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eE0f+Mw3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTDI+spNx9NENuCK3wcYqP8nL+HpxqwIMGb8CIrMqldl6PQhxXENDW0GAJpF5jgJXrX5I663wYGoda5svYoCwJsfkFQdEMGdp/BGdBfl6Qh2YGKjOQKWDR10+uvoxw4+FhcwclJMEU/ulZhn7WCjcrKEe/tMUk1L7hTsUegHL43jCeYjyzVVrEeasFkSUzYjojdm2MXTqro9VasbiEKgzwaOuq2xbAKTJ1cvmVp5cLXcbjWSZEJXMArlI3o0/9I8qwFMnVk3usrU9DAhNzbqIuAD336026ecqIOvW+w3nUC1pD811QaVM8UdcFaEWBOK5FQwDrrl6nVaBvWMHaBoZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCOY/LDl2C0ugokTlQLKG1iNXYxQN1txQDp9SfDCYTM=;
 b=Fj9efwpG0sOHKyHFc285QfKFqrGqYKriAMY8ZwE28F4vTqzhjgFRiCG0np4O77p+2X/q3ktsYvKuS8GwfBLgM0UHQu6eLNxyN0/ZNHsZJizU85bF1Xeq2/5QcqnOywfcp5ECQ5fV/HFEJYdSo6nBE1jFfkSBZea23cMWflc+XTt5f+/Zcs2fOVQ8euaqCb1Qs6GNrULW6/1bmNrg20tOfQkC6lEqCJZeIZ2vLLmaLXOvkr0xM3ozBuw02Sy0KiMLHB3cZRGFf36GXlg70xmuLM1K+sCgDE518trEYBsi2JN0Zlhkd8nkAM0eQ8DIsO+GUE5Nz4IWPh9bgspJyuqteQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCOY/LDl2C0ugokTlQLKG1iNXYxQN1txQDp9SfDCYTM=;
 b=eE0f+Mw3T7ssY2JZKgh+QaUSAT6mDUCegm0WiF5dEFzT4oHgmlDRkIWWNb5tZKaKkt+OziUt8tFijv2o563rJOWvpHdDsT1dRbpciCMJB5lAy3qndtr/BKuNiIrjN/lSGnV9sibU7HowYWd6yWzcksWgvTl/z0k20WYmCahI4GM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by BN7PPF9507C739C.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6da) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 07:37:29 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee%4]) with mapi id 15.20.9654.015; Tue, 3 Mar 2026
 07:37:29 +0000
Message-ID: <3f36f3cf-64fa-48f3-917d-d5e3453d3453@amd.com>
Date: Tue, 3 Mar 2026 18:36:51 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 11/19] x86, dma: Allow accepted devices to map private
 memory
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, aneesh.kumar@kernel.org,
 yilun.xu@linux.intel.com, bhelgaas@google.com, alistair23@gmail.com,
 lukas@wunner.de, jgg@nvidia.com, Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-12-dan.j.williams@intel.com>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20260303000207.1836586-12-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5PR01CA0108.ausprd01.prod.outlook.com
 (2603:10c6:10:246::22) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|BN7PPF9507C739C:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ffd89b-2376-4763-2735-08de78f7b931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	sVYic28u5uWVo5ZyDEyNe9CM0n0UnHBvYtzXQM3AKCOZqSyVBfOc5DNzaDJiR1sP2NpvfOlUMdJLT04t9CGpnyaXh6bs0wsWf7vwpnBklXnaIjzY0CQW0ubThOq84vMYVYG0lt6w9RV1wNe1w6Q7bhotTj3WJ26MVsPTPQLNLD+RhDCg9OcoQhXmcgyyxyl7UGxkQN8YjVYGhWZJjMAmk9FJpblHcxONOwPtWN7RMWs0meGSpWihpZp+LzejGenL7zfdlog8iB18irmcnzgVhNbjJ9cR50TxByt+TXAr2/OBAQ5wGoJiuqvQ41D8QZk7vnJJJ7rUywB8PPldoYa78KdYfZuznlebalZc35GdsE+VtPfKpSkMiC4pmgvWayoF2JrdkMZ1Fd2cXA0yuB6d2xH3t2nCA1FOQc6I/ECy9a+ol88hNYmWP62tudNzq9rjWrN+HEVacgTSTaB0EWko7FmfGIyG7a/JM4r6XYa2GUonDc/h5AHkeOYKwpr98bqwg9V+LW2Jl3WyQcr+YLarVqkFr10P9hp3k2Nt7tECTOjnyJ6R6+8jaOrVQDNrM1o4pGQmvLSkkOTyf0zb7/23Ww8uMybhezp+rDKl4ItfpirZaCzImR5QZnWnvnQ3+fr42tQMV6TwqA28xZwzcE72w7NGvEF2HF8vIOVi0EYC2QlJ8giK3IeC74jcWgPM8B6W1fWFspF+7XyaSPlnvm5C/IVOf46XKdgl8CecTG/XCPw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzVLNUVsT28xTlAyeWI0bjdKcnp3Vy9wS2VBTDdSeFlBU3hnUStoUm8yb0hC?=
 =?utf-8?B?QTA0RVhnbFFoVHVRcEd2YUFLMjNDcDF5cHhEVmo4QnJUNVUvdm56ZmdQdW80?=
 =?utf-8?B?QlNLS09WWmZQRHNmNW1nV3RDcGxPTEd1L1lCM2ltRDNwL2tDUE1JZDBIa1lL?=
 =?utf-8?B?YUNRZXFYWWhsYnRPTUxCcEdmL3dEa1BHV2w4T055bjQ4QXUvelppUmNyeUZZ?=
 =?utf-8?B?TFo0UE9KMzhtOXlHZmVqRTlTRXRwd2NhanVENnNZQVFiMHhFblRRc2FVem84?=
 =?utf-8?B?WVVZaE5uNW1rcjhTVWhaTVJGcHlGNGZFejRqNmE4ZTBMdXdibVViUFBqdnlt?=
 =?utf-8?B?RU5xUVJrZGYyam9Wamd0bllEMmJpK3ZLaDY4NVVWaU81VnpMK0QvRzVwRWRt?=
 =?utf-8?B?QkZ5b29ZL0dybm5rVlp4MGJGSXA1NkkvekFIdVYxVEd0eGppQjZHN3crNTNz?=
 =?utf-8?B?N0Fmb2d2c215THptaExCWSs2dTZQUy9ZcFh0cVQ3VU4yY2lKS0xNOVYrRkRV?=
 =?utf-8?B?Q2VHVkpVbWZHTFhEN2RweXRMd1dDellXdFJCMzlUVHM0bkFPNnBUYysvVWtm?=
 =?utf-8?B?RjhvTHhxZ3lDS3p0bGdTNmF5a01ZYnNQd0lTaGxPSFU4MmJSZHFNM1gwYjh6?=
 =?utf-8?B?WEhadGY5RTVDTi9NaGhvQ0ZZYkZoL0NXb0lzNG9YcGU5MWxucC9JaFhsOGpJ?=
 =?utf-8?B?SEt3bEVyZWUzcWJFVHA3UWRVS3JISmM2K3lRTHZvRjREQ05XM0ZZMHhHSnV5?=
 =?utf-8?B?eGJTSjQrVTJ2NncrK2dyZWRqM0ZWRHpSd2FGandCMXM4aUZKcWN6WndjRDIx?=
 =?utf-8?B?eGs3dHduaUV5TGlTODdiZWdxSTlxaVBPeG9qOVBBTy9sZmhzbEpZcC9UQWps?=
 =?utf-8?B?OFNaOExBelNMUE0zeFVmbEs1am01bFR0Qk5RcFFqRVlqSEJJWVNGQWg2RmJ2?=
 =?utf-8?B?L1NFcDF0cFY5U21iaUFpQUF2YmkySjBaMXZnTWd2MkNteThQVkxrb1M2dlhD?=
 =?utf-8?B?TEVmcWo1ckNHLzZnb1dRZmxTQ2NhYktSbHJ3d0VOaFZNM0tNbGlnaEJYekxm?=
 =?utf-8?B?bGFkRExOc3c0M3puaFZGSndGOTl4NlVycFhpbjJXS3o3UkVaY2E4K0taVmFt?=
 =?utf-8?B?U0hDMGlZaUJBK0JrRjd0ZmUremRCc2UyUWNzY044elpiY3p2TFpqU1lyRm5k?=
 =?utf-8?B?YjlpbzlzeDV4NUZrMDBVNFdpZ2ZJZllTbVRwQzViQzlsZW9rZWtnb3JRYlhx?=
 =?utf-8?B?c2xBUHg1OWE2WmN4SlJlN2xFajFrT0FyUTBXUHZTQWdZM3QxWExOTEhsNklJ?=
 =?utf-8?B?RXNncEc5eHR3cEExelB3R2p2TW5rSVlIN0ZXQVN1SGhUdm5VNTdhbSt1Sis2?=
 =?utf-8?B?cWYyRGlMbkJHR1BQRWx1a05zUGFobjZqWUxWSWFRUHJLMlNzSmx6eGZscURN?=
 =?utf-8?B?bENhN01jVHRsMnlrOENpaHc4VGRDZy9QSjAwV2Rub3lLVFdEY2ViWCtnY3Ju?=
 =?utf-8?B?WWRyQmk3SWRwKzdWbjdrcHNWZFg4N3VTNmdiazhJSVczU2pOcmpJRGMxcVFT?=
 =?utf-8?B?Mk1maVM4cEpkT3Y2R0trSk1XLzBDNi9CelFwS3RBSE9tNHFHQXJOWmIzcklL?=
 =?utf-8?B?bGM2aTRLMTRyQjdzamoxdzgreW9uN2lHMlBiaDY0ZGdnVWJxMVBVQ1ZBQ2FZ?=
 =?utf-8?B?ZnpJTEh2OVgybVVKSWpCTDgxZHhJeEc1NzREdnVDeHlXazNCZ2gwTVdxNEVJ?=
 =?utf-8?B?WHdtLzlSdFZOck5yNHByS3lEaVJqNjk5T3lvNjBFVjBGL2xJbGNISVIxZFRI?=
 =?utf-8?B?RXJKWS9UT3BKdnFTSE9uM3gxejNrREtSR2h6OFVKdmJtM0tOdDRXZlJHU1BW?=
 =?utf-8?B?L0RLNVFvODh3SXNFdnRRNnlWWlpGSU9jbGd5SGVESFJ2eElCR1h6anZnV29Y?=
 =?utf-8?B?bHloc05GTGJmb0F2WURTcS9IZHF0S2FmU0dQcmcrMXlRU2JUZUNDUzZzaVlY?=
 =?utf-8?B?WVZMSjhaZlB6bUluQXdOVmpBMWFQMzBrb0IyVUkyWUhzV0FHTjVuUVliSjkv?=
 =?utf-8?B?dHozUHFUeGVnNjZISGR3MTBnQjF1NXlDRGpVbWVkc3EwRUNtVm9DMnhDdGk5?=
 =?utf-8?B?THlVMEtEQ096YzlwNmZKcE5CZWJNMmdaVG55eCt1bXBMMWZ4S2JlVFZYaERB?=
 =?utf-8?B?N1U5VE1zQUt6eHFZZVZFOVZYMlc3T3NSL25QUm5NdEZTaDNvZm9Cd0dmN29y?=
 =?utf-8?B?RjA4bGxrM2NWT1kzRU1VUVRuYU1oeCtwZDliVjlZQnhFVXhMRVJwejBjcHZr?=
 =?utf-8?B?QWllSEMydVhqdE5UZlMxcmY3UHdGSXl2N2tHOWlxWjdVQUtlWUJidz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ffd89b-2376-4763-2735-08de78f7b931
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 07:37:29.7225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yra9/B16w6EMvV3tO2XY2qOwRg6jAyzHcFsk7F1KbF/lvrrcyP3DowoP/JwygYuEmdEAmUY11PjTyMr0QZgt8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9507C739C



On 3/3/26 11:01, Dan Williams wrote:
> With the arrival of "accepted" devices, devices that have been enabled to
> DMA to private encrypted memory, coherent DMA allocation no longer requires
> page conversion. Update force_dma_unencrypted() to skip accepted devices.
> 
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Alexey Kardashevskiy <aik@amd.com>

> ---
>   arch/x86/mm/mem_encrypt.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 95bae74fdab2..6d2972ff6ed8 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -20,10 +20,11 @@
>   bool force_dma_unencrypted(struct device *dev)
>   {
>   	/*
> -	 * For SEV, all DMA must be to unencrypted addresses.
> +	 * Require unencrypted DMA unless the device has been "accepted",
> +	 * enabled by a TSM driver to DMA to private encrypted memory.
>   	 */
>   	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> -		return true;
> +		return !device_cc_accepted(dev);
>   
>   	/*
>   	 * For SME, all DMA must be to unencrypted addresses if the

-- 
Alexey

