Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022139.outbound.protection.outlook.com [52.101.101.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA534562A2;
	Wed, 19 Aug 2026 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787137842; cv=fail; b=DM4VatMsOeYyz45BOkl63/qk8QSOYHyU4nONuvGY/z/jZrwMUkHxua+pVn44TswMg/qcsGpwC+F/sPBGtgn70kbnw2kVTfCIhtkL8FeBYsYgaqmuMOtOsuaHWOgH4J3FMEMjTfK0L17OzxbGu/1spJaIKeqiW0YsQfeN0NJ9JFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787137842; c=relaxed/simple;
	bh=XZXD/efaS++QVM6lm/YgbjK0rEbg9/iNkZsP4HPrYQY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SqjyMttwR+5PZu/Vh+B8r40mzQNIDeLA5W02wO+Let07fMAhQAfFNA/iHvtONSJHEcgSCuB2ZgGCInLZXW5NHB2Ezw0FK+nqO5lrFbqztEHTPrNqMnsUwM4eJuQbMPdSrSh6N+9NRFtATPTq3qOWIQCi/eaxgDDih5/CRBmEgYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=0SQQ+eQV; arc=fail smtp.client-ip=52.101.101.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="0SQQ+eQV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXmXHF3fA3pOBhKQXT4mcv/xohJlPnCcEd0DfDq1voA57RcrdGFha+2wTaM6Sijizj9JKB7t8tKUNBH8CU19OonNeGDD+F6bp0Ybgf+NY8fQymU+cMjoqNT7OxtVvIdJQNzQFBy+lhkqG4tN6g02cIMYrLxWWzhjk5k05QglYvZgf4dBoXPu2sYUI6VIsLRhJ0lCvRrFFKHD5PgI/kVXCwdFb2JcwOz1PV8STYJsAxuyun4XKludChuOjAb13hXDgvl0j/M9s3MESCFraLB/CR0wtMjlNdrmDzFjvm7jxou+okjF5uanABeGRlwuaQ8dvxQy75kNtTKg6LyAUW2NDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoGBtLeyYpMRN8b0+FC2+3BnjwjhBmSrKnHZb9pNeIs=;
 b=PmVuYSOJ3/tOb/DzhCrjSQh4cBaEN3VTfX6kHSC1AiVHY0zyglV93h80B4Nb+ERsVAvRSHyAHX36SP/nuHOZ0IYBLm7uhNVHejHBewGMp1LgCxkbyiMZdT6v9MjZRbowrJRJi5rz6EClUSIgEXO0SbLk9bwZJLKhwonTyoBjxe27Ti0w426geqhLqqDDzzRmxKNTJ+nrLRNphWsCElXPQwm9odD06qnzvLrEBO0obMl6zLZEwkI1bSeAKYtFvTWsa2OZ6Vcy/3kXNa7gOBp4w4KNK7bJfHJnzEIH6LeY+AvcTv9NMj6pD5JgRwq71yD2aYiCWRjL5e/SMjSRZfckZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoGBtLeyYpMRN8b0+FC2+3BnjwjhBmSrKnHZb9pNeIs=;
 b=0SQQ+eQVYWaEzkQ968/be86yo6Jq4OLQoG7wnDjwaIkKy06PzKPgv0kj0laILNQQM1vmwOhdCW1z7IC+FiTABd1T9JVxhSHs4SKfrokMkMs+VF+jZf4jrn1M2I6OcQonT9sgMr9UWIGuzi3LR3Kjm3fpWTw6wnK0Lxqa3bMYH5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB5113.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:15d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 11:10:22 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 11:10:22 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 19 Aug 2026 12:09:19 +0100
Subject: [PATCH v3 11/16] rust: io: register: support fixed offset register
 without bitfield
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-typed_register-v3-11-3699a75fadf1@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787137814; l=7936;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=XZXD/efaS++QVM6lm/YgbjK0rEbg9/iNkZsP4HPrYQY=;
 b=ur0fPdU8p3BnmNPXsndl5MO9oGBW0Gena+AAZAI/J1q6UGj6Eh7+X7L7ff3RkUAKvgU59F237
 RD4fBpsGZblBXflBm8HrW8bm+Vku1x0S6ks/ogFvSQUfv5kD8S7Jp7q
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
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB5113:EE_
X-MS-Office365-Filtering-Correlation-Id: 41e5692c-237d-4110-17bf-08defde2763b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|7416014|23010399003|921020|3023799007|56012099006|10067099003|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uFarUEpxD//1x7tvvGkm+9otvhS09UUPPpQjNw6NbAZ6ijuwGifIpLPUVUz8dNG1oXqInu4dTO9ReLAmCxIqsFX3DqqzYHkl+pbsrkDQlydYZJY0XsUVxfiFNpN3+vUL/JJm7zCm5FHOjfyQqsI/7uuEofMDzhEq8gpKbYgBweK6/iiJ0g/cfkZ9U5fsbQZJGtYztLegELAIbfozM0fdVNQbDtISLwi7UaOm6gdiV+T+B8mPfKBYNnwKHqjnjNSLfGHM3PK4qt6h8/Bdx8A4OFwmrKyEnCrmxGl8VJUgzMW/CieM+2WxcxDuFkclOaSvTkdf+aMFe+DUDYH5hvXJ2guqL+RxQMCXlY1sYtTkW6QTHt3fkHQNNpq2eOrXjcOzQKBM1RS4IQMFv0JtY5yr5lu4mJUj3xOptO+0xthec6lkpJx/xjtbxV5arMSBcdcTxi3d5s5I9uykX8r6w0TA6fM9709Z7YUHedvdZBFbybkLQ7iPt9GwOi5ffIaKJUhGMyFpBCSxDpT7NI9yX6fKbIp55Hd/1CB5gfD1jfHuNQgXjJd3rvjOnbRS4hj47y22gTuddD65efmY4ylT/qiUyjIlwdjdtju6kDQ8b5U2bN+YcjjxC1WGS1+xJ4aNxkB1IuWzHk/JeSoSbALDHEV3HoYtknEZ7AY1Tl0im2CDF7S68VoYSKHl9G0iBmVyE029NxJK6wvMagETqu9wS6Sfxg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(7416014)(23010399003)(921020)(3023799007)(56012099006)(10067099003)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVBiN1VMR3lTOEJ5Ry9GUUxIc2dkWW1VckxyRkQ0eTZ3NHk1UUlZcitMbjRW?=
 =?utf-8?B?WU9UVmxqbzRwUnlXOE5ITUw3MWFiblVSY3F4T1cwcDJtOUxHc3dPY2g2dlZ3?=
 =?utf-8?B?Ti9NQnozZGdlWXNrejJzbXA3SGJabmxwWGJLK01laEEzNVhsNnZrdVZHMjlv?=
 =?utf-8?B?YUxGdjMwUmY0WlkvMHhrbGZKVmhyTXFFeHZnOHpQdjFseFdvMEtqWTFJazRE?=
 =?utf-8?B?V0Vnd0FsWE5xZEdZVkY5K0dNTFBFbDc4WTFIdmlJZHBjM01meU44VGU1Tyto?=
 =?utf-8?B?L3ZJWjkxc002UW5uS2Vkd0dvOWdsK08yYU9rZ2t0VVlrNnhrL1VBK2EraDlp?=
 =?utf-8?B?alpvQkREYkk2ZUk5SnZ4cVltZSswc0VJbXArdGpWSG5nYm9TOE1WdVA5R0c0?=
 =?utf-8?B?TmorOVpCVWZOQjFsRU12cXBtQ2R1L1l3TG5ZQ3ppVStjUmNVZlJzbzdITWQ1?=
 =?utf-8?B?ZFB3QVFLblU0WTAzdG1lSU4ranJtMlVtRnVUdThpOVZJdjBEa2p0N0tGZnZt?=
 =?utf-8?B?MTZESDNtMEVGb09sNExlT1NKb1NyTXZHN0ZmTnNEMmphTU1MQ3BuRUVlUFkv?=
 =?utf-8?B?VngyQVRtQ1VPSENLZ3lxQlVKOGRpUzBmcUJ5cDFEZ3BDRktiRHJLblVxcWtt?=
 =?utf-8?B?QTJBNG1vdXlmUHBBZXBESk02WWxXd29vQ1BHaWpXc2xmVm9VVUdmN3Ryd093?=
 =?utf-8?B?ZW4vbG5WR0lWK1pPZEFmRVNFQW9uK3VpRnlnTlc4ZkluWDdmMnZkZGRZSFZL?=
 =?utf-8?B?aHpFQ3MxNGdITDlwWUdpOUwwdm9zVGpOM2RjNmYxSmc1ejlPUWdYWk1rRmNs?=
 =?utf-8?B?UEFqNVpwN1h5WVhtb0ZjN1lFNFY3NHgzZ0xXWUhGMU1NR0JUaWtGeXZzVUFJ?=
 =?utf-8?B?bW5KTlRIakR3YWU0K0JkQVhtTHRJakduS3JUK1ozMTJTTCtDNHZGTi9mR1p3?=
 =?utf-8?B?TWJVckxNZVJnV3VZZk1VMnRDaXNaNXJwRzVIbGRXdEcySlk1VEVEakFxczcx?=
 =?utf-8?B?VWJPbHlnSm10djNvNVNXMldNRDJPaHNpRmJ3c0lhU0NIejN1KzNUSjc4VnF3?=
 =?utf-8?B?cDkrVFA0R3lSb2ZvQkxxZmZHL1NGS2o0a2RZOEFKUXBMbjk3RWRoTWYydjkv?=
 =?utf-8?B?bWczN1U2TVVsM25VTG9wVUlXYkdsZVVKOTBYZ21FQmNWemUzYzg4MithQXY0?=
 =?utf-8?B?YVFyQTdlUHdDdHk1NVNMV1dCTGh4SGVnUkhSTE9xMUVLL2g1THBkR0dKRUJQ?=
 =?utf-8?B?bWdKV2JRZUF3QUVLZFlWWWN0UitqYzk2SElYQ0Q4cEhXcUdTV1dONDQzd3R4?=
 =?utf-8?B?bEZybWtDRjF3R1NVQURLdTk5ajFWUHZwWjF3VXB1SGUvYnR2WUhZWFMrL1l6?=
 =?utf-8?B?UVZCdm9uY21paUJTY0JqOFpuR3hZL254K3g2ME8rbmFrUmp1UURuMW9Qd0tw?=
 =?utf-8?B?N1FybHBtbjh1OXJQMG4yUituMW9pWmRYWkh2S29oejJQOUlPZyswUFU0aU5H?=
 =?utf-8?B?MklCWlZHYW9JQ2NCNUh3bEF2OGJBR3RZU2w3bDdSK1lqRHZMMUFqd1hac29i?=
 =?utf-8?B?c25YdGcwR2VVSllzeTFlWk1XcldtM0paVDY3ZVBTc3NLbHBoSGE2Kzd3SUwy?=
 =?utf-8?B?QkgwbXhZZTJoclBuQUZCSis3Y3FoSW85anRXN0dUZDl3b1QyeVQ3MkQ5WkhS?=
 =?utf-8?B?cWcyUnJ6VkFwSHFWQjBMbXN5am1SL25NTVZ1cGJINU1IK2FGT3p0WEZoTWY4?=
 =?utf-8?B?UjNaRG9Gb2ovSFRFUXlTSUhtU3pDdmJaK2R4K0czZ0dmMUNZOXZCTDBXQng1?=
 =?utf-8?B?bHU5SmZ5VDRaaU1RTUpHWmdmRjZ2Zy83R3NKTTVCSjYyR2QxOG5iSzN5dTJP?=
 =?utf-8?B?QWdFTk91dnJIMkR0VEJYWWx1WGVncXhpekJWampjeU1XaUdVblE0bis4eXdR?=
 =?utf-8?B?VmI3d3lna2s4YVFualczWkRUM3k3SGhKeUpMZ284dm5OUyszSzBEeUpLVTd3?=
 =?utf-8?B?WVdmTW00VlZSRjFHNFRNTTdFci9qWEhvbEpjclB0aHVqQ092VHk5bHBiRWtO?=
 =?utf-8?B?dnZiTDFVeWFseHZTdmE0Z2hxOEZzTEZURkI3cmFHaVpYeWlua2VhazB5NWxN?=
 =?utf-8?B?bEI2UVV2ZVV6YWN5bTEzL08xS0RGMlF6d0R5TWpnS2FXbzZFTGlzUEhyL0Fl?=
 =?utf-8?B?QnBFaDlubkFKc0h3SlZ1TSsyYWhXZ3hBMGNHMEZXMFpkTmFuZ21vYU5vS0hP?=
 =?utf-8?B?d3NHU2ZMVHNxa3YvRStlZXFCNlpQUGlEWXdzWHQ0eHNxT3dqQ0dHOGRuNGxn?=
 =?utf-8?B?S1pIZE9hODhBR09kU2NKcGpMYm9YL3FvcTVsR0Jkb1ZTOGJPVmRvZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e5692c-237d-4110-17bf-08defde2763b
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 11:10:22.1941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m36TOpOdljU0rs8epwg/D3aCivo7x9OBp/HJ57rSA9Tc+hvktcBMPXe0z0oXnWfVUWPIQx4iQ/PshWWH34atqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5113

Add a rule to allow creating `IoLoc` in `register!()` using an existing
type and not create a bitfield. Add an example to demonstrate this for FIFO
registers.

This rule is also going to be used to create subregions for registers; the
example of doing so will be added later when relative registers are
removed.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io/register.rs | 30 ++++++++++++++++
 rust/macros/io/register.rs | 86 +++++++++++++++++++++++++++++++---------------
 2 files changed, 89 insertions(+), 27 deletions(-)

diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index f622057f7346..63c054162e54 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -182,6 +182,23 @@ fn offset(self) -> usize {
     }
 }
 
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
@@ -521,6 +538,19 @@ pub const fn element_alias_offset<Base: ?Sized, Alias: RegisterArray<Base = Base
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
index cb02e850b23f..0b4e0d1903dd 100644
--- a/rust/macros/io/register.rs
+++ b/rust/macros/io/register.rs
@@ -14,9 +14,11 @@
     bracketed,
     parenthesized,
     parse::Parse,
+    parse_quote,
     spanned::Spanned,
     token,
     Attribute,
+    Error,
     Expr,
     Ident,
     Path,
@@ -49,11 +51,11 @@ struct Reg {
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
@@ -61,11 +63,23 @@ fn parse(input: syn::parse::ParseStream<'_>) -> Result<Self> {
         let attrs = input.call(Attribute::parse_outer)?;
         let vis = input.parse()?;
         let name = input.parse()?;
-        let storage = {
+
+        let lh = input.lookahead1();
+        let mut bitfield_storage = None;
+        let ty = if lh.peek(Token![:]) {
+            let _: Token![:] = input.parse()?;
+            input.parse()?
+        } else if lh.peek(token::Paren) {
             let content;
             parenthesized!(content in input);
-            content.parse()?
+            bitfield_storage = Some(content.parse()?);
+
+            // For bitfields, bitfield macro will generate a type with the same name as `name`.
+            parse_quote!(#name)
+        } else {
+            Err(lh.error())?
         };
+
         let array = if input.peek(token::Bracket) {
             let content;
             bracketed!(content in input);
@@ -119,22 +133,28 @@ fn parse(input: syn::parse::ParseStream<'_>) -> Result<Self> {
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
@@ -174,11 +194,11 @@ pub(crate) fn register(def: RegDef) -> Result<TokenStream> {
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
@@ -199,21 +219,33 @@ pub(crate) fn register(def: RegDef) -> Result<TokenStream> {
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
@@ -235,12 +267,12 @@ impl ::kernel::io::register::RelativeRegister for #name {}
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

