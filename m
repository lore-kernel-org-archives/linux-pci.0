Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012044.outbound.protection.outlook.com [52.101.53.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899D2367B90;
	Tue,  2 Jun 2026 21:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780436145; cv=fail; b=bQpll7+lSBwnqslMMJw336ZU8IbryVHJPAtJ6yKhKfH6r+UhuBDMsvQiEd29ujQdOx2hQ3uzx66mu2DVAjSiGP5ojr4+U2bJwYZfaC64UMmmVoEf6WaBTZaS5sWkJdVs8rvwY10GTFFaCQKZr6KVS2C3n9HOoO1Nb/00KS4TcSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780436145; c=relaxed/simple;
	bh=1lx11/mxqK17LpuaQU1GBGi7ufgCkKOd0mccmgvqWus=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=PNx5PbV2m1yOzIbLRMNpDnvzd4hXUEyvgOQdinZhw7vo34IxhFKlVKjqv/ZOastznC0n1alkA0C6Si2c0MmB3Z9h2ZbZZmEEaTPWfGh0lnOGPWHk0xALSrgW/EDj3z2fb9STwX/fJkWKQW8sLUW2giZcbsrwyr2fDpB/Iu8CFnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rM6z3DGR; arc=fail smtp.client-ip=52.101.53.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rM6z3DGR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RcmVvaPWT8CazoLhJ1tNf4AJx0z1fZKjTUCdSauJusitapMYTqIHFbzkFc9/F3iBs5fQGxemF4WQFA+mB7LKMZuLwTTnextsXukdnr2uKVRwiPejMEroZDp9XRkwwtdkE0WBJ/vJE2K3/LsPYtEM+0HE380WrRBnzRdLk73bm06wOnOtBHcXPqcCoPkMEiTKIVqpapbNCOmuqYTpL0LNpLqHwgLSDJ+PH0wpQ6VgtNEedVEqWmkMe7Gcb+THfE2duxMEBwE2Xz9XM4PQednDBoO4XW2pkdv/4tMnfin/fPodSMeNKQgLokWhu4ojAUfVTfQ0oni7QKh/wDIiydIJzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsCdX+ZwY5Jwq8sJaFcwy9c/tYM2PGeq/EIzHtViLMU=;
 b=Y8S/x+WHzuaxrGoJd4Isb0j8/23/5LVDWGnBBsszGaNM39Vu8bNgW7iFLU23Y3sz2NXqGcey7UtBMb+sFtkA2SSYyGPDp38LL9kw7wQX4tAT8Z7h7B4rvldGSpJuitgtnM4gjzElJvwLZw/6DsqPy3byHNT+X1XCXN6jOrtO2fh6aB9HYzMEVunBTJOsN00a4UcQud9oETHVzhe45A5sPTj2C6Ne956j+ZcKdHF36resqtone28pngMu0fFbbKUMUHm+iJwYrDSkc16wDnBjEVT5c9tlA3ooRh1n+DlA73C9c3Dp0ql3CXCFs5RKGI39oSQzI1SL70sjNeeZ83ttRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsCdX+ZwY5Jwq8sJaFcwy9c/tYM2PGeq/EIzHtViLMU=;
 b=rM6z3DGRMOmSbnHVmZzerOLMWtaAUy5pDn0RHisI33E0yZz/6m+Qn5vcG6a/6pl4iOunbFHbmfHK+oJ2xrePwEfgXSWlXrYBQc4jsWjWCZ/NqQFFFGPzjfglxyGU8x6AJeZgHT3H/rEMjoJHYRThufXA5kSYOFBC9Dlcc1oHgjw=
Received: from CY5PR15CA0054.namprd15.prod.outlook.com (2603:10b6:930:1b::20)
 by MW6PR12MB8735.namprd12.prod.outlook.com (2603:10b6:303:245::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Tue, 2 Jun 2026
 21:35:38 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:930:1b:cafe::8b) by CY5PR15CA0054.outlook.office365.com
 (2603:10b6:930:1b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 21:35:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 21:35:38 +0000
Received: from [10.236.179.233] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 16:35:37 -0500
Message-ID: <0659eee1-d978-41f5-b626-b872ab87431d@amd.com>
Date: Tue, 2 Jun 2026 16:35:37 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v6 8/9] cxl/memdev: Add cxl_reset sysfs attribute
To: Srirangan Madhavan <smadhavan@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <vsethi@nvidia.com>, <alwilliamson@nvidia.com>, Dan Williams
	<danwilliams@nvidia.com>, Sai Yashwanth Reddy Kancherla
	<skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Manish Honap
	<mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, Richard Cheng
	<icheng@nvidia.com>, <linux-tegra@vger.kernel.org>
References: <20260528083154.137979-1-smadhavan@nvidia.com>
 <20260528083154.137979-9-smadhavan@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260528083154.137979-9-smadhavan@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|MW6PR12MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aadadde-3857-47f2-813f-08dec0eee390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|6133799003|13003099007|3023799007|5023799004|4143699003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	P4XAmpFr4gdPPwo/n6R2LBPy7izEegadwCjZFDvcXR6t+0qONq+qN+5erM8Aau1K0XzDZodUCUbX3HodtD6CcHrKJyc3cLDSJoF5oLjwYrYiQsRB7HJphWaaSKumLpmja71KvwwLrROKBNhLiEvDd2aFchwSGROiDxCvGgCpQzJvgVKq6Z1d0q7GiCgFXYC0m3C+SIKlT3cqvoLNFAJLAwGtxKrB9bJ/JIQ+iRZd//TJFQJnOFMbYxkDQEAdrXe/sPRr6iR8MalPiWcKmCEhhmfA3DTCmGs24s9pN/QN38ooiO/IxWbjbT2fnO9xlromQeNTjUviduH9KbAiTE79YaZv5yyyDTNBvVHbWqCfnUahLaPyDKeJQKctG3KqkkSk/JojyBc0uMdshbTOajfAQI3JpTc35PfEhZKhPVFV93/WkDyWtoqgFKGQrC0G1oqLEGmHsh0Z84RPp9WDPr9wMWI1E/wm3Drff0QSASi9LcJU01LqbAuDVR/S5rpu8/54Y/89e/DL0ekczsxUNFtW3xkQp6tcGoOovr2p9M3NRki5eIsnWQ8/Fr7UuKVMAQafX+M2HTtv6XXgbQAWfi3zV/Ef6Q1uWKVki7Cjr1adKCxXtE/qkT+ZJBGTlEnAsLwFQtoFqrU+kS1rdALy//S7Aw92Noe6hZqEPpRHKHGAfybTKS9lwFdCzqWBnxPuc9Xn
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(6133799003)(13003099007)(3023799007)(5023799004)(4143699003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	m+ErdA+NWSC3Z1RuDEfzZFSLBwV+WXpt1/1zAGX4hUj2/zghv0Oq7kojKQUoNp1lFlO5at4N2teLnFM1tVHx96zQyrdkmQZUdCwihyVUAeQgdj4Xj+p/KQJS78aR7mM0c7oZiJsjrNjXKyc7HSEhXmgrun31X5NZmcOhUq4G2EeDi9dEsylKwHlGag7CCs36/YnpgDCPuF3KMtLjLAbGYec44JxVONFF3WXbBvfjwa8yq3ridYFZSdSBLKdCQjBxfkJPeFzCCygLoZDb7V0bOmrGso6wiDv+Lmsbf4LBHMBDvRciczjvg0+brpipOICRsXbHP9phNuOKuU2cycou8YMpZj2/qRlenklLgjSV2R9Emq5JYEeX0bXueD+idwSOThOuYRQhBEfI7FKFJIxY69LK0Ndq+n80xHfcFEDvnD47fIyUDwVu3mc4xCuRmUA8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 21:35:38.5502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aadadde-3857-47f2-813f-08dec0eee390
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8735

On 5/28/2026 3:31 AM, Srirangan Madhavan wrote:
> Expose CXL reset through the CXL memdev device. The reset flow
> depends on CXL memdev state to identify affected regions, coordinate
> decoder restore, and keep CXL-specific policy out of the PCI sysfs ABI.
> 
> Add a write-only cxl_reset attribute under memX. The attribute is visible
> only when the memdev's PCI parent advertises CXL Reset capability.
> Writing a true boolean value invokes the CXL reset orchestration.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/memdev.c |  30 +++++++++++
>  drivers/cxl/core/pci.c    | 102 +++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/cxl.h         |   3 ++
>  drivers/cxl/cxlmem.h      |   2 +
>  4 files changed, 136 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 80e65690eb77..af67fa3d11b8 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -199,6 +199,26 @@ static ssize_t security_erase_store(struct device *dev,
>  static struct device_attribute dev_attr_security_erase =
>  	__ATTR(erase, 0200, NULL, security_erase_store);
>  
> +static ssize_t cxl_reset_store(struct device *dev,
> +			       struct device_attribute *attr, const char *buf,
> +			       size_t len)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	bool reset;
> +	int rc;
> +
> +	rc = kstrtobool(buf, &reset);
> +	if (rc)
> +		return rc;
> +
> +	if (!reset)
> +		return -EINVAL;
> +
> +	rc = cxl_memdev_reset(cxlmd);
> +	return rc ? rc : len;
> +}
> +static DEVICE_ATTR_WO(cxl_reset);
> +
>  bool cxl_memdev_has_poison_cmd(struct cxl_memdev *cxlmd,
>  			       enum poison_cmd_enabled_bits cmd)
>  {
> @@ -421,6 +441,7 @@ static struct attribute *cxl_memdev_attributes[] = {
>  	&dev_attr_payload_max.attr,
>  	&dev_attr_label_storage_size.attr,
>  	&dev_attr_numa_node.attr,
> +	&dev_attr_cxl_reset.attr,
>  	NULL,
>  };
>  
> @@ -485,8 +506,16 @@ static struct attribute *cxl_memdev_security_attributes[] = {
>  static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
>  				  int n)
>  {
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +
>  	if (!IS_ENABLED(CONFIG_NUMA) && a == &dev_attr_numa_node.attr)
>  		return 0;
> +
> +	if (a == &dev_attr_cxl_reset.attr &&
> +	    !cxl_memdev_reset_capable(cxlmd))
> +		return 0;
> +
>  	return a->mode;
>  }
>  
> @@ -1099,6 +1128,7 @@ static int cxlmd_add(struct cxl_memdev *cxlmd, struct cxl_dev_state *cxlds)
>  
>  	cxlmd->cxlds = cxlds;
>  	cxlds->cxlmd = cxlmd;
> +	cxl_memdev_init_reset(cxlmd);
>  
>  	rc = cdev_device_add(&cxlmd->cdev, &cxlmd->dev);
>  	if (rc) {
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 486c447e98f3..09f016544d24 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1207,6 +1207,22 @@ static bool cxl_reset_has_cache_or_mem(struct pci_dev *pdev)
>  	return cap & (PCI_DVSEC_CXL_CACHE_CAPABLE | PCI_DVSEC_CXL_MEM_CAPABLE);
>  }
>  
> +static bool cxl_reset_is_type2(struct pci_dev *pdev)
> +{
> +	u16 dvsec, cap;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		return false;
> +
> +	if (pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap))
> +		return false;
> +
> +	return (cap & PCI_DVSEC_CXL_CACHE_CAPABLE) &&
> +	       (cap & PCI_DVSEC_CXL_MEM_CAPABLE);
> +}
> +
>  static int cxl_reset_add_sibling(struct cxl_reset_context *ctx,
>  				 struct pci_dev *sibling)
>  {
> @@ -1939,7 +1955,7 @@ static int cxl_do_reset_locked(struct cxl_reset_context *ctx, bool mem_clear)
>  	return rc;
>  }
>  
> -static int __maybe_unused cxl_do_reset(struct pci_dev *pdev, bool mem_clear)
> +static int cxl_do_reset(struct pci_dev *pdev, bool mem_clear)
>  {
>  	struct cxl_reset_context ctx = {
>  		.target = pdev,
> @@ -1966,3 +1982,87 @@ static int __maybe_unused cxl_do_reset(struct pci_dev *pdev, bool mem_clear)
>  	cxl_reset_context_destroy(&ctx);
>  	return rc;
>  }
> +
> +static struct pci_dev *cxl_reset_get_fn0(struct pci_dev *pdev)
> +{
> +	unsigned int devfn;
> +
> +	/*
> +	 * CXL Reset control/status is exposed in Function 0 and affects all
> +	 * CXL.cache/mem functions in the device.
> +	 */
> +	if (pci_ari_enabled(pdev->bus))
> +		devfn = 0;
> +	else
> +		devfn = PCI_DEVFN(PCI_SLOT(pdev->devfn), 0);
> +
> +	if (pdev->devfn == devfn)
> +		return pci_dev_get(pdev);
> +
> +	return pci_get_slot(pdev->bus, devfn);
> +}
> +
> +static bool cxl_memdev_probe_reset_capable(struct cxl_memdev *cxlmd)
> +{
> +	struct device *dev = cxlmd->dev.parent;
> +	struct pci_dev *pdev, *fn0;
> +	int dvsec;
> +	u16 cap;
> +
> +	if (!dev || !dev_is_pci(dev))
> +		return false;
> +
> +	pdev = to_pci_dev(dev);
> +	if (!cxl_reset_is_type2(pdev))
> +		return false;
> +
> +	fn0 = cxl_reset_get_fn0(pdev);
> +	if (!fn0)
> +		return false;
> +
> +	dvsec = pci_find_dvsec_capability(fn0, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		goto out;
> +
> +	if (pci_read_config_word(fn0, dvsec + PCI_DVSEC_CXL_CAP, &cap))
> +		goto out;
> +
> +	pci_dev_put(fn0);
> +	return cap & PCI_DVSEC_CXL_RST_CAPABLE;
> +
> +out:
> +	pci_dev_put(fn0);
> +	return false;
> +}
> +
> +void cxl_memdev_init_reset(struct cxl_memdev *cxlmd)
> +{
> +	cxlmd->reset_capable = cxl_memdev_probe_reset_capable(cxlmd);
> +}
> +
> +bool cxl_memdev_reset_capable(struct cxl_memdev *cxlmd)
> +{
> +	return cxlmd->reset_capable;
> +}

I would get rid of these and just set reset_capable in cxlmd_add() and check
reset_capable directly.

I guess these could be used by a type 2 driver in the future, but it's probably
better to defer creating these functions until then.

> +
> +int cxl_memdev_reset(struct cxl_memdev *cxlmd)
> +{
> +	struct device *dev = cxlmd->dev.parent;
> +	struct pci_dev *fn0;
> +	int rc;
> +
> +	if (!cxl_memdev_reset_capable(cxlmd))
> +		return -EOPNOTSUPP;
> +
> +	if (!dev || !dev_is_pci(dev))
> +		return -ENODEV;
> +
> +	fn0 = cxl_reset_get_fn0(to_pci_dev(dev));
> +	if (!fn0)
> +		return -ENODEV;
> +
> +	rc = cxl_do_reset(fn0, false);
> +	pci_dev_put(fn0);
> +	return rc;
> +}
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index b51b1e9d6400..bf65996e24dc 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -796,6 +796,9 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  			struct cxl_endpoint_dvsec_info *info);
>  int cxl_restore_memdev_decoders(struct cxl_memdev *cxlmd);
>  int cxl_commit_memdev_decoders(struct cxl_memdev *cxlmd);
> +void cxl_memdev_init_reset(struct cxl_memdev *cxlmd);
> +bool cxl_memdev_reset_capable(struct cxl_memdev *cxlmd);
> +int cxl_memdev_reset(struct cxl_memdev *cxlmd);
>  
>  bool is_cxl_region(struct device *dev);
>  
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 776c50d1db51..c8e7349fb130 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -48,6 +48,7 @@ struct cxl_memdev_attach {
>   * @cxl_nvd: optional bridge to an nvdimm if the device supports pmem
>   * @endpoint: connection to the CXL port topology for this memory device
>   * @attach: creator of this memdev depends on CXL link attach to operate
> + * @reset_capable: cached CXL Reset support
>   * @id: id number of this memdev instance.
>   * @depth: endpoint port depth
>   * @scrub_cycle: current scrub cycle set for this device
> @@ -65,6 +66,7 @@ struct cxl_memdev {
>  	struct cxl_nvdimm *cxl_nvd;
>  	struct cxl_port *endpoint;
>  	const struct cxl_memdev_attach *attach;
> +	bool reset_capable;

Should this go into cxl_dev_state instead? This seems like a driver state thing, but the
line is a bit blurry here.

>  	int id;
>  	int depth;
>  	u8 scrub_cycle;

