Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020086.outbound.protection.outlook.com [52.101.196.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5543932E4;
	Tue, 21 Jul 2026 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784652888; cv=fail; b=q36/gx3fsDtO/lw15DwSSZs39jD5Iwyl3sCHBpSG1Km4uFCpYRdH9MRV4opYMb9VM7TiIWcBavLB69g4nTs0x36KghyBI9qon0Jag3irdOY7Z7uBA32qOMqFCaLoVCqQM93TH7EheY7LZVIWuowjXs2Yy9oRkK1U+O11eMD++R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784652888; c=relaxed/simple;
	bh=KJDfs+244AAMtetB/l4yAX6DwbO7wS8IunR7KoFI2os=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=B+8v8JeqVRGB3sdlxhuKTQs7P2Hn44WwrKl/55Ipj4wivrylp1xzO3osNm6/so7AIDJPgJeoLhKEiNRd6fHo00nMHm8hsfpIa2ZXLzehgthgwlfSTmzc942emDxhB612XFT7JkNJrcvrV9GcTOOW41XjNfPoHe/XkyDQBPo9C3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=sdQs724J; arc=fail smtp.client-ip=52.101.196.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="sdQs724J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5PPDqxf4IOb5UU1MvzOGQbyDP0KrnlwOlO5GRhtq/AEZO5i0PrhsfHNOH86w88jXJiBd4pxQxZXGSSNjgI0VqsKAC4UEeX8PYPFkjPABJS8M8vgLt/38TWqfoKXuR8nq3FZwdtZqs5W0rZJ94715HGy9d4aQIGyOfqILNkmZibp1XZm1crkSYoveRqAq9W3U5GgtDJNFbLSLRPjCzPraeoNEH5pS5vW4gKD4WiqO+c3YxEvjeCfcTyaksvUfoFv8To1nvvzrl6qhxNqDyiXh33KrvUqarKlLdkz//pJmua3ViuYgDMVJrKu3ZbQDR1IECtvuE8fqKVGoogFrXsA6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RoX/PgW3xQetTzFxJEl0t/PJxwXjQCnEefgN0cRnG80=;
 b=ZxDBX+HYDkEi23cwsnUDplH4eZTzqm6YZ3Id/9kdQcfBuz1HnyycJVgiL0sk+v1BU1g8lcagoz/p0k2GxUnoi5wkw+oBkIJXkjlY2Pr/cXkkpX5XrDgx4hwaGhRdOw7Wvgfzw97xBga5DQWB6XfA3BkZasIfU159U6vawbQowSHPwGm4qz+ZaAw5A49yDTSU8Y7aZELMoMOzjjWF9JmubeeaBNBUXC9ipSnIAMasGrbV84mK22kumHm1u9AVU9Sa9VrkMA7dg1WpwPrLWhibeoY+nNkG6hC0T83jYHBf0avdDb0UkstfGZWadxFQEuXtoQ3AjQSY7ToQqJGt9MiJbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoX/PgW3xQetTzFxJEl0t/PJxwXjQCnEefgN0cRnG80=;
 b=sdQs724JSL47V439Yw96/Hm/7dDr5OuMPRILy82Rt53mW226jRp9G/N2QYK1TZgkjCkvLO3PlU2pyEZ72Fg9MIGKX0WUBo9GT7v8cGm4eNQ7e0m6a68pn9zftHeLxZirrP9e8VwAk76+8pPByk7MBTXUE2MTr+A5f3wVMDeLj1c=
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
Date: Tue, 21 Jul 2026 17:54:30 +0100
Subject: [PATCH 06/10] rust: io: add static `cast()` method for views
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-typed_register-v1-6-452d72b60262@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784652872; l=1983;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=KJDfs+244AAMtetB/l4yAX6DwbO7wS8IunR7KoFI2os=;
 b=Vkh6H5OA032gZOXm5xCuKU9T1Ca3JyZKpXO4AlnPSSpObxfzSzg/uFtBpEijEVXCIhsS1XAzd
 pXcBNj+XeQDDPw5IEmzu/Zj/meQaYxZJ2dLbpdz5sNLiqbRZPnCXpE9
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
X-MS-Office365-Filtering-Correlation-Id: c1693ba9-f43c-4955-4c6f-08dee748bf1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|10070799003|1800799024|366016|56012099006|10067099003|6133799003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	bGpciIE77r4KDe/5fhD9QhTQWhi+FGQNm+VlSu0Gq9SpWknB0YUiYKSZMx2AL56Euj6h6SX81p/kS3/yFNK7wVbTks+PxfNLGpf1l0LfVWTnfZh7eTCobCOHq7PzBl2Sdv5fNVcVniUNQoavAeVEhS2PikGnaQyCtfoW+hyuLYZFNdObYS3LgnX6ndDtXks/NuRxqPf6tJN8FY9jsN44lCOIfhkb6eFc/df0nECqQ52o0Y4EnU4zd6CCN4cMlXXdZP+6eZYBZX8KmqxkgIw2XacO3LjRXr0Fo9It25trHv4uFOLZPs/vdpBLxccWJFnwlCOk8zD4bVXUVvwznYMeHJ7k01Na74HFVlpxKz2ltsDOzVLuztVrZUDe5epUHKogV9rAhvr5ny2kvjtjDIsHKQG3uhCWlPAzcNbAk6uuf4EmAfzZRN9c/IPnSpyqZAXa8NldlkNYqGu2RNyaVaw9n1SmVKHqhhWOx0bRELJBtR0vmlkQI/rJDJWyZRZ0OV/rIsOzHkPBFeAmNNIyxPfnSCb2farSmR3i+MzpsMDwXX+OGEUXEMH0JVbMgRKOxVGftfiH7zlfNBu/OuSYlN6L1RXqsHWV6jZttB6KD6rmXT0hdoCqLkSL3VRMHl/h2pypmcyMtFfz9BwzHIyQZ7IX6ZkPPFUZGRpD0pEe0MGuBDdY6qLQP8NWlff7Y+w++hC4w1o4W0OSCy7/jICXbDMzlA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(1800799024)(366016)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0VVRXdvTW40emZiZ3QzS0ZwaGp4SGVWbXluaXVzaURTNGxzZmdkL0tObWQ1?=
 =?utf-8?B?T2lGZFh3MEdzMW9uZWRZOHZETjZuRzJaSnNJazdKVzB5dy9VeXlnbTA0YWNh?=
 =?utf-8?B?VEZ0K0JlUkR2MXE5NUZwU2RtRmI3dnhHOFJMdWVxdVR3YTkwSXBOZTZQTUhE?=
 =?utf-8?B?aEMxcmsydnJzcHhLanVvL0FVblEyNHFseTVZVnhnV21zUW83RnF6NDBFRm51?=
 =?utf-8?B?am1RYUczaFlBVUpYOWZVblNXcVhNWTRudVA4bkIxVStYZHcwM1ByUFFGWHF2?=
 =?utf-8?B?cFBOZjIxZ0gzNC9SVGUxOFk1WWMxSkNTSDQ1d0JHT3kyZVc4ZE1UQ1RZZ0tj?=
 =?utf-8?B?K04yMWR3bXJNQitpdVF0N3hoMDRUdnErNThOREYyQVdHcnZzTmlNZEtET1c4?=
 =?utf-8?B?YmNhQkw0T3FVR2VSUWVrT3VlWk11T1dRSnVObUhmV29XSktkcFE1anZVdFZh?=
 =?utf-8?B?ajJ5a0FxSmgyTDdySDVoVXZtQ0krelZaVldQaUhpNGw5MTdROE1JQSt4MjZw?=
 =?utf-8?B?NVBaSDBhVE96dFdvNFFEQnV1cU1DOWFINVZVZkpIMFJhVE02NVJYeGM2cnpY?=
 =?utf-8?B?bFJtblY3Zys0YmxoUmptb1RpNTU4QUtzVXdJZUtOTjBUV1MwOTFicG85ei9U?=
 =?utf-8?B?TkVtVk0vM1dKMVdhWkIzWkFKOS9ZYVJQZ1VXTnZzYzdvS0pvT2VVajR0aG9v?=
 =?utf-8?B?RnRieTN5RnRhSjBPMCsvV1oxckw5VHFoTzVCcUFUME51YWl1RlFMYUhaOXlV?=
 =?utf-8?B?dUgwNzdVUmxFR1VMeFFRUVI1V1BZVTNEOHRUaUgxUGVGaFY5UHEwRmIxSEt3?=
 =?utf-8?B?aTFuTUk3dThxaXFtbG5pOFBZRGxWSjVDQ2Z6Q3RzQ0VrRXFkOUtoT005RjVB?=
 =?utf-8?B?V1YvM1BZWVhpanh2RURtMCsxUTJ0V2tMWTI3b2FNZ0dlYjFsN2xlQjBiYnEy?=
 =?utf-8?B?Vm5mR1ZBUEllYVVUV2g1SkdxdzhIcmVqbTNDbi9SaHBIRldXay84M3VKMWlL?=
 =?utf-8?B?bTJRcU9zWDF2NktuUmRUZFlCQk9LNFpzOExzd3h0ZTZnTTN5Z2tSRk4zcU5u?=
 =?utf-8?B?R3IzemhQWXR6S3ROcjAzSkZXM0kzcEdPTGVsQm5hdDhKUGVXcTVJb0pRNldn?=
 =?utf-8?B?c0JwTXNyL0hFQUwyVlBaRFJHRXlvek1zVUE3eFZKNE5NUTdZOFFlbVNmTXFB?=
 =?utf-8?B?NzlEc0I0SytKcEJlSTl3S0hOajF1MjR5d3NHWFVQRFo5bTVvYW5rbGpZMEtS?=
 =?utf-8?B?eEJiMU9XTUZ4OFBVc0pXSGkrOU1DUk53MGRxT285bDNUV0Q2YVdCQ1dPNUNv?=
 =?utf-8?B?TmV2OW5GUGdaa3UvcmVTa2dReC9veDVEWFJuMVlwQ2ZZWVBMR2w3dFdkNXFl?=
 =?utf-8?B?L1VQN1FXd0E1aXZra1dzbHA2OTZXWkt6aDNsZVZOM1NWeEhDNDZuTG1MdEFm?=
 =?utf-8?B?RExnWnVLM3JaYVkrZGFMVlVMSDBzRHZ3V3JGRm5KZUxXdjMza0lmNzdzbitj?=
 =?utf-8?B?L2tkOTdYWSt6Mk1qWmhmWGtLaUp6TG5pQkxoQVlFdUxqa2FZUTU4L2RaQlRO?=
 =?utf-8?B?MDN3OEVGSWRQZlFRUEVuQlROdDUyOXFadWdmcnlNMkoyVU0rN3J2M1lWTFFx?=
 =?utf-8?B?ZGMvRXp6ZkJaMlVFUGZuRjdsWUpLMzYwQ3lxakhTd3VoYWp0N3l3NkpvSjlN?=
 =?utf-8?B?V1JudGtieXJnZjVSV09sWktubTJqMUNqamg2ZFFQRTJYdkt0N3BJQjVTK2NF?=
 =?utf-8?B?dFBsTncxRTlUdTNGc2taUXRaTjY2NTVya0tLbmtueklYMW8vTzhLWFlyb0dB?=
 =?utf-8?B?K3phczh4YmJXQmFQVmlzYVVWbWIzdktJMy9KTlRoWllkSnF4SG9KbmtVeEdH?=
 =?utf-8?B?eExyaFJkcUFOSjkxWUFlOVJuWTc1b2ZaM1ljR0VCUk5lNHBGVTJHdW5oa0gz?=
 =?utf-8?B?czNPcGJmR1NMRTFIcks4ZC95cUU2WjZidXZ1YWU4d3dpano0dWp5VjRTSzdk?=
 =?utf-8?B?MFFzdld5MHJNYnRDRHM3cUpNZnJUTVpuMVd6TEpRV3VOTFZaQ1hyemRVUUJU?=
 =?utf-8?B?TktUS3pmZUprRllLcDArODk0MnF4WEl3eThuZy9VNitWSFVLbndWeTJTeFRL?=
 =?utf-8?B?ZmV3K0N5ME0rYnA4NzUzNE5wNFlRb0ViTmwvVGROYTg4bWpKbU5iUnFXTXZT?=
 =?utf-8?B?TTVQaFVXRExLS2VpVUJmcS9WcVA1TUIxOWtWemorZVFUYnlmcG5UZVdWZlJZ?=
 =?utf-8?B?RExIanQxWmlGR3l6d1ZYSTVieDNuNjM5SUU0RzRqcmozWkQ4UDkrWE5kd3Zs?=
 =?utf-8?B?dHJOQXQyRWxpSjdDbThVUmltTy9vd25KSlpRTnJzV3I0ZGZaUVVvZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c1693ba9-f43c-4955-4c6f-08dee748bf1d
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 16:54:36.3751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjAOhSu2qXZWEbN5yTMKtkAYY+sdsDTJZ9jY2t5pYkQREQA80QKV20POE8gQ9PyUFc50gWI4tkytEa7iOZkOnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7878

Add a compile-time checked variant of `try_cast()` using the minimum size
and alignment information.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index c5f07c38e59e..0f8b166a6d3b 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -436,6 +436,45 @@ fn is_empty<T>(self) -> bool
         self.len() == 0
     }
 
+    /// Convert into a different typed I/O view.
+    ///
+    /// The target type must be known (statically) to be of the same or smaller size to current
+    /// type, and the current view is properly aligned for the target type.
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// use kernel::io::{
+    ///     io_project,
+    ///     Mmio,
+    ///     Io,
+    ///     Region,
+    /// };
+    /// #[derive(FromBytes, IntoBytes)]
+    /// #[repr(C)]
+    /// struct MyStruct { field: u32, }
+    ///
+    /// # fn test(mmio: &Mmio<'_, Region<0x1000>>) {
+    /// // let mmio: Mmio<'_, Region>;
+    /// let whole: Mmio<'_, MyStruct> = mmio.cast();
+    /// # }
+    /// ```
+    #[inline]
+    fn cast<U>(self) -> <Self::Backend as IoBackend>::View<'a, U>
+    where
+        Self::Target: FromBytes + IntoBytes,
+        U: FromBytes + IntoBytes,
+    {
+        let view = self.as_view();
+        let ptr = Self::Backend::as_ptr(view);
+
+        const_assert!(size_of::<U>() <= Self::Target::MIN_SIZE);
+        const_assert!(align_of::<U>() <= Self::Target::MIN_ALIGN.as_usize());
+
+        // SAFETY: We have checked bounds and alignment, so this is a valid projection.
+        unsafe { Self::Backend::project_view(view, ptr.cast()) }
+    }
+
     /// Try to convert into a different typed I/O view.
     ///
     /// A runtime check is performed to ensure that the target type is of same or smaller size to

-- 
2.54.0

