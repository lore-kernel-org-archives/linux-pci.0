Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795162846;
	b=zLmeITPL6u0+0josULawwB8BfDqP3GZ3dnf25rr3YyEjfTq2h8AgYN/EfWrBkv0M+AoQ
	 PQrYbtvuPW59aURu10+fP52+I0tidChp+OgogSuOLoNBsDz53qMD1xjAMvE2uOtEOUvQi
	 ai2QsEkBIOSrN4jDMU2X2stGCdMtEOutlbMVJSgqg3WkwxPsMAcd/khMRQ22ZTrfZ8+3Z
	 Pe45p2xzZOzoXj5fIdbLFu79rWDl+ZPqqYTmGthY8CwVrd2QEf4/GQJHDkrDHMkVSC8X5
	 qhp6l9bkZ0FLYWuZGcI248TA2OYHDIYrktVO868SSIg8Xr2Qw69z/AazK1JCT+qsfAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162846;
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
	bh=mVmbLUy6FbhhDdwWxcVMHasfEkqq0FMCjC2OvJtCgJA=;
	b=PHLJF/sjDEW3Gk6Wipq9lklt+2jlDNU9x2i+gSSUkpDLrci8xa74sOaerXtLCackXhrc
	 SVTT6VjuJnkrshztAveMJhMHwYKhH9VXhkzoYKDZFN1RMOO8kMaEEH5oBkxQXuLyEPbmB
	 MIiEUvQne7/xr1w2uNCF8XXR/KXJVbirxW0uYTFfW/TdcQbOhbyeBul12Yk7vDBFI9p6o
	 ygqeKH2zFw6WSA5VITL7kMncP0MdrHeUa6HtQZ/FD1yJnF0NjmTpH5qmhwOLOXj50RUgZ
	 /UWMLOhlCbewFEHoX4T2IvBv8VkTByfuW/Ov/OtP5VY6TLD5B4RPmxSw+PiR8+aG/wA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eoiFfpSu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.12
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012012.outbound.protection.outlook.com [40.93.195.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050DA606A338;
	Fri, 20 Nov 2026 08:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 050DA606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eoiFfpSu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBB0fHUKSb/AFIQyDx6Mn+YZ0DKomOHSG2jzEDTRROxS1tLqYPPgu/4vqsQEMUzNPJdZ2S7Ji6eb6gD7ZmUafMQZ6TByjjbbVWSs3G92zM5ggrxuNDzLzyZHW4oFuH3ku0sIk6/VLrxdLKdi1cwGie7fp0yEkKqAN0GBZcdMzMbQaDOYtfzMwLBH3tMGFJEdPeTt43xTe5/HrU+PlxysVrWDAh8wfp39eHYM2euqrc14J5LJaWBbOxjcoQQyIa5iR9jxFEECIQKUqXiR0CU03T/cC2nqDNgcDuMlWtunkpc8Cdm3Goh/X0HnpSod8ZJKdubaHCnu4VrgHLhnIAB/og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVmbLUy6FbhhDdwWxcVMHasfEkqq0FMCjC2OvJtCgJA=;
 b=Tu0Ae9Wggbm3I9xRMm1sfgAZHwZFTlk3CxIFbIYhpKVw4cwmIRDJXYXl1gvUISya31iwdTfGoMTs1o8VQyG4BPWp8LfL4wyF02LmLWAhy7LFdnkxW/aVJ4fL6+PytjsNN0edQBI3Vw+X9i7vM3BGxbZ7LAtSqCwHObwu6vwQKaKRz7LQ9HTEY1x4lnEJSb5aoYACbOfga4mXJ5asV+8xEhjO+ClP6936yTjWbNvoMGCXIgN88/FLDVP0Lh2VvWKz1UbPzyXoO17R723uP6yx+6iXJhPkYsNnfmYirm2MSacBShcXf8N78jnsSgyrmlSFXzMYR/Yg0AfVWjMA5oRL2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVmbLUy6FbhhDdwWxcVMHasfEkqq0FMCjC2OvJtCgJA=;
 b=eoiFfpSuEEM6+4uqOA+bEqSIJLIain9nTksnFOqfGEUNQXFZhBXBtNLEFuR6r7FsBSJf/TjFv+OzM627HS67FxlpW5jRHPAeUDQL4k+m0BCmOsv2XR5QYNZpqqskVqgliez6nKlOs+ZuxpR/U+x3dRTrl7llJrwszU6VWa8V0IdgsopiceAoJHZQUw01T0zAsEF8AeiqUPnFQ8M0wBN7B8tApivbcqqdvZ/LQkXst1bGLvbt1z9ZmukaILKrTwgtwxLitoNRxGV+2U5KCwQ2hEHoUeeBAaHZxfxlOqk6lPeltvFQs76jt8jNAnx1hpK+cOU0vP3KL3L6jA3tPDKikA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by MN0PR12MB5836.namprd12.prod.outlook.com
 (2603:10b6:208:37b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Fri, 20 Nov
 2026 08:20:38 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 08:20:38 +0000
Message-ID: <e5eaa99b-552e-4f6d-9c3f-98f7b309f46d@nvidia.com>
Date: Fri, 20 Nov 2026 00:20:34 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 13/19] cxl: Validate and synchronize HDM ranges around
 reset
To: Alison Schofield <alison.schofield@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <iweiny@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Li Ming <ming.li@zohomail.com>, Joshua Machauer <machaujo@amazon.de>,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <20261105185917.2667656-14-smadhavan@nvidia.com>
 <avyPsvwV1_lc9va5@aschofie-mobl2.lan>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <avyPsvwV1_lc9va5@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0100.namprd05.prod.outlook.com
 (2603:10b6:a03:334::15) To LY0PR12MB727857.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: 23e968bf-4d11-484c-efbd-08df46df2880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|22082099003|18002099003|261009223027099003|5023799004|56012099006|4143699003|11063799006|10067099003|261026121527099003|261102123227099003|261022105027099003|261022075727099003|261021121427099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	QZQ6ldhjNRJA8JZfIYFWjG8hnrThwYFlNIaCWnKNslWhuv+Az9rrfn7Npi13ych4u4AursAo5HFO8M3DSg6gLW4Mh38HIT272yiOq3Or106lM/a5/ZEE8P6G0CVAO4ZAf/KgpsiwaFMT1JgBBCLP7qjZMO6nGG3zunkK70eGdzjbB9LMU4wx0QGgE5JTt8lBc2Fti/HX2UG9yHuTrJgHdUvT36qW8jqNvlBP1IXoaoeK4u48j+CyIuHCpxO/GXLzJVv0ydVKEWE8e6Dt6MLJ+oxB0dmlfeGXxH6PD456SmoE3cF0THDknPgpvNmoxF+DHsHaPhjdP8cryA2RdSU2ZpMrOMXjrK8R5HBmlUwJMcoD75033jPGxWASMQUIZVx1u9N7XV2rdovU8xsytQCFck27YhZSKfd6iSP1/QODgY+JTfeUreRZezydZEfjabjvHNpjtsg7W8NPp31KvkeEeR9GRkEr4CjHDd73iG9uG8tFC5gGRlK4gfWXLLmLtVVsHYqsvj3dduyWz4s2JH+o0zuI6T9+mYXuTihwu8P4xo/D4gxXcA/6miIMyW3B2xLfeZNfK83qF8WKEF3pBB7PM35vtWYnTgb+344Wi/Klu+XcfGJSWC8rFTWubT2osP5mhwldUFJZ69CPks9R11MI1GXpJsg96umAO4GrbIMLLkk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(261009223027099003)(5023799004)(56012099006)(4143699003)(11063799006)(10067099003)(261026121527099003)(261102123227099003)(261022105027099003)(261022075727099003)(261021121427099003)(261028144727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0c4cER5VmxObVNHVjZKQVZUQjRNMHVIM2ZnL0oxcno5VWZOdHpsNEFoVjhq?=
 =?utf-8?B?SXIwK2dDc0J2NUlObWttdzNtWEc0MWE3WkJXOFRKa3ZqY1ZOVXFGdSt1c0FN?=
 =?utf-8?B?MG1GVFJONVNyUmhYNFZrOUNpZE1SUUoyV3hZMjA5S3NJMWIvSThlcC9HZzFD?=
 =?utf-8?B?QUdSL1hwMkg3WlhEdFYwWFRmSTRibWg5dEdMTERrenl6Z0syMkdHbXRPRHZp?=
 =?utf-8?B?SElzeGZybm04TFdCWTFPeWJWd2dUZUxlNDFnTTVqc3cvVWYzMTRQMCtkMzRj?=
 =?utf-8?B?c09zMEd3NjRXd2NIZzE4NHFMcUJVWnBud0FTeUxuajUyWmRvS1NZYkNBVFJP?=
 =?utf-8?B?UGZYdytDOUtPU0VNVzM0Q0VjQi9tbU85ODE5T0l3MUN1SnEyTys0UVVJZity?=
 =?utf-8?B?TzhoeWlsaWVmUGQwZ2VLSUlUL1p0TlJjeUJhUU9QYzlKWHUvVXMwTmMvOC85?=
 =?utf-8?B?K0gydHM1Kys4Z2psdG5odzBZTVd2THRSWE56ZnZJNENtTS8xQmJ1WXc0UnV2?=
 =?utf-8?B?b0hjYWs5NWdFQ0ovMktNcW00Zk9ZRTEyWUhJUzRUTGJXSWhWQ2t2WllzbWRn?=
 =?utf-8?B?cHN0cDdtdlBJZmdvWUl6dm50dS9tVVk4T1c1Z2d3bHFuUnhvTlhwMUM4cnNp?=
 =?utf-8?B?QWgyUzZpdDN1aTRJSTh6aFVIZ0NCVEUzc3Q4RThEVnJRclYrNVhKSytQV1Vo?=
 =?utf-8?B?Z3VoNFpUVXVyNDdvTlJaNE9UMEVZZlVkVVRJZmNlWTluV29NZVl2Qll2RXNM?=
 =?utf-8?B?WjdzOGYyTDVXUUlYelg1emQzcDZzUXBwRFQ1VVBHUnZRT3JSREdyMWNSSzg4?=
 =?utf-8?B?U3hLd2lXaTNGS05kSWZ3L3o2V1BDdHZrKzFVTVBJUVA4Qk1aN1NNMm95SSt0?=
 =?utf-8?B?TTVmVXlHcDl3NzUwMmw2STBaV3RPYVBqVEpQZDFxalhoUVR2UVdlcWZ0aitC?=
 =?utf-8?B?MW9SMmh6UmdObzdxazNzNEtzcGR6YXhCS1kyOWJWaUp5aUIxUUdzM25pcGNQ?=
 =?utf-8?B?U0pya21sU05sT0NVWlI1ZjZvRzIrUWxNV0NvZVlENXhlTmNNdnhQU2tVdzkx?=
 =?utf-8?B?dzZCTC9ISEZLVFdoU3c5Rm1YRTBZZE1UWGExVEhQNXlhbFZyalRmbjFzaG9m?=
 =?utf-8?B?MUNJRkVBNEJ2WmhoSGgvSlhxdTRydExsenlEYlRRb2p0dUFxenlZUkMwWmE4?=
 =?utf-8?B?a3Eyam5Id2tpTWtEWGtIR285M0UzUjczQkpiRmhLaHcxOWRDSm5kQzRBbkNC?=
 =?utf-8?B?c3Q0a2swL3BFdGtoaDhBRG1SbFdTWFpDeThyOU9OcERJR3B2dkFBME1reEZl?=
 =?utf-8?B?OEI3VE1WYVVxakliQWk4bk03TDBSVHY2WHdmckVEdFJXWXZLdVhoTG95VTFZ?=
 =?utf-8?B?QjFvdEJBNjNoVHVtTXN1TjNCenV4aGlQNVhxT2RpNUlZQktmSmxQUGdpek4y?=
 =?utf-8?B?U056MmpDM1NMZW5WQXlENUlQT1JnSVNyc2ZXSWkwTnRtR3Q3MzhCNUJYSzRJ?=
 =?utf-8?B?ZlozV1BEell1L08vQWVodXA1NHZhSXVBRjdTTEFOcG9tWFJ5ZjFCdXBzOHY0?=
 =?utf-8?B?SVlnREpuSDVlVWlUU2tyZFNMdjZGTVNsVUZBdnErUzJZVkNKM1FhdC9Nc20w?=
 =?utf-8?B?STB0WWZVZTF3d2RZQ201QXJGbGRpN0YrWGhLaWNOQkh1cERuMGdjdDh1YldQ?=
 =?utf-8?B?LzNrT2E4NUV0by9hZVVlMXhFYzlFWGhmOEphUXBnbXZFV3hZNmNwWEt4VERj?=
 =?utf-8?B?SUZGWHdCSGk3OE4rODh1eGU0cXJPRW1qeUE2MVF3cXJnZ3c1dFhPNXNHYnNI?=
 =?utf-8?B?WnVmeVFRaEZnc2Y1aHVnOVR1T0hYSjVWeTltMWpaVW9YRFdBdW5BYXRvakxZ?=
 =?utf-8?B?QW5aTGVKMVZFRGNFSTRoQzExbXdDcU9RYU85VWE1cU5vQ0pSMWtlZFoxNDVj?=
 =?utf-8?B?QnpzT08weDBFcVlFVGpCbGx4NnM0T1EwNGxTK3ppS0VUZGtTcWZRV2wrS0Jv?=
 =?utf-8?B?VERZQk8xTFhRb1ZxWEN4amxoalNjbzI2QWNoV29YOU1KdHlPYldIajcwc0hS?=
 =?utf-8?B?cE1oYWdwcmdVRzM4a3k2K2ZaejdEQmZEdEhLbmVUcEpPb3dFMXQ0MkZxVEdF?=
 =?utf-8?B?L2xCWTlRV25VTEFqdVNaWFpCTWFvb241bnUvbE5lbjlKb3pwRjk1OWtpVXBl?=
 =?utf-8?B?UWxHRm8rTkZWYU83V3lCbTBTWEsyTlNTOGwrNnMzUEVXTUNyNVA4TFJVL3lr?=
 =?utf-8?B?RUY0Z3VuOXNLenI3ekc3T3Jub01maDY5bEFESnlVYm1YQndaYzVucktXbU5B?=
 =?utf-8?B?WTNBQWpRUzNwbHhnaHJMVXZsSFJyRHRualJiUWFhZWxrempaNkRRQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e968bf-4d11-484c-efbd-08df46df2880
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 08:20:38.2674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dM5ufmrxHMQRAjC6MNjj/NNYdffmMomFNZVk+xiR3/Ku4puCdZz89Ax+d4IRPm6nJC2L0h6CIaJtYoaNB0uaLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836

On 11/17/26 9:32 AM, Alison Schofield wrote:
>> Refuse reset unless enabled system-physical HDM ranges can be reserved
>> exclusively and CPU-cache invalidation is available. Invalidate before
>> reset and again before ending IOMMU exclusion, holding range reservations
>> until the second invalidation completes. A later patch places state
>> restoration before the second invalidation.
>>
>> Userspace is expected to offline CXL.mem users before reset. The
>> reservation enforces this for claimed ranges: the reset fails while a
>> conflicting resource is claimed, and no one can claim the range during
>> the reset. It cannot see accesses by code that uses the range without
>> claiming it, which the offline expectation also covers.
>>
>> Reject normalized-addressing decoders because their cached ranges are not
>> system physical addresses. Record Normalized Addressing in the cache when
>> region discovery sets it, since the cache is filled earlier. A reset that
>> takes its snapshot between endpoint probe and that update can still
>> miss it.
> What prevents reset during this window? If the snapshot misses the
> normalized-addressing flag can a reset proceed and use a range that is
> not a system physical address?
> 
> Does this mean we need to prevent reset until discovery has resolved
> the address interpretation, or is there another check that makes
> reset safe before then?
> 
On this first part: nothing prevents it in v17. For v18 I'd reject a range
that isn't inside a platform CXL window, on top of the existing flag
check.
>> Ignore zero-size decoders because they map no address range. Refuse reset
>> when the device decodes memory through its DVSEC ranges instead of HDM
>> decoders, since the cache holds no range to reserve for that memory.
>>
>> Hold the global cxl_rwsem.region write lock across snapshot, reset and
>> restoration to keep the decoder state and reserved ranges stable. This also
>> blocks region and decoder sysfs, region probe, poison operations, sanitize
>> and region-aware event tracing across CXL devices. The Memory Clear wait
>> lasts up to the timeout the device advertises, at most 100 seconds; cache
>> flushes and other reset work extend the hold.
> Similar to questions on previous versions and in cover letter -
> 
> Can a reset acquire this lock while other CXL devices are still being
> discovered and their regions assembled, and block that work for the
> full reset duration?
> 
> What limits the disruption to unrelated devices, including repeated
> resets? Could the locking be scoped to the affected device or regions
> rather than holding the global region lock throughout the wait?

On this part, yes. As posted the lock is held across the whole reset.
For v18 I'm proposing to hold it only briefly to snapshot and restore, and 
refuse commits of that device's decoders while it resets.

Details are in my reply to the cover letter: 
https://lore.kernel.org/linux-cxl/20261105185917.2667656-1-smadhavan@nvidia.com/T/#m82b76ee0215d67d91f67ec6fa72036615f1adb4f

-- 
Regards,
Srirangan
