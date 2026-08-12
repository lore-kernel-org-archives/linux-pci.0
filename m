Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021133.outbound.protection.outlook.com [52.101.100.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6B4477E3B;
	Wed, 12 Aug 2026 16:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552731; cv=fail; b=PDgXBWR4hZasc1xT2Oh27wZOeJgCVMbWFNNPiM/Y3pVhm4rCIlvPJvz2iDMOc9JNS5oPfn/NNeu5sZGfi7tcPsY9SgtWnVMF/Wwe9piBch809SoRWAr7p/oLl/JYcgo2JnG/F8JI2n38vcDRSDupeehAWlZ+bpyDoTYuiNgPniQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552731; c=relaxed/simple;
	bh=8K3mkKFi2zgtnBZYhHMbIVCtGxFKYSlL3pC6+kw29nw=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=GN26MBT0Og1PbcDyJ1ij/VBHSw0YdKUjj2gT21oBnDEA46d2O/u2tNMeDoz61vfPtc/BLpCpe9ySDomF7+1ZffSnHMr/P+CbKAFcFAKf9DBM3SXficG9tKyPwMoWc1pS0j1vg53D3StKcPH8I5kZbgi0CtBKl8phFiCDWzF7P1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=U8nH0BFi; arc=fail smtp.client-ip=52.101.100.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="U8nH0BFi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LL1iI9BvKhG2GZKJO6u9NojOKpFNQg3ufXgP5qECAn1Qo84zIaFC/vzv/p2zh7R2Hk2vTd4+LeOSW0kM3esH5EGuXJUuKhL9zU7E75c7GdAR89TeL/CzmDN9aC05inO3Yj0GWUlf6dCwzF1Mq931CdakCRi1cO71xenR7DFeYDYG3MqcInkdmIqwJTgEoX8aLTb30o6jJ6Kfj9ygBywlP/mqSLOPi245CgtPSAqpH4lnDxxazAkostE3l9eoOhNFLlr2HFAEzGpWl/BCEFLikTveMM0zXhp/hekfWo23C6nG+fpj3B+1R5OWyVdiyJZDu1mcUkwfpxHeMBRYe75ASw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLQlMti/jxy0TgsCkpucewx3t3KDtT+pD3B+fJxbmrA=;
 b=JiVWl1BFTN4p+aiQRrT5AsyuczzPIQLoX25i2yyte9/FKpKH/Vueu2zshCbfA97NMvgWQvvUqXr3VNYsW/sn7fST1HOeVQXGMVi3oxnIG/+l/c5YaZL0QsCxEjC6z39yR3DM+lsU0YRM6SLk7C1iKtyNDmB54yba/evVxBE5QhozyIFsEd3iTAU3Z0ZbF7kLYJ2tVqycPVoDVCrtLZhWye0qUe3fEbd2ctWGmxPnFRCOPjc2xtWEMZBvf2xOueO1xhnTD+YCmzP/Q4cGGh8jeGUUiOO/of0qfVhmb3hBkJ/cDdzMbaGL12XFUUmfaFt8Cu+OW7j5bEOSwlCPy6rZGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLQlMti/jxy0TgsCkpucewx3t3KDtT+pD3B+fJxbmrA=;
 b=U8nH0BFioqEc8plFIndS5ft2MgSOsDg55o9NZTlKT0z4XJV/YOwnsA1cm2Zyq6OdjGdCcx6isjBm/4SCIj+vrqlLfqWkEhB/Nm1hIO8OV/Hehnazed8uj8SfMcAtl0N90vsOC6OulQIFiX4qYf3qerpZ+xFssc0eJy6AqafRNsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO2P265MB3085.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:17c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 16:38:44 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 16:38:44 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 17:38:43 +0100
Message-Id: <DKN432T77NWT.1HRUZU9DJ9ABH@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] rust: pci: resolve IRQ in vector() and embed
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
References: <20260811233952.3000968-1-dakr@kernel.org>
 <20260811233952.3000968-3-dakr@kernel.org>
In-Reply-To: <20260811233952.3000968-3-dakr@kernel.org>
X-ClientProxiedBy: LO4P265CA0070.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::10) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO2P265MB3085:EE_
X-MS-Office365-Filtering-Correlation-Id: eb0cb27b-673d-4bbe-f148-08def8902c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|376014|1800799024|23010399003|921020|6133799003|22082099003|18002099003|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	E6H3z2fc07KWO9JUlPnIgO/q/kXo7PiP+oROAHuHfV5w5Yo5j3UkY5sLF1+qB5jw1qwvXaPkGZWJ74MhI2ICdkGS0XmZ2JDtbeZ+BCcT9s0jYWN8lX3/i/XzpAWH12UdRZMSEE8mbsF4B58hLzzN8ofqWfhQ1WP9KNf9S5MUi6+snm9B/E0B6EXMJfZO3xHJ7Jevuv9HKqHTPaLWDa8eMr+0lmSh0YAGyohYrwzzChQtDXJyEw73eSosvn9aHjacutVMEHVobQC0sCtEywj5G3ngDiqKUhzr6pAzsN9y+iNz1eeMsX163ipVIP+MBjMDCwukKboCQLYNN2MVAN5uGc78qzDLwPtZewyWq6bDwu2J0aSSPSkDohBYjP7ACwcjOJ7H50ltBojaf3NIGmtj1BiY8hZW+6Rz2OVtPQIVZkeSJWDC8GZQ4qdmu8XnSKELFEzi8kxiHS42NohYI5tGIJxIZs3+l/HGWbOYPMe8O8OsfFAlE3RtSTwles/ldDrq+JN+7pi4FbOiU8LW/lpSP/YqgNXjLRrzzcB/5tL6hoBw6p32GbfhwxKJmhQeJw8bKEK7LXqhqc4qs4z76iF4k54aUvKesf/6sbTR05ee1ya6VoIn4L+F+DRcKqpfNh8I4Gq/RHGpE1SEKU0FZxA6MNkJnBx5yrTJ+3Ycge39u6Mw4KFL0b/f/t7PRoSs4D6Fm1jHfOv4nDtkOSXnIRLJxw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024)(23010399003)(921020)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bU5jUnNKVjFxUGRFb2hGTXdkSkNHK2FzUjd0Y0hiZ1hObGZkY3FORnBVOUN6?=
 =?utf-8?B?RXN1WGk4VEplRXFUMHhzTnFocC9RZTVrd0FxZlQ4Tlp5cDFxclJQM0NsTVBZ?=
 =?utf-8?B?dXhSYnBBUklEdzVSRDRmWFRVVGZTc0l5OWpDMDBqMXJGRDM5aU1sWDZ6akZ0?=
 =?utf-8?B?a3Y5TXQwZjVsbnU1ZUNIVE5xWXBsYW1zY3lPQ2pkdXk5QitFblRKTVNSa0VW?=
 =?utf-8?B?WDhFd2M2RnlBbStSanlXUGhWNjFMWm82NTRZRDBmS0t1MXkreUVOYXYwUjNv?=
 =?utf-8?B?Q1h4YVdlYlBKMHdoS2tnM1F4Rmd3VHJKMld5RkV1RjF6amxQM1NvUWhJb0N2?=
 =?utf-8?B?aktxQTFyZkhnYmY1ZTY2Y3VTcitsT0ZqNFlMSzNNSUlzY2NNRHF4ZXhncSs0?=
 =?utf-8?B?YVBubE5kbzErbTlOK3pPc1hYbmRQNFF3dThReDFRdVZ1U0hDZlR3QUxuWFZm?=
 =?utf-8?B?ZTlPK2tmdjY3NXBOVFdWLzFxZkJlVEJpdVEzcGVZbGVpTCtlOWN5UzJ2UHh5?=
 =?utf-8?B?MHRLazRSTXNnZElhOTVGMEU0QTNQQlNGZHZZODlyaEs0MnAxWHZPSkdkOElF?=
 =?utf-8?B?RjdLNTQrU0R0Q1lpV1FnRFp0ZFdJVXpCT1NBRWJtdjlOZUtPR3VlZUNhaTFN?=
 =?utf-8?B?VTJQT25nbjR0cG45TC9TczhFUDlXbVlJVmJsRVZ2Z2xkNEI3Q0hpaVAraWZR?=
 =?utf-8?B?blBCL29jSWVXNW8wMHBHN2N0dk82TGVqYlAxN1NPSlhKZVZnamFjRFkyU2Zm?=
 =?utf-8?B?Y1NlVUJxUXEwZzZjcWY2Rk1sMVFHaktmVldsQWNpenVpZjZwaFdkOXZDYi8v?=
 =?utf-8?B?QU5zdlVpS2tJTVVBTFhBMXBoSzZ5WkhRbzJYNi84bitlMTNUVXpLZDJYSER4?=
 =?utf-8?B?UGh6UTlPRWNvL0NrQ09XeC85VDNwM3ZoUTZiK0NtTGJjeGZyYjRPQm1RektV?=
 =?utf-8?B?ZlR1UXhCcVNlNVN2MVZFNGYva25lb0wzQXVoK0hjSElYL3dLUFlBaWI0c1NY?=
 =?utf-8?B?QThrcGYvckswby9RZ1AwaDEwaXZQVm11Z3U4cHpGV3Z4N3VwQXlRWWJtZGkw?=
 =?utf-8?B?SkJERXpHTzZ3QUF4ZDZiem8yS0xjOFFLbm4xT3NKLzRpOVFTMWpXUzVoWHJB?=
 =?utf-8?B?c1RzbmFLbC9GcXVqUkdoeHVTTG1veGpGRFZFVzE4ZWMzQWYzWU0zR1N4K1Uv?=
 =?utf-8?B?NXFYMGp5SFlMc25mVTdwWlJneWQ4ajJoczhjUWowbzlETkdpNWJHblh5dXdl?=
 =?utf-8?B?cVYwWXJqb2doSTk1L3NPaFp6UkM1MGZ6dFhzNGg0Zml5dUlMQWdmZ3c2cWFB?=
 =?utf-8?B?VmpST0svZjhSckdhcWQxdzJFeWhKZndDKzZQZCtMTzN1VkVYN1I0dDZIT0l4?=
 =?utf-8?B?TVhFSmI2K0lzZmlNWk85Wkl6UzMrdEV1S3ROb3VvcFF4Rk4vTEYwQzBVSERG?=
 =?utf-8?B?MHhDTlRsRkhjOW0wN1crVjVidTM0b0w5VTM5d1pPRlVSZHJpNkJPdjFGb29h?=
 =?utf-8?B?Z0VyV2hEMWRMZk90cXkvUnpuTXorTi9KYlBNMmIxUEdNZ3ZlbG1la1VrNFNV?=
 =?utf-8?B?azFkTzdRUG9KbktoNnpYclZtaUw1M1F5VHhSNXRoRHFBMEhvUmVPSHdBSldL?=
 =?utf-8?B?S1JYWm96SzZTdXRJZmN3V1NxbjBLMU9hZGtJbkVKQ1JRNmVldzdJMzJiQkVZ?=
 =?utf-8?B?MWM5dm9NdGR5VjcxaGU3cmR3TnBjbFRPMlNLbVdKeTNCMWtHaGtmTGh5M3dh?=
 =?utf-8?B?NGFQVXlKVFRZVjJCZGtqNS85aElrYVc3VUxkQ2MxQy9KYkJ3WjBoTWtrMVNk?=
 =?utf-8?B?WVAvalhMaGhMT1FXZ2pWbDJCalc2dlhvK3NiMHBVdzA4N1lWaVVEV2xMTEZv?=
 =?utf-8?B?MGlZQyt2V1RSSS9wQ24wZk8wRm85ay9ISDlVMklaZ2llVkk3dVYyaGZ0citW?=
 =?utf-8?B?ZWFTZldDbVBDVk9sajZxTWpvRUNtUm9JOWY5aDBIY1NpaWl3OFhmbmFoZlNt?=
 =?utf-8?B?d3VQSW1MWWhKOXJKVEREaTVXL013UU1FdnpPNUVveGplNzRLSEN5OWlMMUVP?=
 =?utf-8?B?STM4ZHpXYjhzVDh3NTgyVmtORm1uQm9BYVdMT2NpcFlUTyszdEduWlV3bGJF?=
 =?utf-8?B?bVk1UFZiYlRSWTNKMkNwY1Rzd08wMFMvejhrcnRibkFYL0ZEMGZqeVhtOGYv?=
 =?utf-8?B?b3diZWZCVThhblZCVjZxcTgwUVNqK2xwQXVzQ2hWbGcyY1l1R2ppZHhiTEEw?=
 =?utf-8?B?eTRKU0YxMTY0VzNsTVZ0aE5JeUh1cVdqWGNIcVhpSjk3S25IaEZqL3FkdVg1?=
 =?utf-8?B?a1A5cmNIcmZZNWlCYklIeUdhMC9xbVppclI4RmNFR1hFOEg2VVhodz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0cb27b-673d-4bbe-f148-08def8902c99
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 16:38:44.1241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DtlpUDV465KEa1VNX7NR3UxP+Vvwl6ITe4gktqZ1mettWIXaSGIba69MaMVWfMy70VdzjI30vJZqvJeuwj7uEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3085

On Wed Aug 12, 2026 at 12:39 AM BST, Danilo Krummrich wrote:
> Move the pci_irq_vector() call from the TryInto<IrqRequest> impl into
> IrqVectorRegistration::vector(), so the IRQ number is resolved eagerly.
>
> IrqVector now embeds the resolved IrqRequest and the vector index. The
> conversion to IrqRequest is infallible (From instead of TryInto), which
> removes the need for pin_init_scope in request_irq/request_threaded_irq.
>
> Inspired-by: John Hubbard <jhubbard@nvidia.com>
> Link: https://lore.kernel.org/all/20260808031120.363869-3-jhubbard@nvidia=
.com/
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/pci/irq.rs | 77 ++++++++++++++++++++----------------------
>  1 file changed, 37 insertions(+), 40 deletions(-)
>
> diff --git a/rust/kernel/pci/irq.rs b/rust/kernel/pci/irq.rs
> index 8e0651587829..305701440114 100644
> --- a/rust/kernel/pci/irq.rs
> +++ b/rust/kernel/pci/irq.rs
>
> [snip]
>
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
> +    #[inline]
> +    fn from(vector: IrqVector<'a>) -> Self {
> +        vector.request
>      }
>  }
> =20
> @@ -142,15 +143,19 @@ pub fn vector_count(&self) -> usize {
>      ///
>      /// The returned [`IrqVector`] borrows from this registration, ensur=
ing the vector allocation
>      /// remains live while any handler is registered on it.
> -    #[inline]
>      pub fn vector(&self, index: usize) -> Result<IrqVector<'_>> {
>          if index >=3D self.count.get() {
>              return Err(EINVAL);
>          }
> =20
> -        // SAFETY: `index` is within bounds of this registration's alloc=
ation, and `self.dev` is
> -        // the device it was allocated from.
> -        Ok(unsafe { IrqVector::new(self.dev, self, index as u32) })
> +        // SAFETY: `self.dev.as_raw()` is a valid pointer to a `struct p=
ci_dev`.
> +        let irq =3D unsafe { bindings::pci_irq_vector(self.dev.as_raw(),=
 index as u32) };
> +        if irq < 0 {
> +            return Err(Error::from_errno(irq));
> +        }

Correct me if I'm wrong, but I believe that it's impossible for `pci_irq_ve=
ctor`
once we have allocated vector and the index is in bounds. (If that's not th=
e
case, we should ideally fix that instead.)

So I think we should just `.expect()` on the error in `Into`.

Best,
Gary

> +
> +        // SAFETY: `irq` is a valid IRQ number for `self.dev`, resolved =
from this registration.
> +        Ok(unsafe { IrqVector::new(IrqRequest::new(self.dev.as_ref(), ir=
q as u32), self, index) })
>      }
>  }
> =20

