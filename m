Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020086.outbound.protection.outlook.com [52.101.196.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594C85C613;
	Tue, 21 Jul 2026 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784652879; cv=fail; b=AvD/ItOdGFhcnRH73Ljy/zM6TtleDfnwMkcGgzjsd/AQE/Jab1vD+NLa7E30rC5genJuhAGjB7qgm1ioZ9LGWb/ZuHepURQcKTlUj8aTAqMK4nXDEJ/JDB4qVuceQthogfxDFmxufv0G7mFu+ph643okHMvjlTf9TDoH61n88rM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784652879; c=relaxed/simple;
	bh=4xGCDf5PobFlcVHfZZcN3wpd3WKhjw3CCXz8HU8+f0k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gvefvJB48svIxy/KqwunrZkAgzPkAY9oSnqAAeaCSz8vcLZa6D9HOm1DnA5qDlDJSWw015dBZKJLgNlhZhcRmDv7INtxejqqLc95LBY3lnkZQIS9DIO7XBLcwxhIMFrqn8cQoZbZlF6ePMFhvOd7PRacj7NrvAvS5g4mjXujpqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=HykDDPEK; arc=fail smtp.client-ip=52.101.196.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="HykDDPEK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dgy2LPlB8MaN6ce0Nv30CINbAUVLFxLSxREx3HJbGNYvtk0/8NudJZnOn6yf7VxSOqN0AEit8LyFEKSFMEtkNPLnwVlAAP7VPpZu0c1YbnfF5kEbnx2sSam5hQh6Upvnus2On1bBO4oiMFg2AEcgRpgX7yudNLX8StNfJI7cZYlLe028lgG04QIBuwiKGz0+vYC2snvFrphoQZ39Xqlu17P5at1vGPHWi8CzANF9P6NG3wanYAIPjJERDYEm4dOfk8IBRIMO3PrEuX9fMswAr2UEuXXzUL3Son48kwVWMaWW1Mg/TzQ1J1R39y2bxPG/GAnFc90VQl7c4N5dgy/z1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQSlD2okbMxmDByMY0NDFaKyI69PtZ5jkloRhFMO7Y4=;
 b=ZYTUqNkGn3DcHYv+UHZNOWtEItH9G9Dl8F4D6gullKq0LjgyzuJFTL4pqYmeA1jb4y2ESha5FaVXx2755D3w4APGmALwAKqlc0KhJn94HYZANtdEirFw+yByyf4pXeET1mlYowqo+Ybzi9WW43OnzK+gKOZYvDnzdwLku3IGBgaM7rhE6lG15qd3U14lSRA11E5dFFUvvgov5YVkXEwgYFXt0dD44iEBY8kdeIFjKXgVNAGYBpiwEIaGrkaQ+nUmbIInUQv9u1AOc9EMmgPB8dxiSQkfWTQNuv1L5R1uQGsHnY8ro1lWelhYjR0ADIMV7SkYcYu5NEt1e6RXhgljOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQSlD2okbMxmDByMY0NDFaKyI69PtZ5jkloRhFMO7Y4=;
 b=HykDDPEKCBorJ88H3mtLlyykf686ALPjmDdG5Ca22Ly2SPSvFIOBP46F4GANxVHddamargkXtNYd6Mtuv463pBncRCFsPkAGEuvdr3lLjtY5p17S/ozjHyc2rHmNbck+aIOz4NmbjFxiRhbaSQyZKu9DrW7E7VF4WsVeWKGYlm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7878.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 16:54:34 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 16:54:34 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 21 Jul 2026 17:54:25 +0100
Subject: [PATCH 01/10] rust: io: register: allow explicit base type
 specification
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-typed_register-v1-1-452d72b60262@garyguo.net>
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
In-Reply-To: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784652872; l=8773;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=4xGCDf5PobFlcVHfZZcN3wpd3WKhjw3CCXz8HU8+f0k=;
 b=oaKOqpH8wtNQ3+XFDkY5oDFQGe7nJPZDfogjm/DSM6x5VqO5usNei/DzpJcM1CIR7hCmM2jao
 IOQN1R8pIoDBgODvPLkPt9Utm/ECA+dUIkEE4WtsVmwiG9yBWCgtEnX
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0143.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::22) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO8P265MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 74c92060-225c-4156-c359-08dee748bd85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|10070799003|1800799024|366016|56012099006|10067099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	rgYoD7CWhtXMvfNWAimT3uz/GTz0ltJ9F8BE9xrbD3uLGRaAvAfbTHvl0TlF4itm874rfxncUfqwZvMuc39HCXWDjrOpXbHzdqHm81vboSbA7/7BdzkF5zwueqgUvoZPxlhIUpCwcckFhNeKMZFCsa7dTb9iGYZBqJTGLexTYrKE2vV8Wcxy9tv2yhWxgTMYJLRnwFCVoVtOUNmfwl0fosG0dG6oUIZMfhI6EuAyC5SaPI0kapeCNGmWUaSIMpTwrfSL8DIFp6IBqmLeAOxS5mNzCiLNsLvNaqqXycfI3LsXq13v1fNg2dhCqsHIJ0Y9HevoZg2qH8yoc8IalXVx+/rI9NLwDZmUsJ7b6Fwy07O7gJV0zYTuPtrt7zxXV6XyoaPnyEMQoQrVD9e3Z3pY9OSe4xaxYTmIboSqNJ0YEIkFXRT1UIgYQ+KwUegH/JQD4wUnsCJyZInDqxc7xwcR76szL9gXKTQ5ToWaKu91p9BPhJ9OddmysFAGLX2OTr0nhskCvx7nbuR4UIV+lvnjK2JbYEwIqDHkN7L+Kw4fiG0sxEKDeQI2E6e7ZjiGgZoSRmWE3mSpGbSdcpDYz2mhkO42x8XgfZgWqdLqQ1kT83l5yAdUfhroWejzxcJo9fz8xb2k0Hh8aeolbiTRxNP4PTNlQF4NcU4NKRdk/Z6x6Rw/9353CUZUy8E8HsMCiW1XSH16drpWKbuAqLNaRolg6A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(1800799024)(366016)(56012099006)(10067099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2t6bTM5YWxGazdvZERLNjVCYXdEb2p0MVJkYitQMVZzVUtQTXZhek1TaC9B?=
 =?utf-8?B?SFFFSVhSaW54LzRjUFUvZytIRW5qMUpUQ1JIRmhUczdxNzcyY0lhUldyd016?=
 =?utf-8?B?dzVmY1AySmw4NElMc0N0TmJPYnJzRnlWczF4REpsQlMzbUhtL1ZxUTM5ZW9i?=
 =?utf-8?B?QVYxdFpDcnk1V2s3Uy95dUZXR2hIWUVmZytoSTRqMVVXVXJCbzRaRjQwZWk5?=
 =?utf-8?B?YzJJUFR4bXpJcTV2bG42b0Z1TkYvQ3QwLzF1blc5VXVyRURXOHpRYlNLOVQ3?=
 =?utf-8?B?SXRWYVcrUTZaM3o4c0JYbkZDN28wMlZBeTlUVDE4VnhpTnhLOFRkSEJ5MTI2?=
 =?utf-8?B?US9WME9WaDVldStQWlRRNzIwK3dmbFE2M0R6aWZUOUMzRHYzMXI1M2lYS2V2?=
 =?utf-8?B?cEhDUERxYU9nU0dwZk9yTDZnYXdRbkwyOFBkemZxb0JlQXhvZjFid3BrVGtm?=
 =?utf-8?B?enY2dFFxb0tWdmFCODVVR2Q4TjNxSlZxQk5lZ2podjgzUWx6UmRJd0Z1dnhw?=
 =?utf-8?B?NEtXZm9IcnQwSjkyR3A2YlpKWEpDajkraGRzTk5ndXAvcjdtUGkvS3VHYkhN?=
 =?utf-8?B?eTM1QWFUNFA4bEJMYlVTc1JiTGdLdXdWSzZmeWZPRDEvdkVmbDlPM2c5WUNY?=
 =?utf-8?B?Y1BBcmhTMUkrUTdxNEJwSlUzNWJ1amxpa2tGaXNsYTZWVEUzMDZuL2QrZ3ZZ?=
 =?utf-8?B?YURMS0VmOWJ2dVoxL3dmZzQvTXBjL3plRkpZVzliTm9JY2ZYSW9jckkza2M0?=
 =?utf-8?B?QzBNc2dicjBpeUdxcVBOem1jYm82RmhhZk8zbUxnSUhJcFZsU2pDNnVJdWJz?=
 =?utf-8?B?UzBTVWtyY0d4RW94a2dXTkFxTXZ5TXdSZ2VZK0pqV0E2T0V6TEVRVjV5eCtL?=
 =?utf-8?B?OGNvRkFaaU1PZ2pLMTdYaFkwWTVkQ3ZWY2dTcWR1dzU2aXRodVNoQ0UzNzd3?=
 =?utf-8?B?NThrODlhU01ZUWwxRFM3bHpXa01QbGZ4MkhKZ1pQSitjMnlrK2NBTnhQVFVS?=
 =?utf-8?B?VTdxT2lxdHpHc3lUbk9YMHFZaXNmVUo3dkdlODE4MGtwSlE5cHlhaStFNklp?=
 =?utf-8?B?NDVmR2EvQlg2Tk5tcVFiVnV1WjkwWFVrRE1zRDhLRkdnZTBSWHZGSm9ZcTU4?=
 =?utf-8?B?ZVAvQk1BYUVDUmFwQmRPc2dHMmd1YXZGOEI5dER5ZGt3WDMzUWdoZ0hWSWpP?=
 =?utf-8?B?TEpqcjRZQmNGbWp0ZlpIL2MxMWRRK1NZL3JHQ056TnYwMmF4R1NkTG9hSkw2?=
 =?utf-8?B?NUpYSzVyN0dEVWVyQXk4dXFRK2J6dmRtL0dHbGsyb0hBRllZcUduekpyU1kr?=
 =?utf-8?B?WnlsdEtseFZwVUVjaVo3b3d0OUtCbVl2SkVMakdLempKdGc4Q2pFUUdIVis3?=
 =?utf-8?B?TWlDSkVVZjVUZS9HZWRQUUJRZzNJKytqQ0NhaUxSbHljR3ZyV3NSZHg5dUNs?=
 =?utf-8?B?UVRPd2V2TTNmZCtqU1lyOWFZTHFmUVVURGEyT2FCalAzdnhJaE5XTTdSTStT?=
 =?utf-8?B?eG9iNmYvQ2RTUjhnYzNIUk1Fd0NsUzE1bGd0MlJHaFpINXl0MVBjSkQvVTVC?=
 =?utf-8?B?RERjNTdwTEhNUmtxbjVtSmhrSEMvazMzZWZLSEQ0SjdqUXVGckZuTVhEM1Jo?=
 =?utf-8?B?MmZRSE5PVzJDb05ZRWVmeWt5WWpwK1NKQ2tPZ1FaeHFKT1NZQjJnRStRaFFj?=
 =?utf-8?B?a3RJV1RKNzVZTWFyQ21IVlpxaG9rNXNDMldneS9ucWRPdC9oTmI4b3c1a29u?=
 =?utf-8?B?d3JTbHI5QXovd3RyMC9SeU82NEZST2ZRWTBUckJDeTYrZ1JveC9JZ25odXd3?=
 =?utf-8?B?R3VKQldoYmNIeTdpUUFWcXdHZGlybmh5cXBQcndydVZOSGxUZVJxY040ZUZI?=
 =?utf-8?B?SktxVjZ6ajZSVGV6a2J6S01JNjdqTHFmRTRBS1JQTWdyV25ndTBCKytKUXJn?=
 =?utf-8?B?bGk4eDhEa2FUZWRJWEwzY2VkSmdNQ3ZYTXcvQjFXanhjK2ZMdVRrQU5Bc2Zl?=
 =?utf-8?B?VnNBRUluTEZKU2NzSjdmaUtvWWc3Qkl0TXlaTFFTRHMyMmw5THVSM1RJWVhB?=
 =?utf-8?B?SHIyYURIRHRxam1lajZ0L3IrWTRMck16SWlOSEc3dTF6V2hKdnF0Vm9FekUy?=
 =?utf-8?B?SzkrVDEreXMxRXJFSnQyS04yQ1dqQ0t5R0xnczNSaVdkOWNwOFVwdEh6ZGRo?=
 =?utf-8?B?Yks2V3NlNWFkV0xhTGdBYThYbTM3c2RBR1ZsUUl3U2ZWQXl2YlNiaG4rUXJV?=
 =?utf-8?B?ckJSTG0wWmtSYnlNaVNlSzMwZ0hEaTY5VjVkSWFIVWR4YVEwZ1E1YkxYTnF3?=
 =?utf-8?B?SWx0QVhMK2FtNUxHT2pKNHpoRVFIazRVNVlZb3hpTXM1bUNxM1dHdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c92060-225c-4156-c359-08dee748bd85
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 16:54:33.6963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FSbBwgu9xyV6/9GoununumtHZljpychy5llmGHc/l71+NGaLXUiBAD6U4++ck0/tR+5N4+GlzjGSyYYsAUOgXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7878

Currently registers work for all untyped I/O regions, which is not ideal.
It allows registers defined for device A to work for another device B and
there is no safeguarding at all.

All users of the `register!` macro know what type it will be operating on,
and that type is consistent across the driver. Therefore, add a `base`
parameter to `register!`.

Currently this parameter is unused in the generated code; it will be used
when all users of `register!` is converted to gain the parameter.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs          |  4 +++
 rust/kernel/io/register.rs | 79 ++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 76 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 95f46bb75f9e..c5f07c38e59e 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -883,6 +883,8 @@ fn try_write<T, L>(self, location: L, value: T) -> Result
     /// };
     ///
     /// register! {
+    ///     base: Region;
+    ///
     ///     VERSION(u32) @ 0x100 {
     ///         15:8 major;
     ///         7:0  minor;
@@ -1028,6 +1030,8 @@ fn write<T, L>(self, location: L, value: T)
     /// };
     ///
     /// register! {
+    ///     base: Region<0x1000>;
+    ///
     ///     VERSION(u32) @ 0x100 {
     ///         15:8 major;
     ///         7:0  minor;
diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index 6cb07fc92cc3..b0fcfce36c9c 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -13,9 +13,14 @@
 //! # Simple example
 //!
 //! ```no_run
-//! use kernel::io::register;
+//! use kernel::io::{
+//!     register,
+//!     Region,
+//! };
 //!
 //! register! {
+//!     base: Region<0x1000>;
+//!
 //!     /// Basic information about the chip.
 //!     pub BOOT_0(u32) @ 0x00000100 {
 //!         /// Vendor ID.
@@ -55,11 +60,14 @@
 //!         register,
 //!         Io,
 //!         IoLoc,
+//!         Region,
 //!     },
 //!     num::Bounded,
 //! };
-//! # use kernel::io::{Mmio, Region};
+//! # use kernel::io::Mmio;
 //! # register! {
+//! #     base: Region<0x1000>;
+//! #
 //! #     pub BOOT_0(u32) @ 0x00000100 {
 //! #         15:8 vendor_id;
 //! #         7:4 major_revision;
@@ -444,11 +452,14 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     io::{
 ///         register,
 ///         Io,
+///         Region,
 ///     },
 /// };
-/// # use kernel::io::{Mmio, Region};
+/// # use kernel::io::Mmio;
 ///
 /// register! {
+///     base: Region<0x1000>;
+///
 ///     FIXED_REG(u32) @ 0x100 {
 ///         15:8 high_byte;
 ///         7:0  low_byte;
@@ -479,9 +490,14 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 /// the context:
 ///
 /// ```no_run
-/// use kernel::io::register;
+/// use kernel::io::{
+///     register,
+///     Region,
+/// };
 ///
 /// register! {
+///     base: Region<0x1000>;
+///
 ///     /// Scratch register.
 ///     pub SCRATCH(u32) @ 0x00000200 {
 ///         31:0 value;
@@ -531,6 +547,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///
 /// ```ignore
 /// register! {
+///     ...
 ///     pub RELATIVE_REG(u32) @ Base + 0x80 {
 ///         ...
 ///     }
@@ -557,9 +574,10 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///             WithBase,
 ///         },
 ///         Io,
+///         Region,
 ///     },
 /// };
-/// # use kernel::io::{Mmio, Region};
+/// # use kernel::io::Mmio;
 ///
 /// // Type used to identify the base.
 /// pub struct CpuCtlBase;
@@ -578,6 +596,8 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///
 /// // This makes `CPU_CTL` accessible from all implementors of `RegisterBase<CpuCtlBase>`.
 /// register! {
+///     base: Region<0x1000>;
+///
 ///     /// CPU core control.
 ///     pub CPU_CTL(u32) @ CpuCtlBase + 0x10 {
 ///         0:0 start;
@@ -594,6 +614,8 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///
 /// // Aliases can also be defined for relative register.
 /// register! {
+///     base: Region<0x1000>;
+///
 ///     /// Alias to CPU core control.
 ///     pub CPU_CTL_ALIAS(u32) => CpuCtlBase + CPU_CTL {
 ///         /// Start the aliased CPU core.
@@ -636,15 +658,18 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///         register,
 ///         register::Array,
 ///         Io,
+///         Region,
 ///     },
 /// };
-/// # use kernel::io::{Mmio, Region};
+/// # use kernel::io::Mmio;
 /// # fn get_scratch_idx() -> usize {
 /// #   0x15
 /// # }
 ///
 /// // Array of 64 consecutive registers with the same layout starting at offset `0x80`.
 /// register! {
+///     base: Region<0x1000>;
+///
 ///     /// Scratch registers.
 ///     pub SCRATCH(u32)[64] @ 0x00000080 {
 ///         31:0 value;
@@ -670,6 +695,8 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 /// // Alias to a specific register in an array.
 /// // Here `SCRATCH[8]` is used to convey the firmware exit code.
 /// register! {
+///     base: Region<0x1000>;
+///
 ///     /// Firmware exit status code.
 ///     pub FIRMWARE_STATUS(u32) => SCRATCH[8] {
 ///         7:0 status;
@@ -682,6 +709,8 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 /// // Here, each of the 16 registers of the array is separated by 8 bytes, meaning that the
 /// // registers of the two declarations below are interleaved.
 /// register! {
+///     base: Region<0x1000>;
+///
 ///     /// Scratch registers bank 0.
 ///     pub SCRATCH_INTERLEAVED_0(u32)[16, stride = 8] @ 0x000000c0 {
 ///         31:0 value;
@@ -703,6 +732,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///
 /// ```ignore
 /// register! {
+///     ...
 ///     pub RELATIVE_REGISTER_ARRAY(u8)[10, stride = 4] @ Base + 0x100 {
 ///         ...
 ///     }
@@ -722,9 +752,10 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///             WithBase,
 ///         },
 ///         Io,
+///         Region,
 ///     },
 /// };
-/// # use kernel::io::{Mmio, Region};
+/// # use kernel::io::Mmio;
 /// # fn get_scratch_idx() -> usize {
 /// #   0x15
 /// # }
@@ -746,6 +777,8 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///
 /// // 64 per-cpu scratch registers, arranged as a contiguous array.
 /// register! {
+///     base: Region<0x1000>;
+///
 ///     /// Per-CPU scratch registers.
 ///     pub CPU_SCRATCH(u32)[64] @ CpuCtlBase + 0x00000080 {
 ///         31:0 value;
@@ -773,6 +806,8 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///
 /// // Alias to `SCRATCH[8]` used to convey the firmware exit code.
 /// register! {
+///     base: Region<0x1000>;
+///
 ///     /// Per-CPU firmware exit status code.
 ///     pub CPU_FIRMWARE_STATUS(u32) => CpuCtlBase + CPU_SCRATCH[8] {
 ///         7:0 status;
@@ -783,6 +818,8 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 /// // Here, each of the 16 registers of the array is separated by 8 bytes, meaning that the
 /// // registers of the two declarations below are interleaved.
 /// register! {
+///     base: Region<0x1000>;
+///
 ///     /// Scratch registers bank 0.
 ///     pub CPU_SCRATCH_INTERLEAVED_0(u32)[16, stride = 8] @ CpuCtlBase + 0x00000d00 {
 ///         31:0 value;
@@ -801,6 +838,34 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 /// ```
 #[macro_export]
 macro_rules! register {
+    // Entry point for the macro, allowing multiple registers to be defined in one call.
+    // It matches all possible register declaration patterns to dispatch them to corresponding
+    // `@reg` rule that defines a single register.
+    (
+        base: $reg_base:ty;
+        $(
+            $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
+                $([ $size:expr $(, stride = $stride:expr)? ])?
+                $(@ $($base:ident +)? $offset:literal)?
+                $(=> $alias:ident $(+ $alias_offset:ident)? $([$alias_idx:expr])? )?
+            { $($fields:tt)* }
+        )*
+    ) => {
+        const _: () = {
+            #[allow(unused)]
+            fn test_base(_: &$reg_base) {}
+        };
+
+        $(
+        $crate::register!(
+            @reg $(#[$attr])* $vis $name ($storage) $([$size $(, stride = $stride)?])?
+                $(@ $($base +)? $offset)?
+                $(=> $alias $(+ $alias_offset)? $([$alias_idx])? )?
+            { $($fields)* }
+        );
+        )*
+    };
+
     // Entry point for the macro, allowing multiple registers to be defined in one call.
     // It matches all possible register declaration patterns to dispatch them to corresponding
     // `@reg` rule that defines a single register.

-- 
2.54.0

