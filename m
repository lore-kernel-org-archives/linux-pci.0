Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020115.outbound.protection.outlook.com [52.101.196.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FECB37B02A;
	Thu, 27 Aug 2026 14:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787840778; cv=fail; b=A79W9bQzFJtqdt+h8vgIKkAjqmxCAuKwmTAKH04bFShVVAhcvWGkw0T4MyJmmnxzuVV4cU85H0Su9x+Zv2F8qGu0VTWb0gp6W7JU7Xhf4iFVmiroNz75qt2D2NhJx+gJBJeOYsX6kkQ39492QORfrg0DBi9W6ClO0Q+GKeKwips=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787840778; c=relaxed/simple;
	bh=kTY9pyw4krqCz5y3+5qCGGqrSajBxbFLUh5lSkQwtYU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=VnvDl345JHaWWhxXsqnzx/j8SHMbBim+5ZoXYKglPMoJTUNIbkkZw7TruxOVs3K+k/sfuDN6JASkiAWuuj6GFkUWt/g3RH06RsRmaSxayYchKHNmzwvMHe1J05Y6h3i90ekzkP9uYSdAl3UGt/1+muYuomivB3GVgy0h4WMd6dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=b8jWn5lE; arc=fail smtp.client-ip=52.101.196.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="b8jWn5lE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xo3c6dMfKIHktS/lSLxunWjyRCGgbERyIZY3NNPW37IcFV2mwSWIDR6yWCGVb3g0OKlZeyEx0ZrYIUMJneMAXhIRtYlRwKIPY/O9ijahfdKeNL022MOdRIcc5vXs8EmEKC2RHvfhz1tOlBFSMNvosQXER6nIzBt79h3XFck9H6czg95Wj9HK4w7Oj30qHHyPlalMSAe3KAYv8GckzKG3Bhu+77vev8Pmevr4dDpQCGTApn9mzcOc9H1iQXUhSOsWKiCPdjUBO/IsQKPSDpvclY1w47ocLY2I/RFTPsplD/92kgPGKo5A63YiBTt7jBkP1PMhYoegf3FDwzp1M2lwPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZP1TzhPGObqCdOReiTmpCrLvbbt7Cwe/1RxY2+oh7dI=;
 b=YhCm/OtejP1HY5SUij62b8oi4YWivUPi87BfiwRmlW0sJY/MxIL04Jw75hRtKoHnzKDeMFurtRTrssCk5aa3eA+WlOkkS0zeVyRVPHog6yrRt2U03Tj5n+ly9LQV3rEOJx4Q+dj07MyLhR5VCI9z+al1y/fGEfqFXBIXYwYOUdoG6FKQwgAxpLGBj2dsqEPhfxd5Sd/USql4smEvf7hVJFRS8l5KEhx5YXOnBikj10A5zasaKPQ8oDLB1LcdjArR9hJ1hFisBHkPOjoIhFjGgib5j2pFrjmlc40HYxdotnt8dlKfWN1JjvTukrRlfoIYkW8NVS4KkR1YjG5n7Z2wHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZP1TzhPGObqCdOReiTmpCrLvbbt7Cwe/1RxY2+oh7dI=;
 b=b8jWn5lEKTdceA/fBxxKpKtOtmFEtbxAsJJH/q2xMQtFNPU2OjCGOtu/izVfNXafOyYVH1kW6jUIWN/LtIjiuQDmeAo+KwyaNm1EgMrhzvrJMS2cQSwyfB6j/dAJngxeWUdqGSOOFVbYSustqHwpuRsjVGo5H705spnlif4/W7Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB2851.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:cc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 14:26:07 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:26:07 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Aug 2026 15:26:06 +0100
Message-Id: <DKZSNPIF9PLE.3Q1U8A7YX69PM@garyguo.net>
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
Subject: Re: [PATCH v3 02/16] rust: mem: add `transmute` with deferred size
 check
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-2-3699a75fadf1@garyguo.net>
 <DKZIEVS56DGW.1JSQZAO4SGPMW@nvidia.com>
In-Reply-To: <DKZIEVS56DGW.1JSQZAO4SGPMW@nvidia.com>
X-ClientProxiedBy: LO4P123CA0259.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::12) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB2851:EE_
X-MS-Office365-Filtering-Correlation-Id: 30c00f67-1344-49ad-b1dd-08df044721ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|23010399003|7416014|366016|6133799003|56012099006|10067099003|5023799004|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JBg2B8vNiopzaBJOc2/2zLqSlPOhOwCRznxuTFR+9H0ki52KM1uQYjPC1kr1+8PK71fkRswaXN+ZiaxpNTw/Ti+314phWP3l2rG4QsYvaqEd8Z4QIjYhgZrdLJEIywtbTWGmEeVWJRfCj0xUjsEAG7vkLiHbHSXLqPCSYz6ZrbynxKEwCRBRvft3i22EggfxvhXqI1HxFvuDV1qbqZv+VXXvYF+GYNqzoUTnH4WplPxJc8b4Mlq9mxxyqdSrIml0NFVBVJ/jdlu8RooQzBifVmkUFzUQAQ+O6/hHXeqf/Gi3H4zfqpoerJN0FfL6rDqfED8Ddpgz5r5TSMHamgAAy7DHSi1L673nKkzb7b5XS/NZxJAfBryNoHxSwwOXiJXnxNJ4ll0LN4cfoQfAb3BSRjCls+xt+MzUtAYTSlnJEc3i/2lLqqiacNNa43OmXK2GP5Y+IiToyLpUmRI5YtE/YNlw6lU66vpPQzZM1bOQpjxiqq0r8Fw3MjeAMs2HGlJqR3ijxSzSzFrSYDGgrTn/m4IhRD6deES51wpRPyDziDgkoBuAoV+IA+xWaNPN5wrA5rp0yyPpxxgF1G/HA2s3WLBdDVbyCLm/AppFH8+mMX/RrxDzJYDweyh93LMYWM+tetyGbFVpm70DegrtGB7p1ciVSOcHSFf0vOClII6BJyk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(23010399003)(7416014)(366016)(6133799003)(56012099006)(10067099003)(5023799004)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHljUXNNNlJBblN0OXBBdEtmdWIyenhaYTlqTkIxdXZTcDcyRWhJMlgxWTd5?=
 =?utf-8?B?N2Z1SWc0MXV5QTF3Z2R0b1kwOFFZYTladXd5OGdEdTl0WXU4QWJFclBjODJY?=
 =?utf-8?B?ejlyRjJjbEJtc21YRlBVMmtTZGNzMWtSekpZK04wazJ4bG5weWx4clVjaTdi?=
 =?utf-8?B?ak80dHYwNC81aTFYVXRLcU1LemdnVDMrOUJabytuaGZpSU4yMmIvdkVQRWQ3?=
 =?utf-8?B?UTNsbVVhNG4yTXJWa3o4eGxLLytqaG9hR0ZmcEdGdkNIWkFLeWt5M1JxMnM4?=
 =?utf-8?B?cFUxRjZHQll0K3p4NXJtV0FLUkJPTEZxQlEyNGVMcEFPOWJrSS9TZXJ6MUVw?=
 =?utf-8?B?ZG1Ed1N0SkljUUhlTm5YakFxUHlXQlNJWGg2YTJIdlJ2NmdCbitIZyt3TURU?=
 =?utf-8?B?T1ZLeVdzZFhpemVnd05mbG1adFFKZzRhejNJYjh2RGhLQnBDdHRKK08xa2dC?=
 =?utf-8?B?UytabHRQQ2l4Y0cxbGJxT3FLR0ZmaVpOSFhKejZIeDJRQVRIQjlNZXdaYTF2?=
 =?utf-8?B?RXBwK2cxSkkwYko3SVRzb0V2ZUhqMW8xeWRKT1Ywb2RXM2xqRnNEMG5yNStJ?=
 =?utf-8?B?emFEOHV6UmhMNU1KQmVjNUJ5NDBrU2tuTzlBNHFkR09LUU5TSE54Y0IvMjlU?=
 =?utf-8?B?aldQamxQSGhWc3pwekgrOXp6bHJCWE5qQm5YdUZZQUE3MWUwTFExZ3ZaK2VL?=
 =?utf-8?B?Yk9seHhRR3NqbGpwNzFJUDh0UkxlUmNNYmtBUGc1TUtzWGtmQUZ6czNqR2Ey?=
 =?utf-8?B?VjN1UHFqdXJKNHRWRmpIeG5jZ05OZHlub0Z2SklxVHAyM0VROWtwSG45eW9G?=
 =?utf-8?B?VFdrRGwxSEJrWm1pVXZneFh2SjI1VXhLMUFyNGxkT1BtbFdMTklDUDZLK08y?=
 =?utf-8?B?NEJnQnFYNGYwRERIQXN5YThjWWxMRmFkQlRZRmo3MmJWYUxkbmFPVE5YSlFj?=
 =?utf-8?B?NHJPMXFFMExUZmM5a24vU21Mb09jWHMvK2gwd0NJT3pUemlwRWZkUXBLUHZU?=
 =?utf-8?B?ZldhVEk0WmZnMHRBK20vRHJRZ2hUWnRCS1BKbmt1ZFFGMGRNYWdnR2FsMDE4?=
 =?utf-8?B?WVVMd0ZHbnhPY0RTWlhuNUJPVStOWmFUWmJjaldRaWxaR1RnYlAwcG5Fc1lI?=
 =?utf-8?B?aEhLU1B3Z2hIRlN1cXRlQWc0Sm9JaEpGOFJZR05PRDl6QTdhcFYwMEdIdklj?=
 =?utf-8?B?WklSSWV1WXFjM2ZzZDA4bnNQVExVMjlPUlQvd0JRaTR1THJoZ3MvdE1Kc09H?=
 =?utf-8?B?dUxROEpDWGhFdGd2TXhGbmtoZjVhb2MvaE8rUkpwTmNjWllteS9oMlpwUW14?=
 =?utf-8?B?VWY4SStHQnRxQUpUMTNzeklacmMxbW9WQjhDMjV6RUE5REM4WUp3M2Jkai9B?=
 =?utf-8?B?Q0R4S2NmUlMwVzVUUEU3YlFEMTVoWXZlU0htUnN3Z2NCQlhFTWN2YldRdis3?=
 =?utf-8?B?TjV0aWRuTlFsMk9pa2doZ0dMUzFDZWZYMWhWUTdYVDNkM2tpWVRWNXQyS3dV?=
 =?utf-8?B?V2FOVTZjcXlGZ09DcXUrUzNiMVFDaWk0bTJYRk1JcWMxVVJ4U2hubTY5d3BN?=
 =?utf-8?B?YXpHcE9aRE52SkVTQU1SN1BMV0VqWFJQVjlOM29oWWdVdEYwYTh4OHpqQ0dl?=
 =?utf-8?B?WEhZNFVIVnVUSnREVi91OVZzbkJYd3BkNXNXUHVIT1lpYWZ5YnhITXJmYlFF?=
 =?utf-8?B?YUd2cytjcGxqaTJrNVA1OTJYMXgxY254SEdRM2Qxc2J3RE9vc2hYNVByMWFz?=
 =?utf-8?B?R09leDRvSklZbkdia2tHODg5V3BXaTkyVGZrL3UrNUlCK0N1ODE2ZUNxT1VV?=
 =?utf-8?B?VTFHbjF3WW1uMkFGSHJYYkJkYmxxMVRrT0xINFNmZkRHbHh5VzlGbWhRQ3Zm?=
 =?utf-8?B?eTVJSmthRDEwbzVYdC84aVg5R2xTaEp5dEVySHFHb0JyZXJCdmVxckdiRmhL?=
 =?utf-8?B?Z1pUaXZtMEZITUxpa1piSHVLWmFlS0s1aUJlQ1VjNnRoZUo2ZzhuZndvN2F1?=
 =?utf-8?B?R2hDOTZMdGFhenNBVGl1UG9keG5NcE1KWEVwdzNXbktWSWZGdUl5MDlGR2pQ?=
 =?utf-8?B?ekpkNjVDQi9wcHJJVkdFS2RCODkzUFRBcFBNbkpxMDdLT1hWWU52YzljN05P?=
 =?utf-8?B?b0hZcjl1Q3cyNW9KVk9xcmRLWjREVjhmUVl5T2NSTGVCWEFCV0NzTUh6eDFP?=
 =?utf-8?B?VkkwRER0aWVRcVVHRU1IY2wwdlYxazZib20rUGhOZm9mNUpScE5zRzVQK1Bi?=
 =?utf-8?B?VVhXUzQyVXJTZGI4bUtqc3JoZW1Pa1JONEtwcUQwOEo3dTNXdTBkMkJVSEsw?=
 =?utf-8?B?WEVHYmpDcXdUdUpTZWJUNlpUL09UUWZvYXB4eEdpUENQQnpCK1hCdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c00f67-1344-49ad-b1dd-08df044721ef
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:26:06.9730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xelVBiubAag8mHWNZ9aeaVTIkxJQnBQg8LkToL8bAPJ/dfZjBgt+tGHY1QvtgHJixSPVjO1htuKzuMA9K1Kv/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2851

On Thu Aug 27, 2026 at 7:24 AM BST, Alexandre Courbot wrote:
> On Wed Aug 19, 2026 at 8:09 PM JST, Gary Guo wrote:
>> Implement a `transmute_unchecked/transmute` that checks size at
>> monomorphization time instead of type-checking time. This allows more ca=
ses
>> where we know that the size matches but this is not generically checkabl=
e.
>>
>> The signature is equivalent to the unstable `transmute_neo` function in =
the
>> standard library. A safe variant is provided to use with types implement=
ing
>> `FromBytes` and `IntoBytes`.
>>
>> Existing users of `transmute_copy` to bypass size checks are converted.
>>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
>
> ... with a couple of minor nits below.
>
> <...>
>> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
>> index 4d5c96ddc49c..7225abc64084 100644
>> --- a/rust/kernel/lib.rs
>> +++ b/rust/kernel/lib.rs
>> @@ -98,6 +98,7 @@
>>  pub mod kunit;
>>  pub mod list;
>>  pub mod maple_tree;
>> +pub mod mem;
>>  pub mod miscdevice;
>>  pub mod mm;
>>  pub mod module;
>> diff --git a/rust/kernel/mem.rs b/rust/kernel/mem.rs
>> new file mode 100644
>> index 000000000000..a0901cbe1b2d
>> --- /dev/null
>> +++ b/rust/kernel/mem.rs
>> @@ -0,0 +1,37 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! Basic utilities for dealing with memory, values, and types.
>> +
>> +use crate::prelude::*;
>> +
>> +/// Version of `transmute` that performs size check at monomorphization=
-time.
>> +///
>> +/// Use this instead of [`core::mem::transmute`] when it is known that =
sizes are identical but this
>> +/// cannot be proven by the compiler during type checking.
>> +///
>> +/// The signature is equivalent after Rust standard library's unstable =
`transmute_neo` and that of
>
> nit: "equivalent to Rust..."?
>
>> +/// [RFC 3844](https://github.com/rust-lang/rfcs/pull/3844).
>> +///
>> +/// # Safety
>> +///
>> +/// Same as [`core::mem::transmute`].
>
> Let's add a short doctest for this new core function (and for
> `transmute` as well).
>
>> +#[inline(always)]
>
> I suspect we want `#[inline]` here in line with Sashiko's comment on
> patch 3.

That's a known false positive of Sashiko (latest prompt should have fixed i=
t).

For this function I really want it to *never* be not inlined (it's supposed=
 to
compile down to, well, nothing), so for example, it's allowed to rely on th=
is
function for code that use build_assert.

Best,
Gary
