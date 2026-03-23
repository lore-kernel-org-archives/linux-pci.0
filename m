Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011057.outbound.protection.outlook.com [52.101.65.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258512E7631;
	Mon, 23 Mar 2026 18:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291321; cv=fail; b=bbjB627GQfaEQLiEU0xFcABw9SpEdCf4caxGmHCiAYJ+A2nIY08lVcum6ENC1Lie0Pk6JMd4NqU0pmExwvnekLHyEnSJWf2Za6imZQPV6yEtMnFY3PmImrLl2HAEu79PHCTi+EjiC9oD7JfHaT8efldJAEwpjQ8y4dzpgu7Opq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291321; c=relaxed/simple;
	bh=466p/v86vuhsXDQJ7Iq6usHmcAxHV66rivXuGEZ9Ybc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Aqca+urfbpFCkIWbLwcsKGQsSkgZwbRUADE1FxEirVVYLa0sOqRkEsVZeNQs05LjkhBAr6TVQGCiuTAPTvAhjvgI3UIMlt75yB8qGfweOWBpa2iO86agVrhT7D0O8ikcPO04ygXBTeJD72l/uOFFZzv2PcAoWLUILlhas64JiiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Cu9T3mn+; arc=fail smtp.client-ip=52.101.65.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cu9T3mn+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQzheZ8IkqY2K4Gzr6G9EuNJTfVjyegfO4ObOqaXi18zf4DG1VruguahcjNHXfyHWyqd87RIAcA2Xdq5kYZqKu7AcaRV4c8BWQ3cC5VSrypScXrKnsN6RokcSR5JflKW3K/fG2budF3FXYPYOaz58IrmX2/fGjc6473Onfvx+AgglwhZNWHE99wObp1PdoQ8Lp/Wgop6WgPPgMINqEIK4h0cU9T0Yy5b/3qB0aWWn5LxAF9L57OVu2UBFeXXcPGdMH8VPsoz+CbwDXQWdUtrGA9hcPbzA/JpNHUDxwyIUgUgdTIxFxWiTVu7YOXngG4uXhlv3RLXDrz+413OYIunLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7scwOUwC899ZwMwYPTfXllibwpKq8BGnJ85N5Dlot4A=;
 b=H+AQrnRKqDtyWU2ty3Hv8H5WGi6GxEQ5X6xFUcoOQ3NqhOISypXhEeMctCdj3Q5CT6vA0PaFWf/Hek1wNj2SEw0JsFZ0bD2vZvP55vdPx/YOFnTd+tqKE2w/eQD1jKwS5nTGINqFkHMjk9WDRrdQlpcN3wiG2gmp+bCGsRdKPEZ/I+fv6YYbWZ4pgdQ55MxpkNNYkMb0rBbl1mqiJrlu96KOmpqN8GnkE+IHK+ub3ufSZZwtC/Ox/pgFCCAVUzUzkkDGmUfWzqRx8L8aIk5dciAy7KESGnSrq5crUQJ6qLD0lPdJrKJZQdCYAJ+DZVdqK3+m0Zwev6KsJPU2V/YLTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7scwOUwC899ZwMwYPTfXllibwpKq8BGnJ85N5Dlot4A=;
 b=Cu9T3mn+WtRAgbTQTPv2gy1N273fm9Yal/ds/cUKznLX2L1EU2TCKD6Mq/2vhsIlLOV7uTJV+7Z/FmgwZkz5wkeVQJEmmW9jmhUOREwmo0RitC1Wsg4tR4QysYgHC9KMTAUNyIKpCFMVfdMh6PhdVlEIWdd6tY6Ng6cUwMMD6nCnbhkU8I17PTZLlZXPEfRIyHtcgrhHdK95djTWucaaEh927JM4LqKNvkH9HQFLxrxJ+9bIqghuYBqS2Slc0JtWpelufKS5SvL5myGFTfX58DtJrt5EgRrI0LNWHz2R9nqTgIDBgPrMmJJ5PoWOF9cOf2t6eAulAjcRI8r+HOewog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS4PR04MB9242.eurprd04.prod.outlook.com (2603:10a6:20b:4ca::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 18:41:52 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 18:41:50 +0000
Date: Mon, 23 Mar 2026 14:41:41 -0400
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
Subject: Re: [PATCH v10 6/7] PCI: endpoint: pci-epf-test: Reuse pre-exposed
 doorbell targets
Message-ID: <acGJZZzK241BHZMb@lizhi-Precision-Tower-5810>
References: <20260302071427.534158-1-den@valinux.co.jp>
 <20260302071427.534158-7-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302071427.534158-7-den@valinux.co.jp>
X-ClientProxiedBy: SA0PR12CA0014.namprd12.prod.outlook.com
 (2603:10b6:806:6f::19) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS4PR04MB9242:EE_
X-MS-Office365-Filtering-Correlation-Id: 8684fb53-e636-4f48-bcbe-08de890bd8ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|52116014|376014|38350700014|7053199007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	i68VqiN6DnSl5k5hVC/jyP6KWgqiTYK6Y0Hudrwls0t71b5rDARD/k3P/U2ON/WYYPHvSqAo+qtHi9gmIcpMc+0NYms6Ih43b5KJLHmbxjDGcxDMA/SayVY34TbYUDeKtaZw+dKN0aus3JBZD4o0XOyljlivWWGZw6xNBKo8EY8LSCC/noBIvq3qTTMpShKooh7RrwtlDs6W5k+QivIKEFy38gNW54jM9ru7tkMUkU4U8vdue+FtJHoqYzhJTErLWriEgbbcgwv4xRlLc2f40dU77jwGotgcjFknfbVoqplTDQivEmdqCw0fVGuVg4rmMxWjf+JPQhJf+YDKfmHF0P/WnNf4yGG6xMXrWwU3vIeYGGQCRPpc1458jsaAmH6qvK4iT3O62YWKfdN4CCzOR4wp5pKjq/pmLj6Kso16ixck6Jt7CVAJvnps02SIAfTybVoV/VJ6k0cOnm7wWO6XVfrTZzyGLjQBrT+avYJAV2gv7k1POP+T7IJR5R8lqyGPHLhQAUy40xmocnbLWDciRhYoDXoRoIVLSUE+MgX/RgVZu1iNilz6hXynhKJ8S/zA3Y+35Dc2UGmWclSY/Qg68v6Dmbk31WqYZS9f6PCy6Mtla94FVxrnA2Ka9H6Aj9oziEj/LXaMTL6BWOD5RFpOAk6zVKQwA9OAE2moq14nOcvSqzY/BzMgTNsxdulCxfwouxgRPI/RWB2JjgqHicgIKakF+/lOklJIs/5ZgkTnVECNJWrWLeGCg2w6gdnLUDQ5s3JEbo/fqQEIVSx0GrUL0UO46O2Op3+1Lx9nKkZnwII=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014)(7053199007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tDzTuf7k37g2LiKdyiN9341p2ATOGpa8B3oZoiNNxMl/SmtZnjeqzLNU2lT4?=
 =?us-ascii?Q?Fw6AgGsakeK9eS6I+PYENd7Oiv76xr/9PvHn/7ZWnV1uva70CAJntBsKLSfh?=
 =?us-ascii?Q?b+P3eSVKIcJnZAY3ZgRuUr0oswuCeqm3waX+RRK2GiAFhuk7x04+ivTCF8Bb?=
 =?us-ascii?Q?VKiRjPAv2UyLV2GcSnpefhVDrNFX+02VpgxbcolR34saQC4rJipAMw3tX06J?=
 =?us-ascii?Q?wythTuzH552XWmg4rWfzxPb9ogwHe/OVaqOamRUVtjXj0gClzDxZ9IIrhuhq?=
 =?us-ascii?Q?fBR876YH2l+YYxGh/mieLL9iqVj1DJHpyancHymHrIrGWkhSQisBuVPVAyWX?=
 =?us-ascii?Q?Mdxj4T30UxvOFncUzsj0W5yz88JS4lxu/4cKe/YmURAjPdBI6u2H/QGH86c5?=
 =?us-ascii?Q?92gz8nucGNHVxYyTm1GMYju0uZUex6qnI1XLpZrTfJtWcZKkDs2Ritrv5NxC?=
 =?us-ascii?Q?MqDnt/1Ppz2UsrQotrbuUERS/DmHdkpYHzl699IJS4zOUL3jmeOBADq8jiLA?=
 =?us-ascii?Q?Bm/1jnzRUbe8crRFm7pgwklJWuV2sPcGU4/Y0Rivb19VYhNg5Upu6qvhIqpC?=
 =?us-ascii?Q?0m6MRf64Tvd0ybwiqGjMDqDqGCUQdLdOY3z92xGoEI6g1X49TaTPj6YxX5sR?=
 =?us-ascii?Q?6fHIH8eMhRKM2j3EHAVrXV/0+r7LJMJQt5wMJNz7MLoAoe8D470ukebA0iMn?=
 =?us-ascii?Q?P565lR9MzJlksWbxxtu9ixkDArJIdtyEsx70MIYmmsFIV/K/sf8sKDxMq4pm?=
 =?us-ascii?Q?1G//9crkThFu/8mJssPb2KwWVYJrfd0a8wKX6jsVNv2C1bAfYzwB5iS+0zht?=
 =?us-ascii?Q?Eg80vQofuN4lQGv+SPOvHuqqnBGLbbacgCUiaq4+AROGojvEZq85xDzcpxmL?=
 =?us-ascii?Q?qP5xzUKP0fc8Eo47ZSNz2oKsjABMr0ZHh0fy1/BRpeCe7k6ySWIIOLyjQ2uS?=
 =?us-ascii?Q?j0v/UW2wy3rbOJhNWGUQLve3h3yY/qrlGCOPJM8m7XdmX94Ofizh++Li/HbF?=
 =?us-ascii?Q?LOfybnnb8WnHyQBbLiJmrgqF/my4pfEErkaP8l+rOOJvDXRpIFHi6NI9Xkvt?=
 =?us-ascii?Q?AzuOD99ca7IrQn8790fdWuJU+Z01zD7wdr72XX25gRZNa7/dbw7FibZl98ZT?=
 =?us-ascii?Q?ua+c5Sp58//3h3eQlhoMUn+JCU3gp9nr57O8Pi0c2xhVZB9c6opsYDW2B9PP?=
 =?us-ascii?Q?SOoZ4ieZnkBWzapCLtEErmxytG2noawFlBN6XqF95hNZy/rXn4L1XxXLpfit?=
 =?us-ascii?Q?Wr99UTJQNuqciF/D1YC1xsLDXuY8BQ6rWnPDkcFJIOlf2ytAgE/dPINGBUdn?=
 =?us-ascii?Q?o6cZxqvR4gErqHFZHnGxea8+8VWC2f669ukvKaR8k0O82Ke/nKxqeAbMjZiA?=
 =?us-ascii?Q?8gC6f3JQhEtyo4W5Zjy1fDi9lq3aeAL/1BwRdOJPXRBrRRZdfDSGMC0UlhuC?=
 =?us-ascii?Q?0tFTJnszo58+oV+GRhyRZXVCsRc5kuaXV8UpPiPWx+IMwUYnRe73SX1iYLcl?=
 =?us-ascii?Q?Xk5yUBVGQpCq8OxrIEErgSkB596yLOMbvE57oobNuFTLxrpEdjVvpfLqLP1b?=
 =?us-ascii?Q?wUrfuv1NKZTWD8uGen8GBBsF+E3fuFFb8vi8ciuhu6A9tDlJwKUMNaPfEVxw?=
 =?us-ascii?Q?AruU/UARCQsqAHdL4ox3au4KLLyYjQxXeXNIsSHHtB+/UUc9aPPPB26erDXn?=
 =?us-ascii?Q?AAbH9dF7d0b7Ps6zCi0YL3641OVp0Pk5ko/CPktUY/3Vwgca?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8684fb53-e636-4f48-bcbe-08de890bd8ab
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 18:41:50.7562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9Mbdw+ZGM5TmAjq8uPx0jDe35T9L3tEnbuYFHFenAQDkeYdZALZcNg0vkSItTdm0q6JjDTRZnTMDA4/+OkXuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9242

On Mon, Mar 02, 2026 at 04:14:26PM +0900, Koichiro Den wrote:
> pci-epf-test advertises the doorbell target to the RC as a BAR number
> and an offset, and the RC rings the doorbell with a single DWORD MMIO
> write.
>
> Some doorbell backends may report that the doorbell target is already
> exposed via a platform-owned fixed BAR (db_msg[0].bar/offset). In that
> case, reuse the pre-exposed window and do not reprogram the BAR with
> pci_epc_set_bar().
>
> Also honor db_msg[0].irq_flags when requesting the doorbell IRQ, and
> only restore the original BAR mapping on disable if pci-epf-test
> programmed it.
>
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/endpoint/functions/pci-epf-test.c | 84 +++++++++++++------
>  1 file changed, 57 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 14e61ebe1f11..b6c865b0883d 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -93,6 +93,7 @@ struct pci_epf_test {
>  	bool			dma_private;
>  	const struct pci_epc_features *epc_features;
>  	struct pci_epf_bar	db_bar;
> +	bool			db_bar_programmed;
>  	size_t			bar_size[PCI_STD_NUM_BARS];
>  };
>
> @@ -732,7 +733,9 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
>  {
>  	u32 status = le32_to_cpu(reg->status);
>  	struct pci_epf *epf = epf_test->epf;
> +	struct pci_epf_doorbell_msg *db;
>  	struct pci_epc *epc = epf->epc;
> +	unsigned long irq_flags;
>  	struct msi_msg *msg;
>  	enum pci_barno bar;
>  	size_t offset;
> @@ -742,13 +745,28 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
>  	if (ret)
>  		goto set_status_err;
>
> -	msg = &epf->db_msg[0].msg;
> -	bar = pci_epc_get_next_free_bar(epf_test->epc_features, epf_test->test_reg_bar + 1);
> -	if (bar < BAR_0)
> -		goto err_doorbell_cleanup;
> +	db = &epf->db_msg[0];
> +	msg = &db->msg;
> +	epf_test->db_bar_programmed = false;
> +
> +	if (db->bar != NO_BAR) {
> +		/*
> +		 * The doorbell target is already exposed via a platform-owned
> +		 * fixed BAR
> +		 */
> +		bar = db->bar;
> +		offset = db->offset;
> +	} else {
> +		bar = pci_epc_get_next_free_bar(epf_test->epc_features,
> +						epf_test->test_reg_bar + 1);
> +		if (bar < BAR_0)
> +			goto err_doorbell_cleanup;
> +	}
> +
> +	irq_flags = epf->db_msg[0].irq_flags | IRQF_ONESHOT;
>
>  	ret = request_threaded_irq(epf->db_msg[0].virq, NULL,
> -				   pci_epf_test_doorbell_handler, IRQF_ONESHOT,
> +				   pci_epf_test_doorbell_handler, irq_flags,
>  				   "pci-ep-test-doorbell", epf_test);
>  	if (ret) {
>  		dev_err(&epf->dev,
> @@ -760,22 +778,30 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
>  	reg->doorbell_data = cpu_to_le32(msg->data);
>  	reg->doorbell_bar = cpu_to_le32(bar);
>
> -	msg = &epf->db_msg[0].msg;
> -	ret = pci_epf_align_inbound_addr(epf, bar, ((u64)msg->address_hi << 32) | msg->address_lo,
> -					 &epf_test->db_bar.phys_addr, &offset);
> +	if (db->bar == NO_BAR) {
> +		ret = pci_epf_align_inbound_addr(epf, bar,
> +						 ((u64)msg->address_hi << 32) |
> +						 msg->address_lo,
> +						 &epf_test->db_bar.phys_addr,
> +						 &offset);
>
> -	if (ret)
> -		goto err_free_irq;
> +		if (ret)
> +			goto err_free_irq;
> +	}
>
>  	reg->doorbell_offset = cpu_to_le32(offset);
>
> -	epf_test->db_bar.barno = bar;
> -	epf_test->db_bar.size = epf->bar[bar].size;
> -	epf_test->db_bar.flags = epf->bar[bar].flags;
> +	if (db->bar == NO_BAR) {
> +		epf_test->db_bar.barno = bar;
> +		epf_test->db_bar.size = epf->bar[bar].size;
> +		epf_test->db_bar.flags = epf->bar[bar].flags;
>
> -	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf_test->db_bar);
> -	if (ret)
> -		goto err_free_irq;
> +		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf_test->db_bar);
> +		if (ret)
> +			goto err_free_irq;
> +
> +		epf_test->db_bar_programmed = true;
> +	}
>
>  	status |= STATUS_DOORBELL_ENABLE_SUCCESS;
>  	reg->status = cpu_to_le32(status);
> @@ -805,17 +831,21 @@ static void pci_epf_test_disable_doorbell(struct pci_epf_test *epf_test,
>  	free_irq(epf->db_msg[0].virq, epf_test);
>  	pci_epf_test_doorbell_cleanup(epf_test);
>
> -	/*
> -	 * The doorbell feature temporarily overrides the inbound translation
> -	 * to point to the address stored in epf_test->db_bar.phys_addr, i.e.,
> -	 * it calls set_bar() twice without ever calling clear_bar(), as
> -	 * calling clear_bar() would clear the BAR's PCI address assigned by
> -	 * the host. Thus, when disabling the doorbell, restore the inbound
> -	 * translation to point to the memory allocated for the BAR.
> -	 */
> -	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
> -	if (ret)
> -		goto set_status_err;
> +	if (epf_test->db_bar_programmed) {
> +		/*
> +		 * The doorbell feature temporarily overrides the inbound translation
> +		 * to point to the address stored in epf_test->db_bar.phys_addr, i.e.,
> +		 * it calls set_bar() twice without ever calling clear_bar(), as
> +		 * calling clear_bar() would clear the BAR's PCI address assigned by
> +		 * the host. Thus, when disabling the doorbell, restore the inbound
> +		 * translation to point to the memory allocated for the BAR.
> +		 */
> +		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
> +		if (ret)
> +			goto set_status_err;
> +
> +		epf_test->db_bar_programmed = false;
> +	}
>
>  	status |= STATUS_DOORBELL_DISABLE_SUCCESS;
>  	reg->status = cpu_to_le32(status);
> --
> 2.51.0
>
