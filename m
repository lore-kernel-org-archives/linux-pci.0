Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020097.outbound.protection.outlook.com [52.101.196.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA153EF64F;
	Mon,  8 Jun 2026 19:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948770; cv=fail; b=ezHCeoD8utKhoPJuIIEaMBOOd8dtjVB4SHNRcj3UeqR/L5PCduYN7C03v/X/l6fhCVSWkp5ac67WWJORr6WAOOb/EUPMg7RbHfQ04Gc0vP8qMIanF/TPExUs2ym1+Qzko4r8YSo3eZQ8miXA/JLX0Xn83tiyQzfwB5bFXpmEgb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948770; c=relaxed/simple;
	bh=FMyTpgv39QpY3xO13drGr70SK+wnFr/pLzsyeQ+ApzI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=l2kajv0Dh06UG6XfV25A6i/4imbkypl2Esv/zvpyqn55YtK7zh3TAzPK02gWzrOa5o56GQyZMDyWx5PMuJ/7obGY5OOdllufa1e+VZzX7TtlXbpY2EfnWFlU63b1hJMCJRml/hDorFORoVZJYwXMCtH3KaLuPXBh7S1IUC2rhMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=k8yrD0jn; arc=fail smtp.client-ip=52.101.196.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="k8yrD0jn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VL3Py8p3N+N2c6n5r2s3R1LoT6IbZHLPedZXHrdvG0uJCAnn4uNjvQAxWR//tf9xPWtgMSvpMsuy9LNiJhn5e9STKszYkdk9hNTzIcMelTDJu2I5IqNjkdvxzRfkwqxNnHGnEPW5eklXAYq8k9nrf67b1ei5887GeNzW4Mc/u3cwpbtGmV/Si0zCiIQI4PKaisylze34CIE5hHLFsZKP5Z7rxwXjYuD8LXmsn5l7Y1YFngJhLSfBbim4PITwBPjtsLR4Whw8/OGxe1UQOk5eAcEOe47Pccwh/8f+xSqVzBcx1yf4VI4JVz0ERBr69D2oIBvU5QthTW1YT+vm65NoZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+OMAN0Kqzu9SQSmzuZuYXQ0t7v4gw4PfJyG0uT4dgE=;
 b=aj+pOLVidIt35qu0KtY2KTQ1/RqjMPCv9Gk28VosmyvCAHZgqAIVpTecuCU9t7PPh8ODUx0+gSoQAW6G82L8+UAZsk9y0G+HJPFsISIjA+NVEO43RwAgKY6n2cXlo0iNXzNWaUNUa/+7Y3FRRZxkMZmSPmoez4G1wk8CTh8RR0YTxstFSdqZ02bgflTqYqidm/HjHqEaCj+zA/SUaPa1s7dAUbpOOkTuFvAfDU01CZ6koYW9Tin21y8udyCKs029heyYDi0miqLj0jURIot+nrT14zlfY4nkWIorAgx7vCAM+7mrQ+BbqY0k/ZjYkRQrP3S5Stxgf47NuXCLSwTV9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+OMAN0Kqzu9SQSmzuZuYXQ0t7v4gw4PfJyG0uT4dgE=;
 b=k8yrD0jnYLBIMjJoSJxsLdXWh07QrtDm7Y5xUTB9H39slWMILHTlQroFoVi0KdOIp6PZymm5z2ZpdvtLad2+4tE6uyOz96CO9Yu20aKE+o6AQ6Ek7qHAAinfgvVR3S6bJm6vkVr+O1EdYDvfk6bZGd5Fgexllj9bym2jhG6OIQQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7398.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 19:59:12 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 19:59:12 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 08 Jun 2026 20:59:07 +0100
Subject: [PATCH v3 10/19] rust: io: remove `MmioOwned`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-io_projection-v3-10-c5cde13a5ec4@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780948747; l=8855;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=FMyTpgv39QpY3xO13drGr70SK+wnFr/pLzsyeQ+ApzI=;
 b=ugJnNl4GjZ7pynKJmlGu12J8Op2MEH05EjuIG8uxhfi1pU24pHxpt/1c1VYgJByxtlU8eIQlm
 ovQMgwCOrtCDC/Cb5RJDMOuiubQOe+BH/KJDAUNdwjK97bL3y7/lvzt
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
X-MS-Office365-Filtering-Correlation-Id: 0dc34bd8-57bd-4a72-4fa7-08dec59868f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|6133799003|22082099003|18002099003|921020|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	W/92YoR827Mo32o8PM3jGNVwHs4rdQpCa6srq3G8mYW/5XqDWuxUBKBtzq90zzA+PCV5nUUkGMO4wChYE2sRmohi+EaGyjqTscUE1QCf6PNWmRxEmWfM9GVw8DLDnyKJsvK5wxQYWLAK/kIBsgU09RrirHC3hecHnwGH/RLXvCRDN0UASW4XNJ56uWEJ6SIBjn2yaQ6Lvgu6BU44kuD1+yKPgUCiG3cu4OCYjlG8JhAkMgbMRKlyvyhOx8yH/FfykwV6I2QowA36fMoRvsvLBOXLR7zLnooRJkWy3u/tDkBKvqVHorS8uucP2QtRsI5gwGWDmmEaUtoK6FmqXe48UFl0s1LIwXfm4ixFDM/3T+y9dh2IysfjUak1T+ft1ET55hArdb/Ztf2pGNe2loYcCNKeolVBVGSa9qLDAW5X6rZ2tIpAb1EXWOi3Gkq3Iq7xfzPLfa/6K7xck9AuWo9XwNkIywJ54layP3F+g1/tGalhWsKEMovbH0kkzNWqT0PxC6bEFpKeR8CKD5843chyjQkEXI3DcbzMw7m7e9P+HaxguIiLEQneqX42I0Zntv0B+pLUbpMY/yUPLB4YXONN3sTW8+HLqJ7MkJ2yFWU6obZRMIoZzRxpx69mxjKmHYwm0WPEWkG6YGxZhdD9aCK0WeiO1+p6SZ4ahLseGEV5O+AvpT1ypj4WPi2LeeRo3otSuzBZiyvTVTuzdbO32FwYIYvSkJhVlDS05fp0WKzwXjk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(6133799003)(22082099003)(18002099003)(921020)(56012099006)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWNMMFRFV1dTNGg0bUpKTHdSb2dwY1FDZGZWYXlQV0ZQZGoxQ090ZXRSeHlC?=
 =?utf-8?B?ck4rZjJkaWZLODZvMVgyOC9zQmlpZGJpbUxZUlVodk5paGNaV2Q1djJXeEx3?=
 =?utf-8?B?Tm5QWDludXJhck53L3pHam5EdEpxRDkyT2M4Vm8yNTNuN091ZWlsNWMwMVMr?=
 =?utf-8?B?Y1hVeDh4SG0wRjNRZG9Hak9iMG0xS1pweDA0b29sVWVCUFV4S2YxeWlmYmZU?=
 =?utf-8?B?cHFITm1VNUl5cnBUejRhME1vbEpCSThtdkRoNFM2QVljZXpWdXJuVElieTJV?=
 =?utf-8?B?YlVTb1BTRXQ0azF6NEhuOEFUSEpPZ2tjcVB5NTArNThEVHpMYUpncFgyMTkr?=
 =?utf-8?B?YXFqWDhwN1hJc0dKQmRkUml1WXl1WWl2ek9tY2xYUkNYaGMvbm0xWDJrMk9m?=
 =?utf-8?B?N3dCazA0UE5xdW5rVGJQRzRQTlFCS3MrRDJqc3NwazVFaEZIaVZyekVCdEpj?=
 =?utf-8?B?MndRZkJJYVRpUGFWZENOQVZyYWg4Z1ovamVISVpVUkpqS3pDejZTZ0lVL1pl?=
 =?utf-8?B?ZzJ4NUtlUGFNdHA5MmtzN3h6RHlqZEpaOHNOWTF3c3pjeWlMVUV6bTNzaGNh?=
 =?utf-8?B?eGZEWGVLUEVaNkNHY044ZUtLK0tjTHdsQ2NJMHpWUGNjS0ViQSs2NUlQV2pN?=
 =?utf-8?B?VHNQeG12WUhZVUEvOERRR1hYbm5RWVMzY0k0Z1dGZHpFekJuTE1GMldtK2gz?=
 =?utf-8?B?cVJ4T2k1TEtzaWVaSmJiN3VzNlBTbGZJc1k3b0VLcDE1d2NEVkQwZUV1MjNQ?=
 =?utf-8?B?aW51dzJiQzhaQ1daSUtxN1lwcXpBZVpqWTRqeEpma2FpSjluVHZaRGJ1TXE4?=
 =?utf-8?B?R3N5YnpmWUJJSEtaY0lPMXNhOXBRcUJmSko3QStndGJFb0Rab1M5ZVhPS0FQ?=
 =?utf-8?B?cW4yb3hZNjI3aEFLbCtGSmMwOTlBQW5lb3EzL2xPaDQ2MGlhSG5abHk3ZjJr?=
 =?utf-8?B?NEV6TnplNzBMVnhwUTRTeDdFbXVKZHpXdDdSVGVVbHhtdHVkMzYzd3BscUFr?=
 =?utf-8?B?VGV5NXpRZlh5eWp4NEp1R2w5c2t1dy90WmFlYnAwVVNXK3ZvYmUvbElRdHll?=
 =?utf-8?B?akt1cFVzejVybVRtU29Wa1E1N1dVbWNMTmhMOWdBc2pCbEF3Y3RlU1VFbDh4?=
 =?utf-8?B?VDJQY0tuaC9CajZMcWphQlRKQTVMUjhpWjF5dTZyNXRYOEUzQnZVbWRYUHJn?=
 =?utf-8?B?VmFvTGJobkswK3hqWElKRldtcHJjSTJLNXdTV0o2djFrZHkvcDFseWdxZjlJ?=
 =?utf-8?B?ZlA0cjdsSm9zR2VaTndWeHhKemRyWTNIMGF1V1k0clJRbmNvYWkwNklvK0dj?=
 =?utf-8?B?bDl0eXUyVmMrL2tZOWlvOExNMG5wZE44eURvbHhiYUNQYjJEYitYVFJDOU8y?=
 =?utf-8?B?U3JkL2c3b0xjakJMSkJQRGJnMHIxQ1M2NW5lcExOZFpQNFd0eEMvZUxzSTA0?=
 =?utf-8?B?NnQzUlp1SllMcU1FM3dQbjN4MFBTZVdpeHptcXZKMTdvNStUdkVEYldRcGdK?=
 =?utf-8?B?TXcvcW1sSzJVTm5rK1lmRlg5VnFQS2dESWhISTFZSDNkSjZiR0lSUEFlL1hp?=
 =?utf-8?B?QTgwUTd1TXI4bmlxMHFmeDIwOWVFQ1JENll5Rk5Ea1dJS2laSWExeEhqQWFY?=
 =?utf-8?B?SWVDZFowLzdlNmxHNWJwckYxTFFiclVER09HY0pqVDBFOXN2a3lEZ0tLK054?=
 =?utf-8?B?WEg2OU5KYkUyT2Y0djVna3FqYnczaHEvQnNraVhldmhscytMa3N0RVh2b0Nn?=
 =?utf-8?B?aENkZE5CbERsR2ptSmZYcmdwRXRMWEFJdjZlL0xjVmxHTk9sQ3pCWHR3Ti9v?=
 =?utf-8?B?UDR4clNWb3dlOWMwV3FnOHZONVZnZStUeThkeTdZbjgxRWZsSTFFUldoR0lZ?=
 =?utf-8?B?RHhGdjVuSkM1S3BrMTd0TjRRVzVReW9VVGRXaWFIbnNqNmZVWUZHcDJFampi?=
 =?utf-8?B?bHBBaUFCbVVPNUpxQW5kQVFpVTlzTnQva3IwRmhxeENvUEc3Z1hHZlM5RXFC?=
 =?utf-8?B?d0JQYVcrRVl3bW5vSVlxWEZGZDdTZVZaL1FyTGMxQTMxK2Rud1dabjNONzBh?=
 =?utf-8?B?M1dGRlJyY2pQQTU3amtHNEc4UjhPTFprekxKV2RrbnBrODNja0wzcUNFMmRH?=
 =?utf-8?B?WlAyMXNJQXBZMzVnQmlEUTN1V3lUdklub2NIZERmVEEyVWVHbVVVZnZ3VEJE?=
 =?utf-8?B?UHNZSlVqbGpxcGI0S0JKRlBWbGQzOFRSSnlMR2ZPN3Q0Mkg1azNMT3M0eGl4?=
 =?utf-8?B?cWJ5aE5LMWFIK1AxN0tUZkYvR1EzT0Y1MzRjYXcrY0E2SUU4K3BZUzRja0U0?=
 =?utf-8?B?bFZxcHJWdFpmcnZOSkdTRkI3SUFSNjhVeGpDY0FLMk1pOUpSa29EQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc34bd8-57bd-4a72-4fa7-08dec59868f8
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 19:59:12.0684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqO4xQEuuEhAJVuT1cfoJndyVmrz8XhF9ZuZzRdzATChWPdxlQAfT47hIQGWKpAAt7Oagb8prZsG2eJimMXjrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7398

`Io` trait is now very easy to implement. Thus, implement it on `Bar` and
`IoMem` directly and remove the `MmioOwned` struct.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/devres.rs |  12 +++---
 rust/kernel/io.rs     | 103 +-------------------------------------------------
 rust/kernel/io/mem.rs |  26 +++++++------
 rust/kernel/pci/io.rs |  16 ++++----
 4 files changed, 32 insertions(+), 125 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index aed0c994fd30..3545ffc5345d 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -68,8 +68,9 @@ struct Inner<T> {
 ///     devres::Devres,
 ///     io::{
 ///         Io,
-///         MmioOwned,
+///         Mmio,
 ///         MmioRaw,
+///         MmioBackend,
 ///         PhysAddr,
 ///         Region, //
 ///     },
@@ -104,12 +105,13 @@ struct Inner<T> {
 ///     }
 /// }
 ///
-/// impl<const SIZE: usize> Deref for IoMem<SIZE> {
-///    type Target = MmioOwned<SIZE>;
+/// impl<'a, const SIZE: usize> Io<'a> for &'a IoMem<SIZE> {
+///    type Backend = MmioBackend;
+///    type Target = Region<SIZE>;
 ///
-///    fn deref(&self) -> &Self::Target {
+///    fn as_view(self) -> Mmio<'a, Region<SIZE>> {
 ///         // SAFETY: The memory range stored in `self` has been properly mapped in `Self::new`.
-///         unsafe { MmioOwned::from_raw(&self.0) }
+///         unsafe { Mmio::from_raw(self.0) }
 ///    }
 /// }
 /// # fn no_run(dev: &Device<Bound>) -> Result<(), Error> {
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index d09d9864858d..8b3a64188b48 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -100,8 +100,8 @@ fn size(p: *const Self) -> usize {
 /// the represented MMIO region does exist or is properly mapped.
 ///
 /// Instead, the bus specific MMIO implementation must convert this raw representation into an
-/// `MmioOwned` instance providing the actual memory accessors. Only by the conversion into an
-/// `MmioOwned` structure any guarantees are given.
+/// `Mmio` instance providing the actual memory accessors. Only by the conversion into an `Mmio`
+/// structure any guarantees are given.
 pub struct MmioRaw<T: ?Sized> {
     /// Pointer is in I/O address space.
     ///
@@ -158,80 +158,6 @@ pub fn size(&self) -> usize {
     }
 }
 
-/// IO-mapped memory region.
-///
-/// The creator (usually a subsystem / bus such as PCI) is responsible for creating the
-/// mapping, performing an additional region request etc.
-///
-/// # Invariant
-///
-/// `addr` is the start and `maxsize` the length of valid I/O mapped memory region of size
-/// `maxsize`.
-///
-/// # Examples
-///
-/// ```no_run
-/// use kernel::{
-///     bindings,
-///     ffi::c_void,
-///     io::{
-///         Io,
-///         MmioOwned,
-///         MmioRaw,
-///         PhysAddr,
-///         Region,
-///     },
-/// };
-/// use core::ops::Deref;
-///
-/// // See also `pci::Bar` for a real example.
-/// struct IoMem<const SIZE: usize>(MmioRaw<Region<SIZE>>);
-///
-/// impl<const SIZE: usize> IoMem<SIZE> {
-///     /// # Safety
-///     ///
-///     /// [`paddr`, `paddr` + `SIZE`) must be a valid MMIO region that is mappable into the CPUs
-///     /// virtual address space.
-///     unsafe fn new(paddr: usize) -> Result<Self>{
-///         // SAFETY: By the safety requirements of this function [`paddr`, `paddr` + `SIZE`) is
-///         // valid for `ioremap`.
-///         let addr = unsafe { bindings::ioremap(paddr as PhysAddr, SIZE) };
-///         if addr.is_null() {
-///             return Err(ENOMEM);
-///         }
-///
-///         Ok(IoMem(MmioRaw::new_region(addr as usize, SIZE)?))
-///     }
-/// }
-///
-/// impl<const SIZE: usize> Drop for IoMem<SIZE> {
-///     fn drop(&mut self) {
-///         // SAFETY: `self.0.addr()` is guaranteed to be properly mapped by `Self::new`.
-///         unsafe { bindings::iounmap(self.0.addr() as *mut c_void); };
-///     }
-/// }
-///
-/// impl<const SIZE: usize> Deref for IoMem<SIZE> {
-///    type Target = MmioOwned<SIZE>;
-///
-///    fn deref(&self) -> &Self::Target {
-///         // SAFETY: The memory range stored in `self` has been properly mapped in `Self::new`.
-///         unsafe { MmioOwned::from_raw(&self.0) }
-///    }
-/// }
-///
-///# fn no_run() -> Result<(), Error> {
-/// // SAFETY: Invalid usage for example purposes.
-/// let iomem = unsafe { IoMem::<{ core::mem::size_of::<u32>() }>::new(0xBAAAAAAD)? };
-/// iomem.write32(0x42, 0x0);
-/// assert!(iomem.try_write32(0x42, 0x0).is_ok());
-/// assert!(iomem.try_write32(0x42, 0x4).is_err());
-/// # Ok(())
-/// # }
-/// ```
-#[repr(transparent)]
-pub struct MmioOwned<const SIZE: usize = 0>(MmioRaw<Region<SIZE>>);
-
 /// Checks whether an access of type `U` at the given `base` and the given `offset`
 /// is valid within this region.
 ///
@@ -947,31 +873,6 @@ fn io_write(view: <$backend as IoBackend>::View<'_, $ty>, value: $ty) {
 #[cfg(CONFIG_64BIT)]
 impl_mmio_io_capable!(MmioBackend, u64, readq, writeq);
 
-impl<'a, const SIZE: usize> Io<'a> for &'a MmioOwned<SIZE> {
-    type Backend = MmioBackend;
-    type Target = Region<SIZE>;
-
-    #[inline]
-    fn as_view(self) -> Mmio<'a, Self::Target> {
-        // SAFETY: `Mmio` has same invariant as `MmioOwned`
-        unsafe { Mmio::from_raw(self.0) }
-    }
-}
-
-impl<const SIZE: usize> MmioOwned<SIZE> {
-    /// Converts an `MmioRaw` into an `MmioOwned` instance, providing the accessors to the MMIO
-    /// mapping.
-    ///
-    /// # Safety
-    ///
-    /// Callers must ensure that `addr` is the start of a valid I/O mapped memory region of size
-    /// `maxsize`.
-    pub unsafe fn from_raw(raw: &MmioRaw<Region<SIZE>>) -> &Self {
-        // SAFETY: `MmioOwned` is a transparent wrapper around `MmioRaw`.
-        unsafe { &*core::ptr::from_ref(raw).cast() }
-    }
-}
-
 /// [`Mmio`] but using relaxed accessors.
 ///
 /// This type provides an implementation of [`Io`] that uses relaxed I/O MMIO operands instead of
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index 8f6c257c5b8e..d9b3189d09b4 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -2,8 +2,6 @@
 
 //! Generic memory-mapped IO.
 
-use core::ops::Deref;
-
 use crate::{
     device::{
         Bound,
@@ -16,7 +14,9 @@
             Region,
             Resource, //
         },
-        MmioOwned,
+        Io,
+        Mmio,
+        MmioBackend,
         MmioRaw, //
     },
     prelude::*,
@@ -210,11 +210,13 @@ pub fn into_devres(self) -> Result<Devres<ExclusiveIoMem<'static, SIZE>>> {
     }
 }
 
-impl<const SIZE: usize> Deref for ExclusiveIoMem<'_, SIZE> {
-    type Target = MmioOwned<SIZE>;
+impl<'a, const SIZE: usize> Io<'a> for &'a ExclusiveIoMem<'_, SIZE> {
+    type Backend = MmioBackend;
+    type Target = super::Region<SIZE>;
 
-    fn deref(&self) -> &Self::Target {
-        &self.iomem
+    #[inline]
+    fn as_view(self) -> Mmio<'a, Self::Target> {
+        self.iomem.as_view()
     }
 }
 
@@ -290,11 +292,13 @@ fn drop(&mut self) {
     }
 }
 
-impl<const SIZE: usize> Deref for IoMem<'_, SIZE> {
-    type Target = MmioOwned<SIZE>;
+impl<'a, const SIZE: usize> Io<'a> for &'a IoMem<'_, SIZE> {
+    type Backend = MmioBackend;
+    type Target = super::Region<SIZE>;
 
-    fn deref(&self) -> &Self::Target {
+    #[inline]
+    fn as_view(self) -> Mmio<'a, Self::Target> {
         // SAFETY: Safe as by the invariant of `IoMem`.
-        unsafe { MmioOwned::from_raw(&self.io) }
+        unsafe { Mmio::from_raw(self.io) }
     }
 }
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 9286b2e419f9..cd921cbba164 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -11,16 +11,14 @@
         Io,
         IoBackend,
         IoCapable,
-        MmioOwned,
+        Mmio,
+        MmioBackend,
         MmioRaw,
         Region, //
     },
     prelude::*,
     ptr::KnownSize, //
 };
-use core::{
-    ops::Deref, //
-};
 
 /// Represents the size of a PCI configuration space.
 ///
@@ -263,12 +261,14 @@ fn drop(&mut self) {
     }
 }
 
-impl<const SIZE: usize> Deref for Bar<'_, SIZE> {
-    type Target = MmioOwned<SIZE>;
+impl<'a, const SIZE: usize> Io<'a> for &'a Bar<'_, SIZE> {
+    type Backend = MmioBackend;
+    type Target = crate::io::Region<SIZE>;
 
-    fn deref(&self) -> &Self::Target {
+    #[inline]
+    fn as_view(self) -> Mmio<'a, Self::Target> {
         // SAFETY: By the type invariant of `Self`, the MMIO range in `self.io` is properly mapped.
-        unsafe { MmioOwned::from_raw(&self.io) }
+        unsafe { Mmio::from_raw(self.io) }
     }
 }
 

-- 
2.54.0

