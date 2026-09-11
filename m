Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012039.outbound.protection.outlook.com [52.101.53.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9474BEE25;
	Fri, 11 Sep 2026 23:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789168595; cv=fail; b=ORu7+U1y3ndJulIHxO/ByNink4xifgX7VhwtUug0fs+pm8YhJN5ebE3F8aNaaeWhY2q/QFHzkmM0hbX4kMJSiV6qVBljaQFFo5wtPPa6drhElJ5BRX4olbHaFQz23J2JUsaERDLWg1mgr2SakeeQ9TacNXewzcq3cHaNlPTgwK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789168595; c=relaxed/simple;
	bh=qik65rDh6c2kfhsraTiyYfbDw2sp+rpBz+lDNOVDN/U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jI5tqM6qM1T6DGVVnKgySHB69Ta9c2JUk6/1frSQVonE0Vc+xp5x2XQtqFF5Ofk130eyUuZVruzdgpgxDaGGyxjdKTi3dwpNqcY84E6b8DbB/xzKHZ3k+beEis+Z+pY+YZkpNDW/gOUN5V6h3ghXB7JfVko8NTWqRGJ2cSZe2ZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AfuaKQKS; arc=fail smtp.client-ip=52.101.53.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AfuaKQKS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhYmkcWnVeY1cxRzK6tzv0rWQQ5HtBhmU8SLdIrGJYib/WNnE62Nh+pCYkP7DMo4sOngBqtfG7CfTobB3QipA4FW0Vrtc9yxhxVz6Z7bA3fqgWQvyP1MWxXqB6culvNXGJP3oknwLGbZsFbPv9elxA8xPJX7yD/9zfNONTDG3Pu/mUJE13gPgj8yOU9JwI1w3TBFOm6cHL+I9L/+vau/n9MwWzOWW/pH+bBZ6NHgvEW8+19TJcgt2wkXitCTGzMxezrvsk7/ZWLtlo8fXbfSDayuN7e9Pg+96Z0WI/okBD9QzCAEGNCy5oFmq1yEOICAMZ9t8L9NwWsjlmoa0UZFSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z005iNmuxCipZjaeTDI4na7DtiyyRMSUATbPn9GWU0M=;
 b=HVU6WDSPnW6Zv60m5DDnb7GaAZqu5Qk7L72EQBbsWsZbU74alO3RaXjC+/vcA0RRPWByje/bhafg2K2SK5na8AHyOIpOf0g+ig0DAAo8So/Spd9vSzKDaie5E3bsUFBBz5zfKZpmBiztUWZ7+PmNI7ao831WrnLWb+4z1N0Nk5TFKfFHSjVn5af1muWGXlburJJt40/Hc12h/t73q+YoFMkc+T4tTyKktQmysIZmTqC3onuc3oKUTXEsVmzqk+FTwmcyZs+TfzaPJvj+x/+W3gpKYqH+/1C8BYtG049Fq7YvfZuiDJO5A//S/vIsk74CzOrhaHgEfdUPN761n2fVXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z005iNmuxCipZjaeTDI4na7DtiyyRMSUATbPn9GWU0M=;
 b=AfuaKQKSrld4G1WEOBvrfe1CNdu5FPiYbbwDRNx+Xd/600eENq5/7WQiDJ5L2veuP1cOB2EFV2gt9uXuuFbhVmFMGaDk0Ej5A8Y11rou5cjzqdL8MWheKA5L3der9esN6nb0cN4iuU0/aNUaMWysRmA30pB0hLQ4zsLuFsuUantGWAVFPOqrOAc/q6IZ1PhGJ+RNwjHlzVQvYO2RyfQwNu/JG1zz9RKJ3rMNuD533cNnZHL1HFEdLD/g/yiA8J2eHKiatSDRMC5+KTJMl25KUaCbGNCy2Zc2oDHnm9zl+ZftKmARWU5HWcpc+o+Ekmle82PDoTq8onidaIpsWhGWQg==
Received: from SJ0PR05CA0025.namprd05.prod.outlook.com (2603:10b6:a03:33b::30)
 by DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 11 Sep
 2026 23:16:26 +0000
Received: from CO1PEPF00012E83.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::45) by SJ0PR05CA0025.outlook.office365.com
 (2603:10b6:a03:33b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Fri, 11
 Sep 2026 23:16:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF00012E83.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 23:16:26 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 16:16:07 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 16:16:07 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Fri, 11 Sep 2026 16:16:04 -0700
Date: Fri, 11 Sep 2026 16:16:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, Jean-Philippe Brucker <jpb@kernel.org>, "Eric
 Auger" <eric.auger@redhat.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: Re: [PATCH v4 10/15] iommu/arm-smmu-v3: Support PRI Page Request in
 arm_smmu_handle_ppr()
Message-ID: <aqSLsg7AVgqusKob@nvidia.com>
References: <cover.1789081084.git.nicolinc@nvidia.com>
 <cbe6e6f578af848f4efdd8d1050181032effae37.1789081084.git.nicolinc@nvidia.com>
 <178908564507.2841562.6430226716089872094.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <178908564507.2841562.6430226716089872094.b4-review@b4>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E83:EE_|DM6PR12MB4338:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e024b25-ce80-4e75-f198-08df105ab3ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|376014|23010399003|82310400026|10067099003|4143699003|18002099003|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info:
	8JIpXeraGBNV4XBqwvUlCXKy/pN9q6Egudr44Yg+UDTpMmzaBR4Vd7O5FNkaRGBzYdLs8+tJDDjSVUCkwgbfwleKc4m8358tQIyeCYsG6IBguhaSp0y2HaD9ih4e/nPQT5QiAWMKGuA2sSJvlvRtXnLZfl9h18Rm/SW/DMJ3yD/Mbxch93VDu+N3jHblY0K3fD4yGHYHmus7HvFZE8cSjaiUHFpq8atguiCXJJUYGahprql63LrrN6vleKvA24Lqn8ZECKnqA9Bydhs1X4h1dFzUo5QZTZk4AZJKQohazgwkt5NDaEnSUYlq7AQl6EjDvk6BUt9kBMDruiB2D+U/n5bhi4xsTOv0pPzy5Q78YjHpJYN6LUg63vx8Dj04mf7GKAuRrMRabO3zPJmDAYR6gE2IXC2N38detIoCd8M8LxDMlPtJp4MpCT59RClBWg+RhifYlLKEbKldQyolhpso4KFS4veOdItlr82FvAkZNrBeWqImAtu20SNiP6x/GSVTRCKnusJMkceesmHxafI0ycl/ee7uvi6J1rNKk2CF9l5kfFS3sV5D1D7oSYMKfg2TODtOPNV08Yx2yfolpLy/rJGLTpQRNKQLRl679PkfiIGVqwrnohcDiGaxclN08UM2hwP/hIuHniUiiZ4Sl+Xpy+QVZBC5Ctccm4qKiTLr5w4RK084LQnyj5boLdTd7BMmvbFeGf+RFwP5xef+2JnqFA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(23010399003)(82310400026)(10067099003)(4143699003)(18002099003)(56012099006)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QxsqBYk8LQXlBdUGGqdozcdukOWalmRvPU9WKFvmbUR4owU/d7CxBlGHkuugztK/YwhPkP1sCEEzHHM5sTwdVQ+V+RxM4xTlgm1y3jGj4NXlsBUB4ZxYXy7NLJqfIY8PstSCGP7/Li5+qlH02xHxgKVYWudGLnPeFIDTdTg771+WkJCmwRTzBUl6QtjREBlkXhkIfsbvonn201gJAeKb8hlm6NMmYB/upLVp2UNbu3lOD5SkkOBS0PlLGXuC2FP+ooDjHTshZ8U4MmkmiKed6HI9zg5KjwRZ9NKBxTW+lecznWET3yFcaGz+D9kBWip8dnmsKEbyyMxh1k52hAKtxnlW+4JDrynbKmvo7dbSG3DO9h50m+CXzruBC9Xz96n8mQIvWldHcYTj9KnVRl2t9idLIJF+5Av9stc2mfiMg2oNIy2M9sI3129xOQ+zojtX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 23:16:26.0400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e024b25-ce80-4e75-f198-08df105ab3ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E83.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338

On Thu, Sep 10, 2026 at 05:14:05PM -0700, Jonathan Cameron wrote:
> > @@ -2380,9 +2381,47 @@ static void arm_smmu_handle_ppr(struct arm_smmu_device *smmu, u64 *evt)
> >  	last = FIELD_GET(PRIQ_0_PRG_LAST, evt[0]);
> >  	grpid = FIELD_GET(PRIQ_1_PRG_IDX, evt[1]);
> >  
> > -	dev_info(smmu->dev, "unexpected PRI request received:\n");
> > -	dev_info(smmu->dev,
> > -		 "\tsid 0x%08x.0x%05x: [%u%s] %sprivileged %s%s%s access at iova 0x%016llx\n",
> > +	/*
> > +	 * A PASID Stop Marker (LRW = 0b100) does not expect a response and
> > +	 * must be discarded before fault reporting: see the documentation
> > +	 * at iommu_report_device_fault().
> > +	 */
> > +	if (last && !(evt[0] & (PRIQ_0_PERM_READ | PRIQ_0_PERM_WRITE)))
> 
> There is a bit of spec language about case where there is no PASID
> LWR=0xb100 not being a stop marker, SSV == 0 and should be treated as
> a PRI request. I'm not sure what that means in practice but maybe
> a comment on why that case doesn't matter. Feels like breadcrumbs we
> might need in future.

That's a sharp one! I didn't find any the practical action was
suggested either.

I wonder if we should let it fall through instead of a return:

	/*
	 * A PASID Stop Marker (LRW = 0b100) does not expect a response and
	 * must be discarded before fault reporting: see the documentation
	 * at iommu_report_device_fault().
	 *
	 * Gate it on SSV, as without a PASID that same encoding is a PRI Page
	 * Request and it does expect a response. So let it fall through and be
	 * answered with a PRI_RESP_FAIL, since iommu_sva_handle_mm() rejects a
	 * PASID-less fault, or by the PRI_RESP_DENY issued below.
	 */
	if (last && ssv && !(evt[0] & (PRIQ_0_PERM_READ | PRIQ_0_PERM_WRITE)))
		return;

Thanks
Nicolin
