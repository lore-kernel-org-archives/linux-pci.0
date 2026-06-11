Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022126.outbound.protection.outlook.com [52.101.101.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7079E436350;
	Thu, 11 Jun 2026 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195317; cv=fail; b=LNvUgIiaC/NEFKUtYgQhk5Hv86mD+5qY6Tau5nQrUn0YMkKazsH4CcVrqJl3z6t1uCW1dA6gLBEC/ankyM1NPvp5BFEwsySPOBEuyRe6iMZpnbELXsN/5NXQ3RUsbrfuzyCyORshO/hsnoNfNi+fb0V+YghHu6G6tRmf1gpSb9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195317; c=relaxed/simple;
	bh=NBpZ6XUymQOmrt3yk2SJTf8t9CMEp2VjM4ZTi8GWPec=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ndmMPOAYRodqmNe2NUlgy15UMy/E3GUGh6XFHvhFvbqre7kYvczU+QjYneajvPsZXsEr/9dBaBEogpBU4q+ydeTkFS6JAW8cI7mqe5Kpaf433AcySOGHTM1I98rbXi4ASPTS5Ic+Sm1W5PY4PWSQKHhla8vM94VJcI0gnDucMNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=M3a4Tf5A; arc=fail smtp.client-ip=52.101.101.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="M3a4Tf5A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ayzvg+AFlSNUAHJ7kWtiW+RBch7uOCnSlFW1Wl0AH1EFMm7K1Eu2rd0qR3BAzP3EqVABkfk5Br3ooLmOy8EI9VCShqKZVm2ag+qnplHSWTyMu6zvwiDaPmiMhppPC+3I0kRhbfFTZ1Yq/rP3DC11dTpyLlz5VwUUbEZoEaZNtDLb5uH/LHJdOVWGrAg1kT6mABEJAQWQmWP7vxI2ByfygTS1pXqFCPGRrhqnkfD80Rwk9EOqfEmsA2ICR6s2M/vPdu7eo2Ws6/rD7wX2Pz+RXSEa9Pe23Z/KKCEZJnACb2KlPbvQXINah6A4VaBhzsW6l+cIYB+t9/E9kR4fzlQzaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZWvR16iEy73XiDLaDuQn5boJIYryCI5q2a3poJsPKw=;
 b=luZsjtVAQHywCwUD1QsXdqsU9HxzaIVqfuZhb0XZ7D4lPTmwVb4rCsBwAqTXScizHPI4ot5XmxPmHCh16NJ4umajuhImvtLKkaR1Pax3RBuJ/GfQZPFuEhxciCtVuy/z6d6PpDyO6CNWUm0NReug6QSnh9GtgmTkPzLel3qfj+ZltifTsMn4QKoyW7JVrbPsVKJpygDgZiQmpsFsylLLNFGeMeNZdGQQ70BGghFF8JqiYFX47KjLK0yAlQUE4stf8+uslaaJiRr3due/q/w/mu+ab2gXc3gGhb9TLfDbAVlZFsBTWH019v232c0msMcIn0rDWkgBGDLG6QNzQjpC4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZWvR16iEy73XiDLaDuQn5boJIYryCI5q2a3poJsPKw=;
 b=M3a4Tf5AS8q2TTq6CaKAPwn3VsxhcKTrnnCRszNuECLa9fINkO0xPLfiHhhzY5LgWT6UKwW2b2U8R3P2NLr3ldOBRaJK7xfa1JxX/Idt0wcTzBvELzln3nK3j94nKI8dIrAz7Os9xZk6PSaiLtfFrURdlHns/0a7v1xBJ1ubqiU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO4P265MB6525.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 16:28:26 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 16:28:26 +0000
From: Gary Guo <gary@garyguo.net>
Date: Thu, 11 Jun 2026 17:28:08 +0100
Subject: [PATCH v4 06/20] rust: io: rename `Mmio` to `MmioOwned`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-io_projection-v4-6-1f7224b02dcb@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781195301; l=16838;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=NBpZ6XUymQOmrt3yk2SJTf8t9CMEp2VjM4ZTi8GWPec=;
 b=m/DB8HpVWRgfDzJ/p65jSUyNUdYuAuA1jsnH2KdL7g1zk4xzjPmJJcDuAjkM4pqSbQDpiik2D
 kIV6KEySu75DBbSaErkVUOcR1Qjr8uSWiSQPddTVQO81w3oObKQ/Prd
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
X-MS-Office365-Filtering-Correlation-Id: a84a6e2b-1d63-4736-97ef-08dec7d676b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10070799003|921020|6133799003|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xyD0GLVjSR5LIQJWRRV63U8qYfHKR4Dsjq37PSwzVHWtQVnTApTmOaR2OiYohZLiK8mTb716+9fJdS00tZNqijiwDgZhaVIJ8PJdZey57l8p0vFwQ3ISMPYgLExJiashQyhcZRkor8a3R6GEDrlB1mFZcFd+acSfib4BXI+lk+8AvmYJkbp9UEyvVPrIgXGQ3efEYjvR2hc+rxil6eDC1uI4oNK+c18QUu4MIt+yo/l6fWfI+ZOYW1IbDwwwFT0Q74jVg1UcUyqcto6601qdSstybdV1g+UlJM9/B/62FliC+Snn55w7h0X4bsE+YRWU+dSqFrFnV7EGF2LzMRV/jBomoHCZ+ltTDKHTcOVjZbOBEDImbHfo01DkvOt7fl6D26E49h9nkLRM9nZg8V4tt5DBXppUhwrk5ZvpkQ0zFilIgcc1dTu+tkce5X9em5SE6rY401NIplJ9K6jKD5JTlhm+8KwXffCKOWpD/TzQ7OghaUnV0TJdY42RE6GyoG6GXWjkH+Yr3bMjBZrSkyBokup7ZJY55EQJYk+p6d4PLcyZBmDEaTYhuoWFLbz0sRxH6ARkjFAZ88GybH7YygsSIkL8luhCB64P4WSBIEFKFYtrcv66lzsD6by7n75bY9lthGHuO2FcYOUc6HyO1bSLXhzJIs7CQ8TUt7ZJT3LYHweY2Ny8vEEm9iTFmuewFe6HdxyH2MYwTBT+Xli18JacTNrrxi8/EkJNvWvI2x5WtsQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10070799003)(921020)(6133799003)(56012099006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0ZhR1o2L2pXSkI3dzNpT0FkSTRLZ0dmTkRuZWNGSkxsT0FuaXZnN056cnNm?=
 =?utf-8?B?TGdkOHlIVUVuQ3ZPM2pZL2hCN3dNVC9HeCs5UTJ0SWRoYTdmWTdBZGRJNXFN?=
 =?utf-8?B?MldWVDNjbjRoMi8yZ3VWNzk3cWxKM1MzUU43RzNXanpPOHdtdlIxV05aMG9z?=
 =?utf-8?B?SUJ1cWN0OEc3ZFRHQUNzWDBxaElJbFdTL0VSNlJPL0NVa0syVElGcmNyb0hn?=
 =?utf-8?B?dDRsQmhQM0NMT0cwU1psTFlPcTBVRlE0bjN3L1lQQjF0UGkzR1R0cWVHaHly?=
 =?utf-8?B?QkdWbC9qNFV6bERPSTV2YmE2UHBxUlFJWW80ZDhUMmVpdC9YQkd1L1hKb0Yw?=
 =?utf-8?B?blBBa3VrZUhTRGI5UklSUTRLanp3aHE2amZLVVBqSG5FRHMzaUZJamgrNXc0?=
 =?utf-8?B?elJyTHBRRUJLMGpqdk1RNGdtLzhsSUE3WmJ1UnJkWHhSMXVpaFE0VmRwcE03?=
 =?utf-8?B?cmp6UHBNMFpJRmJBeDk3SFkwZDBLbUphREo5Z3JxSHU4dTU2Y0JnQisycWdn?=
 =?utf-8?B?N1gyR1VtWER5S01xdGNZQThib0dFck1zc0M1OUJodmt5dFdUUlA1Nk84dUtt?=
 =?utf-8?B?dTVSVGlRZy9RVEN5UnFobTl3aXErbm8zVkU1QUxpRFY1WjcxMnNSOVhUdmdL?=
 =?utf-8?B?eXF3Z09BL2JGczVVOURRL2ZoRTZ0RGJtT3BxVUlGZWdkbHpLOHF1cG5wVlpL?=
 =?utf-8?B?aXRHTDlINVBxbHVGMDd0UnBtWVkrY2lQZ21xOGxjUFN4TEZDU1c2L1JTcmRk?=
 =?utf-8?B?dG4yOFNabEFYenUwRmViVmtLcU1PcUtWUVJFVThKMVJVOGtkeXRGV2V6QkVq?=
 =?utf-8?B?M2dnUmdISGF0MklzaTZaUWIxMGpyc0hhcUpERi9DMlR6Y0lieGMvNlllZ25P?=
 =?utf-8?B?TnFWMmdiK3VJQTlOZ2pCaGhRNWd1Y3JsSFd5VWJrZTVTQXJDc3NYZnlIVDdL?=
 =?utf-8?B?V1V5d3F5L1ZadEFMZ1I1aXdqS09Jei9YNFBObFNqdG9qakJvMFg1LzhHR053?=
 =?utf-8?B?cEF4Wnc5Vi9YREdiVmxqa0krRGpwNTJXV3NOWE9tQVhtcmptUEJmcThqSjVp?=
 =?utf-8?B?NHVtRU5jVjVFZnBGdkhGbHJLdlJlb0ZIRktTRThpVnFyK01UaXVLYnpkemRi?=
 =?utf-8?B?czlqWlM4RitKenE0WU9lVEl1UlNUaHlrQk92RGs3Y3RLd29TSlpRRmZRTWtJ?=
 =?utf-8?B?N1drRU5MK0JsTC9aOEdwREdseHVqbm05WUc0MGthdEhSMVpaSkhydHVsT3BE?=
 =?utf-8?B?S3RlamJhYnlRb1Q3Y1l0d2tPWDdZYlhlUlRyVFpiZHJzT1VKdXNDYitaaWlB?=
 =?utf-8?B?a1NiNXRFRGdKVWgvMkg1b0dWSVBreUVPNWw1a1FaQmExaVQrTUloUFdDS3o0?=
 =?utf-8?B?S25XbndicDAxNllyV2RBRHpkYmxzckNWdzNIVk45Vk9LeGZQR3FRMFB2bnNB?=
 =?utf-8?B?enhMUEJiOFR0VUgzOEVnYUtvYmxUVzNjQXZYTllDOHBnZUFNdFBZVnRyOVhR?=
 =?utf-8?B?eUdBOHZXSnBoSTF3ckxiK01UcVZLTVF1UTMwMktPYW5ud0Q3ajRIYXBHS3cw?=
 =?utf-8?B?RGFxY2ZsVTBPMDJaeU56bHROQnN0L0l1NmNZaDcrSm56S3hseVZzVzVheVM4?=
 =?utf-8?B?akFZenNkR3FyVEtCT3kxaGhtVVR2aGdFcEVhTEprRktDTWhqTEFKSmRYb2ow?=
 =?utf-8?B?dGJtZGpvNHpZZzYrbzlBTmthUkJIVCswdk9wNzRQbGxzSEFmaGVZeWxNUnQr?=
 =?utf-8?B?b0RwMlM0b216WWZ6VDU1Vk1jekJzMERxcHRpSVB3VlYvQUZ5NEtsYmNYWHVU?=
 =?utf-8?B?MzhjczV3Z3ZoS2ZTUmw0RHkxbW9BTGE4ZzJuZjRhUjUvWnBXeWc5aTZMaTlh?=
 =?utf-8?B?c1NVWlhYTXVCVTN3SjJxbk5qeHBLaUhtdktqVldJV1c1ZUhheWJxN0RESFBo?=
 =?utf-8?B?Zm1TMHByek04YldLQjRCWUs1ekhQRDAwcGVtemxRbjlJU0EzMEgrMEFYZVdS?=
 =?utf-8?B?ZjI0WmRrd3MvclMxWjVja0lFZGw2SjlQczA4QVNoYkhrcDZEMGtLckNhR0Rh?=
 =?utf-8?B?blFUWkUyVVZrVXlKNWdtSTlKckV3eDEzQ0liNTRwcHMyY3JEZmxpa0N3YnJV?=
 =?utf-8?B?K3BzeFprVmlNMlQ2SHBFbDBGYXFnMi94VjFwYzMzV0Y2Q1dVUHNNd0huajRO?=
 =?utf-8?B?dCtaSHNDM3JRRFBWemtEZFpmRDVNUHZtTEJFRzdzdGx3M2NibWxhZlJRazBa?=
 =?utf-8?B?Mk1NRTBhMGlCYk5SQXRQS21ZelhVclY4MFY4Q1Bmc255bnJuUDFzWUN5cXJT?=
 =?utf-8?B?c3RNdmFyZWNSeFNXK2k1M0dBM2FNd09tZ2srb3JYcDA2bVgySU5CZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a84a6e2b-1d63-4736-97ef-08dec7d676b2
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:28:26.2463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXAXLSehtmZuEauHqfdFKZbUDA1AAP/zx6Qr8DT3DHs2vknfAbw3laHpTYbsvvuDBF823YIcqS9+gEgFIN/I4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6525

Most users would more commonly reach out to a view of `Mmio` rather than an
owned instance of `Mmio`. Only implementor of `Io` like `Bar` or `IoMem`
would need the owned version. Thus, rename `Mmio` to `MmioOwned` so that
the name `Mmio` can be used for the view type instead.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/devres.rs      |  6 ++--
 rust/kernel/io.rs          | 77 +++++++++++++++++++++++-----------------------
 rust/kernel/io/mem.rs      |  8 ++---
 rust/kernel/io/poll.rs     |  8 ++---
 rust/kernel/io/register.rs | 24 +++++++--------
 rust/kernel/pci/io.rs      |  6 ++--
 6 files changed, 65 insertions(+), 64 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index d0c677fd7932..aed0c994fd30 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -68,7 +68,7 @@ struct Inner<T> {
 ///     devres::Devres,
 ///     io::{
 ///         Io,
-///         Mmio,
+///         MmioOwned,
 ///         MmioRaw,
 ///         PhysAddr,
 ///         Region, //
@@ -105,11 +105,11 @@ struct Inner<T> {
 /// }
 ///
 /// impl<const SIZE: usize> Deref for IoMem<SIZE> {
-///    type Target = Mmio<SIZE>;
+///    type Target = MmioOwned<SIZE>;
 ///
 ///    fn deref(&self) -> &Self::Target {
 ///         // SAFETY: The memory range stored in `self` has been properly mapped in `Self::new`.
-///         unsafe { Mmio::from_raw(&self.0) }
+///         unsafe { MmioOwned::from_raw(&self.0) }
 ///    }
 /// }
 /// # fn no_run(dev: &Device<Bound>) -> Result<(), Error> {
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index c64b12ade123..9ca0d325da50 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -95,8 +95,8 @@ fn size(p: *const Self) -> usize {
 /// the represented MMIO region does exist or is properly mapped.
 ///
 /// Instead, the bus specific MMIO implementation must convert this raw representation into an
-/// `Mmio` instance providing the actual memory accessors. Only by the conversion into an `Mmio`
-/// structure any guarantees are given.
+/// `MmioOwned` instance providing the actual memory accessors. Only by the conversion into an
+/// `MmioOwned` structure any guarantees are given.
 pub struct MmioRaw<T: ?Sized> {
     /// Pointer is in I/O address space.
     ///
@@ -171,7 +171,7 @@ pub fn size(&self) -> usize {
 ///     ffi::c_void,
 ///     io::{
 ///         Io,
-///         Mmio,
+///         MmioOwned,
 ///         MmioRaw,
 ///         PhysAddr,
 ///         Region,
@@ -207,11 +207,11 @@ pub fn size(&self) -> usize {
 /// }
 ///
 /// impl<const SIZE: usize> Deref for IoMem<SIZE> {
-///    type Target = Mmio<SIZE>;
+///    type Target = MmioOwned<SIZE>;
 ///
 ///    fn deref(&self) -> &Self::Target {
 ///         // SAFETY: The memory range stored in `self` has been properly mapped in `Self::new`.
-///         unsafe { Mmio::from_raw(&self.0) }
+///         unsafe { MmioOwned::from_raw(&self.0) }
 ///    }
 /// }
 ///
@@ -225,7 +225,7 @@ pub fn size(&self) -> usize {
 /// # }
 /// ```
 #[repr(transparent)]
-pub struct Mmio<const SIZE: usize = 0>(MmioRaw<Region<SIZE>>);
+pub struct MmioOwned<const SIZE: usize = 0>(MmioRaw<Region<SIZE>>);
 
 /// Checks whether an access of type `U` at the given `base` and the given `offset`
 /// is valid within this region.
@@ -536,10 +536,10 @@ fn write64(self, value: u64, offset: usize)
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     Mmio,
+    ///     MmioOwned,
     /// };
     ///
-    /// fn do_reads(io: &Mmio) -> Result {
+    /// fn do_reads(io: &MmioOwned) -> Result {
     ///     // 32-bit read from address `0x10`.
     ///     let v: u32 = io.try_read(0x10)?;
     ///
@@ -570,10 +570,10 @@ fn try_read<T, L>(self, location: L) -> Result<T>
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     Mmio,
+    ///     MmioOwned,
     /// };
     ///
-    /// fn do_writes(io: &Mmio) -> Result {
+    /// fn do_writes(io: &MmioOwned) -> Result {
     ///     // 32-bit write of value `1` at address `0x10`.
     ///     io.try_write(0x10, 1u32)?;
     ///
@@ -608,7 +608,7 @@ fn try_write<T, L>(self, location: L, value: T) -> Result
     /// use kernel::io::{
     ///     register,
     ///     Io,
-    ///     Mmio,
+    ///     MmioOwned,
     /// };
     ///
     /// register! {
@@ -624,7 +624,7 @@ fn try_write<T, L>(self, location: L, value: T) -> Result
     ///     }
     /// }
     ///
-    /// fn do_write_reg(io: &Mmio) -> Result {
+    /// fn do_write_reg(io: &MmioOwned) -> Result {
     ///
     ///     io.try_write_reg(VERSION::new(1, 0))
     /// }
@@ -653,10 +653,10 @@ fn try_write_reg<T, L, V>(self, value: V) -> Result
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     Mmio,
+    ///     MmioOwned,
     /// };
     ///
-    /// fn do_update(io: &Mmio<0x1000>) -> Result {
+    /// fn do_update(io: &MmioOwned<0x1000>) -> Result {
     ///     io.try_update(0x10, |v: u32| {
     ///         v + 1
     ///     })
@@ -690,10 +690,10 @@ fn try_update<T, L, F>(self, location: L, f: F) -> Result
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     Mmio,
+    ///     MmioOwned,
     /// };
     ///
-    /// fn do_reads(io: &Mmio<0x1000>) {
+    /// fn do_reads(io: &MmioOwned<0x1000>) {
     ///     // 32-bit read from address `0x10`.
     ///     let v: u32 = io.read(0x10);
     ///
@@ -722,10 +722,10 @@ fn read<T, L>(self, location: L) -> T
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     Mmio,
+    ///     MmioOwned,
     /// };
     ///
-    /// fn do_writes(io: &Mmio<0x1000>) {
+    /// fn do_writes(io: &MmioOwned<0x1000>) {
     ///     // 32-bit write of value `1` at address `0x10`.
     ///     io.write(0x10, 1u32);
     ///
@@ -756,7 +756,7 @@ fn write<T, L>(self, location: L, value: T)
     /// use kernel::io::{
     ///     register,
     ///     Io,
-    ///     Mmio,
+    ///     MmioOwned,
     /// };
     ///
     /// register! {
@@ -772,7 +772,7 @@ fn write<T, L>(self, location: L, value: T)
     ///     }
     /// }
     ///
-    /// fn do_write_reg(io: &Mmio<0x1000>) {
+    /// fn do_write_reg(io: &MmioOwned<0x1000>) {
     ///     io.write_reg(VERSION::new(1, 0));
     /// }
     /// ```
@@ -800,10 +800,10 @@ fn write_reg<T, L, V>(self, value: V)
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     Mmio,
+    ///     MmioOwned,
     /// };
     ///
-    /// fn do_update(io: &Mmio<0x1000>) {
+    /// fn do_update(io: &MmioOwned<0x1000>) {
     ///     io.update(0x10, |v: u32| {
     ///         v + 1
     ///     })
@@ -846,19 +846,19 @@ unsafe fn io_write(self, value: $ty, address: usize) {
 }
 
 // MMIO regions support 8, 16, and 32-bit accesses.
-impl_mmio_io_capable!(Mmio, u8, readb, writeb);
-impl_mmio_io_capable!(Mmio, u16, readw, writew);
-impl_mmio_io_capable!(Mmio, u32, readl, writel);
+impl_mmio_io_capable!(MmioOwned, u8, readb, writeb);
+impl_mmio_io_capable!(MmioOwned, u16, readw, writew);
+impl_mmio_io_capable!(MmioOwned, u32, readl, writel);
 // MMIO regions on 64-bit systems also support 64-bit accesses.
 impl_mmio_io_capable!(
-    Mmio,
+    MmioOwned,
     #[cfg(CONFIG_64BIT)]
     u64,
     readq,
     writeq
 );
 
-impl<'a, const SIZE: usize> Io for &'a Mmio<SIZE> {
+impl<'a, const SIZE: usize> Io for &'a MmioOwned<SIZE> {
     type Target = Region<SIZE>;
 
     /// Returns the base address of this mapping.
@@ -874,27 +874,28 @@ fn maxsize(self) -> usize {
     }
 }
 
-impl<const SIZE: usize> Mmio<SIZE> {
-    /// Converts an `MmioRaw` into an `Mmio` instance, providing the accessors to the MMIO mapping.
+impl<const SIZE: usize> MmioOwned<SIZE> {
+    /// Converts an `MmioRaw` into an `MmioOwned` instance, providing the accessors to the MMIO
+    /// mapping.
     ///
     /// # Safety
     ///
     /// Callers must ensure that `addr` is the start of a valid I/O mapped memory region of size
     /// `maxsize`.
     pub unsafe fn from_raw(raw: &MmioRaw<Region<SIZE>>) -> &Self {
-        // SAFETY: `Mmio` is a transparent wrapper around `MmioRaw`.
+        // SAFETY: `MmioOwned` is a transparent wrapper around `MmioRaw`.
         unsafe { &*core::ptr::from_ref(raw).cast() }
     }
 }
 
-/// [`Mmio`] wrapper using relaxed accessors.
+/// [`MmioOwned`] wrapper using relaxed accessors.
 ///
 /// This type provides an implementation of [`Io`] that uses relaxed I/O MMIO operands instead of
 /// the regular ones.
 ///
-/// See [`Mmio::relaxed`] for a usage example.
+/// See [`MmioOwned::relaxed`] for a usage example.
 #[repr(transparent)]
-pub struct RelaxedMmio<const SIZE: usize = 0>(Mmio<SIZE>);
+pub struct RelaxedMmio<const SIZE: usize = 0>(MmioOwned<SIZE>);
 
 impl<'a, const SIZE: usize> Io for &'a RelaxedMmio<SIZE> {
     type Target = Region<SIZE>;
@@ -910,7 +911,7 @@ fn maxsize(self) -> usize {
     }
 }
 
-impl<const SIZE: usize> Mmio<SIZE> {
+impl<const SIZE: usize> MmioOwned<SIZE> {
     /// Returns a [`RelaxedMmio`] reference that performs relaxed I/O operations.
     ///
     /// Relaxed accessors do not provide ordering guarantees with respect to DMA or memory accesses
@@ -921,19 +922,19 @@ impl<const SIZE: usize> Mmio<SIZE> {
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     Mmio,
+    ///     MmioOwned,
     ///     RelaxedMmio,
     /// };
     ///
-    /// fn do_io(io: &Mmio<0x100>) {
+    /// fn do_io(io: &MmioOwned<0x100>) {
     ///     // The access is performed using `readl_relaxed` instead of `readl`.
     ///     let v = io.relaxed().read32(0x10);
     /// }
     ///
     /// ```
     pub fn relaxed(&self) -> &RelaxedMmio<SIZE> {
-        // SAFETY: `RelaxedMmio` is `#[repr(transparent)]` over `Mmio`, so `Mmio<SIZE>` and
-        // `RelaxedMmio<SIZE>` have identical layout.
+        // SAFETY: `RelaxedMmio` is `#[repr(transparent)]` over `MmioOwned`, so `MmioOwned<SIZE>`
+        // and `RelaxedMmio<SIZE>` have identical layout.
         unsafe { core::mem::transmute(self) }
     }
 }
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index 9e15bc8fde78..8f6c257c5b8e 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -16,7 +16,7 @@
             Region,
             Resource, //
         },
-        Mmio,
+        MmioOwned,
         MmioRaw, //
     },
     prelude::*,
@@ -211,7 +211,7 @@ pub fn into_devres(self) -> Result<Devres<ExclusiveIoMem<'static, SIZE>>> {
 }
 
 impl<const SIZE: usize> Deref for ExclusiveIoMem<'_, SIZE> {
-    type Target = Mmio<SIZE>;
+    type Target = MmioOwned<SIZE>;
 
     fn deref(&self) -> &Self::Target {
         &self.iomem
@@ -291,10 +291,10 @@ fn drop(&mut self) {
 }
 
 impl<const SIZE: usize> Deref for IoMem<'_, SIZE> {
-    type Target = Mmio<SIZE>;
+    type Target = MmioOwned<SIZE>;
 
     fn deref(&self) -> &Self::Target {
         // SAFETY: Safe as by the invariant of `IoMem`.
-        unsafe { Mmio::from_raw(&self.io) }
+        unsafe { MmioOwned::from_raw(&self.io) }
     }
 }
diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
index 75d1b3e8596c..79828a8006b5 100644
--- a/rust/kernel/io/poll.rs
+++ b/rust/kernel/io/poll.rs
@@ -47,14 +47,14 @@
 /// ```no_run
 /// use kernel::io::{
 ///     Io,
-///     Mmio,
+///     MmioOwned,
 ///     poll::read_poll_timeout, //
 /// };
 /// use kernel::time::Delta;
 ///
 /// const HW_READY: u16 = 0x01;
 ///
-/// fn wait_for_hardware<const SIZE: usize>(io: &Mmio<SIZE>) -> Result {
+/// fn wait_for_hardware<const SIZE: usize>(io: &MmioOwned<SIZE>) -> Result {
 ///     read_poll_timeout(
 ///         // The `op` closure reads the value of a specific status register.
 ///         || io.try_read16(0x1000),
@@ -134,14 +134,14 @@ pub fn read_poll_timeout<Op, Cond, T>(
 /// ```no_run
 /// use kernel::io::{
 ///     Io,
-///     Mmio,
+///     MmioOwned,
 ///     poll::read_poll_timeout_atomic, //
 /// };
 /// use kernel::time::Delta;
 ///
 /// const HW_READY: u16 = 0x01;
 ///
-/// fn wait_for_hardware<const SIZE: usize>(io: &Mmio<SIZE>) -> Result {
+/// fn wait_for_hardware<const SIZE: usize>(io: &MmioOwned<SIZE>) -> Result {
 ///     read_poll_timeout_atomic(
 ///         // The `op` closure reads the value of a specific status register.
 ///         || io.try_read16(0x1000),
diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index 64fff9193a13..242ad96ac805 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -58,7 +58,7 @@
 //!     },
 //!     num::Bounded,
 //! };
-//! # use kernel::io::Mmio;
+//! # use kernel::io::MmioOwned;
 //! # register! {
 //! #     pub BOOT_0(u32) @ 0x00000100 {
 //! #         15:8 vendor_id;
@@ -66,7 +66,7 @@
 //! #         3:0 minor_revision;
 //! #     }
 //! # }
-//! # fn test(io: &Mmio<0x1000>) {
+//! # fn test(io: &MmioOwned<0x1000>) {
 //! # fn obtain_vendor_id() -> u8 { 0xff }
 //!
 //! // Read from the register's defined offset (0x100).
@@ -447,7 +447,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///         Io,
 ///     },
 /// };
-/// # use kernel::io::Mmio;
+/// # use kernel::io::MmioOwned;
 ///
 /// register! {
 ///     FIXED_REG(u32) @ 0x100 {
@@ -456,7 +456,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: &Mmio<0x1000>) {
+/// # fn test(io: &MmioOwned<0x1000>) {
 /// let val = io.read(FIXED_REG);
 ///
 /// // Write from an already-existing value.
@@ -560,7 +560,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///         Io,
 ///     },
 /// };
-/// # use kernel::io::Mmio;
+/// # use kernel::io::MmioOwned;
 ///
 /// // Type used to identify the base.
 /// pub struct CpuCtlBase;
@@ -585,7 +585,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: Mmio<0x1000>) {
+/// # fn test(io: MmioOwned<0x1000>) {
 /// // Read the status of `Cpu0`.
 /// let cpu0_started = io.read(CPU_CTL::of::<Cpu0>());
 ///
@@ -602,7 +602,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test2(io: Mmio<0x1000>) {
+/// # fn test2(io: MmioOwned<0x1000>) {
 /// // Start the aliased `CPU0`, leaving its other fields untouched.
 /// io.update(CPU_CTL_ALIAS::of::<Cpu0>(), |r| r.with_alias_start(true));
 /// # }
@@ -639,7 +639,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///         Io,
 ///     },
 /// };
-/// # use kernel::io::Mmio;
+/// # use kernel::io::MmioOwned;
 /// # fn get_scratch_idx() -> usize {
 /// #   0x15
 /// # }
@@ -652,7 +652,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: &Mmio<0x1000>)
+/// # fn test(io: &MmioOwned<0x1000>)
 /// #     -> Result<(), Error>{
 /// // Read scratch register 0, i.e. I/O address `0x80`.
 /// let scratch_0 = io.read(SCRATCH::at(0)).value();
@@ -725,7 +725,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///         Io,
 ///     },
 /// };
-/// # use kernel::io::Mmio;
+/// # use kernel::io::MmioOwned;
 /// # fn get_scratch_idx() -> usize {
 /// #   0x15
 /// # }
@@ -753,7 +753,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: &Mmio<0x1000>) -> Result<(), Error> {
+/// # fn test(io: &MmioOwned<0x1000>) -> Result<(), Error> {
 /// // Read scratch register 0 of CPU0.
 /// let scratch = io.read(CPU_SCRATCH::of::<Cpu0>().at(0));
 ///
@@ -795,7 +795,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test2(io: &Mmio<0x1000>) -> Result<(), Error> {
+/// # fn test2(io: &MmioOwned<0x1000>) -> Result<(), Error> {
 /// let cpu0_status = io.read(CPU_FIRMWARE_STATUS::of::<Cpu0>()).status();
 /// # Ok(())
 /// # }
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 42f840d64a6f..e0acb62f58a2 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -10,7 +10,7 @@
     io::{
         Io,
         IoCapable,
-        Mmio,
+        MmioOwned,
         MmioRaw,
         Region, //
     },
@@ -242,11 +242,11 @@ fn drop(&mut self) {
 }
 
 impl<const SIZE: usize> Deref for Bar<'_, SIZE> {
-    type Target = Mmio<SIZE>;
+    type Target = MmioOwned<SIZE>;
 
     fn deref(&self) -> &Self::Target {
         // SAFETY: By the type invariant of `Self`, the MMIO range in `self.io` is properly mapped.
-        unsafe { Mmio::from_raw(&self.io) }
+        unsafe { MmioOwned::from_raw(&self.io) }
     }
 }
 

-- 
2.54.0

