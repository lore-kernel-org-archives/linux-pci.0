Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011046.outbound.protection.outlook.com [52.101.57.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0E5321445;
	Thu, 10 Sep 2026 01:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002087; cv=fail; b=Zkn02lQGWTlxFr8r7Zulv1y8nPaYSfDUCV2yNR5XYfG94sa0kCRD+q6vbfkHYmkSTIXrY79y8mpIcIio/hbsG35ZUmZHS6YXrqyIz9xCReirOdxvbcvcJ7Y63CymoyDBaygEddGXbbsvCJpLKgtTs3M6q0PD5z5PoByasCGhvOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002087; c=relaxed/simple;
	bh=ZSCXHf5CIcb9cXpHspi8f/OKKWdn9CVoknOxbXCIXGQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KtAKbO8XInsuS6aUgNba+OSNZTcJ0J8Muh1GDtppz3fATb1WHjLa/O9pzunSVfYhb0gMSuNyO0G9/YzFr7Wx8VZUHq9Z/g534I/nNwJ1DBDQeTCTzexLYAr4UBL5XOxTPF345pHF0fP9PWyrT54jsneUMH5AMGI9bVOPrsr/Tj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kWMUk2Mz; arc=fail smtp.client-ip=52.101.57.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kWMUk2Mz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+0Yq/SEzbnJjupU6p0dErKKQd6KHXQ/varI/oLhDv2aFRGzBhG9p2VkZmj3bgnFUckTePO0aJx3+lhKbBK6ZpE9BYQowYu3MHZbXm39Y8n4msJyrIjxEWzIPYO/Z2Nxhs31si0+0ZhSgV6YEd0QcU1uRmn06etqjQ4EwTQLVZxemGfu+UIdDBU503BnEn0PZtKgOeoIQuqvbFFnZt0IFh8tYJ3YQDlgkVpgyIgJXXt60HZ5WFUn40T7KX+9dRosiOdYxW4eT+xDCQFoiXs/QEGCZLiaPoCgmWeAqWSxPK8YzDumhE/WChWR+nW3V7YhIEsFX25ytRvR/HxZPcoeuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRPhpA0KJrvsw6RW1vxC4s/1Zk4vtDVnn7asRViuLMM=;
 b=f4SU4Yw+Kh/kfSnF0daS4WSPJ5OUMxOmfAB8YkC8biIrTrFnVzIiIh3j4cJHMN3vh8vR6Sp7tBiSB5L5p74M4ryyZFrX3Lx2BSQxa93tjle9tiPUAtp0hUZyUkklmOdtVnNPOxbZcls2/R4pKc0x0FyHbIdHgSzMEUbYIp/fBQER5+Nfki3lyPZqPsg1/nuqaIt22V+b1ZaJkxfWpwxwOKRx7+QFYVfySyqkl4znWFTwHSflxDq0n9mY94G29hsRO2GHeD+mpAKf2d7MMZjFxP8bUzC0ahyjsd2z17qAwEF+tPDGqO4ChzBvDOUvgJPUfQd1ZXXr+1bzAcHwknU+mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRPhpA0KJrvsw6RW1vxC4s/1Zk4vtDVnn7asRViuLMM=;
 b=kWMUk2MzAQ4npCNBbDs87gOxcmZ8swe5gNA5TTYghFYpeo6lEcMc0kZZWUZN7WHJ3DqqoMiW7k5ZHoZuSSdkENzm7YTx01L7Pe9VISavBy9CUqDFoCBt5LOOLEMCqhItyQ5F3wmDhywgj4goE19udXIrlEO+r5akWhVCiMQ3i2wVpHc5nY76AIGriwC9xyJVbAsFX+JxfFZs4XnMDpWfBp2ycgpBLof9Qr+w4BhxUfUBlparQ5Fmm+EnA0Opu4IsNKJhcbcfD0Ei3DtdKcz94tA0PQKFShhKWFflG/tUODykFtATCKX2jVZI8iSd7mAYAcljSmdIb6Jm6f8ewJJSXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by PH7PR12MB5618.namprd12.prod.outlook.com (2603:10b6:510:134::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 01:01:19 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 01:01:16 +0000
Message-ID: <b2297a6e-72e4-41e9-93f2-98a962e5461c@nvidia.com>
Date: Wed, 9 Sep 2026 18:01:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/12] PCI/CXL: Add CXL reset support for Type 2
 devices
To: Alex Williamson <alex@shazbot.org>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260902072804.665639-1-smadhavan@nvidia.com>
 <20260909151309.7e1883b9@shazbot.org>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <20260909151309.7e1883b9@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0231.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::26) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|PH7PR12MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f29390d-b65d-45a0-b9ba-08df0ed70489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|7416014|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DPfvmk3ikrjjJbHSH6PieeI32QL3x8mBvTPhQrROlV74OAskiHmAoSXY/uKJzbsOva32Itclw/F07jH64Y+2eNBRZ4MX7z3dKqe1Rqdrx+C/XPmjLAnpt0QwEbowZDZi7Pliek4xfoMbC2jk2ykDQplFMu8bUoFlK72Wp9B5a7uFzXK1/sk/Rb8Scelh6ltjpbnKIuP8Eo5cSrdvvtyxf1waNOc/WAQTEGXSb2/qd8S+KkkejGrb9MtI9/InaeYLacrb8EfKp1iePuHWaNeG1QjVUJVkJtsugkEZl60ml3fRhIKjtmf4BrlnbDx1B5TX35Dk9dpdK3p3N265fxqumm+uL8iRoqSLYv+RPxWjP6xHAMuOs5murD0Gz6MHaU9BtMzCjk6CMqu6m1yWVpZPqiptOsktbdqHwW7QdBS/1Pc1R/L4WefKTMtI0LKyZhPvshnPHjHJohl+7E/sFD52aVA4Tbh6TCfAucs1mH8oIAU/PSN2adhByW7xCJVNH2fYs3IsFLS6niMxXoe67OboFmFtk1qZ8qtDa4w5D+ww8X6Yg/Pu5RzVSLH/TvSLJv5FeWTtti31685YKYoGgl+xoJvbGvUvSUNH7PmKi3KqBGf7sp1eJDIivIJ+NV5DbsOgMbDMw97uw0SsFNo570hE+w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(7416014)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFhodmZzR3kybXkwRzc4NHRscmVXR0JkNGlsVjI0WHVhdzM1ZHk3QjdhRnlL?=
 =?utf-8?B?RE84YWtuOTBLT0p4bURGbWt1OXpJaWMxSURnbnR4Z2RHRmYxVTJXV1BRRGlv?=
 =?utf-8?B?ZUVZd2NpVlg3elNFN2M4TW55ckJxRXdLeWhaY3orTC9kaHRuc3hrajRsNXM5?=
 =?utf-8?B?ZkdBOGo0UGZNQjhZekJLUFkzci9xMHIvZjNaZEltR3FrMDdJdkRGZWNvUXQy?=
 =?utf-8?B?RHRyVVpkaWpJODk2V3RYMmg3K0w4YWl4TlIybGpJV3RtT1JmdFZ3YjIySnRB?=
 =?utf-8?B?NDV5MDBkNitLUlgxZmUwZDJ0TEpzak0yVVpaNzFjU3RqeDdZeXVWT1JINFZt?=
 =?utf-8?B?RTZ0Y1FOR3Y2dGFuVkQ0QWJUY0hYTkZQT2c2c0Z6QVlMMWhBMFBkZ014MlVx?=
 =?utf-8?B?YkU5YkZxdE1mYkcxcyttczBRY0hXUmNhalRZbUVZcWpDcG5CZThaWGV5MDgw?=
 =?utf-8?B?YkpGaURtMTAyOWEwTHM5Y0dVeVMvSGQ4ay82bzE1bkdPYXRPeTJTZ0J6alpq?=
 =?utf-8?B?dEtHTjkyeGE5RmN3OU1aTlNPbmdnc3pwYXc2Y2RSZDZ5UVRTZzYrZ05mVER6?=
 =?utf-8?B?b01JaDhFUkhpdXdtY0twUGxmS3I3MTZvMFVXNTd6WWtMYXBhd2JSY2V3K3dF?=
 =?utf-8?B?cDFzSkdaSnVIMENFZ3JJQ0Roc3FxK2pWSjd1dmdJU3NlSFExbTN1eXJTZFFL?=
 =?utf-8?B?TmUybVNOTGhCYnhyK2VRMTRqQjhTWGZZbEpSd0tUdE9uODk5ZGNmcS93d2dC?=
 =?utf-8?B?SEVpQWovUDhQODlqRHUzWW5TbUlzM3FXTnRXV1lRdXM2aGptTU5KUkJpZHhW?=
 =?utf-8?B?ZFVxYkN5K3JQejd3cE9BS3RmRHlxUnVwS1lUbVRKckgvVTlnUUVuVnJ2OXdr?=
 =?utf-8?B?UmVKckJjUkZuLzl0dE53MGd6L0R1RisrZmIxV3Njd2hlMzlBd043K3UrTUhH?=
 =?utf-8?B?UFRFbVI0RGYyajM3NFFXNllQbTdkenNBV2FaMFE1aWgwbDdNdTRSTWtwcmlW?=
 =?utf-8?B?bnFJYSsrMFJRcmNCTisyYUJHREtYWHJabkxKN0VqWmpEZUM1Vk9icGY3K0Iw?=
 =?utf-8?B?ZDh5U3JHN215Sk9UNkRHV09IL05kTHZYeDlxbzh3NnlDampnT0RjMXlhZ2Ny?=
 =?utf-8?B?ZmQweFRrNE9QVTZ5TnRObWtXM3JWRDhRYmg2QUpIdDY3ZEVzQ291K29QdzM4?=
 =?utf-8?B?ejNYcXNVWXVjM3JHOEFnb3c4SVU1TmFLVGtWTG5LVlNmQVBqSU01THJlYVpi?=
 =?utf-8?B?TndUVkx5QlZrcXZ0NUQwRjRuM3RxNjg1QXF5NkpXYjMrc2MrUFBIYXljRVc4?=
 =?utf-8?B?c1hrdTlLNDNsbzgybS8xUlFVWEFlYnJCNkU4eVVhZlFlM3l1RzRjaExuM1U3?=
 =?utf-8?B?blFlUEI1OGVQbWY3UzU3ZWVqZ3Y5cFZCUC9rbDQycW4zbVVjNlNXVFpWWWFY?=
 =?utf-8?B?azR5eGFlMlNWZTVDdE11ZEg0RXp5MVhYTzZyZGt6WUlmMkRiZGxEczkrVEkr?=
 =?utf-8?B?V3BxYTRacWhDbGtRT2ZKRWd2a1JxL1BiSUFQMkhncGpqSjAzUk1NTmdyek5x?=
 =?utf-8?B?dzdKUUlEcmoyR2c1QmxZVDlBOVNZMkI0UnFadXpsUi9uaGNUV3c1YWFmYWV4?=
 =?utf-8?B?ME9mRHNyakFWVXJQM3NBa0h6SlAxcDQzdDdqNnd4RndhdnlNTUwzV3hUYUE0?=
 =?utf-8?B?cjlsdnJ0N25DRzdCNlIvNWZmZStEZnFtU1E4VlB5TTc2bTlHMjZhcTAyOWg2?=
 =?utf-8?B?MytGb25Hb2NoN05BTVlBNkZSalhYeUN3NUFzZFlxTXg4VXIvMGZCdlZidGpE?=
 =?utf-8?B?amN0aFVtaDBwTHBiMmFZMDJEWWNkbE0xbFd4YVF1OTJ5MGR4cGc0bUdCZWM2?=
 =?utf-8?B?c0p5Q0hmQW1hMUZ0UVNJUTczemM2U0FXQWVaWFRvZWgvWmFXSFh1TTZXOC8x?=
 =?utf-8?B?aUYzMXMyRlZaN2lYV3ZjcEZXMDY1VGJrR3V2NGhLWE40U3I4SFdYbzViOVJz?=
 =?utf-8?B?S2VlMzNEeVNidnM3cnZrRTJzNlp0QWdYUnJsKzEzR3JVSVg0akpRbmpMQnlK?=
 =?utf-8?B?OS8yWDRLc2NWWHRGT3FzWTRaeXBVQzFydkIyVVoxVDlRUUZYcytSNG8vU0w0?=
 =?utf-8?B?QUJYRFF6aFp1WkgvWFQ3QmFYYk9vUGVpYkJCZC9JakdZclJxVGlLTDh5aUFV?=
 =?utf-8?B?TU4rNmE1R3dUSGYvL2Q2djhIUW11THR4eUV0VXlOZFowRG5jS1NkNjZOTjIr?=
 =?utf-8?B?aHBVZ1pQcWIwcy9GNVEydXE3ZzZSZW42WXMrOVdiMm5EQzBDcUZ5MllaQmhj?=
 =?utf-8?B?eTBNcEY2THpGa25FMm1XOUcxcVMvdFdQNGRaV25qemdRa2ZXc1Z3QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f29390d-b65d-45a0-b9ba-08df0ed70489
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 01:01:16.8673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1hQALYMJ0IQ1c830qs2Go+MJBAgnZJvz1dvqJbhhTUfEPbgmwLWGUgyQpEKuFqGGf57oNtOcOcWD7y3PK3o/ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5618

On 9/9/26 2:13 PM, Alex Williamson wrote:
> How does this provide multi-tenancy then?  vfio-pci considers the
> device to be scrubbed of tenant data after a pci_reset_function() and
> I don't think Manish's series alters that.  Thanks,
> 
> Alex
Hi Alex!

I missed considering this.
In V12 I'm exposing cxl_reset when the device advertises CXL Reset 
Memory Clear capability and sets RST_MEM_CLR_EN when initiating reset.
I added the gate to prevent exposing a non-scrubbing reset to VFIO.

-- 
Regards,
Srirangan
