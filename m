Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021101.outbound.protection.outlook.com [52.101.95.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EF648EBC1;
	Wed,  5 Aug 2026 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947853; cv=fail; b=FqxFMAjWPhj0t6kJzpEPLyZBJNOVblwBzq1rmdH+27LAWYMhV9kXR2y4ZbcaBig+CVeFPJtCqn6tp0UsjxwUe7NkTwhGOG6GTdLPyLwxahODHzhmT99PiI0YpTGKF40+gaxfwlIinYnPSk/EXY7xIjg5iz4FxmsUkIY5EHOwT90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947853; c=relaxed/simple;
	bh=p13WzdC2A1rGj72lh5bQ22cWnQWa7BH0yxfz654p6CE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=M2GIN+zg/6/zJiqu2nSxj/kHY7SXyrPl4agD69bOITIotKNM0xyoLNezYcpHFNoEwL0CAB5pjpwJVK3eA1ZbrDgJxYDxyyh2oMRfcG1V7nmpw/W5QmBXKISfD3lUK9oufQBHfeRE9xt41ExXWhWwsIFmmw/1OTnMBqiA/SxOAWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Ky3d2OFC; arc=fail smtp.client-ip=52.101.95.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Ky3d2OFC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VuOvIRIjTJBwFK/HU3Qi+KD5TUK/KBudxFQHiuiF+Ckx347d+scyhno1TGGzT7588lf191uGzcU/aqzo27M/6j3a9TtZxXZlI/LUUt+TE3cCgYKkrNnQwYaRqaN6MGPxaaJxOGw2+3O9f9UCtdVP6THUQvlNOUI4ihvdSCr20REaZVanizGUiTtA6e3s8Wezr7lJNQDaoch+8uuFroaeBm3pZt76yfzntbHcyUc66Odw2R1oJYrt9n+qmg9xLc3cgfrnMVngIMp0zWBPV6DGia8ycwii+eCPa2sbOJEubl38QCGcFpRVMB/8FkZwJQ3veAxSA5tPgO15YrMRyXgHYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4zGmAeiy+AGAGCbR+jYSkIZifHZDji7ckyLq5/X0sg=;
 b=Vb8+vBcIQlXhYacjHODOYqmMJXGd7C3L+G867NIiBws9WQ6nz37kwzrpX6EBsWCkFYDAK9eyIhVnnHAuMOsD/ckxj5KPgP3prmdC70RiW4r0miZ8ERQ7E+lhAmO+jpJiZTYh+k/Cbz4FE0e5ZgAJ5JxHgDEQRM2Zfx1mqpbgYbrojze9aOlm99XmxhWRe1rtDimz+UNAteKO9lxsVOfcPCFcEEQqfAVsOcCSFh9XHldYQ6ig4SbDdIDf8bFv15dQY9/+uTLSqeRYv27TxYcLV7eDZqyOKy4FCSt29RSpGCOrBB3Cx04mgWOchzv97CasCJVnISS/RCeKDUvaBz1HRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4zGmAeiy+AGAGCbR+jYSkIZifHZDji7ckyLq5/X0sg=;
 b=Ky3d2OFCwkEE2Fy9rxPIS9zq938HmN3YvyLZ5NW/uF3Jixw15ALUTQJIc5BNTS5btASdiWYzZHWUOyvW1GALsBLyZc1lId9+iV6ghU7kALa/VCi2sJDScwsGWuKMHeQeX1eXxm0PhJY79nB+RXMRt5KfNVTPBMKQyCr6ExN2DF4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by CWLP265MB3412.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:ea::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 16:37:09 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 16:37:09 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 05 Aug 2026 17:35:58 +0100
Subject: [PATCH v2 15/16] rust: io: register: remove `Register` trait and
 cleanup macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-typed_register-v2-15-c3ca142220a0@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785947819; l=6756;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=p13WzdC2A1rGj72lh5bQ22cWnQWa7BH0yxfz654p6CE=;
 b=7Hu54Crzl8xfpC5zmFQa9DbbgK9ENlBAsnKYZdeSYa1tRYDnc+Pb9v/V9Bg2ntDD/Jp9iEsvs
 3H+t30CpGo1C24ryXiz2wXAfgglUG8W1ONulQb2ST8AAS/curZmYsLo
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
X-MS-TrafficTypeDiagnostic: LOZP265MB8551:EE_|CWLP265MB3412:EE_
X-MS-Office365-Filtering-Correlation-Id: b05c025c-776b-49c3-107e-08def30fcb3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|23010399003|376014|22082099003|18002099003|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	dkuQ0dMXuwLbkpkfVpDwGn3+ZQVhw5cKeD5eeKfAqjSkzagtgCjj0AskVDf4KkEIkpHlpaV8Y3N+CKxfL42JtPp9lvaNnqzGLIFOj73t9EhX1jAwDUk6lO0Vck90FxIiZo4e9MbyWbTbRk63LWY3jfVHn+8VV26LWdHGcvD6jlF6z/ceLMVGI7jIiB8T9dkjxh/w9K5sDS6oMOwOUJUcclmSW62BSTNj7U5g+/MUUBxtd+V8NKFi/Lne0LBK0LrCRmTnB86MhNIerf+HNn5Ym+SgexzR748voY1N0KwW4EvKadYwG/beZXTp9qV4KQgBpeMTM4RDQfKccnXRdn1LQ46aZpimQTp7TTqZIooj+WlhS7v/g0ugJLJQn3iKLz9wq5uBg0iDdugApGhcFNHIRJ1EMR4khyOEPkljZW97Z7/B+oNI68c82pAqz5vVCf5XyXss5BhwI7q7CxleTgflqpxzRc40UcDZMFRagTwM8E/8Br/1iFVfkSHI5xD/74qzmi+ZkntvRCgME2AmDkKVnfM+iDu6C2n/LgC74nJcw60F/MgUpXbXz2fxSS/EALEk4Gx4HVQl4V+E+91cmBLs8+bMPwuhvg/fe7A0Xdbwrz7pPf7rXLhNcWqm3WGVj7l5S9DRXxrkQ7Mae3q2ryW31BpW+mBhXA8ysSnpIUfkRDs/qR43PBlkRcoZConw1GD0lezVuZFdq7SKRx9ZOSX99Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUt4NXc0a0lPa3haWXI4TUN2aU1NbHhFNyszRnMvc3dQVkhrTnpqNGc2V0p0?=
 =?utf-8?B?b1pqdDdCdXd6L2lwNE04bDBSNzNsZDRWeFFrMnYwbmlrQWUwckI3MXVwQ05u?=
 =?utf-8?B?QkhXMStQcmwvMStoWTZLK0pYQ2I1Uk8xN1BoQ1l6Mk9jcVF5VWNlSHUxcTZ4?=
 =?utf-8?B?Tm9WVlZXNCtlMmRsY2NCVzZyOWJpR1EveUVER3dnTXByMGpoTTJTYlVxdGpZ?=
 =?utf-8?B?QkVwWXdlaFRaNncyQ1FOVURhWHlKcXduRFFkWFVKdlgvbkNjOUdySWRKWGd2?=
 =?utf-8?B?R3IvTUlaYlhnOWVOdTVZdkJSaG1PT01ZN1c5ajNxMGJlOWdmb1lXVkhmTFNa?=
 =?utf-8?B?dHNneE1JemhyYU5qRDF4UEJZNXp4bjM0ZlZIanVWcEUvWktkSjFQRzF1YVhs?=
 =?utf-8?B?ZjdXOG9TOFhFOEJ4TXYxUFBjV0IvUUdIZGNXd1U5MmFuVzU1ZXF4MmUza3Z4?=
 =?utf-8?B?WXhoWDJMU0I1RStUMkQxZ1BlZndZVThvdzNjOG96NnlhMDdpeTh2c2ZsVXhJ?=
 =?utf-8?B?RmVVb2dyeTNSMTNvRnUxVUVPT2tMSmM3aVZ1S2lqRm9NSWlaUDZzdi9IQndL?=
 =?utf-8?B?RWYxTkdBbjU2RTdpd254UVdJQ0d6RWhwSFhvSTg0OC9kdmcvejNxLzBDNEdR?=
 =?utf-8?B?VUp2UUI4WlE0QlUzZ1dNNDJGc2dKVUhROXl6YWF0ZGNWcFZrbW9Na1h5VUhv?=
 =?utf-8?B?WlR2V1cwYVNQSENNUGhQVGUwVUQ0S1l0cmwwVDVVeHNnc0pDZDZlYnd2cC9F?=
 =?utf-8?B?TXhCSW1HcUMxdkFEK1NubzRDZ09aTEIvT2NMUURFdWxjbEFQcXFFRE1YclVn?=
 =?utf-8?B?R1Q1a0kxWVdGUTNHaHJWRzVBdDNPWUNWcWRDUVhJV1drVE1vOTkxQWNOZEI2?=
 =?utf-8?B?Ynh5ekREMlllUGZibUhYQVdJSFk0cjdISVM2bDJydkNJRDFvTjFYWlJ3anFR?=
 =?utf-8?B?aDIyR0FWTUF2b2lFbDY5T3FCbVNWYkJkREl0QlZHSDNzbVgyeDVsTFR3aWRF?=
 =?utf-8?B?ZUoyMW92Vi9uRXVSWS9hbTlOTlFkOVRoL3RMMlRySXVoUFNHTE80UzFpSnFH?=
 =?utf-8?B?enlnL1dUSUhxZitsWWk1YkZwQzhta0ViTkZXUHdiaDYrODBoa08raklsQm4x?=
 =?utf-8?B?UkpDQUtUa3NJSFR1U09SaEVIS2NJQjdHV2ZOVUludjkxNzZqUGNCeDhRNFpj?=
 =?utf-8?B?Z09sSUhpbHIwZmhueHZucHdQbFY2MGIvRThDLzNWd0czdXF2MHdnT2F4M005?=
 =?utf-8?B?WWFWSDJYY0Q2UVRxYTJqNllJclRPMzRKa3ZZRmg3RXVRZHFxQk0wTlU5R0tG?=
 =?utf-8?B?QkdsV3V2eTl2WUVrVFBXT215RDF2TFVaN2dWOWVvRXZiRHpNbnpFTHF0ejVE?=
 =?utf-8?B?aGxMTWliN1Q2bFJiY3gra2ZmaGlXd2tmSm5mZlNERTFsdWR4OW9aVUk4bnpR?=
 =?utf-8?B?NTdDRFhaQXB1a0drM0lQdy9oclFVdmp3a2Zsa1RtcTBaNHJiVkY2US9uQlo0?=
 =?utf-8?B?cjZHYWt5M1RPYzJ4NEJ0Y2h3elBmKzQ4TE1aVkZIaFBlTkZ6RHNjOE5jTXhB?=
 =?utf-8?B?anBsYTFIY254Z3BNRnFRSGRpNmtZRnRyUUQ3WW04UXlCN2lUcDVoc1RtRVZQ?=
 =?utf-8?B?eUFjZDNzV0FEZXYrd3hPSG5reCtPWmlybVRGNmJsUmpRN1RsSUUzbHkySnVL?=
 =?utf-8?B?RGlQajQ3aHBTY1dtcW9HcTBFcVFOZHRqVDVocFYxc1lXQXI3blJ5T01BOEJF?=
 =?utf-8?B?RXNpa1I2OXFpY2c1dkJjSW9udEE5SlNhWXJPYUhUK0NaNnJrd0Rzc3JDSlE4?=
 =?utf-8?B?QUMxTVVSWTdPNzFxSW5LT2U1dHppdU4vNEI5TWU1aSsrNlp2bW0vanYwWEY1?=
 =?utf-8?B?SktudGlVcnFycjRISE9BOEZMaTNsbzhEbjd3bCttRmV4MXVUQnVGdW1pdGZK?=
 =?utf-8?B?ZlU2SkRRMFdSMlllelRXVHlEL3BRdUZwTm5XK245dXBIRUFGVXV2dHZwWGxs?=
 =?utf-8?B?OFRjd09qbHZmUStvakZOckVSd2Vvb0Z3TEZaUnhOcU1YYU9VTjcrNDNlNGx3?=
 =?utf-8?B?Z3ZpajIwOGhWMS9IK3R3NExxVTJKRXh4aEk0TTZ0V2lRYmRhazZJUGxsdDE3?=
 =?utf-8?B?ZUdQY0ttSXYydGwxcjhjK1VEZGR3YUkrL2dMbmRMS3N4Qld4NTRua3FtQTFN?=
 =?utf-8?B?d0VnT3lMa1hsM2F3WnIxU2xTUTNaTEN2QzEwdnBtMU9zY0ZIMmU3blFjcUY2?=
 =?utf-8?B?RUdZRlhKM0xUNWk3NGhZNlp4MWZjUjhMSnFsUm9RMGFyUVB2czl6ckFlMFho?=
 =?utf-8?B?NkhHUWtrTmRRd0xQRmhqNFpDVDlXaGxXQm01NkExNmh3WDBLeVYzUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b05c025c-776b-49c3-107e-08def30fcb3b
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 16:37:09.3939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0UjhqpDbMJZ8DQhbKU4bVx9oR+fW7ATmF23WLCrgHT4WScefQ5gYRG8u5Yo0PulG4YiJk+MYaYjYxSjVGMeMgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3412

With the removal of relative registers, there are only two type of
registers left, fixed register and register arrays. There is not much
benefit in having a common super trait for them anymore, thus remove it,
and cleanup the macro rules associated with it.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io/register.rs | 102 +++++++++++++++++++--------------------------
 1 file changed, 43 insertions(+), 59 deletions(-)

diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index 295b06dd53a7..fe0e6763a600 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -121,8 +121,8 @@
     io::IoLoc, //
 };
 
-/// Trait implemented by all registers.
-pub trait Register: Sized {
+/// Trait implemented by registers with a fixed offset.
+pub trait FixedRegister: Sized {
     /// Base type for this register.
     type Base: ?Sized;
 
@@ -132,9 +132,6 @@ pub trait Register: Sized {
     const OFFSET: usize;
 }
 
-/// Trait implemented by registers with a fixed offset.
-pub trait FixedRegister: Register {}
-
 /// Allows `()` to be used as the `location` parameter of [`Io::write`](super::Io::write) when
 /// passing a [`FixedRegister`] value.
 impl<Base: ?Sized, T> IoLoc<Base, T> for ()
@@ -200,7 +197,14 @@ fn offset(self) -> usize {
 }
 
 /// Trait implemented by arrays of registers.
-pub trait RegisterArray: Register {
+pub trait RegisterArray: Sized {
+    /// Base type for this register.
+    type Base: ?Sized;
+
+    /// Start offset of the register.
+    ///
+    /// The interpretation of this offset depends on the type of the register.
+    const OFFSET: usize;
     /// Number of elements in the registers array.
     const SIZE: usize;
     /// Number of bytes between the start of elements in the registers array.
@@ -266,8 +270,8 @@ fn try_at(idx: usize) -> Option<RegisterArrayLoc<Self>>
 ///
 /// Implementors can be used with [`Io::write_reg`](super::Io::write_reg).
 pub trait LocatedRegister<Base: ?Sized> {
-    /// Register value to write.
-    type Value: Register;
+    /// Value to write.
+    type Value;
     /// Full location information at which to write the value.
     type Location: IoLoc<Base, Self::Value>;
 
@@ -601,11 +605,22 @@ macro_rules! register {
         { $($fields:tt)* }
         $($rest:tt)*
     ) => {
-        $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(@io_base $reg_base; $name
-            @ $crate::register!(@offset $(@ $offset)? $(=> $alias $([$alias_idx])?)?)
+        $crate::bitfield!(
+            #[allow(non_camel_case_types)]
+            $(#[$attr])* $vis struct $name($storage) { $($fields)* }
         );
-        $crate::register!(@io_fixed $(#[$attr])* $vis $name);
+
+        impl $crate::io::register::FixedRegister for $name {
+            type Base = $reg_base;
+
+            const OFFSET: usize =
+                $crate::register!(@offset $(@ $offset)? $(=> $alias $([$alias_idx])?)?);
+        }
+
+        $(#[$attr])*
+        $vis const $name: $crate::io::register::FixedRegisterLoc<$name> =
+            $crate::io::register::FixedRegisterLoc::<$name>::new();
+
         $crate::register!(base: $reg_base; $($rest)*);
     };
 
@@ -615,39 +630,36 @@ macro_rules! register {
         $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
             [ $size:expr $(, stride = $stride:expr)? ] @ $offset:literal { $($fields:tt)* }
         $($rest:tt)*
-    ) => {
-        $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(@io_base $reg_base; $name @ $offset);
-        $crate::register!(@io_array $vis $name
-            [ $size, stride = $crate::register!(@stride $storage $(, $stride)?) ]
-        );
-        $crate::register!(base: $reg_base; $($rest)*);
-    };
-
-    // All the rules below are private helpers.
-
-    // Generates the bitfield for the register.
-    //
-    // `#[allow(non_camel_case_types)]` is added since register names typically use
-    // `SCREAMING_CASE`.
-    (
-        @bitfield $(#[$attr:meta])* $vis:vis struct $name:ident($storage:ty) { $($fields:tt)* }
     ) => {
         $crate::bitfield!(
             #[allow(non_camel_case_types)]
             $(#[$attr])* $vis struct $name($storage) { $($fields)* }
         );
+
+        impl $crate::io::register::Array for $name {}
+
+        impl $crate::io::register::RegisterArray for $name {
+            type Base = $reg_base;
+
+            const OFFSET: usize = $offset;
+            const SIZE: usize = $size;
+            const STRIDE: usize = $crate::register!(@stride $storage $(, $stride)?);
+        }
+
+        $crate::register!(base: $reg_base; $($rest)*);
     };
 
+    // All the rules below are private helpers.
+
     // Offset computation helper rules.
     (@offset @ $offset:expr) => { $offset };
-    (@offset => $alias:path) => { <$alias as $crate::io::register::Register>::OFFSET };
+    (@offset => $alias:path) => { <$alias as $crate::io::register::FixedRegister>::OFFSET };
     (@offset => $alias:path [$idx:expr]) => {{
         $crate::build_assert::static_assert!(
             $idx < <$alias as $crate::io::register::RegisterArray>::SIZE
         );
 
-        <$alias as $crate::io::register::Register>::OFFSET +
+        <$alias as $crate::io::register::RegisterArray>::OFFSET +
             $idx * <$alias as $crate::io::register::RegisterArray>::STRIDE
     }};
 
@@ -657,32 +669,4 @@ macro_rules! register {
         $stride
     }};
     (@stride $ty: ty) => { ::core::mem::size_of::<$ty>() };
-
-    // Implementations shared by all registers types.
-    (@io_base $reg_base:ty; $name:ident @ $offset:expr) => {
-        impl $crate::io::register::Register for $name {
-            type Base = $reg_base;
-
-            const OFFSET: usize = $offset;
-        }
-    };
-
-    // Implementations of fixed registers.
-    (@io_fixed $(#[$attr:meta])* $vis:vis $name:ident) => {
-        impl $crate::io::register::FixedRegister for $name {}
-
-        $(#[$attr])*
-        $vis const $name: $crate::io::register::FixedRegisterLoc<$name> =
-            $crate::io::register::FixedRegisterLoc::<$name>::new();
-    };
-
-    // Implementations of register arrays.
-    (@io_array $vis:vis $name:ident [ $size:expr, stride = $stride:expr ]) => {
-        impl $crate::io::register::Array for $name {}
-
-        impl $crate::io::register::RegisterArray for $name {
-            const SIZE: usize = $size;
-            const STRIDE: usize = $stride;
-        }
-    };
 }

-- 
2.54.0

