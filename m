Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020086.outbound.protection.outlook.com [52.101.196.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A7037C0FF;
	Tue, 21 Jul 2026 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784652884; cv=fail; b=CK+8UF3ZuhGDv8KACGZIHZSHCTNz9n7v9Q0pgM5gRkbcqT4zNDkYPh+Kc6Ye1N8pPfC3808pEY4xXFoY1XBDcpB5USMACUwIasTqDvOcXLHg0c+51BDCn+3E0on8hjXNUOszT6mIZKduWbNV8psfcMATADNmUcM3OHAucX3qpqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784652884; c=relaxed/simple;
	bh=RKlPXQIeVwE25TJbDbo2jJ1JHqp1gKN62EqUDFh5udE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=g/GdRY3Fzo/Rss2Yw8GynC/hkF1XylMQlG/daQR7vFIuRYso9TLzqNg9Dfc7xD1A0rG6KV0MGZeTHh4jQojLUdMxRedo0/YmcEWDp0v8XFhAseZFR7gpfyDiy6D4ulGFQbv1v4UE8XaIxWK2OSjVsXoxQt33tHPLhiY+LM95Nzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=urGWbtut; arc=fail smtp.client-ip=52.101.196.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="urGWbtut"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mGZW3g9AMH1yNAFfsEYjjdIigTrtCauK9iQJIJe3xLDepQBHx+RRW96Mr2D3c+SiaQHeiHz81FNH92huq1TZ682TzBWKpgISQhBwyGpSrbx0kXr4sSe3bfbbCwvTHw0xYNLTyGBzZVq15qbO7xpi5aQnmMDoCrp9Hx8hOVd0VJTWf5/dbG7RiYNEGuiZMro/HdvTNGpC+Ydyw53/8CASw/QJhr+yqRwAndCEuTzlVIx/SjIXk1Vyj0Sv38xRnuTb1O+peZH/9ZDS7xRkWcvMdkOfUXnd/Q7nifiWlYVoK7eMOacIN1zuCT352G2lxZq54458M5MB2ZH0OOEnEtbNZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=As+buIbTDyIVvTDk4Plvpn/1BAjMTteMMWjIWgKGcJM=;
 b=RAQ3zC5kwH/xwXQgDFMuJ6EmniIrddTrgtLgwXVo/GKg+FiF+cSr9eCpHXmBstY3xV1UUxBPkAFK/YxccPW/jJgGZWohdor4EWdlhmwTCP/yqMzb4Kf2sfPtkANMmHsF5vXnYn9xMR6PIK6WXcDHhxdKwvEobOz/5b2ipmIzwVYZMT/eI5Ac7F0RY1ZX8ZE3xWBFroFcW8/968++wblNlbxPRQDnX71PjjHTmddZW6WPzXhTXm8WyHsxlameqGkC3frt7ZzGw1gD20ETo6pU9DnauLt1yJbtMAsQUbZtM0WA/dgYgNJlLpID8rvYcUPWbUdoqQEJXZYvW9JeKhH4Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=As+buIbTDyIVvTDk4Plvpn/1BAjMTteMMWjIWgKGcJM=;
 b=urGWbtut8F68WPF10UvqzzCE9G0ovY1dvfUnnpw+HvAviIFKq1DubIeDO/4R6y3a7AyEPQCcD+Lqi3f0Bd/l3ESs4qTGu/rhbpnHnPryZ8TNf2LqyvizSEbHTMQJAKkXfgsQe09nbgTlYseLoIUkSSBBlf61g+hoA0uZA2gZcns=
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
Date: Tue, 21 Jul 2026 17:54:26 +0100
Subject: [PATCH 02/10] gpu: nova-core: specify base type for registers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-typed_register-v1-2-452d72b60262@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784652872; l=8641;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=RKlPXQIeVwE25TJbDbo2jJ1JHqp1gKN62EqUDFh5udE=;
 b=G2V0jN3aVmE+51teSWwx/lqrkwktnviNtrT5f01Ff2nC2mXj1BvlM3cCoZe2unM9iqjK+FSG/
 vt2ZuB1m9ggCP5VFzTTPp07e8LnC+x76zbLX+b8cmcXbZCnwUd9hh+0
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
X-MS-Office365-Filtering-Correlation-Id: 48250de1-954f-4b6a-9448-08dee748bdd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|10070799003|1800799024|366016|56012099006|10067099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	fUy3t1PN5LtoqYRDNig0R5MVdlkDcODgue4zElED7NQHV7kr+cr8UyvsQvBfAjsEw3yxXB+TPihBdvrMufRWnYhEhitKBChskTlFgGWSfHnTIeaLFR/5vW8t/nxXNvASFCcxILioJfEbWmSeXG2ptmwHp+k1EDVD74TgRVlbgSm2kflOfFEiwZJjTtXCPDDOrxvgaTvoNFRTKWojnIkFlB4YMT5dv+1GF3GXVvs+gmQrABPVhxoTjwbZHOHLhslzJysTocPrrEr88k7tB3/PbtfVwSm7Kdbv56/m/QfhgDPhp43EQ7VVXm5/bSY9S/oWZwUZ2orlg/8yEpzpHlz74+gZgdz1pjMAtbHkRax5+EN491ELmnGo7fgzLF0oJPUjBFqBEv6JdhfkY0h4ul+SgdChtqyFlXdR0SAwO/HHTPCYenaQ6e7h9FFcUEAfMLd/Svy49Qx+LApNHeY7cdRCgEuue1Tfzp1P0JeWQAlXX+TtjBqYHvE2rUAJxsPrQoqePAy/VobCu3RGH6hSUU/rJbMlATQ8QJgHHM+WJ8DGVvzzHO+jDKH8NFm/uJpb9h7cwxThWpXg5ELmnDOBy3mTXpfV2FqUSxZ66w9rq7cue1vrrlyTZ7MMPaPR8KqXdqwzy+KtPAS9z5A99/l6btzfTCMXwCskdgTiJ4k0OkAHZSO3enAhRgieyI75rQc5j6y/Dmslz993n++SEkP73FpMUw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(1800799024)(366016)(56012099006)(10067099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eU1ZRm1RclowOWFyNGhKNDNGamRVdlVlK1VBcVN6c0dwU2tqZ2FJeDlMSnM1?=
 =?utf-8?B?S1ZSSlJCWXV6YnVHYWYyUFFDU3RKSU52V096L0pXeGN5ZmpPcDhMenJYd25F?=
 =?utf-8?B?b1RMZ3NVQTZ1Q29Dd2hQNStUV1RMcU9TSktMZ2MrR2hDZEFLRmxqdTVUc1Uy?=
 =?utf-8?B?eFVPWVg2VXRLSERFbk40VVh1cHFoakdOUGg2NU1NMDFoaTdqbngyK3JpbzdY?=
 =?utf-8?B?cTdaUk96QS80QTZhVFRiN1J6K0J3cjZ3bkROeDJLNG43RnZpdms0YUNiQnVC?=
 =?utf-8?B?VXVJQUpHZmROcjdpLzRjcU1odmFBYURsQko3T2tMVWRwc1hZWWo5a2ZwbVZ4?=
 =?utf-8?B?THF1QjQxY0dYSFFXaE1LU0p2ZUJYaFlxM1A2V0dXbm45UUc2bk51OXlDMmlD?=
 =?utf-8?B?WlZQZXplUkcvcmxHZEdVWkpNMzNNS3VQWlFvU05BOStjMUJGem04RlhzNlBC?=
 =?utf-8?B?aVVQeGpXZXdMRXQwVE5zYno5SWVqbS8rU2xqa01hbXNHbWM0dU44LzRqcFpU?=
 =?utf-8?B?NTFmd2tjNlR6aVNYcW5aUmNEYUcvSUVrMFl3cDYrZERiQVUxQXlRRTJTQkMx?=
 =?utf-8?B?ZTlKcy9KWDJVWTB0akFKeDcvenAzK1c5U3pvR1puQ09EZEcrU0JucE43Z05p?=
 =?utf-8?B?VElzY0FycTFzZG9aZFRvNG5FVFkzVkxONVVxaVYrdU0xNURGV2pNSENOVEVF?=
 =?utf-8?B?KzdhWGxRd3dHM0FLMjY3SGpENUlDcWwvazZSTlZXZzljOVpWNEFQM1hrNDNs?=
 =?utf-8?B?eVovMCt6OGUyanN5RG9pOVNLVzF3ZnJhdjV2aCszS2lYYzg1Rzc5WUVMTDUw?=
 =?utf-8?B?cm54K2ZWNkNqaDZWZUpvaDVuSW9vREthcFlCU2p3OEhpTzBBOHhoblAwMUR4?=
 =?utf-8?B?eFpjUUV3MzNNVUNSYkRsSmpNYldnR3ZXVFVac3Aza0pHUzVXUjZhLzVsOE5z?=
 =?utf-8?B?SHhQNFlEY2JHc3BqNXdLdXFHNURLUFZvSnlPMnc5YlpBaXNLdWhZZEtRazgw?=
 =?utf-8?B?UEhzT2ZjdjFmZG5wTFA5c2EzUGhFUDRSOS9keWh5UUdCWlpVZ1loZ1NzYTZS?=
 =?utf-8?B?cFQ0WHVsL3BUU0xDajF0UndSTm9kMktZeVczbUZoSmx4YUdIb1p0eXF4VUZO?=
 =?utf-8?B?b0dndDliSnQzYUpLeGZQVy90MWtHQnp3eTBYcTg5ajgrcFk2SmhiNVlQb2lo?=
 =?utf-8?B?UzdVQWpwaTZPMTNMajBJcFlvejhlWGVrdXZEc3R3ODVlaWJtQ2U4NTJRK1lM?=
 =?utf-8?B?OTQxT1hFOWMxdHc0a0t5NFFyMUhkenQzYjlPUHUrTUVvdHBRUDU5d2p4Mngz?=
 =?utf-8?B?b0ZIYnBjdW8zdnRYMWxKcmhWNEg0ajA4N1BRRHVSbTEzcnZ6Q0pZMHEyN3Zl?=
 =?utf-8?B?OU9YRW9OYlU3bDE3QzFZbWpWTTdPWnA0SHRwUVUybDFoNEgzT1QyZTFpWWsy?=
 =?utf-8?B?TXJIcVJYSVFtVWJ3TWhoUWxMeFp0RjJ0bytPNVl6L2M5aUx4M1htcHgvV3lK?=
 =?utf-8?B?WVorUGxXcmVLZHZtTzRsVHArMENNUUdCU2FWY1hSb0dSOXkwY3hqS3IwQjNT?=
 =?utf-8?B?ZjlQRW56NkdJVjRVUjhOYXd6SkpwT2RqYzBCNWs5V1BHbkFWL0NrWEkrNjV2?=
 =?utf-8?B?Nm02SmRUVERTZDJtVEhKa3BpZ3VXZlVZREFINlRrUkVHemd2MjI2T2ZnN3RT?=
 =?utf-8?B?bTNsQm4zVTdwUzViQ0t0SEFYVlRGbnVPRkgyYzBUK25Ud3RuaFFITXVNNmJv?=
 =?utf-8?B?K01JdUlvMjRXTUQzZlU4NlB4RnNGR1F4dmhOUFZLWVI4ZWMzbHlEU1VXTzdE?=
 =?utf-8?B?bTV4VWNpd1hTRlFTNDZNaFVDSldQODN5eGhFWjRoZXdrbE1WdUZoU0xTdlFK?=
 =?utf-8?B?RUVmZHpqbjJDSWhTQWxsQXF6VGFGQTA5ZTB4b2tqdkdkeHdGSC8xTkhMTHlW?=
 =?utf-8?B?bmYrTTM5ZitPWC91L0ZxekZOa3JtVjFMZzNNMFlhSkZiaVBBV1NVWitDS0lZ?=
 =?utf-8?B?MmVQa0ZVTUF0WWMxQWR4VWlMclNxTHB0Mk1xcnFtQ3ZLUmY1MnZ3Z1FHaEVr?=
 =?utf-8?B?Y1BmQUF5eFIzMzFjMTlTRFRKWFJ2bzFzRFZFVHIzbXdNRGxYSi9Kb1E1cUJB?=
 =?utf-8?B?Uys4RGZmTmNmZzMxZEFJZ0NFbHlFWnFmTXdHVHVzTERidlNMTVcya2dhK3dT?=
 =?utf-8?B?R0JyeGpDSGxUcDFNdFJ4Wm54bDZ3bVc4NWdBQUlUUjNUMVYzQjJRZkNtdlZR?=
 =?utf-8?B?NzQwK1N3OTNUYWlualFZblIzYVNHSkpLa3ZCRzV6UVZ6RFQzOU54MFRpZGZw?=
 =?utf-8?B?MDVXNXIxREVYcHptV1R4bnNZdTlDbnIvSGRqUm1zYWNRS0dKdWxndz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 48250de1-954f-4b6a-9448-08dee748bdd3
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 16:54:34.2226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rOiztYiI2MXh92wh5HWAnqh9V1EmQYPQLJwKqcXbIBP288nInbbp8HToRRNhlH9Xus82x0iJhqkMMUWnpRlC2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7878

All registers use the same base type, which is `<Bar0 as IO>::Target`. Thus
add the base parameter to `register!` invocation.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/nova-core/driver.rs   |  1 +
 drivers/gpu/nova-core/fb/regs.rs  |  4 ++++
 drivers/gpu/nova-core/gsp/regs.rs |  4 ++++
 drivers/gpu/nova-core/regs.rs     | 42 ++++++++++++++++++++++++++++++++++++++-
 drivers/gpu/nova-core/vbios.rs    | 11 +++++++++-
 5 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 48380ac15f68..fe82363a8201 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -37,6 +37,7 @@ pub(crate) struct NovaCore<'bound> {
 const BAR0_SIZE: usize = SZ_16M;
 
 pub(crate) type Bar0<'a> = &'a pci::Bar<'a, BAR0_SIZE>;
+pub(crate) type NovaRegisters = kernel::io::Region<BAR0_SIZE>;
 
 kernel::pci_device_table!(
     PCI_TABLE,
diff --git a/drivers/gpu/nova-core/fb/regs.rs b/drivers/gpu/nova-core/fb/regs.rs
index b2ec02f584be..4296bef5f262 100644
--- a/drivers/gpu/nova-core/fb/regs.rs
+++ b/drivers/gpu/nova-core/fb/regs.rs
@@ -2,9 +2,13 @@
 
 use kernel::io::register;
 
+use crate::driver::NovaRegisters;
+
 // PDISP
 
 register! {
+    base: NovaRegisters;
+
     pub(super) NV_PDISP_VGA_WORKSPACE_BASE(u32) @ 0x00625f04 {
         /// VGA workspace base address divided by 0x10000.
         31:8    addr;
diff --git a/drivers/gpu/nova-core/gsp/regs.rs b/drivers/gpu/nova-core/gsp/regs.rs
index a76dea3c3ab0..34ce8dd1f464 100644
--- a/drivers/gpu/nova-core/gsp/regs.rs
+++ b/drivers/gpu/nova-core/gsp/regs.rs
@@ -2,9 +2,13 @@
 
 use kernel::io::register;
 
+use crate::driver::NovaRegisters;
+
 // PGSP
 
 register! {
+    base: NovaRegisters;
+
     pub(super) NV_PGSP_QUEUE_HEAD(u32) @ 0x00110c00 {
         31:0    address;
     }
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 397124f245ee..f2aadeb429b8 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -13,7 +13,7 @@
 };
 
 use crate::{
-    driver::Bar0,
+    driver::{Bar0, NovaRegisters},
     falcon::{
         DmaTrfCmdSize,
         FalconCoreRev,
@@ -37,6 +37,8 @@
 // PMC
 
 register! {
+    base: NovaRegisters;
+
     /// Basic revision information about the GPU.
     pub(crate) NV_PMC_BOOT_0(u32) @ 0x00000000 {
         /// Lower bits of the architecture.
@@ -108,6 +110,8 @@ fn fmt(&self, f: &mut kernel::fmt::Formatter<'_>) -> kernel::fmt::Result {
 // PBUS
 
 register! {
+    base: NovaRegisters;
+
     pub(crate) NV_PBUS_SW_SCRATCH(u32)[64] @ 0x00001400 {}
 
     /// Scratch register 0xe used as FRTS firmware error code.
@@ -119,6 +123,8 @@ fn fmt(&self, f: &mut kernel::fmt::Formatter<'_>) -> kernel::fmt::Result {
 // PFB
 
 register! {
+    base: NovaRegisters;
+
     /// Low bits of the physical system memory address used by the GPU to perform sysmembar
     /// operations (see [`crate::fb::SysmemFlush`]).
     pub(crate) NV_PFB_NISO_FLUSH_SYSMEM_ADDR(u32) @ 0x00100c10 {
@@ -154,6 +160,8 @@ fn fmt(&self, f: &mut kernel::fmt::Formatter<'_>) -> kernel::fmt::Result {
 pub(crate) struct Hshub0Base(());
 
 register! {
+    base: NovaRegisters;
+
     // GB10x sysmem flush registers, relative to the HSHUB0 base. GB10x routes sysmembar
     // through a primary and an EG (egress) pair that must both be programmed to the same
     // address. Hardware ignores bits 7:0 of each LO register. The boot path uses a fixed
@@ -176,6 +184,8 @@ fn fmt(&self, f: &mut kernel::fmt::Formatter<'_>) -> kernel::fmt::Result {
 }
 
 register! {
+    base: NovaRegisters;
+
     // GB20x FBHUB0 sysmem flush registers. Unlike the older
     // NV_PFB_NISO_FLUSH_SYSMEM_ADDR registers, which encode the address with an
     // 8-bit right-shift, these take the raw address split into lower and upper
@@ -190,6 +200,8 @@ fn fmt(&self, f: &mut kernel::fmt::Formatter<'_>) -> kernel::fmt::Result {
 }
 
 register! {
+    base: NovaRegisters;
+
     /// Low bits of the physical system memory address used by the GPU to perform
     /// sysmembar operations on Hopper.
     ///
@@ -253,6 +265,8 @@ pub(crate) fn is_wpr2_set(self) -> bool {
 // number.
 
 register! {
+    base: NovaRegisters;
+
     /// Boot Sequence Interface (BSI) register used to determine
     /// if GSP reload/resume has completed during the boot process.
     pub(crate) NV_PGC6_BSI_SECURE_SCRATCH_14(u32) @ 0x001180f8 {
@@ -307,6 +321,8 @@ pub(crate) fn usable_fb_size(self) -> u64 {
 pub(crate) const NV_FUSE_OPT_FPF_SIZE: usize = 16;
 
 register! {
+    base: NovaRegisters;
+
     pub(crate) NV_FUSE_OPT_FPF_NVDEC_UCODE1_VERSION(u32)[NV_FUSE_OPT_FPF_SIZE] @ 0x00824100 {
         15:0    data => u16;
     }
@@ -323,6 +339,8 @@ pub(crate) fn usable_fb_size(self) -> u64 {
 // PFALCON
 
 register! {
+    base: NovaRegisters;
+
     pub(crate) NV_PFALCON_FALCON_IRQSCLR(u32) @ PFalconBase + 0x00000004 {
         6:6     swgen0 => bool;
         4:4     halt => bool;
@@ -524,6 +542,8 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
 /* PFALCON2 */
 
 register! {
+    base: NovaRegisters;
+
     pub(crate) NV_PFALCON2_FALCON_MOD_SEL(u32) @ PFalcon2Base + 0x00000180 {
         7:0     algo ?=> FalconModSelAlgo;
     }
@@ -546,6 +566,8 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
 // PRISCV
 
 register! {
+    base: NovaRegisters;
+
     /// RISC-V status register for debug (Turing and GA100 only).
     /// Reflects current RISC-V core status.
     pub(crate) NV_PRISCV_RISCV_CORE_SWITCH_RISCV_STATUS(u32) @ PFalcon2Base + 0x00000240 {
@@ -571,6 +593,8 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
 // These registers manage falcon EMEM communication queues.
 
 register! {
+    base: NovaRegisters;
+
     pub(crate) NV_PFSP_QUEUE_HEAD(u32)[8] @ 0x008f2c00 {
         31:0    address => u32;
     }
@@ -594,9 +618,13 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
 pub(crate) mod gm107 {
     use kernel::io::register;
 
+    use crate::driver::NovaRegisters;
+
     // FUSE
 
     register! {
+        base: NovaRegisters;
+
         pub(crate) NV_FUSE_STATUS_OPT_DISPLAY(u32) @ 0x00021c04 {
             0:0     display_disabled => bool;
         }
@@ -606,9 +634,13 @@ pub(crate) mod gm107 {
 pub(crate) mod ga100 {
     use kernel::io::register;
 
+    use crate::driver::NovaRegisters;
+
     // FUSE
 
     register! {
+        base: NovaRegisters;
+
         pub(crate) NV_FUSE_STATUS_OPT_DISPLAY(u32) @ 0x00820c04 {
             0:0     display_disabled => bool;
         }
@@ -620,9 +652,13 @@ pub(crate) mod ga100 {
 pub(crate) mod gh100 {
     use kernel::io::register;
 
+    use crate::driver::NovaRegisters;
+
     // PTHERM
 
     register! {
+        base: NovaRegisters;
+
         pub(crate) NV_THERM_I2CS_SCRATCH(u32) @ 0x000200bc {
             31:0    data;
         }
@@ -637,9 +673,13 @@ pub(crate) mod gh100 {
 pub(crate) mod gb202 {
     use kernel::io::register;
 
+    use crate::driver::NovaRegisters;
+
     // PTHERM
 
     register! {
+        base: NovaRegisters;
+
         pub(crate) NV_THERM_I2CS_SCRATCH(u32) @ 0x00ad00bc {
             31:0    data;
         }
diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index c03650ee5226..9c214b9f4dd9 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -16,7 +16,10 @@
 };
 
 use crate::{
-    driver::Bar0,
+    driver::{
+        Bar0,
+        NovaRegisters, //
+    },
     firmware::{
         fwsec::Bcrt30Rsa3kSignature,
         FalconUCodeDesc,
@@ -92,12 +95,16 @@ impl<'a> VbiosIterator<'a> {
     fn rom_offset(dev: &device::Device, bar0: Bar0<'_>) -> Result<usize> {
         // IFR Header in VBIOS.
         register! {
+            base: NovaRegisters;
+
             NV_PBUS_IFR_FMT_FIXED0(u32) @ 0x300000 {
                 31:0    signature;
             }
         }
 
         register! {
+            base: NovaRegisters;
+
             NV_PBUS_IFR_FMT_FIXED1(u32) @ 0x300004 {
                 30:16   fixed_data_size;
                 15:8    version => u8;
@@ -105,6 +112,8 @@ fn rom_offset(dev: &device::Device, bar0: Bar0<'_>) -> Result<usize> {
         }
 
         register! {
+            base: NovaRegisters;
+
             NV_PBUS_IFR_FMT_FIXED2(u32) @ 0x300008 {
                 19:0 total_data_size;
             }

-- 
2.54.0

