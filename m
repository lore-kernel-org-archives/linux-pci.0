Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60674C956D;
	Tue, 21 Jul 2026 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784645854; cv=fail; b=UMtQRgKEla9X0s+WEyAaFTSX9+ed0CcbJIiBVApfOe6M9P8N3Ma0BI2TwH+G6NGj43S75q5ABCYdLSfBAZuBmj7ghaV/nhVrlJPjpTMcfOKasNEQsb7bSarIWoZ+A8lc1szvVWiAIaqaRCvD03KeVqRRgVtL/1ZCTMchF5FpbU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784645854; c=relaxed/simple;
	bh=X1Mx02NTqlHjzBHB+7hhbVvE2RK7dFvKGUeBhXCXVWI=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=DzqUDEWVzhS5yDnNXv0sedtl2/OupwStVs4hVeQRGBqp4pOAB6a50ddR0zUi2cghl31VVRX4N6x4HVGtKAn+hXcKOnrZJOjzVcSi8bCwhbIUNKprHclqtT+efSMO68lecPk/ltqcQxxHHb4h43j4k9bxgRc/fUv9mXdxp/nhk5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k8vwEFUQ; arc=fail smtp.client-ip=52.101.53.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k8vwEFUQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWOjMLhOliFdHDds9SZ0kaTVsrcmlRgChfCmgUakA7ahtk5BT334jcsK9JaLZPgrnSwjTs5ZcV/yeEpeWt3n6vye3JMjXZI0qg8M6o37QGLHSbBLOUSoGg9w5ozumLcnglmzhXF3zvB00zwykPl6gZEnbPRcSD5TlUFWRO0uyNvrUD2tbo8sMNk4NpQe346sGoYe1WAkH6PkMtNZGxbbu9wP0/fbj8dJS0z5uHo7Q1fWm32F+9V/K1N/dlAXysJNPdW4y4dvDzMao+ZYgPGLVKvog4nnLx6d6O3xUe1bXs/y8Ek14rrU3N0nFq3cNdRYC53GrU8uT2ieyeua4KqpKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EoQqPqgqgU8Cv3FnzjYU/Y7H55d4YzArGyPj79gvu0c=;
 b=yBk8HzvgNTAmfpKKKPuW/ZGMHn6kBbB/BvfEP18A7HxGokH5nan75soIT5qIBvEC0bSnguMgMlxs+SN+P35LP+ISzUI2Mb8QxZG5f0CjzeJ/fTNS7BF/0r0k6IONjkhM0FXTSulmEGNo/8y1M6r7E+S3i2r9v8F5pIxSjbe4OGftpFMrS+Gzol5ZLYhqIFxtzAow3N/WykylVCOqWQWlPpu/wzmweV5yaNiQQnF5+NXsKuOU9C+3wYHXEmyq2txaWd3Kklolid4eCGgUO7acFuxJFjiS/IybNH0w1zJsO5Edd/pcxk4aGg1IsCWMz7rEF1ErVXsaYrmLSpp5fz84tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoQqPqgqgU8Cv3FnzjYU/Y7H55d4YzArGyPj79gvu0c=;
 b=k8vwEFUQBOB6tHk4bg2L09epMwiPUHYkSQbCG+C87IHQIQ1gclWpDyGefWCvLExqjSixQB5It/sNxqSu1vQcrYSmOCuCutj5L0zyjeW9v6raW69KXjkb4ZOzw0geYAR3/4ys3+/n0HMEsof1uchWlv7zifzvuLiRhtUe81q16iPtCrH2IK7sphjUnWjm4gJT7/6y9RLgNERYDuX7SCTpqoo3UMam3+u+/ZKC7Rg6p6W9XChvsgWrxJLeGfl7RIrbvj40LqzJfcLJbZ9/7yWwKCrIorVU7YUvLJneIVbIA+b0EkXG2TGaNtmGGYTVW0iY1q10yYeTfJoPUvZJt3KxqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY1PR12MB9700.namprd12.prod.outlook.com (2603:10b6:930:108::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 14:57:26 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 14:57:26 +0000
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jul 2026 07:57:19 -0700
Message-Id: <DK4C5GHMXU5G.287NUJIM67T6O@nvidia.com>
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <ojeda@kernel.org>, <boqun@kernel.org>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <work@onurozkan.dev>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <mhi@mailbox.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rust: irq: make Registration compatible with
 lifetime-bound drivers
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260719153631.559341-1-dakr@kernel.org>
In-Reply-To: <20260719153631.559341-1-dakr@kernel.org>
X-ClientProxiedBy: SI2PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY1PR12MB9700:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bf96668-03db-4356-c735-08dee738606b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|18002099003|22082099003|3023799007|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Yd0YwzjSo7DOKy9EwJsciVn0rMT3/8EghQhD3K9Yuzb4AmdaEtAFD5uHX9dpS4XTpiD2Ac9aa9NCEO2dAEaqyLa1b9bbj1DzJZB0U5SUDzvW2cY3OZ4yBF6J7LFFuAyy/0vutvBC0xQ6VBsE9QTUe+S8cTC8Q5KmYNcq+/XY37BiCqLqMTMLmrVjJ+EScqyvVcN7bckDO0NPqLn3nwQrdkxoECwefasyVoW8pqQ+qZ6crpp40nJTBbjVAwbSw/llDmgTx4ibFZcrrScKjBsanwm3fdj11AGESlA+kTVeCLHPj+7ItWd5Fs/ub810ZolZyHgLYYpVaLJy5KrZKzCNze+EU9ziKiLkvZTQpM3nVHX1ja8hqmitO5CE0D7D3wzxGTT4wmNepnVl8bYsI3ypOEVevaIkPCjkOctyMe+w+dvs5/AjGOxt6saXGfLab5mmAlKKGFpwueUuZ9dgqCJbJAGqGR644EX6K5/FFULiOsrMmnBpYfYkJEoKVx/9gRP0wjW2+XqXTupTkTShmejczge+dYPXHcfAexUEkChZjT5kKIyGoG/WHBLASKnUlUoegSn9Viv9vLHNzE6Oeg1HeAzhsFCfGPMy8hx01RbxUczn5xXBZuZiFvYkT/LJqVawlWnYlEkKD7Jr0SvFpdAxNgcLs+ReREVR2CgaXHmNZAU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(3023799007)(10067099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFZNZUdJUnBMazAzWnk4Ym92a1VvK0NSRnY3V0pOQUxmOERjWlYxK1NkWllW?=
 =?utf-8?B?b2Y4SmhDTGpETHVRUnRDR1NCa0xmUTZXclIzRWh4bFp1UTBCRDIwL1FrYjlU?=
 =?utf-8?B?dStOYnd6dlViaGpvcmRvOWlDMStBb3JPQkJtTmpPTDdKWWlpbW53anpLemNx?=
 =?utf-8?B?NTRmRjVQaVpTL2JzZUdaMjllMzVWY1N1V0NGOTNvWW9ZdTJHYnRTd2pBdFQv?=
 =?utf-8?B?RXdCL29FNWkrdWpDZ0g5SEtKb01rbWkrNllvUDBTUTdReC8yVVlUTG1LN2N5?=
 =?utf-8?B?d0tFZjZNUm8rSFNoVHl4YUVIK053WjVvSCtWQlZzUVFhYklzYjF1Q0N0RVN5?=
 =?utf-8?B?dWxqMUY0YTNQaVZKK2duMzdNNWQ5MkNkLzhxWGxibm9Pd200QU5abG1MTFdw?=
 =?utf-8?B?WGUrNGJYK0RMRUJIMnZJU2RwdGxBNHYyaFZUekZUcXZlNHpHd0FLZU93MjVH?=
 =?utf-8?B?a0F2dlNHRGpiSmlNbXBuNWRzWXVuWW5TZ3dYcll5QWFZWVNDU2t4Z0RhbHhJ?=
 =?utf-8?B?STJDc1JURFVXNUZPUzhaUTlTU0dKUjFteDJRSEkwNkRVV3dnc3pwWnhDN2RC?=
 =?utf-8?B?Z3c0RUlFT0JXVW5VeDlmUHRqYzZsaDVXY1E1Mk1JMWx1akNrY1R0VjAxQ0d2?=
 =?utf-8?B?NVRFamNyZEdFL1JMUHN4VnJjcVVpVzJaWnc2MTB5Tk5oZHNYZ2JDMUpibDYr?=
 =?utf-8?B?MDBXUG1aRmNTejZhUHJhVVdQWVFpczlGSlJnd2tCODBXQjZ6Tld6ZHRDUjR3?=
 =?utf-8?B?dDlESjdVOFRBTUpKaG9iZjlVYkxucWtNQUllUytMU0FuMFBYWmtrUFpEMkZZ?=
 =?utf-8?B?eG5SUXFWNURvempXN1ppTmVhK1cvSTFZc3dmQmdNYStLWXBrLzZGTWgvZ3lq?=
 =?utf-8?B?NXBrbFpLZ3dPN0VXR0huQUo2b3UySU1CV0dCL3kzTDYvVFBXY2tPZE5VSlBH?=
 =?utf-8?B?OXA0RFo1cDhHNENlSzFpTHZyVjk3Q2orb3oydWpoUzc1YVM4VGtMVVl6L0d1?=
 =?utf-8?B?OU5zYmMxVDROdndaeVo0eThNaGR0V2tVNDZjdU9ybkVGdWp0c0RWRy9tU3V4?=
 =?utf-8?B?MEwzRDREK2NOYUVxTDk2eFh4VmNVU0RFQS9XazJ3NVIrUEVIbStUaUJLRDVC?=
 =?utf-8?B?YXQxazlBRmZnN1VpbjlBbWQ0VkNFcjFFUTJUL0pOeW9kTHZTc1dwTGFoVG5D?=
 =?utf-8?B?VVptcGs4QjdhMDVwSzJZRkRwY1JjMGxUdGdzTnhZNzFRb21COW5hTmgySVA3?=
 =?utf-8?B?K0J5c0pyUTA3K2ZQNUY4NGQ2b2ZmaVE5Skx5OGxvTUNGM0ZuUUZDeVFyUUZN?=
 =?utf-8?B?L0puTWFCbFZ5UVFneHhTRHZuaXpvL3o4N0RBMjFZZDk2UGltTldhVEdGdDYy?=
 =?utf-8?B?ZWpJMEZlNGttNjByRVlZODJCOTQ0WFRtYk94RUNtK2ttdmZoWXcxWXRFRjlY?=
 =?utf-8?B?dzJyekJIeldtdHVrdDFTaVBjVUN2N2wrZWsxRiszN2l2Q0N6UmdSOGNJMUFH?=
 =?utf-8?B?aitvb0lnLzZqVzdDS0tiMDJsQWVyNVpqU1ZzWk5IR1ZadHdiK3c0NGxJbUhW?=
 =?utf-8?B?NUdUVmxuNDdaTVBBdll2aytuUEdLV0ljNVMxQ2RoOW9VNHB6N2J2NE9IUlVy?=
 =?utf-8?B?T1RxTzZJWXo5aGgxS3Z4cXBMU1ZTNEQ0SEkrdTV3TE1QOUpsMlVBUGM5cDN0?=
 =?utf-8?B?cEs3WWNTdEZEdzFxdDcrQi8rd283TlZqS3FZdGRoajB6SFVqSFljbTY2bEhZ?=
 =?utf-8?B?Zjd2MDY2dkovWEs5ODFYY1R2bDNJZ0IxVGtDWnNVQnhIUWM3NlFHWURJcUlE?=
 =?utf-8?B?dllmd2gwZVZLaHY3WnFDZ2pOTDdWY3V4aWlCNkpSUGlZT2M5MmdjZE9jYy83?=
 =?utf-8?B?K2ozMHB2ZU1ySTNsNVBkTThzN2N1RWpOeVlwaWU4NnhOZmV3N0gzU0M1Y0dN?=
 =?utf-8?B?NmJDY1llUlBrcVNRWW14Q1RUK0EwYTAxaExrUFJ6dHFoeGJCd0x4RVFoT1pr?=
 =?utf-8?B?M0EvNmt3UkN0Ym84ditVOXp2Y3dLM3J3bFloc3c2U1VCQlV2WTZYZGZCblRF?=
 =?utf-8?B?dUFDcnpieGFFVU5XTHFVK25MWTQwdWswdE5WaUhwWG10S3JPWkZHelhnaWNk?=
 =?utf-8?B?ZzZyT1JXWHBSMHZJTFd3eUo4cXZlRlNaYnRhWTdNNExaZ20wbUJhZEpaTGlF?=
 =?utf-8?B?empLekg4QWdZb0hqS1ZuQlp2b1ZyeFcwMDU2MWNHQXYyZzlybytheHE3TWs1?=
 =?utf-8?B?Z3pqYllTcmpPeEFydWVuaWVTcWxOQldGVll1OHI4d0hJWmtjMmN2TUpFTGZZ?=
 =?utf-8?B?cEc1YmhpOU9mRDl3Z0xiemJpUGpuR3g0U1RHRkwwRnVuTVlydzhoZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf96668-03db-4356-c735-08dee738606b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 14:57:25.9262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7TJLwqpIKlpf8QpZN6aMvQDTpP/dx7PIwwGl+UDh2PkMmpS4FfhWNqhRS11oTIf48gkzW7FXjU18PUtkKle9Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9700

On Sun Jul 19, 2026 at 8:36 AM PDT, Danilo Krummrich wrote:
> Adapt the IRQ registration to work with the Higher-Ranked Lifetime Types
> (HRT) device driver architecture introduced in commit 2c7c65933600
> ("Merge patch series "rust: device: Higher-Ranked Lifetime Types for
> device drivers"").
>
> With HRT, driver structs carry a lifetime parameter tied to the device
> binding scope, allowing device resources such as pci::Bar<'bar> to be
> held directly rather than through Devres indirection. However, the IRQ
> abstraction required Handler: Sync + 'static, preventing handlers from
> embedding lifetime-parameterized resources.
>
> Remove the 'static bound from Handler and ThreadedHandler and replace
> the Devres<RegistrationInner> indirection with direct request_irq() /
> free_irq() calls in the constructor and PinnedDrop.  Registration<'a, T>
> stores the IrqRequest<'a>, which structurally ties it to the device
> binding scope.
>
> Also remove the &Device<Bound> parameter from the handler callbacks,
> since handlers that need device access can embed it in their own type.
>
> IRQ handlers can now directly own device resources:
>
> 	struct IrqHandler<'irq> {
> 	    bar: pci::Bar<'irq, BAR_SIZE>,
> 	}
>
> 	impl irq::Handler for IrqHandler<'_> {
> 	    fn handle(&self) -> IrqReturn {
> 	        let stat =3D self.bar.read(regs::STAT);
> 	        ...
> 	    }
> 	}
>
> This eliminates the indirection previously required for IRQ handlers to
> access device resources and aligns with the broader goal of expressing
> every registration scoped to a driver binding through compile-time
> lifetime bounds.
>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
> Changes in v2:
>   - Move request_irq() / request_threaded_irq() to _: blocks.
>   - Add INVARIANT missing comments and missing #[inline] annotations.
> ---
>  rust/kernel/irq/request.rs | 432 ++++++++++++++++++-------------------
>  rust/kernel/pci/irq.rs     |  26 ++-
>  rust/kernel/platform.rs    |  48 +++--
>  3 files changed, 255 insertions(+), 251 deletions(-)
>
> diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
> index f425fe12f7c8..c1c6525a676a 100644
> --- a/rust/kernel/irq/request.rs
> +++ b/rust/kernel/irq/request.rs
> @@ -5,16 +5,21 @@
>  //! [`ThreadedRegistration`], which allow users to register handlers for=
 a given
>  //! IRQ line.
> =20
> -use core::marker::PhantomPinned;
> -
> -use crate::alloc::Allocator;
> -use crate::device::{Bound, Device};
> -use crate::devres::Devres;
> -use crate::error::to_result;
> -use crate::irq::flags::Flags;
> -use crate::prelude::*;
> -use crate::str::CStr;
> -use crate::sync::Arc;
> +use core::marker::{
> +    PhantomData,
> +    PhantomPinned, //
> +};
> +
> +use crate::{
> +    device::{
> +        Bound,
> +        Device, //
> +    },
> +    error::to_result,
> +    irq::flags::Flags,
> +    prelude::*,
> +    str::CStr,
> +};
> =20
>  /// The value that can be returned from a [`Handler`] or a [`ThreadedHan=
dler`].
>  #[repr(u32)]
> @@ -27,7 +32,7 @@ pub enum IrqReturn {
>  }
> =20
>  /// Callbacks for an IRQ handler.
> -pub trait Handler: Sync + 'static {
> +pub trait Handler: Sync {
>      /// The hard IRQ handler.
>      ///
>      /// This is executed in interrupt context, hence all corresponding
> @@ -36,73 +41,20 @@ pub trait Handler: Sync + 'static {
>      /// All work that does not necessarily need to be executed from
>      /// interrupt context, should be deferred to a threaded handler.
>      /// See also [`ThreadedRegistration`].
> -    fn handle(&self, device: &Device<Bound>) -> IrqReturn;
> -}
> -
> -impl<T: ?Sized + Handler + Send> Handler for Arc<T> {
> -    fn handle(&self, device: &Device<Bound>) -> IrqReturn {
> -        T::handle(self, device)
> -    }
> -}
> -
> -impl<T: ?Sized + Handler, A: Allocator + 'static> Handler for Box<T, A> =
{
> -    fn handle(&self, device: &Device<Bound>) -> IrqReturn {
> -        T::handle(self, device)
> -    }
> +    fn handle(&self) -> IrqReturn;
>  }
> =20
> -/// # Invariants
> -///
> -/// - `self.irq` is the same as the one passed to `request_{threaded}_ir=
q`.
> -/// - `cookie` was passed to `request_{threaded}_irq` as the cookie. It =
is guaranteed to be unique
> -///   by the type system, since each call to `new` will return a differe=
nt instance of
> -///   `Registration`.
> -#[pin_data(PinnedDrop)]
> -struct RegistrationInner {
> -    irq: u32,
> -    cookie: *mut c_void,
> -}
> -
> -impl RegistrationInner {
> -    fn synchronize(&self) {
> -        // SAFETY: safe as per the invariants of `RegistrationInner`
> -        unsafe { bindings::synchronize_irq(self.irq) };
> -    }
> -}
> -
> -#[pinned_drop]
> -impl PinnedDrop for RegistrationInner {
> -    fn drop(self: Pin<&mut Self>) {
> -        // SAFETY:
> -        //
> -        // Safe as per the invariants of `RegistrationInner` and:
> -        //
> -        // - The containing struct is `!Unpin` and was initialized using
> -        // pin-init, so it occupied the same memory location for the ent=
irety of
> -        // its lifetime.
> -        //
> -        // Notice that this will block until all handlers finish executi=
ng,
> -        // i.e.: at no point will &self be invalid while the handler is =
running.
> -        unsafe { bindings::free_irq(self.irq, self.cookie) };

Not directly related to this patch, but I think it would help to add a
comment explaining why it is ok for `drop` to own what looks like a
mutable reference to `Self` (and thus `Self::handler`) while a handler
might be running holding a non-mutable reference to the latter.

My first reaction upon seeing this was that this breaks the Rust
aliasing rules, but looking at the feedback for the initial patch [1]
revealed that the issue has been discussed and dismissed.

Since this is quite subtle, and to avoid this being flagged again in the
future it would be nice to explain why this is safe (IIUC
`PhantomPinned` combined with the fact the destructor never forms a
`&mut handler`, but this needs to be vetted by someone more familiar
with these matters than I am).

[1] https://lore.kernel.org/all/Z5HtHVMipAdNvOcj@boqun-archlinux/#t
