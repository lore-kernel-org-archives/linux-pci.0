Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011016.outbound.protection.outlook.com [52.101.52.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCEA4908B5;
	Thu,  3 Sep 2026 12:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436965; cv=fail; b=KHujPxe9QMLS3hMH2ZLj2+rj0XZ4mQekrLQ+T+tw31KZ8mtPXQABNPfqFXwVHH1gTvsAHN8dXnoKCQlkG5kvDHfu6KiVn71Wf985HCBeL3aragBdoW0iNY4kk0Kxu+VUekRYPxtiWYsu8H9PG9kN6DOFVyRDDjNYdAEhy6L6csA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436965; c=relaxed/simple;
	bh=GTCAKHhmV4uiUXcooCmdvo1kWT1uJnoxfFlCVC1H0eI=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=KSS+1Exi11TA/L1A9PDKBH6AgO9xbD7c9+zuKYLsNuVLcUYRmpofcvqLNwXcNWlJaKlj3z5yMYKUalVUbEpiCegLe0jd0qlB4+4DGC3+WoGz9aOBg93cF9X87PAxF9tHQTPnFIAoih2Ky5d4brHyGeGibmVBeYlyT0btTuQV5+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QL2SYJqz; arc=fail smtp.client-ip=52.101.52.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QL2SYJqz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YryKrJgNuSlaqLoMbHrMCCftPZYs6l1RTMipnjjrNdIyRgAJzTeSCMzLi9PLqU8pZI625frnmFnXfByobEza+rRMFePpBLAZCVFneycHkZlKmU3+nEgf4zoFL/3hjS44kCG/kwXgr0i9jOCOON2oKQt76Dbukli5CQjE9jGwYmTlyWfwRbEXb5+FarVCMwkWUsiP24u/agsO5UsXl02Pqmvr/GBep3mOpYupDOPQn1r6gA2A0hJy9kLflyLOglUhz3U3njWSHv7HAQyuaGhy+XwahKWnWSf9u1Z9GOeOdPC9Rh1TZrUiXrhmUBxETJBTlqwpjLOm110XbhVJl6An1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jx7D1ZtXmbms/VaIzaX6EzVBmfkbKpHkWCIFaQWHz+8=;
 b=zOJLkutMZQW8dplQxRrjzwhnj1x7AoHyICDSL2Udva3m1OUqNT2SJcR8LMOYtC8seITfE5t8Qe95jfAWe2EczW83otRVYUZSpO+a3kUxo7XRge5Y6E9YnF2VWJ9KKRroTRsEB+wSTzgSHnjVaYWbuEz7S+gvo3sf82iDa0Igo0cjoDSzQDSGQh2sQPqkMgEMq9wJLdusNebsaXynjcnCHCuawTTd/iVqCGhdhJw2PNecWjmZHrQsIYxM7ZuF2nywTJ/L3mnsBgRCG3KfNtMvGKgt3IUI5TmHBJpjC6keZyO1rhaRy+Dw7Wxvg3gyOv9Gwnqgx77m/tsScYT2ZI4G4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jx7D1ZtXmbms/VaIzaX6EzVBmfkbKpHkWCIFaQWHz+8=;
 b=QL2SYJqz7BfuHFskGvJJ61GFLKAu/NRll0+xftCVzY8KqOR7KHROqH7JJ4qZeIcSzgZTFhTBHNPIBBRp9o1E2UdUDoIp2HiE8u9PcdHuarwJPaLWV4FM9G7bK0QuquVZpeWS+CjArVmLT9FwcnsQfMGBKP4+ILPB/hZf9Xufh86EcVF1elF9BsXBZjHZJIBwoudtrjbaBNtprRpXoJX1cX0FpyADDWqUTZmLm4jOy4ESZcRydXgeW6ZAFuP1+xAUJYNqT7HlErp+QhF/bWLxXMMZeP9PD0gPzcW5j+JO0Kmcz0cDnCNjq/QDuRcuAdmvlM1YgQCMWX3Br+v/+86uaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SN7PR12MB7024.namprd12.prod.outlook.com (2603:10b6:806:26e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Thu, 3 Sep
 2026 12:02:38 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 12:02:37 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Sep 2026 21:02:34 +0900
Message-Id: <DL5NZMOMIBDR.1EWZB3BBD7F0F@nvidia.com>
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
Subject: Re: [PATCH v4 03/16] rust: mem: add `AsRepr` and `AsReprMut`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-3-5552b1d59525@garyguo.net>
In-Reply-To: <20260901-typed_register-v4-3-5552b1d59525@garyguo.net>
X-ClientProxiedBy: TYCP286CA0305.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::16) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SN7PR12MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bb75dc1-ce9e-42a6-9146-08df09b33f25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|10070799003|6133799003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gqdVRmh5sydvVd3PE2RfrWp29tseAXybolZrwk0Wiw1Br9iszRvNOq3HkZ/m4Ffp3e6bfvcw4WqjiSLstskj17Fc8Z4ZCSXlLfJ/iMm0uGwLQ4w5fdyM1ypN0f3kKmPA4vkQhaZNKuplhcj0qvxnt3PYpwb3iFSa7RrkYawaHWDbIUgYwUUsAjfIbCc56QBco0O8y3GWFPk+fSNzqn/6jjGcHBMaTz+zm8hkd9tZTfsUq1DYCn//Y4sYGE2lUdzzAsu2h6PctpJhLfDl1oyWynd+d9IhDAXdgK5nkcFECuolY84FpQO4ag1OTEnhJnjJ3IdNf7CUTE7627D/iYIascTu2gxgW3ANH10tD0y5yv/pX/vV2nASOogLha3lu12EnKRwsnQzf6naZp8rkbTGahfi1EekB9rosEA5GGSG/6OZz+rcdEBl+uXPHBt7UwmHTvAyDX9j4irQX7C0uG+EmNsZXbV3GmUMGOODXUg6cAQya9yJWDnTWNeMKrwXQi3bZBPcHImlojapeqhYLh4wb7ng001fwD4ebQWCK2pzQakbKIjhOhfzCJoX8xbzl7MoaBNE/2HsM22iyqKZBqks/cCn/8fbNvlXozWRIobVluYOLotyKT8zOD+JtHpDUbxK2qEhiyKjwDX3APVLCO582XWFDfPCUE2eA5E7GxtMLTA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(10070799003)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEJkY1p1b09vM0w4RmZ3MTByTlE4Rkh0bEZscUVna0RXbzhxaHRmcXQrRDZF?=
 =?utf-8?B?ZC9hRnRrK25pWlA3RGd3U2tUc2lETWMrY1pIWnFLU2ZqNEt6dFdwYzBKUlhn?=
 =?utf-8?B?K3I4ZEIwdTFRcEoydm1xQk9oVE4xMk5GWmxtTjlYU3lOY0dDR2NzeGlnQ2VU?=
 =?utf-8?B?UHFxYUFhOURsLy94L0t0aFZjWXhmeDlCYnJJdXNWbGdNS1NLVWgvSmt4anpB?=
 =?utf-8?B?ampkMytJRVJuN2pGRDJFMy9tRFJvOGZMYkRxN2krNGk4eEhaRGRyTndBclZn?=
 =?utf-8?B?czd5Z2F4U05rS0YxeXp4OFo5U3Q3SjlGbU1CWVJPaEhXSUhWb0g3NWtMMlMz?=
 =?utf-8?B?NnErZEJKbDFMK1Q0azNVaWI0UFZyQUZWSHpicVdaUnd4NmMzY1BIcW5lQXdo?=
 =?utf-8?B?aXNtNXV5S0w1UlZJSkYwSFVkUEJxOTByWHhCUFRzcXFTOHd1aGZJUTdUVSt4?=
 =?utf-8?B?Znh0cmFmanN1bzNseWlYU2xjWGJieWdVb2NZRUUyQy84Qms3elMxazBqQVdK?=
 =?utf-8?B?RFRaZ21PcmNmemxOU0k2YnRCUXYvS25FbnVyVkpsUmNVblBrdHhiRXU0MWhy?=
 =?utf-8?B?STVoVS9TNGJWekFoQVZZTS9kUlVkQlNNVmw1eFZTMUhjTFlnblE1cUFFeStH?=
 =?utf-8?B?bHJoZ3JCS1VVOExpNnlDeXRNcUdIV0hPdTdrN3p6NWV4ckRLN0dRQVNjd3Z2?=
 =?utf-8?B?aVBHZGg2bHFBdUFwdmI3bGNrM1ZhUm13SmEvcHZlWGN0bkNIRmZpMTVieXZs?=
 =?utf-8?B?ejVYYVA0NVl4ZUYrenRKU3d0WWlNOUJnSms1M2xXZzNjZ2xlb3ljdk9taUpn?=
 =?utf-8?B?ZnowYzkvUWdSQWJsdnZvRE84RERBVm5WdWhMYVNjOFRwcTBlaGlNcjdTTHRK?=
 =?utf-8?B?N3ZWd3pEeE9udGRyZk5CektDcjNBZS9sRlltRUVWZFY4NmtpSU16aFNtRnNL?=
 =?utf-8?B?b2JKWVlad2dPbGYzQVhLbWcrMUVQaDMycTlZVTl5WFMvZnhqeTAxQnVYSzRM?=
 =?utf-8?B?T2RxRXVaYlNtbVZvbmx0cnYvb0lsbEJqdlNEUHJNQ0RoVmc2NTNEbW5vMVNL?=
 =?utf-8?B?UzkzWEp4MzdoUlZPNmtRTEFJdkdWSHdoWis5a0lzR0NaNGRjZHdXMEdIYXJC?=
 =?utf-8?B?Y0o1RlJpaUJrWWlPM29DSzROcnhxalRKOHhuZ1R1RURSVW8yZ1laWmRWM2JY?=
 =?utf-8?B?akw5RE1SdktUNStxcmQwMktDeXM4b0Z3MHYvVml3TmkvMzBYSDdxRExWWXo1?=
 =?utf-8?B?WGRXYjJFMDlRc01EWlY3U1l1QWFWRnFmVDdOVmUrbG5NcURvRmc1cjhoMlc1?=
 =?utf-8?B?cWwzbWlvUkpvWmN4WllHajE0SE9mOGg1N2JUSWtDWUt4eXZkb2xndWJiVC9E?=
 =?utf-8?B?aW9YZnRWU3FOd0VWaDNEZEs1elQ1RkhjUm5IbWxIbE5sTVlqbFR6SFRCbjNh?=
 =?utf-8?B?M1l4NElDZHFLSHVQVm9XUE1nbXNWSE9ONW9yTURxaC9mb3F1VkYwaGtIN2xp?=
 =?utf-8?B?V0FQWHk4RjVXeDJPSDl0VGppdWZGRUZTU2dHNGdqemFXdUtsWEZvbXJpK1gx?=
 =?utf-8?B?M0ZoSmc0QXp6MC9LYjVMaFRKUzFsdjNKQmZNWmxnSWIwYlpkVHV2RFJWM1lq?=
 =?utf-8?B?cyt6ak9CNkRGN0dvenVJU0hQU083Z29qWXduRHdJT0Rzd2NUWnkranpLUjBB?=
 =?utf-8?B?TlNOeFZaUHdMeDcrUWVRQytxRmhYbk4rUjQ4YTcxbXgwR1doVng0VjE1cTN1?=
 =?utf-8?B?TmlPTjJZT1pEKzRtUEl6R1RJc01sNWN4UUwyZHJhNVBHNk9xU1U5b1V2SkFO?=
 =?utf-8?B?aU1MVm1ITE80WWJsOU1iTk1yV3VjdjVtRkI2aTExaUFQRlVKbHFzQVppUjlp?=
 =?utf-8?B?azViMS8wMThSN0g1WjBSKzVEdTZIdTVhdHUvT3FMWWg1Y0JuRHBNTnc2ZlRC?=
 =?utf-8?B?TEFjVHRuKzhXTko2R1hFUDhySFJGOXZTT0xZaVF3S0N6clVXMVllVS96My9P?=
 =?utf-8?B?YS8yS0V4aHc3bW1DODRnaTc0U3pxNm5tSlRPekRZdFpjSDQ4N3FCaFM1MEhB?=
 =?utf-8?B?S3VhZ1lidElLMm0vSDRQTFBoeXg0ZnhndFlxZENOQXdyYk84eUw1a0o2T3E5?=
 =?utf-8?B?VGVtZko4MldDNlBqd0FVaFF0dU5DOThsQTIxNmZ0WnBqTE9scWIrSnBZWmlr?=
 =?utf-8?B?MU1WNk0vUDJFeWQ1c2djTkZ3R1BteGErdDBjakpGRjkrMHN2eC9TNUV2TjVu?=
 =?utf-8?B?eXlLZHk3ZWZnUm5WTSs0K1o4NVdNSWptdzJPa1J4SXFNc3lHTHZqMmx5b1Qw?=
 =?utf-8?B?MWtTaG03U1luRWU1TnVyRTFXWTl3NVhMSlNkR1U4RDBzMUZuODd4YVBHaytO?=
 =?utf-8?Q?oTbq8EHLbf0v3h7nE+uxIxpU0vHcot0dC37o8Hnw3pkZ5?=
X-MS-Exchange-AntiSpam-MessageData-1: UfHS/1DEYE+NHQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb75dc1-ce9e-42a6-9146-08df09b33f25
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 12:02:37.4181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5GpK4tQZ8qS25WPzEcZl92e0KzJ1rxs7ooySKSD4VwWKth/kMbSh1iCUBOfd2kxt7l0OB3f5G7YYKjMjfA0wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7024

On Wed Sep 2, 2026 at 1:50 AM JST, Gary Guo wrote:
<...>
> +/// Type that is layout-compatible with a primitive representation.
> +///
> +/// # Safety
> +///
> +/// - `Self` must have the same size and alignment as [`Self::Repr`].
> +/// - `Self` can be [transmutable] to [`Self::Repr`].
> +/// - Neither `Self` nor [`Self::Repr`] contains interior mutability.
> +///
> +/// The above basically says that `&Self` can be transmuted to `&Self::R=
epr`.
> +///
> +/// [transmutable]: core::mem::transmute
> +pub unsafe trait AsRepr: Sized {
> +    /// Primitive representation of this type.
> +    type Repr;
> +
> +    /// Convert from `&Self` to [`&Self::Repr`](AsRepr::Repr).
> +    #[inline(always)]
> +    fn as_repr(this: &Self) -> &Self::Repr {
> +        // SAFETY: Per safety requirement of the trait.
> +        unsafe { core::mem::transmute(this) }
> +    }
> +
> +    /// Convert from `Self` to [`Self::Repr`].
> +    #[inline(always)]
> +    fn into_repr(this: Self) -> Self::Repr {
> +        // SAFETY: Per safety requirement of the trait.
> +        unsafe { transmute(this) }
> +    }
> +
> +    /// Convert from [`Self::Repr`] to `Self`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `repr` must be a valid bit pattern of `Self` and satisfy type-sp=
ecific invariants of it.
> +    ///
> +    /// Alternatively, if `repr` is previously obtained using [`Self::in=
to_repr`], and each
> +    /// `from_repr_unchecked` should corresponds to a unique `into_repr`=
 call, then it is safe to

nit: s/corresponds/correspond

> +    /// call as well (this means that we're undoing a `into_repr` call g=
etting the exact bytes
> +    /// back).
> +    ///
> +    /// This method makes no guarantee if a `into_repr` corresponds to m=
ultiple
> +    /// `from_repr_unchecked` (i.e. copies are made), to allow for cases=
 where `Repr` is a pointer

This part doesn't parse for me; maybe it is worth rephrasing?

Something like "No guarantee is made if the result of a `into_repr` is
passed to multiple `from_repr_unchecked`" reads a bit better IMHO.

<...>
> +// SAFETY: `*mut T` has the same size and alignment with `*const c_void`=
, and thus `*mut T` is
> +// transmutable to `*const c_void`. Neither types contain interior mutab=
ility.
> +unsafe impl<T> AsRepr for *mut T {
> +    type Repr =3D *const c_void;
> +}
> +
> +// SAFETY: `*mut T` is transmutable from `*const c_void`.
> +unsafe impl<T> AsReprMut for *mut T {}
> +
> +// SAFETY: `*const T` has the same size and alignment with `*const c_voi=
d`, and is transmutable to
> +// `*const c_void`. Neither types contain interior mutability.
> +unsafe impl<T> AsRepr for *const T {
> +    type Repr =3D *const c_void;
> +}
> +
> +// SAFETY: `*const T` is transmutable from `*const c_void`.
> +unsafe impl<T> AsReprMut for *const T {}

These pointer impls have no user in the series, should we wait until we
have one to add them?

In any case,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
