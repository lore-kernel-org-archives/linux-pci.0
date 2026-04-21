Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020082.outbound.protection.outlook.com [52.101.196.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB4C3DB625;
	Tue, 21 Apr 2026 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776783402; cv=fail; b=GMUu7RER7ie5av4FjsPbnodKA+1jdDAC7iyLOD7zAeSgH+nYygxTQmhvNv8bVV4+WEeTQKUTwC6hsXccqOeP6z6SlUVsve08sUXhCKj7wITzyNC5C/jjrZVWBt9EsRIhp0m6nSWWwBR7Lnhk2NmGL+lWB1P1cjvAyGAJfbO4W3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776783402; c=relaxed/simple;
	bh=nYKQK/f1KfskLdodznB/5NT4h/cZos/SolizpGrj0LE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lE3rHXKCrAvdEDWJWWAmfzL1jMk4lwi3IjNVClELcDDqcEyWkSoJpRm4nxn7200rIh/EpKWtBjQPoyXCjKl9E50ypc7r2LBEr3jzIVAgKj9P2C9rreFIBTfOdtmXclc6Lj8qAiHZ3/asiMqKsgZVJqS3/5DZlk7wwF/hcWAcaw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=VqbSJBQI; arc=fail smtp.client-ip=52.101.196.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="VqbSJBQI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ij/bqBuc40tPgaS6OszEXxbxBRww/YcKm6uJ1f6kYZQYW8H2TpWmOAuv3dUX7dRpGXPQSE1eoJay07h8q9clJ3NVdBBAvV3HjeHhYn5p4cmRBPbBxTdC84Gr/oAZn8Nph5IrgOH2h9ajr3BpiePN98VtI4jRxT3qpmfT2X0WWuym0iS5/clZ+KeuBUsTGWdCfBNwEQfVlbFIucntpRrlCE6ZnOJ/WmoUfyRw57UFgaHviFwMXEoNjBGbjqnrOTfF+7r63I5Hlnau3NOwPwNKr1H36AL9sA8wHT9EqqKCTxMpnhmjygaWSzaayD+rL/YCluIYUmY/yRUy0rAy1xpJwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KherrrE+rsrXm3BlkG4oiDUH5/nddaBLxhmqGt2+OeY=;
 b=acQCdL3MUP1VUWaAG4K/yX/7sUympzQHF9seVUbdmcx+jM/DjeEoJraZcdmtNELaqiTjPKqDcZv/EauBwKtjx+GYGYET73eDGpltpslrMii+g2daKmNLHamcrjFQbg+IbItIii5sc1IzLC67x6hY1w3PUKiZh5171Z7GeXtluzS0gcjmKd2C1UpWW0AvvDSLHnsg9794Doz2A7XZ9jk9m+Yg9eIXtNq/pQHDm8tY0cScM62FCkm2jwGu7mcbXw14Jn93GKuXANwo4FS8Fl8g/H+aEwGwRPioU3Jrfp7OVcUHtSkZbFcvykFlRHVeA3NtGgs7XYpocqroABmHhQLFmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KherrrE+rsrXm3BlkG4oiDUH5/nddaBLxhmqGt2+OeY=;
 b=VqbSJBQI3SvwFDkI62FBhved/I9643ZWttr/MB6Kt9H1iG9pp5K2+JlYn2Cg/FpNPMvQdMCzz4c9Lahs1pSHkwaGRSsEIjpRiD8CwCSkJAtYgnSCPWoQQIcws0dFxiF49f+INdGpfIBeNUxhUi6iiptR/2sxAT+Ccw5oixcOPvs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB5523.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 14:56:27 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 14:56:27 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 21 Apr 2026 15:56:12 +0100
Subject: [PATCH v2 01/11] rust: io: generalize `MmioRaw` to pointer to
 arbitrary type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-io_projection-v2-1-4c251c692ef4@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776783386; l=8434;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=nYKQK/f1KfskLdodznB/5NT4h/cZos/SolizpGrj0LE=;
 b=OaG5mFrZyUJqCnGEj3sHwSoJsPGCebrOKCATdGc3MWO9XHxsjhqyRuWhIIAwXdsQrGvIpbYtE
 KSXJicQWrJUAzNUDuroHrvxyA8+GIfotk7Sz5peuVeIJbWnKM5pqiER
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
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB5523:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fe97c69-24bd-4ecd-b278-08de9fb62a24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	qebbT1Q96VGI7ZSMcCimdrG9Fuy/tVc3tBIq2V0SvarRhDrIwjpd/CyachTAeM4lN8sD5u96/eZ3sFUVHoRbJ8JaFDbnXbIgLftRDEiUhEVyMYFbgBqwBkU4CMJnTqwSHSg3nMfi1sn0QNl7zJ2xN7LXoQCBUlIRZ7uz9kPFOftQagZoWY7lL48wP3BpmlSs2DlWgufaYz7ghI1+cbafFkTSPB/PhaEVzzT6Ex1MEEE1hp7f41D6M5LHorjjd3JXnTe7gXxtEQiDGzQsIGzVltxF02bYEvUlPmwOUxz4PVaGy7YrWlnJDvoFiAOnWvxjCUpctEsrvVau9Cc8bzqvEvaz9Ul6yn5AfVu6K5XID9t9Mp5k503sOWVIY+bTF8iREOmPYxMGu2RkzcZReg1lwPyiqspyY0BWSxKQFz/kjHEy6ee1mDcAfoqexXFgmkTrDnwbFqsc90bGaVC4bOX4SWI3k1KDn7rTfekGGqbAF1+5UocCKLH1laGHqGn6GIC+XHOEwlCPW1ecVHCW7HrwELCjw0eIeSwf1tjusa6YsfKyaIj6VPS46iU1RzKnjiV1SOvFxz/iX+eIvczsrWu5XbtFnpT51YaDUKEL/vjhm3ZIbNLE2c8a7wby8zbcPq3RGyVwkG59Qf4IgW0YXS/kAnK36jYK6ODCtEC2rFQsFiJWlz5yYrL1kNGPHYa28OCkaBs5XMf7lBmUH2MXhxAD82jS4fbqB2xgIwPiWnACLTqA7IduA15l8mUahRdh98CndMOVn04qBMIL2ZKiqmnTqQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmRPcENsV3dwZndVa1NKQk8zUnJ3M2pMeDRIYVJPTThaQWxJRG9vOVkrbG1D?=
 =?utf-8?B?aVB4cDVzcm5OdGdLc2JEbWRuRjZRMDcwblpJNXBqYkp6OS9HR3pxeXRUcWxS?=
 =?utf-8?B?cEtPUFR3aDc4U0d4ZmgyR29UamMrenprLyt6VmNGMlkwWmlBOHdKeldUdlBk?=
 =?utf-8?B?Y01WM1JicEM2ZTBncElDVWtlZEQzYkVJQWtGblM4R3lWQXpEME9IWGE3UmNN?=
 =?utf-8?B?YnFtWUU1ZWsvaW1maUt2UjJWeVBZTmd2d1ltVk9meFVZcWxsUVZWcXhSTG11?=
 =?utf-8?B?ejhZUmJWWHBhN01MS1A5Sm5YOFBiRjAvbXBCUUVZaFp4Q1JIUWhpODNqQUNW?=
 =?utf-8?B?dDdWdXJiRmtaSHB3dVBHSDZiZDhGcUNxUHE0dVdJeHE1aHFLWm82aDJqNmdW?=
 =?utf-8?B?enA2cFZCR2VsRUlSOEErejE1c2FJNFJ5N3k5UVFkL0RkSkhBNFV0bE0wVDEz?=
 =?utf-8?B?eHFZUzB4UVI3RVJZWjlMWWtVallJdzVMQy9KZDhkdkY5RzFWZC92c3JDb3Rr?=
 =?utf-8?B?cDNVZDYyTlBxL1c5K2FVNVBXTCtZNFVmd3VyYTVQcVZxa0FncjNXYnQrQ0tk?=
 =?utf-8?B?ZjhlVy9LTSttUDVwQ0x1YUZQTFQ5MUIxYkZGaVNHWkNGZG0wS3RJRHN6SHp1?=
 =?utf-8?B?R1RtK3o1Mk0vQkRaMHRqd05wd0p1VGYzY2NmUXhuL0RTSjRrT1VkUWd0QUF0?=
 =?utf-8?B?NGF0SEZXVng0UnQ2NmZWMnh3VnhjK0k4Ym1MRDZTUXlxYWM2ejdMVzZPbkhS?=
 =?utf-8?B?SHA4cWs3dEMvZXkxNWRXZDdueHNURXJPWThsYU9IMEgwaDByYXBsVmdlMWZG?=
 =?utf-8?B?RkhnVG80Z0lISHhtaGsvSmpEV1hGTjZwR1BzeDVQVU5EVmtEcVBGaHJIbnoz?=
 =?utf-8?B?RFFYMXUzUVRSMVR5WHFKVVhVaVQ3N3VrVmR1UXhnZXc0YW0vMEc0RFRaMXQ3?=
 =?utf-8?B?WFJnakhQYzhSQXdmRXlWVEpacEpZd2xTV3JEWDJRV1dpelhzYmk0Uysvb0FT?=
 =?utf-8?B?aVFSaldDVlVtSXFzdEhsVjQ3L3RrVHlLL3ppOEZ5emQ0T0c2aHRTUHllSUJl?=
 =?utf-8?B?TDYxZk1ycSt1TG1pWVUyeEczZTY5V3RVRk9HbmIxRU9ObHdCZWw2L1NJT2Vw?=
 =?utf-8?B?VHh3SkQ0UXlXTjlyR0gzTlA2OFhKTDhSWUp2alcwaUR6RUFldHdvVnptcEEv?=
 =?utf-8?B?bjlqdFRIcWtWa0JrOGQ3T2xMUlMvbkliYWZoL0ZsUTBjWjNsTk1YbkEzVzdS?=
 =?utf-8?B?RnREN0xzV0h2SHFqa3ZpNFExRll1djVvMy90TXdBM2dNdWx6ekdyaTN4ZFhu?=
 =?utf-8?B?VzQrbWlISUYxNlVGSlhtUndHWXNmR3l4em1xUmFCamhqdGt4WWtMMjFrYUhI?=
 =?utf-8?B?Y2xUUzNSRUk0aDl3eThuSnNBVU9TeXp2aGNnRjYwT1lDVm5OQ2R1TXFjUUta?=
 =?utf-8?B?cmFveFNZc3ZtdWlRMWFIVk1TOXpPY2pqRGtpRndjUW1XV3E2TG5sL045ckRS?=
 =?utf-8?B?bnByQkp5U1lvVnFJZnZwMWNyNzU3Wm1jVUhZN2RwK2RVamxRTitxSkRLMnEy?=
 =?utf-8?B?cTczdFNPcG1uTGtlcjc5Wk1wSnR2RDJ1S2diR3ZPNkRJMFhKWVlIVjBiMWd5?=
 =?utf-8?B?M2xFeGZEeXBSRWdvamxzOHRKNFhDYU0xbjZOZkVNRU9BU3dMM05JRmJTRHdO?=
 =?utf-8?B?VXFRTXp4bXJaNDF4dkVvZ3BJK0QwVkloVmhCbkQzVERwSXdFaWpoZWZtOWt5?=
 =?utf-8?B?TE1qS1Exc2NEV1RaMlo5Z3YxUEJkSXhIOVlnb29QRVFpQWp5VzJNREpxYVRl?=
 =?utf-8?B?Z29IdHhrSHFvZWYyWnZaNGV3blg2NTRlOTE3UWRLNlpodGJJRnRLU01aMXBw?=
 =?utf-8?B?RlFmYXdyY053a1R5MjVCR1BOeG94ZTczYy80Wk5aU3hVL1RsLy8zTWdWZU1m?=
 =?utf-8?B?L1VjdlhSaEc0OVo2STdOT0NnbmJkcmdmM2hUVnc0ZkdRM2FqcWJzcis1VjJz?=
 =?utf-8?B?b1VVNVAzVndSRGR3ZHdIZ2w5NDdTbGg5NGYzYUkxQU9oZkpBd1paWGh6dFFo?=
 =?utf-8?B?NkpEeTJJTWM2ak85SUFGSTJPQnNmRlFEQUFEWlJ0dVA2U21RKythSlZsT0xE?=
 =?utf-8?B?dXpvdHcwc0x5SHJtYXVVeVhFTEVqZ1FmWm51dGJadUVHS2ZjS3ZxaEpSMTNi?=
 =?utf-8?B?NkxBRWZvTGhwbndqSVB1RVQ2bDNyVVJUWkRKOGhhRTJaQUUxc2NYbFdvaVNu?=
 =?utf-8?B?QWF6Wm9iVlVPdmhQcWNPSzBZbVJkRmc1TFUyckZzZ05NY3F1ZFZQRXp1bk1n?=
 =?utf-8?B?Y1E1b1NWNjhhMzlQN2JZWDBSZUFibVJhemJFZDduY2QrdFl5V25zQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe97c69-24bd-4ecd-b278-08de9fb62a24
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 14:56:27.3841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VAOCeFOaBsvJtMWVG/hLi7gEv+m/cJdRJmxZ5chFbv59HHBvFBVRIM0U+nEraD/YAFLGMPADWMU5752fRcG6jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5523

Conceptually, `MmioRaw` is just `__iomem *`, so it should work for any
types. The existing use case where it represents a region of compile-time
known minimum size and run-time known actual size is moved to a custom
dynamic-sized type `Region<SIZE>` instead. The `maxsize` method is also
renamed to `size` to reflect that it is the actual size (not a bound) of
the region.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/devres.rs |  7 +++--
 rust/kernel/io.rs     | 84 ++++++++++++++++++++++++++++++++++++++++-----------
 rust/kernel/io/mem.rs |  4 +--
 rust/kernel/pci/io.rs |  4 +--
 4 files changed, 74 insertions(+), 25 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 9e5f93aed20c..65a4082122af 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -71,14 +71,15 @@ struct Inner<T> {
 ///         IoKnownSize,
 ///         Mmio,
 ///         MmioRaw,
-///         PhysAddr, //
+///         PhysAddr,
+///         Region, //
 ///     },
 ///     prelude::*,
 /// };
 /// use core::ops::Deref;
 ///
 /// // See also [`pci::Bar`] for a real example.
-/// struct IoMem<const SIZE: usize>(MmioRaw<SIZE>);
+/// struct IoMem<const SIZE: usize>(MmioRaw<Region<SIZE>>);
 ///
 /// impl<const SIZE: usize> IoMem<SIZE> {
 ///     /// # Safety
@@ -93,7 +94,7 @@ struct Inner<T> {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(MmioRaw::new(addr as usize, SIZE)?))
+///         Ok(IoMem(MmioRaw::new_region(addr as usize, SIZE)?))
 ///     }
 /// }
 ///
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index fcc7678fd9e3..d7f2145fa9b9 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -6,7 +6,8 @@
 
 use crate::{
     bindings,
-    prelude::*, //
+    prelude::*,
+    ptr::KnownSize, //
 };
 
 pub mod mem;
@@ -31,39 +32,85 @@
 /// `CONFIG_PHYS_ADDR_T_64BIT`, and it can be a u64 even on 32-bit architectures.
 pub type ResourceSize = bindings::resource_size_t;
 
+/// Untyped I/O region.
+///
+/// This type can be used when an I/O region without known type information has a compile-time known
+/// minimum size (and a runtime known actual size).
+///
+/// The `SIZE` generic parameter indicate the minimum size of the region.
+#[repr(transparent)]
+pub struct Region<const SIZE: usize = 0> {
+    inner: [u8],
+}
+
+impl<const SIZE: usize> KnownSize for Region<SIZE> {
+    #[inline(always)]
+    fn size(p: *const Self) -> usize {
+        (p as *const [u8]).len()
+    }
+}
+
 /// Raw representation of an MMIO region.
 ///
+/// `MmioRaw<T>` is equivalent to `T __iomem *` in C.
+///
 /// By itself, the existence of an instance of this structure does not provide any guarantees that
 /// the represented MMIO region does exist or is properly mapped.
 ///
 /// Instead, the bus specific MMIO implementation must convert this raw representation into an
 /// `Mmio` instance providing the actual memory accessors. Only by the conversion into an `Mmio`
 /// structure any guarantees are given.
-pub struct MmioRaw<const SIZE: usize = 0> {
-    addr: usize,
-    maxsize: usize,
+pub struct MmioRaw<T: ?Sized> {
+    /// Pointer is in I/O address space.
+    ///
+    /// The provenance does not matter, only the address and metadata do.
+    addr: *mut T,
 }
 
-impl<const SIZE: usize> MmioRaw<SIZE> {
-    /// Returns a new `MmioRaw` instance on success, an error otherwise.
-    pub fn new(addr: usize, maxsize: usize) -> Result<Self> {
-        if maxsize < SIZE {
+// SAFETY: `MmioRaw` is just an address, so is thread-safe.
+unsafe impl<T: ?Sized> Send for MmioRaw<T> {}
+// SAFETY: `MmioRaw` is just an address, so is thread-safe.
+unsafe impl<T: ?Sized> Sync for MmioRaw<T> {}
+
+impl<T> MmioRaw<T> {
+    /// Create a `MmioRaw` from address.
+    #[inline]
+    pub fn new(addr: usize) -> Self {
+        Self {
+            addr: core::ptr::without_provenance_mut(addr),
+        }
+    }
+}
+
+impl<const SIZE: usize> MmioRaw<Region<SIZE>> {
+    /// Create a `MmioRaw` representing a I/O region with given size.
+    ///
+    /// The size is checked against the minimum size specified via const generics.
+    #[inline]
+    pub fn new_region(addr: usize, size: usize) -> Result<Self> {
+        if size < SIZE {
             return Err(EINVAL);
         }
 
-        Ok(Self { addr, maxsize })
+        let addr = core::ptr::slice_from_raw_parts_mut::<u8>(
+            core::ptr::without_provenance_mut(addr),
+            size,
+        ) as *mut Region<SIZE>;
+        Ok(Self { addr })
     }
+}
 
+impl<T: ?Sized + KnownSize> MmioRaw<T> {
     /// Returns the base address of the MMIO region.
     #[inline]
     pub fn addr(&self) -> usize {
-        self.addr
+        self.addr.addr()
     }
 
-    /// Returns the maximum size of the MMIO region.
+    /// Returns the size of the MMIO region.
     #[inline]
-    pub fn maxsize(&self) -> usize {
-        self.maxsize
+    pub fn size(&self) -> usize {
+        KnownSize::size(self.addr)
     }
 }
 
@@ -89,12 +136,13 @@ pub fn maxsize(&self) -> usize {
 ///         Mmio,
 ///         MmioRaw,
 ///         PhysAddr,
+///         Region,
 ///     },
 /// };
 /// use core::ops::Deref;
 ///
 /// // See also `pci::Bar` for a real example.
-/// struct IoMem<const SIZE: usize>(MmioRaw<SIZE>);
+/// struct IoMem<const SIZE: usize>(MmioRaw<Region<SIZE>>);
 ///
 /// impl<const SIZE: usize> IoMem<SIZE> {
 ///     /// # Safety
@@ -109,7 +157,7 @@ pub fn maxsize(&self) -> usize {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(MmioRaw::new(addr as usize, SIZE)?))
+///         Ok(IoMem(MmioRaw::new_region(addr as usize, SIZE)?))
 ///     }
 /// }
 ///
@@ -139,7 +187,7 @@ pub fn maxsize(&self) -> usize {
 /// # }
 /// ```
 #[repr(transparent)]
-pub struct Mmio<const SIZE: usize = 0>(MmioRaw<SIZE>);
+pub struct Mmio<const SIZE: usize = 0>(MmioRaw<Region<SIZE>>);
 
 /// Checks whether an access of type `U` at the given `offset`
 /// is valid within this region.
@@ -767,7 +815,7 @@ fn addr(&self) -> usize {
     /// Returns the maximum size of this mapping.
     #[inline]
     fn maxsize(&self) -> usize {
-        self.0.maxsize()
+        self.0.size()
     }
 }
 
@@ -782,7 +830,7 @@ impl<const SIZE: usize> Mmio<SIZE> {
     ///
     /// Callers must ensure that `addr` is the start of a valid I/O mapped memory region of size
     /// `maxsize`.
-    pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
+    pub unsafe fn from_raw(raw: &MmioRaw<Region<SIZE>>) -> &Self {
         // SAFETY: `Mmio` is a transparent wrapper around `MmioRaw`.
         unsafe { &*core::ptr::from_ref(raw).cast() }
     }
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index 7dc78d547f7a..9117d417f99c 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -231,7 +231,7 @@ fn deref(&self) -> &Self::Target {
 /// [`IoMem`] always holds an [`MmioRaw`] instance that holds a valid pointer to the
 /// start of the I/O memory mapped region.
 pub struct IoMem<const SIZE: usize = 0> {
-    io: MmioRaw<SIZE>,
+    io: MmioRaw<super::Region<SIZE>>,
 }
 
 impl<const SIZE: usize> IoMem<SIZE> {
@@ -266,7 +266,7 @@ fn ioremap(resource: &Resource) -> Result<Self> {
             return Err(ENOMEM);
         }
 
-        let io = MmioRaw::new(addr as usize, size)?;
+        let io = MmioRaw::new_region(addr as usize, size)?;
         let io = IoMem { io };
 
         Ok(io)
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index ae78676c927f..0335b5068f69 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -148,7 +148,7 @@ impl<'a, S: ConfigSpaceKind> IoKnownSize for ConfigSpace<'a, S> {
 /// memory mapped PCI BAR and its size.
 pub struct Bar<const SIZE: usize = 0> {
     pdev: ARef<Device>,
-    io: MmioRaw<SIZE>,
+    io: MmioRaw<crate::io::Region<SIZE>>,
     num: i32,
 }
 
@@ -184,7 +184,7 @@ pub(super) fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> {
             return Err(ENOMEM);
         }
 
-        let io = match MmioRaw::new(ioptr, len as usize) {
+        let io = match MmioRaw::new_region(ioptr, len as usize) {
             Ok(io) => io,
             Err(err) => {
                 // SAFETY:

-- 
2.51.2

