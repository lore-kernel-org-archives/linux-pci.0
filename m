Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012047.outbound.protection.outlook.com [40.107.200.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D743C37475B;
	Fri, 11 Sep 2026 04:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789100832; cv=fail; b=HvmjjHQZ47+sHI0x4M9bQ6z8YGrNxAVpobimdYqYix45egKZ4eofZ8PBB2RI+zP+nmfHtpxf1xtWS5uJG3iu2I+WmYxPFcqFbdGG8G5RqE0tg2v69EEYwE932DCuSsM4iSeS81nWqKDGMS/FFw0j4gq5/WqW5c/0rQ6AO9oKIh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789100832; c=relaxed/simple;
	bh=MxLMnmeoESk3AqJpjHNYnHyQnT1P1fOkSLDwa8fxgLQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WBoybrmgA3mj8Gk9iKTQ8JTxKqj9svISNkNC/+ntJrXk6NQ1mJ83tnoCN9X9q1CnDHgNaPKJPgJdcTz1E91Qt5EHuGPvY+W9ENiYN+yY4J7blYLSX8VXwXTwCshLXsbKsNeiYzEuSJ/tHAJDsSZnZgyGROeLusA/qKxhPLTAQAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h0nXSzBW; arc=fail smtp.client-ip=40.107.200.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h0nXSzBW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDt7NYET7gne39De/eVKOaD57bUKuU2hzXvLGFNb1davICzhFBYHSQrBDAVc8OdjBiZs6XW17nTQr40dsDULf/8IHuqnTWKFsvTc6dCXX4/CUM47ZfvgV6gt8mngKpjoQO9ny9LK9IbcJsPnCIJNxIIdJos4jZ4cF9qtDIHaJC7uObylIa0F5YLnMNzr67E/kX2YGEscWLjC0Z0H77wE4bba8cbR34sj3QiU5sdrbE8lySOKuDbT5FHns4LZcL9UyE4STOsr6ryL/EYzSOqjTiCQ5mXyM0zMN+Xkpv2pwB4943USKFY/UpoD7VgyT0sSGviyIZORsgOzzSfWe9FWYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+s9a5RX+znTZwOcDyr/LJ0rcGqRMhORDUeAR6VsJT4=;
 b=PQ0fjGkIYbyLueYc+itdKZmxt7YIsrCiTId6MGS3Mu/gkOOn/eQOH32m0c5wYnMa9mWwHksWcbEcP0MUMv/evr0OGHh/hyYYyIuCBzfG86xTMoZ64Ibw5cfRv8g5+Q8PBW/haO050KdZDFeIq6ZE0Q56OnVlwdKbzGfGf/jB8uv21UYbp2PV0txfApt2rjYXbz3cuY8svQqcK27QAPhJ45dmIKSLFKQQ8GBfwlPdl4tzVsvQ3dOdIH1kr9KOUnkL/Lsc5e9hpyWThBJ/egWbsChE6D1+GRK8tmZZsNFc6xjmvzmdCtNJIQEcu3bohin8ZAOmDce/194IhoRP/5D3zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+s9a5RX+znTZwOcDyr/LJ0rcGqRMhORDUeAR6VsJT4=;
 b=h0nXSzBWR6HagxqLQQxExcdCA41U2Ckyr5EJDcO7HSz7Kjr3KH7E9HIBpBZqm1iLYjOVYzIs+JMblS1N1YU6TZ/OGorGnigaKQx3GnDmyj2Cy08cC8SreyHyRJCgD/QjtGMBUi5njkXMtV2Po13KfObQDS2yX3TYqYTDhZGcvGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 04:27:08 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 04:27:08 +0000
Message-ID: <97f230ec-89f2-4538-b8c7-55534f94d821@amd.com>
Date: Fri, 11 Sep 2026 09:56:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] iommu/amd: Remove iommu_ignore_device()
To: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja
 <skhawaja@google.com>, sashiko-bot@kernel.org
References: <20260910142655.3281464-1-praan@google.com>
 <20260910142655.3281464-3-praan@google.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260910142655.3281464-3-praan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::7) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|MN2PR12MB4222:EE_
X-MS-Office365-Filtering-Correlation-Id: c968980c-83af-4920-33b2-08df0fbcf0c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|6133799003|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6VYhbpwwg/A4dTDUiN6jr62wdoSbT5QEgfLX1R8yrtk4LekTDjsFKLqachzClfU6nXWubKZn6rq7GUaXfhmR/MwdsaJG+S2relrownWOqCkzJHiuZS5Up9dntmKrE1n1+klx0ipaMyLmaEFHDOjKGAX3S/1NvUBsacghKYB2/tLe1aDmr37ROchtvaS8A6i9j91W1LuB/4Q4EIXTLLeGk4CrHS4qKA4q+aQEkNbQ5SQ1gojBi0M67T0+ziL05aaZos7nrdy0KhoDm4irSl5xxfhKAte7jmDN6Jsd/HKl14BAjOo6TRq4vck1M7SgMpPmj7lUqpTpxuuMqg58aKFcZK+qwOgqvZrCu8tLzIML4BlVEkRN7eBqXaOA/S9T1wnQRfQ2A20tEnJ5Wml/2VwdIcOGs5WP3zbeb5eRdsOyklv5j85CHRLE6PoG/KxOqA9HiTwpDol+jcfy7gyssVrN9ioXJqdeNWnTcgOclexW5UTu9BiS5PZbp9Tb/6kdu1wVv2d0Tu0yULzfamWLtBJGyvWycK3QlJSyVwvYB/mO3n3+AAXbgRcsOeHqc/HOKS4cj7q3jR0V+DLkMwZBLj7x7crhwlK+rrWs9E39k+zLpQ/TOPM3fX2BjH9+4gCtsJ5XhipReC6dPRqkjsd1CcGHcgH0zlY7xVk/UC3kXXPPdKc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzhoMEYyVHd1NUZGNVdwOEdjUFdZbHRQQ0x2WWhyeFVsbDZxRVd3b0ZKeDRO?=
 =?utf-8?B?RW9iOEt6RTY0WUZpTm85Y3pWMjZTdTAya3V0b2JkNWpCUnJCSTI4cE5hcTdq?=
 =?utf-8?B?TVA1MzUwN1RReGQxTWJTOHB5TzZhMDA0cnNCeHRTd2F4S3d4bTFHVGh4b2JF?=
 =?utf-8?B?dWF0RWFsRUwyTTNORWRoMld3NXBrNEVWd054UVo0N0RWNXFaZXpIcS93Qjln?=
 =?utf-8?B?Uyt4MzdDY3ZrMXgrNTI2RmxhMXduZjhLWkhMeGVwanBwRHdDZlV6bVRRV2NR?=
 =?utf-8?B?aXZiK1ZIbVdaSE9ZUm5yem45Rzlxb252Z0ZiK3lOSXNTbzFvK0xIb3pKYzg3?=
 =?utf-8?B?V1JIVTU4UDUyemRqVGl2RGYzdE4vR3dva1dtSmROVjF4bW50S2F1VzV1WEds?=
 =?utf-8?B?dm1lVE9jSWJoNVN6T21rNWV4TlhrUTdpNWZacVJzTHZ1Y1NoYTBtemZtcTcz?=
 =?utf-8?B?TmxtUWR2c3FPOURyanJGQi90MGwxdy9pZC80RkFsZFVtWkxzTXJtaEp2Mm8r?=
 =?utf-8?B?akhPenRXRnpRR0tvaUdKMk00K05uMnBuSEdZUXI2RDJSbWZPalZFaUJPamtN?=
 =?utf-8?B?SFJMU1liaW95bnhEa21iR3k1V3dTKzBRUUJRMGRGd0hTNlVaSE5yQVprUDZD?=
 =?utf-8?B?MzRLSFdWbjNxZzVQR0VnWG1Nd1ZDaFFQdHNZYjRwdGFrMzhLN3VHTkU1clRw?=
 =?utf-8?B?ZXlJY3NHY3JzTWJrUkUyZURGWkJIMjRvRXNCcmM5VHg3RHBpNVEyZ2pNWmo4?=
 =?utf-8?B?QngwRGpDUUJrU3NnNFRMT2dQVml3Tm1BTXhjUHNydFNZV21YN1BIVlNWb051?=
 =?utf-8?B?Qyt2MmJud3ZiOXRKWU91Ly9aeUVqbHlWVDdNa0poT1VFUWdqa0hkaVYvRGND?=
 =?utf-8?B?N1ZVRXhaRVMxbG1SY2RIcXpicDlvTVBwOXYrQ2JQUmwwbVRnTjRKcEpsOUxj?=
 =?utf-8?B?b3BOS1pjaWRKTm5KNzYwY3dVRmR6d0NPQ3JjeVhCRkRaVHRveExjeC92eHZW?=
 =?utf-8?B?S3Bsb2ZyUXYrNHVxcVVvRWhvNWRHa2ozQ0dCYTFkeFVUSXZ2Z1F2Z25UeExi?=
 =?utf-8?B?VFViRmpyMEEzZ3NCczJKN2RHOGM4R1J2RldJTkVlSHBodncrRFpFOE9hTkdz?=
 =?utf-8?B?dThVVHM1Y21aakhkRndwaC9SU2FLZDhFWEVIL0V5RTlPNmhOSlpnbjAxRWJ6?=
 =?utf-8?B?NTk3MDBzQUQwd3ZQaHhERnVjaHZEYTNqZnJad25EL0h0ZE0vVFUyTVhDc01F?=
 =?utf-8?B?bXNNTDZLb3NUL3pQaFROajJEVFg4YnZSOE9xT2V1REkyQ2pQSXlDbDhRaW9T?=
 =?utf-8?B?eTlGYnRlL0Nsek12ZmdUUWNKSkJ2ekhNSHp0VFdGNWVCOUd6WmRSZWIrMkMv?=
 =?utf-8?B?cGhJSG4rZEt6NVloajVwckswaDhNTEU5MGI5aWI3UlFRU1BRb1MyTjk0bG85?=
 =?utf-8?B?SkZJbGJGTGY4ZmJUYWRkd2NmSFlydUxoVGJlcTBjWEJXUzZEaldzYTlRdTc1?=
 =?utf-8?B?S000VytySnJHWGxpK0g0Qnh0a1VNbEU4bFByblB2b1NLUEE0UGIxekh1ZE90?=
 =?utf-8?B?bUhpRytUWTFMNFJqSDkyM0ozRHUzYVplUGI3MFU1Q2R6MC9HL1dOSUpHSms4?=
 =?utf-8?B?VVZuMHVvVzk1QUtUR1UrTEtXeW1XRDhnajV3cU5pRjhKdzVQWGpLaTdtNHFR?=
 =?utf-8?B?ZFpTdlRTWEFLNHJJRFN1cXRKTEw1RzljLzVKWHJxQkpPS3p4dVlXY0FYMUlv?=
 =?utf-8?B?V25XWWJ6NzF4TWU2K1Zyc0E0cDJuUnQvKzdJT1Z6Sk8yQzVTZUVHMkZ3WnQ5?=
 =?utf-8?B?dGJaZ1BwZ3Zpai9Wc2F6RDVITWQ4ell6ZUVkTlVIN01vNGgwY2RDeDRiN2tm?=
 =?utf-8?B?SWFTWVNPY3JQanBvWEtzaDczOHN4bGxkQmFBMXBURndPcWFaU3Foa3VPbVZH?=
 =?utf-8?B?ZHkrMFJoUzBpb2NVTzVHMEY3enV1VjV5WmRERDhONHpRWnBBWEpQTmR6MVhh?=
 =?utf-8?B?VTV1eDQwYWUxUmJjait5dnQ0Z0YzbTVnc3YweGVLWDhaUkt4ZFNBQ0EybXBD?=
 =?utf-8?B?NGIwNFl2YWlVZUxPYk95MUEvTkRMbWN2YjAxdGJSQ0NFQ2FFSHl1eWE0TWtW?=
 =?utf-8?B?Si9SdVNCTUFuVkU0ZHJnZ3FwSC82Q3U1eWZXL1VhbDFOYVVERVRaUnNvdmxw?=
 =?utf-8?B?SDJydWdVaE1rVlJPQkhRUm0rYW9aeHBuYVNjVzhVcVpaT0s3cVVyTXBidE9Z?=
 =?utf-8?B?Y252K2NPOFpxTFlrK3RSSHpTZUdmaTdXZFRQVVpnUG1ZTHBmTVErU0VPVm9L?=
 =?utf-8?B?V2Z6Q0N0dlJPZ3k4Uld6QUppVk90Z05Jd1J4Z00xUHBEaE83amttQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c968980c-83af-4920-33b2-08df0fbcf0c4
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 04:27:08.0426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubIeG75J5NQC/IYWqjMj8PBvecWRG/OO0CK0V9W1lJDTLbtllSHGNZOEbd0G9SNDcpFjT6Sz3lGZOBhG6/eGng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222



On 9/10/2026 7:56 PM, Pranjal Shrivastava wrote:
> The iommu_ignore_device() helper was historically called on device
> initialization failure to clear the primary Device Table Entry (DTE) via
> memset() and nullify the rlookup_table entry.
> 
> However, clearing the DTE on probe failure is problematic:
> 1. During normal boot, DTEs start out unconfigured (blocking DMA), making
>    clearing redundant.
> 2. During kdump boot, pre-existing translations should be kept running
>    until deferred attach rather than abruptly clearing them, which risks
>    breaking in-flight transfers.
> 3. Writing to the DTE table via memset without flushing the hardware DTE
>    cache risks aliasing & torn writes.
> 4. Clearing the rlookup_table entry breaks interrupt remapping for
>    devices that fail probe or operate in translation-less modes.
> 
> Remove iommu_ignore_device() entirely and simplify the error return
> paths in amd_iommu_probe_device().
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Suggested-by: Vasant Hegde <vasant.hegde@amd.com>
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel.org/
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

