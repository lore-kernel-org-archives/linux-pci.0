Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2114.outbound.protection.outlook.com [40.107.93.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F6216F851;
	Fri,  5 Apr 2024 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330233; cv=fail; b=elJF8ljm0iFFVK4SdvIBA1wa4ygO7Vq58jw5QbXyRssbHci7t7B2vkWgyGn0oH3L+Eju22ffAIx9P3THO9ktaWj4FUPBwwVT8pqJNcNVd2Lkb1bmmtWSwvWGJi8CE65eoDta2XFFzxhQG8j7DmGlATeHjI79XH+i6gtMLNQxsks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330233; c=relaxed/simple;
	bh=3PT0L7167N22bxCp/ksiJz4XNO0BZ4QsxM0jYUprRV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JqHgS77EDydgS9JTBV8jet5mAbzoh5+i0YBUrVo9bJYzTlQemo5ljaFvq/7y5S5lJz/3zQDQw0gQQPOunL9Qxwf2uf8OReVNsvzznxgzSOJgb42s9JcN3xL02YTRa7DV+BgKLAgw7YatsR73VpWFoHEPzPpToQLXL9XOl4xVKWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pc1lI60x; arc=fail smtp.client-ip=40.107.93.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pc1lI60x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2SFrBphLZoTLm5UiDmSNiR4AL7cCSNVt99AKm+P+9ErGVEXDxT1W9KQjCTOZAbU9nIwivbC4UaOavDbYbeyxhi5Vi12sfsELbc2NE/eTRDMR0bkHHG9uPz5QG/P+ty0/2mCwTCWEYoT5sSOkmRE3X1w0xfJIaX2cGhlcGmZBYmcjND/sjkJnCmcdZFhe4dksnHwJX9ZBhvSnB/sTTIG12/S6DEf+NQOmSqN9LnZm1zRW/yK6VbgNozExa6NCrjw7BDJD5unfb4RLGZ+Fl6g2Ee3OV8Bm9CITZSMa4HgrUABWlZbWb/au/9kEHU+XvJVmD1y73gRz0eIolvWm0w+nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ixe/Q3lLADMG2i+kqNp/sIa2knlnV15zFvGQoi7X0+E=;
 b=XoskZ4HWXGN3zVh3Zbed+VGr0K3Fbo46x8UgYIqaoIB1b8PbtC2ezwnDnkERW817HZmYMr1FRDtXullH4mD+RoiHo/NRa0Sjos9IRugKITC2JmDlpNp0qGJsbZHE7KMEcsBrU9pzfgixWVVwbiWC+q4EQyCf3JIpxEqU/ODb97LxFs2Eufth9m4azvtv5dNBSO5zi1IDqYAlqNx7A8QS/M52Wf/x9Kv0fCEwX7JBwPUrWAK1hHMZqfjAgYAOBRREE6fjdGz87ZrbMVBhW6euPf0ei164ipZdhAej/ZVFJ+Jc6Rlo0OZ94z29CULAGQTREce4XNqg14hkujXlyEr6QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ixe/Q3lLADMG2i+kqNp/sIa2knlnV15zFvGQoi7X0+E=;
 b=pc1lI60xdkpa5H4plppB5ndinDH+9jKl/1AVWXCWY43cbfjsxzRgzX/bsmDZKRZcGPH4PDwUagPxwTuUa/rFLLLVTFdmytWswcYfZTFMLSx5CZ/PauY9JYjWG9399uAszN8TObTAXmLBxFEp9vEm7O/REydDFZ7YGYd5Wz2WbliDfnj0XaCPh/gR2+5iO8I9gIfF6uxMVEr7MgzWc1fFQVSNZdsh30/t8YU87H9Ge/4TNTfg0FW30kKe0nmgDMysDN/b47mUXVXKJMqkkbT2gsA4DHUdFRbolByBRB3FC9NCmo5t/jRnFYn4ouwCW+P7BLDVamj8RnXJThQOVmjv5w==
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by IA1PR12MB6457.namprd12.prod.outlook.com (2603:10b6:208:3ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 15:17:05 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 15:17:05 +0000
Date: Fri, 5 Apr 2024 12:17:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <20240405151703.GF5383@nvidia.com>
References: <CAKgT0Uf8sJK-x2nZqVBqMkDLvgM2P=UHZRfXBtfy=hv7T_B=TA@mail.gmail.com>
 <Zg7JDL2WOaIf3dxI@nanopsycho>
 <CAKgT0Ufgm9-znbnxg3M3wQ-A13W5JDaJJL0yXy3_QaEacw9ykQ@mail.gmail.com>
 <20240404132548.3229f6c8@kernel.org>
 <660f22c56a0a2_442282088b@john.notmuch>
 <20240404165000.47ce17e6@kernel.org>
 <CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
 <678f49b06a06d4f6b5d8ee37ad1f4de804c7751d.camel@redhat.com>
 <20240405122646.GA166551@nvidia.com>
 <CAKgT0UeBCBfeq5TxTjND6G_S=CWYZsArxQxVb-2paK_smfcn2w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UeBCBfeq5TxTjND6G_S=CWYZsArxQxVb-2paK_smfcn2w@mail.gmail.com>
X-ClientProxiedBy: BL0PR01CA0002.prod.exchangelabs.com (2603:10b6:208:71::15)
 To DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|IA1PR12MB6457:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JZCHQC+gG/Ytha80Js8p6eeZnTKhqMLe2AvxF1FHQpH+dWIz3qzid5v/XbvYOjqHiNHZjkOtJN9c4ID3V5T3N4X7p7PGVSWo53Am2hw84XQTWsoDBXTOLjG2skcd3SdihcvhWBUamAX7QeePX59C2OzxeuelFFyVLGR5BLeO7TiU9OSybggWImb/WUrkeNu/oIm0RxT6tiKMX1iHpf3W5/RKDdNOrW+Lmbp7BSBI6CWGkVZVcwFtuc4bHgk1YgeRP6IRkTgs2to1cdhrY8BMKPEVea3TTmU1jdfLYbsWN59nvFcmXMBdxz18OdnEeZuSNDfTSgeKJxsrzFTa8wBRBPpyVMBEFtYXKUm9Q4i8+ORdGpsDzrvxvEZSpw9OBxRP2y/teQX5oK97BC4ET3CEHlGBSBY3q9fRex+9+4xGf+lT8avfByZvqKv0UwzzBWJP1ELhnKuu3U9GpeiFuknIKxoYcaPczdcC+LL+eTlBP4aYCw/fPGe917LEEIgqCDgzj74NNWUmCDfu3PHvIsXR7pd5BloEfU0cSZ3iJEGENFPYYk49kCcEK5pD/munwtfbnOv+1ncr2IgM+c2Tyrf805HoeGGtFS3h/MyjTyEsdyMlThvi/dNCB5MwZJ9Kw1nO0R0kfsSHPqo46rrGyoxru2naqHcplvPMG5ZyWKG6IjM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GmLEGj+qQPBb8FljhGOfBIi8rEuq4GJsL7rEFzFZeA/j9UJqIfNXdQYw4Iaz?=
 =?us-ascii?Q?ds+J6r6/yitMfpLsa04KGjMRJpLOXjDx9IpyJ8KiYs5nWlZAUvfvW3zw7qXg?=
 =?us-ascii?Q?wEypB1T5BjhR9OzPtqHCk7GMH6EBzHcOpxtBXLgFbx7dP+Oup9mLSv2lCj9E?=
 =?us-ascii?Q?3aaESMWLblIWLZM/xAVFrQfmJhaCANygKavLpB8J1SYIH+muqS7pu8Ir/YcE?=
 =?us-ascii?Q?HhZedY0hJs0pMc56XT2X26b/S/RiLnmPGE58uICa7WZGtFaRDqmbBKtdeDhE?=
 =?us-ascii?Q?TPu1Ec0VGPu7Sy9Lq2DKHs5+/LYEPazzKF1E6DCFcE7ID1eiN3abU6pDItWd?=
 =?us-ascii?Q?o+QFy04Arx3xhDL50L8czQUDX1LKiE6P5yDZrBxkOsvufEdIJEJmmWDs6SeN?=
 =?us-ascii?Q?vvEoLXck3quTKYKKpi4Ft98NAQ7o7MWJk/yfgUFEu1udva4hJ3prOrFQK5IR?=
 =?us-ascii?Q?8MBSwaG7qFGNGMHAfygB20YvCMZ9vTe//+49f+IO9EcCsri/WRCtPo4Jhuax?=
 =?us-ascii?Q?hmRSSdPPPWj/z21Em597vA8klJkbDo8hMYJti3amLUT2VQWtgd/0OiUQdc5t?=
 =?us-ascii?Q?rlkDfiL22AISbbXYTwhspKaoI9UDnMJ2aCcvi2VlBVrZM6h9eUvzv7NdNdAj?=
 =?us-ascii?Q?dsnufENkDFu/u8F60xdHW3cE7LcxJpMGHYM2rOrPR1twbSh7Wh1lnCbpX6yC?=
 =?us-ascii?Q?NzIEenT9cituGBcJJAfGF+GayJK00AAaNoRGHsLwuI/7MmV8Fv4hWdWmgpPi?=
 =?us-ascii?Q?unmSHhIDkDeBbqGlG7QuVLR7MQYE/XktjDCg8p1pwEKYdMmjxBIuUMuZTnkE?=
 =?us-ascii?Q?wSPZVVzA1+ZiuSpeh/jz3gUtHO9jaEgk8Lf3irBjJ36XYv+3pOhwStzvlupj?=
 =?us-ascii?Q?XSwEbTDFrgsVugt+FcjxU33bTsEw8x4JYKk/4J+470ZncA57enCKp82KBcjd?=
 =?us-ascii?Q?C4OY4x+SXdyCCMvanIR3Gt+wl36WJ8bwQTYXQg3zHGSaITXz0iKwiPJz8Omd?=
 =?us-ascii?Q?QYLLSiwcXYayMeh0IGjJcjW88jUkwP3hfMaFD/l/41BxeDeVGdjQk5i8N8/2?=
 =?us-ascii?Q?+ySzRXhYp7lYdOoYNnAbJKlLH1/81KNzcLDiKMNzyLPIZMpxnwomCZ7TJ833?=
 =?us-ascii?Q?6a8cU5pEwMgADJKGVYr2kpPIZY+8zFzRFRDYTdrNER+7bNn+CVDdFZbw3NzX?=
 =?us-ascii?Q?P+pHn6B1MNVdh1vfcSRxCCTfagmNEPIq+WyYrIKnjRYkK9RK2PhmQZHty8V8?=
 =?us-ascii?Q?jca5/2r/0Rd7B61ZaqWifeGrBuk8NJwImcp7ownSoq5V6GXKR57zUA5d4JdS?=
 =?us-ascii?Q?8i7j2gQekU01w7bUnyGOVDwY9/91PjrKRGr/l3CIP+E+rBojyOR2vw6NeAbf?=
 =?us-ascii?Q?OF/UOAvTktN9YesNOG2t3L6c3z/tf1XmR8QImrdp7J8hnc2Y4EaL6wEQuMP2?=
 =?us-ascii?Q?LkmDNryQPj1L2DL16We5SFgaTud1M7glsZjW+7ltgJ6azk3MITR86fp22CWV?=
 =?us-ascii?Q?xapAMhBoHJ53nvg5pTSSqaQiFknMpSNoWhMvtFPSOO0MV7iIFBa9RVM+MPt5?=
 =?us-ascii?Q?8tdYlNttzAs/3mIPuxjdgIlTqiCiF5WlvLW82uPm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbdc2248-20e0-4d54-ea1c-08dc558373d8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 15:17:05.3926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YHf6wEQZlQjU9TOw4vafSRwVMzlgycrq+hFQ6H9uKswi2EfzctLiqpXfk0FtppPB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6457

On Fri, Apr 05, 2024 at 07:24:32AM -0700, Alexander Duyck wrote:
> > Alex already indicated new features are coming, changes to the core
> > code will be proposed. How should those be evaluated? Hypothetically
> > should fbnic be allowed to be the first implementation of something
> > invasive like Mina's DMABUF work? Google published an open userspace
> > for NCCL that people can (in theory at least) actually run. Meta would
> > not be able to do that. I would say that clearly crosses the line and
> > should not be accepted.
> 
> Why not? Just because we are not commercially selling it doesn't mean
> we couldn't look at other solutions such as QEMU. If we were to
> provide a github repo with an emulation of the NIC would that be
> enough to satisfy the "commercial" requirement?

My test is not "commercial", it is enabling open source ecosystem vs
benefiting only proprietary software.

In my hypothetical you'd need to do something like open source Meta's
implementation of the AI networking that the DMABUF patches enable,
and even then since nobody could run it at performance the thing is
pretty questionable.

IMHO publishing a qemu chip emulator would not advance the open source
ecosystem around building a DMABUF AI networking scheme.

> > So I think there should be an expectation that technically sound things
> > Meta may propose must not be accepted because they cross the
> > ideological red line into enabling only proprietary software.
> 
> That is a faulty argument. That is like saying we should kick out the
> nouveu driver out of Linux just because it supports Nvidia graphics
> cards that happen to also have a proprietary out-of-tree driver out
> there,

Huh? nouveau supports a fully open source mesa graphics stack in
Linux. How is that remotely similar to what I said? No issue.

> or maybe we need to kick all the Intel NIC drivers out for
> DPDK? 

DPDK is fully open source, again no issue.

You pointed at two things that I would consider to be exemplar open
source projects and said their existance somehow means we should be
purging drivers from the kernel???

I really don't understand what you are trying to say at all.

The kernel standard is that good quality open source *does* exist, we
tend to not care what proprietary things people create beyond that.

> I can't think of many NIC vendors that don't have their own
> out-of-tree drivers floating around with their own kernel bypass
> solutions to support proprietary software.

Most of those are also open source, and we can't say much about what
people do out of tree, obviously.

> I agree. We need a consistent set of standards. I just strongly
> believe commercial availability shouldn't be one of them.

I never said commercial availability. I talked about open source vs
proprietary userspace. This is very standard kernel stuff.

You have an unavailable NIC, so we know it is only ever operated with
Meta's proprietary kernel fork, supporting Meta's proprietary
userspace software. Where exactly is the open source?

Why should someone working to improve only their proprietary
environment be welcomed in the same way as someone working to improve
the open source ecosystem? That has never been the kernel communities
position.

If you want to propose things to the kernel that can only be
meaningfully used by your proprietary software then you should not
expect to succeed. No one should be surprised to hear this.

Jason
