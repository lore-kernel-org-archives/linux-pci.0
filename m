Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012003.outbound.protection.outlook.com [40.93.195.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267393F166F;
	Wed, 18 Mar 2026 20:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773864064; cv=fail; b=jtlaju9bndsDKdVXqx+J5qEC/oo9qcHu4Z+9N8YL437AsfoUZT7z17QBWvuaISj5E7N4OZ8jfAjEaUFwon43XpC4150DZdegT1Y5HLRxozM7d2Rvx/YDDYIqUFuHuJxZTSYzV+7iKj0hzgU346l9t9PgbbNUjj6HlPm6XafUO/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773864064; c=relaxed/simple;
	bh=SAgntIym9IyXU+BqcwDkmNqeFy/UOrIbSai54mKhxds=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsPRpea4Fme3r1EB0fzFrmkb/8D5cS+xC3iGRvqGizFRgFfohuZqkzbcfnUzNEuBixIjarZlxON5mw15SfVYM0wrOfAPn34oGz01rAYhN2L9v/+JYxzbN9B8BhwcM2DMtZn4RKOEhtYNdG49yEX4AxUkWiZtiFJzUXujCOYmk9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C8HyPIpn; arc=fail smtp.client-ip=40.93.195.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C8HyPIpn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhZovrG42DxuPuGmZjQN3hsr/7gi0Df5DR2OfE0l5tncMDR2TK+dZuwi6EOZylTp0EGm5n3ZiBHteyAoFRROPyHn4AHm5wVCeDhu413tXz962c2rtjvj/ONywyE1L4BaicvIx8zc51jolFvytmw/mV0yQm5URaSX8RwNoL+pul2m87NtO/2jN45ScPCq2wufQykUHECHwshq9KPThOfIPQ+dRaSsR3endsm+WgeNnUh9WBIXxy1vVh7vCGhZii5i+kO6+zsRZBG7CkQsNYHtKZ0RzAk9IAX3svNqzloKH/DU2HF5L3MdVjKwsFDJRTUGlUpqZzgD4q3UdeRBeJiC5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAZwWZvsW61xPtq3RWf9T/TdjD/SNL9Gb2z+SAeeNBI=;
 b=iAKwzBFM3+4HwSu3eo6C+eWYdU9kYOrCwmd3ebEG7Ro7kYsERP8Ej3Uuy3eaKIdXhmCD5CYbCtYWiXICpMdDCfXD9U5zB/Po2HR8KniIxzCRxVFPm6K2abHCH//MnIE14PJGqk2VI3bxt1h+jpIaegd2Vt5qaA9W9VnTnNWvv797QG3A/RVgUxOCbe56OEeD9IyIbNiqhGNixh2enO1Fu0f3XJjw+Nj7qK7WdDSsm9rWWkGOzY3dhpTXd0+143HkQmwB9dr7MvQq0W0XvI7nmLLSMT7JSF9wEah1RkPR3/y7c8m0swvZhDme81YLCHR5YUVQMyQAvjqvwMPkTBqlhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAZwWZvsW61xPtq3RWf9T/TdjD/SNL9Gb2z+SAeeNBI=;
 b=C8HyPIpnWXRH4qSWHrTc245Apq1lFo5ZKdVT3WAeS563v0bgbYnuDUWb3IgnrcjOLs1XceRRH/LUXngL9NssBizJk9K1hVcVGwH6TR+pXrV2cnmD0noZvLFDDZCfANsyYmJVoXoY2QmXRUnC8xGjOvegPXhIs2K3HteN8QZb8HGJM+SaGEH3FrbN8VeKb9myCjfMuVKYGNHscPcv8FV6Rh0JYo6ta8YGh34nJhAj9/OhYCfPbQzMtGDVYFkESLm9CSWIpCc/ipm2y545PUz1rjV232Nc4D+akuNibgPMFG4dYbSUyzulKRwi+aY6L2aUO07BFhapwTmxPeIV6lPRkQ==
Received: from MN2PR14CA0018.namprd14.prod.outlook.com (2603:10b6:208:23e::23)
 by DS4PR12MB9745.namprd12.prod.outlook.com (2603:10b6:8:2a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 20:00:51 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::10) by MN2PR14CA0018.outlook.office365.com
 (2603:10b6:208:23e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 20:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 20:00:50 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 13:00:27 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 13:00:26 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Mar 2026 13:00:25 -0700
Date: Wed, 18 Mar 2026 13:00:24 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
	<lenb@kernel.org>, "praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>
Subject: Re: [PATCH v2 6/7] iommu/arm-smmu-v3: Introduce master->ats_broken
 flag
Message-ID: <absEWLLh9RgMj3mC@Asurada-Nvidia>
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <c101108ad1e52824dbadb5d35a534584be28824b.1773774441.git.nicolinc@nvidia.com>
 <BN9PR11MB5276CAF65238D9818D3D8BC78C4EA@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276CAF65238D9818D3D8BC78C4EA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|DS4PR12MB9745:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d014859-bbea-4643-3f4f-08de85290dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	vpjLU6Lg8sX3KAsOCUK7Wz3LTU0I5H9DqQRXFhdbmPFlfEQJUfVeNEaleh9CYkSfjUsavMHG9ujFHQkrp0j/c1/YCk9rtYfPNPA6f+2hHnHfVQDc0ViQAx4a6ZkHvMKMJtFXARVx0d5xDFE3HHVuLwEzABin268Ve4q3hN9tHEFpNLnTbIei19iYx7ti4qYMi10pqzU3CtTPXTu43a9VGowLBHGlcXzEOX+CyID7fKqDvdBEksINrTeZY2vEhixT81T0CXmdG8UjohC1lGEAuzBRiIy4pIar16ON/KSjPPdwfW+9bY7iWmng2li5fwpcDICD8Ix8atx1FRGz3LAl6bgZgGRwHZDoil1gF1sWTyFMSMQmR+/5dNhsCf7Hw8HNkShz/c3xV1pCTdXQCjmP50DQD/wuEtVTYQzgDjWN+wa1V+5eFxrLaSwrBBJOYJDfnO3JJ4nHL0YfpsxNVKdX+6zu5WatxJCdisskCBMacox8r2tPDp1KPci2WyYC6ptwp2hfZgwX5DjGTc4HAwkZv/4apvjq34Mivd3Z7vKupbr/iBye9bK0knQHmf/LKt6jg/9v2Al1AFNDNxPcaNcN7gh22+FIUuA650OT1ZgCW2xE4z/3g2Jka6r8TsBsKjebwB/qNmvwZcRhMkLiqdWRcIDPwPY5IjckPODexEfuERoI0y9dkDxfHUOxysq+yM4g+euj+isBBbQ0+aLIFYpaz2jsO2nyv92v7bj5YofnBuEs7UhFJuZ8NGN/ob5Ov5/tMPAHCasZhmDs2FE5Ex51eA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6EkKcg2zrvBXfG9OnFPaQ9F5yYZnDVRLzmPdzdeKzvIDLP+ObSlSI3ZpGJV1KoDxYdfQTsPvTo3M8qV0uGstNJmJwPbxMIJhG2BhoUefCfw5cBepzkkp09l09REbrP6TgSGcg/mauv85oLNzhFmFDTCgyCsyuAfgfS5inBtNQegy1WmDxbvzPaNQTcs8lzFPDfRWBJz5KTJs5+eR9lQWPhpsW+fzprCRaj79W00FY/da0jKmIHi576k4SHJNSCXC82TLgnkdPgazGUEVc/grKtv4MqVwzuuwNagdoX4zYjXbn1dOE1BcB5tCCbRo4kXjFOE0x/3WF/Z+x7ae8dow3OOtaXlin41J5M1YQC1ZmnSykkHu2jGcLM5hvsKIhMw9YMSsaAOYxC0mqMI0UjqBiTG2dhAsE0HtDv5yqPHmPDCg723ugn5uRXi20KAaS0UO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 20:00:50.4922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d014859-bbea-4643-3f4f-08de85290dea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9745

On Wed, Mar 18, 2026 at 07:39:53AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, March 18, 2026 3:16 AM
> > 
> > @@ -3060,6 +3079,14 @@ static bool arm_smmu_ats_supported(struct
> > arm_smmu_master *master)
> >  	if (!(fwspec->flags & IOMMU_FWSPEC_PCI_RC_ATS))
> >  		return false;
> > 
> > +	/*
> > +	 * Reject any new ATS request because ATC invalidation was timed
> > out.
> > +	 * The PCI device should go through a recovery (reset) and notify the
> > +	 * SMMUv3 driver via a reset_device_done callback.
> > +	 */
> > +	if (READ_ONCE(master->ats_broken))
> > +		return false;
> > +
> 
> "Reject any new ATS request" means any new request to enable ATS
> on this device, instead of rejecting any new ATS translation request,
> correct? next patch does the actual work to block ATS...

Yes. We won't call pci_enable_ats() due to !arm_smmu_ats_supported.
So, there shouldn't be any new ATS request any more.

I will change it to:
	/*
	 * Do not enable ATS if master->ats_broken is set. The PCI device should
	 * go through a recovery (reset) that shall notify the SMMUv3 driver via
	 * a reset_device_done callback.
	 */

Thanks
Nicolin
