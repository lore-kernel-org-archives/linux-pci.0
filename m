Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013043.outbound.protection.outlook.com [40.93.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73CB49F101;
	Thu,  3 Sep 2026 12:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788437795; cv=fail; b=HC9XJqDkMZIAUGJ436SAH3atxOMw74vuT7OwP+m7DWgKFyaitJ33gFVivDR+lFsujsJiLzjoIug3CDrDTMNrWTSXxsuwvT1vBY4JRBGUMAbbilGuGXjdiu2lz2WYm4ecdQMn0AHhRmV3oW20kekuez8u0OSqsdJDbKefHL78N90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788437795; c=relaxed/simple;
	bh=Cu+YfKbkK3Elnm649K1imJRrj3klwkpXawp4GXVryog=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=BrDsKU1EpZG6vO6VOePY0iUuRE9uenVpzCxyf9UUuJUx74GMyi2c4iRWhNIe7pBlEykOqlz1MXhpe+H+b7BYCTkVZ/4u00jKm/zxANBwFcberPHPH95yLPQhbZzU5FXyVoLsX9LHaAiXirKRr0expJp2yxl8DPexEwEe25Pgt2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pzGe6Nca; arc=fail smtp.client-ip=40.93.201.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pzGe6Nca"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJOrcsHtN8BmJnY6Ty3S9xgdjA55P+Ol6AYnM3pLBAJ1FNnguHdlAIj6qIU5GzVIGFbmf+QydBPSEAaZQGYVypcucsW4AMP5VN9XOSbfwg+YSkgF3uk2ixVUdn8duZM3Kye1TrYIJBnOaVgvU+OWnMb/g3JifrTY2qJvKrbHc0GYcSTjRaOvga8llvS5b10MpYdYcycths9Tf17CZai5WBJvWJz/GvkE+HHGY5mvtMPs1JqUohIxvrIgT3E6jxIyZQF2JLEXp0Y1YwO6W+WQK3JI+NOu0b3oawM5e1353UG9xrd0lH5ztzJUentJOv9cc7cPogFI4vG/WGDaHwyz6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUlykFTZZ8TnZRebXgBLBGZB0oy2URo/jdNQFJ7FZ98=;
 b=IaNfGPaS/cdR76waG62olVTBPUgcFr6+HXl34vISJazxeOlPowlKCPsAg9C/foHTgCsNa+Q2/teca2GxgfE4CW11tNY+j4jNuUYxpy6vFtYr5xZ5jzfMwDFpFDb8acFB+fgql47qp+PWWIS/gioDto99Qy+7M5G3mJtvJyw+belQ5aiOllSMCH+R/NeHrgcviT2PPOcZLFnpPTznV2VzKDbEX2zNjAXLPn3paEpkOxY5UtDASeBUxqOEJwrwynqEhqDeBxUgF/Ke3UyIu3EIQFCLFQqJOC2R9aA+t5eCtRIKuAaPK8LqGnenRaD8zxqDDQ88er/+BSPqIJM7XUtufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUlykFTZZ8TnZRebXgBLBGZB0oy2URo/jdNQFJ7FZ98=;
 b=pzGe6NcazwBrtAwXoa+NoGZfppbdkB/ulk1+iQNB+kKWCa5dXIVERQS3LxEMnU9g99csXET30eUBsIma+JiwTIS4iLruSR7IcuR5F9q49x33dR2bQrIxY+paOZddNW51h3ZLzTKoyydXg3r3e6HVvq6FG4FO9xumBuZN6EwsMiWWCs2KozVACY1xZ027TSLCMNVxnGrZgq8QRnPU8zjLuUpHQMLa635E6KQOUfu6Yn2TCjiR8Lgy+oUwYbQdYiNDWFCQetZ59/oz7ePCGiOlV93+5+TpskwGdbWixF7pDoxA/Hi231Kgypr+I+VX2JL/3yFPXl1AsZrM5U+S4HGrNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by IA0PPF864563BFB.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 12:16:24 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 12:16:24 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Sep 2026 21:16:20 +0900
Message-Id: <DL5OA67F0UZB.12K59UK93P4FU@nvidia.com>
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
Subject: Re: [PATCH v4 06/16] rust: io: register: allow explicit base type
 specification
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-6-5552b1d59525@garyguo.net>
In-Reply-To: <20260901-typed_register-v4-6-5552b1d59525@garyguo.net>
X-ClientProxiedBy: OS3P301CA0003.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:604:21d::8) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|IA0PPF864563BFB:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df4805a-7878-4bb8-09cc-08df09b52bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|23010399003|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/++JCpq36Eyr++e9F3b3FhFxbRNgWdzCryVeTe790zjW/HWbGjy+gitEAoU8epeVHLxRC1MWTxYFEEqXO2sOYZewYUIzSr8UVhDD02GQKbeihZh3ZBLedmEcj+2noVOXqTCCQ1Zz3rQj4M6xMOfDobhPr6WX11pkIsGCc44FSfuxe/r5/Q+bZWErZ4vEy9UnyGG4E9xMJkXBFZnC6afysqHUWtLyf8c9jfUDZRpxsUSBg7yVJ2Tb9VKCCNkK2MiKIhBnsdfoxhBLQ4Y1HG+0qxqPVLenzCjTxcFzDjW1oNnbygnRKTMdE3wY0H3b8KMDUmuqM9YEqTrHFoHklJssSdQDEXRIMhcsmLG/vS6+ymTtQhmrgQRGDn0mEvjXSPfWagZwQkS1XEcqWW1mDPkIxLqXdYb6UFLa7XRT+lDroLUE5ldrzvA8zbEoOQOKvYH79sggRIOwWuqTJvnwxiPb+nfSE5H0zxMcI/EgNk7BtCWDywKiEBm1Q7fW4QCU05WBUa+oBNkRCVm9hyyuydgomTLB3VAH7INJQJ3toXUQP16sWVKqmB8tohv0ET4TxryVN54AEjMKyeuj/CuYCCvRz14R2X6OIlrXttmBqQOVstC6YL+eeONZWZZYlqQI60rk49jrbTo1qnJTrfRtaiNffBhVXKFZuJXTlPIv3qCk1xs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(23010399003)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzNVb0hKQkp5QmdJbmVFOTFxdmh3MFNESU5zYk5DbWhpeWFqUXRWYTRKR2ZQ?=
 =?utf-8?B?QlNGeVlyQzBLVTFxUVdjVVJVRjUyWUljZ09HSklyVlVxcm9IQzVHOU1MTmFH?=
 =?utf-8?B?OWpzZ1FsNWpJdmNTemwwRm5NZkY2Wmd2cE1WN3RmUXEyVkdZUkhSUlJDTkM1?=
 =?utf-8?B?TW1CSGQ3dmZpK2t6c0hXQXZxL3g1ekZwOVZ4Wk50NU5TYzZrTSttVlVxbnF3?=
 =?utf-8?B?QzNBajVQWW9US2NlbDFCUDJaY1VnaXJYMkZiMHVob3doK2RLcEVsdU04WERu?=
 =?utf-8?B?eG1IWHhhTGQ1bGFMUzY3cTdHM2JsMFJwZkREMURydHE4MVdabEl4MmtqL3Bv?=
 =?utf-8?B?RXl1TFBSUCs0aGdpS21lTHNaWm50MU1EM3gyVXAyMjU2eVNXUkdlTFRUREsz?=
 =?utf-8?B?UVZlcG4yY1hPdjRoUmNzcFpxeTlsZ0E2YTVWbEFCU0dtZERSR3RiZG9tbmZS?=
 =?utf-8?B?ckhqNHB6VXFMZ0NJSVNtMzRoZ0dSRFh4N2dteS93bWNnM29qYzlwWGxFc2dD?=
 =?utf-8?B?YUlMdXczQzRnNEhZdjVYSXNDK3U4cGQyUy9CQjRyWW5HK2NQMzdjSzdmUzNk?=
 =?utf-8?B?NzlMN0VkVUNNbkYycnIzYVNPem56ZUhoL2twZEJCeHc5TlRjRkpHRkR1M2FD?=
 =?utf-8?B?V0czOVhFSC8zUzVIeXVoMkxvR3daSGdBci9PZmhzOU5RWjBXRFRnbzlmeU5P?=
 =?utf-8?B?eGRwcGxrY1M5SUpEUE1UVUdoU3FlMFlwOTNuZjI5WWVoY2x3YmNWNFVIVWNU?=
 =?utf-8?B?cDJvck5CMC9Sb2pRQ3A5UU5YTXJWeDV1cnNoZTRJcklmdEF1b2pxcEwwUjJM?=
 =?utf-8?B?UWdpa2VQai8yL2NPeFpvSmhGVjEydmJENERQT2RXRlU3SU43MTRNUXpGVFA5?=
 =?utf-8?B?Qkk0ZzYrZyt0d0FpV3pySUlTUVRzajJSV0dKc0JmR1FnTXVGU0dJc3pxMm5M?=
 =?utf-8?B?TnRDRjh0SzdNRmdSeFQxMFpSZHcrWU40SmFSVVE1MDBlSmZNNVBGVUk4WTRw?=
 =?utf-8?B?aE1vdGhHWnRxdTFpM0JRTVNpQ0tpZUQ2QmFmMlhKRjVtVVlUckY3ejErVTdQ?=
 =?utf-8?B?YW1BRHV6ZUVhd3lMOHgvb0JCVHBocUp4eWxBV1pBb25EV09xVzBSTU5pYWVR?=
 =?utf-8?B?Q2xNRGNzZ3o3YnMzRzV0TjlEYzZ0YlowdzRmK0xtcGx3TGEzbmE0Z3lwN2lG?=
 =?utf-8?B?bWthcXNWaXRTQ0g5VVQwcXVURThzbDRkSzJYVk1waFZ6RFVraTErcmxGYjNw?=
 =?utf-8?B?R2lwcHoxOUUyMnUwaUdIV1FKdm4rTlZyNytuQ0F2R2JERmxaYVZsQndKUWpV?=
 =?utf-8?B?SE94YTJJOWxueWJiZTkxbmRWektjcklFSUJqQnQrRzYxZFFJL050NitrRGJ5?=
 =?utf-8?B?VlRCY2xkNkgrZkNLVm4yS0RzdVFaS2pNR1NBV2E2MG9aS2NMMlNWL0dKMGdz?=
 =?utf-8?B?VmxxaWRYV0JzY0JVd1laZW5LUHFHMithTjd2ZEZ2amVLbi9BYVBGUHNIV1M2?=
 =?utf-8?B?Zmt6dXVac0g3ek9yb0pHWFNZYk1WZDUwaDdmOG8vcGxCWjFrMXJLMU1oY3hR?=
 =?utf-8?B?amE4UURmWXBIMFVFVWV3NEFXaHV0Sktyamp2QjdaMFpDaWN0OURHdGRKSXBB?=
 =?utf-8?B?V3RwSlk1aUsrbE9NaFVMZ3I3dENyS0J3V1JOZTFzNlNiR0hXV2JPYU9MNGcw?=
 =?utf-8?B?U0Q3ck5IUmhSWWE4OTExMmRrR1JXbFg4eXByT2NHSUdMMmZVUWRaeFoxYURp?=
 =?utf-8?B?MmJXYS9LOVhJNGNFT3hvV2NTb2xabE9WZHR4N1lkaklPTStlV3h2ejAwdERi?=
 =?utf-8?B?V3NtZzh1b2UrVVZOZDFMTjlyczV0aVBFSlBRcE5HbDZIQUVPOWVtQ1VRLzFY?=
 =?utf-8?B?OVhDNENkWFBqS2JzNlBSWWVINFpxRXF2UFpSV1lUOUc3SnRPOERZUWNxUkND?=
 =?utf-8?B?Qmx0Y3QySHcxNFVlQXR0cWtnRXVHK0JKMXBWS1dsdXpROHRScTV6T1dud2VO?=
 =?utf-8?B?KzN5VEd1b0k0YnJZb21XVzQ4WG00VENtRE1XdzBTbWl2T0t3dldrYmZDVVpQ?=
 =?utf-8?B?cjZrKzdFU3JIU2pHOXZvQTRYOHl2RUs0dGZiaDA2dzNMSnpHaUw3RzRLU2dj?=
 =?utf-8?B?elBlczhBTDRmMHdTc2w0N3RTbm5QNkl2Q1p1Q1R4L3J0a2toUTB6WlAyaU5y?=
 =?utf-8?B?V0FiT3hxSFVTU3h4STBJMDNOQ0lldC9pdWRwc2p3Q0VNWVE1WkdwM3djWDho?=
 =?utf-8?B?b2NvWFpiVlR2Ri9QZG11QWgyWWlWSXVjL0ZTWHAwanAzODZGSzNLWHBXWFUw?=
 =?utf-8?B?bTdoaHRLemZKdGEvQ3JUaU1uVmpyQTllSGQ1M0FKQldqc01VbktCVUNSUGhL?=
 =?utf-8?Q?P/faOGuOq8XnlYv1cfs5Lgrq7at+6583lziOFuIoP3K6M?=
X-MS-Exchange-AntiSpam-MessageData-1: DcqJGzfjwp4gCA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df4805a-7878-4bb8-09cc-08df09b52bfb
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 12:16:24.2886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VCzJu+CeF9yAEFykEnAp59zvdEsvicGo/9KvBJ2TQIADrqkrcM7PABqd9aXpEzWx3RYTGzR40CJGmADUrHrITQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF864563BFB

On Wed Sep 2, 2026 at 1:50 AM JST, Gary Guo wrote:
> Currently registers work for all untyped I/O regions, which is not ideal.
> It allows registers defined for device A to work for another device B and
> there is no safeguarding at all.
>
> All users of the `register!` macro know what type it will be operating on=
,
> and that type is consistent across the driver. Therefore, add a `base`
> parameter to `register!`.
>
> Currently this parameter is unused in the generated code; it will be used
> when all users of `register!` is converted to gain the parameter.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

With one nittynit below.

> diff --git a/rust/macros/io/register.rs b/rust/macros/io/register.rs
> index 9b92c8099edd..851335792a46 100644
> --- a/rust/macros/io/register.rs
> +++ b/rust/macros/io/register.rs
> @@ -29,6 +29,7 @@
>  };
> =20
>  mod kw {
> +    syn::custom_keyword!(base);
>      syn::custom_keyword!(stride);
>  }
> =20
> @@ -152,22 +153,42 @@ fn parse(input: syn::parse::ParseStream<'_>) -> Res=
ult<Self> {
>  }
> =20
>  pub(crate) struct RegDef {
> +    #[allow(unused)]

Now that the field is used, this can go away (also generally I believe
we prefer to use `expect` to catch such cases).
