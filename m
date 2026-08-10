Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010037.outbound.protection.outlook.com [52.101.56.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A423B3BF1;
	Mon, 10 Aug 2026 09:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786354254; cv=fail; b=eyzULFwbjVYvrQ4ZpL1Wc86vb/5QTlyJEoRMh2T/Ytt4aoGU45loDOcjcHGvPNtl1SIWiReUw41tUy30uR4JHCz50mj4YO36vAcsNpY+jNl8vgn2mCF24mNluMya6FvI1iBji7L35gcAY+MPbHrBRE7eOlAHNRm24D39tS1b8ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786354254; c=relaxed/simple;
	bh=IRLBC44b8bWMNz+MNoE90g5G1HdSDlKdbK73UoOBTc4=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=mHfdDDMTQpJVNBH+IMZxaw//pR0PeFGah9p034WYSASPCMTUtuBAX09RtjzfBbYQaYL+5DnfN1nX9IiOn3gFL/BHE7eKl8Gch2MclsttagUcHDREcLMIaf47AbvpUEMex81mQtyNC+vSgJVeyGuwIg1Q+XsBO25urZ7j0fG87oM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=amxsZVDW; arc=fail smtp.client-ip=52.101.56.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="amxsZVDW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFKOCENTRbRYhmGcPm8ax2baAdr3ATaYft2ZgT72bdLS5RYBbNF3cYpP5mIJHlS4tJwmy7pDjrx7nS9eSYb47iyLxUyiPZYeCngllgEhddO6QgBcOMe3sA5OLYf/fOe/f4vTgBb9TNczMkLeil51o5XYPMgEthTsvI6rcEPHy5yKUtfKsegvkAg4V2cr9COKGVSlVU6vJv20IGXWhhaMU+ofoZ94EJSl1wf0OB5KRhOV1zT/bBdhSVL7yBZ4xAseXJpeTQ79HlfcUHE37OZHkhdktJlAyWroh5rp2sVbnPhV7OAlH4G00TGySSMK9U+14nB6+JwQYbgIykmhy0xc5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CDu8z5LkGELa+v9oEEsDxCOZqzEvep9+iG89VZOOHE=;
 b=tJUNORxrwlvAF3cSvOkVeYVLRGxv+tDL3NZ4dvPWKbiv4HlKdnKw2+EeybS/NAPcv8NuRalQj4wr2lx+NTwi3IB9j2v6zZSCaWT+owtw82yzw/YHPCAUK695gEN6oH6cC+IjYFGSiTDWV1lC5mjnsXTkiiK/zWFhKc6rtMxORFNFiYmWT3OmDP9GpWdfU7iDRjhwzdmYGYGqKLDKXv1DhFMezh85YXKX5G9dTqJVkFtik05PQhlJncsYNVBxCvJKqcA56iZRxdSplocQS+EejAXUrZJ9g6r3wj3iYTrflHTJocQmY0MvteFEGHEt5fcInOr4ogunVlxfbSIVcqroRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CDu8z5LkGELa+v9oEEsDxCOZqzEvep9+iG89VZOOHE=;
 b=amxsZVDWtc1S43aV6eu7KZO9oMUEKiSe1QwsO66cmycbga7cA9WriIvNVKq1VUlJOkGYOiPRAmOyAEWFfjY3X4BIjleOdsEGingHyMqgmlYx56xAX/vwfcybVy/qsZ0ct/EYigMOPdZFq4t1xSnC6/w/RQEiD8a2TWoU8uSG8DKCErDNSPTAvCDE6Ml6NTFkBlQ5gddGH04fBKicSNIutWUnzIhpfOZD2pcnEBCfS7k6nGurzwoDQr//Dl+aKUEkhl3wtRk79BwkspfTDBdow5hAxKh+J3E380OZOo3W5tGzJOfTVTepp7IUE24QD0mm6N/VYaHge3wtW7XkzTL4Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM4PR12MB8570.namprd12.prod.outlook.com (2603:10b6:8:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 09:30:46 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 09:30:46 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Aug 2026 18:30:43 +0900
Message-Id: <DKL5QACM4OTZ.2Y8RLMSPRCXJ5@nvidia.com>
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
Subject: Re: [PATCH v2 03/16] rust: io: support register projections
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-3-c3ca142220a0@garyguo.net>
In-Reply-To: <20260805-typed_register-v2-3-c3ca142220a0@garyguo.net>
X-ClientProxiedBy: TYCP286CA0256.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM4PR12MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: c0059860-dc42-48fd-9141-08def6c20e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|23010399003|366016|11063799006|5023799004|4143699003|3023799007|56012099006|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	o1NxRyUp8zMVjkjvGGJv5/GPl2Rg73frAOrdyEyAPCDKjm6yfpDeaXBePkKNMp+D3msw9adcP4Aq972lz9XcEJW6f5LO09PfT5Wk+cBE9B2P7D2TkZsXA97H8LYd7/B/BeNWwKo92O6Xcd/yvZQFFslnQFlB+opR8WWnfgp9CdIYajYjG4hLDSkxSiJ8ahMvEeFu6bVYZAFCNpBtwnzduGj5IsEEVHIbuE3HBtnzcBdbl/bPV9i03roJI7zMORxhcE37+240Ob0u2OtW7E2TDnruBRMoAig25gh4ixqZx9wya+2GElwxAhdUol3RzadNhqBOh7TD71N//Xj7pQ4g6ycUTOtbLiXWlSsvrBZjcvcAA1MHJMy6g9ODK/kfkD1649xnnqVSej6oSQkonnLFdI90aELrM5n7C2xJl0rAWx757rLEVFxhNehtdmTECHxySPPa8sfQhd2y2sflXow71eDPkV5KgKT6dqYN0l/976zcFR2ueoIbXQDkkYoSsXB6fJFfZf/gfI9FCSrL0PoqEddCg1C4tmwNks4ShJQd3VoPSBm/TI9mMt77k2zMOLepdZycxhfRciQcGmQeq+4Cm93uxFO881JbI0xMirNt4BaUGUy9n+DDeWxp8kyqZgN2wR1NB4imyFktRyAOSc8O0G8WVjzbrMs5CD3vR9B9hPY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(23010399003)(366016)(11063799006)(5023799004)(4143699003)(3023799007)(56012099006)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0dlZ3B2MkNKc3JwQXpMQVlDdEg3S3ZOUHQvbTVYZk1HR3JTSjFDdEdxNC9j?=
 =?utf-8?B?T0RmNHNQN3VJVXdXcHJXdmM1MDZka2NNZ29iRGpiSkFXQTh4VjFVSTJkSmMw?=
 =?utf-8?B?SDMwWmFyd0JneWQvTXRsYUV6aEhJcHFTWEEyam8yWUxXa3lmRVhuRy9NcS9N?=
 =?utf-8?B?ZHJJQ0hPRHBKdlhrWnV4NWtCREhXZ2RMZFkvQ2hhMWdMeDB3My9YTTJBdGhM?=
 =?utf-8?B?cXBYdFlIKzBVdFMybnZ3MEs3M1VwNWJObGd4VDZiQnU2VnhlR3Axd2pXdlQ4?=
 =?utf-8?B?VkJieG5ubjJGbENocXJjemd3Z1RUcEh1UnYwQzBCYlFhWXl0anV6QmdPMW8y?=
 =?utf-8?B?cmtoRFJCdUR1cE10cm02akxyR01aQlU1eUFGSDNPWUh0alN6bkdsTzlFaUVz?=
 =?utf-8?B?ZGFxOEFuam8yUEoyUWZ3THV4cGJDZmUweEg3YlJRZlJxTXk0OXUxcTdxUHBQ?=
 =?utf-8?B?N29qelVSa0xmVlk3c3RKbXJqYjBnQmMvUWxnR0tiR1JzUUlBYjdmTzlHbzF5?=
 =?utf-8?B?T2Y4Wkt5WHU4dFRCS0JvS3NiTUc0Y08rVnEzMWxmRkZrRWlra0NRSUM3R1lQ?=
 =?utf-8?B?Umx3Z2ZqdXhhRndteGFvaUNHYWtSWFk1MjhvcXRnSTAvTHVDLzh1clNuUTRv?=
 =?utf-8?B?aFlmUnhnT1h5elB2RmhYc3cxNHlFdlEzWjF6Rzc3a08xTmd1cWZsTDhXMi82?=
 =?utf-8?B?TGhQNnNheFZhVElWckxxUUJhbHBFZVpIRzhhenRWS3RkSW05L01Sc0xuT0RU?=
 =?utf-8?B?YWZjMnJ2ZnlTNGluaGhHY2xyY2xlSkxTbS9WTDRNZjRNdlJtb05qN3Vla2E1?=
 =?utf-8?B?UnVTYVRvUjgrSlVxWThCcDhIU3F4UC9pbUNwSnhBV2NvSFAzWWI5QUVsMFNy?=
 =?utf-8?B?Y2ZNQVdZcEZEdXVxQ0lDRjRRb0ErdkFRMDNXeVdXRlRVZVQrR0VVNGFNeDdH?=
 =?utf-8?B?S1JIUE5pTmVyMlgwN25zZmJ2R0hLZkJURE1xYmdBeS9yU09UTFZCSWd0YUNQ?=
 =?utf-8?B?eDdoRFZ4SkJtaXEvYU12Y2JKY0RWZENlYWZZTzJjS0ZxWDlaSk1tYzlxaDZy?=
 =?utf-8?B?L3AxamhNMmNnY0l2Tko1S1F6ZC9VWk5YTTdaWkduOGJWYzhEdEJHeHMzZnBp?=
 =?utf-8?B?Ym1QN2JKVG9GTXVwL1RxZzJlQ0tsOU9Ya3F2alZ2NjR0enB1R1dxeUZBNlFl?=
 =?utf-8?B?L3dYaHBWYnh5ZEYwOHRrR3lKZFNjSXNIWFQyT2QvR3dtdThQMjdvNFEzaUZY?=
 =?utf-8?B?Vk5saUw3MHN0ZGhxVTI5MENudTBhSGxTZnBjTUhUK1NLWGhEOTdla2wzYVR1?=
 =?utf-8?B?eXI2Nk9XcVNCeklFalBmMiszQ2h2VzRudHc4dFhpTUF3UTZBL2syZDBEUWxs?=
 =?utf-8?B?alFaZkdVb000RlZOdm9FM0N5eVlZaVlxbldhS3lIYUdDWlM5QVFXUXdvNWFa?=
 =?utf-8?B?dEVsUjBQai94SWQwblZsbDNSUktkTlNmZkxlWXNvTVR3MzB0cS9MYk92RWcw?=
 =?utf-8?B?RWIweE1Cc0xSSzlBSzNKdTUzSnFuL3VFL2lyQnNpelk1YlZFOFN1SzVNWi9x?=
 =?utf-8?B?UzErVzBpeEJmUHhEWlc3c2RPZ3hZejdKdkQxald2MHJtRitUSHBhenlaRncv?=
 =?utf-8?B?dlVZYUFReXh1ck5wYWtSOWtHL3JpekVMeTI5c3NLYmRVaG5GQkZXbEVaRDJo?=
 =?utf-8?B?RFZEL1NFWjNwWVRtamRUb2FzN293dllPWitEUjFUSjF4VmZwWCs1NlZPczh6?=
 =?utf-8?B?OFRnTnZ6WjdZMkhnUVdOMzUybU9MWmNjZ2lPSzVpamhJcXJWTUoydGhabUFS?=
 =?utf-8?B?aWZWZE50TFV4NzZqOTNVV292VjFXODM4Q2djQ2JFUVhRZ2NKSDRPSHM1UkZO?=
 =?utf-8?B?aFg2M1U0KzhZREpjS3BkcWZUWWU0OUFFdXAwcDJFQzBVR3RDVXZQYVc5N2tB?=
 =?utf-8?B?R3FjOGQ4d0NlS0J4R0lwRW11ajBrdWpQRWxjbFVzeDFlMEQ2OENtTktnb2l0?=
 =?utf-8?B?czAvaXJMQTRYZHd4WUhpa0taRnUwR1g3VHFKSVNoOFcvZFBHRWJYazFLVnRt?=
 =?utf-8?B?L3BKS0ZNTXhmM2hsUmtyd2JNZTA0RnJsSUM2OWcxQVZKYWo5RlArbWN6RlQw?=
 =?utf-8?B?MDRqL2RDNUdQNi9uTUwyZHFpbmNPTWdkTG93eWFncE1MOGJST2VRSkFkZGww?=
 =?utf-8?B?M2pvUTFQcVRxY2pFYjM2ck4wQlNmNlFIVFdRRDN0VDBjQWt1M1pza2pBZi9j?=
 =?utf-8?B?a2dVNWR3NHRRU05KWGtqeXhvVFBKbGUzUStzRjg2TU1mMTFwNHRaNWo3VHNj?=
 =?utf-8?B?M1BreHd5RTRVWTBmR240eVFVdml4RnAvbHpuWXdVa3QwbUtMVXkwam9vZHVM?=
 =?utf-8?Q?zQWiXmeBM/nycAlsruwzFCP6XoYc1w64CjGQx/x22jKbd?=
X-MS-Exchange-AntiSpam-MessageData-1: Io8ujwKsEvvIUw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0059860-dc42-48fd-9141-08def6c20e93
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 09:30:46.2985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oontu7audz/pcuCYnKrzzapBi/VGPC4ZJpxqDFuy0adzvsrrARLgGBPBRv642xLOuFcHefoxEWFNr+do1IOEPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8570

On Thu Aug 6, 2026 at 1:35 AM JST, Gary Guo wrote:
> `IoLoc`s themselves just describe a projection from a region to a concret=
e
> register. Thus, support it in `io_project` macro too. Also, update method=
s
> that operate on `IoLoc` to use I/O projection.
>
> Documentation of `io_project!` is not expanded yet as the example works
> better when `register!` type can specify base type. `io_read!` and
> `io_write!` gains the ability to operate on registers as corollary of the
> capability of `io_project!`. Examples are not added because `read` and
> `write` is still preferrably used instead.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/kernel/io.rs | 58 ++++++++++++++++++++++++++++++++++++++++++++-----=
------
>  1 file changed, 47 insertions(+), 11 deletions(-)
>
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 71c6180ed745..ae18890866b6 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -295,7 +295,7 @@ fn transmute_neo<Src: IntoBytes, Dst: FromBytes>(val:=
 Src) -> Dst {
>  ///
>  /// The layout of the type and the underlying primitive must match; this=
 is enforced via const
>  /// assertions when I/O methods are used, as the type system cannot repr=
esent this.
> -/// [`IoRepr::from_repr`] and [`IoRepr::into_expr`] can be overridden fo=
r conversions, however it
> +/// [`IoRepr::from_repr`] and [`IoRepr::into_repr`] can be overridden fo=
r conversions, however it

This typo was introduced in patch 2, let's fix it there.

>  /// should be noted that they are only invoked on value read/write opera=
tions and are not invoked
>  /// on byte operations such as [`Io::copy_read`].
>  ///
> @@ -970,8 +970,7 @@ fn try_read<T, L>(self, location: L) -> Result<T>
>          L: IoLoc<Self::Target, T>,
>          Self::Backend: IoCapable<<T as IoRepr>::Repr>,
>      {
> -        let view =3D io_view::<Self, T>(self, location.offset())?;
> -        Ok(view.read_val())
> +        Ok(io_read!(self, try: location))
>      }
> =20
>      /// Generic fallible write with runtime bounds check.
> @@ -1004,8 +1003,7 @@ fn try_write<T, L>(self, location: L, value: T) -> =
Result
>          L: IoLoc<Self::Target, T>,
>          Self::Backend: IoCapable<<T as IoRepr>::Repr>,
>      {
> -        let view =3D io_view::<Self, T>(self, location.offset())?;
> -        view.write_val(value);
> +        io_write!(self, try: location, value);
>          Ok(())
>      }
> =20
> @@ -1084,7 +1082,7 @@ fn try_update<T, L, F>(self, location: L, f: F) -> =
Result
>          Self::Backend: IoCapable<<T as IoRepr>::Repr>,
>          F: FnOnce(T) -> T,
>      {
> -        let view =3D io_view::<Self, T>(self, location.offset())?;
> +        let view =3D io_project!(self, try: location);
>          view.write_val(f(view.read_val()));
>          Ok(())
>      }
> @@ -1117,8 +1115,7 @@ fn read<T, L>(self, location: L) -> T
>          L: IoLoc<Self::Target, T>,
>          Self::Backend: IoCapable<<T as IoRepr>::Repr>,
>      {
> -        let view =3D io_view_assert::<Self, T>(self, location.offset());
> -        view.read_val()
> +        io_read!(self, build: location)
>      }
> =20
>      /// Generic infallible write with compile-time bounds check.
> @@ -1149,8 +1146,7 @@ fn write<T, L>(self, location: L, value: T)
>          L: IoLoc<Self::Target, T>,
>          Self::Backend: IoCapable<<T as IoRepr>::Repr>,
>      {
> -        let view =3D io_view_assert::<Self, T>(self, location.offset());
> -        view.write_val(value)
> +        io_write!(self, build: location, value);
>      }
> =20
>      /// Generic infallible write of a fully-located register value.
> @@ -1227,7 +1223,7 @@ fn update<T, L, F>(self, location: L, f: F)
>          Self::Backend: IoCapable<<T as IoRepr>::Repr>,
>          F: FnOnce(T) -> T,
>      {
> -        let view =3D io_view_assert::<Self, T>(self, location.offset());
> +        let view =3D io_project!(self, build: location);
>          view.write_val(f(view.read_val()));
>      }
>  }
> @@ -1772,6 +1768,25 @@ pub unsafe fn project_view<U: ?Sized + KnownSize>(
>          // SAFETY: Per safety requirement.
>          unsafe { T::Backend::project_view::<T::Target, _>(self.0, ptr) }
>      }
> +
> +    #[inline(always)]
> +    pub fn try_project_loc<U, L>(

nit: missing documentation

> +        self,
> +        location: L,
> +    ) -> Result<<T::Backend as IoBackend>::View<'a, U>>
> +    where
> +        L: IoLoc<T::Target, U>,
> +    {
> +        io_view::<_, U>(self.0, location.offset())
> +    }
> +
> +    #[inline(always)]
> +    pub fn project_loc<U, L>(self, location: L) -> <T::Backend as IoBack=
end>::View<'a, U>

ditto.
