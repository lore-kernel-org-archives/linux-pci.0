Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010045.outbound.protection.outlook.com [52.101.69.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A47311C01;
	Wed, 25 Feb 2026 21:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772053897; cv=fail; b=kV0GGU6IjctiX5XXP5ePUmZY/KJVZPjbp9FjXfxUkiqBd1n5HOu3QUuH/wosxH+ZDF1fHoeG/3RmMCEjk2A+JLfhe2TKusFJ4LzZ2mQtnMQoZDsWwOg10EJKy0XOCpijlt7MZsiP6J0blKIed4cfKrGoYmJxxZWIjRIf/k8X+kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772053897; c=relaxed/simple;
	bh=wRcOT4v7pubGdd20hyn6dBvtJUsz+dClzO0HRx6yy+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TKcQo5ITR5QpsWY349IszVizwxwwm/cub+FcVFiVKQxnZ+LgCN6e/Cm0NA3STAkP94FrTMSAzAELwEWhpYHS3F1kaEYNB/fikYsK0laLbwlGIjjWxZNt+oDgHKyCAcmNvzz1Rh89STCqutflNHX1BBLTg7+Wwnnm9HTkuq/a2sQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=miHexjEk; arc=fail smtp.client-ip=52.101.69.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="miHexjEk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ww67jsSO7s+zfLVrZ1O/TjPwX5tK8HxyMZ7L93gSJPZkeb7zWivrpPLrg8WJUWuxh6sYtsmn5lIxUKZJEGWObLRGlniIOBtggMvspUq1wUzhRcmFD4PkEDeTvOrLBCL85FEOsHbBPuIA2MRyzeOVmp1ZEBrtOz8EZaxcQgBkCfOS2TbO3wn60TLfqH8cX0iYqDUoeOzPUwJpl6oiOK0RcM8cj6zHWsGaLOW0BRd5zAa/O82CiwNuAsGSoohVrVm1UiHK6KdMPMOe3y3MGcHXVjd5e/DN5hH0Y/rsyT1Wwb+Uay56gZe9nxJAOufJtNpCTO9ftQOSb12Muv/Cu5FiIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zg87H9E2bnJyvUn1z3b0zt3PFN3qVEcVx3QUMGfDBLo=;
 b=P+4KawJQhr9lZ9pNX4WgqDmp/bG8HM/zDWtdYQYEJPEDc5mvwmyxERt9BnMnhf6wrMKD4M+gcEMl4ivJqiyp2MBTYucunn/DwL3rMhSH4aiW3xmXxwSA/rU0tZNL2oyKOTBtIndFY0NFEWOmEw1Hj3h5aYUxN5pE2xQIRoQDY+j5zRS5Xji+aDlJn2YPGnUcDG7z3gBW/pZuEzHd5Kx1EtSet8I2cI2QZ6gHropNWCrziTs0iqkgwu3gU73sNzwCIxAhV7gkkPQe1Wab2DSQx72w2p0Sv9xXZKRhKiDVTXpTcwkbfqQ0rZ6I2EjCd0MeiuZzPiJLEzNcBKaNT0eI1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zg87H9E2bnJyvUn1z3b0zt3PFN3qVEcVx3QUMGfDBLo=;
 b=miHexjEke+HHOJlbhrasAAvwmldg7OHLLI8GxlbZQ0zVfqHYqlxy9PV6lLU4QY3HuiVVFt7wpPUzVHdDMCuK4KDbtOyHDNpUZOekruiV0xr/yjJTEoU24uqlQiaqYPD0rO6bWjLHmWZDOj5fQFOQCHe0r/CEbBptHeTbqqkLe2XvjPtXPi7fRh4jvAC+QkNKcgOJmYS68GUmCxnI05MUhMnSwL42w9+OLbQT/AlsUlF6PCeCzZ9k9HeeZ6uoVXR1iaRUvLbf5BG6ArF8wUC+ypM/Vkake/pOfM6k3xU+Waq0cJELByGmS8iJM/+lA7ZuV8+osc6aINCOKV8booSbYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS8PR04MB7589.eurprd04.prod.outlook.com (2603:10a6:20b:291::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 21:11:31 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 21:11:31 +0000
Date: Wed, 25 Feb 2026 16:11:23 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: kishon@kernel.org, jdmason@kudzu.us, mani@kernel.org,
	dave.jiang@intel.com, allenbh@gmail.com, kwilczynski@kernel.org,
	bhelgaas@google.com, jbrunet@baylibre.com, lpieralisi@kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] NTB: epf: Fix doorbell bitmask handling in
 db_read/db_clear
Message-ID: <aZ9lexEWqba54kg0@lizhi-Precision-Tower-5810>
References: <20260224133459.1741537-1-den@valinux.co.jp>
 <20260224133459.1741537-10-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224133459.1741537-10-den@valinux.co.jp>
X-ClientProxiedBy: SJ0PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::20) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS8PR04MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: bd1619da-d986-4670-b5aa-08de74b272df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|52116014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	nSrgHIwZfYPG6+YP8XhD3xa4XdHtfSedLdqk7DE6aztiNI4owCtW+7USndqNnPx4AVCr90vALCEfIih0O5FjduKuDlgdTrRxilH/zGe2BCsYrgsjehKEmeGVFUqYQvGfON7E8xZY4hKFDKQPhf0+wEFevy8rpmWE/1DFRRRI4Pp+aZT3gzVrerR8FActIKGQ75VhPu3JicIXce50PorQca6T2El0fG6wp5D79jhkdI9oXFEChGSFpipFviQT3oCPdnMhLK5fwZf6Cx0oilw7uYN1e3V9ydJ67eHMH3QEuXg58Y6n8YRhAK6W1+RvkMBB56QeaesSB5PfRJvPMGWlkjayFG34afV0DPqDpsdzu+eY4IU2FGhOEmjlt/jRG1AQUlEGwbfB5JuqAPFiE/bNu239NKHBBy1ye/nyOz7sn8hVYi0ohziIIKRH8/VGeDvwH18tARGeGbGeJ8o92BsxLkrpqpzm6snS3YO2NS7i/MRj0sZT/7sQXW45Gd3Ibr2cEg7ydcMrqbN2xVI5Vfh8VbdS2ycdLPZBv/etkFWYqoqTQiRXyWYGBSUsQ5uujS0eJl0Zg3FeI5pIQrlkrCwnnvqxE4SyM2BW7HQQJaFoad1Fc2xiOG1Sqp4iItXzryQl14Me6p2L/NorGfwi9yZWhn3iqbze4zYk7G8HwEFB3v1PTk4Y9FqJxJdt7QI4HrRYkMXwmqx8RzJS/q8p2MCsKLsO/ym/iTb/tywXUH02M5LelQY5SjKCdeBe9DmNTNd0WSr80iGFZarlx8O/hzsuI28rET9jyKSSYtKy9MGlEPo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(52116014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s/VI1bJI2vyZcI6vq9xILNn7AbNklisInnOCIL1eMkUS1TDwvVcAHnzWwgqw?=
 =?us-ascii?Q?/kWic5zEIqo+aRQR0nmia3ncjBEXW4sVoiWYXiwzneF8jlyMcuPWTAgsp5CK?=
 =?us-ascii?Q?rxlzwalTtZBzDb/1W/HfieKNw0hT+/EwE16dCFDPmS6mnWSePCTd6fmuebyI?=
 =?us-ascii?Q?3O6LB+bXAIXbFZPGkypr1p8tilWnzb4TqzvYqxTT0gXNGV0zdIH8wFLUUbdR?=
 =?us-ascii?Q?RudktZ8KgFIgd027FGwIfGKfzDAazukNUJnWkLNIdGquVSMxAxWmy1vRaOsL?=
 =?us-ascii?Q?gQpGcDuLsT5DVcX46n57BOK+ITog6C5LwgbQTTQ5DX3n21SbyB93cjtjRthg?=
 =?us-ascii?Q?H9Wi1A1A5iFBwM5tCkfZTTkmkqisTM+ZoXGd0U595PwWWpAVcXZQ3orCsClG?=
 =?us-ascii?Q?cvePMBThLwdqMroMk3qNw27gQDi+8s+KmYWIlWDEsk2Eo70MVS2w+fdo5ITN?=
 =?us-ascii?Q?cOrr0tfUCZKI9c3tINwk4rL+sqHwy7lIEU+zvyrbM/1SKAgMI5O+i+h9m0LT?=
 =?us-ascii?Q?D3Pp6vr1JKn91lgRwWqhoY2e6Pjr7LcQZ8Dm1h6JUmhODY7aer7aoPbnm4Jg?=
 =?us-ascii?Q?46ZFgWq7uaunuvdhhyxt/qdKVLV3RSRUQLl0kCKhQEEgh55VDwbQl+VJHfjb?=
 =?us-ascii?Q?bCK7kc9jXLw4uosUd6mB8dORfKHAO0K7FbcYx40nr+j2WGabLNZUjqJoV6TC?=
 =?us-ascii?Q?ZrnHN1ALoE7l9gQ6bcHwnt6SDpt8kkTYt1zfWM++zCh7moMbaPHu90SUPGSw?=
 =?us-ascii?Q?l/n0DYkCBo4k02YDTtwlQcPPNZbE4RkSpxs5KJCfxQ7lfZs9B0XUCA8h4/Y/?=
 =?us-ascii?Q?aaCficPAbB6mEo5Qr272LdO5NkWK9J8K2bE6n1fY/Q15i8hUkrmfeXprOesM?=
 =?us-ascii?Q?6vZHzZA7A/2pzzo+hZYNqzFDuqytHQsXU6imuo7U/mcRK2IcDi91P+Ggdmnu?=
 =?us-ascii?Q?d/dWf6MM+perkal8wnABj0ys1sCYb73RicLyV2/8JlulPY8ZubHD8glcNhXj?=
 =?us-ascii?Q?HSuI4ENybDzdDHjs3sGnkLIl9iKa7aal47wzNI4k0SoSYhGtNbYbPKsp4wKO?=
 =?us-ascii?Q?mtZZaLNgvAywQGZjBC2/UfghKIU8GqyQbxZnNPkWU+030MUBgiZvDJf1UQnw?=
 =?us-ascii?Q?lIhmWIO0Jd+0cmqrQAzbV7/IjDfmcmNIVvNLuO4DJGtIzR6g5W5YkQ5YiG0r?=
 =?us-ascii?Q?YM3dB1GidQFU3o7BKQ78sRyx1f9YWdvLNATifelR5F57ELSWTq7FHZWtj+XU?=
 =?us-ascii?Q?x3+SvZAn+/OiZkgJ3o5A2lHBnIOJ8CC5eaf3LxYEXuu7OzS2l+2/KxI1xS5S?=
 =?us-ascii?Q?BU7pm/AebzR/QwQESRKkgX7ft7xXgS10tc0js/2gcah5R92NalTJhv0oK+Cx?=
 =?us-ascii?Q?sdxurGCHLUAvc903uM4T3kgyNJyYa+0B6XGubkpBMddzaAPiuOCh8J1HYITV?=
 =?us-ascii?Q?4gQqOTZUyCZV05MKEnXZzqQNQvQAtRT1Fw/WPNnKAcnfoUieRMwRnY0nnrQ6?=
 =?us-ascii?Q?rinLFIOI2oUKZ5emYUbsv6pS3S4MF7CKeAx0R8YZ2rTXpzKt3/1Tra5yJWKD?=
 =?us-ascii?Q?5uJMdKzU19tb1UUZk9TFiXKLv77WIU089J58Vm60OUP/5NRtzTNTf64evR9D?=
 =?us-ascii?Q?wO2flT02lv4Un3Fi0Uo0fOLWsOJ2CUQbchskupmeHt2iIWhoxwffLofo6J3c?=
 =?us-ascii?Q?f23S0oa7PdCFy/WuvLssQcWvduZyVNKG7S0zPivo9EGFRd16?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1619da-d986-4670-b5aa-08de74b272df
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 21:11:31.6183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U5i/6XQKp1YI+PcPAEP0SxrtfvOfpKhGb0ckV0LqloHevphZITWJ4emf/bR6UgMM4C/J2SQAxH0UbQKzBazY4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7589

On Tue, Feb 24, 2026 at 10:34:58PM +0900, Koichiro Den wrote:
> The EPF driver currently stores the incoming doorbell as a vector number
> (irq_no + 1) in db_val and db_clear() clears all bits unconditionally.
> This breaks db_read()/db_clear() semantics when multiple doorbells are
> used.
>
> Store doorbells as a bitmask (BIT_ULL(vector)) and make
> db_clear(db_bits) clear only the specified bits. Use atomic64 operations
> as db_val is updated from interrupt context.
>
> Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index 00956ab2fbf5..0018adc35f16 100644
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
> @@ -102,7 +103,7 @@ struct ntb_epf_dev {
>  	unsigned int self_spad;
>  	unsigned int peer_spad;
>
> -	int db_val;
> +	atomic64_t db_val;
>  	u64 db_valid_mask;
>  };
>
> @@ -331,15 +332,16 @@ static irqreturn_t ntb_epf_vec_isr(int irq, void *dev)
>  	int irq_no;
>
>  	irq_no = irq - pci_irq_vector(ndev->ntb.pdev, 0);
> -	ndev->db_val = irq_no + 1;
>
>  	if (irq_no == 0) {
>  		ntb_link_event(&ndev->ntb);
>  	} else if (irq_no == 1) {
>  		dev_warn_ratelimited(ndev->dev,
>  				     "Unexpected irq_no 1 received. Treat it as DB#0.\n");
> +		atomic64_or(BIT_ULL(0), &ndev->db_val);
>  		ntb_db_event(&ndev->ntb, 0);
>  	} else {
> +		atomic64_or(BIT_ULL(irq_no - 2), &ndev->db_val);
>  		ntb_db_event(&ndev->ntb, irq_no - 2);
>  	}
>
> @@ -524,7 +526,7 @@ static u64 ntb_epf_db_read(struct ntb_dev *ntb)
>  {
>  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
>
> -	return ndev->db_val;
> +	return atomic64_read(&ndev->db_val);
>  }
>
>  static int ntb_epf_db_clear_mask(struct ntb_dev *ntb, u64 db_bits)
> @@ -536,7 +538,7 @@ static int ntb_epf_db_clear(struct ntb_dev *ntb, u64 db_bits)
>  {
>  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
>
> -	ndev->db_val = 0;
> +	atomic64_and(~db_bits, &ndev->db_val);
>
>  	return 0;
>  }
> --
> 2.51.0
>
