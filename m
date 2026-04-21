Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011062.outbound.protection.outlook.com [40.93.194.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6F3369236;
	Tue, 21 Apr 2026 06:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776752207; cv=fail; b=ttRmDLpLQMOlotPSEbmvH1S92PV3d52uN+urhDNlQdHtcI12iAcsiMKknGzUU52a/mCdKoNxe+cEH+cJ+TLJzMXOqAQqo2Yy5NUXiUw3ELJ/j5v0vmlbTk5YXgQ6DDjSoV8snznCWRucsDF11WTok3XwLTRwC/9uSVDP+9UffLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776752207; c=relaxed/simple;
	bh=xjQW6zbG81wJLIjPC/UyEsqVGkpk/K4kHBNs4grfZwU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oaYyJlmnvNpxFMvFD5m2VkOo8WRHZnZ/o0HjP0RQO5LHqNDkOdKE8RYYkNMBVT5CE3vqVT2iiK5YnSbFxb6X5zFAthtB10R6OBYtyCR+eJZj5UBNCE6DYSSm9+/TKrD17SKSfvTOyjGdn/aBbDCFaqXRr3dY6r5742rhpgYdGS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=umGMcs8J; arc=fail smtp.client-ip=40.93.194.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="umGMcs8J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZoPPiuV/yQWJJ3Md+Go5uHaVO6i80mFCfVAOwnmcQXpMncx79aD+czVLl0MKoKaUYVrpXeiVNkKSjoZhEFGLUmoxoHXZ3mzbNa22ufnvMyCLSiYmmrBISGUQTB4pHr3hBDQ7G4dT3Y56wayOV5YxPsPTCcns4nLO/ycdS78gTKzvOEkSJbvmqeC109uhAQekPiX9bR36zkuaPFBnl8kI//4j9fi2Mle76o/zgqXsdEqBJbrSbSDRfAQbqEixG4I3sZpWQ4C+7FfQbKJcYqrqOnxDNj9kPNyJ1GQpT1otFzCohCusNGikQJl39ibOU8MqMVNWh3rkgIQ/VZNf2D7Maw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmfhwgQCCTErv+j2CvALJmbXp9bRliRBt6dRbZo8INU=;
 b=jKRPTXJ3X02IKMJ7okAVcUQNRkcAklL69U/9visq45vU8wWXPPoGkrFTcwwauRAENw7cOzLLUT6/Hr27ae8U7eVvZBFhf19fQGAsDx+l6ik+ae/dhRHPdzFZVs4cuEl6xaZ5QxqJcLlxuY5xuJrdQpCkIemWgph7X+0CPkPRz1cL/K/7ZPE0YHBl0w7opSy3ntOKSrK9dRBNUMnmE49Ll9kyGTfKDsxLWDooqPSnGN/SEsnU9gHRrK5v663/df/hkBJBH0vzxyhwrRQteGbh8LH/ozw26svpyzbORO3DRFft228cZhwUx6Nfve+U2d71jaNzTY8TM+Z5uYKD6LOyfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmfhwgQCCTErv+j2CvALJmbXp9bRliRBt6dRbZo8INU=;
 b=umGMcs8JUXWQlXE2fxYTHWzwpXDeGIIYc7iYHvkXK3vatIe+vN4gpPU1pxT+hNcX5rDRaF8nG7iiSeiqY/ho1TW9cNlyN3xtYdgfeZJTMXXNt6r0XnMG1xFf+y4IVn8V4pMI1Tikun4wTlfXgtZnMtBKoUspmpKVioJrcMSJnpAy4y01a4xvnRzQOfhIiiOrsgCriMZ4hnqPbznobdFR2aPruu6vNT/qG65c6FbsGmOBMydWLznAV/3mmWuVHjw+Vds4umlhWySExIBRQxvSuAgQC1b5gOVDsqxVrvTs5xnvsLBzviGg9Ojrjo0asb/azTNi78xBUmAEYWOPsqOtlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CYYPR12MB8749.namprd12.prod.outlook.com (2603:10b6:930:c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Tue, 21 Apr
 2026 06:16:40 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 06:16:37 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 21 Apr 2026 15:16:15 +0900
Subject: [PATCH v2 5/5] gpu: nova-core: run Booter Unloader and FWSEC-SB
 upon unbinding
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-nova-unload-v2-5-2fe54963af8b@nvidia.com>
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
X-ClientProxiedBy: OS7PR01CA0249.jpnprd01.prod.outlook.com
 (2603:1096:604:24b::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CYYPR12MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c1417f-98f5-4dd0-ee2c-08de9f6d8b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	v2fKXLpXjGrDM+ooJ1Bg6cWGurVqMjPXXOVwCD15s72Vts6dsBvt6yKynrHh4X4oph1/3EXUUYEmJQ4zjEVrl0sIFLChWajXKz8AVMutN91e4jlez0MOjXKJt1XYSsJmeI9O6MCdoHICLj8F4xb8uDnoSfVJtrmV2GO//qKFIZoMvsQO8f/GJJ7BxIdHyCp57BR7VJHP+5uFLSlO7UGMoAsScog+ODTzx7i6YAsjNJOtafCIWAhthElLvXS1ZqFe0C945Zfp5ZH1/3KAmyuu3/zEI75qON6hCD5KnbWeuiwo/eOzmczwzSLyDGD+1hPxhY4BW+Xh3CHwrpj6vZYqWC0LDRie6JwQWPg6ETyA2EubXVMU3FkUtHPWSwB8ZknrocmuitsWZR8sqbFR7jkyi7AHqSpjD3o2mONdCXxrjtiRWvndAOxUoCtrUZUA2g8VTd3QzpwN4tHtEIWcS1F0InGLlpBhLXUFiWoEKbZ3ZRIlYJGRgUpnnm09kqVhCL8HWcKHXKhjM2QtiIbBJnoiwQqKf2vVK6IPsiXuNCIO/x56qabUSyHmuv+707zeEs62KYNeaIXjjN96stH9LlXZTD1FBe+6DEKS2qdYmF2KYUNc5DIn7Jcq0Wzx5XKWR+QLutONu5htuLmRX5+HUsE2lnN2M8JLEy3fpmOlH+wh0KkThu0Bai/H1Ozrd3nEw0IwVSDmTMpeTnIfEUJdNjOGo0fiaOehrYURZFVvEygLKtZ4gEyeqSPbLQ79e/GatI16lp2pX5dsk61U3DvVaMYbwQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXIxRXZuMUlYMEpWcGVwR2IxeUpvSkl5WUxHTWM5LzIyWnQ5UEJudmY4cEFv?=
 =?utf-8?B?RVBMWEYzRGw1emo4R3ZNNzZZdVp0RExoNkpBNmNWYmZaWTJycmNqL0JHUFlT?=
 =?utf-8?B?b1hRNlFDTDFWdW5FNzlySFBBZmxKNC9ES2ZBR2lVelJaeHVmaGU0eDIvcjNS?=
 =?utf-8?B?QWdpWkZpVFhISHN1dmlpYkg0YncrQU56dGRyMUFJbzhoSksvbEdiM25qSzVs?=
 =?utf-8?B?R3VSOWtwZUo4WEdDV2wvZFhMVFRmaC9Ka2hmczJzUG5tQ2VNSDhqcDA5c0Mv?=
 =?utf-8?B?QUg3UGhQZ1FRSTNMZFVrM2M5bkVZaDVFNmt3MlFmMVZOT2RpVmNORHVrc0Ex?=
 =?utf-8?B?NjluSks3a3hod2JVRG5ieU9XenZPVGhKbTgxSCt0WEV1Mm5hRlJ6bTJYSHVD?=
 =?utf-8?B?VDdHRjkvV20zZTBBUVJ3SzFqbW1aTDBlUmFMK1V6b3BwWlNqRWxhZ0MwWDFy?=
 =?utf-8?B?NkM3NThDL215Y0E2K0ZwR2Z1ZUlRNlJiaVNJWVQ2NElSbzhzRC9VMWVobEtJ?=
 =?utf-8?B?UnJHVmVTVjRxc051WHNyOUdkelZuMFVKRHg3TDJ4U3Y2WXVmUkJrOG14VEdi?=
 =?utf-8?B?Z1B5QVdDZEppdWpTS2xWQTJXL0g3bHU3QitDTXU5ZmZocHRkcDhuVjhTT0lx?=
 =?utf-8?B?S3picmdzbVNTUHNxaVRIZTQ5WE44bUdqKzF4V3I5b00zaXJCQjh5MWhDQ2Jo?=
 =?utf-8?B?WjZJaEdYeWRlYkJUSERreGdCMVlLb3k1WlJsYk1FNEZLckwxRnF2QVZYeWZ3?=
 =?utf-8?B?ZVQ0d0p5TStEZ1NGMHU0eFVkZVZQVVQ4d21tcWlxMXZMdU9RMTF0Ly9rcE1t?=
 =?utf-8?B?RXE3d3ZpSjA0RWc3QnlwODBkbkZtLytBMW5aWGpEd056NDVzT2dBcW5lblNn?=
 =?utf-8?B?UjZBNXBsVFJFc1BIVkQycE9UTk9PRTQ1UkVnUGF5aTlxQW9Od3pXY0Y4UHR3?=
 =?utf-8?B?Y2JlWkhrbEFrVXByNEUvN1RvUVoweGpFb3lvSlFYRFhobnVTeGdDLzFJVnEw?=
 =?utf-8?B?Uk9xVEhZT1NwYXB6djlOWk16WFZPN2dkSkVDT0hDQzE0R2E3Z0RFbmh3SEZy?=
 =?utf-8?B?Z1hoZ2hhZXBjcGM0VHJ4UHVsMFR2cXREZVR2YThlWjc3c01jTVJaZDJsLzAx?=
 =?utf-8?B?OHY0VVFPaVJPM3YrcmRHL3pLU0EzTXE5d2o3QURIQVV3S3A2ckJVZzQ5NzFT?=
 =?utf-8?B?UmJ0OHJWWlZDMS9iTVlHUzV5NTVVcklSS1pwNVBxaTZkS3g1ZlNrblRyZENp?=
 =?utf-8?B?clk3WWZDdDNiVnpmN3JKd3JFOXN5MmduL2k5c0VPZ3p5TnN2d0hPaXBFUU1v?=
 =?utf-8?B?MFlPeFJXS0lZMFN0cDdTQWdBTzhmNWk5QmhrV0FET2x6dmhISzJHazJRVzBN?=
 =?utf-8?B?WmoraU9veUFYd21DazdzVWp5RnVkME4wT3ZHbklZTURRbUp6UHNYVGZsMEpW?=
 =?utf-8?B?NEFiNlYvYk01YXIwcHR5TVF4OEp6Y0ZSSVhxTUxTVnQxYVU1QUZYTWp6dFNx?=
 =?utf-8?B?eTRjc1haMEZkeHJ1RVZXdnJ6Q09kTklENGRsRklFcmxoVEFqUnltQWU5elY0?=
 =?utf-8?B?d1JwV0JONU50eGZNRXNrVUdDbk12WXEvbjlGN2xRczZtQVhOTVRVQ2RQTkt3?=
 =?utf-8?B?dVpMUFZnM05UWUpBY0hnVnJIWlB6MWlaVGRCRFRQWGJmSzZNZEZxMjU4TEcv?=
 =?utf-8?B?clFrcW5zbUxoT2dRTHRFS2t0cDRXTzlXeDB1WnlvQ1VPcVJZTVdQa0diUTN2?=
 =?utf-8?B?a3pQbDJhTGMzcTBrZUdyQzRkY05OZ0ZGRlJtRk5EYkN4OWVvZVNKTnRTV2lR?=
 =?utf-8?B?OGhjeUlzU3QxeFdQL05mZjY3TGJXVTN1MStzSnNEYkN0Z1B0ZnhVS1B1SkhK?=
 =?utf-8?B?M1NGNmtXZW5RcUFGVkpOWHdXUVE1NTVGOFZuTUYzSjNsMWRJWTJybnhhdG9Z?=
 =?utf-8?B?eXp0NTM5djF6NGlUT1VTVWxkQTZVK2VNdW1lZXkrZ3FoVlJ1VExFYjJ0eTA4?=
 =?utf-8?B?cmdLZkY0VEtsUEt5VmZxaThXRzNVbE9LVzhvSDZmd25lRGQ4NWdheVhLWDQ0?=
 =?utf-8?B?VjBGY0RXSG92cDR2akJoaEMxUjBzL3FXYXpxZWZZeG5MQ0hpWGNEbUlHSkVM?=
 =?utf-8?B?MDM1WnpTOUhKR3N4bXZBK2FLS0dGamdjMVlzSXpaNTVSRnJ2cWt5ZXNlK2li?=
 =?utf-8?B?QmhWVHZ2dDVaSnFiYnphRk5lYTA4TEIrSDNLMWxvbkNQL1dpWVZrbUxyeVBr?=
 =?utf-8?B?bi9uQWN6bkRCSmhpYWNTWWNHYjZjQ2gwa21VSUpGM1lCc3dHQWFqTUJ4UStl?=
 =?utf-8?B?T3pFaGM3NTl5QWhXSFJTTjZTbXBnNHk1QnRJbzB2cVNoSDcxVVFFRGdKZEpt?=
 =?utf-8?Q?pfZEqCMdpyfKWJLj8aNU8/uTbQYKKI7GgkKZzu4pVGQTM?=
X-MS-Exchange-AntiSpam-MessageData-1: zjJ+XaYao6TlzQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c1417f-98f5-4dd0-ee2c-08de9f6d8b49
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 06:16:37.2052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0orbsCHImjx2Pd6Up1o578FvjNTIV0ZWEhAh8AivbnsLUT8rJ10jW5UF6oFGZ8BTZB/iSYBZodMrRvzxS55GMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8749

When probing the driver, the FWSEC-FRTS firmware creates a WPR2 secure
memory region to store the GSP firmware, and the Booter Loader loads and
starts that firmware into the GSP, making it run in RISC-V mode.

These operations need to be reverted upon unloading, particularly the
WPR2 secure region creation, as its presence prevents the driver from
subsequently probing.

Thus, load and run the Booter Unloader and FWSEC-SB firmwares at unbind
time to put the GPU into a state where it can be probed again.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/firmware/booter.rs |  1 -
 drivers/gpu/nova-core/firmware/fwsec.rs  |  1 -
 drivers/gpu/nova-core/gpu.rs             |  8 +++++-
 drivers/gpu/nova-core/gsp/boot.rs        | 43 ++++++++++++++++++++++++++++++++
 drivers/gpu/nova-core/regs.rs            |  5 ++++
 5 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova-core/firmware/booter.rs
index de2a4536b532..771b018ba580 100644
--- a/drivers/gpu/nova-core/firmware/booter.rs
+++ b/drivers/gpu/nova-core/firmware/booter.rs
@@ -280,7 +280,6 @@ fn new_booter(data: &[u8]) -> Result<Self> {
 #[derive(Copy, Clone, Debug, PartialEq)]
 pub(crate) enum BooterKind {
     Loader,
-    #[expect(unused)]
     Unloader,
 }
 
diff --git a/drivers/gpu/nova-core/firmware/fwsec.rs b/drivers/gpu/nova-core/firmware/fwsec.rs
index 8810cb49db67..4108f28cd338 100644
--- a/drivers/gpu/nova-core/firmware/fwsec.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec.rs
@@ -144,7 +144,6 @@ pub(crate) enum FwsecCommand {
     /// image into it.
     Frts { frts_addr: u64, frts_size: u64 },
     /// Asks [`FwsecFirmware`] to load pre-OS apps on the PMU.
-    #[expect(dead_code)]
     Sb,
 }
 
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 8f2ae9e8a519..37d0e4587ed3 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -286,7 +286,13 @@ pub(crate) fn unbind(&self, dev: &device::Device<device::Core>) {
             return;
         };
 
-        let _ = kernel::warn_on_err!(self.gsp.unload(dev, bar, &self.gsp_falcon));
+        let _ = kernel::warn_on_err!(self.gsp.unload(
+            dev,
+            bar,
+            self.spec.chipset,
+            &self.gsp_falcon,
+            &self.sec2_falcon,
+        ));
 
         self.sysmem_flush.unregister(bar);
     }
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 3f4e99b2497b..e00cfebe5d11 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -267,7 +267,9 @@ pub(crate) fn unload(
         &self,
         dev: &device::Device<device::Bound>,
         bar: &Bar0,
+        chipset: Chipset,
         gsp_falcon: &Falcon<Gsp>,
+        sec2_falcon: &Falcon<Sec2>,
     ) -> Result {
         // Shut down the GSP.
 
@@ -275,6 +277,47 @@ pub(crate) fn unload(
             .inspect_err(|e| dev_err!(dev, "unload guest driver failed: {:?}", e))?;
         dev_dbg!(dev, "GSP shut down\n");
 
+        // Run FWSEC-SB to reset the GSP falcon to its pre-libos state.
+
+        let bios = Vbios::new(dev, bar)?;
+        let fwsec_sb = FwsecFirmware::new(dev, gsp_falcon, bar, &bios, FwsecCommand::Sb)?;
+
+        if chipset.needs_fwsec_bootloader() {
+            let fwsec_sb_bl = FwsecFirmwareWithBl::new(fwsec_sb, dev, chipset)?;
+            // Load and run the bootloader, which will load FWSEC-SB and run it.
+            fwsec_sb_bl.run(dev, gsp_falcon, bar)?;
+        } else {
+            // Load and run FWSEC-SB directly.
+            fwsec_sb.run(dev, gsp_falcon, bar)?;
+        }
+        dev_dbg!(dev, "FWSEC SB completed\n");
+
+        // Remove WPR2 region if set.
+
+        let wpr2_hi = bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI);
+        if wpr2_hi.is_wpr2_set() {
+            let booter_unloader = BooterFirmware::new(
+                dev,
+                BooterKind::Unloader,
+                chipset,
+                FIRMWARE_VERSION,
+                sec2_falcon,
+                bar,
+            )?;
+
+            sec2_falcon.reset(bar)?;
+            sec2_falcon.load(dev, bar, &booter_unloader)?;
+            let _ = sec2_falcon.boot(bar, Some(0xff), Some(0xff))?;
+
+            let wpr2_hi = bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI);
+            if wpr2_hi.is_wpr2_set() {
+                dev_err!(dev, "WPR2 region still set after Booter Unloader ran\n");
+                return Err(EBUSY);
+            }
+        }
+
+        dev_info!(dev, "successfully unloaded\n");
+
         Ok(())
     }
 }
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 2f171a4ff9ba..21ff5d15f648 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -176,6 +176,11 @@ impl NV_PFB_PRI_MMU_WPR2_ADDR_HI {
     pub(crate) fn higher_bound(self) -> u64 {
         u64::from(self.hi_val()) << 12
     }
+
+    /// Returns whether the WPR2 region is currently set.
+    pub(crate) fn is_wpr2_set(self) -> bool {
+        self.hi_val() != 0
+    }
 }
 
 // PGSP

-- 
2.53.0

