Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010062.outbound.protection.outlook.com [52.101.61.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514771A6803;
	Sat, 22 Aug 2026 13:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787403894; cv=fail; b=MTYI1Fk6kvJ0mrypLjim8drFZZRx4nECSMfucsoVGC28ph+F+ZWEkkcGWG2pidBG/l3iekgqLiZdy0lifBkTCGmBEtk9VzmkRTY6+DVTrTzaEsE0QEW1iv1v12BmLU/CDSTAYroiZmBDgUpxwQAi0Dh+ahsQ6Z4h5ixpqBD0J90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787403894; c=relaxed/simple;
	bh=CY3atTD3LYiX75ZTA3jYHiX5f1s9NdEo2lyKOqqMrbw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=erNUIpPzSVy52dpE9AGz1u0ubwGtoR4cySaxugEzZ7Mj4Fj/uM0TxyF9+2ThhWlrhmE903nM55xgJXD9oLc5BNBLH87ie1wiwzk+quCrszkTg0YVVaiDWcW0EjO0qjgn/PyZRXLeNMFcFda26AyGl96ELAfyzftGnUiH8Qhrv+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2i+GjzML; arc=fail smtp.client-ip=52.101.61.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2i+GjzML"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MG+wEwlNGhD7ZxZYsi8EWGQC22oHCMTYXwd9fposjagAu4mI7921yDIlb6n4sIaZNuBPJ+n5j7TU66Y8flmRB3AWKuIoL4kYbBxuFL+V2m2gAVX8/XvnBb/VRrV3oHL/b+crJX7HUOGuRILiBlTYjZAq7+qPsD2Y4d+j8NcSTQgjfQ+t2fG9iom5gVqo16fdTpA3O5yzNQwkpgBoc6N82Q1TxCQ4z8WtDEHQeWnH5B5GABtbzl/uCDmbgd6wo/BtahE4oPFuJZAUPrpAzY6ktCIV4vtTVdruQd8mtaFhoRdWus4LEu72+RnUWXax5zrnFWwjEdVzfWrOzw1XjMihSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8or9DxoFONvm4LZ7qK0mvgiZnNNoY6oWYBsXVakQa+Q=;
 b=VZF9hYKxclnG2UdN8CCdX3A+gSjgNI5gnSmZjERP/OUknQolxzlfy4RUq0CVTD10YcR6sOVw61lt8xlIYPxDPq19DshZr9t4jrkSWGxVggCFzfDtkBAUe258gtWN5dLE0K+0Cobt1C0KOqHH/2VfU36smNFYl1u+Op7jPHmJQSNF7UtRL86ditQN0Rc+KS4Cg6PtxzW/OWCLy0jpEScOYlVsk7m3NNFh0obocnNxmOXBXwGkejK1rdXIORmIrSWkI7RvfvgCaD3qKjC8amty2ARnbLpgc7/5fikybgKAJDEXw2rCPxK/kdCcFgZcMMR0lFrJRSQYElhGykYDskRAfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8or9DxoFONvm4LZ7qK0mvgiZnNNoY6oWYBsXVakQa+Q=;
 b=2i+GjzMLTEadRBk0FEGRMWYWrUAgIp5BhaEZyPzSZI1+e+WSYvJQwqgzTZ78xd/CL9nV3QBvPHW3r4/ir+y7qRhRhU7VfgfyVifi0difVpd8MEcHv4iYUFj4iG8lqaCcNyH/szdEehC46HyzTmVxmYyaSy9oEk9f4oh9PGrf5/A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by CH1PPF8423FDA82.namprd12.prod.outlook.com (2603:10b6:61f:fc00::617) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 13:04:49 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0339.010; Sat, 22 Aug 2026
 13:04:49 +0000
Message-ID: <ecb70415-05c9-40bd-8ddb-173267a7a30d@amd.com>
Date: Sat, 22 Aug 2026 18:34:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] iommu/amd: Refactor device probe and capability
 initialization
To: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja <skhawaja@google.com>
References: <20260814015647.3370124-1-praan@google.com>
 <20260814015647.3370124-2-praan@google.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260814015647.3370124-2-praan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0240.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::17) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|CH1PPF8423FDA82:EE_
X-MS-Office365-Filtering-Correlation-Id: f287e7b6-bf08-4f12-9900-08df004df263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|22082099003|18002099003|56012099006|4143699003|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ilkYi5iHvPhJ7MewbZL1v1Flr7IXYW2UtMM7PzauUTYbgyk5gKC1uZyPItrnozLFD2jhKyreMu0bZqBZjsHtJPo28rj4816tZEKzug+YKjVH77KdP0HUy4Y4UfaMGBBd/xCCxqUMKqxxCysvRqNJoRfXucYsvpKnUB5lkyUeuNeBcJAv6/+RfNfG40g1bUklGAXRFbGonFHxVe/WnZx8hefzu7iW3niKfJq8nDYsR9jd6l0HXYg6AqlzidQ7hSXVR5x0JxNH+/oZOvLA09l9AhsHmQ89m50lLYR8K6Xl45XW2mtqWzZuC3I82tRF8SA+cy8WT7Q/OMQ+4tHTS0Ff3s+lkEIqSmRUAxk9lwFK8F/zHYCPVKvYz//JOao4OdazApH6V+kSm1BldytFm2wnVNIvnUn0WRTh7370RwUk3Egw0Gn2d6aqP2Mk90kkgWhAe1pBVFcMCjZVXxO8Lo7oWmZa+jzHVzEuizQywb014l68LPLrl4OtSZo4trZTDsZKfjcjP/fsY1GQRpGt2w83tE0zoiBbKbPq+ReMGOtaN8C1FbMDj2Hxwh+BwBAtgzws9sXzcf76PCBxCv0E7GOH6wKha8ZoNj+4ErFsa+r0T+ZITF+pShA5I58R49oeWUiNtoO1OytUcqAf+I8zzvoA1gX+VLNAWdksrdINYHKx0K4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWtkMkh1VkljRVhkVlczaWpCWEJjZkRZQ09iS3ZXSHlCZ29NVFZZb3I4VDh5?=
 =?utf-8?B?VjZKNjZ6ZEFscUdZYWEvdytWdTV6U1M5OUxTS3RSOEhydWxlYlp6T0d6Y3Y5?=
 =?utf-8?B?OGJablhQaXhvQlVtaldTRkxQOFhOQWRhL3U2T3pDNzVrWUpNR2JRTmo0bnFS?=
 =?utf-8?B?TEtSalJ3RXcrcmltdTRuTEVHeXU4eU9KQ0x3OWY1bFlUUzR4amlqTmt0NFpq?=
 =?utf-8?B?QkZSSVhxWXI5VXJSWjNEOGREeXowbjB3K1IzUjdrVW5GZ2ZUVTQva3ZzOThY?=
 =?utf-8?B?dlNiT3VML0FINnJCN2U1eGIvVXE1ZlJvMTVxY1pHV1dtOFlqVDRXZThySGI2?=
 =?utf-8?B?Mm80ekFldzNOSXVMRm92ZXNVaTlxZklXQ2FKNmlPbDRiS0lCbDNDbklwdzZ0?=
 =?utf-8?B?Mk5Vd3B1dkViNmtvUm9BemVjNEd6K09QZW00a1FoZlRrM0o4M3M2MURyekxr?=
 =?utf-8?B?RWxYcW00M012dGgrcm5zOTZSVVRuemxtMUdCak1lcmFmRXN1aHlyK2VZSEZz?=
 =?utf-8?B?Rkd4cFNERXVYTmkwcW1oNkRJd1Nrc2lSekViOWloMEszWDNxS2pldkJKZVVU?=
 =?utf-8?B?NzBzNU9FT2VsM3pOdXYxcjI2cjErckZPS3lvYXNUZERUM1BGWWNId1puQXdF?=
 =?utf-8?B?WDUvc1RwWTBGeUZuMERsdHNyWjlyVFZJVzZqWW04SUZpOG8xZWJLSUQxQnZJ?=
 =?utf-8?B?djl6eHFoNnh2akk2aVN4aStPcFRLeVVnZWw2RUt3ZEVNYXZiOU5ldzBjdUdi?=
 =?utf-8?B?eVlSOVYydnZqcUR2aHNISkFHSVRtNVZhQjFYaHdFQms0K2x1aXZQMmFNSmJs?=
 =?utf-8?B?UHpKOXQya1dBTFVOT2FvekFQTTNFRGxrZEhKck9SRUQ0N1ZCQ1NlK0gxYkVK?=
 =?utf-8?B?Wk55VlFqQ01WTzRGZHFadFJhUzZLcFk4cWs4dnRZQ2FOaExQZXhxRlBaa3VO?=
 =?utf-8?B?RnZsYTNMbzVydTl1bXZFTmJna0pEK2RtUFU4ZG5WNjVDa05pSWhuUTdTZHU0?=
 =?utf-8?B?bFh3UWEveFoyNWNOVEIwb1hsVjAxWjd5WGlHdkppa3E1RmpyYTlzaHZsK2Nn?=
 =?utf-8?B?S0wvdnpwTmhnaXZnc2tMVnVhMWViVzcrSHdBMzFvc1d3cWlwcERnc04zall6?=
 =?utf-8?B?dFUwZFNnVnZWQ1N5RGJGUVFwN0NHUlNCdmlrLzVjVnVhZ0VKNjRXZ1JtaDlS?=
 =?utf-8?B?a3ByNU5VOHIyMWlVQllQREp6MTZJdnJQMHc3VUxCekdZaE9nUFNEUE9QUlZa?=
 =?utf-8?B?czJRQkQzWXM1WkxXbXpnODlNOFhhNW5qZjBkRlp3YXlSaGQ1TTlzUVhneFp1?=
 =?utf-8?B?R0JBY01nMjZYYmNPc0xZQU11Y3lXQnZOZ0REOUs1QTZnSGQ3ckM5MStVZmd6?=
 =?utf-8?B?bEZWNVhqc2hPUDFNK05UOHc4eTkzV21OQnljOEZtc0tXaG94OVhLRWtJRVFZ?=
 =?utf-8?B?ZXBWc0lDWW1mUW9HZk5aMFVDZWxhcXZQVjZaNkxmckxQYmh3MlRUcHJ1bmx5?=
 =?utf-8?B?TG4yemM5ejFsMzBQdEthWml5K1BBckpzZk9PVHBDamljRG1JRXVKVzRERE92?=
 =?utf-8?B?cVMzSUZTUm1QS0lJQWRLU0d1YkpUeFdyMldPcjQvYlV5ZjAwalR3N1FndEhu?=
 =?utf-8?B?T2hVUWlnVWRRbDVUNENjc2FwWFlsc3ZpWHdQVG1BR0VmT0hxZzYwYXFGODBS?=
 =?utf-8?B?M25XSHZSaWRlTHN1R1dRa1VweDJnUURtVUgvYmxtd0tUeWpsakNURGx4TUZh?=
 =?utf-8?B?Y2hKSTlKRDYyZXcyNEFkM2k5cVVybXc1K25oT1ZEZ1pJd3VZbS9XenphQXlh?=
 =?utf-8?B?eEVyNGZuYlRzVGxoM0MvbjQ2WHdPdzF1VFFEZkhMU3lJTmNJa3pQc0E0Wkw1?=
 =?utf-8?B?RFhLMnZ5R2FrVjJwdER0NDh1YVY2V29OaW1HM1NJai81UDJ5QUNwRVB2a2VC?=
 =?utf-8?B?WXFQZGhOZzF3U3BzV2JNYUFSRHZnbmc2SnVua1RGVG4vNDRqQlJ0ZlltU3dQ?=
 =?utf-8?B?ZWtEQWhWNGcwS3FVUkN4NTJZQU9IcmhSNnZ2dUxxTzZIa2ZBY0VvaFN2cnVr?=
 =?utf-8?B?QS9xYmpmYUZWelJOUlBNandXNEd1NUVOQkFjNkZ6OTlZUWJnSUNrV0pqclBL?=
 =?utf-8?B?ZmRuVk1UejBKRXRzV3Zvd1hVSDU2Z3RPK3djcitoc2tRMmNNc0htWjhjQ1VC?=
 =?utf-8?B?R1hJcXg3dkZRbXNvMUhrcU9ldEpPazducTlyNGdQNFZyL0ZBQ1NsZTcrbFMy?=
 =?utf-8?B?NmhwOFBVcjFZZVhIbUVnOWcrRHllTWlySVRidkVHMG94Zzl4bVBIZDc1VVpt?=
 =?utf-8?B?MW51czdJWUF4YnhySDU1TDM5SXNkdWxNcE5qUGtSZDB5TU9MU1Vmdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f287e7b6-bf08-4f12-9900-08df004df263
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 13:04:49.0047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IAoXUbNsLixt3fxnSijd68aDaBgBmW/6a+Z9dnSIU81XTv6J+p1Vel4y88JFrp7mrAypv/PtrE/YXNP3xbeeBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF8423FDA82

Pranjal,


On 8/14/2026 7:26 AM, Pranjal Shrivastava wrote:
> Restructure the device probe path to improve readability and prepare for
> cleaner error handling. Refactor check_device() into iommu_lookup_device
> to explicitly validate and return the amd_iommu ptr & devid. Refactor
> iommu_init_device() to return the allocated dev_data. Consolidate all
> PCI cap inits (MSI domains, PASID, ATS) into a new helper:
> iommu_init_device_caps().
> 
> Suggested-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/iommu/amd/iommu.c | 114 +++++++++++++++++++-------------------
>  1 file changed, 56 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 4c31294fabc5..9b8ad131ba79 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -675,7 +675,8 @@ static void pdev_disable_caps(struct pci_dev *pdev)


.../...

> -	amd_iommu_set_pci_msi_domain(dev, iommu);
> +	iommu_init_device_caps(dev_data, dev, iommu);
>  	iommu_dev = &iommu->iommu;
>  
> -	/*
> -	 * If IOMMU and device supports PASID then it will contain max
> -	 * supported PASIDs, else it will be zero.
> -	 */
> -	dev_data = dev_iommu_priv_get(dev);
> -	if (amd_iommu_pasid_supported() && dev_is_pci(dev) &&
> -	    pdev_pasid_supported(dev_data)) {
> -		dev_data->max_pasids = min_t(u32, iommu->iommu.max_pasids,
> -					     pci_max_pasids(to_pci_dev(dev)));
> -	}
> -

Can you add something like below comment so that we know why we are not calling
iommu_ignore_device in error path.

+        * When DMA translation is unavailable return error so the iommu core
+        * won't attempt domain attach for this device. But interrupt-remap
+        * is still supported. Hence do not ignore the device.

-Vasant

>  	if (amd_iommu_pgtable == PD_MODE_NONE) {
>  		pr_warn_once("%s: DMA translation not supported by iommu.\n",
>  			     __func__);
> @@ -2527,16 +2535,6 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
>  		goto out_err;
>  	}
>  
> -	iommu_completion_wait(iommu);
> -
> -	if (FEATURE_NUM_INT_REMAP_SUP_2K(amd_iommu_efr2))
> -		dev_data->max_irqs = MAX_IRQS_PER_TABLE_2K;
> -	else
> -		dev_data->max_irqs = MAX_IRQS_PER_TABLE_512;
> -
> -	if (dev_is_pci(dev))
> -		pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);
> -
>  out_err:
>  	return iommu_dev;
>  }

