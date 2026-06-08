Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020080.outbound.protection.outlook.com [52.101.196.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9DB3F4DEF;
	Mon,  8 Jun 2026 19:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948781; cv=fail; b=DB5DXJRvVg1YsYecjYb1+Mt84fHo6awfXOcyurGuZ7URVIJlAFD90a8FXmyoSSHWghxgmFp6/bFuf1iVk2gIaUgWl0tpJQRFm87uwxTR2LoYp05bnFuguoZQ2sOqepekf2ChlpEE2KLnan7/rCvZ2y3IYBW01ju/kFvGm6xGGgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948781; c=relaxed/simple;
	bh=c8KGbabCBL6sAYhen1qcmvo3+fDJott3INnsajYTRfw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lTysVpg2qe2/BcPY6svM89bapvYMOa1/Lte5g5RWleZ3Ie+H7xv21BwTjkC/WaUxnfGDIY5QpvZxmPQOlt3JAHW06/a/vWWKYMftOsF5dtLbQMtpEd17fepqgpVTgqasulkNWyRG8mGdnJ7pYdtoc/8+UNmyRBsPN4d32uilOtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=CDGgfbBD; arc=fail smtp.client-ip=52.101.196.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="CDGgfbBD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWaUddGdCZco4ZH2PE9524tBoRaSEvYHNXSi1NfwQd/6/1W/SgFcdH6ytlg9Kq6w4//P6/yQ+ncioO7zbRooI0uAvDyB0TKafuLQpcO8bvW4/nR6VkiV7o6NvXwa7FQrF+S5LzUIvKrxnUZtHtii3zUCmJ+Tc7kGnH5P7N52WVSS1YPO0OlRtaU8IlQ7z4D+PeTLqhQcKc9yE20fHrsaf0CMoOLsV/SRQ038QDvxfW4B5QfMd3vs//oQmvAc+6qGUpEk2LjDGQHUmtwECgWMoVShu6hGW3CWrnw08lYVNjo/neMnMn5mysq0djrNZjtboY3bih1Qxfz5mMPc70DwAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLY78DnMjTBxpAlQ4zjOKgVSGoGLmiVXpyredJYtrDQ=;
 b=vqqppThUhgnF4j+JLPC1OG7jGS5F5/UzxYS0SoD8q5jUikZiJdP++VW8Ip/n80dyv7C7KQ9Zb6ikVob5yWfjZY+c+87aOTTBmxd1X2TaO53RXX/ppica2eVrd+XSL89xJ+Bst73S6jhuqxe2rqYplbnn+vFstW8ku6jChodBbM2nB7djliMzOLg7GjtpMsxSGkjyUgFjROzhXT2KVOti6R/xDR1C9uwMv/BfTkXSnMTSVymWO4LWnS6cNWyZhnXSzPKvxaK4tvQNc7oI3UoXnjZiFkRzl/XVa54yvh+/u+UiApCmP98noaW67KpecDl+Fys6NFUcN0ddcnqruLaP2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLY78DnMjTBxpAlQ4zjOKgVSGoGLmiVXpyredJYtrDQ=;
 b=CDGgfbBDNg4SL4HWgBHDhKaAu3dKJQrW9VlesMtVMsTjVn6JSR+LCVmM5DCyAuJemHKBXxQmK5VYbmridpD2lBFxD8xYeUTXvh3dA2gXkdPnX8eZkTAkbYoEtDxwg46AVC2Z6rSipo1tI1yY3DL4tC5h35T4oqYvlUHjLB2CYS4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7398.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 19:59:15 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 19:59:15 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 08 Jun 2026 20:59:15 +0100
Subject: [PATCH v3 18/19] rust: io: add copying methods
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-io_projection-v3-18-c5cde13a5ec4@garyguo.net>
References: <20260608-io_projection-v3-0-c5cde13a5ec4@garyguo.net>
In-Reply-To: <20260608-io_projection-v3-0-c5cde13a5ec4@garyguo.net>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
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
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780948747; l=18950;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=c8KGbabCBL6sAYhen1qcmvo3+fDJott3INnsajYTRfw=;
 b=lpEhKXaXkbrh4egeITFgbW01gTEkqLExTrk6euk8iWHZNjifc9sAFLT3GQCSdZ4xfZWvxMYZF
 Fo963E4z8YIDfpLAYRdMc6xq/FZ1QOf1YMxLCcFGB6Dj2xZNkv+Xo2H
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0344.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO8P265MB7398:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fe4b607-4aca-4373-b52a-08dec5986ada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|6133799003|22082099003|18002099003|921020|3023799007|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	/2vDcwhhWZvEFXw7lniYHKxoVIftRbve+wTA6dtGDONlyOZzgWaO+iKcaQjdEu0l9exQGUdL5NR4eTiagLLAXgQ26VgC+xmFpk2/zvnFhxFreZwdAfXeTHYjc0SJhFI8tcWfo7vUS0+/1zawoI2lYaxSFYQpsmgdNz2rFk2eGq/N2v18F0pb5KP1iYOsDkyU7LHDQHV9MLlNEsZoZNBYWVfAutGDiaWhJwiCzzfJiWTEqFGLtDjXnJuWffhsarzDcOwDBzRjl4PPlpWyapw0BoAYbBZoT5fwG67M0xwhesjyyza0cia5FWGYx1cDzaWixGT4HxfCypBRLgGgHm0oMyZEUAAI5UEUkHh/Scy0/dvwgzzvSIKoUd6B1pdt/0t0aAx961k/u3i269fJf5ULJEc//jS8pD+5FNeVmSjTDYvnbSe1lGpgbiYNwXFv2z8gZ2u9wJPaxXWH1xNW7lOauoXejzdjsTLY2e3tpbTtd5VGK7dXgY7Mz0iPDLhyab7EAcyXIJ9Xp1tw8/CQhn/9v8Mbj9Hxy1Yl3q7ProkeOrS6TuHam7S5afDMhm/FxjAYxRyIpGbxdhdPLlKVhXI6IYTSyCxvs+LVY29VzDFTyZS/LDE83Mr1MCqCMHREw0Gz0N8FUlQ3cARbUAgEmIG1A40QpxR3fAUgrwSeborcYNYOICIrXfTl97H6eb/qqFB0e7QAYuvJbe4PPyYJHvGjGBVVZbWL8MOYaHwu/negN/E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(6133799003)(22082099003)(18002099003)(921020)(3023799007)(56012099006)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUV2Tkl1aTg1YzRkbzZNMHdZK3AyYVZ5WDJFMmhRUzNmdlFHYklHZ3hrQXdF?=
 =?utf-8?B?YkNsOXNjdnR4ZkVnYzVheW5hNmViS2VmUUFNNFM1dFZrZktqdk1MMGJMaEJo?=
 =?utf-8?B?L1RKTHU3NW9HQzEwUzNwR1QvN3ppNkZWRjBtSnhRaElaZUp5NG5QMEF0cmdu?=
 =?utf-8?B?UTg0d2E3RkJFMVRrYXM3QXNEUUhrM1QzZEVEbU04MUFrNXB3SWIrRUVPMHhQ?=
 =?utf-8?B?VHE4MFRYQ2JjS0FFdXl2US9DSHJTK3NNT3pJM0h4OG90bVFmZnd6YTJzMU5R?=
 =?utf-8?B?OTN5WUZzeGhBS01FUmFVNk8xY2NnUGtvdTdrRDRuQVJsL200WWdocno2NlEv?=
 =?utf-8?B?OUw3WCs5M2MzTDFnd1c0bSsvVXc4Z3NTZ1gvVEYwaWpmbDNRQWFpVkVVaEx6?=
 =?utf-8?B?MFNzc1FXZHVwNmdPNkF6QWFCdzZSUWs5REI5dkNOTk9DYnlQbU5Cbm1Za0Jx?=
 =?utf-8?B?cFVsdldDZlA4MlZmYVJRSlRkWXNuVzk4VWxPY2FhMzZoK3JWdy9lZXlFUDBG?=
 =?utf-8?B?TEhyLzFpaDIzVTFwNlNGZEdFemhybXNpc3h5ZjBhLy82K2lTN1ZaZ29pcFpP?=
 =?utf-8?B?c2xtWEpieGtwcVN2aGc0ZExvbEVjWEZhcFMrTExPQUc1bW52Uy80K3d2bzVl?=
 =?utf-8?B?S1RxNGttMVJXZmpQZ25pVk1CRlVWWkJkM1JiN3FuRVk2Ym5nd2JIVE1UU2x6?=
 =?utf-8?B?SnYvUVB4ZzJkQm13dlQ3bFhwQVhkWVc3TndNUU9BR3o4RlRseWErdjBDRFIz?=
 =?utf-8?B?bkJaS0RjcDlpVnBpTEo2QVFFVk9JWFJPZHZDd1FiOHdzY0E5R3dFc2VINmx6?=
 =?utf-8?B?NnNkMHdWdE9YT05zUlV5WUZGTFUrVGl0UnRmMytBNjMrcEdkQU5mcFBmNlV0?=
 =?utf-8?B?ZVZ3QWtETGRwOEZmdUVHSXJaSytNQzN1eE45UDFXb29xU0NhL0t5emRhUDZh?=
 =?utf-8?B?UHpZeEtlR1BaemtKeDA4bmcveVk0NDZtWVU5YVRWakMxRUJrVitYSnNkNlcw?=
 =?utf-8?B?NDFWd0NST0NqUWNXRHBlMktwWWtaMEpUbWlPaTRueDZpSVFEVE5qTW5KNlJN?=
 =?utf-8?B?OVA5UTZXc1ZEMEJnZ1VFakRwOVJac1N0S2J3NmwvcWVIUEF0b1dqMDJLMTU4?=
 =?utf-8?B?SUpJZjd3MUVkbFpZR0VQWDZqTFVzTTZpNk0ybEhrZU5EN2poUVZNMzhFZ1Jw?=
 =?utf-8?B?RURkZkwrOTBaTnZoVFNFUndmdVdDYlFJTDFQMzExY0F6L3hxNUd4UXFUM0tq?=
 =?utf-8?B?WWF3NVhyanRhZlhzNHRURS9WT25MRWl2OUk2ZFo4ZVN0TWNRb2xuTGg0YXF6?=
 =?utf-8?B?RGdLa0FRL0pZRWJpSk1aSzFxQkllWWJ5c3FQTDFHQXpCVlFXTEV6bURQVFo0?=
 =?utf-8?B?UlhPNjZ6a2NmWHRnazlGeXc2Q1hWNEFVbU1ZcXBaOThBaThFU1FZSm56WXpN?=
 =?utf-8?B?b1RCVDFzV3J6QjdQZnc3Und4bkRRSm52TFlPTkI3M3hDa0dtdkJkZHpTbmRH?=
 =?utf-8?B?THdGSEdVSTVXMjltOHZOaHZNNFRrd0E0QVBBSW9xdk95K3drYVp3bHNoanBE?=
 =?utf-8?B?dlMrM29tMytwRUZreGd5NStPZUxXSjN3LzA3TUZrZ01RUi9NeDVTUWxBaEs0?=
 =?utf-8?B?ZVhud1pNTjZBbFE1akQ2cjFLUWkzU1JVdXY0LzJTQ1R2QVZoY1lvQld5djF4?=
 =?utf-8?B?cFJVS1BBNFNGR3cxRS9ud0JZYjA5WkcwZ1Y2YVpVZFVKdXhFa2c2MDE5V3ZP?=
 =?utf-8?B?LzNicXlLUXQ3R1ZEVndmV3FFekhadEZRQ2VNMVcrTlFIUUpsVE1PSktDaDJO?=
 =?utf-8?B?WFFpWWxsTjVsYURnNTQyeEc1WFJmeU5mNEw3U3MyZ0pKUEFDc0lUVVQrLzJE?=
 =?utf-8?B?d2ZlNXQ5MkJFTi9nS2N5K0Y5SnRGdzdKYURwSG8yaTI2RVNSMmNGYURYbndS?=
 =?utf-8?B?YjJrL3oxT3czczFZbVl4ZHdpU0FCMmFFdGpDeXJtQ0dpVFBWR0FmcDhxL00z?=
 =?utf-8?B?TnlSdDVQbFo1WStBMmhuVit2MFpHZ1JBbHpTYW5sOCt6bFl3T0Z2YWpXeWpt?=
 =?utf-8?B?UVo5WUhucThJQmlLMlZOcHMrY1lBSHB3YmRNRkFKTlJqclVqZnNncm1CVnho?=
 =?utf-8?B?S0duYi9Jck9FTWFHVUt4a0JmeEJhYzE1M05xdDFTZ3JNYklHNUI2eUo3c2lX?=
 =?utf-8?B?U3o2VldCY2JSR01rak9JOThlRUVoV1pJUlE5bXlHMTFIVzNzSUQwTEFqWFVn?=
 =?utf-8?B?eGs4aFl0TVVqRjF3ajRaWUpSM2pGUjNKVStRQnY4ZFdEbWN6QmJ2aUplOVV3?=
 =?utf-8?B?VzE5TGY5VG03WlkwN2ZkYzM3Q0g0UndiRStobmxmTkxrSGdwSlUwQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe4b607-4aca-4373-b52a-08dec5986ada
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 19:59:15.2505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZZ866gM6eSjnx1ilpUs2mxwIK5hFKS+yK83RRJhgGkytpS+u+SsvnJgvJSQp0s3Msy1hHrJbMJLx6LsaP7kZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7398

One feature that was lost from the old `dma_read!` and `dma_write!` when
moving to `io_read!` and `io_write!` was the ability to read/write a large
structs. However, the semantics was unclear to begin with, as there was no
guarantee about their atomicity even for structs that were small enough to
fit in u32. Re-introduce the capability in the form of copying methods.

    dma_read!(foo, bar) -> io_project!(foo, bar).copy_read()
    dma_write!(foo, bar, baz) -> io_project!(foo, bar).copy_write(baz)

Model these semantics after memcpy so user has clear expectation of lack of
atomicity. As an additional benefit of this change, this now works for MMIO
as well by mapping them to `memcpy_{from,to}io`.

For slices which is DST so the `copy_read` and `copy_write` API above can't
work, add `copy_from_slice` and `copy_to_slice` to copy from/to normal
memory, and `copy_from_io_slice` and `copy_to_io_slice` to copy from/to
other `Io` regions. They're optimized if at least one end is mapped to
system memory; if none are, the copy occurs with an intermediate stack
buffer.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/helpers/io.c        |  13 ++
 rust/kernel/dma.rs       |   9 ++
 rust/kernel/io.rs        | 367 ++++++++++++++++++++++++++++++++++++++++++++++-
 samples/rust/rust_dma.rs |  14 +-
 4 files changed, 397 insertions(+), 6 deletions(-)

diff --git a/rust/helpers/io.c b/rust/helpers/io.c
index 397810864a24..7ed9a4f77f1b 100644
--- a/rust/helpers/io.c
+++ b/rust/helpers/io.c
@@ -19,6 +19,19 @@ __rust_helper void rust_helper_iounmap(void __iomem *addr)
 	iounmap(addr);
 }
 
+__rust_helper void rust_helper_memcpy_fromio(void *dst,
+					     const volatile void __iomem *src,
+					     size_t count)
+{
+	memcpy_fromio(dst, src, count);
+}
+
+__rust_helper void rust_helper_memcpy_toio(volatile void __iomem *dst,
+					   const void *src, size_t count)
+{
+	memcpy_toio(dst, src, count);
+}
+
 __rust_helper u8 rust_helper_readb(const void __iomem *addr)
 {
 	return readb(addr);
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 68015a2ab43b..71d495a2e3a8 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -18,6 +18,7 @@
         IoBackend,
         IoBase,
         IoCapable,
+        IoCopyable,
         SysMem,
         SysMemBackend, //
     },
@@ -1196,6 +1197,14 @@ fn io_write<'a>(view: Self::View<'a, T>, value: T) {
     }
 }
 
+// SAFETY: `CoherentView::as_ptr` is mapped to CPU address space.
+unsafe impl IoCopyable for CoherentBackend {
+    #[inline(always)]
+    fn is_mapped<T: ?Sized + KnownSize>(_view: Self::View<'_, T>) -> bool {
+        true
+    }
+}
+
 impl<'a, T: ?Sized + KnownSize> IoBase<'a> for CoherentView<'a, T> {
     type Backend = CoherentBackend;
     type Target = T;
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 72f3acc0f50d..2b238b625672 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -5,7 +5,8 @@
 //! C header: [`include/asm-generic/io.h`](srctree/include/asm-generic/io.h)
 
 use core::{
-    marker::PhantomData, //
+    marker::PhantomData,
+    mem::MaybeUninit, //
 };
 
 use crate::{
@@ -229,6 +230,63 @@ pub trait IoCapable<T>: IoBackend {
     fn io_write<'a>(view: Self::View<'a, T>, value: T);
 }
 
+/// Trait indicating that an I/O backend supports memory copy operations.
+///
+/// # Safety
+///
+/// If [`Self::is_mapped`] is overridden, it must be correct per documentation.
+pub unsafe trait IoCopyable: IoBackend {
+    /// Whether the pointers for this I/O backend are in the CPU address space, and are coherently
+    /// mapped.
+    ///
+    /// When this returns true, `Self::as_ptr(view)` must return a valid and aligned pointer. The
+    /// pointer may be accessed with byte-wise atomic memory copy or volatile read/write.
+    ///
+    /// This is not an associated constants to support backends where the view may be conditionally
+    /// mapped. This method should be marked as `#[inline(always)]` if it always returns true, so
+    /// `build_assert!()` in `copy_{from,to}io` can see it.
+    #[inline]
+    fn is_mapped<T: ?Sized + KnownSize>(_view: Self::View<'_, T>) -> bool {
+        false
+    }
+
+    /// Copy contents of `view` to `buffer`.
+    ///
+    /// # Safety
+    ///
+    /// - `buffer` is valid for volatile write for `view.size()` bytes.
+    #[inline]
+    unsafe fn copy_from_io(view: Self::View<'_, [u8]>, buffer: *mut u8) {
+        build_assert!(Self::is_mapped(view));
+
+        let ptr = Self::as_ptr(view);
+
+        // Use `bindings::memcpy` instead of copy_nonoverlapping for volatile.
+        // SAFETY:
+        // - `is_mapped` guarantees `ptr` is in CPU address space and valid for read.
+        // - `buffer` is valid for write for `view.size()` bytes which is equal to `ptr.len()`.
+        unsafe { bindings::memcpy(buffer.cast(), ptr.cast(), ptr.len()) };
+    }
+
+    /// Copy `size` bytes from `buffer` to `address`.
+    ///
+    /// # Safety
+    ///
+    /// - `buffer` is valid for volatile read for `view.size()` bytes.
+    #[inline]
+    unsafe fn copy_to_io(view: Self::View<'_, [u8]>, buffer: *const u8) {
+        build_assert!(Self::is_mapped(view));
+
+        let ptr = Self::as_ptr(view);
+
+        // Use `bindings::memcpy` instead of copy_nonoverlapping for volatile.
+        // SAFETY:
+        // - `is_mapped` guarantees `ptr` is in CPU address space and valid for write.
+        // - `buffer` is valid for read for `view.size()` bytes which is equal to `ptr.len()`.
+        unsafe { bindings::memcpy(ptr.cast(), buffer.cast(), ptr.len()) };
+    }
+}
+
 /// Describes a given I/O location: its offset, width, and type to convert the raw value from and
 /// into.
 ///
@@ -306,6 +364,24 @@ fn size(self) -> usize {
         KnownSize::size(Self::Backend::as_ptr(self.as_view()))
     }
 
+    /// Returns the length of the slice in number of elements.
+    #[inline]
+    fn len<T>(self) -> usize
+    where
+        Self: Io<'a, Target = [T]>,
+    {
+        Self::Backend::as_ptr(self.as_view()).len()
+    }
+
+    /// Returns `true` if the slice has a length of 0.
+    #[inline]
+    fn is_empty<T>(self) -> bool
+    where
+        Self: Io<'a, Target = [T]>,
+    {
+        self.len() == 0
+    }
+
     /// Try to convert into a different typed I/O view.
     ///
     /// The target type must be of same or smaller size to current type, and the current view must
@@ -397,6 +473,264 @@ fn write_val(self, value: Self::Target)
         Self::Backend::io_write(self.as_view(), value)
     }
 
+    /// Copy-read from I/O memory.
+    ///
+    /// There is no atomicity guarantee.
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// # use kernel::io::*;
+    /// # fn test_copy_read(mmio: Mmio<'_, [u8; 6]>) {
+    /// // let mmio: Mmio<'_, [u8; 6]>;
+    /// let val: [u8; 6] = mmio.copy_read();
+    /// # }
+    /// ```
+    #[inline]
+    fn copy_read(self) -> Self::Target
+    where
+        Self::Backend: IoCopyable,
+        Self::Target: Sized + FromBytes,
+    {
+        let view = self.as_view();
+
+        // Optimized path if I/O backend is CPU mapped.
+        if Self::Backend::is_mapped(view) {
+            let ptr = Self::Backend::as_ptr(view);
+            // SAFETY:
+            // - `is_mapped` guarantees `ptr` is valid for read in CPU address space.
+            // - Using read_volatile() here so that race with hardware is well-defined.
+            // - Using read_volatile() here is not sound if it races with other CPU per Rust
+            //   rules, but this is allowed per LKMM.
+            return unsafe { ptr.read_volatile() };
+        }
+
+        // Project `self` to `[u8]`.
+        let ptr = Self::Backend::as_ptr(view);
+        // SAFETY: This is a identity projection.
+        let slice_view = unsafe {
+            Self::Backend::project_view(
+                view,
+                core::ptr::slice_from_raw_parts_mut::<u8>(ptr.cast(), size_of::<Self::Target>()),
+            )
+        };
+
+        let mut buf = MaybeUninit::<Self::Target>::uninit();
+        // SAFETY: `buf.as_mut_ptr()` is valid for write for `size_of::<T>()` bytes.
+        unsafe { Self::Backend::copy_from_io(slice_view, buf.as_mut_ptr().cast()) };
+        // SAFETY: T: FromBytes` guarantee that all bit patterns are valid.
+        unsafe { buf.assume_init() }
+    }
+
+    /// Copy-write to I/O memory.
+    ///
+    /// There is no atomicity guarantee.
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// # use kernel::io::*;
+    /// # fn test_copy_write(mmio: Mmio<'_, [u8; 6]>) {
+    /// // let mmio: Mmio<'_, [u8; 6]>;
+    /// mmio.copy_write([0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF]);
+    /// # }
+    /// ```
+    #[inline]
+    fn copy_write(self, value: Self::Target)
+    where
+        Self::Backend: IoCopyable,
+        Self::Target: Sized + AsBytes,
+    {
+        let view = self.as_view();
+
+        // Optimized path if I/O backend is CPU mapped.
+        if Self::Backend::is_mapped(view) {
+            let ptr = Self::Backend::as_ptr(view);
+            // SAFETY:
+            // - `is_mapped` guarantees `ptr` is valid for write in CPU address space.
+            // - Using write_volatile() here so that race with hardware is well-defined.
+            // - Using write_volatile() here is not sound if it races with other CPU per Rust
+            //   rules, but this is allowed per LKMM.
+            unsafe { ptr.write_volatile(value) };
+            return;
+        }
+
+        // Project `self` to `[u8]`.
+        let ptr = Self::Backend::as_ptr(view);
+        // SAFETY: This is a identity projection.
+        let slice_view = unsafe {
+            Self::Backend::project_view(
+                view,
+                core::ptr::slice_from_raw_parts_mut::<u8>(ptr.cast(), size_of::<Self::Target>()),
+            )
+        };
+
+        // SAFETY: `&raw const value` is valid for read for `size_of::<T>()` bytes.
+        unsafe { Self::Backend::copy_to_io(slice_view, (&raw const value).cast()) };
+        core::mem::forget(value);
+    }
+
+    /// Copy bytes from slice to I/O memory.
+    ///
+    /// The length of `self` must be the same as `data`, similar to [`[u8]::copy_from_slice`].
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// # use kernel::io::*;
+    /// # fn test_copy_write(mmio: Mmio<'_, [u8]>) {
+    /// // let mmio: Mmio<'_, [u8]>;
+    /// mmio.copy_from_slice(&[0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF]);
+    /// # }
+    /// ```
+    #[inline]
+    fn copy_from_slice(self, data: &[u8])
+    where
+        Self::Backend: IoCopyable,
+        Self: Io<'a, Target = [u8]>,
+    {
+        assert_eq!(self.len(), data.len());
+
+        // SAFETY: `data.as_ptr()` is valid for read for `self.size()` bytes.
+        unsafe {
+            Self::Backend::copy_to_io(self.as_view(), data.as_ptr());
+        }
+    }
+
+    /// Copy bytes from I/O memory to slice.
+    ///
+    /// The length of `self` must be the same as `data`, similar to [`[u8]::copy_from_slice`].
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// # use kernel::io::*;
+    /// # fn test_copy_write(mmio: Mmio<'_, [u8]>) {
+    /// // let mmio: Mmio<'_, [u8]>;
+    /// let mut buf = [0; 6];
+    /// mmio.copy_to_slice(&mut buf);
+    /// # }
+    /// ```
+    #[inline]
+    fn copy_to_slice(self, data: &mut [u8])
+    where
+        Self::Backend: IoCopyable,
+        Self: Io<'a, Target = [u8]>,
+    {
+        assert_eq!(self.len(), data.len());
+
+        // SAFETY: `data.as_ptr()` is valid for write for `self.size()` bytes.
+        unsafe {
+            Self::Backend::copy_from_io(self.as_view(), data.as_mut_ptr());
+        }
+    }
+
+    /// Copy bytes from `data` I/O slice to the `self`.
+    ///
+    /// The length of `self` must be the same as `data`, similar to [`[u8]::copy_from_slice`].
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// # use kernel::io::*;
+    /// # fn test_copy_write(dst: Mmio<'_, [u8]>, src: Mmio<'_, [u8]>) {
+    /// // let dst: Mmio<'_, [u8]>;
+    /// // let src: Mmio<'_, [u8]>;
+    /// dst.copy_from_io_slice(src);
+    /// # }
+    /// ```
+    fn copy_from_io_slice<'b, T>(self, data: T)
+    where
+        Self::Backend: IoCopyable,
+        Self: Io<'a, Target = [u8]>,
+        T: Io<'b, Target = [u8], Backend: IoCopyable>,
+    {
+        fn copy_from_io_slice_via_buffer<
+            'a,
+            'b,
+            T: Io<'a, Target = [u8], Backend: IoCopyable>,
+            U: Io<'b, Target = [u8], Backend: IoCopyable>,
+        >(
+            dest: T,
+            src: U,
+        ) {
+            let mut buf = MaybeUninit::<[u8; 256]>::uninit();
+
+            let mut offset = 0;
+            let mut len = dest.len();
+
+            while len != 0 {
+                let copy_len = core::cmp::min(len, 256);
+
+                // SAFETY: `buf.as_mut_ptr()` is valid for write for `copy_len` bytes as `copy_len
+                // <= 256`.
+                unsafe {
+                    U::Backend::copy_from_io(
+                        io_project!(src, [panic: offset..][panic: ..copy_len]),
+                        buf.as_mut_ptr().cast(),
+                    )
+                };
+
+                // SAFETY: `buf.as_ptr()` is valid for read for `copy_len` bytes as `copy_len <=
+                // 256`.
+                unsafe {
+                    T::Backend::copy_to_io(
+                        io_project!(dest, [panic: offset..][panic: ..copy_len]),
+                        buf.as_ptr().cast(),
+                    )
+                };
+
+                offset += copy_len;
+                len -= copy_len;
+            }
+        }
+
+        assert_eq!(self.len(), data.len());
+
+        let dst_view = self.as_view();
+        let src_view = data.as_view();
+
+        if T::Backend::is_mapped(src_view) {
+            // SAFETY: `T::Backend::as_ptr(src_view)` is valid for read for `data.len()`
+            // bytes.
+            unsafe {
+                Self::Backend::copy_to_io(self.as_view(), T::Backend::as_ptr(src_view).cast())
+            }
+        } else if Self::Backend::is_mapped(dst_view) {
+            // SAFETY: `Self::Backend::as_ptr(dst_view)` is valid for write for `data.len()`
+            // bytes.
+            unsafe {
+                T::Backend::copy_from_io(data.as_view(), Self::Backend::as_ptr(dst_view).cast())
+            }
+        } else {
+            copy_from_io_slice_via_buffer(dst_view, src_view)
+        }
+    }
+
+    /// Copy bytes from `self` to the `data` I/O slice.
+    ///
+    /// The length of `self` must be the same as `data`, similar to [`[u8]::copy_from_slice`].
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// # use kernel::io::*;
+    /// # fn test_copy_write(dst: Mmio<'_, [u8]>, src: Mmio<'_, [u8]>) {
+    /// // let dst: Mmio<'_, [u8]>;
+    /// // let src: Mmio<'_, [u8]>;
+    /// src.copy_to_io_slice(dst);
+    /// # }
+    /// ```
+    #[inline]
+    fn copy_to_io_slice<'b, T>(self, data: T)
+    where
+        Self::Backend: IoCopyable,
+        Self: Io<'a, Target = [u8]>,
+        T: Io<'b, Target = [u8], Backend: IoCopyable>,
+    {
+        data.copy_from_io_slice(self)
+    }
+
     /// Returns a view for a given `offset`, performing compile-time bound checks.
     // Always inline to optimize out error path of `build_assert`.
     #[inline(always)]
@@ -987,6 +1321,29 @@ fn io_write(view: <$backend as IoBackend>::View<'_, $ty>, value: $ty) {
 #[cfg(CONFIG_64BIT)]
 impl_mmio_io_capable!(MmioBackend, u64, readq, writeq);
 
+// SAFETY: `is_mapped` is not overridden.
+unsafe impl IoCopyable for MmioBackend {
+    #[inline]
+    unsafe fn copy_from_io(view: Self::View<'_, [u8]>, buffer: *mut u8) {
+        // SAFETY:
+        // - `view.ptr` is valid MMIO memory for `view.size()` bytes.
+        // - `buffer` is valid for write for `view.size()` bytes.
+        unsafe {
+            bindings::memcpy_fromio(buffer.cast(), view.ptr.cast(), view.size());
+        }
+    }
+
+    #[inline]
+    unsafe fn copy_to_io(view: Self::View<'_, [u8]>, buffer: *const u8) {
+        // SAFETY:
+        // - `view.ptr` is valid MMIO memory for `view.size()` bytes.
+        // - `buffer` is valid for read for `view.size()` bytes.
+        unsafe {
+            bindings::memcpy_toio(view.ptr.cast(), buffer.cast(), view.size());
+        }
+    }
+}
+
 /// [`Mmio`] but using relaxed accessors.
 ///
 /// This type provides an implementation of [`Io`] that uses relaxed I/O MMIO operands instead of
@@ -1142,6 +1499,14 @@ fn io_write(view: SysMem<'_, $ty>, value: $ty) {
 #[cfg(CONFIG_64BIT)]
 impl_sysmem_io_capable!(u64);
 
+// SAFETY: `SysMem::as_ptr` is mapped to the CPU address space.
+unsafe impl IoCopyable for SysMemBackend {
+    #[inline(always)]
+    fn is_mapped<T: ?Sized + KnownSize>(_view: Self::View<'_, T>) -> bool {
+        true
+    }
+}
+
 /// System memory region.
 ///
 /// Provides `Io` trait implementation for kernel virtual address ranges,
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 6727c441658a..0f2597798ff5 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -12,7 +12,11 @@
         Device,
         DmaMask, //
     },
-    io::io_read,
+    io::{
+        io_project,
+        io_read,
+        Io, //
+    },
     page, pci,
     prelude::*,
     scatterlist::{Owned, SGTable},
@@ -74,11 +78,11 @@ fn probe<'bound>(
             // SAFETY: There are no concurrent calls to DMA allocation and mapping primitives.
             unsafe { pdev.dma_set_mask_and_coherent(mask)? };
 
-            let mut ca: CoherentBox<[MyStruct]> =
-                CoherentBox::zeroed_slice(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
+            let ca: Coherent<[MyStruct]> =
+                Coherent::zeroed_slice(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
 
             for (i, value) in TEST_VALUES.into_iter().enumerate() {
-                ca.init_at(i, MyStruct::new(value.0, value.1))?;
+                io_project!(ca, [panic: i]).copy_write(MyStruct::new(value.0, value.1));
             }
 
             let size = 4 * page::PAGE_SIZE;
@@ -88,7 +92,7 @@ fn probe<'bound>(
 
             Ok(try_pin_init!(Self {
                 pdev: pdev.into(),
-                ca: ca.into(),
+                ca,
                 sgt <- sgt,
             }))
         })

-- 
2.54.0

