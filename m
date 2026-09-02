Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012069.outbound.protection.outlook.com [52.101.43.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57434326928;
	Wed,  2 Sep 2026 02:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788315193; cv=fail; b=UXZfrnBKVDYXRI6R7Aogwsd84786pAaKeM+3fvXwmcO5bATcl8qaYOcyaJpxJIQkxzq41/uWU939UVz9P2R4O+JxQGq3XOpBR30mRFNSu+5FqXYxGtcKG9ccWsTR2rofmifMPnbZqW5sWdTYFXGOHiuh0OJxpSMIGPHXjfaNquY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788315193; c=relaxed/simple;
	bh=j1Cn1/7loiKv2v7624VkdVWYTMxUBpMgijcMtE/inyE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V7GtY8d7V6mMeljKCwXe1h9Te/qi14R8KPljihnbSD6ePE2EjievlxadHTTMGfNPw/mCllJT5OZV1QVOo5nmhDo342Z5k/CtNxSoaRJVC+6fFcTy0jOO6Oe5M5YNmTVTqhH4/g0d/IfESru9nNz8j7KwXvLutg2ZsI1W60XCPrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=onwFh/Fd; arc=fail smtp.client-ip=52.101.43.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="onwFh/Fd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSdwWE4XGqahx98q+6nJuJP4bdc6ExWgC1F1weNKaAasHv7iK6mYg241Qnlz/rr6BpKCAf+1OtO790zvKfyVmP/NdQt7QsSqOlKVE0ZWEZeTS5bf19YomS7b2HG/qk4iislRBuZzkiDcJpg8l55hAEEpwecuRfZKoNMqsmjCa7wIURaSBm56fd8br9Y+0FKSo6jeMQXSJ1W2MA3vdjb10PY5owcH2nUgWMncid/Fw4KW5mSWWwsYZR8tVMIsCJXsuJS/nQILrK1p11MM4x0QZ/YGqEs8EmqChCmsX0ssHhPQ/a2YcRszc22LOBdkduvYbq8kyeloNkLXe/ijE4j5Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CH8zz3SvbZ89DOpYZLpQ2d5wQwX5Kqmky6+oUb7Wn/E=;
 b=KIX+VThcqFCMr06Gx4YaSRVQ3slKY0UlycxnWhH2kHPaJU/vNthooBsvQBXclgzAO9VT1LQcMrNT0GhaNMveIgf1XpiRMGeeRkXDoNeTsMiAqSPfNgjmSZB/eNlJTMrq5y3h5kVCS5ly8MC5P7hFgyOfbuXcaN/0JySe0Q0FOCHINJpL8Hdug1yJYAFEg8oeWEuwcDCLak7BlLaK//BQ8MovFr2JH3atynqPmgx8Ygk7l9LK53S8PMLkkvdOR+CqdBlMan1LzDe941qcnHCnvJMDbvUJoMrNmBlQiCrUod7N+hiWb+oWPChV9JO+ztk+8HbkhYHfwenyNLa2Aj5Xjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CH8zz3SvbZ89DOpYZLpQ2d5wQwX5Kqmky6+oUb7Wn/E=;
 b=onwFh/Fd09lsFgxA2KEmzbdl4NTkEdqJ51M+bB7AXtAffyrKxm+0KGTy9kIPUB6MToCJPkNk5o1PnnXLjVl2U8YklyuAkavnmdD9bMYXTAx2Wz8vcvxoDJQxeg7qMbxUOMKucbk/7rt2GGUvea5JfP5cKn/Xty7HyBMzeMClcfmijcfWGXLK3uOdpFQNQew7Dr6nASik/GcjOrgrSZRmCGkn9PO4yRE9mvMIHRB29srTSVtLr2Col6b4fZlHWK/TLD7fG9IDGUTKqzV2OqhN6yNKwsvLR+FeElPzNS6Pgj7tb6dwiORKRisRQjs2TEwHFcB+zdKEebl9C73lpu6kYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 02:13:03 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 02:13:03 +0000
Message-ID: <763e7cce-bae3-4d85-bf59-2c93ad559afc@nvidia.com>
Date: Tue, 1 Sep 2026 19:13:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 04/12] cxl: Cache decoder settings on PCI devices
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
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-5-smadhavan@nvidia.com>
 <cd115bea-68b4-4b7c-8cad-93f5fedfb6fc@zohomail.com>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <cd115bea-68b4-4b7c-8cad-93f5fedfb6fc@zohomail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0092.namprd05.prod.outlook.com
 (2603:10b6:a03:334::7) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|IA1PR12MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f38fcf-a306-48b9-40fd-08df0897b808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|18002099003|22082099003|56012099006|4143699003|10067099003|921020|11063799006;
X-Microsoft-Antispam-Message-Info:
	/3IW7M7FqZwbDkcOOMP1ODQa9Exf9G4CylGayuQ0h2uQNndyZIE1YKddUyOYUH+fyHKAjkrWzypjKmVGXHnGHJNyP+m0x0iTQ8eIMLSdI9NAr0pXFxJGqW2GtR/ypLvezATcorRsm/aLJPw/KlDhEAcciLxZgxo81ObMl6eueljlbbJN3WAMKGj+rE+sXkaiQDS4HHcjIyT0PvrHvrFERL2NyqFS8e60nvUJ7xytl6YsKgQpZlfIqQASX+xYl5VxjK+kdd52iUXPSqVLDUSeZEbzbpsM2wVadeAGKN6cUvupTrtEgbZS5ZDWCoVIxhLeGI1h6six57UbRXhmjfCcNbZYxZYtYNljkFALlJFtw+B8Pf34gUZIaRXGsbCDrGxyX+k0I4Mv1d0opkcp3Ojok6puzVS1vWPNG2JTFqQ3mUnfG81vR3jQ0yrSSBdYn/zC5IiAKmvAvFyppu+W6jCNCNpr0r9J/AtbM5BfIA+Vhp3h9rmvd2iOcXjOvf0LProk5cXoZJvGeuGXquSsbo1f44wWYCDlFaWQgNTPZxlxTHavy29QGJ90RKqWK+NxgeqcTzWEXTLhppnYyS78+brtdTVZHPJSVbGiY6dt/6KttOujf7qwVUgA1ID7j8f2oJ6rSIXz8NIB5NgPEPvLl9q/3/13KIm+hy2DwLc5dMA6G99d00JYHSjlF8ZnuCqEs7bKmd59aW8namPXtnsTfBT2CQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(18002099003)(22082099003)(56012099006)(4143699003)(10067099003)(921020)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3hxWStoNm1MdWd4MnA3eHdIbCtHMXAzUkZyQjgzZmNFbUx4NUdOYUcxSFpi?=
 =?utf-8?B?MGJIWldrbFhPZ0VuT0NOd2ExMDVOWWhSOWhXSEFWRHBoWWZlcEpHZnRSQktY?=
 =?utf-8?B?NE1uc0MyY1RhL2tZdE1DYzdzeHZkNVdHeFBaTVA0Q3ZWOHg5cEdzY2VMeGJR?=
 =?utf-8?B?OVloazRsK3U1UmVkS042SlZ4dkRwVHNQVmVYY0F5R2EwbW1zTXAvSUpRczZv?=
 =?utf-8?B?U3NTNkxTRU9YRm9qb2gyVGN1VkdGZXRwZVNZR29ZR1ZMcjdMOWhCaG0wdW1Z?=
 =?utf-8?B?VkVWMG9UWDRzUjZRVUk4RUpSWDF4dHVGMGs5OVRLK1I2bm5TZzdXK2VtQVNm?=
 =?utf-8?B?Q1hqMWhiWHl5VFJRbWxSQnE3RU1VcUxzOEtrVVBPWEZtWU1UWG1ZRDhlY3VS?=
 =?utf-8?B?WWV3TWtQdmh2VzZ2L09DOFMyZDRHRi9QcE01T25jSXdmQytOVkVwUm5heWcz?=
 =?utf-8?B?WEdXS3FBRS9vaEVGQnRlVHBIblZ5ajFxd1ZSejREMlVTNG5SMG5Sc3hRd01V?=
 =?utf-8?B?NGNpK3I2bEE4dy9jWDRoajZpK2E2WktCMHJQWjdFUlRGRHdmQnhWM1U2R1VI?=
 =?utf-8?B?UWRVZTF5TTNwczVTOXZlK2s2UFZLVnppSm91U1FEejY3SGtwbGVYZE5pMWQy?=
 =?utf-8?B?dFlvRUVOU0pZQmRHNXhOOGxGcElTOE8vSDdGTyt0K2w4bWs0T2xnOXkzSExy?=
 =?utf-8?B?VVl2bE12QmVDSE5ueVNKRGJHVFlPUXRXemlCQ3ZlT0srWndaM0pRUEZUQVBJ?=
 =?utf-8?B?UWhpditJRkNoL00wVXdaNEZBVzVkUnJnbHAvd2tqcWROSERoQi9WcjVqYjF5?=
 =?utf-8?B?TkpqWmZpTmo1KzZpcWVsTzFDVXdzcTEyZmJFeWFOZ1BvSXZxMXdYcGdQclJC?=
 =?utf-8?B?ZnRwZGM4ZDc4Zzd6V2VXd2hiMmVuTHVraVo0bUdEMVRUNHNRYUcyRUNhYkUy?=
 =?utf-8?B?U04wODRoMTErUGJ1SnJka2poQkxyeWJPNHNPZGt6VCsvd1Njcm1xSEpGSGRt?=
 =?utf-8?B?Z3A3THFqMnQrWTd0SEFwTkVMUTBNNXlQOVBzTmFYeWRNLzFIdzlLSHU1czMr?=
 =?utf-8?B?UThMODJvVTNEUHNGYWhHT1EwQm00aVd3Y0hSNDZBWTVIREVBR3JCS3hpc2JO?=
 =?utf-8?B?M0MrR3ZBZWdXK1lRdEJlT0l3OG1SYnd4M3BDY1g1TTFHYk9JT1U2VjhLWTlt?=
 =?utf-8?B?aFoxbVlOTEdWUTltVHJ1RTBWazB3OGFCblZVRVJKRVZubzBaOG92R2FiZ1R5?=
 =?utf-8?B?RVJNYUdJUzZ5bzhQSCthUzMwY0dtUG03SjlzazZyODVRZE8rUWJiUUxYUzNL?=
 =?utf-8?B?M2hSYmQ0ZFE5ajk1SzNNc29PbS9GSE5pM2lUV3RhQjViWDkwUzhNREhOdzho?=
 =?utf-8?B?UDBpbUd3Snh0VGdETTE0cTFsL3kwQUYvTGN4cmpYeCt3eHhrdDBkS0pNVXFh?=
 =?utf-8?B?eVo1MlcvTmRPNzk2RlZiNGRXeVlqTHF3c1ZiUjZMeGVXbEkyQmxsdlZPb0s0?=
 =?utf-8?B?c0p1a0QrQ3BMdlQ3UlkwTjFTdS9sZlg4YWc2bHlhcU9YWmx5aG5yUmM3VXNI?=
 =?utf-8?B?SEdSRmZvVW1NVzdBWGp6WlJrbFY2eHlYenJrQzA1ektReWxXOVRnbyttY1lh?=
 =?utf-8?B?blRYNmhVMUs2cUtiZEg5RkNrZ1hDT0VzMnFrajlRcHhSWFBENHUrSi9QSTl3?=
 =?utf-8?B?WTdQM215YmpMVGJjeDlKRmVzMmpHcEt1VmdQbFVTSm1jaWN3Y2xBVDRhSGJ4?=
 =?utf-8?B?cXR5OGk1K1hjQk8xaGZIVXV4enU5NDZDR2JEYk5TL3c5VXVYTUo5cHdORGU5?=
 =?utf-8?B?eHlQanRMdEFIbHpDUjFyZUF2WWllZFBUcWFqandLR0VqM2tWdU1nVlpNRkVF?=
 =?utf-8?B?TE01eXRzWGdkM1dlam05UGpWTnlMWVdwenM4UUtwRS9LbVZXTDhXVnZic2Zo?=
 =?utf-8?B?NXZUK2FEcUxhQjVVeEF6SjIxWmxBeHAyWHVneEprTlJwMkh5SUwzSlpyQ1dt?=
 =?utf-8?B?dTJsK09VWHVncFJVbFVQQU5uampQQ0QwN2cwUTRrL210dlROT3hqck15RHpO?=
 =?utf-8?B?N2QrL0JwOXIzU1o2SUh0SHBMNmt1bE14MzBhVFQ5L1BJZmNvNklXLzQ2N1Y0?=
 =?utf-8?B?OFNOQ2pBTlhZRXN4MEJScWV6RmdUVnhrN3ZSZzdaUW50YVlKTWh4UEJrV2Za?=
 =?utf-8?B?dzQrazJJWmc3RlZWSkt2aldNRVE0aGc1ZHYxTENZdnpmSU9BSG1mcWYvWG1w?=
 =?utf-8?B?aFluL3ViZHdoR0JFeHZWRjRUOWY3MXNwRnIwVnUveFNIb2hCemFKM1Nja2Nx?=
 =?utf-8?B?Z0hOYjZMcHE2K0Yxc0FwWFB3b0V3emNnL1Z6T1dkWTBWZzQ0RXQ1QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f38fcf-a306-48b9-40fd-08df0897b808
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 02:13:03.1696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a7CBpH/HCFMbtU8OAwZaQclXfmNUR/PlVL6uxx9LS+0GmPCH+RnZbt9o9JrECrDDPzF4KsWgR5y0xTqZrCdu3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017

On 8/24/26 12:53 AM, Li Ming wrote:
>> +     bool present;
> This 'present' is unused in this patch and used in the follow-on patch, I suggest moving this 'present' related implementation into the follow-on patch.

Ack. Fixed in v11.

-- 
Regards,
Srirangan
