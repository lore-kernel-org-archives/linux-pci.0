Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010038.outbound.protection.outlook.com [52.101.69.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFA63B6366;
	Thu, 15 Oct 2026 02:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792030344; cv=fail; b=uQ0mpH0wSmmsP/RSdGTsnkO6wLbWkmzvjWtU42Y+F69s38hpcE1dRTV5lffrgFKBXvfown2WXrgiVTI2sovTpQec20nXUt01wHBv16ChvA1rZ1zn0EOv/ToWc/p6AK/RFZQLYNDXmKoxA/EHqPG46OHT6LG40t8ZGgeZCFH/YAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792030344; c=relaxed/simple;
	bh=DQbtR5JkOfOWwku/gXO3Xd2Op2xusHc4mlDv5v+xp08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s92l5NnNO1TWnkh/q7/UnS6zgWwIfYEE8xkRtgbMhr248OWUy8wyoysUxpqqIqexMkfg+hnMOnfo+Dq205wEmtbJ55jhHlsGIUAwN0zBX590bx5f/9udJyDdcQZuHda98DAvTZclet3Hm0mm25uYSWkIPWaaWg4ZDJ7oMiI9F6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=VjWOmNR0; arc=fail smtp.client-ip=52.101.69.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VjWOmNR0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oy6k9x3L4/BjgSjPq2JOltaErfs+rCTEQmeVDSRfiDmAKPkWJp53c4+Yuqs/VYnkqZxy5reHT3+8ELPh8Xm8kRZIdxcKf2BbP94XPoYmiwlGYEE+A3eVljLG+jWatbVO4YWudHhIutfip7OfEH8PHX1VWyhNxPJ0ssVqMuen7LgQyLJuG1f8wL5DXd4PQRVBVIbEbXbp7A3UMn7ZCrjVNx1rVV85fSUdXXBbR14wead9BjMt+LtpUUTiT5XsiaQBi1KBs1aTJfZ3D+crO9enXqQHAR/E5V+AGVpxO9w97QHo3Qe7KWxrKqbfvp1sbEgTH8kKWBW+7bGoVnz4uFfE2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLJBUc7+4T9dUvb0v439CjYUt4TPBuzX5rz9licDj9g=;
 b=SXyMbxhM/BzyFc71fidFpVaFaKtONyDSrBkT/ikhMPXcAL3cYZpOXmHH4VSgD2lj8KtLs/5okDmX+sh0ff6MDv5sCEnOet1S3N1RdUClbwHJ4ufov1vKZGN4LIVkOrKbJLdPhOKz0jPpLmz6ianJs6ZThYvUz3S36CEwb+GzBgsWiCJ45IbolloJl+wxyZcMZcA7FbgSvA83l3f1YjsUHVt7yLUMhYlmYSVD7/xenfQA1zUhCNVM4NdXfkNlLe/plEPqlPdSazWzu6fN0QtglkcZfB4OT5CO4DtQmmkL2bkfJL8Y3dpdeMBoP7aI1mLz7yXU2mnBUK/r32pFroJUNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLJBUc7+4T9dUvb0v439CjYUt4TPBuzX5rz9licDj9g=;
 b=VjWOmNR0nrViGRL/ph0/namDb9R/e0juiGRuxQJjlXtjEul0jyEKQg1nN6W4+YPHM1ZhQ5yIr3vNhxwRXp4g6Wu9RW3VMIckRbKtQfxgzh7CPL0NElYozbrkMBVzK8+8nVKmMA6RR4qfp4oz/if88C09rfzOwsEgAzr78K9V+DCzqP/fRdFzinbL/pHdwPUKjPpu9yoH9K0cbmgEgQydgGbV/8vruhe/z6eil04xkCbxszcNZrOmmKDv3avk/6JSa9y2WNBPSfHFNskj54ZyN/H33R2n4S1wuCt0gFa6LUqi4CWAD0jtnqq7TVj0H/Kiotn0IoTbtQFWvFwOxCeZLQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI2PR04MB11275.eurprd04.prod.outlook.com (2603:10a6:800:296::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 02:12:15 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 02:12:15 +0000
Date: Wed, 14 Oct 2026 21:12:05 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] PCI: endpoint: pci-epf-vntb: Honor MSI-X selection
Message-ID: <atA2dSzs9foYYQpy@SMW015318>
References: <20261015014402.2976188-1-den@valinux.co.jp>
 <20261015014402.2976188-3-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015014402.2976188-3-den@valinux.co.jp>
X-ClientProxiedBy: DS7P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::8)
 To GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI2PR04MB11275:EE_
X-MS-Office365-Filtering-Correlation-Id: e638a580-7fbb-4e54-24c5-08df2a61bb4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|1800799024|7416014|376014|6133799003|18002099003|22082099003|10067099003|5023799004|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	zouLcxuouESN+R7B8V6TxsRmaC7P5wRG4t/Xw50yMWUXR+y34utTy0Wm4tqI0q4dnE+TnATJrCiZNlEPHt4DiiZwnK4b70feZNpVInxXllGaJNQ73KHEurHM9XLWdlPFwaFWchLQsbwRhZ9SFKz8cO/wcftwcHV/6JUEw8zur/HjyaF7+qkwQQ+5cydDn47IwOiZ7Cy+WPuu4E2OFPiVgM7RGNHXgJqxtn/6F4BRPuD21f9UwrsUescGsXsLSlXv9x61Ss4NKVVZ6N+R8uGPlKg1uUdCluDVJOIWZAfvAQFJkqSbwKq5LdtSJhU9IaNfZ+bnrSeCPhrdwZpC1zZXahOdi/pPBLDoHF5C4iZ8V+7O+Ei0tS4QqiSa0o+7/8FiAC/N2/6uwoLS0lBc66rGPZhxgrXjXNfd3x0Z1gMoKhwGt0DPKwmUzpk3SFmY8c59YAj8zWu/tYLIErtuFEt0R3VR+cc5/a7P2moyznSiLqw3NR8BWXJwExgqXli9zRFYxUywMXmrzXC7mu/Ty/6pq6/zbZ22AmoSEViJypq7M9WZaG11/S+cQxgL0Yb2PBFgkzdF00pnkh1VuC+5bX2caMFAIXldgtzksq7zG8mle7Y0gJT/CdDA1ug/sGbPdeAx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(1800799024)(7416014)(376014)(6133799003)(18002099003)(22082099003)(10067099003)(5023799004)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mowkQ9U5dWe0CxZ4EUvwGnLhM7BtZreRhC9TdnE0I1sphXEkqtvVtEN/9P1V?=
 =?us-ascii?Q?SV56iqzfXnRTYUxpiIsEVOeVD65KF0px2TVvgiXIYhp8fmNpp3QJ/ypusodO?=
 =?us-ascii?Q?L7TkmUxeq1G0mU59gKTTeb/mZpa/jHecT9D6FrVca2gTbRIVX/61VRry2A3Z?=
 =?us-ascii?Q?vcWHjWeVWsQm/4YG0EuxMAUSS7t9TA0/SxJ1A8sdXGmkSvPr4YSWvKW1OrCc?=
 =?us-ascii?Q?0VpOMdM4Ciq0/5lCvAFJnzw6FaMoQIuM/NBGZThFdpAhonQdDCyhsLpo8dch?=
 =?us-ascii?Q?wZP5QdQbzd/rAOhSBsYD30FZLwW+6NwentHsN6N9V20R8d/1uH0yB0xbXSND?=
 =?us-ascii?Q?J9DLa2o3/sHjIFswqSF7PWbqOC35e0RF+pBKiWQBiHkfccguUEYGo8ZGQNO7?=
 =?us-ascii?Q?yIdleol6LiwfSwaCeS4jEyeyNPqRgvYLzNIzPZy2AQ1j2SSpJ+gvJYWrDZ1d?=
 =?us-ascii?Q?GlH/yz6l4CSS4MpvYAMCNGU01M/mcjTJMwUnN2w8K5UR75sHVev5Bdg+FDvu?=
 =?us-ascii?Q?z1s+hNtIkSf1OayLUBIQZd1TORWKw+SFkEsi4IrZAwIWj1aobl6/6LsoDrde?=
 =?us-ascii?Q?ymtP5fH1QtO0fAPZ4SsX3mHhhzlaCzH5ZRLW7wLj9c57y2XuE+qMjASmlezL?=
 =?us-ascii?Q?hw2TKXsdfjuui/CWHscUv4NdJinCGOyHdsR21W2eOj0X2F2LF7GXPOfgmRM/?=
 =?us-ascii?Q?QnSqgkQ2wlkeYt8MdN7ZsSIZW4wv4Nj5aGyEk0aWO8tteWY4pnvKivgPPAQD?=
 =?us-ascii?Q?qnhB/0Eq+mkwEOwD1hTwhbtnX+aZUddXiDU8fEr+jD5CdX0gHi1RHzvkfp49?=
 =?us-ascii?Q?3hy5wmBdtrEJxsrNJ64cIp5egOPr3NIBUoTj5VOs2N9fqIfT7s+ZlSN3EGPM?=
 =?us-ascii?Q?33wosmhj/U1wIs/Ya35AhEIjqK6n9bsOFhK+3RmsdX6qR8XE+2vW1avqsHm5?=
 =?us-ascii?Q?f86bQZsQBL7QfSTVodAZnZgVa3DXftiOseHCBiQBlSkoWcmU7XbDtJPk41SJ?=
 =?us-ascii?Q?h+nygeXsJDVslqA/Wc4NuRzLruS3xXxl17J6iJa0ncqk0lEOUiT7hzE/EANa?=
 =?us-ascii?Q?/uzso7gMqJQazWgtDEuVgKoSiKdhIEoDlbxV1QK12bvx2FfrUYfRPU/8aMwM?=
 =?us-ascii?Q?K+i/vLWGDDQm9LGGviRcItiA9ojW8/cO+Bi3aUtkjJyc1NsfZ2d3yZ2mfHPN?=
 =?us-ascii?Q?3hSyha9t09AStgSHOWjNHoAYe38Dkn90l1sOtX+0xwJP7Rnl2BJAqT/7B6d7?=
 =?us-ascii?Q?Ybn4gsc9BZXorrpq7Jrpw5bjrra06kZi7M+WRR+88PMtnmVBeYEzV2kU17aR?=
 =?us-ascii?Q?zA3O07ZHFa8ChTkYsPkcAwAOWA5n6f4zTfs5wRMFxYcnh8Qs+xBjfgNjz6VB?=
 =?us-ascii?Q?PWPnu0vteqbgp2h1+0vt80/+5VRMjUTl4Hx9IpNDfb8BqF3rPJ3yf7de33Ca?=
 =?us-ascii?Q?b68gprQFPbIkTkebe1SsZN+7XR8e8VZu5vqCq0U0HmqhTtyEUiQpexqtHmio?=
 =?us-ascii?Q?LlRvr9QIfZSFvJborZ9iq3aUYIPELYtKHIXhvYD0FrxXT9pGtJHiIkL0vz6w?=
 =?us-ascii?Q?qEJZJG9dgIlgS//Hm8qd8nAmKl2l7+UQV8punVmyCa/klN8YcWuTQH5H+Hy9?=
 =?us-ascii?Q?vAK6TACRLQjY/iRgDHzlD+rsgwnJ8Df/hPCM7ULrkrmdKRNkduAPaTRRG8Ea?=
 =?us-ascii?Q?PpvFRgegypJZ9BQvogEFKQ+Nt4y7G63e+zBN9rBhmlzFXiRBN51ZE2oyqOn1?=
 =?us-ascii?Q?oc8eDJ2wIZH+GAni3TBzZ/j4XzwCWwowU8xE7q7lEDEiXQirHssH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e638a580-7fbb-4e54-24c5-08df2a61bb4a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 02:12:15.4784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Eby+bBjJzxbYY1G9EYQmQbkD+CmwnYUofhE0Jf8mM0N6huZjkpacT1n/cDJQ3xvAa3tbS7zef7xIg7X8aXaRFR0jvmDPMer7Rqa0eVeZ4yP5RnHFhUQRJ0tjCR97vu+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11275

On Thu, Oct 15, 2026 at 10:44:02AM +0900, Koichiro Den wrote:
> ntb_hw_epf tries MSI-X first and falls back to MSI. It reports the
> result in COMMAND_CONFIGURE_DOORBELL. pci-epf-vntb ignores MSIX_ENABLE,
> configures only MSI, and always raises peer interrupts with PCI_IRQ_MSI.
> When MSI-X is selected, the host does not program MSI, so raising it can
> issue a write to an invalid address. This was observed as IOMMU faults
> on the RC, with no doorbell interrupts delivered.
>
> Configure MSI-X when supported and use the selected type for peer
> doorbells and link events. Allocate the MSI-X Table and PBA in the config
> BAR and configure db_count entries. Use this EPF-owned layout even if the
> EPC has fixed, hardware-owned Table/PBA regions, as pci-epf-test and
> nvmet-pci-epf already do.
>
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes since v4:
>   - Split out the local epf cleanup into a prep patch. (Frank)
>   - Keep the MSI labels in the interrupt-numbering comment. (Frank)
>   - Rebase on the link-state fix and honor MSI-X for link events too.
>   - Link to v4: https://lore.kernel.org/r/20261014053256.2378817-1-den@valinux.co.jp/
>
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 47 ++++++++++++++++---
>  1 file changed, 41 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index d74402ea10bf..f4eede5330c6 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -152,6 +152,7 @@ struct epf_ntb {
>  	struct mutex link_lock;
>  	bool host_linkup;
>  	bool vhost_linkup;
> +	bool peer_msix;
>
>  	/*
>  	 * True when doorbells are interrupt-driven (MSI or embedded), false
> @@ -159,6 +160,7 @@ struct epf_ntb {
>  	 */
>  	bool msi_doorbell;
>  	u32 spad_size;
> +	u32 msix_table_offset;
>
>  	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
>
> @@ -202,13 +204,16 @@ static void epf_ntb_update_link(struct epf_ntb *ntb)
>
>  static int epf_ntb_notify_link(struct ntb_dev *ndev)
>  {
> -	struct pci_epf *epf = ntb_ndev(ndev)->epf;
> +	struct epf_ntb *ntb = ntb_ndev(ndev);
> +	struct pci_epf *epf = ntb->epf;
> +	unsigned int irq_type;
>  	int ret;
>
>  	ntb_link_event(ndev);
>
> +	irq_type = ntb->peer_msix ? PCI_IRQ_MSIX : PCI_IRQ_MSI;
>  	ret = pci_epc_raise_irq(epf->epc, epf->func_no, epf->vfunc_no,
> -				PCI_IRQ_MSI, EPF_IRQ_LINK + 1);
> +				irq_type, EPF_IRQ_LINK + 1);
>  	if (ret)
>  		dev_err(&epf->dev, "Failed to raise link event IRQ: %d\n", ret);
>
> @@ -310,6 +315,7 @@ static void epf_ntb_teardown_mw(struct epf_ntb *ntb, u32 mw)
>   */
>  static void epf_ntb_cmd_handler(struct work_struct *work)
>  {
> +	const struct pci_epc_features *epc_features;
>  	struct epf_ntb_ctrl *ctrl;
>  	u32 command, argument;
>  	struct epf_ntb *ntb;
> @@ -342,6 +348,15 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
>
>  	switch (command) {
>  	case COMMAND_CONFIGURE_DOORBELL:
> +		epc_features = pci_epc_get_features(ntb->epf->epc,
> +						    ntb->epf->func_no,
> +						    ntb->epf->vfunc_no);
> +		if (((argument & MSIX_ENABLE) && !epc_features->msix_capable) ||
> +		    (!(argument & MSIX_ENABLE) && !epc_features->msi_capable)) {
> +			ctrl->command_status = COMMAND_STATUS_ERROR;
> +			break;
> +		}
> +		ntb->peer_msix = argument & MSIX_ENABLE;
>  		ctrl->command_status = COMMAND_STATUS_OK;
>  		break;
>  	case COMMAND_TEARDOWN_DOORBELL:
> @@ -483,8 +498,9 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
>   * @ntb: NTB device that facilitates communication between HOST and VHOST
>   *
>   * Allocate the Local Memory mentioned in the above diagram. The size of
> - * CONFIG REGION is sizeof(struct epf_ntb_ctrl) and size of SCRATCHPAD REGION
> - * is obtained from "spad-count" configfs entry.
> + * CONFIG REGION is sizeof(struct epf_ntb_ctrl), plus space for the MSI-X
> + * Table and PBA if supported. The size of SCRATCHPAD REGION is obtained
> + * from "spad-count" configfs entry.
>   *
>   * Returns: Zero for success, or an error code in case of failure
>   */
> @@ -505,6 +521,12 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
>  	spad_count = ntb->spad_count;
>
>  	ctrl_size = ALIGN(sizeof(struct epf_ntb_ctrl), sizeof(u32));
> +	if (epc_features->msix_capable) {
> +		ntb->msix_table_offset = ALIGN(ctrl_size, 8);
> +		ctrl_size = ntb->msix_table_offset +
> +			    ntb->db_count * PCI_MSIX_ENTRY_SIZE +
> +			    BITS_TO_U64(ntb->db_count) * sizeof(u64);
> +	}
>  	spad_size = 2 * spad_count * sizeof(u32);
>
>  	base = pci_epf_alloc_space(epf, ctrl_size + spad_size,
> @@ -573,6 +595,17 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
>  		}
>  	}
>
> +	if (epc_features->msix_capable) {
> +		ret = pci_epc_set_msix(epf->epc, epf->func_no, epf->vfunc_no,
> +				       ntb->db_count,
> +				       ntb->epf_ntb_bar[BAR_CONFIG],
> +				       ntb->msix_table_offset);
> +		if (ret) {
> +			dev_err(dev, "MSI-X configuration failed\n");
> +			return ret;
> +		}
> +	}
> +
>  	return 0;
>  }
>
> @@ -1577,6 +1610,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
>  	struct epf_ntb *ntb = container_of(work, struct epf_ntb, peer_db_work);
>  	struct pci_epf *epf = ntb->epf;
>  	unsigned int budget = VNTB_PEER_DB_WORK_BUDGET;
> +	unsigned int irq_type;
>  	u8 func_no, vfunc_no;
>  	unsigned int db_bit;
>  	u32 interrupt_num;
> @@ -1588,6 +1622,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
>
>  	func_no = epf->func_no;
>  	vfunc_no = epf->vfunc_no;
> +	irq_type = ntb->peer_msix ? PCI_IRQ_MSIX : PCI_IRQ_MSI;
>
>  	/*
>  	 * Drain doorbells from peer_db_pending in snapshots (atomic64_xchg()).
> @@ -1601,7 +1636,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
>
>  		while (db_bits) {
>  			/*
> -			 * pci_epc_raise_irq() for MSI expects a 1-based
> +			 * pci_epc_raise_irq() for MSI/MSI-X expects a 1-based
>  			 * interrupt number. The first usable doorbell starts
>  			 * at EPF_IRQ_DB_START in the legacy slot layout.
>  			 *
> @@ -1621,7 +1656,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
>  			db_bits &= ~BIT_ULL(db_bit);
>
>  			ret = pci_epc_raise_irq(epf->epc, func_no, vfunc_no,
> -						PCI_IRQ_MSI, interrupt_num);
> +						irq_type, interrupt_num);
>  			if (ret)
>  				dev_err(&epf->dev,
>  					"Failed to raise IRQ for interrupt_num %u: %d\n",
> --
> 2.54.0
>
