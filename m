Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793214459;
	b=V6CjaLAyKsYX3lkSp9ael2MiGZ7PiVfMQJ1Au9bQnRiwnQ0QGkc/jAIGtiyCjTRRw2AH
	 zVZjEyZO62bLo4JjVv5xjjK9ZEtmK4WbOzoObbcLpUD2dyQYn4q8L4NmKC/JI+7sHmFoI
	 tTSTuIhAw5d6EIJBYs9e1o39CQV0GP7YdzGDBDAa248EhVN/xbZjKKeijcLZYnHLOz+rY
	 iF689hyYT7jxvwuAfoI5Zh554s9vpZhuDaQc9k8HrSbF6f7xankols3CB5F72Z+VTkQ+W
	 QEyHzucgViFAuvNe+03OEn5j9oroD5R98LJ7iGaVTp8GHahJTQ1UOzqWNv5Pb5BS6xA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214459;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=uhv/uc4FiqR0e+2R1RaHtXtCQLvXfhTGwci2T9drOTs=;
	b=QIrEZumw3KDj1YxBia3pLpcDwCznLD930Kufiq+tEkRf55Et0AizGafq7t8sodZL2APi
	 CC1Rv9U1Uautx1uE/JEHvKW37uR4HWhIjR5bvaf7+nbKubaj+KIqihIl+yRZnuIkkkZBn
	 iQrkcZTNWklsRlloIprWbLOEDmlfEJBwanWPwAAuJ7eJVDoBpQqr52dWCRkCIIRpeJItg
	 yVusrg5lsSxlCEtkmGxiriLegsslBXXyaJ8pVB2UyZsUex/9MqDLhwK690LMZZ6L+6nxF
	 oFmNQWZnjxPYyKoiP0fhciapEoigCXQ8Ve+FEkSkNg9Owdb7a+1OPZBYN+ua2I0nOHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YxihyygS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.7
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012007.outbound.protection.outlook.com [52.101.53.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1BD60A3823;
	Wed, 28 Oct 2026 19:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D1BD60A3823
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YxihyygS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OVHM5uF/E8vj4Jf30oi9IcDm0jFBbapJpFmmEJCagy5OGp7TqT+qhc+lrnw4nkzpplsnrmOPQEL/kETqeqQMhrSnRDA5tvcJncfdZQu7+cSSUg9xl5oNk6fRo8vmnVqHoon8fP01NEBuyJUZDDYvjB8kOSfprPtInTyeSpjvpjGpeWevLHtylCZC1COwR1IxFN77WSnNP0+UqgmjhUoInxpD+tfbsFO5Yj97fSpv6UPZSU59za30IvVRmwO2waIbQk6dHqEVE/FF/57rnNUBNw7KmZGZFZxI27+gbY7KdAD4OQCKmmNdUKbdAl0sMdack0KlMJX5qC/M35+sB7XX1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhv/uc4FiqR0e+2R1RaHtXtCQLvXfhTGwci2T9drOTs=;
 b=u23eNJYh/mkupFTpMcVDiNxJ7wGzQe9maMODSeT5TiIAN7EtgfIO/WyGaStqg1iAnTsZM2YzQfsSvBnfpFvyWfIBZA9K4XfAzqy2/nd3xFN8EbnJB/r98YOlVClScZA1yno5fRHkcooBWNkxlLHxAev4BGXd6pxwCTjnQyYUxGtXY8ehToYK0dCvUI5yAQqKf+X3sxbr80Jk/WxnmF8PkIqHQS7ahnrLlm5QmIJdk/IGh6Dkf7Kt41u+SFO1s7WVHDzKeEUL5Pq66pUI5ZEFAIQ7gi+jvYuS9iO+k+Nm1FDMpQJJlxKNdhOqTAQ211LG+/JnZv4+yzB0AzXD//yKig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhv/uc4FiqR0e+2R1RaHtXtCQLvXfhTGwci2T9drOTs=;
 b=YxihyygS7/k4v4UHdXJmvGyO1zSVYznxrFk7isEPGqcJfjB6K9KSdE1MVVxA1KBbmq0aDGFNvvqakzWOAAW7qd8GIy/1zoBIlzZZZbnP5tSucL+CGAa4cdL2bzq+BHkAe+3xubx/7C1So7LWnX7bi54V8jDpO1Zs0SBa/ThfJ5gMiPdWdKrhtXYZ4gNnOtE1rPjUAZZZ95UQlbzuckw47sOXWQj9s+Vfgo57MPzBSRkifMeDHQzmBUOm/sKuiu2KGu+yzngHCQEUmjiZNhEZS47KRNgXoh4u7gkrTOodTsxW1HmSyu53EnxZy3zfr8w0pfNmx86EtViNlAhu64KW9Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by CY8PR12MB7539.namprd12.prod.outlook.com
 (2603:10b6:930:96::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 19:07:32 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 19:07:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 11/16] PCI/TSM: Remove the legacy guest request
 interface
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, Alex Williamson <alex@shazbot.org>, 
 Alexey Kardashevskiy <aik@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
 Krishna Reddy <vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
 Nicolin Chen <nicolinc@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, 
 Samuel Ortiz <sameo@rivosinc.com>, 
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, 
 Steven Price <steven.price@arm.com>, 
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, 
 Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-coco@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-tegra@vger.kernel.org
In-Reply-To: <20261008055955.4014342-12-aneesh.kumar@kernel.org>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-12-aneesh.kumar@kernel.org>
Date: Wed, 28 Oct 2026 16:07:21 -0300
Message-Id: <179321444124.2412245.1053567517287648928.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT3PR01CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::15) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|CY8PR12MB7539:EE_
X-MS-Office365-Filtering-Correlation-Id: 60003ad6-91ae-442f-dea8-08df3526b37e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|18002099003|22082099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	EUhOgzHTQq/8c5te+2ZjA1hcoKLEhRjH75uxVRpha9RXPWbKG4q7L/8pKmXgIuekcX83o5ittyStUnp4YuH+d4kCbnbPz4ird5XZUzUPsAh6LrW1mTzOiyZN6Tf8qxChjs2RKAilkG44PBCvBPK98CKWQu1xHCFfsS92jxVb8RSXwDrDxQBtg9UpwJ+fhQx6ycpTmaaisBCHdxjXsHUshAO/XZ1nsgMwS/3sdNrsFkGAE7CYHXVJTRyQloYo/COHTysGFauKuTwJFXFNJHw9eXm0suF968xl7+u7vf3NQqnXHFWihpXngIeAPfhtpHv6/Fuor5hQ6WNf6+HFLgYPVn6/zwv/pOgxk9vkNHPVFQy6X11GY6NwbfpSYEY4+tmbpIbOOK7P4YTLYOk6NsG0VYR+IRfZPV1ael/Q/VmbyXyCOcLuW/G3LEfGbiVPhsqMi6146BBl8sRoVKdUA1YlA6EbK0B0aJsAYxH48EemNl0pEvbFCd7C4A59YJkAzKRshidSiCi9BW9tBtmkULgD8ffjNY+Ygo6rdydB/hzXeRvGBurxVPUpxRKaoR5uLWoyIs+eGDG1RuNF0pbKb0oOrZEY13a90s0oTAsHH5AlNNOAlX7bLYvr4+ScgnQRi3ExruYS7/RSfVAkeM6fx/3fyky0jryeXQcUB35OEg2etWQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MklPWHBXK0lxRzJBOUpkREwydVJjS1NhNjkyd3Jmd3JrbTNJRTlvLzhrYjc4?=
 =?utf-8?B?Y21hdFlDOEQrYzI0aG53OGVoK3l3K3g1VlhybnpSNXI4alhuQUFxdG1qbCtC?=
 =?utf-8?B?MjlNTkdBbUQwK0FDKzlicnNmWUttdTBmL1FJSVhRZzZzWlBnUDgyN0NoSC93?=
 =?utf-8?B?UGhINFl4d0dwa0lFSUNtbUtHWG9tczczRENOQzIxWW1QTkI3Q3NtcUFTcTJR?=
 =?utf-8?B?cGRHY3R1eWNEdFVCT2VMa0gxWTBmenF3UGtNeCtvUi9ydVAyZk1uRXJIclp6?=
 =?utf-8?B?UjMzZE83YXZ4SVhvMzFZaEJsQlg5MGRRYzVrbjJuOGtqMFE2MC9IZDVkaEFJ?=
 =?utf-8?B?V296bm02SnllcGFYczZTRHlURVk0VDhLRUNKckZQLzJDQzJGZ2JYU1gwdkdq?=
 =?utf-8?B?TWplYjM1TkdxMjdCU1JJTkw1R3MzQnJZOGhpZ0FxQUNwaFYzcHlOYi9FMmtm?=
 =?utf-8?B?eEtwckNoVlBiMUY4TmlXNks2OWgzSXF0QXV6bWYvcmNibVJjNStSMFcrQmtq?=
 =?utf-8?B?ejZpTThtWktacjNiWURQeG1WQ1ozcC9HYWlaL2hUaVgyTDY1ci85bXp2ZU5t?=
 =?utf-8?B?a3lFaXhPRUs5VitzUUtxeEQ4NVZxNmw5bURkZGtZNjl1Zm5wVlBZVjJndmEr?=
 =?utf-8?B?UXFvMzF2MzBsQzdFck92TjlNanBkQ3owVlFCMHFNL0pMYlRqU0pKeWQ1dWRT?=
 =?utf-8?B?NTg4N3p6RUNtSlRmWDlBY080aVQxcVdLMGVraGhjSkdiK1EzOWY0aHFUbWZa?=
 =?utf-8?B?Zy9EYXR1cjAxRXFYcDVkK3h2SndJc3FDTVdVbE9NckRFS2NYTnpDNFEwbHdH?=
 =?utf-8?B?L3lxOVZRZHJkc0NSenAzeGdyWUp0TGRtNHMxTzFuVFZPWUl1S1ZlYnp0cm1B?=
 =?utf-8?B?MWh0THNiUHdJdUJrZmRsVHFSN2EvU0Y3ZTBCM1h6NHhMWHZncHlJWjJuNTBT?=
 =?utf-8?B?N1ladXp3MkM2ZHBmWmpqdDhUeFJIbVhLS0RkbW9yM0FQVjJrUHRXbllDcVVF?=
 =?utf-8?B?V3FQZzIvTE1maC9vRWRldVdaWWlPVnRXWEpySTF6dDBqaThsdHlWY1R4a3cw?=
 =?utf-8?B?R0hnYXRESUErRjNwYTNFYWhqTUFhR2NxYVM0MFQwQmlGZlcxbjYzL3lCMlp1?=
 =?utf-8?B?bGpHNjVwM3pUcVFqWkZBeVdNbkJQQmVLSkVYOFlxN29YMG9CUXdCYmdRMEZM?=
 =?utf-8?B?aHpROVZMNTl1TlBCTHR6ZWJrSm5oeTYveC9LV29qRTVEK2RhZjZuUnlybFl0?=
 =?utf-8?B?N1VQeW5EZjRNQ3BzVjRwVVUyZGQwcEt5aDNhQUIzQ2lpdlAwOE05U09ibFhr?=
 =?utf-8?B?SzF1R05ZM21LWGFvbkQ1dzh2MEE4WnB6UjN0VzNiNHJxMHpkakF1SFpjYTI0?=
 =?utf-8?B?cmlwU2lBSzhrS1BzU1pZOUUrZTRiSTFzZ0pObm93M1NQby94anlYakxQSDky?=
 =?utf-8?B?WHVJb2FVSmE3TXd4RlhBS0x3dmRCdmRDUkRrcTAxMlpLcm9aNGpmYUFlTFJF?=
 =?utf-8?B?TGUvNFlGT1hUMUxGTkRDTWtZaUZ4K2M2YTFqaDNocXhlazNlUEk0WTB2YWFF?=
 =?utf-8?B?M2JURzJNK29SbjFzYmNuWHNzb2tjSUFLc2pYaFhxdEtRc09reDRkWWRmQi9Q?=
 =?utf-8?B?SXVNVzN3RUNEYWc5YVY1d0d2U0NkTjg3c2FxaG9GQW1GU2dQWS9tMHdZRjRU?=
 =?utf-8?B?OTJYUUNBbDZXcC84MG43Y2o0MVRFOUlPQnY2MUQ5YVAvMFBEZTVNYVZLSmY3?=
 =?utf-8?B?UlhmclkzdnRJOEozbjRYM2JGMnRnMUt6WGszUERKaTRJK2VISWI0YkxRN1RK?=
 =?utf-8?B?R3RpRnpVS1hBNlFla3lnUU9Jck9yMk14Y0lDV3hrT3M5WUhNRExWdThsTEhE?=
 =?utf-8?B?dzQyL2l6MlJuYnp2TzFpVGFENHhMUUpiTndNakhYQnlCMU9sYlFmamNFYUZW?=
 =?utf-8?B?blQ2N1JFVHVWRk1YeHhqWVFRRjZXblFURVpRb1pLRnNHcTFHWDFFVS9BZEg1?=
 =?utf-8?B?am1IUHlDYzJ4ek1pd1hlcW13MG8vNTEweDJpQUk2UTZjdFE2aERjOW5UYnpp?=
 =?utf-8?B?MW1NRXMwdksvMmtScjlycmozQks4NnBmS21Kd0JRNkpMZStkaTFnTGhIOUFz?=
 =?utf-8?B?Nms0Vk9QYUQ5QW9LVm94bUZsTGFGWFlNTzN0TDV5RnBENTltVzVYeW80MktR?=
 =?utf-8?B?bmg1Ykx6a3NlVElnUVQzWWdHYlM4OWZMMytCb0VzczRNTlI4MDE4Y0RVcjYw?=
 =?utf-8?B?czNWOWdRenRoVFhIb2xlQzQxTkUwdTRMenF0Tlhobzl4bG5POG11ZWRCUmNC?=
 =?utf-8?Q?rbVLsKcYUyaAHCembD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60003ad6-91ae-442f-dea8-08df3526b37e
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 19:07:24.7159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OD+n0SSfDdVHraNQPs9/YHmlubh9R/UUewZ3HQTgwA3l5ph8H/YHYlxTO35Xjfya
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7539

On Thu, 08 Oct 2026 11:29:50 +0530, Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org> wrote:
> Guest TSM requests can now be dispatched through the IOMMUFD vdevice
> operation. Remove the PCI-device-based guest request entry point, its
> scope enum and the corresponding PCI/TSM driver callback.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
