Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010051.outbound.protection.outlook.com [52.101.201.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F3635E947;
	Tue, 21 Apr 2026 06:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776752193; cv=fail; b=tzEs6IzA64QofJ+FrjQbEBzigqG7CaG/mjzhEX1cm9nl4H2rQeH5cC7qGXr9U57Nx1+Wl5WkJa/Niv8Li3U0nHLSpqt2bw6Kvgg6YFj8OR8MuiE6oGx85vrCujHd/5dfYEAgL7SRt+ypZ+tfEExtvpjKEhYlBZm7rC4Bebxy1Rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776752193; c=relaxed/simple;
	bh=T/8ZzJeoRy0uQIgxGJyrBqCuJ8SdDMS4wUtGgO4Fbe8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Rq5LP5f6Nm0rvSW10n4QtM/sQmYPGUwf1t4nAIsRyL4taekVvFIGiPNM3YypP+olja2a8ZYDQtoSEsgJCjNV7qHPsvHFMUKnInNfeRNt1ztFAk30XfbNQtQiKjBQKwl7X80zGw1Tm30J6jjCm+wXFk/aNIMEc4EgH0Tkc1LAOe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=chdytXPk; arc=fail smtp.client-ip=52.101.201.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="chdytXPk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGEuKXFumGC3Bkfmd+28wmhPsPnWDoL4bnjKVFNC4+YhmXcpieMq9scbA3DVYPZHEtQczTC/8+QSiunUgDZLCqTqd1FixziT31A/PU3SyFGuUgfsOyEcAUXxisWqsSQmAN1cOpEWiCFXDt3AEgi/KoYlGZRc0fSnAM+RQWi2thr6B9k6R1qnbDt5GrzGGwNCGnw2sPXYB9vMskdQ+o8xwxVnlmfsj1hpn2F47/c03yK5ZTvVEcyoYKtan9ZoHMCf+OZCH4LBaqXUAjvyYHWCUBOVaHnjYI1LwCK2TLYbjYMx4nJyr4VwcSAB4BVbuTkViMGLX+endwnZIBin7jD0Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aej0PGHVgBDJBO7afDycLS+eCbeq7lFtVUn4AgBSJI4=;
 b=ysFvDCtMTIMxzWX2piKhVH3/LOvLVbNs6MKg37Hermxg04yH86S+y8BMiRIlK6TAY4EXfr6jlMYvd1gshD2eKPaf0nzzpHmv9ex57n45pcSti+jzBcowZ64navNnQR46NyWsAXCwYxARQD0ohZISh5VKLwBXg+Yvxa4sDuopbDwvEUyRkC238HJt+/PDOIR86OPMsfyGPx0UeVf31k/AvLKaRSLjzNwcgPy4J9n59eSPk/WXY6l66btP4Gnnn2bD9mz1ws+zys22SyPPBm4yAeOE39J3rJirKWH1e8JYyi8/TqiY+iGtxGO/bRHYpia/cCvVpBjq7s8Bt6FufH5dXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aej0PGHVgBDJBO7afDycLS+eCbeq7lFtVUn4AgBSJI4=;
 b=chdytXPkT/LrkIPENVjxBkD3eJzoLZ50r4ExAyd+h5aciUDRrclcoUJ2HTWWE2A74j+lV1u0NI1Z52tiwK+Vi2ncXy2kcQ3Ux1GPe8wM5mu+AHEreYtsBT27xAcJJrhLlzuWhgR4lSgTleY02kWsGm6DbbLWWAV581evpBxHZc29P8J+V4GX24B1G40iAEOdDfmQ8sSTa//8Ghq8vi8qQvSpu9UG49I1nZurCojj7cTgRraJ6y9VHoyw8Pnn1VfaZswx0wh23MfYTjKEIWlspKFFsXeRkGNLRoA2GRNU9MqWavpn5IiDllfL4iPXw0vBr83c2sao8RNCfm/08kVGuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CYYPR12MB8749.namprd12.prod.outlook.com (2603:10b6:930:c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Tue, 21 Apr
 2026 06:16:29 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 06:16:29 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 21 Apr 2026 15:16:13 +0900
Subject: [PATCH v2 3/5] gpu: nova-core: do not import firmware commands
 into GSP command module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-nova-unload-v2-3-2fe54963af8b@nvidia.com>
References: <20260421-nova-unload-v2-0-2fe54963af8b@nvidia.com>
In-Reply-To: <20260421-nova-unload-v2-0-2fe54963af8b@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Boqun Feng <boqun@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0127.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CYYPR12MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: 90b8b458-a38e-495d-7b41-08de9f6d8640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7aOFt33bhemAiW9MxuK8LTfd1SRLMqfDxvparlf/FANessjijawPfKvVSIVaDTAY5xhC8rrz7RvDZaR4yL2b6Zyn1wOrHKPuVRXOORUsRXWTN70AyTxPiuHHzKKekIIZKMKYjUU0neBG7sw+ux3YQoaNAHdC6XSY4fytT4OMpjBphDhb2g/933QoZGHPYDnzMCgWSDUAThoBaAounTa4PCmyEJIM+R8jDv8X2P3GsjjWTXjdb78NAy80xZ1OXAx/HXHdkCUaxVKIFBUv8BuK/o2oLTpO6LDLdmDjmsDG1xJou4SiLPOy8GTPe7ugE+V90Ev/SmWW0O4u56tFhpZtRehNO6ZdDCwowd04F976zQB2bDFLb+4Au3rbjtcB1CzgSJOE24cBvP+WaMp5X8In4FE04jLho1uBhZ4jp4bNMEantSEXwZzZRRMv5ygKr+9sZtTrswc4xnzXDF4h0IJdb7ZXFblT7BSAVKHcs/sZJdEtwnIBnahZPdSzdnk3rhzhp2fC6grY+K6WUkBpzbbpiVfUWCD2QiRK9C4YkZfMchCUOs47SuzQFlisLucQ4RpAiP3XRWdnIp3vzts1mwlIOP7L7sSVCmL04AeJryib3uhvZDeUHnIn4F9ZNFH7r2bR1Ryqkt85VpalrFVeFmKxentRwwQY2liPfa73TdeRr3UaIidUX9pt0dxL55uduhOsvkfT6flO0BtUubJSbi9rlyblDxf94ehtCdmAV50Z7FEXh1fwjFqPZGF8l6145ydwbN6Spb3NuUVPRxu835w1hw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWdMdEU1N3hqOEZ5YVI3UjdmdXd0MlgycTZ1WUYvVHh1Nll4dFNFdXZGU2k5?=
 =?utf-8?B?elZmUUhOd2p5Tk9KdWREbHViaXlDc1ZtVzhlT21rS0NaUUo5cXFybXdkSGNL?=
 =?utf-8?B?VHplb3VkazczOW5ncUxIYkJCTzhyMDl2SzYyV1c5WGtIS2J5Ynh1MXlONmI1?=
 =?utf-8?B?MDhWN1FIakNEVVNYcXNVcVVTQTRUTEg3V2V0ZXQzSFJzcnBzM2ozd2RYNXJI?=
 =?utf-8?B?MGhpS0Y0WVBnSGlXKzZLeEtCL3ptcFdXL0x0QkcxNTFBbTVYVG9YTzFlMlBj?=
 =?utf-8?B?R1hwTnJSbVY3YnJFSm5TMkpvWE1mb1BGdUVYNlRMQkxPeXVuRXZibSt6MmNo?=
 =?utf-8?B?bHh1Q2hiTmZoYkZoMmRBWmxHdmlGN2c5bjdSbEVMMDBYZHpRd1dESTE2Uy9E?=
 =?utf-8?B?R05UVkx1ZG9tZXRWejgrTjltdjRVUVE5WllJak1yMmZkMW9pTmM3ZG9KdUd2?=
 =?utf-8?B?emNCRGphbldwK1BaY0VFVG1sbXVOSytHckdvYVZlTmRDWE1KU09MOXlYZXVh?=
 =?utf-8?B?WTlwYTU2MlJDbkpzd0w0RzdJc1BFYUxxSENYWDNXb2M5YjAwdHJoRlA4TWVZ?=
 =?utf-8?B?bXdVTUFTSU1aajJTeWtIUlFLOUFFRWZIdWlDM2M5MkpDamZuVit6OTVKb0hn?=
 =?utf-8?B?M0ZxOXFqOXRYSDJVODZuakNrbUsrUG5QNXhUczI4VG1zaCtzUDdVd3RMbGU3?=
 =?utf-8?B?QkdiN1dWaFh4RjBCSXc2UFVPOWNIRUxvOWx0RmJtNGdCajVHbGlMdXBpSWV3?=
 =?utf-8?B?UDRDcFlEc2lsOG15cnhadk9lRENROEN1K3ZSZlU2bmpzeHBBNzhab3RwZXU2?=
 =?utf-8?B?bDljdTJDSVFHc2xYY25VdEMvTWlhNmp5YjBXOTBnTCs5R1VSWFI0ZjJoME9L?=
 =?utf-8?B?YThOWWl3Wkt3Rm84Y3ZhSFc5ZjFIdjBVMHlaUjZ6U0lJaVd3MWVjNDhCRTRt?=
 =?utf-8?B?SEtBMWhFTDI3NGltd2pSZ1F5eG82bEt5Tm5lY0tTQ0FxaTlEeDdxUmh3WDNm?=
 =?utf-8?B?WTY2eWIwbS83UGxVaTVUYXA0b1VDSmY2eXJmcTErQzBlSWxsYzZ5WmhVdUl3?=
 =?utf-8?B?dzNsWWtoaDN5MUhsWVRjT0U1Tlh1ZC93Yk10N01wUUY3MENoTkZud3dCVE5o?=
 =?utf-8?B?TzlDQ3VUdmNKS3hZSndINTdVbVU2ZEw3aHNNVEptNnFZQUFpbWdiL1YvNE1Q?=
 =?utf-8?B?Tmx2VFlpb29iWisvSzhIMUtucytnd1hLdDZwUnZNczlUSGhsU0wvUWt4TWxr?=
 =?utf-8?B?OVBrODJQb3g0S0d0TzhDaklaZUcyWWpYQTFHNFFpck9vUWlVR0ErNnJ6YkRi?=
 =?utf-8?B?Q2tJMDdWZElnWXc1d2FXc2psbVdYakgrdmZjZjZvMmpzZWo1MHNQYVUzTlRq?=
 =?utf-8?B?aXR5VnFMTTFZMGI0SWtFYmZUaEMyTVBOWjJVRHZQTE95MjlJWnNiQUhHd1cy?=
 =?utf-8?B?UUc0clBSVzhacVFaWlFhR0tiWEZ0WU93TmpPWkQwQ0NIZFNpUHYrR3V2Ylht?=
 =?utf-8?B?M1NwdlE5cjAvTm1hNmpWc0JuRm1xMXlGeDZObUVJZnR1M2taU1ZSMzVqU2pm?=
 =?utf-8?B?OVlDSCtsdjFSMFRjZ0RGM0NtcTNaUmZiSTJydjdDb3ptR1NoZUE2MERMcWwv?=
 =?utf-8?B?V2dNMzdHQ2FxMklBRkdLNWFvZnFIM2pzc09UdGh2OVBCTldYb3h2SHh3Skd6?=
 =?utf-8?B?V0JGTENFR3A1aHFvcm5FaXpxL2lmbjc1anZlNjJJRW9xbFA0MkdZNzJmNnZu?=
 =?utf-8?B?UWRBaVluQSs1K3hYVnprVkw4MjFzYUdzOVhkY3k1c0Y0YTNGUCs4ek5uWk5W?=
 =?utf-8?B?L2VJaTk2cVVRQlRYelhOTEk1VFhGOWFTZFMvcWFCUDloWDVGMGU5TWVleHVV?=
 =?utf-8?B?am5zajRHQXhxU1RKQVNoZXEvdDhFZHFIUkluZXdzSE0vWUx6Wi81WWdsU21X?=
 =?utf-8?B?a1hiV2JRU3ZwLzJKc0dZTVdZR3pSeGF5emt1KzRNN1lzcldXTU5oWHJ5UU4r?=
 =?utf-8?B?QjRIVTk3OExxbW5ubWtZeGVqV3hhWHBOQVd0dFlHWnhORTQ1N1JNS1Fybmda?=
 =?utf-8?B?Ty9TNjdLQzZrUXVmQjRMNENpZjRjcHlhVFcrMVF0YlloMEI0UkRFTkkyTWFD?=
 =?utf-8?B?d1hDS28zc3diMmFxNmgzdXk4ZVRlMTVaNU1USnRJMUQvOVlOVS8xTUJtTjFZ?=
 =?utf-8?B?UFUzU3YxbzJQOUdpaVUvS3N2KytSNTF3d2hsQkVmaE9SSkF2YzAxZVo0b0dy?=
 =?utf-8?B?LzhDcXdHV2h1QTE4eFpCQUtMUnRRMUZNdWI5b1N6UTlxaXJqQkhRcTRVTHFw?=
 =?utf-8?B?RTYrbjdEU204SEU2V3NKeUltV1Jvd05haGpqU0FYM0MzVUg3VVpkaGs4cEpL?=
 =?utf-8?Q?xbCOCs0yCBviHCyMEHspHWvTWQLGLE5n04Lq87vRF6cz9?=
X-MS-Exchange-AntiSpam-MessageData-1: fUObv/q/ITHzSA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b8b458-a38e-495d-7b41-08de9f6d8640
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 06:16:28.9071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MLGssUGoWjrEKx+e/1b9aWNgI0WsxYR1W3P9shVRdvJw6E1pmNQyRHaafyhwhOFE29/l1LV++A92fsO9NNaZ7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8749

Importing all the firmware commands like we did is a bit confusing, as
the layer of a command type (fw or GSP) cannot be inferred from looking
at its name alone. Furthermore it makes it impossible to create commands
that have the same name as their firmware command.

Thus, stop importing all commands and refer to them from the `fw` module
instead.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/commands.rs | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index c89c7b57a751..c80df421702c 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -27,7 +27,7 @@
             NoReply, //
         },
         fw::{
-            commands::*,
+            self,
             MsgFunction, //
         },
     },
@@ -48,12 +48,12 @@ pub(crate) fn new(pdev: &'a pci::Device<device::Bound>) -> Self {
 
 impl<'a> CommandToGsp for SetSystemInfo<'a> {
     const FUNCTION: MsgFunction = MsgFunction::GspSetSystemInfo;
-    type Command = GspSetSystemInfo;
+    type Command = fw::commands::GspSetSystemInfo;
     type Reply = NoReply;
     type InitError = Error;
 
     fn init(&self) -> impl Init<Self::Command, Self::InitError> {
-        GspSetSystemInfo::init(self.pdev)
+        Self::Command::init(self.pdev)
     }
 }
 
@@ -100,12 +100,12 @@ pub(crate) fn new() -> Self {
 
 impl CommandToGsp for SetRegistry {
     const FUNCTION: MsgFunction = MsgFunction::SetRegistry;
-    type Command = PackedRegistryTable;
+    type Command = fw::commands::PackedRegistryTable;
     type Reply = NoReply;
     type InitError = Infallible;
 
     fn init(&self) -> impl Init<Self::Command, Self::InitError> {
-        PackedRegistryTable::init(Self::NUM_ENTRIES as u32, self.variable_payload_len() as u32)
+        Self::Command::init(Self::NUM_ENTRIES as u32, self.variable_payload_len() as u32)
     }
 
     fn variable_payload_len(&self) -> usize {
@@ -113,22 +113,22 @@ fn variable_payload_len(&self) -> usize {
         for i in 0..Self::NUM_ENTRIES {
             key_size += self.entries[i].key.len() + 1; // +1 for NULL terminator
         }
-        Self::NUM_ENTRIES * size_of::<PackedRegistryEntry>() + key_size
+        Self::NUM_ENTRIES * size_of::<fw::commands::PackedRegistryEntry>() + key_size
     }
 
     fn init_variable_payload(
         &self,
         dst: &mut SBufferIter<core::array::IntoIter<&mut [u8], 2>>,
     ) -> Result {
-        let string_data_start_offset =
-            size_of::<PackedRegistryTable>() + Self::NUM_ENTRIES * size_of::<PackedRegistryEntry>();
+        let string_data_start_offset = size_of::<Self::Command>()
+            + Self::NUM_ENTRIES * size_of::<fw::commands::PackedRegistryEntry>();
 
         // Array for string data.
         let mut string_data = KVec::new();
 
         for entry in self.entries.iter().take(Self::NUM_ENTRIES) {
             dst.write_all(
-                PackedRegistryEntry::new(
+                fw::commands::PackedRegistryEntry::new(
                     (string_data_start_offset + string_data.len()) as u32,
                     entry.value,
                 )
@@ -180,12 +180,12 @@ pub(crate) fn wait_gsp_init_done(cmdq: &Cmdq) -> Result {
 
 impl CommandToGsp for GetGspStaticInfo {
     const FUNCTION: MsgFunction = MsgFunction::GetGspStaticInfo;
-    type Command = GspStaticConfigInfo;
+    type Command = fw::commands::GspStaticConfigInfo;
     type Reply = GetGspStaticInfoReply;
     type InitError = Infallible;
 
     fn init(&self) -> impl Init<Self::Command, Self::InitError> {
-        GspStaticConfigInfo::init_zeroed()
+        Self::Command::init_zeroed()
     }
 }
 
@@ -196,7 +196,7 @@ pub(crate) struct GetGspStaticInfoReply {
 
 impl MessageFromGsp for GetGspStaticInfoReply {
     const FUNCTION: MsgFunction = MsgFunction::GetGspStaticInfo;
-    type Message = GspStaticConfigInfo;
+    type Message = fw::commands::GspStaticConfigInfo;
     type InitError = Infallible;
 
     fn read(

-- 
2.53.0

