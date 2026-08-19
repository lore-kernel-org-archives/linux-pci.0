Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022139.outbound.protection.outlook.com [52.101.101.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A8045D5C2;
	Wed, 19 Aug 2026 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787137830; cv=fail; b=KkE8/xGV+cBX5xCpGk2Bp/+UM6M9nv2Mmfl5ugC/EnbbTVG4Ral5BFVEI3gyRH5QuYFdvO0cmJILySbCgZRkzLLL7LGt5INxbYUnVqoLNmCNklVniR8e7DC9TzsP9yu++qmrYVT0pcRAJjBgi0fQ/osrf4QyZK2WDB/osW24D/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787137830; c=relaxed/simple;
	bh=4IYGZYY5yfpiRR/pq59TMlwC0IwSy825+cZG4DHMQFA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=XrrQdeTZtqTwhuyVkXMWB7+7xNpacJZqU2dliq7BX61/WPVy3tds/BMwBr3CZ6PZN2XrBoOp9FK2U1HSwPRXJsif9GlTk7RefFEEf2p6KMNhfQWsn1I9nb4oIGYgWZoDXBw2ya/2vbbbZEAwPRoBh81t14mjNBiAnWkmiUKXb/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ix9eYWNL; arc=fail smtp.client-ip=52.101.101.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ix9eYWNL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjNiQHh5kl5OjNVI3264Fhv1p9Fh4+Qra7RM7q/vCHrgPAAgoRMhQblvbIsYT4M3mZV51pb7qYyKwu6zl7k4URXV4PLVgDZk8hGV0BOIElrgh8y6eQDkFcwcg8z2hOyYr+d/Hc8j1psgWRTcHH36ZGINqvOWy3xleNf375GM74ERIgXqyPWzeUv3V+zOQGHPy2oref+khCOwCXA88e2UsyLu94yW3EZB01Ms3B5FTnVMMFe8+xZ9otO7G3NVdQyrSkjVr5WBAPH1KXDVsLx9XEiLQh3dj5J1Iwptpf73IAYxd6hULVVdg9HcvHaTHfEHSLxnxf0A6H8MEHcrlH+naA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4E8hmqb30t8gQ5gAenzaXPjowRjYQsuGIN7wA5UX+s=;
 b=X0RwiHeDiKEDyqRXi8yj05JhqLVsQ5sLMIQnnt30PG0EJixkkTjJ50YHm1+idckarbF2uM1tHa+wEbkqgeL3n26IKdQBm1z77plKWK8eX0/SkybVjtYdAfAoG45F3BCZ5mXM+9zNGTDDG5ntCRuIVacKKXkAkll9uQyMr5LWM5MZOrkAspFcgMp8pTcmjza/N4IQ5zXRJ+KMe3sfRmSCRMmKDkK1yXyRnW9O2irwKRjjRARy1/AXJ0koFV6OEKVwkXmO59sC/2UU85gm/oZWVO9VsXx0yPxZfJ3hybRiBSF0Je6bIN9luGjOkZCi/pvG+tihVdkrEGhJohJHJUbO6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4E8hmqb30t8gQ5gAenzaXPjowRjYQsuGIN7wA5UX+s=;
 b=ix9eYWNLpGD1/+XA2DpYlJZTT9h8WYs1j/nJRLk2QZrDjFE2AV12qyQpKK+5EeTH3dDzZpSWsG2EBPXFPqwSBmdDXSfqGeF/kQMowM4BJFXjZ96bwlT9AqfgGoiYiGXIBs/gyqAiWNnqbA11XFJqOwNu5D+JsJrnduV2LzsjSa0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB5113.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:15d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 11:10:20 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 11:10:20 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 19 Aug 2026 12:09:17 +0100
Subject: [PATCH v3 09/16] samples: rust: pci: specify base type for
 registers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-typed_register-v3-9-3699a75fadf1@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787137814; l=939;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=4IYGZYY5yfpiRR/pq59TMlwC0IwSy825+cZG4DHMQFA=;
 b=SuQ4v2I6hN4e3V6lBsu61hpxoWKLl/Hb0QrxJ4ZCTh8jWsH4ZFin09GKn84MPBzlScqppVD35
 0p5QctW0c+zBy+DVtINeENhBGtsESZ/BtAEPps5a+FU5i2VcU0vSA4g
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
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB5113:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a7741ad-0b0c-4d0e-c617-08defde27574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|7416014|23010399003|921020|6133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uCTvdj5S4C8Vqee3xncLkZ+sIEMpdlUBk2wvQL0HTXc3DskcEFDwohLBtvbw7EPNhWcSokYnJ6iG1ZRuf4LucDbCed0ssKAl7zy7NIG+zvnH5hNFa4+VHkGMzZLEeXs3gRNcKwx2ZHt88/fmh89pgQslDzUnCOydZ5PLL5DpnWbcmDe1NfGFb2BTSGxXsWekJQmTbACBzmGGiKs1AS6UEKSis1C4rYxyVpgxPDJM7E66duFwoxVD3Bb72j04/7qBf9aKSVANKPTHXaTXMgOy3nQYewKu+oTkBXUBnPmVHRP/tGNhZ9NWME7PB5w3f+z8HkG9uVfxl7kJ18QkugbwhqfuPM74piOLmdUM6bRrVA8L7a1YBdfTt3W7e/q8f3997GjkiynI9DXfxFxPTTMj5nish3G4WZPRlpWhZ9IWvx9+FYKxsw+SL/6aiH/H0Zu26gOxxyQxx0zYr7GUrtWQBLsDWmKi0cLr6g3GvPLqCumcgZmIdUG797YdwRLRNUj4Rr4Ew5TEY7EWdEt1AYDTBtwVTDyAs1fGeNWZ3Ar0anGPb4YE0d8vVvKQhx8VFXtDj0+jQ+8fAjIR201Ft0n0yvKBpgbVgSJRCmtkRMqaiuK5xXxJng//6xuNjv9oB6qtyH2p/VPzE7in+Y7VcXW5brKMiCzNvhj2n/GyqhTYJKjnuDLbc0hPrD27mg2/GJvmWP8ZJryVlAqmkYwS5FS8bw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(7416014)(23010399003)(921020)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVd2M1ZGRnZKMmY2eWZlWjJqTDVxdzR4aFV1dDBZTnA3NmhzaDZpWDZRY3NE?=
 =?utf-8?B?SndaeUtldVk1Nm1ZL1N2dUJEajVlM3NyOXp2eEZvSFFwK3ovTWhuV3hoYWFm?=
 =?utf-8?B?UU4wZXM3ekhzY2Z4OVp3blNVS1hRaWw2TnBzWll5VzRiNnFNcVVoRmU2cmxt?=
 =?utf-8?B?TGVDb1FtcVZRNjg0WUdPWkFPNzBwWGdzTVNaeUZtQjR2RDE1THVxWm1LZHdv?=
 =?utf-8?B?UWhFb0NsUlQ1b010aitQZGVkRnhSQVk4TElYT2xPbHBza1lYYjRybi9TMTYy?=
 =?utf-8?B?T3pQaXBMQ0YwUFBRbWRLTlZpMWd4TTFnYlJVcVpWOGZuOS9TeFBSQldta1pl?=
 =?utf-8?B?TlF5aVUrZmp0K2tQSnhuZ0xGR21yVDRvZWVyODRIeVRDZ1BLMngvdFEwYVIv?=
 =?utf-8?B?YjIwT0lUMWE5T0ZYVkw2S080R0djbWZmMElzUzlvUUV2RmxKYmFJeVJCWUho?=
 =?utf-8?B?WUpTQUtoVWNiUnIxSDZnaGZ5ZElGaHRjNmpJWmxoYmthSk54Rjl2azNLSStz?=
 =?utf-8?B?cEp5clNvK216dHAyK2lVNVVjS3psZXovRk43bFp2NEVmUG52Qm5NM3ZHeVVz?=
 =?utf-8?B?VHZnVGRsc2UrK25OMDFyNk82RmpNV1JJY2g2OENDRDByM01Ud2pBS3ZIR2hU?=
 =?utf-8?B?QzhRWTNNQ3FhbC9SMWlZeW9mNFhGTFJDS2dRVlV2dS9KUUVybkNuRHZVWk9v?=
 =?utf-8?B?emFLaXkzSFBRODk2S0tkcitKMFFUZkhBQ1ZyUGpSY1Vjb1VQaXdSbDVjSWVs?=
 =?utf-8?B?SXFBRFFjYUNFK2QveWRHNmpDWTJzajI3L3dMV0NwLzl2OVg3eGxFVWFLTU5n?=
 =?utf-8?B?RDZHQTRFb216YjF5S3h4b016eEFrRUEzYjBxeEdwbE1DM3ZJVHVRMDEyRk96?=
 =?utf-8?B?UUJhTG4vQ0hFUDBmejlTTGthTkl5VXRFN0FhUTlkLzViSExqWEdqK0NLOVZK?=
 =?utf-8?B?WDcyc0ZFaUtMR0RFM1IrVis4alBiQlVkRDgvUUFaQ1FNTjk5cmJnZnhFVXZD?=
 =?utf-8?B?ZHBiQ1J3WGpxL1FvUUZxVHBNTVZuQ3p5UHd0UkhxdWNHVnJJU3Nvb05uWm5X?=
 =?utf-8?B?OEZ2TWFHNnRGVE9IY3pjTUVudnNpSHI3bkY1SjVOWkhSUzhyb0JYZVdsbU9V?=
 =?utf-8?B?bEdQRittYkpnY0g2WDMyZHVCai82MDZnNHkxNFg4aDdna0xzSEhzY0lmS3pW?=
 =?utf-8?B?V1ZmWG5lU0FyN2FQTWlRUlZVaEtGRXBpWUhiTmM2cFlXWkhWeVZLYXRqdWE0?=
 =?utf-8?B?bFBXMFVXc01mbE5DT01UUHJWd25VQUpSM2hqekxnQUFRRmZscS8wUTJRcU9X?=
 =?utf-8?B?UFRlQi95U21qNERrUk9JMm9KTTJYcFJJbm1hTDdKVFJpUFRINDZrdnd4RlJB?=
 =?utf-8?B?VUx5N29SYXgwYU1CR1hORW0rbVV1MmRpalg3dHZhYXBYVGxvRFEvVklNQ0lC?=
 =?utf-8?B?T2FtRlJZcS95eTdDOTFSSFlVSXFmSno0WGgwRHhJMGJuYnloNnpKdDJZUy9T?=
 =?utf-8?B?T3BNVHB6ZUgrYjJwbWZoMXBRN3c4Si9ObzRoMVZEN3c0dWk3QWsySDBKalZN?=
 =?utf-8?B?ZzEzYXZVVkFMRmRpS0dxcUdGRThOSmdaOEJ6MUUrOE5EdUZiUVZROWdjZlg2?=
 =?utf-8?B?dWxoUWx5MXExNHhGMGtnYURlL3p2Yk9nNDVydkdybER6SHExSDVnaFA2YWZr?=
 =?utf-8?B?cXZqL2hWSHdkdVRVOWdFcW1uMkxEbTZRaHg0MmhOSG5jSWhtWmtYMjgxT2ln?=
 =?utf-8?B?aWdoS3BvZzF6TzRTYzZ6Q3RSaTR0aTRFR01kOEdkalcvcmlNTDFFeWdkc0ZU?=
 =?utf-8?B?S2x2ZWpOeFo5K1F6QUR6Umo3VS9MVGZrR2FLN0xLeUhQT0ltaTJaTktOVjky?=
 =?utf-8?B?TUliVzBrQ1RUS3kvcHE1SFRSWmo5Zzgwc2NSbU00bHQrK3RBVzFyNTdzM2Q4?=
 =?utf-8?B?YkRpQ216TE9IMzE2b1VMUm9RYnFuNllseVFCYzdRVlJZQ0l5bUUvZUdSdmdQ?=
 =?utf-8?B?cERFWSsvSnMyK2NNeE1XR2I1YVBQa0R0L2ROUzd2Smc2a3EvVWlPeXlYOCtC?=
 =?utf-8?B?aHB3aHR5WUtTZGVjbWVVckhzZUVBQ2trWWFnYkZmdEJzOU9kQi8zWGNxOGlK?=
 =?utf-8?B?SlpXU0Z3QXZjOWVHdUl0ZS81SXM4eWtZaUw5eGlQOU1WRnlBcTFLUGZqbzNr?=
 =?utf-8?B?aFQ2YlcwRVRCaCtjYUhrVGdXTU16QzBsYjdOQ1kwcGlOVU9PU21YUFpPckRl?=
 =?utf-8?B?SFRCYlQ5RDJwbzlTWXBBdEh1SjYrbDBkN0tIT3ZJNXFBWFZWcWF1ZktLKy9i?=
 =?utf-8?B?R3lwMXpraUduMWkxcDg1OWJSRUtvTnNIaGM0YlJjVGFKRXBYQ2Q1dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7741ad-0b0c-4d0e-c617-08defde27574
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 11:10:20.8932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T2IsmLjpTNTpeLkxOhJm1PAsM3oIbWN0Xu1gDfE3Ybyr30zdMIk2XfN7muEgQVE9k2Fxhr/+vJwpJ3PVpAFS2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5113

The `register!` macro is going to require explicit base type, specify it
for both `register!` usages in PCI sample driver.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 samples/rust/rust_driver_pci.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 2282191e6292..13b035a95756 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -23,6 +23,8 @@ mod regs {
     use super::*;
 
     register! {
+        base: kernel::io::Region<END>;
+
         pub(super) TEST(u8) @ 0x0 {
             7:0 index => TestIndex;
         }
@@ -102,6 +104,8 @@ fn config_space(pdev: &pci::Device<Bound>) {
 
         // Some PCI configuration space registers.
         register! {
+            base: pci::Normal;
+
             VENDOR_ID(u16) @ 0x0 {
                 15:0 vendor_id;
             }

-- 
2.54.0

