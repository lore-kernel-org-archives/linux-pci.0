Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792596772;
	b=Ur+d+aCiZx3wGT/yea+CjMhuX7XSVJwYpCFlkIlOoMmh7qX1nwmvKWYA7E9wMMdfxeOk
	 f0v3j9vYPlUeaf+N0qt42vPWVm5o6jMqKJ64K0F19OQxqIKOegUnqO3Yb4zqP4EfuYVHu
	 3yfcaBIJ45CoUvQMf469UxSJ/Jg97nS+YpzVseGbGx5YnB3jKvMMUnErEBSKVEpwChDXs
	 qTrmBQ2z4eWBW3bpLjD+INKjEaftEWePuSJkx+PWfp66hUC3w1fcFNRxlSPODCH/SD0z1
	 Vg8MsXIRkVhAXjkBlddWxbdla4tdZWAyq5znOKHZwaGkwhNiwnHsp/79k7+mO+LKi6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596772;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=0YYGFMx/1+AR/LiHb4XsKsFjLkSDJbybkshUHOyJtTA=;
	b=eNPqRjCXaerNkS0LFXp5PtAK3haU/ef/onKONG2p93MIA2pzsnX0nzLoK8WTzLSIyusF
	 JVAKtlXI0GdCdYKvvyQQRoDRY760lUXQlRmll/N8yZ7hi8/XXcHer4uMQprpvnj1ggB38
	 H0Pj6/allEl2Pz7kYyJtf+kwOH87xtRWeZZta6OXVkiqukQcAN5Z3kfKuO/n/k99vuz0j
	 eD/S3rzTPR8glaIRJ+YjKELCoRRUyq1fUyRAiPeWU961qKHKtqN60eQo7y7oLQZ6JPdmp
	 pRh4NWTy/kPnr4V0ClsplIw4GQUj0auO22W7/mmnhW0w0+GBwUer5jUHbjZHoPbRDXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=NEocfq1U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.57
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013057.outbound.protection.outlook.com [52.101.83.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56967606A319;
	Wed, 21 Oct 2026 15:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56967606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=NEocfq1U
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRDU4M8ciZZIxByvu2chcJtBwIGNynhbNJckw/0KDxDy+haadqO+CJjUW3iB+mhnoykjffQ8ytPifTtcn2rfoXQYH1HQho/7WFwhAgFyja4c/g+g6sU4RQ6sZrBnrZjFAhJ1hmeQc13wbeIRSzGrEq4g0pzrNHHra/PMmAQcz6ahRwshG/8+rldjMUWrntylx0KwdHTeLO12RAd01t7cQt4RqGj0M2MzvIMleJZb5FY62AbARJTNJhYl+06UP0t9euXbWGgN0q/yv3AskXSMEClEOBKC9THkoXDFBmBPBfw7UxCpejpUqtHq7rIVylFD/2Ou1aipdzODGDktkf+zhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YYGFMx/1+AR/LiHb4XsKsFjLkSDJbybkshUHOyJtTA=;
 b=xGFDyPoSBrrWSNhYFVqNK09SGwgOyyIaM0EvBPkRAgfWc++zrd9X51eAmK+iXWTpmiGvG46ci6G32C9TDEQ2ZUZwrWVM0nT5B/ihQ4HRNZlReh8XN2/87Hkc2Q4XZHD8GDuuy4VUuuCOyfXIYfqh0wGIEv00GNhoJvJIdi0kGxUrnqu5gqbJQmN6nw5+YLmPC0GgaSSfAc2BrSwmJF0I4nMNS6sT9kEOIj0iskxLro4yNuwX2G8mXl8XutJ3qGMcKoXslzCIaJ4SrM9UuQgnTNlV4og7DJzKJxyZy8qW2cUaRyslI6VoLcalwGFmVHLdAptsUlvopEY1CS6PuOX9zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YYGFMx/1+AR/LiHb4XsKsFjLkSDJbybkshUHOyJtTA=;
 b=NEocfq1UMpBzJi4bOoaFzP69dzLAa5ElMU8+lnhsegjOODXOWyYDzSINYYBalTPsK9stwEkJROOP3Z6rxfg450BKrQsdCOf29w02tD7tWpe/RqXTR7W2jjqvR3rZqtOwPzJYMiUAQ4FQIualjxUqlPmE7nv0NgSoKTJAwiBbbPn1GFwS0S5XvNkt7vZ5S2Fgx+v4aq3ZzTUQ9LqmXEq4Im5gaFw03nhA9pbLIRiuaaooEb7Yfm0KHn7qI1Q8Gw7E0ur1G6TEIAnoL86rnFAOCVMktjw+ur1ENsglVBaJEjm1X7KEDoj/Uoo7iwZ1zBzLv1+MHphSxdH+SyaFM+zjrw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GV1PR04MB10106.eurprd04.prod.outlook.com (2603:10a6:150:17d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 15:32:46 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 15:32:46 +0000
Date: Wed, 21 Oct 2026 10:32:35 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org, robh@kernel.org,
	thierry.reding@kernel.org, jonathanh@nvidia.com, kishon@kernel.org,
	Frank.Li@kernel.org, vidyas@nvidia.com, cassel@kernel.org,
	den@valinux.co.jp, marco.crivellari@suse.com,
	andriy.shevchenko@linux.intel.com, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/10] PCI: tegra194: Always disable Tegra234 Endpoint
 L1.2
Message-ID: <atjbE76vkyjPVPdm@SMW015318>
References: <20261021061349.1265704-1-mmaddireddy@nvidia.com>
 <20261021061349.1265704-8-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021061349.1265704-8-mmaddireddy@nvidia.com>
X-ClientProxiedBy: PH8PR21CA0005.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::21) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GV1PR04MB10106:EE_
X-MS-Office365-Filtering-Correlation-Id: f491be48-c29b-4fa1-5933-08df2f888e50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|19092799006|23010399003|1800799024|4143699003|11063799006|56012099006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	UXqj31YgW8PqZ+8aIRR/SJOTzpjdE2dRermHhGqrWcObwIwcBpgUC7iTFVZNvkzYGSbxvkY8jqGyNkMMyk8TwO9Z/O1NHBxTSGyYRtoTQZDeh74AqBl6RD9BvGLZyP68241jir4YQVR/5HM9gYM/eNHDNdZ3rpMdzcLzGwbMdVbR5y2xl6sc+GY4a3fP21DeplXNnGyUQTdkqBz5Rk6BWD67uwTyZ5JKWpmgYHvVPaE4EKqHso1T/8/XMDqQbsa6M2itdT7KNgO/8XY2+vVw2GARNKHcY+R5HdTM7S5RdO2SVsLIOaQnep8x2a0baBhv6mzQ1aHCAk695GdoaTxVF+UoOcFYyVSAOta1kTmALc16WXjm0cQBkFtfUMJsbytxWX1g7fE4xvBmyGe0QHaLcv9Cg0DyzJJteOPkBQs/DQmOnGtie4ePrBuYnqGv9OIOhFgahQeY3rtRRDwVrcdoTjzbmIyF8vm9U6rraOla/zXmkX93FXE+qE4/n+Tn+uFOaUyHMVV8/vwhQxetY+k4n79DDalpr983cLVEu6gRHkJCRXXHOUEskZQZWAs3oO5uXxEpxZvnZJGqp0CM95/s2w5bFZFN7yVJTbxkjwKFFfpbVyJnyDt4W7eW6QxfbqxGrsuPml7S3s/w3KNap2uutk1vmHNqu1BN3Q+TtxqX0Hw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(19092799006)(23010399003)(1800799024)(4143699003)(11063799006)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3VlMji8t3V+x90XfvRkEGxyATWdY3VELNHBSRL69jODjHkBS2aa4XS0o/1Te?=
 =?us-ascii?Q?vS4mI7+ULjsulD/mnVQL44odP4GKzmphedcaGICEW2X1AY600YeIBVV0nL13?=
 =?us-ascii?Q?GWIDm+7z4iItSUx6SU1IsvEJ37n9bbnlzPmTP8Obk0CfISv5fc7puxAhz6Lt?=
 =?us-ascii?Q?0Pqt7raDFwA01fQ+Gs3BLYzrTtFo118bZhKJMi77Nr6IX8rSRYVGyw9PZcgX?=
 =?us-ascii?Q?CesBOhwYxTJcPolIcTsWsI63s3JYjTl2cqUv07jKYgnlIO3NIV8wzNTRBzJo?=
 =?us-ascii?Q?BhpAqyasyCCxZobpPwpfHBkfLfInN1u+EjN/YkpgG0Krd+WvD1PMDFPR53St?=
 =?us-ascii?Q?yzZUTmpReklThZVagXgh7nnqFqFVIOk6x1hezCERy4d0IVfG47oTIbxqtuKk?=
 =?us-ascii?Q?YZxzH0sXVJGOdjRJX7q0YIRme9Oa3qwoXQjOBlWcyK7WaFcDOHp4M3ASixab?=
 =?us-ascii?Q?C1nXn+SJgecNJGr2JgAjPTfsw14KbTXb3seZYJkis/iWFgY+eHrJb6xtX6zr?=
 =?us-ascii?Q?lFsqQxjUvw/lKnyhoCJQdFQSGtGJciQ5PiYWHXV4d6seQaY1uIB6ZGNrXtwq?=
 =?us-ascii?Q?13yKG00daR/3JdWTgjhgaEueWqOYBTnlw674TSIjje0K40/K6z1PUJ25nhmN?=
 =?us-ascii?Q?XPGGUFqh7s91h+8D98I7IWB4ihmuDUFqUlC5Fih3jAgt4f5M2Z8eT6qpRaEP?=
 =?us-ascii?Q?BhmcrIZ+xnWZbjLeeLEqS3OmCt7wgPiSHauSmRRzJcAQPybBzG9RZDE56ruU?=
 =?us-ascii?Q?pfzmA7vL8A/bkpbemEV3FdTeSS82daX+a35tTc1ybAf1I8MgyfcwdOOIRDfq?=
 =?us-ascii?Q?HaJYoa6AyERj915OUtKCkZVJ622k8VvHti1EgtvB8eyIhTm5bZvJU1Zo9C5L?=
 =?us-ascii?Q?5Zn7ZPTIEYdkKqPExlD1TTItDC3Rl+GMhirBhuPUVGnwia0UWGe4MILRcZo8?=
 =?us-ascii?Q?89UE0AlSw4RUohJdTFueZcy6gLRYB1eC/T3dVi4CmnMDcMQz1OerNonjSzOP?=
 =?us-ascii?Q?m22McBfJLBy7XH5XZLgFQ8PhSS1dU/4ZEh9/4MAVvIjFdPGVjvDJLJwjUE3V?=
 =?us-ascii?Q?EKurjVPZHSXqMecjHGwgG7V26zHHHfS6nJ8uu0dhgDcIxT92dv/j6t3N4m+y?=
 =?us-ascii?Q?bqkRmfqBIW8PvcDzb4hcr6QcWZa6TDsXpKcU68F9IqKWcU7KxR2gXgmQw/sk?=
 =?us-ascii?Q?OXZRd7X0PqN+1YpHQcTEZjzLwim3cMlVM+katEYLrWT7YeUyBQjTimPa1+cj?=
 =?us-ascii?Q?fwIUKqiUzXUdzMZJm+z/eWofxcfVku6S2fugQlOXA5zF20oUikjQNYKWsUnl?=
 =?us-ascii?Q?/LAfDUEyVrLVfF6X2DbT2hKy7pN577+scIw/+++IhvcPsoHrwR9ideyBw0+h?=
 =?us-ascii?Q?dRuEU5Ev+kg9vbtsuMz8mhYfINQ+lmmwLyGtDOq2rmEHwRcRLwoaeibyEJ3n?=
 =?us-ascii?Q?79UrrXauA5/QZWDnMe/QC3a0tz4GnPb6tuUmJX6abZZ4k8V2dIn0G7PqwvLt?=
 =?us-ascii?Q?CDhy4kkknp7rleilAjddZIbakdwz8wXEUXuMa+ctR6Q2kONaI6Y6NzTsjTeY?=
 =?us-ascii?Q?nIkB+DuwGZmH4Wh6lAZPlAdUU3jc1G6M7G9QsrCePuhnneNsbvFBC3cLhrTw?=
 =?us-ascii?Q?eXULnXYnqxuJsz33baavB2Om2o93fBeRnB8JjFX5OlSvQdYnkQJ8bxGvjfqw?=
 =?us-ascii?Q?5AyyD8UhU+SpZD63PthZ+BEQ9NSCWpAcao6KD2u4p/GGjigfJHVxkKh2b353?=
 =?us-ascii?Q?2MwbMkMUiUOUrw6ISPoh7AWR5PPNyQHPqRn4no0EnfSOqTY9V0fk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f491be48-c29b-4fa1-5933-08df2f888e50
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 15:32:46.1819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFeMoHNVqN6VwHhlA1nVXJxNALpMaNzJKjooayN9gGOr/jkIBNI6NCOMpQZN3idMjlFEoOh7Nu1lTA88ts17Ks1McXYLmFgdTTUDFbh2s4cX+FTh5V1ITINU0wjfjMqU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10106

On Wed, Oct 21, 2026 at 11:43:46AM +0530, Manikanta Maddireddy wrote:
> Tegra234 Endpoint mode must not advertise L1.2 because exiting L1.2 can
> bring the link down. That hardware workaround is required regardless of
> whether the endpoint kernel is built with CONFIG_PCIEASPM.
>
> Move the L1.2 capability masking out of init_host_aspm(), which is compiled
> out when CONFIG_PCIEASPM is disabled, and apply it from the common
> initialization paths.
>
> Fixes: f59df1d9e6bd ("PCI: tegra194: Disable L1.2 capability of Tegra234 EP")
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes V1 -> V2: None
>
>  drivers/pci/controller/dwc/pcie-tegra194.c | 47 +++++++++++++---------
>  1 file changed, 28 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 7c349478556d..0e6224b6751d 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -611,6 +611,33 @@ static struct pci_ops tegra_pci_ops = {
>  	.write = tegra_pcie_dw_wr_own_conf,
>  };
>
> +/*
> + * Disable L1.2 capability advertisement for Tegra234 Endpoint mode.
> + * Tegra234 has a hardware bug where during L1.2 exit, the UPHY PLL is
> + * powered up immediately without waiting for REFCLK to stabilize. This causes
> + * the PLL to fail to lock to the correct frequency, resulting in PCIe link
> + * loss. Since there is no hardware fix available, prevent the Endpoint from
> + * advertising L1.2 support so the host will not attempt to enter L1.2 with
> + * this Endpoint.
> + */
> +static void tegra_pcie_disable_ep_l1_2(struct tegra_pcie_dw *pcie)
> +{
> +	struct dw_pcie *pci = &pcie->pci;
> +	u32 l1ss, val;
> +
> +	if (!pcie->of_data->disable_l1_2 ||
> +	    pcie->of_data->mode != DW_PCIE_EP_TYPE)
> +		return;
> +
> +	l1ss = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
> +	if (!l1ss)
> +		return;
> +
> +	val = dw_pcie_readl_dbi(pci, l1ss + PCI_L1SS_CAP);
> +	val &= ~(PCI_L1SS_CAP_PCIPM_L1_2 | PCI_L1SS_CAP_ASPM_L1_2);
> +	dw_pcie_writel_dbi(pci, l1ss + PCI_L1SS_CAP, val);
> +}
> +
>  #if defined(CONFIG_PCIEASPM)
>  static inline u32 event_counter_prog(struct tegra_pcie_dw *pcie, u32 event)
>  {
> @@ -694,25 +721,6 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
>
>  		if (pcie->supports_clkreq)
>  			pci->l1ss_support = true;
> -
> -		/*
> -		 * Disable L1.2 capability advertisement for Tegra234 Endpoint
> -		 * mode. Tegra234 has a hardware bug where during L1.2 exit,
> -		 * the UPHY PLL is powered up immediately without waiting for
> -		 * REFCLK to stabilize. This causes the PLL to fail to lock to
> -		 * the correct frequency, resulting in PCIe link loss. Since
> -		 * there is no hardware fix available, prevent the Endpoint
> -		 * from advertising L1.2 support by clearing the L1.2 bits in
> -		 * the L1 PM Substates Capabilities register. This ensures the
> -		 * host will not attempt to enter L1.2 with this Endpoint.
> -		 */
> -		if (pcie->of_data->disable_l1_2 &&
> -		    pcie->of_data->mode == DW_PCIE_EP_TYPE) {
> -			val = dw_pcie_readl_dbi(pci, l1ss + PCI_L1SS_CAP);
> -			val &= ~(PCI_L1SS_CAP_PCIPM_L1_2 |
> -				 PCI_L1SS_CAP_ASPM_L1_2);
> -			dw_pcie_writel_dbi(pci, l1ss + PCI_L1SS_CAP, val);
> -		}
>  	}
>
>  	/* Program L0s and L1 entrance latencies */
> @@ -1903,6 +1911,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>  	config_gen3_gen4_eq_presets(pcie);
>
>  	init_host_aspm(pcie);
> +	tegra_pcie_disable_ep_l1_2(pcie);
>
>  	if (!pcie->of_data->has_l1ss_exit_fix) {
>  		val = dw_pcie_readl_dbi(pci, GEN3_CTRL);
> --
> 2.34.1
>
