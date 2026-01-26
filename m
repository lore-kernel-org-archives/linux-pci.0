Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011064.outbound.protection.outlook.com [40.93.194.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD1C239E7F;
	Mon, 26 Jan 2026 18:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769450510; cv=fail; b=qRhsS4AsK5MVqvx2BzidUIVcSQ5OFDha0kI4pceQ7P5SCOoiHMrZc/U4JX0sIYtRIREPd3/5A18xMLoAanRHaZA9dgXoNYKqAvu5pExA2agh6x8F3vdycJP1ZWVvRApJIY6MPqWEUpzd8WqJtocACFHRaWg/T6AovVwEEOnZ4Zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769450510; c=relaxed/simple;
	bh=GZkxoeYopegK0ROYGRwQcRJ0+DZaJrGWXjdnUxV1m8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hygy0mEzw8ycsZFaOEISL9RfzWbWJBUPuueiIbE3JQyBh0rVK8Faopz60pXVT95B/DEuZqKiVbPByXLWjUZ9s2K7tV5pucPUQee24+ufBPQzr/BLrWXgN93xD1xWkPyy12PVk8nEPUw56Fsm+6V5u2/B9YNjcDdelCn3Tjoeb4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AmjsJloN; arc=fail smtp.client-ip=40.93.194.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AmjsJloN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1rzppfV4BXd4+AfbRVQpxLng17wZ3vBj6cfcuRb/cfoUYGyqBXf07Q/SN9VblZ6ez74F6mkGtOyAEzssD6PSAb20+PeqvMrB1D2MT8BzNzpMabJ4CgOlZK+DFv0pNbrRARPktK+DC1/JtKHsjAz1GTXZRS/Paj4I9kMBN9OHksmhd7wPrgy6Rrp+pmK1nUOfSZ0/A6sdd/ZZ37SEEaROvzKbIJoSgXFhzl4C5HJTKIAYJoBk1l/lq4qgWfWxQY0lLhY3avZMl5FZtRS3Idm0IfPmM6rLvSCMfNnd7aYNzJ8vuC7YFWxgZi9Ce4pUaN41hXM0E0cP8AyyQc4jbO1Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AArw6VEyJmnnXqIwoylQzVUgbHmuOAhrMmyEs5NScmA=;
 b=YiLhsJXDVdLRxzE5/EF2W6x6CJgCH+ddLQyZ53Wuc5rDaPllQKJ6rVhsTythaELmG8FP855tTyBkb5rHgOyxXPUQongPWoYSme+kAWmsmT8Bn/AqWbcRBDZ0aj3AN8IAGG3jv8J9YdyRybbX5+H0P0C40CwR+ZPoDzqgXpQoSMnwnG730J3JQAxdSEcST/DIy//7G/gUCJj8vaWEcoc32NNSidJ1HewZd12eO+HkaGXYjb1sSohR1CfEeCozWAar4E+aq2QWczF8kKlrbA53NKb5DOIzNIRXJx/n1wYWwA/5BjUUwMd2WKYnJMG0mj3EEpyAeb71deN0jqnFc1eqXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AArw6VEyJmnnXqIwoylQzVUgbHmuOAhrMmyEs5NScmA=;
 b=AmjsJloNWPHBjxbybeHTtl1R577oRCZP8kPxayESrVKWv8zOnrkwZHTtqzW10hWs8i4Jm/CI475gkaFIDOxg26PFwNpLpHHZ3U4xID4wAN8b8C53DzoXOWQqUU9iIeCYapNDsdMF+v/lrr37SyuUZFHxKbrqo9Z/XMM8ubRfvVq9IU0d46mgRzbcZI1DsZB4sa4Do5sSEBlzps2LSF92NoX6KZr2BLHh7JIU9DraqloygiSfhZsQFdtc8HOrhfCU9AgxRJm1kSdZLd92wKpzeuV+6reKXpYbZjKbnrlXdfQeRv1/VniQO9lIoY7Tv1n6sfqfzp+ijdRLhKEknFsR5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB7648.namprd12.prod.outlook.com (2603:10b6:8:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 18:01:41 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.015; Mon, 26 Jan 2026
 18:01:41 +0000
Date: Mon, 26 Jan 2026 14:01:40 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Wei Wang <wei.w.wang@hotmail.com>
Cc: bhelgaas@google.com, akpm@linux-foundation.org, bp@alien8.de,
	rdunlap@infradead.org, alex@shazbot.org, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: Add the enhanced ACS controls check to
 pci_acs_flags_enabled()
Message-ID: <20260126180140.GR1134360@nvidia.com>
References: <SI2PR01MB4393B836EA4FEDD1823483BADC94A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB4393ADC9C367C4A6F8032A02DC94A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20260123145113.GA1134360@nvidia.com>
 <SI2PR01MB4393D4D3E28FC1E22E3DF3CDDC93A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SI2PR01MB4393D4D3E28FC1E22E3DF3CDDC93A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-ClientProxiedBy: MN2PR08CA0023.namprd08.prod.outlook.com
 (2603:10b6:208:239::28) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: d08686b3-3f84-4aa9-da60-08de5d04f57e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5/hXPISdZHseadM1l3iZmv7PxMQcVPCIIXF0fKbznXZNczIGjMS8oVXhd3D8?=
 =?us-ascii?Q?/p10MvkXj+pcuKP9nZHdN25LfW/gl8UAPngo8bDLq06aHd23nP2szDw2CyG1?=
 =?us-ascii?Q?YjGp9CmDVkSjqZtW111t9IcNFYrivuMaIakC7l2In485UVITwx5pjZ+J9rIR?=
 =?us-ascii?Q?wrPynPZeFZiVfm1N5XbncF2lWZNPAnrv1dOxk/84+rtB8swp6eAdi6Y7bb6U?=
 =?us-ascii?Q?UBkgFREGKAo6FQ6U7m76pcDGj3FkOs7tM11VuBZLW+/oKjU/fAnK0/Q7BLTI?=
 =?us-ascii?Q?6tI6aGlNQFltWjUVZMwR8SIIMXjNHRtmMUtVWNkCtvL8CjyDLoCCfcUk5egQ?=
 =?us-ascii?Q?rZW2P8iIrifqTaVsNT04mMceh6NJhfDPITmsvWEQ1uTj2zsJpZLsOSpFUlJb?=
 =?us-ascii?Q?xAUaTe34U4pjH8HtBIlHkc/t7fHgDeV0sBOF11BA59WRIPGFMS89uH+sc4Z6?=
 =?us-ascii?Q?hDZUjvCtJf2bmbtSCkfJ+X2HPVrRgZk35XoHKPL/nEzvsUzxnrw6vz8NdzuJ?=
 =?us-ascii?Q?500zg2YYRkJEap3ghlXeQYK0vtSCfjnlc1jT1yzfeIKY4GrafwAumLqFezoc?=
 =?us-ascii?Q?ypn7bmvE3guFWA9FoRakTSHimliMCLHrwxrGz6035ddLD4k0jXMjmU+O9OdA?=
 =?us-ascii?Q?dkz8Mzb70iySq7PmARXazVqQEdrhwE0M88kTBrZyGEMajrr2tRRmQJjqBE/F?=
 =?us-ascii?Q?+CfalOzClpvZKSfevSKOynMX0sVKQIPvWhf/QpkTssleURz7UgaL9tQ5dw1B?=
 =?us-ascii?Q?thqCpwP/hDE5/18FiGocLZcyVPhOUk33kl+pc//4fPU41n+EKI8mLYMjHtHI?=
 =?us-ascii?Q?4UQiG38jEUQcBrCWrdY/GdE7eCajBTT0cSmGmrMXrCtKXKuPEGSBpOqhevSG?=
 =?us-ascii?Q?ZWpFA1DhA02PU36VYR+wPl/2RfaH92NZfqcoHIM0oXwsbhT/+Gx/bua2nLu1?=
 =?us-ascii?Q?Ci3nT2GYQzVwe5ABNvk1vNLy7GkwEMlV7TQQRpttu7fiIZNva7wcWFkHzo8g?=
 =?us-ascii?Q?Zcn5dmlrkKAptsaPxvD8NrK4zMPpcauUZLd/Yl22yxUzXSE+rYr39RwkIXhb?=
 =?us-ascii?Q?NGdL35BLpxbreUOKGrF641N4mJkeHaM6tUxs+f0r0cbUWlWToH6MG2QgYipG?=
 =?us-ascii?Q?K0335MblX1gztctLOB2YaBCad05FT4LP6l6RLHVuB/N1rEa0SiyKP3677Ptb?=
 =?us-ascii?Q?zqbjrtoBkk3RgqiJtkkv1+FVeQISfi0RkOeIPL14bbJJDnW0DMcOvqMRmlai?=
 =?us-ascii?Q?PmeQkZTReSHIRoSoCFqhteKNvUgDZ32JzsUd2Pa3HarUfK5R5ufrB8IEQB0g?=
 =?us-ascii?Q?DU/dYdy9U8AB+iPz6fKYaoH57PKPTl9mxpVhDmTyKsB1Zvba72DL44oxnwh0?=
 =?us-ascii?Q?u99Izl4oV1SBphBmIRRf4stKn3bTnIRTK8KJTUpzsfLW4by07ief9qGhf8To?=
 =?us-ascii?Q?9IBCfP5FxQerUygLSpIEBokIHipydm54btqMJsQI4zu15JFkH3x8GUJq6/1w?=
 =?us-ascii?Q?d7OzLx/KNXtnBmxtDiJi47/OBX+KaPwBRVxi+oV77n5SeNHMYvPiWvyidLNL?=
 =?us-ascii?Q?MnoNyMLo4ro3eTQAnPY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JhtGeCyMiqbQtM5pvbm2/bXrC9QO0hY6bHMlXitfcLi/VG9ZNZ2dfTO3e9Fm?=
 =?us-ascii?Q?KcnbzdVaw2Fo91qbPbZahe2NhTNw9VXQUSMUdeg4DDa0YBEGCK/gWMCgOSxQ?=
 =?us-ascii?Q?EU/4SnaRlJ4anoAnu0yip0dTzdYFtN8IHkzREsE0ZmywXZvpS+XcmK/yv4we?=
 =?us-ascii?Q?ughFj/V/jENZ/aZ2YnA/i0iNLFPlQp/eabBNgT68oalX7kC4H1GeYsNnN5dx?=
 =?us-ascii?Q?B01cK26LwU2JmN4kSQn/jjkYOWBr3/CQtltKGeO/CFK30BYwTSjSj/ojklba?=
 =?us-ascii?Q?jYIHMb/fvj+hKVs1yMgV4bBfbjoxa7rMf+smDIkNynqmbrLgy/F5v663Odc6?=
 =?us-ascii?Q?dA5/9SdCy2KuY5ttaVWxuo86fUuYJU/PjUWGLJfxwYMfl+EcA0PWT7ac+OEC?=
 =?us-ascii?Q?dsA6UXoLJhWheXtfDBr7VxEIWWfkB3JrsLcbs6+qBLtnY5JjnTIbcRPkevlp?=
 =?us-ascii?Q?BbsTqqAYprfajg2b2e5uMd+Al77VaW2r+it4vJV0lgsIeg3DY01R35/E7uuo?=
 =?us-ascii?Q?i0zk82Gb4XcgNCqSMK6z517hQmIZdo3D4tSTCffRdOsH5hbiQXxViEcdvpSo?=
 =?us-ascii?Q?wpuno8deGDZXRQSebqTo552OlGtDP+LXr6tTthEhgnatktHUjuHazx1V+tTw?=
 =?us-ascii?Q?jrDX3DUzt9HcpvgRVM118JHTxmtTIcgLF7G5fUF6bKcSkB7xMPq8NWg1dHji?=
 =?us-ascii?Q?J1Gm/CW9IpL/v/6VIECVO+byxGPROzrZUoM345pixIvnSC0bWUSYYOi70oCA?=
 =?us-ascii?Q?Sv8t6dKLXgx73mzZxAGOGDPkYTaC3dGDAVlUmmULXp00uCADuTkvxNiAozpg?=
 =?us-ascii?Q?w/SbV6N8BprlobqsGH/SiRzjJLt6ziVD9DsHP1ejvVSg+zoeLtXZv0OTopSB?=
 =?us-ascii?Q?rur+JcKAXcZYsVsyQyMR2kVGhflYGdb3AdZLh8vcaGGAIoFJbStMLWwAMKa1?=
 =?us-ascii?Q?ePf75h8AufjAP+v6DBwNUpxxnh6NRTU0paTQmPwBJBt5b1yzDWui2BdjpmyY?=
 =?us-ascii?Q?lRzCpKAfwKtuEGwVE/D013gNcvzvE57oLPQ1NCkaovJ3tAQYpjkLSZhg6S+u?=
 =?us-ascii?Q?50l1qReirRYIvQMNNxQOHDCTZL7lz+ZRKveYz6tD2h3ASp5PKPJAXbCDARSE?=
 =?us-ascii?Q?eybHsdAzbdIGkveSg5+/S0Bb+lzFDoAaJv0eHxOoblUKtxvqhOY0K64+kJ//?=
 =?us-ascii?Q?NnrrKifQ5ZCT60r/eZ0OaPKMB/52Mtiec186yUDYKF6gbwJ6+shA1qUa8/zN?=
 =?us-ascii?Q?hVbrRiPtdJa7VnHkjYh/9Olt8MUVA8r8G9zK4stB8kWyt0/WssQyj4F5/GG0?=
 =?us-ascii?Q?Ya5bzCulD1EcGtQ1sgCt9n65E8xd0lUy74q4FjG9XBFWPULMAnuhwsHbhiIm?=
 =?us-ascii?Q?M3j3V1qgLnf/fhfYc0kKNSZp6R5dlbD9c2JZ6Ly4pq3PN8ZX2dMMwajkZ4kF?=
 =?us-ascii?Q?o7Nbg3PjskQRw9Mpvh3+dJnucN5+TJzL55irnt58kqn/iwjYqHUKreSqdNpI?=
 =?us-ascii?Q?A3VSC3oWxBnuu2P3a4Xg+RTpdm/qXHhvsNuoWvu9XqzmkbX924wc30crReW3?=
 =?us-ascii?Q?XVAYwxi6qCJmL+oMsq0XuIQtr4TqNYILPXC6mPAT172BUao8Z3ptYopDAV7a?=
 =?us-ascii?Q?wB0zqjVYnzI1qGSi4fNK533HREZ45LopM85X21FPcarL+pxt7MXzIxnD2bxO?=
 =?us-ascii?Q?zudsFufFP4pNXurgRuGN95bqxYmIAwd/pin6ZteYz3KbFqKKpEnKKJrSBINb?=
 =?us-ascii?Q?UukTZ3yjOg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d08686b3-3f84-4aa9-da60-08de5d04f57e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 18:01:41.5745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZFGkkGgbncWZVJ31b86KrnYbTaWtnnM9Xv3olaNkmTN/Uyxe/9XtS/srBPvpT4i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7648

On Mon, Jan 26, 2026 at 05:10:18PM +0800, Wei Wang wrote:
> On 1/23/26 10:51 PM, Jason Gunthorpe wrote:
> > On Fri, Jan 23, 2026 at 09:49:43AM +0800, Wei Wang wrote:
> > > The enhanced ACS controls introduced by PCIe Gen 5 ensures better device
> > > isolation. On devices that support the PCI_ACS_ECAP capability, the
> > > controls are required to be enabled properly:
> > > - ACS I/O Request Blocking needs to be enabled to avoid unintended
> > >    upstream I/O requests.
> > > - ACS DSP and USP Memory Target Access Control needs to be set with
> > >    Request Redirect or Request Blocking to ensure the Downstream and
> > >    and Upstream Port memory resource ranges are not accessed by upstream
> > >    memory requests.
> > > - ACS Unclaimed Request Redirect needs to be enabled to ensure accesses to
> > >    areas that lies within a Switch's Upstream Port memory apertures but not
> > >    within any Downstream Port memory apertures get redirected.
> > > 
> > > To maintain compatibility with legacy devices that lack PCI_ACS_ECAP
> > > support, pci_acs_enabled() skips checking for the capability and logs a
> > > warning to indicate that isolation may be incomplete.
> > 
> > That's every existing system, please don't do that.
> > 
> > The issue with ECAP is the way PCI SIG re-defined what Linux has been
> > doing forever as unsafe.
> 
> My viewpoint is that there are known bugs with the legacy ACS defined in
> PCIe Gen 4, and PCIe Gen 5 attempts to address them through new controls in
> the Enhanced Capability (ECAP). From the Linux perspective, we just need to
> adapt accordingly to ensure 'better' isolation.

No, there are not "bugs", there is a gap where a very rare and narrow
HW configuration was not specified. The vast majority of systems don't
even hit this gap, and when they do switches that are safe and secure
to use with Linux do the right thing..

> The warning is intended to raise awareness for users, so they can make
> informed decisions about continuing with this setup.

Then print warnings only in known bad cases by detecting the holes and
evaluating the quirks database if the device malfunctions. That's
hard, so I would just skip the print..

Jason
