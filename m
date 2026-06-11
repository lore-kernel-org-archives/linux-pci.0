Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022092.outbound.protection.outlook.com [52.101.96.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40BD43D518;
	Thu, 11 Jun 2026 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195319; cv=fail; b=dqxicXqgARM3TxbR5ELLPZjcLDdkysQp3Vo/ThrGz6IqJ7OEGQMrfKDsEqyqmyAbFb3xtV1RKPKfh0BKwUc1Wv1iWWaY85ut/BKGaidPfBFL6wUq4dC4EMpqfcoQdE4pycRaZdRleJAV04yH5qyAf9sznn15ffyuKK5IM6IJEmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195319; c=relaxed/simple;
	bh=zAUmlpx7qRmpak2aPShtkQ1ta2dTWYwEkvis5uE7440=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=S9Z0CAbptBPaO3XYwc9GZxKq5zS2G/BwIm/gAYKe1RmwuPBABOW1UV1CN/duGa/+DYID/UpXNiVUXNz58u+EuU2iv/TfDZ7yH9CdKRbRAPiAWoK7bqfh2ApjAKGr3qyoYTE2aAP37h+znfHZrDWxR4AuGC+70RfyiSIu2vDEOII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=0iqTK8y3; arc=fail smtp.client-ip=52.101.96.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="0iqTK8y3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rl1FTEe0HOeBzXIMp8qfgDAfy8b3tIz0YzQchSHa2I9I43xEtE/yXrJNhBYI4NaHtYZzslms5vj8wFuEQU8MXkrzPyCKqzuzIC3yMY08vUtcdMtc0wHdh7Xll7lph6oUjyP0pvkeNS69ebYaPEAX4Mf2TdmhCm0F5DKVUPKDlVqfLRjPdRA+5bcrj/qi1HpEwu+6fleF1F7rdIY0xIIR2lRfy01U8tZZWw6VONClARpLhviVfUAExCXZl8+XknM36sNX9DV5n6ol6+eNKQoi7N+07dyXOvX+h6j7INjYcNJpwM3rUZjyvaZVyEmb2Ecok5YqL1g6P8ERh+BxBneE9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pgr7srKWqQ5y9Ad7bmawsaDw59mKVPoPKoj87/Fi+4E=;
 b=wAtPQU9RYu09rVVwPArvh9Z+ErCWLKm/xKVSew1AbzQiki+JkyqVGj7JqheEhplQJx1MGnYq9Lo35f9Zx31hRYsAt5Fd7RupDxb2nqg9RUSYSS5DQJ/KEP0S8tSx4bbU1MT9ANz+paXVhD1QFa4FsZZQEaNeNzjjXDcQu3w69XHf9KKX3qedhsUaaBvlhHfzOXTEVkSmc2RsqnEQaBuoH6t3VY1VHPWY8kBhs3rKOX/UYF9At/HpDPM8bT7tKW61/e+kKk0F5lA4lH0YhRUTGV022D8sqde4BFZzKk0LncMZwEnAtspNOT5tOpEDJu0hMoUAaSU63Uf4wBbH/4J1MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pgr7srKWqQ5y9Ad7bmawsaDw59mKVPoPKoj87/Fi+4E=;
 b=0iqTK8y3Bnep6JDL13XaFL/1NCOS0w8iTtKiInMJlkzQVHGC310qCODKq8yJgmXhb1SpirHN1Db4ClWglLg2Gu7hhAiJeKLRECdctMnT9GfscsJMVQHGp+SFwKxmxS+tcERYs5l7bU5ntCgYHg1bKR2AGGqKYtsp0fEfpzt3DYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO2P265MB3263.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:156::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 16:28:25 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 16:28:25 +0000
From: Gary Guo <gary@garyguo.net>
Date: Thu, 11 Jun 2026 17:28:06 +0100
Subject: [PATCH v4 04/20] rust: io: implement `Io` on reference types
 instead
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-io_projection-v4-4-1f7224b02dcb@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781195301; l=16076;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=zAUmlpx7qRmpak2aPShtkQ1ta2dTWYwEkvis5uE7440=;
 b=+MsbIQhEGGJURZCK0Jdt0IdZEkCam4LJw+6+gxZeEHa5GEZm9I2OV4qtae3ko3I4Q/sw+OoMO
 RfLW9564I9YCxffBesGd2Z1SgSJqzzky4lE7wjDIOqa2A3Fl64Af1U1
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
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|LO2P265MB3263:EE_
X-MS-Office365-Filtering-Correlation-Id: 825ffc85-bbda-4c94-a41e-08dec7d675f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016|23010399003|18002099003|22082099003|921020|5023799004|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	T37cbllAk+3ZfVwhUS9lx4eI5L2wM1cjx1E/lzogHSV5IYdJG1GTLBWbr+iawZuDrmdcrJ+umdg0C7f1Z22qYIsS3JrprLOuPkIsaujMWtSyp8ETBPjjnGt6p1O8RDQa342jnzndaGPvAJw2OZVbua/J+DlIu6ZYECEh5hsxCfCfHM+kKJOqIqii2lmXN4LsuJO/DgbBABAeqp2MSpUTMRSO1tcMVZYF4PURnwldUqzS4bj45tlSiRF5wC67QFF9RXYuJk5Wz0QOVcLxCw+toHjW9tHC/sLq+NH8z+r82ACrW4kKnnqpI2lp7j/UuG7nhEYZ1t4Uk0ieGyUGxtGEk4NHtZOxy6IPFax/i95CGPTHxkdiPOd6Rcvx9Pma4HpKoXAGCwb6IAMMWi2NGdMj3yI7ao5/yHVhksEULvbex9pGdUBPiV7SGReNDdiGZoQUbULH1nyLcvYyXXhb9v2pzRZnIYH8O1OGW+8g3WlaGyHGNEkH6TY7iu56JScG8RlL8YkX24QGUy6vXl44rchE/L1Tc7Oi3WAzQee2JN0ym9ydxbKLFlRg+rFbJaytann0BIttYafH2PBuzkoM3jaib5yCAP/M/C3qE9pkt6Hk665CMYeNNJJgdQAJs1VFC18LnzzPXVgl+J8ZPkJ5ppFcWsfVwZqW6k/K7TH8tP6G7ep8x/Apij1jYOsC5ccD5YJBoVJCkjtrS9POHayc5IS1bdqK9DDlSugUNZccO18jNho=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(23010399003)(18002099003)(22082099003)(921020)(5023799004)(6133799003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjdhQXYyTXJjMHRHM3N5ZG9PZ3NSczR5WFN1c2pzdGZkUW0rdEkxYzkyS2Uv?=
 =?utf-8?B?TE1vZGQ1VWxWdVNqa1o4WHZhREowZ2hLR2JtaGxCTWtnVzJ2eWlUV3o3dnRj?=
 =?utf-8?B?ZGJhQi9NdXFMRnVZcmZNSmhOUGRUVzdVQmN6NnA3UHVsanp2RXprSVhaSVY5?=
 =?utf-8?B?MFR5MGtJTGtLL0pzUzFjelhnUDdEUktXbnphalAzSXl6YzArNTlIZE9jRUdI?=
 =?utf-8?B?TlBxQ04ydW9Ka0prUS9ycEduQWVqMkdEOUJRNGFRYXUvL1drQmFnTVhwQVRG?=
 =?utf-8?B?WWxzdmo2WTc4bWxlUGMzQklpVHhyS2xSQzVyQ0thUkRieGJ3WDhSUDhKMG0r?=
 =?utf-8?B?bjBOajRwTy9Pc05LTSt3dDZhUzcrNWhvZ0t6TE1Xc2lWdkxyN2xnV0ZPbkJ2?=
 =?utf-8?B?Rm9iVUN1VFN4QWVhZ3Q4MCtBcEs0YjkxNFNlSU5NRHh3SG04cFp6VkIrNExO?=
 =?utf-8?B?ZFN0UGZ1VXFiUDlzeS9LTFZjc1NDY05OREEydXd0NFc2Q2NhOTJOSGE5MzZQ?=
 =?utf-8?B?dWNtMW4yOHdUL3FVZWlHM0VIcWhObVFsanFoT0FmYndFLzhzbUhLTTRrNFFY?=
 =?utf-8?B?UE44NkVjK0YyWVRzZHVzWGY3eEFPeWZVOVlGc0c1d2tlakVIa3hwUWJOQnZ5?=
 =?utf-8?B?NFBURzR3M01ITDRQVGRydUFoeW1VSVJES1Zxc25jZXRTWXlxQzdOem1KQkNX?=
 =?utf-8?B?UlF2Sk04c2xvWUlobjUrTVg4WUNNT3BVQXA0M1NkLzQrNjNkTmFBc1pGN1Ba?=
 =?utf-8?B?d1VBV1BxK28zN0JFbG85Szh0dXBpTmNhZHFJdE9BNTYyQ0xGUlpIWWkyQ21v?=
 =?utf-8?B?VjhEZWRwMjRVMWh3a1dCRDRQM1JWekxWV2JMMGtGNjZiYld1aTI1MSsyN2RN?=
 =?utf-8?B?TFJIWVIxNlkyd0xLWTNWMmRKb3pJVENyTnpLaGdFOVhtMXErWFM0b0ZnTzJ4?=
 =?utf-8?B?Zmh1cnVxb2gwNE1VZE1SZGxieGJ6b1o2Tk1CTFVjdTFud1FGNGJhWkpIQStQ?=
 =?utf-8?B?TDF2RFpDdzl5RTRTNHVRdS9yTnJtTHZNZ01PbHloaHpGUGJ5NC9RYlFwTGow?=
 =?utf-8?B?RU5XYVVLL3RONitGYTVybjJKUnJPNUJXYnd5M25BK09Nc21FWGY1R1RKcHRX?=
 =?utf-8?B?NkZUSXFsbkl0NG9MWlg1VjVodkpYRXNveHJ2M0VUL0FLaWh5UW5mS0VtZ3hS?=
 =?utf-8?B?ckdYcmRSSWNxSS85UWZBMWpVNnhwREptOU5qOUdlZHBnZGN1aUhMYzdoVDNK?=
 =?utf-8?B?cUtsZ1h4aTJVTmIrak0wNVJjMFl5cUM0M2swZ3hKdWFWZGVCNElRRkNUUUlR?=
 =?utf-8?B?czUvWTZYVVEzYXFSZkZMbGhoR3VUT0taQ3dkVmNtSTdRNU1sbi9YTzRGaDA2?=
 =?utf-8?B?M0dJWU9nbTVQSGNFZnIrR3ovMHI2UWU2cFFBM1VFRWZ3dkNIR2pTOE1TcE9N?=
 =?utf-8?B?MGpOWFNGYTJMMWxXM3FXUzFsbzZvbFVZeFNNWTg1WFBDcXlKcG9weXZrTHpU?=
 =?utf-8?B?S2NIdXBISXZEaGlpeDJRMEIzUXZMaW1ZZmpkNng0L3dpV0FqV1phMDhUeTkr?=
 =?utf-8?B?OVJVN1B0azZ2ckhTelhqbTkvQ2V4Vi9hRmcyWW9jU09KcFl3MFZHdmw2VDFr?=
 =?utf-8?B?US9UdGlNek93WlNHYXJQcE1UK25DR21YamhCOHgwcjZpS2UxV0xrK2s1d0s0?=
 =?utf-8?B?ZTdPS2pUWHR3d1RPditRdDR6RVRidmZBK2JBM21tTThVVkQ0ek9JcjFDa29v?=
 =?utf-8?B?dWVLNEJOR2FrTC95YzVBUjVJNzVia3dVTm5acHJmZklWYnA5dnVVdTVGQmFE?=
 =?utf-8?B?SGZDS253dmFmVlhaOEE4S2Z6ZmMzL1QzdzdpK0FiSDl5Wk96ZGhhc0hyQ0N3?=
 =?utf-8?B?azI0YjJDTXU4N2M5M2s5ejJWSGxPenRDZDluQ3BTeStnMVB6b00rL3hwU25G?=
 =?utf-8?B?dXhEQTJRdXEyWlpRa3NHWUJjQzNvQzh4ZzExRU51cUNDdXlTbUhkRGs2MkJZ?=
 =?utf-8?B?U20vY1FoTXJZc1VwVjdITjcxZHBVSU5jclZDYnJ0K3dRUTFZT1dvNUZhbDFK?=
 =?utf-8?B?Z2hicjllY3AvZTY0d2U1OXBBcjU3V0hSZndwZTg4MDlDU0FzYWc3WWdrejBI?=
 =?utf-8?B?by96NmZZR2hDUVVTUUhsaWlMM1gxVGR6c05zeWJIZFEvTHNXVlpyelNSMG93?=
 =?utf-8?B?OTZqcjNpRjBSNWJKS2lqU0pCamVVUks0REFWOGRKYmRkbTl2Y25BWlB0OThw?=
 =?utf-8?B?cHJvVmFjQmk0N1Jpb2NRU2NEOFBuSk9LWWlvRURrTHZqVXlVRXJtTmp4OUxm?=
 =?utf-8?B?Y3BMVm5LVGJlUlArSWtGekhLQ1RrYW45ek9OY1Q2YnIweXVKVzNaUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 825ffc85-bbda-4c94-a41e-08dec7d675f5
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:28:25.0241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chrt3XK1AfK20BKXvgk1KHGhXjgzdWLzDpEKiCsmgthejY1M8V8gToNuU2REKjC2ebmFwQHesrck7807ZiP8MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3263

Currently, `Io` is implemented on owned I/O objects (e.g. `Bar`). This is
going to change with I/O projections, as then `Io` need to work both for
owned objects and views of them. Views are themselves reference-like
(however they obviously cannot be references, because they belong to a
different address space).

To faciliate the change, change `Io` to be implemented on reference types
for the owned I/O objects, and make methods take `self` instead of `&self`.
When I/O views are implemented, we can then naturally implement `Io` for
these objects.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs     | 80 +++++++++++++++++++++++++--------------------------
 rust/kernel/pci/io.rs | 12 ++++----
 2 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 38281636b4da..3b478dcf10f9 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -224,7 +224,7 @@ pub trait IoCapable<T> {
     ///
     /// - The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
     /// - `address` must be aligned.
-    unsafe fn io_read(&self, address: usize) -> T;
+    unsafe fn io_read(self, address: usize) -> T;
 
     /// Performs an I/O write of `value` at `address`.
     ///
@@ -232,7 +232,7 @@ pub trait IoCapable<T> {
     ///
     /// - The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
     /// - `address` must be aligned.
-    unsafe fn io_write(&self, value: T, address: usize);
+    unsafe fn io_write(self, value: T, address: usize);
 }
 
 /// Describes a given I/O location: its offset, width, and type to convert the raw value from and
@@ -299,21 +299,21 @@ fn offset(self) -> usize {
 ///
 /// For MMIO regions, all widths (u8, u16, u32, and u64 on 64-bit systems) are typically
 /// supported. For PCI configuration space, u8, u16, and u32 are supported but u64 is not.
-pub trait Io {
+pub trait Io: Copy {
     /// Type of this I/O region. For untyped regions, [`Region`] can be used.
     type Target: ?Sized + KnownSize;
 
     /// Returns the base address of this mapping.
-    fn addr(&self) -> usize;
+    fn addr(self) -> usize;
 
     /// Returns the maximum size of this mapping.
-    fn maxsize(&self) -> usize;
+    fn maxsize(self) -> usize;
 
     /// Returns the absolute I/O address for a given `offset`,
     /// performing compile-time bound checks.
     // Always inline to optimize out error path of `build_assert`.
     #[inline(always)]
-    fn io_addr_assert<U>(&self, offset: usize) -> usize {
+    fn io_addr_assert<U>(self, offset: usize) -> usize {
         // We cannot check alignment with `offset_valid` using `self.addr()`. So set 0 for it and
         // ensure alignment by checking that the alignment of `U` is smaller or equal to the
         // alignment of `Self::Target`.
@@ -326,7 +326,7 @@ fn io_addr_assert<U>(&self, offset: usize) -> usize {
     /// Returns the absolute I/O address for a given `offset`,
     /// performing runtime bound checks.
     #[inline]
-    fn io_addr<U>(&self, offset: usize) -> Result<usize> {
+    fn io_addr<U>(self, offset: usize) -> Result<usize> {
         if !offset_valid::<U>(self.addr(), offset, self.maxsize()) {
             return Err(EINVAL);
         }
@@ -338,7 +338,7 @@ fn io_addr<U>(&self, offset: usize) -> Result<usize> {
 
     /// Fallible 8-bit read with runtime bounds check.
     #[inline(always)]
-    fn try_read8(&self, offset: usize) -> Result<u8>
+    fn try_read8(self, offset: usize) -> Result<u8>
     where
         usize: IoLoc<Self::Target, u8, IoType = u8>,
         Self: IoCapable<u8>,
@@ -348,7 +348,7 @@ fn try_read8(&self, offset: usize) -> Result<u8>
 
     /// Fallible 16-bit read with runtime bounds check.
     #[inline(always)]
-    fn try_read16(&self, offset: usize) -> Result<u16>
+    fn try_read16(self, offset: usize) -> Result<u16>
     where
         usize: IoLoc<Self::Target, u16, IoType = u16>,
         Self: IoCapable<u16>,
@@ -358,7 +358,7 @@ fn try_read16(&self, offset: usize) -> Result<u16>
 
     /// Fallible 32-bit read with runtime bounds check.
     #[inline(always)]
-    fn try_read32(&self, offset: usize) -> Result<u32>
+    fn try_read32(self, offset: usize) -> Result<u32>
     where
         usize: IoLoc<Self::Target, u32, IoType = u32>,
         Self: IoCapable<u32>,
@@ -368,7 +368,7 @@ fn try_read32(&self, offset: usize) -> Result<u32>
 
     /// Fallible 64-bit read with runtime bounds check.
     #[inline(always)]
-    fn try_read64(&self, offset: usize) -> Result<u64>
+    fn try_read64(self, offset: usize) -> Result<u64>
     where
         usize: IoLoc<Self::Target, u64, IoType = u64>,
         Self: IoCapable<u64>,
@@ -378,7 +378,7 @@ fn try_read64(&self, offset: usize) -> Result<u64>
 
     /// Fallible 8-bit write with runtime bounds check.
     #[inline(always)]
-    fn try_write8(&self, value: u8, offset: usize) -> Result
+    fn try_write8(self, value: u8, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u8, IoType = u8>,
         Self: IoCapable<u8>,
@@ -388,7 +388,7 @@ fn try_write8(&self, value: u8, offset: usize) -> Result
 
     /// Fallible 16-bit write with runtime bounds check.
     #[inline(always)]
-    fn try_write16(&self, value: u16, offset: usize) -> Result
+    fn try_write16(self, value: u16, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u16, IoType = u16>,
         Self: IoCapable<u16>,
@@ -398,7 +398,7 @@ fn try_write16(&self, value: u16, offset: usize) -> Result
 
     /// Fallible 32-bit write with runtime bounds check.
     #[inline(always)]
-    fn try_write32(&self, value: u32, offset: usize) -> Result
+    fn try_write32(self, value: u32, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u32, IoType = u32>,
         Self: IoCapable<u32>,
@@ -408,7 +408,7 @@ fn try_write32(&self, value: u32, offset: usize) -> Result
 
     /// Fallible 64-bit write with runtime bounds check.
     #[inline(always)]
-    fn try_write64(&self, value: u64, offset: usize) -> Result
+    fn try_write64(self, value: u64, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u64, IoType = u64>,
         Self: IoCapable<u64>,
@@ -418,7 +418,7 @@ fn try_write64(&self, value: u64, offset: usize) -> Result
 
     /// Infallible 8-bit read with compile-time bounds check.
     #[inline(always)]
-    fn read8(&self, offset: usize) -> u8
+    fn read8(self, offset: usize) -> u8
     where
         usize: IoLoc<Self::Target, u8, IoType = u8>,
         Self: IoCapable<u8>,
@@ -428,7 +428,7 @@ fn read8(&self, offset: usize) -> u8
 
     /// Infallible 16-bit read with compile-time bounds check.
     #[inline(always)]
-    fn read16(&self, offset: usize) -> u16
+    fn read16(self, offset: usize) -> u16
     where
         usize: IoLoc<Self::Target, u16, IoType = u16>,
         Self: IoCapable<u16>,
@@ -438,7 +438,7 @@ fn read16(&self, offset: usize) -> u16
 
     /// Infallible 32-bit read with compile-time bounds check.
     #[inline(always)]
-    fn read32(&self, offset: usize) -> u32
+    fn read32(self, offset: usize) -> u32
     where
         usize: IoLoc<Self::Target, u32, IoType = u32>,
         Self: IoCapable<u32>,
@@ -448,7 +448,7 @@ fn read32(&self, offset: usize) -> u32
 
     /// Infallible 64-bit read with compile-time bounds check.
     #[inline(always)]
-    fn read64(&self, offset: usize) -> u64
+    fn read64(self, offset: usize) -> u64
     where
         usize: IoLoc<Self::Target, u64, IoType = u64>,
         Self: IoCapable<u64>,
@@ -458,7 +458,7 @@ fn read64(&self, offset: usize) -> u64
 
     /// Infallible 8-bit write with compile-time bounds check.
     #[inline(always)]
-    fn write8(&self, value: u8, offset: usize)
+    fn write8(self, value: u8, offset: usize)
     where
         usize: IoLoc<Self::Target, u8, IoType = u8>,
         Self: IoCapable<u8>,
@@ -468,7 +468,7 @@ fn write8(&self, value: u8, offset: usize)
 
     /// Infallible 16-bit write with compile-time bounds check.
     #[inline(always)]
-    fn write16(&self, value: u16, offset: usize)
+    fn write16(self, value: u16, offset: usize)
     where
         usize: IoLoc<Self::Target, u16, IoType = u16>,
         Self: IoCapable<u16>,
@@ -478,7 +478,7 @@ fn write16(&self, value: u16, offset: usize)
 
     /// Infallible 32-bit write with compile-time bounds check.
     #[inline(always)]
-    fn write32(&self, value: u32, offset: usize)
+    fn write32(self, value: u32, offset: usize)
     where
         usize: IoLoc<Self::Target, u32, IoType = u32>,
         Self: IoCapable<u32>,
@@ -488,7 +488,7 @@ fn write32(&self, value: u32, offset: usize)
 
     /// Infallible 64-bit write with compile-time bounds check.
     #[inline(always)]
-    fn write64(&self, value: u64, offset: usize)
+    fn write64(self, value: u64, offset: usize)
     where
         usize: IoLoc<Self::Target, u64, IoType = u64>,
         Self: IoCapable<u64>,
@@ -519,7 +519,7 @@ fn write64(&self, value: u64, offset: usize)
     /// }
     /// ```
     #[inline(always)]
-    fn try_read<T, L>(&self, location: L) -> Result<T>
+    fn try_read<T, L>(self, location: L) -> Result<T>
     where
         L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
@@ -553,7 +553,7 @@ fn try_read<T, L>(&self, location: L) -> Result<T>
     /// }
     /// ```
     #[inline(always)]
-    fn try_write<T, L>(&self, location: L, value: T) -> Result
+    fn try_write<T, L>(self, location: L, value: T) -> Result
     where
         L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
@@ -599,7 +599,7 @@ fn try_write<T, L>(&self, location: L, value: T) -> Result
     /// }
     /// ```
     #[inline(always)]
-    fn try_write_reg<T, L, V>(&self, value: V) -> Result
+    fn try_write_reg<T, L, V>(self, value: V) -> Result
     where
         L: IoLoc<Self::Target, T>,
         V: LocatedRegister<Self::Target, Location = L, Value = T>,
@@ -632,7 +632,7 @@ fn try_write_reg<T, L, V>(&self, value: V) -> Result
     /// }
     /// ```
     #[inline(always)]
-    fn try_update<T, L, F>(&self, location: L, f: F) -> Result
+    fn try_update<T, L, F>(self, location: L, f: F) -> Result
     where
         L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
@@ -671,7 +671,7 @@ fn try_update<T, L, F>(&self, location: L, f: F) -> Result
     /// }
     /// ```
     #[inline(always)]
-    fn read<T, L>(&self, location: L) -> T
+    fn read<T, L>(self, location: L) -> T
     where
         L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
@@ -703,7 +703,7 @@ fn read<T, L>(&self, location: L) -> T
     /// }
     /// ```
     #[inline(always)]
-    fn write<T, L>(&self, location: L, value: T)
+    fn write<T, L>(self, location: L, value: T)
     where
         L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
@@ -746,7 +746,7 @@ fn write<T, L>(&self, location: L, value: T)
     /// }
     /// ```
     #[inline(always)]
-    fn write_reg<T, L, V>(&self, value: V)
+    fn write_reg<T, L, V>(self, value: V)
     where
         L: IoLoc<Self::Target, T>,
         V: LocatedRegister<Self::Target, Location = L, Value = T>,
@@ -779,7 +779,7 @@ fn write_reg<T, L, V>(&self, value: V)
     /// }
     /// ```
     #[inline(always)]
-    fn update<T, L, F>(&self, location: L, f: F)
+    fn update<T, L, F>(self, location: L, f: F)
     where
         L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
@@ -800,13 +800,13 @@ fn update<T, L, F>(&self, location: L, f: F)
 macro_rules! impl_mmio_io_capable {
     ($mmio:ident, $(#[$attr:meta])* $ty:ty, $read_fn:ident, $write_fn:ident) => {
         $(#[$attr])*
-        impl<const SIZE: usize> IoCapable<$ty> for $mmio<SIZE> {
-            unsafe fn io_read(&self, address: usize) -> $ty {
+        impl<const SIZE: usize> IoCapable<$ty> for &$mmio<SIZE> {
+            unsafe fn io_read(self, address: usize) -> $ty {
                 // SAFETY: By the trait invariant `address` is a valid address for MMIO operations.
                 unsafe { bindings::$read_fn(address as *const c_void) }
             }
 
-            unsafe fn io_write(&self, value: $ty, address: usize) {
+            unsafe fn io_write(self, value: $ty, address: usize) {
                 // SAFETY: By the trait invariant `address` is a valid address for MMIO operations.
                 unsafe { bindings::$write_fn(value, address as *mut c_void) }
             }
@@ -827,18 +827,18 @@ unsafe fn io_write(&self, value: $ty, address: usize) {
     writeq
 );
 
-impl<const SIZE: usize> Io for Mmio<SIZE> {
+impl<'a, const SIZE: usize> Io for &'a Mmio<SIZE> {
     type Target = Region<SIZE>;
 
     /// Returns the base address of this mapping.
     #[inline]
-    fn addr(&self) -> usize {
+    fn addr(self) -> usize {
         self.0.addr()
     }
 
     /// Returns the maximum size of this mapping.
     #[inline]
-    fn maxsize(&self) -> usize {
+    fn maxsize(self) -> usize {
         self.0.maxsize()
     }
 }
@@ -865,16 +865,16 @@ pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
 #[repr(transparent)]
 pub struct RelaxedMmio<const SIZE: usize = 0>(Mmio<SIZE>);
 
-impl<const SIZE: usize> Io for RelaxedMmio<SIZE> {
+impl<'a, const SIZE: usize> Io for &'a RelaxedMmio<SIZE> {
     type Target = Region<SIZE>;
 
     #[inline]
-    fn addr(&self) -> usize {
+    fn addr(self) -> usize {
         self.0.addr()
     }
 
     #[inline]
-    fn maxsize(&self) -> usize {
+    fn maxsize(self) -> usize {
         self.0.maxsize()
     }
 }
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index b4996aa059d8..505305cd9b86 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -79,8 +79,8 @@ pub struct ConfigSpace<'a, S: ?Sized + ConfigSpaceKind = Extended> {
 /// Implements [`IoCapable`] on [`ConfigSpace`] for `$ty` using `$read_fn` and `$write_fn`.
 macro_rules! impl_config_space_io_capable {
     ($ty:ty, $read_fn:ident, $write_fn:ident) => {
-        impl<'a, S: ?Sized + ConfigSpaceKind> IoCapable<$ty> for ConfigSpace<'a, S> {
-            unsafe fn io_read(&self, address: usize) -> $ty {
+        impl<'a, S: ?Sized + ConfigSpaceKind> IoCapable<$ty> for &ConfigSpace<'a, S> {
+            unsafe fn io_read(self, address: usize) -> $ty {
                 let mut val: $ty = 0;
 
                 // Return value from C function is ignored in infallible accessors.
@@ -94,7 +94,7 @@ unsafe fn io_read(&self, address: usize) -> $ty {
                 val
             }
 
-            unsafe fn io_write(&self, value: $ty, address: usize) {
+            unsafe fn io_write(self, value: $ty, address: usize) {
                 // Return value from C function is ignored in infallible accessors.
                 let _ret =
                     // SAFETY: By the type invariant `self.pdev` is a valid address.
@@ -112,18 +112,18 @@ unsafe fn io_write(&self, value: $ty, address: usize) {
 impl_config_space_io_capable!(u16, pci_read_config_word, pci_write_config_word);
 impl_config_space_io_capable!(u32, pci_read_config_dword, pci_write_config_dword);
 
-impl<'a, S: ?Sized + ConfigSpaceKind> Io for ConfigSpace<'a, S> {
+impl<'a, S: ?Sized + ConfigSpaceKind> Io for &ConfigSpace<'a, S> {
     type Target = S;
 
     /// Returns the base address of the I/O region. It is always 0 for configuration space.
     #[inline]
-    fn addr(&self) -> usize {
+    fn addr(self) -> usize {
         0
     }
 
     /// Returns the maximum size of the configuration space.
     #[inline]
-    fn maxsize(&self) -> usize {
+    fn maxsize(self) -> usize {
         self.pdev.cfg_size().into_raw()
     }
 }

-- 
2.54.0

