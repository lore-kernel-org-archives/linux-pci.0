Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022126.outbound.protection.outlook.com [52.101.101.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EE14A2E10;
	Thu, 11 Jun 2026 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195332; cv=fail; b=TPBVpaeDRE+Iz/y4GS/f726JwR2dYZYSfZwM/x0q0Xor90+AdtGEtTuLDb37kCeeGTNmyg3FmGJmLTKCt++lrJghkRM8yWyl/bHqJFESIu92ogyweQzM0wBaIy0Jw5ArxH3IUb2zrZv0FQjnYY+QrJ+mZF6AzEl1ckG42541wk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195332; c=relaxed/simple;
	bh=jwpOL+8onvWtIguzV59vIP2zyg5diaxn32RlHDnn1Gg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=H0kZf0Wi4KDumFoGKJrvTN90vQDzW/Xsu/8OYxsu1IOvuRxtNvGG1us5uHVWx1qADAsZAx63SlXoBPhae+HQfyTWE3Kit5cM6zR+ck2cm91SrAYW/b8fvFo+/pmoqpp2ajuUS4IvnH16jbhTxukIZNcGiySr1ru5l0ssg7GtFTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=uGPObIUx; arc=fail smtp.client-ip=52.101.101.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="uGPObIUx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVdmpd3JKygNH4wHQT82r0pY6N3nF23WcofrLTz2zmKnTO/mU12qCJv1z7mFPKrbE0euk5qmaMS4dU5bkpb5tcHKGeTPDnibJNNk54l2u2lwKjMVr8T+H/JfDdpWrMGweG5iRELIrXfla4qZX/jWEnBPrxNqsRZe6nMrfBK/GUU2mjfxtgqXeFEl8/VPX6iLRvP1nAagrus//VVGI3IkhG+xjwAUXLFx3He5y1/Dt8GfG/e4I1rhbMlRumF45VDTVtDMtpkSvq8M15TQ7dvQnfJwA+cNmPqcvvCz1pkkLdOp9mwvUvh3chfrsFdabSSE1XfxJkjRIkdeUJrLowVKJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCVwIbTNS4Ld6i4HIC/5quYTYSjv320ziVokMa2TFXw=;
 b=P2nakvRWa2n+VOx4VqDTEs6sBB35mzc5uALF9EABkb+6uej65QYdHEQyuau1drhoXKhdJRO4LodTHGMsvTiiQTZsr1Bj6jf6oeqyGb+zOmHs71ln9eIK2k8PTOrxN+W98/VJGJToRbUgSmBwgtzoLjfXPUz4vi6PqMPfr7z128QC25C04s6EwEFqo3Jt5U6TR0T6dGzlrGZJ4PawOx1n5SEiL36vs99Flka6Mo81vKbG2CVGvmx4AnpVQ3JhHfTaKmYwUcJkBKtmXEtxr48v4VWVvlgn/4DyIelshB3trJRGzgr3nOu72spB3yzaBzraRYtAQLR/fHOYuUNhBEwOmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCVwIbTNS4Ld6i4HIC/5quYTYSjv320ziVokMa2TFXw=;
 b=uGPObIUxkBtCGG3a9gtcIsDh5D9+k5GntMuGYzp0CUONlDBK/mVuwcyEK6dR6TN9FXsekagajwtcJCoFVbuIjflJCYOpiSZbTKo2/EZ1e6Iz6T9Kp+11ixq29dosYWGZWNM5AJRDdbqqUoopOb3WSfbYTRBGYD18qRjYvSec7uA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO4P265MB6525.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 16:28:33 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 16:28:33 +0000
From: Gary Guo <gary@garyguo.net>
Date: Thu, 11 Jun 2026 17:28:20 +0100
Subject: [PATCH v4 18/20] rust: dma: drop `dma_read!` and `dma_write!` API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-io_projection-v4-18-1f7224b02dcb@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781195302; l=8864;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=jwpOL+8onvWtIguzV59vIP2zyg5diaxn32RlHDnn1Gg=;
 b=Dw/uRpp9JFOqgDpEN11O2fB0xrpBa1HLOGCIiwu+lyBAguYvVvy3Ieo2Rbqc4wV7wfQACInli
 SogeJHP1suAAn0djAB0PAeEnwF1uiDaFYvXnTe8V/P28wder8/MSSpS
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
X-MS-Office365-Filtering-Correlation-Id: 4a895751-d97b-4b54-6b55-08dec7d67ada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10070799003|921020|6133799003|56012099006|3023799007|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2/zg+cr6djZnOu/sNg5fmxH0tu/wdwdQ8jHBiWBn7fIMES9gstF5a8/Tbnrczrb1uN/REqvqSPTVOXPl/5n1F0b9mDUl3KmmrzhpFpSPeqGL0i9b8TKW2LuQ1rUBbgyEm/1gi+p+ijG4SomabcxG7zDAIxMNgskCiUj2oshbE21/aByI4AdyfheACRpXCsrZNaHnsyRLJFIKgq0f/YJh35p1nV7aI8ewuq0L8JpF0HD2Gylj7B75Ec1SjEKvR5NwBowD9nOxWD9W4fUMtAMqFqweJwYaLZW0xzWD/4PDCGhexTtFqs4uk4QadBSJdvruXUm7LvHnnh5ihekGCPmoHieMmaGXO5j2ZDKs9F3iCGSWwiblvjiLPMKh9xSaamyTBJ567YUcA2/nu9DYcvqIWUEg6UFWZR06ogzTV60xMDh1kSWrllaUyXcpKhrMXxy1FiY8N9d7Xghq/6g0D+/YRPnFvUTKzsMxCftzmMrwYgEVRg7p3tMFVXYEQIjXafZbWDjGl+IqDECxNDO4FQnzFEbBizpt8DVX5p3neWk6nGnKQtRoiSCbjxONCfgMtnxxDli4LmoFMjckqTKBgjoTcOIE07ntysysPU0M/MUIMDtDBdZ6IHz8Lw/lVo0pNX+MCzFA5Isv3Cl0dMxYC2GgKYFYqVBmiABt7ztB563XujEbg/6P+BtsQNT3xpLma1iJSAl9AL0dMOIieuJT2ueAMzZF9givcBSAFMWKgCf09F0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10070799003)(921020)(6133799003)(56012099006)(3023799007)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1RLbHowV01hVEV4clo1eXkzcFBqcWVsOXFWUnh5aVJoWG43dGJlQlJ2MzFJ?=
 =?utf-8?B?UUlVcnRRT0lkZ0tVdTdXVjJCTThFTTg3aUpZR1hqbkpzOVRwNitZS284dGNv?=
 =?utf-8?B?L3cvT2VGbDlvNlJzYjFScGlMOWQ2RXEzRGJyeWpBU0oxREpnUk5od0xWQ2RB?=
 =?utf-8?B?cUNUck1VY1Mxc1hsSEFGSFRhc3pSVS84dS9EMUtlOWZYdldhL20yNHNkWDcr?=
 =?utf-8?B?NlBqOWhyc0VvSXNvSWk5dEZHWW9oWm5hQ0p3Tm5FTmh1Skp5b1FUMjhDcFFt?=
 =?utf-8?B?a1JaOE1GSTVRNjdhbkdXS1NDZ2FkZnlqdWp3V0cvdzl6SytNcnp0T2tMSTFU?=
 =?utf-8?B?cjR4WW93T1pvNW8rSytkOFF5R3MySEk0WU9hYXIwY2trM25hOGRyTkhQUGx0?=
 =?utf-8?B?K2hiQXJVdng4TTc4QVRrWGVJQTREV1RzK1p2L1Jkd1ZYSVNHTTZiWEtIbXVF?=
 =?utf-8?B?VVRzNWxTQ0JJT3N3SXNuVXRRSU5LdzFNejQyUHpVU1VOZExFcEpid2duUHQ0?=
 =?utf-8?B?enk5OUpDS0dBUlh0djd6b1p3TE4zL2hSWHR2cmhZOWZYMWJWWmZNQlIwSHBG?=
 =?utf-8?B?dmxsTlE5dW1SSzQ2VEs3S1FWeXg4U1VQZXljVld5TkhhQ0RuYkQwUFdWK3E1?=
 =?utf-8?B?eUhtdkJWTnBoT2NKeUcyQlhBM1JYRTRVYzVCUWFpWFg3STJDLy9OOGJRcXFC?=
 =?utf-8?B?cDdyQVB1eXY3MmZGUVoxdUF0cm1oWVk4cmt1Z045d3U1bXhQM1lYakFnblRI?=
 =?utf-8?B?N3lQU2g1dUpsUkhlelNJdUtZNnNJdUNudm1RTVdaN3lvaGNoZ041VVdobWdP?=
 =?utf-8?B?WFppWnZNUUcwUmM4SnpPYUppRFlDeTN6Q0pJbllaTEx5QVBZMzE3WUlsLzcz?=
 =?utf-8?B?VEdRdTJFV0NHL1RlZ3JsUjFzMTBQaldITXQ3RExUdXRWdGp0b1M3NzNZWnYx?=
 =?utf-8?B?YXduUWVFMGNSUjRxeFRvZlh2c3ZpdUpYL3hRWTl4NnRXRWxpT0RxTU9MVEJ4?=
 =?utf-8?B?enVEN2ppZkF3bHpmd1dTSU4rK0kwaDlBWTJUWFdsOEEzT1VkaVVha3AraXZP?=
 =?utf-8?B?SzVhODZsTlJhK25rVEk3VjZjdXowaDJnR2dmWWdJTWFVVTVVRjNOOFRPNldX?=
 =?utf-8?B?YkhVMXhTcjVMMmw2clNjRDBvSHYwaFFBQlRVVG9ubnRvSlZKcE5tcWtEZVRJ?=
 =?utf-8?B?RVdrSUZTVDUxcWhYVGIxY2Q4WGUrUEVPNnp3TDlTazVkSGh0RzlJNmE2ZVBq?=
 =?utf-8?B?MzdaN1c0NVJvNXd5QlIrUFR2K3M3aGltSTJ3MUdWSmYxanNEM1NmaFF6YlFu?=
 =?utf-8?B?U2dHbWVLU2VoVDZLbmZnL296U1BPcUZqdUM5QllPVzM4OUZoQjRiY2h5cWVV?=
 =?utf-8?B?eTlHbUtOMWZrWFc2MUhVRzdoU2c2MHdTM0tuVGtIazhvMGw2VXVpNldJRGN6?=
 =?utf-8?B?bVRVRnVUZ3N2R0tyaUtMUXF6Q3JTOTkxa1Bvd3JoNS9sRlgrUDlqSVB2bTZF?=
 =?utf-8?B?cWpJaTRvMnNERFB0dEFPZEN2eG1VM1RnMUVOSVMzQWRoM2dDUTMxY1VsTWR4?=
 =?utf-8?B?ckhlcVRmNlFRSlZwUWN3bm9aSHV5aVA2cmJPZE5zTFRLSlBieVEyNDJXaTBP?=
 =?utf-8?B?OEg0NnQ2cDlVaWU1WEUzVlpTZXJPcVp0UktUZHgydTRvUUFuc0M2aDI2WjhZ?=
 =?utf-8?B?ZHd0ci8zbzZUSDUrcWljbkgxcXhYVW80bTBOYmJXNGo1M1cyd2I0cmJ2bnFi?=
 =?utf-8?B?TnJCTmNPRE5qRnV5QzNTdXMvQUdURmxGaFRhU2RyejBOZTV6QVVrMER2MXRH?=
 =?utf-8?B?K0VuSXdYOGpKNUVqZkVPbkQ4U251RFBrS0NjeXBBbGtkOTZxVEtFdHNvVEtN?=
 =?utf-8?B?QlpSbDZNUDNhdlAzR2J6d05uUVdDdXA4MEZ2b0srVEdBR2JybEJYcXk5c3dW?=
 =?utf-8?B?N2d6ZmdhZi9GeTFTeFUrZE94SWk4MEcxcEJVeTYxcytNUHBhVUpCVU5XSzdD?=
 =?utf-8?B?TGk2ak5yYng3K3l3aDR3OC9pK1NmOHY1ZVUyNUxvMkNSc281N3JzQjZjeTRV?=
 =?utf-8?B?Y0xyQ1RFRWYwby9ONUkxY0VaeVpkcVZVLzhMeWlnVStiRVdIOVdlUE0vS1dj?=
 =?utf-8?B?SG5aTGRCeUxqZFZaUkRUZmN5RlBrd3JkSkFmU2N4Vld6YWtUbG93NVFxNVh6?=
 =?utf-8?B?M1Q4Q3NzVGpzbHRiN1dPN3pQSFRVRDdyQjQzanBMVmF6WjZ6RWhnV1hVd0hH?=
 =?utf-8?B?Y0QxWVNEZm5sU3ViYTY4azIwVktxWWdkTmNFNmIyM3g3NWIvOE1SbWM0ZnpE?=
 =?utf-8?B?YXYxY1gxaklvaUhMT0p5Zkl5S3Bwdis0bkU5S3dnYms1UXFMbU1Ddz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a895751-d97b-4b54-6b55-08dec7d67ada
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:28:33.2185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O2av2+OxSKkLNV0H+7DA+hVgyuhuw62B7D+LbjNM6SdqErgAeXnyRmrkW51aN0ExCnowD46Rs7x4WmADLeBCAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6525

The primitive read/write use case is covered by the `io_read!` and
`io_write!` macro. The non-primitive use case was finicky; they should
either be achieved using `CoherentBox` or `as_ref()/as_mut()` to assert the
lack of concurrent access, or should be using memcpy-like APIs to express
the non-atomic and tearable nature.

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/dma.rs       | 128 -----------------------------------------------
 samples/rust/rust_dma.rs |  13 ++---
 2 files changed, 7 insertions(+), 134 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index ab6504910e4f..0ff4cce8e809 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -661,52 +661,6 @@ pub unsafe fn as_mut(&self) -> &mut T {
         // SAFETY: per safety requirement.
         unsafe { &mut *self.as_mut_ptr() }
     }
-
-    /// Reads the value of `field` and ensures that its type is [`FromBytes`].
-    ///
-    /// # Safety
-    ///
-    /// This must be called from the [`dma_read`] macro which ensures that the `field` pointer is
-    /// validated beforehand.
-    ///
-    /// Public but hidden since it should only be used from [`dma_read`] macro.
-    #[doc(hidden)]
-    pub unsafe fn field_read<F: FromBytes>(&self, field: *const F) -> F {
-        // SAFETY:
-        // - By the safety requirements field is valid.
-        // - Using read_volatile() here is not sound as per the usual rules, the usage here is
-        // a special exception with the following notes in place. When dealing with a potential
-        // race from a hardware or code outside kernel (e.g. user-space program), we need that
-        // read on a valid memory is not UB. Currently read_volatile() is used for this, and the
-        // rationale behind is that it should generate the same code as READ_ONCE() which the
-        // kernel already relies on to avoid UB on data races. Note that the usage of
-        // read_volatile() is limited to this particular case, it cannot be used to prevent
-        // the UB caused by racing between two kernel functions nor do they provide atomicity.
-        unsafe { field.read_volatile() }
-    }
-
-    /// Writes a value to `field` and ensures that its type is [`AsBytes`].
-    ///
-    /// # Safety
-    ///
-    /// This must be called from the [`dma_write`] macro which ensures that the `field` pointer is
-    /// validated beforehand.
-    ///
-    /// Public but hidden since it should only be used from [`dma_write`] macro.
-    #[doc(hidden)]
-    pub unsafe fn field_write<F: AsBytes>(&self, field: *mut F, val: F) {
-        // SAFETY:
-        // - By the safety requirements field is valid.
-        // - Using write_volatile() here is not sound as per the usual rules, the usage here is
-        // a special exception with the following notes in place. When dealing with a potential
-        // race from a hardware or code outside kernel (e.g. user-space program), we need that
-        // write on a valid memory is not UB. Currently write_volatile() is used for this, and the
-        // rationale behind is that it should generate the same code as WRITE_ONCE() which the
-        // kernel already relies on to avoid UB on data races. Note that the usage of
-        // write_volatile() is limited to this particular case, it cannot be used to prevent
-        // the UB caused by racing between two kernel functions nor do they provide atomicity.
-        unsafe { field.write_volatile(val) }
-    }
 }
 
 impl<T: AsBytes + FromBytes> Coherent<T> {
@@ -1265,85 +1219,3 @@ fn as_view(self) -> CoherentView<'a, Self::Target> {
         }
     }
 }
-
-/// Reads a field of an item from an allocated region of structs.
-///
-/// The syntax is of the form `kernel::dma_read!(dma, proj)` where `dma` is an expression evaluating
-/// to a [`Coherent`] and `proj` is a [projection specification](kernel::ptr::project!).
-///
-/// # Examples
-///
-/// ```
-/// use kernel::device::Device;
-/// use kernel::dma::{attrs::*, Coherent};
-///
-/// struct MyStruct { field: u32, }
-///
-/// // SAFETY: All bit patterns are acceptable values for `MyStruct`.
-/// unsafe impl kernel::transmute::FromBytes for MyStruct{};
-/// // SAFETY: Instances of `MyStruct` have no uninitialized portions.
-/// unsafe impl kernel::transmute::AsBytes for MyStruct{};
-///
-/// # fn test(alloc: &kernel::dma::Coherent<[MyStruct]>) -> Result {
-/// let whole = kernel::dma_read!(alloc, [try: 2]);
-/// let field = kernel::dma_read!(alloc, [panic: 1].field);
-/// # Ok::<(), Error>(()) }
-/// ```
-#[macro_export]
-macro_rules! dma_read {
-    ($dma:expr, $($proj:tt)*) => {{
-        let dma = &$dma;
-        let ptr = $crate::ptr::project!(
-            $crate::dma::Coherent::as_ptr(dma), $($proj)*
-        );
-        // SAFETY: The pointer created by the projection is within the DMA region.
-        unsafe { $crate::dma::Coherent::field_read(dma, ptr) }
-    }};
-}
-
-/// Writes to a field of an item from an allocated region of structs.
-///
-/// The syntax is of the form `kernel::dma_write!(dma, proj, val)` where `dma` is an expression
-/// evaluating to a [`Coherent`], `proj` is a
-/// [projection specification](kernel::ptr::project!), and `val` is the value to be written to the
-/// projected location.
-///
-/// # Examples
-///
-/// ```
-/// use kernel::device::Device;
-/// use kernel::dma::{attrs::*, Coherent};
-///
-/// struct MyStruct { member: u32, }
-///
-/// // SAFETY: All bit patterns are acceptable values for `MyStruct`.
-/// unsafe impl kernel::transmute::FromBytes for MyStruct{};
-/// // SAFETY: Instances of `MyStruct` have no uninitialized portions.
-/// unsafe impl kernel::transmute::AsBytes for MyStruct{};
-///
-/// # fn test(alloc: &kernel::dma::Coherent<[MyStruct]>) -> Result {
-/// kernel::dma_write!(alloc, [try: 2].member, 0xf);
-/// kernel::dma_write!(alloc, [panic: 1], MyStruct { member: 0xf });
-/// # Ok::<(), Error>(()) }
-/// ```
-#[macro_export]
-macro_rules! dma_write {
-    (@parse [$dma:expr] [$($proj:tt)*] [, $val:expr]) => {{
-        let dma = &$dma;
-        let ptr = $crate::ptr::project!(
-            mut $crate::dma::Coherent::as_mut_ptr(dma), $($proj)*
-        );
-        let val = $val;
-        // SAFETY: The pointer created by the projection is within the DMA region.
-        unsafe { $crate::dma::Coherent::field_write(dma, ptr, val) }
-    }};
-    (@parse [$dma:expr] [$($proj:tt)*] [.$field:tt $($rest:tt)*]) => {
-        $crate::dma_write!(@parse [$dma] [$($proj)* .$field] [$($rest)*])
-    };
-    (@parse [$dma:expr] [$($proj:tt)*] [[$flavor:ident: $index:expr] $($rest:tt)*]) => {
-        $crate::dma_write!(@parse [$dma] [$($proj)* [$flavor: $index]] [$($rest)*])
-    };
-    ($dma:expr, $($rest:tt)*) => {
-        $crate::dma_write!(@parse [$dma] [] [$($rest)*])
-    };
-}
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 5046b4628d0e..6727c441658a 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -12,6 +12,7 @@
         Device,
         DmaMask, //
     },
+    io::io_read,
     page, pci,
     prelude::*,
     scatterlist::{Owned, SGTable},
@@ -73,11 +74,11 @@ fn probe<'bound>(
             // SAFETY: There are no concurrent calls to DMA allocation and mapping primitives.
             unsafe { pdev.dma_set_mask_and_coherent(mask)? };
 
-            let ca: Coherent<[MyStruct]> =
-                Coherent::zeroed_slice(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
+            let mut ca: CoherentBox<[MyStruct]> =
+                CoherentBox::zeroed_slice(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
 
             for (i, value) in TEST_VALUES.into_iter().enumerate() {
-                kernel::dma_write!(ca, [try: i], MyStruct::new(value.0, value.1));
+                ca.init_at(i, MyStruct::new(value.0, value.1))?;
             }
 
             let size = 4 * page::PAGE_SIZE;
@@ -87,7 +88,7 @@ fn probe<'bound>(
 
             Ok(try_pin_init!(Self {
                 pdev: pdev.into(),
-                ca,
+                ca: ca.into(),
                 sgt <- sgt,
             }))
         })
@@ -97,8 +98,8 @@ fn probe<'bound>(
 impl DmaSampleDriver {
     fn check_dma(&self) {
         for (i, value) in TEST_VALUES.into_iter().enumerate() {
-            let val0 = kernel::dma_read!(self.ca, [panic: i].h);
-            let val1 = kernel::dma_read!(self.ca, [panic: i].b);
+            let val0 = io_read!(self.ca, [panic: i].h);
+            let val1 = io_read!(self.ca, [panic: i].b);
 
             assert_eq!(val0, value.0);
             assert_eq!(val1, value.1);

-- 
2.54.0

