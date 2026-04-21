Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020131.outbound.protection.outlook.com [52.101.196.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F363D9DDF;
	Tue, 21 Apr 2026 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776783399; cv=fail; b=DO+ulg20RBmdCnb3QuFex4boaqqFdzZmT5WS6aeHOl26wHb4mHRKx4ke4dE28DcHqsU0ssE0dmobv+jCFAFlawfIZDS2Kk6rdRdf1JWzNKTmEft78meOI2VWhh/+qdsdDTqvMshMTyNifxSfVlzKrR94svKCyK2xbb2gqfSdV2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776783399; c=relaxed/simple;
	bh=d7D59E81y7GC3frEJZ83WlP+T/kdXpX9ZQKPVZqa7+k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=X74EJ+Bv3s7DEcNVasivvIJG0CYB5WGzN5zJMawb+KBHcpOUreGAWQ1U4fkpOY1XH263xeHKx+R6dzPicC3vE0qqgo4tVffQvW8EAD89w37rV4Qa17TLPyz7ZeH/mEVio51B67/bQ/v8bHDV/MEb2PRFlYJuzJooTTr9YDpek/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=hhhCA9/e; arc=fail smtp.client-ip=52.101.196.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="hhhCA9/e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CA40ceVExwfC2a5hzRTrRuIv7zlYRc3s+bT29eoKQE4/JkNSTZEroMN+aZQZXY/8KVFYuaWdCbdPMuCw1kY1Xv0umJmoal4TVzdCZf68AMuwNoAVEktHd1QNKbzO35YUaZymwZ76CegTnUuuGgfe+YyhaQRjbUAbG0wRmyPOyPY5YuwOnV1lm3+v7z64i1vg+Wu6PPvfm79Eb+WRixJwoAbFd1e000OBWVNJ7C7i6GXz1n6T2OBVbxP50Ktl6OVAYYELlOxUI74fShu4l1jedQGL6pLcpG3EJawlnPwE0psKep25YQpiFFoYT8YzFJ5/FsdzPTYFxGLQeXA/Ann+2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1b5DdLMRYimSWgJfRYYszp83aLSNpWhflPrz3Msjbw0=;
 b=hpCp5b8vX7ahgq/LOBhGNQhead/98Lo6zxB4CgPEj3+E3sHbL3v7ZwVB3301PmKz/Q5vvYT1fugUqlORmmLvuOaeYmaajDyTrQWEbJp3aj6KuFSHpEjDJkuBVNsqNSVOHB7MtygGHpy3APC+m9VBFFQe45nnw2iq+lBJKGiONgjLta7CSYRI9cbr1yhNd6Olkn6C2r6IU8wk/kcgIktkxQmU2nysnkVbSdO7GeZKSPCnH0rUji7uAMrMNkFce+4CC3tEQRlHcZLW3zv4MD0qsHFyrDhtCE2sFnJcb+HVWzWizRvWa0huLzbonyXeTujRn/ur5GOka0g47d9nZiiRRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1b5DdLMRYimSWgJfRYYszp83aLSNpWhflPrz3Msjbw0=;
 b=hhhCA9/eaU+Y2JxIMiWifeyArKcf8914Y5HeeyehURYll+lka+wj/96SUr1/oaQjKdx+7d/hscyc95Vl88XYk5Y0IFxuAqf0y+ykY8Y5qsmpnpLkgn8/GIPzmtcGX2YglQRf0rM6qTHxVCSs7j9ocE/+LE3vEz0KXeO4nTTT01w=
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
Date: Tue, 21 Apr 2026 15:56:19 +0100
Subject: [PATCH v2 08/11] rust: io: add `read_val` and `write_val` function
 on I/O view
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-io_projection-v2-8-4c251c692ef4@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776783386; l=7273;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=d7D59E81y7GC3frEJZ83WlP+T/kdXpX9ZQKPVZqa7+k=;
 b=qF0wrVzmyz8fm5OQ/DwWboUlelLDg5mLGSN9s8IcpY5U5Exs6P6m21qpLlivvfZa17vP94do/
 kKKGzRhLwasA1tPQWtMdNqJP/9gWsCBFWZm5puOfvZYSBsBFUf0lnX3
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
X-MS-Office365-Filtering-Correlation-Id: 7dacd265-791f-4be1-e56b-08de9fb62bd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	mEroFlZL5aM9woDSdEslRumUUAayC5Bu9Vo1ZdLU++sa1r1zmKX40nBagHzx1YHvrkUKB0Pcv504JAyUIe9pWnXIA8kQECG2WeWO9dK9gv2HDCd1t0KdHb4Ys2klOoIHUFcmmp034PefU1+HwWowxxOqUs5/eH5DBaHd8ZpGieRpa6xc/Go6Ro3/+HK3X/i0LogvXzKZSwpIbQ5hImsHW0N2UGbMZb5sTD4VgrQEDUZ7+fcBTM/jdzAQcd6HewAYy8aSjkERcfKAKAmmBVFOM6F0Ibz31PCfN+aDjRXrV9LyVoeo1e0j2zi38rXQWqVkM494KSuSk6MZfevhqmxFJw5vQ5W4Wlnlgj6APhdxHv2RoRYE/dE9Ap6RhmY2zpoWsiwvzorRodt7uak25bcJ12jrYcKv3jmRyJ20SDrYhq1KuVKOh9FjFr3Y+u7Wqs6U2B+0l/GDViZcbq8lpaEJY2SCl0IzURkHgk8Dn/HnJkSWrzl5qYoQtJzhf8MZmE0Nxr0heaYlgYYPtIGmaD3yyzKmdybhZETbHgOk9BIR1gnAzIxMxrJbVjZ7KGAA87qrbOAotxPC14wUoDhoZ9iOO4v62XJ6QWEYdsm0Y+UjCcuxdV0RaxopFXuxFOhzjQUnXdcm0lEvvOY+os3AEKD00Cp4DOUc+adHEaXGVSpv6fQ1JnoEfx6KwjmhvxCyVZeL9H1h66onjEPyP8Toc5L2Q1Pgk45yu1cSN+RO0CqgkO8CcWWc3PTe+zCer3BPI+D1hf1IyHUHtx/sklf9iFcaZg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1N4WitMbFVKWVpLUkhVVGwwak1nK2pQalhHQlJubncvZXZDVTlrNHgwUFpB?=
 =?utf-8?B?MGltUmdWeDNaVnF4UklCbytlOVg4dDY5VFNYUlNQUUZudVlUOTV3MExObFoz?=
 =?utf-8?B?UUhFS2ZNSlR3WlN1SkVmSlJ4UTlMTUZ5QUVWSTNKZGNuRFRGcC84VnZCWU1h?=
 =?utf-8?B?dHNWTHZWRDduUWxIR3RiNG9UK3RaTkhhd1FDZWxETXFmd1BqV2FJMjF0WGd4?=
 =?utf-8?B?aHZaMzRiOGxEbWRHN3crZmh0eXRvTlVDdDM4RkpUTGZVMjVEM3J4VVN2N1Rn?=
 =?utf-8?B?dk5ETGV6STdmU0hSRHFlQzhxTEhiaUIvdlFIMXdpZ1ZWTUdLTkFzWThRTGZa?=
 =?utf-8?B?ZGVVNmplTlJGNjB5WGllbFJINHJseTZOYitsOVhUYStMQm9NZ1l5d2tWdWpF?=
 =?utf-8?B?Wm8rWXpzUi9BcHBSSXpQNzhiNnFzdHlGeGFZdDZMRFNBNkdvQldzdGgwYVpm?=
 =?utf-8?B?TGR0ejV1SEpXdDFvcTVJNkNoRmwvaGdtY3pLNllLaFlES3JPYkhWYXFockJ2?=
 =?utf-8?B?RjNmVXU0YnlQeDRxdkFVNVE2aWlBSytSWW56T0NZc25jTFBLNUtMMUJRZzBL?=
 =?utf-8?B?d2xEUjE2NE1qeEMrYnd0Ym54L25EU2p1em1LSytSZjB0OHM4eURuUjg5akZK?=
 =?utf-8?B?NlJQZ2lkMUJCT2ZhbVh0Z2N5UkR1WHZndWlFck9pNVJ3c242dnVieFU5dmFY?=
 =?utf-8?B?NXQ2WUFIbng5UXNib2o5WWFQQzlFMU1tY0RvTWVXNkxzemlLd3lQQ21nMENo?=
 =?utf-8?B?U3dPanNsVnNvT1Rza0JaWnl3aExrMzZNc3VXQlduMURkT2ljWmtkYjFrSnJ2?=
 =?utf-8?B?QTFITzNrcjY2K1VUWGVrRCt2cWZUdWFyL1FiZ1g5OFVNQkprTHZuVHhTRWd3?=
 =?utf-8?B?a0s2Z1V1Znp0MFI4bG9wdmdDWm9WL1AvNUF6ejE1US80MnJQSHNvcFU1OFFX?=
 =?utf-8?B?R3p2M3pPdEkwZU5QSWtwelREcG1JWisxdUdrcHB0UGNBNEpTVHNsdmpqUEIy?=
 =?utf-8?B?QTNldWwvM0JEMkg0UzNQa2FveDZXWXZXYlBJdytieTNLRkgvbFZ3alQrenYy?=
 =?utf-8?B?eFQ0SEttSTJucVMwdTVReHk0K0RnQk9oclJRUVkzd0VpbjR6NURpblFuOWl5?=
 =?utf-8?B?SFlqUW5xNUpTQkVMRzB6eGhPMFEzajI1QStXbDdIUFRhV204S3J1WDE2Wkt1?=
 =?utf-8?B?dkJoUjhzVjVjMW0ycDJSeUhFbHdFbVdkWFB0OC9vdSt4Smt6UnZYQXZoaVFk?=
 =?utf-8?B?NFkxemRkaFNFT05JbXdqbWJBY2dpZDFlbWQrbG8rMlAyYm5SNU4wa0l1VXl0?=
 =?utf-8?B?VG9HWFEyV1Bnekl2ZVpOQmV5akxqS1NoTmw2TXlabU0rb3gybmhkdWoyeVpu?=
 =?utf-8?B?V0ZUSnAra0Q5L0dqUUJtdUwzQWoyWmp6M1dEbjhIbFFNa1oyVGFPNEtORCti?=
 =?utf-8?B?RUhYcnNWVGU2a0tucCs4L1BiOStVeVZqTTFBOGRvWDcvRGlNRXNwL0xZYlUr?=
 =?utf-8?B?OFBzbDQ4SFgwN1doRUNMTFlMSTByaVhIZmdoVXdpekt2dE5RdFN1OVlmMGQ3?=
 =?utf-8?B?NGM1MXJDYkRNOHAwU2U5azhJNzcrUmlsS1hJbCtJeFcvMjlCcGR0QlNhV3M3?=
 =?utf-8?B?RzJPc282Z0pPaW4vaXRnSDdOTldMejlGcGpRQXFHYTJzZnBKdCtucmk1M2hW?=
 =?utf-8?B?eDl5Ym9xZ0tnZ0ZRNUlmcGJIUXdPTXBETGxpWnhYVWU1emtJMjIyMk5VQjdo?=
 =?utf-8?B?dUdQZ3ZGaXJoTHRuN3lHYkdwcXQ3ZDRueHRPdTVFWjZyUFU0MjBrUXF0R2VI?=
 =?utf-8?B?VGpvV2x4WWQ5VkVhendka09YY29nVVFQb0hYS2IyNjljdFRZUWZkOHdSUnBs?=
 =?utf-8?B?bXBjblNwK3RTUW1hcXpQTmozRGNiWkxpcFlFRFVtRVhNRGJoUWRXRzkwbzFp?=
 =?utf-8?B?ZG1MVW5YTkpReEJMdUJzdFBGNzUrUXM1Q3NCeWNZRGdOK0R2R0pLMjhJdkRv?=
 =?utf-8?B?YVNUTlVsMG5yWThPU1NtaE1wSDRsRnpHMXZLOExtMEVtd1pKWWd2NzN4WFZn?=
 =?utf-8?B?L2hqNWhQU2YxYTcvaEFTL3hOVkkrbWtQN0FwSHFuVmpRS3d3NXVXRDZUYmk0?=
 =?utf-8?B?T20vbUNXVHlKVmJqRFhGZHRKL09ZRVR6dlFHVUUvQ3dYaWdwdm5qWFRxSmM1?=
 =?utf-8?B?ejVNeVFtSDA4M3lIR2hqOWpRSjZZamNRTGx1V0pzbmxZcE43NUxYenV4ZlJS?=
 =?utf-8?B?d2lGRmRZR0JBVkFFRFNaUmxiZklRVGIwcnI5ZzUybnQ3eXdLUm53S3Q3OFQr?=
 =?utf-8?B?RVlGSjZOOTNrNDJudUxsL1RDcXBPeGQ1eWxxclFnTjd3b08xaHlxQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dacd265-791f-4be1-e56b-08de9fb62bd3
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 14:56:30.2277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISszC/OuJXGoejoTIkDqA75bB+4zlB5iF2c/EtxVc0MCBWv6JnbBpS/kqiLo0XBdl+hH1exf32UQzDD8aGH2Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5674

When a view is narrowed to just a primitive, these functions provide a way
to access them using the `IoCapable` trait. This is used to provide
`io_read!` and `io_write!` macros, which are generalized version of current
`dma_read!` and `dma_write!` macro (that works on `Coherent` only, but not
subview of them, or other I/O backends).

For DMA coherent objects, `IoCapable` is only implemented for atomically
accessible primitives; this is because `read_volatile`/`write_volatile` can
behave undesirably for aggregates; LLVM may turn them to multiple
instructions to access parts and assemble, or could combine them to a
single instruction.

The ability to read/write aggregates (when atomicity is of no concern),
could be implemented with copying primitives (e.g. memcpy_{from,to}io) in
the future.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/dma.rs | 46 ++++++++++++++++++++++++++-
 rust/kernel/io.rs  | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 92db0e58f364..d0b86aeebfe2 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -14,7 +14,10 @@
     },
     error::to_result,
     fs::file,
-    io::Io,
+    io::{
+        Io,
+        IoCapable, //
+    },
     prelude::*,
     ptr::KnownSize,
     sync::aref::ARef,
@@ -999,6 +1002,47 @@ fn as_ptr(&self) -> *mut Self::Type {
     }
 }
 
+/// Implements [`IoCapable`] on `Coherent` for `$ty` using `read_volatile` and `write_volatile`.
+macro_rules! impl_coherent_io_capable {
+    ($(#[$attr:meta])* $ty:ty) => {
+        $(#[$attr])*
+        impl<T: ?Sized + KnownSize> IoCapable<$ty> for Coherent<T> {
+            #[inline]
+            unsafe fn io_read(&self, address: *mut $ty) -> $ty {
+                // SAFETY:
+                // - By the safety precondition, the address is within bounds of the allocation and
+                //   aligned.
+                // - Using read_volatile() here so that race with hardware is well-defined.
+                // - Using read_volatile() here is not sound if it races with other CPU per Rust
+                //   rules, but this is allowed per LKMM.
+                // - The macro is only used on primitives so all bit patterns are valid.
+                unsafe { address.read_volatile() }
+            }
+
+            #[inline]
+            unsafe fn io_write(&self, value: $ty, address: *mut $ty) {
+                // SAFETY:
+                // - By the safety precondition, the address is within bounds of the allocation and
+                //   aligned.
+                // - Using write_volatile() here so that race with hardware is well-defined.
+                // - Using write_volatile() here is not sound if it races with other CPU per Rust
+                //   rules, but this is allowed per LKMM.
+                unsafe { address.write_volatile(value) }
+            }
+        }
+    };
+}
+
+// DMA regions support atomic 8, 16, and 32-bit accesses.
+impl_coherent_io_capable!(u8);
+impl_coherent_io_capable!(u16);
+impl_coherent_io_capable!(u32);
+// DMA regions on 64-bit systems also support atomic 64-bit accesses.
+impl_coherent_io_capable!(
+    #[cfg(CONFIG_64BIT)]
+    u64
+);
+
 impl<'a, B: ?Sized + KnownSize, T: ?Sized> crate::io::View<'a, Coherent<B>, T> {
     /// Returns a DMA handle which may be given to the device as the DMA address base of
     /// the region.
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 869071d47a13..efcd7e6741d7 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -1009,6 +1009,26 @@ pub fn try_cast<U>(self) -> Result<View<'a, IO, U>>
     }
 }
 
+impl<T, IO: ?Sized + Io + IoCapable<T>> View<'_, IO, T> {
+    /// Read from I/O memory.
+    ///
+    /// This is only supported on types that is directly supported by `IO` with [`IoCapable`].
+    #[inline]
+    pub fn read_val(&self) -> T {
+        // SAFETY: Per type invariant.
+        unsafe { self.io.io_read(self.ptr) }
+    }
+
+    /// Write to I/O memory.
+    ///
+    /// This is only supported on types that is directly supported by `IO` with [`IoCapable`].
+    #[inline]
+    pub fn write_val(&self, value: T) {
+        // SAFETY: Per type invariant.
+        unsafe { self.io.io_write(value, self.ptr) }
+    }
+}
+
 /// Project an I/O type to a subview of it.
 ///
 /// The syntax is of form `io_project!(io, proj)` where `io` is an expression to a type that
@@ -1057,3 +1077,75 @@ macro_rules! io_project {
 
 #[doc(inline)]
 pub use crate::io_project;
+
+/// Read from I/O memory.
+///
+/// The syntax is of form `io_read!(io, proj)` where `io` is an expression to a type that
+/// implements [`Io`] and `proj` is a [projection specification](kernel::ptr::project!).
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::io::View;
+/// struct MyStruct { field: u32, }
+///
+/// // SAFETY: All bit patterns are acceptable values for `MyStruct`.
+/// unsafe impl kernel::transmute::FromBytes for MyStruct{};
+/// // SAFETY: Instances of `MyStruct` have no uninitialized portions.
+/// unsafe impl kernel::transmute::AsBytes for MyStruct{};
+///
+/// # fn test(mmio: &kernel::io::Mmio<[MyStruct]>) -> Result {
+/// // let mmio: Mmio<[MyStruct]>;
+/// let field: u32 = kernel::io::io_read!(mmio, [try: 2].field);
+/// # Ok::<(), Error>(()) }
+#[macro_export]
+#[doc(hidden)]
+macro_rules! io_read {
+    ($io:expr, $($proj:tt)*) => {
+        $crate::io_project!($io, $($proj)*).read_val()
+    };
+}
+
+#[doc(inline)]
+pub use crate::io_read;
+
+/// Writes to I/O memory.
+///
+/// The syntax is of form `io_write!(io, proj, val)` where `io` is an expression to a type that
+/// implements [`Io`] and `proj` is a [projection specification](kernel::ptr::project!),
+/// and `val` is the value to be written to the projected location.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::io::View;
+/// struct MyStruct { field: u32, }
+///
+/// // SAFETY: All bit patterns are acceptable values for `MyStruct`.
+/// unsafe impl kernel::transmute::FromBytes for MyStruct{};
+/// // SAFETY: Instances of `MyStruct` have no uninitialized portions.
+/// unsafe impl kernel::transmute::AsBytes for MyStruct{};
+///
+/// # fn test(mmio: &kernel::io::Mmio<[MyStruct]>) -> Result {
+/// // let mmio: Mmio<[MyStruct]>;
+/// kernel::io::io_write!(mmio, [try: 2].field, 10);
+/// # Ok::<(), Error>(()) }
+#[macro_export]
+#[doc(hidden)]
+macro_rules! io_write {
+    (@parse [$io:expr] [$($proj:tt)*] [, $val:expr]) => {
+        $crate::io_project!($io, $($proj)*).write_val($val)
+    };
+    (@parse [$io:expr] [$($proj:tt)*] [.$field:tt $($rest:tt)*]) => {
+        $crate::io_write!(@parse [$io] [$($proj)* .$field] [$($rest)*])
+    };
+    (@parse [$io:expr] [$($proj:tt)*] [[$flavor:ident: $index:expr] $($rest:tt)*]) => {
+        $crate::io_write!(@parse [$io] [$($proj)* [$flavor: $index]] [$($rest)*])
+    };
+    ($io:expr, $($rest:tt)*) => {
+        $crate::io_write!(@parse [$io] [] [$($rest)*])
+    };
+}
+
+#[doc(inline)]
+pub use crate::io_write;

-- 
2.51.2

