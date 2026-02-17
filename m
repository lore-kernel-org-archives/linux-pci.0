Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011000.outbound.protection.outlook.com [40.93.194.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7E118A6CF;
	Tue, 17 Feb 2026 23:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771372643; cv=fail; b=CHH+vaH5gfPXlK2V0mHtmTEmHTkKxsA69G1tR0DId1i8OBlGcd9yebE3n+Plk1SRxxBVYLlNYea+ukhC1SAycBklux4WBMmM61HHs96LUiTVUZSHP0hkgvhGGcnqVUr2KLx5v016NuqYc2UTpJ8yjDONMEXvlmn3Yg9ELzKEXOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771372643; c=relaxed/simple;
	bh=j6e+nrpQOQ/YyvRp7UothgxNdMFCBJwMmBGNK8STGaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CyVZaF3YB4U9oJRngueFrPsXVARS8oxAiktGRJvYaZTmJJ7NlB7g8QjgfjntMas2ILucIoekGvtal2uRfCyObziszfpM4k9z8/f0ll9ncbLbisir8NsRPrqFZSV3ADMgWKJPh8sGvm+SnyDotMjmH0q40GBTWTaAsvl/A1NWve8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tGLJWsZA; arc=fail smtp.client-ip=40.93.194.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tGLJWsZA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KS1xQ9s6Z+/poO1/RKW3GRVx6QP8wINxOUprUYJXYmqNGsD4Nm4RaFL/JYXlEiv1A6jC+8g+Wv041lStTu4kSPpPv6ZrqcXom8nB3iBB2Su/RpEya/fsefpQ0nmW38wWRPcf6xbMOWCg2KKN+v8f9ozZdO/iR4VZmpUZEz/W7juAllOB5JFyaQnBDp2+e30PUM9hRRKLS62ddKfnZiYSUhgVieIfLrfGbxs2hKEqL9IZzP7CEU0Uyp6hQgtv0B6G/WO3vsw2imv6OrG/xft9ejR7KIxxU2Opntnc21PffMv0xhtOEZrfdYu39H7VaWtv+yki16V4dNYbtVDpigXQrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yE8mAKsS/84BA9aTu5VS2P/KKWMpnYsPGcwNhritQbA=;
 b=nLFdnbTyhd+niaU1itQhfACHsh12ul/z6ZqKSU9B5C1jlFAjQza3jW4FVLhpJb87aqMelSrEMpgdad/1QLvlK9/91NXcWCUxYFbkQaAeO2Knq1Vs1/r2MFHEYpCWhd4UGKxBaxTeKkZl5elFebJA+38y//7G1vZZXDZb0BjP+qn/WtZA1VT5JB/uuRZJmb2hXS+xOa/gmwncRtpgcmwotWzXUKFTPyOmLAlJgqVYn9ZJlhZ31s33XR16bCpqeIDHMu3Ko4n+ZRJQ3yDAz3en6wLTJiRt4XNrNvdCk2ieLZ5uEsIhCq0Be6WM6AT9YZ2fHvjk2M0mBGD61J8WgJcVIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yE8mAKsS/84BA9aTu5VS2P/KKWMpnYsPGcwNhritQbA=;
 b=tGLJWsZAKffBl+1aoUlpyvUJBF6CT9qRVDHl3fo9wSlIc837TVuC0CBIpaa8x9zQnyxfYLx47lIOd4XK09WZeDdfKuF/DUXmBvM/WyPk8UyHQo7pXrCZQwwcMZjiKUtd1FwHmAQwMUYf7IUyPkUqp4kaFqwi6OzC7wutu4gwX22OP8soR7ixi1+eO/RRo36brBA0kZr0wU0S/JFT5f+rHjPWSRGoE6qT8imjv2OyIhHRkVphtFjUP/Ai5aj7FKh7pniW4njwk/wRF1yQZMeaXrFPgkojX9psa3l64jf35LNkr31xKmhtEfrjO8Oh4lbacf4ul9N73L/29sxOODvYnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6306.namprd12.prod.outlook.com (2603:10b6:208:3e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 23:56:05 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 23:56:05 +0000
Date: Tue, 17 Feb 2026 19:56:04 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: alistair23@gmail.com
Cc: bhelgaas@google.com, lukas@wunner.de, rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org, linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com,
	benno.lossin@proton.me, boqun.feng@gmail.com, a.hindborg@kernel.org,
	gary@garyguo.net, bjorn3_gh@protonmail.com, tmgross@umich.edu,
	ojeda@kernel.org, wilfred.mallawa@wdc.com, aliceryhl@google.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
Message-ID: <20260217235604.GA1595019@nvidia.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211032935.2705841-1-alistair.francis@wdc.com>
X-ClientProxiedBy: MN2PR20CA0031.namprd20.prod.outlook.com
 (2603:10b6:208:e8::44) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6306:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aa43671-6487-41c3-cfe6-08de6e801ca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FjtqG1dWeIEXvNrbBqBlFyHwto6lcoRR26ZGbzeWpPz069v2kS+ZEp/HRfFf?=
 =?us-ascii?Q?3bKQFuO2f8W5dYyGkTRsvBMZNWBYtqWEUGuUiNX4YaUevSZ9y2CyGNXU7tvg?=
 =?us-ascii?Q?eBefxy1n6b7pg7sO+Q7MqoKMKZ2xN5UibWnl2qLmmsEbo7Ok5bCqytTe1bsJ?=
 =?us-ascii?Q?wLpulUfPSyFKIOGuPgTIVui3QMHO2d5v2yuoScy7HbgyvBYesGNQB1a9hJjy?=
 =?us-ascii?Q?hblagB6k3KZQzQJOuvtyp59MJ8Z5w9NbZ2LreUa3Yfh7XEHbIGnDFYd+7YQW?=
 =?us-ascii?Q?fM55CElHbEyJfQlDF8XBJKQMAmvT92Np3+NN33MA9FhVXUkkOhcRmZefAO1F?=
 =?us-ascii?Q?K5WmUe2cVpaWpeLbiJLNvL+CA9YXh8Xmvtuz+sTyL/GTgOIhlTQFeMza1SLD?=
 =?us-ascii?Q?vlzeaqy1bNu5eKBOeK/bhwXHOJLf287VVEKdH8GYdcKF858VyoXMlrBCZmtu?=
 =?us-ascii?Q?H62FhI6L37SjT8QX1+m7DB+zrxqr0xftvbTGr89RAYBy2+IbYFjLbTsh+qSz?=
 =?us-ascii?Q?/fq5yjqnXkgwiJPWSu9SOqidqD4jc5LcvRFQdTGd6uC6ROTg6FgsQeHNsmIf?=
 =?us-ascii?Q?IO6PcTpZSiLF9xB/kgSXR+Bp/SjsZMIfNLKwFMfUAfwtQoaTKAyoGM2Z0Vrs?=
 =?us-ascii?Q?vi7K9yMk3nesPqhhY5zI4dDsWkNKBVCe7iPVEl6X3AazQRvoXaaL73IRG+uO?=
 =?us-ascii?Q?0clFveLVT4PNa3B4VvEO8ED1rNY33ysYeMls7/mKb0bkIzfU4tv9EwYO8XCr?=
 =?us-ascii?Q?G+ZBSw3bk+cgaeouG5f6fCeqwIEGaYXjqNXrb0hppmNvc/Dvx042095f+mEk?=
 =?us-ascii?Q?uP58Zj9gweYRqJ3ntkcv6otd5vqQbwQSMJLOBEZq/u2sR08xLi7aswPQtF9V?=
 =?us-ascii?Q?aEBzU6CDFKG/gbkIVj8pt0g6JjBAb3CiyBTr9+yt+bH4nlISuz/9hWqDfkQG?=
 =?us-ascii?Q?1IfZXunTq8sc8FMMLH2h9jQAWQY3iP5BPabRocYYt3hYayt0Cue9heu/1EmB?=
 =?us-ascii?Q?B8a6D70oKXzCMEN4Wq5K/kqYVlg0qh3RvV/3LfVVG5YQWMOI2EFRLSlekKfq?=
 =?us-ascii?Q?U7pccaTu3IIX6IGMeU1PgXlAKODj6JWcXFVX6tYYDPz9ReI03v3RjaQNPq1E?=
 =?us-ascii?Q?AmkOB7bRRNEbsQfRIK4sC1PsPUgdIoJPXjj/eDpByBwJflJrTaIkkiailBpK?=
 =?us-ascii?Q?WDZbIy3rvED+Pc/LIxUMiRKmfedrxYY3bv/Pks2ARQuVCNK4T4RSvchc7wgW?=
 =?us-ascii?Q?Afrk5bR1p3rmW13eMK+b3qqkLeplwo5xvC0JU+iEDugn7mGsB+/i+xvqwYyb?=
 =?us-ascii?Q?OErif2iUZhXt9ZDBM2LVdOwUvT0yUT6yB0uYcRlyOsNs2CbmK8hBRxAtEpev?=
 =?us-ascii?Q?l97IHTVyTsEJJMCDl9ctrBxFeoag6Eaf00bFh/Ywa2H1JFgAFTXntzT098NG?=
 =?us-ascii?Q?2tiv985/8n4zVKRaA4DRR0XQ93Cesl8rChXUcC9ttMZ9j1rnbR5nEm6TIcDj?=
 =?us-ascii?Q?1cHlyUbW9aNLT52cin9BBnNppLvOSw2va5dM4bPwQ1xs1RqBUsFl3YaZ6klM?=
 =?us-ascii?Q?+7xAg2I/2HOqh0+2+TU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5vGxMSFPIQOesz1nnb50LBtuvAO2X33P8ZUBvhbc8vugRBDZWwEEPEyAnV4X?=
 =?us-ascii?Q?lpO7RxXc4aLQkH6NKP/v52xQzJd1qk+41CQPhOOtzG0vJEDGjBteEa2WFIcQ?=
 =?us-ascii?Q?NEEWT1fgDsmyxoEWsh/zOS1hz+nTAYJFDjvNoUdTsxfp6v3iT/9re52PPYo7?=
 =?us-ascii?Q?ILTftgoSA1cQjn7djkt9t2HB47Xzqy+dXGTVgvTcLBdGEAtLv5Q7bbP5xIQB?=
 =?us-ascii?Q?5WOU2Ie6AR8Kc7P3tiV14yRb99QvWuonAUdu4jWtgyAoxmDcUwdyg0y05Htb?=
 =?us-ascii?Q?hhOnh5eQOtGx4h55shlK+QjoDae1nhb88VIG/WH7XtKgpcbYYszOAvMO5QE/?=
 =?us-ascii?Q?/RH1iQIiMthXpQh/DXs7Xr4eRiJ9pPY5wKinNI/5hIbJzEhA4BiKhBJnfHHM?=
 =?us-ascii?Q?K6sAamS9pWc5fTjqG8vnb0yLDStAKP2RXZM2KU/IeUiLKAabA0q9QucIPaMI?=
 =?us-ascii?Q?IFl8cpzvtuP/G7Wqzbuhx3P0dgKhYlkmlKpsAo14vSjS/gLaZ4NCWLP6LdEA?=
 =?us-ascii?Q?6xIFmqCDaqFclCOKJ8gKMPHunYoScXH5r6G2xOiOfe8jbHvT79/OgFL5vGIy?=
 =?us-ascii?Q?Zy6qGgmhq0FDzprXl/N9q9K+sGW8GHm4Ks4+uaXQ1y1mE0zAIIsMYLJeOXvk?=
 =?us-ascii?Q?A5EhKMBHyBWwEHg6Es/mny7k7k7QeFBxIRmdTW1+rLV45x1wQSCGuyXDfIPu?=
 =?us-ascii?Q?+qhMlPS/OgRwerGS+RBfom7eBcstP10JWMRK+2yW9agg5gTiVWb7Y9wEd9pM?=
 =?us-ascii?Q?2O4XYgkD0WZmaj4gyQDTaqtYFwLMQbFPiTd4xzfHWcxWuT69p8AJQy5CQ678?=
 =?us-ascii?Q?iSDY8vLjh/skXptiKvI77aIqd56OuWl/hRS5fK6Clq7PCc+nCdYZa5NYsi2n?=
 =?us-ascii?Q?0hYOEHorJI+0arN7gYU0Mfv8ej7XY5YfyXPGibVwAej9y3/WFLnj37yQZdB6?=
 =?us-ascii?Q?xTJUqooxRq1YXqigfTYeRUqN50vwxLo90zNmwr0nIpBRBO1mb2FReIphwZCq?=
 =?us-ascii?Q?F8Dopv3sw3SIodfyQcOjAEIrl+ho7MnEAKt3cEcKqsFeknk3gp5WrHjqEgN5?=
 =?us-ascii?Q?gPD+FHWhXh/qxFyCmlAcpvm2W5qNoLjHKUEUpCjT3ifh+aS02Ko3oeAZLEhD?=
 =?us-ascii?Q?VnmPfICd9TMs+xMKTMakEpM0Cn5084G6+YTjEkToU/jUEqYGvmVvO30YWPKB?=
 =?us-ascii?Q?Ip57H6rAztICKzrPisTFNFcdjeyz1sSm8xmShxMJlo6ICkn2lTboKcctBpmE?=
 =?us-ascii?Q?NgMVH+jJwsFLrqGMX/Qpr2W6jPcC+nLx5e3SJrGy1sn8gTTU9g9ej7VyJuwu?=
 =?us-ascii?Q?Ny/yZxMLzSkXbeji2dN8FrDlGcIiApxNmBqGdt+iawr10NTDF1MXHB0Opbu3?=
 =?us-ascii?Q?b9S827QNU1//gIvNhrv4b4C6yyKAuZocaPn2pXTzioC96N2ObiOJza5j3JrJ?=
 =?us-ascii?Q?B1tduoKb9R61TqEWA8yL9gjR1L0gx0yGx+fZ9gUaEbzexrnSSIdQr3OkYUfo?=
 =?us-ascii?Q?XeBKEwWgNFZaP6P9Dss18nDrNa3zyadb7nuMUgjEGHxb0X68QLuOlwJ28D0y?=
 =?us-ascii?Q?pkhAGwu/3r8c98diRNLWLMTXaoHo1tJgbXfb44wKbVZQ3ULPvVr3lphH3gF5?=
 =?us-ascii?Q?yPPLhfDAbp7YkqCtFhI1Ki5a82eyKgZZcNzsIGoRE/ioCBI249pS4e/C6l+E?=
 =?us-ascii?Q?vQVK9vzaJMF4H2SYXWIFlKKXT06QFJCxPqD3B9Y980Ico2xCDoiFTLcp8LAj?=
 =?us-ascii?Q?7lLeLCxn7A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa43671-6487-41c3-cfe6-08de6e801ca3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 23:56:05.0674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6aHKd0T3H1bUfCsdqpzq1cLFSqXtZnt6/qCh8fHuGFeZ4UH5lq3NgHuOCSNjd8N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6306

On Wed, Feb 11, 2026 at 01:29:07PM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Security Protocols and Data Models (SPDM) [1] is used for authentication,
> attestation and key exchange. SPDM is generally used over a range of
> transports, such as PCIe, MCTP/SMBus/I3C, ATA, SCSI, NVMe or TCP.
> 
> >From the kernels perspective SPDM is used to authenticate and attest devices.
> In this threat model a device is considered untrusted until it can be verified
> by the kernel and userspace using SPDM. As such SPDM data is untrusted data
> that can be mallicious.
> 
> The SPDM specification is also complex, with the 1.2.1 spec being almost 200
> pages and the 1.3.0 spec being almost 250 pages long.
> 
> As such we have the kernel parsing untrusted responses from a complex
> specification, which sounds like a possible exploit vector. This is the type
> of place where Rust excels!

I was arguing for exactly this at a recent conference, so I'm glad to
see it. It is a great meaningful usecase for rust in the kernel.

IIRC the netlink was my suggestion too, it really needs a careful
look on its own. It is much better than sysfs, but comes with its own
pitfalls.

You might want to try to break this up into two parts, one just dumps
a large text file in debugfs where there are not uAPI rules. This
would let the rust work proceed.

And another to introduce a proper uAPI for the data.

It will be easier to get the right people interested in both parts if
it is split up I think, given the size.

Jason
