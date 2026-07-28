Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010070.outbound.protection.outlook.com [40.93.198.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766EB35DA5D;
	Tue, 28 Jul 2026 06:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785221243; cv=fail; b=exEBoBTILqvtSDGEiSYmv9bPFQ6bMc8lvkHeVgVU+RGrVI2vtxnBKnfdtTr0QMlVqwU80oE3BNz5jTicECwYnatqqC++Xaa2NTEV/t6/EaOoV2XpKuUL0yS+MiHmWIbEhmS/OlRDWxudgXQmIbEJpD9PXpvHq2mpKEleA7S67ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785221243; c=relaxed/simple;
	bh=AD+Za3qeF7t21R8+ztsuj5cvp+JMeJirmdVuWWAbI2E=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=ELXw/2Jqvsvjc07dWR8aL7aecSmrxsSbUT/T5JYBNAKtIo0pHw84T9YfK4ut3/sPiwYmEKt5+STxY6yyIMGselOyxQE8wc+8thDG+fV31nO64nBUZli0YmUabuhmZI9bL2MfJpThQQHYhfHL+sx0DHh6cUz+g1cu+623LXZhycA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VBqlvbk+; arc=fail smtp.client-ip=40.93.198.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VBqlvbk+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPTb0yD4E/nh9GuroHsv7Mgy4OSun8ijhZBp9KZ+YOmy7IdOxU1z0fblfE4IW/AL4RG5Y1tiVD8OkJYUnebAaFcnGQ+xw7J0mRKQF4piM7LshkRQUNU4C/QjmxD2AtqdxRnpocJiPQ74XAP05x8B0/DZGU80grPCeMpN2i0dJIBz9MOwCOHMb6eE3vAYOTca8L2JKbW11vaxDKOHNsdapd+g4OqiZBlcjGXKw/JQ6Sdd4J7ZJcNIncwYe0zj7h04DKw52UTPNKBfMy3DIuQbpfoPKaS12IL+XDX2XbXo4WW3ed3krkxR2BNw8Qrt9BRY14iT7eiheWP0XZugE61rKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfE1PlDI3+ERybm2GTiEZJNW6CAc+D03sYC0CaLHa0o=;
 b=LuFPR6J5BErPyAc7JMHNjpXAP5AnUMwCetyBWOHr/KQ+mI/PQ/2YfjUSrQUrZz3KmZ1fgBFAvFSEqmXbWWpKfSWhPvQwlYdUbjNG8ynME2kCy/VpFArbaXGYRotiEqZsQ/iLX6CxWmpeQTcgOZRjkJqJMc8SV/D/21RGHSXv5BomTcVumqQfOudsmzvORUQa2DsvgJo1Y43UnvowZydRsNRR/wFnslfNJSFlHpDM1DFpnSvJzdh8b9qZAtLY95ZoV1nWxgk9vN984Aqi/JxhTMX76c+aRFt2YoMQIvxVo3zMzfRk85672v/p2Y2U5KQh3ZCPVRGSEL0S7R9ts2Olkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfE1PlDI3+ERybm2GTiEZJNW6CAc+D03sYC0CaLHa0o=;
 b=VBqlvbk+Ppx+a7EW5IzUDyHFuvFb27ekhw7OfIHNzlBbQlebb0ADqFdYqHmhS38ZZvMGFuxSBhjuKsgXL6pfEU0o8MPlSGW6RpHlZsEd5e2JOWEXlB8sCJoROxwgDptKwVcbTdFX+uDmsZkoH57RMKTdBrJl+uLYDO88i7veptEBdo1emvhuopaF6NGxZECO4P2u5GoDcMU98X2BLpNSkYLxnYRpWad2Fo87xVtxj+sGWk/DCh4ZUQyNUdZJBVHidgbS2hOrPqiwyeaVvSByCMy6mgiHsYWXigG1wrlUHjPKKT1Eq7NidqwqLB2uW8IIdz9L5euk0KjedSZD/+KNhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB6726.namprd12.prod.outlook.com (2603:10b6:806:255::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Tue, 28 Jul
 2026 06:47:18 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 06:47:18 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Jul 2026 15:47:13 +0900
Message-Id: <DKA0410BYJ1Q.15ZMOQJ0XS9I2@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
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
Subject: Re: [PATCH 02/10] gpu: nova-core: specify base type for registers
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-2-452d72b60262@garyguo.net>
In-Reply-To: <20260721-typed_register-v1-2-452d72b60262@garyguo.net>
X-ClientProxiedBy: OSTP286CA0021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:216::6) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: 7869756f-b464-44e4-c784-08deec7410fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|10070799003|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fMKVkKch8o9NsCwZNNc2SnSKFhr0MDLpsT6VGYRTVxnoiY6BWn6FMMyZuYgeLJ+FrWihOs96vAbek5lFfYROLWgZkzooqCXyiWFpy1ei6NAwHZhDx4hlCTn7J15zViBJn4ZN+V6DP3Xtad5m9FJyUMMkpjwsCRl5/vRYlAMd5ADHjXKg3GrWXVYJ15KC1xZ9ndwRSzCB7i1AEum8XULbOxcb1GLELR1mC017TMyuEGyq5pXjdBJtgGYdimcbHOQSoNKHDlXheSsFHadqayR7CbWcP2tCvclNr9fWSi0Sn4I49R2SBsObnFIBdu73BlXyi7n+aJ2kQde7/l1sJwwSs1qAIvCudmJhf7G78bLNxlC9+q4YUMLr2YisMmnLfztX3Z5P77ZxYkgLOb1AUYl0MJVMWouCJ+1J3XdfVwO3LUJqqofIYHzUJQNivgSDNbS0QIlOkmGjwz4DCnrHIOZgsUiM4w4Tim/ooYu3buDARu+7aogRNPkeaFP1qTQ7/QScfWKMfBNC2WLazdLXkVeeogz+Rf7S2Xaq3juzRkMVcXN991nZ8HoUZRDiMamP8X31HBt7uh/+d+NJ6J23KeNDGKSzPWt2P5hKHqATNsPSL550ub2bnGFkkUn9hPUPPcp6/5wekwYeAknK6NUDI89zfTIYncQVikNOISwDZm8u66k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(10070799003)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TG5Qc0pZeEE5UVIyenByV3hYK241d3QrUThIbHo1ZjYzRTBldDFvVHNPci80?=
 =?utf-8?B?elZQSmpvMjZGRjhTTi9VRTRXYTU1SWpDV1REdDN6ZXNWb25VWkRETTh2dU5R?=
 =?utf-8?B?aDdjN3pabHZrWHB1MUsvSXptQmhSUTA4V0NtUEh5QjNJSXlRQ3VhRDFnSUtE?=
 =?utf-8?B?VTVTYXdtUlNjNkNBY1hzSFJ6Q0VvV3dmRFJKeEtCS3daTmszTGZaWC81aGJL?=
 =?utf-8?B?ZllBVUR4V0Ntc0x2T3ZaRHpkcWptSmZvNHl2Ky9YckhxaTd6NnZIbnVLK0xE?=
 =?utf-8?B?alJoYUNlUVRsYVpxbGhSbTYzdzFDNElRV1pxU1VyUm5BcGoxZ3NNeWxFd0dy?=
 =?utf-8?B?aERTeFNBN2VwVGlyazBqQVdtWDliVnowbFFJeXNPZCtpOWo0QVgwNU1SUWQ5?=
 =?utf-8?B?TWlaVE9QeWRUL3hrNUJHdi9GOHpnY0huQk1NUTJCSTVUUTh4OUFyVmdDYnpz?=
 =?utf-8?B?em94aHFXVFlGYUJGSmhlMXhFcnhJNFR6OUszRXM2RE1Ld3lVL3lSdDB2SDNS?=
 =?utf-8?B?K0c1WjBEKzRxQzhUcmhDejhvcnA4c2JqK3dnOWdxMUp5enZtQnN6bHJCdG45?=
 =?utf-8?B?c25aS1p2K3REL2k5amRVNmh5S2tTa3IrdGhRdGRvdnFnbGIwQ09tb3JkMzdU?=
 =?utf-8?B?ako3RnpWWG5HMytEUnRpc1QyaEZGNGlMUmZBMFFyaW12TXorNHJzNjVNRVFG?=
 =?utf-8?B?S1RYeTdyVjU1K2kxUG5ZTmtURldvTGlNQ244ek9QQk5VNnRPUHpsQmtYM2dB?=
 =?utf-8?B?MGdWMC84TlA5TFR0WXZHZnpkbDUxRG1GN2YrelRObFV3dTR1UE00OW5MWUVn?=
 =?utf-8?B?bnE0a1lTeDdTV0lWbk4vM2FHbnB0UDEwb3R0eG15ZjhqeTRhWmVqM3VPYVVs?=
 =?utf-8?B?R3NQNmZPTEpaRnUrZ0dkVkx2SytjM3NDbUd1cDd6QVV4R3RicTFZZVY4dlQr?=
 =?utf-8?B?UXIxd255N0cyQXhkM3FiVXZaMXJ6cS9aanpQaVA3d0R1U2h5cENMZFVOTzJR?=
 =?utf-8?B?V21oOWlnWlFvWUtiZnZwWkVIQWViN0NVZVlMNjVDMGloVWk5czJUVW1EZHFt?=
 =?utf-8?B?SU5HV2pVQkp5aDMrU2J4bTMwR2pHdVdOclh6SWVtcUcyL09abS9oTXdHT1Qv?=
 =?utf-8?B?Vm9aZUhuMlF1TWlJcTA0bXVHYTVwcVdTM1VUZUVtRkIydDcrTlREd1pLYmVl?=
 =?utf-8?B?MlNxeTI2WlA5WHV3UEZ2d1pIdmhScU10djdhUXdBQXplWnEyU05PQ1l2bGFK?=
 =?utf-8?B?a25zRE9ackpUSHV6QVdEbERuYUt2V0k3bEJHa0w5Q2poQVUvaFJtdW9UeUhB?=
 =?utf-8?B?bWo3ZXpIZXBPNmtnc1hsSHNLaCtEU3B0c3pyMDRTd1Fkc1Axb0NhQndWOCtl?=
 =?utf-8?B?bDNBcnpRT3E4UForZ2tERmZkSTMzcXl6cExIcnMzdVY1MThMSWROZlZET1FG?=
 =?utf-8?B?cTdXaEVrY2E1bm53QklnTTFIRHg4NzVUSGpQOGNuejZsS2tNTzI5Nm1hT3JY?=
 =?utf-8?B?TlBVNzVWTHpxRzZSbmE4UVRYZGtScGZlNDBLM2NaVlRUeUVQMHQ1M2ZvRDh6?=
 =?utf-8?B?dUk0ekQ2REdUZ29Yc0RBYnFZM0pQaldRbm0wT3RFUVVMM055VFdNT0J3RStu?=
 =?utf-8?B?aGtJcFhzZm1taWJ1ZTRvaDNoa2NnU2lFbWdYK21lY1Z1d0MyQWp5Vm56Ung0?=
 =?utf-8?B?RUFNNUJwUDRpOUd3OU8vbXJlVDNhc3RteE1zTWUvMzNQdEhlMkV0dnJ5cmdT?=
 =?utf-8?B?R2VaVytoUitDdGFHbkc0NlUyaXlOMnB1S3hrUVgrSG40QTNOTWg4R05Mck5l?=
 =?utf-8?B?SUFkWG5rQUZJcW5OTVlsd241WVYxNWVqRit3OS9Ha3c3cVZFNE5sUVRoKzhh?=
 =?utf-8?B?WEQ3YXRtbTdyeXNBMmZvT1VvdHpLM05PdDZpcGE3dWlNclFRY05zcXA5RFl4?=
 =?utf-8?B?cm4vUUtsL3BIV05NMEU4dEpFeTcxeWRZM2NBQS85YzNuS05Hd3p2UTRiNTdT?=
 =?utf-8?B?RERMVjd6dkwzWWRrcmdDVkx4Wk9vNzlkdjVxdXl1d05YeDAxdVlVbWw2WnN1?=
 =?utf-8?B?dzdNWVpJd3Uydk14djBsWDQ4VU93a0F2dVNUZWt4N0c2bW12d3NWYlBwY2JW?=
 =?utf-8?B?WFVvSnpOYW1Zb2N1L3doWTNJdlYxMDhacjZ6VElsMm5PVjJ5MDRhWHZ0Zm9L?=
 =?utf-8?B?aHdLWEtaYlQzTzhhd0MzWFcyVVNaKzIvVzFreE5xR0JSUVZUcWZ1UUxSWDlm?=
 =?utf-8?B?YzBNV3hFSUVJNXExVmtyQm13YzQ4ZXZQenBWZUowWXFYcW5URng4S3labEZK?=
 =?utf-8?B?NHd6YzVrbXhBd3lhQjV6ejY4cWlaVjhsSFZTYllXM0xIOEVPN3VUT2lCWTJt?=
 =?utf-8?Q?PTHLL6XZL+LxwHGxx6UJJfv9oeM6ToxDEXaUCzpD5Un1H?=
X-MS-Exchange-AntiSpam-MessageData-1: xwAAiT4YI34d3A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7869756f-b464-44e4-c784-08deec7410fa
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 06:47:18.2003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZeGZ2TmgJaDBhM8lVvi0rsr/CgCVSqFLrb5H65YOGLF8ySuwYLzCOQvBZ7TJ6Yp7rUymBbc3dXK/waTOh4T6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6726

On Wed Jul 22, 2026 at 1:54 AM JST, Gary Guo wrote:
> All registers use the same base type, which is `<Bar0 as IO>::Target`. Th=
us
> add the base parameter to `register!` invocation.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  drivers/gpu/nova-core/driver.rs   |  1 +
>  drivers/gpu/nova-core/fb/regs.rs  |  4 ++++
>  drivers/gpu/nova-core/gsp/regs.rs |  4 ++++
>  drivers/gpu/nova-core/regs.rs     | 42 +++++++++++++++++++++++++++++++++=
+++++-
>  drivers/gpu/nova-core/vbios.rs    | 11 +++++++++-
>  5 files changed, 60 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driv=
er.rs
> index 48380ac15f68..fe82363a8201 100644
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
> @@ -37,6 +37,7 @@ pub(crate) struct NovaCore<'bound> {
>  const BAR0_SIZE: usize =3D SZ_16M;
> =20
>  pub(crate) type Bar0<'a> =3D &'a pci::Bar<'a, BAR0_SIZE>;
> +pub(crate) type NovaRegisters =3D kernel::io::Region<BAR0_SIZE>;
> =20
>  kernel::pci_device_table!(
>      PCI_TABLE,
> diff --git a/drivers/gpu/nova-core/fb/regs.rs b/drivers/gpu/nova-core/fb/=
regs.rs
> index b2ec02f584be..4296bef5f262 100644
> --- a/drivers/gpu/nova-core/fb/regs.rs
> +++ b/drivers/gpu/nova-core/fb/regs.rs
> @@ -2,9 +2,13 @@
> =20
>  use kernel::io::register;
> =20
> +use crate::driver::NovaRegisters;
> +
>  // PDISP
> =20
>  register! {
> +    base: NovaRegisters;
> +
>      pub(super) NV_PDISP_VGA_WORKSPACE_BASE(u32) @ 0x00625f04 {
>          /// VGA workspace base address divided by 0x10000.
>          31:8    addr;
> diff --git a/drivers/gpu/nova-core/gsp/regs.rs b/drivers/gpu/nova-core/gs=
p/regs.rs
> index a76dea3c3ab0..34ce8dd1f464 100644
> --- a/drivers/gpu/nova-core/gsp/regs.rs
> +++ b/drivers/gpu/nova-core/gsp/regs.rs
> @@ -2,9 +2,13 @@
> =20
>  use kernel::io::register;
> =20
> +use crate::driver::NovaRegisters;
> +
>  // PGSP
> =20
>  register! {
> +    base: NovaRegisters;
> +
>      pub(super) NV_PGSP_QUEUE_HEAD(u32) @ 0x00110c00 {
>          31:0    address;
>      }
> diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.r=
s
> index 397124f245ee..f2aadeb429b8 100644
> --- a/drivers/gpu/nova-core/regs.rs
> +++ b/drivers/gpu/nova-core/regs.rs
> @@ -13,7 +13,7 @@
>  };
> =20
>  use crate::{
> -    driver::Bar0,
> +    driver::{Bar0, NovaRegisters},

nit: formatting of imports.
