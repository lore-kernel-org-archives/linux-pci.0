Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010054.outbound.protection.outlook.com [52.101.85.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A416953F683;
	Thu,  1 Oct 2026 20:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886196; cv=fail; b=tKHrJCpiE+zbVVDcGdUEGuz06vl88nQFrEvEMViGMoKu5dPnF1GPalpUPqyOOR5w5UAP0+pkiYSZJJGVzA7r23W0pP5YEsksxZJWt8dvvhAz4kbdlrfiGucOq1W6Hj5Uq8wG+UoYxNCcHUv0TaKNje3kEBwU/i7+rovi5v6gl2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886196; c=relaxed/simple;
	bh=vYZJIO5TzBRSu9OTQlg+PjXnlf942nQfOGs0xU/qak0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0plDxrud64rjH8P+/XtILX6C2NSfj6HX1jf+6DxFp3MU7Q+MO2Af7pTBjsBZr2hILLQJOkvd9nZSyv1BW7MKReee0f3vcHJDRQEu34u0fM8XyaDfRBGCINicqNcqe56Vivr+quTz6u/tpM5FlTcHr7tPLQOi3eRY6PpRjh1bQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=auSHSEHf; arc=fail smtp.client-ip=52.101.85.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="auSHSEHf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+27dLCA6Mgyet4dUBSVlbYqKfvTxW8JhyZiFXpiFhV7bs3KQbfFh4mE+iUnErSQeUIE1x3WlsOC0CrEjJGwGvEsnz3GaGVXFKl4Aandfubq791MVP/nLrIkZOoIiNX5SDtaQvotzMXTR4lB3cJkpmwOAWZYuBnAVuh2DPX+KuwMVaJcGuluEjoUgexOX8Y5SBxTegetNIJTb/fBCWZF4rPuMZ04x+DeM0CaHM5WVZZms1UPEWVCb6gbF8KDLMIb7skMTliFjxhQzxknn4Kl0Wj4oA6RgBtNxq6/cszzw6h1XGDhStqkNGB2e5GSNUAxq9ahczj++2hLgH5E+BxQ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpPkeOCPURulNiOuVdrND84Csg55H/+ONreaDCazi8I=;
 b=HxTRAeazuQMcH6vlCjZnij5aUAQPWA/dajh9F1sozs4uIffDT+0qljS7L3WSBozB3XnvM/RMBnDlICCf6s/BECPcHmcz/9vUy/Ey/hEecuOa9ObNIWbSKBW8icG3O+xCfF15nwHKZF0JsKwmNMyt005sHqEz8bGpde5+VvQOWMsu8lv6PNq8SZ7gFnHr4QeqmcoBTG5Lp7OiWbx+EHnScl0TzE6te6Srr7s7dneJw4bqAxCSTlQkiPbhiDM4Ud9nKvD4HuKC9lXt8nMY9E17psWcTpHrvY7kOr/qAMtGNuKVjnIHlo2mxNaAcnlB1bbhXQDgTvhmPvJo/QwgCLjSdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpPkeOCPURulNiOuVdrND84Csg55H/+ONreaDCazi8I=;
 b=auSHSEHfjMhs3Iwdo/ByIGBNy57dkcjYw8gcVPkr/uqvOtzJvYHf/gXv6fVHcpVfFAVEFjQKJ4Dw0pVPa+7V+T9MtsHtJfH7fuK7gNai1Ge8eDaHaJ3PKJy5eKHrNyB+Jigr3PN7RIqy1tJcJjjccpoTcTDpUdmE6VxkE8TEvfZ1HlDXI5S+y+vfMZtKyHspHkWfoFf/Pd8ptNNEamrY+o7Cq6aH9ctv8bU11S+DsJlHw9H+hJYFvYZXZBWsQrQuMJ99ZjnE8SvkQxrZ6P3RWlDRr3N7JYsI6+Ms/Zxpj3wiA4rbfUzc8aUqD+jygES3M78WAtsruqvyJMy1YW8I8A==
Received: from SJ0PR03CA0141.namprd03.prod.outlook.com (2603:10b6:a03:33c::26)
 by LV0PR12MB243158.namprd12.prod.outlook.com (2603:10b6:408:3fc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 20:23:07 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::7f) by SJ0PR03CA0141.outlook.office365.com
 (2603:10b6:a03:33c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Thu, 1
 Oct 2026 20:23:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 20:23:07 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 13:22:44 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 13:22:44 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Thu, 1 Oct 2026 13:22:42 -0700
Date: Thu, 1 Oct 2026 13:22:40 -0700
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
 Krummrich" <dakr@kernel.org>, <driver-core@lists.linux.dev>
Subject: Re: [PATCH v11 13/16] iommu/arm-smmu-v3: Implement pm_runtime &
 system sleep ops
Message-ID: <ar7BEIURVG6kGKX8@nvidia.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-14-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260929034510.2023173-14-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|LV0PR12MB243158:EE_
X-MS-Office365-Filtering-Correlation-Id: 6069da64-a309-4036-a7b5-08df1ff9cde1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|23010399003|1800799024|56012099006|6133799003|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wkNJ00GJVTxA/PZgKwTJQTPQs7wJNy5VilET7+tVt1HDv1I+bROwmfVJrzpQrMLLflfxafWye3V6K/PLdrVkDyES4bEGPu0KgDaWrDyiJ0bUfe71Lhp09dXQljvtWOEj0fNg9YcQtbOQZLM5ymcyR12VYrBqTrTElqyMCMdvaJsPmFN1Ss29EA914SRHYIium1NeN2Zo1s8Yole2paZ4CHe+B4WXlVEuW8vps/2W464TnwDEYnn0k82NGeZJ/wkSyoRQV4jFHiTGFqE2/OLIqqWy3XZd0vCI3c/7Y0lvQVAlvKuB8VRyqO9cGsD/M/nOkD2wZHj5bC+MyjD5H9++04cotbvZvty9SAdrHU4+o7VcRXvUFvhdmES9seH2L9TinNG7dfcC4fKLM8c0yK/dok7QG2cH68RCTsF/ArSvJ2EG1QjGxDiCK6eIlECO6hQfyPl3qaIgIQBVg6vY5PXLEcHSxnuwjce1fxu/WTFEB0vTFHFBZTo6ulUpYFWRPZ7nlCtxVm45L7yt9iHazZ+ZJw9OB+todHUm0WaS7H8eJIUtWCKgNwx7R1Kc62gD8hyxt80SZbrPNz1f5iF/ThIvgi7RWJEh6e8JvdYpclGgtNGml8zteT0U/Olt6Q2tHbp1hceQn9XmD5tMaYkGKr/kJohnpZAKZ/Ge0FzV+eBFXsz9PaNTslEC67RSBu1eKHoRX434uRoNtKMXqOja56sASw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(23010399003)(1800799024)(56012099006)(6133799003)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/joHKHcVocduuhZZ4Mr+NO+05zxdWqnpFYLy+SyQELNicRWh1jHHUqV9ec3cVCMyfgiBN/Id/w+eYAbaPhoqQajIXONZ3zFBFWX4+3pg0PMdHjFNKyAuLeSj16K3DFA/dFTMBwuzcq8ypVylUkZcJpx3+ykDtYPHAxBjP4esizlPg6i0mMAc/iELbfNEIGkCMLsIcH9v+RjtoWdiNl93oUvbr6KiNgyklLPvASMcy1tWOBEpNoiAcb99eIprCI749bFgVLYqe09B45Y1Ek0KIFsPP2QL66JfochG+0TcfCjUjbq4VuyqqTFvW/SSLsk7DX9Qq38r8eK0CT5LgIIW+8RnZ4JC94O68YpF+x9d8CpN9fdDyUEMOMi//37IpU8NTYt+qbe+0B3oGK/9k74HWGJ2j8zavQWG8TIT1/0vKKRVL4aRFNboEHzmwHfiw5XF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 20:23:07.1076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6069da64-a309-4036-a7b5-08df1ff9cde1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB243158

Just some small things from a quick scan:

On Tue, Sep 29, 2026 at 03:45:07AM +0000, Pranjal Shrivastava wrote:
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 0a841441cc44..d0a3d497915c 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -663,11 +663,14 @@ arm_smmu_make_cmd_tlbi(enum arm_smmu_cmdq_opcode op, u16 asid, u16 vmid)
[...]
> +#define RPM_AUTOSUSPEND_DELAY_MS	15
> +
>  struct arm_smmu_ll_queue {
>  	union {
>  		u64			val;
> @@ -1234,6 +1237,18 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>  				bool sync);
>  bool arm_smmu_erratum_repeat_tlbi_cfgi(void);
>  
> +/*
> + * Lockless pre-check to test if the SMMU is actively powered.
> + * Races with concurrent suspend are benign: the cmpxchg loop in
> + * arm_smmu_cmdq_issue_cmdlist() acts as the true commit point.
> + * If we lose the race, that loop observes Q_STOP == 1 and safely
> + * drops the command. If we win, the suspend thread waits for us.
> + */
> +static inline bool arm_smmu_is_active(struct arm_smmu_device *smmu)
> +{
> +	return !Q_STOP(READ_ONCE(smmu->cmdq.q.llq.prod));
> +}

Move these to the patch that uses it? 

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 89a4e756ff17..e127e3be3a6b 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -29,6 +29,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/sort.h>
>  #include <linux/string_choices.h>
> +#include <linux/pm_runtime.h>
>  #include <kunit/visibility.h>
>  #include <uapi/linux/iommufd.h>
>  
> @@ -119,6 +120,45 @@ static const char * const event_class_str[] = {
>  static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
>  static bool arm_smmu_ats_supported(struct arm_smmu_master *master);
>  
> +/* Runtime PM helpers */
> +__maybe_unused static int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
> +{
> +	int ret;
> +
> +	if (!pm_runtime_enabled(smmu->dev))
> +		return 0;
> +
> +	ret = pm_runtime_resume_and_get(smmu->dev);
> +	if (ret < 0) {
> +		dev_err(smmu->dev, "failed to resume device: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +__maybe_unused static bool arm_smmu_rpm_get_if_active(struct arm_smmu_device *smmu)
> +{
> +	if (!pm_runtime_enabled(smmu->dev))
> +		return true;
> +
> +	return pm_runtime_get_if_active(smmu->dev) > 0;
> +}
> +
> +__maybe_unused static void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
> +{
> +	int ret;
> +
> +	if (!pm_runtime_enabled(smmu->dev))
> +		return;
> +
> +	ret = pm_runtime_put_autosuspend(smmu->dev);
> +
> +	/* -EAGAIN & -EBUSY aren't failures */
> +	if (ret < 0 && ret != -EAGAIN && ret != -EBUSY)
> +		dev_err(smmu->dev, "failed to suspend device: %d\n", ret);
> +}

Ditto

> +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
[...]
> +	/* Wait for the last committed owner to reach the hardware */
> +	while (atomic_read(&cmdq->owner_prod) != target && timeout) {
> +		udelay(1);
> +		timeout--;
> +	}
> +
> +	/*
> +	 * Entering suspend implies no active clients. A timeout here
> +	 * indicates a fatal CMDQ lockup or hardware stall. We proceed
> +	 * anyway to prioritize memory safety (avoiding stale TLBs)
> +	 */
> +	if (!timeout)
> +		dev_err(smmu->dev, "cmdq owner wait timeout, (check runtime PM + devlinks)\n");
> +
> +	/* Wait for cmdq->lock == 0 to ensure last CMDQ_CONS_REG is written */
> +	timeout = ARM_SMMU_SUSPEND_TIMEOUT_US;
> +	while (atomic_read(&cmdq->lock) != 0 && timeout) {
> +		udelay(1);
> +		timeout--;
> +	}
> +
> +	/* Timing out here implies misconfigured Runtime PM or broken devlinks */
> +	if (!timeout)
> +		dev_err(smmu->dev, "cmdq lock != 0, forcing suspend. Polling CPUs may fault.\n");

Maybe a small helper that takes: read pointer, target, print?

> +	/* Wait for pending gerror handlers */
> +	synchronize_irq(smmu->combined_irq ? smmu->combined_irq : smmu->gerr_irq);

Both might be 0?

Nicolin
