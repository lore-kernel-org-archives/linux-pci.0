Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021101.outbound.protection.outlook.com [52.101.100.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E089A48551B;
	Tue,  1 Sep 2026 16:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281448; cv=fail; b=jpolBUaLQIi0wtaBNp3DW67WJ2CIM93g/KCJq7pYxuebUizrLtL/aE5BpnmChbJxgVOutFimgUdJQSprTxGPS7Fzlt9Ss1CCQPF/zQKtmGT8LK5889jp68m4WcDCvfLgAI7vdCR3dFmun1nnk5mKv4XOslcrfZS2+DAnNOg1/uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281448; c=relaxed/simple;
	bh=nTJ7wZSeeUArV1c5w8DwZwK2ut/RdnBTX0czYVxRigA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=az9LIR28nWHznZsp4QxGDkpfKPUZQDkTedV/Tbh4ne1kLhnugkeLeyqd0nL08LjgZ30/f/YEujEouoxqdKI6xBUx/jK2PEGlhkyD+DCwqSKRUT1VqkNK0I8MexyoipeylXIrlYHaAeIvFGtIhQr6N4owGXqVfcHXj37KIa61su0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=pGbWEPpD; arc=fail smtp.client-ip=52.101.100.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="pGbWEPpD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEj81LyXE8o44GHfyhH0frbWpEFZWka5GxhHIM1llm3np9J2DKiUZT+GDajN0f+u+jWPLmZdXjWy6ncNmxVb3YVYHs8N4/p/oN0Tg7hg3m1lBK+3WsJ0bxIUaCU+3JWpFgi8xG4mjpPLoKqAmWpGDQXskp/KJ0MXTnYLJ/IXfkXg9JRhUxF9np0OeyHzW1A/AkWzGQeIR8a/nGBv1n1dQ0/ozIJ/CsY5LARDFIOxjdrejX5Lx3TgdQLh5BzqR2WajVNTJ5ClCT4X6c7Yp7xxShZgq5Tm6g03GHgRfTO2r++K52f2CuK+FQndHsttQPE7zU1JhKbO/AGCQo/YI4oxaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvWLye6q3T6iJdVLSyDKt2fXUAcrrEInZPcP41AR6Mo=;
 b=tc0QNDZPcJiRPb7uFP0O+4dSHiC0zskWuX8zfSI27lXZe+Vwuv+BPwcJMmQCjV1YLr7GrPpGNby6GX9E4/hj2emSLV0Pi2X+eVTd9i9HDWMe6zEVmidt3B5bqSmAmmXUTdEYpkxVQhffz1UGSIgAzixZiFdb1vgOgA7plbwx+VxBM3spN6KBxqCJImXOPrnPzdts19GT21oyAiOhaXRuO7ctg3S+b5ydOJknxoT+6OZgrEU2uJUkMi+MnYlk4YXQt9KF/vSyXjUbHBLOTDhrs7LVaMD+Tuy+LCyubOxHpE2rBfXz6i56/0CrkdExWUXXQgiwIqf7tVKJHInL1ksCYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvWLye6q3T6iJdVLSyDKt2fXUAcrrEInZPcP41AR6Mo=;
 b=pGbWEPpD58kDZLpBL7AR09S5fQDJx/XIkYg3NjRHu9DQF2sHwsYfX6dNNGGzod/Ad/duZ0/xwIGdoY0fl9su9b83RdgKx9xHytagf3wqptCtmR6n4oIu7z4UDkrYAb4tQNuri8Q3EDWzR1QxJEMFM8XX9ZGKRhQvgFBDz1eGvJc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CW1P265MB9199.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 16:50:39 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 16:50:39 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 01 Sep 2026 17:50:32 +0100
Subject: [PATCH v4 08/16] drm/tyr: specify base type for registers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-typed_register-v4-8-5552b1d59525@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788281431; l=7409;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=nTJ7wZSeeUArV1c5w8DwZwK2ut/RdnBTX0czYVxRigA=;
 b=hwh470+H6ghU6gJ8+uNBfwNSKLi57prsGhGKA92YknymqxtJWpT3qb85Ljqc875s7yHLWqFsn
 bDqz8D0Gh1/BCGll2fOGh8VdoUWwBg3hI2G5jefFO6CTzg6QV8l4Io+
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
X-MS-Office365-Filtering-Correlation-Id: b5645085-ad1c-4f39-d928-08df0849274c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|10070799003|376014|23010399003|366016|921020|6133799003|3023799007|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ldHPAB4UBRCPQKaSAK43PhZCNO9g8cg1w/Qp180l+gxQoPAFd2bMHaL+OfYLJAlpCgjN+ZP6OLo9ZSK4yAjqkkf+5PTDLbOmN6UOvCgvga/8svHgSunRtl4rkwfgTQ9qrzBYmzZZdUdA6vxLj4ewM21IkqezMQ+xdm3xnMVm9DMG6XX5txanzCP1k4C7t9jQrva+q89zbH7Isk+5lMqU8VtwLGz7ADYfV60yYn25QjiaNP2frJMrAQVw6Sc03fqtATkX6c8liCoZAWMgUs+/WhOdh2nJOO5PUclggA31bYdUrRTNWt5W0O6dXnrbaJVblsJU7arIgSjz/koGJmvhgWQ6DuuGLPuWa4gAkWawCVSJ9TvxeBBJEk9HEXGaEbD/aPzJQeM3gZmBzz4WQT3jyrwds4CEkkAiWc8YhZ5ADsv9OjRUaVvWFKKOZHrUF8OZdrM8N34LEmCnqEc+7+q6/pWhqzjYXk1CoQ8u3g6tgUsB970mCJlLwCNSyqll0iPxiCsJaa87urbTFoBFCACyGBBkUsZe2nczye740vp0GoXQAYbFICOugviMA2ljYuWNQnJPGO32yyt4qQUEkCIhwnAOjtlL1H2in18tLxNGlalkO7BkDGJtsyQugKof23MDLCnlOCxaG7/q+zxCwFC7KBkmojiVIOYaxI6PTzneMHCmx2cL8uidas2d92jvp1cKdqxcoJk7Cn6W+fvVJh6mkA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(10070799003)(376014)(23010399003)(366016)(921020)(6133799003)(3023799007)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmNhVDFNaGwxWGpxUytwQW1ZemVJbUF1aUw0My9qUHhudG05MWoyeU12aGN6?=
 =?utf-8?B?alRmSFpPTktrRmxtcFpCU0MrZEJ3eTlNTkk0OWVRRTdabnE3c0UxL2pvOFIy?=
 =?utf-8?B?dmY4N2o0WW5EQVg3aUhZa3VpS0k5eUFUYzBOMHNTTEsvTVZ4UHNRMnZ6MUtj?=
 =?utf-8?B?cXBmZmUwZEVhRnBYK1FDdHViU0p0YnkweUNTOFp0SEVCZlJyOXFBOTdiRW04?=
 =?utf-8?B?V1VLeHVYNjVLQnQ0YVBrQm55K1pkREMxYitxL0duN1B4TDVZTWVob1Y1UXhj?=
 =?utf-8?B?UmtmNUNBZEFZUGE4aGhOMnEvSWtnOTYvcnQ1UWN4NlIvbzg4R2lud1QvTDNk?=
 =?utf-8?B?ZGZaZzVRaGIyUVhQMC9HaGU3dGJlN3lVZERERldPUGlFNWF3bnRsZUozcEZt?=
 =?utf-8?B?NVRZWHp6YmxGeFg5L2dhTDVXa1Q2VXFGdXBWdm15cDFFOUVQNXFzWHdPMW9F?=
 =?utf-8?B?cGZGVVJNSk10dTlhd1VWSjZ6eVRDMmN1ZEl2cWtOMmZXbm9RNDltMWpCL2c5?=
 =?utf-8?B?djNrbkFaZTI1b1h1bHZmaVZvMmpLTDJTRm0wdVlsckllZHgvOWZFME93SVNC?=
 =?utf-8?B?RWhtcFUxV2lMMSs4QUdxcnhHOXZCNWRremhDeTRFSHBucUFON3RSV0pkU1Br?=
 =?utf-8?B?SUh3THQ2Q1ZPMHhZOG5hVE93cXpZM1pqSDhnWjFnUTZjUWZwaDhWc2VQUkZm?=
 =?utf-8?B?bm5Rd09mZFJ0WGExZWFlVkoyUG9saVJLRUl4ZTh4clVxZ0FaVDRuUC9RYlBs?=
 =?utf-8?B?Q1F3VldYRG9GbnRlaUdvSlpiOHlTS0l6aHhwdDVPTlkwZEdCK1h0bWNVb3Y5?=
 =?utf-8?B?UzJzenJoN2s2UFNwZTJCS2hRUXdwdytqQVdsNy92SDNXRmpRaGxvZG1VWnVa?=
 =?utf-8?B?L0l3amVnaExaMnl3aFYzLzFaVzdCeUVJM2M2MFpDZXpPVFc5cTFMcVJ1YzZ5?=
 =?utf-8?B?dklnN2xNcFFOcFlmMWxianFoNHZkNENPVGhUZStRQ1JzUGFqMkZmaW1CUGkx?=
 =?utf-8?B?MGxtNUM0NzlwTXZOTkh4UDh0clRQc2N0TFJ2dzdEVElTMm9CWGZQYllLMWxD?=
 =?utf-8?B?bnREQnRaNExGMFRWVDBuZ0xNWHpwVFdxV0ZkWEVuL281d1FDVTZaa2taUHp4?=
 =?utf-8?B?UlFXNjhHMWo1Y2tLVGlqSXk3TkJHS1Fwejl4ZTVSNE1tTTNFM2IrTjJGZ2Fh?=
 =?utf-8?B?QkxEL3hOSzVORUFFR0tzS2h1ai9vSm5TSFNLeDE3VUFYTUNSZHRxY045Vjc5?=
 =?utf-8?B?NVE4WEQ2Z0ZZWml1MktJMFNucWdYTWxvblg5QVJqSCs0Vm4rOHU0a2RBd0M3?=
 =?utf-8?B?NWdSZHptTWFMc2hqOUhORnA4aDBYa0ZETE1WUFR5djExYW1MTlVWWDFLY2ky?=
 =?utf-8?B?SlI3Q3NwVEpFZ0JBR09EbDRYWVJJaVArMXFJckE1R1Fuc2hCbURkTTY3ek5T?=
 =?utf-8?B?NGlRbEQ3MjRxemZiODR3SHBYYjhiZExoQ2dOekJ6U2twMG5RUmcvanZJZmVO?=
 =?utf-8?B?ZXpRTW1MSlNHN05xZXhMS1dEYTd2YjdNelpUUlBMOUV2L3hJR3JWb3JzdGli?=
 =?utf-8?B?TjhpcXNYYVdOYk15bVVHbkJWN3FTRVFCVjJMTHMrTDhkUFhWdDNLK0hzRDlK?=
 =?utf-8?B?OGp1Q2EwbzhUbVdXOU0xbmRrTkJkd21QOHAwdEJLRlUwbXBYMmRBMWN3TTJy?=
 =?utf-8?B?L0lMNnBYbkt4QVU2cENITXdmeGkzS2NlM2pzRXpEdk1JWHdUb0Q3bnNPNFpJ?=
 =?utf-8?B?S1ZpL1EzS00rMmdNSmNNeVBSb2dpeWZ4UE9YNjlWTVc2L2ZaTVZadlg2V2Fv?=
 =?utf-8?B?bE1DY1lzQ09NK3BxZDFmZ3lHWSs0cmtBaG9lbEU5VXYrVVRxWEw5Z0NuZVl6?=
 =?utf-8?B?cnNMQ0FZbmw5dmN6NzJqQmRLZTZlUjRrYTllS2lVcmJ0MzgzeE9KZVpUd1Ez?=
 =?utf-8?B?THN5WndsbThmMnhLbkhscGhMWWxXR3AzRGUyMENBQ01hR2Q3UWgzNjMvYzVK?=
 =?utf-8?B?YVNiREhWRXFIdi9WNExrWGtBZDVrbExMbWRzSHBzUW5pcTZveTZoT0ZhWlg2?=
 =?utf-8?B?dVJsUDVsWndqYklvMytES0ZZUll6RmpzRzRxTm95QzhVMnJPUG5CZTczNzBF?=
 =?utf-8?B?SXlzVHNEVW9lZ3NrNWZzL3JXRXdxQ3diK1c0OW0ydGJwOW1IbTV4OXdoa0N5?=
 =?utf-8?B?UEk3NEl6cURXSDNSaFpGc3B0Z2JOMmN5WkgrQ3Fxc1kyK3hGVkh4Q1QvaGc4?=
 =?utf-8?B?QU01dEN1aDdzMzA2QzhzcjJPaHZuWGs4c0pwSTBQdk8zQzFXcFllMnlwVU93?=
 =?utf-8?B?THZHSGo0enl0eitGSTJJbUNGblRMVXdSNUZPRXJzN3JZNkxwZmxwQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b5645085-ad1c-4f39-d928-08df0849274c
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 16:50:39.5628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dAq2Hu39N3KsEhJM6o7T6cfJYxihwT22leb1W42nQVsiED7w5wc+/ReeF8cE2q9zNzQne8C/gelR+HVIbB7Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB9199

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

