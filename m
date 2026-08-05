Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021089.outbound.protection.outlook.com [52.101.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B47485519;
	Wed,  5 Aug 2026 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947849; cv=fail; b=hEpfn5QK56Tv9OUH2nrOR4k33i+BxYKlfDmY/iScR1iSs+Rx0XqeLwPlxaHeUPJlkFskIeML4Yv/h/yrNLjepCQECzLD7Eweg2tx6WnkjuHng/CpHYNtjWZOl64YZLj/V55JI7gLtMHpeonQUE5glCjF41KHfmkAf0yv50QJf50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947849; c=relaxed/simple;
	bh=9J7e7O/qAj2mua8poz9QndiT59xYtbe1AANZj4vu3YI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bpwtPmNPa1pT8Lk22k9uMcal1MlWz92mDtdMw49JNtfdJ1en/lkeWaszfbWuae17pETi/iLLlUg7TkCZoNrKvf51hePQVG7w8rhmLXwK91aBbqH0vPT+eJPgYMDjuaQX1ivUZ7xeCUtF0slWPUTzgVuhWh9sDWBkOmnkMzV707Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ES1c+BCs; arc=fail smtp.client-ip=52.101.100.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ES1c+BCs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XI3cfM9Y/G5t7+yCZFoxKAg8iSwUlbn5So0ydmnd1YgomrhjqeUI9XbbEEmh561CiPtjAOj2vQf1H1/LUXJkdU7SqUiO1vuocQ0VAO6Ka/xHEfJp9flpKSl3Sh06ZOSSaBKj1xTALmCDpObTYABGKpPncxAoctfG5I62vQ1M5LJZTGBw2+nnf8RHgKss7UPyuEBFlTscKAhlJd1G+5K1TvOy3OXnTTItd5WC7aSXS9+pe4GWSiIrS8cPuaGzZbX5DPgrpKoy/nJ16BqtEDRGNqh0Ms83lHJGswWhIo3zFIahXdOVByC9yIWUcREVVMdjaVueBPL5rcdtOjjZuFMg2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nux8+EyDETbEJDHjTqpkS2LEoYY5YRUMdwH0rR32Y+k=;
 b=fKjcx2/JnTvu4DQquAQRyurimVmcjQ52BHr7Q2cq2arg7wcT9qRWxyq8/+OGV0kTmU8w3HnFBwZKXE6A8sOKMTQKDyJrjQ/esdkHToXVpEXijSA315k5rWz18CtrLivhhkmQE2W1Qrp32rbRuCWP+QX1m5ozFWLTdR79kf3pfG5QGM2HFIslVOtgonCbSCvHAWIntL/F7yDXHkrR2PCNY+4ahoL1zIcgiyI7PmgXJJfUq+OUNe1T1Q1N/GEOTcl2ffCKjOq1LhbOzYXScDEqRWWM+2aVpETwCpfA8xXvIrNVTpOcJx871Gm9GS2pkgkSkwk0xEv5C2o6eGKURVV0wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nux8+EyDETbEJDHjTqpkS2LEoYY5YRUMdwH0rR32Y+k=;
 b=ES1c+BCsRJoYE1xpYTAtsYq4d5+bdvDftBqambIc8NGWFkqiUa9CR7nAYHVF5la/P78CZQ8057pZ1C9E0pnc3FIIGRwUCrmY7auYb7bgtoHrCW+nc2MNjbZD1muFb1MqJIAgzfT+2dZDOlZ9RhckGb4ewivRB/UX7herUzvIcc0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by LO2P265MB5822.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:26c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 16:37:06 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 16:37:06 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 05 Aug 2026 17:35:53 +0100
Subject: [PATCH v2 10/16] rust: io: register: make register have a typed
 base
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-typed_register-v2-10-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
In-Reply-To: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785947819; l=9199;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=9J7e7O/qAj2mua8poz9QndiT59xYtbe1AANZj4vu3YI=;
 b=scaXWrN6oyCt/LjisFokqrFLeMQIBqNbmbPKyco7PEakIrJd7V4a9ol/mprTRtMmOf11jaZv2
 ynTDK5UFfxpBm5dC7PxGGJ7uaJqjT7A6Hv2XHmsosaR7zh7AlZ/ckfw
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0608.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::8) To LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4b4::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOZP265MB8551:EE_|LO2P265MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b7a295-bd94-411e-69aa-08def30fc973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|1800799024|376014|23010399003|366016|22082099003|18002099003|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	eF3Yf7a/HrXb1xcasfy3rFRsRDw8bGKSyAb2SADct+NOC1QC7k11eyJu8jY7rQSfToRWFjJiPH5aYVJhbg8Mb7VGxgrvIdYhzb5FSCSkC2m0F3NRZRsFvIIoLmv2Y2gu8WegUnJw65BUVyXB+nObOD5dUr60aIxNLupqFnFS8g8aVvzojFKMyuAlSUlpU+W8+BNpgr5oO0mBSUm+RIUuwKPSOnuVBV311L7RMnDvLbXojXEAOL6RT58sL5dDw/Fwxod1yjdSn63ok4y2xwrhVUEZwv/Lw5x33CJchx+VtE4JiKOQZCyKkzsYsrq+Ikq+sd7RWuOzkMJKlhMzfuz1ltpXkmK033b/M0HE3lLuM/OLrQzI9Kmkx1qcx6Sj26wDBmV8PpwyUXDfnUOwmBMLQFYPv7w4POA7lpI/0ABLuUtSnONeEtU/mAz/kdagg4NTYLvGPcbovvKY9g/5fzGoD1U+rwV1T5nyOIOc0NYx/LrDagQlX0/cwwOtxUv9PmYFknEtyB4k9e2WfcvplTNgLV9hwH5hIGLSw9CvEML1rLsdvBjN1ar0UY7RtENKOaH+xV7wOmTc826C/9fyIrYZbWeUCp2mAHMyCC2ZzaqR/2Msh2hWY7oeBo4FxbjFgobwJXGHbL45V3kOujneJLB7pbWfytH45ePy2StYZv9MYtlD94cYeWSLJWrQfXp0g08tvRR4l+/dPQVVfaEKYyYlfw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTBMcldzWFljQjlXNXlMbEpiOGtHNUFqNzBqUEVnTk84M0pWR0tvZ3p1M2E2?=
 =?utf-8?B?cFllalFXS3B0UngyQy9yeGpKczVnY1pGSDk3bkttWVdQU256SHp6RGJoR0E2?=
 =?utf-8?B?UHExdlhDazJ2TUZXRWIzNnkxMVBoQkxKVTF3S2NUMEV3ZFNNZmJhVTU0U0t3?=
 =?utf-8?B?WEVzM3NoaWpmK0JaSG1pTVNWRkxxOHNJRWJ6ME16dVAydUZVTmE0UUI3ZWpJ?=
 =?utf-8?B?NjQ3TEdCRHNhSmpxckFFU09iOXVIT21nTHh4WThTS3F3cStTODRYdWgrUTRa?=
 =?utf-8?B?Wjh6VlpDVTRxNUF0UGVyVFRpZGZDb0FSU3R4ZEtSUVFDUzVzK0NkcjdLakRh?=
 =?utf-8?B?aXJsdXVkK3J3cXJXV0M0Skx0K2k3TGJiYmdpaUtTL3U1WHpRS3ZTd1FtRHZs?=
 =?utf-8?B?SER5U3RmUXhYcnkzWTBkVnZkaVdZUW16Wjh0VnMrOE82blpXa3p0NWxoRmgy?=
 =?utf-8?B?eFBzd3hkNm9DbDdnQjl4Tk5uNVFYcXdEQ3FMLytMRG9La04vK0l1cmI2S240?=
 =?utf-8?B?cXBoTzVVYzR1OEY2WnRFbUhTdk5YOWVJSjF1Q29qKzVwd0MyNUFwWXkyL0hy?=
 =?utf-8?B?TXByZnpxbVpiUEJqVFlWQzBjOG53S2wxcWpOSWlhc0p6d0ZTanNtQ0wyRXg3?=
 =?utf-8?B?QzBZdS9tdGdsbFRXK3V0cmJWR1hKcWt4M3htVFNpc0w0cjJ3NmhLQnhtbUhG?=
 =?utf-8?B?cnhrbzVONy9RQkVDU2tpc2NCOE0zWWFsNjZBZ3d6SG5iWTJYM29jMGxQR1B6?=
 =?utf-8?B?UkRjK0NPU28zNnVvY3lHQUkrZ3RqQ2ZhbFozRnlicHRvOWo1ZFpyN01YWElZ?=
 =?utf-8?B?eHlmTDE5SXk2UDV2cEhLNEtFV0YxTmRpbm1CeE9SYTNSWW90cGtwUnZYWDIz?=
 =?utf-8?B?cGlzbEdPbDFhNnB0dE15OXhIYjVuTGZoMGFJSnh1bWJ6eU5JdTJpbGxhb3Jl?=
 =?utf-8?B?QnBRbVZTdVV6NHlhTmJ2dVlMMUl4TUtnV29OQTVZZzRQK2V3Rm1GNXRKamQ5?=
 =?utf-8?B?Z3h0QjZrUXIrb1RhY2RvVkhTa21GSEc3STlHL0FmSURVbmFYejlWQk9pL010?=
 =?utf-8?B?c2dFRGJadGhER21lWHo3WFM1bldNZ1ZLeUJrWko1VFpKb0xQbjg2ZXBrOHIy?=
 =?utf-8?B?eW5FaEYxYkp6a21rNTdLQ2o4NUFnSWVUQzI4dkx0TTVmUjZIS2V2RDJXdENr?=
 =?utf-8?B?T0VpbThaT05qaGd0U0x3WCtpWUJKSkNHYnRhSU4wSkYwT0I2Mks4Tk53Qm9a?=
 =?utf-8?B?bXhCVWtndU1HK0dzZ1FZSkd5WmtJQnFWY0NYWDBvUk5LakFHY2lpWE8rTWJ0?=
 =?utf-8?B?aGU4MjQzTkpWYitLM2RybndxVHJpV3JiYnhZdlBCZGlnMktZTDdhWlFrbjZV?=
 =?utf-8?B?cGQxdjNMUmhsaWdXT1dWNWhwT09mVFd5YjVPdEw0dFh0d2V1ZXNLZElOTmFm?=
 =?utf-8?B?dDBXQWJTeUlqOTU3MXEyWVpzemxUK1pQVmxnbVRraFRmTHhTdW9TSHJ3Q3BN?=
 =?utf-8?B?OE9YRThXeG5kRTVrN2tNN3FIQmlLcHpaUUpkQ1RDcE9tTkdncFBhSTR6d25a?=
 =?utf-8?B?SXh0NFoxVThscVFYWFQ5dnNDb09HM0lWa2xrZ3NhNG9wSzVSeXhDN2d5SnJT?=
 =?utf-8?B?WVg2dytWZzgxWWZVdkVLdDErR1k5dnd3ZGJCMXJCNEFLU2RJYUJYZ3lYa3pq?=
 =?utf-8?B?ME5uak9uZ2xHODY0NHMxQ0wyNXJLaVdyRkh0dnA3cDJBOURMcjJxbHpRMHZG?=
 =?utf-8?B?QTZhSGxVc0d2NnhoRjdhR3Y5SWZYeGpBeVdhOUhGUy9uWmgySmN0UDJYbk9t?=
 =?utf-8?B?SFBCY1lmcHZvTThKRHZmbHRaeHJEckVtMHRmaXF1M3pnaWdia25YTkF3c2x2?=
 =?utf-8?B?MXV1bTBHV2dzYjUrcHFGcHFXemZWclB0YjFZNUZFRTdZRkNvYU0yU1pFdzRQ?=
 =?utf-8?B?YzF5MHBTUC9WSTM0OS82MWRUd0d0WE11cUNDUXBkVk9IMms2SjIwSWJLeE8z?=
 =?utf-8?B?blFoekxyd1cxUUNQY2FRYTNjZWl5VVpBUDhZU0J5M05FdnFlVWlvalhzUWdj?=
 =?utf-8?B?eWsrU3NoSWxUaFltL1dNdy82SjUrcDN6L2dGVjFVaGliYmlVdGtjajlZc3Rq?=
 =?utf-8?B?c1NBSWVySHJxWlFJMGZ3Zi9DUWhRTjByWFVaSnVLZFhLb2VrNlJJdmtNK1JL?=
 =?utf-8?B?OTRQVmNqckJoZTY1dEZ5UkFoejlmdWt4WHp1aDRVdm1zQm9zUmFhdFRaSDB5?=
 =?utf-8?B?ZHBkNkNaZE1IeUlaZEJJMTNZaWk5UmhRbmdMWVRvdS9pY2dxNUVMSWhSeG1V?=
 =?utf-8?B?WisyemMwK24xVHZ2bzkvdVNUeTVlRHRGYlU1UGI1Z2VEb3NBUjZnUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b7a295-bd94-411e-69aa-08def30fc973
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 16:37:06.3992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4pqlLlO3msJaGohl3Tbd/NWbWsvXfkZSkh2KPvDhoGcuHbaWQC0DVi/IyEbrp3GcRIWsyogai2MTt6RsH4ZFdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5822

Previously `register!` defined registers can be used on any untyped I/O
regions. With all users specifying their desired register type now,
propagate the specified type and restrict I/O access only when type
matches.

Also, add an `io_project!` example which is enabled by this change.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs          | 13 ++++++++++
 rust/kernel/io/register.rs | 64 +++++++++++++++++++---------------------------
 2 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index d92e0b6adc99..d56c8faa7d7c 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -1798,21 +1798,34 @@ pub fn project_loc<U, L>(self, location: L) -> <T::Backend as IoBackend>::View<'
 /// The syntax is of form `io_project!(io, proj)` where `io` is an expression to a type that
 /// implements [`Io`] and `proj` is a [projection specification](kernel::ptr::project!).
 ///
+/// `io_project!` can also project to subview of registers defined with [`register!`] macro.
+/// Register projection has syntax `io_project!(io, try: REGISTER)` for fallible projection and
+/// `io_project!(io, build: REGISTER)` for infallible projection.
+///
 /// # Examples
 ///
 /// ```
 /// use kernel::io::{
 ///     io_project,
+///     register,
 ///     Mmio,
 /// };
 /// #[repr(C)]
 /// struct MyStruct { field: u32, }
 ///
+/// register! {
+///     base: MyStruct;
+///     FIELD(u32) @ 0 {
+///         31:0 val;
+///     }
+/// }
+///
 /// # fn test(mmio: Mmio<'_, [MyStruct]>) -> Result {
 /// // let mmio: Mmio<[MyStruct]>;
 /// let field: Mmio<'_, u32> = io_project!(mmio, [try: 1].field);
 /// let whole: Mmio<'_, MyStruct> = io_project!(mmio, [try: 2]);
 /// let nested: Mmio<'_, u32> = io_project!(whole, .field);
+/// let reg: Mmio<'_, FIELD> = io_project!(whole, build: FIELD);
 /// # Ok::<(), Error>(()) }
 /// ```
 #[macro_export]
diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index 7dca2437b551..dc800fc71172 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -121,10 +121,11 @@
     io::IoLoc, //
 };
 
-use super::Region;
-
 /// Trait implemented by all registers.
 pub trait Register: Sized {
+    /// Base type for this register.
+    type Base: ?Sized;
+
     /// Start offset of the register.
     ///
     /// The interpretation of this offset depends on the type of the register.
@@ -136,9 +137,9 @@ pub trait FixedRegister: Register {}
 
 /// Allows `()` to be used as the `location` parameter of [`Io::write`](super::Io::write) when
 /// passing a [`FixedRegister`] value.
-impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for ()
+impl<Base: ?Sized, T> IoLoc<Base, T> for ()
 where
-    T: FixedRegister,
+    T: FixedRegister<Base = Base>,
 {
     #[inline(always)]
     fn offset(self) -> usize {
@@ -148,9 +149,9 @@ fn offset(self) -> usize {
 
 /// A [`FixedRegister`] carries its location in its type. Thus `FixedRegister` values can be used
 /// as an [`IoLoc`].
-impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for T
+impl<Base: ?Sized, T> IoLoc<Base, T> for T
 where
-    T: FixedRegister,
+    T: FixedRegister<Base = Base>,
 {
     #[inline(always)]
     fn offset(self) -> usize {
@@ -171,9 +172,9 @@ pub const fn new() -> Self {
     }
 }
 
-impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for FixedRegisterLoc<T>
+impl<Base: ?Sized, T> IoLoc<Base, T> for FixedRegisterLoc<T>
 where
-    T: FixedRegister,
+    T: FixedRegister<Base = Base>,
 {
     #[inline(always)]
     fn offset(self) -> usize {
@@ -240,9 +241,9 @@ const fn offset(self) -> usize {
     }
 }
 
-impl<const SIZE: usize, T, B> IoLoc<Region<SIZE>, T> for RelativeRegisterLoc<T, B>
+impl<SuperBase: ?Sized, T, B> IoLoc<SuperBase, T> for RelativeRegisterLoc<T, B>
 where
-    T: RelativeRegister,
+    T: RelativeRegister<Base = SuperBase>,
     B: RegisterBase<T::BaseFamily> + ?Sized,
 {
     #[inline(always)]
@@ -282,9 +283,9 @@ pub fn try_new(idx: usize) -> Option<Self> {
     }
 }
 
-impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for RegisterArrayLoc<T>
+impl<Base: ?Sized, T> IoLoc<Base, T> for RegisterArrayLoc<T>
 where
-    T: RegisterArray,
+    T: RegisterArray<Base = Base>,
 {
     #[inline(always)]
     fn offset(self) -> usize {
@@ -367,9 +368,9 @@ pub fn try_at(self, idx: usize) -> Option<RelativeRegisterArrayLoc<T, B>> {
     }
 }
 
-impl<const SIZE: usize, T, B> IoLoc<Region<SIZE>, T> for RelativeRegisterArrayLoc<T, B>
+impl<SuperBase: ?Sized, T, B> IoLoc<SuperBase, T> for RelativeRegisterArrayLoc<T, B>
 where
-    T: RelativeRegisterArray,
+    T: RelativeRegisterArray<Base = SuperBase>,
     B: RegisterBase<T::BaseFamily> + ?Sized,
 {
     #[inline(always)]
@@ -393,9 +394,9 @@ pub trait LocatedRegister<Base: ?Sized> {
     fn into_io_op(self) -> (Self::Location, Self::Value);
 }
 
-impl<const SIZE: usize, T> LocatedRegister<Region<SIZE>> for T
+impl<Base: ?Sized, T> LocatedRegister<Base> for T
 where
-    T: FixedRegister,
+    T: FixedRegister<Base = Base>,
 {
     type Location = FixedRegisterLoc<Self::Value>;
     type Value = T;
@@ -823,12 +824,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 /// ```
 #[macro_export]
 macro_rules! register {
-    (base: $reg_base:ty;) => {
-        const _: () = {
-            #[allow(unused)]
-            type Base = $reg_base;
-        };
-    };
+    (base: $reg_base:ty;) => {};
 
     // Creates a register at a fixed offset of the MMIO space.
     //
@@ -843,7 +839,7 @@ macro_rules! register {
         $($rest:tt)*
     ) => {
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(@io_base $name
+        $crate::register!(@io_base $reg_base; $name
             @ $crate::register!(@offset $(@ $offset)? $(=> $alias $([$alias_idx])?)?)
         );
         $crate::register!(@io_fixed $(#[$attr])* $vis $name);
@@ -858,7 +854,7 @@ macro_rules! register {
         $($rest:tt)*
     ) => {
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(@io_base $name @ $offset);
+        $crate::register!(@io_base $reg_base; $name @ $offset);
         $crate::register!(@io_relative $vis $name @ $base);
         $crate::register!(base: $reg_base; $($rest)*);
     };
@@ -871,7 +867,7 @@ macro_rules! register {
         $($rest:tt)*
     ) => {
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(@io_base $name @ $crate::register!(@offset => $alias));
+        $crate::register!(@io_base $reg_base; $name @ $crate::register!(@offset => $alias));
         $crate::register!(@io_relative $vis $name @ $base);
         $crate::register!(base: $reg_base; $($rest)*);
     };
@@ -884,7 +880,7 @@ macro_rules! register {
         $($rest:tt)*
     ) => {
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(@io_base $name @ $offset);
+        $crate::register!(@io_base $reg_base; $name @ $offset);
         $crate::register!(@io_array $vis $name
             [ $size, stride = $crate::register!(@stride $storage $(, $stride)?) ]
         );
@@ -900,7 +896,7 @@ macro_rules! register {
         $($rest:tt)*
     ) => {
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(@io_base $name @ $offset);
+        $crate::register!(@io_base $reg_base; $name @ $offset);
         $crate::register!(@io_relative_array $vis $name
             [ $size, stride = $crate::register!(@stride $storage $(, $stride)?) ] @ $base + $offset
         );
@@ -920,7 +916,7 @@ macro_rules! register {
         );
 
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(@io_base $name @ $crate::register!(@offset => $alias [$idx]));
+        $crate::register!(@io_base $reg_base; $name @ $crate::register!(@offset => $alias [$idx]));
         $crate::register!(@io_relative $vis $name @ $base);
         $crate::register!(base: $reg_base; $($rest)*);
     };
@@ -960,8 +956,10 @@ macro_rules! register {
     (@stride $ty: ty) => { ::core::mem::size_of::<$ty>() };
 
     // Implementations shared by all registers types.
-    (@io_base $name:ident @ $offset:expr) => {
+    (@io_base $reg_base:ty; $name:ident @ $offset:expr) => {
         impl $crate::io::register::Register for $name {
+            type Base = $reg_base;
+
             const OFFSET: usize = $offset;
         }
     };
@@ -1010,12 +1008,4 @@ impl $crate::io::register::RegisterArray for $name {
 
         impl $crate::io::register::RelativeRegisterArray for $name {}
     };
-
-    // Compatibility rule when base is not specified.
-    ($($rest:tt)*) => {
-        $crate::register!(
-            base: $crate::io::Region;
-            $($rest)*
-        );
-    }
 }

-- 
2.54.0

