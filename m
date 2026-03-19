Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013063.outbound.protection.outlook.com [40.107.201.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3FC296BA4;
	Thu, 19 Mar 2026 03:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773890049; cv=fail; b=GoVx0WwvAlTd1FrqtsKTHElNQVN2Zyz/Wj3Hfbtj5r/DVK+MnyZa+dbiiKUOgiS2o5OMJ3m3jZ0aRgfHeGAgjxGY4pTf9cyDRX5vv8CTyP/NqFTdtpa5HXkrVAt7HMNZKIlGrLuBgN2nZ2Y0znqSVfx95LlY6/epzobKEqkwhEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773890049; c=relaxed/simple;
	bh=YnGyjGR8q9fw4nr+6BcG+KbQobopSi4HGqUGqG3s4nE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ly6XySUbfLXb0IbUqOrcWzAHWtbWvd/phUOE5NiCXSc41dxCOxaBoR9mQPPWe87njM4H9ZqETu3gIuOv+UFuFErjTTBGthNmIacaz/9Vyvn6cPwfURlsO+c2EWftdkSF09p2eTyqGURIRsRKyWrHk0THas/85SRs4uszaTNjHxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MprRPC08; arc=fail smtp.client-ip=40.107.201.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MprRPC08"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BpFi+5Sb0A4572FZ63TPbs1glURZ4ZOa6V0H3jPE7gulyU7t+ONblRcMQvM5RaaEfbwqJ0gnk1tT/5hYuTzc2tx2LyDZOdAHctlaEgKYkv3ZikTR6GdA+T6v0L+CaYjfI2A3YBBFjUGkbGQyX3eP/aGfcO32Anikh8xoGouJ4p/aP2S+rBi8qmvp7EQyWxRVzWCAJbt99N1a5nMK73/hQAi5s+zrxJrvu3x38NmxxIHyTEyeyAaPO3QlMrArsGz4tE5ohjFvENZIFpkFnJ9SWirb/Rh39gz5VwxgqxvykhPDudGjEacd3/ZNh2ot4q9E8bFYbTBY2bTGMp6xaJ89YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AA7iNrbw3fBN11Zrvh/hWv/xR7vJVCgjhH1fFELhgEI=;
 b=RueEj0/MzXxmdmcKoQfvI31uRei/tJNOckmiW34vMV6r0VrQ4h1waM1FGk+JvtKlhPvMv+hSxhYZ8fIhloTypibd+hMcIbk8VF6f5drVyRwsLDFQMVCVri7Gq5YrsAoIYEN+406KPcFWdydkVOHFsK3ketrEl0Rc/GkjbBmvUnKySxkY5bbhmQku8+Tg3KaaqOHGYcbsYFl9zLQ5yJgjVpCJ3QUVuroH7hPc656lMccRoGdlwzBgLWU3qO0vq/Tk1xCb2xIXcCz409EVTmNNM2UIqZg7B8HJFqvQxS2a4m6O5SD4mX5afUHzzNOp3J233TkR4sPowTFgrVz09mysOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AA7iNrbw3fBN11Zrvh/hWv/xR7vJVCgjhH1fFELhgEI=;
 b=MprRPC08/haUuGvoaUYJ/PC+jcIVCk62xlXUMeDtDvRJj+IPXyLyLQ7edVkxLONchruelpylEDQz3m80GVsPkwvCHQv6h/GDj0R0FD0uVNd/FkXRFZec5KJjlV7kXicccWfZlifpVlyERUZX7lc+Sdi2RW79mgR679qxtWQRv4NZe8jrmdt3/2KsKnNJF9t4LxazfMX9c/oLXtZUYc87OxetfyY/PDvHaIpyRndCeNm9rEq5+sYy2dCmBomErxYITYSA0GlNDKkKCCeL8aAS3I1e5I6BJ6xKpTPiaBvRi6mJkLYc6wHrjCQJ0AVAo0OEqzAMaIvkMLIuUnWSSjhc1A==
Received: from MW4PR04CA0213.namprd04.prod.outlook.com (2603:10b6:303:87::8)
 by MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 03:14:02 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:303:87:cafe::c4) by MW4PR04CA0213.outlook.office365.com
 (2603:10b6:303:87::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Thu,
 19 Mar 2026 03:13:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 03:14:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 20:13:45 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 20:13:44 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Mar 2026 20:13:43 -0700
Date: Wed, 18 Mar 2026 20:13:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
	<lenb@kernel.org>, "praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>
Subject: Re: [PATCH v2 3/7] iommu: Add iommu_report_device_broken() to
 quarantine a broken device
Message-ID: <abtp5izLCNuojhkf@Asurada-Nvidia>
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <c5390aeaeccfa86a1c79f26d2c0ff5df380940a4.1773774441.git.nicolinc@nvidia.com>
 <BN9PR11MB52765AB4CF7B9966D545CD1F8C4EA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <abtRvoEessOlRzn/@Asurada-Nvidia>
 <BN9PR11MB5276BA7E5C9D2F84C81383358C4FA@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276BA7E5C9D2F84C81383358C4FA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|MN2PR12MB4358:EE_
X-MS-Office365-Filtering-Correlation-Id: 210b9492-a01f-4a44-3228-08de85659252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	PVc7k8zYQqLEEzA6W32KgoyCtGbWQEfMXjwq07oezW0j3YcOStfTnVrSY4Moiuf/Eqjm6b96exVzt2sa14AjNFtgyG268tfhVaQGTI27JelLVYmeNs4QAEq1VQQnEwXKq3AIvTysUtFvE5rwyQuJg5xzznP6PRVLpgCtRy0ihYiQ8GwR3pbKoel8qt/wBLXsZjszAW0w/EyPM+5CGJf6JxZdVSqn5235HCYCL+z9VBYPjQSK3sH7xVcndO4twpd+4KfV5Hos8ejg5gyl9l6vU7GDB/Rr1Rv79WvYZGfbeCq8kN4lscgBpw46gFsh89a+e+TxXN7TWEMcvyA+btPbz9cQB344vm1SCYGVDtHZ5D6I0JDfTafkIwZZ6PWg6wyRjW3p4cKDn/wcnTTKhyxE6JHAdTTEDYB7XLDBKmA2QaurUSfON2Fqq2N0nPDJ3N1WEJkZJDheKBdPYz1xMhllF+zrjpsskhiink54zuifG0tnyIbOy7NeKWks6r1NRNK5Bl0EJtmxKNe8qdbNnqQh/FYM+LmM+cGUy/UeLaOBanohKo24z+XbwsQFJ3pTsRh6rI+E2tZWlsDANA/rc5QnN6xwiyIKvM/kzIOwQeQDOGVu/4dXcngdvzzupKfGPi8ykMYvDqTdi2FuLKu8XLP9JUd4jbIxI+NXE5+JJpkx0uAg2z335TZwium+r/3uFT5bDCvPZ5rg16elQyYlQGW3ZhDKbogRrb+DprqX2patktNWq7YZWwg57uWMBnW6Q6ZQ1jGG4WxAlyTyFcPnKsVlUg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WAWIwwAXa813hzEjcuOZp8OfUPa9WRQDJdqsYd8Fp+ZxCLz1jvuw+bDo1MwR75OfCJqP3jOiDVDUqi2f8c8JwXYQd6wNUFdP3d5DLniOjIz2ijDnZQmvPoCSO/MHfJyz3UubM974gVLLnb9eM3kpaaW4OfDS2LlqfDe3yUdJ4vfUi8dKl3eCT71OQhnzXrIrjKFsRXrryJqya83X1/+5XLMt3aHbDgERabtHWaAxx1bOxLEsuoz4xZTDIyT5vAEgJlDSpFjIOAPAZJMkSjDhT2mCkILVkLMtuVv3C5NNAxpwPpUYm28ozo7sDjWSbUbPfxmsvIo3YfeGTqThYrbf8BrzZJz1iOaD8GTnVpu8MrSvor2N4D5QW86ec4Tl33ODKMZtHuKM0mkHRTxczHelOkar7zPyvOmX0ySK6fKIdgiEKeueHiKuUbyj0PMxNDYU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 03:14:02.4780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 210b9492-a01f-4a44-3228-08de85659252
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358

On Thu, Mar 19, 2026 at 02:35:33AM +0000, Tian, Kevin wrote:
> > > > +	scoped_guard(mutex, &group->mutex) {
> > > > +		/* Do not block the device again if it has been recovered */
> > > > +		if (!READ_ONCE(group->requires_reset))
> > > > +			goto out_put;
> > > > +		if (list_is_singular(&group->devices)) {
> > > > +			/* Note: only support group with a single device */
> > >
> > > this series is about fixing a vulnerability. Then it sounds incomplete to
> > > leave certain configuration still under risk. Probably we should first
> > > ensure ATS can be enabled only in singleton group, just like how we
> > > did for pci_enable_pasid()?
> > 
> > I understand your concern. But I am not very sure about applying
> > limitation to ATS support. Would this block some existing cases?
> 
> what about just throwing out a message to warn that enabling ATS
> in a non-singleton iommu group may suffer from unquarantined
> situation if any device in the group triggers a ATC invalidation timeout?

Yes. Baolu suggested the same, we could move this condition into
iommu_report_device_broken().

> > > > +		/*
> > > > +		 * Quarantine the device completely. This will be cleared
> > > > upon
> > > > +		 * a pci_dev_reset_iommu_done() call indicating the recovery.
> > > > +		 */
> > > > +		pci_dev_lock(pdev);
> > > > +		pci_dev_reset_iommu_prepare(pdev);
> > >
> > > let's rename it to iommu_quarantine_device() to be called here. then
> > > have another wrapper pci_dev_reset_iommu_prepare() to call it too.
> > >
> > > this path has nothing to do with reset.
> > 
> > But the implementation of that iommu_quarantine_device would be
> > still to shift to resetting_domain. Perhaps, we can rename that
> > to quarantine_domain or so.
> 
> yes let's rename that too. the purpose of this function is clearly about
> quarantine. reset is just one user of it.

OK. I will make it happen.

Nicolin
