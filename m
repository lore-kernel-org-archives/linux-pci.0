Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013010.outbound.protection.outlook.com [40.93.201.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3833B47F5;
	Mon, 17 Aug 2026 07:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786950759; cv=fail; b=AMSpl/2MMX7xIKJJPTQl2hcFxEmThsAUAuNAqDQbYEyilUxZHe6jWbngsOrrT6nFaj0m9kaDgKBxCmJhVn8Oa46qC7sGHYWuJap7LN+5ahKa2dQ0f6FWgDX9JQBm+m6Z9D8a3JFAwbXcW50cWT6BFH31X4WRkQdKjYW3Li06xc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786950759; c=relaxed/simple;
	bh=WyxKBDNT1IYZ5fFBaPRbcQFyHjXlg33iTYxmqQF5ry8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jnZPyaLmKXosiZbOE4Cx1GBO3hVGztuJkr3Ozh1pKJKcL9Bf63EDgluqs1XGGciVJLspeevaSqU3t1vWjeaLeTCyyAkmxNYmC05ooBroGu6j7kClxTSK+7Fw/NgYLgLlWsWGP5q1xTZFXdW/MWyEQX90rUpZYNSmunXtOte/JUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xcpljals; arc=fail smtp.client-ip=40.93.201.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xcpljals"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAk40sCH9LLv6GmzaCRmQaMS9hNjp/aQ3Ko2HRa7se36W8A7QmtJgiokiJH4WxUFzQkedqCwbUGjxA2CtH5TDPkWBUdTvUDZkurDB5CTX0ZbTzB+yJnuB1iKTB6nmLXrsdELR5M69h5Y0ylHOWG1l3fqkQEcVkuGkeSqtKKxo9IhcBGTeeYaFeA6QihDteMVHojTzAgutzLSN5tl2F6EtQiem4UujRidElJpzm6kRukrQptE4nGyCrfrMTa4W6HAzXCXcgdV7DEujf4dNPJTZyKy4j5m6bvpfagu44fgGUNByP7WNa6P0cSqjsMu2WCNRsmJ2uErGCW3lwsbxzbVcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1m9Npsil3z4uUUuDxF8RiFO2JY1QSlwgC6NHlam45Q=;
 b=cXfW37Sr96thVJYJ0fpMBZ/8GMPsi91XjpE8HhSMQRboCmJjp4ivWTH91PHdy85xh9FipA99kcbA1eJpsqb73GqhdSpC423AC9tyjz7/qqzubM2bTpp+RpEYjwPtBCs67v22b6RoJ5lXxWWAHuE3ib2Xq1nlzV/UAcqedx5ms8/ywoq1y4eZytDllXWQJt4pTy+yOqz5gs0URgs2J3OJuMdOO0uaVzdOwCi3ZITtzkIiA1VOC10aiwUkLPhjsPZwdX5DvgOM/wr/hWfD/iqiaZ6bX+SnWzOrlnv+as5wza0z+WHY7cIUHnnwe2JR9cAYMuUpBGF6T4T4R9fqTBgo1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1m9Npsil3z4uUUuDxF8RiFO2JY1QSlwgC6NHlam45Q=;
 b=Xcpljalsk8/Jw7hIPBmt4cEUD6GXEjTQLbR4eW00hlShv3y1NDzHfppL/SJ9XZZYOtm8vHpt+GPKl47gm+jTcZP6XXQEaeHZqYgNa2J5oJvOU/zhvfg43X/K5m3MA4Rx3vLhZNL7n5XIhy5HQgSNvnrBffuIcG56tKX0jrPW2V1U8d2peKk/RpoP8tgDvxYkGAj3aE6xBEVgGDeixFZAOTLaMNwLKNNHSbE0YrCIz3GyC0V30CE4HfAmA/05oRlvIRBRO0WIvATXsQLAL8nxcrKkrlMBg8tsuI4mRhmCk4LDJzkH/EaQtSBnWg2mRIT9QtKtK2CtDNNQcteVTgncqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA0PR12MB8351.namprd12.prod.outlook.com (2603:10b6:208:40e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 07:12:32 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0315.014; Mon, 17 Aug 2026
 07:12:32 +0000
Date: Mon, 17 Aug 2026 15:12:28 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>, 
	Jonathan Cameron <jic23@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com, alwilliamson@nvidia.com, 
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, 
	Manish Honap <mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v10 09/12] cxl: Restore CXL HDM state after PCI reset
Message-ID: <aoKx7q0baAPJt2qP@MWDK4CY14F>
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-10-smadhavan@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804192958.1823952-10-smadhavan@nvidia.com>
X-ClientProxiedBy: TP0P295CA0037.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:4::9)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|IA0PR12MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bbbfa30-2839-423c-1193-08defc2ee7cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|10067099003|56012099006|3023799007|6133799003|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	xwz6Wg1HyMI4NNVmzlcaLH0HpSWHvvmx5qlW0r5bahOWbQjTbpeR3j23FDT5Utm/nC/klbz9s5ewoxa4cHzUipOS58RAqFxtfjh0HIvtHChseVJIdx0YSok5WY5eX+1ONQfcxtdZLdRPbpUmY1Dk8hK5giMYP7AIGhtX29p0HYl+dk4fx3b3xpJc+0nD3X88IrbRNyjh21QnQRCRAY2samN6L+08n7/uY6LFTBHdswmiZ35qNlfWoeti2USdTMcR/5vBpW+pWnvsaP6xGhlyZhmEyLI/SmHR1fag8gvHDPpjQqQx5LSlkGPOxjxpyG+tAK41v2womLhVUcV17uTWRj4lauz7kVaYUKY+vWyAUnI7ubQN+9ByZbPsaVoE/oiZpRG/EsOS4TG211Djvp0fBrsrcSMxGXC3yggChWMYMl59kuTIxpyQD8KHgbzgxwq6e0aVMHWfTN75BiJ1OyTsGGbNU1CJ1NMtg//atANMXi4+KO6wlnTluCkxRVG93TkbnDMDrn2VI3Hq5hkChilbeblzkNX0U4Y3DSMgNpeDeS4BouOPtRoVUd0E4A7cqo08we9GbgMWguwbJSGWFpj9LzVerWW9C1UT6ynS6W1Fd1rU9FrXtKe34wNdwIhZvAwTNu+wIZEj2udKsADp8Trh9yk2KvO4LVb7uRHaAtbqCFQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vyF+FZI4OlPl7K1Ovv3PrWQRwPZxb8+BT4jCYSKWdMdzNkC7hdp4HTmqXuhb?=
 =?us-ascii?Q?7WaQCWR0NC1h1DgI+XteNs36cA9QC6WLDJppTbLeBPlAQc/U8TfUnFEqIOdO?=
 =?us-ascii?Q?BhnZfwvsnF9R7KBXnhtRzL4WapTcwWr7VlG7sImNUJdqhgs/LODeFatJYjQG?=
 =?us-ascii?Q?KbRPkzrChMa5K3egZeS3Evuxn0TVe7ucvKFUtjCT+vNOhvpsfNKLR+bL4YZU?=
 =?us-ascii?Q?D7bj9MXqgnuwmJ1wl9b/PR6amyvrvgiQgiaEtxsaawgA+rtduBT5iSkiJFQ4?=
 =?us-ascii?Q?uv5MFsFjVAQ0zdYwAANyHO3gTX1kuJDbPEIRBWS7/HuWATx5EZCtLCOIXgi3?=
 =?us-ascii?Q?HbA7+/dQOHGxB7tV+PvlgLeTH1FMuAgvMPxisrcZLLHwiuT9Kow1+QXHPYfy?=
 =?us-ascii?Q?iyRjo0aEBtwuXPgvtz7d1PIRelvS7qBwSzCdCNA/Lr9ABBOWnJSBuDRXNgR7?=
 =?us-ascii?Q?n1Albwa12ecefPjKARklt8doqoV6V1+bNSvIJK0u1LXgoFzmAHMJSyioN9JO?=
 =?us-ascii?Q?KaLaOnfav2qC7jEMTBbsWvHomOE/006+LfFLVqepDkvuw427TMosz0g2m8Qh?=
 =?us-ascii?Q?ptOZQym6nAjqK3bP+22zOLmBC63wmgDij2O4cSXWaM440g/5mi72udr6j1hH?=
 =?us-ascii?Q?M/1sGD556XiOJmxJ8gSwMeKeF9KmyaFCWFk9CQj2jKWU9cZGPhwHfdwRFrIq?=
 =?us-ascii?Q?nYUuTUjHFZiutEk+EqahzpwvkaQATMjClh8ZXeJOl6voZHaH/cjqqc8FkTna?=
 =?us-ascii?Q?hepMA8570YVabnomkw38Ox6SEY9CqS6F+TXwjgcoLJMqc7Zzdz4Ry5biTl+P?=
 =?us-ascii?Q?O8xVsZHq3QDLajEz9puiwcnN5efWJl1OE2dKfJ/dLxgJDUuoyndGgmb9Fna2?=
 =?us-ascii?Q?r9Y5lJ5CPtSq6M6H0C1ok5kBFKgPzijGkoS8nQCsdhuvPMbalnM+LWDPv0bC?=
 =?us-ascii?Q?R2uWboaCLliZiwBLLHiQxtM1XIkb9smWZaeo2LbGv9N4jAuEVv/KsQAmrM8f?=
 =?us-ascii?Q?kL7JcfNcexAKRzAttIkKFYpuPfd2H+RvfPQWEdKB/BncnrRWxydRZdT8sCAm?=
 =?us-ascii?Q?UvkmkZT+xabUEGKBB5NW4K5TaKWhYdezfRqNPnbhBGuWLyh+tyGwnYgl6BgF?=
 =?us-ascii?Q?NaGYY1BxaBxz7NTY2BruLI9TiWFANxiZj0paajSikmU1FbrivRaiIaNCHaCh?=
 =?us-ascii?Q?bS/oLzOU6kh5W7U8yhJ0OO0fgCKCYcbrmWF3eaIGEAWK4Mr93wLEv1ZzMt9F?=
 =?us-ascii?Q?zHL8ilsCpD33jufEAh05OttK6MM8MhzzvgL5hLUXAJB38XNmWVM8SN2opQ/1?=
 =?us-ascii?Q?4ZQC3YbcveX+exewary0aSNrIJ+VnNVz2nX5j++XhMNxSDRYW7P5og+25N4l?=
 =?us-ascii?Q?9m0j7rpznm399PpbUv0yURqAymfeZ6GmwMKEb5a1P3tKg0dCCOwYvvNIfZmQ?=
 =?us-ascii?Q?uRhUd1jM1n85FTZ0fBCIp1DDD5RxUBqSj7pJZxPi4n2cw233XlGcI45cN4nw?=
 =?us-ascii?Q?nY5hrHv9i/KS9Yc57eqsPtiY1XwW+8VsUNVJHhKc+jrktEVLKE40z4R9NyX4?=
 =?us-ascii?Q?4q4TJGd1NbeqZ+5I3HadZ25ithp3nP26nvqD88lBsyP3/GY7zWyLINo/GkW7?=
 =?us-ascii?Q?YbJgmI0suJEq7yjPUyAcDwNKSAHY5y2GjwM9RkHsoCne/3RbGDgpYa24i5q1?=
 =?us-ascii?Q?uW7hXUgFHmRphR9C0cUFQCz7V8cETlVvfB8p47vvn/q3fB7f?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bbbfa30-2839-423c-1193-08defc2ee7cc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 07:12:32.2886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bvsXxmByqayFCGUzrrtxa7u9cn4pTd4tEaAJvedDKqatNqbgt6OAR3onV1d+nO16TiIUxbLUhQp7dWsbjvYNcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8351

On Tue, Aug 04, 2026 at 07:29:55PM +0800, Srirangan Madhavan wrote:
> After CXL reset, restore PCI config state enough to reach HDM MMIO,
> restore cached global and per-decoder HDM state, and then run the normal
> PCI restore callbacks.
> 
> Keep the target IOMMU reset block active until HDM restore completes so
> Bus Master Enable cannot reopen DMA before decoder state is valid.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/resource.c | 351 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 337 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index 464ca9bdae05..ba0a26276477 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ -12,6 +12,7 @@
>  #include <linux/kernel.h>
>  #include <linux/list.h>
>  #include <linux/memregion.h>
> +#include <linux/overflow.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
>  
> @@ -82,6 +83,26 @@ static int cxld_await_commit(void __iomem *hdm, int id)
>  	return -ETIMEDOUT;
>  }
>  
> +static int cxld_await_uncommit(void __iomem *hdm, int id)
> +{
> +	u32 ctrl;
> +	int i;
> +
> +	for (i = 0; i < COMMIT_TIMEOUT_MS; i++) {
> +		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMIT_ERROR, ctrl)) {
> +			ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
> +			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +			return -EIO;
> +		}
> +		if (!FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
> +			return 0;
> +		fsleep(1000);
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
>  static int setup_hw_decoder(struct cxl_decoder_settings *settings,
>  			    void __iomem *hdm)
>  {
> @@ -286,6 +307,31 @@ static void __iomem *cxl_pci_hdm_map(struct pci_dev *pdev,
>  	return hdm;
>  }
>  
> +static void __iomem *cxl_pci_hdm_ioremap_current(struct pci_dev *pdev,
> +						 int bar,
> +						 resource_size_t offset,
> +						 resource_size_t size)
> +{
> +	resource_size_t hdm_start, bar_len;
> +	void __iomem *hdm;
> +
> +	if (bar < 0 || bar >= PCI_STD_NUM_BARS || !size)
> +		return ERR_PTR(-EINVAL);
> +
> +	bar_len = pci_resource_len(pdev, bar);
> +	if (!bar_len || offset > bar_len || size > bar_len - offset)
> +		return ERR_PTR(-ENODEV);
> +
> +	hdm_start = pci_resource_start(pdev, bar) + offset;
> +	hdm = ioremap(hdm_start, size);
> +	if (!hdm) {
> +		pci_err(pdev, "failed to remap CXL HDM decoder registers\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	return hdm;
> +}
> +
>  static void cxl_pci_hdm_read_decoder_state(struct cxl_hdm_decoder_state *state,
>  					   void __iomem *hdm, int id)
>  {
> @@ -298,6 +344,40 @@ static void cxl_pci_hdm_read_decoder_state(struct cxl_hdm_decoder_state *state,
>  	state->target_high = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(id));
>  }
>  
> +static int cxl_hdm_enable_mem(struct pci_dev *pdev, u16 *command,
> +			      bool *restore_command)
> +{
> +	int rc;
> +
> +	*restore_command = false;
> +
> +	rc = pci_read_config_word(pdev, PCI_COMMAND, command);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	if (*command & PCI_COMMAND_MEMORY)
> +		return 0;
> +
> +	rc = pci_write_config_word(pdev, PCI_COMMAND,
> +				   *command | PCI_COMMAND_MEMORY);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	*restore_command = true;
> +	return 0;
> +}
> +
> +static int cxl_hdm_restore_command(struct pci_dev *pdev, u16 command)
> +{
> +	int rc;
> +
> +	rc = pci_write_config_word(pdev, PCI_COMMAND, command);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	return 0;
> +}
> +
>  static int cxl_pci_hdm_read_decoder(struct pci_dev *pdev,
>  				    struct cxl_hdm_decoder_state *state,
>  				    struct cxl_decoder_settings *settings,
> @@ -488,6 +568,218 @@ void pci_cxl_hdm_init(struct pci_dev *pdev)
>  		pci_dbg(pdev, "CXL HDM cache init failed: %d\n", rc);
>  }
>  
> +static int cxl_hdm_decoder_uncommit(struct pci_dev *pdev, void __iomem *hdm,
> +				    int id)
> +{
> +	u32 ctrl;
> +	int rc;
> +
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK) {
> +		if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED) {
> +			pci_dbg(pdev,
> +				"CXL HDM decoder %d retained locked committed state\n",
> +				id);
> +			return -EBUSY;
> +		}
> +
> +		pci_err(pdev, "CXL HDM decoder %d is locked and uncommitted\n",
> +			id);
> +		return -EIO;
> +	}
> +
> +	if (!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED))
> +		return 0;
> +
> +	ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
> +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +
> +	rc = cxld_await_uncommit(hdm, id);
> +	if (rc)
> +		pci_err(pdev, "CXL HDM decoder %d uncommit failed: %d\n",
> +			id, rc);
> +
> +	return rc;
> +}
> +
> +static void cxl_restore_hdm_decoder_state(struct cxl_hdm_decoder_state *state,
> +					  void __iomem *hdm, int id)
> +{
> +	u32 ctrl = state->ctrl;
> +
> +	ctrl &= ~(CXL_HDM_DECODER0_CTRL_COMMIT |
> +		  CXL_HDM_DECODER0_CTRL_COMMITTED |
> +		  CXL_HDM_DECODER0_CTRL_COMMIT_ERROR |
> +		  CXL_HDM_DECODER0_CTRL_LOCK);
> +
> +	writel(state->base_high, hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> +	writel(state->base_low, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> +	writel(state->size_high, hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
> +	writel(state->size_low, hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> +	writel(state->target_high, hdm + CXL_HDM_DECODER0_TL_HIGH(id));
> +	writel(state->target_low, hdm + CXL_HDM_DECODER0_TL_LOW(id));
> +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +}
> +
> +static int cxl_restore_hdm_decoder(struct pci_dev *pdev,
> +				   struct cxl_hdm_decoder_state *state,
> +				   struct cxl_decoder_settings *settings,
> +				   void __iomem *hdm)
> +{
> +	int rc;
> +
> +	rc = cxl_hdm_decoder_uncommit(pdev, hdm, settings->id);
> +	if (rc == -EBUSY)
> +		return 0;
> +	if (rc)
> +		return rc;
> +
> +	cxl_restore_hdm_decoder_state(state, hdm, settings->id);
> +
> +	if (!(settings->flags & CXL_DECODER_F_ENABLE))
> +		return 0;
> +
> +	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
> +		rc = cxl_commit_start(settings, hdm);
> +	if (!rc)
> +		rc = cxl_commit_wait(settings, hdm);
> +	if (rc)
> +		pci_err(pdev, "CXL HDM decoder %d restore failed: %d\n",
> +			settings->id, rc);
> +
> +	return rc;
> +}
> +
> +static struct cxl_hdm_info *cxl_snapshot_hdm(struct pci_dev *pdev)
> +{
> +	struct cxl_hdm_info *snap;
> +	struct cxl_hdm_info *info;
> +	size_t state_sz;
> +
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +
> +	info = pdev->hdm;
> +	if (!info)
> +		return NULL;
> +	if (info->decoder_count < 0 ||
> +	    info->decoder_count > CXL_HDM_DECODER_MAX_COUNT ||
> +	    (info->decoder_count && !info->decoder_state))
> +		return ERR_PTR(-EINVAL);
> +
> +	state_sz = array_size(info->decoder_count, sizeof(*info->decoder_state));
> +	snap = kzalloc(size_add(sizeof(*snap), state_sz), GFP_KERNEL);
> +	if (!snap)
> +		return ERR_PTR(-ENOMEM);
> +
> +	*snap = *info;
> +	snap->decoder_state = (void *)(snap + 1);
> +	memcpy(snap->decoder_state, info->decoder_state, state_sz);
> +
> +	return snap;
> +}
> +
> +static void cxl_restore_pci_state_for_hdm_restore(struct pci_dev *pdev,
> +						  u16 *command)
> +{
> +	u32 saved_config = pdev->saved_config_space[PCI_COMMAND / 4];
> +
> +	pdev->saved_config_space[PCI_COMMAND / 4] &= ~PCI_COMMAND_MASTER;
> +	pdev->saved_config_space[PCI_COMMAND / 4] |= PCI_COMMAND_INTX_DISABLE;
> +	pci_restore_state(pdev);
> +	pdev->saved_config_space[PCI_COMMAND / 4] = saved_config;
> +	*command = saved_config & 0xffff;
> +}
> +
> +static int cxl_restore_hdm(struct pci_dev *pdev)
> +{
> +	struct cxl_hdm_info *snap = cxl_snapshot_hdm(pdev);
> +	bool restore_command = false;
> +	void __iomem *hdm;
> +	int first_rc = 0;
> +	u16 command;
> +	int rc;
> +
> +	if (!snap)
> +		return 0;
> +	if (IS_ERR(snap))
> +		return PTR_ERR(snap);
> +
> +	rc = cxl_hdm_enable_mem(pdev, &command, &restore_command);
> +	if (rc) {
> +		kfree(snap);
> +		return rc;
> +	}
> +
> +	hdm = cxl_pci_hdm_ioremap_current(pdev, snap->hdm_bar,
> +					  snap->hdm_offset, snap->hdm_size);
> +	if (IS_ERR(hdm)) {
> +		first_rc = PTR_ERR(hdm);
> +	} else {
> +		/*
> +		 * Restore global HDM control before per-decoder commit. PCI
> +		 * config memory decoding is enabled for MMIO access, but bus
> +		 * mastering remains disabled until HDM restore completes.
> +		 */
> +		writel(snap->global_ctrl, hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +
> +		for (int i = 0; i < snap->decoder_count; i++) {
> +			rc = cxl_restore_hdm_decoder(pdev,
> +						     &snap->decoder_state[i],
> +						     &snap->settings[i], hdm);
> +			if (rc && !first_rc)
> +				first_rc = rc;
> +		}
> +
> +		iounmap(hdm);
> +	}
> +
> +	if (restore_command) {
> +		rc = cxl_hdm_restore_command(pdev, command);
> +		if (rc && !first_rc)
> +			first_rc = rc;
> +	}
> +
> +	kfree(snap);
> +	return first_rc;
> +}
> +
> +static void cxl_reset_save_disabled_state(struct pci_dev *pdev)
> +{
> +	int rc;
> +
> +	rc = pci_write_config_word(pdev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
> +	if (rc) {
> +		pci_warn(pdev, "failed to keep device disabled after CXL reset restore failure: %d\n",
> +			 pcibios_err_to_errno(rc));
> +		return;
> +	}
> +
> +	rc = pci_save_state(pdev);
> +	if (rc)
> +		pci_warn(pdev, "failed to save disabled state after CXL reset restore failure: %d\n",
> +			 rc);
> +}
> +
> +static int cxl_reset_save_restored_state(struct pci_dev *pdev, u16 command)
> +{
> +	int rc;
> +
> +	rc = cxl_hdm_restore_command(pdev, command);
> +	if (rc) {
> +		cxl_reset_save_disabled_state(pdev);
> +		return rc;
> +	}
> +
> +	rc = pci_save_state(pdev);
> +	if (rc) {
> +		pci_warn(pdev, "failed to save restored state after CXL reset: %d\n",
> +			 rc);
> +		cxl_reset_save_disabled_state(pdev);
> +	}
> +
> +	return rc;
> +}
> +
>  /*
>   * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
>   * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
> @@ -514,6 +806,34 @@ struct cxl_hdm_range_context {
>  	struct list_head ranges;
>  };
>  
> +static void cxl_pci_target_reset_done(struct pci_dev *pdev,
> +				      bool *target_prepared)
> +{
> +	if (!*target_prepared)
> +		return;
> +
> +	pci_dev_reset_iommu_done(pdev);
> +	*target_prepared = false;
> +}
> +
> +static int cxl_pci_target_reset_prepare(struct pci_dev *pdev,
> +					bool *target_prepared)
> +{
> +	int rc;
> +
> +	if (!pci_wait_for_pending_transaction(pdev))
> +		pci_err(pdev, "timed out waiting for pending transactions\n");
> +
> +	rc = pci_dev_reset_iommu_prepare(pdev);
> +	if (rc) {
> +		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
> +		return rc;
> +	}
> +
> +	*target_prepared = true;
> +	return 0;
> +}
> +
>  static void cxl_hdm_range_context_init(struct cxl_hdm_range_context *ctx)
>  {
>  	INIT_LIST_HEAD(&ctx->ranges);
> @@ -934,24 +1254,16 @@ static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
>  	} while (true);
>  }
>  
> -static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
> +static int cxl_reset_execute(struct pci_dev *pdev, bool *target_prepared,
> +			     int dvsec, u16 cap)
>  {
> -	bool target_prepared = false;
>  	int rc, rc2;
>  
>  	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
>  	if (rc)
>  		return rc;
>  
> -	if (!pci_wait_for_pending_transaction(pdev))
> -		pci_err(pdev, "timed out waiting for pending transactions\n");
> -
> -	rc = pci_dev_reset_iommu_prepare(pdev);
> -	if (rc)
> -		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
> -	else
> -		target_prepared = true;
> -
> +	rc = cxl_pci_target_reset_prepare(pdev, target_prepared);
>  	if (!rc)
>  		rc = cxl_reset_initiate(pdev, dvsec);
>  	if (!rc)
> @@ -963,14 +1275,13 @@ static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
>  	else if (rc2)
>  		rc = rc2;
>  
> -	if (target_prepared)
> -		pci_dev_reset_iommu_done(pdev);
>  	return rc;
>  }
>  
>  int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  {
>  	struct cxl_hdm_range_context range_ctx;
> +	bool target_prepared = false;
>  	int dvsec;
>  	int rc;
>  	u16 cap;
> @@ -993,9 +1304,21 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  	scoped_guard(rwsem_write, &cxl_rwsem.region) {
>  		rc = cxl_hdm_ranges_prepare(&range_ctx, pdev);
>  		if (!rc)
> -			rc = cxl_reset_execute(pdev, dvsec, cap);
> +			rc = cxl_reset_execute(pdev, &target_prepared, dvsec, cap);
> +		if (!rc) {
> +			u16 command;
> +
> +			cxl_restore_pci_state_for_hdm_restore(pdev, &command);
> +			rc = cxl_restore_hdm(pdev);
> +			if (rc)
> +				cxl_reset_save_disabled_state(pdev);
> +			else
> +				rc = cxl_reset_save_restored_state(pdev,
> +								  command);
> +		}

Hi Srirangan,

I don't fully get this part. Once cxl_reset_initiate() succeeds, cxl_reset_execute()
can still return an erro from cxl_reset_wait_done() or from re-enabling CXL
caching.

It that case the above condition will skip PCI/HDM restoration.

However, cxl_pci_target_reset_done() is still called later, and the generic
PCI reset path subsequently calls pci_dev_restore() regardless of the reset-method
return value.

If the reset actually occurred but completion polling timeout, or if the
post-reset cache-enable operation failed, couldn't this restore the IOMMU and
PCI command state while the HDM decoder state remains cleared or otherwise
unknown ?

I am thinking maybe this path need to track whether CXL Reset was succesfully
initiated and then maybe save a disabled PCI state so the generic PCI restore
path can't reactivate the device ?

Btw, one small question, I'm unclear about the ownership expectation for
FW-programmed EP decoders. If a decoder was programmed and locked by FW, and
CXL Reset clears that state, is the generic PCI layer expected to replay the
cached configuration, or should FW or the owning device driver restore it ?

In particular, cxl_restore_hdm_decoder_state() removes the LOCK bit before
replaying the decoder state. Is it guaranteed that FW-owned locked decoders
retain their committed state across this reset, so this reply path is never
used for them ?

Best regards,
Richard Cheng.

>  		cxl_hdm_range_context_destroy(&range_ctx);
>  	}
>  
> +	cxl_pci_target_reset_done(pdev, &target_prepared);
>  	return rc;
>  }
> -- 
> 2.43.0
> 
