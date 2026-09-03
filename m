Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010021.outbound.protection.outlook.com [52.101.56.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDA6446825;
	Thu,  3 Sep 2026 11:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436021; cv=fail; b=Ck0yf2WRun9WmM6BF1bZfZk8n5/o7R370mIePZoQbSJeDdE5ZIXceq14dp3rV4gVYjVTk9JiUM4py+MfbfzcuZ6BG01TDFXOyLVSeIqR4vKcQZwVedeUyhbgEiXPRRUzsHPzrfqLt7G9Qh/L687IPjfOS1yzloAu/4aWHHDJKfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436021; c=relaxed/simple;
	bh=O9wpAcdwR7cMGAwGYghKdCwmMBPwbKnKMvqpK1tWQ1s=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=hGthX+xELcLJqCfCZi4E+FUOm+MaRRoB8V+N8RNLVe4tFXI8mGeHLcBzM+pl6fQ+qDUb7HEBU42Rc4+aBVYdhf0cC7SNnfyiiEAB7J7WIPJ5xabYmKM1HLg28ZiqQ6FMzU1IgfHcdBD6jK5/IOWSiAr5F0VaL6aXXxHVqjVT2H8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l5+DiYlt; arc=fail smtp.client-ip=52.101.56.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l5+DiYlt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nj0du++BlVG9PF08pHREegVafh1se15Bq3e36tRxGxr0Ygr1UDEhLzUzFEThQFBD/3pyLbpD8QqMRtCqGxesX+cD8+07NZi7AOIXI3t/k8eOzSULodEskvOTPbK5qGbHF/s65L7oRgE0/HJ5m9omEHavfuogufODPBeaIFaCUmHBxax4VN7RWLm5Mis7xvvKuFwRnnaD44Bckovfah2VxO7a+cn1qItz3u4LGJbSbHDiHsj6KemSf39u83mrdyXDZHcOPDluXGZiDNoOkGUxafKOTjKW6CteCQErLgmVq0MzTOrqyd2hr5rxBE7+fX62JjRhxW639R8Imylj13zoTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFi1iUMh3e9QxGt8uTsnhuavQgn5q+R4DOVTBTcZrmU=;
 b=TsMbjIwJkj6UDgd2p5XyueCdm3pO8f8QI9b/jUqfPBAMKOaNfwOK/qPt64/SVkDyvyZJdNKhcONdHz29ZyxxKU0SisLRjksxYgjzszK8Qz3dbrMjFv9k9mgpnrip8JnlU4pSzDN7gglSKyT27Eqo+mYJMUt4Tzu6p25fLtISudmcBUbaTK1zS/cuDcBzKF/8YUt34CGm0VuexaGOzaRsURA1fRGPoBfv4EVfbChzVTOAByYHnbmGwTKVukbxTp2IWDHPy6MBgtwCa05V7bMDqp26kx5BUGmq4Qvw4OdKXynwSs+/r0WdvxzPpnzvAA6lNKhlkaH6WtIUycoFElF5xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFi1iUMh3e9QxGt8uTsnhuavQgn5q+R4DOVTBTcZrmU=;
 b=l5+DiYltDnrwL/udXcLr3EIKtRNfxBUYQ0pX67pthFcRoLacIAJgMaKYNiNuB2TM7Bjhj9RIVO4i3ZBsGO1HWqHh8O0h6MKUODQXalDC4v9Cqjf3jPlzobsEDxP9ORJdMMTlOnp/rP+WzXWp27g0CcVxzJSYfEZxDHrn4rlRP+NeXmzKln9IPdvSWZSPT2ecVITVzSItH2vUaQIk+z+4MEs5ErzONKkML+MOtAG5yfhfhUy6SbQ4ZyeT5NVIwgQ08w3SNGmkr4U+wEPIZm4x9RBxwroy8xLybpPg2Wq77aAjn8c2aIA1FiD/cKVUnIRGn2UvgdYqTulO+injEihlrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH7PR12MB9150.namprd12.prod.outlook.com (2603:10b6:510:2eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:46:48 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:46:47 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Sep 2026 20:46:44 +0900
Message-Id: <DL5NNIC77DYS.2BS3GZ701XIY5@nvidia.com>
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
Subject: Re: [PATCH v4 01/16] rust: io: register: reimplement as proc macro
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-1-5552b1d59525@garyguo.net>
In-Reply-To: <20260901-typed_register-v4-1-5552b1d59525@garyguo.net>
X-ClientProxiedBy: TY4P286CA0025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::7) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH7PR12MB9150:EE_
X-MS-Office365-Filtering-Correlation-Id: 7812706c-891d-4341-2e72-08df09b108d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|10070799003|366016|11063799006|10067099003|4143699003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	X4aeJ108YhpdIG+fNxQYVI7pnSATEnnlWMie4ER1pV94cD62G4o1xMjNrqAtVgKl6Bpfn2e5z/6qmjle0do+U7i90WLBWT8Nrrs+QOAHK+AfKORgvMHPPsg2vQKq6U1zihnSShq+MhdlsSBRkFpU/t73fZsAVzeMhTOt99Hf2YzLf9WVI7AK0Rnd7WtVSj1Q9cw64HgJ9iZpLbXDfSKXAqIcFj4cvh7Cf8+g3DwXO1HtY7XMC5kQIhXq028nw7AG59L5w+gHJodJyCjbE9IzZ7m/2dNip9UmFNB7lCVIxUVzdGyfedtasrOfYVZlkEwKiFCqcWtHg379LOpw1ubuNOYvwrj4YBhX0sWM6XkHR+lt8xw2VeKkBTwJADSeDY3FPxPhmwRzhx21Rihv1w+j4+r5H+g8LKz/+U23EF3EHgqrt7iruAnt1JlHRd5vt6fGgcKKKeWwQp1GDGuizh3P24hMsTIqIOvlPSbT8viJZd/eXQK9wH5PMRBXRFMUQ51tBcQb0nxiqe1g6CMI5afwiDHhEIO01S5olvTjD2RIlRLNs9U62RqC55oQIjmHYtmMfyX7THHAdIy8UWlmdBMo7xDKW3f4pD7caMSdCdNvbQ79+YinCMHSw+aSd7B2enqMJ0l0BFzuvQ1S5HY3UiY3Cm14lzWvR+XmzlmCgLtC0Wg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(10070799003)(366016)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eU1HT095Sk1FalNQaC9FRElDVEhYbkVXbTBWbExUUFlrSFVRL3FJdkY4ek9B?=
 =?utf-8?B?Y0d4cjQwRUs0YmZZaXJjTlpoS0JlTmtzREViOXo0aEcweDQ4NW5SUTFNS0JY?=
 =?utf-8?B?SFhlZlJlOFdtU2lkWS9OQTl3NDgzLzExQmgxdmNFR0pJSVFtQnk4cytKeXY2?=
 =?utf-8?B?MGI1OUU2QkNTZzdDNlJFVklrY1BFVm04WUJEQlhQdXIyVWc1VXNoRGRqZE54?=
 =?utf-8?B?TEdnemd1OUxwekxpZ0VacFJUcEIzbG0rd3pOck85ZUJTODQ4L0JOVmlqK1hj?=
 =?utf-8?B?VnV3Vm1vQ2VVdk92MGZRc0hsUEF2NktINGtHS3cwc2RkZUUrREVFYTkyeGRs?=
 =?utf-8?B?WEN6SC80ZzBpSk4xSjd1THN3cHphUnBtamRzY01zM0M5Uk5mYmdLLzFUdTVq?=
 =?utf-8?B?U3kyZUV6MFRHNVdNYUVyTEJjNWlRVXBId2NhbzVzNktZdmVEZmtMU1p5a3VB?=
 =?utf-8?B?OEZvcXRmTXZ4MFluN2dPNnRHNmFYYnAwb0pwbVo4RG5MampxZHVSaVNCYkhn?=
 =?utf-8?B?NTdhbFhRM214RFE1V3Exakx0QllDdFh2NVpOUUUrWlh2R1V3TENQeDZ0eGNV?=
 =?utf-8?B?eWV4STdNeFNhVmI3UmpxdDFvNTV5UHRzcGd4WE9qUmF0aFROa3BkL0RXYkM1?=
 =?utf-8?B?dlVUR2hWN09qM2kvUCtpcE9QY3dxcVhsRjJybDZ0UUQyWTRsZ0JUckVmclkz?=
 =?utf-8?B?UXR3UWFEVHZzZ0J1cGpIdWFKS3ZoaTlOU0tIUkxsUEdKazlqT2VoaGRCWlg0?=
 =?utf-8?B?djh6UmkxOUVxdXRTZklKTmZLVHFWN281bVU1eGRQSWUwY2hYQ2FHUUM1aE9R?=
 =?utf-8?B?OTJEa1JocUNyNFBOcHd3cW1HSzR4MEV3RDNoc3d1dWErelJnYSs0b3BQVVha?=
 =?utf-8?B?UklTQS9sU1g0N0g2Q1dmcHBzdFVIU1p3RGF2NTlWRmFiakwyVlQxV3dGMFpa?=
 =?utf-8?B?OUkvRnNSVWVWR1V2ZllTZkQ1MWlVelFpcE5ZWWlHWkNWWi9jcVYvTm1rbysx?=
 =?utf-8?B?SWJ6Z1B3NzRSZFdOOS9jTXB4WWwvR0xvYmljQ0xVUWRhbHg3Z0JMK0ltVDNW?=
 =?utf-8?B?SEcxdk1PQmNxZzF4UkFuaTVwUkw5RitFdHhmYXBaVnVKTHh0UG5LTTJ3Q3N6?=
 =?utf-8?B?UkpiQ3diYlNtUGZMRy9EVmg0bE1Td2NjbVE4ZUhNRVlzZE00R1lTOXlMSFlY?=
 =?utf-8?B?Nk1EZmJXNFJqaFVSR2xhdEdJYmlOSVBlUm9kbzVDZjFrTnpSc2FzVkM3NkZR?=
 =?utf-8?B?QWswTU1TekozN0ZQSkxLS3lMSHRaVG40QVBCdUdsQjcwc0NwbGpGQ3Z2ZVJu?=
 =?utf-8?B?NENndDVWdk9Qc0xYM3lWZ21mN2lxUEdOZjVxYk1jYjA5eUJtVXFlTU1sZ0NJ?=
 =?utf-8?B?ZDUwSm83Ly9lSnpJeGhHSGlxZS9VUmV3SC9VTi9yTHAyQ0hFaG5DbVN5eHcx?=
 =?utf-8?B?YXYwQkUwWkFtUmhkR0UvYzE5UUNteDI0S211d3JIT1IxcnF6OE5peG1YN0Vn?=
 =?utf-8?B?a010bW9CRlZTaFR0bDMrWVhTcTlJbE5BUVhHdWtabjhFN1NwL1U1M3J4dTB6?=
 =?utf-8?B?bzliUTE5N1pDNnVaOFR1RjRaNzNKZTFLd25EejVkMlN0bHRZVVJuOUxHNnBn?=
 =?utf-8?B?Q0h5a1ZUU016OXJnVk1MNHB2YU9mQkZLQXFIWjlkVk0xYkFaaWJhMFY0Uy9Z?=
 =?utf-8?B?YTBIUTN5M2pJM1RkbzJtVlowc2ZRbStIWldvVHpuYmcrVEtTaGxrRlVQL1Nw?=
 =?utf-8?B?MVRtOXliM2JBVHAzallaVHcvU1NQQ1U4M2hDZStZZGV2dWRTNHd5Q2syZXoz?=
 =?utf-8?B?SmEyV1J5ZHJTQXVBZkZxMk5YOXFHTHlqNU9JS0Q3N0YrcmdVdWhEUXZmQzNU?=
 =?utf-8?B?Z1lhZ3ZOMUFIL3RHcTdhaVFtNXdVb0E2SmZ3Y2ZuRjJXbDdjS1BCMUhpcGZO?=
 =?utf-8?B?bmlGbXFnRnJpbEtNQXArVU91K3JHSUdsaEc0RWU5Ukhza3dQbURQTFhhN1c4?=
 =?utf-8?B?dVA2YS9QZFpqeG4rbCtBRlRtb1MrdUdOZzFEckdNRWZISWc1YitDSEp6MTAx?=
 =?utf-8?B?NFpWWXd1Wm5pNGQ3NDBBeWdGZERDcnFoU3VlNWV2elBLMWFOZElxQWJtWVpJ?=
 =?utf-8?B?K2VaaktWU3d5ZURJblFCbHNVZE9SbERLVENGR1JkNnd5T2Y1UEFSV01XSTJ2?=
 =?utf-8?B?d1Z6TTFiaEVQWXQ3ZTgvYXBHTm9sYVMvVVNFc2RDdE5GTFdPbW91L1YyODJh?=
 =?utf-8?B?SnovTWh4WExCYndPc2dKN3REL3FWNGJPSDA4MDVmZ0xJcmxQcnRyUmJBTU9x?=
 =?utf-8?B?cWxoSnNMdCtFS25VdTk2L2FmWG5Lcmw4VlRIeC9KeXU1RG9TclBTSGxMZStY?=
 =?utf-8?Q?YrW2B+xVvGqgTQYoO6k8zI8VflI6uCUd46FCyoazic7Z+?=
X-MS-Exchange-AntiSpam-MessageData-1: MuLGsAjcRVkzKA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7812706c-891d-4341-2e72-08df09b108d3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:46:47.3144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0X26DnXJit+oGMG/6QhUQ66mDVKuSWqYmcEIMyjA2RwPVTDZ4Lp2oB97JpKUyQzoAyEw7kAByoBReU8w9pcFJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9150

On Wed Sep 2, 2026 at 1:50 AM JST, Gary Guo wrote:
<...>
> diff --git a/rust/macros/io/mod.rs b/rust/macros/io/mod.rs
> new file mode 100644
> index 000000000000..87f7742f4619
> --- /dev/null
> +++ b/rust/macros/io/mod.rs
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +pub(crate) mod register;
> diff --git a/rust/macros/io/register.rs b/rust/macros/io/register.rs
> new file mode 100644
> index 000000000000..83ba4dd75ab3
> --- /dev/null
> +++ b/rust/macros/io/register.rs
> @@ -0,0 +1,276 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Documention and usage example of the macro can be found at `rust/ker=
nel/io/register.rs`.

s/Documention/Documentation

> +
> +use proc_macro2::{
> +    Group,
> +    Literal,
> +    Span,
> +    TokenStream, //
> +};
> +use quote::{
> +    quote,
> +    quote_spanned, //
> +};
> +use syn::{
> +    bracketed,
> +    parenthesized,
> +    parse::Parse,
> +    spanned::Spanned,
> +    token,
> +    Attribute,
> +    Expr,
> +    Ident,
> +    Path,
> +    Result,
> +    Token,
> +    Type,
> +    Visibility, //
> +};
> +
> +mod kw {
> +    syn::custom_keyword!(stride);
> +}
> +
> +/// Definition of a register array.
> +///
> +/// Specify a size, and optionally a stride. Syntax is of form `[size: E=
XPR, $(stride =3D EXPR)?]`.

IIUC the syntax is actually `[EXPR $(, stride =3D EXPR)?]`.

With these fixed,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
