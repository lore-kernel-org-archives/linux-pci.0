Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020080.outbound.protection.outlook.com [52.101.196.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54523EE1EA;
	Mon,  8 Jun 2026 19:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948769; cv=fail; b=r0+RYNSf+0Kao2G8Q4nwINenlTDVtUTyWMMej1Ow9WY6gQM8EFYMjIAW111cBNN0YnA8kmcR9CEdRvUwjx3Kzy0VeVIgF7icjlaKHTPWZixojyQhQ8v+I2hdA35NU/y7/NLk4OuDWPuxFochRO44nCftogK8E6vFp9t6q2Riqu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948769; c=relaxed/simple;
	bh=hARIKO1AiUcO0j1zhfrY2ipk+iqXCaOtanAULqEAdIo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=AIhfATARuKIxgrr2RXxBKrIblWNxYJmltevlRHBi+JnZVi+TXECuMFcpGWjJW/1ASSmNYyKgTn3IzkDD8cnIX3YWW37u6SecyiRHHjsr8sneQMnNHjWO67kObG9eEDgg45INfRpjRm/BAQmWfd8JkpI/q+ONnOz1L/TICMgCc3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=jf3Xp6gI; arc=fail smtp.client-ip=52.101.196.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="jf3Xp6gI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQhRKivhAUd7ddTE09QfS+BJvMOS3n3Kv7fjM5Q5sfrShorE0fv/e6qFFPrmkgCob13d1v2uokpzvk9JGBeAO1U6if/OiUZv2oRXZ/BM5x9wnrPZ5w9rC+etF+GcjX4KawenCJUxTFuqqojhNFlye4JFcAWo681E16fXtuCzyWia+XgBq+cZqfOO0zTxZ0EuvqN9B5BZFXuoql1Ttb2BvG2FrIf1mwlAbwM2xysBBcfJUH4PX8Pb5n+L79uj9atxscv2zG16hSokwi44JZtTI4Q/sTinI/lWdlLIKbiG9ef1E0yTkVs5y/zMnZGOjGhucmMrp9McbVGLLCHPKLy9yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xdy54JqDYQWz55PhzLjgqZ55JFsFWnLcTa5MtnbU6pY=;
 b=q2XEpbqWd+TIuTTF+3aadL/xsGGeUluKymr1+cRWDgsAzrJpj21UjgRRU6ZfEl04KbHkouM9Gkk0UJMOkT5iFJe2iAvGTVBLinWBRpVBbsTqA654NMXQ0femadmlwUnLquVeZgGBkDMWZ+aTsNjK2XzkxKA1KmLxwt9/E+C7cCxIEZk4T8PLtqpW63at2iRP2Cjeh9RJRZ8XJzg8qsU1iHWiZzAhDffJxo4fJyry/5HC0aRY8Sx4uyIpwGsfunQsYg+oSYeNLTO+j0VupfdzbQyQSeToit7lId2mfr/ZLLa+p37RLYayfoJ3zDbdxwanA0KIhTqoyeO9Ce/Tw3WCIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xdy54JqDYQWz55PhzLjgqZ55JFsFWnLcTa5MtnbU6pY=;
 b=jf3Xp6gINQbstspxFN6S2hjtyyH18K1RdrZ9EG+/lyxXkGFOYpElSxD8lCZLcvhhYNMH3Kd0q30P2yJUYCgRHCVGtuiYWUChymDI3z2ISqo2bEtItbpgw4FKyhmwihPWR53Jbofoo54I17cV8Fwb4bBjzmZvCPwl0bz1spkCKLU=
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
Date: Mon, 08 Jun 2026 20:59:08 +0100
Subject: [PATCH v3 11/19] rust: io: move `Io` methods to extension trait
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-io_projection-v3-11-c5cde13a5ec4@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780948747; l=6959;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=hARIKO1AiUcO0j1zhfrY2ipk+iqXCaOtanAULqEAdIo=;
 b=OcPp8gUvCf9PF7NlPCry5f6mmsS507ZX0+ylQJbTn2JErCZVCZ8oeWZjfe/TmiRmHan2+uLdO
 Se/chvYAIsQB4g2yGVtCKorZ5HIXwmgR6WMzuZYdnq13uifapOg3jl3
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
X-MS-Office365-Filtering-Correlation-Id: 1fb4bdbf-e59b-41d6-0203-08dec5986932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|6133799003|22082099003|18002099003|921020|3023799007|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	jwNZMwA45tjWqLGNtWAs//JAjjpTYudr0M0Ic61keXoHzPsqg3A6hbtbge46LY5oaoh5SpTqYDwK+PbGyN0KfuI8KZb4mqGhC+1vGporj5B7GqIa3GCFbmzeeXgsPlsHdsfhZ2DZnhpPXnIHYhoZEwa48MYGE9mILWKoAscoshEG+S/dcdKj3OXv9pkUgjyUyv02psc+6un6FVk/c82g+wxtZvCU0KYKahpJ1fTTESGZD+EzceijsV1d8Vc7pLB9Mww6L1+3ss+WW7j6622tXneV2ErRw0ci++OTFKJjPSVlZLY9hUPTidzYM5r3ynJLudaiiUrGmSMB6cEFQwIel2XKh9o6WB89iYEinG6uZEi7Iw68dfeBwxXMPtjv6C+v7hJ+ujafd8Pd7dIEckIsql3Z5lOJN7LBH9p8sR2amhi9LwaNjMA6/X/1A+lPDEYbHXNrnqoSiga3nwDzftSN7p03ovel/fh2Xni8ImAhvu1eaSdx6rJEtupyP4a+wThu5OzVEQnemqrz5PU/CuknGys5SRqFyXC76vNFlr2xot0y/+E2TPkN5QOBoQpiypDjmQD9O3lcQwoOkmm4ESFXEHERdQBZccAAZBEDgRLBT889+bjNC9hy6uspyau5Kmjm1T1AGAtDKWJd/PqE4RmUGvqly0Cnx+Qf3Ke9lrkbmTuQ6vSYGfehLZ1SZhQhLlQ/dTRUnOKSDj4B0ieUYoxiGO4PU/FkeGMaJVUEwoSnXks=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(6133799003)(22082099003)(18002099003)(921020)(3023799007)(56012099006)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGZ3UGRvVzlkNkovT1E4WlZSeTFDc1I2SUgvakdFMkFheWJVSUdlbXJvU0JE?=
 =?utf-8?B?eTByajM3WWFGb2FEblp4eW93YSs1SFl0cEZEcjNZM0ZnaFBMdWN4QXRPalR0?=
 =?utf-8?B?dGFOSGYvL0d0Nis1TFJTRkFtYnFtd29DUkpHbGlyR1R1bzBJT3JTOUQ1NExB?=
 =?utf-8?B?SjN0ajVGRjdkbXJ6SGo5UmJTaUhBNCtIYm9KVnRGcnBCSFJPbVFpU0RXWmVU?=
 =?utf-8?B?aHl6eTI1VG5XMkdZWHhGYnFreng1UFZSNEpqYURFdlFKL1JUMUN1ZW1Qb0E4?=
 =?utf-8?B?VmFCRDE1UjBXTnVFcWgrU1Q4RDJKZ1V1R2lyQlMwUXVGamJkMEM4TG1Fcm5k?=
 =?utf-8?B?VWtJN0JkTFVRdEV5YVVEV0x0ZkZSdW1zNTRnQlVzN0UvcTArcXM3MHJTM3BG?=
 =?utf-8?B?dlJYZEYzRGgxcFVYbzQzbDRrdVYranRBUlREQVp0RVMxVC9BT0o5ZEoweExU?=
 =?utf-8?B?SXF3OGREcWxMbE0zS2pDS2NoWCs3RG9oZUcxQVJkeTRjL3NJbXZiNVhpa2F6?=
 =?utf-8?B?UVZtUGh6dW1DZ2xwRHBiaVBPMFBPWU5XaGNIampzWHVWWDBTZGQyWm1rUXU3?=
 =?utf-8?B?SkRpb0pmVGtNa1lrUkhzaGdsOExSZjhwSXNWenlqQVJvdFo5OXJUZ3EyMWdN?=
 =?utf-8?B?Z05NSFhERkI3QnZvUUdDS2FBd2JNT2hxajh4MGJrUTJGY3E2U2U0WXBYTXlU?=
 =?utf-8?B?WlB0d3hFdHJxOW1TQVd6aFlsdW5HOGd1aGZ1T2pobTVMSVM1TzZPV0hKNG82?=
 =?utf-8?B?MlBJSjhxeFFISFM0d1ltVDdvS0p3KzFrT2NkK0xUU1hLSzJmc1VHTjhHVk43?=
 =?utf-8?B?M21PcTA4QnVoOGl2czQxUWtpMXNOR0swSUI0YmUyejg4QzNyRDhRYXVsL3JU?=
 =?utf-8?B?MjVVNG9wL0VSNjhTT1R0dlRQU2IxZDdqY1p3UXBLOTRBa2NGSFBaaTVxb3l5?=
 =?utf-8?B?cVUzZkxzZFZSZXdCcVRSd3QyenIwdklYcVozbnpUNENjQVJGSmNqZEZNeTd6?=
 =?utf-8?B?ajViSUxYQVRIZERFVmZJRUZxWjFEOWEzc2h4cTIxaUxwVDN3R2U1N0FtWE1E?=
 =?utf-8?B?NDJ1aWd5OHV3N0x4b1MzRmJLbkZuN0lVT1N4dFoyWVkxQURrSUVCL1B5VFJE?=
 =?utf-8?B?bWV5aWN0UTFSRU9JaStJNjNkN2o4TFlpeFFDU3VqakpjUlhncVpFbENFYUU1?=
 =?utf-8?B?ODcxMVlVYlFFMGxZOHNSaFFYMWVEL2liWFFndGFjNUhmTGFVdmNJVzRIU2pQ?=
 =?utf-8?B?TE0xeDVRRDRseWdGWDAyVXVWd0FCOEFvSnhadWV4V2I5T21UbVljR2tRREla?=
 =?utf-8?B?UFZFanQyNG1Zbms1QVBtdTNRa0NTNStoUjREVGRmbFRtKzRFS0hBME1TTFow?=
 =?utf-8?B?UVdBNlBpY3NZOWUzZWN4bWpmR3ZDQWVQd3Q3QWw2QnhkRHVXOUNqblZlL2ZK?=
 =?utf-8?B?dUV5bnhpV0pnbHkrNDlpWUQyUVo5OHpqL2VxNEd2cDE4SzR6WUJyTzQ5V004?=
 =?utf-8?B?cTZKZHpGVkFadTRjdjZvWmVTTHcvRlppUVVudTc0Tmh3cGVpQUJjYjV3VzEz?=
 =?utf-8?B?MGU1M2xDVDBjdFlBb2JCMDVzUUtocHpsWm1pTTJjOWw4MlhTazRrSmlkUVhH?=
 =?utf-8?B?VWR5ZGZJQ1FJbVNEQ1U5TEFucXpkV2EwU3A3LzRxOE9ESGZyTlRQS0lIazFF?=
 =?utf-8?B?dEJGcGpqY29DREhIem1OL0hjdm9HUDU0U1NsOHNmUzFxNTlqcEVvL216Ylpo?=
 =?utf-8?B?Y2pIdVkvV2JFWVRkVHJQTE1OUkV3Nzc0amhGZTVqYlZvaWY3QnVXUUc1ZlZL?=
 =?utf-8?B?V2JRWXJ6R1FSRWU1aWdLdlFSK3M5QzdsWW4rVklmdk9zVlhVYm94NVBoZUYx?=
 =?utf-8?B?b1hNMW02Sm16cEo3d0tpU1R4VHE1dGZuZWFjR3hJME5QSWFvNm55ZkdjZ0I2?=
 =?utf-8?B?aVBmTXVtOWk4TjNUdHZxZHRmTXVpQnd0bnBWK1N3cDFaYXgycVlKUHlHL2FD?=
 =?utf-8?B?QTlHYUsrZUd6OTcvTVRFeVAvMVZIdjliL2hEbllNTnFCR3hLNEZQbUQxbmhP?=
 =?utf-8?B?NVRWcitXSlBZK0ZNUmxYRkN3amNFN1pyd2Q5eUd2djM2R25leGRwdGRhWnho?=
 =?utf-8?B?cUprUlkyTSt4TnpnU1VTS0xlTENuNkRHeXFZMHBGd1JnZ1JTMDNNU2JiWCtj?=
 =?utf-8?B?MDBjczZkSmdPR1ByMmJ2Nzd6SEJiMHJydlo0OXE5bnpPZjB0ZzRQZGFWS2VG?=
 =?utf-8?B?WkhtZ3dWd2dWZ0tQVDBSbjhtR3lNS01oem4ydHVlQm1ocWZDMC9sU3d5Mmdp?=
 =?utf-8?B?TFlMSHEybVJicGRzU0hEYkZYUXFhZUUxeDFEdy9nNFNkMWY4dDVkQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb4bdbf-e59b-41d6-0203-08dec5986932
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 19:59:12.4458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E98Po6IOkGFUB7V+UUnQO1IjaiGuTydB+hXgcDTF+gqCvekwq59u+s9pTRvi0/cVqd/i0oV0v01dOKiDsOt+Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7398

`Io` trait now has a single required methods with many more provided
methods. Provided methods may want to rely on their implementations to not
be arbitrarily overridden by implementers for correctness or soundness.

Thus, extract these methods to a new trait and provide a blanket
implementation. This pattern is used extensively in userspace Rust
libraries e.g. `tokio` where `AsyncRead` has minimum methods and
`AsyncReadExt` is what users mostly interact with.

To avoid changing all user imports, the base trait is renamed to `IoBase`
and the newly added trait takes the existing `Io` name.

A `size` method is added as an example of methods that users should not
override.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/devres.rs |  3 ++-
 rust/kernel/io.rs     | 34 ++++++++++++++++++++++++----------
 rust/kernel/io/mem.rs |  6 +++---
 rust/kernel/pci/io.rs |  6 +++---
 4 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 3545ffc5345d..6e0b845b229b 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -68,6 +68,7 @@ struct Inner<T> {
 ///     devres::Devres,
 ///     io::{
 ///         Io,
+///         IoBase,
 ///         Mmio,
 ///         MmioRaw,
 ///         MmioBackend,
@@ -105,7 +106,7 @@ struct Inner<T> {
 ///     }
 /// }
 ///
-/// impl<'a, const SIZE: usize> Io<'a> for &'a IoMem<SIZE> {
+/// impl<'a, const SIZE: usize> IoBase<'a> for &'a IoMem<SIZE> {
 ///    type Backend = MmioBackend;
 ///    type Target = Region<SIZE>;
 ///
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 8b3a64188b48..9c2ea17ca87b 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -186,7 +186,7 @@ const fn offset_valid<U>(base: usize, offset: usize, size: usize) -> bool {
 /// operation.
 pub trait IoBackend {
     /// View type for this I/O backend.
-    type View<'a, T: ?Sized + KnownSize>: Io<'a, Backend = Self, Target = T>;
+    type View<'a, T: ?Sized + KnownSize>: IoBase<'a, Backend = Self, Target = T>;
 
     /// Convert a `view` to a raw pointer for projection.
     fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> *mut T;
@@ -269,13 +269,10 @@ fn offset(self) -> usize {
 /// Types implementing this trait (e.g. MMIO BARs or PCI config regions)
 /// can perform I/O operations on regions of memory.
 ///
-/// The [`Io`] trait provides:
-/// - Method to convert into [`IoBackend::View`].
-/// - Helper methods for offset validation and address calculation
-/// - Fallible (runtime checked) accessors for different data widths
-///
-/// Which I/O methods are available depends on the associated [`IoBackend`] implementation.
-pub trait Io<'a>: Copy {
+/// This trait defines which backend shall be used for I/O operations and provides a method to
+/// convert into [`IoBackend::View`]. Users should use the [`Io`] trait which provides the actual
+/// methods to perform I/O operations.
+pub trait IoBase<'a>: Copy {
     /// Type that defines all I/O operations.
     type Backend: IoBackend;
 
@@ -284,6 +281,21 @@ pub trait Io<'a>: Copy {
 
     /// Return a view that covers the full region.
     fn as_view(self) -> <Self::Backend as IoBackend>::View<'a, Self::Target>;
+}
+
+/// Extension trait to provide I/O operation methods to types that implement [`IoBase`].
+///
+/// This trait provides:
+/// - Helper methods for offset validation and address calculation
+/// - Fallible (runtime checked) accessors for different data widths
+///
+/// Which I/O methods are available depends on the associated [`IoBackend`] implementation.
+pub trait Io<'a>: IoBase<'a> {
+    /// Returns the size of this I/O region.
+    #[inline]
+    fn size(self) -> usize {
+        KnownSize::size(Self::Backend::as_ptr(self.as_view()))
+    }
 
     /// Returns a view for a given `offset`, performing compile-time bound checks.
     // Always inline to optimize out error path of `build_assert`.
@@ -771,6 +783,8 @@ fn update<T, L, F>(self, location: L, f: F)
     }
 }
 
+impl<'a, T: IoBase<'a>> Io<'a> for T {}
+
 /// A view of memory-mapped I/O region.
 ///
 /// # Invariant
@@ -811,7 +825,7 @@ unsafe impl<T: ?Sized + Sync> Send for Mmio<'_, T> {}
 // SAFETY: `Mmio<'_, T>` is conceptually `&T` but in I/O memory.
 unsafe impl<T: ?Sized + Sync> Sync for Mmio<'_, T> {}
 
-impl<'a, T: ?Sized + KnownSize> Io<'a> for Mmio<'a, T> {
+impl<'a, T: ?Sized + KnownSize> IoBase<'a> for Mmio<'a, T> {
     type Backend = MmioBackend;
     type Target = T;
 
@@ -921,7 +935,7 @@ unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
     }
 }
 
-impl<'a, T: ?Sized + KnownSize> Io<'a> for RelaxedMmio<'a, T> {
+impl<'a, T: ?Sized + KnownSize> IoBase<'a> for RelaxedMmio<'a, T> {
     type Backend = RelaxedMmioBackend;
     type Target = T;
 
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index d9b3189d09b4..e95b769ebe47 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -14,7 +14,7 @@
             Region,
             Resource, //
         },
-        Io,
+        IoBase,
         Mmio,
         MmioBackend,
         MmioRaw, //
@@ -210,7 +210,7 @@ pub fn into_devres(self) -> Result<Devres<ExclusiveIoMem<'static, SIZE>>> {
     }
 }
 
-impl<'a, const SIZE: usize> Io<'a> for &'a ExclusiveIoMem<'_, SIZE> {
+impl<'a, const SIZE: usize> IoBase<'a> for &'a ExclusiveIoMem<'_, SIZE> {
     type Backend = MmioBackend;
     type Target = super::Region<SIZE>;
 
@@ -292,7 +292,7 @@ fn drop(&mut self) {
     }
 }
 
-impl<'a, const SIZE: usize> Io<'a> for &'a IoMem<'_, SIZE> {
+impl<'a, const SIZE: usize> IoBase<'a> for &'a IoMem<'_, SIZE> {
     type Backend = MmioBackend;
     type Target = super::Region<SIZE>;
 
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index cd921cbba164..0d4e87b00b71 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -8,8 +8,8 @@
     device,
     devres::Devres,
     io::{
-        Io,
         IoBackend,
+        IoBase,
         IoCapable,
         Mmio,
         MmioBackend,
@@ -138,7 +138,7 @@ fn io_write(view: ConfigSpace<'_, $ty>, value: $ty) {
 impl_config_space_io_capable!(u16, pci_read_config_word, pci_write_config_word);
 impl_config_space_io_capable!(u32, pci_read_config_dword, pci_write_config_dword);
 
-impl<'a, T: ?Sized + KnownSize> Io<'a> for ConfigSpace<'a, T> {
+impl<'a, T: ?Sized + KnownSize> IoBase<'a> for ConfigSpace<'a, T> {
     type Backend = ConfigSpaceBackend;
     type Target = T;
 
@@ -261,7 +261,7 @@ fn drop(&mut self) {
     }
 }
 
-impl<'a, const SIZE: usize> Io<'a> for &'a Bar<'_, SIZE> {
+impl<'a, const SIZE: usize> IoBase<'a> for &'a Bar<'_, SIZE> {
     type Backend = MmioBackend;
     type Target = crate::io::Region<SIZE>;
 

-- 
2.54.0

