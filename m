Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020131.outbound.protection.outlook.com [52.101.196.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8E33DA7E2;
	Tue, 21 Apr 2026 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776783402; cv=fail; b=Xqpea07KO+9sfRHEIGdZ3scBEt3SV3k/TayH0EP87QWgQhuhwlSSqjbT7S76nKAZioF2ABWRh7X/62b7a9Xd+LYo8VrwYnfj4rCEF7PWC34bjpvSR0H239InRnyphilQYBn+ext+ZdSRvXzj4RbHai9HD/L+CL0OocKBT2IkiVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776783402; c=relaxed/simple;
	bh=PRmb1wvZ+Pmwck3wqC2xoPHaVRyQSptHTYjFPqcyZSo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ppl7UhCxeYc5mLcqCBF7+p3Z/CYzhqCkXNT0mfuRPYoFELmegy/d2s1k5axdXT7obNJYP5j3VqEes9Cv1ruzptW23YNURY8QHIWX3y3XPoPZVTWuB54vmlugXnqrKDfp78h0jLnBcfw8bBaPRWhfo9nP1D2nHcKeDe4PoxB2wEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=gzRkEzbu; arc=fail smtp.client-ip=52.101.196.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="gzRkEzbu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0fPmim77OhMy/AArBYuqxQN+roqyR9l9RZuxFmzceM4woWHVcpwnUweobxWBpZ27xC/LM0U2LEQ3wYkXgsJqor+OZU5MDtjtsr0VZUylyer/u72k4NZcxxjx6BBhhkRrJUsMfVSxPpawEM7i/v4IKZ/AFkEIZBNYxzIVIozEoJbrZG0XJGvuri3qNoRNCLe+JUOWj6Lf041AMvOnch6ETlBsUxJ54Cs7rGf/nOT749db1JFJ3I4bT48kjxD8/zsvDBtTItg9Sx+trB0oEPSK9DI4DMz+Kz0pYE09KUsnWOAVWGs5WbWBWJaz+EkwJteCb2t/0bBQ4Oa5AnDuo9rLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ih550/9B0Kfc6sJ+DPgQPhZ40972fjfe4eGDtLBMZLU=;
 b=QZX9Bk6RFon8KQFFhURnPSRlWLyeMuBeVCRmY3XaU7CIziPmen5+HuW+OQYhz++VBFfjgeUKJTf8Zp0Vki/ZUehgitHdmuaNWuANL2XuG0W3NqLdS7ARt/a+ux4cQFrQGUeaKlvxpeoulmkoAC3IAXnO1XWO62A18Nymd6YUnYgg1atRq9guzN+jM93ufcf/+ZNr3LhjrqHU/q039xJNOljygOqsAHG0urapmNFKDmZY0eyU5eZj16tVAKj5j2y+6vCToJ87N/nVNbrvkQ/AVaNxubkFSaHqipUDuyRHv4TpqV2evS8JpHTfrYbMXVTCc0oamvsbtb73umNwlhDjiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ih550/9B0Kfc6sJ+DPgQPhZ40972fjfe4eGDtLBMZLU=;
 b=gzRkEzbut50jJjaAtXlaQT52b+cu4acFYGMZT0fQ9Cof3hSOVXO9+HuqvCTgD9PV8t+NJZxeloPPVIS4UBRiFpfM6vJq5VT8wxIR+cIW8lTOPugP6ACz2I5X3VtjaxGgtfLq/TOfisp9ZjdlkKbWhM+C1ZOCuvaQD7XTP0oDsQc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB5674.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 14:56:30 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 14:56:30 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 21 Apr 2026 15:56:20 +0100
Subject: [PATCH v2 09/11] gpu: nova-core: use I/O projection for cleaner
 encapsulation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-io_projection-v2-9-4c251c692ef4@garyguo.net>
References: <20260421-io_projection-v2-0-4c251c692ef4@garyguo.net>
In-Reply-To: <20260421-io_projection-v2-0-4c251c692ef4@garyguo.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776783386; l=12845;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=PRmb1wvZ+Pmwck3wqC2xoPHaVRyQSptHTYjFPqcyZSo=;
 b=FV6fQMw8SBB/uXwMUfB7l1WdZJo0rqbdRde/svIF1wTqDb8Z85lNZJp73GsxFDTvZl3IGtCHr
 wLXxVRg4vQGDJ5jxA7jGTbfAA6dYLmUsS+8+XnTsMdWcI2Vp7r6Q0Lp
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0142.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::21) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB5674:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c296a16-dfaa-4fd9-dd00-08de9fb62c0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	pPPf7xu8o1wlcW90ZLLmV7T2nyzZOFxz9kQ0sX6ZolZTDltS0shpan5e83CdWh/rF1Ue7iDW2VnRrefe2wzTgbbzjhG7Y5dtcQLZ0F0GN5CfrKJX/PhibZuJibJ4BcLLIZDJDbiZi/cFLO2WcBY6t043E6UneIRdgaEw2T44afk3eN3ngXpcptUDdZQjEJxsXVYYzHNRu+RjPP161V1yIQh3YCYRxAChcN4HzdJhEWtTDmzJV98VIuD1uLjEBCEf3C0na9Y2eT/C/NMeu1BSG8CQYpxB7UwZ8I/hGpz/mRgtzTtD6wa2KZEEodoBXA7OAN/UbKeFlKl0w3YbByST8LvUCQj1M1JDIE7ibvuMN2HRAk/agq7jYjWvjKb0HXn7myTZWK7WjP9BZFY0Bc50MOY4p+IAF8Nr2Cf4AZkMD6P9SmWkMzdqKwT2kx+IOD5X3USJASxRvzvdyeJprMJpOI1RjCSjdeDq7oKgXID4moWQtujROl3/+QrOlCQb9sFstZM93v4uMcOk6AkPD1xCIFGiRLLeHngGDMfoGDe063PIKSLjfoVtjrmp2L+Essz7rj0cf5LhWOpSjNiZdkpZfNH7u/6DW7JiRtlaCO/ypw8IvtGvwBlBeHL5wLXZJT4GeIAQmp7oYUsSbYqmFWk9HO8eLWkY2XXuvY6R0JHw7Gw1IvFM4kEU6uIqm8ZHDQrWCdDEbs/aIRddxhHx3ckMrQizihEtfWq5R8ZmOJbNiNTt2Ab/A2I2NGK33CouX+FZSvt+7t82u6jEEBp7YGaVHg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1hySG1MUlNDcXlNQVUwdmkzUE5YSGQzajJwdWdvOWs5L3AzQXhkUSs2eTA3?=
 =?utf-8?B?dVdRSVZwLzNPOU1xZzFkMktqS0ozVnRuZzJYUUVKTldsVXlaUFdMOUtGU1Vn?=
 =?utf-8?B?MCtUemtYZ2pZc2hUZldMTTVMTU5jdWpPMUpqV1M1aU9ITnE3U2RjcW11WFNE?=
 =?utf-8?B?V3FGQUtldWRaeFZPaDgydzQ1dHdVVnRMcFhmOHYxKzE5Q2h1a3o3emFOVWw3?=
 =?utf-8?B?Y3NBbUpQdC9mMWFweWY5RllVTjl6YXN4U01vak0rdm9xRy9RaGNrMDlpbU4v?=
 =?utf-8?B?MC9TczVHTWFBSHlveTJSOUZ3WERlQnlpaEVaUTJSY3MxVjdlM1llbDNyVDRh?=
 =?utf-8?B?OUFpb25CNGxFZ0ljeVMxVDVsYjMxZmZuWDJScktGU3pmWU52Ylo2c1J0YjdR?=
 =?utf-8?B?U2ZMZjd1akRjNE5NcFczM0N1cXk4ckhvSm5OcjhFcmxqN2JzdFlQQmJEOEhv?=
 =?utf-8?B?cGdReElXWnF6Q1llM25GbjdkczducjhvNlgwMXRSVWVITUErMFhVcnVWNFl6?=
 =?utf-8?B?RVJ2allKd09XSkk1bjlZMkZPT3hldkZPMUpMQ0pDZEhsaE9ER0lQc3FGa2Y1?=
 =?utf-8?B?QzVYZVJSTFJuRVhlSkR1YWFQMm44Z2lNcEZHdEw4TXFka3ZOOVF0L1RZcWtV?=
 =?utf-8?B?OWlLZVh2dWhIcEFVNXh6NGJVdGdqT21wcVlkQ1drYy83eFBGZmd2anhnQ1pJ?=
 =?utf-8?B?aFlnaFN2VEM0Ti9ieXBhMnZYZnAxQ21nM3diZWNlS2VReHQ0dTJQekRyYU9s?=
 =?utf-8?B?UVpodjliUytEd0U1NStYWW9yN1hSSzVZeTJlalRhN2JCWDVUWXFudWxBMnlz?=
 =?utf-8?B?MFArb3lGa1Z2MTdKYkNUQnUrSDI4Q2VndEpRMVJrZDgxcFFMaHh4ajRrbHpF?=
 =?utf-8?B?ZE16STFBcW1jcWlvbGxwV1NKV3BJcXNpUUg5WHRJODBNa05HSEg4bXRhd0hI?=
 =?utf-8?B?V2k3MUw2K01JZHppRXk2aHVsNGd4QTFrb3ZuTkFxWkdDeVljTUdHZkx5Yzg0?=
 =?utf-8?B?RXNZSWRxaWd4YjZFajZ4VGhGdzJEaW83NTdycndGQnBEdVFXUW5wNnRPaW1J?=
 =?utf-8?B?c1dvd2VMZ0Z1OEYzSWw4UW4rdXo2bDhIVUpXMkpkdXY0UXo3SGMzZlZ3RWk0?=
 =?utf-8?B?Y3NNazdCZ2FqSkRqZWc1T3Y0RTlUdU1jL1JaVnpwSEhiVTJXeU9LTnBpOExN?=
 =?utf-8?B?cWg5cTM1V2NzRlo5bTAzUEM3NStwc2NSTjc2V3FldC9VV05hT2NDekkyNGl4?=
 =?utf-8?B?aFRuUFV6M0p4bE03QkxpaExpQk96cGFrYjJUSENNdkY1WjdoUkVYUmEvNlRp?=
 =?utf-8?B?WDErNFlUK3JoK2lSTzdoMDNSbFFYb3MzcWUyT3hLT1JHVUJuOW16Wk1DVXRh?=
 =?utf-8?B?Z2xCOVVhc25hTEdMemdwR0tlSVFuenU0SmJpSUNRZ1BSTXNKeWxhWGdnOGRQ?=
 =?utf-8?B?ZTE3T09Xb1VXd3kyeG42cUI2a1JkMXp0Y0pxWlY3d1JNNmNDakFKVXIvdnNz?=
 =?utf-8?B?Qmc2MS9zaVZ6cGtRa0VoYW1YdXVrSU0xd0xjZjJwRXJiaDRCYmRKVWRRU3J1?=
 =?utf-8?B?cUtrQ0FMUzVKa3ErckRSelVwSHE2aWM0OVBFaTJSSGFXOVZFTjNrT0NlOWxB?=
 =?utf-8?B?QkM0ZmM1cjk2dG5mazhMWGtyOVcrOTYweCtUQjIzd0pkZkNZMlZIeW15UmFN?=
 =?utf-8?B?Nk9HaE1MVURrZ0k2V01vUlpTZkFDT1k2dlRNbXM1WDdFRHVDM01hOVRYVC9k?=
 =?utf-8?B?bStvTDR1d1lhYmp6TUJUb1NVdDlSaFhHOHNRM3hZN25YTEQxUmtjUzVDNzB0?=
 =?utf-8?B?cmFpWU9ZZWhQRDdzZlM0VlZhSllPZENUZVZMY25sbDN6ME1aV0hyeGN3WWtR?=
 =?utf-8?B?U05yR0FOVUpWWWc5UmRBMTlHemozM01waVpHQTJYdWoyNWVJdHk4MTkvSDhm?=
 =?utf-8?B?ZlpTMUdkdTgwb3dxc21VNW83TWNqZTg3Mm9CTnY4NitBUGZMMks5T0pPbVVE?=
 =?utf-8?B?L2tIRGZoQ2JRV1dKNG9JSU1VOHZGVzdhc2VDKzdEbmdpd09QS2tJSGJTY3Ix?=
 =?utf-8?B?d2JLdSs2M0VvMDY4VFJ4bXd1dlFOcXd2MTQwUmp4cHB6VUVjN1RjVVlkaEhC?=
 =?utf-8?B?K2ZqaWhiZ2luYXFza0ptRVNsSldUZS9RMG1wZWpJQ1orcFVJMHhDSDhvSXZt?=
 =?utf-8?B?R1o4VVpoNTRjRDAreEd3MDJRVHhNRzFhYStrYkc4bzhSMnFLdHYxUVNSOFJU?=
 =?utf-8?B?eUVHOGczS2MzL2E4akozNndQS0FFY1o0OVdick9aQ0VlK0tSM1pyK01Pdnd6?=
 =?utf-8?B?YWFFL2NVVW1BQmRnZUhjQUg3Q3lLa0p6YldqcHhIRlVsSXg1NG1lQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c296a16-dfaa-4fd9-dd00-08de9fb62c0d
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 14:56:30.5875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gg69nrHXe4QMRqc7yH4sTiMLuBCps5XOEV1dwENujYmYhwC78E5xtjZVSJMtQ2GPyj1qkMRusR2Ckh3s/6G2Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5674

Use `io_project!` for PTE array and message queues to remove the
break off encapsulation.

The remaining `dma_read!` and `dma_write!` is now only acting on
primitives; thus replace by `io_read!` and `io_write!`.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/nova-core/gsp.rs      | 44 +++++++++++---------
 drivers/gpu/nova-core/gsp/cmdq.rs | 65 +++++++++++++++++-------------
 drivers/gpu/nova-core/gsp/fw.rs   | 84 +++++++++++++++------------------------
 3 files changed, 94 insertions(+), 99 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index ba5b7f990031..225a77a2f464 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -10,8 +10,14 @@
         CoherentBox,
         DmaAddress, //
     },
+    io::{
+        self,
+        io_project,
+        io_write, //
+    },
     pci,
     prelude::*,
+    ptr::KnownSize,
     transmute::{
         AsBytes,
         FromBytes, //
@@ -55,12 +61,20 @@ unsafe impl<const NUM_ENTRIES: usize> FromBytes for PteArray<NUM_ENTRIES> {}
 unsafe impl<const NUM_ENTRIES: usize> AsBytes for PteArray<NUM_ENTRIES> {}
 
 impl<const NUM_PAGES: usize> PteArray<NUM_PAGES> {
-    /// Returns the page table entry for `index`, for a mapping starting at `start`.
-    // TODO: Replace with `IoView` projection once available.
-    fn entry(start: DmaAddress, index: usize) -> Result<u64> {
-        start
-            .checked_add(num::usize_as_u64(index) << GSP_PAGE_SHIFT)
-            .ok_or(EOVERFLOW)
+    /// Initialize a new page table array mapping `NUM_PAGES` GSP pages starting at address `start`.
+    fn init<T: KnownSize + ?Sized>(
+        view: io::View<'_, Coherent<T>, Self>,
+        start: DmaAddress,
+    ) -> Result<()> {
+        for i in 0..NUM_PAGES {
+            io_write!(view, .0[build: i],
+                start
+                    .checked_add(num::usize_as_u64(i) << GSP_PAGE_SHIFT)
+                    .ok_or(EOVERFLOW)?
+            );
+        }
+
+        Ok(())
     }
 }
 
@@ -86,18 +100,12 @@ fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
         let obj = Self(Coherent::zeroed(dev, GFP_KERNEL)?);
 
         let start_addr = obj.0.dma_handle();
-
-        // SAFETY: `obj` has just been created and we are its sole user.
-        let pte_region = unsafe {
-            &mut obj.0.as_mut()[size_of::<u64>()..][..RM_LOG_BUFFER_NUM_PAGES * size_of::<u64>()]
-        };
-
-        // Write values one by one to avoid an on-stack instance of `PteArray`.
-        for (i, chunk) in pte_region.chunks_exact_mut(size_of::<u64>()).enumerate() {
-            let pte_value = PteArray::<0>::entry(start_addr, i)?;
-
-            chunk.copy_from_slice(&pte_value.to_ne_bytes());
-        }
+        let pte_view = io_project!(
+            obj.0,
+            [build: size_of::<u64>()..][build: ..RM_LOG_BUFFER_NUM_PAGES * size_of::<u64>()]
+        )
+        .try_cast::<PteArray<RM_LOG_BUFFER_NUM_PAGES>>()?;
+        PteArray::init(pte_view, start_addr)?;
 
         Ok(obj)
     }
diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 0b51e10e2cfc..d424d047c970 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -2,16 +2,23 @@
 
 mod continuation;
 
-use core::mem;
+use core::{
+    mem,
+    sync::atomic::{
+        fence,
+        Ordering, //
+    },
+};
 
 use kernel::{
     device,
     dma::{
         Coherent,
+        CoherentBox,
         DmaAddress, //
     },
-    dma_write,
     io::{
+        io_project,
         poll::read_poll_timeout,
         Io, //
     },
@@ -171,20 +178,18 @@ struct MsgqData {
 #[repr(C)]
 // There is no struct defined for this in the open-gpu-kernel-source headers.
 // Instead it is defined by code in `GspMsgQueuesInit()`.
-// TODO: Revert to private once `IoView` projections replace the `gsp_mem` module.
-pub(super) struct Msgq {
+struct Msgq {
     /// Header for sending messages, including the write pointer.
-    pub(super) tx: MsgqTxHeader,
+    tx: MsgqTxHeader,
     /// Header for receiving messages, including the read pointer.
-    pub(super) rx: MsgqRxHeader,
+    rx: MsgqRxHeader,
     /// The message queue proper.
     msgq: MsgqData,
 }
 
 /// Structure shared between the driver and the GSP and containing the command and message queues.
 #[repr(C)]
-// TODO: Revert to private once `IoView` projections replace the `gsp_mem` module.
-pub(super) struct GspMem {
+struct GspMem {
     /// Self-mapping page table entries.
     ptes: PteArray<{ Self::PTE_ARRAY_SIZE }>,
     /// CPU queue: the driver writes commands here, and the GSP reads them. It also contains the
@@ -192,13 +197,13 @@ pub(super) struct GspMem {
     /// index into the GSP queue.
     ///
     /// This member is read-only for the GSP.
-    pub(super) cpuq: Msgq,
+    cpuq: Msgq,
     /// GSP queue: the GSP writes messages here, and the driver reads them. It also contains the
     /// write and read pointers that the GSP updates. This means that the read pointer here is an
     /// index into the CPU queue.
     ///
     /// This member is read-only for the driver.
-    pub(super) gspq: Msgq,
+    gspq: Msgq,
 }
 
 impl GspMem {
@@ -232,20 +237,13 @@ fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
         const MSGQ_SIZE: u32 = num::usize_into_u32::<{ size_of::<Msgq>() }>();
         const RX_HDR_OFF: u32 = num::usize_into_u32::<{ mem::offset_of!(Msgq, rx) }>();
 
-        let gsp_mem = Coherent::<GspMem>::zeroed(dev, GFP_KERNEL)?;
+        let mut gsp_mem = CoherentBox::<GspMem>::zeroed(dev, GFP_KERNEL)?;
+        gsp_mem.cpuq.tx = MsgqTxHeader::new(MSGQ_SIZE, RX_HDR_OFF, MSGQ_NUM_PAGES);
+        gsp_mem.cpuq.rx = MsgqRxHeader::new();
 
+        let gsp_mem: Coherent<_> = gsp_mem.into();
         let start = gsp_mem.dma_handle();
-        // Write values one by one to avoid an on-stack instance of `PteArray`.
-        for i in 0..GspMem::PTE_ARRAY_SIZE {
-            dma_write!(gsp_mem, .ptes.0[build: i], PteArray::<0>::entry(start, i)?);
-        }
-
-        dma_write!(
-            gsp_mem,
-            .cpuq.tx,
-            MsgqTxHeader::new(MSGQ_SIZE, RX_HDR_OFF, MSGQ_NUM_PAGES)
-        );
-        dma_write!(gsp_mem, .cpuq.rx, MsgqRxHeader::new());
+        PteArray::init(io_project!(gsp_mem, .ptes), start)?;
 
         Ok(Self(gsp_mem))
     }
@@ -420,7 +418,7 @@ fn allocate_command(&mut self, size: usize, timeout: Delta) -> Result<GspCommand
     //
     // - The returned value is within `0..MSGQ_NUM_PAGES`.
     fn gsp_write_ptr(&self) -> u32 {
-        super::fw::gsp_mem::gsp_write_ptr(&self.0)
+        MsgqTxHeader::write_ptr(io_project!(self.0, .gspq.tx)) % MSGQ_NUM_PAGES
     }
 
     // Returns the index of the memory page the GSP will read the next command from.
@@ -429,7 +427,7 @@ fn gsp_write_ptr(&self) -> u32 {
     //
     // - The returned value is within `0..MSGQ_NUM_PAGES`.
     fn gsp_read_ptr(&self) -> u32 {
-        super::fw::gsp_mem::gsp_read_ptr(&self.0)
+        MsgqRxHeader::read_ptr(io_project!(self.0, .gspq.rx)) % MSGQ_NUM_PAGES
     }
 
     // Returns the index of the memory page the CPU can read the next message from.
@@ -438,12 +436,18 @@ fn gsp_read_ptr(&self) -> u32 {
     //
     // - The returned value is within `0..MSGQ_NUM_PAGES`.
     fn cpu_read_ptr(&self) -> u32 {
-        super::fw::gsp_mem::cpu_read_ptr(&self.0)
+        MsgqRxHeader::read_ptr(io_project!(self.0, .cpuq.rx)) % MSGQ_NUM_PAGES
     }
 
     // Informs the GSP that it can send `elem_count` new pages into the message queue.
     fn advance_cpu_read_ptr(&mut self, elem_count: u32) {
-        super::fw::gsp_mem::advance_cpu_read_ptr(&self.0, elem_count)
+        let rx = io_project!(self.0, .cpuq.rx);
+        let rptr = MsgqRxHeader::read_ptr(rx).wrapping_add(elem_count) % MSGQ_NUM_PAGES;
+
+        // Ensure read pointer is properly ordered.
+        fence(Ordering::SeqCst);
+
+        MsgqRxHeader::set_read_ptr(rx, rptr)
     }
 
     // Returns the index of the memory page the CPU can write the next command to.
@@ -452,12 +456,17 @@ fn advance_cpu_read_ptr(&mut self, elem_count: u32) {
     //
     // - The returned value is within `0..MSGQ_NUM_PAGES`.
     fn cpu_write_ptr(&self) -> u32 {
-        super::fw::gsp_mem::cpu_write_ptr(&self.0)
+        MsgqTxHeader::write_ptr(io_project!(self.0, .cpuq.tx)) % MSGQ_NUM_PAGES
     }
 
     // Informs the GSP that it can process `elem_count` new pages from the command queue.
     fn advance_cpu_write_ptr(&mut self, elem_count: u32) {
-        super::fw::gsp_mem::advance_cpu_write_ptr(&self.0, elem_count)
+        let tx = io_project!(self.0, .cpuq.tx);
+        let wptr = MsgqTxHeader::write_ptr(tx).wrapping_add(elem_count) % MSGQ_NUM_PAGES;
+        MsgqTxHeader::set_write_ptr(tx, wptr);
+
+        // Ensure all command data is visible before triggering the GSP read.
+        fence(Ordering::SeqCst);
     }
 }
 
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 0c8a74f0e8ac..f2ba2f13e415 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -10,6 +10,11 @@
 
 use kernel::{
     dma::Coherent,
+    io::{
+        self,
+        io_read,
+        io_write, //
+    },
     prelude::*,
     ptr::{
         Alignable,
@@ -40,59 +45,6 @@
     },
 };
 
-// TODO: Replace with `IoView` projections once available.
-pub(super) mod gsp_mem {
-    use core::sync::atomic::{
-        fence,
-        Ordering, //
-    };
-
-    use kernel::{
-        dma::Coherent,
-        dma_read,
-        dma_write, //
-    };
-
-    use crate::gsp::cmdq::{
-        GspMem,
-        MSGQ_NUM_PAGES, //
-    };
-
-    pub(in crate::gsp) fn gsp_write_ptr(qs: &Coherent<GspMem>) -> u32 {
-        dma_read!(qs, .gspq.tx.0.writePtr) % MSGQ_NUM_PAGES
-    }
-
-    pub(in crate::gsp) fn gsp_read_ptr(qs: &Coherent<GspMem>) -> u32 {
-        dma_read!(qs, .gspq.rx.0.readPtr) % MSGQ_NUM_PAGES
-    }
-
-    pub(in crate::gsp) fn cpu_read_ptr(qs: &Coherent<GspMem>) -> u32 {
-        dma_read!(qs, .cpuq.rx.0.readPtr) % MSGQ_NUM_PAGES
-    }
-
-    pub(in crate::gsp) fn advance_cpu_read_ptr(qs: &Coherent<GspMem>, count: u32) {
-        let rptr = cpu_read_ptr(qs).wrapping_add(count) % MSGQ_NUM_PAGES;
-
-        // Ensure read pointer is properly ordered.
-        fence(Ordering::SeqCst);
-
-        dma_write!(qs, .cpuq.rx.0.readPtr, rptr);
-    }
-
-    pub(in crate::gsp) fn cpu_write_ptr(qs: &Coherent<GspMem>) -> u32 {
-        dma_read!(qs, .cpuq.tx.0.writePtr) % MSGQ_NUM_PAGES
-    }
-
-    pub(in crate::gsp) fn advance_cpu_write_ptr(qs: &Coherent<GspMem>, count: u32) {
-        let wptr = cpu_write_ptr(qs).wrapping_add(count) % MSGQ_NUM_PAGES;
-
-        dma_write!(qs, .cpuq.tx.0.writePtr, wptr);
-
-        // Ensure all command data is visible before triggering the GSP read.
-        fence(Ordering::SeqCst);
-    }
-}
-
 /// Maximum size of a single GSP message queue element in bytes.
 pub(crate) const GSP_MSG_QUEUE_ELEMENT_SIZE_MAX: usize =
     num::u32_as_usize(bindings::GSP_MSG_QUEUE_ELEMENT_SIZE_MAX);
@@ -706,6 +658,19 @@ pub(crate) fn new(msgq_size: u32, rx_hdr_offset: u32, msg_count: u32) -> Self {
             entryOff: num::usize_into_u32::<GSP_PAGE_SIZE>(),
         })
     }
+
+    /// Returns the value of the write pointer for this queue.
+    pub(crate) fn write_ptr<T: KnownSize + ?Sized>(this: io::View<'_, Coherent<T>, Self>) -> u32 {
+        io_read!(this, .0.writePtr)
+    }
+
+    /// Sets the value of the write pointer for this queue.
+    pub(crate) fn set_write_ptr<T: KnownSize + ?Sized>(
+        this: io::View<'_, Coherent<T>, Self>,
+        val: u32,
+    ) {
+        io_write!(this, .0.writePtr, val)
+    }
 }
 
 // SAFETY: Padding is explicit and does not contain uninitialized data.
@@ -721,6 +686,19 @@ impl MsgqRxHeader {
     pub(crate) fn new() -> Self {
         Self(Default::default())
     }
+
+    /// Returns the value of the read pointer for this queue.
+    pub(crate) fn read_ptr<T: KnownSize + ?Sized>(this: io::View<'_, Coherent<T>, Self>) -> u32 {
+        io_read!(this, .0.readPtr)
+    }
+
+    /// Sets the value of the read pointer for this queue.
+    pub(crate) fn set_read_ptr<T: KnownSize + ?Sized>(
+        this: io::View<'_, Coherent<T>, Self>,
+        val: u32,
+    ) {
+        io_write!(this, .0.readPtr, val)
+    }
 }
 
 // SAFETY: Padding is explicit and does not contain uninitialized data.

-- 
2.51.2

