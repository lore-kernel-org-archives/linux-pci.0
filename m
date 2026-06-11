Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022126.outbound.protection.outlook.com [52.101.101.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B757A441030;
	Thu, 11 Jun 2026 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195320; cv=fail; b=k3kab3N2CIhqW9uUlU3qJkdJmEZmS6j0lWvYAGmELn8Ur0m5PpvoTy+riMFPGIRUZ8Pu1qIGs7P1zY6Sj/8gsJgK2kYKoh9V0kNGmca7ZGjXYJzirHgvk9NI5BBnz73xSPeEFJgHyDa4/BZJCEPcgspdD4dFombHh0SQvmMnMdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195320; c=relaxed/simple;
	bh=iK6UgmiaN9Jcnn8xAl/Gjs2DlE8eXQgL6Hxf/lSxxFo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=AQVctUxkbGBq9nc/XhaITcRGC97Fu2dIvLKrP+9X7l+8pSwbSLGSbQR+0nP12YLZi3Muw3h6oqFL3BVSYEE43wRxrHyFql1bCOCI558ONeko96bQBHtMNhecm5mowUQB7tOYFUi/6YA5spstuhsYKhXk62izpezByLjFobveKwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=G5W3uHWX; arc=fail smtp.client-ip=52.101.101.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="G5W3uHWX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmxLX+pa+v7bxdhmm2s3WG6UsJHdY/XIEd1+XyDOtMLxAKcYh155FyCOgW63MlTXizD2Wm/zyU72HIr28wcjUS8jHpj9veirkEWWE9+5j4A/NkJ29QObXiDhLYrg4yiDWSUGujsS4QZ/UT1AmKSzCQCr6mfGXrdvcJagYOSS2vMAxVxY8FpBdqCFB65XQ1iP4J9WD8GmKmZOugoPrgyZHQNOjHmbcO04SEl9VwsXS3sFN1DYlXsk5eQ+ZZhPls4sE0TeO5BOsfsPjZXumk+yRVweSM9CJNMGzT9eD5I5ZzKW94JzSsVw/s/fdh3hyL7eVBfw1SXU88BiuNOkbhIwrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+f600/3NgUVIUQ4CUqf5OEvw/H8USpLP5zT8BXesqU=;
 b=oDhyh1k3BIuH9DTBQWU4uNIp8DSFnMJLCEQVVUJ8vJvCeKWabMU2LhD3OUqsTau15y7vLcFJftB5wyteTjjAQJaLleHrHF0FahWSMRdQdWR+j4MEFEfPjXA1ILqV0eUZiZg6qzr7B8otKK3zXFNdMaMoadt47kjEOUVgOMKfVfyLuIeeLbezyp8bbYtAmnN8h/DKO2DQi45pJuLy2EKsgu7iQ0jH+gD66RFjzrMqoJsx+ClKv8YnGEGKpM1z75xaJi7GpZFl63gmL8KVCq671VxTSrnIOjvPB9GHSuAMPMZyiIJit4hQqHqmFooPBM/yGxTdaLVhnjL6IqFQKBHZmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+f600/3NgUVIUQ4CUqf5OEvw/H8USpLP5zT8BXesqU=;
 b=G5W3uHWXpjn7/1EmMSmKjw+bjb/Zq4Y8hX2deAbmstiEbCSlb08OA5hnbDSeTsQWFWxUJesVWn3qhOmjQR15IoQsteSkLMpZH4pqOYgfrok3zvMzkpFLFzRVNVLphwXSwOv0Tge35Hte6FnuTkv3RX9BJUkAiM9TO0YC1/NX8dM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO4P265MB6525.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 16:28:28 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 16:28:28 +0000
From: Gary Guo <gary@garyguo.net>
Date: Thu, 11 Jun 2026 17:28:12 +0100
Subject: [PATCH v4 10/20] rust: io: remove `MmioOwned`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-io_projection-v4-10-1f7224b02dcb@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781195301; l=8853;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=iK6UgmiaN9Jcnn8xAl/Gjs2DlE8eXQgL6Hxf/lSxxFo=;
 b=o2LFKxdITrV8B3IlCdPP4CTRc+MdH0hNCxvLG8d7SwllaV5yZP4V7DiP8ow11fSLPcvigEaE1
 3o0/ryTWPr2DdZBKamJlxT87i4DafUSk4XT+tDUgsV1VeYK6MkYZDhw
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
X-MS-Office365-Filtering-Correlation-Id: 985a4382-ac92-4a6f-c1f8-08dec7d67813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10070799003|921020|6133799003|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	g5ZWzC4aGGIHBBcvUO/FC3xRtHmQpNphNe8bfl307iEeG7SOtDTX9JsEZ3Q2k5Kp409ZefMLRHjEhTxaMCqB4ZVH1nA81FtWklpJnrpLNaIyq0aLArTebHLBQ3ILj198Iy4LxdhA1zY/hizVZlmsFktd9RYmyy5qlHl/5j4rM7zNdn3FxBx94lvULog0b/CR29Bpdsyii/YDl4Egcp8hZ0yMcRxlrOOxZooOwjET6Uaf/WO/flAJRkMU0DrWSErmqsVz2C7BZQLEpN4i9DvmU3GQo6EW2r6gvoYDmqE9JgTeYSh4V2ln+0Bh9CRX/QNQhjCHQXf16xAkhwQMROKI7xBKZ2kQGirxU4kAqM6ymFUcFM+6y32i3PLsUo3zQeOiCH7h1YJhdmXT9ra/vd743ZBRLyEs6MYqufIbvgxD8A+lyD79zTv9CFCAjghEYOdnxDHPY7YMXocRKmHoiLDPMGsVcA7B09H0OE+9EWohToOWXDJYX+h+cbErGVMbwVrPyEZ6O41fPbVrqY7Lczby5iCLFwb+rCLxEOPynw8R6XPS4jvGeOluHOGfUeHNUOTXtmFKB3dIpSqZX0v6MYkdxfC9RoIyrolX4Kc8w3p65vLYZgjX56abtasejq+rHiRn+1YcCFYzeeyAAVQSdEMVuuhjABy88SU4nKMvoU1gZdd0ahDFI/+KzSpr+SU2CiCKgzxVVSfqqZFyWIaJTjWyDkyR6v05w7ZL/KRk1WSQxKk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10070799003)(921020)(6133799003)(56012099006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXNnS0l6LzdKdmVRN3lhdnZFZjcvWmxCbmJRb2RWWlU1bmpKUmFORDRhVzl6?=
 =?utf-8?B?SDE0UC96MDVCMDF2NmxmMU1udjBjR0IyenNVeU9NcHMreWp3eWdUazBqNEl0?=
 =?utf-8?B?empRVHFZenFpckRtQWthZUpqVnp2dEE1bXhTVW5UNVZWVTB2OEY1TS9aNWcv?=
 =?utf-8?B?Y1ZDdzNBalF3dWk2YkhlR3U5aWpWbTdmYUxCbUhoM2hGZU9ydHlNZGswNzlV?=
 =?utf-8?B?SVh5bjlGR2ZjWUg5a2o0amMxWE9vdHJVTlp6UDBUYm1NaUJPOHI3MEY2VkE4?=
 =?utf-8?B?bjJ4ZkZNUU9qSnJTcnd4ZU5ZTHNpRmU5K0xNRGQ2VVg4QlhzZXZHTEZPYXpK?=
 =?utf-8?B?bFF3SkxCTjlWMW9rR1JpZVlYSUpYdUFudWJPMFpOL09YcHdqUG1aNDJ0STRR?=
 =?utf-8?B?TkZwY1p3ZFRGUTVaaCtjUUhPSzlpRm5IZEdzSENBS1BydG5CVGllSnRGNisz?=
 =?utf-8?B?M2wrbEF2QXpMVzVqZDBZRnkxcitQSHJoeG9mNzh0TWxhMEhPVGU1dmU1Ykxr?=
 =?utf-8?B?blZBR0dJNjJuaEVDM2JjNis2MEQ4UUtPNm5uV25ldnZTMWNZcStiOU5UWkRx?=
 =?utf-8?B?WU1KMldXK2FpdW0wb3BpZm1remYyc25lK1E2ZFN3OCtSWEJTbHlERGo5YVVX?=
 =?utf-8?B?ZTYyUUoyR245SmF1Q3FhN0NhQ09Xa2pHSVMvczFTcFZuWnQwSVhlTkpMM1pD?=
 =?utf-8?B?TnlkRlhqTUVkN3V3eGxqL3VDanBaYzgzTEVaSzBWejFKenhsMFdyaC9HS2g0?=
 =?utf-8?B?MXZIcWppaWUrVEhzV21GdHBvVXV3QTRCdmczdHV3ZER0cW42OU1hUDBBQzNy?=
 =?utf-8?B?MW9aaUhBbWo2WE1zTEw4NjdSbGZ4azlRY3JnMStWMFhWSDdBYW80Uk1KUlI0?=
 =?utf-8?B?L0tNZit2MjF3NTkrbVRHczl1U3BEdWw3cjdGN1FIOGwwQ2t2d1puNnB6dUVG?=
 =?utf-8?B?TmMzOVg1cUxiTk1FdWpCQStENUFWMDRpZWJnZ3QxVTI3c2hYaU01V1dPaHFq?=
 =?utf-8?B?VFlaNmNtVzZPcFdQUGRTbG5sdXBuSGVwNDZHWjFMZWJvTzdFQ3A4TVF2bGNU?=
 =?utf-8?B?R0h1aS9laEsraGNMZjV2Z0FMMkhiSGVRRlhHd1NGT1dmaUc4MDRPenduL0JB?=
 =?utf-8?B?RS9zQXJ5TU05S05GeGl3TE02Nnl5di9abEVWZERDT3dhZVRMcVRoWGYwRC9r?=
 =?utf-8?B?RlpDMWlBK0NGL29FN2cyRHk5QmNzdmpscGF2MU9tRDRmdENJdTRCemlCVnpE?=
 =?utf-8?B?MmpQTGxFWFp6MXpnYlVTQURmdFNYOG00ZjR4eDVqTDZWVUs0SmFUTzZmcGdk?=
 =?utf-8?B?ang2dGlGSnNnL21XalVRRzNod2hwb3JEZU9INmgzdjV4VUZiYzRlWFJ2WHJX?=
 =?utf-8?B?V1VyME5pR3RwTXAraGlpbktFUEk3WlF1ejRNTG5oVWpnWEUrUlRkOFZPOFRm?=
 =?utf-8?B?VDUxaHhFM3ZHeUp3elhyUzRsa3FFRFpOZCtDWFlsam1hWkJDTHMvUkNuaFdt?=
 =?utf-8?B?ZUNGQ1F1Z1l6RUcyRGc2WDRtL2RBNmZKVzREeEt2L0paY2M2NE0xNjQ4N0gv?=
 =?utf-8?B?b2pZMGdNZVhaNngrMk1KQ3ZEcHRCaGZQaHV5NE9jY05YblYrTm1aalhnNXRP?=
 =?utf-8?B?RjBkanNiV0lCNDhVWTFpWUtWbURkL1Q5VXNCSk1hY2d4SklFTXVBQ3lScDkv?=
 =?utf-8?B?eno2aENBMVowdERoQUxSVjdSYm4rN242RjFya20zUUdsdERoR2xFazM0VnZs?=
 =?utf-8?B?L0hncEdpR2Zkb0NKRHRIK0VNNHVWWTVodUViaTJLRkV1cXNobXRSQ0dVYzBQ?=
 =?utf-8?B?WmJiWitnazJmQ0dENUZUVGNxWU9Kc0hvSEdVNTFiNDg2cmtzSmRYV1FTZ05Z?=
 =?utf-8?B?THJIK3V5UzdwVjlzRjJNTitYMzVrbmN5S21JWnpJOHpxMU5idFcyMnJZMmpq?=
 =?utf-8?B?cGI0ekpmakhWMDBaSjVveUlXV3lKWDVMVWNSZU84S3lKemxOSzVpWDZJNFdm?=
 =?utf-8?B?Rmg2Wk8rVkVndFRRcWFrUXIwT2tjamx0cTRVOXNLZzNoT0lGZEV0M3owaHBY?=
 =?utf-8?B?ZUpSajZNNytUNU9mcHZjeFZpTmplQ3ZVOVo2SWs0VEtsdHo3amlONVhwVGlj?=
 =?utf-8?B?eXgvWXBRZWZKcUJTUFNhUlZzNEpSb1FERTVkK3E3Rlo0c3prYWlaanRnRmhE?=
 =?utf-8?B?YWtzcjN2TWMzQTFYUlhvUW8xQ0oxbklLUVEveEdRaUZYd2h0UEhOclBSMVcw?=
 =?utf-8?B?dFlSRk9QV1RHVE16VnpEK2ZQV1pMZTREb0UwQ1BuVFVEdUlGcU45VlhsbW02?=
 =?utf-8?B?SmlMSE9ydWhnakdqUTJmSnB4eUx0bkVkREtVWHNtUUhnRlMwYmVpUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 985a4382-ac92-4a6f-c1f8-08dec7d67813
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:28:28.5608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 60fPJMLaQK148vunb3RDvVbNgFbFzdLHP376nEEaqrgrw1pzlLiP3vigRfWW6qHkqaXTO4rcph+vr2C/joJUpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6525

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
index e422a5ff2a5e..132454a38d64 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -99,8 +99,8 @@ fn size(p: *const Self) -> usize {
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
@@ -157,80 +157,6 @@ pub fn size(&self) -> usize {
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
@@ -945,31 +871,6 @@ fn io_write(view: <$backend as IoBackend>::View<'_, $ty>, value: $ty) {
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
index e67c1e3694fb..4be33ecb4192 100644
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
@@ -269,12 +267,14 @@ fn drop(&mut self) {
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

