Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022131.outbound.protection.outlook.com [52.101.96.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8963A254D;
	Wed,  5 Aug 2026 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785949157; cv=fail; b=ba2uTbUAb8r7E8aciouWM+kb1xSGC5WeWrHXi3GGiIaSUXiII0fQe44lSVgM/pxHPJTuhp36fq5ZFnC06dT4zCWZqPAA1iO+zIl+9/dv3uCRMMUxP6J1N4W/rTt7dvcZwl99CWfKpNLJKEfe0reqdCSkxH74p9LoievZEwm5g9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785949157; c=relaxed/simple;
	bh=AwUFYBaFjOmqZQYyFToL+XGEC4fQJn1LKhjmmbVTYA0=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=aETc4Q7A0czYW6nvaqu4Nbh6SQrK6SdtC0kfUklZRLo4fyCbH5qbL0kOSO5VjFzG3s/sozTTg4I3J7VeDr0P/JwPRalwhvOU301tNAZFh8w10tGk5GTmuGLsM9tkFr252MovCKaTGmHT1+zhGuYQp/KOfbsSqep6MGW9jLMja2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=aN/mLPL1; arc=fail smtp.client-ip=52.101.96.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="aN/mLPL1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gfp2PLN0LDopNaDooJ7MAMmPwtmORwUsORZ6dH30KxgQR/LkV/fYfWsY+Py1HhtNMeyhVBtBVd4ngAtVXdZoqdFUfJ4Xh6dgb16wsKHj8rz23V0GWZLPqBmDU/b6cP+JascxQFbuPi1x/3yx2GwbQF+MfA/7xIY+f4ZzM0a3jbiulszwQTSNX9W/QAzw0y/dI5XxNFkEhDif+6YOv08ZItbgmmRyqwHxVWUj2/WkesXXQRKn/ZI5Hdc+QOhAgZBU8a6bx6gAcoK5UJ93xYOzxQXyomnlj3AexzdfEyiGxsmtW70dcDcl26+KgjuCb2YaWgGvwJL2HBdMq24w/tfogg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjn3ts974cxwP/aoNxSdo2bIz4oWxsLvrOFSv5BM40M=;
 b=S06a0pAiyyA20bNlcuREwEcwUWXWdJMFIgFuSW9oqffAKEBc/nEf4PUSFHckd2+sSrMztFKnC9mqB4e/OqSKAdPFQie54d0hGqi/wFQnISh3SbiMCOcVfSEVsA4knNbAP4WYQ62jOoPhrout5r+T6KGduzEza8IzQ0DplP8jKyHlCCY4uY+DA6i/ek59glJdNq4aRRifn4nrmA6lqwa4U+KqLd6OMk+NnlP14sgbRnM0cE7j/3v8/wycCpdozFee/0olQx5DLUMA+fx+IZy1TxooswOpC4yFccZHl/jpMEU0gF4NMF9S76tGNBAiWva3QcMl95TdSaKuBuFoz1uiyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjn3ts974cxwP/aoNxSdo2bIz4oWxsLvrOFSv5BM40M=;
 b=aN/mLPL1/8zGgi24lpbFNsittNs623lplb2LP8XXY55M+DwbzeeTFdbhHwyz87FpxBKE7MJeohng5ScRFK25H/KeU8P9kU+ZrWAuJ1IvZetTgVaNM6uEQMUh/wzjSlVfJqXWylv15QMRlc4rXmpOLj8J2br6m6CDkWq+QS8RiAY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by CWXP265MB3319.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.19; Wed, 5 Aug
 2026 16:59:11 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 16:59:11 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Aug 2026 17:59:09 +0100
Message-Id: <DKH64WXJI76V.3PA6HHOB9NNTW@garyguo.net>
Subject: Re: [PATCH v2 08/16] drm/tyr: specify base type for registers
From: "Gary Guo" <gary@garyguo.net>
To: "Gary Guo" <gary@garyguo.net>, "Danilo Krummrich" <dakr@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Tamir Duberstein" <tamird@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pci@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-8-c3ca142220a0@garyguo.net>
In-Reply-To: <20260805-typed_register-v2-8-c3ca142220a0@garyguo.net>
X-ClientProxiedBy: LO4P265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::17) To LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4b4::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOZP265MB8551:EE_|CWXP265MB3319:EE_
X-MS-Office365-Filtering-Correlation-Id: 55d13f5c-d0c2-4bd9-c275-08def312deee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|23010399003|22082099003|18002099003|56012099006|4143699003|3023799007|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	rkbsX6IC9uod52I2brmw6YYzGdPmmlmA06DiHR/4V6n4+65fUZx2/zVAFEjAFKQdpRnzZhubGU9lRJKCgQ2Mp7YnfA5bGCT+QeddgvytEDPiqLCBslU/SrqRrssxF+vo8R8jnMCxMQbKVh0Nde+xYUGpmJVxlZp7trVZ6sM1lGYJorTJLkoPlzrymwCJo4eQY/+FUKnALH9eNF8Lkc9WdSakrpAokaymc+IebyNPbzO/pU2sLlsa2lnDyepp+Q3RBbAFOm80OTAmvLNEwMgmZv+Qb6XUvbfvdmvqTMPuFWyAPKmIAk5OOH/a+ZjiNUZRCy1kdFPSYLuzcNLcTSPnVSS1bPPWZwjeb9y3mpoU30LvfQnpTnY49v9Zpf2UO21kx0H7vDSuC3xlEbln5+j3PcMcjZOE0DwPWBnjRyYi7gJYvM3Yj9SMRbLD++l5K2KcZKMDCYRm7K2bi4zy4HNb79NOENuUsTMzcP44A8QEXDAv9XPuzalBVs86wNu1TLctVAsKHLTgYADIDU9t1qfPXi3dor7UdpC34aRt7KrXwfJQ8QZKvKIhKzhL6Wz7UmJybQIZC2k76weKJaYm60COgT7iiCKLyfqZqyxKKI3/I8bs/6cCe1s9Yhj2U/MXv97B5dngLF3wRjirK64QF6rF8sjgodrkXvcaw7B/gvSuxwv1IQCFi0ShJnv1Jna1DvH1n3wjGdxvSk89wreEqVP7EQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(23010399003)(22082099003)(18002099003)(56012099006)(4143699003)(3023799007)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGxnSko0UnZ4WStWMnlZWWM0d01MNW9lZXBRSTQwdWxSdFVXUkE4MjF0Tzk0?=
 =?utf-8?B?WFpWTTkxL0xXQlFvYW5OSERCMTRTNENKTFR3c2NlMmI5c1h0d1FUWTJlMDkx?=
 =?utf-8?B?QzNZSXNkWmlHcURYRVBWbGJQTVFzQyt2OUM1UUhzeVpROFZOcHR5bVg1Z2VG?=
 =?utf-8?B?L09yUStoTDNWMjQyZ1BHaGthMjhHcm96VEZsb2JPN0RvYStNVGRJaVllZis4?=
 =?utf-8?B?b2c0aVZXV0NzakJMcm50UDJ2TjVYK0NyMWlMTnIvSTRwK2FXSUZ0QUJWYjZi?=
 =?utf-8?B?TU9LYjNwUjJxNW1nT01POWxsd25qSDllOG0zS3JvbUtVMm9icVk3MDN5K2k3?=
 =?utf-8?B?OGx2WGdXU3VXVHJEMlhLZGJHWGdabkZjUk5mTnQrZWxGSytLc2NlcUZKZ0Jo?=
 =?utf-8?B?T3RRRWRRZVRXUmxYWlVvdTN5dHQyOXpmbzZLOGw3UVNlMVlLYlB2OGFPalRu?=
 =?utf-8?B?YzRpdFRpT1Zzd1RXazQvOTVMYVcweGF4eFAvNUVHcVFzUDB2M2VCbnRKZWxy?=
 =?utf-8?B?NlJNUVFockhoUDNwRTdWdS9Ec0ZZU0xtZVRaU1JrQUlycnhCUWJVcVpxbVJZ?=
 =?utf-8?B?SXJ2OXZYUjBJY1A3MWhQTUcveE9uaS9QMDFRNGtwd1YrQlpFdDQ4dlRENXZr?=
 =?utf-8?B?N3g0cHFnNDhIa0d3RFZ1c09yNWRxdHdpZDMzWnVHbUFDaFlOSUViU3piMzJY?=
 =?utf-8?B?MzgwNURNQ1Y3WkJQRUFvWjI0YXpaVGs5WEtJb29IVnhTejNsVWRMSmd5TVRi?=
 =?utf-8?B?TU1kRTJPWk9xSlIrcnlZN1Bya1Q4UzlPb3lrdmprYUd3KzE3U0szZWM0Y0ov?=
 =?utf-8?B?b0FNSUpnKzlFbnpIRGpWNmdHcldmVFRNZmRnWjNjOWsvenlrV214NXRFV3lM?=
 =?utf-8?B?RVIxcUpobHV1TzVwbFpxdGxSNnpycC9Ra3hvMU12aHdHRFN1UHozVWIwSWtt?=
 =?utf-8?B?WDh1dElwa1ZLVkx0cnZMT2J2bGRZREwzZTN3N0kwd1k0QWUwT1BwMktrcVgv?=
 =?utf-8?B?bjluWGlkSGNKWDN6R0tVLzJzTTFLRUQ0TUg2ckkrZG40L1puOS8wSGFXdi9F?=
 =?utf-8?B?aGEyY01CZ3ZmbThiNWwvVGFUekhzVnRtU3FCbjVkVzZXSFR5QWJZVmVhMi90?=
 =?utf-8?B?cTBaWWFCTTRsNFpER2lBc2U4N3ZZaGRLUlNVN0dQVFovN3loR1ltdWxsSERT?=
 =?utf-8?B?a3JzWTJLZThhMnBaVE02Q04yZlBmZUlCYW5WSjc4NlhEUnJRaVVMcTl5eCs2?=
 =?utf-8?B?T2pFV2w0WDVqc0FIMDBzeDRnbWdrZmZOOVFaaGFYY05KU2ZKc29ORVd1T1R0?=
 =?utf-8?B?UnNtSk96RFJ4ZVA4b0xiZGJsL2svMFpmUTRSU1ZncThTVGQ3SkZnOU4vQUU3?=
 =?utf-8?B?WnBKYjUydUluSlFNYVE4U2MwMlE0S3BoYUN0VnZqTG4zY0pVVHlwZWJvc3hI?=
 =?utf-8?B?b2xhNmRHRy9qK3pFdVdveUY3WjdBRXBKSmFWL2R5NWRaU0wwc3pMd1FzYVJ0?=
 =?utf-8?B?M3FXeE82RVBueXR6NDNvWFQwbkY0VmQ1WjR5MGUwcE9PK1hHN3UxQnQybi94?=
 =?utf-8?B?Rk1MOFNJNTBzYXRYVzdVVVdnZGxnQWJOVEJaTTdwZnRxMDcvRU5TV2Zva3c5?=
 =?utf-8?B?UFBObWxTbTNHVktHT0w4dDFiS2VsS1lBb2dxaUtvSWtTa1FSR2JVeGJicEk0?=
 =?utf-8?B?SHc5Z1hyc1FBbjF2MzJNNnVPVU5hTWF3NEtUNUVtVEd2bWxNbG9Oc2hYYzlE?=
 =?utf-8?B?SUh1UzR0UTdmV1d4N0FmNkVLcWcyNUpCL0QyQmRURVdLNThYdGR3bzNPdXJk?=
 =?utf-8?B?bDZNN0NiSnhnQWJvbXBENExBOEdyUkJuVVNDV2w1MDdkdkk0RHpWZHV0eWVk?=
 =?utf-8?B?bDI0MmNPcXM5S1IxSk9Kalg3OWtEY3EyQk40OXgzRjYrS0dvYkRzcGlzTGZD?=
 =?utf-8?B?Mm9heHBLV3BDN1BtaHlVME1GaFJMRFBqZUVXdjFVc3BickRJcktibWh4OXM1?=
 =?utf-8?B?RldGemRqUTdNZy8yWDE4Qm9sNzFHKzllcVgwbnJxTjNZckFJR0w0NFh3TjI4?=
 =?utf-8?B?WHJFblBReU1ETDdzc25Pa0tEU2wyTjNtS0xmcTVKODBrV0x5blpJN3BvaVdv?=
 =?utf-8?B?WkhQaWh5YjFWWk5jV0hCTHB5Y2dCUzIyamhUM2Fydis0M1N3TTZPQlF1a3Fy?=
 =?utf-8?B?WFRPQjhIcXlROW9wV01NS3dqM081U1JEQ3RFOFFTYW1uWEZ5WGRpajhDZ0s5?=
 =?utf-8?B?ZUxiQjhhNUp1d0VSaHZHZDlMK2RpeWYyZzB1SW1uYUxnRUpLUC9XejNtTDlw?=
 =?utf-8?B?MlBMWXFSMnphUVpEL1dyQnZ5MHdGUkJZZ2sxb25hRjZuemdWejNRUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d13f5c-d0c2-4bd9-c275-08def312deee
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 16:59:10.9708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wnAGblyZ8fy0w98OdJKdQSWnIzNOW59aan/z71sqo9J9HVIDfINbgesU4m3mHCD8VkEIwf7nC3cvLNLL9vAhKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB3319

On Wed Aug 5, 2026 at 5:35 PM BST, Gary Guo wrote:
> All registers use the same base type, which is `<IoMem as IO>::Target`.
> Thus add the base parameter to `register!` invocation.

This is missing a few `register!` invocation that's introduced in the new
linux-next base, as Sashiko points out. Will include in the next version.

Best,
Gary

>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  drivers/gpu/drm/tyr/driver.rs |  1 +
>  drivers/gpu/drm/tyr/regs.rs   | 43 +++++++++++++++++++++++++++++++++++++=
+++++-
>  2 files changed, 43 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.r=
s
> index bfb0ba19caff..730b84e37a54 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs
> @@ -46,6 +46,7 @@
>  };
> =20
>  pub(crate) type IoMem<'a> =3D kernel::io::mem::IoMem<'a, SZ_2M>;
> +pub(crate) type TyrRegisters =3D kernel::io::Region<SZ_2M>;
> =20
>  pub(crate) struct TyrDrmDriver;
> =20
> diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
> index a62724378ced..3e6edae6e27f 100644
> --- a/drivers/gpu/drm/tyr/regs.rs
> +++ b/drivers/gpu/drm/tyr/regs.rs
> @@ -57,7 +57,11 @@ pub(crate) mod gpu_control {
>          uapi, //
>      };
> =20
> +    use crate::driver::TyrRegisters;
> +
>      register! {
> +        base: TyrRegisters;
> +
>          /// GPU identification register.
>          pub(crate) GPU_ID(u32) @ 0x0 {
>              /// Status of the GPU release.
> @@ -315,6 +319,8 @@ fn from(mode: FlushMode) -> Self {
>      }
> =20
>      register! {
> +        base: TyrRegisters;
> +
>          /// GPU command register.
>          ///
>          /// Use the constructor methods to create commands:
> @@ -380,6 +386,8 @@ pub(crate) fn clear_fault() -> Self {
>      }

