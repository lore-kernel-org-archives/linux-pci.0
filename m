Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012068.outbound.protection.outlook.com [40.107.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7AE35292A;
	Tue, 28 Jul 2026 06:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785221164; cv=fail; b=XFDQpC4EOOQFSpFils+CCvJCa92Qstfk0x1r8CBXulrjVSA7Jp8Je2S6XI38Otz6c8LEArvd6MLopn6nGfNzrJuJxe3zOYrpoQCB86dmhaBapWyQUk1bnoch1IwNHyo6mZMlso1GXwTMrqMFgwHKLyGIz9qM+pWgPAlfjBRNNd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785221164; c=relaxed/simple;
	bh=kJ3TCeYoZiknPIssTX2qgmc7v7r5u++wCyN4AoKUyHA=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Z4n0jo8tpyOXbw1jQ4HCzsn/zzpOOJ9aqkaFnpydJpYdvy967WbuXAukFot/tYV+DQ/7AqSYAIoiAyBbb/6GAvKOOUEsnQ+vuh2Zk//25HY+MUHA4O+PJVZyKcpO21IlaR8faP3YSA1EgNjI82aa9jHfY3glnSfcDbziyc36dQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VLDA1OZ/; arc=fail smtp.client-ip=40.107.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VLDA1OZ/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUTkgIFvFnoLTa4wca+CUAaN/Xy7Y7pgtfU6gRUOrp+vjv9Akz+BfcUoQWKjByCv3va0gWfQ1JZQns3qYjbno+6Xf5TNHWBd/tQrKiQbO7nOdOVE35O2rbkXO3O0NzTWsVyPm244f9+GpBBpLg1B4QtyddyIIZIrmW0o6HZEWpR/qnygmXXwaIQ3bYmM2S/w2qYzsFWdktbsyly1LIji8EpMpYagPJNBqJ71QJ85hnCUsONN74h9IBsrCzd/Hxky17YlVL0sTxjhGkYzFhuAm2Ysm+OjZE0IiC5dcbQsms88e7vtOh7ixHut9Bds07jAscCrJQrSlDx46BzHpai7Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1ieTHOQy7n3qPyOpJMSgsRJL+oGxnaI8CtwZs7TbqE=;
 b=ppCRTwNpjmdd4jz+qYjkxapTm3m8Cc1npjhHDnZb/uSOxF8HhGc5xltkU+KuQ1BjKgBvYMCKemPXKkXwcL/Ix1D+zUAebuyh8nvKS23gkNgU+6VHVYoK43pg4V3B7+KsnoOrrwXJGD7Pi1RSTNXcyaC1qYPoQrDupmosUbrMwit4ov5CuuhKB0x56ruq0bxONLkMu+FhUWTKuUX5eZM0ao3If4C1dYxbwXJYQmFk3L/+6u2EdX5/GUMcyKpvFMLFUQehyzmTDYALx16RqX2akA6f5kqVpSjTzxx1nsLpWU0P8nL8+gSwku8byrLR3uE0dH/XuE43g/R0aPf4dMitLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1ieTHOQy7n3qPyOpJMSgsRJL+oGxnaI8CtwZs7TbqE=;
 b=VLDA1OZ/JJRO4S8ovsifa9YQFzkbQL81b8sX2Bozi8dzsO3vqxkqyyu59o31RZDgJA9gTsZTW3aPWL0W6U4StbjvZHsAU3HRkKpYAVxUo/YTW486RMYca45bSA0MEi262Sg61cFqYC/jj+1Hahd4tIkGsEXCtmJrEZ3y+0Qv3w7CD9RzJ0xHf7Hyw+A4t9+5n/b4Hq7Ml/lexXUx4BscuMDmjUknEVKuez6ZJddW0GQ27ZZPyBU5NEUXuhvSERhB2ZQZkCSnPnKs2H+MBYaqOOFAEeuI99QXc0dM/5W8McC5scSvtVfYyAetXm1YZ/mVxY7tjoBRjtk5L/v0VVozSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB7874.namprd12.prod.outlook.com (2603:10b6:8:141::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 28 Jul
 2026 06:45:54 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 06:45:53 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Jul 2026 15:45:49 +0900
Message-Id: <DKA02Y5RE1YJ.2FGI97Z60X96R@nvidia.com>
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
Subject: Re: [PATCH 08/10] gpu: nova-core: use projection for PFALCON and
 PFALCON2 registers
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-8-452d72b60262@garyguo.net>
In-Reply-To: <20260721-typed_register-v1-8-452d72b60262@garyguo.net>
X-ClientProxiedBy: TY4P301CA0071.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::10) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: 29569ede-6891-4279-a219-08deec73de32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|7416014|1800799024|366016|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	+AKk1rVCemQPkTv7kg0ZZ0nDoDw1YZ85rib0X4f6WrLStEgaKK+DIrIIsgUkBVqPQTtNHq2oRdV+icw88XH959LZb9lGZyvWIhHjrMFKeYr3AEJt3xSvmA8fpzEbRxpifE2cS/eO5qKtndGa3WXo8I1GkS689+acUzeLqAMiUryMcmfHeDuta9dGbizm+WONDhStFDskLXFFeewUt7swYCPV1LtsyABec0hagmC0XxXx7dBq1pVHjFMh5E84MFwreNVs5o9u1ZZwUlILMdjSu4e6Sw4pylKXJKqaYUR7enwaYYJFcrBAoIyDQ6pKv34jEnR1lFTdD4zt/cWuk/57PgFX+I28CYnB+v2+jz2QOPKgjm0t/lFu3eCMMNKVWGa5Y4KxRqTld9JxHOVd3ccKSZTgQoP50ZyEbLGz6+N0VW22/VVnTIwgWH8SnJ3Db+n1zqzk3RJ+mQmNmrmgSoYzRJl6p4OGZrexiSNDFE7hh/c8Q59p7XbMLP4iyEeBFrWGKU4GxnV/k5+QuTMyWkUEdDRn9GPORF+pTR6tQgd/DfVBXgTndvdceeMzM20RRK5EvaVOhYSGkHPB27YLvIGpL+VLLRhcL3AQG7O847/XrRb8tHdBDAElOWDiqF5dd/cj9y2eTRtSlqGtXe4eRG+B6G9PALkQI+tcsYeXiVg6LHs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(7416014)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUx0LzBIQkUxTUlZYnRncFovYUlPejVRYm5NY0ZQTUlnREZJN3hzZm5PbTlv?=
 =?utf-8?B?c0xuaW4yOUZRa2FmQnoxcHNxUWR1QXRwc3hYVTE4OHN4NXVPUjJ4Q1lFUW0w?=
 =?utf-8?B?blYzZUNPcEdwU3V1Yk9YWllJZ3FwOXRVTmQwdGc5NVovbzBkVmJVUDRFWlZ1?=
 =?utf-8?B?NklYeFhZeUYyczJaSEYyRFF6UDd5Q1N4bWZrTFNWZEQrZGtScE04MnJSRE1K?=
 =?utf-8?B?NWJ4SUFiSEx0Y3hoTzVhdUk2Nm9QRVFZU290YUxkVTNwZU0zMklYWEF4bzJ1?=
 =?utf-8?B?Vlkzanp2NkRKbG4zb2w3QUFOZGdzQlBsanRnWWVtMDludEpwYXZkcjg5dXgw?=
 =?utf-8?B?MlZJSXdMQm5Ob2d1MjRibzFmWG5PWHAzL05BejJPeklXU1RqVTR0cXhCU3Rk?=
 =?utf-8?B?eHRXeXppOW9qd3RYSVF3d0JNblBGd3NOdjFrUVVRQkMvYWoydWo4bE11REFu?=
 =?utf-8?B?NWNxSHR1N1BnS1A4dlRnQUJsRDgwZHlVcmg4YnBpVlM3bDJnRDU3VUNSOG90?=
 =?utf-8?B?YVQ1OHJIZHVzTFNFRzJBS1pOT056RWQybVdJY3JtbGFBZHArR3p1cFQwOHY5?=
 =?utf-8?B?YWV5UXB0bzdIYXhWcmhpTHFzUVhyZHRSQ2NLa1k1TTIwdGRpZ2NZeTE5L09q?=
 =?utf-8?B?VW0remQrVmRFNjdGU0RrT0FOeWZEOXFPV0h5UzdWbWZKRjYrU1NOUkllc0hR?=
 =?utf-8?B?S3Z3OWlEc0dvbStkNVRuRm1QNld1Tmo5VmUxVzAxNFJwYTFOTS9FeFI0NHZG?=
 =?utf-8?B?Q3lFU2tDVEFaNnVHeWJZcjBkbWJwTkYxUGtZdGtOeG1JQ1Q2MHdGNG5tNGJn?=
 =?utf-8?B?dnMzdEV4aXo4enhrWjlGcjQrY2Y2SWZ5bzhVQmp2OEJzWHR3SmdDZFZnSVNw?=
 =?utf-8?B?cHJIQ0xxWmVOTFp2anRIdXVOM0w3d3grejVxZzNTenhTdDhMeHpJcVpPckJv?=
 =?utf-8?B?T3VlejRySGdpWmN0Q2pUS1lEY0pvZ2MvNFZCQS9GQ2hOMEM2QnJEdTFVcy9v?=
 =?utf-8?B?c0lndHR1ZlZSam84RHFxUHY3RndPZ3Uxbld4ZmZKK3VrS242RFg3ak0yZy9Z?=
 =?utf-8?B?WGFZTTFnT2lqK0d3QmVkUzZtZjlJWG0rYmlPdDRvSGNWOGpXeGkyMDZFOUda?=
 =?utf-8?B?V2FKSHcvOVZvb2JIU0IxemhVZ0JhZU83VVF4L29VRXg1Nng2ZEdyQWJIUmlT?=
 =?utf-8?B?U3VENVNZbCtLbEkxaUp0NmJvUFFZLzBLY1pRZHZYbUZIN0RIdnpPejhvdERG?=
 =?utf-8?B?T3BGNkhyekFOWmdNTXpJalY3L3hJQk1SbFIxWlJnaDZLRnJXbk8zb1VySU9t?=
 =?utf-8?B?VEF1QUxTWWNJZSt1ajZUNkx6bSt0QjNiL2lZcDg1aFNHRk54T0pXZWw3MkFr?=
 =?utf-8?B?U2FCZ2szN1VGZmxQdGlRdVdWU25NTDFWc0Zpamx4TDFIenNPNk1yVFpsdVBU?=
 =?utf-8?B?NjBRcGZsdTkvc002bXRhR3IwazNBS2t5K2lJVVN3OFM4L3lwRWNUV0pWK2Vt?=
 =?utf-8?B?WDMzTmxoa2dBWlpIU0c4aUZzTnNKemxnZnFXVnppZlJoakc1c1RNdlQ4VSs0?=
 =?utf-8?B?NEd4R1BWeWpZU1ZoZ2tEcW9UQ1REOGxqVGtaQUdNb09paXc4OVR1L2ZiLytM?=
 =?utf-8?B?NWhIZHhWL0VTOUtDU29UZUZSZXZwdVlhRVlCckxWRHEwb1M2Z3RXZjNmVllO?=
 =?utf-8?B?YXo5cGNKQ0R4b1IvY1JvdFVBWWxuVThCZzBENFRDN1VwWGprNktYRlI5ejlz?=
 =?utf-8?B?MVNmUjZCTmxsMmxPakErRVVRV0dsNHBIQjNiT3pOclJwNWxNQmFEdnRYNXRn?=
 =?utf-8?B?MzNDdW9EeS9RVTFuWEZhRVdoSmJ5UW1qYzYyb09qL0EyVUdaUU1pM2g1Nzh5?=
 =?utf-8?B?Wm4wOFFIa3BvRDNqbGFjMkRtbjRuWTBRRUlRSytoemo5RVQvQUYwNFNTc2FF?=
 =?utf-8?B?ajlmL1NGYjNmSUNHYVhXOEhDRytwRnlreWVOQm51dnN1c1V0TzZMSGFhUHdW?=
 =?utf-8?B?WVZzNmErQlZSWUZ3TzA3Q01ZODdQakltQW5XU1RxMk9aNDVITERWZGdZdXJG?=
 =?utf-8?B?eWJUZ1lneVhYRDhwVXpKVHZ6Z0cvMDlqRGVvMEpMaGw2WUxuTmxWdEcvSlJs?=
 =?utf-8?B?cU5UZGprY0xRZDlJVnp4QzVUYnlGNmZDNzlMQnlqbFgyVzBYa2VteGpzZkRK?=
 =?utf-8?B?MnU4MFczeEEzVUFFdnRKSXAreXEyYm1WZ25QK3ZKYlRIbU5jSGRTNUZ1MjhP?=
 =?utf-8?B?SzJma2lZc3luVktrb1VVZWlLRUNjLzRPYW1ad0EvTDFsYnUzL1krU3ZvSUlX?=
 =?utf-8?B?VGdGb3NQRDhmbWpvazI3YThXV3pTSjJyQkpFbll4NXlIb0hUamJpQk5QaWV5?=
 =?utf-8?Q?w72iZ6TjzFmQCYkyptavZAeMWfMvNQl4Iph2ABkq9cw7w?=
X-MS-Exchange-AntiSpam-MessageData-1: DBFHhUDIEziYyw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29569ede-6891-4279-a219-08deec73de32
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 06:45:53.4873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: joxLdJm7q52Z+KymHjr7gZM+PEFkjjqACoKmDjA4pE1WCyRg2XhNSwziBCh/lJidvhYY0rAqPQ9gI6aweFiWcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7874

On Wed Jul 22, 2026 at 1:54 AM JST, Gary Guo wrote:
> Add fixed size region types for these and add projection methods that
> project from `Bar0` into these. Update these registers to be registers on
> `PFalconRegisters` and `PFalcon2Registers` and not relative registers on
> `NovaRegisters`.
>
> The use sites are updated mechanically; calls to the projection methods a=
re
> not extracted in this commit.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  drivers/gpu/nova-core/falcon.rs                    | 158 +++++++++------=
------
>  drivers/gpu/nova-core/falcon/fsp.rs                |  53 +++----
>  drivers/gpu/nova-core/falcon/gsp.rs                |  43 +++---
>  drivers/gpu/nova-core/falcon/hal/ga102.rs          |  39 ++---
>  drivers/gpu/nova-core/falcon/hal/tu102.rs          |   8 +-
>  drivers/gpu/nova-core/falcon/sec2.rs               |  32 +++--
>  drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  11 +-
>  drivers/gpu/nova-core/regs.rs                      |  81 ++++++-----
>  8 files changed, 193 insertions(+), 232 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falc=
on.rs
> index 78948cc8bff3..3cd065019a66 100644
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

nit: `SZ_4K` looks correct for both PFALCON and PFALCON2, but the size
should be defined at a const of its own.

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

We are calling these methods quite a bit throughout the code. I
understand they are supposed to be optimized away, but that's still a
lot of repetition.

Since we now have HRTB and `Falcon` is already referencing the `Bar0`,
how about storing the projected `Mmio` inside the `Falcon` instance?

    pub(crate) struct Falcon<'a, E: FalconEngine> {
        ...
        pfalcon: Mmio<'a, PFalconRegisters>,
        pfalcon2: Mmio<'a, PFalcon2Registers>,
    }

    pub(crate) fn new(...) -> Result<Self> {
        Ok(Self {
            ...
            pfalcon: E::pfalcon(bar),
            pfalcon2: E::pfalcon2(bar),
        })
    }

That way all the

    E::pfalcon(self.bar)...

Can become simply

    self.pfalcon

And I suspect that once this is generalized, `Falcon` won't even need to
store a reference to the `Bar0` (and potentially poke the I/O of other
engines) anymore.

Actually I would like to push that even further and replace the
`pfalcon()` and `pfalcon2()` trait methods by associated constants used
to construct the projected view in `Falcon::new`, since the projections
are all constructed the same way, but doing so requires
`generic_const_exprs`. :/

We could make it work by moving the `OFFSET` generic argument of
`subregion` into a regular argument and enforcing its invariants using
`build_assert!`, but that would require `subregion` to be
`#[inline(always)]`. I don't know if there is another trick we can use,
if not otherwise I guess the trait methods are ok, especially if they
are only called once in the constructor.
