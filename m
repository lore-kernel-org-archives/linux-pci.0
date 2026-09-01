Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021101.outbound.protection.outlook.com [52.101.100.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2CF488224;
	Tue,  1 Sep 2026 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281451; cv=fail; b=jGzITqLz4Sc9EsYoujvVJ5MG9uBIdjPhVBUadNf9K1GQb3dJNtn0jld8Hwrye8ybcnf4Qb3mLRPVnV49qVizK6ey6RiXW3qDFMDIPcAbRMh6LZr8Ju7r9oPlFFihfXrfoFQwCXwJCUwpMimzorizyS7NrdgpoFsMU7DK5tNjPL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281451; c=relaxed/simple;
	bh=zEIOeiPp4a1yDOdPM6mIKhxZQ8hMqxFVFnTtfY+7bqI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nxziap3aB0OpgxrN5G3rsakvJ+Kw+3dmmVnR9iiFi/uYeyuFqY+nuSzoutQ48uOSbskvbllg2eKPSEhgLa68vaXAA+1jF1HRwGE1wY6DRcpZSv04gxvogncPk2s4Ebvw1jtJPqBm5+jLybsKVifWMoKvLMgyl5leRJ1MeDr6fZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ZalMD0Dq; arc=fail smtp.client-ip=52.101.100.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ZalMD0Dq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jg+ax6NPjXwNxLu4bmgqPTYJGxBQXG3t4wx23+WDeuM6qdCeJcBbvKekZiDMjjR91CpmQUiOk51ECL75PmUK4KVOII8C++qaszc4xojAJEai8IqQOTARPOClX/qbpSx8mpTBZFjnOv1uCBx/7Gdofpep5ezxkaSjvFeRWFSBFOGUJPS9DTGsCJRgtgXMb1BgQMg3upotZlVMr6SnrNnyN/801ovB59+pcMuHWeVhQE/nK4CCU9K8VStr1gEI7uFuaTw+nOfQikMXx0kUpyV49P0YMqMOQtkrRkNY+eL6k9IopBq06TX3H97jtgXWPG8VczFYinbMKtvmbFlRvL18Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCqwbtdaqZ+QP3nT+UsxF/pKPsWOYcZlWfV5Q0XGCkc=;
 b=RtNs3M+oQVXXCtZ41mamdaNYWoA67XrzwAx2PSeGZ1yoblhX5jBHG76VOKW5Pzxv1NGc/2ztGnz6lqE0JrUA3T+dFi33SkYJ3v7eh0R2nCOIhRq/g/DtblmNoj6CqOAANFCiUJUN5VVyohFDw1rdcYVPwhWfg0oR6qLwjpqA717tA5B3nkcwQuPLlBLz7juvsluwA4cR7n+q9cWeb7g7XeHmf+DsPyOR7KhDFNkYA+FhMXvjFxilDTTbT7jSkWRXU5QAOrV6Ar0aGvFaNYzLQ2rxgDOAH+0UPwXxED2MAnMKrd3lXnGd4FLAUK2i3CzD8Y+dS4oEjatcnozYtHnoBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCqwbtdaqZ+QP3nT+UsxF/pKPsWOYcZlWfV5Q0XGCkc=;
 b=ZalMD0Dq+eAEsLvAlIIkQjFDu1Luznw/yQQgiuKpvYfHsMijVZSyajIaCHbFXaGLQBhhDBf9I46l+9+2Kr4777S2Z1TmGxMfRuarv18urp61RYlxLKWbmCBxDw/W/oatebHSXsnPVPc/29lhm1Vu80mGhD2MqIasUDz0bCqj4AQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CW1P265MB9199.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 16:50:42 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 16:50:42 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 01 Sep 2026 17:50:35 +0100
Subject: [PATCH v4 11/16] rust: io: register: support fixed offset register
 without bitfield
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-typed_register-v4-11-5552b1d59525@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788281431; l=8003;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=zEIOeiPp4a1yDOdPM6mIKhxZQ8hMqxFVFnTtfY+7bqI=;
 b=SFk/cHLNnbV2FfHDTmt3JssIWyqe/UeG42qFroyd6eKi5q6hp5TxIGAabf8eZbXi8LRcPPQrq
 ibjYkIH9Jz6BxJp3x1A7vA5zdy5KtfbLFrbNHKWRGmxdpUJd7q/bLVK
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
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CW1P265MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: 33f4f20f-9fbe-4673-4f79-08df084928da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|10070799003|376014|23010399003|366016|921020|3023799007|10067099003|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xthVSC91G8LM21dfbm30fQuH9SeylS5RHqvXkAe4/9OvlgDCoZPWfb87euIY6xUuA4gWhwU+/fdVmtH6L6wksmwjolOh2v0Ef6OG+GP0jrsIDojG9hEfDzg4MoZiR+xfbtZYEkVjUaQtWO697BQKRWC8LE8iSNEqy42flkzRCAhm4jXEoA9yLcVjAO2Hb3U81rHOj6ywWS0qCmhOgA9kJEKwF1Xck8s/BQ8/vkkQnrPWjKyKjxypMdRSq6HDQq3hr1hYEFkGFdkBKZQqwhdNi/3BeoZTNNqtwFmwT51z0lQjCsWApXeHyEuk38ko0unoocENdd2XR4BHM1+KXCt+dyuOSigT3pw++9j7yMywkW9XXP0JqjlQeVF+cLWEcZHKOtPYpOoN2wWO695cDaIu373ZtUu2MpPGqhZ/HodIgqU3BiqHqBL9/w6c3p+48l9nvELrOpBaotRagoDIwpexQ42a/zdfwh+JLjqBSRQ6gwoMGpz+Zlxe7u2GpxYSm3t0k4ZY67Ic+g4zMJ3kENXoOsbH6kj1blG8EYxiOVLRt7cqjK6QMO1GY9hQJ7+cWzqApo77Dma8mbHarGUStLCDFPoROBBKXBJGgQ3nwC0vVoVZyTgfXT4/X0XlC8F6sFe6T2vb05xAsFVziZJm4q/IvOdMk0G/C/2g/pir/SgjnOK895ch6G2t+Lo2H5iYvFGGMw07wHLmlsOPYAZD9P5W1w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(10070799003)(376014)(23010399003)(366016)(921020)(3023799007)(10067099003)(56012099006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmJ1NmgxZTRzc1pmazE3WC9GOW8wcFlFNjRxN3VsMi9ZZXlFdlU4SlM3SVlZ?=
 =?utf-8?B?VVV3dFB5S1FTQ3U2ajlHZTgrWU04SkRLZktQbmlnSFZ0Y2ZFM0E5LzB3UzBt?=
 =?utf-8?B?T1NLUWEwN3E3Zk4vZjNDdStObnhsVFR3eEtYcHJCSHlkSCthMXUyQUtud0dl?=
 =?utf-8?B?cFZrc3N5QmNtUDVMbmlwVFZFNkQxMTFDYkZpUFY5c2d0WFJtdGcyK1BTS3ov?=
 =?utf-8?B?NytHMVJvRkh4UmNNTnNoUUUzMDNoeWhSVnBrRDJMV3o1MmNqZ001R1Z0c1I1?=
 =?utf-8?B?bGtILzZuRFZ2RFhUa2Y2M1NPb3dQbFljT21USnZmMmtVYVptVUlleGdZYTB0?=
 =?utf-8?B?UUpmenNKMXV3T2hOdUFDYUpJek5pQTgzNjJhQWZ5WGYvaTRDTkFLdmNLRjh1?=
 =?utf-8?B?YmFCRU44a2FuVWE0YVc5Y3ZpM3BrSjZGZkYrSlB3dHcwL0NVMy9IRFljNzRN?=
 =?utf-8?B?S3JrNE9EenUwc0lHakNPZDQ4Y05tajhzQndlQTFuTDBJZ2VGenZWcGZHemJa?=
 =?utf-8?B?T09TaHR4RHlPUzZ3Mld6NlJaZG5FcmZDcmtRRjA0YWJFRVBHWVRnd29keUUv?=
 =?utf-8?B?SlVVSENGQndqdWlodUgwTGp5MStGNXNCemVFSng1SXdnTGxlaENnZG9STW9L?=
 =?utf-8?B?Znc2UUVwbC95Um9TRnhEZ2NBaEJISFl0RG9WVXZGelFYbW5rLzVidzUxWEVF?=
 =?utf-8?B?THNyWjY0RENIR2wvWDNBU1RURnlUSlNPMlQ0UmVRNXRzRG5uZy92NnNpQVdq?=
 =?utf-8?B?NUtvS1YyVDRYWGZBS1d1ZExNdURsWnVEMkhXQ1ZXK1dodlJGeDNuMmFnSjQw?=
 =?utf-8?B?M1pteDlXYkxlelZ6UzJidGpQSFZXME1oMWN6LzlmUWJLVU5BcnloeVpXejhj?=
 =?utf-8?B?NGV4SVU4bXhyMDBiMUx4QXBmUjVjWTNaRTAzeDdnY2h0TGMrQmw4aUJ6RDV5?=
 =?utf-8?B?eXFodm5TWkxwc1VmVEIxc2lnSGo0YkZJazM3UVU0T3ZneXYwVHBkemlONDJk?=
 =?utf-8?B?VGxyU0RMZVgzQll4TTA2RUF4RXRpUk54VlRQdlJaL3Y1eHJYejRFS09YamN5?=
 =?utf-8?B?dTlRYzdheVpSKzJoSUpxd0VjMDJnOUtqbzR0aVNYc1hKWDlwQUZTTS9qdzk1?=
 =?utf-8?B?WThpNmE0R2xwakVwWXM3UU5FdTMycllHQ2UzZHJmMnByMzRjV0FpZUZvb09v?=
 =?utf-8?B?Q2M4eXhEOVhGNU5yMlgwZStJVkVkV2VsbHBCTnpoVzdYV2JwZ2JGY05oa0li?=
 =?utf-8?B?L2wvVHNIdlZCSkcvbFc5RVk5cE5zR1ZlOWkvK2pDd1kwcjBvYXFKZ2dJTHFw?=
 =?utf-8?B?eEhKNWFTUWV6alVyT3NUTXByVlFYd0dXSnhhbEJBdHB5RThLT0F1N1kyaUFT?=
 =?utf-8?B?QzVjQ1R4L2lPQWE5VUgzUUgzcWhTazlFRnIrMVNkdjdzQkEwQjQ5MThxYitq?=
 =?utf-8?B?WTA3ODJIWmJYUkNuV2JrQWR5R3RSU0RiWUNJU01kdGVqS1RmYmdmeVJrbXd4?=
 =?utf-8?B?c3p3Mkt2VmNhYUVGM2gzWVRXTlAxdStVRi9XdzVYZVVHcUdWakJvMWZUTU9F?=
 =?utf-8?B?UnM3L015dFgyVnNMa1pCb29SVkMwcWhRUWRESE5QY08yNzEzelRzVG14YnJQ?=
 =?utf-8?B?M1dIb3FKVU1SVTgzTmQ4S2FHd0ZSQU1Vb1Y0ZHVvUWY3VXF5OXUyWkh2cnk0?=
 =?utf-8?B?VURpQzRHRlZvSDlkOGNuMkpJaUJBVzkrU014NHdGNWFSdHVCWER6SGxYaFJo?=
 =?utf-8?B?ODkxTThIMWtwclZ3Z2RlMDViL24yaDAxbkVpZ1h5ZVIwbTN3dHVhOWdhSDBG?=
 =?utf-8?B?RVYxZldyUlJ6VWEza1Vybm1IMEovdG15S0d4aUlnNklPeTF5WjRrSDlXVE9z?=
 =?utf-8?B?d3pRandiMjJUVDFsSGJFWmRaZU9QMHhlczQ3SUdyR3htNEQ3Ylp1dUNja0R3?=
 =?utf-8?B?WWlzbEFDMExrSTNFUWc3dHJmRXkyWVFmcXl5SzNwZ2IvSU50L1VCQnF0Wnls?=
 =?utf-8?B?MFd6SWpnU1VhKys4NUYraDBuUXo5MUlRMmhiMTB3VnB5OHA3UXNGelJiTURX?=
 =?utf-8?B?VlNucVFQNHRSdXY2bWhSeW9vcHZlRGFoUWE3RTFtZ1BqYjFYbytNMVdVT0Uy?=
 =?utf-8?B?U1VTU0RsN2YzbHd0RWlsOWszQmhCSkdVYVVnbEs4Ui81VGNTbkI4aWd2andL?=
 =?utf-8?B?bEIrT1NaUnZiV1oySDRDaHlUMVJ3dVdjdThZTjdac0lYTlZWUDlHMnhPNFNj?=
 =?utf-8?B?R1duUS9JajBFYld4R3NQNzd2ZmQ5U0RUMWdROE9lcDI4T1dUSThYQ21YOStF?=
 =?utf-8?B?SWVFR2hmN1I0cGI0ZVBnanJ5WENyQnE4MkxhbVRPbHVxSVFnVWp4dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f4f20f-9fbe-4673-4f79-08df084928da
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 16:50:42.1747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mziR4W098qt9DAa70DRtPMO+1cWyFonp1m8yRu0h/c5pxnKoh/eHKVOx+MIr/qijwqeRSi0kaMJI5M5hnocclA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB9199

Add a rule to allow creating `IoLoc` in `register!()` using an existing
type and not create a bitfield. Add an example to demonstrate this for FIFO
registers.

This rule is also going to be used to create subregions for registers; the
example of doing so will be added later when relative registers are
removed.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io/register.rs | 31 +++++++++++++++++
 rust/macros/io/register.rs | 84 +++++++++++++++++++++++++++++++---------------
 2 files changed, 88 insertions(+), 27 deletions(-)

diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index 58dcf651dfd0..b9cb4fce8628 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -182,6 +182,24 @@ fn offset(self) -> usize {
     }
 }
 
+// Provides a `IoLoc` impl that for a fixed offset.
+#[doc(hidden)]
+pub struct OffsetLoc<Base: ?Sized, T>(usize, PhantomData<(T, Base)>);
+
+impl<Base: ?Sized, T> OffsetLoc<Base, T> {
+    #[inline]
+    pub const fn new(offset: usize) -> Self {
+        Self(offset, PhantomData)
+    }
+}
+
+impl<Base: ?Sized, T> IoLoc<Base, T> for OffsetLoc<Base, T> {
+    #[inline(always)]
+    fn offset(self) -> usize {
+        self.0
+    }
+}
+
 /// Trait providing a base address to be added to the offset of a relative register to obtain
 /// its actual offset.
 ///
@@ -520,6 +538,19 @@ pub const fn element_alias_offset<Base: ?Sized, Alias: RegisterArray<Base = Base
 /// In this example, `SCRATCH_BOOT_STATUS` uses the same I/O address as `SCRATCH`, while providing
 /// its own `completed` field.
 ///
+/// If you do not wish to have a bitfield defined, you can also create a register using an existing
+/// type.
+///
+/// ```no_run
+/// # use kernel::io::*;
+/// register! {
+///     base: Region<0x1000>;
+///
+///     /// UART RX register.
+///     pub UART_RX: u8 @ 0x100;
+/// }
+/// ```
+///
 /// ## Relative registers
 ///
 /// Relative registers can be instantiated several times at a relative offset of a group of bases.
diff --git a/rust/macros/io/register.rs b/rust/macros/io/register.rs
index f603f4e45565..b3262e9c06a1 100644
--- a/rust/macros/io/register.rs
+++ b/rust/macros/io/register.rs
@@ -16,6 +16,7 @@
     bracketed,
     parenthesized,
     parse::Parse,
+    parse_quote,
     spanned::Spanned,
     token,
     Attribute,
@@ -62,11 +63,11 @@ struct Reg {
     attrs: Vec<Attribute>,
     vis: Visibility,
     name: Ident,
-    storage: Type,
+    ty: Type,
     array: Option<RegArrayDef>,
     relative_base: Option<Path>,
     offset: RegOffset,
-    bitfield_args: Group,
+    bitfield: Option<(Type, Group)>,
 }
 
 impl Parse for Reg {
@@ -74,11 +75,22 @@ fn parse(input: syn::parse::ParseStream<'_>) -> Result<Self> {
         let attrs = input.call(Attribute::parse_outer)?;
         let vis = input.parse()?;
         let name = input.parse()?;
-        let storage = {
+
+        let lh = input.lookahead1();
+        let (ty, bitfield_storage) = if lh.peek(Token![:]) {
+            let _: Token![:] = input.parse()?;
+            (input.parse()?, None)
+        } else if lh.peek(token::Paren) {
             let content;
             parenthesized!(content in input);
-            content.parse()?
+            let bitfield_storage = Some(content.parse()?);
+
+            // For bitfields, bitfield macro will generate a type with the same name as `name`.
+            (parse_quote!(#name), bitfield_storage)
+        } else {
+            Err(lh.error())?
         };
+
         let array = if input.peek(token::Bracket) {
             let content;
             bracketed!(content in input);
@@ -133,22 +145,28 @@ fn parse(input: syn::parse::ParseStream<'_>) -> Result<Self> {
             Err(lh.error())?
         };
 
-        let lh = input.lookahead1();
-        let bitfield_args = if lh.peek(token::Brace) {
-            input.parse()?
+        let bitfield = if let Some(storage) = bitfield_storage {
+            let lh = input.lookahead1();
+            let args = if lh.peek(token::Brace) {
+                input.parse()?
+            } else {
+                Err(lh.error())?
+            };
+            Some((storage, args))
         } else {
-            Err(lh.error())?
+            let _: Token![;] = input.parse()?;
+            None
         };
 
         Ok(Self {
             attrs,
             vis,
             name,
-            storage,
+            ty,
             array,
             relative_base,
             offset,
-            bitfield_args,
+            bitfield,
         })
     }
 }
@@ -188,11 +206,11 @@ pub(crate) fn register(def: RegDef) -> Result<TokenStream> {
             attrs,
             vis,
             name,
-            storage,
+            ty,
             array,
             relative_base,
             offset,
-            bitfield_args,
+            bitfield,
         } = reg;
 
         // Use register name's span for generated code, so error messages (if any) can point to it
@@ -213,21 +231,33 @@ pub(crate) fn register(def: RegDef) -> Result<TokenStream> {
             }
         };
 
-        outputs.extend(quote_spanned!(span =>
-            ::kernel::bitfield!(
-                // `#[allow(non_camel_case_types)]` is added since register names typically use
-                // `SCREAMING_CASE`.
-                #[allow(non_camel_case_types)]
-                #(#attrs)* #vis struct #name(#storage) #bitfield_args
-            );
-
-            impl ::kernel::io::register::Register for #name {
-                type Base = #base;
-                const OFFSET: usize = #offset;
-            }
-        ));
+        if let Some((storage, args)) = &bitfield {
+            outputs.extend(quote_spanned!(span =>
+                ::kernel::bitfield!(
+                    // `#[allow(non_camel_case_types)]` is added since register names typically use
+                    // `SCREAMING_CASE`.
+                    #[allow(non_camel_case_types)]
+                    #(#attrs)* #vis struct #name(#storage) #args
+                );
+
+                impl ::kernel::io::register::Register for #name {
+                    type Base = #base;
+                    const OFFSET: usize = #offset;
+                }
+            ));
+        }
 
         match array {
+            None if bitfield.is_none() && relative_base.is_none() => outputs.extend(quote!(
+                #(#attrs)* #vis const #name: ::kernel::io::register::OffsetLoc<#base, #ty> =
+                    ::kernel::io::register::OffsetLoc::new(#offset);
+            )),
+
+            _ if bitfield.is_none() => Err(Error::new_spanned(
+                ty,
+                "defining without bitfield is not yet supported for this type of register",
+            ))?,
+
             None => match relative_base {
                 None => outputs.extend(quote_spanned!(span =>
                     impl ::kernel::io::register::FixedRegister for #name {}
@@ -249,12 +279,12 @@ impl ::kernel::io::register::RelativeRegister for #name {}
                 let stride = if let Some(stride) = &def.stride {
                     outputs.extend(quote_spanned!(stride.span().resolved_at(span) =>
                         ::kernel::build_assert::static_assert!(
-                            ::core::mem::size_of::<#storage>() <= #stride
+                            ::core::mem::size_of::<#ty>() <= #stride
                         );
                     ));
                     quote!(#stride)
                 } else {
-                    quote_spanned!(span => ::core::mem::size_of::<#storage>())
+                    quote_spanned!(span => ::core::mem::size_of::<#ty>())
                 };
 
                 outputs.extend(quote_spanned!(span =>

-- 
2.54.0

