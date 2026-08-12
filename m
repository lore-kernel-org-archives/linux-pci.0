Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010004.outbound.protection.outlook.com [52.101.46.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8BA46C858;
	Wed, 12 Aug 2026 14:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786546109; cv=fail; b=Xy48gwOYd1RQNzCcXyhwW9PDF0HpQKlExQN7ucNI+tlMkpdMBQfLybdNMp6QJzOh0Ulrpn9krl2YbV1weGB+II+1FlI4qEV4peOPRLe6f6kx5iPW2nxVs1DRomh74iNKSjZtWB7UA115uaPls86n/O46ukszXwkduFOMeu2E0h0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786546109; c=relaxed/simple;
	bh=a9YnaIYaP20ltOAZEV43CqT+DtKIzJGnvLSi1H2OrXo=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=W6klkOFyosjGGC1/Wc0kVWhOqz+C900velMoVutujn+QlREqsNrK53moojfJbiBH4lvdV5GQpoDAjC267biJi6PfBaOUqAfwDHjYQX9E4kLx+OilVPrX206BPKXKWTUWuDhHA0C858e//99HR0WHvuanzn2KOHxeSUcIEaKFpSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hG8JQ6O3; arc=fail smtp.client-ip=52.101.46.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hG8JQ6O3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWJ2dI+/yExQ6bOA9a7txJtQWa3+IO0E+UUTX5LS/oIbkNiDKoVZiuJxZTnglk8UACjOdw0xLb3u2uFzMijrNUW7TIaDw4WLjK+EPEXPohGdP/k2J03cxTHXuXEoMbo6yJQcIZTc/iujy9AmSa2csOADNRM+L7maXq0enwZXSibPdXyaFcpBdJQM9Y7cVBSE/L8mWGKSka3CfmLjIG0X25/jZDSW3V15fBiovm6TI0ZO3rYfBVco6Ged2yFxeHV5TbL+LMAgeh1xo4Gy48lNxnzATDAD2r0oVMBjzRxKuoTtZPVnPLt7BEm3L77fhdSi76TdScBjS/nqpmQai/aHEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bb2XX+K8XlPrskQ3LjuUMVJxBwTNrFhavyXBFcu8lVc=;
 b=Xz/p9eOw2uML5dU7oecWYnTFGD0kNy07JUg2NaRJwd91O/l2zsHELJ2XeI75BDTt9+2Kdnqib3t+bX2fSE2JTSMaCwTe2zKO2EtKMofrvOqN2w74dA8xG7WKHmxS+NHNvziziaB14I/+EkFSDcoKlWACyENw+CUTwzpDaPC63tKK2/XJj7VURyzr3PK3ryySuKUDFSG0dgAgMDA0V29gnA/aB9xXEyOFl0OcPsH8R3+0iUOomQ5/4zzL8kFCSZMB8V0XOtuT/0KyjxACrzc5dw818UAhTkef2tP1gIdO0Bhn8hAwUC9SSaVyxhcOBdJncjZq9ZejLUjCWV4HtS4F0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bb2XX+K8XlPrskQ3LjuUMVJxBwTNrFhavyXBFcu8lVc=;
 b=hG8JQ6O3UyldndPwT92F/99PLhEyNTycIMqoHGhygZol3Y5zgYx0qo+6MRyA2SO9uH0g8P57IKzK1ref9o/vdSKDIEJY53e5qaSrbtv1sZyq3OwdADTx9zk+7mqRC5Mr3/eRecRQ3JTywO4uD51+325BNkeyEc6GElIFcmikT4DTgDEsr6EV3AEr3TZnZReU7G3fecu3hH/+0X72osp8XZtoFhezLhqgh6TD7I5J82F9RDFTjw1Ris3AG166ALiDIWFjZTHridy5rTis+/OE9Ex8Itslf1rcQETaS0oIoyPtdRC3Y7SBJGrb+t97XhylMiLVyT29D2Om8LhNViRqJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB8406.namprd12.prod.outlook.com (2603:10b6:208:3da::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 14:48:12 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0315.008; Wed, 12 Aug 2026
 14:48:11 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 23:48:07 +0900
Message-Id: <DKN1QEH1HWD1.1ZV0LWLNCZJTH@nvidia.com>
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
Subject: Re: [PATCH v2 12/16] gpu: nova-core: use projection for PFALCON and
 PFALCON2 registers
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-12-c3ca142220a0@garyguo.net>
In-Reply-To: <20260805-typed_register-v2-12-c3ca142220a0@garyguo.net>
X-ClientProxiedBy: TY4P286CA0128.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37f::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB8406:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fd8f1a7-5bc2-4336-69d0-08def880bb1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|10070799003|5023799004|4143699003|11063799006|3023799007|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kTOa0aWKHj0COw/Dd/j1mtD5kNDtI1rn1PI5AU9eQNh2EaubmBz7FBwnEv3mMNmOFN/6J0z2gkAA3aSyGa+lzfskzJWbdinOYLqP01lcUvfEH5k4ckvhXLkRaLJG+ErOFmskB+ZYMZLToH5FKuSV8h9vASGMiIqRZ7Pb2k7rTbsvbEevQwTCH21o0zJeNexIEqHLsltijxY2sp5gMemFT4eEGsZgfxq/oWpYbGycLDtvnsMhsAZwcbXtyUDXsrv/nEA6BIolitlGaibTMWKiXI7e4j3gW9NMt1sqKIZD20lK9EnRVuo2oE9E88EyLd7YdVFuQzbAC6QSbadkvHIk2ncPE63gFLjoUaI0bXiAVd3uvRq28p6ZlryVKIRV+wRiFMNLSUcXmLKtaEQhYUHwSqCyen6DvIANarTLCwHdo7NMYqUogHfK4Zn10iEVXEef1z+QMN2ERfE50JfcEVCQrx52qCMyltUrJ7QE7nn7sGOX/raSMJF6YtAEZg0FzLVPQz+5f9Y4G+ENS3kWSLsXjLRq43kJhZ0wF23X8Jxx5QP1RPMXott3Q9mqIqYwhldPo3Q6doqfydDtksuD16Uv0RaT5iRN1gJSsP4RY+FkjFV1wrpuWhg4CtIjkCzMEerU9fjIfjjNU6muvoS/F0MNOFSsIV6FUrRinRd3z3GVrVM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(10070799003)(5023799004)(4143699003)(11063799006)(3023799007)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0lkUmMvZWd4aG1RaXIzb1JraXFPYllSSWowa045eml6U1FiUXM3Zy9oVDc0?=
 =?utf-8?B?aFNoNlBXNjQrOWhrcVBCaUY1UkMxNXIyNWlFRWtoZFpKYU1rclZsWVpOVll0?=
 =?utf-8?B?SndjSVRyOFJDVXI5d2M4UnVNU0hjUEd1ZGdWblFwYUE2OXcyOEhyQ3lNR3FS?=
 =?utf-8?B?T05pUUZRZE1VNkRGZmlERFhBa0lRS1lWNVNuemhvY011WVVGYk02NmxrSW5a?=
 =?utf-8?B?dWttZCtUYkR4UTZoM2xMYmkwelJqRE5McmY3KzVZVXBlYmNNL0U0ajRua3g5?=
 =?utf-8?B?S3RNY0NmK25ob2p6UzJpK2FEVlU4bXpJLzBjVXlNRkF6eHN3WFVtTnQwYkha?=
 =?utf-8?B?WElPOTNyNjRwM0RGdGhpRWcwa2NaYUJuVG1pVkRQSXBFa3luSWxxRllZQ0gy?=
 =?utf-8?B?REZ3TmdoV2FrNGZLR296bDd6QkVTOGk1TTh5eWhjTGxlRWdpdU5pT203NmFV?=
 =?utf-8?B?azlrcnZhRjFGY2xId0lINThkRFFBRy9UcU54T1g4UHp1TnlNSEhoRGZmU0Zr?=
 =?utf-8?B?aWJNY05nd254OVZPL0NoVUNCYmdjc3ROSk5BV1lLYnVtR093NWFERVpDUmto?=
 =?utf-8?B?MDRTVUdJNzN2Qm5MMmRuWWF0TkxhV3ArTXdwQjlWaXJQME1HSFY3TU53OE1I?=
 =?utf-8?B?RGNRWEs0aUkxQmFpTDdwVG13ajIvUVNCOVdVb3RGZ05IcWV0M3RJb1EwZXR0?=
 =?utf-8?B?RWFScEhTTHFLMVJDL3JoOVlHcHFjUWJzeHlqc0xkMlhRaUZKamo1OXIwU2Mx?=
 =?utf-8?B?SW5zTWp4dFRERm9SRTkvbWkwZnFYM2hObElEeSs4Vm9QWlVIV0JjR1c2K1U3?=
 =?utf-8?B?a0x4YjFQNHJuR0IrbmRobC96UjNya1ZZVktwYzZFNlRkaUwvYVFlazRVNUpL?=
 =?utf-8?B?Zk51UXNwbm83T0NYZHVXbkM1SFc0bFR3eFB3aVlDTU5mcUI5S2wrL21UUmJ1?=
 =?utf-8?B?b20vWDAvb2lKZCtta25IcVdIdXJzOGVGc1FxV0hkZjR2ZjB3cHZPdWlQSEw0?=
 =?utf-8?B?K0hDQngzaTlveFBWMW9FTmZ2R3o5NzRHdGQ2d2g2bW9ieDdzMTNqUCtQQWdS?=
 =?utf-8?B?c3dDUkR4VlFwMmo4SytQdGRGSWNwaWxTNXpiYUhZQ1k3YjZ6M21ZRmtjSU0z?=
 =?utf-8?B?NUt6MERrQ1Y4VDREb2ZRWlo3OG1CeU9yd1FYbFgrOW5tVmxxQ3FEWXRzSjdh?=
 =?utf-8?B?WFdPeE9wM3V6M280NkJDOWcyT0NlaWJVdmI4Lzd5ZjBBbW5hUEdpZkNMbXAv?=
 =?utf-8?B?M0lKZWllZ2tvb1ZnOVJsY09RVkFSZW1ZZ0sxRkFnWGJobTUvakR4VkhSRHlp?=
 =?utf-8?B?d0dWMmZ4V2hWb0xjZWJZN3NNN01JZ3ZEclY4clNYU0w0b3hzTk04WlpuWklm?=
 =?utf-8?B?WXpEaG9oOXBIT1hoNUtFU0NvS3Q5QTUzUzNNMG9kWUVYd05MWkNld1RYSlJK?=
 =?utf-8?B?K3pFQnVnM2dHTzYxV0dBRGJNY3Zka3JwNjJtT0ZNTnZHNDdSODNYUStnTG1v?=
 =?utf-8?B?LzFudjlmS0lOUEYwN09DSG5jNFVXdUJPaS94Q0tvU3RmcGtkOWg5MFQzTVlG?=
 =?utf-8?B?ZVl5RCtuNnE5L1gvK1diUDg1M3c2MTc2SlVlcTNocGZ2bEk2L0dhcDVnbUd3?=
 =?utf-8?B?L0M2Zmg3dkZvbHh2V2tGWDlTVkRSVldnV0JiTDhBb0QwYVRWK1UyYk1nWGtz?=
 =?utf-8?B?RHphYTFIcmVWbkg0bTF2cmhZaW56bHUzbkJUengvKzQ2YmtZcU5jdms5eGdM?=
 =?utf-8?B?cXRaVWNKQ3RxMmdjc1ZobXI0Wk5nUldVVnZtTG1RN3JBK1hmVzl0S0F0VmN5?=
 =?utf-8?B?c0tROHlYOXpMb0pVUm42ODc5ZXhjY0MwRU9TVkNHMVR3bXJjQ01pcFlUb3J0?=
 =?utf-8?B?S1o0blMzUVlpZndHVWhVQUJuaVFENkxHYjlnNnR6NXhyZUcrTmZGaS96K3JF?=
 =?utf-8?B?QitnMnRLT3FkNE9wTlFCb2JUdmhpVTVKS3Bna1NhdzZrNU8yVkR5WGRLa2Vj?=
 =?utf-8?B?Sk5XZHRwK3VCOWNPMnZGR290dUdVV0pxYVZBVXA1cnFvWjdtekk0Unc2Yitv?=
 =?utf-8?B?cXNzblZRb2Y0UzBLelFRbDNYTTd0c0pxUDJHengyMC94VW15QXdEM3F0ZXIy?=
 =?utf-8?B?bUxDblpCZ3gzZlYwc2R5VkZsSUN6bHlWQUxEZ2tCWDIrMWRSMVl2aUptMVBv?=
 =?utf-8?B?bmxuNlhDeVZ0aEcvNlBEVFdXMDVGeFR4c1BWUi9pcE5DME5oM1crVnk5bFg0?=
 =?utf-8?B?STRvbnR6S3gxWm9VQklBUTJ5OGd5S2JkTUp4MllrdWhQSW9NSm1TL3NrdXRK?=
 =?utf-8?B?WU9RalNCU0VxUnhBMVQvb1NnSDNNbjM2THF6SytJWnJtZHFOOXpXL1k3eGtO?=
 =?utf-8?Q?MrER9tzT8bwwSiZURqH4bi6z/X53QTDK+sImtuMvl8NNs?=
X-MS-Exchange-AntiSpam-MessageData-1: FohuTWlJcyeJLQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd8f1a7-5bc2-4336-69d0-08def880bb1e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 14:48:11.5981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUaUb7RHLSkMwanM9ENamJ18ecMBULmKtKOEYpBghr37D8krXOq10dnokGESGSUVTSP36fN+Zltz1K4CeBqAPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8406

On Thu Aug 6, 2026 at 1:35 AM JST, Gary Guo wrote:
> Add fixed size region types `PFalconRegisters` and `PFalcon2Registers` an=
d
> update PFALCON and PFALCON registers to be fixed register on them and not

nit: second `PFALCON` should be `PFALCON2`.

> relative registers on `NovaRegisters`.
>
> Update `Falcon` struct to store projected views when constructing and
> access with `self.pfalcon` and `self.pfalcon2`.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  drivers/gpu/nova-core/falcon.rs                    | 157 +++++++++------=
------
>  drivers/gpu/nova-core/falcon/fsp.rs                |  63 +++++----
>  drivers/gpu/nova-core/falcon/gsp.rs                |  51 ++++---
>  drivers/gpu/nova-core/falcon/hal/ga102.rs          |  62 ++++----
>  drivers/gpu/nova-core/falcon/hal/tu102.rs          |   9 +-
>  drivers/gpu/nova-core/falcon/sec2.rs               |  37 +++--
>  drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  18 +--
>  drivers/gpu/nova-core/gsp/hal/tu102.rs             |   7 +-
>  drivers/gpu/nova-core/regs.rs                      |  91 ++++++------
>  9 files changed, 238 insertions(+), 257 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falc=
on.rs
> index a91cbdd5d636..ed52572690ff 100644
> --- a/drivers/gpu/nova-core/falcon.rs
> +++ b/drivers/gpu/nova-core/falcon.rs
> @@ -14,13 +14,12 @@
>      },
>      io::{
>          poll::read_poll_timeout,
> -        register::{
> -            RegisterBase,
> -            WithBase, //
> -        },
> +        register::Array,
>          Io,
> +        Mmio, //
>      },
>      prelude::*,
> +    sizes::SZ_4K,
>      time::Delta,
>  };
> =20
> @@ -165,18 +164,22 @@ pub(crate) enum FalconFbifMemType with From<Bounded=
<u32, 1>> {
>      }
>  }
> =20
> -/// Type used to represent the `PFALCON` registers address base for a gi=
ven falcon engine.
> -pub(crate) struct PFalconBase(());
> +/// Type used to represent the `PFALCON` registers.
> +#[repr(align(4))]
> +#[derive(FromBytes, IntoBytes)]
> +pub(crate) struct PFalconRegisters([u8; SZ_4K]);
> =20
> -/// Type used to represent the `PFALCON2` registers address base for a g=
iven falcon engine.
> -pub(crate) struct PFalcon2Base(());
> +/// Type used to represent the `PFALCON2` registers.
> +#[repr(align(4))]
> +#[derive(FromBytes, IntoBytes)]
> +pub(crate) struct PFalcon2Registers([u8; SZ_4K]);
> =20
>  /// Trait defining the parameters of a given Falcon engine.
>  ///
>  /// Each engine provides one base for `PFALCON` and `PFALCON2` registers=
.
> -pub(crate) trait FalconEngine:
> -    Send + Sync + RegisterBase<PFalconBase> + RegisterBase<PFalcon2Base>=
 + Sized
> -{
> +pub(crate) trait FalconEngine: Send + Sync + Sized {
> +    fn pfalcon(io: Bar0<'_>) -> Mmio<'_, PFalconRegisters>;
> +    fn pfalcon2(io: Bar0<'_>) -> Mmio<'_, PFalcon2Registers>;

Remember on v1 when we contemplated using associated consts? Turns out
we can with this version:

    // Need a better name, but you get the idea.
    pub(crate) type PFalconRegs =3D OffsetLoc<NovaRegisters, PFalconRegiste=
rs>;
    pub(crate) type PFalcon2Regs =3D OffsetLoc<NovaRegisters, PFalcon2Regis=
ters>;

    pub(crate) trait FalconEngine: Send + Sync + Sized {
        const PFALCON: PFalconRegs;
        const PFALCON2: PFalcon2Regs;
    }

... and make `Falcon::new` call `io_project` directly, and it works! At
the cost of importing `OffsetLoc` in `falcon.rs`, but that removes ~30
LoCs in total, and I'm not sure `OffsetLoc` should be hidden anyway.

>  }
> =20
>  /// Represents a portion of the firmware to be loaded into a particular =
memory (e.g. IMEM or DMEM)
> @@ -358,6 +361,8 @@ pub(crate) struct Falcon<'a, E: FalconEngine> {
>      hal: KBox<dyn FalconHal<E>>,
>      dev: &'a device::Device<device::Bound>,
>      bar: Bar0<'a>,
> +    pub(crate) pfalcon: Mmio<'a, PFalconRegisters>,
> +    pfalcon2: Mmio<'a, PFalcon2Registers>,
>  }
> =20
>  impl<'a, E: FalconEngine + 'static> Falcon<'a, E> {
> @@ -371,19 +376,19 @@ pub(crate) fn new(
>              hal: hal::falcon_hal(chipset)?,
>              dev,
>              bar,
> +            pfalcon: E::pfalcon(bar),
> +            pfalcon2: E::pfalcon2(bar),
>          })
>      }
> =20
>      /// Resets DMA-related registers.
>      pub(crate) fn dma_reset(&self) {
> -        self.bar.update(regs::NV_PFALCON_FBIF_CTL::of::<E>(), |v| {
> +        self.pfalcon.update(regs::NV_PFALCON_FBIF_CTL, |v| {
>              v.with_allow_phys_no_ctx(true)
>          });
> =20
> -        self.bar.write(
> -            WithBase::of::<E>(),
> -            regs::NV_PFALCON_FALCON_DMACTL::zeroed(),
> -        );
> +        self.pfalcon
> +            .write_reg(regs::NV_PFALCON_FALCON_DMACTL::zeroed());

Remembering the debates we had over how to address relative registers
when we ported registers to the new I/O scheme, I guess this new syntax
which should make everyone happy! :)

<...>
> diff --git a/drivers/gpu/nova-core/falcon/gsp.rs b/drivers/gpu/nova-core/=
falcon/gsp.rs
> index ae32f401aeb0..cbea6d7b49d3 100644
> --- a/drivers/gpu/nova-core/falcon/gsp.rs
> +++ b/drivers/gpu/nova-core/falcon/gsp.rs
> @@ -2,23 +2,24 @@
> =20
>  use kernel::{
>      io::{
> +        io_project,
>          poll::read_poll_timeout,
> -        register::{
> -            RegisterBase,
> -            WithBase, //
> -        },
> +        register,
>          Io,
> +        Mmio, //
>      },
>      prelude::*,
>      time::Delta, //
>  };
> =20
>  use crate::{
> +    driver::{
> +        Bar0,
> +        NovaRegisters, //
> +    },
>      falcon::{
>          Falcon,
> -        FalconEngine,
> -        PFalcon2Base,
> -        PFalconBase, //
> +        FalconEngine, //
>      },
>      regs,
>  };
> @@ -26,24 +27,31 @@
>  /// Type specifying the `Gsp` falcon engine. Cannot be instantiated.
>  pub(crate) struct Gsp(());
> =20
> -impl RegisterBase<PFalconBase> for Gsp {
> -    const BASE: usize =3D 0x00110000;
> -}
> +register! {
> +    base: NovaRegisters;
> =20
> -impl RegisterBase<PFalcon2Base> for Gsp {
> -    const BASE: usize =3D 0x00111000;
> +    PFALCON: super::PFalconRegisters @ 0x00110000;
> +    PFALCON2: super::PFalcon2Registers @ 0x00111000;
>  }
> =20
> -impl FalconEngine for Gsp {}
> +impl FalconEngine for Gsp {
> +    #[inline]
> +    fn pfalcon<'a>(io: Bar0<'a>) -> Mmio<'a, super::PFalconRegisters> {
> +        io_project!(io, build: PFALCON)
> +    }
> +
> +    #[inline]
> +    fn pfalcon2<'a>(io: Bar0<'a>) -> Mmio<'a, super::PFalcon2Registers> =
{

The lifetime `'a` is elided in `fsp.rs` and `sec2.rs`, so we can also do
it here. But the point is moot if we switch to associated consts anyway.

> +        io_project!(io, build: PFALCON2)
> +    }
> +}
> =20
>  impl<'a> Falcon<'a, Gsp> {
>      /// Clears the SWGEN0 bit in the Falcon's IRQ status clear register =
to
>      /// allow GSP to signal CPU for processing new messages in message q=
ueue.
>      pub(crate) fn clear_swgen0_intr(&self) {
> -        self.bar.write(
> -            WithBase::of::<Gsp>(),
> -            regs::NV_PFALCON_FALCON_IRQSCLR::zeroed().with_swgen0(true),
> -        );
> +        self.pfalcon
> +            .write_reg(regs::NV_PFALCON_FALCON_IRQSCLR::zeroed().with_sw=
gen0(true));
>      }
> =20
>      /// Checks if GSP reload/resume has completed during the boot proces=
s.
> @@ -59,8 +67,8 @@ pub(crate) fn check_reload_completed(&self, timeout: De=
lta) -> Result<bool> {
> =20
>      /// Returns whether the RISC-V branch privilege lockdown bit is set.
>      pub(crate) fn riscv_branch_privilege_lockdown(&self) -> bool {
> -        self.bar
> -            .read(regs::NV_PFALCON_FALCON_HWCFG2::of::<Gsp>())
> +        self.pfalcon
> +            .read(regs::NV_PFALCON_FALCON_HWCFG2)
>              .riscv_br_priv_lockdown()
>      }
> =20
> @@ -71,10 +79,7 @@ pub(crate) fn priv_target_mask_released(&self) -> bool=
 {
>          const LOCKED_PATTERN: u32 =3D 0xbadf_4100;
>          const LOCKED_MASK: u32 =3D 0xffff_ff00;
> =20
> -        let hwcfg2 =3D self
> -            .bar
> -            .read(regs::NV_PFALCON_FALCON_HWCFG2::of::<Gsp>())
> -            .into_raw();
> +        let hwcfg2 =3D self.pfalcon.read(regs::NV_PFALCON_FALCON_HWCFG2)=
.into_raw();
> =20
>          hwcfg2 !=3D 0 && (hwcfg2 & LOCKED_MASK) !=3D LOCKED_PATTERN
>      }
> diff --git a/drivers/gpu/nova-core/falcon/hal/ga102.rs b/drivers/gpu/nova=
-core/falcon/hal/ga102.rs
> index 7600ee07ca2e..ebfaff3d960f 100644
> --- a/drivers/gpu/nova-core/falcon/hal/ga102.rs
> +++ b/drivers/gpu/nova-core/falcon/hal/ga102.rs
> @@ -6,11 +6,9 @@
>      device,
>      io::{
>          poll::read_poll_timeout,
> -        register::{
> -            Array,
> -            WithBase, //
> -        },
> -        Io, //
> +        register::Array,
> +        Io,
> +        Mmio, //
>      },
>      prelude::*,
>      time::Delta, //
> @@ -24,6 +22,7 @@
>          FalconBromParams,
>          FalconEngine,
>          FalconModSelAlgo,
> +        PFalcon2Registers,
>          PeregrineCoreSelect, //
>      },
>      regs,
> @@ -31,17 +30,16 @@
> =20
>  use super::FalconHal;
> =20
> -fn select_core_ga102<E: FalconEngine>(bar: Bar0<'_>) -> Result {
> -    let bcr_ctrl =3D bar.read(regs::NV_PRISCV_RISCV_BCR_CTRL::of::<E>())=
;
> +fn select_core_ga102<E: FalconEngine>(pfalcon2: Mmio<'_, PFalcon2Registe=
rs>) -> Result {

The generic parameter `E` is now unused and can be removed.

> +    let bcr_ctrl =3D pfalcon2.read(regs::NV_PRISCV_RISCV_BCR_CTRL);
>      if bcr_ctrl.core_select() !=3D PeregrineCoreSelect::Falcon {
> -        bar.write(
> -            WithBase::of::<E>(),
> +        pfalcon2.write_reg(
>              regs::NV_PRISCV_RISCV_BCR_CTRL::zeroed().with_core_select(Pe=
regrineCoreSelect::Falcon),
>          );
> =20
>          // TIMEOUT: falcon core should take less than 10ms to report bei=
ng enabled.
>          read_poll_timeout(
> -            || Ok(bar.read(regs::NV_PRISCV_RISCV_BCR_CTRL::of::<E>())),
> +            || Ok(pfalcon2.read(regs::NV_PRISCV_RISCV_BCR_CTRL)),
>              |r| r.valid(),
>              Delta::ZERO,
>              Delta::from_millis(10),
> @@ -86,24 +84,23 @@ fn signature_reg_fuse_version_ga102(
>      Ok(u16::BITS - reg_fuse_version.leading_zeros())
>  }
> =20
> -fn program_brom_ga102<E: FalconEngine>(bar: Bar0<'_>, params: &FalconBro=
mParams) {
> -    bar.write(
> -        WithBase::of::<E>().at(0),
> +fn program_brom_ga102<E: FalconEngine>(

Same here.

<...>
> @@ -359,7 +356,7 @@ pub(crate) fn usable_fb_size(self) -> u64 {
>          25:25   aincr =3D> bool;
>      }
> =20
> -    pub(crate) NV_PFALCON_FALCON_EMEMD(u32) @ PFalconBase + 0x00000ac4 {
> +    pub(crate) NV_PFALCON_FALCON_EMEMD(u32) @ 0x00000ac4 {
>          31:0    data =3D> u32;
>      }
>  }
> @@ -385,13 +382,13 @@ pub(crate) fn with_falcon_mem(self, mem: FalconMem)=
 -> Self {
> =20
>  impl NV_PFALCON_FALCON_ENGINE {
>      /// Resets the falcon
> -    pub(crate) fn reset_engine<E: FalconEngine>(bar: Bar0<'_>) {
> -        bar.update(Self::of::<E>(), |r| r.with_reset(true));
> +    pub(crate) fn reset_engine<E: FalconEngine>(pfalcon: Mmio<'_, PFalco=
nRegisters>) {

Here as well `E` can be dropped.
