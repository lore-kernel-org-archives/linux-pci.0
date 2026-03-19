Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013022.outbound.protection.outlook.com [40.93.196.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EC723EAB3;
	Thu, 19 Mar 2026 03:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773890823; cv=fail; b=ILPqb1WblJYAgQ+ZpnIN+7QYjYbzgZQkHTGoN9yjit0JIzKDydn/IROppQRwOovkdZPkR0tYX9Qa2nuAXaVZqbp3ngfx6ef0WtfZYGrXCYBuL/p8WlK3ZLZJAoURwRrWWkLAo2FwPblrUNP5ZTm+PBI4igqBD486Iq1RBnrEPDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773890823; c=relaxed/simple;
	bh=GVvcemwtXHechD67e7qXuBaukYEIIgnDGn4J/ulASYk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrfTPYE8AB/G609+MKzqRAdLYdmJfGYZYt1hWUXkCcrojUNdZ8sw8TsZLPBm3rAjhEwJ2Z9ShinUBsaLiH5KLnKGgDZGTrx+RcizoM0IUt99Y1ikYqFzyZetEq3IArbynHGj3j2kVgmVXcQMmXJpsVKvMC3wUUoOkGSCvH9xfkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SyJWikjz; arc=fail smtp.client-ip=40.93.196.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SyJWikjz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/it1w0p8vIPRcFWk0dcB5JYWmbPU3DLdU2MggB5pJhFzR+Bl2xOClt+jOi6wXeYhXwoygUNS+81F3ilIyqn6072g9zRxHrQEojNOIaSkhNoi0U7pjUb+dBpJjT5s/jka3ercBW6SnTpAQfhzotmgC8TYc0NsHlj0whPQ/r/OTrM+g2CAzf1X0Y6KDTLGbIXFH9Z2T5pCwcMS66oyh8fpOJd9tHkZnNcutOahvhLaYFpBYmdG+JSyxXDun7SGEtP7f7H63OVdlTPdQC7LPtf2VPb2nDXoyN8OPPhXdtXHEx1vvSYCQfzd+1WkpLmmsPo7q6r2L6jgsQ7lAJaVPyxOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCY+dC96kLDn5udxsuzs0YzOT7RNsPRTu53zkk2Ye9A=;
 b=DCLULtqjL5z7P5lAk1PlOPLNa6upVSbn77LOHTdjMFhc8Aoe0uxMt8b2xrvDhCROIdnulH9uu1qPYWZbp8DVX6xmEEfyiqzEyT5koatLl8cwppxlaHRCHY8JDfYwofMa7e7dpbBVSi8jVbiOTxwhf4pgkPw3/lzvFHJecRVBDqre2yiSsepSmmp/b/9jKccaSTYdIzHXPu+Wllu2YS/s62GZqXs/8C3gKxl+d550IBrRLcQLkMnalhY5sZnckmqSLXEFPzVs+N7iaOPjfWLNMkYipCsC/jPSJP2YOsprCgEPVYkFMHHueyErnZmeM34OkQPuJLGiVb4Beq8OSqdFlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linux.alibaba.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCY+dC96kLDn5udxsuzs0YzOT7RNsPRTu53zkk2Ye9A=;
 b=SyJWikjzc9yxyWQcYS9KbNUoCArxc8RWcODilsHPsazu0MJnJf3Ve1qRLrbOd045XmXsIRErH/Jd62bVmrdYFL9A0E+W785oz/s/ECcbcSWlC0YmThA+fnQL0U1ipk5PbM0rOXTColFAAHyK/XlkxjOM2Uf31BCIeaP9XibUX9K/4F8bDQhOsCtYJGpCsJaGj1tWiu3d1yIgARBEeG7H5SHMhi8c1i19fL065qM2b/EXoehs1VpPG/0Mg4OPpGEFapBmg1fyNjJ89yGKWkEVhX50MQQr7TIqOIczzxypIqJs4xToA8YBeZyayslejYqvaOEsIPatHrb5y+OBxjQBLA==
Received: from MN2PR05CA0057.namprd05.prod.outlook.com (2603:10b6:208:236::26)
 by DSSPR12MB999237.namprd12.prod.outlook.com (2603:10b6:8:377::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 03:26:58 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::61) by MN2PR05CA0057.outlook.office365.com
 (2603:10b6:208:236::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Thu,
 19 Mar 2026 03:26:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Thu, 19 Mar 2026 03:26:57 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 20:26:45 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 18 Mar 2026 20:26:44 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Mar 2026 20:26:43 -0700
Date: Wed, 18 Mar 2026 20:26:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<bhelgaas@google.com>, <jgg@nvidia.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<vsethi@nvidia.com>
Subject: Re: [PATCH v2 7/7] iommu/arm-smmu-v3: Block ATS upon an ATC
 invalidation timeout
Message-ID: <abts8l0UPvGuzrzF@Asurada-Nvidia>
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <7e21e14faddeb0e3af692356f4fefbae2dfbebda.1773774441.git.nicolinc@nvidia.com>
 <eeee122f-54e2-4fe9-82a6-724c3f80a499@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eeee122f-54e2-4fe9-82a6-724c3f80a499@linux.alibaba.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|DSSPR12MB999237:EE_
X-MS-Office365-Filtering-Correlation-Id: ab049936-5fbf-4654-2302-08de8567603a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fjfjFg9ZmP7XZfDxqkqSJ1aBHsKgyv3v4lPQ0zU7ibmLbqxUIUFiDJLAOEN3wVynVZ3xY6Oz3itNZYS3X1pOOnUey8m50rxLCpAyKI1GXNr1Lgju1pA2yLzkF250cPlKInf0Lhl+PbR6VNjzwfkIjkEgR4kEG2wv3NGdJbldcGu2h7KZf26Z60zoDyCpU780do1899IKI5ZRkfki4prLWNdr0TeDtsLOfeqkzBNDDZjhoswiqSNieizPhrp38yBMr1m3NJ/9KDLwHzqBvsdX07PAhnqllwu0l3bQqJJBza07KhsEcCrtuuN/fhEWB6DGaFqAGMPPOhyUMfSdYm8owul5mlD8Vl3NlgZPZgybBVg5BcFmTtunRD6tl/vP1+WwEdA39b/Zu+r2/4YB3YFwR+hqea9K/hMX9xtUJFaiE3/nSVWS6UvwIPbie94alZpO98a4yk5IIb/WXnuTkf+45/Nlj3JMeVH9r64BHAokiohASrldjgnKjbZbqsmHJJD6MgIwM/mdEYB2091s60LiAIIFUJTDsewh8sPgDjjn7khqRXhygac7S2sO0KnFMO3l4cuVykUexGh1+Etb/UpfPIzBzwij/QQ5qDO8OodhqmwSmwMYAhsCo5u2X9OObwqLpeqHWUAR62Q+W8ku6xOUkw8aQpuFWfZ7aXUuoSvLEO3xzk0tYGKvfeEnYfUq2kd24U0i4MDbWq74eldfYjGkorvPjOfhQvgYxVcOVdBSx3Vyk1yB4aozP4iTd5f2/mcJEDfzUKmTxQKJYGp5Yeo6uA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	syELex8kHnT7rYCsZc4ig/cVWfUth/taQXPoIWPsmafdLMq8Nh3v/SaSGJ6lCIhIW8qXOSHZsGjHEh2aNIGzvMiUDmYU0U8br5SWf5AtPfN5PZVEiSs+swO4shXbZrbz0ZP9P+SHBSITQFe35L/3uS0fYanc7wPVzrS2/9DnVKP4P2WizPift1TyfuEF6wrMettNR75tH6BbUdZFCwHDXMJa3bp1RIt9Bi5AP0GdJ7Few3iStZuUCog4sQrZpEK7RAGVO8fXEK9zNPcZKXDsk3yzb0jpAYeRzlwS0NcK2F2EtTsKE6U0hHeDQ5HW8jUhpkNF5QNrxXTwhWGDPPsCyoZQoPYhpa622InGq0ClS3UCwF+b30X6kutTfFN1HKJ9nhWrlsA2iQ5Xx8AujlXPAoycNKcTKcZEXburZQkf3/fjttynorIpL64rXo2SaJJh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 03:26:57.4000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab049936-5fbf-4654-2302-08de8567603a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999237

On Thu, Mar 19, 2026 at 10:56:43AM +0800, Shuai Xue wrote:
> On 3/18/26 3:15 AM, Nicolin Chen wrote:
> > For batched ATC_INV commands, SMMU hardware only reports a timeout at the
> > CMD_SYNC, which could follow the batch issued for multiple devices. So, it
> > isn't straightforward to identify which command in a batch resulted in the
> > timeout. Fortunately, the invs array has a sorted list of ATC entries. So,
> > the issued batch must be sorted as well. This makes it possible to bisect
> > the batch to retry the command per Stream ID and identify the master.
> 
> Nit: The implementation is a linear per-SID retry, not a binary
> search / bisection. Suggest rewording to:
> 
>   "retry the ATC_INV command for each unique Stream ID in the batch
>    to identify the unresponsive master"

You are right. And that sounds OK.

> > +	step = arm_smmu_get_step_for_sid(smmu, sid);
> > +	WRITE_ONCE(step->data[1],
> > +		   READ_ONCE(step->data[1]) & cpu_to_le64(~STRTAB_STE_1_EATS));
> 
> 
> This non-atomic read-modify-write on step->data[1] can race with the
> normal STE installation path (arm_smmu_write_entry → entry_set →
> WRITE_ONCE).
> 
> The error path runs from:
> 
>   __arm_smmu_domain_inv_range()  (data path, no group->mutex)
>     → arm_smmu_cmdq_batch_retry()
>       → arm_smmu_master_disable_ats()
>         → arm_smmu_disable_eats_for_sid()   ← NO locks on STE
> 
> The normal STE path runs from:
> 
>   iommu_attach_device()
>     → mutex_lock(&group->mutex)
>       → arm_smmu_attach_dev()
>         → mutex_lock(&arm_smmu_asid_lock)
>           → arm_smmu_install_ste_for_dev()
>             → arm_smmu_write_entry()        ← holds both mutexes
> 
> Since the error path holds neither group->mutex nor arm_smmu_asid_lock,
> the following race is possible:

Because invalidations can be in atomic context so we can't hold
those mutex locks.

>   CPU A (error path):             CPU B (attach path):
>   READ data[1] = X
>                                   WRITE data[1] = Y (new STE config)
>   WRITE data[1] = X & ~EATS
>                                   // Y is lost
> 
> This could clobber a concurrent STE update from the attach path.

Oh, that's true. Maybe this:
	__le64 new, old = READ_ONCE(step->data[1]);
	[...]
	do {
		new = old & cpu_to_le64(~STRTAB_STE_1_EATS);
	} while (!try_cmpxchg64(&step->data[1], &old, new));
?

Thanks!
Nicolin
