Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020082.outbound.protection.outlook.com [52.101.196.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04AF3D9021;
	Tue, 21 Apr 2026 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776783397; cv=fail; b=OLLvDmjFNUtOJEGBz2a1CcvL6PNyKCvGk1854qdwvcrVWAjUI6HsPECkSVSoFuY417+4MGAIya6gV3sqlQ3tg9+7IU+KpWvMFuZL8PucKSBI0t8uLKhd2SQWA0pPtVb/aSb81B4wzRWDmHHogTHw5bIdN88Qfy1/DUx/qxG9+gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776783397; c=relaxed/simple;
	bh=+v90d6nPJJL+5nNeYYRyZ5OswaRENd0OB2njGVD8jPs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=QD5t00Y0aOuruoAcgbAUzw8u22rErtXZ2Sy39WKCxa1ve0UKcPmQKo47tZwar/1bBqwkA4U+VG5kQ4wleJi1Gf2XDJAiImpsNvKHGENraYFhhf/kzrBzLrl9zKxqhjPGelOqin60D+itESs26k3sLBhqpW7C2LoTLQ4IEBIMFto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=tkQEhTUZ; arc=fail smtp.client-ip=52.101.196.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="tkQEhTUZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HaGwfNv72mYchzzfVvgspeUAuI2IivVFBPgtTeRZbM8DB7aj8ph6hjLfsavrr4OkaDa7R6dU2bW41BUD1xczxYmplHOuIRopjHRUCZD64DFWeEJPRPOIXQtlU303m9sphuUAiYLstFfq1sy4aMmdnDtMQLuC9ShBCSvrrjSBSzkYlPe1pGck6IqJ1kNXs08bEkGfXMDIk4H9GIy1sWJN9CteXURlHH7J3rVRqDPd6Wj3s9rLYIahEeFaDfA/ziYEHfg0nrBAtMEHcSTj5hcph21jZC2k0gBx6MHIJW/07MvH4RKZbb3ki2j4KO5gToq5HJ/8Iq0mposWb0IA2mVUnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMrf3c+zwtgjUAEfo1PPqVecL3lCus38m4GaKEn0YNE=;
 b=roYH/ekkbH0gAlrjf8/DPh842k2rVGlT3UQRnbKg9wg1bH9/vViiSff1ud08twTma32+/MjHwYsyZ5NTH4VwMNzHXcOicndXmHkFMyKgiynHRghwTztEfbg1NVvadkL88SaAO/mVK0yVShJ7t595kANo5x5mHWFAE58Z7yR/pizjRWiiCFdr3SwRDq/sI4rV3/UhPtYhwH6tWs4HHk8qOaMecODqpNFKOa0pSuq6/O9R8pnWyto3w0KOMXSCe8JI7VyaAOksMfkIe1HQbMDFGEqOSoMioyxe9kx4KdzaZAPMIJzt9CkdnzpGPKzLBmwnAqGABMPe/KxtT+PaBxfUyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMrf3c+zwtgjUAEfo1PPqVecL3lCus38m4GaKEn0YNE=;
 b=tkQEhTUZ61ZhGpzOKQRAkuDB0Ly1iKddFS8/n9jWBEiqDV/sIDG8p5Qk3nzPX/wNGsEqH/4cn2ZVK8rbnS9Hzc3KZE9HItMsKkcXyARfOzwVHUA5mL+v9woWxB0Am7zA5YVXHcsh1IefRb8wpWIiOpXxeTrJCABcerLHtg/mxik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB5523.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 14:56:28 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 14:56:28 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 21 Apr 2026 15:56:14 +0100
Subject: [PATCH v2 03/11] rust: io: use pointer types instead of address
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-io_projection-v2-3-4c251c692ef4@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776783386; l=19161;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=+v90d6nPJJL+5nNeYYRyZ5OswaRENd0OB2njGVD8jPs=;
 b=vDuEVX4OICrx6bQ7VPCc+PjRpdD5QenD1dHrTb3fP1soxlglMrTgxHWFC/Pgx/QR55uYDaPZF
 4XiArnKHTapAdTxdAJR9HTNY7MqyWut9f7ldElTDRIiEHGPWx2g0AzF
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
X-MS-Office365-Filtering-Correlation-Id: c3dac4c9-99d0-4c0d-71e0-08de9fb62a9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	r7i6aAoXO9YKwdyiGKUS/f4fYtuhO8bM7SAcvasLLwGpad3OfhLSydN3XkH/vlSMnrE5/YVdP0RBRNIhkPzDUtb7jZddBuxccDsSWRwmKwOS1pKMFbrb/7AvPmk5w+riAJ9CT36kMeS+Gg3i3bQuQ1+U3ieHFmweX41L0TW8r1RZnjRBw0f3QDi+6YyFr50yuB/6FjMTNtUk52BFuKX+NgcLC4lY387m1XjmHQycM779P2TL6ggfjyhoLxxp+cfU4dDmcZVbmwj1lUVT2gOvW1u2PcBizxFq91ThLJxXhxjaTAOzgo/7ao8pdyx0q2+aAl9QMFS5PbvKzF1ZuM0OpnTq7H0UEG9MI/H9yyYH4lMsKW+u0ldXyz6B1eWPjKZdfZtoePTLqQkKvgy7LNS9hvbaVNDt7hM15IVxqhWpnUigm/GFG9ZHdxvhc4gPzcM8/meKQKUgHtaIN7vgn5XpkNGD2oBa/eJpe8ZEIko+05XTN/UQ/Dq+nu+7DXUlSQdnA+cjKlPe5rrgXxx3wqqNXAcycr7drOTp90Zsk+IFPfw+3olqSRu+PD44sI4WSrneixt9PjvKvP+WoRB+Eh3Qcw2c4dMK7wvSV8+t+nBkvkuAq37osGrfLTsJta/nE+g2eJoE3zgkaP9wVOqqGTdwjZy1SDZtS9Ze/PxD7SBbFlvqJoAb91un5rfIwOvob1TsutPHx/ktJrGILV6adHi+W/u0mcNwPzTW+K7b05jZIy/mKkx3Yk60lRAKtB3HaFPeAZe4ffQh0id2PMjfwB5tdA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkZ6dHhoWFIxY0pNek0xbFR6VVJ1Mlg5N0JXY0dkb2U0Ynh4Zm5QeGlMQk92?=
 =?utf-8?B?aFBzU0M4YWtJcHQ1NnZ1ZElualJsVTB6MFJFKzd0aHdPN2RiZU83S0Z4U1F6?=
 =?utf-8?B?Q1FRdXorWTBBRzJTYzJJbjBmSk1VVDRHWWQvNzM1Qzh0VG1uWFBhK2d4b0F2?=
 =?utf-8?B?RFg5R0lJUWNLL2JXQVJGVkdLd1BOd3NFK1hDUGJFekFXclpCTHkybjZ6NkZS?=
 =?utf-8?B?U3krUVgwU0JlSld4bjR0eDFTVk5NRlA1aTdCcXp0UFlNTW03RktWendSS0U4?=
 =?utf-8?B?SFVBd2hYU1cybTNLTGtENkJwZlg2NDZucTgrNytGcWQ0bW0waGFrajVGejd0?=
 =?utf-8?B?bDE5NnpLS0ZOMkhyYmJJRjlEYjZQSlU3ZHh6c3ExMmN2NGRHbXVsTkQ1SU03?=
 =?utf-8?B?bllJNDloTDEwTlNsWnFTR05mb2RVaVF6QVNyMU5vUTlzMWwrZDVzV2RMVytB?=
 =?utf-8?B?NlF2U2w1b01IVDU3eFVFZ1h1SHV4QVlacUcwVyt2TFU0Y1hqQXBZNHk1TVMx?=
 =?utf-8?B?cHUrb3VyODJjUDFhaEQ4WHRzUHlEeXAvbHJMcXg1bEdCM2RvMHhGQUhaSHQ0?=
 =?utf-8?B?Vjlnbk1KZkdkOGNaa3JNQmpyTkZVcnFaT3ZNUHJwdEYvazlFNm4vZDY1U0g4?=
 =?utf-8?B?eFpScmhGQzc4QURNRngzTjFSbHFPdWF3QlB0T0ZDT05yWW0yWTlpZUFxbE5H?=
 =?utf-8?B?aktwQm1KWjB3UllZRlVwN0RiKzJJeXlXVzV4eUFHclRwc29MMWc1ZmVYTGpO?=
 =?utf-8?B?dkFEZTI2cU04RDN6ZXdTMGx6dU9yU29ibnFyc0tEdHN6VWhkaDFKWEsydW5K?=
 =?utf-8?B?dVM0bDhmdGQranhKMGxiOW93ZGp0UTd5OVMyT3d1cHhYZFVMTkFJWG9kQVBx?=
 =?utf-8?B?aHR1M1d2YTJuRkdpWDhTS00zR21wdEt6YkJXeUJLOHY5cHJtNTkwMisydWdR?=
 =?utf-8?B?OW1kQkNpSHZObzJuSElqcnBOaUVlcXVmNTdZdEJnQXVvN3pBeXpHMXFqMW8v?=
 =?utf-8?B?UVRpQUd0TUI2MlVwZWx5bjFWSzZ1TFcrQ056SHhJSXpOeEFPbTNwa05VOHQz?=
 =?utf-8?B?Vmhtcm8zYksxcGtKdkFYcFB3TUpmZEtPWjJwM0o0TWliWG40b3NzZklPNThN?=
 =?utf-8?B?aGhISDJaTjgrbzlwaFZvTHJZY3JKWWt4OW9iQ1k2dWVocXhod3Z3Sk9SZ0Zx?=
 =?utf-8?B?dmU5OFpmdENHY0dsaXh6aTBUTWM1Z09vc21BWjFIUnpUOEJPUHNSc2FNMWtY?=
 =?utf-8?B?UThsUXlQUDExd044MG5CWXM4NHAvZmEyQ0RyNXBGUHQ3NEJ1T1hzQzJOMUU1?=
 =?utf-8?B?RDUxclpWR1gzQmlkSmJSdllyNDA5TGt5TVlHZnhCZFIzVzlxOTFpbG13bTZH?=
 =?utf-8?B?bVhLUExJckZNSW4vWXYrWGtibU96TllETnlzNzRUa2pFU0VXNmVOQ09KYXQv?=
 =?utf-8?B?T2p1Y0lxYUI2U0V0cnVneTBVYjdPV2g2ZVlaUTdUKysrQ1BRdGFwYWw3TmhZ?=
 =?utf-8?B?TmFWMll6eDBKMm5EelZ5QWJnU1BTWEg2VEtna3JPT1ZPb0N5SEFMYzJ1d0t0?=
 =?utf-8?B?Y1dpQXFON2E4eDR0SHJKU2VWSFVRZHdYcGFyVjI0QnlhQStYS1lBWGN6N2dV?=
 =?utf-8?B?OEZnOWhhUGE0dVF5QnVneHdEL2VwZDVvcGt2TlovUHhIM3gvT29kdXlRZndB?=
 =?utf-8?B?anJYZG0rOTBBeW4xZU8xTVJyaTdqZWp2K0R4RDRNNi9mdWdPLzYyU0VmSURz?=
 =?utf-8?B?aStxQ1lhK2krdEhjRkNYVWZ6ZS9mY2d0ZG9DZjJSUkhNOTZLcXNUK2ZVMGxp?=
 =?utf-8?B?ZEUzRjV5OFVBL0wyTmNUaWtyMTJBeGlyeXYzeXg0OFhVVTViK29rNjJ3QkxD?=
 =?utf-8?B?Z0MxSjdGOWcyRS9obmtHVVBnZ3B0NytmdVJvYThOaFNyU0FqTFJ0VThUUjNU?=
 =?utf-8?B?WXFCekNvRk82cWc3UnpmUUlKL0lad0FiVWVjbXlRSjc3OEZkbUVHczhwN040?=
 =?utf-8?B?cHhFRzY2TUZ0azVtOTlFSklnMTlmMm4wbGJnZElkaE9VVFkwdnJaeS9ZSXRh?=
 =?utf-8?B?Y0NJOHlQUUxHb2I0S09LMjJkUDdURlJmQ0s2R0k3MmpVcTNpNFQvdUlqMklF?=
 =?utf-8?B?ZjVjaitHc2ZTVHg1NlBXMmVrTXo0N3ZoVjBRUTVMSTlyRTJZOVE4SjlFL2NR?=
 =?utf-8?B?d0J5M3lHeGdKSzBNQk9XWFlyalFxTE1EcDJRa1pNTW84VG1GVnpCVlVPYW1k?=
 =?utf-8?B?S2g4cEgrbEVBY3VyK2tIVm9oa0Z6SSt4UjBTQ2dkWGtPT2E3RTN3SjBnNkdD?=
 =?utf-8?B?aEV2cVNxT3Ewb3dwL25ncEl2SmpJSE8vaUhjSjlyakM3MWdyRllsQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c3dac4c9-99d0-4c0d-71e0-08de9fb62a9d
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 14:56:28.1880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZcMwBZCgR2Ml0FPY5vTc3uhkoRdzqcFg7l8CbxSViYmnI7T4kOGC1IiXxEEiuDjjJN0fGDCE4mx6YAROvplBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5523

This carries the size information with the pointer type and metadata, makes
it possible to use I/O projections and paves the way for IO view types.

With this change, minimum size information becomes available through types;
so `KnownSize::MIN_SIZE` can be used and `IoKnownSize` trait is no longer
necessary. The trait is kept for compatibility and can be removed when
users stop using it for bounds.

PCI config space uses only offsets and not pointers like MMIO; for this
null pointers (with proper size metadata) is used. This is okay as I/O
trait impl and I/O projections can operate on invalid pointers, and for PCI
config space we will only use address info and ignore the provenance.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/devres.rs |   2 +-
 rust/kernel/io.rs     | 123 +++++++++++++++++++++-----------------------------
 rust/kernel/io/mem.rs |   2 +-
 rust/kernel/pci/io.rs |  74 ++++++++++++++++++------------
 4 files changed, 99 insertions(+), 102 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 3e22c63efb98..ea86e9c62cdf 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -101,7 +101,7 @@ struct Inner<T> {
 /// impl<const SIZE: usize> Drop for IoMem<SIZE> {
 ///     fn drop(&mut self) {
 ///         // SAFETY: `self.0.addr()` is guaranteed to be properly mapped by `Self::new`.
-///         unsafe { bindings::iounmap(self.0.addr() as *mut c_void); };
+///         unsafe { bindings::iounmap(self.0.as_ptr().cast()); };
 ///     }
 /// }
 ///
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 0b9c97c0a1d7..1682f2a0d20d 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -105,8 +105,8 @@ pub fn new_region(addr: usize, size: usize) -> Result<Self> {
 impl<T: ?Sized + KnownSize> MmioRaw<T> {
     /// Returns the base address of the MMIO region.
     #[inline]
-    pub fn addr(&self) -> usize {
-        self.addr.addr()
+    pub fn as_ptr(&self) -> *mut T {
+        self.addr
     }
 
     /// Returns the size of the MMIO region.
@@ -166,7 +166,7 @@ pub fn size(&self) -> usize {
 /// impl<const SIZE: usize> Drop for IoMem<SIZE> {
 ///     fn drop(&mut self) {
 ///         // SAFETY: `self.0.addr()` is guaranteed to be properly mapped by `Self::new`.
-///         unsafe { bindings::iounmap(self.0.addr() as *mut c_void); };
+///         unsafe { bindings::iounmap(self.0.as_ptr().cast()); };
 ///     }
 /// }
 ///
@@ -217,14 +217,14 @@ pub trait IoCapable<T> {
     /// # Safety
     ///
     /// The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
-    unsafe fn io_read(&self, address: usize) -> T;
+    unsafe fn io_read(&self, address: *mut T) -> T;
 
     /// Performs an I/O write of `value` at `address`.
     ///
     /// # Safety
     ///
     /// The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
-    unsafe fn io_write(&self, value: T, address: usize);
+    unsafe fn io_write(&self, value: T, address: *mut T);
 }
 
 /// Describes a given I/O location: its offset, width, and type to convert the raw value from and
@@ -291,23 +291,35 @@ fn offset(self) -> usize {
 /// For MMIO regions, all widths (u8, u16, u32, and u64 on 64-bit systems) are typically
 /// supported. For PCI configuration space, u8, u16, and u32 are supported but u64 is not.
 pub trait Io {
-    /// Returns the base address of this mapping.
-    fn addr(&self) -> usize;
+    /// Type of this I/O region. For untyped I/O regions, [`Region`] type can be used.
+    type Type: ?Sized + KnownSize;
+
+    /// Returns the base pointer of this mapping.
+    ///
+    /// This is a pointer to capture metadata. The specific meaning of the pointer depends on
+    /// I/O backend and is not necessarily valid.
+    fn as_ptr(&self) -> *mut Self::Type;
+
+    /// Returns the absolute I/O address for a given `offset`,
+    /// performing compile-time bound checks.
+    // Always inline to optimize out error path of `build_assert`.
+    #[inline(always)]
+    fn io_addr_assert<U>(&self, offset: usize) -> *mut U {
+        build_assert!(offset_valid::<U>(offset, Self::Type::MIN_SIZE));
 
-    /// Returns the maximum size of this mapping.
-    fn maxsize(&self) -> usize;
+        self.as_ptr().wrapping_byte_add(offset).cast()
+    }
 
     /// Returns the absolute I/O address for a given `offset`,
     /// performing runtime bound checks.
     #[inline]
-    fn io_addr<U>(&self, offset: usize) -> Result<usize> {
-        if !offset_valid::<U>(offset, self.maxsize()) {
+    fn io_addr<U>(&self, offset: usize) -> Result<*mut U> {
+        let ptr = self.as_ptr();
+        if !offset_valid::<U>(offset, Self::Type::size(ptr)) {
             return Err(EINVAL);
         }
 
-        // Probably no need to check, since the safety requirements of `Self::new` guarantee that
-        // this can't overflow.
-        self.addr().checked_add(offset).ok_or(EINVAL)
+        Ok(ptr.wrapping_byte_add(offset).cast())
     }
 
     /// Fallible 8-bit read with runtime bounds check.
@@ -386,7 +398,7 @@ fn try_write64(&self, value: u64, offset: usize) -> Result
     #[inline(always)]
     fn read8(&self, offset: usize) -> u8
     where
-        Self: IoKnownSize + IoCapable<u8>,
+        Self: IoCapable<u8>,
     {
         self.read(offset)
     }
@@ -395,7 +407,7 @@ fn read8(&self, offset: usize) -> u8
     #[inline(always)]
     fn read16(&self, offset: usize) -> u16
     where
-        Self: IoKnownSize + IoCapable<u16>,
+        Self: IoCapable<u16>,
     {
         self.read(offset)
     }
@@ -404,7 +416,7 @@ fn read16(&self, offset: usize) -> u16
     #[inline(always)]
     fn read32(&self, offset: usize) -> u32
     where
-        Self: IoKnownSize + IoCapable<u32>,
+        Self: IoCapable<u32>,
     {
         self.read(offset)
     }
@@ -413,7 +425,7 @@ fn read32(&self, offset: usize) -> u32
     #[inline(always)]
     fn read64(&self, offset: usize) -> u64
     where
-        Self: IoKnownSize + IoCapable<u64>,
+        Self: IoCapable<u64>,
     {
         self.read(offset)
     }
@@ -422,7 +434,7 @@ fn read64(&self, offset: usize) -> u64
     #[inline(always)]
     fn write8(&self, value: u8, offset: usize)
     where
-        Self: IoKnownSize + IoCapable<u8>,
+        Self: IoCapable<u8>,
     {
         self.write(offset, value)
     }
@@ -431,7 +443,7 @@ fn write8(&self, value: u8, offset: usize)
     #[inline(always)]
     fn write16(&self, value: u16, offset: usize)
     where
-        Self: IoKnownSize + IoCapable<u16>,
+        Self: IoCapable<u16>,
     {
         self.write(offset, value)
     }
@@ -440,7 +452,7 @@ fn write16(&self, value: u16, offset: usize)
     #[inline(always)]
     fn write32(&self, value: u32, offset: usize)
     where
-        Self: IoKnownSize + IoCapable<u32>,
+        Self: IoCapable<u32>,
     {
         self.write(offset, value)
     }
@@ -449,7 +461,7 @@ fn write32(&self, value: u32, offset: usize)
     #[inline(always)]
     fn write64(&self, value: u64, offset: usize)
     where
-        Self: IoKnownSize + IoCapable<u64>,
+        Self: IoCapable<u64>,
     {
         self.write(offset, value)
     }
@@ -637,7 +649,7 @@ fn try_update<T, L, F>(&self, location: L, f: F) -> Result
     fn read<T, L>(&self, location: L) -> T
     where
         L: IoLoc<T>,
-        Self: IoKnownSize + IoCapable<L::IoType>,
+        Self: IoCapable<L::IoType>,
     {
         let address = self.io_addr_assert::<L::IoType>(location.offset());
 
@@ -670,7 +682,7 @@ fn read<T, L>(&self, location: L) -> T
     fn write<T, L>(&self, location: L, value: T)
     where
         L: IoLoc<T>,
-        Self: IoKnownSize + IoCapable<L::IoType>,
+        Self: IoCapable<L::IoType>,
     {
         let address = self.io_addr_assert::<L::IoType>(location.offset());
         let io_value = value.into();
@@ -715,7 +727,7 @@ fn write_reg<T, L, V>(&self, value: V)
     where
         L: IoLoc<T>,
         V: LocatedRegister<Location = L, Value = T>,
-        Self: IoKnownSize + IoCapable<L::IoType>,
+        Self: IoCapable<L::IoType>,
     {
         let (location, value) = value.into_io_op();
 
@@ -748,7 +760,7 @@ fn write_reg<T, L, V>(&self, value: V)
     fn update<T, L, F>(&self, location: L, f: F)
     where
         L: IoLoc<T>,
-        Self: IoKnownSize + IoCapable<L::IoType> + Sized,
+        Self: IoCapable<L::IoType>,
         F: FnOnce(T) -> T,
     {
         let address = self.io_addr_assert::<L::IoType>(location.offset());
@@ -762,41 +774,25 @@ fn update<T, L, F>(&self, location: L, f: F)
     }
 }
 
-/// Trait for types with a known size at compile time.
-///
-/// This trait is implemented by I/O backends that have a compile-time known size,
-/// enabling the use of infallible I/O accessors with compile-time bounds checking.
-///
-/// Types implementing this trait can use the infallible methods in [`Io`] trait
-/// (e.g., `read8`, `write32`), which require `Self: IoKnownSize` bound.
-pub trait IoKnownSize: Io {
-    /// Minimum usable size of this region.
-    const MIN_SIZE: usize;
-
-    /// Returns the absolute I/O address for a given `offset`,
-    /// performing compile-time bound checks.
-    // Always inline to optimize out error path of `build_assert`.
-    #[inline(always)]
-    fn io_addr_assert<U>(&self, offset: usize) -> usize {
-        build_assert!(offset_valid::<U>(offset, Self::MIN_SIZE));
+// For compatibility only.
+#[doc(hidden)]
+pub trait IoKnownSize: Io {}
 
-        self.addr() + offset
-    }
-}
+impl<T: Io + ?Sized> IoKnownSize for T {}
 
 /// Implements [`IoCapable`] on `$mmio` for `$ty` using `$read_fn` and `$write_fn`.
 macro_rules! impl_mmio_io_capable {
     ($mmio:ident, $(#[$attr:meta])* $ty:ty, $read_fn:ident, $write_fn:ident) => {
         $(#[$attr])*
         impl<T: ?Sized> IoCapable<$ty> for $mmio<T> {
-            unsafe fn io_read(&self, address: usize) -> $ty {
+            unsafe fn io_read(&self, address: *mut $ty) -> $ty {
                 // SAFETY: By the trait invariant `address` is a valid address for MMIO operations.
                 unsafe { bindings::$read_fn(address as *const c_void) }
             }
 
-            unsafe fn io_write(&self, value: $ty, address: usize) {
+            unsafe fn io_write(&self, value: $ty, address: *mut $ty) {
                 // SAFETY: By the trait invariant `address` is a valid address for MMIO operations.
-                unsafe { bindings::$write_fn(value, address as *mut c_void) }
+                unsafe { bindings::$write_fn(value, address.cast()) }
             }
         }
     };
@@ -816,23 +812,15 @@ unsafe fn io_write(&self, value: $ty, address: usize) {
 );
 
 impl<T: ?Sized + KnownSize> Io for Mmio<T> {
-    /// Returns the base address of this mapping.
-    #[inline]
-    fn addr(&self) -> usize {
-        self.0.addr()
-    }
+    type Type = T;
 
-    /// Returns the maximum size of this mapping.
+    /// Returns the base address of this mapping.
     #[inline]
-    fn maxsize(&self) -> usize {
-        self.0.size()
+    fn as_ptr(&self) -> *mut T {
+        self.0.as_ptr()
     }
 }
 
-impl<T: ?Sized + KnownSize> IoKnownSize for Mmio<T> {
-    const MIN_SIZE: usize = T::MIN_SIZE;
-}
-
 impl<T: ?Sized + KnownSize> Mmio<T> {
     /// Converts an `MmioRaw` into an `Mmio` instance, providing the accessors to the MMIO mapping.
     ///
@@ -856,21 +844,14 @@ pub unsafe fn from_raw(raw: &MmioRaw<T>) -> &Self {
 pub struct RelaxedMmio<T: ?Sized>(Mmio<T>);
 
 impl<T: ?Sized + KnownSize> Io for RelaxedMmio<T> {
-    #[inline]
-    fn addr(&self) -> usize {
-        self.0.addr()
-    }
+    type Type = T;
 
     #[inline]
-    fn maxsize(&self) -> usize {
-        self.0.maxsize()
+    fn as_ptr(&self) -> *mut T {
+        self.0.as_ptr()
     }
 }
 
-impl<T: ?Sized + KnownSize> IoKnownSize for RelaxedMmio<T> {
-    const MIN_SIZE: usize = T::MIN_SIZE;
-}
-
 impl<T: ?Sized> Mmio<T> {
     /// Returns a [`RelaxedMmio`] reference that performs relaxed I/O operations.
     ///
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index a6292f4ebfa4..f87a29f90e79 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -284,7 +284,7 @@ pub fn new<'a>(io_request: IoRequest<'a>) -> impl PinInit<Devres<Self>, Error> +
 impl<const SIZE: usize> Drop for IoMem<SIZE> {
     fn drop(&mut self) {
         // SAFETY: Safe as by the invariant of `Io`.
-        unsafe { bindings::iounmap(self.io.addr() as *mut c_void) }
+        unsafe { bindings::iounmap(self.io.as_ptr().cast()) }
     }
 }
 
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index e048370fb8c1..63c35eaab6c3 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -10,11 +10,11 @@
     io::{
         Io,
         IoCapable,
-        IoKnownSize,
         Mmio,
         MmioRaw, //
     },
     prelude::*,
+    ptr::KnownSize,
     sync::aref::ARef, //
 };
 use core::{
@@ -60,14 +60,37 @@ pub const fn into_raw(self) -> usize {
 pub trait ConfigSpaceKind {
     /// The size of this configuration space in bytes.
     const SIZE: usize;
+
+    /// Region type for this kind of config space. This should be [`crate::io::Region<SIZE>`].
+    type Region: ?Sized + KnownSize;
+
+    /// Obtain pointer with actual size information.
+    fn null_ptr_from_size(size: ConfigSpaceSize) -> *mut Self::Region;
 }
 
 impl ConfigSpaceKind for Normal {
     const SIZE: usize = 256;
+
+    type Region = crate::io::Region<256>;
+
+    #[inline]
+    fn null_ptr_from_size(size: ConfigSpaceSize) -> *mut Self::Region {
+        core::ptr::slice_from_raw_parts_mut(core::ptr::null_mut::<u8>(), size.into_raw())
+            as *mut Self::Region
+    }
 }
 
 impl ConfigSpaceKind for Extended {
     const SIZE: usize = 4096;
+
+    type Region = crate::io::Region<4096>;
+
+    #[inline]
+    fn null_ptr_from_size(_: ConfigSpaceSize) -> *mut Self::Region {
+        // Small optimization. For a extended config space, we already know that the size
+        // is 4096.
+        core::ptr::slice_from_raw_parts_mut(core::ptr::null_mut::<u8>(), 4096) as *mut Self::Region
+    }
 }
 
 /// The PCI configuration space of a device.
@@ -87,28 +110,28 @@ pub struct ConfigSpace<'a, S: ConfigSpaceKind = Extended> {
 macro_rules! impl_config_space_io_capable {
     ($ty:ty, $read_fn:ident, $write_fn:ident) => {
         impl<'a, S: ConfigSpaceKind> IoCapable<$ty> for ConfigSpace<'a, S> {
-            unsafe fn io_read(&self, address: usize) -> $ty {
+            unsafe fn io_read(&self, address: *mut $ty) -> $ty {
+                // CAST: The offset is cast to `i32` because the C functions expect a 32-bit
+                // signed offset parameter. PCI configuration space size is at most 4096 bytes,
+                // so the value always fits within `i32` without truncation or sign change.
+                let addr = address.addr() as i32;
                 let mut val: $ty = 0;
 
                 // Return value from C function is ignored in infallible accessors.
-                let _ret =
-                    // SAFETY: By the type invariant `self.pdev` is a valid address.
-                    // CAST: The offset is cast to `i32` because the C functions expect a 32-bit
-                    // signed offset parameter. PCI configuration space size is at most 4096 bytes,
-                    // so the value always fits within `i32` without truncation or sign change.
-                    unsafe { bindings::$read_fn(self.pdev.as_raw(), address as i32, &mut val) };
-
+                // SAFETY: By the type invariant `self.pdev` is a valid address.
+                let _ = unsafe { bindings::$read_fn(self.pdev.as_raw(), addr, &mut val) };
                 val
             }
 
-            unsafe fn io_write(&self, value: $ty, address: usize) {
+            unsafe fn io_write(&self, value: $ty, address: *mut $ty) {
+                // CAST: The offset is cast to `i32` because the C functions expect a 32-bit
+                // signed offset parameter. PCI configuration space size is at most 4096 bytes,
+                // so the value always fits within `i32` without truncation or sign change.
+                let addr = address.addr() as i32;
+
                 // Return value from C function is ignored in infallible accessors.
-                let _ret =
-                    // SAFETY: By the type invariant `self.pdev` is a valid address.
-                    // CAST: The offset is cast to `i32` because the C functions expect a 32-bit
-                    // signed offset parameter. PCI configuration space size is at most 4096 bytes,
-                    // so the value always fits within `i32` without truncation or sign change.
-                    unsafe { bindings::$write_fn(self.pdev.as_raw(), address as i32, value) };
+                // SAFETY: By the type invariant `self.pdev` is a valid address.
+                let _ = unsafe { bindings::$write_fn(self.pdev.as_raw(), addr, value) };
             }
         }
     };
@@ -120,23 +143,15 @@ unsafe fn io_write(&self, value: $ty, address: usize) {
 impl_config_space_io_capable!(u32, pci_read_config_dword, pci_write_config_dword);
 
 impl<'a, S: ConfigSpaceKind> Io for ConfigSpace<'a, S> {
-    /// Returns the base address of the I/O region. It is always 0 for configuration space.
-    #[inline]
-    fn addr(&self) -> usize {
-        0
-    }
+    type Type = S::Region;
 
-    /// Returns the maximum size of the configuration space.
+    /// Returns the base address of the I/O region. It is always 0 for configuration space.
     #[inline]
-    fn maxsize(&self) -> usize {
-        self.pdev.cfg_size().into_raw()
+    fn as_ptr(&self) -> *mut Self::Type {
+        S::null_ptr_from_size(self.pdev.cfg_size())
     }
 }
 
-impl<'a, S: ConfigSpaceKind> IoKnownSize for ConfigSpace<'a, S> {
-    const MIN_SIZE: usize = S::SIZE;
-}
-
 /// A PCI BAR to perform I/O-Operations on.
 ///
 /// I/O backend assumes that the device is little-endian and will automatically
@@ -219,7 +234,7 @@ unsafe fn do_release(pdev: &Device, ioptr: usize, num: i32) {
 
     fn release(&self) {
         // SAFETY: The safety requirements are guaranteed by the type invariant of `self.pdev`.
-        unsafe { Self::do_release(&self.pdev, self.io.addr(), self.num) };
+        unsafe { Self::do_release(&self.pdev, self.io.as_ptr().addr(), self.num) };
     }
 }
 
@@ -267,6 +282,7 @@ pub fn iomap_region<'a>(
     }
 
     /// Returns the size of configuration space.
+    #[inline]
     pub fn cfg_size(&self) -> ConfigSpaceSize {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
         let size = unsafe { (*self.as_raw()).cfg_size };

-- 
2.51.2

