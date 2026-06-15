Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011071.outbound.protection.outlook.com [40.107.208.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84693FD971;
	Mon, 15 Jun 2026 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781535173; cv=fail; b=df7yg/sRqt7GOYvC/lbNmgKvOa7EH6rtVKvABaLCP6c8CWTFedjxZUDY6oaRJK0Gjy/dpGJJbQjBhQ3lLF43fV7jrCoCalc5l5g+WoX1m/U7yYzBuAK59/QIN6Zh4MbJKm2dzg+vYz+n9MYlM+NzOWaCEppAoMriRRYC8li12ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781535173; c=relaxed/simple;
	bh=lt5MBcUGM/wqLeCyLHTxBdUUvyWFkA4rB0YPPGWOgpg=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=BLE8eHE1oASFhH+600AVSxO9BdfttT9ylT9ASMN9Mgdpi25fwDXPPhRG7xEOR1tf5VVddh/ASIQxSrHRSm+T30crBJPIQhty6Bd5+uKPAhjnd3bfHWw3hxJ5rMEmiNplFSgVLgrY73/iFa8S4+9uPN63xzyD/wmc7Jtm9FNBSX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H5SDMQwn; arc=fail smtp.client-ip=40.107.208.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H5SDMQwn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHC8GOwvdwDPqN/uafBsokCJKuNjOycrevT5xuI1Oba1DfapzPZTarUIaSk39PfKlmpy1eEPLzR3F9EHIHVCrdFpXecp97AGV+/nOCvUMTAFrJb5j95qFBOaHkYFMHMMXAy6Werq/MR4k+zf1Uhsp41Ie0oQ1NPPFHQfUKGXvuiNdwdX5PEwCHexiqLvULRd91AqXQpzFPCKYLt5ZkAyyOcen4+fjKRnGHqj2yINFvmC7DVz80XW3Um74nQCeJASmjA8h6UOrgNeKVke4aXAE6ikt71rleV2Qj0PVRTw9Gq6P4N3YjcYtBxQ1zhr0FAiA/RnGj/8t4dMznIH0Y4s+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqx1ZYJhNKxZUJAPoOEUguP/ra0i9g3vjeXxcYpXefE=;
 b=XEvwx2yQmz50vaEhZ/nBBuf6t9gtiOCK4rhb23ymComwwjiM2ziCYdmMIGwUjLXuvzIERzzcQAXfJ4v4hwAIn2UVPPFXQTDHFU9FFM4bDHloONx+Et1Szz/Lhw+7ZK8tb0Sp2JrryuDc778FeEGuCY+A3SAAXjjngtPGcd9MVnXJ3RFfHlT7yrcGrLtD43ogGxPvgWpvC0d0nweW2dcAQiieYrC5gYjViODu2pDwQbn50zMcD73AoPDtxCmr/3ausKBsI2LZiiZjDZeejG6+r6Asi+zCWXy7PfSJHrZ4mB8PgtIT5F7vPcsqbDBBElm6pLR8OC0H1RuRhgjNgI80Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqx1ZYJhNKxZUJAPoOEUguP/ra0i9g3vjeXxcYpXefE=;
 b=H5SDMQwnj+7MkDumU5uegfn0Dcp/JSR9e68zpTjJNXxBEPO2HgSRQvWnhvbDk+q72PWKprXGCdfHe1+ND1tAp8x5UvMDkYcdMJb2PjZvmctdru6O2mQDtZOIsx/u7vAeuiGfsjpfVxur+devBc/s8XEkm3XYAkEc28qzn4h+lIDsh31VrK9AMmP3AiUd1QVij06INLIOxIk3t71e1/tBBJmrKNg2H7YFxbdGBiZhvfspMhgzDA7YUapCp500xECazu4cxnH1fM6FBidl5z3KiwDr3OWkZP6AEGlM7ezpAM/jUMHzhotHDF9rf6Wll1xSRwX9Z4Pl/3aCnUxC2kZzNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BN7PPF2E18BD747.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6ca) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 14:52:44 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:52:42 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 23:52:39 +0900
Message-Id: <DJ9PI9NEJ92T.3D0E90RPSCXA2@nvidia.com>
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
Subject: Re: [PATCH v4 07/20] rust: io: implement `Mmio` as view type
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
 <20260611-io_projection-v4-7-1f7224b02dcb@garyguo.net>
In-Reply-To: <20260611-io_projection-v4-7-1f7224b02dcb@garyguo.net>
X-ClientProxiedBy: TY4P301CA0114.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BN7PPF2E18BD747:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e9d45f0-1210-4d75-2359-08decaedc103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|10070799003|1800799024|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RdrGqB/lkc5I5nsNNeO2La0kxjIpktUk1jYroiW2KWASyfc8WK9y2kSryC5r8cKI8vnlEiNZ2M6uPB+oVRXVM2QdKf9hd8olO77hHINqLpEnN/aDvYbg6EWauF5CsvZxKZFMCyZC+A3Vj1pWwhtsvHrhCDeq5buQcranRba6fhXVpuTkhQo+m9D7groKKqmLDPau1cc3t5nAFYbfBq0MgLzJhhVNyA3mQ72JE5wquMdsXHG9gfo8twfzGjtQggDWxu4hFshfe9qdZXVJSLiJDlC1tG66arhfTWDR+lLPAlcZh0MSKati+iL9PkzopxTuoEYqnPx6TnHfHa4yXcskfi4lvQ7pfFcgIyfZKcJJb00H5Msm0wPEkp0Yy1Hwmdua52YqWqHWUhfA9mca0RT24lCmCoKo5IYqky0Q8V7cuLrLNFTtK5KeIOYB7mXLpUVBvN1oiXJanM426qU1V83GOKxEsdUx4H0DTlsASIFmB10gAascLLu0LLda3MhNclSuVN9Ki0Y68BGiJ+AxyGbjKEP1U7L173BA3GsfQJ7Q+VGeCGJEwNpsaAz41eGtUhyg+mDSZ+s2m/TGpU0k2LLhaV5z6lp8Rs/MnuyHBTxtzFLp+nr/47z7UpkpIdxtNfttDE/DmsN7qrrfXxmdBPDBxYKvDaZ3xJ8BApPz72G1+nQqDQbSXUq+2PMlVAkgFZfa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(10070799003)(1800799024)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmUrcjlrb3RQREd2TGpWM1Y4K0pXSi9FYWczV0F6c1NEc0kxSWRGNWdLVGR0?=
 =?utf-8?B?QnlwWG9vUS9JZWNZMHVxelJaYzZKMjlLYVVTSm5JeWZmVThDS1FnMGJzaHN5?=
 =?utf-8?B?RlJXdmhsZUY0aVRiU1Q2YjBXYTJzd2hySXNiWDZNdjkybjZOaERlNzRQeFMv?=
 =?utf-8?B?RzlWZkRGMHJFUTF5V3FBSEx1YTlGS1AyTVY2MmMzamRvRElJclJUV1ZaVUVQ?=
 =?utf-8?B?dVQxYVQzbkZQd1BkWnhKNjJnY214cXhIUTUyUGNWa0ZHZmNuVC80UDd4VE9C?=
 =?utf-8?B?L2dnNGNiRkEwQjFFbGtrZWZENG9iNjJydWJpMEVvWGRrZGlCWmh6M1ExYm1j?=
 =?utf-8?B?MnhtTkRMZ1IyYkdjbFprNE9JZHhXT0JFdGtISFFKblJwSnBLRk5LelQyRTds?=
 =?utf-8?B?Tk50eXhWdXhadVNBdk4rYlRHSis2UnlaazVXd0FyekdXTnp0U1FLbXZZbWpP?=
 =?utf-8?B?dVpRSVgwUHpOSzFiTmgzV1dQUVJsTXcyQ3RWZ05GTFdvTW00UW9RVDFLUU85?=
 =?utf-8?B?VEZOWDlsSXJZbVpEVkg5eFdiMzZoejVDeU9pYmFNTjNFbGIyeThOeTErcWpt?=
 =?utf-8?B?VEFobVAwRTd2TGlyRHdXcWs1N2FXdGFjVWx2bHJPbzdwNENQR3hhMVhKeHJY?=
 =?utf-8?B?LzBOV2IvQVpnQmRZNnpQeU42SmlYdVNxN2JtWVBvYjdaV0J5ODZWT29uS2dZ?=
 =?utf-8?B?N3NnSisyYXFnZ2VkUkNDQm5zVmxjdFUxN3BBdVU4bTl0dDNDQjN5TmZlNUY5?=
 =?utf-8?B?aENBMjlEYit0TVNDV3hNV3hlUFhUQzdvOGYzUHdPZ21EWVd0eVVWY1FrbVhF?=
 =?utf-8?B?QytVQjZaalhsMjFqNG03V3lZbHE0RXJRZ0dDM01QbDVGZjJra0YxU2pTdER4?=
 =?utf-8?B?Y05sY3NSYUdiNlZhdmtLbUVlRWlhQlFBcE9sM2ZCaHpKMmtiZEdNODhuaU5P?=
 =?utf-8?B?ZmIvdXQwdmUwWWp6Q1g2OCtvS0VGWkowQ3RlTnBRYmJpeDlrRmpqRm9oZ1N6?=
 =?utf-8?B?Mzc2OTVxT2J4Y1R4RkxjVUtqYm5sclYrMlc0MHhHS1ZmREtTc2FxNWFsdEdS?=
 =?utf-8?B?Q3Q1YWFnUVNiS3FSbU40Y1NHQ0xIWHhiV2RPajlTRXY3REJsQ2ZzVk5yYlI1?=
 =?utf-8?B?eUhha1FwdUZFYXdVZmJ4aHYxUVEycFV2dHpMZVppT2hwakhmc1hVU2lZRmMy?=
 =?utf-8?B?ejNoK3RBUmNMRzltLzI3dnJFc2x2aVZ3YkgxeVhnTE0rVTUrWkNNOCtWSVNG?=
 =?utf-8?B?QmR1a2w3TUNuclZ3dUNsTWFZQlhCQWxNbEd1MGVaTEVpZUNyKzlqWEF1QUhk?=
 =?utf-8?B?RXpzeGQxNFAwMTV6Q3lOdGRscVBlWTZLVHFOdzM4aEMvUjcydk5iY1B6R2x4?=
 =?utf-8?B?Ni9FaklpS1h5RDRHK0JvYUpvTzNMYVpMY2NnR1U5bjZzSWw3QkpSRHlnZFFG?=
 =?utf-8?B?WlpFRTJUTmlRUEVoTnNLL3UxL1FTbDdvS21aVm1IMEJicUM1bTBCOXFodm44?=
 =?utf-8?B?NlVWK0dib0dlUkUwUlBUbi9GcVJVanF3QzFmdFQxNFhPajRqMVBLVnlSUUlT?=
 =?utf-8?B?Snc2S3hURGNSWlBOdEZ4ME90SlJUWVQyMnAxTVN5MytQM085UjQvblV5RTV1?=
 =?utf-8?B?UkJ4OFZBNm1DVVg4djBmVXhZN1VIUUQzdnRYSXFOR0IrcE1waEc1cUREUTR0?=
 =?utf-8?B?UFlMZmpRU2d3aWZIa0IwZU82VU82blVHaWlMMjJid0pQYWJ5SlBqZENmQ082?=
 =?utf-8?B?c2x2OEt1NU1FRi8wWjVwdTJRY0tZVDl4K21IeXJ3TnJPWEhSWjQzUjVmWDRH?=
 =?utf-8?B?SXAyeFpYeG05eVl5YituMGVUaWp5cmNabC9qRUpVdEZuWVV3WUZuZnZqYTJO?=
 =?utf-8?B?czZrbUhIaVlWK3RkM3AveFRFU016c200RmNnS2NTaTBBYldxZlB4U1NQaW5o?=
 =?utf-8?B?WHVhbFNmbmZXaDNneG1qZHZlUjl4SUtRaG1qOWRQTXU5dWgxZVE4cVlYWGtr?=
 =?utf-8?B?Q1lpUEs2THRaRTlrTWhvUGxHK2hXT2N3OTlYcmkyUWRIcmRyNTVDTnErc0NF?=
 =?utf-8?B?MzhKdjROemFrS01kQVpBcmxSMVgwZWtTd3JpdjhTUDFmdHc1TVBwWkdwQi90?=
 =?utf-8?B?SFhPb3FxbDduWTVrL0U4SmRlTTRHOGFjSXdJbHE1R29WTTJDZEVkSGtyRTli?=
 =?utf-8?B?QlRnKytJMFAwR2hzUU10SlZtcjZseXJmZEpZOXVpeThuUGV2UktreGhuVnVS?=
 =?utf-8?B?RE5IRlBFTVZnOEJLNHRkamE3V0lPOHlZTk0zR2MyRzVJLzlTSTBqVDZ6RStI?=
 =?utf-8?B?RWhad01EYk9yVnlLZ0ZnVFJvY2YvRUhsUEt3YTZNbWtWRDZYL1RsUzlyNnZS?=
 =?utf-8?Q?r/hXYJCVEuQ9V0S2c2jgXdNDoxDLydzQYPV+uTrKt1Ayp?=
X-MS-Exchange-AntiSpam-MessageData-1: ryNLLtXNOYPPbA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e9d45f0-1210-4d75-2359-08decaedc103
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:52:42.9163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CMRuvajamxe3mwVK8p7Ed4WTRssKWLZG+pAlUjFGxl5m6XScqit1W7VzF6mHEzkEW5VdHUssseowtMqhzoUkpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF2E18BD747

On Fri Jun 12, 2026 at 1:28 AM JST, Gary Guo wrote:
<...>
> +/// A view of memory-mapped I/O region.
> +///
> +/// # Invariant
> +///
> +/// `ptr` points to a valid and aligned memory-mapped I/O region for the=
 duration lifetime `'a`.
> +pub struct Mmio<'a, T: ?Sized> {
> +    ptr: *mut T,
> +    phantom: PhantomData<&'a ()>,
> +}
> +
> +impl<T: ?Sized> Copy for Mmio<'_, T> {}
> +impl<T: ?Sized> Clone for Mmio<'_, T> {
> +    #[inline]
> +    fn clone(&self) -> Self {
> +        *self
> +    }
> +}
> +
> +impl<'a, T: ?Sized> Mmio<'a, T> {
> +    /// Create a `Mmio`, providing the accessors to the MMIO mapping.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `raw` represents an valid and aligned memory-mapped I/O region w=
hile `'a` is alive.

typo: "a valid".

<...>
> -/// [`MmioOwned`] wrapper using relaxed accessors.
> +/// [`Mmio`] but using relaxed accessors.
>  ///
>  /// This type provides an implementation of [`Io`] that uses relaxed I/O=
 MMIO operands instead of
>  /// the regular ones.
>  ///
> -/// See [`MmioOwned::relaxed`] for a usage example.
> -#[repr(transparent)]
> -pub struct RelaxedMmio<const SIZE: usize =3D 0>(MmioOwned<SIZE>);
> +/// See [`Mmio::relaxed`] for a usage example.
> +///
> +/// # Invariant
> +///
> +/// `ptr` points to a valid and aligned memory-mapped I/O region for the=
 duration lifetime `'a`.
> +pub struct RelaxedMmio<'a, T: ?Sized> {
> +    ptr: *mut T,
> +    phantom: PhantomData<&'a ()>,
> +}

Is there a reason for not just declaring `RelaxedMmio` as

    #[repr(transparent)]
    pub struct RelaxedMmio<'a, T: ?Sized>(Mmio<'a, T>);

similarly to what the original code did with `MmioOwned`?

I tried locally and could build. This avoids declaring `Mmio` and
`RelaxedMmio` as basically identical types, and lets us remove the
explicit `Send` and `Sync` implementations. IIUC you can also reduce or
even remove the invariant section as it is enforced by `Mmio`.

> =20
> -impl<'a, const SIZE: usize> Io for &'a RelaxedMmio<SIZE> {
> -    type Target =3D Region<SIZE>;
> +impl<T: ?Sized> Copy for RelaxedMmio<'_, T> {}
> +impl<T: ?Sized> Clone for RelaxedMmio<'_, T> {
> +    #[inline]
> +    fn clone(&self) -> Self {
> +        *self
> +    }
> +}
> +
> +// SAFETY: `RelaxedMmio<'_, T>` is conceptually `&T` but in I/O memory.
> +unsafe impl<T: ?Sized + Sync> Send for RelaxedMmio<'_, T> {}
> +
> +// SAFETY: `RelaxedMmio<'_, T>` is conceptually `&T` but in I/O memory.
> +unsafe impl<T: ?Sized + Sync> Sync for RelaxedMmio<'_, T> {}
> +
> +impl<T: ?Sized + KnownSize> Io for RelaxedMmio<'_, T> {
> +    type Target =3D T;
> =20
>      #[inline]
>      fn addr(self) -> usize {
> -        self.0.addr()
> +        self.ptr.addr()
>      }
> =20
>      #[inline]
>      fn maxsize(self) -> usize {
> -        self.0.maxsize()
> +        KnownSize::size(self.ptr)
>      }
>  }
> =20
> -impl<const SIZE: usize> MmioOwned<SIZE> {
> +impl<'a, T: ?Sized> Mmio<'a, T> {
>      /// Returns a [`RelaxedMmio`] reference that performs relaxed I/O op=
erations.

The `RelaxedMmio` is now returned by value, so this comment should
probably be updated.
