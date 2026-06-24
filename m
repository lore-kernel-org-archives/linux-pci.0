Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013020.outbound.protection.outlook.com [40.107.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B05D7080D;
	Wed, 24 Jun 2026 14:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782312938; cv=fail; b=RwUJYemmwRZxuFhlw6mTnKYTY4pVwY4JtlHy5yowVrs5W3YhVGVP7LPZQIOFX5fuLelE5MRVFBZ6610E829meL8ERHjLZUhATk4cVEIR9PeZ/jxG6kHEpEFs/Z4VaRa/rDhBG45CknBh/Mnxt0YoVyk36S+H6uVoiK+nViEPsk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782312938; c=relaxed/simple;
	bh=qnZjNypS22Li0Nc0zrI74kuHAD34kEAdfp4ZFzaTni0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Lrx60dUngIPMUtK1Wri5+sBrhaLT6rrIPunemf023EDqkxlku9bC0KSOvA5wtsMpG++2BdRbEsSAX9i183tXTEWeweaUM8PkWZMQlzRWDCbmU/SkbWHR8lCZ6QG8uUY30DzSjPavXY+8oRq9PTAtv5N9c+yFKheIeUXxzxg87pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nnYT2Yij; arc=fail smtp.client-ip=40.107.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nnYT2Yij"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4++VMBwp/Tas5mAeayVyS0yp1Tfrn/QsJE/NPgAxx6MBT0QYUfjN+uEJB4BqeCJJNqIDccX9+Mp8tI2v5JUEuV18tP35hC8RBL1B7gy0z7gUoWsPAmioTjjuTWqSH97cxUJM52NuP7jMaX05/573fc0kT6uLN8vJt/ahFxfMn9KZsDSMpPKDnYDcZaOBegDBEZCAajIx/sE7WLeCVZKjTFX90BpdG0ygI7ID0wEbPQ67GQmW+ZvGhphG8iyF0yUx7P9nXS8H9YCuSBLOfj0SOXyxCvb4+uvh11pgr/EQuUydc1ZZV34NGClPEjQodiZdXK6ZvDjsz4xlHu2DWdk0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12pTgMBmY4OuJ8vVRk2V0WAB7J6f8qGCSE/wDUcQi8U=;
 b=hQN066ju+9Iy6AsN92vyCKUflYPl2veyT+lfOP/pcf9zKcQ5pa6yHZbIL9nSC44TbGoaDu08Q47wjeKUq+86CPmE9Q6TAw4U0/bazrPoBO7qll3TbdXx5MIVveVlfw+hwF98UJfRRenjHv0PAFbyzOvgi6tA0U4T9n9x9nY/+2tLjrOcGM4Jj6ahBmusUUSJOvgU/XtGYL3KWStr2RNj8LAuMtdkCtSRs1W18g3mAh5Qx49mBGnCGpmpkYK+nKSoXohouUstTTexwzj9IOA3G5W/53MDdWNAWZimtYsqG4g6zrBCctFSRQqVft6ikUAKuKl/PLXyNC5uHP+kdLYUWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12pTgMBmY4OuJ8vVRk2V0WAB7J6f8qGCSE/wDUcQi8U=;
 b=nnYT2YijiHqyo6ediEx4dqnP2u96lKAyw0/x122wxIja1/Bw9JhmVsZlhDySUhNnNtaUKEJfZViSdiV+wfbsEjWxWaC0RaFoDbWMMt9WIvIJ+BhwDSHZBsFZucja41Olum3RrWjqEqPkJ/jbJbR+EXtT2PIiQoeSdUeiE9OPoVRcEu+13+ryOrtHiJTNzwicHDHU27VafeMkokTb2d6LQKy90Iw0TxpXz88Kj/L/jCcWnVl5t/zlG93Wf9IQqfpATwP2WH63lsZX3ph389zBSbCWQ9E54TpNAsWv714JD9jSyAiD7xtP8BwLIAPwqGuKgo7M3L2CGmhsC2IATsSL+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW2PR12MB2380.namprd12.prod.outlook.com (2603:10b6:907:4::32)
 by CYYPR12MB9016.namprd12.prod.outlook.com (2603:10b6:930:c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 14:55:32 +0000
Received: from MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5]) by MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5%6]) with mapi id 15.21.0159.013; Wed, 24 Jun 2026
 14:55:31 +0000
Date: Wed, 24 Jun 2026 22:55:24 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>, 
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, vsethi@nvidia.com, alwilliamson@nvidia.com, 
	Dan Williams <danwilliams@nvidia.com>, Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, 
	Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, 
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v7 09/11] cxl: Restore CXL HDM state after PCI reset
Message-ID: <ajvvSYu1uVtDY1qe@MWDK4CY14F>
References: <20260623032453.3404772-1-smadhavan@nvidia.com>
 <20260623032453.3404772-10-smadhavan@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623032453.3404772-10-smadhavan@nvidia.com>
X-ClientProxiedBy: KUZPR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:d10:30::10) To MW2PR12MB2380.namprd12.prod.outlook.com
 (2603:10b6:907:4::32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2380:EE_|CYYPR12MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: 30a6e058-815b-4654-a271-08ded200a265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|18002099003|22082099003|56012099006|4143699003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	/WDGBOX2cz70AOxYnjNy6n1pvSYwLXj4un2PMq9zAFoNvPRQ22bRCa4ZhC3ws5Eg0OeBq9BAiiHPRbbk0aEgd7C66tzqCiDvwERcwBSCXL0LcSWLOnb0ljohkeBZVkgMsUX0lT41ExSPhhM+NOSYKNE6mTdpnrWe0qTfk1phQ+pDg52dtMNqQLXBOvB1Mr+BpqdN8ik/d+4n6z9LeVckTA7wEQYa8wNb5agcXNm1/nQ93bD72dDttrgbKUPinMX5RWT5wxB0ax3d7U/MU0+fHAcNvK4PonZF/I3aOwj26AagY+aImtrTCrP24+u9WlxJabRESzWVwb3/nGIomJRYZMnmRy2ty4jhw7s3h2iga30Lju/rj+mhRfVq2AeKXjK/b/tBOZm2M1ZXB2sjeyc0TvWcjr1gC/KOr69Wo2pAfRvVlyDvH12p5VHBcYa36s1PeQmG9YlV+szDRsC9S7D050w7tpMlktAT+1anQ29sgJ31tbw4UBoekz9wsR5iZ/Sb9dY9oqUUDgKhqMSW770M57KY90ie35Ija732gibjtqBIZJ0w7ycLhnd6G1HCF/11CAeCIaNkf7QvcJ1YqWM06Ve2TNQ3+4+TgYXliIPB1JQLPxxQIN1YpH9Mo1P0/rTvNpVnfURqSiykEFiZ598OUDWKewxlmENuKd+Ll72E6U4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(4143699003)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?se5Dw5U/PRMiV9n3Hdf1UGlOiYJQdfezIQ6t+3PmGsP1YcUn7zSH5ZP2ispd?=
 =?us-ascii?Q?xcP2dRweeodfKnkdD0LxKVUg4yEETPqL/Y5lUkI6YHZFl2ZFEfeEz0AWKYeG?=
 =?us-ascii?Q?1Kvj2/kCw5GJ7UkYqAyOcx1Kxhok72sD6VdJ1ObGxmXuVIRyqQuk5+9jZ4cT?=
 =?us-ascii?Q?MBKsQRYATXrpy/bmFiq2vfZ92QW3C41V2IyPfuCM1P8PPP3PyGPEwQzCx0sS?=
 =?us-ascii?Q?9eGq28UiUbioyacAE2gI9Q6xY6GyXQwmjOZtFpCWJUB9ak2DJJaImWZBphYG?=
 =?us-ascii?Q?XoaDn57v4DR8/CQlHZE3+W4Dwq4VSF6MSIIZhmOWxx3/HzNjLPeK3l5rQZBq?=
 =?us-ascii?Q?VxbRPVQTCYf47dhGwlYCAC7Vhg59lZEU3VnJe5Lo/9DBm2XDsvIs0MKH6eKg?=
 =?us-ascii?Q?XPy/BMesgFOkGOul36Kt262EIxbQR9SNJoLGVG6riYBNJ1i/+o3Meo3apTEc?=
 =?us-ascii?Q?SyEhhuK0TORIAIlw+/Lk4xmjh72GBC/xvh8Rl4YW/r7NNMlxvrIi+FOhX70b?=
 =?us-ascii?Q?7QI3mmfgxbH9EfmEub5Zl1eqk1tzua5xDuOUcBHN+w/qbwuzn/834u84V6A/?=
 =?us-ascii?Q?16B6zaeVPT2oF/f/qAioP0RJEanZOfeVFm/rLKfUgjzF8hu/ZAL9yGUBzIC1?=
 =?us-ascii?Q?hgSPpwfnJ+g3RrfFGr5yDi3srUENsnINJpuHGrk8rFs/1HkFHN3BtzAm7/Wf?=
 =?us-ascii?Q?XEdOqWaFp7r4NO9KoQqaWrS+heRqzOHDzwlUWZC4kvT8M4v/PcpzASdPHLsR?=
 =?us-ascii?Q?92W/PmKmT75g+qdxr61pjfo2QRHUfw+tqb/AP19b0bZvpFS9BxfXUilpm/XN?=
 =?us-ascii?Q?wtsjn8FQI7G1kJZy3ClA7txWlJk7/zFLXtSdH9Heko1H+HVsqE0Fx1fWE8ls?=
 =?us-ascii?Q?6eIKuKXImKq6ylGZ0ttRUmQyLSC7j/Tsz/8VlS2BD7/kcsIIs79S7ATd5cMU?=
 =?us-ascii?Q?fNN8BPVgt0LE3JiuUxwJzZji1R6jf6fz5ZUtfwZ3TFTkquOODnYrI/y4DEi2?=
 =?us-ascii?Q?FXiVOIC7ITHqML/6eyFl7sHwp2/V/50tqXHbOVvXhJLDjaSsNrlWS0CFCITJ?=
 =?us-ascii?Q?pxfOoCIXX7LgWvBXWnZDPfERm/YGd74dkt0eB/7DigyjMv8i2bAcpTHsbv5X?=
 =?us-ascii?Q?zMUi4GzhLJE0m+btyqEKSPKPCxVMBm8zDdqfW9RpF3ghknY1GWHJqW/TzuFL?=
 =?us-ascii?Q?TWC+Jwi+fiU0+VUOo0DQEHBbDfcm+b47MDbbOF6QaS9BWRsrOAewbn2UCH7j?=
 =?us-ascii?Q?TrwGeVDdEITGJckKUUFp15rhAw0u2tYOCvg7zm+29w2Tocl33+nEO6JFSUKX?=
 =?us-ascii?Q?VldFaUPLXRZkYIWkzGmzb+Zz4eN5S+vuLRJczm9+NU9VlY47IdpuoRZxsWGt?=
 =?us-ascii?Q?/NuFZGD+R87mT3C813jRCZVQpH0ihCGJAzWf0AuOUwp1yn+DCH/UY+YusGFA?=
 =?us-ascii?Q?mNgUhJRcvH08BQVabb3Ln+wkcWT/9vWEMh844hz1S/ot3L8hoVx3rJzVQKZi?=
 =?us-ascii?Q?+x2q65TE36UazVNy/2oNa6dpthNMZhZM85mOYy+6j+tvhmx1SvDI2bnsRFLo?=
 =?us-ascii?Q?1lxyihXeo4sTt9zqacqxZpyZLDatF+57vpkos2NDdi0oxD5X8N9CW9N6veJr?=
 =?us-ascii?Q?WALVn7j3mKa8uk7oY/G2T7piXxGY5QcnuIqdr3Nsi1F9LBQesZTZwa380b/+?=
 =?us-ascii?Q?QxCZKrjCNeAYm9DEQ+nCLzKBHhIgMzEQ0FE6bouMeyv0FCOQ41fiTC7HXiCH?=
 =?us-ascii?Q?OE4sEO/e2g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a6e058-815b-4654-a271-08ded200a265
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 14:55:31.2708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfJdWntfdusKBe4hDh0OxJ5/73EJG/tKuJa/EXKNkKKP9PBIvHjF5/XcnCDGGJ3hzHA/Ol9LPlCHD0fG+8G6SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9016

On Tue, Jun 23, 2026 at 03:24:51AM +0800, Srirangan Madhavan wrote:
> After CXL reset, restore PCI config state enough to reach HDM MMIO,
> restore cached global and per-decoder HDM state, and then run the normal
> PCI restore callbacks.
> 
> Keep target and sibling IOMMU reset blocks active until HDM restore
> completes so Bus Master Enable cannot reopen DMA before decoder state is
> valid.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/hdm.c   |   4 +
>  drivers/cxl/core/reset.c | 195 ++++++++++++++++++++++++++++++++++++---
>  include/cxl/cxl.h        |   2 +
>  3 files changed, 190 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0230ebfada42..095cc13e5d00 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -152,6 +152,10 @@ static void cxl_hdm_info_set_decoder(struct cxl_hdm *cxlhdm,
>  	if (!info || cxld->id >= info->decoder_count)
>  		return;
>  
> +	if (cxlhdm->regs.hdm_decoder)
> +		info->global_ctrl = readl(cxlhdm->regs.hdm_decoder +
> +					  CXL_HDM_DECODER_CTRL_OFFSET);
> +
>  	if (cxld->flags & CXL_DECODER_F_ENABLE)
>  		info->settings[cxld->id] = cxld->settings;
>  	else
> diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
> index 69bcfab89858..d801c91a5cbf 100644
> --- a/drivers/cxl/core/reset.c
> +++ b/drivers/cxl/core/reset.c
> @@ -83,6 +83,21 @@ static int cxld_await_commit(void __iomem *hdm, int id)
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
> +		if (!FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
> +			return 0;
> +		fsleep(1000);
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
>  static void setup_hw_decoder(struct cxl_decoder_settings *settings,
>  			     void __iomem *hdm)
>  {
> @@ -92,6 +107,8 @@ static void setup_hw_decoder(struct cxl_decoder_settings *settings,
>  	u32 ctrl;
>  
>  	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	ctrl &= ~(CXL_HDM_DECODER0_CTRL_COMMIT |
> +		  CXL_HDM_DECODER0_CTRL_COMMIT_ERROR);
>  	cxld_set_interleave(settings, &ctrl);
>  	cxld_set_type(settings, &ctrl);
>  	base = settings->hpa_range.start;
> @@ -300,6 +317,8 @@ int pci_cxl_hdm_init(struct pci_dev *pdev)
>  
>  	info->decoder_count = decoder_count;
>  	info->regs = regs;
> +	info->global_ctrl = readl(regs.hdm_decoder +
> +				  CXL_HDM_DECODER_CTRL_OFFSET);
>  
>  	settings = info->settings;
>  	for (int i = 0; i < info->decoder_count; i++) {
> @@ -324,6 +343,100 @@ int pci_cxl_hdm_init(struct pci_dev *pdev)
>  	return rc;
>  }
>  
> +static int cxl_hdm_decoder_uncommit(struct pci_dev *pdev, void __iomem *hdm,
> +				    int id, bool *locked_committed)
> +{
> +	u32 ctrl;
> +	int rc;
> +
> +	*locked_committed = false;
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK) {
> +		if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED) {
> +			pci_dbg(pdev,
> +				"CXL HDM decoder %d retained locked committed state\n",
> +				id);
> +			*locked_committed = true;
> +			return 0;
> +		}
> +
> +		pci_err(pdev, "CXL HDM decoder %d is locked\n", id);
> +		return -EBUSY;
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
> +static int cxl_restore_hdm_decoder(struct pci_dev *pdev,
> +				   struct cxl_decoder_settings *settings,
> +				   void __iomem *hdm)
> +{
> +	bool locked_committed;
> +	int rc;
> +
> +	if (!(settings->flags & CXL_DECODER_F_ENABLE))
> +		return 0;
> +
> +	rc = cxl_hdm_decoder_uncommit(pdev, hdm, settings->id,
> +				      &locked_committed);
> +	if (rc)
> +		return rc;
> +	if (locked_committed)
> +		return 0;
> +
> +	rc = cxl_commit(settings, hdm);
> +	if (rc)
> +		pci_err(pdev, "CXL HDM decoder %d restore failed: %d\n",
> +			settings->id, rc);
> +
> +	return rc;
> +}
> +
> +static int cxl_restore_hdm(struct pci_dev *pdev)
> +{
> +	struct cxl_hdm_info *info = READ_ONCE(pdev->hdm);
> +	void __iomem *hdm;
> +	int first_rc = 0;
> +
> +	if (!info)
> +		return 0;
> +
> +	hdm = info->regs.hdm_decoder;
> +	if (!hdm) {
> +		pci_err(pdev, "CXL HDM decoder registers unavailable\n");
> +		return -ENXIO;
> +	}
> +
> +	/*
> +	 * Restore global HDM control before per-decoder commit. PCI config
> +	 * state has been restored for MMIO access, but IOMMU reset blocks
> +	 * remain active until HDM restore completes.
> +	 */
> +	writel(info->global_ctrl, hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +
> +	for (int i = 0; i < info->decoder_count; i++) {
> +		struct cxl_decoder_settings *settings = &info->settings[i];
> +		int rc;
> +
> +		rc = cxl_restore_hdm_decoder(pdev, settings, hdm);
> +		if (rc && !first_rc)
> +			first_rc = rc;
> +	}
> +
> +	return first_rc;
> +}
> +
>  /*
>   * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
>   * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
> @@ -355,6 +468,7 @@ struct cxl_reset_context {
>  	int nr_siblings;
>  	int nr_siblings_locked;
>  	int nr_siblings_prepared;
> +	bool target_prepared;
>  	int sibling_capacity;
>  };
>  
> @@ -609,6 +723,68 @@ static int cxl_pci_functions_reset_prepare(struct cxl_reset_context *ctx)
>  	return 0;
>  }
>  
> +static void cxl_pci_target_reset_done(struct cxl_reset_context *ctx)
> +{
> +	if (!ctx->target_prepared)
> +		return;
> +
> +	pci_dev_reset_iommu_done(ctx->target);
> +	ctx->target_prepared = false;
> +}
> +
> +static int cxl_pci_target_reset_prepare(struct cxl_reset_context *ctx)
> +{
> +	struct pci_dev *pdev = ctx->target;
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
> +	ctx->target_prepared = true;
> +	return 0;
> +}
> +
> +static void cxl_pci_functions_restore_state(struct cxl_reset_context *ctx)
> +{
> +	/*
> +	 * Restore PCI config state first so HDM MMIO is reachable. The final
> +	 * pci_dev_restore() pass deliberately replays pci_restore_state()
> +	 * before invoking driver reset_done() callbacks.
> +	 */
> +	pci_restore_state(ctx->target);
> +
> +	for (int i = 0; i < ctx->nr_siblings_prepared; i++)
> +		pci_restore_state(ctx->siblings[i].pdev);
> +}
> +
> +static int cxl_restore_hdm_decoders(struct cxl_reset_context *ctx)
> +{
> +	int first_rc = 0;
> +	int rc;
> +
> +	cxl_pci_functions_restore_state(ctx);
> +
> +	rc = cxl_restore_hdm(ctx->target);
> +	if (rc && !first_rc)
> +		first_rc = rc;
> +
> +	for (int i = 0; i < ctx->nr_siblings_prepared; i++) {
> +		struct pci_dev *sibling = ctx->siblings[i].pdev;
> +
> +		rc = cxl_restore_hdm(sibling);
> +		if (rc && !first_rc)
> +			first_rc = rc;
> +	}
> +
> +	return first_rc;
> +}
> +
>  static void cxl_hdm_range_context_init(struct cxl_hdm_range_context *ctx)
>  {
>  	INIT_LIST_HEAD(&ctx->ranges);
> @@ -985,18 +1161,9 @@ static int cxl_reset_execute(struct pci_dev *pdev, int dvsec)
>  	if (rc)
>  		return pcibios_err_to_errno(rc);
>  
> -	if (!pci_wait_for_pending_transaction(pdev))
> -		pci_err(pdev, "timed out waiting for pending transactions\n");
> -
> -	rc = pci_dev_reset_iommu_prepare(pdev);
> -	if (rc) {
> -		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
> -		return rc;
> -	}
> -
>  	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
>  	if (rc)
> -		goto out;
> +		return rc;
>  	cache_disabled = true;
>  
>  	rc = cxl_reset_update_ctrl2(pdev, dvsec, PCI_DVSEC_CXL_INIT_CXL_RST,
> @@ -1020,7 +1187,6 @@ static int cxl_reset_execute(struct pci_dev *pdev, int dvsec)
>  			rc = rc2;
>  	}
>  
> -	pci_dev_reset_iommu_done(pdev);
>  	return rc;
>  }
>  
> @@ -1053,12 +1219,19 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  	if (rc)
>  		goto out_functions_done;
>  
> +	rc = cxl_pci_target_reset_prepare(&ctx);
> +	if (rc)
> +		goto out_functions_done;
> +
>  	scoped_guard(rwsem_write, &cxl_rwsem.region) {
>  		rc = cxl_hdm_ranges_prepare(&range_ctx, &ctx);
>  		if (!rc)
>  			rc = cxl_reset_execute(pdev, dvsec);
> +		if (!rc)
> +			rc = cxl_restore_hdm_decoders(&ctx);
>  	}
> 

HDM restore only runs when cxl_reset_execute() returns 0. Combine with
the wait_done false -EIO at patch 5, the reset succeeds in HW but execute
returns -EIO, so restore is skipped entirely.

Maybe we should detect an unreachable device (all-ones config) and chain a
link-level recovery instead of leaving it wedged.

--Richard

 
> +	cxl_pci_target_reset_done(&ctx);
>  out_functions_done:
>  	cxl_pci_functions_reset_done(&ctx);
>  out_unlock:
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 1fe606f15733..eddc48f1fa49 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -127,11 +127,13 @@ struct cxl_regs {
>   * struct cxl_hdm_info - PCI device HDM decoder programming cache
>   * @decoder_count: number of decoder settings entries
>   * @regs: mapped CXL component registers for this HDM decoder block
> + * @global_ctrl: cached HDM decoder global control register
>   * @settings: cached per-decoder programming state
>   */
>  struct cxl_hdm_info {
>  	int decoder_count;
>  	struct cxl_component_regs regs;
> +	u32 global_ctrl;
>  	struct cxl_decoder_settings settings[] __counted_by(decoder_count);
>  };
>  
> -- 
> 2.43.0
> 
