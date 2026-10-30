Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793323413;
	b=D8nCHr0WfaBqeo8NBl2hUjiAsz5VkJyQC1tBZhycnnJfQvdBInOY1s+kMGG49v/d1bH7
	 h3+4VY4KIh0lC1eDwfyo/2vdbzMZX50FAxdiPnDu5q3hSj7/PH3pgJxkXuIBKXPuIXjxk
	 iJF0CyA+zWjZYyQcBOTonCDTb6NUkaj1vqxZf14/d+ZmwqbMOiA7GFKpCxhVbK0Fr5WdG
	 2zv+NRXnRbe226auceld0qWg1Aww5XRrrDyDWd5ObdjacMS7Rz/JGGx8ZtKJj5WNc8zTi
	 DlQh4Bn+GaiP93vEpoN4kLMfmZgO8zDfdEFQhBBwGwIqJw1b5VMXHfUJYFkZ6rMXYXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793323413;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=GzUIsXcfPMTHYHJWytKnp/0ccBk2PrgzRRZQg8RxgdI=;
	b=FOpOP/IsNRjOCjE+wd19Es2KVcL1lHfNrg8Dt392m4KQSnOfppEEiWLPxpoawdUL4Akp
	 4SQGU9onflZChTs6vwdPcP3h8wpFeQWR1zKPvTc4CJBKBP0lVCw1d4UkrwWsTLO40/qg5
	 Xm2RiTEnpC52qSPJATqbb2QGdWlqwikcz+xfPM7JMRjJbuZZlHLuBYNIVheOY+G2FAuW3
	 WUIr1/nHVuD5HYH9MYifNVnFgUKSCWBF3DgkZZeYqEhWfjJ9c4xNBrfLbrWIMoRfuC7fs
	 iA4anumSGOv2TsgCM1lVimLj12dQBZChEjF4XNws2US2ioPP9Gi+Fu6zqYsLiQqiS9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mHuJlhlW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.50
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010050.outbound.protection.outlook.com [52.101.201.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274E9606A31A;
	Fri, 30 Oct 2026 01:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 274E9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mHuJlhlW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sl80/w+BkNR42bjToAjZHCchrDcJx9xVtXkfMxjhMIv9OGe72BGN0sb64CjiK7uJ0XoIKr4cBCBPapDykcxHFqBBzJFzSrMmWTYxY8RZlSKFHBlOJInNuYBDnnMMvNPlgLSJ2giWK7HlVBGJvLAdn2tsKDjtpl4DCzKpCiU1nluVtae2pHrOYGvjFKlfvV1QC13h3ihO97y4HkCGwMBeMP0tVbcBOZrE+GynUE1wY/OZaAVMTMHm9VWB5THR2mjfmiCzODQ3RrCIgTP7xkxpduMaW5C7F+sfi7CF6qFKEd3tHPExrnzy3q9IWL1FyjjvgPLHg9qy7+icTWkMBfK8Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzUIsXcfPMTHYHJWytKnp/0ccBk2PrgzRRZQg8RxgdI=;
 b=U7TkaJn7fRwzO2VPBonLLDmmFuHCxuT88oKsM41KWvhoP87L2taxjPhRyVVGyiQmcla/4ESgBnxmYLP3+oo08W2ZNOqLh8NY6nEZQNmam6orp3IaE+iMkNRTcBXDkE72HMfCQsw05LqpWrUjUtej3K9w3HtfVfobDZpK2YA7vtLwEy6x/1+C4sit3oF0iEzyTsm/GvRlIyOoJEFwUFjTdcIrnWDveFeHlYjMtfEOmIMCSadEwCsyG8HNz3vdg0B2lMuSB/hL+Sp2ZzMjQRpzDMwHfsSXK04pShSBew/13BivggYo8iUq7VpPDcteolV40Iqc5WjP3RWAXYvmhgtqrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzUIsXcfPMTHYHJWytKnp/0ccBk2PrgzRRZQg8RxgdI=;
 b=mHuJlhlWHj+gB/XNmvUaUH2PE4bJ/R40WcKTG/bTT+frhE1wEo/W11EPInghi1UmObVKus8sNKnm9dBF2uxmhSEQ25SNJJmqLPBicJko2FOdqPqe6qaAU4qyQKuXtxyxkyYrLYbbCtL4yTVRtjeWi+waQgha3+yoqrVgsAQ76fT3u8SVgSdWx3PWo9HsNw0nJx7nYQ/lHgp5J6WYGb+0bHvWtAjPoi343iRxl5Rxa/bZxq6torng9G3QtMno7Dupt2jrr6a1HolhkpF/mo/B4Hr+rUngArBmIS9Gc5Z8VJVQcjd+WMVhz2SzunPusFbJ5p9uIqCYsMol0LJ5e/KGOA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 01:23:28 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 01:23:28 +0000
Message-ID: <096fa1b9-b28f-447a-a7f9-e473056b4bf4@nvidia.com>
Date: Thu, 29 Oct 2026 18:23:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 10/16] PCI/CXL: Add CXL Device Reset sequencing
To: Li Ming <ming.li@zohomail.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
 <20261011021422.3428136-11-smadhavan@nvidia.com>
 <37c6f2bc-53b3-4260-aa27-04f89c45e950@zohomail.com>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <37c6f2bc-53b3-4260-aa27-04f89c45e950@zohomail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:a03:331::7) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|BL4PR12MB9478:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b4640cd-7ed8-406d-3c9f-08df3624670d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|22082099003|18002099003|921020|56012099006|11063799006|4143699003|10067099003|261022075727099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	xLMipPmVV1s/AgPeO2Y36XN65uz74yOwELBQiG/rdHyYLUboqQb0mmir6hmlAwK1//zONzTzfzoyAmnCT/ppB2YZFHAI2Mf/lu1Oeboo+CUgfSKba8bm16TNgVqdbVf4cqWnhgQzFF2SdJGNj+ghSuNH0BBsqRORkellA0McrkBl660zwi9Aq+NPOhfNyw88UZ2n0HF0THqhRfFnYY4Q32JYmAyrclpVYACG8nEtfkOzrVEFUGpkXUAI9zWUzKKrBwUI14Kk4N8yzRjc4a0vh7m+H3SWUSTXfS4hOED7Pc/Si4jxizVsWLbX1XNPlJvhZ24ghpjD7REiDyyZ4qaU/j/dzMOlMzhwFBOyWBKEbbqG2XqHTyFEps9T48HfO2k5fikPSvkPgloz0Zitr2XvjYERovXvXa1r6Zo69LVN0aQVU1xljoi2SdRCRcjaS5+IEQj0stXCHST20VwWERBHtpA1777LkBuD5+J+GY+D+s9Jn1nrDwrL2iCok4X9zrB4ZdZKkzh74cjP0At4eyWRu7brbSfGgY4AFEz3KYJNko8ggt9jHlGlGiMZ9rPDswNsPnA09MxywAtrUrW1QoIhN+o2MgZZYcFX96AuoybW3mFOI1yLw3wFQ831HPvWoYMPsfUz7XMY85nd5Vm+5hswNqtJvEt70cp54+gh99tBB/mRpDzPRxsEcH6XN8tBXgDdARz4h9noWP+Oe+q5wwG+jg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(921020)(56012099006)(11063799006)(4143699003)(10067099003)(261022075727099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eG9iT3cvOTgzYmRkcnlNN1hBQ2pTOHVGQjh1Z2ZGSTRkU0pDVmduNlQ5VWtk?=
 =?utf-8?B?MC9vdXVCMHl3T1ZCRzV1WjZpWXFJQjUwUFd5OGVpcWpqdE5jUFNXODBHeGRE?=
 =?utf-8?B?ck1TSERqenh0RVpGeW9UMERnZkFLTDhGNERZZVZka1ZnWm5aMTBCUGtOeVBj?=
 =?utf-8?B?blFsRHFtT1FFWVNMOTZ0S05pY2RxWUtJZXFvNzQvZmUveDRTempmNldYVWhL?=
 =?utf-8?B?OFpDaXpJVmxzL1Bzcit1a3QrZmNLNHVEaElsQ0EweHpDcTg0Sms5enIyZEVD?=
 =?utf-8?B?MThYSVYrclVwcjNhZFlqQWxFOFJVdGVqODdhSGxRbWJtMkhHb2RCVE5WUUV0?=
 =?utf-8?B?WE5haXp5MmdoZHQwNE9yaXZtWkx1RE9zWjVobVRCczJEdUwwSkIrYm16cXMw?=
 =?utf-8?B?QlpaRkh0R0k1UjZ4dGVPK1JMampPYkdhR3FoYmlBUnBhRnVNd1NicFZwK1NN?=
 =?utf-8?B?QlpKL3RORkhtQ3NnOU5QakUrMUpRR1gwdHp1VGxwYjBqY3l6SmxrczF2cGNJ?=
 =?utf-8?B?Vm11ZVZxZFlHR05lYjZJaTdpTmdJN2dDR2taZmZvb2VDNGlkNTd2bzlnUmpO?=
 =?utf-8?B?akloZWJidDJSS3NCS1Q3S1pGaTVyclI4b0RMVFVNa3doT3c0U2NJak5wUlg4?=
 =?utf-8?B?ek0xeVFHM0xobWk4MnlpMEduVCt5RHd6MUc1VkVWWWFkUzFvc0IveDNXbXdl?=
 =?utf-8?B?S2I5cG1TdjRMQlBQZ3h4Y0l5WHhzMGxYVGptN2d0WHFobDR4SUhJNHh0WWNx?=
 =?utf-8?B?akhySjBWUzhpdkt4T3FjT21IMmdCVUZpQkhhaDFEOWk1cFg4L2R2V2xXeXQv?=
 =?utf-8?B?ZlVVR2dZTWdFaGJDV1lrRjJQUzBCb3J5cDdmMDZiRHI1UXk4dyt5Wm9tNmhM?=
 =?utf-8?B?Z0gxRFNrQTBaNXMvbnFJb3p3a1hxWnhYeDZNc2FvVDRVcDdjZWR5UStQVW9D?=
 =?utf-8?B?NXJhTzUvNFNTemhSVEw1dWlwTUVsSTNwNjkzZGFBbWk3NEk3QWdiRFJjSEZG?=
 =?utf-8?B?MUZEUXBiak1UN2hDQWZtWFNtUTl3UzZrbEpZa1ZvMk41blpiN3hWWHJ0WUdx?=
 =?utf-8?B?UFhQaitQQzNpTW52RGdZLzNNWE5RWXJpQUo5Y2lOaGxSbGtZenBWcllMYTVy?=
 =?utf-8?B?SXlVMXVOd2hKUTQrT3pja0xHTmhWY1lXS1R5VnpDNnRHc2Iwd01CVWQ5Z1Ax?=
 =?utf-8?B?dFZYVVc0VDM2bEN6MFoxSFhSYVhWcTdFVlljZVpHTVdkZ3NzZWo0TVM3UzR3?=
 =?utf-8?B?dFRTUXJYaEp5MWlHOXROT2dRcDJFcFQ5T1hCTURabWRFeDl3ajRvVUJkM0Zv?=
 =?utf-8?B?NHBXZUc3Z1FEZTBtajJqNXNaZGVBTzRUZ0g1K0dnYzIyb3hodEoxeWhNdTF1?=
 =?utf-8?B?R1BnbXdPSHhmWTZEYkkwQ3JpRkxkaUR3Uk1nUnppNFRKNXNhYk14VnhOTkE0?=
 =?utf-8?B?RTZpaVdhaWY4WHI5Q0oxVXpuOXhwVjBKRERqdWxTcHRQajJnQUJLdE8rMkkv?=
 =?utf-8?B?NWFCYWNTVGFsN0ZuN2N3dmwvQ3ZlR3R0TGFDTVd4Q0JiZTRMVWtvTEIvYm4v?=
 =?utf-8?B?RkJNMXZoZmQ5YmgxYTViOTlUYitnVlJwZGkxMUpBeXdieVNxVXliZU5NdzlZ?=
 =?utf-8?B?S2VhSzVjQ1FjRUNPYzd2NW4zR1hVeVplVlZkcWQ1bUlielBDWWFhOXR4ZDFO?=
 =?utf-8?B?aWlWL2dDNDkrNFJBeEVQd1B4NE13bHZkYjlQVndObnlXNU9kZ2phRXBTWVJn?=
 =?utf-8?B?WkRIdE0vNkxLaEdNeXhoZis3K09UMHNudkFVSGRqUzFuMmNoeVVlRnhsYUd5?=
 =?utf-8?B?VmFmUGV2bDQ1OTVRMmZ4TnRNb012NFFwN3QrVE41MnJlMDhoRnliV2RPY0ox?=
 =?utf-8?B?NXF2TWFrUjg3Z1ZtSmI1TnlEVG1ndmdFZHFDZXdCYmFiYW5SUXFDNVltRVBT?=
 =?utf-8?B?djhudk9FR2tEZlhLNlpuN2g1SUlJbnhjVWtkcXNybjZBSjd2eThieTdBSS9t?=
 =?utf-8?B?bVRMM3dUWU9xRzd3SDdyZFMyNXlmOFFDekd2QWFRbE1CUHJnRW1EZGFxcVp6?=
 =?utf-8?B?WXJTQzdJS2hBRzNNaUE0YzFISHhOU3l1WWZkN3Q5Ym9xeExjaWcyNDUvM0dC?=
 =?utf-8?B?aHAzQkNGZWlXMnRkdkVZRTgySEx0ZXJSL3lyZU9XY3Fhb2U1WHN6Y3JCcUhR?=
 =?utf-8?B?Y05VZjVoWFdyWDdPN2RyQTJjbVVtRVcxWVRBeHpOOVIzZk5rTFVhY0UrdHhH?=
 =?utf-8?B?Y3IwcGdqMzkvdWtXd0Y0QWhNUi9UVjZBN1JXVWlWTUxZR2I4c0VtN0ZNaW5r?=
 =?utf-8?B?NTl3Q3R0b09MdzJtclh4cU1taXNZNTFST1dMOXlqakIyczF0a3Rvdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4640cd-7ed8-406d-3c9f-08df3624670d
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 01:23:28.6964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zE3O7C2df6T12jErZhJkNCFT6xErQSwZ2y6yLVLvli0e9b/jLFcsF/MLRlKu9NSk6JTwChPtH89C84bIOmOFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9478

On 10/27/26 8:01 PM, Li Ming wrote:
>> +
>> +     rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, 
>> &ctrl2);
>> +     if (rc)
>> +             return pcibios_err_to_errno(rc);
>> +     if (PCI_POSSIBLE_ERROR(ctrl2))
>> +             return -ENODEV;
> 
> I think this PCI_POSSIBLE_ERROR() checking is not needed, in
> pci_bus_read_config_word() marco, if bus->ops->read() returns a error,
> then the function will use PCI_SET_ERROR_RESPONSE() then returning the
> errno. That means that we can always get an error as return value of
> pci_read_config_word() while ctrl2 is an error response.

I kept the PCI_POSSIBLE_ERROR() checks in v16 because I believe 
configuration read can return success with an all-ones value. For 
example, pci_generic_config_read() returns success after readw(), even 
if the value read is 0xffff.
Please let me know if that assumption is incorrect.
-- 
Regards,
Srirangan
