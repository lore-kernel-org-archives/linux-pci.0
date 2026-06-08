Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020099.outbound.protection.outlook.com [52.101.195.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595FE3EE1D1;
	Mon,  8 Jun 2026 19:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948774; cv=fail; b=TKhgzMrhgRlf9nFQgtix4q/WnSSG/e4UHcXfC8pxuQ45joKgMMT6neuVULQBew4FyocWVK1LSGpLvs9pOHKMZ9/ZknpcRoVTt9leJaWGB2ibnQo0LA+EtkwglZUcW3FNzPORHLUNODa7Q21MlFydGaZp2b/6Gl5GT7CWcuaDkcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948774; c=relaxed/simple;
	bh=vcdMQc7L2X5q7MLzsjeBdjUYKsKn42hZ7KuZ3sc3al0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GQ40QgIEiJlKR/oNTdQiS68VdO7YOwV6s6EuVunLAA+zLXH3mhu1onlmo2KEprs6YT2c4p16rgjSrxMHuyBZN7knCIrpAP4JdzgOqmu9xrt8Zo41yRhmuIMIOCzsRahK4FaAKxd4FmFhsLbPyY/Fwjc9D5MZywDXB+47PYJN3xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=x3UsNviq; arc=fail smtp.client-ip=52.101.195.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="x3UsNviq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNJtqD1/1/r0RMy2Xk1KVO2n99bQsYANthjNRPBnNE0k5wpCNLEPVdHerC9Sadk4NQpNGcqBMwS726mNxVObyyfqtk6Wzq6KMSxnUQgHSh2i1xhtKdjnJPf7B/McnCMJ+9p0Tt93qoKy4l4vLYXjL3dbrrzKQjBWl8QGdG54POxVWomgZyCueG9Rf7NqZUpbVYfzrFS2mTXIFgu+Wnylnk96VpsMlL+muLsRGdDF/Fyon02hGjf0yEIkbJcNEyplvt+UrPLL+TNZDEsIEUQPP0OGqjMTMm2wQEh7zVfnv2g296TvQsPCF4wzw7P/BOoxJiaTmxLVYaJhV97jCEF1xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60pCk675gSeThQ+AfPYkQPgXU+UzSOf56AMAw7q5jX4=;
 b=U22NRLwjs+9fYjkynyVb4qQNiROGlLuWE982B05wjvAormyVn+Q1RzF93ZyMSkG/teCCO5U6OEUKQG45uuB1iRigr2OwB8c+nDa6x3juMKZp9qsKSTja/Zw8cx9MNCWJjt0u7h3dDyGXOZpUqG206SgcZUtv1qo0JBUfI9ZX86DN436B2R+Hbm0DhP/l5xsznmxKDtlajDb7thfqlN9xyJJK2Nlh+rmRtcsPVqNeCyEbDW/sGlOr48gT9l8vADOPN6BAnpY44xt9B5eQ77K26vCcHIFb/MttxYRbfmcy/v+IIeoyhOJMkRXAgPTtACozPRWnxbJRrpAG3cSCAPqYLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60pCk675gSeThQ+AfPYkQPgXU+UzSOf56AMAw7q5jX4=;
 b=x3UsNviqzyTPkZw1VaL1tsESGOm2dWaochFGI3bmy69igCmULrNhURq74uK7sxsQN1yADa79jvnNEMWmW/f5v7qhz3NGkQNYH2u1BAaN0eP4xbMENAGesv5XFlb4VA151DDmtRiXpTD+c/8uqNYtE4HuMgQrMoD9oRAsE3aU++8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7398.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 19:59:13 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 19:59:13 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 08 Jun 2026 20:59:10 +0100
Subject: [PATCH v3 13/19] rust: io: add I/O backend for system memory with
 volatile access
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-io_projection-v3-13-c5cde13a5ec4@garyguo.net>
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
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Laura Nao <laura.nao@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780948747; l=4994;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=9tXIYsADs8wwgk9tZU6LAmTg0OnAqj70/WkBdSauC6E=;
 b=Pizf4d1BKQIL+ItdyguqRWkUG2+FpQ59YDsHmPTOqFM/j2agWf9CsR6VLP/ej+ClTBbYDdTY4
 zJGMBft+ZLlAGpUWgkpLp5S9CfeaV+QP2s2h/WnLnt5ZXHkjEAjdJxX
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
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO8P265MB7398:EE_
X-MS-Office365-Filtering-Correlation-Id: af7b434e-9c57-42be-2ffa-08dec59869a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|6133799003|22082099003|18002099003|921020|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	Xq/2kDgZXFAZZm3TuyrnLAGCmfqwX5ntx7JUrER58klqv2ptczIz1pMREpF0bUegaaPxSJffWCBAcRGoHXiNAw4+LSDbZyYaUi79scrR2SwCMdmDodFyNj4m6bZZ9mlOu1Rp0FyNSO4KMJiYKzmmYl1LlzFRvOojCQZGTQSTrLUcSi0a6pLcRkJUcc9/b61HNDp3jKvkFZVdXnx1OZCTXaXDav98pE6qTd3OBo5Qhvn4VLgvML+vmfdInSrptZJlo9CpfAoz97JyZ6UWHqDn3A5hA31qAxw052dl1k/eK9JEwJ/i0/lTQNFuyQw9vcp+79SHtL61ojPHhfVqjq+Ps2GfyqcVbG9W+KlAfbnhzZV7nJfyit5YhVCWJn0bwi2JX0+I0OzWABrpS0ba0mOlhBCqsucIQNALJktuTL/mKrxCM4yXnwaPl1RQO4hsvbVfeY4z7oq+jDGvcBF4NxTdB0G2v/78LhdF6uAO59aOsaXJO+fG23Bo70IRvxTcPpiJGi3plpdTKOMgHvO3FbQJ7VevYnrUGRB6wA3KYXQ3tBPn7HW5G9CQBRi99fL5T785kkbvd3ILq8xlsRiqygUYjieH4PtSdGsByg8SgatvaOBiZYkXSfYZo/sT0bWqbOGC/WTIcF1apt0zTbFOZyDuAMcrNrFFM6v25GgkfABrX9V3sHGljyAg4pRGOfBw2dGSN9aneH3f+7/9XlV7JnJFR8LAyskXz0SC5x7G49NaaAI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(6133799003)(22082099003)(18002099003)(921020)(56012099006)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjBKMHN1dnMzN3NwVzY1TTU2dzBMMGlYQlFLMityVWRxYlB1a05nb001Uk5Y?=
 =?utf-8?B?cENINGUwL016cEw1Syt3Z0NoTXZ0VmxuMHlvenNyeTc4bG45eXZzN2NyWm40?=
 =?utf-8?B?NzA3VDZ3ZGZGOVNwUVJNWXk2WC9YSkhpeWlDbDN0bkNHV2JFWEZITXVpS2dX?=
 =?utf-8?B?dzQvZzVtYzE0dGViUFI2LzBpbTUrQnhpWVVma3hNNUhRMVZRR3pDRHBwVVBX?=
 =?utf-8?B?dDRJWGxJTjdKWVVUUnJUSGREekFLSVRiUzRBOFlRVDFOTTRuNXJEUGd2MGx1?=
 =?utf-8?B?dWxTMTVZQVJtb0RjTnZDSndLbmp1Vzhtd2F1RHNnRUkwSlpkbmNsSkh4L1I5?=
 =?utf-8?B?UnJySXBFbHc0cGF2NzVWK0FuYWRNaVNRZWFYcE5iL1JxU0gvYlUwTzMvejRY?=
 =?utf-8?B?S3k3Ny9JZWFZVE1XbEsrWWVBbWRGcTcxTCtSVHZ1cXdObzRiMjNhNFJ2OTlk?=
 =?utf-8?B?T2E2TGZBUGFiYVYzcHpXZEZ5SmgxTjZCYVlQMmdkMDF3eDNnUnQvNGgyeHc3?=
 =?utf-8?B?QUhCQUtzeDdXZnhFNEF2S05PUkZoL2tOWWt5UjJSdUh2bmNkb1kxRjBIemlE?=
 =?utf-8?B?ZUltVndWM2tqTTFYd3hvRnNhUlArVnFJdzE5WURQbUtOQW43UDZDWlJaNXB4?=
 =?utf-8?B?aXFpQ0szMWszQ1crWVI0YlFTblg1OFhCK2VLVWlMWW51cUFocWtiTEQzSU9U?=
 =?utf-8?B?ME5tTzlnN1VvQmdvMEFCbjNwdXU1ZFFaL0NXdnhEQWNMS2Y5YjRRVWdzTm93?=
 =?utf-8?B?TFlPemFVdko3bkprOEl6aWE3cDdkcGNRVnpxV0VvWWg0bk10QUhMZHJROU5q?=
 =?utf-8?B?b1BsN3I3L0tUNDR5YUY3Z0ZNckZZUURWQ2kzY2sycW9hTWljaisrTnZmQWNB?=
 =?utf-8?B?YzNvbW5WZWNDWmpCbitYa1JEaVdJZWxBMnpRM2FJMHpLQWdGS1lnbWpvMHhL?=
 =?utf-8?B?SWlnTmZLNmUzS0VWNG56NW1IZVlRK0FreHExQUdzZnorenc4OHZNd0RGUjZG?=
 =?utf-8?B?UGkzeUV2bmkrMWFmNVY0TWtiSHR3Z1lydGc2bU5TcnlFM2Fzd05NVkRaTDdL?=
 =?utf-8?B?Q3UySkdWbU83aFJBejdCcG1pajhyQmM4cmxsa2EzeGtJR0Y1WU1OWnc0SE5B?=
 =?utf-8?B?SUNlUWhiSndOOTk4eGRTaHl1cWhsYlBMMXJLaTlqOEc1MWRlcUQ3TlpFaHlX?=
 =?utf-8?B?d0g4ZUErNDhCZExCRDlzZjBjUHlsYjhadUJvQnE4MmN2M2ZadlFpNFpvY1dw?=
 =?utf-8?B?UTRqUm9GcDFCQTZLMlJkaHY4OUFYMTYrVkpwLzRScVVjY05ZQTJ4MUlkL3d6?=
 =?utf-8?B?bVF0SEpKYTA4eUVnVWsvY0VQT2lRUEpZVjBONmdMTE5RdmthTCtOOFhyYWdr?=
 =?utf-8?B?TUduVWdIblA0TVZRY09NTi9EbUU0SWF4L1ZocUxtdWxKSFBSbmM5d2xmMUxB?=
 =?utf-8?B?OXNZS3hUMnRQaFNsV3JaaTdLa09lMFRJQ3RSODluMSs0aWQ5ZGlBMW1ZRGRM?=
 =?utf-8?B?Y3U5UVhlL0JjYXdWTEw2UDJGY0lIUUdzNG1sZHRLVGxoaTg2SXppb1FtWXZ3?=
 =?utf-8?B?bzVYMnRraUNjNnJieVp0K2wwRmVGZm90cWpmamMvSGh2VG91aWYvK1RYTWxQ?=
 =?utf-8?B?MnhDVmFvelY2K0d6MEdaQjZ1NUp1T3JGL2dqUHdxVzVOcEtLYWVnajU3NHN3?=
 =?utf-8?B?ZEU1SklVOFZZQUFlV2ZsSjNNcndRV3NwMDZjQTR6dU01WTN4L0lsYmx2SjNZ?=
 =?utf-8?B?aWxTOW1BS1dudGFxMFZQc3ozNnZlbmQvSzdSdEhMM0QyQzNOSEhhclJ4UjhE?=
 =?utf-8?B?MmFNaFhqcUtXRVovMXJqWDdVenhWc0cxWjhjdjRPOU4xYy95WWhMYUd0SUtX?=
 =?utf-8?B?cW5wYnNEaXdTNFN5RUhGOUN5RGJDN3ovKzNDRThDWHZ5RHpnTUl2dklObzJv?=
 =?utf-8?B?elhOaXBBTE1MeGdBVmVMQ3B0UTBOZlFtbDNHMDJreGlFMmNlVmdpLy9CYUlu?=
 =?utf-8?B?OHh5bmsxSjFqUnFGejVjSmE2aXFjaWU3Mkt0VVBud3NhVmE5c1QxeHJtUDJi?=
 =?utf-8?B?UUc0WU5vaU1ZZmlwcjg5cTdIN1l6eVJyemhoUElQRi8xUys5ejExSGVYNlFw?=
 =?utf-8?B?UEo0QmVYcVlrb2tRalpQYXl3ZGswU252ZFUrZ3Y3S0NTOTAzcEFwL1FpWUNO?=
 =?utf-8?B?WEFrMXUxUmU1WVhqL1M2SGMrbi9rRmlYY2RLbTkxN1lnTE1KNHBIVWs2Wkhi?=
 =?utf-8?B?QlNPaGkyYWZEeUdpTGFqMHpkc0gxa3lsOWV2REtJcEE2RWhKZnNrNVdFTmhw?=
 =?utf-8?B?Um5XRUdDZzB2eCs5YnF0c1EvRDRKMlB0bFNid1Z5TERqcWtxU2FUdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: af7b434e-9c57-42be-2ffa-08dec59869a8
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 19:59:13.2260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MuS172WAuEhuclXLj6hmXd+hh0Rty7oGu66m1SbeCbL6Gl8bk2pVr3UlHRTATSgTk4oa2MjVWwt+uH5t67qY+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7398

From: Laura Nao <laura.nao@collabora.com>

Add `SysMem`, an `Io` trait implementation for kernel virtual address
ranges. It uses volatile accessors to provide safe access to shared
memory that may be concurrently accessed by external hardware. Implement
`IoCapable` for `u8`, `u16`, `u32`, and `u64` (for 64-bit system).

This can be used for instead of `Coherent` for cases where a different
layer takes care of mapping the system memory to the device (e.g. dma-buf
or GPUVM).

Signed-off-by: Laura Nao <laura.nao@collabora.com>
[ Rebased and adapted on top of I/O rework. - Gary ]
Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 173f8c0ba2d6..580ca88c46cc 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -1040,6 +1040,120 @@ pub fn relaxed(self) -> RelaxedMmio<'a, T> {
 #[cfg(CONFIG_64BIT)]
 impl_mmio_io_capable!(RelaxedMmioBackend, u64, readq_relaxed, writeq_relaxed);
 
+/// I/O Backend for system memory.
+pub struct SysMemBackend;
+
+impl IoBackend for SysMemBackend {
+    type View<'a, T: ?Sized + KnownSize> = SysMem<'a, T>;
+
+    #[inline]
+    fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> *mut T {
+        view.ptr
+    }
+
+    #[inline]
+    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
+        _view: Self::View<'a, T>,
+        ptr: *mut U,
+    ) -> Self::View<'a, U> {
+        // INVARIANT: Per safety requirement, `ptr` is projection from `view`, so it is also a valid
+        // kernel accessible memory region.
+        SysMem {
+            ptr,
+            phantom: PhantomData,
+        }
+    }
+}
+
+/// Implements [`IoCapable`] on `SysMemBackend` for `$ty` using `read_volatile` and
+/// `write_volatile`.
+macro_rules! impl_sysmem_io_capable {
+    ($ty:ty) => {
+        impl IoCapable<$ty> for SysMemBackend {
+            fn io_read(view: SysMem<'_, $ty>) -> $ty {
+                // SAFETY:
+                // - Per type invariant, `ptr` is valid and aligned.
+                // - Using read_volatile() here so that race with hardware is well-defined.
+                // - Using read_volatile() here is not sound if it races with other CPU per Rust
+                //   rules, but this is allowed per LKMM.
+                // - The macro is only used on primitives so all bit patterns are valid.
+                unsafe { view.ptr.read_volatile() }
+            }
+
+            fn io_write(view: SysMem<'_, $ty>, value: $ty) {
+                // SAFETY:
+                // - Per type invariant, `ptr` is valid and aligned.
+                // - Using write_volatile() here so that race with hardware is well-defined.
+                // - Using write_volatile() here is not sound if it races with other CPU per Rust
+                //   rules, but this is allowed per LKMM.
+                unsafe { view.ptr.write_volatile(value) }
+            }
+        }
+    };
+}
+
+impl_sysmem_io_capable!(u8);
+impl_sysmem_io_capable!(u16);
+impl_sysmem_io_capable!(u32);
+#[cfg(CONFIG_64BIT)]
+impl_sysmem_io_capable!(u64);
+
+/// System memory region.
+///
+/// Provides `Io` trait implementation for kernel virtual address ranges,
+/// using volatile read/write to safely access shared memory that may be
+/// concurrently accessed by external hardware.
+///
+/// # Invariants
+///
+/// `self.ptr.addr() .. self.ptr.addr() + KnownSize::size(self.ptr)` is valid and aligned kernel
+/// accessible memory region for the lifetime `'a`.
+pub struct SysMem<'a, T: ?Sized> {
+    ptr: *mut T,
+    phantom: PhantomData<&'a ()>,
+}
+
+impl<T: ?Sized> Copy for SysMem<'_, T> {}
+impl<T: ?Sized> Clone for SysMem<'_, T> {
+    #[inline]
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+
+impl<'a, T: ?Sized> SysMem<'a, T> {
+    /// Create a `SysMem` from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// `ptr.addr() .. ptr.addr() + KnownSize::size(ptr)` must be valid and aligned kernel
+    /// accessible memory region for the lifetime `'a`.
+    #[inline]
+    pub unsafe fn new(ptr: *mut T) -> Self {
+        // INVARIANT: Per safety requirement.
+        Self {
+            ptr,
+            phantom: PhantomData,
+        }
+    }
+
+    /// Obtain the raw pointer to the memory.
+    #[inline]
+    pub fn as_ptr(self) -> *mut T {
+        self.ptr
+    }
+}
+
+impl<'a, T: ?Sized + KnownSize> IoBase<'a> for SysMem<'a, T> {
+    type Backend = SysMemBackend;
+    type Target = T;
+
+    #[inline]
+    fn as_view(self) -> <Self::Backend as IoBackend>::View<'a, Self::Target> {
+        self
+    }
+}
+
 // This helper turns associated functions to methods so it can be invoked in macro.
 // Used by `io_project!()` only.
 #[doc(hidden)]

-- 
2.54.0

