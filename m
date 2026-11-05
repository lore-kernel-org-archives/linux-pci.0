Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793900724;
	b=eS8RjHy5k3RvmZW4yyVW/xspfn8vpTuugmXbE8h3IyYU7L1X50u/6SNNXCJ/vHUzg2EN
	 zI8iuuKUeqtVW4ZoFgZGgE05F6bXFe8NPJ7bYf8osXjgTSeuB9jQ8D49k48No0TBtIDI9
	 BdizuA5lBxrDXeLva1Xn2VeOYokz2EBaLX7FSdomqFKTEBE1OTXFUgA8LdXf49BGv+Iwy
	 wPsd+a49Gxheq4lsZqv2sJa7iWlQ+TSGHAWuMFFlSAac5TduhwJRE5y/IqpodJX2poKOc
	 Nz0pKJw00uhXGRz6TXnUegpzU0shN5WapH7V6RvTeCHe6VwvY7GaQejJPnF+mLWhNNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793900724;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-NV-OnPremToCloud:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Qzs2U1JxN/gcqr9rlImwtlc7EXXTLf4lHDlbpcuaqBY=;
	b=shnw/rus7ZsoFCHJElxVhu11bRJ15XTc5IObO35F4OQ5wapwA6o8AKWaZ3BwxSALUw0m
	 lFMRguyyJJlF1dVVzgUi1qySFxBvQt8lXuEKyF7t5Amo0FKBip/yYyhbBRZdGw8K0S2Ia
	 aQ8uJX4asBa9Fjk0ycEtBS2bjlhsEfxWNdpis9epIJbP9hH5DNkKgw6pKoSA4kg5XsdhT
	 inOa4JKPm/tHrnB9VoHo7T3Q7jHLAZtPy9mWwYtTmYZjVMDJMND+4jJBp7N29YMugqM7r
	 ieKGK6+NoqeLEYA9VNZMQIdonqlArOLgFVkxsf3UwZn5DmJjAqbNQ/eQZMEachOMrmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nvaSF4yz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.28
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B990606A32C;
	Thu,  5 Nov 2026 17:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B990606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nvaSF4yz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NnEfB3x54H4UC0LLS9wkqQQuVAaF2zVxWmR4sGdzxeTHEBFA4+guVXE7JjjeojKGBK9NYNFMsL4tOf1MFZ+9xwg1ROPqnJ/arTOZcfZ4YaVFC5V+miN6tO5DG02iplakjrpRUzwazChB32UXP1F1oHtwcVQAEFDyIYIFXi+ZFK2w4K8CBINmh+0L2FdPf1BaFxNHtD0k3CGPbXw/ksYsPGaj/5vu0YgkPdDY2b7zMGnaUdtTAYcwesecFYADUagVj+kPXIdCik3+Br0frSHvS4mTmvbvfu36Frk+540LmEYo8rc9foLBqQ6LHrBEg2lV10phCbFADet1rsFdJCOsxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qzs2U1JxN/gcqr9rlImwtlc7EXXTLf4lHDlbpcuaqBY=;
 b=qoucA5rEkoih3f0RY8Y1n7vl3PPv0MUAMrJUcypBgALSb4L9aFtirmjrAjSBbiZHdXMbfZw0njdnOfR7pqlkWAEoMBqOz/Yl4SFdeYmuDRL2jCcRtmEDNb3O4epAYDUdOydRcEv3X5zqt9FUv/jnNCRztRMATdxJ+qbutTgDnxmQ36arOuC0mMeAXxkm3a/9sqJ0W6aN3uqvNlbs3sQOTP9S/BwfX1hB1ilHK+G7jqnqEyB+S0VIX/XLi41tkTMX4wWkcA0Cbm3gXTqWs71QpsP5E1XbjE6ZkmGz3W/TmaQQMM6SNNT7S2MLM6toLm0PMa/sIK0oWt1Uct3FPHZevA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qzs2U1JxN/gcqr9rlImwtlc7EXXTLf4lHDlbpcuaqBY=;
 b=nvaSF4yz7lSPi1uhN9L0bYsTT+hujtPKC32gxe/B0bwsc7yQ2yxsn+OxSL6D48FxVjjR6pZamQPePHZCJiMUoXjkF/rFZ1FZNcyFy/2FBHG0zKI485XGJlVjqLci0cZSuKO6t51jJQTtXuNTy3pAA/yq/F9FdS/OREbBd+6g1ADxajwma0oh9/MLaDdIfVFjSOEe1CH2e2e2WTmmgAVS6zx+UA97dLAb5U/daRhJtDoLu3rdm2HC1nQaD4TafiOWZL1+eN46a4ZJncyKL+qTHS8yft3cciIKmas8/BGkWdGgz/cyyBZWxK6vqppJMh8rEhTXiSjQ68FoS8Agh8uTUw==
Received: from BN9PR03CA0943.namprd03.prod.outlook.com (2603:10b6:408:108::18)
 by PH7PR12MB6660.namprd12.prod.outlook.com (2603:10b6:510:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 17:45:18 +0000
Received: from BN7PEPF000000A5.namprd05.prod.outlook.com
 (2603:10b6:408:108:cafe::7b) by BN9PR03CA0943.outlook.office365.com
 (2603:10b6:408:108::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 17:45:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN7PEPF000000A5.mail.protection.outlook.com (10.167.245.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 17:45:17 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 09:44:52 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 09:44:51 -0800
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Thu, 5 Nov 2026 09:44:45 -0800
Date: Thu, 5 Nov 2026 09:44:42 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, <iommu@lists.linux.dev>, Alex Williamson
	<alex@shazbot.org>, Alexey Kardashevskiy <aik@amd.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Jacob Pan
	<jacob.pan@linux.microsoft.com>, Joerg Roedel <joro@8bytes.org>, "Jonathan
 Cameron" <jic23@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, "Kevin
 Tian" <kevin.tian@intel.com>, Krishna Reddy <vdumpa@nvidia.com>, Lukas Wunner
	<lukas@wunner.de>, Robin Murphy <robin.murphy@arm.com>, Samuel Ortiz
	<sameo@rivosinc.com>, Shameer Kolothum
	<shameerali.kolothum.thodi@huawei.com>, Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Suzuki K Poulose
	<suzuki.poulose@arm.com>, Thierry Reding <thierry.reding@kernel.org>, "Vasant
 Hegde" <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, Xu Yilun
	<yilun.xu@linux.intel.com>, <kvm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v8 13/15] iommufd/viommu: Allow vIOMMUs without a parent
 HWPT
Message-ID: <auzAivzpzSUHjEQj@nvidia.com>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-14-aneesh.kumar@kernel.org>
 <auuBjRjQwXl7UvvO@nvidia.com>
 <20261104193139.GB3889730@ziepe.ca>
 <yq5afqxf97a1.fsf@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <yq5afqxf97a1.fsf@kernel.org>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A5:EE_|PH7PR12MB6660:EE_
X-MS-Office365-Filtering-Correlation-Id: 54cb11e0-a066-4517-c3ef-08df3b648e1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|82310400026|36860700016|11063799006|261022075727099003|4143699003|261021121427099003|56012099006|261026140227099003|261009223027099003|261021135927099003|261028144727099003|261022105027099003|261102123227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	S5WpNuLZYts4Aw+82HFrSBoE5JtvGqLV/wqvP1b7gzzSNPOkg6SsRFeaoKXjosp+Y72N93JXz7lLT8nHIcrxU85tPl7Fx2giU6EgxQYywAXpScRqy3cDndS1v+Vq8x9Vf7CfHWzPyGgDvjJELkxGHX70JHXZ5e89scITADZBEDvjUnDYxscN2Z8wOPZOURrSfwbyL8r3wvx+Wj/SLlkkJvT0bE1AHLMY6/dPnuXsEzEWUuulE0WDgY8OToIeA6lEROR5Z0OH1io/lI7Ik2V6/4zQy9m5/vVQUd9BkatdG6HNL6OzU8aF0GluXwg4DrfFzadrO1nGPwHbdojCJRJSZgw/4iiAUP6VXQVe+DICny3K0imtkl4pYZ31tP+bXasN9dWz7dbPXEg+5Kb+s5vTEAOMwgYlZiHXw7ONiUd0S5SFebkL2ZRfElaUVkovaHoJu9V1bmQPawRyiU8bYJPEfklOqsRgzEOTdocyQmFaS05foWk+akrGij4lbc5jv6T9SOggzHfBgtkxDSaBoOCliAQRRSJcPV0LDwkMEfMIomVO8CyEZKFWOD0AL4veMj/UZMxkDGuGoW+ePMEM/ozY7q++v24dn3OJsFuAc4uQRzAzSmVIaIopB3QTnPLrQOK6/Jn00cZd0smhkHz3U07VMpQFun+dyWNG0rYgu+O/rzTR5n9/GsRDpOyJIHPdGOshgeRak5hG3BSW4m423Ol2zw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(11063799006)(261022075727099003)(4143699003)(261021121427099003)(56012099006)(261026140227099003)(261009223027099003)(261021135927099003)(261028144727099003)(261022105027099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	d8hVi+JscFBs+QaBybuTlRigcLAcKy2HynGk25s1LVRsOE5rH98CtxLmjNcHxqQzJVqFn0JhZvf9952aEP78Bx4yaD6crkAra8gxsc9XivfjrLsnbHKu8jusPirxlodPWAdymUfJBqKYnBlJblnPN0ZvrKVhFOYv1nQthLfozvahNhQYpsVJyFqdhPvTRCq/tK1W+a6UfcmEA3fN7220E+wIYM5RGrXxFJVTXXR3io0ihwcIbv7C2PuWJQahTJQ5iYJEQLpyytRfnbZ4th3Z8NZOC1nvUKZ9GkkSc/rCyqj4r9/OpdpvggujAgJnbRcUqOk7bKM8nQklnRgBhGJSvdBB5bAyrjvMnhqSpb4Bsh85aHMWJtPE5YtMhB+50IMDz7vqMF7zqz1dmcHYpTXHQXu0OcBMJoxB9N5QarM3V6A25hBnOsnLy2aChDGMRbzM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 17:45:17.5609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54cb11e0-a066-4517-c3ef-08df3b648e1f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6660

On Thu, Nov 05, 2026 at 10:58:06AM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> > On Wed, Nov 04, 2026 at 11:03:41AM -0800, Nicolin Chen wrote:
> >> By dropping the nesting parent from VIOMMU, it just simplifies the
> >> attachment to an S1 paging hwpt, right?
> >
> > Yes.
> >
> > The VMM must always maintain a S1 paging attachment that is the
> > identity map of the VM on all devices, same action as when there is no
> > viommu.
> >
> 
> I am currently creating an S2 paging attachment. This results in a
> configuration with S1 disabled and S2 enabled, which is used by all
> untrusted devices.

For validation, that would work. Yet "no viommu" should would be S1
paging, i.e. hwpt allocated without IOMMU_HWPT_ALLOC_NEST_PARENT.

For reference, QEMU has this:
https://github.com/qemu/qemu/blob/master/hw/vfio/iommufd.c#L467

Thanks
Nicolin
