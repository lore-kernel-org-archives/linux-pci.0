Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795627193;
	b=zXsvrzFkR7af0OcwhPyW6vnUSStfn3z+4CnPccIKkgVGRaulFXLBjPLInrmqd+Eu4Y6e
	 Lefp5EWRlcC1TbhIaEFIu/5zESyWBXWro8I1n0fXebz/y7iJqwKFgep5KR9zECXaXNqbG
	 MF4YI34j5xwAZHB8tmmnUneCFJkq0z4QV+4apZMK8nNPpCU+E7MEc2VeH+2+VX6DJY1w6
	 4PaEfAwQ0FgFzW7Je+umWh11cisDzGWq4ngKnXeXeEoUVwzQ5J3QCxirxiUDxGWtp1DmC
	 OVy9Ka3bscMsBhWnoMaI2ewYbvjD1orR7kswplkmVI7fTgAEtaEUr286CXzLZFlsdIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627193;
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
	bh=YJ5zbM1KAkMv2nx850qzKF+VmrPat36BOb8eNpynfSM=;
	b=Hf6Wr6xRY6ZK3r3dXxwf4Yt8Pd0OUW6WhM7Xar81s7AYniFhxk4qrjIb1CfpKbcnPU04
	 q1bLxVXlF9d0amHATz0QlhtChtz0vFQuQYEIxyD70kx7CBGfLsrcF+RD+N3kRXxNBkgRw
	 h4ObZoscukPlhgxA4TNUrcnVHr+1KwHmgRdGvwmFv17wOLJIlNlFdKn86iv6X/xTuCLji
	 Hp4P8sT6sOrhFKAWb0ltXf3MZqpMeapA8bn6KBICfn6R9Qmq7MbVUyxfcV/Aw02nije+L
	 oQz3/D7s+B4kumBGHAWXxnLbaxQQbCMkQMRi7DCNew1NdBMngD/LswcPlCsoSdW+8/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=t5ik5znB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.64
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010064.outbound.protection.outlook.com [52.101.61.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37BD606A31E;
	Wed, 25 Nov 2026 17:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D37BD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=t5ik5znB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ae2UqiHhHu+vWcCIqqfBb8ifxWV0OAgYiGzXXG0Hmfx0PiRHFvZR8eKQmzamqWx9U32jwHxRj+xfHPhj8GFfJs8OZORg3ZTHgbOJa0NB6TGaaLYR38NNpqhAsXlUT0YD1cb4uBjsKVbEBfyEoXV07ZAQfhf1kNd2UFsPyBkm06AIIH3Xqyhrsr/U1BUWPyF+p8IgTgXVBSbRlqRM5vp35qU23mJgxMJuAhTqjy99AqloVGF8wSwweOUI4CR2b8OcJ8Z+5DLwmJ/dyV3VFWNTfbiPmRJJACOlYdfY4iEnLrkNPKb2Z3CkZMQDBFoatZOYV9Xw4D/JuVT6Gu6SrKT4JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJ5zbM1KAkMv2nx850qzKF+VmrPat36BOb8eNpynfSM=;
 b=qSwqeCm0tKNSCNTw9rjq+zaoPoFVBX/3aaFW9rUjjyrxBpgbyleKFZIpO+c0bkft0Pgq0sm+DgNcBoG6JsBOlABw9cyU1QOMOFVRj31yAxeLQWPyo8iOn1RyDtzH0RitK/m96G2RkCLSYOxwoAHvGZv0CWakyzd7/hCCVl1Be/gofr++WGvQjglwzyA4bUSdvtC3oTMse5x+sCSI9v7nRcVH0lS5632eyRiR/mE0GdXb3swknCt8mqIKYymAtXiiLfZZZxrta6Z3dYJNujFa9dP0yxtuD7Zpw456NgUpOlsaj1Sv/rFkUaUayUq66kFE3JlymKCQ4v3MfAYSnGaOPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJ5zbM1KAkMv2nx850qzKF+VmrPat36BOb8eNpynfSM=;
 b=t5ik5znBwxuX+3QhhpUXzbAb2ZDq+CZoNzpcphnFTdNFVS8Gl3bXJpVHh5HB2Y2pluCHBLjuSFhJQiYPOx6kNUtBiUQy0BSJY7apYprEoGbWps/F106BPMLmMTckR/lsDZK5BSbdoWjTrFZUoFyLwZUpuymXj09nNZPd4WNO2J8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from EAYPR12MB923140.namprd12.prod.outlook.com
 (2603:10b6:303:2fd::15) by CH3PR12MB9021.namprd12.prod.outlook.com
 (2603:10b6:610:173::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Wed, 25 Nov
 2026 17:19:20 +0000
Received: from EAYPR12MB923140.namprd12.prod.outlook.com
 ([fe80::b986:8b81:beda:c167]) by EAYPR12MB923140.namprd12.prod.outlook.com
 ([fe80::b986:8b81:beda:c167%4]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 17:19:20 +0000
Date: Wed, 25 Nov 2026 12:19:10 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Tony Luck <tony.luck@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] PCI/DPC: Decide DPC ownership with
 host_bridge->native_dpc
Message-ID: <20261125171910.GK2156781@yaz-khff2.amd.com>
References: <awVV71IbFuYAJDzh@wunner.de>
 <20261125000838.GA1194450@bhelgaas>
 <awbF3MrVWm98q95O@wunner.de>
 <20261125162258.GH2156781@yaz-khff2.amd.com>
 <awcQrljZYEuCZWGA@wunner.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awcQrljZYEuCZWGA@wunner.de>
X-ClientProxiedBy: BN9P223CA0007.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::12) To EAYPR12MB923140.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: EAYPR12MB923140:EE_|CH3PR12MB9021:EE_
X-MS-Office365-Filtering-Correlation-Id: ba2b536e-a71b-46bd-3de0-08df4b183e4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|4143699003|6133799003|261009223027099003|22082099003|18002099003|10067099003|56012099006|11063799006|261102123227099003|261026121527099003|261028144727099003|261022105027099003|261026140227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	sQXVLa1IQLd7DjPK9sx9L8ae69fRt1o1J18/nsAxWqoWg+0Z0ZfG18NTs+kFtc9wOTzeB/zwhd0hqAdOG/cUDb+1GlqCzwa2YsSHAzhMO9+1CiGfI2RkEautCjxGg5CU/Gq8tVaiSr8UAQgNbLznOQS0+SAdq+/OCSN9MuJcCPYrDdj6rwB5QdBlPP8zCXYRWViHDBTvaW0hBuhHpEp9eAPsiryI1jwH3XDM34QhvQOjUQKhB3ifDgvyKSoyKdjAzsyg1xlp6I6jU2tkCfFEJVR5jWmhFqNF2vhlTJw7Di0IW+pLiIBrVdxq2zted8f+8QkGgFLMMK1g4Oww2Bdcr0b+WQRwmRzQMyjNNwVTt8L/ZS5YHnnRPLl/2HeXa8IIK8rd46ct9Mr9rq0Gs5mndPd1EPoQXJeXQ9+BKA2vWVnao8q/P2KV9hGrLnszKNfzVbFweq9DrnPp0jOorSP/MrKBR4uwbLaAh5a4XRQ3Q2NYsyxGsPNEKI23pY5FCcnKFxCc8fr6kYtzHlsyBTCSyyODangP22y97FRZ39sFUgCRS+354zIW0J558OeDhD2xG5ZnZdR9qKSutifdGcFmykhmt8vQoGX8wU0hd4grfEFy1fPsFsIXk18SUPqA9S8ZCvhSQFN8lS5sAOiyLzgY9kGzQ8B6TsN76dI+/ZnIVj0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:EAYPR12MB923140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(4143699003)(6133799003)(261009223027099003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(261102123227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261026140227099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1DKA0IuSHHyqfvbZ+0BomJ9qKiwBXWiFLXaKP+VJ/NxDdRWXUH0mFhAerLKn?=
 =?us-ascii?Q?c+1WYmY5Xtd6IxRB6C0V55pSiwhzH0N2Y+D7w7jDuRLr+NgrV6QMBV49WrO8?=
 =?us-ascii?Q?AmZT3f7s/5d0EgbRuU4HVCdIPxyFfYF7O9MeIBNh2lZFwRaaY7WA2B4kM3W0?=
 =?us-ascii?Q?2589ieYhXZXqxVjR/9uakLNjWAAd+Yj8ecwoWqfL4JFsLdFMdQWkicUjr/7k?=
 =?us-ascii?Q?JqIXKDVUHEg8A8zDCs4SvYOZePBfjpu5Yb4Ax10VRS1NPD9TWg3eJlNl85Ip?=
 =?us-ascii?Q?PfYEdTLKUux0N/2oGwqmtw8gfUj1NeJB1FluX2bFXA3Syr6hSmYXRrayaqh7?=
 =?us-ascii?Q?+xuhAVAGo5UYkqpTflzfQEIXNJCPL1ZRbpQzwhJL1+S9QHwa7aBV4mr6Q+iF?=
 =?us-ascii?Q?VGe29iYy/UDVFy+XPKe9Ba9P++/QAqkunGRS6lddM4nUzP8IyoVQ165Mz+G8?=
 =?us-ascii?Q?HAQRVSrJ4Dcw6GUqvPeSpdLXWH2IfGu3PMuowJJaRvrH05hruwyaB+dabkSo?=
 =?us-ascii?Q?iwpsyrQXd5F2glJYOii2SGqT3lo+2LmYx0R5XVRFVqwUu4XN54lCQJczGmHu?=
 =?us-ascii?Q?rUPj1QXRMuObsjri3bRQZszeS4eZCj5HrimL/Y0oOH0WCaIr3gkTEVQaYHb/?=
 =?us-ascii?Q?3XVpI8Its43KjqIADb+26GX2XqRKCuAfztHFPPuan56Vi7YBf4KegcQ+d8sY?=
 =?us-ascii?Q?SYRUQdbzC7liW2UOerBJJMhak+yXQjRcH6MBKt92FpDo3t/XZK9WKtDdwCu4?=
 =?us-ascii?Q?s/hnWmxH/CV4ssE65iocncDEgDLjJdyInC//xwKX1ZI0hw6Ytrf+PnoZ7Fni?=
 =?us-ascii?Q?yEgfKHsr/Gs76M8UzqMZTkFrCjM33wuWjqw60Ab7/QAAMWsmAlige4zBDcUB?=
 =?us-ascii?Q?lX1K41t4Gdb8Ho6L5NxwX1yHGaXygR+/jqQ8JqwLkZ+fkCkAFe3MolRMquH0?=
 =?us-ascii?Q?8gqAU5ouk02ZyJFxSndkW3udUjDhegJXunUzMUkgg5f8xfc1MxLi1c1U/yYD?=
 =?us-ascii?Q?+lJKDz41LmX8YLhWUqs9ko+QZP4eVlDjNd545j2tl0MaHtwMj5bVb2+Qo/FZ?=
 =?us-ascii?Q?KHDuGmYcOQR3bYJeRYxoQU4E2QJ1hTjT6pyZqAmqahBVsfa7dNzk23rUeF2r?=
 =?us-ascii?Q?Tots2jV4byRTJWenwX6TorQuJ0S4xyd5XOhHClYknc7WW9CBJjKJx9cWptVK?=
 =?us-ascii?Q?eMwUHwvsXGDJgdsKjIG/QUEwrxR2swL8rO0HOeUCyQMeqaENzuRGJ2wzNOmc?=
 =?us-ascii?Q?HOCSTmShWzGJ+FHBNRTWCPOgEW/dOWRijfcimrrJxz0/4VWa3/41aBoe6uis?=
 =?us-ascii?Q?hYzN1/8d5StxSC2mERj/DHYpEXuTg1i+xKliVLA9kqC60RH+BOpXh5iansWP?=
 =?us-ascii?Q?NdiJSOUUC1abLKvSSup62igk4nZH0KeeSUlFvxpdJlflgi8wOYCu3+g4EhBw?=
 =?us-ascii?Q?tkzkMFffmeCtflcPcfMl0MmAI9bItyfTTfDu/Zd3vVL1ITanGO5HrE1NoB51?=
 =?us-ascii?Q?2wdMooMXfYgSI7wkdm0AroNYWlIl6KuLGzbtM+1Az+pAy6w8fvlKUpqA/lfT?=
 =?us-ascii?Q?QGNKAlr0b6VP3KmL4XELV5DP770G6vlE/yca1wlHRcI9V5xeoC+9QtDEVn6p?=
 =?us-ascii?Q?iba+Y9uPug327jlSuUOyZ56GGy1UU1g1o9kLKx+zo3Ze2r2bL3oAtyAoOnq0?=
 =?us-ascii?Q?GX7q+zqbamchgNkdgUPPPcJ1HjFKcLQla3Ds3SaPVxvoGgBK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2b536e-a71b-46bd-3de0-08df4b183e4a
X-MS-Exchange-CrossTenant-AuthSource: EAYPR12MB923140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:19:20.6896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4ZzAOurxIYfkG3rC0XCy5IP5AiiW8IfOE6eoYozFnM8InYxn+TX2cbyGYbsGJ42Lm65L/mPxLsWSWjQY3V6hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9021

On Wed, Nov 25, 2026 at 05:45:34PM +0100, Lukas Wunner wrote:
> On Wed, Nov 25, 2026 at 11:22:58AM -0500, Yazen Ghannam wrote:
> > On Wed, Nov 25, 2026 at 12:26:20PM +0100, Lukas Wunner wrote:
> > > Hm, I thought about this some more and realized that at least on x86,
> > > the kernel may receive PCI System Errors through pci_serr_error() in
> > > arch/86/kernel/nmi.c.
> > > 
> > 
> > Do modern systems still do this?
> 
> The reports I found are for systems sold in the early 2010s, e.g.:
> 
> HP Proliant ML330 G6 (2010)
> HP Proliant DL380 G6 (2010)
> Intel Server Board S2600CP (2012)
> 
> However the reports are as recent as 2024 because people continue using
> the hardware despite its age.
> 

Yes, that's fair.

> > I don't think the reason and CPU give any explicit indicator for the
> > error-reporting device.
> > 
> > I expect there would need to be a platform-specific handler. Or do you
> > think a brute force search across all PCI devices would be okay?
> 
> The PCI topology of these systems seems to be fairly small, so a
> brute force search would seem okay.
> 
> However my point is that there are platforms which do signal System
> Errors in a way that may benefit from the statistics and ratelimiting
> knobs exposed for AER.
> 

Right, so basically the EDAC behavior but folded into PCI subsystem.

EDAC scan: edac_pci_do_parity_check()

Not sure if there is anything worth moving. Or just do something fresh
and deprecate the old code. What do you think?

Thanks,
Yazen
