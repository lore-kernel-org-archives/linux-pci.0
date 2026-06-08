Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021080.outbound.protection.outlook.com [52.101.95.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A0F3EA967;
	Mon,  8 Jun 2026 19:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948761; cv=fail; b=mhY3a5fRBjordMT65mj8dTfk3g1ce3t+AQXxYdl7X93o3hxkuPW290u1P+mcNoBb5hxG8HvUJblCJLV6dTSbZlONlyJstZT7+B8F8yqrk8T1mVx34UUVRiq30w0XUHycFQGd1E/+FfwFyroa4CybBystjUDXR30Wrun1S0Rz7Y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948761; c=relaxed/simple;
	bh=wmxzPu0c0OKYEprY/AcsW+0RzmA2WFWu+K+BzicwFZQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uXMKgRlhw80aW02NCchPEiNffLWkdbt2ID/SJZs8NRM0TB7nPvVCwTlpNwHWwZbrA98P3YGZMzzCXC+bg/cMbjHlpHL72mAXJhaEd0Y+0ErqRIODgBJErjhaNgQzD5zm67HeR/Zw+KRxtoMqE5vcNzMkznzOoqHNAaDRzX+cquo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Yj7ycDa4; arc=fail smtp.client-ip=52.101.95.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Yj7ycDa4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkhyIZcxSzOTy0AvMNAvGa7plgmBc2laB88sh78XIY83BvJtfyRhyfhW0QjhqFIeGF/oKQSUF8F5ccczXGRKE5qhlM8MwM1Ata7AQd3f93R/V4LUplBBblvVmn7i6466h0biCaW3aWSxvPhIFP8+3m67obzXQ4HzBekPkE9JOevuI47PNwGhm0ATgCjgYBiRp202jxV16QDNs/w2912J3vkn2QXCw3dwJyr6lCXDGoBGYvapqKnjzrpQz2AHnROw3FeaaDjhxkGSXCaPXdt+5104e/eFZ99T6azoYhbN1l2q6KJ93igl4qqoSpUDJXifdM3nocUKI7E13X/HKSwuNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcmDl9qJ/oGwD4XoEgLcnZxea+19bOZMP/ZNt8FC8NM=;
 b=IIkj1N1kguDFoipqElgIL1iJcP+MgGSjuNmqmrLcOoBUYOet7Xs0HH53jH1jr5Fyc+H6tDyfhlvr0cQWbVtX7Kp97maoQxpIRZ6ohpjGEtDmo3MMrZ5n+OiBgwLYhCOye9R8VFMdv/uUN0fMYy4V9nY6C7LMAIjZ4QeQ6NRrHlkJZtF9c/Op9q/fwjNu0ZXouhlne5jJUrqj4GP/HQSthwRLiuLIwNzIFp54eJWksm4aohWhthi1jd/NbKcSqQOWhtpNBIVAFAB1XXSBFj/jH4npckPzNrk3VnDl6b43G2IpmYDvoRNhMRMFzWHzef5+xtAOfpG7kGuB/5ohTqJVdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcmDl9qJ/oGwD4XoEgLcnZxea+19bOZMP/ZNt8FC8NM=;
 b=Yj7ycDa4VQGR41Y+SB2iLHJ3C6nW8nGafwSUuhyVyqn4wGeEPNfUmheKFloxSHQmVOcStfWy3UDHcW58Wk2fu7zMbUTy1r+28pVaQsY6/GVBgM9aHiXv8u+Rb/7/rySe3tG6mM3+A8Jy+yfHMbE9i5FZsPTH2cA7xcEu0CuGJZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOAP265MB9032.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:492::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 19:59:15 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 19:59:15 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 08 Jun 2026 20:59:16 +0100
Subject: [PATCH v3 19/19] rust: io: implement `Io` for `Either`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-io_projection-v3-19-c5cde13a5ec4@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780948747; l=4706;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=wmxzPu0c0OKYEprY/AcsW+0RzmA2WFWu+K+BzicwFZQ=;
 b=q1S2929VJWPMdafMXT0r61VsJALLzS6xmkHO2r2431POzQGCniIaRMRjvZAWHtCGEENbfp0lV
 F25in8X1LmmA2NiXEmn591SaicdYqn7JQQNjqnDbdWu7J1pCTkmhr/L
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
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOAP265MB9032:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e25a22-f420-4ca1-6395-08dec5986b19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014|921020|5023799004|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	e5ZMd35SaF5Y0/HDn4fLyu+hqeIEgGnOTX2GlwwVs+HxBU4I+K8EqxySv9+SZZpITEMtXmj7FP6C1rVGsdKpCOABQp9sqp/8B6pwiCu+YhITPBx4SWC3AxqzS4fVCxOsG2OmVZEu/Ew1MfE71/DQreFlInUW4bkU6S9GC1WNhgEqU9FasXYSE9vbb2mCEebK5tFrHUqcReeg8e5pgUjCU4XVGs793oAVQyjE3oe4rQZLyoghqIY5O+cN6ZFv4sa+gw8/Jt20uwrNZt+NdyOfRspxVIiNO2u1CdXTZwR9mahK67XPi7idiEztQGJhvj2WUodb506/j1MYWSxLA3WWgIEhTZbu3JeWZRbdG/R4ReopEl4LpFQebp37Vj1m4kEAvTa5wbpyvkl58Y0Z6uvOGEwX79EKxilA7GVsqYeXFQ1EGOO+RAV0k75JhIaG1aCccqw2Ou2wAyTVPmV4wjO/HYNIAZYbVFvf/K50wmtTcRqeUZqbqnvT/N7ihufVjwPSLP1+nb4ywLvpkvcfY0WX3TjWc/KEhu9tytX/6t7VJ3mjo9cUGgcuK5gNHgiaurEDlhWhA5vHkNDyi8IQk/Que+gYBTToA2botCpb90GRhnMaseTRUShVL1XyzXkwc7jHqD5ARcDvCGnAg/jPrD9RM7oIpzGcMD5cI1l3BW0+7qSLpng1lJBTQsZhpCaOVFMSRYiQItsGVwUpOUDdZtPBJUxYHdlRmnCpcKmGkP9mfBI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014)(921020)(5023799004)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjNnQkQvMnB2eVd4dzdZeFN3d2FrWkhaa0hXSUMwUlpWbm1iQU5zTmtSWWVj?=
 =?utf-8?B?ekgrK09ZVktzc3lIODRpTnY4N0FPc1FpRHloZ0E5YVNHem43eFd4Q0FxL0hK?=
 =?utf-8?B?SWs0bVFTbi9ISmN3L09sTFAvTVpLWGdsUGJqRUQrdllrNFZaVkhCOExtSEgr?=
 =?utf-8?B?WjIwVFpIajhpNXJOQTRUbU5kV0x4TXZqTkZEMlltMHg1MnFVd2ZzTEhmUnpw?=
 =?utf-8?B?MkZSMDI2SFUvL3pjc0tXUWM1RXBKcURISnhOM3hlWHBhbWZvM1hiMGhadVh6?=
 =?utf-8?B?ZjJjd3NKamU3MytPenJKWWU1RnRXbmk1REt3dnhzSFBvRlZ2ZDJtK3hOUzJh?=
 =?utf-8?B?dDN3bStURnlja0V0QzlVWXZLR2pKRjhKN1pVd1NLckEvc2RhbFZOdlQ5WkhX?=
 =?utf-8?B?aW9EYlB0VmQwdWt6ZTFVRWhaL1cwUzUrSDBEQ2JyeGdyQnlMVmVCWHZLYkVt?=
 =?utf-8?B?bTN6NnE4TjN2d01ORkE1UjVlN3QrRVhVT2luenN4c1pvK05sNnl5NHFJTTFz?=
 =?utf-8?B?bFpXSlRKWlhGNlNrK0NRVGNnWUpkTVFwc3B6Z2dpWmp0QzZJMk9WN3pWaHpC?=
 =?utf-8?B?ZW91Zk1Kams3QytITERZVkwwQ0F3KzcxYUtKT3R0ZXpVK1FCdHBGZTFnZFZH?=
 =?utf-8?B?aUxQbmNxNEZPVEQ5RkVwSTVBMmxxZVNKcEpid2VMdTZyN3RNZGZnd0dlRHBm?=
 =?utf-8?B?dlNwTmtzejFBaWJqU1dRVGZuZEJ5YWdHUEJDMkJnZktjTHNWL0YzVk0xeFox?=
 =?utf-8?B?ZFBPTnd3bmxxQy9vUW9kV1NWT1QxZFVRZmRxNmJEMit1bHRIdm1aalk2TDlZ?=
 =?utf-8?B?MzJzNmxoamg5dWdOT2EreVJ6c1lqaWNGcTBKTWZBNWdkSUNGVzBKN1AvM2tU?=
 =?utf-8?B?akY1K3Bma3lNa0Zvb3BwWU5raTZNcGZhZk9NTXUyVDJLdEhrQ05SMStuYndi?=
 =?utf-8?B?eWI4R1FqMlQ5RHNkNFFSOStpSmpBcVJob0wzdEtsNjdnVXozaDFERkU1NG5r?=
 =?utf-8?B?Wjd3d0d3aDJaT0RuNXdjZEFlQnNiRmNrdlErTUZmSHhDVFBEOStHbHJuZW1K?=
 =?utf-8?B?ZTZBclBwdWdCdGwwL0VnejY2VWhhazZzSFpMM3NSL0NHWHl6d21YN3pzYmF4?=
 =?utf-8?B?dW9YM0YwdnhWb2JUb01xOWx6NEdxQlJHbXoxRldLWVU0SXMyMHJQU1MyZUpF?=
 =?utf-8?B?SVI3d0ZVZi9jdk1ESVVCMUZPVjYxOUhxMHlYSjJ0eTRTV29ZcDlnblR1dHFs?=
 =?utf-8?B?R3VYN0xtc0xuUWNBMjRDVnZsMEI1Z3pnb05WUnFNL0FQYlhIRkpNRTBBd2Va?=
 =?utf-8?B?eHdac3pNSUM5RXh1Ky91ZEx6NnYralJ6WW53dWkvN25LUkdmQ2xnallWQWhq?=
 =?utf-8?B?NVBlOEVBa2E1VlJHNmMrWDZHMGpXejBKTUoxYXd0Z28yMFNkRU0zemNQR3hy?=
 =?utf-8?B?aFBDc2U3QjZSdVhzKzI1TUlYbXNueWtZcWd1c3dmTXIrUTdoQXpDckVQWlQz?=
 =?utf-8?B?bTVXUVN4RFRtY1l3WFJpSnRCVjAzYmJ1MUo4RVN1T2FJdklWTHIraWQrdkxw?=
 =?utf-8?B?dDVibURoQWZuVEZxaUhSYzRDWkZUdXZRNWNnd0UwMUIwejErQWpFby9oSWxy?=
 =?utf-8?B?ZUwzcnhrelhLUldpS01aZTZQUUVkTFc0bTM2eEJtVk9IclJYWFVaaWs1ZjBQ?=
 =?utf-8?B?dlFENjJnWVEvWGxSdTRUWWlwUGt1cFRGaUFiYnlQRDZoK2x6d0c5bzA1dzhG?=
 =?utf-8?B?NXF5cFA3VjJQNXhGcXRJb09UUk5aemZzcjA3K2lacmhhQkx6bW1LRHVONnhm?=
 =?utf-8?B?R0YySDNrWkwrQ3pMY0ZTckcrN3pmVnpORW9icjFPeGpTN0hwNVI1ZmxqemFs?=
 =?utf-8?B?ckltd2VkZ1VXeWM2NkRGRmxjTUlYK2ZHZ2hzbzNuWXdpcllXU3NZcE9JNS9l?=
 =?utf-8?B?ZWpWUzQ3b1ZVenpoZFBYcmhFd0p3c0J3elRpUXFmME51ZDRqcTBNRWdZbWRZ?=
 =?utf-8?B?N3dxVUxRRWl2MTY2L0FyM0hDWGhJa01qVUlJNGJWcU9lUmd0VTgwMWRxdGp5?=
 =?utf-8?B?Y0cwaGo2M2VuVUhsSHd1bm1nQXFxSnJ2Tkk2SzZkREkxMFppYzM3Q0lvRWNC?=
 =?utf-8?B?T0swbUFxbm5CeUdhMWhpMXFTcnM2RFYrV2RldWYzZjN2V0hOR2dwL1d0VEQ0?=
 =?utf-8?B?TkV2K0NkaWVrU1liVnk1SWU1ai9qcFpzVUxiVXN0dC8yVzlaQmNOcUgzWWpy?=
 =?utf-8?B?NERzQXI0QWV3b2QxWUdVUzdsaXpYTFJuNDRmNGZoOWt6NGM5TDVFRUZRaEpQ?=
 =?utf-8?B?b29LekFZYllOd2xBYjM1RXZqT3orTHBscVltUTJXeFdoS2h2elEyQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e25a22-f420-4ca1-6395-08dec5986b19
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 19:59:15.6360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PXwH3itv3xPM2uxvNO5zH3yA6LBmRpC7nnMGWJi7zP2HripPdAmOmjSCnB8O7scn65JArHSCxMFl8zaOFzu+JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP265MB9032

Add a general purpose sum type `Either` (with no preference on either side,
unlike `Result`) and implement `Io` for it.

This is generic version of what C `iosys_map` provides, which can be
just implemented like this:

    type IoSysMap<'a, T> = Either<Mmio<'a, T>, SysMem<'a, T>>;

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs    | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 rust/kernel/types.rs |  9 +++++
 2 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 2b238b625672..28d713eaddda 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -19,7 +19,8 @@
     transmute::{
         AsBytes,
         FromBytes, //
-    }, //
+    },
+    types::Either, //
 };
 
 pub mod mem;
@@ -1592,6 +1593,96 @@ pub unsafe fn project_view<U: ?Sized + KnownSize>(
     }
 }
 
+impl<'a, T: ?Sized + KnownSize, L: IoBase<'a, Target = T>, R: IoBase<'a, Target = T>> IoBase<'a>
+    for Either<L, R>
+{
+    type Backend = Either<L::Backend, R::Backend>;
+    type Target = T;
+
+    #[inline]
+    fn as_view(self) -> <Self::Backend as IoBackend>::View<'a, Self::Target> {
+        match self {
+            Either::Left(l) => Either::Left(l.as_view()),
+            Either::Right(r) => Either::Right(r.as_view()),
+        }
+    }
+}
+
+impl<L: IoBackend, R: IoBackend> IoBackend for Either<L, R> {
+    type View<'a, T: ?Sized + KnownSize> = Either<L::View<'a, T>, R::View<'a, T>>;
+
+    #[inline]
+    fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> *mut T {
+        match view {
+            Either::Left(l) => L::as_ptr(l),
+            Either::Right(r) => R::as_ptr(r),
+        }
+    }
+
+    #[inline]
+    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
+        view: Self::View<'a, T>,
+        ptr: *mut U,
+    ) -> Self::View<'a, U> {
+        match view {
+            // SAFETY: Per safety requirement.
+            Either::Left(l) => Either::Left(unsafe { L::project_view(l, ptr) }),
+            // SAFETY: Per safety requirement.
+            Either::Right(r) => Either::Right(unsafe { R::project_view(r, ptr) }),
+        }
+    }
+}
+
+impl<T, L: IoCapable<T>, R: IoCapable<T>> IoCapable<T> for Either<L, R> {
+    #[inline]
+    fn io_read(view: Self::View<'_, T>) -> T {
+        match view {
+            Either::Left(l) => L::io_read(l),
+            Either::Right(r) => R::io_read(r),
+        }
+    }
+
+    #[inline]
+    fn io_write<'a>(view: Self::View<'a, T>, value: T) {
+        match view {
+            Either::Left(l) => L::io_write(l, value),
+            Either::Right(r) => R::io_write(r, value),
+        }
+    }
+}
+
+// SAFETY: Per safety guarantee of `L` and `R`'s `IoCopyable` impl, `is_mapped` is correctly
+// implemented.
+unsafe impl<L: IoCopyable, R: IoCopyable> IoCopyable for Either<L, R> {
+    #[inline]
+    fn is_mapped<T: ?Sized + KnownSize>(view: Self::View<'_, T>) -> bool {
+        match view {
+            Either::Left(l) => L::is_mapped(l),
+            Either::Right(r) => R::is_mapped(r),
+        }
+    }
+
+    #[inline]
+    unsafe fn copy_from_io(view: Self::View<'_, [u8]>, buffer: *mut u8) {
+        match view {
+            // SAFETY: Per safety requirement.
+            Either::Left(l) => unsafe { L::copy_from_io(l, buffer) },
+            // SAFETY: Per safety requirement.
+            Either::Right(r) => unsafe { R::copy_from_io(r, buffer) },
+        }
+    }
+
+    #[inline]
+    unsafe fn copy_to_io(view: Self::View<'_, [u8]>, buffer: *const u8) {
+        match view {
+            // SAFETY: Per safety requirement.
+            Either::Left(l) => unsafe { L::copy_to_io(l, buffer) },
+            // SAFETY: Per safety requirement.
+            Either::Right(r) => unsafe { R::copy_to_io(r, buffer) },
+        }
+    }
+}
+
 /// Project an I/O type to a subview of it.
 ///
 /// The syntax is of form `io_project!(io, proj)` where `io` is an expression to a type that
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index ac316fd7b538..12546c312dd2 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -448,3 +448,12 @@ fn pin_init<E>(slot: impl PinInit<T, E>) -> impl PinInit<Self, E> {
 /// [`NotThreadSafe`]: type@NotThreadSafe
 #[allow(non_upper_case_globals)]
 pub const NotThreadSafe: NotThreadSafe = PhantomData;
+
+/// General purpose sum type with two cases.
+#[derive(Clone, Copy)]
+pub enum Either<L, R> {
+    /// A value of type `L`.
+    Left(L),
+    /// A value of type `R`.
+    Right(R),
+}

-- 
2.54.0

