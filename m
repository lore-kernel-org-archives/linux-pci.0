Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA912D7BF;
	Fri, 28 Aug 2026 02:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787882847; cv=fail; b=F6hX+zZEgxSt96YTNCa6YKB7zJi+kzcbq9FzHmH6/Mr71ncYuoX/WBsNn3sUCQGuTRQhZ1Atz3TER9XW/UagfAkgCOHVhv1xh6FDhk+yYSRzkrEdMwUKQHJ9H6z3CeLw2t36PjRVxYQeeov7x5lagvhfFFrAxtLSzIoPWg+Av20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787882847; c=relaxed/simple;
	bh=sdFq1wG/EaqU1/xU0uv2XMn7kH2H6YY3cEvsDzQEkVk=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=pmxLZn+Qti/6fbrro1MYILBwI6We/MgxxGHcgvdxOhXLEmDBbIfNJP2zYE24VKC5z4zD2TAgB5ijuk7pr6AYce+UcmdJS7jPlw0MTYm7n+Nyw5l8SN4PVScgwp3DI1+Ct7KGGmT1V++SGwee7e9LL2mxD2517Ku19ExVe7vgcG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q8MdOX1+; arc=fail smtp.client-ip=52.101.46.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q8MdOX1+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqxz1mVijE260J7i1HrTlvblpNr9K6HYVP1YjamtD8ucbFmXx++PUdRDellP1CEQBl++E+OFvqnjleUrYFHm/Upm4nX0nVDtgV3fjm/Jj2taxvE7hPJmqeXOiQ5LD398Z/aHjFr+qxwqdAQ+9/ItyEPMbXW1zkCEGETzFSTuY8ATAKM83vP/EyfCio493ZQkksrIO91YkOYit5cMegtJfYpUvu3So4fZADGbSEAB8nPQXlwZkgg7MNrnnv7Pl041qbZSSuAojqKC0V5cjwp7bGupbyJJEoziNhBX52rWY5iUdWcM+AjgvLbqPiV8YVn3zR1JF4DowLNzPRoBwnB1Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h68GB38Dt6wVkTwUYtYojL329RkC412SaECLYAXfvqA=;
 b=BLu19YeZz7DsETY0NjOcBTomXzj36CMeH1cqfiWnPZ1NyvjdZWeX+ttA5B2qJgH8pPlgYQsbfBwFrI/Uflf8Umq0bzJ8vK3q6LHFy3JvwWX3w8DvkltfeFNlOd+YjHDNFc6msXg++DFz+sLFEK5E3c8InGIhoaC7NU5PwEFfOcHDABpX7Xrf/OG6+JCzE8Kf4BVK97coS8rrdk9TRGitnL6xVe05MK3s8cce7tI3rcSdGteYI3I/6I1o3K3Zuxy7+crENWAfqk6cPgKuufknA2YX3Xa4X8EEZ6IFQeZ0Op15bjxR3OYwOU2oz+GuUN9cNnUhfFgcgyHlzFMbZA0hfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h68GB38Dt6wVkTwUYtYojL329RkC412SaECLYAXfvqA=;
 b=Q8MdOX1+avDIhzEnJPfsPL9R6AWoe6P+IeGscLD5njCk119kHWsgqkslXTpw5s/ZxzCXC1Lgwc6M0l/5oYCb+28cI8A5ab0WLB5ERrq0Zti6AAhqK02llFYEHupKsyHDt3fwZDX+Mosm1bsxpXdIR1ulKioFyUfaBJNTXp9JIonlN6VoXMIY0U9pLHyMghrRUx0ILwANPMxrTIPHvyeEIjAdmP7gVzlbuJcC59djKZpOdAMyq2yjobPxQIRfsSG6nePfqrwDqDPwgChM+ZKM64dBW9Oxb52JMSydP+t56ypD0s62mUlmlTTvCnZbzC052SeaSrhiu5aCJof4zHbqPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS7PR12MB8275.namprd12.prod.outlook.com (2603:10b6:8:ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 02:07:19 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Fri, 28 Aug 2026
 02:07:19 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 11:07:17 +0900
Message-Id: <DL07KKL8OIC9.2KIJACQRZDBFG@nvidia.com>
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
Subject: Re: [PATCH v3 16/16] rust: io: register: unify handling of register
 with/without bitfields
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-16-3699a75fadf1@garyguo.net>
In-Reply-To: <20260819-typed_register-v3-16-3699a75fadf1@garyguo.net>
X-ClientProxiedBy: TYCP301CA0019.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::6) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS7PR12MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: dad262b7-e0a7-4ec9-fbd2-08df04a9172c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|10070799003|376014|7416014|1800799024|10067099003|6133799003|3023799007|22082099003|18002099003|4143699003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	9t/dwakve6iYXAN5CCbw6ykwZSOLDxUUSRhzi188Iz7L9wWK7up7Lr9ImIJNN9GwZ/TQKfGqctN9R/v3sJN5iuiOPAriOIhXblRI56ksg/1mnWbNa8tVLbusKj/IK9Ivx2osd2vPfDV79GwIxLizIu1NxS8pYt3g1MWQl9gGfOIfe41rn8pfIxi1JuJoJBVngurxqfBe0odsaHn2EIaYL1C0TsC7WWyyNUzULQbKHYKVqYHmWs3YDmTvGytkVGHTQdiAbQvCg4dJlokbMeJ82ONf59fYCvLACfuKY7fP8yHvLO8VcL+QmteR+Ppk0Cw6t1inDL+wyVS2HfhSwgYNxpe2RjKA5u4yhWakuGMtkT8pk5xs+chiTuD9UZoQhnVOBBQ53sdnjTIrquZ1O4iC4E9THWEOHAqrd9xGiI9yfXfjDoY3I0jyxVPDZyvsJZA941/EskqqGDK5GEPJ1JfOCQk8td4UAbscrI2CGMx22dEVZR0mOJ4YQUsfvTCwKD0BNDGkiiu2uTQ0/6YtuValAt17QeXxwlWYL7OD1a6fVIgLYmjFlG9HbJzDuYJDqS37tXwwjT+S5zt1MyCv7FDqciMJ97HfpiJe5yZhJnAvlYztXxwvGPqT99EHXkOZ08iJDDdXMvllO21CeGjkSGkCVwukDHiQ1GAN2K5zvIO3aS8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(10070799003)(376014)(7416014)(1800799024)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(4143699003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODgxZWZhcHZZc2ZybTR5N1ZFa2JmSnJJK1NiYUZiQ2o3SWJucjFzS1dJTkht?=
 =?utf-8?B?alQwZEpDbGo0QTZIVWxSRHFCNEpGWkZpOFdqNjhybmhRN0Jhbk9ybkppR1RE?=
 =?utf-8?B?VWxidFhCNHZlaHJDWnlwRERUbnNjaVZzRlFJS0N0VDFxZ2l1bk0yVkhjZGhy?=
 =?utf-8?B?NzhxTFBJWUYyOVhHbWtNV2hQc0Z2azRZMnE2MjZOejhUN0E5dmV5SVIyYk84?=
 =?utf-8?B?NXFKQWpDWjBDVVBuMHdvdXpHTzlmL2pYMmQ2eng4RTM4a09WOWJ4MVhwbmI1?=
 =?utf-8?B?K0ZJWGt2TzVmcmdUOG5KK0x6OVUvM1lYcWZ6YjBvNFMxK3VwaHhMSEtOU2dV?=
 =?utf-8?B?UjNLRlFrOER5a1htSWZaczVjeUVnVFVHNUNiQUVVZ2haOGlSOWMrQWVjQUFJ?=
 =?utf-8?B?OU5vNTAwZEUzWDhNL3RkcFRUWTJtMVBZeWd0SmxqTlNnMEJ1TkZpcmhUQ0Nu?=
 =?utf-8?B?dXJMSVdEeTlyL05taXlueHBLZ0habVZDemZmcGJ1b0tpRms2TzJMb2lhQVhq?=
 =?utf-8?B?clMyMDZ3VW05dUVkenVDdnVGRjdtbms1b2dIZlkwWTZvMHA2SDR2cUZNTFVB?=
 =?utf-8?B?MGVhdVoxSzNQaVZaekcycnliZDljQytFKy9SdDkwbUVLNWNOS09XaE8vMjRK?=
 =?utf-8?B?WHNXTTNKcjJJS0EzN3lUbFMxdjZmMzZkY3FYejZyRWlHbjJkdVZmdEloZ3Mw?=
 =?utf-8?B?U2ZpSWlITG1NcGNXc2pGZ0NPT3RlNzJOdkRsQlVHbU00bThuK1pLb1IvU3Ew?=
 =?utf-8?B?WitsbUtSL1l2NWpOOHRYUWhIbkllS1pFTzR4cC9iT2JMUXJKK0VOekZadDlL?=
 =?utf-8?B?S1pXL0F1TmNZU1R6bmhhazVLUFlqcE8zNzZWdnVLT09JL2J4cW1WYmdHSEZQ?=
 =?utf-8?B?NTFRdUd3UGlmVUtKMEEzMDNsQ0JIbnFlSUZtb0VEcUxzY2F3RUpJd0gwZXVB?=
 =?utf-8?B?S2VrODYzMzJJajVibFZ2MktDbDdXbHNBenUxUWpuSDROZnRpZnM2WVRLdTVp?=
 =?utf-8?B?UnlCQmpMQW4zMzRKZ2ZrMmFMbHpjdTJmM3g3cEVzcmRVRWtyZ0l6NExGQlJJ?=
 =?utf-8?B?VFh4dEdvV0ZMOFpndlMrQ3JSeUlDVXI1TzQxTnZaUkpRWHY4dEZKVkRsVFNn?=
 =?utf-8?B?NHdXUENIUHRkcVVyd1NzMTExc1BoOWpNZURVSE4vUlNaS3pxMnhzMlJEclVr?=
 =?utf-8?B?U3BoYnBSMmdUYjNUcUt5WTlGV011dGh2bTg2M0JvTm8zUzVJbnFPeE9oY1lw?=
 =?utf-8?B?OUJHRmk4RHh3aDFPR2NsZ2VveVpqZ2hpbmRsam15Yk5GdnVHU1ZjZ0E2VkJU?=
 =?utf-8?B?OUNpRkdsV0JFOUtRajc1cDFnN3lnU2xaS3ViQzcraWNiYWprMEVWT0c5UW5L?=
 =?utf-8?B?cTMrQXV1TXBaenltL3dxd2srNXZvTUpZNFlVRFhlUXoydnczenBPM05DN2pp?=
 =?utf-8?B?UUhRWGRiM2NFdVZtS3hha3RwNWc2WmlRT0QxbVUyVFVURlpML2pBTmw3aHh1?=
 =?utf-8?B?dXpsTWkyQ1B6TUZ4cUs3cEZ3M05tVWRDRXR4NVVsb1I1cVlwSHhrQlprS3Yw?=
 =?utf-8?B?Z1Y1WElTdi9XOXFyRmg1TmRGY0xteExEZWhub1o3U0E1OFQ5Z0F6L0o4MWZv?=
 =?utf-8?B?MDZCeDJsUkYwS3NaNW9selU4WE9ZdWV0Uy9reEk4TTBLYkJwd2ZNR0ZzTTlP?=
 =?utf-8?B?cUVrN3VnM3kwazNUV0hqdjZVNW1sWUNFbXpDSTB4YkdlcDByNnFqKzdGTkVJ?=
 =?utf-8?B?aGNrUkVRZUlOenROTUJETENTWDU5OHFyRVFwY1RmOVc3czVqN1h6d3Z2TEdn?=
 =?utf-8?B?TE1lazJOR2ZQaFQvYnRkWFN4amNxYS9abjFadUJzaXhTaWJzUkZyVldEdFdo?=
 =?utf-8?B?MHV1eHU5Q0JmaGhtS2RMZGpLcVV4KzNkSks0VmhXS1hqRTFQVjdnZmR6SnBX?=
 =?utf-8?B?NVNaVThsUklMVHFhNnduZ2NjSUQ1VUlLUFRtTVc2R0V5dlZQTmtEbEt4RkdO?=
 =?utf-8?B?eHpXcUdUQWJaWjR4bEhSTTFMZytwSS9zSGlSajZUM3pOQTREdE95ZHk3TmJS?=
 =?utf-8?B?Zk5NMjlSbWRZT1pxaFY2a0l6VzR1K3NNaVdVcVdUdzJmL01CNzNsYUxoQVNa?=
 =?utf-8?B?b3M5KzY0Mi9nME1aU2d1SExqblY4cDMwR2pxVFU2cXhVbi9JR2VrSFM1QXVE?=
 =?utf-8?B?dWJiQkU5UngxUE9uaktrQk44R0pqbkZuNkFHbmhsN054UUx6a2xBZktiV3N3?=
 =?utf-8?B?RFhIbXoydnZSK0N1bDN3S2tPS0g5M05ITGpXeUZiWm5wSWpEQmRDMDRqV243?=
 =?utf-8?B?amJQbXB6UEt5bThob0RrK05UUEEzOG5NOW1CVVJRWEppZ0R5dVRvYnAxNWZp?=
 =?utf-8?Q?CQT5KQMH+I4ng2P93JqleDEGBJ94+wsNrRBsExg2fGSST?=
X-MS-Exchange-AntiSpam-MessageData-1: cW5GvL6zEyPqfg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad262b7-e0a7-4ec9-fbd2-08df04a9172c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 02:07:19.6221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NdjRXgwi3W6oABTcTfT9B3zGrd+fPUmy+z2c7KHqs3McZfNVF4pUiAbY9iWJMd0KXLjEZad8BXnl41/tWa4Jsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8275

On Wed Aug 19, 2026 at 8:09 PM JST, Gary Guo wrote:
> Move the `FixedRegister` to be a property of register to become a propert=
y

s/to be/from being?

> of type. Name the new trait `FixedIoLoc` indicating if I/O location of a
> type is unique for a specific base. Thus, bitfields become just a special
> case of this (where type is unique because we're generating it in the
> register macro), and expose feature to registers without inline bitfield
> definition with the `#[unique]` attribute.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

The Sashiko findings are legit but not blocking, so:

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

<...>
> -/// Helper function for register alias implementation.
> -///
> -/// This is used to enforce base matching. Only called during const eval=
.
> -#[doc(hidden)]
> -#[inline(always)]
> -pub const fn alias_offset<Base: ?Sized, Alias: FixedRegister<Base =3D Ba=
se>>() -> usize {
> -    Alias::OFFSET
> -}
> -
>  /// Helper function for register element alias implementation.
>  ///
>  /// This is used to enforce base matching and provide bounds checking. O=
nly called during const
> @@ -419,6 +380,31 @@ pub const fn element_alias_offset<Base: ?Sized, Alia=
s: RegisterArray<Base =3D Base
>  /// }
>  /// ```
>  ///
> +/// In case there is a fixed register associated with a specific type in=
 the base, you can apply
> +/// `#[unique]` attribute which enables `write_reg` shorthand. This is a=
utomatically applied to
> +/// bitfields instantiated via the `register!` macro.

As Sashiko pointed out, let's add a sentence explaining that this is not
intended to be used on primitive types. I guess that could enable some
interesting syntax in the case of FIFO sub-regions, but generally
speaking this should be a Bad Idea.

<...>
> @@ -217,27 +230,30 @@ pub(crate) fn register(def: RegDef) -> Result<Token=
Stream> {
>          }
> =20
>          match array {
> -            None if bitfield.is_none() =3D> outputs.extend(quote!(
> -                #(#attrs)* #vis const #name: ::kernel::io::register::Off=
setLoc<#base, #ty> =3D
> -                    ::kernel::io::register::OffsetLoc::new(#offset);
> -            )),
> -
> -            _ if bitfield.is_none() =3D> Err(Error::new_spanned(
> -                ty,
> -                "defining without bitfield is not yet supported for this=
 type of register",
> -            ))?,
> -
> -            None =3D> outputs.extend(quote_spanned!(span =3D>
> -                impl ::kernel::io::register::FixedRegister for #name {
> -                    type Base =3D #base;
> -                    const OFFSET: usize =3D #offset;
> +            None =3D> {
> +                if unique {
> +                    outputs.extend(quote!(
> +                        impl ::kernel::io::register::FixedIoLoc<#base> f=
or #ty {
> +                            type Location =3D ::kernel::io::register::Of=
fsetLoc<#base, #ty>;
> +                            const LOCATION: Self::Location =3D #name;
> +                        }
> +                    ))
>                  }
> =20
> -                #(#attrs)* #vis const #name: ::kernel::io::register::Fix=
edRegisterLoc<#name> =3D
> -                    ::kernel::io::register::FixedRegisterLoc::<#name>::n=
ew();
> -            )),
> +                outputs.extend(quote_spanned!(span =3D>
> +                    #(#attrs)* #vis const #name: ::kernel::io::register:=
:OffsetLoc<#base, #ty> =3D
> +                        ::kernel::io::register::OffsetLoc::new(#offset);
> +                ));
> +            }
> =20
>              Some(def) =3D> {
> +                if !unique {
> +                    Err(Error::new_spanned(
> +                        &ty,
> +                        "defining without bitfield is not yet supported =
for this type of register",
> +                    ))?
> +                }

Sashiko's comment about the array validation bypass looks legit. IIUC
the guard also needs to test for `bitfield.is_none()`.
