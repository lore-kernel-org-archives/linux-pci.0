Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012023.outbound.protection.outlook.com [40.107.200.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280E0250BF2;
	Fri, 28 Aug 2026 01:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787880563; cv=fail; b=HZ4JJ2nJX7Rm3gaq3NLvEGyjdvDBDJcPMefB8LS0W9owVWvbFJjT2VJXDpL6EjWPoy6WvkyycaJzB0oCYlfWlDUtQ3KW+VZTlEZfEoqm1JO0xvFaQr2sxMNFdXciaF1FqekDoNzqRtyswCJX/heYevzfRwWghaiKGhqFewMxT4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787880563; c=relaxed/simple;
	bh=X8BDowKVWes2qq6mrOoOmIAfFdFmAdwe1VW6YPFhP6o=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=tr2sQtq9KPgda9qpcdXlNLZE2sARWqUreZSw+erLmyzdCnx+Uu/+jNz7RrZGwyjcNQZnEx5gWuZRNOaLI+rcUZSBWRw0wnsC7RE0mT5N1mso6+ja4EpXQKnpIgc/HYrB2bwKoNjT3b8lB6+A6p+srxmwoVWIKJk930bH73UDN8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j7T6icVg; arc=fail smtp.client-ip=40.107.200.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j7T6icVg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=loBY03XHFy7ckVo/pdOgsaZoI0bCPBJuTqRRa5xNwTGFOIAFSA51iKDGXLXzrrRkOgCEEfci9vF+dMJuVmfTUhlYfzRVXPZNLxEc2W4joYOME1bdBTPV8YEaCc5SNierKQ+KbmtYr+kwnhPsoStrMszc2H2RK1yJGAdovScYaYtoDwo/GXauFFXtgEHlGCheA59byXDf1h+rqWL33gy9V3XYbAyljZ0vrc3g0vEivama2aBUde2rwUGb6WcamUkKBlRqnb6ZcsUWSjK8GiOAZOjvZ8vQfdRtwFJUvliYMCFktzBdcXnAwA91OXqXGqoDt3QV3hkMeEdQbpMinpNRNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/0FiOtSxFTdCI6pyk75aw3hIG1jzaAl5LHaCPnsEUA=;
 b=QfdNWvRtkHKi4LvA9WD9uiRHIHvc+MZtv0rAcGOL7UDa+qwShVGS+X0ZYDbTgLZjJwttzz7OLcz+TGr9vzzwhZZbGzFUCUlUVI88PyjOqoAMMN4TwyHRUKMukjthyhsA2NyZxwNLwCOu0+GR+aQDAlW6jS8G/8ePQkbGp8C2fFn1Rg7PfmgsJwIQHZEMbHQgbBTlauUx+VK1EgxF37M1MFQcKvVY6OithR3rVuX+mY9oYOu5YjbduwmAzmRAMTB44WL6WynoI2sn5wKafIKMd7G9+wxII5gYHxaKPsmNidGC5lCJe6JKdncicYP0NEMKR4F0XAeh8n5/8PUwMP8DUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/0FiOtSxFTdCI6pyk75aw3hIG1jzaAl5LHaCPnsEUA=;
 b=j7T6icVgcn1sCQewaRFyEEuRRhTkA6/ipean0YfNzLCmeLlay//2plYLPmE31UzEkL0AUor11NcICA0tk4IDy0204hJj/Docern8RTWu+IAXWIV6qOyOJEIa10RIwV/xDjNv3m3ujRYYLpOTDh9YseIe8rO7E0EJ8pKIHp9KWh0l5Onins/A8xgPb10xl8qlJQc2wDviUGBmugr4Ym3wIBdIMd+pIqvyz3npYT8ulrzHTDrZBEEQesjz3Jl7+67RvGxm7RQQESLhNimOAPWZS3R/KKLbrzAdJ+m452BOvL66RbyKeWn6kF0CjnZkAfN1Au1Y8rmBNcTHXds/XpSzpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH0PR12MB8776.namprd12.prod.outlook.com (2603:10b6:510:26f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 01:29:18 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Fri, 28 Aug 2026
 01:29:16 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 10:29:14 +0900
Message-Id: <DL06RFRR69V2.SGOX9YATC0EX@nvidia.com>
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
Subject: Re: [PATCH v3 13/16] gpu: nova-core: convert hshub0 from relative
 register to projection
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-13-3699a75fadf1@garyguo.net>
In-Reply-To: <20260819-typed_register-v3-13-3699a75fadf1@garyguo.net>
X-ClientProxiedBy: TY4PR01CA0090.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::8) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH0PR12MB8776:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a9113d2-b66a-4338-02b5-08df04a3c65b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|23010399003|7416014|10067099003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	wU4/Vno+0G9+5qFkceUCq9WLxcUONf+B+QOyH62S8D1MBaOxe8nI1RW6e7nAgdeWtHpqT/P7mUcJqgMBlWL06/joKGo2vM2C6zM92uYEXtxictOzz23trd18UHFhUuCf0GRbdibm+HNmkZB8cSVcLwEoTzXslY3H+4zH6JC7lVGWX09rUMk8hLvVwCXRjp2XyCdOvOJudNCQX7K6MxfDFN/mcGhiSJpLjq+l8P2EnSN6mIB8UnvgZ0POKlatOE1oOZY06t+T+8Za1mVP2/H5myP1E3E8+GRvO3ewC9+1btPd1W6wkOaH2/yZu960kUCXBsbLp71yjuXTzCR09A7BskSsbu2pY0eykUlozijs2Es8bkMHK5zcrNrCY4ayOiIqvrLDuR5APW1i8aZ/CWTzArGDWuS/2v68oUorHLrL+UvYBz92Xwd74FL4Ac9YnSn6uGMZKe0fQO43FxdtuOkEJQvZaV1D1lBv6nbtTanlvpmTzMglB154RT8bK0JFTjkW/4zGu0ha5hXHDAxqrAwJ4WPbhmjZe0/FYKM8Z9HgoanmCCbnKfwodXU4ihBUyAWqYqtvVm6SDjiLTgcmB1fkJiWiYsUcrWGm9q5lnkZPt4w8dlIKhCjWA09LyrcshTJFUIUVoc2y2/3YXRgJnLTy4Ec3aPdvQxkDHuU08BD3Bhg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(23010399003)(7416014)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGxXVm9jVGZYQkdGS3Buc3dJTk1GMUFCNjZHaU5pYnY1OXBjdFRORXIwWklJ?=
 =?utf-8?B?RUI1WG1aNCtyaTVHK09vY2IrQUdudEY5SFdVT21Dc2VPdDNRTHVQd0FQQnB1?=
 =?utf-8?B?Y3lGK0dwSzIrTXNqNnJjaFQzS2ZXNmNsUmpOU1B5ckJVSGNTOFVaL21WUjFh?=
 =?utf-8?B?elMrNDlUaVFSUC8vWnpDTVYwWi9mV3lwQXg5ZE1PUVNnSDVBVXZsbWdTWlFR?=
 =?utf-8?B?bkc0QStDTGxIZ20zb1VTQitqZnBYUWd6bk5FSi9VTld5OFRmZnBVY0xrbEkr?=
 =?utf-8?B?V1VhVGJGczl1TUdQZGczeHIxT1dWa0JscUM2UEFxVEE0aG5MbzRXMk9hV2xG?=
 =?utf-8?B?dHNXdmN6RElFOHpVYXFYUGFmKzZJeUEvQWIwQjI2Nko1YXhGUG5LNFVJM3hC?=
 =?utf-8?B?VmROaCtZaERZbUhwQkM1T1kza0QzNWRkQ2krdWF0Yjc0SmxHN21OUHFjeVZW?=
 =?utf-8?B?cHp5Mm5rMGsxNDAyTkJmdXQzbTBrb2VoRlVNZ3NzU0lOSEFreDJjWTRsV1p0?=
 =?utf-8?B?ZWNjMXhYVTdEa2RLK0FJcmw2VGJiL1pDdm9yK0NpTFpJN09YWDZtS0RKOFA0?=
 =?utf-8?B?N2tzMnBsVFlwd3FJcDBFMGRlcnc1dTB1U0JoZnh3NUdWeENxQ29tRnh5VEVx?=
 =?utf-8?B?NHlzcGgzRmM0SFd3clpxOU02enB1RDcrT1AyMkt6VGRJQ3R6NFgyaDBRbW5B?=
 =?utf-8?B?UklrMi9acjlSVUViN3VVZmpzWUdrZHJOemVXdmk2STBuZXIrY2NHMEc2T29M?=
 =?utf-8?B?ZEZRdDZnYnJlSytwNTJnVHBLS2VIdFFzOG8xcjhoMFQxOVNaVnNCSmJPaVBC?=
 =?utf-8?B?b09nbElJbTc1ZFMyalFCSlZyY2hzajRJTkdEYkxzQUtiNDFTdC9qZzNZL3F3?=
 =?utf-8?B?eEJJMWU0bkdhTngzOWkvaUtHN0x3VUM5NkI3WmxLakczYkx4WjZmZVhrTG9o?=
 =?utf-8?B?L1JNL3hEY3FwaXVxN1pNcGRnQ09xTC9CYm0xbjhiTi9NQlJIbWlLODQ1VTFM?=
 =?utf-8?B?K00vUnZuVE1HTjZEbHpFa3dTM2FzZEdyWEhwcUNiaXhFbUdadlcrSXVYbnh0?=
 =?utf-8?B?aEcrM1FubWxvVGZoV3pHQWxwak8ybXNHWHBxekdCMFl4V3V4QzlLWVVwV2dv?=
 =?utf-8?B?R3B2bWhGOE15c3JxTlJPTTg0ejJVZGJiRVFjSjVEYkRiZ3Nmb0V2REx6TFdN?=
 =?utf-8?B?a3FIWU5vbDZDWWc1cWZkYk1VbXNCSi9GeUloODV1YXRvSm9PNklBbEIxcXUv?=
 =?utf-8?B?bzNqNW1KTTdYTnUrME8rdXppZThwRFZxR1dqWEp3aDRSSXJGaG9uWDNjemJM?=
 =?utf-8?B?WFhmbEtuZkJLdTViNEtoUWdoSDZTMjl5bjVhdkdRVzRxU21JVkYzOWJRZ1Zp?=
 =?utf-8?B?aXZNMUxydlNIZ2JjT016VDFmeERSQUF6ZFNiSzNOVHgyWlF0bHBCeGNpS1oy?=
 =?utf-8?B?VUNWMm1DZG53VGRabTRCSmRSNHpScUI5aUpIclBRaDFyd3ZITEkzNGZVdDBK?=
 =?utf-8?B?ZXFGRURHaUFlNEc5UmpFSDZnSERlbUlETzc4SUlXVCtnR0Q3b2ZES3pzR1Yw?=
 =?utf-8?B?U0NBYXNFb3YvTTBxczdseVJDYS85T0VyNTRpTDhtZkxqTUZYZzhoTzNkbTBn?=
 =?utf-8?B?Vy9nK24zM0Q4RW05bVIxbVRBK3N3cjB5VDVhNnFGZmJ6Vk8vZTlFcXNpNGs1?=
 =?utf-8?B?WDFST1FGNkIyUnVSTy9sd2FHQWEyazM4aGlLVEtKbDFtcTdhRTFvZDhiOS9W?=
 =?utf-8?B?QjVRZm0zRnh6T2pVWGowZVBLWHFVNENVKy9NeWZqMmt1QUpTeGMwazNQckxz?=
 =?utf-8?B?YjVjeGtzNU5hTkFiOXl5VU0zUlRVMzVqdys4V1gvZ3BpUXFjcW9wMUdjM3FI?=
 =?utf-8?B?TEZjN2ZuWUk2ODd0U2hKQytqK044S1ZVd1RmZzBURVJmeHFuVDk0dUFzQ3dk?=
 =?utf-8?B?UkFvdGE5QTIwWitGT2drNWNFL3J5Zjd3SDFvNGo5YVp2TnRtbWhtc3YrNzBM?=
 =?utf-8?B?MktrVmtPS0d1RzlpbGhqNHhXeFFFRHRiZDBsY2VzSGxSSG9GUUlieDloNFRZ?=
 =?utf-8?B?WTRhdGpDcGlUNjVuNHVuVWJJUCtLMTY2RnE0eEQ0cm1NS2NVRHU3a2VHckV4?=
 =?utf-8?B?cDA3VkhONkF6aStaYSt1VUVGRDBUN3lENzFMSllxc1BLbC93a0twRHptZ2xn?=
 =?utf-8?B?TVFpRmVNN1pEZzMva3YzOFprTkpFajk3Y25hbTFzSjgrcmRIU1FMTzE0RWpk?=
 =?utf-8?B?NzZPb0g4RVNkVkc1djdhaUVtTnVwMEp3amNDWnk5ckIxRitscmQrK1JNZkYr?=
 =?utf-8?B?SUpDSTFPUXBDSnY2RFJlTSsxcnBHQ3JOUEJLd2xCTDV6cm5LTWdHY056dnZr?=
 =?utf-8?Q?9jnOq0IUPAwFtgA7WS+mt5opns1DujEiJ4qikzjX3UCuE?=
X-MS-Exchange-AntiSpam-MessageData-1: goV1ipQZCa8OHg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9113d2-b66a-4338-02b5-08df04a3c65b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 01:29:16.4746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BkXNsDCYqKgGehuBl3NoOjseQK3gCFO08coyyDs+LgFQMukrxKNWNJi6KkJ/zRFgWeI0cREIElMfNu5O+4ZDkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8776

On Wed Aug 19, 2026 at 8:09 PM JST, Gary Guo wrote:
> Similar to the PFALCON and PFALCON2 conversion, the hshub0 relative acces=
s
> can also be achieved cleanly with projection and a new base.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

<...>
> diff --git a/drivers/gpu/nova-core/fb/regs.rs b/drivers/gpu/nova-core/fb/=
regs.rs
> index c27582e376e2..584488a3e012 100644
> --- a/drivers/gpu/nova-core/fb/regs.rs
> +++ b/drivers/gpu/nova-core/fb/regs.rs
> @@ -2,7 +2,8 @@
> =20
>  use kernel::{
>      io::register,
> -    sizes::SizeConstants, //
> +    prelude::*,
> +    sizes::{SizeConstants, SZ_4K}, //
>  };
> =20
>  use crate::driver::NovaRegisters;
> @@ -65,31 +66,33 @@ pub(super) fn vga_workspace_addr(self) -> Option<u64>=
 {
>      }
>  }
> =20
> -/// Base of the GB10x HSHUB0 register window (`NV_HSHUB0_PRIV_BASE` in O=
pen RM).
> +/// The GB10x HSHUB0 register window (Base defined as `NV_HSHUB0_PRIV_BA=
SE` in Open RM).
>  ///
>  /// The base is provided by the GB10x framebuffer HAL.
> -pub(super) struct Hshub0Base(());
> +#[repr(align(4))]
> +#[derive(FromBytes, IntoBytes)]
> +pub(super) struct Hshub0Registers([u8; SZ_4K]);

A named constant for the size would be nice here as well.
