Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020105.outbound.protection.outlook.com [52.101.195.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9934848CD57;
	Tue,  1 Sep 2026 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281459; cv=fail; b=dO+z4VbjGPXnVrennIcJ/2QqdIFA0m1jkxEn/XmZqj1Ycs3RP8kTnxKEfl8Qr0kMCUXaUAN34CnBQl3Kp7/nasQ+ttdelusIogVfHcu2OSosoMak1JPKxwX1KVyD/DbR6BzlYujzpmF9ilMHgsVad0EpHG2EgYrYkOt1uPciqBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281459; c=relaxed/simple;
	bh=WYaIyKcKO7QIC+sRD6g+xJ/UsiWjwb+9Ba3XtN9t9SA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qJDGP95YEecJDfSx99S1S3ntpA25rjCtagVl0JhBtxzANKOcLcENP5SULHwTnCxK6Kx/dx5mB038Padxbw//37ynTSQ6EjBAQLT5swM8aDkhQl7CeVBt1HqLbgzGdi9ZV7Ze8xXTh7jA1AZcOXXt36p2xak+uHrj1p4SjY1z1HM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=DDSRe6hF; arc=fail smtp.client-ip=52.101.195.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="DDSRe6hF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ci+4wYXnK7YWsGF+WFBeF2HrzlkTxy/XoncFzOX0saPdS+jXm7+/+W6W6lj8WMxotO+z7pm+zuAZkOpxlc/8Otgg4+2H0QUF9RV8qXejhdnYJwHufxuRN29Wj9R1Jf0EgIwZGsoL/8bld2/efxImoE4AzaWYevc6uw/B7XQkQJekOY0IVpo/Cp0jpIYlfXtEr7sdCl+ys7FyEJuami1oH/c4rZO5engBD8jqPChqu++m02V0SWu9ErN1s9TDLuvUQ7xJvmjy5ztyiQMWBvj2QN7lQAkBBJK0WzliIgDscGlCMRS4zJL/EhtHAwZqB1o/TUz5OIR7wk4h+vi41DZpJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5e3CEs1asxsaI1dtRmvhvQTfPV88eNjosHxKRSKS2c=;
 b=U1asrZq19OxchenynooGAXKnlhdBN/7tLlXTBWuYg6MictZ8e0GZpeq2SGeAEMNb35N098wwLz/faMy924F0ByjgJiB3HRm1wbGGYObZPKhR9qhrvZ3n98F3/qDm+nXmXloDIQzy5ntUVnDTEZNsSLFMsPhVqeUcp5YjqxQicXcUZ5j61dT1rHk//lI2x091CL/ytIprjIDbn+DqOZAreoXOFfY9RqcBD1mtlJaWYNWmn7ED+YSMlk/n3w49W3BM9NahxzoUxWyF6vqblNPzMq3S4RIub7Sp9fnP1sdlobFhF1cDZrqERQaNGmY8zLdjQtocSZY+xXPfbtltnk5tJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5e3CEs1asxsaI1dtRmvhvQTfPV88eNjosHxKRSKS2c=;
 b=DDSRe6hFyY6gnulNm4+fLrDuaVTLrXfyi9ZGm98sYhOM2MJncZiy9zcieVcQCVTV5QI0CH41uYJx4HRS8+VEP64IMzu3Bve1eBpYuQFdw9kclU4acnw2J/eqUp0mTLmElwdEXLXF5fXgKSFTocNfJ3ya+HOzcRFbGRPWI4keUrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CW1P265MB9199.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 16:50:45 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 16:50:45 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 01 Sep 2026 17:50:39 +0100
Subject: [PATCH v4 15/16] rust: io: register: remove `Register` trait and
 cleanup macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-typed_register-v4-15-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
In-Reply-To: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788281431; l=4357;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=WYaIyKcKO7QIC+sRD6g+xJ/UsiWjwb+9Ba3XtN9t9SA=;
 b=kQ1Ppeib3fjkA+kvY3Yh93wcYlMXX6Hu6J3xokdF8eyxYx1xvwXCaMpVBCG69W4fKhKNCnAbB
 3Cl66orN8enD1SnFWXqtWzXdSGlwshOGyT2CtHd1NiYEoc8f/mBJs/1
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: PAZP264CA0173.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:236::16) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CW1P265MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: 5708527c-148e-4ece-12a3-08df08492af6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|10070799003|376014|23010399003|366016|921020|3023799007|10067099003|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bzcs8I6o8nzyCxAzCCYJwrYnpTncf/gYht+PPdfN9a0lBWTqaNJYq423zyu2yr0KdnrF7pupQdBESvCxjhaHO7zHoDUncjkzNLIFdmLSpbZKRMToFIfcOo3OdwCS7wP4Z0Jr0wlFXKgLlp+nghey5u7DFfP6sWVS50X6XIXyLptev9jgbdAlQOwOhXHCUUtPSMcIVX9glMiCPTuKDiFmzssfmPSpcuZ+BnHChA5JKBXcjV9M/2VXgD0IqvapUqWnR6wi9EsJx0HaHBHzovNtHBTdeyVkfmNBjj9ZVE/cAjArwXGF/YzCeqdIxeKjEuqgYORi+Y9Diq11hSB0uWWOcli+m6ZJ2kyfK5DDEdCGJQR17ZcPb/RAVcgEnNH9A/fcOAicacO+/Y2F+q6jmt2lGB9x9p7V1nl7IgmSd8dyggA5449cKMXOuKi5+14uNtDm8pC+fjUJxXWpPlCxPiaeCZqa81fwHBYTZLPX1caH7DBFq7fnBlJMGgwhFpDMCFC9uJ1rZZOnVJn5/VF377BF3XUwLeuQwPui5TedmSXltGPE83S+npmD/iUb5MpruVC6/UOmnAz0FxHhbzWlepdIUGQLqeuXsjj4Ffe9eAgb+oSUTCu37VXhuI0Aa1v95+7wVI1FuIndq95I/jZlb3wWu+H94qrpcWdCG8OfRGx4dkUBeF0u1hkK8OeYe/skUsedKI/WPry1JbCZpQV731fKzQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(10070799003)(376014)(23010399003)(366016)(921020)(3023799007)(10067099003)(56012099006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amx6YVBPWWp6SmFjUjNTT1FaTlV2Uit1dnVZNlpjTnBvMlNvZENOcG95aUxk?=
 =?utf-8?B?YkpwUytHS0RSeGR6U0Q3anhOZDZRV1Vjd0ZOaWhrZXNZOXlJMDFVTURpcEZJ?=
 =?utf-8?B?cGpEWllTYzM4SmJmNWVBT2M0d01vNExneXQzZXB3QUFSc0p2RG51WGVOR0Ft?=
 =?utf-8?B?WU8vaFp1VVpzUExjTitXZzY5elBRYmJqOTNkbzU2Wk5FTXBaRFBPdmZuTHhs?=
 =?utf-8?B?cE1jWkVJeTg1SjAyaURGSDQ2WldJUEUwT005dVBDTmFLUytFdUd6aU1QQ0dD?=
 =?utf-8?B?bER2S2lIbStYeDZhTm1VOWUxYmlqR21mUG0xY2RCUkJVQ0N5MXpqN1IzWkJ4?=
 =?utf-8?B?MFh0Vmdpd2hSQjB0UzdXOVM3Qzlpa29hQUttZzZzRWRVWEFUaWgyWDUxUnpP?=
 =?utf-8?B?V1Y1dFpPYktrUHg1NlE5RmFWOWhxU3czbEpFUDN2dW12Tldoa2tBNzVhYTVo?=
 =?utf-8?B?SWFhc1EydFRSQlpZVUt6c0dtVXNwc1ZLSmdkaFZUUkliOHBUVGFiOXZTUGFU?=
 =?utf-8?B?WkJxc08yM3hUR1N6VEEzVGZxQVJBSXpnempvTHBYd3orYjNUQWVTdlBnakhs?=
 =?utf-8?B?MDhXV0cwOGpySm5zQktTZXZ2K2ZaUVVXekhjMGxINFhBemovRTJRTlZWdEJa?=
 =?utf-8?B?M1Z1S1lTQlQydzgzdEdTVHpPbk5BbS9ZU1gvb1IxRDlPaFNUSUVRZlBiYlpn?=
 =?utf-8?B?c1c0bVB4eVFIbGlwSWxPZDNMQWtzOUdybUpYQ0JjRi9FU3kyaTNRMVpNbzFm?=
 =?utf-8?B?Sm5QQW1vSkVib2dWWGdXMnJuWUlpYmp5UW5iN3FwKzdIU2RoN1dyOHhvQys2?=
 =?utf-8?B?MjVMT1gwN0tqSU9NV3ZwSVg1S281aERBcXA2NkQrWUErYmtuY09EUTZSamVk?=
 =?utf-8?B?SlJ1MjMwMjJSenpGdVhNQlR3U3JURlRrdGo1SDBkY3hzTGNRT000aTNtalgr?=
 =?utf-8?B?VlVTb1BGUDVwZEJkc2hpbDdKUnV2YUxsYmF1d0pDNzI1b3JpR3lrTHcxT0Vi?=
 =?utf-8?B?dVUwVStZOWFTNmQxb1ladlBQZXQydGQxUFBvSjhiaEVVb0ZOYkcxeFUwYXFE?=
 =?utf-8?B?bE01K3F3VnMxRnpkT25yR1hMQm12YUZicTJ2Y3Y0SWlnR1BVN3pnS0ljL1Zk?=
 =?utf-8?B?clAyTUZWK3ZURTZWZ3RQdm83Q21EeWJrUlhXNTNiN0hmT3N3bldLcUVNcWJJ?=
 =?utf-8?B?SzNOZndndlg5RjdTL0F4dVhTVVBZQ1NpaHptOGVJcGNTZTJUYURyRjVyU3RZ?=
 =?utf-8?B?enV2emdjMXZRVnk4Q3JVOEVzQkNkdkgrUFM0NnhNZ2Q4QkN6YU9iVkdBdHly?=
 =?utf-8?B?S0FtRW9MSlljR0YycmNyRGZ2c3d6RWVrUzF4MGxubUx4T0RHNVZPT0k0SU1F?=
 =?utf-8?B?UUVwSzJ0QmJnaCtTZnl2WFNRK1dxZWpsY0FGUGtUcHhDL1dSK2pvb2JBdDVy?=
 =?utf-8?B?YStESEFWNWtJckZXa1ZDaHhGRkhicVo2Z1A1RUw3alZncHU3aEhiSkFvbklt?=
 =?utf-8?B?cFN4TUpmRUJ2TitUY0NPR2lodGRtRWJRSFF6dWptMTJGQVdneE9xUzhEc21L?=
 =?utf-8?B?Slp6cnlyMy9IYkhvd1lJWVZ3eXByZXdxa3VBWkhvbjZwRlExODNIcEJzOUV6?=
 =?utf-8?B?TzVrWmp3QzVTMVZYcGFIRnRLaU9TeS9EM05xbzMrdm5KcUJoVlcyTHB6NFpt?=
 =?utf-8?B?SWJrSVVkRkdScm9RRGE2eEttZEp4enFPVzc5MEF5TmpRSzhNd05CYkZQSW54?=
 =?utf-8?B?TmcvMG5Mc3BVeVJ0QzRUN3ZheDNhUnl4YUxyN2NxM0ZEd3RUazVrYkJrdDRa?=
 =?utf-8?B?YzRlWHA2ZEFoVGxOQ0t1aXBKVktCYWlPOENzVWplNko0M2lTMC93THNKeFJz?=
 =?utf-8?B?TVZYWjE1a2k4UHhaLzhVbElEL2VjakhJL3VrM2FMNmdobHMzaEovcnc4MUhr?=
 =?utf-8?B?bHlNQzU5c3lVSHBEa3BhMVprMW85Zkg2NEN0bFo0NTJlRFpMMXpQU0cvdlNT?=
 =?utf-8?B?R3hrQnF6REhwUlVEMmNkL082WmlUNnEvRGlYRllQNXBXWnQzNVduc0xJeDhp?=
 =?utf-8?B?ZFZCTE0vWGJ5S1ZVNStTN1NKakxjSlZnODI0Wk5EN25OMEtySzAzWnJYamI5?=
 =?utf-8?B?OTdoNEkrUEZZUzZmeVlpUVFLeDBkNDJBQ2lOT1NkcTJiWk1QNThCa1dlaHl1?=
 =?utf-8?B?d0NSdjdLbUJWSWtRU2pGb2szM05iUkpXZk1MemxBVTBFbzE0aWNvTlExLzJr?=
 =?utf-8?B?K0h0RnFwQzRrZi8wWW5uV0JUNlVoeGQ3czg5N1I2OG94NEFNYU9LZmI5emtS?=
 =?utf-8?B?bVZVeVkzby9VWXZYbzlmTGVBY05XL1p1NTVDNDlPNDNaYWtZZE9PZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5708527c-148e-4ece-12a3-08df08492af6
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 16:50:45.7172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0UMo1RlVeCLesUeR7NTmlPwbDPOKHn/e6O2bwvmiCUvkhMQqZYOBdKF9W1Hof32UPZA8FDUETbY6Gcgt9BPaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB9199

With the removal of relative registers, there are only two type of
registers left, fixed register and register arrays. There is not much
benefit in having a common super trait for them anymore, thus remove it,
and cleanup the macro rules associated with it.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io/register.rs | 22 +++++++++++++---------
 rust/macros/io/register.rs | 12 ++++++------
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index 187f28f16614..9df7572aee9d 100644
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
@@ -201,7 +198,14 @@ fn offset(self) -> usize {
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
@@ -267,8 +271,8 @@ fn try_at(idx: usize) -> Option<RegisterArrayLoc<Self>>
 ///
 /// Implementors can be used with [`Io::write_reg`](super::Io::write_reg).
 pub trait LocatedRegister<Base: ?Sized> {
-    /// Register value to write.
-    type Value: Register;
+    /// Value to write.
+    type Value;
     /// Full location information at which to write the value.
     type Location: IoLoc<Base, Self::Value>;
 
@@ -295,7 +299,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 /// This is used to enforce base matching.
 #[doc(hidden)]
 #[inline(always)] // for const eval only
-pub const fn alias_offset<Base: ?Sized, Alias: Register<Base = Base>>() -> usize {
+pub const fn alias_offset<Base: ?Sized, Alias: FixedRegister<Base = Base>>() -> usize {
     Alias::OFFSET
 }
 
diff --git a/rust/macros/io/register.rs b/rust/macros/io/register.rs
index 6da8ba760ab3..7d3160c4873a 100644
--- a/rust/macros/io/register.rs
+++ b/rust/macros/io/register.rs
@@ -225,11 +225,6 @@ pub(crate) fn register(def: RegDef) -> Result<TokenStream> {
                     #[allow(non_camel_case_types)]
                     #(#attrs)* #vis struct #name(#storage) #args
                 );
-
-                impl ::kernel::io::register::Register for #name {
-                    type Base = #base;
-                    const OFFSET: usize = #offset;
-                }
             ));
         }
 
@@ -245,7 +240,10 @@ impl ::kernel::io::register::Register for #name {
             ))?,
 
             None => outputs.extend(quote_spanned!(span =>
-                impl ::kernel::io::register::FixedRegister for #name {}
+                impl ::kernel::io::register::FixedRegister for #name {
+                    type Base = #base;
+                    const OFFSET: usize = #offset;
+                }
 
                 #(#attrs)* #vis const #name: ::kernel::io::register::FixedRegisterLoc<#name> =
                     ::kernel::io::register::FixedRegisterLoc::<#name>::new();
@@ -268,6 +266,8 @@ impl ::kernel::io::register::FixedRegister for #name {}
                     impl ::kernel::io::register::Array for #name {}
 
                     impl ::kernel::io::register::RegisterArray for #name {
+                        type Base = #base;
+                        const OFFSET: usize = #offset;
                         const SIZE: usize = #size;
                         const STRIDE: usize = #stride;
                     }

-- 
2.54.0

