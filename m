Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011021.outbound.protection.outlook.com [40.93.194.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED83236166B
	for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 11:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774439776; cv=fail; b=aF9Iup6V7UO2t35RNfo2IoUEWUB974zkP2Qck26viC1d4JfDKgUBdo2TbjrO72KPYeEBL02MjyepR30KpkdIwWD3flNTiarEitvVyymB2fQ/U8+TDkNwMP6xT3SHVj0+BlBtLghBpgWgNkjRDK80TL3jKEOzkNFTdVfmpktXv9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774439776; c=relaxed/simple;
	bh=3f0Nx0yDdqgAJYwoy6cUKgfwqYCmWBSbViqgUCW/eug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tmTNdgZ/hrMzSOtJYkb5YYKndsNZQKr6xHRPn+zJmMr0FiM6m7eqehGts85U0Or66ousR7mcoRAcFQxpRJhNhwDpEVbehmxkZgODO5FrtOdycvr3NlxADw7r/k2Jv+mMzxam+qkbZpCqQHGjLulPalf+YtptWp91qm1jGkjs1YA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ldRm4Q8J; arc=fail smtp.client-ip=40.93.194.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ldRm4Q8J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVRzpyqXgsQ/mRMUwmbM2vX26MRZchQQMLtghxjKmdcQMpZet4kaquHbYbpqlXmDbga32dSXSpBQR4xEDs1gwHxN2q16xTh5kmGhV+EQhUP9VeKArGBeZ4mK2N3kFe6PJz2OBTGdRFZnKka2+VhZLHIbv4RCi9aHizw1VeLlMM/vw3apvT4UQcDnVVHXwIEXMTajEHCS/Z3MJpT++H6rz/Awa+KEUguqJk3nyMx7qbmlYj55T0Jk+kvZCXPMioAvQxwRO32dgEbfEsdbXtpZ4fX8MGCJ2uzHxiKWAXRPM6wSTHq4uaeZk9ADTZNil7yVm8XHmWxo87XSQL0t/PTmDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lUhp1wVfiadVx1gbfN9SOqWH6qiVwvYby8mkMqYkg4=;
 b=gfRs5sVjFfWZQpkDVAu/kE28QHgi4ArUU8VK493eL9TWiFr2adsvN1dX3yPWObOWB2djN9lkCKMla9o37kpt1xW9SitQVZ8HYs4yRbGPqCDDhsVJMuk5bB7rS/xmFdH3tzmVnOrNa/mMaZDgasn0odr3A/JbwhFLJ/xwqSwfInqrBPYvaAxw+qRa5PEhG2dZ4itRZ+vNiyUhW89VgTEojnOm0BaQm+w4vGtGy8Tnud7d5g24Dl+wDlgRnyYPdqwYgCOPYkxZ39/YLXwLp4yOd/9Sb71fA6fdni1YAVkctXvfYOsif9MCCG0JtVy+65bd8rdw+TPcWlp1nwsFUV732A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lUhp1wVfiadVx1gbfN9SOqWH6qiVwvYby8mkMqYkg4=;
 b=ldRm4Q8J8PL7q/KDTBauK3VtYJJQhwsUoFnO1MpguyLMUCF6gvbeBJEHng/KoQA15/eSwMlNVcC6idIO8u77+uZG71isLmeawAkPZLkKF4QmFxCTxMaNn/ZjqQT0Wtuv+RpKs3C1fwLhjsDp723RsDWYXhKj4Mbp3kRA7x9p35TMZIQrgiDy8aUvUwrkvXBoXJ+J4SR6ClRZZHIpLx8PB0LajB1COEEWjE5ILo2YCtx8BZ71OjG5xDcy8Tu6kPode88xslJRgq8eXT3zd7MneqT96ZXLcOSLTuvxBzWBAGUoKovgmnfiyTm+XqH3tUhje+ob+zAE9OofCgfc8bhVjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV8PR12MB9230.namprd12.prod.outlook.com (2603:10b6:408:186::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 11:56:08 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 11:56:08 +0000
Date: Wed, 25 Mar 2026 08:56:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, aik@amd.com, aneesh.kumar@kernel.org,
	yilun.xu@linux.intel.com, bhelgaas@google.com, alistair23@gmail.com,
	lukas@wunner.de, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 03/19] device core: Introduce confidential device
 acceptance
Message-ID: <20260325115607.GB67624@nvidia.com>
References: <2026031230-mastiff-create-7593@gregkh>
 <69b38e7427a61_b2b610073@dwillia2-mobl4.notmuch>
 <20260313133235.GC1586734@nvidia.com>
 <69b46bd7935d9_b2b6100b7@dwillia2-mobl4.notmuch>
 <20260313202421.GG1586734@nvidia.com>
 <69b4baab2b950_b2b610013@dwillia2-mobl4.notmuch>
 <20260323181413.GP7340@nvidia.com>
 <69c1f469f2814_51621100bc@dwillia2-mobl4.notmuch>
 <20260324123649.GY7340@nvidia.com>
 <69c360d2107ca_7ee310052@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69c360d2107ca_7ee310052@dwillia2-mobl4.notmuch>
X-ClientProxiedBy: MN2PR06CA0018.namprd06.prod.outlook.com
 (2603:10b6:208:23d::23) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV8PR12MB9230:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ae81cb7-535d-4fe9-eafc-08de8a65805f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qFd6m0FGj+xDBZoqQ+1+Y4AAhgwJwbNZ9v5hEhLB24CRDPxk7VE75tr3ZD5vIFVdL9dYzb8gWhzhOH58fmDgZnsUGrLcWYFdOPyCRs7L2Ltyboest3fUmHNSbETyugOzwW3ZiRcGNdNvXxqhEPQMbu8tlxj4P793PtJLCmWWOd4q1tCUAz1QsNXvoxgvf5McrG/Jnlrmp374/7tuGyzZVXAasV9c9LJk7hV177WQXEyIVTsLjOiqGzKdi+j2cHW1bVlH0FtE6LX1F95x0TBvB3BYFreIJTgpFliOQWEW6hC57W9UtUmsLSRJoVGN7AUhyaNTVsadnzYKx06zPZSOa43jvPRkY180Kg4EGgU5LZfmOtewsaE9h2VEvUuXh3tAP5NHv/Qki4shzL5uLBoziPWQhLgRpWcjsySfhEsKl16Lm74OpIEYWQ5tvqhNzF1ZanJbYmP6xQ49DCXPx6ZWFC3RQf/KusDTAxLktbALWQC8ztj68pXY+YAtHgLaUlp692pgmq493KyOeIAGwLd7h/ipzq8NPq7U6jvcJMnaA2TAMMPONdvhMB+48oGsehm5Gc48Wg6xEna7KY0VngpVJhbhrjAjgvb+2Mur9qC6XtNQ16U45Roh3QlTXkEsple5LFJqcWL/O9FimTy4WhjZR5dQLWYUqfCxIjOaDzqStEG/l+bMCG/ncCLFfzoMsiVwKXBMxSNxU6GRITC/fpgaWkL+hhMjFzC4+Svjh20UduA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jh8sSyY254oXnbERBprk8H0/c0Z/VxCSlbxf/fi2g0CoevjHpY1qoE+B6SgZ?=
 =?us-ascii?Q?OT4dnJdtxPXqA5C7P4P7l+wWRXqWjCWTwkFQWNcjlSq6BM4n5/aAzNYHRenG?=
 =?us-ascii?Q?tuFhH4aTNry4sUDhyWLtY0p1dkTCzPCsNuJK2VMtzwYehxiRGucHIiCheuM3?=
 =?us-ascii?Q?h0vVbUfeDPmgblceGtMfu3rnfnxHRJLqQ7yGgklvLhFVEyeMYEepyaLtradV?=
 =?us-ascii?Q?Y4wfpUzHnH3B0f8wXUOpjIuAvt7a2MiJ7lSYj1GbMlHvL7JX0UM40R5cDmJu?=
 =?us-ascii?Q?pz2ZZC5U+4ZVJMwHW2zmM7hGMD0J0SsGCxTDYPH+SgeUB06nbhhKYATcLqfM?=
 =?us-ascii?Q?La4g2wTuup2oLMmRz0WV9/q3FJJMeFKs7MXAh6fQfExyWwkK5cI21cdjD6sr?=
 =?us-ascii?Q?6wuuQ1NjljNjjZUQc2k127XprlStSZYXEzKzee0TgLj9dUIxMOuGlbC7y3Qy?=
 =?us-ascii?Q?5vcuiK9NH3ZqMzcq35tHYW9ZbdoAdj+wrGsGA04wsvsH4F3fonn98PTedogk?=
 =?us-ascii?Q?REMeh99ZV9G8IY8Q8gIwcJtKHVgKVZxyGFIWy9aFlkkIMWGYu5yJiYLs4FpP?=
 =?us-ascii?Q?tDIJ4QMs2COa6d674+QtItkOsbE5qhxE3DPyehoX4MlLP7279J9zwf1aWoQb?=
 =?us-ascii?Q?CJf9HCp4Rik+WwCcnax8dpViq8g+jGUmiELy8bfLANWX2XtTMwIxQQc6uFqF?=
 =?us-ascii?Q?zGBq+2TtHr3j+9CTExBz4dKdqA+2UI6er33yKN3IZJtQ6WD3Lw7qi/yCzV0g?=
 =?us-ascii?Q?ob0Lrnagvy4xUx6/bX0C0+/U8vnmIMMxtnaPNnjKgZfU9Bdi8w9mWRTvR+3A?=
 =?us-ascii?Q?144Ok2aQeGtME0EqXRU00Tvkcr2Erb/RV54HUSjiP2j+Qe2yaPDeOGEq1VPk?=
 =?us-ascii?Q?Ff7qCrEvow6blN+sVjYU4Sygrcg8Mj2095xpCMoohhH2OjLN3nhb88SBzw8H?=
 =?us-ascii?Q?FRgmDpPycdx5xQ1ljusbCa6Jge9JrBiliYgWi+7c2cpTMNMYaFDMws6fCCTu?=
 =?us-ascii?Q?ASHO44Hp/Pebv0JNxcQXXlyJ2nfLdDQi7uDNoWYjvaNznW2TO4IyK9rQ89+q?=
 =?us-ascii?Q?JQ4T+MIEm7+PPqoXfuuerPU5wVmJbSj+3tZZtvZjyH1uXBtJswFy1XsY2etC?=
 =?us-ascii?Q?3pjIVwWMOUU5P7AltkZrrEN/IrZ8yolJ5WAAfJWynLL+rnWLlQepmggM1hzK?=
 =?us-ascii?Q?+4oNQL1jYFqD33txzZgY53RzHQtqGrZ77CM6SDx/zOoRf9cANiq/MHKO6uX0?=
 =?us-ascii?Q?poS1RTb72tj4Lw+0a15zXiJXsddU62phm48fBi/RLWBFP7BoDDyrw3NTn/Ja?=
 =?us-ascii?Q?xh6GfQir3iHtl7BsMACOv15YtKNZw/LaQ4inLxpgvE5wKdNtxyQuFogSkdqy?=
 =?us-ascii?Q?cZn1ZeZEl6gNdbPkta4aUBNmjbCzgnRtWhuY0UEE4KdK/WJY/eV0+fRmPy+U?=
 =?us-ascii?Q?oT4MlnApJpbPuSJr1OgYkvl6/VqlGd9fnhAzmmITpXhHDrh/EKw7YbL0wXiV?=
 =?us-ascii?Q?Zkvyacj7JGI4gewgzKD8EEdi0j2oDugx0CHGUy13iN8UxWpyB2d3YLAbfdrV?=
 =?us-ascii?Q?WmHtaQddgSB+6zXLt2/d+PUWQHGAroK4804CYfrJbawi3B6MYz7dv9dNfnzY?=
 =?us-ascii?Q?uwXDaZsjW/qNlNo1MZlvlJw5jm68TT/1SjaPyZ0aNzeErCUzQpjBT2YhW/mJ?=
 =?us-ascii?Q?FNuKeFyhEpeFWo1FyoL5pJZHwIHWQqjnrorleWbIwmFNgeJT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae81cb7-535d-4fe9-eafc-08de8a65805f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 11:56:08.5979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVOfoHMp6DczrUcsidCaDw/p2RcknhsJ2mijjSD3M+LGNu6ycF/XNwDi4l30gotE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9230

On Tue, Mar 24, 2026 at 09:13:06PM -0700, Dan Williams wrote:
> Jason Gunthorpe wrote:
> [..] 
> > I feel like starting with trust=0 is much cleaner than using
> > autoprobe. Especially since it would be nice that when you do
> > ultimately set trust!=0 then you do want the kernel to do the normal
> > autoprobe flow.
> > 
> > Double so because I would like the iommu drivers to respond to trust 0
> > by fully blocking the device 100% of the time without holes, so to
> > make that work I would like to see the struct device report trust 0
> > the moment the iommu framework attaches the iommu.
> > 
> > How you decide the starting trust value for device during system boot
> > is definately something we need to discuss properly..
> > 
> > I liked your idea of using built in driver match, so if there is a
> > simple command line paramater that says 'only built in is trusted'
> > then we'd default all devices to untrusted and during device probe
> > check if any built in driver is matching and auto-set trust to X based
> > on the commandline parameter.
> 
> I do agree that forcing trust=0 at the beginning of time is attractive
> and theoretically clean. I am concerned about subsystems that are not
> prepared for driver attach failures. For example, I would not expect to
> need to set trust for auxiliary bus devices if the host device is
> trusted.

Yeah, IDK here either. Maybe it is some per-bus opt int.

I think the most important thing is we get a clean story for devices
to be isolated by the iommu until user space ack's them.

> Right, the potential to see in-between states concerns me because TSM
> uAPIs would have fully enabled the device to wreak havoc, meanwhile
> dev->trust is still showing the device at some lower level of trust. So
> I think trust modification needs to be synchronous with privileges
> granted/revoked.

If an iommu is present then the device will still be blocked even
though it is in RUN, I'm not sure this synchronicity is so important.

Jason
