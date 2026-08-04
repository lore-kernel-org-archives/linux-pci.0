Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013068.outbound.protection.outlook.com [40.107.159.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B60B455183;
	Tue,  4 Aug 2026 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785857206; cv=fail; b=hKW5A4Fha22QgHMyeRFdKt6GLqL47eF73xK2sGL35ugerLh/WbG7lFqfZUS94RSzOfnSe6PEZxPMHBgqt1CEsGPAcMnJy6mEem95HVTbn/+Cw3hGni/x05Y0uVSBaYO14ikzsZhk0h42CLzaLkWvh0sREZf4aAQ1tg7ZlglbUAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785857206; c=relaxed/simple;
	bh=ZCOR2S8Vd8jqWqDu0V/+xiav4uXRi1OqG3i1Y3SP1LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SDMAow1Wqy0b5zU1W7qQ/r4cX/Z630nkT6iBMZuJq407IA92t9DZaHUNQ+4q9K1EvaBVPz/YX+FRHwOGqW0asMNqqbetRDymlW9XWdjyafqAwMAeAU58amOK/g2E+xNxSHkc6ylw0CHzjqWbwMx0DssZCQEL9sgoV1JOWqC9Q2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=w0VZlBwZ; arc=fail smtp.client-ip=40.107.159.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="w0VZlBwZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKPsoGbytPGy5y140NKuqBc6jEOs1Qc1Un9MVoeC7Ie94NTa06CFipMBE4jRA1zYsyvhXljMHvcYpac5bgYsEyfIsq3zFamQ56DTyDuFAmYmSyWLc0l0qrIAJeTEEwSm+8DywDMiix/znGji2GDTlMIfnhr4q2lc2r4Fzf7QiSz12sOlz0FFJ5lX4BjxhI5TrPrEqMgWMlJZSAHRxaZF3+XPC8HhfWRMtiC8iRDhnXmmpW7g0OJUhYvo/VwnADL/I4YQIGRiLTvJBYpdMQXCbYzPAWWl//yGzbwpJN6C/XKtcUJOAwuH7jw1xIK0StKboNPBtfWVKoP7KT7B4sfh+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlWViD5TqkXsZPqOopXgJURRJLNp4/8VXk3vfpui6Ak=;
 b=iXJmdnDR5LT3IbenNSQMheX2Hq4aNlWIWtR7BcqsLNeMUdYtyq9YqubFWpkXoyOh52PnTEQWHMk2MqAAgNhltzi5fDJN9q2mLm0IydQtaDjXkwHeGWzKy4b3okNdbQIT/6vBp+ri4CthfBM1iID/fM1ESmGXdbc+lD8bpzv1in2/pIwsPNWXr7IoKXnxsGRv7YRt0hLhqzqI32fjy3XJkDh16WFIkz289Z3svgFko5URIIdf05ga79GviATygocqGMXIKv3fA5y5B2wgziJFHwCtQK3OmHv2fe4G9tXTSEBDKECSrr0vpgRREQHOqPmchhkFvzDbV1OT2FqrMefgew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlWViD5TqkXsZPqOopXgJURRJLNp4/8VXk3vfpui6Ak=;
 b=w0VZlBwZbOtzlsYkI0Qa0mG8d6IOvJ7WYNaNG4zHxGSxk2VXlXpK+4tYZfuOe2rNGQh5BvddpnxNu6KZW4FY33eS8vqurGt4EGSeXN0cdjh4BOQFCvDSoHGJooIO534q2kUzd7I5fPRc2vZ9eABYPkfuCrRWFySnsjsksCFzqJ/vceMegMIUHyuu6bsvpKcTkbsRFEweTcFW7t/TgvKdNrs2nM7wIOAPZ+6g6VvtBy3J9yF0sbUZH14PAIrWnSWgVwE3O1uIIXVcnmUdefirtI3SWybZ3QeVHow16F5pMPdo5yyaw9Mrp+KNm0nZH7ipx93BkWrh1qzrk4a1lI6pCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU2PR04MB8919.eurprd04.prod.outlook.com (2603:10a6:10:2e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 15:26:41 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 15:26:41 +0000
Date: Tue, 4 Aug 2026 10:26:33 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/6] PCI: endpoint: Add DMA auxiliary resource metadata
Message-ID: <anIEqUqEni_CDVFi@SMW015318>
References: <20260804033855.2115817-1-den@valinux.co.jp>
 <20260804033855.2115817-3-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804033855.2115817-3-den@valinux.co.jp>
X-ClientProxiedBy: SA9P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::33) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU2PR04MB8919:EE_
X-MS-Office365-Filtering-Correlation-Id: ede33dc4-da91-4708-8072-08def23cc8da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|376014|7416014|366016|1800799024|10067099003|56012099006|22082099003|18002099003|6133799003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	V3C15IyMWgbki1N39hpHYl/cSLyiH3Qgz1uiko3mnRsrRPEH25/+sWX9IV0KR1SUM7OO4lQK5qCFljlW9xulT4zpqP7RGt9R9nVVP+nUqow6kA22jEZgXukJz6pbBOZasTUjLvcYKG8Mqq2fC29To6I1T/1uxIwNXmVKCNJwWZ2CWCYqdQbZeij/Ey3yxkLoHjEBPgaR36Y5ynsghs0u2SA92qz1lNbd/gMcpn3dFQ6J//UIa7yh4HEX7v/dNxc4ibv/E/sqAIMqJLndGn7jWsDeWedLvTHpqVvgmjbaoIGOW0Mk9oiqa1eDxul0ycw3SzZOhwFh0BnNCNlLJhRlVtJ/AlUJkm/abgstYFhlTLgpurljtGEjLcDwQPfhpXvrOoKlYNtF378FJMAv6NfDMaZdwrd9nL2j2uoVo1hFyq1NV3XoeF2ejQUqVKDCAQar01HMO3HtPUbGnGdlFMSgRjURosfaZq4ko/UkROK1hvJkZPGF5j/W5D9rDLLeu83CC26WQJ04z9BxLAPEUoZPpy2wpwxw0JdXGmL0xnOh7FWoxyPpSdDC+GzTVl7TcQb9uy+y4ifdtnOVHL134OiF6VJhcM6kjiL80LQprY0qdGTz3cFeg6h8105Opa+lqhGJsWoTKQ6qsrV70IznMB0Fy99u/CZs6SIk7awBVYb84fc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(56012099006)(22082099003)(18002099003)(6133799003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ayMO9zZ4hnFMAolt3CM3iiKcWEiNLNt7D9PGxAcdogu2UiLVzisQGcrcnILg?=
 =?us-ascii?Q?XqmMAPU7bi1rgPHV9R39rljNMSsIXd9uNXzkWJj34dAv8zYpgzMfxvP5mU8/?=
 =?us-ascii?Q?pjoOFo6KkhQYvSijTrgqN4T8syy/vtL73GNkuvtxKQWbGJR4xz1PI35Eovvu?=
 =?us-ascii?Q?1dU/GzkSLjyjgebpMNU3D1O9WKmAo+UYhQOW+UpAdXf7OQEJSOJBGQs6y31W?=
 =?us-ascii?Q?7tAkG5NlWlysYzRQTsdep2VJR0oW9vffOlMjGtW0tlKkkLawhvML7JVL0ZHI?=
 =?us-ascii?Q?NF1Fm3hV2aM6Dshd0kHs7+1ASh6gtm85V2A6RNyDjWVx1wt3JdqWuwUnqEVe?=
 =?us-ascii?Q?8NvBskfijLI2WPluul497JJWpY6yN+lhNY5cGuTQ05QFQ8hJ+ZmgDvc/1Z3y?=
 =?us-ascii?Q?TQpZIrrdAaww2QlE8VMvU5A1K1t17ldZhXnvDwqvUVb2OYLoLqIcbNwAoEis?=
 =?us-ascii?Q?vG/eEFHXDmvL10/Iy+cY8Gx483t4gRL2eA6eAr/nKb8CgabtC8/lQbEs/4Kw?=
 =?us-ascii?Q?Gl2oCZzSYWUT9slTGTGubpcIuKcMTSg0XMUpHLxG78taUYBeaQIjRYTT12BD?=
 =?us-ascii?Q?ZRIxlpAQ8GIc0OdoBj+FCEerY8L8Bb6kQfSP+PEXiepmN6GEyxjx8dYz1vKv?=
 =?us-ascii?Q?RE/mHJ6i6b3h8pGPuOsXmplJjuqGHFsyBLBN43CZq0HFR9AulPJjqyV76dEJ?=
 =?us-ascii?Q?9n7L3N9nosJ1KXri9xQRIFj+6EL2FZWFmoIVVmdnkHDUm9pzXixDo36jHT1p?=
 =?us-ascii?Q?wrUFxKMXDwTRJbto9W8STR7PFK0ZP3k/Gd9RTeXuftCpnSON8obOu2lSAOS1?=
 =?us-ascii?Q?WUe5vliQv8Aed+d3Q/xd+DWfaOVhEbecCL24jBQV8kYj/chx4VaKdr1Df6hD?=
 =?us-ascii?Q?uBCbwZbH139g5+OaLYwKj9/pcKgXML3pYSjPhxgOD4/lE1oFdHKxFW4IGJH8?=
 =?us-ascii?Q?2FqfGBUuymIp5uipBBJy2D274+HYeV5dCkZjhRFKkYKj3nlpjo+GAxYy6K5O?=
 =?us-ascii?Q?CDi8YFltW2FD2vwXjzraJ0F3ZpEG2vKr7iICIyKpiayOjVLQgcu9pEGQChbo?=
 =?us-ascii?Q?Nv6V1EE/pBvJOYGUtRh5ABSQ1GRm454D02Mb8UgvkGl3BXvOL3Ext2iJvXXa?=
 =?us-ascii?Q?tYGBiDMlafzlagfBY3VEYt997GWwRHt4oyg9BlSR2q39iROMwUETrs4iiMFX?=
 =?us-ascii?Q?3Wt8cU7+TyY6S7x2dFjbZKvIPNcz1hSwXGVhksCvya3/JdLbCmiRAgSnVtbw?=
 =?us-ascii?Q?S9lPm/bPbt55RwtwQjbqheriH1T/eTtLfnjX5Hbuu9KCA6BpiuNC60Q0Y3k0?=
 =?us-ascii?Q?TzbIOvMQR/EVtJPGDKj1n6p5jVYiXKfYvLyhMfPkTSjv+8x7ySbGo+oaSEMt?=
 =?us-ascii?Q?hpYq1MepwRWDOYBRf9H2Hg5Vo5F/zuvUSVcR1pX57CSSi0UWywSae8YzJPbs?=
 =?us-ascii?Q?8UJWq5q2a0rAXRnq3bJf133P6k4+gZ8ByOvKvtv3F63fNknSzRAJHPvlhUCN?=
 =?us-ascii?Q?bFjX6ZhjFKRR+f0EuNghmoG6xZXrY2aNU+AeIk9o4DmsKjVgJ5IGhhVdkiGB?=
 =?us-ascii?Q?BbhP6Kg2uO6Vxz5WLjuV0f3IpMlypI3jRlXg+aXm2Q05C+WA+O/gA/vhmBau?=
 =?us-ascii?Q?fiZj493c1sPNVGCQF9XqsqK3agtfJdwVVZCWS6imeCvL1yORrr/W3AOg/xpU?=
 =?us-ascii?Q?d5TlP7F/pQ2KdC1Jji0fvU8rQgdx7U6FszClv+2/71I4r/SKtMWGbygqdV2Y?=
 =?us-ascii?Q?e4ELYadv8lIdfO/slUTs7AEuj2sBEDkIW7wsqEhS2T6zCKg2C9Mm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ede33dc4-da91-4708-8072-08def23cc8da
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 15:26:41.7715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sv/7O30R8UuN5srrLsugsCHsVTKnSFcyE6kr2plUsZO0jZTNnOHPbybU4w4GIx6JtKFan3JxZe7Pd43+i3C5rDMvwCzyCal5slSbHJnsbmiSKY/hRkWkV2a0i/5CQZbE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8919

On Tue, Aug 04, 2026 at 12:38:51PM +0900, Koichiro Den wrote:
> Extend EPC auxiliary resource metadata so endpoint functions can
> discover controller-owned DMA registers, logical DMA channels, and
> descriptor memory.
>
> The DMA metadata is intentionally generic at the EPC layer. A backend
> reports the register layout, channel counts, logical channel resources,
> and descriptor memory resources. Logical channels carry hardware channel
> numbers and refer to descriptor memory by ID; reserving or delegating
> those channels is handled by separate EPC operations so resource metadata
> stays independent of any backend-specific DMA provider. Descriptor memory
> is identified separately so one memory resource can be shared by multiple
> channels.
>
> For DesignWare controllers, reg_layout_data carries the eDMA/HDMA map
> format so a consumer can distinguish legacy, unroll, HDMA compatible,
> and HDMA native register layouts without making the EPC API itself
> DesignWare-specific.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v6:
>   - No changes.
>
>  include/linux/pci-epc.h | 46 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index f247cf9bcf1a..8c89cb6d6733 100644
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
> @@ -99,6 +125,26 @@ struct pci_epc_aux_resource {
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
> +			enum pci_epc_aux_dma_dir dir;
> +			u16 hw_ch;
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
