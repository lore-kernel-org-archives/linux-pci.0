Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022080.outbound.protection.outlook.com [52.101.96.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660C33FEB18;
	Thu, 26 Mar 2026 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774535501; cv=fail; b=MLaIbvnewE/eBIaPCd8JN8c5MflYAdp81Hh9pscKBpJNrGj1HTzrc3I07s2GtWz95f8gh2WZwuC64n+IZ2BSDmZbIyrN+BcJ8dUcfJYLn+YQytxco3wBAhxxL3yjnEUXLgT5SNGnhbfLY9kpdQIRsWr4ePiEhb8mR5iFOw1zv2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774535501; c=relaxed/simple;
	bh=Lqs49/Vn9MPTczxpkBBmoB5rwugkzuGYXP52H1Mug54=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=GJu5mNRf1r8oAbU7yimQaiClonHHVDPXDTmEUzB8vpMjvm+38Kep1c+nCxHfbVfeaxoxAVtuiXVoPQ/roKue5TKu58ol/vm9SgGqYrfPlDaDzJBSqsvrme4UJH4XaoKjTpGczprIlW5cuZ7L2w8FjmBkMC3gZ2vBXzivJHlMPM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=zDMdq0ZS; arc=fail smtp.client-ip=52.101.96.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="zDMdq0ZS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ec2XmeOno/dsdY+ntOTsKOWEb0aBiFEu9KidzWOC2KyjIfCOCaYNeP704TrAgBn4FtPbHtbr+hGM0o6rEJ5yA/Yx0qAroAYJPMteCiiZ9BzF3Y0v3aiQXVpNFtUz0RATTYnG8J8eKWaedlR0f5iqn7ii+5Cz7PKuxwWxRuyUFKy0k+t2WwUIXCwUI0JK6HebT3gzUNNUm0Y9QAMLKxdWmHk4V74jSRw5L8OI0Vg3UWpkq6ZObmV4gQGfj8vhhlCRNoqIMR7yZSNE/x5COf7CDH1Wu4hR7qvVzqaNVzTXb1R/e4fj0iM/xQjaeGCKT4wUbx6Runc/giFTjSdzHmnpgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4MljMmpky+Ozx+IFgyaqLFgKTNbkn2uCXLsmBUHdts=;
 b=JHnOKeskeNLsh3s35Bb7bYfVAhR0wI6cvM+ULvhufLRuje76OvQReZIv3tJ1u1Z7M0oP7JC/G0VZtPw4ee9vkr4N1I0M1aAFNhwsYhTbmuQ3Qs7RoLwVczvOIKas8Il/TiUo1KWYOkf/cTuWzIJ7LE/6WrsJGgp/M+6G43Mm6aohoCj1qV4lNMSht+S0y3o8h7m9LXcrxQj10b4WtkJla+28/3GTxxo32yPCQH20QaPBpxqAop5dJEFFhntHLbZuUDk0c/abKPYbbnKfgaTsK49h5ppiC2Gr82qn3RkJ/WJCPadwATY4M6jSifmKJudYFjdudrdtSvIQB5CMhxYt7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4MljMmpky+Ozx+IFgyaqLFgKTNbkn2uCXLsmBUHdts=;
 b=zDMdq0ZSsIt1Z2eAtsMAirsXeGFCnytNgNDmRlND96EGMDO4jqj4QQGPrN4pOQ9cZVdXH5mMFVocuWuQ2+gXrmAB+lYjwgj1hP11ma8F8uv/uRh7pvJe0huHYhtPitguHNRYBSOvOhnElOxxDegtiT2BsJKE3lGEj3sTQTzx5xQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOYP265MB2206.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:114::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 14:31:36 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 14:31:36 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Mar 2026 14:31:35 +0000
Message-Id: <DHCSC0M3P2NE.ZF90M8QI0QTF@garyguo.net>
Cc: <rust-for-linux@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/8] rust: io: generalize `MmioRaw` to pointer to
 arbitrary type
From: "Gary Guo" <gary@garyguo.net>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Gary Guo"
 <gary@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260323153807.1360705-1-gary@kernel.org>
 <5t7h2K-OzntmDmVbwyRSJCfuCaWFNs8bmYJMd8dOrRTuDwmTSrbBdgPily9gdXK_ylxKdR1REa6Oa2puVmTHPg==@protonmail.internalid> <20260323153807.1360705-2-gary@kernel.org> <87qzp6ycol.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87qzp6ycol.fsf@t14s.mail-host-address-is-not-set>
X-ClientProxiedBy: LO4P123CA0334.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::15) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOYP265MB2206:EE_
X-MS-Office365-Filtering-Correlation-Id: 8092208e-8efe-40e7-8cb4-08de8b4462a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Al5aCqVl6L1TXA/rgX2qZKLdsdBicHbT2c9W+wODNSxwvIoRJGH/QG7sjZo1Ux1Zbr5Qbo8OksrMzh07DmeRf0LqGiKkxnMtt34YVQNU5aJ659mQaHiDjfzIyCjd0qQKHrOvb2zQ9KGwdQUbDPYm8dhCK+13SsgOc9907xUGJsxJ30SGsTa8Vf/iEualgaIy06ApwB9bq2+mdlN+SKehiS2PeFCvL80M5hg0u6C5Wddz38hFItJNHNY7WYkkAvCQlxBeUGmVzWoSXvT+NUSXCJtu0R56sW6Rr6GcVMfcW9NUN1WQ0NsZlrjJG7zR/KJPPU0FLnBuXO/VQ9DOTAznWSaP1rIRKk8jR/Yhc/bhcakNV/y424LupUkRnstOjjqM0H+GZ5mh1BL9f2SzmqQUkh875d3tvx2iVjSLZfvDAXbFv95FeJQdhxn3vDMNVd9zoP22nDRQEOzhGI+QdYWmUcHbEo2y8LuBA3gXbTXk5deVv+3jcMLOjBVfF0ksk5oCGsP1oNMPHDtuy15/Rx9VsLVWuNXWryrQT8WKNJCMf1TcGQv9PKEoMwdDJtgedw7pNCbkx0Xa4DEFexl22PuOTREfnP4rgJBeO8mC5FZ87L34xrnJKGcKOmrQts6/c6TAL1sCV+dyOmKcYY48TdFGl9bA+t68vf6uT6zaQsic2wO0+cclAg5a505DKwPqncg7LGjXNNGPqDgL7yf3T47FQBAsu9l28Uo6E/6tuMUbhn4M48fOBtEGvj6dom6niGBMf70yUFQZ/YhuHpZK18jIFg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGVKUFRPVVQva2cxd3JGckhZWGYzQ1FQUFlrYzZBaWdSV0lReENVNFR6QmVQ?=
 =?utf-8?B?TFFjS2xuclRZbGI0UXpPUS9Lb3d0NGEvSUwxVFNsREUxbFA4b2RuZTl1MUFO?=
 =?utf-8?B?SjU3UlRuVngxcmpTbEZiMTc0K2ZUN29kNjRRQ0hkSW0zaTBoMjRhYnJ2VWVK?=
 =?utf-8?B?Q3FHYm45MTdlZ241M1UzU2U1Rm9JTGtST2hQNVl3UDhOT1M4Sm5DMFIyWHor?=
 =?utf-8?B?OEJyS2JoQlErR2JYVXRGZys2cHpPZEZSVHFIQmR5Q3Q4aHU2Wlg3N29RR2Vl?=
 =?utf-8?B?QitjMFB5MjduNnRYYnVFMksrRW1oakVxZFFDZFJ2YTlvbmVKcy9OU2t3SWxj?=
 =?utf-8?B?UitNWGxBVG53ZDV6WGJQRVlBcWRPMlloeTFhR3lqNjlrbzlHN2ZPVXJoMzlG?=
 =?utf-8?B?TWNvc3BYNUVpYWNTQmVPQUpRLzgrdSt3ZHY2SFJiaGZlSm8zSVNMeEVneERi?=
 =?utf-8?B?bXliOXNyT2lLdWVzWndxNHQwL3pJcUJCUHpoMGlkYWphS0UrcVd4QUJlVmpt?=
 =?utf-8?B?QzdKRjBHWGRXOERjZzM1akJud1BrYWx4Vk12cXVkSmd4SWlxa3hFbDNwVjZk?=
 =?utf-8?B?Z0U3UWJaSGszaXBubmxGSTJNbUphdlFvbnZOMXR5UVM5eEcvNmZ1UEVZVUgr?=
 =?utf-8?B?cEhsaTNQalMycTB5VXlGa1I5czV5dUtBQ2Fzd3B3aE9nT1NFY3ZMb1ovWnly?=
 =?utf-8?B?dXVoZFo3eTByb2hsR3BjMWlyS2FNRStzK29lcVpUUjBnYzRJbEhJNjFkNkY0?=
 =?utf-8?B?UnBWeVpTKzVkdmgzWDIrRXFMSjdobHVZdytyUU8xNHNxaFJVU2R5S1JrVXFy?=
 =?utf-8?B?WjVKTmkvb2dhclBHWHNRQW8xZW9EWmN4YTNidy9CUy9HaTR0STdzdDFlOUZh?=
 =?utf-8?B?M3cxTU42eGR2K1VTYUl3K3BrNG9YVGxaVWJNMTQyTUN0QVpOQ1MyVzErN1Y5?=
 =?utf-8?B?VnBGZ3RhMTduTUZIY2IxVXdrL0N1QnEyQld6ZUliN2ErV3JPalhzbVdRRFVp?=
 =?utf-8?B?MnBEREx4ZHppajZ4K1N1VFhYMDlKMExKSklwMmZzVEpzOU1FN2dOcWxIZis1?=
 =?utf-8?B?V1huVVc3UUFQelIwdTNUMjZLdHpRSlkrTVcvOVZ3TXRTQUtGYUo5RS9IZi9C?=
 =?utf-8?B?WldIdmh3dW9idUVwV2RtY2daVWpOOUp6TEk5Mysyc3BBSjBhbTBGRFFmWVh2?=
 =?utf-8?B?YTFCbit1QkNiQjlSdDdaMHlZQ3UyTEpVc05yTXlwRFBSN0VrRWNzT21vUjRT?=
 =?utf-8?B?dUZXVkxEazUramo1OWxBcUdqTlJUNDFTYytYTmdBdU50bnlqSmI2S2JEcEVi?=
 =?utf-8?B?aGdmdEhGVEhYRERIU1pSVitSbGpMRythSXVoWGtGRDBtUkpzWVNFS2JlVVd1?=
 =?utf-8?B?U0UwOE1waHE0eUN6eHVIMElkbXkvanl3ZkY5ckxOSTd4d3paTjNFQ0xkRXRn?=
 =?utf-8?B?UFJpNzYvZFMzNW4zOXlibjhRVGdSSUhRbFRxMXN0cEF1VVZ2Zmp6OHRvRHlH?=
 =?utf-8?B?aEtnNXJJTGUzZDIvaVUrcnp2RitvNFk5S0VWT3E5eGR1V1Z4WThmT1E3WU1q?=
 =?utf-8?B?M0twam0vbUZYMHdmd2VkYWxZRHhqVlZyVlFPME1wT2RrUnNYcm01QjhsY2tN?=
 =?utf-8?B?Z3E0YU52Mllob0R2cG5zWFR3QXVtRjB2eklkTVR1WjBSR3A1SnJnNmo4K1Jm?=
 =?utf-8?B?WU8rMkZVZCtFRzlxd1VmT2JTanhDVytRK3BYLy9XWjBXRlRDRkR3S2VjdDhP?=
 =?utf-8?B?Qi9WOVN4czVVTmVybThHRVBnZWE4alZRK0I0bWVTU3hsSTZ0NDMvak5GWGlK?=
 =?utf-8?B?ZHJ6MTMvLy81SDJXR2JCZFI4WGlGSHpHZnlMK2p6ME9veVI3NjFySmdreTZJ?=
 =?utf-8?B?QjVNamZ6TXZrTFlMK0xHN0tDRnBtUnpRUDNaZDRvVHQyTU1ickN3R0Z2WTFU?=
 =?utf-8?B?anNvQ2ZRRytxSEJIV2lxMHlDREkrVFJpeHpWT2w3ZDlKekdkbzNjbGJrM0Ni?=
 =?utf-8?B?c1cyWUdYVlh3dzRSK2xRcGVTWmZRaW5Cam5NdTdJQ2loSE5Mdng2b05pd1ky?=
 =?utf-8?B?RU9vREFmMnVoYytuZTFWUjl2Tit1N3pTS1VnNm43aXRDWDVOdTdUcHdQOWMw?=
 =?utf-8?B?dlZjOWsvTkgwMFNCUDVNdHlpUThYRWtTWTRIcGNrZTZWTmY3WnAySXp5M2tm?=
 =?utf-8?B?Q1pJbFVBTjhTVENoVkgyS1RSMTlDMUw0aE5HYTFqOTk2MlhudHRGbFZma0gz?=
 =?utf-8?B?aVBvSjJkRWpwa0o5OTBQanV0cUJQclNhM2xRWjRlRGJGRmJFZytWOG1FV0Vx?=
 =?utf-8?B?S1MyZldTQUpoY2RNRTRwV3ljenc5YXNCa3diUU1WNmRjSDlVZHduQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8092208e-8efe-40e7-8cb4-08de8b4462a2
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 14:31:36.3125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PeYrgfmCisWYs3Wf5n3GfjpbI8l/IOnnNMrQYY3JTr6Utd+5BjcFfPm/7ReWADvQdFBMIAWuLy9HjNw/uV34jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB2206

On Thu Mar 26, 2026 at 12:53 PM GMT, Andreas Hindborg wrote:
> "Gary Guo" <gary@kernel.org> writes:
>
>> From: Gary Guo <gary@garyguo.net>
>>
>> Conceptually, `MmioRaw` is just `__iomem *`, so it should work for any
>> types. The existing use case where it represents a region of compile-tim=
e
>> known minimum size and run-time known actual size is moved to a custom
>> dynamic-sized type `Region<SIZE>` instead. The `maxsize` method is also
>> renamed to `size` to reflect that it is the actual size (not a bound) of
>> the region.
>>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> ---
>>  rust/kernel/devres.rs |  7 ++--
>>  rust/kernel/io.rs     | 84 +++++++++++++++++++++++++++++++++----------
>>  rust/kernel/io/mem.rs |  4 +--
>>  rust/kernel/pci/io.rs |  4 +--
>>  4 files changed, 74 insertions(+), 25 deletions(-)
>>
>> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
>> index 9e5f93aed20c..65a4082122af 100644
>> --- a/rust/kernel/devres.rs
>> +++ b/rust/kernel/devres.rs
>> @@ -71,14 +71,15 @@ struct Inner<T> {
>>  ///         IoKnownSize,
>>  ///         Mmio,
>>  ///         MmioRaw,
>> -///         PhysAddr, //
>> +///         PhysAddr,
>> +///         Region, //
>>  ///     },
>>  ///     prelude::*,
>>  /// };
>>  /// use core::ops::Deref;
>>  ///
>>  /// // See also [`pci::Bar`] for a real example.
>> -/// struct IoMem<const SIZE: usize>(MmioRaw<SIZE>);
>> +/// struct IoMem<const SIZE: usize>(MmioRaw<Region<SIZE>>);
>>  ///
>>  /// impl<const SIZE: usize> IoMem<SIZE> {
>>  ///     /// # Safety
>> @@ -93,7 +94,7 @@ struct Inner<T> {
>>  ///             return Err(ENOMEM);
>>  ///         }
>>  ///
>> -///         Ok(IoMem(MmioRaw::new(addr as usize, SIZE)?))
>> +///         Ok(IoMem(MmioRaw::new_region(addr as usize, SIZE)?))
>
> Should this be `addr.addr()` ?

This (and other occurence) are all existing use of casts introduced probabl=
y
before we enabled strict provenance APIs. These should be fixed separately.

>
>>  ///     }
>>  /// }
>>  ///
>> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
>> index fcc7678fd9e3..d7f2145fa9b9 100644
>> --- a/rust/kernel/io.rs
>> +++ b/rust/kernel/io.rs
>> @@ -6,7 +6,8 @@
>>
>>  use crate::{
>>      bindings,
>> -    prelude::*, //
>> +    prelude::*,
>> +    ptr::KnownSize, //
>>  };
>>
>>  pub mod mem;
>> @@ -31,39 +32,85 @@
>>  /// `CONFIG_PHYS_ADDR_T_64BIT`, and it can be a u64 even on 32-bit arch=
itectures.
>>  pub type ResourceSize =3D bindings::resource_size_t;
>>
>> +/// Untyped I/O region.
>> +///
>> +/// This type can be used when an I/O region without known type informa=
tion has a compile-time known
>> +/// minimum size (and a runtime known actual size).
>> +///
>> +/// The `SIZE` generic parameter indicate the minimum size of the regio=
n.
>> +#[repr(transparent)]
>> +pub struct Region<const SIZE: usize =3D 0> {
>> +    inner: [u8],
>> +}
>> +
>> +impl<const SIZE: usize> KnownSize for Region<SIZE> {
>> +    #[inline(always)]
>> +    fn size(p: *const Self) -> usize {
>> +        (p as *const [u8]).len()
>
> Is `as` the only way to cast fat pointers?

Yes. There's no way currently stable way to guarantee a matching metadata w=
ith
traits.

Best,
Gary

>
>> +    }
>> +}
>> +

