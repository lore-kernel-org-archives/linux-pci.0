Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010039.outbound.protection.outlook.com [52.101.56.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB43A3403E0;
	Tue,  2 Jun 2026 20:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780432457; cv=fail; b=eBc0kGYJ52VWL0rXZbgoJfLWgSyxsSdxccl9V4yVwQWNbclVNdCo1SUKkfHNpYsh9xnCFIS3WZiDOQJXpqiAhuzjTzCk6L7paOnjN7eqcSG4KjkTP8nDUGkIpEzgPyAwVNky2Wp3KqFxlOPtebrwOv/3FhaP3Y/NYH/0kAeS+x0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780432457; c=relaxed/simple;
	bh=of56vpLXiHlxcgio8fhmybJNHT/pAm3Q6ONQsnikqoc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=WlKRrOeif7M6GKbyPDKGuNDHrsA+e3TF0CF3PM01t0A336/UD9De/ntnFDTC/CXyFwCEGWQkxdK1fKQ0dQ3XOZEcsNt31kjXwt5XhduG8RqibfBrSnFl8EGlrZj6mdl961xUpVA126hAPW9A2khaImbNm3cxMCT76E2+C1TlJdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KJD99y0Z; arc=fail smtp.client-ip=52.101.56.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KJD99y0Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MqDUVZf23b+XDPZj4yOcdEcGQ+nG3i2ocxgG+pU+P+cQUa1Ea7auuLQfK5cuLxyJtMJ+HLoK2Is8bz2rScCwLkZoXfFO7GZdVx+DKhEySMOuNDjzqohIZaWOgBCr+V2/7eVjxl98omk8MjQodDDbP6lFg3LD/kszHKxfgEPs2JVO6aPX4JSsfl2gynsP+mEj6B8l3KcpAosxgsXbgAkBtihrdep2wXgasQ4ShW5zZjJgLgU+ZVBwf3AuojMMYGzI8NnwEFiFM2Fcl1AAlk6hby6QeUVnva9O5+U7Nh+4Qw5YboirSa3kQMTMdoMBfrQgPhFMP5fq3eoCc66sudrOYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwSekZ++HEmqG1Txfj8S0RFkA7zBwdYdmDQBeiWYMkw=;
 b=C1SpWr+yxyf+0sfYtLeXnkr0gbqlFQ2A29YbDRIqoe8icorulS19V4zm+iDD3ZXQtBrZU93OkwmnnJvsycVUKbwV0UhlbNBLv84Wkya/9tc9ogqyUg1t77gyQZGX1/fTqGkRma9Gu3L+THzi3zt0M0lhyGjyg6Gua8xGB007AmKnC045rdzUrU7nCjZ+y19MciDr+jEaLUwIwXzG1si6tGjzkaVp6wW/GZDqXEMIOV9iQNsUTlMiL/VwTH8U1viXuWGpdPSoZJST4m3lkIXsI7T4xPRjHGpsJCRo66iJoTwc01q2NonWc8b8ig/FPgOY/JGtQ2Mu0K84o3IqgL8hGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwSekZ++HEmqG1Txfj8S0RFkA7zBwdYdmDQBeiWYMkw=;
 b=KJD99y0ZQPSNV8Zl4axMPYCDGPB02IgXxmHUC4AEldkel1nzzMn4qTbhMxTVbDbX/E7g4ixbVMmdd/vEFBYNFnaMcSfouFk9GWu0GD4uqwgXLrwv1NjWclierj7DzEgK22l5jTKnKqm3aemE1acvFNBysnC9XTDw4blM6ky7XBk=
Received: from MW4PR03CA0347.namprd03.prod.outlook.com (2603:10b6:303:dc::22)
 by CH1PPF7A6EE32B1.namprd12.prod.outlook.com (2603:10b6:61f:fc00::616) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 20:34:04 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:303:dc:cafe::a1) by MW4PR03CA0347.outlook.office365.com
 (2603:10b6:303:dc::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Tue, 2
 Jun 2026 20:34:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 20:34:03 +0000
Received: from [10.236.179.233] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 15:34:02 -0500
Message-ID: <47ba3ee2-2a3b-4c86-9bc3-4ae4c80d81ab@amd.com>
Date: Tue, 2 Jun 2026 15:34:01 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v6 1/9] cxl/hdm: Add helpers to restore and commit memdev
 decoders
To: Srirangan Madhavan <smadhavan@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <vsethi@nvidia.com>, <alwilliamson@nvidia.com>, Dan Williams
	<danwilliams@nvidia.com>, Sai Yashwanth Reddy Kancherla
	<skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Manish Honap
	<mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, Richard Cheng
	<icheng@nvidia.com>, <linux-tegra@vger.kernel.org>
References: <20260528083154.137979-1-smadhavan@nvidia.com>
 <20260528083154.137979-2-smadhavan@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260528083154.137979-2-smadhavan@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|CH1PPF7A6EE32B1:EE_
X-MS-Office365-Filtering-Correlation-Id: 04ab584c-f23a-40a2-4983-08dec0e64932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|36860700016|376014|4143699003|18002099003|22082099003|56012099006|11063799006|5023799004|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	3UFDf6cBJSobA0QX6PixO5CWYk49Z9aVBUUYXhZKxQYxTW9av1KOLecogQp8peDRwlohWXPJ+tR4KfhdNXKBy1LzYFkByJtdNCjblnsytRn12B52daXD0bQpPNiaBrmtqtIjUV7j0PhVxMNTNogq+4bUm6zvEcMqrmJpFjaMWewBq7KAuEMEQQJaBdd9lmS8KS4tR8MwKF+P7n+PqPETvJirUA8kwQzxBO+m+l/Y3f1V5lNpxOP0ljmhug3VCpi7WSdJ2mR3T7c3DDLgMn/wXKerNbvojhjIfcpSvSJe5wfv8WSbZHV/4T/NJfRpiuEariHrqhjSK1S02Eno2T0h45kPp0fW/9renGsrG7WuatVtdMlenQcdOPp2Vkgwkr2g33wPRbuIWoTRRdV84R1lGmztv+P7FTI4/OfdOh4Dttojt9jAg5hhj+Lb6lEanl2yUQwvX4+moGbc52sODpQkFew0389dOnbwRliyafiiA5xfZktKpiN0Y7peKzwwyPatALMVXYYKIEnM/6g22Din1/l5zOymmJ1Omg1uk5ALs2wIHxo1iChJ3BqZ3zZ3AvYmS+y9J8SlhLJ2maoLzY5SPifkfEMX8LeOQvtS9SFOnZgEOfV/1pWvklaxyADJVxaCKDWs4lZt0lDIbA34H0huJzp1HiWZHWjKUI4/O2gTfY+U30sC+alFV8BA7t0r/qBQhlnlHCaA5Z1JZ29R5CP0b23MGDL7aIoE6tqYZUICD68=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(36860700016)(376014)(4143699003)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	v4MThvgi7SgYakBBaKTMaooCsa6KNmw93wqWXGchB+6MeEi8WZpeLm0TTwqzLLCeXhbtvW1W7taK32Kc65n+UKXw1G25h+esux+Fv5MpONcpPOeCanzGZk9sD0I5EGdmuhuW35PSYnMUKQiWdo5JQQ7I8IYnxp4qAzaTrldxEoI77wDZ7DkHZiDaWgfdvipf603dJUi3F9uMHtWV0kM+HP2UmMGsWbUPt4BX84HXWLBLySm5+ebE8dE7DgxRgEz//8HFgNDviE7Eu76vNmsNfwWu/h25MqWAM/3NSE+4NWHNW88SbwUg3cwKllVdbjyAfc4Wj74yxcFZ7KkV+P4k/WiWaCPUP+ris9zIqHAUtPS8LYjnNbhXIkhgqGe8gGgjU6WhLbriXqahRerwhiR3QDdvuQsmLf/7ep4yNj2Mi/wt426zn8VNWeSspaYqHsAF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 20:34:03.4960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ab584c-f23a-40a2-4983-08dec0e64932
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF7A6EE32B1

On 5/28/2026 3:31 AM, Srirangan Madhavan wrote:
> Add helpers to restore endpoint decoder programming for a CXL memdev from
> CXL core's cached decoder objects, then commit it as a distinct step.
> Callers are expected to have established reset safety and to hold
> cxl_rwsem.region for write.
> 
> cxl_restore_memdev_decoders() restores programmable decoder state while
> keeping traffic disabled. For HDM-backed endpoints it programs enabled
> endpoint decoder fields without COMMIT, keeps the HDM Decoder Capability
> disabled, and mirrors matching endpoint DVSEC ranges where possible. For
> endpoints without HDM decoder registers, it restores the legacy DVSEC
> ranges that model endpoint decode.
> 
> cxl_commit_memdev_decoders() enables the HDM Decoder Capability and
> commits enabled, unlocked endpoint decoders after safety checks pass. It
> sets COMMIT only after decoder fields have been restored, does not
> re-lock decoders, and does not set DVSEC MEM_ENABLE.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/hdm.c | 318 ++++++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/cxl.h      |   2 +
>  2 files changed, 317 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b..f7af1041a9fc 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -679,7 +679,7 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>  	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>  }
>  
> -static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
> +static int cxld_set_interleave_fields(struct cxl_decoder *cxld, u32 *ctrl)
>  {
>  	u16 eig;
>  	u8 eiw;
> @@ -690,14 +690,22 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>  	 */
>  	if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
>  		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
> -		return;
> +		return -EINVAL;
>  	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
>  		      "invalid interleave_granularity: %d\n",
>  		      cxld->interleave_granularity))
> -		return;
> +		return -EINVAL;
>  
>  	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
>  	u32p_replace_bits(ctrl, eiw, CXL_HDM_DECODER0_CTRL_IW_MASK);
> +	return 0;
> +}
> +
> +static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
> +{
> +	if (cxld_set_interleave_fields(cxld, ctrl))
> +		return;
> +
>  	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
>  }

Few issues here:
	1. This isn't used in this patch, so it should be moved to the patch it's used in
	2. There's no mention that this sets the COMMIT bit. A name update would be best,
	but a comment above the function could work as well.

I haven't looked ahead, but if this only gets used once or twice I would just remove this
helper, keep the name the same for cxld_set_interleave_fields(), and manually set the COMMIT
bit when you need to.

>  
> @@ -927,6 +935,310 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
>  	}
>  }
>  
> +static int cxl_restore_dvsec_range(struct cxl_memdev *cxlmd,
> +				   struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_decoder *cxld = &cxled->cxld;
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	u64 base = cxld->hpa_range.start;
> +	u64 size = range_len(&cxld->hpa_range);
> +	u32 lo;

Nit: this should be after id below
> +	int dvsec = cxlds->cxl_dvsec;
> +	int id = cxld->id;
> +	int rc;
> +
> +	if (!dvsec)
> +		return 0;
> +
> +	if (id >= CXL_DVSEC_RANGE_MAX)
> +		return 0;
> +
> +	rc = pci_write_config_dword(pdev, dvsec + PCI_DVSEC_CXL_RANGE_BASE_HIGH(id),
> +				    upper_32_bits(base));
> +	if (rc)
> +		return rc;
> +
> +	rc = pci_read_config_dword(pdev, dvsec + PCI_DVSEC_CXL_RANGE_BASE_LOW(id),
> +				   &lo);
> +	if (rc)
> +		return rc;
> +	lo &= ~PCI_DVSEC_CXL_MEM_BASE_LOW;
> +	lo |= lower_32_bits(base) & PCI_DVSEC_CXL_MEM_BASE_LOW;
> +
> +	rc = pci_write_config_dword(pdev, dvsec + PCI_DVSEC_CXL_RANGE_BASE_LOW(id),
> +				    lo);
> +	if (rc)
> +		return rc;
> +
> +	rc = pci_write_config_dword(pdev, dvsec + PCI_DVSEC_CXL_RANGE_SIZE_HIGH(id),
> +				    upper_32_bits(size));
> +	if (rc)
> +		return rc;
> +
> +	rc = pci_read_config_dword(pdev, dvsec + PCI_DVSEC_CXL_RANGE_SIZE_LOW(id),
> +				   &lo);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * Preserve MEM_INFO_VALID / MEM_ACTIVE and any reserved bits while
> +	 * restoring only the programmable size bits.
> +	 */

I would move this to where you do the masking above. I think it's (effectively) doing the same thing,
so putting it at the first instance makes it easier on the reader.

> +	lo &= ~PCI_DVSEC_CXL_MEM_SIZE_LOW;
> +	lo |= lower_32_bits(size) & PCI_DVSEC_CXL_MEM_SIZE_LOW;
> +
> +	return pci_write_config_dword(pdev,
> +				      dvsec + PCI_DVSEC_CXL_RANGE_SIZE_LOW(id),
> +				      lo);
> +}
> +
> +static int cxl_restore_hdm_decoder(struct cxl_hdm *cxlhdm,
> +				   struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_decoder *cxld = &cxled->cxld;
> +	void __iomem *hdm;
> +	u64 base, size, skip;
> +	u32 ctrl;
> +	int id;
> +
> +	id = cxld->id;
> +	hdm = cxlhdm->regs.hdm_decoder;


I would go ahead and set these variables at the top.

> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
> +		return 0;
> +
> +	base = cxld->hpa_range.start;
> +	size = range_len(&cxld->hpa_range);
> +	skip = cxled->skip;

Same with these.

> +
> +	ctrl &= ~(CXL_HDM_DECODER0_CTRL_LOCK |
> +		  CXL_HDM_DECODER0_CTRL_COMMIT |
> +		  CXL_HDM_DECODER0_CTRL_COMMITTED |
> +		  CXL_HDM_DECODER0_CTRL_COMMIT_ERROR);

You don't need the CXL_HDM_DECODER0_CTRL_LOCK bit here since you've already
verified it isn't set above.

> +	if (cxld_set_interleave_fields(cxld, &ctrl))
> +		return -EINVAL;
> +	cxld_set_type(cxld, &ctrl);
> +
> +	/* Preserve setup_hw_decoder() programming order, without COMMIT. */
> +	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> +	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> +	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
> +	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> +	writel(upper_32_bits(skip), hdm + CXL_HDM_DECODER0_SKIP_HIGH(id));
> +	writel(lower_32_bits(skip), hdm + CXL_HDM_DECODER0_SKIP_LOW(id));
> +	wmb();
> +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +
> +	return 0;
> +}
> +
> +struct cxl_restore_ctx {
> +	struct cxl_memdev *cxlmd;
> +	struct cxl_hdm *cxlhdm;
> +};
> +
> +static int cxl_restore_decoder(struct device *dev, void *data)
> +{
> +	struct cxl_restore_ctx *ctx = data;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_decoder *cxld;
> +	int rc;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	cxld = &cxled->cxld;
> +	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
> +		return 0;
> +
> +	if (ctx->cxlhdm->regs.hdm_decoder) {
> +		if (cxld->id >= ctx->cxlhdm->decoder_count)
> +			return -EINVAL;
> +
> +		rc = cxl_restore_hdm_decoder(ctx->cxlhdm, cxled);
> +		if (rc)
> +			return rc;

I'm pretty sure HDM decoders and range registers are mutually exclusive,
so this should just return the result of cxl_restore_hdm_decoder() here.

I think you could also fallback to restoring the range registers, but I'm
not sure if you need more set up to do so.
> +	}
> +
> +	return cxl_restore_dvsec_range(ctx->cxlmd, cxled);
> +}
> +
> +static int cxl_restore_decoders(struct cxl_memdev *cxlmd, struct cxl_hdm *cxlhdm)
> +{
> +	struct cxl_port *port = cxlhdm->port;
> +	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> +	struct cxl_restore_ctx ctx = {
> +		.cxlmd = cxlmd,
> +		.cxlhdm = cxlhdm,
> +	};
> +	u32 global_ctrl;
> +
> +	if (hdm) {
> +		global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +		writel(global_ctrl & ~CXL_HDM_DECODER_ENABLE,
> +		       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +	}
> +
> +	return device_for_each_child(&port->dev, &ctx, cxl_restore_decoder);

Now that I'm looking at it, I think it would be better to modify cxl_restore_dvsec_range()
to be usable by device_for_each_child() and rework this function to:

static int cxl_restore_decoders(struct cxl_memdev *cxlmd, struct cxl_hdm *cxlhdm)
{
	struct cxl_port *port = cxlhdm->port;
	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
	struct cxl_restore_ctx ctx = {
		.cxlmd = cxlmd,
		.cxlhdm = cxlhdm,
	};
	u32 global_ctrl;

	if (hdm) {
		global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
		writel(global_ctrl & ~CXL_HDM_DECODER_ENABLE,
		       hdm + CXL_HDM_DECODER_CTRL_OFFSET);

		return device_for_each_child(&port->dev, &ctx, cxl_restore_decoder());
	}

	return device_for_each_child(&port->dev, &ctx, cxl_restore_dvsec_range());
}

That would allow you to remove the hdm register NULL checks and keep the same behavior.
Only drawback is that cxl_restore_dvsec_range() wouldn't take typed parameters, but you
could use a wrapper function for that if needed.
> +}
> +
> +/**
> + * cxl_restore_memdev_decoders - Restore endpoint decoder programming
> + * @cxlmd: CXL memdev whose endpoint decoders need to be restored
> + *
> + * Restore only programmable decoder state from CXL core's cached decoder
> + * objects. For endpoints with HDM decoder registers, program the HDM decoder
> + * fields and mirror decoder ids representable by CXL_DVSEC_RANGE_MAX into the
> + * DVSEC range registers when present. For endpoints without HDM decoder
> + * registers, restore DVSEC range registers only.
> + *
> + * This helper leaves CXL.mem disabled: it does not commit HDM decoders, enable
> + * the HDM Decoder Capability, set PCI_DVSEC_CXL_MEM_ENABLE, or restore
> + * unrelated DVSEC CTRL, CTRL2, LOCK, MEM_ENABLE, or other control state.
> + * Callers must perform final commit/resume steps only after reset safety checks
> + * pass.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int cxl_restore_memdev_decoders(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxl_hdm *cxlhdm;
> +	int rc;
> +
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> +
> +	if (!endpoint)
> +		return -ENODEV;
> +
> +	cxlhdm = dev_get_drvdata(&endpoint->dev);
> +	if (!cxlhdm)
> +		return -ENODEV;
> +
> +	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
> +		rc = cxl_restore_decoders(cxlmd, cxlhdm);

I don't think you need the scoped guard here, just use a regular one? i.e.:

guard(rwsem_read, &cxl_rwsem.dpa);
return cxl_restore_decoders(cxlmd, cxlhdm);
> +	return rc;
> +}
> +
> +static int cxl_commit_restored_hdm_decoder(struct cxl_hdm *cxlhdm,
> +					   struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_decoder *cxld = &cxled->cxld;
> +	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> +	u32 ctrl;
> +	int id;
> +
> +	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
> +		return 0;
> +
> +	if (!hdm)
> +		return 0;

Can combine the two above checks.

> +
> +	id = cxld->id;
> +	if (id >= cxlhdm->decoder_count)
> +		return -EINVAL;
> +
> +	/*
> +	 * cxl_restore_hdm_decoder() programmed the decoder fields first. This
> +	 * control register write sets COMMIT as the final programming step.
> +	 */

Don't need the second sentence in this comment, it's pretty self-explanatory.

> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
> +		return 0;
> +
> +	if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED)
> +		return 0;
> +
> +	ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
> +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +
> +	return cxld_await_commit(hdm, id);
> +}
> +
> +struct cxl_commit_decoder_ctx {
> +	struct cxl_hdm *cxlhdm;
> +	int id;
> +};
> +
> +static int cxl_commit_restored_decoder_by_id(struct device *dev, void *data)
> +{
> +	struct cxl_commit_decoder_ctx *ctx = data;
> +	struct cxl_endpoint_decoder *cxled;
> +	int rc;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	if (cxled->cxld.id != ctx->id)
> +		return 0;
> +
> +	rc = cxl_commit_restored_hdm_decoder(ctx->cxlhdm, cxled);
> +	return rc ?: 1;
> +}
> +
> +/**
> + * cxl_commit_memdev_decoders - Commit restored endpoint decoder programming
> + * @cxlmd: CXL memdev whose endpoint decoders need to be committed
> + *
> + * Resume endpoint decoding after cxl_restore_memdev_decoders() has restored
> + * programmable decoder fields. For endpoints with HDM decoder registers, enable
> + * the HDM Decoder Capability and commit enabled, unlocked endpoint decoders.
> + * Locked decoders are left to their current hardware/firmware-owned state.
> + *
> + * This helper does not set PCI_DVSEC_CXL_MEM_ENABLE. Callers must enable
> + * CXL.mem only after all reset safety checks and decoder restore/commit steps
> + * have completed.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int cxl_commit_memdev_decoders(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxl_hdm *cxlhdm;
> +	void __iomem *hdm;
> +	u32 global_ctrl;
> +	int i, rc;
> +
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> +
> +	if (!endpoint)
> +		return -ENODEV;
> +
> +	cxlhdm = dev_get_drvdata(&endpoint->dev);
> +	if (!cxlhdm)
> +		return -ENODEV;
> +
> +	hdm = cxlhdm->regs.hdm_decoder;
> +	if (!hdm)
> +		return 0;
> +
> +	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +	writel(global_ctrl | CXL_HDM_DECODER_ENABLE,
> +	       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +
> +	for (i = 0; i < cxlhdm->decoder_count; i++) {
> +		struct cxl_commit_decoder_ctx ctx = {
> +			.cxlhdm = cxlhdm,
> +			.id = i,
> +		};
> +
> +		/*
> +		 * Per CXL Spec 3.1 8.2.4.20.12 software must commit decoders

Update to 4.0 spec.

> +		 * in HPA order. Region setup already enforces that ordering by
> +		 * decoder id, so restore commits follow ascending id order.
> +		 */
> +		rc = device_for_each_child(&endpoint->dev, &ctx,
> +					   cxl_commit_restored_decoder_by_id);
> +		if (rc < 0)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
>  static int cxl_setup_hdm_decoder_from_dvsec(
>  	struct cxl_port *port, struct cxl_decoder *cxld, u64 *dpa_base,
>  	int which, struct cxl_endpoint_dvsec_info *info)
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1297594beaec..b51b1e9d6400 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -794,6 +794,8 @@ int cxl_port_setup_regs(struct cxl_port *port,
>  struct cxl_dev_state;
>  int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  			struct cxl_endpoint_dvsec_info *info);
> +int cxl_restore_memdev_decoders(struct cxl_memdev *cxlmd);
> +int cxl_commit_memdev_decoders(struct cxl_memdev *cxlmd);
>  
>  bool is_cxl_region(struct device *dev);
>  

