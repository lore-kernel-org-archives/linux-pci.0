Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010023.outbound.protection.outlook.com [52.101.56.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A67302742;
	Mon,  6 Apr 2026 04:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775448020; cv=fail; b=bc2EDxAOH8QmXwEfO9Fmm/NygJgh0GLFgQf69ASgmFOUpoaIVGxGb3QQkDEkjj6eg/rzJfU+neYDVYpZvst35RO6mR5X83bZbJIHBE/zws5AYMbt5WNGsBtYahewBEFOCpiqupUAC1tbP09lp0kkZZRLXUd0Fm85Kq03k35h0I0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775448020; c=relaxed/simple;
	bh=XN6+iRdyDIxiahpEXyiepv9keZTTLNxR8UR/QIpHckE=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=vBAjJujzjg3CD5LL6tl2uRUOWBW4IvxuULx1F6Q3bZmZvWxwPVuLpjrN/I7ELy7UsjcDRpIX83kUb+Lt7gaFjt4MSg8f1EFBtx5wzViZZEQEbnCq9pUjZ+k+41s07ONfI5oS1SJ0nqVCvF/5vUsLw0T7wk9zf/DPWhucXDyf3js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b7JyvbTO; arc=fail smtp.client-ip=52.101.56.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b7JyvbTO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NY7i9imds2/NgOxEE2g/mnhQoXyvl6oCvTkYE4BfwKsRbT4KP2u3KTl0TqBMQUwwSoEaVqJun71fydaqP00pB496xQNqePDMClTK5P/63y8h83CtOk9+G0jFIOQ3/mxSCOW06EaOY1uOzWZgxIoPn2QqxVzq14KLtjBYWhc1zQ3n1ev1rKfs7LN5ea2FG2OVamSCgTO0RwKMvhXSsjQADr65lVW6K5TeLbWphRC4ksc6zBK++0r7PE9GllR0LYNZDawnk7zM3DfRQZUBgLvvq+mGO3wlbXt39S4zszfMKTLp9WWjqIo4YCIRieMahDEpNDwIqLlA1TZW+i+NKgpRJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XN6+iRdyDIxiahpEXyiepv9keZTTLNxR8UR/QIpHckE=;
 b=RRCvIQOl1bcH3R5nGiZVBrlfE2F9ddiSTyiQX8rMttBy6qTfSY/H/2PPiKgb1wbO9AQakW1AkOYjIGjynqyQGCBs0kRv92gt6fKk7/eFLNMuhvLWlZxpdHAkm837HqzwiFgFxTG+E4JjzrLT5jkmN4Ail740X/TaCqa0G3uiMz7cbp2OVEaju3MSLnyGriKq5tvNJcAVuvR1xATYawkXA2B6V6w18wQGakmKKZOzdejZuEfM5OmY4C6yZBNxH/Is8lmDylECZzvOd6UBRUmaUJhzJIJssJNEBfDFiIXEYM/WtarALiq/Ol3R/alSozyVTkATxrNx8d6l35EPZa8GRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XN6+iRdyDIxiahpEXyiepv9keZTTLNxR8UR/QIpHckE=;
 b=b7JyvbTOJBbFET2e6TFQz8iHPAEADdLVaTJzp0CBdgqFiSX9iK0y3Jun6EKdlbEeZxeSgCuENXHb99upVxHv2ArSd1aO1V92+uYvGHV+ERpv3lNPBqzB9EMWksstjXNHL9WuA2HHbYVOPWIyyVrEGI/kDRyn1nKB3MWk1sRLFIimSBbOJxOQIdsQUCEPU7zb+zD3X/mzQu8R1NwlDlczULtJc+yTZlQ5+1yRLVH0pt8cdnhSMSVRTHm5/ZVEzUNOLOnMklmrXdbfljbe2JR7Y2OE1dJ2p7Ln6DfF7LcA++PWc4Dcds4p6Spc3QFHHq+yAW4QOz/Vh/zDyRCWyOLLUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB7512.namprd12.prod.outlook.com (2603:10b6:8:13a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Mon, 6 Apr
 2026 04:00:11 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 04:00:11 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Apr 2026 13:00:06 +0900
Message-Id: <DHLRSIFTH8NK.1IIMX3HZS47G5@nvidia.com>
Cc: "Gary Guo" <gary@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/8] rust: io: generalize `Mmio` to arbitrary type
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260323153807.1360705-1-gary@kernel.org>
 <20260323153807.1360705-3-gary@kernel.org>
 <DHLB3RO3OSF5.2R7F27U99BKLN@nvidia.com>
 <DHLLV6ER6L2T.JF2CXDXSFJX7@garyguo.net>
In-Reply-To: <DHLLV6ER6L2T.JF2CXDXSFJX7@garyguo.net>
X-ClientProxiedBy: TYCP286CA0152.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: d1bf8ec9-3c5b-4e2b-15f4-08de9390ffbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|10070799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+9lt0RMTOcxiEkQAYsUw/Vkzkw+Y9Sw2FFZ+RnBNCA/ot+1sjBgaQJzQ9MGpUoNF0FOIDVZfZkQazpHTyguEjMDYYQfu42bnVwwdNTuS7u6qQ2gbvptnY+JqmY6ybEYNMxdY1/Tf/qOV5yAeZnp+inaPi8T1SNQtUT0d1IMkIK+quKlywkYUq8yTS2bKJAd1lU4RJRe6EXpt650hNYje8nNCC8MyXrwd4Q/BzzKhd+mX6ERgBFSbIAs1/nKq1V/t0pA4yaoHQ3SrCoxb52+EkI96mJ3b1J2wJtHeKflQj0sWtJ7lDHlTs4AC3ndGyC7ZiZDyLodHySU9j7YNy3DC14Rbku0RvmdSaCAfqhDTyKCWkTYvVOWtlP6jaNOIguMpWpI5hs5C8/Pcj10o55h0vL4irVGhN/6Kr4+V9E82PvTacA2J7fJg24ezgYIvQamAx99EhB6kb0NNyuezsOX4lv/r1nkZ8l8X37I4m8yv0v5IuZn0QwgT8BpiPAWC74kY6U3w+EvvBF6WNCZlTT8Jktcqi5Go68EG517GZEqdHnZAbM9TaRok2B1fLnRQTc6n4J96bzfQlmjCWF3a985ohK6JcfMCzjSzYXwRXXpGYWLBpdkEQ7VhdZKT5oSZvLhOPmS8fIRUzpkILGFUGW5BLhIWAhumedaK2Wz2KnVqyaBy4LtoCTySBBvKjOcWKMWa49pOj7LoyjvmP4Pt+9iKA+g6x8CLgj7jhtY/4s5bE9k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(10070799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmNDVVFtMGhsWmVFOHRlWmNxUjM3Y3BjY2dvK3g5amlCbTNBWC96TW5ZSEp4?=
 =?utf-8?B?ek5vRHhkTjVnZG9sMjJ5Zm05dXJDNUtYWDJoOG9VUWdNQ2Q4cWJ0bnBteHpD?=
 =?utf-8?B?Z1lhZ0tPUDRZY2ZoM1FlVVk1ek1vSWM1eWo4dVk1U1h3aGV5TW5qU2l1aW1n?=
 =?utf-8?B?R05SdDJQdVlUZzBITCtqazR1STduekp2a3cvTm1QdjVqWHRVN01EYUN3Zk1p?=
 =?utf-8?B?c1diN3JORjc4eFlQSjhzdWJpWFdSNVk0VkRxUjUzNXhITzhMUUhTUFpHb1Vv?=
 =?utf-8?B?SHcxbm54Si9Ub2wxMGREcis2UXhGSkM5OFVNSXZ2ak9WNktzS205SStJVWdt?=
 =?utf-8?B?NTVOSmZZZ2Z6Z0ZvZVROTFJ0TDNDa3ZuVUsxYzFRVzlZeEV4UkxmUzBYNGJ1?=
 =?utf-8?B?emd5UU85cERqbEVXUWtHclMvOGZUZUI2MFk3R29zQUM0ejQ0QWh1T3kxK1dm?=
 =?utf-8?B?cnJ1WGlCbnljWTlxaUU0clFXd1F4UWNxWDZsQTJOZkNQTTMwVkFFMmxVZFgy?=
 =?utf-8?B?RWh3cEJXSm02Z1FSdlpXbjRQZ1gzc1pVUWM3Zjl4VHZ4OVZxMFNKMThIdzFT?=
 =?utf-8?B?S05oUk1hSkNIWXoxOWgxUFhnd1RUb21lOTFDemhCcTlremRIRUdOMi8rWEVt?=
 =?utf-8?B?TDRRT2FtYllyUVVLSGZ6ckhaaHB6Q3o0cUdla0VoVmIyVkF4anlQS0dyQ000?=
 =?utf-8?B?NDZTVWxDbVBuMGVaTkpjVFI5d1JjeUxnQ1owdnREUndiTEdYaVZraFBacndy?=
 =?utf-8?B?Mk1QNEJnWHpna2RVR2grZHp1Z2FWcVlqSWVWNStCbHNRZ3VXTlp4amthMkdv?=
 =?utf-8?B?Y1FGUCtER3ptYXlDNUFkaXRtZ2hLV1A4YzV6V3p3Y21KWVk0SDJPQTRSTFBH?=
 =?utf-8?B?N3E1eStSYStVQlk2YkpWMUlnV1QzVytlTzhGK2ExL056RTJPUGZ6WW1FT3Rw?=
 =?utf-8?B?ZFNnV0tsK3FSMmQvYTJpN2dYdDk0V3FVcDFmY3ozc1VYWU5aQkY2b0huTS84?=
 =?utf-8?B?UFMvL2hNSXkxVzJxM2xkNzFjOXp4Ry9SbG9SOEdIZ2w5eWk3cjhyNTdISTBy?=
 =?utf-8?B?Zll5MERDNmg4dDNVcVVKSW5UdHhJZzczV0I3THUvVzR2dU9IVGtzVjFTVXVY?=
 =?utf-8?B?WmZrN3NGdytpNFhKYTROa2d2MFg1TWxhV2thNkJRNWhDRHRvWlNidG9aQjJx?=
 =?utf-8?B?NE8vL3NqZU1yWTRnME5OYlVmbUREUGFOWVQ1SU5xMnNUSStpaExVOWRhOGlZ?=
 =?utf-8?B?M1hxZlVITEFpcElLTnpIQy8vUE1ZcnUrOFBad3l3V1NDcno2emx2NFBGM2VN?=
 =?utf-8?B?bjdhMjI2YU1xRStEa1IrVlUxSUd3S2trcmVCUVYzeWh0RlNiZW1sbHc3RXpp?=
 =?utf-8?B?cHpvdGErelE2WkxWVFl5Sy9Nc1V4bkUvZDkzTHZiU1RWWFcrb0dCcHdXT1p0?=
 =?utf-8?B?aVZZc2RYT2Fjek1HK1QxeU94MDQyU2MzQXZ3cC9adjVGOE55TkxTNlpid3pG?=
 =?utf-8?B?NlU5T2VPVE5CeHoyZUZQOUFDWVp2VTZ6c2Q4SDV1bWZtMU9mb3JpZTVwcU4x?=
 =?utf-8?B?QkIrOVZQN2R3SnRYOFFtbGQ4L2ZudUJoNCsxL2pGOXhlVEVyN2pKTVJnUEY0?=
 =?utf-8?B?MGc0WlE1ajk2cDJrNmF1MXRzdXZtL1J2dU5OVmNzZDhDT05oNnFyRXo2RzR3?=
 =?utf-8?B?N0JPNFV6VkFXWHJ4Um5HUEVNNWtVZGprM0VtWjFBUUZCZ2pFbGpxZ1FNbFQ1?=
 =?utf-8?B?VDQzZURVVldlRDZueVJqYkhGV2pRTmF6Rm92UHRoWGduQWc4UGZSTGdNSU1G?=
 =?utf-8?B?RS9NVmtUWWZRZ0dkRjdiNFBhTzIyYU1jcEFPRnN3VlplN3JMb1NVdWU2d2wx?=
 =?utf-8?B?ZHBvdnRjUzJJalp5ZkFMRnpiQ0J5RmZZZ2RoWDljMzVUeDJFZEE3Z2FuSWNW?=
 =?utf-8?B?OGs5RlJzVkt0eEVLdU9zdzhhVlV2OFc1b0dqL0Z2S3ZwRXlmZ3pGYllnQk9K?=
 =?utf-8?B?Z1AvTFJISFVRT2ZQQlo2OWc1VmxOMVhueVUyWmNwdlQ0NzVtRFY5eDM3UFVh?=
 =?utf-8?B?eUhGVXZiaUVEM3hpQkU0bStYdldLWGE2Z05vU3FoQ2JQeDhnczFiTEdjY3k0?=
 =?utf-8?B?dTFnclNKTEtJYnBPSTlDYnVYMHd0YjN6N2o5bmhjbXgyY0U1U3lHRVVJelZC?=
 =?utf-8?B?eHlmZmg0MzRjY0RYSkN2aW9wbmpqeDF0V1M5dGo1MmNxd29iK0s1K2JicHdE?=
 =?utf-8?B?RnVsTkxPZk5TYzdJTDNPQnM0cjJpRzhRZGg1WXNaYnA2MFZIS1NtUUdLNkNS?=
 =?utf-8?B?UVV1QklrOVJUbUF2eHhXYjZrVVRSZG5LVnkwWGJQYkpybjNCWFJaNkMrQWgz?=
 =?utf-8?Q?JzNcwLwD2gJ/MxSMjkk7SJ67P7Hg1wi1q8C886yB5L0DJ?=
X-MS-Exchange-AntiSpam-MessageData-1: 8iQDshbXwnV2dA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1bf8ec9-3c5b-4e2b-15f4-08de9390ffbe
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 04:00:11.0045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 62iNHvtWCk3QpYoIBbUz+x1m9CNcpWCYNcF6EfltibzK2xGjrZkmeh2TJx5D/Sc+Mz5utBt2n4qomNWa1q4v1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7512

On Mon Apr 6, 2026 at 8:21 AM JST, Gary Guo wrote:
> On Sun Apr 5, 2026 at 3:55 PM BST, Alexandre Courbot wrote:
>> On Tue Mar 24, 2026 at 12:37 AM JST, Gary Guo wrote:
>>> From: Gary Guo <gary@garyguo.net>
>>>
>>> Currently, `io::Mmio` always represent an untyped region of a compile-t=
ime
>>> known minimum size, which is roughly equivalent to `void __iomem*` (but
>>> with bound checks). However, it is useful to also be to represent I/O
>>> memory of a specific type, e.g. `u32 __iomem*` or `struct foo __iomem*`=
.
>>>
>>> Thus, make `Mmio` generic on arbitrary `T`, where `T` is a sized type, =
or a
>>> DST that implements `KnownSize`. Similar to the `MmioRaw` change, the
>>> existing behaviour is preserved in the form of `Mmio<Region<SIZE>>`. Th=
is
>>> change brings the MMIO closer to the DMA coherent allocation types that=
 we
>>> have, which is already typed.
>>
>> You probably noticed, but the regular `read8`, `read16` remain available
>> irrespective of the `T` parameter, allowing the `Mmio` to be accessed
>> using both the structured type and arbitrary primitives with an offset.
>> I cannot find a reason to label this as unsound, but it might be
>> confusing as it makes projection an additional capability on top of the
>> existing raw I/O methods. This might be worth mentioning in the
>> documentation, or maybe the primitive accessors should only be made
>> available to `Io<Region>`?
>
> Perhaps I could add a new `UntypedIo` trait which is implemented on
> `Region`? And I can restrict these methods to be only usable for it.
>
> I would actually prefer to just remove them, and say you should either ac=
cess
> via projections, or via register macro.

I am pretty sure there would still be users for more C-like accessors
over an `Region` - although we should discourage their use, removing
them entirely seems a bit drastic to me.

How about an extension trait of `Io` for when `Io::Type` is a region?
This makes the feature unavailable unless the trait is explicitly
imported - just the right level of friction imho.
