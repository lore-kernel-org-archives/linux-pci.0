Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011054.outbound.protection.outlook.com [52.101.52.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610F6F9C0;
	Tue, 25 Aug 2026 06:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787641188; cv=fail; b=NvWIcicBb2XD1M1tai9bZQtkqqcLWBaZCUQQqwKDSW4Rs0vPPrYE3e/8LheOGfediwoW9BQyQvrElPw5meXxHyRn/ySqU+yucEeMIhJ6GhGx+lhOHUkhtE/5TgC8N2djEDQ8Gbdek1R6CPj76kdZnec3TT6FeDkUAxFd8qtRakg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787641188; c=relaxed/simple;
	bh=6eX8ANMgCu8DlpLA/O4us1TwpNYjlcVEOy3Td8QxmzA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TduOX+xOxDW/7xckhLcJbzmry2qLQjvaqQZ5roCGNuN5LDn5ScRjbgbHpBo6Xe1RUhrKRyjkvjZbNoz6+Aqs3WVgVFskfHuAY2tNCwBXkaeSDQbxJ1MfcpGlffUDdUALt/6/vsjwXB+ZJwkRIqK5+VwJd3M/TofA1KJuoORhklA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DRSxuBsU; arc=fail smtp.client-ip=52.101.52.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DRSxuBsU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5vU6fz7aCarQxvIsV3CchrrJaPAQNw1BR39grVRgYWdxHT9XO3JtruJ1KW0mGjGpIqL7/dtoEN1gMxvoxfTtGL8CN2nLbH9LSujcxPFx/tYR1R0N8fq7YOdLJj08qIa9+8b8m3YaZ6Qd/YSUKuYXEN2z7Gc+P28fG18DG7HHXavdvHmfy8vR0cLbYaX82n8ZuUPEdpK9QCqnUFZ0+v50w79lbNdBb0W9TKM3Y4rUYA6T/mbNr6fN3bC7wKJdRpKsrBufiPwgW+UOCu9af7oCxmDDfCio67cA1qhthXbeJcF2O8KYCPXn2urijNWq31sk7J7aZ40K0K9t27dqJt7DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZlANTsISkNL13D7mn9V7eIOaRNIAs51rW16hNBPVvU=;
 b=C3H+MmB2s/3C9KnxxHGpDkxgq5zF4pgXiC0YrEvAgIVqpnTsDFT0vNH18cjyt0flprCekfUXVw/ipGqaA33kGm4k6c9O5ABBIgUupJvizZc8NPCYEGMjkdezHoGEXSo7bXp2uxzFSYZMAPNeVgBz/z9eu/0Wda9LO58zC2EM/PdUwx9hGlFJcuGc2MX4jhhKtB1EJQ3Jfb9glVN8QdYRmpuJTQh9lEBgdh44YhRkE4alKltZfU9x/KfHtIiTmmdQUzkNMFe5W3m697mvOIIYXSKBBOEZ+MWORQ/NTG7RozI2JIfGMrqWxniacac4cTxfZeRt0XRljNhx0ZaJmDSVew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZlANTsISkNL13D7mn9V7eIOaRNIAs51rW16hNBPVvU=;
 b=DRSxuBsU6idIyRhpSfkH4FDmx5sGFTz/c/3u+vHNOz3cwejF6tPVxDMDVgz5UQNN8gKwLRMeTAdiA3BZF4QsnhhmyvxAdsEmmWjXXwsULPNWjVDWkkYQ6UEPdORBzYAauHY+j+U7EoCzZNbJqFBuuJ8TDpHWqvPuzLtzKmzsDL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by MW3PR12MB4426.namprd12.prod.outlook.com (2603:10b6:303:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 06:59:42 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 06:59:42 +0000
Message-ID: <a3279e43-5875-4165-8754-022a6cb2fb54@amd.com>
Date: Tue, 25 Aug 2026 12:29:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] iommu/amd: Refactor device probe and capability
 initialization
To: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja <skhawaja@google.com>
References: <20260824122347.1588592-1-praan@google.com>
 <20260824122347.1588592-2-praan@google.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260824122347.1588592-2-praan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0347.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21f::19) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|MW3PR12MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: 250a2c7f-028b-4a55-9d60-08df0276704d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|6133799003|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SJEEHmuyKoT87/IA861KkzFPquez2PSNu5dZN/OpLt39W64DXYIc571IaVoOfJmRL0riQVUXPbBrtW1PVDGul8pgCnsLbS5C49eUPX5MRCQAaOT4VW93qLLc4HDLFIf+1JVMmhyhXLn+TNKxJaCrQuPfWQokn1qqzi/q6UEddY0u1nRijIHbhd+eiJ0Ez3dsL02Z9iQ5YodWbfBAkje4y3AdWGOaaOyxmiJcwD8k5fKtubo7f/KuQiTb7Q0oPzOBQwHmA6z5NS+/rmYgpd+wd/CeEAwF+FtDHUlSzmPLy/1XOXne4hD5IRMfEtNvAvRfi2ZVho3ED/IV6vR/KDHCYblG1DMn4p/FLFCQmoHlziUYOf0r548TwJbnXUEkUO5Gldxeu+Iw8q7GY0EPVSHDGfLEt2LPc0FJ22N4xC08OziJ/Vn2m1MutZRhHbT+1xBuXLroHBReljdEQJg/X9y7sp66QVfu7bUke8570GxH+XdZilsXpzldW/Lomz6YXRj5JAbQbV4qRyGcHyg92SFQRPwE9tOEiBydaZtd0t1EsrARpIe6XjBmlX8TE0NYpzIyUF6h6Y3ozG2NBa7jLgn8F6SRwxYWeN3NcvZ9S12IMlkaP51oNQyxtRzPRUC+hMO/tGzsVD1zOpe1gQH2ZjP0cY/grbPMsCfCHPS/6UOW8Rk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzRheVRRZnZ4ZXdYZGM3N1phWjBIWVRCNVBrYldzS0QrbXk1bHp4c0EwZFNS?=
 =?utf-8?B?SVpkMTFSbjYxRnVNOWtVNkgvT0pQV3JMUXl2QXFOMExjejI3cEdETkZVbFJl?=
 =?utf-8?B?czVsUjZrc0pqR2k1RW9ZVS9iTUNzQkJNTTU4bWdMRnFUK0QyYi9PYmN0N2N0?=
 =?utf-8?B?dGJ4KytaZFZWSVVQZnV0STU4anlGNnJvZHR3RTJCQ2RUaDNRajlwRWRvUjJ1?=
 =?utf-8?B?ZG5uZXUzdW14RW5adDV2dkxPMlVCNkFLN1BLT2tMMTdXMkhveFBmZlpCRW9t?=
 =?utf-8?B?bXE0VkhZVGdFU21GY0szS2VGSUtuNWJxcGtDZXIwRlB6NUNlaWthd3hBYm4z?=
 =?utf-8?B?QzdoL2FSTStIbFQybnA5aTRYNVFmeTdMc3h2QlVXV2s1UmxnRE9uRmRpdEhm?=
 =?utf-8?B?VGlMbU1FY1pJek02eWlZdUQ1VDA5Rmh5dHhzUkp0dklKQTZGM3R4ZnhPVDJs?=
 =?utf-8?B?YitCeVRxVHRQb0ZwNkVSYzNpYjhXQ3dsN25iQUdOaEwyT2o5cmR4Q29aK2dU?=
 =?utf-8?B?TlYvUkZydTBsRlJXK09KU0pubWI2elZzamxuZ2ljMTR4R1c5OGRnUFN3Vlgr?=
 =?utf-8?B?V2NnNW9uQWgyeGJibGsrU0k4a24xRlA5aDhHMENzMzR6UDZHUWs2VGdiVEJT?=
 =?utf-8?B?YmJaMGFEcUFGRDhqYUNLUFhzbk9rN1l6Y0RkSitqSVJKRlJvV25KQmpLRUpC?=
 =?utf-8?B?NXhkcTdNVGtnamRpT3R0MkhiZ3p5NmQxQnl4SkdmcysrVDNMTWVSODZpNkFU?=
 =?utf-8?B?OEl5U3pLMDNxT1hjNUZueFBGejdYZjE5YnZCZmZKd29CejdWSis3WWl1bUc3?=
 =?utf-8?B?WDU5bmVPb00yWlcydVd0eGpEUXAwY3hhTUdzdXFjT1VUVlVzYk9kNVdPV25N?=
 =?utf-8?B?Z09pQ0pRWnNvc0pkZngyUFdvcmNPMHg3TEtLUjZRdTlqV3dCUFd2YUdLT3kx?=
 =?utf-8?B?MERhT0h2dno2RnNDb2tCa1gzYy9pK2JRQ3lyNEk4WHg0cVRHdFdtU1B6NjJl?=
 =?utf-8?B?OHdEL0J0Y2t6bno4TEUrTE8vRmJQajUzKzhFalBDOXROMWx1S2dSbitLd3Iw?=
 =?utf-8?B?cUhiV0UwOFlrMEk4aTFlalZKdWwvaDFMKzhKK2VTT2N3c1I4dSsrNWJqeGRj?=
 =?utf-8?B?b0FvNFRMWkJDeGpDZEg5WGJ0NzZRMnRuVDVzQjNyY2gvenRUSis4U25ROTdh?=
 =?utf-8?B?MlY4cm5HeUJ6UlJkT2ZrRW1CVlQ0Nkk5a0pKVzNGbGJHR0RLT1l5Q0NKWXVN?=
 =?utf-8?B?cVVGdHdZV0p6Yzl0OHFxMEJwNS9qREdWNTRWc015dEpML1JsNm1rZ1E0cSs1?=
 =?utf-8?B?Z1J3OUM3QmJwSUkyVjBQcnBIdnZoaElCY2ZSKy9uQlNrSW94VGpBTEpOVlJw?=
 =?utf-8?B?Smh4aU9SaTEwdUpQUHpUYUxQK2N5Q2FkZlZVTy95by9PY0JBazhMcnFMRHpi?=
 =?utf-8?B?OGVXTThCblFKYlYySDlLZWxaZkdhUHZ6RWF3cFNKUW4wZEkzQUJJc2tMb1RH?=
 =?utf-8?B?QnFobGtwRHQ0MUU2RnlTSFVlcG5VU3Y1Zmx0YWFmWW9oTTB5dHBXVmVrZFc1?=
 =?utf-8?B?TEhSWHh0ZnhKL1ZYUHdHL3U2L09ndHJuaFh0ZnE1Y1k0YlNBWWovWmg0YVkv?=
 =?utf-8?B?Z0V6Q2hjQjArMzhyOTJ3SEhuaHByaTJOYUVoSlN1cmozckZJK0ZZRUJTZDRN?=
 =?utf-8?B?MDBabjZlSTJCaUR3NUFBRWNiaXFBbTVobG5kQjY1ajNJWHlFRyt2TkxJQTY2?=
 =?utf-8?B?bXhVOFYwK01Rb0V3QUZwZGVaTW9HZ0tHL1FvWXZqNUxxcFV4YjhtQjZuTGRB?=
 =?utf-8?B?V2FJeUhNeVFpSlRBOGY3cUdRWGFJQ1hENTFTVEcxQVdWNHFjWnUzN04wUXM2?=
 =?utf-8?B?SkttL0Q2S0NnQzhJVk5vVGNJL0FFNHU2enJuckJTd3NtcCt0T0xhSDc5RjVX?=
 =?utf-8?B?OXNSai9RNFNQMTNlN1FpRjUybTE2NHhQdG9ieTN1L0JOdU1wTmpVczZXS0Vz?=
 =?utf-8?B?N3NBMmpQLytRYU42Z0FHZktxR01wOUhzcVVQRkwzd0FiVms3WlFJMHcxM1Rr?=
 =?utf-8?B?WXFBZ3V4MDY2Q25MVXBKSzFhZ2hsbEtLWE5yeFJ1bHI0dlhEYUhqREVjaGhQ?=
 =?utf-8?B?NVd3N0oreGxYNUFwMzhYVGhLd1NIVjFsWWJST0hTd2s3S3hUbWxLb3ZZR0Rl?=
 =?utf-8?B?YU1kTzZOQzExMVIyVm1CbWQxR1hLWGh1UkxubWRidHU3SktaT2dJS2VyUVEw?=
 =?utf-8?B?NGEwMDcxVTBHWnBHUksyeTVUZ2dWYXFRWUtYYS9pdGxrcnpOTlZGRkJKNE5n?=
 =?utf-8?B?UDNENE5FdmQvZkhIT2MxcmhoeW1hS053dEh6RXR5U25LRjRQT3lxZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 250a2c7f-028b-4a55-9d60-08df0276704d
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 06:59:42.4722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bd4qfVQlPN+btz9BjQtdy5htOb8PkgXQHT1GZBpBKiHhuUbM8GEnCgaSeijyrKyxSjNjT6i9jHUI7RlWP/po7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4426



On 8/24/2026 5:53 PM, Pranjal Shrivastava wrote:
> Restructure the device probe path to improve readability and prepare for
> cleaner error handling. Refactor check_device() into iommu_lookup_device
> to explicitly validate and return the amd_iommu ptr & devid. Refactor
> iommu_init_device() to return the allocated dev_data. Consolidate all
> PCI cap inits (MSI domains, PASID, ATS) into a new helper:
> iommu_init_device_caps().
> 
> Suggested-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

One minor nit. Otherwise patch looks good.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>



> ---
>  drivers/iommu/amd/iommu.c | 117 +++++++++++++++++++-------------------
>  1 file changed, 60 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 4c31294fabc5..e1f9fbb63837 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -675,7 +675,8 @@ static void pdev_disable_caps(struct pci_dev *pdev)


.../...

>  static struct iommu_device *amd_iommu_probe_device(struct device *dev)
>  {
>  	struct iommu_device *iommu_dev;
>  	struct amd_iommu *iommu;
>  	struct iommu_dev_data *dev_data;
>  	int ret;
> +	u16 devid;
>  
> -	if (!check_device(dev))
> -		return ERR_PTR(-ENODEV);
> -
> -	iommu = rlookup_amd_iommu(dev);
> -	if (!iommu)
> -		return ERR_PTR(-ENODEV);
> -
> -	/* Not registered yet? */
> -	if (!iommu->iommu.ops)
> +	if (!iommu_lookup_device(dev, &iommu, &devid))
>  		return ERR_PTR(-ENODEV);
>  
>  	if (dev_iommu_priv_get(dev))
>  		return &iommu->iommu;
>  
> -	ret = iommu_init_device(iommu, dev);
> -	if (ret) {
> +	dev_data = iommu_init_device(iommu, dev, devid);
> +	if (IS_ERR(dev_data)) {
> +		ret = PTR_ERR(dev_data);

Instead of this, you can change below iommu_Dev assignment directly.

-Vasant

>  		dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
>  		iommu_dev = ERR_PTR(ret);
>  		iommu_ignore_device(iommu, dev);
>  		goto out_err;
>  	}
>  
> -	amd_iommu_set_pci_msi_domain(dev, iommu);
> +	iommu_init_device_caps(dev_data, dev, iommu);
>  	iommu_dev = &iommu->iommu;
> -
> +
>  	/*
> -	 * If IOMMU and device supports PASID then it will contain max
> -	 * supported PASIDs, else it will be zero.
> +	 * When DMA translation is unavailable return error so the iommu core
> +	 * won't attempt domain attach for this device. But interrupt-remap
> +	 * is still supported. Hence do not ignore the device.
>  	 */
> -	dev_data = dev_iommu_priv_get(dev);
> -	if (amd_iommu_pasid_supported() && dev_is_pci(dev) &&
> -	    pdev_pasid_supported(dev_data)) {
> -		dev_data->max_pasids = min_t(u32, iommu->iommu.max_pasids,
> -					     pci_max_pasids(to_pci_dev(dev)));
> -	}
> -
>  	if (amd_iommu_pgtable == PD_MODE_NONE) {
>  		pr_warn_once("%s: DMA translation not supported by iommu.\n",
>  			     __func__);
> @@ -2527,16 +2540,6 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
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

