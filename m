Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010035.outbound.protection.outlook.com [52.101.46.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CBB37CD30;
	Thu, 16 Jul 2026 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784219316; cv=fail; b=nls74CeLlSQ6ydslH3N4ESCtZTl10ttEuJL/l+IuVZtuXlqUaRvuWsJ29ZGlCEzWdmgvrvA26O8N1yNfM24bewNaNbJUEqqE9HWm5m3LDrNyA7ajYC8YoaoQ79jPz/4VqvTfteAbqYcTd01aywcFxpKv0VABqDjImhpvapPP1JU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784219316; c=relaxed/simple;
	bh=RUF1IG8Dry/ZQyfpdMXnb60C81rkYoJIghdBlU71fNU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qqaVHDxjlJM9sbUmJP1FgV8gew8TDlcmqRZ8RQJTNdW2exTvNzk6bY8VJWEbcLXBDG1AimXeXm2EnawfL2B6QZzK548vkD2HofCoeg19GF8zLWr24rlfFWBdcnbuzy43/sctF/ob3+LyCJZR9Qx48KpuHZxcgOoyZuktMEDIhkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NFBb2NZR; arc=fail smtp.client-ip=52.101.46.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NFBb2NZR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wdgyBz0VLO9gRcbo5FtZ2vdGR2E9DKntNcvtQ6mEr3aXGFSf7JpJ5TarTLof4+ikcLhyixbwqNTPulyaxRWyJ9ClNFE5MbPNYFFytLc4uvNyRglRichFhEPohoaunReM5CVzuxdQYwrsu+bVuY518X/WYZNC4+sjLQhlB26SAxvzCm+jZj0EV2uQNtW4yENrBKrnUeRKsTQHXT7blawjUwv/nt2YD2AH+8D7ZppaT4ehlHvnuf8JkGNOJ9QQgp5dpXUmxU0FlEpgOpnvEhlOWFLegjkwZHjQcGVnH9TxhrwW4mOuCT8/DQLXLQr+EwKDfgzNiu3cEcXoa0JgJR8l5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xIBS4kt4vKU5Hob8FhY5Xdf5jhn3HDw0C9alSf8GBs=;
 b=iZghoRjA/EjxedMPE3LibD54rSLcaRYKPFMzoNI55v3kb/jRyw224wMzIYfcf7dJt87EuK585uWmJaC2yrfDT01n7xi384TTCTv/LoGBDVCc3lqf2o4dW94KYTvmTUntnsmFFXL1J8Wn+UHd7rL5lUDR7xIVsWkQDcbyF4VQPK5D12rDp7VvGqlZJncU95/ZzbzxJWbN7IlBEgEZH1+aNB/hERoDgvblootDwsH8RUc8hhG7wjhuOrzx8L5kN0GZ+pWa7awY4jbIhGRUMDDLQbEUswn9SVaLPux4tcidSx+XJu1Pt6Sz9O1mGCYTVZwz2Ztyzrxe9JM0Kw9hploV1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xIBS4kt4vKU5Hob8FhY5Xdf5jhn3HDw0C9alSf8GBs=;
 b=NFBb2NZRgJ0wUoRsAxN6k65wY6ijaIMWINh8bI652OulBrA/NI4P0EXkMNAxPU3fGRa1tCkzu/7PWqauzVo+RtimR+nHF29riFP9qTG8wtcoKLmlHko46e9jljf5soumn5opRojIOe0+n96VHoUzYmn/a/GuDF5zEWUFBDdA5eg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 CH3PR12MB8459.namprd12.prod.outlook.com (2603:10b6:610:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 16:28:28 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%6]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 16:28:27 +0000
Message-ID: <a4126800-ad21-4864-9de3-313385d6bcbc@amd.com>
Date: Thu, 16 Jul 2026 17:28:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/11] Documentation/ABI: Document CXL Reset PCI reset
 method
Content-Language: en-US
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com, Dan Williams <danwilliams@nvidia.com>,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260709010304.680422-1-smadhavan@nvidia.com>
 <20260709010304.680422-11-smadhavan@nvidia.com>
From: Alejandro Lucero Palau <alejandro.lucero-palau@amd.com>
In-Reply-To: <20260709010304.680422-11-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0176.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::16) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|CH3PR12MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: 7392cd1c-7238-4b85-219a-08dee357440e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|6133799003|4143699003|11063799006|56012099006|22082099003|18002099003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	ojBqBrJ7nsXHKh2tAxn/V48vi0Rl0/B1/wly46gh0jb5iPRWHmR0J5vBn3QhWgxdSgvf42f7sKBptTOlREMO9kSzlpkrT8jaJ6te0SSiwu2deE2+PnWu6WaZJyWX2T0rA7ZKQsfdF2Yo9WVnYrgTR7QDRzxBfdNYUoc+rmkwFki5Ah9XtzRqXRMZxhklp4gMS+OKX0RJNcrHPv9Vm32dc68TbUhqq6/CxBJwXz76bYA1iW4gC+Or/UdCHZ3F5k/2//75ilzqFNU3AJIAAwkNcU1nU2PU7gyMshZzj3XiJFjqUjIGw1ZCKLNDCjKwQUIU4DSvZOjN1rmTnkzFaDCPhDFO4GvutwVuH1THxl+VoKssTcq88BLae36Ax8PJxxJ1csUJNLNq+eQfOBUhOm/lCG05FPYCte8CdB/01m+Y2TtFUHmE7zBxxmiU3uzvIwm8kAkV7KqUgCWl36kzSqre8ZFkgmRLsQ6jB7PubaeCezR45A92BkIpfPynKHBito0a/cGszjiwwEFk5lYyCaRGNNeiGw4ZXhRgMNezt0kKu602ExJcxird9nF9iErBhb7eGl1gVJ+kLPJ6S0XX0oq4l9vguAFRXKsuNH46LfrMlN6WNW1OzXbzY6BkgST5LZvm7DS3W9cED5KyLDxmBCGGgEl38fcWsure0V5jx+8gDHPgfx4he6Ziw4zQyDEEspKHZXEB9Ed7+KWfF6NyF8xuzw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(6133799003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RE1xOHhmUFVxNmtWclY1ZEhKRkdnMTNaby9JZFdSUjh0YmZTVDYxUHJvYUIy?=
 =?utf-8?B?MGFhZmZrbDB3UFRXMTdCZ0daeXVPVkFjVjUzNTRnZVRpaVBOT3B1TGJSNkt3?=
 =?utf-8?B?ck94dlFJc3I5d2JvOTQ1bHhncFhtU2tDR3lKOHZKd0o4a054SjIxNE45ZXR4?=
 =?utf-8?B?ZXRUQWtBRkdaSDlQdnlYS21mRmxvRUF6SFI0TXlKMFFIZUxLNllFL2pwa0ZY?=
 =?utf-8?B?V2dQSmdla1hKbVdTcHJna3FaTEtpSEtCYzc4WDdNd24zNGNoQmpUSWhmTWhX?=
 =?utf-8?B?dDRwUHdFY2pYU25YTUJQU1NiK3d5TWlKeW5IQlhpUFh0TlBoMXBsZVlHQjR4?=
 =?utf-8?B?NU5WMVVZYVpVakJ2Q2hvZVZrM2t3Z2RtQTl5VjZZdlU1WkVLSm5sOXNoMm1O?=
 =?utf-8?B?Wk1oNEp1RG94OWxpcDB3bFIxSDMzNmV6WHhBZjVmVFBzR0FRUlpqekJVYXRl?=
 =?utf-8?B?RW5tSlF0Qk1wNEtjZ3VIcmsyYTdOcDhjbDVpTUpMY05TK3lFT1F2bUlsNzdm?=
 =?utf-8?B?S0FIZmZ2dllNUFdHYWV6bmozQ0k3bi9MbE5PMVlZTjFOemx3ZFEvRWQ1R1RU?=
 =?utf-8?B?b2Vha3FKOVZ1ZkdXR1ZQallrSmhHMGVmeU9lQThQczlCbktmTFJPZU81N2dT?=
 =?utf-8?B?YzIrYWo0NWdGSCtHbmVTejVFNWtnT2lFdUo2Sk1wdjNBRTlHemtteTQ2a0Ev?=
 =?utf-8?B?aEVuNWVLNElUTXc3QzNKcy9Rc3hDUkNpT2JiVXRNQVJoWjY2LzIwTWZEQ3hE?=
 =?utf-8?B?N2lBaTA2YjhJUnR3RWFBMEtQSVYxcmRpZHRTZXBneTVBVzZTRXQ1WU0vc05G?=
 =?utf-8?B?ZHVvQUNlOEt2d0tkbDdUdXV6dGZJNW9kRWVSbmNCcjlpQmpiRGEvZmlJQWZU?=
 =?utf-8?B?Umt3N3NaUUJwRWVvMWxyMVIydmVra3FLY1pQbDVYUlZDZFZDakNqRHpVTjYw?=
 =?utf-8?B?NGg4Mmt1dis1b1FLTjRzMGZsdFdkYkZLQTN2MXNyWlRKczh0akFTWVpiek9m?=
 =?utf-8?B?QU0vQTNnNnQwT3FtNi9KdGx2bHdibUl4dzJqMHQ5U2xHZXMzSTR5Zi94QXdx?=
 =?utf-8?B?MjhCaUpuTk02eC9uRk9QdHFVdUF0V0N4VWZQVy9COWdxZ3RSMTRIWkc4T0FJ?=
 =?utf-8?B?bjlDWkJybmpZUFRRa2V5OXoyZnJWejk2OFZ5ci9aaWlidDNCdUhSeEhZaEJ4?=
 =?utf-8?B?a201UHFUNU5EWmprd1h3NHhGbVcwdkdGczliSEhreWZFd3ZmS3lMNGl2ZlNa?=
 =?utf-8?B?eXBLZDJGYnhNN0VYWHRwQm9VRHdGdm5MUUwwbkMremt6SGEwRmlzMnY5MUtD?=
 =?utf-8?B?NC9CVEZvd0tRSDZVZEYwSllYa2R6R2RBNmxKdHdIZnNBdGc3Y09Va3lRUDZh?=
 =?utf-8?B?WElNdlRlVG1Wd1RJbVJ4TzFrdXJpdllHSEMxUDFXd2pkeUY4MER4ZGljc0xy?=
 =?utf-8?B?SHVtVDk0MGZseVpjamJNdk9uNVRBY01MclBaQXBNUkN0WWlETkVNdEMzSjAx?=
 =?utf-8?B?VldTL3BGME4rU0h1bWNFQWFpeXZYRHJNY0FGUkRPeDRNMTFRdml5UERFRnlk?=
 =?utf-8?B?UzUrNVhwUmMyZ2Q5ckFKRndKNDJmL0lPNUlzUUlBKzhhcUFtcXN6Ym1reG9I?=
 =?utf-8?B?Vk9TNVV1ekxhL0JCM0dOajEzdFZvZDE5d0QrY3Q3MC8zb1gwaUVLa0prc01Q?=
 =?utf-8?B?NjR6V3EyUStiS1cyZngxS04rcHhkeG1EZVA5TzFTNER6V1BJeDBOeGZxWDFY?=
 =?utf-8?B?cHZDNThicW5QRkZKQ1JIQUtxQWorTVBuM2JGV0htOXMrSW0rTnVGMXpzSEMz?=
 =?utf-8?B?OXNvLzdBVnQvSkY2ckN1WUlPZmxFdCs1bWVWbEh2MFRyTHNhZDZqM1R0ZnEr?=
 =?utf-8?B?Z01uZ2NIRVg0S2hOUmtDUDNDSmZzcVRJNU55eEZXVlloMXpZUzNkY1hicjNZ?=
 =?utf-8?B?cUg5MkUyWUl4VGQxa0tORURXWHBzSTBudTViamtDaHNyZXM2SjU3TVNzWlZH?=
 =?utf-8?B?b050dkJEZWJodmpnRWw5b2dzMGpYMGJmM0RZekx2b1NDVUtlZWxGNm9PbG9r?=
 =?utf-8?B?b2w3N3BzdldtRWkyZ2lwenZRbkp3K3NoV2Y3VXY3c04zdHBCS2xFZWFkbDJx?=
 =?utf-8?B?TjI5b1VLNVpNMXBtVEY4QzJKRlJPdTBycUR1TEtEdFhkQlRkNEJrY3dHbkhX?=
 =?utf-8?B?eXZURW1WMzFrWnVnV2orN25NaUp2alhrNFIvRmxNOTA4S2NRajhVL2xPZTN5?=
 =?utf-8?B?emVjejM5bDNyK0R1eWRHVitsYUJwRHFCckwzbFRYbVlGd0lTZUNJSXdVeFIv?=
 =?utf-8?B?d09sU1BqRTZFd0NMMDN6ajJPOTE5aTJONFJrR2hXQkFYTTdtZEdKQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7392cd1c-7238-4b85-219a-08dee357440e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 16:28:27.8809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VpbKdilSl2iJbDjV3EzD9dch0VE0un1Lt2io5BvEeyn/x+IBOORFts9jyz125NB4bmgbIhYfLnXcupFUNr4R9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8459


On 7/9/26 02:03, Srirangan Madhavan wrote:
> Document the "cxl_reset" PCI reset_method value for Type 2 CXL devices.
> CXL Reset is device scoped, requires affected memory to be idle,
> invalidates CPU caches, restores cached HDM decoder state, and does not
> request Memory Clear.
>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>   Documentation/ABI/testing/sysfs-bus-pci | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index b767db2c52cb..5ab46a4340ae 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -153,6 +153,20 @@ Description:
>   		"default" enables all supported reset methods in the
>   		default ordering.
>   
> +		If present, "cxl_reset" selects CXL Reset for CXL Type 2
> +		devices that advertise CXL Reset support and whose reset scope is
> +		limited to the selected PCI function.  The method is not listed
> +		when CXL Reset would affect another CXL.cache or CXL.mem function.


Not sure about CXL.cache, but as I replied to the cover letter, this 
last sentence is at least confusing. Only PF0 can enable/initialize 
CXL.mem so if there exists a memdev, any function using CXL will be 
affected ... but the reset can not happen because the range is in use by 
the PF0 initialization. If the reset can happen implies no PF is using it.


> +
> +		Before issuing CXL Reset, the kernel quiesces the PCI function,
> +		rejects the operation if cached HDM state is unavailable or
> +		affected CXL memory is busy, invalidates CPU caches for enabled
> +		HDM ranges, disables CXL.cache, and initiates cache write-back
> +		where supported.  After reset, the kernel restores PCI config
> +		state needed to access HDM MMIO, restores cached HDM decoder
> +		state, and completes PCI reset recovery.  "cxl_reset" does not
> +		request CXL Reset Memory Clear.
> +
>   What:		/sys/bus/pci/devices/.../reset
>   Date:		July 2009
>   Contact:	Michael S. Tsirkin <mst@redhat.com>
