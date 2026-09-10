Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012010.outbound.protection.outlook.com [52.101.48.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBD82D0C82;
	Thu, 10 Sep 2026 00:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788999368; cv=fail; b=G+n47rkBiGQaUMenu+JbZPWYUbaktIFZEh+gcvA7XyVbfhNaiZA4DsMDJEfQ8uBo7g2VmEonZe55ucr/2nckhWHBnWDM369bGXVZYPWAIN9pPLzMg8U4cKna3U7kTKx4ev7Wk8Zb1Fr18dT3zm3rRqNtDcd26Fvd8uXeaEi2jKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788999368; c=relaxed/simple;
	bh=YY2dwu5H1dgMH3VgJN8tGGo6k/ldVMN99Sd5LqGAs5w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CqNV4Z2hW1iiC5q4SfN7AVxW9PYye2Z+qtmXmjFH+DpRi5/7lpKjtR9vZew6/oot7eUoPSYqUYtVnjSiFGsa8vENBUimsP5bityMExSuyyovPneoJTqlGrj3BPaEaCFpF91gdpDpNd2OeGSNAHEC3tdIA0piFmz5t2qIdfMPFa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EPcZihGK; arc=fail smtp.client-ip=52.101.48.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EPcZihGK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2u8UEPwANIoD97wSUWCa6BcbtRkAI/vHzb4YDR/N3uEVPC84/2B8pP/K7+ck+oZY5VPvoFa8k9IxV8Tr4X54dsjrcQc5gjbDvYMy5mq4uNDg0eqGU7olHqmz2NCxA1S1GrRTPZk6gjQY/RaTcEjq6MV1RoL0u/n7EXmHE4sLdYUDN/TO1uX/TjKhfwETdUplPNtdwZgono7yfh+ACkFYDTwmzgM4kQ4pm60758b257keXXp1cnU76jzzyWTLQn+TkFQ7jhaFWNEmF1iAv7tGHGx29qRC1vV15x1O+YJdeDMiuVAFzHrC9H0bXDJLHacGOCEvg8aeqKOBSxXLVafnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbCJ8M700WJx811vpgPHt8+5utLz4mtzeb9YEl6oNv0=;
 b=TEToVHOMxDV6kiDksaN7sMKm4XsqVTlu5cUxZVGg+1l3hsYQyXdEOdTnfanaflAAfq3QZ/Pp6M1ltEp4IGQSw6g2YjavDz/K1Ue0PlA0fVRxKbWkfhpfexkpS6UP20Uhqbbh8gHLqz29m1tHfqsOJy3KQlRmCLhQbSh+AAfVpb4AIf4tK68kyHOW+npJL/zosydJJP/J8HfGznDna/hV6Yxv28zkyWv1WzDtZDXYfgU40kxER98K/PSlRbn2dY0s2LL8I3rUAs0d22Lryj/zk9+be/RKbSiZupcvzn4NLMG5scHdVxgeZKSp2h31LvZZHpkZeXnPrI6qa+vwUZU9bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbCJ8M700WJx811vpgPHt8+5utLz4mtzeb9YEl6oNv0=;
 b=EPcZihGK2jlcgIhWcFD+ZkRORsfJrRdlPzhOVDVUq0bYzJK14ptyJ0oKO96YWN/lY9VTiJ4ytPy+oHm4eIXJ+fybvzZlzfYV4MaLmlC1mG5Li6+0NKoZhv/9WWs3sBIcdeGUCbKpt9ku9V1OVT7wC8wHnlxz5HHwE53+7NYKOa9L4aplR62j7KEVKHAwpYgLz22w2VxGMWtSVwEjvDQYIZqxQhcCUNM+6jng1/sXcCZruIeNMjsJQ5uvF5dNMNZ3gpdNvcIQRPyhK/fBKYRXGMmcmArPq91VlW+x2FY/+vkfhW4SCDYGTr+8d6BAkNuMXdKcSDLg0Whny3udqMYwyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by MW4PR12MB7312.namprd12.prod.outlook.com (2603:10b6:303:21a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 00:15:59 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 00:15:59 +0000
Message-ID: <f961571e-7be1-464e-8d79-5c36c5a53734@nvidia.com>
Date: Wed, 9 Sep 2026 17:15:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 08/12] PCI/CXL: Reject CXL Reset on multifunction
 devices
To: Richard Cheng <icheng@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, linux-tegra@vger.kernel.org
References: <20260902072804.665639-1-smadhavan@nvidia.com>
 <20260902072804.665639-9-smadhavan@nvidia.com> <apqONsm7xxFqtC5U@MWDK4CY14F>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <apqONsm7xxFqtC5U@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0207.namprd05.prod.outlook.com
 (2603:10b6:a03:330::32) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|MW4PR12MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b2a5fa-3eec-403c-6856-08df0ed0b10d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|4143699003|11063799006|10067099003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	eRrqJz9zsBGDh+bce4ymAPh1FUPdx0iwnua6o1lF+E4cy8p7za5gIV01emRZtiuabvaUvPuaX3qft+XxL2o3E3boOkk1L0gna/Aqjwi5/BsALKGb1B5Yj6LRPbvnwTJDRTk5uD9UekJ33hfDuGi9Pzv7BjNSysk9EfA8dQt6mFATEUcDMntxEC6esOxKIIRsjeumdzAvMtLGpMygn4fS39NdDKyrqbT10B4M1H9W8YL3b6ogo31W5lHxJFxmT3O9gq53RwVWUB8Dphr59gkpRIsDttCQ+4qIZfxN/m8XsvZK+SAHvTd4MN5SCyzxankWe4W4arzw2M5N6E+vdf5VUw3X5JdyzXhpnEKoK00R0l6Cn9P4Mze695g7QIhMINJ8OMAw21L2/uSYTN64G6rtp5FOs3T3z5jk4NAg/+rAnVltRTg8aVwaz6ISQJiBL567kktKZJ5O2D8+kQXOVAUwUb8IF+NXdRSvBZ77d6dYdLBoMXztdpqM+y2cA7TyeBD8i50QLa0usbf4bx5FHkAZxecveXI41rzMJRmAgM182xQKdi4VOCYA8w167kSG8LZWIZggZ3S8+PTYbpUG/WLwJTjqLb/JttMcLZAKHRuaXJ+/kK2H9Lraukc4YN73D9pP6oSHfFQuvDYS7XvtmtlAgCZHUAciWGsze02yKt/j5Vc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(4143699003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFVHN2xlek9iWTF2OVdJZUMzYzRqU1dpWVZ3QTJKWkMvbTZMVnB0R09LaTFa?=
 =?utf-8?B?bFpKQlRvZWk2bnUvNE1lM1psYmhBaEZHU0kzdWJyT1Y5WlRUYTF2U0FsT0Z0?=
 =?utf-8?B?eUE1MTlkcU81eXc0Vm00NFhQdXlHNmxIU1UyYk5mM0NQamJ2ZElocXRZV3Fs?=
 =?utf-8?B?MEh5WmFJcWJJbTY0NmhodDVZdk9yQ3VTeFM2U3lNa1ZRN0VEZkxvU0RYOFA1?=
 =?utf-8?B?VzI1YW9ZYmh0aW9mRFJFcTZrSE1JTW56bTZONlczelp5Mjk3WVVwc0pxSnNH?=
 =?utf-8?B?OWhRcktjeWltZ0sxVlhCZHREMG40SUd0MFZuczEzMjEyOS8wTkNtaG1zZGtN?=
 =?utf-8?B?MGEzSjA5c2NhZVdDWTlOVHlBWEN0MnJHeTlxcmRyWmZjeXlQTzJpbnZObGgv?=
 =?utf-8?B?NHlSVSt3TVBIcDR4QjBQcllqSy9WYzVwdlcxRDZQVFRhQlIvL0FCVTZkL3lj?=
 =?utf-8?B?eUFTU0phWElYd2V1bGRMaGJhTlpVcE5uc2cwOVI1MUU2bFZGaGs4azhOL1B6?=
 =?utf-8?B?TkxEY0c5M20wTEowSWg2WDB5T05rYXJwQVhreGttbUFCTU45NDZUS1BEdXZI?=
 =?utf-8?B?RU5Jd0ZRaWk5R2RmY0lqazBBM3lHUFBsY0NlZFdmZGE2NUNJTnpFenlTVUFG?=
 =?utf-8?B?L3pyVzZzZi9NaWp0UjZKdDVoRHRZSGx1YmpvRFZvNWRCYVk0VjgrZU9kWEFJ?=
 =?utf-8?B?Qkw0MmlRMW9xWHVDRG5od3lmemVjKzJ5bXhCRENqbFZEKzBSdkFHNlFOOTVh?=
 =?utf-8?B?Y3Q1K2lJSUtWS0k3ZzdJdkx2V0F3OUNxZzkzenlBNWdlUXh5VnVncldMS2ZN?=
 =?utf-8?B?aFdiMnRHbXh2SjM5QVkyc1RjeExSMTZla0tkcWpZaVVwS1ZKbW5VTlFPcXlj?=
 =?utf-8?B?UXZXczVHWlNLMDRGQUhFY3o4SXRsY1dRV0hyQVpEbUlMSTJkY0N3UEVuRExT?=
 =?utf-8?B?NTR3YmlIRDlLeDRlZmtyYk5hUVlzaCtieGVkS0tNL08wSjQ4UFIrYlQreHJT?=
 =?utf-8?B?NndMMVc4NGpzK3FvSVkvV1J2bHlOMEM3eWNac0JIKzRicGZLRldTNTFYV2xo?=
 =?utf-8?B?RWNvdTVudngyZVRNc3Zvb21FbVFVcXljNEJSSEtSMktUYy8rY0s4UWhBc1R4?=
 =?utf-8?B?WHJuVWZPL2drOTVIaitVYjB3bXVVcjI2UGhpa3JwVTBGckM1V0hLQ2YzTkZT?=
 =?utf-8?B?U1JWSmxzSkg2WndvajNBZUQvMjBTNXRrMjNUc0RtZkxRUHlSS0dQWElZYkhr?=
 =?utf-8?B?MzY3M016QnIzUS9wQVFXODgycUJ3eWF0VFE5Ni9CZUNmeERWTzdNd2hxWUN0?=
 =?utf-8?B?L2NiVll3OWdxaVl0MGwyL0VEN3k2S2h5enBDU2lYRTI3VVJBQmkza2E4WVdM?=
 =?utf-8?B?VFUzNVVVM3dKTlFWZngzZnEwRFBUM1Y2MXdhTXN2ZTNFUHFYQmIwcTZ1eEFL?=
 =?utf-8?B?bjlhL0ZZN2YzOWhJZEZLampYekl6R3k5SldBQlpEZm96OGk2NzUwSFRDcE9v?=
 =?utf-8?B?Q2tVK1Vyam9DelRiOEJtZ3JrNy9TZG1PNE40R3poNmJRSFZDTTBScVhWNVR2?=
 =?utf-8?B?aldBVVk1UEZNQ2tsT2xWKzUvMVROT2hZa2RYK0lraHJaMUpOdG80dXN3bTFZ?=
 =?utf-8?B?RUxjeFpjTFFwSTM4bHNjVEc4azFpV1F2SGdIazc2MHgxRWlEeldxeStaWnF2?=
 =?utf-8?B?MTh3VlRneHU1R1QxMlJRQlUwYVpUMFR3aEoxUGQwcGdaZ1UrM003OEVHaW5N?=
 =?utf-8?B?T0RUWUZmWHV5RlltRTNHQVlHLzBaTWVXVTlnMlR1SUZKR2dvcC9iWlZ5M0Zl?=
 =?utf-8?B?Z2xoR2h3YWdMNjVBaGpRaGxuV3UwaUFYcFo5Wk05SDJKSjU4d21SM2psUGwy?=
 =?utf-8?B?aGpSbnFRS1pnNFBSNm9kL2hDK2F0VHNYYnFKeVVyRHBZemNxVGlVRW4xaXNL?=
 =?utf-8?B?STdaKzNiRkVaa25FZHNDQWdJTkF6L2RLaTV1anB3TzBBNGUxLzhJV28xQzVi?=
 =?utf-8?B?ZWVkY1RoajV0ajhvQlFYYnY0M0hyMWs5SFZZcTJTUzZnVTVLajE4RkwzcjFj?=
 =?utf-8?B?NGZncGJ5d2h3SW9uNzF4bTNERUNYUG4zTFFwdWpKR2tqRGNLZGtYUm1hcnBN?=
 =?utf-8?B?V1FCenM5WWplNE45cEN1OG54RWR2MVFRMkhjbUMwQ0k5czAraE5DUTlSNExD?=
 =?utf-8?B?clVCQWNXKytLNHFxbjNUaUl2blFlV3EzZndvbjZvcVNFRU9wbFZBeC92bXM0?=
 =?utf-8?B?L0xhbC9zQVZ2ZTVGdm9GTGlVQnpmU2ZnRTNNT3FOQ0FKb2MvS3NjVFdTYUpk?=
 =?utf-8?B?aEpIMjdRdUkvY2dRbW5lN2FKQnFVVSs2MGF6eVpyZ1dKSTNiZUk1UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b2a5fa-3eec-403c-6856-08df0ed0b10d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 00:15:59.7769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tgRvwLp/pU+xfMlFjcA2ZpAPWXuycVkzK/DFp6yACyf+IUgj45IHZQMR4lbLYKHRtdKr8vTZaXu5gU6VcjdNVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7312

On 9/4/26 2:26 AM, Richard Cheng wrote:
>> +	if (pdev->multifunction)
>> +		return -ENOTTY;
>> +
>>   	if (probe)
>>   		return 0;
>>
> Hmm a PF can have a single-function PCI header while having many enabled VFs,
> and VFs enablement can change after reset-method probing.
> 
> Since CXL Reset can affect VFs, do we have the mechanism to quiescie all VF?
> 
> Best regards,
> Richard Cheng.

I see the issue.
In V12, it now conservatively rejects CXL Reset when either 
pdev->multifunction is set or pci_num_vf(pdev) reports enabled VFs. The 
check is repeated when the reset executes, so VFs enabled after 
reset-method probing are also caught. These changes do not attempt to 
quiesce active VFs.

-- 
Regards,
Srirangan
