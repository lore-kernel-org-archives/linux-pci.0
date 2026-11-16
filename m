Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794853023;
	b=Prnh6o/1X/2ZELMjBpQgM1yHqN48+Wk6KiwwSmHQXoyG7tzVBJSLPZUcygu/Rk1Lp/05
	 NoZHgEkBme1NgSqhfSVT2TPqG2PZcbZtUUYEpKLji3RFLUuPgzBmSy+Ju53uogwCD1cF6
	 JuIUyI9Pb/uMVW416cUfaE29NA40sxJTDO3XerbTdHY0TRtbEwJKtWKlT2dZtPJjF1AAs
	 dH+iib+J7SozdXgV3SxMRnZkIIQ9YeW/gAoa9agHZX/jHJMhAt/q7jjAr+IpZt0Pgn+9p
	 u+ci+ezA8Vj+L3EbPvBus+4NG5AACqDCS+oIGXPDbarhjdeB21T0PVD1uITmLN3nybQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853023;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=oNfu7Qx9QWNdej/Iw5qZrDdqCuxWsTyvULvk1oCcjrg=;
	b=P0GCejbU6rM/AbhXJcoq27k0ZLaNBurNAqMnYyWbD2PO8yC+hao0E7Zbc7KQyAOlkaVz
	 wKU/SA+sir5SFKhxA5u1ycxf73MVUPvr9KBLv9ekk2/z5B0RkLFuvi77cZP6FcbBHiGOd
	 Ozg2itlKdijYLeU57xxfwQNf9x7A3VFyIsuQ+HDYecuUdlIluiARHnrxRVb+CtHyGQcrn
	 Cgo6dXshskRfHXjEiyqImC2z14dWsi9xRSXaXlF1v4ZhOZ0zPgWKZVkZhQjNfFDDs7Bz1
	 bRyhFSQuIP7jP3xClDyo1H5g1vMbpAilAnaz6YP3n1jTWT0GLsBU3JLm3yNStF34ULQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="S0KQW/gG";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.16
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011016.outbound.protection.outlook.com [40.93.194.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF25606A322;
	Mon, 16 Nov 2026 18:17:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EF25606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=S0KQW/gG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dguWgp5nZwI7wdiH5v29QkrmOefmCM9LGK/eP3OOeo2AwHQ+3g/CRTAee/gzNvp+WHryRrjpTLsRt+vQv9aGIrBFNJieikoGdC3LIQKOZAKHf2ueEzVpaKag8OL4S505z1DZvha2RTIIUvUQIqrlRsPQ5Ifnycjb/oF0V57ZlvgO3jIj/iHbpetc9JOPDo4QAu5HmyuSIDLdgl6jS6dRmyXEBs2yv0AUzgkmDgJuva7eIctKL4ktPZ963CMrgG0zzRxKA74UtNK5xTaEBgghhAGprvCUoIMd5krFLBH1lUqE/gJCA0mlvFM6mBbRqk1yLslt3irSe20QZ9iMr700Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNfu7Qx9QWNdej/Iw5qZrDdqCuxWsTyvULvk1oCcjrg=;
 b=N3ktxXEJ8UxDLUnPkvxl4sn7XyUrd6UJXQKaDzqa8IIvGCnrmMba/7OacD9oq3y+9HdYqmYA1SOKfhJdg2BCjX6zxjlQUNppmE8bj+vxl3ileVEWw3d/1V53dSKexwmlOebPhnR+HKQxRyyn+1toCv0awZRgbrvtgtTbWkKuplHKPCW55DofvW1+3m0PDAKeAH4HC1fq7ZF2rUiK7gph83OAspxM/b6wj/SN6uewNV09ogqvag8L9owY4AQBJ6Kqlbq9XMdiPtQcUSU6Yu5ehMwHluXy+rYINbgQSyPZqYDK7mgqaifrgBeW4y229VoQmFeNB32tE1OFJOKXZh6isw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNfu7Qx9QWNdej/Iw5qZrDdqCuxWsTyvULvk1oCcjrg=;
 b=S0KQW/gGelilkQ7f8MxA51pYEScFvW771oWc3hPjP6K9DqBd/WkYR/kmT6ilmOYV7FX3C3K1scFilsNQe8siTE3dYFfu3/8caMKrADxPK0jKvn7qfRwiBznWOqVy42F3k3DS7tZE0Q052wL92vCaD1/B69m5iy9QOSRBhdJ9S8//ZqHM5IASFzp1x+qOGc3As5Q94yLQBG2aJozR+Ba1n1bMYYsZ3rH7iD1IFn96YEnFek/7mDxR4PH4eDn9153v3Pjn80UvDhZW1vTgm+VhQMweSvPr3+QuGlUyk03hSqH5jwf16oj/l+l7Qpqyy42HUWvy/8R4sBr6DJa44Zrmig==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by CY3PR12MB9605.namprd12.prod.outlook.com
 (2603:10b6:930:103::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 16 Nov
 2026 18:16:59 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 18:16:59 +0000
Date: Mon, 16 Nov 2026 14:16:57 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Mastro <amastro@fb.com>, dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org, Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>, Matt Evans <mattev@meta.com>,
	Matt Evans <matt@ozlabs.org>, Mina Almasry <almasrymina@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC PATCH 0/7] vfio: selftests: Add peer-to-peer DMA selftest
Message-ID: <20261116181657.GC2245175@nvidia.com>
References: <20261111192411.4133780-1-dmatlack@google.com>
 <avYjFfqr3T/U7lvn@devgpu015.cco6.facebook.com>
 <DMTK99TDM9AM.SAM3Z4COP9WS@google.com>
 <20261115231946.GB1239159@nvidia.com>
 <CALzav=efnA_ABCZVicX0QeTmHknaEbMeWOy8cS+zHYVhm5z+iw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALzav=efnA_ABCZVicX0QeTmHknaEbMeWOy8cS+zHYVhm5z+iw@mail.gmail.com>
X-ClientProxiedBy: BN9PR03CA0770.namprd03.prod.outlook.com
 (2603:10b6:408:13a::25) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|CY3PR12MB9605:EE_
X-MS-Office365-Filtering-Correlation-Id: f1c7f693-4d60-4aa8-55ff-08df440dcdff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|7416014|6133799003|22082099003|10067099003|18002099003|56012099006|4143699003|261021121427099003|261102123227099003|261026121527099003|11063799006|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	gwJMATy1A/s7NhHE/DnAwlVouUWCaz+rERA1TGEOLE0iQgPFrhxVT3gsSVsjhVoVfnTordSnParP74TatUw1Ed78QzHNxbSZUM9ty7cOCqmgwJ6aVp/uNO89rX+X6x8zbIgVkKWxH+h8N/CEOqiqdm6fdhyJ+d5EOOpuloyFbR+O1DozI1X1iWOyoz5CruiDxVRcfSfbu8kOiWuf52LB/l4BWfYAq9EmAozmY0Nwnzr0K5Srkufq+FDukwI/LNOfnMrFMAaRSeglum627kd8FLQ+rS08ZNl++WUde3kaEkGJC/vcrHNzTtOH2ytDqIDS6zP1CeTP6yVndRSlbmq5sGYvA6GSirsdCHSGveg5U8WKi7MUhfwyP1u1aXL6uYGNwFbb5EhGQEw1uIyc5I9HvZxqDN2QVaUqKoziOekNnd1n3ckB/lc1EhTK6KHLJ6QMPN0BGvoYXW8N6KFpeTVVWwXAjqUFVRrW8z4sEajaQBnO84f/bqmNevXxg9VTbBoGMRm8gJud1TwDCwYg6R288y9gjXZ5UQdyMjD2CrVoJ8499qJMpzL95KXO57X1VjiNDDmKvH/kgHNAqUig/ruE8Y1178CzxKDjNX1UQi1scmHU9eMDsFRxmSnJKf26EnESKO0/8UpEYDZ18wLKliu4RlLc7pOvMDdtH4ois8cYU5U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(7416014)(6133799003)(22082099003)(10067099003)(18002099003)(56012099006)(4143699003)(261021121427099003)(261102123227099003)(261026121527099003)(11063799006)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qGEiDsiLCSQTw25Etch/rvT/THlWeutyqsN/MYcBPQMLbNwX7XJTiAj8ho1X?=
 =?us-ascii?Q?cjb1Oy3YN3M0wydc1BHU99ezBsVWkuNwrWce2hhiRuz85GH87w7DjYkWVKrn?=
 =?us-ascii?Q?55HfQDZUrOgzwUAk1hXF3uULRa9ZSSf5hJMgIZ9Jx1/0p5FPajhNdcmr07em?=
 =?us-ascii?Q?C1YIgJ3Gj9U5xFBWW84IoqKGqK5ejGc6tlBb8/nCRzwkV9ZyG4oJZ4UdXrE+?=
 =?us-ascii?Q?E60qsPxDzIdqo6tYpMfgituryY2pTmydW5RNnC0ZAlRQ9Ia57bEdFeA+Alty?=
 =?us-ascii?Q?FnP6YnlhwSpSJdKAXwA/H1E9hH1K6+FKNayOLNpSbhTlYGDncRpQUVMXEEmL?=
 =?us-ascii?Q?cTGZ5UXtfd3kzCVCp9vaJ0K+3zF/70QZZ2E3i7ImGigR5pYAZL1pnDDOf3KS?=
 =?us-ascii?Q?MLgpj1T0XihIdTFEthBXC0FOx4JV6NTwJAsnrbhB8bsGQBdJjqreUK32zk2W?=
 =?us-ascii?Q?s6R0GIQE+WYKKRsyNWLeQevL6k4wNdtUmDxRnBPDk3VH/Y+o9QyIMuhC0Vr9?=
 =?us-ascii?Q?7UdZFXqxetJXBXp8kILcuYcFY9CsPhb1hz/YIO6DbPmgG3nJGgUMEhTS7rj8?=
 =?us-ascii?Q?vvdHHwM67FCX6OyzWp7NvMvT5clYRs3rUbz1vvpDqCVpaYsIzurTMXCYOyLe?=
 =?us-ascii?Q?CnoAS3e8ktykofp/VUSLvUDpd5+iYLb/w1CuzHekpifgrrUAhCuwd4cNOuDl?=
 =?us-ascii?Q?mvAsU0tLuhQtCRYINpD+goeHnKuyJi2unaKWKh4Zp8yQN4cVcwBSyiNlsIWP?=
 =?us-ascii?Q?XPzWCrX07Er/VqUn1Ao3fWBDwuVa4ESsbqWTJBv1Rsj4AguJKB94G7nPhv1s?=
 =?us-ascii?Q?gI6/T5ojOuAQObHn8+9Mr1/x99qUKOQNybf4hdG3bZyLgI4FE4xupj0Qazy7?=
 =?us-ascii?Q?sMKomSYpMQsmftpV0wN3nNvCjLQGHP1wGP5Vq9FyEOKUh0hhPtdCctP+BRa8?=
 =?us-ascii?Q?ZSg4D+O76UXZq5iZi4ZSbrdEdXS2+hWqKGRfxOmQwj2V1gqnlGOWVZdR30dM?=
 =?us-ascii?Q?J1V7b6n+FUpP8JjNEGEJgxBQAD2sdWkCHvxQXALNUGybJjrgn/vI+H4DDDg1?=
 =?us-ascii?Q?GgMD9WBh35gJ88CL+GR0SDuNqsu/trNaPPa/PKGp/fXO8AOTVghfTD/P2Xat?=
 =?us-ascii?Q?kVWsdC21Lsc1VraXpd19Yzn5TXCcRiOLZVyDPmic6g4QY3U0wDPZf8mhUnnU?=
 =?us-ascii?Q?TPTstesPI3eXeKLKg1i1kURQYjtxQVNAzaUtJz0yGQ5aWztM3pjzjXb1+/Gk?=
 =?us-ascii?Q?oCuHaP1fXUWLx+AFgEiMpEocI70yj0T8Mk2ua+asY0keD38YfZetUivvrmAZ?=
 =?us-ascii?Q?JgYXBNdXddCi2wIr/Jdx3g7EeBULhIx8Ak1MZVxEcttzU1Sfdsf7xCxf9TAV?=
 =?us-ascii?Q?C2AU8/N/2ZnRGzsMa5o5LMsMoiNjwIg8ami68JSiiO/siXUfXPI8jX/44hPV?=
 =?us-ascii?Q?O07zy8z3G3X4ZLkQZc1lQVYvoHMrp6Uok1EuyXBbXX4WjF3dig+txoBfvMjm?=
 =?us-ascii?Q?dDO+88vuir9iT8yv3PibbghZQkBcfNUVI67rD6j/MNDFvjhpWV6LlnMmsh3Y?=
 =?us-ascii?Q?ydhmpRKN1V8CkeGFt64QgFrHecgVjwa7vMzPx3UKKtyYU5xlHuLHj8wL3wUk?=
 =?us-ascii?Q?80/OnN4K5CtusOh98rDVfT0rt0aFUv9hCT8Tx5V7IMxTNs0bpNQ2HCottUH8?=
 =?us-ascii?Q?Fs4HV7R54RMRP9Mq+iWzqCJJbxZsUInOqU2RdEAO0trP0PIw1L+yFoed1jV5?=
 =?us-ascii?Q?Z5scw5TiWQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c7f693-4d60-4aa8-55ff-08df440dcdff
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 18:16:59.2497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZluOYr7nHXxiyLsI35fj3xjusr8Rqf5BVhPpTIIqAXgupTPEaV/DXlJ0+3ll8Szd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9605

On Mon, Nov 16, 2026 at 10:02:56AM -0800, David Matlack wrote:

> > > The way I designed the P2P selftest support requires 2 things:
> > >
> > >  (A) initiator: A device that has a VFIO selftests driver.
> > >  (B) target: A device that can provide a memory BAR (vfio_pci_find_mem_bar()).
> > >
> > > So far I haven't found a single device that can do both. But you are
> > > right that theoretically a single device could satisfy both
> > > requirements.
> >
> > mlx5 can do both
> 
> Looks like GPUs and NVMe can do both as well.
> 
> How would we implement vfio_pci_find_mem_bar() for mlx5? BTW for the
> target device, by "a memory BAR" I meant "a region of a memory BAR
> that behaves like normal RAM". Sorry that was not clear.

It's a litlle complicated, you have to allocate a "Device memory" (DM)
from the FW, then you get a chunk of BAR that is like RAM.

There may also be some device boot time configuration that has to be
done to turn it on, I forget.

Jason
