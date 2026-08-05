Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021105.outbound.protection.outlook.com [52.101.95.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D00488DA9;
	Wed,  5 Aug 2026 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947843; cv=fail; b=m26we13ematad5o4iRmmMASlWumjMQ1A2vKF0aLpuDvRVqQQkBEMQOnL72nM+Pwv5UjMPM2dFUX0eHd5BU92W/YgP5zhjmT1d83LtAKr5cLMoQoOTaeBowR1TKJmTbb2IP3vMFLqyT2TpTUC+PuT47kWCYA7ni3CFaAmr3N/GTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947843; c=relaxed/simple;
	bh=mv3/sV5/3SVN383DdQp42etg9sPrNM13SS1QFVQvyEg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nnsH52CcYthD+DbyKKIVe2wmFR1dmpYklbri0lrnC+PD4PElmgThI0r9KXf3lEnYbYK20CT9yXYB+3SfMVke4oftmvDFz1Gqn880a828+lKJ3Nx9WXfswvDSGu1i9PkkLDKzwsGm/GiH1Q90PefkDpfZCNbPkM4wjmfDy6OFmKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=IuOyVS+a; arc=fail smtp.client-ip=52.101.95.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="IuOyVS+a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7xCs2a7WKcn1lhZrCYUCLhVmKYtuacDqFa9PmWQu4EV58tZibN/kfv68fdiBfoCV4VI2/DOngT/HDXnThTviKz8zoy5F8pJOfjDeSSARL+nGf5DLp6Sr9KXSpTiK9DEf00d2qU8W/VnCuc6myK4Fm2r2uNSF/Z7SlEbLEAIHmb6y+l9S/v+TR0LmzVFwx5hTU+EU4aZVdLpQfFywIEb1WPItEIsC4gpUUtANvtBXPD2Gvg+0Sv5aZ2g/pZyAQ4xnvfYuuZVj0NKdmSNZlCc6R7/n2ri0u8utNtp09TUM/ZwHeAy392mnNla8et9rDw0qWel/iL6VPPazlhoCivPUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0Gb3VD/MXDl9xV8m/t5L6cOG17hk/zKGM1ulBtV3Rk=;
 b=XhImwpio7HAHEOJheCC4jE2M+0dzxPHo2kWuRxowKZg2hABl2t66fJS9Jl2z9zCM4Gwq6rrE06rnCEmpyLpWvkbh8wyrXJiDGgpNLmt+TR9p9oVJ3jJCtbTo60fSoeHLY6C8aD6SBcWhydKSRcq3ZsJ4y0OB6AkpxJwyeJepQvgv7lZvWNHuxo/N84qNaUoi3FxoOtLLFvtdlvS+b00hXMSOdywNzAZ4pR47caFCcbWxIQdawlelFsMVI6pCC1xYFOcRpRXuBuUVNegUe3NckOU9nqy8WDcZI2UibQyNzTIuNJOqBiidpOlde7XzdVPhkKclvN8Ire7wZQg0wG6NqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0Gb3VD/MXDl9xV8m/t5L6cOG17hk/zKGM1ulBtV3Rk=;
 b=IuOyVS+a2TEv8htFRqVhimh9Tdlv5CyhzTgsSx8eryXzjX8pkHYk/5wQVOk+BkSufKgSam9xAX3kJCZUlRW7boFCPOegdbQ0vOjOAy+bAkFBsYZLJYvf4Lo6N8IV/oj8sny233ri9yHobJlxRVj1hfKQMD4q4+yybrufUM9PiB0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by LO2P265MB5822.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:26c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 16:37:05 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 16:37:05 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 05 Aug 2026 17:35:51 +0100
Subject: [PATCH v2 08/16] drm/tyr: specify base type for registers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-typed_register-v2-8-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
In-Reply-To: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785947818; l=6459;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=mv3/sV5/3SVN383DdQp42etg9sPrNM13SS1QFVQvyEg=;
 b=U7GSEt07zAVbHdlqUYaMPys3WGaU9/7WO5AalGCictiUsg2ydgBhU9KVol28Xg0XRrf/dn9PQ
 KiTS3s5CgXJBfT6zApiyX8zCCnXRGymWEDyKYxIWvCv7iU/giiQ34XN
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0608.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::8) To LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4b4::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOZP265MB8551:EE_|LO2P265MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: 48802ec9-0ecf-435d-a52e-08def30fc8af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|1800799024|376014|23010399003|366016|6133799003|3023799007|22082099003|18002099003|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	THkJVPHqwDsN5Y6FvzKyOHMHte7y8JCO9bmUbW49J67lh/dSpcYpoyIthTKFNYeLGs35lgUZx5TaxCr58uNMa9/sPPPO0zSzL/ygjhLhiufpcQ1HqaPGs0uy2eVaYrAFUYSB75yHIsBevZEi/psHo2ILHkIrbmcJerZJQKMnSYm8wxBY2UXqcR2Gj2fJeGnE14yTEVC/2y7zqvdJgyYVJTqN6PC4sOinQho4Y4m/AbVLt/sTDdnuoALhm5oZifS8Zy02HZ6YIic39gYupAteS2b7fB4djVZzoYsOPS8z0AVITWXcR0wlMbNPk/HiTLEDiY0WgVjHmkHmqPP/3qJoIwwUkLP7k+9zzEX7EQotMQkWmH20JmXg9u1vkqNtvyXkIw6ZLBdxtcIsjWTSCkgnEq26fLZZsZSeoNg2T0RImGpOS8Vpm0wbLY3eagSpiqmKIl2ME7n0+f8yEiCo/zT+SoiKQLwyvsRGKVo6FsACTf/Y1dVJ2l+pYTYn53chpb9vFn2+6IqjHWESUrKcVIMt5JskKd+aD9/o4ZKr+rFENR8Cc9kLhtpFzuIpzgMST1hCTsuNI1kHn2qr0vP+PJY8X8ILxBYU9Tgu4crGcVuYAIqNNIFTvJp3QaVCoKKheiAxsgIuEA5VhaU51biXVJWjDXcKwxZFg/M6767D6VEH8pJO7v3/qtVlm59u5KPPCRBJG6OqFN5X3m8xwc76LUVKcw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(1800799024)(376014)(23010399003)(366016)(6133799003)(3023799007)(22082099003)(18002099003)(56012099006)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mi9kLzcxa1pWTzRiKzNmMktTTld5QnZpUXlKY1V5aDBWaFJORC8wd0xFNDVh?=
 =?utf-8?B?YUNJOG1kSVpESWF1V1JXNU1VNmttcVpPK0VKTlVvUUFmN25nWU9TSUkyWGFq?=
 =?utf-8?B?YkJsOXJXR0dGMlh1QmdWVzViSW44dDRvOURPYS9TakpSSlNaK3l6eDdUSGY4?=
 =?utf-8?B?SFc0N0IwRlVkdE5jcDlZdHNvRE16S2pUZkFGeVdSc0dSS1h2WGREZHBPKy9v?=
 =?utf-8?B?MWJkeUEwR2RWdFM5WFBXUVZMMjB3NTZldkVKSFFuVVBhdGlUWVV0eW1RLy9k?=
 =?utf-8?B?RXJTVk1sZ20vcDFkNXl3TkVuY2taenJlME5scUoxSCtUc3UySHZSUU81V1ps?=
 =?utf-8?B?NzNubExvSVVMN3JSLzVxemdzV0d1b1ZEcnhMOER4NG4wSjNzd0lZVkE5cEtD?=
 =?utf-8?B?SFFpOHYyUGQ3TzlFQ0t1NlppWkNBb2NkUy9qM3UrTmxFcXFuZ01wejVGZDZT?=
 =?utf-8?B?dWZpL1lLakQycGsvcXVOTS8xTjkzc25jRzRlZ3lEQkNPOWM3QVVNT1hRaWND?=
 =?utf-8?B?Ykp5MHNabXZzTm5BR1R4UVhabVRjRnhzZFZ0aUpCQzFFOEZWRmxiQ1dQVWtX?=
 =?utf-8?B?b1E0R1FtQWRwUlJ2a3p6RUtmbWpMUUxIUHF2SklDODFvUTBGVFhvcVd2VTRj?=
 =?utf-8?B?a1hucWJyN0NvUERmWjZNRmhYVUFNWHEwRmdPQVZHN0VXOWcvNU5QbEVtaHF3?=
 =?utf-8?B?RHA1ZGhrdTNmcEV4UGlrTVpORVVSaStNSEtSVGhkb1RhaXdlWUxJMSthN1pY?=
 =?utf-8?B?YWRMM2JIdHV4RTV3S2RqN3ArLzNRcFFrSUtWdTJYNTlFbERlYjF0WlBzdys2?=
 =?utf-8?B?TE44MVNaanpuZmNSYzBReXg3VmgwUklqZEc1Zmw3NlpGa0VNOTRWQzNheU5H?=
 =?utf-8?B?QnlUWEZyYzdYcE5tODRHanJBRGV0YlJIZHNNTnY5b3JLZ0I3bzREZVUydlox?=
 =?utf-8?B?RUlxMGl1WnhoTndYanlPaHZMWDhtcW5IdmpCcnI4Y29GOHl3UDhDNkhrK0hJ?=
 =?utf-8?B?bzI5Z01sTUF1OWVKSGM0bU95V29lRDNBZGZXeStJTTZQSnZtc0haTFpFemNQ?=
 =?utf-8?B?QXByYkxiTnRMWU54NGYremJKWm96b2NIcDl0ajlaQVh6OHJjcGxTZ2JESlZy?=
 =?utf-8?B?TzUwZ1pmRXhvdkovclJWbno5T0VET0FWL0xtZVJBMjMxT3diYnRPWURFTnJK?=
 =?utf-8?B?akxrYktZZ21VMkZKL1Z1WjRUdll4YWhZR1dOK0JWYmZYMEdFaHEyTjY0S1hs?=
 =?utf-8?B?UVpKN09ZdmFPVG1uSzBPUHJJeE5ueFBWdDkwN1ZmbjM3M2RTWTRxOUVpRjI0?=
 =?utf-8?B?dXBNRytnOUtJc2VPNUZzbWk3SXdnd2p3T3JRWmk1UUhhT2lPSVlha0lobFJZ?=
 =?utf-8?B?bEVCcm1jTitQRlNiR3ZaNjlzZ3lnQ3E5YVlHcHlMM2lBcngvUGVjUnFBaC8z?=
 =?utf-8?B?bkJZTXdMQ3p4Vkp3dXA0TS9tc3JKWnFyREtRbzZidEhCbkoyUU0yVFFpeHpB?=
 =?utf-8?B?OFgrQUF3eDVoV0JTN0JyU2FoaGMrdmllTmMyM1lLRlRhWXJ5d29GaURqTHJZ?=
 =?utf-8?B?clh1Q08zM09lcDliVFB0Y3d1MUJTeTJkeDZKUFByaWRpbGYzM0ltckZCNTBV?=
 =?utf-8?B?SENOTnlwME54d1dzZ0NmUjFja2t2K0JBeFBDbUtxS3UrZVpaWDBqcjFnVHEy?=
 =?utf-8?B?Q2wySlh6L3E4WlVKdEhGalpuQVdCNCtOdmNkYXA1N3lNR2oxbjF0UWtiRUcx?=
 =?utf-8?B?RDUwYVJnckdzUnM3d2JDZ2R5M1VtMHRZQVg3b3pkTXVESjJBZHFWQkIwZ3JT?=
 =?utf-8?B?dmZMZENqa1FoNTFQSFpmMHdCMUN4Lzdld2JZVmM3Yld5eXR3V1B2ejVId1ZI?=
 =?utf-8?B?djRYaDNwRXpDSFg3Ym8wYWNYNHg2dFlTLytoQnlJUGZndmhPT0RVWnZ3NGtQ?=
 =?utf-8?B?MmpwNHlqbHZPSEdFV05LYTBnVkU0aVg1d3cwbzlzOWJoZW5nVGdLdXkwQXZS?=
 =?utf-8?B?YUcwcWNMd0orVUlicG5RNCsrUWlqWWNHQzhsT3FFWGNDUHVrRm4vU3hMc3Rt?=
 =?utf-8?B?NHdsVDBaZXBNenh1K05wR1BubVd4S0c2L0haU284OHhCMnB1OVRYUkdxMXZX?=
 =?utf-8?B?cVBlRlgxdCtWNmJzTEFqbEg5ZTMzTnlyOVlnK1J1RVJIY2ZtV29XWWlNL2Fx?=
 =?utf-8?B?TmxXeFdBWTZHQlJKY0xrdWdydW9lMEZEQ0hJaFhLOXREOHBWUHE5QWdJWWF6?=
 =?utf-8?B?bkpJTFVNK3hTRjY0ZW5RZENaMUJNZnVFK1N2UlR6QUZ2MHV0T1JxOW1iNXBj?=
 =?utf-8?B?dDNyV1g3dEoreEZwY240RUhsbVV1cE8wWFBVTzRFQnpwZmdFUjNzQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 48802ec9-0ecf-435d-a52e-08def30fc8af
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 16:37:05.1574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FNIH8/0lIFW/VyJKPGuekVc6eAUfvIUCz5jhIpQ74aTz4Dt9v+3atffrbPd+vAjZ4BWe1EAHXDyk9ROORatOkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5822

All registers use the same base type, which is `<IoMem as IO>::Target`.
Thus add the base parameter to `register!` invocation.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/drm/tyr/driver.rs |  1 +
 drivers/gpu/drm/tyr/regs.rs   | 43 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index bfb0ba19caff..730b84e37a54 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -46,6 +46,7 @@
 };
 
 pub(crate) type IoMem<'a> = kernel::io::mem::IoMem<'a, SZ_2M>;
+pub(crate) type TyrRegisters = kernel::io::Region<SZ_2M>;
 
 pub(crate) struct TyrDrmDriver;
 
diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
index a62724378ced..3e6edae6e27f 100644
--- a/drivers/gpu/drm/tyr/regs.rs
+++ b/drivers/gpu/drm/tyr/regs.rs
@@ -57,7 +57,11 @@ pub(crate) mod gpu_control {
         uapi, //
     };
 
+    use crate::driver::TyrRegisters;
+
     register! {
+        base: TyrRegisters;
+
         /// GPU identification register.
         pub(crate) GPU_ID(u32) @ 0x0 {
             /// Status of the GPU release.
@@ -315,6 +319,8 @@ fn from(mode: FlushMode) -> Self {
     }
 
     register! {
+        base: TyrRegisters;
+
         /// GPU command register.
         ///
         /// Use the constructor methods to create commands:
@@ -380,6 +386,8 @@ pub(crate) fn clear_fault() -> Self {
     }
 
     register! {
+        base: TyrRegisters;
+
         /// GPU status register. Read only.
         pub(crate) GPU_STATUS(u32) @ 0x34 {
             /// GPU active, a 1-bit boolean flag.
@@ -463,6 +471,8 @@ fn from(access: AccessType) -> Self {
     }
 
     register! {
+        base: TyrRegisters;
+
         /// GPU fault status register. Read only.
         pub(crate) GPU_FAULTSTATUS(u32) @ 0x3c {
             /// Exception type.
@@ -768,6 +778,8 @@ fn from(mode: CoherencyMode) -> Self {
     }
 
     register! {
+        base: TyrRegisters;
+
         /// Coherency enable. An index of which coherency protocols should be used.
         /// This register only selects the protocol for coherency messages on the
         /// interconnect. This is not to enable or disable coherency controlled by MMU.
@@ -808,6 +820,8 @@ fn from(mode: McuControlMode) -> Self {
     }
 
     register! {
+        base: TyrRegisters;
+
         /// MCU control.
         pub(crate) MCU_CONTROL(u32) @ 0x700 {
             /// Request MCU state change.
@@ -849,6 +863,8 @@ fn from(status: McuStatus) -> Self {
     }
 
     register! {
+        base: TyrRegisters;
+
         /// MCU status. Read only.
         pub(crate) MCU_STATUS(u32) @ 0x704 {
             /// Read current state of MCU.
@@ -862,7 +878,11 @@ fn from(status: McuStatus) -> Self {
 pub(crate) mod job_control {
     use kernel::register;
 
+    use crate::driver::TyrRegisters;
+
     register! {
+        base: TyrRegisters;
+
         /// Raw status of job interrupts.
         ///
         /// Write to this register to trigger these interrupts.
@@ -912,7 +932,11 @@ pub(crate) mod job_control {
 pub(crate) mod mmu_control {
     use kernel::register;
 
+    use crate::driver::TyrRegisters;
+
     register! {
+        base: TyrRegisters;
+
         /// IRQ sources raw status.
         ///
         /// This register contains the raw unmasked interrupt sources for MMU status and exception
@@ -966,9 +990,10 @@ pub(crate) mod mmu_as_control {
             prelude::*,
             register, //
         };
-
         use pin_init::Zeroable;
 
+        use crate::driver::TyrRegisters;
+
         /// Maximum number of hardware address space slots.
         /// The actual number of slots available is usually lower.
         pub(crate) const MAX_AS: usize = 16;
@@ -977,6 +1002,8 @@ pub(crate) mod mmu_as_control {
         const STRIDE: usize = 0x40;
 
         register! {
+            base: TyrRegisters;
+
             /// Translation table base address. A 64-bit pointer.
             ///
             /// This field contains the address of the top level of a translation table structure.
@@ -1104,6 +1131,8 @@ fn from(val: MemoryType) -> Self {
         }
 
         register! {
+            base: TyrRegisters;
+
             /// Stage 1 memory attributes (8-bit bitfield).
             ///
             /// This is not an actual register, but a bitfield definition used by the MEMATTR
@@ -1137,6 +1166,8 @@ fn from(val: MMU_MEMATTR_STAGE1) -> Self {
         }
 
         register! {
+            base: TyrRegisters;
+
             /// Memory attributes.
             ///
             /// Each address space can configure up to 8 different memory attribute profiles.
@@ -1353,6 +1384,8 @@ fn from(cmd: MmuCommand) -> Self {
         }
 
         register! {
+            base: TyrRegisters;
+
             /// MMU command register for each address space. Write only.
             pub(crate) COMMAND(u32)[MAX_AS, stride = STRIDE] @ 0x2418 {
                 7:0     command ?=> MmuCommand;
@@ -1480,6 +1513,8 @@ fn from(access: MmuAccessType) -> Self {
         }
 
         register! {
+            base: TyrRegisters;
+
             /// Fault status register for each address space. Read only.
             pub(crate) FAULTSTATUS(u32)[MAX_AS, stride = STRIDE] @ 0x241c {
                 /// Exception type.
@@ -1705,6 +1740,8 @@ fn from(sh: PtwShareability) -> Self {
         }
 
         register! {
+            base: TyrRegisters;
+
             /// Translation configuration and control.
             pub(crate) TRANSCFG(u64)[MAX_AS, stride = STRIDE] @ 0x2430 {
                 /// Address space mode.
@@ -1760,6 +1797,8 @@ fn from(sh: PtwShareability) -> Self {
 pub(crate) mod doorbell_block {
     use kernel::register;
 
+    use crate::driver::TyrRegisters;
+
     /// Number of doorbells available.
     pub(crate) const NUM_DOORBELLS: usize = 64;
 
@@ -1770,6 +1809,8 @@ pub(crate) mod doorbell_block {
     const STRIDE: usize = 0x10000;
 
     register! {
+        base: TyrRegisters;
+
         /// Doorbell request register. Write-only.
         pub(crate) DOORBELL(u32)[NUM_DOORBELLS, stride = STRIDE] @ 0x80000 {
             /// Doorbell set. Writing 1 triggers the doorbell.

-- 
2.54.0

