Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C89495515;
	Thu,  3 Sep 2026 11:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436041; cv=fail; b=Xewzg6fkEgUbJLo7Rzk+/DgzJZcOFevQW1RN23Y7rXjqSRVv12xJzIRFsrcI7anZveSyqkbOIgJvhJ9uMuJm5BRLxprwIzjq+7RBWj88T87T19jVBG09Sb+XcqrQkrjmQ9T9RgrbzkKa/Tk1kK0TuQ4UOWCp6rDfIzDSXymJeVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436041; c=relaxed/simple;
	bh=JXkigm7UUwRmo86dGaMQAfS5+XpoVzFecfiJPMZhehI=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=BEL6x2dVzp5UiPd4C5vPSydb6BHYANaMTaxg5dOxyaFT723aCKy/fhnWIjDrI01aZOMhZYe6IorDiI/7g3rJLTbA2BbqMJNIunZfgUE84HjYF/YGYIy11tbudoT08IRrL/Wz9GuvGGF4UervG9JBYeV5jG4K5yrtCR57+eWNPYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GrsAvrTL; arc=fail smtp.client-ip=52.101.43.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GrsAvrTL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y1f+lNw4izv8OfmFoJUCJRB8CHZuLSHwehkahQTD6ZthwQiE9nGNl+Bcmac4YO3Pq8MkHB/OfQIYsF9Lhg3BSBs+QQdUV1ZBULPJotuUbi6iN11vXAff/1xFYSZQ0D2bPm0Q1A0Leaoxcn65he3bLrIv8bnFd8NTsU8HN7Bf8/u4WeXmMXkOp93G+V/voeuX4Y83A9Y4khPqOmJ0JHxXLL/N1dfK8hBj6MVnmBaiSXl5aNbDyhnjDc200Ilv1n2ewwdmocsOLygBI44rRcblAniUl9lspuit87Oj+J7Vz4VCC9655IoPQ0B7bEWwxp7bC3J2Wy0mJ97JeOS9ILs+Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRD0bUK5Iurm8ftoMfilRqs7LIHBy+x14Lxlaqf46oA=;
 b=iZNWGKgnwOHe4bJoiltOfhnZwKV3sBlzRCOpeNrfjPeogreq6faCGpJoM/+Nio03mHNe7PCvo/cCPf7OKGFLBYigHAmKoogjHgGp15rr5i+TfL9e1I79v34sepaooGMO2X3qUOuJLkxq3brV8gRbVyYEplf8M/RHStjBFJisIPX2gYSk2SFvduyIxibfcOCpqQ1jYm9dL/1BMR+FTZ0Sfz+is3xWzW2x0zrQ6cOvW3DXXZB1z5sBPMd63jYMPbdxP2cgXlnyZFFsDwWAoe8lMjJYuapMLBnAVHvWjDYH8xeoOkeTuDIYQiOOlnnQquxgbrKvQTafKj7MW35JTYMr1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRD0bUK5Iurm8ftoMfilRqs7LIHBy+x14Lxlaqf46oA=;
 b=GrsAvrTLJAFt5E7VRqH1tqW/m6Y2EeoZ9z0GTYwzCnpnrNJe0lWxJ0tLlUrmdFUShk6W0jk8bv7iHR7hD+fCxQ8DiGB3Lphz+O/kktzSKNzfvpTERg2JSXJLoXkjehKddLCq26j+BX+/FziSW+mYULdHL2azldbNvI7oF96WrfzVinUmOFgNcIMvFNnzzfhJIGaFF3a+2VtTheaPTAXfHh+jpbQCjRuxcehJBjMdOxkkgz2Tj/R5zf0QznMVwQZeiNr0FgzrSuICY6IWJElHgEaeF3VjW8CLwsFrGrreA0A78WQsAKxduIgXEZYWbfVTXiJ1vHRwTvqAHGRPxC6f1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH7PR12MB9150.namprd12.prod.outlook.com (2603:10b6:510:2eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:46:58 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:46:58 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Sep 2026 20:46:55 +0900
Message-Id: <DL5NNNDKFTQZ.3IEWFNTS1GQ6I@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 02/16] rust: mem: add `transmute` with deferred size
 check
Content-Transfer-Encoding: quoted-printable
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-2-5552b1d59525@garyguo.net>
In-Reply-To: <20260901-typed_register-v4-2-5552b1d59525@garyguo.net>
X-ClientProxiedBy: TYCP301CA0076.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::10) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH7PR12MB9150:EE_
X-MS-Office365-Filtering-Correlation-Id: 601f23e9-a296-4a42-b7bb-08df09b10f85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|10070799003|366016|3023799007|11063799006|6133799003|10067099003|4143699003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	3f9VPit8sLsNbddbnaoCSe6Tl7gQieIanyveNokvDBf1dQsy9nrtPRZfpTNG/kq4F4TbCSvJuDQMFh+wGGb8RnuGD0u0noO45ZVq8xEvAXTZsaKr8aOp/6MVF1gO1Q/GlX81HPCIPhc+lf6bKegxKKABGjw6uM45vxZxaqu9BsJ2vDIMoZ4AGEZ9NY85rzkhaOuT1UgSMr71oJJMyeQyZ+wn/ql8IHGzS6UnJCcZPyP+UGRt8or9o/o8UlKwWckzJgXKa3Uyh98bv6zuD5rFgRaAV3Kv2N7aoyPQi31C/FDnrQljYOVAjTvJhxNGOn1RlbcJR+WBsO0rjVGWXdmcT/gdZnD/Oyx3XzIOpi+BkdjqbZvzTvyhc8LKKiRmJpLcAUs+bI5iGaJMjxwuDQt6Oj+QYbTDQsSqI/Ufjy0tJBW7mqHzuqo/Ep3G35KH+C/AgaPAUXB0tOpo1bvD6FuaIzjz+KYdbmKssu3a97g+p/duyZ1TD0T/53qxRGmak9CGIDjV3QstacTpYy/6i0YtiLEGSU52EzmdYxQwR2XXS9+/uqvfKcAJ3dbOmuDMpJAL6lunLj4X2iu4ilbkKKGdpjLBEo4JpdTGf6I9rRl49F2y15UWTIK3v9e+8UXhziqLnm7ofEmistnotyHixWP2zH1D8DFZxtKGAYOrh+fcOWA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(10070799003)(366016)(3023799007)(11063799006)(6133799003)(10067099003)(4143699003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWZiS2tIYWV2ZGVCQTF2aDZRdzBzWC8rZHBlUFJqSnowTUZiWktIdklYY1Jp?=
 =?utf-8?B?S0k5WGxjWUNvbXBFS0p4cE5OajFuUzM5UnJMUVF6OUYycDRmREE3THoza2tH?=
 =?utf-8?B?L3ZXRTE5dG1Ia0xFN290S1RibDdUY0xrN2g3dGNQbVVQcU5tandtRGE5VkpI?=
 =?utf-8?B?Q0FoV09ONGpnR0VaNTRRY3htU1Jubk1OKzlYR1dYaWhCd0RmT3VSSEtLVGxI?=
 =?utf-8?B?VERsckhCQkhjZzhMMUVPaHhJZUkwOGVpazFZVFBZQ2xtSTdzT3pLaWhLZVNF?=
 =?utf-8?B?WUxSb0VsL2RmVkRVa0V3U2hKMkY2NlJiWkZXOXZ1cDBNQVZudE8xclVtdkVK?=
 =?utf-8?B?eWZxV1BXNVRQYU9GekxFVWgweU5tWFVUUmUvT1dYam1pQVF3V2xXNUF4aEs5?=
 =?utf-8?B?L1pxZU92REp5b3JpT1IrQWsrdVVxUUFGdEhsRWxWMjA3YmxMQzJwRUpYcGRQ?=
 =?utf-8?B?YkJuVzVUVkZpZ1oyVy8xTGVvMzVKOEh4RFFXSjNISHlYL2pMaVg1Q0JXWEFJ?=
 =?utf-8?B?L0g2NUNxVG9VWUc2ZVh3LzMzOEMrVkpTdkxDRDR1SEx5QVZRMnlPOTEvY0l2?=
 =?utf-8?B?dlduVmptbisvQVNqQ2VWSkIyZU9wQ0pPVDUvQk9sVko0cXYybmtraFhSbWhM?=
 =?utf-8?B?WUFQekczRVc4bFA3K2hxc0hOdjZmWWJFazdjY3BUNXBOVXVLN25BRS96a0Rp?=
 =?utf-8?B?MDZGQmZCSEQ4RWZPRXQzck5JUmFPTUZLTG9CSE9QcWMyVWpWQ3lLYVladG0r?=
 =?utf-8?B?VzRzZGNtWGwvTUs2bmFCaEJadmdndGxsWFZXckVnTE9zdXp4cnBTTUhxaEdl?=
 =?utf-8?B?ZFN6R3FPc09GVzlMQjJXV2d6UHE0M2JjSDZnR0VHcDhlVDdkeEprZlBjYThl?=
 =?utf-8?B?UmVNNDBBWHlHZlB6dThNYVYwR2hwd0tpZW5FRVhzWFl2L29OOFExTWRUbnY1?=
 =?utf-8?B?UU9rVHNVSWc4TElMZ0VUNFlCWXdOVUNJQkZHVVgvWWo3OTlNMURRbU8zUWFB?=
 =?utf-8?B?QmN0Q0l4eW5mNlpDM3hzamEvaTVBOGpYallJWmo0ZlM0cVpyYUJaY1Awd2p1?=
 =?utf-8?B?TCticnhmT1d3eERMRmdvbXdBakZtUUdqMHFuU21Vc01Ea0lXMWdUNWJaZnFp?=
 =?utf-8?B?Z0ZicWdvTXhNYmZndk5PYXp4d0p2NkNXWGVCdmdLMHJ3UFE4QXhnWEk2ZFU0?=
 =?utf-8?B?eFI2aitmcDFrMnZTWkl3TmJkd0UxOVkrS0ZOditxM2puNEUzT3JKbFlwTFBn?=
 =?utf-8?B?eE1YYVhPcGdMakZTbEZ1OHhhZ3V5M2F3dzhkbVVmK1ROeW5kWE95azNWLzU1?=
 =?utf-8?B?dVZ3TWdLeDZzWDlXV2lTSk1pQUhaRE0xMmlZSTlkeGtOL1JIQ2tPZk1YUTdz?=
 =?utf-8?B?WjNwVkJLUldwbHNPYnJXRDVmclYzRDcvLzhrdCsyem9IL0xaT0NqR0Z6VWJF?=
 =?utf-8?B?QUx3MCtaVXVnQ00yQ0tFdnhIRmYwUW9SZzY2cWorbktab2JCZkRuSTZWS1Iy?=
 =?utf-8?B?ZVZWcDBvQTRoN0hvdzU0RW9iMzF6aXhTdnVJT1h2RTNJMjFVSmc4WFZ2N2Zu?=
 =?utf-8?B?c3pLR3ZjQytYcnN2d2F0T3J6L2hGVXNXS29uaWpVSkJELytJMG9HZzZwODc0?=
 =?utf-8?B?S0ZkckdCUmdBNFlWK3lSTXhLSUFZNDFrOEZGZ0NqUWJxNmRSYk94cnF3cDkv?=
 =?utf-8?B?bGloVFNSSkxpYjMyQWdJaTlPZkFZZDVNc2ZVdzdTVGN3TGV6N05va0FPckZt?=
 =?utf-8?B?TEUrVUhHbDNjdDBycldKdHZBbnRvY29OanJnT0grc3l3citUOFZDV1JhSXhi?=
 =?utf-8?B?aTlET2xDZDhwNjkxd1p5dEo2YmVoczNEcjd3NWkySFlzdTVmT1B6M0MyaWRo?=
 =?utf-8?B?elNsL2RucmIwTzdtMnFMQXBoaU1qQlc0b0oxZWFUS1llRDE5U3ErcTZGcHBU?=
 =?utf-8?B?cktHSHBZbStXN0NzY1VMYnEvbDZVQXVUSmlvVlVBL3VITW5PL2g3TWRrcDAv?=
 =?utf-8?B?RHpHTk5xOUVoMHRUWUIvZWZDcHExNitpRlB1R1ZaVy82YVhlZVZ6VUxsZmg4?=
 =?utf-8?B?TWFwNzU2MWhkN0pGazEvd0dObzNtUFlab3RMY1l3QmJuYmtIdnBRU3B5Ukta?=
 =?utf-8?B?UkV4UzNKamVIN0J5YVZvZDUyWGluMUV3NElqcVM5MHRDNUV4d1NqSUgvQlNZ?=
 =?utf-8?B?eDBEQTArR3p3aFNnTjB3THNKR1JYSkdTY0x2UUNNc2hMUG4valhtVzdta3pL?=
 =?utf-8?B?NkZmL3VnYzBSVUNIVjEzdWxhaklDcjk2SUJjUnZnWUNxU2VvdXhPb1ZFYkVF?=
 =?utf-8?B?WXJKOGV4Y0NMd1MxbmlLd1hhQmp0SCtKemFGV2RzZXFBMUdJOVFrSGxjN1Na?=
 =?utf-8?Q?eMaMaqKFdshXDZwlbHh81/5Nfsf37aVphRtePGE1D/C8T?=
X-MS-Exchange-AntiSpam-MessageData-1: qcx/dLjluq1slw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 601f23e9-a296-4a42-b7bb-08df09b10f85
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:46:58.5669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xo1kiwUc3aNDnWe2px7kZDlzr174jqsz24h3wRQTCgK9E3LWsB92d8iVZh+8j4euOaw+3/N5r9yvnSNSYjX6/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9150

On Wed Sep 2, 2026 at 1:50 AM JST, Gary Guo wrote:
<...>
> diff --git a/rust/kernel/mem.rs b/rust/kernel/mem.rs
> new file mode 100644
> index 000000000000..958e43bbcc3a
> --- /dev/null
> +++ b/rust/kernel/mem.rs
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Basic utilities for dealing with memory, values, and types.
> +
> +use crate::prelude::*;
> +
> +/// Transmute between two types.
> +///
> +/// Use this instead of [`core::mem::transmute`] when it is known that s=
izes are identical but this
> +/// cannot be proven by the compiler.
> +///
> +/// This is equivalent to Rust's `transmute_unchecked` intrinsics.
> +///
> +/// # Safety
> +///
> +/// All safety requirements of [`core::mem::transmute`] apply, plus that=
 the size `Src` and `Dst`
> +/// must match.
> +///
> +/// # Example

nit: IIUC the convention is to always use the plural `Examples`.

> +///
> +/// This can be used when types are known to have the same size, but onl=
y at runtime.
> +/// ```no_run
> +/// # use core::any::TypeId;
> +/// fn to_u32<T: 'static>(v: T) -> Option<u32> {
> +///     if TypeId::of::<T>() !=3D TypeId::of::<u32>() {
> +///         return None;
> +///     }
> +///
> +///     // `core::mem::transmute` won't work here.
> +///     // SAFETY: We've checked that `T` is u32!
> +///     Some(unsafe { kernel::mem::transmute_unchecked(v) })
> +/// }
> +///
> +/// to_u32(1u32);

Missing closing code block here - interestingly, without it this block
triggers a "function has unnecessary safety comment" warning.

With this,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
