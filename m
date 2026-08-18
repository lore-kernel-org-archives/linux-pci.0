Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021095.outbound.protection.outlook.com [52.101.95.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDB6390CAB;
	Tue, 18 Aug 2026 14:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064106; cv=fail; b=Sfr/2kLePdOoYbTvyEdJVr2WTMy/emYaSEerFTpar9ehnhVleASgGjWjAZrnt4rAZWrvTC8x4qxeI7NFTZ1fmwtz4+qATfdLfS1HY9ncobj/28GCZ4u72YjlIYu82Uy8Kuw/sJrroBT7+rol0XvN1qSiUkLh9sO4QbfuZP+4MZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064106; c=relaxed/simple;
	bh=4K68H40lAgEva0xj34IjbIZpTmsblR7AsU3Kk8L6JGU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=OSg+NEzv/JDHhh0w//ilk6dJ2eMVvigEFMIHWiOM1qjp/GH4oFx+O42JZnkD8lRizGCJsPc5Sd5CYkU48uzxibNflWYldbM+dE8MY2ChVh+vd99sRZeL0WS3FjDKdfvsHavWQZiY+9GOreedZZtLfDdBp+5Lv6qRFcTem8jmm20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=GXYE/u6Z; arc=fail smtp.client-ip=52.101.95.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="GXYE/u6Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxLuQQ4HxBSw2PwxJdqFxKYAun91huYzVZf23b2hQuarpQH2Ox2KFHpp8sbcP/e5qxZNE+wOOn/CaNuB4nzuDHULrMIF/wH+xJQjmWXu+TW/CIfG3Sf6Rt4r4FJDDfDZ5H7VUBgBE/OoqIYCeYRwQ66rEwPN5Ynr9TlScTjpKzDpSG/nsUBu0TQNJqDFXL/w49wefiOpJUACfPcpwKsQhHjza5lK39pVRDEv77P0OoOqwA16BFy1n+huLxozn1vr2EoCdQwzBgVTpgizF0WABJ61BPWsPQqhg1xW4A9u1xTMKTkDET3WifL7LVlw43iHz3JUtkrzITJqwEkgAcf1lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyFWeT9fmWP12YdzE16TEhHszGiKqlWXTCfNN2E5o9Y=;
 b=I7u6alGv+oHMdgQz4elhcPFfcDck2fSEoAHJplIuC6KitOSsaIw5UPndVq5fRAUtnn9qtAJH4c1Ws/mFnhbnIkHjX1PQid1QrUR6X7ktz8hCJ6LpC/rVrhQ1b14TWrP4Jbt2o4BaHyGHR+rjU6us9K9XIocujMbtD2/Nx7PSGFfAdAXtH6UBONQh65CYOjCH6124dfx5JGZczh+2kKlMXPNEJ2fd/6FUCtlNXv5ESQwOrU0V0Fe7akb7pnv6JtTN2uNqT6A70UEEPR5k3gj5MZQKqTR9am3gAknrJ3izxn3flijAcM3w9UvpQwKCYD5fRKgId89myfJodQYwwScwWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyFWeT9fmWP12YdzE16TEhHszGiKqlWXTCfNN2E5o9Y=;
 b=GXYE/u6Z8L02F8GDrpbFNaONa6oOA/SLx37S6Jm6ie1yAzPPgsmrJ1Ew07gek6m4bI+pERk7eMenhRicO7ZMkrTcLc3bdTitIxD1hhjCQe9wQd1hFiacigZBiChbCbxPj63S7E4oX92ZeU3eQ+kYGs1Q8AHPN9NM+RgnB9WOCgc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CW1P265MB8749.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 14:41:36 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 14:41:36 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 18 Aug 2026 15:41:35 +0100
Message-Id: <DKS5CNQNI0XQ.2EDHGGIQ95FHK@garyguo.net>
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
Subject: Re: [PATCH v2 02/16] rust: io: add `IoRepr` trait
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-2-c3ca142220a0@garyguo.net>
 <DKL5Q2P868GQ.29WSPCWX4HTHJ@nvidia.com>
In-Reply-To: <DKL5Q2P868GQ.29WSPCWX4HTHJ@nvidia.com>
X-ClientProxiedBy: LO4P123CA0658.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::7) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CW1P265MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d65380-66d4-4b2a-ad27-08defd36cdf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|7416014|23010399003|10067099003|56012099006|6133799003|3023799007|5023799004|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HpmCtaxd1omVfnWQRzq3L5f8hqP6AmAA5y4Ykm4ifsVbGnFBurNNiyRDt3mfoR2dWbnEEv/DkvUDI9wauGxuLg7wnGuypq0SC0SPwc3lK2RaBMV668Nlwm5hTf4+pXI0pVH6MjXtXPA1CIaf2TgaLz3e8h0ezA4XGewejapAxSC41kjBHs2FrgncNNpqj9pgoPIWOOTtc2h76DS/s2378dd8g/b+bC5pAgetQYzBBjUzB0crBdQsASJuHbufWhAOY2kklOKyk8AoV35+TcFmLzr4awkSqzUhZe8rLOyQBN611Dvy2loKpCQeHsay2xCh46qm6iq98BLZ4qrifh/qzvLkL+nCexhEihX90mSliDYII1Pk7iGqYfjyc9LX6SHGPjV3Un7yQ7JG69odKIWJ1S3MD7EV0Ge/TprJdCJnSFJFQmoo4Tbw1IIU3L352GNPdX8oHd+6g4RDsrbrk+Rz4oS0rv62R3lE5iL6C7HrfKaZ8EaYjij0JfAyMwtKxFoolnDAYfg2IAdouRMP4Ah9WwvBx2CGm5Ffi0heyaaLu1mqrbASaZIXn2w6tfu8OWPLEP8eTvJ81xWYCuUzBz9tmw7EaVe1pnnMYvr6fIdMpJEJzEhZY9oQ11YGG2jWsKOXgnLqbMvRrGuEz/cddlqUJSdWJY9ikZ+IpaXH3RmromQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(7416014)(23010399003)(10067099003)(56012099006)(6133799003)(3023799007)(5023799004)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1luemNPOHArRlFJczdidVoxa0RTb1hpTzJoZWVyUVJjeExwU010dFgxaHkz?=
 =?utf-8?B?L2FBOTlhc25lZG1mMnB3bHJ1SXcxZk54bDY5VFQ2MUFTOFE0STJLZGRPcTI4?=
 =?utf-8?B?MzV0aDczWXQydzRUMHBsNXNVWTJIcjlkditGSnlWUHR0TlZnc3g4S1Y0ZkNF?=
 =?utf-8?B?dWFPMTQzYzFZR3pKeVJyYzdrRXBpWHNIbkJTcUFBclUxNyt6VG0vUThHWHpJ?=
 =?utf-8?B?NlZtelpOeEY2WkpsVjdRcGFVTmk0emp3bmo2OTJLUUZtb21ZYWZBRHlmVVp6?=
 =?utf-8?B?MWdIa1FSVmltTk9vUDY2T2dTVG1zVExCYXRYaVozZXZaRGpmQm5DVSs2Uzlk?=
 =?utf-8?B?UDlrOTVrdDdBYzFvQ1BrOVpNeHJPRjRKMHhWc0xadmcvcForV0JuRGJrUXNp?=
 =?utf-8?B?OFJMRWJrc1NnMEtMZjg3SjMxeEk2MTk0aWxpS2RQeUtoT24xRE95aStWSGtZ?=
 =?utf-8?B?eUNZSlFEanlXV1pwYkFVaEZZL2VaYVZxQ3AxRjFjVnV1Ty9jaWg4NVBRaUdG?=
 =?utf-8?B?UjlCRnp1NWN1eDl2eGNCWkJYQ29FaWsxM3JJT1lQRWliUnUweWpHOG9tbWYz?=
 =?utf-8?B?VitKU0JLaDVTendiRHBKd095aUxpN3R5SWVjZXY1SXg1aWdPandONmsrQmlC?=
 =?utf-8?B?VW5EaVQ5U0w1TmluV0FEVnhKTC9HT1BMNVJVUXpZNG41dGxJSlM4cTFOZU1Q?=
 =?utf-8?B?SHd3UUdyaGlrMU5QVVBjRU93OXN5UTBPTGxzdmpSZnRBcWN5WUkwZk96QzhR?=
 =?utf-8?B?cDIybS9ON29TejU5QzQ4NlRyYVF1dmJBYjc4dFdpSDAvUzI0YVQ2VUkyR0sy?=
 =?utf-8?B?Z01jYlhGV21lZ0pxemcvQXBYa212VUdUTGNLQjRXY0FHNitGV0FveElrK2pl?=
 =?utf-8?B?dm9nZzFJOVlyNGt5MHpXaTRzTktjbEZDdmdvTi90b21iaHZJZ1hjQWFGWjJD?=
 =?utf-8?B?YXFKUUoySGZrNVBrWUphaGxPU3lCWVFDRnB0UmtJaVFjL21jZzBqZmFCWnRr?=
 =?utf-8?B?b1FNaytVRXE2ZGhFVjBJb09pNCtpeGh1TmFYT3JzOW1qR3FEQW55b2Y0ZnAy?=
 =?utf-8?B?OVNaZGJoWFZFbjFqSTd6bGs0dGZNNmhZRk5jRXJzVnlSVGU3RUowWE5BcGtC?=
 =?utf-8?B?ZXF5RWFTdW1SSThVNFhmeHBabGYyWnIrcUlkY1RTeWZBblFvcXlCNWU2VGFl?=
 =?utf-8?B?eU55ZFJFeFVmV0NXdlQ5Q1BCRitkdDk5OFVJM1M2cWl3d0g5RFNMcWZ3a09L?=
 =?utf-8?B?OWdHUlN3eUNPY1Voa0tlRGYxeFV0ZXNocStCbVBrQ1QwRHFuNGEvczFDN2VM?=
 =?utf-8?B?QzZzTGsxMjV1S0lhTDRYSklkNHlCazN4ZlFOUUVUNE5GT1lOcDdDRTM3c0s4?=
 =?utf-8?B?QTFjTmNIUU1IVk90KzR5SjhiZ094d1g0eHhGdXBuNWxpZWFqbEFjSEh5RTNB?=
 =?utf-8?B?bjNMM2FRbVVTU0hRd00zc04vR1JZUnNub1JWdVA0ajd5cFVXd0swdU5qeW1E?=
 =?utf-8?B?L3FrWkVaVUtRbURmdUhSbUhRWDkrVGROQmlEN3p2eUg3Q0V1RFJkRHFCSCtE?=
 =?utf-8?B?MWVkZUhwQlNIaVQ4R3lydm5rZzFvQzlPWGtuOVd6TWpNMXhOeWt4K0RuM3oz?=
 =?utf-8?B?cXBmTnNmVWpiOEFham55WWhpT0VvTHlsancvMXFFN2htN1BXRjFkYVJWY25y?=
 =?utf-8?B?eGh3NlcrYjBoTGlaUUYrQ0w2ZjFKckM4OUIwaTdvK09oTlRsdG8za2lQOWhw?=
 =?utf-8?B?KzhHSUlBd3I2MDJWakFFZ1FRZWZrR0NiQkQxaVNFbkpXTFFyaTNLTFYzcnJq?=
 =?utf-8?B?YmszUW4yQWVRS0RPVkV3MjJiYklMbFk0RDVaRkJMUGVQdW5yc1hYQlIrZmNU?=
 =?utf-8?B?Z2JaOVBuMEFuTzRSbXc0RUVoT1dQK3JLZE5yZVJUbHVvT3MvZ1lCUFlib0Jt?=
 =?utf-8?B?aW5MaHg3RWZDTk5nRXhORVVleEdpSExOM3hXQktSVU5xZjlnQnFBQlpwWS9X?=
 =?utf-8?B?blpuNll1d09mcjRrRDA0UWNVL1FwclVybnJZMTd5MXY4OVFDRFAvaCtEWlFH?=
 =?utf-8?B?Zm1yZTRqQ1ZoRVJ2UER6aFhjWGN0bGN3UU5aSnMrNDNHZlFLa2c5alEvdFph?=
 =?utf-8?B?WkZKTXliU3VHWndUTmZjSHViZkhLZ0JvMENLT2x6MlhMWVhqeUIwUHh5dHdv?=
 =?utf-8?B?VzNINjhCZmw1OGZVTDg4RjB0TWs1WjlUOW9LOXc4bmN4NVFyblkxY3Q4TnZM?=
 =?utf-8?B?aDFCK3NDOXFKS2JJa1RYekZWY3hkZlBmTDlabXJ0OGRJSnJpNm1kbmtGWUlU?=
 =?utf-8?B?TnBkcHl5NHRmRmZFU1c0SHZubEQyejFUaWx4K1lWUEJTcDFkTjk0Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d65380-66d4-4b2a-ad27-08defd36cdf6
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 14:41:35.9829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40/BU4Yi8ef2lvwVIOoCjlicVN/zMdKfBGjbp83YkNkpw6ehUPrUXrNNgP54wV6wwnXzthtS8AjsNkqVPNwhyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB8749

On Mon Aug 10, 2026 at 10:30 AM BST, Alexandre Courbot wrote:
> On Thu Aug 6, 2026 at 1:35 AM JST, Gary Guo wrote:
>> +/// Trait indicating the underlying primitive types to be used for I/O =
operations.
>> +///
>> +/// Implementing trait allows arbitrary types to be used for I/O operat=
ions, not just raw
>> +/// primitives.
>> +///
>> +/// The layout of the type and the underlying primitive must match; thi=
s is enforced via const
>> +/// assertions when I/O methods are used, as the type system cannot rep=
resent this.
>> +/// [`IoRepr::from_repr`] and [`IoRepr::into_expr`] can be overridden f=
or conversions, however it
>> +/// should be noted that they are only invoked on value read/write oper=
ations and are not invoked
>> +/// on byte operations such as [`Io::copy_read`].
>> +///
>> +/// # Examples
>> +///
>> +/// ```
>> +/// # use kernel::io::*;
>> +/// #[repr(transparent)]
>> +/// #[derive(FromBytes, IntoBytes)]
>> +/// pub struct MyNewType(u32);
>> +///
>> +/// impl IoRepr for MyNewType {
>> +///     type Repr =3D u32;
>> +/// }
>> +///
>> +/// #[repr(C)]
>> +/// pub struct MyStruct {
>> +///     raw: u32,
>> +///     new_type: MyNewType,
>> +/// }
>> +///
>> +/// # fn test(mmio: Mmio<'_, MyStruct>) {
>> +/// // let mmio: Mmio<'_, MyStruct>;
>> +/// let val: u32 =3D io_read!(mmio, .raw); // Raw primitive read
>> +/// io_write!(mmio, .raw, val);          // Raw primitve write
>> +/// let val: MyNewType =3D io_read!(mmio, .new_type); // Read via `IoRe=
pr`.
>> +/// io_write!(mmio, .new_type, val);                // Write via `IoRep=
r`.
>> +/// # }
>> +/// ```
>> +pub trait IoRepr: FromBytes + IntoBytes + Sized {
>> +    /// The backing I/O capable type.
>> +    type Repr: FromBytes + IntoBytes;
>> +
>> +    /// Convert from [`IoRepr::Repr`] to `Self`.
>> +    #[inline(always)]
>> +    fn from_repr(repr: Self::Repr) -> Self {
>> +        transmute_neo(repr)
>> +    }
>> +
>> +    /// Convert from `Self` to [`IoRepr::Repr`].
>> +    #[inline(always)]
>> +    fn into_repr(this: Self) -> Self::Repr {
>> +        transmute_neo(this)
>> +    }
>> +}
>> +
>> +macro_rules! impl_io_repr {
>> +    ($($ty:ty =3D> $backing:ty,)*) =3D> {
>> +        $(impl IoRepr for $ty {
>> +            type Repr =3D $backing;
>> +        })*
>> +    };
>> +}
>> +
>> +impl_io_repr! {
>> +    u8 =3D> u8,
>> +    u16 =3D> u16,
>> +    u32 =3D> u32,
>> +    u64 =3D> u64,
>> +    i8 =3D> u8,
>> +    i16 =3D> u16,
>> +    i32 =3D> u32,
>> +    i64 =3D> u64,
>> +}
>
> ... and `IoRepr` and its implementations for primitive types should also
> be part of `transmute` IMHO (after being renamed to e.g. `Repr`), for
> there is nothing I/O exclusive to it. It just indicates that one type
> can be represented by another, a property that is again useful outside
> of I/O.
>
> That way `bitfield` gets a dependency on `transmute` rather than `io`,
> which doesn't break layering.
>
> In order to avoid `Repr::Repr` we can also rename the associated type to
> `Raw` and update the method names accordingly to `from_raw`/`into_raw` -
> which would have allowed us to remove the `bitfield` methods of the same
> name if they weren't needed in const context! But at least it makes
> things align nicely.

So I am working on this design for `kernel::mem`:

    pub const unsafe fn transmute_neo_unchecked<Src, Dst>(val: Src) -> Dst =
{ ... }
    pub const fn transmute_neo<Src: IntoBytes, Dst: FromBytes>(val: Src) ->=
 Dst { ... }

    // Round-trip transmutable.
    pub unsafe trait AsRepr: Sized {
        /// Primitive representation of this type.
        type Repr;

        unsafe fn from_repr_unchecked(repr: Self::Repr) -> Self { ... }
        fn into_repr(this: Self) -> Self::Repr { ... }

        // Name from conceptually having this (not actually added)
        // fn as_repr(this: &Self) -> &Self::Repr { ... }
    }

    // Bi-directional transmutable.
    pub unsafe trait AsReprMut: AsRepr {
        fn from_repr(repr: Self::Repr) -> Self { ... }

        // Name from conceptually having this (not actually added)
        // fn as_repr_mut(this: &mut Self) -> &mut Self::Repr { ... }
    }

This design works well with both `Atomic` and `Io`: atomic can use
`T: AsRepr<Repr: AtomicImpl>` while I/O can use
`T: AsReprMut<Repr>, IO: IoCapable<<T as AsReprMut>::Repr>`.

One thing that I ran into is with signed/unsignedness of repr. Say for exam=
ple
you have

    #[repr(i8)]
    enum Foo {
        ...
    }

Then it'd be more natural to have

    type Repr =3D i8;

Similarly if user specified u8, then we would naturally want to put u8 ther=
e.

However, to avoid duplicating signed/unsignedness code, `Atomic` and `Io` w=
ould
need to pick a preferred signedness. So far, `Atomic` uses signed integers,
while `Io` uses unsigned integers.

Would it make sense to canonicalize everything to unsigned integers (even i=
f
users explicitly specify signed integer) for this trait, and convert `Atomi=
c` to
use unsigned types as impl (we can always cast sign back in the impl before
calling C)?

Best,
Gary
