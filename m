Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021087.outbound.protection.outlook.com [52.101.95.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8867459AF9;
	Wed, 19 Aug 2026 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787137827; cv=fail; b=I6cQbWd6HO390KSETAzkFbJytkDyqRK3B1HkKeK8i4Ro+jXlK/6aXgNiBexdv3erJg+vJe4wJGA9Zd8NC57kp7einpeiCG8s7SQhyugM5cEwoQiH/CbPKegIHR3xTCnxe6FYdjEeFd5OcWaeuhB5n0JQiA6bQTuE1tivCznQ/tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787137827; c=relaxed/simple;
	bh=U5eGkkYvQADr4TTFPN+0TCXo9RfXrHMnOeCh7ums5W4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CoZSeX+8StnXKwxyosJ8SWBN9lHOkTbAxeBUucWFve2N+6NhlO3fWClWZTW+HDk8TJjazQmis/asSd3x88A1mMb60/yszplRTgGz4BUUKQPgftiEvxRNedeDCZKPr9/78DVxHnvISI0BB1o1rXJemeba0YxF8ay5Ji3pMf2Opr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=kGfN1xFC; arc=fail smtp.client-ip=52.101.95.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="kGfN1xFC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zATGqCKUJvWz77W8gP9MZQLeTzr+iccbkX4pgISZ4rrrXrOZm3aE8Bx4H8biCyfTNcpBuVtjEk5yWVexqcbHO/xfaWGPasnIEd2MwAW4xzMBS56YTnc3GVtjf19b9fzWD45uT9pa2IAgWzMxF2hUb3EeizQzWM0GeAfWAU04aK+ERoVv5S+8GxvJETkMFnIxzeGyB5WkL5xuEPb2VxI5nzGJg4k/ULEddXa4RlIaVFL3tH4+yrJnMvDV0UjCIZ63Zd5EUYUtnU1R2pbiCMp7bf6mG9Vk+4Qvgfty7vaxyCT1uFWNiISfr+rptJSNwZeRFPC48A59+36GnrE+Dk3qww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNbnK7EWtcupeD63vJljcXrAq764/NWDK2IMvXG5HMY=;
 b=CMk33GgL/V79qiuOT9rKjzK3tIn/2LW9eX4GP4bxeJFoUvQ/lKvV++MVY3UNIF1k4DnP0nVG+pLGJOpdOMHZU+PekcnrhPPk28Ppy0RMw6aL00J6sRST+ksYZQa4H+SKXa5V4dfubIDIDnGuyiJOv/b31+ghB2RqMPOOECeNAENSxWNOl2Rb68A7HlzidsRU/a86njn6hM5Xy9yDABo1z940RHVYS06/pzX+qZ5KQ4wzTYENbv3Eu4AU5xJ9h0M7Q0YjH7hWYg/qrTf34pnAPThn02jieSHqB5sxr/IvzCoKOM8tGH11gbR+IyY9u86O5EO/8KJUabep8ibPvq+gxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNbnK7EWtcupeD63vJljcXrAq764/NWDK2IMvXG5HMY=;
 b=kGfN1xFCW6EcCx6xWkmp1g2vc2lhTvCN5RarFIOGQUCisNPubtO6K5/2tDRdq4CLp0vV/voyTXyEadI7eFjjo3Lm8ndukD+euXv0x5hrldPhSrg0PxwClBAf3QSuucVrFDL7SQMkjzpDtDvZaDYowqe18yGr0J2AslbUmvh5ApI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB7056.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:200::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 11:10:18 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 11:10:18 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 19 Aug 2026 12:09:13 +0100
Subject: [PATCH v3 05/16] rust: io: support register projections
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-typed_register-v3-5-3699a75fadf1@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787137814; l=5270;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=U5eGkkYvQADr4TTFPN+0TCXo9RfXrHMnOeCh7ums5W4=;
 b=ymP3QVpluvwtOhBEWP6phQFPe+xRniP/tw12BolNOftwvfuMdl4OXLsM59rpL+Gs3p4FikWg/
 vi1S4XmLftmDSEldxL1O2Q7FGHgaKpISBsPaFdr20snKcYzXnwrT/Fn
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
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB7056:EE_
X-MS-Office365-Filtering-Correlation-Id: c5be3b55-6bda-42cc-8b1e-08defde273c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|1800799024|7416014|366016|23010399003|10067099003|56012099006|6133799003|5023799004|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	XD8rShmPS/y2APPIWQBuprfLeihH/Iqagh348GoQf8JaUhORtjnfoW/72YeSz9wD0lzld4Yb+k4ywjWCbXHwZa9SvVCAejV5ZzD8lX1szmhvNqPWFrwzSK2zP+1HdOzrTw8FjNbK9Xhb6r5t+58qQ/f1v4j1en1+pShiGQzyDVoPxCjT5qDbOFhzfgogC5k+ckJ2P2LpXAgz5e2G1rgmfJCanUwn9saI2a/517C4MkufSdgYwMsrsAJfulIyC2VvMZXIRGKn0Pg1EEpBbkygrk4AglzS0hkifNgyl1+uyaYli7tIrpJ5gGSwSA/xzU86CJp8Mbxp8OA9HGvVsVZPVmJh5/+PN6kHpUVS5lAylQ5lLi0KMPeIGz3JNSQMBsXtCgHHDR+LtdTHOD0ljVNqo/r+aLtEPtHWY7LKgPfIFrz5FtmCmrVXtaQr/EJQ7ndlfo8cPhedd9VAfuFwEw26H9GOhx8RqkFTeNCY+zDVgERqbPPRLHD2P2/RxHrvfVoSlqhJBDWgYs786CMfHV6ReJmEPoz7BMOu8Vmbtx2669bdEvaTvwrGkxFG4Pmznp8v9SZL1EKcbgrEefRqe2tMdSFb8LufZYrHecrs85nih0BDTWRRpleIt6EiK9vE07LXX6KJ0TtWqLl7H6FNp+yeHd9aGIa452/4I2xdlzqZUcgY949YRRdi6KiJBsEp9KB3QxuZ9z5rvOozK9ltvKx65Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(7416014)(366016)(23010399003)(10067099003)(56012099006)(6133799003)(5023799004)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWxwUkhxL253RmRneTJnbENqUFB2bFJQcWVSTm5kVzBwU3JFNUZ6aXZleFJJ?=
 =?utf-8?B?LzkyWnlsQVZuMFhQZnM1T0dadDhCUHRDNGlUUFAxeXVFeEhyV2xVUjlwY1RJ?=
 =?utf-8?B?alh6R0Z1WUl5VkdSdkVKdXpjMTRQNUhEdDZpYVlBMjFxUEF6aDVKQVpZbmtv?=
 =?utf-8?B?OFZoeitEdElBQmgxZ1M2VDVYdXpJTlB6bHFNUms4blNpS1ViQlhNR016VVNQ?=
 =?utf-8?B?TFZBZWlYQksxdXNEOFlKaTgrbXRwSkpEOFI5Y2FYSEwvOWludG5LamhDNC9h?=
 =?utf-8?B?S042dVRJaVdDR0laM3habGVhK2VXYzR0MUtIVHU2cHVSbjY0UjJLbmhJeUsr?=
 =?utf-8?B?bVc4Yjdaa0I0aUQxSU5lb2xpV3lSY0l3OTVCYVBuNmI2YWJ5cEpna2lUT1dP?=
 =?utf-8?B?OFR3ODNBU0tZWURHaVRpSHJha29QaVg0Sk0xZHIybW5SNlduN0U1RFo2WlIw?=
 =?utf-8?B?UE9RMGtGZDVVSG9Rc1pJVVl5Q1Y5cXEwZUFEbmN1bDB3OC81OFVtYlBzdXlK?=
 =?utf-8?B?cUpCS1U3UkwwTXhwZ2RHbEUxMTV4UGZlNU01K1NPb1JuMWFxd2RMNmZVckNy?=
 =?utf-8?B?Y1VSNzA1bWJobHAxbTJUblJTRUJlSFVPVEFlTVFCdXRtbGpkdlZ2aTI4UlR2?=
 =?utf-8?B?ZzRNSVhXMStVNVlYWnQ1Tks2eDlyeE41YjJGNWxzR2lvSU9VamRPeW1HVGF0?=
 =?utf-8?B?NHplMG5vVFRQeDhoakJhWTZtT0tpNG1lK3lZMUJsQXBkYmZVb0FIVkV1RzEw?=
 =?utf-8?B?NkZhQzIyQkdzK2tDcTBXQ1lOUVp3MTcxcE1nWnR6NXpsQXVpeTB2VnkrS2Ju?=
 =?utf-8?B?VG1BVU85bm12aWZrTkxMdWxXdGliSlF1ZXNkSFJsbFlEMWE4dWJYdkdUL2pv?=
 =?utf-8?B?NHNrRzJHT1F3REUyM2FNQU14NC82NmxGYitpeDR5akJoNEpiNEhiK1hYaXk3?=
 =?utf-8?B?NzlEQTJaVUNmUjFzeEZtdU1pUFIyODduS292YTdHeW4xelBGQUJEYWdMb1BQ?=
 =?utf-8?B?S0NuUk80QTY5RklHZlNmcFZsR3ZzMVFTNGZIQkF6R2U3RkFLVkVEa2I1bmVi?=
 =?utf-8?B?blNWbzNzaThnd09vRW9PN3g1WnFIWk55MTVObzR3ZU1veEFNcmQxYmNOWFR3?=
 =?utf-8?B?U1kxYlk4em0ybHBGQXB1NHdwaUpFUURCVUg4Ym8xaWhLVkdsd1h2VGVCWVkv?=
 =?utf-8?B?U1NqWmVFbXBLZEx0MXRmSFI3aExJU2wvbVVYNFFTdEN3TjFjUnVacHJoQ0NL?=
 =?utf-8?B?di82cEk5bGdsN210YlpWcXc5bE9TbmNjTnBlVHBGY1VCRElOWU9mVGo0dys1?=
 =?utf-8?B?bHVqdEttbXZPREJ4b29qVEkzOWFPTEdxN2hxY3J2bEdWWVdkRyt1eFZ4N1FO?=
 =?utf-8?B?dFlSUFBTNkhnNjl3SG5UUWJTWklBdFQrZEFaaUpYSVlNejJNOVlDaWVGWUph?=
 =?utf-8?B?NU9WYVByWitzTHg3NC9LSFRYRHJkUU8rNkJ1Z3BwRTdtclBJa0w4aS80V0t2?=
 =?utf-8?B?dkMreDNoT1lHZ0M5b1Ezb2pYUE45MHJwTjZpbTNnRGtTUlJ5cjlWNEZUM3Nz?=
 =?utf-8?B?YTlEN2Q1bGVwM0Ztei8wNnM4bTcvM2ZHa29sOU1NeWtvT2NFVjgzWE0yeDhP?=
 =?utf-8?B?SHhycFk0dmNsVXBTOTVBa1Y4TjV4UDVuSDcxMDh0d3JmUVp0ajdYS0pWUUts?=
 =?utf-8?B?cSsrQXFaOVJuL054SWhqdUxjbGt1SzFtdld1NDEvT3Bqbm8ySmNGMUhGRnhT?=
 =?utf-8?B?dDJ3SGU4QzdhVkZINUYvYVZ3Sm5OSXJYRDl3NGMzeVRkQWswWWp4ZWx0RGFE?=
 =?utf-8?B?TXl5NXN3a2lyUS8yMjNLbisvOFJGbDF3SlFtb1NpZWFpd0owSTJ5Z3FTK3NF?=
 =?utf-8?B?dXhHbDBQaGI3SnJ0eitMLzAvZlVDVkRscmlxeC85SWN0bTZPRGh4OVllWDRK?=
 =?utf-8?B?c1lpRFhXeHlGa0VSOVZCQytpMlFLbGdGZ3hEN1ArdGNrUy9Ta0NvZTBlUzVv?=
 =?utf-8?B?YkRQck5KUWIwNjdEY01XejNEdEwvaExwSFBFUnVqQkgyQSthMjJVUnBtUmNK?=
 =?utf-8?B?djZwMGNTZFJNbUNVM3puUDRIS01XeHJQSHphNHZtbE5JTGZnaWVwMThJVEJz?=
 =?utf-8?B?TG5LNE1NZU9BeTF2eklLbzk4T2l5VFY2RXNscFdQRDdLdDVBUHBEOHhkTzJ2?=
 =?utf-8?B?VXFyY3d2eldKTC9GSUZGMklyN0F0YWJwdE9uVnVxdEJOSm9IVi84WG1jc281?=
 =?utf-8?B?VXpXS09WMGVWN3RzK3JOTHcwVm12aHVXRXFiUDZoQ2hrM09XUVRMMHlqbkZl?=
 =?utf-8?B?SVhGSTFXb1ZaK1N1UzM5UC9iQnc1K2RrdzA5RXNEdWZLQk94ZVQxUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c5be3b55-6bda-42cc-8b1e-08defde273c4
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 11:10:18.0905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pug5hDbIKvUYnlMuaJLwEHuCMVHc1acZR0DzSNafrv54YEbGm4QB29MGLwbHYbMWUvTGTlz2H5x5DE5y+Nx3jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB7056

`IoLoc`s themselves just describe a projection from a region to a concrete
register. Thus, support it in `io_project` macro too. Also, update methods
that operate on `IoLoc` to use I/O projection.

Documentation of `io_project!` is not expanded yet as the example works
better when `register!` type can specify base type. `io_read!` and
`io_write!` gains the ability to operate on registers as corollary of the
capability of `io_project!`. Examples are not added because `read` and
`write` is still preferrably used instead.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs | 56 +++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 6c087d30a166..ea072c098b13 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -864,8 +864,7 @@ fn try_read<T, L>(self, location: L) -> Result<T>
         L: IoLoc<Self::Target, T>,
         Self::Backend: IoCapable<<T as AsRepr>::Repr>,
     {
-        let view = io_view::<Self, T>(self, location.offset())?;
-        Ok(view.read_val())
+        Ok(io_read!(self, try: location))
     }
 
     /// Generic fallible write with runtime bounds check.
@@ -898,8 +897,7 @@ fn try_write<T, L>(self, location: L, value: T) -> Result
         L: IoLoc<Self::Target, T>,
         Self::Backend: IoCapable<<T as AsRepr>::Repr>,
     {
-        let view = io_view::<Self, T>(self, location.offset())?;
-        view.write_val(value);
+        io_write!(self, try: location, value);
         Ok(())
     }
 
@@ -978,7 +976,7 @@ fn try_update<T, L, F>(self, location: L, f: F) -> Result
         Self::Backend: IoCapable<<T as AsRepr>::Repr>,
         F: FnOnce(T) -> T,
     {
-        let view = io_view::<Self, T>(self, location.offset())?;
+        let view = io_project!(self, try: location);
         view.write_val(f(view.read_val()));
         Ok(())
     }
@@ -1011,8 +1009,7 @@ fn read<T, L>(self, location: L) -> T
         L: IoLoc<Self::Target, T>,
         Self::Backend: IoCapable<<T as AsRepr>::Repr>,
     {
-        let view = io_view_assert::<Self, T>(self, location.offset());
-        view.read_val()
+        io_read!(self, build: location)
     }
 
     /// Generic infallible write with compile-time bounds check.
@@ -1043,8 +1040,7 @@ fn write<T, L>(self, location: L, value: T)
         L: IoLoc<Self::Target, T>,
         Self::Backend: IoCapable<<T as AsRepr>::Repr>,
     {
-        let view = io_view_assert::<Self, T>(self, location.offset());
-        view.write_val(value)
+        io_write!(self, build: location, value);
     }
 
     /// Generic infallible write of a fully-located register value.
@@ -1121,7 +1117,7 @@ fn update<T, L, F>(self, location: L, f: F)
         Self::Backend: IoCapable<<T as AsRepr>::Repr>,
         F: FnOnce(T) -> T,
     {
-        let view = io_view_assert::<Self, T>(self, location.offset());
+        let view = io_project!(self, build: location);
         view.write_val(f(view.read_val()));
     }
 }
@@ -1666,6 +1662,25 @@ pub unsafe fn project_view<U: ?Sized + KnownSize>(
         // SAFETY: Per safety requirement.
         unsafe { T::Backend::project_view::<T::Target, _>(self.0, ptr) }
     }
+
+    #[inline(always)]
+    pub fn try_project_loc<U, L>(
+        self,
+        location: L,
+    ) -> Result<<T::Backend as IoBackend>::View<'a, U>>
+    where
+        L: IoLoc<T::Target, U>,
+    {
+        io_view::<_, U>(self.0, location.offset())
+    }
+
+    #[inline(always)]
+    pub fn project_loc<U, L>(self, location: L) -> <T::Backend as IoBackend>::View<'a, U>
+    where
+        L: IoLoc<T::Target, U>,
+    {
+        io_view_assert::<_, U>(self.0, location.offset())
+    }
 }
 
 /// Project an I/O type to a subview of it.
@@ -1693,6 +1708,21 @@ pub unsafe fn project_view<U: ?Sized + KnownSize>(
 #[macro_export]
 #[doc(hidden)]
 macro_rules! io_project {
+    // Register projection
+    ($io:expr, try: $ioloc:expr) => {{
+        #[allow(unused)]
+        use $crate::io::IoBase as _;
+        let view = $crate::io::ProjectHelper($io.as_view());
+        view.try_project_loc($ioloc)?
+    }};
+    ($io:expr, build: $ioloc:expr) => {{
+        #[allow(unused)]
+        use $crate::io::IoBase as _;
+        let view = $crate::io::ProjectHelper($io.as_view());
+        view.project_loc($ioloc)
+    }};
+
+    // Field or index projection
     ($io:expr, $($proj:tt)*) => {{
         #[allow(unused)]
         use $crate::io::IoBase as _;
@@ -1763,6 +1793,12 @@ macro_rules! io_write {
     (@parse [$io:expr] [$($proj:tt)*] [[$flavor:ident: $index:expr] $($rest:tt)*]) => {
         $crate::io_write!(@parse [$io] [$($proj)* [$flavor: $index]] [$($rest)*])
     };
+    (@parse [$io:expr] [] [try: $ioloc:expr, $($rest:tt)*]) => {
+        $crate::io_write!(@parse [$io] [try: $ioloc] [, $($rest)*])
+    };
+    (@parse [$io:expr] [] [build: $ioloc:expr, $($rest:tt)*]) => {
+        $crate::io_write!(@parse [$io] [build: $ioloc] [, $($rest)*])
+    };
     ($io:expr, $($rest:tt)*) => {
         $crate::io_write!(@parse [$io] [] [$($rest)*])
     };

-- 
2.54.0

