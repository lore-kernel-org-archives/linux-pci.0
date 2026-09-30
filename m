Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012054.outbound.protection.outlook.com [40.107.200.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D49C3BE642;
	Wed, 30 Sep 2026 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790799210; cv=fail; b=BqcJ6mInw3yl3y6W/fzDKlHvW/H7lDF5fgXGj2QqYgXtF9236BDG9oUYgm89RhvG3K/dTFCA7Xjq/z2EH6tZYd+3bbIFZOBGNcUoUtUc+/f5U8ntCqqB1VqmXkTQhOgxFoGscyi5x3ICWr5HEZtRmlXAa/OwoqkLlj7jlpcsXDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790799210; c=relaxed/simple;
	bh=NKr9N7MRTUydCjTyZxqH46+YroSLkpioY3EqUqQIRUI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1xjVSrNDTwlNF4IZ/vb3Caz0p0qX0XDHCNZBTixNNt/IpCpHqCXXZAJKWp70qab7VIhD0J/+BA7RBs5CoYjLKvAQuDxpm19Y2h2FTGegqe0QN/f7gOj/NnWJeHsJjXkvddSMLedze/XW0A/mtGsy8Gd0IR2w9ex3GpUaUzCvGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lgkQ6uMI; arc=fail smtp.client-ip=40.107.200.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lgkQ6uMI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PVnIdGiAK+VvVtZNr6XAFQbybTF5YSh92D6cOybtYFl4oy7Zvfs7F/t6xcisDFFd/3hgWxhwT6B0nD+fY5P53Gummi/X8IscFsPjcvRy/f0gF/XI0sg3BeNuLlRNphKynA1HJnq7qVnYGkvafWYE+5RFwZEtlSN0vSvvmZG7msoiyz0DoPMehvqOqFZIXFwkp89PNdUidtge9Km3lH2db39AZdqjahan/39TNhWWYy1/UYILd8oK7ufhr9jtEUm7PT0DJ/wAfz8NV+en3WPn1q2u6Cdrbsx6rnLeydiMGV7DNSYG47fiy/c+ws7SxLbXl4pWKz+/Viiu2xL8rNmcrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgPrgtmYPVNyHOhrAS8UBVFYEHf1rPUKodz1a7ElJ8U=;
 b=I5KIrCJkXp7yXlZUatoG3bCXzMllBbZfFHVLvIzx0F1yO2mdeM+HGROa5bTDP60IgsES1dnFIn7ym665nmyk0aCOr8D+5f0Ip7Z7uqYv4I9P2Gr7rHbfs0CocUUL/aTXic5Yy30BYgc1SIlAKQPql0kPkIj+MVJ5ujCXCF0aKtaBH+pF8cpzBUl42BNOvcoltJSzsfsAIEDITv7Yz6Rvy5a0V3t09nBVE7EA8bpUWmJi168XMozoYoWJTNABX5EfLsUOzTD+SPrMxS6bZXWy4RZVpinzt3WdOcE7k0N17ExQA6cf75UfT0IaPsMjvLFr+sNAnRW2MdX7lyEzTj4D/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgPrgtmYPVNyHOhrAS8UBVFYEHf1rPUKodz1a7ElJ8U=;
 b=lgkQ6uMIEOLZajUYvd0HwxaFfrgq5MJLpI3CDUqHd6jMX1+mFp/LgY/LlrRze6BsXb96LhOo3BtZU8kBbq+ttW0u1K4eife72lCW8qIELNatdJJ+zKahoobjNXnxmQFua0V0WzFCOOJHb/Z0VLCU4C2OLuBQlZrQz2ilRIthiGX+Lx1OrUoCUKk8hGd9RrI8x0UQyqPusiLHMHrRakHWYg1VPUkaKcO18v/vo67vP9eYZ9WrtKDYMlOgiaHzni7oKRjIODpKqPfGxGRb6yuaSC5fLIYnrmELS0gwxcPMS/DF5FcdxloI4nRaQg26SEkCHaFq6z5RFVBna/JR+eldRg==
Received: from DS1PR07CA0015.namprd07.prod.outlook.com (2603:10b6:8:44d::16)
 by CH1PPFE5ACC0FD2.namprd12.prod.outlook.com (2603:10b6:61f:fc00::629) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 20:13:21 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:8:44d:cafe::10) by DS1PR07CA0015.outlook.office365.com
 (2603:10b6:8:44d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 20:13:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Wed, 30 Sep 2026 20:13:17 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 13:13:02 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 13:13:02 -0700
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 13:12:59 -0700
Date: Wed, 30 Sep 2026 13:12:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Daniel Mentz
	<danielmentz@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>, Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, <rafael@kernel.org>, "Danilo
 Krummrich" <dakr@kernel.org>, <driver-core@lists.linux.dev>, Jason Gunthorpe
	<jgg@nvidia.com>
Subject: Re: [PATCH v11 10/16] iommu/arm-smmu-v3: Factor out
 arm_smmu_handle_gerror()
Message-ID: <ar1tSenOxhYRRlJY@nvidia.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-11-praan@google.com>
 <ar1WQCud+B3nAWX6@nvidia.com>
 <ar1qX_Ox2ONgcZM5@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ar1qX_Ox2ONgcZM5@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|CH1PPFE5ACC0FD2:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a9a6102-10d1-4a02-eb3d-08df1f2f43d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700016|23010399003|4143699003|260925021911599003|260925022911599003|260925021311599003|10067099003|6133799003|11063799006|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HbkWfD0ZLRJVGarrMUCo8kiDYsZ4UJcgJFLlMmh2jHg62uEcxGq6Ee8LvN7jrTIoZogRYdkFApytTZlsFQZ25o1jM5tC8mowMFU47FujYfHixTZ4hQQyNyBLI9M3QXGnmNG1iI/HFtWUSVWn4su5Bm4eiBNdblU8pi+fEshxIMRXe4aKVqo3do0KSayb8BOqU6lUfynRUk2Xf7QyGYg4yAA+ll2sL0g93qQriPtjNEJ6R+RwjrxqaGIrIxhxpno9Pn2LWM79ThUG5fA5qkgXB9inzvXQGfyNna7R4t4oeo2NH28NmoikRLQAS8RAno0YcQ0zzDOD2RfnXemMM4dnp9kuzAzSW9jpU5gY7IISQrZYM1+Hkdy3Yx9MfeTTsZRrK47e9B7CXYVyPKovytjPisaQ8VYILdWamEWz+D0v3IsaL1W1l3wxj5XeMnJMTKhhMBsuvxFNU8qHJsGOvMEm9EopH/qTZDm2tF4j6TahV2qvnl/0JOQtlzq7hpnPpWo7Mdh2rG2gJ6/TDKwNnw9DJpJQoHzGpMLNgy+tXrEtdzQc+Q5xz6eeS32kMELnqDQjCOXYWjLMhogjGkoam7VRdbcsZ3gW3Adh1PAuASI6gYsY9aHRA3wIaqtWn8Q1Ekr2J57WnPY7rMB573lvQxfLWw/BELTkUoZ4g1xG7nY99ZGQ4t6Gx8j4l2eAlN5BeWNU+Zbaxc5UfB3//PbQGMRRvQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700016)(23010399003)(4143699003)(260925021911599003)(260925022911599003)(260925021311599003)(10067099003)(6133799003)(11063799006)(56012099006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	21TVMOVLXRpVAOpvpxoq67I+7azxqqIn9O6m6x+g/RMvokS3za8DhIQCEknpCt+Ijj5n5v4QEgihHN4r3EMWPH95efP4VY3Xb7kvj2mK5GDyBXA1L8LvTipyvhkwp7Y8HeeHK1btiJwq8hSE1sGrv9SiOCbk4eQaVg2GNhXVZV0oOjJ5jBL86Ppnw4uOLazNbaOA6rBmlHATWouLvl5rptfLZYgxVFJSV/I0T3FxLejrq4ZYjmFkRIJCQtK0Jogsu1dDTkKbmaolyBpkjcEGTdbRgTkcRECN3HLflVnJiZoLBvd+FBw1dg7zuQHb/dEKG0mVYpPoUOyLQ5UcmloOYCA4BDaGhwQcVG+1L0QFbl8bQBJC6Ttulp4b5oI2lfEm6t6appN/bjLCVHJ95h/9d76IRwQUM5yVGhIh5e1p2Rsox9JwJDOjwdPk6K4yvy55
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 20:13:17.0663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9a6102-10d1-4a02-eb3d-08df1f2f43d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFE5ACC0FD2

On Wed, Sep 30, 2026 at 08:00:31PM +0000, Pranjal Shrivastava wrote:
> On Wed, Sep 30, 2026 at 11:34:40AM -0700, Nicolin Chen wrote:
> > On Tue, Sep 29, 2026 at 03:45:04AM +0000, Pranjal Shrivastava wrote:
> > > The GERROR register's state might be lost when the SMMU is powered down
> > > during runtime suspend, requiring the suspend sequence to handle any
> > > pending errors before the hardware state is lost.
> > > 
> > > Refactor the gerror handling logic into a helper function. Subsequent
> > > patches will invoke it from the runtime suspend callback after disabling
> > > the SMMU, ensuring that any late-breaking gerrors are logged and ack'ed
> > > before the hardware state is lost.
> > 
> > CMDQV has a separate IRQ, so I think it likely needs a counterpart.
> > 
> > I have a similar patch in one of my series:
> > https://lore.kernel.org/linux-iommu/16ae24cc2a002802b990afa1a69fe4ceab1e0da2.1790188510.git.nicolinc@nvidia.com/
> > 
> > Mine only handles CMDQ error though..
> > 
> 
> I'll add a counterpart to arm_smmu_handle_gerror() in v12, I'll factor 
> out the body of tegra241_cmdqv_isr() into something like 
> tegra241_cmdqv_handle_errors() (bailing out early if VINTF_ERR_MAP is
> clear, so we don't warn on every suspend). The new impl->suspend op
> would call it after draining the lvcmdqs, with cmdqv->irq disabled
> around it, right before hw_deinit(vintf0).
> 
> Since yours is for the CMD_SYNC timeout path, I'll keep this
> independent? WDYT?

I'm fine with the independent function for now.

Nicolin
