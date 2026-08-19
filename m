Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020102.outbound.protection.outlook.com [52.101.195.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2CC46982A;
	Wed, 19 Aug 2026 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787137842; cv=fail; b=mkEm3jrBBo2VT4d1ojcM6J0LR5WvqU8MJiq/h8mMh3f6hVm6nyXqRXSmCGuU+tDkzmCrmDqF5P9HSCkIkksQqnKmcYRHz8bcakKtRb9uSr+HtAJQh5o8DiSs85U0t6RXgzu++8HF4HXR7pJB39yprpAxluDLcK2QTlPmRKu6bZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787137842; c=relaxed/simple;
	bh=kuia1m05caZxtQrixxcme0yfXZ1k7Qjcz0016uORFpA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ojk8BZbdZ/V1ED8wpX3XGnX9NYlFqk2p+Lu72jUD+vlTmCx0japC90EG4VSD9stnZOp6+cT6okZA0/5FvAE9z1e7EFEIDHT06Tvi10NN3HtQrrrhAIhPhP7bHN5x30+kEeLfbZ2wQvE0LZmeOpe5han26c5M0Z5XX6imQ0T+Y9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=OiBY02N7; arc=fail smtp.client-ip=52.101.195.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="OiBY02N7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evwZbmhZNwegZEn1rX26KJYR4eXospP5Cpmox4/xi6WpmnirwySwB5lWA9C9ZuS4o1ucqXpZ5YlclvRfEFx2cBJ/LWOeLDgq0J3KkmXWMk1nMcx73AGJ5MHHSFmKRd7TTeH/LFkuOiHIbXvdBMQGxusg0EMGQ9jJzgzIpGc5mwW++AP1L8k7JQxnhuSx8icYxhPsPELMERkX2YAYQPLhvEZUmYd339rtdusr7bgUDeSfbwqeWqFBADrYLOU1pNKO7GE7jbMIkboZMcTJUd6qktB4fsnRFzs85H15xQ+DGEEcOgKx6CuXr1tNi4jRXP1PBVJFg9uGKoehxxExH6PdEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30L1At75N7BB65GJHrPP7D9EbJKTB7i6elzX9/sM4DM=;
 b=Ri7ay5vl5uNMqbnzCxlI18D0WjUdORziJ8oL7BnkajOb4XcYo1q6yrUZ4HsIOhWVBRwuZX4/QMdm7Wv5hcPt1MRkYAce+6jmGQjSet5pkx4AXNic+mgk2s3xyNDeyycFaHMTryYHxBH9RbQh634KQJu1AJ4YLgM1CCJswjcJEL/q4Rlx3yBiHlOBwvLdwfBSUNt16z3IYu7A113SzLRl4Qp45NMP6jTeQB15YyMQXPUNCjUah+umAHLkt6oaUwC4jAnGiTkT7HnWUT6P1+sRF9kR57j2JzG/L8V0AKi4G3XCleNideJXNOK+UGuiHH0eegYK69d0iGYrmyVFYawtBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30L1At75N7BB65GJHrPP7D9EbJKTB7i6elzX9/sM4DM=;
 b=OiBY02N7uUCWlXFJaEONNFSvSwVIE51NSSGrwJCEYCz/sH3byaYO+GpiSi54QV+vtKdMWMxFcz6esz08b8jYvrXWDh9D5NrwkFpBsOnDnRYiH15XlZVWqH+CdMDMMHNKRQH3g4VU3mwuUCjRJ40CGt4rLXbh7INGrbVpHu6cf5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO0P265MB5167.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:283::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 11:10:16 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 11:10:16 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 19 Aug 2026 12:09:11 +0100
Subject: [PATCH v3 03/16] rust: mem: add `AsRepr` and `AsReprMut`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-typed_register-v3-3-3699a75fadf1@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787137814; l=6271;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=kuia1m05caZxtQrixxcme0yfXZ1k7Qjcz0016uORFpA=;
 b=lEX6GVNve9WkDrYqVnlnk/M4i6pxxDZuCycigMll7k7jbeBqMEYUcuCkKfRMpnekuWjUOGE2g
 P/1EnCp0PcuAJqRnU7GodD8UygmPkG3fxTak1Axy3416ahNxKQ3oJf5
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
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO0P265MB5167:EE_
X-MS-Office365-Filtering-Correlation-Id: 91fafff0-8833-4914-a394-08defde272fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|23010399003|376014|7416014|366016|22082099003|18002099003|921020|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Rt4f7Irsf9QUkWOz9J/n5uhw0kY4fmTEVgVKDWFO5TGp2x+ZVle9xc+npYohcPcXjendKccXDZ7zTESq/mgRBHKDj8FsKJrrhhlD+CADbFX13sWUqNuaDBAE/mlw+IEqfuRWui+mpogKShNvWE/f11Ad2604SgdSG6OVDh3bqgnosfUPLvcCVUBHFvxeh2+pLYy2BIWsvHVu9rokP+2Owc4PSLK+s4D+S4/Y5NX30UyASDcgGGXpFmB71rz0hjBi0iRKHBRwD47r9RwBzZxFvW0qmliipSFiG5XeIGnYYQhOGfsjA/ASlY7jlTX8CLmedIUY6genU9n5jN9yo8bcTxa6HzjBmP/FjmM3eKpWSZsRNUbJkYvPj2sApldiUPd9MdrJK/O60hAxUN95J9DZSoozVBIizQyPrxPuDM1++Bb2Qjy7vbjxbGTXSBc7/bNz85zunsfgUTYrIYzrcyfPjdregmVrJh6+2xqf7rFMffs+3INgzKfOA9GZva4h6l25JEDap0T+UTEK3LhhQr71HZ7NgFVF5OA7X66fLSgP9ba5csbSX3YJf2DnhXGGNPSg8aTPrq/yWwHhVc5iROuLOs3hJAqMFP3htM/8XXVM1/DJUBPjnJmZMXtVOdi6eiPjzlYDGanoergDIYwERSkEKO/MIDrK73g5jK6Qodna0nIXhTLpLvG6QcA9nmAmGtsvpJR9vDb2wR0an7dFxWseQA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(23010399003)(376014)(7416014)(366016)(22082099003)(18002099003)(921020)(10067099003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1RIMUhmUDBaZjJ0dXdmQitzVDlWS1VUT0VoYVdTcURmV2d2akcvY01mcFEx?=
 =?utf-8?B?cUtFdlJNTDQwaUxEVC9QNGxUSHlpTnozRTBiT2s1cjUwSjlZNkZFVm5RcVRW?=
 =?utf-8?B?cW1PKzQ1dEpsNWx4V1VNUEZtcEhDeFo0Uldrb2x0UnZsaGxQanBFS3pVT0FV?=
 =?utf-8?B?M1JiTjYyaFk0V0s4SUdMdE14VHZCKytsT3NrUTVqNVl0c3MzWjZoUkpEdkdv?=
 =?utf-8?B?WUEzeE43WDRkWXRxekphd1oyRG9CM2s1b1c3eDgwMlRrK1c4Q3k2UmFYNUk2?=
 =?utf-8?B?R3M1VllzV1hNMm1QLzJaUnlSdGFOMG92ZGJUZ2tVeTRXWGRuUEsvd0h2VTlZ?=
 =?utf-8?B?Z2VrSkZjSmJHcys3blFRY2dCaWVYSnNrZVVvR0M3Tk5MQ0RaUGllQmM5Z25y?=
 =?utf-8?B?NVlYL3NZb3p1WXRmMmZ1anZ6QkdxZkdhSkVrTWxRVmFjallDT1FjZm5qbnRL?=
 =?utf-8?B?Rzdna3ZLTzlNN3h1YVA4SjJRSUVpSGkvMlVURkJaRUp6MmRVSnp4VGZ2U3ZH?=
 =?utf-8?B?TlE3UkJ5WC9RK0hyRVlYNjBGN3Q1OE1kaUNzaVA3Tnp3a0YycUE1QWIyVW9q?=
 =?utf-8?B?bVBiR3EzQkNTdWJJZ3JkQ1ExdmFxZEcyV1dkYkRtbzA2R0VWaUtIU1ZVVVNM?=
 =?utf-8?B?UUd0QVQ0bmFDakdOcUsvc2dpNHg5dXBDL3JvZ1JDbzRlRldqQW55Tm9SbGtw?=
 =?utf-8?B?THk3RlpRY3RwMm9MYmZyMWJoNkJGLys0Vy9ETCt1cFpyODVHN1daNjBJWmkv?=
 =?utf-8?B?bE9IbGtwTjBVRGVwdGhwempDcWxBK0xmT3JjenVqcUFJRUViY2xBeGk1ZmtN?=
 =?utf-8?B?OXJYOFgrTFpudW5tSDZzeWl4cEFuTGphYm0zZ0Z3VU12Q2JSM2xHRFM1eFlw?=
 =?utf-8?B?OEg4SkR2dW1KV2Jibkx6M2lybEo1OURiWGRKWm5ONUNDeHFlRlI5UGJzS0Rw?=
 =?utf-8?B?blBPZFdOMVJGUHJlSkliUkVDZ21NbEN1cjhOWHR3QzRsbWkwdzdlMHhoZzBw?=
 =?utf-8?B?OFlGYW9sMzZSQWx0bGt2TE4wS2dwTFZzaGhYckt6dkg1QzhCWTVQeVFocU9H?=
 =?utf-8?B?NUlzWEpHQ25TbTNXNnROZVUyR01jbUFjWmtzbUdpWXdSMTNxZE9Kc21OaFkv?=
 =?utf-8?B?dFM0TlI2Qi9idkM1TW1QdWVsU0IyMmQwVnZZU1JYYUpvWEJkbGRRUzJ6YVUz?=
 =?utf-8?B?MTJML2l5YjhmQjY4RU1jVStpSWtUV1NHMmxPd3JzQ25lNHJRSHUxM1ZmRFlW?=
 =?utf-8?B?MVdLZVFBdjVrVHNZNEpsTTBQbnFTOG5HMjExTWtWaFZCVndHbnZuenhTSzNI?=
 =?utf-8?B?YlFZcWRTMThqOVoyNU9DY2lCRTA4RU4yRHJUYzRmZzNEZW5MQ2hPRjlZQlA4?=
 =?utf-8?B?UmVLTSs4cHJPTHNpYmYzQ2MrdUdnUm9tNmZkcVRCZkpnV3p4d2ROUzdDeUNu?=
 =?utf-8?B?bkVmd0VSMU9ta0xWdWdQVml5UVJsWVB4T09WUWtqcjhScEkxYXgySkZ5ZXVz?=
 =?utf-8?B?NU1vK0J0UnE3bUc2cHBsZS9CRDNSZWV3czZSVFhhQzJSUlRmTENHVnBRNmRB?=
 =?utf-8?B?cW1mRjdRK3A4VVlwL1ZDakVqN3VvMFhsUmZpenRCZmJQWG5KaWNTM1gvWHVw?=
 =?utf-8?B?WlhDVGxNdDdVRzNkTktqWVd5cVN1VndaY2ZDbHdzL0c2WWYrbVZyZUVheFdo?=
 =?utf-8?B?WHZrdzIrVGd3T2M5WXZ2SGNxb0tmaGd1WHJsOW43WVBHVlFUa1RiRXd4REtB?=
 =?utf-8?B?RmdXUitRYjVWSlFFNEN0aStwQkRVTVJRZmh2emJWYmFCKzJrQjlMdncvOW9X?=
 =?utf-8?B?M2R3eUZ2eCs1QVZzL3RXTWp5eDcwL2ZRY2NvQmFyUm8rWXFYem9HMDM4VXpU?=
 =?utf-8?B?dmxBQmJ1Mi80OWpmQURzRXd6ZUlkMUljN2xUNXVEMG9CZnl3L3VSVGlZVCtC?=
 =?utf-8?B?V2JKV1pNUE9HVGpPNjBCMTFvRmhFY2RDSW9ReVFJQkZBY3o5anNpaGo1N2du?=
 =?utf-8?B?RjJaRkRLczV5alV4V1IvS3dDbGdHMGt4NWIvWVM5SFlCdGI1SS9QTnpZeXp6?=
 =?utf-8?B?ajNPM1h2T3FZUkp2ZkZqQzBmbWF5M2V5WlBHUHVyV0JlMVhFNkxJdTg2RU5q?=
 =?utf-8?B?ei9JenZpYmFRREhOejVGVE9IeDZDaTBvb3lNRkNtT3VmY1pnWnN4UDJaZ2hl?=
 =?utf-8?B?OE5FUWttVGg3cmFLME5QWm83bjBRYitVUXV3QmVON25yTDJGZkRlZFd4bllN?=
 =?utf-8?B?K0dnY2IrWGJjTWxVWmt0VnlMb3JBK29SYUlrNktsSzhoencybjRoTmp4cVBp?=
 =?utf-8?B?RkxnMlRkTmxKekYwQXNaVXBWQmtFWTRHZkt1U1RuMlhxUyswOEl2Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 91fafff0-8833-4914-a394-08defde272fc
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 11:10:16.7688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RLM+HumRKAQ7v4Ac4y0m9UTpj77ZwYno7qagFFeaSvKbYOkxdjw+BIhzVLBMlKnUU7qRDCNrja1+09hvewJ7Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5167

Some API like atomics and I/O operate on primitives only; therefore other
types would need to converted to these primitive first. Add two traits
`AsRepr` and `AsReprMut` to indicate that the type can be turned into a
primitive for these operations.

Conceptually, `T: AsRepr` means that `&T` can be viewed as `&T::Repr` and
thus it has only a round-trip transmutability requirement. `T: AsReprMut`
means that `&mut T` can be viewed as `&mut T::Repr` and thus it needs to
support bi-directional transmutability.

To avoid duplicating implementation, all repr types are normalized to
unsigned integers.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/mem.rs | 148 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/rust/kernel/mem.rs b/rust/kernel/mem.rs
index a0901cbe1b2d..5bce381d8895 100644
--- a/rust/kernel/mem.rs
+++ b/rust/kernel/mem.rs
@@ -35,3 +35,151 @@ pub const fn transmute<Src: IntoBytes, Dst: FromBytes>(val: Src) -> Dst {
     // SAFETY: transmute is safe with `IntoBytes` and `FromBytes` bounds.
     unsafe { transmute_unchecked(val) }
 }
+
+/// Type that is layout-compatible with a primitive representation.
+///
+/// # Round-trip transmutability
+///
+/// `T` is round-trip transmutable to `U` if and only if both of these properties hold:
+///
+/// - Any valid bit pattern for `T` is also a valid bit pattern for `U`.
+/// - Transmuting a value of type `T` to `U` and then to `T` again
+///   yields a value that is in all aspects equivalent to the original value.
+///
+/// # Safety
+///
+/// - [`Self`] must have the same size and alignment as [`Self::Repr`].
+/// - [`Self`] must be [round-trip transmutable] to  [`Self::Repr`].
+///
+/// [round-trip transmutable]: AsRepr#round-trip-transmutability
+pub unsafe trait AsRepr: Sized {
+    /// Primitive representation of this type.
+    type Repr;
+
+    /// Convert from [`AsRepr::Repr`] to `Self`.
+    ///
+    /// # Safety
+    ///
+    /// `repr` must be a valid bit patern of `Self`. If `repr` is previously obtained using
+    /// [`AsRepr::into_repr`], then it will always be safe.
+    #[inline(always)]
+    unsafe fn from_repr_unchecked(repr: Self::Repr) -> Self {
+        // SAFETY: Per safety requirement of the trait.
+        unsafe { transmute_unchecked(repr) }
+    }
+
+    /// Convert from `Self` to [`AsRepr::Repr`].
+    #[inline(always)]
+    fn into_repr(this: Self) -> Self::Repr {
+        // SAFETY: Per safety requirement of the trait.
+        unsafe { transmute_unchecked(this) }
+    }
+}
+
+/// Type that is bi-directionally transmutable with a primitive representation.
+///
+/// # Safety
+///
+/// - [`Self`] must be [transmutable] from [`Self::Repr`].
+/// - Note that [`Self::Repr`] must be [transmutable] from `Self` as well, however that is a
+///   requirement of the [`AsRepr`] super trait already.
+///
+/// [`transmutable`]: core::mem::transmute
+pub unsafe trait AsReprMut: AsRepr {
+    /// Convert from [`AsRepr::Repr`] to `Self`.
+    #[inline(always)]
+    fn from_repr(repr: Self::Repr) -> Self {
+        // SAFETY: Per safety requirement of the trait.
+        unsafe { transmute_unchecked(repr) }
+    }
+}
+
+// SAFETY: `bool` has the same size and alignment as `u8`, and Rust guarantees that `bool` has
+// only two valid bit patterns: 0 (false) and 1 (true). Those are valid `u8` values, so `bool` is
+// round-trip transmutable to `u8`.
+unsafe impl AsRepr for bool {
+    type Repr = u8;
+}
+
+// SAFETY: `*mut T` has the same size and alignment with `*const c_void`, and is round-trip
+// transmutable to `*const c_void`.
+unsafe impl<T> AsRepr for *mut T {
+    type Repr = *const c_void;
+}
+
+// SAFETY: `*mut T` is transmutable from `*const c_void`.
+unsafe impl<T> AsReprMut for *mut T {}
+
+// SAFETY: `*const T` has the same size and alignment with `*const c_void`, and is round-trip
+// transmutable to `*const c_void`.
+unsafe impl<T> AsRepr for *const T {
+    type Repr = *const c_void;
+}
+
+// SAFETY: `*const T` is transmutable from `*const c_void`.
+unsafe impl<T> AsReprMut for *const T {}
+
+macro_rules! int_impl {
+    ($($unsigned:ident $signed:ident ,)*) => {$(
+        // SAFETY: $unsigned has the same size and alignment with itself, and is round-trip
+        // transmutable to itself.
+        unsafe impl AsRepr for $unsigned {
+            type Repr = $unsigned;
+        }
+
+        // SAFETY: $unsigned is transmutable from itself.
+        unsafe impl AsReprMut for $unsigned {}
+
+        // SAFETY: $signed has the same size and alignment with $unsigned, and is round-trip
+        // transmutable to it.
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
+}
+
+#[cfg(target_pointer_width = "32")]
+const _: () = {
+    // SAFETY: usize has the same size and alignment with u32, and is round-trip transmutable to it.
+    unsafe impl AsRepr for usize {
+        type Repr = u32;
+    }
+
+    // SAFETY: isize has the same size and alignment with u32, and is round-trip transmutable to it.
+    unsafe impl AsRepr for isize {
+        type Repr = u32;
+    }
+
+    // SAFETY: usize is transmutable from u32.
+    unsafe impl AsReprMut for usize {}
+    // SAFETY: isize is transmutable from u32.
+    unsafe impl AsReprMut for isize {}
+};
+
+#[cfg(target_pointer_width = "64")]
+const _: () = {
+    // SAFETY: usize has the same size and alignment with u64, and is round-trip transmutable to it.
+    unsafe impl AsRepr for usize {
+        type Repr = u64;
+    }
+
+    // SAFETY: isize has the same size and alignment with u64, and is round-trip transmutable to it.
+    unsafe impl AsRepr for isize {
+        type Repr = u64;
+    }
+
+    // SAFETY: usize is transmutable from u64.
+    unsafe impl AsReprMut for usize {}
+    // SAFETY: isize is transmutable from u64.
+    unsafe impl AsReprMut for isize {}
+};

-- 
2.54.0

