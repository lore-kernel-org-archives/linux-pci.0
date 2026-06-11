Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020141.outbound.protection.outlook.com [52.101.196.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A29F368D7E;
	Thu, 11 Jun 2026 19:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781206616; cv=fail; b=g6F4kIPxXDAwRVR7I77noKHyiQiyVnZ95upeRRLCA0xRHU6K5WAqRy8x1zEfnuQWTeJdmHJ2jMckyXiSMfHlFBKHYStGew4j/IycbJMtslfCSqHzoMVg7/VEHrJQSvHj7c2NYA6jmREncdrVRKV+i2QhWcvBHphIX0CEbLyEGHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781206616; c=relaxed/simple;
	bh=umlLIfSThqNTo6Chrzf1pZtYtXyiCje+uzCZYJmK3vY=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=aUptnyteLRM+sykAsUzxorjAPN59m6mJ0p4HpQlHGe7igdcGd60Tq2jLY/Yan/WiKwvjRLqb4siY9LBP15L0QqAc6KbciRTx6R+kZrHDJl+GiZ9KI3owVZ69XXhHqv73Xd9rTm9g50rg5DXiy2LZASwFBNwAMwwFi+5r5WqIKBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=QNg0HkIw; arc=fail smtp.client-ip=52.101.196.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="QNg0HkIw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=loH19zHG8lJPKTvT2a+51mdxKlq4T/Z987AbwXEG1DnxCump5p7Ywz2h2s6GdKOOfCwnLLqtNmysFwk7xZgkQLydiI8lMH0US45yNhazFvhrv+17yh67WAPlOMX7WOnjp/7un5q+UnXFDxsDuvwqX4jfNQdLZXtMZXTZWYdk/MIfnloNVk0xWfoSg0ADuLxqEcbLT8ADzigKfRvoV02/Xej2849JTfV7cRjgLkeN7IzLXw8SlWih5H2xgArPdOdY8baj4lGYCsMIZNCULRWY4hWDX4b10ZWrI6ZUI4oWg3lLIuHob0fOoSxiGLFVVsruZQ0WoGosLgecz4cdArBLQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eY0KzQw8mCIM26rAhDs8XrajWUnRCEhoDp2y1uSOuGQ=;
 b=Lg6sJj6iPXLQA9mcLGH9NM/WB4PKruxz1Q7CTJVbxq/hwwz4lH9d2Y9O7m3UnMdawVGGWBxuTr9ZJei8wbcbVosQVy9nKUJYKyePw93+D8zHa7Z1T+KDzMqrTJruFXum5TI11+/j4uWjFfQINnYIXWgsxQtOEuLq3dHQdgjxljTtf06VVXQhG4u/5Z42/eem4QXRbAhq4ZIBPejjjYG3oySohl5A42grdLraFkb/aVS94WqYaDrxyYMaExp4HiOXG6FqEGf+HlKsVS5subE7LRRc5MF8FcCXHhssuu5Q1kzJY/Nj0mGL8LPFDXwjLrzLmZjb9gcG1B5xbUjqp6XPaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eY0KzQw8mCIM26rAhDs8XrajWUnRCEhoDp2y1uSOuGQ=;
 b=QNg0HkIwIK/QBU0eGhTDdeLyoA2nij8fxUy/cHqfizIpARWNxheVEcE7khd2yr+f43JFbmITBAWqfWbr1PXPCWDMLjSYYYtWyGsLDe0NJzb96JYU7GZznPjkVovbkTyiEEmzVBa/ok4vp9o6lsI1O1XAVrmq8zuqZxFzyvkQ71U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by CWXP265MB5702.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 19:36:48 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 19:36:48 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jun 2026 20:36:47 +0100
Message-Id: <DJ6H1N4T9A9Z.9OX5GX0CEE0Q@garyguo.net>
Subject: Re: [PATCH v4 19/20] rust: io: add copying methods
From: "Gary Guo" <gary@garyguo.net>
To: "Gary Guo" <gary@garyguo.net>, "Alice Ryhl" <aliceryhl@google.com>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Abdiel
 Janulgue" <abdiel.janulgue@gmail.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Cc: "Danilo Krummrich" <dakr@kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.21.0
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
 <20260611-io_projection-v4-19-1f7224b02dcb@garyguo.net>
In-Reply-To: <20260611-io_projection-v4-19-1f7224b02dcb@garyguo.net>
X-ClientProxiedBy: LO0P123CA0007.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::16) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|CWXP265MB5702:EE_
X-MS-Office365-Filtering-Correlation-Id: d16e8135-da06-4dea-911b-08dec7f0c75a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|7416014|10070799003|1800799024|921020|4143699003|56012099006|5023799004|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	PgxJ8+RRZCX34yHQgvd1vWMoIiYtc0Iyj2Bp8i+wuEM0Z2EQfoHTPNa7R3uLLSXQ5gwcpyjEez2hGgRih28qjl3T0diF4F8OCzzL6B3Ujvx5twB/S9QR0wVTTORMV7e+5Ui2ASePh0E/Fnex/dWekI/TnyQY4brLeNI/WmmjTFr3mHh0Jvbx7NYtF59YkNhNGZ4yol9sCgfiHuiQnKSIyF2yJv/BHhqwwEvjOQa6yKtQVGZndQpe0/oWu969Y3/ihaEpblUo0S1K/dCNnZT7uKGYIab/321yq/Io6IZHP1Hp3bQUwiTE+ccDWyhdJu1DCsqZ3xW72cMrjAMJ2EGALQkH8TbpmlXKw0Yj6C9bw5bcVEgLSu008YdTSrsPqSPF1e2GVarl4jYzu0ZV0kYfVekNL0JvO1fl3cWe4TGcs6P/hga7vk2vYwGFEm8F9KgbB3VSZutV6XGIYQWPWK+Phj08j5uH/WpgYN0nJxzR6LoQyqlxZz6l4zh+37vFtQ4eJ7VqEfntuf02afYAzynmznod3y3ThyaqhBuhXblRp44glNs+HUnt/7y2Fn6BUcAbTvJXiNSPx2dfRsucEtRtnRTxoX+CSBDnXFsBqZ3hpU+Kp4FPtJ1rhMhEyYlR3BWfwfATwXInoR6qcllVBL6zVvecPo3AwfuQsnRKgfX1xcrxWmrVVueNrylZSrhKVg3vaQXW3YYk7GoGeIdHPN94f7+uSGh7kcDFuIAJMWX92FY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(10070799003)(1800799024)(921020)(4143699003)(56012099006)(5023799004)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnMwUWlNRERYYTFRUVZqTmFmbUxHOTNCOGx5bFJVTldSbHFHSldraGdLTnlO?=
 =?utf-8?B?UU9hall5cFVJWU5aMWpyYTlwWkFtSlF3ZjRXZUp2VUkwQnhvM0JTdG9KSXAv?=
 =?utf-8?B?S2JjV25QeEtja1cyZzZLNFpZaFF2TENpSHlPZU1KYzJDdmJWZTUzQU41aTJO?=
 =?utf-8?B?ZER0ekFyUk95cHRXREk5cXZlWTFQZFFtd09QMHczY0wyeHBLT0dDeVhXbE5y?=
 =?utf-8?B?VlFHS1hBWllGT3R2K3BMcHdEdk5MejlIamFyS0p2NzNDYjNBNVlLU2ZuMXRW?=
 =?utf-8?B?ZXEyVkI2NnJZdGhoMHFGOC95bHpPOW55aDQ5cXpMQi9hb0ZGei9ub1JTWk1R?=
 =?utf-8?B?dHZnTDRuOURZZ0Zza1FkTlkzL2hwaEpYaEdzTEtPeWhDQzNyN01GbjE3Y1dU?=
 =?utf-8?B?dUY0c0x5Rm5QSDgzd2YxRnpDQW9qWmNFMHNQY0xJbHBhOWppVkN2eENaQ1F1?=
 =?utf-8?B?MDFIcVRpK1V5UTFTSktUVkpTNmRuZ3BZZG1nUEdtRUFJTHQ4SUd3Q2RZT1BO?=
 =?utf-8?B?dWgvUXY2NUp4amZkODlOb0ZMcTdJRU9XTWNuaXc2NTc5SjczdXhwN0dIc1dr?=
 =?utf-8?B?SUpxQXhKVEY5S25FQWNjb3lqUGNPbVpaK1B1UmFleUpPZW5qYW9VV2lXeHBa?=
 =?utf-8?B?aDd0TWxuV3VrdDdQYUdNSGd5cGtlMWdPSFd1emhaU3FubXpqbWFKSmJudlVY?=
 =?utf-8?B?MGZ3YmhxdjFmcWpaS3RlZTI0Y3Vxa0t6MU1SU210MWRLUTkzMHAxOXc2QmV0?=
 =?utf-8?B?M0hYMW1GOVRBOEVTWlZvVFE0RXhsd0JncHpCbjhwcThKcFROcEI4d09XMkVD?=
 =?utf-8?B?dUZuK1Q4aEVPYngyZjhFbmU0eFR0ZlRTeDNyTU5ubllpdDJ2NEZ4OFFmL1lB?=
 =?utf-8?B?MXlMUXFPOHd2WUdPcXAvWlBiWFkxRmFJMlhZWWNoZXhSRzlUdXByZy9iWHFv?=
 =?utf-8?B?MFRJUUxuREJ4SFpReXgyL2h0OXJVZVJ0Z2Y0Y3FwS0p1Yzl4VlpnZUNEd2s0?=
 =?utf-8?B?R2hOdmhRdFFYblcvWFM5UVBFNXVpR2szdlpZdTVOZmxxMENrM2Rrb1Mvc3Fv?=
 =?utf-8?B?bmc4R0hzSEZiZUMzOVgzb2N4eFJzOXhNUndlaXpyWHVKbnlHdCtuemM3b1lR?=
 =?utf-8?B?ZWFoL05OTTdZRFVPVlpCSjRvTUVGR3duVWF2eWVOYmNpNDZOMU14bmFjZDl6?=
 =?utf-8?B?TVNWWklQYVRSSzArZmZDTlIvWG1Xck9oNWlpRENqOVJNcXNKM2t3dkwwbFVn?=
 =?utf-8?B?UnVXQ2xYRTU3Y2ZnWEJDVTdzRENDVnI5Um5RNWRSOXJXYWJwZzBGZ1hrS2pw?=
 =?utf-8?B?TkdTUHZWd0owM2pKOVdyRWQ3eEFkKzBpTnNFVE5KK0NnN0NHdDhSb0NBUWZw?=
 =?utf-8?B?ZmE3ZHdlRnlUbWRoZE9HMjNJMFAxT294UGxuSS9jTWI0TTRPeE1EMUFacUwr?=
 =?utf-8?B?L0tOeWs0UEloOVo1K0tZL2pUWDhzSmRjeHJiWnFmNGU0ajcyYzJSbnVBSzcr?=
 =?utf-8?B?NzdqdXBiYXM3TUtuc0RWV3V0R1VvSGVRVktYMm1RaTRHSUV1azQ3UFZBV0RX?=
 =?utf-8?B?TElNMGcwb0lJY2VpaURVa2JFQng5cDF1QkZySnpCUS9jZGJsZnI4RWxpamJy?=
 =?utf-8?B?S2ZBVndOQ2lVNnhvajFkQzUyckY2T2x2UjNINk5yS0xOTlJFZ0NQR1lpRHhO?=
 =?utf-8?B?L2hkSkVrdjJOU1huRHplczMwcGN3Z3Z0RUM2UHM5TU9GNUEyYkVHSDAwQnRJ?=
 =?utf-8?B?Y3A3MlNEMGszaThLQWZSVllTbDd0U2d5UkJ2VVNrQkFUcWR5enE2cUtsL0pZ?=
 =?utf-8?B?SSthNHpPK2Fqdmw4MWlBV1dtWThoajg1NDJwUnNFNlU2eU80TWxKZWNNd1dZ?=
 =?utf-8?B?c3pnbTFEKzAvbG5JWWxnK1dFUlRXSHBJRllOK2txM0VKcXZpdWU3MGlxa1gw?=
 =?utf-8?B?Vk9pV1ozcGtMNlJoYld0d1daNFBXeitKYnV0aTI0M0JkY1R0aFJXNm5OSS9Z?=
 =?utf-8?B?Z0FkNGZXTWVGTlVIbmt2cHJzUlNDZWRqMGE4ZGpyU2ZYUnV5L1hMNDNQWVFm?=
 =?utf-8?B?dDF4dGwyY2RMaEFSWXdManZEc1lGQjV5bnQraVhpSEdrbjJIQWxLTWZZb2Fy?=
 =?utf-8?B?NWo1TnNmOWk1RTdiRUluVjk1bXI0dmdKNUdSQ0VsZzErVWdGUmIybDlTRHlL?=
 =?utf-8?B?dFErWElMSWlZT1l6bkd0YU1rZkxPZjUxS3RTbWdtOEpUdDVOeElaaDF0bnlI?=
 =?utf-8?B?TnJ2WmxYVnUyOE55dWx0MldNemtzdzNuUDdDM05IOHZaSVVkcnZZdy9vV2g4?=
 =?utf-8?B?dk0vNXJiQ3ZrUjNvRjV6eVBwVzU5YXJTS1BBa1h6WjBjYkg5cmViUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d16e8135-da06-4dea-911b-08dec7f0c75a
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 19:36:48.4975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hVM07xRLu7QtzC2kszVbU1EbDdQ6sdDq1ffIfL0Yd1Kmt2s7ZOLoBNGgG15YDoyLKlJWhWTRXPXi9EBXC0ya/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB5702

On Thu Jun 11, 2026 at 5:28 PM BST, Gary Guo wrote:
> One feature that was lost from the old `dma_read!` and `dma_write!` when
> moving to `io_read!` and `io_write!` was the ability to read/write a larg=
e
> structs. However, the semantics was unclear to begin with, as there was n=
o
> guarantee about their atomicity even for structs that were small enough t=
o
> fit in u32. Re-introduce the capability in the form of copying methods.
>
>     dma_read!(foo, bar) -> io_project!(foo, bar).copy_read()
>     dma_write!(foo, bar, baz) -> io_project!(foo, bar).copy_write(baz)
>
> Model these semantics after memcpy so user has clear expectation of lack =
of
> atomicity. As an additional benefit of this change, this now works for MM=
IO
> as well by mapping them to `memcpy_{from,to}io`.
>
> For slices which is DST so the `copy_read` and `copy_write` API above can=
't
> work, add `copy_from_slice` and `copy_to_slice` to copy from/to normal
> memory.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/helpers/io.c        |  13 +++
>  rust/kernel/dma.rs       |  25 +++++
>  rust/kernel/io.rs        | 238 +++++++++++++++++++++++++++++++++++++++++=
+++++-
>  samples/rust/rust_dma.rs |  15 ++-
>  4 files changed, 285 insertions(+), 6 deletions(-)
>
> [snip]
>
> +
> +    #[inline]
> +    fn copy_read<T: FromBytes>(view: Self::View<'_, T>) -> T {
> +        // SAFETY:
> +        // - Per type invariant, `ptr` is valid and aligned.
> +        // - Using read_volatile() here so that race with hardware is we=
ll-defined.
> +        // - Using read_volatile() here is not sound if it races with ot=
her CPU per Rust
> +        //   rules, but this is allowed per LKMM.
> +        // - The macro is only used on primitives so all bit patterns ar=
e valid.

This line should read "`T: FromBytes` so all bit patterns are valid.". I co=
pied
from `IoCapable` impl and forgot to update the comment.

Best,
Gary

> +        unsafe { view.ptr.read_volatile() }
> +    }
> +
> +    #[inline]
> +    fn copy_write<T: IntoBytes>(view: Self::View<'_, T>, value: T) {
> +        // SAFETY:
> +        // - Per type invariant, `ptr` is valid and aligned.
> +        // - Using write_volatile() here so that race with hardware is w=
ell-defined.
> +        // - Using write_volatile() here is not sound if it races with o=
ther CPU per Rust
> +        //   rules, but this is allowed per LKMM.
> +        unsafe { view.ptr.write_volatile(value) }
> +    }
> +}
> +
>  /// System memory region.
>  ///
>  /// Provides `Io` trait implementation for kernel virtual address ranges=
,

