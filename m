Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020131.outbound.protection.outlook.com [52.101.196.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AF23DBD58;
	Tue, 21 Apr 2026 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776783405; cv=fail; b=AFQQPlG+X1BoluCT1VtQkfH3ASXBDOcQLmzuUkaXVzTMVdsyPy2z3e/R65VTjWuyhFRyCEvLW9qJUIe7OU8ct3V9b4siTiXvsAVKek2z2wI7B7tg5HeH2FmhReegAqRA5idFQppHePPi/1oYxuXZh+h7Jvhuu3wybYr6Bz+kfm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776783405; c=relaxed/simple;
	bh=ERQyRg6FCVwG0U5GQXUSxvKmT2yPSztVRq39JXT1JUo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=aKcMrrfvtRvKrZiSkvq65PLLQ58m9aMGNCeWlPDg63SamTom4xDNlH3LYo40h+Ud/uMkiYcUk4QvgFS5cZ/qsLdXJHl66GvejUwUK8SfIu7WLvhhHHLkf5zqv6t1CIJiTbc6ta+2q9nrgqC1Wl1BOU/ysytGC9RT21P6DOmNKng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=rd59Q9yf; arc=fail smtp.client-ip=52.101.196.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="rd59Q9yf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pC6AdZunnHueYMpO6vYS8KNiit9x953cnjUWSXli+hKC08eDq4C0PXD6qscv5uysJQEkDuUfSiS7wMjb3ig7St5kq/qQ/DW4+r8Oou7CtkX43lYvDYyAEKae3tp9i2k9Hb1xABJ6SyC1s1lZLnx2zoBF/PqftjzeN0r81s0uC9w5n85J5raZV2aMk3cPbiQC7dD/os3e6ot3/9axUIyECIk4jev/vhALwRzEJjg5M2r/j8YLCJKwAcaXmDUc579CJ36A9dZvR6fIBniSOg3ktEDdUyHtfsrJLCXFAUZu/KQI9G/xxcm/o0E/gl+MXHAsBifZswUPSaF9Mq4ejTgCHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhiXe8a3REvkFHSbZGLhsht++x7Hwq50WeRMOiDIXZ4=;
 b=m/F7H5twmpuQye+wa3EKHMxdxNP85SHgjLkbf8JF0K5LP10aZF7G0Qf4jIccc/0+dsI7Yx6Yy9G6TnGK5BAbftGL66/7VFOIe8+tfIBtZP8k9bjN1UtSsvpPFIXPTFgf8Mo2NjRtBbUaXHDJkJ4DTTlIQqWFfeLS8YvCnfAmPuH2S3sc8nwz+8Rcjk/K25xm7nlLXaqgx5a4gSbmijPtTmOTopT89xjHKBU+omGzcEmuONfK5qlKHQ0uLz62FxGqTin3jaDQGbi7/1ps3SWRKzN5hxJl/QTPKJ/pSQ6lSpNw8U2DBvNq4bmSjZVH0zlfP5pO6WBCbMoL5dY/5nu0yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhiXe8a3REvkFHSbZGLhsht++x7Hwq50WeRMOiDIXZ4=;
 b=rd59Q9yfE8vZYQbqs4b8AVuzTNB4gbSwmNchd7seMo0PD8h4mMCF6vQnw+SFugOAuRMSEcCvjiHimVrVKUk9463co+XkMoFA1t31p2nt4NM+KWeKK5E3mzNUJBQ1IEBAW5DPgGHbW7T/440IR5i66IhSAB2N6EwGjZtWS+IDelI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB5674.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 14:56:31 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 14:56:31 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 21 Apr 2026 15:56:22 +0100
Subject: [PATCH v2 11/11] rust: io: add copying methods
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-io_projection-v2-11-4c251c692ef4@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776783386; l=11952;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=ERQyRg6FCVwG0U5GQXUSxvKmT2yPSztVRq39JXT1JUo=;
 b=uV59Tig1UAY86hboNAV4E3WIfI7Ql+9hlbKVgSxDejiR22aUNKPgwm2L01kkGD4YuxBthGXxB
 VK9/9YS3bVzBoD0RYoIqOm+9CZIpiMdSTwrbXneIfGvR8KxGbIJFG8S
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
X-MS-Office365-Filtering-Correlation-Id: 85b87724-6a5a-469a-3a8f-08de9fb62c86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	orwlKEzGLNpwUFSx1iOk6ddBcck9W+HB7LIjcjLuWtfGqqO5Q7MN9w8ErEBMiQFEzbQMNLz35LfgfaYZ0hD4A9YrxjdPSCOfBFe9QsTI9PQhGT91T2b49Z82HrMQiZmL4i6h15hl1wOFrZNMhUaxTRYV8tsjhfHJXa1jRi+boIVrdcHh4lUQvwgxB+laWqxUsO3ceSmDpYl7NnJZx2hEBa4azfuIVqhrTsCxWw2IVIHYCHW5hU6CQY1RRNtD17iF12NMCrtJkvThkiJzUodaSVZzfSW2kMntRfkqIerqgNrCXqO+/g95l9gQlj0p4aBeT+I7y64CGFWoWSRif5JEo/yiUmzFLEB1XNIGyb3xsa9R0KZktAj01IRpOxWGTcyCTFmP7bvjTSnf+SXRjJtivvt40cvqW0ystH6SfTGEmHirS9jPt1BTmwG+sLeGS0/JZcRHdZWuTmh6q4fpRyTQrrOzgj/kuX5VTvb16mt3yg88HdZ4fmVBYvVB0zW4jD1wMVhwhBgrPj8j26joS+O6vt6IkhRtwVp+yNG153fHV1pb2RSU9KFLQlRss4MdNIFiK5BDpfGrHTtbZrNgOetI8VjUX7hrzW6rEw8b2ifVrjUlMWM94TWeDyOGLQRWzU17uxX8Z8KkzIBBA9aOhymiEDIyYlIfefufa2ZiQl6qW3prPsx3jwhB4cFxLlueD675eZLhWGJPIajTNH1n4rlKgebKzV3UV/lAN1MSPHx/jQtYfVkfJIjf80+qS/gPM+nLySDmnS4vPTZHTfohhMr+8g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2wzS2RSTTFsSEQrRkxmWVB5anJvL3I3Q0F4emg5a3JFZDl4Nnl4RVhSUnpW?=
 =?utf-8?B?bUg4S0d0YjJMMm9wM0NoZ1Q2ZnZ3L1ljZjNrVnBQWDVzR2NCK3ExYTZ5NmZO?=
 =?utf-8?B?NUlKMFpMVE1OOW5VblBKMGFLa09iV0c3OE9LdVluYUtFOWxtamtWdWhxcFM3?=
 =?utf-8?B?TDNmNzA0VG43bmxDelZjdk9CcUEwZU04eVFPa1I2V3NtWEVDbXJxSEpybFlr?=
 =?utf-8?B?dDEzenh4ZUZSeHpxQzZ0dFFrYnNtMzNNeFc0T3BGaWRDWWFGYlZyTlpsY0hq?=
 =?utf-8?B?bkxCeURVLzgyYTRmZHhjVFJpVnQwNDRGdUo1dzMwZDZVREhibjcrUTRnT1FS?=
 =?utf-8?B?Q1hMdmtXTVdGeGkzVFprekVRalR1eUsrWmdocWY1RXZnUjR3U3phYkZBL3B2?=
 =?utf-8?B?cVNRQ3htUUdTNy9mckFiV3NXWDlabDZzejdBZk1MTGVEdkxrWUdHWWcxT1k3?=
 =?utf-8?B?Sm9YN3lvYS9tS04wUlRqTjd3UkhyYkZtWVZqdnMrTGRRVmt0TmhpcVNiWXAz?=
 =?utf-8?B?Vk95NlNFK0Y5NDlLVUFrVlE3MXZlWjdSc1FYZ0t3cVBJUEpjZ2N6YzdUT09M?=
 =?utf-8?B?WW5vNTNSTlg3MnBOWWtIZGlNY043cVpxSndGK0pQMGdSTytxNjU4U0YxcDBJ?=
 =?utf-8?B?VGQ5RDNtelU3WlM2OUhLU0QxSUJGaVo3SklvNk14bkVjNUVKNjZKaU84ZzdD?=
 =?utf-8?B?eHV4NzAyR3RrcS8weERya2ExdGxGY21rSE14VUwzYWgrVFpLU2J3cEkxcHRw?=
 =?utf-8?B?R1p1eXd0ZmduL2FGSjRBWWtzWkhTTHlZNi84MFhXQ1JDTXZrNHQ2M3RoL0I2?=
 =?utf-8?B?REZZeGFla0IzbERhQjlqS0QzUlJiUkk0ekhNY2ZIVUdJMXByZ0tTcmFFUkE1?=
 =?utf-8?B?Y3dwOUVnRWVrSG1CRWdMcHhxTWNFM0hBbjliY0NieTJwYjU4MjdyakhzR1RV?=
 =?utf-8?B?dzhqYTcrNktwWVh6YzdHRktKRVlXVWhGM0ZEVWZhOXJkM1VMM0NRcTBTNTRw?=
 =?utf-8?B?elRNN21xTTlLbDNSaHhvdTBiZENrNWpybXdPbENhZzFmY1ZteUlDOXhabjc4?=
 =?utf-8?B?dnZzbW5Bd1RrV2M0SldGS2NjRGdWb3lyYUFEdUNycTN3MUtvZ1A5b3V0MjRa?=
 =?utf-8?B?Uk5wMG9hVDVEWTl3VFhML1dXWXhoZmtWYmkxTWsrUlR0Nyt1R0Q2N0RvTEh6?=
 =?utf-8?B?c1dHaUlBaXplai9vMGZlVGxKcFNEZzBVbXVCMmlFRUZtU3JsQk13dUJxK2w0?=
 =?utf-8?B?NnRBU2NUeTlGM2JLVWxpQlpWbUVxZTIvT1d3K2U4M1dUZjd6bVNlR25BNmxr?=
 =?utf-8?B?bmdhRnNMcGJyQWpZcjVMMkdNUnRtTEF2VFpnNDFyM2lpTjE5Z3VhajRaVUdT?=
 =?utf-8?B?dTAzWjR2cW56WkpIUHYzNmM1ZnV1blBvdDJkTUljU1lzeU5hSkhVajZGdThx?=
 =?utf-8?B?TVYxQXF4M3RyNElWMzF6MGFsMUJSTVo1QmxUWjNCNGRjUjFhNlRGL0JCam5P?=
 =?utf-8?B?THhOVHhZQXRzU080Q3hweFhkeE0zSFgvejNQQ3JWUDc3TjhOU09VcTVXdHk2?=
 =?utf-8?B?andGSGFpODYrblFjZWQvYTRTWDk0ZjYrcWgrNXVaRis5RzhQS0xJSUdrUkEw?=
 =?utf-8?B?NVl0VytHRWxnWXBrNzE4Y1Q4MGNJSGRGYVlmOHFvWDBXMUlIUnl6ZDFMSkhu?=
 =?utf-8?B?WnFETk5wUGJHNkRSRzJHVFJZRHlQRHVDNTRqekFLNWpFeHg5RUNHVk1meXFT?=
 =?utf-8?B?bFNzMk1Eb1VvU0RNVm8rUXJ1ZSt3d1FCK281ekRCZ0FqOXhoK1hxTTN4dXNs?=
 =?utf-8?B?NHR2aDFSbDJLekx5NG1PMXFoU1B0NDB1dEJjakNNK25yaFdsRUtGN2gwdERT?=
 =?utf-8?B?ZDlIV09Sa2M5R1YzZXA5enNsZTEvS1IrdzBJQlpKY2FEcjFKVXA5NkxpOVpv?=
 =?utf-8?B?LzRQUTY1MHd1akFnUTBrT3l1QlRibG5jLzlQd2FDR2RnUDlReiszd3ovZmEw?=
 =?utf-8?B?YXgzODZMZTNNWjhDRnIxellsMTZFcmZ5VmdZOEFSazVkbGRpMjJEekdvbUQ3?=
 =?utf-8?B?K0tZeUZJM1Qvdmk0VDEyRUlqQW54NTV1Q2FSUEtPK2hhdXVJaEorYWs5a1VF?=
 =?utf-8?B?emVIT2hkbGpiTU95VllManlLNWQyMklvSVR3UkpxQ0VYcG1iRnpsd3hLZWZk?=
 =?utf-8?B?MGhiUWd3eVUybUtRVlBETkhCVGw5VHB6WExXNHlja3dGUkN4T1lVT2JBam9k?=
 =?utf-8?B?SWZHT1dncW1FVjhsR2dmVldMNjd5WSs0UFovZEQraEhsa2NRVElDQW1wVW1Y?=
 =?utf-8?B?VEF1cVdKMGJqSHFEUGNqdXZhUXd1ejZEaDNYUWxOeDBxQ211Y1pyQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b87724-6a5a-469a-3a8f-08de9fb62c86
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 14:56:31.3720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3LV5lvyij58RXqf6uE0dooijMGQBJkU4DWKi7/H4dSu/JMv9ySwnImpIZCXowG/b9jW5oLzyb5xOpT7WvmVjJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5674

One feature that was lost from the old `dma_read!()` and `dma_write!()`
when moving to `io_read!()` and `io_write!()` was the ability to read/write
a large structs. However, the semantics was unclear to begin with, as there
was no guarantee about their atomicity even for structs that were small
enough to fit in u32. Re-introduces the capability in the form of copying
methods.

    dma_read!(foo, bar) -> io_project!(foo, bar).copy_read()
    dma_write!(foo, bar, baz) -> io_project!(foo, bar).copy_write(baz)

The semantics for these are modelled after memcpy so user has clear
expectation of lack of atomicity. As an additional benefit of this change,
this now works for MMIO as well, which maps to `memcpy_{from,to}io`.

For slices, which is unsized so the API above can't work, `copy_from_slice`
and `copy_to_slice` were added to copy from/to normal memory, and
`copy_from_io_slice` and `copy_to_io_slice` were added to copy from/to
other `Io` regions. They're optimized if at least one end is mapped to
system memory; if none are, the copy occurs with an intermediate stack
buffer.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/dma.rs |   8 +-
 rust/kernel/io.rs  | 231 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 238 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index bbdeb117c145..307f5769ca0a 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -16,7 +16,8 @@
     fs::file,
     io::{
         Io,
-        IoCapable, //
+        IoCapable,
+        IoCopyable, //
     },
     prelude::*,
     ptr::KnownSize,
@@ -997,6 +998,11 @@ unsafe fn io_write(&self, value: $ty, address: *mut $ty) {
     u64
 );
 
+// SAFETY: `Coherent` is mapped to CPU address space.
+unsafe impl<T: ?Sized + KnownSize> IoCopyable for Coherent<T> {
+    const IS_MAPPED: bool = true;
+}
+
 impl<'a, B: ?Sized + KnownSize, T: ?Sized> crate::io::View<'a, Coherent<B>, T> {
     /// Returns a DMA handle which may be given to the device as the DMA address base of
     /// the region.
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index efcd7e6741d7..0b1ed68c0f9b 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -4,6 +4,8 @@
 //!
 //! C header: [`include/asm-generic/io.h`](srctree/include/asm-generic/io.h)
 
+use core::mem::MaybeUninit;
+
 use crate::{
     bindings,
     prelude::*,
@@ -233,6 +235,55 @@ pub trait IoCapable<T> {
     unsafe fn io_write(&self, value: T, address: *mut T);
 }
 
+/// Trait indicating that an I/O backend supports memory copy operations.
+///
+/// # Safety
+///
+/// If [`IS_MAPPED`] is overridden to true, it must be correct per documentation.
+pub unsafe trait IoCopyable {
+    /// Whether the pointers for this I/O backend are in the CPU address space, and are coherently
+    /// mapped.
+    ///
+    /// When this is true, it means that memory can be accessed with byte-wise atomic memory copy.
+    const IS_MAPPED: bool = false;
+
+    /// Copy `size` bytes from `address` to `buffer`.
+    ///
+    /// # Safety
+    ///
+    /// - The range `[address..address + size]` must be within the bounds of `Self`.
+    /// - `buffer` is valid for write for `size` bytes.
+    #[inline]
+    unsafe fn copy_from_io(&self, address: *mut u8, buffer: *mut u8, size: usize) {
+        const_assert!(Self::IS_MAPPED);
+
+        // Use `bindings::memcpy` instead of copy_nonoverlapping for volatile.
+        // SAFETY:
+        // - `buffer` is valid for write for `size` bytes.
+        // - `IS_MAPPED` guarantees `address` is in CPU address space, with safety requirements
+        //   `address` is valid for read for `size` bytes.
+        unsafe { bindings::memcpy(buffer.cast(), address.cast(), size) };
+    }
+
+    /// Copy `size` bytes from `buffer` to `address`.
+    ///
+    /// # Safety
+    ///
+    /// - The range `[address..address + size]` must be within the bounds of `Self`.
+    /// - `buffer` is valid for read for `size` bytes.
+    #[inline]
+    unsafe fn copy_to_io(&self, address: *mut u8, buffer: *const u8, size: usize) {
+        const_assert!(Self::IS_MAPPED);
+
+        // Use `bindings::memcpy` instead of copy_nonoverlapping for volatile.
+        // SAFETY:
+        // - `IS_MAPPED` guarantees `address` is in CPU address space, with safety requirements
+        //   `address` is valid for write for `size` bytes.
+        // - `buffer` is valid for read for `size` bytes.
+        unsafe { bindings::memcpy(address.cast(), buffer.cast(), size) };
+    }
+}
+
 /// Describes a given I/O location: its offset, width, and type to convert the raw value from and
 /// into.
 ///
@@ -841,6 +892,19 @@ unsafe fn io_write(&self, value: $ty, address: *mut $ty) {
     writeq
 );
 
+// SAFETY: `IS_MAPPED` is not overridden.
+unsafe impl<T: ?Sized + KnownSize> IoCopyable for Mmio<T> {
+    unsafe fn copy_from_io(&self, address: *mut u8, buffer: *mut u8, size: usize) {
+        // SAFETY: Per safety requirement.
+        unsafe { bindings::memcpy_fromio(buffer.cast(), address.cast(), size) };
+    }
+
+    unsafe fn copy_to_io(&self, address: *mut u8, buffer: *const u8, size: usize) {
+        // SAFETY: Per safety requirement.
+        unsafe { bindings::memcpy_toio(address.cast(), buffer.cast(), size) };
+    }
+}
+
 impl<T: ?Sized + KnownSize> Io for Mmio<T> {
     type Type = T;
 
@@ -1029,6 +1093,173 @@ pub fn write_val(&self, value: T) {
     }
 }
 
+impl<'a, IO: ?Sized, T> View<'a, IO, [T]> {
+    /// Returns the length of the slice in number of elements.
+    #[inline]
+    pub fn len(self) -> usize {
+        self.as_ptr().len()
+    }
+
+    /// Returns `true` if the slice has a length of 0.
+    #[inline]
+    pub fn is_empty(self) -> bool {
+        self.len() == 0
+    }
+}
+
+impl<T, IO: ?Sized + Io + IoCopyable> View<'_, IO, T> {
+    /// Copy-read from I/O memory.
+    ///
+    /// There is no atomicity gurantee.
+    #[inline]
+    pub fn copy_read(self) -> T
+    where
+        T: FromBytes,
+    {
+        // Optimized path if I/O backend is CPU mapped.
+        if IO::IS_MAPPED {
+            // SAFETY:
+            // - `IS_MAPPED` guarantees `self.ptr` is in CPU address space, with type invariants
+            //   `self.ptr` is valid for read for `size` bytes.
+            // - `T: FromBytes` guarantee that all bit patterns are valid.
+            // - Using read_volatile() here so that race with hardware is well-defined.
+            // - Using read_volatile() here is not sound if it races with other CPU per Rust
+            //   rules, but this is allowed per LKMM.
+            return unsafe { self.ptr.read_volatile() };
+        }
+
+        let mut buf = MaybeUninit::<T>::uninit();
+        // SAFETY:
+        // - Per type invariants.
+        // - `buf.as_mut_ptr()` is valid for write for `size_of::<T>()` bytes.
+        unsafe {
+            self.io
+                .copy_from_io(self.ptr.cast(), buf.as_mut_ptr().cast(), size_of::<T>())
+        };
+        // SAFETY: T: FromBytes` guarantee that all bit patterns are valid.
+        unsafe { buf.assume_init() }
+    }
+
+    /// Write to I/O memory.
+    ///
+    /// There is no atomicity gurantee.
+    #[inline]
+    pub fn copy_write(self, value: T)
+    where
+        T: AsBytes,
+    {
+        // Optimized path if I/O backend is CPU mapped.
+        if IO::IS_MAPPED {
+            // SAFETY:
+            // - `IS_MAPPED` guarantees `self.ptr` is in CPU address space, with safety requirements
+            //   `self.ptr` is valid for write for `size` bytes.
+            // - Using write_volatile() here so that race with hardware is well-defined.
+            // - Using write_volatile() here is not sound if it races with other CPU per Rust
+            //   rules, but this is allowed per LKMM.
+            unsafe { self.ptr.write_volatile(value) };
+            return;
+        }
+
+        // SAFETY:
+        // - Per type invariants.
+        // - `&raw const value` is valid for read for `size_of::<T>()` bytes.
+        unsafe {
+            self.io
+                .copy_to_io(self.ptr.cast(), (&raw const value).cast(), size_of::<T>())
+        };
+        core::mem::forget(value);
+    }
+}
+
+impl<IO: ?Sized + Io + IoCopyable> View<'_, IO, [u8]> {
+    /// Copy bytes from slice to I/O memory.
+    #[inline]
+    pub fn copy_from_slice(self, data: &[u8]) {
+        assert_eq!(self.len(), data.len());
+
+        // SAFETY:
+        // - Per type invariants.
+        // - `data.as_ptr()` is valid for read for `data.len()` bytes.
+        unsafe {
+            self.io
+                .copy_to_io(self.ptr.cast(), data.as_ptr(), data.len())
+        }
+    }
+
+    /// Copy bytes from I/O memory to slice.
+    #[inline]
+    pub fn copy_to_slice(self, data: &mut [u8]) {
+        assert_eq!(self.len(), data.len());
+
+        // SAFETY:
+        // - Per type invariants.
+        // - `data.as_mut_ptr()` is valid for write for `data.len()` bytes.
+        unsafe {
+            self.io
+                .copy_from_io(self.ptr.cast(), data.as_mut_ptr(), data.len())
+        }
+    }
+
+    fn copy_from_io_slice_via_buffer<T: ?Sized + Io + IoCopyable>(&self, data: View<'_, T, [u8]>) {
+        let mut buf = MaybeUninit::<[u8; 256]>::uninit();
+
+        let mut dst_ptr = self.ptr.cast::<u8>();
+        let mut src_ptr = data.ptr.cast::<u8>();
+        let mut len = self.len();
+
+        while len != 0 {
+            let copy_len = core::cmp::min(len, 256);
+            // SAFETY:
+            // - `src_ptr` is valid for I/O read of `copy_len` bytes per type invariants of `data`.
+            // - `buf.as_mut_ptr()` is valid for write for `copy_len` bytes as `copy_len <= 256`.
+            unsafe {
+                data.io
+                    .copy_from_io(src_ptr, buf.as_mut_ptr().cast(), copy_len)
+            };
+
+            // SAFETY:
+            // - `dst_ptr` is valid for I/O write of `copy_len` bytes per type invariants of `self`.
+            // - `buf.as_mut_ptr()` is valid for write for `copy_len` bytes as `copy_len <= 256`.
+            unsafe { self.io.copy_to_io(dst_ptr, buf.as_ptr().cast(), copy_len) };
+
+            dst_ptr = dst_ptr.wrapping_add(copy_len);
+            src_ptr = src_ptr.wrapping_add(copy_len);
+            len -= copy_len;
+        }
+    }
+
+    /// Copy bytes from `data` I/O slice to the `self` I/O slice.
+    pub fn copy_from_io_slice<T: ?Sized + Io + IoCopyable>(&self, data: View<'_, T, [u8]>) {
+        assert_eq!(self.len(), data.len());
+
+        if T::IS_MAPPED {
+            // SAFETY:
+            // - Per type invariants.
+            // - `data.as_ptr()` is valid for read for `data.len()` bytes.
+            unsafe {
+                self.io
+                    .copy_to_io(self.ptr.cast(), data.as_ptr().cast(), data.len())
+            }
+        } else if IO::IS_MAPPED {
+            // SAFETY:
+            // - Per type invariants.
+            // - `self.as_ptr()` is valid for write for `self.len()` bytes.
+            unsafe {
+                data.io
+                    .copy_from_io(data.ptr.cast(), self.as_ptr().cast(), self.len())
+            }
+        } else {
+            self.copy_from_io_slice_via_buffer(data)
+        }
+    }
+
+    /// Copy bytes from `self` I/O slice to the `data` I/O slice.
+    #[inline]
+    pub fn copy_to_io_slice<T: ?Sized + Io + IoCopyable>(self, data: View<'_, T, [u8]>) {
+        data.copy_from_io_slice(self)
+    }
+}
+
 /// Project an I/O type to a subview of it.
 ///
 /// The syntax is of form `io_project!(io, proj)` where `io` is an expression to a type that

-- 
2.51.2

