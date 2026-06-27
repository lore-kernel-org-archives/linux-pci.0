Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010032.outbound.protection.outlook.com [52.101.193.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E9440D56D;
	Sat, 27 Jun 2026 00:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782521103; cv=fail; b=iTgmfKqayRXgBp0eKswR53PopvNHm3AxgBylveqNA6SYpCfq2e8UgaCOo9nCYzzwVPBOrd5g7McWtTHEL/Y5whI5P/1UrcgnJk1hGikZmPBsB530gD8LrZCIcMhVVpLZMafy9PIQL7pQ4mQ2Q5cWz9/oMb7vow5XxJRjIYcwUcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782521103; c=relaxed/simple;
	bh=AuAFkMWZ20dbMNVXcDo6yxQq/gIxVNna2m4b1BjM8ig=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vyefh74RIn40A2Lj6bnXLS5RkkuYEuf8GbIWyz9zAWEOHJA8/nXNXKLOpc8+r7X8eGi8L9qjo/wGnV2pPSsN3Pi5VfCNw4+Q1f12w2E71CLJBUQ5Xl8DI65Z536Vuy69eGFfj5iezs8VQtXWvt3/DjSXVLpaOYSyuerXpC7rwOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tsYSlZdR; arc=fail smtp.client-ip=52.101.193.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tsYSlZdR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJxTLQkzXM0YGIztvCynO/BlbXx/Fjx6GxU3qRHLyY3AvHTMKyMsrt5Ds0Cnm2OgzIrfzseHxHto5CQv9yA5YKL6A1I1M16qU+pqgblU/t2j25TQtoXCj3dN0oFhP0z3Dmxri2jjdlDnoXr+dCNHHYUXVVpt5UhJno2HOumHBzLMYyOZgwA+zogbMZQVrID2juqFZfThU8z8BihdZLnJm+eGnuEW7xCQ4S7VIKJpOPOdXCGWX08BaQxbcfVyCzq0FRExAbXEdH0l+ELRfYYVbfszFZF/jyk+SoMPt9QA6NYMsRdM7BlRiK6EYJfp2fBhicxM2+k9eKcoAV/gzTbIwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=teh2UxW0RwzVcHuMV81q6TJEIxRcFyvvjo/DcEXS3i4=;
 b=defT2aRuEW24EDaK/qPTFMgk8HU/KGNXr6tT7C7QHv9h7vfNKP5fiJElLjdwabXsWxP7y89ibH4sXNNoB9sCfRFIwcaf1aPSvzwMjfO/26paxsa68aog59jR+JnWdEjpdQgLjuEQucQhYOMp45zxus3IUtCe7GjsrS9q55cmFHzX61q3/FUESRxrsuBMfjk5GGiZ9Ic6e+DPTqG82uqY2OHHx2991JQD6hIcizCYt7fq/olw5yQmTL0qQqtFOAgg/P+SbRMMmOdEMlw5ERyFkl9C8x1SZBCACGkXDvn6SNxav2BlOYh6YMyHZ98Py0OCZ3ViEwoog8hVZjpQuwedVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teh2UxW0RwzVcHuMV81q6TJEIxRcFyvvjo/DcEXS3i4=;
 b=tsYSlZdRSCPlT+8r511Y9MfV1UNrIvmSEloE20CSqaBX8XVio+MKPY5FToE0vm7umK99QsVrgq8bw9xk5RFNDlfkz0sOgUaGgEqjWwDgHQ9z91IwHXhFli2HqjEaxYtF4ekxocvDQk+RR6lwojiORPKhu54TW503OCJwCzZZNk/LohPeD4Yy6gJOlqKd5cril4tBNsk+/QkREwICmchZTemzONipX6IS8KYm6eTggcv9wSKs4BIOmogNW3zAwa8Q3UG9x5cEM+rjhaJOnTJZI4vDn9rgnnpaAm0c1lWF8aQwS4WXRlWEZCi4kWbvdV9QZFxrD9xmCrORCK5Gr3P4JA==
Received: from SA9PR10CA0017.namprd10.prod.outlook.com (2603:10b6:806:a7::22)
 by DM4PR12MB7696.namprd12.prod.outlook.com (2603:10b6:8:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Sat, 27 Jun
 2026 00:44:56 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:806:a7:cafe::60) by SA9PR10CA0017.outlook.office365.com
 (2603:10b6:806:a7::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Sat,
 27 Jun 2026 00:44:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sat, 27 Jun 2026 00:44:55 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 26 Jun
 2026 17:44:53 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 26 Jun 2026 17:44:52 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 26 Jun 2026 17:44:50 -0700
Date: Fri, 26 Jun 2026 17:44:49 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: <will@kernel.org>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<bhelgaas@google.com>, <praan@google.com>, <kevin.tian@intel.com>,
	<kees@kernel.org>, <smostafa@google.com>, <baolu.lu@linux.intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<skaestle@nvidia.com>, <mmarrid@nvidia.com>, <skolothumtho@nvidia.com>,
	<bbiber@nvidia.com>
Subject: Re: [PATCH v2 05/11] iommu/arm-smmu-v3: Submit CMDQ_OP_PRI_RESP for
 IOPF event
Message-ID: <aj8dAWZ7GGyxfUdR@nvidia.com>
References: <cover.1779944354.git.nicolinc@nvidia.com>
 <6c713c724fa09bf5a1b5e2247c633e516036f079.1779944354.git.nicolinc@nvidia.com>
 <b5085e09-6533-4f88-938d-8d46751cf7da@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b5085e09-6533-4f88-938d-8d46751cf7da@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|DM4PR12MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: ec9b7f84-51ed-4f40-bb68-08ded3e54ef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|30052699003|36860700016|82310400026|1800799024|23010399003|18002099003|22082099003|11063799006|5023799004|4143699003|56012099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	TOzJR1OLDdw4SJCIVojUth2pGhw5GlW+GEdwzPASGLCUUEJafULEyGvxnZizl0LDNidYGKPqihzxcqGg4x6fBJfIE1frfkncx6N1dgzfgdFZyU8yyYbi8E4nqFqiSXflp6+soC43yjXj9zPFqwivyio1CE6GIgVps4nDqw5J2vzK/7XWgECYq1jryHivwqFqK008E4aCER/P7vb6/IXbGo8ea4PpRqPCblh2iwQkseX+eMQxZr5kE47QNhd8JaimD/0wTjF1MUbPcMc0LxyuZIlSZnqtfSoqAIk/2P9bWgcNDhf5M+lhyt2Der09tDih6B6G4V2HjOw3MjyKGwi4jCm9QqkPADMhA/cwhemYOUNHCP/nUB/hD75NJNPuSReqHLrR5UsnSlsxcJmLPT9Fng4Dyck702YFsJOCyc/Ue72fI4nbl9PLyQaMNYSoXNXkwaCpEkAiyX7nQFbGPitWq2/UIxNW7ejkqx/e2m/WcvFu/ibIxervIzpFa67Io8+2uImPEzdWdxW2c1UdvSrv2QRN6bjM3Zn5GRotaJJR3Ga2/1hatzkHTXAVG1QENO/RfObHhaZOo9fp9QZlRGAbNfqZcuw54hMGy/AmGirCnX5dRUA5GFJ2MbdoLRoT1BzmoHw+79Xae66kf3nU1dYGu8FX0TawfRZIM/MoJRgvZWnkd9NOURoxzMzqr5uNRNt9uPxRc1AfvhvpRlfpY/gtAQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(30052699003)(36860700016)(82310400026)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(5023799004)(4143699003)(56012099006)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JEsBIbiYTe7fb+MRgEjVwj+lgWhJcSHjOujyz6x9t2Rn9TOswhKINxh6BWSmXfGRNVENmja3dJvfV14d6It6aCt17c0P3RLUBnaOojrfD0m0M2qgEhyiS1R6W8xbG2mOcdjkwO3oqHbUS11faAbyfMLUa6wlC9ar4nBHCSnTnr8rYQN6ZRxer5TdIrzl/w/p+eJDA+08teA6Z7Rlo/W83U9MzQGSPIyjiz7MEcmve2X3cRkHl4S1VJuJ2MnwcSD8GMwtLkXXOoK0thvdf/CGQ1Ao58qeOpg0oFfNT5fltZQydjS/vcOya/TMPG0szgBIIj0TxDKiGKVXScygHmC6ttRMIJAjAooLCKVvJjuNtuTvJD2ppm/L7NqYP0A4QEL8mAp85T2BkcbElWyjN9tsh9vcMyHTS/FpkyS7PIM73JL8YXBVzIArugQX9OGf5WW6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 00:44:55.7432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9b7f84-51ed-4f40-bb68-08ded3e54ef2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7696

On Fri, Jun 26, 2026 at 05:15:13PM +0100, Robin Murphy wrote:
> On 28/05/2026 8:59 am, Nicolin Chen wrote:
> > From: Malak Marrid <mmarrid@nvidia.com>
> > 
> > To handle IOMMU_FAULT_PAGE_REQ from the PRI queue, arm_smmu_page_response()
> > must issue a CMDQ_OP_PRI_RESP back to the SMMU.
> > 
> > However, either a stall event in the EVTQ or a PRI request in the PRIQ can
> > surface to the IOPF infrastructure with fault.type == IOMMU_FAULT_PAGE_REQ,
> > and a single master can in principle be both stall-capable and PRI-capable
> 
> No, the SMMU architecture does all it can to specifically forbid this, see
> 3.12.1 and 16.4, it just can't be made architecturally ILLEGAL to enable
> stalls for PCIe devices because there's no strict architectural definition
> for what "a PCIe device" actually is. Similarly with the note in the
> definition of STE.EATS about the relationship with CD.S - the unwritten
> implication is that defining specific behaviours would only create an
> unreasonable burden for hardware validation, for the sake of something that
> nobody in their right mind should ever do anyway.
> 
> The expectation is that RCiEPs which do speak stallable non-PCIe bus
> protocols will not go to the effort of implementing ATS/PRI capabilities
> (not least because there's every chance that such protocols simply doesn't
> have that kind of transaction flow anyway). And conversely that it can be
> considered an egregious firmware (or system design) error to even claim (let
> alone force) stall capability for a real PCIe root port which may be
> deadlocked by blocking its requirement for free-flowing writes. Thus I think
> we could go so far as to refuse to handle any endpoint which did somehow
> claim both.

Oh, I missed that. This certainly can simplify things here.

I will fix it.

Thanks!
Nicolin
