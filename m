Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012027.outbound.protection.outlook.com [40.107.200.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8F435E1CE;
	Tue, 25 Aug 2026 07:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787641590; cv=fail; b=kXoI1SHN+xe+vj3Z3BNMueqG/T9mvXtBZ3ADUXucq267kPUjnp4VfIwes4YCvAuii+4V4FGPfZvcUBQrzw86ogNq/DfpwifKevYTaRqVu6POA2OkNpbJwNbCfPNlf8iSAcVGa49Xh7XlV/IOVdv0tGBRLMMk5gzPTzTLj2jAz6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787641590; c=relaxed/simple;
	bh=PlIgye5hGGZ3dN7bQVYTIo3h56/NcCt3T3YK6jOrHjE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cbXfMAI/LyV1MB+kfRb28aZw5RUFYuwQ8KRxkHa7bPRmqAPBbOOaO0tItBHcVz6w/qyzRsR8/J470MYjC0iuYHn4x3TvgWwBixFtOOrQZew6UZRQsjBjgJ8jkN/NC4Cch+FJ9i0wDz5HKJVayTvwHnWbyqty4TeIIUdUvGvqieo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5t72lrS1; arc=fail smtp.client-ip=40.107.200.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5t72lrS1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vw7Do79no0LvBNOgGqLer6+qT20aYNxrcAriqdMnwAueOsVgMPFpOavNchhOEIYO/GDSU+qgjDA5WYs2HXnOkiS/v6DxC7optmowJ4nP7lesd9JKzqpkfH2ickf3K8RroTZ4SJFRObR3HA1n/YaFRWNggjFNaZGdjEWJVzxitPknrS72XnAqaay6AVWCoHPOaR8w55TftqNdZ+IKsd/qfsb910DcaePOsUFpWANzxfuXVgI59+Kz521XnxNz9TTQN+IRyhgiYAaN/t++ZI49O1Yg5Ls+ywYVZm0SKn1y0oObe370w5Ob81YUFhRCUBVdGV+t/KnmxZYQYZ+awgmrFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tszzytVXFHQvdN3uFPDsmywf+cqgIbEHR89lUKqM+Cg=;
 b=dg2e0mFwRUscd4jv3tZPebU4qOyQJFPr6apItAJrverj5CZle2anKybMEA1BCReukSMub7ZMi0RXuVnaaP3Eewfi4iWSibSinFwLCL3/SD7oKfBNUUdTpwA6CWqA8iyItf8EE3fbM4HpJeBJsmk0UQjSK0omjRuk+XsacCUITqslZwUJllctesvMwJPn+KC7An2W9qzM+8qlTb+64e3yg827NnY5neiGaB/EUIWVqHAksHWy9x7c908xiz5fJw769LyVQR4/fvZcBeThcEBAvg7iDoye1XDYbwykiGbIO9+vYH1ybGph26ZUrF+h2K+3p7Nfw1jLLY7AneOULnoZFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tszzytVXFHQvdN3uFPDsmywf+cqgIbEHR89lUKqM+Cg=;
 b=5t72lrS1iYy951XzeL0+Utbrxtb3wZHozKa3pKSjJpePdgG/OmYkgFcGZbs+oKZok6XrXPwDo8GPITeI4UvwA76tFCOGhB53JP97B5IOkEaxSEjs7NCOP/OTDM5nF4paMYMX3iw4/6l9XcpFMaqifcWz9tGJ2FAfYBVI0w4wMQU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by IA1PR12MB8080.namprd12.prod.outlook.com (2603:10b6:208:3fd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 07:06:25 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 07:06:25 +0000
Message-ID: <8e53fdee-2c3a-47c6-9478-19fbabef18eb@amd.com>
Date: Tue, 25 Aug 2026 12:36:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] iommu/amd: Refactors for ATS robustness
To: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja <skhawaja@google.com>
References: <20260824122347.1588592-1-praan@google.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260824122347.1588592-1-praan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0030.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::14) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|IA1PR12MB8080:EE_
X-MS-Office365-Filtering-Correlation-Id: 279988e7-d809-4ca9-912f-08df027760b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	X30tQ6r1JTHXO4fgBr3oaQ1gtXdeDB8zYUs16fUN97vUpE9kEIIe3IZCEMl8zAULabXb//5mUbAyiYzGfLdOwttKfy5xF1Il3y7LlwaJIGAUq7k+zYSvAg58Rrko0hLNRzNbaBVc/ElgZ04PXSzMUUswEk5sW6t7y4gzvfObulNFCnNXr0AadtiJAA2JWyVguMPMFuL4lVFWjpC2uAbQ/QQsL5uFmNHuvHV6HSj4XzgYOMY4wNyWvfnuoHPgf2Oi2uifp4ygeh4Nn8etJg6D7Ogl/e36Zz5unFBNcfbnVn5Ho0101CkKJHFdqPAssx/HvbLXznrC75SeqXxEwscevRsrxDm83flSlUTQj7HOP81X7lSKK+Wr6EzqDQSVasDnULxDauFl0CfZs9FFMkqSdlZmyJVFosBnVhsYj9pMMq7knuhJgX1yymWfKTDQ/I9i67dr5MGirai9k8Wug+CL/cPdW8LFuiKKJoxJZVhQlPvY4za5xGs++kiovwMQMm4lD0bTP8ZpqZetkMZU6xuy+b3fO7s70SIfbYsm4qFGFWa3QzpNNHTeDJBoq2uotoktgxdumgOOTqFvFJHAMmf8JaNKd3OCvNyKSly3JXV3wmecpCmeCel7BjX4ecxAm+4T51Jc2uHYrnif8w85QCLeB3rj6UWA5RcXuzIilKXeh3Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0JhcGtyYTY1d1lGVDZIQzdLZTdZaWZkOGJkalFEZEdZZkoxSExOS3owSlpL?=
 =?utf-8?B?eFFXbkh5VU1Bb3BSRCthUnNjZittK2hsVlVQQWtVdG1odUxUWHRlZC94NmlX?=
 =?utf-8?B?NUdjWkRSOWJxSEV6cmovcWdya2tLQUNqYnBrNHRHd0IrVWgvSWJIYm5HSE9s?=
 =?utf-8?B?Z3BQOHlpaHE1WTZCUFVlZFB3em8rWlZDZlloZUJuQ21zTTRvcGw2SWxyaTFl?=
 =?utf-8?B?VXlFRC80MTBBVkhtMHhnc21SWmt1c3ByTlZPa3Z0bmlzd2txM3d3S1hkSDMx?=
 =?utf-8?B?ZTNCL1hKYXFMb21peUc3bUk1TDRRYmEwb0FSWE5nVGpuZndJR3daNVVNU0Z6?=
 =?utf-8?B?ZEZ6UzZjbitMeGJrUDNGSHR3UjFXOC9neDd0SEl5SUpBdFVobEkwL1hKNitu?=
 =?utf-8?B?QXRuWUVSYkM2RE5jR3E5MnR3cEZYOG5TSnh3V1hMaXc2N1Q5ZXJGT2p3VkI0?=
 =?utf-8?B?NHlOSi8xZkhTaFZGVm1raUZxZHM2d2dWb3ZjU3R3U2xPRWozM0FoUWNLR3Bv?=
 =?utf-8?B?SVpmSmRITjU3MTJ5MWMyVmx4TUtzN2ZRaTZjZVFuekM4M0RUdFE4Q2NyR2JK?=
 =?utf-8?B?TmN0STdoZ25PWGJlOU5BVGhkejF6QVJLRHhtVjl4UzMyOUpaYmJXQUpaelZD?=
 =?utf-8?B?bnlUc3UvUzB4YTh5blQwYStsOTBMQmlaWTZWdkJoUHN5UjhTTkZRTFJkamlz?=
 =?utf-8?B?NmRVRHdranp0aXA1K3dYZHJNMjQvUyt2eG1pUEVMRitIWFBOeElWUnc1aVpJ?=
 =?utf-8?B?MGVWdExDTERra256ZnR2WnRJajhoN0RSNm1lME1kY0JPVnRaUWp4Q2d3NEIv?=
 =?utf-8?B?Z3g1eGRXTEZuc3VPaDIrK0NaajVQbm13T0kzcHYyaDJCVTRUK1h5ZjUxOWtS?=
 =?utf-8?B?emN2cG1YTFk3VW9CNE9YSlVyK0VJN1AyKzRPTnRHdjF1dVhKdGc1WGNjNUNT?=
 =?utf-8?B?UUt1anJEQUtHK05IT1JCOGdyakVxenpKTTVnNHBNWmFqL251SThCQjgwVldW?=
 =?utf-8?B?aVBkSzRwalRvbEUzY0QxOEJ2b0Z5ZDQ2aGJTL3d2NnZjRmZmOGlKa3k3Y28x?=
 =?utf-8?B?R0E3YW5nejFxS085V1U3czB6Lzc3VW9heit6bnROeXRvTkRCandRNW9BSW1S?=
 =?utf-8?B?S2dhbENmR0R2bEtydXlUUm03clZhTm9ta2dHTHN3cDJrOUtENDRRT3VvSE5v?=
 =?utf-8?B?RzdtN3JEamN0MkNEa2w1SHdaTGVNM3lEMHkxWXVSeUVUN0cyaDc3QTBkQXly?=
 =?utf-8?B?REZTRHhoZHhMYUF6N096T0hDNlR3NVFJWHNiTStoVXJiTDBDZHFid0lMNUc5?=
 =?utf-8?B?VzUwd3JpQUdMMFoyRjBUZm8zTXNmbU1SNlh5empoWXVma0ZiaDV6M3RlNSsv?=
 =?utf-8?B?bHlIMW1rYWdUQ1FmRHJnZGpHL2daM1llZG14ZXM5SC8rRGpBRnFlVFNrL1U1?=
 =?utf-8?B?bmkxN0JaL3FXamJqY1ZrcWVkWmZ3WWVTY3BlRHpRdzlvWThBdGU2ajNwSFdy?=
 =?utf-8?B?c1ZPbGFLWHptSHpNS3NQQW4wajlDNGpwb0tOVzJUd2RVZENOVklDVnNkQkRw?=
 =?utf-8?B?SXMvdWViK29IZy9teHBrOHFoWnlUVllLZ3B4YTBNVEtxYUhoUEcydjJIRUpH?=
 =?utf-8?B?UmV3S3lkeE1DbjhNbGRrWWNGWWErTkt2Tnh3SGZmV1FKTXJ4UDBFSWREZlk0?=
 =?utf-8?B?bHVoKzVVSTdCMnFyZVFQQ0VkZmdBRE5iRURBS0RqdjJ5VkR4U0EzemcyaEVt?=
 =?utf-8?B?Ulp4czhpNiszeENwVFVxblZpUmhzN0NHci8vUmNYODlwR3RLTjRqYXdhVU1i?=
 =?utf-8?B?QVc4WlpEaHdCbVkwbjgvaVM3K2I4dzhjbGJEMTU3V2RRc2V1aHprWkI1TCt5?=
 =?utf-8?B?eENMUmRGc05uYVhSMlBuQ1YxMzFGTTdVeUlNUlRuaHFoQ0JjTFdYSGtBeXlv?=
 =?utf-8?B?dVgybU1TekY3YS85OUFuQnpST1pMVTZmVmlqL2VrNnRiWFhTM0wwYzJ0d2pW?=
 =?utf-8?B?a0VKVlJKaGZ0OXZWaWxVbmVpNEh5Q1NzS3pQNTl6TTVSWjl0VHhmelZabWxP?=
 =?utf-8?B?K0k5T2F4bkRpUTlZeHF4QjFMckdmRUEwczlCZENYbkFtZ3dvMkQwRmhJWVRM?=
 =?utf-8?B?VHdHamM0NyttdFBCQ1FBYlJIZUJQL0hvQUo5MU5nQVlTOFV1K3NvZXlrN1V1?=
 =?utf-8?B?ZWc0TGVhdHIwdW1wbGxSZUZBajduUUcxd0hrK0gxcm1yV0JOby9hNHdicXZZ?=
 =?utf-8?B?dEdqTU5odmpzczJBemE3VEc5UWNCQnN2ajhKV0NaN0JySUdSVnpEcm1BM3Rq?=
 =?utf-8?B?YkFKZlYvV2dKN3dwUXdoQi8rUFlOdFpIbFJ5b3FrQ1JZdVZPNVNTdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 279988e7-d809-4ca9-912f-08df027760b8
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 07:06:25.7904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0bHCXDrMBrrp0sSJUaJZQ7uUWCqSPWwpWAqE+auTHkMBuDKYfsbNaSgp8lZKMdLO7ArA1YtxKvbLdKJJWDLGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8080

Pranjal,


On 8/24/2026 5:53 PM, Pranjal Shrivastava wrote:
> This series forms the second half of the subsystem-wide ATS robustness
> updates. The first part (focusing on the core subsystem, Intel, and ARM
> SMMUv3) has already been merged upstream [1]. This half addresses the
> AMD IOMMU driver and standardizes the PCI ATS API.
> 
> In v2, the series has been significantly restructured based on feedback
> on v1. 

Overall this looks good to me. We did run our CI w/ v2 and no regression found.


-Vasant

