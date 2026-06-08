Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020099.outbound.protection.outlook.com [52.101.195.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01EB2E9729;
	Mon,  8 Jun 2026 19:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948754; cv=fail; b=jYxAgwru7Gb4KMwDK2hyQL3KgIoecbrfTtnyWKzaepKVjK2PViDeNOhn6cgPhUf303TamuJW7Cu5ER9G9ZA0zoqxfhuzzPeHkVQZmtbfzHiv5+R42KPKxZy1k7h/lvSoaUBw24BZJ284QEZXf+8++VNdN0QIfhuRtAteB6T3ozw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948754; c=relaxed/simple;
	bh=9kc34t/fCVoNLZv+3VpTgeN7MieeNOygy8GCKlBxPz0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UU6HEWXZ0ksPr9tl/rEy2jC68Rr+KMJKlYDQYZYfVsGHLgMbVcNTPKJxNYPPTQviLj3BIaQlmBFt4QoiMEgUVL79zGaGdYVC/u7jPP3WONNh8ncygHb1EjhkFJy9j7l7PR4648p1FTCALnziIjHqHkECI3WxOtWJlwkaczsI974=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=IBFbL8s9; arc=fail smtp.client-ip=52.101.195.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="IBFbL8s9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUuV2Zk+jJgXH0LsJWG6/r/xNogQUaX+Wty8J6yMPD4qCCsJtUyd7qIt8pkhA5Ejo2xmnbVMj6gGoPl33GVnloANON5q/Eu8qX4JDQXiVfXHTHChtbHQIYrmJPO3a0oLdsmFFTgYnZoF9yb2NOMwiQQMZ3J1pjQ+xyMgqpbcVDgQANcDIYjxAW4YzrvZFq/JAPYrb0MZTXHTJcdkK10jORXOAHPxMNVAFWC83Mu+aNU574UQ2PJShn6BlUsQWYpqG6/jw5/ku5GpOA2AzrfXmdFak+t2fHwiKiJzELRcHY2rBd34/fu6lASZwzqYxGoaVADbPAMMQ39KRXzMuyEzyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ND1fcK0zeZsQ7guq4wiThRCNimjDJvRCl85vTSMKHN4=;
 b=MGA/lvK5cYkHLdTdAhTCbbhpYHJbks/u1xi5ZlfUcjLIxZapCIC8ZiwyptDug8DCjQGp7L30iEOtZRY4yv7n4ZjWT6Gd23bp+BCOU/6aMfV4KMYAPBLZktqWNi+/wDboBwknumgigujBITldwjykEuxEyedHlhvMaRRpN6f3dbu7XMFtuC3xfeq93cgB/0q40C4LvWeJRO8IJStQWMIuKupr468qVbiwlwiAYOm6RBkObCZq/ja6fBVe1sYkN9dqnkt2G+tQGoli6YmzJ9MShzFtDPX4O4OyYXN7ZEFqEP46ezOdVi+Eqw9wHhsJEVK0uav7ppSykJxgHoR1P4ep8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ND1fcK0zeZsQ7guq4wiThRCNimjDJvRCl85vTSMKHN4=;
 b=IBFbL8s9Ep5781uE75dIS/wXxSaimlc1sSRFqbVmIi816j4hGEWkC02x7DyxwqNH0mjol+L2ML0HROaLgXug7W0omWcEH7hIIdVV01WD6Mxrnthadga0XeYXOxKinU167TJ9XIKf1CeewjBW8YKBpE2rTRnLfOXfKiGWfgw+f/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7398.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 19:59:08 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 19:59:08 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 08 Jun 2026 20:58:58 +0100
Subject: [PATCH v3 01/19] rust: io: add dynamically-sized `Region` type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-io_projection-v3-1-c5cde13a5ec4@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780948747; l=16706;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=9kc34t/fCVoNLZv+3VpTgeN7MieeNOygy8GCKlBxPz0=;
 b=xfv578LvEoFcXyAiBWryQxqVTeoaVPg5z6kp8QPP2Il82RhEZebxtMvfyWrPsd1LeM3cmC32n
 dJcHUMAtCBgBKf4knBWjSsrQbpk9Fog/xtL3o5z8EXsyJzYNauqYnUz
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
X-MS-Office365-Filtering-Correlation-Id: 0e1b7665-40e7-440d-c33c-08dec59866ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|6133799003|22082099003|18002099003|921020|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	HWCMn8kbeo+lbB+m0RuTOZZOJ/tih7xHT1CgfKsVTR3NKpAT07XHJH0oLsOGnC33CnFUWUJjcYZmg3VPfhN3jYIfbez5WlZ8wLjuljhHqpx1ItDAjb0yJKqzFTQ10e9gIJiE6gKmEclwwRKUz8X4rJsTey1aSpl7lGjDqWH/f4H1jLf8i8ti+GeX9tZhY5X6t4iyfkKRsuBuW0Vk72WzEX60ODHqt0RblbukiB+HyFvBWwX6AWPKOW9vmxTYwuWa4ljykKAgVUcKlSHfgQI0Po6u/TybRCILpRGvO7HMn7Y5WnQVVexLQ5nZcssiafef+U62UlknBUDvjErmKCwyfwytWLf5kRGi9b0pWqhscTL0PDgNCydClUw/ikNtD/dP8yVnnD2Qnhrzr+yAs/wcTuZc31ny4efTyX8rzC638VfBrlP5jxUE6/TGOeLhRQSGHdupJgc2q1q9d8+oujXqelhzMfReZkxe9QInldbtdjmdcOJoPycQnxuoPme2K1E/DAr6JILy6cagr/vj8YzjbiQxq9CfnUDUrVp4nZn1lThrU0ttMmBLbIG2R8umXXI5aQ5KKjoK7xINjxw9z8Lqs9Ve3RoIQL+sC+VubDc/dT7uHL3VcZJLCVsj9W33rLrZ9/yI2Jyq+jrJ034DYBV5ssSNVtdqC0Xz58Wv7EhP2Mvg06aRxy+DS4U2uQfNZ5cyn3yv7+ZDhGY2Z9fOlEYc88ybENrWHjRDm7oym7XroMg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(6133799003)(22082099003)(18002099003)(921020)(56012099006)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejg1NWNvZkI0SENITmQ5K2lmOHZqNVBHK3lxbGdCTFYzR2w0VDZHMjhUUjF5?=
 =?utf-8?B?UGhTdmJPSXRDcnpwZkVreGhickhRTmtWcEFxclkrWHZBQ3JuNHl6ajc1MUtK?=
 =?utf-8?B?RlpITXFoNVRVRTZHVExRd0l1cHFTNHpaYytGT2M0YklEbHFYMWpaS3dJZ1F2?=
 =?utf-8?B?WDk2aTFZa3lyeWtEWEt2cTRDT2NIbzBySzFFbjUvVDZYeUloeE83QXArVjRn?=
 =?utf-8?B?V01vc2Z5VlFTQkNuWU1nNDFtNE1jZnFYTmZ5TmVoT09UVzg1a2JqNjgrVlhF?=
 =?utf-8?B?OVkwbEFrTHl2blBSV2VhR1FYdWZvYjRyd2JpcDdzc1pQNjZiSXozbENULy9O?=
 =?utf-8?B?MGZONzRyR3lUZDBGVUo4NFFGVHdiL05KY1oyaGRlaHlQU2dYNHFtdU9sSmVG?=
 =?utf-8?B?MTJwRGF2bTlHTzc2TlhxNll1Z2dBL0pya1dpMzl0dXdoWlp6djlLMjNERC9E?=
 =?utf-8?B?eFRJY0JwcFhwT3hsemd1R1BLSjBPREJwVVBWRU1RZHR5T2FXamJZNFhtUDNa?=
 =?utf-8?B?QlNBUzBvaEtLMHlPQmVJUWY3M0lJa2NEbkpLdENJelVwVFRUVlpOcXg2Y2Zo?=
 =?utf-8?B?dW4zdGZFRmVWWXMzaG93bjFTMVoyOUlHZERicTdjQ0pDZnIvY0lISTVoSmsz?=
 =?utf-8?B?SzlGNytQUDJKdDgvb2NTTm9adVR6MnZtQUpCN21DL2ZmUnBYVFZPbTFYek5V?=
 =?utf-8?B?V3Z5M2QyVFRoRW9Sei9QRUFhdXhiWnAvVlZqODJLbCtSZ2lKNlYvT3FKTTdj?=
 =?utf-8?B?YmR5eUxlUEJQQWtBd2puclR3WkNISGNRZkttZTNzdTk0ck15SXV6YTI5Nmhu?=
 =?utf-8?B?aVZ4UldZNnJkVjhrS21wTGc0bkYxR1VxTDc1OVBNdXp0MjBhbmphYnc2MS9l?=
 =?utf-8?B?UjdtOVU0ejNtZjM1Q3R2dTRJWHdpSFZ6THhZRGxJeFRDNnZySFdDVFlOcXRa?=
 =?utf-8?B?UnNwbzY3YW1oMlZDTUp2M2J3YzRHOXZiTWhkQnp0U0cxN0drR3c3SXlpcUs2?=
 =?utf-8?B?bGxZUjBnZ1RQbVk2WkJTM2R2QnNBU24zNkpYT2VoQkNSMDJreDJXQTA0K0pX?=
 =?utf-8?B?ci9wWHZHeWlJQmozTVpFRlNudm9GQnVWY2hGQktKZDYzTis3STJ0Q2JqTjlM?=
 =?utf-8?B?dWMrRy82ZWJWRExVNVlEQnd6UkNQK2FSSzE3aVJxdDZUcHBVMHVPMUlyelVY?=
 =?utf-8?B?OXZoVzNIVUhlb0ZielZLMDIwUjRTek9GdDNrUDZRVTNCNmhLb0MwRXhCWERr?=
 =?utf-8?B?NUtFdDUzU3hoTkZqbnVZdms5TW9uQXRUQ016akdXQnRicXhzY2tPRXk5bTZO?=
 =?utf-8?B?cU5vVFBUcXZMb0tJQ3BiQVA2UVdjRXBEeGdrN0VPZzZqaGNLN1N3S1BlVWta?=
 =?utf-8?B?aTdMMGY1MStSWitkQncyR2pERVh5U3lmZ013V1BDSVJYUlRRdit1cS9jTDF0?=
 =?utf-8?B?OTlReVNpeGxPaDB1VVI2eEVLS2NFOUpVdEhuL3U4ZVY3S1RnUlFacjBJYnF0?=
 =?utf-8?B?SFh5Tm80eGtwaDFpd3I2dkt0aUVlTHYyMGhsTXJONWh4cFhMM3ZrR0V2UXlZ?=
 =?utf-8?B?bkNqcjVNMlZwWmNZZ2tzbEtUSVp6V0JXamdXY0o1RFFWZ1lTNUt3QWdhMjB2?=
 =?utf-8?B?cEdKNDZqbE9nZzBWMUcrWEpKamFDbXpRYkxBV0hpSjl5REp2VCs2dFBYSFdq?=
 =?utf-8?B?MXlhK1laelpiM3Y1M1RkaWROVjEybFVxWEhENzZlczVsV1FGdURBKzFrYm55?=
 =?utf-8?B?YmlYVUZIM25rZks2Tkg4b0FYWEdDMThYMWlCck1GTGxCdk9zbnlGTDduTlJk?=
 =?utf-8?B?Q04yVERqcWkyZTV6WC9VUzhpV3ZLRUljY1FQQlF2YnErUU1YOG4vY2NPQ1No?=
 =?utf-8?B?ZUhoYVlzUFpZelVLL1dVZGl3YzNYbXpXUVl3cVZmazhpTVNCV3lwQzFlTFdv?=
 =?utf-8?B?UVZxUnlnbFU5THA2OU9SWSticFhqYmNDWXAxL3owaG1HeUwyeDZlNTEvcmRm?=
 =?utf-8?B?WFQ2TDIwZGdFRXpCY2JNRXYxY2ExcHhaRmVNZ29qNUR3dEFMM2dOTDNjRS9F?=
 =?utf-8?B?SmVCbFBKcnVCRllFYTJrYXBuQWJoMzM1M3JOYUovaE92cit5U1p6U2V0VWh3?=
 =?utf-8?B?SlRDWldHdEdJeFpVSDVrRDZRY2dmVXVNUWIwSDJhakdXMFB3ZTJISDhWS0xr?=
 =?utf-8?B?UjcwRjhTRTJLbDRkQnBwRi8vTnRpLzJYRFVXRVB4VGJNUUM3cWxQYTBDamtR?=
 =?utf-8?B?bHdxZzZOU3Ewam5tbUhpTWFyNm9OdGJHUU1HSWNMd2gzVFV4ME5sMlpuMGI1?=
 =?utf-8?B?K3dDSC9rOFNVUjE0YVhuTDZncUhmT2UzdnB4clB2L1BxTG11NVdwQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1b7665-40e7-440d-c33c-08dec59866ce
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 19:59:08.4453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ub8IwFPwYKlJYr6IeCekFkhnHHelOxROJ1syIbHyqerV62SmJojvOBogkDolabw/YnSBmuaDNENWyiwNxVXAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7398

Currently many I/O related structs carry a `SIZE` parameter to denote the
minimum size of the I/O region, while they also carry a field indicating
the actual size. Proliferation of the pattern creates a lot of duplicated
code, and makes it hard to create typed views of I/O.

Introduce a `Region` type that carries the `SIZE` parameter. It is a
wrapper of `[u8]`, which makes it dynamically sized with a metadata of
`usize`. This way, pointers to `Region` naturally carry size information.
This type is required to be naturally aligned.

Expose the minimum size information via `MIN_SIZE` constant of the
`KnownSize` trait. Similarly, expose the minimum alignment information via
`KnownSize::MIN_ALIGN`.

With these changes, it is possible to add an associated type to `Io` trait
to represent the type of I/O region. For untyped regions, this is the newly
added `Region` type. Remove `IoKnownSize` as it is no longer necessary. Use
the same mechanism to indicate minimum size of PCI config spaces.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/devres.rs |   6 +--
 rust/kernel/io.rs     | 131 +++++++++++++++++++++++++++++++++-----------------
 rust/kernel/pci.rs    |   1 -
 rust/kernel/pci/io.rs |  40 ++++++---------
 rust/kernel/ptr.rs    |  12 +++++
 5 files changed, 116 insertions(+), 74 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 11ce500e9b76..ed30ccc6e68e 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -68,7 +68,6 @@ struct Inner<T> {
 ///     devres::Devres,
 ///     io::{
 ///         Io,
-///         IoKnownSize,
 ///         Mmio,
 ///         MmioRaw,
 ///         PhysAddr, //
@@ -297,10 +296,7 @@ pub fn device(&self) -> &Device {
     /// use kernel::{
     ///     device::Core,
     ///     devres::Devres,
-    ///     io::{
-    ///         Io,
-    ///         IoKnownSize, //
-    ///     },
+    ///     io::Io,
     ///     pci, //
     /// };
     ///
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index fcc7678fd9e3..dcf3b40ffa48 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -6,7 +6,11 @@
 
 use crate::{
     bindings,
-    prelude::*, //
+    prelude::*,
+    ptr::{
+        Alignment,
+        KnownSize, //
+    }, //
 };
 
 pub mod mem;
@@ -31,6 +35,59 @@
 /// `CONFIG_PHYS_ADDR_T_64BIT`, and it can be a u64 even on 32-bit architectures.
 pub type ResourceSize = bindings::resource_size_t;
 
+/// Untyped I/O region.
+///
+/// This type can be used when an I/O region without known type information has a compile-time known
+/// minimum size (and a runtime known actual size).
+///
+/// This must be naturally aligned to `usize`.
+///
+/// # Invariants
+///
+/// Size of the region is at least as large as the `SIZE` generic parameter.
+#[repr(C)]
+#[cfg_attr(CONFIG_64BIT, repr(align(8)))]
+#[cfg_attr(not(CONFIG_64BIT), repr(align(4)))]
+pub struct Region<const SIZE: usize = 0> {
+    inner: [u8],
+}
+
+impl<const SIZE: usize> Region<SIZE> {
+    /// Create a raw mutable pointer from given base address and size.
+    ///
+    /// `size` should be at least as large as the minimum size `SIZE` to uphold the type invariant.
+    ///
+    /// Just like other methods on raw pointers, it is not unsafe to create a raw pointer
+    /// that does not uphold the type invariants. However such pointers are not valid.
+    #[inline]
+    pub fn ptr_from_raw_parts_mut(base: *mut u8, size: usize) -> *mut Self {
+        core::ptr::slice_from_raw_parts_mut(base, size) as *mut Region<SIZE>
+    }
+
+    /// Create a raw mutable pointer from given base address and size.
+    ///
+    /// The alignment of `base` is checked, and `size` is checked against the minimum size specified
+    /// via const generics.
+    #[inline]
+    pub fn ptr_try_from_raw_parts_mut(base: *mut u8, size: usize) -> Result<*mut Self> {
+        if size < SIZE || base.align_offset(size_of::<usize>()) != 0 {
+            return Err(EINVAL);
+        }
+
+        Ok(Self::ptr_from_raw_parts_mut(base, size))
+    }
+}
+
+impl<const SIZE: usize> KnownSize for Region<SIZE> {
+    const MIN_SIZE: usize = SIZE;
+    const MIN_ALIGN: Alignment = Alignment::new::<{ size_of::<usize>() }>();
+
+    #[inline(always)]
+    fn size(p: *const Self) -> usize {
+        (p as *const [u8]).len()
+    }
+}
+
 /// Raw representation of an MMIO region.
 ///
 /// By itself, the existence of an instance of this structure does not provide any guarantees that
@@ -85,7 +142,6 @@ pub fn maxsize(&self) -> usize {
 ///     ffi::c_void,
 ///     io::{
 ///         Io,
-///         IoKnownSize,
 ///         Mmio,
 ///         MmioRaw,
 ///         PhysAddr,
@@ -241,12 +297,25 @@ fn offset(self) -> usize {
 /// For MMIO regions, all widths (u8, u16, u32, and u64 on 64-bit systems) are typically
 /// supported. For PCI configuration space, u8, u16, and u32 are supported but u64 is not.
 pub trait Io {
+    /// Type of this I/O region. For untyped regions, [`Region`] can be used.
+    type Target: ?Sized + KnownSize;
+
     /// Returns the base address of this mapping.
     fn addr(&self) -> usize;
 
     /// Returns the maximum size of this mapping.
     fn maxsize(&self) -> usize;
 
+    /// Returns the absolute I/O address for a given `offset`,
+    /// performing compile-time bound checks.
+    // Always inline to optimize out error path of `build_assert`.
+    #[inline(always)]
+    fn io_addr_assert<U>(&self, offset: usize) -> usize {
+        build_assert!(offset_valid::<U>(offset, Self::Target::MIN_SIZE));
+
+        self.addr() + offset
+    }
+
     /// Returns the absolute I/O address for a given `offset`,
     /// performing runtime bound checks.
     #[inline]
@@ -336,7 +405,7 @@ fn try_write64(&self, value: u64, offset: usize) -> Result
     #[inline(always)]
     fn read8(&self, offset: usize) -> u8
     where
-        Self: IoKnownSize + IoCapable<u8>,
+        Self: IoCapable<u8>,
     {
         self.read(offset)
     }
@@ -345,7 +414,7 @@ fn read8(&self, offset: usize) -> u8
     #[inline(always)]
     fn read16(&self, offset: usize) -> u16
     where
-        Self: IoKnownSize + IoCapable<u16>,
+        Self: IoCapable<u16>,
     {
         self.read(offset)
     }
@@ -354,7 +423,7 @@ fn read16(&self, offset: usize) -> u16
     #[inline(always)]
     fn read32(&self, offset: usize) -> u32
     where
-        Self: IoKnownSize + IoCapable<u32>,
+        Self: IoCapable<u32>,
     {
         self.read(offset)
     }
@@ -363,7 +432,7 @@ fn read32(&self, offset: usize) -> u32
     #[inline(always)]
     fn read64(&self, offset: usize) -> u64
     where
-        Self: IoKnownSize + IoCapable<u64>,
+        Self: IoCapable<u64>,
     {
         self.read(offset)
     }
@@ -372,7 +441,7 @@ fn read64(&self, offset: usize) -> u64
     #[inline(always)]
     fn write8(&self, value: u8, offset: usize)
     where
-        Self: IoKnownSize + IoCapable<u8>,
+        Self: IoCapable<u8>,
     {
         self.write(offset, value)
     }
@@ -381,7 +450,7 @@ fn write8(&self, value: u8, offset: usize)
     #[inline(always)]
     fn write16(&self, value: u16, offset: usize)
     where
-        Self: IoKnownSize + IoCapable<u16>,
+        Self: IoCapable<u16>,
     {
         self.write(offset, value)
     }
@@ -390,7 +459,7 @@ fn write16(&self, value: u16, offset: usize)
     #[inline(always)]
     fn write32(&self, value: u32, offset: usize)
     where
-        Self: IoKnownSize + IoCapable<u32>,
+        Self: IoCapable<u32>,
     {
         self.write(offset, value)
     }
@@ -399,7 +468,7 @@ fn write32(&self, value: u32, offset: usize)
     #[inline(always)]
     fn write64(&self, value: u64, offset: usize)
     where
-        Self: IoKnownSize + IoCapable<u64>,
+        Self: IoCapable<u64>,
     {
         self.write(offset, value)
     }
@@ -582,7 +651,7 @@ fn try_update<T, L, F>(&self, location: L, f: F) -> Result
     fn read<T, L>(&self, location: L) -> T
     where
         L: IoLoc<T>,
-        Self: IoKnownSize + IoCapable<L::IoType>,
+        Self: IoCapable<L::IoType>,
     {
         let address = self.io_addr_assert::<L::IoType>(location.offset());
 
@@ -614,7 +683,7 @@ fn read<T, L>(&self, location: L) -> T
     fn write<T, L>(&self, location: L, value: T)
     where
         L: IoLoc<T>,
-        Self: IoKnownSize + IoCapable<L::IoType>,
+        Self: IoCapable<L::IoType>,
     {
         let address = self.io_addr_assert::<L::IoType>(location.offset());
         let io_value = value.into();
@@ -658,7 +727,7 @@ fn write_reg<T, L, V>(&self, value: V)
     where
         L: IoLoc<T>,
         V: LocatedRegister<Location = L, Value = T>,
-        Self: IoKnownSize + IoCapable<L::IoType>,
+        Self: IoCapable<L::IoType>,
     {
         let (location, value) = value.into_io_op();
 
@@ -690,7 +759,7 @@ fn write_reg<T, L, V>(&self, value: V)
     fn update<T, L, F>(&self, location: L, f: F)
     where
         L: IoLoc<T>,
-        Self: IoKnownSize + IoCapable<L::IoType> + Sized,
+        Self: IoCapable<L::IoType> + Sized,
         F: FnOnce(T) -> T,
     {
         let address = self.io_addr_assert::<L::IoType>(location.offset());
@@ -704,28 +773,6 @@ fn update<T, L, F>(&self, location: L, f: F)
     }
 }
 
-/// Trait for types with a known size at compile time.
-///
-/// This trait is implemented by I/O backends that have a compile-time known size,
-/// enabling the use of infallible I/O accessors with compile-time bounds checking.
-///
-/// Types implementing this trait can use the infallible methods in [`Io`] trait
-/// (e.g., `read8`, `write32`), which require `Self: IoKnownSize` bound.
-pub trait IoKnownSize: Io {
-    /// Minimum usable size of this region.
-    const MIN_SIZE: usize;
-
-    /// Returns the absolute I/O address for a given `offset`,
-    /// performing compile-time bound checks.
-    // Always inline to optimize out error path of `build_assert`.
-    #[inline(always)]
-    fn io_addr_assert<U>(&self, offset: usize) -> usize {
-        build_assert!(offset_valid::<U>(offset, Self::MIN_SIZE));
-
-        self.addr() + offset
-    }
-}
-
 /// Implements [`IoCapable`] on `$mmio` for `$ty` using `$read_fn` and `$write_fn`.
 macro_rules! impl_mmio_io_capable {
     ($mmio:ident, $(#[$attr:meta])* $ty:ty, $read_fn:ident, $write_fn:ident) => {
@@ -758,6 +805,8 @@ unsafe fn io_write(&self, value: $ty, address: usize) {
 );
 
 impl<const SIZE: usize> Io for Mmio<SIZE> {
+    type Target = Region<SIZE>;
+
     /// Returns the base address of this mapping.
     #[inline]
     fn addr(&self) -> usize {
@@ -771,10 +820,6 @@ fn maxsize(&self) -> usize {
     }
 }
 
-impl<const SIZE: usize> IoKnownSize for Mmio<SIZE> {
-    const MIN_SIZE: usize = SIZE;
-}
-
 impl<const SIZE: usize> Mmio<SIZE> {
     /// Converts an `MmioRaw` into an `Mmio` instance, providing the accessors to the MMIO mapping.
     ///
@@ -798,6 +843,8 @@ pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
 pub struct RelaxedMmio<const SIZE: usize = 0>(Mmio<SIZE>);
 
 impl<const SIZE: usize> Io for RelaxedMmio<SIZE> {
+    type Target = Region<SIZE>;
+
     #[inline]
     fn addr(&self) -> usize {
         self.0.addr()
@@ -809,10 +856,6 @@ fn maxsize(&self) -> usize {
     }
 }
 
-impl<const SIZE: usize> IoKnownSize for RelaxedMmio<SIZE> {
-    const MIN_SIZE: usize = SIZE;
-}
-
 impl<const SIZE: usize> Mmio<SIZE> {
     /// Returns a [`RelaxedMmio`] reference that performs relaxed I/O operations.
     ///
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 5071cae6543f..c6d6bd8f251d 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -43,7 +43,6 @@
 pub use self::io::{
     Bar,
     ConfigSpace,
-    ConfigSpaceKind,
     ConfigSpaceSize,
     Extended,
     Normal, //
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 0461e01aaa20..b4996aa059d8 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -10,11 +10,12 @@
     io::{
         Io,
         IoCapable,
-        IoKnownSize,
         Mmio,
-        MmioRaw, //
+        MmioRaw,
+        Region, //
     },
-    prelude::*, //
+    prelude::*,
+    ptr::KnownSize, //
 };
 use core::{
     marker::PhantomData,
@@ -46,28 +47,21 @@ pub const fn into_raw(self) -> usize {
     }
 }
 
-/// Marker type for normal (256-byte) PCI configuration space.
-pub struct Normal;
+/// Alias for normal (256-byte) PCI configuration space.
+pub type Normal = Region<256>;
 
-/// Marker type for extended (4096-byte) PCIe configuration space.
-pub struct Extended;
+/// Alias for extended (4096-byte) PCIe configuration space.
+pub type Extended = Region<4096>;
 
 /// Trait for PCI configuration space size markers.
 ///
 /// This trait is implemented by [`Normal`] and [`Extended`] to provide
 /// compile-time knowledge of the configuration space size.
-pub trait ConfigSpaceKind {
-    /// The size of this configuration space in bytes.
-    const SIZE: usize;
-}
+pub trait ConfigSpaceKind: KnownSize {}
 
-impl ConfigSpaceKind for Normal {
-    const SIZE: usize = 256;
-}
+impl ConfigSpaceKind for Normal {}
 
-impl ConfigSpaceKind for Extended {
-    const SIZE: usize = 4096;
-}
+impl ConfigSpaceKind for Extended {}
 
 /// The PCI configuration space of a device.
 ///
@@ -77,7 +71,7 @@ impl ConfigSpaceKind for Extended {
 /// The generic parameter `S` indicates the maximum size of the configuration space.
 /// Use [`Normal`] for 256-byte legacy configuration space or [`Extended`] for
 /// 4096-byte PCIe extended configuration space (default).
-pub struct ConfigSpace<'a, S: ConfigSpaceKind = Extended> {
+pub struct ConfigSpace<'a, S: ?Sized + ConfigSpaceKind = Extended> {
     pub(crate) pdev: &'a Device<device::Bound>,
     _marker: PhantomData<S>,
 }
@@ -85,7 +79,7 @@ pub struct ConfigSpace<'a, S: ConfigSpaceKind = Extended> {
 /// Implements [`IoCapable`] on [`ConfigSpace`] for `$ty` using `$read_fn` and `$write_fn`.
 macro_rules! impl_config_space_io_capable {
     ($ty:ty, $read_fn:ident, $write_fn:ident) => {
-        impl<'a, S: ConfigSpaceKind> IoCapable<$ty> for ConfigSpace<'a, S> {
+        impl<'a, S: ?Sized + ConfigSpaceKind> IoCapable<$ty> for ConfigSpace<'a, S> {
             unsafe fn io_read(&self, address: usize) -> $ty {
                 let mut val: $ty = 0;
 
@@ -118,7 +112,9 @@ unsafe fn io_write(&self, value: $ty, address: usize) {
 impl_config_space_io_capable!(u16, pci_read_config_word, pci_write_config_word);
 impl_config_space_io_capable!(u32, pci_read_config_dword, pci_write_config_dword);
 
-impl<'a, S: ConfigSpaceKind> Io for ConfigSpace<'a, S> {
+impl<'a, S: ?Sized + ConfigSpaceKind> Io for ConfigSpace<'a, S> {
+    type Target = S;
+
     /// Returns the base address of the I/O region. It is always 0 for configuration space.
     #[inline]
     fn addr(&self) -> usize {
@@ -132,10 +128,6 @@ fn maxsize(&self) -> usize {
     }
 }
 
-impl<'a, S: ConfigSpaceKind> IoKnownSize for ConfigSpace<'a, S> {
-    const MIN_SIZE: usize = S::SIZE;
-}
-
 /// A PCI BAR to perform I/O-Operations on.
 ///
 /// I/O backend assumes that the device is little-endian and will automatically
diff --git a/rust/kernel/ptr.rs b/rust/kernel/ptr.rs
index 3f3e529e9f58..82acb531b17b 100644
--- a/rust/kernel/ptr.rs
+++ b/rust/kernel/ptr.rs
@@ -235,11 +235,20 @@ fn align_up(self, alignment: Alignment) -> Option<Self> {
 ///
 /// This is a generalization of [`size_of`] that works for dynamically sized types.
 pub trait KnownSize {
+    /// Minimum size of this type known at compile-time.
+    const MIN_SIZE: usize;
+
+    /// Minimum alignment of this type known at compile-time.
+    const MIN_ALIGN: Alignment;
+
     /// Get the size of an object of this type in bytes, with the metadata of the given pointer.
     fn size(p: *const Self) -> usize;
 }
 
 impl<T> KnownSize for T {
+    const MIN_SIZE: usize = size_of::<T>();
+    const MIN_ALIGN: Alignment = Alignment::of::<T>();
+
     #[inline(always)]
     fn size(_: *const Self) -> usize {
         size_of::<T>()
@@ -247,6 +256,9 @@ fn size(_: *const Self) -> usize {
 }
 
 impl<T> KnownSize for [T] {
+    const MIN_SIZE: usize = 0;
+    const MIN_ALIGN: Alignment = Alignment::of::<T>();
+
     #[inline(always)]
     fn size(p: *const Self) -> usize {
         p.len() * size_of::<T>()

-- 
2.54.0

