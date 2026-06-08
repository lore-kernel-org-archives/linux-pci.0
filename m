Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020099.outbound.protection.outlook.com [52.101.195.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC763E9284;
	Mon,  8 Jun 2026 19:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948762; cv=fail; b=bx8LrM6BZZFgCU0tabod0PfKVB9eIVCSe74LwoceewEzC0LqWkPxP9zxXmDNBpLIaoGUxe+XJjWbSERGRlgQuOc9xtbD/2izbyhlwmp3AmlEHfp89QnXgiOvsahdBzGwnx7yuikLAgSi46aqI+opvY5w0ujtlQUYpX/kwfDCxAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948762; c=relaxed/simple;
	bh=TQu251RbAEKJSp7O3be+Dv/1yXkBgl67+gFSH6eSmMo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hdcA4WpxMkJlWsKswKH4RnwBjDK7+bERCCEtTA7Ad9ycq1dz5tjjvsbMc0Rs4v2enn7wrdMPwPQ6uyO00JxC1gj5Dw8ZZAdjFV36AaF3sWYhP67qaT1q/veD04kY0Nsumsb7Wp7cvoHmddfb/clKve3QhdO96XsEMKXJgRsQVSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=h9bD4en0; arc=fail smtp.client-ip=52.101.195.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="h9bD4en0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdKSrtLd8rBo0pAfHIgd8XetmcvvKn6HSgM1lS1JdRgc5O6KKW+xeKPl0WxustOTzvrWqxnSpiHho1tjhW4y8uzQtZcf5fOATYN4Qdlna1Ny2XbflNnRVeCgPYgJyEbaREguV1+ew0nVXVlN/rtLK+iYdtLA2FXQHCNoNl35vUXDQ6n91INn/ewJBf0da01Oxxaog5utqdha2XGFOmUX0GK+kkPrn0WhRueEVCP0Z/XyxJl42AYO49YuBXNTvDiK9lKc8a0fKc/c1NtL7YbYWg8tpa22dyioRiYwJfGTas7Mvm2R4q+EVFlVFDJEfUrN6pb2jTLyvPgbT+xKdS+GcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=La+iQi6/WOXuxcAaZxq6cKG9UrrA5hLsn3OenvkCCTU=;
 b=Wa2VffXUqvh1kqVZtszWIhx5jHal0nlneXNbi0DYmUNPyMhDDx2YU5fTrlocaxVsgKA05APjZuwQmKInPxlNLxS4iWSeDl6zZB3G2r8AJyyP3xBEx0FajfQbxqcXZ3fZRaLhXjgAiLXJIBhz+mrT1xbiXbCM73bM95E0O0N1w2foWztfDwN3DMxTdeIEqSdaoXOTshu9ind/JqbWP5Dk1ZTyUiVFgn2v5hSYKXjZe2dYK7dt4yjTvWQWN5uzCX2a7QAfaURH0WUkhMKcY6CDjD7WXFa3Xf7+lIJEUe80MLd/y+3ng3Av8FdArFA36Z7kIffIawnjPEjhh6/AxGz47w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=La+iQi6/WOXuxcAaZxq6cKG9UrrA5hLsn3OenvkCCTU=;
 b=h9bD4en0HTmDhmlU97pkKGpwne4Sfsq3fhPm6D74IpQXyLmp96D/kxt++6tW1Rb4+M3swXZDynfEYFKdt0tOpW40dJTfwiAPvdx57FYcxUARVmdw23wxM/23Azkm/3Fdq7izzVYH/p1WGGgMGs+MIzB2jiwcIS/lmrO2/84YHrQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7398.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 19:59:10 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 19:59:10 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 08 Jun 2026 20:59:02 +0100
Subject: [PATCH v3 05/19] rust: io: generalize `MmioRaw` to pointer to
 arbitrary type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-io_projection-v3-5-c5cde13a5ec4@garyguo.net>
References: <20260608-io_projection-v3-0-c5cde13a5ec4@garyguo.net>
In-Reply-To: <20260608-io_projection-v3-0-c5cde13a5ec4@garyguo.net>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780948747; l=7828;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=TQu251RbAEKJSp7O3be+Dv/1yXkBgl67+gFSH6eSmMo=;
 b=l/tiv7OG4YJWEJBx3pSIcmCFQ5jfxX47LHdJGCyo6yBYJwGL3rERpUw18yN7Fmb3Q1UbQiBuz
 V1Ht3uYxoUyD2R1qTc0CcG2dfIQzIkVvO+uwHF5oJboIAUeKeEyG1oq
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0344.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO8P265MB7398:EE_
X-MS-Office365-Filtering-Correlation-Id: d884709b-ef3c-4568-4564-08dec59867c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|6133799003|22082099003|18002099003|921020|56012099006;
X-Microsoft-Antispam-Message-Info:
	bjLXGSiwwjp4hyJbN7AfoXUaUwaXoepsHgs9bEsu0e/5qMXjVlOEEcBuiRCZulgG6B/uggH9nEF7C6HgnAi4I3fi24oQBa7MbPeYABjPYCmLADR5DiqpOAL0Xe8rs+JRyA7PQX+ksTdRznu/BL/czxZbbtdIlVMqibdbFAMK8/zR8xeah/dBZRyXvyTLhMu0HxNN0Jcdufc8qp11dNuM3sSyp7jCqtRSSXp4jMhEuyDFlF/m1tN9Qq5sZW3d1Y4cfVRpBB0XoLoPs7GIDmDNQRjL/KQfo4ABMdFdWiHW6mXauoF7tt9KxXAYyfnMRBEeB9WqepNFKlyjCfkWxizAql/PpA0uU6JeXj0gyLnC8FqyQl9X5d0d7q0LFEG+Pczi9oS5/gTL3CfZrZL8W49XSTQLNXyzL4P17VHJSBHDVizKrL/9rHUpHsOjjmBcc+vDGdCzKliOBLoLYBHmEy8Q7ZA9859tUbOeTBlN+3d/Gx2rUaHrBNdo9DWKNash8WEbF15N4pPJYBB3H384CH/d88Kww2ajZZ4xswivjz8vddQ5Q1lfmFfYVJTudI+sPD9an24rYYlpwt8jqELC2pPC63qib2MzjqChGEjkFvo6XkSAm57ZKfKhdPpnbZ8veE0B3rAFkzaMPGQMjVXXv6iaHcoPh2LJsRXT//j4+fXQZiJ+fI/e7svjORIvtcx5DFcuhMTD14CmJ2DwubqXEgvuOxmEoDKrmpYg8iw8Icx4Idg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(6133799003)(22082099003)(18002099003)(921020)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlJhMHZ5ZVM4ZGs3d3FPdjN0L2tkQklCKzd0VHZYV1ZmdnJ0b2hLSVFOWk9N?=
 =?utf-8?B?bTYwdlFNeis4dk94VWVFNXdEVmpqamR2MUtteDhxNnl0WWVVcFQ1LzJuckRT?=
 =?utf-8?B?blJyWlFEUzd1d0Y1c29CQ2dlV3VJdjQ4T3ZUN1NIZnVLOVpGbnN1WXZVL0Z2?=
 =?utf-8?B?WTVyTXdVQW9EU2lBbmNxcmxPeUlML1RPc0dHMzBuaGozMjZRUVBmRHlVN1J2?=
 =?utf-8?B?WXk2ZTVRdnJRUnNoT1VraVdzUXpBb0FrSTkvSXp4R05BNVYxcUFhaElSRm1O?=
 =?utf-8?B?cGppSnUvK1N3R0trK2t6WCtUQTVLeUMyTjhVUnROaDdwcjVhUlo0SFVkbVZ0?=
 =?utf-8?B?bzBwMDlSd291TUF2Uy91aHZzRnZIbjhsaDFxclBGV1BERDhPNk1teGthcm52?=
 =?utf-8?B?a1J0ZkhTYk80NWx6OXpLNzVRZXpWQ1NOOWlPdVhvWEdEVjJkZEpPWlk5djZm?=
 =?utf-8?B?ZnVvbzJvZFBJT2VJK2dtVlFJTXZ5a0pEb3oxMEsvbytJRytwenc3UFozbjc2?=
 =?utf-8?B?S3pYMFNtL1dlc0UxWlVDY1QveTd2aGdBcjI0UGN2OGdBdEM0ZHhkN2kwUkp6?=
 =?utf-8?B?bnJxb0tIYjJFZTdrZmNLTHZXRHN5SUpqbWZ4RklmSTJZd015Q0lXKy9Gcmsy?=
 =?utf-8?B?ODRjVmllTHpJYVllSkhrUVlESGF2R2ZLTWxDYU5NTVNYYktWMnJDSk5nY0lT?=
 =?utf-8?B?ZjZrVERCUExHbUtJQUhqZExrVjA1d1B2dHM2ZzZ5dkNwb3ZlT1FrRjlvZjRl?=
 =?utf-8?B?ejA0MERlZzA0Q0FweDhWNHBSOXlaUVc5bjBtaXU2NW1vdlJjWURjcU1UK3g4?=
 =?utf-8?B?VEwwNGExQzhVWXdKY2p4RDhod0RjL0x0OGxFMHpwTDh2MFh0Yy9DTzBiUFFO?=
 =?utf-8?B?dndJMGlHTkpRMW5ld0MrL1hvUTA1dnJBdWUzcGh6Mlc4WGZNM1JkK2tkWlpl?=
 =?utf-8?B?c2VMa3hPc0ZuK3o5cmZjeWJHdC9uWi9FODJhWU0zZmc2THZtMms5cjJHTERO?=
 =?utf-8?B?a2d0bDcwekZQQ3ZMQVhQMGhxR3p4TjNXYjFqUy9qVk9pTUREQ2taMW5QeWUw?=
 =?utf-8?B?Q1BjNEJBZ21pbm5DUTA0VFhsZ2JtQVp2QVI1SUVmd3Rqc2gwa2h4a01sVmVy?=
 =?utf-8?B?anUwakdrYW1qeFI1cVAzN3RsWDJQdldtYXRiQzYrY2FkL1R3U3R0ME5PWGhS?=
 =?utf-8?B?bzEyOVhDMmViQStqZUpGSVFURjNlUm5wZ0JPbjA0bHBmTllSWGpJLzdLT3dW?=
 =?utf-8?B?ZTR1SXZ4WUltQzA0M3I2YlRGWWxJdjFCcGpHNW94UUdnYmN0eW9CU2dRY3VD?=
 =?utf-8?B?czNzR3ZhNEU0NTA4ZXdvYis1RVo3S1A1OVA0am5KcWlFWVZxTGZGTEZaa1ZV?=
 =?utf-8?B?NFI4N0pNRnNVMHQ5OGduWmZQS2VkVFI2VVZaai8wQU1JWVAranBqYXNyckNQ?=
 =?utf-8?B?MXVvL01NSmFTeFJIenJpUE14c2pmcWRjdi95ZzNiUjN3dzROcU13YnRyY3pl?=
 =?utf-8?B?YmdoZnZuZ0Y3NGlpczBtbEFYREwzbCtjM0FHZkVwNlN5a29JN3c1WWx3SGth?=
 =?utf-8?B?dmNOYTByUGVmeFNDTmlEV1A1TVNPSnJHN2hOZGJ5V2JQK0ZzN01aMGlNUUty?=
 =?utf-8?B?NWw3NFJwNE9KdUVEd3hGZFB6bkExRmRpb1VqcmVLOCtIQTE3V20vSXNUZFls?=
 =?utf-8?B?cXRSWDJWQjJUcUdnZkg1bGxZZzdTUk5kdkhPbDNkd3EvVm55UnByNVgzNmhI?=
 =?utf-8?B?NWc0eFFheEZUend4L1BDekJnZm1sUzA5NlQrTkFOZkppK01JbWVVZzBBQll1?=
 =?utf-8?B?Y3Q0eXN1Tzk1SkNnSW4xVkUybitVb1l1T1lhb1ZJUFRIQ1RnQzB1bjVzWjNL?=
 =?utf-8?B?dGM3SVBzVUlEQ0NaMGN4Q09RRDMxNVNkRDhFb3R2eFgwNjNnWkhqWENxMmwr?=
 =?utf-8?B?Ry9yTWoxeFY4d0JtdURrdm5NcVBWa3ZobGZ2RUVXNXgwUjJieXdRUGlidm56?=
 =?utf-8?B?VW1OYmdkejc4d2JmN0swV3lpTlk0UTFMYzl4T05tSUhseEdPYmdmZTNnaGZm?=
 =?utf-8?B?VUc2WVVEdE95QVZRNnJzSzA3dEVTMHNOK0pOTGFrSWMxZTFKSlFXZUs3V0ow?=
 =?utf-8?B?YlArUlpNQmE5YVRFZWNIejNrRmFFZ042dk1QUDZaSjY1dXp4YlVxTFlHWFo4?=
 =?utf-8?B?aDZ4OHhFNkhIcklMOVJLRGpXdWFCMm5kZXBhN2FRM0REZzJ6WWxXVlBpTWlI?=
 =?utf-8?B?ZWFSdjRqTUdFZk40TGI4Tlp4MEJyOUdSQXlic1BjdXlBREJ6bnJaVEQyeXNP?=
 =?utf-8?B?emh5eTVJS3JsTHREWmFPaFhLYWMvcitsQ1FjbTlYUFBZSHF4L0pNQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d884709b-ef3c-4568-4564-08dec59867c5
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 19:59:10.0915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: euGSgUg7sjmoaVcqsJdS5aKZXGMESHK7ERgmj05A70MMsmTOol+6npZA7Jd6rWzVp7IAYpjOtW6j24Srg5Mq9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7398

Conceptually, `MmioRaw` is just `__iomem *`, so it should work for any
types. Update the existing use case where it represents a region of
compile-time known minimum size and run-time known actual size to use the
dynamic-sized type `Region<SIZE>` instead. Rename `maxsize` method to
reflect that it is the actual size (not a bound) of the region.

Implement `Clone` and `Copy` manually, which cannot be derived due to the
generic parameter. The use of raw pointers also cause the `Send` and `Sync`
auto trait implementation to be lost, so add them back by manual
implementation.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/devres.rs |  7 +++---
 rust/kernel/io.rs     | 67 +++++++++++++++++++++++++++++++++++++--------------
 rust/kernel/io/mem.rs |  5 ++--
 rust/kernel/pci/io.rs |  4 +--
 4 files changed, 57 insertions(+), 26 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index ed30ccc6e68e..d0c677fd7932 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -70,14 +70,15 @@ struct Inner<T> {
 ///         Io,
 ///         Mmio,
 ///         MmioRaw,
-///         PhysAddr, //
+///         PhysAddr,
+///         Region, //
 ///     },
 ///     prelude::*,
 /// };
 /// use core::ops::Deref;
 ///
 /// // See also [`pci::Bar`] for a real example.
-/// struct IoMem<const SIZE: usize>(MmioRaw<SIZE>);
+/// struct IoMem<const SIZE: usize>(MmioRaw<Region<SIZE>>);
 ///
 /// impl<const SIZE: usize> IoMem<SIZE> {
 ///     /// # Safety
@@ -92,7 +93,7 @@ struct Inner<T> {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(MmioRaw::new(addr as usize, SIZE)?))
+///         Ok(IoMem(MmioRaw::new_region(addr as usize, SIZE)?))
 ///     }
 /// }
 ///
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index d57df2a072a0..c9533d3f003b 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -90,37 +90,67 @@ fn size(p: *const Self) -> usize {
 
 /// Raw representation of an MMIO region.
 ///
+/// `MmioRaw<T>` is equivalent to `T __iomem *` in C.
+///
 /// By itself, the existence of an instance of this structure does not provide any guarantees that
 /// the represented MMIO region does exist or is properly mapped.
 ///
 /// Instead, the bus specific MMIO implementation must convert this raw representation into an
 /// `Mmio` instance providing the actual memory accessors. Only by the conversion into an `Mmio`
 /// structure any guarantees are given.
-pub struct MmioRaw<const SIZE: usize = 0> {
-    addr: usize,
-    maxsize: usize,
+pub struct MmioRaw<T: ?Sized> {
+    /// Pointer is in I/O address space.
+    ///
+    /// The provenance does not matter, only the address and metadata do.
+    ptr: *mut T,
 }
 
-impl<const SIZE: usize> MmioRaw<SIZE> {
-    /// Returns a new `MmioRaw` instance on success, an error otherwise.
-    pub fn new(addr: usize, maxsize: usize) -> Result<Self> {
-        if maxsize < SIZE {
-            return Err(EINVAL);
+impl<T: ?Sized> Copy for MmioRaw<T> {}
+impl<T: ?Sized> Clone for MmioRaw<T> {
+    #[inline]
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+
+// SAFETY: `MmioRaw` is just an address, so is thread-safe.
+unsafe impl<T: ?Sized> Send for MmioRaw<T> {}
+// SAFETY: `MmioRaw` is just an address, so is thread-safe.
+unsafe impl<T: ?Sized> Sync for MmioRaw<T> {}
+
+impl<T> MmioRaw<T> {
+    /// Create a `MmioRaw` from address.
+    #[inline]
+    pub fn new(addr: usize) -> Self {
+        Self {
+            ptr: core::ptr::without_provenance_mut(addr),
         }
+    }
+}
 
-        Ok(Self { addr, maxsize })
+impl<const SIZE: usize> MmioRaw<Region<SIZE>> {
+    /// Create a `MmioRaw` representing a I/O region with given size.
+    ///
+    /// The size is checked against the minimum size specified via const generics.
+    #[inline]
+    pub fn new_region(addr: usize, size: usize) -> Result<Self> {
+        Ok(Self {
+            ptr: Region::ptr_try_from_raw_parts_mut(core::ptr::without_provenance_mut(addr), size)?,
+        })
     }
+}
 
+impl<T: ?Sized + KnownSize> MmioRaw<T> {
     /// Returns the base address of the MMIO region.
     #[inline]
     pub fn addr(&self) -> usize {
-        self.addr
+        self.ptr.addr()
     }
 
-    /// Returns the maximum size of the MMIO region.
+    /// Returns the size of the MMIO region.
     #[inline]
-    pub fn maxsize(&self) -> usize {
-        self.maxsize
+    pub fn size(&self) -> usize {
+        KnownSize::size(self.ptr)
     }
 }
 
@@ -145,12 +175,13 @@ pub fn maxsize(&self) -> usize {
 ///         Mmio,
 ///         MmioRaw,
 ///         PhysAddr,
+///         Region,
 ///     },
 /// };
 /// use core::ops::Deref;
 ///
 /// // See also `pci::Bar` for a real example.
-/// struct IoMem<const SIZE: usize>(MmioRaw<SIZE>);
+/// struct IoMem<const SIZE: usize>(MmioRaw<Region<SIZE>>);
 ///
 /// impl<const SIZE: usize> IoMem<SIZE> {
 ///     /// # Safety
@@ -165,7 +196,7 @@ pub fn maxsize(&self) -> usize {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(MmioRaw::new(addr as usize, SIZE)?))
+///         Ok(IoMem(MmioRaw::new_region(addr as usize, SIZE)?))
 ///     }
 /// }
 ///
@@ -195,7 +226,7 @@ pub fn maxsize(&self) -> usize {
 /// # }
 /// ```
 #[repr(transparent)]
-pub struct Mmio<const SIZE: usize = 0>(MmioRaw<SIZE>);
+pub struct Mmio<const SIZE: usize = 0>(MmioRaw<Region<SIZE>>);
 
 /// Checks whether an access of type `U` at the given `base` and the given `offset`
 /// is valid within this region.
@@ -841,7 +872,7 @@ fn addr(self) -> usize {
     /// Returns the maximum size of this mapping.
     #[inline]
     fn maxsize(self) -> usize {
-        self.0.maxsize()
+        self.0.size()
     }
 }
 
@@ -852,7 +883,7 @@ impl<const SIZE: usize> Mmio<SIZE> {
     ///
     /// Callers must ensure that `addr` is the start of a valid I/O mapped memory region of size
     /// `maxsize`.
-    pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
+    pub unsafe fn from_raw(raw: &MmioRaw<Region<SIZE>>) -> &Self {
         // SAFETY: `Mmio` is a transparent wrapper around `MmioRaw`.
         unsafe { &*core::ptr::from_ref(raw).cast() }
     }
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index fc2a3e24f8d5..9e15bc8fde78 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -229,7 +229,7 @@ fn deref(&self) -> &Self::Target {
 /// start of the I/O memory mapped region.
 pub struct IoMem<'a, const SIZE: usize = 0> {
     dev: &'a Device<Bound>,
-    io: MmioRaw<SIZE>,
+    io: MmioRaw<super::Region<SIZE>>,
 }
 
 impl<'a, const SIZE: usize> IoMem<'a, SIZE> {
@@ -264,8 +264,7 @@ fn ioremap(dev: &'a Device<Bound>, resource: &Resource) -> Result<Self> {
             return Err(ENOMEM);
         }
 
-        let io = MmioRaw::new(addr as usize, size)?;
-
+        let io = MmioRaw::new_region(addr as usize, size)?;
         Ok(IoMem { dev, io })
     }
 
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 505305cd9b86..42f840d64a6f 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -139,7 +139,7 @@ fn maxsize(self) -> usize {
 /// memory mapped PCI BAR and its size.
 pub struct Bar<'a, const SIZE: usize = 0> {
     pdev: &'a Device<device::Bound>,
-    io: MmioRaw<SIZE>,
+    io: MmioRaw<crate::io::Region<SIZE>>,
     num: i32,
 }
 
@@ -179,7 +179,7 @@ pub(super) fn new(
             return Err(ENOMEM);
         }
 
-        let io = match MmioRaw::new(ioptr, len as usize) {
+        let io = match MmioRaw::new_region(ioptr, len as usize) {
             Ok(io) => io,
             Err(err) => {
                 // SAFETY:

-- 
2.54.0

