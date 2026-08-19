Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021087.outbound.protection.outlook.com [52.101.95.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEE7469841;
	Wed, 19 Aug 2026 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787137842; cv=fail; b=tMkI3daoUTbggIL/hCZ+ohx1h8Nq8xGsyLYqwvsVF2MBfB0mPM5bGQNZxne/2SAsOIIRdz2Sv7/sYI8hxqWxEKLQIO8uPDcN6BKZHdXr5wYSC1j7qUbar5wwB6YEM7ra9tpXAc4chcidJvJx+rNshytlSA7N+PzuJjZg732cBVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787137842; c=relaxed/simple;
	bh=nTJ7wZSeeUArV1c5w8DwZwK2ut/RdnBTX0czYVxRigA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jyfmI0OStBEdhiCAFtl3R+rPKVPW7WHxsgZhT2+eOVr3qHJnR8U4j8jkzMFL5vmp8zNA9w2tCFAYstA8Q/fEfR7t6+Qsj86326a8UTh4yiPWxW19pCMZEDOWnT6litOb9Dy8fs35jdc+a5kaNmLLbuZyl8fdgRzECRiJXQkZPzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=zvpxA9sC; arc=fail smtp.client-ip=52.101.95.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="zvpxA9sC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0K5pQ19n7Uh/1PmJuPdLBbXFMSmffiNGdeeknvqhusaRKuf/smCugNtNHBWdOas/YVDLpyh0GOFgsbUTxNOcEvRc8ePdnFDqd0YBlzAGjUfDZoZomV/RShsfiEmR+Wy0X8MX5/NTWZvvFacqn7cqVB9QKWAEhnfbD9lGNKZDxhtJb55vH7WkASaYITrrBVp/PpwB91NzHTRoNlicMh1XxCY8MnhwbrnNpzU5+ndJ736cApBbMMulwdi7zJOv9Xfs7P4VHroQ282bWQ2426+ZYIUnczkdnDgwiL6ednBlIt3APy2Py7va9gspFfsjLWM2zQ1ehg+ngZ8zZSshC5LkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvWLye6q3T6iJdVLSyDKt2fXUAcrrEInZPcP41AR6Mo=;
 b=NixWIX7Nm9aqhcCEz542utUtXB1Q21hHWs1qNg6Dk+PL72v2Z+hXFrTmel7iy19NIz6g8gC1lBx7aRQtDVsCA0YKTLUmemIZ9u2tq/3RYVfGu8xr+ek6QHOsD+JIj6n5tRa4jr2aW/EDxdpOEKDOb+Hnb53rpoTf590Q9hokpdAPdY5GUyE9zqNN9T37+/jGcFk8feK3lA+74Dw6Uz6sLhLQAaDlWUhkHrEDanbMGHa74GSapji6yQxKkoFXkYi8ojWDkhWD5sE16mkerGnWGXwfJPbTeknrlp6OsJmPckDSQ0CJMTOjKn37em/H0qeY4xGDoEh77l3KVlSNAsAMbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvWLye6q3T6iJdVLSyDKt2fXUAcrrEInZPcP41AR6Mo=;
 b=zvpxA9sCxLzCkYsIhf1AQxN6ia409dYWtmnvjY/2bYovRPeSs0Ryeze+Q0XuBRzCxEHGiaW9byigYXPKLgqmx0NSHBvYwCCwM6gOrmireUn1fpqKFQgFUPmQA6vNb/fCP9FoxLeSY+F1eRJpZj0CmVJLuQwY3QdswO+RqpuqrFk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB7056.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:200::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 11:10:20 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 11:10:20 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 19 Aug 2026 12:09:16 +0100
Subject: [PATCH v3 08/16] drm/tyr: specify base type for registers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-typed_register-v3-8-3699a75fadf1@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787137814; l=7409;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=nTJ7wZSeeUArV1c5w8DwZwK2ut/RdnBTX0czYVxRigA=;
 b=iJK1ONYarEIyTIJLbZ224SMSZb3cRTCKvsikDgCHO7OgTY03Xm0ZSO4SPaQjhGTpHFylYvRXW
 IKeWmbq0VqqBHD0866ZE1nW5yIPU7rZQZUg5hC0x4Qwj3CHeISkI1gr
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
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB7056:EE_
X-MS-Office365-Filtering-Correlation-Id: 71b98cf0-6105-4319-1a19-08defde274e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|1800799024|7416014|366016|23010399003|10067099003|56012099006|6133799003|3023799007|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	OSuNz6ieTZElrKtj3J9Oo0wy2ehTJP+75yjXhw0Rtr7qdjgEYhTXV7KnLB3pYXyoUeEr6rmqqhsKnS0X4PWdmfPcz1eNIM8Tiho+yDVRBv3twBraYB6WUFomvB8MrMxyhB6cJ01C7jf/CFquX0vglcpGelE31X1TMlNYb0ppRf+H9vyktyIgHz2n3Qgf8b9Mz/5QgmTBOKKu8ccZOOEEXT6zKn6ngbLtwOIbUz5kJcsnAjM/nhhKM29uJX37cNVNjH3AZppJw0B4/9LJSA+/hcTpD/LMiwG9PkMWrmiwEXLhPXaxfxcb/99+pYgYBJMOaXlRhuP8dLV82Yny54G924QA53DsONJA1uU1E8dlGRBXFsLBOAWLJhrnqM/+fvy/kh4C5EL9gW2QsuyTnfN9QqnbRYO2spfj64oQm4L37PqkvdcaarMni5q3vBmhZNYdQhd98fDVMqbk6vJXs4YG0nB3JLFEt7jQaL4bOWX0xJ7qJBUXtzEPOfIdiELllk5GRk6pPCfW1TDEFY3PwO57J8sSK249ZKJ990qrPKT65Ip45lSGIIEerm3al9d7+Poz77xSDrJoNPQZL1AnBPWdOU5rsPLbdn80gTio6aiYNTLJs2ZFojz+NkoWGaNCIoLy56V5ngfRRH24PJi06EURpLIfnlhxDGp0aGz4MZw2or1YzwP+Pe8ngjfOJJ+cYKAIemt3MygxTavry2uUyKFMYQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(7416014)(366016)(23010399003)(10067099003)(56012099006)(6133799003)(3023799007)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUJZSmdCNmZEN2Vxb0tjMk1WUllGUC9WTmhMNmllUEVaelptcmREN2VEd2xL?=
 =?utf-8?B?NXZMZng1UmFlbk4vNWpPcHd2VFdKK1hURHVsWGFpUkx4RmJXSjJFb2tXb1Jv?=
 =?utf-8?B?U1JpQUtWOGwrdm1PRStWOTAvQTFWR3huVXNCbDlzWStnMWxjOTVKMnJGUGZr?=
 =?utf-8?B?UUdMTktuUVdkVWxmMDZ1QTV5MGJCNDB2amcxYldoT25sV1VTVkNxaWlXdjNr?=
 =?utf-8?B?RFp4TU1vRHpFbmxnWWZZa25yM25RUVhpWmxQSDJiczRmTkN2bWplMTR1RGxy?=
 =?utf-8?B?QVkrQ2hRYk9jeEVYY0VIeGd0WHpWRWpVdzRBODdGdS9EemVLUmwyTUFsMDZv?=
 =?utf-8?B?UnVIdlVSOGpIU1YvQzg0T1ZzVno2Wk45UUNEbTlYZ0ZzeUNDc0dQQWRsdzdl?=
 =?utf-8?B?MkUwSUwxL3ZYYUxvSGJjU3ZvSDNwREdUWE0zQTI2QWZhV3hRVnRGeURna3ZG?=
 =?utf-8?B?bWdCMmZXQUVEeVo2amZHMy85NWNtUkY0cnNuV0ZkcHAwYXNuTTZwby9FQXZ1?=
 =?utf-8?B?emZxMmpuQ0x3b3RvMm1HOHIvUXNEZktKcE5yaHRuWUphOHR1SUEvNy9OcEFa?=
 =?utf-8?B?Y2tMNmhpaVFPcEt3dm9KWUdyd0RiNys0MnU2c05BdGR0S0lNMHdkZU1HeTVL?=
 =?utf-8?B?S0pYQjk0czJsYmFIY2JNT3Vhc04wcHlpai9Mc3BrcXpWMHdhM3REZEFUd1oy?=
 =?utf-8?B?eUM4NFdwWi9WVlpnK1loTzdJMWJEYlZUL2xpaFFiUitIaW1PQXlweHpacjda?=
 =?utf-8?B?ckVpSndrZFE5NmkrdmtudEJrbzJkZGNLblltc2ZNK1p2Rld3bW1EbldMQitP?=
 =?utf-8?B?S3QzbHZhUms3b21tVys0K0xYdksxOWZDSHNDUEdmeStUN2pQNEpZNFY5eTlN?=
 =?utf-8?B?QmNGb0pTMDNjVVpmNVRIRXh3eFQvdTUyc01Ba1kwZE1oK0ZScU9QOFFkUWJN?=
 =?utf-8?B?TkR2VURDbkYvVFlxM0NVTDV6OVFSVVlHK3NpWThrc3lkS3FNQmtTNzRRR3Mx?=
 =?utf-8?B?TU1pdlc4NS95cjM4TllCYy9Wc0x0VWp1VUxoa01qZnI4bk5tSTlmM3ZESHY0?=
 =?utf-8?B?N1F3MkpmUkRYZkEyZ3Rnb2VOb0VsaTZuVE0xSkpqa2F6Q2Faem52Yng2SC9Q?=
 =?utf-8?B?N0NiOHpKNWhMTUlXOUpQVGpGMHh6WkVyZHFMb1BJcU1PZ09JU3ovdmFDRnpi?=
 =?utf-8?B?YmFNQ1VnSEJLYjN3eXhRQmlIQkJadytsZ2Y3TFVRU1p1S2FkV21TTjdtU29i?=
 =?utf-8?B?L2RFUVlGR04yWmp2SnFhR0hrc1l5Tkl2eXQ2YWJTQjhHUlVPRWt3TU83bjFT?=
 =?utf-8?B?V2dqOFE5eDNkUytJNlNZazJHdC9BTnBOOVg4ZC9qTTRjY2RYaXV6TFJBZWxj?=
 =?utf-8?B?Z1g4dktpd1YySml0b3U3RGZic2djZmIrN0J4MkEyTGg0dnhZbzJjbFVIU0JO?=
 =?utf-8?B?MHk0am1GR0ZzYiswc1lxWUhpV3l4di96dmRhVmtBVEtFTHloVkZGU2QrbUQ0?=
 =?utf-8?B?RFJCc2FBN0hpR1BHNWRoWHZjcmE1S0p0RUM4d2hkUGxDd2wrUWU0ck4ybWx3?=
 =?utf-8?B?c0VwcXgzcE01bFBXU1l2c1NMMkd3Vm1CTDlMVzd2K2llYUhEZDVaOEdWR1M0?=
 =?utf-8?B?VkJ6Ni9UMjNLQnU0TDNRa3ptQzlOVGtTZmZYM1VBOVQ0RjZpVWwzS3FhajhJ?=
 =?utf-8?B?YnNBUU5nZmxDeG9GZUhLWkxLZHVIVHphR1JnY1dNRDE0RWJTQ0dmN0JLNjNU?=
 =?utf-8?B?T0x6K0ZjOHY0SUtUTDE5WnlVdUU4ZEJ0QkZPZks4RVU4RHVtbnpDaDVvcWsr?=
 =?utf-8?B?djVDRlFic2hPeDVqMStGbmZBLzkxaEcwUWtQYUEwSWJITWg1WldORjMrTDVO?=
 =?utf-8?B?S2Y3M2RMWHhEbGlFY2pOOFlOSEFsWmZXYWhCS3ZaTjBwcEZuV0dlTEpKVm8w?=
 =?utf-8?B?L2JsT241TXNaRUp4U1ZSU0djeWE2UjBXQmlEcG1lVzJaZWMzVllYWWpsNjNy?=
 =?utf-8?B?dlpnRXdkSGNIVGZjcitQRUpGQlY2clJMdkdyblB6VnpRNkVtQnNXeXozaHdl?=
 =?utf-8?B?cHV4Z1VvK21hWVpxcE9zVi90MnpqOUM2dVIwUUVSV295OXVUWkRNSk1aQkJ5?=
 =?utf-8?B?UkRXYmZzL0N1YW5RSm5qSWFQcVFWSk0zM2hEUkJUT0tjZTAzelZwc0JzcFFp?=
 =?utf-8?B?QnJOb2ZvQTQ5M1Z3U0tlZFZpWjB2d2hERWNyQXpBbElwWkFBQmdLK3FOVjRF?=
 =?utf-8?B?M0pDQXpaM2RhQ3FJOVpuVGNodHg4V2hoSGdyRVNoOEVIT05janFWSFhhNDRO?=
 =?utf-8?B?cGF5L3ZCMGVQb1M4S2Q1bVAxTmVMNmxhYnNsNEVSMzlZUU5MeDRnQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b98cf0-6105-4319-1a19-08defde274e6
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 11:10:20.0270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SzsWuObU/rSmpqeN9bmqRpclvhJnQf5bYYS9Q0Qw4J+QotwPIlBGJVOrKcPRCOdw8TV9NazD4/6Zd+m7a268jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB7056

All registers use the same base type, which is `<IoMem as IO>::Target`.
Thus add the base parameter to `register!` invocation.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/drm/tyr/driver.rs |  1 +
 drivers/gpu/drm/tyr/fw.rs     |  5 ++++-
 drivers/gpu/drm/tyr/regs.rs   | 45 ++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index bfb0ba19caff..730b84e37a54 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -46,6 +46,7 @@
 };
 
 pub(crate) type IoMem<'a> = kernel::io::mem::IoMem<'a, SZ_2M>;
+pub(crate) type TyrRegisters = kernel::io::Region<SZ_2M>;
 
 pub(crate) struct TyrDrmDriver;
 
diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
index 47d25c901bd0..7edb5eff1707 100644
--- a/drivers/gpu/drm/tyr/fw.rs
+++ b/drivers/gpu/drm/tyr/fw.rs
@@ -39,7 +39,8 @@
 use crate::{
     driver::{
         IoMem,
-        TyrDrmDevice, //
+        TyrDrmDevice,
+        TyrRegisters, //
     },
     fw::parser::{
         FwParser,
@@ -101,6 +102,8 @@ fn from(value: CacheMode) -> Self {
 }
 
 register! {
+    base: TyrRegisters;
+
      #[allow(non_upper_case_globals)]
     pub(super) SectionFlags(u32) @ 0x0 {
         0:0 read => bool;
diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
index a62724378ced..0c419c4e1186 100644
--- a/drivers/gpu/drm/tyr/regs.rs
+++ b/drivers/gpu/drm/tyr/regs.rs
@@ -57,7 +57,11 @@ pub(crate) mod gpu_control {
         uapi, //
     };
 
+    use crate::driver::TyrRegisters;
+
     register! {
+        base: TyrRegisters;
+
         /// GPU identification register.
         pub(crate) GPU_ID(u32) @ 0x0 {
             /// Status of the GPU release.
@@ -315,6 +319,8 @@ fn from(mode: FlushMode) -> Self {
     }
 
     register! {
+        base: TyrRegisters;
+
         /// GPU command register.
         ///
         /// Use the constructor methods to create commands:
@@ -380,6 +386,8 @@ pub(crate) fn clear_fault() -> Self {
     }
 
     register! {
+        base: TyrRegisters;
+
         /// GPU status register. Read only.
         pub(crate) GPU_STATUS(u32) @ 0x34 {
             /// GPU active, a 1-bit boolean flag.
@@ -463,6 +471,8 @@ fn from(access: AccessType) -> Self {
     }
 
     register! {
+        base: TyrRegisters;
+
         /// GPU fault status register. Read only.
         pub(crate) GPU_FAULTSTATUS(u32) @ 0x3c {
             /// Exception type.
@@ -768,6 +778,8 @@ fn from(mode: CoherencyMode) -> Self {
     }
 
     register! {
+        base: TyrRegisters;
+
         /// Coherency enable. An index of which coherency protocols should be used.
         /// This register only selects the protocol for coherency messages on the
         /// interconnect. This is not to enable or disable coherency controlled by MMU.
@@ -808,6 +820,8 @@ fn from(mode: McuControlMode) -> Self {
     }
 
     register! {
+        base: TyrRegisters;
+
         /// MCU control.
         pub(crate) MCU_CONTROL(u32) @ 0x700 {
             /// Request MCU state change.
@@ -849,6 +863,8 @@ fn from(status: McuStatus) -> Self {
     }
 
     register! {
+        base: TyrRegisters;
+
         /// MCU status. Read only.
         pub(crate) MCU_STATUS(u32) @ 0x704 {
             /// Read current state of MCU.
@@ -862,7 +878,11 @@ fn from(status: McuStatus) -> Self {
 pub(crate) mod job_control {
     use kernel::register;
 
+    use crate::driver::TyrRegisters;
+
     register! {
+        base: TyrRegisters;
+
         /// Raw status of job interrupts.
         ///
         /// Write to this register to trigger these interrupts.
@@ -912,7 +932,11 @@ pub(crate) mod job_control {
 pub(crate) mod mmu_control {
     use kernel::register;
 
+    use crate::driver::TyrRegisters;
+
     register! {
+        base: TyrRegisters;
+
         /// IRQ sources raw status.
         ///
         /// This register contains the raw unmasked interrupt sources for MMU status and exception
@@ -966,9 +990,10 @@ pub(crate) mod mmu_as_control {
             prelude::*,
             register, //
         };
-
         use pin_init::Zeroable;
 
+        use crate::driver::TyrRegisters;
+
         /// Maximum number of hardware address space slots.
         /// The actual number of slots available is usually lower.
         pub(crate) const MAX_AS: usize = 16;
@@ -977,6 +1002,8 @@ pub(crate) mod mmu_as_control {
         const STRIDE: usize = 0x40;
 
         register! {
+            base: TyrRegisters;
+
             /// Translation table base address. A 64-bit pointer.
             ///
             /// This field contains the address of the top level of a translation table structure.
@@ -1104,6 +1131,8 @@ fn from(val: MemoryType) -> Self {
         }
 
         register! {
+            base: TyrRegisters;
+
             /// Stage 1 memory attributes (8-bit bitfield).
             ///
             /// This is not an actual register, but a bitfield definition used by the MEMATTR
@@ -1137,6 +1166,8 @@ fn from(val: MMU_MEMATTR_STAGE1) -> Self {
         }
 
         register! {
+            base: TyrRegisters;
+
             /// Memory attributes.
             ///
             /// Each address space can configure up to 8 different memory attribute profiles.
@@ -1292,6 +1323,8 @@ pub(crate) fn from_mair(mair: u64) -> Self {
         }
 
         register! {
+            base: TyrRegisters;
+
             /// Lock region address for each address space.
             pub(crate) LOCKADDR(u64)[MAX_AS, stride = STRIDE] @ 0x2410 {
                 /// Lock region size.
@@ -1353,6 +1386,8 @@ fn from(cmd: MmuCommand) -> Self {
         }
 
         register! {
+            base: TyrRegisters;
+
             /// MMU command register for each address space. Write only.
             pub(crate) COMMAND(u32)[MAX_AS, stride = STRIDE] @ 0x2418 {
                 7:0     command ?=> MmuCommand;
@@ -1480,6 +1515,8 @@ fn from(access: MmuAccessType) -> Self {
         }
 
         register! {
+            base: TyrRegisters;
+
             /// Fault status register for each address space. Read only.
             pub(crate) FAULTSTATUS(u32)[MAX_AS, stride = STRIDE] @ 0x241c {
                 /// Exception type.
@@ -1705,6 +1742,8 @@ fn from(sh: PtwShareability) -> Self {
         }
 
         register! {
+            base: TyrRegisters;
+
             /// Translation configuration and control.
             pub(crate) TRANSCFG(u64)[MAX_AS, stride = STRIDE] @ 0x2430 {
                 /// Address space mode.
@@ -1760,6 +1799,8 @@ fn from(sh: PtwShareability) -> Self {
 pub(crate) mod doorbell_block {
     use kernel::register;
 
+    use crate::driver::TyrRegisters;
+
     /// Number of doorbells available.
     pub(crate) const NUM_DOORBELLS: usize = 64;
 
@@ -1770,6 +1811,8 @@ pub(crate) mod doorbell_block {
     const STRIDE: usize = 0x10000;
 
     register! {
+        base: TyrRegisters;
+
         /// Doorbell request register. Write-only.
         pub(crate) DOORBELL(u32)[NUM_DOORBELLS, stride = STRIDE] @ 0x80000 {
             /// Doorbell set. Writing 1 triggers the doorbell.

-- 
2.54.0

