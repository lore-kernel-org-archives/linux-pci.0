Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011066.outbound.protection.outlook.com [40.93.194.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAFD38A71B;
	Mon,  4 May 2026 23:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777936477; cv=fail; b=ppPTUJJhRl9Tap1+iW4I/NF6s9Dmm0CUToasU0dzNyAM9AE/PbXCxysQnrzdC/PUuB/uDDxfYpIziN1e8INXxfmcNywsn6m03kC8IBx+tqrYJKIYfIyUMrTb3j4M5OMCQWGyS9fg138Qk4Ry8XPnf+COuxt9hoKbOECzy31Cj6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777936477; c=relaxed/simple;
	bh=NVI5BZ4JN5t8rG+kUTdGBBy1SbHe/u9HcRjKxfJxlTk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdRZoPWDIeMUI/OFMcP9nUL8I8tUJdOhU2Xa1wLfAadUAfCM9jbLEs32t+hN6z9TwAt5T11huByX76nuKap1Dn0AnfHyDTFlds6WONHFh81gi09RiKxORiX1JcuFWq4CvJtH5IG4YpFfEW0FU8GSHqd02LNrEl3NHj3q7/WO6Vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jRRfDlT4; arc=fail smtp.client-ip=40.93.194.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jRRfDlT4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPgNM2uljrtgZq3LjwBcgjE1i+RCwbLYFg96y+MNcWb4eUkhXPkXRhtdrEi6aIL/OmKEB4quryMkxx8u+AIMq+ddzYWcQ6HaQZD8E+IzUhnolku4xsqeTawwgrpUTtH3gcERcgRYfjEDlTJqmSnQOTXgrYOs6d0N85aCSOzShDwLgEsKVTX4l8jSHKmVz4Ogz/cloWQpAjkCXZ5oRgkmZtnMnWminqRR24eZ8MLvOB6I5AOSK7BOG9H9JjNv7L4iJ3uA0stC28Ao3KrKeh2KC8Mi2TDkwZGZ/Ov/Lzv518OBz30ImwUhmIeql1OTPhOi7WvbiooSTCKGxijOqgz5zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dp9+WptzmKO+k1EbeWJuLgtWwXlB1Hl2WtVtk9fIIjU=;
 b=KPCcWN5ECS38wHrLfw7yew8m6K/qhR1jCrpu5HzDcULgWSyNfQ6dbXjfdtk6MseSo6CLif96nJQV7YGCCAHsBEzJ6JNCIxpYw6OBudNCdj9BAzX/B29ulsAd7cuQuMakB7dxCBALnQEESxCx2tdrMVj9xL6lzqkxqBpn6iVU6t3+V7+I6cQEcpfnIzSleAmSwMl+54RHwvyJ83jy1nMBX4s9fr3P1AWgE7slSC25vOj12ot/J5p92n+RK3ONrGIqVKBeZoppxxVdqEYyvgAFslLTAV5CzFLsx9uPy0yr3ksraVHWz8jveje07axI2sqOmIO7BA8SZ0iNLL58v3vzpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dp9+WptzmKO+k1EbeWJuLgtWwXlB1Hl2WtVtk9fIIjU=;
 b=jRRfDlT4606zIgKLfWkNUejqojN1baUdmkUl+FtwqeplRiOngUiefQza4ObqXLpUg8N5b/KobBBtaCHogHJW7NRRyWZKHKwJ/CA+v1IW01szoQhGLJM7qtewrYNBRrd14frX8/Hgn4bi5yqjDVW8TYTI7g28dBX+tA6oamsp5O9kz1UC0adCskJ8+TVHkGcYpaCuLDFj768nxAkHiyot06RQ2+XRK0e5pUTOWjP6fD7t9xFORF3OneTi3TCNM9Lu/vNE/mbJLGB7RYcdn2elnIHGGpcVaiYS7jZhBmb39PiTxTvoEov6/c/ptTwgK3TCm6lk30nNXqzTB63kcOZo2Q==
Received: from SJ0PR03CA0103.namprd03.prod.outlook.com (2603:10b6:a03:333::18)
 by DS0PR12MB6439.namprd12.prod.outlook.com (2603:10b6:8:c9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.25; Mon, 4 May 2026 23:14:29 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:333:cafe::f3) by SJ0PR03CA0103.outlook.office365.com
 (2603:10b6:a03:333::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 23:14:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 23:14:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 16:14:11 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 16:14:10 -0700
Date: Mon, 4 May 2026 17:11:07 -0600
From: Alex Williamson <alex.williamson@nvidia.com>
To: Chengwen Feng <fengchengwen@huawei.com>
CC: <jgg@ziepe.ca>, <wathsala.vithanage@arm.com>, <helgaas@kernel.org>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v5 1/6] PCI/TPH: Fix pcie_tph_get_st_table_loc() field
 extraction
Message-ID: <20260504171107.040d1190@nvidia.com>
In-Reply-To: <20260427085843.42460-2-fengchengwen@huawei.com>
References: <20260427085843.42460-1-fengchengwen@huawei.com>
	<20260427085843.42460-2-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|DS0PR12MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: 96c4ddad-44b3-4c90-90d4-08deaa32e420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ZDfA+xcA8wiXdn6KmRPYpb3QqGsEdj8gaKA3nuFWoPZub9q4B+VOag7pSVMXfjrhx7BddZmFov4f/j7M5r1sgCh+oFVN78rFt9wzCcBWrXn509XJ6mMoYlGIV0DfUGUhizWzI+bjOoDn0TJk97BV1Bo0LD8SQFvY0PprUdTY4m7MJfN0ZVtvtn89St9GeomXWo7T442b+tuHLrXBYm8UrqkBFfhU2FoA5Rv/klQb5lFCYeCarhogGUKSH8fafop2FV496dGGXn9Z+UVpYLC/iXIz/ou9lnet9cN6p1L1SfQC5pO68OApyPuMQDBMR0GHCy/oZQqHFK3AU5pks6XqJQfLiaHVPEy2Pojozbw4Ib8Uh+vAsEPJO99CWtLJtOyeRVdXbUPCkAP7+WOlhOY0cw7y8RAtpraaBy4TBYaNL+i5APrC8AgVSgkPrOryUWGyxAlBXQ2pncjq96LoTmteeXop7QC4y0X13PKdUiagq6BW0W0CAc1KdGHZsBkhLDoc/PNAK9SqKNYnOBb5mT9PbAimRb+7gTOibTBxF5YpKbw9SCbAFJYiPOO6uz4j4OGXfmszBlBSNUTRlVtwuoOducdIZ/KM+OheeNB1WUCO62Rl8VR/1pIiYShzTCUcaOKIYWZ9eBTy5D0QFtyQ3SHwUupbNGaJ5KV7jTcMySqNOaryU5Ef7kjBRaj/bG0cjwD9xzHi8HiDd3uj4NrF+fzgCL3a0zrnDu/7T4p6FRDdWDU=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AOYSE5tDUiUZGnyRY7iGG/J7atcXyjIbNokc/VrpKPc4X6q1Cn25MDGRpQ+Lz3xrzfgAneQMxDqkwnl4fDwkJeTD4ymSzhxj41Tp649z3tACR3Ej/S2qAtFEKDdQkYrFjSmkv8VUtgqFsBXDnDBXRaD1mAfDSgF2iteSFMdNSaqYjtgAt2qX1io6b998wZsJatWZ2v3hNPHkOTCoYns+aLqcF+5RS93kpIBzD2F68wFGcJ67MZ9UQkIB77m0VFdCWQ53EbQMVt3NYuvotrjepbBCKXghcZ9hFiTjwaifzCjT1AfVUyI3oOQEM7+wQCXtPrh/0C2PBCuXccV18JbBsBWUcsUYsrb2E7LDpfDVHVj7CkEni24SrMDvE5zm0wpCzwru82DzlECNlhE+sdRzlytKw1lahQkooUn48CS7QwwBNNxx/pZLGME15rnWj+Va
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 23:14:28.5231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c4ddad-44b3-4c90-90d4-08deaa32e420
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6439

On Mon, 27 Apr 2026 16:58:38 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> pcie_tph_get_st_table_loc() incorrectly uses FIELD_GET(), which shifts the
> field value to bit 0. But the function is designed to return raw
> PCI_TPH_LOC_* values as defined in the function comment.
> 
> This causes incorrect ST table location detection. Fix it by using bitwise
> AND with PCI_TPH_CAP_LOC_MASK to return the unshifted field value matching
> the function specification.
> 
> Fixes: d2e8a34876ce ("PCI/TPH: Add Steering Tag support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>  drivers/pci/tph.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

AFAICT, this is effectively a no-op within drivers/pci/tph.c.  We remove
the FIELD_GET(), but we also remove the FIELD_PREP(), so the end result
is no change, other than to align with the function comment.

However, not mentioned in the commit log, mlx5_st_create() expects the
documented rather than implemented behavior here.  That should be noted
here to justify the Fixes: tag.

Reviewed-by: Alex Williamson <alex.williamson@nvidia.com>

Nit below...
 
> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 91145e8d9d95..f17b74b5fb1e 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -170,7 +170,7 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
>  
>  	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);
>  
> -	return FIELD_GET(PCI_TPH_CAP_LOC_MASK, reg);
> +	return reg & PCI_TPH_CAP_LOC_MASK;
>  }
>  EXPORT_SYMBOL(pcie_tph_get_st_table_loc);
>  
> @@ -183,11 +183,7 @@ u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
>  	u32 reg;
>  	u32 loc;
>  
> -	/* Check ST table location first */

This comment still seems valid.  Thanks,

Alex

>  	loc = pcie_tph_get_st_table_loc(pdev);
> -
> -	/* Convert loc to match with PCI_TPH_LOC_* defined in pci_regs.h */
> -	loc = FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
>  	if (loc != PCI_TPH_LOC_CAP)
>  		return 0;
>  
> @@ -316,8 +312,6 @@ int pcie_tph_set_st_entry(struct pci_dev *pdev, unsigned int index, u16 tag)
>  	set_ctrl_reg_req_en(pdev, PCI_TPH_REQ_DISABLE);
>  
>  	loc = pcie_tph_get_st_table_loc(pdev);
> -	/* Convert loc to match with PCI_TPH_LOC_* */
> -	loc = FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
>  
>  	switch (loc) {
>  	case PCI_TPH_LOC_MSIX:

