Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022089.outbound.protection.outlook.com [52.101.96.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A733485CC3;
	Tue,  1 Sep 2026 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281448; cv=fail; b=oD29XmS4j9SLPqTcKe/d4506va/0ekEe/nfqMETW1Y8XaiwK3oP7rp52MBC7txOlZ9IULxhtoPboYyEui4U9qhBJyROEtp4IsxIcCzXU0QgdgOXtGDuQerjd3pcueBKSPHeUihpb7ttSpL4BR8WgBExVnebhDKCaYg5gLtiNW5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281448; c=relaxed/simple;
	bh=sEaFmQA041Nq96pwerlQKqsj6hyKGBvL0oWCm+haOJM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Ac9KCxEuPIiy/YU3+6Ks5DZhx6wcjv0wFgw5TbyVQlQ3IoRUFILPIfQGTQZn0bwZ9nOwQwkRCO7BTaWXpfQZ2N8GeQrfu9k0HcJxa2aPlzHPqwRrEtIomR7O0lY71BUlHHFZoB3YulaiED81P7bZUIxMx5cuF8uw25gmiMRtsac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=M3eWj+G5; arc=fail smtp.client-ip=52.101.96.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="M3eWj+G5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4zkMPrjuey+ZfQu/Bkj7p7SyB8M2DJTC5Fu/2yFbR8es8YJ4oCFUVZvSKCzEbidCACTphZalcQznCxZ+JA0w3GMJ9T+lNkZcXn7dzD/7Yh1MZihr7VDIPD2h+FFHbiIjJOVRiGmGJCWQEzD+/HoTilLCOMGCKZTs7nPNDyr6qfb6ym0U7wJIvepUNqp34idYykcuhZUMCUpJRO9y2mwhxT8DexxGflkWjP9lE0tFhQ+6sKDUCgNPOcrt7GK0XuE0WPndz0DFvlwFetU0Bwgdwbwnd/UDKGLKQRFRlW/EETgq+4GtB/QErIF08icU7T4HhJejKzGSg6W2PkCSzgrvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jE0bJqKT5LFNVhvgPBihMUBaSnMK8oMzqaN6Q0oGnU=;
 b=EMdC81vgqsr00Da1fZ8BNgc4nkYrvm+VyTLZPvT5FW1SEeucVXXaS7p05uLrAEXAy0RWbjf4V45ibvQ5jCdlUPqQ+JnT68PXvj0xzmuMSESPMEiXaQSYqCioEDoM8Jz73QxNI37MMgGWAkJRwLrmB4N6KzYlCMTR6bLeaEOZJdWnWFUdzQyxiSxsiJ5xA3LFBZDylkD2rjGihp/8UlpKVxeYDIs2LxP+FCNEW1B5GbwHWvpfx+ZPY5xLC7dxjixpIzxBqxLBT2sLJklhEMiEmOFEqrAbTPNnJIFz/HWaGB80gqodbWD/W+5JGG+nmKg6HSU/GEYc0N0jBzT55esUUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jE0bJqKT5LFNVhvgPBihMUBaSnMK8oMzqaN6Q0oGnU=;
 b=M3eWj+G5AS1A6TQCG82LH0gKWxJyQdmO2F/tOmBcSR7D9R111pf3RLndpd1+HDSLxvAgY7YMwB9TUsUg1EliOp5CKkiRnq6hQ5fIP54JnKwve870EBxdAw3VxZYXIpzptSRI2co/WOS59EHPOkw+h3Nf8vme++WnFTDzkt1DYQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO0P265MB7316.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ef::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 16:50:36 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 16:50:36 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 01 Sep 2026 17:50:29 +0100
Subject: [PATCH v4 05/16] rust: io: support register projections
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-typed_register-v4-5-5552b1d59525@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788281431; l=5324;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=sEaFmQA041Nq96pwerlQKqsj6hyKGBvL0oWCm+haOJM=;
 b=+RrGLvf1Dqe6r0gsQGkEJe7Ww8LtICPzAt3VproILBj7bwADcqY5823VaFX1II30nH93j26c/
 4VJXSGrf18rDHjQmwFqq0CSlJy1dBWbIg84C0+GiIgtzcKCQ0quKsE4
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
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO0P265MB7316:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ba7699a-28a7-4e61-7341-08df084925b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|10070799003|376014|7416014|10067099003|6133799003|22082099003|56012099006|5023799004|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	xCKkgCkGEuGr+SmYmeUByt9xmkDa9L7kzJxYKzaym9ZsZxcAk7IEDemKOHHk5U19U3IWghAsig6sN7ZLch+ze62ncAF8ptkwulFXF4Rqfbv4QPIwetFMV0zM/g4FhXsjxwOa7kffOD0k/9js1JAq+ggfO/GipjjhHWB6Q3z4L7FWRW+8N6gXH1yzZhgskdCBVZgpRB+VFQl2hE+6Igg09vrzRA9qNEY+wOPI2GOj/TceR7CsviXxqfJhkcdH48o75BV3CgxwIlBhVY0yAmgOOwDNR3oNOzvJbFEljGu4UViGi/VlYd+5XvwX2reaARH+dzFDl0MEV2yHDYRyLDkxnEFcQd/ZjFyF5yPyZv88S2JDmbe9Yu6PlrMhBvNQ1VbCAeOasBRlPRmS/DvFV2Sr1m8iwl+fhx5nJYLINBai6xcjGxYQ2Ou65ciANONd2uxpz+iSce9tQ6p0PBGEh19SobLfPQw23v4cl6mmL80UV6RTQJ4VS/jkajNeQcd9/6jIZJsuqhadivnYLIkgkjcsm61Yz5sAbtD6HbXFyDiKTNAstvzdAvVZRS0YOKXB+LrwKhJyBxTEPrFp/PvuxLFyNVwydTAk/jEq1Etpogw6zZ2/zQDZ5hglk9orJcowtaL0jrJON0SOHZFAWZKEUUvqRV/Xwtmt1Xk0MWUpkUlbsLTcy7iF2glgdUAwZD9DHB34jptC/XphPfrc9p0bMP2d/A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(376014)(7416014)(10067099003)(6133799003)(22082099003)(56012099006)(5023799004)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFJzTjRlQTZ6Nzlvd1JvUVROa04wQnI0TElYOUpXN2RUd0JpZWRaR25NRUVS?=
 =?utf-8?B?cGV0R09TL3k0d0wrSFhwV2l6YzkzU1JPcjdjTzd2YzNPRk0zUm45SzdyL08z?=
 =?utf-8?B?dXVvUjVFTzBnQm9zTGk3MmlpUzNHcExGSG53b0hoU3lVUmYrVnRwcVo2bGd6?=
 =?utf-8?B?MzI3WXBQMXcyQlhJV2FTQk8zRVRpVy9ESVZjR2o5YjZmck50aG5NbDBZNmUw?=
 =?utf-8?B?Nk1pSldQMUVpVFpmZjB2REhCb2krVlUwM3lmbG5UZGNvaXNrQnhUZFNVMndj?=
 =?utf-8?B?Y3ROVnl1bDhac2ppZFdCTWNnUEhla0I3djF1SW5ydURDTTBhTjlsaTFnVm1J?=
 =?utf-8?B?SlhaWFA1ZFJqZ3d5RFJzNy90MktVeW9idVpFdHcrNk40TVVDbnNQSklSU2Mr?=
 =?utf-8?B?YTBKd3FiMHhVY2NXOTQ4L2w3MkpIMmlZbG05V1pvVHdXZ21JcktNSkVPd0Fq?=
 =?utf-8?B?UzlVaC9kWTNlK20yak9JMm93QnQxVExkYTlIMXJhbThkRFRMTzBySEc2VURl?=
 =?utf-8?B?dFloYTVFZ1I5ajVYSThhUy9LN2h5NmdVZjFZdmxlWTIzZ2tTZUd5ZjNJOEFk?=
 =?utf-8?B?N0pUSEo2UVRhZy9KcUYvNi9pS3p4K0pvUGsvR3RBSGtwa2tjWjBFYXo3WDVY?=
 =?utf-8?B?elpibUo1S2hVMTFsWVdTejA3d25rK2ZUTVc0RTk4QjNMcTVmTGkzKzEvUWJS?=
 =?utf-8?B?NmkvL3Z1NGhDWCtmdHhIaHZJbm1UcjB4TlhibFZobDJsY3V3THNLSlRIcVhT?=
 =?utf-8?B?bmgzSHZmekZCRlZWdFE2SGdmdmdVemhBRUQ3OE9uQVZJamNPOVBrSVhTSUFh?=
 =?utf-8?B?akZ4anBKMU4xYTJ2YVFuNFZadTB4a1JrWGdoSUk4Q0tDYVNuQ2N2eVVOQ3Ay?=
 =?utf-8?B?RlNBNUJscDQvWjJCLzRzcDYyNFNvZDR0SmZ1ZE96eFRmdm8yVWl5VCt5Sis5?=
 =?utf-8?B?czJyck9lTXhSV051N2JWeDVsdGhHbUNVU3JNVVVNZS9YZEkyWXhlN0VQRXBO?=
 =?utf-8?B?cUxHU3lCZVFYb0U2TG41dWZwTXJwK1Q1N1JrcjBPSmhuRU5QL3JEaTdoMjhM?=
 =?utf-8?B?cURzRHIxTmRuMHVyNjFtSnh0SzQrN0g2UVRHUWZtME9SQmYrbm9WaXQ0NVZD?=
 =?utf-8?B?MGVIV3BCdEFLbjE3bE90ZTU2NUp2bVZYYXIrTmk1Z3lrTzViNjBUdkZCVXFi?=
 =?utf-8?B?Z2xweHp5MFNySjZTZ2h1czR1eVpGNk1uVlh6dUtQY2czb3lQRTFIeXJPRTEy?=
 =?utf-8?B?MWg5bHdldWRISVBRNy9GeUxpaFpJYUFvRnBkTWUvR2JubHFRRlQ3aUdKd09o?=
 =?utf-8?B?bzVPK2hVbkdiWFRNNm0wQVprQkUvZEZkR3dUT01Va0ZrZ2ROSVVPM2Y1N3JJ?=
 =?utf-8?B?amhIN0FiR0hkSDgzbjVmbUJTaTJFWWhFMFBBcWdHMWxhU2JNdXg3RkZRZDBm?=
 =?utf-8?B?VURSRjdEV0pMblFJY1JuR0o2aVo0TStjQnRrNnhUMEx2STJCWCsyQ3VjSmZM?=
 =?utf-8?B?Uy96SVJxbFhoY244YUVlYnJlcUx5YzVHd1Z6Q1hkM3pCVm5xOFBEeXJDTTNF?=
 =?utf-8?B?MnlxYjdDdVQ0OXVTdStVSFRubFpHbzRyUFhGNk9XZ1NyQzJzMGZTQ01OTHVa?=
 =?utf-8?B?T01qS0NYTFJ2eUFIMG9wSUpBTktjM2JCamVtYUxFOEQvQnpJeWFxRklaM1U4?=
 =?utf-8?B?YWxEbHBQM0RmQzlJamI0VHQ3K1dpcXFnd1ZGQzkvMnFDVXZJcDRGLzJJbytP?=
 =?utf-8?B?K1Fnd25uRGloWjMxTGRjQVpHeDFUbGRzTlhrc2lDOVg4S3RWWGp1Um0vcWlj?=
 =?utf-8?B?QzlxZlUwN0gwbFZxOUhHWjk1Y2NzZEJjMnNORmxnNSt2cHB0aXQxMXd5Ri94?=
 =?utf-8?B?REZ6cXFOM3gxcklmbGwwdlQzSUtBZmUrRmoxQjFvQUZFUTBCNjk5TEY2MHB5?=
 =?utf-8?B?N2RCVUhaVnZpcmRrU25IVzdmUmpWZEVmQnFkMXNWVlVrTVFVUk96UmcyN0xX?=
 =?utf-8?B?dFdNU3V6aTVlRXdHd21DTjc2d3pldXdoT0Yxd2dEbHhYM1NiUW9EeUxKZmhX?=
 =?utf-8?B?Z0YyaHBIUmtiSldZV2lnYU50WitHTDJ3aVVIRDVKOENLSzVDYjZoTHJCVVpG?=
 =?utf-8?B?eFZGL0JCYUNZSVNXRzNxUTNhaVNYNEt3cUR3VzhNTEZFczdaTkgwNnlBM2ZH?=
 =?utf-8?B?a2x3Q2FERUtPOExXV0lFQWxBSUw2QVh2NUltNVpFU2NOSmVOT3BEQmtyM3Bx?=
 =?utf-8?B?VGJ3WDhNSVBFZE5SekpDbzlYVzA4MVh5b2NFckJyTzFMcHkvY1VZaVl2Rk1v?=
 =?utf-8?B?VUQxNmpuMlFKYStaR0UrSHR2L1g1QXhEeUpOcU83YUV6OFVDQmQxQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba7699a-28a7-4e61-7341-08df084925b5
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 16:50:36.8868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tXkMD6MZVafbjsHI3Z02Esm3UE4hZP+eEirLN3edNk1wP8UOXrv16HIgnRh3J4pIeGJTL8HFB1eDIXtLuBY1EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB7316

`IoLoc`s themselves just describe a projection from a region to a concrete
register. Thus, support it in `io_project` macro too. Also, update methods
that operate on `IoLoc` to use I/O projection.

Documentation of `io_project!` is not expanded yet as the example works
better when `register!` type can specify base type. `io_read!` and
`io_write!` gains the ability to operate on registers as corollary of the
capability of `io_project!`. Examples are not added because `read` and
`write` is still preferrably used instead.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs | 56 +++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 18c71bd765b2..8df268969566 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -857,8 +857,7 @@ fn try_read<T, L>(self, location: L) -> Result<T>
         L: IoLoc<Self::Target, T>,
         Self::Backend: IoCapable<<T as AsRepr>::Repr>,
     {
-        let view = io_view::<Self, T>(self, location.offset())?;
-        Ok(view.read_val())
+        Ok(io_read!(self, try: location))
     }
 
     /// Generic fallible write with runtime bounds check.
@@ -891,8 +890,7 @@ fn try_write<T, L>(self, location: L, value: T) -> Result
         L: IoLoc<Self::Target, T>,
         Self::Backend: IoCapable<<T as AsRepr>::Repr>,
     {
-        let view = io_view::<Self, T>(self, location.offset())?;
-        view.write_val(value);
+        io_write!(self, try: location, value);
         Ok(())
     }
 
@@ -971,7 +969,7 @@ fn try_update<T, L, F>(self, location: L, f: F) -> Result
         Self::Backend: IoCapable<<T as AsRepr>::Repr>,
         F: FnOnce(T) -> T,
     {
-        let view = io_view::<Self, T>(self, location.offset())?;
+        let view = io_project!(self, try: location);
         view.write_val(f(view.read_val()));
         Ok(())
     }
@@ -1004,8 +1002,7 @@ fn read<T, L>(self, location: L) -> T
         L: IoLoc<Self::Target, T>,
         Self::Backend: IoCapable<<T as AsRepr>::Repr>,
     {
-        let view = io_view_assert::<Self, T>(self, location.offset());
-        view.read_val()
+        io_read!(self, build: location)
     }
 
     /// Generic infallible write with compile-time bounds check.
@@ -1036,8 +1033,7 @@ fn write<T, L>(self, location: L, value: T)
         L: IoLoc<Self::Target, T>,
         Self::Backend: IoCapable<<T as AsRepr>::Repr>,
     {
-        let view = io_view_assert::<Self, T>(self, location.offset());
-        view.write_val(value)
+        io_write!(self, build: location, value);
     }
 
     /// Generic infallible write of a fully-located register value.
@@ -1114,7 +1110,7 @@ fn update<T, L, F>(self, location: L, f: F)
         Self::Backend: IoCapable<<T as AsRepr>::Repr>,
         F: FnOnce(T) -> T,
     {
-        let view = io_view_assert::<Self, T>(self, location.offset());
+        let view = io_project!(self, build: location);
         view.write_val(f(view.read_val()));
     }
 }
@@ -1659,6 +1655,25 @@ pub unsafe fn project_view<U: ?Sized + KnownSize>(
         // SAFETY: Per safety requirement.
         unsafe { T::Backend::project_view::<T::Target, _>(self.0, ptr) }
     }
+
+    #[inline(always)]
+    pub fn try_project_loc<U, L>(
+        self,
+        location: L,
+    ) -> Result<<T::Backend as IoBackend>::View<'a, U>>
+    where
+        L: IoLoc<T::Target, U>,
+    {
+        io_view::<_, U>(self.0, location.offset())
+    }
+
+    #[inline(always)]
+    pub fn project_loc<U, L>(self, location: L) -> <T::Backend as IoBackend>::View<'a, U>
+    where
+        L: IoLoc<T::Target, U>,
+    {
+        io_view_assert::<_, U>(self.0, location.offset())
+    }
 }
 
 /// Project an I/O type to a subview of it.
@@ -1686,6 +1701,21 @@ pub unsafe fn project_view<U: ?Sized + KnownSize>(
 #[macro_export]
 #[doc(hidden)]
 macro_rules! io_project {
+    // Register projection
+    ($io:expr, try: $ioloc:expr) => {{
+        #[allow(unused)]
+        use $crate::io::IoBase as _;
+        let view = $crate::io::ProjectHelper($io.as_view());
+        view.try_project_loc($ioloc)?
+    }};
+    ($io:expr, build: $ioloc:expr) => {{
+        #[allow(unused)]
+        use $crate::io::IoBase as _;
+        let view = $crate::io::ProjectHelper($io.as_view());
+        view.project_loc($ioloc)
+    }};
+
+    // Field or index projection
     ($io:expr, $($proj:tt)*) => {{
         #[allow(unused)]
         use $crate::io::IoBase as _;
@@ -1756,6 +1786,12 @@ macro_rules! io_write {
     (@parse [$io:expr] [$($proj:tt)*] [[$flavor:ident: $index:expr] $($rest:tt)*]) => {
         $crate::io_write!(@parse [$io] [$($proj)* [$flavor: $index]] [$($rest)*])
     };
+    (@parse [$io:expr] [] [try: $ioloc:expr, $($rest:tt)*]) => {
+        $crate::io_write!(@parse [$io] [try: $ioloc] [, $($rest)*])
+    };
+    (@parse [$io:expr] [] [build: $ioloc:expr, $($rest:tt)*]) => {
+        $crate::io_write!(@parse [$io] [build: $ioloc] [, $($rest)*])
+    };
     ($io:expr, $($rest:tt)*) => {
         $crate::io_write!(@parse [$io] [] [$($rest)*])
     };

-- 
2.54.0

