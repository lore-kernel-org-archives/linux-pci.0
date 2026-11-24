Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795543531;
	b=GEihxDABHitylpvQgc0ck5yvS+PfW0KzC6VxGA6ktHNO7pWnjK774N5HyjNMKm46U0ko
	 IlWzxXDM5Ry6txzoQyWVBzrCLKh698DOIrtZf8zNGDHOQ64ETREZBDCiTGddnqTEViIp5
	 ilSfBzOcXy5UO3X2DNfqLMjt9i8Zjq155uNV8p2LAxpOVONJbth03xNnLGyoiRcyOQbLf
	 LZXtHq9E9qmQQp2GYpN2xIdoZYVzmoTNCY+cqhPzDNsBg1L+wO3ijNHSrO/mPwl7wdqO5
	 w4SdlYOJUYH3LnRAxJoYls7DBSNyIzqbMIZQKyqy3Ys+nZT2TKBzhvjat6Li9f4hU+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543531;
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
	bh=g94ABvJezR+EMdeXbMLU6crw+tg+9kwH2x9TRq9EOvQ=;
	b=QXLvuE5xPzGoWBp4nX8iHjrTI+F6ybvZpq0hdgec8f3YKn1SzHQWL925VYRypPXaUIYJ
	 Uu7+0KCAdg5KfriQgO4deWt0hJ9HDUiFhdFbFhgPTvDmWDQQhPdWkLSMNJrPwbdwTkTBN
	 cbgIfQ5ZqGRUEp64Rpowjpm4ASOVuYjJ24jSjPtik97RXv8Qb+hKF6IBCJhkGORL1vhVV
	 Q+26uO0agFZ3bX+q3y3k+WGdyRpExQra38PoZ2kEdjZQ+pLM5xFIigBJbtvnKrOVa2QyH
	 xp9kHzp4y3CZEQYLHK+3wpZZMw5OvKJ0S1LXHEt9NW03g+Dhf6RWWYZ53/dGrCOixPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=yNMGJgNN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.5
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011005.outbound.protection.outlook.com [52.101.52.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EAA606A33A;
	Tue, 24 Nov 2026 18:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56EAA606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=yNMGJgNN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0EI3r3/kdGrsPdFQXHmJ6uPN6PrNxbW1XrHA2ElnKrw8NawCX371+cMUlsd55cmEOl6lxJl+5E51VhdCx+SS7CARFzMvkkx1dZM4tvULe9549Lv+g7t9Rn4a0mna7GRjXcjeWH0fFTojQJzvp9kcHT+z1rUKIy2TCy7pB+2O+JJNrITKoQPlQ1IU/KbiTXXPZIUPs37XGYUv/i0NEYiq/md5ljZ4agpVXwAgj+XjoQ9HlBOALVJCiNhqVWJ68n2Il38nyTBPs607f6uF5MtK+p6Vuy2WyjYjUV10OY7Las+wV+827dX3adnQZSemuEE8SBR1DWfZN3fFrRi65vWTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g94ABvJezR+EMdeXbMLU6crw+tg+9kwH2x9TRq9EOvQ=;
 b=XNrv/S3U/V2aGayRRpYrgsp3De8e5racY/Btu0SFLTsQj1PCnGb+6QCS+ecGZEOLzqDnJc1jkOzBCs3efpiIm+SRieR8TeCLpZkc4xHG3l+MaQMbLHZxUgVvm1TOxYl6dvfc+u17PqyVnxL5Thp9wrt5JMEcKzg9hbLYtb8xn0DSK0nKx/OfrOCRLkHeBeqQRY4lxUgven3oPoas2D9L9d9D5zsQUcafDeMOkfcEuRVaCrPY8pnW05dGufeD/Xfizsj7xpYI7HrBpGS9SjWyaRJ50c0TtEyDJaej6uxkHalIQDyXNeUVemJYG9N5DfuuMMYKZWMTxFrFOh6gXlBIQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g94ABvJezR+EMdeXbMLU6crw+tg+9kwH2x9TRq9EOvQ=;
 b=yNMGJgNN40Lsi9JawwJOQV2rpTScee8sCgVvqjXuAheaviWAznOs9SOSBnr93Y+CqOxKQGXenQdZLAZ6MbOcHw/8p7wZ6bF890PZY1QgvpeFJliKk+KZSnmS4l5V49rRi7dxEXziDf2EbBsDK4/NQYjV0GsYT0XXTuRA9LNhFRM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from EAYPR12MB923140.namprd12.prod.outlook.com
 (2603:10b6:303:2fd::15) by SA3PR12MB8024.namprd12.prod.outlook.com
 (2603:10b6:806:312::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 18:05:22 +0000
Received: from EAYPR12MB923140.namprd12.prod.outlook.com
 ([fe80::b986:8b81:beda:c167]) by EAYPR12MB923140.namprd12.prod.outlook.com
 ([fe80::b986:8b81:beda:c167%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 18:05:22 +0000
Date: Tue, 24 Nov 2026 13:05:13 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, Lukas Wunner <lukas@wunner.de>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Jon Pan-Doh <pandoh@google.com>
Subject: Re: [PATCH 2/4] PCI/AER: Clamp negative ratelimit burst to zero
Message-ID: <20261124180513.GF2156781@yaz-khff2.amd.com>
References: <20261123165050.GA1741477@yaz-khff2.amd.com>
 <20261123233859.GA1120797@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123233859.GA1120797@bhelgaas>
X-ClientProxiedBy: BN9P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::34) To EAYPR12MB923140.namprd12.prod.outlook.com
 (2603:10b6:303:2fd::15)
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
X-MS-TrafficTypeDiagnostic: EAYPR12MB923140:EE_|SA3PR12MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b06c24-772f-42ab-4644-08df4a55821e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|261009223027099003|260925022911599003|261021123027099003|260925021311599003|5023799004|261026121527099003|260925021911599003|261028144727099003|11063799006|4143699003|261021121427099003|56012099006|261102123227099003|261022105027099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	CRtEfRMEuJe7+wyG3JHehFbhjT/CMpmaYE0l3Rafu4dBTaCb56649jwv0UUDVoHUMY+WIrFvBcp8srrcWp8bwxRV3xFRyAJuP+3JQGm4bFmnzprGPXkOemdIo8rL0tDFZ6JyMGFaItR5fM282RmWEMzd5X/f7kaKB/2uvRO1RPN5ro3qy1V4CXmHQJ4rlWRRWEHGqMPRs7ypH/GPIGNNbq1w1W3jX2ZqKCNg6LRvZhyw9e12LzxsPJs3p5ASf/eULSVRqm5U0+EvUdSYSOeahY5EOe+lYJKv5V/dC8mieREXO3IoycpNughjbuOvRsq32ojsH0v4c48pti7e76yCinUAbYxqdufalOBuokN2wFFHtHSBK/24p/hLjOVDswGWRShB5RCV3VoEEPl/OJh3uYjyGlBhz0T/3K/nVkUFuUXj/uirt/2/S863Xq0Oq5Vu6919YE3lgFuuYv8JNfBiD5NSH/mREATPeX9tsXMpqzDqtqVqU0AYvn3h126YlVS0Cetnrj8RNPc/FcXm/OA4F3MzMM9DfPD/Qc8uBOF2H/wJ9SfcHP77LSMEbKj8fMFgxoJDB4GHlV1twjNetnHnGUrIr5sv6G89gKl7fe/Abew=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:EAYPR12MB923140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(261009223027099003)(260925022911599003)(261021123027099003)(260925021311599003)(5023799004)(261026121527099003)(260925021911599003)(261028144727099003)(11063799006)(4143699003)(261021121427099003)(56012099006)(261102123227099003)(261022105027099003)(261026140227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tP3cM/mZrDqYMEP92Qikc6Lx9JDHof594IOgckA8nk+Sqjl3i9c+Dm6P/Tl7?=
 =?us-ascii?Q?SLuImv08Fx4OlKPHfSmANCBA6nHowbS5qHtzkZ5lJdYWos07baf7xrGCDpwd?=
 =?us-ascii?Q?dkjiyluTBPEe4CUns5zZhR3fuzZkcFzmdbKQxOZovHXy7p43DA+X+jj/5vV7?=
 =?us-ascii?Q?FpPTH5sn8TVO/v26OoSlFhYv3Ei8DmF0eA942tpZVdGRUbqm/GZRZNcZLvWG?=
 =?us-ascii?Q?GerTMxdZRQ4BUvd41rbRBt9EQz6fLl+LVJ+cNVyqfXJx7G8mD9YnD0vXQqp1?=
 =?us-ascii?Q?7xK1jnR9/lZ+RvDRWsy7tOsPm/j4srqi5Cej3K49A1asNDaEerfY5+tc2mOQ?=
 =?us-ascii?Q?lNYUPkOZkvURr5RWgJyhc4fn0tvPglTvWLH9qYs1TP1A8+Xob+y1BefVQJJB?=
 =?us-ascii?Q?nzc9PA0RhCnmxDWMSM8Hb1AFOLVo78ijVD4rHzXwYv+vVztLVHt04ZMrEeb8?=
 =?us-ascii?Q?qRFscCjmjhzClvFU1/Hv49I60ZqbRxVICnmA6K7rYj2w2KDYHRA/6qDgnR3y?=
 =?us-ascii?Q?SOwh3GFfwfYe+kF1eG9COq2cbATthLsoc4VJd2lo1OAb9YeS+EcG8+Dusqys?=
 =?us-ascii?Q?UhOcdIjFy2L0S9thx+j30G8y04r016gkatQ++LOOnRikzTQJ7EvUOavDXBWa?=
 =?us-ascii?Q?QjAKlUaUnqmRxon69VDPu1dLGOC//915eR+/hWV5lBh2/+pUSnA6qtayduGD?=
 =?us-ascii?Q?uReFuEzA/qUeS06G65ejMHdD9m15e2p9kZv2hT1/ceWz1aoIVVDVfob2qRL3?=
 =?us-ascii?Q?obUEXQ/g8stGHe485mEuJafLsLJweSk0lZGGWkfMKHgfdnILcl9T0is1rHYJ?=
 =?us-ascii?Q?12I81ahXJA+8CJSmBZgfNZZOG97+cPGG1halkec2NgpBV/4baGzs9hUn9i2Y?=
 =?us-ascii?Q?oypa/lFfuD6SiBHzrMJM0xFqJ2F+dtQeiwg5DL4ZaBMR/etuualtaE6/9E3B?=
 =?us-ascii?Q?OIw0V+YSdQAzSvWQtJ+67IKHnnWsx4EJh1hZZkKTUuI5aATiV2sDYtZMo8gq?=
 =?us-ascii?Q?KdK818xojpko7cmwVMBGa4TIZ3D5nEWH7EkTR2mwaS5qZf6Tdgo7bhAaIATQ?=
 =?us-ascii?Q?d9Q9LIzG317WFjJXGbwv5ooXsXEn1fBebSQKsl59Q9FzPUAdQOCT7SdXk2T6?=
 =?us-ascii?Q?025xnHwqJT8t1kp6X9C+2a3p93N6FHqL2bL7K69LTsUncbpd6S973Zghg1mz?=
 =?us-ascii?Q?NMWW+4Fn2G5TGYz0J3mRO+K56YqGl8PlN3hFlvFOHTHU8Gg6tUKVLBLxd4YU?=
 =?us-ascii?Q?cowcvDA+KrApCV946H+M63uReOawvndfWmr0xj23JY2UdxBNWV6TJRVBrC43?=
 =?us-ascii?Q?DFLc1XnotOp2Ff/0z/yGbn2h+Er+i3L0e7pBjNGPNYR+bKDmEyKVM3xfOyXx?=
 =?us-ascii?Q?nNxgInhFDplBptL8PALUyufIYGWWQfzk34a3DxAvu0tqBOMZGeVTmxTkI98J?=
 =?us-ascii?Q?D7aL9z+wxLMdRqFBz0GR4lMwxzcUgVwxf12nQwxFFDxjUeYhE7iLjc6M2Zjf?=
 =?us-ascii?Q?ulHVD9WT/untiQY+jrnUQM9N2ThvMy11nyjYAiY2/gHDjUc+n7Ij3TvyiUVx?=
 =?us-ascii?Q?8aBMia1QI3k2juxfyuUiAp/txaPvPH7e4InfSsYxLK9MYdxD218A3ZdvdtQ0?=
 =?us-ascii?Q?xS4I24NMOd7VJPvo+v6f9+nQjJnqtXBQM6Cu3PV4QutQ3wk4J0vZXctjpTgl?=
 =?us-ascii?Q?wmQtx/SrMncz78bbNs+qgkdCDwJrFSbtjHIZCq2lVa5vSGJd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b06c24-772f-42ab-4644-08df4a55821e
X-MS-Exchange-CrossTenant-AuthSource: EAYPR12MB923140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 18:05:22.6993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0R/6Fv87FckFO2okEqDKV/GZJTr69Rn7wG7EkcHIV7Bbei1TdTAlPKtcgyViwS+52Tfx1/TJffEjk9oPzZTz1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8024

On Mon, Nov 23, 2026 at 05:38:59PM -0600, Bjorn Helgaas wrote:
> On Mon, Nov 23, 2026 at 11:50:50AM -0500, Yazen Ghannam wrote:
> > On Fri, Nov 20, 2026 at 06:12:02PM -0600, Bjorn Helgaas wrote:
> > > On Fri, Nov 20, 2026 at 04:13:07PM -0500, Yazen Ghannam wrote:
> > > > On Fri, Nov 20, 2026 at 12:10:43PM -0600, Bjorn Helgaas wrote:
> > > > > On Tue, Nov 10, 2026 at 03:56:12PM -0600, Yazen Ghannam wrote:
> > > > > > The correctable and nonfatal "_ratelimit_burst" attributes store
> > > > > > whatever kstrtoint() parses, so a negative value lands directly in
> > > > > > ratelimit_state.burst.
> > > > > > 
> > > > > > ___ratelimit() reads a negative burst as an uninitialized
> > > > > > ratelimit_state and gives a WARNing.
> > > > > > 
> > > > > > Clamp negative values to zero and document the clamping behavior.
> > > > > > ...
> > > > > 
> > > > > > Fixes: b4fe7398def6 ("PCI/AER: Add sysfs attributes for log ratelimits")
> > > > > > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > > > > > Closes: https://lore.kernel.org/linux-pci/20260714191826.BA81E1F000E9@smtp.kernel.org/
> > > > > > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > > > > > ---
> > > > > >  .../ABI/testing/sysfs-bus-pci-devices-aer     | 21 ++++++++++++-------
> > > > > >  drivers/pci/pcie/aer.c                        |  3 +++
> > > > > >  2 files changed, 17 insertions(+), 7 deletions(-)
> > > > > > 
> > > > > > diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> > > > > > index 5ed284523956..215cf8bd4c30 100644
> > > > > > --- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> > > > > > +++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> > > > > > @@ -130,9 +130,10 @@ What:		/sys/bus/pci/devices/<dev>/aer/correctable_ratelimit_interval_ms
> > > > > >  Date:		May 2025
> > > > > >  KernelVersion:	6.16.0
> > > > > >  Contact:	linux-pci@vger.kernel.org
> > > > > > -Description:	Writing 0 disables AER correctable error log ratelimiting.
> > > > > > -		Writing a positive value sets the ratelimit interval in ms.
> > > > > > -		Default is DEFAULT_RATELIMIT_INTERVAL (5000 ms).
> > > > > > +Description:	Writing 0, or any negative value, disables AER correctable
> > > > > > +		error log ratelimiting. Writing a positive value sets the
> > > > > > +		ratelimit interval in ms. Default is
> > > > > > +		DEFAULT_RATELIMIT_INTERVAL (5000 ms).
> > > > > >  
> > > > > >  What:		/sys/bus/pci/devices/<dev>/aer/correctable_ratelimit_burst
> > > > > >  Date:		May 2025
> > > > > > @@ -143,14 +144,17 @@ Description:	Ratelimit burst for correctable error logs. Writing a value
> > > > > >  		before ratelimiting. Reading gets the current ratelimit
> > > > > >  		burst. Default is DEFAULT_RATELIMIT_BURST (10).
> > > > > >  
> > > > > > +		Writing 0, or any negative value, suppresses all logs
> > > > > > +		unless the interval attribute is also 0.
> > > > > > +
> > > > > >  What:		/sys/bus/pci/devices/<dev>/aer/nonfatal_ratelimit_interval_ms
> > > > > >  Date:		May 2025
> > > > > >  KernelVersion:	6.16.0
> > > > > >  Contact:	linux-pci@vger.kernel.org
> > > > > > -Description:	Writing 0 disables AER non-fatal uncorrectable error log
> > > > > > -		ratelimiting. Writing a positive value sets the ratelimit
> > > > > > -		interval in ms. Default is DEFAULT_RATELIMIT_INTERVAL
> > > > > > -		(5000 ms).
> > > > > > +Description:	Writing 0, or any negative value, disables AER non-fatal
> > > > > > +		uncorrectable error log ratelimiting. Writing a positive
> > > > > > +		value sets the ratelimit interval in ms. Default is
> > > > > > +		DEFAULT_RATELIMIT_INTERVAL (5000 ms).
> > > > > >  
> > > > > >  What:		/sys/bus/pci/devices/<dev>/aer/nonfatal_ratelimit_burst
> > > > > >  Date:		May 2025
> > > > > > @@ -161,3 +165,6 @@ Description:	Ratelimit burst for non-fatal uncorrectable error logs.
> > > > > >  		allowed per interval before ratelimiting. Reading gets the
> > > > > >  		current ratelimit burst. Default is DEFAULT_RATELIMIT_BURST
> > > > > >  		(10).
> > > > > > +
> > > > > > +		Writing 0, or any negative value, suppresses all logs
> > > > > > +		unless the interval attribute is also 0.
> > > > > > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > > > > > index 6f2460231422..401cd3a1b3d0 100644
> > > > > > --- a/drivers/pci/pcie/aer.c
> > > > > > +++ b/drivers/pci/pcie/aer.c
> > > > > > @@ -752,6 +752,9 @@ const struct attribute_group aer_stats_attr_group = {
> > > > > >  		if (kstrtoint(buf, 0, &burst) < 0)			\
> > > > > >  			return -EINVAL;					\
> > > > > >  									\
> > > > > > +		if (burst < 0)						\
> > > > > > +			burst = 0;					\
> > > > > 
> > > > > Why don't we just return -EINVAL if the user writes a negative value
> > > > > to either *_ratelimit_interval_ms or *_ratelimit_burst?
> > > > > 
> > > > > I don't think there's any reasonable interpretation of negative
> > > > > values in either case.
> > > > 
> > > > Right, that's fair. I think the reason to clamp was to be consistent
> > > > with the current code.
> > > > 
> > > > Would you like a follow up patch?
> > > > 
> > > > > Any non-negative value for the interval makes sense (0 disables).
> > > > > 
> > > > > Any positive value makes sense for burst; I don't know what a 0 burst
> > > > > value could mean, so maybe that should be an error too?
> > > > 
> > > > "burst == 0" came from here:
> > > > 084a990ded63 ("ratelimit: Allow zero ->burst to disable ratelimiting")
> > > > 
> > > > IIUC, the goal is to **always** hide/disable the messages. IOW, keep
> > > > logging the errors internally based on the interval, but don't print any
> > > > kernel messages for them. The user can still get the error logs from the
> > > > trace event and leave the kernel buffer alone.
> > > 
> > > OK, so burst==0 should have the "usual" semantics (disable
> > > ratelimiting IIUC).
> > > 
> > > Can we make a replacement for this patch?
> > > 
> > >   - Return -EINVAL for negative values written to either
> > >     *_ratelimit_interval_ms or *_ratelimit_burst 
> > > 
> > >   - I think the existing *_ratelimit_interval_ms documentation would
> > >     be fine, no change required
> > > 
> > >   - *_ratelimit_burst documentation needs something, but I don't know
> > >     what.  084a990ded63 ("ratelimit: Allow zero ->burst to disable
> > >     ratelimiting") suggests that burst==0 disables ratelimiting, but 
> > >     you wrote "suppresses all logs", which sounds like the opposite of
> > >     disabling ratelimiting.
> > > 
> > >     Also, I don't know what "unless the interval attribute is also 0"
> > >     means.  What *does* happen when interval==0 and burst==0?
> > > 
> > > The pci/aer branch is mutable, so we can just replace the existing
> > > patch.
> > 
> > No, burst==0 is the extreme opposite of disable ratelimiting. It's
> > basically a mute button.
> > 
> > "Interval" takes precedences, so interval==0 means burst is "don't
> > care".
> > 
> > The three scenarios:
> > No ratelimiting (interval==0, burst==X) => show every message.
> > Ratelimiting (interval>0, burst>0) => show messages based on settings.
> > "Total" limiting (interval>0, burst==0) => *never* show messages.
> > 
> > I guess a user could tune the settings to get to certain level of
> > "quiet". But there isn't a way to 100% filter/hide the messages. The
> > burst==0 setting gives that option.
> > 
> > What do you think?
> 
> I think the patch below is great, but should be split into "reject
> negative burst" and "update documentation" patches since the negative
> part is trivial but the doc part is unrelated and will always be a
> little confusing.
> 
> It's more work than I think it should be to integrate "interval" and
> "burst," partly because the "interval" documentation refers to
> "ratelimiting" while "burst" refers to "messages."  And we mix "0" and
> "zero."  Maybe something like this?
> 
>   correctable_ratelimit_interval_ms
> 
>     Writing 0 disables ratelimiting and prints all messages,
>     regardless of burst.
> 
>   aer/correctable_ratelimit_burst
> 
>     Writing 0 never prints any messages (unless interval is also 0,
>     which prints all messages regardless of burst)
> 

Okay, np. I'll split this patch and send as a follow up set.

Thanks,
Yazen
