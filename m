Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011070.outbound.protection.outlook.com [40.107.208.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F11D54CF6B;
	Wed, 14 Oct 2026 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791990993; cv=fail; b=cDnUat/zC4HUiqAp1OybqPkWgmdl0DIhNKkEbIfZsnEHwwGeIy0nCnZMByj7xqL+cAGY0zI9cva/23Rykpugx3yaGFJQwnbCR9kArZLDdgwEUA0HwetwQ+4XNPEQhnMCxVYQ7ZJn3S9pQsdWWwYVQE36/ONEcvcdLKRaDvz52P4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791990993; c=relaxed/simple;
	bh=Ef6uG45qciy0ICfpxGNyt6RFptvuirIG2zCr/LTQh00=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Mm0pmcGWhxd7wAfqlzUzN9n4BCNANYAe5caW4mMrnlSPkr1tt134+ZjL1bxTRipWLA7Vj6wGtGScocF7JI3bs5whvFkdK9OAWKHeuvrdIn8j+7iQMy1gvXCxOGKBwuJeIzHXzJSIJqXKHKKGoNxsvc4RKa/UplZf6Wp8HUah7Tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RiPZ+Zg4; arc=fail smtp.client-ip=40.107.208.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RiPZ+Zg4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJ0/kZk+/5u05eNiUdcDK5bn4YzOSzY71LXgJXuVg8oEqlbKL+jmzpqfBwn4S2EH6UCQyoe/gouibFDkeor89VuXbmumoBfQvPXP7vsWE6YSjAA5VdKgdNjyXZ1lmxz3K7R1wiQD42bIgaIFLRxj0yILA3cczohoNzKRaLGNSq9OS1aAwdo/Gzv8Fn1a0CWE2wjgnuVzsqfa1Yfe+QR+oTtqBMo/c+a7fwOy96i+oLSLFbTslXDyrKiFvQNF10BOJSeQjiS3qleQVbMi9Wi+AvoU/oh6lRwDzGliaJXsNI78NplTR/tAFnpzZGGxe4/s6m5qnKpbc6YLsKociMUfwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXLnrncGKxkG02hEaQqDbH7mtGCGE9k3MAm34rj8JwM=;
 b=BUcO5uNFY4covXn8mYP990jyCefcqKSH5HswjHX8Q7DloNfBqZ72oOCcvUz7/RnMlUnJmGxcfQLK9BLRdDFp1HjG7eHnCHaaIcjnVrKxheJoKMMYw/GqrEDZP/mcIonRMW2Y7lfo6LklWPGzYLCMUgftZ3640WGk51tABKGAtjXr0dLqN12/dSSQEt2Ek9RkZrAMf5HJwPeZIWpqgpe2J0aXKWB8UYXLrTO/8POcnA+FhlkrWShS47uWludOWRs7MOSxS3q6khWZrjHKRKJ6hXOMaM1Gih/Jsalv9Da68DsFwvoAgbvm3oC30w1qhulrD6vr63H7S2T2D1Z2qlvkIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXLnrncGKxkG02hEaQqDbH7mtGCGE9k3MAm34rj8JwM=;
 b=RiPZ+Zg4N7eWDVJDvm4yZM+dFTTDhRBijKy3K964udKb5pgcoW3X7/9fsxTQUw5ISpAhuHt04RGx3QKvo6zXkasqPC1udmdD9KWy8myM9LN/oAiNLhktG5Jsdnzgnr8ElPdODzENX99170tO7WFWfgUyjmGcJuG4a3gtd73rYt/gsYAw1RYR3qdd4HBR6J0TvFk/P7Tq52OJAdKjUXaWa4WOomUJcJU2QCA++b3h7jF1PECr0WE3NCPQajvulFWBndQNovAxWCGteqvfuqPxbmX3kuCcaQhYdBU+B1tBzCuIM4t0w5w4FdqodpMW8exGv4zUHIHPAQ9GMspFMYuCgQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH7PR12MB5880.namprd12.prod.outlook.com (2603:10b6:510:1d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 15:16:22 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 15:16:22 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 00:16:19 +0900
Message-Id: <DM4NSAYZG3EW.27L8GX0Q9CV0P@nvidia.com>
Cc: <lukas@wunner.de>, <linux-cxl@vger.kernel.org>,
 <akpm@linux-foundation.org>, <Jonathan.Cameron@huawei.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <jic23@kernel.org>, <bhelgaas@google.com>, <alistair@alistair23.me>,
 <djbw@kernel.org>, <linux-pci@vger.kernel.org>, <wilfred.mallawa@wdc.com>,
 <a.hindborg@kernel.org>, <gregkh@linuxfoundation.org>,
 <alex.gaynor@gmail.com>, <aliceryhl@google.com>, <benno.lossin@proton.me>,
 <boqun.feng@gmail.com>, <bjorn3_gh@protonmail.com>, <tmgross@umich.edu>,
 <gary@garyguo.net>, <ojeda@kernel.org>, "Alistair Francis"
 <alistair.francis@wdc.com>
Subject: Re: [PATCH v4 00/22] lib: Rust implementation of SPDM
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: <alistair23@gmail.com>
Content-Transfer-Encoding: quoted-printable
References: <20260928011123.450800-1-alistair.francis@wdc.com>
In-Reply-To: <20260928011123.450800-1-alistair.francis@wdc.com>
X-ClientProxiedBy: TYCP301CA0043.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::19) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH7PR12MB5880:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a0c0221-3f62-4d06-b79b-08df2a061ab2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003|23010399003|6133799003|10067099003|22082099003|18002099003|3023799007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	PVoXZZ5TnDnL6IwIlXlO4utyN+FTbFVbMe1bpHB+c2SlCL62zVBVUndWpY+jHiC3s2TvS8NtXzRQ+a/UHt4pk8M4iDsNcLLmymBagZ2uB1yKWJx3k6jesKF2JbyZ4By/2/rg3vvdAIlt6XCEfQcW9Ma3K5pSREngGkv8gkYitar6Xk3bPUyB9dVZGre6v5h2yU53PuvhRm0r1RvcreEMneVQkqf6VR4c5Iak7Q14MYlhgqsoV6FVpP3IWI2/lPK0Cko4Bolgs7aTKOToImmKmwHVqzGlA81l5454WY9FdcKRmDUqg1ucgBgig9h7gfi+ojDWhI5AczIdTeLnNQp+Krv0lmgB4ha+KauUBjf9JwK0a1G9aZPPLHIwDq2mFidWadqCxQ+U9QzV1Ag2Zpt+hActDQtYQbvT4QsaKtOWlob3gr+/uSuQGZZZvad/RpcmlOyTyD4R2MWz4hHfuouEyHMDF24rVZdpz1R1I1dcwFoca1aSftnNw4kw+cIHmRRRpIkatW/dZ7mJd8KQPpMNrdPaLWyos7EsnSxSfCNC15WVciC7TD6qokN8avlBazUBfKnf4CgoHWSStq57Vpp+wliyqZW06rilCeAY5286ow1YaF1iObUOYIhwo5AJ+Ywx2atJLkRN9XIqbVoHUVDHuFT3IZ+m5EwJeQK2GdFgaAE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(3023799007)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0x2RW40ZmNTY1pvdnJyVG1WdHpHT0lVUjZYa2RqbU5QZHdEUWpaMWhYYmdm?=
 =?utf-8?B?bm1RYjhNdHB5YTY3UklhRnozZ0hxOFN1NzJmZXg0WGtGbHdReWFhaW5hQUVu?=
 =?utf-8?B?aG52akVwRTFFYTB3Yy91S1A0RXpCRUljYWduMUdtWUVyQkg1WE4xTFBDNDdo?=
 =?utf-8?B?VzZpQUl5Q29aYmphc2dYQ3MxSVhiTFRDR2swOHlGTDJHVHpYMFdZR1V5cnVY?=
 =?utf-8?B?TE15ZnRLSUxQTHNNN2ZxdExTM0dFSW1rRDltS1VSc2h4blp4aHl1NDJNaHJl?=
 =?utf-8?B?MlprSDVLbFdaeFhBWWhaNFVBb243eFdJNEtvaTh2SW5yM3FiL3I0bENmc3Q1?=
 =?utf-8?B?TzhMVWhBQVJ2aS9idHRFcXZ1b1dhTlJzSHRUcWpma251SzF4dkxMbmZORGdo?=
 =?utf-8?B?T3FPQjdRVjl0Qy9ZeVBoUFBFdVNQV0lJa2lkR0p3QXVUM1lVM1JqTVd6U2xx?=
 =?utf-8?B?eCsxR3VtU2M4ODBOZzRleVlSbWhkU292N0g2VXVpUVJHdFhWcnZsRENxVmZP?=
 =?utf-8?B?TFZOV3F3TC83cmRuZkwxVVZWSlRoLzJQQUV0MUwvLzVpZlY5NGZFQ2FPcnFZ?=
 =?utf-8?B?a240NXBRRGhkaEhwcmdxS1h0WnpseHhaTzZjUkkvZmFOWlByNGhQOEhoV2l4?=
 =?utf-8?B?MTZtT3lKcE92NFVCZVhuSFFNdm53RVN3TEt3UWZmekRsRGtsQ0JlMldVT0NY?=
 =?utf-8?B?SkxFRktDQU9BaCtoQnJjd1RGV3ViaTZPc01Ic1RPamMxWXpJdWRFejlGVUh3?=
 =?utf-8?B?NWhPbE5XTWo0bkRmVmlkRURuSHhOWUdqOHV4ZmYzYVY5cXpndDJiYnhFUFE3?=
 =?utf-8?B?VTR4dzFwUCtDdy80cnJqTWhLNGQyb2t6a3dNeVJtVXp4djMzZTArNUYxUmpX?=
 =?utf-8?B?cnVFTVkwckhlbmJJd0tQMU9kT2Q2c29xS3VzYkFPWmhQd0laRzR1cjZPUUlQ?=
 =?utf-8?B?ZDVvYmJRdnJHaEhBKzg5a29XR3c3cTlubDBpbmZKWEFvMWthNGZWNUgybXZT?=
 =?utf-8?B?SzlSbG5KOGRpOXN1ZGhGRUY3NisraHVtOVBFS1V2VkRrVk1SZE1wTjR0QjRD?=
 =?utf-8?B?ZXVpdlJJRnJTQTFnMG5Kc0RBRllEWURKUmhCdko4eFlIcTc4UnlvemNsdXM0?=
 =?utf-8?B?VWlSKzJjaUVndENaRGZVallBazFTM1NzNTNINGVEeU1zQ1RNbTNFeTZHakxP?=
 =?utf-8?B?NXI1dVZDSjcybERDTDVwUUh2UC9Zdmc1OEtFV3E1ZW16L3FVS21nVUNrV0Ez?=
 =?utf-8?B?SFUrbnIzclJueUlGZ3dGamJQbWdqbkdPN1RNcUZNMnhWVTYzd25UbjhNbkpl?=
 =?utf-8?B?bVVndUQ1enJMVUtwODhXcDRXRzE4WVYwbWZsZEZXOHlPUGFSbmg1WVNWY08y?=
 =?utf-8?B?VlB2VTBTU2pQRmVDamVKKzJpcnVMd1h0VXVDcmo5OEJ5TW0zbmVaV21WOXcx?=
 =?utf-8?B?cnh0TXVGWk1WRDlVSXQxNXdEZTRYQ2M0cDh3OGhWc1IyaTB0WWkrZHJNS0hL?=
 =?utf-8?B?eng0Wms4YzVPbC9yb0RkeGdWYTdJTENxeERqK3k2ZEpaSkdmTDhhcGwxM3lW?=
 =?utf-8?B?d0VFNVhXRkxzUS8wSjVVS0JPVnJ1ek0zWEdSK0xIeXYzWWUrVFFIYUFKRHNB?=
 =?utf-8?B?T04vSGVKT0FZL1BSTDRIeXg1MTU5Q0lNNHBsWjBrSzVVenN5YzVGZ2lWcjU5?=
 =?utf-8?B?Z2I2ZWZac3VtY0xsZ29jVEJMRGxaL2x1UzgxaVcycnpiT25yeXJGS0MwSm9T?=
 =?utf-8?B?YlN6cTdKcHovNDZISU41MDdLYTY2L1pIL3NuQmdhd1FYckRNRzlrdWI4OE9T?=
 =?utf-8?B?dnZIRyt1MnM0cjVocWVaTHFDc05QSnZPSUNTdXVBblZpTitoWEFIMWNVSWxw?=
 =?utf-8?B?ank0ZGNabE9KNXBiMlpVZm9WREJValYzc3VrZnBzbldqSlVwMlllMW43QUQy?=
 =?utf-8?B?MUFsNWhUWUZQazl2QnFVMzRaR0NTM2ZYYU9DQ1FaYy9IS0g4NWNYV2VFMjZF?=
 =?utf-8?B?Y3pxVHpZOCtvU0p2RFdwT2t3QlRDUjlLTC9yb0hhREhQVXlTVDZ2NU9wczZl?=
 =?utf-8?B?YUQ3VktPNGhlK1dacHJDbjZKN0pkMDA1am05NVRoS3dWQ3h1MCtOOUwxSDBH?=
 =?utf-8?B?Y1JoUERRK1JKQUJUZWJ5OXJsNlN5TlovOTd4c29pWHVOdDlmVjJXSU04OXdZ?=
 =?utf-8?B?WlZNMVZkdmNDQ2hkblpGaUNKbzVzL2VBWDB0SWhCNzBjWTArRi9xV2ljdzlY?=
 =?utf-8?B?UlhHYXlxK0lSR3dMbjN4bU1KMlZlcVByWkhGUUdlaHIzRUFYejRCYjBWN0Jr?=
 =?utf-8?B?YXphMEZVZmEydFBFSlpuS1NpekZJRUg3RWZndTNVQ2tOZmhMZ2dpbkFCQysz?=
 =?utf-8?Q?ij2cZU6qYf5+TVsJSlI+y4QMUrv9G5snNFBYHCHWeRwXg?=
X-MS-Exchange-AntiSpam-MessageData-1: DlWQGFKlD352eg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0c0221-3f62-4d06-b79b-08df2a061ab2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 15:16:21.9195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zbfXa4F4lfF+lFgn/4GiaMpYWFBbnW9TEjn5+/DikVEzVTguevQdxNmW08rpFoUNj909TKaSEtO9dPB5ovVZYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5880

Hi Alistair,

On Mon Sep 28, 2026 at 10:11 AM JST, alistair23 wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
>
> Security Protocols and Data Models (SPDM) [1] is used for authentication,
> attestation and key exchange. SPDM is generally used over a range of
> transports, such as PCIe, MCTP/SMBus/I3C, ATA, SCSI, NVMe or TCP.
>
> From the kernels perspective SPDM is used to authenticate and attest devi=
ces.
> In this threat model a device is considered untrusted until it can be ver=
ified
> by the kernel and userspace using SPDM. As such SPDM data is untrusted da=
ta
> that can be mallicious.
>
> The SPDM specification is also complex, with the 1.2.1 spec being almost =
200
> pages and the 1.3.0 spec being almost 250 pages long.
>
> As such we have the kernel parsing untrusted responses from a complex
> specification, which sounds like a possible exploit vector. This is the t=
ype
> of place where Rust excels!
>
> This series implements a SPDM requester in Rust.

A few high-level comments/questions about this series:

- Have you tried building it with `CLIPPY=3D1` as per the checklist [1]? I
  am getting dozen of Clippy warnings about unused imports, unused
  constants, missing safety comments, and style issues. Series are
  expected to be Clippy-clean when submitted.
- Most of the C parts have received more attention than the Rust ones so
  far, if they are meaningful on their own can they be merged separately
  so this series can focus on the Rust bits and the C FFI?
- I see many unsafe calls to C crypto functions in e.g. patch 17, these
  will need to have their own Rust wrapper so they can be called safely.

I am not familiar with SPDM yet so I cannot comment on the
protocol-specific parts, but I'll try to perform a review on the Rust
bits. For this revision it won't be exhaustive as there are a few
critical things to fix before considering the rest.

[1] https://rust-for-linux.com/contributing#submit-checklist-addendum
