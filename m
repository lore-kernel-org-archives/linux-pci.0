Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020099.outbound.protection.outlook.com [52.101.195.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048EE3EDE53;
	Mon,  8 Jun 2026 19:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948765; cv=fail; b=bfraPbeJBvh77wmSaGLBEGYZocU9olVyE8ABDEU7ngVBMUCGjQ15hzqPcZF6DpCqcTDYNIDU/JMe6VPwDYlb8aKR7k4m50vlIkaMOJ8Zhq95mzv9yOf5qV+NCj3XkFlrOwkwjweGmabpSuzJQkebhqZpLsWWF1dRhbys8D9HOvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948765; c=relaxed/simple;
	bh=asZ8rlzSXV0U+EZg1Fe9smEUk3vFTSWP3reSKao5plc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DkwwFxlPmfGXTR8KPY7gXGwT/3h5pidqM0/8k5eNEZfFAWYcYFCTo2tP8zC3EgLp3NROG4tvLjIP724vKn5/hurgeiwsHV28r7jCLr8E/6gh0I9Z93oZZxSJiKf0N7DYDczvCrKv3fX2/UPThaHB38HZvwoILTBd0xy5Yo33AZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=HMh5naKX; arc=fail smtp.client-ip=52.101.195.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="HMh5naKX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZJ24nXNv+aHRu/Poz3ftMt+6zhHn7kFmbadyldLJdWb+xsMZaAtG3HgR0FKkTIfXDPri4d0i2wsThXzEWdr2hymEQUQUhm+gF7YooCmuowy+M8Y0Qfyf9LPLLogtjgAZlYuOZg47xIHKcpm8Ewz9uYm2MJSNnVxAm1OMlMgSSCggeq3G8z5A68DnQBYJrOAT2/ytHaO0i++Bh/mbrrNwUiH4lqURdK4AJf/rEGqD/osyLP3BS39xJYGuYoQFjNhcaMVT6j/CK/R84ZVJ+IsuVcdw7z5lh9LHkwpLHFNxGdmRQ8b9RpgGIGZUMu/3L/cl9s2vOwE9MqTYzU+XhhQ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0rnkgChXX3moDTT9hxo4eQ4gldoJ90V5SBu8bqZpg8=;
 b=xT0rnnfVEiPTP6yfAetSojd4klf3bG9+wCXu4wnRoUOgTOkGKyf/YXAZG3jw2L1ohFOkpvmaNvhot3RlG2dyMlVso2V1uj+uEZ8TmJiahw0PmQZJvgDk9YuXpiv8fLytjE5siC+1TBGQ7Ki8g/9SD95ickgOt29I1GKk2/HNxSEWw44m8UXrzymPDMS31RWkUyA9biitZzjZmMcpObHAN7pLUlMAzY9nepbEALxEH36Eu3cdBzxanLvKRlctX6cPwiWlpLTsJnN4CH9kZ8WCiZXG50t8FBopr2Uh+GjgTGtgUtdTG9B+lsOgqjNSm/Xr9WWCmCAV4B/uFTMuSeT+Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0rnkgChXX3moDTT9hxo4eQ4gldoJ90V5SBu8bqZpg8=;
 b=HMh5naKXEPCJqFNEh7/nfNcgHDIxVmZrE91a/uZYuj4LTfGsQ4u48Ri38el417VKuShGbUIUmQjaNqRU63QKxJOyLEu2JmbdRQX0EulmGJ9ERkff7d+ncK6WGynlBUt8QPv30KjbZ+gcgOfRFOLBtOB488Bx/I/M3Pil9VW4MKE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7398.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 19:59:11 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 19:59:11 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 08 Jun 2026 20:59:05 +0100
Subject: [PATCH v3 08/19] rust: pci: io: make `ConfigSpace` a view
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-io_projection-v3-8-c5cde13a5ec4@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780948747; l=5574;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=asZ8rlzSXV0U+EZg1Fe9smEUk3vFTSWP3reSKao5plc=;
 b=1/TgU1LhqRQJCj67vYAJwPqRax/itwT+A8si9KDuxJOwW6on6fdLfKJ/YZAbOuDvYdFUxIySs
 HkYGcwWuuarCNqhiyXtap8Td+y/TSmEdgzp/eufTghzkRM5yVvw1uSI
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
X-MS-Office365-Filtering-Correlation-Id: 7cc7f9db-4039-4b05-0b23-08dec598687d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|6133799003|22082099003|18002099003|921020|3023799007|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	Aj8YNjYZUhQGP3QXu+PKA7N7MEdE/XwvhvaH3J91lbPVeRjtmvgLrGeNzWWNpQB6oygRFBSRRrdK5r4btM7ZA9ClBIVIwoAlQMXXGOK/O54OSoXWmIHw05IeH//xwa8toar0kyozSygi1aVzJR1wHRo2I6/8XYHCDsf/mkCRRV6gGlGsbdWxxWtLCDjQvTObvqXhzKaq4259oXxlxaKigXJBOKfUIVXS8dM9JBsHRI6+/vPytIBzVpCpIkLN08bpBpR7SeCNIhvxA3JfFsjdO1yhWkTEJDFVakVFon2KIyPVqV7JLvlSKnRBVz248f/t6VSwUBoN37ntSvqRx3L9OMQrN1vsBxxdTDoxsC4TDq72AxS7M8a95cULIDaP2lp0KjHVmKs/c+zagbbe35z5JQjDd6+7/JcIEU8tp8IzSzvjpieguk32tRUjS5b1u2EaxIpuQpmtVAq11mXCU2GKxQYHGbn48FK3VTkRpU7g/I7qVAVaZ/PabWmcPPu/aLo5Xi+FW5D16XVy5dluWMorU4M5ky8F6AZnvHxNk9JlmsPu7FrNaac/7Hn5O0UDgvc9CFfZqkYdKLz/HDKjmMpv2X+BcM39rz6qd16LNIj6REAtWl2ZuNqO/LDD4b8rMiaMbbHgZxQQa67fY6NLKWWrSK3ytqIHtreHaQKuGiioLcGI2DvXJhqB8TxFiuMQrflmkp9B8vRI3aYv1iDBKzS4EWu7cErrbUgZaplwiswfXW4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(6133799003)(22082099003)(18002099003)(921020)(3023799007)(56012099006)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUhJaDZmdzl0NmVWMXI4aXZ3UzYvekxheFpuU3BKK3ZiRFJaY1NpcVM5bk00?=
 =?utf-8?B?KzFwaXpsc3RMTWIxUWg0ZUxIU2hqdnhJejlkbW0vWHBvN3JSaCtlUGxSZTVu?=
 =?utf-8?B?Q1VZZEdKQUhPaERyUHhsZGdWR1BXbFF1T1dlVHV2eG5GdWZJSU1OTVpoejhi?=
 =?utf-8?B?SUhqNzRVSTB3cVdNc21McUgwUUplZ1FvNXhqdHFrWjNwQ1EvU3ZGL1ZxYUZo?=
 =?utf-8?B?TVNOMlN0cGNlNHpURy9tZ0VZa2p0TUlhR2l1Qis4aVpDeURuV3B2Q0U3TVlT?=
 =?utf-8?B?RkhWTGZLZEx5Y1pwQmNEWEZKRUdHeFlCWEVpbjB5KzBmNGRwYlR4OXRYM2li?=
 =?utf-8?B?ay9ZVVgyMUsvazRDTTZza1VLRXFtejZuc2syWE5lNENUTnBXSCtycjdnaTFs?=
 =?utf-8?B?VzBHZlFVQm9BdUFubzRxb3pOSU5GNWczalBOaDdaVEV6MWpodWI3SHFYdmp6?=
 =?utf-8?B?eGpXeEZObGlseFdFd1d2RGFoZGZ5VkZQcHhDV2V5Y3lGcGgweDJ1M2thNnFz?=
 =?utf-8?B?V2M2cHNpMU11OVAwaWhxemNuZDFTSnVnNkRvR1hBV05zUU9naUxQOVpsZUxN?=
 =?utf-8?B?czM1SzlHYzVpNFJYSGdua0ZMV0lTSDFoajc4SHdSTVVBUUZTVEpsNUl1UUd2?=
 =?utf-8?B?ZVBzcmlub3NTeUcyQ1Z6TGsvdGtKOStTd0hWZFc1dW5zamxtbDQyMGZlWU5J?=
 =?utf-8?B?SmVVNW0vUEZPaGpGTVVyY2xwWDMzUmNiMDM3eFMzY3dLZ1Y4UkloUjNUTk1J?=
 =?utf-8?B?bjZ2R1dkbWhOZUtsclZQZHh5WTFMdFh6MEJabEUvejdPeitzUTdhRnVuOGNo?=
 =?utf-8?B?RUo5bEk3ek5uVXA5ZVV1VitNYVBBUW5NVXVseExMVE1xWG9WZDErczVHVnhI?=
 =?utf-8?B?NFFpZnBqM2d3TW9Qa3JBMnpHUjV1VC9IdGdWYURqc3VzMFNKS1JWSytSeEJh?=
 =?utf-8?B?RkNzZndtU2x0Mk04VmhpQlBvUlpERGJlVDY4YnpXdnpSYnhPdkJNbHpvZjdV?=
 =?utf-8?B?VnJ1SmIzWVdiS3VQT3ZnVDljcFhCa0g5NUZIYW5ocFN3R1drU3JGY0JpM3Ns?=
 =?utf-8?B?VWNnT0sxcENOZ2FkVndRRUJuZi8wN2UyeG1paXBxdHNyRy8vd2tmL2xpdHhp?=
 =?utf-8?B?bEtYL3R5SkZrK0JROEF4dld0UnJLaDlTMlhqY0JMa3ZtSDY2ODR1QUJ0VDZQ?=
 =?utf-8?B?ZHJHZzFzOXR2a2YreWlZc0xwWVVMbjBGYmVwYTBHRitxVGIzV3ByZ1lQcnN4?=
 =?utf-8?B?RlZ5UDhGSWlrMXRYUGdrOU9jcUZlNm1vZjJoNjZsSHA0aURBRzNyWDh4NFV1?=
 =?utf-8?B?bm5rVGlqSCtLMmtjQUptQ3FleC91SXdIemlLYnhaYnlDeWFBWjZoZWs5WjJu?=
 =?utf-8?B?YmRRYWJYYXFWazFvTGpyT29LRjg4K1F3N0V0M3Q1ejdsRldzcmRYWGRMcmlj?=
 =?utf-8?B?YSsvL3JIZ1QyVnh2R0FneTMyZVhOdjZ4a3VLRVNMYnJPZ1VCQk8vTjlHUkFE?=
 =?utf-8?B?My9Nb3I3a1lOeDJpM2lpN0dwTDh3cmJSY3VDUUh4bTB4TWlUZ3IwVVdQdXdo?=
 =?utf-8?B?ak0vK2pyTTZWZ3RPek4vL0tJYVJ6aFRiaE1CbU5LS1ZyZElMc3Q0OTl0MGo5?=
 =?utf-8?B?U3krZ0FXVy9qdHUraWVHbE4yVkFOMks2M25JYXptcC9mMXdTNlBhQmZVV1JI?=
 =?utf-8?B?Q2VVVkNVTE9Qc2hjRUVEV29YQnFNWkMxcW04U013U0toN1FtWlFsdWhCMVho?=
 =?utf-8?B?cXg5djgyMG5mand5M29ZcUlBb3NuazFFQXArZkJzejA0eWx1OFc0cytuNVJE?=
 =?utf-8?B?czZzYWI2emNXTk12aTBWQVorWkVMRXVnOWhFdlAvbWdjb1RlS1VUVUE4aDM1?=
 =?utf-8?B?UmdLS01tVzJmVXA0c2tRV3lacWFScWhwK2t0c0ZVVS95RFVqRnlqanlVYTIr?=
 =?utf-8?B?dFo0RjJtdmh3R0QvQ3dFb3dQaTY1NFR5eEZERkxtNzM3OHVTcWlieVVJMWJj?=
 =?utf-8?B?c01ZY2t0SUxMdmFmYmpaRXZuL1RHRzJUdm5XRGhLNWRqUG13Zmd0Wmh3eHYx?=
 =?utf-8?B?SkRpemQ0cjNobG4zdFRsOVArZHdMZnFPaFFvWUZjNW8ydnRGNFR6U3VXdTIr?=
 =?utf-8?B?a242U3VGSk83NTZpRFZsMW9uOHVvOE0wVFV0WXh2S1BiQWNQMmhiQ3R5L0tQ?=
 =?utf-8?B?RTZaZHhaNTIzV3pia094OEJpeUhVL2RXRlBERE9rcFF2QkRtZklTamJIV2pT?=
 =?utf-8?B?VzJMSzA1eFphbUZvWUh2LzZUd0t5ZzlBR0dwYVZwMXBza05IOUNIUnpRMzlo?=
 =?utf-8?B?T1dMZ25Jck5kMHZqQkVtdHBsc0Z1NndtSldSNzZVNEtIYm4rZkZBZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc7f9db-4039-4b05-0b23-08dec598687d
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 19:59:11.2743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/2N5O0d0TFB5auX2TzVSK7u+dwK4MCplA/VN2mSJwISGuqb29X+lDxqByhcFCeRWD/fYJ1shZ7OdCWHbznY/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7398

In order to support I/O projection, we are splitting I/O types into two
categories: owned objects and views. Owned objects have a specific type
that is related to setting up and tearing down, while views can have their
type changed with I/O projection.

Things like `IoMem` or `Bar` are owned objects, which requires setting up
mapping and cleaning up on drop. On the other side, `ConfigSpace` is really
just a view, as the resource is associated with the `pci::Device`.

Remove the `ConfigSpaceKind` bound on `ConfigSpace` and make it a generic
view. This means that `ConfigSpace` object now represents a subregion and
therefore encodes offset (as address of pointers) and size (as metadata of
pointers) itself. The full region case is still supported with offset 0 and
size of `cfg_size`.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/pci/io.rs | 58 ++++++++++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index e0acb62f58a2..a4cfa1ec6e62 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -18,7 +18,6 @@
     ptr::KnownSize, //
 };
 use core::{
-    marker::PhantomData,
     ops::Deref, //
 };
 
@@ -53,33 +52,36 @@ pub const fn into_raw(self) -> usize {
 /// Alias for extended (4096-byte) PCIe configuration space.
 pub type Extended = Region<4096>;
 
-/// Trait for PCI configuration space size markers.
-///
-/// This trait is implemented by [`Normal`] and [`Extended`] to provide
-/// compile-time knowledge of the configuration space size.
-pub trait ConfigSpaceKind: KnownSize {}
-
-impl ConfigSpaceKind for Normal {}
-
-impl ConfigSpaceKind for Extended {}
-
-/// The PCI configuration space of a device.
+/// A view of PCI configuration space of a device.
 ///
 /// Provides typed read and write accessors for configuration registers
 /// using the standard `pci_read_config_*` and `pci_write_config_*` helpers.
 ///
-/// The generic parameter `S` indicates the maximum size of the configuration space.
-/// Use [`Normal`] for 256-byte legacy configuration space or [`Extended`] for
-/// 4096-byte PCIe extended configuration space (default).
-pub struct ConfigSpace<'a, S: ?Sized + ConfigSpaceKind = Extended> {
+/// The generic parameter `T` is the type of the view. The full configuration space is also a
+/// special type of view; in such cases, `T` can be [`Normal`] for 256-byte legacy configuration
+/// space or [`Extended`] for 4096-byte PCIe extended configuration space (default).
+///
+/// # Invariants
+///
+/// `ptr` is aligned and range `ptr..ptr + KnownSize::size(ptr)` is within
+/// `0..pdev.cfg_size().into_raw()`.
+pub struct ConfigSpace<'a, T: ?Sized = Extended> {
     pub(crate) pdev: &'a Device<device::Bound>,
-    _marker: PhantomData<S>,
+    ptr: *mut T,
+}
+
+impl<T: ?Sized> Copy for ConfigSpace<'_, T> {}
+impl<T: ?Sized> Clone for ConfigSpace<'_, T> {
+    #[inline]
+    fn clone(&self) -> Self {
+        *self
+    }
 }
 
 /// Implements [`IoCapable`] on [`ConfigSpace`] for `$ty` using `$read_fn` and `$write_fn`.
 macro_rules! impl_config_space_io_capable {
     ($ty:ty, $read_fn:ident, $write_fn:ident) => {
-        impl<'a, S: ?Sized + ConfigSpaceKind> IoCapable<$ty> for &ConfigSpace<'a, S> {
+        impl<'a, T: ?Sized> IoCapable<$ty> for ConfigSpace<'a, T> {
             unsafe fn io_read(self, address: usize) -> $ty {
                 let mut val: $ty = 0;
 
@@ -112,19 +114,17 @@ unsafe fn io_write(self, value: $ty, address: usize) {
 impl_config_space_io_capable!(u16, pci_read_config_word, pci_write_config_word);
 impl_config_space_io_capable!(u32, pci_read_config_dword, pci_write_config_dword);
 
-impl<'a, S: ?Sized + ConfigSpaceKind> Io for &ConfigSpace<'a, S> {
-    type Target = S;
+impl<'a, T: ?Sized + KnownSize> Io for ConfigSpace<'a, T> {
+    type Target = T;
 
-    /// Returns the base address of the I/O region. It is always 0 for configuration space.
     #[inline]
     fn addr(self) -> usize {
-        0
+        self.ptr.addr()
     }
 
-    /// Returns the maximum size of the configuration space.
     #[inline]
     fn maxsize(self) -> usize {
-        self.pdev.cfg_size().into_raw()
+        KnownSize::size(self.ptr)
     }
 }
 
@@ -281,23 +281,25 @@ pub fn cfg_size(&self) -> ConfigSpaceSize {
         }
     }
 
-    /// Return an initialized normal (256-byte) config space object.
+    /// Return a view of the normal (256-byte) config space.
     pub fn config_space<'a>(&'a self) -> ConfigSpace<'a, Normal> {
+        // INVARIANT: null is aligned and the range is within config space.
         ConfigSpace {
             pdev: self,
-            _marker: PhantomData,
+            ptr: Normal::ptr_from_raw_parts_mut(core::ptr::null_mut(), self.cfg_size().into_raw()),
         }
     }
 
-    /// Return an initialized extended (4096-byte) config space object.
+    /// Return a view of the extended (4096-byte) config space.
     pub fn config_space_extended<'a>(&'a self) -> Result<ConfigSpace<'a, Extended>> {
         if self.cfg_size() != ConfigSpaceSize::Extended {
             return Err(EINVAL);
         }
 
+        // INVARIANT: null is aligned and we just checked the `cfg_size`.
         Ok(ConfigSpace {
             pdev: self,
-            _marker: PhantomData,
+            ptr: Extended::ptr_from_raw_parts_mut(core::ptr::null_mut(), 4096),
         })
     }
 }

-- 
2.54.0

