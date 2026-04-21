Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020131.outbound.protection.outlook.com [52.101.196.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993583D9DDC;
	Tue, 21 Apr 2026 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776783397; cv=fail; b=mXsjUD9fIDf+Pc6dHgfpJZFFoqdHyIZMT8H7P8EMpn3mLbqTWrYo3EVcrUsXx74NH6E0gr6jZ5vp3foPCu06XXq2WthdA7tNfesDANt4HzYhIax1c5tRE2rpxzNQAVmHghqQ/Qu/PhFKRtnTGlWdDfqexkiB4Ym/GEYGqFadthE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776783397; c=relaxed/simple;
	bh=Aiz1SAzAaI4xDUYeDbA1tGyZD1iLdIGo9Omh+b0S9cE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GCkYAFg2zFkQH1g9ii3vt9XJn9JoYu1PaedZ1XBgZBUd1Cu6z+BaSfYuoG4qY560QLU4PYWgqa3DEofgQtzWg2PuAV2qV3S+uqEaICw1ZfWg0FQkZdgODVC9DwtfhBspUStSBfkTJR9xXrh2lN1J6fD/ztSuaLpFlo2Qoe2TuvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=IGLO17Mb; arc=fail smtp.client-ip=52.101.196.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="IGLO17Mb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDP4tCAp3YY3lju2em9ny5IpDr/vzo5sS0bdww7i6120UPrtvhwed4zsRWFOQkfS6t1mtQ3/Oity4BUp5O6ov1m1rDeTvbDV7l1XNHzvWjpLE+mrvw+nxaamuW2xNfG6TqvNHMU9jmyjFsI1KY3SQfbUQCTJa738oJJkFwTFqGca8j17iQsTpQ/DXJHjFPr1VQI69ADLKjFHCQ1cKRZe+zvZk9etVhUnKHXtZHf5hZ20VzvGlSAJwJF2iGnBhvFkBrX7NHTDzAwga1k0ec1VEu/WuYJew+Wx3Bs5qp1EEggeW0H3Klk9uWvNTR/AXWokzMNgjGKI9YPbA2INp0Q8vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBCRkNd4yS+sbgCTUuQCjj+vsx4wEQlficT2OEM7beE=;
 b=QDPjGn89zOvuriPriIbx/aAFN+A48yX0FMxZSAQ+hZi+HBSoyFO193fQEWd6inVkK4KFcNyXZKDe2BgkrUL2HqHuMMdD3ZWH/s6PRTEm2H/yDtnmHp1h2YVM8IjKz75nAQsyxGjilEBve0Jw1ufrI98o4Mu3zoN3D7aD2txZuLeB0xo/kYV7YG+M6bVyRaKd5N/MfFbgnFks9txrkXMEYJPI58Q0zs1UrpWHFnK/XFIHKNMTlqQsUCuXuPYJD4N1HPp9Xk/TEwYbeWHKJ6dmAehVNgr5XfpQLkYUcQupCfF8ei2L93Xu9DZrOBgNk07Uxozhl56hpwLV+4dKR1V35w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBCRkNd4yS+sbgCTUuQCjj+vsx4wEQlficT2OEM7beE=;
 b=IGLO17MbXGUWXVtGRpwpXP+pxvt5b+zSXUS88ICW0d9cj/Qu3m5nArJrH0yH/5HPCz3PwrryjfafZIV4g3HGyJvG35bkyCdccTuIF8VrO9R1xMnRojD5gPjx2SYZCQSePdKyZ03aremYQ9DtIuZB37zZ8yuOB1InblREdLnw4h4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB5674.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 14:56:29 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 14:56:29 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 21 Apr 2026 15:56:17 +0100
Subject: [PATCH v2 06/11] rust: io: add view type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-io_projection-v2-6-4c251c692ef4@garyguo.net>
References: <20260421-io_projection-v2-0-4c251c692ef4@garyguo.net>
In-Reply-To: <20260421-io_projection-v2-0-4c251c692ef4@garyguo.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776783386; l=5749;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=Aiz1SAzAaI4xDUYeDbA1tGyZD1iLdIGo9Omh+b0S9cE=;
 b=nCrvfstnb2bvYiKMDfOSPCaiv0BoY0hMKfa4+nDIeuRoo33zRi9gM+3Ue8jnRMcVG39vMm/eX
 MtOYjTn6YtoBtAK7MWmQoyXhS0z6D+SoqXT+pPWIyVCz4q28gNytRLg
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0142.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::21) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB5674:EE_
X-MS-Office365-Filtering-Correlation-Id: 28f11079-18c8-41d1-7aa9-08de9fb62b5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	7J5YxYfOO0KE9wVilg4vvkJUIbGrUwPiWBY0LsonuhnDZB4JhOct5I3UyjF+C1qnPnEu1TH2S9DcoO0EyENcaoCuq6El9fAOTgbbXu//aul7GFTNAByIJuQ1uIzAyNV9zlGKcM6BokQ8v/YwSpkxy1TB0tdMW0wJwZt/Uuioqb3CRr6UBtpYkfIJhw7RhqueBo6zlKlUTXOqkrOUYgCyzD4+aKftfoMGi3p9ZDUZDEvRGf9YivBMDTjGaTXobFok6Ao7lIdRgDBnaN80jvyMERMdjNyYiYbbf1iEM/SGNRuNADgmwBLZJV+kK6pZ/EjGvsPLk6bGsxof/ClW3EBcQA3CKXinBLBNQbdi3X3kvsllSMaiY+bEjazj5H6V3fEZgVfE4wzVlNWF8khhiMcYbdxjFQajjo31D7GqbOaUwl5gJLIGNGV1TyanDpVCvoUlq8LblLyLglSExElXTtHhVS5dcYELhxZiBr0UA1/FUYt30H6czbfVmwUdFz9PUpqzOsAbOC/Qyy/n6v6zEZsKXtDC3gqhU+iuhFLK6Mearg1ZxmUzwHzQdyVk/aSn5DBpsXG3VsjBuQ0+O3OZGQKM2A+B4HmCpfQzfcLxBcG1MBtwQbEW1ShJK1fK/g0kbdEwGeIRbGjZrMziQZKs0Qh8EkRY06xYBWMmVPPvt91ejVGAjrNUA8S6nJ0EzwTNFeN3qInIhUCVm56mrQhLUeBQlO6WXZY3pmQEKtIJIgBUuVh+n2PiiR03S4Y/RTCR2j1otttrFbsgH4TqOZ4vnaYCsQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzJ4RzYxNHkzS1hZYXZHaXBDd1JFRGJVWVpoMXZqaGxIcHM4NllwN1VYVjZ3?=
 =?utf-8?B?VmhwTmE3M1VlalhodGdwZE5ra2xRejFySWRjNS8yd0t1b1hGN2dHQkFjUUkz?=
 =?utf-8?B?Z1FhRmVyb1VuSE1Nd2FyMnhQVFFXL1lBc1dxU0EySVFGMUt4Vlkza2x6RmhZ?=
 =?utf-8?B?QlB1bjZUL0RMT1ByalV4UHBqYzJ6b0IrWmhONlZsOWNvOGxCSWRrVi9lUmIr?=
 =?utf-8?B?ZWpIR0RXUEcvQkZ1M3M1SURxTVg0QkI1T0crMDh6UUtUeS9XWW0rMjNwekdo?=
 =?utf-8?B?NHNnNGt4cW1zSFN1VTVJQ0kwYWk5aFFBOW1RSnB4NEdxY0RWUEhBckpqYXU4?=
 =?utf-8?B?RzNFdVVtalViVTdtVHN5TlpCNDhHNERXUUk5YjFpQzZ4NzloeWs4VVFjRFpC?=
 =?utf-8?B?TVNjK1pRNVEySzc3WFkrclZOaDhCczMxdlcvS2czeVRDUnJpNU9ENDVaOTdG?=
 =?utf-8?B?YkpwN0x5b1B3N1VsT1JtOXVKSE5jOEFwSDZlNENNWnFLSDUyWGYxYjRQaVE4?=
 =?utf-8?B?Z1M3R1FnTHRSSkFIVThtZWZvSFpoTFNOcnpKZkVlQ2dOMHB3eXQ0OTZHYlRC?=
 =?utf-8?B?akhvVFB0WHY4UDR6ZFBMeUtVSk1KK2RwazdwVENlNkVhNkdYOXJ0clVMajAy?=
 =?utf-8?B?Y3JkYXRlaTlSNE9RcUI3TmRtNnhXcG9zMVFabjNqeERHaS95S3o2VWZlQk1x?=
 =?utf-8?B?c2FjNklZcXdUcmxmQkxvTE5lNzYyd2oyNVBPbTBZUE1haVUwdWswUVdRVEcv?=
 =?utf-8?B?WUZmV3VlNTQwNjlTV2VjbC9ZdjFPa2h5bW9VMG5GR1pWT0FjbE9vTXh3NGNt?=
 =?utf-8?B?K3pBQXNiTmRleUtuY2xDcWp4V1lCZXVEUmswaXBJVkFFUjVGYzA1UDNtRUEy?=
 =?utf-8?B?M2N5WXR5dEM3QzZDNWIzUEVvdXo1V0NJZTlaK09EdWtqajN1cXZ6NVJQdW5q?=
 =?utf-8?B?dXVNZ3R0SURSTnl5alR2VFdZd1hWYmtvYWlVYTc2NkEvQzJwL2dQS0dMMkJO?=
 =?utf-8?B?djJoYnpuWDFhb0xYeE44dnplV3ZnQy9RandPMXErVmhwZ0NZcjdTTGJCOTlw?=
 =?utf-8?B?MVQzUTlzUGFXQ3ZEVEZqNWhVZGN3ejdwdUJHbGw1UWl5ckx3YlB0TGNSVFNK?=
 =?utf-8?B?YzQyRE1pZ1pPSERqOVhMS1N2VmdZWnplcmxpTGdaRFBnL1k2RERaY2swK0FS?=
 =?utf-8?B?dHJJcDk5bGJ4R3BVUjlCSlpmWUp0L1Q1WjcxdEgwd3dRamRDNHloYVRmdUxu?=
 =?utf-8?B?eWNDY2I5cEVacWlaMCtuWXp4RjlpeHY1R1BaamNpb3JycDU5N2pyKzJISXdp?=
 =?utf-8?B?dCtQV0VJa1E5NXp6ZnJnVWVWQ1pyZG5HRWF2T2RoMElQTloyd3QxSWd1S01r?=
 =?utf-8?B?L0pSRFMvZ1lOR2lXZjdXY0lOWXdXNW0zeDJUb1RvcU9xWkVOTWV1UUVvRjJl?=
 =?utf-8?B?TWxZQWljQW9PQlJTeC9mUWlHbGE0MU9mZm5Ec21qZGF5anhZYlFUUjRNWklu?=
 =?utf-8?B?SXI2a2MydExUVFVLdmIwNUdjTXJ4UnNNNXlRK3pPS1RKNXFlM3dEQU1DVk1m?=
 =?utf-8?B?SkkyV0RENHRwUjdnSFNMbzJ2Qlk3andoT1RjYmZYeFdBZ3A4Znl4bmRudXFk?=
 =?utf-8?B?ZFltMmxKdDJXcXdhZ2tuTVhwUFZ0cUgrSTRBak9URXg4MVYrazE3dS9yMW1y?=
 =?utf-8?B?RzFmK1RzR1lyQzh5TVQ0NitIM1dRVFBJS0liMUxFSi9haUZqc3QzOCszSENR?=
 =?utf-8?B?OWRQOU94d0RuRzVZRFdFZWw1WUFaWnRhWjIxYzlrRjlwZllqdkwxYStqR2JL?=
 =?utf-8?B?dWo4bHUra0l4TnVhVGpIR2ZXejlyR2NiZFhuTHptN0s2clBlTnpCNXVNT2tm?=
 =?utf-8?B?MkxTZ3V4MkY1R2F1UXMyYjJTWWRFUUpRMGg5dWVDd2NDVUdoZHB0S3RwNkhS?=
 =?utf-8?B?MkdaWllndVh5SmEzbFNJVWYydDNRdWpwRGRzNnhRamc1ZnFjbS9FcEZSY0JT?=
 =?utf-8?B?N3FjenMwKy8zZHptdHFlelhHaG93MmlpNGRRcUh4S0NzSktRM29rdEtMVVp2?=
 =?utf-8?B?YnNMdjk5U3IxeEd0K1hnejJaR1NJSm1mWDVzZkhmMU50SE1NejJDNGI0MUJW?=
 =?utf-8?B?UkZhTkdEUk1lbnZmckFpR1BpYWxPdnMrV3ZFYmpzYVdYNjk3SVRQN3FPQ2N2?=
 =?utf-8?B?MDR5TzRCRGdmS3lmb2lXQVFSYVBpNjVHalNxbVF5YmlLT3pGU2JpN29ON1ha?=
 =?utf-8?B?SWw1M3RuTFRJdnZya3IxLzNuMXdQUzF1cm5TL3d5Z3RBdDNoaVgvN1hpZTVS?=
 =?utf-8?B?RU1sUWJHWUx0K0N1dzU4MmtVNXlkV3VFbTN4L3lsUWhNZk5zVlRuQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f11079-18c8-41d1-7aa9-08de9fb62b5e
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 14:56:29.4443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Syz8XJXVkI6KKLCpM9rZmI6lTHNlMxjzta7D73csoPArsab/AkmuOkZk9NFHov1vgmuOBQRP6XHP2OMMxVyug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5674

The view may be created statically via I/O projection using `io_project!()`
macro to perform compile-time checks, or created by type-casting an
existing view type with `try_cast()` function, where the size and alignment
checks are performed at runtime.

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs | 147 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 146 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index a13be8c5fd2d..869071d47a13 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -7,7 +7,11 @@
 use crate::{
     bindings,
     prelude::*,
-    ptr::KnownSize, //
+    ptr::KnownSize,
+    transmute::{
+        AsBytes,
+        FromBytes, //
+    }, //
 };
 
 pub mod mem;
@@ -297,6 +301,13 @@ pub trait Io {
     /// Type of this I/O region. For untyped I/O regions, [`Region`] type can be used.
     type Type: ?Sized + KnownSize;
 
+    /// Get a [`View`] covering the entire region.
+    #[inline]
+    fn as_view(&self) -> View<'_, Self, Self::Type> {
+        // SAFETY: This is an empty projection, so it trivially satisfies the invariant.
+        unsafe { View::new_unchecked(self, self.as_ptr()) }
+    }
+
     /// Returns the base pointer of this mapping.
     ///
     /// This is a pointer to capture metadata. The specific meaning of the pointer depends on
@@ -912,3 +923,137 @@ pub fn relaxed(&self) -> &RelaxedMmio<T> {
     readq_relaxed,
     writeq_relaxed
 );
+
+/// A view into an I/O region.
+///
+/// # Invariants
+///
+/// - `ptr` is aligned for `T`
+/// - `ptr` has same provenance as `io.as_ptr()`
+/// - `ptr.byte_offset_from(io.as_ptr())` is between 0 to
+///   `KnownSize::size(io.as_ptr()) - KnownSize::size(ptr)`.
+///
+/// These invariants are trivially satisfied if the pointer is created via pointer projection.
+pub struct View<'a, IO: ?Sized, T: ?Sized> {
+    io: &'a IO,
+    ptr: *mut T,
+}
+
+impl<'a, IO: ?Sized, T: ?Sized> View<'a, IO, T> {
+    // For `io_project!` macro use only.
+    #[doc(hidden)]
+    #[inline]
+    pub fn as_view(&self) -> Self {
+        *self
+    }
+
+    /// Create a view of a provided I/O region.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must satisfy the invariants of the view type.
+    #[inline]
+    pub unsafe fn new_unchecked(io: &'a IO, ptr: *mut T) -> Self {
+        // INVARIANT: Per function safety requirement.
+        Self { io, ptr }
+    }
+
+    /// Obtain the underlying I/O region.
+    #[inline]
+    pub fn io(self) -> &'a IO {
+        self.io
+    }
+
+    /// Obtain a pointer to the subview.
+    ///
+    /// The interpretation of the pointer depends on the underlying I/O region.
+    #[inline]
+    pub fn as_ptr(self) -> *mut T {
+        self.ptr
+    }
+}
+
+impl<IO: ?Sized, T: ?Sized> Clone for View<'_, IO, T> {
+    #[inline]
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+
+impl<IO: ?Sized, T: ?Sized> Copy for View<'_, IO, T> {}
+
+impl<'a, IO: ?Sized, T: ?Sized> View<'a, IO, T> {
+    /// Try to convert this view into a different typed I/O view.
+    ///
+    /// The target type must be of same or smaller size to current type, and the current view must
+    /// be properly aligned for the target type.
+    #[inline]
+    pub fn try_cast<U>(self) -> Result<View<'a, IO, U>>
+    where
+        T: KnownSize + FromBytes + AsBytes,
+        U: FromBytes + AsBytes,
+    {
+        if size_of::<U>() > KnownSize::size(self.ptr) {
+            return Err(EINVAL);
+        }
+
+        if self.ptr.addr() % align_of::<U>() != 0 {
+            return Err(EINVAL);
+        }
+
+        // INVARIANT: We have checked bounds and alignment.
+        Ok(View {
+            io: self.io,
+            ptr: self.ptr.cast(),
+        })
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
+///     View,
+/// };
+/// struct MyStruct { field: u32, }
+///
+/// // SAFETY: All bit patterns are acceptable values for `MyStruct`.
+/// unsafe impl kernel::transmute::FromBytes for MyStruct{};
+/// // SAFETY: Instances of `MyStruct` have no uninitialized portions.
+/// unsafe impl kernel::transmute::AsBytes for MyStruct{};
+///
+/// # fn test(mmio: &Mmio<[MyStruct]>) -> Result {
+/// // let mmio: Mmio<[MyStruct]>;
+/// let field: View<'_, _, u32> = io_project!(mmio, [try: 1].field);
+/// let whole: View<'_, _, MyStruct> = io_project!(mmio, [try: 2]);
+/// let nested: View<'_, Mmio<_>, u32> = io_project!(whole, .field);
+/// # Ok::<(), Error>(()) }
+#[macro_export]
+#[doc(hidden)]
+macro_rules! io_project {
+    ($io:expr, $($proj:tt)*) => {{
+        // Bring `as_view` to scope.
+        use $crate::io::Io as _;
+
+        // Convert IO to view for unified handling.
+        // This also takes advantage to deref coercion.
+        let view: $crate::io::View<'_, _, _> = $io.as_view();
+        let ptr = $crate::ptr::project!(
+            mut view.as_ptr(), $($proj)*
+        );
+        // SAFETY: projection of a projection is still a valid projection.
+        unsafe { $crate::io::View::new_unchecked(view.io(), ptr) }
+    }};
+}
+
+#[doc(inline)]
+pub use crate::io_project;

-- 
2.51.2

