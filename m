Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011007.outbound.protection.outlook.com [40.107.130.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C793A39A075;
	Thu, 14 May 2026 19:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778785574; cv=fail; b=j0CcPTixsET2Lt3pLvH0fg7yEHkevJTR9QJU5CaYsr2vfMN827lyq3DdVU5jXSzqYMQASgxx6N9wrroVbIAo1ub6zD5mKo8fDzclMr9i+uND/gumuW3mizP606VHuYLOn0oQ5d17uHYwwizY7Pfr21wo/DOB83aSh21xPvVB2HE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778785574; c=relaxed/simple;
	bh=xTcNXhuMs11ceCq9v3Q0rSlKVmmeAy6DglUrtSifXsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VwXRcK/CbWPV6fvQ/9Q+V2lrhvwPBdk0awcWi5LUiCsZOS0/QkeLtEERGdsVR3MMZgtNYkZLLzPJIvpVnNzK8ROerQFjTosJdaayrNEaqv7nsfjHH1vsv/teVBpd7gGKT1efIezHG8HZOIs4JLbpiYQCIXyqHBA5I/G/r6F6v7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DHaONwDH; arc=fail smtp.client-ip=40.107.130.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DHaONwDH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXAIts2iAu1fqJf4ze0kTK8c174VAo63UkJMdopmTD6QM723fqFL5WRyv5wk40VbcIJX8N/zQYWSbsUkThPqbWIzROFaH0mj1td7Jbb8c7Npmg5qfbyrgW9+Y37pk6es2FSexYeb7g4xPky/siqm40KjnEOoE/zDHkQzGyDATdkTC66U+LS2Dm/PgsXBFpWs1Ct+gcyCuPeUTa1QI+JiwkvFCPYOtof9Zb6gcsgGVt1xLlLAYdRawlkZXoIWFITsSuPv1VPYaLxjP6V6j+/sk1THgfSFQF72upUMTW5kVsZ4c1JMYPRUU7aGxFLryt+a26jlWw8ptGmHjjzHapfsoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xO1L9Nd9TgrKl/Wd1ejjRCOg88WOpYMiTu4lhs68CU=;
 b=WGCwoNNCnLnkM1OrXeEp4oIFrzJb7yQkrEYZtMiMqy4L9/t7xtMqI6KKZHMvRAOeMzE/R0cqKFEJ4OSIWzRs/EM+FiTex8x8g5t40N6YQCbXWv52u/O01jsLEWay5qzsml+d8jICfFsErla8H+PikXQKgP52Rga4iXL2J8CwskOF68igsxm0DdXqLP++GqFIggKCVCxwH2R/WWoxuxkgmkX5j8I0DJ3hFs8avLRqkPE9FYk/sj4Wdi3URlJcoR+kgPznjrnfBE48LTufDcGkB5RU43ZkngdxszFPgoTp2P44GgjYHdc6Nn/ePrWuKBFE1DeCIsydjKmgKLnohmvqow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xO1L9Nd9TgrKl/Wd1ejjRCOg88WOpYMiTu4lhs68CU=;
 b=DHaONwDHiz6lx5a+Fm18RT/Pxaneyv/zH5gObVZJV0ArKgKXGTaAAZdAvBmB4azJoR34Cjwl25BrKst5s9x4kbIctI1fybfCVsBM+OO0CrRYtrQMcAK7nZTK+SyWByeBMfjzErAguZV5O1Me38h7WMVfk6Bycbu36s3L0ok3h+v6n6vYcE1WOBZgbpIH5GBe+bNDW1esHfFGhrm4xgJuuVZqnaT/hfFUt1zYD5HDP9LBP+CxpXW0gTasy/WBx6QsEbxNxzsR93W0rqHuga16YV8MTWOlOs+mE4dRyqHcQLu/8ACutG0wcU8vYLOcWlFQOcWfFNF0WfTAOKRNrQjU2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM7PR04MB6806.eurprd04.prod.outlook.com (2603:10a6:20b:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 14 May
 2026 19:06:09 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 19:06:09 +0000
Date: Thu, 14 May 2026 15:06:01 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v4 11/12] NTB: epf: Fix doorbell bitmask and IRQ vector
 handling
Message-ID: <agYdGUws0GNxfyRW@lizhi-Precision-Tower-5810>
References: <20260513024923.451765-1-den@valinux.co.jp>
 <20260513024923.451765-12-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513024923.451765-12-den@valinux.co.jp>
X-ClientProxiedBy: PH8P220CA0044.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:2d9::11) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM7PR04MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c98428f-219c-4887-ca34-08deb1ebdb72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|52116014|376014|38350700014|4143699003|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	EFNa9uSE4vkX257ZUFVwWSOFI8r/buvZrKMDuvif0THhdTFXlV8KAXYGMaoybAwfOyDnyoHPqqesRf/jxV0lTZmzRL2XSLRybVZGKyg4Oyp7ZHn+LwDCkaWwcOEYewulKfT7OJ64/YytsgVyVyLa99Vlew78ICQDbJLmCsZwBA1WWKGelnDm/yvJORxBFWLLRFo0Mztwn620Bhjg7yp9bEKJ/NLyFPK7zEmwNEhyieb5okdKDy4nfMGpMHaWkDBKPPSG3d3UgTVB2YjWzxnfMdlWpBuvgTy7XMdx/+O1OLlghWSH6tWA+NZSUNQii5dZVFsMLAZn5pMae2U3T52YbZF1fDGZnu6M47lgTgLV4aLtMJygrzRnRhfssr8C769qSRVLP0EXGYsc3wl5WqKt+lWIwlQ5bYuYBx7mZshBWWU9rFYLeC+eilDg/zMstV1WGE5230/gOzDa3TbHSVmMs8EcBMuCwq2VWU+k6fwvku8t6HpnrU2DNONpeS8WpgtLlKjnc6WWIN62TU2ReXQ95W/BRKpN+p4oRq7YsbRZRM56C1z4t8qRAeT8w29rMfeS4166qfkCLGMaR/eQe9irOAQ1/N0UAPrXLA+gJKTUOAtwzeDM9jaiHzFJPv1cvJ2XpfrOX348VQsPKjI768qCBXe+fU+rqdS0kH1f+PNH7xtLfKr3sBooskOi5zT1wj9QEUgTU3+IXvbbs5TNjYKdcAIg47weXZ27fsaZiHlfCd7bejonJrlCk2RLpkX2mUyP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(52116014)(376014)(38350700014)(4143699003)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?blLTOOPXmm+YabebzatJdjFAiY5dPKP810znXDYU3Cu2TQxg9aAKmEqudjG6?=
 =?us-ascii?Q?1D4zMRIw0QVCmu9OBVRUs7DtnPeXWnH8EjYNrcdH+xfgMs2w6e7hrLasff9W?=
 =?us-ascii?Q?bpwGnS4VkXDTZjkikSohAPjfXwYppRIGzrMISvQen9fXXrJIXJvjKbDRm0tk?=
 =?us-ascii?Q?A7gIBMJlcCqnmoGlMjS0M1PVem1imXFPrKvTKNajP1bJSQ+PUvQMlzCqcHc3?=
 =?us-ascii?Q?lgrHtqcD0XNvWvemHij2JtCjPHVgIm6Fup39HSlFHcddbTWf57kga47Sk+Tx?=
 =?us-ascii?Q?U7rwX6AfMZasbjFmtvdAcgVcdmVzhxMHWLXQH3t2iBStE4+SNkOcL498YZtQ?=
 =?us-ascii?Q?dghz0rCWoxi8GchicSGVZblMK47jYmKwdfeyrV6nCeaw4LiUE51kN/4YAI/1?=
 =?us-ascii?Q?u2EAIWGKq+oBNUB3ctMpPUp/ZwQch1wkGmkkjdMG9qbRXIe3iFVo/aFLV+YT?=
 =?us-ascii?Q?zv94m6Yhna2i1+bJM129ZnP6QcLARS37PepY+B9Ibia34L8EgXgecSHAktHP?=
 =?us-ascii?Q?qIw0li4J37Q5S+0/Per2qmhjstr3fBt2jna5+tbTuqZaSODS2TAKCPC1VZlT?=
 =?us-ascii?Q?9ZB6SzvREc4EaPWlo8yORrbFSXAyyo8N85fhTsEzTSGudgWKrluFSyGdftdV?=
 =?us-ascii?Q?imSUOxRUsVqKuqz3eESyx6bgzoNmsNRYWS7JB+mmvoV228D0+4yRX9OGk0nS?=
 =?us-ascii?Q?JCu0QSFYvEEEnY+x4CUHHTd7TkLGguE5+HUBaCTpui5nPapEw69YtYjGpATd?=
 =?us-ascii?Q?ld6aHotNEjh8xq4eeE6Jnv2WY2cPFymM+ozoymXu6eTwyouXyU0mqlmHlsa6?=
 =?us-ascii?Q?HSdXdSXXsZED1/bsCKtJpLk+rGtJqYnurcwfu+bU1IBfGPdwqJZ2eeqMHGJo?=
 =?us-ascii?Q?WmqMJO6c+oJgbVVIjCA26haa22aj9KiQ7QYb5ykSD5E2m4cVfd1nbfo9jTzB?=
 =?us-ascii?Q?e5eNXHtaMb/lnkTEYqMP7uhllw3pDH+uX9uD8pDU5+SbEddEW9kl0L+YIY6Q?=
 =?us-ascii?Q?DhKLBnKwEW1/b5AQfciCm65PJyLuMWRguhwFIUTZxfZF+RpdTKJY/zlGmEGx?=
 =?us-ascii?Q?HQ6sSy1z/zwKFaOF7Q30lfStfb862HLjUYMFRMj4VilFZKEuFV6q7C85/K5v?=
 =?us-ascii?Q?OmK8v4QBIG5I8ec6JqeGIeuzNfnyr+xxxeHE+wA+lcIZs+gEwa+p7bvO7F7N?=
 =?us-ascii?Q?5YUA0sJnvP8AOcjgWoKrWt4cycIH8cEEuC8LXfgrI3gcmJHfz5uWepQkGnYp?=
 =?us-ascii?Q?JhmLwgp40Gkh1YUm0/IZyy+y+2aH7gba4zVNXJz/+nR3z02Q7uRlxP74lt7d?=
 =?us-ascii?Q?I2ge0MBSWAchq2eiavd8nBbXnim2FTvfl8B0aKFDfpWayPVDkQQdS7h/a7uq?=
 =?us-ascii?Q?l/W84ltnAHylWcDzHCqp4+VyuxOVm1ywvz11fCpbUMQbFB0YEDftYie/rTtJ?=
 =?us-ascii?Q?7aDnn+279AKvs4B7j6BFlJL4XE57QJprYCv1uOqmEoG3oeMJ/hyO6iYT9M8K?=
 =?us-ascii?Q?YLtY4MKnr7OoTkxRoRPigpYmua7xWauB2TZliHzEmtgolHI+jYRgygBEKhov?=
 =?us-ascii?Q?RqmDAw25M5LuZfxa9Aj0AQsUOCA1pRXRGBzd0wVnKzFC9r8I7EAQy942db6c?=
 =?us-ascii?Q?QHDtS3vWumNV1bYwO3hRPeKmMaAzsaIkwrs9JgyMhoADGpYFvn54GeG6tai3?=
 =?us-ascii?Q?ZxXfsSgFYj8NR9a8u1Dv3d4U6JeN5GUzeVhykPdlGkmLAtiUZarZ++xHd5CV?=
 =?us-ascii?Q?JDfM4Esg0Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c98428f-219c-4887-ca34-08deb1ebdb72
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 19:06:09.1679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rBdmZEa8nHzB1CASmh9PlEUT9Dxj22arDGiJPIFfpVxcEDl98uwNqSue23sNbtZIjApPzinhHsWxprOyHiqSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6806

On Wed, May 13, 2026 at 11:49:22AM +0900, Koichiro Den wrote:
> The EPF driver currently stores the incoming doorbell as a vector number
> (irq_no + 1) in db_val and db_clear() clears all bits unconditionally.
> This breaks db_read()/db_clear() semantics when multiple doorbells are
> used.
>
> Store doorbells as a bitmask (BIT_ULL(vector)) and make
> db_clear(db_bits) clear only the specified bits. Use atomic64 operations
> as db_val is updated from interrupt context.
>
> Once db_val is stored as a bitmask, the ISR's doorbell vector is used
> not only for ntb_db_event(), but also as the bit index for BIT_ULL().
> The existing ISR derives that vector by subtracting pci_irq_vector(pdev,
> 0) from the Linux IRQ number passed to the handler, but Linux IRQ
> numbers are not guaranteed to be contiguous.
>
> Pass per-vector context as request_irq() dev_id instead, so the ISR gets
> the device vector directly.
>
> Validate the doorbell vector before updating db_val or calling
> ntb_db_event(), so an unexpected vector cannot create an invalid shift
> or be reported to NTB clients.
>
> While at it, read and validate mw_count before requesting interrupt
> vectors. An unsupported memory-window count does not need IRQs, and
> failing before ntb_epf_init_isr() keeps the probe error path simple.
>
> Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> Changes since v3:
>   - Stop deriving the device vector from Linux IRQ numbers; pass
>     per-vector request_irq() context instead.
>   - Validate the doorbell vector before BIT_ULL() and ntb_db_event().
>   - Check mw_count before requesting IRQs.
>   - Drop a Reviewed-by tag due to the large changes.
>
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 61 +++++++++++++++++++++------------
>  1 file changed, 39 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index 7b0fc7ef00c6..10618e462229 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -6,6 +6,7 @@
>   * Author: Kishon Vijay Abraham I <kishon@ti.com>
>   */
>
> +#include <linux/atomic.h>
>  #include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> @@ -89,6 +90,13 @@ enum epf_irq_slot {
>
>  #define NTB_EPF_MAX_MW_COUNT	(NTB_BAR_NUM - BAR_MW1)
>
> +struct ntb_epf_dev;
> +
> +struct ntb_epf_irq_ctx {
> +	struct ntb_epf_dev *ndev;
> +	unsigned int irq_no;
> +};
> +
>  struct ntb_epf_dev {
>  	struct ntb_dev ntb;
>  	struct device *dev;
> @@ -108,9 +116,9 @@ struct ntb_epf_dev {
>  	unsigned int self_spad;
>  	unsigned int peer_spad;
>
> -	int db_val;
> +	atomic64_t db_val;
>  	u64 db_valid_mask;
> -	int irq_base;
> +	struct ntb_epf_irq_ctx irq_ctx[NTB_EPF_MAX_DB_COUNT + 1];
>  };
>
>  #define ntb_ndev(__ntb) container_of(__ntb, struct ntb_epf_dev, ntb)
> @@ -334,11 +342,10 @@ static int ntb_epf_link_disable(struct ntb_dev *ntb)
>
>  static irqreturn_t ntb_epf_vec_isr(int irq, void *dev)
>  {
> -	struct ntb_epf_dev *ndev = dev;
> -	int irq_no;
> -
> -	irq_no = irq - ndev->irq_base;
> -	ndev->db_val = irq_no + 1;
> +	struct ntb_epf_irq_ctx *ctx = dev;
> +	struct ntb_epf_dev *ndev = ctx->ndev;
> +	unsigned int db_vector;
> +	unsigned int irq_no = ctx->irq_no;
>
>  	if (irq_no == EPF_IRQ_LINK) {
>  		ntb_link_event(&ndev->ntb);
> @@ -346,7 +353,17 @@ static irqreturn_t ntb_epf_vec_isr(int irq, void *dev)
>  		dev_warn_ratelimited(ndev->dev,
>  				     "Unexpected reserved doorbell slot IRQ received\n");
>  	} else {
> -		ntb_db_event(&ndev->ntb, irq_no - EPF_IRQ_DB_START);
> +		db_vector = irq_no - EPF_IRQ_DB_START;
> +		if (ndev->db_count < NTB_EPF_MIN_DB_COUNT ||
> +		    db_vector >= ndev->db_count - 1) {
> +			dev_warn_ratelimited(ndev->dev,
> +					     "Unexpected doorbell vector %u (db_count %u)\n",
> +					     db_vector, ndev->db_count);
> +			return IRQ_HANDLED;
> +		}
> +
> +		atomic64_or(BIT_ULL(db_vector), &ndev->db_val);
> +		ntb_db_event(&ndev->ntb, db_vector);
>  	}
>
>  	return IRQ_HANDLED;
> @@ -373,18 +390,18 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
>  		argument &= ~MSIX_ENABLE;
>  	}
>
> -	ndev->irq_base = pci_irq_vector(pdev, 0);
> +	ndev->db_count = irq - 1;
>  	for (i = 0; i < irq; i++) {
> +		ndev->irq_ctx[i].ndev = ndev;
> +		ndev->irq_ctx[i].irq_no = i;
>  		ret = request_irq(pci_irq_vector(pdev, i), ntb_epf_vec_isr,
> -				  0, "ntb_epf", ndev);
> +				  0, "ntb_epf", &ndev->irq_ctx[i]);
>  		if (ret) {
>  			dev_err(dev, "Failed to request irq\n");
>  			goto err_free_irq;
>  		}
>  	}
>
> -	ndev->db_count = irq - 1;
> -
>  	ret = ntb_epf_send_command(ndev, CMD_CONFIGURE_DOORBELL,
>  				   argument | irq);
>  	if (ret) {
> @@ -396,7 +413,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
>
>  err_free_irq:
>  	while (i--)
> -		free_irq(pci_irq_vector(pdev, i), ndev);
> +		free_irq(pci_irq_vector(pdev, i), &ndev->irq_ctx[i]);
>  	pci_free_irq_vectors(pdev);
>
>  	return ret;
> @@ -529,7 +546,7 @@ static u64 ntb_epf_db_read(struct ntb_dev *ntb)
>  {
>  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
>
> -	return ndev->db_val;
> +	return atomic64_read(&ndev->db_val);
>  }
>
>  static int ntb_epf_db_clear_mask(struct ntb_dev *ntb, u64 db_bits)
> @@ -541,7 +558,7 @@ static int ntb_epf_db_clear(struct ntb_dev *ntb, u64 db_bits)
>  {
>  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
>
> -	ndev->db_val = 0;
> +	atomic64_and(~db_bits, &ndev->db_val);
>
>  	return 0;
>  }
> @@ -582,6 +599,12 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
>  	struct device *dev = ndev->dev;
>  	int ret;
>
> +	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
> +	if (ndev->mw_count > NTB_EPF_MAX_MW_COUNT) {
> +		dev_err(dev, "Unsupported MW count: %u\n", ndev->mw_count);
> +		return -EINVAL;
> +	}
> +
>  	/* One Link interrupt and rest doorbell interrupt */
>  	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1,
>  			       NTB_EPF_MAX_DB_COUNT + 1);
> @@ -595,14 +618,8 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
>  	 * doorbell layout, hence -1.
>  	 */
>  	ndev->db_valid_mask = BIT_ULL(ndev->db_count - 1) - 1;
> -	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
>  	ndev->spad_count = readl(ndev->ctrl_reg + NTB_EPF_SPAD_COUNT);
>
> -	if (ndev->mw_count > NTB_EPF_MAX_MW_COUNT) {
> -		dev_err(dev, "Unsupported MW count: %u\n", ndev->mw_count);
> -		return -EINVAL;
> -	}
> -
>  	return 0;
>  }
>
> @@ -696,7 +713,7 @@ static void ntb_epf_cleanup_isr(struct ntb_epf_dev *ndev)
>  	ntb_epf_send_command(ndev, CMD_TEARDOWN_DOORBELL, ndev->db_count + 1);
>
>  	for (i = 0; i < ndev->db_count + 1; i++)
> -		free_irq(pci_irq_vector(pdev, i), ndev);
> +		free_irq(pci_irq_vector(pdev, i), &ndev->irq_ctx[i]);
>  	pci_free_irq_vectors(pdev);
>  }
>
> --
> 2.51.0
>
