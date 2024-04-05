Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2111.outbound.protection.outlook.com [40.107.244.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4960013A265;
	Fri,  5 Apr 2024 12:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320013; cv=fail; b=gKKDy3epApRCI2irEkYxp+H0rTU/kDb06A/nXYHl5EqrUONWX+v+oCV2QTG63lDwI8ja4tX+a6WNi4cAqZGV1kQX6knm2/IHGkKcqC+Rkaw/SuQUMjOgToDsCA+m6MN+7NYBamTxdTvjEtRNZPjjJlujBLRZZUU9cuWey6LuplE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320013; c=relaxed/simple;
	bh=jFNo1EimX1/H8fQ77ZwGSxyTySkbcMg4tJqnSziyhgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HMYzSF3q5wusA8MOXa/1Y222Ah8Am71I+Owdq7a2SbEUImVJt+vnNTnGM3Uf5idTZg0tTw9yRoUMjPMA6OayP/5ycB69KRBaDykKDYuu+Zoze04pDiOgBZ25ggqkaIwg/Q4K3YSfrwheNZ5UIXKxyOYx+wyozrDE1gYIKeDT+rU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sOPDBchf; arc=fail smtp.client-ip=40.107.244.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sOPDBchf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leRL43DRIoUbz7/HhcigfutT4//ZxQOKgeNxT+VvYQNhCs54OE3b6SmWiXGd5cFLn77tojjFstKQVHImzFcAj6yP4zRCVs4i4og3YwpDFnmeePmlHfk5T7rKBd0gYlACuUaZPRZHafc4CS56tugSzqWdFzjg9jptXYlcveZMjYqplds/yr5tRD3dIedGGVzmGpnA21g2OFpwOWmKQ4J81k1+Z88aj7rTpQ7PVjb3deDDBgYAJJBu6ynqZS45SVjAT8SIAWgzfNLXOUiiSDxWdZF0m+AM8omPcESw357sSTJrsG09lQOSdk0H0u++tYav3TPv57ZPxBUW1hm9jbKSXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tA+NsjcRahzf1BXehG4Lp4fBIwRKd8Af3/diB9e5oqE=;
 b=k2UTc8M9gBsUnExHzHnBsTdtwCgSLT1HMFR5byBUDxrk2WH1NZzqqAc42juakIpYw6juA+DuTaEKEojTWFyNbqJZKWI0PSThd3Yn5PRCdfzUEM92a0oYgmaJBhId/jqZ0lTkAZJrH7Fmj8BD+RJQtDDl3DA+ZDizrmMWpsZRCDFa1KvUJGpHobA1ISIbeiOlg93wujOskfF2NQFa9z9WQ2KhqZoLkLxAXVjJYDbkT2M4xO1gV2AR0/oMiL3DY5T2Y/sJlZ9ZGwKmC0u7gyfL3z4LNHT+Nxl4Mz5qi4EcDew/M3OKFCl4nP7SYxS+uPgtRM6J8kmChBrCiy4JyEbLvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tA+NsjcRahzf1BXehG4Lp4fBIwRKd8Af3/diB9e5oqE=;
 b=sOPDBchfJ89E2Wx2Dk2RiQ5vu5NaSUlOjFGdn01KU7JYXhIGMTDEd+O9LBkdVnOQMYSgUcm+Qwizdml4A0cXfpa4M+Kd+3Q+/C3A4dAp/ZH0Jo2gNpHFWCvYzpPa7uY/eTTDCqr4xmAm5+fIC6mu8BmqiaqrBwinZKlcV2B4Qi5Tpz4F/roVcxcMpK9E9xLeqD/GpSOB/Wky1ETBKQH75d1wa/WBH4dhE89chmMkGjD4GuO2pdHaLFkbAlZhlBYgOTtVfXMxsb3D+dzwLzioG1ebm33+yn8gp3VhF/Wbdy1y2bi5mQDtkuzP7I98BhYfDUU5VnF9SBF+ZHpuoVZV9w==
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by LV2PR12MB5822.namprd12.prod.outlook.com (2603:10b6:408:179::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Fri, 5 Apr
 2024 12:26:48 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 12:26:48 +0000
Date: Fri, 5 Apr 2024 09:26:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <20240405122646.GA166551@nvidia.com>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <Zg6Q8Re0TlkDkrkr@nanopsycho>
 <CAKgT0Uf8sJK-x2nZqVBqMkDLvgM2P=UHZRfXBtfy=hv7T_B=TA@mail.gmail.com>
 <Zg7JDL2WOaIf3dxI@nanopsycho>
 <CAKgT0Ufgm9-znbnxg3M3wQ-A13W5JDaJJL0yXy3_QaEacw9ykQ@mail.gmail.com>
 <20240404132548.3229f6c8@kernel.org>
 <660f22c56a0a2_442282088b@john.notmuch>
 <20240404165000.47ce17e6@kernel.org>
 <CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
 <678f49b06a06d4f6b5d8ee37ad1f4de804c7751d.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <678f49b06a06d4f6b5d8ee37ad1f4de804c7751d.camel@redhat.com>
X-ClientProxiedBy: BLAPR03CA0044.namprd03.prod.outlook.com
 (2603:10b6:208:32d::19) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|LV2PR12MB5822:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c03anaC0HXoFwsOFBWVxY/zNjIYxDhNiM0BC/9PYwQasmT3IF9zYlBh/Crh8RTnl1vd8spceXQ7exnkZrbjpgcQkCgixaeV8SAEPCBaMLYcvBEzuNMMkuwctl9d20Jcjiv8Jz2oBuTWooPh3MbZ8LRc1G5TVFdNRNPj7pRAMf+GrOvkX0eL/BRh+p94BdnmWftJ5VL1CZ8hR5SMp/S0LitNGPkwP47phz1lIaxMJUzxsrPGwzrrd156HoGnd2owVNSjOjO3EJfp9wdv5IVVcoL0+RgOFE1qAwHqnDyF0cLQaB3U2Yxw0GoFjlsAWIsO4BSt753wi6LitW80B9nZX71D1GHKcX0SlDfB8ekek5fSR5wJbkwTrD+1Kiy9/EwFRzsPfb7t+DtO1WqJJolBXawTbDoIp32Jn40aJO21vpcmiOP1pP2ExC6pag+WEsvDZhU8XOGnGCM57NzlLzJLhxfP3WKBEAI6N6PTZWLhsjBAiMrYh6HnUiaOLFZ057yzf7DGxX5+dz+ungoIVoSmZzgAMcwC/DbaB0b30UXuZ/2gC+3oz+0xlm2yYIZ1vrnc64J2miEVmCS8xI/+bbrbqnkA+DMCzRt3+znOOkmJmZgevSehg/kHutU1LoAYY3k/XzO22F9YbSIcRpfKC6D+mlRhw3IGcshzCRz+0oF6CajY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YU5zUytVU1VpREw4dnF2UThuREphM3U0THg2VTV2VWR5UUhmSkQ4alR3bHg2?=
 =?utf-8?B?N25qcm5HRVRKREllVkF0VXFucEFZWTJyclNUVUhYTFZFRmNMQWVtREswMmVk?=
 =?utf-8?B?eGJKV2lON1IvTzl4ODJLZjJGTFYyOFNTeFJQUlZBMjNKczY4d1VTR0EvVU52?=
 =?utf-8?B?VDArYi9lS0xlZVBzWlNjKzJNd1BZNzZJUjJINXFJcFY1THFveU5oS1hkOThz?=
 =?utf-8?B?RzZqZmw0RW5iemJmNGFMbHcvWU9DemVNV0NZSXpxSm9rVDVNVHl2UHV2SDF1?=
 =?utf-8?B?ZFNmRHJKY2pGR2NFVzFsanhRWis2Zk1jdzZaS1BOMXJCcW8vVkJ4SE9aVDUv?=
 =?utf-8?B?eExLb2gxZjVtT1RhUHhrRzlyYW9lUitLY1NjMHhvVnV2dmlzeGZrckRiSTBG?=
 =?utf-8?B?dVk2Y3paSGEyR1k5c2tPd3NCbDV4MHpwaTQ1OEx3VW1wRXZyN3dlcGpjZ1gw?=
 =?utf-8?B?ZTQwdWx5ajhDRXh0M3ZMbTE2MWp3KzZkaHdwZWJwZWRuWEFBbGRQV0xXaXQw?=
 =?utf-8?B?R2pHT2taQ1RnR2RsUU13K0hxZjVCbzZRYWpPbC8zK09SMG5jMEpPWFllMmR0?=
 =?utf-8?B?dUhKOEMrcEltbDl0eWFNNngzOHlhMkVGRnRwWmdGQTdoQk1KcEtlL2tIN244?=
 =?utf-8?B?N3ExTTBEcE1YL2h5L0ppaFN1ZDEzMnZDaitLbWdkZTJVR0hUemQzUjRlcHZW?=
 =?utf-8?B?bGRqYWZKUjN2Y1VBS1ZZSEM5aWR1M3ZQOTRKY3RyV3BjWGFoTXhYclRzck5i?=
 =?utf-8?B?bXNnZWtSd01QdzB6UzNSRmxYMUcrU0xXbDNFSFRpdlVSd3FCTmdKaTlBbzgy?=
 =?utf-8?B?cFRZWGZhSDB4TDJDYXU5S3RwRVY1ZlNjZ0FLTGRmcWRIWVRyd2EwSTdvcU5v?=
 =?utf-8?B?RmpwTkNxMmZkUFlVYWtHdFh3NGsyTFFCUmtCS0dzRmF3M29FOW9VNTFXWGxm?=
 =?utf-8?B?bHlrdHJFd29PZVRWQzZTWWYwVVVNc01zWVMyWEMvWkdycHBzVTNxNXpkOGxJ?=
 =?utf-8?B?c1F1VHEyUlVvU00rZ2c1TGNPTUtrc2FIdFBtZVVXOHB3UXVmRmwrSFBFbGZm?=
 =?utf-8?B?V3NJVG82dWFjSm9DU2kxdUd3VHdzNHZHbnhrSERMMS8xUFRpU0xlWEp5ejdK?=
 =?utf-8?B?L0ZQcDY1Wk9EdW53ZGpCaGE0Z0ExS21tSy9YY3lrTzBMMmZQcmNQeUdaVnBa?=
 =?utf-8?B?dTZlOWM3Ynpld1VMM0hYMFhIS0JNZ1o0R002ZXZ0eGdVdFBzdXA5ZEJ5b0FR?=
 =?utf-8?B?M211OUdLMHc1UEMwVzBxZk4xbkpvMjJnT1FTZ3hzQlA0MmpTcEhqZkx0VHN0?=
 =?utf-8?B?SFErWmRRbnJOM2J4NFVnWEFHWjV0dGRKTnFMOFVvQlZYaFRuZ0JWTWJxRXhh?=
 =?utf-8?B?cnN1UkU2SE5QTmo2SzdmT0NLTzRWRzVhTC8zTVNuS1VkemxoUEtlT09yRjdD?=
 =?utf-8?B?cENtMEkvaG10OHlSZGtRWnFYTTMyOFZqNm9MRFhMbjhyR0JqUmcwemNoY0Vv?=
 =?utf-8?B?VlhRSkZSWitmK1Jnc0p1S2ZNZnFtQkRPS3lEdWFWM0V2M0VYUGVpczA4Zllp?=
 =?utf-8?B?VVhDV0wrRFhxNmFhYndVQkhNV3NRNWQxdk5vWE9mRERVOGlFU0xrclJnL2x6?=
 =?utf-8?B?bTNlbGFkSjB0elhiVFA4STJQVTdmejlIYzF4R0U2Z2NnR1lteXgwanIyVVlR?=
 =?utf-8?B?S3l1MVpCMmk5NTR0bHVFSDFaS1d4TTFSREE5cHZDMFA1cUNnaXdkbzcveDk1?=
 =?utf-8?B?T1gxY1JTUmpTKzZENHVvNzZQMTVWLzZpNUtMTFlWbW1PRmJIVlVtYTdIdWtq?=
 =?utf-8?B?a1V4ak9RM3pGVVRRK1Vyd2RKck5peFNRVlUrTXpIWVBRUWNzaldsM0NDcEht?=
 =?utf-8?B?aG82aEZ2VVNPUWxZVENidVVqbkNPUzdKSnZqc0I3OXZobkV4MXhxZjhHZ0hR?=
 =?utf-8?B?Q3VEUG1CT2VkM3h3UlNrdUk0MUpOUzRIUmkrUTRLWHUrWHRMY0c4ZzByamM4?=
 =?utf-8?B?K1AzOEQ2S1hhN1JZNk1GYW5URVJQL1hyUXFqOWtSNDI5bk5kd3BkSldWTWtm?=
 =?utf-8?B?ayt6TTlaVXI1SVVQZExVTFVEYXBMWkh4SFM0Y0lIZFQvVU5RK3BTYlRkNHJm?=
 =?utf-8?Q?fetLzWZn+XrHyx8Jo7aWUCRYE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c5385f-1dab-4251-c291-08dc556ba99e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 12:26:47.9672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCa5Xujd+Mo8j/n+vqeSN/Be1omalOcJRZ9baLVaJj2mffh3NADyglhHajn1DwIT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5822

On Fri, Apr 05, 2024 at 09:11:19AM +0200, Paolo Abeni wrote:
> On Thu, 2024-04-04 at 17:11 -0700, Alexander Duyck wrote:
> > Again, I would say we look at the blast radius. That is how we should
> > be measuring any change. At this point the driver is self contained
> > into /drivers/net/ethernet/meta/fbnic/. It isn't exporting anything
> > outside that directory, and it can be switched off via Kconfig.
> 
> I personally think this is the most relevant point. This is just a new
> NIC driver, completely self-encapsulated. I quickly glanced over the
> code and it looks like it's not doing anything obviously bad. It really
> looks like an usual, legit, NIC driver.

This is completely true, and as I've said many times the kernel as a
project is substantially about supporting the HW that people actually
build. There is no reason not to merge yet another basic netdev
driver.

However, there is also a pretty strong red line in Linux where people
belive, with strong conviction, that kernel code should not be merged
only to support a propriety userspace. This submission is clearly
bluring that line. This driver will only run in Meta's proprietary
kernel fork on servers running Meta's propriety userspace.

At this point perhaps it is OK, a basic NIC driver is not really an
issue, but Jiri is also very correct to point out that this is heading
in a very concerning direction.

Alex already indicated new features are coming, changes to the core
code will be proposed. How should those be evaluated? Hypothetically
should fbnic be allowed to be the first implementation of something
invasive like Mina's DMABUF work? Google published an open userspace
for NCCL that people can (in theory at least) actually run. Meta would
not be able to do that. I would say that clearly crosses the line and
should not be accepted.

So I think there should be an expectation that technicaly sound things
Meta may propose must not be accepted because they cross the
ideological red line into enabling only proprietary software.

To me it sets up a fairly common anti-pattern where a vendor starts
out with good intentions, reaches community pushback and falls back to
their downstream fork. Once forking occurs it becomes self-reinforcing
as built up infrastructure like tests and CI will only run correctly
on the fork and the fork grows. Then eventually the upstream code is
abandoned. This has happened many times before in Linux..

IMHO from a community perspective I feel like we should expect Meta to
fail and end up with a fork. The community should warn them. However
if they really want to try anyhow then I'm not sure it would be
appropriate to stop them at this point. Meta will just end up being a
"bad vendor".

I think the best thing the netdev community could do is come up with
some more clear guidelines what Meta could use fbnic to justify and
what would be rejected (ideologically) and Meta can decide on their
own if they want to continue.

Jason
