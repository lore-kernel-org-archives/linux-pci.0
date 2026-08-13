Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022142.outbound.protection.outlook.com [52.101.96.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A6E34CFDD;
	Thu, 13 Aug 2026 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640466; cv=fail; b=UnCnYsiivTrZIXtMq5J01Jh+H2NFv/6E2bhzYaDa93HkNWG6ADSh/bhuxr5VHGxCNpCXHMMzCo26uS40+cx8fRj1gibMK7IJY7We4dTCdLS9WKmmOelT/0ZA2WKI2GugcP3Kt8hr8tB1YaDbzPsFRtFJH3fC6wRfbx55Rcu+lr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640466; c=relaxed/simple;
	bh=aexOmstgljr9UoJ5jG01ZMCrUBJVTA2aw4kCgZHb3zs=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Dy+AJ33ZtuCarQFWGCPKFUaXocNisFX98WHmrYLFricRisu8kpBEJt1VEsw8OioU4pXCvtn3CjLvvDbiqj94w2CMv7pCD3sQ9wua5W46001+7AYAEvxhSc4+XM2znNvKeByO5GS3b5LXzaefKAU1aKZpM9bT6KtWchHwISlHDLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ehOGDbgA; arc=fail smtp.client-ip=52.101.96.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ehOGDbgA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DiEmt9FH8fVv0h8Upw0Rie0w9Zq1t7D7ZDgv1s83NnJpGgGpAJgezt1QBhZ+wHOkZeMtIDez644L2eohTMfMOm0r/HLEGJThsLzYqSRvexpxHmg5/paK03cudQ2duTxicPafhSPFJhH5asz14PSyHGvA/XNrUPRAN2LXI2je7yHqS/j5OTheO2T80WgD87W9U99gqj2qoIqUzvuBPU6zBmWjIGGT6R+ha7qoX/VzvmGdtjV1DAQp+qr5yCpG1KY7uijAaTRdky+zvwPMONFhQRGE/wGw1HWl8EYbJzlXIb9BnG1H1de9PpJJtuwoAXuYDDCh/BHF5ZU/kuxfYquZZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXyjU/GymPcR4tiTONGbzWpcOMcFFkKUbJG/P2PlZ3U=;
 b=k04qfFEie1+0S0Eldy8j6rZOzaxWFFdjooVphJOabVEDcIscE2fgaaieC8cdVVT+A0ZMh4gy1kAFUwUqetT6V2BxSJtnOKmyVWLXllkDLCBZUIKc+wKU62p95G2NwbOcbcJFuPCc+QOoktHqlFq3hMYImgwjHuBcQaKpmmwREzwFid7Odhe4SDWzW4VZGgpws+Mkvt2btXALTMr7B2Eft3Ec4r5scQMD5UvIp4n+PLv32B/lglDhOjrqBWthl1aDV6WAe3JAKJx3IDiSpGQtcrHVoRWSJDzbvVooNwFcRF0R0GVmeUr4PpPwZVaRhX8NHwJ8jO/ybffupzpnKTU/Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXyjU/GymPcR4tiTONGbzWpcOMcFFkKUbJG/P2PlZ3U=;
 b=ehOGDbgAwSuM4IEsF26L2ESZwM3J761vVOVeO/LFqI0yBIHvthHIkwMpKPe4oKprQ7xer8VbZeAJfvAThB5zuhX0V9xRFf/iE3bgZH4LGAlX2cZagmc6yNyKsGtpTufTizzMYz0WHqeIvbE0x1banz/N/DdrMOYWXJHUS/7cUIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWXP265MB1845.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:3d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Thu, 13 Aug
 2026 17:01:00 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 17:01:00 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 18:00:59 +0100
Message-Id: <DKNZ6O34IHZD.LW3GQM39XSAG@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] rust: pci: resolve IRQ in index() and embed
 IrqRequest in IrqVector
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
References: <20260813165234.620555-1-dakr@kernel.org>
 <20260813165234.620555-3-dakr@kernel.org>
In-Reply-To: <20260813165234.620555-3-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0611.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::10) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWXP265MB1845:EE_
X-MS-Office365-Filtering-Correlation-Id: f4dafa46-3839-4f50-0414-08def95c733b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|23010399003|1800799024|18002099003|22082099003|4143699003|56012099006|6133799003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	hpGos5FjgrCOFp4qQpirelZAWkm0DaXV6oQF8QMw04gBA1xr0fi05h+UcJKVZqP6Yx6flsVBgnqsUP+fiu6dGS1PWKiNl8roIgM3K5uo3Vbeaf6CFLmLA+rfey4S0byJkwYXHnEj8vPVwh1e6Kvwik464DBjQgFWMDpW6INbZJfjLiFl2ZX3KVodGdYwmKu33t+xgWwrMv1g0lZAotLZM6Pvq6uvRU1P02wwWc9aci8i66ptuo6auDq8vOBCwnlJp84MWXfFvFv1/ozmAZUCHDeixmQcVvpNX5inTmVbVCCCpK3BEVXhG5K6ZGBNnkyV+bT9aO0D49V2BDKyBUfHpHW3fRNkwBITDHhqo7CkwSK2+/LRPfjqr580/z+DkeWQMzmKCxOljZKiJpRcnoOJ9oTQHcs/pJdC5/wGcjSgO46FkM7HUF5zJLpcRNpzBOiBRDHkMzNbsxM+DsXV5tvY7AYfIA3E8cNyCyJ2Kj5ElDfiGQE3L4a0zHvpzq2yrUpfn/ftZAFjdNomV/ezabBKdFDRTAOAyioVzImX84eFEQLZHq5dg4CJvXNls97r4aWb3gKFP2htfDliMTmMhRgOEwGMF/4fhRYX0z/nWEznGyEbsCBSH0moHKqO9g1tzWtdD9nRE4xr7PUnt0YvoEpth8xUJ7sdNk/BnqsnMn81NiC+GWgNBO7jq94ZoA0Sj7Nax4mPsbs77NPvp53rJWlZ0A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(4143699003)(56012099006)(6133799003)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEZ1bHRBcmphRk5hWlJ3OGZRdFNYMTBMTWgzalY1RGJDNG4xVUdOUGlOdlNa?=
 =?utf-8?B?TXdlaHpLNzBrSlAvbmJqRVhPUjlPNlkrai9rdFljYnFDQ2Vxc0l6Mm81NFdI?=
 =?utf-8?B?NlZCOG9salhqOVY2MjdQK1NGWi9oaHlOYkk1VWpLdGZOWWNsbXQveUtSNjdk?=
 =?utf-8?B?N21lSU8yQ0QzTWhOMUlDQ3dqdkF3SVk3UGJxWGQxSEs1NnNwR1MrelJydTd0?=
 =?utf-8?B?dnQvdUw1bU9STENIa0V5Z2RLK3BvMWZVY1pMaHU1T0Q4c0JKcnk1ZXlsVllR?=
 =?utf-8?B?dVdQcmUrcnVyeTZRMFIyNXRjVDlBSlp5V21rRzhDUlUySlgwRXNMYlIxdW92?=
 =?utf-8?B?c3U1R1ByYzYwanRLNDVmVStId0pnSEtlV1ZQUlhmaGl5U25aQnZ2Z0ZpZXEx?=
 =?utf-8?B?bFJUbllseVRvblA2MUduLzIyT01EWjBwQXR3WWQ5dDlDYmN1UHpraUZWc1px?=
 =?utf-8?B?TnA4T0EyVG81RWR6WWZxVldQQjJEUU42NXBha2wvM1Y0U1NURlQ2amQyOXUw?=
 =?utf-8?B?dW9KdEwxbExaWW5tOFNjNnB3OUtpd2pIN3lJUW9YQkZFSm4yaUlUNEVWMUlU?=
 =?utf-8?B?NEJ0ZFJmTkdYWWdvWXIxV0l0djRzanVHR3FjeDZJWDJkUE5iZFlSSkJnNzZo?=
 =?utf-8?B?RjZqODRudW5MZmtjbEYvenlyRmpUNEEzd2s4MCs2c1FPRGl5dXVXNjA1OHQv?=
 =?utf-8?B?RmFFVUNRZ1g0RllKeE15dDJQNkw4d0o1cHJJUlI3bXpaSzN2REFhdk83YUN1?=
 =?utf-8?B?NXdoNUI3OFJYcGN6c1V6eThRV2tMb3UxclRuUDloZFFFRXJLdDFhZGZoTnNP?=
 =?utf-8?B?MkVYelpKU3k4OER2ZEw0MkIrdE4vQUF0NFdIWHhYUDJLOW9yQkVQT2JtU01j?=
 =?utf-8?B?Y3VkV0RXQ2prams2ZlZmc2tOWSsrNjBBdEQwd3dweHFuQ2YvSHRvSEFUR2Jv?=
 =?utf-8?B?YXRFelVsdm01RHY0d3N0YXA2ZEEyZnJYVG0yREc5WjFXR0trZzhXOHgyeElz?=
 =?utf-8?B?UzFuTHBhck1welM2eHNCb01hcGpmdGNyYUpMbmEyM2hTdStyWTFzczMzckho?=
 =?utf-8?B?aXMxcGxpTmhqZzlzSVNkQzFZcDBvWjJudjg4bklBbkw4YjVQMXdwaTJyYlNz?=
 =?utf-8?B?dmdmTU5UN09KU3NXenJLVEpjVTNUMGcvNlpYVDVRTFM5eWZKUDN2Zk5yVXBQ?=
 =?utf-8?B?VG5NOURzdE83OVE4T1VLVVJzZmd1M2UxVjVvc3VDN2NRbkZUTlR3d2pURkxO?=
 =?utf-8?B?a3FvMnNYY2tDMDY2aTdFUm9pQk9ZQ0swRmt3VFdOM0NuUEgvTi9JWWd4S3E3?=
 =?utf-8?B?MkhoanR6YTY0ZU1ZcFNyWEJ2TjNNSkFnb1dadUxNcEowY1kxeGxkSVovSDRK?=
 =?utf-8?B?cFVtUDRBMzNxaTgvNGFJdlhMVkxBTkdSSnA3R3dkWW4wNVVzaEcrWEpEd1dF?=
 =?utf-8?B?TEJBendzd3A4ZEd3L2RoSmdnNEN2V1V1OU9xdVJ3Szl1SHV0WjZNYkVCTG83?=
 =?utf-8?B?dXRpcWs4QWM4RjJaQzlDTnpGdUNDb1ViMTdWWnE0TkFWc05UZWptV09ZN3Fw?=
 =?utf-8?B?ei8ydmhyZ25yai9oZkl0N2NGcHNsQ0JxUlNkMDBPdE84TU40VnVtNTVYL2c1?=
 =?utf-8?B?Q1JtZzY0WUxmdzU1N0lYdC8yUHAweUQ2MGVKR3lscmhsV3ZONHFPM0NIdk5W?=
 =?utf-8?B?QzUxZkV1NFZveUt1cUxKb0k5U0s4WU0rZVFGYWlwblJObFV4NFdlbFNYTXhX?=
 =?utf-8?B?ektiODZVT1lEQU9DSUtlS1dQamdlWmQ5Z0V4VGdMOFYrcWNWb09ndm9DWlFk?=
 =?utf-8?B?cmcweEw3L1RCalUzUWNuaENzVUxOeU9ieFRHMTc2Wk5GMDFxWnFmV0s3UW50?=
 =?utf-8?B?WElxMExNYk5xWms5d2tqTlhqaURVSmRPT1lnenFwMU83WWdFUVFQTGJCMDMw?=
 =?utf-8?B?T2lEd1BYY0F3eWEwMm1FSllqdTVjaEVtS2d4dlVNd0lrU0xPVUhnb3p2bWxp?=
 =?utf-8?B?a1RrZjUya0ZMLzN3NitqKy91akpDTG5RQmRtK2h4Um1HT3JvbmkvWmN1TEdi?=
 =?utf-8?B?eXNaRXAxN1R0TXNmbUN5aXFIU2V2U1puRTNpMUNyOXU2YVhsb1U4V1hIU2Rt?=
 =?utf-8?B?SE5nU25zU0tJNkI1K0UzNXY0L3ptL1U3bUhMVEZLT0pSV1NxTEVFNkk5QWls?=
 =?utf-8?B?a0c2YU9xMSt1dEFPckJGSlN2dEV2a0FLTjR6V3U2a00ybFlMTG05NWpnTVc2?=
 =?utf-8?B?b1pINkpycUYwOEFxaDdYZE5yZDk5dm03MGRnbmR6K2JzcEdXZjFJTkM1d0d1?=
 =?utf-8?B?bnVtd2FiOTVJUVdXZ0ViaE1ManBLemU5WDRKREJGNDdZSWd6dEdSQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f4dafa46-3839-4f50-0414-08def95c733b
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 17:00:59.9670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WHzkGJgkKvz2tcVEOMDpRVmpFHsnp3f+QGxgmZ7hkxwpaI/7ikUA/FAHU5ZEVJPyo6fecQ+N36zFIho4gYMYIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB1845

On Thu Aug 13, 2026 at 5:52 PM BST, Danilo Krummrich wrote:
> Move the pci_irq_vector() call from the TryInto<IrqRequest> impl into
> IrqVectorRegistration::index(), so the IRQ number is resolved eagerly.
>
> IrqVector now embeds the resolved IrqRequest and a reference to the
> IrqVectorRegistration. The conversion to IrqRequest is infallible, which
> removes the need for pin_init_scope() in request_irq() /
> request_threaded_irq().
>
> Tested-by: John Hubbard <jhubbard@nvidia.com>
> Inspired-by: John Hubbard <jhubbard@nvidia.com>
> Link: https://lore.kernel.org/all/20260808031120.363869-3-jhubbard@nvidia=
.com/
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/pci/irq.rs | 67 +++++++++++++++---------------------------
>  1 file changed, 23 insertions(+), 44 deletions(-)
>
> diff --git a/rust/kernel/pci/irq.rs b/rust/kernel/pci/irq.rs
> index daba86505cd2..81b74c4c17d9 100644
> --- a/rust/kernel/pci/irq.rs
> +++ b/rust/kernel/pci/irq.rs
> @@ -68,32 +68,25 @@ const fn as_raw(self) -> u32 {
>      }
>  }
> =20
> -/// Represents an allocated IRQ vector for a specific PCI device.
> +/// A resolved IRQ vector from a PCI interrupt vector allocation.
>  ///
> -/// This type ties an IRQ vector to the device it was allocated for,
> -/// ensuring the vector is only used with the correct device.
> -#[derive(Clone, Copy)]
> +/// Created by [`IrqVectorRegistration::index`] and consumed by [`Device=
::request_irq`] or
> +/// [`Device::request_threaded_irq`]. Borrows the [`IrqVectorRegistratio=
n`] it was derived from,
> +/// so the allocation stays live until the handler is freed.
>  pub struct IrqVector<'a> {
> -    dev: &'a Device<Bound>,
> +    request: IrqRequest<'a>,
>      reg: &'a IrqVectorRegistration<'a>,
> -    index: u32,
>  }
> =20
>  impl<'a> IrqVector<'a> {
> -    /// Creates a new [`IrqVector`] for the given device and index.
> +    /// Creates a new [`IrqVector`] with an already resolved [`IrqReques=
t`].
>      ///
>      /// # Safety
>      ///
> -    /// - `index` must be a valid IRQ vector index for `reg`.
> -    /// - `dev` must be the device `reg` was allocated from.
> +    /// `request` must have been resolved from `reg`.
>      #[inline]
> -    unsafe fn new(dev: &'a Device<Bound>, reg: &'a IrqVectorRegistration=
<'a>, index: u32) -> Self {
> -        Self { dev, reg, index }
> -    }
> -
> -    /// Returns the raw vector index.
> -    fn index(&self) -> u32 {
> -        self.index
> +    unsafe fn new(request: IrqRequest<'a>, reg: &'a IrqVectorRegistratio=
n<'a>) -> Self {
> +        Self { request, reg }
>      }
> =20
>      /// Returns the [`IrqVectorRegistration`] this vector was derived fr=
om.
> @@ -103,17 +96,10 @@ pub fn vectors(&self) -> &'a IrqVectorRegistration<'=
a> {
>      }
>  }
> =20
> -impl<'a> TryInto<IrqRequest<'a>> for IrqVector<'a> {
> -    type Error =3D Error;
> -
> -    fn try_into(self) -> Result<IrqRequest<'a>> {
> -        // SAFETY: `self.dev.as_raw()` returns a valid pointer to a `str=
uct pci_dev`.
> -        let irq =3D unsafe { bindings::pci_irq_vector(self.dev.as_raw(),=
 self.index()) };
> -        if irq < 0 {
> -            return Err(crate::error::Error::from_errno(irq));
> -        }
> -        // SAFETY: `irq` is guaranteed to be a valid IRQ number for `sel=
f.dev`.
> -        Ok(unsafe { IrqRequest::new(self.dev.as_ref(), irq as u32) })
> +impl<'a> From<IrqVector<'a>> for IrqRequest<'a> {

I feel that this is actually one of the prime candidate of `DerefMove` when=
 (or
if) Rust adds that.

If we have !Leak` in the langauge, then we can drop the unsafe on
`irq::Registration::new`, then we can move that to become a method on
`IrqRequest`; if we also have `DerefMove`, then you'd be able to do

    irq_vector.request_thread_irq(...)

and this will look super clean.

That said, we have neither `DerefMove` nor `!Leak`, so a unsafe constructor=
 + a
`.into()` does sound like the best option so far. But one can dream :)

Best,
Gary

> +    #[inline]
> +    fn from(vector: IrqVector<'a>) -> Self {
> +        vector.request
>      }
>  }

