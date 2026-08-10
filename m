Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022078.outbound.protection.outlook.com [52.101.101.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7A63BD228;
	Mon, 10 Aug 2026 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786360905; cv=fail; b=OiLkvQd46Yt1ZH6kbCTwrrKtnSlRnjsWQl0VtlULrqsXBAjF+ThnJXlR4inmObzTe/czG02lj5gsNTmEZhyZzhOj0rfPByri/2LDfJoAJzJo2JRkat825swxinYr1oEM2Dgj9j8RyenmDXgwR9efvTFyAYFzwKD2W/68WboD6Ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786360905; c=relaxed/simple;
	bh=Tngc5GrMxDtJPOkZtuEvzBIM2/i9eskjdQOp9IL003k=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=gUDR81bIUokN3vhgo0oZD6uVtk3qGLheYUXvHRK8Iho8k9K7vCQli308VhUwjKB335xWN/rX6tmsjalti0owBXS0vidWhEzKNB+rtwVenye982fX9J5nPALpq32Mzi1LXDFG/EtPkJ9/xN8aTGQg5iAHGVzMj+tbfsK3MoAotmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Cttdo2sT; arc=fail smtp.client-ip=52.101.101.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Cttdo2sT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Off2ILzdTIrNBpsW8B86VbBSqcKwlTHEl7phueu5JBPkw72QUB4Uzsrj66v4JlFw8tnK/N4S8KaK+CK+w13mBaCfd7QrAusA3zsVmCOQII70NV6FLyN5QzJnKTg9mbu6c0cnmAkzU1xv8IbKQcw/cnzOpNY9HQ4q7UNOmRbmIOZ23epxTtc179xjXM7MezIdKN36UxuspbM4K1RcxZMnJijywgM15KHznABY0NauMXCvF2IDPqj9x2bYQhw5tF1TuxWEsbBJhrAhyTy+mfzdhbv4fbrdfCNVK0CzxRIrCvZMVgNju8kXMVUq3P4wTaMbXyRCnYqF4YXHlvaBZmDcgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dt0/8c5S3U5GQtrTBhUZp6Emr5f92yZPhPC+zVxfY3I=;
 b=ZHpLvC1QM2ZK40C6/5skVZjEJuLKluNNR6SAQHxcLAhBd5y8tBnBYFw45xAWUwkSQb/R3QX7WkSb2/uN0Jvw7eb78HpJ/sfCwO6BA0nMDZhOWsGwuZ4SpPlNfHV463/G0aiydWFjtPXQwQViz0X1R40w7Pz/uxJXy0MMpje6BJaH8Q5EUesP/CAQxFKO9NI2ayJJ7NFJeCz7m9j+Osgm4nZRNhHViw8dJHeZgAXCmXnPLK5nuuxyhZucsweKi82eV+2SaoUsc/f/d2tKYZVuXrCyuvLugTmXiaYnv5j3BvAuRRCMNc5KSND1MQIsPqbqBlJCHurtf0remR1tFlCA+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dt0/8c5S3U5GQtrTBhUZp6Emr5f92yZPhPC+zVxfY3I=;
 b=Cttdo2sTTaXo7THyJIfiaHeyUxwQptofx1tesSk6QA5DuAYrOu6svvIZ1oXxpnr7jSzlUHVqnlCJKsqyCVzU8q1z8gqNQi0M4SkipjzRrN0rZqztARbezhkDbbCHrqn2cT1LufNvPGjkk0GnYGm6SGz9UDwVt8J+YBbUyNix7Eo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO8P265MB7485.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3b5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 11:21:39 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 11:21:39 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Aug 2026 12:21:38 +0100
Message-Id: <DKL837PVU38R.3OONERSO8RMOW@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
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
X-Mailer: aerc 0.21.0
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-2-c3ca142220a0@garyguo.net>
 <DKL5Q2P868GQ.29WSPCWX4HTHJ@nvidia.com>
In-Reply-To: <DKL5Q2P868GQ.29WSPCWX4HTHJ@nvidia.com>
X-ClientProxiedBy: LO4P302CA0030.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::16) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO8P265MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: 924a46ae-14ab-45d5-427d-08def6d18c1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|10070799003|6133799003|4143699003|5023799004|56012099006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	x8e+mAErGsQDeX5bVPpsyrzArXP9vtt1xLfsuW89onBo/vLDjicbKQJsa4/8P3LfQfrxTFFRCdevcyncDNiyDAOMQQUKAQf0z4Ak/YsShFxNwx5XUmPtt/CbjdClRQ1ecwgdfzO/OxfCqQYUNQQHC5S3K5tStnP6iq9YjXiz9kYAdVBSK8k7g8SAWdkRP7JIeT/DM6BkAImhD5fGR2Hv5tPpXYtwJFxKJj+G56D4dipJ/Vf+BPcWAx5rzEkk0a5NsidOHWhR8EtJTme0OLoFNQ9cUEut8Vc/rqqhFgvUHmI51n1kjF3XEcQhB8suiYRxqQFxU00ZU0ZoudengHXor7t0S41VXDloaQC9YIBJpDbdNLnBa0ycGDRCf2sT0BbZeofS4mawgY6owNC8f7S5bLAFp+QxJLAphQgSdjR/79lpFUvpyQD84lMFK5QdxcOoDC2t7tXu9h5DYKTP/qzjd56+Xn0FzIU+3ANq+cHXd6Cj8KsFXvff9K4y0dzc/r1GItqtU8bpuTHGAFU50PaUbo/bzaHfGkwWMZjsCKjjGb2gjKWG3X9aTYy2HHyk0vlnw00CZvdzUVkFN3i5TbLGVMVK9BeDbSfQjHvwngjCHo8gDy0l5c98RtSOxEkkSIy/wlOYnKuO6FNFUCG2HPf/iwyEhtt5Z3XIbN4ijy80cOY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(10070799003)(6133799003)(4143699003)(5023799004)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WE9JOVhwQTZUVmdKZTdlenRnVVZDRVMyTVg0YzJOVnA3N0l6WDZidFl2eXBy?=
 =?utf-8?B?elJHZ3FuNVJRZmVWK0M1dVB3K1NTdERseHh6OERLR1VaUnFnQWEyYzdRaURj?=
 =?utf-8?B?c280SGx6UDJUdEs3dm1EdSs0ZVF1N3hLcURBWW5hVWFJOXRRM05NaUlxamV1?=
 =?utf-8?B?WGlsN1ZWME1BcU5ERDRBQktzYkhmd2VxcTZuMU1zc09lanZjemdEMC9menJT?=
 =?utf-8?B?MWRzRHRiWTA3UnVZQVpLZGEyNm12VkQ4akF4NmJTRnM0L21Kc2NHSFREUWVL?=
 =?utf-8?B?MGFMZkhqWDZ4MU51UUduemdkTHg4MGkyaEk2ZkVHOHZmeDdxNXV6aitzdWpk?=
 =?utf-8?B?OGtkVmJLUW95RGpmR3J0VDVFL1FIRlZYV2RZZDhFMERIWGpaOThyOWxMUnZE?=
 =?utf-8?B?RVZXVjFyWm9FdnZTNXdrd2R0UFBXWnlIZW4wdGFHM1kwcXREazZNeVlRTDRq?=
 =?utf-8?B?b0xmdW5WaWh6Sk12U2JIMGl0RURGUlVRVERiUzREVnpmNVgvMTVud3FSNmMy?=
 =?utf-8?B?dEhHeW1NMU9ZbHhUUk5LQ3QvR0gvN1FqS2M1R3ZwK253SlpUcUdOY2szK0Mx?=
 =?utf-8?B?T0dhM2p3Y1hiWGo2aGQ1dGdsUnpnaCtSS01sOE1ydFNTS0ozZERQck1BaU1Q?=
 =?utf-8?B?dDNkK3p0L0I5M2pVZkJQaitOVjRyRDBKdEFWTlM1ZklKZ0VuRllrVUI2UDMv?=
 =?utf-8?B?VTRFcTZYSGFrSVEwZHhIWFYzVFhoVkRwWlNaU0tvWjErMVZGcUJPQzZSNDRk?=
 =?utf-8?B?aWhFcmhZaEZZV2x0TFhXbWVXa2lGZE4zcTF2V1FxV3N1MCtqOTVTYW1LZThj?=
 =?utf-8?B?VysxNUdhYjNQclk1WW1SaHd2TE1HUFNpUktkajlVdmZ2RCtYdkVLekVvSHRj?=
 =?utf-8?B?b0UwWThsSkdEVTFxemM3cVF3aHFrNWRtaEhPeDRHdytVcC9vdmxDUWhkaGU5?=
 =?utf-8?B?VVE2Wk0yb1NMdkRoZ2UwM1N4enRCS2wyNmFPOWIyUWNPY0RjZTl6YmRTbDJj?=
 =?utf-8?B?MzFQcmdLVkxiOGFVL2VlZFVKTWNjMWdaRm5vWWN2NTBocEE2alljSXZmeDdi?=
 =?utf-8?B?RkJPM2tYWFdMempsbGVJSHByaFM2OTlFRWhBRzFiK0trdktsWGQxTHF5VUZz?=
 =?utf-8?B?OGNiZEpuV21CU1NQSFM1a2hBMVFITUcwcU55ZXlRMSt1Yk5TUkdRTFNvUVBl?=
 =?utf-8?B?Ymp3TEdneTQ1d29ISklDMGh0WUcySnRxZWRXTDNGM0RTeUZrY2tkeHhrQUw5?=
 =?utf-8?B?eTJCN0IxdUIvQnd5UUJTMC90WFVLRlRYV29saVFKU3hySXpIamh2SU0wTFds?=
 =?utf-8?B?WGJyWExsbk5mRG1RMjVXNEEwcDlZYzFQYVdYLzBOVWVhY29zU0U5OW9NMDlz?=
 =?utf-8?B?blc3UWRpMzhHZGU4SGRGZmpnQytXdUFlUWp5STZCSTh3RFloK2hIZ1dRMzBU?=
 =?utf-8?B?RndheEM0dmpsY3FtbTRPbC9FWG5jd3AySUpsSXJZUVZrNWlpRk02S05Ia1U3?=
 =?utf-8?B?SVUvM0piNUxPWkc4QURFZW5NRVJCdmJrK0I5cFkrcnpUaWJ4R2dYY2liVHdz?=
 =?utf-8?B?MjlSWDVPdnBUdDFxRmdPL3Q4c0d1NFZHclkvaEY1UlhKWlR2RG9jSlMxYWNS?=
 =?utf-8?B?Y09BKzFGUCtISnpoNkZtL3AvQm9mOUs2TEVSWE9HZkNyaVVuRFZMVWpKczIr?=
 =?utf-8?B?S3FuOVVFcHphK3RSbHdLMndUV1gwZFJ6YWdLNzd5ZFZKRG1qQU9QenVxMktn?=
 =?utf-8?B?eUgrK0lwdUkwQy9ZbTZrYjBzcEVET1V5eTJFYWlEbTcvYTJzNzQyUTdwdWZW?=
 =?utf-8?B?Zm1ya2pxanlFOGRhb2pBeEdRQVVqNnErWkdXV0wvcnp3dlRtelM0NmNYUzlu?=
 =?utf-8?B?SUt3ZnRrL1lleXNXMFpjY2hQS0wxUDh6dndvWEN0UGZMbXB3ODBsT2VCYmdD?=
 =?utf-8?B?dFdVcHNjbk4ydVg5aEZ3OXl2ajJaVXlGZDNSUGw5N0tuWVlSYzVvOXorMXAw?=
 =?utf-8?B?MVNiTGlCM3pZa1dIT3c1aWdiQnMrRUR3WkpVbUhzZXdORG1HdXFaa2gzNmtu?=
 =?utf-8?B?TlVZejlEQldyR3krZGoxZ3NrY25nTXZOZmdzQWFwMElJZUdocFhVcWxvUVJs?=
 =?utf-8?B?dlc1Z01RakpNb3E0NFNmN2Z4cnhDNUZ0TGtmUHBuN2hjUUlRcUc2MXRWRVhL?=
 =?utf-8?B?VTJXUmxxMzFTcTJTZkt6S0lyanhrNXpyUmpxZlFsOC9BSm5RTG9kTmQzWUpl?=
 =?utf-8?B?K1k5S1Fyb0V4WWVENVJySUpIN0phMVAwcUpBeElYK0hlcmVYRHB5UXhaZ0xL?=
 =?utf-8?B?aEthQmltQlN6WGpPNjFlMWxFNkU1QTFlRStTdDU5Y3M5Yy9LNExjQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 924a46ae-14ab-45d5-427d-08def6d18c1f
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 11:21:39.3933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Ku28JySzzHK+8z9BYLUF53W/3+WCSnkZ0z8sPKyWXzpvXMb4O80JtwA7fu0bXf1dF4IoDsyEDZb00+/9Kn/gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7485

On Mon Aug 10, 2026 at 10:30 AM BST, Alexandre Courbot wrote:
> On Thu Aug 6, 2026 at 1:35 AM JST, Gary Guo wrote:
>> For types that are layout-compatible with an I/O capable type, we would
>> want the ability to use them directly for I/O operations. E.g.
>>
>>     bitfield! {
>>         pub struct Foo(u32) {
>>             ...
>>         }
>>     }
>>
>>     #[repr(C)]
>>     struct Bar {
>>         foo: Foo,
>>     }
>>
>>     let mmio: Mmio<'_, Bar> =3D ...;
>>     io_read!(mmio, .foo)
>>
>> Currently this feature is available from `register!()` macro but not
>> otherwise available with `io_read!`, `io_write!`. Support this by adding=
 a
>> `IoRepr` type to denote the underlying I/O type to use for a specific ty=
pe.
>>
>> This makes the `IoLoc::IoType` and `Register::Storage` redundant; thus
>> remove them; also convert register methods to use the `read_val` and
>> `write_val` instead.
>
> Ah that's nice, I was a bit bothered that `IoType` and `Storage`
> basically defined the same thing.
>
>>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> ---
>>  rust/kernel/bitfield.rs    |   5 ++
>>  rust/kernel/io.rs          | 203 ++++++++++++++++++++++++++++++++------=
-------
>>  rust/kernel/io/register.rs |  59 +++++--------
>>  3 files changed, 170 insertions(+), 97 deletions(-)
>>
>> diff --git a/rust/kernel/bitfield.rs b/rust/kernel/bitfield.rs
>> index 35ede53f2b8e..4bc92c62da06 100644
>> --- a/rust/kernel/bitfield.rs
>> +++ b/rust/kernel/bitfield.rs
>> @@ -308,6 +308,7 @@ macro_rules! bitfield {
>>          $(#[$attr])*
>>          #[repr(transparent)]
>>          #[derive(Clone, Copy, PartialEq, Eq)]
>> +        #[derive($crate::prelude::FromBytes, $crate::prelude::IntoBytes=
)]
>>          $vis struct $name {
>>              inner: $storage,
>>          }
>> @@ -346,6 +347,10 @@ fn from(val: $storage) -> $name {
>>                  Self::from_raw(val)
>>              }
>>          }
>> +
>> +        impl $crate::io::IoRepr for $name {
>> +            type Repr =3D $storage;
>> +        }
>
> This introduces a dependency from `bitfield` to `io`, which looks like
> inconsistent layering. But thankfully there is an easy fix - see below.
>
>>      };
>> =20
>>      // Definitions requiring knowledge of individual fields: private an=
d public field accessors,
>> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
>> index adfc555de7d0..71c6180ed745 100644
>> --- a/rust/kernel/io.rs
>> +++ b/rust/kernel/io.rs
>> @@ -276,6 +276,91 @@ pub trait IoCapable<T>: IoBackend {
>>      fn io_write<'a>(view: Self::View<'a, T>, value: T);
>>  }
>> =20
>> +/// Safe transmute that performs size check on monomorphization-time.
>> +///
>> +/// Can be considered as generic version of [`zerocopy::transmute!`] ma=
cro but using the unstable
>> +/// `core::mem::transmute_neo` instead of [`core::mem::transmute`].
>> +#[inline(always)] // This is a no-op.
>> +fn transmute_neo<Src: IntoBytes, Dst: FromBytes>(val: Src) -> Dst {
>> +    const_assert!(size_of::<Src>() =3D=3D size_of::<Dst>());
>> +
>> +    // SAFETY: `Src: IntoBytes` and `Dst: FromBytes` and we've checked =
size is the same.
>> +    unsafe { core::mem::transmute_copy(&core::mem::ManuallyDrop::new(va=
l)) }
>> +}
>
> This is universally useful, so let's move this to the `transmute` module?

I think we can just have a `kernel::mem` and put it there so it's consisten=
t
with std naming. The `transmute` module just contains two types that are go=
ing
away.

Ideally we have this function in `zerocopy`. But my understanding is that t=
his
depends on inline const which is stable since 1.79 but zerocopy's MSRV is 1=
.56.

>
>> +
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

I tried to be a little bit forward looking in designing this, so I ended up
with a design that provides conversion functions instead of just transmutat=
ion.
If we're moving it we should probably just get rid of these and just requir=
e a
transmutability with the raw repr.

Note that there is `AtomicType` which has similar (but not equivalent
requirement). `AtomicType` requires a round-trip transmutability only, and
`IoRepr` needs both directions. So `repr(C)` enums (that is not used up all=
 its
variant reprs) can be `AtomicType` but not `IoRepr`.

>
> That way `bitfield` gets a dependency on `transmute` rather than `io`,
> which doesn't break layering.

We can also avoid breaking layering by requiring user to need to specify
`#[derive(IoRepr)]` when declaring bitfield.

Best,
Gary

>
> In order to avoid `Repr::Repr` we can also rename the associated type to
> `Raw` and update the method names accordingly to `from_raw`/`into_raw` -
> which would have allowed us to remove the `bitfield` methods of the same
> name if they weren't needed in const context! But at least it makes
> things align nicely.
>
> <...>
>> @@ -831,8 +816,8 @@ macro_rules! register {
>>              { $($fields:tt)* }
>>      ) =3D> {
>>          $crate::register!(@bitfield $(#[$attr])* $vis struct $name($sto=
rage) { $($fields)* });
>> -        $crate::register!(@io_base $name($storage) @ $offset);
>> -        $crate::register!(@io_fixed $(#[$attr])* $vis $name($storage));
>> +        $crate::register!(@io_base $name @ $offset);
>> +        $crate::register!(@io_fixed $(#[$attr])* $vis $name);
>>      };
>> =20
>>      };
>> [snip]
>> =20
>>      // Implementations of register arrays.
>> -    (@io_array $vis:vis $name:ident ($storage:ty) [ $size:expr, stride =
=3D $stride:expr ]) =3D> {
>> +    (@io_array $vis:vis $name:ident [ $size:expr, stride =3D $stride:ex=
pr ]) =3D> {
>>          impl $crate::io::register::Array for $name {}
>> =20
>>          impl $crate::io::register::RegisterArray for $name {
>> @@ -1008,7 +991,7 @@ impl $crate::io::register::RegisterArray for $name =
{
>> =20
>>      // Implementations of relative array registers.
>>      (
>> -        @io_relative_array $vis:vis $name:ident ($storage:ty) [ $size:e=
xpr, stride =3D $stride:expr ]
>> +        @io_relative_array $vis:vis $name:ident [ $size:expr, stride =
=3D $stride:expr ]
>>              @ $base:ident + $offset:literal
>>      ) =3D> {
>>          impl $crate::io::register::WithBase for $name {
>
> These appear to repeat quite a bit of [1] which is already in
> `driver-core-next`. You'll want to rebase, I think the only difference
> between the two is the removal of $storage from @io_base.

I'm thinking of moving this entire thing to syn :)

Best,
Gary


