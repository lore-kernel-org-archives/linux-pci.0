Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021132.outbound.protection.outlook.com [52.101.100.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EA138239C;
	Tue, 21 Jul 2026 16:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784652885; cv=fail; b=lJnX49dhFv7r0a1b9J1GfA235xa5g3pz/Jp6uswPMECTmrCcS37/d6SQ5Lme/cmVxf0FZH84JQEQkcdvwpuXNszaFKKaCGgaNfA3brOYz+/yM4ruUYClNU95uxWIooSSOb8rt7Z4jNuA1BJs24Lgo9H4j0h0Dkbq5V+ccUljIso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784652885; c=relaxed/simple;
	bh=CVtl6QGHGHTgUxhd8Ee9uc5NPHuTrs9T/t3HWlWXORM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dvZyzn23pXVbmnPecL66X2w6VCTBMUW1OhZr6OBuBbJ3Yprxb+NWCLxk323xllsFY50ELummYRg5nmF/rz+2JDv7EpQ7sOErNoAEoBnJfoeNphZOvHkOOKY5bgy7BR120n2zK67DLU8e67/ICixsw8M7yZVBXa7D6g7bSmnsbpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ocPpBmhq; arc=fail smtp.client-ip=52.101.100.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ocPpBmhq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3vYOu+qKYdz91Lub9OVxTiYc3s09uWLSJATZZuHS29IwwmS1+8pvHHrqV3T7Oj6yHQP4Nmm0fA75z7KMjvRSWOFJuFbypDHjH/0rdjpvY3Sm0c7mVOKITzLTd7kU7h2JztlEUR+vou+M8hIx6FwC/jV++fhnBORL2nUI9VTRdctjkQWQKbNsurdrYIjkrsMIhyilFy3Z2pDkuiDBsffhiNlCF0zFN1HoENvwYXYWL85YvwU/vN5ix0+jgiynPxL1+mN7N04WdVldoWpzO9EptMmoQFkqaJ4detHdE0B3vErBEz5sPrMNAtaoAXjN/oo5lDasfftEnbo0RlEIjl7Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EH+Ks+rTkbtc+YjDCEWnOULQnHv8ONMCUfN815ETfyk=;
 b=aSXNce3dVqa0/7MIqtADvoAePNsVP8HKPAtXJdGZxagswyZLaT7wHAtcwZQ6orZ9nKLVVcHGq0Anbjk5ecpbHKj9lMimsjfT1WJSp+xCMrGZNcYRpMMUCj7aip1MEza1kSdX5Aww4SH3yzROdfibYNvDLojXGwE5abD/VhAzGQ6DH0MNB0D5sV1/7cF7ySPAlqblztcElyPJ6vCrJX5KQhU928ga+bEtn+vgDdOvaQpIEjkCTwwsMswcexnJIn0kGFvFErqbmAay0QxQ2EauXyg1yYi9L6RL3CeEGiCIzAnR2LmgH9IxBOjCBeS8ZxI2T8Nb0RF6jQ6G+9wZz/oJaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EH+Ks+rTkbtc+YjDCEWnOULQnHv8ONMCUfN815ETfyk=;
 b=ocPpBmhqlaZKodzrLDaDcUzAfQNhuU1jd3Zm0zpOkGAE7zcJgTq8nPFNH6UptUcFWNkUapq41bknAyYkO6NJ0zM7mIOt1E9aBa7nIhwVW9Z5wmPfwej96TqooAlkYDKC3FAo9CbfWBU/OCZ+sbslfVO0y8VLVCAoYcb8muyrJEk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7878.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 16:54:34 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 16:54:34 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 21 Jul 2026 17:54:27 +0100
Subject: [PATCH 03/10] drm/tyr: specify base type for registers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-typed_register-v1-3-452d72b60262@garyguo.net>
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
In-Reply-To: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784652872; l=6378;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=CVtl6QGHGHTgUxhd8Ee9uc5NPHuTrs9T/t3HWlWXORM=;
 b=BmQhSct2n/JjfcoI5g5rdOy8aqDhgeHB7HmT4ryN0SBg7rb2wUBKuHSw6XEmNLY4Avl2Vxj3f
 sse3W52DHj/B6Avb/lleTyzgDnVm212Xv5uQrdi5XuKm8htUqePwTn4
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0143.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::22) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO8P265MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 9250cad6-d9e2-483e-97cf-08dee748be24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|10070799003|1800799024|366016|56012099006|10067099003|6133799003|3023799007|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	SqYb4db7u/nCZW5APDeKoEIl1VTsECpzJCAx9COBvak/4FFbMueosYuye7Ux086DtxvN6Ezsv+HRusvmJDQmFKEEpySSPxmwg9Px0CDcu0fDGeFlDoc1LcqlUtEb8yCuQiqoYauD+HeqXDiJEYVvnyL8ihPG6jtx7B1hwGxlScznMZiNPnwpytAX+CBscdMti+46KRTULWAd0VsncTZzcZN6bb+LA6fRrNslc11nebEzI/Ko7gkP17pYuT5V4gWJT5JZTkc1w0+hMsB6t8IeXoYs1Csm9L0K55mtSl1MLEakq2PI3yZMlrZ6vCmsLyLau1eXMB3M4q/au5ebjOw7tK53Aa/DlvVXVEs527fRgMwJoD3vS+ONrKojviG5b3X779RZ/5YN4E6s4L3ntPQjkxYGXSBerdhrPVjQRNIQqhYXJMPPTiJgTYGaudVEqRqHXKObPyth6yfSBH0k3okK8uVGoyNOGKBvYH/KN1S5IrH/Waf0JwHg4SI4QWNFgMtfVz/RFqD3D+iOXITVioSRTmgXrSuZTIs+muu7ZX0K3RPK+033Nw5albBgPjbIcLr4eCdq8cXWhnIruKPujA9/dVsgrw5/jvhhDwqx3Qz0qxtn66+kBodKcrUlDQbpv4zJRiAgrHYlAJo0UuYsx7zah/RYP5S8giYE3sPBHpEWiWRat8CN+oSa6rxcMnKUDJvio3Nxltw661mBMjXmSiU9vA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(1800799024)(366016)(56012099006)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGtsbURBVWoxbXdhb1BkNnMxR0UxL3BGbUFvY3ByckFQU0NRL1pCU2RhbUdy?=
 =?utf-8?B?OXBocFN5UG1xbWh3ZERXNmhOY25hQVVCTmpncnNjM3R0NWJmRDNZWno3NHZO?=
 =?utf-8?B?ZTlWWlJ3M1hvd0tPMWJTcldicHQxZ3IzblN1bWJaK0FMRjZWUXZkNS85ckZE?=
 =?utf-8?B?Y3gzdXArOUh6bFAya1RuSFZhb1poQmZVdXhhYWRQK0s4dkxybnp0cmhzVXBk?=
 =?utf-8?B?VFRXMlFxVDh3eHpyKzRqeFBpa0NodmpXbVVVeXhjblhWU2twY3dTTmRLMnc1?=
 =?utf-8?B?SWd1L2NyL3pUT2JhRVdHRDREK051SVFvNk9ITklnK3VJbzVmSGZUVVVaTmd2?=
 =?utf-8?B?ZUVhdXRXQUhkRmh1OFVVbGVoemprSzJOUlhqelU1NmdiQWZNSzQzeS9ad0pn?=
 =?utf-8?B?dFhFSy9hek0wRHJHZklWS0FwWGhic01TbnFVK2ZwV3VTWW9yNGYvb2paT1Jv?=
 =?utf-8?B?ckk1MGxhL3JVbFFtKzdvWnlId0VGcXhJcWcwL0ZEaTJIWkQ1aUYzM0NXVnJp?=
 =?utf-8?B?U0V1Z0ZyRnRGL2w2S2drMCtwditPUE1nVSszSllBNG9ONEorUVk2bVRneFly?=
 =?utf-8?B?bk5lSzE0N2paaHJRRnc4VVNkeFRyZkQwQTAwNDFoYUR0bkVTYVpvc2tQMXp5?=
 =?utf-8?B?VEZQcVRPNEIvY3dPajRlVEZaRXNKaE9qQU9RWHVkYVNINDlqdnNhYnRpckZ3?=
 =?utf-8?B?N283QTNZZlpNeHdWd2tsUnA3TGtEdnl5eFdwbHJ5c0dOVDcyTjdLdEdtK1Nh?=
 =?utf-8?B?TTBNZTJVWTcvcGVuMFh4VWRWVitQUjYvclhNY09rNFA1d0hMK3A1cVMwdGI0?=
 =?utf-8?B?eTM0ektEQ2xNNDl1aGZHVDdPc3BHTzdaRDFYeVhEUU9BVmQwaFkrM0pjaFVK?=
 =?utf-8?B?a2VJQ0hzZGtabzcvdjJBa1Ezczk1VHhOSFE4K0JueTBKTjNCaWFwR01qcktI?=
 =?utf-8?B?UHRzRjBqajV3VGVkVFI1R2hSR0tpRWp3L0F6eFowbmxJV2hLQ1NMbVAzKy9w?=
 =?utf-8?B?Sno2aWw5dVI5ZGlzV2N4WW5IRGhxd1p5VTRsMUl5cHNVVzFLcnBWakhIRmJw?=
 =?utf-8?B?M09wWk1TbURqYW5oblIyc0cwVW9CbzY0V2xVam5ZNm4zdW5zemJETWt5QjZQ?=
 =?utf-8?B?ejVIVlBnd1MzeldtUHhzZlNVNTFhbFZIZ0R6MkdPYkpSRlFIV09KM3VqVkxl?=
 =?utf-8?B?MUxLaGJBSWp1TzdDREFKUHNzUnNYN0lKTi9iOCtYKzExWU1keFBwK3JCcCtE?=
 =?utf-8?B?SU1rWGRPdG5LZnhvb3RMT2wvdURDdVYvU240Zng2eVF4S2lnUUJvSExGdEdC?=
 =?utf-8?B?R21CMU5iWEc1dEdreHFoRXpOb1h4R2wyc2k2TEw1dHpacC9kOGVPVWRQSTBN?=
 =?utf-8?B?YlhkcHlhbDd5MXpCZmlrRFUvREdWRDBDRG8yc0pqK2pwN0NLWjgwRmhlTGh1?=
 =?utf-8?B?dmZjUzlkNDRzOGdCU212VmgyaXVXdmdJa1UvOXRNdlBYVVFFcERIWG15RHpn?=
 =?utf-8?B?WWNDVmlJUlRPUnVvNnNQK2JvUTU1MVR1WkI2QWhpRTEza3o1WFJ3dWIyT2xM?=
 =?utf-8?B?QjZRWkM2MVR3WjluMGthd29uOTdqTFdFc09DNER3MS9xMURVSkNFaTB3Tkpt?=
 =?utf-8?B?a1EwS29WSDRwNk9ES0JoZzhPNGoySW9FRjdOZy9CeGxpOWNKMnJSdDhKaFRr?=
 =?utf-8?B?Uzhsb05hTWs3cEY1S0NiTitnclFWZ2JZdkY4aWdGNTlBOFg4d3BkZDBwTHRs?=
 =?utf-8?B?Nlo3a3dIVHRFYU5oVWNDSm9Pb2xmaDMvOXRQTmd3U1NteWEvRHh5VnNaangz?=
 =?utf-8?B?c1I4Zy9nUUpBTnNING9kVTJRaE92SDlTRUpkYjZMQVNxU2E5V1NCNWRZd0d5?=
 =?utf-8?B?cVlaZFhOZU4ydzdyMUNSNlkyYlJaajBOYytmVzlvSG1WQkdHdUJTZXptVzlh?=
 =?utf-8?B?d3lCUXpTSk5LWEJtSDVvZmhVbUkyWFVaZXIxWXBGeUZiNzdiWEVUanArMnRi?=
 =?utf-8?B?UGpVT2Z3bElQK2VTR3hKT2pBREhKaXhJZlhtTjEybFlxbDJva0gzNlhqMi9D?=
 =?utf-8?B?SWxjeWM1TkhHOW1DSU9aQVExQnAxME1HaTBneThxMDh5aEtCZTZDUGZTN1VJ?=
 =?utf-8?B?OWlYdnBxVngrNVFaKzBQSEVSZytnR2ljUkZJNlgzY0hVLzRLanJMWldtcnN6?=
 =?utf-8?B?RjZDbklMdmszQ1E0UEFwemcrbk1ueng1dVJVVlN0VWVWRE1zSHlid1VzRlg2?=
 =?utf-8?B?QlNpZ1hWb1hrY3FCNlhpZzFLamd1cEc4enAvTmlQWThQaXVYMUh0RHAvV2Nq?=
 =?utf-8?B?NmsyZFFvaWFTbGdjNys2WlVIUGRZWUNTY0RXVlhBdW80dVF0Y0dEZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9250cad6-d9e2-483e-97cf-08dee748be24
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 16:54:34.7714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIpHJY1Txrh6tbn+/81yyTJ9zR2GAL6uXrKZFsQ1BSP/19AU63BEF5123LFZlHlrJ7I14RjlZC9ysXoJkT1WEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7878

All registers use the same base type, which is `<IoMem as IO>::Target`.
Thus add the base parameter to `register!` invocation.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/drm/tyr/driver.rs |  1 +
 drivers/gpu/drm/tyr/regs.rs   | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 8348c6cd3929..401a4b321eaf 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -43,6 +43,7 @@
 };
 
 pub(crate) type IoMem<'a> = kernel::io::mem::IoMem<'a, SZ_2M>;
+pub(crate) type TyrRegisters = kernel::io::Region<SZ_2M>;
 
 pub(crate) struct TyrDrmDriver;
 
diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
index 831357a8ef87..ef21d90dbbc4 100644
--- a/drivers/gpu/drm/tyr/regs.rs
+++ b/drivers/gpu/drm/tyr/regs.rs
@@ -55,7 +55,11 @@ pub(crate) mod gpu_control {
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
@@ -313,6 +317,8 @@ fn from(mode: FlushMode) -> Self {
     }
 
     register! {
+        base: TyrRegisters;
+
         /// GPU command register.
         ///
         /// Use the constructor methods to create commands:
@@ -378,6 +384,8 @@ pub(crate) fn clear_fault() -> Self {
     }
 
     register! {
+        base: TyrRegisters;
+
         /// GPU status register. Read only.
         pub(crate) GPU_STATUS(u32) @ 0x34 {
             /// GPU active, a 1-bit boolean flag.
@@ -461,6 +469,8 @@ fn from(access: AccessType) -> Self {
     }
 
     register! {
+        base: TyrRegisters;
+
         /// GPU fault status register. Read only.
         pub(crate) GPU_FAULTSTATUS(u32) @ 0x3c {
             /// Exception type.
@@ -766,6 +776,8 @@ fn from(mode: CoherencyMode) -> Self {
     }
 
     register! {
+        base: TyrRegisters;
+
         /// Coherency enable. An index of which coherency protocols should be used.
         /// This register only selects the protocol for coherency messages on the
         /// interconnect. This is not to enable or disable coherency controlled by MMU.
@@ -806,6 +818,8 @@ fn from(mode: McuControlMode) -> Self {
     }
 
     register! {
+        base: TyrRegisters;
+
         /// MCU control.
         pub(crate) MCU_CONTROL(u32) @ 0x700 {
             /// Request MCU state change.
@@ -847,6 +861,8 @@ fn from(status: McuStatus) -> Self {
     }
 
     register! {
+        base: TyrRegisters;
+
         /// MCU status. Read only.
         pub(crate) MCU_STATUS(u32) @ 0x704 {
             /// Read current state of MCU.
@@ -860,7 +876,11 @@ fn from(status: McuStatus) -> Self {
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
@@ -910,7 +930,11 @@ pub(crate) mod job_control {
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
@@ -965,6 +989,8 @@ pub(crate) mod mmu_as_control {
             register, //
         };
 
+        use crate::driver::TyrRegisters;
+
         /// Maximum number of hardware address space slots.
         /// The actual number of slots available is usually lower.
         pub(crate) const MAX_AS: usize = 16;
@@ -973,6 +999,8 @@ pub(crate) mod mmu_as_control {
         const STRIDE: usize = 0x40;
 
         register! {
+            base: TyrRegisters;
+
             /// Translation table base address. A 64-bit pointer.
             ///
             /// This field contains the address of the top level of a translation table structure.
@@ -1100,6 +1128,8 @@ fn from(val: MemoryType) -> Self {
         }
 
         register! {
+            base: TyrRegisters;
+
             /// Stage 1 memory attributes (8-bit bitfield).
             ///
             /// This is not an actual register, but a bitfield definition used by the MEMATTR
@@ -1133,6 +1163,8 @@ fn from(val: MMU_MEMATTR_STAGE1) -> Self {
         }
 
         register! {
+            base: TyrRegisters;
+
             /// Memory attributes.
             ///
             /// Each address space can configure up to 8 different memory attribute profiles.
@@ -1220,6 +1252,8 @@ fn from(cmd: MmuCommand) -> Self {
         }
 
         register! {
+            base: TyrRegisters;
+
             /// MMU command register for each address space. Write only.
             pub(crate) COMMAND(u32)[MAX_AS, stride = STRIDE] @ 0x2418 {
                 7:0     command ?=> MmuCommand;
@@ -1347,6 +1381,8 @@ fn from(access: MmuAccessType) -> Self {
         }
 
         register! {
+            base: TyrRegisters;
+
             /// Fault status register for each address space. Read only.
             pub(crate) FAULTSTATUS(u32)[MAX_AS, stride = STRIDE] @ 0x241c {
                 /// Exception type.
@@ -1572,6 +1608,8 @@ fn from(sh: PtwShareability) -> Self {
         }
 
         register! {
+            base: TyrRegisters;
+
             /// Translation configuration and control.
             pub(crate) TRANSCFG(u64)[MAX_AS, stride = STRIDE] @ 0x2430 {
                 /// Address space mode.
@@ -1627,6 +1665,8 @@ fn from(sh: PtwShareability) -> Self {
 pub(crate) mod doorbell_block {
     use kernel::register;
 
+    use crate::driver::TyrRegisters;
+
     /// Number of doorbells available.
     pub(crate) const NUM_DOORBELLS: usize = 64;
 
@@ -1637,6 +1677,8 @@ pub(crate) mod doorbell_block {
     const STRIDE: usize = 0x10000;
 
     register! {
+        base: TyrRegisters;
+
         /// Doorbell request register. Write-only.
         pub(crate) DOORBELL(u32)[NUM_DOORBELLS, stride = STRIDE] @ 0x80000 {
             /// Doorbell set. Writing 1 triggers the doorbell.

-- 
2.54.0

