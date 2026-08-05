Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021089.outbound.protection.outlook.com [52.101.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E0A485509;
	Wed,  5 Aug 2026 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947838; cv=fail; b=qsvKY8QVOs3F0wNympT9X8Okz1p3pmY/evH1fqNas7kBhn9V48mugDs2A0E9GoVGJXxrxXXx8qf30KDVdcGd3k0wPmfk++Mfy+A+7/oLi2xzZVJ4M2xLE8cN7+Ymy1FAEWWQbKBl5L/pECn57fF/UwMfra40aRfuRdFZQcMS4SE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947838; c=relaxed/simple;
	bh=/Y4Qgsj/Y8MasF5B1mbDGsToiwgqsiI1N94mauL0kok=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oqIvjFe28RqqZU+JZBt3DhLiwbHRhIhCgfTmK/Bc1lbsaLWuWgg5Zn6eStWTkv6Mr2AetppKfw+WFsRKvh0gjodWu3hN4bC0/AjXrG2TDPUhb7zTvV63LHmLSCGfDWc8hS4Uu20OvH4qOAN4Z5NUCQfhWeWnjA864SNT8Hfdzek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=tAR+fkpL; arc=fail smtp.client-ip=52.101.100.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="tAR+fkpL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUw+IXHQEZAtNzfabTvQbhADVbMkmsE09CW8iqzuy5t+VGzk39v972F0J7dLqW5tXRwRQaBRXy7GwGkkP6nYK4pkrr/tqB4CcbapZvfyOYR2ItGTlJu5qmDSHSi2uziLx8zoJYnxg4FlDyrvTJ28f+uPow8f0ZyFG/lRC7KIh8693yi+YBfoqsyVkzEEl7KCb5quExtMpMCn8U0qU3ahIMkIuG99p3ngsMOnuUduas+mslbxJlM2Hg7/eX03An7DVXwsoMHwvWYGmHctRTXdHI9kDpCWs3gji3ZG+1YxRfjPW+TBhcKcSlbm1HZh9SIGyecnnWt26IiNBLoTUW73yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpOgwqfwG2ALHBZLncL3EvBmfEKgtwaKyEwKgrS0t30=;
 b=bv67utsBcXV/hQ/MPpKWdBPXd3wjbWYCGhvKFkXA7t9gRHINPbAv+8c7lCpI3qcdyx6A1vDPYBgj4OC+iVRSqOkaVxpEhYPRSIIznUBx70BxITQFK2AEJcK0PEwaywerCerekMtctoZnDv2062WrkpedjzySm7xmrFd8x6RCQp2Cr9yhm6H7fxTSYTGWbGGgdPvRacXQNAWoheTt1eJ0L5isz07+tvxmqQsTIQ4iLPA5Ug/Q7BKkjgvkacAR9beiq1KPPWwJffsOg2azLR3m8TFfAUGNs3GburHq++FOhR4v3/7s0K1EIEiJnnasNRhxqZo3cfnvBTqyyVIteXiekQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpOgwqfwG2ALHBZLncL3EvBmfEKgtwaKyEwKgrS0t30=;
 b=tAR+fkpLRyvxH/3bVKstorwXRukHGpuhFPniymr1HnRConsfUmsRqYz9AGE54e6WY/ENgefHOkMeJfrJoyMeYW9/0WGZeRM5jtgenSLfb4HW7hZO9elLmsJCIgZPK7fDIcLKvKWnBxD3PgwLIlMxea2lmLTcOYSvqYx/8JHkZQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by LO2P265MB5822.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:26c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 16:37:03 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 16:37:03 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 05 Aug 2026 17:35:48 +0100
Subject: [PATCH v2 05/16] rust: io: register extract offset computation to
 helper rules
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-typed_register-v2-5-c3ca142220a0@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785947818; l=8026;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=/Y4Qgsj/Y8MasF5B1mbDGsToiwgqsiI1N94mauL0kok=;
 b=XmX+oOXv+MF84OhTi5qjVDM/+YZ/NIYICmMupYdyw9pnssh0KYk6Wgm+eQim9zPXcBK0nrmbX
 M1DUEEOc07TDfbFSWs9sJw3OictNrYyexwVWDXa6yK/Songml9lmbVA
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
X-MS-Office365-Filtering-Correlation-Id: e5d27585-ece3-4ef9-c431-08def30fc796
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|1800799024|376014|23010399003|366016|22082099003|18002099003|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	TR+audOBpEfV6wEAZumXtK4C40PrS49RxqQcFvvVudKwXwDQNo4VIlauOgx/sHIr/YQFhxwN7KlwEzJhSfxRkrLqK19JnIxDxLp6YCuRGnr1ACy9rwQ1QwQKUMmPi6HJtO6ngGQUcuVBE3lXDWj/VI8RrgeuDg6Q5HL21+GL7yyhyRxorZSdDtWh+tR8nJnThwzEAshK0niQmj/cPlxoIi8SYDUUVhgpWyLR8XPISrW1BOpuQsyup31rQdcPpTe6pAqqlPKcnR9tiPmW7Zg8wi54etphGNxBrBBTppgrS4TnbM29hW7gzF0l1nFeBaEUls0/ocpPFxi0uNMy+FtC0ZJqM09CLG9czx3PjjFfSDAqzyq6/265LoDNGDS2o6VQf+R31fbA/zNTRkYtIODWnVnFflEL1EtqDNLY9OaajvCXck5UBJKAIcrL2l2VME1Ixa/bwRoWJHF+7koswj5OxVjvuxlF7slRbuzU4Wtn+5HNumLljjc6m2RPz+XMDXv1aPnpG0OJ3D0UADMNIp6q/Iqm8n8d84lhRlB8rcnRlp9Aj+GCzHYz4P1kG2PJ4qD8c3w/2yMNbodvlR2HIoJ6apHCw3iyas1gBSYHjw/6zqPABW8pReeMG6vSzxFh7cjXcyr4UsspQkIbr4636W5rFF+ZygM/lwU8p4KmwAjgBkqiU0zq2qGDudGDSgQhwuIv+1A86YP7t1P4Tq0NvRgLqA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3V1WmtOSDlkNGNGMVh4QStyN0VXTmE3Q2IwWHpkalFPeW9rNmRvRE1KaElW?=
 =?utf-8?B?dEJmOUpmTXhkZTl3N2JYQWloclNwOXNjQzVIbS9uL1dTcDFlejNmRmtIR0I1?=
 =?utf-8?B?SXJaaVdzRFRaQUdmL2NKQ3hPQlpnMHJVV2NxZ2FjQm1rNSszVWwyOEVtT3lM?=
 =?utf-8?B?VW1HYUNIS3k4cjZkQ0dxdUM4L3cwdytiOVFaVGhyQkhRVDZOWk1wU1lFTnNy?=
 =?utf-8?B?M2lpQjl2SStFYWMya09BOElKKy9hM3F4bndBb2hDVzBTNUFDUUN3aVRtTGl0?=
 =?utf-8?B?eWNQQ1hiUjQvOFp1U21wMzF3Qkhlb3gvZVdKUE83OU1XaFFFK3prTG1yTVhq?=
 =?utf-8?B?MmNJV1NOTXMzRnFFQmQzNC9BOXhmMjZxSitURlhQcW9SbC9GZUJ2RE1NWGgz?=
 =?utf-8?B?TjJxcEZVTjhxdExHbTJRTWIwTHRBZSs3SEtWVC9hWW02T3VGYXRodFRxVHdO?=
 =?utf-8?B?UGJ2MjJHd1N3K3QyWTJoSDIzOVRhUmVLTWwwWExubU0zQkJ6NWNOQ1kzK1d5?=
 =?utf-8?B?NEIwRDhCemkrd2crSUgxcHM3UWptbmNLWXN6emhENDFWMldSelo5VkREd2J5?=
 =?utf-8?B?dnR6Zjg2M1JscE1rS1J6Y3IwajcyMXp2UE9lQ215SHA5dy9TNFRtYXdNOWZ2?=
 =?utf-8?B?cGE5d05JUjZRSURQWDh1K2VZMkpER01WY2g2T1hFVWNGdzhobFpNc3daWkdo?=
 =?utf-8?B?Mlk0SjFEME0xN1ZyY3AzWXNkRzZKSGs3OXp5UEtLT0lUaEptWG1ocGZjQXM3?=
 =?utf-8?B?Y2FTYno2K2h6WTByc3p0OS9DVFVrSUtKYWFCTFFWTEE5cnNBTUVnRVk2YlNv?=
 =?utf-8?B?WDI0TjZWRGpxaWVidDc0K1VWRXVtTi9YUTA4MFJ0cXJrT0ZRL3RrNG02c0NE?=
 =?utf-8?B?UVFlSzdPbmVRZFJTMjRxV3ZKNmtJTU9QeHI5YzNoQXUydkhpL05HczNob05t?=
 =?utf-8?B?UURmZitIL0xEUkZjTmc0SXM2YjBQSmFndS9iMlN5aEtUdU5ueGFiYmJDa3lD?=
 =?utf-8?B?bjRNcWlZTkZFOGEranVpRjBiTVY1dyt5dDBGRlQ2Lzh1YjBsWTk4emFJK2V5?=
 =?utf-8?B?MG5FTGlOWkRraDBWQXZQSW1YaVhsQ1gvR1kwMTYwbVhNd1QwZ1czcitMRmd0?=
 =?utf-8?B?bXVQczRHZzVwUW9LUlptSUJIekNESUFNNGtLVUxVWm1YYWNzUUd5UW1McG52?=
 =?utf-8?B?VmN1UFRnNlg5enVGU3BIOVJHZXF5a2tDbnI1aHZUYk9oSTAwOFp6N3FWOHRF?=
 =?utf-8?B?aFNab3l0MmJwVExBZ29YZm9DRVR2dmhRdWNXSWZGNEZpUnFqb0wzUVZsVklT?=
 =?utf-8?B?SnZYYXRjZ2JYKzQvS3I0TjhFYU5NYmZWNnVZbmJlYWF4RkpzNVBiS1dIOUhl?=
 =?utf-8?B?b016TVpWelJiRTZCeFJDSmgrelRaNkZvb0Qvc2VodFB0U3RjWmFqWTJ5Um9U?=
 =?utf-8?B?VmE1UUhkdFNpNktEWExrWDlBenFUSE5GOFdXZGppSkhjYUN3YkY5Z0N1clY0?=
 =?utf-8?B?YmxXeGJKTU9jY0R6d3UwWWNQazlmM3F1WmR1SS9INWgvM3RBUEx5U2w4djN6?=
 =?utf-8?B?K3M5V3pWbHpCSU1CZU5iVml1ejk4V0VzdzJ5MHppUVRiZFdPYVpwRklaNGF5?=
 =?utf-8?B?UldDR1FtYm8vOEUwTlZNRmhKNWR1RjZ5aDJqT3JtUHFWUVJ4STRJVm5IbnJS?=
 =?utf-8?B?U1pUWDl4Rk5LclQ2aE9uN2ZTaXJHeG80R1pUTlRWUkdLZERiWWpqQ2c4V0VX?=
 =?utf-8?B?S3IvN24zMlNaek1kRS9hTnozTDBjSWxOMmlmTFIrL0x1OXdYV3pUc2VqMDU4?=
 =?utf-8?B?ejFkanVCd1AzeUxRbGpROC9IVDl5dWRSU3FERXVtcDB5QVB2NHZTcFhFcUU0?=
 =?utf-8?B?VGRhZHR1dEk2Y1JvT1U5bUJnSzZFalhoR2pOTzduei84azdFaTNIQk5LNC9q?=
 =?utf-8?B?dGV2NzdjdW01SGJIQ2pKU2hUTS9vZWVuVWhxaWEwdHlNMGFQQWlBcjh1aDZ3?=
 =?utf-8?B?dXZKZGlCanIwTGlVM21YWWFMYXBGRUczKzJaSkRpT0pXNFV6QzVmRHlXSkg1?=
 =?utf-8?B?QmlEcEx3TlZ2TSs1ZFp6Q0YwelcraXlSS3d0RVdOYm55WlpIaGRGenhJWE9X?=
 =?utf-8?B?L01jamFtd3BWb0VCdTN4WWZVRmNGc09iZHN4bXl4a0ZjKzAyNHR4Wm9UNEgz?=
 =?utf-8?B?eXJucTNBZGRMdHFaa2MrYkRrQkNvMGZCUTIvOG1Ydyt6dFZtZDhIbXlESTlB?=
 =?utf-8?B?Vm9qeGFmdDBTU3dxT2tJcXdibFU3NHpld1FiK0N3OFFvakFweS9oMlRCT0w5?=
 =?utf-8?B?KzZXenJTTmh4Z0RiUktYWE43YjFDcWJvbDc2ZGFmdVhvNENpeC9GUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d27585-ece3-4ef9-c431-08def30fc796
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 16:37:03.2906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a7lC8j2pqPv48dOWFUXZICjLYAm21XyYTh6MKy0VsW0y4HY8yAri7LJEHMrBZHTzAg/yr88xx6mv2Nuef8+80Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5822

Create a helper rule for register offset computation so there can be a
single rule for fixed offset registers.

Similarly, extract stride computation to helper rules.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io/register.rs | 115 ++++++++++++++-------------------------------
 1 file changed, 36 insertions(+), 79 deletions(-)

diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index 91804c1ca117..e4039e31b4e7 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -789,27 +789,19 @@ macro_rules! register {
     () => {};
 
     // Creates a register at a fixed offset of the MMIO space.
+    //
+    // This handles all of the fixed offset `@ offset`, alias of register `=> alias` and alias of
+    // register array element `=> alias[idx]` cases.
     (
-        $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) @ $offset:literal
-            { $($fields:tt)* }
-        $($rest:tt)*
-    ) => {
-        $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(@io_base $name @ $offset);
-        $crate::register!(@io_fixed $(#[$attr])* $vis $name);
-        $crate::register!($($rest)*);
-    };
-
-    // Creates an alias register of fixed offset register `alias` with its own fields.
-    (
-        $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) => $alias:ident
-            { $($fields:tt)* }
+        $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
+            $(@ $offset:literal)?
+            $(=> $alias:path $([$alias_idx:expr])? )?
+        { $($fields:tt)* }
         $($rest:tt)*
     ) => {
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(
-            @io_base $name @
-            <$alias as $crate::io::register::Register>::OFFSET
+        $crate::register!(@io_base $name
+            @ $crate::register!(@offset $(@ $offset)? $(=> $alias $([$alias_idx])?)?)
         );
         $crate::register!(@io_fixed $(#[$attr])* $vis $name);
         $crate::register!($($rest)*);
@@ -834,9 +826,7 @@ macro_rules! register {
         $($rest:tt)*
     ) => {
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(
-            @io_base $name @ <$alias as $crate::io::register::Register>::OFFSET
-        );
+        $crate::register!(@io_base $name @ $crate::register!(@offset => $alias));
         $crate::register!(@io_relative $vis $name @ $base);
         $crate::register!($($rest)*);
     };
@@ -844,76 +834,28 @@ macro_rules! register {
     // Creates an array of registers at a fixed offset of the MMIO space.
     (
         $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
-            [ $size:expr, stride = $stride:expr ] @ $offset:literal { $($fields:tt)* }
+            [ $size:expr $(, stride = $stride:expr)? ] @ $offset:literal { $($fields:tt)* }
         $($rest:tt)*
     ) => {
-        $crate::build_assert::static_assert!(::core::mem::size_of::<$storage>() <= $stride);
-
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
         $crate::register!(@io_base $name @ $offset);
-        $crate::register!(@io_array $vis $name [ $size, stride = $stride ]);
-        $crate::register!($($rest)*);
-    };
-
-    // Shortcut for contiguous array of registers (stride == size of element).
-    (
-        $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) [ $size:expr ] @ $offset:literal
-            { $($fields:tt)* }
-        $($rest:tt)*
-    ) => {
-        $crate::register!(
-            $(#[$attr])* $vis $name($storage) [ $size, stride = ::core::mem::size_of::<$storage>() ]
-                @ $offset { $($fields)* }
-        );
-        $crate::register!($($rest)*);
-    };
-
-    // Creates an alias of register `idx` of array of registers `alias` with its own fields.
-    (
-        $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) => $alias:ident [ $idx:expr ]
-            { $($fields:tt)* }
-        $($rest:tt)*
-    ) => {
-        $crate::build_assert::static_assert!(
-            $idx < <$alias as $crate::io::register::RegisterArray>::SIZE
+        $crate::register!(@io_array $vis $name
+            [ $size, stride = $crate::register!(@stride $storage $(, $stride)?) ]
         );
-
-        $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(
-            @io_base $name @
-            <$alias as $crate::io::register::Register>::OFFSET
-                + $idx * <$alias as $crate::io::register::RegisterArray>::STRIDE
-        );
-        $crate::register!(@io_fixed $(#[$attr])* $vis $name);
         $crate::register!($($rest)*);
     };
 
     // Creates an array of registers at a relative offset from a base address provider.
     (
         $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
-            [ $size:expr, stride = $stride:expr ]
+            [ $size:expr $(, stride = $stride:expr)? ]
             @ $base:ident + $offset:literal { $($fields:tt)* }
         $($rest:tt)*
     ) => {
-        $crate::build_assert::static_assert!(::core::mem::size_of::<$storage>() <= $stride);
-
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
         $crate::register!(@io_base $name @ $offset);
-        $crate::register!(
-            @io_relative_array $vis $name [ $size, stride = $stride ] @ $base + $offset
-        );
-        $crate::register!($($rest)*);
-    };
-
-    // Shortcut for contiguous array of relative registers (stride == size of element).
-    (
-        $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) [ $size:expr ]
-            @ $base:ident + $offset:literal { $($fields:tt)* }
-        $($rest:tt)*
-    ) => {
-        $crate::register!(
-            $(#[$attr])* $vis $name($storage) [ $size, stride = ::core::mem::size_of::<$storage>() ]
-                @ $base + $offset { $($fields)* }
+        $crate::register!(@io_relative_array $vis $name
+            [ $size, stride = $crate::register!(@stride $storage $(, $stride)?) ] @ $base + $offset
         );
         $crate::register!($($rest)*);
     };
@@ -930,11 +872,7 @@ macro_rules! register {
         );
 
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(
-            @io_base $name @
-                <$alias as $crate::io::register::Register>::OFFSET +
-                $idx * <$alias as $crate::io::register::RegisterArray>::STRIDE
-        );
+        $crate::register!(@io_base $name @ $crate::register!(@offset => $alias [$idx]));
         $crate::register!(@io_relative $vis $name @ $base);
         $crate::register!($($rest)*);
     };
@@ -954,6 +892,25 @@ macro_rules! register {
         );
     };
 
+    // Offset computation helper rules.
+    (@offset @ $offset:expr) => { $offset };
+    (@offset => $alias:path) => { <$alias as $crate::io::register::Register>::OFFSET };
+    (@offset => $alias:path [$idx:expr]) => {{
+        $crate::build_assert::static_assert!(
+            $idx < <$alias as $crate::io::register::RegisterArray>::SIZE
+        );
+
+        <$alias as $crate::io::register::Register>::OFFSET +
+            $idx * <$alias as $crate::io::register::RegisterArray>::STRIDE
+    }};
+
+    // Stride computation helper rules.
+    (@stride $ty: ty, $stride: expr) => {{
+        $crate::build_assert::static_assert!(::core::mem::size_of::<$ty>() <= $stride);
+        $stride
+    }};
+    (@stride $ty: ty) => { ::core::mem::size_of::<$ty>() };
+
     // Implementations shared by all registers types.
     (@io_base $name:ident @ $offset:expr) => {
         impl $crate::io::register::Register for $name {

-- 
2.54.0

