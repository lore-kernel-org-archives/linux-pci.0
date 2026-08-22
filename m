Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011058.outbound.protection.outlook.com [52.101.57.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5F52BCF46;
	Sat, 22 Aug 2026 14:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787407503; cv=fail; b=gkhHPy8RYlWAlO9wgsv1JT2QrB6fMxJkvesASKk+2rjerjlbPpUCrnDL76k4rhFg6aPx2NAAA+itRhTGVOrwNoe9KIjVvdkZZ273ptEHvaU0oAWVChuTHE+A8FSt9btDVME0sgI2QjsJLEbviDYlOw09Lzn8rUNLouvUkr8nf5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787407503; c=relaxed/simple;
	bh=PYLKPQkP6QS+OW1JUnYFDu7Jyn+WDWy9mrAY2o1K0IU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HJzy/nBk5esEoDPje4wRYkn34krq+v8/cnUW4WEnGM2khdaqywKgu5TTJmSfQxOXz8edLs78JIQktXvzRpj2jULtJCnl4QKei9ukn8sV6fniybVR+ZXShV0oIiHkmqJH9r+98FAOxIUzZTfmZKqaGzN/vq0vz+fN1d/BLPn7ufY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=06DukcVi; arc=fail smtp.client-ip=52.101.57.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="06DukcVi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQ+dSk+750efWyqCnNF+xVBccAcGdoXg2wZl+Jr9wbsvUyxdFKklMBtmmXSZ71FJB3A/ZIEIjrQAQ0rAoO5b8CA9xojUWq1Hg2JUQx4djky1TjPs/PFn9xqiDNC4sEDD7voZ0Lmq8VxT5fLx4AeFZYm02BSdXOdBwDKHRz6IjQikE7gefKNM4HCi3PZ8IzPV7CCX7DPlx1MFTSeHqDE0ihLetA3/Emwefuk/nn3zkbWGkd2gBp6k7NavI8veJLWa23NqGiI/U0/qMU3gQuKrFxrmh52Ccrjw292twd6IB9DuYQEqZvkJwFfZY0D/yNFGc8E/WQeKxLqFF1Al5flxAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuuSVgQWiVsinLoXL8DSBPRI6oNM+6S0NU5jATUvO74=;
 b=K9Yrr6Sg9/yTL17gQXrWifRLJDHfGr/vFqJj3tf+S4AWn9okv0EKkemU/yIWhOsCRBJlBMcslJ3v5FVQVZzCFaRqu+rtCUzJAj8DRD4FDm6VxpqknotvdQiSRzq+PDz+/d2xy5f8DXhPlB5E9jVROqsPQ0f+6ZJEXQPmK3cN6NF8r3E+v/i/eqM8WTCmpDbQQYSgcEEIRMBb8dcv1NtoahvPkqIG6vdle7Kte1WLoi1ZL6wt0BxwF46WKS3I5C4dvgu7M3VZKrbWrO1X3lNAlpW9CHmu06rmZxml6jrDWWPNF6FoANy3wrGPbkVcjwJzXqxK2GeRuXwt7gJLVqU+bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuuSVgQWiVsinLoXL8DSBPRI6oNM+6S0NU5jATUvO74=;
 b=06DukcViOsqsHn/l/oyLVv72n5fpQJKpzKpVH3knsoD37i/Vc/C/4jRbn3cWzIKQwmMwAZg4pRp3FgC9P5zDfYymt9sONl5XndbbatMP89FkNmHbvRAdhyfDqOoOMizKhN15Wvu3YI4Qnw+2vEviRctJJPXcN/rV6Fs/oS8cUsA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by DS0PR12MB8367.namprd12.prod.outlook.com (2603:10b6:8:fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 14:04:56 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0339.010; Sat, 22 Aug 2026
 14:04:56 +0000
Message-ID: <5e58b312-e958-4753-a9f5-0ff8f90065e5@amd.com>
Date: Sat, 22 Aug 2026 19:34:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] iommu/amd: Refactors for ATS robustness
To: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja <skhawaja@google.com>
References: <20260814015647.3370124-1-praan@google.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260814015647.3370124-1-praan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0098.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d4::18) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|DS0PR12MB8367:EE_
X-MS-Office365-Filtering-Correlation-Id: 2276b0ed-e8a7-4d00-cc86-08df00565848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MsuFpki40Xy2OuZiO0bhlobmySSF7ISd+dafdwndYaFwe1T8sQQ/a2OklYFc4MP6EatCv8B3uPOB/XKVkCLKJD2RuvpFKwqFKs9yBLhIyXdCJqU7/umhjO+5N/zF3k5rdrrBZo0rXY+Jm6r3Tkt3WB3JUTut3wj71Tj0bkKVBEHEyoAHjWi8DBS0FDJBcOhWTcilwGZKIQaWmc4suMQiCZoiNYTo64DRyxgK5R/y3cTVCpShF0PjiNNQ8WUrR8RG+B3T0GynHuZiGwqcVR3KxHwgk3zCntCsSpsmIfsL+SC9NFAoUjUs5Vvjy85d1CfMcPyatbKkfYxj/NgCx5Cjh6cweS2RgnUq0wQVC4GKIvKTrW8Vcp6sQg7E6sv8ZIW6KADs9gQt2iLeSOUpRn3zXMYdGFeLv3idoXywLmqjZETLtNIfNvbfcWPEjJ6+DwJnW4mNbUOhyUPM8L0jxq3jCjZucci7kPiotgem8tLaMZB5ykOeB4iHBEojiP98U6x07mAhFDpkRA4NUYpWE55/5FU1a32yVkpPJKT9qwo02baDaiFEoZ72GZaPl93QQ1qyZgGKKzrhh9NoCoCREzpWrjWcSFUnW6mcMRCuLA0Gft431TJGoJAs21zGps5iqBAxRk4Ysof1fP2Vt9YlWbEfUJ4AX6yan4rF3cP9is5YPWg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmptQ1lKMVFDMXZQckdjeFZEWXlGeEpVcVh1Y1hSRm15SWdScjB5eTFHaDN1?=
 =?utf-8?B?dlUyeWw4RlVzajFqYmtiT25iWVFxWno3QkZUUjVBc3NFUy9XaXhZNjV5VmFp?=
 =?utf-8?B?NFFZQTVYaU55ejhFaVJYMWV4UExkbmRxK2tEYXFJalk1S1UzNXlkZlRDaFJI?=
 =?utf-8?B?dTYzc2VyYzUrR1Y0VFphREJ0Y0Z2dDFFdCtLcHg4Q3o1Qi8rQ015OW9nOVIw?=
 =?utf-8?B?VmNSczNBYU1QZWxGNXlVdUtSQmRhQzl5UWRhK3RWV013Q0oxdUpidDQweGZs?=
 =?utf-8?B?aDBPZDUxOWdoQ2NEM2NTam1oSG1FVW96QjdjeW1TU3FnVkpFVGNsZHlmb1Jn?=
 =?utf-8?B?M0gzcDdRVXVEMi9iY0hnUHd2ZzhzQzRwbTk2Nkd6Z1grZzF3ejRUS1JzV0Y1?=
 =?utf-8?B?emRWUGQyRnZvWnY3MzNyYUhtVC8wSkZxaTl4OEs5c3NVajVvRHozTkw2UHF4?=
 =?utf-8?B?MXhGdU1TOStWL203UTVBbjZWUTJVQ3hzR2dSTW90YWpJR0g4Z0ZaZyt6U0p2?=
 =?utf-8?B?bWNCZU5xaDJ4NFdwem82QTd3TXlmUExhVzh0UUw3Q0psUE4rL3pKZDRWSWZx?=
 =?utf-8?B?RlE5S0Z3dmZ1TG40MmZObXhGd0c2WkdDWlczSjFJTjA4Q1NSdTA2WDhSU0ts?=
 =?utf-8?B?aytkZ0I5QVFDaVc5MmNhZkN6eDhDWUEvOGo5SEVvSmtDV09RZEg5Tk9yeldV?=
 =?utf-8?B?b2xuTm9YcmxRdldnU3c2L2ZXMkh6dlZVM1B1L3J5enVXOEpic3pPbDZ0K0cy?=
 =?utf-8?B?VWRoenNYQzliclNhL2hGdGJOMkhyUElpVk9vVEg2RTl0WHhseUtFTmZTVm1O?=
 =?utf-8?B?YmFpcFE3OXFNbzZod3Y4L0NRYTR5eXhFVG9udi9QN2ErZjI4NzlxdWN1L0Ur?=
 =?utf-8?B?aDNtSVpVNk92eDIxVVJNMEpWd3hIdUpTc25nczRwcEgwYXRYVHZSd0VxS1NS?=
 =?utf-8?B?L3dRWDQwQldweSt5dFNzZlgvM2FMY29MY1dZcGpkR1BsUDEvTDdUMEpwZ3R5?=
 =?utf-8?B?T3UzY3c4SWZDdTE5Z04xMFRNSy9FSTBiMEp1R2gvclUyZHJITC9rZzcybkNh?=
 =?utf-8?B?OW1PeWo3NlVtazVqZzVyTGhsbE9ESklnOSsvM2NKYk9EOVJVb2JQTFZYZXhF?=
 =?utf-8?B?YnNlVmw5RmFNK2Fna09qNy84Tmc4R1RBd2VWdUJYaGlSd1gxVklJWEVwMmkw?=
 =?utf-8?B?V0NJTDVFWXFUc0hZRSt3TGY3TWg5dzdNcXVQYTRkVks3Zkx4WitjNU95T2ZS?=
 =?utf-8?B?UTdkcE02ejh0TlZQWFFZcTR0YjJQczNKRHYvaXBpQlU5YnpSL1hQeEdVYm9Y?=
 =?utf-8?B?VldSUTBuVFFuSUFhT2dDSE5Ia204OE5OMU5NZWEvbFVWMnEwZzB1a2hHOFo3?=
 =?utf-8?B?dW4xWVM2ZkM4VkZsNUhQekJhUFdLbGxkVHhVT2pzZlVGbk1yQ1Y2QWRIYk84?=
 =?utf-8?B?SG91MWY0ck1XYW9DSGtUTmk1Q0dEMEtMVDlpNkVTeksyOHM5anRxVGxYWXZK?=
 =?utf-8?B?WDVlZ2N3cWRmMHd6SnRoSnhuTWk5WFZTWjhLclM4WWRibkxJN1pua25mRXU4?=
 =?utf-8?B?dFk2eUxSbFQvazBJNnhIQ21yR1pFRjJPTWZra1VBeC9aOTFFTTB4VU9XZnNF?=
 =?utf-8?B?UEtjVHB5Ri8yeHhjL2JJNlFEaDZoSFR1bzF2UGhUVy9SV25Fa2lmVHQ3WmJy?=
 =?utf-8?B?L3dldVZzT281WEdkV2NwbytrQkhCRFc0RkJEalcrZlRkU2Z6OEw4Kzk2VXBW?=
 =?utf-8?B?ck1XNVpFMGRNR1JRSGVUazFieHh4REx4cE9QOVIrdWlVWTlVTGZ3MDZJR1hW?=
 =?utf-8?B?VU5ZeHJ3VVoxemRCb3MyYTBQL3NMZC8vSVpLcGVrcXZHNHdOVHBPY1FheFRr?=
 =?utf-8?B?NWwxMTB4elFHZXk3NTBJQXdwZHp6bHRKSFl0ZnE2NjlVT2hpRzlBVTkyaXh3?=
 =?utf-8?B?VWdlOW14S25Ma0xVVWQxQXpTeW84S2NndUljOWNBS2FMWnFLTHZUWGdnU1Zl?=
 =?utf-8?B?dFRqTkx2NVhTcmJGRVZKTUhlZXBWdk1Cd0VaSytxalNsc3RWTVBKSTFOZFVn?=
 =?utf-8?B?eGJCUThiTWpxS2FiZVdYcytyZmxLeElXUmZZa1dDcmQrdXkrQlVlOWFIRGVs?=
 =?utf-8?B?dVFJS2lHUGlJb3F5eHJJckd4VERvQVRIYXNRMVAwV0tIUEkzcHF4bk1OcTRC?=
 =?utf-8?B?cWNNZFZJSGNxaVJMSW1FbU0wUGlMbHJxMS9lVzkveUNidGprQlI4UnR6UmZx?=
 =?utf-8?B?WEhzOXpxazVKQnlMY3E4a1BUUnNHc2V6cldwdm15UE1jeW1KUnZBVnRQMkVp?=
 =?utf-8?B?WmMzYjd4R3F0VmliVHZFd1FRMHJiZTQ0WFEyMXVPZ3grNFhYaTAvUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2276b0ed-e8a7-4d00-cc86-08df00565848
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 14:04:56.1431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NTQCdG7soJ2aFlabdS5TXrLLZtcq8fVV4om0yH7lS+sSR7Ix4vTiUfiHLI3o0+0rGMuitKZoKU0vZbTckNGldw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8367



On 8/14/2026 7:26 AM, Pranjal Shrivastava wrote:
> This series forms the second half of the subsystem-wide ATS robustness
> updates. The first part (focusing on the core subsystem, Intel, and ARM
> SMMUv3) has already been merged upstream [1]. This half addresses the
> AMD IOMMU driver and standardizes the PCI ATS API.
> 
> In v2, the series has been significantly restructured based on feedback
> on v1. 

Overall series looks good. We will run tests internally and let you know.

-Vasant

