Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021132.outbound.protection.outlook.com [52.101.100.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937E3386C0A;
	Tue, 21 Jul 2026 16:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784652888; cv=fail; b=IvapuqAaCe65iDP0dWSo2qaaCGBg/p6m/znVkcTrOzEsAmECvywDzizzeRi04Ri1E5edb1qPwBM9JANlukK9McxTi44hnaE84J/S8wpoTCHxxxd2JYaiQJ3xL8tvHZ/QEvwmWhec6P44LTooDni1b936NCZByHUwfcg0mmOFJQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784652888; c=relaxed/simple;
	bh=/tbPMm7MZEGr2hdg4hsZfc5XlLdU+1m/iS/d5okVeRs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dbc38Hv5DyjVZrY7jonjKH5hRJZA2sowVK+n44Qaz7sT7/XZexikvHb4Tpor06oRCukrQuzvPJunzASCW+Dgne3qjpQlb1AmbbvvU449lRVuHQuZNxixY7dfh15Hue5Qj+XT8EmGtuDayvos45Ln8hWZVBQOoW1Dgwy5pK1yX9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=xU3l24Nu; arc=fail smtp.client-ip=52.101.100.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="xU3l24Nu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YD/z8qafj8w6WK+6ODxL/9beE3hIrwGg5M9lOeGdoY2f9I/S5l+QiN1O08FJ6exF3slW7xsB3b2yvSrPJ1+mvnLx96PPL1fEMtgxDGmWBmUwzkMDtHS669fEwncyRVumcSvdAjYNlTB+CscGudNCbMoiWFHVzGVdQzFc0puroYfo7S+Kt/s4jgDvacE+x4vGn/fKpW6ey+CcmUbsDjvKLcY5vM31pDa8Q5DWRFYCEE383c5oexvcKvO28FXFxFcKyir0wUFjxxSqKE/zP7XZRPJbVHuUf0GWaGNbGnF0VDt9vu7xb3pTKmsLipzF9to0/suHZsTj3ax/k8N3s9/YSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqvt61eNCMhTn8pEzy/jGP0FdJQ7M057SVVhboqWcpI=;
 b=sQaNcXWkVpKXSYwx8IIa9N3KWUF5pO0K3PKjhWWy7yiDQOfUj/+DlSCWUBurEpEHKC/LvuFk5BeKz3eqKqLa7xg6VNxn97nBUGvkdypZ/6VLYGGuKS+KRAxizk1g01/qFC9zRmvz8W93sQRDk9L4r/cyWBNFYMB/3BTZ1cmMeS4ak4NDkZ+rGAaQsbI/MzYTS7FF31m+t1PwCVEX/UjHzYcyFwQ2JJWyntKanUTryBmSL7McpaV/RX3xFLqX86gR2DdQls7FdZhWswRVsyZnhPKzZXqh89p9xUrttiLPfMaRnK8Lrqfk5ztWn6VhTAoc6JXoxTK1vBfFgDjrdxRgdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqvt61eNCMhTn8pEzy/jGP0FdJQ7M057SVVhboqWcpI=;
 b=xU3l24Nu8ATRmjPb0BNxXzBvSxRImv2Zu93weD44ES18swVLPkx8+WFIjiwxPCNuWGx6V9o2WhktYxq7gMwp+GtdYmkaUUt4boU/mEDVGXThC+7Hqy4Nk9W7Gk9zC5RRPhM4bfCUjakaZQIFvD3+vnYCJ5GwftI57/QESf8CxRo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7878.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 16:54:35 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 16:54:35 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 21 Jul 2026 17:54:29 +0100
Subject: [PATCH 05/10] rust: io: register: make register have a typed base
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-typed_register-v1-5-452d72b60262@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784652872; l=13356;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=/tbPMm7MZEGr2hdg4hsZfc5XlLdU+1m/iS/d5okVeRs=;
 b=dC6R3tnbzA8WfUd7G6E8uIHh7G0cPg5LGaLQC/bdZO6ph302S/Kwy6h73pwAKAhMm6tSk9Kj9
 X7tz1z0nH4ZARTnXXqYT1U6mMZVchRdq2w98Y/roGJSBNdeA1a20zRt
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
X-MS-Office365-Filtering-Correlation-Id: 48b3b6b3-18f4-4be2-5aa0-08dee748bec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|10070799003|1800799024|366016|56012099006|10067099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	AvAHAuTRiKesMwSfDnRjS/G39PBN7eAAmE1suKgXXWAnUvAusK3Og76N4vkoy12PS0sr0GXXeQrG9PLRAn8Ft/WWduVCp5vMe355l48/yESrnZsukqjS7TJL5890D5kndWopZHMajFHgz1SVrkWWeHjdAxRTrOpvX76u6ddzoiRapOMBvLnR176a/bbOEaht2i0DXkfcswSM89ohrR9vxDuqzL/+cKZ1VUejCrFY7oiPVDLlcxr9NgUE55sJFK8Rs2tYFD/4PWC3Y65zvHT6TmJiC3yev470sy6gBlgsnoCA+lrpqpl8YFInmfMyxZUcMzDpLWhVn0QvK1FdW+BQyeZKWVUIOSTotaVp6wt+VO/g8EJq6+2e0E7uTjZOmwa/uFoeqdfvevTs6/9yFhZpjczAupNKfERk7uGSo5jfJXzTVuqEOmJVhlRE/btzoLpPpIEnxC4ERCtj/zQh5rokIKhIviPOhwF9IoKKmsrSohmg0ZWildZZ+N8X/eV8bUMXKuE+lXxJ4km7lkbthnqHXVlN/ShIt2w+oqe9oHEK6EgRWJnwvp6zzHtAiQQKL6fJvIpVM9Ep7hMl4z8xW3mELFqPZB2Ee0uqqJ1R6LaUFgCUiuNHih5lxc9lrZxDHcALJh7Cbl+fkgObJEfaLs1O1P9gkYRFjOdXBHbGWbSumyIMTbzAcFIpI4Ef+g+kULQQuS/fOxwBrez+LMpiZFl6/Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(1800799024)(366016)(56012099006)(10067099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rm5YV2VkeGdNZzRYNlVWbTlyMk13djNGYW4xNkJCUjEvWWNNcysrK0JUZXpR?=
 =?utf-8?B?Y1A5NmxLSzhVQ2dJK3NYMUpSdjgyQ2hGZHR2UFE3N1RjK25NcEFtQnhhU1ZL?=
 =?utf-8?B?NXZWTkJpSi9hNlRlUitFd3F2SDViVXAwTUtFdzhmU28wRnM0aGJNWU1QcnRN?=
 =?utf-8?B?OFRJVTl5eVB6alJMZHNqZ3BwczZWT0FCb3NTVmhZZEVFZjZKVUo3WDRTaVZQ?=
 =?utf-8?B?VDFoc2l5MDZBdFk5T2lIUVFVL0FsdHJjdTZaaFBzeDM4SGtLV2hDclZKOHVj?=
 =?utf-8?B?bEFFV2lPWWRDSFJvTWZkQk5JbnM2NHR1SFlZaFBheXdnTTJkTHBPSjNPNFll?=
 =?utf-8?B?SWdjdHZ6M3c5QjMxMGoxRGtIeEdjWHNrU0ZQV2JPUFpoZzQyc0hMVlBDbFZY?=
 =?utf-8?B?eXFUTFZTdXJ2R1V6aCtkZ1NmT1h0Y0lPdTUxZjhCOXdybWQ1REtjUkNZenBk?=
 =?utf-8?B?TXJ6RTVFK3pqRHkvcUVnS2l0Z2NkcHFUNWo2ZFJnd2wwaEFMQWVLQThnWHEz?=
 =?utf-8?B?OHNBRjVja25HYUpwYzFsTXp0bXBPMXZEUngyOW5UaDVRVmNIQUt0L2tIamhR?=
 =?utf-8?B?TUZaTVMyZ0F0QWNBZmJSV0ZGVk9vR0Z1UVdOYkRuS2cwRHNXNjZpNzdUb1Q5?=
 =?utf-8?B?N0x3TFFHOURXTmw0MFFERGdQbXJFTzRaU0NKSnk2ck9lMzd1VVdibzlQbGlC?=
 =?utf-8?B?R204elFtb3hMRlFQT2g1Wk1ITkthNHhuNm1QemR2WWh0NG94ZDRIS29SdGNa?=
 =?utf-8?B?blcxUWdTYUV0M0luRGJ1aTdSTnBrVmNyeUZiZWlyWVJFK1REV1VGR21GbUgy?=
 =?utf-8?B?Y25sM3pEaHlGbklsQTZDbW1TVTViWmYzcm5SV24vMThNSFJFK0JqR01vSDJI?=
 =?utf-8?B?TldjKzBQR09BLyszZEQ2eWwvcjl0TzdCakEwYXNpOVdpa3o0T3BMSDV0VlVK?=
 =?utf-8?B?Q3JpMGFXaWJPcXVlMU1KNmxPajZESkdMc2h0TzRNWXVOSGhPMmZBaXFTL1RQ?=
 =?utf-8?B?dDA5aEN1dEpCdnRqT2VNOEQ4UHRaNlJYMEVINnF4dVVhem1lelpscnQ1RFZ1?=
 =?utf-8?B?QVVISGx4NmdFL2FGNzRPRE96aUtXVW1GWFg1ZnFoVTFKdVRNRlQxQUtPS3px?=
 =?utf-8?B?V0JUVVZuTUdESEhlMXJ3YitSN2piaEtjUGY1enBUZys2ME5ud083MW16VnZ4?=
 =?utf-8?B?THVlQVlVZ0s1U0Zob1J1WkFiVXprR0xLSE9MY3RxOE5VWlZZWTBoeWkrTXJ5?=
 =?utf-8?B?YnZLdVVzeXlETGtoaEhzYXZtZ1hMZEFJbjFkckQzZ21SeGJyVjNxb1daVElk?=
 =?utf-8?B?ajQyU3A0K2t1N3FtTlpSUW9sVjJub2JPOWtDSmhsU2FJM0pOQUc2OFVReUY0?=
 =?utf-8?B?TVlZRkJNZ1BxUlNiNHlpcmRNcmdHU1NMMXZhZDRrdXFReERrWUxRQlpGRHd0?=
 =?utf-8?B?bGRCQTgyZHcxMzF4dUNlYU1jbFd2S0tnc205Y2FheHA2NlJFMjFuZDdxQjNH?=
 =?utf-8?B?ZDhRSisxQ2FBN3hLWDg5YU1kU1lMVWI3TFhROXJFYktxOEdKU09XUXdZdVM2?=
 =?utf-8?B?d0wxRURyZktjVkdYdWFaL0l1bUJMSFNHallXSHVtOUJTSkpyU0Z4VThyMTRG?=
 =?utf-8?B?N3FEbUJUM0hYM2JSS1pLMGFpWkZwd1VhN09uTjFWd0dieGc0Kzh6ZGt0TDdS?=
 =?utf-8?B?ZXl4ZGQzZEc4QWZwZVdEK2YwemFyOVJtWlJTM25KMnNxeVgwVmlBMHh6anF5?=
 =?utf-8?B?RWVpUitscWFVYjhueUdNb2JVUWNFcXZscVdXRGRaSUhCekZ3bFRGMGJJSEdO?=
 =?utf-8?B?K3UyOUhCbXRpeEFHKzZTeU9QRmZhQlpJMTVjWXJwVnRUWnlIOG9WeFNkYVZM?=
 =?utf-8?B?YmpmZHoyNFpWdUdJNlNWSktPSkphTFhydXNOMWhVcUtmdERObEpJWGRkQnd5?=
 =?utf-8?B?bW1ScXVWRnpGdXpiZ2hHeTFQQVY3b1puNWhlb3RsVE9RaW1tQTIrbmlvZXFD?=
 =?utf-8?B?YThXT05rejUwK3NWejBTT2VDWlZjakRLaUVrOWc2eERUNXFHVVltd0tBclMv?=
 =?utf-8?B?OG5BNUhzTEVjRHNrRGpyUkFRdGJITi82U3ZWeHV3RUU1Y3FHdFV1Tm5TRi9a?=
 =?utf-8?B?ODV4ODgwSENMbGhqbkZHYTZkY1NMSUJUU3QyeGQrT1ppenJFV0d2aEppYkM5?=
 =?utf-8?B?cWpoay9KYlpzMlR0d2kvWDB5QWhaajF6M3Z2KzNTRzFoSm94RW41SWI5b2JG?=
 =?utf-8?B?K1A0c05VcGxvcUcrTWR0VkNmbFZRbVowQzB2aFU3UnFCU2ZuamlHbjlkTDVZ?=
 =?utf-8?B?dGMvNE9Uam90U0hzdm9KdkxRV2FzaU03cVJSR1hpcEpDZ05ubkh0dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b3b6b3-18f4-4be2-5aa0-08dee748bec9
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 16:54:35.8411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1TsTYq3T1O8xAlixo6iewnCqsRThCaVYdcgyxy3eC7j7L4xh5bLrgDqpdH0AnyBZ1X2VH9bDmNTBqhzVG1RpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7878

Previously `register!` defined registers can be used on any untyped I/O
regions. With all users specifying their desired register type now,
propagate the specified type and restrict I/O access only when type
matches.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io/register.rs | 111 ++++++++++++++++++---------------------------
 1 file changed, 45 insertions(+), 66 deletions(-)

diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index b0fcfce36c9c..df47c28ba4f4 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -121,10 +121,11 @@
     io::IoLoc, //
 };
 
-use super::Region;
-
 /// Trait implemented by all registers.
 pub trait Register: Sized {
+    /// Base type for this register.
+    type Base: ?Sized;
+
     /// Backing primitive type of the register.
     type Storage: Into<Self> + From<Self>;
 
@@ -139,9 +140,9 @@ pub trait FixedRegister: Register {}
 
 /// Allows `()` to be used as the `location` parameter of [`Io::write`](super::Io::write) when
 /// passing a [`FixedRegister`] value.
-impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for ()
+impl<Base: ?Sized, T> IoLoc<Base, T> for ()
 where
-    T: FixedRegister,
+    T: FixedRegister<Base = Base>,
 {
     type IoType = T::Storage;
 
@@ -153,9 +154,9 @@ fn offset(self) -> usize {
 
 /// A [`FixedRegister`] carries its location in its type. Thus `FixedRegister` values can be used
 /// as an [`IoLoc`].
-impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for T
+impl<Base: ?Sized, T> IoLoc<Base, T> for T
 where
-    T: FixedRegister,
+    T: FixedRegister<Base = Base>,
 {
     type IoType = T::Storage;
 
@@ -178,9 +179,9 @@ pub const fn new() -> Self {
     }
 }
 
-impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for FixedRegisterLoc<T>
+impl<Base: ?Sized, T> IoLoc<Base, T> for FixedRegisterLoc<T>
 where
-    T: FixedRegister,
+    T: FixedRegister<Base = Base>,
 {
     type IoType = T::Storage;
 
@@ -249,9 +250,9 @@ const fn offset(self) -> usize {
     }
 }
 
-impl<const SIZE: usize, T, B> IoLoc<Region<SIZE>, T> for RelativeRegisterLoc<T, B>
+impl<SuperBase: ?Sized, T, B> IoLoc<SuperBase, T> for RelativeRegisterLoc<T, B>
 where
-    T: RelativeRegister,
+    T: RelativeRegister<Base = SuperBase>,
     B: RegisterBase<T::BaseFamily> + ?Sized,
 {
     type IoType = T::Storage;
@@ -293,9 +294,9 @@ pub fn try_new(idx: usize) -> Option<Self> {
     }
 }
 
-impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for RegisterArrayLoc<T>
+impl<Base: ?Sized, T> IoLoc<Base, T> for RegisterArrayLoc<T>
 where
-    T: RegisterArray,
+    T: RegisterArray<Base = Base>,
 {
     type IoType = T::Storage;
 
@@ -380,9 +381,9 @@ pub fn try_at(self, idx: usize) -> Option<RelativeRegisterArrayLoc<T, B>> {
     }
 }
 
-impl<const SIZE: usize, T, B> IoLoc<Region<SIZE>, T> for RelativeRegisterArrayLoc<T, B>
+impl<SuperBase: ?Sized, T, B> IoLoc<SuperBase, T> for RelativeRegisterArrayLoc<T, B>
 where
-    T: RelativeRegisterArray,
+    T: RelativeRegisterArray<Base = SuperBase>,
     B: RegisterBase<T::BaseFamily> + ?Sized,
 {
     type IoType = T::Storage;
@@ -408,9 +409,9 @@ pub trait LocatedRegister<Base: ?Sized> {
     fn into_io_op(self) -> (Self::Location, Self::Value);
 }
 
-impl<const SIZE: usize, T> LocatedRegister<Region<SIZE>> for T
+impl<Base: ?Sized, T> LocatedRegister<Base> for T
 where
-    T: FixedRegister,
+    T: FixedRegister<Base = Base>,
 {
     type Location = FixedRegisterLoc<Self::Value>;
     type Value = T;
@@ -850,37 +851,10 @@ macro_rules! register {
                 $(=> $alias:ident $(+ $alias_offset:ident)? $([$alias_idx:expr])? )?
             { $($fields:tt)* }
         )*
-    ) => {
-        const _: () = {
-            #[allow(unused)]
-            fn test_base(_: &$reg_base) {}
-        };
-
-        $(
-        $crate::register!(
-            @reg $(#[$attr])* $vis $name ($storage) $([$size $(, stride = $stride)?])?
-                $(@ $($base +)? $offset)?
-                $(=> $alias $(+ $alias_offset)? $([$alias_idx])? )?
-            { $($fields)* }
-        );
-        )*
-    };
-
-    // Entry point for the macro, allowing multiple registers to be defined in one call.
-    // It matches all possible register declaration patterns to dispatch them to corresponding
-    // `@reg` rule that defines a single register.
-    (
-        $(
-            $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
-                $([ $size:expr $(, stride = $stride:expr)? ])?
-                $(@ $($base:ident +)? $offset:literal)?
-                $(=> $alias:ident $(+ $alias_offset:ident)? $([$alias_idx:expr])? )?
-            { $($fields:tt)* }
-        )*
     ) => {
         $(
         $crate::register!(
-            @reg $(#[$attr])* $vis $name ($storage) $([$size $(, stride = $stride)?])?
+            @reg [$reg_base] $(#[$attr])* $vis $name ($storage) $([$size $(, stride = $stride)?])?
                 $(@ $($base +)? $offset)?
                 $(=> $alias $(+ $alias_offset)? $([$alias_idx])? )?
             { $($fields)* }
@@ -892,22 +866,22 @@ fn test_base(_: &$reg_base) {}
 
     // Creates a register at a fixed offset of the MMIO space.
     (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) @ $offset:literal
+        @reg [$reg_base:ty] $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) @ $offset:literal
             { $($fields:tt)* }
     ) => {
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(@io_base $name($storage) @ $offset);
+        $crate::register!(@io_base [$reg_base] $name($storage) @ $offset);
         $crate::register!(@io_fixed $(#[$attr])* $vis $name($storage));
     };
 
     // Creates an alias register of fixed offset register `alias` with its own fields.
     (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) => $alias:ident
+        @reg [$reg_base:ty] $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) => $alias:ident
             { $($fields:tt)* }
     ) => {
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
         $crate::register!(
-            @io_base $name($storage) @
+            @io_base [$reg_base] $name($storage) @
             <$alias as $crate::io::register::Register>::OFFSET
         );
         $crate::register!(@io_fixed $(#[$attr])* $vis $name($storage));
@@ -915,44 +889,47 @@ fn test_base(_: &$reg_base) {}
 
     // Creates a register at a relative offset from a base address provider.
     (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) @ $base:ident + $offset:literal
+        @reg [$reg_base:ty]
+            $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) @ $base:ident + $offset:literal
             { $($fields:tt)* }
     ) => {
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(@io_base $name($storage) @ $offset);
+        $crate::register!(@io_base [$reg_base] $name($storage) @ $offset);
         $crate::register!(@io_relative $vis $name($storage) @ $base);
     };
 
     // Creates an alias register of relative offset register `alias` with its own fields.
     (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) => $base:ident + $alias:ident
+        @reg [$reg_base:ty]
+            $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) => $base:ident + $alias:ident
             { $($fields:tt)* }
     ) => {
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(
-            @io_base $name($storage) @ <$alias as $crate::io::register::Register>::OFFSET
+        $crate::register!(@io_base [$reg_base]
+            $name($storage) @ <$alias as $crate::io::register::Register>::OFFSET
         );
         $crate::register!(@io_relative $vis $name($storage) @ $base);
     };
 
     // Creates an array of registers at a fixed offset of the MMIO space.
     (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
+        @reg [$reg_base:ty] $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
             [ $size:expr, stride = $stride:expr ] @ $offset:literal { $($fields:tt)* }
     ) => {
         $crate::build_assert::static_assert!(::core::mem::size_of::<$storage>() <= $stride);
 
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(@io_base $name($storage) @ $offset);
+        $crate::register!(@io_base [$reg_base] $name($storage) @ $offset);
         $crate::register!(@io_array $vis $name($storage) [ $size, stride = $stride ]);
     };
 
     // Shortcut for contiguous array of registers (stride == size of element).
     (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) [ $size:expr ] @ $offset:literal
+        @reg [$reg_base:ty]
+            $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) [ $size:expr ] @ $offset:literal
             { $($fields:tt)* }
     ) => {
-        $crate::register!(
+        $crate::register!(@reg [$reg_base]
             $(#[$attr])* $vis $name($storage) [ $size, stride = ::core::mem::size_of::<$storage>() ]
                 @ $offset { $($fields)* }
         );
@@ -960,7 +937,8 @@ fn test_base(_: &$reg_base) {}
 
     // Creates an alias of register `idx` of array of registers `alias` with its own fields.
     (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) => $alias:ident [ $idx:expr ]
+        @reg [$reg_base:ty]
+            $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) => $alias:ident [ $idx:expr ]
             { $($fields:tt)* }
     ) => {
         $crate::build_assert::static_assert!(
@@ -969,7 +947,7 @@ fn test_base(_: &$reg_base) {}
 
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
         $crate::register!(
-            @io_base $name($storage) @
+            @io_base [$reg_base] $name($storage) @
             <$alias as $crate::io::register::Register>::OFFSET
                 + $idx * <$alias as $crate::io::register::RegisterArray>::STRIDE
         );
@@ -978,14 +956,14 @@ fn test_base(_: &$reg_base) {}
 
     // Creates an array of registers at a relative offset from a base address provider.
     (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
+        @reg [$reg_base:ty] $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
             [ $size:expr, stride = $stride:expr ]
             @ $base:ident + $offset:literal { $($fields:tt)* }
     ) => {
         $crate::build_assert::static_assert!(::core::mem::size_of::<$storage>() <= $stride);
 
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(@io_base $name($storage) @ $offset);
+        $crate::register!(@io_base [$reg_base] $name($storage) @ $offset);
         $crate::register!(
             @io_relative_array $vis $name($storage) [ $size, stride = $stride ] @ $base + $offset
         );
@@ -993,10 +971,10 @@ fn test_base(_: &$reg_base) {}
 
     // Shortcut for contiguous array of relative registers (stride == size of element).
     (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) [ $size:expr ]
+        @reg [$reg_base:ty] $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) [ $size:expr ]
             @ $base:ident + $offset:literal { $($fields:tt)* }
     ) => {
-        $crate::register!(
+        $crate::register!(@reg [$reg_base]
             $(#[$attr])* $vis $name($storage) [ $size, stride = ::core::mem::size_of::<$storage>() ]
                 @ $base + $offset { $($fields)* }
         );
@@ -1005,7 +983,7 @@ fn test_base(_: &$reg_base) {}
     // Creates an alias of register `idx` of relative array of registers `alias` with its own
     // fields.
     (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
+        @reg [$reg_base:ty] $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
             => $base:ident + $alias:ident [ $idx:expr ] { $($fields:tt)* }
     ) => {
         $crate::build_assert::static_assert!(
@@ -1014,7 +992,7 @@ fn test_base(_: &$reg_base) {}
 
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
         $crate::register!(
-            @io_base $name($storage) @
+            @io_base [$reg_base] $name($storage) @
                 <$alias as $crate::io::register::Register>::OFFSET +
                 $idx * <$alias as $crate::io::register::RegisterArray>::STRIDE
         );
@@ -1035,8 +1013,9 @@ fn test_base(_: &$reg_base) {}
     };
 
     // Implementations shared by all registers types.
-    (@io_base $name:ident($storage:ty) @ $offset:expr) => {
+    (@io_base [$reg_base:ty] $name:ident($storage:ty) @ $offset:expr) => {
         impl $crate::io::register::Register for $name {
+            type Base = $reg_base;
             type Storage = $storage;
 
             const OFFSET: usize = $offset;

-- 
2.54.0

