Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012024.outbound.protection.outlook.com [40.107.209.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D2535E947;
	Tue, 21 Apr 2026 06:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776752202; cv=fail; b=cBKyKvR6dBVsw9qFAjwhzeZxNFOJzRdGrxHGI+2JDihiuNclbKkjswgvecuIbK1D/GpgH1f3eMO6/1ikg9Exo/t1HbQ+ZEOacL3wWl6lbKdw+vostPY7vmXdQK18jE64PaUoowvAbYw4nUupRjHbAwzaPe2dFilxGQgJ8Ltydxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776752202; c=relaxed/simple;
	bh=cXPuak9HUliia3E5O2qG/XBdHMZ9+OnK7bGTReyJr6Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HA/o/fKekd1nl9dDickhALfOo1/sxApoILhph5xKy9usFUdAXO4GG/Dz4C3Gzj47m9uSGDEuT7l/aysPt0Wa6ng2oGHiFa398eNdfuBd4s6RUiKgXItH6Fp4g8I7BnI+U+yd1AZoErrNRcN1W3/PmA9xIXkFA7vLuxwX7UeEusc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rk9w7e2Z; arc=fail smtp.client-ip=40.107.209.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rk9w7e2Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cinGcQKyO5g47N6lFamyjYG6yBuqq34Oz1a2VYovpYZjNLMigDhDo1VEJjhNvE+Ut7XtHTni/SIgcOqDuLI9WqTUSb5IKrJtiMhabubmGmPqjr6Fgy+rNd/72OOZl/Q/j5LN/1W16tnjM/MsH2vlWGkerBLw6vyRd3oyVAM55p+9MgUjFFJ9rBrraR8MMFVbxMWlhYgdP4aPnXyw42cJwQGIUKW6J4an9MgMYkmRCKFyv7TIUXKfV4LaRKU3H2fk+BBuLH656gXWj8lLNwtCa2nNayrc4ha9dv7G5jZxkRYmpGzluuuq1YwggkicPLCJ3OyuIKrxnYMC4792pxj82w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LS/9e/tDax4bkVeHVJ5hd/JEceKzidDFI9TcIg/dzD8=;
 b=FxUz642A9/8L5MQQBtQfO902EQo06PwTkTkPfhtMEo+Dz4xYOV1ucqLrb8ykUk1YmNVxgK8SDsDf6fXy5TOaMEymcsqzu0iHbpZP3vEjrsCEwGrO5c4U5nFWTj5bw54fuNym2CBURSEy4EEAZ3OMRdhCSk3pC2uEjJLdLkjzKj6WzyrR78H7LErycs5/S1LirD8P2i4PUB0Obem4rjLNQ800F9FDEHV6EKno5f43XgsJpCcgoFiGgYFhNPkFZHik24t4htpG/Ze1Ml8kgxRKyHBEGcpfRFCcpNyln+RNYidB11rJauiOSghrMUq424m74UKA6HFd6uMSKmPWy2OJBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LS/9e/tDax4bkVeHVJ5hd/JEceKzidDFI9TcIg/dzD8=;
 b=rk9w7e2ZhA1d8jyWzebDICJ/6qKg5o48Cdwfi2R2DW6ILHzfuWhKTYR/U0B0L/hVxwtfSakWXE8yD2BYHJojFhjIpH5lxUcpCZp/ARANw5ZJH13NWLVGQ049F+tgZTtYWnWYuupvEpiF1vc002sMKrMDtuLa1p4FqpJAdSZ3CQUHGlGiVTRz61HTX3lJmV58TPLmHBZSpFaxeQKR8ntNIUt3zgNBLTIYoCOMo/m6OBy1LmBz3WF+1+YquBjT7iIHhMxefKAbTeLVEOPTQ4Jie/AEB+qE2l1COXFIg13WDvGhXI+Wr7CiDCvROLdlddkXu80RMb70+Q4tmN/j2QxcIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CYYPR12MB8749.namprd12.prod.outlook.com (2603:10b6:930:c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Tue, 21 Apr
 2026 06:16:33 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 06:16:33 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 21 Apr 2026 15:16:14 +0900
Subject: [PATCH v2 4/5] gpu: nova-core: send UNLOADING_GUEST_DRIVER GSP
 command upon unloading
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-nova-unload-v2-4-2fe54963af8b@nvidia.com>
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
X-ClientProxiedBy: OS7PR01CA0192.jpnprd01.prod.outlook.com
 (2603:1096:604:250::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CYYPR12MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: b889574c-7a91-4cc1-8b09-08de9f6d88c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	W3sep71e/OtTKs17dWRAPOurvg0VwynG/M1Z2UbuDuhx3rb8YnF2jJuFWk9ZxFgr+PJUC+UBoyNoregbWr9A1Ygk5maz1IVALsJbc0GyK+TZKQ6D73v3q1w82slBGUVyxCaRcKwQyrOv6mJ8XV51x4w7TQvxsU4IhmVpi+rrfgZ6lfK7N2t/uXdFUE1k1wjQMb1pRBJ13S59p+EqdrHZsnryUAhSBOcKEkAE43UfvPPLKEWTE+umFXTaJSoD1hbGvtH2YQ/JQUfPzHal9AdgZB1WPHPiwiPSPGRL+CPDMqWCX8bL4ydrQB9mAA6Bv85jrIXt/oIQ5MUPp6h7kB5yqA/JFDdMCDcEtbUQwcs9hLxJFxQ/4x8VXNSU75t3DfYzYs3qI/xkKowcLaUcyB3dV0DHabVI58hvjsHi6jXeUTZ49bdyB7Nr8GgLz3p9+2vq9UsJZ8aAZcqt/5jByWUcHXfOVvH2jdVPtMiARtQnmV2eQpzS+kcnTWQwmhK6D7ELe4vkpIC3xeSPdkD9ue/Dr+LMF0Zdxu7QLynZvU9yJTV1hfjBPkjIF/q1bWEO7JjTM6xPX9VHqMJh3RZchQkXWOW6e9TE0VghvcyTPa7Rtk1Culom367vlLiJQr6lUQUL/8duoWGvaiFdj5yD8X/XVGjolc7+B3jjoeUFMZhYmQpLgKDpeaD8l4HA1sYNqnhWqdwGMczErH+fdab/bExNQAPVPMtIcnh0vYmEkOivRvw/QqHaktjiZIP7QbZYbKNzKakDifQ0qxNvO3GNca/wnw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVlxYjRKQVBuQlZydzMrSXc2QnB3R2hPSVBFSlFzN1UyT3ZMSDNNWEtPZ1RU?=
 =?utf-8?B?MnNXcFp6WFdDbkdTcFN1TnJKRFZvY3JkLzJKUEx3L3dZOHB0UHgyZ2QvZG9B?=
 =?utf-8?B?dGlWQTRVL2w2YmpJVmFiUk9yVVYzbXU2K01iZ1BxRkxibU9UWVdoMkhlc1FQ?=
 =?utf-8?B?Vy9aR0JiaTRzalAvQmJmRDhsL2NUeUJ1N3pVM05jK0oyZkxIVkJJaS9PZTFr?=
 =?utf-8?B?S0VpVEhBSTl1K2EwZFZZZ0JoR05ScGIyamsvTTg5QTI0UUdLK1VudnVYQjRW?=
 =?utf-8?B?VG5Rcm43V3JoaDhwQ0lObnBxNU9tdktSNmg4VFhDaTF0MGpLR3ZHL2NIU2JI?=
 =?utf-8?B?V2FOYnJwRlVDQXJDeHdFVncrdHNhSzg2UDI5eHRSOWxYV3hoNkZlRUppVk1Q?=
 =?utf-8?B?L3VGd1N0bE9vMHJWbS9nQjVuTm9Mck04TkFGKzZ6TXZNRk5udjAvKyt3SFBJ?=
 =?utf-8?B?ZENJaURWZ2FMZ2plTC9iNUl4WHJrOU9wNGxSQ3NINllydFVia2dVSGg4WjJZ?=
 =?utf-8?B?cGYyZ1VSQWprZ2x4SGVFaFdKK3BFUENNS1ZidnZmbHJWUlpNNGFJY0lEV2xT?=
 =?utf-8?B?MUZMdzhNQkh3SWpxZ3l1NDBJZEZHZ0lZbWo0ZzRsV1JBb0ZMVXl0Z0ZKTk1V?=
 =?utf-8?B?cDhwaEFwMldDeWlmQVVQajc2Q2I2bEo1S2xzMmhuUktrd0x5bGsvUUNzZkxp?=
 =?utf-8?B?RjJyUnJRaUJ6Vlg0b3FORFdPenA0L1p3YU5TYzFiY0N5em1wSUl2dGRGQW5r?=
 =?utf-8?B?d0V5dmRUMW9FZTRDMmZmbGEwMVJqbFNMcnVyY1JCV2JKZVVKTmxaLzlSSFBG?=
 =?utf-8?B?a1ZSSDNkaHd4ZWIyTm1VN1Fra1BoWjlZb0p3K1hGcUJmcFlZTWZJVWx3WTZE?=
 =?utf-8?B?djNHbStrUDRBYzdwelBqZVlhOHloTGRmZ3NUWEwvcjVvclZCZld0eVd6N2lV?=
 =?utf-8?B?ZXVaanZINmNTNzFxdTNvVW1oWW5waUtGcmY0cmNVN2dacUJmcGdISHRZa1Vm?=
 =?utf-8?B?a1crV1NIOG5qcjFpNEVGeStqcG1vSUxBdnZvT0xDVkVlWUJKYnEwN05HMitr?=
 =?utf-8?B?YTMvY21Ld1JuQysyQk5rZmw2Q0lwc0FtaWRRNWVhbW4xSTJINmc1MHQwNU9S?=
 =?utf-8?B?bnhvbTd4Q2FRWE15dmQ3alErVkNGbkNqR3dCWWtsRjVSQlBqTDcwY05UV0hW?=
 =?utf-8?B?bU1URXl0YTQvVjNITm53VE1IYkRmQVNQTVE4RDJ5Tk5qbjQ0S3ZKR3V0Tnpt?=
 =?utf-8?B?T1kwN21hK3d3b3RTNHRyU05ZT3ZsNVpMWVFkZDJ1NUxJYkQ2MzQ0amZkUW05?=
 =?utf-8?B?eG8zNGZNZkNpTTl0bnNxWmcyaGJBM3JDL3ZzS1dwdlQ1cEZwNlBWbEQ4dm05?=
 =?utf-8?B?cjZrNmtqSEp0c0VFWnE1RjdlT3dxd09PL05UTFhlcG1FcGVDZ3NzSUxrT3hn?=
 =?utf-8?B?alFXc0k0WGNPdzZscHY3MEp6ZnNLT1cySE5MV0ZrOUNYVTk0ZHpRS2VJSzNr?=
 =?utf-8?B?Nm9pT0RMNEx4bk9SY0ZBcmRvK3V0RnFtK051WDNUVXk2V3l5NlVLdnBiR0s5?=
 =?utf-8?B?MnpwUlhIUklSSWhXcEhXUXBGbjJEK01aOWlESXBZS1VCTUFDdG9CckQ4d01p?=
 =?utf-8?B?QkZRTTZHN0pHaGVDazIvMWJrZExER0VhSnh2cmtabGlLdE5WSkkwZk42LzhE?=
 =?utf-8?B?VGFnTEcxN29Gbnd0dmp5RlhRdXhyUTdqaytyM0RTaHQyeE5DUTNoL2VNOUlM?=
 =?utf-8?B?YTVoVHdOSk1mRWp2amN4U1Zha3ZlU0ttVGRsZXZzaURIMHZwaCs0Y3FxSlov?=
 =?utf-8?B?VGQ3T2lwSlRMclZtekVucm02M0ljQ1p2SldGRUcvRjdIcjdPKzBLYldPQ1Rj?=
 =?utf-8?B?OFJhOVZZcHgzcXlzLy95c1BWN2l1S0ZObXpPMVVWSlJBRkhsRHdCYjRBbWc3?=
 =?utf-8?B?RktQc1BIcHhwWWFGbVBYcEw5L0x5UXdPTktZZk83S1dNaUxINmw0Zy8zc2hR?=
 =?utf-8?B?azFMaDNNNlZ1c2hab3hMbC9LbnBtMWx0TkRURlpDY1ZGbWRwRXMwMHpBZ0NL?=
 =?utf-8?B?dFpWQ0syK2puc0tqaE1zNVdRMDByMFZPWkRJWEc1Z1NUTlVVSXpValNsYjZ0?=
 =?utf-8?B?KzVNZXBXd0dUVFJvaHBnRFpLVDUrcXZ6SERXUkZabEYzR0lvODhDbkpLTnpE?=
 =?utf-8?B?Q1RTcGpBTXNZU0JJRUljRDNqR2Jkemg5dEI4enRYU2pPTkkzc29MNkRiR2dP?=
 =?utf-8?B?T1BYVG5Gd3lUM2x0akJkMjZaRmpINnFMNXp3ei91TTlhdWpPVC9wTDJUYVNa?=
 =?utf-8?B?a0RRWjROWUVrZDY1NVlBY3VKSG05VnVRTHNNYUt6V3lTV1BrWkdNcnVtMmI0?=
 =?utf-8?Q?UJ8v9YuWrub7eUshYUt34dxGyiJ1rzGqneaheSKGK09y7?=
X-MS-Exchange-AntiSpam-MessageData-1: Yhinwq2ojiuQMw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b889574c-7a91-4cc1-8b09-08de9f6d88c5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 06:16:33.0755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfKxM5APqr6w0mjIMcq4L5cJaU6xOjs+7noOYuUbj7GsHNili1jtkU+U7X/QnG2po/ovgufzxEYmwLOj/avPhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8749

Currently, the GSP is left running after the driver is unbound. This is
not great for several reasons, notably that it can still access shared
memory areas that the kernel will now reclaim (especially problematic on
setups without an IOMMU).

Fix this by sending the `UNLOADING_GUEST_DRIVER` GSP command when
unbinding. This stops the GSP and lets us proceed with the rest of the
unbind sequence in the next patch.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs                      |  5 +++
 drivers/gpu/nova-core/gsp/boot.rs                 | 40 +++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/commands.rs             | 36 ++++++++++++++++++++
 drivers/gpu/nova-core/gsp/fw.rs                   |  4 +++
 drivers/gpu/nova-core/gsp/fw/commands.rs          | 23 +++++++++++++
 drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs |  8 +++++
 6 files changed, 116 insertions(+)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 1701c2600538..8f2ae9e8a519 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -277,12 +277,17 @@ pub(crate) fn new<'a>(
 
     /// Called when the corresponding [`Device`](device::Device) is unbound.
     ///
+    /// Prepares the GPU for unbinding by shutting down the GSP and unregistering the sysmem flush
+    /// memory page.
+    ///
     /// Note: This method must only be called from `Driver::unbind`.
     pub(crate) fn unbind(&self, dev: &device::Device<device::Core>) {
         let Ok(bar) = kernel::warn_on_err!(self.bar.access(dev)) else {
             return;
         };
 
+        let _ = kernel::warn_on_err!(self.gsp.unload(dev, bar, &self.gsp_falcon));
+
         self.sysmem_flush.unregister(bar);
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 18f356c9178e..3f4e99b2497b 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -33,6 +33,7 @@
     },
     gpu::Chipset,
     gsp::{
+        cmdq::Cmdq,
         commands,
         sequencer::{
             GspSequencer,
@@ -237,4 +238,43 @@ pub(crate) fn boot(
 
         Ok(())
     }
+
+    /// Shut down the GSP and wait until it is offline.
+    fn shutdown_gsp(
+        cmdq: &Cmdq,
+        bar: &Bar0,
+        gsp_falcon: &Falcon<Gsp>,
+        suspend: bool,
+    ) -> Result<()> {
+        // Send command to shutdown GSP and wait for response.
+        cmdq.send_command(bar, commands::UnloadingGuestDriver::new(suspend))?;
+
+        // Wait until GSP signals it is suspended.
+        const LIBOS_INTERRUPT_PROCESSOR_SUSPENDED: u32 = 0x8000_0000;
+        read_poll_timeout(
+            || Ok(gsp_falcon.read_mailbox0(bar)),
+            |&mb0| mb0 == LIBOS_INTERRUPT_PROCESSOR_SUSPENDED,
+            Delta::from_millis(10),
+            Delta::from_secs(5),
+        )
+        .map(|_| ())
+    }
+
+    /// Attempts to unload the GSP firmware.
+    ///
+    /// This stops all activity on the GSP.
+    pub(crate) fn unload(
+        &self,
+        dev: &device::Device<device::Bound>,
+        bar: &Bar0,
+        gsp_falcon: &Falcon<Gsp>,
+    ) -> Result {
+        // Shut down the GSP.
+
+        Self::shutdown_gsp(&self.cmdq, bar, gsp_falcon, false)
+            .inspect_err(|e| dev_err!(dev, "unload guest driver failed: {:?}", e))?;
+        dev_dbg!(dev, "GSP shut down\n");
+
+        Ok(())
+    }
 }
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index c80df421702c..fb94460c451e 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -237,3 +237,39 @@ pub(crate) fn gpu_name(&self) -> core::result::Result<&str, GpuNameError> {
 pub(crate) fn get_gsp_info(cmdq: &Cmdq, bar: &Bar0) -> Result<GetGspStaticInfoReply> {
     cmdq.send_command(bar, GetGspStaticInfo)
 }
+
+pub(crate) struct UnloadingGuestDriver {
+    suspend: bool,
+}
+
+impl UnloadingGuestDriver {
+    pub(crate) fn new(suspend: bool) -> Self {
+        Self { suspend }
+    }
+}
+
+impl CommandToGsp for UnloadingGuestDriver {
+    const FUNCTION: MsgFunction = MsgFunction::UnloadingGuestDriver;
+    type Command = fw::commands::UnloadingGuestDriver;
+    type Reply = UnloadingGuestDriverReply;
+    type InitError = Infallible;
+
+    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
+        fw::commands::UnloadingGuestDriver::new(self.suspend)
+    }
+}
+
+pub(crate) struct UnloadingGuestDriverReply;
+
+impl MessageFromGsp for UnloadingGuestDriverReply {
+    const FUNCTION: MsgFunction = MsgFunction::UnloadingGuestDriver;
+    type InitError = Infallible;
+    type Message = ();
+
+    fn read(
+        _msg: &Self::Message,
+        _sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
+    ) -> Result<Self, Self::InitError> {
+        Ok(UnloadingGuestDriverReply)
+    }
+}
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 0c8a74f0e8ac..59b4c4883185 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -278,6 +278,7 @@ pub(crate) enum MsgFunction {
     Nop = bindings::NV_VGPU_MSG_FUNCTION_NOP,
     SetGuestSystemInfo = bindings::NV_VGPU_MSG_FUNCTION_SET_GUEST_SYSTEM_INFO,
     SetRegistry = bindings::NV_VGPU_MSG_FUNCTION_SET_REGISTRY,
+    UnloadingGuestDriver = bindings::NV_VGPU_MSG_FUNCTION_UNLOADING_GUEST_DRIVER,
 
     // Event codes
     GspInitDone = bindings::NV_VGPU_MSG_EVENT_GSP_INIT_DONE,
@@ -322,6 +323,9 @@ fn try_from(value: u32) -> Result<MsgFunction> {
                 Ok(MsgFunction::SetGuestSystemInfo)
             }
             bindings::NV_VGPU_MSG_FUNCTION_SET_REGISTRY => Ok(MsgFunction::SetRegistry),
+            bindings::NV_VGPU_MSG_FUNCTION_UNLOADING_GUEST_DRIVER => {
+                Ok(MsgFunction::UnloadingGuestDriver)
+            }
 
             // Event codes
             bindings::NV_VGPU_MSG_EVENT_GSP_INIT_DONE => Ok(MsgFunction::GspInitDone),
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index db46276430be..71c8690c9322 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -129,3 +129,26 @@ unsafe impl AsBytes for GspStaticConfigInfo {}
 // SAFETY: This struct only contains integer types for which all bit patterns
 // are valid.
 unsafe impl FromBytes for GspStaticConfigInfo {}
+
+/// Payload of the `UnloadingGuestDriver` command and message.
+#[repr(transparent)]
+#[derive(Clone, Copy, Debug, Zeroable)]
+pub(crate) struct UnloadingGuestDriver(bindings::rpc_unloading_guest_driver_v1F_07);
+
+impl UnloadingGuestDriver {
+    pub(crate) fn new(suspend: bool) -> Self {
+        Self(bindings::rpc_unloading_guest_driver_v1F_07 {
+            bInPMTransition: u8::from(suspend),
+            bGc6Entering: 0,
+            newLevel: if suspend { 3 } else { 0 },
+            ..Zeroable::zeroed()
+        })
+    }
+}
+
+// SAFETY: Padding is explicit and will not contain uninitialized data.
+unsafe impl AsBytes for UnloadingGuestDriver {}
+
+// SAFETY: This struct only contains integer types for which all bit patterns
+// are valid.
+unsafe impl FromBytes for UnloadingGuestDriver {}
diff --git a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
index 334e8be5fde8..5d8e4c0ad904 100644
--- a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
+++ b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
@@ -880,6 +880,14 @@ fn default() -> Self {
     }
 }
 #[repr(C)]
+#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+pub struct rpc_unloading_guest_driver_v1F_07 {
+    pub bInPMTransition: u8_,
+    pub bGc6Entering: u8_,
+    pub __bindgen_padding_0: [u8; 2usize],
+    pub newLevel: u32_,
+}
+#[repr(C)]
 #[derive(Debug, Default, MaybeZeroable)]
 pub struct rpc_run_cpu_sequencer_v17_00 {
     pub bufferSizeDWord: u32_,

-- 
2.53.0

