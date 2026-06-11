Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022106.outbound.protection.outlook.com [52.101.101.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ED7496904;
	Thu, 11 Jun 2026 16:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195331; cv=fail; b=JlcDN77fc4ItXW0qUAYGPFmlcrYwInR85fCIELIhYw/cIN5iT54eSQsNRtRA85hJDc19q/1gypfnMc3SYlVomILDvJ8cQJuUs+hNtynC8I3Pp1yrugPL1jymHUDM2Q8sLyfYM5ILAtgg1FFqXhzTlCohDzKjK60KkKKb3AqHC4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195331; c=relaxed/simple;
	bh=X3jtfWZLQGJZh2g9tCEqgAxb4lmWw01CX+lOBYGY4qM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CRSePjkLGVza3b04Pk8keMw07dvsexeWXo4ZaW9czxmiZ9PNF7Vuizh883kMe5Wk1R1lGEcpDC6aqoQ5aJGGak21OvlYC3xGEmNpsvd6XBJ9zJBkhjRQbXUUoYWHNgPh8H/RZ7qdTq94woE2jFcUL68z3vXOXH1JrXN0Lafpv4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=LUPORnRi; arc=fail smtp.client-ip=52.101.101.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="LUPORnRi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=davStuv447juijMlpIMX2H35gRyb+M9knOEvr/E77taSjsZdHm3POmqc7YRE7MCbTjNVtfbOWwA2c7TkN9OYDZGuGQBtvQO3Ih8DheH8pJxaPM4VSidr0nClODbbQBIVb5OXIekzoaTp0OrgxFotMquJCjgLcjqrp87E+K2YKRuAhPjJMMtuugFJ7mX81nGmMkjn+lN3Fhioi836qSPpQLQijUB0Ep+DSU5OMpx9cUrbutuVt2ijsxjbrdA1PRqOrq2IT/lhm2hes9GmnKz8xMmkvNaJKxilY3vd7frNc46ydtRoD+Zn/EdiAKN8NoiiG99Xw2VfYj5oCncf1OrAFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvP3V1N2DDGsrmatTSvhoZJuRmdEBJem5u3DqqZsDrA=;
 b=TstVJKy3Eq2XsUD7M+vyKYFirPwiOp7N3f4eLNvao4AUL598VBPijTiaHO7Y8rq4Y3sZ2mETae9whNllct+ZCanJj5BpuW+MO8stSD9ffA+KP+utobua/Akcb/2iKd7TZGpnALGWJKRu7cDZYTYuPwSExS9ABLiRmjNhSk14BETbjFDYOofmuQiX4OD9RIRPopUM6nSz8OHQ+3trigrBn8PwdRfwRcPHBo3hrPLdWtdZgEqtIOZyLcyjTzTFHPZi4n2aesNEsyICdsO2A9ckbIrQurfG98IfvMyi3Ff7UMJqHCUrpcAhgNlqK0rsnoXsrvtwJ6qMNgR3poOUzia8xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvP3V1N2DDGsrmatTSvhoZJuRmdEBJem5u3DqqZsDrA=;
 b=LUPORnRiuk8tgHYfr36u0hLjEZS0OWeF5VmmzX2tEJUIV2xrTj9b5WjB1/fWX4ibJnSnHeBKgc5FOBC9ze910bxhYxm3a0pOXPRRT5fvvTasFgGcazA3rmZwdBa3N/fFrMdyMBBpOTrvPe/PAoNklzFL838fsduYPDJubtk0eiY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO4P265MB6525.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 16:28:32 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 16:28:32 +0000
From: Gary Guo <gary@garyguo.net>
Date: Thu, 11 Jun 2026 17:28:19 +0100
Subject: [PATCH v4 17/20] gpu: nova-core: use I/O projection for cleaner
 encapsulation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-io_projection-v4-17-1f7224b02dcb@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781195301; l=13099;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=X3jtfWZLQGJZh2g9tCEqgAxb4lmWw01CX+lOBYGY4qM=;
 b=T4mmhjhEPj1vEDa7YClxNoxvGs6OTJpkZxYSTS/wg0AHAVW7QE93eZ0zmH1Qm3EGITH1OpzBE
 QcGSW2Vgyb+Dp462CIB8qN7tfYEur4Rjja1YoxC/QutTM4buZqn2v+4
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
X-MS-Office365-Filtering-Correlation-Id: d4c4056e-c6dc-40ea-78d4-08dec7d67a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10070799003|921020|6133799003|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hY6oSpQDGZDkqNtTjH++bTcLTSSaizBz4sa6Vv5CF6r6DLs/i1jamB2WFK59J3fElDa218lJqZYwX66zp2o7DDzG9WAEyjhjw/bBar/3J8EuI0w+yznneeKZ8zMfsukiJUB9rNib/F62+k7RMSMFD3l8NP8+g+dioizf8dFhXDjj5///2qRQU6mG0irbbTCg7Pc0KmyMGq5a0AmlrsP8hXzMLGE6RMBCS/RZo+l3GXfwCee2Y36PWA3ZU7pMnIOfY8ddOZn5rrDA9+pwVwU9WTfZceOPlSJK222I3D4oGZ1yj1UiPp9cj7zmDGRm+NbSmuytevSrYl5xhEQVYMbrdtOvhIbh6Usxi2JZLFlUCdFemd+RRBNlA7deNt+TFS85JofTRBQ41nFfCozvt2uXh0/HZRKmCpAwpf7ihb61caQQ/uqqa60CJW9D8pv/DaVJ5Cdx1SbrfruvMQJSKIw6BRU+eFTBaZcs5s5z9On8M/Aho3Vk328JvIflULMHQXOKI87WaqOXImLhicpfFwoquTDUjHzZJRoHdwXClbNIEYyW0wSRBP7xVvWIIvloRb6FBuygngU7WIpHf8fe3HFik3TC7k1vlgWRAC4J2QvceFcEmMsWk+vVKKqwbJbhvfQGimD3PsFBFgNFchrQnYls3+FCqmQotu/CbXp9UHV9VDsOkFi7pNhTQZoRW7mgSPpxlIWXtikJdYjRXInxWDU+Fx9uO7KoTCrxEUIAqBlp+IQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10070799003)(921020)(6133799003)(56012099006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjZwM3ZmYkpFYVJhRGcxM0lnQW1GeDJUalJzVjRma1oyVDROODJibmczRzFv?=
 =?utf-8?B?N05yUUZuRENiU3pWaFJ3TWE2aDNXam5oMDc4M2N6UjhKNmo2MG00L3ZUYlQy?=
 =?utf-8?B?MzhaT20ybGY4L1VMRE5mTU9sUDRpeWpGdE45ekl5dk9TK2lhOVNacDVxSzYz?=
 =?utf-8?B?NnNzTnYwZmdSVUg4M3V2djF1Y0gxMlloQ0s1NGJHcE5qeHpzTEdvMVRLMmpj?=
 =?utf-8?B?UlB5N1k0VTdteWpEMGxUWHVwakt0VkdUNEFSdk4yWWFsUTA0UFprOTc5RGVQ?=
 =?utf-8?B?N3FoUXpiYmVzcWxnVVVZOFJSc1N1ektEUHN3NjV5TVMrVDE4cjh1elVLOEUx?=
 =?utf-8?B?aEUrR3JrNWtRYU55NHUvRzlmNmpmME5FYTV2M0J1MmpFbm1wR0wra25CSTlN?=
 =?utf-8?B?VEhiWklieVBXdTJZM1NmVXQ1MWk5TTZKQi9pc0k5VHBJdTF5cmo4VWNLTDly?=
 =?utf-8?B?Y2NWWGpoQUg4Y21OSHhqZk5kM3YzaThHWEJxbUJCT3pUYitRaGZvVENFOFNE?=
 =?utf-8?B?U21zRTRrSWkxM2FYRTdZVmw0MU9MWS9sUW9OQ0o4elBQNElTQ3BwVlNHTzd3?=
 =?utf-8?B?bXZreHlYdFZ3bFBtbVMxcEdnQ09HblEwZGtaZmZrZ2RweGR1Q2FwMklSbllO?=
 =?utf-8?B?cnpVaWxnUE1pUWZuZ1pTOVkrMnJtRnFhR1lrOUJGNnc0QWVjQTkvL1ZYSkZz?=
 =?utf-8?B?a01kaHFudGVKMWxnL0NBeHRsZFlIWmtVSUhDUUFHemRmZ1AxQVdscVlldGIy?=
 =?utf-8?B?TTRXaTF3bUZtSjJ6WGZsWVVYUE5Bdkt0YnZ6NmFBWEcrUDRyR2J6eTVaN3h4?=
 =?utf-8?B?REg5SlI5bmlDVEtYMEg1eGdtR3Z2TEE1a1FXQ0g2K2lPVUo3NDB1d1N5VS95?=
 =?utf-8?B?cGtiZmt4WENSL3pKTzQ1SXRDLzc1ZXNwRlZ6THIrZ092SjU5Qk0rYTJ4UG5H?=
 =?utf-8?B?UndNd0NBYVprejhyV2RHNmlIY2RiT1JxV0ROcDkvUEFyUDlnN3g3ejBtbnhy?=
 =?utf-8?B?anJSUEw3QTJUcXRTTWZINWNkYzBYeEExN2o2cnRkNHl1VGxxTHUrQ01tR3U4?=
 =?utf-8?B?T3o5Z0ZqcEVSZXVsNXhJSHA1YTRkbjNBNmt0aTVmbkxXejVlZ0ZIOTRNZGli?=
 =?utf-8?B?QUtveGNxanhkRmwwS3pkWit3NklQZVZIRVFIMmRrd0FjdE5DeElmSmh0RDFZ?=
 =?utf-8?B?TVlVZElDbVBqZkFnOFBQZlUrbmJ6b0dkZTBPbm5MSHRDK3FZdjlQZmRjTDZ4?=
 =?utf-8?B?ajVmSmcvckZLaXFhdmFESmJTUzdwWnlzUkNjZnJMbnlNZ1dybHRFeTkrNDVO?=
 =?utf-8?B?RnNQZnpFR3NTNXdwY25uQWJxSkovQkZwb09PeDIvY2dnNFArM0czdDVzWUc5?=
 =?utf-8?B?aWoyM3QrSjZVbkVzVzluT3Niam5MOXZ6U0RQT05YejFZeEtXNXd0N0ZLNHcr?=
 =?utf-8?B?MmttWlB1UXVTbFpLMmgrdU54bE9YaTF3bEpPMDNtblBhT1lyQzhLNkVaY2Jm?=
 =?utf-8?B?WEdnbllnRCtYK0VZL2RmdXM5NkQ5ZDFXVUVXODg3TUFpT1BxamRHYnB3eW5r?=
 =?utf-8?B?VTh4bXVvVkhEVWs1LzNiVUY1NDMvaWxOSHV5Sms3TW56SzdNcmpscmFVcDNJ?=
 =?utf-8?B?UFcxYldzUFpEcEFzR3VYU1ZwaWVvQlpIb0ZoZmVyOEloVnlsd1BwcEJaaFBS?=
 =?utf-8?B?ZUgyQnB6cHBTZVpFc05oQzJwVjBOWnZ0OWFaWWh6S25VRTErUEJLaGxZdDQz?=
 =?utf-8?B?bFc0K0RDNzZ1Y0lvUGMrU0N4N0NGWldrTVJLMzlOQmlJdklzcWx3aGxQQVVW?=
 =?utf-8?B?S29EWk0ybXE2YnBEMWdjZmFrQjl3NzhwRVJFSXBMcXRSTXozZ29FSElHUjJR?=
 =?utf-8?B?M2JBQmxJeFZwOTZZWXhYbGh4a2dIVUJwNWl0K25XbW5nTHAzSmJjY3FRQmM3?=
 =?utf-8?B?ZEdnK1JJMXQxdmpQcWFyRHZZdjZidTlRWm1iVHhtMzJ2eEx3KzF2dUNKR24v?=
 =?utf-8?B?T2I1eUUyM3VGamU3VVlNdzlEVi9CbEoxa2E2aXpsdE1jd2pYNkFBaUpvNG1x?=
 =?utf-8?B?bjJVQmRYK2RTMGFSSWdxUklybWtSSldJM3Z2TGRrcHAxUHVqbjdBbzJUTDFT?=
 =?utf-8?B?WVVtenFZY2hUMU1PZHczR0Q5SWIrZHV2L1dtOUNETTI3Vm9rTDVwaVAzeU1V?=
 =?utf-8?B?MTA4QWJVUHRjZnVpV3Jac1NGaS9Vc0Z5OVlXUDV0ZVJEdEpvNzRMcFBMZW1R?=
 =?utf-8?B?d2htZGlxRk1OTmNlRHljVUZjUUdMVHoxSFZ2Z2wwcWhQRjgzTTF4ZlRnbW40?=
 =?utf-8?B?RytzazNSbWF5M1lQSGtYeTBpaUx5eHFQMG5ja05XVE1MMlhvZ0dIUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c4056e-c6dc-40ea-78d4-08dec7d67a82
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:28:32.6329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FRIIwG40BA1rvEScOSIK4564fqL2ktnPr8xrLhSS+Hp2v4/F/rY4WbFQEQEI8nIm6IY8fV3j+yBmF/2jo2wewA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6525

Use `io_project!` for PTE array and message queues to restore the proper
encapsulation.

The remaining `dma_read!` and `dma_write!` is now only acting on
primitives; thus replace by `io_read!` and `io_write!`.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/nova-core/gsp.rs      | 53 ++++++++++++-------------
 drivers/gpu/nova-core/gsp/cmdq.rs | 66 +++++++++++++++++--------------
 drivers/gpu/nova-core/gsp/fw.rs   | 82 +++++++++++++--------------------------
 3 files changed, 90 insertions(+), 111 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 69175ca3315c..cfa7553cd820 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -9,14 +9,16 @@
     dma::{
         Coherent,
         CoherentBox,
+        CoherentView,
         DmaAddress, //
     },
+    io::{
+        io_project,
+        io_write,
+        Io, //
+    },
     pci,
-    prelude::*,
-    transmute::{
-        AsBytes,
-        FromBytes, //
-    }, //
+    prelude::*, //
 };
 
 pub(crate) mod cmdq;
@@ -48,21 +50,21 @@
 
 /// Array of page table entries, as understood by the GSP bootloader.
 #[repr(C)]
+#[derive(FromBytes, IntoBytes)]
 struct PteArray<const NUM_ENTRIES: usize>([u64; NUM_ENTRIES]);
 
-/// SAFETY: arrays of `u64` implement `FromBytes` and we are but a wrapper around one.
-unsafe impl<const NUM_ENTRIES: usize> FromBytes for PteArray<NUM_ENTRIES> {}
-
-/// SAFETY: arrays of `u64` implement `AsBytes` and we are but a wrapper around one.
-unsafe impl<const NUM_ENTRIES: usize> AsBytes for PteArray<NUM_ENTRIES> {}
-
 impl<const NUM_PAGES: usize> PteArray<NUM_PAGES> {
-    /// Returns the page table entry for `index`, for a mapping starting at `start`.
-    // TODO: Replace with `IoView` projection once available.
-    fn entry(start: DmaAddress, index: usize) -> Result<u64> {
-        start
-            .checked_add(num::usize_as_u64(index) << GSP_PAGE_SHIFT)
-            .ok_or(EOVERFLOW)
+    /// Initialize a new page table array mapping `NUM_PAGES` GSP pages starting at address `start`.
+    fn init(view: CoherentView<'_, Self>, start: DmaAddress) -> Result<()> {
+        for i in 0..NUM_PAGES {
+            io_write!(view, .0[build: i],
+                start
+                    .checked_add(num::usize_as_u64(i) << GSP_PAGE_SHIFT)
+                    .ok_or(EOVERFLOW)?
+            );
+        }
+
+        Ok(())
     }
 }
 
@@ -89,17 +91,12 @@ fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
 
         let start_addr = obj.0.dma_handle();
 
-        // SAFETY: `obj` has just been created and we are its sole user.
-        let pte_region = unsafe {
-            &mut obj.0.as_mut()[size_of::<u64>()..][..RM_LOG_BUFFER_NUM_PAGES * size_of::<u64>()]
-        };
-
-        // Write values one by one to avoid an on-stack instance of `PteArray`.
-        for (i, chunk) in pte_region.chunks_exact_mut(size_of::<u64>()).enumerate() {
-            let pte_value = PteArray::<0>::entry(start_addr, i)?;
-
-            chunk.copy_from_slice(&pte_value.to_ne_bytes());
-        }
+        let pte_view = io_project!(
+            obj.0,
+            [build: size_of::<u64>()..][build: ..RM_LOG_BUFFER_NUM_PAGES * size_of::<u64>()]
+        )
+        .try_cast::<PteArray<RM_LOG_BUFFER_NUM_PAGES>>()?;
+        PteArray::init(pte_view, start_addr)?;
 
         Ok(obj)
     }
diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 070de0731e95..c34b48961496 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -2,16 +2,23 @@
 
 mod continuation;
 
-use core::mem;
+use core::{
+    mem,
+    sync::atomic::{
+        fence,
+        Ordering, //
+    },
+};
 
 use kernel::{
     device,
     dma::{
         Coherent,
+        CoherentBox,
         DmaAddress, //
     },
-    dma_write,
     io::{
+        io_project,
         poll::read_poll_timeout,
         Io, //
     },
@@ -171,20 +178,18 @@ struct MsgqData {
 #[repr(C)]
 // There is no struct defined for this in the open-gpu-kernel-source headers.
 // Instead it is defined by code in `GspMsgQueuesInit()`.
-// TODO: Revert to private once `IoView` projections replace the `gsp_mem` module.
-pub(super) struct Msgq {
+struct Msgq {
     /// Header for sending messages, including the write pointer.
-    pub(super) tx: MsgqTxHeader,
+    tx: MsgqTxHeader,
     /// Header for receiving messages, including the read pointer.
-    pub(super) rx: MsgqRxHeader,
+    rx: MsgqRxHeader,
     /// The message queue proper.
     msgq: MsgqData,
 }
 
 /// Structure shared between the driver and the GSP and containing the command and message queues.
 #[repr(C)]
-// TODO: Revert to private once `IoView` projections replace the `gsp_mem` module.
-pub(super) struct GspMem {
+struct GspMem {
     /// Self-mapping page table entries.
     ptes: PteArray<{ Self::PTE_ARRAY_SIZE }>,
     /// CPU queue: the driver writes commands here, and the GSP reads them. It also contains the
@@ -192,13 +197,13 @@ pub(super) struct GspMem {
     /// index into the GSP queue.
     ///
     /// This member is read-only for the GSP.
-    pub(super) cpuq: Msgq,
+    cpuq: Msgq,
     /// GSP queue: the GSP writes messages here, and the driver reads them. It also contains the
     /// write and read pointers that the GSP updates. This means that the read pointer here is an
     /// index into the CPU queue.
     ///
     /// This member is read-only for the driver.
-    pub(super) gspq: Msgq,
+    gspq: Msgq,
 }
 
 impl GspMem {
@@ -232,20 +237,12 @@ fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
         const MSGQ_SIZE: u32 = num::usize_into_u32::<{ size_of::<Msgq>() }>();
         const RX_HDR_OFF: u32 = num::usize_into_u32::<{ mem::offset_of!(Msgq, rx) }>();
 
-        let gsp_mem = Coherent::<GspMem>::zeroed(dev, GFP_KERNEL)?;
-
-        let start = gsp_mem.dma_handle();
-        // Write values one by one to avoid an on-stack instance of `PteArray`.
-        for i in 0..GspMem::PTE_ARRAY_SIZE {
-            dma_write!(gsp_mem, .ptes.0[build: i], PteArray::<0>::entry(start, i)?);
-        }
+        let mut gsp_mem = CoherentBox::<GspMem>::zeroed(dev, GFP_KERNEL)?;
+        gsp_mem.cpuq.tx = MsgqTxHeader::new(MSGQ_SIZE, RX_HDR_OFF, MSGQ_NUM_PAGES);
+        gsp_mem.cpuq.rx = MsgqRxHeader::new();
 
-        dma_write!(
-            gsp_mem,
-            .cpuq.tx,
-            MsgqTxHeader::new(MSGQ_SIZE, RX_HDR_OFF, MSGQ_NUM_PAGES)
-        );
-        dma_write!(gsp_mem, .cpuq.rx, MsgqRxHeader::new());
+        let gsp_mem: Coherent<_> = gsp_mem.into();
+        PteArray::init(io_project!(gsp_mem, .ptes), gsp_mem.dma_handle())?;
 
         Ok(Self(gsp_mem))
     }
@@ -406,7 +403,7 @@ fn allocate_command(&mut self, size: usize, timeout: Delta) -> Result<GspCommand
     //
     // - The returned value is within `0..MSGQ_NUM_PAGES`.
     fn gsp_write_ptr(&self) -> u32 {
-        super::fw::gsp_mem::gsp_write_ptr(&self.0)
+        MsgqTxHeader::write_ptr(io_project!(self.0, .gspq.tx)) % MSGQ_NUM_PAGES
     }
 
     // Returns the index of the memory page the GSP will read the next command from.
@@ -415,7 +412,7 @@ fn gsp_write_ptr(&self) -> u32 {
     //
     // - The returned value is within `0..MSGQ_NUM_PAGES`.
     fn gsp_read_ptr(&self) -> u32 {
-        super::fw::gsp_mem::gsp_read_ptr(&self.0)
+        MsgqRxHeader::read_ptr(io_project!(self.0, .gspq.rx)) % MSGQ_NUM_PAGES
     }
 
     // Returns the index of the memory page the CPU can read the next message from.
@@ -424,12 +421,18 @@ fn gsp_read_ptr(&self) -> u32 {
     //
     // - The returned value is within `0..MSGQ_NUM_PAGES`.
     fn cpu_read_ptr(&self) -> u32 {
-        super::fw::gsp_mem::cpu_read_ptr(&self.0)
+        MsgqRxHeader::read_ptr(io_project!(self.0, .cpuq.rx)) % MSGQ_NUM_PAGES
     }
 
     // Informs the GSP that it can send `elem_count` new pages into the message queue.
     fn advance_cpu_read_ptr(&mut self, elem_count: u32) {
-        super::fw::gsp_mem::advance_cpu_read_ptr(&self.0, elem_count)
+        let rx = io_project!(self.0, .cpuq.rx);
+        let rptr = MsgqRxHeader::read_ptr(rx).wrapping_add(elem_count) % MSGQ_NUM_PAGES;
+
+        // Ensure read pointer is properly ordered.
+        fence(Ordering::SeqCst);
+
+        MsgqRxHeader::set_read_ptr(rx, rptr)
     }
 
     // Returns the index of the memory page the CPU can write the next command to.
@@ -438,12 +441,17 @@ fn advance_cpu_read_ptr(&mut self, elem_count: u32) {
     //
     // - The returned value is within `0..MSGQ_NUM_PAGES`.
     fn cpu_write_ptr(&self) -> u32 {
-        super::fw::gsp_mem::cpu_write_ptr(&self.0)
+        MsgqTxHeader::write_ptr(io_project!(self.0, .cpuq.tx)) % MSGQ_NUM_PAGES
     }
 
     // Informs the GSP that it can process `elem_count` new pages from the command queue.
     fn advance_cpu_write_ptr(&mut self, elem_count: u32) {
-        super::fw::gsp_mem::advance_cpu_write_ptr(&self.0, elem_count)
+        let tx = io_project!(self.0, .cpuq.tx);
+        let wptr = MsgqTxHeader::write_ptr(tx).wrapping_add(elem_count) % MSGQ_NUM_PAGES;
+        MsgqTxHeader::set_write_ptr(tx, wptr);
+
+        // Ensure all command data is visible before triggering the GSP read.
+        fence(Ordering::SeqCst);
     }
 }
 
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 4db0cfa4dc4d..b0e7de328eaf 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -10,7 +10,14 @@
 use core::ops::Range;
 
 use kernel::{
-    dma::Coherent,
+    dma::{
+        Coherent,
+        CoherentView, //
+    },
+    io::{
+        io_read,
+        io_write, //
+    },
     prelude::*,
     ptr::{
         Alignable,
@@ -44,59 +51,6 @@
     },
 };
 
-// TODO: Replace with `IoView` projections once available.
-pub(super) mod gsp_mem {
-    use core::sync::atomic::{
-        fence,
-        Ordering, //
-    };
-
-    use kernel::{
-        dma::Coherent,
-        dma_read,
-        dma_write, //
-    };
-
-    use crate::gsp::cmdq::{
-        GspMem,
-        MSGQ_NUM_PAGES, //
-    };
-
-    pub(in crate::gsp) fn gsp_write_ptr(qs: &Coherent<GspMem>) -> u32 {
-        dma_read!(qs, .gspq.tx.0.writePtr) % MSGQ_NUM_PAGES
-    }
-
-    pub(in crate::gsp) fn gsp_read_ptr(qs: &Coherent<GspMem>) -> u32 {
-        dma_read!(qs, .gspq.rx.0.readPtr) % MSGQ_NUM_PAGES
-    }
-
-    pub(in crate::gsp) fn cpu_read_ptr(qs: &Coherent<GspMem>) -> u32 {
-        dma_read!(qs, .cpuq.rx.0.readPtr) % MSGQ_NUM_PAGES
-    }
-
-    pub(in crate::gsp) fn advance_cpu_read_ptr(qs: &Coherent<GspMem>, count: u32) {
-        let rptr = cpu_read_ptr(qs).wrapping_add(count) % MSGQ_NUM_PAGES;
-
-        // Ensure read pointer is properly ordered.
-        fence(Ordering::SeqCst);
-
-        dma_write!(qs, .cpuq.rx.0.readPtr, rptr);
-    }
-
-    pub(in crate::gsp) fn cpu_write_ptr(qs: &Coherent<GspMem>) -> u32 {
-        dma_read!(qs, .cpuq.tx.0.writePtr) % MSGQ_NUM_PAGES
-    }
-
-    pub(in crate::gsp) fn advance_cpu_write_ptr(qs: &Coherent<GspMem>, count: u32) {
-        let wptr = cpu_write_ptr(qs).wrapping_add(count) % MSGQ_NUM_PAGES;
-
-        dma_write!(qs, .cpuq.tx.0.writePtr, wptr);
-
-        // Ensure all command data is visible before triggering the GSP read.
-        fence(Ordering::SeqCst);
-    }
-}
-
 /// Maximum size of a single GSP message queue element in bytes.
 pub(crate) const GSP_MSG_QUEUE_ELEMENT_SIZE_MAX: usize =
     num::u32_as_usize(bindings::GSP_MSG_QUEUE_ELEMENT_SIZE_MAX);
@@ -720,6 +674,16 @@ pub(crate) fn new(msgq_size: u32, rx_hdr_offset: u32, msg_count: u32) -> Self {
             entryOff: num::usize_into_u32::<GSP_PAGE_SIZE>(),
         })
     }
+
+    /// Returns the value of the write pointer for this queue.
+    pub(crate) fn write_ptr(this: CoherentView<'_, Self>) -> u32 {
+        io_read!(this, .0.writePtr)
+    }
+
+    /// Sets the value of the write pointer for this queue.
+    pub(crate) fn set_write_ptr(this: CoherentView<'_, Self>, val: u32) {
+        io_write!(this, .0.writePtr, val)
+    }
 }
 
 // SAFETY: Padding is explicit and does not contain uninitialized data.
@@ -735,6 +699,16 @@ impl MsgqRxHeader {
     pub(crate) fn new() -> Self {
         Self(Default::default())
     }
+
+    /// Returns the value of the read pointer for this queue.
+    pub(crate) fn read_ptr(this: CoherentView<'_, Self>) -> u32 {
+        io_read!(this, .0.readPtr)
+    }
+
+    /// Sets the value of the read pointer for this queue.
+    pub(crate) fn set_read_ptr(this: CoherentView<'_, Self>, val: u32) {
+        io_write!(this, .0.readPtr, val)
+    }
 }
 
 // SAFETY: Padding is explicit and does not contain uninitialized data.

-- 
2.54.0

