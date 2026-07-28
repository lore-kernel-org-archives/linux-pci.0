Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013043.outbound.protection.outlook.com [52.101.83.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38BE2F3621;
	Tue, 28 Jul 2026 19:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266599; cv=fail; b=JB4wpr8zaJfJZWeouv4Y8zBYJBBg4yr7eEkclg9YgX4FvI5XURfCMp6kFpm3eTzuJtoDD4m7g6ZX2/KTQg5S9D3g83qACywsCNrRhfbs2oK8y9U1Vci1J050Qe8Gy99roDt9T+rjX0OxZTQD0a9kz1Vumv36EK3AdLkJdW21NNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266599; c=relaxed/simple;
	bh=+wGSVCXBjJUcTkRqYCDW93EEUd9p7O/Nmoc2EKf8ces=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MwsFsbLfO9s2YfMCtjOgaJzgZLmVHFNDDvWkFn0uCCGo/F150S4u6JKWUSmTiM8HjCG6OZjwNOfPRD2FY3hToSIfY867SlyzHRVVcykbBqIh0qGme7vwDdnqPbz+VBCi8/vdg/QgRky+ziLsTmhb1rR0wh83caX1r81LzgdEq+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=RmBpz68I; arc=fail smtp.client-ip=52.101.83.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RmBpz68I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPGJm6Y+XxYtQQey22AWm3CUFibCVM5Sb40P+i+ecX95wMJc0bbVdizgKC+DoTE7lLA8Z43M8is11WYYdVA/CLLETbE1DliTryL8x+5uk1Rcu6HMR41f7IATQcSDzjWGb6Lj+2VO96vyQlm+AgPREZJ5K40TWNNrDDZK04DgmwZs2w4jI0mPJZ/ZwxOyE2woKYSrIzptMDwJtq7efvqeNBKvyHhilr2zJk0usO0P0v5FryzXehBcAvqZJsxV/9w0JPNTFptuFTWF5p8A28dWkd2wfmr8OhH5CXNFz/ZmBJilHB9lXlL6/YgFgk+6lN2aJP93TKL1VAx/S7A/FhiByg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHv+KdWBlRB9H1eDL8G14vGqC0zSdEBqa0yTAeQE0ho=;
 b=wiild9BDpzHvVJ2QxfOYHiMYVfdhE7V4KuXXBKMPnEeKOn+pmm+cuS9WKHupxVnJ71ix1x4LBJNQ7Y/MXUK1uhAqtmK9Yf9NFjUYWJ95mpmCWhovdXGetkADvcpIQcDt2+jqsdWNsIpUv8fXYdH0SUjFL1BUaIviVGlbx3RztGo+w/2nQsQzY8aYFxdS7+F3mfalBdyz5UHUn8RATOQzVBZnKuAIYaKPuhT2cRAmY1lRnI/k8dW8KWRvYwtS7majqajyGY+PnKr8+Ek8Oy6f0yEfkjeQOtjCvVHzMNy8s2MJJ1etJw14sPhPRaIFAad8HwKjlPN4oOzXjMQagiOdUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHv+KdWBlRB9H1eDL8G14vGqC0zSdEBqa0yTAeQE0ho=;
 b=RmBpz68IcZzMOCJ0ipZ7dAfIaVcm6+Kv46lC9lhik6MuBPQN8f0eXG2CVzOUPNN8K/vtQ4mcL5W6NCE4tsWw90XRXY8srhW/KFfCq61Wm3QC55b3xMhF5qfIgos8lchIfsRtM0eq4mMwYswn+MSNbf8Zia4Xly4GTG5jk6Ixuf8MA8GWEjuKOGF5t6qnC8IMMGlUCLsTr4TY8DFfPc9Hee/165leBPwz8vbjU5pEDNKyAJ/er/zIiSayaJLCO04QYUSCBe2BXq/6UQTsYB1HLrCaFL5J/rq+PluRHSfCQpuregEnWL0hYlaalWpPhBASuZykkWt/fVQeI6Zvc7SSkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA6PR04MB11805.eurprd04.prod.outlook.com (2603:10a6:102:525::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 19:23:14 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 19:23:14 +0000
Date: Tue, 28 Jul 2026 15:23:06 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: endpoint: pci-ep-msi: Make embedded doorbell
 IRQ exclusive
Message-ID: <amkBmicqi6mMTIQ6@lizhi-Precision-Tower-5810>
References: <20260728172306.2751813-1-den@valinux.co.jp>
 <20260728172306.2751813-3-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728172306.2751813-3-den@valinux.co.jp>
X-ClientProxiedBy: PH7P221CA0036.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::6) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA6PR04MB11805:EE_
X-MS-Office365-Filtering-Correlation-Id: 476e4f73-9b62-457f-f71e-08deecddab56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|1800799024|7416014|376014|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BGmaI5MZjnTzONfK/qgyO8jt0b39CD5xea2hCsLyY2djgcgSJhZ8avV4FYwP/DteOGiRKDDCfNX2P7UliqHYr+schQb5TDhDEnyh6GW4zpwaku15cGuKmA3CSzlgI7EETQIy9vmchDldLuMU+I6RwDx2iqJhzjgeMSfC9yKswip7hnhw1/OkRMWtCg02jiOru1IGAF5bPz6fh28A2Oskb7HsOtOUUfBMqCYrH2BGp85UiVjL1YI5ufpInF5naXVOPlh9TYRv1WchTxoLnkl+268AgclN3LbxWY/1ypbfeOQ88ii2GzhMZqJGee4h419PJHnmFsPMcV2aMDzgZmV/ojDi0movlV7Bq+oEhxMe2Om4oNliiDsKg733G/6I49SGYe5zLTCYYt7Osl+lkYtU8zSO2a8Sw+cYzMzfB52c9jffEVSV6vt6879zkba7g+/IrOnqrcj60xPib33dKBBDmhLvxDQz1GIft82BvE4TDBgsveIQw5r2XfYe+A3YFIdz8+jB++LXJ6HRfyYK3tFzmMfym8YT4zhornHRv/WCmXwiDzHykUfVdSCLs2lUnDhfvSTtG39jjywqEGOztlmBV74hBBumwgiI+qqakjYSfu+L3szQnvrxWvWWvRyYf6bpEGgSil6WeYOQTB6PKUK9prpIJ/66RWwXvZ6oI3+2bIc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(1800799024)(7416014)(376014)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7UK5yUxdKoX2QBi50JPNMNDAIx2vXZdtKXdKzzDdOW0olwu1fkiLsj4HziLC?=
 =?us-ascii?Q?pWeVlvN3ef1u8jUflZxmdCwVYAjPMpvSz/MWORtgACVAs1RoWPmWrKMClaxr?=
 =?us-ascii?Q?mJYSy1BlSZHUwDYFF17J3o3Yh/GPEnW6iB1RoOQqi04gB4MHCRg/QkkAN/Gk?=
 =?us-ascii?Q?OAgqSfyI/4x2LP11IFpgI5LuSGd0VqXzDDMbXieUUQKA8+ean+sAuvz8VM1y?=
 =?us-ascii?Q?fF4dvkpSAVMBHWVFxATN4D0MZ28IUgdShUwV0Cot0jgSpjhfhtb+xFg9kaLA?=
 =?us-ascii?Q?S5LJ7IvY3s9VyEymh1+dWB5CX+eO5cvzSaKrGL+PAtJHcsIdT4HFvL0OaDY9?=
 =?us-ascii?Q?IrQP69GnlrGXhOvYJhAOWCFIHRDMJs6e0lguTxRXNZrqJquU8AlTVmtDiMHt?=
 =?us-ascii?Q?bpQCe95zjKWrACq2j+T0qN1GK+g5FX38XdfuiOuyswBMSlHSAC+HvmyKRyaA?=
 =?us-ascii?Q?7OFS1nNOiIW/s4ER+KP3JgLa4ihKYvlCXiNqCcRRpK6rf/QJHBVEv3kMpbGw?=
 =?us-ascii?Q?VkkRSbxoHL70qYQ4mI7Udz8McdHfhdoRIydTB4I4N4TOykD2SAcfFjbUrCAt?=
 =?us-ascii?Q?gR3WNQv4nTyExT/rm1XFWrJ+7/YO105YJGdMVCL2mG0U+MOK3yXpZxDX58IC?=
 =?us-ascii?Q?kK1dqV0e+MK+7oXj7O8H/WyDD5ChJ7rEriUsU7oxXIQXgSX4KZPf/F5GGezd?=
 =?us-ascii?Q?xhv2MKw/jxBukl+uhYioROGBbFK0eKgUYdv+UYQdWDDCA37XY3vQR5e+hqwf?=
 =?us-ascii?Q?Oan4aK0ADR0KHT+nMCnoamk0KpT2yA5m5cgxP65/03XgBn0vAbDoPpMYNF84?=
 =?us-ascii?Q?JoY8NRbTteUm6iGUmRMrCjQOdvX2WeGMJsS8z28LxOw6pb4uvXjH2vW5eC4p?=
 =?us-ascii?Q?M7R8SFwqDekU4boam8MJn0KWyG9uEhJ9qfywJNOdU4c5vVfeeCqSisZrKbl6?=
 =?us-ascii?Q?5nbYXH066OURHAo5sl/shjBhtcqZtAYGM4bIur0OUkat/rCdfcJLXTLJqb0h?=
 =?us-ascii?Q?lbQDLBkjBadq+ifonINkW4Uxj6dkVOkgmOTWUZ4VljGT67+sPqc/fF8enZRg?=
 =?us-ascii?Q?yEs/V93i73FEqJSc1bomi76jkKKCUnFLa8Q0/tWvYnAOVcaHBNJb5Pb9kz0j?=
 =?us-ascii?Q?vCtTJZN3PQwoliNuENHi1xQnPHD4IyP9Lnk5YRJi56EAn5MxaQPMXncEc63a?=
 =?us-ascii?Q?en6N2PoSEI8BzPKMKNefkEuKHhIT1WV9m60x6rRFOYturVp77xBpALPwbv/P?=
 =?us-ascii?Q?Hrm21yt/aTJJEQR4ahiZbcW09y+o5TPE0lV2mLU79gG0oEmamqxfXHz5ohaQ?=
 =?us-ascii?Q?5uN2DkaIl0XmWE9RMEVWE1Yev7+aSSBBlvG2oZR56Kdb+RjiX6o8W5esZPOo?=
 =?us-ascii?Q?fz2b0szcbFn5+7iHYIqQD+SSxaA8YysKWkHHt4GuDTXDdriXNHyHE1m1Ol4w?=
 =?us-ascii?Q?izZ2LdMzv1chjdqbGXgH8QHCdWvev7hKYoNQIrE9aQCpXChG1Gnmku7+ZTgo?=
 =?us-ascii?Q?zxTEMuR9qTv/1X53hoqXlKj5J7egvWeIsJgxzhjhSC0ppoCFcObkohV6t9Q2?=
 =?us-ascii?Q?RDS/jm+DWv1Xo6GvKHtUtjE1fq7wq+NOJgXNCoNC8hXUWu69k6aE83I24xCc?=
 =?us-ascii?Q?4IoSfWG7BFICcWVXkCEAZh0bCoKKEXKPf5Dxs97sAMmcl2VPwcXgLKiipywo?=
 =?us-ascii?Q?Bbp+w+jWL2ZR5KSNk9RE4VR+uGB/sn4/HwHKDaPsv7/ILBtycShGbQjnXoct?=
 =?us-ascii?Q?jrZfz9Qn4qUVzbX7BPwAy1saSLszWPYj+TKBon6PUxmTMM+ELH+s?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 476e4f73-9b62-457f-f71e-08deecddab56
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 19:23:14.1634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7VUlW7KSApsE3LU+iKzJbPREU/V0+slPDBiZSKN6K21624MS7hqtXbhjk8mpi/JV9ZFj3tEarVSVUGyEMXH++gcElNvug9u4xN7stAzGbSp64UMMmtdZR5PLetI2EJF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11805

On Wed, Jul 29, 2026 at 02:23:05AM +0900, Koichiro Den wrote:
> Embedded doorbells may use the same virq for several messages. This does
> not mean the IRQ itself should be shared. Consumers only need to request
> each distinct virq once, as vNTB and pci-epf-test already do.
>
> IRQF_SHARED would let different EPFs register handlers for the same IRQ.
> The embedded doorbell interface cannot tell which EPF a write targets,
> so every handler would handle it.
>
> Only the first EPF can allocate doorbells today, so this cannot happen
> yet. Drop IRQF_SHARED before extending the embedded backend to non-first
> EPFs. A second request for the same IRQ will then fail with -EBUSY
> instead of attaching another handler.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/endpoint/pci-ep-msi.c | 9 +++++----
>  include/linux/pci-epf.h           | 3 ++-
>  2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
> index 0855c7930abb..a123a189b4e6 100644
> --- a/drivers/pci/endpoint/pci-ep-msi.c
> +++ b/drivers/pci/endpoint/pci-ep-msi.c
> @@ -10,7 +10,6 @@
>  #include <linux/cleanup.h>
>  #include <linux/device.h>
>  #include <linux/export.h>
> -#include <linux/interrupt.h>
>  #include <linux/irqdomain.h>
>  #include <linux/module.h>
>  #include <linux/msi.h>
> @@ -112,8 +111,11 @@ static int pci_epf_alloc_doorbell_embedded(struct pci_epf *epf, u16 num_db)
>  	 *
>  	 * Still, pci_epf_alloc_doorbell() allows requesting multiple doorbells.
>  	 * For such backends we replicate the same address/data for each entry
> -	 * and mark the IRQ as shared (IRQF_SHARED). Consumers must treat them
> -	 * as equivalent "kick" doorbells.
> +	 * as equivalent "kick" doorbells. Consumers must request each distinct
> +	 * IRQ only once.
> +	 *
> +	 * Keep the IRQ exclusive because the source cannot identify which EPF
> +	 * rang the doorbell.
>  	 */
>  	for (i = 0; i < num_db; i++)
>  		msg[i] = (struct pci_epf_doorbell_msg) {
> @@ -121,7 +123,6 @@ static int pci_epf_alloc_doorbell_embedded(struct pci_epf *epf, u16 num_db)
>  			.msg.address_hi = (u32)(addr >> 32),
>  			.msg.data = doorbell->u.db_mmio.data,
>  			.virq = doorbell->u.db_mmio.irq,
> -			.irq_flags = IRQF_SHARED,
>  			.type = PCI_EPF_DOORBELL_EMBEDDED,
>  			.bar = doorbell->bar,
>  			.offset = (doorbell->bar == NO_BAR) ? 0 :
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 8a6c64a35890..e5b9a79beb93 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -163,7 +163,8 @@ enum pci_epf_doorbell_type {
>   *       For MSI-backed doorbells this is the MSI message, while for
>   *       "embedded" doorbells this represents an MMIO write that asserts
>   *       an interrupt on the EP side.
> - * @virq: IRQ number of this doorbell message
> + * @virq: IRQ number of this doorbell message. Multiple messages may use the
> + *        same IRQ; consumers must request each distinct IRQ only once.
>   * @irq_flags: Required flags for request_irq()/request_threaded_irq().
>   *             Callers may OR-in additional flags (e.g. IRQF_ONESHOT).
>   * @type: Doorbell type.
> --
> 2.51.0
>
