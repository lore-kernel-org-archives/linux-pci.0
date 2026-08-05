Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021138.outbound.protection.outlook.com [52.101.100.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C955E47CA73;
	Wed,  5 Aug 2026 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947830; cv=fail; b=sN33thdOdC9tGiUtfsWQoaG6lQ7WdWsfm+hFaq76UlLK0kcYgqTkuJSzpWjcICxoa9YjiGZRoV4mYdI7ShL6MDYXqDMPdcevRuG1j8Y3Ua+Qsv99OQikUd4IhwMQsOu8dn1ndx523o73CixcobkYo+2Tw8+8bYUsd3RbiYPa+Hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947830; c=relaxed/simple;
	bh=4OTC0teSIM1xSp6kRfAuey2wjXPl4VEtk8eMLcGEVSI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=AQzvshcM5VuHTqQ7u4FqCVATF9vMEteWCJG8R+kjtkpSWfKtg6ah4MQWOAYBfa9y4f4OlC9GanSydUHNZErXJOmJusyWBvVH7uWxwvrUpHVPw5yGLKq121z4pfYm7pWL6lGZaAIM2iIDDS05fjE089VQhSBFjKr8ZfdArY5LrkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=vtXyHGBe; arc=fail smtp.client-ip=52.101.100.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="vtXyHGBe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxYMsCXLker6WrqsveulbrMcxcmU8rZty/WhSxvCbf/Ks3FcTPmHPeQ58p37zl7arJdkbA2Uq2nUDzVNu/sFfAn/25DJ60LHOY/MmnVQD4hKEwyGC35z2dkEwuavjZc2gpU+m7UnrXkcMJ0HbZXSbocjRwSfrxz46X6jmx92ox7JcbcfklwFu8d41Mb/8OIfwVMzz8uBkuA4x95DsI+iemde33+8n8EhqO+MqEX7RVHOIPTk8TcVXupG3f/IVT+ytjmE8X5Hp3UYbG+AcbBrsyuZ6M9gTqp+ny1Ah/N8LNZdz/E7ziOmbMga9E7QX8s2lLIE21DU53KSrDU4fAq0wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foTm3n/NlJ0DNqvRWEZ6c59U9jEKFZU5e06FbdSgk9I=;
 b=b7dWKXxBAhROu6GChFLrxrefv+A+bOHq6lnl5OB4XctMBa9s6aA3Ixy+nhcxWYhR2Fcw47a/OG44yKHBeDavO92XdmGwUJcLH0gvhZo8bkLPGXPRtqX/qS/K8qKuXv/X/8Fj6oyG86yGLBvEXwW4sHU8ravb/TDXZK1nFkugHqTRygebtvhW6O5ydPeyEz4VMo3J/mZbipfm3a5Xgs4ZCpxnMvNG285R7Iy99YJjpN2r+s8IHkL+fJ4ddPW8PaNK72m6x0ibL6u41aG3lRn9oyO0BiNzDvZu85whiMfV/w9N5mJ9Cs2oJEv1z70RAZPnS4YjAydDdRbDUncN1NdZFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foTm3n/NlJ0DNqvRWEZ6c59U9jEKFZU5e06FbdSgk9I=;
 b=vtXyHGBeKbDLMb6uiLR7v2N0mC5gMp2NJzGRYOOF5tbEeMa20Wyi7Vvt32MyMREQAolkiAr3nnzd55i+kJh3MhXSsxsBT5SVdSu71SwZ7nqeXLTeSmQNpatIkgyWxSi+vK2AmmZEVQD06mZXljtXTx5NqbQwfe3sI1I+RO6dmYs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by LO2P265MB5822.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:26c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 16:37:00 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 16:37:00 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 05 Aug 2026 17:35:45 +0100
Subject: [PATCH v2 02/16] rust: io: add `IoRepr` trait
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-typed_register-v2-2-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
In-Reply-To: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, 
 Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785947818; l=26792;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=4OTC0teSIM1xSp6kRfAuey2wjXPl4VEtk8eMLcGEVSI=;
 b=di0eyeAQVEUUwzDMlzQPN0hf2BmAo8iQ0fWE7vpJsFWJVu6deVUEEosHwo35rxZFHwB+749lI
 +Xe3Rjw/Hc6Bm6XN8M0A77jfKgFs8kFpRPayT1Uq/8U8Yg4weBJtY18
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0608.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::8) To LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4b4::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOZP265MB8551:EE_|LO2P265MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: cbbdbf91-ca40-45fd-dfab-08def30fc61d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|1800799024|376014|23010399003|366016|6133799003|3023799007|22082099003|18002099003|5023799004|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	4pAbdPVpZkSd1oRLYyMt1dwB7X5bO+HNTa/nXTgPMbj4bb2tw0OqGxL0JQGF5wv9wOl6hYVw3WOr3ms5Z0aRj3rXeFZcDTqd9YrRiTdsVCpBVcYlXK3XkjNh5qXSrG/L3SfwrfVnirBJ/BYGc7Iyh/Yw4nFoxC8RiIA3aiNJ8HGh2nFkEOY9RTB8EiiRtTXN11HSX0DPa9uzoEqs9wGuvOhxm99lyCzj6ZpAtC62dS4+p6t1TCvxGjP0alQnRyZ9gKw/lC02WbnIRZtCJjYDCNiWXrSc4z+mSqeWBOrUb9eeSqewIvSJhEeojO3aPPrOCGpL2c5pjFAtlZfEHmTlABsC+iK1cazqqNdfcI1AaSjKX6DCEqrE0y8ZFeHp21vR5QFmWv3Jl0ir7Ef2uxQRULjIpXgsfeVRF0VM9H00MplGyfjurLvIYTZYa/VTvOJM4s2Ay1hnLxEc0Tez+jFJpL98d4zfz9q+b++cRjjmr5cgXvJfbMpke3xbRNwl7KaG/tq6Y4HL73ez5kGONZ6KJFj0d9a1Ib6uKtmsHtxjAmiHfVaPFzu8GqM4yej1cjCPdAoT5wyOilYpdyFH+QLns1vU3JaE3JDZ9Lo4+Fb/58y3pIPnphleU4sds+2JSek/G18ZDhY2iG/9uboGrrHkBG60f/DpfXVn/6w8EdnEKRSo8I6uoe4zU0IEUH/nCErvWMd1FWhM12RpJBLg99FN/g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(1800799024)(376014)(23010399003)(366016)(6133799003)(3023799007)(22082099003)(18002099003)(5023799004)(56012099006)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2h3cC9OeXR1ejVkZ2kzcGRkc3FPaFgrL1RrcVdXSXZJR09uaUpOL2hLam5Y?=
 =?utf-8?B?b0JodG9aSk9oeGEyb1dDOU1HODVJckV3aEYwZ21VdFU5NUlQRlI1ZkxEa3ox?=
 =?utf-8?B?dEp0ejVGZHQ4blQyQTIxYnBubnBoRnpiYnRLUFFvS09QcmNkWmtGaG5GZjhO?=
 =?utf-8?B?WjdZZjJlZkNBWEF6WUk2ZjArVm50c0svTjV1YkdqSnBmZEZYWXBmYUVzWGk4?=
 =?utf-8?B?WU8yY2VISGVRSW9qUGFFZXpOZzY4V3A2RDY5c0xZRllKNkRlZFNLSDF3V3da?=
 =?utf-8?B?QThtbldPZCt2dE5KdUlpczlJcUg4TkhjYmR4NmpmODg3RGgxcEc1V2pSNTJY?=
 =?utf-8?B?S0RrYmpXMTBGSnRQM3ltS0RvWG5ESmpoTmZ4Tmllcklyb05HNG9nRXU0RWpz?=
 =?utf-8?B?UXk0MHllSnkvb0pBWTB2R0E0MnY4SXI4MmNKK09GTEhEVGIzYiswbDhPVStq?=
 =?utf-8?B?WHVXUDdHcDFmQjAwZE5Ib2dTMElsZmhQSlE2VnpyWUpkZ1pMNW1seXVrYzlp?=
 =?utf-8?B?WE1Xc0kwTTJtVm5rNTdoWXFrUVFEbzNucXBEYVBQMjZwSm1IUXRIY2s3TVlm?=
 =?utf-8?B?V2dkQnlobkNTWXgrVUZyOVJZcHNlUExGcFJSWG9QdUhHS0JpOGVqTFpDdVRJ?=
 =?utf-8?B?cUE5N244TE9OUjVBdG4yN3hXRU1VbXRwN1dGclNuNGNkY3ZxeDlHM09jaEJj?=
 =?utf-8?B?a2lLMEI5WjZUQ3JzdnBmbm1BTDNlcldub0pVTzZuaFJ0dlRaYjZTWHNvanlk?=
 =?utf-8?B?QjhUYnVlOE14dnJERDM4SEEzbmZGOWY4M2FiRFY0dFI4enMyVG0vZXN3N1B5?=
 =?utf-8?B?NVN4eTlXR3BTdCtPMkVEOHVtVzA1RGdsNUFXeEFpNkhwUHhkQmRadDlKbWM0?=
 =?utf-8?B?N0gxbkY5S0p1MTdib1N6d3IvWWM4dHZ6N1d0bEI3dXYvSzJPS2MxM2JxdGs0?=
 =?utf-8?B?WVg1dzhVQjhnbVZDNWR3M0RXM00vWGNCR2lDQkY2ajMwclJhY0MwYW1pNHc4?=
 =?utf-8?B?WUlYaUtlSDYzNFFXYzVpNCsyRjZQSmFjcDFhTnhCanIwTFlLdW5lbjBoWVRy?=
 =?utf-8?B?SmYyNk1ZbDdteFRUYUFyczQvWGpFY25zVEwxM0FPc1NxeUMwdmJabWxxZyt0?=
 =?utf-8?B?MndxdytoOGtlMlB3WDQ3Zm1yNXVhNTdQQnlyRlp6UGkzL1c2M09jdDZ3S1JX?=
 =?utf-8?B?Z0R5S1B3a3lxMkhLaUlEWEpNMzBQSkhCR3ltVW81cmE3cm5ITm1QVXhxREJ2?=
 =?utf-8?B?Z3hGeWtmVzUwWEpnNlYrTFVIdVkyQ2c0dXgwWFhQZkgvVE1MUFcwY0ZITm5y?=
 =?utf-8?B?ZWFSQnczVitNQmhZbmEvQW1aeUxnZmpSalI5c3lJOEd3R2lKOTQ4S1lnd1ll?=
 =?utf-8?B?cGpKL2hnVjJoQjFBWUFlOGN2Z2ZDRHc4My9INGdmRGN0Nzl5bFpYTk5tWDhp?=
 =?utf-8?B?eFlRcWV5YU5NSmVSTmlNekpzeHpNNFd6Nm9wc0hXM3dRQ3lMODd2dXozYjFK?=
 =?utf-8?B?TUcyUFlIZWY0ZlNuOG8vb2lORDlFb0Q1bG0zTFlmaGV2U2s5Qmsrckl6Yzc2?=
 =?utf-8?B?QkcyT0d5Ty9iME9LdDV3eWVPWTY4V1JTU1dHODVVUmFBWHZsZkdTYzMrTE1W?=
 =?utf-8?B?T1JWTjJrRnNFdHhFV1lNWG0wdzI4YlBEdnBpbE5FcEFiNlJnVzZSRHArd2gz?=
 =?utf-8?B?TXB0NG5zdHZETmlsZEdvQmFXQkJKUzdLL2tOQjRSWmRNZmlPbWVXTzhrN0po?=
 =?utf-8?B?NjJwSHVOVXNaZG5abFlkdStid0lTT1FLQ2dGbStqS1RVWG1PaHQrN1AvRFpL?=
 =?utf-8?B?VEtkYjR2L3pOWnNzZ0IxQTQzdHRpRmZRVmhPME0vWEMxUEZOS2ZEdU9EVjlG?=
 =?utf-8?B?WVdJdy9XeEt5Q3ZQZk9yR096L1JjTURnbGJ0US8xdjhaMnM1UEFwTytQS0lF?=
 =?utf-8?B?Wld0UmJtKy9BSkNjNXM4VS93T1VCWnU4UlNZejMwWlhyODZJMGFQWEhEeTU5?=
 =?utf-8?B?SENnRkd4QzhNTXZTSThva0kxd0lGN084WUQ2allRbU9UeTIyZkdEYm9ZakhH?=
 =?utf-8?B?WlhSdDZsSzZGWmdVa0VXajNZWSs1T1NrR0lzK21ZT3RaYXhIMndHOE1CczFC?=
 =?utf-8?B?T0EwTWo5bkhETTdveEliUzdZUkFBTUZTM0c3M1dTZTllcDA1ZFNPdTFkVEkx?=
 =?utf-8?B?dGp0ZkZKVWVPdThFVzJ0blpSclRnVUhhbGJmUmFaemM2WDdBbVF4UGxRSVFN?=
 =?utf-8?B?TmRSWDk2TkxUVEptTFNvYkdjSTRUZnhSZVhwT2k5VUJhMjhtSFhIM1Jkckth?=
 =?utf-8?B?Z0NNVzJQZVRQVWtCazMyTDJ2VVlDZUtkblFIQkhUOGpIVFpsUllXQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: cbbdbf91-ca40-45fd-dfab-08def30fc61d
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 16:37:00.8290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HsnIeBq3NyXiJYf6RA/OMUzuKnfHGnT9Pm5yxbupazR6tndNFeaqlfmgeqzETpA6IWBnisvX/mrvL2E7BpGpiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5822

For types that are layout-compatible with an I/O capable type, we would
want the ability to use them directly for I/O operations. E.g.

    bitfield! {
        pub struct Foo(u32) {
            ...
        }
    }

    #[repr(C)]
    struct Bar {
        foo: Foo,
    }

    let mmio: Mmio<'_, Bar> = ...;
    io_read!(mmio, .foo)

Currently this feature is available from `register!()` macro but not
otherwise available with `io_read!`, `io_write!`. Support this by adding a
`IoRepr` type to denote the underlying I/O type to use for a specific type.

This makes the `IoLoc::IoType` and `Register::Storage` redundant; thus
remove them; also convert register methods to use the `read_val` and
`write_val` instead.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/bitfield.rs    |   5 ++
 rust/kernel/io.rs          | 203 ++++++++++++++++++++++++++++++++-------------
 rust/kernel/io/register.rs |  59 +++++--------
 3 files changed, 170 insertions(+), 97 deletions(-)

diff --git a/rust/kernel/bitfield.rs b/rust/kernel/bitfield.rs
index 35ede53f2b8e..4bc92c62da06 100644
--- a/rust/kernel/bitfield.rs
+++ b/rust/kernel/bitfield.rs
@@ -308,6 +308,7 @@ macro_rules! bitfield {
         $(#[$attr])*
         #[repr(transparent)]
         #[derive(Clone, Copy, PartialEq, Eq)]
+        #[derive($crate::prelude::FromBytes, $crate::prelude::IntoBytes)]
         $vis struct $name {
             inner: $storage,
         }
@@ -346,6 +347,10 @@ fn from(val: $storage) -> $name {
                 Self::from_raw(val)
             }
         }
+
+        impl $crate::io::IoRepr for $name {
+            type Repr = $storage;
+        }
     };
 
     // Definitions requiring knowledge of individual fields: private and public field accessors,
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index adfc555de7d0..71c6180ed745 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -276,6 +276,91 @@ pub trait IoCapable<T>: IoBackend {
     fn io_write<'a>(view: Self::View<'a, T>, value: T);
 }
 
+/// Safe transmute that performs size check on monomorphization-time.
+///
+/// Can be considered as generic version of [`zerocopy::transmute!`] macro but using the unstable
+/// `core::mem::transmute_neo` instead of [`core::mem::transmute`].
+#[inline(always)] // This is a no-op.
+fn transmute_neo<Src: IntoBytes, Dst: FromBytes>(val: Src) -> Dst {
+    const_assert!(size_of::<Src>() == size_of::<Dst>());
+
+    // SAFETY: `Src: IntoBytes` and `Dst: FromBytes` and we've checked size is the same.
+    unsafe { core::mem::transmute_copy(&core::mem::ManuallyDrop::new(val)) }
+}
+
+/// Trait indicating the underlying primitive types to be used for I/O operations.
+///
+/// Implementing trait allows arbitrary types to be used for I/O operations, not just raw
+/// primitives.
+///
+/// The layout of the type and the underlying primitive must match; this is enforced via const
+/// assertions when I/O methods are used, as the type system cannot represent this.
+/// [`IoRepr::from_repr`] and [`IoRepr::into_expr`] can be overridden for conversions, however it
+/// should be noted that they are only invoked on value read/write operations and are not invoked
+/// on byte operations such as [`Io::copy_read`].
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::io::*;
+/// #[repr(transparent)]
+/// #[derive(FromBytes, IntoBytes)]
+/// pub struct MyNewType(u32);
+///
+/// impl IoRepr for MyNewType {
+///     type Repr = u32;
+/// }
+///
+/// #[repr(C)]
+/// pub struct MyStruct {
+///     raw: u32,
+///     new_type: MyNewType,
+/// }
+///
+/// # fn test(mmio: Mmio<'_, MyStruct>) {
+/// // let mmio: Mmio<'_, MyStruct>;
+/// let val: u32 = io_read!(mmio, .raw); // Raw primitive read
+/// io_write!(mmio, .raw, val);          // Raw primitve write
+/// let val: MyNewType = io_read!(mmio, .new_type); // Read via `IoRepr`.
+/// io_write!(mmio, .new_type, val);                // Write via `IoRepr`.
+/// # }
+/// ```
+pub trait IoRepr: FromBytes + IntoBytes + Sized {
+    /// The backing I/O capable type.
+    type Repr: FromBytes + IntoBytes;
+
+    /// Convert from [`IoRepr::Repr`] to `Self`.
+    #[inline(always)]
+    fn from_repr(repr: Self::Repr) -> Self {
+        transmute_neo(repr)
+    }
+
+    /// Convert from `Self` to [`IoRepr::Repr`].
+    #[inline(always)]
+    fn into_repr(this: Self) -> Self::Repr {
+        transmute_neo(this)
+    }
+}
+
+macro_rules! impl_io_repr {
+    ($($ty:ty => $backing:ty,)*) => {
+        $(impl IoRepr for $ty {
+            type Repr = $backing;
+        })*
+    };
+}
+
+impl_io_repr! {
+    u8 => u8,
+    u16 => u16,
+    u32 => u32,
+    u64 => u64,
+    i8 => u8,
+    i16 => u16,
+    i32 => u32,
+    i64 => u64,
+}
+
 /// Trait indicating that an I/O backend supports memory copy operations.
 pub trait IoCopyable: IoBackend {
     /// Copy contents of `view` to `buffer`.
@@ -352,15 +437,12 @@ fn copy_write<T: IntoBytes>(view: Self::View<'_, T>, value: T) {
 ///
 /// - The valid `Base` to operate on. For most registers, this should be [`Region`].
 /// - The offset to access (returned by [`IoLoc::offset`]),
-/// - The width of the access (determined by [`IoLoc::IoType`]),
-/// - The type `T` in which the raw data is returned or provided.
+/// - The type `T` in which the data is returned or provided.
 ///
-/// `T` and `IoLoc::IoType` may differ: for instance, a typed register has `T` = the register type
-/// with its bitfields, and `IoType` = its backing primitive (e.g. `u32`).
+/// `T` is not necessarily the type for underlying I/O operation. Methods that take `IoLoc` have `T:
+/// IoRepr` bound and the `<T as IoRepr>::Repr` type would be used to perform I/O and converted to
+/// `T` instead.
 pub trait IoLoc<Base: ?Sized, T> {
-    /// Size ([`u8`], [`u16`], etc) of the I/O performed on the returned [`offset`](IoLoc::offset).
-    type IoType: Into<T> + From<T>;
-
     /// Consumes `self` and returns the offset of this location.
     fn offset(self) -> usize;
 }
@@ -371,8 +453,6 @@ macro_rules! impl_usize_ioloc {
     ($($ty:ty),*) => {
         $(
             impl<const SIZE: usize> IoLoc<Region<SIZE>, $ty> for usize {
-                type IoType = $ty;
-
                 #[inline(always)]
                 fn offset(self) -> usize {
                     self
@@ -536,10 +616,12 @@ fn try_cast<U>(self) -> Result<<Self::Backend as IoBackend>::View<'a, U>>
     #[inline]
     fn read_val(self) -> Self::Target
     where
-        Self::Backend: IoCapable<Self::Target>,
-        Self::Target: Sized,
+        Self::Target: IoRepr,
+        Self::Backend: IoCapable<<Self::Target as IoRepr>::Repr>,
     {
-        Self::Backend::io_read(self.as_view())
+        Self::Target::from_repr(Self::Backend::io_read(
+            self.as_view().cast::<<Self::Target as IoRepr>::Repr>(),
+        ))
     }
 
     /// Write a value to I/O.
@@ -558,10 +640,13 @@ fn read_val(self) -> Self::Target
     #[inline]
     fn write_val(self, value: Self::Target)
     where
-        Self::Backend: IoCapable<Self::Target>,
-        Self::Target: Sized,
+        Self::Target: IoRepr,
+        Self::Backend: IoCapable<<Self::Target as IoRepr>::Repr>,
     {
-        Self::Backend::io_write(self.as_view(), value)
+        Self::Backend::io_write(
+            self.as_view().cast::<<Self::Target as IoRepr>::Repr>(),
+            Self::Target::into_repr(value),
+        )
     }
 
     /// Copy-read from I/O memory.
@@ -683,7 +768,7 @@ fn copy_to_slice(self, data: &mut [u8])
     #[inline(always)]
     fn try_read8(self, offset: usize) -> Result<u8>
     where
-        usize: IoLoc<Self::Target, u8, IoType = u8>,
+        usize: IoLoc<Self::Target, u8>,
         Self::Backend: IoCapable<u8>,
     {
         self.try_read(offset)
@@ -693,7 +778,7 @@ fn try_read8(self, offset: usize) -> Result<u8>
     #[inline(always)]
     fn try_read16(self, offset: usize) -> Result<u16>
     where
-        usize: IoLoc<Self::Target, u16, IoType = u16>,
+        usize: IoLoc<Self::Target, u16>,
         Self::Backend: IoCapable<u16>,
     {
         self.try_read(offset)
@@ -703,7 +788,7 @@ fn try_read16(self, offset: usize) -> Result<u16>
     #[inline(always)]
     fn try_read32(self, offset: usize) -> Result<u32>
     where
-        usize: IoLoc<Self::Target, u32, IoType = u32>,
+        usize: IoLoc<Self::Target, u32>,
         Self::Backend: IoCapable<u32>,
     {
         self.try_read(offset)
@@ -713,7 +798,7 @@ fn try_read32(self, offset: usize) -> Result<u32>
     #[inline(always)]
     fn try_read64(self, offset: usize) -> Result<u64>
     where
-        usize: IoLoc<Self::Target, u64, IoType = u64>,
+        usize: IoLoc<Self::Target, u64>,
         Self::Backend: IoCapable<u64>,
     {
         self.try_read(offset)
@@ -723,7 +808,7 @@ fn try_read64(self, offset: usize) -> Result<u64>
     #[inline(always)]
     fn try_write8(self, value: u8, offset: usize) -> Result
     where
-        usize: IoLoc<Self::Target, u8, IoType = u8>,
+        usize: IoLoc<Self::Target, u8>,
         Self::Backend: IoCapable<u8>,
     {
         self.try_write(offset, value)
@@ -733,7 +818,7 @@ fn try_write8(self, value: u8, offset: usize) -> Result
     #[inline(always)]
     fn try_write16(self, value: u16, offset: usize) -> Result
     where
-        usize: IoLoc<Self::Target, u16, IoType = u16>,
+        usize: IoLoc<Self::Target, u16>,
         Self::Backend: IoCapable<u16>,
     {
         self.try_write(offset, value)
@@ -743,7 +828,7 @@ fn try_write16(self, value: u16, offset: usize) -> Result
     #[inline(always)]
     fn try_write32(self, value: u32, offset: usize) -> Result
     where
-        usize: IoLoc<Self::Target, u32, IoType = u32>,
+        usize: IoLoc<Self::Target, u32>,
         Self::Backend: IoCapable<u32>,
     {
         self.try_write(offset, value)
@@ -753,7 +838,7 @@ fn try_write32(self, value: u32, offset: usize) -> Result
     #[inline(always)]
     fn try_write64(self, value: u64, offset: usize) -> Result
     where
-        usize: IoLoc<Self::Target, u64, IoType = u64>,
+        usize: IoLoc<Self::Target, u64>,
         Self::Backend: IoCapable<u64>,
     {
         self.try_write(offset, value)
@@ -765,7 +850,7 @@ fn try_write64(self, value: u64, offset: usize) -> Result
     #[inline(always)]
     fn read8(self, offset: usize) -> u8
     where
-        usize: IoLoc<Self::Target, u8, IoType = u8>,
+        usize: IoLoc<Self::Target, u8>,
         Self::Backend: IoCapable<u8>,
     {
         self.read(offset)
@@ -777,7 +862,7 @@ fn read8(self, offset: usize) -> u8
     #[inline(always)]
     fn read16(self, offset: usize) -> u16
     where
-        usize: IoLoc<Self::Target, u16, IoType = u16>,
+        usize: IoLoc<Self::Target, u16>,
         Self::Backend: IoCapable<u16>,
     {
         self.read(offset)
@@ -789,7 +874,7 @@ fn read16(self, offset: usize) -> u16
     #[inline(always)]
     fn read32(self, offset: usize) -> u32
     where
-        usize: IoLoc<Self::Target, u32, IoType = u32>,
+        usize: IoLoc<Self::Target, u32>,
         Self::Backend: IoCapable<u32>,
     {
         self.read(offset)
@@ -801,7 +886,7 @@ fn read32(self, offset: usize) -> u32
     #[inline(always)]
     fn read64(self, offset: usize) -> u64
     where
-        usize: IoLoc<Self::Target, u64, IoType = u64>,
+        usize: IoLoc<Self::Target, u64>,
         Self::Backend: IoCapable<u64>,
     {
         self.read(offset)
@@ -813,7 +898,7 @@ fn read64(self, offset: usize) -> u64
     #[inline(always)]
     fn write8(self, value: u8, offset: usize)
     where
-        usize: IoLoc<Self::Target, u8, IoType = u8>,
+        usize: IoLoc<Self::Target, u8>,
         Self::Backend: IoCapable<u8>,
     {
         self.write(offset, value)
@@ -825,7 +910,7 @@ fn write8(self, value: u8, offset: usize)
     #[inline(always)]
     fn write16(self, value: u16, offset: usize)
     where
-        usize: IoLoc<Self::Target, u16, IoType = u16>,
+        usize: IoLoc<Self::Target, u16>,
         Self::Backend: IoCapable<u16>,
     {
         self.write(offset, value)
@@ -837,7 +922,7 @@ fn write16(self, value: u16, offset: usize)
     #[inline(always)]
     fn write32(self, value: u32, offset: usize)
     where
-        usize: IoLoc<Self::Target, u32, IoType = u32>,
+        usize: IoLoc<Self::Target, u32>,
         Self::Backend: IoCapable<u32>,
     {
         self.write(offset, value)
@@ -849,7 +934,7 @@ fn write32(self, value: u32, offset: usize)
     #[inline(always)]
     fn write64(self, value: u64, offset: usize)
     where
-        usize: IoLoc<Self::Target, u64, IoType = u64>,
+        usize: IoLoc<Self::Target, u64>,
         Self::Backend: IoCapable<u64>,
     {
         self.write(offset, value)
@@ -881,11 +966,12 @@ fn write64(self, value: u64, offset: usize)
     #[inline(always)]
     fn try_read<T, L>(self, location: L) -> Result<T>
     where
+        T: IoRepr,
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<<T as IoRepr>::Repr>,
     {
-        let view = io_view::<Self, L::IoType>(self, location.offset())?;
-        Ok(Self::Backend::io_read(view).into())
+        let view = io_view::<Self, T>(self, location.offset())?;
+        Ok(view.read_val())
     }
 
     /// Generic fallible write with runtime bounds check.
@@ -914,12 +1000,12 @@ fn try_read<T, L>(self, location: L) -> Result<T>
     #[inline(always)]
     fn try_write<T, L>(self, location: L, value: T) -> Result
     where
+        T: IoRepr,
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<<T as IoRepr>::Repr>,
     {
-        let view = io_view::<Self, L::IoType>(self, location.offset())?;
-        let io_value = value.into();
-        Self::Backend::io_write(view, io_value);
+        let view = io_view::<Self, T>(self, location.offset())?;
+        view.write_val(value);
         Ok(())
     }
 
@@ -958,9 +1044,10 @@ fn try_write<T, L>(self, location: L, value: T) -> Result
     #[inline(always)]
     fn try_write_reg<T, L, V>(self, value: V) -> Result
     where
+        T: IoRepr,
         L: IoLoc<Self::Target, T>,
         V: LocatedRegister<Self::Target, Location = L, Value = T>,
-        Self::Backend: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<<T as IoRepr>::Repr>,
     {
         let (location, value) = value.into_io_op();
 
@@ -992,16 +1079,13 @@ fn try_write_reg<T, L, V>(self, value: V) -> Result
     #[inline(always)]
     fn try_update<T, L, F>(self, location: L, f: F) -> Result
     where
+        T: IoRepr,
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<<T as IoRepr>::Repr>,
         F: FnOnce(T) -> T,
     {
-        let view = io_view::<Self, L::IoType>(self, location.offset())?;
-
-        let value: T = Self::Backend::io_read(view).into();
-        let io_value = f(value).into();
-        Self::Backend::io_write(view, io_value);
-
+        let view = io_view::<Self, T>(self, location.offset())?;
+        view.write_val(f(view.read_val()));
         Ok(())
     }
 
@@ -1029,11 +1113,12 @@ fn try_update<T, L, F>(self, location: L, f: F) -> Result
     #[inline(always)]
     fn read<T, L>(self, location: L) -> T
     where
+        T: IoRepr,
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<<T as IoRepr>::Repr>,
     {
-        let view = io_view_assert::<Self, L::IoType>(self, location.offset());
-        Self::Backend::io_read(view).into()
+        let view = io_view_assert::<Self, T>(self, location.offset());
+        view.read_val()
     }
 
     /// Generic infallible write with compile-time bounds check.
@@ -1060,12 +1145,12 @@ fn read<T, L>(self, location: L) -> T
     #[inline(always)]
     fn write<T, L>(self, location: L, value: T)
     where
+        T: IoRepr,
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<<T as IoRepr>::Repr>,
     {
-        let view = io_view_assert::<Self, L::IoType>(self, location.offset());
-        let io_value = value.into();
-        Self::Backend::io_write(view, io_value);
+        let view = io_view_assert::<Self, T>(self, location.offset());
+        view.write_val(value)
     }
 
     /// Generic infallible write of a fully-located register value.
@@ -1102,9 +1187,10 @@ fn write<T, L>(self, location: L, value: T)
     #[inline(always)]
     fn write_reg<T, L, V>(self, value: V)
     where
+        T: IoRepr,
         L: IoLoc<Self::Target, T>,
         V: LocatedRegister<Self::Target, Location = L, Value = T>,
-        Self::Backend: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<<T as IoRepr>::Repr>,
     {
         let (location, value) = value.into_io_op();
 
@@ -1136,14 +1222,13 @@ fn write_reg<T, L, V>(self, value: V)
     #[inline(always)]
     fn update<T, L, F>(self, location: L, f: F)
     where
+        T: IoRepr,
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<<T as IoRepr>::Repr>,
         F: FnOnce(T) -> T,
     {
-        let view = io_view_assert::<Self, L::IoType>(self, location.offset());
-        let value: T = Self::Backend::io_read(view).into();
-        let io_value = f(value).into();
-        Self::Backend::io_write(view, io_value);
+        let view = io_view_assert::<Self, T>(self, location.offset());
+        view.write_val(f(view.read_val()));
     }
 }
 
diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index 6cb07fc92cc3..d898b2b46d52 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -117,9 +117,6 @@
 
 /// Trait implemented by all registers.
 pub trait Register: Sized {
-    /// Backing primitive type of the register.
-    type Storage: Into<Self> + From<Self>;
-
     /// Start offset of the register.
     ///
     /// The interpretation of this offset depends on the type of the register.
@@ -135,8 +132,6 @@ impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for ()
 where
     T: FixedRegister,
 {
-    type IoType = T::Storage;
-
     #[inline(always)]
     fn offset(self) -> usize {
         T::OFFSET
@@ -149,8 +144,6 @@ impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for T
 where
     T: FixedRegister,
 {
-    type IoType = T::Storage;
-
     #[inline(always)]
     fn offset(self) -> usize {
         T::OFFSET
@@ -174,8 +167,6 @@ impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for FixedRegisterLoc<T>
 where
     T: FixedRegister,
 {
-    type IoType = T::Storage;
-
     #[inline(always)]
     fn offset(self) -> usize {
         T::OFFSET
@@ -246,8 +237,6 @@ impl<const SIZE: usize, T, B> IoLoc<Region<SIZE>, T> for RelativeRegisterLoc<T,
     T: RelativeRegister,
     B: RegisterBase<T::BaseFamily> + ?Sized,
 {
-    type IoType = T::Storage;
-
     #[inline(always)]
     fn offset(self) -> usize {
         RelativeRegisterLoc::offset(self)
@@ -289,8 +278,6 @@ impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for RegisterArrayLoc<T>
 where
     T: RegisterArray,
 {
-    type IoType = T::Storage;
-
     #[inline(always)]
     fn offset(self) -> usize {
         T::OFFSET + self.0 * T::STRIDE
@@ -377,8 +364,6 @@ impl<const SIZE: usize, T, B> IoLoc<Region<SIZE>, T> for RelativeRegisterArrayLo
     T: RelativeRegisterArray,
     B: RegisterBase<T::BaseFamily> + ?Sized,
 {
-    type IoType = T::Storage;
-
     #[inline(always)]
     fn offset(self) -> usize {
         self.0.offset() + self.1 * T::STRIDE
@@ -831,8 +816,8 @@ macro_rules! register {
             { $($fields:tt)* }
     ) => {
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(@io_base $name($storage) @ $offset);
-        $crate::register!(@io_fixed $(#[$attr])* $vis $name($storage));
+        $crate::register!(@io_base $name @ $offset);
+        $crate::register!(@io_fixed $(#[$attr])* $vis $name);
     };
 
     // Creates an alias register of fixed offset register `alias` with its own fields.
@@ -842,10 +827,10 @@ macro_rules! register {
     ) => {
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
         $crate::register!(
-            @io_base $name($storage) @
+            @io_base $name @
             <$alias as $crate::io::register::Register>::OFFSET
         );
-        $crate::register!(@io_fixed $(#[$attr])* $vis $name($storage));
+        $crate::register!(@io_fixed $(#[$attr])* $vis $name);
     };
 
     // Creates a register at a relative offset from a base address provider.
@@ -854,8 +839,8 @@ macro_rules! register {
             { $($fields:tt)* }
     ) => {
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(@io_base $name($storage) @ $offset);
-        $crate::register!(@io_relative $vis $name($storage) @ $base);
+        $crate::register!(@io_base $name @ $offset);
+        $crate::register!(@io_relative $vis $name @ $base);
     };
 
     // Creates an alias register of relative offset register `alias` with its own fields.
@@ -865,9 +850,9 @@ macro_rules! register {
     ) => {
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
         $crate::register!(
-            @io_base $name($storage) @ <$alias as $crate::io::register::Register>::OFFSET
+            @io_base $name @ <$alias as $crate::io::register::Register>::OFFSET
         );
-        $crate::register!(@io_relative $vis $name($storage) @ $base);
+        $crate::register!(@io_relative $vis $name @ $base);
     };
 
     // Creates an array of registers at a fixed offset of the MMIO space.
@@ -878,8 +863,8 @@ macro_rules! register {
         $crate::build_assert::static_assert!(::core::mem::size_of::<$storage>() <= $stride);
 
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(@io_base $name($storage) @ $offset);
-        $crate::register!(@io_array $vis $name($storage) [ $size, stride = $stride ]);
+        $crate::register!(@io_base $name @ $offset);
+        $crate::register!(@io_array $vis $name [ $size, stride = $stride ]);
     };
 
     // Shortcut for contiguous array of registers (stride == size of element).
@@ -904,11 +889,11 @@ macro_rules! register {
 
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
         $crate::register!(
-            @io_base $name($storage) @
+            @io_base $name @
             <$alias as $crate::io::register::Register>::OFFSET
                 + $idx * <$alias as $crate::io::register::RegisterArray>::STRIDE
         );
-        $crate::register!(@io_fixed $(#[$attr])* $vis $name($storage));
+        $crate::register!(@io_fixed $(#[$attr])* $vis $name);
     };
 
     // Creates an array of registers at a relative offset from a base address provider.
@@ -920,9 +905,9 @@ macro_rules! register {
         $crate::build_assert::static_assert!(::core::mem::size_of::<$storage>() <= $stride);
 
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(@io_base $name($storage) @ $offset);
+        $crate::register!(@io_base $name @ $offset);
         $crate::register!(
-            @io_relative_array $vis $name($storage) [ $size, stride = $stride ] @ $base + $offset
+            @io_relative_array $vis $name [ $size, stride = $stride ] @ $base + $offset
         );
     };
 
@@ -949,11 +934,11 @@ macro_rules! register {
 
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
         $crate::register!(
-            @io_base $name($storage) @
+            @io_base $name @
                 <$alias as $crate::io::register::Register>::OFFSET +
                 $idx * <$alias as $crate::io::register::RegisterArray>::STRIDE
         );
-        $crate::register!(@io_relative $vis $name($storage) @ $base);
+        $crate::register!(@io_relative $vis $name @ $base);
     };
 
     // Generates the bitfield for the register.
@@ -970,16 +955,14 @@ macro_rules! register {
     };
 
     // Implementations shared by all registers types.
-    (@io_base $name:ident($storage:ty) @ $offset:expr) => {
+    (@io_base $name:ident @ $offset:expr) => {
         impl $crate::io::register::Register for $name {
-            type Storage = $storage;
-
             const OFFSET: usize = $offset;
         }
     };
 
     // Implementations of fixed registers.
-    (@io_fixed $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)) => {
+    (@io_fixed $(#[$attr:meta])* $vis:vis $name:ident) => {
         impl $crate::io::register::FixedRegister for $name {}
 
         $(#[$attr])*
@@ -988,7 +971,7 @@ impl $crate::io::register::FixedRegister for $name {}
     };
 
     // Implementations of relative registers.
-    (@io_relative $vis:vis $name:ident ($storage:ty) @ $base:ident) => {
+    (@io_relative $vis:vis $name:ident @ $base:ident) => {
         impl $crate::io::register::WithBase for $name {
             type BaseFamily = $base;
         }
@@ -997,7 +980,7 @@ impl $crate::io::register::RelativeRegister for $name {}
     };
 
     // Implementations of register arrays.
-    (@io_array $vis:vis $name:ident ($storage:ty) [ $size:expr, stride = $stride:expr ]) => {
+    (@io_array $vis:vis $name:ident [ $size:expr, stride = $stride:expr ]) => {
         impl $crate::io::register::Array for $name {}
 
         impl $crate::io::register::RegisterArray for $name {
@@ -1008,7 +991,7 @@ impl $crate::io::register::RegisterArray for $name {
 
     // Implementations of relative array registers.
     (
-        @io_relative_array $vis:vis $name:ident ($storage:ty) [ $size:expr, stride = $stride:expr ]
+        @io_relative_array $vis:vis $name:ident [ $size:expr, stride = $stride:expr ]
             @ $base:ident + $offset:literal
     ) => {
         impl $crate::io::register::WithBase for $name {

-- 
2.54.0

