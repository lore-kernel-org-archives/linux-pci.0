Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021095.outbound.protection.outlook.com [52.101.100.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A253DB64F;
	Tue, 21 Apr 2026 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776783404; cv=fail; b=SzoxB1aqBiFCxYIKCtJFd38pd/esNsF22CgOcxgSGS+CNvIRkqJuTprAIS/tc1U9jBce0Txu9nmeuroKweN1imj2RUOml0dQRx/NnP6AbNR5uG2HMSogRtimCZM4WmSk4BqZlc1zEMPOU4rsXyODMjo1at+3VGJhiPXa561yQa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776783404; c=relaxed/simple;
	bh=REIYrCsog4jKSossyNrV9NAWmOpEvzTGJMg8c+iA2tw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JkZIZgq/YxWtO8bOMiw5TtzoKca1bnnMMcYzggefU1FmlIqqZq82t1wNZm82H6DQHHs2/WpK2NWUPN1WJbBj4F+Ep0dm9Ps0/mmucDDUO8p1ojukKxnfPFxd3C4cktOYPK974g/B1lQ8XIGsQ67gnHQiXbWM1k9lPczVCHDaqTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=uDjVdfSu; arc=fail smtp.client-ip=52.101.100.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="uDjVdfSu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KKZiEYpepveV1NDs+cVzuz8AVkf8f0HKM9cr0WYQe6XoX2dVLL5DxeaEkBs94n7diPS/ghWZMcuvc3+w2uRv71fu2L7hTW6id4cNroH17e81QHpKNy95MOWIy2AKpP5T186Z4zU78R43hAOq/Rv5zYZhYZ06bJchWDSAawn2T2WSlvgKfn06UlKigecHu9fv/AKFbGWGOB0dgZbaURv7OlTyoQfGmwc9sZ1GlaOyDSidw8ySQhNtd/jTX7GwEBWdazsgs71R8cWMkUchxRvBgZX1V/M7JcvcPrpEyrSb6igxT2jBk/kvMdn8fYfsAg+Kpqy8N/dNCFxyHpZEsTfTTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOPnJ8/rArX21QGk5WpOti5jc4cbsiKxm9EchkvMApg=;
 b=xCjbr0BH7q2pxuoKfDVGvvaO4pG3b4B/2uIzlZWRxJdnouCuuwdOo398n+7udeBpDUw4VB1MmwlYiF6+tbfKnWgHwDZEG1OySt/TmiaZxYoK8Q29Jzilk0jGZASOvRdKws3Z3zY1NbzzG8krknHdZpc6aUsHA78mV97CFfFzAktzBqR03RpTvfKXyUsRCf7EPW7j4bYXhMP+tsIP4WZY/ZCyKQQ702i+bsM7m3ONbx10enCpsyY3wNpKlKK6CpQMSkUQleTOmOu2jZUwsHqr6TDV3AT63MdG48LdprMSLcMCzk6Rx1yo1HLDxCGQ7Gr+L654HxH5TJ3hAPHHK9RdDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOPnJ8/rArX21QGk5WpOti5jc4cbsiKxm9EchkvMApg=;
 b=uDjVdfSu6sOy7Mxzgg08DYLOsQVvW2hFV090Tim7j85NWuHNw89g6XH2loEZLmJTIx2g25OvRVqvG42+5OoK6cbC2azd4nybNJ0g9ZhNk2cELkXMhLrQLXRHlyNLmkgtaWhPZtDD5ph/6QdbxUwyszvRJVQ29FfyAsNxBA33Be4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB5674.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 14:56:31 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 14:56:31 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 21 Apr 2026 15:56:21 +0100
Subject: [PATCH v2 10/11] rust: dma: drop `dma_read!` and `dma_write!` API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-io_projection-v2-10-4c251c692ef4@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776783386; l=9221;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=REIYrCsog4jKSossyNrV9NAWmOpEvzTGJMg8c+iA2tw=;
 b=LuAgQuSw8Ou9slF2iDjHLVQajkitMXsFiUlYzh8tm0bNggeeRvCe9j6sgAMxSZI2tQ70fU6/I
 Kl0lp6+kd1hADXhZ9bhgcMAuElCCQmegjdzjKzdxGNUMrRSZfkSLH95
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
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB5674:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f06d217-a096-40be-f5f0-08de9fb62c4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	5ocNZWZgcd37BmPL0woIBLIYT+mV+v++X3PLhzEdBAE95vJaqoUde/DHDg6WCV3kjwv7Z2dkofOM8QkyIQvxshgALD2+Nw3B5yMMOYxRaxanMaFNqetzBBQ4lkJkctTaB6A11hZpNioR0LtbnDorLWhv1HD+0nlVYWSZw3A/SKsfYBdaBjZfNzlBED2c/Ht2cdnmhUc7Ux79k7DZb3H+zXcKoIui7yW2fTjNpJFpqFAPvWgGTwv5bJOi/ajvKnblvTSwhXU8MgySO/LV14aK8ottnHElYdwNdfnQyjSg2vG37YVr1xpCl4ciN7UBb8nWGV4wyC7EBdHGN4ZY5ljnPT3BJmJKThLWoNbbBaACBV8dS4Ozk/lcgVo9kOFWsHowQR5ITrIqEV/svpqmWaaHSAaTAJ5h7UBOb7w08ZbX8Utg5clSYSYYquh37fOWJfbf3O1BfQYFV7XNz0weDTo5y93Cb2yw6QVzxsMLxfBp+QymTDfPhLzS3vxbzYWSerkrh6gpYzWgXgUoySSEht+Pd7gOiYtzkSEhGUmK37mn2t/lh2gZON58uSbspF3nTOBAnpwZk54FI3CCQJbO6MefAm530Ff6X2nJW6IETg856MRFq3xrO7wlMhQseS9LuQp0c1MKnD1Cf9dbBzke1D81srxjiOR/1mhJdsJTK2yDCm5+1o4PcH+x/XSX911sLIz1frRKkoFXQeEKqoJLa8OstpS4pXt8t2/xNh/384XFNtjHREfMFTNO+vJHxMA4SK+T6Nio+7cFRtk0jBf7/4fhdA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1E5eUkvWlVjM0p2ZjRxOFdBenh2eUtsL3BWTUtWK0VvMU9Qci9Yb1JRNVhR?=
 =?utf-8?B?enZPTHp5dkNxQ3lPaG1oTEVzcEpGb29Kb0gyZ1ptK250ek1ZbE9qdG9rdHA0?=
 =?utf-8?B?UjREMmZ4KzRVSWJ0TmE4LzZNMXdzZUEvTU9sZ1VKVDNBRTA4MW1vWkNtRk9z?=
 =?utf-8?B?SnlRMnkyZDVad3RFb256RVREek9CYm9IVE5ZcDFmSm1yakUvV3pFMGIrMTZj?=
 =?utf-8?B?YW1ZWndtRnZjdks0Uk9xMmhHRmZIZFRnemZuNytvbkJORnJjQkIySmZvcTdS?=
 =?utf-8?B?UklkTjFaZXUrSVB0anBhTFJPbmYra3lHNmlpdmdWUFRrVno5Yk9ycGhlYzVX?=
 =?utf-8?B?S0FlbWhTVWRTbGE2QWNxR2p2cXg3TFBvUUVKSFBxSW5GMnpldWZyc3Vqb1Fo?=
 =?utf-8?B?bGlVWmpoTHpqclhIMkRwY1l2REJrS2Y0Z1paNnhKS0tQUkZWR3VBZUEzd3RC?=
 =?utf-8?B?SG1LVEpOaXUvdnpBL1pHNS9qdDN3dWNZZCsrcEVOZWh4SUE2TDN3M3BXb0Y2?=
 =?utf-8?B?aDEyREdaS0xRc2RuVVVMZ2Q3Tlg2ejEvZlg2NU9LOGZQZlgvSVpCTUtMWkla?=
 =?utf-8?B?dEoyUEpHK2JNSkZmR1YrOHpJNWliYncyRHFLQjNWaTIxR3U0TVhjOWpiTzBv?=
 =?utf-8?B?Rnhhc2gwSFUzWmdOWWQxZ0diMlBES2VwdS8vMTJDYXhrak40L2o4cC96Sjly?=
 =?utf-8?B?TXNqK09JVWk5VWpQRFFaNmVaT2EvOEh5ek5KaG1hZVcrck1CdmdhYWJMSjZP?=
 =?utf-8?B?aGtvendWeHY4cm9nb1lPM1RyZndyZEZPRE9tY2NJTFVIQWhXSFAvM3ZpUE5x?=
 =?utf-8?B?TGVVcTdsbzNuV2VrQTNpbk4wZEp2aWVtZmxKaEZNc25ZTTVYQVkrNE5VSTNa?=
 =?utf-8?B?RHlIRkJQQTgweFNqcXZNUWhDb2UyL0xJRWtOWEltS1VRRTVNZnFSVDh0a09F?=
 =?utf-8?B?M2tYQXAzT2lZZjZCL1ZEQ3ZmSWRiTDZhMCtkQnEwSDY4UDVuYU5pcmh1MlBK?=
 =?utf-8?B?czNySGRCTVpBbnMrOHR5Um42cXI1emhrMkxLWXdvN3F6UEg4NXpzZC9wNUZq?=
 =?utf-8?B?blNEWW1DZEdUN3dLOFM0dmhPMkRYby92amtudWVtd0NzMWJpcGttNWRZYjEy?=
 =?utf-8?B?dWNLSlVSUHdxR0pRb21FdHlhSW5GdGl0VlZHSkVmMmYzQkZoNzlsZmQ3NGpI?=
 =?utf-8?B?R0F5Y1lrMmp3aWV5YW5oSEJzaTFKcWQwSXMvNGZ4UjVaNThLeUkzVlJMdU44?=
 =?utf-8?B?R3Fzc3J6bEd5OExUYWl3V2h2L21vSWZHbytELzlzNy9MVWsrN0hSeFZsT3kz?=
 =?utf-8?B?dWJFK2twQlRDUDc1Z2d2cFBCME9zRG9mdXBBUU52VFhEOXF3cVZZS3hLU3VO?=
 =?utf-8?B?alNlczNKM1g1Z2VrU1RhSEk4Y0xqdUgwRGdqMEZMdHdFd2ttT2dUaHdLMFMv?=
 =?utf-8?B?a2s0SzlxWFIyWFQ0bEZXaHNkaUEzclJrbnNLbjJxeXFyM0lHb2FCdDRUU09W?=
 =?utf-8?B?YXdaOXdXRHBseEhuZWM5YkZxSkRpaytJSDY2Q3dQd1BSY2xXNEVDWHZBWHRo?=
 =?utf-8?B?aGZLbkNIeldxUk54Sm80eG51VlRoUEZENnNLOENneDhHckZ5dVV6dmRhVFl6?=
 =?utf-8?B?b25XRk51ZDkzLzVERHJpa0xadHBGSko1bWxMSHQwdzlNVWZiZGdma3hnVngw?=
 =?utf-8?B?NHlVNmxvOG1jTjdyV1dnQVJzQ1QyUm1UMkR0ZU5hNGUxWlUrNHJQVjNlU0Jk?=
 =?utf-8?B?YWpUTVZoWmFqcy9vMVd2ZWU2aUt0STVnTnptWUNUa0VxUVdpTDhCVFRyaXB0?=
 =?utf-8?B?TTlxZGdCK0ZnZ3JWTW9rYkNYdnVhNW83Y294Tm95VElqK0FXc3duSS82Vms5?=
 =?utf-8?B?Wis1RkpBb1ArQmxvdTNpRE1aQ3VsN1p1cVRXbnptSG4rSUhmd2FPMXR3NURC?=
 =?utf-8?B?SUdmdGJ2TTRla2Y4bVo5QTlrNWttN0hzSlZUd3ptY3YzVk4vemtFNTlBdUR1?=
 =?utf-8?B?RWdJa1ZtNGR2cFhXc0pwL1hJWHB6d0V4a3hUKzdYUlJQN0xXa3YveDl1ekt5?=
 =?utf-8?B?NGNPSGZBTndNeUt5M3JRREpmNFNZaXptWGJNdjFpNGVyZW9odm9Nc2k5eTZm?=
 =?utf-8?B?ZnBVejNtUEZleGhaYS9SM1AwdW5ObnV6bFltSCtFWHdFTW1KR2VKYWduQ2RJ?=
 =?utf-8?B?OEw5MEphZlo3QUJoOTVFRFFxWDc2dkFyWXR1SGFjeS9hdzdPOW1ZZGxYa2RO?=
 =?utf-8?B?cUg2Rm9FdEdXY0Q0aTltVVBEc1Brb0NJNFZpT2NYMkpUMEttdUtMNVJoY3Ba?=
 =?utf-8?B?K3lPbXJZVi93Q0RLQjBPQ0NDWVRJT0pSeFRtZmpOUFBRM09XNUo4QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f06d217-a096-40be-f5f0-08de9fb62c4b
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 14:56:31.0027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvm+s4jTJs/7Y5L7YSN3N3hy0iD0ZUw4ienwhPt+01g8XWpZXbM+NHOei5q/S0pHJwDR0nvG8ViwbJh4md/AUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5674

The primitive read/write use case is covered by the `io_read!` and
`io_write!` macro. The non-primitive use case was finicky; they should
either be achieved using `CoherentBox` or `as_ref()/as_mut()` to assert the
lack of concurrent access, or should be using memcpy-like APIs to express
the non-atomic and tearable nature.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/dma.rs       | 128 -----------------------------------------------
 samples/rust/rust_dma.rs |  14 +++---
 2 files changed, 8 insertions(+), 134 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index d0b86aeebfe2..bbdeb117c145 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -658,52 +658,6 @@ pub unsafe fn as_mut(&self) -> &mut T {
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
@@ -1230,85 +1184,3 @@ unsafe impl Send for CoherentHandle {}
 // operations on `&CoherentHandle` are reading the DMA handle and size, both of which are
 // plain `Copy` values.
 unsafe impl Sync for CoherentHandle {}
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
index a2c34bb74273..9250ed6f6673 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -8,10 +8,12 @@
     device::Core,
     dma::{
         Coherent,
+        CoherentBox,
         DataDirection,
         Device,
         DmaMask, //
     },
+    io::io_read,
     page, pci,
     prelude::*,
     scatterlist::{Owned, SGTable},
@@ -69,11 +71,11 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, E
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
@@ -83,7 +85,7 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, E
 
             Ok(try_pin_init!(Self {
                 pdev: pdev.into(),
-                ca,
+                ca: ca.into(),
                 sgt <- sgt,
             }))
         })
@@ -93,8 +95,8 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, E
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
2.51.2

