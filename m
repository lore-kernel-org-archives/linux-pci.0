Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020089.outbound.protection.outlook.com [52.101.196.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A19483BF2;
	Tue,  1 Sep 2026 16:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281444; cv=fail; b=Y5Ams3kvbZIjEi7/igOedcJDwuXswqb8pcoR/oZQLveJtNjiQv4y0cE+X6PMKzyJ5cJfcJlClbfooX1ZB8UdW3LvAzXS77qJe9RSRMkzZjLAyyz9Zn1b+kpewAyZdGHE8AU5aFiJpTM9CP2h2JPgvgA/e8CiVvfktEWhen5ROGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281444; c=relaxed/simple;
	bh=aqM1m8hQVBQcfuLUtUp2YErCndlB9UHKXD3Qyyki3X0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WX/VVh5OnbjEZIKe3DOjCp5M9sY40y6PB8CZb/kEXa8vIPF+MoXLVN85NyHBnFN5k4Bx14DMhE3yZpVEY2o4HLEGExtUFwg+9UdAphQHEOnUNAHxI2azFwtyp/8k4mcgH852/oz7W45JLAczvedhmmn96RMsQTAqdlPYe6/DEfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=SOHoEwq8; arc=fail smtp.client-ip=52.101.196.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="SOHoEwq8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKIsAk9ZbaU/7G2lApYykoq+BCVINm1rMpOsI7ZJDusqWkVGUlmL/sLSpnlNOcTM6uPqH5IpX4OU9X1qKNL13se4CfLuNK8pe2o81gDJmo0rEuB537OL5Fa7bhYoQ0UxN4ln9OdAO/1KvIHPAOflEIE5sRL/MTCUYKIfuE/fmag1MENl76Z72gRoAi36VmaEp3cqxJYj8gxFiut97H206Kq4WISEnibbdMZS4GXDr3hvH/dAgSRFilkS4GFi5BzqVZTQdxy3C6RW8pQ7TCoSw9lYCY6lwk0e0Tlz3J6Yav77HYG898NdbDzRphowMQuYGOEcPqshGxSIpKNuv9WYzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LIgUQ0Lq8xjNZ53P0UEI58qk7Zc3xSvgVWc9JA3104=;
 b=rdRvGCagnZmzO82qSasZMQwn+pWawA1tLow81rAxzZDwHUk+UW2IGgqHII7pKKKZsPRfV7wi+Fj6Bpq4KZ5RqqgL6Z4IY4MoVC5rx+QrQbI9lOM31qKwo9auZbLAgLv/T0XCV2QeKNvOcdUjXXtFJUAeIBkVMMj5LwulZQHxGLL7y6jag3LI4hQYU4UFA+ll79+WRMVKBBDSdPPuRfvUjaKb0bt2vFZSApgSWNwqNy4eABCPNdMCUmlFwO4i2QsBoS/3eNIN0JWDHq8ytSM+WqVsiunsX9DISHnMyU1KWuLFTi0K4Pbw4b5CrzDeY47e3BacknXb0jAgv0Oc5xInKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LIgUQ0Lq8xjNZ53P0UEI58qk7Zc3xSvgVWc9JA3104=;
 b=SOHoEwq8wTzcO0q+2kl61gVgKzaME7WAm0U0ocdel/CmP84P6Rol4h/4mEB7S7Qj42u8fnPCSfuZbrFT/gqcvjGInEpTgzytogz9CjspFR70CetKOVP+6GHocO0eQIyzdcfQAnmXG+hNsqP4fYWq42i2yRU48me1fhwajO7lTHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO0P265MB7316.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ef::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 16:50:35 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 16:50:35 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 01 Sep 2026 17:50:27 +0100
Subject: [PATCH v4 03/16] rust: mem: add `AsRepr` and `AsReprMut`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-typed_register-v4-3-5552b1d59525@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788281431; l=6839;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=aqM1m8hQVBQcfuLUtUp2YErCndlB9UHKXD3Qyyki3X0=;
 b=enlmFjuj+HDXPvXRhhJv3ET7jkW9NEJzhAbRX6Kuy55iCm4ZJ6qZ+7W/khraQMtw/YboG3onn
 dN22aHbn6dEBaecVUk3QbZ6s62Z+Vx8zuUTzZhWR1AqeLsmfTbKM7DV
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
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO0P265MB7316:EE_
X-MS-Office365-Filtering-Correlation-Id: f3b5ef96-960c-439d-df8f-08df08492495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|10070799003|376014|7416014|10067099003|6133799003|22082099003|56012099006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	ApGvS0sXhGTZNZI29jPsMFXuEpurZ3CNR3qp8UHrTXYHyaIVArZ4Sg8tMqVL195V6WqsHrCkBvP9kH3R67T4ybjJsaWUVqbnsiJ85d81OZ04TFfMQFTl4GUbbaxpTrbNCA/6daDFmUpXdfGDKAeaTyfjGmVm9+EjvwYEoRt+aNpjPYMO7v5kstKUqMqD1d4GoQCciDH6Pr6Qwx5JWIvJElFyEvmp0Q14qnockQqreR2rjOCYA+uTSDAs6teTlT8qvZhqPw8QjwgQiOK5tXt/GjpiraiHdnfxVFD5udtgRZTjARg/arwliEDmgxYWcdnHn0gsDnGtlFFEmSOPVXp0C6W1FPE0ACf+6aflhyjxuirxvEr+OeZNeiQnCCL1VEWQWXo1AsKMj6fuIK9nd7WSxo9ClcRmn67BXocLY0OgsigIWTUxO7ZniSgEyVHtR6RZ16/o0PX4EyOiwe9OkAWibxrFMVL6BL6/uSG3XT++6gtLeQjQ9Ca67WrlpkV5NqfRMDDKwdNlmczLvCTu7vtEef6PPtIdsT7iskOcA7Wl9TiMQU39YFZnxx1PyYcIpvlCH0mA6maNHCaOEmkxUQUP3RdX3UFphfzjuRjWrGRargdyywJcZzwAdpHiuJK7NC6tqdn/QVlZ5ZnnGRgUnuniAx9Q31zrZJg8LqCm9hTAi0a6nRISsC3jUbU/8SKbWwHEnvpVBQ1Lj8fdWCanSrNOyw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(376014)(7416014)(10067099003)(6133799003)(22082099003)(56012099006)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a290RmdYSTNISnRGMmpITTcwNysveFM2TVNnUHRkR1RyNlNnclkvVHNidGh0?=
 =?utf-8?B?aFovMW5FaU4xVDllYjZ1Q2ExUVg1WGdVVldRZkduTlVHWkEvajBPRFdMTkIr?=
 =?utf-8?B?cUJtRnVxOWVLcnlJYkE5QStYaXpmOW1oTnpxSVFRSnoxOFpPQlE5L2NhS01X?=
 =?utf-8?B?ZjVQSTJGVzFQRkxtUi8yYnRwMWI4UG9GcDhQWjhtWnZWcTV0dEFZcG5TRExn?=
 =?utf-8?B?WDNIVDNDU2dkWTZUL3VkVFFtZFg3cHR0OVV0NC94TW5ZRmJ5SjJ5OVJ5VDRW?=
 =?utf-8?B?dUZHVkI4dnU5YlQ3czdmM2tpU2xXaEIxdlVuNXM2djlmcXk5ZnhWL2xGTHln?=
 =?utf-8?B?L1hVaFZVWm5rTURjWVA2aS8rUlFSY2F0bEZNcnhuRzZod3l2ODV1a3pHdFE3?=
 =?utf-8?B?Y1hOWStPYXErVW1tWUd5QTQ4K1dCNmJwZlU0UGlqczhNd0I4b3l1WUdtc1g3?=
 =?utf-8?B?eWo5WU9zQ0ZrN095a2laY2lvQzU3VldEcDFqeWxkOE9xclllc2hnd21wMG0y?=
 =?utf-8?B?KzFkamFXLzliQUdzVmJKNjFsREYwdzRnck5ibXhqOFhMMXNWZVpQejBCazdX?=
 =?utf-8?B?b2U0M1M5WDJiUW5MTlpXRC9PR1dUS3pSQVdIWkJYYmlPY0wxNWgzWVpUdkVm?=
 =?utf-8?B?SW12SDNnUVV4OUNUSVhKNEtNTFgwVnI5ckF4aW51WmduYWJDam90eFJWV2dy?=
 =?utf-8?B?VllrUHBQL1dXRHRTZit2RUFiSnBIYWUxcGxOdUQ1TVNDZytuK2p6MUNUYzRw?=
 =?utf-8?B?WkowbnFFeGJ1STdNMmtSRE55UkNST2FwU2orN3lKTEhzVmRyc1NiVFkrdWhK?=
 =?utf-8?B?bTNONGxSV0xaR0lVSGJzSkwrTVZFVVo0aGRGNHR4NTN3NG1jT0ErVmwwaW9N?=
 =?utf-8?B?UVRLSjB4bG12ZC9GT25YR3h4cUJyaCtTT0YwbEU1cnJQbnlaWGxURFdNOXY1?=
 =?utf-8?B?SWVieWc1V2dDRDAvcWdxN0VoMmJUNlM5Y3BtSWViWVZMUms5eFVsMlA3RnE3?=
 =?utf-8?B?MEprRzcrOGM0QkYvcHY1V2h4d1hGVThGTmdVUVVVK1NrazlrK3d5dUU2V1lV?=
 =?utf-8?B?ZmN5NzlkSzkwYUNBT2p4dmZaMDcyWkdzZW5lWmtWN2V5Z2cvTXJQYzIzWmhS?=
 =?utf-8?B?MnA3SzMvL0l1ODl0RDZBTjJvMElxUU8xZE5HMGFzZ2RLQkhLNjZEbWRZUnhD?=
 =?utf-8?B?bEUrYnB2K0dOVEhzYWxDV0RuMnFHaStUekNWMWdoSHVnbDRxWHp1N1VSUTVp?=
 =?utf-8?B?dFY4WDZaeFJUdm5OZU1nekdnUUlwdjlhL1lVMEpCanlTQ2xZbmtYbnQ1Nmpk?=
 =?utf-8?B?NEFQamZBRnBjMHRwTDgvNTdLOFZnd05zRzhWMEdRTWJxVXkrNktLNXhRd1Er?=
 =?utf-8?B?bnNxLzhwd01RZWxJNklHVkc2N1ZCb2VsdjU0Si9WVjRxeFFpdHQrQk95VE8x?=
 =?utf-8?B?RmRxaXpiUXpCTjJDUmh3dTdNVml5M3J6dm1Ma0lXTUNqUS9JRS92YXdiK0pl?=
 =?utf-8?B?c0dUbzlKZ0NnclkzdjVoa0VCNkhHZkFjNjhwcW5tVzNmKzUyMzJ3TVdvYkVp?=
 =?utf-8?B?Z0Z5cnRpWngzeFhBaUhHZm1ZZ1pWanZRa2p2WC9NSjJlSEVBU25Tc1VHaHhk?=
 =?utf-8?B?ckZreTNjS2YwNlJIV3hFdmI0eEN6OU1oSms3RTV6OVRsVG5zUGZ3MVJ6aWJP?=
 =?utf-8?B?djNBT05IUmQ3MWg3dGxrMy9JMUk5OVl2NXoxYVJNQWpXakl0Njhoc3NIM1NP?=
 =?utf-8?B?UHgzRDFVRW5XNXlWWmpVenlyL1VpMlFwTmtFbEFpY1VMc2JVSVZjUGVZdmdF?=
 =?utf-8?B?dzNJb3BTZ1VMM2lNZEZGelkwTko5bEJkOHIzL1ArWEJVMlVsM2FaQms5aFZy?=
 =?utf-8?B?OE1oam94Wi9PWnh2N3FyMGhNek5VeWttWjRRaEhWczBIamtMaGJvaHUvOTJt?=
 =?utf-8?B?dGo4enlzSHNMVWZqTEVsNVFjK0lqdlQzbnhYWTF4bHNNMWRHK0tTQi9YbTJ4?=
 =?utf-8?B?dy83OC96N1ltZHRnU2tkN0FQMGF0K1pyc3huZXhNamxVaFErNWRFUzZFUzZM?=
 =?utf-8?B?dUFIOUZQamxnbHNFWEJQYlQ2c000c1lTdHhHZHlZa2ZidzdxaCs1YlMxSGFr?=
 =?utf-8?B?Y3MxY2lNSFhNUUZqK0t2OEJwR2dLRVkwdHNtVkR1b1JnUDdDK2hHb0gyaWdI?=
 =?utf-8?B?UEdwTEp1R3lzM2RmbWpDUWhFVXhtZmR6Yno4TWE5OGFFc0FORlE3MFNkWEpJ?=
 =?utf-8?B?QjhYSkpHM3FIdTlKVmc4OThBQzFhRlg5YjFOYnNkdkdkV3kyVEVpMnBsNERH?=
 =?utf-8?B?SUVZL1ArY0VITFpLYU5HZWdPSHl3enNTYzI2dkVRSHZWV3Z5bWVMZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b5ef96-960c-439d-df8f-08df08492495
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 16:50:34.9904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbR3wIuREzRA1bxNhtdNCuSc+pw981etpsR8CeUmlaOSVyzqBRLbApVngmem/uPWISMYle0oU3lq4n0zEJZ6yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB7316

Some API like atomics and I/O operate on primitives only; therefore other
types would need to converted to these primitive first. Add two traits
`AsRepr` and `AsReprMut` to indicate that the type can be turned into a
primitive for these operations.

`T: AsRepr` means that `&T` can be viewed as `&T::Repr` and thus it needs
to support transmutability in one direction. `T: AsReprMut` means that
`&mut T` can be viewed as `&mut T::Repr` and thus it needs to support
bi-directional transmutability.

To avoid duplicating implementations, all repr types are normalized to
unsigned integers.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
Changes since v3:
- Added `as_repr` and `as_repr_mut` so the name makes sense (Alex).
  I did not add `Copy` bound because it is not necessary (adding it won't
  simplify the implementation without also requring `Self: Copy`, which I
  don't want to add).

- Dropped round-trip transmutability as a concept, as it can be proved
  correct because `from_repr_unchecked(into_repr(v))` is basically just
  `move v`.

  Even for the `AtomicType`'s use case where copies are made, it can still
  be proven by observing that `from_repr_unchecked(copy into_repr(v))` is
  not distinguishable from `from_repr_unchecked(into_repr(copy v))`.
---
 rust/kernel/mem.rs | 132 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/rust/kernel/mem.rs b/rust/kernel/mem.rs
index 958e43bbcc3a..0bfd6929ae45 100644
--- a/rust/kernel/mem.rs
+++ b/rust/kernel/mem.rs
@@ -97,3 +97,135 @@ pub const fn safe_transmute<Src: IntoBytes, Dst: FromBytes>(val: Src) -> Dst {
     // SAFETY: transmute is safe with `IntoBytes` and `FromBytes` bounds.
     unsafe { transmute(val) }
 }
+
+/// Type that is layout-compatible with a primitive representation.
+///
+/// # Safety
+///
+/// - `Self` must have the same size and alignment as [`Self::Repr`].
+/// - `Self` can be [transmutable] to [`Self::Repr`].
+/// - Neither `Self` nor [`Self::Repr`] contains interior mutability.
+///
+/// The above basically says that `&Self` can be transmuted to `&Self::Repr`.
+///
+/// [transmutable]: core::mem::transmute
+pub unsafe trait AsRepr: Sized {
+    /// Primitive representation of this type.
+    type Repr;
+
+    /// Convert from `&Self` to [`&Self::Repr`](AsRepr::Repr).
+    #[inline(always)]
+    fn as_repr(this: &Self) -> &Self::Repr {
+        // SAFETY: Per safety requirement of the trait.
+        unsafe { core::mem::transmute(this) }
+    }
+
+    /// Convert from `Self` to [`Self::Repr`].
+    #[inline(always)]
+    fn into_repr(this: Self) -> Self::Repr {
+        // SAFETY: Per safety requirement of the trait.
+        unsafe { transmute(this) }
+    }
+
+    /// Convert from [`Self::Repr`] to `Self`.
+    ///
+    /// # Safety
+    ///
+    /// `repr` must be a valid bit pattern of `Self` and satisfy type-specific invariants of it.
+    ///
+    /// Alternatively, if `repr` is previously obtained using [`Self::into_repr`], and each
+    /// `from_repr_unchecked` should corresponds to a unique `into_repr` call, then it is safe to
+    /// call as well (this means that we're undoing a `into_repr` call getting the exact bytes
+    /// back).
+    ///
+    /// This method makes no guarantee if a `into_repr` corresponds to multiple
+    /// `from_repr_unchecked` (i.e. copies are made), to allow for cases where `Repr` is a pointer
+    /// and the user of the API wants ownership transfer. Users that want the ability to call
+    /// `from_repr_unchecked` after copying can require `Copy` bound explicitly.
+    #[inline(always)]
+    unsafe fn from_repr_unchecked(repr: Self::Repr) -> Self {
+        // SAFETY: Per safety requirement, `repr` is valid repr of `Self`, or it is previously from
+        // `into_repr`, in which case we're undoing the transmute so it is also safe.
+        unsafe { transmute(repr) }
+    }
+}
+
+/// Type that is bi-directionally transmutable with a primitive representation.
+///
+/// # Safety
+///
+/// - [`Self`] must be [transmutable] from [`Self::Repr`].
+///
+/// [transmutable]: core::mem::transmute
+/// [`Self::Repr`]: AsRepr::Repr
+pub unsafe trait AsReprMut: AsRepr {
+    /// Convert from `&mut Self` to [`&mut Self::Repr`](AsRepr::Repr).
+    #[inline(always)]
+    fn as_repr_mut(this: &mut Self) -> &mut Self::Repr {
+        // SAFETY: Per safety requirement of the trait.
+        unsafe { core::mem::transmute(this) }
+    }
+
+    /// Convert from [`Self::Repr`](AsRepr::Repr) to `Self`.
+    #[inline(always)]
+    fn from_repr(repr: Self::Repr) -> Self {
+        // SAFETY: Per safety requirement of the trait.
+        unsafe { transmute(repr) }
+    }
+}
+
+// SAFETY: `bool` has the same size and alignment as `u8`, and Rust guarantees that `bool` has
+// only two valid bit patterns: 0 (false) and 1 (true). Thus `bool` can be transmuted to `u8`.
+// Neither types contain interior mutability.
+unsafe impl AsRepr for bool {
+    type Repr = u8;
+}
+
+// SAFETY: `*mut T` has the same size and alignment with `*const c_void`, and thus `*mut T` is
+// transmutable to `*const c_void`. Neither types contain interior mutability.
+unsafe impl<T> AsRepr for *mut T {
+    type Repr = *const c_void;
+}
+
+// SAFETY: `*mut T` is transmutable from `*const c_void`.
+unsafe impl<T> AsReprMut for *mut T {}
+
+// SAFETY: `*const T` has the same size and alignment with `*const c_void`, and is transmutable to
+// `*const c_void`. Neither types contain interior mutability.
+unsafe impl<T> AsRepr for *const T {
+    type Repr = *const c_void;
+}
+
+// SAFETY: `*const T` is transmutable from `*const c_void`.
+unsafe impl<T> AsReprMut for *const T {}
+
+macro_rules! int_impl {
+    ($($unsigned:ident $signed:ident ,)*) => {$(
+        // SAFETY: $unsigned has the same size and alignment with itself, and is transmutable to
+        // itself. It does not contain interior mutability.
+        unsafe impl AsRepr for $unsigned {
+            type Repr = $unsigned;
+        }
+
+        // SAFETY: $unsigned is transmutable from itself.
+        unsafe impl AsReprMut for $unsigned {}
+
+        // SAFETY: $signed has the same size and alignment with $unsigned, and is transmutable to it
+        // Neither types contain interior mutability.
+        unsafe impl AsRepr for $signed {
+            type Repr = $unsigned;
+        }
+
+        // SAFETY: $signed is transmutable from $unsigned.
+        unsafe impl AsReprMut for $signed {}
+    )*};
+}
+
+int_impl! {
+    u8 i8,
+    u16 i16,
+    u32 i32,
+    u64 i64,
+    // `usize` is not normalized to particular integer for portability.
+    usize isize,
+}

-- 
2.54.0

