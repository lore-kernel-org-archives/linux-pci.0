Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124D230BF4F;
	Tue,  2 Jun 2026 20:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780432466; cv=fail; b=CCX6ThmYtBAnZ9i6LUJsx+7mGjzqYmxpa1QyqUdYh+I1uvPUzQbgc4zZF85GsTl69IbtveFHaDXQ4qVZB2qviMvaZcMKv2zjaeYxwVVgiNUCG5GM4vfunE12UAzmxLTgihWX0JVG+RS3ARHhJdfN7FRdRke3NObmoC8qWHZKUvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780432466; c=relaxed/simple;
	bh=mvf9JN7NGBWiqWwOWMMkPHnK96v/YV8jbkoLEN29KDo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=Mo8WTBglMnEJ6XL4a1MwAeRWMNavTlZCWBTwSmj5CFUfscjxwJlg074XG0ZaOxYAr7dXqLUovusPjN7zMfCjIm9wkWuYFUZjSOUvk3m+KWH9o9FQSdXERR22us/zbRzzv3D9md0/8HNH41o0iwExvrBfj6ZdrcdQbz5WXYQLxGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CiG7IP7X; arc=fail smtp.client-ip=52.101.48.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CiG7IP7X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXHP4ajF4+IhR5qkLwILlND+2CVrjT6uuGw/QzuFFIM+Fk9o4JDoRv1Pzr+R3nHGmi3swfaR3DuU/ne7xXdfTVmm0eyt0LbGPYd8o7mMolxHCn7Faz0z+ftie/CtbfS5DC6YsMklfLcstyp0KPU0a+kCVoHWLBzbLBLvOQj9l0ctulsMynRWXxUMVjmWd17zTmpzH26b5R/WuAQHGKsuVdegCvA88QLYWTJ4IVmmL+ld7dmEU2LB6wqhRYF+onq/SRdZ6yRIbokoFd+vvApAW3oFvsQ3g0Yq4MKgcj0nXJrpW0yLchEGkT6Z98hQ9XtGp7UB7vhHEZrKftlkTRh9fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8oyvMYnQbBPN7Aw/fSQYTkR/+NBbsmn4hGwUs0J5QMQ=;
 b=ru8mOi5Jo+hwqVDXDGBsaijc6jfZOYaje2Ad8nkk88RpkfHG3Q+3BSxXDyHDoEADPkPaNvjlgIhYkEvbJwHjS6bstMgfUqBeL6Tl76QM8nzNiOq4+iKj+2Atr+Qt/b+for/UIFH8effspYf4STLzNcArmMoyfGyhbL+0A21EM8aTJuOV9pRutOjI/FvChzvCJuiQFnGWhjXOYagzouiMimlupzl5Lu0dhgR1oPc2P43WDy1ZWMCDqG4TNl5zCDQKb8jtLkaX8upNfPAhzfniH0/rq1cbnE/sTDNvOdzlm1mD0Ts4sDS0ConLgLXo8N1awgoED09awRQADGgCJjgKlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oyvMYnQbBPN7Aw/fSQYTkR/+NBbsmn4hGwUs0J5QMQ=;
 b=CiG7IP7Xw+bbPqGPNwvcUimd9awOAU9KtoxD8fGZ/pZ5hN6sfMmh36etCn5l7ymW0FEBQhId1DH/OM+Y7qVYO5/S22vM+crjBty7KCgbx2aPvK5gR6z/YAWRBu6HDhAXPJEf68lNP0oV4Pnehbe13SIkyxVFidPXLMrdmiRmjUI=
Received: from BY1P220CA0044.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::10)
 by MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 20:34:20 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:59e:cafe::5) by BY1P220CA0044.outlook.office365.com
 (2603:10b6:a03:59e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 20:34:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 20:34:18 +0000
Received: from [10.236.179.233] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 15:34:17 -0500
Message-ID: <c21bf78d-fc98-4c05-970d-8d8b66e59904@amd.com>
Date: Tue, 2 Jun 2026 15:34:17 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v6 5/9] cxl/pci: Add CXL DVSEC reset helper
To: Srirangan Madhavan <smadhavan@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <vsethi@nvidia.com>, <alwilliamson@nvidia.com>, Dan Williams
	<danwilliams@nvidia.com>, Sai Yashwanth Reddy Kancherla
	<skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Manish Honap
	<mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, Richard Cheng
	<icheng@nvidia.com>, <linux-tegra@vger.kernel.org>
References: <20260528083154.137979-1-smadhavan@nvidia.com>
 <20260528083154.137979-6-smadhavan@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260528083154.137979-6-smadhavan@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|MW3PR12MB4409:EE_
X-MS-Office365-Filtering-Correlation-Id: 31e43b84-68d4-4a81-8eb6-08dec0e6521e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|82310400026|1800799024|56012099006|4143699003|5023799004|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QRIwSsl3/CwaKhq9i8NthGdxJBMgzegitcdDCUjmnSTO++4jCYnYlRJFvnywrKOW29fVIEn1JtT6TwFwrSOxhMkWMQuS6vHAeNvpWGAR1fi3vgmldJ4a/yZ8fu8gwTqIMWB71f+vlDpf5jYeHYY/mSuDBRthU5s9iLTNWKOZ+y4FarMT8oTZAqQBqho4NAFSfjK5SRYs9YQ10EIhaq1+6TAupBJ38rxk/+9ENdMkWZgAnVtlBATGAs5Xoqtb0zQB2z+92suN2jULw+0OrLv/hHlS8cyOEI45HI4sexmTmijSOqypr6ZgaP5KwuGa3RfEV5RPSj/IJWJojyHfdSUia1ppkSn+WBem7qR1+71eZgSzaC6kRJ52R39AiHofK7GMl1grPJP0YMruj3P/1KrLWFeew2SOGI3ZXn9H23iRUT30EJU7MudKdVN6rKqEPoXmTR+L5IEfFgCMN/6LJVseoQMk6UDAZGySqPuK9u1ggoKfl48K0ujfyufbYFm0+MSZWQXroyqccwo5WGSkdJIhJPypNkeAiZ7QTFT0kFpaknHoGCNJT8hFNyV2ieu1CWiwIfGEJ+2XZN9MimvdfC/qGmOKcWlvczqOAE8kvySNUlYaKz6d+p6JaIut5VKyuPu9YaRE4e0VUvB9f0cExa+Jp7amPfUSrHc56RUFsON+6c5sorcTdxD0fi0OpeLSrU/jxAJdTbZm8WqUVKgaVUcAixd4932607AemSwq7zDSzhA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(82310400026)(1800799024)(56012099006)(4143699003)(5023799004)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dFW1QwH8LLerSSebvE8t+PnED06AVDLeyVeaTF7VrJ/LfknDGY1HkrjqAVTYnMGPYNibI+Roa0qaVc1JNMo1yY0YbkaBHDkK3Ozu/+4R8Ksdzq7uc6ZGz2ZpSx6hB8HrDzIRtJmaWQZ6HfbUb9Ya1dmFEJvP3E9e6HH4myj3d+jAtVEojyFd2mGnAvc0HJgbv5vO6/A41Hthz8N3IrSU6SvHOKyKb4djAMos48puCFpAnQpj0JRf7lQh1TvNRrvtGDn/qLSwGFxXsbXClsKa8kJQyVAJpYWOWSnqy47FAQ67oiVfPdZE3Z4de0R9MJFRx5aeP4H0pPRsCy5pIKzMhRDNK9Mr+GAJAHFXyTQH9YdT80JJQiEvKIMwTv866fAnNArJ+SNEp3uN0nfYnJokjoAkWtTV4GssFgcH5bYBc5izsXuSzEsrHKhc1+Mkh9As
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 20:34:18.4904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e43b84-68d4-4a81-8eb6-08dec0e6521e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4409

On 5/28/2026 3:31 AM, Srirangan Madhavan wrote:
> Add a helper to execute CXL Reset through the CXL Device DVSEC. The
> helper verifies reset capability, waits for pending PCIe transactions,
> disables CXL.cache, optionally initiates cache writeback and invalidation,
> and then starts CXL Reset through the DVSEC Control2 register.
> 
> Block IOMMU traffic while reset is active, then restore IOMMU
> translations after reset completes.
> 
> Wait for the DVSEC reset timeout before checking reset completion, and
> report reset error or timeout status from the DVSEC Status2 register. Add
> the CXL Device DVSEC reset and cache control definitions needed by the
> helper.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/pci.c        | 185 ++++++++++++++++++++++++++++++++++
>  include/uapi/linux/pci_regs.h |  13 +++
>  2 files changed, 198 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 01effbb4e7cd..1dd880f5a333 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -20,6 +20,9 @@
>  #define CXL_RESET_MAX_FUNCTIONS		256
>  #define CXL_RESET_FUNCTION_MAP_REGS	(CXL_RESET_MAX_FUNCTIONS / 32)
>  #define CXL_RESET_SIBLINGS_INIT		8
> +#define CXL_RESET_CACHE_WBI_POLL_US	100
> +#define CXL_RESET_CACHE_WBI_TIMEOUT_US	(100 * USEC_PER_MSEC)
> +#define CXL_RESET_MIN_QUIET_MS		100
>  
>  /**
>   * DOC: cxl core pci
> @@ -1303,3 +1306,185 @@ cxl_pci_functions_reset_prepare(struct cxl_reset_context *ctx)
>  	cxl_pci_functions_reset_done(ctx);
>  	return rc;
>  }
> +
> +static int cxl_reset_update_ctrl2(struct pci_dev *pdev, int dvsec, u16 set,
> +				  u16 clear)

I'd change to cxl_dvsec_update_ctrl2(), see next comment.

> +{
> +	u16 ctrl2;
> +	int rc;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &ctrl2);
> +	if (rc)
> +		return rc;
> +
> +	ctrl2 &= ~clear;
> +	ctrl2 |= set;
> +
> +	return pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
> +}
> +
> +static int cxl_reset_wait_cache_inv(struct pci_dev *pdev, int dvsec)
> +{
> +	int remaining_us = CXL_RESET_CACHE_WBI_TIMEOUT_US;
> +	u16 status2;
> +	int rc;
> +
> +	do {
> +		usleep_range(CXL_RESET_CACHE_WBI_POLL_US,
> +			     CXL_RESET_CACHE_WBI_POLL_US + 1);
> +		remaining_us -= CXL_RESET_CACHE_WBI_POLL_US;
> +
> +		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
> +					  &status2);
> +		if (rc)
> +			return rc;
> +
> +		if (status2 & PCI_DVSEC_CXL_CACHE_INV)
> +			return 0;
> +	} while (remaining_us > 0);
> +
> +	pci_err(pdev, "CXL cache WB+I timed out\n");
> +	return -ETIMEDOUT;
> +}
> +
> +static int cxl_reset_enable_cache(struct pci_dev *pdev, int dvsec, u16 cap)
> +{
> +	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE))
> +		return 0;
> +
> +	return cxl_reset_update_ctrl2(pdev, dvsec, 0,
> +				      PCI_DVSEC_CXL_DISABLE_CACHING);
> +}
> +
> +static int cxl_reset_disable_cache(struct pci_dev *pdev, int dvsec, u16 cap)

I would remove the reset portion of the names of these three functions. There's nothing
reset specific about them and it'd be nice to have general functions for when/if CXL.cache
device support comes to the core.

Also would like to see the RESET part of the WBI #defines dropped for the same reasoning.

> +{
> +	int rc;
> +
> +	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE))
> +		return 0;
> +
> +	rc = cxl_reset_update_ctrl2(pdev, dvsec,
> +				    PCI_DVSEC_CXL_DISABLE_CACHING, 0);
> +	if (rc)
> +		return rc;
> +
> +	if (!(cap & PCI_DVSEC_CXL_CACHE_WBI_CAPABLE))
> +		return 0;
> +
> +	rc = cxl_reset_update_ctrl2(pdev, dvsec,
> +				    PCI_DVSEC_CXL_INIT_CACHE_WBI, 0);
> +	if (rc)
> +		goto err_enable_cache;

I think you can probably return here. I would be surprised if the pci_write/read_config()
updated the register with the new value while also returning an error.

> +
> +	rc = cxl_reset_wait_cache_inv(pdev, dvsec);
> +	if (rc)
> +		goto err_enable_cache;
> +
> +	return 0;

With above change you can drop the goto and do:
	rc = cxl_reset_wait_cache_inv(pdev, dvsec);
	if (rc)
		dev_warn(<descriptive error message>);
	
	return rc;

> +
> +err_enable_cache:
> +	/*
> +	 * Best effort rollback: preserve the original WB+I failure even if
> +	 * re-enabling CXL.cache also fails.
> +	 */
> +	cxl_reset_enable_cache(pdev, dvsec, cap);
> +	return rc;
> +}
> +
> +static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
> +{
> +	static const u32 reset_timeout_ms[] = { 10, 100, 1000, 10000, 100000 };
> +	u32 timeout_ms;
> +	u16 status2;
> +	int rc, idx;
> +
> +	idx = FIELD_GET(PCI_DVSEC_CXL_RST_TIMEOUT, cap);
> +	if (idx >= ARRAY_SIZE(reset_timeout_ms))
> +		idx = ARRAY_SIZE(reset_timeout_ms) - 1;

I'd put a dev_dbg() here just in case someone is wondering why their timeout value
is being shortened. Would also be nice for vendors/users to see that their hardware is
being programmed with a value that's (probably) too long.

> +	timeout_ms = reset_timeout_ms[idx];
> +
> +	msleep(max_t(u32, timeout_ms, CXL_RESET_MIN_QUIET_MS));
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
> +				  &status2);
> +	if (rc)
> +		return rc;
> +
> +	if (status2 & PCI_DVSEC_CXL_RST_ERR) {
> +		pci_err(pdev, "CXL reset error\n");
> +		return -EIO;
> +	}
> +
> +	if (!(status2 & PCI_DVSEC_CXL_RST_DONE)) {
> +		pci_err(pdev, "CXL reset timed out\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused cxl_dev_reset(struct pci_dev *pdev, bool mem_clear)
> +{
> +	int dvsec, rc;
> +	u16 ctrl2_clear = 0;
> +	u16 cap;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		return -ENODEV;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
> +	if (rc)
> +		return rc;
> +
> +	if (!(cap & PCI_DVSEC_CXL_RST_CAPABLE))
> +		return -EOPNOTSUPP;
> +
> +	if (mem_clear && !(cap & PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE))
> +		return -EOPNOTSUPP;
> +
> +	if (!pci_wait_for_pending_transaction(pdev))
> +		pci_err(pdev, "timed out waiting for pending transactions\n");
> +
> +	rc = pci_dev_reset_iommu_prepare(pdev);
> +	if (rc) {
> +		pci_err(pdev, "failed to block IOMMU for CXL reset: %d\n",
> +			rc);
> +		return rc;
> +	}
> +
> +	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
> +	if (rc)
> +		goto out_iommu;
> +	if (cap & PCI_DVSEC_CXL_CACHE_CAPABLE)
> +		ctrl2_clear |= PCI_DVSEC_CXL_DISABLE_CACHING;
> +
> +	if (mem_clear) {
> +		rc = cxl_reset_update_ctrl2(pdev, dvsec,
> +					    PCI_DVSEC_CXL_RST_MEM_CLR_EN, 0);
> +		if (rc)
> +			goto out_ctrl2;
> +		ctrl2_clear |= PCI_DVSEC_CXL_RST_MEM_CLR_EN;
> +	}
> +
> +	rc = cxl_reset_update_ctrl2(pdev, dvsec,
> +				    PCI_DVSEC_CXL_INIT_CXL_RST, 0);
> +	if (rc)
> +		goto out_ctrl2;
> +
> +	rc = cxl_reset_wait_done(pdev, dvsec, cap);
> +	if (rc)
> +		goto out_iommu;
> +
> +	rc = cxl_reset_update_ctrl2(pdev, dvsec, 0,
> +				    PCI_DVSEC_CXL_DISABLE_CACHING);
> +
> +out_ctrl2:
> +	if (rc && ctrl2_clear)
> +		cxl_reset_update_ctrl2(pdev, dvsec, 0, ctrl2_clear);
> +
> +out_iommu:
> +	pci_dev_reset_iommu_done(pdev);
> +	return rc;
> +}
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index fa1fcd26af01..7fc1d34fcce7 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1352,8 +1352,21 @@
>  #define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
>  #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
>  #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
> +#define   PCI_DVSEC_CXL_CACHE_WBI_CAPABLE		_BITUL(6)
> +#define   PCI_DVSEC_CXL_RST_CAPABLE			_BITUL(7)
> +#define   PCI_DVSEC_CXL_RST_TIMEOUT			__GENMASK(10, 8)
> +#define   PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE		_BITUL(11)
>  #define  PCI_DVSEC_CXL_CTRL				0xC
>  #define   PCI_DVSEC_CXL_MEM_ENABLE			_BITUL(2)
> +#define  PCI_DVSEC_CXL_CTRL2				0x10
> +#define   PCI_DVSEC_CXL_DISABLE_CACHING			_BITUL(0)
> +#define   PCI_DVSEC_CXL_INIT_CACHE_WBI			_BITUL(1)
> +#define   PCI_DVSEC_CXL_INIT_CXL_RST			_BITUL(2)
> +#define   PCI_DVSEC_CXL_RST_MEM_CLR_EN			_BITUL(3)
> +#define  PCI_DVSEC_CXL_STATUS2				0x12
> +#define   PCI_DVSEC_CXL_CACHE_INV			_BITUL(0)
> +#define   PCI_DVSEC_CXL_RST_DONE			_BITUL(1)
> +#define   PCI_DVSEC_CXL_RST_ERR			_BITUL(2)
>  #define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)		(0x18 + (i * 0x10))
>  #define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)		(0x1C + (i * 0x10))
>  #define   PCI_DVSEC_CXL_MEM_INFO_VALID			_BITUL(0)

