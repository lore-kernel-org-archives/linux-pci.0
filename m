Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021087.outbound.protection.outlook.com [52.101.95.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C70445D5E8;
	Wed, 19 Aug 2026 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787137834; cv=fail; b=nQHJspifU7BqwJRpeNQudWZ7RWSL5WJh327a6H61yBMn6zP6UoYh5ccjlUwKblq0MDET++5FidiouWlkzruKt5SBhD2+i0lS33SuBJDiJaa0cWOqGil0hxE+aQA7ZzrsCq7oVsZmhLa3GQ/N/j4UNQS45pNJ4/HHt9Gq/H+SR78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787137834; c=relaxed/simple;
	bh=EA8nt8Iv5DnadzaZ1L833fTrj6susiTu+zZOLANPB2A=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qmcafWXZAdfjk8MkIgfRru0xdT3cpIy9NJsVkQAr7VhmzLpxXlfpIkK2syFXaJnjTdDNvtpgI8JmDZrrAnZVArrWLpnzFf/E+5hgj/dToDR7zjhNw9KFnPg9p5UDcJGngxFnPX8jBKtLnT05Q/FRiBazTtVRTZZKAoLeUas5A6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=D/vlFjbg; arc=fail smtp.client-ip=52.101.95.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="D/vlFjbg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vx7IIfosOm+s60SPvu5v/hUovVbU8s+miUbjGMs18Cx0+tjEz+iuT0bNbtyMxIL1RqYZN73RmkWgjMa+RwlUt5B2W0vm9Lx+2BxD1953G3FBsV4bD9meaus3HAAXiFkYXrQtozPZaxiXKgCqNV5OA/WEbfDZc6NYlnrAlo5dKb6ccZJYwTXrgYsXPEkkXsBTVe0BXG0MNIvEKV/8FBSLzy44i+1BQaV/E6IYOKZFHd3Z5IroY7RDPEh3TWmJquIN0FuME2w8eam4q0Eq/GTysADu5abgUDrBFIRcmqonbsRzIx9f/LolI8GYSkuslKhRjH3ognFW1nTwb20eN5piPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hb082skm67h44ihoTj0EfK5v+N6cUhum6FfNDFPKiGo=;
 b=RdfrXEXzbVNNyl6geTDFUM0BbTGnsnrEtSzLzrnAHJ3W95aatpd9Gml0KWhiF5Jfj6kpalRGoJMREF8OG0YRudqP2TrqGHtxCUyoE3m0dGLGIGNRVdC46bqhOeUOyQD/cxmXqy6UElVyFmdm4vos4sYCfoP8fSaXSe0Y07UjD+qyrjF+TVNqr6I7M68hkNaO4iD/ZkYwPKkg2k/GRFRXfqs5ozIYbGuyQigrdwZILiyU9aIoaHAY2Vw/DLHpgfxHaLt0FtGyTUyiFfEUcNHHRyXnfMLkclxkQIByJrQ8N78ALddr+SUxMpB1ApbnPkrmPmjptMd1pWQpxqXLiP4Dyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hb082skm67h44ihoTj0EfK5v+N6cUhum6FfNDFPKiGo=;
 b=D/vlFjbgquGHAa2pkz1YLMdB3R4fxQYcdTRYeBX2jyomtSAYkuyFFjegEj724vgq83BzRbFVxdof9SQSZ+aBdlG1W25u3CeMtTcJCh6DUkvArQd4Bah0Zlk6TvnGfnujyWTjdBQohxV2QBmjQjyVWd/ZTNw40PwrNwPJxiyj6BI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB7056.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:200::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 11:10:19 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 11:10:19 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 19 Aug 2026 12:09:15 +0100
Subject: [PATCH v3 07/16] gpu: nova-core: specify base type for registers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-typed_register-v3-7-3699a75fadf1@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787137814; l=8925;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=EA8nt8Iv5DnadzaZ1L833fTrj6susiTu+zZOLANPB2A=;
 b=YznlK0ObFWYzJ8n9slKdL9huS5iGINAwRO5Id2ZHomIFVJ6OKPGKASHHTW5Mg3fb+jxI+cO0v
 Ep1TBlQXRlaAA2WZGE1sD/tLFnGewjM+cOhZCycCghFzELuRpMjdBtj
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
X-MS-Office365-Filtering-Correlation-Id: 9ea6ada8-1398-4d5f-4cf9-08defde27488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|1800799024|7416014|366016|23010399003|10067099003|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	V1J9RhJ/XkWh9Muact+97+H2j5ABneLsTeh+AuwqyL0AKYVVbn4yVoGuFwcyVfZk4npMPbglZe4EwDeVirurnH+yt7iLdzRArVvKUgezVOLeOsuGmC7lydQNePY/rGsx/HgWE2vlCHWvgS81ra2kFjNQJPqVsGTAMP94l19Pp3ROt5LJf35o+hCzel29XVQJ9pzxfMCqcL4uw+fOcajWPqB3IuRn17b2Mboez6lPOa1DBo3or6LYripH7bgku2mmyfoNxEIMmzLr3Gtpnid+Eh5j5WqFMTB3QLR6XKIHAy3Kos/I2KEdR35XK9qTJDAoHkMoLY9Xs5+ttA4CHT6LQbRg/XDbMO57tZIqxq2b52n3bQiMt0MzN3KPC8nJBPrQR5cxsPRQQqAdQh9f06Eyv3e5O82S6ud4/uzZfOIoLi31zqw6CpWehHl5OwjDSnUcv3plCQcyUBDxq5MQjTyKKceUDVgfyS7x36UgqT0hXeZ5URjW1qNcJJVXKGRSbSMcOMBT8FchrzLXSLFBKby2gel/Zhg//JQFpQDxHcl2Xdv5o5qH46IwlRTm1VdEqdzShmZm8nyQNu4Mw6323HgOoExkBLHV6qtuLF/9nZ+2hc7rnYQoc4US61tUKwOxEtN1MySnUeI0PdB+SIWT+fmR2r4yvGjU1yXLSsNztoJikq9j/dw5JkCs8ToHKOjfLwyb6z/UIyyYvG+TTLuRgEc8wQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(7416014)(366016)(23010399003)(10067099003)(56012099006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0F0dmhRZXN4eWN5MTNpUkJtQlpOanlEMlR2OXd3alhrdUpsT3BObVJ3RnlC?=
 =?utf-8?B?dGxiTWhQbG9VTWdYeWZnODJ5cWlCTlMxMjFWSmRGY0dKRTAyMkFFc3dhemNP?=
 =?utf-8?B?NEVUTng5U0Fic2VGQkpqWUtiTlQ5cjVVcU1DdlZNUDVpOU5paEtTNnFDVkpt?=
 =?utf-8?B?c0RZeVA5YlFia1pEeHZHbnZEMllVWGs2WkxFWlBUT05MTXZqTHRMc3RrTW5S?=
 =?utf-8?B?b0JZSWY5S1I3YlRxNGVCYmdQMDNzWXc4VC9qTHRmeTU1ZkZTZy9NNDJyclFa?=
 =?utf-8?B?K0Q1Vm1ORlRvbVNxTmdwMGtSYTVtSkNQRFNmZGtGUFhUOUhmT0hWQmZGSUJQ?=
 =?utf-8?B?aTNVaXRydVN2UnVHRjNrRHNmNU16UGFPSjdXK2pWeldTK1JJd2NvTm1lUzY5?=
 =?utf-8?B?VTlyditydEkxVVN0bmJGcFpvQXRmUFQ3cFFTR0NwZ2xxazZEV1NVWUFocU91?=
 =?utf-8?B?Ukkwd2V4T015WDJlSjZZblN0bU02ZVR1LzhHSVo4YW8zY0oyNVY4M0k5bGE1?=
 =?utf-8?B?N0MrN0FwWVV1cjRMZHl4LzRuZmN1YXJ5NE5tYXFFNS8vZmhkdlpCY2poeUM2?=
 =?utf-8?B?Y2MxWGtBczd0ampURzZwaXExRVl5a0dOem9pekFGZG5GcmFTV0Z5WDlhbFhj?=
 =?utf-8?B?YkVlWGdYeGtTRlBvTlJidWJlVWY1a245RVB1eCt6NVNwNTJOb29tU2pFOWU4?=
 =?utf-8?B?NzgwUmdZMHFUWDFqWWFPRGdRTmk5Z0dyUXdtQ1lsNEtCdXFPaGJXVzhvbWpE?=
 =?utf-8?B?ZlUwYXlZRGIrVkVLQjZTa1ZQWC9taVkrL0VrbFpKdy9hREJQN1Q0OXUrb3dE?=
 =?utf-8?B?NERCeVVITjdlLytXM0xtcGtNMjJZeDdlR3YzSjU1Nkl5NzllYmlXSzFHdUZ6?=
 =?utf-8?B?UWtnL24ydGVjOEtYYTk1MkU3bkpwK0pHUGI5WnYrNXh1WW9OSThacEZrbi9t?=
 =?utf-8?B?R3Nncm5mMW5CL0VTbG1zNzV0Umh6OEJOR1ZkQ0V4Q1NPSkdPR0VuVnV5dTVW?=
 =?utf-8?B?dzYwS3VuLzhIQ2hETjBnR1ZObFZYQVRESEZQL3hGWUhTTk1UYURVZ3NTOTVp?=
 =?utf-8?B?UUxvdE1NSnc3Mk9WOUdhdUp2VG1BNEtkYTdML3hWR2VINGhTYzQwczJjZm1L?=
 =?utf-8?B?bDU4Z3lWY2pDMVQ1ZXlaQ1N2QW9TRENsZ3g1VkM1Yk9oVXF6Z0RHQmhqUEll?=
 =?utf-8?B?YWFNc1I1REd4R0lZRURWSXhtL2ZDWkg3WnlWT3FwcUZ6Zkd6Wk9KV0llL2l1?=
 =?utf-8?B?VG5SbklkRG11blJYekY0c0dSd2M0VysrdEovdlZaQ3ZieEJ1djJVelBvZWRZ?=
 =?utf-8?B?MDZybStuNVRpRFNFTnVRaE54Y1RGSFNEYko0REcycU9Na2JobVJvNTFRMzYw?=
 =?utf-8?B?ZmtxZHpMUk1zWGpkd2IvWlc0NFlYWmdhSjFoMmVJYmlCb0p5aXdzekpKaExZ?=
 =?utf-8?B?aEdSNGhZL1VTeTMyZEF4NG5oYkNLWjRQN3pCQzBVQUtaaUxsWnp4SFB1Vkl2?=
 =?utf-8?B?L3BTVXBvSDgrTHB6Y0hLTEsvRE1TclBKZjBwekF5bGFLRVR5RmFlUnNvSEts?=
 =?utf-8?B?OUlXSjRIYkNxU3BUSVhwb0hJaGlMVEtVTnc4UkxRYk1mZHVna2hnMVdwZHcy?=
 =?utf-8?B?WFhTS3dCT29MTDRmay9IZVpjUjZzVnJ3b0xONGxlbDNPKzlRamd0MlVQUmtM?=
 =?utf-8?B?M0VJWThGRXVjVUNldEdGdzJMTnZRUzZmMWhra3g1VDB3Z0I0S0tNV3RsZmtD?=
 =?utf-8?B?UjhGZUJJaUJKWklpZThCSkJQZzkwNDM1azJpMm1vemlmSk5hQ3RQQjlQa1FI?=
 =?utf-8?B?SnNYb01GV1lYMTBLOEtzWVIyMzQyRGtsa21XT2xZUC80YlU4MWxTVHZ4aVY5?=
 =?utf-8?B?aFJ2QloyN0R4MnJDdnJHc1ZTV3U4Nm5wTnZ3R1JTd0djTkVpaXhrZG1sdzZB?=
 =?utf-8?B?VFlNYk9lOWY5eVVtdW5lb1hVTDVzYmVkYkREQzFZUmNISzVTRjJGZTFORk4x?=
 =?utf-8?B?N01Pbk1PU09nQzdiWDV5QWpqY05KdVJhMlhGQ0JRdUc4RzAxN2k4RHZ5SElB?=
 =?utf-8?B?NnNJWFEwWFNOSlJUVno2N1J3a0N5MVorN1VPWXVZc3A1NGxQeDV5ejVrY1ZK?=
 =?utf-8?B?WWpycHRFcTFjcm1yZFRJbmYxZWhTdzhtQ3lacG5EdUZkZUo5c1JRMy9FYzU0?=
 =?utf-8?B?RjRjVkZqem1nRW9ES2JBcDhVaVViMHNsZGFCNnhzYVh1V0pFOTNiUmFTWkVG?=
 =?utf-8?B?UXBOTnVwWk5mVE43b2ZxMjhRbjUyektjaTM1UGlaWEdXZUowZHl0TWlvTEcx?=
 =?utf-8?B?MTQ5RnBscHB3K0FObGpiZjZiRy9nbXVhQ2tQQ29oQ2tTRDJHVmZHQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea6ada8-1398-4d5f-4cf9-08defde27488
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 11:10:19.3466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uCPdp72HehAt5EjxJMcnSSzWbjt3/rRZbfoU90PGHJgNRsS+KevZtGcLrS2ffcQLvHT7rMkmZPME+HDzLLWQVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB7056

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

