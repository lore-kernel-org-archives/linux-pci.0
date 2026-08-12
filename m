Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020132.outbound.protection.outlook.com [52.101.196.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676AE3559F2;
	Wed, 12 Aug 2026 16:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552020; cv=fail; b=DsGglvebZMTZc9cJGHqMfY8AXecMLs+HL6p3OAu07RbIVBmqrwTflsAqjwPuwZ+EOZdm2bXQ6d3K7u2gj0kqpe8i8zMyc2AWztt7LcarhDEG/NaLYeiTBxSHhdYyFJay/LCRNiL6mt49/w4PTsmbiyahSiiOR3L7gYMuGTE3Cxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552020; c=relaxed/simple;
	bh=vaVbSIyNl5z5vC7/9jhrrL9TwyTp/MMjtgDkYSDF9VU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=oQocWp+jMnGR9tNLnapiidwzHPYYS3ldco0dnZc2Ra5mJbHEkkErOXT14N8nTv1gfSuLHB/LamqcTQgBaAYIpvZl6DXebvXVM8vQGdEqCgi5VnEysB9i6VsI72nlECuW9r9NtkAGjswm2TJi6j1zjImUwj877SOsiKM63n+5/ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=lSxZxqy5; arc=fail smtp.client-ip=52.101.196.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="lSxZxqy5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+77nV6kuw72bWa2DuDGfT6hViAwDjMT7CjKSp0UJeXwBbY3YurjXLWHffpMeJPVixPGVjBFDFhcuZmn46uORz5k1OwvlRW9lFbt1GwNZPvrGqFH1asQPNOSyIPzdv/6oC4Tpwj0VjNnFw9EqnNbh03Vhn7TMUmefuUt+YAfy/to0x2GFtJ2hchowzI42Hs74wkqQG4tWIAmm323mU51KlvovhUfrRTzedLkJbHgsUgdQhny4NY2Y182AOkRGBwf+lJYnzfO+ty2EsePIaUUSwaKq+oE77EqlkN/HUd0D51+H0o5a0wBllYXY5s/Ss0MYQ1WBEWaTIq7kRLu0sYnEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdBHQx644AQQneJjlBoc3D/R2DSmVqTcCDe1rN9xTxs=;
 b=Pwr6ft+hJGeudjVaFZKZJkKnI9eEn2z2bipnuSP9JT5PPpUDf1XeeuIg5/N/nv8DiRg+LH8Gp9R0JWiYQhmzAAT+XqArvt+Cw0UIe9bNIgWc5vT4q7sHV/Nxby76NQaTjYJCVk9I/JNhc1pcKoIBDqto9+3Lc6OYFJF19Wg5lW6YxZ3eUUxxNRbF7R1s5UyonCzKbwhAITkAAqzVs5xo9cIzZTpaDB58r9aJiNnsBdCWNtJNcZM4cmkOIpTh5PYCi1UJyohdh+Euq2/PqDpeJx6P98CHPPcWVpmLRS+5yd1vEZq1pyV3BJnzXVsqXO8ModV3m/o5Ps1vg8qvrAcv0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdBHQx644AQQneJjlBoc3D/R2DSmVqTcCDe1rN9xTxs=;
 b=lSxZxqy5hUWJWo7r1ROrKPjRQmmkc7X0ym5kbbnK+J61PzqTNb/TY9scIbCBf2VjJ4RRI7u6z7GdA8T7K7RUY17SOediMzgt/n803/TQ2Ntyzh5k6ZNvgiMdiubgww+MX3G6nZsNLzdPNqcRHTPQodajvSX0zdM0jt1FP4+jimI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO2P265MB3437.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:19d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 16:26:53 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 16:26:52 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 17:26:52 +0100
Message-Id: <DKN3U000UGRL.2MOXT25O11UE0@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] rust: pci: convert IrqVectorRegistration to a
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
References: <20260811233952.3000968-1-dakr@kernel.org>
 <20260811233952.3000968-2-dakr@kernel.org>
In-Reply-To: <20260811233952.3000968-2-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0675.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::19) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO2P265MB3437:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d5f1dd9-a426-43d2-80ad-08def88e849c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|376014|1800799024|23010399003|921020|6133799003|22082099003|18002099003|4143699003|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	jJekVn6pOqb+nYYJeCyJHfHj9y371LJaEk5cpQFJ3kEAhFCw/pOtXqEuGWVjGx4NAbdRCeizpVyHLhT0JRpFtsvS3gMPK3xGgjmMhSlBhXXzy1mwZozkk54LFKQ8LlPbQ/m2omE50wz4wJpA54W/MR9W/0NAZztAqbOWXgvN2ATC7ZP/lYDR5RyQSq2ZlfwBmxIO54iI4Uewrc30vvaYqnX6/g0ABJaVkg9YPxfx1x6MZoAwdT/m8UPc9Gp9qT2rqivS38CkNt9Bue4gjoiFrCZHe4Ii/IRVm2tYqZU0X8WC5EY67YG/VQkAopuOMzm7SoEoIoAl9BIGd/qsgqCv95xEX+kD8/kTy4k4dQPvOprGRR6PwnFSUmqAa4IV+EgCwpEMuGNHZ+3bbgV0YB2yD7SzTc1mNLESnVpjHDfpIPmCoUkcYN38TPf9hc9/83ue2goyy42uGYXzWmdpwF6qxtOX+W00n/uAtgD1ciKdk5HwD0Z81SAj33fEKq0X2XY/wyNIPk+AHprpUfd7yWPSUyR076Xd9BZ2A7ZkYG5YC8XZueQ6WSR1mb9NOlznh6n9qq1wpyVaQQGVR6nmmkTRnA/uAJ8/G1xPDw5kQcQBgdVufWhLSNmHz4azmbMtRwMF/AOoE/HjYtDNF7YDHrYl06v5xGsaSEuslmMhtCFCrKxIy+ekzuO0lfTi/+VPEkLM4Vh154UVqhg60e64Sz5H6A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024)(23010399003)(921020)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(10067099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Znk3ZWEvTTRlcFRVTU5zSWJabmgzT3pQTXpCT1hBSWRGZllhak1FVUsrYllI?=
 =?utf-8?B?OGZEaXUxekFRZUhQcVBLNHVma2xpUWRKUTdLWDJac3h3SWFzZU52enNNRWZR?=
 =?utf-8?B?MTNiU2J2d0d1T01lYTBQdzdSS3V0ZDdRcVUxU0kwZzdtVEFJMC83SDBCcWJv?=
 =?utf-8?B?ZTdOMlM4NkErc3FCZHVTaHNOOXQrQ3Q0ZjZieWNmRzlLVzJuckVqbng2ZUY1?=
 =?utf-8?B?anZRL2QzbnA3YzBmVm95TzlWdG1TUlVhbVBxclR5bGhRVmttaENOTTRnRFVZ?=
 =?utf-8?B?S3kwTWdPcWh4QnIrTWpIaWhqenBsZG5lK1IwQ2xNYTYxY0IzQTJVeHh4aXJz?=
 =?utf-8?B?RkU5Z2pJcmk2U2sxTDdKVW5Ca0M3bndRamNRdHUwUTVYSU9HbHdWS1ZEL3dv?=
 =?utf-8?B?N0FPdnhValVhUDc5Qy95dS9SRjJMY2g4RWc3cExFa3dBVlEvdVJFZHlvU0kr?=
 =?utf-8?B?UzFtaXFkL3pwUmt6UnVCb3h2YlNEY2QxVlp1ZnlwUDd3R01qYjVSUlE4Q1Vr?=
 =?utf-8?B?ZlBoYjFhRW1rK044azRtZGNZTkJZWXdTZkEwd05HVHlJaFBGMEE0bzhqUldv?=
 =?utf-8?B?N3JQNk5PaXZEckdQS2pPVkNjdHVuNTlNSERLOWxLd0hHN25PQUxjZ05WNmJD?=
 =?utf-8?B?b1lQOE9GeU1waHdqc3oxRDJCekNXazRzUUIwMElFMnRteTdkc1FBSThLQXJP?=
 =?utf-8?B?cFpzZUlGaDN1c1VGN29DV0xwWTlJT20wS2FySzlKSFc3dnI0YmJNUGJoZ2tP?=
 =?utf-8?B?T0VOYzY3aVgrMHJYVHN3bWZ3WHZmMS9BVlY4SjZ6Z2x4bEVhb3lRc05NWkdD?=
 =?utf-8?B?UUFxWFp5dTQ0OW1oUlRoOFJ6WWc2czh3NkpRWkRJdkdKaFI0Q29qNHZ2L0tM?=
 =?utf-8?B?YTJWdzNXeWF0bDZMZlJ2WTNoRTRJdXNRMVlmS3hkeWk2NXpSa0RVVkdxUU5S?=
 =?utf-8?B?TG4wWmU5Y0hwYWZsTy9TdWRVNWd3TEhyL0cvMWZnd24vaWgzRUY2TVY0U3Rw?=
 =?utf-8?B?V2doNUdTVDVxZmJ6eGNpWmpvVVE0WWlCeVl0VGJZRUkzbkpDdzZzaFVESXlV?=
 =?utf-8?B?K3h4MlQwaTBpTnRESUowS0hBS2pueFVJRE5SMzh4ODRFdWxMQXZxVURYOWFl?=
 =?utf-8?B?Y3NueWxjWWpkZ1k5UjFsU0xDS3F6dWpzQ21iWkx4NklVQ2ltRHBMUmZKNEN1?=
 =?utf-8?B?bzJTZ1ZsRW5sZGJsVGs3UGJMNEFuazY0RzF2OENjSHNtdmQyeUhVSlJtYTR5?=
 =?utf-8?B?UGdXT3lNdlVETjJiTDd4MURYOFVlNFFoK3J4Q1o1MEY2ZUJWSzh4d0tLbG5L?=
 =?utf-8?B?Z1dBemhDcGxpSVE0T1h6YVVVM3RYL2p1WjVZOHhqNzhlemZ3SytSeVBSWDRO?=
 =?utf-8?B?MmVpNDQwQUpGUUV6RnZuWCt0eDFoWGRYdHphL3JMZ3piYVFReHhESnlrVlhQ?=
 =?utf-8?B?NFhKcG9HMkd5VFFOaTM2YUdzQmx2N25kRWZ5Z0gxeHA2UVYrREp5ZEFGaHVW?=
 =?utf-8?B?VVpPMDdIZGlkaks5d09ydzlJWnk3U01BbVJCcFZGa3lDRmRDMEphWlIra2pR?=
 =?utf-8?B?UUk1T0c4VlgwZW44Rjg3NVUzRTlYdmZkRFd0OWk4RFpFS1dERG8wU3NFREo5?=
 =?utf-8?B?Q0lwSlgrT2I2K1QxZE5SRDVnT0RSaklOc1hDRjk5dm5pRUkwaktENWNGS3Rv?=
 =?utf-8?B?TVhZaGUvUTVMZnhlam44UU9iU3VkelZHb1o1eVRuK3ByZEhrY1hacHlIVSt6?=
 =?utf-8?B?dW5tZzE3U3VCdytNRUVjdGQrdlVUeFZsVzlSbjBGRFJyTHdFMWJ2NW02R0JH?=
 =?utf-8?B?cFhxUUpPbWFUSXhQeVFuT3VtL3hGWVVjUWpwYWVxYVRneEMrWUJSVmpLNUFa?=
 =?utf-8?B?WCtHSzVENzRkOGxvZ0U2YUswYzZycUE0RkZ6WmVTRWZaWTR5eVdwMHdGRjdo?=
 =?utf-8?B?WkVpU2Z3Yk1hKy92NDVhcU02Y1RxYjNLeGQ5T3g3ZUhPdGx0ZkYyZHc2Wmow?=
 =?utf-8?B?d01aVGVGSUVGQUFTdFdzK1ByQTNFWDAzVlhiS3FVMlhId2xwVjdQWFg4RkM0?=
 =?utf-8?B?U1FyV1crTklGaForQnFYcEJrVzVJeUlCNWlpRnZsMHcvTVNuVGcxemdtMGx6?=
 =?utf-8?B?d2RkL0QwZWt5UDJlcVkrL3E5RnE5b3FqcGRuNUZCMFhZM2tsQ0dZWmJISTJV?=
 =?utf-8?B?ZUN5UHdONElyOTBDSXUyRytvQk0vNXNObE4rYXRYR2JTSDBZSXB2R2J2ZGpT?=
 =?utf-8?B?cVJ3SGhaMUxzV3F2NmhzMWw1SlZ3blMvOVVMaS9ZRXVoQ1JoRDgwWWRubzAv?=
 =?utf-8?B?K1gwd2c4WTUyYmZTSUgzYVFITTNvLzNaWFJIbzZBc2xZNFJ0UGh6QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5f1dd9-a426-43d2-80ad-08def88e849c
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 16:26:52.8107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DiZZxHRYMBOaCiPkS2CR4zpw//53zdHgQULlEgdcGw1dCt9BoludjifdupPN6UfMgk6BXkxdvMVPWMXo+ruhgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3437

On Wed Aug 12, 2026 at 12:39 AM BST, Danilo Krummrich wrote:
> Convert IrqVectorRegistration from a devres-managed internal type to a
> lifetime-annotated type that owns the PCI interrupt vector allocation.
> Dropping it frees the vectors.
>
> IrqVector gains a reference to the IrqVectorRegistration it was derived
> from. Since vector() borrows the registration, the compiler prevents the
> allocation from being dropped while any IrqVector (and hence any
> irq::Registration built from it) is still live.
>
> alloc_irq_vectors() returns IrqVectorRegistration<'_> directly, giving
> drivers explicit control over the allocation lifetime, which is needed
> by net and block drivers that re-allocate vectors at runtime, e.g.
> during queue reconfiguration or device recovery.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/pci.rs     |   3 +-
>  rust/kernel/pci/irq.rs | 127 ++++++++++++++++++++++-------------------
>  2 files changed, 69 insertions(+), 61 deletions(-)
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
> index fea484dcf9cf..8e0651587829 100644
> --- a/rust/kernel/pci/irq.rs
> +++ b/rust/kernel/pci/irq.rs
> @@ -7,17 +7,14 @@
>      bindings,
>      device,
>      device::Bound,
> -    devres,
>      error::to_result,
>      irq::{
>          self,
>          IrqRequest, //
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
> @@ -78,6 +75,7 @@ const fn as_raw(self) -> u32 {
>  #[derive(Clone, Copy)]
>  pub struct IrqVector<'a> {
>      dev: &'a Device<Bound>,
> +    reg: &'a IrqVectorRegistration<'a>,

The registration has a refence to the device so we don't need to keep both =
reg
and dev?

>      index: u32,
>  }
> =20
> @@ -86,87 +84,81 @@ impl<'a> IrqVector<'a> {
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
>      fn index(&self) -> u32 {
>          self.index
>      }
> +
> +    /// Returns the [`IrqVectorRegistration`] this vector was derived fr=
om.

#[inline]

> +    pub fn vectors(&self) -> &'a IrqVectorRegistration<'a> {
> +        self.reg
> +    }
>  }
> =20
>  impl<'a> TryInto<IrqRequest<'a>> for IrqVector<'a> {
>      type Error =3D Error;
> =20
>      fn try_into(self) -> Result<IrqRequest<'a>> {
> -        // SAFETY: `self.as_raw` returns a valid pointer to a `struct pc=
i_dev`.
> +        // SAFETY: `self.dev.as_raw()` returns a valid pointer to a `str=
uct pci_dev`.
>          let irq =3D unsafe { bindings::pci_irq_vector(self.dev.as_raw(),=
 self.index()) };
>          if irq < 0 {
>              return Err(crate::error::Error::from_errno(irq));
>          }
> -        // SAFETY: `irq` is guaranteed to be a valid IRQ number for `&se=
lf`.
> +        // SAFETY: `irq` is guaranteed to be a valid IRQ number for `sel=
f.dev`.
>          Ok(unsafe { IrqRequest::new(self.dev.as_ref(), irq as u32) })
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

I wonder if it should be called "len" as I view this as a collection of IRQ
vectors.

>  }
> =20
> -impl IrqVectorRegistration {
> -    /// Allocate and register IRQ vectors for the given PCI device.
> +impl<'a> IrqVectorRegistration<'a> {
> +    /// Returns the number of allocated vectors.
>      ///
> -    /// Allocates IRQ vectors and registers them with devres for automat=
ic cleanup.
> -    /// Returns a range of valid IRQ vectors.
> -    fn register<'a>(
> -        dev: &'a Device<Bound>,
> -        min_vecs: u32,
> -        max_vecs: u32,
> -        irq_types: IrqTypes,
> -    ) -> Result<RangeInclusive<IrqVector<'a>>> {
> -        // SAFETY:
> -        // - `dev.as_raw()` is guaranteed to be a valid pointer to a `st=
ruct pci_dev`
> -        //   by the type invariant of `Device`.
> -        // - `pci_alloc_irq_vectors` internally validates all other para=
meters
> -        //   and returns error codes.
> -        let ret =3D unsafe {
> -            bindings::pci_alloc_irq_vectors(dev.as_raw(), min_vecs, max_=
vecs, irq_types.as_raw())
> -        };
> -
> -        to_result(ret)?;
> -        let count =3D ret as u32;
> -
> -        // SAFETY:
> -        // - `pci_alloc_irq_vectors` returns the number of allocated vec=
tors on success.
> -        // - Vectors are 0-based, so valid indices are [0, count-1].
> -        // - `pci_alloc_irq_vectors` guarantees `count >=3D min_vecs > 0=
`, so both `0` and
> -        //   `count - 1` are valid IRQ vector indices for `dev`.
> -        let range =3D unsafe { IrqVector::new(dev, 0)..=3DIrqVector::new=
(dev, count - 1) };
> +    /// This is at least the `min_vecs` that [`Device::alloc_irq_vectors=
`] was asked for.
> +    #[inline]
> +    pub fn vector_count(&self) -> usize {
> +        self.count.get()
> +    }
> =20
> -        // INVARIANT: The IRQ vector allocation for `dev` above was succ=
essful.
> -        let irq_vecs =3D Self { dev: dev.into() };
> -        devres::register(dev.as_ref(), irq_vecs, GFP_KERNEL)?;
> +    /// Returns the [`IrqVector`] at `index`.
> +    ///
> +    /// The returned [`IrqVector`] borrows from this registration, ensur=
ing the vector allocation
> +    /// remains live while any handler is registered on it.

nit: I think this is redundant information as it's just stating what the
signature already conveys.

> +    #[inline]
> +    pub fn vector(&self, index: usize) -> Result<IrqVector<'_>> {
> +        if index >=3D self.count.get() {
> +            return Err(EINVAL);
> +        }

Given that the error is for out-of-bound access only, perhaps return `Optio=
n`
like `get()` function of various containers?

> =20
> -        Ok(range)
> +        // SAFETY: `index` is within bounds of this registration's alloc=
ation, and `self.dev` is
> +        // the device it was allocated from.
> +        Ok(unsafe { IrqVector::new(self.dev, self, index as u32) })
>      }
>  }
> =20
> -impl Drop for IrqVectorRegistration {
> +impl Drop for IrqVectorRegistration<'_> {
> +    #[inline]
>      fn drop(&mut self) {
> -        // SAFETY:
> -        // - By the type invariant, `self.dev.as_raw()` is a valid point=
er to a `struct pci_dev`.
> -        // - `self.dev` has successfully allocated IRQ vectors.
> +        // SAFETY: By the type invariant, `self.dev.as_raw()` is a valid=
 pointer to a
> +        // `struct pci_dev` that has successfully allocated IRQ vectors.
>          unsafe { bindings::pci_free_irq_vectors(self.dev.as_raw()) };
>      }
>  }
> @@ -214,15 +206,16 @@ pub unsafe fn request_threaded_irq<'a, T: crate::ir=
q::ThreadedHandler + 'a>(
>          })
>      }
> =20
> -    /// Allocate IRQ vectors for this PCI device with automatic cleanup.
> +    /// Allocate IRQ vectors for this PCI device.
>      ///
>      /// Allocates between `min_vecs` and `max_vecs` interrupt vectors fo=
r the device.
>      /// The allocation will use MSI-X, MSI, or INTx interrupts based on =
the `irq_types`
>      /// parameter and hardware capabilities. When multiple types are spe=
cified, the kernel
>      /// will try them in order of preference: MSI-X first, then MSI, the=
n INTx interrupts.
>      ///
> -    /// The allocated vectors are automatically freed when the device is=
 unbound, using the
> -    /// devres (device resource management) system.
> +    /// The allocated vectors are freed when the returned [`IrqVectorReg=
istration`] is dropped.
> +    /// IRQ handlers registered via [`Self::request_irq`] or [`Self::req=
uest_threaded_irq`]
> +    /// borrow from the registration, so the compiler ensures they are f=
reed first.
>      ///
>      /// # Arguments
>      ///
> @@ -232,8 +225,8 @@ pub unsafe fn request_threaded_irq<'a, T: crate::irq:=
:ThreadedHandler + 'a>(
>      ///
>      /// # Returns
>      ///
> -    /// Returns a range of IRQ vectors that were successfully allocated,=
 or an error if the
> -    /// allocation fails or cannot meet the minimum requirement.
> +    /// Returns the IRQ vector registration, or an error if `min_vecs` v=
ectors cannot be
> +    /// allocated.
>      ///
>      /// # Examples
>      ///
> @@ -256,7 +249,21 @@ pub fn alloc_irq_vectors(
>          min_vecs: u32,
>          max_vecs: u32,
>          irq_types: IrqTypes,
> -    ) -> Result<RangeInclusive<IrqVector<'_>>> {
> -        IrqVectorRegistration::register(self, min_vecs, max_vecs, irq_ty=
pes)
> +    ) -> Result<IrqVectorRegistration<'_>> {
> +        // SAFETY:
> +        // - `self.as_raw()` is guaranteed to be a valid pointer to a `s=
truct pci_dev`
> +        //   by the type invariant of `Device`.
> +        // - `pci_alloc_irq_vectors` internally validates all other para=
meters
> +        //   and returns error codes.
> +        let ret =3D unsafe {
> +            bindings::pci_alloc_irq_vectors(self.as_raw(), min_vecs, max=
_vecs, irq_types.as_raw())
> +        };
> +
> +        to_result(ret)?;
> +
> +        let count =3D NonZero::new(ret as usize).ok_or(EINVAL)?;

I don't think `ret` can ever be zero. `expect` or `new_unchecked()` perhaps=
?

Best,
Gary

> +
> +        // INVARIANT: `pci_alloc_irq_vectors()` allocated `count` vector=
s for `self`.
> +        Ok(IrqVectorRegistration { dev: self, count })
>      }
>  }


