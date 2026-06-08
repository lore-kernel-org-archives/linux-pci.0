Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020097.outbound.protection.outlook.com [52.101.196.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E9F3EBF02;
	Mon,  8 Jun 2026 19:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948762; cv=fail; b=ufyKn0Jz9lDC/2yyLP970RR/jXDVP/tw29J++IY+HXIW0293aFq9khLGLnGn7cT5N2+/pjYi1mBf55ztNQvTKJZldqy4/wu8RexaJTIeGhgaHf/17tb9b2W8fOy3XgWdo/VGql60/ilVDH2m58jyfCVz/7CFIymUGqgwSRc/WAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948762; c=relaxed/simple;
	bh=1dBGnRtZtvrGIAto6rLiWeZm1SPdkIb+ZmTkOAo6zpo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=M3aPnuhd2XgHFi6M6hmRWsuTwwXyNVb9xhWblZ1/rojThfg7NCtKP2CJ82IEUx+Ws5n6FgcD0QX7fhEfFJFud/2i7cgU4aclGlalcfvuGQGRq0bx7PC2gIVMC2b8ojwWQhUUqXwvigO/M84sgHGTK+FRn4cVt2WDrrGy9Z6rtU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=O8tEO63g; arc=fail smtp.client-ip=52.101.196.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="O8tEO63g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0eVdod6vQoB0+cgzapRY2EKhAz+G6kdIrsJRlUXdLJmx5BoEoz/VKo8VN2+tk4hJGHQ2ZF6JtRh5nKhn3muxJXMo9ehoMTL9WhHryEVfpaQ7Dd4BmA2ry+lG9eQ6qwuDYgS8RkbhzXrSY9jsLTtIthsmgwrKh4OvmiaEtoFvvrSZoVOGfmSa+N4OFpL+96H8ml8it43Rq/CGeShqaHD8Uibzgs7J/PWnIiaZ4Fpb9gMVkfV91sW2ANk6a1ntwUkn0P5flwpdvBXZ+xuBSNLm3a40U11WnU2NBhIvYowBpbf0vfFxMpIknHY+JKtDOf6Y6syT1zpPyl8HX1Va69Bkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rj8tPZ70X73pJLFJzHDL00y/CnyDaT2yCg0XffJ9Qg4=;
 b=scLBiNQvzH4kDV05/3Flb+dpsUexBhhBL7QvhQ8yj8UFKqWD/MCqXDTQSbHUMsdOW4nclM22p2UhQ0Cnohl1ci5eZwt9WX0joRcvQWrOyMuSRAfXzc5NohGLL+KTYhFV5vECMiWqBG/1tesAd3GA9Qu85F0igvz4vG1Vru0dgv+RrSXaAN1VeamG/Ljr/RxLQqzfxQ0d7AmCm3ioQ+W1+dMOHEeFu0nITonk5i5kQLx25RP5i/jghbYCo9MWvqzPnA3kNAbeQIaCWCMsLG6zxItpqINw5esSWP2R3O7j8iSitqoCE0LBAWbnHilx6lW/4cYoL9Pu5ajDei0vlqRfLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rj8tPZ70X73pJLFJzHDL00y/CnyDaT2yCg0XffJ9Qg4=;
 b=O8tEO63gZ2m/jQgvSTHUe9DW6jknJxBDVgk6MMIcEIpsUHl9DLyMKpaxlFZzwnzNvYHnr74MlFwx/aeRAgXwiHecL+s4z8HdngQyHp0ps6W508PPqPgVhqImKYrk8ozcexPtLgy5Vu7W+b4GwAGUrQsIvF3ipfy5ZGGiIXhGMJs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7398.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 19:59:08 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 19:59:08 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 08 Jun 2026 20:58:59 +0100
Subject: [PATCH v3 02/19] rust: io: add missing safety requirement in
 `IoCapable` methods
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-io_projection-v3-2-c5cde13a5ec4@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780948747; l=3404;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=1dBGnRtZtvrGIAto6rLiWeZm1SPdkIb+ZmTkOAo6zpo=;
 b=ZzASpkW5Y2YhBk/fsxqiSe5SkjhlvZA1L1Ofb/stCyYtoH6RHVDyLCPDQ6JcgMm+q/2XZ0ZCR
 h/QRvt3QJDWA3DqSFDDX4jRu7/ysmFujGmlkydsoQZH5qWY8JpRnmUg
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
X-MS-Office365-Filtering-Correlation-Id: 47598c69-a3b6-4933-587e-08dec5986709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|6133799003|22082099003|18002099003|921020|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	k8lDbi1I0sXj3oSx+b5dU7peJ+z7C2x/j6cG9ZILEboxhAppE4PKbQ7wQYKgjGCSCDJVlOjIGtH6eNZH1425AL9IsMphi2vlCafGWEzlvJNtHXFaecO4IL3BUk5lqLPkYW6PV4dxL65+a+JK0q23K9cToXOm7qXi+8SCW4gyi92TyvsU8tPESOq3b0k7r+Scg7/5pO20bF4e5hYNIYXzvjFFF071bhON2UC/vX7TLjrOfK3MX70vR9cQaox49mLT7bPFyhg8/XFoYZ9l2FhEfSXT1Mtbn7afZ6w7ckoTG7FjQX3/vuDM6bmOT4fmemAmAwB5qRta60MMwIfnbxw56HZnaxFP9p1+6rjvVanp7xD+M4nhh6yYQJwJXAsSeEMk8tivNPveHscjMgHrGK92N88WrwAPU5fFb14B/i2a1kwYgfWNYx/mF5IzKw9amGedq/YTEzLGWPNQTkCFeF4v1ze98JxCrmf5z3HVTo3fpX/Z5JBf+HImshp5vVQsfr1kgkAOYZ3VE+ofH/jNg5rHkdADMSog6xIZI2Szgk0KWK7CKGPjA9jtbR8ja7evVe2US0OVPKogrYvRXi2RlD6plJpjut4tJ+wccOHnniOwaKOoUq4vTE9c5voeHMTOGzLFQknum5YKzE5bklV1k8SHsbwfCjc3Pn6MVjryBQaAi024ZTBKyGzuQjLReTz6rfMVjtXEUJ3xHUTNdmOPguGpiGSS4SP7NjcpTsxEK5l08Qo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(6133799003)(22082099003)(18002099003)(921020)(56012099006)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFcrZ0RLUUpyYitMMUNlVG4xWFlWMDVTOWdWcXVVeElrSjFsTER1SU4rMUtF?=
 =?utf-8?B?c3VDbHVDTWZMN1p4aW5Yc1R2Uk5XQU5nOUk2WkkrSExDVmxuTWhLSTdyaW1u?=
 =?utf-8?B?MjJ3Y2NIK2NXcEtLc3VnNU1WWXZRSi9yYjdkQWFHbFVVZFRCL1h3UGZVZjZk?=
 =?utf-8?B?QzVMV3dGN3dpTWdWbng4Z2Y4ZXIrL2NQQzloQURhSlh3WkEzMHdlMlM1Tjk0?=
 =?utf-8?B?NEVUM25KUGFZTnR6d0FST1VhYmttby9pcWY1K0o5UmorQ01hSENHUVpBMWpr?=
 =?utf-8?B?ZSt6YmljazhiSUJOeEppK0J0cDJjQ3NhK1VkbWhQbjJuL1pUVkV1V05HcUk5?=
 =?utf-8?B?Unh6UzBUUGcyWUxpZngvdC9Ka2hRQlJobm1NQ3AvNHF2ZzhnbnZjRE1uNE5M?=
 =?utf-8?B?dlU1SFdHeTNzZzJYSlRqbjFyYkljM3JBWWRwSGhtWW10ejFBMWhBUDJTWGNY?=
 =?utf-8?B?Q1dvWGxidEdjUkIySGhJN1ZTTnJDQjN0eks3RDhFRXp4eXE2dlRRSEp0RTZk?=
 =?utf-8?B?WWg2ZjAweFFQSzJBOE5EbW5JMXRqLzZvWk8wSXBYYkkvelB2TXhPVHBZUDU1?=
 =?utf-8?B?NWZjYTYwNVZ6VkVDRjBSVWQ4TmRJVi8wOFFVNkZRZHBOWmovcTkwQ25OZzAz?=
 =?utf-8?B?b2kwM3Y4NUtmOHF1dEZObzVoME9mNnMwMjY1M1RJOUNBQjNOL2lHOEdLLzlw?=
 =?utf-8?B?VDFRbmR4TXNEa1ltUWtvRTkwalZJY0kvaGV4ZTF3V2c1cXRxOEpZeW95RnJw?=
 =?utf-8?B?by9GcGI3N1JncFAxc1U0bDdFZHJEdlh4WVdrMC9TNU9SRDdUNyt3TjFLWG1s?=
 =?utf-8?B?eXBKdGU5TFc5dXFjU0d2eEVQUDNqK0ZBSEZETDl5ZmNyRjRCVHQrT2tmaFFl?=
 =?utf-8?B?UE1CczlPYnJER0pCbTY0TTBQVVZNZlFtU3JVQnlCdGpsakRubHJzMWFOWTZ0?=
 =?utf-8?B?cC95eVV5cUNQdUdVcm9pUER3WmFNcDNaNWMxblo1Qmx4cHQrVUErSmFCeWhi?=
 =?utf-8?B?cTUyT1d4bzVZTmcrUi9iRUtKbWlha2Uwa1RaMStSWkxDRnJ6ZVJXQnpDa3g3?=
 =?utf-8?B?amUycjJZSE9pVUNwQlBybHRhWE83ckVsQ2ZEY0lKcDAxOU9MbUhmdS9xRWpG?=
 =?utf-8?B?UEZZQ3lhcUJ5aXhyaTJ4MjRvTXJyaEZScGlBbThKRlNqc3BhdCs5MlpteHJp?=
 =?utf-8?B?VDh3V0gxZTdBdmdBSmpnWDFsakdadzRQTXRXdUphU2ZKUzFXeEV6YmkxaG9R?=
 =?utf-8?B?QUhMRmpZMFY1N1R1cGF0YlhzSU5mUG44RWNRNFRNbnJYaWpqdC8yeEdiTUw1?=
 =?utf-8?B?RUo5cEpWdGpvZysyT01aSmh3NDNoQjFxSE5aYlF1YmpXMlJhUHN2ckFkcW9S?=
 =?utf-8?B?THFXNEdmeTBwcHJWSFJ5SWU4STBtYkR2YkE2WjAzeURyaXBTQnVuVzBJZ1da?=
 =?utf-8?B?US95dTRZTDUxS2JsOHdLM1lrdklaYzZmMHJzNThWUW1xZDVpN3hCdDRrOWFu?=
 =?utf-8?B?L1JWTC9RV2pCMDloSzgzbnJtVmVrWWE1WVF5SEJhaEJoZmxrUEVSTndnMU12?=
 =?utf-8?B?TjU1WE9LeHVJN2t6eXowc0YxaHJzRXRRTVhQUHhsU25pQXZjVG5Xc3hZeWtI?=
 =?utf-8?B?WHVIMFVjbzU1NmdtNG9iMWptUGFWVncwaE0zZ01NcnNWcW5DbFJ2SjVsdTN4?=
 =?utf-8?B?VFF3QzZVbkJNaHpRSllhTllCUWNOR25DTEV4bmc2eFFvVVpKSStpL0R0NDBE?=
 =?utf-8?B?NFVTbHlKbkM0VFZRUkc3THdBQTJwM1FpTjl0Y0hOazR0U3lyK0pQQjBZM1hl?=
 =?utf-8?B?VjFoc2VkSnFXREJrZmp4Ky9jVnMrZGN6OEFvck0vN25McGR3MVZ2djJzMFMr?=
 =?utf-8?B?KzErT0tjSGU1Ni9pVDVSdWlaVXo5dENoaXN6ODJseU51WWRWb1VOVnlOaElN?=
 =?utf-8?B?RWtjTHJEZDNtVFNwTmo0bnhQVnBRSm45N2tIOUVlSlNOS2RDQWpKa1l0VFhR?=
 =?utf-8?B?dHF2MWJzRmNCMzRMMS9WenNvdUZ3bnVlTUhPVEliWWhxNGpUc0FmYU5zb2o0?=
 =?utf-8?B?YnUyTXlLelVxaUwyQXozNEF1ZklYLzNYdkhMU0VTNVo5NEZrMXNWdFdaNk13?=
 =?utf-8?B?VXl4UFkyVkZ2eGhtb2FjaWVSSnV3bG1uZGlYSjdmZEdOSmx0VlY0UkFURDRy?=
 =?utf-8?B?ZjcvS25OTy9jSFNwY29RTGp1VkJVcVgrQU5CTGV1NWc4ZytEYXcyTTVxSlhU?=
 =?utf-8?B?M2I3UTdIeTJaYXRnSEFOR2k2M3psb0FsZjBqNldnZkdiSUcwQTZCYzJncTZQ?=
 =?utf-8?B?dVpBK0lPNE1DNnhoYmRXN0srekVhbUFrWWRnd0NtaG81bCtlZmxYUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 47598c69-a3b6-4933-587e-08dec5986709
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 19:59:08.8208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +cMpr8zKf+kvDAc3tyb7YLGUu3BvWnCkwbeFYmSYD0R1mzXBtS0undqpsmmGT/WmsUa5EuYUicd3mSM1CUYd1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7398

The current safety comment on `io_read`/`io_write` does not cover the topic
about alignment. Add it so it can be relied on by implementor of
`IoCapable`.

Expand the check `Io` by taking `self.addr()` into consideration when
checking if `offset` is aligned. For the compile-time `io_addr_assert`
check, check using the known minimum alignment of `IO::Target` and the
accessed type.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index dcf3b40ffa48..a58fb9a21dca 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -197,13 +197,15 @@ pub fn maxsize(&self) -> usize {
 #[repr(transparent)]
 pub struct Mmio<const SIZE: usize = 0>(MmioRaw<SIZE>);
 
-/// Checks whether an access of type `U` at the given `offset`
+/// Checks whether an access of type `U` at the given `base` and the given `offset`
 /// is valid within this region.
+///
+/// The `base` is used for alignment checking only. This can be set to 0 to skip the check.
 #[inline]
-const fn offset_valid<U>(offset: usize, size: usize) -> bool {
+const fn offset_valid<U>(base: usize, offset: usize, size: usize) -> bool {
     let type_size = core::mem::size_of::<U>();
     if let Some(end) = offset.checked_add(type_size) {
-        end <= size && offset % type_size == 0
+        end <= size && (base.wrapping_add(offset) % type_size == 0)
     } else {
         false
     }
@@ -222,14 +224,16 @@ pub trait IoCapable<T> {
     ///
     /// # Safety
     ///
-    /// The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
+    /// - The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
+    /// - `address` must be aligned.
     unsafe fn io_read(&self, address: usize) -> T;
 
     /// Performs an I/O write of `value` at `address`.
     ///
     /// # Safety
     ///
-    /// The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
+    /// - The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
+    /// - `address` must be aligned.
     unsafe fn io_write(&self, value: T, address: usize);
 }
 
@@ -311,7 +315,11 @@ pub trait Io {
     // Always inline to optimize out error path of `build_assert`.
     #[inline(always)]
     fn io_addr_assert<U>(&self, offset: usize) -> usize {
-        build_assert!(offset_valid::<U>(offset, Self::Target::MIN_SIZE));
+        // We cannot check alignment with `offset_valid` using `self.addr()`. So set 0 for it and
+        // ensure alignment by checking that the alignment of `U` is smaller or equal to the
+        // alignment of `Self::Target`.
+        const_assert!(Alignment::of::<U>().as_usize() <= Self::Target::MIN_ALIGN.as_usize());
+        build_assert!(offset_valid::<U>(0, offset, Self::Target::MIN_SIZE));
 
         self.addr() + offset
     }
@@ -320,7 +328,7 @@ fn io_addr_assert<U>(&self, offset: usize) -> usize {
     /// performing runtime bound checks.
     #[inline]
     fn io_addr<U>(&self, offset: usize) -> Result<usize> {
-        if !offset_valid::<U>(offset, self.maxsize()) {
+        if !offset_valid::<U>(self.addr(), offset, self.maxsize()) {
             return Err(EINVAL);
         }
 

-- 
2.54.0

