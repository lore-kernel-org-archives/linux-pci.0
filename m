Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011069.outbound.protection.outlook.com [40.93.194.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE33259CBD;
	Thu, 28 May 2026 18:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779991226; cv=fail; b=Pvq4m3ECwvUC5KgI4Vdj2mt8Zf9CwomAo5CrRSKbf98vWmDHM4w/LX4zPZl8MKnb194XEaXMbMDJRdJDw0No4kt/8g2vBz8/LKWtreRrwuyZqlqtibtJxRalINYXElfDsumhpr7T13CQESM95PG34CAkzgKECMdvsQjA3t+skTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779991226; c=relaxed/simple;
	bh=rKssWHfeVieaEeHuM4kJ3seDiS6CduyJ1AYfIC3rsCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OdHgN44YhQvBtOfy7fGdyh8J4Gr+npH0XWlw9L4jeKlWkxzGFn/YmHYG84DuwZAm81RTVtgq1O/JDySCb+c088/86M6mxT5B1XAp0e7jQaw5Efzsyq/UJJf7xvGeNhWGgyGUWRLNPAJX9SGp26LW4tBPOjcnQa7HvJ1lwpqzSGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qa6O1VmE; arc=fail smtp.client-ip=40.93.194.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qa6O1VmE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJaRRPxqcIoSn5/l4m9leTUY4KS0cd2PYEtXlkcoIyY9KQXR29QQFLvewohwjw2JyKZo5tkkU0QZMh5n2VCEtPoPBSfqPJTwFAWQGwrz6pScicT0M6VBHqoryiXd3EgeM8q9G1fhTjC0rMc78+PUrTKl1IUJdGHDoKdm/NuRBBW586eafBT5iGv+Gtod2FvSxUkX9wtNqQ8fvempBYOgzNe1L4Il9IrGLprgaRaMdwYF87MWhntcw8QFZe1sogs1cR/YCMgyVxG05i4AHAVL1zfPE6AKrQ1UT3OfKHsIhX4C5srg5LlqQJnk2scnjeoy9QLpSC0esVtA8u+ywJMpdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLtmPVRMf4S3y7Z+8yTD283vsq7I2KJ7f9qkhDqSMFs=;
 b=fWNqlzlHdSD9f1OfZW518s30e+yIWjfVDNQOrSbn2Du04Pk+fnoHatAsRdH6S8lPwi6qNSGOFLG7a5mQN5i7Xpgbfml83TqqUgg75OTPiq9ZohKF6VM1U3qx7xw5TtFyXwShtFlWUf+kHvHpOUboVknEq9GkDdwJpw5nQZgDvSPS12gH1k1+41x62vYSRYDA99O9oKKroL/u4gl4gyLl+TBqNHh0a9nT+oVbypLpEbtRdpw44nO1+L+qJaUzmFgDAEc0+dKSM7Jq8P7rkz37yBwNH38EJMklwTiGve5b+z5ZenLXUFY0H2gj8IDx6cFW1EMwN4fOwEh6iXCMI13kyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLtmPVRMf4S3y7Z+8yTD283vsq7I2KJ7f9qkhDqSMFs=;
 b=Qa6O1VmEToVtzvRE7oFfpj4i/8qtgKvSlyoVQnyZi0sSAkVuZvn72MqdJ3Mdkrwe9xeBxlwBp/oRAUGBSaqBqllBhtR977wH2wjisRrc6Rz/UF94tcznW79zQCYto8wO3+IXHoleZpeTkt+Jt4ZQ38O2ZeWgRb7xvpZRYZ0uOfRAuj+qCFa0m51/pFh3wAhkKIJjOwCFm/+T/CPBp7aiYJRaUL1iPn5QIBbStGVngG1nqio7CSAF+POgW+TbgwqdkII3BtQPIoQmg1Q/Cg1b8nld0JGzRub08Py5NrWhi5FVezqb88jFRHUbuEJg3fpXYmIZTXFX9KHegt2n6mIB+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA0PR12MB7089.namprd12.prod.outlook.com (2603:10b6:806:2d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Thu, 28 May
 2026 18:00:21 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 18:00:20 +0000
Date: Thu, 28 May 2026 15:00:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, bhelgaas@google.com,
	baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, vsethi@nvidia.com,
	linux-cxl@vger.kernel.org, nirmoyd@nvidia.com
Subject: Re: [PATCH v6 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Message-ID: <20260528180018.GB3195266@nvidia.com>
References: <cover.1779392420.git.nicolinc@nvidia.com>
 <18bb6f421b3be891caa8f1fb50f3a4d56b52d5be.1779392420.git.nicolinc@nvidia.com>
 <ahheOF8L0aGMttcI@google.com>
 <20260528152930.GA3195266@nvidia.com>
 <ahhuFw3ZJpy48xkH@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahhuFw3ZJpy48xkH@google.com>
X-ClientProxiedBy: BN1PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:408:e2::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA0PR12MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b0b436e-6d78-4f6e-02c8-08debce2fbd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	D1449oyTxnsWjS4MUNMHxrncsf5nIrNFkO9W0aswxCqBL2pF13aY3gJC6+fFKKTgcvwtFi7xI8f9ZHp2mzYm1yht3G2miwwFsK+FQV+CA0DaPQ4akNRdv4hhwAj9nZc87QcEzoDIXV9qlQU0eeOCJIOEvtftG3fu2ECkwyh9RJwubGu/tN1UlBg0Nrr+HWOCwBYQI+lqSciUjUazWSrGPKXlA/bledsCtP4LuatXcv+3aoyvFhEQM+7ytOUBCYD1EmGqpAXmIKJWeUgZ4EF90bWvhT7fWGmH0TsN84tm/CAtQ4KQP4Q0dYlqJx7IUQpC0qInpcs2H5D4fLn900ZV/piTQyCPC73LoTaR7u4+sOdFHZKzKtvbzG2NSUVp3uxE12CNhHa9M3qN+eE2s5P4KkmWaKQ1sKEA2PpARiAnD/Cm16GBl92AjFEBS34X06k1/E+3MyxT8lfxhsPyPC9zhf4DVnJBfrino3bnnP5awScXDThJlcmqdG/NEUeQGWmJoS94QbIrXalpGWmKaM+scThvgs9S5SOD7mt6x/zOLf8nhRwgUSfLy4ax2RoKU/jRWcUeMNbHDOnhHsCJpMLOWzdB8ECSIqV783BsM6GwGxKfCRB+jYMH5a5a1zXDGbvPy8d3n8ccLmLqSLh2lGsA7g/Zps1Uw+kL2H+etPr8vE3O1eiUJCXTCuggGyXEIdg6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WRDT+GT9I9wqPyLHW5l15hQnevtThyl4kb5jcbZuLMdsjyklYsWgrHTS0RH9?=
 =?us-ascii?Q?JRjC1Z2l7qxU3qyiSxogm0zgkFzFge7o4xaFZi9EsxrV5zugs+wndECF+FnY?=
 =?us-ascii?Q?vAhwyorZVGMT6TqljW+qVXeXIV6ziuBcTL3DHo9SuiVyk0kFknJFg9AIOqL/?=
 =?us-ascii?Q?4A9az416rI/7rGjAfvVmwFLxUQYgztUbYGX2VTMswd/Y5WlTs66dRIcbQcMw?=
 =?us-ascii?Q?nf7KALA1Q2lNF5nO88WQ9Kg23TZhDmclpj8Q9zKRiioE8/OZdnEnU6QPbnSi?=
 =?us-ascii?Q?V5xBmQRi8eMp2kvHfrc8iJgKrXby5q/IKIe2T6FvZo9kLNLh31CCMDTgPIOr?=
 =?us-ascii?Q?zT8WQQHOuLo4XGqMsB1zuKscxoYBhmGhKc1bqr9sLsfDd1Ld0PE/dDWSeggV?=
 =?us-ascii?Q?05jDjl+ycgsjw6rvj9E65qqHAvfZ3JxIjY0DpLyx4qXsg77BJAp5z9/2GSKq?=
 =?us-ascii?Q?TUQ1dX8OVDqxsn2/4IdWYioMq08WOu4Z86MWNEEaDr22qS1F+yXdK4y6qbJd?=
 =?us-ascii?Q?auaIjEV/cUUXinnB0rgU/45vWBqrGRSK72ven8L0vu65oGZNQIBbVd5xZtpP?=
 =?us-ascii?Q?XBNsg/CICBpos2jh2tlvwNOrLEdt4YyF9GKIhT/Si+p4qpTeStRCu2scsd3a?=
 =?us-ascii?Q?IdGLzsWu8ZjpfxI6jmVwMmBARNCwMxZ1gtVBUnHYPeg6w4ptc8I4F3e79Izg?=
 =?us-ascii?Q?5lXjC9ZO2nUf2egFSXh97KbHMbDj+nzkF7/pVUrrdzm6Wa5en74AVSIIQ+Gn?=
 =?us-ascii?Q?4OMbnbIHslbyQRaEXdmi6FGyvJUW8WxuzgusO9+5fbgBa7xbFxKyjEjcyz49?=
 =?us-ascii?Q?RvONLPr9nomiIlx6lf9u91z5kUVNHPBrqpsaOnY/DcqwBaFfyEs4pMyB9Iep?=
 =?us-ascii?Q?gh2s5Ae+9QT3ynH6KyYg26XV+kmtMKjtMp4px1x/qTD51U3sS79pbOXYrW6D?=
 =?us-ascii?Q?gEptt2qrhVrJO82wGPP8zFPrt1P3aHCk/hrkO/DRuq4BAAtoLkG/5xkcTDz1?=
 =?us-ascii?Q?lvfwE9B2k46JnXcjZj3eUmEcYsvM7g/Uk6V4SI/Bak+i6s1k3QrB5U9Af8TF?=
 =?us-ascii?Q?Ka2pNMfAq0pnrLzQbg/GKWqE1tNXpCU+a93ZabFRQIwTfIih5eWGaBmk0xt0?=
 =?us-ascii?Q?Yntish9uCAvk6ToNhTeS460MF3WPpJYfxcDYMcQvPDd2UWJsi3Eglf1XGo3a?=
 =?us-ascii?Q?wMLZ3ei4epHlpboUbJOyuoLDpFdKbDmuKPjIRAmbwNGQmRLBv0yimsEXurIH?=
 =?us-ascii?Q?QKQhBhyLiVU0+es+5cOP2SyHIvM4jZQ5Q1i7HOegw/qUPC78FMqs4Smo+5lU?=
 =?us-ascii?Q?PVdxOLJunkOb2sp5D4zylLyeE0sv5NZeN1ZCfESGoWj4CVBwV99sC/aTpbgq?=
 =?us-ascii?Q?3Md1gPzkNX02dv6nKRFZT5qrN4prUIyou0w+Ehvy6csJlBKZ+MnKVqXy2st4?=
 =?us-ascii?Q?Iqzdnr1V3MkaQsCSAWUI2XLCRgVM21XUYM977H4kXAj5nZuPVZRnMwerwBmM?=
 =?us-ascii?Q?Q4N6Eh9x3LUy8FvyUumD7JB1ta0guLCEmGw1rnazZpOwXJP31afkoqCFMDZy?=
 =?us-ascii?Q?CsLJygabz9PaWPWRiFiati7y5jVr0ULIhb3qFNE9XnTS8PhVWNDlDoEYmbQN?=
 =?us-ascii?Q?JCdFXijKSCX2TDxP6dlzJ5o/rFg+bBNPmXQRMcj9OUK/pUmlAitlD+XVUqct?=
 =?us-ascii?Q?kKf0I4jUzu5sQV01GGH45EfsVAgKyKN38Ao2A533DAPEHRFQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0b436e-6d78-4f6e-02c8-08debce2fbd9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 18:00:20.8697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6NP7IzHfC2U+As7ZnHG11aEtmW5LJc1OuZpGhN6qo0/k8UBZifjXIvyY0l7EKY9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7089

On Thu, May 28, 2026 at 04:32:23PM +0000, Pranjal Shrivastava wrote:
> On Thu, May 28, 2026 at 12:29:30PM -0300, Jason Gunthorpe wrote:
> > On Thu, May 28, 2026 at 03:24:40PM +0000, Pranjal Shrivastava wrote:
> > 
> > > > +	master->ats_always_on = true;
> > > > +
> > > > +	return arm_smmu_alloc_cd_tables(master);
> > > 
> > > Nit: I'm not sure if I'm getting this right, are we saying we *need* to
> > > allocate CDs for CXL.cache cases in the probe itself because STE.EATS
> > > requires Config=Translate with S1DSS in bypass?
> > 
> > Yeah, basically.
> > 
> > Effectively the ARM rules for enabling ATS and Bypass together require
> > a valid CD table pointer.
> 
> Ack. But do we expect transactions before attach_dev? What'd happen if
> we don't allocate CDs here?

It can be done at any point before a non-abort STE is formed.

The core code pretty much does this immediately after probe so there
isn't much point in moving it later.

> Am I missing the fact that CXL hardware could be already active and
> using ATS after the device_probe succeeds?

The STEs are preloaded with abort when the driver starts, so that
should not be possible.

Jason
