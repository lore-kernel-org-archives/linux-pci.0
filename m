Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013060.outbound.protection.outlook.com [40.107.201.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69901EE01A;
	Wed, 20 May 2026 01:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779239084; cv=fail; b=oMSxq2Ar7rEK40estlYHL2N1+yDXApT9EVfgIoXsJpgxFRF2Ev6GfJfy7P2ihQ7L+DPSWxYscUIAJAsEslIgiO6P01Thyx6Uaa8LrS/Cxj/96MdBY40bat3fHn4w8YiEJ2fQDcxvhOTF2t9kOPPZG7MSxFYNQQKQTy2V/6Dw8Ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779239084; c=relaxed/simple;
	bh=GvUK5P6x8pBWdEcbVBmXLMMqgM/5AJN2G2npZ24R334=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQPSDQ105GLCTn7cxkXjAQK7u3UfBPKViQNzZMM246MpWskBscnCrPDRLZVOT76HFffYyAAawrwqgTsN6RVl7Def3HnAulBMrGJV9rqxjZm60F3lXedtg427/1dUXbl6LKkAXOY+xkIc0h+e7InctLMOPu7wo5RaXBCy6IV5q0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jleze5a6; arc=fail smtp.client-ip=40.107.201.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jleze5a6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YW0jVtzCmSmpOPFYpr4FmkEoq4eA5X81/kazprzlgzo5ZH96g+TlTkmMTU4b5iEqS5nmNpbcuCGJ4SZvWpVw+sAFPdKjk6sjyyos7useWbKCHBaXpE/UiNeimsF3gIQAch6j6UoBkDeORwHEcJMtvQFaTbmqW19vwgHYtJlH9WsFt7WZzebxpUSveJrqKO6bdkrFsQjqlCcprQ8rOL6cpXPBnzwLcGWlfEZG5Z1BcOBU5xVgCyC+eqi8V9SIPPt+kno1obSnyocpD5p2vD+b2xRRr9r6E70zl+1e5OMSqBgsS7M8Le2GCnQ1kQYWNVsfHjXdy9X8z5kgRynhX32ChQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaJIcoYizLBrf4wJ/hcB4ffoIk09ajQoviCpwfg2Uns=;
 b=bq2RFSkSjUEcxfkw9Gp6jjvr8ta88cs8vrhV5LWvrOHAagA1fvQT3jWlBUmrrDrIJB385pwMoqurfA0IEIvMqmpArF5MZhiWFhBoVVPg6DoEKlgB9jwm/PWuJ55keKbvoRyl9QaBmIOarsc3QiummBfZDbshPj7cWyFqeWYLyYEsdEW20c1OEp4oyoR4UxsyS/zrxVSJtWttvwF/2VObg7PslhtfbESsqFHXkcdvY28dAG952G+W/IvLdMe4uCOVRpsQnWfac2AZEbJCiCmVWpZT2EH1Zo+0ahNhI0alpK8QmrjsJuXyByZXNKV/mtUQZVXVFc0ORDLgaTJdbcpqyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaJIcoYizLBrf4wJ/hcB4ffoIk09ajQoviCpwfg2Uns=;
 b=jleze5a6LqMdVJKhal135dgCeCUpCiwuTm2PTcvJOShtWphh1tpqoOYfdR4TRw1zSuVItaQhLZVBgw6UelnBD48D4s7TyCiL6j8sPKPvTZsBhpKv6PBt+SrKqJZD0arSR+Eu+3OWi/O3xd9E4Ch6uQjsLhJQ7eDZZYTsLclHGyq8iIVxcQWUAYWP+OLHAslBuLczO3QUKXCLuxkGoZQ5tmo1SxQyfUAVGIjVuVchmI8B8JH5enKA7iuFXVPP6QfCEYzNXK4gCqZo8cQ/qbIDrVcYzX+tYtfQnmFXIhStN7sHfKBmLgT9bqwBpILZkpT1vSbOMwfqMhWoY74TnRZzVQ==
Received: from SJ0PR03CA0189.namprd03.prod.outlook.com (2603:10b6:a03:2ef::14)
 by BL1PR12MB5756.namprd12.prod.outlook.com (2603:10b6:208:393::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Wed, 20 May
 2026 01:04:36 +0000
Received: from CO1PEPF00012E84.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::5) by SJ0PR03CA0189.outlook.office365.com
 (2603:10b6:a03:2ef::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Wed, 20
 May 2026 01:04:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E84.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 01:04:36 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 18:04:21 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 18:04:20 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 19 May 2026 18:04:19 -0700
Date: Tue, 19 May 2026 18:04:18 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <bhelgaas@google.com>, <joro@8bytes.org>,
	<praan@google.com>, <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <vsethi@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <nirmoyd@nvidia.com>
Subject: Re: [PATCH v4 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <ag0IkpcWvhQUfzf7@Asurada-Nvidia>
References: <20260519222335.GK3602937@nvidia.com>
 <20260519234801.GA21369@bhelgaas>
 <20260520000504.GQ3602937@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260520000504.GQ3602937@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E84:EE_|BL1PR12MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a5ed148-2ea5-47f0-bc09-08deb60bc2bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|7416014|376014|4143699003|11063799006|22082099003|18002099003|56012099003|5023799004;
X-Microsoft-Antispam-Message-Info:
	hsJqSQTRDVL31dzSflifDZXTn0HssKjJ9C5OBzW4R75udXZ4KXCVx8ugPxMZkBaA9f455JKMKRbwS6yXxbpNn25yMhnU7jR8/RN6N9Sv4LNc0RASvTENwFUr8+Wlii0R8CuKVRO1n9M+2POEirSQG81C3MUsU/kLY4r/LIsDTg7+22WAkLOk0kb2QLZL80KU5/JNEKDjLSG3RVKXWHj48WEeEYijjhV0VG4fBKL4TFJLqIELb+8pQ4QhQcyaSjVnMaBKxePLKzxo79Vm5GMqODnjfkxBed2wbUtzxLH4h5PX5hG7PHfshv1SucdbinRh0wwzF/EzoPDBRqi5P0defzCrzsx2HLRomkB4+AIHELFhQKZa5931R5IJg4uZTfus7GUCegwAnQ8b7a8oA7qdLyatQQBxDFFvFVMCMU4hVnFgfo7K9PC2O4HvPgg0ixbXQy3aH1QCWkbrfLJ7NroH4bNIn0PUhK+wF2qaxBGbMGAJDaVwfsCgxOeFygnQha6xnEfnCHto9LDV2R2qRD+76SS6N8Zo1XydLVLAaM3gdJovcZMGdtlR60Za4kVZIAH9qb0tMe7vZaqVElMP42xcrLYPy4kcsLPy26jYDP6JyLhTljic2wwRWF4dUQcJ9Acmm20/ppXlBXjUrHVCz+kmDi4dJLbmx0w5iXLGz2m3oljt1E1Uir+GnvQR95papMovpKW2azQoz6PgdMD/F8sERUEamAhhODPvI5IxSoLU6NE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(376014)(4143699003)(11063799006)(22082099003)(18002099003)(56012099003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vij1HBOPxXLJD6dVsGfr3QghMd4Qpu45o0EtcHW1a9yRGp9+Wy+1c2Gq3W6FRaO7vStWc4VMbWIYtaVdq7EA3Cn7X2oEN6LI2Uc6mJdmeG/wYtWEjUFz/M+Nfhsg40luqT56ulqbCBooHdl//SfWb19CQtsfeM0cs/eEy4eWdxvbn2kikVzhg+JFd6aZzGHDvvtirPN73OwVf2aWE1bAlf+qB7JVUDsYPwu/0WSoUufNrcryOwakYfB2JUIxtOXPPTqf8wFowG++/n2mcO9eQ5BHuNj5aLKHIv1nms06cnBeB/LR6tN/6znahqAKNbrFVBNQnl+04lvApBcvJD797d6kLkUdyNh987LQNWlKfL/WbgXJyaNQ38KxCC27pqSWKMKEkpiwVb8v1frxTlsZ988PUPoEdKiLIEm0Gek0byBpFMxWv4RoGBTQYhXlcJFj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 01:04:36.0257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5ed148-2ea5-47f0-bc09-08deb60bc2bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E84.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5756

On Tue, May 19, 2026 at 09:05:04PM -0300, Jason Gunthorpe wrote:
> On Tue, May 19, 2026 at 06:48:01PM -0500, Bjorn Helgaas wrote:
> > On Tue, May 19, 2026 at 07:23:35PM -0300, Jason Gunthorpe wrote:
> > > On Tue, May 19, 2026 at 02:36:49PM -0500, Bjorn Helgaas wrote:
> > > > One motivation for putting this in the PCI core was to use the quirk
> > > > infrastructure, but this series doesn't use any of that.  It doesn't
> > > > declare any fixups, e.g., DECLARE_PCI_FIXUP_FINAL, and it doesn't
> > > > update any state cached by the PCI core.
> > > 
> > > It works like the acs quirks that are in the quirks file, which are
> > > also arguably only used by iommu too :)
> > 
> > True, although ACS has a lot more PCI-specific grunge in it, including
> > all the "pci=config_acs" and "pci=disable_acs_redir" stuff.
> > 
> > > I'm not keen on spreading lists of device ids for PCI quirks to iommu
> > > files, but it would be OK to move pci_ats_always_on() to
> > > iommu_ats_always_on() that calls the PCI quirk function.
> > 
> > Yeah, I guess it's fair to collect the device IDs in PCI since this is
> > about characteristics of the device.
> > 
> > If we leave stuff in drivers/pci/, I would prefer that part of it be
> > named to be purely informational, i.e., "CXL.cache_enabled" or
> > something similar that would also cover the NVIDIA devices.
> 
> Yeah, that's fair, so let's rename it to 
> 
> pci_translated_required()
> 
> ie the device requires translated requests to function. This is what
> CXL.cache implies (IIRC I was told the spec specifically says this)
> 
> Requiring translated requests implies you have to enable ATS in the
> system.

Perhaps we could let IOMMU drivers check:
  pci_cxl_is_cache_capable() || pci_dev_specific_is_pre_cxl()
directly?

Thanks
Nicolin
