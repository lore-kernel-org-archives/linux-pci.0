Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021095.outbound.protection.outlook.com [52.101.100.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C41A3D9DAC;
	Tue, 21 Apr 2026 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776783401; cv=fail; b=K277uUiGqIwjq2piGUrabQuSVpVsnsJBK0MuQmdIJcSvzQADdt+Yp3rPyqT5aWolBPs19q0ArS5IFQzNTz/UXPcaeBgSPSidfujeCf4ICNVzlnoMrulxwgpr55eGbTMiGy4DS4J8/HogXFQdeBCPY/BU8choQfXETPqBVWzXP30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776783401; c=relaxed/simple;
	bh=aOfLPip234jwbtfUDxAEqballSOb6fOW5cF0Oh7xboU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=m+XRNsHmLUQcLFSbVKYyeFxo5q507nWLxUWSxtGZpeDX/tWk88l2flLdKrtgG6eMfSoSDw0Ricr8hnOBDYJdKRQjKGUCaDs6ClpseQcpnwklDqq+QatbJewlEN8BkM+HXxNJwnV0Df3AeWfYyFuu2E14TNk9hk+bSshqa+3sIjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=W261OWEU; arc=fail smtp.client-ip=52.101.100.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="W261OWEU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5Z9y3acjMC+zGKZnH1pF9j3SwpJCGv0tc8M702z9xfxEx8kweG1NVxsRAoWJUmMkWjiv9H+KBDxDY3rqHAR+8p117jyaPt6p/GBZfL+YQcMgkffx+7rhb5QiNdefOLh2B50csWjJr/d+HpnvKeOXF+Y7EEUZhzf9V8WcSzJvi5P6/44v7bsXB6WT8JjQD9I9O1B8tnEvqNmY+D9MC3HWLBAgH+TaCaQT3UToexpw5lnD8y83MfW1XVgbUovCRXdZL6gznaCZ6+jxVVMyg8WfBo8pPtcIUFhJ3GZFG1r/wnRW39g06NFFO2tniTKpG1SYuRPrCADxt8TlNAn9MmVXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXLe8WC7UCzcv5FezZO2TXpBmQPZnCQW8VAR9ImGU28=;
 b=hEOu2tEvK29BwVWqsEUwM4bXxoxCyzKCbzn7x/xXx52iTa7hvesMziyD3Au/YEneX/+hX4yK8uEWTnAfwvVRZqVljJVJXlRbP/12c2lf+7foL1bbSyYdX/ji8H+IAKkG/IqMdVTaNDfmJ8x8QH6ALcbhl8Eab2o0qpYizXECujSb7qf6QeEcr3FykxImSh1pmwAtwWk7KdKZvFbg0iI95sdKQRingJRU4kwFd6xZ2+YetfraFB9Q+6Jff/i5Byo/qS+9we9clD7gTodHIYo5TpJfnkDXCOHU9xlpruAnbOg3XNiWlmdEqOD7lRYkpw2TICQfBZG6lmzCEmo41r/hWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXLe8WC7UCzcv5FezZO2TXpBmQPZnCQW8VAR9ImGU28=;
 b=W261OWEU8baWiolRoGviCQDonJGZ57t28SUEd35/0TjcHPvRblye6nLkeGpQSEy4Q72GzClM8NDQLupe2qrm/jkVmhmkJMV7v5N6mE20fw6IJ58+Lm4BZDTOEeQcGdmRwvHf4z9tKtVoie8uoXrVljRKIgTUtbmUGhLq5tOOU3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB5674.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 14:56:30 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 14:56:30 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 21 Apr 2026 15:56:18 +0100
Subject: [PATCH v2 07/11] rust: dma: add methods to unsafely create
 reference from subview
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-io_projection-v2-7-4c251c692ef4@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776783386; l=3238;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=aOfLPip234jwbtfUDxAEqballSOb6fOW5cF0Oh7xboU=;
 b=9cwJCopkLJXLfv+fchvQXU2DAVsu9tkTmCIoRC61SlzZ7JqVJKLjnY7m9FcMHshN3o/tpWmGu
 eece+sVYDhlCTmfdJvjXTSH38fFJxTltLkHqs8un0ekriNLG//JKnNR
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
X-MS-Office365-Filtering-Correlation-Id: 0e47ee9d-3303-49aa-75ad-08de9fb62b99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	PKeaGTdBH7YXZxXtJ+UU8G4qrqRLQvvlFf4rvHURRzJ6pwaVlmtlM2LUlocHjvBIHkcS6+12VOEcWWXrGZQDOc+w2CwPx3k6v1QiecJpVmwqsExdb/dIxpmITMiw5ZCxQUBO6R/sGSZol5qmGXRBxNrfuQwQDE6sLvesOZ0iEzVr5jLHVRPtuCYMJgisDlcHxt+oCM7xIcNnf5PEfXK2F+mTti3iTHfR/r5fDfOeE3qhU2RR5R47MPUDcEG3nvWLTuyoWuSiu8iwdgMreCmw0Sy8MrG6MIVQ8wA83H7VqiCQElFTFX8Q2DVkXToSINl7XHFOVylS49GWlJT2PSMg3AZ0JdZZo6MMknCoiaC/U1bqdlyeG2LL2n/0MxHkOWC3aJaIfF6IPOLOlPRjijnd7x3S13as0a0dPvQ6HFMNmCuKcmG/kuV20tngjhpmVkbSwAdIPx/ROvxlcpLUAqLlw26DMZXklQNbR0Yn63bzp9UPx1+lkCDHlWEVQ7QvPPMjt8T3PI+9/FxDybX/GIGBJxcEM/1xNe0HzQaSv5HtADU5FKjNLAJaW5Wv9sxILd9B/FT34wPCh1v+VwtwLNCbI0Ye6SxCMiRq+BRpxNqD6Njvpq8R7LZ9C6GONozjsHirPThODHDV/SNTABuLOmnFGHrukc3ixHfU4ru6gf4aBbwjNXmIaqCv8DsX78lyynECtI+An965Q+2rjJjpE2tcTppQLEm5wnW0OqmZr6oBgL0AOvb9RC4QxmVrwNXdhs962XER8Rm89OYxbD3UFRawZQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTc3L2dBQnJkemNybXNOQjZ4YVFvL2UzSklVMHJtU1ZVV0lvOW1lVktWUmFW?=
 =?utf-8?B?ekMyZzBVTzl0dk5JaTZIK05GQjBnK2FZWjFUZGtOdGM2YmEwby9Wc2RHRkMw?=
 =?utf-8?B?c0V2cWd6MWhCdVFXek9qMzYzVmgyNFdqQ0ZxMmd6VThhbDU2T0tZS05Pa21H?=
 =?utf-8?B?aUluZm9aQlBCdWl4OGorZVNDR2EvUEE2dzQ1SGo4LzZCSWVkdy9IbDRmZWUy?=
 =?utf-8?B?SU5taERJaVNMNi95SlFiKzZNWDZUOWZXOWdzZk1DelVXNWdhdTZHQWhIS0FB?=
 =?utf-8?B?dW5oNmh5eWZLQ2x4MEpKSHVZRDBNVGVOaFRCSWlES2txSHhRbDhhSEoxQmVv?=
 =?utf-8?B?RkRLQ0xPdnhpRll1dm1ZOVZQUGMyUS9MSllqVGxiK2Q3UWY1ak1RNHFhdHdq?=
 =?utf-8?B?bGpQL3pLRGliU2VLOGU1S1N2Q3M3RklFY2xQNzdENDMzb3dWT3lMdmZLMXNS?=
 =?utf-8?B?ZTJaRWNKTDhrMDNIVlYzN3ZuVmZtbnVDMGNlbkF1WXJURm9jOVdQQ3ZUZzNN?=
 =?utf-8?B?Nm05Q05sK1BBenhkTXRVMHFqaTJzb3o4QVpoN1B1akFjL0VEUkhtRFFHS2Ns?=
 =?utf-8?B?QVRoWjNjSHV4b2xMWmowNmJiM1M5SjZURndYMUlBejYycm8wV3lLWkFUaW9V?=
 =?utf-8?B?VkNVVFhRckc2OEtTTzdKbHlFNXZsQUVIYjAxT2lVdTk0RzVKQSs2Q1lVKzc0?=
 =?utf-8?B?aXd1dmlNdndVZmx3OXIxakczR1VSMW92bzdPOUhCUmVhOEE5MHBEeDVUdExI?=
 =?utf-8?B?TW51RFpGbUlxb2Z4NUZCalhYVFhQdXppTnpiajh6a0wxRlBEOTEyVEQ3WHI5?=
 =?utf-8?B?V3dXNkVRaTN4eEg5MDAwcTJleng4U2lTeTE3dGE3M3B0NHhscGwxUHRPcVNq?=
 =?utf-8?B?OXZKOTNoeVZVNUIzR1kxNHZQZzFKb0svMmUrWVZsbGxVWGNsUDl3Q0ZGQjRK?=
 =?utf-8?B?TmRTbjZWLzRWVHNsNUFHQTE4RzVrV0txRGF0V3VPK2pJbWo1RlVvempPY1JV?=
 =?utf-8?B?bWhCaHI3MlhxTjI3R0RyanJzbEVHU3lMMnkxdVVUWE1XY3c0QkR0c1phdXE2?=
 =?utf-8?B?RkRORDdDZFIvSjc5MFV4dWYxcFQxRVdrL1FBZlBUS2h4S1l3WVB5d3Fqc1F6?=
 =?utf-8?B?Nm5nMERGYzllYmNHaWR0MzJQemdWL1NjaVdkWW5CMU9QRU9DU1NGbVVwNnB2?=
 =?utf-8?B?RUw0TURJNlZGWm1tcFdxN0ltK1lzeTNzdU9DZmttRW1ENXIvc0tYWUxNWTdH?=
 =?utf-8?B?TWk1azNoblFhUlY5U0FjRHowTUZoazB2a0hUSVE2R3YveFVlZFg0bWNIN0ps?=
 =?utf-8?B?cGRsQXBsQmVkbmpuK0UwaGdEMnVzaC9IWEc4OEZaSUpNU0xzUFBYcUtUcDUw?=
 =?utf-8?B?YklpUzBLRCtSUk5sUElWT2RMTi9JSDl0Z0ZVYUtsVVUxS2w4emtYRDlTTVQy?=
 =?utf-8?B?am5kNnMxMS9oL2JrTHdDeGM2QTB6ZDZYbEROeDdaOEUvL1M1M1FPYUoxOU9E?=
 =?utf-8?B?UGQyTjRTd012clNIVG1Zem9oTVFoUEpxMy9ZWUI2TFA5TGZmU0pTdkttZXBz?=
 =?utf-8?B?TTNYVXk3ZysyWVJIbWFXTkptNUE3bkdZUGw4L2czdTg3aGY2em1kWFN1dlgv?=
 =?utf-8?B?SkNLNW4zVDhHcXVYM0dXVHI4K0R5V09MSlFyc3dEOUhRcGNkSW1ib2I3Y2Qw?=
 =?utf-8?B?ZXEvMEJjeTdibDZJOS9BbWcvdUJSZk5iaXBsVFJKVGtwaEh1dkI4MlFFZlBK?=
 =?utf-8?B?Q09jRStYNkNPclZyUEZDOEt4bzRLcWZLUW5TNU1NVkdBRFVKTGxXL3BRZ1Vz?=
 =?utf-8?B?bXEwaVNnQ0VSRk5xcjdvUWJCaTlseHJZMkNlekxlSFhmcUwzdzMrYlc2Skpr?=
 =?utf-8?B?ZHAxZUI3NWJudGJEbnorVjNZQkFUZnl1Rk5FWldCSzlETVN6bnlwdGZkYXha?=
 =?utf-8?B?R0F4L3VMV3RmY3lFQU1XcE5Oak5pV2h0cmJzNlh3ZVR6N094SmdEWjdscW9j?=
 =?utf-8?B?bjJvN0lHTklKVHd2ODlXcXV0ZGFFNWp2S0xLeEowZzdMUEI1WStGSWM1ek96?=
 =?utf-8?B?N1RzOFVVTTR4ZXU4QnRDMHhlTEpwMlliR2hIN0hnY2NJZWt0NWhhdmd4R2tX?=
 =?utf-8?B?YTBxdHl0cU1xcTI0dHRlb2U5LzhqcFBHSTljZUhjRm1ob01SMDNWZVBOUTNI?=
 =?utf-8?B?YUNyaytrTkZzMVo3b0tFUy96WWVjSFhLekVoY0hmRytveW9qKzRZUUdlWFdW?=
 =?utf-8?B?bjZDdmtjWHB2VzY4S1BqS3Y0YndBZmpQZkdPV2p3dURBWVYzWldUSGp6YXQ0?=
 =?utf-8?B?TTJiazZ5TmU0bUpETTJvbGEwaXdWT2IrYzI2TGIzZnJtZTBtbmU3dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e47ee9d-3303-49aa-75ad-08de9fb62b99
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 14:56:29.8300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQ1NfKZA/lhJvrbTUcgVxAwapgPD+yibre5kogvYC4UTqBmW1rlObAfVSfaU8KPS3AE0rr46h4vEPCZ53HQHMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5674

Implement `Io` for `Coherent`, so now `dma::Coherent` can be used with I/O
projections.

This allows the `as_ref()` and `as_mut()` API to be used in smaller region
than the whole DMA allocation itself. For example, if a ring buffer is
shared between GPU and CPU, users may now use the `io_project!` API to
obtain a view of the buffer that is uniquely owned by the CPU and get a
reference.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/dma.rs | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 642ccff465c8..92db0e58f364 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -14,6 +14,7 @@
     },
     error::to_result,
     fs::file,
+    io::Io,
     prelude::*,
     ptr::KnownSize,
     sync::aref::ARef,
@@ -989,6 +990,59 @@ unsafe impl<T: KnownSize + Send + ?Sized> Send for Coherent<T> {}
 // The safe methods only return metadata or raw pointers whose use requires `unsafe`.
 unsafe impl<T: KnownSize + ?Sized + AsBytes + FromBytes + Sync> Sync for Coherent<T> {}
 
+impl<T: ?Sized + KnownSize> Io for Coherent<T> {
+    type Type = T;
+
+    #[inline]
+    fn as_ptr(&self) -> *mut Self::Type {
+        self.as_mut_ptr()
+    }
+}
+
+impl<'a, B: ?Sized + KnownSize, T: ?Sized> crate::io::View<'a, Coherent<B>, T> {
+    /// Returns a DMA handle which may be given to the device as the DMA address base of
+    /// the region.
+    #[inline]
+    pub fn dma_handle(&self) -> DmaAddress {
+        let base = self.io();
+        let offset = self.as_ptr().addr() - base.as_ptr().addr();
+        // CAST: The offseted DMA address can never overflow.
+        base.dma_handle() + offset as DmaAddress
+    }
+
+    /// Returns a reference to the data in the region.
+    ///
+    /// # Safety
+    ///
+    /// * Callers must ensure that the device does not read/write to/from memory while the returned
+    ///   slice is live.
+    /// * Callers must ensure that this call does not race with a write to the same region while
+    ///   the returned slice is live.
+    #[inline]
+    pub unsafe fn as_ref(self) -> &'a T {
+        let ptr = self.as_ptr();
+        // SAFETY: pointer is aligned and valid per type invariant of `View`. Aliasing rule is
+        // satisfied per safety requirement.
+        unsafe { &*ptr }
+    }
+
+    /// Returns a mutable reference to the data in the region.
+    ///
+    /// # Safety
+    ///
+    /// * Callers must ensure that the device does not read/write to/from memory while the returned
+    ///   slice is live.
+    /// * Callers must ensure that this call does not race with a read or write to the same region
+    ///   while the returned slice is live.
+    #[inline]
+    pub unsafe fn as_mut(self) -> &'a mut T {
+        let ptr = self.as_ptr();
+        // SAFETY: pointer is aligned and valid per type invariant of `View`. Aliasing rule is
+        // satisfied per safety requirement.
+        unsafe { &mut *ptr }
+    }
+}
+
 impl<T: KnownSize + AsBytes + ?Sized> debugfs::BinaryWriter for Coherent<T> {
     fn write_to_slice(
         &self,

-- 
2.51.2

