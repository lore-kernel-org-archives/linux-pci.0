Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022106.outbound.protection.outlook.com [52.101.101.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F046C49218E;
	Thu, 11 Jun 2026 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195328; cv=fail; b=OAB+kWNYiv8hgQup3xIQP5Tw5f0PWNCKPX3TwSKGH5VAd1inq3WD3CbpsY55SIBWccJwiNG9bj+nEcwI0IWbcEJx92/iNk1fvIDKaV/BINHvYMNLCipSDLrFGRdEpBuu7oLGzKdMYRj7Kie0dWf4NKtkrTBAC0bEoMhnGcaTtbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195328; c=relaxed/simple;
	bh=1KDVAjQDV95PM3cfyWvcXgbs2vPjx8HAx1il87YdtO4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=G25DFRJcNLpoAG3zyNDcnuTcrdRhRxDvlhlLQqMwTLxTmjNzGOO+61sv6B906YBNJuR1TWY/o0CbE6J6LlS2rNw24PSqj5Bj8QScEqufVkd+8sJIDFPyP49tixx5Smh+FyqXDKwKqjrPIhZw67KUJElTk4JEobh54DYIPkVCp2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=hPCnsMEc; arc=fail smtp.client-ip=52.101.101.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="hPCnsMEc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQXGePBBfXa+yumTqNfQov25nx098EE4nZFQqh7TSzgqn3FPfPf7D8GiiE501M68O4qt3e34PsSfqW93XOgSvibXx4vT6qRl8FdXPvIe6MNTvcwes7DjIaknwRif6RFT+fOOGaSfnABdAEZE3dKwmeihlsUMy8ry8UYnVaMlxsiNuz8mHyW57RPE2sv1YQDE2bVQYYyQ7+qzXS/oArH2AtJhBlAoiqJib+ovQOvueeQeQWALzfjy9dv4/z8A31ryVpAvBJVhhL/Vi8NiBL/qNb7Lqzj2iQ7kpCnT9szlmBKzT1QkJwyMlV0SGZzZzZrhZujcKvdZF8coUX62czfh4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFdRUcJQKUmV8oOcbV0z2r4i9Jy5D1L9pgQmGTpA1mo=;
 b=ROp3AH+VGsAzEFU8H1mOyi1PEYr98GFlNObEmP2xcfZ6hdV1UY4J0sEnyKph66nGqrRltfR5LcJMUww5qRrBHnGVA7U1pXDC8rldr4IxYzaRMIyfiZVITIl8QOTMEoUEo+qtM2/ujpYE5qtDyNxljo3YrPxNXqy854uHF9Dz6toXAtiuv1kETKObBUoP0l9Na9JwVQ07F+hcnJSqRRzOl14Oczo9LPgEaejGJq+3fJyKnrCt5BtYGCbODxBqxcluZE0rP1/TOtQl1yo/Gz+/nDOmH17PvPjb0TstOPaCpgk4tnBeMvdImmol4LfmqeWTLlqv1IeBU/+LS/deX/tCGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFdRUcJQKUmV8oOcbV0z2r4i9Jy5D1L9pgQmGTpA1mo=;
 b=hPCnsMEc4L2ZbDx/hjj1ZP3mELzbhrzk+9ZXNCA5CmK9LvgyP8wojTVEsySeXqQUVcfY6MpwQ7DeReZjXdpdVVinW8eqJHYJgdRoNLTSNZra4iKF/LMzHHuqOwzoOiuhJX+aO9dcH+T43ae8ZmUP7BiTPCebd77zF7bdFGTfr6o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO4P265MB6525.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 16:28:31 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 16:28:31 +0000
From: Gary Guo <gary@garyguo.net>
Date: Thu, 11 Jun 2026 17:28:17 +0100
Subject: [PATCH v4 15/20] rust: io: implement a view type for `Coherent`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-io_projection-v4-15-1f7224b02dcb@garyguo.net>
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
In-Reply-To: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781195301; l=5630;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=1KDVAjQDV95PM3cfyWvcXgbs2vPjx8HAx1il87YdtO4=;
 b=c7xzNkTsWyiJmKWVAGEQpL81CRSxBBYivP+ay1LdYHixnomtGZ7XpNC7okK+pMDRBhcMGkRsS
 XsUdtaluzWsCNTURToWIKpyVkF10g3LeaP8hMTMlDZiLu5vSBfOxa/u
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO6P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::8) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|LO4P265MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: e64add29-28fe-4cb2-8fd6-08dec7d679ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10070799003|921020|6133799003|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pyXQ3WVdA/x4Yhs8Z8GWc9QwsKf56h+4jTLtdiHvlYspdcgyN9fVrD9NafZ2ieebWEDyMAjmfRrxHxATKM1tNBGnBR9tMWY9RXhlcj5iq+yAsHzjhUJCs6uavzhAXeEZ+29XuyqyQeQ1OqHBPFaPWF6ZHQpZbfWJ1rTEo5qJseeTD6ttVaGWWSffGvUdH2qv+mwqKpRbWiCq7l2XqWgbK4bk9Jat8Aw44/AFuWCeJIXUKAuB8OBCf4wF4ZC4wZmACccECkkUGz1oX4mE94Q8SFbhpY+7aqGVKgc97/qpcJXe6+NZob8asX4gBpVRdj8YuMvxljEdw61p+P1a5t9d4owo+cMfe7IbVGQIvaf+t/QV+nzbTWNS8fWHd5EdGw7oSonUec9EDewjDlHye6h/XQqzB4mCVJ55VTUBIA5ubk14Hz99k9kasu/nzE0JeWs5LX4yUnm4ydOBGdmoQ4KNlmU+4gp4fdAJG9tThjX3rFjfhwEejdJMeL8n1z4Bva0hsazfK/44CuR9YKzaPnNc0zQ36RGbSKWRTDPLDkTiaZ+3gkWTJX29vleMqCklAidVy2nLfhSgJDONTIaLrBXsI4LEAu3FRYqrI7v7aqyb+QYeUdeG8RSKpOzu84+IEeOMSQhqQ7cfj3CEEszlEMs4L/tPI2qIYgf6E6qXFRmSKHLIDmBIvIbbUI62QWPg1HFt50MNsgSRaZL0VZ1lIUTmVegKaCz2qD8uStPWM5ygIoo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10070799003)(921020)(6133799003)(56012099006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmV4N2ZBQWNpODBYZ1hYSDdTck5NNmlyV253d2VvNndCUW92L1h5d3lnY2Rz?=
 =?utf-8?B?M0ZIcWduYm5hNVJoOURzdnR2d2ZqRHNLR0J6WTFHZk01dnRyc3hnYm1xSXVF?=
 =?utf-8?B?byt6U2MybVdGVm45QWNFb1A1blJnbnVVRmtlZXNBc2txeExXR3h2YXZjeW10?=
 =?utf-8?B?cUlzTXlNVGxTM0NDcTZnUklVc0haNkZPbFg3VzlQcUk4ZVZDWWE0bWRzbW1m?=
 =?utf-8?B?cFJ2bnZhUE4vRklveVUxM2txaU5LczZMWU1wRVE0OEVOUlU5MWhBMkJJM01O?=
 =?utf-8?B?NWxqWjJMV2tYdG1Wc1JITmcxc29hcCttU1l5MmYrOTRYNVRoQmFINGpZQVZN?=
 =?utf-8?B?NVpzWUprdG9DZzhZNVQwWTlPZEtOeVlzY2RzRjd0Y3d4ZkQrQ0oyM00zZU96?=
 =?utf-8?B?ZVdIY3lyaUM1T2V6SFNscDEwVmdqOTMrVURvQUFaRTdNTGNMNUxBYW9TQVdZ?=
 =?utf-8?B?b2I3RUI4a2g5R1lnU0x1OGNZTWh2OW50N20xbDRHU2Jobk1rcEZrcTREK1o2?=
 =?utf-8?B?SG4wTUJsdTAvWHhiNkltcFFERy9RM0pQTEMxMW9ocW44bFNvRjZIbXpSaDda?=
 =?utf-8?B?dUo3ZW9ZQmVJSkdkU05xZDV0ekxBdXJ1clNrZGRIYmNLMEhOUkdBdDB4bG9k?=
 =?utf-8?B?ZFU0cUU3cW1vR0V3Nm9Xc3NPUGw4UG42TjJHMURueVlLRDZiR3hsYm4vZ29w?=
 =?utf-8?B?SVJoZUJDelQrUE1IMkUrNFNBYnRLSVg5b2hOcm9TbFc3ZGRwdThSSTNCUGRM?=
 =?utf-8?B?U0dVa2gyREVpS3czNGNUMTNGUk8ydEYyM3JZd0tEcVhzRVBydjBvYlJhKy9w?=
 =?utf-8?B?N3JBL0g3bTJHMm1pQmpSWEpreStqUUp6U0FCRW8zQkx1aCsrSEpNRFVWU09Q?=
 =?utf-8?B?dUJ1NVRaZmlLVFlBUitIZENpVUVmNXhlK0toUDlrOHprSktveHZwd2x6SXIx?=
 =?utf-8?B?SDdNWEhlaythdWo0ZGdYV0EvTS9ieEVJU0VUYTJjclg3R01WeGxKUFJzUjBB?=
 =?utf-8?B?S0cvcHV0bXRaa3Q0SVlka0k3WHJDejJnUGVuckVkaFAralNzL05YU29ZOWMw?=
 =?utf-8?B?MTJ5SzhBNEJMWnhmRUhBand4MXMrUlNLdlZscmRKSEJtc2x6aGhqb1k0M2dy?=
 =?utf-8?B?dDl0RllMcHdtSEtkVTEvbXc1M1NZN2djV21tSDNjT2tNOVBYRWxQZVdBdWFU?=
 =?utf-8?B?Y3hCeUo1NllHdEt0V3NmS3QrTWNacWNnSVlrYVlGREJoMVVMb3BZSUlMOUxr?=
 =?utf-8?B?VHVnck5OcE1hbUdMVzJnVTlLcEtYT3p0SUF1OTFzdUxEYnE2bTBlWlM1SG9T?=
 =?utf-8?B?N1JUTXlRdUNDM1YzMGFET1NuMW40YVNKeVNvN0dmRlFDUC9rZHc5bUliOG0r?=
 =?utf-8?B?VkJoaS9tbE9IazNUbDhwamI5c05ncUhSc3JvMnd3em5ISDJnckJPNzNSWklO?=
 =?utf-8?B?TFpzTFRQWkVCaGp2bUlKZjJEQ2lWT2dEdXdwbEd4VkgyR2drVTI5SVlnSDRQ?=
 =?utf-8?B?dmp0Qkp6SWU1ZVRNdmpwUFROcHdqS21rSUxqazIwQkI4Q2NnZkVUT2xlMXha?=
 =?utf-8?B?NnVvWnMzMTVJNWJNaTdFY3FVN1ZjakxNRUZaK09EL1dFSmRuUFBUTnk5MlFF?=
 =?utf-8?B?eHh0MEFXV1k3blIrMi81QmdoRU1ZN3cvY0p2UWJvckw3UENvTFhFdzVkYm5T?=
 =?utf-8?B?QnpWZUhVc0RkUWIweHdoSDBtUzl1MXZZOXlHRGpzYThkQ3JMK0dCbEdtbkU4?=
 =?utf-8?B?UC92T1p3RTZvYWlhOHEwS2t2cUZ0YThpZ2wxN3pPTEErekZ4U3lhbjIvTTB6?=
 =?utf-8?B?OFpGNm56Mkx0VHNROW9oMSttTnNCWUZRdmFSNHFnbGVzNnRnTGttQzBvSS9F?=
 =?utf-8?B?Vno5S0NLQzZKbkxVT2E5M0pRSmZ5VHlQRnRZRUlyM1NuYmNJNmFrQVNiYW1o?=
 =?utf-8?B?ZGM5em9mYU9PTjFhTDZzTTU3YVlEWW13L1VCaWtiQkNRT3JNZHFQc1pLVm1z?=
 =?utf-8?B?UFgrV1Y5R3hCbVA4TW8vbm42TnpHMWg3bExMbitJWmhzcW96ZVlNUUVNam0w?=
 =?utf-8?B?Y0MwdDcrQ2owY2h3dGVFREZnaUlDY3kyZzNwRzhkRWVKc1pReXJRWkZLYWRL?=
 =?utf-8?B?ZkdzUnV2a291V3UyTGtORDI1YVk5MklsTHhic0x6M1AzUXpQNGtUNTNOTkpN?=
 =?utf-8?B?b2p0UFFOUlBpaUpvTFU0OEJUOHM3NEg1TU9CS2wveTB0aXNmWElrMCsvZ0pK?=
 =?utf-8?B?Q3VFZC9pN0xjYkxFeHk1VGxvUFh2M3FIR2dibVRITWJ4dTA2dmRVLzAzT1VS?=
 =?utf-8?B?OFRUbUZyZ3k5bEtqRU1oVTVWZFlpMnZ2QTI0RE9ycnZyaTBrSGNjQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e64add29-28fe-4cb2-8fd6-08dec7d679ce
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:28:31.4660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1OMj9mXTc2cIjQVL4NX4ECfaFM6Y/OcZiZRMmHpMQeku5S2Kc1n5EEh7x7AGtGzvdMLSaJaEAsbZ0hTXPz0vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6525

Implement a `CoherentView` type which is a view of `Coherent`. To be able
to give out DMA handles, the view type contains both CPU and DMA pointers,
and the projection method projects both at once.

Delegate most of the `Io` implementation to `SysMemBackend`. Provide a
method to erase the DMA handle and give out a `SysMem` view, if the user
does not need the `dma_handle`.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/dma.rs | 137 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 135 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 200def84fb69..ab6504910e4f 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -14,14 +14,21 @@
     },
     error::to_result,
     fs::file,
+    io::{
+        IoBackend,
+        IoBase,
+        IoCapable,
+        SysMem,
+        SysMemBackend, //
+    },
     prelude::*,
     ptr::KnownSize,
     sync::aref::ARef,
     transmute::{
         AsBytes,
         FromBytes, //
-    }, //
-    uaccess::UserSliceWriter,
+    },
+    uaccess::UserSliceWriter, //
 };
 use core::{
     ops::{
@@ -1133,6 +1140,132 @@ unsafe impl Send for CoherentHandle {}
 // plain `Copy` values.
 unsafe impl Sync for CoherentHandle {}
 
+/// View type for `Coherent`.
+///
+/// This is same as [`SysMem`] but with additional information that allows handing out a DMA handle.
+pub struct CoherentView<'a, T: ?Sized> {
+    cpu_addr: SysMem<'a, T>,
+    dma_handle: DmaAddress,
+}
+
+impl<T: ?Sized> Copy for CoherentView<'_, T> {}
+impl<T: ?Sized> Clone for CoherentView<'_, T> {
+    #[inline]
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+
+impl<'a, T: ?Sized> CoherentView<'a, T> {
+    /// Erase the DMA handle information and obtain a [`SysMem`] view of the same memory region.
+    #[inline]
+    pub fn as_sys_mem(self) -> SysMem<'a, T> {
+        self.cpu_addr
+    }
+
+    /// Returns a DMA handle which may be given to the device as the DMA address base of the region.
+    #[inline]
+    pub fn dma_handle(self) -> DmaAddress {
+        self.dma_handle
+    }
+
+    /// Returns a reference to the data in the region.
+    ///
+    /// # Safety
+    ///
+    /// * Callers must ensure that the device does not read/write to/from memory while the returned
+    ///   reference is live.
+    /// * Callers must ensure that this call does not race with a write to the same region while
+    ///   the returned reference is live.
+    #[inline]
+    pub unsafe fn as_ref(self) -> &'a T {
+        // SAFETY: pointer is aligned and valid per type invariant. Aliasing rule is satisfied per
+        // safety requirement.
+        unsafe { &*self.cpu_addr.as_ptr() }
+    }
+
+    /// Returns a mutable reference to the data in the region.
+    ///
+    /// # Safety
+    ///
+    /// * Callers must ensure that the device does not read/write to/from memory while the returned
+    ///   reference is live.
+    /// * Callers must ensure that this call does not race with a read or write to the same region
+    ///   while the returned reference is live.
+    #[inline]
+    pub unsafe fn as_mut(self) -> &'a mut T {
+        // SAFETY: pointer is aligned and valid per type invariant. Aliasing rule is satisfied per
+        // safety requirement.
+        unsafe { &mut *self.cpu_addr.as_ptr() }
+    }
+}
+
+/// `IoBackend` implementation for `Coherent`.
+pub struct CoherentBackend;
+
+impl IoBackend for CoherentBackend {
+    type View<'a, T: ?Sized + KnownSize> = CoherentView<'a, T>;
+
+    #[inline]
+    fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> *mut T {
+        SysMemBackend::as_ptr(view.cpu_addr)
+    }
+
+    #[inline]
+    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
+        view: Self::View<'a, T>,
+        ptr: *mut U,
+    ) -> Self::View<'a, U> {
+        let offset = ptr.addr() - view.cpu_addr.as_ptr().addr();
+        // CAST: The offset DMA address can never overflow.
+        let dma_handle = view.dma_handle + offset as DmaAddress;
+        CoherentView {
+            dma_handle,
+            // SAFETY: Per safety requirement.
+            cpu_addr: unsafe { SysMemBackend::project_view(view.cpu_addr, ptr) },
+        }
+    }
+}
+
+impl<T> IoCapable<T> for CoherentBackend
+where
+    SysMemBackend: IoCapable<T>,
+{
+    #[inline]
+    fn io_read<'a>(view: Self::View<'a, T>) -> T {
+        SysMemBackend::io_read(view.cpu_addr)
+    }
+
+    #[inline]
+    fn io_write<'a>(view: Self::View<'a, T>, value: T) {
+        SysMemBackend::io_write(view.cpu_addr, value)
+    }
+}
+
+impl<'a, T: ?Sized + KnownSize> IoBase<'a> for CoherentView<'a, T> {
+    type Backend = CoherentBackend;
+    type Target = T;
+
+    #[inline]
+    fn as_view(self) -> CoherentView<'a, Self::Target> {
+        self
+    }
+}
+
+impl<'a, T: ?Sized + KnownSize> IoBase<'a> for &'a Coherent<T> {
+    type Backend = CoherentBackend;
+    type Target = T;
+
+    #[inline]
+    fn as_view(self) -> CoherentView<'a, Self::Target> {
+        CoherentView {
+            // SAFETY: `cpu_addr` is valid and aligned kernel accessible memory.
+            cpu_addr: unsafe { SysMem::new(self.cpu_addr.as_ptr()) },
+            dma_handle: self.dma_handle,
+        }
+    }
+}
+
 /// Reads a field of an item from an allocated region of structs.
 ///
 /// The syntax is of the form `kernel::dma_read!(dma, proj)` where `dma` is an expression evaluating

-- 
2.54.0

