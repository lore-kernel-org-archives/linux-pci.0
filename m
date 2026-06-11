Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022106.outbound.protection.outlook.com [52.101.101.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E718480946;
	Thu, 11 Jun 2026 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195325; cv=fail; b=Gpg4rJvAw5DGbxPjb3GDyVtAigzSY5H5Etuw56WssUA+f0uR29R5iPDSr8h4ChnhYToSty2IVpIuJUPDIz1NHboraI000mC2LSde91i+kZ3U6uVFGARHHSnY4xVLZy1B31uBCDbtawWMpjZa0VkmWVlokUWOiXydGlIWgOXZwCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195325; c=relaxed/simple;
	bh=0Ouuv4rEG6K7m1QcFobtEFBysyYvLBM3w06T/IkWO7k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=X9oC6JLYWKbpu7YI5tNhqC2Yid1VYfa6XPAReaoz/26ofIWO5z5BwsrR2c/U1NQM90SjX2c/pmr/SebJH0B0oqtAm3y9iepwbPMMPExrM63MEmFOBWSD3YMrIIOYmEChf/tWFMD1blVmezPll0ykdLrc42DMOEyFpnKG7AKXemU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=RfhFR61D; arc=fail smtp.client-ip=52.101.101.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="RfhFR61D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wmAz35V88emDkO3UaNmFVMe8/BdGMnGei8hR4bfAqmcYBxUZHEPPdIsCZydvEwmrVGsM09v1E6vBhNMgR4JwXDCEzeGBNYOM42eYxTQ0N1VgM8iF1Gn5hq084sisqsbmnkCdGYQ+ks/apNwlPf8+5eJ+CxheioC7D9fES1SokmuGQAfy9xRtobekMGpRBm1s8D+4nhxB8FQ7X2MOY4DG5bartghnqQC5WYNXjNMMNLDGUPY1XL3k7+Nas76w/Awm3YZ+aiad+J6nijx130LlaiTzwI9rqWjHq0ksPCUz0rBsn/v176nYlBbarW/c48tjBPjWFnbmMzJTmrS6INpBWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKy/1dqDfkwi8oiOKg7Hf6ZEHqb7O3P6mPojB/g7VmM=;
 b=PoLFVQEks+qA/I9owVIRJR1eSdptkteMbJWjBzPvli9/jj6rXm9HdSbJKCt3TqD6F84+QuFhCpUZO28kU98yGoxr/rrQFjwuXovUQB/ktE9ej4+fVDt5QAIAUiBzyzprtlBMnl1o0e1Ee5r3rY7EZk7TdWTRz1JuobMJOTzwSAVmvxP7bfW+CwDETVY5ON8lNQBRFIe1G92vt/NdwI9/qyKHtwSSdF09G1KrVuq5sUkd+3EMDFc4hTrwzsE9Fb0CLI45qEhzyr97yAJIsS5xPvBFx4O7P58PBXhL2OdKB4O7+mcYrva+etIgLQhiu24oJadTIZb/Z15GBgNXUnI7sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKy/1dqDfkwi8oiOKg7Hf6ZEHqb7O3P6mPojB/g7VmM=;
 b=RfhFR61Dul6x+J3NfKEF410SMvb745P22X1onHf0HE5dqyu6XmfDxqX06+458F60ElkIWlz6swhYSdjQwEZF1BDbCdoHELEJ3RX2PBhL7T1fWg5AWI8EblsdEKhcwNW56X3tFZHk4Hyy2tgGCeP8jRl+U09UNVHhZqkNOEokTTc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO4P265MB6525.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 16:28:30 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 16:28:30 +0000
From: Gary Guo <gary@garyguo.net>
Date: Thu, 11 Jun 2026 17:28:15 +0100
Subject: [PATCH v4 13/20] rust: io: add projection macro and methods
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-io_projection-v4-13-1f7224b02dcb@garyguo.net>
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
In-Reply-To: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>, 
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
Cc: Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781195301; l=5994;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=0Ouuv4rEG6K7m1QcFobtEFBysyYvLBM3w06T/IkWO7k=;
 b=FgmB+CU0jQnnM14thZ2DpsUaJQwsyvr8wZJ33J24qyM8wFpYbHFIFdQLXoHVXMyBPC0aRjAst
 mubNJsSodyHCNLaQ723MqYzic5ESCvgERCSwn2mlatzHjSyAKtyXBZm
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO6P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::8) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|LO4P265MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b8405e-4230-418f-ea70-08dec7d67920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10070799003|921020|6133799003|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mG43alH1TIyEi0l5xKjNB7wGQAIyYW0xA4JP9OhXYkrBhy2qQYqTjIWRJBxyS4HAeMPgRWDPBU1TD47gfdJzpSPqJ3mzTrBr4DHlM9W/dTHyzjVYCc1kcKO1sQy/WLELDMrSTPam/1wZlxRQK0PVJmAyyKpLNrTBL3ktLRlHj3Mk3lZkFNQzQZF7Pyc29rbZ6gdVXbBabpLzTVMg9Q+pha6ygONlGwrTbedT78JeT/CMc749PCPJKePc/uZbUX3FROb3iCJ4ZQ78B+SF8D/XG1zZMAlSXwZRIXagQipCnWa1QDbzVFPWlFTg1NhPtCWL0MMiOD5L7+Laexg/63kY+5rfPgJ72YLMokIDgRdJEuy9h8yhHpMhR+gbAy9NzdTNLFRJPqv/Q3yg1W6bC7RJIOSxMnZTzuaxQ8r9fHorRv4Q/u4hEHSLIwKAdTiF0EI3KC4yR2/WDnjW6fSrG0pkjt+xBx/V1Lye+2XboZza1Bq1RApycYxFSfDI4hVVXfKKfh8/f8+XKX+KU+oo7cVDi7evpqkSwJG0/Jt76V1RizhjqJjz42HPK6R/6u0bLmOK7dTRBWSrRCN5pD968JQ7pgRbGY6qZfLeJCnVMYEi/xquUkSNS+a4oUhscbiKcLecpXir9AUXr7E1TC71QOIKda3lS1Bg6lmJJ8SqbV+xbB6yqEJZYcla51VElptxMRwD3M4ypQARf5lIu70G7014CQCMkQ3PkLgldEkHamk45Tw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10070799003)(921020)(6133799003)(56012099006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3NEMG9GU2twbTBFRG0rVXVVQXJpRWsrc3FqYTVXMU04cUwyWnRjRUE0SERE?=
 =?utf-8?B?KzlWSmhaTmRHZnNuanF4UGNOanJEb1M3dXJyKzVsQVRSeEI0dFZaZ3JRRlEz?=
 =?utf-8?B?QTdCMDljRnV1U0FRUHF4OWhIYW1YOU52VENpc0NHeWtvTHBaWURIOHpZSThH?=
 =?utf-8?B?eFVrdjZjZW1YSW5IV3h3SkcydjE3V3NUeGZObUJZeTZEalhUbEg3a1BwQnBH?=
 =?utf-8?B?blNsOG5wVG11TXJ5bmdKQlVaUm9tOENwSGxZQTRpWENYQzZwYjNHUUVKTnlJ?=
 =?utf-8?B?NzdkQnRqNzhNekVsR0twN0k3VGtJeG1aRzU0UjM1WmFJK0hCUEhYb1NVZUU2?=
 =?utf-8?B?SEUzck55bkxoVEVzM0FrL2pzNUZrN2x4WHpSY2tUZ2tVQWMrdkE0aEJDRm5u?=
 =?utf-8?B?RVFwM2FWb1hVaHNjYUpqOVBYTStQdVAvV0E0QUdxL0R2emZrbld4QWRZZDJ5?=
 =?utf-8?B?LzBObHhQbGxJZ0VwWHN3V3ZNZzhuMk9WQk9MSGNxWUs4eXA5Q2lFK3Z4eGhC?=
 =?utf-8?B?NnFVMENETWhBNVhOZGEvRUtYWitTUER4ZFJrQUU4OXg2dE1abVZIRjhxSkVS?=
 =?utf-8?B?VS9NZGYrYzFDa1FGRm13MjBGd3RFZlp0cWtGUjdJRVRYbjQrVWxJZ21HMFRG?=
 =?utf-8?B?WXBZazMxbHJJV0EyTzU0Z2ZKN1lWZzJmbUJTc0RxRm5UL0owQkFlN3A3ZWtZ?=
 =?utf-8?B?T0k3a1ZIbDlHRktjOXNyMVZJc0xqcGFyMzFnZ3VWTlI5MHFBMGJCaXJUQlYx?=
 =?utf-8?B?eFE4UE8xTUtFZ2NVamdVZ3VTY1c5d3FjSm41azJlRjRNYzBFNHJpcHpSMzI2?=
 =?utf-8?B?YUIyREU5Q3ZOODYzUU1SVlQ2Tk1KbzNXcXJlUy9xS3ZNb2VZZVBOSzZ0M2N2?=
 =?utf-8?B?K1BINmVkWTRnbCtnbkwwVmlXSWFXYmZDa3BtYTJDamJkdVVqcElKTWo4S1pP?=
 =?utf-8?B?eUY3R2VuZ1FlbEJCQ2tsd3ZVRktKclFpNTE0RFNXSjh1V0dZNHJKV1pJYWY1?=
 =?utf-8?B?RjVoN1JBR0x5RGJ3ZHpBU21sbHg4L1EzdFAxZFNnVmZiZG1RUHlJWjlxRmlZ?=
 =?utf-8?B?cll6SndKbDNFaTByWlkwRDZMR2JDVzBSUTVrNkQ1UStaTThPTENyVy9Kd1BB?=
 =?utf-8?B?cVVTbW5udk5xb3lFN2t3MnZNRTBta0prY1hHV3dQa3VzRk1qWjhURWp0SWFL?=
 =?utf-8?B?ekRTYm04VE96Y3AvckZaZkhUZncyRXlUWjhlMEhzWDVuS1p1WVlrM2thOVZP?=
 =?utf-8?B?ME5WVlp4NDdybnV5U1FVZjFxNXlUWk52ZU1SZUhYOU84Z2ZNMTlBNEdlMWJS?=
 =?utf-8?B?V2RRaUJOa1ZubDBLRzhBRHNZc3RNY1NKWE1qVldJWUdGV1NadS80RnZzU1pF?=
 =?utf-8?B?R0xqaGFSNmlFc25uOFU4eFliZUtoZzFxTml1L3BxNHVlZzNlMHNIRHh6RGtO?=
 =?utf-8?B?VXJZZHltQUwrbHEvOW1rMmNHcHBaSy9qZXVJdFJITmpFK1NSMEF1b0hxOExF?=
 =?utf-8?B?R3dYQ3lsRk55QmRlNnkwWXVoQ0oxRGFnSm1zdUR6OStMTGUrNDNudnR3ejNI?=
 =?utf-8?B?Y3hXZ3VJbFdzL2NScGFkRG5VREhReUhsTlovdTdqRU96OXFTLzJFN1dqbVVQ?=
 =?utf-8?B?cTZxMGRwSUcvYVlVcVRrUHJzNHNQS3B0bFhHWkFtM3dLNTdZbTR0RHdPUTk4?=
 =?utf-8?B?azM4b2dyWVhMVDJ2VmRSMm82eThZZFYxMFJFcXlOME9OcDFiYmRiZ3NwSm43?=
 =?utf-8?B?b1NMeUMzTTJSZ1duNk9ESUJycjFFWUtyQjJMcmhadng4ZWJ6Vnk1VGZNWGJa?=
 =?utf-8?B?V0F6Q2JMckkvMVE5M01CQktUNnczUWhTdXJ4VXR3UUN1NFlDbEJIbC9teGwz?=
 =?utf-8?B?aVNNZFlKT0x0aHFuQngzRmNBcDhBWWFzeEpHU2Q2WjlCc1BDcmQ3Wm1wZHFo?=
 =?utf-8?B?QnBjRzhROGU2NUlNNE5GREE4NTA4OVJXcVBvaWhVMW1iTDcwOHpyNnpzc1h4?=
 =?utf-8?B?bGFXZ3U4SFc1d2tWa0pHVmtaRmRId25YSHkyUURsR1FaZ0FrKzRISVNZTkl1?=
 =?utf-8?B?MVUzZGswcmxIUHphaGNuejZkUHdNcjk5cjJqeC9TcGJUTDVJZVAxanp4THRF?=
 =?utf-8?B?MW9Ebk9PR0MxVjg3cDRIUTRqa1dnVHVOMlN1bjY5WHN4dVRVc3VMRUF6S2hT?=
 =?utf-8?B?SVhiYVowa2MrQWpsV0s0YWM4a05XeTd1QnRScmdVcEUvRVlsd21KUy9KbmJR?=
 =?utf-8?B?bmxEOFB1MktWRUQ2OE9pN0ZETWNyZlQwK3V5dGtqWnhma1RMaURSMWFlTmFv?=
 =?utf-8?B?b3VWOVFVNEg2RjQxRnI4djNmejJkMFhXNU1OM1pucHQ4enovZGIzZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b8405e-4230-418f-ea70-08dec7d67920
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:28:30.3098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOW9geFOm0t4uNQQp4O2BkXGXz5Ckg/1ZQU3SZx7V5OTONeCYcngQYta5YU1im4EDZR3MBWZeLMkbv9InQLv+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6525

Add an `io_project!()` macro allows projection from `Io` to a subview of
it, using the pointer projection mechanism to perform compile-time checks.

For cases where type-casting is required, the `try_cast()` function may be
used where the size and alignment checks are performed at runtime.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs | 130 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 126 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 470ee2ed9849..c7a9952af995 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -14,7 +14,7 @@
     ptr::{
         Alignment,
         KnownSize, //
-    }, //
+    },
 };
 
 pub mod mem;
@@ -44,12 +44,12 @@
 /// This type can be used when an I/O region without known type information has a compile-time known
 /// minimum size (and a runtime known actual size).
 ///
-/// This must be 4-byte aligned.
-///
 /// # Invariants
 ///
-/// Size of the region is at least as large as the `SIZE` generic parameter.
+/// - Size of the region is at least as large as the `SIZE` generic parameter.
+/// - Size of the region is multiple of 4.
 #[repr(C, align(4))]
+#[derive(FromBytes)]
 pub struct Region<const SIZE: usize = 0> {
     inner: [u8],
 }
@@ -91,6 +91,15 @@ fn size(p: *const Self) -> usize {
     }
 }
 
+// SAFETY: Values read from I/O are always treated as initialized.
+//
+// This cannot be derived as `derive(IntoBytes)` does not know that this type is padding free (given
+// `repr(align(4))`).
+unsafe impl<const SIZE: usize> IntoBytes for Region<SIZE> {
+    #[inline]
+    fn only_derive_is_allowed_to_implement_this_trait() {}
+}
+
 /// Raw representation of an MMIO region.
 ///
 /// `MmioRaw<T>` is equivalent to `T __iomem *` in C.
@@ -295,6 +304,49 @@ fn size(self) -> usize {
         KnownSize::size(Self::Backend::as_ptr(self.as_view()))
     }
 
+    /// Try to convert into a different typed I/O view.
+    ///
+    /// The target type must be of same or smaller size to current type, and the current view must
+    /// be properly aligned for the target type.
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// use kernel::io::{
+    ///     io_project,
+    ///     Mmio,
+    ///     Io,
+    ///     Region,
+    /// };
+    /// #[derive(FromBytes, IntoBytes)]
+    /// struct MyStruct { field: u32, }
+    ///
+    /// # fn test(mmio: &Mmio<'_, Region>) -> Result {
+    /// // let mmio: Mmio<'_, Region>;
+    /// let whole: Mmio<'_, MyStruct> = mmio.try_cast()?;
+    /// # Ok::<(), Error>(()) }
+    /// ```
+    #[inline]
+    fn try_cast<U>(self) -> Result<<Self::Backend as IoBackend>::View<'a, U>>
+    where
+        Self::Target: FromBytes + IntoBytes,
+        U: FromBytes + IntoBytes,
+    {
+        let view = self.as_view();
+        let ptr = Self::Backend::as_ptr(view);
+
+        if size_of::<U>() > KnownSize::size(ptr) {
+            return Err(EINVAL);
+        }
+
+        if ptr.addr() % align_of::<U>() != 0 {
+            return Err(EINVAL);
+        }
+
+        // SAFETY: We have checked bounds and alignment, so this is a valid projection.
+        Ok(unsafe { Self::Backend::project_view(view, ptr.cast()) })
+    }
+
     /// Returns a view for a given `offset`, performing compile-time bound checks.
     // Always inline to optimize out error path of `build_assert`.
     #[inline(always)]
@@ -988,3 +1040,73 @@ pub fn relaxed(self) -> RelaxedMmio<'a, T> {
 // MMIO regions on 64-bit systems also support 64-bit accesses.
 #[cfg(CONFIG_64BIT)]
 impl_mmio_io_capable!(RelaxedMmioBackend, u64, readq_relaxed, writeq_relaxed);
+
+// This helper turns associated functions to methods so it can be invoked in macro.
+// Used by `io_project!()` only.
+#[doc(hidden)]
+#[derive(Clone, Copy)]
+pub struct ProjectHelper<T>(pub T);
+
+impl<'a, T> ProjectHelper<T>
+where
+    T: Io<'a, Backend: IoBackend<View<'a, T::Target> = T>>,
+{
+    // These helper methods must not have symbols present in binary to avoid confusion.
+    #[inline(always)]
+    pub fn as_ptr(self) -> *mut T::Target {
+        T::Backend::as_ptr(self.0)
+    }
+
+    /// # Safety
+    ///
+    /// Same as `IoBackend::project_view`
+    #[inline(always)]
+    pub unsafe fn project_view<U: ?Sized + KnownSize>(
+        self,
+        ptr: *mut U,
+    ) -> <T::Backend as IoBackend>::View<'a, U> {
+        // SAFETY: Per safety requirement.
+        unsafe { T::Backend::project_view::<T::Target, _>(self.0, ptr) }
+    }
+}
+
+/// Project an I/O type to a subview of it.
+///
+/// The syntax is of form `io_project!(io, proj)` where `io` is an expression to a type that
+/// implements [`Io`] and `proj` is a [projection specification](kernel::ptr::project!).
+///
+/// In addition to projecting from [`Io`], you may also project from a [`View`] of an [`Io`].
+///
+/// # Examples
+///
+/// ```
+/// use kernel::io::{
+///     io_project,
+///     Mmio,
+/// };
+/// struct MyStruct { field: u32, }
+///
+/// # fn test(mmio: Mmio<'_, [MyStruct]>) -> Result {
+/// // let mmio: Mmio<[MyStruct]>;
+/// let field: Mmio<'_, u32> = io_project!(mmio, [try: 1].field);
+/// let whole: Mmio<'_, MyStruct> = io_project!(mmio, [try: 2]);
+/// let nested: Mmio<'_, u32> = io_project!(whole, .field);
+/// # Ok::<(), Error>(()) }
+/// ```
+#[macro_export]
+#[doc(hidden)]
+macro_rules! io_project {
+    ($io:expr, $($proj:tt)*) => {{
+        #[allow(unused)]
+        use $crate::io::IoBase as _;
+        let view = $crate::io::ProjectHelper($io.as_view());
+        let ptr = $crate::ptr::project!(
+            mut view.as_ptr(), $($proj)*
+        );
+        #[allow(unused_unsafe)]
+        // SAFETY: `ptr` is a projection.
+        unsafe { view.project_view(ptr) }
+    }};
+}
+#[doc(inline)]
+pub use crate::io_project;

-- 
2.54.0

