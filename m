Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020102.outbound.protection.outlook.com [52.101.195.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36A745D5E8;
	Wed, 19 Aug 2026 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787137846; cv=fail; b=t+i5jhykhfII1t9lbGDlEFoD0K9zVdJk4oZzM7UTM0EBzNZW0AlFBQbanOo81U8D4GefA/ozTZjcqykgpfrYZLoqrXVq7QFRh0iO1Q+OEIhMQ067y1gbU8G7Gc8e6AwVmU9FfrYBe6ieSIErRCEF+NZgkK6HljeMTUPa7kpod6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787137846; c=relaxed/simple;
	bh=mVBAgfzt49nYUC9KtvB97HmFPe/wUfHuf4347t39LVI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DFOkzzsXI5sgBqyfUBV0uAvsZaoYDEtTJRPL85bfESKKyN4Hq+I356lMduuBPd5FCvSnQ9+Ja4PnotmLi/XS4nPpZJaBmUmz1qFKTHO0k+LwsIRe+SuYVxca0OXmpU9phm4CiiKXMoAjfFI6rODH1nj2ndyQvINp4hYPh3ZulMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=mOS0s9zg; arc=fail smtp.client-ip=52.101.195.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="mOS0s9zg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezdNpazFIycmiEREHutKaEWYbVjlfIOV2Qw4uV6HkjRvgMibVImvkeIhoL0Z5yCioF3tmvnfp65yLrAxv024KKCJ7akN/V39f2wtHft3K5F90AVrNQ5yVOwkMVhqCH2Thw2fBTFKyVJAfu8wczTVBETBhQThQOmmrmqUVi/SDTQlb1EcfXnY5wOqmSFFzbFbmXmKtRtbGmw7K6X/7POgxKrgcFEKYeoaQYg+ajPEQZOlBkyAd5eZDOYQvbeCqn2CcmRztJ0U2d77KSAPdUZTNFEvWrt3fJYv94cPJVmkq1PTuEAWe8LB/7k/BA8EGjcU/uxK/zDPH7Ez3w85P+Nmmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pedHMMSfiAL+Q+nqp507G/ko3vcUafCgveq9BKAgleg=;
 b=W0AP1RJX2hLV5R4zw4AGZn4twVVwpWF+88PML0K2n96PgaKQNHBcC9f+5ZpC9qxw+CZ/EaFbxKWYOKgz/DP0Gu36ttWUug6Xrk7PvgSKSrF0tCArPLFQ3Uwjlklxm2d/C3oQwktEjUfRSJKJEJYbUM9uCwyZBh1CQEPdXcJTyDaFOYTH+883POhN7ZnJJgCS2YlYH9ctx7KqWA39ywK0Nmk/HlA6CM9XHaa5EDuDMB0E9iJrpxkLSnGY4JwZGvyictmz6c0oordHXZlWC0mbUfZSOsPtJJ6K20dPF4HFLkP1wWgWPZpauHCLrQm12XEXlKwrpom1/TmmmqcXQatAzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pedHMMSfiAL+Q+nqp507G/ko3vcUafCgveq9BKAgleg=;
 b=mOS0s9zgPEKeyDgb+yicPQeftx+PDgeitbLpnwDqAQvGiSlk6zQ+lOii6L3RYjtPSmbeMHRMgOE9TBPtDVMDprIbSobcS4jzLHX1lFlERCtTtHvBro8Zolm2vCuPJSGcqoNk+v3WnbUyF0waMTdCjIe09yypEoPm9EjH83PwLzk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO0P265MB5167.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:283::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 11:10:17 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 11:10:17 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 19 Aug 2026 12:09:12 +0100
Subject: [PATCH v3 04/16] rust: io: perform conversions using `AsRepr`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-typed_register-v3-4-3699a75fadf1@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
In-Reply-To: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787137814; l=18533;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=mVBAgfzt49nYUC9KtvB97HmFPe/wUfHuf4347t39LVI=;
 b=FbpHfRxaPe6LALKq/vfg5gH65KpjhrqK7paO5jdo0QnE/b6ubQf2gvTNdRGvgKhr5ubOUktv+
 cEz9qcLiiWmDaMMjoGcAXhmRlfM5J1kI8u33OsFNjyZ7R6dBEuqemg9
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0096.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::11) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO0P265MB5167:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f43b373-375c-47f4-cf4c-08defde2735e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|23010399003|376014|7416014|366016|22082099003|18002099003|921020|10067099003|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	DOX7tVBo5L/hTI04qJ3F5zcD/1lbiMFEaWuAlmrt6Dlg94UEdfkpw4U34BukX7W5R3Zfv1m5LDVLpAhjlLowZTOEJaACE772DGLANbGIZG8mhC6exSXb+Ii4p0awAL38qWvz2r/z9rfvy7ZJLPv9ZGOOgg8HosKhZwo+gTbVzKx0oOW0rxApW1TuMClblfYb+EVjYSQEAbUdpcFyJAbkx1CLooig9uDQgtfSCyHZSAk2AoqUofnjMSepyPQdW0iAXCSgUQBuR5fx5oslVV5/UyZB0Cjjzzi272cFj+ajCl83qbOylbbAdkayFNRHZxD0qkmxcxzTopK2R6VXixAE9OvO2+i6ri51qd7KRxUz1cKIUayJyt1AF3IYzuqCI1gbXaVVO83jnDxB2fpvumdf7RAaY5jbMPBjnHZtpr9Wqg4dEnzqiPCj4pUHGw+GJ1PdIfB+oeclCFmhDbeJbC9iqchGhMxyv5JWjP/K5Nae/lXE82TtIFZjb32OKm9Iikz4n0+0duMQMdZXqZJHjuC4SrpgEwMZqmNRV3TRB9MohlqnHEkT2Wsr627FhEqNjpcrC1jVVdNQ4YzeeznLcT5gy91/dI2gS8IKtTK7j8rb1RqWOetRrQXCUR8Si8GTwunp6UR2rO5AJ0NMOyb4cW+xkWiuWGMYLeX9g0RmE7Qx/CLl7u4WLUInTqH7PYqAmyZ8Ov6FFM/stq1XK4Ry5eeMLA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(23010399003)(376014)(7416014)(366016)(22082099003)(18002099003)(921020)(10067099003)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0Nnby9oQmhrMHJSQXJCelpnSmRQdk9RMStCUC9FQ3ZBejZUSmt2bXFpNUxz?=
 =?utf-8?B?WmZVT2k1Q0RCM08xbEExd210NGdNdW5wUWV6ZXZLRHBsWUJJT0VhY2tsZTdK?=
 =?utf-8?B?bk0wZ3kvbUVqejZrakt1TVprbXZ1aGU2RWJqTTdKbkxRcmRTRy9yR0FCeE11?=
 =?utf-8?B?alppbkN3c1lIR2dVdUM4UDBwUWU2ZDlLdklPZlRXV3dEVlhSM05KOWx1Y21p?=
 =?utf-8?B?NnJDakh5NmJianU4K0Q2VlZzdnJNMk9WK1J5WFhRVVFydy8vcWovbXBKVzVW?=
 =?utf-8?B?RmpjREpsRDdwUjE1WldCYUVadEoxSGJXVnRlbS9hbUhwcDJRaUlOenc0TTZU?=
 =?utf-8?B?QkNVT3dmT2dFTnljRTBDNVphNUFINUZvZVNFTTlNSU5NRjQvWloyYU5TT3M4?=
 =?utf-8?B?Qmh1bVJqbE0xZ0xPS3FlTUFDZkEwK245UDJIWWRHalF6Vk1jYXlLVXNvWVNK?=
 =?utf-8?B?QWhZdVEyd3NHZlVDaTdxQjlvYU5hQ1ZBdWI4cUFNRExic0pJQ2xyTW1rRmFw?=
 =?utf-8?B?WGJDaWR2RGczbWxsSjhhY3BCa0c4RjM5TDgyMGZTRUZXb1Y0ZUcyWmhHM2Fh?=
 =?utf-8?B?TnQ2NERxMHdZU2tRbFFmbVRKZFczQlVHWUlDYjE5K2JNeHBsTC95MnJVaHd4?=
 =?utf-8?B?a0wxblpvNHVSa2JiWW54dGNwTjM2YTB5UWxJRzlJS3BuU0JwazR6TzdJaHFs?=
 =?utf-8?B?NjBhT001bmJ1a013UHNtcUVsTlBMdytMczdRODAxMXVia0I0ZytQYW95K04w?=
 =?utf-8?B?Qm1jYmxmaEU5aHhnd1JNU2lqQ1B6VS9VM2RTWDA2SDlSbUxYd2JFdDdONVZQ?=
 =?utf-8?B?MW9ielhrOFlEL1pudDRNQWxPNlB4MzRLZThvY3ZaQncrTU1VVlJjTmxDVVJF?=
 =?utf-8?B?eFJKb3J2WE0raTJyOFp4NUFGUGl1aUJIUkFJSm5FeDVncHBQR3JmR1ZCUTA0?=
 =?utf-8?B?U0RBdlU3Y2hydWdsQ0tRMUMrUTZwYjArNFNsRGxab0lyQzNJek5yUVZrTUhN?=
 =?utf-8?B?bnZmcEhqUGRqR3hqVEpaTEpneU95b3dMeGxFclVlRmZUT1MvSW90VjRqT0Jk?=
 =?utf-8?B?aW9FTWtMR2NYNmNma2N6eXk1NzJCSVdac3ZjekQwbHNvV2NndXVxb2FXODFQ?=
 =?utf-8?B?VHhTMnhIRFZSVm5Tem9tSzdpLzM1RDVUei9hUnpCMXE5N015UklxcFJNSjZi?=
 =?utf-8?B?dm9yR0hJenFMaHV0L3E4QUtMUGQwOStmUlRUNW94MmZBQ1c2QjRKZW9Cblcr?=
 =?utf-8?B?TlYva0ptd014bnlNdm9pZFpUWC95eTJlRXBKYzVFZjZVb3ltWlBSZEpSd1By?=
 =?utf-8?B?aDlTRjNja0VNVnBaYTdOSW5sb3dnVVhMN1R4OVpYVUFJdEM5K1U2STk1WmlS?=
 =?utf-8?B?NzlXbSt5cVp2U0JCRVdseDI1dTJkQ0liNkwyUXFYb3ArL1VOdFI5OUI3MU5r?=
 =?utf-8?B?ZjB1OFdQRWFTYWRCZlJ5UWJxNFNNZEEvYWF3R1NvMXY5UGgrRGdobytHZnRa?=
 =?utf-8?B?RHVJdFVMK1lXcHVydmpVSG5vVWo3cEE2RzNIUlpIYTdnOE9kU2tLcDhTbng3?=
 =?utf-8?B?WkU5KytCalU0R1V1TlljODY2Sm95VDFIT3VNbUhzdVpIV3NnZXQ1SS83R0Rp?=
 =?utf-8?B?ZWplcGxyVUh4WGs1SWEyOEh0ME9rd1RIdTgzMm9QTGxoN2N0UGhiZ1BFTk1X?=
 =?utf-8?B?WVU0QjVjbkZzaUxrZ2VJb0VJM0hxY3d5MlIwOVFLQmRZbEUrVFhLWlBIM3Nx?=
 =?utf-8?B?M1dvaGRaVWVQVE1XNFl1ZTM5Rzh5b1Rwb0pjVzlBdjFkUE0vQUpHeDRXaHF5?=
 =?utf-8?B?YmJaa0JBakZaUVl2OTFOOVZkZVFaR0VaRDBBQkNsb0ZpcVorSGVmR3N6ekkw?=
 =?utf-8?B?aXZtSmVDZ3NUelVJdHhnMFpTcTVBdFJhajd4NWlzMVhlcExXdkNoSWlQNnRm?=
 =?utf-8?B?cFdiT3RWZWwwbjI5TVhVT0lETXVaTDZnTnljdnVLTFYxbEtzZWlDSWJiY29i?=
 =?utf-8?B?azl1WDhzRGVyeDIvMFB1R0cvYllEUVFkeGI3L3l3ek1JazdXdDE2MndIQ1Nu?=
 =?utf-8?B?MHBlRW1jZHFRbkxMVFRSb0hCdDhXSUhWcmoraTJKNDNQTnM2Q2RRNlBENktI?=
 =?utf-8?B?dlN3YXVMbUpRdzNZa0tNdUtVM1RSdWlwK3dWUkgwRm9WazVoTWNzWDQ3MlFV?=
 =?utf-8?B?b0k2SDJUenhzUy9ub09SOTVteWF2b0JCajgvclUwdmR1c0w1L3pKQ1VaSXpL?=
 =?utf-8?B?cjFTVlFsTnRrT0NxUStmaExDd3lvZmxQMzJ4bUN6M2ZPM21ZdUh3cldkdVpC?=
 =?utf-8?B?eHNMcndCenNxdzUyMFNyM2Qwbi9GY3cxSzhTSElXdVVOMmFadjU3dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f43b373-375c-47f4-cf4c-08defde2735e
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 11:10:17.4311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LarXTmWVsCNKEW2zXsukKtOL55EX+ouBBzGN4L3PmSybaUsbd7k73EJDYtsCFMQMQe93Fc/7qLVfIgG+ZYm69A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5167

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
otherwise available with `io_read!`, `io_write!`. Support this by
performing conversions to I/O primitives via the `AsRepr`/`AsReprMut`
trait.

This makes the `IoLoc::IoType` and `Register::Storage` redundant; thus
remove them; also convert register methods to use the `read_val` and
`write_val` instead.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/bitfield.rs    |  10 ++++
 rust/kernel/io.rs          | 135 +++++++++++++++++++++++++--------------------
 rust/kernel/io/register.rs |  15 -----
 rust/macros/io/register.rs |   2 -
 4 files changed, 86 insertions(+), 76 deletions(-)

diff --git a/rust/kernel/bitfield.rs b/rust/kernel/bitfield.rs
index a0d089423f21..619c5e2189d1 100644
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
@@ -346,6 +347,15 @@ fn from(val: $storage) -> $name {
                 Self::from_raw(val)
             }
         }
+
+        // SAFETY: `$name` is transparent over `$storage`.
+        unsafe impl $crate::mem::AsRepr for $name {
+            // Normalize `$storage` to the canonical repr type in case it is signed.
+            type Repr = <$storage as $crate::mem::AsRepr>::Repr;
+        }
+
+        // SAFETY: `$name` is transparent over `$storage`.
+        unsafe impl $crate::mem::AsReprMut for $name {}
     };
 
     // Definitions requiring knowledge of individual fields: private and public field accessors,
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 5ce9fd129068..6c087d30a166 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -11,6 +11,10 @@
 
 use crate::{
     bindings,
+    mem::{
+        AsRepr,
+        AsReprMut, //
+    },
     prelude::*,
     ptr::{
         Alignment,
@@ -353,15 +357,12 @@ fn copy_write<T: IntoBytes>(view: Self::View<'_, T>, value: T) {
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
+/// AsRepr` bound and the `<T as AsRepr>::Repr` type would be used to perform I/O and converted to
+/// `T` instead.
 pub trait IoLoc<Base: ?Sized, T> {
-    /// Size ([`u8`], [`u16`], etc) of the I/O performed on the returned [`offset`](IoLoc::offset).
-    type IoType: Into<T> + From<T>;
-
     /// Consumes `self` and returns the offset of this location.
     fn offset(self) -> usize;
 }
@@ -372,8 +373,6 @@ macro_rules! impl_usize_ioloc {
     ($($ty:ty),*) => {
         $(
             impl<const SIZE: usize> IoLoc<Region<SIZE>, $ty> for usize {
-                type IoType = $ty;
-
                 #[inline(always)]
                 fn offset(self) -> usize {
                     self
@@ -498,10 +497,19 @@ fn try_cast<U>(self) -> Result<<Self::Backend as IoBackend>::View<'a, U>>
     #[inline]
     fn read_val(self) -> Self::Target
     where
-        Self::Backend: IoCapable<Self::Target>,
-        Self::Target: Sized,
+        Self::Target: AsReprMut,
+        Self::Backend: IoCapable<<Self::Target as AsRepr>::Repr>,
     {
-        Self::Backend::io_read(self.as_view())
+        let view = self.as_view();
+        // SAFETY: `AsRepr` guarantees layout compatibility.
+        let repr_view = unsafe {
+            Self::Backend::project_view(
+                view,
+                Self::Backend::as_ptr(view).cast::<<Self::Target as AsRepr>::Repr>(),
+            )
+        };
+
+        Self::Target::from_repr(Self::Backend::io_read(repr_view))
     }
 
     /// Write a value to I/O.
@@ -520,10 +528,19 @@ fn read_val(self) -> Self::Target
     #[inline]
     fn write_val(self, value: Self::Target)
     where
-        Self::Backend: IoCapable<Self::Target>,
-        Self::Target: Sized,
+        Self::Target: AsRepr,
+        Self::Backend: IoCapable<<Self::Target as AsRepr>::Repr>,
     {
-        Self::Backend::io_write(self.as_view(), value)
+        let view = self.as_view();
+        // SAFETY: `AsRepr` guarantees layout compatibility.
+        let repr_view = unsafe {
+            Self::Backend::project_view(
+                view,
+                Self::Backend::as_ptr(view).cast::<<Self::Target as AsRepr>::Repr>(),
+            )
+        };
+
+        Self::Backend::io_write(repr_view, Self::Target::into_repr(value))
     }
 
     /// Copy-read from I/O memory.
@@ -645,7 +662,7 @@ fn copy_to_slice(self, data: &mut [u8])
     #[inline(always)]
     fn try_read8(self, offset: usize) -> Result<u8>
     where
-        usize: IoLoc<Self::Target, u8, IoType = u8>,
+        usize: IoLoc<Self::Target, u8>,
         Self::Backend: IoCapable<u8>,
     {
         self.try_read(offset)
@@ -655,7 +672,7 @@ fn try_read8(self, offset: usize) -> Result<u8>
     #[inline(always)]
     fn try_read16(self, offset: usize) -> Result<u16>
     where
-        usize: IoLoc<Self::Target, u16, IoType = u16>,
+        usize: IoLoc<Self::Target, u16>,
         Self::Backend: IoCapable<u16>,
     {
         self.try_read(offset)
@@ -665,7 +682,7 @@ fn try_read16(self, offset: usize) -> Result<u16>
     #[inline(always)]
     fn try_read32(self, offset: usize) -> Result<u32>
     where
-        usize: IoLoc<Self::Target, u32, IoType = u32>,
+        usize: IoLoc<Self::Target, u32>,
         Self::Backend: IoCapable<u32>,
     {
         self.try_read(offset)
@@ -675,7 +692,7 @@ fn try_read32(self, offset: usize) -> Result<u32>
     #[inline(always)]
     fn try_read64(self, offset: usize) -> Result<u64>
     where
-        usize: IoLoc<Self::Target, u64, IoType = u64>,
+        usize: IoLoc<Self::Target, u64>,
         Self::Backend: IoCapable<u64>,
     {
         self.try_read(offset)
@@ -685,7 +702,7 @@ fn try_read64(self, offset: usize) -> Result<u64>
     #[inline(always)]
     fn try_write8(self, value: u8, offset: usize) -> Result
     where
-        usize: IoLoc<Self::Target, u8, IoType = u8>,
+        usize: IoLoc<Self::Target, u8>,
         Self::Backend: IoCapable<u8>,
     {
         self.try_write(offset, value)
@@ -695,7 +712,7 @@ fn try_write8(self, value: u8, offset: usize) -> Result
     #[inline(always)]
     fn try_write16(self, value: u16, offset: usize) -> Result
     where
-        usize: IoLoc<Self::Target, u16, IoType = u16>,
+        usize: IoLoc<Self::Target, u16>,
         Self::Backend: IoCapable<u16>,
     {
         self.try_write(offset, value)
@@ -705,7 +722,7 @@ fn try_write16(self, value: u16, offset: usize) -> Result
     #[inline(always)]
     fn try_write32(self, value: u32, offset: usize) -> Result
     where
-        usize: IoLoc<Self::Target, u32, IoType = u32>,
+        usize: IoLoc<Self::Target, u32>,
         Self::Backend: IoCapable<u32>,
     {
         self.try_write(offset, value)
@@ -715,7 +732,7 @@ fn try_write32(self, value: u32, offset: usize) -> Result
     #[inline(always)]
     fn try_write64(self, value: u64, offset: usize) -> Result
     where
-        usize: IoLoc<Self::Target, u64, IoType = u64>,
+        usize: IoLoc<Self::Target, u64>,
         Self::Backend: IoCapable<u64>,
     {
         self.try_write(offset, value)
@@ -727,7 +744,7 @@ fn try_write64(self, value: u64, offset: usize) -> Result
     #[inline(always)]
     fn read8(self, offset: usize) -> u8
     where
-        usize: IoLoc<Self::Target, u8, IoType = u8>,
+        usize: IoLoc<Self::Target, u8>,
         Self::Backend: IoCapable<u8>,
     {
         self.read(offset)
@@ -739,7 +756,7 @@ fn read8(self, offset: usize) -> u8
     #[inline(always)]
     fn read16(self, offset: usize) -> u16
     where
-        usize: IoLoc<Self::Target, u16, IoType = u16>,
+        usize: IoLoc<Self::Target, u16>,
         Self::Backend: IoCapable<u16>,
     {
         self.read(offset)
@@ -751,7 +768,7 @@ fn read16(self, offset: usize) -> u16
     #[inline(always)]
     fn read32(self, offset: usize) -> u32
     where
-        usize: IoLoc<Self::Target, u32, IoType = u32>,
+        usize: IoLoc<Self::Target, u32>,
         Self::Backend: IoCapable<u32>,
     {
         self.read(offset)
@@ -763,7 +780,7 @@ fn read32(self, offset: usize) -> u32
     #[inline(always)]
     fn read64(self, offset: usize) -> u64
     where
-        usize: IoLoc<Self::Target, u64, IoType = u64>,
+        usize: IoLoc<Self::Target, u64>,
         Self::Backend: IoCapable<u64>,
     {
         self.read(offset)
@@ -775,7 +792,7 @@ fn read64(self, offset: usize) -> u64
     #[inline(always)]
     fn write8(self, value: u8, offset: usize)
     where
-        usize: IoLoc<Self::Target, u8, IoType = u8>,
+        usize: IoLoc<Self::Target, u8>,
         Self::Backend: IoCapable<u8>,
     {
         self.write(offset, value)
@@ -787,7 +804,7 @@ fn write8(self, value: u8, offset: usize)
     #[inline(always)]
     fn write16(self, value: u16, offset: usize)
     where
-        usize: IoLoc<Self::Target, u16, IoType = u16>,
+        usize: IoLoc<Self::Target, u16>,
         Self::Backend: IoCapable<u16>,
     {
         self.write(offset, value)
@@ -799,7 +816,7 @@ fn write16(self, value: u16, offset: usize)
     #[inline(always)]
     fn write32(self, value: u32, offset: usize)
     where
-        usize: IoLoc<Self::Target, u32, IoType = u32>,
+        usize: IoLoc<Self::Target, u32>,
         Self::Backend: IoCapable<u32>,
     {
         self.write(offset, value)
@@ -811,7 +828,7 @@ fn write32(self, value: u32, offset: usize)
     #[inline(always)]
     fn write64(self, value: u64, offset: usize)
     where
-        usize: IoLoc<Self::Target, u64, IoType = u64>,
+        usize: IoLoc<Self::Target, u64>,
         Self::Backend: IoCapable<u64>,
     {
         self.write(offset, value)
@@ -843,11 +860,12 @@ fn write64(self, value: u64, offset: usize)
     #[inline(always)]
     fn try_read<T, L>(self, location: L) -> Result<T>
     where
+        T: AsReprMut,
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<<T as AsRepr>::Repr>,
     {
-        let view = io_view::<Self, L::IoType>(self, location.offset())?;
-        Ok(Self::Backend::io_read(view).into())
+        let view = io_view::<Self, T>(self, location.offset())?;
+        Ok(view.read_val())
     }
 
     /// Generic fallible write with runtime bounds check.
@@ -876,12 +894,12 @@ fn try_read<T, L>(self, location: L) -> Result<T>
     #[inline(always)]
     fn try_write<T, L>(self, location: L, value: T) -> Result
     where
+        T: AsRepr,
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<<T as AsRepr>::Repr>,
     {
-        let view = io_view::<Self, L::IoType>(self, location.offset())?;
-        let io_value = value.into();
-        Self::Backend::io_write(view, io_value);
+        let view = io_view::<Self, T>(self, location.offset())?;
+        view.write_val(value);
         Ok(())
     }
 
@@ -920,9 +938,10 @@ fn try_write<T, L>(self, location: L, value: T) -> Result
     #[inline(always)]
     fn try_write_reg<T, L, V>(self, value: V) -> Result
     where
+        T: AsRepr,
         L: IoLoc<Self::Target, T>,
         V: LocatedRegister<Self::Target, Location = L, Value = T>,
-        Self::Backend: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<<T as AsRepr>::Repr>,
     {
         let (location, value) = value.into_io_op();
 
@@ -954,16 +973,13 @@ fn try_write_reg<T, L, V>(self, value: V) -> Result
     #[inline(always)]
     fn try_update<T, L, F>(self, location: L, f: F) -> Result
     where
+        T: AsReprMut,
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<<T as AsRepr>::Repr>,
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
 
@@ -991,11 +1007,12 @@ fn try_update<T, L, F>(self, location: L, f: F) -> Result
     #[inline(always)]
     fn read<T, L>(self, location: L) -> T
     where
+        T: AsReprMut,
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<<T as AsRepr>::Repr>,
     {
-        let view = io_view_assert::<Self, L::IoType>(self, location.offset());
-        Self::Backend::io_read(view).into()
+        let view = io_view_assert::<Self, T>(self, location.offset());
+        view.read_val()
     }
 
     /// Generic infallible write with compile-time bounds check.
@@ -1022,12 +1039,12 @@ fn read<T, L>(self, location: L) -> T
     #[inline(always)]
     fn write<T, L>(self, location: L, value: T)
     where
+        T: AsRepr,
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<<T as AsRepr>::Repr>,
     {
-        let view = io_view_assert::<Self, L::IoType>(self, location.offset());
-        let io_value = value.into();
-        Self::Backend::io_write(view, io_value);
+        let view = io_view_assert::<Self, T>(self, location.offset());
+        view.write_val(value)
     }
 
     /// Generic infallible write of a fully-located register value.
@@ -1064,9 +1081,10 @@ fn write<T, L>(self, location: L, value: T)
     #[inline(always)]
     fn write_reg<T, L, V>(self, value: V)
     where
+        T: AsRepr,
         L: IoLoc<Self::Target, T>,
         V: LocatedRegister<Self::Target, Location = L, Value = T>,
-        Self::Backend: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<<T as AsRepr>::Repr>,
     {
         let (location, value) = value.into_io_op();
 
@@ -1098,14 +1116,13 @@ fn write_reg<T, L, V>(self, value: V)
     #[inline(always)]
     fn update<T, L, F>(self, location: L, f: F)
     where
+        T: AsReprMut,
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoCapable<L::IoType>,
+        Self::Backend: IoCapable<<T as AsRepr>::Repr>,
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
index 6a19552ffb95..45d2e73a92e7 100644
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
diff --git a/rust/macros/io/register.rs b/rust/macros/io/register.rs
index 61d076ab570a..8af12caa964b 100644
--- a/rust/macros/io/register.rs
+++ b/rust/macros/io/register.rs
@@ -200,8 +200,6 @@ pub(crate) fn register(def: RegDef) -> Result<TokenStream> {
             );
 
             impl ::kernel::io::register::Register for #name {
-                type Storage = #storage;
-
                 const OFFSET: usize = #offset;
             }
         ));

-- 
2.54.0

