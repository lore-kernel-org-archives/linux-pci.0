Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021089.outbound.protection.outlook.com [52.101.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D49483814;
	Wed,  5 Aug 2026 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947843; cv=fail; b=SeRre4KqMcduL93S3nqVL3Ae2iunZ3gPUU4MygPRHp/n/469zVj8I8lRb2d9LiCu3tsoSqUvf6hw8UHjBKrqnKahr2ElRhASkRlVt3H3fmkqDBnyoN/5lvHz+DXUCEOGRw0kT+eEfjLmqbN6m0dDr6BXfrpY/hFCx+JGT0fDink=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947843; c=relaxed/simple;
	bh=EA8nt8Iv5DnadzaZ1L833fTrj6susiTu+zZOLANPB2A=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pyU70sbFo9zQMTGFLkXQIgEjgopTG219qMGbLkfhvoaWLEoffNSmORxPn6M2fgk45GaPuQap/iwAP6oOMDXauy8fOzIVjtgtRaeBo7XTNr8hUUtmdAR9Or+rLuCNrL9RURzN4rZs5O364zCfHfYWcgEd12UXRgnibcFRaCQv6ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=e9RfLLx6; arc=fail smtp.client-ip=52.101.100.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="e9RfLLx6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWOH1OovDOCe4Jw1N5WmwJsxZiNxNUwYITWnPDj+85LsI+IS8ck55dJKgJwPcDE8m4YU+qPT7xzv7x5vZp3jKwusSqRfUDVE1RC+8L7h0Igh3h1DPiKVu+rz1bKk03KXpSkUrojLv+3C3AVxluDguniZyifbaW63Rvv+2rSVN3YKhrfcFY5KvuvcgyXhXXvoB2RDEncjNYvrWi+cgS2xuzxw/6T8ByuUscLOwlSW7CUL0e+gA0PGevNp3m6aWlvxp4FNzEQwN2Vo3S3AmjOJs/3I9yGWJt8JO357MTBeAxdfcs7xVyTLfLNWGY93CfVCdIJguWRpzOF/M+AYX408FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hb082skm67h44ihoTj0EfK5v+N6cUhum6FfNDFPKiGo=;
 b=emkmSzvt5u8J0D/+qqMnjmcJzUewTxDC8iy4Z8z4mO2NaMwhZJwQyLLzz/NgWf+BxyzdNkEXPVFFWngwO+OVaYvjfgGcDluC6P+K+pTV+va1yMFhC+IWLwk0TnjwbHisICwRWZ5k/lE2fnZsyO0swqd/VN2bVvDbK1wGyD7Iv/l3m2CM7ryVEOwTmHLLlrdNqu9EN+aYWGCmYie/6MLxmsgUhsyLwQAFgU4tVHkOkRtloI5gGiCiT7IyIAA06sQMkP/8ckc0QdngWRAk0D20ozCE/Ox3fhnkNpWcGQDqbSnxInUJS9W1CpIM8qGRyD9wr3fvz1/VCnutV3UejVtcVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hb082skm67h44ihoTj0EfK5v+N6cUhum6FfNDFPKiGo=;
 b=e9RfLLx6ByGSxonF2xJMGPfLrpe6fNU+3ACxHFXjP1e+l5JgomfCj9qwPExlCClcmqoDUThvsgdp+q30Tcxja0yXIJ6FBS+8iIRzs7HMxttkN+CSmpcBPBmujkQSWAoDk/U8Z17IyEJEcOPCOX4HK4083XchI2TMopRZPTv3CqU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by LO2P265MB5822.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:26c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 16:37:05 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 16:37:05 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 05 Aug 2026 17:35:50 +0100
Subject: [PATCH v2 07/16] gpu: nova-core: specify base type for registers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-typed_register-v2-7-c3ca142220a0@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785947818; l=8925;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=EA8nt8Iv5DnadzaZ1L833fTrj6susiTu+zZOLANPB2A=;
 b=0C81QwBvANKXq+syHcxgqJ0znDm/WtG/3mLtk7426pd8DGYy39xBJuH8OeCJqvs0JZdeNTH8o
 lut3Ew+kU5bDnr4zEncJI7jvJEgTgPa2AN4DzkcuAXSSv+sFbSQLT4f
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
X-MS-TrafficTypeDiagnostic: LOZP265MB8551:EE_|LO2P265MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: bcd0faee-9a09-478a-5ca6-08def30fc854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|1800799024|376014|23010399003|366016|22082099003|18002099003|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	fjfmJNXYsh7zv5zlHE8sltZEvUnOp0QfrO+md99PjhlSouoKxaRhLBdFFGq1b0F06OTDLJybcw0WtPYcFEGBrUFF1QgiQvhD/z8OKqnLiz06QOU0DvA4sOlB4lZRM7oxGxW1BQEZ750B7/IKVyQ5x2TW5MQ//shH8698bbmQ+x3Lb7Z02ghqFepSYo4OConn4e0M+jZ2QSSiczJDUGfgJVabKuRkP+OMabBPJkJg3n3BFyZ0FXdkdSCVLO/LrZVo6mTWcI5QnkGn65kP2ZyDlJ7Om43zQrZPnTgUKni1u9gCChtC/WLMqqGGMebgMF3um6OVH/WiJMtF5qmf4cSye4T/4BNVOT2nghZGQJxDZyRUI2drauDDpKRm3KTJfQ5VZhG0vGYmY/SrZ5HIjvaEAn70J67bxyI4l78+RQOuAwnYxQ+MDxSxNKaBr6sKQsd4V/ZXPBiuUsZQYVqH5E4DMInu6yyxFEeirWm8HAn2S00vErlCIaGJIqjJm6fTlkqmUyOyZbJNCnceiRBl/shvxkDx1FtYxBMafA1IYssvhRDd+82Jf0EBp+ytFKvkdXIGxKc0MHzfb8xJLa8HXrE6+Gz+oya9AmlnvpxVp42lITGLdGgjd5VgEa872JUS6dWpwluANC7v3MsidHMhchdHTnPx31eKTlJqTAQikfWllioVjbU6ogDu+iLjkqwkGmgdmuhoOEMibXH+wWLAjoNs7Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ei9mRldsRjlxdU1FaFhPRXVPUkdXeTlFdm95OWhaQUZRa2NNYTZGZ0tYeC9Z?=
 =?utf-8?B?OHVaSnFEWWZVOGkwWE5JOFQzSEFmZXVWS2F0UlZ3VGVkOXNHOURxb1FPYXdZ?=
 =?utf-8?B?dEhzNklRT1EzY2NwendrZnp4dy9CT3didUl3dWFUQm9mQ1Fic2xlTGw1ZTBR?=
 =?utf-8?B?TDlyOHFUbVRzMGdPZm9ROGI4SERRNEZxdVlnUlo0d0k1b0pMODJmMG9jS0Nu?=
 =?utf-8?B?elVRVUJJbldMTUJiT0EwMUlOMEIyQzNLRVhQbWNFS1UwbmdLcktXT1lJcWlQ?=
 =?utf-8?B?T0FCUURUeDlMbFFZWE9uNXU3ajJuOXJYN1ZIMVMwdWd0QnZObkZaZUFiaWxY?=
 =?utf-8?B?dCtvKzJZV0VjQzNCT2FScUhGTkJSNVFXdnEzTWJjM0U0ZHFWWHQwOGVkTVp0?=
 =?utf-8?B?b1dDUEFLK0liQWhEVGYrRWR4UHdkTUc0MVR6NXgrN3BubDZIdVA4b2QwK2Q2?=
 =?utf-8?B?encrOTN4bEllTHRpUlV3WkloTW51L2lkM1lLRU1xa3VnUzhVSjFVNFk1MWYw?=
 =?utf-8?B?eGlkQnFCbzZOeUpqcDlJYWtjUHJ4eUhEdzRUNmQxM1Q5QnpKZS9ndVpwM2pL?=
 =?utf-8?B?UEQ5WldvQ0ZWVW5tOUF3bmVmdzhCVnVvdUhrZGlHa1orZXIveFhxQnhJdFZX?=
 =?utf-8?B?M0owTmhWKzNMdmpHT1RaSW5EaEFpS3d6VHJLVE45VEdTZHJkaEU3N3l6VFFE?=
 =?utf-8?B?ZzQ1anZOZWpTN0dGMzN1Y2M3cndyVTBxTDBFWDM2VnJ3UGZ6QS9xZldPRzN2?=
 =?utf-8?B?MGU1Qjkvb3A0YS9KbVFtTzczcStzbEtkVWdGMU5KNHJiak5ycjhJbk9XcHBY?=
 =?utf-8?B?bFRVdTlkTWVBODNNTXB1RysrcTVZS3pjSjRNU2ZIb0w4VEFBZ1hmQkNqajF5?=
 =?utf-8?B?QmlxekJpVDBSRnBvTk5tekpneFkwQXM3b2R2TGY3WlZNM1F5RHVFS2RWZHps?=
 =?utf-8?B?T0hTNGltZCtzaEJpU2dNaEh5WFhsZkFvTktERThHNUZjcExjTnFKVWN5ZHlk?=
 =?utf-8?B?UUI4VWdmR054WStVQ2M2STdTZ3g3QkxvcU5hUElKM0puVmZJV2gyYmNrbXdw?=
 =?utf-8?B?V0FZVTdCVVlvQVpuNmdxOU5zQjlQWWZIQmZZelVlbXZZakp6dkdCTGpKaWVX?=
 =?utf-8?B?M2RCUThjWTVadzgwQTBkc0l2K3NiVy9tYnNaYWQ4bUEvWEJtRGwwNXZ2RHpG?=
 =?utf-8?B?MFk2dFNtRVAyT0xXMld3WE90Ykd0NkFtZUo1RE1VU0cxTjZ2OFYrOVVIenMz?=
 =?utf-8?B?b2lKVjV2WmtGSEVPTmkweTdzQUhQd2dabE9iTUFKYjVNSXFIWFBLWmVacGls?=
 =?utf-8?B?VVFGSWFUd250dnFKaEkxTjB6WmY4Qk9nd0FuQVpxMnlXRDQxNndERHAzMnBI?=
 =?utf-8?B?M3lZdi9QbDZYeU1oc0NDVmxaY2ZMd3lna2JJc0c0LzhZa0dYcWhDMFVvMlh2?=
 =?utf-8?B?ejQ1ZlRoR09EN0d3R1dpcEw2Y2p4MFBnbmhwSVNIMlorSUVSdGZhZHVJSFRD?=
 =?utf-8?B?enl5ZVY1WnZsNXZ5cmtDK2FFeWEyNlEvYmVBZ1N4OUdWQ25XQjdFMUVmektX?=
 =?utf-8?B?S2ZaS2hBV2VSNTRvVldjeFBLejM2YlFPTy85SzM4WW1wZWJQTVpPZ1ZRUEth?=
 =?utf-8?B?Qmgva2w3ZE9WTWwyclU2dEh3MFQvR0RkUml5WHdIbVQwY1g5V0lwWU9OeE9v?=
 =?utf-8?B?bm1iTVh3dVFNbHZVNzViekFER09ObndJdGFvT2hwRkREOEdKVXc1ekZvMVhS?=
 =?utf-8?B?dENCVEd2dTlpenNOQ2JVVnk2UVZ5MWdxbVBFd29ncjFORHlJdFRsdjBhZUlB?=
 =?utf-8?B?dFV6QTgzcnd6ZzNTRGpnUldQOHM2bEpvVElNbnRERExjeWZlV3lMeHBENkRM?=
 =?utf-8?B?eXJ2dzc3Wm1aTm1yY1ExY05oMDRENG5vR21sOWhlcC9ydTA0N3E0TCtOclds?=
 =?utf-8?B?R051a25wTXY3MmpQQzhoOVVxQTVVZnZJL1NSUUdzb08vMERZS2RyK29YL3pN?=
 =?utf-8?B?aE1XL21sanFtRnhFbUx6SmZRcUdZamNzbnR5Q1RuajFUaisrSzZ4US9aeXAv?=
 =?utf-8?B?Y1lOS3hRcHJwc3NpK042eEJaVFlHM2xKQ2x1elFzbVZYdHNnOXBEb3VHM2NH?=
 =?utf-8?B?YW5GVkM2UE85RGl3aFVhcktiT3VJdWVDRnA0OTRGVmFoOFZtdTRzY0MrLzhB?=
 =?utf-8?B?a0dwQ2RuNWdOcjcxMkFvcUFDY092Q3Eyb3Ntbk10WkhMMVF2ckhvZ0pjY0Uw?=
 =?utf-8?B?ak9obi9rTEFoWVZ4M2lGU2FtS0kyai9lOVYzSk5HZ09JYUI2cnVtNHp6THJ1?=
 =?utf-8?B?QXFxd0xOeitlZkUrRFdHSXZVKzRBdys0cEcrN21XTFN0cERYd0Zudz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd0faee-9a09-478a-5ca6-08def30fc854
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 16:37:04.5241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8AqGio3nByFOBONYRUmMQqmiKI91JC4awkJDH582ZXWVmTEhU/6TmfVvl2YDv/Y57Z8ZG7NQ1b4sYr6+cR0I5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5822

All registers use the same base type, which is `<Bar0 as IO>::Target`. Thus
add the base parameter to `register!` invocation.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/nova-core/driver.rs   |  1 +
 drivers/gpu/nova-core/fb/regs.rs  | 12 ++++++++++++
 drivers/gpu/nova-core/gsp/regs.rs |  9 ++++++++-
 drivers/gpu/nova-core/regs.rs     | 37 ++++++++++++++++++++++++++++++++++++-
 drivers/gpu/nova-core/vbios.rs    | 11 ++++++++++-
 5 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index bbd93959e0b2..cf3534dd47d4 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -37,6 +37,7 @@ pub(crate) struct NovaCore<'bound> {
 const BAR0_SIZE: usize = SZ_16M;
 
 pub(crate) type Bar0<'a> = &'a pci::Bar<'a, BAR0_SIZE>;
+pub(crate) type NovaRegisters = kernel::io::Region<BAR0_SIZE>;
 
 kernel::pci_device_table!(
     PCI_TABLE,
diff --git a/drivers/gpu/nova-core/fb/regs.rs b/drivers/gpu/nova-core/fb/regs.rs
index 95adbe124a30..c27582e376e2 100644
--- a/drivers/gpu/nova-core/fb/regs.rs
+++ b/drivers/gpu/nova-core/fb/regs.rs
@@ -5,9 +5,13 @@
     sizes::SizeConstants, //
 };
 
+use crate::driver::NovaRegisters;
+
 // PDISP
 
 register! {
+    base: NovaRegisters;
+
     pub(super) NV_PDISP_VGA_WORKSPACE_BASE(u32) @ 0x00625f04 {
         /// VGA workspace base address divided by 0x10000.
         31:8    addr;
@@ -30,6 +34,8 @@ pub(super) fn vga_workspace_addr(self) -> Option<u64> {
 // PFB
 
 register! {
+    base: NovaRegisters;
+
     /// Low bits of the physical system memory address used by the GPU to perform sysmembar
     /// operations (see [`crate::fb::SysmemFlush`]).
     pub(super) NV_PFB_NISO_FLUSH_SYSMEM_ADDR(u32) @ 0x00100c10 {
@@ -65,6 +71,8 @@ pub(super) fn vga_workspace_addr(self) -> Option<u64> {
 pub(super) struct Hshub0Base(());
 
 register! {
+    base: NovaRegisters;
+
     // GB10x sysmem flush registers, relative to the HSHUB0 base. GB10x routes sysmembar
     // through a primary and an EG (egress) pair that must both be programmed to the same
     // address. Hardware ignores bits 7:0 of each LO register. The boot path uses a fixed
@@ -87,6 +95,8 @@ pub(super) fn vga_workspace_addr(self) -> Option<u64> {
 }
 
 register! {
+    base: NovaRegisters;
+
     // GB20x FBHUB0 sysmem flush registers. Unlike the older
     // NV_PFB_NISO_FLUSH_SYSMEM_ADDR registers, which encode the address with an
     // 8-bit right-shift, these take the raw address split into lower and upper
@@ -101,6 +111,8 @@ pub(super) fn vga_workspace_addr(self) -> Option<u64> {
 }
 
 register! {
+    base: NovaRegisters;
+
     /// Low bits of the physical system memory address used by the GPU to perform
     /// sysmembar operations on Hopper.
     ///
diff --git a/drivers/gpu/nova-core/gsp/regs.rs b/drivers/gpu/nova-core/gsp/regs.rs
index 9a48aa87e7fb..3c410d65e8e4 100644
--- a/drivers/gpu/nova-core/gsp/regs.rs
+++ b/drivers/gpu/nova-core/gsp/regs.rs
@@ -2,11 +2,16 @@
 
 use kernel::io::register;
 
-use crate::regs::NV_PBUS_SW_SCRATCH;
+use crate::{
+    driver::NovaRegisters,
+    regs::NV_PBUS_SW_SCRATCH, //
+};
 
 // PGSP
 
 register! {
+    base: NovaRegisters;
+
     pub(super) NV_PGSP_QUEUE_HEAD(u32) @ 0x00110c00 {
         31:0    address;
     }
@@ -15,6 +20,8 @@
 // PBUS
 
 register! {
+    base: NovaRegisters;
+
     /// Scratch register 0xe used as FRTS firmware error code.
     pub(super) NV_PBUS_SW_SCRATCH_0E_FRTS_ERR(u32) => NV_PBUS_SW_SCRATCH[0xe] {
         31:16   frts_err_code;
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index caeef4d85874..1af073f3861f 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -13,7 +13,10 @@
 };
 
 use crate::{
-    driver::Bar0,
+    driver::{
+        Bar0,
+        NovaRegisters, //
+    },
     falcon::{
         DmaTrfCmdSize,
         FalconCoreRev,
@@ -37,6 +40,8 @@
 // PMC
 
 register! {
+    base: NovaRegisters;
+
     /// Basic revision information about the GPU.
     pub(crate) NV_PMC_BOOT_0(u32) @ 0x00000000 {
         /// Lower bits of the architecture.
@@ -108,6 +113,8 @@ fn fmt(&self, f: &mut kernel::fmt::Formatter<'_>) -> kernel::fmt::Result {
 // PBUS
 
 register! {
+    base: NovaRegisters;
+
     pub(crate) NV_PBUS_SW_SCRATCH(u32)[64] @ 0x00001400 {}
 }
 
@@ -121,6 +128,8 @@ fn fmt(&self, f: &mut kernel::fmt::Formatter<'_>) -> kernel::fmt::Result {
 // number.
 
 register! {
+    base: NovaRegisters;
+
     /// Boot Sequence Interface (BSI) register used to determine
     /// if GSP reload/resume has completed during the boot process.
     pub(crate) NV_PGC6_BSI_SECURE_SCRATCH_14(u32) @ 0x001180f8 {
@@ -175,6 +184,8 @@ pub(crate) fn usable_fb_size(self) -> u64 {
 pub(crate) const NV_FUSE_OPT_FPF_SIZE: usize = 16;
 
 register! {
+    base: NovaRegisters;
+
     pub(crate) NV_FUSE_OPT_FPF_NVDEC_UCODE1_VERSION(u32)[NV_FUSE_OPT_FPF_SIZE] @ 0x00824100 {
         15:0    data => u16;
     }
@@ -191,6 +202,8 @@ pub(crate) fn usable_fb_size(self) -> u64 {
 // PFALCON
 
 register! {
+    base: NovaRegisters;
+
     pub(crate) NV_PFALCON_FALCON_IRQSCLR(u32) @ PFalconBase + 0x00000004 {
         6:6     swgen0 => bool;
         4:4     halt => bool;
@@ -392,6 +405,8 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
 /* PFALCON2 */
 
 register! {
+    base: NovaRegisters;
+
     pub(crate) NV_PFALCON2_FALCON_MOD_SEL(u32) @ PFalcon2Base + 0x00000180 {
         7:0     algo ?=> FalconModSelAlgo;
     }
@@ -414,6 +429,8 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
 // PRISCV
 
 register! {
+    base: NovaRegisters;
+
     /// RISC-V status register for debug (Turing and GA100 only).
     /// Reflects current RISC-V core status.
     pub(crate) NV_PRISCV_RISCV_CORE_SWITCH_RISCV_STATUS(u32) @ PFalcon2Base + 0x00000240 {
@@ -439,6 +456,8 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
 // These registers manage falcon EMEM communication queues.
 
 register! {
+    base: NovaRegisters;
+
     pub(crate) NV_PFSP_QUEUE_HEAD(u32)[8] @ 0x008f2c00 {
         31:0    address => u32;
     }
@@ -462,9 +481,13 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
 pub(crate) mod gm107 {
     use kernel::io::register;
 
+    use crate::driver::NovaRegisters;
+
     // FUSE
 
     register! {
+        base: NovaRegisters;
+
         pub(crate) NV_FUSE_STATUS_OPT_DISPLAY(u32) @ 0x00021c04 {
             0:0     display_disabled => bool;
         }
@@ -474,9 +497,13 @@ pub(crate) mod gm107 {
 pub(crate) mod ga100 {
     use kernel::io::register;
 
+    use crate::driver::NovaRegisters;
+
     // FUSE
 
     register! {
+        base: NovaRegisters;
+
         pub(crate) NV_FUSE_STATUS_OPT_DISPLAY(u32) @ 0x00820c04 {
             0:0     display_disabled => bool;
         }
@@ -488,9 +515,13 @@ pub(crate) mod ga100 {
 pub(crate) mod gh100 {
     use kernel::io::register;
 
+    use crate::driver::NovaRegisters;
+
     // PTHERM
 
     register! {
+        base: NovaRegisters;
+
         pub(crate) NV_THERM_I2CS_SCRATCH(u32) @ 0x000200bc {
             31:0    data;
         }
@@ -505,9 +536,13 @@ pub(crate) mod gh100 {
 pub(crate) mod gb202 {
     use kernel::io::register;
 
+    use crate::driver::NovaRegisters;
+
     // PTHERM
 
     register! {
+        base: NovaRegisters;
+
         pub(crate) NV_THERM_I2CS_SCRATCH(u32) @ 0x00ad00bc {
             31:0    data;
         }
diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index c03650ee5226..9c214b9f4dd9 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -16,7 +16,10 @@
 };
 
 use crate::{
-    driver::Bar0,
+    driver::{
+        Bar0,
+        NovaRegisters, //
+    },
     firmware::{
         fwsec::Bcrt30Rsa3kSignature,
         FalconUCodeDesc,
@@ -92,12 +95,16 @@ impl<'a> VbiosIterator<'a> {
     fn rom_offset(dev: &device::Device, bar0: Bar0<'_>) -> Result<usize> {
         // IFR Header in VBIOS.
         register! {
+            base: NovaRegisters;
+
             NV_PBUS_IFR_FMT_FIXED0(u32) @ 0x300000 {
                 31:0    signature;
             }
         }
 
         register! {
+            base: NovaRegisters;
+
             NV_PBUS_IFR_FMT_FIXED1(u32) @ 0x300004 {
                 30:16   fixed_data_size;
                 15:8    version => u8;
@@ -105,6 +112,8 @@ fn rom_offset(dev: &device::Device, bar0: Bar0<'_>) -> Result<usize> {
         }
 
         register! {
+            base: NovaRegisters;
+
             NV_PBUS_IFR_FMT_FIXED2(u32) @ 0x300008 {
                 19:0 total_data_size;
             }

-- 
2.54.0

