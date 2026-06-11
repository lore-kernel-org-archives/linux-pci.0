Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022092.outbound.protection.outlook.com [52.101.96.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D9130674E;
	Thu, 11 Jun 2026 16:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195312; cv=fail; b=JAGnobbFchSrkBRaWHIpzy1E1YfNL8Mtj2WJ8lZzrifC0S4WUaWqKIfu3P6nAx4fH9wProhxXYKnSZWhWp/2/yqWmZ/8gsyt9GH8razSqpx6UTmR4RY6AqOMtMnkqjek1d7Tu2tpTCbZgW5AUxIM8nKEgORdqDkZ9qbx6STTqXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195312; c=relaxed/simple;
	bh=3aH7apFce79+fBGN0fdMkFZxI0uuMM4f7+WP97okgN0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pJdSMR2T3vy2Yup5BeZHb2puTzeJoWS/k8hlAwkzemBNi7SB4+NjQLU5nnzZKp6ZNdU4QZ7JGUDYNZ64dIyYMeUVkOeTQlMTA3HT6QlBDZQZk4Rm17umgkNlJPdr7r525mwTha1lpqnrXtGPjs0sd6ME8WRNvimqkBMsrnIAhdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=c/sEZR31; arc=fail smtp.client-ip=52.101.96.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="c/sEZR31"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZyMx+pitQt31vYp6Nyx4QsUenf2knBM+nKYSf0TQGMaMyUtA2b24X5JV9DEbSNEQjrkHqJaCe5G8Ar4ht5SsRrN+VeKkk5RryZw80NjBdzQXTxarze8uzI6ZBMu06ePteZKzNu1NvPuJ7+MaGc5STCoXhA04aqv6waM7KzWkcGG9nilj2Td3lP79zGhuBG9yWDvDRZEVxnUCr70Ax5v4nRc+T+hKOm4uYJUUoxg4drBCfLDyxO46OzhM0y6QtPA1Li6yVDIIsj26cIMRpSWMO6pSMc6tVTSG7r+CZ+okQJDuzr1WIVidisnqQJMgE9LqD8Ag1iXLrF9qXRCkLjyEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCtZi8vaoOW5F3VXQAVNZ0x0Te1tIv7kEIU1I+rjS88=;
 b=xMtWFIyd5Aln9YJrcWVziPOHzzknaytIxQP/ZF7kAQvrz1QPfEanirW8Kn2xzLWF+kZaPftk7Uv6UwCT1HVFNkIwvGaoI9PEsiRozHpbYmLLjhwJTNFjuzd00mlbck561VitFI91yXfLk5h75dsPfhudPteAfD+dWOBIBGc+5fecnufubCTXEbHe+5WTg/BulInNA1EloGJ+YLrZP2/WgVVhalqTM5LwUC1MhQmoPyMZ7nArT4LkGFZDRWypHefQlfq8MBWWLOVFsZQVyfJ58J0DPCeqy3JKPrqfYPzoXFOxiXVTbkR03asziB6Lw3y59kKjLsbUK6c6XiNWT2qRaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCtZi8vaoOW5F3VXQAVNZ0x0Te1tIv7kEIU1I+rjS88=;
 b=c/sEZR31VCjq4lMRGZxBtMDm3fqmtAb9yOiCq+5mUo5T3jMqgkdD/IX1/tMgxMrO9VYCIKsl/eqwuSNZwMjfVXoaDX7970HKYmsj1A2Eacb3HX3o7s/s4o14wTw5Iw1n1WecWiunUyIe5E9H5zlkYOk8pnaEB7rX0A8L933maFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO2P265MB3263.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:156::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 16:28:23 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 16:28:23 +0000
From: Gary Guo <gary@garyguo.net>
Date: Thu, 11 Jun 2026 17:28:04 +0100
Subject: [PATCH v4 02/20] rust: io: add missing safety requirement in
 `IoCapable` methods
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-io_projection-v4-2-1f7224b02dcb@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781195301; l=3721;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=3aH7apFce79+fBGN0fdMkFZxI0uuMM4f7+WP97okgN0=;
 b=D8b+7BOfC/hKCdA9Z7KZv8hfdDCwKE2hOwsz52LTzcF7tlkzdVjoTTLUT1YkZn+3yj0N7EQCc
 lRxBy6oAaPAAHFCeo12fiiiDuuexMRvNDfBdsQx9xMZYUqKZWgc1xaA
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
X-MS-Office365-Filtering-Correlation-Id: 8c6648e6-27cd-4028-07d0-08dec7d6753d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016|23010399003|18002099003|22082099003|921020|5023799004|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	dlMc24V4KaZbgwK3tS3uDxgn5jQV3F3k05WVWNU+fq/71EEiVimBQfJf/d37YyQf+AgXVbmPhMOvDrYVVahqyrmKMi/hmUXX2m1GJGYlAGPANknuz2wzKtIrBcKNHMjJQdHzAH1/9B+Xzvjhp0hugqvdeFoMeZrrC8MVzTvZhFfUi27Qnc8wrGRk6MBdmOqmIWBj5CtQqf8RLwBXMOwLMhCOcB2lgyLYLLxtQD375SkbySw5+5YvGMxhABfV+Wf+urMbFS39eAdbetNKhAPmQA5z2WAalWr0JC5oR8xyaHOyp2XaRIHt8EzTxuioJ6V5O9wN2VrWX68RVDYJxfWvk7LOrvsGugdO3uVIuHLgJBk99WuO25yaOU4Jn077t4rsUdN3qaSM/rUPjoSDjKRRES77Nyg2cocRom/iKIJYtTrY1DfBK+iClxpRYYPBdsyq491uP1LNbjx11eTWrcj7oc00r2R1A2aKm6i+ADxWXRYHtjKE4KPW1rSbuCaa+Kvqu1xGA3/hhBjdsJ6aBb9pu+5Bu78i824grDENMnSv6vIaa1/8J0eFy8U9yrdUb6VE7tvIpm2ZbMIbzCXXsL8uuO7+K9haJJNaqo4MJ5tELuXCxbEl35jY6SNahjiNpj0ZzmIGGUbsEU+HI/t3Lw3MKyWfoFKz50uH0zF45Uz7/mtYbnlEVg/0dD6DjXgpPBg5hj1d3l7S0NsciCdT7+41wm+IvVFcbZ5R92zctTjlZm0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(23010399003)(18002099003)(22082099003)(921020)(5023799004)(6133799003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZC9FNGl4UXNPY1k1R2VXV3plaEUzWXQvV0dBbitjakxPcWtCWFFhR2JRU0tR?=
 =?utf-8?B?Q0xtejFSSEY1a1Q1N0hvdTJocS8zOVNtcWVrQXR1YkZ3RUFXd0FjWWF3cWNo?=
 =?utf-8?B?RFYxTDhCQnoxTkpTdXNDelJnQ1NBdWZ6Y0VkY2l6Vy9yNlBaVDBWUWRFOWtJ?=
 =?utf-8?B?L0FhN2pGenNLTWc2L2tQWGhidGR3QTVaTFZ4OWN3Qm5GQk45THBLV3F2VWs1?=
 =?utf-8?B?Vk5ka1NySms2SkJ4ajlaTkdyUWlRRkI5S2ZqblhYSU9mUlljQzByMjR5NjZy?=
 =?utf-8?B?RlBSc1NjSmFqWUM0c21kS01tMjFEaUZPVUZnQWt1TDV4MUxZc3dFVG52b0ov?=
 =?utf-8?B?OWxSVW5henp3R3FXSEY2RnRuRlJXSGg5NzBaaU83SXB4dFJBcm5SYlJQQVFV?=
 =?utf-8?B?bHFzdEhKSHFJc1NrTmlFY2ZYbFFjUGIyL1BvYmVFcFVwOWtMRkVvcjMzSUpB?=
 =?utf-8?B?OFlIeXFDMjdiWGhWRUxtUDM0c2ROMnhrZVZyeTBOdWNRZERwNmhOQldsVFVL?=
 =?utf-8?B?Z0F3cnVPckRJcjRjUWh4MU9XS1E0c2FiNklwLzZSeUpmVk5NZW92RmRtQkI5?=
 =?utf-8?B?MmRNWmNIVk1XNDFQSFQ0UnlxTnpQWCtiamM5UGJ1emcwWVdLZGJGSVVoZCt6?=
 =?utf-8?B?M3luU0wvMFFSTzBlZzR2cjIyTFVUeTNQSlliM0tZbXd6MTNxQjQra0d3eDBN?=
 =?utf-8?B?eXdnN3B4R2YyaFRzSEVnNzltSnhHUFY2KzRHaStMYi9HVDFMeGdySzlDcVIz?=
 =?utf-8?B?eHBiOTExR3VXUFY0eVN6Z1lGN09JU3RTTlVQZWpodXFyUFp3Mms0NHMwODdz?=
 =?utf-8?B?L0EyQ1ZyT1k5eGI2YkVrdGRVQXpQcVdjUGJ0Zlg5d2czWTMwcUY1L0t6WnZ0?=
 =?utf-8?B?NVRTYTNSaEU3VHd1QU81ZU85MTBmaGVnSSthekVqamtUK1lySjcwWHVLb3kv?=
 =?utf-8?B?UFg4S1ZoY2tGS1I4aWsvQkhRVFRzTWpGSzdqaHdOTkNXSldTOHVTVzRrN3lD?=
 =?utf-8?B?cmxySFZjbWdnalVhQWRjc0hHUTloQXllNHdNYWZiK0VBc0cwZlRtb0MzOC80?=
 =?utf-8?B?OCtJM3NmMXZId1lsN1U3Mm5YV0NRWThiMTRxUTFCUnhMb0hzbHZwRXRhT2Np?=
 =?utf-8?B?WURIWTVqTlU4QytPcUliYlZkN3h4d09SY29Nb2dPdUR3VmRHZlpmWHJGeDdZ?=
 =?utf-8?B?MTlqME04N3A4WUhTclBiQzdHSVNhODdHMFBoQUJOZFBMTmZQNVF3WW01V0Jm?=
 =?utf-8?B?UnpYRFc2SG40Y1J5TTZFZVJYZVp3MWJEd244c3BiYVZRWGorakpESG9hZHk5?=
 =?utf-8?B?aHlsdlFvanpXK01Ldit1TjdXYVVDRHZLMFRXbzh5d2hvR0dvak52SW44aGdT?=
 =?utf-8?B?bDYwV1BPTUVFaG1wVllDK09TT2ZDbVpmRHVXT2xpTVEwL0RrSWlMVnUzeTZU?=
 =?utf-8?B?SExWclRQY1hFczNRMm1mb0xCSjc3eW5xU2N0WUxxZmVTWit5NTYvWGxNMlVT?=
 =?utf-8?B?eHpFTlFGM0U4dkthcWc2WmdNMkVpSUxyTTVRSUlXV0pOUVZpaHV5YVFpOGV3?=
 =?utf-8?B?d2s5WGhsQm5PcnZIVCtXSkNOM2U5SXRpYmpsTzZKTXltaGthY1F5a0NGRkJ4?=
 =?utf-8?B?VmFrdnhvQkdaQUtYMkRITTgwZFUyL2FnMmQwY0k3ZGxyS1JtUjNYdUxKUkZl?=
 =?utf-8?B?OE9VQnF1UnFDR3IyTDAyQnp2ZHZGSXpUV3FqVWNFV0t6K3J3eXJGWVZwQjZV?=
 =?utf-8?B?MnNGcmQxdTFZN2NFaGdIOG4wRzBENXdhYk4yQVh4ZFRqanJMbHVwZlJGTzAv?=
 =?utf-8?B?SUdoNDBJQ3UxbVRDWFRDTTFUTVdHTlgvalQ0TUs3SmM2V0RHeENvMUZqU0F4?=
 =?utf-8?B?UVJQL2VLa2RGclFxQ2piVHR0UU12WGxqNS95UXBVNHAwcjVZdXE5dVJJMkZ2?=
 =?utf-8?B?MlpoQ3lvRytCUE11L04xYWJ0TU0vQUFTU3VUb1Bab1o4RUtZbmcvS3JJOTh4?=
 =?utf-8?B?SmFUZWd6VTArWGFmd1NWaVUzZXRlYldVam4rVk83cXFyQzhCcW1mcHhRL2dQ?=
 =?utf-8?B?VU5EYjRwNEJ5T3g2MzJRZjdWelBlRjFvTW1vQXlHRGo2VDVqVkkyT2VPNGs3?=
 =?utf-8?B?VE9NYXlpQnpyNkdUL2VWeTU0bkRxOU9CVjJsSXhPbjZjYnd1L3dIMDhRekly?=
 =?utf-8?B?T0Zab0tmMlBYSURRMTY1azJzdUpQenpoa1pweWt2UUN6MzZUcnYyT0JMTmU2?=
 =?utf-8?B?aVA0a2lBbnl1cnNvakxVYWl5UWNsdFhVTFR6Yjc1UDlab0xaVkc5S1RmS1o5?=
 =?utf-8?B?aEYyQVNKM1ZCaHlvZi9MY2lKenJyUGtiaWkwMXlUOGhoWjVPc1JaQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6648e6-27cd-4028-07d0-08dec7d6753d
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:28:23.7935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+tcCxjcYAGT7NawrOWsBSZfkzUhHv5S9iNkcjUXfz3F3k/5/J7b5N5V2NnE5zIg5WAlNeF82AojqvZPdwv8uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3263

The current safety comment on `io_read`/`io_write` does not cover the topic
about alignment. Add it so it can be relied on by implementor of
`IoCapable`.

Expand the check `Io` by taking `self.addr()` into consideration when
checking if `offset` is aligned. For the compile-time `io_addr_assert`
check, check using the known minimum alignment of `IO::Target` and the
accessed type.

While at it, fix the alignment check to use `align_of` instead of
`size_of`. The values match for all primitives (including u64, given that
we do not provide u64 accessor on 32-bit platforms), but are not
necessarily true for custom types.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index bef571dad6eb..fa9ae39ad9d2 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -196,13 +196,14 @@ pub fn maxsize(&self) -> usize {
 #[repr(transparent)]
 pub struct Mmio<const SIZE: usize = 0>(MmioRaw<SIZE>);
 
-/// Checks whether an access of type `U` at the given `offset`
+/// Checks whether an access of type `U` at the given `base` and the given `offset`
 /// is valid within this region.
+///
+/// The `base` is used for alignment checking only. This can be set to 0 to skip the check.
 #[inline]
-const fn offset_valid<U>(offset: usize, size: usize) -> bool {
-    let type_size = core::mem::size_of::<U>();
-    if let Some(end) = offset.checked_add(type_size) {
-        end <= size && offset % type_size == 0
+const fn offset_valid<U>(base: usize, offset: usize, size: usize) -> bool {
+    if let Some(end) = offset.checked_add(size_of::<U>()) {
+        end <= size && (base.wrapping_add(offset) % align_of::<U>() == 0)
     } else {
         false
     }
@@ -221,14 +222,16 @@ pub trait IoCapable<T> {
     ///
     /// # Safety
     ///
-    /// The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
+    /// - The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
+    /// - `address` must be aligned.
     unsafe fn io_read(&self, address: usize) -> T;
 
     /// Performs an I/O write of `value` at `address`.
     ///
     /// # Safety
     ///
-    /// The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
+    /// - The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
+    /// - `address` must be aligned.
     unsafe fn io_write(&self, value: T, address: usize);
 }
 
@@ -310,7 +313,11 @@ pub trait Io {
     // Always inline to optimize out error path of `build_assert`.
     #[inline(always)]
     fn io_addr_assert<U>(&self, offset: usize) -> usize {
-        build_assert!(offset_valid::<U>(offset, Self::Target::MIN_SIZE));
+        // We cannot check alignment with `offset_valid` using `self.addr()`. So set 0 for it and
+        // ensure alignment by checking that the alignment of `U` is smaller or equal to the
+        // alignment of `Self::Target`.
+        const_assert!(Alignment::of::<U>().as_usize() <= Self::Target::MIN_ALIGN.as_usize());
+        build_assert!(offset_valid::<U>(0, offset, Self::Target::MIN_SIZE));
 
         self.addr() + offset
     }
@@ -319,7 +326,7 @@ fn io_addr_assert<U>(&self, offset: usize) -> usize {
     /// performing runtime bound checks.
     #[inline]
     fn io_addr<U>(&self, offset: usize) -> Result<usize> {
-        if !offset_valid::<U>(offset, self.maxsize()) {
+        if !offset_valid::<U>(self.addr(), offset, self.maxsize()) {
             return Err(EINVAL);
         }
 

-- 
2.54.0

