Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013054.outbound.protection.outlook.com [40.93.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A960039478D;
	Fri, 24 Apr 2026 13:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777036317; cv=fail; b=A+/QzA5FFS9stjMtSH07yMuHvFiq7RUn4ox78kNZiI5DalICeyfvqLEVrGVkpaPpUPa+q5KcPw4qEZtHqDhVKpvXBhErJaxLRl6L/K3GmH9eSu4ZzFsMJL7r2s6IeXsrcXz7HuWE4g52lhYIidHkUzW3JLSF6QS4Z+WspvthUv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777036317; c=relaxed/simple;
	bh=0yONkzPEvd1wqrQqwgFu3wHVznmYjeAnUuETznnNjNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mNa5ibZD2BD9XthsMwSzLM+LQbR4AVLKIoTM48vwSqEUepGKX1P9j3Z4pwr0uVngxm0Cv3q4ZWjPbV/RGRv4VNb2eCf+Kk4JcosQZ9js2Ye4iVlEE+Vpzq/WpCVnoHW5hxuyRG6PGg9rAk7HYmOwUlFa9zy0k8t0c8pWMXvdISc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tu6o7BqO; arc=fail smtp.client-ip=40.93.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tu6o7BqO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ot+8D2krCNHkduIE3Gh+dAhZlg5VyjAAxYktNpGs9UVd9kIKdzGiIhxnH9UpeOs59ZhVmvrskcz36V2myW/8HsUc8MyCcZiLAdHSw4DB0k6vItprZQKg9UKV0jHKeRILk6NHUVPBVadrazEMFeGPcwlloEHWNaogzXN4mRnqJWVHsdG08bkiCsunK11V228bG4HK9TUu0tW4RvHBtGbaT794rUfyas5z14u6BbZVdYOkvYTPlMdRbkGhZu0VQSSP9YiOsk054zxv217itCMu0Vv6QTmckz/ueemLsxUpAlR7x63YMg/+kMdyEMkQE+Reqnsgh3Imgeug3BPcVPJwNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SEMsnCv7F0SZ1sMaRVWrWG3ATz0zPriTI/aw7CyBKA=;
 b=RuQW1c/cLipgf6Mr9G19gnZcExYdU3b9FjFccINLekCbD5ST8aCnMsPv69qkrSDr1POGldqZzzJcSlAewt5RmQ1sr3woeGThNbrby7Dcps7xvi99FRoM+0F26oplmnSomCqXxJVxuIsE0VotUZlfMoJjet2+HDOUbj0d1gE+jPE7bmQeVVs67ZMqP812L5hybuGj4sq7JBZ5e7JsxKmVinAxZwZAtggpueCxODEWy/ZzLNa0BsBvPApDUWLE3fOtQtCJq9rAJrukNeS93x7aQu38JqmoBy1hzD4MZHwP6sDZQQnsCJ+FFEI/CX5QARMTu3rrZK6L3JibS3ASGfXl+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SEMsnCv7F0SZ1sMaRVWrWG3ATz0zPriTI/aw7CyBKA=;
 b=tu6o7BqOZ4GUtXZttRD8v5iTfiy47VGl36r2TMv0HTaP4VW3JL35RRxIrg2mutn7COW8nLL3vgUEjFwdGIP4DUxcDMPwHYPqt/F8L7vLjBpwi2yk9t7BSsI+OYJWswEIKvXwSf/vbPphSe4PEC8C41GMdx4FLTM650pDeeBFKNo9qDPPKZpdkQCY7vmtRjQattB/glA4W5eLoVD+bd4/IgXjMpVg+d+QBVAVZ3+OvOf9JiU978q2+nB75m6PHPQv3P+0mODvEyORLm4Z7qWmeBq2+1AKlAuHmAvLymBPJ+XGNuJsKIrAoY6XOdEWQxSvXjeNaxlGmjafi7krBPGGkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH2PR12MB9543.namprd12.prod.outlook.com (2603:10b6:610:27f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 13:11:49 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9846.019; Fri, 24 Apr 2026
 13:11:49 +0000
Date: Fri, 24 Apr 2026 10:11:48 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Pranjal Shrivastava <praan@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, vsethi@nvidia.com,
	Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v3 05/11] iommu: Change group->devices to RCU-protected
 list
Message-ID: <20260424131148.GB3444440@nvidia.com>
References: <cover.1776381841.git.nicolinc@nvidia.com>
 <12a224061de4fff9e0725909fd0ba4e14996ff08.1776381841.git.nicolinc@nvidia.com>
 <779dad61-d7e7-4ae0-83a9-8c5920222219@linux.intel.com>
 <aerey+ULGG589rdi@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aerey+ULGG589rdi@Asurada-Nvidia>
X-ClientProxiedBy: MN0PR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:208:530::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH2PR12MB9543:EE_
X-MS-Office365-Filtering-Correlation-Id: 53eb0116-a9b4-47ce-bc3b-08dea2030b57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	S4MYqoEl7Odel8L4Z9L4ojofxhb2wtHJ4QFLaeaUO223GOQgSTWBGh5gg3iCjHiZNqDIIsg4E7hBzEkS18XFEowABgYZqav7lcclyD0+vKKFGvXrK5b4zM2RMl+Xc7D4s0oeFW+uObpEJIw5v6CAFqUcT1oJp1I6lX9hdP4eZ3kZaPWBvhmHBeMYPZaZIS/imHMqr5u/objxA9XEr31Cxc3Apa8eZExCG4XJrP5U+M5BAG8I6cHjMnhS8f2xfv6udS0xyKE5k+dTujE2k6SqC7DjYCcAsvvKvDaqYaKzkrdlHD+CDh2TLmaH/NKXq1bW83F+7V+7QS3C+TSteEGgGoXBuP/nwXyRKQN2xwGSqKcnUxTBfwW7o2NqJL73Owbo4GdWe0pgXGTx+KXSuG+IdUmsEAA5EEQDhfBnRJYzIWT8KUudxLK/AIbUebYIJxKdg8jpNFFB9GbaazmCVb0Noad6V1SrbiQOh4oifWRtHnH3J0bXjvHWMaKJWYuUQC//eek7CyQOGy2/I7bdJmFZukgtfe660AhI3avxYxSAOsRr60TuGoe/EgB1cuKwdbvQotXGglt2ue8v7X4X0PipbEnnLbIOJ1Hak0q3H45CxuTytOWqTbAVMPHmmxXHwFQ1rJ/kDoj4hfzWaJWiFGZntKoktFQVDx2EHeeDibaJucRYSuW9wRqrGsQH2r3Zm7inbi5ksoJ+9hGeUtNgnXgl8rrs9dr4keMlpff0Zgp8WJo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d6ctNdMlLpM6ppiaBCSVrPaNj02bIXVLqL6/IStGL8P5QXOYcxwDNswBZL7u?=
 =?us-ascii?Q?O7EkCKsFxwb4EVeODVMwTELjKZ/bqVBXxpOMaDK/RpkEe8uidcQHNYEQuGTZ?=
 =?us-ascii?Q?4v8waT1PgDqd8+vsnzm7D0LIYdy7fs6xjXncAjWy3qnh3QafaplFQY10sf7J?=
 =?us-ascii?Q?4pJwoEMAgwC5yE8RQ/GwC2WWdad3EeZ7CoeEw3GhNHmNoAI+wz67mRsMsapE?=
 =?us-ascii?Q?vOu6/gYBQwe+xfhz7mQmKmhg42hzWMzoAYwg/s+bEnzb7I5RRZ9STDmA9gN0?=
 =?us-ascii?Q?6YgLa9sZQrocXk1mPPAJWNcsTjN0/4aCjyjm50o0oLoWYTAClheEwfRkQOLB?=
 =?us-ascii?Q?xYERu3lKkLPLOao0VjHgzaAjAOVzQiVo2XN3EUufzBboCB6yYMX1P/B2hhZF?=
 =?us-ascii?Q?sFqXnEdQSV7KAt+9YiAKafcdhlo6P9oEuWVoTJEMXDC8qu7Z5I86ZgU2NEVF?=
 =?us-ascii?Q?wWBtZm5ZSI4vxZRou0mVX5U4/EAvMaLwWniltwNSQf5xo8lHSB5xkwBMUxOT?=
 =?us-ascii?Q?qcBs3V5MujMr2/0NNPhnsDKHsWIrXzc+weQ9chc9ZNN3noOsRWBVnodT2IOP?=
 =?us-ascii?Q?JtdAoP0wNFDpMyvGO89ZcQA7psWTFjtPqNbOTu3f66Rm/BHe7WF9LCbLYsdE?=
 =?us-ascii?Q?PQjNS7Uv9Pk9lslfwywqteUNQh1A1WWz6DthCNQ9pm1vm6SU0d56tnQ+u+/G?=
 =?us-ascii?Q?ODecMNxGDnqkir71hy3RbLJXALG+cZ4i8eJb83vtDmwgZKUiVKcbLq4aoLKR?=
 =?us-ascii?Q?VmqAF8nCj9rmog7A+2PHKDFY+VM+FXxnX0DiFDYZ20FG7ENRitVERF7On89v?=
 =?us-ascii?Q?kd57EOBLz4bZdvTChQ1y8p0/3OKLNN57GWGLXuFSA7/vEd5KNJ2yVeTFmY2+?=
 =?us-ascii?Q?kSbi0vjf5JjXm+Y5eNtj4OdLlSQ96Wjsjn4quxi8Yw4tUV7/eEEOifhOmHk9?=
 =?us-ascii?Q?MOJU2C0nBqWBDscmu/ZY093FfDzTv93iFJrVivct/tstKuLxy1PMtrHTUcrZ?=
 =?us-ascii?Q?aA8CISaI/qSlQtJre7u4Ytm17TeGH5Csd9ghg/o9prcLenX8ANU8vsscqZs0?=
 =?us-ascii?Q?eUpcUyh+uYRR5AN20iVJibtEjT2gTc7nAtbuofCJaHUjwxQ7utJgELtix/gs?=
 =?us-ascii?Q?FjjO6qx+7BV//fRSl0Gbc8uOX+brrPTn36YyPfwt7DHDA/2+ntLb8FyYOYbj?=
 =?us-ascii?Q?81WJri5tlPzZ+DYI5NqtGd0RrpQOnmFS2sZChQ7P84HlZcFi31Kh4Qa+4n4l?=
 =?us-ascii?Q?XFbyaLxssyBH/Fblx7gY6FomS55sNxRSHNZEdBC8MNXUDTntHn0HVBL4X3Yb?=
 =?us-ascii?Q?sYegouk6Ce5Yt3sMQENGzTnuLCTP3mAxQ/qceaxVn+s8gv0JkO23AkNHcFAF?=
 =?us-ascii?Q?sEEOdq6N9FlASydJHVb7GEG7GLDZs5KIMmz4Y9tsE2XHxkPLAKmHgj0ecbOm?=
 =?us-ascii?Q?OgZe3OYAoceyOmGmG9c+BhpAhmkB1XQCAduM+jpDcpi3/QwrNK6aQxobV6C7?=
 =?us-ascii?Q?A/pQ96fXIcxhte46P5tglyjRzQKTWsbKKX6PHVmktWqh2elFi8ZlY+sXOEd0?=
 =?us-ascii?Q?HSYGUyvgjjNaBJAk35o8lIMbzK8gpPDJETUPSm5uJ71gzkEKT/ENFPA170q/?=
 =?us-ascii?Q?jsofSopKakTazJelMriP3H9cuXcoEwQcHNPX0OQGhipbYzG+y4U9RlWFx6Ke?=
 =?us-ascii?Q?qn+OSwvjWi98UINMLl21VFgPQ2MI4jGK/8RCY1zLSMI0F/Co?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53eb0116-a9b4-47ce-bc3b-08dea2030b57
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 13:11:49.4770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4QTo5YZ96yLTTqdB1NU10dtG9uQmfWMk8R1zAPyDYqvUhZF9gjL1BFuJPv8Q6IC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9543

On Thu, Apr 23, 2026 at 08:08:59PM -0700, Nicolin Chen wrote:
> On Fri, Apr 24, 2026 at 10:53:49AM +0800, Baolu Lu wrote:
> > On 4/17/26 07:28, Nicolin Chen wrote:
> > 	    mutex_unlock(&group->mutex);
> >             /*
> >              * FIXME: Mis-locked because the ops->probe_finalize() call-back
> >              * of some IOMMU drivers calls arm_iommu_attach_device() which
> >              * in-turn might call back into IOMMU core code, where it tries
> >              * to take group->mutex, resulting in a deadlock.
> >              */
> >              for_each_group_device(group, gdev)
> >                         iommu_group_do_probe_finalize(gdev->dev);
> >         }
> > 
> >         return 0;
> > }
> > 
> > Will the change above trigger a lockdep splat due to this "mis-locked"
> > case?"
> 
> Oh, I missed this one. That's a good finding!
> 
> Perhaps we can just change it to list_for_each_entry_rcu holding
> rcu_read_lock() and drop the FIXME.

You can't hold rcu across that function IIRC

Jason
