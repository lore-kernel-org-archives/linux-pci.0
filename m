Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022106.outbound.protection.outlook.com [52.101.96.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF731A6811;
	Thu, 27 Aug 2026 14:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787840496; cv=fail; b=uz+YQTSS/PmGRz4LEL44+DbrLrlcR/3WkegejA3e/3bmkKCuWTXRJh5QMHCtSYRuHP4JP4S5oWg8+4cNcEPsrc0qZAmE0mSfTHD3ZHIYgmSG9NT1BWUyfge49fSkLmr0qEQJ5A9UL3o/Na5QdcGUUs6OCvh6007TmuafL5UOEPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787840496; c=relaxed/simple;
	bh=VoUEeDuA1+Q7zM9zwGw7MS78LZkHQeO0ouzrGa0eLa4=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=RmHfBDaiUuXO6ooy5Q+IzRs79PQVB7nJewD3NTtlq05y4gQc8AjNPLUi32YAMoAb4v/WG7koGBDGyApHqu2Os1hRpqhhQXYSBZU8ms0ZE+xWPQTfnxQdVoiUl7qUQJUdzMEeU2yUuZJAYRPXkEs9QKlCCnsV+muS6Ctf0dI9iB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=aJj2hc2a; arc=fail smtp.client-ip=52.101.96.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="aJj2hc2a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ADoX3vEXD2CYd9xK7Jt03sybK0RBnYW6v5hrDDmGCBHS/B5zHx7O5/wrLJ5YbpQPHCEuz8aX88ql71uUS2uS6h6CO+iHKw6iExHbH+Lr27Ev3+0KQnyLb49GqWyoZmJxTfFUYrwAtb0uUj4RcwOlTQkLmC2z6ZqCfL6keZWJZMNtbLXkIk6eY9j6BGeZZIOiohqoiqFk/WlvlmHXgiFpg0OrVwtJbqJMNLkt+nxTm/44uDeCDvK84/xx/DMy6qEi42Rkh+ETuHTaQne4gZ7l/UyamfeF9U+awLCB6cNgz+ydnvBwLo5FTHy7d4ZTCO6HtsqhiQDAk6eWFwjn8Jyvxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dm+owOf4EdKQ3kT8WDRN6+mJXeIWODeB0oo8MvRo854=;
 b=W1ZXYXh/cfy+AZOyHKQJswEXOBIsKQ5k/HqeSgipmJqcyYmrjr7ig016xxBV34Z744d3QJMg3JIbmFqwaPj5bYd9n+stVbbSX8MGsSnw4aAP+gk8/hzTveaovmIreOqaALRq2ihcBQ/G63Hl4YRnydwcaL1zSOGBZXEbsjDZxL6xEeqZMSvfIRIJtLED/MozLph7dijKn8X0nbaxF9ON6yh6Ekrn1Umc1pBxM2cVbMYb+ab0fVB7ITUS7rLEcAoVj1cx39Ju16gNzbu0866CoeLDT3fCfkonSwMOQvb47R5R1gggnfq16vLDmjz2tlU0KS+hdW4SlarowhylxSTaZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dm+owOf4EdKQ3kT8WDRN6+mJXeIWODeB0oo8MvRo854=;
 b=aJj2hc2a+bq47x4kjTnuuK/ZrjZeMDQ70kpXUpvXK+9Cl/vJDTG+03OzR6vOI9RZqMXFRsc1Ob8Ho0mlfNrSteRxXau6lR07IbY2C19FRJkBo0vJVNktTF2LzypmBytm/o3DMyBiv2RsmFTgs+SPLpCY7cPz8Ua10sTRE6d2hqw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO0P265MB5359.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:244::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 14:21:30 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:21:30 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Aug 2026 15:21:29 +0100
Message-Id: <DKZSK6DW84GM.2EARLBR7IPHQ5@garyguo.net>
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
Subject: Re: [PATCH v3 04/16] rust: io: perform conversions using `AsRepr`
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-4-3699a75fadf1@garyguo.net>
 <DKZJ14NCZ37X.31YOYFWBKZ478@nvidia.com>
In-Reply-To: <DKZJ14NCZ37X.31YOYFWBKZ478@nvidia.com>
X-ClientProxiedBy: LO4P123CA0633.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::20) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO0P265MB5359:EE_
X-MS-Office365-Filtering-Correlation-Id: fe3b666f-8ab1-4591-3dfb-08df04467d04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|23010399003|7416014|1800799024|376014|10067099003|18002099003|22082099003|4143699003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	aeR7BjO5Trezd8EcwQomPCcSPF91er+dnivG+6fiA2YWQYNNR8jDST4d0xFyA8H4p09he2askVwiblnBdX3CbIZF/zkMzqVljHTdY02nz857UfZW6Gu3TNdJH2KA047Z0iT+W7W7SO50Fe0HiMKCrvEDYnxBxe+j31z3wAvXPye4LKFJbaVdj/50MOxAxvcegRGr/8EJWM196A8tKwkQMtT/exXIyr2kmAXW7EQipBgdxLy9CUKQ0ORM+mr4kru7JxoWumL/xYYxJHzetH+iBWniXDHLju6gWN/8J7+DteJ24j5VGDf/jnK1SYak1AhuxoQXOT8Is0rAR7LmZXIXG0r/UWy5l7c7bpMEhnaKlTSl9DG4thSQzYQB7vNcEGZpLYkAmkJr8ofJ1bRJd6XicYJcDgfKDpw2xsqkAlFOPUYfaSQ1VwJ2rmrLKjmeW8qA2Yqo5HKS/HyvH7QHsAnknSP42cCcn1OSZVOVX5lnxlGnDV559FGUT0daewxxTNatDaDqLNoIPm2spwUw5AKnrUc01b8BYjINzGRO7i6w0s6t81HlhC2kseX5JOKSR2DbtTNOscRi/YT0K1kgKox+o5LCi/EOUzns7htwhEqiwPcVsiNv1shi04gMVimjgYCNcqR4cISV9+jtkXYYTka4Sl86yxmA9aMhYd37bNfKxyY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(23010399003)(7416014)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(4143699003)(5023799004)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkFrbTFFQ280NG5WRE9ibUluUWZqZ3FLRTQ3WjgyTFVadVpIWlZQMGZWdEcz?=
 =?utf-8?B?TExwZzIwWlNGMzZTZCtKUXRaWmZ6TmN3MkN6cEJobmI0Ykw3RmRLbkRzUHJV?=
 =?utf-8?B?a3V2bUF4bTlUd1RkRGxvSkh5ZDhTZ2tkRDE1TkNLOE1STEpNNVFlYkRyR0lj?=
 =?utf-8?B?akJtazlheGQ3SmJ1c2RZcXR6dzBJdG1GelNzY1RNUGoxWTJFVFBKMUVqbUI2?=
 =?utf-8?B?b2NuTjJac2ZRYk92VkFodVNSK0FDcnZMamhqWTVJVUlSNzl0T2tveEVRZHN5?=
 =?utf-8?B?ZlZEelJNbmFqVElIa3EybXB0SytUWlQxUmpselRZVTNoc2dCNUV6U2tvcHdH?=
 =?utf-8?B?UFB2bUI1dGdxWWY1UXZvTEdqbkxVNGorVmprUC9MMmhHaURST216SGF5N1Ry?=
 =?utf-8?B?T1FQZjBxUjVmc0hZSjNpMys3bFpISUx1SjNNQlBlUFkxYURTaWRuVllZRjdF?=
 =?utf-8?B?MDhNZ0g4RFNJbkZQYlpESXk3elhmUHJxVmF0bk9ZRDVYaVNOaE5tam80V3Fn?=
 =?utf-8?B?eWpwL1NJR2szcXpjby91aXRMUlVEbk16V1prUTRvS3h0L3JIQlJFYkpqeCsy?=
 =?utf-8?B?Skp4N0EyYjRqZ1d1SEdxQm1GQnZjMHNOaWFPcWtEZnZOV0I2bmpSU0RZVWxv?=
 =?utf-8?B?bTgvQ1ZlZTZjNFRmT0M5VXRFb3kyQWphL0xzVmhlcUNLT0V6d0lWTGo1OWhr?=
 =?utf-8?B?VXJQWjhNU1N1V0RtSXNpYTVrZWJuaElzdXJvQW5HUDE3R0M4bkdCeitqK09z?=
 =?utf-8?B?RWdDaE9raUlpOFZnNm1lZXVSMk5La25KdXN2YXZ4K0I4ZXl1c1FmMndmUXhq?=
 =?utf-8?B?Wm04Q2NnRy9qREljbCtwZzJyVHhCaUV5ZUpUT2FsNDhKckZGRnVoYzJ0SHgz?=
 =?utf-8?B?cEdiWEg2Yi9PZjBOa2NkNXJ6azNQemI2ZCs2M253dENkeWMzcFVsdzkxYUJx?=
 =?utf-8?B?OXJ5cHc4Z0haTXVBckdyZWxMK3ZrYUh2clZVendwb3BIWVVqdWZ6VTF2QWdC?=
 =?utf-8?B?N21XMGhnMDhDeGNrS05pbVNwdWJQV0k4bFV2NjF3eHR5eC9EWmN3cWxKZURI?=
 =?utf-8?B?cTJycGdpbXNzSVZ5SER4aVlsS28rQjZyTzJRTFZnSXpKSlRXOUVwazJ0bGJV?=
 =?utf-8?B?N3VpY0xIOTA1WVZIOVFNQmxHZHN1aGRrY0ZiNm9YelkzRWhDRENBYW8wNnJk?=
 =?utf-8?B?SmpiQmRucUtNRXdwcmNvb0Z0Q0lzVE4zQ3g4RGZRNndqZW81aTBFQnRia1BV?=
 =?utf-8?B?dGdwY3lRdDB0YVBLcGo3YUhvMFhodTY5ek0zWTJhcTRFd0tFYURVdWlWZ1dU?=
 =?utf-8?B?TEU5ZnIyWm9FckpOTURYV2FJSERvSzVJM2V5aXJ2VThpMStEK3o5Zkw2dGUv?=
 =?utf-8?B?RHlicnFVTUI5QzRQUEpCOHJuWVVHTHpKazdsamJpcXJ4MUhqeU5MZC9XOG9T?=
 =?utf-8?B?aEdvYitKM3FldXp5WEE1ZjZMbW93MUhPbE5RNFZPTnl0L3M1Snk3Z216eWJE?=
 =?utf-8?B?MHJiZHQwUGY0Uno1ZmZJR3pkV1JQbGpwTFRHTmY0UG5LNDdONm1yZW1kT1ZE?=
 =?utf-8?B?KzE3L1gvOGIzQWZveDIzUHdMT2VyR2JXMVp2amt3Rk9KbUM0MmtyUHJDRERk?=
 =?utf-8?B?bzIvdkpPNDNpWnJhTmZ0dEJtNGIrVmJqZVEvZUJtT0RQNXpzVU1zRHh5am5i?=
 =?utf-8?B?WlE3OXNMRkMyaklZQm5LTWh1b1FxTVpKanY5OTN5TEJCaFhlRkN2cWVGRzVs?=
 =?utf-8?B?Umh6KzFLb1dxTVoxR2pwbGl0cURMbXdGUnRSYnpxTnJWMDVDN0tBbmxiaUxj?=
 =?utf-8?B?ZGRXR0FBQVNBT1BRcmp5ME1pdkVHYVJFSEc0Y21GbTNIZk5JckJkWTE4Y3NM?=
 =?utf-8?B?Mktya1NoK2hMNXN5Z1d1SHc5dk5PVDkzclhKWVQvRWhES0FOMERRa3ZnU1dE?=
 =?utf-8?B?MFBBK296aXprSXYrc0dCRUIvYmZwWVk4NE9nS0NxWlhHZHhiMGlvRlAvQ0o5?=
 =?utf-8?B?dGFoMTd6RDV0TWJPNWcxc2lmM2lUSW9hYXYxOVhycmw2aTRsQXZPaWxYODRL?=
 =?utf-8?B?eDNmdmIwdEp4eHlITzBlYTVOaXFGdXB5YmU3OE5zTGxJWG4yenByN3h3b0s5?=
 =?utf-8?B?NFBYdVBRcG8zYnAzUkVob0ZCU0MyUnIwOXRKZ1dlNW40eDVMb0lzbEp5SFhG?=
 =?utf-8?B?Q3g0RUhTNWNHZ29vMk1PZzdJSVJMWHcwOU9KTXYwQXQ5VkxFZGxEQ2JHUkF5?=
 =?utf-8?B?S3pqZ3BDbkQ4WXhqQXpHTUtjaWF1VGRmTEk4WGxrbDNYOVZJK25JN0xZYnBo?=
 =?utf-8?B?YnhsbE1LSmZKSExqUEw1enBza29DVG9CRXVYd1AwV012SDhqK1REUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3b666f-8ab1-4591-3dfb-08df04467d04
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:21:30.2479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y1R5YqzHg0PU0Fhsi6MI7S8NNvOum+72SRv9qtC9j7FAlgIWgG599wz59u/FfSwK3OIffYmraUP8N1M+y0ZMfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5359

On Thu Aug 27, 2026 at 7:53 AM BST, Alexandre Courbot wrote:
> On Wed Aug 19, 2026 at 8:09 PM JST, Gary Guo wrote:
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
>> otherwise available with `io_read!`, `io_write!`. Support this by
>> performing conversions to I/O primitives via the `AsRepr`/`AsReprMut`
>> trait.
>>
>> This makes the `IoLoc::IoType` and `Register::Storage` redundant; thus
>> remove them; also convert register methods to use the `read_val` and
>> `write_val` instead.
>
> Nice, the redundancy was bothering me a bit so this is clearly a better
> design.
>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
>
>>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> ---
>>  rust/kernel/bitfield.rs    |  10 ++++
>>  rust/kernel/io.rs          | 135 +++++++++++++++++++++++++-------------=
-------
>>  rust/kernel/io/register.rs |  15 -----
>>  rust/macros/io/register.rs |   2 -
>>  4 files changed, 86 insertions(+), 76 deletions(-)
>>
>> diff --git a/rust/kernel/bitfield.rs b/rust/kernel/bitfield.rs
>> index a0d089423f21..619c5e2189d1 100644
>> --- a/rust/kernel/bitfield.rs
>> +++ b/rust/kernel/bitfield.rs
>> @@ -308,6 +308,7 @@ macro_rules! bitfield {
>>          $(#[$attr])*
>>          #[repr(transparent)]
>>          #[derive(Clone, Copy, PartialEq, Eq)]
>> +        #[derive($crate::prelude::FromBytes, $crate::prelude::IntoBytes=
)]
>
> Do we need `FromBytes`/`IntoBytes` for every single bitfield type? I
> mean that probably doesn't hurt, but if we need them for registers then
> we can derive them from the register macro.

These are not needed now (as `AsRepr` provides sufficient guarantee so
read_val/write_val use unsafe with them instead); but I kept them as I thin=
k
it's useful derive regardless. I suppose these are not needed for `register=
!` so
direct user of `bitfield` can derive them manually instead.

Best,
Gary

