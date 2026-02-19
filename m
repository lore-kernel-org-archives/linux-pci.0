Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020140.outbound.protection.outlook.com [52.101.195.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3620334026B;
	Thu, 19 Feb 2026 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771512507; cv=fail; b=THrCz6ZgCOzdaUH6zbwVooYB+UNCjc6IUAIvin/xcmmpjJmwGrf3I0S5M1YTTTVkq9sDh+phuJxjlLVo0sa/LETaa/3OSZW7OWU9K6R/94hYndZgUuL3q8mQyNU0/5gifu8L8f/UCL5hb7LjVoXfDXNimBPedgQ14zfEMCC1fwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771512507; c=relaxed/simple;
	bh=JFkyoT2S5XIKNlLDb8T4RGR46KopsT8WS4F3a6E5jSg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=txg2364u4UfHR+1At77majlmhoCBlCsxhz9eCIvk9npxt6nh4nrQXc9Qap3MT8/ROKGY/IZyW/slf+MeftXxjEGODqCQ3NWWnRU6xULBcUMTxN/7T81J+T8nm54Q9/vCMxlIIyr16UVQrrpSmaW6C4LD0RNg8yAeLP3ri5lQ/bA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=BpmZX/Mb; arc=fail smtp.client-ip=52.101.195.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="BpmZX/Mb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLIDBNfR0htjnCMPNchwZzDIzbhziCQVC1id1Ga2yO54u+U+71e/1QhJMbxTgENcOmkn9556CEyDYKbKrueJ7aAoZSw4dA6qCfipD+C+zaNstwPFGpY1afDEn/gb3TEPnbXf1EZGT4CME4YWSGYepQVyPXK7b4XPyT2pA/8ipZorCBlIFxvwWkEgPdNozbhXXZ5J6wgPVBxDGh10MSS0kv5CiIpzXD2ZEnNe9ZQu1hRmwa4nGIVfO1c08I9HXg4JHUrkrqATN89mmGeBZaph8m2UnodYzHbIc3AT9GKU9zZwaqrPqJlNSZJIOMni6T/1NkXrJbAi4G1ke50ypwWIiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7zDxWcepZ9zqgUdf4SBtH27703KnXygNjT2T9vaB2c=;
 b=LsuL3NVhiaR9k5MNXwLEchfJ6oKx+f+Lq5cfXQiQ7C2ZnAa5af28L1wz09WjKcy6Dez9IUZy2VsKFejndjkXuoKheIo3h2e8yqJsbhC0yVrQ8QSF5w//o3dCsz3TgRXqAPz3AUsA8kpYr+V03TBIwmu9FUNn+SHF5OVYj5J2PIsX+9msXWGtZGGLdsnYbOWZpPBv5Lwo90IjCP6e46BOPqzpdVmZcJEDYdjrbM2g/K+7iUQnxIMNgGr1VIFVKCeUoOFpTBM0B7UqI8REMM2QWo+xBB4y4K2T2LJtyOO2Zb1bYjm2PXqLDrl6FowELz6sRaV8SVGrmNfbGcWjr80yQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7zDxWcepZ9zqgUdf4SBtH27703KnXygNjT2T9vaB2c=;
 b=BpmZX/MbpWLTY7B1getcBM4WAnEn0ElUEvG2BcTU11DB9lSt7oDoassh35lUw0qL0PdtiaAbGMPBjUd8PnjoCGL6gJmvAw80UtPKUIFjzkWWArmLWpfTvDj+iLZXSw9NrST5sM4KIMGYZhRA71eFV8t+Vx1jL1MZPewuurMBgxM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB5163.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:15f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 14:48:19 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 14:48:17 +0000
Date: Thu, 19 Feb 2026 14:48:17 +0000
From: Gary Guo <gary@garyguo.net>
To: alistair23@gmail.com
Cc: bhelgaas@google.com, lukas@wunner.de, rust-for-linux@vger.kernel.org,
 akpm@linux-foundation.org, linux-pci@vger.kernel.org,
 Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, alex.gaynor@gmail.com, benno.lossin@proton.me,
 boqun.feng@gmail.com, a.hindborg@kernel.org, bjorn3_gh@protonmail.com,
 tmgross@umich.edu, ojeda@kernel.org, wilfred.mallawa@wdc.com,
 aliceryhl@google.com, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [RFC v3 06/27] rust: add bindings for hash.h
In-Reply-To: <20260211032935.2705841-7-alistair.francis@wdc.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260211032935.2705841-7-alistair.francis@wdc.com>
Message-ID: <c0c8fe92086eb8c7836b5c424eab0d2f@garyguo.net>
X-Sender: gary@garyguo.net
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::18) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB5163:EE_
X-MS-Office365-Filtering-Correlation-Id: b28a070f-3db5-4b4a-a78f-08de6fc5eb28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|7053199007|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6Xyb0GkP76oaRWThNgyrTt7NROFOolq3Yj7S0ANEQHSPGIq20QpyCH/5jGLt?=
 =?us-ascii?Q?CcmVDt295xcd0chzK/U169R+WM2Po+QmoJq1pW31I1vbZHi9lH4Mok08NSqn?=
 =?us-ascii?Q?sjL7mnlym+FrOyTvFk2+KBTP6Yf2p/xNgDI4wuZtnWeNBD/YnKM7wt4eoCUv?=
 =?us-ascii?Q?TIil5BcC7NLrEJBPtSv34CuAOY3AIek/rQUUTMUot9ALUBhalCkYkAm1uRsu?=
 =?us-ascii?Q?lTf4DG+3KhrPtHQH67xcP7tl6v9aEkXlA1tBp/B2q2ARf6x5mcJlbn4aPRrD?=
 =?us-ascii?Q?lk2zRvY2rfyNW3/7sMxfZyLSBz0pEdv7UQRg31ia50VAuqYNfsg1rXnipYWf?=
 =?us-ascii?Q?KRTWlSlrOaWFCIEXJK/COfmJZGJeULWcqvRkjrhSwtoK/eJviNk+/CtxF8f9?=
 =?us-ascii?Q?aipscgfNX6tiO7qgkIh7DSHG13HyPENAvbBEni/03wBmYokat7+jdpYQF7/f?=
 =?us-ascii?Q?1YYjECZG8JZEkhsCv9DShE+HY7kdrQS7HnQs1bbyIjEIHbv7G7ZKg8R+C1KV?=
 =?us-ascii?Q?zHD/mrB6TfV7Ib5JdpanAuhmBJ50sqV+9/EKTtN7Rul8emEAkZmH54F4bmSw?=
 =?us-ascii?Q?yHpV2PLr3nraS8T9kQZldrPlNvtxNIbSddNbggpSScT+ppvadYcVMvmvrAI+?=
 =?us-ascii?Q?OJUDRGC5trrfwAZ8S3hrOqjHiLeQuPNMb9JoIfhSysrOCy/BgchH1W3bYWeX?=
 =?us-ascii?Q?YaODBDKl/DQUNVNEMIA1sCT0exY/N80UBFBWIQvWHxxN1L3AhqiUVPFvosVD?=
 =?us-ascii?Q?6B+fxyQ49cmwT5lNzmB4QaM2cgNvo/2syFtrn5Vu0LYlS+uzd/OLHMNXsuVn?=
 =?us-ascii?Q?n7fE9JltPSmVxnwU/RNa1Z1/XXuclZQInWV5IDIu2IR7cUz+Saftx+5cbccM?=
 =?us-ascii?Q?XTEN/KXipaIQjwh3HNPfziybl7eul7R7BSiAL0IlCrydWnW1TpQkvPqjbpGB?=
 =?us-ascii?Q?mtCgxnBlSxQOj3+zl6wsIV/H2qk+xfOvac7c/9LU8OjUYHDiKKTRwmyOSZve?=
 =?us-ascii?Q?HHANs4fiifuh02JbT1o7dfDff7xfZjbBsAAPB9EC154r2XBKrZRHbfmdMHic?=
 =?us-ascii?Q?SXm00x24p13eJgKwy4yF6a2ng+1acqETfsAZe7B4Ch2ubVlBxf1ZFNOMgLAp?=
 =?us-ascii?Q?e5ED5B3D4lFSyN0nBWj3/OKojAXVnnPs4g9Gu7eC7bBxKke6PE4VVJdp9iai?=
 =?us-ascii?Q?bW/w4tQz2sUa51TXZn7YtbiLqOLhQlfAmDkY95kOtHbxNR0gQYdiEG/iwfoi?=
 =?us-ascii?Q?WTgDbGdJl3eidF4h13xPu+2Spuz1sMel+zgL3YjRhq5ZHPdeyUltAqpjePGq?=
 =?us-ascii?Q?JEEkC8qnw3xJO4tbHEY9f/qGgSk3i+k/VEGQzznQWyerVbbXnleAW/YO7z1Q?=
 =?us-ascii?Q?A4X9d311o3Dn1/IAGeH1E3PrhQP3cc62ceycMy1IoGAEqqy/hTrCU1DLk6Qv?=
 =?us-ascii?Q?BWdi6niUeXhdfS0sbBdWWiXp4NUicP78AkvZ6ozP5c/JuffAabZzn/o6iIi5?=
 =?us-ascii?Q?ke5r2Ua4y0tMZGLORuFUnBTw9ehmoFTG7ipoRNNHeZ4/B1QWex+dKUXeaghj?=
 =?us-ascii?Q?RgIQdRIP3TK/i/sZVrw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(7053199007)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gH16EZsLkK8G6uQQYM6PGh3iRGb87vsQ5HVuL8SzK7WoNj6QVueIzkJvp4pe?=
 =?us-ascii?Q?Fie8sDhl5CdqqKfRajZxI3SpqF37PB5g9as0ys7g6OWvMDTNWn0Rtd5otn5U?=
 =?us-ascii?Q?+I6zhxTvkn4tYbmyQ3KW1VZ0uxTLL/Hth87niuptelwDHJvC2lXkQ3VC6b8S?=
 =?us-ascii?Q?saeT7wWLzdpckkfA3R9slvIxZ+r3/YXO85Ny1nX2JTxtbjHEIChTRzHzgQDV?=
 =?us-ascii?Q?gQRNG36a+jqGh2rM8yfHRaZSVLIiIKDApwAcQYT+6VYguVmDdpouw01m3yMs?=
 =?us-ascii?Q?xZ/wJe411hYrIeJGUxKrZTMPlbBFEpIAgXfTX6nZ0u850QxzErbL/7lJDG9s?=
 =?us-ascii?Q?W9u8vqzDXa8rhIGJUlkLS6SFk19x6RRHSGdhiBgZJelRWZNoawC0caWwODdV?=
 =?us-ascii?Q?fz4URXlhFSItUs2iIskLff0mvs8ESTZAbFNnHNWn0Riu7K8F8vYTMYwVb6FI?=
 =?us-ascii?Q?W03d0eqP6CgsSoRs/guRsR83rWrdZx5R+DTYNdsUSUshS68dxtQpo4T74IBE?=
 =?us-ascii?Q?XoM+VgXMdwY1fiudYb98V4TAiJYbMpotXd/MrACmw9e1Y9hKIMicYq3jws82?=
 =?us-ascii?Q?Z6fFIM4P6xCVmcJsIZhhOTyVAdabMpI9iRh9Z6dureMY0HUSA6mgp5Tc/rXp?=
 =?us-ascii?Q?YGMD8T+VOWGkdfju3JUIBwY3tjj8VBojCodQaFGXX10FDZrtX2iQTGIN3WJi?=
 =?us-ascii?Q?MrmYZpmD55O6mpZIjOyeMCgY1aeWzhOHAVid94qlBM3eFrx8/RJkttLOWN6u?=
 =?us-ascii?Q?wx964az4tTqc7ietDAuHdoJfK+cCho2DIqXWq9wLnp4i/5kYkVCCXVyYkEE+?=
 =?us-ascii?Q?bTx7xz8NDfdMscyZdHYXckBG45SU6+A1mH7kk/LHzfI8IUl+ydq9T4gqTaIw?=
 =?us-ascii?Q?gU0dEczVocrNbnl/Of1cPh4ckL5Y6w2uHJgvsqOzBD+vJk/hvEmddbYn9Vy2?=
 =?us-ascii?Q?5p5TdglRQirOVXvpiyu9mGLXJLcZHFiMgHSiimz2sbJQ7aa7p6yNBq2G3VVX?=
 =?us-ascii?Q?ttmqrket6OriikQzWEUTr28q8F1lgdMQPPcSMvM2nRnVo2Crw2rtFuPm8kT3?=
 =?us-ascii?Q?AvfmLGLcH0GVD5OZ1twPeh9IQ3en4j5+UZCQ1eOVWLrEpbF11/O+LcvroQ0M?=
 =?us-ascii?Q?Jig37EUnJil9C7Y2qXgSIZb7egQaL1rwiAP56wAyTa4Q6EFSQYBzhPS8lP9w?=
 =?us-ascii?Q?snKRJRGPLGXCu0gSJKEYq7HcWFiOqxw+4IMFqxpqEZES4jKWopYLzglGpXDG?=
 =?us-ascii?Q?Hc3Cdt2Ahyqu0SkREM/+pmZzW03wdFJdZn45RwZaY7MT+T/uJixDpWxpXCiz?=
 =?us-ascii?Q?PPpTBrr9qO1Y/0qatJkWNPdL56ysNSPeZY87t5cn9xgCGxM/Lr1hWf04qq6l?=
 =?us-ascii?Q?7qqaoZ3ZfQ5+J3mksYIMd0XjvW40s5YXHCdJX8KcGCg30veseRwgG+UPU9Ve?=
 =?us-ascii?Q?wyhUcx1lisa+KeYA6ZxPEVAeBq6UCC/RMunj8E9UO598IgTgpKNP5dCiPwMF?=
 =?us-ascii?Q?L1Hea2dbaPVlIsoZ6AwBylveL0bkySeLN8Q9QB+j4Bp5atMETJT9w3boYKhB?=
 =?us-ascii?Q?8TFggKSuYlqzq48WcDrzJPXGsZ09k7xWC7nnDCLmEQbHqDPU8PXce+EyLYYO?=
 =?us-ascii?Q?CZlX0hug9lw2hY+VIctmyh4hCjD/UFEE+az+z1Dbq/LURzlCwuX4wQMopqD6?=
 =?us-ascii?Q?eqVYQyYfgsPtjZiNQSacsnLcIpuzDWMjZNqaIgGgTf6z9JN3ChhP6Y9fLIZV?=
 =?us-ascii?Q?sNw9SfkuWA=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b28a070f-3db5-4b4a-a78f-08de6fc5eb28
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 14:48:17.8490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSfK7G9TJ77IJ8q0HbAbU9haXNdDSEUIKWt2PS+iIK+RWNR7q8Y+4N6EmQsGt0KlzS2cz1k/OivnSfjyQe+c4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5163

On 2026-02-11 03:29, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Make the functions crypto_shash_descsize(), crypto_shash_digestsize()
> and crypto_free_shash() available to Rust.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  rust/bindings/bindings_helper.h |  2 ++
>  rust/helpers/hash.c             | 18 ++++++++++++++++++
>  rust/helpers/helpers.c          |  1 +
>  3 files changed, 21 insertions(+)
>  create mode 100644 rust/helpers/hash.c
> 
> diff --git a/rust/bindings/bindings_helper.h 
> b/rust/bindings/bindings_helper.h
> index a067038b4b42..0075c4b62c29 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -34,6 +34,7 @@
>  #include <drm/drm_file.h>
>  #include <drm/drm_gem.h>
>  #include <drm/drm_ioctl.h>
> +#include <crypto/hash.h>
>  #include <kunit/test.h>
>  #include <linux/auxiliary_bus.h>
>  #include <linux/bitmap.h>
> @@ -60,6 +61,7 @@
>  #include <linux/fs.h>
>  #include <linux/i2c.h>
>  #include <linux/ioport.h>
> +#include <linux/hash.h>
>  #include <linux/jiffies.h>
>  #include <linux/jump_label.h>
>  #include <linux/mdio.h>
> diff --git a/rust/helpers/hash.c b/rust/helpers/hash.c
> new file mode 100644
> index 000000000000..8ddb84668841
> --- /dev/null
> +++ b/rust/helpers/hash.c
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <crypto/hash.h>
> +
> +unsigned int rust_helper_crypto_shash_descsize(struct crypto_shash 
> *tfm)

Please prefix all helpers with __rust_helper.

Same for patch 26.

Best,
Gary

> +{
> +	return crypto_shash_descsize(tfm);
> +}
> +
> +unsigned int rust_helper_crypto_shash_digestsize(struct crypto_shash 
> *tfm)
> +{
> +	return crypto_shash_digestsize(tfm);
> +}
> +
> +void rust_helper_crypto_free_shash(struct crypto_shash *tfm)
> +{
> +	crypto_free_shash(tfm);
> +}
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index a3c42e51f00a..4b08b4f1d3a3 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -30,6 +30,7 @@
>  #include "dma.c"
>  #include "drm.c"
>  #include "err.c"
> +#include "hash.c"
>  #include "irq.c"
>  #include "fs.c"
>  #include "io.c"
