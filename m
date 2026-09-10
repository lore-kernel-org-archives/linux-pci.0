Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011068.outbound.protection.outlook.com [52.101.62.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C465474F;
	Thu, 10 Sep 2026 00:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788998883; cv=fail; b=CiNPrMe5P1F41BVxznXAK17uI+zJfrYyyC/Ai3bv0G/QqPXc7UpmdjWdz+1MHNkXopOsF4r4bsjFb889Imdx9DBR1yNjIDpxhuuv1jeaLCDmEUPk/x9/zff6m0Z5JjfPhhsDWn4edCfj2aSI2SUqaMzpdGYk5GsX0KJhZVF8chQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788998883; c=relaxed/simple;
	bh=6kQ4UUMcBI5WzNuNe9gV1tQD83Sa+FB2l0ivUXymT74=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AOgclxhDgKt0UOdOzaDagCWGfUCK5c/l7QI6bpy61V7NK+/PTaF8mzd1nazqA8xNW4A4rB4mE1ylF/50iMyHFs0UXFqMV2PECcX5s6eFhfyS2TDhkfz0N+VabF1Em5+rg2LgsxxyXiR23CEJnzhzVwJTw93RmpmlYDELIQRRBTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IirhRVx6; arc=fail smtp.client-ip=52.101.62.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IirhRVx6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RB+OvwtSbWDK6ownUi40ZqbQ90Lr/c5jY/KflrmR9zwQtT65+Q8SqwmYm19IMGADhKtbfQvBOqYJXoG+04OAgIT1esyC1WkjU0ctIMVxXxMQxIqgAqGBSw+2AYv06xOeraF1F+vL4lnUeKpYw3Sa49dT7VLoH8Hxxd6AmJmLZ58me+7EJ3RORcV9DRWJa6+prMur5OpdnbloOK1fPAb6aWzpu4O+qssET0OV+e7+9YQz4YdCpWZ0scJfPpiMEWClhyn5lFzuwBhLYuaE3mqc+biLXkwxipEIXmtJW4QLbWVwyzxQE4bcX8qt83ILxkNT4OTvUYLBdJgyR2Cw35hKJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BH3YzE97Zm7u92VJ5Q1s9ykrZiqYU4QuATojHrgLv3c=;
 b=Pp59e5JLceHL24OMNaMnc80TU/53C7VL5t9J7KVLNNgCPO1tDUEYk+D3eBKwls+id6EkLOpsjZOQb6X38a//0UQXuIgAgW+mZgyLCfwjJ4bmt+oqieyqAvUjwyEVmW3VmKOvDWzyN2U8BPIkFp+QztkCFYhWqljfwNME/y6vLRMS3AIDF6eGhOHrH5YSvAfooxl1dTK+ejVX7VQKgAJp/9OXWSEmui0og4gfmF06p8nMV4qV3UNSPdVCuOuWTbWZooeY3WcBYl00CD3wdn2FksZMgVd2k7ueFK+yQj7/vuzlOKBIm56qFMUSh1oRL0Jozjd+ZNhaDx4ozgfNR3rU5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BH3YzE97Zm7u92VJ5Q1s9ykrZiqYU4QuATojHrgLv3c=;
 b=IirhRVx6vtE2kbf7+6jmkITWUSkqwib9R45LFoXal5UK2sUeNkVyVTD2oTtJATc5lWVYEgCLcp9O5WMZ80Vyz6Ao8NKZGjoRvadhGLSo7T6GAR+CY0DluO0agxi5rARYt+4Tn9xHPNKXZSIoe5mj2EdwguK2MlYprsfvwvkTvVfhCDocz6+t4pvMRwtQ6nuA0GGDW+bFqZncgzwvl/8uSQWHADpj1GQztLos2oXOvL9iwRwfef19/hJtAdmTx8cR8U4ikMXLtWn0hV2xrc18gQpIJYUmwXMH1JZXqcXpX5FNUJD5yzBla/7/wBjNnEc6Sbu919wB8ME5vx9S0MhZrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by PH8PR12MB6700.namprd12.prod.outlook.com (2603:10b6:510:1cf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 00:07:57 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 00:07:55 +0000
Message-ID: <58a876a1-7569-49d9-94bb-d090c8acd439@nvidia.com>
Date: Wed, 9 Sep 2026 17:07:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 05/12] cxl: Cache endpoint decoder settings during PCI
 enumeration
To: Li Ming <ming.li@zohomail.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260902072804.665639-1-smadhavan@nvidia.com>
 <20260902072804.665639-6-smadhavan@nvidia.com>
 <08d97766-d62d-4901-a413-705df0020d22@zohomail.com>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <08d97766-d62d-4901-a413-705df0020d22@zohomail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0150.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::35) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|PH8PR12MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: d99ecd92-2a4f-4ec3-cde7-08df0ecf9071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|10067099003|6133799003|22082099003|18002099003|4143699003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	f58lcUUV7LkxSfV1VO/G/nHr51Dic5XYAlkKRgoHVD7mGdtHsxNQ6b34oVoHdLzs5IvISdixaRIXa/aQrV44EeHJJg+zwU6ZtQhWbZ40EgSq5Q8cj/sNw53oX7B4kmQNR+NlVhG8K2sTVHNM/0iOtbIlHZjRqp6ugZ+zWP0vTpKvQ97HBiXxd+xJzZFaJBj9k2ZQzsdTGBwYTBKBDVr+op8El5B8//uv8Fc2cMf7YXaxsBRpe2qjAgsVrQT+RX08cUgTGQFjIXUzYJ3tRVdcsF1rBSKtLvv/f5XE8W78/tTAMOU/EToHDZLXlJHrP/ZadaatsuORh6rb4ijNHKJJaAwjyIkc41qvxB9SIwes56F+Ir1waRK5NIJ2PB2Pv9KA1ZBb6bte7YCKUXFn2Xfl4yHZfEqehAxw8DBsKz8yULuzIGm9V6pX3d3N+UZcSUEbciXv5Hnr0xvEeTqqfxTRUEP8oA0b68hxZ/8XjDgf/s58qILypf9sUVsg7GfdRYlW09o8yj1/xz3S3Q/hQIrEnVg77dU+YRFwYv0HF4D9NeMbplK9nbZIpQRyQtGOzpF42OsTgAm7i22ATTx4DUK0TLupi4k/Pq+JJOYZH4DWCoo5nRVH2A/EUTvEIPh3BFFyg4lCTWoZZ2f1izI2T9PYvS4I4SaXPXZ6aFjr/9ca/caxAU5UwJCaFRvSfU8vRL8wtT2/Dkkmq7MI6yZUrCZSLA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(10067099003)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L25LSThLRFFIbFlKbGRKbDJCdk5BWXlXNFQ2UDRtZ1VuVElLcFZuYWxkdzlS?=
 =?utf-8?B?bnoxRWdhTHFlOEhEY2huQ0hpSzR0YityMWdzVDZrSEFaQ1haU1l1MHloenJZ?=
 =?utf-8?B?cW9yd1hkNkpHZzdDZWJKTXh1Sk1CendFcW5TT0xqMWxKUWVobzI4T3htck9Y?=
 =?utf-8?B?cHJUTVkwUEJvYnd2eHhybnAveE84R3d3RXNJcytIR0RDc2FlZFdYci85cmFN?=
 =?utf-8?B?d01xYVV2OWgySU45TytaNUxxRzl0UzlYbzZ2SE9FZDV2bnlJSDlwejA2VlVB?=
 =?utf-8?B?ZUc4TkdINUVzTFhGTGpXQXRnTWY3ZmIzYnhBUDY2S1NQbnNJMnRJU3Z2OVNN?=
 =?utf-8?B?ZmhGNnpZa2xVRlRHWWJJdE1HUFVNUXhMZkhmZ1pJdjdRbFp1Nm5xSThtQ09i?=
 =?utf-8?B?T01xMlFaODRDYzdySGtlYjlaTm5ZejdRcWpDUUV3cFNSbGt4cVByUGFMcDBs?=
 =?utf-8?B?cVZUWDlvZ2tpSzJ5a2hFdTkzQWdGYVdoU0FGUE40Umh3aXBQdSthTXEveUxX?=
 =?utf-8?B?VGFKcE16NldyS3pzK256WU5NbzAxd0ZxWHc1OXE1ajZza3ZFNVRldTF4MU1M?=
 =?utf-8?B?YXJYZUtjS0JBVnFWQ0U2MG1PcU1NZ2dQc081b1d1Y0FCUjhzc3QrclpGdVRo?=
 =?utf-8?B?U2FKVGNpOEpNS0t2Z0FxOGhsTlhyK1lybW1XQXBQcEd5UGw2OU91YVkrL09M?=
 =?utf-8?B?aTdXbnpjaUUrSUxoaHFLSEJLNURQc0ZiczJmV09QUnBrcmdjaTluQzI4NnZr?=
 =?utf-8?B?cDV6OHRFNWc5aGdBQmgxczdMNUlPclduM1lqbDVLVzRBL3lKTWdENHErc2dV?=
 =?utf-8?B?TStsOWNSYzIvTjlKcko1MUFoQ2tHVURlSlZJRVJMNWZZTUFxaXZvMGtTS25W?=
 =?utf-8?B?MCtDL1FESU0xa1Jkci95Z1ZFSFhrYmN4dUhhdGt5RnJadEZYNHZHR1l3K0JW?=
 =?utf-8?B?b1ZDMTVHTlBMclBPK1NIN3BCMm1PSDFob2FORFhvZk02TFZxa2x6U25qVEJy?=
 =?utf-8?B?YTZ6M01zNGlRUXc3Y0ExM2Y5RGNsQy82cWgvTUFyanhsT01OT0VGM3QxMDEr?=
 =?utf-8?B?MmFiaVZqZFlwTEVGek42SldIR1JKbzhCTWluUEJMRFQvRVNWaHBnR2JMRHVM?=
 =?utf-8?B?TWk0Q2ZLMXFKbW5kejMveFZyWXVaVi9GOTZyd2d3b3pQRml1bFU4RW1oZmN2?=
 =?utf-8?B?Vndxc0VHU2JjSlJHVG96T2JLZy90QjVpYzBXdFZ0QjZ1L2ZJQytRYkhxdTZ2?=
 =?utf-8?B?VXhMM1puWW1ZNi9VM01nRGVKZmMvY3NPZU1HUXduMHd2Rnh5TVNxSjllbFYx?=
 =?utf-8?B?S3VsL24vWnhtUElIUmFUSHRJSFozektsb1VEbjdzb3owZ3A1YkZCYVAyc2x6?=
 =?utf-8?B?UFJZdjJXRnozYkI4UUJMa1c1ajRRR0tUeU9JRTBiL2k5S0FhUzJjdSsrMWlC?=
 =?utf-8?B?WnZYU0t3Vk1YNGx6TWZwVlk3OE9PK3JUdDJ3Z0VoZU1qQ0h2dEhUNS96d3M4?=
 =?utf-8?B?TUZ1akZVUGI4eFVIdXJBdkRZd3hhNEM2aVR5UlJVa1lrd1hsam5OOERZdlJM?=
 =?utf-8?B?M0llZHNvRjA4bGxNQlphUjhZLzlaT244U3lQYWY1cnV4WGd6dTRjSUpUTWFS?=
 =?utf-8?B?cWY2cWxQQ1BFQWtIZG5UeldKbHBrWEsyQUtpTW4ybXRlWWhuTTRaTWhscURX?=
 =?utf-8?B?blBYT3crZSt5MjhrUlUzb2NyWUdQbmpsQ0gvVWhqOGNzRE5aNkxZTHNWVkc2?=
 =?utf-8?B?VlNUSGwwRjVNUk1mV1JPME9nUFgyck4rRDR6dlZlL1VDWjlyRFpVWERISGY0?=
 =?utf-8?B?ZmUwZDhKRFFGYklMcWVFakpYWXVvRUIvOEFrUGZad3BHRmtJZzJKSkhqSVZZ?=
 =?utf-8?B?c1pKaDNzVzFYTXptOTBCc20wU2NCODNPcGxRQUtvWE5ZMVhFZFI0YVdTSEJI?=
 =?utf-8?B?NUxORzlhWm1ENDVERXlpN0ZhQVlVV1V3N1Bkd042Q3hNZ205ak9uMTdDZnpJ?=
 =?utf-8?B?VlBweUpHRE5RNnp0OFVPZXJTQjd6UDN6NlhuQ2Y1MHp1bHA5ZTNpRlN6bFUz?=
 =?utf-8?B?blVjMUhIM2tQVHJINHNaaStwdFdKY0UvS3c0Ky9mcms3cjk3N0ZVeGl5R2Rv?=
 =?utf-8?B?NTBneVkyd0hFcjlxWnprb1pmaEUwRjRMemE4NUp4ZGtkQzFCc0NNa3FOR0Zt?=
 =?utf-8?B?MkZVMjZPak8yNkxMUjdWaG9yMm1xY3FMeGxKcGdTLzAzSEpBYlovc0FsSEls?=
 =?utf-8?B?ZER2UnE3SUQ5WkJLbG1WbXhCY0VjNUE5UEhsR2xwbHlwMmRXL1hhT1I1UHFw?=
 =?utf-8?B?QmNPR2U3V2hzdDlURUR2NXVoQ3ZTOEpvaW5ud003L3d0MVN1L243UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d99ecd92-2a4f-4ec3-cde7-08df0ecf9071
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 00:07:55.6815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +C0y26rgnW6NnNBRpAfP1jbZC2AS9qTB115i9xzotuWhqNidNQC8DX2D+L03la9idheOCIohww+U85VukAXamQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6700

On 9/2/26 7:03 AM, Li Ming wrote:
>> +             return true;
>> +
>> +     pci_cxl_hdm_init(pdev);
> 
> I forgot to ask a question in v10, sorry about that.
> 
> I am wondering why calling pci_cxl_hdm_init() in
> cxl_pci_hdm_decoder_count_match() is needed. pci_bus_add_device()
> already does pci_cxl_hdm_init(), so if my understanding is correct,
> pdev->hdm is not NULL here, so this pci_cxl_hdm_init() here will not do
> anything except checking if pdev->hdm is NULL. I am not sure if I miss
> some cases for that.

Hi Li Ming!
Your question is valid. pci_bus_add_device() is the normal 
initialization path. The later call is a retry for cases where that 
attempt did not publish pdev->hdm, for example because allocation or 
MMIO mapping failed at that point.
If initialization succeeded earlier, the existing cache is detected and 
the retry returns without rebuilding it. I clarified this behavior in 
the v12 commit message.

-- 
Regards,
Srirangan
