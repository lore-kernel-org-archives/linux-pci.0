Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021105.outbound.protection.outlook.com [52.101.95.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485D0483BCB;
	Wed,  5 Aug 2026 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947839; cv=fail; b=DxNSIvy1cMYEI9sEU8HDioLKKhjJSPb31wuIgbDFGxBEeSTdKhmHac3w5BsXkpVjseYXenyWy65WK+BBRQ6PtvgrmcOdLfcZsSVrsmnuERr3KcdfQhlbdgsohpj0Tqtce/qLw24ZgWsm/2qmcD4BvZj5S/ij7aS3QkGuvxyRROY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947839; c=relaxed/simple;
	bh=kxYvMQ7UZOZnHvroydQaLwy3JkmA7ZZfobEsk/DeEdI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=D5BlZSogzYvMOg7vsYR1H6CrLga4ql7uuA1TtKKCxK3d+UvRcQQN0Rk3N5Sb3PIbJx+TU0UhqQu3I8T27mrSNpkgBOn9JaP3+9ba1AGXhzmOi6d5JOWkmkfIodNIbYFLuLq4EfmaS5vQPuyhYlW7EG7Qw8ozdoeoP4DOPmA9xfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=lL4mmeiy; arc=fail smtp.client-ip=52.101.95.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="lL4mmeiy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b37Em66/r9CKCvS/X4ErsYROiMF0dZQiaK8XC5X71obO0QkdSUoS8kmhZ3JUWMRCK2F4rKSAIqjDn4wKw73A86/pLMBF57yqktg5yHHa4BbwDrpEN9ZXnMqW2jG+uh5cpN2qe0wimDZZbq526EbTyUVJus4lYJSsBeDLarcD8bjmRxbu7XU7QjE7XMGiSZvjz0YKzV1bs25YoQgXpU7Rt2kLc8I0JPMZECjm3zvPMKn1oOzaoGMKMNjnk5sTo7Eg7Y/BsPaltroOm/XVc0bKuj1+MxO/s2+4YxA/wG8PreVXS4Am2A4TDVDFO6APmairJkb1ogsd+l9LJKQKH4eS+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drUypYPRnv6ULrv9Li0qH+xITjQcHHHsahchsFzwJ5g=;
 b=PLRktzBdtQuVdV8t7rqLJW1mSMqf9vgHfHDwMWNUVa1K9TLMR5nhYRTvhWFB2EjzBq++oG4vcfGk69/EfoG/NGX+f+pgQ3yeBEEsPRq4nPRJXKQYpIGgLFU7Jx7vQwNxThDGoVKUVhkfhrIA3UCxjTD0m6w2OKZhwpeGKFeC4welpFJwaLcwfp+u/2Z+tJt8YR7cYZvOxMc6PKDkKJeyVNN8KCFXts566cM9GTZJqFYFpjLIPbKwjSvN1zQDgSrd/vN+wgRPcpMyqVeBYkx5bzT3OxRe2YDPieEZyZ76sY6Mn1qepUCbylQfJZQbpA68XoKt5/RbQOxEZPdR7P8gnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drUypYPRnv6ULrv9Li0qH+xITjQcHHHsahchsFzwJ5g=;
 b=lL4mmeiyA1ZPEF6pqnIAl0QAZykCB/rDxSjyRtRI/34Po4KFl1uZ4+ozxpqz8h39vGjZ95tCjgjlQkIg5r+vpNUMMLDZmeUSB8cJCkV9sLGwAEpeegLsivSZj2HV9+Va5dVX5bxZWUPpoa1xsvEyGBmz+7BgQ0kVXBI0SVqu3jA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by LO2P265MB5822.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:26c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 16:37:04 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 16:37:04 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 05 Aug 2026 17:35:49 +0100
Subject: [PATCH v2 06/16] rust: io: register: allow explicit base type
 specification
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-typed_register-v2-6-c3ca142220a0@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785947818; l=12073;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=kxYvMQ7UZOZnHvroydQaLwy3JkmA7ZZfobEsk/DeEdI=;
 b=8NRAjr5Laeniyx3vJKy9sXSWAKXmHv8rczcyZmg8qx8uwWksLz8KYZzdDya/cfTjaTxYgTI89
 fKc1PaXNiPvA/Dxjc/JdjDE4dyKG+xIgm+2n37xv5s3dgwImV4pXwjk
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
X-MS-Office365-Filtering-Correlation-Id: 6fd5c7fd-4239-4f98-0089-08def30fc7fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|1800799024|376014|23010399003|366016|22082099003|18002099003|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	cjHi1jMpqctHdMlBSj7HUNOMQfwVjoHQWK4EuEsX0ikf09PXjr+FhWVa0IHWhfWlwa4SWQeobILHOV9wqcqynFyRO0UyD1YkxEKKwE/V3ga/gd1P5HKGgsxcXE8l+fXGbNSMgTz8Cge0vfXieEE196sLTKqiLs1/6A+QLGcMRkOU+vcolDeQ7knr9NwJHsfBNlLAwK4tmiZ5VywKDJZcFRhF45CBQqTfXSbyg47I9hhusTFdp6KLncb2twmi1eyDurztL2Z6KhD6H9FCGzmKFOjzE2hQn9F/0Ni2Abo2XZ+yAtB9hmr5MATErmN2uRlsH4jccKwAkUATqpPV1jWCwUiYghVzDcarvDjZWMz32B6T/PEwyPVSLgqXhogUnnQutU/t9tYolPluMQ2IeF+70me5XvIY/YNhI6IjgQAJKqnfOKJhZa/9Q4ec+8Ed3OCjbmpn900NsaxS3lxO8fgBnxLKnMfF31FaWN0qV0A+utUQuj66rCOTLbZZYNTgc50VU+sAEmMvIUYY8BoJGdSO8iG2xWF6kGJLu3iLgwwMMIKhkGYleLURsVeVM9HHJ4KkS9B3WNM/H3yEjxNXK6OsfLnx94ES8ekNO98YpcUvxhHMYrHDEXKvxaCGRM3z6n8ebX4gTj4viMo1PswR4xRgD8G5dsijpmWgSyVt36wA9Nt5Y9pws+XDnklmHK7I1GwUnT59rlcD/ajRWqDl2w2mmw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjhYUjJBWmR1M1Nqcmc1VVNzbmszUUJDQnA4Yk50Y3M1VUN3RnlodTlWTzVo?=
 =?utf-8?B?WVYwRU50TXJWK0w0dVROSWRZdXc1amtqakh0dTczRnhtNi9Cem1ZZytkd3ZC?=
 =?utf-8?B?WDBJbWY2RDVRcjNCT3ZJQmhYazlPRjZIWDVZRmlHbnZHQTcwdUhJZDFGWnI4?=
 =?utf-8?B?OTVuOEpibzh5ZURqS0hxcmJ6aHh4b3Vjd2M0ZXM0ZkNtVnBEV2VVMW1UZjI3?=
 =?utf-8?B?QUhieGEzNnE5b21yZC85b0ZINVA3dGR2Nk9CeUJub2J6SEFtd29FWFRtRzhO?=
 =?utf-8?B?WUdYLzViWGhPaWRCbTlINHdDVUNJUkpJOUNUaU5MbnJBekxJQnZFNUYrK25W?=
 =?utf-8?B?YWNhbWgwaGRjSEpEelNCODFZY3N1bWNKK21PS3hmVnRXV0YzaUovdXArb1pq?=
 =?utf-8?B?ajc2Rm5sSzZBSEtyUzZrUWxjUmdJbGxFSG14dmFxOW1MdWZIdlRlVjJXNEZi?=
 =?utf-8?B?ZGExdHJPV2RZczVPU0R0MjlDVUZDd25OSU9kcCswdUtLOEtjcTJWRjZZdW5C?=
 =?utf-8?B?WWswcWtmaDlDdkc0OVVLT3VKWnJ2ek5UZ3oxWlFhcTVTdnE4U0Z2eFRZT05M?=
 =?utf-8?B?WkZ6SGt3RHpsejFqYUthRVFCbEgyTEdpdzB2aElXQXMvSUNpSWJocSt4Wi9C?=
 =?utf-8?B?SDZsbENWL1VienhabTRFaEM4RS9FMTE0akRDdnhMN1JHVTg0L2lMZXdWZGMw?=
 =?utf-8?B?K0hRNG5NMFVSRjRhSThEV1JaSk5DVHRoMVpIWmVVL1lEbXIwSElYQWlRbi9m?=
 =?utf-8?B?bkNhRlNZM0xEbmhmb2pqbnd1WWNwajF2M1JPQ0JQaEgvUWl6Y3JOVEJGL1ll?=
 =?utf-8?B?K2NlblV0WlNqUTdTbjZuTU1RTU1vMGYzZ3NRaUVqL09pUTB4L3Q2TVl2THIr?=
 =?utf-8?B?QlErRExTRnk0dERTTzJTeHdCS1BNYzg5MEl0YlBXRXRMZC9xTmcyZklaYmNQ?=
 =?utf-8?B?QkFGN20waWh1T3daWHNCODRYNTE0Q2t2VUNxdmpJcGtFQnR3dUZ2NTljb2Ja?=
 =?utf-8?B?b3NJZmk1NEh3LzNTMGFvUWh3aXpCSHNWZTRTaXh2cnhOVXozTXNBUS82OHEz?=
 =?utf-8?B?VzZ1Ulh2SXRYclJDNkdiTDhaOUxOZ29KV3R5WnNJYUZkbGFLbnJsQlNQY3NL?=
 =?utf-8?B?SzZZWHFCeVFaeHhRNWx2dGVSdmdjU2pQTFdXd1RsS21WTmNBKzdXajJjYzVY?=
 =?utf-8?B?TmwrSUU0cGZxaGZ0a0xpWFdydkdtMUZsOVgyUjladmxwbDVQazZ4Q0hzS2Z2?=
 =?utf-8?B?STRlT1ZlTU9vM3VrSi95eUFBL1l6aTZxU3lGclRDajVBQUxLc0RYaEk4ai9t?=
 =?utf-8?B?bU9wZUJ5Ti8zWkp4NEVpSGlwWisrTXF2U0lvSzR6eFNJT1lhMXh3TllkRC9h?=
 =?utf-8?B?SzFhcS8zekIvWG9ZalRHbjlzVDVzQ3lzcy9GSzFPM25vWWxSZS9Rd1d4c1hv?=
 =?utf-8?B?S00xenUxek42UW9zZ3ZmTjFJVDFIVHZFMmRSZTVrdVdEbFN5SUpodGlHWjlB?=
 =?utf-8?B?bUdCVlRrV3p1S1crWXJzWUZ1d1YrZS84Rmd2OGRjUnE0WkMzclpuVTA4T0Y5?=
 =?utf-8?B?dWhXSzdxZG0vRVJWdFRFcnFZM2lxK0doY3Z3SjdDbnM5NlBkOGNCZkNLWTY1?=
 =?utf-8?B?bVlsbi9KWXZ0d2FxbUJMbVlkaWdyQWpSZ1VNZGtaVEtQMEpnNGZ1Y1N6UUVW?=
 =?utf-8?B?Z1lBd1owTWJjdHJrUGlCaE9tdGMwRVFOaU5xT2gxeEdFaGxrTUN2Vm12NVIr?=
 =?utf-8?B?akJ6VThHNGlOVnNaL0ZtZFBZZmlsb1QvMzExQmpJTEVDVThpZU1sME40VHNi?=
 =?utf-8?B?cmR2dnhsODc4amxCRWM3MnpTRkh2RmtCY1VPS2xTcnlmRWJsUEpJemhoWGhL?=
 =?utf-8?B?Uk50cDlmdDlYOEgvMWxyU2pzRDdtU2VBbm1PaWg1dkZwMTBTRlhFZ0xaMloy?=
 =?utf-8?B?K1R1cUFhdjdNQWRibkZUY1czeDNFeE1mazArVTh0OUwwcFptYWxKNVdvOVhG?=
 =?utf-8?B?THk5dWN3Vy9STnU0ZTZ5Y2wwOXUvZ3FWYzFydElXL2wxQWErN0dCeXlubGhN?=
 =?utf-8?B?bXhPUDg1dzU0S3h3RS9XbEUvdUw5alJSemoxaDFlVTVUR29Da1BPYVgwNk5Y?=
 =?utf-8?B?aE1GMjNCVlNkUnBUK0tUeW4wdVo4UjR1WU1lRVVGZUxxU0IzVjJkUTRzdzZn?=
 =?utf-8?B?SEZtZUUrZmZzNmhyNnR6b3ZtVDN6NTFzd1AwYVBneUV5NW9DVEp5dS85WkxR?=
 =?utf-8?B?ZTJzcDdEQkN5V0l4bW5uTTZnQ0c3Nm9RTzJFaUZ1N1J1bS9YU1ZiYzBqVnJL?=
 =?utf-8?B?YnRxbHRnazYzaHF3aG1VSUVUcldncVNkemp0WDJHZHdtY2dadktYQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd5c7fd-4239-4f98-0089-08def30fc7fa
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 16:37:03.9316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MzWjXBrInUIOHq1aHzi6i52gjDuQA51zxklEjpE3/IEOyq31LTTUqWFZCbHvrpxdPOz8CgSPv+TIhQCTNA29cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5822

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
 rust/kernel/io/register.rs | 84 ++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 74 insertions(+), 14 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index ae18890866b6..d92e0b6adc99 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -1022,6 +1022,8 @@ fn try_write<T, L>(self, location: L, value: T) -> Result
     /// };
     ///
     /// register! {
+    ///     base: Region;
+    ///
     ///     VERSION(u32) @ 0x100 {
     ///         15:8 major;
     ///         7:0  minor;
@@ -1164,6 +1166,8 @@ fn write<T, L>(self, location: L, value: T)
     /// };
     ///
     /// register! {
+    ///     base: Region<0x1000>;
+    ///
     ///     VERSION(u32) @ 0x100 {
     ///         15:8 major;
     ///         7:0  minor;
diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index e4039e31b4e7..7dca2437b551 100644
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
@@ -429,11 +437,14 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
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
@@ -464,9 +475,14 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
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
@@ -516,6 +532,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///
 /// ```ignore
 /// register! {
+///     ...
 ///     pub RELATIVE_REG(u32) @ Base + 0x80 {
 ///         ...
 ///     }
@@ -542,9 +559,10 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
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
@@ -563,6 +581,8 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///
 /// // This makes `CPU_CTL` accessible from all implementors of `RegisterBase<CpuCtlBase>`.
 /// register! {
+///     base: Region<0x1000>;
+///
 ///     /// CPU core control.
 ///     pub CPU_CTL(u32) @ CpuCtlBase + 0x10 {
 ///         0:0 start;
@@ -579,6 +599,8 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///
 /// // Aliases can also be defined for relative register.
 /// register! {
+///     base: Region<0x1000>;
+///
 ///     /// Alias to CPU core control.
 ///     pub CPU_CTL_ALIAS(u32) => CpuCtlBase + CPU_CTL {
 ///         /// Start the aliased CPU core.
@@ -621,15 +643,18 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
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
@@ -655,6 +680,8 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 /// // Alias to a specific register in an array.
 /// // Here `SCRATCH[8]` is used to convey the firmware exit code.
 /// register! {
+///     base: Region<0x1000>;
+///
 ///     /// Firmware exit status code.
 ///     pub FIRMWARE_STATUS(u32) => SCRATCH[8] {
 ///         7:0 status;
@@ -667,6 +694,8 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 /// // Here, each of the 16 registers of the array is separated by 8 bytes, meaning that the
 /// // registers of the two declarations below are interleaved.
 /// register! {
+///     base: Region<0x1000>;
+///
 ///     /// Scratch registers bank 0.
 ///     pub SCRATCH_INTERLEAVED_0(u32)[16, stride = 8] @ 0x000000c0 {
 ///         31:0 value;
@@ -688,6 +717,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///
 /// ```ignore
 /// register! {
+///     ...
 ///     pub RELATIVE_REGISTER_ARRAY(u8)[10, stride = 4] @ Base + 0x100 {
 ///         ...
 ///     }
@@ -707,9 +737,10 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
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
@@ -731,6 +762,8 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///
 /// // 64 per-cpu scratch registers, arranged as a contiguous array.
 /// register! {
+///     base: Region<0x1000>;
+///
 ///     /// Per-CPU scratch registers.
 ///     pub CPU_SCRATCH(u32)[64] @ CpuCtlBase + 0x00000080 {
 ///         31:0 value;
@@ -758,6 +791,8 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///
 /// // Alias to `SCRATCH[8]` used to convey the firmware exit code.
 /// register! {
+///     base: Region<0x1000>;
+///
 ///     /// Per-CPU firmware exit status code.
 ///     pub CPU_FIRMWARE_STATUS(u32) => CpuCtlBase + CPU_SCRATCH[8] {
 ///         7:0 status;
@@ -768,6 +803,8 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 /// // Here, each of the 16 registers of the array is separated by 8 bytes, meaning that the
 /// // registers of the two declarations below are interleaved.
 /// register! {
+///     base: Region<0x1000>;
+///
 ///     /// Scratch registers bank 0.
 ///     pub CPU_SCRATCH_INTERLEAVED_0(u32)[16, stride = 8] @ CpuCtlBase + 0x00000d00 {
 ///         31:0 value;
@@ -786,13 +823,19 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 /// ```
 #[macro_export]
 macro_rules! register {
-    () => {};
+    (base: $reg_base:ty;) => {
+        const _: () = {
+            #[allow(unused)]
+            type Base = $reg_base;
+        };
+    };
 
     // Creates a register at a fixed offset of the MMIO space.
     //
     // This handles all of the fixed offset `@ offset`, alias of register `=> alias` and alias of
     // register array element `=> alias[idx]` cases.
     (
+        base: $reg_base:ty;
         $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
             $(@ $offset:literal)?
             $(=> $alias:path $([$alias_idx:expr])? )?
@@ -804,11 +847,12 @@ macro_rules! register {
             @ $crate::register!(@offset $(@ $offset)? $(=> $alias $([$alias_idx])?)?)
         );
         $crate::register!(@io_fixed $(#[$attr])* $vis $name);
-        $crate::register!($($rest)*);
+        $crate::register!(base: $reg_base; $($rest)*);
     };
 
     // Creates a register at a relative offset from a base address provider.
     (
+        base: $reg_base:ty;
         $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) @ $base:ident + $offset:literal
             { $($fields:tt)* }
         $($rest:tt)*
@@ -816,11 +860,12 @@ macro_rules! register {
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
         $crate::register!(@io_base $name @ $offset);
         $crate::register!(@io_relative $vis $name @ $base);
-        $crate::register!($($rest)*);
+        $crate::register!(base: $reg_base; $($rest)*);
     };
 
     // Creates an alias register of relative offset register `alias` with its own fields.
     (
+        base: $reg_base:ty;
         $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) => $base:ident + $alias:ident
             { $($fields:tt)* }
         $($rest:tt)*
@@ -828,11 +873,12 @@ macro_rules! register {
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
         $crate::register!(@io_base $name @ $crate::register!(@offset => $alias));
         $crate::register!(@io_relative $vis $name @ $base);
-        $crate::register!($($rest)*);
+        $crate::register!(base: $reg_base; $($rest)*);
     };
 
     // Creates an array of registers at a fixed offset of the MMIO space.
     (
+        base: $reg_base:ty;
         $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
             [ $size:expr $(, stride = $stride:expr)? ] @ $offset:literal { $($fields:tt)* }
         $($rest:tt)*
@@ -842,11 +888,12 @@ macro_rules! register {
         $crate::register!(@io_array $vis $name
             [ $size, stride = $crate::register!(@stride $storage $(, $stride)?) ]
         );
-        $crate::register!($($rest)*);
+        $crate::register!(base: $reg_base; $($rest)*);
     };
 
     // Creates an array of registers at a relative offset from a base address provider.
     (
+        base: $reg_base:ty;
         $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
             [ $size:expr $(, stride = $stride:expr)? ]
             @ $base:ident + $offset:literal { $($fields:tt)* }
@@ -857,12 +904,13 @@ macro_rules! register {
         $crate::register!(@io_relative_array $vis $name
             [ $size, stride = $crate::register!(@stride $storage $(, $stride)?) ] @ $base + $offset
         );
-        $crate::register!($($rest)*);
+        $crate::register!(base: $reg_base; $($rest)*);
     };
 
     // Creates an alias of register `idx` of relative array of registers `alias` with its own
     // fields.
     (
+        base: $reg_base:ty;
         $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
             => $base:ident + $alias:ident [ $idx:expr ] { $($fields:tt)* }
         $($rest:tt)*
@@ -874,7 +922,7 @@ macro_rules! register {
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
         $crate::register!(@io_base $name @ $crate::register!(@offset => $alias [$idx]));
         $crate::register!(@io_relative $vis $name @ $base);
-        $crate::register!($($rest)*);
+        $crate::register!(base: $reg_base; $($rest)*);
     };
 
     // All the rules below are private helpers.
@@ -962,4 +1010,12 @@ impl $crate::io::register::RegisterArray for $name {
 
         impl $crate::io::register::RelativeRegisterArray for $name {}
     };
+
+    // Compatibility rule when base is not specified.
+    ($($rest:tt)*) => {
+        $crate::register!(
+            base: $crate::io::Region;
+            $($rest)*
+        );
+    }
 }

-- 
2.54.0

