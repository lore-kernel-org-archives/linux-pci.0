Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022139.outbound.protection.outlook.com [52.101.101.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A679145DF4E;
	Wed, 19 Aug 2026 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787137845; cv=fail; b=hje+ALQ2P0EZCn8d+mpyy+yJod71xOtKAth24iHV02PRYEoIgG8NwcgBArIVR03pSd2x4nEQJCc0s6ZTE2LPm+4yDDY0LCVCGxVEw55s/DZhQeodkUtMVYbpeMvsgxXHCt2HP2uijS1SInlPXtGDfnRXBYoAfJC0xmjg1+avKco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787137845; c=relaxed/simple;
	bh=UcdRmVpzRIL5d6EXe2nVU7lPrMffwe962tEbCQsnEq8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WAQHMXPSq4Vw+MLH5R11Iq9yf4jPDBGUX9nSZ86lA4kWsINvi0npEfKy40BFHUZrthmEzBfqNJO7aZymDFqkGAqDm+8DdzWB5Vh/eghtUw7+WUE6p74T+bKY1UFu7osk1c361a9ZHuuBWXPWZJxCGLNv2TTWLnJWtEiS5s3twrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Ha9JBVjA; arc=fail smtp.client-ip=52.101.101.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Ha9JBVjA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jALZFgFobHgWgmHM33DuosQEs0P/RISZuniyYGKSPmU6dFFh3n3CjD/rlxh2+HM6sn/tEXWKWBN1gpdgp2qUGIUm65+bChoF8o4ALnZoUhgTegKOzQNcwbWphsMI8IQ11z9G3rqwD5btRHWKuVm6z83G+acAdvbIJSFaYpTvShWqRk3VVY1x6KozltbjdNbzigh4aKTprCjlhnVAwTaPS4fzTkkELtCOpsGq4RmZ162ixdOL6BEaZ6TeLTAelnXpu57Ctzw+D3cdiFemObCOlamBAO35aRO6+/WbOgAvKKyxnKwIe0FDtZnFjV8Ld5fGTO9LAkPp7Aro9/wrIauTyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0B9J7EtjFFOfqpNapB2NAxL9XvD5dlbr2Cpc+w+7pc=;
 b=IzZtI40MBD7I1LsT/1jzzQfXfw4dQJhN/7xONzvQEzuveE1KqnEc5aSn33c4qGKP0KRxSpfj87fPvgFmEBYFNH8WYjBiRtL7X2DjlpN4bFkZ5ig8T9Oex2yGw9uoKl8tAWtzPzBDeGjPHLpKhJQV4iBcmqeYHqIHSAd/cMO19I0mDZ7UdXuwK0FHhahzsrj5QyGecVaQ2Mp39IkwSA6uX2fSkiVeS/9Fh4sucFbmtueVFpo7vMANTlZBdJyTjGRJPDcHhSDHhVqjl81Hb24V1LTaW8977Y7xh7Q6stS/jbxYAc8pIr35QLA/6Ut7yFuBZobzaqHHB2PRkarsb9fcQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0B9J7EtjFFOfqpNapB2NAxL9XvD5dlbr2Cpc+w+7pc=;
 b=Ha9JBVjAn2WNErgFAOlunk/CaUtzEwlNbhES8ijrxytpX3mXNOuL8sGBm+y34hSiTMPJt1H6L92cfdaymyXlru0BZNEPQevke2X1W/BMDypyeti26rvCdVAxq2JQ/hxroS6JFvN6H65O5S/yPZvtuyQ1PUjkZ4rTimlgBXTL5G8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB5113.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:15d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 11:10:23 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 11:10:23 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 19 Aug 2026 12:09:21 +0100
Subject: [PATCH v3 13/16] gpu: nova-core: convert hshub0 from relative
 register to projection
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-typed_register-v3-13-3699a75fadf1@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787137814; l=6702;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=UcdRmVpzRIL5d6EXe2nVU7lPrMffwe962tEbCQsnEq8=;
 b=dEHU3s9Bt6dbAAcjdnsSRiJ5FhuX3fnSoI4gjo0CkeMrfeY575uC6sAMCFXwhAsAlnr4eFJ+b
 nhmPxD3opaCCho/D0u6kZQr+RhiaEdoSVTGHjkcVW+oLdmjMCuuPiBA
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
X-MS-Office365-Filtering-Correlation-Id: c894bf8a-4e06-4420-1d5d-08defde27716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|7416014|23010399003|921020|6133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zbZMLvH2x/Qpe2XcHcVoNiduVTlci05kpOg7cnTMMg6sDlK6ooMdiwlz8hQzC0WRMNhlqucXE4SMjI2w0ePy4K86kwLfMzQK46RNPv3ipSE/2qgOQ2Ezxvc08mjMp2plC3pd0EyGTNtGTnbMwKmsD8Gm41Ij9wkExKo8U0DGVzoUacWysKzzBzJJNSRO1mbBPDpi+TIbs1YTJSQNkaWZkir9ez6N45Of87CiW6XTgFaKrA5QaQcOGC83UYg7uoou1ITf/O0EGSV1+Dst482cXKq1cBD51zUQ1ocut+HbP4VW2wad7Wh6WYwY3XiOhvXQnLgp8TJPimD9a/t2baoelj2Yec7kCU3fpDMDrFs8mQYW0fd6E4Sy/x4Cp1V85SLOQ87PZ4Z5nMCvkql1hVoIejZSZaerB5e1qPbJ7RciTwKm6VLqn9C+y5Eqgagevq11WiydYd/ZA4LlJPQVbhITtio5WPiLmWSx/Yeiu069O4f6F/zG39omltxuidEHh73exy9E4dEGk45LhcGcsvCcwGGgIyPsRRgLAKgctLf3eW5s42v5uD7ZX1so0YCIcGmYrWs1UwQ5784xOhyIvJ/WCDpoK61YsM1D5t0JwjcI8wRomitdMaLSirbldE0QDIflpIMLGAJxqGnD+szlQ4HCU5/a0DcrQrgiyi6ArK4ZPbE74KVXGsm7PG+LUOyO66AJet+1F+8VZPAIryjkBd8wVA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(7416014)(23010399003)(921020)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STh4LzlsWUNzdndOdFlJZm1NMUJaMHJ1bnErcDlHMHVSTWNIdXd5VmF2cmE0?=
 =?utf-8?B?T2xaMDdYVWw2Y2xUNFBGM0ltRlhRSkRrMDNkQ0Vzbys3UVY2TWEvM0kxSExq?=
 =?utf-8?B?VGxoUndvWC93T1V2VUZBWVBmL280ZC84WExseUNQbGtIblRucEZ1VW16cGc5?=
 =?utf-8?B?WVU1QnppaFJ3cm16R1JLbVZsNFdNbUJINEJ0OGtCTmdXdEo1ZXZFbUIwWi9R?=
 =?utf-8?B?QXFWL1hUV0syZHlXUFJycU1RejNQa0RDWDAxUGFWeU5SSGJIcmlQSmo4QnZp?=
 =?utf-8?B?MU1WdlpCNDlsTXdaSUZaYWpicmwxajd4TlVkTHR1LzJZNjdXWUlZWGxDcDNU?=
 =?utf-8?B?WUxMeTRtNVkzaWc0clFMRklWZmk1cGZQNTBweUViT1ZmbzVCRkhIazJ0cDVo?=
 =?utf-8?B?QWZkUHpKM2gwd3NaSTkrZ3Zyb1VpMCtKKy8xYmphV0RObUlRanlMdnJhbUVk?=
 =?utf-8?B?S09BcjBvOVMwZlpiRk90ZldnT1YvNTI4ZW5Cczh6dXJxcGt0QVdtQ3R5ZmtP?=
 =?utf-8?B?ZHA0VVc1eit5TzVwU0RWUkFQb0dCRitJcjk4c1lHT012OW1OaGo0ZEVFMHBx?=
 =?utf-8?B?OVpaK2xza3Z2aXlIMEs3Ri9GalFKTzg5NVRiUy9JTUFHZkticm1BbmxNWjNR?=
 =?utf-8?B?em8xTGNZUk9YYldBQlI0RGFxYWNwMjNJZjFUbDU0SnAxYWNiWk9KeGtmdVNP?=
 =?utf-8?B?M1hDeEpSL2l4cWRzb3dMNWtOYVcyWm14WU9xbC9oWGcwNlhXVCs1aXV2QTBK?=
 =?utf-8?B?S1h5Q3k2V3dDNU9oMkFCV1k2b25Hd0RYUXVOdE5hSlU1alpEYnFPSlVBUVk1?=
 =?utf-8?B?bWU4UnllL0V5d2cva2RJaElCanZUR2hjVlZjM3hBK1d5WTE3L1lldVVzckhJ?=
 =?utf-8?B?SjhVdGx4R3NoenkwZENRSU5kNXp5R2ZoY0hEVWEvNGNCemFJdmxzU0J3cWFx?=
 =?utf-8?B?dGdYMmsrQnNYQXJVOW9nZXVVcjB4RDY4QVdqUFN1ZU91cHl0THZrejBRNlh0?=
 =?utf-8?B?NHluMWJMQXJadnA3MC9QN2pnYzVINEhiZnZ3QkdOWUxKdnQ2NFVmbWNhU0E3?=
 =?utf-8?B?S2FVS1FUTXZpNUpqZU1VaGEvVnRkQnNHL2tMaVQ2ZHZJQXdMeU5EdmdxaUdj?=
 =?utf-8?B?UitPUWt1cjkxbDVPSGRnMmZuQkJnOXFZSDROMXU2OW43ajlRU0FROUZpNTVw?=
 =?utf-8?B?bWNNbDAvWHhKOCt6WVlUbnRLVXd6WllIOXpWTVpwQjBaYUJ5SVlabUhhRXZX?=
 =?utf-8?B?ZlZ1VDFEdXZsbms0Ky91a0NZSGFXS2JiZjZucUpoR1dFcVNmRFRDZXNlYXlu?=
 =?utf-8?B?bHladDRhRlhOTWZSNHdiaWhqQ044c0NtU3lIclQrL280cnYyT3ZVek5odmti?=
 =?utf-8?B?bTZKKzVSdGJZNENrTUMxbXdKcEluQmExNUVua0NNRmdrOXNGakRMUS9mZmVo?=
 =?utf-8?B?RTdUUG0xZDBIZnRSNkV5UW9ZbU05SHRidmhTVDZQckxCMHMwNlBzZXZkck1m?=
 =?utf-8?B?TnFWYk9kanVoVXFSVDJWaUoveWZMcVA0Rk9wVFEvcnJJbktqanh2bTBHaFhz?=
 =?utf-8?B?aEtZR25YbkdPb1V1MHNHOXpRV3hoaTdjK0Z3ay9nckFVQ1FsWitMS09uVDQz?=
 =?utf-8?B?RTVLTjNnVGNNVTVnR2FJcTVqQWkySFlEbnM0ZndncW50TURCQ1JrWndEaExi?=
 =?utf-8?B?R0p1TlRJRnBsaVZUTUdMZ3Q2d1pRdFJWc0M4RTBpWStCbEVBcjZzeitYWWFa?=
 =?utf-8?B?ZnkzT3VZRDNTTnhjamVoZ01sOXBvdUFpQlRSWVNyRktSVElmUGY4bzcreTcx?=
 =?utf-8?B?SENRZFlSWEwyaFFINy9RbTl4Y0IvbXhLbC9wNWtGUmhpK1F1TGxRZGR5Q0F2?=
 =?utf-8?B?dU0zdXpER2Q2dTB5NlBhYTloY2NGWTE2VnBtRHh0NzRkbHF2Sit4Z2ZmUHl6?=
 =?utf-8?B?Y1BVRlMrcE5QWEw3VnZLcmRzbXRzOU5zSkkzWWxFV0o0UGYrcFlab2VKMEFO?=
 =?utf-8?B?RkNQeGpvekNROGxrdHgyRW90WElvMnNwNFFBMnBCMFZob2UxRVBQOVIwRUZZ?=
 =?utf-8?B?S2dRcnpTSVNUbmw2T1hhYk9WMzhVb1ZsQStxVU44RldkS3IvYmpRWDNpakJO?=
 =?utf-8?B?ZUR2U2Y5aDdONUdmUG9GYzJOK0pzeERoT3BNQXRBSkJTTC96czZ2eG41dmU5?=
 =?utf-8?B?MWtkM0JFSXNhYWppK05jTHNzOUc3a21qK0RFVlZNRTdYNkRiN1Q0NGNaejlL?=
 =?utf-8?B?a2R2ZEMydzlWOXZCcXN2cThKanI4d2Z0VFhtQmNwK3pMd3dRdHBoMzFHMko2?=
 =?utf-8?B?RVZOYllRT1hYSzkrNFVUQ29QTG1iMmpWMEgzNEE1R1RkbmhQT29Tdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c894bf8a-4e06-4420-1d5d-08defde27716
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 11:10:23.6915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y6kUVRAgYnAEDAdGZx5dkSCF/L0CQ4zd2rPMNMx/4rU2zxgyTD4Ql83sjLriW8C+7F+k/v9Kttbc+GapPweHVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5113

Similar to the PFALCON and PFALCON2 conversion, the hshub0 relative access
can also be achieved cleanly with projection and a new base.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/nova-core/fb/hal/gb100.rs | 59 +++++++++++++++++------------------
 drivers/gpu/nova-core/fb/regs.rs      | 19 ++++++-----
 2 files changed, 40 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/nova-core/fb/hal/gb100.rs b/drivers/gpu/nova-core/fb/hal/gb100.rs
index d9e4d62ae632..9fa094939600 100644
--- a/drivers/gpu/nova-core/fb/hal/gb100.rs
+++ b/drivers/gpu/nova-core/fb/hal/gb100.rs
@@ -5,11 +5,10 @@
 
 use kernel::{
     io::{
-        register::{
-            RegisterBase,
-            WithBase, //
-        },
-        Io, //
+        io_project,
+        register,
+        Io,
+        Mmio, //
     },
     num::Bounded,
     prelude::*,
@@ -21,7 +20,10 @@
 };
 
 use crate::{
-    driver::Bar0,
+    driver::{
+        Bar0,
+        NovaRegisters, //
+    },
     fb::{
         hal::FbHal,
         regs, //
@@ -31,17 +33,26 @@
 
 struct Gb100;
 
-impl RegisterBase<regs::Hshub0Base> for Gb100 {
-    const BASE: usize = 0x0087_0000;
+register! {
+    base: NovaRegisters;
+
+    HSHUB0: regs::Hshub0Registers @ 0x0087_0000;
+}
+
+#[inline]
+fn hshub0(bar: Bar0<'_>) -> Mmio<'_, regs::Hshub0Registers> {
+    io_project!(bar, build: HSHUB0)
 }
 
-fn read_sysmem_flush_page_gb100(bar: Bar0<'_>) -> u64 {
+fn read_sysmem_flush_page_gb100(hshub0: Mmio<'_, regs::Hshub0Registers>) -> u64 {
     let lo = u64::from(
-        bar.read(regs::NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_LO::of::<Gb100>())
+        hshub0
+            .read(regs::NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_LO)
             .adr(),
     );
     let hi = u64::from(
-        bar.read(regs::NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_HI::of::<Gb100>())
+        hshub0
+            .read(regs::NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_HI)
             .adr(),
     );
 
@@ -52,7 +63,7 @@ fn read_sysmem_flush_page_gb100(bar: Bar0<'_>) -> u64 {
 ///
 /// Both the primary and EG (egress) register pairs must be programmed to the same address,
 /// as required by hardware.
-fn write_sysmem_flush_page_gb100(bar: Bar0<'_>, addr: Bounded<u64, 52>) {
+fn write_sysmem_flush_page_gb100(hshub0: Mmio<'_, regs::Hshub0Registers>, addr: Bounded<u64, 52>) {
     // CAST: lower 32 bits. Hardware ignores bits 7:0.
     let addr_lo = *addr as u32;
     let addr_hi = addr.shr::<32, 20>().cast::<u32>();
@@ -60,24 +71,12 @@ fn write_sysmem_flush_page_gb100(bar: Bar0<'_>, addr: Bounded<u64, 52>) {
     // Write HI first. The hardware will trigger the flush on the LO write.
 
     // Primary HSHUB pair.
-    bar.write(
-        regs::NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_HI::of::<Gb100>(),
-        regs::NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_HI::zeroed().with_adr(addr_hi),
-    );
-    bar.write(
-        regs::NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_LO::of::<Gb100>(),
-        regs::NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_LO::zeroed().with_adr(addr_lo),
-    );
+    hshub0.write_reg(regs::NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_HI::zeroed().with_adr(addr_hi));
+    hshub0.write_reg(regs::NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_LO::zeroed().with_adr(addr_lo));
 
     // EG (egress) pair -- must match the primary pair.
-    bar.write(
-        regs::NV_PFB_HSHUB_EG_PCIE_FLUSH_SYSMEM_ADDR_HI::of::<Gb100>(),
-        regs::NV_PFB_HSHUB_EG_PCIE_FLUSH_SYSMEM_ADDR_HI::zeroed().with_adr(addr_hi),
-    );
-    bar.write(
-        regs::NV_PFB_HSHUB_EG_PCIE_FLUSH_SYSMEM_ADDR_LO::of::<Gb100>(),
-        regs::NV_PFB_HSHUB_EG_PCIE_FLUSH_SYSMEM_ADDR_LO::zeroed().with_adr(addr_lo),
-    );
+    hshub0.write_reg(regs::NV_PFB_HSHUB_EG_PCIE_FLUSH_SYSMEM_ADDR_HI::zeroed().with_adr(addr_hi));
+    hshub0.write_reg(regs::NV_PFB_HSHUB_EG_PCIE_FLUSH_SYSMEM_ADDR_LO::zeroed().with_adr(addr_lo));
 }
 
 // This PMU reservation size is r570-specific.
@@ -88,13 +87,13 @@ pub(super) const fn pmu_reserved_size_gb100() -> u32 {
 
 impl FbHal for Gb100 {
     fn read_sysmem_flush_page(&self, bar: Bar0<'_>) -> u64 {
-        read_sysmem_flush_page_gb100(bar)
+        read_sysmem_flush_page_gb100(hshub0(bar))
     }
 
     fn write_sysmem_flush_page(&self, bar: Bar0<'_>, addr: u64) -> Result {
         let addr = Bounded::<u64, 52>::try_new(addr).ok_or(EINVAL)?;
 
-        write_sysmem_flush_page_gb100(bar, addr);
+        write_sysmem_flush_page_gb100(hshub0(bar), addr);
 
         Ok(())
     }
diff --git a/drivers/gpu/nova-core/fb/regs.rs b/drivers/gpu/nova-core/fb/regs.rs
index c27582e376e2..584488a3e012 100644
--- a/drivers/gpu/nova-core/fb/regs.rs
+++ b/drivers/gpu/nova-core/fb/regs.rs
@@ -2,7 +2,8 @@
 
 use kernel::{
     io::register,
-    sizes::SizeConstants, //
+    prelude::*,
+    sizes::{SizeConstants, SZ_4K}, //
 };
 
 use crate::driver::NovaRegisters;
@@ -65,31 +66,33 @@ pub(super) fn vga_workspace_addr(self) -> Option<u64> {
     }
 }
 
-/// Base of the GB10x HSHUB0 register window (`NV_HSHUB0_PRIV_BASE` in Open RM).
+/// The GB10x HSHUB0 register window (Base defined as `NV_HSHUB0_PRIV_BASE` in Open RM).
 ///
 /// The base is provided by the GB10x framebuffer HAL.
-pub(super) struct Hshub0Base(());
+#[repr(align(4))]
+#[derive(FromBytes, IntoBytes)]
+pub(super) struct Hshub0Registers([u8; SZ_4K]);
 
 register! {
-    base: NovaRegisters;
+    base: Hshub0Registers;
 
     // GB10x sysmem flush registers, relative to the HSHUB0 base. GB10x routes sysmembar
     // through a primary and an EG (egress) pair that must both be programmed to the same
     // address. Hardware ignores bits 7:0 of each LO register. The boot path uses a fixed
     // HSHUB0 base, so the multiple runtime-discovered HSHUB bases are not needed here.
-    pub(super) NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_LO(u32) @ Hshub0Base + 0x00000e50 {
+    pub(super) NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_LO(u32) @ 0x00000e50 {
         31:0    adr => u32;
     }
 
-    pub(super) NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_HI(u32) @ Hshub0Base + 0x00000e54 {
+    pub(super) NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_HI(u32) @ 0x00000e54 {
         19:0    adr;
     }
 
-    pub(super) NV_PFB_HSHUB_EG_PCIE_FLUSH_SYSMEM_ADDR_LO(u32) @ Hshub0Base + 0x000006c0 {
+    pub(super) NV_PFB_HSHUB_EG_PCIE_FLUSH_SYSMEM_ADDR_LO(u32) @ 0x000006c0 {
         31:0    adr => u32;
     }
 
-    pub(super) NV_PFB_HSHUB_EG_PCIE_FLUSH_SYSMEM_ADDR_HI(u32) @ Hshub0Base + 0x000006c4 {
+    pub(super) NV_PFB_HSHUB_EG_PCIE_FLUSH_SYSMEM_ADDR_HI(u32) @ 0x000006c4 {
         19:0    adr;
     }
 }

-- 
2.54.0

