Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020133.outbound.protection.outlook.com [52.101.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8026E337B81;
	Wed,  2 Sep 2026 02:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788315250; cv=fail; b=Onk4MOjssKYp7/Dj2zNKPqaJMC8MERE642S6x7cs25fxUiDP2fUFmDEuAb1oW7HeZb1zScR3Q/rkoFX0aLV1dMvOP3qd/LwVfOsq5W8DAqENVUiFFEMH1l4fh4K99QVL2J1n7VuHIns4tN/ZR+jWL9nW3QF6CsN63R2gzQagG0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788315250; c=relaxed/simple;
	bh=1NhakVeJMSHU+dmSvOo0frI3lx9v7UU+yxXBFwek4GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pl3OY3uw4ae6kTgGEK5F/60JlYcYUcI1gnAot90fecEgg10TTZXZVp76ioC1PWMWLj4e2wqSoNqwzPWOMIosKfScOhx/KL1L01VAdDzv9niIipQbH1KD6O0RBYcdgMO+5l+JBWYdKaeKHhdNkjsSo3MZA9GT9U/JHXzdD+8NVK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=KhX+JLQD; arc=fail smtp.client-ip=52.101.228.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="KhX+JLQD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NE9oiQtXK/4n8Qopjpc8xHeZeee3/uDWmdMadzxRpJZgfLOg2vVtIxmunmKxPmlwlmPyZ4ujIo3EN9a4JLmQLiisLZ92pHBrDqJOWomKgCJNrhgu9Tdjp3a1HIZWJnqXLJ31YcV7CjI2jJ3eTZ7l2/wQJv/ro9WcplRCdW2kYOUS90t9jk4M2gy+EMkHUHnvCkeOxxkyTrj2yqzEpveQZPmzTye+2QjIhJMMrFG2KCCyozZPXpaOKkghPnnDGnNavLB+MAL8VKQHR8cOcRNGaDKvEM8eLcUq5xYY4cbKIYF9b0kspdwZx6Yjf0dVrlKu9go6dF7VwPB7zq+kIV0UlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuJfd/AHXAEt+yEGlnUS3imaLMOXGbBnlCHdm9yJGhw=;
 b=GyFQ6txMgwEYiwQKHuUerv9axyHWk3uWyuiqgbOQPEI0TDg1onf1m0asmZwgmAHk4kn3HKDL4Us3uQyyU2tbWtAOn4tPr4fSWb71B/2rlA21R2SHrQmaqczoPRb/VkiO4OzJqes5meN76eOc/Bsy8WDPLnSioQfrU3t7wO2tpPTniPsTkCvMloJzQwGf/eji77WgmiPdlF7hYIvFmOKtYPbpvVl33ZUOXGGYw92vxCu9UJKlOrSQSrkgKnlwT19OJPTdKd2YiBsUOqlvSk8Rm9tbciIMywnB9ZgPjXGZxgMA+6xNdggeQsR8DnR8/ll4r+Mii7Ca3NppiLyG0lR3xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuJfd/AHXAEt+yEGlnUS3imaLMOXGbBnlCHdm9yJGhw=;
 b=KhX+JLQD/qX2/6okIci3jiN+ove5PujTqXiogQ/nf5kzf44zS9L1/aeBdDXz3T8SGlTopTbwWHOfQ0EONdiIr9miFZnINTmRnM0S2CNNtYVbuwOnwBJHtH8fjTRxz+MD8rdmVJjq3/9lOhw0xl0IoEjlK6JegB9YVgmj0AKuIG8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS3P286MB2567.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1fa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 02:14:02 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 02:14:02 +0000
Date: Wed, 2 Sep 2026 11:14:00 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Rob Herring <robh@kernel.org>, Aksh Garg <a-garg7@ti.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Heiko Stuebner <heiko@sntech.de>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, 
	ntb@lists.linux.dev, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] PCI: endpoint: Support hardware-owned MSI-X table
 and PBA
Message-ID: <sor2mm4jzgeprhn3fjw4jmcaowwkhhuus6exi4k5kum6frqvug@gatkk7r4qyxd>
References: <20260830151948.3547577-1-den@valinux.co.jp>
 <apVWd1u9JjTKQczu@ryzen>
 <pj5vpwwd5tr5tuvhdq3bcpefnq27r6ljvwoysguz2o4tglcqx5@l7zmb6wjnhla>
 <apXdm2I33edo8kpZ@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apXdm2I33edo8kpZ@ryzen>
X-ClientProxiedBy: TY4PR01CA0125.jpnprd01.prod.outlook.com
 (2603:1096:405:379::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS3P286MB2567:EE_
X-MS-Office365-Filtering-Correlation-Id: 27b115b9-873e-4d7a-6fd0-08df0897db48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|10070799003|366016|6133799003|10067099003|5023799004|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0HW/uwv9xu881hY6b5vuz32lI8eyot8LbqIXTuWRd+mQB6ysQQA8oGiF+viuzwloAQZnmXUB4RQfxDMXYcYE2NdlAYvqjNPTUC/hsz3ccGywJvunBv54FARAwxZCvLztQU8CRSNSuUl2TXCzF9vdM/mYM4IRi+EPJ1IftUlO2XeFnHCrCa+W5AzrUpnkNoXrOvP+TeRXh6tbOCRKubrMm5pXITGepxd8JnaZWg02QnWrMgvd7ZQOxDgtm6xtu3zLE1oBOiFXJJCw+xOJqLMxSJOj12XUR4A0NA2+SZLByb/XIPcj3DxcebnayiUTroY6ymOzlhD6ErnBg8IwtWhq2ge9mfKERv3RUMgyFyuMNcxEfwibwq1ovHgk2BOe95tU4KBrwUsmY1Vyov9V+v/KXzDYtGu6uW8GdcWl9p2RobdKeSkJfcslBz/0YFFascdl6Mo5aHMH9FqaiI6Sg1qBrwFXXLaObKAYap8x94bDBKFewjW9k9p1uRRKRJtAtBho1D+uOB4TSV1vZgJVRzPZBo4s6UgnWCKqMHRM0PoKPn9e7DTjVKkOV9kpEEnJGbYz6Lxp2abaHVY7h2ateySRYdEsa0YaQQZZT6iTvHfkvDROh+OZjml4wT8JK8PjjaKstHx+gsQSnYlYlpg1uMPs3Nnq3Z9XUmNcZrpQRlFjZuQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(10070799003)(366016)(6133799003)(10067099003)(5023799004)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H5Df1WgN6NxNdJQMzqTrEGO76/aDUBtDum/FVnjqKVSlT4TtM0s2fYxpgakt?=
 =?us-ascii?Q?w3SoiToprjvN6wlZQfzFBHCrbOvOegz8oX+18f8qevFpNWWATtpLvkFyBPxR?=
 =?us-ascii?Q?lqnDuhJjtVG3sYGXGAmTM8wVIl+WH3+CoHjqYJ4ElpL8RdKyNlbDPyKZCpjB?=
 =?us-ascii?Q?+0PKPxtpBE031kp75cydEe2aEpH0VjVd+7pm3Cbg4CZV3sM0aFtX+41HqKnS?=
 =?us-ascii?Q?sCkBv+CwI05AaWfI4w74thdJmOvHcbNM5UVQrIn4+f7qx1OzjftV1e/vlGT7?=
 =?us-ascii?Q?vkTW/U7W/J9sWcWl6rfFjuOhB4cPzJRL1qJNvBX9Y6i5LCqHsI6dsxamH7zt?=
 =?us-ascii?Q?tJQJisnXEYURUZZHZoOP7KcmGqdgEbNzH8zKSlocsqDeXIHSx+i8NQRcBKhJ?=
 =?us-ascii?Q?OZPcU1w38TTGJMycDCKbCq9c+CxO9p73MOLIaAD/pFrFyM2WIRyjfb+MRU4A?=
 =?us-ascii?Q?zHxfDZlNZ5LzrC8YD8ZjHA1tIckZAfWhCGGvwuWxd3bA3NMLpUMR7etshd9L?=
 =?us-ascii?Q?FZ3u98e9Zg7zdSIU5IINIP/qZdAUPLpvpLsHE5yPhu2Ru8EYGq6y0Z+mmS35?=
 =?us-ascii?Q?euNF5y3dTd9xVBRxUWLPHQlEezr8wAnbXaXbslSyIYdWUQpnSLQYKBftmPJR?=
 =?us-ascii?Q?4Po/2OS3IHPB2cmkAo7IlPfOkrZ6agVlWxacmroFzStdlMZXmGmGkLK2OdzM?=
 =?us-ascii?Q?i28VAf0/xi6tK4vpssVBOT76R82/1Ivf2hI9H8mHB8uH6ShukU1lxCndjGPy?=
 =?us-ascii?Q?47wdtHKkHTSsXpH+MGstJYAB2uOa60uv+RhlbO0EkQvm7rNKekWzGDx3JAGt?=
 =?us-ascii?Q?3eT+7VhnvicjHo/JD2ytDPAqPhtGgSi8KNT9lpBFw/WUl2Q0DXV9IY0BQsqm?=
 =?us-ascii?Q?8oDGqinh4qNDKmwF8jZnTf+pJHJiVM7PVwDYAaJfLYEBAXR1ppSqv21l61Kj?=
 =?us-ascii?Q?SUJLeeaL0PFf3cVVWt/pujmaK81G9L08NFIQsJjhB5e/yqsUJM6bs9iFRNIJ?=
 =?us-ascii?Q?qulGQ/XdcH2FPIy2BGlzssztpAQrGqnNjrKsz+1MAZ6aRYUs2+aHLkCmBIPP?=
 =?us-ascii?Q?Me+gE9YxQNNUBwVE04WfbJXLr4cj59b1oMqENJDfFlX1cCBZDXbHWIitLFcz?=
 =?us-ascii?Q?P/vabjfXWI7l4WRCby7tWuUVYBhpWLeUfui9i9bUW2bJRJpoVkWeAg3QuRzk?=
 =?us-ascii?Q?WrrOjajzL0anc31KfLARMjgLzy7ncmI+Xq3DMyEm674L/WFf4pi8wn0p68tb?=
 =?us-ascii?Q?8ZMUsPiQolvdDXHoSRoy9Q7v1Sn/bunBQlf8J0E4pT7gHOXUaj+DQzcbX/c8?=
 =?us-ascii?Q?dGO1eO5EmN6ZE+rdq9f15ttdlLSzqMOPTAtfu72Gl/cgcgrWo9P3ugRT1KqO?=
 =?us-ascii?Q?6uB1Q5JOeQHcWE/3EON3vX9Mr0smU942gEHARgBq7YPsczgsWOAoCIdJklkf?=
 =?us-ascii?Q?5rJNbXlvqc3hgG3QFJ1blQKhzrsEGJcao9qKv2i3fSgXteXc5df/BSFl5B2n?=
 =?us-ascii?Q?99GlXt8beat0WcM57PQUzK1xt3Qyyw9xKmd3oGczYgmTswGLWY28xhqmdk0t?=
 =?us-ascii?Q?qdJHIarYjzZDU9WUHLb2phFHB4FTkxZhJje9zbIMAK9iKN1Ygk5uhilHkrRI?=
 =?us-ascii?Q?dwSZYkaaN3h8rC5vgRcO0mcbwWD/U+XoGSbm52Nj2uzaOrLC3qvrB2zKXYFI?=
 =?us-ascii?Q?OCyuU8x/GbkSqfjqiyLbhdWg0oCnp7HNJkHkEzs8HKbGM2n21T0nRMoCwTC9?=
 =?us-ascii?Q?cy34X6H1FGeTLz2zTuD+bCRv75K85Q/Xq9xLafKPaFdlYEfL+GH0?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b115b9-873e-4d7a-6fd0-08df0897db48
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 02:14:02.3209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: USLp0emGf6a9PJE7usGvwyc2i6Yc9fDesSyErp+vtZDwo9K7zhZxuHeJHzKB4F45iNVEvN9rld56FB+Z6XZYtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2567

On Mon, Aug 31, 2026 at 10:01:31PM +0200, Niklas Cassel wrote:
> Hello Koichiro,
> 
> On Tue, Sep 01, 2026 at 01:11:09AM +0900, Koichiro Den wrote:
> > This is not driven by a performance target, so I do not have numbers. The
> > immediate issue is correctness. ntb_hw_epf can select MSI-X, but pci-epf-vntb
> > currently configures and raises MSI. I want that MSI-X path to work on RK3588
> > with the controller doorbell. I will make it clear in the next cover letter
> > that, with this series, a doorbell sent from ntb_tool on the pci-epf-vntb side
> > of RK3588 reaches ntb_tool on the ntb_hw_epf host side when MSI-X is selected.
> > I believe that is the simplest E2E test showing what this series fixes.
> 
> Okay, if the main issue is that pci-epf-vntb does not raise MSI-X, even when
> ntb_hw_epf host side has requested MSI-X, then I think that the first patch
> in the series should fix this, so that the fix can easily be backported.
> 
> (Right now you fix this in patch 3/3, and the fix in patch 3/3 depends on
> both patches 1/3 and 2/3.)
> 
> I think that pci-epf-vntb actually respecting the configured IRQ type by the
> host is a separate logical change from adding support for HW defined layout.

Sure. It can be a separate patch, first making pci-epf-vntb use an EPF-owned
MSI-X Table/PBA like the other in-tree EPF drivers with MSI-X support.

> 
> 
> > I initially considered making the hardware-owned layout automatic for every EPF.
> > pci-epf-ntb (not vNTB!) is the reason I did not. It currently reads
> > host-programmed MSI-X entries through epf_bar[] backing and uses them to set up
> > peer outbound mappings. A hardware-owned Table has no such backing, and the
> > current EPC API has no generic way to read those entries. I suspect that
> > supporting it there would require a broader design change. Also, I do not have
> > hardware for the pci-epf-ntb bridge configuration.
> > 
> > pci-epf-test and nvmet-pci-epf should be easier to convert. However, converting
> > only those would not remove the per-layout handling while pci-epf-ntb still uses
> > an EPF-owned Table. I would prefer to handle those separately when they can be
> > properly tested. This is what I meant by this part of the cover letter:
> > 
> >      [...]
> > 
> >      layouts. This avoids unnecessary changes and reduces regression risk.
> >      They can use a hardware-owned layout later if/when needed.
> 
> Okay, if pci-epf-ntb is special, perhaps we should add a comment in
> pci-epf-ntb which explains why it cannot support HW defined layout.
> 
> But for consistency, if we modify pci-epf-vntb, I think it would make sense
> to also modify pci-epf-test and nvmet-pci-epf as well in the same series.
> 
> pci-epf-test should be easy to test, just run the pci endpoint selftest.
> 
> nvmet-pci-epf should be quite easy to test too, just run the normal fio based
> testing that we usually run, and unless you see worse performance, I think we
> are good. (If we see worse performance, that could be an indication that one
> of the MSI-X for the different completion queues are not being correctly
> triggered. By default, the host side nvme driver creates one completion queue
> (and one submission queue) per host CPU.

Fair enough. As an experiment, I converted nvmet-pci-epf and tries to test it. I
could not get as far as running fio because host-side NVMe initialization timed
out.

I found that on RK3588, host writes through BAR4 to the Message Address field
(the first 8 bytes) of entry #0 do not seem to show up in the internal iMSIX-TX
Table RAM. The rest of entry #0 and the entries from entry #1 onward that I
tested seem fine. The same two DWORDs can be written through direct DBI Table
RAM access, and the doorbell for entry #0 then works.

I'm not sure but one thing I wondered is whether this could be related to the
boundary between the BAR4-mapped unrolled iATU registers and the MSI-X Table. On
RK3588, the iATU register window starts at 0x2000 and the MSI-X Table
immediately follows at 0x4000. If there somehow is an address decoding issue at
that boundary, with the first part of the Table being taken as an iATU access, I
would like to know.

This still sounds really odd, and it does not obviously explain why both DWORDs
at 0x4000 and 0x4004 are affected. I may be missing something important. If
anything similar involving iMSIX-TX Table RAM entry #0 has been discussed
before, please point me to the relevant thread.

(Also, I can share my current WIP v3 series, which makes pci-epf-test and
nvmet-pci-epf use the hardware-owned layout when available, while leaving
pci-epf-ntb with its EPF-owned layout. If you have any setup where you could
test it, please let me know.)

> 
> 
> What I suggest that you instead do something like:
> Patch 1/7: pci-epf-vntb: Fix to actually use MSI-X when requested.
>            This probably includes adding the code that is inside the
> 	   if (ret == -ENOENT) { }.
> Patch 2/7: PCI: endpoint: Support hardware-owned MSI-X table and PBA
> Patch 3/7: PCI: dw-rockchip: Support fixed MSI-X table and PBA on RK3588
> Patch 4/7: pci-epf-vntb: Add code that calls pci_epc_get_hw_msix_layout()
>            and uses that layout, if the function returned success.
> Patch 5/7: pci-epf-test: Add code that calls pci_epc_get_hw_msix_layout()
>            and uses that layout, if the function returned success.
> Patch 6/7: nvmet-pci-epf: Add code that calls pci_epc_get_hw_msix_layout()
>            and uses that layout, if the function returned success.
> Patch 7/7: pci-epf-ntb: Add comment that explains why it cannot call
>            pci_epc_get_hw_msix_layout() like all other EPF drivers that
> 	   support MSI-X.
> 
> 
> This way, patch 1/7 can be backported, and will help all users vNTB users,
> even the users that do not use RK3588 as an EPC.

That split makes sense. However, given the issue I described above, perhaps I
should send patch 1/7 as a standalone fix and hold off on the rest until the
issue is understood and resolved.

Testing vNTB alone (ie. this v2 way) did not expose it because its first data
doorbell uses MSI-X Table entry #2. I only found the issue because your
suggestion led me to convert and test nvmet-pci-epf, thank you!

> 
> 
> > > I understand that you introduce dw_pcie_ep_msix_layout_is_hw_owned()
> > > because you want an EPF driver optionally use the HW defined table.
> > > But if all EPF drivers always use the HW defined table if available, I think
> > > you can avoid introducing this helper, and let rockchip_pcie_raise_irq()
> > > unconditionally call dw_pcie_ep_raise_msix_irq_doorbell() for case PCI_IRQ_MSIX.
> > 
> > Yes, under that assumption I agree. With the current mix, however, the Rockchip
> > callback still has to choose the helper according to the selected layout. That
> > is why the DWC code records which layout was selected.
> > 
> > I will update the cover letter to state the motivation and this boundary more
> > directly. Does keeping the layout choice with each EPF for this reason sound
> > reasonable?
> 
> Yes, since pci-epf-ntb apparently is special, I can see why you need
> both ep_func->msix_hw_owned and dw_pcie_ep_msix_layout_is_hw_owned().

Sounds good.
Thanks for taking a look!

Best regards,
Koichiro

> 
> 
> Kind regards,
> Niklas
