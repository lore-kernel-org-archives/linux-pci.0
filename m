Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012018.outbound.protection.outlook.com [52.101.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A0030BF6B;
	Thu, 27 Aug 2026 06:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787811873; cv=fail; b=dT+JEzTg2G5U+t7Aidd4NwU1djFDQ1sl1Ln1h+w97l5jiwVPHUJamHqD/qevYnANO+jPxYQFzkPIKtiF4RdREYlafjN33ztjft2Oqv7VY8k/3RHTv3vkoUVLBBixoaNxMzZN2wOH4EHMRxeXvN98l7s1eVc0YfGZGBdWx2WiGqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787811873; c=relaxed/simple;
	bh=jJR+HtMT5FXK2IBIfWQVakh0QOuSp93yL2NoRBNlwik=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=ELj4nFwO2mkO+5CkVxhVYsF9KpEy1QK6k/4lk2cfQpumHF2sy+BMVC8P4aKvnSYn+zo4ko9iMfFVKzPvru8zb9xYALliB13jJAnakiAvkFKVjwrtfgnwHMEBnDwOpNgPjYRZ/2VLLXkUgVDAauinEofKWVpMIB8GzqqKMs1Bv6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X4hyt/xL; arc=fail smtp.client-ip=52.101.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X4hyt/xL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jaDHl9VEJFaX/4wgCKLZMre4B7F02xrGg472Hu3EYp1ZRbeWpzN96T78fMEcp6ebgnuYG0mABTcHLIfP9DWnrey9kXrBqWrwbipiOCeoN9bT5w4MtuclnYlbJ4MaE+792bW3dwSl5OaMYC5teEYlU+2RxAKf2xfy9oIAeqobPWrWT4zVp6bHolCaT73leEpyd5hMkfinI7RSLM4siJzWliY0fYccDk9ouExrdXUg8G3RkQYwRqcIXp9LaXCgbifJQj1v48uN4MgcvU8M4zHoeJ+iva54JRwitfkiB3nzRY47ZIg3nwaR/p/QH45EVgYTbwpMO6MufqaTOl986Y1GBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMfAXtGOmdkBrRjXzTNqbskVfiu0TIy/bnPp84Tp+2E=;
 b=OtiJx2VKZZH5E6i3bSjSFfsjCnb6syv34vsUGEyxFosUbnQYBSNiXt0vFQ4OYb+vk526yrMvGz0nOJusPWMlJG73t0V1j1BWOnZY8qtGKu7zcqamINfD+be6HHxGx1Pzc9W2I2iEtpkv5Guz+Cg20ra4aO7Z55XFoYrSgjrTx60X+PMj2Znm1nOsk8YtO8PZKA8oRqTa+crlvAMAiYVzU9Ze5KcZPxDJnIwwGEg+m9woQL9WfmjWkvfrRuYHMcMi6Tx9ZCkbR+BQjk8+Jcv8cSQTVYAhPEP1kq/OEGy4VbX8mxgcYhs6a5pmBpqkjCRSfgnXiRbiC0tqP0g0vVLzYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMfAXtGOmdkBrRjXzTNqbskVfiu0TIy/bnPp84Tp+2E=;
 b=X4hyt/xL1MC9tCAW/CThZEGY80scUgPeCm7trJEa82eYcpeg7hvB1UOao9bZraF7qP+eN9RKuYAQLOCQj8ZQ8hpB713+IZJR5QAak5bVbwKTAjDhPYYijd8pBXvD5e0VsLBdshpXL9YTSThaSEe/lzkqB4SZU4mZSJrgVisM8OFsTQyl/joJoLfBkzJU3bf+70b+HLx/dnczWBQVE+u0d3ZjcnleVJ+bZ1Ek2a1ov4vSQAUgXSFGLYhNVPnbO8fliyfEQPnrw8ZRjSjZcElxUqqnT/tCtgrDDi4AUn9G+TFPcqpYHi/rc6H0ssKN+Sicuzw1CwbuPDc+OON0iJLtyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS0PR12MB8272.namprd12.prod.outlook.com (2603:10b6:8:fc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.10; Thu, 27 Aug 2026 06:24:26 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Thu, 27 Aug 2026
 06:24:26 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Aug 2026 15:24:23 +0900
Message-Id: <DKZIEVS56DGW.1JSQZAO4SGPMW@nvidia.com>
Subject: Re: [PATCH v3 02/16] rust: mem: add `transmute` with deferred size
 check
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
Content-Transfer-Encoding: quoted-printable
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-2-3699a75fadf1@garyguo.net>
In-Reply-To: <20260819-typed_register-v3-2-3699a75fadf1@garyguo.net>
X-ClientProxiedBy: TYCPR01CA0152.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::6) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS0PR12MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 67cadc69-6602-4ed9-16e8-08df0403d7d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|10070799003|1800799024|7416014|376014|10067099003|6133799003|22082099003|18002099003|4143699003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	UEtD8qb4srRppayvqZH9LVTSrm31br9NhkD22bkXXK/7i10YHUO9sdRjf/HNn46rtPi8s2ao4zKRtAzqyi2OJnhcdcOWy+abOYsx3ISOb6oulHvTXyuS1u37hlzewLBcjgJusugjEG0dpQel1zVbt0axOdbtGqUBWJzZJfomEqsBKZN/Wt+Wkj+jz2FnXY2I/zI2tI+gV2xNDr7DUt1ssOT+efeDf7poeQQiCT9KCVeWXWx5cNdzjKT1BVi9sPo/vNAJQ+j1Zs81o8IzlmKSywE3ksB0sBVZqgGy4uTmqhUV8n+xQWUbsGQkZYpr1t3pK0k2esFEqNwVt0KFBbUzJLWl5Md/RbaeToEUI80CECVY0RL/2ueQ6kE3lKyeBek7cpCnXbGbuoxSjWVQ41dSDv1gQEzUOayf5r8J1fT3Lf+ZLx23exeMAtDgAMZ/Ac/QRYzYDusbr2NRPyLsgtSZCWdbcGyyHxghgugfq9dWY4CSpnc5K312ct+iZmVrTuz/avVX/I6KFnUAIdPIO3M2GOggG5mFg+B0zfLCnMXuAnozOzTFV5tb36g8j7orADzBpoSoGXSf3BLBvLZX6PL4ZeWCiZ0+12CQj2dg8Db+i1PzcjEUmqd9KYwxBYIBJ1j0lXTUbxajQRbuAqWd7zTgpTzynxj710vAcvxe7fbxxhc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(10070799003)(1800799024)(7416014)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDFSZVc2angvZUl3amdDdTVqbzNYeENDQ1F0VFNycWtVQ0VPNkZIZ2lBWXp6?=
 =?utf-8?B?d3VmMVRZM21XZEY3ZFgrVWp5ZnpzWFZFL3VqUzI0c2FRL20xYnhMTEZxZWxv?=
 =?utf-8?B?RlJiY2VUNGRXckhNQ2RyQ2ROVjJTV1IwUGNDVXVaUHQrYkdITWUweDcxVzZM?=
 =?utf-8?B?c1VVODI0S3JpUE44d3JZeDNySVA5K3ZkcEdpa3RXY0N3cEM0OW01amdVS1Uv?=
 =?utf-8?B?b055QVF1ZW5NcFVkKzJhczFXVXJrdGEvMjduanZwdENINUJXUVJYU2hMeUlO?=
 =?utf-8?B?KzFiTnlFd0kxVWNiRnpwWEl2VFdJOVVodnU4OWVnWTVVdEpraWE2VUpob0ZQ?=
 =?utf-8?B?Z0YvRmsvZllPb3NIUno4Q1dPbHdSTWt6R3V2UTliMlJKZnRUS2N3REZrMEpR?=
 =?utf-8?B?LzVNNFVSU0N2eUp2NjIrNERtOTVnWVpaOTVjVUlkbjUrNWNTelBIOC9FbEoz?=
 =?utf-8?B?dmlyTTNweUNWbHhjeGV4a1BqL0V6eDZOTzlDVGxnaENLQ2NhZERBblplTkVQ?=
 =?utf-8?B?eStIU3cwZnM0anpoUkJWVlNnaHV5cDBlYXFEcThKUHRSMmVneFVVKzBzVzRj?=
 =?utf-8?B?UE1OYTNZUlpGWXY3djR1d09JMU9WaFQyRzY5WlBramlCc3gyQjJDemNXWjgv?=
 =?utf-8?B?TWVUdHp6bkJ0S1FjLzl5VFBJcTdDRVJaRnhDSHlXY0xRU3pUV1hJQVZrRkY0?=
 =?utf-8?B?TE83SFROQVhETWpZVTNuWTZNTCtOQkRvU2NuT1k0QVFPU091ZUE5RDVjaDVx?=
 =?utf-8?B?c1ZHRDlrY0xsWC8vbDEyWjlPM29zd2RKTFN5NHd3YkR1Sm5IWVRpTStWakcw?=
 =?utf-8?B?NXJPRC9wNmRzRERsOTVLdFMrdE9DTnNrK1RPWEVZa3FEeXFFcmtucEdKTGdu?=
 =?utf-8?B?SHNFZ2M2QStvS0V0d3VlZjNyRFUxdHZDVW1qQXZMNklCbUxXK29TaWdqaVBo?=
 =?utf-8?B?Z3JLaHBHWklkL0ptUURYWER0clJaWmdwWDlPUEJPZk54WXV0K25EcWVTM096?=
 =?utf-8?B?U0ZTL1VSQ1BDOGtodElZdUxuN1pTNjIySHZmclEyMm5QMnlBcDFaWDdCOS9R?=
 =?utf-8?B?MlVoNGNYYk1SK3JZbjZhS0gyTjg5RUFoU0Jlc09wNTJsTjNyeUp1akJTZ3hz?=
 =?utf-8?B?amdESlVPVTI0eGE0UXFtR2lCVVc1N1VRUUpTNVRhdjZtYXk2cjY3Q3dmS2o1?=
 =?utf-8?B?SUw5OWdjUTZlWU1jYWk1Q1R4RDNxSllod3BNVGIwckpqZjRobVRNdE9GZmlu?=
 =?utf-8?B?TTJMYmpyTXV4Y0d6WjdWeGlSMnVYOWpHNVlYbURxVFlIRE1PQ3JQSmR0V3k1?=
 =?utf-8?B?OWhUaWFvYVl5N01ETGdZdE1BYTF6RlJ2SWpPb1JuWktocU9Ddmw1ck9sZTVz?=
 =?utf-8?B?cmpJWEN5bUF2ZVpUeHNlUy9taFl6R0VzcXRkMUN2cWRYUU51Y24vRjNDbzR5?=
 =?utf-8?B?TXRrM3kzaWthbGdRL1JUTU9MMGdSZENGTjVISTMyVGpmY0hFanJoRzJsQ0dh?=
 =?utf-8?B?Q1MrS0o4M0w5Z3RzUjlpT01DVWhsU0ZiRmlYY3p6K1p0OU5WME9ZVEFNeWpr?=
 =?utf-8?B?Qjg1c09LeW5Kek9PNXZFZi9VR01iNGpPY3dJMkluSDhhREsyOG55VUNZaGlN?=
 =?utf-8?B?NTI0TEoydTZ3bVBWWXlYZ2FRb2ZhZnpqN3k1THh3MjFDcmh4VTk1dGZSaU4z?=
 =?utf-8?B?L3FiWFZBU3dlQWpFQjdMNzhhTU04eWUzN1I3cjRZL3NyTVhFQWN3eGI2bitT?=
 =?utf-8?B?aHBhMC9SbUVFZ1hKTGg5blllVkJKZXphWjlNVUVXUlZBNWk1YmNDK1hrU0Zm?=
 =?utf-8?B?WW10c2hKcHVsZ1JlaTQwZ3lHN2Robm5HbEEweFRzTHE1L2xkcXJMc0tqRWF3?=
 =?utf-8?B?czhXb0Zyakk5eVp6ZzRHVGgvNWFMMUNtYnMwcVFmQjltVXpCNS94NWF0Qkdp?=
 =?utf-8?B?eDQzcWxpdTl6UGpJSXhXbk80TGFRQlNZQTNTWFNYQkdIQWxaemxyV3huV1RI?=
 =?utf-8?B?U2o1Y3BCTE5RZXJVQndPVENWOElhTklLeWxLTHlBM1JpajZwaklMT08xb3Rj?=
 =?utf-8?B?bHZ4UnNyRmNlS1pXU0JGUzU1ZjVUbVhGZDAyNVZwQU9GcjdxS2ptbFR2RDFZ?=
 =?utf-8?B?ai91UC9jWGd2Q2NiWnRxU0RpT1VibTAwSWt1bVVJZUxmQmhpeCs3ajg3ZmRZ?=
 =?utf-8?B?SnFVWkpscWI0V1VOclU3Yiszb0ZtTmM4akhCZDVxcXhTSlZUZkFBN0gxRXlI?=
 =?utf-8?B?c0Znalh1ai9ZaW5XaHFNVG9pcTBNcERGdXZzanpVOWsxWVJMWEN1VnRYeEpk?=
 =?utf-8?B?SWdDS0VDZlQwcG4xcWZKMEY2RndLQjVFbWpEZVNCN0hxNDB6dEl2cmtNZysx?=
 =?utf-8?Q?371FprhVkDZZcAVpJrIF+zQjssTg4+lcXQAQwRsvYBSQp?=
X-MS-Exchange-AntiSpam-MessageData-1: nEFzVnAio+MgGg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67cadc69-6602-4ed9-16e8-08df0403d7d5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 06:24:26.4068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJZ1sGa2cRPU7nCMiBdiDweHqo1H3xlDUI7Q9C37Pso5VLKA8dlF0hXRzs4WWCbZaPkzfFh5HhUjiceAzpe5Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8272

On Wed Aug 19, 2026 at 8:09 PM JST, Gary Guo wrote:
> Implement a `transmute_unchecked/transmute` that checks size at
> monomorphization time instead of type-checking time. This allows more cas=
es
> where we know that the size matches but this is not generically checkable=
.
>
> The signature is equivalent to the unstable `transmute_neo` function in t=
he
> standard library. A safe variant is provided to use with types implementi=
ng
> `FromBytes` and `IntoBytes`.
>
> Existing users of `transmute_copy` to bypass size checks are converted.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

... with a couple of minor nits below.

<...>
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 4d5c96ddc49c..7225abc64084 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -98,6 +98,7 @@
>  pub mod kunit;
>  pub mod list;
>  pub mod maple_tree;
> +pub mod mem;
>  pub mod miscdevice;
>  pub mod mm;
>  pub mod module;
> diff --git a/rust/kernel/mem.rs b/rust/kernel/mem.rs
> new file mode 100644
> index 000000000000..a0901cbe1b2d
> --- /dev/null
> +++ b/rust/kernel/mem.rs
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Basic utilities for dealing with memory, values, and types.
> +
> +use crate::prelude::*;
> +
> +/// Version of `transmute` that performs size check at monomorphization-=
time.
> +///
> +/// Use this instead of [`core::mem::transmute`] when it is known that s=
izes are identical but this
> +/// cannot be proven by the compiler during type checking.
> +///
> +/// The signature is equivalent after Rust standard library's unstable `=
transmute_neo` and that of

nit: "equivalent to Rust..."?

> +/// [RFC 3844](https://github.com/rust-lang/rfcs/pull/3844).
> +///
> +/// # Safety
> +///
> +/// Same as [`core::mem::transmute`].

Let's add a short doctest for this new core function (and for
`transmute` as well).

> +#[inline(always)]

I suspect we want `#[inline]` here in line with Sashiko's comment on
patch 3.
