Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012063.outbound.protection.outlook.com [52.101.43.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534C33BFE26;
	Sat, 22 Aug 2026 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787406942; cv=fail; b=KAidmXI5fMchzRdfF645/MCWy1WR1LSGPQLzn2NOTSV5A9EWFZbTv0YuvkPlpQq/bFfVKfIFq+GtgS2mnk/HLkmjcyZfZAitAdtgBvOu7SnDKnM3Bvdy591eCvmkwnoWHSktWFjMsTES7h8CLqXsK9iOZR518PERX8zlN6hStsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787406942; c=relaxed/simple;
	bh=Bw07fXb/AMMwvOkGRybbowwcwBs+ZCB/pFt6yop8XiE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vp+mFlp3gFb/8I1T02m9RL7v2saXcj2llfRwkYM9Uxo79WK/FEdwIvwsuuuvUNbY4DuHqW9XxfmNc8gp+/5opFlKCbjY/LQolLBZYsMfrQrwc/aCXJ6yCSLB8/ClCjUFvTxMBH6gJn5jVS9ojnOn7E0RJFN4SHhgxmqngUjmkDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P8Br78do; arc=fail smtp.client-ip=52.101.43.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P8Br78do"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0YYMjQgF9iE3BRj6PfWdwcf/+Z4bvDMmNGyvKTHq6ktljOkJqrrGgvrU92BpRQ93w2Ox/6AFuVIAT6L5MSfoy0VaWFNEKWel2Fz6SS1q1sOf9WcPSLYTpVeBmGaRfQ3uomwXjgUslHhrFIkLObIFHhrzp9XM5FTiMcUxco/yJRcdONGaCJNmT1zT6u7BCr6RoR2BP/YdDcF9PIrkRuBKXxSud8hQ+EegG1v3NLXlQ7+mjmxz1RWEwE7xu0za68qPvKqbiyNtdDqz9i+V6g6UldLN2PW1V0zWb2ieQNNh+23ZEUxvBYUuuE0DIto+sjj6zTmZzk3vBevXOvZPs/m5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8h7KedmZPcUHVDLw/sOTgiA2Gxhx/1kq126m+dg7z+Q=;
 b=kqDDdBDkgxrIQaGjHs+zriq0/CUBatlONyqQWNfw6d6+YmJRSM5leIVdYZriuPiXO242xFNt+HTaw9qG52pdKi8FSnafA2VyI1kitx+38wylunLjVZ9EGvMB8rnrtqED4zdry8yDGjHgnOdVSPnftcRrax/WuvfBGULaXtF3i12RD6lMRcOWrckC289i5gckVAf03Brxugl8EoZbVAsqM9dr6RXRvHExMh2bkOglT/4EF1+injfHYBEnyh210gxiWMSicXyceo2KPDDkp/Ck2hHZoNk86//cWmCH63fjwpw5YM8jw+NFQoVBkUVQ0F7v/A6lZqb/sYS+4KEcu2ulvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8h7KedmZPcUHVDLw/sOTgiA2Gxhx/1kq126m+dg7z+Q=;
 b=P8Br78do7QwtwBSiNjMpmS9XJ4cA454VSDYhTLWrgUyE/BgU9vjuNo51wNodooIFwfc1QrI5V9KmR+GiZ2PriWloL9Jzy4LoR2XRyKQPh68wsOvehQ9Ewautad41d6y2KpFsmgWCOCxXdmb5BqPqKfxGnh/q5qjc4veSJj0Mgok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by DS0PR12MB8367.namprd12.prod.outlook.com (2603:10b6:8:fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 13:55:36 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0339.010; Sat, 22 Aug 2026
 13:55:36 +0000
Message-ID: <5f90bdcf-0ca5-42b4-98d1-807fe19990f2@amd.com>
Date: Sat, 22 Aug 2026 19:25:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] PCI/ATS: Mandate checking pci_ats_supported()
 before pci_prepare_ats()
To: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja
 <skhawaja@google.com>, Baolu Lu <baolu.lu@linux.intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20260814015647.3370124-1-praan@google.com>
 <20260814015647.3370124-6-praan@google.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260814015647.3370124-6-praan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0120.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b3::8) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|DS0PR12MB8367:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e881850-9d87-48a9-751e-08df00550ae3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jV3KigRwIMJbdJvuMU/GQn80qGgf59UiS0ZpQ+f7pco+3uyeyD4JXEz/riGAn29PvrbPNIir/YjMLFAQQBvnr4zQwFNTmZEs8jKMDZjixWa2wiO7t53yuMhvLZfgNoL0/ANRcTvzfWxnnO+mp5fKFLd4S5bbiV/3g/3I8rk6hYOuBV2m3TEw+XFOWOwPlFhi3pmM8VbcBHbZNjprtYvmENUPuAb51oExzEYdudBMBkYAsufckUkQ83sODagRkCz7w0fF6M5RbslfhbDWeabtyDhUAbt+J7GCH9EwmnURw8wDGQRWoJ2GCQJ1fpcHPm6gocRoMYTBZ9CDbb/Lm36N1CTTpJQKe2w8xTiTf1std4GKFGT9MVsuSh+Y3iuuDIlD7fFCITNi9992ZPk4C/rM8H0ZF17Kd7K+Ld5Dh59/q53TwWG7tZsPaePhue15ANlRzjnzNDc8BcixzKfhkK34geaxs3Yo44LQ/Mko/B4TCW7OVys5pS4gcXpuIffqN+FcI72ruRTF8Iu7RNOqhYzn/k3pvmbnOjyZoioKxg/7dBW3tDww+VrjlTISCdo99/UjIfvrjPOw+DmcExvifu07TBW1od0Sk5SyvBHZ0YuharTTxexNJclL84IjPoR7qfiWELg7UIoBV11gm5T39CThnfhtA57lAZy7DRtIrvBcr4E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWRLTCsrUUpYdjVqUjRLRUwyOXJMSlRPbmFIS3pPRXJ1UFZrMkpldGNLRW1U?=
 =?utf-8?B?R2hUeTBzcVNNV3NDb1Y2cFBrUEdvbU44Q3FXOVhUUlBmUEEyZVdsVnRhVkNE?=
 =?utf-8?B?TjBMTGwxeGFFQXJEZXFWSS9QWkxJSER5TGtuaVEyWGxhL1pVN0UxbUxUc0ZO?=
 =?utf-8?B?amF5eFo0OVN1bUdtZlRuelJXQ2lHSzlHWWxRUVNvbGIwY0EzcHF2Ty85aVBq?=
 =?utf-8?B?MlpnNURiVHNlNkUyL21jM1dQMEtrbHQ2ekNVOWhEb2d0ZWZxbjFDNWhCbWQ2?=
 =?utf-8?B?eVhWQ0NvZjk2K1F3dllmNFc1RVBXM3JObVhiNXljUEpNRHpZOUJ0OXZxaFJn?=
 =?utf-8?B?TnhrRndEVzg3YzY1clQ5WnlCbjUrS1o5cnU5SzdPQzNnY0lMb3JvZzlIQWNN?=
 =?utf-8?B?QnBwRzR0cEE2K09aQjh1djI2NWZINnJCYVhiek9rTU8yWXlvR3RNWFVCYzVy?=
 =?utf-8?B?aytpWENpaUFYNnQybDVZYXlickFLSVgwS1gyQXQrM25BTmhmalhVZThHcmZm?=
 =?utf-8?B?OEs1d2lHNnp6eENHK21rQnRRK0F2S1BjbmxlZTNKTjVRKzZpWVVOM1J1MnJN?=
 =?utf-8?B?MTVXZmdUd0gwRDRTOE1sN2ZaUGVtYzdrck5VZ1FEZlc2U0E1NjdEWVB5SWVY?=
 =?utf-8?B?K3FyVXBRSmJ3MHVRK0V6bG00Vm14NUlsMTRuOGpkakprL0xGaVl0RjRLUW12?=
 =?utf-8?B?MWxoYkZUNzFCLzh3R1FMUThzcTZ5Q3oxN08wbjlyWFRaVEVoOUpPTzFVbHZC?=
 =?utf-8?B?dXUvWkpCcFptZDkwb1RuNTlEVTFSQTY5SlBvOTRBamx0MWxkdXZtczBDWVhr?=
 =?utf-8?B?ZlJqQVhQQ2RTNVYzbGdWT1dLMjlFa2JDa3ZqRkg1ek9kUjlaQytHVEY1aVlN?=
 =?utf-8?B?ck1SeGk2UjBjVlp6L0dSSmpLSXU5Nk1EVmpFYWxGd3hXMWNxeXJwOHQycm9l?=
 =?utf-8?B?UVZldUF0S0E3b1B6akRUcFg2TGhmUzJvUnhWbmcwa09menNZdlFiR0gydHRy?=
 =?utf-8?B?d0Z5UGQ0ZWlmdllPT1BLbnNOVERFQlJSTVV6ZkFHRGd3dUJqRTJNV3h4bFdi?=
 =?utf-8?B?WXRFUlNLd3VldXUzYlFzUTAzRVRzdTA2dlBlbmZ5bk5TNGdFSHJuL0FvVzl6?=
 =?utf-8?B?OGw3clo5ZUcva3hYVkduTjJGWThrR2hWUWpsUDJlSy9pM1lSNk03cHUwR2pD?=
 =?utf-8?B?a1l0TW9BTU1HbjVKdm1mMkc4dTB1dWNDR3BReW5KRXRxZjB2K0ltblVuVjFs?=
 =?utf-8?B?alNmMW91RkxpZnJJM3hWbWhjY0JlNm42UkJKdS9lcW9GUlUrOEk0YW9sUk42?=
 =?utf-8?B?QUtNSzNwUWZuNWxTRzdSaURBb2tmcjhFOUttMDVxUUUrY0tEMHZ3YjBEbXNE?=
 =?utf-8?B?QlIxNEJMUUNMTzAxMnI2SFZFUU45WWlra0JMVHJSdGp5bm13ODA3aXRUMmFa?=
 =?utf-8?B?dU1HVXVTR2xMczd0YUlzRTVkMngyRkxreEFuOEhyY21WYlNDNUJqNlVlVlBI?=
 =?utf-8?B?aW5TMmh4NDZ3alRENkJOWmJIM200V2NidmpwdTBudm5ZcDlDdnFyS1JCT1Jx?=
 =?utf-8?B?NlY0WDFJcDh6MDhkSDVvQ0Y0cEV3OXZLTG5DQ2UwdUFkOFlqK3NObXBJbm8v?=
 =?utf-8?B?Yk1INGhRaXZodmt6NXk5OExLUUp1TUdaanN6V3hRM2dqaU44S0ZWQytrME8v?=
 =?utf-8?B?eVpHSEdEK25LOFlCN2RRcFJSc1dEOWtsamlTKzBGUkRlRVZlWDlyZTQzeGtj?=
 =?utf-8?B?Nmw0Y040NUFDY2RBNTIzbllvWjFmZDhVV1FXQ1U4TCtMM0V6L2xzcVJJNmls?=
 =?utf-8?B?U2o5dkZYNUczNjUvZkMvV3dnSjJySmdNQ2R4T2xZdnlZNm9NM2tnekE0cWZ0?=
 =?utf-8?B?bi9BR01tQnUrZnBjTGpHRWNSMFFleTNDN2ZvUnVVV0lCSVRxanhoeXZWQ3ps?=
 =?utf-8?B?MWJESllEaXdLQ0RzblNkczlxY3JIdEZnK1Ruakw4YWloakw4ZHRlS3FkcVZI?=
 =?utf-8?B?V05kR2Ixbkdtd2lOWXBTcEg5MVJTcG9IK2dXU0tsRnk1bW0ydjRuOHdlemxa?=
 =?utf-8?B?TWZJRzBsQ2dvYmlwSWVXRGdiVS81bWdJUFE4RTJVVEtmcFByVEJYZUI1R2h0?=
 =?utf-8?B?eHE0b1ZYSWFDMFh4Y2hiczluR1Z3M0tDQ1J0c0lRdkpzejdqMFgyK21NdndY?=
 =?utf-8?B?WC9uY3lNYXhUREZRZE9Oa0hCTnVzeFVHRE1RN3pvbkoxdkdMWVlDcmVVeWdi?=
 =?utf-8?B?eFVoNTVqWUNMQTd5emZKNTRqMG10SGRZK012SmpXY1NlR09pV0luM3pDdHpM?=
 =?utf-8?B?WkQvd29OTG40bE5TV0ZRUWhGc3l6NlBodmVkeElZc0sreG9pd3Zadz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e881850-9d87-48a9-751e-08df00550ae3
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 13:55:36.6095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91TiteqnbRWgbxpwNhAoauMuKvQdaNycnb+ody+T34bGWdLiAyV8EKdN6sCNnkzzGb3tAKC3N5mQ4BewkwXoLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8367



On 8/14/2026 7:26 AM, Pranjal Shrivastava wrote:
> Currently, pci_prepare_ats() internally calls pci_ats_supported() and
> returns -EINVAL if the device does not support ATS. While this provides
> a silent safety check, it conflates support detection with configuration.
> 
> Update pci_prepare_ats() to wrap the internal pci_ats_supported check in
> a WARN_ON(). This mandates all callers to call pci_prepare_ats() only if
> the function supports ATS.
> 
> Update the function documentation to mention that callers must verify
> ATS support (via pci_ats_supported()) before calling pci_prepare_ats().
> 
> Suggested-by: Baolu Lu <baolu.lu@linux.intel.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

