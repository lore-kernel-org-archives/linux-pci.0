Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020105.outbound.protection.outlook.com [52.101.195.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03F448F831;
	Tue,  1 Sep 2026 16:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281461; cv=fail; b=SRHqJlVGfC4VVvHv6yAyJB/6sfhTY3EDeXYKNTm1tcWP7N93LzqHIOw7GrKantm//LpQ7Yet2+Nwye9dmV9nvOCy6OwBM2i4TWuKyMf1Qa7CuRkYZ01cK1JvllmOcq62Lte3uL7c5gHgAWL/two8Avt0231A0HLEIEl5Xo/G+SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281461; c=relaxed/simple;
	bh=Xb4DD4uN8tS4xE64OPyY1srq63t2yRPPUCby23Jigzo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=H7mnuDVm5/kw79dTI/sB1e9x9bA9qDm8q540a0ZybHEIqqhUSB1Lp1OctDyZh7tQE1uBofRR99DVzLhHNiBllhHmafB8Nxx1Rt7ors3Y3bXCnlY64S9LwRFy4wApqn6loa8GTilgV2UAkTOaWoxU0deLchIWDDGTUY1zKAcvWcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=m4dTYEfR; arc=fail smtp.client-ip=52.101.195.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="m4dTYEfR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWBp2sWdRPYZgKbR8lf1gaRiP8ioxOR9ay/JNkbPSSA3FZ0aHvJMuFKj2zSLBZ39akVVI7MaVkETKOdxhGKha7NUO2atNtZqhAT5MpX+SKRQuEwFeHMPlJWU35gP1YNbmQg2X/x0XHbPrxuMcmvu0mDYQ0O8/E5N2RDpDDII/VZ7np9Rgit3kO+J+mvAnLSS2Mj96lgrkLAMQzpgW1XuSuioMg/oDf29cxNNpP1VUB/sC3u2q4bhnXJibAH7iiH/iZq7NLKijOq6he3gtS3fEmDKyN4x6ThlASygmcOSlwZERLsuzqF2JcxNuof2Ok6+ARhnzX+9MSUyB4rDMXy+gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgNTWozGwZ/yHO7i+BJQmmZm1y8Oef8BDGqKEaOWIno=;
 b=k5EWXvDzi0pOeVlEOYb3V6hNSC5spPNS4cOW5ajh9TArParwE7WyH2FATW7jRtxpYuuU9lOpg2lWX74gHwQx9wYwtSrWQeEnMug/5kBIn/k26DbPn/GJICUC/KVx7fgbzepS3tiBb745ZiW5zzFRc4lGlSvOFq4v3hSwM8qiu6+TAp8h25plCNssOXJpgBkid2zxbFssMeDXWkwGuOS+J3zjq+fX0I4OsFbOXt8g8bWWf715BjDr3dgoo9HsxxrRg4StX6A7AUbuqca1Vj4pFs6Tp+6Txzpcz+uEpjRrnxxkmcpuAwsMBBaDAZA4mU5iGK8yycKRCATp9uO7uw4Fng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgNTWozGwZ/yHO7i+BJQmmZm1y8Oef8BDGqKEaOWIno=;
 b=m4dTYEfRUVq28QfQdgRucZuvoLlpJLrVLMODuhvzViSFRuGFvi0ev//4AP0lAm7KP753yNaFYyPZ32CgGkzXzH4ra0DqnTWwOEK27WWvmVMULKWLFQxj+choAouAKg4+ivPn2dqMedxg6Uq5dN8Oyk/BFT8nPkY1HkAvqkFAcsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CW1P265MB9199.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 16:50:46 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 16:50:46 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 01 Sep 2026 17:50:40 +0100
Subject: [PATCH v4 16/16] rust: io: register: unify handling of register
 with/without bitfields
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-typed_register-v4-16-5552b1d59525@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788281431; l=10728;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=Xb4DD4uN8tS4xE64OPyY1srq63t2yRPPUCby23Jigzo=;
 b=NLIFSh0h4XvoG2uzJTeMnm/v6lFM4wgLIaHXPmrNyj/y3WHl8uaqEmxaRDsHLEyVImrkEB4g3
 wonaBr4v2CqD9iQ6NPZ4NiMT6f4QEpvR+f4WB06er8Df7PD417rg8bj
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
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CW1P265MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: 3530b8f8-7158-4fe2-0024-08df08492b78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|10070799003|376014|23010399003|366016|921020|6133799003|3023799007|10067099003|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mWpfFP5PWkUzzSvgGbqUt155oTNY6yjCA6HphaUAMDsy1DTfV1re5zU5FJowo5tJtMFRng903OwUSOUhlyyAwUID0BLBhG5V3fKPQa1V8ZrI9jvycbWrW38g7rJQ0506z8qDbPuU83vvY/V4Ue9mlYmV3P2VS1D3ceukHLTGif86rCRcTtPjTf5Nxh+D8DgnMP8XH0ItgAQmDwlXocOb0veo93czoQz32RO5lBl6GxjM51N8GmfxCmmdqtgW8l0xZQjOYz2ywcMNVNqI+IVn6kFtzJ638Wz253GKVggiiKVdxRQHlkTVqBC8D709kKZP6GFhvDn41pF0hcesgNIqmtsVZADM9SoMrXP8s9BCRwyERJ48AzcPCGFvZef+rcy945udVXrPjH76wtrHk09/6RmvsLx8pVStYwC4Q1cecLyOsAr1Yat0SweWOaxUPlDF9zmezKCb1JXSyYmgFiG6wHVgw7kGsB2LH+zXMKmlMaWVN778E+ED2RPa1Os4psvGoKe2W7ySFVHClfhd3/OAf1DTAU6JNsiOfF1jdCAti40CrZYAwQcxudYYGSgJzB6sf0w1d6Fku9o9xfGTAqNM8yLMRWtgPvUDyTrkmACmQkdX2LMr7LUgqPdD4ro30Kr1rHSEieJwFvK9kEfFtR6BITy6X9B4qvkuO7ufe4PqEmViWgKXXxjUh9INsEqt1uDST8rwR3A7JDPaqF5XbXnwLg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(10070799003)(376014)(23010399003)(366016)(921020)(6133799003)(3023799007)(10067099003)(56012099006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVJMb0drQVRaNVd1cW1xRkdHWitqY3R3Q1k5MHNoTU9sSmpsczQ1LzRRMzY1?=
 =?utf-8?B?RjJEVWxHc0hTYTFmaGlEUzFFdWNiSUxtZzlIajI1YzBqV1pabk9YWlB5UXlD?=
 =?utf-8?B?b3FTZTIvdW42Wmh2UHJSa0Y2UlBtRjR0QjRxUXMxR1Erak5QcXhSMllhTm56?=
 =?utf-8?B?cGtzRHFQcjRrcElZR1NrNitwY2orMVkreDZHbGIyQ1hiaXY5bjJqOVZDUjhI?=
 =?utf-8?B?YjIyN2UwMExqNk42QXhaeTNLUm5ZTlUzQUpwQWV0a2UrTVdsZ2ZiMW1SVVI5?=
 =?utf-8?B?Q016M1kwQkZxaFZaNW5tdm94TTZNZ3VhRi9JUW54eE4waG9ndjhXOW4xTkhm?=
 =?utf-8?B?ZDhHVWdnOXcwUFVtamZKQStMaVc2OVdVUjFnYS9ySG12QUNhZWJ6S2lsT1FN?=
 =?utf-8?B?M09xRXIzUkIvU1FLY2FTck93ZTRtN00vUm5hUEJVa2duNXhPTE04NWs3M1R3?=
 =?utf-8?B?RjJwajhlV3NXUm1nalF6T2ZvQzhtc3VCeXdraHgyMk9hUDNWK0g4Wkh5UlJo?=
 =?utf-8?B?SEkxL1lFblFGSkJKeWJtdS9DUXRaazlUcXlSRVZuYjF6U3g2MkpocDFya2R3?=
 =?utf-8?B?bndyaENWN2Q4ZVNSZ1hESmQwbFRwb1FKczVLU0ZRK2VqUUkvRDN2V2FpV1lV?=
 =?utf-8?B?Rlh2SHppMFIzWnVUa1BERzRtVHpQNXdUNkFLRjg3TFdmRkRweStzbWZ0SnVi?=
 =?utf-8?B?ZTVGN3VUUm9QNnI0K3lUNWMydS9sYys5SnhZOElTNWtrcEdWT3VuSlRuSm02?=
 =?utf-8?B?aW9HRDVNWjQ2NmQ4V2xjMlRmcW9yMUM3MFlNMFJ4N2RTOUdnemFRSjJiYVdT?=
 =?utf-8?B?TFhFaEpYS045bHQyL0l3N3FEbUt1MjFaVm9UQ3lGS05KMU8xTkQxSUJFeUtx?=
 =?utf-8?B?eWtSV2ttdER1bW8rS052dnFMeHU3RXorMTJzemQzYVhWQnd5M0pkQVVZZVJW?=
 =?utf-8?B?VGhZbG9tNGdoV3VSbGE3K0R5TkVpWWFDTyt5cjF4a0toSnp5Sy93b1RxeFN1?=
 =?utf-8?B?UDEvd0grRjJTR1pRWnVaSTBVaHppSHRSb3B3c2lkbmhtZTRYcStRRDNVcTV6?=
 =?utf-8?B?NGFDT2c4bGUrMGNETXVHdzNYeHdpWlAwenRNQTlGOW15WXB5b05aVDV0WlJK?=
 =?utf-8?B?TStHb29GbzdCeHZTSHFTamw4Vys4Y1FrQ1NoNDFwbER2c0ZyVUJIaE9CaWk0?=
 =?utf-8?B?cEE0bU0wQTQ2Q0liYmwzbUNlSnFXNkdyQ3hZYlFiTGkrSDl1emkxeHdjSjZh?=
 =?utf-8?B?MWpTbm8xM2dUWlFLZXZPZG9QU3llVEh0cWNqd3ZRUzIzU2YwanpsNGlKamE4?=
 =?utf-8?B?SXljZitIdERiNkhIVG9IcnFnbDR2L1R0cnViMVA1elVnOENCbzJDNHYxOER4?=
 =?utf-8?B?aUdxRXhkUi9nejI4dGs1amFBVStxRXFyQ29qK2IyTmpVSjBTd2RDNGpRdW9i?=
 =?utf-8?B?OGhKdUtyTkowYzROTDNpNlEvMTNzeTRNc3NWb3RRRWZkaUdZVVVJOWhyWlJW?=
 =?utf-8?B?TS9ZakpGM0MzT3dram5VS1pEalVjRVpXSVZoVldEZWN0Y3hjU05qeUxYV1hW?=
 =?utf-8?B?VmN1U1NwNTVRYVJEQTVuc1lxVitha1FiSnZaZDgrWTMvcFQyL3VPbXYwN2Mw?=
 =?utf-8?B?V3pPUDdGVVN6SmVsVk5LWkF0OGZRWmt0VXhRVWdycmplVlJDQWxYSVNaZ0xS?=
 =?utf-8?B?SVpPVXJXSldvcUN4cEhBRmxsRExmdEw4dGplZittZ0dHeXJXR0pvNkxJVE96?=
 =?utf-8?B?bDRXb24wc1dvNjBjTUZaSnlmeGlzcVU3Qjc0d2xLZVQyTFdSaDRUZFdsLzJO?=
 =?utf-8?B?dVI3YTZub3pLYkxxNlZkaWJ6alZ4YThhRXJOVjRFbUdKSkdGTjVBYTVpQnhz?=
 =?utf-8?B?VlNkU2ZLTWJTY2doSkdkcmI0QzJ0MU40QzV4T0N6WWs1TnA2MktaRk91S3ZJ?=
 =?utf-8?B?SGlid1F6Mmdtc0V0aXVRL0cvcWJLN3htS0I1L25LUFBkblkxR3dTL1BWd2w4?=
 =?utf-8?B?VVNIVkF5elZhb1lDTXlwQnNFdHo3RExma2t1TEJqOVkycDFLSlRLZlFIZGRQ?=
 =?utf-8?B?MFhMcDNqOStWc2ZsajZkRmZJQWw4YXJzRCtaTHBreFYxbEc3Znl6N01BYjhT?=
 =?utf-8?B?YWtlN1V0LzBqNStOci91SGEyeGlDUm9Ic1JWR3MyMDErTSsyOWNFcmxPOWhG?=
 =?utf-8?B?ZFdZaEhxYy80OTYzZENYZDBEY2V4c0hxdUVMM0VpWTg4bGZxQ1J1eUZCUUZp?=
 =?utf-8?B?d1pGNUVNOHNqdTV3TFczWFd3Y09LeVIzODFQUjFoQkl2dWh1Zk95OUxsL2cr?=
 =?utf-8?B?eUpRNGt5SGMyZkhXV3RqTkJGVHBCbVJpSjQ2TlE2dTdPWm9rc3paQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3530b8f8-7158-4fe2-0024-08df08492b78
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 16:50:46.5532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEFY7iXfzIF53/I+w2/yUEcnSn71Jvqc8/nm3VTLG1vmx3dItL9780/ZDdwZoKKgEiUQC5tOJIzCyDh2ymlm1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB9199

Move the `FixedRegister` from a property of register to become a property
of type. Name the new trait `FixedIoLoc` indicating if I/O location of a
type is unique for a specific base. Thus, bitfields become just a special
case of this (where type is unique because we're generating it in the
register macro), and expose feature to registers without inline bitfield
definition with the `#[unique]` attribute.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
Changes since v3:
- Add a note that discourage `#[unique]` on primitives (Sashiko).
- Fix array's bitfield check to check `bitfield.is_none()` instead of
  `!unique` (Sashiko).
---
 rust/kernel/io/register.rs | 114 +++++++++++++++++++++------------------------
 rust/macros/io/register.rs |  58 ++++++++++++++---------
 2 files changed, 89 insertions(+), 83 deletions(-)

diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index 9df7572aee9d..b6513fa0f412 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -121,61 +121,15 @@
     io::IoLoc, //
 };
 
-/// Trait implemented by registers with a fixed offset.
-pub trait FixedRegister: Sized {
-    /// Base type for this register.
-    type Base: ?Sized;
-
-    /// Start offset of the register.
-    ///
-    /// The interpretation of this offset depends on the type of the register.
-    const OFFSET: usize;
-}
-
 /// Allows `()` to be used as the `location` parameter of [`Io::write`](super::Io::write) when
-/// passing a [`FixedRegister`] value.
+/// passing a [`FixedIoLoc`] value.
 impl<Base: ?Sized, T> IoLoc<Base, T> for ()
 where
-    T: FixedRegister<Base = Base>,
+    T: FixedIoLoc<Base>,
 {
     #[inline(always)]
     fn offset(self) -> usize {
-        T::OFFSET
-    }
-}
-
-/// A [`FixedRegister`] carries its location in its type. Thus `FixedRegister` values can be used
-/// as an [`IoLoc`].
-impl<Base: ?Sized, T> IoLoc<Base, T> for T
-where
-    T: FixedRegister<Base = Base>,
-{
-    #[inline(always)]
-    fn offset(self) -> usize {
-        T::OFFSET
-    }
-}
-
-/// Location of a fixed register.
-pub struct FixedRegisterLoc<T: FixedRegister>(PhantomData<T>);
-
-impl<T: FixedRegister> FixedRegisterLoc<T> {
-    /// Returns the location of `T`.
-    #[inline(always)]
-    // We do not implement `Default` so we can be const.
-    #[expect(clippy::new_without_default)]
-    pub const fn new() -> Self {
-        Self(PhantomData)
-    }
-}
-
-impl<Base: ?Sized, T> IoLoc<Base, T> for FixedRegisterLoc<T>
-where
-    T: FixedRegister<Base = Base>,
-{
-    #[inline(always)]
-    fn offset(self) -> usize {
-        T::OFFSET
+        T::LOCATION.offset()
     }
 }
 
@@ -188,6 +142,11 @@ impl<Base: ?Sized, T> OffsetLoc<Base, T> {
     pub const fn new(offset: usize) -> Self {
         Self(offset, PhantomData)
     }
+
+    #[inline]
+    pub const fn const_offset(self) -> usize {
+        self.0
+    }
 }
 
 impl<Base: ?Sized, T> IoLoc<Base, T> for OffsetLoc<Base, T> {
@@ -266,6 +225,17 @@ fn try_at(idx: usize) -> Option<RegisterArrayLoc<Self>>
     }
 }
 
+/// Trait implemented by types that indicate there is a fixed I/O location for this given type.
+///
+/// Implementors can be used with [`Io::write_reg`](super::Io::write_reg).
+pub trait FixedIoLoc<Base: ?Sized>: Sized {
+    /// Type of [`FixedIoLoc::LOCATION`].
+    type Location: IoLoc<Base, Self>;
+
+    /// Location of this type within given base.
+    const LOCATION: Self::Location;
+}
+
 /// Trait implemented by items that contain both a register value and the absolute I/O location at
 /// which to write it.
 ///
@@ -283,26 +253,17 @@ pub trait LocatedRegister<Base: ?Sized> {
 
 impl<Base: ?Sized, T> LocatedRegister<Base> for T
 where
-    T: FixedRegister<Base = Base>,
+    T: FixedIoLoc<Base>,
 {
-    type Location = FixedRegisterLoc<Self::Value>;
+    type Location = T::Location;
     type Value = T;
 
     #[inline(always)]
-    fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
-        (FixedRegisterLoc::new(), self)
+    fn into_io_op(self) -> (T::Location, T) {
+        (T::LOCATION, self)
     }
 }
 
-/// Helper function for register alias implementation.
-///
-/// This is used to enforce base matching.
-#[doc(hidden)]
-#[inline(always)] // for const eval only
-pub const fn alias_offset<Base: ?Sized, Alias: FixedRegister<Base = Base>>() -> usize {
-    Alias::OFFSET
-}
-
 /// Helper function for register element alias implementation.
 ///
 /// This is used to enforce base matching and provide bounds checking.
@@ -419,6 +380,35 @@ pub const fn element_alias_offset<Base: ?Sized, Alias: RegisterArray<Base = Base
 /// }
 /// ```
 ///
+/// In case there is a fixed register associated with a specific type in the base, you can apply
+/// `#[unique]` attribute which enables `write_reg` shorthand. This is automatically applied to
+/// bitfields instantiated via the `register!` macro.
+///
+/// This should only be used when types meaningfully represent a register. For example, in the
+/// previous `UART_RX` example, even if only a single register is defined with `u8` type, it is a
+/// bad idea to annotate it with `#[unique]`.
+///
+/// ```no_run
+/// # use kernel::{bitfield, io::*};
+///
+/// bitfield! {
+///     pub struct Reset(u32) {
+///         0:0 reset;
+///     }
+/// }
+///
+/// register! {
+///     base: Region<0x1000>;
+///
+///     pub RESET: #[unique] Reset @ 0x100;
+/// }
+///
+/// # fn test(mmio: Mmio<'_, Region<0x1000>>) {
+/// // let mmio: Mmio<'_, Region<0x1000>>;
+/// mmio.write_reg(Reset::zeroed().with_const_reset::<1>());
+/// # }
+/// ```
+///
 /// ## Arrays of registers
 ///
 /// Some I/O areas contain consecutive registers that share the same field layout. These areas can
diff --git a/rust/macros/io/register.rs b/rust/macros/io/register.rs
index 7d3160c4873a..6a89e4b60735 100644
--- a/rust/macros/io/register.rs
+++ b/rust/macros/io/register.rs
@@ -63,6 +63,7 @@ struct Reg {
     attrs: Vec<Attribute>,
     vis: Visibility,
     name: Ident,
+    unique: bool,
     ty: Type,
     array: Option<RegArrayDef>,
     offset: RegOffset,
@@ -76,16 +77,26 @@ fn parse(input: syn::parse::ParseStream<'_>) -> Result<Self> {
         let name = input.parse()?;
 
         let lh = input.lookahead1();
-        let (ty, bitfield_storage) = if lh.peek(Token![:]) {
+        let (unique, ty, bitfield_storage) = if lh.peek(Token![:]) {
             let _: Token![:] = input.parse()?;
-            (input.parse()?, None)
+
+            let mut attrs = input.call(Attribute::parse_outer)?;
+            let unique = attrs
+                .extract_if(.., |attr| attr.path().is_ident("unique"))
+                .count()
+                != 0;
+            if !attrs.is_empty() {
+                Err(Error::new_spanned(&attrs[0], "unexpected attributes"))?
+            }
+
+            (unique, input.parse()?, None)
         } else if lh.peek(token::Paren) {
             let content;
             parenthesized!(content in input);
             let bitfield_storage = Some(content.parse()?);
 
             // For bitfields, bitfield macro will generate a type with the same name as `name`.
-            (parse_quote!(#name), bitfield_storage)
+            (true, parse_quote!(#name), bitfield_storage)
         } else {
             Err(lh.error())?
         };
@@ -150,6 +161,7 @@ fn parse(input: syn::parse::ParseStream<'_>) -> Result<Self> {
             attrs,
             vis,
             name,
+            unique,
             ty,
             array,
             offset,
@@ -193,6 +205,7 @@ pub(crate) fn register(def: RegDef) -> Result<TokenStream> {
             attrs,
             vis,
             name,
+            unique,
             ty,
             array,
             offset,
@@ -207,7 +220,7 @@ pub(crate) fn register(def: RegDef) -> Result<TokenStream> {
             RegOffset::Fixed { offset } => quote!(#offset),
             RegOffset::Alias { alias } => {
                 quote_spanned!(alias.span().resolved_at(span) =>
-                    ::kernel::io::register::alias_offset::<#base, #alias>()
+                    ::kernel::io::register::OffsetLoc::<#base, _>::const_offset(#alias)
                 )
             }
             RegOffset::ElementAlias { alias, idx } => {
@@ -229,27 +242,30 @@ pub(crate) fn register(def: RegDef) -> Result<TokenStream> {
         }
 
         match array {
-            None if bitfield.is_none() => outputs.extend(quote!(
-                #(#attrs)* #vis const #name: ::kernel::io::register::OffsetLoc<#base, #ty> =
-                    ::kernel::io::register::OffsetLoc::new(#offset);
-            )),
-
-            _ if bitfield.is_none() => Err(Error::new_spanned(
-                ty,
-                "defining without bitfield is not yet supported for this type of register",
-            ))?,
-
-            None => outputs.extend(quote_spanned!(span =>
-                impl ::kernel::io::register::FixedRegister for #name {
-                    type Base = #base;
-                    const OFFSET: usize = #offset;
+            None => {
+                if unique {
+                    outputs.extend(quote!(
+                        impl ::kernel::io::register::FixedIoLoc<#base> for #ty {
+                            type Location = ::kernel::io::register::OffsetLoc<#base, #ty>;
+                            const LOCATION: Self::Location = #name;
+                        }
+                    ))
                 }
 
-                #(#attrs)* #vis const #name: ::kernel::io::register::FixedRegisterLoc<#name> =
-                    ::kernel::io::register::FixedRegisterLoc::<#name>::new();
-            )),
+                outputs.extend(quote_spanned!(span =>
+                    #(#attrs)* #vis const #name: ::kernel::io::register::OffsetLoc<#base, #ty> =
+                        ::kernel::io::register::OffsetLoc::new(#offset);
+                ));
+            }
 
             Some(def) => {
+                if bitfield.is_none() {
+                    Err(Error::new_spanned(
+                        &ty,
+                        "defining without bitfield is not yet supported for this type of register",
+                    ))?
+                }
+
                 let size = &def.size;
                 let stride = if let Some(stride) = &def.stride {
                     outputs.extend(quote_spanned!(stride.span().resolved_at(span) =>

-- 
2.54.0

