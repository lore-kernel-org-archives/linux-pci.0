Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020086.outbound.protection.outlook.com [52.101.196.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6411539CCFB;
	Tue, 21 Jul 2026 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784652892; cv=fail; b=AXaYYexmwnp8FqaUifAemxWghw7goheO659mu6NQWGH4lQRj79wa8pmik3OKSq65oEy8VY+gh+lRriV7Np9Wp1UjVzRy82ZG2P2hsFw9VPYQF2RuLZsY6+g8MIxfvmSieq9C4IjoqBoa0gP2unMzTAw4pv5+MKHqA0Ngmd9vzyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784652892; c=relaxed/simple;
	bh=v1AhLEytp+ubGM9er1SfcTppOcOxQOUG4YK7S3jTrxY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PJ4km7gAEoapc3/DHSGOY7OPz7foX7Qshu3jpak6CdHOtc4aa4ubuye0B4BTmJHjUbnfKRlV78Z7heEFxr7us3sLy/XrZ9kOBl7qQzSIP4awv5BoAtFULwqTBxzJlsSmAANPWUcnyBio17GpFFcp/MWBMQm1xm5QrWDRHwdAe2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=QxPfcSmJ; arc=fail smtp.client-ip=52.101.196.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="QxPfcSmJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skukv3Djd6nNosB3bRXfr5V9G/J8+Ux6Mp0woeURF+GVTbZKtztMtlKC2nOrHmQ+gked6tetGuK8zqFU13cYv/Mf5gEQUMRLMpjZFZWt2iK3KwFjmewVbtbAvsszmj+MSn+4FA9dKFeVPLpVgG5Q4oBdriWpKGq4ME1bPXaaHAbxAwoR62g/0uATeW/NDZR4g+iXmb2a/zZq39mad1O+XuuWVNHEKDABlrBU7YfYZt+NeA89xIASMglGn2D6y8wxX7NkZ5q4nxtTK7Y4QTm82Qa5rDggT/aUKF4XOZd9cv1GM2y+8pXPny7vtGWbBiYnfNTd3pv4A5esXmA1qKO++w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9U1O/G0PdIjgKwC9lMycnNTEDGZPORy/i+sUq9XpXAQ=;
 b=IcmCihfnFs8rz9JwP4A32klatzKXwXWYJTN2F8Z7BIxvFpKZ8hDgtI16ZURFEAG/fmZNgU/2BLgx/v3OsD3k6V0P2BOr9JCBOgjUUvxYGA9wncbbTH8ID77oh85ehydWkiUjMZtFEPSpgKSHGoj4uZsy0G8MK6ijS7wj9/IZSL8MPuT3E2YzCALiANBf9xT6HPE2Xnia/Rf1poUKdBxMmNzZxJi9R8x5+Fp79sR/InDLR6NAAW6bgOr5jeEclenBEFvmPmQdBrh684PthxnvLZjyjQAmmQrs98ztR3lBTIaPODbS5/L/kCYYCrbT7US/ZXKkZF9jcQrc1LbPqauBtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9U1O/G0PdIjgKwC9lMycnNTEDGZPORy/i+sUq9XpXAQ=;
 b=QxPfcSmJrLzstNVJ29bGDNqIMvUJ1f38BEI6tIoixvYn2V+0qavAWNQSSdGt0CfiQl0RzKDMvgeoPP3PeoI/B470JDAmPI7vMIpYox0HLaNkPvAnhBB8TMGUL6wXed60J5n3scyiAMQDxbGlsaNmUMDqYVrX6FFIMayp19x1jQ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7878.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 16:54:38 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 16:54:37 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 21 Jul 2026 17:54:33 +0100
Subject: [PATCH 09/10] gpu: nova-core: convert hshub0 from relative
 register to projection
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-typed_register-v1-9-452d72b60262@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784652872; l=5363;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=v1AhLEytp+ubGM9er1SfcTppOcOxQOUG4YK7S3jTrxY=;
 b=ID3jt47eVs7jdqWoN2OOu+OOrmCzvsaCkStotLa64wc55VDv1532zGICa44Layqayp2pGYXWF
 bSgrc3qliorAdQmJy82eTujUJkIbevjC0ofyG5cpVMw+MmR9REOrblv
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
X-MS-Office365-Filtering-Correlation-Id: f141ebb4-b23a-49c0-67f3-08dee748c00a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|10070799003|1800799024|366016|56012099006|10067099003|6133799003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	+ZIPC95uqLTYltm/6l1eXLxyFH7kpGA53q6euFwuAsGWEt4DE9CbgCZoh3SfhHqjRNmLlWZLY9k/JBtpS/JEyFGh9pJiGKas4QY/5L51UdcS6kqW+abMbFXrh26za1NPqo1aP2Xnx3aILrkyhvZ2XVZybI4DotExcutWZjRe9B7ZJQNfUHAfyIuPH/NSphZ345zQ4Ge4WfowY+Pu5qSgmgmHB0Dwc5OOBfkjDi0jYRUCpXy/9jTK/hcxw79ePmSRnRXBKarQiulW+12ddWuqdAfd1KVL7ysRb5fj8YdXPl9Lu7cYYAqPve6VvuR/rH3D5O7VBBpJvO0/YRN9VQiaFpj1E9rb3AZEC8p6Uh3T0SdhxRMuL3Ed/Q87OZ59wKbUnjoFh1DJtBWlD4VH7HKa3sYq47AmAI9TWMe9pCT8wk2pVRzSePD0SYqv4UNWj9gXqSm5KNIJoDMtxkrNZLx2eneZCAyu93ukOsmbbiJnGLILc5lo2nTbg/8DVApN6KO7Z9UzXPsPPvaSKcj3/GbzCu6lptoy6NbDYQspr3J6BeI8q6L3gtfPAMn0cl4JxTcvLkVsoPhZ3HEU6bQFNUh46/rYtxEBzM5t6GwRBDHJ3Xlt3HThHWzBl8NkuDwJU2dsINi83LmdHosBaCgHtSm2GxHWjsDSPNTlaFA7eTt9dN/xJ8Ce5FCxZW0oQXcJjCW9RGZY6LcDzU4lkt3G/Fuuvg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(1800799024)(366016)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmNvVk9XU2l6ZktONVl3NW8yYmxLRDVIUGltaHdLcFMyZWtZdk91NlE0Wng0?=
 =?utf-8?B?NHZjOHFlZC9hZnIvd0Z4RmNyUE1vYjJRS2poVWdvaUQyOUw3R3BqejFvNG9x?=
 =?utf-8?B?c25ZZG5PWFVUWUltd0lMMHNvRlQ4Z29uVXlBK1g4WjdIR1dEVFlsV3VmQXkr?=
 =?utf-8?B?cU0xRWJNQ3BiS2NUWGg5ZVdSMnJEZHdMb3U2U1Q2NHA4ZjRVMDlXamtIZ0d5?=
 =?utf-8?B?eEoycVhsbWRKUnIrZ0owQUJsdlA1MlR2VkcwU21NSXN2T1ZtMnRaMXNYREhu?=
 =?utf-8?B?T212cWpuVlJ5TkU5cE1DRlNOSmNLSXF5U0kxU1lKelNPNGh5eUlVVDZsdmZ3?=
 =?utf-8?B?NE9LMHJuS2ZURlNDRmRDTDk0WGtLRGQ0VTI1RmF4bllyNVhEczBEb25QVVlP?=
 =?utf-8?B?TE5Vb1BJVkxSanRtMTRXQW1xMXhyNTdRejBWajlqTEpKbWUweGtLb2g3Q3kx?=
 =?utf-8?B?djAxZkFuR05BNGFiNkd6K0xpMzJNcmJ0YmpLMC9KcUx3dzloZHUwTi96Ty9x?=
 =?utf-8?B?UWFEUlJMcDhodDBYUWtJMXJtL05EYVhNRVNKZGdpWHZ3RG1lYlJoZDViamZx?=
 =?utf-8?B?aG4zemhzUnMyT0lDM0lDWVltdTlkVngyVWZkcnNkeFg4U0lZckxjQ2N6THVo?=
 =?utf-8?B?bmJyVkY2SHVGcE45MGd2dFo3Y3ZqSUJCN0JEVllXeWIydnE1Z2ljaUl0aUFC?=
 =?utf-8?B?R0NzQW1JcHU0em1QYUFtRDlUbnFleVViWi9RMjIrcGRPSWw2M0x6QnZsd1U1?=
 =?utf-8?B?WkRLcGp2RVlhaXcrTXlGTlh4d0RVZTBzQnBxWnExSW1oMDBqdEpOZlpUVW01?=
 =?utf-8?B?V09FL0VnblhzREZydHZYNE8vcEc5RHZ0cnFwZHVLVm5aOExWYkI5Q2puUXZ6?=
 =?utf-8?B?TXpLY0ZQRms5TTZrL05PdS9XM09MeU5jazVYRDJoc2VteEovczBFS3BSNWxk?=
 =?utf-8?B?d2RJWG43eXZ6ZGNidC9qR1pVbDJhRkZWbTBCWXJtRzUra1dpZkdHcE45dnFP?=
 =?utf-8?B?Um5EdHZtanhNUkxweVRXbVFiMHpKY3A2NjJDb1hnR21PenpMWnpiRmE5R1Ni?=
 =?utf-8?B?VVpDNXh1WU1xZC8zaHVhbHBFcEVsTWlvZFB2dWxHZE1YbXoyYjlGOC9nQ0FS?=
 =?utf-8?B?b2hWRUNzdHY2ZTlPeDdmbHdObk5RNit4elViUUQwOXN2QjlmcmpPeDFXeFhV?=
 =?utf-8?B?MXVPMkZkSUd2QVB1eDZlcU41ZlcxNGRMc3J6RHdHZmVobk84dGhhVTRvQ2Jr?=
 =?utf-8?B?dHhDQTFVbVljMEZ6TFN5R0tVejBGNEJvekpkM21NWmh2YmJ4RFRObFNBbEI3?=
 =?utf-8?B?em5Nd1c0azJXWkVZcmExWUFyYno1cSswOHB2eE9EdGlCS2Q5WHBLRmpyeVFn?=
 =?utf-8?B?dm8zUnZoWVhMSWFRNURraXBkU09wcEg1WS95eVlKZXJQd080M2JKTWVNSTMx?=
 =?utf-8?B?b2RjNEZpUE9kMUJjVER5cXlMK0hPN3VoS3NRVk85bGFhQlVDQXpTNmxqY2Rz?=
 =?utf-8?B?VjZ2WXdCZy9xRDFTWnRZODQ0TkdueGZGbW8xYm9TRTRjbWttYzQ3NjhybDZp?=
 =?utf-8?B?d2NFLzQrL1QvTElBWjVkRnNINThTOEVORmVFeTdnUkVOUVRpZEduQmRZQWdR?=
 =?utf-8?B?eFdGRWVQOVEzR3R6eFVsQnBmcjg5bFV6SmpZUzJIdE0xWkgwdE53ZnNXRnFX?=
 =?utf-8?B?eXh3SndDQ2IrRW5VSFpnR2wybFdicEtVWTJkaGlVdjhzY0ovT3AwSEVXcU9a?=
 =?utf-8?B?djdvRjJyZkZITDVxV1IycWo1MWs0OUYwQldFcmdMQ25UZWdnNzVYYnRsV1Y3?=
 =?utf-8?B?dXhBV2JkOE13NzA1bmNQTi9hZElLY0ZtRWpPRTg5cVVnclBJS1pYR1Q3Yjcv?=
 =?utf-8?B?QkZXd3VGMWUyS2ZIRUkzeXgyNUV5RVJQWWg5T1d1N3kzMHA2dDR1dXBiVDEx?=
 =?utf-8?B?VHFOdUNUeFhoUnZjMFMrUE9IM2ZUSkh5YlZaQzQ4QURURklaeDR5ZGhrQ0pl?=
 =?utf-8?B?MXA0QWk4cVVNaGhFbWFzZGRkdDNJTVY4dUJJRjBFQklhaWpvMEJ4MHY1R0tx?=
 =?utf-8?B?akhYZlRGR1JhMU8zWTZFZVVhZ3U0MDU5TVFERkdleFFqdzF5YmxGQmhvL1Er?=
 =?utf-8?B?U2ZyNDlNSzFoQjQyMitFSVNQN1JqNnVWdFNOeG96OTlweUt3V29iSWEvOEhn?=
 =?utf-8?B?VGh6Zlg1NWFJSzEzTU5qWjNyYlJCR21HRlZvdjRHTG5jOG5PR2pGUis0QXhi?=
 =?utf-8?B?Q0FPS2g4dnBlUGMxUkg5N21vZTRuOStCK3VyalJ1OWZlRi8vbk14ZXV5ckoz?=
 =?utf-8?B?MDJCSWVTMU5xTjRIbXRna2JDTEZsR0dtKzhwV2s0dlJkVVhUK3ZKZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f141ebb4-b23a-49c0-67f3-08dee748c00a
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 16:54:37.9343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1+PqdJf/cGddBCZqJTifG1WgMtS6qbA4v8Ho1NfU/UFDLqBjx644BgleN0ghmTLKQlD9FomVFgYgZB3/zqnig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7878

Similar to the PFALCON and PFALCON2 conversion, the hshub0 relative access
can also be achieved cleanly with projection and a new base.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/nova-core/fb/hal/gb100.rs | 51 ++++++++++++++++++-----------------
 drivers/gpu/nova-core/regs.rs         | 19 ++++++++-----
 2 files changed, 38 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/nova-core/fb/hal/gb100.rs b/drivers/gpu/nova-core/fb/hal/gb100.rs
index 6e0eba101ca1..ec910e0a044b 100644
--- a/drivers/gpu/nova-core/fb/hal/gb100.rs
+++ b/drivers/gpu/nova-core/fb/hal/gb100.rs
@@ -5,11 +5,9 @@
 
 use kernel::{
     io::{
-        register::{
-            RegisterBase,
-            WithBase, //
-        },
-        Io, //
+        Io,
+        Mmio,
+        Region, //
     },
     num::Bounded,
     prelude::*,
@@ -29,17 +27,24 @@
 
 struct Gb100;
 
-impl RegisterBase<regs::Hshub0Base> for Gb100 {
-    const BASE: usize = 0x0087_0000;
+impl Gb100 {
+    #[inline]
+    fn hshub0(self, bar: Bar0<'_>) -> Mmio<'_, regs::Hshub0Registers> {
+        Region::subregion::<0x0087_0000, SZ_4K, _>(bar).cast()
+    }
 }
 
 fn read_sysmem_flush_page_gb100(bar: Bar0<'_>) -> u64 {
     let lo = u64::from(
-        bar.read(regs::NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_LO::of::<Gb100>())
+        Gb100
+            .hshub0(bar)
+            .read(regs::NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_LO)
             .adr(),
     );
     let hi = u64::from(
-        bar.read(regs::NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_HI::of::<Gb100>())
+        Gb100
+            .hshub0(bar)
+            .read(regs::NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_HI)
             .adr(),
     );
 
@@ -58,24 +63,20 @@ fn write_sysmem_flush_page_gb100(bar: Bar0<'_>, addr: Bounded<u64, 52>) {
     // Write HI first. The hardware will trigger the flush on the LO write.
 
     // Primary HSHUB pair.
-    bar.write(
-        regs::NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_HI::of::<Gb100>(),
-        regs::NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_HI::zeroed().with_adr(addr_hi),
-    );
-    bar.write(
-        regs::NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_LO::of::<Gb100>(),
-        regs::NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_LO::zeroed().with_adr(addr_lo),
-    );
+    Gb100
+        .hshub0(bar)
+        .write_reg(regs::NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_HI::zeroed().with_adr(addr_hi));
+    Gb100
+        .hshub0(bar)
+        .write_reg(regs::NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_LO::zeroed().with_adr(addr_lo));
 
     // EG (egress) pair -- must match the primary pair.
-    bar.write(
-        regs::NV_PFB_HSHUB_EG_PCIE_FLUSH_SYSMEM_ADDR_HI::of::<Gb100>(),
-        regs::NV_PFB_HSHUB_EG_PCIE_FLUSH_SYSMEM_ADDR_HI::zeroed().with_adr(addr_hi),
-    );
-    bar.write(
-        regs::NV_PFB_HSHUB_EG_PCIE_FLUSH_SYSMEM_ADDR_LO::of::<Gb100>(),
-        regs::NV_PFB_HSHUB_EG_PCIE_FLUSH_SYSMEM_ADDR_LO::zeroed().with_adr(addr_lo),
-    );
+    Gb100
+        .hshub0(bar)
+        .write_reg(regs::NV_PFB_HSHUB_EG_PCIE_FLUSH_SYSMEM_ADDR_HI::zeroed().with_adr(addr_hi));
+    Gb100
+        .hshub0(bar)
+        .write_reg(regs::NV_PFB_HSHUB_EG_PCIE_FLUSH_SYSMEM_ADDR_LO::zeroed().with_adr(addr_lo));
 }
 
 pub(super) const fn pmu_reserved_size_gb100() -> u32 {
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 7f7cb84b21e8..6bc8601f2176 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -7,7 +7,10 @@
         Io, //
     },
     prelude::*,
-    sizes::SizeConstants,
+    sizes::{
+        SizeConstants,
+        SZ_4K, //
+    },
     time, //
 };
 
@@ -156,28 +159,30 @@ fn fmt(&self, f: &mut kernel::fmt::Formatter<'_>) -> kernel::fmt::Result {
 /// Base of the GB10x HSHUB0 register window (`NV_HSHUB0_PRIV_BASE` in Open RM).
 ///
 /// The base is provided by the GB10x framebuffer HAL.
-pub(crate) struct Hshub0Base(());
+#[repr(align(4))]
+#[derive(FromBytes, IntoBytes)]
+pub(crate) struct Hshub0Registers([u8; SZ_4K]);
 
 register! {
-    base: NovaRegisters;
+    base: Hshub0Registers;
 
     // GB10x sysmem flush registers, relative to the HSHUB0 base. GB10x routes sysmembar
     // through a primary and an EG (egress) pair that must both be programmed to the same
     // address. Hardware ignores bits 7:0 of each LO register. The boot path uses a fixed
     // HSHUB0 base, so the multiple runtime-discovered HSHUB bases are not needed here.
-    pub(crate) NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_LO(u32) @ Hshub0Base + 0x00000e50 {
+    pub(crate) NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_LO(u32) @ 0x00000e50 {
         31:0    adr => u32;
     }
 
-    pub(crate) NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_HI(u32) @ Hshub0Base + 0x00000e54 {
+    pub(crate) NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_HI(u32) @ 0x00000e54 {
         19:0    adr;
     }
 
-    pub(crate) NV_PFB_HSHUB_EG_PCIE_FLUSH_SYSMEM_ADDR_LO(u32) @ Hshub0Base + 0x000006c0 {
+    pub(crate) NV_PFB_HSHUB_EG_PCIE_FLUSH_SYSMEM_ADDR_LO(u32) @ 0x000006c0 {
         31:0    adr => u32;
     }
 
-    pub(crate) NV_PFB_HSHUB_EG_PCIE_FLUSH_SYSMEM_ADDR_HI(u32) @ Hshub0Base + 0x000006c4 {
+    pub(crate) NV_PFB_HSHUB_EG_PCIE_FLUSH_SYSMEM_ADDR_HI(u32) @ 0x000006c4 {
         19:0    adr;
     }
 }

-- 
2.54.0

