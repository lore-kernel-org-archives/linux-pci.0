Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021101.outbound.protection.outlook.com [52.101.100.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E301D48A8A4;
	Tue,  1 Sep 2026 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281455; cv=fail; b=hvtzjH9uYGnSZizEuFqnf+ctl8HDRsuaWGiejiR4H62uj+4qjYWv6Fk5o4fgBvkbCvYKM69PDHg6KIN1ESif8SelDHFvmt2C0ZjXiu+bL5j23BPr0TD6H3kpw/U5hub5nlrnMOBfMrqGA19Ey6lg8j5VtzkA60BbkVAJlKytz1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281455; c=relaxed/simple;
	bh=16xLc/mUOzaQreTnJHGn33Nj9qxTDTA1r7zM5uFYy/o=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CKK6pGh9AuY/HHHtkHUHFA/OZGNZBXNYQhjSmHQwoXv9gDYZXAF4+6CmFpwqqYqj0zJSQKtt3mFNegKcyvMMo3YPaPO9s2CNKL75soz5LJR4naP/WyHhcD37HMMKVrFO2609TN/atmGrpGnfK6Q0plYKT3ppjDStfvi77YIBxWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=L9Rbley9; arc=fail smtp.client-ip=52.101.100.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="L9Rbley9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9qVBGlg8+QZDluzhx+mueNhP7RJG6c3yZ9U/ZnmqPeBMLmL2J6nladcxkDqS9CqEg1UAKkv0a3n0xADSu3Kz3ac4k512RbuCgZoLUIo6g8izd/Ga4xDh0SQM+D8M/kXelyRTEb7loOdmDAqYKlIlaS2ATo0agy0i1FxG8Rf8lkCBDIGVm5yptYv9A80s3A3Pl85BAlzrf89xoVsH0xfAWVXFB0KOoYsfWiGXe/76lv4hetYzQ9Ypuk3VqGiygJ8zaW49xfXiqw+l5B0SGzy5CYlho/aFEAMrbycb0wZ7fz5NB/4h40VqAWYLDS8rB+W+PXBGx+HMEWC4PdhwEltew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTUtJEFv5VcrEXgxXLcxho/So8UFIvCOQMAgnhyhiso=;
 b=FEI0tgtuiSRA2/tn7p/2vAEddcsy7fM3w58gkXW46dDqD29+LO/cL70jlakXKgrfXXBIeE2U4Gv0FqU3yj3ip2JohEe7v8YntwzJwbLLKFw7L4WbX/Wts68Rzmj2c8ZczDKvWkDY5/hVZyIqBHJTq1X18QLYvqvjB0ofnnbUMDipaNsWrX5UNFPK4igTA8IdkQW7QNAAqUMNziubynfdib49IhBKyBVC1mk9QB/PWLe0elUW/ZrL6BcrD+BAvsVbVgSDfeb6jPBW2HYVqGElJEENhQeO7d4WYBqkjuLq1IP+Q93UNm0m/pv2OwqSnub6WUIXzEAmGzoC9r/QUsg7oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTUtJEFv5VcrEXgxXLcxho/So8UFIvCOQMAgnhyhiso=;
 b=L9Rbley9eR9e3su5FeoNr2Q5+lae5IeDiDEvyT8fR8XF16wH/dSuVKDB/aueLbwiJhG8bgSe3my9x+S375uWABUbOST6+eujrc1EDUQ7gxW/LEwKw3NxLqDOFDWQZLGBcCvv5+YmhVSjYMRIIxPWVTKgMLjcd9DMSSioeEtMjqI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CW1P265MB9199.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 16:50:43 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 16:50:43 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 01 Sep 2026 17:50:36 +0100
Subject: [PATCH v4 12/16] gpu: nova-core: use projection for PFALCON and
 PFALCON2 registers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-typed_register-v4-12-5552b1d59525@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788281431; l=44858;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=16xLc/mUOzaQreTnJHGn33Nj9qxTDTA1r7zM5uFYy/o=;
 b=0ayO6V4OirGtfBsNM26WIhduvQGZjEtX2Ct6/EBN+LQkDzOK+F8bvst+Go5sz290efqgDjvzI
 +JvmLSkhgqTCny5nSFDAaywwVCglS2LpkIN/QXImXs98UBxzxIzKQjd
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
X-MS-Office365-Filtering-Correlation-Id: cb3cf142-b3ab-49f6-eada-08df08492959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|10070799003|376014|23010399003|366016|921020|6133799003|3023799007|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uzP0erWwwM7Qo2u3S1RAYy2PzA5tLc44wwAq4jZYZvH5rxy2NPqAoPLBiVh62t04FiXZzJNc3IwiT1P00UmuG0rIIvwNqN/b82uJlUi5Z//Lynn3FK8+igIrRQP8NhCMK8YEO9h2o2csWxCF7nk4kdr/UrsaYGIKrfcWjw5ZUR71NvPj1NejyA0GHAhXC91aZASdkyr2L/GhU5WZ0YoDlMT8EfyFtOOb0eOzyHI1Z+AZRLNmjB9Z4XKtUMTQB1OJ9wKrCvWsZ/OcVQKK09D1y1axdmVFwnLZGs7TPlqxpec1EyfTKKGm0T2NDPyagrR8EXs1qyRI0o48n2u122f/M5u4zmDVaolOVCgYbbvfhfI8UVl9fAk+mjtiUKAdfiuNEDsmH3vFte0MUE0TmoIC72ApAZD5DoiX79J5AMYQdwhigjIBW84A8sgafAg77S7DEGrkdy8hoGOxsvc1v31ECBQ8HZUip/Y1XVEGg/6cybSNy8fEfj++eNZ0hgS//J4oZfwd5aw8jItxloN/zx1E44FxXCA6xmf5y5NmyrmR+LoiuPzZ4bnZR5WkLUdDNBVj3AZYQiKAatA8h9LLtYhn4JEPqcUkefbiyW37Ea2O4bLfK3zQlI3KtueR++XWaU8BsrZSmxTGOEkq5sD+T7AskE53182+Yl8wtPnjLUIMh8fv/LRrSK1236EP7TkJ2TbTj3JAe1Jw4ah4Cp3jJScBHA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(10070799003)(376014)(23010399003)(366016)(921020)(6133799003)(3023799007)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UW16aVB1bFJXakhDamdaem5mK2NTZVFSTCtLZmVOWkhtOHhGYTlNcFVmaWNU?=
 =?utf-8?B?VStjb3lUNksySFUzeVVTS0tZSVA5YTJLbVBBcHdTOVdKcnBUclZYQWpXeGs3?=
 =?utf-8?B?Z0hWOEdvNnRweFdFTnVqak14bU9BdGRiTEE5VGxKb282aXBGcGM0T2hOWmd0?=
 =?utf-8?B?NWpVOXQ1OUhQcWRPOFZXRU9oeE5vTk8vL2ZlYXpNNWc5MzlpMTFDVSswQmV6?=
 =?utf-8?B?eGNodWQzNjFCa0I5ZnZHZUQra3pRd3pXWjN3QXE4TWN5S3JhRlNDdkJmSHR4?=
 =?utf-8?B?UHk3VklZNUNzV0tQN0M4aDlDTHJIVkJkL29LbHhHdkdWSU9vK2gwZ3RVVUJl?=
 =?utf-8?B?WjZ4MjFHVTgyeUNWVzJVbDZ5anVPSVZHcWJyUHZTZmpIKzYxcnRDUXJlVllh?=
 =?utf-8?B?eWtERk1tYkdPQjJ4ZThGWWdPOHJacFNGQ0tPcFZ2c0Z5S2Jib0txRlJXQW1v?=
 =?utf-8?B?TXV0YVl4eCtoWGNSRG9oMittVG5mb0tlanZMaHc2bmUxYTJjTnJPbjhsRlJ3?=
 =?utf-8?B?TkVhR0xMSnRHcmZUd1c3M3ZsdWhOdFNOVGg5L2hDRmgxdmVCQ3o3Z2FwWUo0?=
 =?utf-8?B?WDFibDhsRnRBSk1wQm5SSkdMZ0loemtSdi8zV1Y4SnpOZStlZXBQNjQ1VFI0?=
 =?utf-8?B?UThhb0NHVFNFU01rU20wdVFxYkR6bnB2d2NMSVJkbXFJdWF5aDI5Z3NidG9n?=
 =?utf-8?B?NDhhNE4yUVJEVDM1SERWSmFTeDRTVERSa1YvNTgwTTdIZ1k1eFpLOFlXV2M3?=
 =?utf-8?B?bDFoWTlGdGhQdVpack83M08xdVpDcU5xK0JBTUpTem1MSXRza0V0RUtEdUxD?=
 =?utf-8?B?SWJvZE1uVSs3L3I1ZlNEMTV3eWliQ0Erc0pjbXk4cXRzMWQrdU9PVy9vdmJY?=
 =?utf-8?B?TWpKb3MveW5kLzhMTVVuWHJjUE4zUTRNNkpxVmtGc2FXakVURDBpWmNaV2Nm?=
 =?utf-8?B?aDc4b2sxeWtESmVVRG41eGg4d2l1UGtWdlFkQ2JweHpWR0t0TzBURTJZK1R4?=
 =?utf-8?B?Skp0SnJEc1FrOUZ3eXZueURsd1BaU1lhMU05bDZuY2s5OVFHYVFiaTJ3TVFq?=
 =?utf-8?B?WStxVFpiNW4zR2d6VGg4dzBTWGJkOFlsVVVLNzBMcmc1MTVISkFnd0tuMkdQ?=
 =?utf-8?B?YndvcE9jdWIrT0dvd01PN2VFejVNbzhYVEdtWGJldHhoOCtpVDVVZVQxSnVr?=
 =?utf-8?B?RUVqMUl6Qmp6V3JCMEpFVGdlLzRHTU5keWhGUXFBSkVmeURRZzlOMDVHeXlS?=
 =?utf-8?B?ZURkeENhYXNwMXFlQjdQaDZ2dU9hbEh6MHNDMERCSndhVlV1QVN1b2tPL01Y?=
 =?utf-8?B?cnl2bzZXSXJ6enJQNmJUUHdhUnRQcTZpMGUyTkRwTTFqL2VoVzBBb2VEWTAz?=
 =?utf-8?B?cVJRZ0FaYmpVMGt2c3phOEpNZVAyVzl4ZDJZanZXVXpoaHp6ZS9wL0lkUS9S?=
 =?utf-8?B?RUpyWWhveEpMZXlDYzFJdmtCa25GRVVOV3VZZ2ZISGExNjZlVjBEdzdFUW81?=
 =?utf-8?B?S1VkVCtuS0swemdSbFFHNW1abFJPTUVNMXVkci9Tdm45U1cvUmVub2hqV3kw?=
 =?utf-8?B?U0diTnc3RnVaZ3pyRUs4dit1OHZUQWFleXcrTVREdFpoRkprUnJTTlVLOVNa?=
 =?utf-8?B?enhTNFRZR0FoY3FRSzExQi9ZU0lyQVI3dUJxVERGSFAzUXRwK0oyU2Z3eEx6?=
 =?utf-8?B?bE9RYWxwUDZyYjVCenV2YjZFUEx0MC8yRkR0d3NjSUxxOHJ3enIya00vZ1l6?=
 =?utf-8?B?dWwxZEFyVzk4ZndqMkIwdDRndGdpWUJmbGdDREcxdXpWNnduVUE4UDNLWjhM?=
 =?utf-8?B?dFY3K0RHT0xoZjk0V1VWeWREY0lSYTlvRzk4SnpBTTBkZU96MmpBSGlhTWVm?=
 =?utf-8?B?Q3dVdW5NUmRWUlpTQ0ZWMWZqeUtnSWdqWWVlWmtoU1pmTzVJb1pmZTBQem4w?=
 =?utf-8?B?RjZWZEdUZ1JsZ0taK3p0MGZVQzd2WmlVZUpGRENGaGYxT21TZFRTV3krQ3M5?=
 =?utf-8?B?KysxMHVrajNmOXo3SDRRRkJGSWdmWStqVlZTT3hvWWpVNDJ6MFYrbzBqWXMy?=
 =?utf-8?B?SWFIZWZmV2NNQWNCeDltdEh0TzVKQU9HL1RVM0xvQWc3V3crdzFMd2RKaEJ1?=
 =?utf-8?B?WXFXTDdsTEExa3dwZ0pzampmNmZoWWw1YWRNM1ZFbGc2TldJakd0SEFqNXZm?=
 =?utf-8?B?NnNZS0o1SUxtUmg4REFObHdwMWRrRGdUam5FWUJXeGJQOEdaaDU2ZmY0cFVy?=
 =?utf-8?B?bHE4UFFVS0QybHFYR0o5azFYUVZFcE1tbW50QVBqcmM4K1VVOE5ZTzhnZ1Vt?=
 =?utf-8?B?MXhkVlkzeGw1aDh2ZG5XcnhpQ2ZzTy9JTUpibVg5aVhqTzd2ZXVtQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3cf142-b3ab-49f6-eada-08df08492959
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 16:50:43.0703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X6ncPYatvFM9ANkGXMcC6kUnxhpkxf8wiBwIjVUzVuzQx8hOJ3GVo1Coz7z4nBFc/le+hty2HfTXjBOH5Y522g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB9199

Add fixed size region types `PFalconRegisters` and `PFalcon2Registers` and
update PFALCON and PFALCON2 registers to be fixed register on them and not
relative registers on `NovaRegisters`.

Update `Falcon` struct to store projected views when constructing and
access with `self.pfalcon` and `self.pfalcon2`.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
Changes since v3:
- Add PFALCON_REGION_SIZE and PFALCON2_REGION_SIZE constants (Alex).
- Add TODO comment to remove `pub(crate)` of pfalcon
---
 drivers/gpu/nova-core/falcon.rs                    | 161 +++++++++------------
 drivers/gpu/nova-core/falcon/fsp.rs                |  63 ++++----
 drivers/gpu/nova-core/falcon/gsp.rs                |  51 ++++---
 drivers/gpu/nova-core/falcon/hal/ga102.rs          |  59 +++-----
 drivers/gpu/nova-core/falcon/hal/tu102.rs          |   9 +-
 drivers/gpu/nova-core/falcon/sec2.rs               |  37 +++--
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  18 +--
 drivers/gpu/nova-core/gsp/hal/tu102.rs             |   7 +-
 drivers/gpu/nova-core/regs.rs                      |  92 ++++++------
 9 files changed, 239 insertions(+), 258 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index 65cb12d26e2b..e3af59fd57e3 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -14,13 +14,12 @@
     io::{
         io_project,
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
 
@@ -165,18 +164,25 @@ pub(crate) enum FalconFbifMemType with From<Bounded<u32, 1>> {
     }
 }
 
-/// Type used to represent the `PFALCON` registers address base for a given falcon engine.
-pub(crate) struct PFalconBase(());
+const PFALCON_REGION_SIZE: usize = SZ_4K;
+const PFALCON2_REGION_SIZE: usize = SZ_4K;
 
-/// Type used to represent the `PFALCON2` registers address base for a given falcon engine.
-pub(crate) struct PFalcon2Base(());
+/// Type used to represent the `PFALCON` registers.
+#[repr(align(4))]
+#[derive(FromBytes, IntoBytes)]
+pub(crate) struct PFalconRegisters([u8; PFALCON_REGION_SIZE]);
+
+/// Type used to represent the `PFALCON2` registers.
+#[repr(align(4))]
+#[derive(FromBytes, IntoBytes)]
+pub(crate) struct PFalcon2Registers([u8; PFALCON2_REGION_SIZE]);
 
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
@@ -358,6 +364,9 @@ pub(crate) struct Falcon<'a, E: FalconEngine> {
     hal: KBox<dyn FalconHal<E>>,
     dev: &'a device::Device<device::Bound>,
     bar: Bar0<'a>,
+    // TODO: make private
+    pub(crate) pfalcon: Mmio<'a, PFalconRegisters>,
+    pfalcon2: Mmio<'a, PFalcon2Registers>,
 }
 
 impl<'a, E: FalconEngine + 'static> Falcon<'a, E> {
@@ -371,19 +380,19 @@ pub(crate) fn new(
             hal: hal::falcon_hal(chipset)?,
             dev,
             bar,
+            pfalcon: E::pfalcon(bar),
+            pfalcon2: E::pfalcon2(bar),
         })
     }
 
     /// Resets DMA-related registers.
     pub(crate) fn dma_reset(&self) {
-        self.bar.update(regs::NV_PFALCON_FBIF_CTL::of::<E>(), |v| {
+        self.pfalcon.update(regs::NV_PFALCON_FBIF_CTL, |v| {
             v.with_allow_phys_no_ctx(true)
         });
 
-        self.bar.write(
-            WithBase::of::<E>(),
-            regs::NV_PFALCON_FALCON_DMACTL::zeroed(),
-        );
+        self.pfalcon
+            .write_reg(regs::NV_PFALCON_FALCON_DMACTL::zeroed());
     }
 
     /// Reset the controller, select the falcon core, and wait for memory scrubbing to complete.
@@ -392,10 +401,9 @@ pub(crate) fn reset(&self) -> Result {
         self.hal.select_core(self)?;
         self.hal.reset_wait_mem_scrubbing(self)?;
 
-        self.bar.write(
-            WithBase::of::<E>(),
-            regs::NV_PFALCON_FALCON_RM::from(self.bar.read(regs::NV_PMC_BOOT_0).into_raw()),
-        );
+        self.pfalcon.write_reg(regs::NV_PFALCON_FALCON_RM::from(
+            self.bar.read(regs::NV_PMC_BOOT_0).into_raw(),
+        ));
 
         Ok(())
     }
@@ -413,8 +421,8 @@ fn pio_wr_imem_slice(&self, load_offsets: FalconPioImemLoadTarget<'_>) -> Result
             return Err(EINVAL);
         }
 
-        self.bar.write(
-            WithBase::of::<E>().at(Self::PIO_PORT),
+        self.pfalcon.write(
+            Array::at(Self::PIO_PORT),
             regs::NV_PFALCON_FALCON_IMEMC::zeroed()
                 .with_secure(load_offsets.secure)
                 .with_aincw(true)
@@ -424,14 +432,14 @@ fn pio_wr_imem_slice(&self, load_offsets: FalconPioImemLoadTarget<'_>) -> Result
         for (n, block) in load_offsets.data.chunks(MEM_BLOCK_ALIGNMENT).enumerate() {
             let n = u16::try_from(n)?;
             let tag: u16 = load_offsets.start_tag.checked_add(n).ok_or(ERANGE)?;
-            self.bar.write(
-                WithBase::of::<E>().at(Self::PIO_PORT),
+            self.pfalcon.write(
+                Array::at(Self::PIO_PORT),
                 regs::NV_PFALCON_FALCON_IMEMT::zeroed().with_tag(tag),
             );
             for word in block.chunks_exact(4) {
                 let w = [word[0], word[1], word[2], word[3]];
-                self.bar.write(
-                    WithBase::of::<E>().at(Self::PIO_PORT),
+                self.pfalcon.write(
+                    Array::at(Self::PIO_PORT),
                     regs::NV_PFALCON_FALCON_IMEMD::zeroed().with_data(u32::from_le_bytes(w)),
                 );
             }
@@ -450,8 +458,8 @@ fn pio_wr_dmem_slice(&self, load_offsets: FalconPioDmemLoadTarget<'_>) -> Result
             return Err(EINVAL);
         }
 
-        self.bar.write(
-            WithBase::of::<E>().at(Self::PIO_PORT),
+        self.pfalcon.write(
+            Array::at(Self::PIO_PORT),
             regs::NV_PFALCON_FALCON_DMEMC::zeroed()
                 .with_aincw(true)
                 .with_offs(load_offsets.dst_start),
@@ -459,8 +467,8 @@ fn pio_wr_dmem_slice(&self, load_offsets: FalconPioDmemLoadTarget<'_>) -> Result
 
         for word in load_offsets.data.chunks_exact(4) {
             let w = [word[0], word[1], word[2], word[3]];
-            self.bar.write(
-                WithBase::of::<E>().at(Self::PIO_PORT),
+            self.pfalcon.write(
+                Array::at(Self::PIO_PORT),
                 regs::NV_PFALCON_FALCON_DMEMD::zeroed().with_data(u32::from_le_bytes(w)),
             );
         }
@@ -473,14 +481,12 @@ pub(crate) fn pio_load<F: FalconFirmware<Target = E> + FalconPioLoadable>(
         &self,
         fw: &F,
     ) -> Result {
-        self.bar.update(regs::NV_PFALCON_FBIF_CTL::of::<E>(), |v| {
+        self.pfalcon.update(regs::NV_PFALCON_FBIF_CTL, |v| {
             v.with_allow_phys_no_ctx(true)
         });
 
-        self.bar.write(
-            WithBase::of::<E>(),
-            regs::NV_PFALCON_FALCON_DMACTL::zeroed(),
-        );
+        self.pfalcon
+            .write_reg(regs::NV_PFALCON_FALCON_DMACTL::zeroed());
 
         if let Some(imem_ns) = fw.imem_ns_load_params() {
             self.pio_wr_imem_slice(imem_ns)?;
@@ -492,10 +498,8 @@ pub(crate) fn pio_load<F: FalconFirmware<Target = E> + FalconPioLoadable>(
 
         self.hal.program_brom(self, &fw.brom_params());
 
-        self.bar.write(
-            WithBase::of::<E>(),
-            regs::NV_PFALCON_FALCON_BOOTVEC::zeroed().with_value(fw.boot_addr()),
-        );
+        self.pfalcon
+            .write_reg(regs::NV_PFALCON_FALCON_BOOTVEC::zeroed().with_value(fw.boot_addr()));
 
         Ok(())
     }
@@ -547,16 +551,13 @@ fn dma_wr(
 
         // Set up the base source DMA address.
 
-        self.bar.write(
-            WithBase::of::<E>(),
-            regs::NV_PFALCON_FALCON_DMATRFBASE::zeroed().with_base(
+        self.pfalcon
+            .write_reg(regs::NV_PFALCON_FALCON_DMATRFBASE::zeroed().with_base(
                 // CAST: `as u32` is used on purpose since we do want to strip the upper bits,
                 // which will be written to `NV_PFALCON_FALCON_DMATRFBASE1`.
                 (dma_address >> 8) as u32,
-            ),
-        );
-        self.bar.write(
-            WithBase::of::<E>(),
+            ));
+        self.pfalcon.write_reg(
             regs::NV_PFALCON_FALCON_DMATRFBASE1::zeroed().try_with_base(dma_address >> 40)?,
         );
 
@@ -566,23 +567,21 @@ fn dma_wr(
 
         for pos in (0..num_transfers).map(|i| i * DMA_LEN) {
             // Perform a transfer of size `DMA_LEN`.
-            self.bar.write(
-                WithBase::of::<E>(),
+            self.pfalcon.write_reg(
                 regs::NV_PFALCON_FALCON_DMATRFMOFFS::zeroed()
                     .try_with_offs(load_offsets.dst_start + pos)?,
             );
-            self.bar.write(
-                WithBase::of::<E>(),
+            self.pfalcon.write_reg(
                 regs::NV_PFALCON_FALCON_DMATRFFBOFFS::zeroed().with_offs(src_start + pos),
             );
 
-            self.bar.write(WithBase::of::<E>(), cmd);
+            self.pfalcon.write_reg(cmd);
 
             // Wait for the transfer to complete.
             // TIMEOUT: arbitrarily large value, no DMA transfer to the falcon's small memories
             // should ever take that long.
             read_poll_timeout(
-                || Ok(self.bar.read(regs::NV_PFALCON_FALCON_DMATRFCMD::of::<E>())),
+                || Ok(self.pfalcon.read(regs::NV_PFALCON_FALCON_DMATRFCMD)),
                 |r| r.idle(),
                 Delta::ZERO,
                 Delta::from_secs(2),
@@ -614,8 +613,8 @@ fn dma_load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(&self, fw: &F) ->
         };
 
         self.dma_reset();
-        self.bar
-            .update(regs::NV_PFALCON_FBIF_TRANSCFG::of::<E>().at(0), |v| {
+        self.pfalcon
+            .update(regs::NV_PFALCON_FBIF_TRANSCFG::at(0), |v| {
                 v.with_target(FalconFbifTarget::CoherentSysmem)
                     .with_mem_type(FalconFbifMemType::Physical)
             });
@@ -626,10 +625,8 @@ fn dma_load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(&self, fw: &F) ->
         self.hal.program_brom(self, &fw.brom_params());
 
         // Set `BootVec` to start of non-secure code.
-        self.bar.write(
-            WithBase::of::<E>(),
-            regs::NV_PFALCON_FALCON_BOOTVEC::zeroed().with_value(fw.boot_addr()),
-        );
+        self.pfalcon
+            .write_reg(regs::NV_PFALCON_FALCON_BOOTVEC::zeroed().with_value(fw.boot_addr()));
 
         Ok(())
     }
@@ -638,7 +635,7 @@ fn dma_load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(&self, fw: &F) ->
     pub(crate) fn wait_till_halted(&self) -> Result<()> {
         // TIMEOUT: arbitrarily large value, firmwares should complete in less than 2 seconds.
         read_poll_timeout(
-            || Ok(self.bar.read(regs::NV_PFALCON_FALCON_CPUCTL::of::<E>())),
+            || Ok(self.pfalcon.read(regs::NV_PFALCON_FALCON_CPUCTL)),
             |r| r.halted(),
             Delta::ZERO,
             Delta::from_secs(2),
@@ -649,19 +646,13 @@ pub(crate) fn wait_till_halted(&self) -> Result<()> {
 
     /// Start the falcon CPU.
     pub(crate) fn start(&self) -> Result<()> {
-        match self
-            .bar
-            .read(regs::NV_PFALCON_FALCON_CPUCTL::of::<E>())
-            .alias_en()
-        {
-            true => self.bar.write(
-                WithBase::of::<E>(),
-                regs::NV_PFALCON_FALCON_CPUCTL_ALIAS::zeroed().with_startcpu(true),
-            ),
-            false => self.bar.write(
-                WithBase::of::<E>(),
-                regs::NV_PFALCON_FALCON_CPUCTL::zeroed().with_startcpu(true),
-            ),
+        match self.pfalcon.read(regs::NV_PFALCON_FALCON_CPUCTL).alias_en() {
+            true => self
+                .pfalcon
+                .write_reg(regs::NV_PFALCON_FALCON_CPUCTL_ALIAS::zeroed().with_startcpu(true)),
+            false => self
+                .pfalcon
+                .write_reg(regs::NV_PFALCON_FALCON_CPUCTL::zeroed().with_startcpu(true)),
         }
 
         Ok(())
@@ -670,32 +661,24 @@ pub(crate) fn start(&self) -> Result<()> {
     /// Writes values to the mailbox registers if provided.
     pub(crate) fn write_mailboxes(&self, mbox0: Option<u32>, mbox1: Option<u32>) {
         if let Some(mbox0) = mbox0 {
-            self.bar.write(
-                WithBase::of::<E>(),
-                regs::NV_PFALCON_FALCON_MAILBOX0::zeroed().with_value(mbox0),
-            );
+            self.pfalcon
+                .write_reg(regs::NV_PFALCON_FALCON_MAILBOX0::zeroed().with_value(mbox0));
         }
 
         if let Some(mbox1) = mbox1 {
-            self.bar.write(
-                WithBase::of::<E>(),
-                regs::NV_PFALCON_FALCON_MAILBOX1::zeroed().with_value(mbox1),
-            );
+            self.pfalcon
+                .write_reg(regs::NV_PFALCON_FALCON_MAILBOX1::zeroed().with_value(mbox1));
         }
     }
 
     /// Reads the value from `mbox0` register.
     pub(crate) fn read_mailbox0(&self) -> u32 {
-        self.bar
-            .read(regs::NV_PFALCON_FALCON_MAILBOX0::of::<E>())
-            .value()
+        self.pfalcon.read(regs::NV_PFALCON_FALCON_MAILBOX0).value()
     }
 
     /// Reads the value from `mbox1` register.
     pub(crate) fn read_mailbox1(&self) -> u32 {
-        self.bar
-            .read(regs::NV_PFALCON_FALCON_MAILBOX1::of::<E>())
-            .value()
+        self.pfalcon.read(regs::NV_PFALCON_FALCON_MAILBOX1).value()
     }
 
     /// Reads values from both mailbox registers.
@@ -760,9 +743,7 @@ pub(crate) fn load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(&self, fw:
 
     /// Write the application version to the OS register.
     pub(crate) fn write_os_version(&self, app_version: u32) {
-        self.bar.write(
-            WithBase::of::<E>(),
-            regs::NV_PFALCON_FALCON_OS::zeroed().with_value(app_version),
-        );
+        self.pfalcon
+            .write_reg(regs::NV_PFALCON_FALCON_OS::zeroed().with_value(app_version));
     }
 }
diff --git a/drivers/gpu/nova-core/falcon/fsp.rs b/drivers/gpu/nova-core/falcon/fsp.rs
index 0437180b8829..85f9c8c5d60e 100644
--- a/drivers/gpu/nova-core/falcon/fsp.rs
+++ b/drivers/gpu/nova-core/falcon/fsp.rs
@@ -8,13 +8,12 @@
 
 use kernel::{
     io::{
+        io_project,
         poll::read_poll_timeout,
-        register::{
-            Array,
-            RegisterBase,
-            WithBase, //
-        },
-        Io, //
+        register,
+        register::Array,
+        Io,
+        Mmio, //
     },
     prelude::*,
     sizes::SZ_1K,
@@ -22,11 +21,13 @@
 };
 
 use crate::{
+    driver::{
+        Bar0,
+        NovaRegisters, //
+    },
     falcon::{
         Falcon,
-        FalconEngine,
-        PFalcon2Base,
-        PFalconBase, //
+        FalconEngine, //
     },
     num,
     regs, //
@@ -41,15 +42,24 @@
 /// Type specifying the `Fsp` falcon engine. Cannot be instantiated.
 pub(crate) struct Fsp(());
 
-impl RegisterBase<PFalconBase> for Fsp {
-    const BASE: usize = 0x8f2000;
-}
+register! {
+    base: NovaRegisters;
 
-impl RegisterBase<PFalcon2Base> for Fsp {
-    const BASE: usize = 0x8f3000;
+    PFALCON: super::PFalconRegisters @ 0x8f2000;
+    PFALCON2: super::PFalcon2Registers @ 0x8f3000;
 }
 
-impl FalconEngine for Fsp {}
+impl FalconEngine for Fsp {
+    #[inline]
+    fn pfalcon(io: Bar0<'_>) -> Mmio<'_, super::PFalconRegisters> {
+        io_project!(io, build: PFALCON)
+    }
+
+    #[inline]
+    fn pfalcon2(io: Bar0<'_>) -> Mmio<'_, super::PFalcon2Registers> {
+        io_project!(io, build: PFALCON2)
+    }
+}
 
 impl<'a> Falcon<'a, Fsp> {
     /// Writes `data` to FSP external memory at offset `0`.
@@ -62,19 +72,15 @@ fn write_emem(&mut self, data: &[u8]) -> Result {
         }
 
         // Begin a write burst at offset `0`, auto-incrementing on each write.
-        self.bar.write(
-            WithBase::of::<Fsp>(),
-            regs::NV_PFALCON_FALCON_EMEMC::zeroed().with_aincw(true),
-        );
+        self.pfalcon
+            .write_reg(regs::NV_PFALCON_FALCON_EMEMC::zeroed().with_aincw(true));
 
         for chunk in data.chunks_exact(4) {
             let value = u32::from_le_bytes([chunk[0], chunk[1], chunk[2], chunk[3]]);
 
             // Write the next 32-bit `value`; hardware advances the offset.
-            self.bar.write(
-                WithBase::of::<Fsp>(),
-                regs::NV_PFALCON_FALCON_EMEMD::zeroed().with_data(value),
-            );
+            self.pfalcon
+                .write_reg(regs::NV_PFALCON_FALCON_EMEMD::zeroed().with_data(value));
         }
 
         Ok(())
@@ -90,17 +96,12 @@ fn read_emem(&mut self, data: &mut [u8]) -> Result {
         }
 
         // Begin a read burst at offset `0`, auto-incrementing on each read.
-        self.bar.write(
-            WithBase::of::<Fsp>(),
-            regs::NV_PFALCON_FALCON_EMEMC::zeroed().with_aincr(true),
-        );
+        self.pfalcon
+            .write_reg(regs::NV_PFALCON_FALCON_EMEMC::zeroed().with_aincr(true));
 
         for chunk in data.chunks_exact_mut(4) {
             // Read the next 32-bit word; hardware advances the offset.
-            let value = self
-                .bar
-                .read(regs::NV_PFALCON_FALCON_EMEMD::of::<Fsp>())
-                .data();
+            let value = self.pfalcon.read(regs::NV_PFALCON_FALCON_EMEMD).data();
             chunk.copy_from_slice(&value.to_le_bytes());
         }
 
diff --git a/drivers/gpu/nova-core/falcon/gsp.rs b/drivers/gpu/nova-core/falcon/gsp.rs
index ae32f401aeb0..4c96ae325fda 100644
--- a/drivers/gpu/nova-core/falcon/gsp.rs
+++ b/drivers/gpu/nova-core/falcon/gsp.rs
@@ -2,23 +2,24 @@
 
 use kernel::{
     io::{
+        io_project,
         poll::read_poll_timeout,
-        register::{
-            RegisterBase,
-            WithBase, //
-        },
+        register,
         Io,
+        Mmio, //
     },
     prelude::*,
     time::Delta, //
 };
 
 use crate::{
+    driver::{
+        Bar0,
+        NovaRegisters, //
+    },
     falcon::{
         Falcon,
-        FalconEngine,
-        PFalcon2Base,
-        PFalconBase, //
+        FalconEngine, //
     },
     regs,
 };
@@ -26,24 +27,31 @@
 /// Type specifying the `Gsp` falcon engine. Cannot be instantiated.
 pub(crate) struct Gsp(());
 
-impl RegisterBase<PFalconBase> for Gsp {
-    const BASE: usize = 0x00110000;
-}
+register! {
+    base: NovaRegisters;
 
-impl RegisterBase<PFalcon2Base> for Gsp {
-    const BASE: usize = 0x00111000;
+    PFALCON: super::PFalconRegisters @ 0x00110000;
+    PFALCON2: super::PFalcon2Registers @ 0x00111000;
 }
 
-impl FalconEngine for Gsp {}
+impl FalconEngine for Gsp {
+    #[inline]
+    fn pfalcon(io: Bar0<'_>) -> Mmio<'_, super::PFalconRegisters> {
+        io_project!(io, build: PFALCON)
+    }
+
+    #[inline]
+    fn pfalcon2(io: Bar0<'_>) -> Mmio<'_, super::PFalcon2Registers> {
+        io_project!(io, build: PFALCON2)
+    }
+}
 
 impl<'a> Falcon<'a, Gsp> {
     /// Clears the SWGEN0 bit in the Falcon's IRQ status clear register to
     /// allow GSP to signal CPU for processing new messages in message queue.
     pub(crate) fn clear_swgen0_intr(&self) {
-        self.bar.write(
-            WithBase::of::<Gsp>(),
-            regs::NV_PFALCON_FALCON_IRQSCLR::zeroed().with_swgen0(true),
-        );
+        self.pfalcon
+            .write_reg(regs::NV_PFALCON_FALCON_IRQSCLR::zeroed().with_swgen0(true));
     }
 
     /// Checks if GSP reload/resume has completed during the boot process.
@@ -59,8 +67,8 @@ pub(crate) fn check_reload_completed(&self, timeout: Delta) -> Result<bool> {
 
     /// Returns whether the RISC-V branch privilege lockdown bit is set.
     pub(crate) fn riscv_branch_privilege_lockdown(&self) -> bool {
-        self.bar
-            .read(regs::NV_PFALCON_FALCON_HWCFG2::of::<Gsp>())
+        self.pfalcon
+            .read(regs::NV_PFALCON_FALCON_HWCFG2)
             .riscv_br_priv_lockdown()
     }
 
@@ -71,10 +79,7 @@ pub(crate) fn priv_target_mask_released(&self) -> bool {
         const LOCKED_PATTERN: u32 = 0xbadf_4100;
         const LOCKED_MASK: u32 = 0xffff_ff00;
 
-        let hwcfg2 = self
-            .bar
-            .read(regs::NV_PFALCON_FALCON_HWCFG2::of::<Gsp>())
-            .into_raw();
+        let hwcfg2 = self.pfalcon.read(regs::NV_PFALCON_FALCON_HWCFG2).into_raw();
 
         hwcfg2 != 0 && (hwcfg2 & LOCKED_MASK) != LOCKED_PATTERN
     }
diff --git a/drivers/gpu/nova-core/falcon/hal/ga102.rs b/drivers/gpu/nova-core/falcon/hal/ga102.rs
index 7600ee07ca2e..f9a8444cf840 100644
--- a/drivers/gpu/nova-core/falcon/hal/ga102.rs
+++ b/drivers/gpu/nova-core/falcon/hal/ga102.rs
@@ -6,11 +6,9 @@
     device,
     io::{
         poll::read_poll_timeout,
-        register::{
-            Array,
-            WithBase, //
-        },
-        Io, //
+        register::Array,
+        Io,
+        Mmio, //
     },
     prelude::*,
     time::Delta, //
@@ -24,6 +22,7 @@
         FalconBromParams,
         FalconEngine,
         FalconModSelAlgo,
+        PFalcon2Registers,
         PeregrineCoreSelect, //
     },
     regs,
@@ -31,17 +30,16 @@
 
 use super::FalconHal;
 
-fn select_core_ga102<E: FalconEngine>(bar: Bar0<'_>) -> Result {
-    let bcr_ctrl = bar.read(regs::NV_PRISCV_RISCV_BCR_CTRL::of::<E>());
+fn select_core_ga102(pfalcon2: Mmio<'_, PFalcon2Registers>) -> Result {
+    let bcr_ctrl = pfalcon2.read(regs::NV_PRISCV_RISCV_BCR_CTRL);
     if bcr_ctrl.core_select() != PeregrineCoreSelect::Falcon {
-        bar.write(
-            WithBase::of::<E>(),
+        pfalcon2.write_reg(
             regs::NV_PRISCV_RISCV_BCR_CTRL::zeroed().with_core_select(PeregrineCoreSelect::Falcon),
         );
 
         // TIMEOUT: falcon core should take less than 10ms to report being enabled.
         read_poll_timeout(
-            || Ok(bar.read(regs::NV_PRISCV_RISCV_BCR_CTRL::of::<E>())),
+            || Ok(pfalcon2.read(regs::NV_PRISCV_RISCV_BCR_CTRL)),
             |r| r.valid(),
             Delta::ZERO,
             Delta::from_millis(10),
@@ -86,24 +84,20 @@ fn signature_reg_fuse_version_ga102(
     Ok(u16::BITS - reg_fuse_version.leading_zeros())
 }
 
-fn program_brom_ga102<E: FalconEngine>(bar: Bar0<'_>, params: &FalconBromParams) {
-    bar.write(
-        WithBase::of::<E>().at(0),
+fn program_brom_ga102(pfalcon2: Mmio<'_, PFalcon2Registers>, params: &FalconBromParams) {
+    pfalcon2.write(
+        Array::at(0),
         regs::NV_PFALCON2_FALCON_BROM_PARAADDR::zeroed().with_value(params.pkc_data_offset),
     );
-    bar.write(
-        WithBase::of::<E>(),
+    pfalcon2.write_reg(
         regs::NV_PFALCON2_FALCON_BROM_ENGIDMASK::zeroed()
             .with_value(u32::from(params.engine_id_mask)),
     );
-    bar.write(
-        WithBase::of::<E>(),
+    pfalcon2.write_reg(
         regs::NV_PFALCON2_FALCON_BROM_CURR_UCODE_ID::zeroed().with_ucode_id(params.ucode_id),
     );
-    bar.write(
-        WithBase::of::<E>(),
-        regs::NV_PFALCON2_FALCON_MOD_SEL::zeroed().with_algo(FalconModSelAlgo::Rsa3k),
-    );
+    pfalcon2
+        .write_reg(regs::NV_PFALCON2_FALCON_MOD_SEL::zeroed().with_algo(FalconModSelAlgo::Rsa3k));
 }
 
 pub(super) struct Ga102<E: FalconEngine>(PhantomData<E>);
@@ -116,7 +110,7 @@ pub(super) fn new() -> Self {
 
 impl<E: FalconEngine> FalconHal<E> for Ga102<E> {
     fn select_core(&self, falcon: &Falcon<'_, E>) -> Result {
-        select_core_ga102::<E>(falcon.bar)
+        select_core_ga102(falcon.pfalcon2)
     }
 
     fn signature_reg_fuse_version(
@@ -129,27 +123,24 @@ fn signature_reg_fuse_version(
     }
 
     fn program_brom(&self, falcon: &Falcon<'_, E>, params: &FalconBromParams) {
-        program_brom_ga102::<E>(falcon.bar, params);
+        program_brom_ga102(falcon.pfalcon2, params);
     }
 
     fn is_riscv_active(&self, falcon: &Falcon<'_, E>) -> bool {
         falcon
-            .bar
-            .read(regs::NV_PRISCV_RISCV_CPUCTL::of::<E>())
+            .pfalcon2
+            .read(regs::NV_PRISCV_RISCV_CPUCTL)
             .active_stat()
     }
 
     fn is_riscv_halted(&self, falcon: &Falcon<'_, E>) -> Result<bool> {
-        Ok(falcon
-            .bar
-            .read(regs::NV_PRISCV_RISCV_CPUCTL::of::<E>())
-            .halted())
+        Ok(falcon.pfalcon2.read(regs::NV_PRISCV_RISCV_CPUCTL).halted())
     }
 
     fn reset_wait_mem_scrubbing(&self, falcon: &Falcon<'_, E>) -> Result {
         // TIMEOUT: memory scrubbing should complete in less than 20ms.
         read_poll_timeout(
-            || Ok(falcon.bar.read(regs::NV_PFALCON_FALCON_HWCFG2::of::<E>())),
+            || Ok(falcon.pfalcon.read(regs::NV_PFALCON_FALCON_HWCFG2)),
             |r| r.mem_scrubbing_done(),
             Delta::ZERO,
             Delta::from_millis(20),
@@ -158,20 +149,18 @@ fn reset_wait_mem_scrubbing(&self, falcon: &Falcon<'_, E>) -> Result {
     }
 
     fn reset_eng(&self, falcon: &Falcon<'_, E>) -> Result {
-        let bar = falcon.bar;
-
-        let _ = bar.read(regs::NV_PFALCON_FALCON_HWCFG2::of::<E>());
+        let _ = falcon.pfalcon.read(regs::NV_PFALCON_FALCON_HWCFG2);
 
         // According to OpenRM's `kflcnPreResetWait_GA102` documentation, HW sometimes does not set
         // RESET_READY so a non-failing timeout is used.
         let _ = read_poll_timeout(
-            || Ok(bar.read(regs::NV_PFALCON_FALCON_HWCFG2::of::<E>())),
+            || Ok(falcon.pfalcon.read(regs::NV_PFALCON_FALCON_HWCFG2)),
             |r| r.reset_ready(),
             Delta::ZERO,
             Delta::from_micros(150),
         );
 
-        regs::NV_PFALCON_FALCON_ENGINE::reset_engine::<E>(bar);
+        regs::NV_PFALCON_FALCON_ENGINE::reset_engine(falcon.pfalcon);
         self.reset_wait_mem_scrubbing(falcon)?;
 
         Ok(())
diff --git a/drivers/gpu/nova-core/falcon/hal/tu102.rs b/drivers/gpu/nova-core/falcon/hal/tu102.rs
index 5291598fedf7..7fc6e83c2566 100644
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
@@ -50,8 +49,8 @@ fn program_brom(&self, _falcon: &Falcon<'_, E>, _params: &FalconBromParams) {}
 
     fn is_riscv_active(&self, falcon: &Falcon<'_, E>) -> bool {
         falcon
-            .bar
-            .read(regs::NV_PRISCV_RISCV_CORE_SWITCH_RISCV_STATUS::of::<E>())
+            .pfalcon2
+            .read(regs::NV_PRISCV_RISCV_CORE_SWITCH_RISCV_STATUS)
             .active_stat()
     }
 
@@ -62,7 +61,7 @@ fn is_riscv_halted(&self, _falcon: &Falcon<'_, E>) -> Result<bool> {
     fn reset_wait_mem_scrubbing(&self, falcon: &Falcon<'_, E>) -> Result {
         // TIMEOUT: memory scrubbing should complete in less than 10ms.
         read_poll_timeout(
-            || Ok(falcon.bar.read(regs::NV_PFALCON_FALCON_DMACTL::of::<E>())),
+            || Ok(falcon.pfalcon.read(regs::NV_PFALCON_FALCON_DMACTL)),
             |r| r.mem_scrubbing_done(),
             Delta::ZERO,
             Delta::from_millis(10),
@@ -71,7 +70,7 @@ fn reset_wait_mem_scrubbing(&self, falcon: &Falcon<'_, E>) -> Result {
     }
 
     fn reset_eng(&self, falcon: &Falcon<'_, E>) -> Result {
-        regs::NV_PFALCON_FALCON_ENGINE::reset_engine::<E>(falcon.bar);
+        regs::NV_PFALCON_FALCON_ENGINE::reset_engine(falcon.pfalcon);
         self.reset_wait_mem_scrubbing(falcon)?;
 
         Ok(())
diff --git a/drivers/gpu/nova-core/falcon/sec2.rs b/drivers/gpu/nova-core/falcon/sec2.rs
index 91ec7d49c1f5..6648a397d38a 100644
--- a/drivers/gpu/nova-core/falcon/sec2.rs
+++ b/drivers/gpu/nova-core/falcon/sec2.rs
@@ -1,22 +1,37 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use kernel::io::register::RegisterBase;
+use kernel::io::{
+    io_project,
+    register,
+    Mmio, //
+};
 
-use crate::falcon::{
-    FalconEngine,
-    PFalcon2Base,
-    PFalconBase, //
+use crate::{
+    driver::{
+        Bar0,
+        NovaRegisters, //
+    },
+    falcon::FalconEngine, //
 };
 
 /// Type specifying the `Sec2` falcon engine. Cannot be instantiated.
 pub(crate) struct Sec2(());
 
-impl RegisterBase<PFalconBase> for Sec2 {
-    const BASE: usize = 0x00840000;
-}
+register! {
+    base: NovaRegisters;
 
-impl RegisterBase<PFalcon2Base> for Sec2 {
-    const BASE: usize = 0x00841000;
+    PFALCON: super::PFalconRegisters @ 0x00840000;
+    PFALCON2: super::PFalcon2Registers @ 0x00841000;
 }
 
-impl FalconEngine for Sec2 {}
+impl FalconEngine for Sec2 {
+    #[inline]
+    fn pfalcon(io: Bar0<'_>) -> Mmio<'_, super::PFalconRegisters> {
+        io_project!(io, build: PFALCON)
+    }
+
+    #[inline]
+    fn pfalcon2(io: Bar0<'_>) -> Mmio<'_, super::PFalcon2Registers> {
+        io_project!(io, build: PFALCON2)
+    }
+}
diff --git a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
index ec4d92317a93..02a36fd59902 100644
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
@@ -23,7 +26,6 @@
 };
 
 use crate::{
-    driver::Bar0,
     falcon::{
         self,
         gsp::Gsp,
@@ -235,12 +237,7 @@ pub(crate) fn new(
     ///
     /// The bootloader will load the FWSEC firmware and then execute it. This function returns
     /// after FWSEC has reached completion.
-    pub(crate) fn run(
-        &self,
-        dev: &Device<device::Bound>,
-        falcon: &Falcon<'_, Gsp>,
-        bar: Bar0<'_>,
-    ) -> Result<()> {
+    pub(crate) fn run(&self, dev: &Device<device::Bound>, falcon: &Falcon<'_, Gsp>) -> Result<()> {
         // Reset falcon, load the firmware, and run it.
         falcon
             .reset()
@@ -250,9 +247,8 @@ pub(crate) fn run(
             .inspect_err(|e| dev_err!(dev, "Failed to load FWSEC firmware: {:?}\n", e))?;
 
         // Configure DMA index for the bootloader to fetch the FWSEC firmware from system memory.
-        bar.update(
-            regs::NV_PFALCON_FBIF_TRANSCFG::of::<Gsp>()
-                .try_at(usize::from_safe_cast(self.dmem_desc.ctx_dma))
+        falcon.pfalcon.update(
+            regs::NV_PFALCON_FBIF_TRANSCFG::try_at(usize::from_safe_cast(self.dmem_desc.ctx_dma))
                 .ok_or(EINVAL)?,
             |v| {
                 v.with_target(FalconFbifTarget::CoherentSysmem)
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index a5c0ca355493..d2ef35080689 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -62,12 +62,11 @@ impl FwsecUnloadFirmware {
     fn run(
         &self,
         dev: &device::Device<device::Bound>,
-        bar: Bar0<'_>,
         gsp_falcon: &Falcon<'_, GspEngine>,
     ) -> Result {
         match self {
             Self::WithoutBl(fw) => fw.run(dev, gsp_falcon),
-            Self::WithBl(fw) => fw.run(dev, gsp_falcon, bar),
+            Self::WithBl(fw) => fw.run(dev, gsp_falcon),
         }
     }
 }
@@ -88,7 +87,7 @@ fn run(&self, ctx: &mut GspBootContext<'_, '_>) -> Result {
         // Log errors but keep going if it fails.
         let fwsec_sb_res = self
             .fwsec_sb
-            .run(dev, bar, ctx.gsp_falcon)
+            .run(dev, ctx.gsp_falcon)
             .inspect_err(|e| dev_err!(dev, "FWSEC-SB failed to run: {:?}\n", e));
 
         // Remove WPR2 region if set.
@@ -168,7 +167,7 @@ fn run_fwsec_frts(
         if self.needs_fwsec_bootloader {
             let fwsec_frts_bl = FwsecFirmwareWithBl::new(fwsec_frts, dev, chipset)?;
             // Load and run the bootloader, which will load FWSEC-FRTS and run it.
-            fwsec_frts_bl.run(dev, falcon, bar)?;
+            fwsec_frts_bl.run(dev, falcon)?;
         } else {
             // Load and run FWSEC-FRTS directly.
             fwsec_frts.run(dev, falcon)?;
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 1af073f3861f..90ac8dac5349 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -4,8 +4,8 @@
 use kernel::{
     io::{
         register,
-        register::WithBase,
-        Io, //
+        Io,
+        Mmio, //
     },
     prelude::*,
     sizes::SizeConstants,
@@ -13,22 +13,18 @@
 };
 
 use crate::{
-    driver::{
-        Bar0,
-        NovaRegisters, //
-    },
+    driver::NovaRegisters,
     falcon::{
         DmaTrfCmdSize,
         FalconCoreRev,
         FalconCoreRevSubversion,
-        FalconEngine,
         FalconFbifMemType,
         FalconFbifTarget,
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
@@ -202,32 +198,32 @@ pub(crate) fn usable_fb_size(self) -> u64 {
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
@@ -237,17 +233,17 @@ pub(crate) fn usable_fb_size(self) -> u64 {
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
@@ -255,15 +251,15 @@ pub(crate) fn usable_fb_size(self) -> u64 {
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
@@ -274,15 +270,15 @@ pub(crate) fn usable_fb_size(self) -> u64 {
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
@@ -291,12 +287,12 @@ pub(crate) fn usable_fb_size(self) -> u64 {
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
@@ -307,17 +303,17 @@ pub(crate) fn usable_fb_size(self) -> u64 {
 
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
@@ -326,29 +322,29 @@ pub(crate) fn usable_fb_size(self) -> u64 {
 
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
@@ -359,7 +355,7 @@ pub(crate) fn usable_fb_size(self) -> u64 {
         25:25   aincr => bool;
     }
 
-    pub(crate) NV_PFALCON_FALCON_EMEMD(u32) @ PFalconBase + 0x00000ac4 {
+    pub(crate) NV_PFALCON_FALCON_EMEMD(u32) @ 0x00000ac4 {
         31:0    data => u32;
     }
 }
@@ -385,13 +381,13 @@ pub(crate) fn with_falcon_mem(self, mem: FalconMem) -> Self {
 
 impl NV_PFALCON_FALCON_ENGINE {
     /// Resets the falcon
-    pub(crate) fn reset_engine<E: FalconEngine>(bar: Bar0<'_>) {
-        bar.update(Self::of::<E>(), |r| r.with_reset(true));
+    pub(crate) fn reset_engine(pfalcon: Mmio<'_, PFalconRegisters>) {
+        pfalcon.update(NV_PFALCON_FALCON_ENGINE, |r| r.with_reset(true));
 
         // TIMEOUT: falcon engine should not take more than 10us to reset.
         time::delay::fsleep(time::Delta::from_micros(10));
 
-        bar.update(Self::of::<E>(), |r| r.with_reset(false));
+        pfalcon.update(NV_PFALCON_FALCON_ENGINE, |r| r.with_reset(false));
     }
 }
 
@@ -405,23 +401,23 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
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
@@ -429,23 +425,23 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
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
         4:4     halted => bool;
     }
 
     /// GA102 and later.
-    pub(crate) NV_PRISCV_RISCV_BCR_CTRL(u32) @ PFalcon2Base + 0x00000668 {
+    pub(crate) NV_PRISCV_RISCV_BCR_CTRL(u32) @ 0x00000668 {
         8:8     br_fetch => bool;
         4:4     core_select => PeregrineCoreSelect;
         0:0     valid => bool;

-- 
2.54.0

