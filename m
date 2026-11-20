Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795209207;
	b=RYF+r47Bci/Zry6QGQj2aWmf0qtNit/LmjoxFxQC+VJVR/+VfxCOfRd/VpEgipFCTJcw
	 zp6hRB9Dn298iR4+yRnex2rxyWYdb4hsAzPIJmqbgNiiSr4i3AVgrF9vCP5IE54BNOzZZ
	 dKdTYJ0xCDqulFK5uZ2v9HyhR1C0Uj4S/hla0egNuQopY5Z9jL6PWbSJNG6V97l0FzSnR
	 o93NjdKCDZD1KV2CLz0l5TrzV7N00Dd1c9fKkqDRGIS61AEuFZe8nc3u4PRIeeCwLJrRe
	 uGDsCmT1FaAq1ZcpLA0T4jtbIFScFguFaYpEOWkj3vth1kb/H0jjrTglDEQiKQd0B8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795209207;
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
	bh=4KxiaQBBKZXs70pvugIoYke/+vryVVtGUSO/vYhVkyA=;
	b=BLhXBndNgruo6bLnWPO49ewgGSj1Z6qGEMj8xCX58b2ubSERn9d3qBpOKYhPBSQ6Ll1M
	 OytGPKNMwf3BJ1kd/KMb3n46DVFlDUyO4rCeb5aulfSTSnBIT2rN37rcPi1lO9304+9i9
	 s8wQPMHteN1Mqk29mJIkuJRevc4x1YT2VQyljC+OznI/5bqJdfa3qz4lC9Jc7VbdHrTX1
	 jO/3V/2SeuAZBRVUMdH95On1m9db0vcfNPNp9B1K3EcnQNbEzVfhjs0X1S2OaBNZUCa4W
	 foQ/yi735eGHzzFZ1uPPh33mReO1nr/zcfQWysXpdD5k253004qDOOrYnNGr39i6Qkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KixYsurB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.1
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011001.outbound.protection.outlook.com [52.101.52.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067EA606A69B;
	Fri, 20 Nov 2026 21:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 067EA606A69B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KixYsurB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/4Y8l+JQCzhMwkOVCZ/CktP7qVGvuuUsIWkAj6eUjgd+8PnmFSwJ6HXMS0fzGDFPPZ0xX2ieyj73ZQWccn1YLOeyEUJr5l03yARNsoZJH9gPSd4BRFOwCuD/CKpIty6P771NjdUNNfl1tsQTFeVE+lAAsNRCuGsPTnKxHneJRUwCkLo5GuvsGqVWwKXA3QzFvgLbV2ezGKv+EsaVn+qidmmaGh0jmpBR8sGMP0JwB7nDxFOlwhkEYoQi0qaFgY8NlEyamzFnOujadHwIUqBRekGU11M1dWKYmHefSj5AfEpBTFp00bFpwIi6zHZdljM4qjAlQHKRZXXL4z1AnQE+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KxiaQBBKZXs70pvugIoYke/+vryVVtGUSO/vYhVkyA=;
 b=m/YKeF9wHIJhPsQlVEeKpOc0BZYNWGpfcKIuohZXAPoVN8g0oikNmv0lHQNBjRg0zU5zo+iSKJ/vNOy3rZlOMksHFtJOQhN9emFmRGBp+/FaeN0tZYTTP/w9vEnG3yYZeSrkrP7avV/t27qshFoeb97r1hykuqkPQsIUUf1EVOmutMhc4Dw8GEE58rE+UWodBNYizvLXQlDq22knPOjOKQ/46tJ5ytZCKhWSzKZDTIt1cohAhPiLDsvrfQB8jYrtqAPL3krMobRTt6SACbWoDPxdUeeGwUa/VXg7w/8cW3qhtdIkFJ7VV9yjbPwaijC0X5gOA2pLBZpPoJHtU65Q3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KxiaQBBKZXs70pvugIoYke/+vryVVtGUSO/vYhVkyA=;
 b=KixYsurBbmVVdtG4vcheqK+iNpw/fF0VBXMLW5vx5ZHjvDpYeqxV7AkRSVRG3RAGyHTfvh6TU09uqhI6ejwAiPsvm5aNtrntXlb1C49cy+vLS8Sa1/w94gm8Ef6zAule/RMUq4GwObvljqzJLpMCCU54jjOtcmWKbNUPB7q7KRs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from EAYPR12MB923140.namprd12.prod.outlook.com
 (2603:10b6:303:2fd::15) by BL1PR12MB5730.namprd12.prod.outlook.com
 (2603:10b6:208:385::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 21:13:16 +0000
Received: from EAYPR12MB923140.namprd12.prod.outlook.com
 ([fe80::b986:8b81:beda:c167]) by EAYPR12MB923140.namprd12.prod.outlook.com
 ([fe80::b986:8b81:beda:c167%4]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 21:13:16 +0000
Date: Fri, 20 Nov 2026 16:13:07 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, Lukas Wunner <lukas@wunner.de>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Jon Pan-Doh <pandoh@google.com>
Subject: Re: [PATCH 2/4] PCI/AER: Clamp negative ratelimit burst to zero
Message-ID: <20261120211307.GA1524494@yaz-khff2.amd.com>
References: <20261110215614.3931232-3-yazen.ghannam@amd.com>
 <20261120181043.GA900258@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120181043.GA900258@bhelgaas>
X-ClientProxiedBy: BN0PR04CA0183.namprd04.prod.outlook.com
 (2603:10b6:408:e9::8) To EAYPR12MB923140.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: EAYPR12MB923140:EE_|BL1PR12MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: dba603ae-8169-4023-fd97-08df474b183b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|10067099003|261022105027099003|4143699003|260925021311599003|56012099006|260925022911599003|260925021911599003|11063799006|261009223027099003|261021121427099003|261021123027099003|261102123227099003|261026140227099003|261028144727099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rG1woPkD2RGYR26bpTfhW7z8zW10l4QbD4qVUCLlu+qViJKzaKQp5uaMX/B6H6fAOsZP5JqWtfHUsj98CHBoLCED39tTv6IFpyK1wP5dc9I51pea600D+/IRnr1LOQwCjb0c3ScnfNwiovmdHRfR2D31Kzgdy1n8sbo82EOmypOthUrZ3YT53TD/J4W8lfldsfEJI7XPIBieyGLGpPwCmX9/IoN0AkFs1fL4Fll2f3PFOILK5kn3UEjXxeyUHb+YlDD55q8e//owX5ERHgk9Mj2x+gPdoeUxItx7DoMeDNWCUc97ox/eRnRWYHTvN6RyPkpTaMDV8SB+IZ2NkXixJliL9q1yPjeY16tIKQPJJoxSea4NS9jRAaHHzgkBJiYw2BzB+g9w9cd4MWoUqbhKBFmAHR3O3aQJvxgmBOgkacoD9tignBwiU4DrB4OZLAYeJqZla1cMJi/URy5+xqqaGi5FnhD4tJ3n8SuzgEZW1jPkGP8N8eVy+AEk19B4ilpCzqXAHOkfaXXmaXNyvI46pjnRyj5zNZ68cAtzTl/H/QinNZOuovSdnKkz7eM//41hFOrERfgPi8kcEds7MwoTwDYk4x4fz9WPiWnDJ0jnVvZqHvrSshD8NuxvRoXNmcTp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:EAYPR12MB923140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(261022105027099003)(4143699003)(260925021311599003)(56012099006)(260925022911599003)(260925021911599003)(11063799006)(261009223027099003)(261021121427099003)(261021123027099003)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TsIDyp1xhm7sT+f9hRmLBxx7Nwqwh4p8KRavvI3CSOni46o2T66Rt++rhJgK?=
 =?us-ascii?Q?z1ZyzmMuiV5e3R0+TGprjWQFLX3ajvFqz1dqQSNBhnpF3cFF3vdYvw6A0mZG?=
 =?us-ascii?Q?dzWejct2/dybHdXIN3j/eFXiF5/xRWe61198WUqO6BvPdJuqxwJD1SuwX9RA?=
 =?us-ascii?Q?CVCSgtQz5G8SVAcTguZIqI/ZZlShZe0Lo5Xo4gMjqtg2/QS1g0HVFaLF5c41?=
 =?us-ascii?Q?fvkfJlhBDAnzLfrHAOZSogZ3H6pW+Gzjbg4THmyjWjpet717HTWO0E8s+t/j?=
 =?us-ascii?Q?l2aUvOXxKZyidies1vSwkXwjuHO0uAksvyrrCR2b2GRTFr6lwTr7lGLthlJV?=
 =?us-ascii?Q?GN8jdOzOCUfNTO48Hm2Zfv8bCDNepgZrWpuonTdJLOhKNEzASpEBPBeAxphb?=
 =?us-ascii?Q?aYQ3vZxVRirFxyJ9eL2pbNWMI5/8nIVimS/xqWa2QSIthYlupKrPWfeu2GIG?=
 =?us-ascii?Q?Lt1DilYStBL77V1qldU8TtsV5ZeoRYxnQaacGxNwzv8qp3g9QqU7nt4GsDSL?=
 =?us-ascii?Q?w4ZUOUq9Zu/8+0GrkFG/dm0mjuHsxixVuH4QOReqOBfzH9YFotrV+n997NR8?=
 =?us-ascii?Q?l5gLPUJ8ynpePDfPkbvx5zhMvYkGcL6Xm+SfWX5E10RkNC8h4vUYy95mWr5i?=
 =?us-ascii?Q?NynlJkHZLvQ3T5vPN6cr5FXB0+1nhxnlCqvdGZcruCoCVaRJGPAfhurH4KBI?=
 =?us-ascii?Q?krXcwc13MpCdc/ZDnrGWkTlI7p/WfbnUZP6+0ESn+qf+2v7VS1j6PWhAJ/LQ?=
 =?us-ascii?Q?tfnVU/9nfrQPCjcZujXw27Bg4zjb8S8TOIaCBeGB+DPYC+dKCBBuCc0ZmMHy?=
 =?us-ascii?Q?9lxuJF4sU8M21UKM9brnwzS5y2Vi8B2cJSyjzFu3pHTDZxKjq2pPq0+xJEbM?=
 =?us-ascii?Q?g0ow4xkVNiVu/6yQPRUF2mrg8iq9F6uTAfDX4+lcgTYePRlYyTtKeWigrjv5?=
 =?us-ascii?Q?mzi9o0jxTClrxKWG4mIv+72MBYsRBCTx+CEYq1pmJlt5Ti5KzZ5rdu5dHL4p?=
 =?us-ascii?Q?5GIbRgdgrE2fwM3q4nUZvl0g40VtG08zpD9MQ2xStw08adYZYkOw/uRnoJRl?=
 =?us-ascii?Q?Mwm0td1+Z4Bei/FEDY77xDXEXz594MEqMMBYim44dv9nnI/0W2rZH6NgA7VI?=
 =?us-ascii?Q?A+IBWeyGHewkDERx9mhghscQ5dvPFGR6rnA0JgKQGMlhpP9u1ALOen/CNGY8?=
 =?us-ascii?Q?9K2vvUgXBbL+kQWFZARWQxZ2vMNAXpv63pWc8KJjUEaYF0AqtLN1RzHzNvXf?=
 =?us-ascii?Q?nyaLYQV66QMa/E3GbPOXmBG1EztQoh8MEJvwtFx4nrtYX+e2JE/xl9cQK7DZ?=
 =?us-ascii?Q?q03kQzaIeuN575MFdke6m8N8ZOepzP64qw2yuaMRKGZ2g6SzoqWASGVQhjBV?=
 =?us-ascii?Q?VkZln6FxuN3aR1m2D1nqv6veQPx5yKe3pmmFCf/y2IlUnBR/ff5kY/TcYQIk?=
 =?us-ascii?Q?nDGOuVeSNYFKWL7iUPeQKU0S4CuWDypX1nkSvTcdk0kcHgBd3aD/7lD0E+pn?=
 =?us-ascii?Q?0PIbMzDND6NHvS/oyLYttyAW3eRa+MxmT1reVTQJZWMYzyhMsaKYjmXKi7Pd?=
 =?us-ascii?Q?fu6TYU2VWdYauYBezjdwyLVprQnXQZrV9nAYzleWW4K2MH1uOKviTlPHO8Ds?=
 =?us-ascii?Q?jMDjGk/frcGOGs54D0g4a9na4PDjc80CEUvMaGkXKaaSO1A2BBkb6Ss2FJX1?=
 =?us-ascii?Q?H3YxjZF+KUt3noS6ph0Ofm1vmouyunjr+q7FIuitD0r+jjCd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba603ae-8169-4023-fd97-08df474b183b
X-MS-Exchange-CrossTenant-AuthSource: EAYPR12MB923140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 21:13:16.5961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywDhzfdERLKblN42K774hKemTrGwLBACxLaMuYv68Ehb/gV6Q9U9h65u9sNSRCZ7ORdOXko/hFVOFcW6HyST7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5730

On Fri, Nov 20, 2026 at 12:10:43PM -0600, Bjorn Helgaas wrote:
> [+cc Lukas, Sathya, Jon]
> 
> On Tue, Nov 10, 2026 at 03:56:12PM -0600, Yazen Ghannam wrote:
> > The correctable and nonfatal "_ratelimit_burst" attributes store
> > whatever kstrtoint() parses, so a negative value lands directly in
> > ratelimit_state.burst.
> > 
> > ___ratelimit() reads a negative burst as an uninitialized
> > ratelimit_state and gives a WARNing.
> > 
> > Clamp negative values to zero and document the clamping behavior.
> > ...
> 
> > Fixes: b4fe7398def6 ("PCI/AER: Add sysfs attributes for log ratelimits")
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://lore.kernel.org/linux-pci/20260714191826.BA81E1F000E9@smtp.kernel.org/
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > ---
> >  .../ABI/testing/sysfs-bus-pci-devices-aer     | 21 ++++++++++++-------
> >  drivers/pci/pcie/aer.c                        |  3 +++
> >  2 files changed, 17 insertions(+), 7 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> > index 5ed284523956..215cf8bd4c30 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> > +++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> > @@ -130,9 +130,10 @@ What:		/sys/bus/pci/devices/<dev>/aer/correctable_ratelimit_interval_ms
> >  Date:		May 2025
> >  KernelVersion:	6.16.0
> >  Contact:	linux-pci@vger.kernel.org
> > -Description:	Writing 0 disables AER correctable error log ratelimiting.
> > -		Writing a positive value sets the ratelimit interval in ms.
> > -		Default is DEFAULT_RATELIMIT_INTERVAL (5000 ms).
> > +Description:	Writing 0, or any negative value, disables AER correctable
> > +		error log ratelimiting. Writing a positive value sets the
> > +		ratelimit interval in ms. Default is
> > +		DEFAULT_RATELIMIT_INTERVAL (5000 ms).
> >  
> >  What:		/sys/bus/pci/devices/<dev>/aer/correctable_ratelimit_burst
> >  Date:		May 2025
> > @@ -143,14 +144,17 @@ Description:	Ratelimit burst for correctable error logs. Writing a value
> >  		before ratelimiting. Reading gets the current ratelimit
> >  		burst. Default is DEFAULT_RATELIMIT_BURST (10).
> >  
> > +		Writing 0, or any negative value, suppresses all logs
> > +		unless the interval attribute is also 0.
> > +
> >  What:		/sys/bus/pci/devices/<dev>/aer/nonfatal_ratelimit_interval_ms
> >  Date:		May 2025
> >  KernelVersion:	6.16.0
> >  Contact:	linux-pci@vger.kernel.org
> > -Description:	Writing 0 disables AER non-fatal uncorrectable error log
> > -		ratelimiting. Writing a positive value sets the ratelimit
> > -		interval in ms. Default is DEFAULT_RATELIMIT_INTERVAL
> > -		(5000 ms).
> > +Description:	Writing 0, or any negative value, disables AER non-fatal
> > +		uncorrectable error log ratelimiting. Writing a positive
> > +		value sets the ratelimit interval in ms. Default is
> > +		DEFAULT_RATELIMIT_INTERVAL (5000 ms).
> >  
> >  What:		/sys/bus/pci/devices/<dev>/aer/nonfatal_ratelimit_burst
> >  Date:		May 2025
> > @@ -161,3 +165,6 @@ Description:	Ratelimit burst for non-fatal uncorrectable error logs.
> >  		allowed per interval before ratelimiting. Reading gets the
> >  		current ratelimit burst. Default is DEFAULT_RATELIMIT_BURST
> >  		(10).
> > +
> > +		Writing 0, or any negative value, suppresses all logs
> > +		unless the interval attribute is also 0.
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index 6f2460231422..401cd3a1b3d0 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -752,6 +752,9 @@ const struct attribute_group aer_stats_attr_group = {
> >  		if (kstrtoint(buf, 0, &burst) < 0)			\
> >  			return -EINVAL;					\
> >  									\
> > +		if (burst < 0)						\
> > +			burst = 0;					\
> 
> Why don't we just return -EINVAL if the user writes a negative value
> to either *_ratelimit_interval_ms or *_ratelimit_burst?
> 
> I don't think there's any reasonable interpretation of negative
> values in either case.
> 

Right, that's fair. I think the reason to clamp was to be consistent
with the current code.

Would you like a follow up patch?

> Any non-negative value for the interval makes sense (0 disables).
> 
> Any positive value makes sense for burst; I don't know what a 0 burst
> value could mean, so maybe that should be an error too?
> 

"burst == 0" came from here:
084a990ded63 ("ratelimit: Allow zero ->burst to disable ratelimiting")

IIUC, the goal is to **always** hide/disable the messages. IOW, keep
logging the errors internally based on the interval, but don't print any
kernel messages for them. The user can still get the error logs from the
trace event and leave the kernel buffer alone.

Thanks,
Yazen

