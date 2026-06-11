Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022126.outbound.protection.outlook.com [52.101.101.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAA7481AB8;
	Thu, 11 Jun 2026 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195326; cv=fail; b=eDtSa7RIrCyQ9tom1FDNT+UpDZXomnVHAplBV0kZysqbOYqnX2vT76slah+bp21N4CGPN+tNHVztd6p2sWifn5gPQcGXDLlDPQwQ902xMEl/9vsuCuWwmhTtf4HTJUZdoO4C1WUVPy72BawOdjQ7CB+h+g566/xUzA970Myq0H4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195326; c=relaxed/simple;
	bh=VgsN9Sg1dp0TUbG/ok+GvKH00Dv8r2Kv2dJgDG8m844=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=chU1HHfv8A9po0gpVo0fQ2/dU0NBNGxqfupbI+MCnQvLxo/4f7Rdv2MO0tYzMC0nXJLv8BOoFISjH8Lwe+lgL4nkMXrsVw3rBdaPoXBMz7TqMVn2sKgl20aTyGiL8qj60zXl67kpeDdNgOuD2z4x0gW2sKksDpHzii52pT4Yqdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=hJGTmUim; arc=fail smtp.client-ip=52.101.101.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="hJGTmUim"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oB8KRwOLji4PFew2JUmRXK44joGr/GZbEVAmbx2ZdKCLnk0wbvciyaqPk9SrhRfyxrHIzlTpAIyr4fHscKA3sNrjez3Wg6ugUdP4EEtiqdsH0s95X0LzUqga4dpF36XyivvegX+07RnrsrrhLwCG6KzKIYiEGqaq/xIqdWqKKDgWZ2WY7HRGUuEMOnKG+IkK8q1K96UAVUSPEM1XCIkcFxhTns+03nDCRfDkLB839Gbhpp8z1GWXUbHS08KZYbGKCKaTm0PQJIywl64yR+DykQMvVwoltGROBJaWNvY5nz91lP3RTGRcyC6+drX2kHASDUWzU2adxgwOkq6ZZ0KksQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qN9tqfRafOv7/7gE0QTzPm6f7EJUZMUQgF6JoPKeX7w=;
 b=a5VwWTRigFSfg+jdx6GSsF8bi0Ls65l/tiYGxLX2uSlttG6NVgiUBWunnfcLNjSvV8HnUpGRDTR4gKcyxQXhzEXypdQAz8neSRsgTDlp7/FXw1kAykBe6pSM87YGakJ3Lkr8TfhckaYWvkVxskTUEft/N4iJf7i9fOiKZMi+o7jY1A7YbYw9/ELkSc8R0BC3GYtmfi7vFXylSLqLmOblrTO7Ztcfl+yQA00j/ycURhDyJHHwJrriiFl3FcYNXK1sBlAfTT/mFiVspP1WfYi8zACG+1vjUcaV6zUiWv3mtMVXmdgsFB/6yPaU0fZclCvXDV1sJRTY94RskGoGYcbOjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qN9tqfRafOv7/7gE0QTzPm6f7EJUZMUQgF6JoPKeX7w=;
 b=hJGTmUimJ7HZbTkISqDVPrlDIDCvyfy3eIwGOlHMw75qAuEHoUgPTOa8gkTGdcp1VbpCbs6jgohsmzu7ellTwQ46DnsM9U8SN9/bhgCFL++KSI+tXF0reY0FdvwrokQhwP2ufoJbLvZ/ZfurjmvnuuiIs7U+ngFr80+UhmKegFE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO4P265MB6525.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 16:28:30 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 16:28:30 +0000
From: Gary Guo <gary@garyguo.net>
Date: Thu, 11 Jun 2026 17:28:16 +0100
Subject: [PATCH v4 14/20] rust: io: add I/O backend for system memory with
 volatile access
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-io_projection-v4-14-1f7224b02dcb@garyguo.net>
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
 dri-devel@lists.freedesktop.org, Laura Nao <laura.nao@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781195301; l=5302;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=+3g3zjrIMkWzE2l+dGN2VRMKCNbJcRYKIfHVvT2+YxM=;
 b=Ffyee4+SHyduFhIbRrhbEIC1vI2mUlEsOQB+SvqbwB+wLJX5qMfE/OZV4Gv3En9kDfb8EKI3w
 PS3UttHm9f+AQlcV29eWpOCbZ7sLcP4x2D2dzzZcUifwLjHh5C0oLvl
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
X-MS-Office365-Filtering-Correlation-Id: 6ef24a40-c177-4746-28a4-08dec7d67977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10070799003|921020|6133799003|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	D5FGaUhJ4nt0wUOc9E8zmWbH8dJQ0s3gv+xRUBFk6X72g9dW9WXrLWrj5yskvkRG+RRd2Ty7m9+htNrZMYqE1vMmWIk81/FJEY89zdmKNz3dPn+ev5v64iSPGc94cQBDcixpGUhsy33I4z4IcIxCl3InF0oeO+EXmSCjl2wiEjfNtU1shXdIoa3hD3AjqCwtXNqXuWho2N+HLWXWfnYqtW8YHGbo7kzNHPXgSFoyTWCOziI6V5xki4IPavyjCrDzmZA030m0dQ3JfjuBYwl7HUU2a/Tdcdrn2Gkv4gyRne+Q8vtdMwzAXwVbF++x1VdJ8hzTpcG1hW98fcZq+stUntOwEc05qbxmfhOmVLorX0IzC6IxtFe2UmuNYr8lpMMOeQvkD7JWfOND3T7QPgtrTqm+51+TkM5VOvgJzeGPdUaMrqA035cTVl0TZG8JzkNcTp4uVSFDbJiNIsTShIq1QqIcpkaoxumgKa+nXLsdy8oYcQKcHhxBgxVF0LOCsKXaBAuHuZLQmGmtc+flEOCNSwWkqXUfU1fV1IrmUgAKnslHCvk/b99hT0bS0ySnNFNSgytVJ1P5jBQageyl18nwFdvOWXoOqAHLaBmm8+iZN8MPsGIpgj62J2FDbS4ILaAn4XDw3LLAZUzDoUdRJqspPB8HQDrLk62xZKbRuBR0oKOEKkbcbbQyLUBqTkz2laxPSPR6GDaiSpRqG1WBaCq015z7phyWGHzUSF0EWpeYkQY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10070799003)(921020)(6133799003)(56012099006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TS91Z210TEg4Qjh0bFJwU09ETlkwWHFUUjlzZ3oyZ0NDb0E5cEQ3UEFLTXYw?=
 =?utf-8?B?QWNJbnRKUWlvRDhGeCtraG4zYXRBODhBellvdy9RZFAwT1Y0MElXQ1VaZVJI?=
 =?utf-8?B?Um85NUhaSjIwb2ttSHh5aXA0SmtNcjBtVE04MFhXaklhVXFuTXZia2I1MVZl?=
 =?utf-8?B?bEltcW5CdHhyaHhmS3JPck91V1FNdEUxY1RNUHh6Z3BSaHYzZHpzSmlXV3RE?=
 =?utf-8?B?dXNlMmNCbjBvcjNDYXlKVlhUVytxbmtxbnp0NVh3YlBCdG90Tld3cGw1enF2?=
 =?utf-8?B?UGRZUitXTVB1UDJ4UTIrTngycCtDQTJ1dnhuN1pmdkF2TTZUb0pETXRsSzlG?=
 =?utf-8?B?TnkyVDFiTXFqeEY0TFl0UGdlamJlMzdsQ0Ewcm9xVHlQWHQ0N20yeHB5TTJu?=
 =?utf-8?B?VDNKNEpSL2pzYUMzN0dnWnpMMEovN0dWcHhlemJNVjhtcWJmbGl4MnRqT2Jm?=
 =?utf-8?B?UHU3VlRxQ2pTQXZ0UEhDUXozR3VOUnJRSTZrNFI5RXBYajcva2M1MEJ6OXR1?=
 =?utf-8?B?WVRDdlM1NkY5Z2p1Rjk1SEgyVExPdStjd1RBb2oxSVBiem9QTGFycW8wdlBG?=
 =?utf-8?B?Q05iZjlmN2hmSnVaU1M3a3ZNYmxRdGdTM3A3K1dLZm5MZ0IycWUrazlOZmk2?=
 =?utf-8?B?SHRXZ3NWcVVnVHYveWdxZWhCRnpWYW82VVhBa2hxYVl6WVJUeHhHVjI0em0r?=
 =?utf-8?B?aHBuZ2tqQk9Hb1NnSXRtdXVsT1RiQUt5QVlkODF3ajNoZWF0UkdLaWtVbUVq?=
 =?utf-8?B?MUlHUmh1QytTNThkWml3UWJzaFpWenlZREovVTNRc1JYS1NOQ2tnS0h3SU16?=
 =?utf-8?B?N00wY2NyUFhDaS8vb083NXovN0hrZS9kMklDUlhtYVBhMitRRXpycUZtZER4?=
 =?utf-8?B?dzlHcUwza05QTkE0YUp0UTVISEZCb1ZLLzZiVjl2M2xPV0puR2h3L2s5d1ZO?=
 =?utf-8?B?UnBlVzRBdjIvd3ZHZTg4SktHU3RMaE1NZnl1eG9pWklDUlNNVVdpZUhJSVlp?=
 =?utf-8?B?bk9ad0NiY0dUUnZnM1RvTTRHUHh4TWcvZHhOWHJNSVFwWW9EL0lhbGZmQjlW?=
 =?utf-8?B?UVVsM3UxcUUxb3VmREpWZnNTZFhoTThzSUJPUFl4SVhQSkEvYldoZDc5b2V1?=
 =?utf-8?B?anFyVVlmV2Jtd2Y5bjIxWDhjK05CRTBwL1hnb2ZTUEp1Qzl1TGFlRE02N0sx?=
 =?utf-8?B?eXRtNm5CREc0RjVBVDExQVh1a2pMRXdIbmcwc2dtRjVmejlyVjNMdXZVYy8y?=
 =?utf-8?B?K21HcUJIVURDbW1qY1FiaktMNlhoWW1hNGRDQWNaQjJ5K2NpNTVWWDJteFBU?=
 =?utf-8?B?dG9ZRDh3MTlaeXdEejBhTm9odWpVWXZ3RGlDRVAxc1pvWG52N3N2eWEvZDA5?=
 =?utf-8?B?Z2thRVdJR0hVOTFIN1Z5NHp6a285eDZMblk1Mi90YitObGVtaXdqVldlYW5j?=
 =?utf-8?B?STFoYmFtY3EyQVZjSzJXK2t3TDhHbmNUV3Bkb2xTK1U2c3I1WmRlY2hLMnVq?=
 =?utf-8?B?UDNLdG1WcXFpclAvVVNnQmI2Nk9uZ0NvZ2lIdUltcGk0NzByUlpkelNSMDRO?=
 =?utf-8?B?VWtBSzVaa2F3VDlTcHlPanE3Q2hrV2ptM0t4Y1JWOFhTeTBjZlkzK1N3dnBM?=
 =?utf-8?B?V1l3aGVpU0o1QzJWU2VGbHVpbWdKckY5TUlqUHhOMG02SEFoUzZxdEVNblBV?=
 =?utf-8?B?ZmoySHhjOGRvNkRpOUwvcE9OTXQ0Y294Wmg5K1U5UHNVa3RuTTE1ZlhjWitE?=
 =?utf-8?B?aEZ6UEloTnZxMzRjNlNXY3lBbFVzZnYyTm94R2YzbHlXZ3lZcituNHpsZFp5?=
 =?utf-8?B?VjZHYkJLMnlMYmFKYm40eEtiN0pTbFBVOFlPeUNVcjB6VGNtd1VsZTJKKzYx?=
 =?utf-8?B?Y0xKOVFsT1k3ZDhtS25ZRGdRNmZUbkNSWm01dEhyeTFyT3BHY0RKZGJMbUVR?=
 =?utf-8?B?dmg0YlNsc0g1U3VTNjVQdGxUS3ZvZThWVitIME9OeXB1cTRDNzF0U3dJdlJV?=
 =?utf-8?B?clJuOS9tS0ZMSjhuNkxLelRMQm1ZYjVXNlgrRXEveG1XVFA4R0F6R1htTUQx?=
 =?utf-8?B?cHZudFFSaDBsMTN1UnR0MmJqVS8vQVNUaU9leXVoVG82TDZhU0UvM0luZ3VJ?=
 =?utf-8?B?K3Q3V2Q0eXkvOWgzQk1OQk5ZQms5RzBHQlBJTHdMMU9qNklmNjVXdXRqR2pn?=
 =?utf-8?B?UVBtTGI4a05UWk5kK3hsdDFIcTVRZGhVRUVLc2RHR283dm4yQS9INHZnS3gw?=
 =?utf-8?B?Rm1NVVhvNSsvQ0pKVC9ZZ28wSDkwaHFWb0F1azJHcC9OalByM0JXd3BjVWJs?=
 =?utf-8?B?TGZ3cndwS0FXai90Q3AweGVLOWhBdFdwaGxXMHdDZWR6WE1Id0Nvdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef24a40-c177-4746-28a4-08dec7d67977
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:28:30.8849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sijuWXL6nuk+nDwGg/udAM8aLXvx/O2hFmAfDbRgTOXPESe2BXUPifGQrZiSXE1xbkhJq4VAdj3XuZSkEoIKWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6525

From: Laura Nao <laura.nao@collabora.com>

Add `SysMem`, an `Io` trait implementation for kernel virtual address
ranges. It uses volatile accessors to provide safe access to shared
memory that may be concurrently accessed by external hardware. Implement
`IoCapable` for `u8`, `u16`, `u32`, and `u64` (for 64-bit system).

This can be used for instead of `Coherent` for cases where a different
layer takes care of mapping the system memory to the device (e.g. dma-buf
or GPUVM).

Signed-off-by: Laura Nao <laura.nao@collabora.com>
[ Rebased and adapted on top of I/O rework. - Gary ]
Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs | 122 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index c7a9952af995..a418c8cbb031 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -1041,6 +1041,128 @@ pub fn relaxed(self) -> RelaxedMmio<'a, T> {
 #[cfg(CONFIG_64BIT)]
 impl_mmio_io_capable!(RelaxedMmioBackend, u64, readq_relaxed, writeq_relaxed);
 
+/// I/O Backend for system memory.
+pub struct SysMemBackend;
+
+impl IoBackend for SysMemBackend {
+    type View<'a, T: ?Sized + KnownSize> = SysMem<'a, T>;
+
+    #[inline]
+    fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> *mut T {
+        view.ptr
+    }
+
+    #[inline]
+    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
+        _view: Self::View<'a, T>,
+        ptr: *mut U,
+    ) -> Self::View<'a, U> {
+        // INVARIANT: Per safety requirement, `ptr` is projection from `view`, so it is also a valid
+        // kernel accessible memory region.
+        SysMem {
+            ptr,
+            phantom: PhantomData,
+        }
+    }
+}
+
+/// Implements [`IoCapable`] on `SysMemBackend` for `$ty` using `read_volatile` and
+/// `write_volatile`.
+macro_rules! impl_sysmem_io_capable {
+    ($ty:ty) => {
+        impl IoCapable<$ty> for SysMemBackend {
+            #[inline]
+            fn io_read(view: SysMem<'_, $ty>) -> $ty {
+                // SAFETY:
+                // - Per type invariant, `ptr` is valid and aligned.
+                // - Using read_volatile() here so that race with hardware is well-defined.
+                // - Using read_volatile() here is not sound if it races with other CPU per Rust
+                //   rules, but this is allowed per LKMM.
+                // - The macro is only used on primitives so all bit patterns are valid.
+                unsafe { view.ptr.read_volatile() }
+            }
+
+            #[inline]
+            fn io_write(view: SysMem<'_, $ty>, value: $ty) {
+                // SAFETY:
+                // - Per type invariant, `ptr` is valid and aligned.
+                // - Using write_volatile() here so that race with hardware is well-defined.
+                // - Using write_volatile() here is not sound if it races with other CPU per Rust
+                //   rules, but this is allowed per LKMM.
+                unsafe { view.ptr.write_volatile(value) }
+            }
+        }
+    };
+}
+
+impl_sysmem_io_capable!(u8);
+impl_sysmem_io_capable!(u16);
+impl_sysmem_io_capable!(u32);
+#[cfg(CONFIG_64BIT)]
+impl_sysmem_io_capable!(u64);
+
+/// System memory region.
+///
+/// Provides `Io` trait implementation for kernel virtual address ranges,
+/// using volatile read/write to safely access shared memory that may be
+/// concurrently accessed by external hardware.
+///
+/// # Invariants
+///
+/// `self.ptr.addr() .. self.ptr.addr() + KnownSize::size(self.ptr)` is valid and aligned kernel
+/// accessible memory region for the lifetime `'a`.
+pub struct SysMem<'a, T: ?Sized> {
+    ptr: *mut T,
+    phantom: PhantomData<&'a ()>,
+}
+
+impl<T: ?Sized> Copy for SysMem<'_, T> {}
+impl<T: ?Sized> Clone for SysMem<'_, T> {
+    #[inline]
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+
+// SAFETY: `SysMem<'_, T>` is conceptually `&T` but in I/O memory.
+unsafe impl<T: ?Sized + Sync> Send for SysMem<'_, T> {}
+
+// SAFETY: `SysMem<'_, T>` is conceptually `&T` but in I/O memory.
+unsafe impl<T: ?Sized + Sync> Sync for SysMem<'_, T> {}
+
+impl<'a, T: ?Sized> SysMem<'a, T> {
+    /// Create a `SysMem` from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// `ptr.addr() .. ptr.addr() + KnownSize::size(ptr)` must be valid and aligned kernel
+    /// accessible memory region for the lifetime `'a`.
+    #[inline]
+    pub unsafe fn new(ptr: *mut T) -> Self {
+        // INVARIANT: Per safety requirement.
+        Self {
+            ptr,
+            phantom: PhantomData,
+        }
+    }
+
+    /// Obtain the raw pointer to the memory.
+    #[inline]
+    pub fn as_ptr(self) -> *mut T {
+        self.ptr
+    }
+}
+
+impl<'a, T: ?Sized + KnownSize> IoBase<'a> for SysMem<'a, T> {
+    type Backend = SysMemBackend;
+    type Target = T;
+
+    #[inline]
+    fn as_view(self) -> <Self::Backend as IoBackend>::View<'a, Self::Target> {
+        self
+    }
+}
+
 // This helper turns associated functions to methods so it can be invoked in macro.
 // Used by `io_project!()` only.
 #[doc(hidden)]

-- 
2.54.0

