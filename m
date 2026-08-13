Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013069.outbound.protection.outlook.com [40.107.162.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17610331EB2;
	Thu, 13 Aug 2026 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786652431; cv=fail; b=ca6eHpTRxBTyYIZ2txWvv/0oc/CssbWa4KcdYv+kdJeUim/3QvMn6VdpALe9d6ND+RlqglBT7hFAI3z0oUiFZlapYB+fH3CouLghUpEJ2oidL/7Uo/zlIjcwUlf5CJ5odKna5fgfR9jcQzoSFN2eJLet/f6LCoj3Gzg3FtTSKFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786652431; c=relaxed/simple;
	bh=BudYFyJKunDCPOCAMqoLB9nDXNK+qyz/F7quQQ1Do4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n+4pXfG8/WI8REn3/U4z7XbjXvJIovNFcfKaDDfPOcuJjgOZ0/M2acamkEgAXQ1+7OC/wykj2lBMox6cSjF/mmEBHau0WzHTKrmPYBF1K35u4d40FSVXR3kEsdHCKguHTxsp5AsAd5yZ1n8vrie8WIeNIyuvHiL4lbqx4USsEKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bFMoyy/F; arc=fail smtp.client-ip=40.107.162.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bFMoyy/F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dnUFQvslNw/ufs5BWR+uc4V7uP/C37YwqNdzYFKEVovIprHVpyZq7uT+7pS5U+LWPoSGkduVDaecH3Vyof4L5t5i6Ko9KFMWje1gWBAo68bKsMumZ4kQwjp+9besAPf/vYOKbznPmMksmYIQA8WOlGKHYbiO9jOVEcpKpaMSdTfo1nw1jb+YkCq9NOomJ9bPgT2R3Cql+xitXBIppqzXaZNkXb7nVRDn83+wmXr1ZRVLghWHtWFYeK1v7jfcbZt4GIRHFtqdTIMCIzXSMX2RdsTZtBml2ibk8fOG8h+6GxoOsDGyJtDEBmQ5xybx8QaA063F3Z1FjbgyQ4oWiMDM+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//Mq5lJqV11tTiDxEYK9Bw4mIhkqBZJVOQGpziglL2s=;
 b=le590tHsYrgqtXQEhXm9/BYOxqEAH1QwnbUxHPOi3lq9cbg+ihFbQdPRYx6GPkRp/m6Z/5t/zgsTiKX5jdTNiydmzy+iCIQY+NutLjNrnWgQwEATYRzn6fJ5fjCVlQsMB+CbDZpPIAhxg8mJYtNA5fllyoff33fscRDCaFrHn2otyj5Kv8vsN2HnJjW3bgwcCF//1Emaa9FzIBijFYDyQFEeD/K2aXmHiHNAVDjBN/digbcBuRA88v+clox76glLwZVSAxlb9HGi1lT3U3OqJVaR1CyzEcaEz1awvw918iRzfzCtkzafTlX/0APbmg6EjxWnMezDVav7O/Nu7vsANQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//Mq5lJqV11tTiDxEYK9Bw4mIhkqBZJVOQGpziglL2s=;
 b=bFMoyy/Fi0Yt4pVd3wP53LADHiprQUsmvHMqfu53PyPWVRrP3LKZo/yyb+kiq2aHde/8eOK4M1EEGGtEXCUQ2VDVF//rLjtu1zhnVDwOV0a1nDSvsR5zmhBNIXaDD8AvgsS/g9RVFho3iURMUDRiv+qIiBaBBelHwwyarLc4b1JEW5xx9cnUXFLmEyReKXtb2ZF1TF9qVzfPPpOTD5aMhxgOx/8FUgyvJZr6qr6SXgSNlU/A1AsdfUWsm9onRcPIJHpILcVhduwmxlXGVK90s0tdodNbpUfb4sw8bhF1e4lila4UlWBAWHotEcd9e2kE5My9BILZ5C3xkYVZ+eHS2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DBBPR04MB8027.eurprd04.prod.outlook.com (2603:10a6:10:1e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 20:20:24 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 20:20:24 +0000
Date: Thu, 13 Aug 2026 15:20:13 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Vinod Koul <vkoul@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v7 03/10] PCI: endpoint: Add DMA auxiliary resource
 metadata
Message-ID: <an4m_U7B_gnJRgcV@SMW015318>
References: <20260813063757.3131865-1-den@valinux.co.jp>
 <20260813063757.3131865-4-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813063757.3131865-4-den@valinux.co.jp>
X-ClientProxiedBy: SJ0PR05CA0170.namprd05.prod.outlook.com
 (2603:10b6:a03:339::25) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DBBPR04MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: 54eb31d0-f25c-490a-f7c9-08def9784e01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|19092799006|366016|1800799024|6133799003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	COYLHKJbH4jftudY8L6lcu0uRRpH0zdHygZeViiaYkjycTaw4N/jtjIVzn6bnA3luVSWNoCHGR+LQhbRpuHwz0ogAe3ax4JtnfBqJCOM5fGSOjBBjN/tJXOHONOHFdkyWjvecY8ivEzvjq400qRMGhxwTNtn4rGrGfHuf0wFibhRPjImZEnMnlZCKN6hpJ85Z4srAhjeIk+eextEQYSZSd/4j8KP51UOaAQrCKSHqOK/9Vy5m08CB0ddcJ/79DNHWVUrC+llF9Ef2/8EeCagACIDH+7e6UVeZ3aVq4WvfNFddJN38TKUs6v7IU5EM61I7ZjQJDidJISpqY0OkWmKXfMPdFc4PG9wqGXG8Y+fkqcak3fjGQmphqdNIMZJvZpMkz0djHj4sSFMmbndF3E12LrXgyIBuDuXnIDdWPVHb95MAd+h7wpKZYVeWZkYNa+Tr4KfG/jDim9d7qTIoNDTN7CwQZnC1ZBd0fQOH/mGOgZ5VcJrHToA3Vdt2TJoeKbDO6U8NF5mP8CjqVr81s/e7YDDRmh/S3RDWhathnByL7gfC6LLbct99I5tFvIN30Ny5o/EjJAtIXKZDDAQ9X+HnxabQKhDTria8vWB1uR/si9JOEfO7FPTl5oQeIgREg+lu2GMAPUMnQRumVj6hDR3VYDG063r2h8sVkQSJbP2NO0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(19092799006)(366016)(1800799024)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bui6T9jkcZvpmwpmRrXnPqndqrJa7qpwLh+HVOUGX7X/C1HF3kENXCPDv1hz?=
 =?us-ascii?Q?mbscU6NwtQZ/qJ3Y8J/zLNK4xnsCbnPIAXw1Lr8me9pxzB0w+8fkjd7hJDJs?=
 =?us-ascii?Q?8zs0TksKQJeyJVTz8G0mZkmAVi2HJGIW90csVZLu2sOn+47p0ON3ZLo1rwI0?=
 =?us-ascii?Q?5DRsmcdvKdQRpvJ3q1L9NpZ/XFLD9eWrvg+d/mWPSejAW5asA+PdQ8eMvC9d?=
 =?us-ascii?Q?02x/442+9Uiw4l2cYUvw+e0ic14YpvIteLcG4aSMB791JnSqQRkhVzi3Z8EW?=
 =?us-ascii?Q?/Za0r4OxlY7Bt/F4RIsqunV3L5dP2tQEEMNeribxzo7l7hKmxnZhhTH63P97?=
 =?us-ascii?Q?6d6Jpg6TD6kwxVfGerylo1JjtOaDN+JAHUS69OnwhHz6h4RsuztQeMz7Lvuc?=
 =?us-ascii?Q?9AeyzzALH41YqX1jxcUMdigTm4oCRVSxLSZPQQnAruTmSSQTE36Ci77rdsKy?=
 =?us-ascii?Q?BPP/IvOCxkDBHIS26FNwYkGNywJIdFULKn+CSjDREchlsggDm9ehqF8IiyMW?=
 =?us-ascii?Q?jTy/yu32M/rDXPcsJfI6Vgjs+oghPrEqRlPzDGm/YHfyUtWAEoQyisUXXST1?=
 =?us-ascii?Q?RjLEQ2lDAaRigHboooFbBrqEaLaqgKt4Gyg2OtW/+ONTJt4HXdlNYFKWtG9t?=
 =?us-ascii?Q?4sGk9dqipIQjEjle8tTKK22Ce2laBR6WSM0zbrG0NlsgiVQtc0nLN7Nb2C6Z?=
 =?us-ascii?Q?JLA47TP54wqGqdDoId1P4Agf0vOy4iYwau+lCf02PODAllCysKdyf8hjEgau?=
 =?us-ascii?Q?QYYIoyBH1DaLhZFcgxJVBavS2YIU6sGLimlx+WWELj/4iID5IH4qDWmAwkrc?=
 =?us-ascii?Q?bpLNruhU1s64s710Kh5eUekl3tOak+6I4HC2M5oOEMLhI+6tggOugqwd4Kr/?=
 =?us-ascii?Q?sK/aTOR8WuP9USC4IpHBhv1mC7NGKxmH0GcOtEeJwq6GXrcOVxQxeq3N0A2G?=
 =?us-ascii?Q?1kTRknrqsK13B72GdRUoDYFttViwgvGMvflDMW7/zGi1wMHJZANUlwtZHdja?=
 =?us-ascii?Q?SWDA7F9s+Z0xprBeD4WAj7JDMjyi2PNEEfv5zG2imBKgHN19jTIJfVqMbcme?=
 =?us-ascii?Q?g5SSFTfa3L9REV/0b+cCXexTEJRZ18wg1Lyjf2HAOvNN6tD7h8QzPGMg9eiQ?=
 =?us-ascii?Q?Brm7fCZezlmewq/fLSMetIf9uJVEoL7TVyd4uwdI4T6Ahk5DQdtDLSGzMmPP?=
 =?us-ascii?Q?u37QWnbtSDyCCuywrxvgt1F3sFAZ9o6j5lM/xPsS93WqoZqysUSon5fTk4SU?=
 =?us-ascii?Q?JJ4plYrkpodWgc4/AlDg+9BW4dkuJi0e0hNjrLys/TwOzCFXUCPlYaYN5L5N?=
 =?us-ascii?Q?jAuiQiArNg9RGLg8skocw+sAb+7N5eDVkeG1NfAF9C0TPBfwyNT6sPHYLrWr?=
 =?us-ascii?Q?s27OCjSPIPi/g/aunPgCC9tZ2mmtsKCgoJdH5tq7Mmc1tl6F78mvQ5FYLi6D?=
 =?us-ascii?Q?XV4sDs+gdlnz41KipPxK7+qFbz7+GjA2kVyZm5pw1BkeJb2DrpGQCAzPVbYg?=
 =?us-ascii?Q?0L8RJEmhADu8KKvvcbf0pbaGAUHzJKe5EBAW1UIOVAeasu2IZYfLAz7i42SS?=
 =?us-ascii?Q?VHA7dSXVPD3zvX6OARh32P+yYvcNKpsHr4VNarz8lyeHJ0yhM+1QfzSTgeIT?=
 =?us-ascii?Q?Ibf4TxoZNVxTIyN7nWobc4w98WqWqjhZ09nKxZdNDr6f2ACp71z6mvkctcHu?=
 =?us-ascii?Q?ZLoyPRYM851h6gaObkOWw8FRMj6LgPNJPdImFhCN4inOq19cvhyURc3jMfw5?=
 =?us-ascii?Q?chmEGoMTYbMztkyeoXwlb/hvABZrbOTblUpVcANHNlMjZJroODKB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54eb31d0-f25c-490a-f7c9-08def9784e01
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 20:20:24.5782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 042R3AP3l8z/5Zj50K0WRNYkORPByBUSH4Q7SO09eI3OsYZWMOxP3ryeHP53c4JJu7HLUzPcYdsv2OquWtGBKZvpuA4yhd/TKQBgxnTRiIRprP291W+NwvglELtjhzli
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8027

On Thu, Aug 13, 2026 at 03:37:50PM +0900, Koichiro Den wrote:
> Extend EPC auxiliary resource metadata so endpoint functions can
> discover controller-owned DMA registers, logical DMA channels, and
> descriptor memory.
>
> The DMA metadata is intentionally generic at the EPC layer. A backend
> reports the register layout, channel counts, logical channel resources,
> and descriptor memory resources. Logical channels carry hardware channel
> numbers, identify their corresponding local DMA engine device and static
> channel ID, and refer to descriptor memory by ID. Descriptor memory is
> identified separately so one memory resource can be shared by multiple
> channels.
>
> For DesignWare controllers, reg_layout_data carries the eDMA/HDMA map
> format so a consumer can distinguish legacy, unroll, HDMA compatible,
> and HDMA native register layouts without making the EPC API itself
> DesignWare-specific.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes in v7:
>   - Identify each local DMA engine channel by device and static channel ID,
>     per discussion with Frank on v6 patch 4.
>
> @Frank, I haven't picked up your R-b tag because this patch has changed.
> Please take another look, thanks.
>
>  include/linux/pci-epc.h | 48 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index f247cf9bcf1a..3b60cf6628e2 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -65,6 +65,9 @@ struct pci_epc_map {
>   * enum pci_epc_aux_resource_type - auxiliary resource type identifiers
>   * @PCI_EPC_AUX_DOORBELL_MMIO: Doorbell MMIO, that might be outside the DMA
>   *                             controller register window
> + * @PCI_EPC_AUX_DMA_CTRL_MMIO: DMA controller MMIO register window
> + * @PCI_EPC_AUX_DMA_CHAN: Logical DMA channel
> + * @PCI_EPC_AUX_DMA_DESC_MEM: DMA descriptor memory
>   *
>   * EPC backends may expose auxiliary blocks (e.g. DMA engines) by mapping their
>   * register windows and descriptor memories into BAR space. This enum
> @@ -72,6 +75,29 @@ struct pci_epc_map {
>   */
>  enum pci_epc_aux_resource_type {
>  	PCI_EPC_AUX_DOORBELL_MMIO,
> +	PCI_EPC_AUX_DMA_CTRL_MMIO,
> +	PCI_EPC_AUX_DMA_CHAN,
> +	PCI_EPC_AUX_DMA_DESC_MEM,
> +};
> +
> +/**
> + * enum pci_epc_aux_dma_reg_layout - DMA controller register layout
> + * @PCI_EPC_AUX_DMA_REG_LAYOUT_UNKNOWN: unknown or uninitialized layout
> + * @PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA: Synopsys DesignWare eDMA/HDMA layout
> + */
> +enum pci_epc_aux_dma_reg_layout {
> +	PCI_EPC_AUX_DMA_REG_LAYOUT_UNKNOWN = 0,
> +	PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA,
> +};
> +
> +/**
> + * enum pci_epc_aux_dma_dir - DMA channel direction relative to the endpoint
> + * @PCI_EPC_AUX_DMA_EP_TO_RC: channel moves data from endpoint to root complex
> + * @PCI_EPC_AUX_DMA_RC_TO_EP: channel moves data from root complex to endpoint
> + */
> +enum pci_epc_aux_dma_dir {
> +	PCI_EPC_AUX_DMA_EP_TO_RC,
> +	PCI_EPC_AUX_DMA_RC_TO_EP,
>  };
>
>  /**
> @@ -99,6 +125,28 @@ struct pci_epc_aux_resource {
>  			int irq; /* IRQ number for the doorbell handler */
>  			u32 data; /* write value to ring the doorbell */
>  		} db_mmio;
> +
> +		/* PCI_EPC_AUX_DMA_CTRL_MMIO */
> +		struct {
> +			enum pci_epc_aux_dma_reg_layout reg_layout;
> +			u32 reg_layout_data;
> +			u16 ep_to_rc_ch_cnt;
> +			u16 rc_to_ep_ch_cnt;
> +		} dma_ctrl;
> +
> +		/* PCI_EPC_AUX_DMA_CHAN */
> +		struct {
> +			struct device *dma_dev;

Needn't this information, this struture should only include hareware
informatin.

> +			int chan_id; /* Local dmaengine ID, unique within dma_dev */
> +			enum pci_epc_aux_dma_dir dir;
> +			u16 hw_ch; /* Direction-local hardware channel exposed to the host */

should epf driver decide which channel export to host.

Frank
> +			u16 desc_mem_id;
> +		} dma_chan;
> +
> +		/* PCI_EPC_AUX_DMA_DESC_MEM */
> +		struct {
> +			u16 id;
> +		} dma_desc;
>  	} u;
>  };
>
> --
> 2.51.0
>
