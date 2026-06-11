Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022092.outbound.protection.outlook.com [52.101.96.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32834508F2;
	Thu, 11 Jun 2026 16:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195322; cv=fail; b=QlXv5Hv5lbeVNhUC4SRAUQHIQisjjNEEXiGQB75h3d6AcNmw36sWsfuPN31zIXw52tWo95W2k9qAyNSVsSkm0kHwTYX4Z2yJab7B0SvYgkH8RPICnWPxQbSB8nCcmjEFkLxlIsgJZbqRqsqFXT35I4mhniGhC+q1r93MQ1lfIqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195322; c=relaxed/simple;
	bh=goWQJ0ThqV+Q3smjs/gu7WOWjqv2qJjkHt4GzWinuVo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Yv9QlEeRxQ8CJw9ktHyTVZwKh3EkJM6ELQkU40m5RxOI8DP/LWjPAA7f+5khP0TMlriTBaEzHVdhZwaz5tnXH+o9m3UZ0B/mDE6Wz5LI9lKmAfj0HcrquZhg6jhpKqKwQbwLTXmaJOdVil/+XLYWOGvnJSQp49yjKp0HUtKZ2Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=oAKOcfzd; arc=fail smtp.client-ip=52.101.96.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="oAKOcfzd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iAFfTJO8ojylEH+hHlBZePjLCcE0eAxZeHsGoMSy3qidMjATdlVnpFrkofWCXI2OuQVcJeEgMgqZPJttYdPpbmHbiZcGXjm3/sBp3yCMHch00H4VCJ98r87dfwwHKz9dcO8TXmytWkvi+HkZbLZ1kfE3LdV91m1uICwzhmeoeSc6a/SIQrZz27NjRBcD7fqpTRPXcufCEtkhIIRT44l8/FDKIiEaKh3CWmMFOt7MJ/GhUZ3rGZH5xIgSrBuf6+28AHkseHraFNu769zWE6e5rUKqR1kUhtiGQXgg3qzJiN2Mzpt53NSPPlHMAa8eaWEozhUeZOLG24IrOUDt5+MPjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXhVRgl85wuRcvaMXiSEbAEkYhmJUzpAzdTGo9eVxqE=;
 b=ZodEbi7wKvuXJY19h6gLKy1lJS+Dp+bysCI96fpLtE04+L8lR9DtSq0B4dLdAVuOLj1A9/JT+IgCfrH0CTzrfUkjNuzAINgwfjgfx9onV0qz5va3YzMD34yTJ+9gOdPkNJaHcwxtGwBzLtBZ5wSCU5KmggC9SGZkITKpn5qD+w6OLiXPGkYXWNtzhBnu8xMoS0yFhK8IpCl0sA0wqiZ0xxIm7UpQFe/dOO9aAJBw6gznEUFr8v/w5mk1RMpB27hyESfZM5xewqrmYp4+f83ZKfdTtlqVfYC4dbtVxQGqO6pE6Yv1YMIfG2SC83ZfBFz0mfziri0N8UilX9G7OxS+fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXhVRgl85wuRcvaMXiSEbAEkYhmJUzpAzdTGo9eVxqE=;
 b=oAKOcfzdTt5MR7PkQ7mEtLa2T5KrJU4jxjctg1zF2/1x7Hio9xXhm9MiOeQG7mvZd9iElMGNDTqVNppzBFmXR3Q9VQMLT0CwsNmzTTFR4iUHTkIsEbMHa3sLDn/H+a95F1nACPoTKbjIGW98OnunSnQUojU2XPLHi5pq6WddVAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO2P265MB3263.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:156::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 16:28:25 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 16:28:25 +0000
From: Gary Guo <gary@garyguo.net>
Date: Thu, 11 Jun 2026 17:28:07 +0100
Subject: [PATCH v4 05/20] rust: io: generalize `MmioRaw` to pointer to
 arbitrary type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-io_projection-v4-5-1f7224b02dcb@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781195301; l=7828;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=goWQJ0ThqV+Q3smjs/gu7WOWjqv2qJjkHt4GzWinuVo=;
 b=k9YiAb9v4cjRQbAUWlvlUCXKL93Pd9Fo67RJvaIPB6uOa0CnkJysKPFRbF7Lm2L9T7iV7wP3S
 t7IRyG0IPMlDqEbf2n1VPQf/9js1fMom0hoZQMUQmKKRwml38WmrMkD
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
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|LO2P265MB3263:EE_
X-MS-Office365-Filtering-Correlation-Id: b99ee732-e639-48e0-68f0-08dec7d67654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016|23010399003|18002099003|22082099003|921020|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	7r6m24igwOsLg45G6pno7N/Khc4SYROsYj3MCHe0eyryxioFdhI8YH2zda6d4DA+Yhdz3iYIq+JPCPmBlXfJ886fPbPDcr1wOemgcZ8kl+mzD7NV3v+V+SB/667dQFBRuAD0V3VaWCBYtAey3q/AdO3ny2kQ0S7CIihHqrrHQuSA8C8WOXyT3znC22B1JKUhJRst8+JJrvCe6U6BJVX78YgGyCz/3hsbKZyBPI7izahPT47jKAe5eeFWz6ePj3+bKrIR3pFZ4/2qcZVCbYPTeVsBAH5Io4aUgsc9qmUuDUaYUdMHeNNjgD9yvYVt4bKHBF0f7yj03ORpB44ecN+HyW3jl5YAXaFqadjJZ/jialmANCSeA1lpwrAZ5OPu47pleK4psZs7cEn98ICZcTR/nIbECD9sEzXTdQg1NZiN9zjBIG3dpnMaO2IdO/gEr6lyc5GZhyCccOzMrCsL85jSWvJBj560dt23w1YXDR/vudhMFa+p9X/Ms9T8q+TRBgUmavFS9BzJa3atvgLCz0aPhC20Tmth+N1yhovUowkI872U+KnEWt7kdv76iwSZ75X0FoBP0m/v4A34Ie/8F/2oSNmK79ZuVBU7R1UJueI/lb2mM3gpJQxPgX49ZwFBXaVQpDZQRzxsR6U5rjuboAFiOoDMA+D8xTMKATBUsCKnS2NlD+Vppj6bFhW6RQt2vxqLFpjkadpA2KnyC7ZGGyQhqkqSCejbtZ3Qt/pQshbJpMs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(23010399003)(18002099003)(22082099003)(921020)(6133799003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmFXeXVKQmJXVVpqMGt4RnVmZnNseG9vL2FzNG9WRXM0NnRBR095angxeTJU?=
 =?utf-8?B?WHl4eFMrMDQ5U2NNclRlbWFMMjZrZG54M0NYYjdaUVNRUU1uR0xWVUVFVVhh?=
 =?utf-8?B?VUhXclRKalNBWFYvUnBRQk9qemFSWmlRdCtSUzhNZGU2eU5OaHlvUlNCQWUy?=
 =?utf-8?B?Zzhvc08zZ3Q5UFZpZURBeXdSS29VSm5ldVhRR2haRjFUaVprcXlGcUwyaEZw?=
 =?utf-8?B?NWpUNGdpMCtwUVRyRkFCbkRhcmQ3aFBCazl6bUtvUWE5UDZZakJ0bjQ5dWxw?=
 =?utf-8?B?d25ZSFJHNTdUMW02bjlNbkdFZVhyMVN3MldVWUtoa0lCcXlteDhENGhIdVho?=
 =?utf-8?B?ZGR0UUljMDNuRGNKUlVDc09BMjFHSm8xc3F2UVRzUTgyRmd5bDFwa09DalV1?=
 =?utf-8?B?YkZEem1nc2REb0h4R0orb1Z4ZnA1STBOTysxU2FXUGFmMGdaUlNPSUVkUXBr?=
 =?utf-8?B?U2tkOTFLY3QwUStPQkNpenlUN1VsZGo3bG44cmNuWThnaEsrZlAzdWM5Uk0x?=
 =?utf-8?B?YmNXQ3B5VkdjSWMyWDkzVERDd3U0V2tWbXFnR2MzdTZUOFdueW40UGVXL3Rm?=
 =?utf-8?B?MGZnVTZrUnBaWFZZelBKWW9RUW9MdXA5Mjh6c09Zdkt2QjhCU1JkUzY0RGp5?=
 =?utf-8?B?bG52blN6bXJJcGxFeFpMTXc4TVk1TUhYSk02QlZ1WGg2WUNPSjdVazlUOTJn?=
 =?utf-8?B?UXp1cDEzejZlWjBIaHNmMnVYSnlMcU8vVmZDamNrYlhxdHU5M1JrbzFzdFBi?=
 =?utf-8?B?RnZkQzd3Sk1nUEJCYkU0VVZQMnpRaGRHd2d2cTNYSDF0MXR0UUg4dDBXOUhQ?=
 =?utf-8?B?OG44Q1c2dlQyVmxQc2V6Sk1jTkdDUDdBYmowQ1F1bDF0dTdWaU9mcExickF2?=
 =?utf-8?B?WEE2STREU1dRV3VHLzQ5b2liNDBOWG1OTkhRcVlWNk5Jd3U1VXpVdDl1QTVV?=
 =?utf-8?B?RG9QenRBVU1CODBtL0lSK0k2SFlmc3ZEbTVxekdtczR4RnpOcnNpblJIbmhL?=
 =?utf-8?B?d2lOaDNMcm1raDZtcTJBVVcxb3Jjb1gyRHZ5OUtWajgwblJhSk9uSXdXd1dy?=
 =?utf-8?B?dFJ2a2ZZQmxZdEM3L3FnWGw2MmJybEVtaXVEQU1JREdiVlpXa2RQancvb09o?=
 =?utf-8?B?U3pHL1VtOFVhcGFrblN4NmFXU0tUWlBnYXFkRnd2ZmhKSk9lQk9hdXllMWJi?=
 =?utf-8?B?U2s3YXNrR0RyVWJOVUJKZ3V2ZkUyRW84c1ordkJJTzBIaGEwLzdBdlRkeWhT?=
 =?utf-8?B?bGhuRGxuSSthRGtmS2Nra1UwUitiMWNYOERvM1hVbVVYajl5TXBpaHc2aHdN?=
 =?utf-8?B?cHFJUkFwdjVQa1dMZ2V3c010UzRMM1BmRGNCKzhDbGw1UWo2UzRMcVZNUm1i?=
 =?utf-8?B?bjF3ZXRXRGlRckxzVUlBeXlFekt5V3JxVGRrU0t4N2V1Z2N2dG5KWHZpOGdv?=
 =?utf-8?B?RlZiaDV2NGFDVllWRzZvZG5vTmU2UTlVcFlUYXpzUTE1Z0VxSTROSzg3eVJB?=
 =?utf-8?B?ZmlRZG5CTnJOeWRHdmZqQ1dpODRZaTFoQ09jWE5RZUZrL011Sk1qbUtvdStY?=
 =?utf-8?B?WXN1SjlENjBEVmpUblpUOW4rdUdxMll1ZFBPeXVXVkhleUkyT2ZmRE1pUUhi?=
 =?utf-8?B?TGZOUklwQWtNaWh1T3dIeDhNSHpmcGlIYzRmbFIyU1l1N1VNWXdHSnFJd1Ru?=
 =?utf-8?B?Y2RTVURLNWlwTzdhMkFzTmhwTE94dzhRTUtXSzhvYlNOR3JJQVJOQkZiNUNq?=
 =?utf-8?B?UzZEL2NoTFdWYk9iVk5wSmFsS241MHplemN0dnllY0MwSjUxRWhhMjN2bmVx?=
 =?utf-8?B?dHZqUE0vMldSL05Xc3BueTVzU1pQeFZseERXNk1xd1JjL2gxWXZOVWQrT1VZ?=
 =?utf-8?B?MGNnUjFTTUNyMzRVYlZvcHV1M3JxZ0FaVUtIbFZGL2M0QXN2MENhRnZYTTFo?=
 =?utf-8?B?N1lqMklvaTlsNFdUSHdoLzY5NitYenRwY3VRRlB6eGRzNzZ5Z20zVXNOOFor?=
 =?utf-8?B?UFV1dlBZdHNLRHoxamlmSFJJTmxrbGxIalUrNWdJYWs4OW8xcjNKa0xhd2ky?=
 =?utf-8?B?bEFtRzFmRjd3Y0lYYWNCVlo0MzNVZzh3aENCQ3k5a3RyRUxHRzAwVDlXZXhr?=
 =?utf-8?B?aVV1U1pNcVhCQ2hVSWVnWjJZc3pWN3VXL211SkdoNUJ6ZXVmL2Y5L2VnNENC?=
 =?utf-8?B?Zi9QR09pdS9NQlFkcnNQSVdZMS9DRUZHQXN3SW1sYytndnZLWG9sa2lheG94?=
 =?utf-8?B?emNvUVdnMDFSSzJGeU5ieENxYzQxYXRYdGFKWVd5dlBIRW5kWnRVQUJKU2pp?=
 =?utf-8?B?UkhqS0hycUFvbTUvNjQ3Y2ZRRUEvVmgxczN6bXRQYzZZa0pJUUVjdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b99ee732-e639-48e0-68f0-08dec7d67654
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:28:25.6254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: teoM6klYbyYuxL0oH1f4Y5YRed6MAXRiU0h6y8foAl3yBELbN7i5TpmdWiorua0MstlaqzMKGzuSOFfgHdSCmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3263

Conceptually, `MmioRaw` is just `__iomem *`, so it should work for any
types. Update the existing use case where it represents a region of
compile-time known minimum size and run-time known actual size to use the
dynamic-sized type `Region<SIZE>` instead. Rename `maxsize` method to
reflect that it is the actual size (not a bound) of the region.

Implement `Clone` and `Copy` manually, which cannot be derived due to the
generic parameter. The use of raw pointers also cause the `Send` and `Sync`
auto trait implementation to be lost, so add them back by manual
implementation.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/devres.rs |  7 +++---
 rust/kernel/io.rs     | 67 +++++++++++++++++++++++++++++++++++++--------------
 rust/kernel/io/mem.rs |  5 ++--
 rust/kernel/pci/io.rs |  4 +--
 4 files changed, 57 insertions(+), 26 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index ed30ccc6e68e..d0c677fd7932 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -70,14 +70,15 @@ struct Inner<T> {
 ///         Io,
 ///         Mmio,
 ///         MmioRaw,
-///         PhysAddr, //
+///         PhysAddr,
+///         Region, //
 ///     },
 ///     prelude::*,
 /// };
 /// use core::ops::Deref;
 ///
 /// // See also [`pci::Bar`] for a real example.
-/// struct IoMem<const SIZE: usize>(MmioRaw<SIZE>);
+/// struct IoMem<const SIZE: usize>(MmioRaw<Region<SIZE>>);
 ///
 /// impl<const SIZE: usize> IoMem<SIZE> {
 ///     /// # Safety
@@ -92,7 +93,7 @@ struct Inner<T> {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(MmioRaw::new(addr as usize, SIZE)?))
+///         Ok(IoMem(MmioRaw::new_region(addr as usize, SIZE)?))
 ///     }
 /// }
 ///
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 3b478dcf10f9..c64b12ade123 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -89,37 +89,67 @@ fn size(p: *const Self) -> usize {
 
 /// Raw representation of an MMIO region.
 ///
+/// `MmioRaw<T>` is equivalent to `T __iomem *` in C.
+///
 /// By itself, the existence of an instance of this structure does not provide any guarantees that
 /// the represented MMIO region does exist or is properly mapped.
 ///
 /// Instead, the bus specific MMIO implementation must convert this raw representation into an
 /// `Mmio` instance providing the actual memory accessors. Only by the conversion into an `Mmio`
 /// structure any guarantees are given.
-pub struct MmioRaw<const SIZE: usize = 0> {
-    addr: usize,
-    maxsize: usize,
+pub struct MmioRaw<T: ?Sized> {
+    /// Pointer is in I/O address space.
+    ///
+    /// The provenance does not matter, only the address and metadata do.
+    ptr: *mut T,
 }
 
-impl<const SIZE: usize> MmioRaw<SIZE> {
-    /// Returns a new `MmioRaw` instance on success, an error otherwise.
-    pub fn new(addr: usize, maxsize: usize) -> Result<Self> {
-        if maxsize < SIZE {
-            return Err(EINVAL);
+impl<T: ?Sized> Copy for MmioRaw<T> {}
+impl<T: ?Sized> Clone for MmioRaw<T> {
+    #[inline]
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+
+// SAFETY: `MmioRaw` is just an address, so is thread-safe.
+unsafe impl<T: ?Sized> Send for MmioRaw<T> {}
+// SAFETY: `MmioRaw` is just an address, so is thread-safe.
+unsafe impl<T: ?Sized> Sync for MmioRaw<T> {}
+
+impl<T> MmioRaw<T> {
+    /// Create a `MmioRaw` from address.
+    #[inline]
+    pub fn new(addr: usize) -> Self {
+        Self {
+            ptr: core::ptr::without_provenance_mut(addr),
         }
+    }
+}
 
-        Ok(Self { addr, maxsize })
+impl<const SIZE: usize> MmioRaw<Region<SIZE>> {
+    /// Create a `MmioRaw` representing a I/O region with given size.
+    ///
+    /// The size is checked against the minimum size specified via const generics.
+    #[inline]
+    pub fn new_region(addr: usize, size: usize) -> Result<Self> {
+        Ok(Self {
+            ptr: Region::ptr_try_from_raw_parts_mut(core::ptr::without_provenance_mut(addr), size)?,
+        })
     }
+}
 
+impl<T: ?Sized + KnownSize> MmioRaw<T> {
     /// Returns the base address of the MMIO region.
     #[inline]
     pub fn addr(&self) -> usize {
-        self.addr
+        self.ptr.addr()
     }
 
-    /// Returns the maximum size of the MMIO region.
+    /// Returns the size of the MMIO region.
     #[inline]
-    pub fn maxsize(&self) -> usize {
-        self.maxsize
+    pub fn size(&self) -> usize {
+        KnownSize::size(self.ptr)
     }
 }
 
@@ -144,12 +174,13 @@ pub fn maxsize(&self) -> usize {
 ///         Mmio,
 ///         MmioRaw,
 ///         PhysAddr,
+///         Region,
 ///     },
 /// };
 /// use core::ops::Deref;
 ///
 /// // See also `pci::Bar` for a real example.
-/// struct IoMem<const SIZE: usize>(MmioRaw<SIZE>);
+/// struct IoMem<const SIZE: usize>(MmioRaw<Region<SIZE>>);
 ///
 /// impl<const SIZE: usize> IoMem<SIZE> {
 ///     /// # Safety
@@ -164,7 +195,7 @@ pub fn maxsize(&self) -> usize {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(MmioRaw::new(addr as usize, SIZE)?))
+///         Ok(IoMem(MmioRaw::new_region(addr as usize, SIZE)?))
 ///     }
 /// }
 ///
@@ -194,7 +225,7 @@ pub fn maxsize(&self) -> usize {
 /// # }
 /// ```
 #[repr(transparent)]
-pub struct Mmio<const SIZE: usize = 0>(MmioRaw<SIZE>);
+pub struct Mmio<const SIZE: usize = 0>(MmioRaw<Region<SIZE>>);
 
 /// Checks whether an access of type `U` at the given `base` and the given `offset`
 /// is valid within this region.
@@ -839,7 +870,7 @@ fn addr(self) -> usize {
     /// Returns the maximum size of this mapping.
     #[inline]
     fn maxsize(self) -> usize {
-        self.0.maxsize()
+        self.0.size()
     }
 }
 
@@ -850,7 +881,7 @@ impl<const SIZE: usize> Mmio<SIZE> {
     ///
     /// Callers must ensure that `addr` is the start of a valid I/O mapped memory region of size
     /// `maxsize`.
-    pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
+    pub unsafe fn from_raw(raw: &MmioRaw<Region<SIZE>>) -> &Self {
         // SAFETY: `Mmio` is a transparent wrapper around `MmioRaw`.
         unsafe { &*core::ptr::from_ref(raw).cast() }
     }
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index fc2a3e24f8d5..9e15bc8fde78 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -229,7 +229,7 @@ fn deref(&self) -> &Self::Target {
 /// start of the I/O memory mapped region.
 pub struct IoMem<'a, const SIZE: usize = 0> {
     dev: &'a Device<Bound>,
-    io: MmioRaw<SIZE>,
+    io: MmioRaw<super::Region<SIZE>>,
 }
 
 impl<'a, const SIZE: usize> IoMem<'a, SIZE> {
@@ -264,8 +264,7 @@ fn ioremap(dev: &'a Device<Bound>, resource: &Resource) -> Result<Self> {
             return Err(ENOMEM);
         }
 
-        let io = MmioRaw::new(addr as usize, size)?;
-
+        let io = MmioRaw::new_region(addr as usize, size)?;
         Ok(IoMem { dev, io })
     }
 
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 505305cd9b86..42f840d64a6f 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -139,7 +139,7 @@ fn maxsize(self) -> usize {
 /// memory mapped PCI BAR and its size.
 pub struct Bar<'a, const SIZE: usize = 0> {
     pdev: &'a Device<device::Bound>,
-    io: MmioRaw<SIZE>,
+    io: MmioRaw<crate::io::Region<SIZE>>,
     num: i32,
 }
 
@@ -179,7 +179,7 @@ pub(super) fn new(
             return Err(ENOMEM);
         }
 
-        let io = match MmioRaw::new(ioptr, len as usize) {
+        let io = match MmioRaw::new_region(ioptr, len as usize) {
             Ok(io) => io,
             Err(err) => {
                 // SAFETY:

-- 
2.54.0

