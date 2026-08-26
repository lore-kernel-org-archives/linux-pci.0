Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010032.outbound.protection.outlook.com [52.101.46.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E649B3BD22F;
	Wed, 26 Aug 2026 11:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787743528; cv=fail; b=XYPS5bI3273OYtVLUT2D1+n01W9KuYzQDESWM1Zt0redM+Hw8wQc2ITJ7bf8f9zl8wmjhSU88pcrPXTFgeDIFjfsly9mqvIc53S+7KvVJIDO+R5ireBNUz8+5L89An0ix8dnP9pXHSRVKmzRr1LvjuUmcJh6DM9wjPENGgJkGPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787743528; c=relaxed/simple;
	bh=yqIribufW0swoz9uVemsCp0QMJYiwavsW1vw54VBBoo=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Bn7/CkFSDlteNoBH3O11p5PC+p1bfGaCIdrQ1DyB2z3MwaSmHvflQFUx/3edoFALjxSlNNWhCtxtpjV/trJD7Xp1Zl6bMrkl16rw5G1DBYay7Ub7NMVefLbqk790a7+mf8zj9jv5fAHjGvFfNSs1zrcOTxIrQL4sQK0Z0DN/Zn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LI7VqZIk; arc=fail smtp.client-ip=52.101.46.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LI7VqZIk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yxJ8iWHnNNdx1gmIEk4ak+a8pJDBV1JrCqERp3DR1J7zadcd+nrfmMp6JndRmjzrmXDs0q5Aaam+6J58J2Smb/4xotkjeF6Cyx/LbtOcl+dT9XdN0mlC0+pfOlW34uXe87jcI5oyjHhEQnJqyI8cp1OHnRYZOmHWZEP2IUw75qASzCIdLtomj9jnaraCzjoec2KvJUGp8Pc74f9aYup9eitMcMc4H1Yyj6PB2dLKGVJq+fVDbywMUNI8jSWwFvEDbqC4SExoj7DXfUkOawWi53ZTnJZVqMRsadf3PBPkUQFgHmS2LqDdf1LIG986f7hAPom1t06j3FGdf+IyGriFrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtAQIEDwpiYnbZbjtMg7LEwpuR5NuIyoDy/VP79P924=;
 b=ux8nYaDP21gy/7pyDQx8Ww+GO25VbWL2ooL+zDTDVQOnjJIowiz/tNeUKzefi919VS+P+YDtcGu2CBlN+ImLFS5gOyuBlQRzAVOzJbI4lsZhNAbUlZzdfjfuMhJYkTXea9z6SS9RNxeO2UoEFwhjlvYJJMM2/h9iv/ImIBo0z1lld8g8Pe6U7tMYg2y6g7HaEqE/kxVZg/XLPzCWamwkw6/tKWuUJcWP4y1mAvGslN0c3QGeXrh556LAPURhI6e9H0Sov9XYDE50nUGMSqHXxOUo9cdDJojuo1TAiS4E/5X8GG1PYFtiOGbA5GhWBeaW4Zthq96fbxieutnJX4oAWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtAQIEDwpiYnbZbjtMg7LEwpuR5NuIyoDy/VP79P924=;
 b=LI7VqZIk0/DiH0i3uP5yKugYeWDlrqvmS2KoipkNgWbyJxwZnJqOxG6T5Gh466Dmwhn6Mdq9cXt1exl/8Km0wrZEiGUvIRBPK9sdD/rq//yrFa+IqXW592H9lh204d9ImhTc500yjD61YZC9bDy7FsqV5MKW6gvVmrsPlj7qG7wZL43T7gkP1XHnAyq2jxSBNlgmxa8RAgvuoIFPYLEREa+R33XaUrAmBegq2lN8vsEZ0wyYmFInkUxd784ztxOTPZEXrWGwMr4DEG0qa4ZgImaRkqxwt6xk6JXKPQUZQM17V/tVMlrtQ+L/LCU0UAHg45BRxjXyWwcbZTTCekpqWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH8PR12MB6937.namprd12.prod.outlook.com (2603:10b6:510:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 26 Aug
 2026 11:25:23 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Wed, 26 Aug 2026
 11:25:23 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Aug 2026 20:25:20 +0900
Message-Id: <DKYU6RA4PD45.J2EMZIOB0BBF@nvidia.com>
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
Subject: Re: [PATCH v3 03/16] rust: mem: add `AsRepr` and `AsReprMut`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-3-3699a75fadf1@garyguo.net>
In-Reply-To: <20260819-typed_register-v3-3-3699a75fadf1@garyguo.net>
X-ClientProxiedBy: TYCP286CA0374.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::9) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH8PR12MB6937:EE_
X-MS-Office365-Filtering-Correlation-Id: cd5fa837-edc5-472c-bf02-08df0364b7f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|10070799003|6133799003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cVprPAfgkgisYug3GQtWC02ZefycEVGK3pXP79/iLoMsHIhwCzp9B1e1ntHvkZebeWdH2X9Cp9Ibqr+dQ0m4pyWD3Eoyzlw47URoOlS+xTar35PlMUNw5wpfz2o1mRL3XdKp6/pcr8FsqKS4gIeuwdhEGEUQKuhv+oTAtx52kOzPsLNc166XuO2EzqhB/RsjTQow/cuWeiAgi8cO8avKwc8y/7HmrkcnA9MU5xVSDpFb0DoqcWHS1Sld8VWE0RfjthyQvknFwWoca/ziMh6Hr5sFRvIEmipbAW52M6fF8MEmk5r39K6exp4svSLfCTZaBulyur0yUxOkqAae6SqtY6s1MFYaS+ekMbNXCn4/OZ6NWZwA4xJmOAlo0SmtdRz6zU8dg5IlEaD7asZUvHLkfNRlVw0L20AhfAvTvZXbKPPJoy/vfYhd6EIcKbw3CsmJGWge0EsQhOUuIG6YAJzgudtacG9MJRsbV602Fwyyy9gF+GfLy1rd4kJbfzifFZs2LCVexLoS7i4gJnaPYJIUWIKyaLCSDs1oBZymSxYGBxBBzdOmtaqYiA9FFJk4wzHuPrfoGDCk0FxMaQo5x9jycOHpxjIqRCvhhc68od+9nCYCfrJOMGqP4FdT2HvOhEa1oqoyJw9gU0yncEUpBhYuQ1eAvqn8YQvRV3WKzAbjk/4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(10070799003)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmNVNjVCa01BaDRKSkpvZ3Z5MVltc2JVdDd3ZlJtS3hac2NvQnhvc2NteXNB?=
 =?utf-8?B?NitrcTJmZnFkQnFoVWdjbkdoTnJ0RTRpT0tKNHhIVDZVMmFCUzlDYmF3SGpH?=
 =?utf-8?B?SURQbVYvYVZPUmJJZy84R1lMY0NyMmJCRXNDV3VqTVBtM252RUUwVDAxT1Rx?=
 =?utf-8?B?QS80ZmhCeUpOTklVcG15V3lPMmUxK2svR2dSN2VtMWlJVmd0Mk5wbkZCVG9Q?=
 =?utf-8?B?RlBZM3Z4NGVCM3ljL3M0TTV6N3FXbDdEVEdKandYSTZLb0FseTRYL0UvQjhh?=
 =?utf-8?B?QThCeFprL2lFUlUwTzNtaFJENU02dHAyQS9SUjBKWEdHNTdRZ0dOc3RNMVBC?=
 =?utf-8?B?QUZ4TnNseGN4TnBNcGtXcEkrd0NCZjhXaStXQ0xXYTZhSnFZK2UvdUFVdTNt?=
 =?utf-8?B?dFFleTZZRkI2VSs3Z2FJdVpaYW5vQXVDM01sM05rRHdsN2xnM0lubXBTZzNM?=
 =?utf-8?B?VlFaeGNlb1c3Q1pBMTRSYVpKUDVBSlNXZXhSUmMzNUQzVXN2MUJhM1NpTUsx?=
 =?utf-8?B?VmhKMk14ZXB3S1h1LzBHMU1zOG9VNkRPRmNLeWdSL1JwRWl3bDluaUNPTmRP?=
 =?utf-8?B?d2d5K2hOV21kTWJxeitVU1ZqWnpNdWVnZXpMWHRZa1M0WEpWYmh6VFF5RFhi?=
 =?utf-8?B?K2F5cWFadnM3KzI5cFZEVUNnQ0Q1anM5OTQxbUExcGo5K3J5QkZYbURZT0wx?=
 =?utf-8?B?SkFsZ3RLdW5iNk8vUU83S25iT2FTRU1yTHppREZIZGxGTE5hdmZmYmNGWXJz?=
 =?utf-8?B?S2RBWUt1ODBqVnBrRi94VnlpSUEyaTdqUmNVOFZJdUIxM0s5dlpGbXEza1VZ?=
 =?utf-8?B?RFFKWGVtclVrQWMrZHltT1FYU0YyT0xXQndxYUljb0NjVjR4QmM4aHJuTkhr?=
 =?utf-8?B?cENkSnd0b3BwZW5XY0tLMkwrQm0xMWhsT1ZZV3dsSEM5N2dlMSt6UGQ4NmZl?=
 =?utf-8?B?ZnFlVkN6L3FwL0JyN0J2czZ3M0xzMzZtL3U4M05VNWFFMW5uK0NXWlFpRm0v?=
 =?utf-8?B?emovM1BySWkzcHdjc3I3RlRwZVl0NmZuV0dkTXRQeXE4cDQzZi9ZREFISTRn?=
 =?utf-8?B?aHFDb3Y2K2lNRkNZS3AvU2RjdlY4VHhrVkhaMkpoak9xeG1sRGNrbmowMitX?=
 =?utf-8?B?RisxNUFuZUFYeG1oZDh6T0NKZWo0eXFTUld3ejdtc0YrZUJZK3ZIYVl6Q0JV?=
 =?utf-8?B?NnF3UmROMHdFS1NzQ2FudDNTZzJ3bkdENTNiSHBML3lEZEdONFprWGdUQ0dq?=
 =?utf-8?B?RytOc3RWOWZZRGJKYWY5ck1EQ0RjaW1WRFVtSDRNTnRuOGZ6Mm9wMkV1NUc1?=
 =?utf-8?B?dW5hS3VwZG9ldGV2c0s1RVNMblN2V3h3NUcrajVJSDJZRzg2N0xDVVM5WmFL?=
 =?utf-8?B?L3JjWXFpWnN6NnltQmVVODZ1WVNsT09HdUlLTkE4ZFd0em0wUVJweTZnTzJj?=
 =?utf-8?B?dTJvL29EdURNMjNsSTU4NUEwRlRmZWFxL015SWtiMWVxeVljaTI0eUpSQXRR?=
 =?utf-8?B?blo3R0cvQkR3TFpETG5sd1QzUHh1dW43ODU1UzJUWU9DaXNlek10dFJ3bzRl?=
 =?utf-8?B?SmFhVkdGTkk0cHFWa0s0bU1TQ2hmd0M5ZlBza2hSYmRRZzV0SkFaREFaSXYv?=
 =?utf-8?B?cm5LVjFST3pXclpZczBwY0dGM3JoWkxXb0tGRXc5ZUZVK1hTTVc2R2JZQVJ0?=
 =?utf-8?B?ZVhFam5pM0syZ3ZBTEpETm5BUXM3elBnampVTHBrVHRZczkrSUh5aWpFY0hm?=
 =?utf-8?B?OUlSVGs3MFVXQ3lqMkR3RlZQTHN0QzdKYnRNZkVjUlliQUVoaXpuT0RNOU5p?=
 =?utf-8?B?Z2xQaWp1U0E3TkxNWUxjRDVnRUNERE93OE14bzFMd3N1SGFnbllPdjBIdTdq?=
 =?utf-8?B?THp1b3ZkOURQT0Z0V21zME84QWUrMGt6R0thTnJrMzZ6bmJxMWFRTjgycEtX?=
 =?utf-8?B?ZExBdlBRWEVOOGZkYW9VVUdVeCtnOHgzTHBvT0dhVXJra2tET1ppcGtuS2NX?=
 =?utf-8?B?d1FDaHRWZUVOTjhnb0NmZGliSlBOM2ZsYXgrOG9PYzQ1MDhoMldCNzFFY01v?=
 =?utf-8?B?S2pxVHp2K2JwWlJEM0dzM0VTTkxja3Y5SVd2ZW1ZQkw1NkEwSXQyYUlTcVds?=
 =?utf-8?B?UWd5c0t1OGZVV3B6MDNNNEpKK002ZW8wS2lTa2pySkNKRnl3cytkaTk2UFMz?=
 =?utf-8?B?SkdZTEcvYWtJbS9KMDQ0ditHVS9yem1GQmlNY2xud1BlMmJ0eFJOVGRMVnlk?=
 =?utf-8?B?MXRyUFVsb0xSY1B5VnBveXl1T0dRM0ZCZVFDN1NRb0RURERyWG9OQ3gvaExZ?=
 =?utf-8?B?cC91TmpvUUh4UEo2VDRUazBxTW9lNnlIRDN5VElTY1J4Nk5xMFU0Q0xxY0xl?=
 =?utf-8?Q?iZmbkuB21T/YJQzVD/T9u7jD1AOEBYbfzTyy5fKcle1kL?=
X-MS-Exchange-AntiSpam-MessageData-1: 4GnMEVQP0P10Jg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5fa837-edc5-472c-bf02-08df0364b7f7
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 11:25:23.0132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7yD7vM7jLDytmgFC6SY3rtBCiJk3ZwJ5aAZ9YXSib47pafd9FV3FIExm2yLeFV5iPyZCc3iqPTi4LqMlvSKp9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6937

On Wed Aug 19, 2026 at 8:09 PM JST, Gary Guo wrote:
> Some API like atomics and I/O operate on primitives only; therefore other
> types would need to converted to these primitive first. Add two traits
> `AsRepr` and `AsReprMut` to indicate that the type can be turned into a
> primitive for these operations.
>
> Conceptually, `T: AsRepr` means that `&T` can be viewed as `&T::Repr` and
> thus it has only a round-trip transmutability requirement. `T: AsReprMut`
> means that `&mut T` can be viewed as `&mut T::Repr` and thus it needs to
> support bi-directional transmutability.
>
> To avoid duplicating implementation, all repr types are normalized to
> unsigned integers.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/kernel/mem.rs | 148 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 148 insertions(+)
>
> diff --git a/rust/kernel/mem.rs b/rust/kernel/mem.rs
> index a0901cbe1b2d..5bce381d8895 100644
> --- a/rust/kernel/mem.rs
> +++ b/rust/kernel/mem.rs
> @@ -35,3 +35,151 @@ pub const fn transmute<Src: IntoBytes, Dst: FromBytes=
>(val: Src) -> Dst {
>      // SAFETY: transmute is safe with `IntoBytes` and `FromBytes` bounds=
.
>      unsafe { transmute_unchecked(val) }
>  }
> +
> +/// Type that is layout-compatible with a primitive representation.
> +///
> +/// # Round-trip transmutability
> +///
> +/// `T` is round-trip transmutable to `U` if and only if both of these p=
roperties hold:
> +///
> +/// - Any valid bit pattern for `T` is also a valid bit pattern for `U`.
> +/// - Transmuting a value of type `T` to `U` and then to `T` again
> +///   yields a value that is in all aspects equivalent to the original v=
alue.
> +///
> +/// # Safety
> +///
> +/// - [`Self`] must have the same size and alignment as [`Self::Repr`].
> +/// - [`Self`] must be [round-trip transmutable] to  [`Self::Repr`].
> +///
> +/// [round-trip transmutable]: AsRepr#round-trip-transmutability
> +pub unsafe trait AsRepr: Sized {

I'm a bit confused by the naming of this trait - the commit message
mentions that it means that "`&T` can be viewed as `&T::Repr`", but such
a method doesn't exist. Instead we have an `AsRepr` trait with an
`into_repr` method that makes a copy.

Can we either rename this to `IntoRepr` (and `AsReprMut` into `FromRepr`
I guess?), or maybe better, have `fn as_repr(this: &Self) ->
&Self::Repr` (on top of which `into_repr` could be implemented if
useful) so the names of the trait and provided method align, while also
making the commit message match the actual API? I haven't tried but
since all the representations we are working with are primitives that
implement `Copy`, I intuitively think it should work just as well.

Same would apply to `AsReprMut`.

Since this is becoming core infrastructure, I guess `as_repr` will also
become valuable when we want to do in-place access (with e.g. atomics)
or use it with larger types that we don't want to copy.

> +    /// Primitive representation of this type.
> +    type Repr;
> +
> +    /// Convert from [`AsRepr::Repr`] to `Self`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `repr` must be a valid bit patern of `Self`. If `repr` is previo=
usly obtained using

nit: s/patern/pattern.

> +    /// [`AsRepr::into_repr`], then it will always be safe.
> +    #[inline(always)]
> +    unsafe fn from_repr_unchecked(repr: Self::Repr) -> Self {
> +        // SAFETY: Per safety requirement of the trait.

"... of the trait and method" maybe?

> +        unsafe { transmute_unchecked(repr) }
> +    }
> +
> +    /// Convert from `Self` to [`AsRepr::Repr`].
> +    #[inline(always)]
> +    fn into_repr(this: Self) -> Self::Repr {
> +        // SAFETY: Per safety requirement of the trait.
> +        unsafe { transmute_unchecked(this) }
> +    }
> +}
> +
> +/// Type that is bi-directionally transmutable with a primitive represen=
tation.
> +///
> +/// # Safety
> +///
> +/// - [`Self`] must be [transmutable] from [`Self::Repr`].

nit: missing backticks on [transmutable].

<...>
> +#[cfg(target_pointer_width =3D "32")]
> +const _: () =3D {
> +    // SAFETY: usize has the same size and alignment with u32, and is ro=
und-trip transmutable to it.
> +    unsafe impl AsRepr for usize {
> +        type Repr =3D u32;
> +    }
> +
> +    // SAFETY: isize has the same size and alignment with u32, and is ro=
und-trip transmutable to it.
> +    unsafe impl AsRepr for isize {
> +        type Repr =3D u32;
> +    }
> +
> +    // SAFETY: usize is transmutable from u32.
> +    unsafe impl AsReprMut for usize {}
> +    // SAFETY: isize is transmutable from u32.
> +    unsafe impl AsReprMut for isize {}
> +};
> +
> +#[cfg(target_pointer_width =3D "64")]
> +const _: () =3D {
> +    // SAFETY: usize has the same size and alignment with u64, and is ro=
und-trip transmutable to it.
> +    unsafe impl AsRepr for usize {
> +        type Repr =3D u64;
> +    }
> +
> +    // SAFETY: isize has the same size and alignment with u64, and is ro=
und-trip transmutable to it.
> +    unsafe impl AsRepr for isize {
> +        type Repr =3D u64;
> +    }
> +
> +    // SAFETY: usize is transmutable from u64.
> +    unsafe impl AsReprMut for usize {}
> +    // SAFETY: isize is transmutable from u64.
> +    unsafe impl AsReprMut for isize {}
> +};

By making these available, aren't we running into the same
non-portability issue [1] that we discussed on the `casts` module?

[1] https://lore.kernel.org/all/DK9A6KGK5JQD.3U23MBEMSAXBK@garyguo.net/
