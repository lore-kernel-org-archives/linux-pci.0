Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013006.outbound.protection.outlook.com [40.93.201.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8142E377A80;
	Tue,  6 Oct 2026 17:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791307645; cv=fail; b=bz+o+K3hDcaD+VbJaVTNh0TQuYDXLg1R/DsxBgrMNwpsoOzbO493QAz/dqA3MBk8CAeIlEoo9GUJoIH0SX1WwU/Q8wdZ/ZCQnorATQ4gx4m8wFFW3QsMWlN+9IWZGArSOwR6Y5AaZa6tZrgjVeUtyeA/QoUKOsgu0tYTC+j7hws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791307645; c=relaxed/simple;
	bh=8Ov+NNl747DYuuRKgblzdusZV2JAiNYb7FnBYKs6jDM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cyduphl/aO8nLk2h7pbDdW15m0MZtfeTWOYbnFJXl2lSJilgfE4Yr5n4NO4zKhIy1LtAfQlfyqwu5h7HCcJK21FWTZjTn3aFKDBlfA+3sh+UdQjbdaMhE7cqGJ7jDdXceFUeBDZQbyOR6GCRu+GC/mhOnuPx5VosfC3DjywTg9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B6XhkOG5; arc=fail smtp.client-ip=40.93.201.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B6XhkOG5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FScoJr500Yx9RW7SKHqCr+ZoQ3XW3yBLK33Sb2ulIYKftyvxWzcMLoXCyGkvFeQqGA86OXeWV27P62BXDAKG6APtzmYs+nobl/lqLBXVqCc/3sNm8wWS8VUeQFRDoYguJDe/fx+97j46Z3aU2aDNb24q+ldFKMrLjqH7Tme7YcnkYKL5Zuqu+ZW/jDzIKgKkbnNtsrsuhNr7HN6XwBnO0GyLl94+PVw7wtNQQqDfA6v+hddYg4DEfLXLNyUuUt7KP7dMuCvWbz56iVk19qEuGXYyD+Q3udva00q7cATS3FXTHNJEOgkTc0WDIK0hrw2qrihWdaLv60toj6TtXJs5ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2bhA+uZ3vUrcb5norWF7VUtyFvgn68rxkSwA/DkM+A=;
 b=himKe5n/Ll9xgvmUjCHCDUUj64Z32/xCGvKe2By+pVuORMgt32L8oOaqngUe6M55PO2nq9+2HQurxkfwzYgRdtKar13V4+3sjqhUgELtQkh2dmBHFpv2/Ni3RSQTBqTAXDE1+nGegAhqfWjaIM13EPMRhAsiolu9xNthu3xLcLyhNU5tV76JCAt8tICxZUzdxaPffl/vkGfa4h+SFa7Gm2BwkF9eXTyk/GLha57byNzeIS/VXjgl0BQWI2dkwwWfp1CUuqjngeJzb16KN5UT9phllKz7hr/83yAMQu8s+amS+UrfEXHKjBYFleD78275+z/hz/UFfmepH2A1aYVhvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2bhA+uZ3vUrcb5norWF7VUtyFvgn68rxkSwA/DkM+A=;
 b=B6XhkOG5Zxy8qQKL0c0tKrDZIjUAmr9d8QhTR6ZBdNOv6n/uSPALrGtDy2FnZAxvbMRjTKsArH/GZLkLibhJGuoEb3v06HklD7Yjgy57jxf4zX+1bFg0/x9+OFf/KhcpxsiVdPYuP5rfAoA1oQTn3JEQ77D6DDVkvPSAvL0Cvy7ceklDcA26jMhdpfidUL5X4TR6/5zqkWdlDD+GPzaRhoo3iqV2qlco+P1+otEAOfeAyVFRopIx3l81Ou7oQYOKGLdVyvk7Whb4dDNyvwz3D9w8irfQ35wTXrZPCvn60Fl18B202BduH0fGfURQKV1HSEeQDp11VzQM6asAdPzZ+A==
Received: from CH0PR13CA0015.namprd13.prod.outlook.com (2603:10b6:610:b1::20)
 by CH3PR12MB873938.namprd12.prod.outlook.com (2603:10b6:610:366::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 17:27:17 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::75) by CH0PR13CA0015.outlook.office365.com
 (2603:10b6:610:b1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 6
 Oct 2026 17:27:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 17:27:17 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 10:26:45 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 10:26:45 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Tue, 6 Oct 2026 10:26:44 -0700
Date: Tue, 6 Oct 2026 10:26:41 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Pranjal Shrivastava <praan@google.com>
CC: <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Mostafa Saleh
	<smostafa@google.com>, Daniel Mentz <danielmentz@google.com>, Ashish Mhetre
	<amhetre@nvidia.com>, <linux-arm-kernel@lists.infradead.org>, Thomas Gleixner
	<tglx@kernel.org>, Radu Rendec <radu@rendec.net>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <rafael@kernel.org>, Danilo Krummrich
	<dakr@kernel.org>, <driver-core@lists.linux.dev>
Subject: Re: [PATCH v11 11/16] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to
 gate CMDQ submissions
Message-ID: <asUvUf4PZJ7JCLXp@nvidia.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-12-praan@google.com>
 <ar1yNtr7Kp2OTcDd@nvidia.com>
 <ar3yWUmi8E0k37Ml@google.com>
 <ar6gY9grmdMZcN/M@nvidia.com>
 <20261002164748.GD3481470@ziepe.ca>
 <asAeCz_rmpe5hbsh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <asAeCz_rmpe5hbsh@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|CH3PR12MB873938:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e5184b9-7d05-443b-15d7-08df23cf1200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|7416014|376014|1800799024|5023799004|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	oNoxu2o+yOyAyjH9D+1LRzLDxI9f+HufROL+/5PhCmrnxFV6BOn+aebeAH8XqPqgJ0sho+BWc7/SGeTfC7z7NF5NiUl2N1ioxTAbmA59GHDq52Y+MOglo9GFn5md7MWl8fH1OxPehcQm17Tj0Ti6DlgBHNPaP0oRofMVrw+n4gPrdPGlkz3nnP73bus7s1qMwpvGtFb5V3uCcxd5QhR1XdgR3Df7/gVUgqfWPlw+CaXWLJ4e8o+tQW+RrHLcj3Vnw3K2krb30bnaotoERYVn/k/Ew1nVwB+LZEGjUpCRlUZN8aJ0HoSwwUKeSgnL9dyvpUu1Q0ckCiS676esZ89LysFkOzzGF+F0H31VjdID+0aoLdX3OYoXVOZQlcbtlc3rZWV4r6Y+SbMDxnt5vi+7QlweYhQLp1gT8cPrD4+2MdSHv/Ow2IyJHnYAvE7+ijArqirp8dvmpxOkrwHStiX4/gb//aRpk7ag0b1gptjlwLHyXTf6R5xo71EWOcM+dy0BEOjkFnLyi+AhCr2doi6x8932sey5HWkK+nBCBCL49+LBlIB3u5l7+1T5kellBf1j2HPOVtgBqgvGeOvrDLZARQpC62YiRLw8I8HIbIcXU6G6QIbkRfYSqOlk5cIhJ2zT9tEPRIDwKWNjuBq5ZERHV9G43sEGAFiYR/SNXOByWDx5aUeuPtpAyPlAImd5r9DSd+aiw7HVwNvtWgFHTA+YsQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(7416014)(376014)(1800799024)(5023799004)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6on5dneOxA07jgzPwBKxzb8L+veZcqZOhTfU8TMMD841DjK/Y8YM0NxO0IbxjTw6Nh27xVKlWkcUpuVQamUiRioWOF68CytCzy/WSe6FJyLTv6d83PqeDcnhdmDam6kTArvHA71BGK6JABS/q2SR3T1GJht+Cicgktrc71ryBL9MEYX8/uKX4J4nf4AUZcof9XkASjDKq3AcgzpD4+v9VYjWrr8Y1jfdO5Omb+tlhFKqEOea6z4m1sXAupA7ZVpXRSiToepMT70utehgLg2xqWiwjgImHfjZOqcS3VBlc9+YTfY3gdXiBNNvXedYVWvO53tgS8Y1IOsfjolbOphuToj8/qhm7LmXh03Vx7cyL7uQouPD3vUfaiYGO8yxDNeZ1H2yRwrhvAfiDKbaJHb+Oo1TuNgWRdS4o+sXN6lhO+uy7v3BhkFvPLY/Nr9u8oqk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 17:27:17.5583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5184b9-7d05-443b-15d7-08df23cf1200
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB873938

On Fri, Oct 02, 2026 at 09:11:39PM +0000, Pranjal Shrivastava wrote:
> On Fri, Oct 02, 2026 at 01:47:48PM -0300, Jason Gunthorpe wrote:
> > On Thu, Oct 01, 2026 at 11:03:15AM -0700, Nicolin Chen wrote:
> > 
> > > > So we can't issue ATC_INVs during suspend (the EP is already down), nor
> > > > during resume (the SMMU resumes *before* the EP is made active). The EP
> > > > can't use its ATC while suspended, and if it loses power/resets on the
> > > > way back to D0 (from D3cold, or D3hot with No_Soft_Reset=0), it comes 
> > > > back with an empty ATC.. same assumption the PCI reset path makes today
> > > > (pci_dev_reset_iommu_prepare()).
> > > 
> > > In that case, would the STOP flag be too late? It's only set in
> > > the middle of the SMMU suspend. So, an ATC command (via doamin
> > > invalidation) might be issued prior to the Point of Commitment,
> > > which will be timed out due to the unresponding EP?
> > 
> > How can you ever fix that?
> 
> The unfortunate reality is that this gap exists in the kernel even
> today.. upstream SMMUv3 has no RPM, so it's always on, while the EPs can
> runtime suspend independently. So an ATC_INV can already be issued to
> an EP that has suspended. I'd argue RPM improves this slightly, since
> once the STOP flag is set everything is elided, so the window closes at
> SMMU suspend instead of never.

That doesn't sound very convincing though...

> > How does power management really work, is it expected that the end
> > device is already quieted by its driver?
> > 
> 
> Yes, power management would topo-sort all dependencies and invoke
> suspend callbacks accordingly, i.e. in our case the suspend callbacks of
> all SMMU clients would be called before the SMMU's suspend callback.

If that's guaranteed, we should probably -EBUSY the suspend if one
STE isn't aborted.

> > Could the first step in power management install a blocked STE? Then
> > we don't have to worry about ATC desync and that automatically stops
> > generating new ATC invalidations if we go and detact the domains too
> > 
> 
> Partially.. at SMMU suspend we set GBPA to abort and clear SMMUEN, so
> nothing gets through while the SMMU is off. But that's global and only
> happens after all EPs are down, it doesn't stop ATC_INVs in the window
> Nicolin pointed out.
> 
> One way to ensure the ATC state is relying on the PCIe spec to lose ATC
> content during D0 entry from D3cold, or D3hot with No_Soft_Reset=0). 
> 
> Another way to enforce this, is to *somehow* ask the endpoint drivers
> disable ATS during *their* suspend, i.e. in the EP's driver's suspend
> they could call pci_disable_ats or a better suited helper from pci core
> and the in the pm_resume / rpm_resume they could call it's equivalent 
> pci_enable_ats, counterpart ensuring a clean ATS state. Or maybe the

pci_enable/disable_ats is used by IOMMU drivers only.

> pci_dev_reset_iommu_prepare/done() pair (with slight refactoring) in EP's
> suspend/resume?

That sounds right to me, though a different API for suspend/resume
will be required. And call them in pci_pm_runtime_suspend/resume()
maybe.

Jason, how do you think about this?

> I could mention this explicitly in some comments or dev_warn if any of
> the masters have ATS state as ON during suspend?
> 
> LMK what you guys think of that?
> 
> > Maybe I'm wondering if power management should involve the core code
> > so it detaches all the domains from the device, setups up blocking and
> > then the iommu itself could power ofF?
> 
> I'm slightly against the blocking domain attach because it's a
> reasonable ask for the client drivers to be able to dma_map / unmap when
> they're suspended, given that most of the modern IOMMU state is
> in-memory and the only HW state is some sort of TLB/ATC maintenance. We
> can map/unmap when the IOMMU is off and just ensure a clean cache state.
> Drivers often want to pre-map everything, power ON just to run their
> workload, power off and then unmap. 

If it's about mapping, it shouldn't be a problem: while a device is
in suspend state, iommu_group->domain would point to the DMA domain.
This is similar to the resetting flow that only sets gdev->blocked.

Nicolin
