Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020086.outbound.protection.outlook.com [52.101.196.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D133998AF;
	Tue, 21 Jul 2026 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784652890; cv=fail; b=Robr8M0dyR73q7lgUPjFmjCQnraUFBrnU3YHF4URhyjGjyL3Z/m/R8sP2TCnYAGgjivBiv1rKyDFG+a8vYFhxgGbEBVQZtzPz+9RcY07ZcbYmTmh3I/Vhfdp3S8KcZ9fnsmb2XsaiLYsbR4zEk8s5WPnYkHYVQCqrxNe7xIt4VA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784652890; c=relaxed/simple;
	bh=UuUtulP5TTsCiBoLOzge4yJEZnhJxQB6CbEM3NnyO3k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JyDa3ytAW50jJkbPaZEaQx0KbQi5PjXJNRL6sN3l4H+OmiHbDVO1oQyOcmQB95JmBkB81hH2qw7IB/KxKXXIpPhEnKhQTIAL+aautRZ6L6NPEoyBermVDv6DArgJ45y3+VIlZnPzGy3QzPPeTeMOCiCAxANhbhwuDcI2BlKSLNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=K5GYwA5P; arc=fail smtp.client-ip=52.101.196.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="K5GYwA5P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekqYpn8vkki3pXkQvKkiPAyUO2KE9S3hKMjYT5Jsy+5+k4qvSJOZ/Q4fA+dv8IeB7HkO63j0/S4yy8lbxgT61/8zC6N4CcsB6/ncRGGb5WotAZw2n0XidGZdcpITB76Xgz3X7UlGtCfMrYE0ee0oF6Ftc9bErzefqn+8JJ7wDrjWEhXLPHggGUMZDuUcLFUFIEuArYBoHzLcgiTUUf/Oiy5K7ySm8GFv+YocqhNoQ7qYxcCETTBLRdSVJZAZwagc2dXn4TAxoHD/XXSOONr3gVrMCe7lsZMjfvCjkgJzNgmHaBqCDT/Xew6pXDrK5pv3mA90D/E8usFlfR5WGz3Jjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3Q6cgY4/fY7xuRsxeLLgbo2v/hJYuFRyehKXpZR8Vk=;
 b=xkCsD9T6dgXlp84rHNlvRcNWnJk+ZlN2C1M0wb5XIC8kH+7YH8xqgvGfo6r+/3ExmnRpWQFvEMSldeWnAg+zjmYPZeHAMlhICJvM3qpzRFwbqjxBCoxYzevDyGzZIRs6NG/f65b13adEFlZgf97fyYmSy2dPcNPRH2fYSsgopSHMapoPyEV8oEScpTAi5oKsfBnEPcULIXhBc7X3f1bV9eXjzwGgxCPLomQEReKIWm3tolvTWIieW8E/kOzKj0FweCxSu2vaRd0MHD1gzJEcZ6AjlBcFWj4Ah5twIwMSOv88edM84XSQkIetO3xXOJovG/4+cw58MkgZ7BBkvuPFBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3Q6cgY4/fY7xuRsxeLLgbo2v/hJYuFRyehKXpZR8Vk=;
 b=K5GYwA5PXCxJ6yGnBjI3I0iQw7lZFl1Llf96aMqp1/7fwQgsb6QAzZAopL2gi5VTj+ORaCxLLMYTDy77Rs4XiRkVD358ssd3hzVwazM6mvKVGhM0gYMYRqVk7TvgJhpDF/HZJpfDkOy+yfQK/wlBTIH9/LE5IrWZq9uC4in/rko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7878.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 16:54:36 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 16:54:36 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 21 Jul 2026 17:54:31 +0100
Subject: [PATCH 07/10] rust: io: add subregion method with compile-time
 check
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-typed_register-v1-7-452d72b60262@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784652872; l=1603;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=UuUtulP5TTsCiBoLOzge4yJEZnhJxQB6CbEM3NnyO3k=;
 b=yg0dCdKIQhekGtnJvoKnddBHFJmyJscAKVBw6HTvuwiMpITAtcWA9eddeR1ByCQcgcjjxPVGG
 eUZ+Z5C08FgBYknqTU/m76xi0ltzscB8/XYMjN9EK7C5qG/bdEVHdpA
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
X-MS-Office365-Filtering-Correlation-Id: 20c14eb5-955c-4b80-36ba-08dee748bf6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|10070799003|1800799024|366016|56012099006|10067099003|6133799003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	CgeRoiluuHCihLcSErSHzoV7Zcti384C/6dmzgPqGHHWGDd1A+BxhX967OJTlNY+Dx8dy4nsH76pK8noiI/B38FvTxEW3iPZIqjSL1SjkiYdM4zCF3Dcd82FYuoSg55ktA6git3WmkyiBF3HIaJclNrk38zi0rWmdlNfF0ubU0g441EyGRuGfCF1DsV75wssCcyJeeyzuRtHLPfIFpNt3dejFGUCmoGVkBUcK8nDgYFjChQc8E26fDiTSu0bFxmVEWMfPrrgSkCxwNtCrynQsVeINH91B3+yPzt1A96mvAC6qb0mPOOcEkKPQPg8oA2vTiyIKHT3JA5VprJqb4/+NLYRQjMRv+Z3AyRq7yKt1dW6BpaGQrcxZS41YEEBALfWHO1mNeVA1BOHwqELv7VjJYXqrpYDfUXSv3OFeLHBhVIMz4fbJFfpa120qJTIBWOQwcwPN8J82TQ1sqoIHDGr5tSP8zHuia2yTe0fWQ1JZ1ftw53zOT+TSxNQmx9QkGse1OWejKdkq2tFp/+Sl2kqTZKYswBkd+JXa3ZqrSZvKXgCXWpSfDyzT3xX2Cw371zjITS1ryyIsJUJ3hORZjgAm4zz2IlMmeYOD9T8lefzdE4iO8aI7wanvf7gp1sRsWvHSErr5O4c4HE7o7YeCy9A9VB5QC5ACvP9OxVCCOR/Y01MYI+2f5aIX7bxpUVGlJX0ij7dqyLu+3z6AwBT/jkfsA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(1800799024)(366016)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1h3dXFzeDRrNVpEU2Z4T1F4N1Yxbk5aN2p0bmR2R3N3Ymx3ZWEvNzBDYUNZ?=
 =?utf-8?B?ZVF6R2NCSTJKVEUxaFVsbTI3MDZQeFNBcmluTUVwVHhKR2VyOGJ6cHdyeWVt?=
 =?utf-8?B?Umlnc09BanMwbVpRbDRDbmpnb1ZRNXFDOTJIS3VBaStMdElyQUdBSVQ0SXpy?=
 =?utf-8?B?SGoyNFlST2cwWFFNblF3VUliTXVvMVh4VTVPQ1N0dFRpcVJtS1dzTlA5dVRT?=
 =?utf-8?B?ZlU4cUpFbVgwcHFBOXVxYjZWVEF1bGIrcExqaWpubGRxN1VydmxPcW1wLzk2?=
 =?utf-8?B?dzNOK2g0cElTd2xUaDdLZnlqZWxMd2YvODBJVWVWUWZsdFNYUVpxdGtGMWpr?=
 =?utf-8?B?aThXUEJsQmpwUWpGOUE5QWRrN2ZkVDZIY0VCTVNYYkY2NFdlVDRBdms4ODEw?=
 =?utf-8?B?S3FjaUNFMk83Q0daL1BRajhzQ3F2NkEyUUt1YVpRMmM1M3dGemU0eXYwZ0xF?=
 =?utf-8?B?OTlzcDliZFNWTnhEenR2RWNoa2JBRGROY3Viek0zN1RpQmE2ZERUa3ZNRFk2?=
 =?utf-8?B?MHR4YkVtaFh5OUhoQ2tBeG5lTG9uckZFYkRXNmo0dVdzNWtVdXc1RmRVaXIw?=
 =?utf-8?B?UXNxTEFlL2dYc3FGK013KzN1aGNBQUlLZUlRQ2dLbERlK0c3NVBRSDlncnZu?=
 =?utf-8?B?Wlc1Mzh0U09NMWJJNGNRczZiQW51QjZucWZhekRwenhlaitjQnkxbDFXczdV?=
 =?utf-8?B?a3A0cWc3Tk9qUSs3c08wd3ZHZlE1MHU4T3piNTVBYStja2xlYnV0VFNJajUz?=
 =?utf-8?B?elJZOVZuNUVjYW9HOVY0b1U4eVorZWpVdXFJU2NqWk91VitTVEhSV2sxZW5D?=
 =?utf-8?B?ZjVjeEhseUFoc2ZobGg0VzBkVDhrbzVud0pCRHNZUHJBa2FtRVM4NFFSeHNM?=
 =?utf-8?B?WEpqT2E0UFFQTmJQTlJhZk1MU0t3N2piQUVGT2I3bFR2c0l6a0ljdjF3Zktz?=
 =?utf-8?B?bTZjV2gxa1EzRXBjRXlGT1VSVGVQM3ZIMSsyOXIwbDNUVXdUUUd5VzhYaUJI?=
 =?utf-8?B?cGc0bDQ0c0IyenJUR01LajZPdjJ0YTllUnEwbHp2NDFLelIrV1k2RlI4RTJL?=
 =?utf-8?B?OG00QldIdFR2Q3FLSlNaOGV1VTlYNFJFMm8rTlhjWXc4OEs5b0NtV0pWbTl1?=
 =?utf-8?B?aGpEZEovSEp5UDFic2Q2NlgvUXV1eTI1ZjBpNXhSYjVxTGNoUkJ2WXhTZ3Iv?=
 =?utf-8?B?a1BBVS95ZUFWY0VuWnJHSzBNeXQyUTgyZmE4b2dyaVFPWmVoNWVYdVB3Mi9r?=
 =?utf-8?B?cTZvc0lHV1pqUjF0MUtCejAxK1ZESjlKRFBRMUx6TFBZcG1xUXROdXhtZHgz?=
 =?utf-8?B?MnZyc1lIZktJSHhOczRxaTJhQ1RZSFJ3SlBNQlA4cTFxdFFnMkZzVzFoVkNQ?=
 =?utf-8?B?TjRwRG13dGlJYVZFdzVjVzZLMTNUNzZzNWpibHgvcU5BMXZGVDNKMWpkSDRP?=
 =?utf-8?B?NTJxQk40Q3lIL1pDR3YvVWxyZ0VuRWRpV0JDVEliSjJEdkRWQ1h0MzNHSHlt?=
 =?utf-8?B?eE80VXhXWVhHcnVkYkMwTlUwOVIyQ05vSjh6MzBFZlVMS1E1Y3VqVVFvQWU3?=
 =?utf-8?B?RkM2TnNvQnFaa3pXUVNzUVE1cm9yU2JTYjN6aFBCeXByUy9pMGY2VGJ6MEJv?=
 =?utf-8?B?K24zNGordmNWcHVFWno5QXFLU2h6Y1lQaU16TkFLYmpnamZVbkhueXJjRWpE?=
 =?utf-8?B?VjN3QmhLLzlnL0pvbGFxaGl0YTdiME1VaTNPSHVtenFhTk42VXJ3NlV3Unl3?=
 =?utf-8?B?blRwK2J5dlJHUFgrWk5SS2ZHd2NOTDM2UEZjUFdBSUNRc3J3RVNWTzBPbGhR?=
 =?utf-8?B?ejF1KzgrNlpXUUoxMWpsU3lZVFdnMWhJR2RIT0JpZjhXekVzR2toNzhnWHJT?=
 =?utf-8?B?V2NrT25teEV2Wit1SUFxRndTSFVJa1JaeGJwYjhkMVd1bGU2dDdpSDFOZE90?=
 =?utf-8?B?OEVCVlVjRkZTWWpRaURISkZQekh3eHhicUdHTUU3U0Z2TC92Nzc2Zk0wZ29j?=
 =?utf-8?B?UkJEUWl1RXdrbUhHSU9zZ2dRZlgwenFidGlNTENPemNpcEdFb3B3V2RBbnVn?=
 =?utf-8?B?ZERtREtZaXFpZjFyb2pCVlNPRmYxYVpDRUU4R010a3NlWFZSb2c5WGd2Vzhw?=
 =?utf-8?B?enpzRlRqUmVMcXlKKzBZMGd4WFZlUGlYRnlYdllFanovcTNnd1FoNDVjTXlY?=
 =?utf-8?B?VGk1cy95enJ4RHVCbGEyT2dXcnExaDVZdGdUTTROVm5GMW1pSDRTcXdhVkNp?=
 =?utf-8?B?ZU42T1UyWlo1dXVVZG9TMUZlR0VMbmh0Y3JLVkdJMHVUZ3czUWl4aHdHT09U?=
 =?utf-8?B?LytwVTFXODV1TVpSejZoajZXcDhXNjBxeFYxZlZUalJtaldrMXdrQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c14eb5-955c-4b80-36ba-08dee748bf6b
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 16:54:36.8807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tGvR0kvCcFhqn7q+ZNM+SVDB8Lt3QZy3D+KJwVX05hhUp13TU1sIbdlD63YybN7XJWzW+bUe56xz32SlepeIOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7878

Add a helper function that allows obtaining a subregion from region with
compile-time check. This can be used by drivers to obtaining a subregion
for relative register access.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 0f8b166a6d3b..f31d37c8a3d5 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -80,6 +80,30 @@ pub fn ptr_try_from_raw_parts_mut(base: *mut u8, size: usize) -> Result<*mut Sel
 
         Ok(Self::ptr_from_raw_parts_mut(base, size))
     }
+
+    /// Create a subregion with provided offset and size.
+    #[inline]
+    pub fn subregion<'a, const OFFSET: usize, const NEW_SIZE: usize, IO>(
+        io: IO,
+    ) -> <IO::Backend as IoBackend>::View<'a, Region<NEW_SIZE>>
+    where
+        IO: IoBase<'a, Target = Self>,
+    {
+        const_assert!(
+            OFFSET + NEW_SIZE <= SIZE && OFFSET.is_multiple_of(4) && NEW_SIZE.is_multiple_of(4)
+        );
+
+        let view = io.as_view();
+        let ptr = IO::Backend::as_ptr(view) as *mut [u8];
+        let new_ptr = Region::ptr_from_raw_parts_mut(
+            ptr.cast::<u8>().wrapping_add(OFFSET),
+            ptr.len() - OFFSET,
+        );
+
+        // SAFETY: We have checked that the new region is a subregion and it is aligned, hence it is
+        // a valid projection.
+        unsafe { IO::Backend::project_view(view, new_ptr) }
+    }
 }
 
 impl<const SIZE: usize> KnownSize for Region<SIZE> {

-- 
2.54.0

