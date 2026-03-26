Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013005.outbound.protection.outlook.com [40.93.196.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC4524DCF6;
	Thu, 26 Mar 2026 21:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774561889; cv=fail; b=P0EI/q5tuNWFaij030bkZzGOc/qrePpPl0YigrfEPyyP6NreY//vDtsa5ltsrRgn0bcp+OT5athgQS6ala4pXGDqV4fwwqu62JAUO3x8CB6MklxM6DCOAefEzCvkkfZE9KeTeb7MXUqXt612yYop7b0GQCrdVpoK/DLD4OZ+TEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774561889; c=relaxed/simple;
	bh=622YPnAQvIs89F+k/n7MNqyWLFx9Ks+vztLxe47h3y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bMbSl1A+OUA+O+kDg2vc3f2t4Ec24eixL8e/RCAsf3akpaiyzFsVRy2HgJJaINyxReAOzM+w2UbBeFRXhnzfWEKo5SNwcR4wZEzDDvRVAeLDL2CaCig+iZNXVERgbxLE/FGt6QiXth3xcwZIjQ5Vc/Kdd73k0kNkQEwOH0g+njs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t7ekeWA0; arc=fail smtp.client-ip=40.93.196.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t7ekeWA0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wx5NrXbvE28X+J+eXcwqkrcRusUaJKwKkMS61Pwg9O/pln+3e1xU/4PnWp/XAXm1Uzm2Qt8V0x+kbgH6b0zS5GO99aq7eWnXlfG+jN8M4rBz/cHmHtTcGzyjRXxfGrgMwEv1Bo53DpcpjMrTav0eTRew2HMCsEr2xbdnTNYqzrnXJ5Z3nVMdD7TNQxkNqPkGvkA1dDoLAe/PIqadqmM8vUXociFrcfvxdg1/9ZLmy45dbykgw5lhI1xUlza/1uJ/UpRD9w0oG3d0amjnTm7gusZ5VHkhCpDe6HlkjpOY50L3HRGkAyNdtYoyzRYopxnrmqIaZbgQ8vth5j8FZHIzaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSxekb7GZVdb7TEN6uXLZzRnGG5+eFAEFTezW1dkK04=;
 b=UX7JRHMn9on1hBsPI98nEQ+R7EA86KQ4NoEUB3JqfpLVPw87ZN5UB/oQeKr2TDx66hUUoUDGSIFEmvGwf2fcEifL7ZDsa9SSVkC7+j81tY9UZ6OzQqda0CBevB2Bx+G+SvNLzcMZCu+NFvKQO3SdOVPDsd+IaeTCI4uTN1gMR1gWBFm/Bv8A7idryqqnxocE/SnVFQMwib0tBaMrPnNdm12MWCagUVr987YUGu659xIa6UM8GrnZQVaAnVLsB8kQ2z1e5A5burRterWzJ8r/rlniLnVjRATfvQ0Ih6i4kw2OL6G1RsYcF7nZdsKCmBjW9SWad4buyrexRLU18UpzPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSxekb7GZVdb7TEN6uXLZzRnGG5+eFAEFTezW1dkK04=;
 b=t7ekeWA0GAxwXLCPaOO80byVqtkbHzSOoZjxhq5XVIRHPIxszXgoXu/3cUS0X5gRdQzCkcp9dhL0KPQcm6au1pPN1WphuG/NivT4gBkCnId2HCsZsbqAAzRmqAiWLyJxNVPZoEPw3xN2MvBoxOS/kF5OPkBNBXsUJP2yMwKbCoatxguqEE320MkPOeIelAJjSiiU8ulcVFw6pkNTwPZsN/6zRZR+cOtxjEI4OwbAweeicb4Imn7oyVJKBS0ILpCB0oAeobiYwmnHOxLtfT/kN6XOKwp4GRM39XFEwY10EZCoAaXDc7jB5cg6BvIAuKYRDvO6v+NKA7Cr1gjEPZg2kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by PH7PR12MB7114.namprd12.prod.outlook.com (2603:10b6:510:1ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Thu, 26 Mar
 2026 21:51:18 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%6]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 21:51:18 +0000
Date: Thu, 26 Mar 2026 18:51:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, bhelgaas@google.com, joro@8bytes.org,
	praan@google.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, vsethi@nvidia.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <20260326215116.GK67624@nvidia.com>
References: <a0dd3e4cc5260f55bbec5b3ed6791def33028735.1772833963.git.nicolinc@nvidia.com>
 <20260326213854.GA1348488@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326213854.GA1348488@bhelgaas>
X-ClientProxiedBy: BL1PR13CA0125.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::10) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|PH7PR12MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: ff63b225-9d5f-4656-7e59-08de8b81cf56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HeM8bdVQlggES0hR3o8FDcsIt3o3WTp7oTmxb9yEKdX7kaz+qKi32K79SdjtaG0oWEIoIISdS/cB9W0O1YJlUx+RN9S4QHj287ybwA8KPavZZSE3HPXoNrvVdSMLjEcxYxHu9TKUYnYaUpRPSV1a1YJJNAaOvlht8x8v585VyXcLJYd8aqsGNSYTx9wvAabz3acemuO4jkhlcZRGk4S8v9qt1SaXw6iCO8A3CHl8Af4HDdQl4VKzCsthkzmlOzrkFHCa15DcjY1+gjwo3OpfAw6Q5m0yNiaFZ0J4xYV5nr9DjnKJQ/hUoKxLUWOiwaWKXkUIOi23UC5Ompi8TCL73EQiN0VyM6hGWjEGywOAyzNwgAeAlCIukmUJYk4dgd5+03UDnRkNWwzoV1ZYmk2lMmhIBgkZq0BvVCVmm/L3AYnyk+CacphRFaUrOfQrTrbUcrWTcERgnkAHqevyHFst+RPrwtXfWADGvaFJIil+HPcjM5lBJh6XBcQZxnFj3HNCrBGs+7LnCDXvhQmK3fCiDDUKDyWGty3dwtUHB64BvxfyvWkWqYZI72r0Ao0i5XV+I+DS+H6CFWiESnA+nHyAJZ3NjJiCIytyPbHpDbEeQwuGLqG2d+FHNVfmLzn7QAX9MHRbhqN51UWGZvn8HhDIadq4kxJqP8oDS8cKxI//F9zkqmQgMS5zdcrvQU+yrNiTbUuWxa1HJyI0JDBzVUj1PPX7O154ugOO6vhm058X2C0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e/UVAIszi5kLwRqIALX22rX20cO3ZdhcVUTwSZm4fp4HJiaTVykE1P9eugA3?=
 =?us-ascii?Q?pS4fvjCbg3VMrKsWeKjnJjtNJmB0f0W69bgJLtTTa63GIjTfaHj/kgA7Wzmy?=
 =?us-ascii?Q?f75mcUIONrCYPOnnMjnFLBDn3LyVx9clhjTK7tJFUjj9Pf/A00i1RG5ZpvaV?=
 =?us-ascii?Q?sHB+lmQs8Ev0xNQMZ9eUCWHsdEdepVVh8EKNeoZFL1dnKyZHUoBHXty8/jcC?=
 =?us-ascii?Q?rErdFxXGGv8fEqvJLbgCFJGP0jWYhsCiQguA6qyQYrMPInbi/c8fjJSTrwQX?=
 =?us-ascii?Q?eIcBj1Oy0L57F0RtZw82x0IJpxwCeexaue/rNHaPWee0GMFynD62ND5j/BBv?=
 =?us-ascii?Q?gbSYU2Yd4lvD/o6ODd5cwXvhmltCFxqVWFVzkME+yOzalASkcOIVMDe5jQh5?=
 =?us-ascii?Q?65gj8qlNQbZPLIBMz9rR8I96LsabKk+n5QM3N0LKI0wLpFlCBqySNf5ENlWu?=
 =?us-ascii?Q?q2pNmVgq1CmXROOa9VYOaJXyz8Ixt6pTKKouzgDFMHe8Jbk0/REWJmKJNTEH?=
 =?us-ascii?Q?mDyHv6szdEfVvMuHMUpN/qGnQitBlkU2NPEHT9sZhAzLGs/LFurIuOmKWheD?=
 =?us-ascii?Q?+BTMiMyY3HMJc9yynlRYX7BPeKAlR4QDxKqcsYk3q5Gq9NBdemSeF8Lm2Mfp?=
 =?us-ascii?Q?H47PhNOZRXnUbMuvqwvafBZODj6/HfoCqZLEAcB3L8mk2Zh4ydNlXK2zHdjw?=
 =?us-ascii?Q?lsRG9nc4+Yrqs7ELTgTPd2JYDkBQ48PQVWGh76vCinnhL5t+sh/P0Pbn+fSW?=
 =?us-ascii?Q?n1SyOJHUVOC134YD6NM3QvjGk2tFfgi55rtd4I7WhQ2TL5uxBWgtME0l+8JW?=
 =?us-ascii?Q?HgEi4+GIFD8x7lX4S4kGyCm6srMrg+LM0imcX9PrZzL/pVoZFtld3Cz3AWR5?=
 =?us-ascii?Q?blJkQItzK/Wua2gAcIE4QlEWaf1Rk5VSERS7K/rKRLLuGW9ulhICnJPNUNtd?=
 =?us-ascii?Q?/F6Ef2oiKt885sqI1MUYgoqvCh5DaRswWrIAHJUsERgLuzuO+OlWN4iVDpod?=
 =?us-ascii?Q?JLBQlh0EGpCn0jlg8fADawzqMC63m0wjT4V6P9NbLSaFkQKb6DQhpPSWfYqD?=
 =?us-ascii?Q?3dhMCYdpQf40HSFjx5AwFJmkMYwwo1Rx05mGbpdzOpkKHxu40XSFFPD+LJdK?=
 =?us-ascii?Q?mUBV85eR68Q+GXVCpU+1QPSQtpxEWg7BWXZcTOffkoPG4fCRfAxSogUBQFk7?=
 =?us-ascii?Q?lfhNGTIxJApN+w3adwtORGiJXeQqoiJBHemADaOlQKufISxB9qjrMRAvbRwD?=
 =?us-ascii?Q?rnNbYR+afnWizTiH7Wvl6Dvp1LI3CFOHY25nKzRf8SsqdV0EWeind2jIhlsv?=
 =?us-ascii?Q?lDXbJ1uvaoYNPjvwzcho4wLlJN1JLPITF9u1DPjU46fJdyFsB6a+vbjLC+R9?=
 =?us-ascii?Q?BwaP4KQWliW3DIWVmqaqBsevUK9U/yC0lqcWIIi7ECrTqCeEej+q65oFEXn2?=
 =?us-ascii?Q?pCpm9CxyuUhtDBAT8WDmE6wgyUmj9KmL5Mwq2QGnFReTVSDlFery2ag7Fqgd?=
 =?us-ascii?Q?aGDUXa4gXcmvfv/u1RULfeZgruiAS8KCsAwpM+qNnzheJjXGOoqN2Dqi+KmE?=
 =?us-ascii?Q?MPOTg3/xUmGehPopMO87kB0odPFW7keip/wdek/jSfEXAsFyzwoB+duD2n41?=
 =?us-ascii?Q?W9LA5wEcfH9j4Vq+0VEyBhBSk7LpkAZbaecnpua0rgtqR0mfh7Rg132J11W8?=
 =?us-ascii?Q?jYyXLZBEezt6gc6juZvHYratWJSRhhyqcDYPMZwblANeWJHX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff63b225-9d5f-4656-7e59-08de8b81cf56
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 21:51:18.0997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HmLK5/SLmuzZ1G+XbnqTZ6P0SzMeYYg9TuS/41Gs82VEj92JbFIw7bp4L1+v+gH7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7114

On Thu, Mar 26, 2026 at 04:38:54PM -0500, Bjorn Helgaas wrote:

> It's only called from arm-smmu-v3.c.  Is there something unique about
> SMMU, or will other IOMMUs need something similar?

Yeah, every iommu driver will eventually want to use this. IIRC the
motivation for using the pci core was to make use of pci quirks.

Right now ARM is the only one that turns ATS off for identity, but
IMHO those are bugs in the other drivers to not do that.

Jason
