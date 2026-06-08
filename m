Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020097.outbound.protection.outlook.com [52.101.196.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5693F0AA2;
	Mon,  8 Jun 2026 19:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948778; cv=fail; b=exCXz4Uw0So+IQZufdawzT+RZo/wqYTYB0+1bKwf1UrrCAGLniWxJzLPL8XB0sokGTt2U5yN+jWh5uLj0uDzylX8+05NGKnhUFry5V247XOF6/qMqHKXxNtDJy1He7k0XV9b6I8HGD68RJmwnmxQ7iqsVlghXdHjPlgUljPoHwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948778; c=relaxed/simple;
	bh=U4sgtg+PsZydA75oyiPMnCQI7oPllCK0F9P8o45F4bU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CnpaKox9N+ZpZLp3e2ihM2oCOc2vp5a/uZEDniIsFjInChDjgbd51Ap+0iKfqIQQKXcx6hBf/ugr6cOOE0ceW9Er27Gat5hBvHaiwNqMrqxOqpnRn1XWuZlPdL9PtdkrjBY3/iuipc3EmLBMx48tUUebYc8nklCiZU/7sEDewZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=pJ15MoaS; arc=fail smtp.client-ip=52.101.196.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="pJ15MoaS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B05WzdrPnftNMMblVFWP2ZpfsQytPFqSmm6cabY1a6PQFEG514vmInfTfAm3HHIXiTF+zbu+EUS0kxrXQBwhHLn07M0CocdEfU67ZWw2r1hvh/m81x2RuNqrByPvRSuDzleoEk/qe3YjyburAyljRet4/XqU0ny2NLdgQgDyuDMwaknkqu0bOqX8Rp62ZijS3IG7DffFez2rVjQtjV5Ogmjyz8/UeWXPAivYKY9XRzmx5fLUERnW5syiAm4yunVkW6V927ZxJahpoHGzDK/1dl3pDxON+3ZrGNZ3w2Pc5qd+lRIrNbDTxjGcoapbZLiNBFdnQctXYSp4G2g4arX/wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6s55GE3t+EaTIWGewrRvkHNiIicUa9eIXKL7E2bCF8=;
 b=bka7w/5w+TRXjZBDi28bW5Vv2QO7GbBsfKVV5Jahxjrtt/IksYQaI6ZIIjOdYw4Tskz/ro0134ptM2YyIcaOKWGd9AaJCslO5euTZPVWRUoQbvR5Cn1YEM4zf4lZkR+tebJ06kSY0/gMC/nEng9XePD2XMKcgnoRsHgJrqJlktsHdk66/2qcjVLMwKRXoF3YVAJXuCj1wjLcEEXE9x7zISAsY7Jf5V2gDDHgBqXVRSJp3CkqzlUPsx/G65uFn49UpxL32S4o2Dh5Cx2grY6Rg9MWw7eQO21RtGnoZDZV/Ith+ZCxsvgESNB8T02fYIfuhQ4Fl+t7Rhz0GWa9BbHTtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6s55GE3t+EaTIWGewrRvkHNiIicUa9eIXKL7E2bCF8=;
 b=pJ15MoaS+CuY4ivroL7bt39o+qNebBC+PizjnV46Es87UlycTY5sSnS43LkHCfcPx1GtLeIvyDS0v6XukdvjnAIQkmeg/2loUhffpHjYJ9gNwuPJG7dbmhO2EHvERYWLKhbqS9uHQ5E89MVVyc1Df3E1goWbaDcPEw7ErG4cokc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7398.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 19:59:14 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 19:59:14 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 08 Jun 2026 20:59:14 +0100
Subject: [PATCH v3 17/19] rust: dma: drop `dma_read!` and `dma_write!` API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-io_projection-v3-17-c5cde13a5ec4@garyguo.net>
References: <20260608-io_projection-v3-0-c5cde13a5ec4@garyguo.net>
In-Reply-To: <20260608-io_projection-v3-0-c5cde13a5ec4@garyguo.net>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
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
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780948747; l=8864;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=U4sgtg+PsZydA75oyiPMnCQI7oPllCK0F9P8o45F4bU=;
 b=mFuP8PQ2/l5oFJKw/nExr6QOfHGRroas+dN2Pz1rGYirQdOwehSLTajFut8g3GSf6f9dhEWdB
 vndkhp2ppF0AFbuK6jNACZFBBNPZ9DChDPgGs4V6cqM0c9Sui0hBgL1
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0344.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO8P265MB7398:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb4bd58-b4b3-407f-4ede-08dec5986aa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|6133799003|22082099003|18002099003|921020|3023799007|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	tRbjzXP68waXnVxUmBSPTFyTQhOdlKJ1yH2f2Y4fXbCo4uo8KaS+xl4gPYwa6Jgx4IjNOGPWBWzQiH8XaLzfyi5LE7y/TeTfS4F9Ah2s90UNO1slcC+HjvLKtU5PukhvqezM+SJ6hgUP9pByxWlLHYtPhAUgLteQlamqxTW/SfRbKiQU6s9iEB6h5vheF69MGxQ1LdkVjsdtPWRy2oAne5UthLUPxiN5uOVB9FxVvQOE6HFk3jh56jaST7cvyVLHjbLDVQHMdmAY5Y39llmRMWQav1sHBd69Sk68JgmY23cvuHBjSnA2AdZoLBmdMQWA7vhhYR1P/9LfZVMQxd5ngb4GBhXh7UJoumP62sV0Yigv+NPjp5EAhmCOZvj5gF29R/U/61WxXZ6Zv0aHurQsNyWVgiTCGRKqLPkQXZFhEFLA4ymcS+vc9UYCU8upCybjNFaPIcMCwnfMY+iZxCkPHmk3KLsW6+aAzCGubqZZCJL+VX7Ou0cTFFMvpnH5RT/8HPQGVNRHAV90i2h0X4beW3zxuC09XM6ojurRHm3PlBUOF6wj/m5mmQee3jEbkJ5/GDHiUTUrRyp1K0+6Bv4QWuyzimvaJ7+GxBzF/2krEsCEqOvUxU9xDxRTHokAyT7T6lK5NM41SxluSOVsdnYywPKkXx1V0eX31fiMeXwPI3LJE2xSdMECMJFJExyvVDE7WngGSicHYTEG1O4WaPqrpBbRm3rfltAh9jWb5iAzGhM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(6133799003)(22082099003)(18002099003)(921020)(3023799007)(56012099006)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0J6bjB3amRzRXJzbVNvYktqMmhOWmpTOGYxMEZWOStwYlBvWlQ2ZVQrVlNj?=
 =?utf-8?B?UjVsQ0JGWnFqZnIzYVRqMXVoMWltaHl3VHllQ3VkQnRTTnVmdy9VdEtYRWlr?=
 =?utf-8?B?WjRnWWdtc2xoVVNzUWJlL043ZDdSWjAxY0NnUHZmWXIxZ1grZHRUVkRmaWF2?=
 =?utf-8?B?NTRSS1VTK2tROVltYjJtNHpPS2ozaW1XemxmTnRKdWtJRFgreERkNjNaVytv?=
 =?utf-8?B?bWU4ZzhVeXY3N1ZqVThDS2dCYm43b0JwYjRoVDloWEw0SW1wZ1hraDJuRzZn?=
 =?utf-8?B?S3psUGdWUGxxaVJQd0FOcjBIMjBURGtneXhSem12OFBGNFQyVU0vY0VaYnFP?=
 =?utf-8?B?WlBHSWt0bEh5WFN0Z1QwbmxQNUpINzJhREFKYzZrRkppanptaHNsYS9tUGNN?=
 =?utf-8?B?cEdKMUlINUlGdFAzV25kVmZ5alBkNzg5MkNqL1kzenFNY2pTTWdtN3dRcEdi?=
 =?utf-8?B?SjNFUUNwbXJSbFYwelNBTDltQ3A0NDRKYlFISHBWbm9sN0VFZVFTZlI5cVBH?=
 =?utf-8?B?RGw5dkhPSUlmUzB3QnhjeSttMTB0Q3MrT016OVhleXRqUEx4dS9DRmxQYmxy?=
 =?utf-8?B?VkhlL29BUEdhQ2ZlSUZRMHBSa3JEWW0xUTVJVFVkU3J4OFNyNFdFUUFMUzhj?=
 =?utf-8?B?cFZrUm9KbVMyVlo4SGptYURkYVNxUENOV3l2djNoN090L0RtK2hpcCtiTitL?=
 =?utf-8?B?ODk2cStRNE5CN1owbkVVdkljS3FoN2hRWUJnaGpkNFlqYzg5ZGtDMWhSeldh?=
 =?utf-8?B?d2xJR1BLZDN2d0l6SXQ0aTJJMFV3bUllTVN3ZjR4cmJZdDdmQ3ZtNit3eUpP?=
 =?utf-8?B?NlRlbVNGd2tLd2NBYWtHYlhnSzF3TXc0RzVZa2hmdXd4ZURUU1A2dnk0U0VT?=
 =?utf-8?B?US8ySVJySnBkTXErU1V0aEwybnRwcjJPc2lHZWg5OG5qcitreHNkUGZ5UC9y?=
 =?utf-8?B?QThyQ3RjbTlZekErN2tjNFYvYlc0WU41eFFLNjE1bG1ubHM1VnNGQVhwNzht?=
 =?utf-8?B?eU1EV1UwL1VTZFJUTWJqWWV4ZUM3OElTa0lWc29QVGxnUk1YVmVDb0RBYk0w?=
 =?utf-8?B?WkVLVUNUUitvdnNEbkZ5Wm1JRkY4NE5YZGdOdHhYVVlvRWI1NVhKMlhjMHp4?=
 =?utf-8?B?c3lERi9iekJFWk9HZDBJKzFFTnI0eTUwRE1hdHlPWHdvWUxCMkdFNVlFUTll?=
 =?utf-8?B?azgvbVBwQzVGcUlXRkorZWJZZTcwMzFSYkJjWkFxaGx3VFd2cVZHdnIzQkVO?=
 =?utf-8?B?anlZNDVRUlQzakFJa1ZzbjQyUndGMzdsZndMbk11S1BDTTl1RkJ3eXphbksy?=
 =?utf-8?B?WlNwNkExM09NNjRCUFNVUGpMNHQzWGFJbDltNTg2d3NwejBOTGI1aitRWjZW?=
 =?utf-8?B?YUJDNjBnNkZGdEtUekdZQXJMTFRMVmVOWjU5N1Z0cVNtaXErUGFMT011VEVF?=
 =?utf-8?B?ZFNRdHVmSno3WUV4NXpIbm95aWxrbjhHaGZ1bmlVQVlYM3BBRWNORWE1V3Vu?=
 =?utf-8?B?VEVXYlFpbDNNS1B4NE82YzBVald3amloaGFmN3VmVEZOaENFNlJhSWJFUEFx?=
 =?utf-8?B?ZkRCRkhCTlF4bzJPaHpUaThMY04wK3ZBMm1ndG5ESmUyWFFhbDkyeFRCTjdP?=
 =?utf-8?B?ZHA0Z2RpTzh0TndEQWM5ZUdlay8yazF2VzErNlVEKytrRTFUbjIzdTI3WktX?=
 =?utf-8?B?d2tTdTNERGxVRDRDN2FQVXRNb2tENDNDT1dGLzMzYld0MytnM0huMHB0VjRW?=
 =?utf-8?B?UUVhOUpiUDdER1dvN0E1NDdiNWxiUFlGcUloQ3lCT1BEd3hoN29oWnZkWjR0?=
 =?utf-8?B?YTZQVzhCbHVEL29LcnpjZlRoUW5jOFJaT2dUVUhVQmFrSUJhQk5LNUw5WE5w?=
 =?utf-8?B?OGZDaEFXdjF6dmlhby9NVGM0dWdjeVdpOTNmQnpETnhoeTkvczRuRXJwS1d6?=
 =?utf-8?B?RVFsNFhNTG5vUis5elhyMlluTm9UR3F4Qmt6OTZNVmNtR1BoQjhVZUo2aW9x?=
 =?utf-8?B?eTNOOXRZcHRteHhTMlU0T3dCdlVMa1FlT3BHVXRBa0hmTkJrQkJRak82cEc1?=
 =?utf-8?B?cjIvQ3Q3UStzZS9rQU51QXF1TmlhTEN2SE40K1FHVUR1akZ0dnkwTWtyU2h4?=
 =?utf-8?B?S3QzVUhzS3RheWtBbnBHc2JuSmU5L3dmS1hZaEM4SzVFOXg1OTRTcFdLN0do?=
 =?utf-8?B?a3dhdFJOcW9IMko3MlpOYXR5L3plRWFXNzZ0NjlMaEZpci9lejBaY21nZE5B?=
 =?utf-8?B?NmxTQU9wM0RicnpjemJ1Mm9qZ0NvYlg1QXB5eHJJQ0IwMlpieHk1QktvL1BZ?=
 =?utf-8?B?WGF1MTRuU3RyL2kzQVBqUFhGL1lUTGVaZVliVXJyeU5aYlM5UUllQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb4bd58-b4b3-407f-4ede-08dec5986aa0
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 19:59:14.8460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JS1iwd/qHimgLXQQdyu9xG6Jy4lo66Mp2B17SqTvV1HMVDaqnA8qlvq5vrM6SThf7985gE0yaQtZBvpwZr2gHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7398

The primitive read/write use case is covered by the `io_read!` and
`io_write!` macro. The non-primitive use case was finicky; they should
either be achieved using `CoherentBox` or `as_ref()/as_mut()` to assert the
lack of concurrent access, or should be using memcpy-like APIs to express
the non-atomic and tearable nature.

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/dma.rs       | 128 -----------------------------------------------
 samples/rust/rust_dma.rs |  13 ++---
 2 files changed, 7 insertions(+), 134 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 970a667b9be2..68015a2ab43b 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -661,52 +661,6 @@ pub unsafe fn as_mut(&self) -> &mut T {
         // SAFETY: per safety requirement.
         unsafe { &mut *self.as_mut_ptr() }
     }
-
-    /// Reads the value of `field` and ensures that its type is [`FromBytes`].
-    ///
-    /// # Safety
-    ///
-    /// This must be called from the [`dma_read`] macro which ensures that the `field` pointer is
-    /// validated beforehand.
-    ///
-    /// Public but hidden since it should only be used from [`dma_read`] macro.
-    #[doc(hidden)]
-    pub unsafe fn field_read<F: FromBytes>(&self, field: *const F) -> F {
-        // SAFETY:
-        // - By the safety requirements field is valid.
-        // - Using read_volatile() here is not sound as per the usual rules, the usage here is
-        // a special exception with the following notes in place. When dealing with a potential
-        // race from a hardware or code outside kernel (e.g. user-space program), we need that
-        // read on a valid memory is not UB. Currently read_volatile() is used for this, and the
-        // rationale behind is that it should generate the same code as READ_ONCE() which the
-        // kernel already relies on to avoid UB on data races. Note that the usage of
-        // read_volatile() is limited to this particular case, it cannot be used to prevent
-        // the UB caused by racing between two kernel functions nor do they provide atomicity.
-        unsafe { field.read_volatile() }
-    }
-
-    /// Writes a value to `field` and ensures that its type is [`AsBytes`].
-    ///
-    /// # Safety
-    ///
-    /// This must be called from the [`dma_write`] macro which ensures that the `field` pointer is
-    /// validated beforehand.
-    ///
-    /// Public but hidden since it should only be used from [`dma_write`] macro.
-    #[doc(hidden)]
-    pub unsafe fn field_write<F: AsBytes>(&self, field: *mut F, val: F) {
-        // SAFETY:
-        // - By the safety requirements field is valid.
-        // - Using write_volatile() here is not sound as per the usual rules, the usage here is
-        // a special exception with the following notes in place. When dealing with a potential
-        // race from a hardware or code outside kernel (e.g. user-space program), we need that
-        // write on a valid memory is not UB. Currently write_volatile() is used for this, and the
-        // rationale behind is that it should generate the same code as WRITE_ONCE() which the
-        // kernel already relies on to avoid UB on data races. Note that the usage of
-        // write_volatile() is limited to this particular case, it cannot be used to prevent
-        // the UB caused by racing between two kernel functions nor do they provide atomicity.
-        unsafe { field.write_volatile(val) }
-    }
 }
 
 impl<T: AsBytes + FromBytes> Coherent<T> {
@@ -1265,85 +1219,3 @@ fn as_view(self) -> CoherentView<'a, Self::Target> {
         }
     }
 }
-
-/// Reads a field of an item from an allocated region of structs.
-///
-/// The syntax is of the form `kernel::dma_read!(dma, proj)` where `dma` is an expression evaluating
-/// to a [`Coherent`] and `proj` is a [projection specification](kernel::ptr::project!).
-///
-/// # Examples
-///
-/// ```
-/// use kernel::device::Device;
-/// use kernel::dma::{attrs::*, Coherent};
-///
-/// struct MyStruct { field: u32, }
-///
-/// // SAFETY: All bit patterns are acceptable values for `MyStruct`.
-/// unsafe impl kernel::transmute::FromBytes for MyStruct{};
-/// // SAFETY: Instances of `MyStruct` have no uninitialized portions.
-/// unsafe impl kernel::transmute::AsBytes for MyStruct{};
-///
-/// # fn test(alloc: &kernel::dma::Coherent<[MyStruct]>) -> Result {
-/// let whole = kernel::dma_read!(alloc, [try: 2]);
-/// let field = kernel::dma_read!(alloc, [panic: 1].field);
-/// # Ok::<(), Error>(()) }
-/// ```
-#[macro_export]
-macro_rules! dma_read {
-    ($dma:expr, $($proj:tt)*) => {{
-        let dma = &$dma;
-        let ptr = $crate::ptr::project!(
-            $crate::dma::Coherent::as_ptr(dma), $($proj)*
-        );
-        // SAFETY: The pointer created by the projection is within the DMA region.
-        unsafe { $crate::dma::Coherent::field_read(dma, ptr) }
-    }};
-}
-
-/// Writes to a field of an item from an allocated region of structs.
-///
-/// The syntax is of the form `kernel::dma_write!(dma, proj, val)` where `dma` is an expression
-/// evaluating to a [`Coherent`], `proj` is a
-/// [projection specification](kernel::ptr::project!), and `val` is the value to be written to the
-/// projected location.
-///
-/// # Examples
-///
-/// ```
-/// use kernel::device::Device;
-/// use kernel::dma::{attrs::*, Coherent};
-///
-/// struct MyStruct { member: u32, }
-///
-/// // SAFETY: All bit patterns are acceptable values for `MyStruct`.
-/// unsafe impl kernel::transmute::FromBytes for MyStruct{};
-/// // SAFETY: Instances of `MyStruct` have no uninitialized portions.
-/// unsafe impl kernel::transmute::AsBytes for MyStruct{};
-///
-/// # fn test(alloc: &kernel::dma::Coherent<[MyStruct]>) -> Result {
-/// kernel::dma_write!(alloc, [try: 2].member, 0xf);
-/// kernel::dma_write!(alloc, [panic: 1], MyStruct { member: 0xf });
-/// # Ok::<(), Error>(()) }
-/// ```
-#[macro_export]
-macro_rules! dma_write {
-    (@parse [$dma:expr] [$($proj:tt)*] [, $val:expr]) => {{
-        let dma = &$dma;
-        let ptr = $crate::ptr::project!(
-            mut $crate::dma::Coherent::as_mut_ptr(dma), $($proj)*
-        );
-        let val = $val;
-        // SAFETY: The pointer created by the projection is within the DMA region.
-        unsafe { $crate::dma::Coherent::field_write(dma, ptr, val) }
-    }};
-    (@parse [$dma:expr] [$($proj:tt)*] [.$field:tt $($rest:tt)*]) => {
-        $crate::dma_write!(@parse [$dma] [$($proj)* .$field] [$($rest)*])
-    };
-    (@parse [$dma:expr] [$($proj:tt)*] [[$flavor:ident: $index:expr] $($rest:tt)*]) => {
-        $crate::dma_write!(@parse [$dma] [$($proj)* [$flavor: $index]] [$($rest)*])
-    };
-    ($dma:expr, $($rest:tt)*) => {
-        $crate::dma_write!(@parse [$dma] [] [$($rest)*])
-    };
-}
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 5046b4628d0e..6727c441658a 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -12,6 +12,7 @@
         Device,
         DmaMask, //
     },
+    io::io_read,
     page, pci,
     prelude::*,
     scatterlist::{Owned, SGTable},
@@ -73,11 +74,11 @@ fn probe<'bound>(
             // SAFETY: There are no concurrent calls to DMA allocation and mapping primitives.
             unsafe { pdev.dma_set_mask_and_coherent(mask)? };
 
-            let ca: Coherent<[MyStruct]> =
-                Coherent::zeroed_slice(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
+            let mut ca: CoherentBox<[MyStruct]> =
+                CoherentBox::zeroed_slice(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
 
             for (i, value) in TEST_VALUES.into_iter().enumerate() {
-                kernel::dma_write!(ca, [try: i], MyStruct::new(value.0, value.1));
+                ca.init_at(i, MyStruct::new(value.0, value.1))?;
             }
 
             let size = 4 * page::PAGE_SIZE;
@@ -87,7 +88,7 @@ fn probe<'bound>(
 
             Ok(try_pin_init!(Self {
                 pdev: pdev.into(),
-                ca,
+                ca: ca.into(),
                 sgt <- sgt,
             }))
         })
@@ -97,8 +98,8 @@ fn probe<'bound>(
 impl DmaSampleDriver {
     fn check_dma(&self) {
         for (i, value) in TEST_VALUES.into_iter().enumerate() {
-            let val0 = kernel::dma_read!(self.ca, [panic: i].h);
-            let val1 = kernel::dma_read!(self.ca, [panic: i].b);
+            let val0 = io_read!(self.ca, [panic: i].h);
+            let val1 = io_read!(self.ca, [panic: i].b);
 
             assert_eq!(val0, value.0);
             assert_eq!(val1, value.1);

-- 
2.54.0

