Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020086.outbound.protection.outlook.com [52.101.196.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1074384CC4;
	Tue, 21 Jul 2026 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784652886; cv=fail; b=GA+5cwp4/g1mO5E0yJLaT8rPvz/dJMEUBEo3EJ7pExGcYpNKsjm9BP+zhp5TU0WSEGnITYdDl8NOUkszZrnI/okFjBX/M8XoDMIyQJfOsfUPixhk/9xthr5BI+0quYjhqjVOz/mcEY9mXi3dhcudRKPgpk8Vvhkzh9/AxjX15LI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784652886; c=relaxed/simple;
	bh=ytBzPDgdYHcUQOkTvpajw+z5xUNMQfhuUYLGbkFxHXM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Sc3NMK7xQjkba6Q2VlkAeiXi1jVn+/Mfk4uH3IVbQQXs1/abfa+kRgowSbfO/VgcXAnn1GBKBQ1w0J2oe6/bHy8a4+LTL/gI89TaqeYXtaatLKYhBEtaAE7N7yY0xFHsF8LcFWUCQPpw2S1hO/Z9MUPh7dsFG1tIvs+0mVZUqmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=K+oqBW1l; arc=fail smtp.client-ip=52.101.196.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="K+oqBW1l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfU7jdiDINk8s71tmX3XAOrF+AaJ908uoVqA2f/qEyF9wEvz8el95qCsfpWk/okVgShEGrgV0D0ZxzcAK1g/mWF+Hia2vO6o0YZS6BRdX5qhzu6kJ183QfxRe2EcWZ7sO06YPFN0x8SazeXQ6oEKNjJ22aYWoz2ETmTuS0sRWaXhoh5rPFSNGNhRaRESdlom4dovXnHsmlstqbYP/1YJ3CG0u6menOJ0L4lVBz0NdW/HUTFhyGub3A0jEBsGyr1W9RcTELXl0LIVX+Ew2sEj25nEGGvRtjnXbH80JYKBfOy0y9tgk2tqOTjl/vbPTzmVVkMM85mPghxSoYBzxAgMKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRuRGmh3FNrrueS8zDRFfCMFsMLyRDvXKrzBaZk+Ups=;
 b=YPfM7OBf58ApesegJlHFkOTUZJ4AJEqMLBCHM3mbh+vXrR9+Yko/UcR23WnmJxW8v0W1/L89MWlhA1WC4a7RbIyoL3+gLexC0bPeAtWg/4u3jicfYMDsnIrPwOyHKlwigSQKgxMH5mkhgA9sljP421TNtaN0XTuWMRChIUK5JJ+N3NpZYj3tTS7CdxC5HqVbBGHYUKW2UiRWZkwsFQ4lXjCABUi5qvqhQLWfj2OWp8ILFmAvG19IXaknmWE6upLVnH/SITgJ2j06BCl5mnwRGAifeLmfmC5G2O43ttI310WO0QuvnkSa7e/w2FXDbskVjGCBH8zz+ztZIFNHKHlzYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRuRGmh3FNrrueS8zDRFfCMFsMLyRDvXKrzBaZk+Ups=;
 b=K+oqBW1ltg7dD6Ugbe1Ml6QCEGft/a77qBo4yoChLXMsxfrzBs8Mw4BspeELZ2AdN5IlghyPflA1oUz6bMAres8l9x+4mwZV6Gi8eVjmxd8fCFwe3DBmJrjCQbdl1jJ9e78Nn16lNjX13Nq74xLrZt7rFn3jn33n6OuwAz9TSfA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7878.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 16:54:35 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 16:54:35 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 21 Jul 2026 17:54:28 +0100
Subject: [PATCH 04/10] samples: rust: pci: specify base type for registers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-typed_register-v1-4-452d72b60262@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784652872; l=939;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=ytBzPDgdYHcUQOkTvpajw+z5xUNMQfhuUYLGbkFxHXM=;
 b=rmXDNCGb/KrRf7Ve9/BOxFBd9Zzp8D/pwYjt1iFN4MAr4y+0uaEMGfUlFkEqZTLOIlEz5tcBC
 4VvNpaP5PwADli0Kb1vevJdzojvFkO/y7Y1XeX/Z78DtvnMNA+a+krs
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
X-MS-Office365-Filtering-Correlation-Id: b404e02f-9837-4a9c-607d-08dee748be7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|10070799003|1800799024|366016|56012099006|10067099003|6133799003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	xMrJ9oNuO6QCFk9iNNa5lcd5uuL5f+I2MRgbPIVA2L7Rk6sgtrDnq9Tn20rW+mGu8W/aOls3Qj74yaS6eKXDbB8j6w0MBtpKe84c9Dx57oOgS6Q69ydMFF7iQO5uPpzpccbWV9Tokd8ITUtQkA5bLSgG9DAaqrkTQUONKkNTsyVQBNJzJOt2iM3elG7jzAxJCmqbV/TZNVcqoG+WrFhdpf+e15O8+QiO4DIlS639HI20lGBcwaMG/5dPX2Fa620H+uf8eygd84SS+GtXut1tjDXuK86ra7JgrMuXgnlsSisrwpy71gh4Mpn5gsOq4lVGgGNVpFTcwOTCyXuusxq8NAjPrTY0G/GGCLNJhYe3/z+qFDrC+sgEaZ/s8hBN+FBcP3xlQ85KfPIlY/wRbIwQR2Mzz+lV3pDZiiuFMfDLL6bEFahy+XrS0TOa2L2i5bahFkpaVlCr8hq2Fy5Pa0dOMTx1QaxThwmI7S0bO55G96uYuBOWhUnUQIckt53rayzCm+1ga0KwObJO7TB7yOvqcrtGSqsWZA1fHmdaLSiPFguHJ3zH1AVbmAhDlfb2nZEC52/tyc3tD6SPMXWg2Be9/LDZD/quDn4pUiy1UZORpDCPAXZZ4OIrbTDmPWU4MpaOrqk1Hig4joLTbw4P7iLKxp/GjaCbXdGS+EZMVDLyo7NeAVpcuuJFcTtZBCWHx+EheXUPJUHldoSkdhShGlehXA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(1800799024)(366016)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkhCd2ZqcTVPR0FXQXNTdUNkOS9QS3FFK25mbk9QTjhDZ1luMlovVU9KTk5k?=
 =?utf-8?B?SktQdkcyalc1aHRmaUFWUXNIcHhxVUVBSHZJN25HWHVKOEpWVmxueEJuekhC?=
 =?utf-8?B?RmQyc1B1bHE0cTQyZ2FWRCtGekFEWWlVTTM4TGN1ZlhZTXVoWGJpdi9mVVNa?=
 =?utf-8?B?M0VGSldQcm5aVlZVdlZTNGdsZWRUUy9xY3hBRzdzZGVoMURpZkFsT3d6ZUNM?=
 =?utf-8?B?a0JjTDJOY29ydnZqSUxOVGwxNTNuTWdLa2o3b28zeTh2SjNPL29UbVJvcDly?=
 =?utf-8?B?THJuOTd3cjBTK3B0dFVqZWlrWitNU1ZVT3I1T0FiNkxydVFvNFlaSHRxaWlv?=
 =?utf-8?B?Z1lrc05UREk4MkdGTzl5VHVGUGZGNTBVWSs2VGI0YjV2VHBiTHlyMjUydTBy?=
 =?utf-8?B?OE41Y3ZyVjZwUi90OVBxS0hrWWZjenZ3RXRSdFdUZmtzZEYxMzZjTGM0ZWxq?=
 =?utf-8?B?NGhNN1ZZKzZTcjJYYTNsYzl0aTNNK1d6TVBIa21Scit3aUtuU3lpQlljK1Iz?=
 =?utf-8?B?YWN3aFA0cEFnb2ExVUVLbkRpN1FyRG5uOVRJWVdaRmpoR1F1VE05U3d6OGtT?=
 =?utf-8?B?RHZpTWRrVk5HRlFMYm9jT09LZUh1Z3ZkZFFQRURTU3JkTlYyV2tjRkNOTk80?=
 =?utf-8?B?MzBGUUZQK3ZaVWZkUDdwMmJxUmxrQU5Yd29Cc3RVcG8yNmVmby9MSy9YYkFT?=
 =?utf-8?B?OHBFYkNsSFFQaWR5dktzdnphZU9VUk9JYll0c2xxNmhOQkVGNWpnbHMvU0I3?=
 =?utf-8?B?dU5EeWpBZFFlVERucmt1ZzljOXhYZWJmSng4R1JtSjBhNytHdGErVjczbUgx?=
 =?utf-8?B?UzRGOVpLeGdXZUN2L0RFN0owenhmZ0hjWUJERzJuYXFzMktOc29OSHIxempW?=
 =?utf-8?B?cFNnQStoNEdWYXhGNjNCM1RDakF2TjV3SlFXWURnWlpORWo1YjcxQU9qb0Jz?=
 =?utf-8?B?d0laeGZDRU4zL09VaCtJMTl1Mm9MVFBoVWRyWWd4Zk10QU5kZFlzNFBaNVRY?=
 =?utf-8?B?ZnF2WkQzQWN5aWR5RlZLSXhmRDhjcDlXbHZaYzF2dGFZZTZWL2pNc1p3Vy85?=
 =?utf-8?B?MndBZTBqM3cycUJPdlg1emxmQ1NZdWJhb1JLUm1yMXBrNXFoREQxRnplZGpL?=
 =?utf-8?B?Q1NQMndZQmdrcTM0QjM3Rk04VTJOZlMrejQ0aW04M2lXOC8xNzArTjEwVDE5?=
 =?utf-8?B?NDdzWUJ5Um8yM0UzdmRRM25kS1dTRXBpR0NBbU5OTzh2MVB3VjBWRjhoVWNi?=
 =?utf-8?B?VDZMQnhTdEY4clE0UGhzc01MOExsZmdJNm8xM3ZvYWcwNGtWQllmbXVPanoy?=
 =?utf-8?B?cVEyRDdyZUdxMjhQeUNaeWpZckFCbW8zMjBsTUk3aXF1eFFwcHFjVHdEcEJi?=
 =?utf-8?B?Vnh4cjFSTHplc1dOU3VRbUc1SzBEVnZXTlRDN2tuOExVV1hZYldxYTRKa2Ir?=
 =?utf-8?B?WXkyWTVaOStXelY2RzJ3MmFRc0ZZTXRWSkNyZkVhOWxFWDE2SlR3eWhUUEZu?=
 =?utf-8?B?aUc4VDE2VWxIdDQ1aURiZzM0SVJHcWZKNkhEcXA3UFF1YkV6cFF0VlFHODdy?=
 =?utf-8?B?bUY5ZjM1M0syaS9mVCsxNmNjQ2VweUNHUDkveFltMEVTOXp6MHBmZU5ITXJr?=
 =?utf-8?B?RGRSeTNCbGxBNFRZWHh4NzJyck9CdXVXMkZwQy9wYXl1OXo1d0JtKzRETzFC?=
 =?utf-8?B?bFhBeEJnWDk5a21PZE5uNWsyUGYvTUY3b0h0N3lQaXJuRWlWVGFoQklrR3VC?=
 =?utf-8?B?QlVOT0Z3NzJ6eTlqL3FKbGNGZitZdWxVNi9TU1lVQTg2eG9iVGNOS2NXMTRX?=
 =?utf-8?B?TFBEdFpBNkZDWmlEYkxmaHd4M3phMGcvT0dQTWFkYndzNC9YWUhHc1ZXUTVF?=
 =?utf-8?B?a0F1Q0l0VTJWSnpyaWV4WXY5UnlLK3hWSDVEZWhLaGxCMU9MN0VDM2RQem9m?=
 =?utf-8?B?THBSaUZhTWlYQVFMeWV5YWlzRURoVjZidXhSaW1PbHNSdVUyUnp4QnFLMkRK?=
 =?utf-8?B?Y3QwMDZycVFlYkhXTk02WTdEUlNVSi9vOTdpVjBqL1NMaWZ1Sy80dHZlRXJi?=
 =?utf-8?B?bXRESlVJMVZRZkU0UFp4U2NaMnppbWpoZk5xVFlDQWZmRnkxNklwWjFvd2Fn?=
 =?utf-8?B?bE9BVDVWaVVIeTNMcVEwMkozemZYYlJQMStqT0MvYWxkTjY4ZktRY3JPWmZU?=
 =?utf-8?B?NDV1ZjM3QncyN2tJdWhPVUV3OWE4VU5JcU9aUFFOKzdQU1dWa0E3TVJ0aDBh?=
 =?utf-8?B?Qld1Wk1Sc0dic3JGUEZ1M1pnWVpmSHVHcng5VFl4Yys1aGRPaHNXaFo2bWRI?=
 =?utf-8?B?RlZGN1VDa3JhM0VaN1d1N09rTEg0NGhpNlJYUkpYUENrNTJha1Aydz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b404e02f-9837-4a9c-607d-08dee748be7b
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 16:54:35.3166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yX6helg3OV9YGkKStzR8ZtUHkWdp/J3QHIUjguQjiW/xMLo93FhCL421dTbPlY1M2a4WwNE/w+CP7/utJLdR/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7878

The `register!` macro is going to require explicit base type, specify it
for both `register!` usages in PCI sample driver.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 samples/rust/rust_driver_pci.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 1aa8197d8698..aca8af795785 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -23,6 +23,8 @@ mod regs {
     use super::*;
 
     register! {
+        base: kernel::io::Region<END>;
+
         pub(super) TEST(u8) @ 0x0 {
             7:0 index => TestIndex;
         }
@@ -103,6 +105,8 @@ fn config_space(pdev: &pci::Device<Bound>) {
 
         // Some PCI configuration space registers.
         register! {
+            base: pci::Normal;
+
             VENDOR_ID(u16) @ 0x0 {
                 15:0 vendor_id;
             }

-- 
2.54.0

