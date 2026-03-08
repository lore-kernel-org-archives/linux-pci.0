Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010054.outbound.protection.outlook.com [52.101.46.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA2D34CFB0;
	Sun,  8 Mar 2026 20:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773003170; cv=fail; b=FVO0WrX8724FFHd50X3j9LRZEMjO2J404NXEUyqDMi+UEqMnBqBa0cAPFoJu41pnr0fU7/dWUIIs6T8a9IhfOLlXnn6JE9jJl4zGogtymIXeSIdXdyhs29Xo4mD8S7S2FyZWI5oTU+tZ7wTGevG818KmQdMx14y+nXHXaK9BbsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773003170; c=relaxed/simple;
	bh=fHf3cBPbLFkA8bAb8QGYHOE8xAq8juSmKdS/TxQWapk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JLCYi2w3sduPH9FhRgsEG325C/zHBQyE2tIKEjvHmPnr+389ZrD7I+jMZqgr+ziaEJgZeCQHkW72M+GF1v7GsLIzH32Ig2tIKyWKJa3X/x0mEKFeBzPn+tjpkBCPkoSGSLUhkFz7vZiyAaia7fMBskZag6O2+FFV2DORrf7CdfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eP80sthT; arc=fail smtp.client-ip=52.101.46.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eP80sthT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T99mZ0WLx8NFTIumn3HxFJg69QT7atdW8fioEQHhJnqQOazj9X0d7rJCb8g3ydCK/wBmsQcZWwXkN9NRWzytJoKdQEXBxfI/gd+BsJB+yOV4X55PqS7ozXEAnyeBpmiRb7g80yVgsrs0QubwvojxvTJU6xNwualPORLqXwkCO1JF3mXF/YqJpx5xy0YmtzlrfpJe7OYWDKRTciRzCCItRTyfvvi5PQ4ZywrBlsu3a6EU3HUc8ozkkSJOlM8VKS4I1aKp9wfFxyDOpEi5i0kZ+mg4tujRlE4pXvX9LF5wG6eZtOCYQTYHYWkyTxb0naPoP/Dt11Cnu4KQz8cHESK5Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVrXurwIw4w1s8dEynOGQfMUWtl+NYxqDwvntHmATwo=;
 b=odIdqbqFDEy4dFXDN+qZAsqzpi7l/t1w/IROrBtJ7m42QkKLEKOgAwD+02FU9JGB0w2e9wtJZBL68GpMnLvaIu7Hc+V7Lg9e9evR/82Hqyro5J3ms3tOxvKL88yBf0itXiXv648KAeuSIphZ3TLpWKtCOlam//K7BwXM1i6kYWL8atqaOCes3v9Tpc7uoyXI3sO0YLCstWb2V84whYVVo0GTcoqbePhwxJudjxbAS1MyYDaZByQZMB/c5xJwo/bP33BEU4LWqclUTCt74b6Ktwopfk4KDc5Je9z0i3ziBaYNVH57x7Q7mnlxeFHe3fruuCk6b/UrntoTO7heF/BwaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVrXurwIw4w1s8dEynOGQfMUWtl+NYxqDwvntHmATwo=;
 b=eP80sthTj7XRljDgcsIFIeZDJhxwB8em2jCnsu/9w5wDyjgPWnQCnpqqYHBYDy+jt2c42hyofwiqIK90s+hrE9lAg2Qkyx8Efrtt0jq5vJ6JJfaKVvPtdKF6pGo806mn+BrrMvV2NjMAFK9OUCZcd5oksE0nec81vl+bShOiS+J+M+DK57OxpAO1aH9jpDdOOZ5pWLhyh1DqHTy+6fysRLToYW3OvXRlyISPY7AvdWCoC2WfFEoyeGpulUhN9peO4vBH1ZCi5cG4LTnrFfP7m4/YWQOhORVgzHvuAKLk7WNkkvzlp9DdysffjWIUn3NVkHfwsOOsFeS/YnKdPyENsg==
Received: from PH5P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::17)
 by PH7PR12MB8108.namprd12.prod.outlook.com (2603:10b6:510:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Sun, 8 Mar
 2026 20:52:42 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:510:34b:cafe::b3) by PH5P222CA0003.outlook.office365.com
 (2603:10b6:510:34b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Sun,
 8 Mar 2026 20:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Sun, 8 Mar 2026 20:52:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Mar
 2026 13:52:30 -0700
Received: from [10.221.136.116] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Mar
 2026 13:52:26 -0700
Message-ID: <54bbce49-e226-436a-bcf3-025e1455cc09@nvidia.com>
Date: Sun, 8 Mar 2026 21:52:24 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
To: Nicolin Chen <nicolinc@nvidia.com>, <jgg@nvidia.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <bhelgaas@google.com>
CC: <joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<vsethi@nvidia.com>, <linux-cxl@vger.kernel.org>
References: <cover.1772833963.git.nicolinc@nvidia.com>
 <0e8d1ee1557c54943dd15ff836576de4c3aa58b6.1772833963.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Nirmoy Das <nirmoyd@nvidia.com>
In-Reply-To: <0e8d1ee1557c54943dd15ff836576de4c3aa58b6.1772833963.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|PH7PR12MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 13a26498-1236-4ea3-0605-08de7d54a3ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700016|7053199007;
X-Microsoft-Antispam-Message-Info:
	Mriej2n7zTqnw4vfSFWb0/xU8LmI6CVf5L43vkq5UJPyh3u4XPdkFRR11Zn8FxWKWpv62RssjLKa0tkaYnanljQzTScitCx4xxUP/+vULa3+8eIA7STxGro7kkeEE2wA5zODxS5giA5W9/xG8PD5fBzZMggzTP/ihHeMmdEtrFnpb15oNKYBFYkXHQkMlqiLK2pIHuKnbZB7eC5zYsa4B3vlFBcisCv37NcuZRjsOMUmPThSHblGIJs2H0jCJnOlfa8gGKzoiGXZNCs6tsOLaYyghb47d3aLBEiH1DTLSGOLx4AcMHhPoFbRp7kGnBFjY4uduI5rbrI2aC7fvVdFwsGUr5zec1l5tLwocD8qvHGYfJKhszqrkdG6eeYPESqVhNzuFGSWheCxsrdcDj4GG/Bb151dusxZ0WdL7QKMYXaLwXtVGaCnbntsHlLMs0SGdHZQjtP+xZZk1v7ZT71tBzrRHqXpymCtQqljKFWywy3qQfq0e8BD/rQKo7mklPc2uCFjY/fhagX+V2bQwDZWOXNmn4NXhfQatDIAI/zdVh+wCaefHF88T3edIkZSjoV4XlifG7MSkGnYQi8V3cFbjbNfxrfuXTmcefQAedU9WkXtYuEsBUq7ERPoC580dVH0esq6lhU0anMFZmMV7RWKBCu6z5tKeJHa9V5BK/n+4FYZ3Ug7RobDCYb/h6ywBIhFfiRqi5/tQasX3lR0AVaMQwVhDz2vPzi4ZpvQSMubSrvMcvAhQGmIhSuAK839YP6OSEQ42ZCNFoYBao5H63iCfA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	F60TIbApElZT8T64OWyIfpzjknguIeA06UVKv5g8VxIkZ8XP14CGCHEavS82D69vLwi7I23yh5eY6A9hxNhJHylHFrx+QJYVZRNPYwKxOHM2iDtYx7CFUyNEwxrCUk22I2W7uAqNGH/o6LWFC1zHhlM2NsFaEV2qlReGkdCcu1JZ/tT/PXGnEf4iw6dsqXOmILlmuPhMIGeQujq5vOZ0icORt0HN5Kqoro2QxEak7WHAU1FapqDeG1uaQPYBnxwDcxQG9IdXPXipM+7qUUhrFZaXMU5CQpSI9ERqPjYUgOkzxrXIHNGrSY91i680iCGvVo7UEVFTTT778k2SZq94tpGIWviBZ3SDycGq/kYTc4UCBJVsf2jLeibssotR4fEEffiNVnhDeg17vVUrRXEpZP/sl7OMp05gKezxH6h3tiqETyAcuaxqsvdIw8EnvDNd
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 20:52:40.8511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a26498-1236-4ea3-0605-08de7d54a3ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8108


On 07.03.26 00:41, Nicolin Chen wrote:
> When a device's default substream attaches to an identity domain, the SMMU
> driver currently sets the device's STE between two modes:
>
>    Mode 1: Cfg=Translate, S1DSS=Bypass, EATS=1
>    Mode 2: Cfg=bypass (EATS is ignored by HW)
>
> When there is an active PASID (non-default substream), mode 1 is used. And
> when there is no PASID support or no active PASID, mode 2 is used.
>
> The driver will also downgrade an STE from mode 1 to mode 2, when the last
> active substream becomes inactive.
>
> However, there are PCIe devices that demand ATS to be always on. For these
> devices, their STEs have to use the mode 1 as HW ignores EATS with mode 2.
>
> Change the driver accordingly:
>    - always use the mode 1
>    - never downgrade to mode 2
>    - allocate and retain a CD table (see note below)
>
> Note that these devices might not support PASID, i.e. doing non-PASID ATS.
> In such a case, the ssid_bits is set to 0. However, s1cdmax must be set to
> a !0 value in order to keep the S1DSS field effective. Thus, when a master
> requires ats_always_on, set its s1cdmax to minimal 1, meaning the CD table
> will have a dummy entry (SSID=1) that will be never used.
>
> Now, for these device, arm_smmu_cdtab_allocated() will always return true,
> v.s. false prior to this change. When its default substream is attached to
> an IDENTITY domain, its first CD is NULL in the table, which is a totally
> valid case. Thus, add "!master->ats_always_on" to the condition.
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Tested-by: Nirmoy Das <nirmoyd@nvidia.com>

Acked-by: Nirmoy Das <nirmoyd@nvidia.com>


> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 72 ++++++++++++++++++---
>   2 files changed, 65 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 3c6d65d36164f..f966d474b61fd 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -848,6 +848,7 @@ struct arm_smmu_master {
>   	bool				ats_enabled : 1;
>   	bool				ste_ats_enabled : 1;
>   	bool				stall_enabled;
> +	bool				ats_always_on;
>   	unsigned int			ssid_bits;
>   	unsigned int			iopf_refcount;
>   };
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 4d00d796f0783..ef98e79b4e75d 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1482,8 +1482,11 @@ void arm_smmu_clear_cd(struct arm_smmu_master *master, ioasid_t ssid)
>   	if (!arm_smmu_cdtab_allocated(&master->cd_table))
>   		return;
>   	cdptr = arm_smmu_get_cd_ptr(master, ssid);
> -	if (WARN_ON(!cdptr))
> +	if (!cdptr) {
> +		/* Only ats_always_on allows a NULL CD on default substream */
> +		WARN_ON(!master->ats_always_on || ssid);
>   		return;
> +	}
>   	arm_smmu_write_cd_entry(master, ssid, cdptr, &target);
>   }
>   
> @@ -1496,6 +1499,22 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
>   	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
>   
>   	cd_table->s1cdmax = master->ssid_bits;
> +
> +	/*
> +	 * When a device doesn't support PASID (non default SSID), ssid_bits is
> +	 * set to 0. This also sets S1CDMAX to 0, which disables the substreams
> +	 * and ignores the S1DSS field.
> +	 *
> +	 * On the other hand, if a device demands ATS to be always on even when
> +	 * its default substream is IOMMU bypassed, it has to use EATS that is
> +	 * only effective with an STE (CFG=S1translate, S1DSS=Bypass). For such
> +	 * use cases, S1CDMAX has to be !0, in order to make use of S1DSS/EATS.
> +	 *
> +	 * Set S1CDMAX no lower than 1. This would add a dummy substream in the
> +	 * CD table but it should never be used by an actual CD.
> +	 */
> +	if (master->ats_always_on)
> +		cd_table->s1cdmax = max_t(u8, cd_table->s1cdmax, 1);
>   	max_contexts = 1 << cd_table->s1cdmax;
>   
>   	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB) ||
> @@ -3250,7 +3269,8 @@ static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
>   	 * When the last user of the CD table goes away downgrade the STE back
>   	 * to a non-cd_table one, by re-attaching its sid_domain.
>   	 */
> -	if (!arm_smmu_ssids_in_use(&master->cd_table)) {
> +	if (!master->ats_always_on &&
> +	    !arm_smmu_ssids_in_use(&master->cd_table)) {
>   		struct iommu_domain *sid_domain =
>   			iommu_driver_get_domain_for_dev(master->dev);
>   
> @@ -3274,6 +3294,8 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
>   		.old_domain = old_domain,
>   		.ssid = IOMMU_NO_PASID,
>   	};
> +	bool ats_always_on = master->ats_always_on &&
> +			     s1dss != STRTAB_STE_1_S1DSS_TERMINATE;
>   
>   	/*
>   	 * Do not allow any ASID to be changed while are working on the STE,
> @@ -3285,7 +3307,7 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
>   	 * If the CD table is not in use we can use the provided STE, otherwise
>   	 * we use a cdtable STE with the provided S1DSS.
>   	 */
> -	if (arm_smmu_ssids_in_use(&master->cd_table)) {
> +	if (ats_always_on || arm_smmu_ssids_in_use(&master->cd_table)) {
>   		/*
>   		 * If a CD table has to be present then we need to run with ATS
>   		 * on because we have to assume a PASID is using ATS. For
> @@ -3581,6 +3603,40 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
>   	kfree(master->streams);
>   }
>   
> +static int arm_smmu_master_prepare_ats(struct arm_smmu_master *master)
> +{
> +	bool s1p = master->smmu->features & ARM_SMMU_FEAT_TRANS_S1;
> +	unsigned int stu = __ffs(master->smmu->pgsize_bitmap);
> +	struct pci_dev *pdev = to_pci_dev(master->dev);
> +	int ret;
> +
> +	if (!arm_smmu_ats_supported(master))
> +		return 0;
> +
> +	if (!pci_ats_always_on(pdev))
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
> +
>   static struct iommu_device *arm_smmu_probe_device(struct device *dev)
>   {
>   	int ret;
> @@ -3629,14 +3685,14 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
>   	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
>   		master->stall_enabled = true;
>   
> -	if (dev_is_pci(dev)) {
> -		unsigned int stu = __ffs(smmu->pgsize_bitmap);
> -
> -		pci_prepare_ats(to_pci_dev(dev), stu);
> -	}
> +	ret = arm_smmu_master_prepare_ats(master);
> +	if (ret)
> +		goto err_disable_pasid;
>   
>   	return &smmu->iommu;
>   
> +err_disable_pasid:
> +	arm_smmu_disable_pasid(master);
>   err_free_master:
>   	kfree(master);
>   	return ERR_PTR(ret);
