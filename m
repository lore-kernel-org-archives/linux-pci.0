Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020080.outbound.protection.outlook.com [52.101.196.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840B13F39E5;
	Mon,  8 Jun 2026 19:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948777; cv=fail; b=PhpOjItHILSh3XNU/5IQ0TWEe0fQ4xX95/gC3A4QkgrCNESifeXMFWoouISFEZkk/BEnD4QXLP/cx8Nvfy5YpsJzs7KbcHHt1SBJ0tEqkWv0KV8Xyj5k9erw/TPdME2R0fp6JtTUqqelafjjir7i0g/Yw4qGOmQg6qxKl+uutks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948777; c=relaxed/simple;
	bh=2reHlWNqXZ1I2nXvOoGdiIWe017bHX3+8mpgOeI2sVI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZqxoytYhWewydn2hjuCOufm/7K8RhKXrTxS1xX0OljKjsUZWoPA39JD8UeItdi6Q7rjqxp8bUxhBIEY5sElhAiHKZO3hiTxCbmAoijCzPb5Rb+dGB6INCStVVmPeybEPuh2bNojq6zs8UrqmOGZhSliye6w5SltVCECsZKDUsiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=J/NGqaBd; arc=fail smtp.client-ip=52.101.196.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="J/NGqaBd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6ZCN+2sqKzu7fbbeyJn3SUW7myku3V4LP8WLGBSL55Nx0njCt5RayFoQ2KEsVfayDzzXwZLPIRgXLKFs9SEXF7arGDA/viri8L5jlKrqg/GfFmqp1IQrCjNgPGRNSJWpeovRQ4Ro7OieUulhOr1aMmBxgKrOS2YiarjoWhqAZRrc3u2An8WSuGh4oDw9vQ5XGAl1o4VAoXVjZvVaPFd+wY+kkZGcMXkIw+yXm/wC00OgYVhqcnSIJNXOCBLuWLy8OWOA9mB7yV4+htF748ekIUkee+L7njdU9Aa21DVKtyoUieRxpAqxZoQTYtNSkgpwgY60U9Z6vJ93kWNBQ2CWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhjW1NSoebyE/bs8Vx2O/rQlrwNytPj9LNyoNRD++Us=;
 b=DymYWiUHyJnLQRALJaE15FNGEMIo5nnwDy4Z8z5RiWQzKaOK7VihOaIPp4TPH4XGayg2/BINYf6YqUFhEaNfPu/B03q+89so/M1t2GQwxsey0H1ug8wB81XHgUBHPvHsiohQiNbxS4f2X7MFEZgkloklb+RGY77TqD8bR3LTL27i1JvLzDDEIhrRNOvY00dOECB+DUDSpB/Ek3XVOXWxRSbievYXa84OwRwNIgWRheIkIBC7DhxnCFNH4weGN7yI1YlpW1LGxTHb6p3gF+rEp3hBY5pONid7isG4HAutZMQAIIqj5HAUuS8EA/Lj7b9swhap8f8MRnIWjMjpN9yMIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhjW1NSoebyE/bs8Vx2O/rQlrwNytPj9LNyoNRD++Us=;
 b=J/NGqaBdC49+hT0CaN/yzuUTTwQJMl2YPaGk48afRW27/20K0or9XVpCRHH4kuWT3r7D8M5lv0tIXmO19HsKqZrpu5QYjYAnqYIlmcc4LDV0a1sxUjSSiV2ut2YWAtn7zxnyuJTfhc9PyY4/OAfFxNRShtbB+Snmv8g9yoTbOUs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7398.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 19:59:14 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 19:59:14 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 08 Jun 2026 20:59:12 +0100
Subject: [PATCH v3 15/19] rust: io: add `read_val` and `write_val` function
 on `Io`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-io_projection-v3-15-c5cde13a5ec4@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780948747; l=5545;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=2reHlWNqXZ1I2nXvOoGdiIWe017bHX3+8mpgOeI2sVI=;
 b=INSbpiXpPLvYgD6Cr3IvrSQ/PGjB6wnXUjSsZmnlk0Xm8Zh31rwxhlh9F+G/OoUpipGbtsK+H
 ye4tyUyxqxxCfqlwNq1K+TP9S7SVq8+63iXsE9D16UJtScAHKFfQMNO
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
X-MS-Office365-Filtering-Correlation-Id: c592f6f6-7e5d-471b-3fcf-08dec5986a21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|6133799003|22082099003|18002099003|921020|3023799007|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	P5eEBJ4Dlk0R3SxIZLzQz0dx2JejvPaxOnPIYR++AmmJoVgwPNb6/PjxoG6JBYbbOOMvCz/BRoSUJkkKvLgFomShQlPKtR8EwCvfkzh6di5mdD1+B6i+aAGnSTMOY+JKEWZyFKIJDuuuuoTdfARDUg4TiO2k11V4f/0ZjQq3vfYXSNX8ic5WH2j4bG/aqpokO0RNXubd7J+8Vh2Zh3Sof8rm788WChSe7tQSPHx3k42/PriZwcH/rb9/aZIoyBJPngTiNWjGVFerPJw/DQjb9+TtPQdFInXnrLbLcul3Apslemu7peIZ8wUBKV2goDVwQHMmLDrGZJcoSj5k7R6K72ELvvRYV/pC390vv9Xr1WVNqxsQ8QtyzxdSNZoPX47QLTDUjFqQhm5B2SAdpN/OWIX/be54ODfn9CtxLqFhx/tTHH39CMqUwMX5QlKS6G1BZL+f162lEsgOUn8x37WN56qym6MuoxJ03inDDNPRZaXfzG2AImtiXcmYq00kw3EGEE3OfAwNRXHE6DvbO4d3MFdmLpMtPz51uzog813ZlF9fKG9p7Le3xAJknigDRYBy6MFGFpJMPPV6KMohTpiFl0TW53f/Y8xh5xCYdY2CHt/m6uzRSxE4Hme2zP/pvRUK0c4NyjnUf3xWNwyxo9GKSEIWYgsvBbKb26aHnmLuo836Sr/Uenrh9FWtzZILk53O8sUCk69YERyeutAwNjELtObbqgvZmCR4FzGIN9oSB44=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(6133799003)(22082099003)(18002099003)(921020)(3023799007)(56012099006)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUJ1QW5kMTRQcEN3UFF4L1lTb2gwSXFpYlkydEpQRXdEalRrbm1YRnlYbkNj?=
 =?utf-8?B?ZHJyNDRGbFAyQnJUa2VNOWdMOFNrbDB0V3czd09XcCt2VEd3T2Jzdi9pWmQw?=
 =?utf-8?B?L3VEbTF1QnY2RjZOZUNGSTlYeHpaVy9XNTBXdzV1TnhFRFdIZ0hnWEhLQjB5?=
 =?utf-8?B?eEdZdUd3cEphbXpjclJkalNYOCtCaC9VK0xJZThGRXUrZ3hlZnpERnUvNUFN?=
 =?utf-8?B?TlM2MmVMUWVPK0VLK2syNmFUdEVoRW9sRHJnbUpPaURZODROWUIxb3Q1TUNr?=
 =?utf-8?B?U2loSGJzTUJ0d0Q4c1NRbTFvZDlXVHNadW84L3kzK1ZKSFh3L2hKalQ3bU9V?=
 =?utf-8?B?QkhQaHM2azNhWW9MemFYNlA2TUNMQkxLdnBKWFFpOElaekxBV2xILzlmK3NC?=
 =?utf-8?B?VTZxL1RVazRlVXZSaEtRakF2Q2NpeDFnUjlSVHpaWFc4NVo5c3kyRjNydUZU?=
 =?utf-8?B?ZG1jOW55TWQvR3J4OVJEMkpKdVF5TEc4T0ZYTDM2OWdWSE9LSkdjL0Zlc1cx?=
 =?utf-8?B?N0JBWDJJQmtCZFA0dnc4ZkVIcHZGNDJpT0lzdUZaSmI5cVozTGdLbmxOeXdy?=
 =?utf-8?B?UWs5eS9uYzlHV0Y3TjhYR2J4OXNJRVNIcjZDaGE2ajNmWjlpM3BiREdxS09D?=
 =?utf-8?B?NC9lRlJYZzZpOWlkaHVGY2hMcTJkZXVHQWVaemxEV05JcUFMVmJ2OGg4cnBh?=
 =?utf-8?B?SEI4OTVXcCtOODBWNlFHNEhIK2NmODBybnl2ejJWRmt4Y0l0UGRrZkVLYWRL?=
 =?utf-8?B?RW40YThoRm1UcnlQVXBncXBrTk5xaWVJVGl6R3pGYWgxYkhsWFE2WmtuTEM5?=
 =?utf-8?B?a1B4c0NaSmowdWhIWDJ6aUt4NHZ1M3VGV1ltUFdVZ2JybStaVmZ5NTdtOFc4?=
 =?utf-8?B?cXBnbHJlU0hzVVlJaUt4VkFxNm4wbWo5RVRsOHR2OHVsb3piVUNBekRlL0ZB?=
 =?utf-8?B?MVFWQ3NyOG9FTGhiaFVSaEplYmZOUnNoMC95QUk1VC9jWEMwU0UydmhySUUz?=
 =?utf-8?B?WnEzc1FCMEJ0eTJreksyQ3BuUTdRbG96V1FzbVZMZjJESjlnSUpCUWtKTFQr?=
 =?utf-8?B?eG9QUjFCOU9heWxLU2xyYnlpMzFsNmZyWnR1YjNTRU0xVzg2WXN2VHZmdFly?=
 =?utf-8?B?eUNZZ0FKdEI1cDNybUJ0TjhKYjBaQ09TTmhLZWt3MHZBSHdqRWJFSjlVOU80?=
 =?utf-8?B?TFVLWmI1UGprbGJnUDB0K1RsT2Y0cnpqQm0rVTNBS1BmeStSWmpnOVkwYm4x?=
 =?utf-8?B?STBxcC9JSXkxQzY2Wkhxamd6NUNtSGVxWERmVEJtWGxwaGVrK3hyd0c0QzRL?=
 =?utf-8?B?elZjN2Z4Y1FXYS9JaDR1bFE0Z05sK0ZLNWpIcVRhV3pSaTd4R2VieXd6TVY5?=
 =?utf-8?B?QTdlR1VmTVEvdWJKdVZSUDFpazIvNG9PMkl0amVuREt4dk5FM2NLdUo3VG8w?=
 =?utf-8?B?MjRXOTIwa3IyZVFOcEZTWFhPVndFeTBzaHROT2FoOUJhYmNnMWZiWDhZdXgv?=
 =?utf-8?B?RFgybkNBZENuaEJwYmR2NXRFUWhQbWZxNitGR0RQWWxYbTEvRHpFV0ZIbVE5?=
 =?utf-8?B?OGlSbEZaa3l0RHJQYTBMbG5kajVoK1ArR0NEQjVTaVVzSlBZNmJhdUVnZTQz?=
 =?utf-8?B?WUlQci9HRENjZnNFWjc0bkMzSW5tQXRRYUJocERGWW5PbWVmTVFKdTBqV0Q5?=
 =?utf-8?B?Rm9pMjdkK250YlgzQjV1a2swNExBZHF1akVVMXZWMWRmRG9UZzE4bUpRbGR2?=
 =?utf-8?B?eFhrYTRmMkVGVGVINTdKbEg1SnViNEIvRlMvQ0trVjNvS0JHQ2dKVS9DVTVa?=
 =?utf-8?B?SkFqQ1l1MmFPRWh2T0Z2ZmhGcEtEYzM0Y05iNE5zUVZ2d3FvVk5vcG13K0FX?=
 =?utf-8?B?U3dnMzhjZjRoOFBvaitGaERTd0JRZjJiZ1FQVm5WeVUvYXIyTjJyZmVNVDly?=
 =?utf-8?B?TEoyWCt2VEhiVGZ2QVBmQlpFMzZBUVNPYVQ1VkVEYnNLZlVZa0pDcVA0SC9k?=
 =?utf-8?B?d3ZrUEd3S0ZWKy9wRlZXUzc5VFpFV3hwcWtZUitzQmJFcXVKdVJldE9ydFNv?=
 =?utf-8?B?MERLNDdZdnlaVmQxQ2RacU43MkIvbXh2TTB3WkIxdzVIdFRRVFBSZzVnYzlG?=
 =?utf-8?B?UU1hTkpYTDA3ZGxXWkpQWDR1TnN1QWkwYW1TTWx2bkUyNUpoVC9WVW4yWmV3?=
 =?utf-8?B?V0dxQ3hYZXhLSmE5cE1OSDV1dHhoZURWbFFNZ00wci84ZWxLWVN4Y0s5anV5?=
 =?utf-8?B?N1BpSGdRdXZuTm9ER2lQZUNhU2ZienlMS1dEVldTMG5DVE1HZ3EwSTJXbFYx?=
 =?utf-8?B?bXNzajFXcklZZ09jTU9EUGxlTXllRFR1VzhXb2huYnphZS8rNWM4UT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c592f6f6-7e5d-471b-3fcf-08dec5986a21
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 19:59:14.0240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqiNg15VhO2BeAXApMPBJ1c1VEnTwPdFmWFVnWqb5GRe9Yl7nyufDx6T4QGnPwdI2rW1OaIRoVr7RkgypsmbWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7398

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
 rust/kernel/io.rs | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 580ca88c46cc..72f3acc0f50d 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -353,6 +353,50 @@ fn try_cast<U>(self) -> Result<<Self::Backend as IoBackend>::View<'a, U>>
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
@@ -1228,3 +1272,73 @@ macro_rules! io_project {
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
+/// // SAFETY: All bit patterns are acceptable values for `MyStruct`.
+/// unsafe impl kernel::transmute::FromBytes for MyStruct{};
+/// // SAFETY: Instances of `MyStruct` have no uninitialized portions.
+/// unsafe impl kernel::transmute::AsBytes for MyStruct{};
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
+/// // SAFETY: All bit patterns are acceptable values for `MyStruct`.
+/// unsafe impl kernel::transmute::FromBytes for MyStruct{};
+/// // SAFETY: Instances of `MyStruct` have no uninitialized portions.
+/// unsafe impl kernel::transmute::AsBytes for MyStruct{};
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

