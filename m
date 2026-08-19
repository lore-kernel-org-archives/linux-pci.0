Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020099.outbound.protection.outlook.com [52.101.196.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C61C46C830;
	Wed, 19 Aug 2026 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787137850; cv=fail; b=hA8xhLmaohyRvdYSTWoAkqqGXXKS7ABtDsvcwRjJQpF4ps8pfSOKJmd5U+bZhHBWiGBaGqShYYTmwTrJykCQ+BQd0E8q70Z8F35Kp+oz61DWLyliGO28LXlsqSyKk2jlQnCC+1xuIKMUSvmuvURhostyN05A5IsT5U7798+f3DY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787137850; c=relaxed/simple;
	bh=hhnaSlzSE2Z66uVV7DHhQmy4tSqv+1IXM+RJzzv/+x4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=eB/ywofy7edLes81k2lztax2RdpMRq8P4m/Msua+2MrWjvDe+6UyAYXDGqCRio75zBk0sB4Djjlryoh+ZUVXsCHS/cD1JsGQVLI5HDfPLGrqhm6zyO7+M5iIlJY9dB/IDjtJNH9/ZwCAvkJu7uW2FWVR/YpQMkxu6gD1mQmNkck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=burTnuKU; arc=fail smtp.client-ip=52.101.196.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="burTnuKU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKJrwIBEFT7GC2FOP+PBlkEhN+GIS2t4tjoabe6ZC6casporA7v60uWwu80aVB34RhjljAIxr8FaV0Z1kEvq4mb48z6xn6lrvUlQt89xiR5p24e57Gohksv5ckMwmkXCBijjsEIuvPBbTq/YnKJQ+5NjLxBKkMBonPHv3W6Kiz+xs4uOixcCvnthp2EhbtaDKqsJuDZTqhlnKkYc2PvHrgB6wZ6mbZXLcG/U0aEBg6vOAEfAzRkaJaDW4sSD3P34AjKkIC4BimkuDV+swjqjU/yHZlOuIUtwJnKldVPJRHryDlZ2Li5tdJ2SE5+LAtOzorn0VwCO4O+Wj9nQGpN9Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2aTEr+ItVCLi14N3Bau2Rhv3A5PUSmeEBSOimB/TVzo=;
 b=FDBzE0zltj2qzZjCkl9hVyTrKpVoADAmpO+2EkiFlXyiwg3sF5MWCZBkHoTxdYFOqZUR+UWaOrmCUiMGGtrmrl6lmJZ+Gna23D0+Qj1WIEDsibbmeBKw5B/xoNeTm3BF19yHf7tYVodjMbUj0UY+SfZRF6XsgfaA4yGVYknwl1sEL23mjeBahos3kmI/0NDYiWUjhFiPx5E4/BHJ8wSnCun+rcVZK8A2UtMGWqJwdcEYfbCGYO0sjRXEWbUOGD800xai/j2X3feEKJQwv7iISQhHjlgK9QCcerfg6A2bPBoUtC7zUgNLE92tbBaXMV8PlxayiaGS5EJ+ma5X+lJWZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aTEr+ItVCLi14N3Bau2Rhv3A5PUSmeEBSOimB/TVzo=;
 b=burTnuKUxooqrVQY+kspi5l7Wo1nnFzPaUqXpzXBERMWCemWuBhOp8rr9K6PMjNxqPhTjC0IlIPlnVgri0muPxFuzxh3bsw+ax9NPIqv/6lUnr0SpWjl4tz9IFy23lnBw3yPnfXjU7cmQiIHCyrdzlXauIzT3Rv/qBprGlv1Kng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB5113.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:15d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 11:10:25 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 11:10:25 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 19 Aug 2026 12:09:23 +0100
Subject: [PATCH v3 15/16] rust: io: register: remove `Register` trait and
 cleanup macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-typed_register-v3-15-3699a75fadf1@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
In-Reply-To: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787137814; l=4365;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=hhnaSlzSE2Z66uVV7DHhQmy4tSqv+1IXM+RJzzv/+x4=;
 b=ty935MJoWB2ycq7iW0ju+qYmJ8uTOkIeEb7xq5bwQYxGX/i6Jn7EIikrRAOUhA+DWSlwyplIc
 ibqJ5bkX87XBmgSNhpjF7cRHoI1rD146oCnLtME2D4L4tEnUzI00Rmv
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0096.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::11) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB5113:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a2a8e5-44d6-45ab-9c41-08defde277fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|7416014|23010399003|921020|3023799007|56012099006|10067099003|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	FZq3y4EN2flwnNc8Oj7HRb9hmPmuL7DCGnXmNRqXxwoLBHG4miakt87c4YzDwQwNZ7352KoUXlibD+X4HJ+f5WQYtsdir2k0Yj1sCg2Oku0ET5cJVgbTWDhWB+9i3napyC3Z+7XFiAn+wtj6sLwlyi6RclL3DGBtFHqTMXHvoQJ8ui4a2KBTXJQcorr71VPB+4JNUhIH0qzQ282W9nXLtWSfzqmkwd9Udfabbre61vHgYhLtWXd/KzpPYCzeTolv5f6M4uZAd70zaa+/I6ox49W202lNvUqnF8FWLLpPSdt4rcxZoNbtbO+CEjZpfDPYS+M0BG5mtDn3oZmbm0P3aW5IBepT+EpWCTJ9y0l+tUUlc/SIKhfgu9lBW2DPnKr8d533ybLZ20QvUz8CTFpCH36aXwPXf0OLw+qpylAmMi23rLTO4P3u4U+WqpaJdWAC5ltXm08Swc1mNdlF9YwdpjUEfOAQTcsCIryqV3LvGhFw3uQJOAjsgs+jkOWAJ/rog6bbDS6Eal52pPsj0u+pT5jO6phfxMuspLo12gTmPVFZ49Ei0xP8SiZyDUCOETWPFYt0YZGmMtoy/5aTMkzh8lniSsmBn63XR72aViQx1j3Xx6qsjgSWRVSZ9ZTFBIzo9oBEBYIbBF6fHMrsUZD531Wg2vLRl4mDHYrVXw9hie1WBA6Tofol5HoDngu60hjEmGIlqUBGAti36AYbGnqBDw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(7416014)(23010399003)(921020)(3023799007)(56012099006)(10067099003)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVJ2V3c5MXRaRjN1UkVISXdwSlQ5WUdJYS9WMWJ0enZOUUZRSUtQcDRjZ1NR?=
 =?utf-8?B?UGlCYTQxamdCTk8reXZmVXNMVUtXNEdjVFpxL2I4bHlVR3Y0L0xkRXRaeldX?=
 =?utf-8?B?by83bmpkQVJBRmIvV3FyY0drQkI1YVNmRHZwOU1IbE1jYTJiYi9qOXFGMjh2?=
 =?utf-8?B?ZTJSaUVLTFpXUDVzcWcrb2pOR2dMaTF3bzBqam9WUi93eW9Ydk5HVnpjMGRr?=
 =?utf-8?B?WlZicm9jVUJHQ0dNNDJvMmpSU1RqdjdxcWNDelJNSnptNm0xSHB5OTVVSjk3?=
 =?utf-8?B?bjBmRVFuWnYwWmtFSDhTMm85UkV6ZUdGVmJMaXl6S2lUSkxsTlNHdVh3dTZa?=
 =?utf-8?B?eWdWTnNXTmwrOXAxY2xYMlpNZ0hRYWV6UXpNZzdobUVhR0ZzRmFEU1g2eHUv?=
 =?utf-8?B?UG81RmZ5VzhQeDdpcC9yd0ZMQ3BOeXIvbW51QjdsaGROZVErNlJKdXNqeWJC?=
 =?utf-8?B?WmNhdDEwdEhmVFNvTjFMc3Jab2N6NnpNRk1qODRMYU5kM2FUZHFwU2RsazNP?=
 =?utf-8?B?YkY4M3Ztc3pzYTBBMUNnSXNkMGkwNThxUE9UakVKN3RwL0MzSzRlMnM1Y1ZK?=
 =?utf-8?B?TXJNb1FzU29mVmhlVjVXKzYxa1FTNlp6UHVEK253OTI1RTRVbDhCVldLSEFv?=
 =?utf-8?B?RHVxWlA2S2pMekM5TEZUVUR4di9LNHBINGhyMzlmSm9wODdiTk1ZR2NUaVpE?=
 =?utf-8?B?SjQ1N1Ftc0ZJRE92S0h5WXkvK0RKZmNSSFBPYThWdFQrUHpPSGROcUVwbklO?=
 =?utf-8?B?Q0c5c1diM1BCK1F0bmI5OHNzSnVsQW1mdjZRVVFZQnY4Y0JMbkZxMXZaSFZG?=
 =?utf-8?B?cWFxTkw3ME9sdEJHNEl4OFNLbTl5ak9ybGxwaDBvc2N5dk52LzZFeHVBMmsw?=
 =?utf-8?B?N3NXYXY5dllzdVQ2dXluSmhzaGlLVUl0OHFwVkQ3MnFRWW9lRXAzOWgwVmEv?=
 =?utf-8?B?b2Y1UXFiRU5ZTVIrdXFnS1Z2akd1QVVtdytaVVI4a3ZWaVBrTEt2QzlTMm5p?=
 =?utf-8?B?bmxVVmZ4azM4MGc0NDdHNm92VjdTQXN4d2NHWDdSeW9Fa3hFUkNDTmFheXpX?=
 =?utf-8?B?OGxneEQ3Z2F6ZHZvTklkUkV3MnFZRklTQU10eDV3SVFVK3BDOVJMeWNwckJ0?=
 =?utf-8?B?Rml5N0xKalZUQ0NZZUdkZDc3VS9hb1YrcEdJSHBsSFhOTmxodEdqYXdrS2xF?=
 =?utf-8?B?VEpnSk4zaGZqVDhYbS84ZDY5ZXF2VzdlMVhPZ1NubWhCc3NSZk1BeDM3Tk9N?=
 =?utf-8?B?SDJTWTZXS3VaSGhYTEdQeW52cUdXdmQ3TEQxMyswa2pEN0FBeEtVWkVWbTJz?=
 =?utf-8?B?c2dHcm83ZmJzY3lYS1dLNldwUVM3NEF0cVJqeFlMdERycjdxdFh2RlNkeEh3?=
 =?utf-8?B?TkpNOFdpc21nWThETkRjSXZ2bGZvZDhac0o5OEU2Vks5eVgxNWlGbXpzSGxk?=
 =?utf-8?B?WU90SjlMZzVMQ1hmT0d5ZzNJUEFBTkpZUlpuSjFFRkZwWjBOZUxSTkpuYWp6?=
 =?utf-8?B?NmwrUFZ1VSt1alhnU25BcmlhTlc2YUhSd1lBeGhDNlF4VkNyWFN2RXlPWGRC?=
 =?utf-8?B?RmRGcXJnL1pYTkJOUXEvMVFpdy9DZDZiRWVEbkZEYTdqbEJmTkt4bDZpNkpl?=
 =?utf-8?B?Zm41SVpZNm41aGFQL2FmZ1ZBSEFDaDg4WStqK3hnRGZzMXRJREZrdTJPclp3?=
 =?utf-8?B?akxrV0pyOHVBZkR2ZlY2S1BDOHU2R1NBc2pxOFUwdTgzL1FTSlE0OEZHYnEr?=
 =?utf-8?B?aGFscFFMZWN6L211eWtPSTFDaVZFZ0dBNUQ4eUh2RHY2T094c0pBbHVyNGcw?=
 =?utf-8?B?bWFXYUowVTZ1OFkxMEhlZWZkaFJ4dzFyWEJMb2hVcG1DR2daMTdGWFU1RXdt?=
 =?utf-8?B?VVZNTkhNMkdST3Y4UGUrRVhKcUE5TWRBWjlHR3JhNC9uekpnRitOVjhVOEhB?=
 =?utf-8?B?TVBsd0loNVZEejlzYjdNV1ZKc2hkKzNmeUlJbUlmVE5oUnhObVZLb21oTzFB?=
 =?utf-8?B?TEFBMU9Wbm02aTdhNGtTSy9Cd1VweGkyUHIvNnJxcnlHMHlidmFUQVFNRitR?=
 =?utf-8?B?V2ZLYThZSHR2SUlJbkJ4YmJic00vR0dGaUV2N3VQdjJxZUJ3R0xQTGx4ckxi?=
 =?utf-8?B?clBoTnltTGZkNVJ6cTcyaVZrODdaQkZOU0JZaXBiakdLVUNrZHFlYWs3ZW1X?=
 =?utf-8?B?b3F6b2trQlJhc0lOUXRwY2JDV1lxNW9tY0dIUGlZYWVTdTJNY1FnL1QybTlC?=
 =?utf-8?B?S1U1bGwwMmVTZ281S2ZWc3ptQ1FJblFoanZtWk4wNmlObytPb092Y0lJRkNn?=
 =?utf-8?B?L0ZQQk1QTGRjenVHZXJlSlVycUo3cHFUcTdWcUVtMEtpY1NxSjBXUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a2a8e5-44d6-45ab-9c41-08defde277fe
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 11:10:25.1557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eg0+/RzXjvWXiAEiaiG96AoDBJoEVenhH653q5xkgN6GQH1Jrw8WfThLZlCyiORr0sH8mUtBzNIJMDY00yXnpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5113

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
index 4d4afd3ae94a..6aeee6c0a5f2 100644
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
 
@@ -294,7 +298,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 /// This is used to enforce base matching. Only called during const eval.
 #[doc(hidden)]
 #[inline(always)]
-pub const fn alias_offset<Base: ?Sized, Alias: Register<Base = Base>>() -> usize {
+pub const fn alias_offset<Base: ?Sized, Alias: FixedRegister<Base = Base>>() -> usize {
     Alias::OFFSET
 }
 
diff --git a/rust/macros/io/register.rs b/rust/macros/io/register.rs
index 757ea8094f61..e0bba6b71ebc 100644
--- a/rust/macros/io/register.rs
+++ b/rust/macros/io/register.rs
@@ -213,11 +213,6 @@ pub(crate) fn register(def: RegDef) -> Result<TokenStream> {
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
 
@@ -233,7 +228,10 @@ impl ::kernel::io::register::Register for #name {
             ))?,
 
             None => outputs.extend(quote_spanned!(span =>
-                impl ::kernel::io::register::FixedRegister for #name {}
+                impl ::kernel::io::register::FixedRegister for #name {
+                    type Base = #base;
+                    const OFFSET: usize = #offset;
+                }
 
                 #(#attrs)* #vis const #name: ::kernel::io::register::FixedRegisterLoc<#name> =
                     ::kernel::io::register::FixedRegisterLoc::<#name>::new();
@@ -256,6 +254,8 @@ impl ::kernel::io::register::FixedRegister for #name {}
                     impl ::kernel::io::register::Array for #name {}
 
                     impl ::kernel::io::register::RegisterArray for #name {
+                        type Base = #base;
+                        const OFFSET: usize = #offset;
                         const SIZE: usize = #size;
                         const STRIDE: usize = #stride;
                     }

-- 
2.54.0

