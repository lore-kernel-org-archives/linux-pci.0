Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012061.outbound.protection.outlook.com [40.93.195.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BDB363C62;
	Thu, 21 May 2026 21:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779400791; cv=fail; b=q3+DxpEF9aoGWYf8YXuSKcvF1liIiNT7vWHKXQKltH3HQXXRm4gDwnvI4WesrIJpXn2TdnP+qBquTQVkvf65WQUjE7adUt6ezhlLLgvWbS9qPqGeD2bRFMlPt1bjoO5Ou9bzAXzMPHiz2qzPWa8wNJINnYHLtWMyYeHObjfXUt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779400791; c=relaxed/simple;
	bh=wwf4BCxlKGGZ4u1wRUNykm5q+nyZplb+nkNYTVVUPo0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvJSal6r3NiBc3yuwhSk3m3HrrsUYogcD89oN7EX+5guMIPeHsu/jDsGsf1+VGRpO0u0tdrPJMXNpf8Hwu0GDBzXDiOvEfq2grn49+LCHNZp0OJ6fJK3bQ16GjLSkU8tKFRB5mpNoj7JKOWAVRFxRR8D6BXxg5DUSuP4dNw0NdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XM5d9U+/; arc=fail smtp.client-ip=40.93.195.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XM5d9U+/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXEBhyRdN5LzR1n/6fZxwyH+mHPhA7dBAq9xCpTq7NBF+3iR+PQzLJkut92luTrIn+szrI97y9TBvh5u+gM/3ZeDvv/gnLxdJXVt9ae34VtnB2B2lvymNMBoZYLOkYdMPDgPc2kMUcb/7NUH/WK1DjfNg6lfCLjfl5BFpdgLOzrYTkZAvNjBOjogVEVG8MGdYVKBa6IbhMBKUKe9+H57Vbd88aX9D6B79LEGY6YLvF1z5d/nJqtTNQ8ODGNsO1+jMxWtJue7k/nHcFkuqwqc+e3wrNqv4kz6dFc53PX/ur9FMlGwsPGnseyIdiqvvw3eSjpF8dzgAAe36Dr3PbDoHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/A25vY2wwu+FxkZChatyc454HcHMRVq124kDP6lHcJA=;
 b=ZopKXVJM9HgWABf7h49sife2a2RcxThyS6dZR7aWDGSl49i4eU6Q9iXgtWzLsgyfj/tzB3AbMY7AAmuVMt8u60oTzslIjvAvzHVV7EpkSFadLXwbgbLUcR/9i95+lGLsog9JmMbTDF4Mjghj1Nn484I7k5Id6ef4eStd7AmHhfryyyN2OyTkVv/xpo+o3t97qFU7dzxskDKDIR3SGIqIDfJfLECXFJkO2r91ATyPmsrvtEVt4SvfnDJYqi06jELWziicfgQ/Bo8xX7To+PtjNXFpJVFQToiYM+oJ8TaxLWI1KLgHD6/8DQ6C7uiDmput1sWew0OBRo9srQXN4b2gng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/A25vY2wwu+FxkZChatyc454HcHMRVq124kDP6lHcJA=;
 b=XM5d9U+/50TEZ2WdPUIgxSAEIc/1PimdkOhQmPD1eC1+NI983122j5RfthGwbMib/rAgJYQkTG6p8hFO9Ngn0WoyewN0l8MP5spOmSCxHUQvanl55FXMNa8qV3rKBQnnzVGN7EwtLfqbBRudy+v02S8t8SuoAVFc1PsQFN2NDHErxh1cyu5njSPVPWXX5dfsmqej6o7cXO1rYv4hJbrDSnOaMCeLl47Cvh5VMyUnKsiHHW9xGuGzw5vizyHfo8/wd0wQ4N5dNE0EC7XaZN7qPcYgYl8UKZGYQhreX0c70x1mwSwtg2w7ObNfykMXHGABcSe81v/DYPuA0UrjQvqW2g==
Received: from DS7PR03CA0103.namprd03.prod.outlook.com (2603:10b6:5:3b7::18)
 by CH3PR12MB9454.namprd12.prod.outlook.com (2603:10b6:610:1c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 21:59:43 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:3b7:cafe::3b) by DS7PR03CA0103.outlook.office365.com
 (2603:10b6:5:3b7::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 21:59:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 21:59:42 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 14:59:28 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 14:59:27 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 21 May 2026 14:59:26 -0700
Date: Thu, 21 May 2026 14:59:25 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <vsethi@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <nirmoyd@nvidia.com>
Subject: Re: [PATCH v6 1/3] PCI: Add pci_ats_required() for CXL.cache capable
 devices
Message-ID: <ag+APX/6seVWrpvB@Asurada-Nvidia>
References: <ag90FlOaljwa0qqU@Asurada-Nvidia>
 <20260521213123.GA186424@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260521213123.GA186424@bhelgaas>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|CH3PR12MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: b6fdac66-e07b-4a21-74f9-08deb784439d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|7416014|376014|56012099003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	wxYe/OpKAAblObq5pQuDuSiY/LVEGDr6vUDCBgqXn4o1NA7K3e+fk+igfG9EYEdgCIJthwpt1nQCsIQx1fn2W9eQWH7Mnhga1FINt/E/kbV+BcZIqcwZroIYdom6UQs4vsia9yBAJkh6bIqpSi/+YR3wQ/b22dRLP0pk1sY+Ytgf0Meh9SsPy9Ov1hyJmG5jv0yUKkpe2Vb4KkeWKgtoipZPluUhthl7RF1GHl+iIJop5cXKR783AhIHnvW9Tl3A2SlXR/sLQPhcYO29tpODZnGyON434ZSESkSd+hpQZVXQhREZjZXNrz4etnG+YjUenPv0ZWpEDTTBfpT79tymHSeyu2hsXhh2WALxIhjQ1+5Z2IGaznIPyjMBcW1gcosFI5Q4VGO2BertbUBjbTMwM6a3oOzwOREAvm0ezkvT8AfrEJHOxF0OBuQbQQWoorzsfYFDQbDuQVHY4vftM51ISBKOB8ImUDNTbuMYdlMA1F5c5kyCB/1zB8gqNzHOeLrNJyXbKzT1gqKUaBNpsSmxNR2bqX3N0tXdtU5cf7JDbPSf3F7EdQBxoGIImx9U4+yGCzBhrBuompHi/DFeehjUCLFOQJFMuQSCVeOO/YkyJTdZwqrgFs59M48Vc+/LFCDe8H9EZ38Ii1loDdN6stYxUgBSQ1Wqnrn0ABbROxfOwEZM0EnNz0XaHWWs8m01+QM6a1lBfQqi4WYOfyWl7XF5cBXBVS54qloT3G4lyZuu+E8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(7416014)(376014)(56012099003)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IGoMt7o/1TqrXPnXB7cXLH0jGmAeVqAcAu0XVJESXhmACZeOBB2BMPRfxZfuRP5hkVOy/QSqY5W9GXZYu7/+RnBHHPpK2epqdHlBrXq/Hgl2ZhYdf5/Elf10mScA26DmeiTQr9w4w+u1PrfzTAuVVv9v+Uq92EZGraO2PQ8s4syuYTyB0TMtSiUT7c8sHprJRAhBX/tS0JSUEmXfqDkNo2z0UqaR0i4VpyTHoxEO2QpmIYKAduFZ5EO68AWoZpDxJB3tVPhiw7qtSgpSpdVgEntWQ1Ffw5wlZ7MEjwM654duayXsOsjNRgxdN0fS29/SpoMFWWrCTUYYLfBuaC0PiVoXowWMFXAIvSOzsZWNgj2af+v677bWFuP+l76OOH20Hcz+AfbT3+6XsjnP1fANFUyWRbqdw01vuLjQYtTM+ey/4rBZAmGP1BZ0UnRSQHdW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 21:59:42.9621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6fdac66-e07b-4a21-74f9-08deb784439d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9454

On Thu, May 21, 2026 at 04:31:23PM -0500, Bjorn Helgaas wrote:
> On Thu, May 21, 2026 at 02:07:34PM -0700, Nicolin Chen wrote:
> > On Thu, May 21, 2026 at 03:57:23PM -0500, Bjorn Helgaas wrote:
> > > On Thu, May 21, 2026 at 01:34:20PM -0700, Nicolin Chen wrote:
> > > > +bool pci_ats_required(struct pci_dev *pdev)
> > > > +{
> > > > +	if (!pci_ats_supported(pdev))
> > > > +		return false;
> > > > +
> > > > +	/* A VF inherits its PF's requirement for ATS function */
> > > > +	if (pdev->is_virtfn)
> > > > +		pdev = pci_physfn(pdev);
> > > > +
> > > > +	return pci_cxl_ats_required(pdev);
> > > 
> > > I acked this before I saw this sashiko feedback, which looks like a
> > > legit issue to me:
> > > 
> > >   Will this VF inheritance logic ever be reached?
> > > 
> > >   According to the PCIe SR-IOV specification (section 9.3.3.1), VFs do
> > >   not implement the ATS Extended Capability, which means pdev->ats_cap
> > >   is always 0 for VFs.
> 
> Huh.  I wish sashiko would include the spec revision because that sure
> looks wrong.  In PCIe r7.0, there is no sec 9.3.3.1.  In PCIe r6.0,
> sec 9.3.3.1 is the SR-IOV Extended Capability, which doesn't mention
> ATS.  In both, sec 10.5.1 is the ATS Extended Capability and says both
> PFs and VFs can implement it.

I am glad you checked the spec. I should have done the same.

> So I think this is OK as-is:
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks!
Nicolin
