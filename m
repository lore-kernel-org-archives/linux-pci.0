Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013038.outbound.protection.outlook.com [40.93.196.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA54386334;
	Sat, 30 May 2026 01:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780104496; cv=fail; b=sk0XRPc+tUaFAkIIYsRoqQHQeyYlIYife3sYw3ICE6Z6yXIcNZwhh6/wMDAhvx09e8nevITT4JlKKzzzj7vV8ONHEGPcPmmwAoTCRDkVAIuKPSsVysCvEnM5fRbMkU0YhkaNQFKj2PT6Pcw1mdRWl8mBOPlCZJGgkAWGjU3KMmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780104496; c=relaxed/simple;
	bh=Shl3EslrKi2uu5fXAEMRqeltULV/Wp1J0DH6aa+XjLE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ti6SqLdcQspecW5ASeKJYIWgy011gEy8+4pseQygRRDiWPiuu3aK9mG/UydEPPlRM0T0I/dpnyeigsqPd8j0SRSYrb/e50yU8c8QBj2GDBLf1aIuBWVGkp4GDMLzjYDC0hAczzigfxdtxsJid6iXhhrqRo/lbrujfz2jlNxLuO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pi1FNw12; arc=fail smtp.client-ip=40.93.196.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pi1FNw12"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1M0r4Csa+oAEGcEhHzGfQ9d1vEvmLWxHWR57B77M2QdIg5OhghUOhPGkA84LtI5U9YluQNU3Oe8G2VhQAoPsSHKimbfKMJBvMrvkjhnMEeYC/1Q7AKnj7dVgiu8Uxb9iUbDxQCwUSPrIUadUPFgiXTHHqGy6H8MkYwKCmQvfvJYHkxkMpDD+wwu2ri5i657FRxuntZvCsHco4281SNLz5XNy8WYPeJEDZuxilt0VpkeNUBByWKoyA1HsnVm4WGhR5sOROEQ9DcBvNOP/4IGsP8PrRGlhlXJGKEgkUtTS/CYsn1dqnzkteCdrEQRSUiEjIaSnUumEgs6Wz6044Sy+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwwmFQZiYn5QRP4xmXJPJy/nEPp1K60YnRUm7WdddRU=;
 b=OvZ+HrDEDPEqFK7MMLexQQ5QYZ4fTGBRI3TuWF5OG8j64tNcRlbs6F1MrOGXZDm8L4qIvOUdk094ZvmHm8F5qRHuaIQxhi2YaNMg2GCi9OPe9OY9jvFdw1eR6FKGpC+nrQ+mrZgo3305F9cTX7GtrTM5/hAaWqDGB4TjQlo5fqCJcz44nUKkEhBXTJUyzmXm5Bx7HNTYzGcEIFAjsXn1axtbWfzaiivmF5MfmMxDKWW0Pf42mJtvsdCsbJt4k9yeZvHxbHiddi3OD87S3MclD2DL78R/GV29zFXW4l5+KBvgsbRR4f8pdhukALr1O4ymmDv0dVte75CJwkZ6OS9WuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwwmFQZiYn5QRP4xmXJPJy/nEPp1K60YnRUm7WdddRU=;
 b=pi1FNw12Zz+LicDoIghq3NthnEOL3qZGa3BUEby5+PgKlW5Ik3ZOHaeWhQlJCZ7bt8COcM7ISew+Hfj5x8Ux+zfYsQd3XUohWph919y3pPTBLR7WnGpALjZw90d2WUAwVqtTsQutggd2ibyz8sLFD4MDIQXVSpirw3S/GnYJk5LiQOJ3uJJYgWJ5fROsJT8fQqRjDk4gHyN8qY1zLfzh1G6cbajeceNtHV730XeCTTFTXMN8BfjRtFaChFDHFkypPiXEz+lnt4YI3wx4cj2niSRoKxCtNO3wdjLhu42veeHwfUlSnKnmmnoWJvH2Mbh9E7/4Ayi3Q4Oa+HzAiPe+mQ==
Received: from SJ0PR05CA0126.namprd05.prod.outlook.com (2603:10b6:a03:33d::11)
 by CH3PR12MB9455.namprd12.prod.outlook.com (2603:10b6:610:1c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Sat, 30 May
 2026 01:28:06 +0000
Received: from MWH0EPF000C618B.namprd02.prod.outlook.com
 (2603:10b6:a03:33d:cafe::33) by SJ0PR05CA0126.outlook.office365.com
 (2603:10b6:a03:33d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Sat, 30
 May 2026 01:28:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000C618B.mail.protection.outlook.com (10.167.249.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Sat, 30 May 2026 01:28:05 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 29 May
 2026 18:27:43 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 29 May
 2026 18:27:43 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 29 May 2026 18:27:42 -0700
Date: Fri, 29 May 2026 18:27:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J .
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, "Pranjal
 Shrivastava" <praan@google.com>, Mostafa Saleh <smostafa@google.com>, Lu
 Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vsethi@nvidia.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v4 18/24] iommu/arm-smmu-v3: Introduce master->ats_broken
 flag
Message-ID: <aho9DB6it2R5O5Nm@Asurada-Nvidia>
References: <cover.1779161849.git.nicolinc@nvidia.com>
 <49dde0a2e2dc88e421a3010956db33d47cc92aa8.1779161849.git.nicolinc@nvidia.com>
 <20260519120658.GB3477375@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260519120658.GB3477375@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618B:EE_|CH3PR12MB9455:EE_
X-MS-Office365-Filtering-Correlation-Id: add7a66b-d50f-4bac-0e78-08debdeab2e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	97M19Ho6hDnO4oWGZv/g+6vc9CEWI1VBTW7eDBY7oRvVrw4iJ2Hv5MCIRpeepPAu4BuNNamUl/aCMjelkxIaNc1y7JFOsSLLb28XQyTrZgvDRsBRkkEx3SpSc1SLBOtssjSfFVEX7MdV8QyF4vjFccXQRGTBVsHe0/toTpATJBlkdABQb8h1FLtj5+X9J60DQpNJlC+j/BuwvTWhYRHt0I78wHFs8/QovjQoGWEC3PIjUxernf1JAKcWqc/5MhCQwfagJ5lDm4SHbwqGW08KkL8r6MqA1njsX/WOMsD/6+8W9+tpprIcgkALiZJlDiijxXERBXNGIDfqDo3yK0gCvFWBdfIdstdwmQ3vyEBbZROaV48BX+kGFwICr3k2zeT7yg7f27BIovVg99QOnadV61ulYWz6J6L1Ttwkd6lZ+PvWjCwQZB47/A1LbeVx6zk7gVxqNy0r6SFNuof9ecokLzK1HJfEqn96Cg71UX4giS2cQWvSmRA3SxN99ydnYWZgAHCbxV3jfkvqYTaYx0xTcZJsIZxXEVsUBHeLlI45vUO++nPYJ4iIil6vdpun5VhQBJSgvDYMjdoSV8ECO19tMCAq+qJ9CicsoLmWJiomcuZaPC99gv+qGZWTb30XsL1P1UpDxNQ05vLMB00FzVFaxoT3CihD01VKHvX1uAwxHYv771DatoLH01od/RQYdxTJUHI415xay78TQPvg7mPdvbNie9mAEemnH34N6s3ec0Y=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	d9rw1vx8ltl25pNvzywCOML/gzute+0rbNg0NfKgCvWm2RXdZj2FTTyujq/aV+Vs8xzK4roWdyzxZuVb1oBeUg9eqawlY6DO1xRnh3dkddjw4+FgEaRhqtx4Sctjtmgu7KRIH7cuXILJUel9d6XElolo4WJyCbKuhfTGko8U91dV3rAYoLXD0l7CFo/pj9DPHLr+8lwL4ypbYMiPhIgvtuUDh3LIt2t3A2wxNhD6SutZmnCl6Nz3mpL86EAJdm8b3yLRRq7SCKXRcvqKKTQ0TCXitk1kzFQrNQxQeZp41xNfI0h02c2o6hNAh8bKSToL8cjpF5jiDqlWIq+D2LHMAkdWsrxAnHhmbmkVl48x6Zk3U+UJJ2/8g6BDWUOfOHoOv5DB8YY/uLPeVYuAehWLeeLxY6FU8Lwd674XMN97Itx8XoRu9GchdhWQ/fZx7ZPY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2026 01:28:05.3356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: add7a66b-d50f-4bac-0e78-08debdeab2e1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9455

On Tue, May 19, 2026 at 09:06:58AM -0300, Jason Gunthorpe wrote:
> On Mon, May 18, 2026 at 08:39:01PM -0700, Nicolin Chen wrote:
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index cde2ff2dcc49b..638956e2535b4 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -2429,6 +2429,10 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
> >  	struct arm_smmu_cmd cmd;
> >  	struct arm_smmu_cmdq_batch cmds;
> >  
> > +	/* Do not issue ATC_INV that will definitely time out */
> > +	if (READ_ONCE(master->ats_broken))
> > +		return 0;
> > +
> >  	cmd = arm_smmu_make_cmd_atc_inv_all(0, IOMMU_NO_PASID);
> >  	arm_smmu_cmdq_batch_init_cmd(master->smmu, &cmds, &cmd);
> >  	for (i = 0; i < master->num_streams; i++)
> > @@ -2651,12 +2655,18 @@ static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
> >  						       cur->id));
> >  			break;
> >  		case INV_TYPE_ATS:
> > +			/* Do not issue ATC_INV that will definitely time out */
> > +			if (READ_ONCE(cur->master->ats_broken))
> > +				break;
> 
> Yuk, this should be a bool in the invs list, not the master.
> 
> If the flow is to have the core code always attach a blocked domain before
> reset_done then the invs list will naturally fix itself.

So I've tried INV_TYPE_ATS_BROKEN: during per-domain invalidation,
each batch is built from domain->invs so it can carry the "invs";
if the batch times out, we can immediately mutate its ATS entries.

But I realized a limitation. E.g., if a device attaches to two SVA
domains on two SSIDs. An invalidation timing out on one of the SVA
domains could mark INV_TYPE_ATS_BROKEN in its own invs, but not in
the other SVA domain's invs?

So, it seems that master->ats_broken is still a cleaner solution?
In the same spirit of "the invs list will naturally fix itself":
we could clear master->ats_broken on every attach; if the device
has not recovered yet, arm_smmu_atc_inv_master() in commit() will
time out and set it back to true. Right?

Thanks
Nicolin
