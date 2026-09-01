Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020089.outbound.protection.outlook.com [52.101.196.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DBE48665F;
	Tue,  1 Sep 2026 16:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281451; cv=fail; b=FAqHGd1YfgEK6WaVdVYqNA4wlws+8vJeSJpRrxKqrZJhrs+xUQmygOR80iTvbtOOlQYKslPd7GWZfLIcfBFpCEggXvcnZyOkwDU/8U5zt20pj3bveozjOuEQD3JcyuMzLr+82kykfUFC2YHwGWNV03Ea1Tx2GJ6DRQ0HcBCAYic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281451; c=relaxed/simple;
	bh=xnfbjRqvJKgOcZ12SKC5n17bNMX2qwQHPgAuyVtchgA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oqmvoNozG/0Bmw44HG3tECumq0PqHMWo8gP9c2EG3NvguNhSy6NzN+C472uHVWll76ix6fWMTCQ3hThoeDJwtgf7eYBJIGnj0xr55vXLEdVDx/2jqoyJe27OrFl+mHsGpGO3UsyWMuD6bDYVu189J82L0Bh4cRA7PyQW5y82rBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=k0pmHjfm; arc=fail smtp.client-ip=52.101.196.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="k0pmHjfm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gt+nb1pa+gzs2k3vzbOIBuSO2dSGcpTpVzA09O7/cVsvMmwaQ8oY4MlYnHqnTU1BvDu4U3KtAEx5PIeZgRWBhAg3Whc/qEULcE2mtjl9qWfx3vwN0dXy7Vw8+U1u/vOT+cDT8BmEY6HnjGB150RsgSkBRkvYllANvU/PHXJ/4+WP+Z09c0FJ1oFA3kN/6GAmer2exQE/MNLToFDNxchCG8tAWfNiU1haGM3WBYroLErVFjBB5svXx/Sszggs9S0Vy+Iv3daL5Ew3rm6RoWNPnSqcPvHcSbmy+IlOkGzTb8+nJ7q7ZBj9ZVSVI4g1JoQky2qkROoJqcb3aXpP7UASfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8POvxbCn0EDxKQV16ymx8mJMnN25n6i4oyPMxZhVbo=;
 b=l/UdC4YmurtQa50J1YzWlqgKPEnRPV3TqGPspK/xNwjK0EFMQkfuFhRGJMGlt2D8/SklxvV0W2sx+zDjuPvIjBDqn6wH+OCgDN80IliMopsaT/jY94EdRBtU3jZFM6JV7SkkAerhiaSMgsRvUBz77YbEsVVc186kJiFi+io44fk5OkyXQNTHPkh2pEkZ4BNl2RqZpPiweAncAAHfRaCaEnZQdlpl0GzvKRd6BFDgInzJPd23K9mBAgeLLPxQSC16bEmwbMsxNMRm5buvWCfi1icxex3puPjJyG6CFc+ME2uwMGdoDaNA72AfDSccaBUdlv+rUzFUvOX9h553HhTQSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8POvxbCn0EDxKQV16ymx8mJMnN25n6i4oyPMxZhVbo=;
 b=k0pmHjfmxs0+fZXKnNdSnd4hgdm51TayHCfM8ivQ+T4DO/LL2smjNmXN03zhUxotMVTGNHdPzG75iSJ9Y8wSeAtCcSG0Svz+uKs2lkXlbU/7iWQh/y0u4M8XbWmfyTE1dZcEmraT7bbf9kskddtnHIyHZ77ucJfbpcB1/Pz0+2w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO0P265MB7316.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ef::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 16:50:37 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 16:50:37 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 01 Sep 2026 17:50:30 +0100
Subject: [PATCH v4 06/16] rust: io: register: allow explicit base type
 specification
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-typed_register-v4-6-5552b1d59525@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788281431; l=9090;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=xnfbjRqvJKgOcZ12SKC5n17bNMX2qwQHPgAuyVtchgA=;
 b=7gW4WluEWaD83+/nNVoqBjkftphtAebq/fQHGP1DyaBlOvTWdwqQ8mzxEBgqU/hFz/xw7VVIZ
 SO1g3LR0jBsDDUITDrQltbGGrWCLjXkIVshYbF2HdmeSpeXTmdvW3HZ
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
X-MS-Office365-Filtering-Correlation-Id: 728ac541-dcd4-4fb9-1a7e-08df08492628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|10070799003|376014|7416014|10067099003|3023799007|22082099003|56012099006|5023799004|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	YMg+HJ1J1pNFvqXzjcZUNDypAHwEmmcJEGwMB+Av6yskpX+KJ/LLghDL1BL8CNUHejk1IkvMFNis5Ny7hIaTlzJmBGP4qv8qOiVt65z9Et6ufIlCEtrflpd3OLdxSMjXB4dpAy3GTlbSOVlqvR4qPO9pk9CPSK2nzbOlTfsLo6tG7FIhpqjdH8FuOOpb02bJjVakO6e0wrUVh+LjtZMejpMbyH/an0e65Eur7zxESpbSg+uCVlqC7RotiPjQRR90A3ZDBS0bBvSl1OJun9Ub8RsbZsvGPkG33LhJO3ZWsLji2xw+QPu3CHXD2DPCmln+IhPkLElCKEyKFvm822RnYMMmehd+exn1iI+7pMtYU4ispM+83vXFCYU3tf2TqE4RzSCIwkztSe2ZmdLRpYgI5wz5JGBR1VLSEIxDvTH4+vwI5FkdrQIhSIES1v1WXVdlQVZKpcKTTriMulkENhKaSJkJnWcKf8BXOrvhBUsZ8M6FzI9DHgqgGVyc/Id0qH1wUtYhXYK4BTTYIoSNy5sROtsvTqflbLFH4zDHaIB7e0Ac31a54T7u75VVtScLrj4NvFj5r0CDL3kL8I6f6t3t3YQCJr19A12VdYaK3/vKNiLbegQ43ChuwW7/fz1W7CUnEDeUaUSHGWVMW0A4pvHKwWKiy8w/crFbJOBJxjz8C5fu97qEBacr9BDIRAe5Ztc0lV8tu3C61XJXDZOCJw2euA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(376014)(7416014)(10067099003)(3023799007)(22082099003)(56012099006)(5023799004)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmNnMDd0NXJ0VzVUVUZjdWRpbG5VUVhzc0JZS01COGVUaXNncW8rREZJK0hX?=
 =?utf-8?B?UENTZGMybnVqemIvZ0I0TXE2OXZ2ZWY0N0h3NWNURDhzRk1sQXVhWWJ5RjFZ?=
 =?utf-8?B?ZktoMFFrT2hrZFJIeHN6d0dPZTR1c3U1emJ1c2dualRRa21TVytkTHJKNFlv?=
 =?utf-8?B?WHprWFRIVTRBOURsRHVRMUVuOWZBNCs3UUhkWkJGNnhOcGVpa3lQanRScWNV?=
 =?utf-8?B?bW1Ja2ZYdXp0b2tkSGROU3Z2cG5acTRCZFhVUFY4eHRCdnFRSWZaSDNnUTk2?=
 =?utf-8?B?TmRuSG9TRGFpT0RoUE5IL21kN1QwZklYM3h5bnJyejBGMGlCRjB6YytNazg0?=
 =?utf-8?B?UFQ1ZVg3ZmVrb0FKRTAzRE9CUDNHdVpxOG5vOXVYckttMHlMZzVzU2svcUxu?=
 =?utf-8?B?Tk5TUXNIbVU4R2YxZFJnSVEzTWxJMjYrYnovMFROTlphSXh2eGoyNDRzd0N6?=
 =?utf-8?B?MXBRVnNnMHhMaDVEN3FkNkxtdTVxK1NrcUt1UExjeE9lQ3Z4Z2FobUFFM1Z3?=
 =?utf-8?B?alpEK2E2SENCSHI2aGV4MW9pUVd5WGRXcUdFc1NSQWthKzBkaWQwbUs4NkRI?=
 =?utf-8?B?TDBYQk8wWjBtS1pZTFFjU21jTC8ycW9sU0NCeFRBV1A1enJWbU16STg4SEZM?=
 =?utf-8?B?aitWRGdLa0VSM29ackpKUXlmamxzK1RjeXA0TlBkMGFPdTIvc1IrNk5kbXZZ?=
 =?utf-8?B?UnhrZi82SW4rN2hlREdOQ05YZ213QmxEWDkzanZuOFp6MlAxa1ZuRDRZT0hV?=
 =?utf-8?B?UHpQR0JuaEdxbkZmTGZZVDQ1MlhiM2k3QllsaUd2eE5zV1NiTXNpZ0dqNHJo?=
 =?utf-8?B?cUNtSVhEVXZGcS83RkwzaUppRGN6YmthLzRXaHF0bU9kbUU5akZ0NkJ5QTVn?=
 =?utf-8?B?RmVaVUNRRWQwOGV0U0VLNHBmeHY5angwSGU1R1lPRFpzS2N3SHBZNFhBY1or?=
 =?utf-8?B?RFRlaTJnSWovWFA1NEJ4RmxLeVdTQlFkTG1EWi8rZGZ2eTBleS94QndXTkFP?=
 =?utf-8?B?T0xOK1lsVFhBQUVKS1ViVElRS0FaT3lxQU5Xb1JadjdUN3VSaU95SzdhVzlv?=
 =?utf-8?B?dmlleVA5S2JuVzRhK0tLUElId0hyL1hvdTI1bnJPTitSU0puZ1dxcDF5NCtw?=
 =?utf-8?B?UFh4TVRDbVRaaElJaHd2WFFlUjdwdW05NW55cmhScUZNOU1VNXQ5dTNJMktV?=
 =?utf-8?B?akdGTjdqQjRueWFIRlkrTTU0dGR2SnhMNkR5dm9BUnFOSnY3aExtcXlNS0Iv?=
 =?utf-8?B?SFdkS0JjU1J5Q1pyeG90RzNRK2ZvMzB5bWZvd2Y5c0xFRUdSMXRZRG1yYzJq?=
 =?utf-8?B?ZGMvNlBrdDFEbmg2RzVLY044NTl0UUdnRkhzeVo3QzVLRmNkOTREMUM1RWtQ?=
 =?utf-8?B?eUt6RWpPbHduVXlxdWZsdGlhb2xCcUw4b21zK2UxWGpwbGx0R0dmTVdVVlhC?=
 =?utf-8?B?T3VyYzkwNUxkVTBKWnFrU0I3VSszUEp0UkZMS3E1UFUyUUt5Yjlob0t5WC82?=
 =?utf-8?B?WXZTcEZYVldrWTkwaG1UeDhVRWJMc1RoOXpPUk9zT253djBDN3ZrOUtDK3BB?=
 =?utf-8?B?QkEraktmdDU0bkdwdmxNTGh1cU5URUNkelFucXdXaXRHanR4L0NxVkRndGJ5?=
 =?utf-8?B?UGMraFBmbUd6MlVldEZoMVFIRk1lTlZDeFhoYjZ5bTViaXQ5VW54b3hGd1Za?=
 =?utf-8?B?dGtvamxuQXVKdmxHbTlLb2d0eWIyeTB1a1IwNEpiK0dCKzg2UlZTaG42ellR?=
 =?utf-8?B?WUtvYXFPVjI1a1JHUHBVWVphbmxEVHNwZGNWWUFGNmx1YnJkNEtCSmkwdlRU?=
 =?utf-8?B?WEJ6RmE5NWxBU1ZsWGpxam1kY2o2djdNcTY0UEI5Sjc0dFBvMkt1RXp2K2xD?=
 =?utf-8?B?QXo2VFRQL0xHZ2NrUis2MXIwVVpNb3cxcVNrNlZXczRjSk9JS0ZqTEFQMm44?=
 =?utf-8?B?OUtGK24zRWl5UmhGZFpoWXZYejA1YnFyOUV3Z3Jmd1Z5Z0hJRHQ4TjhTQjIr?=
 =?utf-8?B?Sy9wUVgzdldoWldsM2l2RnpjMndvaTJ5WnFSSnNKQkZKbjlQUWVRVzgwKytX?=
 =?utf-8?B?WWJmREZPc0xaTjdUdnM1NlhrdG1YZXpLK3U2Wi9KNkFpTnBaS1NSc1ZlWGYr?=
 =?utf-8?B?Y0JtaTdGc0M1cjNXdDYzcWMzRGdQR0VtYVU4TEZoTSt5S1YvWjRnNllWWWRR?=
 =?utf-8?B?a0hXdGN2dGZNSlE2NFBINlJyTTJ3cmo1K08wcHlxNjM3YmgrYnZHTE84V3VU?=
 =?utf-8?B?N0lmWTlTdkZsNm5QOWo5d2xURnJIdlBTV2tyWHdJOVgvNVVpb092YWJBNGJw?=
 =?utf-8?B?S0dzUzIwUEszNGFJV3BYcUpUa1YxVGc5YzRwQmFPdmdhNG1xK2tmdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 728ac541-dcd4-4fb9-1a7e-08df08492628
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 16:50:37.6336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZVRXViJcsS48dGjKUi+vZIqK8rAAmzUkHAxYzJvdQVaFjYGqEduQhRKckcJ5Ttc7lB19KCKvrWdd9pUE3RtxmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB7316

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
Changes since v3:
- Add a dummy user of `base` to prevent warning on user side (this is
  present in v2 but I forgot to add it in v3's proc macro rewrite).
---
 rust/kernel/io.rs          |  4 ++++
 rust/kernel/io/register.rs | 51 +++++++++++++++++++++++++++++++++++++++-------
 rust/macros/io/register.rs | 23 ++++++++++++++++++++-
 3 files changed, 70 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 8df268969566..05c7fa12fdbe 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -909,6 +909,8 @@ fn try_write<T, L>(self, location: L, value: T) -> Result
     /// };
     ///
     /// register! {
+    ///     base: Region;
+    ///
     ///     VERSION(u32) @ 0x100 {
     ///         15:8 major;
     ///         7:0  minor;
@@ -1051,6 +1053,8 @@ fn write<T, L>(self, location: L, value: T)
     /// };
     ///
     /// register! {
+    ///     base: Region<0x1000>;
+    ///
     ///     VERSION(u32) @ 0x100 {
     ///         15:8 major;
     ///         7:0  minor;
diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index 45d2e73a92e7..49a5fe069e47 100644
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
diff --git a/rust/macros/io/register.rs b/rust/macros/io/register.rs
index 9b92c8099edd..851335792a46 100644
--- a/rust/macros/io/register.rs
+++ b/rust/macros/io/register.rs
@@ -29,6 +29,7 @@
 };
 
 mod kw {
+    syn::custom_keyword!(base);
     syn::custom_keyword!(stride);
 }
 
@@ -152,22 +153,42 @@ fn parse(input: syn::parse::ParseStream<'_>) -> Result<Self> {
 }
 
 pub(crate) struct RegDef {
+    #[allow(unused)]
+    base: Option<Type>,
     regs: Vec<Reg>,
 }
 
 impl Parse for RegDef {
     fn parse(input: syn::parse::ParseStream<'_>) -> Result<Self> {
+        let base = if input.peek(kw::base) {
+            let _: kw::base = input.parse()?;
+            let _: Token![:] = input.parse()?;
+            let base = input.parse()?;
+            let _: Token![;] = input.parse()?;
+            Some(base)
+        } else {
+            None
+        };
         let mut regs = Vec::new();
         while !input.is_empty() {
             regs.push(input.parse()?);
         }
-        Ok(RegDef { regs })
+        Ok(RegDef { base, regs })
     }
 }
 
 pub(crate) fn register(def: RegDef) -> Result<TokenStream> {
     let mut outputs = TokenStream::new();
 
+    if let Some(base) = &def.base {
+        outputs.extend(quote_spanned!(base.span() =>
+            const _: () = {
+                #[allow(unused)]
+                type Base = #base;
+            };
+        ));
+    }
+
     for reg in def.regs {
         let Reg {
             attrs,

-- 
2.54.0

