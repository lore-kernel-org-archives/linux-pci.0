Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013056.outbound.protection.outlook.com [40.107.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866CF3BFAD4;
	Wed, 20 May 2026 22:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779316564; cv=fail; b=JDpkipWE61cxvJIeUL6HaZLF/r4DZp8TSJR/4G/6QH0/kp9q+BqtcXdrgsQrU1e9OKvYhaMBT20ncuMAVzLZi0VrVbHy+0tFdNDDlQXFbSyHVXLXo4HNE1uEE7BCL74oKs+kyLbCnaeT2RIH4WaqmePtvRmboEUCHja5qZ7FlYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779316564; c=relaxed/simple;
	bh=qq5qZ9kKfYI2Z9zzbBMaG4+4uIf7HcKRGHASgTTv3WQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOVDGz40uxhE28Zs/E0x9nIUYjxM+iDDt6PKkr5sBgsZW9w1m7W0kUmBylQKVIqvtMF8wO7X6OIZFgDyZSFUszaWGn2RWDQ9uVqZrx021f8PXdeGa6WO7Y/nvR/49PDtBA5g9EBJOPrj9VvgBQjRFAC/Eynl+Th/nlja1sgFeoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OnBB1lS2; arc=fail smtp.client-ip=40.107.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OnBB1lS2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYpq6wlYWEdavdSoDdHiEA1ku6dQjrRy5HFVll8/s72OHeoa8we/S50TVeX0QXiSFPhqwf2s8nvGGY6GTZBDDoF8dp/tCpGnKyC7/bgMBf2WBMjH6FLfgL7pYEPZ6+WFZjxfriIbWP6xQcH9A5lKjKbun5EUUvqhyZtcOAJbt5pu6KCepze/B14M3qJhRuwzDx8ySOCDsgqK/3OYBu0GpPE0Md+hU434huE6JEO+DZZPScWkLhFUhDKPBywNtMaJRIzeqKCCTTxQ0iwwgBBbBacKvjye+t4EmUafboTdoA32dWH91fEkI3tywMJcc6wDZ30mz0DED1je2m+eEBBYuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8R+vswJ6B/a/bfANrGQJ4skhXbq7vCocbOo563BvdI=;
 b=C9MGwDHt/4K0S/B6O5DL70LCFSMQGM1LpeBCoxTnB8DqqMnEY2mQz9YOWdqoMtwe0caNHVoUWlbhQaIhGR1AcF6afJwqmWQqkI0JiqmI0uuU5l1Ju2RY+wRHYZpkp9hLtEuhbh/IvLiDpFIrOJY1m2pSdzCNoLPCwoGU9/GjTqqW8g3j0E4X8DcnKj37p7L1RumYFmgPakaU4J1NQhh5KoexAB9Rp8G95wTTWowuZFEZGYZVzsoOq00id9h5kT0y7tbwP9IqBpau7GMXJiOyLAne+5Rdfw2AzDb9kc9zPx5ZWui7Gh0A3H67EZ5it+ZaOlptDhVZ8pZAipnbxnKsHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8R+vswJ6B/a/bfANrGQJ4skhXbq7vCocbOo563BvdI=;
 b=OnBB1lS2Ta+zhzWWH652cyTNsOSZAMSs0FZ1bf6OgzOCeSULmX6GDMwSqbq7IvFQMi94AF2ZXqKatqfEwCbo5o/W7nNfQsPnecLAW85rNRLLMiRP/2h5GIuCvfBAhP8Oe0OGV1PYuT4qy/5YWFXQ65mHhE6e2HWgCgidQXkGRexBNezSja8rZTFPvDolaEd78lEgP/vXmyKuokYMdSJ9WQ2if6+VntEWoHfMbybsJyHtzXXx+d+dKBBVRF75w+wvg3xlNxmeYKCZvIrvrjNhjNklaa/pdLmrPJ4Rrj98zsqnh/XLkiBe2kirM9D8xDum/lz6q9q7gZRRwv7oSTufvA==
Received: from BN9PR03CA0298.namprd03.prod.outlook.com (2603:10b6:408:f5::33)
 by CH2PR12MB4309.namprd12.prod.outlook.com (2603:10b6:610:a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Wed, 20 May
 2026 22:35:51 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:f5:cafe::50) by BN9PR03CA0298.outlook.office365.com
 (2603:10b6:408:f5::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 22:35:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 22:35:49 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 20 May
 2026 15:35:34 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 20 May 2026 15:35:34 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 20 May 2026 15:35:33 -0700
Date: Wed, 20 May 2026 15:35:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <joro@8bytes.org>,
	<bhelgaas@google.com>
CC: <robin.murphy@arm.com>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<vsethi@nvidia.com>, <linux-cxl@vger.kernel.org>, <nirmoyd@nvidia.com>
Subject: Re: [PATCH v5 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Message-ID: <ag43NP4UiS7Z9T6q@Asurada-Nvidia>
References: <cover.1779304390.git.nicolinc@nvidia.com>
 <b6d2f24356621c504e47633d9e96a7274c2859f3.1779304390.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b6d2f24356621c504e47633d9e96a7274c2859f3.1779304390.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|CH2PR12MB4309:EE_
X-MS-Office365-Filtering-Correlation-Id: ed822cb6-97ea-4028-3bb6-08deb6c024a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|11063799006|4143699003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	bIiDJmC66iLkAC+/qub1CFIBbYT2PE3skvZl2yH9qemuKL2zOoA+dDqMDr+Uma/JO8DCw90Q2Clsw+IGY/P0fGmjoRHsDOqLStk8iRzmtw6KSXEt0qgq7ics6yzRZfzb4HujwHSiWJMmARJOCeSGqEV14mEM+ffD37hsjKrgAML5xTzqScjfT0eiXH5/BUNVRVZoeMVjAlozQgxlEpHL9V7qjrgOdy4JCLT/nyuArFryvnkBcAyzTC8093U9gJuVIKK4whlSxU9H67SVTBdZ6OYNDplozPOQKyKUlabe25A5LKYxkDINWsYbahM0ksE8IO4fzXnYQX8BXS6fm5JM7riZep/MranxiVfiwVEBlrD/qeu9zKCHNuDm6Og4sFqkYnC8KL07dWEpTd96jiU60YVwhok11XuEophacO/z7e92Pa4bk52el2/VwnQ99+rh7Xd5aEILlbA6j42Fafocg+UWfs0xV37itWV9mzusZ7q62ZAP/p02mkfD/Q5wSUsfFbXiNPEfjxRIHs9Zt9MB9HNcmePQgVbNV6ssLWwa7fqd+yuHK8NQXXKfdlBuoLWOLDorgaF8cXcEmucd9dIr8J+W2Vh+DlpocZiffDJtIzsNmRL8DN8S3yxn9YJIRofUCBuPWf80Y2LuFVXq89TJeVYcHGXJ7NvzRy2Ix1tgGEVUaAxzRGub4ZlD0M5osi9/fEDHFd5dVNiRto7y75pwR/44OcZbMvVY5dqGQ88Gs64=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(11063799006)(4143699003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WFOOLKkGeZmAi1SzdRnNOrrJlMR7847bAaENdsoovoqGKxFrQ6xP4a4kDM/+RnLRwRjWqSnUsCXbtsYCqu2v+BeBA4ByszPAyG7lgUsUqyosUxs5hbpQJRRpc5YqQALPpOxsCliW7pZKHX9u6Oe/R01qn8wj53VVUufWBBQ5tBI09OWaxhCc4l4RwAZFX8cW+Y3VT4SfRtyum/L5/t+yi8+DOiVjbMVQhpMy18sB9USOBxXH54laQBm8tpn/dV+iap3CiIJacklRUI/bD57dUFhUD27HtZHU7zDTY68k0uC8vkwq2N24K07Lv7PgvnHFZy6bz3Kl6B/uBP7lSOWjEPBHRWQZLTNUFxg3J/zDqcZKmlvCdNtj8yrmXMm/nL1vp3iP1c+7hJ8TNbPb2yKPybfcJu390I8n8QFIRABEnxvGc8omOkmUxMM9et78cdoh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 22:35:49.5565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed822cb6-97ea-4028-3bb6-08deb6c024a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4309

Hi All,

Sashiko pointed a couple of valid points.

On Wed, May 20, 2026 at 12:46:10PM -0700, Nicolin Chen wrote:
> @@ -3851,7 +3870,8 @@ static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
>  	 * When the last user of the CD table goes away downgrade the STE back
>  	 * to a non-cd_table one, by re-attaching its sid_domain.
>  	 */
> -	if (!arm_smmu_ssids_in_use(&master->cd_table)) {
> +	if (!master->ats_always_on &&
> +	    !arm_smmu_ssids_in_use(&master->cd_table)) {
>  		struct iommu_domain *sid_domain =
>  			iommu_driver_get_domain_for_dev(master->dev);

Here the detach path doesn't check sid_domain's type, mismatching..

> @@ -3875,6 +3895,8 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
>  		.old_domain = old_domain,
>  		.ssid = IOMMU_NO_PASID,
>  	};
> +	bool ats_always_on = master->ats_always_on &&
> +			     s1dss != STRTAB_STE_1_S1DSS_TERMINATE;
[...]
> -	if (arm_smmu_ssids_in_use(&master->cd_table)) {
> +	if (ats_always_on || arm_smmu_ssids_in_use(&master->cd_table)) {

.. the attach path where it only applies to IOMMU_DOMAIN_IDENTITY.

I am addressing this with:

@ -3870,13 +3870,15 @@ static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
         * When the last user of the CD table goes away downgrade the STE back
         * to a non-cd_table one, by re-attaching its sid_domain.
         */
-       if (!master->ats_always_on &&
-           !arm_smmu_ssids_in_use(&master->cd_table)) {
+       if (!arm_smmu_ssids_in_use(&master->cd_table)) {
                struct iommu_domain *sid_domain =
                        iommu_driver_get_domain_for_dev(master->dev);
+               bool ats_always_on = master->ats_always_on &&
+                                    sid_domain->type != IOMMU_DOMAIN_BLOCKED;
+               bool downgrade = sid_domain->type == IOMMU_DOMAIN_IDENTITY ||
+                                sid_domain->type == IOMMU_DOMAIN_BLOCKED;

-               if (sid_domain->type == IOMMU_DOMAIN_IDENTITY ||
-                   sid_domain->type == IOMMU_DOMAIN_BLOCKED)
+               if (!ats_always_on && downgrade)
                        sid_domain->ops->attach_dev(sid_domain, dev,
                                                    sid_domain);
        }

> +static int arm_smmu_master_prepare_ats(struct arm_smmu_master *master)
> +{
> +	bool s1p = master->smmu->features & ARM_SMMU_FEAT_TRANS_S1;
> +	unsigned int stu = __ffs(master->smmu->pgsize_bitmap);
> +	struct pci_dev *pdev;
> +	int ret;
> +
> +	if (!arm_smmu_ats_supported(master))
> +		return 0;
> +
> +	pdev = to_pci_dev(master->dev);
> +
> +	if (!pci_ats_required(pdev))
> +		goto out_prepare;
> +
> +	/*
> +	 * S1DSS is required for ATS to be always on for identity domain cases.
> +	 * However, the S1DSS field is ignored if !IDR0_S1P or !IDR1_SSIDSIZE.
> +	 */
> +	if (!s1p || !master->smmu->ssid_bits) {
> +		dev_info_once(master->dev,
> +			      "SMMU doesn't support ATS to be always on\n");
> +		goto out_prepare;
> +	}
> +
> +	master->ats_always_on = true;
> +
> +	ret = arm_smmu_alloc_cd_tables(master);
> +	if (ret)
> +		return ret;
> +
> +out_prepare:
> +	pci_prepare_ats(pdev, stu);
> +	return 0;
> +}

Another issue is: arm_smmu_master_prepare_ats() here doesn't guard
against cases when !arm_smmu_ats_supported() && pci_ats_required().

"!s1p || !master->smmu->ssid_bits" also needs to fail the function.

Actually, this function does not return error at all. This reminds
me of the !pci_prepare_ats() issue Pranj is fixing. For this series,
at least we should propagate the pci_prepare_ats() return value to
the caller.

I see this single patch is getting large. Maybe it's a good idea to
split a bit. I will keep the reviewed parts into patches that retain
the given reviewed-by tags.

Thanks
Nicolin
