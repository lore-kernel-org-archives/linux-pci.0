Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010014.outbound.protection.outlook.com [40.93.198.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8480F18DB01;
	Mon, 24 Aug 2026 23:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787613791; cv=fail; b=i2ZS3iOEugE6dY84LLurjHSdOVK6E/bgDPtjtZJyNMNHWYPsrXBbgwaY7Z7AEFM5foJzVi5mS4SCeQhwfZg/lJXlEqVryDWw0TIAweODSXflrE0FsPIlNa2v5/NkS2E3vL+FOD/Y/vOPB03oIzjlpqBjGcMyD087eh6F3Aj0HGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787613791; c=relaxed/simple;
	bh=4DOCnIh9wcdzw1hx7Dv8LcX/LDyea8YFgdFyxyOOA80=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=n8yihlw1W4e8y3eVbxQ4TwwgB13Uh6YCLwGJC7MUpugycCGusn61Ir/MYsdDtSvJy8+NxMLc1JguM8Qu4HgtUOV8/aNG857LdizBhW2TXYHUcdOTbkWyuvqjvRF1/2phq7dLVhp28O/knfU7UXaXMya8sQtT8lUyXWfiNNspiDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t5ih2MM5; arc=fail smtp.client-ip=40.93.198.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t5ih2MM5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxuOtKY7n78oXikmmYj+CloQAkze+1ymhcWbUHXiNwi6dakwiGvFAIMKk9/PgXT2uv7WjRPt+ZM8VyLWv2YojE+gGbwhg9XCqmUcYUNQTTzN/U9LrdBPyXSzJLFS+rE+/Y5Mpjbmxj27YnnhWAeKEluA0WaYXj1h+qXhetV54hTG4Scp4Jilfb8lVLyHz0+fpSO9S7/aV+P7A8WCR3isMMPMor6t3UtcS7ck4cNmluyQc6WjB/SKBAbwpL9NfhzpViZdKdmrxkRol4rDLybiObYZC8z6cOTa3Gyx0UI3mMUuGoAGKBnZUFZ1zXnYKXnLCi6gxvplwFBm3po6hiri/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfgT+mbmL4sBIIuuMkLWL0Yll+AVhDO68p8dsnoPVuY=;
 b=G+c6oXDhld71eDarrrZyB9tMO75EUCddMgymPDbk3TEKbR5ie4lVRYZoKy9nJG5Tbot6N/e3rRcnAHDg/gFarx97W/Q1zUd/lG1TqgfTqG4YtwcJ4xWo+0ULDylRZT/R/vPsGaf+lcn64TWFWO7Rr6F4ng2S51Fj+Km6kbtr1J82S4e/a2aChoYse//4lodOqO0gVu1KCiHBQNMBgAfmNdQiyJZnfcXCW61NgbukZCzMmjNCE/JNwe9QgFE3nFhil1lJvf9bddaoq30BccNvibEEvx0InPWRvy3gs57T/V4CH/zPLnKHjbjATiR3KdYfi6iFtY2GbzqrrPJ26FB/Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfgT+mbmL4sBIIuuMkLWL0Yll+AVhDO68p8dsnoPVuY=;
 b=t5ih2MM5Q1imwjhFtoGAnZtmZDuCGRivLG2mZVAhbwB6qJWWLbfemPxl3MpwsVbh538RwkZHFg9S/HdpEdTE0KIbGpvaR7TOxI6hecsC0PKRJYJcoReJP8finJtJqHS3ZcOfH0wB679zHktxonGGkA6BnKDjMlcsaXFpmgh/jjvuXvE69B8Crai6GBU1wfEJRQ739j3NUsyMSXxAU1hfBIRxeeIQO9jtN5CVLAXt5jQ4lqax2YllnWAq6Cxfl22rRg/r0qxWE2/J7Udnw8B5t/vEIgMmm5hB8xaAIVhmR0eIbi57IoZTXb5mTEAmqzc0+0kpDr5AfzY1Qb8QTjNwFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 23:22:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 23:22:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 06/18] PCI/P2PDMA: Gate the host bridge whitelist
 warning on verbose
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 Logan Gunthorpe <logang@deltatee.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>, 
 Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 iommu@lists.linux.dev, Tushar Dave <tdave@nvidia.com>
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-6-94426b96de73@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-6-94426b96de73@nvidia.com>
Date: Mon, 24 Aug 2026 20:22:50 -0300
Message-Id: <178761377055.3197084.7003957681533954491.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4PR01CA0414.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: dbe9e8c6-5ba0-49cb-791e-08df02369ffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|56012099006|10067099003|11063799006|18002099003|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6/BP8bm0ygDHlmHqFL38m2czD3mtVRD4aJT6g+I5NOOiVZ/yISDUpzYUfnfxW2L4KqVlGmrdsKLgQkzHOZ3XLuFMQ/8CDPd4pW31quRmZrGGc0SKoqCwlAKLm6+WT1ylbKGazi4YpYi9wD4vb8SN7Dt3wuYa19ztEvyssd7HNnSmKYpR/iFKI/1Dw4kR+wP0ttw3KlYNhTyKIYtYVTTIZy4FiY0rL2sZUfUSFnljcecm9dSa7TUdmf0lwiLPz8rIbQD1ixH+GcctpP3m8+c96d+s4wt1Wu6epPhfFHewSZnRA85QEJJcGVoF4lxUasDiGTTftiH2ulRkXNCBkj0WeEuqlE7X93xZvup+eHIPFT2bknuGZN9NgU7DKvgcU1IsQkVl/JiIPPiBH0X0LHqqfMRzcn5C/VdFioe2wkWCKLpPmMfHkiQfKcQqEheczHPVjUQXcokLjBM2QQiWk02+hVqf4GIhleoo1nwH5EbnIOPwQxFR8JbuuY8xP9sH5OgV6JP3dFUDXTRIJCbxCV8RVP7r9FVFmE5xhKm5MdZdWJXd/iVwn5yhID71NJwjJMwLr4BbkbL54AGrvQvT4nzh0kerPYnqnL+RpZEbyPRccM0cBFZ08/4b6SpULolKUe2gQ1vnIh/n2bl2sJ1zI6TdpIdZMzPgz/d3od2M+sXJgDk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(18002099003)(4143699003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2tGb09UbDc2dHp5L3ErR2VmMk9oZG4wZkxkMFl1d2wwK2JXMk0vVkUwcDRO?=
 =?utf-8?B?bTJQOHdqNkFEbDIycjF0d1Jkc0NhNDRJQU51MDlibmhiWDJJSk9zclA4KzJG?=
 =?utf-8?B?cXVTbVY0TkhVWFI0ZldJV0hzQncrcjVjVXZ3azFyRm5oQmtqbWlmRmEzUG5N?=
 =?utf-8?B?VFdKY2ZGS3hEMmhjSEtRK1BmZHpkUzhJQnhYNENvN0V5MGZHZFJwdDUwVy82?=
 =?utf-8?B?UmhRejdNRkhEYTdSUzBHRmhRZjRmTGJ4aW9YWlF2dktrb1VHQW9zRXB5TDVr?=
 =?utf-8?B?R3lWdWh3czFPM2Zucm0yZHZqUWhmRVFaUGdWenpITVRMVUIxeVVSbHFuQmRk?=
 =?utf-8?B?VDdsK0dWaVhsWU9wWnMvdE9ncU5mY1BwRkZJTzhBTm10cVFRbzdXNUVMSHlh?=
 =?utf-8?B?cE0ra3B1Sm92dGFVZnNMWlVpUEd5T3gzVHNhcVdjOUdZbERkM3VwZzhrR3BT?=
 =?utf-8?B?dGZDK0t4OWxBeWtXVC9hb2RNaTJ5MmFVbVBPWXJ4SDNNeWkzY2d3OGozUVI3?=
 =?utf-8?B?eWFTWSthaFZ6S1BXYnFycE9LK2tFbnRqR2YzMzhUL2FibE1jRVN4eDBTSmll?=
 =?utf-8?B?cGZPeHhyZllBaDhoNmorNmlkOS9BY1UzUFBuS1Z1dmt0bUtsb0hoVXZ5dmky?=
 =?utf-8?B?eWZXWjdqQndZSnpBYnJlNWY5SGM3NVQxWW9oclN1V1dxMzliV1F1aENQUlNO?=
 =?utf-8?B?ZGNSQ3JFZ25Uc2xtT1loNFdTTEdBMkw3Y1F4dmV2TXBkUE5Td1FXYjFlbGVT?=
 =?utf-8?B?ZFdyRDRlNFNVakc2WGJrZXhCRFp6eHpGcXlqWGtzVmo4MTVNUVdrVEdBdGhU?=
 =?utf-8?B?aVR5MmRKVVlDZUJmbFhkdnQ5R0FmUFRtRERaSkl2ZHp6Z0lIWlpXNDl6dCs0?=
 =?utf-8?B?b3UrTGlXamZCQTJ5TTUyckszYkxNbFZUTWxYTTc1M3RQVHJ5VU5zTXgzejBI?=
 =?utf-8?B?eXIxaUdPNTUrcEltTW43L1RhUldwd1p6U0VHOHNPWGloVDZCbmxwMU5reHEx?=
 =?utf-8?B?bW5Fekl3d2xMM3B0YjNrdWhzOGtSRHJvMjdJQmt1T2ZIZFp4VHVCNkRrWGwz?=
 =?utf-8?B?LzJxZDVJaXZVKzUrVEY5M1liYkdyVzlmVDR2SzBrYTR3RFJENGJwaFZYeElk?=
 =?utf-8?B?b29SaHRpQzQ3RjRvNUhQQkxJK3pqbWIyN3JwYmJQc3BRNzBRcG1qREFYY3Nx?=
 =?utf-8?B?ekNvWnhxTXVqaVZ5bk9KRFIwNlB0cS9uY1JHekhaUXpTNEFPakhhVDNGUHB4?=
 =?utf-8?B?anlhUGtRd21nNWFPUEZFQlNwTDA3V1V4RGtsdm1hYXFMMjVzOTdOZDA3WjN0?=
 =?utf-8?B?SUNiUXdhSHNla1hFR0JYS3dwVUMwU1RmcWU4Zy8zQlBxRWNsTVhFQUN2TU5n?=
 =?utf-8?B?dmRXdGdaSnhRVmdhbXdiMktlNHFFam92a01lZ2xPeVNhWVhPbHg1UjJkVHdC?=
 =?utf-8?B?TER1UFhLV2JQK21QRGlibms2NmV0dG5rY3V1V214UkRrRDVLUG51WmQ5L3Zq?=
 =?utf-8?B?L2gzYm9mN00zQzJ6SlJYNnRkSWpHSkxtYld4a0RHbnhvZFd1SHlhN3BmV0xa?=
 =?utf-8?B?akF2bmdQZFJCV2kzV1MvSWFxeWYxYk1nZUh4U3hkdjdyaVRBeE4zV1A2Rzlh?=
 =?utf-8?B?L09lWjhkeHlHRFRuU3NpTDFtZHpoRmwybFp4OCt2MFIzRXRmQ3BNNUR6Um1M?=
 =?utf-8?B?RldmRTh4ZW9JMnhsWGVVckpuMDBjZlI2R1VQSUFWUjB1TWtZeE5mMXpTTmsz?=
 =?utf-8?B?aW53aG40WXhlV0xjTTR1d1NVQ3M5SUc5T0lIMDBDQzVYVzl4WWFMTlFYNmNm?=
 =?utf-8?B?SDFSOTVxM2d3eHMyVmp2NjNMVkxjTTRrRXVvcEFuQ3VRZFJuSUhiOGZLdURv?=
 =?utf-8?B?emtPV1lkb2VubGlqY2JjZ1FLUDEzUDhjaDQxSGJGcTJidmZHSUpIQVFDWm8r?=
 =?utf-8?B?ZHhlZ211dTVyMWltb0JlWHJFcEVjd2RHWmdvM1BjSUc2dFBET3cycnlLZmdt?=
 =?utf-8?B?R3hBRWVDdjJLMnMwS1ExSjRrVUt0NEgvUThkWjNWZVRORXJndldIaUJuY3VE?=
 =?utf-8?B?RlJiRTRRL0tiQ0FEcm1mM0ZZUFNFZDZ5cXBYb2NOeFZRL2VCdWJnRHo5RVBQ?=
 =?utf-8?B?SlFoUUNmYzZNZVF3UzNaeW1IK3ZPYTBDUDhuV3Bud2g4bjVheXYraFd5amhH?=
 =?utf-8?B?Zkpodi9SODZkb09kYWxRSHlyYVNkc3crblVUOWxSeWxyNDE1RVNISllqSkFT?=
 =?utf-8?B?b2l6Ym9FMnFPSGM1c2RsM1RaVEw4Y2pCYTU0QmxlRE9kSThNZzc4ZkZTUVI3?=
 =?utf-8?Q?w54LMJLOCmzIc9ymzz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe9e8c6-5ba0-49cb-791e-08df02369ffe
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 23:22:54.9715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/n2hrcE7FQFTU0UyzpyucHGdXoiR7ad29zr3ORXVqh1wXime5IqMtXUHDEl8zQ/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386

On Fri, 21 Aug 2026 22:38:37 +0300, Leon Romanovsky <leon@kernel.org> wrote:
> calc_map_type_and_dist() prints every other diagnostic under its verbose
> argument, but reaches the "Host bridge not in P2PDMA whitelist" warning
> through host_bridge_whitelist(), which it hands acs_redirects instead.
> A caller that asked for a silent answer still gets the warning whenever
> any port on the path has an ACS redirect bit set, the CPU is not
> whitelisted by cpu_supports_p2pdma(), and the host bridge is not in
> pci_p2pdma_whitelist[].
> 
> [...]

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
