Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022126.outbound.protection.outlook.com [52.101.101.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B3747276A;
	Thu, 11 Jun 2026 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195324; cv=fail; b=rTAeYSWE9Ro/kLjVdLq3H8LtRuRtHxG8e+vAtyUMLDpydKTnwQhtsdj+Ng1QFDMCEhsnZu67FgL5oDNq+yuDFp6nXVuTb64NMeH6E9hfa6c+1fp/poJuOq6dLKDsGKjb2FYy1Jwil26fNaj037zYq0OW7Z3aFf9o7iG1B1kyXDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195324; c=relaxed/simple;
	bh=BMHlZuqeKIOpjPrmR887sn0p/bQpz2qvFneWEVNxlaw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Rcij/SLESIg5X2M/UmCh4alEdiPDBQPkG0iWBDQGLGfzZN9PSCUYDyqzySYhEVT9zCVqwRviuDGu+Zif9xxNcjT253jSBj30on9My0epyxf2McZ6hMUG1rcDtVvot7D6dpfiY0bB7UmU2nhwZ8W+aZsxShCBCVbG2jBy/ztoN4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=GTqa9Eol; arc=fail smtp.client-ip=52.101.101.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="GTqa9Eol"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyVWMRqPuXH6dusikOBtsl/W/yA+xKooziVhcmBiFlToPvAXkp0hmsi60D3YaloZtCmKKglkBdMGXdNvXf9HLIyW+NDfBGwHus/lBI1ZVA3ctNob6hYb3LfVS6Qzbrty7UFdaalq7ksgEe1CdDuYz6YmI94bsfpz6aTm1xwgvTtHF62qsR6fXiPa4lErXGq8e0DPZGtCnIs4eeS/INs9plEXKwFEnlIqRpV03BgDyXaEetM948S5UxEw4IQ6mrrWUk0hyDWb6I3yDBF2P1CHCHysSDHoI2dR7QtY7rgwKKHgycjdG6FttCUd41xD43Pj3ZmADvf+6uqcosdgUb3+Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yeG2do/HPdyDiGshtJW0A25oqZztHLd7ZA0ynJO+RcM=;
 b=ajF5CO4Y8im5YZInY0kDyyKaEBAZOVAOz5qvZo/ddpztWuEAsG6ScTjoYgn2EFzFxswTjldtXis4M4GMlov61HrLHslfldTdDuq1eH1klzr7ZgtW/7hO3MJDzaaiSnJidH43xbkg90LNepe2HVB361Bjb/Um1/bcebQn8U5+4Q3E8C7pSHU1a38wccMFo5Jw2zIM6kVh2OcgOG+vBLxm4kSBxUgU/awfUMvMXYRpHI3KQ21TWQtufjeL02wLuXwLd3eu3SdT10M9KTdVtW27/kmHO18cDHde9jfr6y4uSr9iYU0hlRhL9WnaVdf6im5oXJucAGGv10wnNmH4jKBfSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeG2do/HPdyDiGshtJW0A25oqZztHLd7ZA0ynJO+RcM=;
 b=GTqa9EolGZmYjs5H0mn8xeHKRbc8LA2xrKrBaOii96ggNmxON/C3DSOCk71Ycc/JpvyPQ+cH1uDRzloOpbnmw643BgOlCkMlQrizn4Qu7/NKYC9fqSttD8UpxbbE9Nmg7LV8J9EJ4ZTsiLLqSOi1gIdgH58trtViYaPKauRyBCE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO4P265MB6525.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 16:28:29 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 16:28:29 +0000
From: Gary Guo <gary@garyguo.net>
Date: Thu, 11 Jun 2026 17:28:14 +0100
Subject: [PATCH v4 12/20] rust: prelude: add
 `zerocopy{,_derive}::IntoBytes`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-io_projection-v4-12-1f7224b02dcb@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781195301; l=1101;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=BMHlZuqeKIOpjPrmR887sn0p/bQpz2qvFneWEVNxlaw=;
 b=lCIwzNaVjx8MgBPV1IrNWjj9xccFQYcWNGRMCqNm4DRaWfnbbllB1X/ZqkxXDj3KEo9De0ubS
 9XuW1zV5SfYAwuqMK4auTLMdh+kAm+jp6CNoWm1WL9A+zQJ05p1XrG5
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
X-MS-Office365-Filtering-Correlation-Id: 8536713c-55e0-4d2a-8b15-08dec7d678ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10070799003|921020|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	x7xVhm/pEhMTjjlA/5KJxWhCLJDNaFo6qJtlfaTgnGGUr7UBGJpSW2nV6AbyVzBzK7P9q9aCUYdOPf3ONf0Tpr6rHWQkOX/UVDeN61ELlnqkF5O+GGJZP0/tS3OOW27b3744hRWtaionnn/Z5H0gRMdvfyc/0p95C0QCXST0qC/TzcTyDAqJyKbP+Dz2QdapSP/2lCD+7khwkpMT6zVtDVlcoNnkGZ4y/Un8xHpLrdR9TM5TAoHbgCQdct0LQBb2BlS3xImNKwR7McfGipWBbjdsWR+O0hlBlgCGudeMCqUBC9nFzzRuW7Fl2kEcSIlsOzd2HTVScxojcgfo6lv0So07rIXSo+SwvEX0gf2PT7lz1i8JKEIPX4rD5oBfTX0WXBmgW/I624RqmQLNCEuAounWDIxL1IQWXhKqfyWwnTyj5BWsY7t47eBekoZG0vcun6FhXe/UX3/aYXjwon9kXkhERk5wHnuqOOSRysqvdNLRI/sDFLwIAJLgn2wrjJeA3+1keX7G26oy9oODaCjWGwc79dPi05ohLC6W93NeoiRYdiIhTwCwasYtiGdRIKHefFi6dbirrIMbp6gaI7WdsxgRSSmzymdkEZQWCIqFeIIz1aikf+DmhHbO9lifrY5MQwFyRCg90XIZQrm8TXLyoftML9WY/dLXbXxcUYI46lDSfT05Vz9HPc973SowHa3bY4pXEy1WddVlk29iDbsNERExCRb0ncdLnsJ6KX0DDFs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10070799003)(921020)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R05zSExqdktQaFJ1RTV6MWNZVEZMMElGY2xtNXY0SE9zdUdnSWs5NDVUWm9r?=
 =?utf-8?B?SlpkWlgvMTZCYldDNE1LRVpnL1c0Snd0Q2xVTTZ6OC9zd1RyUW1nUndqeHZo?=
 =?utf-8?B?UDFyakcxeHVOcHl5ZFN5NHpseVhrSHlBU3NJZUYrN1RJT2xQQ2N3VjdERmRm?=
 =?utf-8?B?cHRaMTJYR0EvRU54NWlwM2o0VEpzY3M1ZGhmdVg1YVhKRk9vQlhJdE5uRWlK?=
 =?utf-8?B?OTAya3pnMDJhL3VWb29ncUNMNUkyOWduWFlTWThvblB6Tk5UZ2pYcnoycTB4?=
 =?utf-8?B?MXg4RWZqS2xKVGtrcTFpTVRZZ3kxN2NtWnNRdHllNEtsNmxIR3RuR2FGU0JY?=
 =?utf-8?B?K2wydTZuM0JaaHJGK2d2STR0eFBXTEgwc3lzOEcwWUwweEJVNVk5cThiNDFx?=
 =?utf-8?B?YXhUb1o1YVcxU3VMRnl4Z2tzRi84OGVHakhMS2dUN0xzdkNVVHpqQm1uT1pE?=
 =?utf-8?B?dkluSlYyNEpabjcvNXVWdGVSM1BNSm5tcktBVEhMTzhaOE5vZ00yb3c2ZWUr?=
 =?utf-8?B?emdKUHljNk9LMCs2WklzbzZPT3YycjFjRHFtQm51Sm5oL285cUZSMU5uek9U?=
 =?utf-8?B?VVh3MWlpRUVlSUJMMlhWWVZOcTBYb25qVXYzT2Z6S25rR2MyZzlQMnhOYlhJ?=
 =?utf-8?B?L3ZCUm9HSDNqVWRmWnR0VlVnVUlyRXZGUmovTThCYnNYZGZoeGYyR3hpNDIv?=
 =?utf-8?B?VWk1ajBaYXl1QzZmQzhhOHdGeUhKc3NPVDZqalArVmg0RXE2UW9XbEVKUHhY?=
 =?utf-8?B?aENBWk1MTmJOZjRQUjNnM3BqMUJhd3NnNDdheWlvRE5VVEJJYW91azIzajg1?=
 =?utf-8?B?OHU5cUVUUVNQSXA5MmdRZ0Z3b0VUcVVHSzhtQUJuRWdma3JPODBvMThkU0Ey?=
 =?utf-8?B?bERxeE9SR3VYd3FEWG00di9ZUldocUh5Q3BCeXhwb1JJanowRFhiQjZLc1pu?=
 =?utf-8?B?am9PUkVoYWlpaDhwZkVaQ1hVUFByRm1DblovcXRMbjh0YmlJbzFGUitOL0JG?=
 =?utf-8?B?OVdJVWdFT2VxaXd3Zk5ReHY4a0JiV1R1QmJYVXYvbWoxVHRBSk1VTlZ0SjdF?=
 =?utf-8?B?d2NVUGI1b09UV1htMWlxUGlWWEpUeDJkeG9BbllXdDZhY1h2OUxKcldKUFJu?=
 =?utf-8?B?WStBREdzdHdRRkxJdGdVU2pqM0RDWnRNdE14cHJ0U0RBbmVyTDJkTklyamty?=
 =?utf-8?B?b241a290dVVyaUdFYWFHZEh6Uk1GS1RZY2RMbkVRN0ZKdjBCam5xSC9vcGxi?=
 =?utf-8?B?TFJ5MUJBWWNGMFNFYjhyWExRb2xnL21GRnlPWjltb1M4TGxoVkdTT3RiTTlI?=
 =?utf-8?B?d2RlWDFZN3g0RFRwMHFpMWdVS0NWTVlvaUdPYVVJWk1pOFEvT0RhYm0zTUJU?=
 =?utf-8?B?dXVnaFd4Q043SGlCUEN0NkhKWUt1RHloTk9Lb0k1b1NYU01IcVJPSmdnSGo2?=
 =?utf-8?B?RGIxQjFuUkVnNEdkS1NEZEwzV2EwRmRnK1FKVjVCaVl4N2Fwa05wWEpCa2g0?=
 =?utf-8?B?ZG9jMk91WFdlbFl5aTVkcFoyNmZpVmF5UEJLRGtzZm1jWHpaWE5GQ3NWTy9s?=
 =?utf-8?B?T05uRnNlMFJBY1RJKzIxYVd2VzYrU0RQNGdSYUZ6Y2dDd1grNEZwMG92YmRX?=
 =?utf-8?B?TVluUVJzdUhHZjFvT1lXNHlQdmNJbkRadktaSHdvU1FMblpORnRPdjNRd3Jz?=
 =?utf-8?B?UVRRRy9rV1Q4ZDNhT0kxZjQxVnBOc3ZuY2U0dTZ5Tk44dzA0WHdtSGQ3cGV1?=
 =?utf-8?B?VUV4Wlhha0tDL3o3NHViVzlSS3lPZGl4dXB6b2YvVjh5UU1aMVBJVTBrWm9k?=
 =?utf-8?B?RGlLQ2dreGR5ejQ4K3FJYUVvYWtHT0wya3F3R3RFQ2Foa1NqR3VkaCt3Nk9n?=
 =?utf-8?B?bG1SZW1tMmpRRkkxaEJqTWIwTTZwUzAxZExreDV3MkpiajQvTTUwRzBOSWJt?=
 =?utf-8?B?K0tHbTdldjFWWnJsTnpDS0Jua2VIYTBueEQvLzhFZ1N0T21LdXJQVlhhNURq?=
 =?utf-8?B?bkZHcHZUbWdIUnk3ZDdCdmxuVW9iS1htR1pqWWxtVU10QmNaOFJzSnRYcmxr?=
 =?utf-8?B?ZjlaK3JRdEwxS1VXZ25GWnpzekZ4ME5kVGRmeG5CdmVuU2RwSFhmOUd1cmVH?=
 =?utf-8?B?eWpraGtQU2diTFJIRURqeWxrTlJ4N1EyYjJ3NHk4QU94elFIdm5aZUpjNkxO?=
 =?utf-8?B?K2VJbGFuZ1R4b2F6Vzg5OVNMbS9GbjBSaWYyWE5BMVBPeVM3OUlESGhmdzdv?=
 =?utf-8?B?ZkhOZXVWdUdML09FcVBEU3E0Y3dqbjdtQjFFTzQzMHVQb0tnOVhVNldUNVl5?=
 =?utf-8?B?ejN4ZDlqaVRzTFIxeTFhbWJUUzVmQno2MWpRRExIMTBwYnpHVGRFdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8536713c-55e0-4d2a-8b15-08dec7d678ca
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:28:29.7467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DevV/J5/t9LJC+UjDW8VuCuHaTVvIavNpuq4ivnNk/1pyJ3kZT3x89+x6sFEa2uJ0LYIzGKSPr5zCc7i9PsOmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6525

In order to easily use `IntoBytes`, add it to the prelude.

This adds both the trait (`zerocopy::IntoBytes`) as well as the derive
macro (`zerocopy_derive::IntoBytes`).

Signed-off-by: Gary Guo <gary@garyguo.net>
---
This is wanted because I want to convert the upcoming I/O projection series
to use `zerocopy` traits rather than keep using transmute module.

It is most helpful for derives in doc tests; I do not want to explicitly use
`#[derive(zerocopy_derive::IntoBytes)]` in the doc tests.
---
 rust/kernel/prelude.rs | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index 8a6da92e8da6..ca396f1f78a6 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -61,10 +61,16 @@
 };
 
 #[doc(no_inline)]
-pub use zerocopy::FromBytes;
+pub use zerocopy::{
+    FromBytes,
+    IntoBytes, //
+};
 
 #[doc(no_inline)]
-pub use zerocopy_derive::FromBytes;
+pub use zerocopy_derive::{
+    FromBytes,
+    IntoBytes, //
+};
 
 #[doc(no_inline)]
 pub use super::{

-- 
2.54.0

