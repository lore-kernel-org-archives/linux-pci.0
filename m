Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020097.outbound.protection.outlook.com [52.101.196.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59A73F1ACC;
	Mon,  8 Jun 2026 19:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948774; cv=fail; b=uhmL/TM9wuvf+PeFzv42yK/6bR5D1ByKrT3NsxupnG5ZuBNEUQxD1AKfdYzxSsjGmKjHyMGfSz51egtTwTogZkvrRH5hyYeWO4VaxpVNLRt4dkUlyXjFc2zzEEsMFYzWO53aV0eo2AvTVd74YoKWPkIi2XVfiteNLU83EvVrHLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948774; c=relaxed/simple;
	bh=3nIiOE6FJXaI1YLRgnb53IPPaAbfEtvdGIHEVlnr5jY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=k1/F/lQQUnwYXGv6xTJr4iqbOHajAzSKj3WIVeZu9YsN5xWlrlBzFGTJY4AgwJlAKhYxfiHHlEmXVlavM3YRaFqI8VBlXq3y/+013m5pmT9NZDU2pdEqZxywViZ/8imPqVO2mEsua/qsZPgHnhuE3BZsYTgAD288tttzn0xCupQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ZXOPQjg5; arc=fail smtp.client-ip=52.101.196.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ZXOPQjg5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h548KC/BjYlzziUt5OAqg8zepbYIendTWWhnUNBNLFee9SfTGt0babeEVF2NBAlKLAE0E9CCKfgTMT6SyLXA9VBGgb1FH+neUgYN+x9bZujWgPh4XJu4tPC6Yp97ORwMTDE+OxOLZqE+W4WR23Cp1p7bKhFde7bPTW8EMEWuGyEbuLuyM4dXDc1l8eRcfavfnDQdKgFIqxq3AhMTSmZWHFa5vcZGUsJl3C0raP+AFBl9yWi2CTuvJDGU+CrR+ZQRkMgN7HA0VV2go6AkXoYLE50rohZUw+21hL9M+nlaWabuUTihr74nxYkSu39rwhpyXDg2qjeJxAkBBfZX+QjPhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mo92A5YIhqAgyTJ5d5JrCMrcSLa0f1V1WI7G/2pctzw=;
 b=GtZS8di8eQZToxH2OXanWruPnLS5ACRqevJAYxI99IwLMIell0uWf0rJvyuZGYIBDmRBJ61yFIbe3Iv9gA4jk02ckdMwCho/xBMXIEstlzdIqAlCtaT8+wSCKKgFMp3bMHdq+ukC/sF/W0vaej61h1gzoLJUgrIPTI2Ykibs9N7DK2gw3cQxfbO5nheNHt6AhyV7gP4WrquSf9IHlDiUwPwV1q5CzzsAMyH0nWmsguA36CB+G2hkAhisnEIilcoYGQvzSlpatioIC8+vlmOZ8MWtyxSytG+sn5EaXNEcwXC4YCfNzQgC44RMzSGed7iu1c65S7lQnNWtoT6rWHF/hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mo92A5YIhqAgyTJ5d5JrCMrcSLa0f1V1WI7G/2pctzw=;
 b=ZXOPQjg5NfzHIpzJgs2slIMOPlrLe2gKLzL7mCNq/zhZC4qYGOZYUdBzzoS2M3iOqDwZotdNFaOJxuqqg9t5DZxGHdfVtR9oAtDpB0P75rvfalBjL6KCDzASNAEkLa3/l/rwt4rgblFd7I25ytWbjTInb8byw8k/1b5Zbkfmui0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7398.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 19:59:13 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 19:59:13 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 08 Jun 2026 20:59:11 +0100
Subject: [PATCH v3 14/19] rust: io: implement a view type for `Coherent`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-io_projection-v3-14-c5cde13a5ec4@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780948747; l=5606;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=3nIiOE6FJXaI1YLRgnb53IPPaAbfEtvdGIHEVlnr5jY=;
 b=pw5VhRge3g2Qs5r/5Tt0J9dyAuuO9LLWqhMXEl1BNUTrDaLc96SDTXtpCErj9avRZ1wst3QA9
 ldrZTGOwO1oAnrhooE6s4zfpaiLdo3Jik47Vw6da/JpNC6CN2fvjdh8
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
X-MS-Office365-Filtering-Correlation-Id: f70c1e67-f3a0-4926-d6a2-08dec59869e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|6133799003|22082099003|18002099003|921020|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	+VPRFaLZKM8s+90I2erNzMkW0VE1yd3Wy7rFfRJHDBZo4Ec3xPZyxKASFujaa3bYwwkY9D35a8e82oGCTYcKECaGQLj0ZvmXgjRrBPUd2PE4gw/d4tsw3HAKa79toJOICVyCTxaWUCvLUf0b26Slc5YaGf/Duj2aJbdVF5naX+kEC749xHNwb7kqI5b/oWgKHOOnvlv746PkL1n0eH1hxvnt9sifQhm2KGK1z6W0LN4N1t30KfsKM7X8zBozwo7JutaZlreIYG6SVG326o6C1zyKTmertDKrdKafuz0c4IeqipG0Ix9J++Az5YSpUB72etibBIpWA9NIrKpeTbgyKoQ0Te9wdvw6OqfIvQkF+fZxRW2KD684pgWej1nQVQLPzBunwJvKXP68vczznwpTKMNR4XS8dWP+sI98GvrlVcJeGhooxjwqHNWZ47skDm0odidLtIJa1pIXSZeGREnNaLplGCzbbyjH90n1zNi7Qs9lM7E0f+2RxsQSpWBcEMHbEV43dzXJI0RVXvHNtokvEvjrY98xIPSKmljMn0oSlwxEkqqn4kXfMlIQMyeywVvYbDyIw0OOW3SmXlrHgaIX93o3CYK8W4i1DFAjcRHZYq26H5E8Ljot5o+LvDyceUnKj0taamyajtcKmWFv9liwRH/8EZbyNi3omJDzbjN9WZLC9VK0IHGZ6E+PZNsO/IYsn+7BWgrvNbFsngSIxr7fl998fSCY/cGj02FnZhiRq9I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(6133799003)(22082099003)(18002099003)(921020)(56012099006)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1ZDVnJVQ0xJV0U4SE9tQ3IzTVJpMVgxaG9ndy9HSXhlT1ZnSXhMSUxQb3Zh?=
 =?utf-8?B?ejVOYncwYWp3STNqZ1EyMnU5d25nbmUwaVJHaWRmcWpSTnR2bEJLbXF1emRD?=
 =?utf-8?B?Qm1vdm5pdFAxZFBCN2tDS1lzOStYMHczejlGaGJPSCs3ZGlENDBtdSttRnRN?=
 =?utf-8?B?cGlySUg5OVlyUU5zcmluVzVLWkYyOWZGK0FOMXdJbTBGbVJXQVU5VmV0SFF6?=
 =?utf-8?B?VkFjNEM4NkpOVVdmNjVrZ2lzNlN2NmF2Mm5IUG1PMXFqYkRSZE9LbDY0b3lD?=
 =?utf-8?B?QUlyNnVRd3did0ZBanpqT25ZeW0zTG1IMFZDMXVkSzYwcC9qTnpFc0NOWXMx?=
 =?utf-8?B?d0hxaHJXdWtpdjRyeU5ncjJyOTUrTUNpMUZ2RkRrVTE5S2RXOURaa3lLYWQz?=
 =?utf-8?B?dFBqdEdKRFREVjJkOEpuOEp5elo0Mnd0emV2NVd5enFKVjl5NnBmclBtYzV3?=
 =?utf-8?B?Q2d3Zkpyd1BJbXV2V0VOSGhycWtSMXFMYWYreWhycGZWK2liWDlGSmx1L1cx?=
 =?utf-8?B?bVBpQXZqZEd4VUdJeGhjWFEvVCtZUmN0Uk1GSEVBTHVwQkpjWDhzMXVndXRB?=
 =?utf-8?B?Yk5jOFBON2F5ZFBPaEw4aVNNcm9xTWhDR0tLZGYyalp6Vnc3Z3hxUHlOYmdk?=
 =?utf-8?B?R1hXaEF4V2FibG80dzUwakQ4SW82aVFML2pqMSsxN1RFNUN4ek16Q0JiaDlN?=
 =?utf-8?B?aHpyWHlnVEZoMjR0ajNtZEt4NTFGMm41NnNFamFJditCRG1NWTBja21rcndL?=
 =?utf-8?B?d1lxMGI3N1Z1NVZ0bzlxdzh3V1VXMi9oamtwdlRjNkg2Zng2dFc3bEM3djAr?=
 =?utf-8?B?NWFiaDA1MXovbXdXMm9XVk9oOFdxNkZ1ak8raVVMbkZZd0puUXJsTkZDS21D?=
 =?utf-8?B?cDRCN2h2RWxJYVJMamdJL2ZjWUNnMlUwaEJkVGt4QjBuZE5kUDgxQ3A0c2Jk?=
 =?utf-8?B?NVlEZG0yZ00yZUlEWnFhNnBMUmxDaW96Vm1hNElNWnlyTWk1VkhwVlZ2TWNx?=
 =?utf-8?B?bEdqWkZ2SDVDdFFrWWQvM2NNWDhtUlR2TW4xTUkwOHgrcXlZYkwvWUFjbzRp?=
 =?utf-8?B?bWxtQy9SZWRVTTMzTFpVSnUyOHBKb0pGbGhuNW9Jbk15d0ZzMDIvaGhpRmsy?=
 =?utf-8?B?aENZMTNvenVqNmN6TUZtdVpVdG5LRFlNbFRHYUFUVU5DY0hJVDJ3UXFmKy84?=
 =?utf-8?B?MTRrbmxoUWJBei9PMlNDcGdMZUNJUFhqcUsvSm1rdXB4TmorbXpLUEVQN1hx?=
 =?utf-8?B?WDNpMFA0ZmVhRmU4UG9nYTZtRUpSSU41S1hpU2V1WDJhcWM0WnNBMHo4eUF6?=
 =?utf-8?B?aHVUeDNsYlhGR0RvL2ZPTHBQWXoxNDdsUFdyMm1EdmZvTFRvSkVCQ0lvSi9w?=
 =?utf-8?B?d2x0dzZUZnhOS2Y2enpnNllmbmpTUXcrYkl6ak82TkNNSFE5THZHcTZSVzZU?=
 =?utf-8?B?U3NoVDdqVHNuRjcrc0lGZ1paUStXb0JXMEVybSszdUNxbU15ZXNvcjlvMlZV?=
 =?utf-8?B?YXQrVzZvazRESGY2TSthMzV2Tk9kWUF1VDlKc3BPVjlIc3pvSTlZbjNTcVhq?=
 =?utf-8?B?VGtGWDgramVQTEMybVBYbStBZ2crTjVNck9oRzBFK1hYZ201Y2VsbTNMa0lX?=
 =?utf-8?B?RXRob1p0bFBSUFJ5R2hKTEpqNktSUFE3VDFzTWt1YWhPSHNFUnlLWVdLS0JB?=
 =?utf-8?B?TkRuQkxkUzVDOXAxcmx4YkJyUjNuL1RoMzJ2QmZ4NU5MaS9TQ3pvT05Jdy80?=
 =?utf-8?B?ZGdwUVNLT0tjd1l3a1B5eHJia3c5QXhZbkV0SjJWSkYvWGJHdlc3eVlRSHRK?=
 =?utf-8?B?Z3dKaHlQYk1EQjRxK01uQ25TdVBNODVnTWdUN3F1RW54emRuYWh2OGNYL29R?=
 =?utf-8?B?TXdmc1VTWndVTDBBRS95UjZIVUxSdENtL1ZiNjJ4WVo0SDRUY2dxKzVMUk9J?=
 =?utf-8?B?UGJnTzA2dE11YTNBOEE1bm1qSjYwR0lqU0RuOHRLOFRTcFVoSWM0TThwQklo?=
 =?utf-8?B?Z1Y4a2tmamIveWFKbFg4eXVoZHNDc3MrOVY3SE14dlNVZHBiM1hwUkV3dmxL?=
 =?utf-8?B?N2FySVdhK3V6U0RpblpvNGt1YVZGNXpHYlFoTHZlWjVxSHFaeU5lZm9yUFA1?=
 =?utf-8?B?NWNUZWVYWVJTUFRUTVFlRUh0YnZrRjR1VjIvVk04a0pkVjU3dlhzUzJtanlI?=
 =?utf-8?B?bEVuczBLbmg2ajFiWkVHOFZxYkNLNTgrUWRlZGxtT3hrMllqczdWOWlnSTYv?=
 =?utf-8?B?U3J6bFNCU3ZXWkR4OEpZNFVTN0wwM1d5ZEY2UzJoeDJwMWh5ZFp2eFl2by9E?=
 =?utf-8?B?d1pvUGo2cG9GTHJKVVk5cVFxTlhtS25nRWRVUGU4YzNnR2ZhN3FOUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f70c1e67-f3a0-4926-d6a2-08dec59869e3
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 19:59:13.6320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A8spEXmmXGnSn2rRIPQMRET8m2JC3tbSz9ikzOnA3TQgqyLOq5Qz0Z5pAyMPQAPAopP9ExS3YaNKAYp9b6/ytg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7398

Implement a `CoherentView` type which is a view of `Coherent`. To be able
to give out DMA handles, the view type contains both CPU and DMA pointers,
and the projection method projects both at once.

Delegate most of the `Io` implementation to `SysMemBackend`. Provide a
method to erase the DMA handle and give out a `SysMem` view, if the user
does not need the `dma_handle`.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/dma.rs | 137 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 135 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 200def84fb69..970a667b9be2 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -14,14 +14,21 @@
     },
     error::to_result,
     fs::file,
+    io::{
+        IoBackend,
+        IoBase,
+        IoCapable,
+        SysMem,
+        SysMemBackend, //
+    },
     prelude::*,
     ptr::KnownSize,
     sync::aref::ARef,
     transmute::{
         AsBytes,
         FromBytes, //
-    }, //
-    uaccess::UserSliceWriter,
+    },
+    uaccess::UserSliceWriter, //
 };
 use core::{
     ops::{
@@ -1133,6 +1140,132 @@ unsafe impl Send for CoherentHandle {}
 // plain `Copy` values.
 unsafe impl Sync for CoherentHandle {}
 
+/// View type for `Coherent`.
+///
+/// This is same as [`SysMem`] but with additional information that allows handing out a DMA handle.
+pub struct CoherentView<'a, T: ?Sized> {
+    cpu_addr: SysMem<'a, T>,
+    dma_handle: DmaAddress,
+}
+
+impl<T: ?Sized> Copy for CoherentView<'_, T> {}
+impl<T: ?Sized> Clone for CoherentView<'_, T> {
+    #[inline]
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+
+impl<'a, T> CoherentView<'a, T> {
+    /// Erase the DMA handle information and obtain a [`SysMem`] view of the same memory region.
+    #[inline]
+    pub fn as_sys_mem(self) -> SysMem<'a, T> {
+        self.cpu_addr
+    }
+
+    /// Returns a DMA handle which may be given to the device as the DMA address base of the region.
+    #[inline]
+    pub fn dma_handle(self) -> DmaAddress {
+        self.dma_handle
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
+        // SAFETY: pointer is aligned and valid per type invariant. Aliasing rule is satisfied per
+        // safety requirement.
+        unsafe { &*self.cpu_addr.as_ptr() }
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
+        // SAFETY: pointer is aligned and valid per type invariant. Aliasing rule is satisfied per
+        // safety requirement.
+        unsafe { &mut *self.cpu_addr.as_ptr() }
+    }
+}
+
+/// `IoBackend` implementation for `Coherent`.
+pub struct CoherentBackend;
+
+impl IoBackend for CoherentBackend {
+    type View<'a, T: ?Sized + KnownSize> = CoherentView<'a, T>;
+
+    #[inline]
+    fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> *mut T {
+        SysMemBackend::as_ptr(view.cpu_addr)
+    }
+
+    #[inline]
+    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
+        view: Self::View<'a, T>,
+        ptr: *mut U,
+    ) -> Self::View<'a, U> {
+        let offset = ptr.addr() - view.cpu_addr.as_ptr().addr();
+        // CAST: The offset DMA address can never overflow.
+        let dma_handle = view.dma_handle + offset as DmaAddress;
+        CoherentView {
+            dma_handle,
+            // SAFETY: Per safety requirement.
+            cpu_addr: unsafe { SysMemBackend::project_view(view.cpu_addr, ptr) },
+        }
+    }
+}
+
+impl<T> IoCapable<T> for CoherentBackend
+where
+    SysMemBackend: IoCapable<T>,
+{
+    #[inline]
+    fn io_read<'a>(view: Self::View<'a, T>) -> T {
+        SysMemBackend::io_read(view.cpu_addr)
+    }
+
+    #[inline]
+    fn io_write<'a>(view: Self::View<'a, T>, value: T) {
+        SysMemBackend::io_write(view.cpu_addr, value)
+    }
+}
+
+impl<'a, T: ?Sized + KnownSize> IoBase<'a> for CoherentView<'a, T> {
+    type Backend = CoherentBackend;
+    type Target = T;
+
+    #[inline]
+    fn as_view(self) -> CoherentView<'a, Self::Target> {
+        self
+    }
+}
+
+impl<'a, T: ?Sized + KnownSize> IoBase<'a> for &'a Coherent<T> {
+    type Backend = CoherentBackend;
+    type Target = T;
+
+    #[inline]
+    fn as_view(self) -> CoherentView<'a, Self::Target> {
+        CoherentView {
+            // SAFETY: `cpu_addr` is valid and aligned kernel accessible memory.
+            cpu_addr: unsafe { SysMem::new(self.cpu_addr.as_ptr()) },
+            dma_handle: self.dma_handle,
+        }
+    }
+}
+
 /// Reads a field of an item from an allocated region of structs.
 ///
 /// The syntax is of the form `kernel::dma_read!(dma, proj)` where `dma` is an expression evaluating

-- 
2.54.0

