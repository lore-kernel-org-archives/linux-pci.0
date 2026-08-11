Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022092.outbound.protection.outlook.com [52.101.96.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8C7437478;
	Tue, 11 Aug 2026 11:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448679; cv=fail; b=TocJ56aNCWRwQ2KGkW1vaGHX11S0zJhYCrbtYE32Fqtr0L9fjquW5vHjfU0O8/VeLQcw4GTE2ETEQyE10xXR4wRzCTH3CQSbVvv9ykH1BTU4vQZJ8JkZAcpcXZyegXEQik2rUNBPoGAK0vw2RfjQrSdFbVwvh5R4Q5/jp1tyxZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448679; c=relaxed/simple;
	bh=/B+VZobHUUrUI70A/xrw0a61coOBr+64WDBLCPZkZbM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=fpdJMOgjN6fe11TBqw/03HCQhjwG4a68P4rIt152/K2t80hzgO8pNNIOxDfLdHejmTPuohWHqTQdgOMC2cHQeojeH+hM3dd4AE495ftAcqmMIbjBC2hmoSNB9zJ3OrHAAhH4o4Rzew+kIYF5dCPJXkLeiMkObJF02j+sbXbPhDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=aaiETaYf; arc=fail smtp.client-ip=52.101.96.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="aaiETaYf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i05/lgSS/laOCIr6XjN7xQ0d1anfvzNoBm2xbSHBvPUfKGAV8Ny5aCTDY/mz2npDsrb8x+UcNi79xh3R/GMZy98esmzpQxLsRvxjNYa0OwuUaCiFeoiNPdgBijpV7Z6Q1nuvD9sWDsehDH5W6pfl4yrhEazoBDJyZqADQ9Cg+UIAyZociXfFiIbA1zOFmwauSUEucb7tDfd7E7D6JGRlA923NzfnVo863Cd2tvYK0WLXUKYkIzEUYCrnVNH6OUrKY3ZvnsD4Tlmh+RfqbqCVemxHD36g08/Ol87LhH+0RqZl0DFU0/vitrePZuowJGobbyESrhy2g9P3Z29PlBAThg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFb+gzVrz9waZ+62V4gpJCTpdcv9VUjRpCKN5A3njI8=;
 b=I7/yK4KUCLtrQtOuebgOgxxMEZSi+0+Lwcw0Dyo0d7X8SnJXTbFqpbm0zOB/IrWtFdH9CY7MoDFYyNTMBCS4R7zzpAd+UHjMPwYeMx9cLfieXRL1yd7k+QBWzMVF+5O8Aeup4aBOp7TELYh1RvVc0RwbQ7f7f/tIZQnHb9hxnLK8eE77e+pSg8b01V59eSdLZd69mO4SOjmQ67Ad8FlLVQKVWMCBQlDunB8U8leNLjv/IW15AT1vaIoohDXSz9lu5ZEKtCWFM4ORG6AlFclTVsaHJsgCypOqwnM7GmNjB0GD2wCSe1S4pIKc7HNjOPfK33PqvAADobOszQC6kJ+h5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFb+gzVrz9waZ+62V4gpJCTpdcv9VUjRpCKN5A3njI8=;
 b=aaiETaYfvuQ3inhB7Wj7bKXGowLTP0q/fAIQg7Z4TWTcGhbeCUPqfhNHl9TBYJhcKe/Hgwm0buDsnY2WJ/i5HWovzng5qJDQI8woBRDIHP3C6hSeb/EKqVnzpBtbLaK4Njy3UM9kN0675xCsK4xydPuefA0Mi1X7KXVYgv2dJLw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWXP265MB5879.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 11:44:32 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 11:44:32 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Aug 2026 12:44:30 +0100
Message-Id: <DKM379N6SYPU.11KDELXPAG4UL@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] rust: pci: convert IrqVectorRegistration to a
 lifetime-managed owning type
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <aliceryhl@google.com>,
 <daniel.almeida@collabora.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <tamird@kernel.org>,
 <acourbot@nvidia.com>, <work@onurozkan.dev>, <jhubbard@nvidia.com>,
 <ttabi@nvidia.com>, <apopple@nvidia.com>, <ecourtney@nvidia.com>,
 <shashanks@nvidia.com>, <zhiw@nvidia.com>
X-Mailer: aerc 0.21.0
References: <20260810224800.2314458-1-dakr@kernel.org>
 <20260810224800.2314458-3-dakr@kernel.org>
In-Reply-To: <20260810224800.2314458-3-dakr@kernel.org>
X-ClientProxiedBy: LO4P265CA0131.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::12) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWXP265MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: 41ae9ba8-7633-4305-a614-08def79de87b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|10070799003|366016|56012099006|10067099003|6133799003|18002099003|22082099003|4143699003|921020;
X-Microsoft-Antispam-Message-Info:
	V0TMh5KL+4ZwfeZZc4mFET+VY8QSALdO1hT4rkYq0MRaibC5x1jdGbmyaiBKQFNzHIl4zvuxPyJOv5ba5hRailuCMTTHbvMv+I8HZOj+5Huj+dDmLWI6AUZvRCPi9Ana7fG4BSpo5je0fAt62ZAkvFE17ULlKcR59BruDWlbQFaucvezvNrjchin+QqywtGjeCIKUbURfEeN3oXw+/tCfyvBM1LdgPb7vi/wh2kUvq2hLr3wjg8lG4Qf8vrtkgX2vFr/kPnf4eH3Qq6pphkOowiEoXXgY9tl0D0jFncisHH7KwFotAQe+EKezncSvLCWSDZGl+e5aOp5q+WO65xxi+NCGaAkbmNttaTJp60bNhEsEH6ISSH6WI0RDdPGvqdyaJhyiMVrDZNekyZkhJxAAgm7uFabbM2CbKnevQS2jM0iN+8EAEmwRBir22m10Z/u+nHbxfuE+3vc7rwngOlwkzPKiRyicw2nZO18Et09nCFD3P7NP3Ab+S47jvJpHuzwFIAfpcHZpGz7q74JbLRROaaJ3FsP1sReEPdu1Pac/5epAfltLCy0pAjoraM1ms77v82PgQkUyneEcdkPbSem+h2u7DLTa6ObTrS69NhKK5rKrVTRzORkkVTHq3vg9/16hfqPjEIyHc/Cycaru05wIPXyQiWrY3O63iU34C/RZc4VB8ENwF79FF268zXxYZQwSLAawASmvNYvIollDouzQg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(10070799003)(366016)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(4143699003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGp1VW04cE1NWGJBMGZ2dEVtN0t0WVM0VjZ1NkUxZFphWEt3aUt4aFZFM05w?=
 =?utf-8?B?VmtFTHR4Mjc1UmlQMnltZ1g1RW91YW02UkJSWFduUTlrd2crQUNEVndtdW9F?=
 =?utf-8?B?YVJmMlFyd3RiSzBxTlRndnIzSzlQaUlKSFFuTG9qbFpITTJSQU96cTJkb09s?=
 =?utf-8?B?cW9QTzV6eHJPV1EyVkMycG1zdHNCU2UycFgwQ2NUeGdFczN1OHlaNklJaC9h?=
 =?utf-8?B?bzU3MUJTcnR6SXF0YnJLdHk2aG9HeVJHM0VpRURPK2JXei8rc0FjSVdqWFM3?=
 =?utf-8?B?Rjk3eERrVDdkUjNhTnM4R2NLUEZZOWhZVkJWQk42ZHRuQjM0VHliZzcrRXV3?=
 =?utf-8?B?Y0xieSt1d0ZHZVpWUTFTMXFxMjBsVDVsamV6cWNaUkJpYWFtb29UeWNnVnRa?=
 =?utf-8?B?N2V5bk9nTWtocDQ4NVh3SHZIN3BvbElIYzhtdzJDWVFPNmtlWWFoREp5S2kx?=
 =?utf-8?B?YTJzd0lhcmd1MmpNNThaTFQ2b09hZk4wT1JzU3R0RVloMEU0WHZvNEZXeFdk?=
 =?utf-8?B?NEh2dnZJd2dWeUpMcFlmc0VFVGJJRkhPRVJObEJaMmZJNmJRbnNSbGZ6K1hP?=
 =?utf-8?B?SVE4RVc4OUZvQTNjVHUwbnJjQTYxWU9TYVBGaHlQWHN0MXdIOWtiTlhpOCtC?=
 =?utf-8?B?NTJMYjhCOTNLWE5qNkdQb3lCblRtS3FoenMrS0wvZ3lNRG1wZVl0MUVrcUM4?=
 =?utf-8?B?L0hsU3N2RHJCU05ZMlQ3Qm5mVUl1aW5VOStRNnpkYXg0Vnl1ZXVENzR1TmF3?=
 =?utf-8?B?WVl0clJlQXhISjlCc1o3RFNjYlV3Z0xMVmdFZDdOVm5rMUVZS2dUclI1TDBj?=
 =?utf-8?B?UUZ5R1d2MXhCWnEyZ2Vpb0k1SFNnQXN5cGU3TDhpZnRQWmtMMjk3QmlTeUYz?=
 =?utf-8?B?dGNlS2R4VzNnSXNmcEpYT04rQW8zU3FTcnV4c1RwdGp0QnFwQmMyMmFiMHlR?=
 =?utf-8?B?T253VGVGeCt5K0w2TWdBZm9jRWpVNlZLQlo0TUZwSFBOMDVsbllCcWI0Q1BM?=
 =?utf-8?B?dXppY21GbVF5Z0k3NnpheVhHSUZjVzV6MFhScW5WYjlrK1VBWjYyMUR0Y2hH?=
 =?utf-8?B?Mkkzd2VoZzJlOVhJOE9nSkQzMzNYMHpZZ25MSDYvK2dWN0J2WnF2aHo3YU01?=
 =?utf-8?B?aGs1T0syaEZMNFZEak45YWdkT3NXMUd2bjZXZC92c0FQUWM2ZHk5YnJTdWxX?=
 =?utf-8?B?b3ZHWkNDcVpEWVpnMm9KQTRRTEJBOVovWW1ScnBBc1FkVHVYWkY1ZWthalpa?=
 =?utf-8?B?Tjc5V2NoTzF3U2Z3c2owaWpHa05nTXlmL1lYcWNSbkVqZFkyRGs1T1FtekZE?=
 =?utf-8?B?SE5SOG9CMUtKS0thOUxKQjRjMTdqZUk1SmxkaVI1S2szU3VBQmdvQXYrUVF1?=
 =?utf-8?B?S092WkJWbWJiOG9BcFdkVER3aW84SHNleGh4TjdrdGx1YTQzdm5LVWdqRVFm?=
 =?utf-8?B?US9pNHpXeUxIM21jR01ZRnplajQxRm4yTG1JRXh3SFVkMjNXK2czVXNsVUhr?=
 =?utf-8?B?TnhEcC90dFJsNXJOa1k5N0RpRThRVlVRZ042V2FLUWFyQXFCaXY3M0lUL0JE?=
 =?utf-8?B?bW1ZUlowdkVhS0hraEswcWw5TEFaQlpLSHYvMWlzQmY4Z0R6VVlTUnljQlNu?=
 =?utf-8?B?d2YxTGFWYmxqKzRhN1kwenBrZURRY29MWmpFSE0vVnlydnVOaGtjQ2FKRjVs?=
 =?utf-8?B?eUpaSy8wd0tpYjJXN3o2MU9lQW9lSzZUMFNJMUovZW5jNjladnY1ZlJmdlc4?=
 =?utf-8?B?K1N4d1FBdG1pdFZiSm9OVzYvdU1CYWYyTzJhYlByaWVrU0FOMlBzL0h4ZzRu?=
 =?utf-8?B?UlhaZlhHanVOcHVrK0c3M3VrTDl2NjBlTmpvYU1wQU5FRTMvTDNtS3EvWGJH?=
 =?utf-8?B?aS9xK1hadmtIZnpPazZxRkZTTGM4OENVWTJWZmQxUy9ZMDcxSXhsOEQxN0tx?=
 =?utf-8?B?Y3dxY1BDcWZ5Y0szL0xubnNZazVkNjhNdEVJb05GVGNGQUM2ajRZRWlhbFN1?=
 =?utf-8?B?YUNnMUNoblh5RGVaUTMvVmxuZU1GL1ZzQ05uUHc2bE5MY2JtQUJsb09VVFJO?=
 =?utf-8?B?MW5laVB3c29oZmVGeG9iUHF6RktWVWhyUmtORmxEdUdLY1piTWZXcTAvdEtn?=
 =?utf-8?B?aEJFVVg4ZEVSWCtPNGYyeU9ieDIxNW1rTFVSdkJvQytCK3EyV01ZVTQ4aVpR?=
 =?utf-8?B?UUhJRkdxZzVoeTZldnQ2c0puR3dWS3l3aGxkdzhzZXVtMVhTK0hGU0dYaFZH?=
 =?utf-8?B?eEhyQzd1cFFYaUxFM09wM2hBdEhMVWlFc3FDL1YyeVc5WUhXWWZhWjZXTllx?=
 =?utf-8?B?UkVRM0NlakRJREVSUnE0Sk0wb29mWS9HOVBueDE4Rk8veE5WMGhIZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ae9ba8-7633-4305-a614-08def79de87b
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 11:44:31.8038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2d4OAEjOOBtbZfqbyQhmPUaqnb8MCBZjj+g1pKvJCESt0KpGfToKMDcgG7YFCbA1E5IDP2nK7pCHXeo2+XSPNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB5879

On Mon Aug 10, 2026 at 11:47 PM BST, Danilo Krummrich wrote:
> Convert IrqVectorRegistration from a devres-managed internal type to a
> lifetime-annotated type that owns the PCI interrupt vector allocation.
> Dropping it frees the vectors.
>
> IrqVector gains a reference to the IrqVectorRegistration it was derived
> from. This reference flows through IrqRequest (via the IrqRequestAnchor
> generic) into irq::Registration, creating a borrow chain that prevents
> the vector allocation from being dropped while any handler is still
> registered.
>
> alloc_irq_vectors() returns IrqVectorRegistration<'_> directly, giving
> drivers explicit control over the allocation lifetime. This is also
> needed by e.g. net and block drivers that re-allocate vectors, e.g.
> during queue reconfiguration or device recovery.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/pci.rs     |   3 +-
>  rust/kernel/pci/irq.rs | 149 ++++++++++++++++++++++-------------------
>  2 files changed, 83 insertions(+), 69 deletions(-)
>
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index c6417af2bb17..2757a0cc0f11 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -51,7 +51,8 @@
>  pub use self::irq::{
>      IrqType,
>      IrqTypes,
> -    IrqVector, //
> +    IrqVector,
> +    IrqVectorRegistration, //
>  };
> =20
>  /// An adapter for the registration of PCI drivers.
> diff --git a/rust/kernel/pci/irq.rs b/rust/kernel/pci/irq.rs
> index fea484dcf9cf..38a7d72dcda7 100644
> --- a/rust/kernel/pci/irq.rs
> +++ b/rust/kernel/pci/irq.rs
> @@ -7,17 +7,15 @@
>      bindings,
>      device,
>      device::Bound,
> -    devres,
>      error::to_result,
>      irq::{
>          self,
> -        IrqRequest, //
> +        IrqRequest,
> +        IrqRequestAnchor, //
>      },
> -    prelude::*,
> -    str::CStr,
> -    sync::aref::ARef, //
> +    prelude::*, //
>  };
> -use core::ops::RangeInclusive;
> +use core::num::NonZero;
> =20
>  /// IRQ type flags for PCI interrupt allocation.
>  #[derive(Debug, Clone, Copy)]
> @@ -78,6 +76,7 @@ const fn as_raw(self) -> u32 {
>  #[derive(Clone, Copy)]
>  pub struct IrqVector<'a> {
>      dev: &'a Device<Bound>,
> +    reg: &'a IrqVectorRegistration<'a>,
>      index: u32,
>  }
> =20
> @@ -86,10 +85,11 @@ impl<'a> IrqVector<'a> {
>      ///
>      /// # Safety
>      ///
> -    /// - `index` must be a valid IRQ vector index for `dev`.
> -    /// - `dev` must point to a [`Device`] that has successfully allocat=
ed IRQ vectors.
> -    unsafe fn new(dev: &'a Device<Bound>, index: u32) -> Self {
> -        Self { dev, index }
> +    /// - `index` must be a valid IRQ vector index for `reg`.
> +    /// - `dev` must be the device `reg` was allocated from.
> +    #[inline]
> +    unsafe fn new(dev: &'a Device<Bound>, reg: &'a IrqVectorRegistration=
<'a>, index: u32) -> Self {
> +        Self { dev, reg, index }
>      }
> =20
>      /// Returns the raw vector index.
> @@ -98,75 +98,72 @@ fn index(&self) -> u32 {
>      }
>  }
> =20
> -impl<'a> TryInto<IrqRequest<'a>> for IrqVector<'a> {
> +impl IrqRequestAnchor for &IrqVectorRegistration<'_> {}
> +
> +impl<'a> IrqRequest<'a, &'a IrqVectorRegistration<'a>> {
> +    /// Returns the [`IrqVectorRegistration`] this request was derived f=
rom.
> +    pub fn vectors(&self) -> &'a IrqVectorRegistration<'a> {
> +        self.anchor()
> +    }
> +}
> +
> +impl<'a> TryInto<IrqRequest<'a, &'a IrqVectorRegistration<'a>>> for IrqV=
ector<'a> {
>      type Error =3D Error;
> =20
> -    fn try_into(self) -> Result<IrqRequest<'a>> {
> -        // SAFETY: `self.as_raw` returns a valid pointer to a `struct pc=
i_dev`.
> +    fn try_into(self) -> Result<IrqRequest<'a, &'a IrqVectorRegistration=
<'a>>> {
> +        // SAFETY: `self.dev.as_raw()` returns a valid pointer to a `str=
uct pci_dev`.
>          let irq =3D unsafe { bindings::pci_irq_vector(self.dev.as_raw(),=
 self.index()) };
>          if irq < 0 {
>              return Err(crate::error::Error::from_errno(irq));
>          }
> -        // SAFETY: `irq` is guaranteed to be a valid IRQ number for `&se=
lf`.
> -        Ok(unsafe { IrqRequest::new(self.dev.as_ref(), irq as u32) })
> +        // SAFETY: `irq` is guaranteed to be a valid IRQ number for `sel=
f.dev`.
> +        Ok(unsafe { IrqRequest::new_anchored(self.dev.as_ref(), irq as u=
32, self.reg) })

Why is this anchoring thing needed instead apart from the lifetime that alr=
eady
exists on `IrqRequest`?

Best,
Gary

>      }
>  }
> =20
> -/// Represents an IRQ vector allocation for a PCI device.
> +/// An allocation of PCI interrupt vectors for a device.
>  ///
> -/// This type ensures that IRQ vectors are properly allocated and freed =
by
> -/// tying the allocation to the lifetime of this registration object.
> +/// This type owns the vector allocation; dropping it frees the vectors.=
 IRQ handlers borrow from
> +/// this registration and must be dropped before it is.
>  ///
>  /// # Invariants
>  ///
> -/// The [`Device`] has successfully allocated IRQ vectors.
> -struct IrqVectorRegistration {
> -    dev: ARef<Device>,
> +/// `dev` has an allocation of `count` interrupt vectors.
> +pub struct IrqVectorRegistration<'a> {
> +    dev: &'a Device<Bound>,
> +    count: NonZero<usize>,
>  }

