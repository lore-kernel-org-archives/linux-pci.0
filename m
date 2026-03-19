Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010069.outbound.protection.outlook.com [52.101.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC313285073;
	Thu, 19 Mar 2026 03:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773889612; cv=fail; b=NnVtb4b8KyWG6oTZkXYlotkOM7digyoFbeWDCFsI9BE0BxDVOxdNsszccTjlLYsN1aAf9p2ukGUVfTkjkFl6bi2NDfJCn3yLlowgh6rVfOectrS0ea7odo9JLAb4c9515NxjP6dlrORa6OWgAHBmkqP6tDlGgCPQvGd9lR86q6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773889612; c=relaxed/simple;
	bh=qDncCEBj2+POYx7h48GMRiILtzaZApqgKab7u/ogWYo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tmz1XsRiYPEZI5+B5xcsxfKxGgkiuskrrsLwW+vobKuAbsBQO9k9Z5nk0w4vl8DrUXKIBqxuXG6EHN3/yXqDf7MksNMwtuWUICzwo9cUyMEIqT/vSPvoL5+TAf5+J9N6qU77wrUTsTFuObztqvu2RWLSCSKePUOkRTE/Jjgub9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fJr64p5V; arc=fail smtp.client-ip=52.101.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fJr64p5V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxwcXprosRLGBu+4TKkqlc8AbiSa85TRIUrUV2b7TF0nruFoe+d8L+J+nJL/feHfBLshjSL2qE2cw/zn5+dS6ed15pMiDo0fbYmD+lphq+XxBC+cJn7gyJgHcZXC72DLR8/BmdlZwwtH+HFnpC9O2FU6C74mWuQ2MgAGPdYajvEmiyDNT5AAjIR33LpxrPoxgrClKLu5kiW7RjGyouZGOpxS5gbAJ+39uCH6xJ3jgTXsXalxp8WgKIgIH/NbyGZzeX3PFTu3hddBFaJwgUJ7Nz61OkOthox3K2Den+miKfd2Xo4YdEvxr/XTOsytEUJJPEF9Mv5HZyxUPfpogPM5XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqhDpS04+NuO//DsYxLXbooVwPYeELodwVfuqGDHrbw=;
 b=QEq66NSIy7YxnvCSRNNvAeavt9omDHAP6WA5qh8HIG/XySTjbAbcUe5iCjS1v+uh5vLXO1NOvjlWsWBbrfLhnbGelXYNgiDRSKTYKwUhUizTqxvwVcps1/hiwqnpIPdbARCZKsrph5koMG6JH84vhI7Ztizh1WpY4kvuDdi2a5nzOPuEkQ0sKtO4ctdO1ItuDBJFUNy+6j4SAIoCLg5rFk0EBjnfLyN0U1A8arrxZs1nqyd+uxgsq2wyuC+v2x9dHywcJAfYR+wlVvCBBLKImy3ktj2g0dZUrINvV5TlOsbwdHMd0Ja6d/LNRDqEBlSQICasBa30Xp4xN1jYZE2eKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqhDpS04+NuO//DsYxLXbooVwPYeELodwVfuqGDHrbw=;
 b=fJr64p5VPKJ3SODsnCic/vVHXgtqBRpHVJWY6qNURf0BMyhYIFMmLpbpSdAoesoUjUW8z97VBxKa6BaUPr3VHEGnA7kG6AQYev0cOJgNI9cYIOx6go7/ygxdrki7NHG+j9DwWb7mXlijESltaBMaqFXJnSw20vLe8T+0LBjd3eajMKYj4AbrVG8HH8C/V/tc1R5hF5iwzJGLW5DitHc6yI464hYbhvMo4HMTvdNEtErZMLjYNgRsRfFZoIUUIvOTuvjWWCokC5t0caVunnwJ9D2HW76+rQ5WxKoL1SpfdFvUSLt84w4xP1NlkNUbeDn1mQOw/sIqxj8XC/AbVGqztA==
Received: from BN9PR03CA0286.namprd03.prod.outlook.com (2603:10b6:408:f5::21)
 by IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 03:06:47 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::9f) by BN9PR03CA0286.outlook.office365.com
 (2603:10b6:408:f5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Thu,
 19 Mar 2026 03:06:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 03:06:47 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 20:06:40 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 18 Mar 2026 20:06:40 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Mar 2026 20:06:39 -0700
Date: Wed, 18 Mar 2026 20:06:38 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "joerg.roedel@amd.com"
	<joerg.roedel@amd.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH rc] PCI: Fix nested pci_dev_reset_iommu_prepare/done()
Message-ID: <abtoPiYKGzJ1a8MX@Asurada-Nvidia>
References: <20260318220028.1146905-1-nicolinc@nvidia.com>
 <BN9PR11MB527657D79BF5B16943BCEC258C4FA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <abtipPYeAEpg+vbI@Asurada-Nvidia>
 <BN9PR11MB527654AC35FD1EE8CDF7E1828C4FA@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527654AC35FD1EE8CDF7E1828C4FA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|IA0PR12MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: f3c2a714-9061-4225-bde5-08de85648ec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	+TNaVKzjs4mMRiLfcR5TjL6tn5Vo53iCibzRk8MkWVwQF6VLsvQmxSfGMXxw5j2kTlAzyPSc1FTY4c5oHsK1JU9b7GCDSJAqtRKqWxeR94p4qoHe6Fc85JYCtN4BxwQQmtD19Q+dgfqDjsp3TI1dtiy48x4x8n/MgWqIC7yT2Xo7+D8zBR/ErEEubLPsK5mC+Bi8CVJ/AlKKV7a+6BLMBKJHxd9M0Y1FsF3Ao2eVuCrRiKtP+EQt+xavGj8a43TUN/bTy64zyHyFVvrk5q0xnslg2rqIbsMLlYTR3OPdPars8dGDR2jhQUwGSZySK044oxVLNZEd6uj86cyu5N/Oad3uHDPwHvVYDgRLTXlnWJbXnOkBQWoBY2450F9p0l3PUZa/b96Za5ut9kalyWjIjiGIgmPGycF5OYd5R4+Bkvz2gxx4T/EOFEb51Ux2zK2m/t+aGLek42hBl6KMpeIMNI/H0bQHh5cTX9vh59Iz3lBuw39REh3hU9tfVZ86BatLOvyrCmyOvwfOF8T7txLy2XcU13GVUnbHfSvIxSc9eW+pYFb1sg/UgOtEkr49xCYoJ8Kjd0/QRM88od9s9qed6yPvNHagSRHu85ouuiSOS1CHjfGdJxkFeG6O/XP/JyaiwQkqalXOAIXiByKK5BOTcSxPuhL9HhDBZJfxcCuzPi+WHw5XGJZnRsId66Vu6jbwLTlGgU+kYN2hCKR/DMJoRlQDsL10QNz+HL1+ZigxLzpQaA0wpIAaDHVbWBw/ydBLNBFnCqtI6iX6QQHb77YqbA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	290IeghQzwxyG3x2n9YXAJruW9wxaHK7HwuDtelX4kUmv+qEfYOShsJhF++rcDovONjx7w34zt/7MNOMMsCnb+cG8+DqZl3euD8Ks5qryY176UYYV7iW+TkJZo2TntzgpnnxnciGsRnqCFj7bGM3rgXQiU0v2u5Wkb+89UU9AEVCRv5YiOHLEZi7zUfu4Fl0QouzDrG4VY/r0Mw0QSHfaDTkhu9amPHY1PIVUngjWUWPYNbmEFaE73lES9N2GdEFj278NBncKIAW2qwgDGYTiftwkwjWTSMmk2phcEUflmyDTnyMXA8fA2VscR/Kx4Y3VneOGxBw8+BwAaGRnssBHyO/j++0dJzG+EmVcGfU9Da0/hEM1kSiHZgNbNWSOWDKFRNtays/7MNpVMJr2j9aAOUpi1iMqtNx13QF/LFlpHd88LhAax4jrydEMzL4gufJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 03:06:47.0025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c2a714-9061-4225-bde5-08de85648ec8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8376

On Thu, Mar 19, 2026 at 03:00:58AM +0000, Tian, Kevin wrote:
> Looking at handlers like reset_intel_82599_sfp_virtfn(), the return value of
> pcie_flr() is not checked:
> static int reset_intel_82599_sfp_virtfn(struct pci_dev *dev, bool probe)
> {
> 	if (!probe)
> 		pcie_flr(dev);
> 	return 0;
> }
> Similarly, delay_250ms_after_flr() ignores the return value when actually
> performing the reset:
> static int delay_250ms_after_flr(struct pci_dev *dev, bool probe)
> {
> 	if (probe)
> 		return pcie_reset_flr(dev, PCI_RESET_PROBE);
> 	pcie_reset_flr(dev, PCI_RESET_DO_RESET);
> 	msleep(250);
> 	return 0;
> }
> If pci_dev_reset_iommu_prepare() fails inside pcie_flr(), the function aborts
> the FLR and returns an error. However, since the quirk handlers swallow this
> error, the PCI subsystem is falsely told that the device reset succeeded. 
> Could this falsely reported success leave sensitive device state uncleared
> between host and guest environments? Can we ensure the return value from the
> inner reset functions is properly propagated to prevent this?

Yea, looks like we need a preparatory patch for the other series.

Thanks
Nicolin
