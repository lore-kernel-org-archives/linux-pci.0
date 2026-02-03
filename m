Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010040.outbound.protection.outlook.com [40.93.198.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8182629DB65;
	Tue,  3 Feb 2026 17:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770141347; cv=fail; b=ocZzekIw2+Sdp/NHiVATJoK25z0Rtot1/HBSD3qwaJAAgU4SzwYiuAKemiT7PbSX56CwcH861j6vFsdhNM10fL3fIznGogYjPe7Z4SyadPKgtezgOrNj25qi14wkq1ai/F300TYCkwhIDYqIy/Pjeg/F8XrqxP/jDnva3PuzWK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770141347; c=relaxed/simple;
	bh=0yAUcgGlM0ciUYvwhGOYb6/gxJebmd+UokaekdHS0/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UXUjphrvlhfnfJ7TlzYiSooD5rnP6BwTOsk4n0vFdT2Ek5494Zd8xIyXHPWI2XX3Xm03f1ktyhhV1V1/zDNSToTn0wfJmjZV/z67IswjutF/UrMpqdUZUpAO45z4Ch3q0TK8occvdR7vyl+Gnmx+De4z4KOwfHX7v5/6BqUbScA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h//CetNp; arc=fail smtp.client-ip=40.93.198.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h//CetNp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBBHaADAUKLm03izCRldGJJIif2oxNGux9wxIsAD1aSBQmXyZd3+oi9rJac239X5/3VAw9s1158kjJ54hz7lInACShBQSgm0wFXFv/+nMChGn3c011w5+KduSI0umQ/ROkcN8u7dL/B+lble3fVjHryH7jwLzH7yULDLzIXVOHfLu4X3Qz4eIK+f8WLLon2x2LpDi6WBFFNtAbj6d5t8k3VAwVwnqgYqVgC8c+7LIrRcijl8XdB9DM8ggXlI5O/xn58TrtXneY/7aeWy8GWYnUTMpuohqDnZwoiYRlJrzkA5AzNKVRcs4zeQe58u0tXRBTuNHb72MS8OrQ4QEsP5dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yAUcgGlM0ciUYvwhGOYb6/gxJebmd+UokaekdHS0/c=;
 b=CvIvUG0G/FUIp9bUSP5PV47dv/AIketMZy5T+aL4RsFfIqJJxVMkEmHdNzW9KzJ/EjOcAMCCnjq61sUU7aGZPT3mQWbdfSoPKR7xQs0w1CF/MOfkJr8b90FSfp64NeWUW5wxMj98Yo5bY4+gLz4jRo7lfu/CL4zTUHs2W0iz9WTGqbRztczeDbJMcE+adw4TPvchSxidWIF4mudfOwYyF2unvBIsU0vUkPMZnmacbCuww6HXrXXI0qSQ8Y8/HX+TFrqw/q5wIqBkNR05NrEBhXd5iIZhX/wL9W3p0xPp0XV8gQCvAuxeBQAnE04nvQ3nwyqL0o1kdCrNN+GCNPN75w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yAUcgGlM0ciUYvwhGOYb6/gxJebmd+UokaekdHS0/c=;
 b=h//CetNpKhMLePXFe2GYugOx8FSofnwjWi2Ed3FL0MMI3bck30Xyj/+t773B3x/13p2zWI/hg3e/tvnbaOOOk1i1g1Fq4NlLPLYsiJkhFbNTWP7uQVevF0+OfoJHFT6WssxBlpIYa2nPE92i9LFhZpGxjbo7GaRNsDNodohyxiAB1+JAPg8ym5oLcw0xJpJUs3Bms7QQRBpwZ6Mrp0G6zWxOfScDXyNM+eQKEZkXuUQTcEXq6FGuexYVc28ngIBjTb5JGiSljR7LAUHLzuSbjGU1KtyuAvkfunqNQw0LeOBpmekNz0cSwD2rzPazmxoo7du2+3ArgczaKyHkXycndQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH8PR12MB7349.namprd12.prod.outlook.com (2603:10b6:510:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.13; Tue, 3 Feb
 2026 17:55:41 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 17:55:40 +0000
Date: Tue, 3 Feb 2026 13:55:40 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: dan.j.williams@intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"miko.lenczewski@arm.com" <miko.lenczewski@arm.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH RFCv1 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <20260203175540.GC3931454@nvidia.com>
References: <6971b9406d069_1d33100df@dwillia2-mobl4.notmuch>
 <20260122131432.GJ1134360@nvidia.com>
 <69727e7ded712_3095100ab@dwillia2-mobl4.notmuch>
 <BN9PR11MB527649A0049CA195E7BCF9218C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20260127150440.GF1134360@nvidia.com>
 <69795d0366a9_1d33100d3@dwillia2-mobl4.notmuch>
 <20260128130520.GV1134360@nvidia.com>
 <aYGEDv86r4a6l2Dv@Asurada-Nvidia>
 <20260203143348.GA3931454@nvidia.com>
 <aYI0LUdXqrjmRcMo@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYI0LUdXqrjmRcMo@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR01CA0053.prod.exchangelabs.com (2603:10b6:208:23f::22)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH8PR12MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a8769c2-602b-4575-b93b-08de634d71d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bgbv8EleA4tk4zAL4dbSaan2jW+xkCNWylc/3Lx9defR3o8E4/bXX6fffaD7?=
 =?us-ascii?Q?BZ1CEQfcOliSKmJZhmpBkdq1WJwU+kjktY+rEvWmYOekNAxiPku5ibbPYO4H?=
 =?us-ascii?Q?kUIIMhiV+ygcaWvbR6zHK6BrPwIQMeRI3F54eL9bJPADeCaLVzGfuvxva6Br?=
 =?us-ascii?Q?lttOjK8D/t7susFJxvW40Owicc4cXJRIHW2UvipkdqTGiKTxoNbakzf6M/rC?=
 =?us-ascii?Q?Tf9LfBkLcAFm9UuV4/0zUB5aecDtT0hVnOLjW03qbcYra2w+mUR152GVGXNY?=
 =?us-ascii?Q?xBCrhlnwC+alGsSaZey3QmddbKbRuKXGGdhHq4JGvh/VxQuk9u82w7ABhwYp?=
 =?us-ascii?Q?J8WktZXgEjuLK/qSSt3/+3KksiZSTSPGyjNQShG1alzWZBBA8isx3UgqXu6h?=
 =?us-ascii?Q?bevVl43hBvRWUSjte7RPbA7AeuUjkIfwaNrn+eMJFPTJaLTIui7domzs1oka?=
 =?us-ascii?Q?gkZzut+AVTGvMe3YQqVveskzajR0CfvNKD2GSh3IrlyAF5pEUOvl5bGzLu0u?=
 =?us-ascii?Q?c8zHxpLCdzeqZmamyaK85EUcixFZRKIRfKs3vaHinqpBSNm5trVcw8Cc8Ivr?=
 =?us-ascii?Q?HPcSAp1+j6qMUI7LVpmcSoTeTNdYG5tJF3EFEVZWtvtgPLbHVzrZg/0k9KaH?=
 =?us-ascii?Q?6YVE7YDL+B0UDN65mLKiNPx+Rs1b3T0QrhKFU2R0ylc5Ri/72cdfsNyDuQVw?=
 =?us-ascii?Q?PPAuokWF57LaoYIoF9as5yDTmmAcTMgsPphds3vuFbZia2Gfri/+3vXJYIss?=
 =?us-ascii?Q?DTn7rmI00Ha+GYnpFj6tS25+q/BQPTqKE174SKRA2nEWp/tQ7ingmly1byxu?=
 =?us-ascii?Q?6KaIH0ndR6HR2jMm6oryL21ZqWeAr09y5elIP7iL9X6LtjQORHmTP195Jw4C?=
 =?us-ascii?Q?bRcoXBF70qC60IOs1eEGLyHn0jHlYsdHnzi0CZ/L1JKsSqRzTeYlpO9TY8or?=
 =?us-ascii?Q?Q60kMfpP9bVgctO12HP+7QpdCWi19nYbXe+DGtZbWS/EJitQlItGDZ2bwWC9?=
 =?us-ascii?Q?fzpuMPnc/REXWyKMHhJXO83/xSg0x/k8pz06DKOQymZO9MM87Qsm/iPGWpDg?=
 =?us-ascii?Q?TCRhrSApQTiTPNLNx+iha4kh/TYPonsdpLUChTtjrbvJiDto/dvjAtQrB988?=
 =?us-ascii?Q?AlswudFN7f/rbIykqF4Bt+wfWTbAzgsNowwSFZTquItBBUHDg3TmPHoyg8it?=
 =?us-ascii?Q?tevlH6wVGnbqSpdywaS5EVSaUtw2vL7L0DUUIlCJKHzy0eLwGCnpjEB5/4uD?=
 =?us-ascii?Q?s99yoc/hJ7vf+N9AqmRQeo5HXELZht34X5TrulnMG3wOEpEtCgu8NoH0cx7u?=
 =?us-ascii?Q?QVCwmAoVBzlmFy2fQMmVCtnOjSk21BSwx6YJ46cqn8XSPJf//6pPBgtBFEYY?=
 =?us-ascii?Q?AUqI50tfNkLitJyEQNoYAbtu/VaRBzZRfZTLqone37pgvfht4lwxrwSJrxvV?=
 =?us-ascii?Q?/bZei+MvK3VEnJj44Sba06+MYuNXZK1hKVdJ1/7f0ZuUKf9Kw7pW3skGWuOn?=
 =?us-ascii?Q?eU7iE+nLnQrA46bwU+3amtJPjRrrzBsCfRaAwrZ7bcxcp3FGZGQos0GawT7Z?=
 =?us-ascii?Q?wgwNsJAIzkSo0zqgh7M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZcUXBjgxFLXiXOJIVEJ0bYtlMrHMDvSFGc1VHW4G+zQhM9rafEBwQWaFWCVu?=
 =?us-ascii?Q?CvxOho7tqtyvKa8YYdRpsixTx/Z6F3QTgmb7AbiVVGJWDCrIXOtCSY7MbCVG?=
 =?us-ascii?Q?yVFAwi4B8/TJ1jOoCy26LhM5NNPCJj0IjF11Iq1WmQZUNZgRCKOV9o/BN5td?=
 =?us-ascii?Q?TnKtknPDGLBsIwZ+r5R6gVunrAXc/zjtagqvG7LcU6lIonB+FthAobs7k4Wl?=
 =?us-ascii?Q?sHua/BFmN6arXNyqE/+3w+DQeNe2RQcPYtzj729dqSwXlw6j/c1w9TmiujQx?=
 =?us-ascii?Q?lhJ1+p84Jz2Cjkpz1E6Ab3ARvQPbRS2G3InwkvsDZiQln32V6IWt8PxnYqv/?=
 =?us-ascii?Q?CVtVrnAxEU5Bpf/nKwoKJr1NFHBkrSht8LQzFkm5txLIvjAhkRmeLkTS70cB?=
 =?us-ascii?Q?CJiN/Pu0l4wYLAm8FzFrpko2vTKNRQQfLy6NOfynjdPxRl1dGidlUUhmdEV/?=
 =?us-ascii?Q?DtLX4zC3rCzVtDyKlp6oy8lwh6fadFoQ0ixcY6xG74eUg72VIZt2w6oqmy+W?=
 =?us-ascii?Q?ymNh2wjuwKLhjTQzCd/fO6XlIiAtBdwOd4ktCl/z+yR/5b8YFS/6yJHFW2Kx?=
 =?us-ascii?Q?SApa1KTgsHBbXD14saG+Qsj4C+WvXeayjAkP5ePyJFzHqp3ucdCCTnAmUhZe?=
 =?us-ascii?Q?Hp+pIWTCVKwMHUF+WmrQbHRowQF/sRq2knlF1jGkeXczh/ISnFH8+WEAvENI?=
 =?us-ascii?Q?gn/bjRvr6tCCdYS85eeQ5tz0pW7c4CQgfyLYnQYhuVGX68uzZlZ60Rb9TceV?=
 =?us-ascii?Q?GoRAePc3CXwQxD1MvW6cYF/1x1JSaWZTolxaJt7YUd1QPNVRfh5d6hwh/Cj/?=
 =?us-ascii?Q?7Yb0vQIrDiojc6h5kUFqBi2OjvoQOVF6hmTdg/+t2N3Xo2sdNhZiQlo+IH4q?=
 =?us-ascii?Q?NLJjetpaerpszEnOpifCtV8ixu3reBVRA659GSO8dhEoeZAJhDOTpRbhp0hQ?=
 =?us-ascii?Q?GKLk63J+nqQkP/qds3IG2bE3WIKAsgYRnSB7bs70+NBmMWqcfk4y84mgoken?=
 =?us-ascii?Q?07OJp1SWw0801/s4vmk3qbk1dBZGLQRtLAICrFXB1Xd6Jz6eMEY5AdKpvSov?=
 =?us-ascii?Q?fbKKDGIhjBZuHJFvcGmrXEx4OPITfdTwe2oxEJTj+lYji9jl4wEPdEud+q2G?=
 =?us-ascii?Q?ihdoL7OBhy6NFVpbXF7UTCK65hkPH5WwewfyLPMcKY52LXFRYFKj4Hx4K+Ae?=
 =?us-ascii?Q?K0SqNV1CwmkZ6CF/9hsovSs7zzSD4tpgV5iW/PfApIx628O5MTHFiSPFeYjc?=
 =?us-ascii?Q?6S6/ucE6hOK4BimzNGJMjVTJnjgNZgaLi8QI/IthSt+GbRXi8Ad3I+CcFABL?=
 =?us-ascii?Q?YRw/3qHw49/hw2lVljavqXPjlIOQdc+DmoAf4YW64GJ8OMFi8xNuSeBwZ2iU?=
 =?us-ascii?Q?/qi4MVRujJQOOuzTB3WKrtx/zzeYw4bQvC1H7qHeURn3zcI13RTla6LRFXrt?=
 =?us-ascii?Q?Naw2pUWrpbjAs1SAq9wUrp4/KgV/WbgeountKdlh36LWWKiDj2Nb26cuQoL0?=
 =?us-ascii?Q?ynFkJnFchxU6Jfg+ugiJOvHaNLOmYIKVn6CGxxrHoafuuiPdz1Ft7ahAnAJJ?=
 =?us-ascii?Q?d/nqm04grmgkMD6yQdXcLDjH85EQ+YP2qRl2D0wYtp8xfq3/wFFFIyGbMKyI?=
 =?us-ascii?Q?aIGjcpyDIJJCdkpW9rRlVCOx5qh9ZTHJp+PIpV0tHoGjdZ9aY4AX3kQKPQ8u?=
 =?us-ascii?Q?DXfAeMHB8si9Y4xMaDyU4lwujykV51Z5LdSgDkL3VH/H47GOdfT3UEdZERzh?=
 =?us-ascii?Q?z+jGaMDa1w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8769c2-602b-4575-b93b-08de634d71d6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 17:55:40.8224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+mCT1HSUdCrn7wtKPNiX5OkRiAw5WcHR0nz5vKHljH304bfjWz1aNOmRMetT4Px
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7349

On Tue, Feb 03, 2026 at 09:45:17AM -0800, Nicolin Chen wrote:
> Btw, attaching to IOMMU_DOMAIN_BLOCKED/group->blocking_domain is not
> allowed in general if require_direct=true. I assume this case can be
> an exception since there's no point in allowing a device that has no
> driver yet to access any reserved region?

If require_direct is set then we have to disable this mechanism..

I'm not sure exactly what to do about this as the require_direct comes
from the hypervisor in a CC VM and we probably don't want to give the
hypervisor this kind of escape hatch.

Perhaps we need to lock off to failure on CC VMs if this ever
happens..

But baremetal should just keep working how it always worked in this
case..

Jason
