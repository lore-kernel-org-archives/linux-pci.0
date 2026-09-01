Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020139.outbound.protection.outlook.com [52.101.195.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1877B4854FB;
	Tue,  1 Sep 2026 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281447; cv=fail; b=aU0E4w8uysohT/vzhma8J8hhqQqyD9+XDdw4jsx0PDnckF/QCB41RKMC2qCInaQgSokwpX9B/LYal8XHxiQONQhqEu+ge31ALVp0RM4ei5JYb2mTv7gG1s7hlzB+cF3QYnyjH70VwcFmXD4bB0auDNciWoT2USi9bdp/yzHYss0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281447; c=relaxed/simple;
	bh=2uNTtWhdTI1vj/BfIrNYGSr2FLG/bFe6Zrz19DCl530=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=adNiNdV+B+nTKV6rYwq4UxTBngQF1+LsgPCcSEtPaNreI6b9hya8PrdImmZUnVzHZRIOE5DdqcLJoDoguybxHVsbpF3N9h2akOe4NXmjVJt4Wc33y0W+Qp15/i4fo/86oX0cLD9gQYISnYfC2errMTZx4weI8Vih5vNlioILQRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=GWRc4kGe; arc=fail smtp.client-ip=52.101.195.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="GWRc4kGe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CwyicxT5DpR34upuzC7mFLC6kVkK4oP6y+IrvkGTatMH6Ko4XMWsC/y2ZoqmUbLS0CA1ACQJm/ZiHEh3rb8UHd9AKKxOdHdxqfKsaniyw6MP9HIuO9LAdpOJu13JLI2gfrbw7oc0lE1+wO3wYKcm7oEK5u9HG/243fodYilWAq3mwn7OP0tfg1kX72zLkZxPOIsRllnfnJebmC/1d7Lt9Fgor429EuxHotmc+l1Jxx9G33YQkJiN85DVKH5qeJoZsH6DgTZqCrUeVO/46aYkrC9mTp9A/dwl8V7ckLUnkQQoJRBTm6ll3ylD2cIW1Rmf5uJ/0BbLx3d+Uqt7K6Jmhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnKPXDwl84fJXnvofr18yY6Cs8bP0OUEpUgDn761ty4=;
 b=eKVKBdAV8w206UXcBbFbzVT0hLxAMmoaUMx/MfkiW5PAe2eWWdNFiiEfn3vVTo/dpHEswWafvSSCfflzmB3YAy2G8P7cvYiq0BOBHrud8XHCvae0h+Vyp6y1TEREbMZ712rZrnY9e2YJOWZIIHPDa88MJqRgtCVYgT/f+pOJt5yO1yQrErGUoahiOs0pkOKUcl3gPvXDJCs+dCtK56pPyUD35gLOvTrBrQr5XqH+25NpBdQLUrSH6U85/mbiWjaDT4q10KFjps8zLAvRnyfKOwEi2GuxY2H2+YzPhFTsNPkxErkbSD5QxB5wgdnDNRMMXhOUxQrT1Hz0TohjXSlDDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnKPXDwl84fJXnvofr18yY6Cs8bP0OUEpUgDn761ty4=;
 b=GWRc4kGeQld95s2gfCwpQC/6V3lg/me+bRxCRxm4YI3sye6HLLkikheZFr1145gvBPnvdMQKcojiULZJbx0pZ7l8kvgr+yqBpxh1+hzUE7yVeCL45gVIteUN7jVfcrWfgWv78Pc/m7HL7omVdDrHYXoBhUDFCzxPhHbrp0WU4Ps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO6P265MB6954.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:322::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 16:50:38 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 16:50:38 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 01 Sep 2026 17:50:31 +0100
Subject: [PATCH v4 07/16] gpu: nova-core: specify base type for registers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-typed_register-v4-7-5552b1d59525@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788281431; l=8979;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=2uNTtWhdTI1vj/BfIrNYGSr2FLG/bFe6Zrz19DCl530=;
 b=Kkekqypd+3vwr0X9v02kkDU4PlqTPgMe3QPqkP+xHv96CbfQT+Fdnhwtp96UPrXvZu4WGeAx9
 qINL2aqdCITA9qTqBN8oYrMvEBIUvDVrmM1Qp/rjTXYanjaZVUKjwVn
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
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO6P265MB6954:EE_
X-MS-Office365-Filtering-Correlation-Id: ac3c05d9-64f3-4a76-82d3-08df0849269b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10070799003|10067099003|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	buazC7D4XnVgA11scuI99f9v3QhBMP638C+952BG54WyeROoAKjvxp2OtFSqrTgpGS6+Q6wrL9LO4ghsdjIa2d2x4VgDGGuNb/DP2cLsgp6juMG7RgOCmrrahiBN/JxVueJojIiyCj4ZDlpL1DHYJggndrMWnFmiFpL11Bmdo+ApI1tS93dx0AXrPrtolzST3Hv3G1dmlhTeC4ABtVMgNhuku9VZqj7jkAILRn1M9n47F6kAf3tTXwi+MMaAsC0n8dV0PW3pO90MiPuvDT4dqyZHBCqGKUE70W7lIb6sIQxlVrpeUUIsQg4AW5YW8/qpM3aL+JGKn8D7yeYHGu8hVCItLyNMII82EY3gIVO4IldNr0spuxxh1yIZ68UTD6WG5+1fzhZxRr3m8YP+z2bX1mN1IXhUlTzO4R4At6k+42iwqstpRr/XDaGLOP3ax0FKDDAj6J+agpskGFeNeZGjvgE6/k0kyqtKGPYLmzcIhgkQ841p0tmgLON9KPoxWXYuPWbyDQSvSJVubXxISGPbvcxkET1HOTxkufbIN0dahhb/QVaj9o9uNtjMzeVB5KYFT+HpHE8VTQRwCh8eGgyUSVO/eezYAaFjmHGdS92GAHH3kTMrHET+dcUWmJ1+mza7P4OY3OelqfrmK1pfsOH58X/roVBo/t5+zT2f9SWQ8EoAp32oEG0Hqe7DN7kFCKHw87SU029+vIql8z3f24N6Xw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10070799003)(10067099003)(56012099006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzdiVHl2ejIvZXpJKzE3WUluR1FDT01OREQ1OXVUVE02eTQ5YzRqZkRQbnhh?=
 =?utf-8?B?R2xoSlNyTEVqLy9lejR0dFE4WVlLTlljcGVPdFVSUnFaK0hWZnowbDlkbzl3?=
 =?utf-8?B?SjJSaGNoN3pPUjExcklZZi9odnpEdTlQeExYaWQxN21nNXNGemRuWG8wbFpr?=
 =?utf-8?B?S0g0cS8yQitkS2l6bGRaSVdCYWNGeGQ2VXZzL2daZnpXQXl0OVFWRkxEbWU2?=
 =?utf-8?B?cGR0Zk5vQkhRUFkxMUFjNWhTb0I5eUlZeDRaaVEvOUEyTWJCRE1aaHZKc0Vz?=
 =?utf-8?B?Y3FwUE1tbVUyWEk3OWpscUlUdWM4VnNjUTByalBnNnJJd21OVElvVHZPd2pJ?=
 =?utf-8?B?SHA2TEl4WGJDT25IOFM2ZzJZQTF4Zm1RSHRoM1czVGxsVXZTVVgvMHZuZXJN?=
 =?utf-8?B?NWFDV09JUlU5V2JwdTF0eWJsY002OVNmZFJncjg3WEVXMzNwYk4relduUHRJ?=
 =?utf-8?B?ZzlpaHdtQTBKdG53bUlQS25tK3MxaWxyM3VQbUJhVnlrQ0IyNlBMNjZRMGN2?=
 =?utf-8?B?WlBkNEgway9wYW5NRGRrSDRpbGxMMStwaTJRMFRjeFpMTFk5UGJKQzBoMXlz?=
 =?utf-8?B?bXZ3TnNzY05ETWU2Z3FORlBabTFaaVRobk1HSVJyQlViRDZjdlhUdmhKMHUx?=
 =?utf-8?B?a0JOaXpuOEdjdHF3WC92VlZoTy9FYktXQTB6ZEY3K2ZrWG41ekp4MkJXV2U4?=
 =?utf-8?B?cDJGZjIzWTZnUUt5UkdnYjdzN2lPaytzMGJnSGY4ZWR4K0RpTThkdndSNmMx?=
 =?utf-8?B?S2xPUXRoV25BcUNuTVI1ZUNHQUM2c0dpeCsvQjZydHpxWkFwQ0NkNGlvdGNK?=
 =?utf-8?B?OWgvaUpyNXphbHppWEJWS0VPYWVlWSthQllySlVJajJCZTkwTklCNXBHN0ha?=
 =?utf-8?B?RStqbmtDK2d3ZGIxT0pod0FlbmN2TUJXRzdXSHZnSzVPdlJlMnVHQzN5L3NC?=
 =?utf-8?B?bHlySHgxTklQNC9QNTlZNHIrR09PRDFqMGhxcElNcDM2OGVRa05mbmMvNGhP?=
 =?utf-8?B?QUUrSXNEVzBYVE5rYXhYNnBwY2YzK3lPenFJdWpCdjRDa0tNOHdMNVFGVFB1?=
 =?utf-8?B?eGlQWHVDNTNUVkdyZ05TelJoRzI2YUFoU3N3QzdBSDNQNFR5VTJyQmVOaEx6?=
 =?utf-8?B?b3V3bU12VDJkenFqSWw3UHBjNC9CV1p0VTRuUjNtMXVtL3E4SzRLamFVdTZh?=
 =?utf-8?B?VXNNekhMTzR3WEFCa0c2b0dIMWw0YUxqenN2MWxiMG1JMlBaWG1ONEpsMERi?=
 =?utf-8?B?YXArdUx4a0k3ei9oa3M0bTIxelBmYTdrdXVCVndaaTdkbkh5QVQ4bm4vZTBz?=
 =?utf-8?B?ZUJoVDJTb3pjMUNGM25OcCtiSXFnNERZODhLekM4SUtXSkV2YzZsOTYrUzI5?=
 =?utf-8?B?TnpxbGYvS1FiTmZEN091R2d2ZFdDTGFTSHlleWY1cVVSKzJ5Qkw5M2pMdzZM?=
 =?utf-8?B?VHZnNUw2TUppekRtODNUa2lsUllsRVlUQzM0NjNJUXl2aGlPUXBxdGJhNUZl?=
 =?utf-8?B?UE1wTGVMd0F3eGZZSG9MbTIxWllYZXZOZi9MUk0wVXQ4UXJGZzZ0UTljTGFj?=
 =?utf-8?B?TnlUVmJVNDFnNFBIMHRUTGp1N3FIQlUxbDRnM3F2V2J0UlZaOFROZmhBSlM0?=
 =?utf-8?B?cXM4K25udXduRHgra2ZubkVWcUV0SU1HbHk0Q21ESmtCU0E2RlNrM0VPbEtE?=
 =?utf-8?B?R3VaeHVsTVhTK0JiZTl2WGNTMlF4L0dJZTMrWUlPTVFsTWs3ZkUrZGk0enRK?=
 =?utf-8?B?ZnoxRnZWSENISTAxcUVBbG5PZ2tiV01sblQ1dWRmYlJvUTRxWUx5ajRhVHFX?=
 =?utf-8?B?TlNpNkZFT2FmWFIxZ1FjL2lhLzlwa01DdmNBMFZGQ2grYkNoQU9Qb09CcHVs?=
 =?utf-8?B?bGw1N0hGTlpEbnM5aVV5b1oyeUkyZXlrQmhwNklwZk9DQlU5NzVacmUvWHlx?=
 =?utf-8?B?K3Y1Wkw3U1c3cGsxZWc5Wk82UXNnS3drZzZTSzRSdlo0eEdDTUxmWnpTL2Yx?=
 =?utf-8?B?eGpianFqOHNZSFViZTRqWkVrRmNaVE1UbmVUMDhJNzZjWFJCeVlNdGRHVXVF?=
 =?utf-8?B?SllKaGdaTmxWMGVVSGcvQkRrRisva09TTGJucmQ5V2lTa2tQZndEcEREL2Ez?=
 =?utf-8?B?cjgvemJFYi9pSHVFdW8rMFFzYlowYXNlQ29xNnU1Ynp6akVjRjlmekFnKzB5?=
 =?utf-8?B?dlRFQzRIVW5Tdzkzb2cxYnk3clM2YmhvM3Q3Zys0VnltU3ZNQ1JNSjdWVHl1?=
 =?utf-8?B?blU5NEtVZjhmU3JyQmI3bGRzbTRMMmxZUlhNZDFpMmZkLzZTNmJuV1d1RElX?=
 =?utf-8?B?VC9Pd3lLSDllU3RicVpuSXpXNjhQY3d5eStZRGkyaE40QVVTUGdjQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3c05d9-64f3-4a76-82d3-08df0849269b
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 16:50:38.8096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQw1yPspY3IK3otruYiAlYuFr6w113i8hqEMcCFSsd7InAguJyvw8gmO5snEXEyuqzR2iPEtJK59eHnya6iUNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6954

All registers use the same base type, which is `<Bar0 as IO>::Target`. Thus
add the base parameter to `register!` invocation.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/nova-core/driver.rs   |  1 +
 drivers/gpu/nova-core/fb/regs.rs  | 12 ++++++++++++
 drivers/gpu/nova-core/gsp/regs.rs |  9 ++++++++-
 drivers/gpu/nova-core/regs.rs     | 37 ++++++++++++++++++++++++++++++++++++-
 drivers/gpu/nova-core/vbios.rs    | 11 ++++++++++-
 5 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index bbd93959e0b2..cf3534dd47d4 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -37,6 +37,7 @@ pub(crate) struct NovaCore<'bound> {
 const BAR0_SIZE: usize = SZ_16M;
 
 pub(crate) type Bar0<'a> = &'a pci::Bar<'a, BAR0_SIZE>;
+pub(crate) type NovaRegisters = kernel::io::Region<BAR0_SIZE>;
 
 kernel::pci_device_table!(
     PCI_TABLE,
diff --git a/drivers/gpu/nova-core/fb/regs.rs b/drivers/gpu/nova-core/fb/regs.rs
index 95adbe124a30..c27582e376e2 100644
--- a/drivers/gpu/nova-core/fb/regs.rs
+++ b/drivers/gpu/nova-core/fb/regs.rs
@@ -5,9 +5,13 @@
     sizes::SizeConstants, //
 };
 
+use crate::driver::NovaRegisters;
+
 // PDISP
 
 register! {
+    base: NovaRegisters;
+
     pub(super) NV_PDISP_VGA_WORKSPACE_BASE(u32) @ 0x00625f04 {
         /// VGA workspace base address divided by 0x10000.
         31:8    addr;
@@ -30,6 +34,8 @@ pub(super) fn vga_workspace_addr(self) -> Option<u64> {
 // PFB
 
 register! {
+    base: NovaRegisters;
+
     /// Low bits of the physical system memory address used by the GPU to perform sysmembar
     /// operations (see [`crate::fb::SysmemFlush`]).
     pub(super) NV_PFB_NISO_FLUSH_SYSMEM_ADDR(u32) @ 0x00100c10 {
@@ -65,6 +71,8 @@ pub(super) fn vga_workspace_addr(self) -> Option<u64> {
 pub(super) struct Hshub0Base(());
 
 register! {
+    base: NovaRegisters;
+
     // GB10x sysmem flush registers, relative to the HSHUB0 base. GB10x routes sysmembar
     // through a primary and an EG (egress) pair that must both be programmed to the same
     // address. Hardware ignores bits 7:0 of each LO register. The boot path uses a fixed
@@ -87,6 +95,8 @@ pub(super) fn vga_workspace_addr(self) -> Option<u64> {
 }
 
 register! {
+    base: NovaRegisters;
+
     // GB20x FBHUB0 sysmem flush registers. Unlike the older
     // NV_PFB_NISO_FLUSH_SYSMEM_ADDR registers, which encode the address with an
     // 8-bit right-shift, these take the raw address split into lower and upper
@@ -101,6 +111,8 @@ pub(super) fn vga_workspace_addr(self) -> Option<u64> {
 }
 
 register! {
+    base: NovaRegisters;
+
     /// Low bits of the physical system memory address used by the GPU to perform
     /// sysmembar operations on Hopper.
     ///
diff --git a/drivers/gpu/nova-core/gsp/regs.rs b/drivers/gpu/nova-core/gsp/regs.rs
index 9a48aa87e7fb..3c410d65e8e4 100644
--- a/drivers/gpu/nova-core/gsp/regs.rs
+++ b/drivers/gpu/nova-core/gsp/regs.rs
@@ -2,11 +2,16 @@
 
 use kernel::io::register;
 
-use crate::regs::NV_PBUS_SW_SCRATCH;
+use crate::{
+    driver::NovaRegisters,
+    regs::NV_PBUS_SW_SCRATCH, //
+};
 
 // PGSP
 
 register! {
+    base: NovaRegisters;
+
     pub(super) NV_PGSP_QUEUE_HEAD(u32) @ 0x00110c00 {
         31:0    address;
     }
@@ -15,6 +20,8 @@
 // PBUS
 
 register! {
+    base: NovaRegisters;
+
     /// Scratch register 0xe used as FRTS firmware error code.
     pub(super) NV_PBUS_SW_SCRATCH_0E_FRTS_ERR(u32) => NV_PBUS_SW_SCRATCH[0xe] {
         31:16   frts_err_code;
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index caeef4d85874..1af073f3861f 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -13,7 +13,10 @@
 };
 
 use crate::{
-    driver::Bar0,
+    driver::{
+        Bar0,
+        NovaRegisters, //
+    },
     falcon::{
         DmaTrfCmdSize,
         FalconCoreRev,
@@ -37,6 +40,8 @@
 // PMC
 
 register! {
+    base: NovaRegisters;
+
     /// Basic revision information about the GPU.
     pub(crate) NV_PMC_BOOT_0(u32) @ 0x00000000 {
         /// Lower bits of the architecture.
@@ -108,6 +113,8 @@ fn fmt(&self, f: &mut kernel::fmt::Formatter<'_>) -> kernel::fmt::Result {
 // PBUS
 
 register! {
+    base: NovaRegisters;
+
     pub(crate) NV_PBUS_SW_SCRATCH(u32)[64] @ 0x00001400 {}
 }
 
@@ -121,6 +128,8 @@ fn fmt(&self, f: &mut kernel::fmt::Formatter<'_>) -> kernel::fmt::Result {
 // number.
 
 register! {
+    base: NovaRegisters;
+
     /// Boot Sequence Interface (BSI) register used to determine
     /// if GSP reload/resume has completed during the boot process.
     pub(crate) NV_PGC6_BSI_SECURE_SCRATCH_14(u32) @ 0x001180f8 {
@@ -175,6 +184,8 @@ pub(crate) fn usable_fb_size(self) -> u64 {
 pub(crate) const NV_FUSE_OPT_FPF_SIZE: usize = 16;
 
 register! {
+    base: NovaRegisters;
+
     pub(crate) NV_FUSE_OPT_FPF_NVDEC_UCODE1_VERSION(u32)[NV_FUSE_OPT_FPF_SIZE] @ 0x00824100 {
         15:0    data => u16;
     }
@@ -191,6 +202,8 @@ pub(crate) fn usable_fb_size(self) -> u64 {
 // PFALCON
 
 register! {
+    base: NovaRegisters;
+
     pub(crate) NV_PFALCON_FALCON_IRQSCLR(u32) @ PFalconBase + 0x00000004 {
         6:6     swgen0 => bool;
         4:4     halt => bool;
@@ -392,6 +405,8 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
 /* PFALCON2 */
 
 register! {
+    base: NovaRegisters;
+
     pub(crate) NV_PFALCON2_FALCON_MOD_SEL(u32) @ PFalcon2Base + 0x00000180 {
         7:0     algo ?=> FalconModSelAlgo;
     }
@@ -414,6 +429,8 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
 // PRISCV
 
 register! {
+    base: NovaRegisters;
+
     /// RISC-V status register for debug (Turing and GA100 only).
     /// Reflects current RISC-V core status.
     pub(crate) NV_PRISCV_RISCV_CORE_SWITCH_RISCV_STATUS(u32) @ PFalcon2Base + 0x00000240 {
@@ -439,6 +456,8 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
 // These registers manage falcon EMEM communication queues.
 
 register! {
+    base: NovaRegisters;
+
     pub(crate) NV_PFSP_QUEUE_HEAD(u32)[8] @ 0x008f2c00 {
         31:0    address => u32;
     }
@@ -462,9 +481,13 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
 pub(crate) mod gm107 {
     use kernel::io::register;
 
+    use crate::driver::NovaRegisters;
+
     // FUSE
 
     register! {
+        base: NovaRegisters;
+
         pub(crate) NV_FUSE_STATUS_OPT_DISPLAY(u32) @ 0x00021c04 {
             0:0     display_disabled => bool;
         }
@@ -474,9 +497,13 @@ pub(crate) mod gm107 {
 pub(crate) mod ga100 {
     use kernel::io::register;
 
+    use crate::driver::NovaRegisters;
+
     // FUSE
 
     register! {
+        base: NovaRegisters;
+
         pub(crate) NV_FUSE_STATUS_OPT_DISPLAY(u32) @ 0x00820c04 {
             0:0     display_disabled => bool;
         }
@@ -488,9 +515,13 @@ pub(crate) mod ga100 {
 pub(crate) mod gh100 {
     use kernel::io::register;
 
+    use crate::driver::NovaRegisters;
+
     // PTHERM
 
     register! {
+        base: NovaRegisters;
+
         pub(crate) NV_THERM_I2CS_SCRATCH(u32) @ 0x000200bc {
             31:0    data;
         }
@@ -505,9 +536,13 @@ pub(crate) mod gh100 {
 pub(crate) mod gb202 {
     use kernel::io::register;
 
+    use crate::driver::NovaRegisters;
+
     // PTHERM
 
     register! {
+        base: NovaRegisters;
+
         pub(crate) NV_THERM_I2CS_SCRATCH(u32) @ 0x00ad00bc {
             31:0    data;
         }
diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index c03650ee5226..9c214b9f4dd9 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -16,7 +16,10 @@
 };
 
 use crate::{
-    driver::Bar0,
+    driver::{
+        Bar0,
+        NovaRegisters, //
+    },
     firmware::{
         fwsec::Bcrt30Rsa3kSignature,
         FalconUCodeDesc,
@@ -92,12 +95,16 @@ impl<'a> VbiosIterator<'a> {
     fn rom_offset(dev: &device::Device, bar0: Bar0<'_>) -> Result<usize> {
         // IFR Header in VBIOS.
         register! {
+            base: NovaRegisters;
+
             NV_PBUS_IFR_FMT_FIXED0(u32) @ 0x300000 {
                 31:0    signature;
             }
         }
 
         register! {
+            base: NovaRegisters;
+
             NV_PBUS_IFR_FMT_FIXED1(u32) @ 0x300004 {
                 30:16   fixed_data_size;
                 15:8    version => u8;
@@ -105,6 +112,8 @@ fn rom_offset(dev: &device::Device, bar0: Bar0<'_>) -> Result<usize> {
         }
 
         register! {
+            base: NovaRegisters;
+
             NV_PBUS_IFR_FMT_FIXED2(u32) @ 0x300008 {
                 19:0 total_data_size;
             }

-- 
2.54.0

