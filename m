Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021135.outbound.protection.outlook.com [52.101.100.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38621324B22;
	Fri,  4 Sep 2026 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788528745; cv=fail; b=MfvwGFc4O9fQDcl5gIZWnzF5lSCKcheAAWfo5Yy5LO19sh9NXEQwDdaBxoNIsGik8MlbYhIjMM2wbmNSSeTLrSBD6sOo8h7Q7BY5JEoKZGAm0HtGzpAeqMr/65Hy7TZeeWDyjjHdmQqfDQX2lfwf3re03iYJC2osA0uysrnWKZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788528745; c=relaxed/simple;
	bh=/JKRKeS282p3ezwfdRXwA4RNzQr/G3la9xuRnmZFqUI=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=DNDQj74jsopx5z1TBpDb+CQYmufy//SXaOr26DhSZkOhjnrX8nsnlAiUUM+YBrlGyLRcqLi5D59TJkjf7N3lidfgSS/ge5KAM8vgI9EYSydlFHAONc++eX/ortnX/SeYgmXvKuVL9Rbtx4/AriuWYikPGshfCnGgWGv2msrfFHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=aLfUs14W; arc=fail smtp.client-ip=52.101.100.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="aLfUs14W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+zxRsRxKFPZZswGwnGsMMltzg2p+Iy2N+qDtD4Os48DVeZYMX7WGMHs74S8mz6U1v2qL40oZC7Prd3ORwSRfpszP9o70LbwrVj63z7HMH1qrcTRBL+ar3uicASPqWb9Jd3G4PZcAkU4tgC+95jWsyT7WF2iBfhSw7YU6FspC9Uif8VASgtOUnLm94Q1MeN59aXZda3rYHRpBHge6phnqQVnzH0hNK+iqxzAqdHuO4grcpTqfD5/jMmnP5+bj2t1BXWB4f1TT1r0FcIPWzaSkNr+FMOUOknpx+XKSya4rlEJRFBOAopFqgO3IcOT1tdOBPVvOxH1EHYZWp5rrJ9UOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlUswDcrZP9GVD724704mizV5C30GUUNBDoDDrSl/zs=;
 b=p08sVj7TS4vTCjJdcy7EzrtyX6z4QixZgMBj+SNkkHUSA4+Fkv/PrGf/x6PKdgUJG1Vcfe+ayvnaEQDap4vVWksvzswHyxJbVwFoEP/8VFi5ylpWk5tgRszx3wOAYTm1MkhuYic35xdDSGVi6hpy6MS3Ur8AOKqQRR5LlHhkaua36ugeowwGh5/jhQE1fPVyG5bRtpUWB8yfjsTshyYjXdcyX8oynxhE1/3GYnsTdc+yGoMioIBK9RI2K3w2QS71hbr3XMqfoIwo2PQuYKujjm6iyThf1h73o0NgkANsoamWg06gpw2XeeZPtpP9yJxby3v4bZlmjZ2Oyhfs7GtpMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlUswDcrZP9GVD724704mizV5C30GUUNBDoDDrSl/zs=;
 b=aLfUs14WlEQJTJCV05tBtNEAi2mxNbcv24NH08cmBWa1L9DDwSVNRd+ITO9Zrhq8/XM7G8PjrpaE/Jp9ZkP2wwY6DcmV7IQ+S5QLoJ9JezgQGLWde9blji8uPIT5Hw9N+tenGZVlWW0dfTjNCQezKHvM/tQWsxHZ3dQkv9ieP0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO4P265MB6729.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 13:32:18 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 13:32:18 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Sep 2026 14:32:17 +0100
Message-Id: <DL6KIVBHB08P.1LH0WPGN5FFVN@garyguo.net>
Cc: <rust-for-linux@vger.kernel.org>, <linux-leds@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v24 1/4] rust: leds: add basic led classdev abstractions
From: "Gary Guo" <gary@garyguo.net>
To: "Markus Probst" <markus.probst@posteo.de>, "Gary Guo"
 <gary@garyguo.net>, "Lee Jones" <lee@kernel.org>, "Pavel Machek"
 <pavel@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Dave Ertman" <david.m.ertman@intel.com>, "Leon Romanovsky"
 <leon@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Ira Weiny" <iweiny@kernel.org>
X-Mailer: aerc 0.22.0
References: <20260903-rust_leds-v24-0-8d9e4c04db69@posteo.de>
 <20260903-rust_leds-v24-1-8d9e4c04db69@posteo.de>
 <DL6JWHOEG91Y.1BKBUP653Z5D@garyguo.net>
 <612e01853459f0eb87fe78b7f5fdb73e22cd1776.camel@posteo.de>
In-Reply-To: <612e01853459f0eb87fe78b7f5fdb73e22cd1776.camel@posteo.de>
X-ClientProxiedBy: LO4P302CA0006.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::12) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO4P265MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: 61b42a32-402a-4c83-152b-08df0a88f10a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|23010399003|366016|10067099003|4143699003|56012099006|5023799004|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	wot5X2aa0mCSohQC4U9jdrar2qoFNTp3jdK4ieyf0yAj084cmCzrsAPhfbicoWepF43sor2NjgUSnk3yo3zxRX2vQnzzs11HT+N7UJLuFS85UF0MBY3MABeJBrwzor5DB57Dllmek4Vw4nrnCxZD3jyyzvZChDsXC+cmCd6AFTqFu3u6ZV0xk4aVZJq4NjcISLbu5u80uko56z8HX+uGowHaAbfo+vYM7nSU2QNZWPCFrbS7V2pTSbNycJPTzBcpUKKmuoMqm5pHuyr5pTLtWGahbCGIap5lzTURsC6wp0pDiGqo/Eg8WbRPwr8ZDTtokeW169gZrXv2PkLDeswN8EP5CBjzYMkeEzLUAp8VjT+A6Vi1dbF5y6KXqyJb5Q5VsZWLHWoGxm/o4JieV016bvvCmLcUrOe/ELPSpivUeH6YURoUx52wdWQVexO/jZ/J6uDAJD1elukC6t6Wyqsv+4D1iapk2drtTsQDNRkFfWgqiQimNlbXFblG7en0qpUU30zEn/mDSOjDKiCDNke1y5+mLm1vic8EJsfpeI0UHfW+Rmc35qRAj9MfNDWeIzOCWDZaBwx7FnbMqTvyfN5FhirhF+RtaZuD70DZ/7f7JP9SJYZEYUrjb8UWkfZtJWxRzLVRcDRsrFq8pED39kasTdohhnMeo7BBfCYU4RG2ojdOqQROXU6k4ja3W71Ms/g+MUL+gLdeDluYHDk3DazKNA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(23010399003)(366016)(10067099003)(4143699003)(56012099006)(5023799004)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUhHV1J0YjlFSERpRVNVK29CQWdZZTZYekdCKzNYSStFMkY0VUcyMStCd0po?=
 =?utf-8?B?MCtWYXFWRitEZHZ1QXczOHFSRnh1ckc1N1dKRURURmlmcG10cEllbEpkUlVV?=
 =?utf-8?B?NXMvUjB3RU0yZHlIcTdIVmt4Q29HRnlDR3pyclNsblpTZnVucGdEUmNkSWJw?=
 =?utf-8?B?Q0N0elVKZU92cGswY2Z5YThocDVmN0FRQ2FQNG5oNDVwQkh1b1U4MDZMU3lO?=
 =?utf-8?B?Tk1VMW9MeGJ2SmxobWRGNmdoWDkyQUJFRW9IOVVmSVBpN290UlBHTmgvUE5C?=
 =?utf-8?B?dGgyT2RlZGNPZmJVWDB3OVArcmxOL3JUMkEwYkhSNHZwaVhMc04xZXlkQTly?=
 =?utf-8?B?R2JNS0RicGZLL2IvU2RBZ29JZlRpWVJ3R2s2TmFpMXBMN0plRTFoaDk3SU5a?=
 =?utf-8?B?dGN2Uk41RnZ5Q1o2WUFyMlJPUzhqRktKdFVlVWxwOWQvNTV1Y0IxM01jT0Va?=
 =?utf-8?B?VzFOeU1iTW5hL2E3a0pmdjJyWnFiMmlJdFEvSG9XUnBGVkR2Z01vSVlHb01M?=
 =?utf-8?B?aXlKYmQrdHRaSnpmVFUrNGxhMlAyQUVkdzdDNlFEaFVzUHBMY0VmSHNhNFQ5?=
 =?utf-8?B?Uk03TjEzMlBSdTVHZU5iUU9EdVczQzg3Qmd2TlFsdm1wVVVCaXFabmRUVFk5?=
 =?utf-8?B?ak1iR2R1UmVrbm95ZzlqUDE4NXM4NmlGeFpGdFRmbWhEdFZCc0Z2amcvOU15?=
 =?utf-8?B?bzQ0V21vSkVhekdiajZSU29rZnlLQld0OVptbm9aS0ZGMVhTUVZySnpmT2tO?=
 =?utf-8?B?aW0xVkdEMTcrWmhNdWFSVFlWVjdJckcyUTB3T3ZuOUFlTjJZUnZHcFlra1hE?=
 =?utf-8?B?eWpZdDlaT01nTmViNElzeDM2RHVoYmhOMUJpV0ROMWxBNFlaTHAyWis5RER4?=
 =?utf-8?B?YzdjVit0UGlyWnFFQVU4MmRXMDQ4TkNlNnJwNk9jVkM4QWNzRFpUUTFUWXlB?=
 =?utf-8?B?ZFdLNTF5Yjg2VStaZXFyYnU5VzBoY2QzeTRVcDRvcTUybDM2T3NOOElFa3Bh?=
 =?utf-8?B?SE1aY0VXTHhmL1BGdWFMam56djFhdk9VbTM1UW1HTDYyWmdnWkNWdmdwY09G?=
 =?utf-8?B?RVd0NWI0Zy9uOVV2RTlYYU5kRGQyOVpwL0VMaE5TQU0vRG5MNGZVRVgrWTFj?=
 =?utf-8?B?bW9iUFFpYk1wQlJhNDg1SXlJa0lqdkIxeXpmdlhmU2pQMnFFbUxrM0gvUHU1?=
 =?utf-8?B?ODY5ODBNNkJtdXJhL200RmxlVk9mZnlxazZLMzlmdFJpR0dxaUJ1bXcvVG40?=
 =?utf-8?B?d0pRMGV1a3NWSTk1aUVHeGNoMTJ1RHE4UUNpQmR5MDdkNnArOXJJRFM4VTF5?=
 =?utf-8?B?WTZmczhCeWlQUTZWL2UrSzY4bVRxWFJqWmZuTHhlVVpJRUN1NVA2anhTNzAx?=
 =?utf-8?B?cnZJNWtQVFNPWnJnamZsV1BISGk5N0JyRGxialBHZUpKTWVRVjhobm8zaVo1?=
 =?utf-8?B?b3h5emdDaHVqUllxSjhtTUZMRytMQWxPWjlISnhUYWxlRFEzOTM4d2JZT0dZ?=
 =?utf-8?B?VDUyOXNSMU1UUUJ4UEgvejJsQmk2eUJhK3c0dXdtZ1NOM3ROZnI0aXovdFRU?=
 =?utf-8?B?WVRPYzRWNlJtbjlMY1ovQnJNbXVUL0xDaHpHQktadWNVV2NvQVRJWlRtRXBN?=
 =?utf-8?B?T2dnYUZtSkk1Qm81UlF0QnRoWlZBZStnWUpvZXk5Q3RBMHlKVkJSNnYyQ1hB?=
 =?utf-8?B?UVh5TXh4S3lCZDUyOWNMekpYc2RCK3RYcDYxQkJTODlHUXNSYTBVckUrNHdM?=
 =?utf-8?B?TVJ1K2ZjNm1XKzBwYWN2elVyQUovTm44WWllZ0RGREJSSkhPMlJXRERDVU1M?=
 =?utf-8?B?djMyNmd2dWZ6QTkwQnF2RGsxRXNaaktoTHhXYXBtWFNCVHJHYTdUZzVVZGZI?=
 =?utf-8?B?MlppM0V4RTVCaTM5bWhRS2Q3WVgzRGU3bDh3S0Jvb1dvYWZLZ05LSDNBTzc4?=
 =?utf-8?B?ZEtCcjFPaGw4K0d5TUhYNk4rZzBSWlFFYkpnSG5FRkN4YVR3ODlvVHF4THAz?=
 =?utf-8?B?SlIweUVmMTRwOGNBN0xVdW9CUUQxVUdpTklEejRueXVhUldpeTdPSVI3QWs3?=
 =?utf-8?B?RUJTdkxmbWptSXY3OWpJLzlTcEtrMGhOekRGQnowRWRXbmFUM2ZRSUhVSXNs?=
 =?utf-8?B?dGxDUm9PZ0FLUDNSNFVjTStmYjIxc3pIZThpVERtbGxDTUVITXBkZ3UzOEcy?=
 =?utf-8?B?VGFVeWY4MHhZWDJCVkFnemVyWXB1cDZ0SnpqVGRlZTJ5eG9IeU1Ea3REQzhC?=
 =?utf-8?B?WDF3ZEs5TEdXYVpJbExRUFZxdERacjBwdXVtT0M1ZmluL2YxVitmdDRueVNJ?=
 =?utf-8?B?a0JZZ2Z1S2VyUHJRTlNtOHppSTJvOTFTQ0ZoOHhQeFdqeE5tZE02Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b42a32-402a-4c83-152b-08df0a88f10a
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 13:32:18.6733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7jUU7tov2ooNizW9LLMrljNXl7Hec8d+Oy6Fk6geeDQddW0nTTX5O9ny8w5xvpaFIEa7vjS5FPt8QRrAI9jfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6729

On Fri Sep 4, 2026 at 2:15 PM BST, Markus Probst wrote:
> On Fri, 2026-09-04 at 14:03 +0100, Gary Guo wrote:
>> On Thu Sep 3, 2026 at 12:01 AM BST, Markus Probst wrote:
>> > Implement the core abstractions needed for led class devices, includin=
g:
>> >=20
>> > * `led::LedOps` - the trait for handling leds, including
>> >   `brightness_set`, `brightness_get` and `blink_set`
>> >=20
>> > * `led::DeviceBuilder` - the builder for the led class device
>> >=20
>> > * `led::Device` - a safe wrapper around `led_classdev`
>> >=20
>> > Signed-off-by: Markus Probst <markus.probst@posteo.de>
>> > ---
>> >  rust/kernel/led.rs        | 288 +++++++++++++++++++++++++++++++++++++=
+++++++++
>> >  rust/kernel/led/normal.rs | 230 ++++++++++++++++++++++++++++++++++++
>> >  rust/kernel/lib.rs        |   1 +
>> >  3 files changed, 519 insertions(+)
>> >=20
>> > [snip]
>> >=20
>> > +/// Trait defining the operations for a LED driver.
>> > +///
>> > +/// # Examples
>> > +/// ```
>> > +/// use kernel::{
>> > +///      device,
>> > +///      devres::Devres,
>> > +///      led,
>> > +///      macros::vtable,
>> > +///      platform,
>> > +///      prelude::*, //
>> > +///  };
>> > +///
>> > +/// struct MyLedOps;
>> > +///
>> > +///
>> > +/// #[vtable]
>> > +/// impl led::LedOps for MyLedOps {
>> > +///     type Bus =3D platform::Device<device::Bound>;
>> > +///     const BLOCKING: bool =3D false;
>> > +///     const MAX_BRIGHTNESS: u32 =3D 255;
>> > +///
>> > +///     fn brightness_set<'bound>(
>> > +///         &self,
>> > +///         _dev: &'bound platform::Device<device::Bound>,
>> > +///         _classdev: &led::Device<'bound, Self>,
>> > +///         _brightness: u32
>> > +///     ) -> Result<()> {
>> > +///         // Set the brightness for the led here
>> > +///         Ok(())
>> > +///     }
>> > +/// }
>> > +/// ```
>> > +/// Led drivers must implement this trait in order to register and ha=
ndle a [`Device`].
>> > +#[vtable]
>> > +pub trait LedOps: Send + Sync + Sized {
>> > +    /// The bus device required by the implementation.
>> > +    #[allow(private_bounds)]
>> > +    type Bus: AsBusDevice<Bound>;
>>=20
>> Does LED class device has no private data that driver can use? This can =
be
>> either a private pointer or extra allocation living at the end of the cl=
assdev
>> struct.
> On every callback `&self` is passed to the LedOps, which could be
> considered the leds private data. It is currently stored in front of
> the `led_classdev` struct.

Right, I missed that. In that case I think you can just remove `Bus` comple=
tely
from the callback?

Do you have a user that needs this info? BTW, it would also help to include=
 a
link to a potential user in the cover letter so people can see how the API =
is
supposed to be used. This is especially useful for API design reviews.

>>=20
>> It's usually a antipattern to get the bus device directly, especially th=
at in
>> Rust we do not allow anything other than callbacks to access data on bus
>> devices.
>>=20
>> Instead, the class device registration should provide a data initializer=
, and
>> the callbacks would receive a pointer to the data instead. In cases that=
 a
>> device resource has to be referenced, it should be kept inside the priva=
te data
>> by the driver themselves.
> It should be possible to store a pointer to the bus device directly on
> this data, thus I can remove it.
>
> If I think about it, I could add a `led::Device::drvdata` function, so
> it could be accessed from the drivers private data. Sync is a
> requirement anyway.

An option is to provide `Deref`. Then you could even have
`self: &Device<'bound, Self>` in callbacks.

That said, you might want to eventually support type-erased `Device` types =
to
support consumer of LED class devices. So I'm unsure if we want to provide =
data
accessors on class devices (maybe eventually device'll be split into two ty=
pes?)

Best,
Gary
