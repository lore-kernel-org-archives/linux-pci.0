Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021132.outbound.protection.outlook.com [52.101.100.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4673AEB5C;
	Tue, 21 Jul 2026 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784652892; cv=fail; b=KFP/tEa6WhwgG4vFrmwmd/VFfmJ+2BdsJ9FbZKLNVYZDgNRrBSCj/iJnbOb/HLV9cHHGeLKxtBaAmGjkj5Gn8xsnkety6y8M3eRssqK+HqV4cE6Q7rowdrPQHE+C3OTRgSA+BBmMOgzntWy7UYVIety7u3skwG18MI3IsZZT++c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784652892; c=relaxed/simple;
	bh=nOV0ISgyzzax+jzHJde42WVYoL+NI8pIw7tEdedWISc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZYm8bvnans9l5f10Rqq5/gkfl4IKZ279g/9Abit8gzi+kDKgEUzKXxlR1uWHMSQy+VBTOe/C9g/sBUdZmUjxoZm6fx1dcUvcCDxbq2lbwGJMaZHDpOj57c9p2Kmu+e9iNN/f/ovuWVuU8DvGXu6EOBXGNuRuheu0zTC9BauEKzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=H1I6F0lJ; arc=fail smtp.client-ip=52.101.100.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="H1I6F0lJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJrQkfpGsecSd+7bJzUKCGrVeO7egrkbzMVjCzVczLqIiUZBQUQq10GDOOihoMRj3gFrjlndK1jetAVMnoD95WfuetN9bDEEXMXPI90zALH0nk6x4Yh6QMwN62iHoasTBM1Q0wN6f8oQFq0/xl847A0RfEde06C7fzHxmeZs2zpqfyi76q2WSBfh/W1HGFRchCxge6juXVvYe7ewmdbh1PcZgT5cU+kxvxcegoIqk6g6i087/rFbKIeUnKvjmcfxuKMkHaE3gXfHJ3SdTDNLV3I7N+PK1WXKfkHX9A3qX2o7r4Ah+leBI8xdg3UVAM+1wplfeHH3QhxW9mi8x5bFEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jcr+U5Mxse2jgojKiXRGKCtxnArv5kZ0sYs+hWuSudg=;
 b=tuUmgqS8Ko4seSXtyn0+VvBG1JIfBhi47K85d2OuTVBpmG/MdOVCThiwqZ9BRgwiCI8rk3F+i+DTDcLk5TaDG6xq613QfzZUFiW/sJ3/0X+j1tsKmywFs4H/XXKQbwdz70x1YK9BawCKSSmciSBAno6A4vQJ9Q0+4ACNXw1bXV9XVLU5bSQrO4bPcL/z0cFEejtHaybvQr+VkZ2mkuIqhGHi9m2HeIa2zC6oDmbNNJrFyqHq451zv0Xi2KgHJG4XerpT7qtLE9pg7BHqf2dcxFr8cG+ZPTV6SJFkGgtx33hDdjL04XaGnuiPOMXCzXNQtu7VBg9d5NoKjXEA4CgOng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jcr+U5Mxse2jgojKiXRGKCtxnArv5kZ0sYs+hWuSudg=;
 b=H1I6F0lJFCpliK0wdCLoF2iUjvJMkwX0WpEhHKBQVThk277ZMdBm3LDs+BT7RWa8UNW57dzAh2jiETkZGEe03jRg55Q2ydKp8BoIhqArP9BiwoEWVl6l7HT3Xz6Pbh5BazUklHLMkfWwoNfFtyzhvIrN+JQdbBwPukGm0E07Udk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7878.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 16:54:37 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 16:54:37 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 21 Jul 2026 17:54:32 +0100
Subject: [PATCH 08/10] gpu: nova-core: use projection for PFALCON and
 PFALCON2 registers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-typed_register-v1-8-452d72b60262@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784652872; l=39936;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=nOV0ISgyzzax+jzHJde42WVYoL+NI8pIw7tEdedWISc=;
 b=n9Kf9oKtZaUENh8xiYPp3EwsVEWpdKOHG+9ZtVME1/XWOGBefvMLRZLZmb//G+krgJZaVxFkt
 PXDJBw8sLs0AltioZnfKdqQxkC5c8RKPF5gapQRuGeZZU+hMTXiDK36
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
X-MS-Office365-Filtering-Correlation-Id: ab991e26-64fe-4371-5e86-08dee748bfb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|10070799003|1800799024|366016|56012099006|10067099003|3023799007|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	ZED3mL/NPiL/AcLImy1kXih0rOA7wEMcRyH3hFLbr+ahhXEzHIqserBA6pXrNOv4DuveoAGwfz4yopQ7+u9lj5vAojSsHRiZ6Wahc8JJ8ua7+dqC6Dc9Nximoq+dNdAB64Sj44k8oQdA5ruTB87zhuapmFSkd4FHxYwyKTU/oxGcbXe3TTLKkvCQDd9L8wh57pm3afsk0k74fOYWSXjPH856cX6s43LvODrkum51NOIHifCmN7hlixC14jnusPL47dnlT2nbhWIN2tPIw69jpH/GQRd05433gJzeQEiTHGwyTeKHt/rsTl5GbZNJpWYjW+KCdIGM2NqFJE+bHz5SgtLUaMuLjLC8G3ZBV6UFFcn4IVQ8tTv5PZYuj+1m0DnyP9lXQVW1QdA85NFRqjNqcAMNMu92jhdXZuU7cB0SDVr/NyKhuT+ociFPW9bYjHl57quKGg7yFquDk9yr9BJzauh3CsQEgJYqUqKx32QszxQsaulsn0NKWlUmQ2T1mMlUyjts02JFGafLF7LAjT61lmwTOlYebvQC1fBu01XGTAES+bkVbhb5OfflnQm7s3F+qTagbDyeySL2LKflay+Ed+j1pJFcyEjYmmYc6v9Wt2ND2ol+uWuofAqNflmDfbNOev/diBXIB6vOwTaGadQdeLL11Z3aUf83WUE4SG1v+6J4fVuWI238O7jfOjNRu+W86XohM7EXpYxQJFFtbaeNUQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(1800799024)(366016)(56012099006)(10067099003)(3023799007)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmRTRHQ1emk1NTlaTUNuNFJnN3Z5QnNRelMyekdDVVllWmtHWElsUE9HblRT?=
 =?utf-8?B?SVd3YUFIL25wYzgwQ2N4VExWMWUwaEV2UlpkSmZrd1kvOTBDT1JDbmttT3pn?=
 =?utf-8?B?V3BUS3FDQWZ5RW5mNlIvbEt4cTdGc25udUV0Qm9rbGZzSnJCTG9kTXZwR1Ax?=
 =?utf-8?B?VlBCNWZuZGVRcnhHRThQVlRPNDgzem9CdUxVVlVDVWdOVStCMkd5aWtmaWY3?=
 =?utf-8?B?L2h2QUN0a0phbFRsdlF3dDJ5R3ppaUpWL0VXeDYxN01kNHFTQnhrMjlXdU9N?=
 =?utf-8?B?YnJUWmtyL0RrcWFGQ2kyYlNCa052M0FlVTgybXR6eU9Qd01TdnFwTUorb0N5?=
 =?utf-8?B?R09mUm4vRFNpRERFZmVoek9SUFJoQ29Bb3BWcnhwQXhBeGhTNWVydTVqajU1?=
 =?utf-8?B?VGFER0pNN0pWcGJTUjlxUGozd2FrVzlTNTlCbnZ6Tm5XZ1M5UDJoTFdDR2Na?=
 =?utf-8?B?OGN6ako3VlkrTVVBaXNkU1dTMXdDcG54dHN5R2NaYTNmemEwcUFhUUZLMDVG?=
 =?utf-8?B?NzdyTTlRTk1xYWhaalBiTmRCRHFhTVEyWTJueWVCRkJGem1yYmMxVi8zOGdx?=
 =?utf-8?B?a1J0L1MzVEo5b1lPZlJzV280eituVjc1RG9vY1VZWDU5dzRaOEdTdFFwYmtZ?=
 =?utf-8?B?ZEU4aVNZOEZ0RkJGblo2MlJ4ZmtEUkRIbnhGS0tidmlISk9pN25ycDRicTNM?=
 =?utf-8?B?M0MrNDBvMzQzVlFSN1hFSFVDN1BHK2hPbHgyOUFCTW1VWlp2RTBGQ0NaK2xm?=
 =?utf-8?B?UFNsYmRlVUxrdHp4SnoydmF4L0pvUVJzMjJpNE4yMXk4UTR6VmVzbnVRRmh3?=
 =?utf-8?B?UmcrbzdPQXZNdWVTZEgwTGZtNjFkczA2T214REY1cThmSXpvUGJUWjNETkl4?=
 =?utf-8?B?YzMvV0IvQzFxdWFUYkRUUXMwaHdMMWZLNWE1KzA4YXRhazI2VXlldVlvc1Fr?=
 =?utf-8?B?NUwyQ01ONFdzOENvNitEWCtuZi9IMzNWMFlWOXo3UjVlWCtRNlB2dU1qUmVz?=
 =?utf-8?B?Wmw2d2VSYnpzNHhPWVluS3l6NnM5VTgxaTc3L3JrMk14MUpuRDNWUm9WUVNm?=
 =?utf-8?B?amJyYm9PcTFSN3RoQkh6eXEzQkF0S21jSDZYODVkc2JQS09McEVETmV6RFdT?=
 =?utf-8?B?T2RBU09XclhTczFrY3k5L1J6ZkUwS1F5NWNHdGNER3hUOXNUVmI5Tk5nYTFM?=
 =?utf-8?B?WEFIR3FNVGZVdytneXEwR2F5NmdxNjFhdXpFUHNFOW02UmNYclYwbTlyMFJB?=
 =?utf-8?B?RHB0ell1NzZ3bThzVDFHd2tnVHN2VnlaSUc3dUNhNkFMSWNqNHBjak1MNm1Z?=
 =?utf-8?B?UVJ5eDg4Umxwb0c3ZVk0YTlJb0NkQ0JLNXpadURjM0Vhb0N4K0VKdmRaZUJZ?=
 =?utf-8?B?VDNyWlI2akd2UHVNNy9DUEpMQ1ZOYU9KdlVuQVZHc2JEOTlla2RtWldHd3lw?=
 =?utf-8?B?Z29OZ041LzFJVGl4MGVweldaT0YyUVcxbHJkbkpFYVpFSCtVQkM5VEZFcEFN?=
 =?utf-8?B?emRoby8rRUdTQWxxU0pLdCs0azBMcU9oam1vZkxxekN6TmlQT1pNQ1ZGemZa?=
 =?utf-8?B?RDZVTFF2cTQyTHlIT0p6cGdLeWFnTUM2L1FSN2VEZG5SMW1IVWhVZTAvU2NQ?=
 =?utf-8?B?eDR3eFdyL283dkZaV3ZMZkpBUTE5S04zclJqbXBYMCtqSXR2WFgxbGdEbXJs?=
 =?utf-8?B?THdLMzB1TUt1bWJMVDUwdHErS0VzUFZ1dDFET1crWFkrVERyL3dvZ0Mxbm5C?=
 =?utf-8?B?emNNQmV6UVpZUExDZ1lyTVdqYmlES0UzVUN6S0Q4SWltaVdvRnpKMHZBSDg0?=
 =?utf-8?B?QmlKaWV2SkZOclVZZXBtdUtXQzRiQ2FPZmtrdy95cytkSCt0VGd1N0hLeDE1?=
 =?utf-8?B?alpNbFJtRjVmYWx2MEZOOS9BQ01rcWJQdE0xbEV1SGdzSFNHTXF2THVlVllD?=
 =?utf-8?B?ZTdZTys0WFkwTXBMTEVYWkpsNUlhWjZNeElNbDBBY3FuS2dsSldtUVdrNnQr?=
 =?utf-8?B?MHcvVE91cGdUMjMvWDUyMTRSSWw1NG4rSmhicDRnQTA0ZHlkZlU1NWV0TEJn?=
 =?utf-8?B?NkRkdUhlU0lCbkhDMllMaTBqVDlicDFqcnhkWTkxKytZVHpzVGxoTXVzVy9x?=
 =?utf-8?B?dE9ab0VSaU0wOG9ISTFyeFZyUVg3SklucDQxK2QyRFpuYzRreCtUTWdubDVJ?=
 =?utf-8?B?QW1LdGUwNkhPQlA3QmhUbkVKMFRkWFVpZlJySFNURmhMSDJNOVczakxMaVJj?=
 =?utf-8?B?b1JCQ1N0QTFvOXNoYzZueWF6WVpxODMvamtyeE4xWmZvekdscC9weTlWV0Fq?=
 =?utf-8?B?bnhqa2RRMyttYm5lbGVSRytvdEltYjlzb2ZvRVhLYzhFYVpNcElHUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ab991e26-64fe-4371-5e86-08dee748bfb9
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 16:54:37.4188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IgVhclryOkbaHNq6RqAczchIU9Ub+gPiiQH3uXtxHO/6mcd4xW+1hvbKzGptUWhcM/PhPNDF7v0oTbNYcAodfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7878

Add fixed size region types for these and add projection methods that
project from `Bar0` into these. Update these registers to be registers on
`PFalconRegisters` and `PFalcon2Registers` and not relative registers on
`NovaRegisters`.

The use sites are updated mechanically; calls to the projection methods are
not extracted in this commit.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/nova-core/falcon.rs                    | 158 +++++++++------------
 drivers/gpu/nova-core/falcon/fsp.rs                |  53 +++----
 drivers/gpu/nova-core/falcon/gsp.rs                |  43 +++---
 drivers/gpu/nova-core/falcon/hal/ga102.rs          |  39 ++---
 drivers/gpu/nova-core/falcon/hal/tu102.rs          |   8 +-
 drivers/gpu/nova-core/falcon/sec2.rs               |  32 +++--
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  11 +-
 drivers/gpu/nova-core/regs.rs                      |  81 ++++++-----
 8 files changed, 193 insertions(+), 232 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index 78948cc8bff3..3cd065019a66 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -14,13 +14,12 @@
     },
     io::{
         poll::read_poll_timeout,
-        register::{
-            RegisterBase,
-            WithBase, //
-        },
+        register::Array,
         Io,
+        Mmio, //
     },
     prelude::*,
+    sizes::SZ_4K,
     time::Delta,
 };
 
@@ -165,18 +164,22 @@ pub(crate) enum FalconFbifMemType with From<Bounded<u32, 1>> {
     }
 }
 
-/// Type used to represent the `PFALCON` registers address base for a given falcon engine.
-pub(crate) struct PFalconBase(());
+/// Type used to represent the `PFALCON` registers.
+#[repr(align(4))]
+#[derive(FromBytes, IntoBytes)]
+pub(crate) struct PFalconRegisters([u8; SZ_4K]);
 
-/// Type used to represent the `PFALCON2` registers address base for a given falcon engine.
-pub(crate) struct PFalcon2Base(());
+/// Type used to represent the `PFALCON2` registers.
+#[repr(align(4))]
+#[derive(FromBytes, IntoBytes)]
+pub(crate) struct PFalcon2Registers([u8; SZ_4K]);
 
 /// Trait defining the parameters of a given Falcon engine.
 ///
 /// Each engine provides one base for `PFALCON` and `PFALCON2` registers.
-pub(crate) trait FalconEngine:
-    Send + Sync + RegisterBase<PFalconBase> + RegisterBase<PFalcon2Base> + Sized
-{
+pub(crate) trait FalconEngine: Send + Sync + Sized {
+    fn pfalcon(io: Bar0<'_>) -> Mmio<'_, PFalconRegisters>;
+    fn pfalcon2(io: Bar0<'_>) -> Mmio<'_, PFalcon2Registers>;
 }
 
 /// Represents a portion of the firmware to be loaded into a particular memory (e.g. IMEM or DMEM)
@@ -376,14 +379,11 @@ pub(crate) fn new(
 
     /// Resets DMA-related registers.
     pub(crate) fn dma_reset(&self) {
-        self.bar.update(regs::NV_PFALCON_FBIF_CTL::of::<E>(), |v| {
+        E::pfalcon(self.bar).update(regs::NV_PFALCON_FBIF_CTL, |v| {
             v.with_allow_phys_no_ctx(true)
         });
 
-        self.bar.write(
-            WithBase::of::<E>(),
-            regs::NV_PFALCON_FALCON_DMACTL::zeroed(),
-        );
+        E::pfalcon(self.bar).write_reg(regs::NV_PFALCON_FALCON_DMACTL::zeroed());
     }
 
     /// Reset the controller, select the falcon core, and wait for memory scrubbing to complete.
@@ -392,10 +392,9 @@ pub(crate) fn reset(&self) -> Result {
         self.hal.select_core(self)?;
         self.hal.reset_wait_mem_scrubbing(self)?;
 
-        self.bar.write(
-            WithBase::of::<E>(),
-            regs::NV_PFALCON_FALCON_RM::from(self.bar.read(regs::NV_PMC_BOOT_0).into_raw()),
-        );
+        E::pfalcon(self.bar).write_reg(regs::NV_PFALCON_FALCON_RM::from(
+            self.bar.read(regs::NV_PMC_BOOT_0).into_raw(),
+        ));
 
         Ok(())
     }
@@ -413,8 +412,8 @@ fn pio_wr_imem_slice(&self, load_offsets: FalconPioImemLoadTarget<'_>) -> Result
             return Err(EINVAL);
         }
 
-        self.bar.write(
-            WithBase::of::<E>().at(Self::PIO_PORT),
+        E::pfalcon(self.bar).write(
+            Array::at(Self::PIO_PORT),
             regs::NV_PFALCON_FALCON_IMEMC::zeroed()
                 .with_secure(load_offsets.secure)
                 .with_aincw(true)
@@ -424,14 +423,14 @@ fn pio_wr_imem_slice(&self, load_offsets: FalconPioImemLoadTarget<'_>) -> Result
         for (n, block) in load_offsets.data.chunks(MEM_BLOCK_ALIGNMENT).enumerate() {
             let n = u16::try_from(n)?;
             let tag: u16 = load_offsets.start_tag.checked_add(n).ok_or(ERANGE)?;
-            self.bar.write(
-                WithBase::of::<E>().at(Self::PIO_PORT),
+            E::pfalcon(self.bar).write(
+                Array::at(Self::PIO_PORT),
                 regs::NV_PFALCON_FALCON_IMEMT::zeroed().with_tag(tag),
             );
             for word in block.chunks_exact(4) {
                 let w = [word[0], word[1], word[2], word[3]];
-                self.bar.write(
-                    WithBase::of::<E>().at(Self::PIO_PORT),
+                E::pfalcon(self.bar).write(
+                    Array::at(Self::PIO_PORT),
                     regs::NV_PFALCON_FALCON_IMEMD::zeroed().with_data(u32::from_le_bytes(w)),
                 );
             }
@@ -450,8 +449,8 @@ fn pio_wr_dmem_slice(&self, load_offsets: FalconPioDmemLoadTarget<'_>) -> Result
             return Err(EINVAL);
         }
 
-        self.bar.write(
-            WithBase::of::<E>().at(Self::PIO_PORT),
+        E::pfalcon(self.bar).write(
+            Array::at(Self::PIO_PORT),
             regs::NV_PFALCON_FALCON_DMEMC::zeroed()
                 .with_aincw(true)
                 .with_offs(load_offsets.dst_start),
@@ -459,8 +458,8 @@ fn pio_wr_dmem_slice(&self, load_offsets: FalconPioDmemLoadTarget<'_>) -> Result
 
         for word in load_offsets.data.chunks_exact(4) {
             let w = [word[0], word[1], word[2], word[3]];
-            self.bar.write(
-                WithBase::of::<E>().at(Self::PIO_PORT),
+            E::pfalcon(self.bar).write(
+                Array::at(Self::PIO_PORT),
                 regs::NV_PFALCON_FALCON_DMEMD::zeroed().with_data(u32::from_le_bytes(w)),
             );
         }
@@ -473,14 +472,11 @@ pub(crate) fn pio_load<F: FalconFirmware<Target = E> + FalconPioLoadable>(
         &self,
         fw: &F,
     ) -> Result {
-        self.bar.update(regs::NV_PFALCON_FBIF_CTL::of::<E>(), |v| {
+        E::pfalcon(self.bar).update(regs::NV_PFALCON_FBIF_CTL, |v| {
             v.with_allow_phys_no_ctx(true)
         });
 
-        self.bar.write(
-            WithBase::of::<E>(),
-            regs::NV_PFALCON_FALCON_DMACTL::zeroed(),
-        );
+        E::pfalcon(self.bar).write_reg(regs::NV_PFALCON_FALCON_DMACTL::zeroed());
 
         if let Some(imem_ns) = fw.imem_ns_load_params() {
             self.pio_wr_imem_slice(imem_ns)?;
@@ -492,10 +488,8 @@ pub(crate) fn pio_load<F: FalconFirmware<Target = E> + FalconPioLoadable>(
 
         self.hal.program_brom(self, &fw.brom_params());
 
-        self.bar.write(
-            WithBase::of::<E>(),
-            regs::NV_PFALCON_FALCON_BOOTVEC::zeroed().with_value(fw.boot_addr()),
-        );
+        E::pfalcon(self.bar)
+            .write_reg(regs::NV_PFALCON_FALCON_BOOTVEC::zeroed().with_value(fw.boot_addr()));
 
         Ok(())
     }
@@ -563,16 +557,12 @@ fn dma_wr(
 
         // Set up the base source DMA address.
 
-        self.bar.write(
-            WithBase::of::<E>(),
-            regs::NV_PFALCON_FALCON_DMATRFBASE::zeroed().with_base(
-                // CAST: `as u32` is used on purpose since we do want to strip the upper bits,
-                // which will be written to `NV_PFALCON_FALCON_DMATRFBASE1`.
-                (dma_start >> 8) as u32,
-            ),
-        );
-        self.bar.write(
-            WithBase::of::<E>(),
+        E::pfalcon(self.bar).write_reg(regs::NV_PFALCON_FALCON_DMATRFBASE::zeroed().with_base(
+            // CAST: `as u32` is used on purpose since we do want to strip the upper bits,
+            // which will be written to `NV_PFALCON_FALCON_DMATRFBASE1`.
+            (dma_start >> 8) as u32,
+        ));
+        E::pfalcon(self.bar).write_reg(
             regs::NV_PFALCON_FALCON_DMATRFBASE1::zeroed().try_with_base(dma_start >> 40)?,
         );
 
@@ -582,23 +572,21 @@ fn dma_wr(
 
         for pos in (0..num_transfers).map(|i| i * DMA_LEN) {
             // Perform a transfer of size `DMA_LEN`.
-            self.bar.write(
-                WithBase::of::<E>(),
+            E::pfalcon(self.bar).write_reg(
                 regs::NV_PFALCON_FALCON_DMATRFMOFFS::zeroed()
                     .try_with_offs(load_offsets.dst_start + pos)?,
             );
-            self.bar.write(
-                WithBase::of::<E>(),
+            E::pfalcon(self.bar).write_reg(
                 regs::NV_PFALCON_FALCON_DMATRFFBOFFS::zeroed().with_offs(src_start + pos),
             );
 
-            self.bar.write(WithBase::of::<E>(), cmd);
+            E::pfalcon(self.bar).write_reg(cmd);
 
             // Wait for the transfer to complete.
             // TIMEOUT: arbitrarily large value, no DMA transfer to the falcon's small memories
             // should ever take that long.
             read_poll_timeout(
-                || Ok(self.bar.read(regs::NV_PFALCON_FALCON_DMATRFCMD::of::<E>())),
+                || Ok(E::pfalcon(self.bar).read(regs::NV_PFALCON_FALCON_DMATRFCMD)),
                 |r| r.idle(),
                 Delta::ZERO,
                 Delta::from_secs(2),
@@ -630,11 +618,10 @@ fn dma_load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(&self, fw: &F) ->
         };
 
         self.dma_reset();
-        self.bar
-            .update(regs::NV_PFALCON_FBIF_TRANSCFG::of::<E>().at(0), |v| {
-                v.with_target(FalconFbifTarget::CoherentSysmem)
-                    .with_mem_type(FalconFbifMemType::Physical)
-            });
+        E::pfalcon(self.bar).update(regs::NV_PFALCON_FBIF_TRANSCFG::at(0), |v| {
+            v.with_target(FalconFbifTarget::CoherentSysmem)
+                .with_mem_type(FalconFbifMemType::Physical)
+        });
 
         self.dma_wr(&dma_obj, FalconMem::ImemSecure, fw.imem_sec_load_params())?;
         self.dma_wr(&dma_obj, FalconMem::Dmem, fw.dmem_load_params())?;
@@ -642,10 +629,8 @@ fn dma_load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(&self, fw: &F) ->
         self.hal.program_brom(self, &fw.brom_params());
 
         // Set `BootVec` to start of non-secure code.
-        self.bar.write(
-            WithBase::of::<E>(),
-            regs::NV_PFALCON_FALCON_BOOTVEC::zeroed().with_value(fw.boot_addr()),
-        );
+        E::pfalcon(self.bar)
+            .write_reg(regs::NV_PFALCON_FALCON_BOOTVEC::zeroed().with_value(fw.boot_addr()));
 
         Ok(())
     }
@@ -654,7 +639,7 @@ fn dma_load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(&self, fw: &F) ->
     pub(crate) fn wait_till_halted(&self) -> Result<()> {
         // TIMEOUT: arbitrarily large value, firmwares should complete in less than 2 seconds.
         read_poll_timeout(
-            || Ok(self.bar.read(regs::NV_PFALCON_FALCON_CPUCTL::of::<E>())),
+            || Ok(E::pfalcon(self.bar).read(regs::NV_PFALCON_FALCON_CPUCTL)),
             |r| r.halted(),
             Delta::ZERO,
             Delta::from_secs(2),
@@ -665,19 +650,14 @@ pub(crate) fn wait_till_halted(&self) -> Result<()> {
 
     /// Start the falcon CPU.
     pub(crate) fn start(&self) -> Result<()> {
-        match self
-            .bar
-            .read(regs::NV_PFALCON_FALCON_CPUCTL::of::<E>())
+        match E::pfalcon(self.bar)
+            .read(regs::NV_PFALCON_FALCON_CPUCTL)
             .alias_en()
         {
-            true => self.bar.write(
-                WithBase::of::<E>(),
-                regs::NV_PFALCON_FALCON_CPUCTL_ALIAS::zeroed().with_startcpu(true),
-            ),
-            false => self.bar.write(
-                WithBase::of::<E>(),
-                regs::NV_PFALCON_FALCON_CPUCTL::zeroed().with_startcpu(true),
-            ),
+            true => E::pfalcon(self.bar)
+                .write_reg(regs::NV_PFALCON_FALCON_CPUCTL_ALIAS::zeroed().with_startcpu(true)),
+            false => E::pfalcon(self.bar)
+                .write_reg(regs::NV_PFALCON_FALCON_CPUCTL::zeroed().with_startcpu(true)),
         }
 
         Ok(())
@@ -686,31 +666,27 @@ pub(crate) fn start(&self) -> Result<()> {
     /// Writes values to the mailbox registers if provided.
     pub(crate) fn write_mailboxes(&self, mbox0: Option<u32>, mbox1: Option<u32>) {
         if let Some(mbox0) = mbox0 {
-            self.bar.write(
-                WithBase::of::<E>(),
-                regs::NV_PFALCON_FALCON_MAILBOX0::zeroed().with_value(mbox0),
-            );
+            E::pfalcon(self.bar)
+                .write_reg(regs::NV_PFALCON_FALCON_MAILBOX0::zeroed().with_value(mbox0));
         }
 
         if let Some(mbox1) = mbox1 {
-            self.bar.write(
-                WithBase::of::<E>(),
-                regs::NV_PFALCON_FALCON_MAILBOX1::zeroed().with_value(mbox1),
-            );
+            E::pfalcon(self.bar)
+                .write_reg(regs::NV_PFALCON_FALCON_MAILBOX1::zeroed().with_value(mbox1));
         }
     }
 
     /// Reads the value from `mbox0` register.
     pub(crate) fn read_mailbox0(&self) -> u32 {
-        self.bar
-            .read(regs::NV_PFALCON_FALCON_MAILBOX0::of::<E>())
+        E::pfalcon(self.bar)
+            .read(regs::NV_PFALCON_FALCON_MAILBOX0)
             .value()
     }
 
     /// Reads the value from `mbox1` register.
     pub(crate) fn read_mailbox1(&self) -> u32 {
-        self.bar
-            .read(regs::NV_PFALCON_FALCON_MAILBOX1::of::<E>())
+        E::pfalcon(self.bar)
+            .read(regs::NV_PFALCON_FALCON_MAILBOX1)
             .value()
     }
 
@@ -765,9 +741,7 @@ pub(crate) fn load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(&self, fw:
 
     /// Write the application version to the OS register.
     pub(crate) fn write_os_version(&self, app_version: u32) {
-        self.bar.write(
-            WithBase::of::<E>(),
-            regs::NV_PFALCON_FALCON_OS::zeroed().with_value(app_version),
-        );
+        E::pfalcon(self.bar)
+            .write_reg(regs::NV_PFALCON_FALCON_OS::zeroed().with_value(app_version));
     }
 }
diff --git a/drivers/gpu/nova-core/falcon/fsp.rs b/drivers/gpu/nova-core/falcon/fsp.rs
index 53b1079843ae..cf22992e6387 100644
--- a/drivers/gpu/nova-core/falcon/fsp.rs
+++ b/drivers/gpu/nova-core/falcon/fsp.rs
@@ -9,23 +9,21 @@
 use kernel::{
     io::{
         poll::read_poll_timeout,
-        register::{
-            Array,
-            RegisterBase,
-            WithBase, //
-        },
-        Io, //
+        register::Array,
+        Io,
+        Mmio,
+        Region, //
     },
     prelude::*,
+    sizes::SZ_4K,
     time::Delta,
 };
 
 use crate::{
+    driver::Bar0,
     falcon::{
         Falcon,
-        FalconEngine,
-        PFalcon2Base,
-        PFalconBase, //
+        FalconEngine, //
     },
     num,
     regs, //
@@ -37,16 +35,18 @@
 /// Type specifying the `Fsp` falcon engine. Cannot be instantiated.
 pub(crate) struct Fsp(());
 
-impl RegisterBase<PFalconBase> for Fsp {
-    const BASE: usize = 0x8f2000;
-}
+impl FalconEngine for Fsp {
+    #[inline]
+    fn pfalcon(io: Bar0<'_>) -> Mmio<'_, super::PFalconRegisters> {
+        Region::subregion::<0x8f2000, SZ_4K, _>(io).cast()
+    }
 
-impl RegisterBase<PFalcon2Base> for Fsp {
-    const BASE: usize = 0x8f3000;
+    #[inline]
+    fn pfalcon2(io: Bar0<'_>) -> Mmio<'_, super::PFalcon2Registers> {
+        Region::subregion::<0x8f3000, SZ_4K, _>(io).cast()
+    }
 }
 
-impl FalconEngine for Fsp {}
-
 impl<'a> Falcon<'a, Fsp> {
     /// Writes `data` to FSP external memory at offset `0`.
     ///
@@ -58,19 +58,14 @@ fn write_emem(&mut self, data: &[u8]) -> Result {
         }
 
         // Begin a write burst at offset `0`, auto-incrementing on each write.
-        self.bar.write(
-            WithBase::of::<Fsp>(),
-            regs::NV_PFALCON_FALCON_EMEMC::zeroed().with_aincw(true),
-        );
+        Fsp::pfalcon(self.bar).write_reg(regs::NV_PFALCON_FALCON_EMEMC::zeroed().with_aincw(true));
 
         for chunk in data.chunks_exact(4) {
             let value = u32::from_le_bytes([chunk[0], chunk[1], chunk[2], chunk[3]]);
 
             // Write the next 32-bit `value`; hardware advances the offset.
-            self.bar.write(
-                WithBase::of::<Fsp>(),
-                regs::NV_PFALCON_FALCON_EMEMD::zeroed().with_data(value),
-            );
+            Fsp::pfalcon(self.bar)
+                .write_reg(regs::NV_PFALCON_FALCON_EMEMD::zeroed().with_data(value));
         }
 
         Ok(())
@@ -86,16 +81,12 @@ fn read_emem(&mut self, data: &mut [u8]) -> Result {
         }
 
         // Begin a read burst at offset `0`, auto-incrementing on each read.
-        self.bar.write(
-            WithBase::of::<Fsp>(),
-            regs::NV_PFALCON_FALCON_EMEMC::zeroed().with_aincr(true),
-        );
+        Fsp::pfalcon(self.bar).write_reg(regs::NV_PFALCON_FALCON_EMEMC::zeroed().with_aincr(true));
 
         for chunk in data.chunks_exact_mut(4) {
             // Read the next 32-bit word; hardware advances the offset.
-            let value = self
-                .bar
-                .read(regs::NV_PFALCON_FALCON_EMEMD::of::<Fsp>())
+            let value = Fsp::pfalcon(self.bar)
+                .read(regs::NV_PFALCON_FALCON_EMEMD)
                 .data();
             chunk.copy_from_slice(&value.to_le_bytes());
         }
diff --git a/drivers/gpu/nova-core/falcon/gsp.rs b/drivers/gpu/nova-core/falcon/gsp.rs
index ae32f401aeb0..7308c596ad7b 100644
--- a/drivers/gpu/nova-core/falcon/gsp.rs
+++ b/drivers/gpu/nova-core/falcon/gsp.rs
@@ -3,22 +3,20 @@
 use kernel::{
     io::{
         poll::read_poll_timeout,
-        register::{
-            RegisterBase,
-            WithBase, //
-        },
         Io,
+        Mmio,
+        Region, //
     },
     prelude::*,
+    sizes::SZ_4K,
     time::Delta, //
 };
 
 use crate::{
+    driver::Bar0,
     falcon::{
         Falcon,
-        FalconEngine,
-        PFalcon2Base,
-        PFalconBase, //
+        FalconEngine, //
     },
     regs,
 };
@@ -26,24 +24,24 @@
 /// Type specifying the `Gsp` falcon engine. Cannot be instantiated.
 pub(crate) struct Gsp(());
 
-impl RegisterBase<PFalconBase> for Gsp {
-    const BASE: usize = 0x00110000;
-}
+impl FalconEngine for Gsp {
+    #[inline]
+    fn pfalcon<'a>(io: Bar0<'a>) -> Mmio<'a, super::PFalconRegisters> {
+        Region::subregion::<0x00110000, SZ_4K, _>(io).cast()
+    }
 
-impl RegisterBase<PFalcon2Base> for Gsp {
-    const BASE: usize = 0x00111000;
+    #[inline]
+    fn pfalcon2<'a>(io: Bar0<'a>) -> Mmio<'a, super::PFalcon2Registers> {
+        Region::subregion::<0x00111000, SZ_4K, _>(io).cast()
+    }
 }
 
-impl FalconEngine for Gsp {}
-
 impl<'a> Falcon<'a, Gsp> {
     /// Clears the SWGEN0 bit in the Falcon's IRQ status clear register to
     /// allow GSP to signal CPU for processing new messages in message queue.
     pub(crate) fn clear_swgen0_intr(&self) {
-        self.bar.write(
-            WithBase::of::<Gsp>(),
-            regs::NV_PFALCON_FALCON_IRQSCLR::zeroed().with_swgen0(true),
-        );
+        Gsp::pfalcon(self.bar)
+            .write_reg(regs::NV_PFALCON_FALCON_IRQSCLR::zeroed().with_swgen0(true));
     }
 
     /// Checks if GSP reload/resume has completed during the boot process.
@@ -59,8 +57,8 @@ pub(crate) fn check_reload_completed(&self, timeout: Delta) -> Result<bool> {
 
     /// Returns whether the RISC-V branch privilege lockdown bit is set.
     pub(crate) fn riscv_branch_privilege_lockdown(&self) -> bool {
-        self.bar
-            .read(regs::NV_PFALCON_FALCON_HWCFG2::of::<Gsp>())
+        Gsp::pfalcon(self.bar)
+            .read(regs::NV_PFALCON_FALCON_HWCFG2)
             .riscv_br_priv_lockdown()
     }
 
@@ -71,9 +69,8 @@ pub(crate) fn priv_target_mask_released(&self) -> bool {
         const LOCKED_PATTERN: u32 = 0xbadf_4100;
         const LOCKED_MASK: u32 = 0xffff_ff00;
 
-        let hwcfg2 = self
-            .bar
-            .read(regs::NV_PFALCON_FALCON_HWCFG2::of::<Gsp>())
+        let hwcfg2 = Gsp::pfalcon(self.bar)
+            .read(regs::NV_PFALCON_FALCON_HWCFG2)
             .into_raw();
 
         hwcfg2 != 0 && (hwcfg2 & LOCKED_MASK) != LOCKED_PATTERN
diff --git a/drivers/gpu/nova-core/falcon/hal/ga102.rs b/drivers/gpu/nova-core/falcon/hal/ga102.rs
index fe821ded5fa1..c0a23a84aa69 100644
--- a/drivers/gpu/nova-core/falcon/hal/ga102.rs
+++ b/drivers/gpu/nova-core/falcon/hal/ga102.rs
@@ -6,10 +6,7 @@
     device,
     io::{
         poll::read_poll_timeout,
-        register::{
-            Array,
-            WithBase, //
-        },
+        register::Array,
         Io, //
     },
     prelude::*,
@@ -32,16 +29,15 @@
 use super::FalconHal;
 
 fn select_core_ga102<E: FalconEngine>(bar: Bar0<'_>) -> Result {
-    let bcr_ctrl = bar.read(regs::NV_PRISCV_RISCV_BCR_CTRL::of::<E>());
+    let bcr_ctrl = E::pfalcon2(bar).read(regs::NV_PRISCV_RISCV_BCR_CTRL);
     if bcr_ctrl.core_select() != PeregrineCoreSelect::Falcon {
-        bar.write(
-            WithBase::of::<E>(),
+        E::pfalcon2(bar).write_reg(
             regs::NV_PRISCV_RISCV_BCR_CTRL::zeroed().with_core_select(PeregrineCoreSelect::Falcon),
         );
 
         // TIMEOUT: falcon core should take less than 10ms to report being enabled.
         read_poll_timeout(
-            || Ok(bar.read(regs::NV_PRISCV_RISCV_BCR_CTRL::of::<E>())),
+            || Ok(E::pfalcon2(bar).read(regs::NV_PRISCV_RISCV_BCR_CTRL)),
             |r| r.valid(),
             Delta::ZERO,
             Delta::from_millis(10),
@@ -87,23 +83,19 @@ fn signature_reg_fuse_version_ga102(
 }
 
 fn program_brom_ga102<E: FalconEngine>(bar: Bar0<'_>, params: &FalconBromParams) {
-    bar.write(
-        WithBase::of::<E>().at(0),
+    E::pfalcon2(bar).write(
+        Array::at(0),
         regs::NV_PFALCON2_FALCON_BROM_PARAADDR::zeroed().with_value(params.pkc_data_offset),
     );
-    bar.write(
-        WithBase::of::<E>(),
+    E::pfalcon2(bar).write_reg(
         regs::NV_PFALCON2_FALCON_BROM_ENGIDMASK::zeroed()
             .with_value(u32::from(params.engine_id_mask)),
     );
-    bar.write(
-        WithBase::of::<E>(),
+    E::pfalcon2(bar).write_reg(
         regs::NV_PFALCON2_FALCON_BROM_CURR_UCODE_ID::zeroed().with_ucode_id(params.ucode_id),
     );
-    bar.write(
-        WithBase::of::<E>(),
-        regs::NV_PFALCON2_FALCON_MOD_SEL::zeroed().with_algo(FalconModSelAlgo::Rsa3k),
-    );
+    E::pfalcon2(bar)
+        .write_reg(regs::NV_PFALCON2_FALCON_MOD_SEL::zeroed().with_algo(FalconModSelAlgo::Rsa3k));
 }
 
 pub(super) struct Ga102<E: FalconEngine>(PhantomData<E>);
@@ -133,16 +125,15 @@ fn program_brom(&self, falcon: &Falcon<'_, E>, params: &FalconBromParams) {
     }
 
     fn is_riscv_active(&self, falcon: &Falcon<'_, E>) -> bool {
-        falcon
-            .bar
-            .read(regs::NV_PRISCV_RISCV_CPUCTL::of::<E>())
+        E::pfalcon2(falcon.bar)
+            .read(regs::NV_PRISCV_RISCV_CPUCTL)
             .active_stat()
     }
 
     fn reset_wait_mem_scrubbing(&self, falcon: &Falcon<'_, E>) -> Result {
         // TIMEOUT: memory scrubbing should complete in less than 20ms.
         read_poll_timeout(
-            || Ok(falcon.bar.read(regs::NV_PFALCON_FALCON_HWCFG2::of::<E>())),
+            || Ok(E::pfalcon(falcon.bar).read(regs::NV_PFALCON_FALCON_HWCFG2)),
             |r| r.mem_scrubbing_done(),
             Delta::ZERO,
             Delta::from_millis(20),
@@ -153,12 +144,12 @@ fn reset_wait_mem_scrubbing(&self, falcon: &Falcon<'_, E>) -> Result {
     fn reset_eng(&self, falcon: &Falcon<'_, E>) -> Result {
         let bar = falcon.bar;
 
-        let _ = bar.read(regs::NV_PFALCON_FALCON_HWCFG2::of::<E>());
+        let _ = E::pfalcon(bar).read(regs::NV_PFALCON_FALCON_HWCFG2);
 
         // According to OpenRM's `kflcnPreResetWait_GA102` documentation, HW sometimes does not set
         // RESET_READY so a non-failing timeout is used.
         let _ = read_poll_timeout(
-            || Ok(bar.read(regs::NV_PFALCON_FALCON_HWCFG2::of::<E>())),
+            || Ok(E::pfalcon(bar).read(regs::NV_PFALCON_FALCON_HWCFG2)),
             |r| r.reset_ready(),
             Delta::ZERO,
             Delta::from_micros(150),
diff --git a/drivers/gpu/nova-core/falcon/hal/tu102.rs b/drivers/gpu/nova-core/falcon/hal/tu102.rs
index 34bf9f3f44c7..23ba22d6a7cf 100644
--- a/drivers/gpu/nova-core/falcon/hal/tu102.rs
+++ b/drivers/gpu/nova-core/falcon/hal/tu102.rs
@@ -5,7 +5,6 @@
 use kernel::{
     io::{
         poll::read_poll_timeout,
-        register::WithBase,
         Io, //
     },
     prelude::*,
@@ -49,16 +48,15 @@ fn signature_reg_fuse_version(
     fn program_brom(&self, _falcon: &Falcon<'_, E>, _params: &FalconBromParams) {}
 
     fn is_riscv_active(&self, falcon: &Falcon<'_, E>) -> bool {
-        falcon
-            .bar
-            .read(regs::NV_PRISCV_RISCV_CORE_SWITCH_RISCV_STATUS::of::<E>())
+        E::pfalcon2(falcon.bar)
+            .read(regs::NV_PRISCV_RISCV_CORE_SWITCH_RISCV_STATUS)
             .active_stat()
     }
 
     fn reset_wait_mem_scrubbing(&self, falcon: &Falcon<'_, E>) -> Result {
         // TIMEOUT: memory scrubbing should complete in less than 10ms.
         read_poll_timeout(
-            || Ok(falcon.bar.read(regs::NV_PFALCON_FALCON_DMACTL::of::<E>())),
+            || Ok(E::pfalcon(falcon.bar).read(regs::NV_PFALCON_FALCON_DMACTL)),
             |r| r.mem_scrubbing_done(),
             Delta::ZERO,
             Delta::from_millis(10),
diff --git a/drivers/gpu/nova-core/falcon/sec2.rs b/drivers/gpu/nova-core/falcon/sec2.rs
index 91ec7d49c1f5..5acec63e6394 100644
--- a/drivers/gpu/nova-core/falcon/sec2.rs
+++ b/drivers/gpu/nova-core/falcon/sec2.rs
@@ -1,22 +1,30 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use kernel::io::register::RegisterBase;
+use kernel::{
+    io::{
+        Io,
+        Mmio,
+        Region, //
+    },
+    sizes::SZ_4K,
+};
 
-use crate::falcon::{
-    FalconEngine,
-    PFalcon2Base,
-    PFalconBase, //
+use crate::{
+    driver::Bar0,
+    falcon::FalconEngine, //
 };
 
 /// Type specifying the `Sec2` falcon engine. Cannot be instantiated.
 pub(crate) struct Sec2(());
 
-impl RegisterBase<PFalconBase> for Sec2 {
-    const BASE: usize = 0x00840000;
-}
+impl FalconEngine for Sec2 {
+    #[inline]
+    fn pfalcon(io: Bar0<'_>) -> Mmio<'_, super::PFalconRegisters> {
+        Region::subregion::<0x00840000, SZ_4K, _>(io).cast()
+    }
 
-impl RegisterBase<PFalcon2Base> for Sec2 {
-    const BASE: usize = 0x00841000;
+    #[inline]
+    fn pfalcon2(io: Bar0<'_>) -> Mmio<'_, super::PFalcon2Registers> {
+        Region::subregion::<0x00841000, SZ_4K, _>(io).cast()
+    }
 }
-
-impl FalconEngine for Sec2 {}
diff --git a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
index d9fafd2eea5b..95fec6dd3cfd 100644
--- a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
@@ -12,7 +12,10 @@
         Device, //
     },
     dma::Coherent,
-    io::{register::WithBase, Io},
+    io::{
+        register::Array,
+        Io, //
+    },
     prelude::*,
     ptr::{
         Alignable,
@@ -33,6 +36,7 @@
         Falcon,
         FalconBromParams,
         FalconDmaLoadable,
+        FalconEngine,
         FalconFbifMemType,
         FalconFbifTarget,
         FalconFirmware,
@@ -287,9 +291,8 @@ pub(crate) fn run(
             .inspect_err(|e| dev_err!(dev, "Failed to load FWSEC firmware: {:?}\n", e))?;
 
         // Configure DMA index for the bootloader to fetch the FWSEC firmware from system memory.
-        bar.update(
-            regs::NV_PFALCON_FBIF_TRANSCFG::of::<Gsp>()
-                .try_at(usize::from_safe_cast(self.dmem_desc.ctx_dma))
+        Gsp::pfalcon(bar).update(
+            regs::NV_PFALCON_FBIF_TRANSCFG::try_at(usize::from_safe_cast(self.dmem_desc.ctx_dma))
                 .ok_or(EINVAL)?,
             |v| {
                 v.with_target(FalconFbifTarget::CoherentSysmem)
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index f2aadeb429b8..7f7cb84b21e8 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -4,7 +4,6 @@
 use kernel::{
     io::{
         register,
-        register::WithBase,
         Io, //
     },
     prelude::*,
@@ -24,8 +23,8 @@
         FalconMem,
         FalconModSelAlgo,
         FalconSecurityModel,
-        PFalcon2Base,
-        PFalconBase,
+        PFalcon2Registers,
+        PFalconRegisters,
         PeregrineCoreSelect, //
     },
     gpu::{
@@ -339,32 +338,32 @@ pub(crate) fn usable_fb_size(self) -> u64 {
 // PFALCON
 
 register! {
-    base: NovaRegisters;
+    base: PFalconRegisters;
 
-    pub(crate) NV_PFALCON_FALCON_IRQSCLR(u32) @ PFalconBase + 0x00000004 {
+    pub(crate) NV_PFALCON_FALCON_IRQSCLR(u32) @ 0x00000004 {
         6:6     swgen0 => bool;
         4:4     halt => bool;
     }
 
-    pub(crate) NV_PFALCON_FALCON_MAILBOX0(u32) @ PFalconBase + 0x00000040 {
+    pub(crate) NV_PFALCON_FALCON_MAILBOX0(u32) @ 0x00000040 {
         31:0    value => u32;
     }
 
-    pub(crate) NV_PFALCON_FALCON_MAILBOX1(u32) @ PFalconBase + 0x00000044 {
+    pub(crate) NV_PFALCON_FALCON_MAILBOX1(u32) @ 0x00000044 {
         31:0    value => u32;
     }
 
     /// Used to store version information about the firmware running
     /// on the Falcon processor.
-    pub(crate) NV_PFALCON_FALCON_OS(u32) @ PFalconBase + 0x00000080 {
+    pub(crate) NV_PFALCON_FALCON_OS(u32) @ 0x00000080 {
         31:0    value => u32;
     }
 
-    pub(crate) NV_PFALCON_FALCON_RM(u32) @ PFalconBase + 0x00000084 {
+    pub(crate) NV_PFALCON_FALCON_RM(u32) @ 0x00000084 {
         31:0    value => u32;
     }
 
-    pub(crate) NV_PFALCON_FALCON_HWCFG2(u32) @ PFalconBase + 0x000000f4 {
+    pub(crate) NV_PFALCON_FALCON_HWCFG2(u32) @ 0x000000f4 {
         /// Signal indicating that reset is completed (GA102+).
         31:31   reset_ready => bool;
         /// RISC-V branch privilege lockdown bit.
@@ -374,17 +373,17 @@ pub(crate) fn usable_fb_size(self) -> u64 {
         10:10   riscv => bool;
     }
 
-    pub(crate) NV_PFALCON_FALCON_CPUCTL(u32) @ PFalconBase + 0x00000100 {
+    pub(crate) NV_PFALCON_FALCON_CPUCTL(u32) @ 0x00000100 {
         6:6     alias_en => bool;
         4:4     halted => bool;
         1:1     startcpu => bool;
     }
 
-    pub(crate) NV_PFALCON_FALCON_BOOTVEC(u32) @ PFalconBase + 0x00000104 {
+    pub(crate) NV_PFALCON_FALCON_BOOTVEC(u32) @ 0x00000104 {
         31:0    value => u32;
     }
 
-    pub(crate) NV_PFALCON_FALCON_DMACTL(u32) @ PFalconBase + 0x0000010c {
+    pub(crate) NV_PFALCON_FALCON_DMACTL(u32) @ 0x0000010c {
         7:7     secure_stat => bool;
         6:3     dmaq_num;
         2:2     imem_scrubbing => bool;
@@ -392,15 +391,15 @@ pub(crate) fn usable_fb_size(self) -> u64 {
         0:0     require_ctx => bool;
     }
 
-    pub(crate) NV_PFALCON_FALCON_DMATRFBASE(u32) @ PFalconBase + 0x00000110 {
+    pub(crate) NV_PFALCON_FALCON_DMATRFBASE(u32) @ 0x00000110 {
         31:0    base => u32;
     }
 
-    pub(crate) NV_PFALCON_FALCON_DMATRFMOFFS(u32) @ PFalconBase + 0x00000114 {
+    pub(crate) NV_PFALCON_FALCON_DMATRFMOFFS(u32) @ 0x00000114 {
         23:0    offs;
     }
 
-    pub(crate) NV_PFALCON_FALCON_DMATRFCMD(u32) @ PFalconBase + 0x00000118 {
+    pub(crate) NV_PFALCON_FALCON_DMATRFCMD(u32) @ 0x00000118 {
         16:16   set_dmtag;
         14:12   ctxdma;
         10:8    size ?=> DmaTrfCmdSize;
@@ -411,15 +410,15 @@ pub(crate) fn usable_fb_size(self) -> u64 {
         0:0     full => bool;
     }
 
-    pub(crate) NV_PFALCON_FALCON_DMATRFFBOFFS(u32) @ PFalconBase + 0x0000011c {
+    pub(crate) NV_PFALCON_FALCON_DMATRFFBOFFS(u32) @ 0x0000011c {
         31:0    offs => u32;
     }
 
-    pub(crate) NV_PFALCON_FALCON_DMATRFBASE1(u32) @ PFalconBase + 0x00000128 {
+    pub(crate) NV_PFALCON_FALCON_DMATRFBASE1(u32) @ 0x00000128 {
         8:0     base;
     }
 
-    pub(crate) NV_PFALCON_FALCON_HWCFG1(u32) @ PFalconBase + 0x0000012c {
+    pub(crate) NV_PFALCON_FALCON_HWCFG1(u32) @ 0x0000012c {
         /// Core revision subversion.
         7:6     core_rev_subversion => FalconCoreRevSubversion;
         /// Security model.
@@ -428,12 +427,12 @@ pub(crate) fn usable_fb_size(self) -> u64 {
         3:0     core_rev ?=> FalconCoreRev;
     }
 
-    pub(crate) NV_PFALCON_FALCON_CPUCTL_ALIAS(u32) @ PFalconBase + 0x00000130 {
+    pub(crate) NV_PFALCON_FALCON_CPUCTL_ALIAS(u32) @ 0x00000130 {
         1:1     startcpu => bool;
     }
 
     /// IMEM access control register. Up to 4 ports are available for IMEM access.
-    pub(crate) NV_PFALCON_FALCON_IMEMC(u32)[4, stride = 16] @ PFalconBase + 0x00000180 {
+    pub(crate) NV_PFALCON_FALCON_IMEMC(u32)[4, stride = 16] @ 0x00000180 {
         /// Access secure IMEM.
         28:28     secure => bool;
         /// Auto-increment on write.
@@ -444,17 +443,17 @@ pub(crate) fn usable_fb_size(self) -> u64 {
 
     /// IMEM data register. Reading/writing this register accesses IMEM at the address
     /// specified by the corresponding IMEMC register.
-    pub(crate) NV_PFALCON_FALCON_IMEMD(u32)[4, stride = 16] @ PFalconBase + 0x00000184 {
+    pub(crate) NV_PFALCON_FALCON_IMEMD(u32)[4, stride = 16] @ 0x00000184 {
         31:0      data;
     }
 
     /// IMEM tag register. Used to set the tag for the current IMEM block.
-    pub(crate) NV_PFALCON_FALCON_IMEMT(u32)[4, stride = 16] @ PFalconBase + 0x00000188 {
+    pub(crate) NV_PFALCON_FALCON_IMEMT(u32)[4, stride = 16] @ 0x00000188 {
         15:0      tag;
     }
 
     /// DMEM access control register. Up to 8 ports are available for DMEM access.
-    pub(crate) NV_PFALCON_FALCON_DMEMC(u32)[8, stride = 8] @ PFalconBase + 0x000001c0 {
+    pub(crate) NV_PFALCON_FALCON_DMEMC(u32)[8, stride = 8] @ 0x000001c0 {
         /// Auto-increment on write.
         24:24     aincw => bool;
         /// DMEM block and word offset.
@@ -463,29 +462,29 @@ pub(crate) fn usable_fb_size(self) -> u64 {
 
     /// DMEM data register. Reading/writing this register accesses DMEM at the address
     /// specified by the corresponding DMEMC register.
-    pub(crate) NV_PFALCON_FALCON_DMEMD(u32)[8, stride = 8] @ PFalconBase + 0x000001c4 {
+    pub(crate) NV_PFALCON_FALCON_DMEMD(u32)[8, stride = 8] @ 0x000001c4 {
         31:0      data;
     }
 
     /// Actually known as `NV_PSEC_FALCON_ENGINE` and `NV_PGSP_FALCON_ENGINE` depending on the
     /// falcon instance.
-    pub(crate) NV_PFALCON_FALCON_ENGINE(u32) @ PFalconBase + 0x000003c0 {
+    pub(crate) NV_PFALCON_FALCON_ENGINE(u32) @ 0x000003c0 {
         0:0     reset => bool;
     }
 
-    pub(crate) NV_PFALCON_FBIF_TRANSCFG(u32)[8] @ PFalconBase + 0x00000600 {
+    pub(crate) NV_PFALCON_FBIF_TRANSCFG(u32)[8] @ 0x00000600 {
         2:2     mem_type => FalconFbifMemType;
         1:0     target ?=> FalconFbifTarget;
     }
 
-    pub(crate) NV_PFALCON_FBIF_CTL(u32) @ PFalconBase + 0x00000624 {
+    pub(crate) NV_PFALCON_FBIF_CTL(u32) @ 0x00000624 {
         7:7     allow_phys_no_ctx => bool;
     }
 
     // Falcon EMEM PIO registers (used by FSP on Hopper/Blackwell).
     // These provide the falcon external memory communication interface.
 
-    pub(crate) NV_PFALCON_FALCON_EMEMC(u32) @ PFalconBase + 0x00000ac0 {
+    pub(crate) NV_PFALCON_FALCON_EMEMC(u32) @ 0x00000ac0 {
         /// EMEM byte offset (4-byte aligned) within the block.
         7:2     offs;
         /// EMEM block to access.
@@ -496,7 +495,7 @@ pub(crate) fn usable_fb_size(self) -> u64 {
         25:25   aincr => bool;
     }
 
-    pub(crate) NV_PFALCON_FALCON_EMEMD(u32) @ PFalconBase + 0x00000ac4 {
+    pub(crate) NV_PFALCON_FALCON_EMEMD(u32) @ 0x00000ac4 {
         31:0    data => u32;
     }
 }
@@ -523,12 +522,12 @@ pub(crate) fn with_falcon_mem(self, mem: FalconMem) -> Self {
 impl NV_PFALCON_FALCON_ENGINE {
     /// Resets the falcon
     pub(crate) fn reset_engine<E: FalconEngine>(bar: Bar0<'_>) {
-        bar.update(Self::of::<E>(), |r| r.with_reset(true));
+        E::pfalcon(bar).update(NV_PFALCON_FALCON_ENGINE, |r| r.with_reset(true));
 
         // TIMEOUT: falcon engine should not take more than 10us to reset.
         time::delay::fsleep(time::Delta::from_micros(10));
 
-        bar.update(Self::of::<E>(), |r| r.with_reset(false));
+        E::pfalcon(bar).update(NV_PFALCON_FALCON_ENGINE, |r| r.with_reset(false));
     }
 }
 
@@ -542,23 +541,23 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
 /* PFALCON2 */
 
 register! {
-    base: NovaRegisters;
+    base: PFalcon2Registers;
 
-    pub(crate) NV_PFALCON2_FALCON_MOD_SEL(u32) @ PFalcon2Base + 0x00000180 {
+    pub(crate) NV_PFALCON2_FALCON_MOD_SEL(u32) @ 0x00000180 {
         7:0     algo ?=> FalconModSelAlgo;
     }
 
-    pub(crate) NV_PFALCON2_FALCON_BROM_CURR_UCODE_ID(u32) @ PFalcon2Base + 0x00000198 {
+    pub(crate) NV_PFALCON2_FALCON_BROM_CURR_UCODE_ID(u32) @ 0x00000198 {
         7:0    ucode_id => u8;
     }
 
-    pub(crate) NV_PFALCON2_FALCON_BROM_ENGIDMASK(u32) @ PFalcon2Base + 0x0000019c {
+    pub(crate) NV_PFALCON2_FALCON_BROM_ENGIDMASK(u32) @ 0x0000019c {
         31:0    value => u32;
     }
 
     /// OpenRM defines this as a register array, but doesn't specify its size and only uses its
     /// first element. Be conservative until we know the actual size or need to use more registers.
-    pub(crate) NV_PFALCON2_FALCON_BROM_PARAADDR(u32)[1] @ PFalcon2Base + 0x00000210 {
+    pub(crate) NV_PFALCON2_FALCON_BROM_PARAADDR(u32)[1] @ 0x00000210 {
         31:0    value => u32;
     }
 }
@@ -566,23 +565,23 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
 // PRISCV
 
 register! {
-    base: NovaRegisters;
+    base: PFalcon2Registers;
 
     /// RISC-V status register for debug (Turing and GA100 only).
     /// Reflects current RISC-V core status.
-    pub(crate) NV_PRISCV_RISCV_CORE_SWITCH_RISCV_STATUS(u32) @ PFalcon2Base + 0x00000240 {
+    pub(crate) NV_PRISCV_RISCV_CORE_SWITCH_RISCV_STATUS(u32) @ 0x00000240 {
         /// RISC-V core active/inactive status.
         0:0     active_stat => bool;
     }
 
     /// GA102 and later.
-    pub(crate) NV_PRISCV_RISCV_CPUCTL(u32) @ PFalcon2Base + 0x00000388 {
+    pub(crate) NV_PRISCV_RISCV_CPUCTL(u32) @ 0x00000388 {
         7:7     active_stat => bool;
         0:0     halted => bool;
     }
 
     /// GA102 and later.
-    pub(crate) NV_PRISCV_RISCV_BCR_CTRL(u32) @ PFalcon2Base + 0x00000668 {
+    pub(crate) NV_PRISCV_RISCV_BCR_CTRL(u32) @ 0x00000668 {
         8:8     br_fetch => bool;
         4:4     core_select => PeregrineCoreSelect;
         0:0     valid => bool;

-- 
2.54.0

