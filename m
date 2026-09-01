Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020105.outbound.protection.outlook.com [52.101.195.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAC348BD42;
	Tue,  1 Sep 2026 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281456; cv=fail; b=qVWRrq3GTsmYT0A+cGWn4n5dEvjI7jlXc8tbUgMrTFfG8n5JCg2M31mpAqhNbXa94zgfbOYZXzWCA0l6ctAwp3Y+AnyD3b2MxPm5DQszkAZGObV59cmB7skae0WOIZc+zo4NRyH2EKO/l0DTiPAhEH9z56CTzOFr9Op9zuAjGZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281456; c=relaxed/simple;
	bh=jxmNg7xPw7da42o5I5lxrJuHBh4clo2hgfjUDn1kqRg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZuGldEw5CEQcBg5xQ/SKPwHDjgjmOSpDL2IQniUdjeIZtwCdQt3JZy4qVhxfSzO+/zB7LV2PYmCm11sFR1nlZVjnHDhuJh20Ina2+uXTPDfxkQZob41uXYfiI/hTWK75qde6+1bN4gdN4o+xsXY4vP0zGoQD9oXK5YuE5gqA9VM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=uC1IWFqg; arc=fail smtp.client-ip=52.101.195.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="uC1IWFqg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+Y5Ycet/PjB2ZHkp+8hlE0yUnN9OTjTq3PdOTh5HkBBXmqW/oN/dMBgPx7TCd1iP4vDRBM36P4d7c+JBPFkGX1TOhtJ5s9rJ+W1uC6iLBS9jRfr5wteMQe++ARl/Aeq/WkdSWU2zt1eP+Bf1Jete8gv9qk8WUTnheOjbvOaTskEc8IZpiKtA9XBhTDAYAMvSsZSEjvHqpCRVlpjG2vyRCyEe2fi+rbkWR7ot5g+BiQJiTp1gPT/lO1dyuPKMMJxR6z1XHCjR9F61HckjbyqNLWg8KSfb6bKZRx5XqEGQaAx7tidgz4tCth+UWIIxPmhxi1BwCJjlJXGaEOpaSvjuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToENILkQJrEJR14hMqLdQy9VnyEgDH8Lxe1vho9utvw=;
 b=Pp0OJ6GsYJJLymQhhIr4wugg9RjTeZ8VrGUzcql3fenXwM/WmCJfbD1Lkn+HwmAiCdck10rl82ACQExCn1CCcrpRY/wXfjsvLl1ESv1HxTIb3sXNMk6c2y1E3ldZTA0fs8g7LsyIAk5yAUbR5DSdAK68BYecjAwWZPQJGk1L7d+5cGi13oYGSBNEoLGAu6lCm0VMbfNeR9qAFSyqw7sg5TKTFfou2b5W07T822V6vCVYkYkV0FXajbuaZUZgRa9y7ocVn5duVMQKl2RBjeUBwS4bXK/JFUrZ+7Po9JSVZ3TGzKrSVHvQjQXgWKGOuMlUJWwkaCGCCaVQTgXy50SvnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToENILkQJrEJR14hMqLdQy9VnyEgDH8Lxe1vho9utvw=;
 b=uC1IWFqgKT95KXNhfubaUP9G5Q0W1hSq82ulJrpW0hIKUcAXJeKXx60m5HTkFUpU+q2cjj0n8trPfc0zsuzvmbd15gt4s+CGBkEcr5qarWRLXDf6PSpc1sb2+kHo5/czIfTpjDnmMBM28B/ePmoZyftrjaDy5yqjpvt2rO7b62o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CW1P265MB9199.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 16:50:44 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 16:50:44 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 01 Sep 2026 17:50:37 +0100
Subject: [PATCH v4 13/16] gpu: nova-core: convert hshub0 from relative
 register to projection
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-typed_register-v4-13-5552b1d59525@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788281431; l=6817;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=jxmNg7xPw7da42o5I5lxrJuHBh4clo2hgfjUDn1kqRg=;
 b=JadxgMXLjjnnZrm+DOQbhiD40wM/k7aZulIxsp2o2YwTWXGUCw3jVBsWC/hmEVFCqRmAb+OK7
 44uIbImgxzpDg/v0tySKH986Gt7QNKr8+/ich2YhSTf0o14cmW5E2Hg
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
X-MS-Office365-Filtering-Correlation-Id: 9ed1013e-ec49-43de-4765-08df08492a02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|10070799003|376014|23010399003|366016|921020|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RR7EsED61qSUlhjA39HXGgkISiWbtcARH0atp88wOGEet3jKSlUMDnt9y+MfL002yB/Llhhh93U2+8p4NNtQLv+chSKqyWOUYCsl9SiQK8hhJtbsqzpHGlh9oqEyq7ahKuhgWRsxqOlHQlKNnNBYvMXTG5XURKoD1Sp6Ey5c/x2Vfj5OMvCswB5rtSAM5oEt1dfc3RIm1+pnl4m25vI6n4jLUKEtxUygyyBcHOio14lziRNqKu1Lr9Ui7hVv1fzDWVsh/sECTOI3nto5xMMwNvsvqKEeSYnX2TWRijfuPF3DS3yTg/wthbjVFv0gwuQelLcQ4QYoRYwu/llvYWwA1F3UdAsZDyCDY6OkUrKZpw7Vba/sK7uCuqeQNtuF6nayYLP454a8LhmxkXA/PspWtqo7A2keXmt9N4NAIXmTZn2moWs6QsyV/dm/2hp7e5a09ODowsAZv1yUnthAC6Ta2AiABkiz2tCnV6u+2dmPeo0MCCBTBmDO/4z1eWJjAffsbMec/OUfLoJ9GfZ1gM6gM1CYwpeo9LaJZ02rN2pbOnOoYdd108MLmYMudSxdyoGVBYEKUQe4gLY/Bk7IPueq0jvLm7ai7DgDtCQAXfXSD6gb7TF9yB0E6Oxah0PB7eqAVWi8UUFKKod8ENrmmkw7MlqYdxpOZyVF0Kw6Uh3kJpG6ZYlhl1M7i6UUU2r2jm09R+pTVN7+lrnrkv9AJ1Ppfg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(10070799003)(376014)(23010399003)(366016)(921020)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmluR1lBeksvNElnZWtoNlExZlVrc2Q5L0p2cDVXWUpMcUhQaVN6SUJOcmk0?=
 =?utf-8?B?Z3BqeUZnaDBpRlBHcWJhMnI2NzRkQ1cwa2RwTTg1YTk3TGxsYlZEMjloK3Np?=
 =?utf-8?B?eEhSZmp0REdRZWErbDhTbFVWS2VjdCtCQXAvWG85dVBlNUZGdTl6WWZBRFFU?=
 =?utf-8?B?eng4SFNOdnFqK01SRjNjaUd1Y0RQMEdzVVBXTVpJazIxaVBIWUNGKzNweTJi?=
 =?utf-8?B?aW9MSU82NW5VYzZ2c0E3OWMxU1BnYkF2enhQbVprS2VxaDNkS2xoUTl2WWw1?=
 =?utf-8?B?N1I2Vm9TeWRLYjE2eFg1Tmg5ODZaNHpRSVNnWlFtZWdXcmdJY1g2eC9ZUDdP?=
 =?utf-8?B?M05vY0twQjh6M1RNUCs0T2F6c3NLTkMzZXk4RVNaK29ZZFNpZWNGNUNpTnpw?=
 =?utf-8?B?RG1vbDY3QldoMUw3UFZkdkd6LzVBYVgvTHhJY0psV3FSZXpvcjhaQldrSmZC?=
 =?utf-8?B?TkpyRXVaSmJoOE9YRDlBaW5xZFNCVUpRcnpQWVIrWG40UE9GMnNSVnVYNHhs?=
 =?utf-8?B?TzlkU1FMNGptR0JIbStFcmdHS2FvSS9WUVVWQUhYTXF0dnhVeGJnVTFlYncr?=
 =?utf-8?B?dUVtS0lkRnhNTUJvNW9IemJtMFBJbWRZcjJiNml4TzZldWFFUlZtSzVqbU1z?=
 =?utf-8?B?dGZsYWVYSVVPWFUwRS8xZ0FrQWZmMnlpNHIxZERGaFJmS1k1S3dVbEVHTHlm?=
 =?utf-8?B?b21YMWk4QXJleCt0cllpTExubHFXTlpNMWlrSEZqbEo3OUhFYllLa1JiZk9x?=
 =?utf-8?B?KzF6YWRXOWE2QWhvL3gwZmxrTVhUWGVqSG5ORmRwem9yQjJpYkRaRyszREhl?=
 =?utf-8?B?M1djQm4rSEFEcHBDbmFmSUZrQjhPUDh3SWY2RmhBQmpIMXlWZ3p1QS9jTnQz?=
 =?utf-8?B?UFZ5RzlscXkwdjFycGM4M0VldjFBUVJrZnpTUUthVnZoTWUvaGs1TklzTllv?=
 =?utf-8?B?bCswL1JVYkc4SDZ6YUJsQitlWisyb3Y2Wm4yWElUTGdpdjJiNkpVakdIaUt2?=
 =?utf-8?B?aks4NW5xY0gvWE5BRmRKaEU1SCt2UWwwZnQ3NWVQbUlXS29WU05mR25yK3lt?=
 =?utf-8?B?cXg0NkFPYWxOY2JnOGhCRE51b0h3STl2cFJRSE9ScEpNbVpNZVBLQ3lsVzE3?=
 =?utf-8?B?cnEyT2Rhd3pmOVVEemdYbFBNVGZwbE1YM0pvUjdZOWJKN2xVMjNzYTM2TzdO?=
 =?utf-8?B?TWR4andhOHA3K1o1QUdKc3dhT3N2cGtsbi9xN0ZBVFNrT0o1NVdLREpVZkJl?=
 =?utf-8?B?SFBRck9yNjRsUXRTaDFJakkzMDVzWWkwZFNldDNwYWltMS9wWk1YdjBmd1lk?=
 =?utf-8?B?QjAyZzNOTmhBSzZ2NHBxQzVMVFVBd0J2djFvOWVFWHpVckJham1JdTFHREQ3?=
 =?utf-8?B?U25VL1BMSXE3Y3hhR1VUQ0hON2UyNTB0eTNpRi8yOGlJTW5oY25UeEhIYVNt?=
 =?utf-8?B?Z1Rsc282bWdQYXpUT1R4ckYrSmRPVVlnc2paYjJnaXRMM0RjRGY4S1ljVENa?=
 =?utf-8?B?endLQTZxR1BBYWd4NTFQZ2ZFMjEvcGdIbVZlV1lWaGtleUdEOGVjMEJqaUdt?=
 =?utf-8?B?Ky8rVVZPeUpSa3BJOTNEeWIrbWVYTFowUVhWV3cyV0RpS2NjMzZLaWpIT0JL?=
 =?utf-8?B?cGxWOWYzdTNjd29pc1daVXpiQnh3MEhaWCt1WHJKTVdqU1RpLzVvVU5wK3dp?=
 =?utf-8?B?VmlRditkM21PRTRWanplMjFLOTdYcjB0VjJuRWdyU0RuM1FrZTdLQ3k2NVlI?=
 =?utf-8?B?d0lnMXRyWHlMSm1CdDJLb2FsU0RvRDV0WVRRRXdQaWVWdno5aHFKbS9sTy9s?=
 =?utf-8?B?T01IRHkzbjFhZWUwMW90V1J3eloyTTB3SzVJR29GUURyamMxcURsdm9MVnpx?=
 =?utf-8?B?NnJFL3pUL2xadEJkd005ckZ3K1F5SjNJNkhFTVVGVGprOU1RamJRS0xxT1Fn?=
 =?utf-8?B?Y2QrVzRNK3g0UU1QZ05jdVVUSEEvZGJ5a1BrZkhwNWQvM2IyaVFmUGpHL2ZH?=
 =?utf-8?B?NVA1Y2dUSEdPTTJaR1pVRkJxRnJyem9hR29nWkVGbmNqYXEzZ2NTb2ZZZ3l6?=
 =?utf-8?B?dXYzL2VxdzBsSHdZWFMvWVZIV21QdWpNZUtFRVk5K3U5dXNGZ29jdXlhSUpT?=
 =?utf-8?B?UlM2a1E4UEdwN1N4dHJBTG5OUGZKUUZFSEdxYTdNcW85ZGJhQ21CS2c4Rmln?=
 =?utf-8?B?OFpHNTFyQ0VUVGxaeExacVdHeFNYWlZUZk9wd1V3WmRnaXZqTmpDdzNWNEpR?=
 =?utf-8?B?QjZQbTZiZWlnOUFqa2lxREFqMlp2dThzRE45WjAwdnhqMVVUdERDeFQ5VUVH?=
 =?utf-8?B?aWRXWFdMTkUveUtVZVd3THNuY3ptcll5QUtBQ0crSzZuUjYyM2Uvdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed1013e-ec49-43de-4765-08df08492a02
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 16:50:44.0989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/KxF7kf4L/YFM1+dqCQtd1co+U917+zpg8WstUuuAP78MheVoFuY/1TP4OQDem74D4pMD+bBJQgSK0IH+GLCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB9199

Similar to the PFALCON and PFALCON2 conversion, the hshub0 relative access
can also be achieved cleanly with projection and a new base.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/nova-core/fb/hal/gb100.rs | 59 +++++++++++++++++------------------
 drivers/gpu/nova-core/fb/regs.rs      | 21 ++++++++-----
 2 files changed, 42 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/nova-core/fb/hal/gb100.rs b/drivers/gpu/nova-core/fb/hal/gb100.rs
index d9e4d62ae632..9fa094939600 100644
--- a/drivers/gpu/nova-core/fb/hal/gb100.rs
+++ b/drivers/gpu/nova-core/fb/hal/gb100.rs
@@ -5,11 +5,10 @@
 
 use kernel::{
     io::{
-        register::{
-            RegisterBase,
-            WithBase, //
-        },
-        Io, //
+        io_project,
+        register,
+        Io,
+        Mmio, //
     },
     num::Bounded,
     prelude::*,
@@ -21,7 +20,10 @@
 };
 
 use crate::{
-    driver::Bar0,
+    driver::{
+        Bar0,
+        NovaRegisters, //
+    },
     fb::{
         hal::FbHal,
         regs, //
@@ -31,17 +33,26 @@
 
 struct Gb100;
 
-impl RegisterBase<regs::Hshub0Base> for Gb100 {
-    const BASE: usize = 0x0087_0000;
+register! {
+    base: NovaRegisters;
+
+    HSHUB0: regs::Hshub0Registers @ 0x0087_0000;
+}
+
+#[inline]
+fn hshub0(bar: Bar0<'_>) -> Mmio<'_, regs::Hshub0Registers> {
+    io_project!(bar, build: HSHUB0)
 }
 
-fn read_sysmem_flush_page_gb100(bar: Bar0<'_>) -> u64 {
+fn read_sysmem_flush_page_gb100(hshub0: Mmio<'_, regs::Hshub0Registers>) -> u64 {
     let lo = u64::from(
-        bar.read(regs::NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_LO::of::<Gb100>())
+        hshub0
+            .read(regs::NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_LO)
             .adr(),
     );
     let hi = u64::from(
-        bar.read(regs::NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_HI::of::<Gb100>())
+        hshub0
+            .read(regs::NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_HI)
             .adr(),
     );
 
@@ -52,7 +63,7 @@ fn read_sysmem_flush_page_gb100(bar: Bar0<'_>) -> u64 {
 ///
 /// Both the primary and EG (egress) register pairs must be programmed to the same address,
 /// as required by hardware.
-fn write_sysmem_flush_page_gb100(bar: Bar0<'_>, addr: Bounded<u64, 52>) {
+fn write_sysmem_flush_page_gb100(hshub0: Mmio<'_, regs::Hshub0Registers>, addr: Bounded<u64, 52>) {
     // CAST: lower 32 bits. Hardware ignores bits 7:0.
     let addr_lo = *addr as u32;
     let addr_hi = addr.shr::<32, 20>().cast::<u32>();
@@ -60,24 +71,12 @@ fn write_sysmem_flush_page_gb100(bar: Bar0<'_>, addr: Bounded<u64, 52>) {
     // Write HI first. The hardware will trigger the flush on the LO write.
 
     // Primary HSHUB pair.
-    bar.write(
-        regs::NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_HI::of::<Gb100>(),
-        regs::NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_HI::zeroed().with_adr(addr_hi),
-    );
-    bar.write(
-        regs::NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_LO::of::<Gb100>(),
-        regs::NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_LO::zeroed().with_adr(addr_lo),
-    );
+    hshub0.write_reg(regs::NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_HI::zeroed().with_adr(addr_hi));
+    hshub0.write_reg(regs::NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_LO::zeroed().with_adr(addr_lo));
 
     // EG (egress) pair -- must match the primary pair.
-    bar.write(
-        regs::NV_PFB_HSHUB_EG_PCIE_FLUSH_SYSMEM_ADDR_HI::of::<Gb100>(),
-        regs::NV_PFB_HSHUB_EG_PCIE_FLUSH_SYSMEM_ADDR_HI::zeroed().with_adr(addr_hi),
-    );
-    bar.write(
-        regs::NV_PFB_HSHUB_EG_PCIE_FLUSH_SYSMEM_ADDR_LO::of::<Gb100>(),
-        regs::NV_PFB_HSHUB_EG_PCIE_FLUSH_SYSMEM_ADDR_LO::zeroed().with_adr(addr_lo),
-    );
+    hshub0.write_reg(regs::NV_PFB_HSHUB_EG_PCIE_FLUSH_SYSMEM_ADDR_HI::zeroed().with_adr(addr_hi));
+    hshub0.write_reg(regs::NV_PFB_HSHUB_EG_PCIE_FLUSH_SYSMEM_ADDR_LO::zeroed().with_adr(addr_lo));
 }
 
 // This PMU reservation size is r570-specific.
@@ -88,13 +87,13 @@ pub(super) const fn pmu_reserved_size_gb100() -> u32 {
 
 impl FbHal for Gb100 {
     fn read_sysmem_flush_page(&self, bar: Bar0<'_>) -> u64 {
-        read_sysmem_flush_page_gb100(bar)
+        read_sysmem_flush_page_gb100(hshub0(bar))
     }
 
     fn write_sysmem_flush_page(&self, bar: Bar0<'_>, addr: u64) -> Result {
         let addr = Bounded::<u64, 52>::try_new(addr).ok_or(EINVAL)?;
 
-        write_sysmem_flush_page_gb100(bar, addr);
+        write_sysmem_flush_page_gb100(hshub0(bar), addr);
 
         Ok(())
     }
diff --git a/drivers/gpu/nova-core/fb/regs.rs b/drivers/gpu/nova-core/fb/regs.rs
index c27582e376e2..abb48b0955a9 100644
--- a/drivers/gpu/nova-core/fb/regs.rs
+++ b/drivers/gpu/nova-core/fb/regs.rs
@@ -2,7 +2,8 @@
 
 use kernel::{
     io::register,
-    sizes::SizeConstants, //
+    prelude::*,
+    sizes::{SizeConstants, SZ_4K}, //
 };
 
 use crate::driver::NovaRegisters;
@@ -65,31 +66,35 @@ pub(super) fn vga_workspace_addr(self) -> Option<u64> {
     }
 }
 
-/// Base of the GB10x HSHUB0 register window (`NV_HSHUB0_PRIV_BASE` in Open RM).
+const HSHUB0_REGION_SIZE: usize = SZ_4K;
+
+/// The GB10x HSHUB0 register window (Base defined as `NV_HSHUB0_PRIV_BASE` in Open RM).
 ///
 /// The base is provided by the GB10x framebuffer HAL.
-pub(super) struct Hshub0Base(());
+#[repr(align(4))]
+#[derive(FromBytes, IntoBytes)]
+pub(super) struct Hshub0Registers([u8; HSHUB0_REGION_SIZE]);
 
 register! {
-    base: NovaRegisters;
+    base: Hshub0Registers;
 
     // GB10x sysmem flush registers, relative to the HSHUB0 base. GB10x routes sysmembar
     // through a primary and an EG (egress) pair that must both be programmed to the same
     // address. Hardware ignores bits 7:0 of each LO register. The boot path uses a fixed
     // HSHUB0 base, so the multiple runtime-discovered HSHUB bases are not needed here.
-    pub(super) NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_LO(u32) @ Hshub0Base + 0x00000e50 {
+    pub(super) NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_LO(u32) @ 0x00000e50 {
         31:0    adr => u32;
     }
 
-    pub(super) NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_HI(u32) @ Hshub0Base + 0x00000e54 {
+    pub(super) NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_HI(u32) @ 0x00000e54 {
         19:0    adr;
     }
 
-    pub(super) NV_PFB_HSHUB_EG_PCIE_FLUSH_SYSMEM_ADDR_LO(u32) @ Hshub0Base + 0x000006c0 {
+    pub(super) NV_PFB_HSHUB_EG_PCIE_FLUSH_SYSMEM_ADDR_LO(u32) @ 0x000006c0 {
         31:0    adr => u32;
     }
 
-    pub(super) NV_PFB_HSHUB_EG_PCIE_FLUSH_SYSMEM_ADDR_HI(u32) @ Hshub0Base + 0x000006c4 {
+    pub(super) NV_PFB_HSHUB_EG_PCIE_FLUSH_SYSMEM_ADDR_HI(u32) @ 0x000006c4 {
         19:0    adr;
     }
 }

-- 
2.54.0

