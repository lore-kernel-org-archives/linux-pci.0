Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010054.outbound.protection.outlook.com [52.101.56.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D3E1DE8BE;
	Mon, 26 Jan 2026 18:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769451562; cv=fail; b=uQt8EBJa0cJvlTRSzL3nBEgChfrvH5hOprZY6J/CZp3erebP9VusC0FsCiK/mL48m7T5hMlT9UOaQUpqvGSS7QEcp2lTmCMLj5y2wBixGPz3Irl5qqVgFLMGdSIiWumVsNTQFy475qxGdD0vjsFg4UN9GfiRXhvur1K9w4KMXgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769451562; c=relaxed/simple;
	bh=jvHJPB9BiwUNvOi2APPnlwHTVtlUpcuJ80QbgjDTsCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mbsqflw69kIzg2Wk7UiJ2U63wxt5YU7foEmHHM7FIUMVmtHtF1tOaR0jSGMbgPNqt/70xIXqJ8i++5oFwU3gNpOdermwCiKJB6KLi9b/Jq7cWEfRwaTRsvTjq+bhh7ATpiPfLQXvprD5/cLZ9SFD37YxqM7qCk4fyZs7pk7BEEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MXffpTth; arc=fail smtp.client-ip=52.101.56.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MXffpTth"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObwFkMx86pqhlC8CNvPIObRxTMwaHj0dFBNvEdQQcChXBgJaBS0QpWNJ0AcnO3ibhuAnOPULqhgqTUdsys1d1bde5/48cH5kIp/PrBegJQegzdCW1Tl6f5ag9ubZ/BLEc/3hKuc7ZhHBt8mMoS6Sxm8uBXrlYUseLgvBg8vIZTfa7hOcY3wpQJ4tdfmvD+bRScEhb90FfNzZ8y57vcLFmPNJFJGJbDItcYF4ipFTDj+WYlCP9w1wmFOktgYTEr5JZT9tsXLPgbD0t8FFi4AuUJ6gfbCXz12yyzX22Cxxloy8qcul/GeCA8qriNgn4nMGedxa27+RWFyHsxe01XbI2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H++95ao5JiJt6IktGNi2k7zbKKcq6GWcjpGUVXO428Y=;
 b=hf4B2w5jc2g98J10oFY4PVy9HvcTJrgiPLMxJ9oD4SRRJsZpINzV4Iks2TByBLQIjTNTJRFhxKRCAvY35cyFs0HDyWw/1HGO4wdSkNiNf/czHiICJwSjXM15AV7EXSpRHlfx7SKq4GQ69hflGamccrHSEw2GRozDIg6vW/ar8iHYaWeJkfC22nUCAjmHz3kLkcepzrJ051W3ZRqp02UJnmXNC0deqOj+F8u1ERJYqz1e0JdNWqxDzPA3QjiDLGm0fkzznLPevDcwjJvyI6/LGcZ3w+FtPURwSLfIIgtin8TrTcl53RPn89AnfRx1DXYzPoaiIsfYE9jA9YW/5bgaxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H++95ao5JiJt6IktGNi2k7zbKKcq6GWcjpGUVXO428Y=;
 b=MXffpTthPUPKsttmsTG0hBccOZHmMV8+ogG5G8pVgYrBGmKaTmJA6rW4zdNQTN93B9Zeyk49ZzvU9eyqMSn7MC/xdWoplV4FWBt4DshdFzgd+8pgmcxnT0cZvINik2th5/fNTLIbODJtVzEM5Bd7mukmpBE810OqwPq7ZXFiWWbFQIa9wBcBr48DHwe7BK6Bq84qQyvlLE0TLBuca/mqHEjhkiFmF4rhU7onPpSIPCVQMuGeYFtbWbhC0rf8iwQCcP0Abm1F2Lz9iGdP6/LR910/jeOkpHrcbEGvxn7aTYmLQIa/P/1EY3MEGN2E+BlI8wnbxui4otbSW3LvVcJZtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB6969.namprd12.prod.outlook.com (2603:10b6:806:24c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Mon, 26 Jan
 2026 18:19:13 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.015; Mon, 26 Jan 2026
 18:19:13 +0000
Date: Mon, 26 Jan 2026 14:19:12 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Zhi Wang <zhiw@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, dakr@kernel.org, aliceryhl@google.com,
	bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	tmgross@umich.edu, markus.probst@posteo.de, helgaas@kernel.org,
	cjia@nvidia.com, smitra@nvidia.com, ankita@nvidia.com,
	aniketa@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
	acourbot@nvidia.com, joelagnelf@nvidia.com, jhubbard@nvidia.com,
	zhiwang@kernel.org, daniel.almeida@collabora.com
Subject: Re: [PATCH v2 1/2] rust: introduce abstractions for fwctl
Message-ID: <20260126181912.GA2131321@nvidia.com>
References: <20260122204232.15988-1-zhiw@nvidia.com>
 <20260122204232.15988-2-zhiw@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122204232.15988-2-zhiw@nvidia.com>
X-ClientProxiedBy: MN2PR19CA0059.namprd19.prod.outlook.com
 (2603:10b6:208:19b::36) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e38f86e-cef5-4397-38c9-08de5d076881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/ayv9tXMui4ljPK7Aq1kXKaeOXKLMjkbNNGHObwDTXHXaLdz8LVgwsaOik/+?=
 =?us-ascii?Q?IP9mzSpyXJlKIveO9iIvTfGu9Z2G9hTYQJALSevwgXYIlCeLiA6GDamGzuY5?=
 =?us-ascii?Q?VinTjsAIR+phvBs9dfoaodr1JlZu9xgohl9LZjKr4OWOjZSNafftcZdwMD/I?=
 =?us-ascii?Q?lZLR0n7Ytvev8EBZsoAGdPeKXWH1xbWo0n/nIJ0jr+Z71PVfWSqF7WzszEr2?=
 =?us-ascii?Q?XO6Vae+Wr8PLX24/YL/xFAGqtXjxlyF46LPwZ+uv80hyAKQ3UDDVNR5xwx1D?=
 =?us-ascii?Q?2RQmjKsv0e9KnzrWr9GUBAydGZG9ODztIvqBfHHhyrMpKLOnMh+TcqJp/1B5?=
 =?us-ascii?Q?NsL6r5JlQSrko3N92iBr51n5L3Ni3tzUgK1+frsOe4UMGBSHMNFxIUaP56tZ?=
 =?us-ascii?Q?d11Y5FololI9HGz8I+WJud3JU2e8AKDS7vsGVGSqIDY0RGyagcnNqghyUN75?=
 =?us-ascii?Q?AkCCJvyl7AGzRNXRmjhjiEaImKyC+TU1oWa8cacDD+wLtPP6V3GaMdpfuNDf?=
 =?us-ascii?Q?moH7NGiukwvHms7da5U0wg9W9rGHA6EiBopjNqdgK6gfFZX5XYFii/14IUEa?=
 =?us-ascii?Q?b5VqbJJCqnH28CkyaJM9TseDx9K1Y8CBbp3yR8uqpxEfevgVvX8TaseYFHno?=
 =?us-ascii?Q?9t1VoqVO/T8P1z3KfzdZjjQ9vFcbGwtcW++KfACQ17dyQU2fdo6Pwy01ayZ2?=
 =?us-ascii?Q?Jr8MzcdskpSbreDVx+S2xzWtWg8y5u2aZNcSvXtbmALOjRprENUjYhMbN12W?=
 =?us-ascii?Q?pWSjD9pNeCey/citZzWiXkLHpjW8TE5m+qrxqebwSKSxiZrTem9bqTtupQ1s?=
 =?us-ascii?Q?Kq+TC1PGQn0NXPDiKjtrn1hO1N/pVtdUkV9JWQ+OZlW4u+yhEOZwfQgo826n?=
 =?us-ascii?Q?ASZ9snEtdOxZfXMNrckiCiFy1Jmz6Ndn4lRK7QXqu0rw0443c7ecQ3WhfhJn?=
 =?us-ascii?Q?8FloBYSpiERic033MAWCRscJXqUi2RGfipt82jkENjGqkGYP11n/Rfs4Df00?=
 =?us-ascii?Q?gm/MWddlTn+ErrArrcJo7Ad1kq9r7r2DWJrN1c2BSKPNotNXsrqvLKg0u2i6?=
 =?us-ascii?Q?OlItZzcwU/krZggW052jDNYc4FeK1dUhlurNlguGQkfvvz8eX79o/Y8mQpR6?=
 =?us-ascii?Q?PlfWXJKrHfG+2GKSyQnDqACGTASnBmvDT8VbKokykfz+4WuRik2DeAaX+u4A?=
 =?us-ascii?Q?6JejlXp/p/YBWNNDjGBe8CukRTkNQS+Z2YsIjwQcDAWChA+5K539IBaEZQtc?=
 =?us-ascii?Q?VBSnAiCU1mfUFgsi1zRR9BmPQhu8tvxowB9IpxVDpKVcEZMVbJKvVhYwsj/Q?=
 =?us-ascii?Q?7HFFflKzqiI/03SriJ489aHAoUkxJC9bxX0bhXVS2SGVgEy2pOTlJcXphHha?=
 =?us-ascii?Q?9g6PrSR2YemVC20OIOEd3odn7KRV6Im/Kfqiqz9dTRyygWwEYr8lhEPWuvtC?=
 =?us-ascii?Q?W6ag5sPPsrrb5A0WIAC8NwAPJr5mSJoqr0oUmC5rZTViQ0kUxuHtT7i1uKAk?=
 =?us-ascii?Q?dUy0Whcn8lGO/eztj87Su5xb6zVQUhDiJxPITdGfe2Lj2wWbT3wEanSEb8uI?=
 =?us-ascii?Q?QGtyWvxhSSwPxrre3hQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TsYbMGWgws6t3QhaA5Kz3Fu5hf1iu7f5WcHlLXTPmt42Fx8m8f5sIUlr1C3+?=
 =?us-ascii?Q?FcLPFdA5CbkZYemSBazxzZEDYK+Amfv0TxVZD1xMSNUzQbjwPi0iccontchI?=
 =?us-ascii?Q?0qFViOcrbRavhSUAKGG91Jw3bb+0mnfenpcvoRwQm9uCbr1SA574k3TZUxx8?=
 =?us-ascii?Q?sftGYefCvbcc4PswLyQIqENUwDJev6e0fGo2lexaGYa12k1DFP+3Er6sknOU?=
 =?us-ascii?Q?Wf/ZpxgCGrTyld5a4ZApx0/IA4lXPn/jCVpBJpmJg8z1JbsoUDzdavpC12c2?=
 =?us-ascii?Q?aEr9/b2YbE3guZLGpmTT0Gs0Fj8uc0F8rHk6wMkXY87vKsWcnh5rstDwphjT?=
 =?us-ascii?Q?vHL6XUnjcgGFf8TFo0duKnbvuV25OlliPdBlEKtwLHAdU9H7VqqT3mtxSNJ4?=
 =?us-ascii?Q?QPHq9GUZDbiPPmHERPL23wZAQGneW+fmUhIvsLH666F9QIO3DHj1fRAJuPDh?=
 =?us-ascii?Q?PcTgEguhcrXYjUDERaYocxe0yyusToXyKqrRQuTH7CByuRcM/4dtZQvLZ5ZV?=
 =?us-ascii?Q?IEuv8SBvXVNj1b1aQiXAgJiQnJUjoTD1gAIcVX75iSKc61wEc53XCp16idKB?=
 =?us-ascii?Q?gOrAfPqaIK94WBClQ2MspznekdGO5r1fBB5kD3nLjkEWHuoqi3G8SaWAugI1?=
 =?us-ascii?Q?BHEEAZcj1U2+VXlUNW/iudMs36fTgVkLAnyV0xGs7vtyWRo/JhdvfKJX8atF?=
 =?us-ascii?Q?zu1g/t2HPsiF3m+nbqPo475ZA6X0Z3/uRlDmB9FY2PvmIDUV1yGkVTqhXe0Y?=
 =?us-ascii?Q?Bs4AUu9Kc7OsrVk3A0LzeAehpu64y8YWotyZfH6EbmVXrbxwG403rRVd4ey4?=
 =?us-ascii?Q?MsYrGy2etg5Wft7C6CVn9t3IKe5MgQNYlCOe/RRB2y38LKWQYSGcqyiKRiDo?=
 =?us-ascii?Q?xQejb9qc/nMskHLPTLikYwIQjNE4SfyKPC/m0ZGifUa10FV4uvAxwg90Akbu?=
 =?us-ascii?Q?ZoM1Gx2leIRMdMc8z2WyVsDK/7bKkpeiJlgXR6OJksDyCjs+4FBPeTEPkL5m?=
 =?us-ascii?Q?UMoQTPZrvs6vwA8xUDwweN9IqqYi6UBPD+ib2wDlrQn0N+RkMV2cT8kVqDly?=
 =?us-ascii?Q?GzwgTtDfMxYNL/ys2LuiTK1D5CZ5mUIEP+uZVf5EM90fe5dXSLS38xZbR3op?=
 =?us-ascii?Q?bxVv1q6ZjLp+EEBzC3LC6v1uTlOX93wo9B48nXqHvg3dsv41ORFHoU1+3AFm?=
 =?us-ascii?Q?ntd0Yd15b9xLxk3ssHg1wZ4QPlkhJlUEeLDNPOyUWigB9cJkqqQZGfrvhmQD?=
 =?us-ascii?Q?lTctmKXHvM0ndJY/PSk12xyeBafS/usDgoJ6bY4L4vbd2Ldiy/wy3/DcdzPW?=
 =?us-ascii?Q?2ItRriTmL3p0WqrGF9UjFX+xH4AMEpEmGtA8Qt+6vwEc1vbjCKRzSb1tJjh7?=
 =?us-ascii?Q?2xQJjS2zNOdtAfbhRfUSM9AfM4r6MSOW4+Nh1nsKhNEyQWYt3P5vwr5qcnBT?=
 =?us-ascii?Q?VcOtLbvUMlQ+NR1M5KhjAJ1GLx9Wh5YHnSJk8ujJD9uKEK4CYk5ofw31MVMv?=
 =?us-ascii?Q?ojJHrRZQWzDzv1PqKm2Ta/LPJkSPAniLn35Fw0QKq6M5ysNALooC9LvfVHax?=
 =?us-ascii?Q?UgdGlWJWRqeRy9bIxnzNas/zGobKOuCu1eXGiRUiZYhkYEEhaW4CCB4kBwc4?=
 =?us-ascii?Q?8Pb/trPLm91ImctXUF61EU054RbWUivd3HzhgFsDcO3IjhxL9JVy8CFuVzAV?=
 =?us-ascii?Q?NGWuQJ0kl9vR+T9LLm3H6LXdghKH421aIsrTJrY7dL7X4SR0RxmiyKIsab2q?=
 =?us-ascii?Q?/3D9/fDXWA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e38f86e-cef5-4397-38c9-08de5d076881
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 18:19:13.5056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJ9hwykO/Wxj/0dpwYR8IMVFZp2gOwTEM/9zJ9FYdxUvmihA2tCt04H/PWyPGlDv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6969

On Thu, Jan 22, 2026 at 10:42:30PM +0200, Zhi Wang wrote:
> --- a/drivers/fwctl/Kconfig
> +++ b/drivers/fwctl/Kconfig
> @@ -8,6 +8,18 @@ menuconfig FWCTL
>  	  manipulating device FLASH, debugging, and other activities that don't
>  	  fit neatly into an existing subsystem.
>  
> +config RUST_FWCTL_ABSTRACTIONS
> +	bool "Rust fwctl abstractions"
> +	depends on RUST
> +	select FWCTL
> +	help
> +	  This enables the Rust abstractions for the fwctl device firmware
> +	  access framework. It provides safe wrappers around struct fwctl_device
> +	  and struct fwctl_uctx, allowing Rust drivers to register fwctl devices
> +	  and implement their control and RPC logic in safe Rust.
> +
> +	  If unsure, say N.
> +
>  if FWCTL
>  config FWCTL_MLX5

It should be below the if and not use "select FWCTL"

> --- a/include/uapi/fwctl/fwctl.h
> +++ b/include/uapi/fwctl/fwctl.h
> @@ -45,6 +45,7 @@ enum fwctl_device_type {
>  	FWCTL_DEVICE_TYPE_MLX5 = 1,
>  	FWCTL_DEVICE_TYPE_CXL = 2,
>  	FWCTL_DEVICE_TYPE_PDS = 4,
> +	FWCTL_DEVICE_TYPE_RUST_FWCTL_TEST = 8,
>  };

Put this in the patch adding the test and maybe this is a reason not
to merge it..

> +/// Represents a fwctl device type.
> +///
> +/// This enum corresponds to the C `enum fwctl_device_type` and is used to identify
> +/// the specific firmware control interface implemented by a device.
> +#[repr(u32)]
> +#[derive(Copy, Clone, Debug, Eq, PartialEq)]
> +pub enum DeviceType {
> +    /// Error/invalid device type.
> +    Error = bindings::fwctl_device_type_FWCTL_DEVICE_TYPE_ERROR,
> +    /// MLX5 device type.
> +    Mlx5 = bindings::fwctl_device_type_FWCTL_DEVICE_TYPE_MLX5,
> +    /// CXL device type.
> +    Cxl = bindings::fwctl_device_type_FWCTL_DEVICE_TYPE_CXL,
> +    /// PDS device type.
> +    Pds = bindings::fwctl_device_type_FWCTL_DEVICE_TYPE_PDS,
> +    /// Rust fwctl test device type.
> +    RustFwctlTest = bindings::fwctl_device_type_FWCTL_DEVICE_TYPE_RUST_FWCTL_TEST,
> +}

Do we really need these contentless comments?

> +impl Device {
> +    /// # Safety
> +    ///
> +    /// `ptr` must be a valid pointer to a `struct fwctl_device`.
> +    unsafe fn from_raw<'a>(ptr: *mut bindings::fwctl_device) -> &'a Self {
> +        // CAST: `Self` is a transparent wrapper around `bindings::fwctl_device`.
> +        // SAFETY: By the safety requirement, `ptr` is valid.
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    fn as_raw(&self) -> *mut bindings::fwctl_device {
> +        self.0.get()
> +    }
> +
> +    /// Returns the parent device.
> +    pub fn parent(&self) -> &device::Device {
> +        // SAFETY: By the type invariant, `self.as_raw()` is a valid pointer to a
> +        // `struct fwctl_device`, which always has a parent device.
> +        let parent_dev = unsafe { (*self.as_raw()).dev.parent };
> +        // SAFETY: `parent_dev` points to a valid `struct device`. The parent device
> +        // is guaranteed to be valid for the lifetime of the fwctl_device.
> +        unsafe { device::Device::from_raw(parent_dev) }
> +    }
> +}
> +
> +impl AsRef<device::Device> for Device {
> +    fn as_ref(&self) -> &device::Device {
> +        // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid
> +        // `struct fwctl_device`.
> +        let dev = unsafe { core::ptr::addr_of_mut!((*self.as_raw()).dev) };
> +
> +        // SAFETY: `dev` points to a valid `struct device`.
> +        unsafe { device::Device::from_raw(dev) }
> +    }
> +}
> +
> +// SAFETY: The fwctl_device is reference counted through the embedded `struct device`,
> +// and inc_ref/dec_ref use fwctl_get/fwctl_put to manage its lifetime.
> +unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
> +    fn inc_ref(&self) {
> +        // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
> +        // `self.as_raw()` is a valid pointer to a `struct fwctl_device`.
> +        unsafe { bindings::fwctl_get(self.as_raw()) };
> +    }
> +
> +    unsafe fn dec_ref(obj: NonNull<Self>) {
> +        // CAST: `Self` is a transparent wrapper of `bindings::fwctl_device`.
> +        let fwctl: *mut bindings::fwctl_device = obj.cast().as_ptr();
> +
> +        // SAFETY: By the type invariant, `fwctl` is a valid pointer to a `struct fwctl_device`.
> +        unsafe { bindings::fwctl_put(fwctl) };
> +    }
> +}
> +
> +// SAFETY: A `Device` is always reference-counted and can be released from any thread.
> +unsafe impl Send for Device {}
> +
> +// SAFETY: `Device` can be shared among threads because all methods are thread-safe.
> +unsafe impl Sync for Device {}
> +
> +/// The registration of a fwctl device.
> +///
> +/// This type represents the registration of a [`struct fwctl_device`]. It should always be
> +/// used within a [`Devres`] wrapper to ensure proper lifetime management. When dropped,
> +/// the fwctl device will be unregistered and freed.
> +///
> +/// [`Devres`] guarantees that the device is unregistered before the parent device is unbound.
> +///
> +/// [`struct fwctl_device`]: srctree/include/linux/device/fwctl.h
> +pub struct Registration<T: Operations> {
> +    device: ARef<Device>,
> +    _marker: PhantomData<T>,
> +}
> +
> +impl<T: Operations> Registration<T> {
> +    /// Allocate and register a new fwctl device under the given parent device.
> +    ///
> +    /// The returned [`Devres`] wrapper ensures that the fwctl device is unregistered
> +    /// before the parent device is unbound.
> +    pub fn new<'a>(
> +        parent: &'a device::Device<device::Bound>,
> +    ) -> impl PinInit<Devres<Self>, Error> + 'a
> +    where
> +        T: 'a,
> +    {
> +        pin_init::pin_init_scope(move || {
> +            let ops = core::ptr::from_ref::<bindings::fwctl_ops>(&VTable::<T>::VTABLE).cast_mut();
> +
> +            // SAFETY: `_fwctl_alloc_device()` allocates a new `fwctl_device`
> +            // and initializes its embedded `struct device`. The `ops` pointer
> +            // points to a static VTABLE that outlives the device. The parent
> +            // device is guaranteed to be bound to a driver (Device<Bound>),
> +            // ensuring it remains valid during allocation.
> +            let dev = unsafe {
> +                bindings::_fwctl_alloc_device(
> +                    parent.as_raw(),
> +                    ops,
> +                    core::mem::size_of::<bindings::fwctl_device>(),
> +                )
> +            };
> +
> +            if dev.is_null() {
> +                return Err(ENOMEM);
> +            }
> +
> +            // SAFETY: dev is guaranteed to be a valid pointer from `_fwctl_alloc_device()`.
> +            let ret = unsafe { bindings::fwctl_register(dev) };
> +            if ret != 0 {
> +                // SAFETY: dev is guaranteed to be a valid pointer from `_fwctl_alloc_device()`.
> +                unsafe {
> +                    bindings::fwctl_put(dev);
> +                }
> +                return Err(Error::from_errno(ret));
> +            }

This looks weirdly sequenced, the driver's object has to be fully
initialized before you can call register, so it is quite strange to
see a wrapper that does both alloc and register in one function.

> +// SAFETY: `Registration` can be sent to other threads because:
> +// - It only contains a `NonNull<fwctl_device>` pointer and a PhantomData marker
> +// - The underlying C fwctl_device is thread-safe with internal locking
> +// - `Drop` calls `fwctl_unregister()/fwctl_put()` which are safe from any sleepable context

fwctl_unregister is not safe from any context, it must be called
while the Device is still bound.

Jason
