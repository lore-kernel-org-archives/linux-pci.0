Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022126.outbound.protection.outlook.com [52.101.101.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16965495537;
	Thu, 11 Jun 2026 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195329; cv=fail; b=mQ4jJ0eWydPm3xqdUjIucbOczKGMfRh8r+j/Xxa4fEh4BIL1crdSg5GWpNUsK8iaaOo0/oIC0C2Z80ICiuTyXdYDv9vtyAAwWIhzlCoFeLNNMfsd0gTSrlVh0aE63ra0BhUjG2LSBf2cJU8oGeloWXhoXfeSM5Z9OncvVQrZjRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195329; c=relaxed/simple;
	bh=nZ1d5/awpoVPbX/s+fSI4bB3Kv514L1v9RLCo7wUgGQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=L8UTtaOgxHZVEK/DVU1fAor9Lq2M1beA+RMGkEg4nqnYczCqZcl2z0VSBbx+U+hocwku9040MgXV7nSBDM/sEVxVK/U4SnMNwy4dBMZzKTSEgBNqQoYBg6qEGef7hgZpkqMqiBODYnZMutfUJHo+plGpaL/8l7dBFZR1VjqC7No=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=L/77gcgQ; arc=fail smtp.client-ip=52.101.101.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="L/77gcgQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUg+4fe3j6eR9BZqqxYhc7BORdKZeQKc2Cok8GQ5qSBcoK4dMxIQOfRk7XDFReNz1CftYxbZLCtueu0AyZ2rSp6NA0oj3Kn+e4ai1pUVL39YyjbF0uo2ShrgXbzB2lPc8yAHjOayeynKhlbhq9zSm2IRJARupy0EZaZzvG7ywAa/IykbPf2vvXLvXdOFFr6AzP68Bra+9kS2fg+hOV9H1tKirq2h4bUOFLKI3Pu59y1el+/OM+Z5xP3ujd07ldl1VRNPCSSoHGuhsjJGq/M1IN+HBl5GwRsELAW6Pvz8wgTQJ6E7H5hN1O4Mc9sG/Me8UlHt1jHYvVywH1srSQxzCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTtGLMvpsCIumS1SMAGZMboeYFmWAvp8G6alrtBQs54=;
 b=wCFQ4pJFBTqjsVIXQyonFPRmd2plCM0cA0x04RauF56kJn/oDGJUaCHx1V20BYDZbBnPpFSBRyHGm5LTZJEkvxd1d2KOSfOrRzttEHoXpxNDkUFLUmnw8ad1RncFmPAFLWocRxousrduGL93Gtjb8Un23STEcnnlbXPmubGi4e9fTE4xbttr0D31EvtJrocH+0JKyyNei4EQeQviCh1hB6T29kD5KDXE3W3DzcGItuJHYF3Tr1m0GTjXHTJF0EPKzyDWl6Ut72xnpIPPRRrNkYafz9YLL+TAwA0KA+1HlrUck753Mz2c9BVHxGAO5RTLh02boUN5LHWOc1VQeqLs7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTtGLMvpsCIumS1SMAGZMboeYFmWAvp8G6alrtBQs54=;
 b=L/77gcgQwfoeBvLac0EX6XW5lkORBkAQpu0PM8cC+anhH0G92rVkLGBKTdJuLk6yot3guKki7PNfnDis5e0W0lVx7Wa2XvaUvR5jeFYe5x1VrrsKLYOloJZSm+Czk2oMOS+fBZjQ7uYpOMqDXhKBwaFBImmjx19rjEYMQ7MaMmo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO4P265MB6525.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 16:28:32 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 16:28:32 +0000
From: Gary Guo <gary@garyguo.net>
Date: Thu, 11 Jun 2026 17:28:18 +0100
Subject: [PATCH v4 16/20] rust: io: add `read_val` and `write_val`
 functions on `Io`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-io_projection-v4-16-1f7224b02dcb@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781195301; l=4995;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=nZ1d5/awpoVPbX/s+fSI4bB3Kv514L1v9RLCo7wUgGQ=;
 b=Kr0ClBwFPyf7DXlVidnEzCEo7j4ylgggw49TwcWtOGvsj/aftM0jHIN6rRjIuvedNcgfiPCrX
 ikAobUMC84KC10pjpP+br/3eFAw6pQBzXxsbXaDs9lnITnJrxSDNxpx
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
X-MS-Office365-Filtering-Correlation-Id: 8b5072cf-b966-4876-16c5-08dec7d67a29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10070799003|921020|56012099006|3023799007|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lyQLSUkORkeZkmHzpij6RnAgkTM5oMXSWA7gJmY5NtLpCONyIzA8qhM662+qdHG706tk87fr9UgszvsZ9XsVstkC9inPxqInN93pmXsgIUbZNHKDGB0c/D+QIz48bjUVT6WM+ogFf2h16aLYu62zGjuYHslrjI+aOOR02tZUDBJIMuuLJKPpYX/N4F1KpyWv0LjDgCzFaIR64x4kr+GsENUWOYJyFp1flycf+jbTV6hrdtThzeGNmY8DHIgw6kdx7K1acesUY+H4vpuuJqg47jhYybdkl/2et+ZFyqdMYOJMKf0UmYJKMQooBB/u3E6fq6w3PJLfkUlLapt2T3PMqXuTcauj9QdN4fx+j+0ev8sGSnu5VaAe+EjgXH+37VXRybC6HglI0WXmjpFtmdjWL+jap+ZpM0iLonffe1IdDANy//JDTfsTeEEYS0vcW7G8K68Wma47PGjntEr9eSoTmPu5eIVHGrC4OBylokcyaxtgsrF9TiTewuvt6eogEpytHuxLPNAqOss6xoN2jluJtot6ktGfSXBgtSfYC6ciLYXx/SymfOKWnwHvUbqpgBnq4NAp4Pbi1J9gRP4zzMzya67RoCv9U3TmpDlTfCW4lZOZz2DpJAEJOPiNtzZHbz02sZqVy4fy1LVkrraQw8s2UMC6pbSBr4R3UmNphmvZghWATlQlGlxrWfHLN4uPPh4+YPC5ZS4ZreHCpOcsPoKzn3v4UkNNTUhadBEz2oPgPhs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10070799003)(921020)(56012099006)(3023799007)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDJtOGppQUVYVk84bDNjM2NUTktWL3c3K3VIdllvZGM2STdvWlJTN0p0Smov?=
 =?utf-8?B?bWtkTWRDam8zMVVYNWVRQWo5WGpvdFVPWmZPNzhYbUJRUDdyU0I3dmlMdDBy?=
 =?utf-8?B?NzhjdkhvNGwrRkltb3BTM2hkK3R2Q0RiQTlFMXNrMXFOeGhwMGVpV2FxSW51?=
 =?utf-8?B?SmtPNVIrd2dnSGx5N09uYjAvUzBjclZRT0xhQXZlamN2MFZheUxPSjdXZTlH?=
 =?utf-8?B?Q0RmUkhtL3FDZUlpelZhUVhIcUxYSGcwYUcvdW5pMjZxMW9xOHVKamdPNFF1?=
 =?utf-8?B?QTZwZ2wxY210WVBUY1FmTHpxZVRCQmVKQ2d6TDdGQW1RQzIya3Y5T2xmR0ZI?=
 =?utf-8?B?d2RmU1JzeWhSVjR2d0FoUDlMcGhzSStZV25QaUVHZ3hnT2Z4QmswcXl2anRk?=
 =?utf-8?B?dkdiQ1NKdVhJVmlKdkQ0Y0hqOThmOE0xNVlJc25YbUlSM2ZwVjRLeUFmOHNs?=
 =?utf-8?B?Vll2VDdnRGIrYUpRZHlDcWtIaEoxdXR4cFhTMEN6TW91bE43dDJhc0pJd2Iz?=
 =?utf-8?B?SU1rUjBKQzFneWd3QUJkKzFqZXVuVTVRd3VqSkRnUlY3Z3lrQnNBckR4Wlli?=
 =?utf-8?B?YjVuK2g1b3VkYythVElqMlgvTU9WaUtaNzAvSy9sWlp2QjJmWTRuYXJLRjVx?=
 =?utf-8?B?UWdVMXp4UEpGS2pGZTRQVy9Wck5yMUVkSnNoRnpHMTRVVDJENVFPRzkwR3lL?=
 =?utf-8?B?NUYzd2lLNzEybjcxd1F0NXJFRXQ0Q3U3Uk9aT1hCcGlZNmk4RS9hMUhWcDFC?=
 =?utf-8?B?eTM5TmlQeWJValV1QTFsekZXZnE1clJZdVREK0FsbWRrT0JIbFQ0UnljdmdT?=
 =?utf-8?B?c1lMSnJVeW9HeFZWUlRzZzMxL2pZTkhvc2ZPMXZVWmVnZTk0VVh4cTl1aDAw?=
 =?utf-8?B?clMxRWhpVXEreVp3ZTJrS0F4cXpMb0RaRHBQV3FpU3N6Uk1aKyt6YWE0T1VZ?=
 =?utf-8?B?a05sUXJoNVh1OCtWM1pWNzluSkdrTk1uZjNITktKYnBEUlhGbEJhNU9HS2tD?=
 =?utf-8?B?dkxudUFEallMM1Q2YWJRcjRaMXVJNndzeU1xTWpPNGpmUTZWV3ozSlpEaGtP?=
 =?utf-8?B?eE9CVitWZEZPNytuWVBFQk8yZ0x2VHdkU2lxTUJISE5uNGFneHFXTGJ3RmEy?=
 =?utf-8?B?NCs3dVI0cU5KdjBoQlVadUZMNWtRYWlYUEZxajFyck1lUjV0WFhoVFV3VjNk?=
 =?utf-8?B?dFIvTFdLWGYwQ0ZuZjR4eWt5RWg3QXBiT1FtZG9JNC84WElJaEpoSnVZclZM?=
 =?utf-8?B?bTFBMTlHNnpvMFJjWWRoSmg5aEsvbVB0ZXBBVFo1Yjc1ZDZCMG1tUmdjeXl4?=
 =?utf-8?B?cmsrVG15Nk1TTEx4OWsvZnZsOCtIQmRFekxROEtFaGE1VlVpYjBURlowbm0x?=
 =?utf-8?B?OEdlWEV6QTd5MlZXTmxLd1ViM2RZMmxNMkNHZjdLa2xzTHFwTXhmY3JwRG90?=
 =?utf-8?B?N3FFb2xabHJxcFM0OW83U3JqUjJRbkxYamxaY1hmdDBjdko4NDFmOGtFRllp?=
 =?utf-8?B?MXpSbm5RUzl2ZXI5NlY0T3JheWlZdmZrUjhvb1FKTjB6MWJSVkkwNlpHZFNU?=
 =?utf-8?B?bVByV3UraTgxUmRuVEVLR04zWURHOHdhRXZaNGFVOVJnOFUvNmVRTUEyZk94?=
 =?utf-8?B?VGhpY0hDNTFQeVhvME4wZDZvZFNWMUlLTjYvcG5qY3ZFWmtRMGRZU2pDQ1F2?=
 =?utf-8?B?TkdPRGdjZVVibHZhTExJbnpJWXEySGp5NWxlUzhKd0hRZnE5cklxYWRzdE9h?=
 =?utf-8?B?VXBURHVaVlpnclc2TFB2Mit1N0FyeGJscitJc0FyVFFDWHlvdURUcVFKOG1R?=
 =?utf-8?B?MEV3R2pONkt3bkNXcmNYUDB4ampsRjJrejN2dndNaU1FcU5NeFdTOUFNVS9Z?=
 =?utf-8?B?bWREYTI3TWUycTNicDdZZkpJM0t4T2FwSkozRzJQUEl1Tk5ZSnI1QXU0bkNn?=
 =?utf-8?B?bXVVWW1OQzRTVHRVWXZvZVJPWlkyclpYcFFveEQwZE1qZTZEU2ppU3VTdjJU?=
 =?utf-8?B?Y1B6RjBFM0NOUXJ3UDNOaTExUFgyVWhYdTYzUmlzNTh1eDlrYmZPWUZLQWZy?=
 =?utf-8?B?a3A0aFBycVVabUhOczVuVW50RE95QjVZWGVRWmZFblArejRvRDVDZWJHWC9V?=
 =?utf-8?B?MXV6aFd3Zk13ZGtYcmV0eGdrQjZ5OXZQOW84S0FIQlBEbXV0TjRlcmlGWTBs?=
 =?utf-8?B?a2lrd2YxYy9nbUxQbkxRVzl2Ky9tMGlCTkNSdldITWJmVlRmVmtwRXg0aWJp?=
 =?utf-8?B?ZWpjRythd3cra0Fxamd4bWdzTUpsMk16TUFLTm9ZUnpDNzJ5TUFqMHE5QzhB?=
 =?utf-8?B?cUppR3FJRUdCbktSR0JMclJnbmVrNlhBaWUxM3pEblFKWXJkWTRPdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5072cf-b966-4876-16c5-08dec7d67a29
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:28:32.0597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyhjiX+bnVuqQFyHcxEBpPj2OQuxZB9djiAJleF6C0+v+xe6NhUx8i5Wod2irxBRPMrNZdHF39UOpMXVPq8elQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6525

Provide `read_val` and `write_val` that allow I/O views to be accessed when
they're narrowed down to just views of primitives.

This is used to provide `io_read!` and `io_write!` macros, which are
generalized version of current `dma_read!` and `dma_write!` macro that work
for all types that implement `Io`.

Note though `io_read!` and `io_write!` only works if backend implements
`IoCapable` for the type; which is typically only implemented for
atomically accessible primitives. `dma_read!` and `dma_write!` currently
supports them via `read_volatile` and `write_volatile`; this can be
undesirable for aggregates as LLVM may turn them to multiple instructions
to access parts and re-assemble, even if they could be combined to a single
instruction. Thus, `io_read!()` and `io_write!()` does not fully replace
`dma_read!()` and `dma_write!()` in this scenario. The ability to
read/write aggregates (when atomicity is of no concern) is better served
with copying primitives (e.g. memcpy_{from,to}io).

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index a418c8cbb031..f64ca2202ff2 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -347,6 +347,50 @@ fn try_cast<U>(self) -> Result<<Self::Backend as IoBackend>::View<'a, U>>
         Ok(unsafe { Self::Backend::project_view(view, ptr.cast()) })
     }
 
+    /// Read a value from I/O.
+    ///
+    /// This only works for primitives supported by the I/O backend.
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// # use kernel::io::*;
+    /// # fn test_read_val(mmio: Mmio<'_, u32>) {
+    /// // let mmio: Mmio<'_, u32>;
+    /// let val: u32 = mmio.read_val();
+    /// # }
+    /// ```
+    #[inline]
+    fn read_val(self) -> Self::Target
+    where
+        Self::Backend: IoCapable<Self::Target>,
+        Self::Target: Sized,
+    {
+        Self::Backend::io_read(self.as_view())
+    }
+
+    /// Write a value to I/O.
+    ///
+    /// This only works for primitives supported by the I/O backend.
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// # use kernel::io::*;
+    /// # fn test_write_val(mmio: Mmio<'_, u32>) {
+    /// // let mmio: Mmio<'_, u32>;
+    /// mmio.write_val(1u32);
+    /// # }
+    /// ```
+    #[inline]
+    fn write_val(self, value: Self::Target)
+    where
+        Self::Backend: IoCapable<Self::Target>,
+        Self::Target: Sized,
+    {
+        Self::Backend::io_write(self.as_view(), value)
+    }
+
     /// Returns a view for a given `offset`, performing compile-time bound checks.
     // Always inline to optimize out error path of `build_assert`.
     #[inline(always)]
@@ -1232,3 +1276,63 @@ macro_rules! io_project {
 }
 #[doc(inline)]
 pub use crate::io_project;
+
+/// Read from I/O memory.
+///
+/// The syntax is of form `io_read!(io, proj)` where `io` is an expression to a type that
+/// implements [`Io`] and `proj` is a [projection specification](kernel::ptr::project!).
+///
+/// # Examples
+///
+/// ```
+/// struct MyStruct { field: u32, }
+///
+/// # fn test(mmio: kernel::io::Mmio<'_, [MyStruct]>) -> Result {
+/// // let mmio: Mmio<'_, [MyStruct]>;
+/// let field: u32 = kernel::io::io_read!(mmio, [try: 2].field);
+/// # Ok::<(), Error>(()) }
+/// ```
+#[macro_export]
+#[doc(hidden)]
+macro_rules! io_read {
+    ($io:expr, $($proj:tt)*) => {
+        $crate::io::Io::read_val($crate::io_project!($io, $($proj)*))
+    };
+}
+#[doc(inline)]
+pub use crate::io_read;
+
+/// Writes to I/O memory.
+///
+/// The syntax is of form `io_write!(io, proj, val)` where `io` is an expression to a type that
+/// implements [`Io`] and `proj` is a [projection specification](kernel::ptr::project!),
+/// and `val` is the value to be written to the projected location.
+///
+/// # Examples
+///
+/// ```
+/// struct MyStruct { field: u32, }
+///
+/// # fn test(mmio: kernel::io::Mmio<'_, [MyStruct]>) -> Result {
+/// // let mmio: Mmio<'_, [MyStruct]>;
+/// kernel::io::io_write!(mmio, [try: 2].field, 10);
+/// # Ok::<(), Error>(()) }
+/// ```
+#[macro_export]
+#[doc(hidden)]
+macro_rules! io_write {
+    (@parse [$io:expr] [$($proj:tt)*] [, $val:expr]) => {
+        $crate::io::Io::write_val($crate::io_project!($io, $($proj)*), $val)
+    };
+    (@parse [$io:expr] [$($proj:tt)*] [.$field:tt $($rest:tt)*]) => {
+        $crate::io_write!(@parse [$io] [$($proj)* .$field] [$($rest)*])
+    };
+    (@parse [$io:expr] [$($proj:tt)*] [[$flavor:ident: $index:expr] $($rest:tt)*]) => {
+        $crate::io_write!(@parse [$io] [$($proj)* [$flavor: $index]] [$($rest)*])
+    };
+    ($io:expr, $($rest:tt)*) => {
+        $crate::io_write!(@parse [$io] [] [$($rest)*])
+    };
+}
+#[doc(inline)]
+pub use crate::io_write;

-- 
2.54.0

