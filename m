Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010066.outbound.protection.outlook.com [52.101.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352E9423EB7;
	Wed, 23 Sep 2026 21:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790199675; cv=fail; b=JlTLeVJnmvw/1dzAiIdkv4LjcRyQRApDBzT6/ehBOGCbyfZcAsviG83oHAHd/QwR8aLrPDr5UKI2wXMQsbRst2hH6gVYzkAOmCTKHc2+5JZ0pHvm1XHxn1VmvzEAc581LjqbyLIAlrLJpg9RQNTQeeC9BLKnR0pgZGFdJnr6boI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790199675; c=relaxed/simple;
	bh=/3pqY9LDEsbyqXCslKF6ombk3L9svwRul9JThjOExW0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=IYOCxvcAtrr5vpv9X5J8zJUYeoJyPDTapBh86oUJ8hvPhqxU9gpnEP2XxZKdz/HqMZ0oVzAdkgMRoBLXFFuZ/ECna6sfABfZYqmIzxmbb8swQ83Wi0BnWLvcvXmzFc1W7V2SVPnDD6R8h/o0EriM1PJNVi3oPxrCMbzhkkoWfss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G/xGAIhH; arc=fail smtp.client-ip=52.101.201.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G/xGAIhH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q11NOMNlsJpy0eDb8sLFeejvsHyDGtN4pG4LnA8FfEN88/JxrPj2pRRFJ/VaAY+ihWbFTy0aur9w3dTJ5mGgAXv+Wr2lCT7rcxLHc/2WvqrL1GXznUuFPXeJNbKLAce3ES7eoO7rOs6XPFBjFwnV7F7e43finh7GyPIwQOTnvePU9XMrMEMG2HCOlijBH0Mxe95jUe7FEAIl+Yy5l48nXVBLEBs8Uy/MIDMr/dfITVQCanXnAVHLmimdoAF71OFKxgLq7GSnocVfmH96PuNYJ4wVOZy8DCLf5VW+j6fe/a5HF85kgEnE0mIsU4hCNX54AeL7avZBDigiOvPXBSSwJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hooBYJwaD+VfWn2eNfSf4tYwW8UJfTrQ7vegjJvZwQM=;
 b=F+7WoS97yQ18y0DBu6H6twvjHfoz35uLEJzhQIZtui19vLSH6qInEe75cXkJc9GP36CXIMoNOjnpGgEpFgQhYQUh1Th8Et9kv+VXuUCPPPiYw6c0UtnwCNuGXIBN3xANajsiFGlHZVYWQYVp2aQXE7+IpA2EM1poaP8+bGRskqA5gihxZIDMfBacxgJu3cZtrONrO4989yGhbZgiutNWxfO3xPG2fJxZvuH0zJ1l08R0QCu01aBejvJnKLKdX1gF7S+gIQxrzHmH/9NcBVNc4gfvSxu2J004gAYJoUcgx2Q4QyOpiIz5aiy3fMx4ih5dijqOpxgxsvNJp0I87xcZuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hooBYJwaD+VfWn2eNfSf4tYwW8UJfTrQ7vegjJvZwQM=;
 b=G/xGAIhHfV7Xvsg7RG8zQM10YH5d5YCkNgq2RMYIllzrG4X6wHKqMrUjFdBsrw1HbqlwwD/lGnfRBZC5exKQwK3JpZpHihQPPL3A381cNuUx77y9SRNQa4OrXYUIP5mx4xZWddpgvfy/IkrnfQQWVQ/rVqA6oBJyqmErniawLz8=
Received: from MW4P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::18)
 by SA3PR12MB9132.namprd12.prod.outlook.com (2603:10b6:806:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 21:41:07 +0000
Received: from SJ1PEPF000037A8.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::5c) by MW4P222CA0013.outlook.office365.com
 (2603:10b6:303:114::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 21:41:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A8.mail.protection.outlook.com (10.167.244.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 21:41:02 +0000
Received: from [10.236.178.170] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 16:41:00 -0500
Message-ID: <cd752641-4563-40d0-a53c-b7a85d396097@amd.com>
Date: Wed, 23 Sep 2026 16:40:59 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v13 10/15] cxl: Add CXL Device Reset sequencing
To: Srirangan Madhavan <smadhavan@nvidia.com>, Alison Schofield
	<alison.schofield@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang
	<dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny
	<ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Alex Williamson <alex.williamson@redhat.com>, <vsethi@nvidia.com>,
	<alwilliamson@nvidia.com>, Sai Yashwanth Reddy Kancherla
	<skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Manish Honap
	<mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, Richard Cheng
	<icheng@nvidia.com>, <linux-tegra@vger.kernel.org>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-11-smadhavan@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260922083924.2451158-11-smadhavan@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A8:EE_|SA3PR12MB9132:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e95a42-bf3f-465e-5c8c-08df19bb5d27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700016|23010399003|6133799003|18002099003|22082099003|3023799007|921020|56012099006|11063799006|10067099003|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info:
	MXPAgNQkSzdmnih6TOCceoNJ9vkCEy9jx2bcJctcJ/sfIsRtqSmanV5sf/4+nd4AnzlLfx1nJQ99RpeWzXJAbNL2xTMQ6PeyMaM02d+hnYHMCsMy8IhBC9u2QeN1ewaMCk6XLCe4t47Y2j0W+nSz4MixrYKfJmuAslLI7cCVzK4WvYfExondxMbL/5ItLC5367R21ObJWOIINR1FdeLTU1NJzB9kOzLj1AR8KvU0REI5KMsbIkBy98Sd+0z7b/eCOyYp45t5aTahFZimnPkfoajMXAw5fs/H4vf268z39S/gLrAEJ6nG3QpHF2MUCB2YHB1FroO5/UnnsgikiwMpLs5k2DY4i7Dkw6wlxC1gP5+2tl7Ifp2Xsa/GjlQkj93zWedleLHN9dg8RFLvgyZ6uYjRPFePz+O+ZNvn2xZiO+/fuLddcmNgAmlm4sRLSIc3lBXFwbm0WErTZAJRiNeK/Kgq2fnjBdlqb1FIfhrhlAWTrGGlIvAEDYLYmcIjkzWzN8B9gsjyVIPYe44Chla3pDs57lgjZqsNLY6gsON5ZP63kan2lhGRwennu7KlTYMVqy6XCndyNaHvvwznacQgMbfNbntMHDVQqzQn51KHq7mH+XTd1eDP1StBx3/8SKzd64r67jULxusVelWR11R8N59sSIwUhAYqyI1yvZQ74xEWmMQYHtE/cxqyx4j7xkKh8Ug8MWVqRXAMiOsNTFit4WZTh9Fdo6/cJcIx0LRmcTVUgEWK4fCo1vw3yz4vj6gE
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700016)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(921020)(56012099006)(11063799006)(10067099003)(5023799004)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fTd1YSZpZYnNNmWp61GiTXKSrJfLP1mVnC7e3YQOU2qoWicpcVMWMxznF77Vps3D7HctUoiMAmdpoWKe003OSC0/D3ObkvHqADdZ2O04bUWFCIhVAmPTbIxWuRMKv99D8yw1H0tgLpP9pqzNheFR++ZbIveSyLj5c7n3DRWlAdddszkGgN9L4H36OiCEwYiv2lwLpdRa5zLsOZQu7hdjFozlpcMo8Dn9NNqH274HfupzWj0eF1Q59lcJdoZr8GlwpmZK1Q9VJun646fCGKgA5K6kPXXldE6XMn5ceBm6IHI93M3XkVR1uF76XTxSIQ0Pk6tVo7CUpeRe0OIG6Ag5MDpWzPxh9MKUU4nqJXUtlK4cBjMSIDkmTUKeJITSwBa4fmeQ4btnP6E8rGD+u4M7wg/fKwAHlOF4Ooh8MNI85bOsM1KBD8uTCYPmPkNYg2sA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 21:41:02.1581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e95a42-bf3f-465e-5c8c-08df19bb5d27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9132

On 9/22/2026 3:39 AM, Srirangan Madhavan wrote:
> Implement CXL Device Reset for eligible Type 2 devices: disable CXL.cache,
> perform supported writeback, drain transactions, prepare the IOMMU,
> initiate reset with Memory Clear enabled, and wait for completion.
> 
> Observe the 100 ms post-reset quiet period before polling Status2, and
> treat an all-ones read as not ready. Treat Control2 command bits as
> transient state, restore cache policy on exit, preserve the primary error,
> and abort when IOMMU preparation fails.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/resource.c   | 229 ++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h             |   7 ++
>  include/uapi/linux/pci_regs.h |  14 +++
>  3 files changed, 250 insertions(+)
> 
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index b5f8c28e613f..57eec77cbb21 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ -8,6 +8,8 @@
>  #include <linux/export.h>
>  #include <linux/io.h>
>  #include <linux/ioport.h>
> +#include <linux/iommu.h>
> +#include <linux/jiffies.h>
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
> @@ -419,3 +421,230 @@ void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
>  	pdev->hdm = NULL;
>  	kfree(info);
>  }
> +
> +/*
> + * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
> + * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
> + * initiating CXL Reset, then limits software to CXL Status2 access until
> + * reset completion, timeout, or error.
> + */
> +#define CXL_RESET_RRS_WAIT_MS 100
> +#define CXL_RESET_STATUS_POLL_MS 20
> +static const u32 cxl_reset_timeout_ms[] = {
> +	10, 100, 1000, 10000, 100000,
> +};
> +
> +#define CXL_CACHE_WBI_TIMEOUT_US 100000
> +#define CXL_CACHE_WBI_POLL_US 100
> +
> +#define CXL_RESET_CTRL2_CMD_MASK \
> +	(PCI_DVSEC_CXL_INIT_CACHE_WBI | PCI_DVSEC_CXL_INIT_CXL_RST)
> +
> +static int cxl_reset_update_ctrl2_no_replay(struct pci_dev *pdev, int dvsec,
> +					    u16 set, u16 clear)
> +{
> +	u16 ctrl2;
> +	int rc;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &ctrl2);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +	if (PCI_POSSIBLE_ERROR(ctrl2))
> +		return -ENODEV;
> +
> +	/*
> +	 * INIT_CACHE_WBI and INIT_CXL_RST are commands. Do not replay a command
> +	 * that remains set in the value read back while updating persistent
> +	 * Control2 state.
> +	 */
> +	ctrl2 &= ~CXL_RESET_CTRL2_CMD_MASK;
> +	ctrl2 &= ~clear;
> +	ctrl2 |= set;
> +
> +	rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	return 0;
> +}
> +
> +static int cxl_reset_wait_cache_wbi(struct pci_dev *pdev, int dvsec)
> +{
> +	unsigned long deadline;
> +	u16 status2;
> +	int rc;
> +
> +	rc = cxl_reset_update_ctrl2_no_replay(pdev, dvsec,
> +					      PCI_DVSEC_CXL_INIT_CACHE_WBI, 0);
> +	if (rc)
> +		return rc;
> +
> +	deadline = jiffies + usecs_to_jiffies(CXL_CACHE_WBI_TIMEOUT_US);
> +	while (time_before(jiffies, deadline)) {
> +		usleep_range(CXL_CACHE_WBI_POLL_US,
> +			     CXL_CACHE_WBI_POLL_US * 2);
> +
> +		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
> +					  &status2);
> +		if (rc)
> +			return pcibios_err_to_errno(rc);
> +		if (PCI_POSSIBLE_ERROR(status2))
> +			return -ENODEV;
> +		if (status2 & PCI_DVSEC_CXL_CACHE_INV)
> +			return 0;
> +	}
> +
> +	/* Do not miss completion concurrent with the polling deadline. */
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
> +				  &status2);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +	if (PCI_POSSIBLE_ERROR(status2))
> +		return -ENODEV;
> +	if (status2 & PCI_DVSEC_CXL_CACHE_INV)
> +		return 0;
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int cxl_reset_disable_cache(struct pci_dev *pdev, int dvsec, u16 cap)
> +{
> +	int rc;
> +
> +	rc = cxl_reset_update_ctrl2_no_replay(pdev, dvsec,
> +					      PCI_DVSEC_CXL_DISABLE_CACHING, 0);
> +	if (rc || !(cap & PCI_DVSEC_CXL_CACHE_WBI_CAPABLE))
> +		return rc;
> +
> +	return cxl_reset_wait_cache_wbi(pdev, dvsec);
> +}
> +
> +static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
> +{
> +	unsigned long deadline;
> +	u32 timeout_ms;
> +	u16 status2;
> +	int idx, rc;
> +
> +	idx = FIELD_GET(PCI_DVSEC_CXL_RST_TIMEOUT, cap);
> +	if (idx >= ARRAY_SIZE(cxl_reset_timeout_ms)) {
> +		int last = ARRAY_SIZE(cxl_reset_timeout_ms) - 1;
> +
> +		pci_warn(pdev,
> +			 "unknown CXL reset timeout encoding %d; using %u ms\n",
> +			 idx, cxl_reset_timeout_ms[last]);
> +		idx = last;
> +	}
> +
> +	timeout_ms = max_t(u32, cxl_reset_timeout_ms[idx],
> +			   CXL_RESET_RRS_WAIT_MS);
> +	msleep(CXL_RESET_RRS_WAIT_MS);
> +	deadline = jiffies + msecs_to_jiffies(timeout_ms -
> +					      CXL_RESET_RRS_WAIT_MS);
> +
> +	for (;;) {
> +		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
> +					  &status2);
> +		if (rc || status2 == U16_MAX)
> +			goto not_ready;
> +		if (status2 & PCI_DVSEC_CXL_RST_ERR)
> +			return -EIO;
> +		if (status2 & PCI_DVSEC_CXL_RST_DONE)
> +			return 0;
> +
> +not_ready:
> +		if (time_after_eq(jiffies, deadline))
> +			return -ETIMEDOUT;
> +
> +		msleep(CXL_RESET_STATUS_POLL_MS);

The goto here isn't necessary, I think this is functionally equivalent:

		if ((rc || status2 == U16_MAX) && time_after_eq(jiffies, deadline))
			return -ETIMEDOUT;
		else if (status2 & PCI_DVSEC_CXL_RST_ERR)
			return -EIO;
		else if (status2 & PCI_DVSEC_CXL_RST_DONE)
			return 0;

		msleep(CXL_RESET_STATUS_POLL_MS);

Sashiko also brought it up, but the timeout is probably too long. I'd pick something like 20s
instead. That's probably still too conservative, but I don't know enough to suggest a more practical
value.
> +	}
> +}
> +
> +static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
> +{
> +	int rc, rc2;
> +
> +	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
> +	if (rc)
> +		goto out_enable_cache;
> +
> +	if (!pci_wait_for_pending_transaction(pdev)) {
> +		pci_err(pdev, "timed out waiting for pending transactions\n");
> +		rc = -ETIMEDOUT;
> +		goto out_enable_cache;
> +	}
> +
> +	rc = pci_dev_reset_iommu_prepare(pdev);
> +	if (rc) {
> +		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
> +		goto out_enable_cache;
> +	}
> +
> +	/* Clear Memory Clear again even if this command write reports failure. */
> +	rc = cxl_reset_update_ctrl2_no_replay(pdev, dvsec,
> +					      PCI_DVSEC_CXL_INIT_CXL_RST |
> +					      PCI_DVSEC_CXL_RST_MEM_CLR_EN, 0);
> +	if (rc)
> +		goto out_clear_memory;
> +
> +	rc = cxl_reset_wait_done(pdev, dvsec, cap);
> +
> +out_clear_memory:
> +	rc2 = cxl_reset_update_ctrl2_no_replay(
> +		pdev, dvsec, 0, PCI_DVSEC_CXL_RST_MEM_CLR_EN);
> +	if (rc2)
> +		pci_err(pdev, "failed to clear CXL Reset Memory Clear: %d\n",
> +			rc2);
> +	rc = rc ?: rc2;
> +
> +	pci_dev_reset_iommu_done(pdev);
> +
> +out_enable_cache:
> +	/*
> +	 * DISABLE_CACHING was the first preparation step. Restore the original
> +	 * cache policy last, after reset exclusion has ended.
> +	 */
> +	rc2 = cxl_reset_update_ctrl2_no_replay(
> +		pdev, dvsec, 0, PCI_DVSEC_CXL_DISABLE_CACHING);
> +	if (rc2)
> +		pci_err(pdev, "failed to re-enable CXL caching: %d\n", rc2);
> +	rc = rc ?: rc2;
> +
> +	return rc;
> +}

This is pretty messy, I think it would be cleaner if you split this into several functions:

static int __cxl_reset_execute(...)
{
	int rc;

	rc = cxl_reset_disable_cache(...);
	if (rc)
		return rc;

	rc = cxl_clear_memory(...); // could be open coded, made a function for brevity
	if (!rc)
		rc = cxl_reset_wait_done(...);

	rc = rc ?: cxl_clear_memory(...); // This one doesn't have the INIT_CXL_RST flag

	pci_dev_reset_iommu_done(pdev);
	
	return rc;
}

static int cxl_reset_execute(...)
{
	int rc;

	rc = __cxl_reset_execute(..);
	if (rc)
		// log error

	return rc ?: cxl_enable_cache(...);
}

Hopefully what goes where makes sense just based on the names. I'm also not convinced you
need to preserve the original error code throughout the function since it's essentially
the same error conditions for all these functions AFAICT.

> +
> +int cxl_reset_function(struct pci_dev *pdev, bool probe)
> +{
> +	int dvsec, rc;
> +	u16 cap, ctrl;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		return -ENOTTY;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +	if (PCI_POSSIBLE_ERROR(cap))
> +		return -ENODEV;
> +	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
> +	    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
> +	    !(cap & PCI_DVSEC_CXL_RST_CAPABLE) ||
> +	    !(cap & PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE))
> +		return -ENOTTY;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL, &ctrl);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +	if (PCI_POSSIBLE_ERROR(ctrl))
> +		return -ENODEV;
> +	if (!(ctrl & PCI_DVSEC_CXL_CACHE_ENABLE) ||
> +	    !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
> +		return -ENOTTY;
> +
> +	if (probe)
> +		return 0;
> +
> +	return cxl_reset_execute(pdev, dvsec, cap);
> +}
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 4bad41e74f74..a07dbf7463c0 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -6,6 +6,7 @@
>  #define __CXL_CXL_H__
>  
>  #include <linux/device.h>
> +#include <linux/errno.h>
>  #include <linux/node.h>
>  #include <linux/ioport.h>
>  #include <linux/range.h>
> @@ -201,6 +202,7 @@ struct cxl_register_map {
>  #ifdef CONFIG_CXL_RESET
>  void pci_cxl_hdm_cache_init(struct pci_dev *pdev);
>  void pci_cxl_hdm_cache_release(struct pci_dev *pdev);
> +int cxl_reset_function(struct pci_dev *pdev, bool probe);
>  #else
>  static inline void pci_cxl_hdm_cache_init(struct pci_dev *pdev)
>  {
> @@ -209,6 +211,11 @@ static inline void pci_cxl_hdm_cache_init(struct pci_dev *pdev)
>  static inline void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
>  {
>  }
> +
> +static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
> +{
> +	return -ENOTTY;
> +}
>  #endif
>  
>  /**
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index facaa324bd86..7224857c7b30 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1352,8 +1352,22 @@
>  #define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
>  #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
>  #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
> +#define   PCI_DVSEC_CXL_CACHE_WBI_CAPABLE		_BITUL(6)
> +#define   PCI_DVSEC_CXL_RST_CAPABLE			_BITUL(7)
> +#define   PCI_DVSEC_CXL_RST_TIMEOUT			__GENMASK(10, 8)
> +#define   PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE		_BITUL(11)
>  #define  PCI_DVSEC_CXL_CTRL				0xC
> +#define   PCI_DVSEC_CXL_CACHE_ENABLE			_BITUL(0)
>  #define   PCI_DVSEC_CXL_MEM_ENABLE			_BITUL(2)
> +#define  PCI_DVSEC_CXL_CTRL2				0x10
> +#define   PCI_DVSEC_CXL_DISABLE_CACHING			_BITUL(0)
> +#define   PCI_DVSEC_CXL_INIT_CACHE_WBI			_BITUL(1)
> +#define   PCI_DVSEC_CXL_INIT_CXL_RST			_BITUL(2)
> +#define   PCI_DVSEC_CXL_RST_MEM_CLR_EN			_BITUL(3)
> +#define  PCI_DVSEC_CXL_STATUS2				0x12
> +#define   PCI_DVSEC_CXL_CACHE_INV			_BITUL(0)
> +#define   PCI_DVSEC_CXL_RST_DONE			_BITUL(1)
> +#define   PCI_DVSEC_CXL_RST_ERR				_BITUL(2)
>  #define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)		(0x18 + (i * 0x10))
>  #define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)		(0x1C + (i * 0x10))
>  #define   PCI_DVSEC_CXL_MEM_INFO_VALID			_BITUL(0)

