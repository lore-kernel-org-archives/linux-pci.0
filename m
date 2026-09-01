Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020089.outbound.protection.outlook.com [52.101.196.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CDF484255;
	Tue,  1 Sep 2026 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281447; cv=fail; b=V7f2shaUUPq35fmDDFsuJsWVbB8h2uGyzGuAnV2Ohp7any9bZKzV7wv4efkj1AtI0LV8T3rlWnA71pYeTfuvwokWNq/sP27OiqqR/JLxI/uw98ZNZtsday4DKhIxBlHCc0cW6Hqn27C3ivfgLGmcqL5VGtCTIuwHhHusW8mJuNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281447; c=relaxed/simple;
	bh=a4e0IW7uOdgVQTyEzPyQL8e411BYAWC48EB6qOIO1d8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mgGM1Mx2F1/Np6SL0FIIgzwyBATBGYicls9DkHKL7o1yIUjuq9RoWK8/v56E7Em8RgueKL9LORklmA+BsLTakLqMatTEgH9fie29bYwsPme4OCyNPqZUfOWomQiHdSbgcRZdRIpXj+IxvRttROdCGbXlbuQ4Q+JarebhKKgzD44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=TEr9m4EL; arc=fail smtp.client-ip=52.101.196.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="TEr9m4EL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQ4ofD/ecyR+qtWKjVxAPyO4DKorOeZKCs9638HX3EZBRX9cQLnI5h95VIW2MpooS4F3JhOUMCFCuULCbmIQdGj/F3U82t6vaMNivwsYj1geRO1GZDV2nyuZQ8aJHBSuOc4mr/5GAb0RJaOVkHnQ0RA1gU3c40c4sujkPfm14Zjb+1BbMkJ4Zg2tOqkyQp498ZbR5HZXBkYJEbs2ynASC8m46VyTOkbQHs7ZzFZEiPiqrqagQUlRAke9NJidr0a1IceFs/TRgDMXIwvaSvMqwGtCoU/xz/Iw3uq/9p7ktRPTtqxzfETnQL8SQnV9EVZqCXXKTXFms9yDv92hbbxNaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DEKIwi5XRlMtlt/hNGKxVbZBbR6FHV50Rhc592Fzww=;
 b=cmo77OThY5Pav47wpF+TgeTtRCgi2UV8Sb9clQG+3HY61JerDMtETb83U/3t5kiZIdSqGxqlRzPeL8BUhUNUIiub83KLapGEGRfn1QZFCZyI8ybXxrpREBxLB4aV3PbFxPKiG5wOKsPgVl1W/MUbgNo5A6hk56IRd882q/KtFXprvvb7lpXNXZNAW7bK8Hj5gdkRW4ALFV98wpiQf/HU0Vxhnxe2iWgwn0jkQ4ySEQ19Z/7aL0XBKAPXnZbYg77tcb8ghEfQiRgF1V0PmvDeiRWnol8GNtuR09bbVHyG7DgDwTG518aQtMFs0S66PMUTTx34puvbk/UGf+lGDah3mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DEKIwi5XRlMtlt/hNGKxVbZBbR6FHV50Rhc592Fzww=;
 b=TEr9m4ELenwK36xlSKUYV5QS3LW2YU1C/eK1SXdbzglnkfgoWyFVChI5Ugh6W7T33owIDtqkPI4fh/sdLkUoYLrhF6nlH7GGrgaOsN5qYq1Kie4nyXEPN3wc/eUQVRGBU57fCI6rUDacp/rnEDvqSsuDNqjQYsQ21CBAJsbZUlg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO0P265MB7316.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ef::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 16:50:36 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 16:50:36 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 01 Sep 2026 17:50:28 +0100
Subject: [PATCH v4 04/16] rust: io: perform conversions using `AsRepr`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-typed_register-v4-4-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
In-Reply-To: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788281431; l=18332;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=a4e0IW7uOdgVQTyEzPyQL8e411BYAWC48EB6qOIO1d8=;
 b=wFxuX2Fy0md6c2KfGcum6OOQ/wuh4+GStOBNPLd7ztoe4Vr7TkLJ9gIQNz+nqVESmIwHHe/lD
 xt0HOgwRKxIB7kbwIwCrZ062pjVFPLu2W0TExbdcx50iFxHy57Ha/KY
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: PAZP264CA0173.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:236::16) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO0P265MB7316:EE_
X-MS-Office365-Filtering-Correlation-Id: e2558477-487b-49ab-94ff-08df0849253e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|10070799003|376014|7416014|10067099003|6133799003|22082099003|56012099006|5023799004|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	80FzFT4d9/i93bE/YA12pc6NYrS/+WzKhZzetusG5/PD+UTCGwn0BuSYLxaq19x0M7fjiCaw270kFzBFH5n2EHPiV7Ulia9cUy5YZbpTxbi0SaYIPOJGjoK9LeUMWzFWMVG5/+OZ7QZf7Ix+50SoK8KfSKVNq78wmf6tSFNYhXsVIene5csO0YkgERBh5ZzuP7+72ujUTPk8gJmPfwc6rnzAlwSO1aHONYQ9d6khXFOONncg3626ezjgxN+Y+WhaVoxxJTfazy/BRoa8ag0N22U8NHzOL1HQFLw6ArrwK2GvlFPBGe3vkYltwvnh3X+7vqXvcfjVdMZKyaqUFYDhFCahVyhx9qy8BkVDWjU1XF9Xobv91zaMFu2lCw3ab+wWTig7aiOtcOeGMPYpm/yuEIiVWftrIIaGInEZc7sTcn47NNh/+0pGEhthpedhbZ6N/R/Sz4P6whW0QMuWU0xNjlPKXHIFF7OKxrrlm4V1hzJZsVmW9sAU7l256YJAVnUZc34VwrDmC66pLehcYlWZAoh/49a14WYhoo5yygsC8a9AwYiZLKQWfIoUQxPW+pj+bduCm0nUQwuYYJqOKHF8mOu+0sGErohnPo8Yv2t8pvavNgd3GnGXOnv0bvGim1If0FKZ0ruDgOyPL2dJjTEQ6iorGxBuyvpXVvfAqoh2fO2DWyPkvZKGA8qg60GWu1GumiM2CiEY2VesL69iHRimmg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(376014)(7416014)(10067099003)(6133799003)(22082099003)(56012099006)(5023799004)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkExa0hNRGVoWlBNeGMzS3l2Q0V3LzdGRTg1T2YxQXJZZFNFN1lLVmtHWjBJ?=
 =?utf-8?B?Vkl0cVM5RVYyQW9HbE5vSC9uTGZ2RXg3T1NsU1h0Z0ZGd3lNV0dlejhGelhw?=
 =?utf-8?B?eVBPeGNvT2kyN0ZtcmlNUmp2ZDlFZU91a2lLdjcxQnI4c1h1VDY4QzEyV3Ns?=
 =?utf-8?B?Z3dvRkZPSnRWblRPMlA0UGZBSk9OaWZWLyswZ0NKT3lZQXJkSmdNVHlLLyt0?=
 =?utf-8?B?Nm0rTVZxWS9IeUhjWG14YXZjdDEraVpPYlFzcE5OYSs5UW5NU2FZdi9RWGli?=
 =?utf-8?B?OEVaSzFyMmtoZzNlUDUrVWt1SHVrSCtxMTYvNHVZYXI4NDdQeGlXRFNxMmhp?=
 =?utf-8?B?bXI1RVNXV1ZKOHFQdDdkUEI1cUlMMVVKdzVVMGhKT084M20wUWpRL3IwWlI5?=
 =?utf-8?B?emFnUUxVWmZuS3FndHNFemIvcWFFcVhUVnZ3Yk9RUFFPM1FaNXU1d0hSNys3?=
 =?utf-8?B?Qk1RaUJQdGZySGpWUVR6OS9VTGpKT1V6eFlCVk9lUDZOOEl0OWJYOVlTRE5h?=
 =?utf-8?B?QjRVZjRUQ1RlWEVFbUtuWUxLUE04UTlIek8wa0xFbUFlY2dFSThZS1VGMTN3?=
 =?utf-8?B?TVBMUWVFOGFrdlZ1RlBXb2EyejIzK0hWaVBBcDhFUXFRUTJzd0JSbVpxYm5i?=
 =?utf-8?B?K3oyaTVXYjNUUzJVdTJ0YXlReVdwSk83bStVeUdKUXJZWFlTcDZhdG1ObUFM?=
 =?utf-8?B?bXNmNGtwN3BWNTBIU0VFRFZ2aldyR3dTekFHWC9zTTA1RFdOKzR2VFFlR3pU?=
 =?utf-8?B?M0hwN3ovSHR5eHF6a0Ztd3hEZjh2Qm1uMzZaaGVoWFU2NVlHd0dnSjRVQjg0?=
 =?utf-8?B?alhzZGQ4TkkvNy9JRndoV3RISlNZd0VtenY5ZlUyNWFCVkNLUEwvYituTis4?=
 =?utf-8?B?VWZzQit2U0pVdytmaDY2MFU1MVRZVEhIVk95NTBlQjNEeG8yZ0xrZGIxVE5m?=
 =?utf-8?B?eHk4RDl5YjlLVmhzZGNLVUtzUjZzS0FEMlNkcVRzYjIzWlp1RURMV3lPaGpI?=
 =?utf-8?B?ZFlXRmt3c2F1V0RIYURWOUJoQVJWNE1aYW4xWjBuK3lVZGNUa0dOVk9uYi9N?=
 =?utf-8?B?cDJqa2VZMWVmWmtCQVJWZS9LTXZUWFEyR2hnbkdsbkw5QlNCK0NIWVRQayts?=
 =?utf-8?B?SFNnblZ1eDZEYVhDVlc2bTlBWDNZUE9EcTZUZGVTQTV0RnNWcVQ0Z2lmOURM?=
 =?utf-8?B?Uzh1ZldtRDNwZ2xlZ3JyTXNqdE5BOEU0cmx2R1lSajdGNGd3VUVLQkNNWVBs?=
 =?utf-8?B?ZlFDT0pjYWRIYjFsaUdpOHdXU210N2pTREZ0d1NiOTlQdHFGTkJta2YxNVIy?=
 =?utf-8?B?U1NIT3IrSmZBRXU0dnE5NUNaUTAxc253UmNoMElDTVVEeFZYdjVwSVFFcTR4?=
 =?utf-8?B?blNBWmRFa2FLM0RSZUZIVGlMSDM5WHROQTJRZUQ0VFRsMDZJb3dDK2JJRHo2?=
 =?utf-8?B?d0hNRzRNdTAzT0c3K3RYc0p1OXhEcUJmM2txMzVMNDA2RWlkdG5ocUJGVFJX?=
 =?utf-8?B?ZnlzQ0xkYTl6ZVJ3cUI5U2FicFU4OHhPc3FOVFZEL0FOeFpmY0ozdW4zazd4?=
 =?utf-8?B?bWFsQVZiSXRnMktrZEt1aXlnUmkrc1FQZ1ZGQ1JqYTFvU2pZRk00ak1hanp4?=
 =?utf-8?B?MHVQbUNDaDNlSGNobHgzVFYvM0hXMkE1R1F2dUVqYUZ5L0hhRHl6V01FT256?=
 =?utf-8?B?WGV3NkhzcC9Cc0FCeDZTUUEwalRCenpoQk5vNkZZT2RqckJPM1I3YXpZQ0Rp?=
 =?utf-8?B?M0pOVzk0RUFYTmlTeVlwWWlXRHo0S3FVcXpHbGVnazc1aHNlUWREMmZKblpn?=
 =?utf-8?B?NTRwOXRUSW1oL21FOFdidjVtREVRY29LREtIWTBycVh6TUdHb2V6dTlZeVdM?=
 =?utf-8?B?VDRBR2JJV2xvQWZ0czVuZ3JtU3FCNUVwZjRsOHlNODlKQUp2WTE3UjFaMnJ2?=
 =?utf-8?B?Y0YxMHh0MnlMNVVwV2F2K29jYks2MVJLeFdTZENiV1ZmaHhsRXJPRGlHb2c5?=
 =?utf-8?B?K1NsRkw0QlB3ZXorZVZoWitYelhETGhGM1lBdndjZ09vNWRiT2p3U0ZtbFc0?=
 =?utf-8?B?L1F3dlg2SklWSWNobm9mNjhNMGdURmpQb2RNSTh1WGFWN0pHMGhoUVVxRHZ3?=
 =?utf-8?B?cUs0S2RuRjVBRnV6aWQ4N3ZQUUtCd29qQXFuanRBNmQrWHlTZFNoclpsMjh5?=
 =?utf-8?B?OFNiVVNUMU9BbW9uN1JHOXM3U2hKb1BsczBUWUxMV3h4RHpwWXpIalZjY3lK?=
 =?utf-8?B?N3NYSnFjaUhUM2o3SUs1UVFhbDNEektLdjBNZUlpbHJscGpZMXVCVWxCSlpi?=
 =?utf-8?B?V085ZjJMc1hwaVRQdlFMYWlmdkJubUM3dERObzUzQ3hOcExBdHo2Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e2558477-487b-49ab-94ff-08df0849253e
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 16:50:36.1403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yp1b+7tQKBbeJ9o+FybnDV4pYfjgIq8m567VNh6xtp21VLULfGxBSNoWBG35hT2NiXK5R5bHIgBGuFo4Bjcu0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB7316

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

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/bitfield.rs    |   9 ++++
 rust/kernel/io.rs          | 128 ++++++++++++++++++++++++---------------------
 rust/kernel/io/register.rs |  15 ------
 rust/macros/io/register.rs |   2 -
 4 files changed, 78 insertions(+), 76 deletions(-)

diff --git a/rust/kernel/bitfield.rs b/rust/kernel/bitfield.rs
index a0d089423f21..15c78790e151 100644
--- a/rust/kernel/bitfield.rs
+++ b/rust/kernel/bitfield.rs
@@ -346,6 +346,15 @@ fn from(val: $storage) -> $name {
                 Self::from_raw(val)
             }
         }
+
+        // SAFETY: `$name` is transparent over `$storage` and `$storage` has no interior mutability.
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
index 5ce9fd129068..18c71bd765b2 100644
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
@@ -226,6 +230,17 @@ fn io_view<'a, IO: Io<'a>, U>(
     Ok(unsafe { IO::Backend::project_view(view, projected_ptr) })
 }
 
+/// Returns the primitive view of a I/O view.
+#[inline]
+fn io_view_as_repr<'a, IO: Io<'a, Target = T>, T: AsRepr>(
+    this: IO,
+) -> <IO::Backend as IoBackend>::View<'a, T::Repr> {
+    let view = this.as_view();
+
+    // SAFETY: `AsRepr` guarantees layout compatibility.
+    unsafe { IO::Backend::project_view(view, IO::Backend::as_ptr(view).cast::<T::Repr>()) }
+}
+
 /// I/O backends.
 ///
 /// This is an abstract representation to be implemented by arbitrary I/O
@@ -353,15 +368,12 @@ fn copy_write<T: IntoBytes>(view: Self::View<'_, T>, value: T) {
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
@@ -372,8 +384,6 @@ macro_rules! impl_usize_ioloc {
     ($($ty:ty),*) => {
         $(
             impl<const SIZE: usize> IoLoc<Region<SIZE>, $ty> for usize {
-                type IoType = $ty;
-
                 #[inline(always)]
                 fn offset(self) -> usize {
                     self
@@ -498,10 +508,10 @@ fn try_cast<U>(self) -> Result<<Self::Backend as IoBackend>::View<'a, U>>
     #[inline]
     fn read_val(self) -> Self::Target
     where
-        Self::Backend: IoCapable<Self::Target>,
-        Self::Target: Sized,
+        Self::Target: AsReprMut,
+        Self::Backend: IoCapable<<Self::Target as AsRepr>::Repr>,
     {
-        Self::Backend::io_read(self.as_view())
+        Self::Target::from_repr(Self::Backend::io_read(io_view_as_repr(self)))
     }
 
     /// Write a value to I/O.
@@ -520,10 +530,10 @@ fn read_val(self) -> Self::Target
     #[inline]
     fn write_val(self, value: Self::Target)
     where
-        Self::Backend: IoCapable<Self::Target>,
-        Self::Target: Sized,
+        Self::Target: AsRepr,
+        Self::Backend: IoCapable<<Self::Target as AsRepr>::Repr>,
     {
-        Self::Backend::io_write(self.as_view(), value)
+        Self::Backend::io_write(io_view_as_repr(self), Self::Target::into_repr(value))
     }
 
     /// Copy-read from I/O memory.
@@ -645,7 +655,7 @@ fn copy_to_slice(self, data: &mut [u8])
     #[inline(always)]
     fn try_read8(self, offset: usize) -> Result<u8>
     where
-        usize: IoLoc<Self::Target, u8, IoType = u8>,
+        usize: IoLoc<Self::Target, u8>,
         Self::Backend: IoCapable<u8>,
     {
         self.try_read(offset)
@@ -655,7 +665,7 @@ fn try_read8(self, offset: usize) -> Result<u8>
     #[inline(always)]
     fn try_read16(self, offset: usize) -> Result<u16>
     where
-        usize: IoLoc<Self::Target, u16, IoType = u16>,
+        usize: IoLoc<Self::Target, u16>,
         Self::Backend: IoCapable<u16>,
     {
         self.try_read(offset)
@@ -665,7 +675,7 @@ fn try_read16(self, offset: usize) -> Result<u16>
     #[inline(always)]
     fn try_read32(self, offset: usize) -> Result<u32>
     where
-        usize: IoLoc<Self::Target, u32, IoType = u32>,
+        usize: IoLoc<Self::Target, u32>,
         Self::Backend: IoCapable<u32>,
     {
         self.try_read(offset)
@@ -675,7 +685,7 @@ fn try_read32(self, offset: usize) -> Result<u32>
     #[inline(always)]
     fn try_read64(self, offset: usize) -> Result<u64>
     where
-        usize: IoLoc<Self::Target, u64, IoType = u64>,
+        usize: IoLoc<Self::Target, u64>,
         Self::Backend: IoCapable<u64>,
     {
         self.try_read(offset)
@@ -685,7 +695,7 @@ fn try_read64(self, offset: usize) -> Result<u64>
     #[inline(always)]
     fn try_write8(self, value: u8, offset: usize) -> Result
     where
-        usize: IoLoc<Self::Target, u8, IoType = u8>,
+        usize: IoLoc<Self::Target, u8>,
         Self::Backend: IoCapable<u8>,
     {
         self.try_write(offset, value)
@@ -695,7 +705,7 @@ fn try_write8(self, value: u8, offset: usize) -> Result
     #[inline(always)]
     fn try_write16(self, value: u16, offset: usize) -> Result
     where
-        usize: IoLoc<Self::Target, u16, IoType = u16>,
+        usize: IoLoc<Self::Target, u16>,
         Self::Backend: IoCapable<u16>,
     {
         self.try_write(offset, value)
@@ -705,7 +715,7 @@ fn try_write16(self, value: u16, offset: usize) -> Result
     #[inline(always)]
     fn try_write32(self, value: u32, offset: usize) -> Result
     where
-        usize: IoLoc<Self::Target, u32, IoType = u32>,
+        usize: IoLoc<Self::Target, u32>,
         Self::Backend: IoCapable<u32>,
     {
         self.try_write(offset, value)
@@ -715,7 +725,7 @@ fn try_write32(self, value: u32, offset: usize) -> Result
     #[inline(always)]
     fn try_write64(self, value: u64, offset: usize) -> Result
     where
-        usize: IoLoc<Self::Target, u64, IoType = u64>,
+        usize: IoLoc<Self::Target, u64>,
         Self::Backend: IoCapable<u64>,
     {
         self.try_write(offset, value)
@@ -727,7 +737,7 @@ fn try_write64(self, value: u64, offset: usize) -> Result
     #[inline(always)]
     fn read8(self, offset: usize) -> u8
     where
-        usize: IoLoc<Self::Target, u8, IoType = u8>,
+        usize: IoLoc<Self::Target, u8>,
         Self::Backend: IoCapable<u8>,
     {
         self.read(offset)
@@ -739,7 +749,7 @@ fn read8(self, offset: usize) -> u8
     #[inline(always)]
     fn read16(self, offset: usize) -> u16
     where
-        usize: IoLoc<Self::Target, u16, IoType = u16>,
+        usize: IoLoc<Self::Target, u16>,
         Self::Backend: IoCapable<u16>,
     {
         self.read(offset)
@@ -751,7 +761,7 @@ fn read16(self, offset: usize) -> u16
     #[inline(always)]
     fn read32(self, offset: usize) -> u32
     where
-        usize: IoLoc<Self::Target, u32, IoType = u32>,
+        usize: IoLoc<Self::Target, u32>,
         Self::Backend: IoCapable<u32>,
     {
         self.read(offset)
@@ -763,7 +773,7 @@ fn read32(self, offset: usize) -> u32
     #[inline(always)]
     fn read64(self, offset: usize) -> u64
     where
-        usize: IoLoc<Self::Target, u64, IoType = u64>,
+        usize: IoLoc<Self::Target, u64>,
         Self::Backend: IoCapable<u64>,
     {
         self.read(offset)
@@ -775,7 +785,7 @@ fn read64(self, offset: usize) -> u64
     #[inline(always)]
     fn write8(self, value: u8, offset: usize)
     where
-        usize: IoLoc<Self::Target, u8, IoType = u8>,
+        usize: IoLoc<Self::Target, u8>,
         Self::Backend: IoCapable<u8>,
     {
         self.write(offset, value)
@@ -787,7 +797,7 @@ fn write8(self, value: u8, offset: usize)
     #[inline(always)]
     fn write16(self, value: u16, offset: usize)
     where
-        usize: IoLoc<Self::Target, u16, IoType = u16>,
+        usize: IoLoc<Self::Target, u16>,
         Self::Backend: IoCapable<u16>,
     {
         self.write(offset, value)
@@ -799,7 +809,7 @@ fn write16(self, value: u16, offset: usize)
     #[inline(always)]
     fn write32(self, value: u32, offset: usize)
     where
-        usize: IoLoc<Self::Target, u32, IoType = u32>,
+        usize: IoLoc<Self::Target, u32>,
         Self::Backend: IoCapable<u32>,
     {
         self.write(offset, value)
@@ -811,7 +821,7 @@ fn write32(self, value: u32, offset: usize)
     #[inline(always)]
     fn write64(self, value: u64, offset: usize)
     where
-        usize: IoLoc<Self::Target, u64, IoType = u64>,
+        usize: IoLoc<Self::Target, u64>,
         Self::Backend: IoCapable<u64>,
     {
         self.write(offset, value)
@@ -843,11 +853,12 @@ fn write64(self, value: u64, offset: usize)
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
@@ -876,12 +887,12 @@ fn try_read<T, L>(self, location: L) -> Result<T>
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
 
@@ -920,9 +931,10 @@ fn try_write<T, L>(self, location: L, value: T) -> Result
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
 
@@ -954,16 +966,13 @@ fn try_write_reg<T, L, V>(self, value: V) -> Result
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
 
@@ -991,11 +1000,12 @@ fn try_update<T, L, F>(self, location: L, f: F) -> Result
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
@@ -1022,12 +1032,12 @@ fn read<T, L>(self, location: L) -> T
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
@@ -1064,9 +1074,10 @@ fn write<T, L>(self, location: L, value: T)
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
 
@@ -1098,14 +1109,13 @@ fn write_reg<T, L, V>(self, value: V)
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
index 83ba4dd75ab3..9b92c8099edd 100644
--- a/rust/macros/io/register.rs
+++ b/rust/macros/io/register.rs
@@ -213,8 +213,6 @@ pub(crate) fn register(def: RegDef) -> Result<TokenStream> {
             );
 
             impl ::kernel::io::register::Register for #name {
-                type Storage = #storage;
-
                 const OFFSET: usize = #offset;
             }
         ));

-- 
2.54.0

