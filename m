Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021101.outbound.protection.outlook.com [52.101.95.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043BB484247;
	Wed,  5 Aug 2026 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947836; cv=fail; b=IGqkrrmJ4gtwuUXeLJ5mcxz2e8VyCaVVLzbhDSaXj9pDqXW5fDU5yenlRZSRd78PQ9FbFD0kfNvn7Jg88W+8O6OJPpK6s4Nou5eei5PDAa1vybwQUx+JV2QgsSagxyPu/i96jb8sjkV63QGNrAkcNuj03NO/R0jocvSmw0W9j4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947836; c=relaxed/simple;
	bh=UcdRmVpzRIL5d6EXe2nVU7lPrMffwe962tEbCQsnEq8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=H5cDbXE+KfRWigHW63tbAoqLvUCspnt2FofFupyhA42TkiFjMLCNopUlrLphlqywY2rGqa+kjqQWY6PNbn25TeWlObKxzLwUnJ7nmWVmqOMTtfGKrIR2OoLIZjrKNm3hyrO5M+LUm7mWD7BiqEhPEhfQS3abwPjJOzmZ/e4xGbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=QMNkJXVe; arc=fail smtp.client-ip=52.101.95.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="QMNkJXVe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jC1X2zh9JnSvDzSZewe9V88yp2cL23oGN1fW1AUqZb/Q86WtEHpyfKk2h/dgZ/DLA/yz3iD6zWppAqrzPPrPg7DJqDEPbxkAdYjnMJNg1ui5gV3jLl8MgId6VbwkAIivYGyWBgVhBo/MTyZ4k2THqGRL6nk9yr2FSkUvfOcaVktMJJ+Ame65/hFE9vjl/T5Ed/6bp8S2RoHIX/P9v8tTDXL69wSzDKZ7M2ivVHAvYZi1INAsKaR7ZNeAtifV1pJKYhymRUDjvneH+xqYrTmWCu/8MFhmEOTZufsWHwfq5oJkCeIQy0dp1EAQ4gWZfo/5+L+2GLlLkguUzH1KvEFBcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0B9J7EtjFFOfqpNapB2NAxL9XvD5dlbr2Cpc+w+7pc=;
 b=Fkw+UMFV2viwEhuJC2bR8i6EOXwpZkMW9bcNxuardHJcfLPqegjPBqhDPIXXGMxzgUWGat54YTCuib8NUI11f+kWNvsPZDa6EpoKXbdpEWxcj9nmRhqug+jqbbutFibXubWOFaicttViGm7qGFDf44Tpo5mAEbmqCmOUuSsFc+MZUMBwRRc+/+CFwJkIC78FknPRGzuxAibuFK1+LVMyTyQgc/F1M3YWiNiEZ2WplbUMs92yKkBo+aJhPT38kTGM31mSxAXPmixyLw+JX0AdZCM3D4Ev2upQ1M0eTDHVlEr0w1JIiToWgZTm/A6VmEoXCJwpDUDigLc6zrRKdNq9HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0B9J7EtjFFOfqpNapB2NAxL9XvD5dlbr2Cpc+w+7pc=;
 b=QMNkJXVe6CydLiyeABSpIu1fpGH3aerVFAMlYAw9Ld/gucFe3YBNJlvuX8FbhnyNb33asHCujE+gUYlR8RyMALdMuySuzLa0XgejD2pSXz7qom2z5LXrULIlKUwPPMNhHnLJFwQ+v84uDTny2HcuM7WlqJ2YPdizQbdRn7+boIk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by CWLP265MB3412.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:ea::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 16:37:08 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 16:37:08 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 05 Aug 2026 17:35:56 +0100
Subject: [PATCH v2 13/16] gpu: nova-core: convert hshub0 from relative
 register to projection
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-typed_register-v2-13-c3ca142220a0@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785947819; l=6702;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=UcdRmVpzRIL5d6EXe2nVU7lPrMffwe962tEbCQsnEq8=;
 b=v8NEDerkeR7e8881UUrHp7Lg06WNuZ9vjZ6x/ZMLFytw34MRRTvToNx9+q7DwCynlEezZvL2n
 wxmOSZ5HYdAB2yeeAqJZE22WenvBRwqVdM6j6MfKywVu6DBvWKdbWpE
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
X-MS-TrafficTypeDiagnostic: LOZP265MB8551:EE_|CWLP265MB3412:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a9809c-a15b-4df1-47ae-08def30fca86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|23010399003|376014|22082099003|18002099003|56012099006|6133799003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	6vTxnPHMdP/x4Uuzp88i4psK5OiZfIY7QKQ8lzkym0AUerHVituXhSLfv/oeJyId6kLhoyyEWp8mRR8yR5wWHCe1i0GJhx+LMaB/g7+18zeUgRFJikDK1ltsfOPkVQTTPvpbCoulaGayCi/WzXp1nOhAslTzerHi9/9UAYYuw00GJOm9Ft3mt2RMc3POI7Cd5LAhpBWXW2ihyOHbjZrzRFHc1ykb5HOrlgBukuM6gvDFAAG9ca+A2SSs2OPWO4Ae0k/kGaH9VPhqG4OPH0dv5SYuP6Rg3FJe2wtk19Yn2MjR4o9hImGdWp56dlf/A5L3lenFv94n0fswKAc8axBAMbqlhGEjwsyi+KMLr1Xw7DUVSctJ43UrtII9NXvm6f6y6eQMhmSiRtrNDLb263JFy2lwu+kXozcoV3wGbQaWJ+xWZGBxTg3/M/f1k3+wuQ2ffy6WUP7H8tNkYmNFr0AiFGK9dyxUh8sE2Yt3Ik+xfQKbIdJvnbgrMe8LC4yjhLKKgS/sAoC3dwiTtZGMPtfIkr+Eff48FMPWZf80nax3iUE4YeVPZ3eBxfGTYum8EUud9T/pGzZjhI0b6y0+MHl7JEeuQiYHDtgY/FEwoW0Qh6mWdcT+s1qLGnlZUNf0W27kHe8MlOgINMG6NcWAbfRXo0q58U5wX3+vv8xHQoqqGE/kULx9a4fhA45xoLhSrJFxOHaeF3FIn1wUJClVgVXZXg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(6133799003)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zk1GTHA5bTFKRDR1K0lLd1RYQmxhd1R3NkhuQUJwN2hObFRmekdxdVN2NnNB?=
 =?utf-8?B?Q0ZocEZkS0xUVmFNK1NoREtIejV6T2lCdTFaQXY3Skdjcnh1K0cvdy9SaWho?=
 =?utf-8?B?N0tGQTRSS0Z3YjRxK1d2Z2syZHFoQVh5OG9nMVY2UnBwWWhia2lUVmltcVhm?=
 =?utf-8?B?YjNOSG9hRGFMeGRuRTB1ajkwTERCbWpvZVozOVY4clFLY0FXT0h0TDBJWndT?=
 =?utf-8?B?RlVxZ3J3aENCbUl2b3RBanZraVRVOGFVRkxGVlFtSTNvQWpIeXRMMkxRczVC?=
 =?utf-8?B?RklJelNvZzZId00vTWw5OUVNYzRxVHJ6SUhsU25yTTZOQTFwUkxqQTlXWk5E?=
 =?utf-8?B?bmdsdEY5eDh1RCt3S0Rlc05LL0ZjSnM4VHdzTUhTWmhWYUoxYU5UcGVkTEJZ?=
 =?utf-8?B?RzIzZGRSTjdvaWh0NFhGQUEwS3B0SlpoVmZwekdtRmQ2a0ZWbzVvV2pkUkxa?=
 =?utf-8?B?ZjVHbGMvMXFKTGVVKytIdXVCdnNRZXpmVDBBSThJWGh3ZjlicS95MjBuVkFk?=
 =?utf-8?B?K05YQjUvNFU1SmtZV2JXRGV2UVd4R0N6SmJhRWRNSXEwMXFDTDFsRzBFdURE?=
 =?utf-8?B?Y0dtODU4Nk9peTdSczdsRVg1Y1h5VkRiRFJDcG5oUFFKSDZNMUNGeUdFRnhx?=
 =?utf-8?B?eDFBMm0wbjEybStHcVI5Y3d3T2IyU0sxNTloZXJSNDhlUTI1WEkzMmFuMnFy?=
 =?utf-8?B?UDAxY3pFdWhRbUNJNjRGcDcxQkd5WDUrYmkzZ2lUaGo2MHhEZ21wandCYUhJ?=
 =?utf-8?B?NjBRUG1mZGJ5Ulh0ZEVrNDA4ekgyZkZKeEt6VkJucHpvUityYWQwMDRxRzk1?=
 =?utf-8?B?YktJVTZqSXcxSGJLQlREZVlON1lobjJJSlFFdldaeEtwTkNYVHl0REY3dENi?=
 =?utf-8?B?L2lNSmRmUzc5eGJSUHA4eUJzbm1ST1ZmVWxmbTJqaFpBOE5RVmtEVVRBUXhR?=
 =?utf-8?B?elVneHJvcmVUalJ3RDdkdGZsN1lkekg3d1ZCMjh1MkVtTzMrY2xXbWhKM3JZ?=
 =?utf-8?B?eXZQVU1qazZQQjNUWFpBT1ZOVXBUc3pTcHNqcS9hekdlT0Q1WGNsT1Z6V3pz?=
 =?utf-8?B?Q0JRc01hREJ1MUdBR2tlakY5bitacUdQZTZIbkZQRHBNMllRMEZqZFFNdjEr?=
 =?utf-8?B?WHRCYUZodUw3V3NCNTh5bE1wK0pucUt5VWVkdzd6S1JRSEdnbFJQZ1l6Z1gv?=
 =?utf-8?B?WityNFQ5NlV5Q1k0R2FoUHRsSCtNNGg1YmJCTGxJbEZzRkN2Sm1UM2JDUEla?=
 =?utf-8?B?Q1oyU0I3eVdrSGF2Ui8wZzA0R2ZpeXcxTXp2ZXYyUU1ObXE1MTUvL3BuWDg1?=
 =?utf-8?B?Lzg2ZTljOWxoTGk3QXR6N3NZRUQzNy8wcnlGR3ZiT0E4dG1vRWl6OGpQWnB2?=
 =?utf-8?B?bmdYdlZJNnBYSkRxRWZuMFdVdTF1R3h2R3o2MGZBUytEbHdmbXkvNkpFS0Nm?=
 =?utf-8?B?d0dkUURCV21EZDBRUUlvUklxZGJLMFFUeE9WVWpEbVM2VXNHT3U1bjZ3Mmsw?=
 =?utf-8?B?eUlheHd5eEJ5VUtNV1pyUm1ySUo3VmVIcytDcDZqZTFoS1I4VkEwbm9oSHJl?=
 =?utf-8?B?a28xUUdLV1BJM1dmMEsydHg5VGwydXFMYlhFZkw2blFyb0E3Mlh6OTNldG9Q?=
 =?utf-8?B?aFJ3bGx0MmhXaDhXS25wMTFlZTJOZVFBOXRvc3RRN1VTUFZqdisyU3N5RGZa?=
 =?utf-8?B?QkZOdU13WXh0aXZPbjd1eUdpbzdCbHUzYXJUNE0vMlQxZVd6cTAzZDQrbjFC?=
 =?utf-8?B?dlkvVEs0SVlBamY2U1g0ZjRZOGt4TUdHV1VQNDE3R29oN1JJSWhpczBvVnVu?=
 =?utf-8?B?VG84amFWbkoyZkdiQVdNQ3FiMDdzbDl3NUwxVGVVbWJTVWpkcm0zVzFSZ2xm?=
 =?utf-8?B?ZDIzdjhGcVR2UHpHWHZvOTFaLzhIVU11eWVWMmIwQytiWm1MQ0QwZE1BcU4z?=
 =?utf-8?B?czlEa1l4OTdoVkFUWUVicXJTdWNpNlc3Z05OVElFWGR3aXhMTjUvQURnaXAw?=
 =?utf-8?B?M0tUaW9qTFJKYStrQVpUMSt0NHVuZ0ZxRyszYUh3K25VUGZqSll3T1NDVUw1?=
 =?utf-8?B?OFdhUE10NVcvVjUzbmtRUjZBYlh4dmxmWG5aaTREVnpzTU5sWjFBSUhTUHhQ?=
 =?utf-8?B?b0QxUC95LzZPUDhuc0E5YmJPcjBOcjJnMEM5R0dqSXpwVzcybndBREdXTkkw?=
 =?utf-8?B?Y3hDeUVCaWkzRWRkcTZMNlROendqWjJnZE13ZnlLQkJvVHZSbTFyU3JpRnJx?=
 =?utf-8?B?NjJ1QVBWZnhlU3J4eUsrRHUzSXZtQlVGWFFCVEtQTktFUEpQZW5oSTBkdURs?=
 =?utf-8?B?KzNyRkVtcnhwVkhGRi9HOFNMNlM1MjlpQytpYjN6OW1CMGZLUFYrZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a9809c-a15b-4df1-47ae-08def30fca86
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 16:37:08.2039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKJhfsbSgrMIfVEZuCwA5LzdoPPF87rCy7lehxUFhsy4xq/0aQb9NgE8TBtlzEwNVg8nCWcLtrB0lhjsnHZxqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3412

Similar to the PFALCON and PFALCON2 conversion, the hshub0 relative access
can also be achieved cleanly with projection and a new base.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/nova-core/fb/hal/gb100.rs | 59 +++++++++++++++++------------------
 drivers/gpu/nova-core/fb/regs.rs      | 19 ++++++-----
 2 files changed, 40 insertions(+), 38 deletions(-)

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
index c27582e376e2..584488a3e012 100644
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
@@ -65,31 +66,33 @@ pub(super) fn vga_workspace_addr(self) -> Option<u64> {
     }
 }
 
-/// Base of the GB10x HSHUB0 register window (`NV_HSHUB0_PRIV_BASE` in Open RM).
+/// The GB10x HSHUB0 register window (Base defined as `NV_HSHUB0_PRIV_BASE` in Open RM).
 ///
 /// The base is provided by the GB10x framebuffer HAL.
-pub(super) struct Hshub0Base(());
+#[repr(align(4))]
+#[derive(FromBytes, IntoBytes)]
+pub(super) struct Hshub0Registers([u8; SZ_4K]);
 
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

