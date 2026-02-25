Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013063.outbound.protection.outlook.com [52.101.72.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFCD30B52A;
	Wed, 25 Feb 2026 21:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772053334; cv=fail; b=eAbMKMSbL+veIk5d2BQQLQ602Lr/tqGQLU/8QRRkTSf3J+/qP1BDF3NgjEDF1mNh+RppF1pMiWYs84gNrG6ZDhnldaR+sNNyP8SO27EQSl7BPbVtXcNXMsy8bITWgECfVq1FIDS81933gPWKexzITqjFVEXcjopgidvtbB+xj7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772053334; c=relaxed/simple;
	bh=DLvsdT3Panq0S/c7kqqJ2akpqLzEPj87d/+cGNzF2uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l705coN3pS98J0JBPbejDWT//4+d9MlIPdkZGKqOkJAra7g/eTnH3gJb9FX6G+HM5G3a4zIAk1MrUkfRWQi56b/XJZbNdNEc+RYkMomcw4+KzYKnN/vVJAB1XClp9eUG/HBArOqLR8OQAHPpbZ+WspC3Cr7gzyrPKW8tvmJTb1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gigclbaO; arc=fail smtp.client-ip=52.101.72.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gigclbaO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYabZu9KtV0JU5mf/PaALuiwhu18DuimpT70/DKmHSVzhpXCK0WlH33dAx3f8hw1aHlqWErKna1j+Z6NvneuLcGM6BKJmBx1J1GlqjuI2ze0cR1vRBtsxkY4pghk0Gg7196IkLUQ1WoeA53FbqUnf7lNM0dGRJRBkl0dpjV/7a5MZ/q0Y96eiMybjLdfd5qQQCSvBZHcTiQQGr/PyyVRPsTmIjOg2IWTKkz+R/X9DxyeKn8N7iTEsdEcj5ziqGvWjBrVLmqYQeijmNeg5wosVsUIB33cnAZa98CvAGPAtXxBNq0+DwxRDuVNPl+x81ETvs06cxd5sNEYnDMgTEc/Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4kYU0HnlWthMp96qst+zuE85aJpICoql7KJQvhrVYg=;
 b=Ao16x2mfup1MweE+vYKuSnYay7XIAB73bfscAXh/k2BOyCwWs7N+srXX8PpYwpPwNMH1k/w2TbnwwZ2OX4gKnJeIgD+YLklVXgSyiakpC2rMjJfWDpaxeekZjRqD0EVdFHnHxNQxYmpi05o4AbEi8r+l2E6FAXM0asjHue1ZUXVFPERCYIMOJ2cfvQQrP+Xm/CAhRi2Hby6+/uo4IP/bjzmzgAlT4Su3wY/4u++E2DXGqR7bEpZalEGmoHg/3Dz1jFN0fZakwM2GxBko5EPjWbI/vaXNK/e+O7a3gbXAezDExjFNUIqFrDG1YjUHipWlmoM5lKfaw6rtWWhpbRsmcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4kYU0HnlWthMp96qst+zuE85aJpICoql7KJQvhrVYg=;
 b=gigclbaOqdD4VRCKmlRkK/CXdGq6PrzrxHQDtyDGIb81y05Go2flyF7iRsZGxd+ByayJgPa3AZI4fkeBXvv5VxQx4+yskTR4PLVb24IueV0yYAaPhziZ9/VDhhAcv2u1dL8L0mm5U1MrknEck61PHyiUkjcfexVNCZj48i6l9rxIv76rA/59VNiMWmGqT7OPzTV/SGHBWAzYXcRZQ9qVgvt6F8ZKr0a/KRHu2+C19+EM0JeQKLWrdcoHo6UhBXw4m3i4wzffrUaC6FBGfZ6acWENqyjJfFmdTaaxaZs/RimJRrdUprrxDA5wXB9PqTbzrHzn5qIuBpCmILnPCcoLKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA4PR04MB9687.eurprd04.prod.outlook.com (2603:10a6:102:270::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Wed, 25 Feb
 2026 21:02:09 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 21:02:09 +0000
Date: Wed, 25 Feb 2026 16:02:01 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: kishon@kernel.org, jdmason@kudzu.us, mani@kernel.org,
	dave.jiang@intel.com, allenbh@gmail.com, kwilczynski@kernel.org,
	bhelgaas@google.com, jbrunet@baylibre.com, lpieralisi@kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] PCI: endpoint: pci-epf-vntb: Implement
 db_vector_count/mask for doorbells
Message-ID: <aZ9jSS_sWVGnZwb6@lizhi-Precision-Tower-5810>
References: <20260224133459.1741537-1-den@valinux.co.jp>
 <20260224133459.1741537-6-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224133459.1741537-6-den@valinux.co.jp>
X-ClientProxiedBy: PH7PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:510:33d::19) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA4PR04MB9687:EE_
X-MS-Office365-Filtering-Correlation-Id: e4f11536-5247-4597-ff00-08de74b1238f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	vyvMETOW+qd/kcVLUnXqCsAQeVF98V61UFkZSSPs1GK5K+Ahami57az3HbvM6zMSevgyZO9+mMZg5zXSRoWLlQeS+kwR1bspfG2/cZx8PVM6IhjyNiEw9vZdpkcGeBO2cLDGf/wMtcOo4W1ktHbrLmbRdisa7phpblFvsvzoeJ5dchnm6maYbsRbjGxHIC4PKVMs8mIhcFcpUzGaLVQiWRs5U21NRNnIeavpAbqaT0JZR7XlCaS4BBW60nB3QizVP755411rGRWI/ozlsOEdoGord4WRNReWCfLmSbUeQQ6K1v2+UWqlfIUpzIbJUaqdMAlHTxuPYjT9o4TJ1eP/wHf4eUkw+GOLdd2lTPHQ0e4nT04wgW0934dHvwXyNLUYPHpiKYTAMyOWRtUfE3B9CCzphJJ6xS/mII7wzX5yLCZdVQQXccJFc+YZS7KV3N8qiJq5LUwY2ODX5Gdv7hTL4R0Q84qt1CZh3WT5wclnjVOf77hx9m7wTYHtnYSywT16oerDY4/2jE86cLf+Ii2+nxtVOAAk96cDyl+GgqnlM4h3YdvjejIudglv/ukifW3ISaarAiutm1Hm651HK/MuIFlf+XS+iBwzJPCQKuhfGhmkUgXi0pijf3uSR9fCAUUkqq+rbvkm1CW74Zo2Ia/KSvHuUAFRbtkYM7yOd3tHAg7S8TNlh99/OMryOpasjv17guu4rrOM98WeXU/lZpMxHhPZzEkvO28QiU086nvqcYV+QGw79DcNE3VlSZw4C+COEX/BJ/sa9ajpUkK+TQR7PCxCLeSRs7obQ9Kd8Q6M+dw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6hlCMkz+OpJgREDHcHqOXlCOt67b3GSSwK96ysk7SbMyhGVKzlFBY38Kgreu?=
 =?us-ascii?Q?3qLCVU2o566CpbmPbaNdwvTfMDvnLKBkUiXluzr9oFcndv/0y2YV0NY2L33s?=
 =?us-ascii?Q?SU6OV9+GkXkkOyke8V5U/wVmu60NC3AMJSwokEA6vEdJ6EWgkwlFajk8miEO?=
 =?us-ascii?Q?aej/pwFQLyBmamTE8x4qmy3rGCP0WgvTaexTyBlMMD3r32o4PF0fLEwpPjaq?=
 =?us-ascii?Q?ZACxuIHD31sjgSPp5BTwYmwUW6C+h+d1kL5XJXcrHqyACgmfnnndwtgHmd4h?=
 =?us-ascii?Q?FXtdgrDrLY9AqlpyGoVPSIs6EvLJL38kJ0pQKv++RwJE8pDdbBN2WJkcffuu?=
 =?us-ascii?Q?Ko4bk6rvjkkuHCLV0ofSgb4vAOvAveJurVoV2NqjfZfVlroLa/f8AzwWiaEj?=
 =?us-ascii?Q?ambXEmI7KGXnFuoYv+JNWfprw6FYO/m3NC94/IoxGOmoqpX/+zZQ7OrojLiX?=
 =?us-ascii?Q?81TVCd5mdR3zARxV+bK7KqaAM3tEh4trFA/UyYqm1IaTKjrjf7CkIHYlU0aw?=
 =?us-ascii?Q?zllvAGAoOtHNCEWp8adEVK1yN61Oh+UNywCTEVmhByY9kwSLAK1MZiPwX91R?=
 =?us-ascii?Q?mPz/WBBze5PqB8PRhBMpJ52VS4JMNCeyIC7eWqOOoZ/ZHuw609i5BF7krOWd?=
 =?us-ascii?Q?oCdNxPXnKe4ArZcNqUMpCcqkG5wwSuiW24L/UP3u+RsRYtHp/P62szXhj3BE?=
 =?us-ascii?Q?Jes9GYdYu9E6b0qPrmUEzH39uAhcRG2d3PCNOXUJnTl8WjcYIYONJAsNrfQb?=
 =?us-ascii?Q?+6s/T5bwvp6spGOtVynX2SCotB6xLgw6I4KTWroxxsJa4N0pGAcf/8qz+ruu?=
 =?us-ascii?Q?DtHOyOmfn3jXj4heDMvj4bp9Y6gz6pq8Kb9x5ftwXFxrw9Jh6ecLm56E9408?=
 =?us-ascii?Q?y1T9qTleRH6AbttkRPfn5hRqAbs3zBqJBO6tOXYJCdVKm6ps0q9agiqRXjVV?=
 =?us-ascii?Q?ynXxqCASmX3MAbQMJoCJTkTFlA6tfHPVVHKeW40SLMizWPU/Gh8uNzmlVa4F?=
 =?us-ascii?Q?VVtpL153qHqNk+AwJo3fC1RbiD+pnY1CB0kI9kUW0B01AvgeLi33d0aPYMTL?=
 =?us-ascii?Q?vIUsNNSd32bUpB0OOxUIrG2vVZJQi5bp5aijETHulQnG+jwbC9637vgMAonH?=
 =?us-ascii?Q?xs4IV3fx+0qzAg/VLfrHMlYgxpB5NOp8BmMTssn+FikTxK7mHamS+YbKiUVV?=
 =?us-ascii?Q?qIwQrt8lqsE9kea+M2vvybR+gnmdDubz3LAGqFI3hXzkWdtFEbBmVmUt/HnG?=
 =?us-ascii?Q?X06NV2vjQqJ5rDLqcWaRnEoqjbDkTZQumqv14vn/lyjvK9Lq9Tcf/SYSsq+y?=
 =?us-ascii?Q?B75TpUddqo5/NB9PDhqWdH00b1sbOEbWLlQj9RJvtBvDUPfKRfKEz2hxVA9b?=
 =?us-ascii?Q?0JTSDMAQK64B8MSe4S2NJeUPbBgQfrkl28jeEWHe+QjN+Ib2GWTPpmSXHTIq?=
 =?us-ascii?Q?g6q2bbb+NsOzBpr6+eLMxxWQcDqBSnk65NVvBKGuBhgkWEk6L4VYOqSeNVeO?=
 =?us-ascii?Q?o02u5ElSB+kM9GacNnwnP+z6B9uku+dmOwKSl/wXmEVfnCrSF5rT4IW/MNg9?=
 =?us-ascii?Q?pZZvIYk5kuKbrjteiCo9QZYlZSfxSSbEyz2byTSwwXc/SAFbZAoJTlMHUxyQ?=
 =?us-ascii?Q?obUjEqe+vIcUY15Xm9Jl5NZcIuXSnxV2y03LxA5qNKR/CnhKM/GXZlMk9PQ+?=
 =?us-ascii?Q?SW6PCEttMjddLiLIbijn5KMH8SDMTsjXJWDsfI1EcbpL3x9R?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f11536-5247-4597-ff00-08de74b1238f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 21:02:08.9853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e36z6xSK1Ig/qpncfESuJYq/LCM6F7quvfn0H0Y5X+4/RqUhmG1KnwVUtQaznGkvLDvLECgXP2SAo9H2+UvOtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9687

On Tue, Feb 24, 2026 at 10:34:54PM +0900, Koichiro Den wrote:
> Implement .db_vector_count and .db_vector_mask so ntb core/clients can map
> doorbell events to per-vector work and avoid the thundering-herd behavior.
>
> pci-epf-vntb reserves two slots in db_count: slot 0 for link events and
> slot 1 which is historically unused. Therefore the number of doorbell
> vectors is (db_count - 2).
>
> Report vectors as 0..N-1 and return BIT_ULL(db_vector) for the
> corresponding doorbell bit. While at it, use vntb_epf_db_vector_mask()
> to simplify vntb_epf_db_valid_mask().
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 36 +++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 2eb3db035644..b651c54d6bef 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1267,12 +1267,42 @@ static int vntb_epf_peer_mw_count(struct ntb_dev *ntb)
>  	return ntb_ndev(ntb)->num_mws;
>  }
>
> +static int vntb_epf_db_vector_count(struct ntb_dev *ntb)
> +{
> +	struct epf_ntb *ndev = ntb_ndev(ntb);
> +
> +	/*
> +	 * ndev->db_count is the total number of doorbell slots exposed to
> +	 * the peer, including:
> +	 *   - slot #0 reserved for link events
> +	 *   - slot #1 historically unused (kept for protocol compatibility)
> +	 *
> +	 * Report only usable per-vector doorbell interrupts.
> +	 */
> +	if (ndev->db_count < 2)
> +		return 0;
> +
> +	return ndev->db_count - 2;

return max(ndev->db_count - 2, 0);

Frank
> +}
> +
>  static u64 vntb_epf_db_valid_mask(struct ntb_dev *ntb)
>  {
> -	if (ntb_ndev(ntb)->db_count < 2)
> +	return BIT_ULL(vntb_epf_db_vector_count(ntb)) - 1;
> +}
> +
> +static u64 vntb_epf_db_vector_mask(struct ntb_dev *ntb, int db_vector)
> +{
> +	int nr_vec;
> +
> +	/*
> +	 * Doorbell vectors are numbered [0 .. nr_vec - 1], where nr_vec
> +	 * excludes the two reserved slots described above.
> +	 */
> +	nr_vec = vntb_epf_db_vector_count(ntb);
> +	if (db_vector < 0 || db_vector >= nr_vec)
>  		return 0;
>
> -	return BIT_ULL(ntb_ndev(ntb)->db_count - 2) - 1;
> +	return BIT_ULL(db_vector);
>  }
>
>  static int vntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
> @@ -1512,6 +1542,8 @@ static const struct ntb_dev_ops vntb_epf_ops = {
>  	.spad_count		= vntb_epf_spad_count,
>  	.peer_mw_count		= vntb_epf_peer_mw_count,
>  	.db_valid_mask		= vntb_epf_db_valid_mask,
> +	.db_vector_count	= vntb_epf_db_vector_count,
> +	.db_vector_mask		= vntb_epf_db_vector_mask,
>  	.db_set_mask		= vntb_epf_db_set_mask,
>  	.mw_set_trans		= vntb_epf_mw_set_trans,
>  	.mw_clear_trans		= vntb_epf_mw_clear_trans,
> --
> 2.51.0
>
