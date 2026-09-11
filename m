Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011015.outbound.protection.outlook.com [52.101.57.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37FB31618B;
	Fri, 11 Sep 2026 23:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789168697; cv=fail; b=RahZvh7XXDfZ8ie25iwqs8Y7jOrpOLZooCiyzXuiCg0B2/bIOpIp9WaLDtXXukBL3aYgJoHbLpyOAXqoCNE8sTikYVoXR6fXT/MaqPsivZy6Q5LG1pW6p9/JmFyGQ+msib4PwUbL/NwKULeYcwLUf7mOOQuUHZj1BD4MD0kagB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789168697; c=relaxed/simple;
	bh=VnrJ5867AhGcVnHL7ddKQcxpeh1fVUnBiUo2dD2gsNw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUrGvCkoPvB+AM05MmQgOOhdBJ+4PL3USUi9iKEQmRSWcWpH62jdZOZKR9/XRB6Qlb94s6wMhAHYz0ZFOR0aaZTv1faIZF3xxO/YYoiwHgk2EHSN/1CiaZvMBNH8lW4F74lDvQKqwutTnIYK0tkU3c5jp+iNL46COfxQW17PqZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HE5xJbpH; arc=fail smtp.client-ip=52.101.57.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HE5xJbpH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eiec9MeKRi6cI9bVEf30Br16/u/AKR8FsogL9QdpD1orZUxMGMqEKpTnqVe1IbUwO12z8EypQ+FfDAgqqZsrfivwgyoGeFLG9n2BW83qiF3SoBbmSTc9x6peSQni70FU7vnbSQwy/mjisA6DoFJdCZjzw85pnQobEVUubdQZk/619YzDK5E9El5zruufDY8VCMcLzh6SyMnggF2GpNsB+cDsYzLkbvPUC2wHLMnapca9OCpQ6jojsbetA+hdrthV7u5CuenmjWxmYd12TUipnOeiVF0EE+J5pQ9WGN7Vl25VifAywEMUy3yOXlOVA66WrXOoc+Cszmp+WNXHksAXxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BU/y+MUuWPTsUuV6tYKsgqkqe+UgymgcJ/v7TeAL+qw=;
 b=DpGfsxaAHlgxUzSt915ZW4BcfkqihmztC5fYq16ieNFnNUXZ4u5ksNYQXUo7T618R1bZyT969KgK6V8rnvtlkxti4byhBdUqtu4neeW7VUnsGBPUQqEf2IyXi0jP62JPEaE+tuLw47VR6BWMTrxcCUC5z/YdhcrZFL87xFh3mFjqESLZ9vpZTugLm41deJJs3gZhFi9bsQnboMqjiaP6BJKz7Cws4NB6xsKdU7xESSTsSbzqm9dMZw9ATB9imahD7TBBavwpqm84LesfAGwVlasdURln1GP1KRyb646W0uz9+Zkyvjbpu6dUqUrQ3/lGaksJPyEWSFyZojB07v13Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BU/y+MUuWPTsUuV6tYKsgqkqe+UgymgcJ/v7TeAL+qw=;
 b=HE5xJbpHdAMkDBunh0SC3H2d5zJ05kRFsiY1+/+zAhE/mSG4IzCHFWfBM59lhL6kYnftYoY5O27bB+ThWsKBI2qKeH/Wl2W5+gqLWdA7jDrtZ8Gf3ToW9oinFqqZv2CABKP2k5GgxtT4F9HJgey8xuhZbKCNOmYE/2EmiWvmaVjQ4u2kl/KEyRyLF2wWw9TzYtzrbanabSjeMe+e9WJO1AH/D1jwyfPwgtV9/BXWrtizGTmvAKtttDgz+dDVeB1/q7tilN3JrNVPJ5sRaNRZUuCusQX3GO9nBvizoLwL6516o0yb+NW+t3EWcTKhRQpU7bRnFN5vJoPN2nNQdbJaDg==
Received: from SJ0PR03CA0062.namprd03.prod.outlook.com (2603:10b6:a03:331::7)
 by IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 23:18:11 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::9a) by SJ0PR03CA0062.outlook.office365.com
 (2603:10b6:a03:331::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 23:18:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 23:18:10 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 16:17:50 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 16:17:50 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Fri, 11 Sep 2026 16:17:46 -0700
Date: Fri, 11 Sep 2026 16:17:44 -0700
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
Subject: Re: [PATCH v4 01/15] iommu/arm-smmu-v3: Disable the impl before
 disabling the SMMU on shutdown
Message-ID: <aqSMGCr/9DLFyE+b@nvidia.com>
References: <cover.1789081084.git.nicolinc@nvidia.com>
 <61536b87c45164b1f581ee4358574ee7822e212d.1789081084.git.nicolinc@nvidia.com>
 <178908564506.2841562.10082006196933269469.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <178908564506.2841562.10082006196933269469.b4-review@b4>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|IA0PR12MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fa3d6ee-229b-4404-9bab-08df105af238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|7416014|376014|1800799024|82310400026|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vPgPZ25KHWnlGMWa6eMe9F6pBwHFUBnAg52Is+cqCEDpbTaSVSCwsZTZhLf1yd/DIEIP9qp3HM19gl7pGqPLZkjZoWt+4S9KVheX5y/iBf/dvmujtUMLEjGiB4VRYNDZE+5jL4hzhND8Lq52/kbqGO1srByxxUGRtiC5OOrBvzSQ4ntgWIFEoJ1jkc3/9bz2z0CLiJEH4FQBy0Pn4vUhkso4D0r2lVtKkSivzbrdh0j1CGHxGg6nVASBQ7hvcv1l+PlKdmH/QIgWV8RE+ktQtBWOSJ7jNpKBS66zll6WmaznYEn2dpV1jxUPOkdXysrGU+juK+PUuTLa9B7cY3GpitNVr1aH7uhNvCMs2TfZJTrxsbyAqMSz9KKsCLWSrUJNYpqS72MLixXe97zb660Ktndw4dyTupkqacPfn8I3N1APnf6zFuGltKF/BMtsf4Z0srDmKW2SWtjGcsa9GcwbPq64/YjYzG+VOuYreZ7pXFmgB0m42z0ziaHDjfvbeO3BOPkELAWcPKUqPGHY9BqkUVhSjmRqTCRjqSJbg1OFmXnSr8a3eITGqU1wcpRSdagZ+CCYaUB6mGE6ZrGfEvid+GrySmBA2RYfzObAcSVUJrmCSPjaeGjEPbCJPjqjptRmZFhHpmbJcCtfsaFSZ9xr/sHFYcJcN8NdX4QiPdhl1kKUfm+NbSnykivGMONWDCDtdODOe7HHV6Qf/W1qIF8eEA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(7416014)(376014)(1800799024)(82310400026)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EEhiuKsZHsjH5I5RYDrW6q25YvjcGVqXM85PkbgPOFMNfwOEktCYxSD3iL/rRkksBJfm1CS9rMX3ScELrantbgpq0u4jX5w+GnccI3a954EsTWGTwXrsr47kGzA4+gi/uqQGjFHTCiZAl7zcnOBGTGj0DtZDALpq1VNc2JdgfJLxUBHG+xyyCSwCNh2yi4HUcxoEo1N2TSmF7umE2MFER9V4ELToq0EBacsC6jAkZJASd+rvbesr85+TYcZj3sURxXa49c+KzIl8j/VSP2KSVY0sluNrkvc7Q05UdpvIEoO4/V0CSmbGl6lDuKzCdfQdvRd76CwLM+NeI8vpayE7fYDOblf97WAIJhqfn/FZdr+xtljdaCoITl6Bnd33xy7kotDDn6EshM2VgzPhS4We6vpXivbkPOYF0HthqSuB70yCfb72ZQtb8LubzCZ4CY0T
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 23:18:10.5420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa3d6ee-229b-4404-9bab-08df105af238
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8376

On Thu, Sep 10, 2026 at 05:14:05PM -0700, Jonathan Cameron wrote:
> > arm_smmu_device_shutdown() only calls arm_smmu_device_disable(), and never
> > the impl_ops->device_disable() hook. On tegra241-cmdqv, that hook quiesces
> > every VINTF through tegra241_vintf_hw_deinit(), which issues a CMD_SYNC on
> > the shared CMDQ while it is still enabled.
> > 
> > arm_smmu_disable_action() already runs this hook before disabling the SMMU,
> > to cover an unbind or a probe failure, and no devres release ever follows a
> > reboot or a kexec to run it again. Have arm_smmu_device_shutdown() call it
> > directly, instead of reimplementing part of what it already does.
> > 
> > Fixes: 9ff145a25c5c ("iommu/tegra241-cmdqv: Fix CMD_SYNC use-after-free on teardown")
> > Cc: stable@vger.kernel.org
> > Assisted-by: Claude:claude-sonnet-5
> Assisted-by: LLM
> 
> See Documetation/process changes around this. Personally I don't care
> either way.

Ah, it looks like they changed that recently. I've been following
the old format now. Since we need a respin, I can fix all the tags.

Nicolin
