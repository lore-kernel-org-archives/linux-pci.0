Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127BC2288CB;
	Tue, 24 Mar 2026 01:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774315328; cv=fail; b=GZNJ+YqIZLHFfwUMPWGRzbKvp34blD4epXN557pdTtSaXFGUA/6x0aBoeF64ZY578xgpJjJjHt1FcCuAgG/vseKH4kO4XUfML2cIWf/tWJ6uPg//ao4oeJnZVe+jJESS+c/QiwBrW6dzdNiisjyrfcp/TelwD+HWbAT/CF9kJKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774315328; c=relaxed/simple;
	bh=wNt0n0ddbua3uzYfrJJ80C4nOThin4jFjT9gtsOsgXU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1NFWPlUkUzAi2BwEkjAeTinaWfK/8+xev4CTGVrMSIVbTtF4e+wTt7Aektn19kgY9SiZWN9kuWM8SCLp/3a5iorJOee2IqZ14wx+QvkSum3KoQlXSpq8mRKpBHwS9rUTGNzABIRxgIhz8ENpLNfeZNOru4w9vX7GJDcuWQYjd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HfySuETy; arc=fail smtp.client-ip=52.101.53.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HfySuETy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYRXGzupR1zONHuyQD0+EPqwE2tFv5n5HdoHTZPNLyc8ZaDp6QM5VFWKz5esWjZy77FBid5Bjf+CmY9ZIA+HvmgtAbDhWkoQ/WWfUcWJt+kMwgg1QT49RqFJ9+xSgBZTFsRFCpcYs+1yrDheNZ9UC79lnAdKFm3ZAWuxL6bnaSoHY18fdb/U30KWZd3DHMeXguI1Vnd7wclnXpCDh0My2RCWYymQ5GLjGjd0LCLYElSTBra+EGp8zPqWb/x/0B3+Z+PPFwV5LL/+inlmlj3s/3/LxX7T2zhH62CCROdFYtKrgYGrUlTEgAkVDwPnu4aayj+LFOgGBtg49e0TtJ4AaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4u4qwOi8947afJmL/tJWDvx8LLwnPIvS8NXvU0hxLI=;
 b=OlJq2Tlcxksvfi5jgMK0SJjEClJmHrh+JhNhl/gIKYzqPF1oa8wBFI+3UkgW0f/Av47V/NXhNcc+bA/RBC8VM4JLR0CWm0AiKuqeFyY2gQh4SPov7L9fZO8V/raa2LlmMpWsGJVJJ3qi91Z+pqT7Nro1JtbrY4C376i+4EtdE/+ewVnW1o/Fcsj080WasHUCFJfOnSYVL0OvFpbWSLcrZzKRy1xFHjitd63IZ9P9cP7f1bN3BQE/wjr1MDELALNweVkzA/MDlDPTBezCsUSRMUD4vfUDpYSAGtZPACDryOJEsy1/kPcuWpvMnoh3m3hQSswJwmvPDacXUiLZbu/OZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4u4qwOi8947afJmL/tJWDvx8LLwnPIvS8NXvU0hxLI=;
 b=HfySuETy+ddMNyk29+opfWC6Q1garfX1uFG1qbTTS/2hRVehQiBuKkHhW6Oje9CQQplI9SsfGdDA4YxNtG6WG/Y+50b4XgJRXMBBuX72N49GW0xXv2b8knTX7aQPOeuFlTDaVW+gYd2y9kTsw/xoeMnkgUiws51QKgNm6+f4QbcQwN5kIdoznGYTDi8LmA08Acd2Y2567MmEaWeuwRQDH02Q3Q4dUQBKpC/rUIh9SMp9aHZ97YVo095KljeCTBiBmMO9vOOTOmyRhV2jtNgO+xIwNkYmMngHtRD8WgO00QgNXFtMtOw7UnjKy/fi8z3cvzOtDzNEo+kLJXdgJQw0Ow==
Received: from BL1PR13CA0002.namprd13.prod.outlook.com (2603:10b6:208:256::7)
 by SN7PR12MB7884.namprd12.prod.outlook.com (2603:10b6:806:343::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 01:22:02 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:256:cafe::9c) by BL1PR13CA0002.outlook.office365.com
 (2603:10b6:208:256::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 01:21:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 01:22:02 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 18:21:52 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 18:21:52 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 23 Mar 2026 18:21:51 -0700
Date: Mon, 23 Mar 2026 18:21:49 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Samiullah Khawaja <skhawaja@google.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <bhelgaas@google.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <praan@google.com>,
	<baolu.lu@linux.intel.com>, <xueshuai@linux.alibaba.com>,
	<kevin.tian@intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<vsethi@nvidia.com>
Subject: Re: [PATCH v2 4/7] iommu/arm-smmu-v3: Mark ATC invalidate timeouts
 via lockless bitmap
Message-ID: <acHnLVtSgbcAbX2M@Asurada-Nvidia>
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <0c5525367cc67ccc84a675544d1d9f8462704065.1773774441.git.nicolinc@nvidia.com>
 <absfAT4jgL2f3UfR@google.com>
 <abs0CQCrFlCsV6Ls@Asurada-Nvidia>
 <20260323235756.GW7340@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260323235756.GW7340@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|SN7PR12MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: d32e9768-a953-4428-3dba-08de8943c0ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|7416014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LCFr2mvtLSmm3Y83inhfAiVSoDUBTkYD+DhcxEjOgGUyF8LhBNZbIhv350q5lPiQA5hUyteBD1wPo/CisA+hYNCFor8yw4Ptqr0BObpL6idnTpg4lP82t6QZEu8g10XtO+CIMbaitW4WzVieK66f/xX2ENB/5I+c3C3KvDsolJviMqTPGCUUeRkqZ8HF/kCLQwkFxc4WfWP6gCbQX8ghSKeDxG3erNhIIThuquGFy0IPWkiYCmsC0X1OtGgCe2fwyLN1tS7S7dMaDynYLL5gJdmXQ4nHT7RZI0rfURon4U16O/PODn92CJ49TdI82+R9OMiUuoGCx4lpd6cv5X4Gj+IjB7uYrjVknDEz01rlieuLFIPRIZudzUPWZhvaIDFBFMi7RNM8hxX2A+zVNFP09kNZPgnEGxim7BQsQaobaIS+KLSzMBvHQlhYC+Z+ueL0jKzomxhpPpsXDOJQ4XG4zow5mvk7+g72QeKL3BFqwu6zYEa8zkxjuEdkqtJi6Gj98bllSLP++Z9MSHZGtiwalBq8ylNQNCz2TtzkoVDrhdtd45vv6+TtZPdBxskG+QRlXW8FHuwfFv+f5ZEI6ST1wVRbeUxvu3WbiIj3V3yUXYROvAYW+k7pBatJneWyN6OkVaZoRVum00usOWcqOrZh5t7dYrPuE5k5OQMHOLjALNpNRbP/p8FRywQa7k7+392dIaxq66Dzeq9aku93fXRN0kqb8y3Sl3ZEsQa1IL+wyHpSgmMxL8/O4nlUR7ygKTvw7T0HeodNi32RRIDy+uxzpg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(7416014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RlYBIietkzF4TruvkgxrJrUa7wksAzu8CW7L2wBlaNiEMOmezU1+oc8uLs76bHcP+lphzOongBO3AzTlnwO2Y0TzItjNgnwhXnPlHxNAlbLAtnhFBL+Nb5Lj6p7CtIBYVCvagfrNRYZlW8of6WIprMkDxvOfl2oZ57AdJ7K9ZY4ptg0rUbvufkHTVogKg6KXz/DAPGkjC/Zvau/ToB16mGUTKcc24P/52/X6IDNsnm0OvcVt/xxeVRcd2I/6t7dQU9oF+4HWtRkKx83pTJTukJjNRm05eUfRKFh8WOaqtAfbwQnw6hwpNHnhFJlv1QXYc7FEw9y/5HvMHDkqwEZZgCwa/RP/Pz+VqMopf7uhiGYUVyL/Gfb1W6EoCo/ELTQscuS2wSvuylqROOmSXQ1hsNlogmNwJ5L6G0fARNfA6eajOLC9Wg7UCKBCW6+9KzXz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 01:22:02.3755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d32e9768-a953-4428-3dba-08de8943c0ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7884

On Mon, Mar 23, 2026 at 08:57:56PM -0300, Jason Gunthorpe wrote:
> On Wed, Mar 18, 2026 at 04:23:53PM -0700, Nicolin Chen wrote:
> 
> > If the software times out first at 1s, it means the CMDQ is still
> > pending on wait for the completion of ATC invalidation. Then, the
> > caller sees -ETIMEOUT and tries to bisect the ATC batch or update
> > the STE directly, either of which involves CMDQ. But CMDQ has not
> > recovered yet.
> 
> Yeah, I don't know if the SW timeout flow is really all that RASy here
> right now. Without somehow recovering the CMDQ it is pointless to try
> to continue after a timeout.
> 
> And we are really in trouble if things like normal IOTLB invalidation
> start to fail.
> 
> I think the right thing is to somehow try to recover the cmdq and then
> restart it on the commands that haven't been SYNC'd yet and just keep
> trying, maybe with progressively longer timeouts.
> 
> Just ignoring the error and continuing doesn't seem safe.
> 
> But that's something else again, as long as ATC invalidation reliably
> hits the HW timeout first we should be OK to ignore it in this
> series..

Yea. I will leave a FIXME inline for now.

Nicolin
