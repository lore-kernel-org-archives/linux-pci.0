Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012019.outbound.protection.outlook.com [52.101.53.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5213ED5C7;
	Mon, 31 Aug 2026 12:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788177733; cv=fail; b=GmgNvgAV9PQ3xd5zNtjPxM6zlZOivn/HCdflkMJI5PlfOtykIEsPov1GB3HDQRq2NBkxf1CBFVmoAndMHR5e7yKFc8FPvJbMCjWAufjX0sgsN7sj7zdjQjQeq7sOexey0g8jAsz8YO4+l06QL2/v/v6ZCpT1VtMqZrncbTF8TE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788177733; c=relaxed/simple;
	bh=OBhfePlHSfFSSIHHuEKFsDoc//nzapG4jnXearpn55U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uNmaXeL7SB4fcJcVpf9+YvZKyJUFI+AL/7KBoR8keM/ngWnpwKnx4S/8XCiHbf5r/1+tTdbjyQyteuhlu11SUUQfolHE6y3ioCiNbu4z2i4MzJwoFrjMUMo766neaU0uRBU6l0eK/NiVddAC+jJH1KMEFXf8pUQdyjQFBQrRlkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=femdVmQb; arc=fail smtp.client-ip=52.101.53.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="femdVmQb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNV0HwJ6SHCD0ITCMhkroeIqK+Ztbh0Cy1oNt8LmAj/DHRbq9xZC/UKd9Qs2BKYw1OpPWzCh34dR4+HNJbKrR50on6iSligm1XgFOwpcUTKFyzn5Ta5BDqbZHlUZ1OajwZmkXbpkpujQIAdp4VabMe5ERQAp0FcD/GsphJFTgv7C4aezxf2Kgx2DxElsOBEj3OM9fibdxKd9gnqTCbj7c+pHglGhp/0VZ2Mmo93p13n6lAhSZuVFhoTxvlcKCzfOSybNvvMrpepK+PADXXmBV0jF0ymJ48w4kiYv4eSUNMIP7oWYR+G9EFCcRui9T2RAd4EWl8/8SogpEY2UaydSOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32tEMqalnYinDgJiFrPy2hUA4L0wfu+x8SPLDRspAu8=;
 b=lxZSK1hQlFJ/gz92qPPEl81vkgl0vn+Q212aG6DgTnyZcM0KUZIPPRpmqkxqT2cMnUC+V+nx6twx76pKy54zVz5YxOVZGQYdMRDAQgdsnsLIPFmYnQS+TckQuv0sCP0yfjnSD4kzPdiK5py4qYy5zKw/6rGN391tdVutCG8Ci30XpP8jAbUkWQq75Qx/r8DEPFP/aFyCZmiQCsMXx4gct29zTaVS3E3wVbmT8zF1a2gkRA5spkUECB4ywy/BB5vK/0QrVc3LgLMpjroEMkBqlHo2i9imKKO5bL1FISzzXMvoN2mwkZQ1gj2E+Bt9nuKBYS4stqbAepIWnaqBpY0+6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32tEMqalnYinDgJiFrPy2hUA4L0wfu+x8SPLDRspAu8=;
 b=femdVmQbs7VPXjBo7tfh1rBp+eLGBtrE+ZFlpMHa+5s9vN6lAUd9JhMewpQUgAKZzOLVqLqX529aEYCxsfejsF1ENFq1xPI/EkU7NXfroYaZPR9GbTA1iRb6qxL4KX422KiPPclbw7gjWVuB2PNGejMAVLbKchIA8QDQGtkszoxiKm2u3MFsP0GEr5ewZUIniEPsAhy5yNL1Liy3X2nFBm1bxYFyx6/YrKOIqEvf0qFxSI9jAa0UZnwDmUu6ei1mGfa7Crl3Yxu6qVQXlVbDD/1z8w8OESucwSIpm0lhp8w40w6V5lPTwSL7i5+0Ifp+Mnw2k+wpXaErju2gQRSTsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 12:02:07 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 12:02:07 +0000
Date: Mon, 31 Aug 2026 09:02:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, iommu@lists.linux.dev,
	Tushar Dave <tdave@nvidia.com>
Subject: Re: [PATCH v4 10/18] PCI: Account for ACS egress control in
 isolation checks
Message-ID: <20260831120205.GF4157646@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-10-94426b96de73@nvidia.com>
 <178761377056.3197084.2573998749847027711.b4-review@b4>
 <20260830092033.GE24140@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830092033.GE24140@unreal>
X-ClientProxiedBy: BLAPR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:208:329::21) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW4PR12MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: 1daf9441-ab8d-4a5b-4b43-08df0757ad90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|23010399003|366016|3023799007|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cyn+oMEfe6yU/Hqw9qrGSWni2+t+utcbY7s7A8SBfxDiMPfPMgK6TAkoB+RlXZb4PwFwZOuSGaRZXQMHaSWsNXyXKsmQNwr+lUJffIBiqBbO6EdAJqyDbqmRSiRSJKjneZfKVaQ5FlXe32640t/3zVrBvwDz393bK/efXzfITGasXa3bzL70ySOY6zZaK9tc3qe5La5+oq/M5xdoL/wYK71u212jb6Xp5OysL+8BlPdUVik3PAKaQLyA8VLckmhUGHouvXmByQ0LW3vk9fjSa8LX658bdXt8zjoMGQ2GSzd2CB405zxVO2X3dMGQC2FRowAYEz/+6zoW3pOycBhqzsl1pTDbPky33r0yvxMB/ewgWFyNDadmvAj4/2zYBsLSBeiBLJyBTmxxU6appKZJH25R+hJpl3WNo6mzdAXLB4CDiLqhpMfXg82jeSa7jdYYANKhKTMAFm/b/yysgydoYTYLgdD1yo9i31+k8dB0AZi1KyLfMqppLB0ipS0yxCLC+NTAHbuRDHn0EzznPFugtHGa7MUhORBq8lAe+U8C4W8rYsrh3f5RmXtS3mnIY47EpTISo9Cz/icl/JOum0fduHbyT7SZwRNZm0KQs2I4zkf8bocDAb/tcnPJiAOna0Kq9z4jR7wZO1QwSpzZ+gH7vvUPvf6se3j6yulelumV9Ow=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(366016)(3023799007)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9qvSkyRkOk0DZmIT2309tnBrrD5Hyf/8VaNKl+ZOZYUngOzW3o/jiyurJrut?=
 =?us-ascii?Q?Lj8OlTldDxQexm//MTgZMs+mAQp059waJNJhFSUT79/KuqHn1G2N8vL7hdvm?=
 =?us-ascii?Q?RifBLkHbgzCz2UPMVQaIKVIIy340iJxalVs7tOYdHOAO2LpjlezNkeCOA4a9?=
 =?us-ascii?Q?q36XtYw649o1+Y2W3Dmve0prx5BVGAk9zIfSKy88yc9IURk8vJ2CqoZMEiNU?=
 =?us-ascii?Q?ADLmshHPt20+xxBhiGEGwsE3sTOUtR462sxHjBtvIKF3PwfeKphKBX9ieGOK?=
 =?us-ascii?Q?NoahKx/znxr2mxZrrFOI2jTm3lMNQdsYzM8xwKzvuvIgbRJfzvxUqh9kCFMR?=
 =?us-ascii?Q?ndxbulrk79lxHj7Shi4t6yilBtcNphw2VeiCelma+lz0zZUvoSL1bz+rrsEt?=
 =?us-ascii?Q?e4CdonjRBiUU19qYUzh2PtsSQEBFZ+zfxABeDBcev91J8OnwI3PnA2x77WGD?=
 =?us-ascii?Q?ib8Uuh2d/6VyqHB87PM9OvV3sgDbMKMT4OktNvMBO5MU0fLZmzfZJe7yTfCC?=
 =?us-ascii?Q?Myrw3Y2iUzqisCU9MadWzmNwN+SZqZNswVsCMEOlRC40A41wwrunIHqxk6Sq?=
 =?us-ascii?Q?iRhrdP51irgP/Qe6HFh5S/mVusssFeZKq9kyoa+eYt9+OqcwbUH1xrT3qxsu?=
 =?us-ascii?Q?yB1L+AV+uZnHX5yDejIpes/MG3u/mqLB7obnH+GPi1pLuNNaqJA8xuSRx00m?=
 =?us-ascii?Q?SGF0ojL3wjJIO5YWm7oJWuipnCzma2P/tK9OK5RalytTKnuBjMpVj/Wy3oIy?=
 =?us-ascii?Q?HUdi1k18R968VHGcLxS031O8lUCaZ2pJkhLGu9skHyIJZyYFDq5wYQQHh4J3?=
 =?us-ascii?Q?3fGc+jKCClxE2DqIDmANJGysB4osGeAMOZTk7aFeuSe21fQVEmXiCUefANpp?=
 =?us-ascii?Q?bM2zO+YynisvHVvhL/0Qweyx+GZqfeJMgMNSk5PDHWgiaIctdn17tlpcLHZH?=
 =?us-ascii?Q?1rDRdFFYyg94Yrs7LHVLi9dMW8dfCzQ1WPWfPnCC03DOdzHn3d1qOvEgR8hb?=
 =?us-ascii?Q?ifwMvsmk099ViJK/1Lz825OPgwkfOylib5UW2sYzMH07x5uYe4PmMHyDN4mI?=
 =?us-ascii?Q?LhZFWjWaHoq5n97BxEk33nm5UGXigf9RosaWTxyuwlIjI5uwvhGOumx3cM4C?=
 =?us-ascii?Q?KtFKwhjv4W6S06U9Gz8UOfMeRw2m93DHOcXwDCRs6MdfgNkxSGLioBJSfsQe?=
 =?us-ascii?Q?FXmhwBj14Col3L1ouSHFvlp2RV6VLurT/3gsyKYejxEJvKr5U5LRcYJm1y9j?=
 =?us-ascii?Q?NAvhPPA1dr3HSE0luZjljML/l2oGhpeNw+aFu7VcNTIN2TwZU79r2qU1gFyr?=
 =?us-ascii?Q?ETpCLx/h6bY+ooHrIG/Iz7VpWWS1oLZwA92M3JDEqs19PZgmKKKRdQS0b0mL?=
 =?us-ascii?Q?KqZnMxiXbJbuUd+biV8l6l7fFBZUF+q9Cq/2Ov0a7Ej1fdSKRrKDEP13jNuX?=
 =?us-ascii?Q?qOn0ilZ9nhMHETxqV+BPg5vTVFFEDW87vtPWnfHdVISwhlPoM7FEDNn7y3MM?=
 =?us-ascii?Q?lXnrtSk/0OrlM/vJ6xMPU/EXDnytbnOorJ1aUFfznhAKqY/WQyAK/dluCmna?=
 =?us-ascii?Q?Pf3CqNGveG8f1V2UeEMXDRIj0mH4bDqXS2z1emfaWk4NtWcAP5sF6xOUtNZw?=
 =?us-ascii?Q?DPeJF1cp3sS4O7TxK2mWN510ByB6mqAZXnJGDqDbqxy735PL5B/H7EhJuKZ/?=
 =?us-ascii?Q?N5zKguqXEFBkaIuovQK0SjJke/21lTOZOeFQOybRFGCSVPhC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1daf9441-ab8d-4a5b-4b43-08df0757ad90
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 12:02:06.6484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lICA9+onBgn4yvNHBD48sozjrZvL2Yc1dRzYi3fwYkGFfnPZFr0F701Bp57x45oX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6875

On Sun, Aug 30, 2026 at 12:20:33PM +0300, Leon Romanovsky wrote:
> On Mon, Aug 24, 2026 at 08:22:50PM -0300, Jason Gunthorpe wrote:
> > > pci_acs_enabled() treats P2P Request Redirect as effective whenever its
> > > control bit is set. PCIe r7.0, sec 6.12.3, table 6-11 lets an enabled
> > > Egress Control Vector override it: a clear vector bit routes the request
> > > directly.
> > 
> > This may well all be correct, but I'd prefer not to touch grouping in
> > this series working on p2pdma.. The grouping logic is already not
> > doing a good job with the spec and we can't change it because it
> > creates regression.
> 
> The longer we wait, the harder it will be to address this deviation
> from the PCI specification.

I think it is too late already. People already made HW that probably
doesn't match the intention of the spec because Linux works with that
HW so we are good and properly trapped now.

Jason
