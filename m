Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020099.outbound.protection.outlook.com [52.101.195.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2F53F39F9;
	Mon,  8 Jun 2026 19:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948777; cv=fail; b=INOrPOTAtwirQYhDTCD9Z9OSXuNS4YuqIM9+M9DXGh4qHahy+nQBqyPcQwMi01lLhXcyZ9AXeyQQc1BJbtqtpF94rcJJ6GCqho4IJotYYUaH3Q712QOlc2mbzJINB4A7P4B6wuNpvcn4b7rtpwyrI0mQhjESe6GjlAKK65D6j24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948777; c=relaxed/simple;
	bh=l4oA9OL4IRd+F2126WqfQn4rOSqui3zNcK3p0I1bTBc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=os20/TCs7Ea21U1nU0Av3lg3Q2Vn8cPU22P1KzfQ6bpm34hvJR//gdX9MTphUGZJCLfXVMTNwmXO6YY/0MHE4EB/VCg4K13NzOWg5JDL4hgsLptYITHRMxoQtARHAhJ++Sa0aD8Mgb/Idh4fUE0nsCW1+n40F6Pf1Y3NjJ6ojoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=VEXJ71o9; arc=fail smtp.client-ip=52.101.195.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="VEXJ71o9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMKHYTLMlQrMSMKEamhJV0kQ77BQpX1+ZlyQh4KlBpeMAGPhnh0VJ/XnetkYxwe5XCmMWqM6qTQBh92pK26+sh5LCUsTgbwZc7hlGG4rvNeGWW8F2DAGawCMpsRlgjNcFlVD9bPtPh6DKmJr4HX2lOujITkaNC5uE0KS1zZtv+jInzknILbEX3MHzqnhwCGKXOb6pwMTE0G/NxlEIMPZALWu4KYu56H2o3cMWa95OXNIf2s0WrukUDGDfLbczcO45q5lthOZTsI41Y+akUlH+vmXZvkIZPpKCX+51SyDtB7yRLt5tTcKqD6ARNmb5rPQ9xxkpa+jfmxCyXcYKOcxAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5SpviNfIjUUozXT+xdEge2MyrYHZmt8nPbL/SBu4N8=;
 b=o+sOcD+oKEpV+cwBcv7NUP7s07inETySj9VJgMkR8mOsEvu4PzlWrNU0ipZQRQnwyZ7eb9ytptyqeqG/AjxHklf3QN/aUSULgwlAQNopMg7NEl1LkdSsd0yzYxLK8iVNo0y3y623Kb9VvPybuHYN6ZM1TMdmmdOmzy/xmg1wv4BsfSG5786cAR8s8iFACNWE3RVJvPHdNdZA3U0YPR4u/s7gkUnELrLkX1bDbdI2fZ6Pza5k5m03QRA585mrq6Ez2SCqHV3bLl2dRqy+s9zUdU8c5mNWVbjB7HSewZdjn4WC5/ZTkw3zS6azSCWUghgqMRgiJCcvhUODy1iKmpPCIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5SpviNfIjUUozXT+xdEge2MyrYHZmt8nPbL/SBu4N8=;
 b=VEXJ71o9tqYYT6lV9XBxNn1V5X0Fho+hoFM7Uo5qyuuYe5XOXc5vLkia+j2o7U1AsOeTbAE+6IZqKrJK7WRpKJKTyZuhhSTPGb0vQGyicoMKZNNT79KX2DrLvtBtMlmEWm4Hho4tTnpoHOOfxuIXeyxnMZTS9ANt4yNPFV/H9TY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7398.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 19:59:14 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 19:59:14 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 08 Jun 2026 20:59:13 +0100
Subject: [PATCH v3 16/19] gpu: nova-core: use I/O projection for cleaner
 encapsulation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-io_projection-v3-16-c5cde13a5ec4@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780948747; l=12615;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=l4oA9OL4IRd+F2126WqfQn4rOSqui3zNcK3p0I1bTBc=;
 b=Mf8jiS6DUTnAi0qFE2GOzUTaR1xm+AfT4V04lcohKcMbAe6H5g1BW+grcp+qzuC6BnCSamcoE
 GFAgYahvn6JAIw4gArEB9Ar0F4GD09+tbmb+ljIyg01skYcM27PSAZH
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
X-MS-Office365-Filtering-Correlation-Id: 1d851fff-a528-410d-4742-08dec5986a61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|6133799003|22082099003|18002099003|921020|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	O89piWUkqBADUbeUroNQsw82WrmVG1mlDdcSJGE9df3C76VRmIIKxRVrUMA/nYrYPcFSLiv+RClRcdZQ126Zc4pcvtEphQNbmhe/8CIiL1sY3JtD2QrxiWuNeqGR5X70KpTpSZ5c8Im3U0gnHDPbelAfgTVTLGJKySNAgk9UBtoZ488lggmP5ehdNtLhEoGT9BPV4UM7xwjs6eYzfbNjpX1LNZWu3dkxEUtoPpRWprb8G6vsr/8OtYGsdxcfnN74PsSIJUqGqaQwB11ZhY5znVR7qJ1lr1xfoxfvR64PAfatoJUl6TVnp3rjNUDSX9vkiok62nSP+rzmdVUIESKdQvKZq27iWDRTCjtrgLGZoLTWvHxoyDhyklOP8mGBHkBnPBlRxRSFohg9CiGgYM1NmlLBtYTe3qGBKmgrr/eZUryVtrvP1gaNrseMqtz5LdBejN0kL3a2NB/XjWkwSJe3oR1lAXUzPHsSs5f4KMhtA0dojVxfSyCBr/AKyBbtgdRIGu9XLxU3Ozr8vhBlS8goTsOZBmC//i8SvDolh1Q01+C4R+Qqro77AQGG9D+kJTe8yvbxhG3iXDJSTSwwDj/XDsJFH5fjAsm7PFx9aAtQR1hs/7NenyRBQSnW/jKt5k8ccfJjH8t5ZDXRYnqpz/6xYGwaMdPQcSEYbkRDQ/zFuCjCwHvyc0lK3SoS/T6/aA/BkgnM7ofo26SteN13EC20F3aqO+GcQhEivFHFNXrKKbU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(6133799003)(22082099003)(18002099003)(921020)(3023799007)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZG9MV0ZnK083NEtJNTlydHFmakhYSjYwS3RqZXA3TnROQUFZMXBjOC9WZ3Vo?=
 =?utf-8?B?TmQ1Zjh6MUoweWJxVGtGcnluZDVYUnZSK2tpN2JUVitVWXdMNlJIT0UzV2JF?=
 =?utf-8?B?NGhPclZnSXh2ZTZnWUdBM2tVRG9USzBMTzczOXFPN2VlRFBrVzI3aHJpSUxM?=
 =?utf-8?B?RFNoR2I4VUVXeTZZVWpvU1NZYjM2dHVSSlFMV2t1K2trMXZnVVNMdGxsUUpu?=
 =?utf-8?B?RXExYnlyaXIwa1dwY2szNTMvZEFRQmRMa21EakZZY2xiNy81c3dLZWJrMHJr?=
 =?utf-8?B?bmVMRWtkTWxCVHdaVjFRR0dWL1owSmRTd25raVJDc3I1ZkpSM05DV0VRbFM0?=
 =?utf-8?B?by9FbXZ2Y2FuSEg2VFBBdkMrQ3JtUVREQjVlV2E2Q1lPN3dZK3FhYStyTDhj?=
 =?utf-8?B?bmQ0WDlyM203YkhFVUloa0FhaDVaNlltZlVuZm40UnZQdVQ0cTV0c0Myb1Bm?=
 =?utf-8?B?MGFFcWdSRWJPSXovSVk2bUo2em4xbVhQRjR6cm1oK3ozYTJVbWlmbTR6VnZ5?=
 =?utf-8?B?LzM5V2hSU1NzMTc2Q25BbjhUL21rKy9EckhML3B6N2M1TWl0NGtGdk13YWM4?=
 =?utf-8?B?UitmZjNVdlBjTXlBcGZyeWppV2xaL0dDVTFpWWY4emwvVTZzZW12UHY3ODRr?=
 =?utf-8?B?R1BjOGIzSGRnZlhJZUw4TVJJTWxhVWNmbzltbEs5dllOeElCNmFOU0tNejFk?=
 =?utf-8?B?MGpSdlNmblZFOWRvR2F4a25WWURBOFY5d1VHc09MQ3YySUxmazlvdjVXN0s1?=
 =?utf-8?B?bk5Ya1lnakM0WjJzTWE2MzZ0VE0yNE1ybnBxUVRoeFVFU3J4MHlCWXUwb0hz?=
 =?utf-8?B?dXhLK0kzQWNQTGlaRll5ampGNUFsZkNzdDREdXFyaUtTcTFBbkdZOHNXTDNE?=
 =?utf-8?B?Vmg1QkkyMWNkdjBqdWhGUWxGVDFmUXNuaHloNERoWVN0aEE3d3JFRjIvS3Nv?=
 =?utf-8?B?dzN0bVAyaXBhVXArQVZiNUJkK1NKSFlPUU95SWhYRFpzSCtZK21oL0NUdHNj?=
 =?utf-8?B?RGJ3Sm8vOXpFMlNIT2RYU3RndUp0RWZZR0RuNGpmY1F6SElaRUtldCtkSVJS?=
 =?utf-8?B?c1N4cXdIZDFNMFN2L0NRNmJBQmNlbTRzbjBHaFBTalZOMjFtMXN3NmJCZC96?=
 =?utf-8?B?U3ZVUzAwZk1tUXhPUWVIUXdEYWJQaVk2Sy9ISXF6L3IxaW5jbHQrd04vTWJh?=
 =?utf-8?B?czIyeWpGRG9QV25MVldGWmdQd2phSEhYUEJDaHQ4RElXMHNOQjhjV1RVb2t5?=
 =?utf-8?B?TUY4aWRRK052RUJobGR0T3ZNRDRXWlkwVHpjdzJYUGFlOXByTmJoUHV5djJm?=
 =?utf-8?B?VzB0ZUlZNHhqMzZnN0x2dEVQYXQ0R3RVVGFWSjFaU2lGbHZvS1k5eGs4dS92?=
 =?utf-8?B?MFl2dkczb0p0VmFUKzczejVYckFmWGxaTi9WUTJlOFRqeDUybUh5L2U4TVJl?=
 =?utf-8?B?MUplOUkvUko1NjdVUG00MlpHVHBKZ29sU0RsaDRlNlRIdlBiVVZjNXR5YzI5?=
 =?utf-8?B?MUQyNk1UTnRWeEh3V29pZHlReHovZGlXb0U4TG1mcDQvTkpCWExwMzFYYnZ1?=
 =?utf-8?B?b0FPSXVYZWtwMDNCVmFqSU9xUmRhMFcySTlRYktBS0E0Z09ITisyaVQyTHRS?=
 =?utf-8?B?MlhVSE1rV3dOTkxsUmpnT2xaVVZGMFFrcDZIckdvK1BqYlMzQS9UZFhEbVFG?=
 =?utf-8?B?QVJnRU5rQlZGa0RJczdldVFsc2hVTU11K0wxcERXOWVKSDhaRWQ1d2gvN1o4?=
 =?utf-8?B?UVhKY043UTJPbU1TTGVmZ2RnT0VNOEY4TzlSdXhDOWhtSDIxaWdVTkNZZDF6?=
 =?utf-8?B?ZU9DdGkzbnUvR251aGticW13eERKR0dPWXpXVnI1cUlQRmFFNXgrY3lwZ2pi?=
 =?utf-8?B?MVhxTjI3OXlsTWJubG5pVWkzeGhMOWVrVXJXT2F0b0VCaXg1M3dTdEZrbVVF?=
 =?utf-8?B?UXhBVlVscWNiVWpBVHpad2NZTmVhckpWbU1DWlgranNxVWlkeW1ZWDZsZlZR?=
 =?utf-8?B?cjI3d0VEVlZMc2VHRUFsNk5jczRzc25lRjB0Ykh2SXRQa3VXZE44M2JlVEVw?=
 =?utf-8?B?bys1cHJwTlErR0pybDRGK0ZWeWhJdytOR0dpQVlCcGpJVEJiUWZUcXg5bk85?=
 =?utf-8?B?V1JOdmhpRDNpQ0xpQzJtUHp4VjZKV3hSeGYzbWZTMEJuVlNORGZOc2tvQmxs?=
 =?utf-8?B?ODMxOUVmZndsZm96SUc0WXNGU1F0Wkl2eE1VaHRHTUFRV2tLVHY1NFMzdFdT?=
 =?utf-8?B?dnRLdzJ5M0FNV0pjZ1F0bmJZdHYxTGM3aHh2UVd6Wkh2V0U0R25VRnVsdXh4?=
 =?utf-8?B?d252M2lYVlJrdUwvSkFjK0FneW5iajJyZnU5S0lLYVdCQkFQTFhjZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d851fff-a528-410d-4742-08dec5986a61
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 19:59:14.4372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HoAKzEoV6CqfqMbiTnHLsIrI7B6pDA4Y+kfbjud+HCIg/OrdYqFy3XKum633yXcBfr3tBlbMhtjID/iDAPf7bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7398

Use `io_project!` for PTE array and message queues to restore the proper
encapsulation.

The remaining `dma_read!` and `dma_write!` is now only acting on
primitives; thus replace by `io_read!` and `io_write!`.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/nova-core/gsp.rs      | 40 +++++++++++--------
 drivers/gpu/nova-core/gsp/cmdq.rs | 66 +++++++++++++++++--------------
 drivers/gpu/nova-core/gsp/fw.rs   | 82 +++++++++++++--------------------------
 3 files changed, 88 insertions(+), 100 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 69175ca3315c..d18942dee61e 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -9,8 +9,14 @@
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
     prelude::*,
     transmute::{
@@ -57,12 +63,17 @@ unsafe impl<const NUM_ENTRIES: usize> FromBytes for PteArray<NUM_ENTRIES> {}
 unsafe impl<const NUM_ENTRIES: usize> AsBytes for PteArray<NUM_ENTRIES> {}
 
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
 
@@ -89,17 +100,12 @@ fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
 
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

