Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010029.outbound.protection.outlook.com [52.101.61.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBA23F107F;
	Fri, 28 Aug 2026 01:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787879086; cv=fail; b=L77TWyLGkNC1rlkC3n0D46Cg+KhPvue2rdujRYChPNVAlRiOWq25++L2TEuKg0Ae9/N1pfl0Ge0ISgob5hQN/ZcXX0itW0AUFlZGWLsvV0U/7lWku4U1chpwGBVUGIayPO+WvsX6pvQcPDFErCCHC3ZoKBw7NcEYXE2earCdF44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787879086; c=relaxed/simple;
	bh=2qouksppgVw57Ll1AqGe64g+vd25nxC1Sjuv149GhfM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=psi9BUKcHnTMA4L6vAIqSiSPNYH0HpvfldbBmQ14BqAjTkSEeeNQpzzDiR4YIShpqo9jVW8X0s84JdDqORf6iu0POWBiyDpwE+olkVYWaGowbX1mlq65yiEp1CuYAixxgZiwVw7bt8AwN/XIl7WtktRTYknV8FB4+lNkX0CQzsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gRx1EP2L; arc=fail smtp.client-ip=52.101.61.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gRx1EP2L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHfOdFHFeI9yz1U6NSTpovM21tv/+9onaEVwrlVC0k+1+habbknXmqAWm++zdul2uQoqFUVT7Ho+PvJUFtBnGiYeniqtmzj0wQtuoGHknXKNZXx8SN5R4x8dyyUlgWUxEaq+2s8zBkcDVQjUrl0XmQVIT/+qGMzi7ta1QyP33ZVPTTXeWuoZokr2JZ+T1suMcEvxtcp31PslWN0SRzwJOYfwYv2bMv88PA1RPYXRIlisFDbYSCwXGOddox7cFaDoSkJ8DgZ9wpriozux/uZUntiARVWHSJ+mGDx+miqtVJhCIt3OFJaCTEM+JmMkRZ88EN8rhxy9rUlY3hNCsZIdAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GAj9xCtvxZFmPQc7/wwSUfgwOWEFusbrwuZhy3M6yxw=;
 b=dWSsCkdmHlbnlTPjgJoeUQPJIhzyuD49IjFHwqPZBUh5Sdurmfxmn+V/GclJ6+1h4ZQw0P5O6OgLrbyVc4A+IXGYtBc0Qo9Xrw0fEQAo2CqGh+Vs8PX3Jxu77iflOQrk91ld7Hk7fHlk+dwxwkR1Qlscp1K5JlG3BOlQDP2O/pYqs42fK9n4Yz/WHK4hvEAr1Yv2oX6TupTYW3/9tOjvBmeEHf3VzUW8vjVFTnS7AImKcI2h1fU21qNSL+KzHb7YZ0hXSc6ex+qjjQuDUsLxMfCpWwHWwJl/N+G7064wkCbJyh/r7odd5YiUPq4C8jDfJX5YuuVcPdXZVMHwAsqyEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAj9xCtvxZFmPQc7/wwSUfgwOWEFusbrwuZhy3M6yxw=;
 b=gRx1EP2LN42aBgPqOsu5DjxxL3wr7BCyK/Nza6pwthq+peP74uMla6WzTDsGHDbB3F1s+ipUspboTqFHoxr7cbaXedVOZyfchDGR8cl4BVuAqJ0SmjXmd+lo+SvnuH8Jh23EHGOuUhpbfkJZbAkDQZrfNsVv5N3GyQvAAzgJQWGoqlpQ/lFV1TrEnwYZDYp5dLU6kfiPzRJ9F5Ou9sQWuwaOeqSCraZkPSna63reYjC1DXkRI6oMdmpRRj+jvj9kcNMA2R6Ue19oW/D4MYz7knnC+mk37BfuyrtXetntPLP7/e3qkl5+/8G3JZzvawbki0S//QvQG5NZZDSiZgwRFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH7PR12MB9152.namprd12.prod.outlook.com (2603:10b6:510:2ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 01:04:40 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Fri, 28 Aug 2026
 01:04:40 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 10:04:37 +0900
Message-Id: <DL068LFDXPM1.7A1482C1UJF@nvidia.com>
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
Subject: Re: [PATCH v3 12/16] gpu: nova-core: use projection for PFALCON and
 PFALCON2 registers
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-12-3699a75fadf1@garyguo.net>
In-Reply-To: <20260819-typed_register-v3-12-3699a75fadf1@garyguo.net>
X-ClientProxiedBy: TY4PR01CA0098.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::13) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH7PR12MB9152:EE_
X-MS-Office365-Filtering-Correlation-Id: 80dab005-0c9f-4a9b-c599-08df04a0564c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|23010399003|1800799024|376014|7416014|10067099003|6133799003|3023799007|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	PbZPRDIT0sWu4maYS2Cq10COS0O33M6G7aLIzOqh2mzBNYvMh0vfqIN3a3bkj+QtVC+qMohVSG33qdyuPZgvhud6znkZlcK//+nnbX3HigcrpzHmqeeGYM1/A862VeA9MRhSyjuvQaDtgVu3esFSGl6sYzFTFnt0PgZ26vV0BPE6SdaDhlO4L2EIw25oOsttUharqo/8gkQSvVtzEQb8HZQwzkhG0iC+cRA1zUcIJt+xq9QlbHOy6XtlcHGHfrSRZ3EbG+K+gQmWJ5yY9RtceIDrsRrWbhM7mxOZQQmUcwPQzdEW85PooQ4djXVgzA7ypIWLq9/fyroIIF7FUeSmU6+xToIXVfZOWY0XduIjk1HkkQsK38LYqM0zTdA2R88GnHd3D4k72m520nSG+uC/HlhLHb5ZmWKEqeyRhpWUfhnYqVBb6APxFw6+qnj9yFeBtc9yQKQX2yM5mUwguZtQ6BHpdw1yubJKLe3DV1+KhKK5NIqZ40kcWlhx6oPqPHmVsNbVexyQUlahW24JS0Io92gJzRqAeMyNadAfVyr+P41TNfv2eJ/WhsgoTJGXbfBC5GmYxYM8XZ2vhjvZN/5101qH3I7G/Epe4KY4pBVVg4wDl1+b6iaYVetAmsQ7L76xVvw0ck/636n3xPj24tdsZLg6Q5F2YlSi0d6RjG1EM0o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(23010399003)(1800799024)(376014)(7416014)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnNVcWk3ckdmclFtTVArWnBxbWJRaGttUFh3dmJqd0hDMWNqaHZnS2RuRTBp?=
 =?utf-8?B?Uld1V3BSc2tmeC9rcWhlMllkRXlleVdsbnNFdTd1MXVXS2ZKdGVxREt0akJx?=
 =?utf-8?B?ZHZRM1lmMUlnUnNkcUowbS93OGFKS2cwWkkyanVLcVd2czlqWDRxYlc5aHNT?=
 =?utf-8?B?cWdTWU1CdkZNUGlRdCtVaVN0YjJaSEpoaXV4eHBWdTFNbTdKNmYxekUyWGFP?=
 =?utf-8?B?S25sR2pWZXhZY0VoRFlaRHN0My9FaWN4SzRHUGlJSUlFdHlLN1hiRDFYVVN5?=
 =?utf-8?B?Q1NJWm96UkhZTzlPMVQyZk4zUnhSemhPUnAwODMyeUtNeENDTWt1MDNBOFBr?=
 =?utf-8?B?d3FDZW1KOVpIVDRIT2JjLzRKb3hNMGV0bVh4RkpUU3UzK1UvdTgvVkVRR2Rk?=
 =?utf-8?B?UUZMaUswNS9paUFZMnREd1puZjc0d2I5alluUEMrMkJIWUtSTUtDcFNSTytX?=
 =?utf-8?B?dDNqRE4xdTg4cjljejYrM0ZoZGR3YmtweU5qcEcwODBzY1FqZHhkS0J2TXIx?=
 =?utf-8?B?ZDBUcW4zNFZXZlZBNHFuNzJtdTBXcGZReUZnQkM5cUp3SittOUwrR3BGOE1r?=
 =?utf-8?B?d2R4OVgvWlRXbWhvRUkxQVVHU3RxbFNzdnNiRW45cVVHZThVNjBoUk51UlVZ?=
 =?utf-8?B?K0x6aXF0MXZrNFo5MWtmK2hPcmRvMC81cjR0WWEwZHQ0OHY4WFluUklQakkx?=
 =?utf-8?B?UHRBQ2JlaHMxQmxxNDVPMnFQYlhNOVFlUW9vdGU3cVJyL0lDYUVWNlp6WXlp?=
 =?utf-8?B?aHcvQkxkYWxDSG5YMU9WK2JrQjRBK0c0VTladUV0all2VmRhTTJScEl5QzVp?=
 =?utf-8?B?RDNqbnkrNFZGamdySUdoTENRaXFyMDh3QVgrdWVPdVFlNVY1NW1MODVXKzlX?=
 =?utf-8?B?emhGM2ZaNDJhbFFwYjQvTElvTElqeDgvWnZtTUJhRHRKak5PNVUzMmdvSk9n?=
 =?utf-8?B?MkNMMGhQc0d2ckNnb1BxUE1pN3hKMlFGa3hxVHFuLy9HY29pcnBvL3cvR3F1?=
 =?utf-8?B?bmpxYWM3N2J2RFJJTDIveFFlNVdUbDBpU0FRS21heEE2Q2NLT2JSQW5LdFZu?=
 =?utf-8?B?T2J6ekJMUzhiblBmclVGYTBpUUVyNTNjL2w0N0ZpTHpyWGJtSjV4TG9NVE5K?=
 =?utf-8?B?a2pjSUpiRlhnOVdKZFJUZEc2TU1Sbm1wTG1nODBDYStwRWhjVFZUUGN6ekYr?=
 =?utf-8?B?WUl5U1hFM2ozazUxaEthTkxPOFVpeUJmMUZqSGRLRUN4U1RsMkpKK0xRVTNu?=
 =?utf-8?B?NWl0R0tSVDZIZXg4SkJ5eWd2cDMwUkZNV0ZGNDkwQWV5dU5ISVNuaHNtZnlK?=
 =?utf-8?B?ZEE3RDFUaXlsV0hXVFYyZnZxOWJFUVF1dXUxSklhdEJRSkIzSy9YZ05kNEFo?=
 =?utf-8?B?TnpLZU5lNk9QUHNTbllVU3psd1dsTXNYbWhlVWpVWDJZcGF1K0pDQThuTFRq?=
 =?utf-8?B?UXRDZEtHeGpNVVdrY1dnM2hKSmlDd3JmVVpwZTFheGVna1NRMy9KaDlFOHV3?=
 =?utf-8?B?cFZGTmljc0lGVG1ZMEVMYnVGNVJVcERWeEtmV25PZTA5dzJsbTJNL3IyWVM2?=
 =?utf-8?B?NWkxNzNBRXdmQUxxSkkvUlJjeEpGbHRYditrbHYxM0NVVGdEN0psMDVrTzZo?=
 =?utf-8?B?VHJvZ0J4czRtVHZWeGJINlNDK3BnSm9hMVF1bENsdnNkSWdpUTVDTHRKY3Bk?=
 =?utf-8?B?V05vMVRTU0N5b3NBamRhcVhjc2FMU0hSakZWTUVjRnVBc1BMM3RSeS8yck1o?=
 =?utf-8?B?Zk1qN2Y1VExCeW9wTUR5NmJxbE1EenYvRS9WcUNxUDFZYjRSUmpHZjg1RzZt?=
 =?utf-8?B?UUhJK3NCUjFnNzBWT3lCK1FHZ2kzYWJDblQ1UHdnYU10Z1pOTUZvUTE2SmNM?=
 =?utf-8?B?ais1K0IwV09HOW1qdDRJazVnVnNhdXJoaGl1a2FaNVBYQ2VrVVpmbjVHOEpN?=
 =?utf-8?B?bFIxY1cwVFF4UG9QZVFma2MrZ1QwdDF3K0V6U0FPWCsvL1QyZElDaThaUm1a?=
 =?utf-8?B?cGg0aEFmWUZzVVc4LzlOcmdmQW1qblh3VFZ5VEFoWXNtWDFBZVNvcEF3ZVBD?=
 =?utf-8?B?Nk1CbCs3c3NPdHRCZHJmOW1sbEtiTURqZjFiMWJ1Nm9WOHVMUzV2Sm12RHAr?=
 =?utf-8?B?N2ZyaXhlT1M0Vi9BOTNOUzVnb2hRbFA4dzk3R3M0Mk56cjFQWCtUd0t6Tzdh?=
 =?utf-8?B?djQ3WTZodG1sSGJOUnJJNUpBVklxRUN1akFPdFVIcWtrUkZmamhRZVEvY1lx?=
 =?utf-8?B?QUJmS2Vka2hNdzhteFkyOHdsT3NsOTg0SklYbGcyRjNzc2xNOVBacDlnOE0r?=
 =?utf-8?B?VXByclFGaUxGQWYwalQvTFVtcjkyNTA1c2YyTmdZMnRZcHlPaysxQ24zbUk2?=
 =?utf-8?Q?qF4vf90j0pTyQqzUBC06V++9uuaVnuz0emXSH00lOn/qB?=
X-MS-Exchange-AntiSpam-MessageData-1: QLMdteKXZIAg/Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80dab005-0c9f-4a9b-c599-08df04a0564c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 01:04:40.1326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qeEJIEmHd1SHguOipYDFWioJmAioScMydvvEpQodiG08D+L61eUN4HG8AZwQgfsWl8US6RTDnG5vhKTaW7M+Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9152

On Wed Aug 19, 2026 at 8:09 PM JST, Gary Guo wrote:
> Add fixed size region types `PFalconRegisters` and `PFalcon2Registers` an=
d
> update PFALCON and PFALCON2 registers to be fixed register on them and no=
t
> relative registers on `NovaRegisters`.
>
> Update `Falcon` struct to store projected views when constructing and
> access with `self.pfalcon` and `self.pfalcon2`.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

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
>  drivers/gpu/nova-core/regs.rs                      |  92 ++++++------
>  9 files changed, 238 insertions(+), 258 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falc=
on.rs
> index 65cb12d26e2b..119d305e2ea3 100644
> --- a/drivers/gpu/nova-core/falcon.rs
> +++ b/drivers/gpu/nova-core/falcon.rs
> @@ -14,13 +14,12 @@
>      io::{
>          io_project,
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
>  }
> =20
>  /// Represents a portion of the firmware to be loaded into a particular =
memory (e.g. IMEM or DMEM)
> @@ -358,6 +361,8 @@ pub(crate) struct Falcon<'a, E: FalconEngine> {
>      hal: KBox<dyn FalconHal<E>>,
>      dev: &'a device::Device<device::Bound>,
>      bar: Bar0<'a>,
> +    pub(crate) pfalcon: Mmio<'a, PFalconRegisters>,

The only spot that accesses this outside of the `falcon` module is
`FwsecFirmwareWithBl`, and only for the GSP falcon.  I guess we need
some sort of `configure_dma_transfer` method to `Falcon<Gsp>` that
`FwsecFirmwareWithBl` will call, so we can keep this private.

Actually I that reminded me that Antonin ran into the same issue with
his series [1], so that's a logical abstraction to have regardless.
Since we're going to do it, can you just add a `// TODO: make private`
item so we don't lose track of it? Then I'll work with Antonin to add
the method and make this private after this patchset is merged.

[1] https://lore.kernel.org/all/20260826-b4-extract-pfsp-registers-to-falco=
n-mod-v1-4-38351df09084@nanonej.com/

<...>
> diff --git a/drivers/gpu/nova-core/falcon/hal/ga102.rs b/drivers/gpu/nova=
-core/falcon/hal/ga102.rs
> index 7600ee07ca2e..7880c145f8f7 100644
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
> +fn select_core_ga102(pfalcon2: Mmio<'_, PFalcon2Registers>) -> Result {
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
> +fn program_brom_ga102(
> +    pfalcon2: Mmio<'_, PFalcon2Registers>,
> +    params: &FalconBromParams,
> +) {

rustfmt triggers here.
