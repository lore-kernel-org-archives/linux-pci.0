Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010070.outbound.protection.outlook.com [52.101.56.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902701991CB;
	Mon, 15 Jun 2026 04:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781497694; cv=fail; b=PK0apUJCgXe9IjPJ0XU1zXpUrYngWNRmfz6p5XnetDSu3G8hzFffAX3JWgM/ymbp0gItFb0cEQUCbaXz2Xts7yBxk/SAAOw2HxmH+6TVmct6JPMeC582VhucL9YkuYro60aH4obM5fJZQ+1aMlRDb7LaJXkKzB1rqQkFOXZToRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781497694; c=relaxed/simple;
	bh=gL9VTiQXEsTUcVzz3fNM0+lCmVbTnGQgOLgwupWhA9A=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=lOuVHMd8hCxOv13ehUF3ZBqM4zP0zZGa5Mw9BvgssZ6tv6UKx23wX0VpBHC5p62NvZ6IOzt8pFHWvF+d/sV2gd4mXPdkVSSjSueLqIIzYwobxP73MA6we5ySKyWCOah3LAVxU7/hGfyQiD+b0N5gRkZvHTQRSJW9Beo0/2aNos4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MSuB7p7v; arc=fail smtp.client-ip=52.101.56.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MSuB7p7v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gx/5vCFHDsS8NEFoRpqrdvwPxMQL658wU+Cs9jtqJkW/t/f9qcfHHerpyjmCTR6UJ+PEQa3Bd6vFG0v3Vxi0rjk4w3Ors51TrsvPCx+0WkUj5AvfaiYR5KtPVxvHdwxRcJgQOGKlNHAsn0dm4aHXVvJmLRBJbZAr4Zp11xqKZjxEvPSuUCYRr2PlqglsUBMinH4BgbcJ4QZewRyfRTadfbEGO4Rwa72OG9qDEkS/eYlFLb2T7+X/TJD0YgzWYkYrRe7a3P4aklGTD3aia9fjAHSljpykCxmsIqphJbul4ki/qLTLA57LP0cQyMbFzrCaP6OtPgJgg/EvjWJolGJF0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TL9H16R+hCnSLgNvERojlQBlGTCtKxV/ON/T24Lq4E=;
 b=jwAJV7t8FFSDubs+YgdvYmd+HR1vZZCq28yGJShaF84wBtKspHExEAu+aIakUmZ5zcn0Hy0es61plv6qLez/X1wd9QIruSaNteVJMk5mMSeBCLOdYlDxmsBavgAYwmeDHOtUY+I3Qj1GCQzE+KhOJQMMpeH06/KIWZYX6aOLx2nIcoYishep8JEAP/wfzihlwZpcYSZPxPcKhGehqtm7BOQasyaBP4oyNKPgXuHfTpbzemg9iD+wExn8y4s2xsyIbvdQGx3UTTVfYgz0+yHKeL+fVKPGTBq3OjCbwyTqldrsnmhDNKkgYOzbloZLaydfzv/9DVsAqYpWGdqHe7+Acw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TL9H16R+hCnSLgNvERojlQBlGTCtKxV/ON/T24Lq4E=;
 b=MSuB7p7vpG1UL8F2i1lKz9xgg/q+BDwfyhJVkwj0HrxU0aUohQnw78jJOSYo1JY5s4dE/2lP92n+oqXRyYz3DRTXs/sYQNLptToiQvTeXLFx/x8JWJd0dQMHYz33PnMW2MBf+OitrjBFWwMSW9yFPrGx0HSPN9UERJWJXExqLakOEszFbDnocNARn6RRpnfBNsQ0KO97zBLfZzNHBKp0ZjF/jNtOqLuBjpwQcD98eWJL79T+RNJMZgI3P2izoVaBkT8yKo/EWwLWgwrE+L0Fd9rkv47veWwtPaYn9B0uNHOQQXuJWpEIUG+uGQVtfzfjS5nHS5iEzNsSsPNnxvnm5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN0PR12MB6366.namprd12.prod.outlook.com (2603:10b6:208:3c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 04:28:06 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 04:28:06 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 13:28:02 +0900
Message-Id: <DJ9C815EGU4Q.3L04WWDJAUK1H@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Abdiel
 Janulgue" <abdiel.janulgue@gmail.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Danilo Krummrich" <dakr@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 02/20] rust: io: add missing safety requirement in
 `IoCapable` methods
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
 <20260611-io_projection-v4-2-1f7224b02dcb@garyguo.net>
In-Reply-To: <20260611-io_projection-v4-2-1f7224b02dcb@garyguo.net>
X-ClientProxiedBy: TY4P286CA0016.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN0PR12MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b854fa2-9f14-4579-a3c4-08deca967f43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|10070799003|1800799024|56012099006|4143699003|11063799006|5023799004|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Fr/et14eNcbrgjYmoEtuB1/3Bcdy9trG3/6HHio67HLnrZKAhWAWpXwnc61vYHRTZMK0jyIvHDSXEcWH4lyftMF6UqlwlcQa42ejQpXYYATGcNlgMtxhk4GDBBeRjf8GVVXea4y4rrbJr8EgYRUJUIrTK04j32UGTp38PrdQpb6lMaoeKD27RD7xm+RX65Zhae0ZsrP0vyOFvWOI6EnYoYcexCUouuxWhxRHSbIpryNhvRSkpO1eLaLrgEc2RQ+KVYYgHXX7sLbWVdN5DWXJnzdcdRoaExmby7WHl9xLCsn3qEMR/BErfw4NcqZbCLAaphEUZn3Sl5YkAWpz8VR43oTe4cocgC0bVdTHwPDxyfdeAd1Ru7QAazb3eBABYdZlck8bARi3GzhkGptuAz9SaXt81zarZUcDXW0/reIum8p6i+2G3tMPIhrOtpLDItD01xp/VNhBh5Pci5pwYjCSiHT9rWlLXZk0teJDH8l8Kgbb+gQfQTLnHK2jiMp+bC2GrfUBsdV3ehvwhF1Ehmc/65IRgj7nMHsGmw201YCxZhVpC59R6J1hKrlychW/ODniv5KiMznwBT8G4nQb+mE9XIgyJUeagnPnQJDTpWa+d6/JXcD+BG5POZNKm7wFbqHQimg95Jpg3dLOZxpwLkgZIeNNn+9Etb7/sP9lSwGoUI3GQzQnmlhHsEIbEgj6WXfD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(10070799003)(1800799024)(56012099006)(4143699003)(11063799006)(5023799004)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzJxTVljWVJaMEE2eGFVdkJSeE9JNy9ZUHR5VDZLK2RBdzdCYjBzd3ZGZlpE?=
 =?utf-8?B?YVNFYzcwYzZmSGMxcmtGT0Qrb21DdE81OXd4OHY3WGNUUmVORTF6VHhWdWRO?=
 =?utf-8?B?V0hoTHhtd0U1eVJEaGRaZ3lBMGZNSmkzK3pHS2VwRTJJYU5Ndm1tQkp1Y0Vp?=
 =?utf-8?B?SDEwQmZ6TE5FSnYya2p0aVkveTlaSEZrSlFaanpMM0NSeUN2N3ZGVGI1QWVP?=
 =?utf-8?B?ZmdySWpZNklQOWNPeTBydEJ1V3o1V0ZxUXVzL1BqRk14dnBsUjF2U2JWWm5U?=
 =?utf-8?B?ZEJTcGI4dFR6VVV4bU1VUUp0N1VuUnRVZzFCWmpMaHBQS2RUYk5CMmQwdFZl?=
 =?utf-8?B?ZGdRaFZYNm9vZGtSR2FGSTh2N1h2WW41bkRYT2lVQlBGdy9qT1llcFdEc1ls?=
 =?utf-8?B?a2lpWHNFVVAxNkpTcmdkTVBsa2Rzc0V2VWQvU051N3hLZjBYUzhUdnp2WkRx?=
 =?utf-8?B?ZDV3MTJPTmRFSzJPem1BQ1JnWWpSNDNpbEROTUFTTVFyaTB4SXIyRFBuSmJX?=
 =?utf-8?B?bm8yVEZOT2NRNklkTEVqLzlPQ1ZUZEJ0OU1saGNha2dCK2JHTVlsMmRSVzhT?=
 =?utf-8?B?Vk9wZklPSUhqSllCNGN2SGVaa3UzZUpxcUVaUktNZnUySUhyWThPVzN4aFhI?=
 =?utf-8?B?OWhld3daNWZBUHBjTGdJcE5ndEdvQ0JZdWo2VG9IV0pHS1VKUkNkd2NsRkli?=
 =?utf-8?B?MlhWVks0ZEhTNzdFVW5iajVqQkpuRmtmVHJnald6MFRFaHJ4L29HaFdxN2Q1?=
 =?utf-8?B?UFV5azFTbnFvYmJTZ1lkZkpuV0dXV0dvcnRxSWhrWEN4YmNHTWdOdDdUQjhz?=
 =?utf-8?B?UG9NNFpxL0lOdXRwWmpDQ2tpWDZUQTVJclh5VTMxYWxJQjZOT0lxVW96UU1y?=
 =?utf-8?B?cVVNOXZabmtiSE0vU3VnUWNIYkZSZWtzV205UG5jRzIydmIwVnBCWHhvRk5U?=
 =?utf-8?B?Y29JWFFYYlBQemhHMEFXMURiQXY1M3p6eEF0eUF2VGlQQktUdHJoVnVCQnIz?=
 =?utf-8?B?WjJ5MGRNQXhPOGhsejJUWXdsUTFZZllxYlB5YUlYdU50Tk9zMDJ2cEVHV1Mw?=
 =?utf-8?B?RENlME9EYTJiUDgyQktwb1VUb0xYRXJIdnp1TGxyRVlpSlIxTVZvZThnWmZp?=
 =?utf-8?B?VTJ3VlZKVVJXUHFMa0VlbHB6NFlmTEhMRGNVeWtBMmZlcDhSR2Mxb09zMS9D?=
 =?utf-8?B?UC9YWWNUMjdRZFp4SnhDVVhkMmd5R2N3clRvOWdKcDhZYnhrUytHV1FuRS9Y?=
 =?utf-8?B?YXYxV0FGYmp1d2c3cnFVenFTOWFGU3gzMlQvMVdTdHUyT0UyTmRibTJzOWFj?=
 =?utf-8?B?VlUvamR4RC9WdEc4cnZISmh1TlVkYXNheXIyYWNmMVEwVWRib2J4d2NyRWdo?=
 =?utf-8?B?R1FRZml3OHJsT2NzK2VnVW03bFFUKzk1Ylk1blU4c3p0VzVUSnhPci9vMWVU?=
 =?utf-8?B?OE1ieThFOW9YcmhzNEtrN3hJVzlrUnpoRGh5TFMyOGI4cmV2UWRWRHdYcCt3?=
 =?utf-8?B?YTB2aW9wNXVQRWtyZXVGcjVSSmVvS1Y0alBmeEpKdisvTnlxU09NL3I3OGxL?=
 =?utf-8?B?WVJuWGJScUxyL2FoOFBYUkhvcDVhM01PT1o2dUkvL1A2b29iMzdsUDg0VkVs?=
 =?utf-8?B?d2RCL1dMWW45THE2elhURFhkcWZCRUpGZ05PcENTM0dhaS9Tb01zOHlPN2w3?=
 =?utf-8?B?WjlwTTVOb1gvd0ZuZUxqTWdxY0tDa0lMSGtqTlFjazhtaXNTak5xWFltMnpK?=
 =?utf-8?B?c1BabXNLL0NGdHk0bU5kdDVOMUVlMTJIR1FGL3JEZU1qdDh4clhXWHdYclVa?=
 =?utf-8?B?dlA2ZG1aSnp1MzNmSERBazk5YWJZdXJtV3dSc2lTQmdNRDdzZVhSNWIzMG1t?=
 =?utf-8?B?eWE3T3FDb1hFN2Jkb3RxTnl3clhhb3FzU1gxWGYxY3oyU1FMMXNEVll1Rnpl?=
 =?utf-8?B?NXk0YUxkZUlWZ2RXWlI5SG9UQTJoNXVmdzdISWtCU01GQTIrK09kTzZqNVdU?=
 =?utf-8?B?ZVVBT0lGZ3VsSWNGQU1xa3lka0h4M1hGTnVPT2NPK044alUwSm50SVpQY0kz?=
 =?utf-8?B?MDlSYlhPSjFjOU5YNUdteVpXZi9BaU4zUDRGU25DTEVPTk9MOU5ZdHNiSmMv?=
 =?utf-8?B?WnArbVhKUHowbStOdG5iaTNGZFhYb2RlbGV2VU5Cdm0rNkpzMnVWMmhKOGt2?=
 =?utf-8?B?TWdDRVRmQXM2R0tYL0RqemtxWTdPNWJxMXpkMmJUTzM2SlZaTXFjSlhOQVZZ?=
 =?utf-8?B?UDJSK3hKNkxZYnJkKzNKWTFnNjk1MVdCMWRUZ0V4N2FEZEg0Z1ZLQ3JXTFI0?=
 =?utf-8?B?N0N2N29GQVhxMlo0YXlZY0ltNk1DWUtlM2o1U0NhV3F1d0dKTWQzNFY4TW9h?=
 =?utf-8?Q?dBs5QMvZDnHmBpkOf6CcGEXOKpUickXa+WmgI7VJl7vf6?=
X-MS-Exchange-AntiSpam-MessageData-1: KFjM8rSwGrHoBQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b854fa2-9f14-4579-a3c4-08deca967f43
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 04:28:06.5382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: poHMNo0TA9tIxTb0VFajrmvFdDVS7DjHRUt2TOUrpbhSu2ekis7YEZ0a8nyNG+fI4qR5RpW3TJEwlHvjJyLIhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6366

On Fri Jun 12, 2026 at 1:28 AM JST, Gary Guo wrote:
> The current safety comment on `io_read`/`io_write` does not cover the top=
ic
> about alignment. Add it so it can be relied on by implementor of
> `IoCapable`.
>
> Expand the check `Io` by taking `self.addr()` into consideration when

"the check performed by `Io`" maybe?

> checking if `offset` is aligned. For the compile-time `io_addr_assert`
> check, check using the known minimum alignment of `IO::Target` and the

typo: s/IO/Io.

> accessed type.
>
> While at it, fix the alignment check to use `align_of` instead of
> `size_of`. The values match for all primitives (including u64, given that
> we do not provide u64 accessor on 32-bit platforms), but are not
> necessarily true for custom types.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/kernel/io.rs | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index bef571dad6eb..fa9ae39ad9d2 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -196,13 +196,14 @@ pub fn maxsize(&self) -> usize {
>  #[repr(transparent)]
>  pub struct Mmio<const SIZE: usize =3D 0>(MmioRaw<SIZE>);
> =20
> -/// Checks whether an access of type `U` at the given `offset`
> +/// Checks whether an access of type `U` at the given `base` and the giv=
en `offset`
>  /// is valid within this region.
> +///
> +/// The `base` is used for alignment checking only. This can be set to 0=
 to skip the check.
>  #[inline]
> -const fn offset_valid<U>(offset: usize, size: usize) -> bool {
> -    let type_size =3D core::mem::size_of::<U>();
> -    if let Some(end) =3D offset.checked_add(type_size) {
> -        end <=3D size && offset % type_size =3D=3D 0
> +const fn offset_valid<U>(base: usize, offset: usize, size: usize) -> boo=
l {
> +    if let Some(end) =3D offset.checked_add(size_of::<U>()) {
> +        end <=3D size && (base.wrapping_add(offset) % align_of::<U>() =
=3D=3D 0)
>      } else {
>          false
>      }
> @@ -221,14 +222,16 @@ pub trait IoCapable<T> {
>      ///
>      /// # Safety
>      ///
> -    /// The range `[address..address + size_of::<T>()]` must be within t=
he bounds of `Self`.
> +    /// - The range `[address..address + size_of::<T>()]` must be within=
 the bounds of `Self`.
> +    /// - `address` must be aligned.
>      unsafe fn io_read(&self, address: usize) -> T;
> =20
>      /// Performs an I/O write of `value` at `address`.
>      ///
>      /// # Safety
>      ///
> -    /// The range `[address..address + size_of::<T>()]` must be within t=
he bounds of `Self`.
> +    /// - The range `[address..address + size_of::<T>()]` must be within=
 the bounds of `Self`.
> +    /// - `address` must be aligned.
>      unsafe fn io_write(&self, value: T, address: usize);
>  }
> =20
> @@ -310,7 +313,11 @@ pub trait Io {
>      // Always inline to optimize out error path of `build_assert`.
>      #[inline(always)]
>      fn io_addr_assert<U>(&self, offset: usize) -> usize {
> -        build_assert!(offset_valid::<U>(offset, Self::Target::MIN_SIZE))=
;
> +        // We cannot check alignment with `offset_valid` using `self.add=
r()`. So set 0 for it and
> +        // ensure alignment by checking that the alignment of `U` is sma=
ller or equal to the
> +        // alignment of `Self::Target`.
> +        const_assert!(Alignment::of::<U>().as_usize() <=3D Self::Target:=
:MIN_ALIGN.as_usize());
> +        build_assert!(offset_valid::<U>(0, offset, Self::Target::MIN_SIZ=
E));

IIUC this can allow unaligned accesses if `self.addr()` itself is not
properly aligned. Do we need a new `Io` invariant for that or is it
already enforced somewhere?
