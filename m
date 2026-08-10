Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012003.outbound.protection.outlook.com [40.107.200.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D2D3B14CE;
	Mon, 10 Aug 2026 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786354239; cv=fail; b=m4LOsAorJY1GAlkZEhT4Sv8eaIgqVDH7CQPuWanTiUKjTGGQidu55gSGiQh/Q2/dRqVmgKLSRCL70ZOgHy7RBR3ORTzEAtweyjS7UW0rhKnZAq4uyiKF5SYJJVEtyFMGUA8Ia4EuUQkvGP23yyQpjkGFRa6PVnURdipJwyLqGiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786354239; c=relaxed/simple;
	bh=LZ9ssQogF5dQaaLbNCGRUeAc2DpqJY+FdqGEkIme4ZU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=GaufC+7M8QuWDuCl7rt2egq52cXhXaZuThweOBICSQTLQx/ZDv1wTMdCdGuFyHETtuN1erY8PoQMooNFQLEHSfoeMTCL9D/ZFbqBV2fugLj6fZxLbJdIpikZ4/zwVeHrhZ/TAecQ6EpkC0U+P1t0l1p7tIykf/rlyLwQJ9F4YwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BKEsJtsR; arc=fail smtp.client-ip=40.107.200.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BKEsJtsR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYb5PPv1YnWNNrFq+t+pQfBfoV9yIiA/oXjpS6Zn/sTYaYyTtgC9pnJ3+vghgFbAuHbNZb+0Jfvxd7FnKdSpkjwzFbgmmrIMrww8E+wG5pXMNJaPdWKRuCzAGyYZG1XvXn8nj19kcstM9s06rvjQ1Y9+bkQfS7kuU2XrLZcPUaRJjAiPiKmM1ukkj3tw/o+We9AvRRo7MSm9fgbug4JqBTmYSibfuUcpRlOnPMhWafJ9GaS12880/XD/94SNwx7Hjozwdusd1AQorR8yNHQm6kjoGv6smVjXr5kdraW9qsn/RZ8IC6K1KHgiPGCo+UGvI8JmKTIpMUf1smwEL2Q0Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6F2s32+2nhz0zcX4Y/v7xsUFoT1iz40D2GA538oMB4=;
 b=Ep9Ujg1F8TxmI8/wGt0UaI5VQswM9OR6dCFuzg8frM+oCPqtnn2FVg1Dn3mwFj6NMLtcEEey67bH0WFUjEdAKu9d+RJhm0XUFMnzDMdchFC131v82ixro86XGeoQR6jMUgs6w66530FGFJLyS2F1uVU2aS5GhPqNfk8REhLq5nyh2r1W/XuycbUAY8FhNRX+nqyjCMFN/ZSqSogTpa/zaTm3QF/yZBh8eOp/7tCI0Hp+7599IBE1G4zJX6SYq5/pE7a4TtCsvIwVqMgVUvstd+oL5GxDGLFBVPZuxo/LU6y3feEvRhWhkKqFaqb/yGUBo9M6FooUmQNnkgQxKYnC1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6F2s32+2nhz0zcX4Y/v7xsUFoT1iz40D2GA538oMB4=;
 b=BKEsJtsRsh57gFVGWThmGR5IEs0hqZY/Iky0ERnOSIJmeyG5khdZYI2v7FLlmXcDEbDCfveS2McQKUI9nj0W6BN8P4wpAXqbnQmPq7vFb48yQqiL328oPBM/nRcDlSxJBTRHhNCCyX80gbREeHHPI213bAad9Ig0cc+IjwoapYVIKoZdSIDzpHGVpSbC/ccsY0MbVeG9FgWgeg8aIqF4KHyqVeu3aiAYCtC49StCe+j+mVJ6GvaQ/dKKEKNE1d/M2kP1DskSYNaeI0vuxP8A+OZ51fzyTMu/Gu8zFpF6mRYFFhxaTU0ufE92vh1zgFnmSgEro0LR6UHGrp+NF3yzjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM4PR12MB8570.namprd12.prod.outlook.com (2603:10b6:8:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 09:30:30 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 09:30:30 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Aug 2026 18:30:26 +0900
Message-Id: <DKL5Q2P868GQ.29WSPCWX4HTHJ@nvidia.com>
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
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-2-c3ca142220a0@garyguo.net>
In-Reply-To: <20260805-typed_register-v2-2-c3ca142220a0@garyguo.net>
X-ClientProxiedBy: TY4P301CA0096.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM4PR12MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f3740bb-b1cc-49da-2c16-08def6c204d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|23010399003|366016|11063799006|5023799004|4143699003|3023799007|56012099006|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	FrxsG29BKSBx2BLARnfsFwDKAJ+FffuUSFKrTxT4WGF5ZHsGrerFyyGQTuyxEAkn7AW3ou+lE+19iU1O/XK1rRdNhmdyGwHz4MesXWRNgy+8IcBRfra4P+9CRQlMA3yGe7wWUoqJG/C3SrlLzydG8zPbmmGvZhDqS1u41c2bxi+gqqHgFXzSfbMR6+6//pm76mRYbwaCdUEhgWoBIk+SRb+U8y/K8qyir0lf9OsCHfGIzSaHwkLw6x29T9rUk5YxDan8A3KiAz4OpdfBzTEL9D0FmnjKMCTj3zWEo6ME4xLnz1nYrBBG9Yz4DtZeIkGMt/sOY334cZZ+bNZvVpmIoHu/276LhzmC1Li/v9tCeRoYZkd9lUkQee+i1tKHTSLJ3+XSA9cJRTbydnWwR7IBK4DULctV3qvLOH9oW9EODolxvCvX50Trbzi8AEsFVU6uZHfXzBPI0IKAlD5iYDrw3SOD5iBBFtR5mmaiTfy37DUAaefZC9Tv1zXaaHngIeiPOVueKZ3YdKPm7RRzKeWpvBo7JgbtVOF5h0QZETStRsZccBRuajUMDF6MHUQYDyZjSZToLa6NCfTkTgN+m7NCew5S4I67yCXFl6EmOOOURKsfRBlbeMJwzZ8ICBZatavDfgeBPVeFOYYF2jCbjx02N9Im0XcTCBVZcBZhu6JDTz0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(23010399003)(366016)(11063799006)(5023799004)(4143699003)(3023799007)(56012099006)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEFqbE44dGl2MitVZ1RMVGtrY1k0bnNyNmsrM2ViRVFrbUdHbythMDZ5S2xO?=
 =?utf-8?B?RndHb01CUnN1MEFRYStodkhxUzhyRnpPeUFTeU4vek02dTc3MUVDMUZRZU9B?=
 =?utf-8?B?TG1RUDlBNmVLRXJsTXYyRlpIVFJGSXpJdjFJNU80VkkzdTBSbFlsZnRVa0hK?=
 =?utf-8?B?bmtyOS9rSy90ckRSRGxCcXpmeWZrUlFobS9vSEZKcHIxRVR1ekZ3TEFQTkQx?=
 =?utf-8?B?SkJYdjNPRjI2QWNUVnBmUWtMaDhVOUkrUjJpTUJhMk82UGNyYTZWUjNLU3Nj?=
 =?utf-8?B?b3NvUG1HMFhrYjYrd2c3MVZyRE1iTllmL3E3UjVzbkFCWmRmOWJ1dEJEMDJH?=
 =?utf-8?B?WmRxYWVYUlpramQ5cGpKa21RN1dVZ0M3MVJSSEhqZEUwekVsaFRLL0hJV2Nw?=
 =?utf-8?B?TTRkNmJGZXJzMnJsT2tkUnNpaVZ0aEhoZEFwZ2RiMUY4M01YaXhHRk1QVlFO?=
 =?utf-8?B?WnJ5K2hxSU1ZZkdFV2pucitod1E0NmNmOUQwZUFaNWlUK3BsemRRL0Rjbng3?=
 =?utf-8?B?U2ducWJCdGRlUWYvNS9uU2h4UjdSTHpPVEhDa0xwREJ3WkJqQlduV1B6MXRU?=
 =?utf-8?B?b01IcFowbW9TU01QREFIRHJpV3o3MTVHYUxTUllIVG1JZndWTHAyWWw0K1Vw?=
 =?utf-8?B?Wm1ZVVhGLzhPNWhZeTV3KzJrSnJTMVRxMTVobVU1ODZxTVhlWDF1ZTFpVG0y?=
 =?utf-8?B?RE1HaFFROHJZZUlIVjV5aTc4WHFmYXZqRk02Y3hBRXltWlhZUWNySmEwYnJu?=
 =?utf-8?B?UmYrVHUwK0tGd0hFTG5veWVnSzlaVE9QbHZxY0thY1BkbGZzcVlnVXprVTlJ?=
 =?utf-8?B?VFI2MENEV2FVNVA1S3cveDMyWldqWFJ5YWtQbkZrTURKdDBFalFicGxVSkI1?=
 =?utf-8?B?ZThSa3ByR3dhR1UxMVU0SXFtR2l6NW1IUkdqMnJpQ3BJNnVTZ0RUeVE0NUVr?=
 =?utf-8?B?emlHY01abjdTaElFUkVINUxmbGpLVWVKMlhtdkZZY0xQdTRCNkcrUkU2OTNw?=
 =?utf-8?B?Wk9JcE15VkRXWXBtVGszZEZ3M3EvUDVqNGVmUWgxMitGaExXREhsS1NZM0dC?=
 =?utf-8?B?Q2gyaHJwZGdrZ2hLWjFKY2Nia0V0ckdLbHo2T2RpQ1FRQnFPcyt6dDJjYUZz?=
 =?utf-8?B?SHUzVFRJUDl3ZE8yRHBxdTNxUDIzamdaajk2N0pMRFZyazhjdmkzRVN2OXFL?=
 =?utf-8?B?cElBZm83dHlybGw4WHJLMks0WWZLOExsNGJnMnQydjZZSGJsV0ZLM3FJanVx?=
 =?utf-8?B?Y0V1ZkM5U09QQWw2a0doYUY1K1FNNXo4Y09SZEpYdXBFR3NDcnRPcVA4K3lt?=
 =?utf-8?B?cTVPTVpjSlFRZWpQY2ZHdk1qakJZREFEeHhwNmFBTHZCMFlocFovc0FmemVB?=
 =?utf-8?B?aEF2c3BiMVY4WWxONUZ6M2xDaVdwbWFVZ0FFYVJsYm5tdms3UDRKZHBVUHFT?=
 =?utf-8?B?YkRSSjVRTVFsTmxnQzIzaHlzbUVGRlJLazQ1OTQ1UTdJYTlROXZDNkZtdVVw?=
 =?utf-8?B?UUZOV3JiRGdmY0hmN0JrWkRzZm1ScEs1dU5xVnVYUGlxOGhNS2kyM2JreXlC?=
 =?utf-8?B?T05JemdiYnhDZjdaNmU4RmRLT21hWGVPNlNBSEczendYOHluenNsWlphT29L?=
 =?utf-8?B?OXJ5aVBhMmR5cDNHNVpJVzIzR2w2VytxRHJJTEhjNmF6VkY0UVBMWUVldjZx?=
 =?utf-8?B?U2VSTE1CcHZRb2dJa1Z6a1VWQkUzcXY3U3dzSDcyVi8zWmNCVjNyUDdJUUg2?=
 =?utf-8?B?NktMblVzRDl3WkJvRWhpelJnSGpUTWtTR3lCT2tMQUNSazRrMXNZcGcyWm51?=
 =?utf-8?B?TU1CV0hhdHlhK3ViZ0drU215Qy9ncEk1SGhEUWtqWnh4V21PNU5zSnF0ZVlU?=
 =?utf-8?B?bG5heGg0N1BZV3JuYUxNcDNHQmN2VWxQQll2bkxXM3pVcVdOY1BsN0EvaHE4?=
 =?utf-8?B?VER3Z1JSVUJkVVBxaG9lL1B0M0lRc2E3MS9OVWs4T2IxZ3RZSHFLMXoxWFkr?=
 =?utf-8?B?TiticDNXMjl6WW1IbUNVa21MMno4M2Q5QnBwT1Zxbk5QdHJWWlNkbXV6bk14?=
 =?utf-8?B?U0o0cnhJTXh5NzM5WTIxRXRuUFl0OFdIVnN3S2taR2RJMWQyYU00NHNCYkZI?=
 =?utf-8?B?M0s2cllaTjcwT2VlSUwzYjdxdlh5SExjUnVLQW9vZ29KaTI1UGh5bVNHaUdt?=
 =?utf-8?B?MExlbzMwT1FWd2o5ME5VcUZGcHQzL0RsY2xnTlRRbEMwbWFJYzFiK1YvOTJS?=
 =?utf-8?B?bHBzM0lqaTZTdlI1Q3hzUEpNR3FkdmcxNm9ITjVOaDRxOGEvSk1EMTBUR0J0?=
 =?utf-8?B?aDNLV3doNDRqck81VWJnVGYrV2YvWmdZNzR6QVdBeFVwa29VQzVJS1pRTHF4?=
 =?utf-8?Q?tU+FMklBhEibSF7gVk8BjTOZ8Yhb+jVTizcCDo/yqvseP?=
X-MS-Exchange-AntiSpam-MessageData-1: IkLpjw2ZKQla/A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3740bb-b1cc-49da-2c16-08def6c204d7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 09:30:30.1516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JrNG9S1rD5DFiwWyqmmr62qWs3Py7D5bVBQZEZLN/6ckQgOw9E7s9div4Pxt8Qu21MilipHoxbGgCKCm1eJnoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8570

On Thu Aug 6, 2026 at 1:35 AM JST, Gary Guo wrote:
> For types that are layout-compatible with an I/O capable type, we would
> want the ability to use them directly for I/O operations. E.g.
>
>     bitfield! {
>         pub struct Foo(u32) {
>             ...
>         }
>     }
>
>     #[repr(C)]
>     struct Bar {
>         foo: Foo,
>     }
>
>     let mmio: Mmio<'_, Bar> =3D ...;
>     io_read!(mmio, .foo)
>
> Currently this feature is available from `register!()` macro but not
> otherwise available with `io_read!`, `io_write!`. Support this by adding =
a
> `IoRepr` type to denote the underlying I/O type to use for a specific typ=
e.
>
> This makes the `IoLoc::IoType` and `Register::Storage` redundant; thus
> remove them; also convert register methods to use the `read_val` and
> `write_val` instead.

Ah that's nice, I was a bit bothered that `IoType` and `Storage`
basically defined the same thing.

>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/kernel/bitfield.rs    |   5 ++
>  rust/kernel/io.rs          | 203 ++++++++++++++++++++++++++++++++-------=
------
>  rust/kernel/io/register.rs |  59 +++++--------
>  3 files changed, 170 insertions(+), 97 deletions(-)
>
> diff --git a/rust/kernel/bitfield.rs b/rust/kernel/bitfield.rs
> index 35ede53f2b8e..4bc92c62da06 100644
> --- a/rust/kernel/bitfield.rs
> +++ b/rust/kernel/bitfield.rs
> @@ -308,6 +308,7 @@ macro_rules! bitfield {
>          $(#[$attr])*
>          #[repr(transparent)]
>          #[derive(Clone, Copy, PartialEq, Eq)]
> +        #[derive($crate::prelude::FromBytes, $crate::prelude::IntoBytes)=
]
>          $vis struct $name {
>              inner: $storage,
>          }
> @@ -346,6 +347,10 @@ fn from(val: $storage) -> $name {
>                  Self::from_raw(val)
>              }
>          }
> +
> +        impl $crate::io::IoRepr for $name {
> +            type Repr =3D $storage;
> +        }

This introduces a dependency from `bitfield` to `io`, which looks like
inconsistent layering. But thankfully there is an easy fix - see below.

>      };
> =20
>      // Definitions requiring knowledge of individual fields: private and=
 public field accessors,
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index adfc555de7d0..71c6180ed745 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -276,6 +276,91 @@ pub trait IoCapable<T>: IoBackend {
>      fn io_write<'a>(view: Self::View<'a, T>, value: T);
>  }
> =20
> +/// Safe transmute that performs size check on monomorphization-time.
> +///
> +/// Can be considered as generic version of [`zerocopy::transmute!`] mac=
ro but using the unstable
> +/// `core::mem::transmute_neo` instead of [`core::mem::transmute`].
> +#[inline(always)] // This is a no-op.
> +fn transmute_neo<Src: IntoBytes, Dst: FromBytes>(val: Src) -> Dst {
> +    const_assert!(size_of::<Src>() =3D=3D size_of::<Dst>());
> +
> +    // SAFETY: `Src: IntoBytes` and `Dst: FromBytes` and we've checked s=
ize is the same.
> +    unsafe { core::mem::transmute_copy(&core::mem::ManuallyDrop::new(val=
)) }
> +}

This is universally useful, so let's move this to the `transmute` module?

> +
> +/// Trait indicating the underlying primitive types to be used for I/O o=
perations.
> +///
> +/// Implementing trait allows arbitrary types to be used for I/O operati=
ons, not just raw
> +/// primitives.
> +///
> +/// The layout of the type and the underlying primitive must match; this=
 is enforced via const
> +/// assertions when I/O methods are used, as the type system cannot repr=
esent this.
> +/// [`IoRepr::from_repr`] and [`IoRepr::into_expr`] can be overridden fo=
r conversions, however it
> +/// should be noted that they are only invoked on value read/write opera=
tions and are not invoked
> +/// on byte operations such as [`Io::copy_read`].
> +///
> +/// # Examples
> +///
> +/// ```
> +/// # use kernel::io::*;
> +/// #[repr(transparent)]
> +/// #[derive(FromBytes, IntoBytes)]
> +/// pub struct MyNewType(u32);
> +///
> +/// impl IoRepr for MyNewType {
> +///     type Repr =3D u32;
> +/// }
> +///
> +/// #[repr(C)]
> +/// pub struct MyStruct {
> +///     raw: u32,
> +///     new_type: MyNewType,
> +/// }
> +///
> +/// # fn test(mmio: Mmio<'_, MyStruct>) {
> +/// // let mmio: Mmio<'_, MyStruct>;
> +/// let val: u32 =3D io_read!(mmio, .raw); // Raw primitive read
> +/// io_write!(mmio, .raw, val);          // Raw primitve write
> +/// let val: MyNewType =3D io_read!(mmio, .new_type); // Read via `IoRep=
r`.
> +/// io_write!(mmio, .new_type, val);                // Write via `IoRepr=
`.
> +/// # }
> +/// ```
> +pub trait IoRepr: FromBytes + IntoBytes + Sized {
> +    /// The backing I/O capable type.
> +    type Repr: FromBytes + IntoBytes;
> +
> +    /// Convert from [`IoRepr::Repr`] to `Self`.
> +    #[inline(always)]
> +    fn from_repr(repr: Self::Repr) -> Self {
> +        transmute_neo(repr)
> +    }
> +
> +    /// Convert from `Self` to [`IoRepr::Repr`].
> +    #[inline(always)]
> +    fn into_repr(this: Self) -> Self::Repr {
> +        transmute_neo(this)
> +    }
> +}
> +
> +macro_rules! impl_io_repr {
> +    ($($ty:ty =3D> $backing:ty,)*) =3D> {
> +        $(impl IoRepr for $ty {
> +            type Repr =3D $backing;
> +        })*
> +    };
> +}
> +
> +impl_io_repr! {
> +    u8 =3D> u8,
> +    u16 =3D> u16,
> +    u32 =3D> u32,
> +    u64 =3D> u64,
> +    i8 =3D> u8,
> +    i16 =3D> u16,
> +    i32 =3D> u32,
> +    i64 =3D> u64,
> +}

... and `IoRepr` and its implementations for primitive types should also
be part of `transmute` IMHO (after being renamed to e.g. `Repr`), for
there is nothing I/O exclusive to it. It just indicates that one type
can be represented by another, a property that is again useful outside
of I/O.

That way `bitfield` gets a dependency on `transmute` rather than `io`,
which doesn't break layering.

In order to avoid `Repr::Repr` we can also rename the associated type to
`Raw` and update the method names accordingly to `from_raw`/`into_raw` -
which would have allowed us to remove the `bitfield` methods of the same
name if they weren't needed in const context! But at least it makes
things align nicely.

<...>
> @@ -831,8 +816,8 @@ macro_rules! register {
>              { $($fields:tt)* }
>      ) =3D> {
>          $crate::register!(@bitfield $(#[$attr])* $vis struct $name($stor=
age) { $($fields)* });
> -        $crate::register!(@io_base $name($storage) @ $offset);
> -        $crate::register!(@io_fixed $(#[$attr])* $vis $name($storage));
> +        $crate::register!(@io_base $name @ $offset);
> +        $crate::register!(@io_fixed $(#[$attr])* $vis $name);
>      };
> =20
>      // Creates an alias register of fixed offset register `alias` with i=
ts own fields.
> @@ -842,10 +827,10 @@ macro_rules! register {
>      ) =3D> {
>          $crate::register!(@bitfield $(#[$attr])* $vis struct $name($stor=
age) { $($fields)* });
>          $crate::register!(
> -            @io_base $name($storage) @
> +            @io_base $name @
>              <$alias as $crate::io::register::Register>::OFFSET
>          );
> -        $crate::register!(@io_fixed $(#[$attr])* $vis $name($storage));
> +        $crate::register!(@io_fixed $(#[$attr])* $vis $name);
>      };
> =20
>      // Creates a register at a relative offset from a base address provi=
der.
> @@ -854,8 +839,8 @@ macro_rules! register {
>              { $($fields:tt)* }
>      ) =3D> {
>          $crate::register!(@bitfield $(#[$attr])* $vis struct $name($stor=
age) { $($fields)* });
> -        $crate::register!(@io_base $name($storage) @ $offset);
> -        $crate::register!(@io_relative $vis $name($storage) @ $base);
> +        $crate::register!(@io_base $name @ $offset);
> +        $crate::register!(@io_relative $vis $name @ $base);
>      };
> =20
>      // Creates an alias register of relative offset register `alias` wit=
h its own fields.
> @@ -865,9 +850,9 @@ macro_rules! register {
>      ) =3D> {
>          $crate::register!(@bitfield $(#[$attr])* $vis struct $name($stor=
age) { $($fields)* });
>          $crate::register!(
> -            @io_base $name($storage) @ <$alias as $crate::io::register::=
Register>::OFFSET
> +            @io_base $name @ <$alias as $crate::io::register::Register>:=
:OFFSET
>          );
> -        $crate::register!(@io_relative $vis $name($storage) @ $base);
> +        $crate::register!(@io_relative $vis $name @ $base);
>      };
> =20
>      // Creates an array of registers at a fixed offset of the MMIO space=
.
> @@ -878,8 +863,8 @@ macro_rules! register {
>          $crate::build_assert::static_assert!(::core::mem::size_of::<$sto=
rage>() <=3D $stride);
> =20
>          $crate::register!(@bitfield $(#[$attr])* $vis struct $name($stor=
age) { $($fields)* });
> -        $crate::register!(@io_base $name($storage) @ $offset);
> -        $crate::register!(@io_array $vis $name($storage) [ $size, stride=
 =3D $stride ]);
> +        $crate::register!(@io_base $name @ $offset);
> +        $crate::register!(@io_array $vis $name [ $size, stride =3D $stri=
de ]);
>      };
> =20
>      // Shortcut for contiguous array of registers (stride =3D=3D size of=
 element).
> @@ -904,11 +889,11 @@ macro_rules! register {
> =20
>          $crate::register!(@bitfield $(#[$attr])* $vis struct $name($stor=
age) { $($fields)* });
>          $crate::register!(
> -            @io_base $name($storage) @
> +            @io_base $name @
>              <$alias as $crate::io::register::Register>::OFFSET
>                  + $idx * <$alias as $crate::io::register::RegisterArray>=
::STRIDE
>          );
> -        $crate::register!(@io_fixed $(#[$attr])* $vis $name($storage));
> +        $crate::register!(@io_fixed $(#[$attr])* $vis $name);
>      };
> =20
>      // Creates an array of registers at a relative offset from a base ad=
dress provider.
> @@ -920,9 +905,9 @@ macro_rules! register {
>          $crate::build_assert::static_assert!(::core::mem::size_of::<$sto=
rage>() <=3D $stride);
> =20
>          $crate::register!(@bitfield $(#[$attr])* $vis struct $name($stor=
age) { $($fields)* });
> -        $crate::register!(@io_base $name($storage) @ $offset);
> +        $crate::register!(@io_base $name @ $offset);
>          $crate::register!(
> -            @io_relative_array $vis $name($storage) [ $size, stride =3D =
$stride ] @ $base + $offset
> +            @io_relative_array $vis $name [ $size, stride =3D $stride ] =
@ $base + $offset
>          );
>      };
> =20
> @@ -949,11 +934,11 @@ macro_rules! register {
> =20
>          $crate::register!(@bitfield $(#[$attr])* $vis struct $name($stor=
age) { $($fields)* });
>          $crate::register!(
> -            @io_base $name($storage) @
> +            @io_base $name @
>                  <$alias as $crate::io::register::Register>::OFFSET +
>                  $idx * <$alias as $crate::io::register::RegisterArray>::=
STRIDE
>          );
> -        $crate::register!(@io_relative $vis $name($storage) @ $base);
> +        $crate::register!(@io_relative $vis $name @ $base);
>      };
> =20
>      // Generates the bitfield for the register.
> @@ -970,16 +955,14 @@ macro_rules! register {
>      };
> =20
>      // Implementations shared by all registers types.
> -    (@io_base $name:ident($storage:ty) @ $offset:expr) =3D> {
> +    (@io_base $name:ident @ $offset:expr) =3D> {
>          impl $crate::io::register::Register for $name {
> -            type Storage =3D $storage;
> -
>              const OFFSET: usize =3D $offset;
>          }
>      };
> =20
>      // Implementations of fixed registers.
> -    (@io_fixed $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)) =3D=
> {
> +    (@io_fixed $(#[$attr:meta])* $vis:vis $name:ident) =3D> {
>          impl $crate::io::register::FixedRegister for $name {}
> =20
>          $(#[$attr])*
> @@ -988,7 +971,7 @@ impl $crate::io::register::FixedRegister for $name {}
>      };
> =20
>      // Implementations of relative registers.
> -    (@io_relative $vis:vis $name:ident ($storage:ty) @ $base:ident) =3D>=
 {
> +    (@io_relative $vis:vis $name:ident @ $base:ident) =3D> {
>          impl $crate::io::register::WithBase for $name {
>              type BaseFamily =3D $base;
>          }
> @@ -997,7 +980,7 @@ impl $crate::io::register::RelativeRegister for $name=
 {}
>      };
> =20
>      // Implementations of register arrays.
> -    (@io_array $vis:vis $name:ident ($storage:ty) [ $size:expr, stride =
=3D $stride:expr ]) =3D> {
> +    (@io_array $vis:vis $name:ident [ $size:expr, stride =3D $stride:exp=
r ]) =3D> {
>          impl $crate::io::register::Array for $name {}
> =20
>          impl $crate::io::register::RegisterArray for $name {
> @@ -1008,7 +991,7 @@ impl $crate::io::register::RegisterArray for $name {
> =20
>      // Implementations of relative array registers.
>      (
> -        @io_relative_array $vis:vis $name:ident ($storage:ty) [ $size:ex=
pr, stride =3D $stride:expr ]
> +        @io_relative_array $vis:vis $name:ident [ $size:expr, stride =3D=
 $stride:expr ]
>              @ $base:ident + $offset:literal
>      ) =3D> {
>          impl $crate::io::register::WithBase for $name {

These appear to repeat quite a bit of [1] which is already in
`driver-core-next`. You'll want to rebase, I think the only difference
between the two is the removal of $storage from @io_base.

[1] https://lore.kernel.org/all/20260724-registers_fix-v2-2-a0fb58b02185@nv=
idia.com/
