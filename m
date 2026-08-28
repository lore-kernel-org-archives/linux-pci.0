Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011062.outbound.protection.outlook.com [40.107.130.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E822D8DD0;
	Fri, 28 Aug 2026 18:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787942949; cv=fail; b=cBbRQvHlzBTyY+kG2nn8SW31IYTD2H3CgrpW/s/aHCJJCQasv0L+V0Yk8xClIVlYbEVEg4yU6hHvNwvmPit4sI936+dS6jbvrUyXPIRFtotvXRACtummSjQEGkPjxr9TvFuqUVxUAxDtpwBK8E+yyssT/KJPKsNRsMd5Srw4lcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787942949; c=relaxed/simple;
	bh=TsbwVmh/vT7zcb95jQSoGip1rctGRpxx2NGDxzSsiGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VjLHNRI729a9uppnpi8tltYTIme1owR/lKAirH/y5GEU5SmWLtntjIAsU2cVzMFua3ryVS5XY6SHJRuvRgDAAO2vclKgz1fNGLjK+vbt5uZoN3UROjPqFY+SSfWh1WHfoT+0puZvHveb8yyIvHz2lSJXW0eyR7+4r5sC7pVMh5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=LKxn3Rlt; arc=fail smtp.client-ip=40.107.130.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LKxn3Rlt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6alFEo9GYXLDYlNH3uGIPushgF7XCgY0oVurazFJhdIN84BvGyig9lnmUSEJFO1cMAwPmH96DKcE74O5WN73mBzTCZ+Rj2/Ij77qTX9Qnq37/sW64dfw4s6F+cmceTpYZBkRzFQrMU4JZAlFEZbLJ7bNzbZqKOIHjssLbplaNXxyR8fwl/X0qc7gs5MS+WkARmRObfyZKPx0aPdfio7vl/QwTjc5eRNyyQykWtWN/LT8d+y0AXQiEGocukAb40CgrTVKZayfX6tzeS3EbM33+bSLzNFIKGK+/PryDwD8EQpXTmNuRaCKPDQZdD/VFOfxA/Z6cDWHyrUtYOdTrI7fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bw2PdR20Gvu7OBxc9GP1/47gewcvwHH8if37dJ8f2jg=;
 b=GoJJQvMIvBkMFBdN8xXivadsZdozKE76cLTkc2G5XxIoXwA64YboiiHD11A1pgr3BepA82BpTcNhpYZS7Jjwe96u9I/MejoiUawzqqWyVkKNhQkCNUfn1RBuWv6UPsmqPMGq2qJVbet6LWKaLvJcLnscqYvslqxvBpG8aVErXVC4dEE6TfWhKvhWqglrX4aWub676ArQ1CBSHP5WJ5z7G/ZM2cLgqsI/XCoIaO1X3k9VWT777DhPXzMttY6VvYbiJHS4Z4SazK/s54VM3TcF0kmdh/RmJNg2Ws/yXn8TBDrXGx4nw7bmqnd7MkvLxGPm7DipkLyoTZOFyuH5C1ApGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bw2PdR20Gvu7OBxc9GP1/47gewcvwHH8if37dJ8f2jg=;
 b=LKxn3Rlt1a2aPM7b9FTfvzGHTnV2mRuN9dqlVtTa1Ijji0MwM/McMTPiOkxuzcY+9FE6c7wRFQ5w/zMcleVc4KguK9IkCUSETYbvS6JD4oglCD/OUWiqW/gXim5iWhqwCN2kpA5jGySIn5Eqf0o0Sv5lmXv+AzXhsvshSw7sZTx+/pc8DyY3SgleIGL3sAveSa7otdP41GZUNI7kM7RxKo74q3KZgvAk6JK4jFEftzZpyqCx3mqwySl/us77zEEWyblR5BhFWp7mDoBSD4MULN5H0seElk/bxLyzy8nSAqur5E83Y3ewDm+MATlSQ7ewWzg8wh/Qs+W1A04NkrLvlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA2PR04MB10186.eurprd04.prod.outlook.com (2603:10a6:102:404::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 18:49:03 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 18:49:03 +0000
Date: Fri, 28 Aug 2026 13:48:53 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v2 1/5] PCI: endpoint: Add DMA auxiliary resource metadata
Message-ID: <apHYFeT4dOxOolII@SMW015318>
References: <20260828170932.2735807-1-den@valinux.co.jp>
 <20260828170932.2735807-2-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828170932.2735807-2-den@valinux.co.jp>
X-ClientProxiedBy: PH7P220CA0053.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::15) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA2PR04MB10186:EE_
X-MS-Office365-Filtering-Correlation-Id: ce27934c-dc02-4dd1-11cc-08df053507c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|1800799024|376014|7416014|6133799003|10067099003|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	19D7FPSZEx7EBMmsvA3wz6HxloeyS7cuj36ksuRcm6iUhwuCv2yP/eP5yxv7YLzg/Le5TVS3LwWqoRtYQaFCWaIWWJ451bams5Yh9lEAHliyvcgmQW2JuJxgW97lEn0JyzY63C7Ig931JA+xMhlNHKiBu7ss9EyBVQGWCuycwYitHSrwK3u+GTOgVFLiQajEkGrq2FBqCEB+JPrqhabYynjUgxGhBELG2hiduJW/uGTseFvG5R8y38aymPkWys1A4XdbJs/T9i+Nq8FxBkmpmJx3LJOm3MjAtqC9fZyfeyC4kqZz8RIwL8npPAenVin+Y+OfZmYOs05ZtWUvB8jh3bvr/5mLar9Ps3oZ2iEgT3WI1uM9nretrrN+EyqW83iVHj4yJd2RCSbXAD5GXTwrJzA8WganJa/ItN5bQMoOhobl1Bk2ZWaPvY682T7VON3Oz+QmjzU4oAukERFX8uLLQrcb4t2yahGF0t8dX06vFV+kxEiAHLPaajvRLljwwSR8DSjt2Mwc86phb7tDmg5o6f9LD7lRZwLULxA8KYv1D/77I/Ct9DbqZDXjRNsFeXqdg8aLNWLEjqhpa3Rs4WrgAdu94c1FPfXiBZ5b0cXHdiogLrpysAO2bgQN/+hf78h7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(1800799024)(376014)(7416014)(6133799003)(10067099003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kQdBeKpGgjSOC7qHXkq2doofRLREm6o55Jk+TdEMZ7LEMEHVlJAJrWB18MUE?=
 =?us-ascii?Q?3HwSm9UAdHtMbBoYrSglSCqCL3++6sUC3rg4nSmgMHkcsQSNbJDl0ZH2yMAv?=
 =?us-ascii?Q?pL43e0bhIYlGElhL24PXwHtPWR+wQax6IxffeM1KV/mhHyVSJA19glSeoGr6?=
 =?us-ascii?Q?xyWetbRMiPziXuh7yAP1ZNbiMhaOMBRk6YIZFgdoTEOlGXp5i7P3+PP8XbPf?=
 =?us-ascii?Q?hqAfhP4eIf+ixPdql5b57aHrA828XVas2SqUOg+WsectmgHmr/aQMn4+fCYE?=
 =?us-ascii?Q?lFz3RH9LJoNXV89BNjdvACKQ/DZyYIvMxH+9M3vS+u0ena9mf5lR6emif15Y?=
 =?us-ascii?Q?kWfvENrZ54W7GNrR0l+IgdWnLGRG3pnSc6Uy1yNKx+76lfKbFTwlaaJycYHF?=
 =?us-ascii?Q?ippR1bM6CxyBFLSzXzwW5/xyvup1UVKj4h9XwBACVbnQN/8WqpmhOBCz/5Hm?=
 =?us-ascii?Q?f4a8d4hVVVHgWfsbV4NOkXpvjMTUi3xKC9/FoJtR92k+7E8wMAbmIoqcEl0V?=
 =?us-ascii?Q?Cg1aOoNdeaqDw7QG/Rqgeo35NFklZE8A8bwRT4HB80P8rTnYZKbIKkweuRQG?=
 =?us-ascii?Q?w8eZBt5tuasuAAX4UtUTdC6qXcHg2nD5Cs/gPHh8C9OeHoFCMSPW/Mj06YBu?=
 =?us-ascii?Q?IrlSvNexuN+PSJK6quVSutyTVhiVZ5n2U7NN5lyhGbwZKhlYKTkaapHFzGwM?=
 =?us-ascii?Q?+phlM/KTOyLtz7p54ncMubEmsj6HKlFXpVG6Rl4L0A34xdkCdQt3d83LsK3r?=
 =?us-ascii?Q?bmfHxjLvZ2mfPa4RFnBSy/mGA1P0XF/LvAK5PkHGxu62TGgGZr3n3ykPB+n7?=
 =?us-ascii?Q?MzT5Xj2gsOOTa/J7Im632/uKETiU0Q52OijbHI87Ejq+2XpQYW6ANdGBAvBO?=
 =?us-ascii?Q?BVmnBmXsMw2yqIQsSGIuxK8LtVO7CHqYZES77sq4jt4f85IaOf3cZR1D96mM?=
 =?us-ascii?Q?R0LGSq87O4X7pfzB3e5kKaUxVu2habHrgReWN9sfI3ZPncMeOU23QEhVNACF?=
 =?us-ascii?Q?OK1YV6K5Cnty+6XL2pNmnc5Nc3vhFD3EXbPfrVYpN8L5lMd5aun/xh6y5Yrc?=
 =?us-ascii?Q?O02YnOx0/T+IhRHCtUiyoALD0pt5oDv4jdc9kmhcv1YA6QjJ01wyBq7iWi1w?=
 =?us-ascii?Q?dPA6aV3NwyEiEnbESrlHfFwX0Bgvxk1HvN3w0O85cCPtNJYAeeAJ3BoNxem8?=
 =?us-ascii?Q?/H2gbJMHYnQHP0Q5EJ5SgxC9MjI3+ZmWpXr5i55gRclhalqiUSuSjZ833KdG?=
 =?us-ascii?Q?rRVMc6eEoEUjWCfHREi4wDx1NXMt0lRt2lkuSHV33lP9bBRYZj+tsQWw0vUq?=
 =?us-ascii?Q?wCCcrxnUw1JeQ2VJpB/10UYWyaQT0CzvnULOLSiyToyJXYTVelWmdmZPO9c9?=
 =?us-ascii?Q?ZWq8fRPxCXm7WSmvoUo/PePdg8VJX56vTfe7/h5EwnBQcvT4qirUGFXKz3iX?=
 =?us-ascii?Q?cwhMg14dYozEO2v86zUfb9ClsyGUEeZO/AvK3wwJU70soOZLzVcmIEOxtZN0?=
 =?us-ascii?Q?1AGIPACSC6R/deN4N6yTB0AbBhZj00QV08mCatdhOYjxmUgnrepwzJtykHtI?=
 =?us-ascii?Q?CcNL8OW0hFqEwFjvx1Uc1Hsd3Rjl2DK7DtlrPBHdsScj8yXH6FR9yX1pI35d?=
 =?us-ascii?Q?eWEogdK5rl2X8CeahyYa7Z9L8nZWJX6e0JWxATLMDCPp3S+a7gcOKG6wOBa5?=
 =?us-ascii?Q?/2pr/6++IAeYGFnDx6NEM4onmfR2O6RplLKKVU51zDHDSWNq62fsmxz5vCnM?=
 =?us-ascii?Q?lfS7bawu+02RwY7MpAkWh9Xafe4DXzi5XxwNb7YNX7xr2nVZb0wV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce27934c-dc02-4dd1-11cc-08df053507c9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 18:49:03.4958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sh692zXnqDzRInd7SXJdX43XxghbByFJKkO1JrNelVqOhVEpKomTmjf2ju3vnmhXv6NlO9MMzwaR+nRwbqYcqe8BninYV7e1WDglqSfHeuc5s+Pryr8h7YSwedT90k/F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10186

On Sat, Aug 29, 2026 at 02:09:28AM +0900, Koichiro Den wrote:
> Endpoint functions that export controller-local DMA channels need the
> controller register and descriptor-memory layout.
>
> Add DMA control and descriptor-memory resource types. The control resource
> carries the register layout and channel counts. Each descriptor region is
> associated with the static channel ID assigned by the local DMA driver.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v2:
>   - Rework PCI DMA EPF v7 patch 3 with only the metadata needed by vNTB.
>     https://lore.kernel.org/r/20260813063757.3131865-4-den@valinux.co.jp/
>   - Keep descriptor metadata keyed only by static channel IDs. (Frank)
>     https://lore.kernel.org/r/lm7tadnxsyrypu4mypptlkx5qkytex4qxsijdr5ydud2n3anvf@yakjfjg5ng4u/
>
>  include/linux/pci-epc.h | 34 +++++++++++++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index f247cf9bcf1a..e0348e7bc534 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -65,6 +65,8 @@ struct pci_epc_map {
>   * enum pci_epc_aux_resource_type - auxiliary resource type identifiers
>   * @PCI_EPC_AUX_DOORBELL_MMIO: Doorbell MMIO, that might be outside the DMA
>   *                             controller register window
> + * @PCI_EPC_AUX_DMA_CTRL_MMIO: DMA controller MMIO register window
> + * @PCI_EPC_AUX_DMA_DESC_MEM: DMA descriptor memory
>   *
>   * EPC backends may expose auxiliary blocks (e.g. DMA engines) by mapping their
>   * register windows and descriptor memories into BAR space. This enum
> @@ -72,13 +74,25 @@ struct pci_epc_map {
>   */
>  enum pci_epc_aux_resource_type {
>  	PCI_EPC_AUX_DOORBELL_MMIO,
> +	PCI_EPC_AUX_DMA_CTRL_MMIO,
> +	PCI_EPC_AUX_DMA_DESC_MEM,
>  };
>
>  /**
> - * struct pci_epc_aux_resource - a physical auxiliary resource that may be
> - *                               exposed for peer use
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
> + * struct pci_epc_aux_resource - an auxiliary resource that may be exposed for
> + *                               peer use
>   * @type:       resource type, see enum pci_epc_aux_resource_type
> - * @phys_addr:  physical base address of the resource
> + * @phys_addr:  CPU physical base address of an MMIO resource
>   * @size:       size of the resource in bytes
>   * @bar:        BAR number where this resource is already exposed to the RC
>   *              (NO_BAR if not)
> @@ -99,6 +113,20 @@ struct pci_epc_aux_resource {
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
> +		/* PCI_EPC_AUX_DMA_DESC_MEM */
> +		struct {
> +			dma_addr_t dma_addr; /* Endpoint-local DMA address */
> +			u16 chan_id;
> +		} dma_desc;
>  	} u;
>  };
>
> --
> 2.51.0
>
