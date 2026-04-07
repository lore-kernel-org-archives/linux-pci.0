Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011009.outbound.protection.outlook.com [52.101.70.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7A4397E9F;
	Tue,  7 Apr 2026 09:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775554856; cv=fail; b=DpsA8XjURIpNB9pSTOybYImx77Qq43SbI78hQbKG+ZsFFnE8VDwQDZZXK4DtRV79CD0NLwamtt+bn8SCoullmg5GXMeyo4zQ5MI3uTwC2UnCeEnqogDbwsXUxKDUsg04a9TWQBLx9PN9tEq/5Fd/kWVM6WfqF6HjQ78B0Tayvyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775554856; c=relaxed/simple;
	bh=S0EOach71xCjKLOjmjXdLZQxyNQZUnftpHx5fF/QbSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LAXCtRPGNYUho4TK3HsyvezZWeLIjO27AASTvPiEkZE99Lq/6v8A6zEdvT3BQ3BSVpxTvusRszNDMEi8Hx5OF5p2za39Nx+gQcm4Guxe8p3I6p03mpAxnbUabDKBK8BK38Jt6C8j/kKv45ftBF0hP7R9F7+p7XY+DDIl22ui5z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OIdY69iC; arc=fail smtp.client-ip=52.101.70.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OIdY69iC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgDAopCfvVxmoBRm4FDBs5qmONSxv9alBoDJVyvzBLKONNqOloPmtEaU2C/94vLtGqq29/gp9j3/9jQ27pwp1zGN00/NgiUyV9h/Fm/sTrWLOPt/MOaRAygoclbcT3TpvoLHtn6wv7fmZmp3nwrWptB+vDDJNnuvon+Q/7olBZ4M0UnRsnKveJFTstIL/80jlOlO0RQZYdH4sN7dJO3qRVaALwBWIJKaVNA2O4t0dkQcYypXb8cchIdaOiTtmcKKDGU5Z1ZyBwgAWEvxxE+IcV7cHsrJvr9zkY+r7Mnww4hxkNMrS/oY7bT6Ri8U9SKxY32MldOUOaNLeOSu8G+pVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JA83uBlwPzmd0XCLh0Md+lnbApBa+GIyGQqADdw3rgQ=;
 b=x+sOipywVMJnWu7Zdj4XhT4uFjc2MCJsRlIz2xlDnJIm2wDC3r6GJ7WuC3FNQd8Irbl9cLnSsoVUgDey61NWFiN4jBfy8l2nLz9Be4ofT7R7wf3ySjTWOBt9D32vdSA0/9WJ90ysNth4uZxNwgxCNeghXRjGhjnAsJ/wW1V0I9J4JCYRQN6MoW+9HUcEvTA0L4UjJHtrk0MXAbp2hAcSBGWOpXar0rZ7S4Bw1PcKBeGpiKYkY8q+KE/lWb031gSS18bQP4cCg9lwgd3qWvNYHKTL0rKVn5EYH0rQCz2sEwH8/RS65BoCd6ZttPLKF8Yh9x62keQY5PeBGFU/Ssy3TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JA83uBlwPzmd0XCLh0Md+lnbApBa+GIyGQqADdw3rgQ=;
 b=OIdY69iC7SHgqWVLvkCqPP7E7YtGrltgK7/NW+hOQX8wu9f8oGRrA5yO+7h7O3K6fn41MiveGg/lI0vvQQxLYr42jWn7t+K1BTNVZSV0sLNVgTyeoVnyh8dTQ0LwzX6NWvDwfkvEg7sgpWD16ARhwmSH3TCyG0kmABduAkUenrWpBVJuizvyxIpVaxTSR++DErn+I7NRttVZhuy6O9//nRcipO6P7u2//LU1DD4fM0fvIMaNbpQhjfFbODY5HAfxTmozbE75TxaWxLTUL+twfrAKrnCjEjfxIqvhnqCU9m0WQhXna3LPpPxwkJejLb+FmwyPSFqNs8ZpWj2Ka77a2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS8PR04MB8023.eurprd04.prod.outlook.com (2603:10a6:20b:2a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.27; Tue, 7 Apr
 2026 09:40:51 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 09:40:51 +0000
Date: Tue, 7 Apr 2026 05:40:42 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>, Niklas Cassel <cassel@kernel.org>,
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: Re: [PATCH v13 3/7] PCI: dwc: ep: Expose integrated eDMA resources
 via EPC aux-resource API
Message-ID: <adTRGt8YA8q937PJ@lizhi-Precision-Tower-5810>
References: <20260406155717.880246-1-den@valinux.co.jp>
 <20260406155717.880246-4-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406155717.880246-4-den@valinux.co.jp>
X-ClientProxiedBy: PH7PR17CA0045.namprd17.prod.outlook.com
 (2603:10b6:510:323::10) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS8PR04MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d1c452-28bb-48f0-ca19-08de9489c17c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|19092799006|1800799024|18002099003|22082099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	0ADKJpq1U5AO/oSV3WTCQIa4X7cpPft4lc+1NMg+edmUxGk2IeKBiMXfyCKue2uF3OL89o2xw8yOJ88rC0cctZ5IQR3mptWhoZKB4YQlLeWIxWeRFyDPR8Zta9aTqjb2aXbo2bYge+xXaIdiVW0IzMJ/HLLQ4kp6EzLtqZVK0HqpdOYwfOFQBUV0OBhg97zIQzrEhosRbHUpkGLDfDURtLvV9xaCagGPDofIwfAfAW8C9mozVFUQsJxbEFUNaLqkTwIEbdcwaEJiMRtRkHVA9xocwtItFDcsTPirAcvO+jW3BRP81vmAK0SWXch6aOsEyc4WMjKQXfg6ZQ41Q7GqMvHF26E1hdvJH0tC7N+1MXvtg0d8NE941SJ40LIUJvJMlFk2q0c5/dji0rWNVuDFQiIWLlPt03SPEvsqjMwBZNvtec8ShrCx5XaeLEzAlrACV7WMa5PzbaXTi5NRDoIlzlmA+MqH8rKjFClFR47lBnenXK8LWHZNMrnCdWuGRdLZqnrYGyRcaEwsQJsIsGIE/SVozWbgXV9x8tuA7dnLZXkb6Nj3Kl5rcswfJdX95SvIpFwfsKzml06szNMjoy7PRQ+bibwqqShelkLdeN5yKen2vLUSI2TpsfVidtKTv9iZQxpYw9kSTqbuS7vAYV3E4tjUePO7gAHecsYhYjFFiDG9Bo7ZDDYP6mTcL3rECSrT9Tpvg7Iewe3V/WN0CmO1pazw1/VPI/axHu91hTVmxDrm2GjidbTsKRb7cesem7ZuywOUq28nAvcoabbq/rCj17vhWIX5v1gLjDhPoshBzTw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(19092799006)(1800799024)(18002099003)(22082099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MT1zDMCjPtYTk4MJSTQftvoheYg98HmLU/vNf4qH5luEypEvKyDI/EYCcQ5L?=
 =?us-ascii?Q?cilkXm689eymc72lDVi/QapAbzXeCID2kgTnU7OqmK03ZeSEzV5SMGF7YKf8?=
 =?us-ascii?Q?e42Caa5H5XwF9/lIGA0MhCTVdgdQ/mQg6U+49GwB/gF1/WXFdob98k1EXUUY?=
 =?us-ascii?Q?KdEx4CK1D9QaCll5s/4CwDJ9gazBIZZYr4BIOn81wiRkK3SoJiQ1RU+lobfy?=
 =?us-ascii?Q?NBF6rkZEaQT8rj1wEnv8gwpiHPGql00FA1FvjezeIBYoxaW+3gGizVHjklSD?=
 =?us-ascii?Q?gc3IWoVdMRl51n0XbLYzkZ38o+n5nFWRI9kbzD7Slf3HQNh3JgWC+S4jsTX4?=
 =?us-ascii?Q?HCr7i5kUboxyWC/TkZnDBV6PlimQKEAk3nXeazavEZAz9jwJyVMrx+3NZOKD?=
 =?us-ascii?Q?KaVotHvQzTQzsNrsPOMXn1hjtXS2F1D0AqNIWvHzTPLVFJ42kl5SC3CqodwV?=
 =?us-ascii?Q?cFVQAqZjTcu/7wpXgzkzP1HUGa3zJ6PAGHE4JV8oxMY76A88aOUohQCA73im?=
 =?us-ascii?Q?t/Bj8Xa3hICcnUNrEnATlg3MHeM23C7N1ndqDLJJAB42Bpcn1F+lK5C3f9cp?=
 =?us-ascii?Q?H4NTZ4isf/PJW5V2DKEEjBV+LYg8MNZhlBA+31AkDmnVXujbD6HiWC27ysYw?=
 =?us-ascii?Q?fqSqVlsLqF3bHPSep+/a711AdvXZg4F5EaGA2h1f4zPOrBvvA39lt1nqFZbp?=
 =?us-ascii?Q?cmrB0TIyuViPqju3dmNtp5iv9SW2vgvsKdhk3x4kFun8zaXBnqsPKIwUkByG?=
 =?us-ascii?Q?YIWc18UVRphyipV4uEQHj6VMuH7Nk0wm8m8k63jE90XcsKl9dJP3ymKbXy71?=
 =?us-ascii?Q?x5WDNNAX/BN2a1Sq4hyPBCpy0vy0Co0O9d+XY1sUcgjqUl4YWx7hQvrR7PqV?=
 =?us-ascii?Q?HKE+pFD/lq1YCeb6nW7eahf/utajPkpDEmOX05yFNM5eNE1/XCd8icikvfH9?=
 =?us-ascii?Q?KaNxTyLt27LuZ0/eIZOk8j5bbZ/KWv00otKGOlJZBfrOZqcOrkhej+9fUQtG?=
 =?us-ascii?Q?UdH7ZpCiq9BfchtNUznY0nY77u1cq7BleVNEz6pWs1r9K70hBqka7DdPT9bs?=
 =?us-ascii?Q?0f91TEkAyFrIKA+Um4EAtwf3CnvBIvyuc/5Fn01AJqWs6SI3X/alxZvkNPk4?=
 =?us-ascii?Q?e7CrZl8qCBjsEOOggvodaZtcHn09c6QqTzdB2gNhbkiNxVQxM0AC60Iv5GnX?=
 =?us-ascii?Q?EmBXakF5CMuQRXYiB7Tq+mcpfsJZzXIz8hK6NN2pRwYn2Zk3f3+l6/K5VjzB?=
 =?us-ascii?Q?nZYRmGMCrdanjDGfWjylan7qBusDYAqDVNb7Mn47MTb0KGnHSc8jnmTgaSH9?=
 =?us-ascii?Q?xpNSxtzDJvBl/vtogGKHQz0c7GyGfU/3Z6dfn6cqnV1vfzbHYtPqmwLdmu7K?=
 =?us-ascii?Q?z1P7vdE9rdXT22PY1gJJZg/YFmJUvE1R/ByRzRg809qvFu8Te/a2fbiuCB8s?=
 =?us-ascii?Q?O3p3GBj0gYyNxwDanKbTqLJKyK554qwIMAddSijQwjBs2RAywvrX/c3gasM2?=
 =?us-ascii?Q?ut9QxsUbZtZiYS9dRpWPaDdaaOClWMkSj58eHfMmk908bj5VHcb1lHQST8F5?=
 =?us-ascii?Q?X8xsuqFKdrEsSUnH7UgA/WiZGxhY8IQPLUPcTJAQGijCmqzWfoVF9jhS7buu?=
 =?us-ascii?Q?7JdSq+5AQFMcobeXqmIdnqh31KFS8U9QvgGSGAUzCbmS4JmhpSK3LWS9k3Ye?=
 =?us-ascii?Q?sIEG4m6hp5s5xGeRBBxs2yT1fbXjTdZmV/fCOdxJ4aJ5yn8E?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d1c452-28bb-48f0-ca19-08de9489c17c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 09:40:51.3276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6T/UxUderdPpvRgX9+g1MHYiA/CZ4+R2As5PJ6W2uDRhTMG47C88wEZg1fnfzuSkPE9TcSzvavUg1lcpQmqdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8023

On Tue, Apr 07, 2026 at 12:57:13AM +0900, Koichiro Den wrote:
> Implement the EPC aux-resource API for DesignWare endpoint controllers
> with integrated eDMA.
>
> Currently, only report an interrupt-emulation doorbell register
> (PCI_EPC_AUX_DOORBELL_MMIO), including its Linux IRQ and the write data
> needed to trigger the interrupt.
>
> If the DMA controller MMIO window is already exposed via a
> platform-owned fixed BAR subregion, also provide the BAR number and
> offset so EPF drivers can reuse it without reprogramming the BAR.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Changes in v13:
>   - Updated to use the revised direct-count aux-resource API.
>
>  .../pci/controller/dwc/pcie-designware-ep.c   | 119 ++++++++++++++++++
>  1 file changed, 119 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 386bfb7b2bf6..c3c354265307 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -9,6 +9,7 @@
>  #include <linux/align.h>
>  #include <linux/bitfield.h>
>  #include <linux/of.h>
> +#include <linux/overflow.h>
>  #include <linux/platform_device.h>
>
>  #include "pcie-designware.h"
> @@ -817,6 +818,122 @@ dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
>  	return ep->ops->get_features(ep);
>  }
>
> +static const struct pci_epc_bar_rsvd_region *
> +dw_pcie_ep_find_bar_rsvd_region(struct dw_pcie_ep *ep,
> +				enum pci_epc_bar_rsvd_region_type type,
> +				enum pci_barno *bar,
> +				resource_size_t *bar_offset)
> +{
> +	const struct pci_epc_features *features;
> +	const struct pci_epc_bar_desc *bar_desc;
> +	const struct pci_epc_bar_rsvd_region *r;
> +	int i, j;
> +
> +	if (!ep->ops->get_features)
> +		return NULL;
> +
> +	features = ep->ops->get_features(ep);
> +	if (!features)
> +		return NULL;
> +
> +	for (i = BAR_0; i <= BAR_5; i++) {
> +		bar_desc = &features->bar[i];
> +
> +		if (!bar_desc->nr_rsvd_regions || !bar_desc->rsvd_regions)
> +			continue;
> +
> +		for (j = 0; j < bar_desc->nr_rsvd_regions; j++) {
> +			r = &bar_desc->rsvd_regions[j];
> +
> +			if (r->type != type)
> +				continue;
> +
> +			if (bar)
> +				*bar = i;
> +			if (bar_offset)
> +				*bar_offset = r->offset;
> +			return r;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static int
> +dw_pcie_ep_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
> +				   u8 vfunc_no)
> +{
> +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct dw_edma_chip *edma = &pci->edma;
> +
> +	if (!pci->edma_reg_size)
> +		return 0;
> +
> +	if (edma->db_offset == ~0)
> +		return 0;
> +
> +	return 1;
> +}
> +
> +static int
> +dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +			     struct pci_epc_aux_resource *resources,
> +			     int num_resources)
> +{
> +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	const struct pci_epc_bar_rsvd_region *rsvd;
> +	struct dw_edma_chip *edma = &pci->edma;
> +	enum pci_barno dma_ctrl_bar = NO_BAR;
> +	resource_size_t db_offset = edma->db_offset;
> +	resource_size_t dma_ctrl_bar_offset = 0;
> +	resource_size_t dma_reg_size;
> +	int count;
> +
> +	count = dw_pcie_ep_get_aux_resources_count(epc, func_no, vfunc_no);
> +	if (count < 0)
> +		return count;
> +
> +	if (num_resources < count)
> +		return -ENOSPC;
> +
> +	if (!count)
> +		return 0;
> +
> +	dma_reg_size = pci->edma_reg_size;
> +
> +	rsvd = dw_pcie_ep_find_bar_rsvd_region(ep,
> +					       PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO,
> +					       &dma_ctrl_bar,
> +					       &dma_ctrl_bar_offset);
> +	if (rsvd && rsvd->size < dma_reg_size)
> +		dma_reg_size = rsvd->size;
> +
> +	/*
> +	 * For interrupt-emulation doorbells, report a standalone resource
> +	 * instead of bundling it into the DMA controller MMIO resource.
> +	 */
> +	if (range_end_overflows_t(resource_size_t, db_offset,
> +				  sizeof(u32), dma_reg_size))
> +		return -EINVAL;
> +
> +	resources[0] = (struct pci_epc_aux_resource) {
> +		.type = PCI_EPC_AUX_DOORBELL_MMIO,
> +		.phys_addr = pci->edma_reg_phys + db_offset,
> +		.size = sizeof(u32),
> +		.bar = dma_ctrl_bar,
> +		.bar_offset = dma_ctrl_bar != NO_BAR ?
> +				dma_ctrl_bar_offset + db_offset : 0,
> +		.u.db_mmio = {
> +			.irq = edma->db_irq,
> +			.data = 0, /* write 0 to assert */
> +		},
> +	};
> +
> +	return 0;
> +}
> +
>  static const struct pci_epc_ops epc_ops = {
>  	.write_header		= dw_pcie_ep_write_header,
>  	.set_bar		= dw_pcie_ep_set_bar,
> @@ -832,6 +949,8 @@ static const struct pci_epc_ops epc_ops = {
>  	.start			= dw_pcie_ep_start,
>  	.stop			= dw_pcie_ep_stop,
>  	.get_features		= dw_pcie_ep_get_features,
> +	.get_aux_resources_count	= dw_pcie_ep_get_aux_resources_count,
> +	.get_aux_resources	= dw_pcie_ep_get_aux_resources,
>  };
>
>  /**
> --
> 2.51.0
>
