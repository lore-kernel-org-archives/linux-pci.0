Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011070.outbound.protection.outlook.com [52.101.65.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FD9324716
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 18:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537707; cv=fail; b=XS4YFVY+COg1smQ4jNTBWZnadVk2rURmwoLVCsqVJ6FGOJy0FWCuZqlwsp6vJKFDxR5kbtiPN+ypE9S/e4vCbD+4FaqjlxBfufVSzm3c91AqAgNc2boJKRofbQ9vrfQf/WPfXyYOaPLXngd0AQhEt3kBut4urMQXBhca8RYs2fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537707; c=relaxed/simple;
	bh=CGJNqzPMTEGFgMxp7qBHg9YcbFn1NdRdHcCopbfkZzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i+Dy/i2aTjOTHQIqTg70PDxWlrnLjP+r5YQyssGfgr1t7uJ7wlTMdo+zWSUGnGI7BSxoC5q6WlEQr33O6jVIia5lwo+m//xvoSF5/gY9y5j+72u7BLqaIMyiIE0NI2ag4tau7dKVdKJwQ+B2bGMMgnBsMZFJOubyIsP39kY7hiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L7g3TJJz; arc=fail smtp.client-ip=52.101.65.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L7g3TJJz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rObw7HZfeW7WmDc0HL+B3UAxnmHM2Xtc3GHF/Yr/j0/F7DKrO2LvhoZ1nNwPqfZZDEWPjutyQd7Aa10LxIpKbhBTh8ovWC3OKW+4dtmJKOWtubE78v32FndaQZOFAGLvlL94U3IxG+LH4NnF3lcGtQVLwP9JkvMbdxb/sHv5ahl70HVCK7rlKeu7ToFL3q4prekfDMP1rTUXUcpJ+p5YYVCLmovS/rQFX+86b6NQE0tRXkc5M38U65Wq/U9pjueaS5zmgagkXjkznu57yI5CYlJM6CM1z1t4mi0pC0z1p/HmxLNySaKacClTRj1vNentF08OpLKCyW10ZOF4Z5b7DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+G2jZkPvP0548tswWQ1CXWL0WMUSGykaUkIGH4D7hk=;
 b=CZi/zYAL+I7q2I/nVCMWhhrL3oSXpmDRQWFTvP3ZPlGKNLa3i8rV0sfae5wq9TSfyOOA61W7KlqMv/OlpXvInyhoDWetgR0xt41kpNERrJmXIsPyh9XjR0w3huLOd0NDgmDvPl813vtSxMNqQuoQTZgq1zoqC77mhpjp7ahCP2xBXpEP2aoAFpt8Wv/FJygK5u3rJusXtcQN77W3s/xIkL9xYebOUyhsp6gO2B55wcZkWKWCE1Ktg0QbzyqTbpR1h/XZeqr2zOzBZCJ8FHaV/EgqQg1pZCW1FYmZD5C2DgwKLcjB8oKtjN7MD347aLMrtm0TkL9DSiz3kOoOvgqkOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+G2jZkPvP0548tswWQ1CXWL0WMUSGykaUkIGH4D7hk=;
 b=L7g3TJJztIuKiBmZ48Vd22AQdStFV6UTeIh9cHrkeNWGHopwuYT/dTb9jzPEyWkmcmIskyscaSXPa43pdWGaf3SsW+frbCirEoW1iQLIDfW6FPw9Ae0MIZZloOHADueAO4awJjHsbtXkj+HSJeu4rAogpsOsmQc+kuGl+al2jRAAAR9Mt0awpRKBeyeeR/twOlm1DtQY0Iv2uDgxG7Gu3nHMb1PLTzMUH+MpPNw2jk+zzsGzMeGNBCjiQ8tvShp/ABNNr/SmyAGAQnQWYP6E/+E2tHOL5gmsmKFqj5fmyVpDq7nTD4WdFjfDUoY4DTX1iHikVCBbQpdh5O/HVy5//w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU4PR04MB10402.eurprd04.prod.outlook.com (2603:10a6:10:55b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 18:15:03 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9520.005; Tue, 27 Jan 2026
 18:15:02 +0000
Date: Tue, 27 Jan 2026 13:14:52 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Randolph Lin <randolph@andestech.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Charles Mirabile <cmirabil@redhat.com>, tim609@andestech.com,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	dlemoal@kernel.org, "Maciej W. Rozycki" <macro@orcam.me.uk>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 2/3] PCI: dwc: Clean up iATU index usage in
 dw_pcie_iatu_setup()
Message-ID: <aXkAnCidraQ3iJpB@lizhi-Precision-Tower-5810>
References: <20260127151038.1484881-5-cassel@kernel.org>
 <20260127151038.1484881-7-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127151038.1484881-7-cassel@kernel.org>
X-ClientProxiedBy: BY3PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::25) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU4PR04MB10402:EE_
X-MS-Office365-Filtering-Correlation-Id: cbc5ef2a-12ca-4293-ad94-08de5dcffd1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|19092799006|7416014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YkU3bC3gV0/4+y9Vcyajfi1aSPgCRjK/SxAyWJCyV23fVpEoVV9DVWHyZA3g?=
 =?us-ascii?Q?vCNx5TT/0fE+UnH8r3dTv4JVJd9k7SXqsaOTF9H+KPLyxoQ9FF5glK2KirAx?=
 =?us-ascii?Q?bNVq0a5bBAs6zbWmSV6WbBqNqPtzi4nE17bDhy1LUkwvz7HLhmUPupanCnWp?=
 =?us-ascii?Q?WsMBIu8JInLKVxI4yp2cNf/ve+hbNdkC/cbWS61OGxePiFWUfz8huQ55z3k+?=
 =?us-ascii?Q?XnXtcl3UTCphKJrfh4oGJxBng2ITatbhom3BQAWORI5wlrxQHN3yrlROvN1r?=
 =?us-ascii?Q?QHCIy6UwiA5PcUske+GlgR3E3ihTNt9bq2dn0VeK0oUO4S3QuinHhQjdMX8H?=
 =?us-ascii?Q?FmYmBWKZbIrlfuCKHHUbQJ5i0iXF330+NRjwytn2NC3bFNGhlWQb/I8mDkwA?=
 =?us-ascii?Q?dY5fdgxyvP+gj69vIoSmlsGsnbH8jZMVbzu3wcQ+tHxEHnT0cv/YyCWJh88l?=
 =?us-ascii?Q?s8Kjq+w9xFKbFW+gcCCBW3n+9s/1qL5rfYxK/5947tBMmJh8z9vB4zTk0Apk?=
 =?us-ascii?Q?AYbLmT4J5BcPRGPtD/3hpEIiuwzsIVDLeZNcujno8LXWF0J/T18VoSidN2ek?=
 =?us-ascii?Q?Ujj4e2I7BB6Qkag5YL5ik9/c0JAVCNme6tEjbb1HnGygPsh5xnEeSvYjZ0L+?=
 =?us-ascii?Q?NgcgRkCCAVxc7LuTLCxWNG0vmBKmxDGpr5U7glXdjRgylmtiyXAqnHwTHm9k?=
 =?us-ascii?Q?PHPPWF8W41FPw+cuHjxT/lbP8nDqbyLVw2lFOLevdzTvnLdoQ8xQrKCKtHVd?=
 =?us-ascii?Q?jFgJLO6qYl7+ZR+nUWZmk2tz3CGiFcOBPfrG2/R5TQPEl1V5NZkC6WqWS4Z0?=
 =?us-ascii?Q?gFTQE1UfPyENRF4xWHnddrKLvQSASyar45cc3yQYvIT8gfwmvuG0872TOXu+?=
 =?us-ascii?Q?KcwqgSI3pYV1dS5q0Zmbk/AjEPvVDtW37+FIk2hpZ/39mLWYQZa92oPG7biq?=
 =?us-ascii?Q?QWWFPZS/srxjmISOepR+fx5eoZoM8irXAJhCjBkTACer2CXBqCQ0T7xnpCX3?=
 =?us-ascii?Q?J91idOrb6khJnkeTan9Ie81p3Iq2WxL1lcyTJjH4c/6Aj2bT1FgTzE6udImD?=
 =?us-ascii?Q?COzts3kHF7wb+zs7dAbP7lUDFwcaJUxMn7lr1E7u5i6wnlhg8UuQYIJypkTu?=
 =?us-ascii?Q?s5jqPVBHNaTPoneE7MJrs+H4jG84grQRJavRJ/DOvvYYHSEDkBBGHWsNzNpe?=
 =?us-ascii?Q?tWMRnWOIiOkVLSaYjFX6Gusc8aXARs8MX5QzkOZKLBrOdT2QR5EJHV8fx0kM?=
 =?us-ascii?Q?VNo3HcXzISb6aOiArBC1HCZbeTp+7QxZLrAxzZdUwD9/nmX001p+K30oi5Rx?=
 =?us-ascii?Q?JfJmpjS9KB7rIJQal84ZMfGS/qqTqvQ9u6idWzfaMvs/6Ept2Kt22ZK0n76t?=
 =?us-ascii?Q?9ShVMbWTIGph9y8JteQVLaoe1Bg+29jvKYuMbSgbt2Dq7RK2Iet5BpV1B7m6?=
 =?us-ascii?Q?+UF90RALu+BlkqzVYkWT0Fx/XevB579LpkPEBP1c4GhUnKnHzbsq7WV2n+H2?=
 =?us-ascii?Q?Kdly4QMDR5kNxyzSC20ROouSJ75+Q+fgSocNRw1D3aMcXsWQtifFp+bL69tn?=
 =?us-ascii?Q?YneHWK/g0SiswNkJvNiH/cSIx9sD2qEgfkqMHTBvstG3n3wOctAflOQTmKvg?=
 =?us-ascii?Q?qlSgg7qB8fB4XFgDEfkAuoE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(19092799006)(7416014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aT3/kx9/ZZSoRHYeq7nTRAExTA0gfOkqLGEh6i4/J9MzWgzh7phn1OZEnz6p?=
 =?us-ascii?Q?cnv6dBuVhbdbImy/AOYS5/WyUaIKp+wpOoCbNkEOWmBoetirA1KH/I5w2XYF?=
 =?us-ascii?Q?1aByNZZng5WaJQet8OVz3Id8UK0gLI54JUvZHSaHiHs64ugdgDKI9Pa2OMHi?=
 =?us-ascii?Q?M5wuJIBxaYjrA0uZc0h1lwqOdX9aQrmKlPE1dqn2MQkJioonD2J+Vsincyq3?=
 =?us-ascii?Q?vQQNLJ7mqu1Lp+UJhjim+U0ZAeRVcpkBEaFYtzQw3oHCC4dg+UCNBa4qOeYd?=
 =?us-ascii?Q?HUdLrSdyMzMI2aUhXsTrfVAr00QYIyKdj+Hb5kM2RNwIMeuHhc/vPGmLhWRR?=
 =?us-ascii?Q?iDyTNCtnz+DWXKkiPMq/xYh3h8blJzpC7EDVTpBuhron4JX493z5wiqtyBGN?=
 =?us-ascii?Q?7DrEKzTpXTVUrWscCt7jONGHhlb74o+mDHckyW+DXThGwfunPPgR0qLNAshj?=
 =?us-ascii?Q?jFoQRjJVmXQTJeu15m8XAbWzlgHgpX/ZYo8WDCISi5k0crlleQexDC+FBGBH?=
 =?us-ascii?Q?bwXFutjaojxop/P0EKPVYA3znb1b60K8L56pUMIiXD3jBnOgcqfnCdF99pL2?=
 =?us-ascii?Q?NN6F4m911967IzGly0Ak2rr+dUNGwUiHNIJLWdwrjztSjuF17mY+lqmby6Qt?=
 =?us-ascii?Q?ExHT8eegJDXX+MSru8HwLyaUpV9XOYNVdfslQLDtwMERQmYo+olyLgg6qTt4?=
 =?us-ascii?Q?wR8xUihNrHvlnMgijCopuCX+bjGy4rZVRGvB8/KfPHBBHmVjhODvJ0msuqML?=
 =?us-ascii?Q?D+Ycw2UFOFh9kyJPpqwutRBfmG5Jpkvarsq+vcVfREA5nO4MJ75I8tUwtI1E?=
 =?us-ascii?Q?hsTbS1E6Nt7lEP3BNMRDE2GGWai+hsPKh9o9NftAUUFCoGqc5Eh/SJaei7+w?=
 =?us-ascii?Q?4/Q3gLS5h9qFC2U74ijiejslMuabP0BhctpAFdfXGAHa1h567ktY0xBt6uZg?=
 =?us-ascii?Q?VhFkGIx0T17lOMY8tPKfku0sKFY+bTCD7H1gJdPMr9/Vx4HgWgooJyup5oOB?=
 =?us-ascii?Q?S+0lkrfykhNesYCfyo7Or45fHelfQVIQF7hD+4GinokzFMAlbA5d6x43QQNq?=
 =?us-ascii?Q?t0zTAXxXNIa1ZdWw5iHsWAfc0kb8agVTu+QbRNIFAeQIlRYV7dP0sGcIQHjN?=
 =?us-ascii?Q?9E7gIJygao0JKjuDPK5/GNKzJ2v0ZOCFI0+RLuaBwIbOJ6EQz4KuhQ4P18QW?=
 =?us-ascii?Q?86XP4fqnaWaUQ9zD1s4l9tJPNCsn9VKpPK3IofNLqXf6P9c8dWtht+w//4iG?=
 =?us-ascii?Q?1mxevklK7diM4FKpmKIfjhoI8UHbnn1AQEFhf7zfk93H/9HOdbvY0pmpmzJc?=
 =?us-ascii?Q?Yw4YcHmJ9pMz65lAGTaq7NVnhyIexUP0RJOriSXKX5mvq866Un5LlsiTQD1f?=
 =?us-ascii?Q?a3gm/FPU8JGe+bGWVfvYMSOvy9D7MSbfslyVJv/7QlJpMd2u6BUmZo2nLnT7?=
 =?us-ascii?Q?KyBItRTZX4Sqld6xkKniTGTDovxRn2mZjiD3Pawt5/Ex3sZWmlMpdhaaSQRG?=
 =?us-ascii?Q?JEZ00gzv1yZAfLVzpRpGXB63Oghgjum6GHKWEKuA1YDcZYosTWradt4e7uu1?=
 =?us-ascii?Q?IZ5R+jjXy+TRkEubq8XfW4aLgBLpNoOx5yXC0SzdvmkHK0ymvyq5SCeboEOr?=
 =?us-ascii?Q?HGg5zU6AnpQzxhR4dYULVht7bCbuVarFCy6gss5B/+iFZIGcwi6xBrRN6EgS?=
 =?us-ascii?Q?7kmI9TcKkQxthGdjQJ+ZQOfTlC7c0kWZ6cLWmjxd3VPRs9+E?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc5ef2a-12ca-4293-ad94-08de5dcffd1f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 18:15:02.4023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3FlBLFjN3hoHFmYE5Yta/z/AUwFKFa0Aqiw7xue2GTOTH0blpFWHFtlDJ8+0d+JttQ/5Eq9bKH1g5t7CkA8ZYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10402

On Tue, Jan 27, 2026 at 04:10:40PM +0100, Niklas Cassel wrote:
> The current iATU index usage in dw_pcie_iatu_setup() is a mess.
>
> For outbound address translation the index is incremented before usage.
> For inbound address translation the index is incremented after usage.
>
> Incrementing the index after usage make much more sense, and make the
> index usage consistent for both outbound and inbound address translation.
>
> Most likely, the overly complicated logic for the outbound address
> translation is because the iATU at index 0 is reserved for CFG IOs
> (dw_pcie_other_conf_map_bus()), however, we should be able to use the
> exact same logic for the indexing of the outbound and inbound iATUs.
> (Only the starting index should be different.)
>
> Create two new variables ob_iatu_index and ib_iatu_index, which makes
> it more clear from the name itself that it is a zeroes based index,
> and only increment the index if the iATU configuration call succeeded.
>
> Since we always check if there is an index available immediately before
> programming the iATU, we can remove the useless "ranges exceed outbound
> iATU size" warnings, as the code is already unreachable. For the same
> reason, we can also remove the useless breaks outside of the while loops.
>
> No functional changes intended.
>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  .../pci/controller/dwc/pcie-designware-host.c | 59 ++++++++++---------
>  1 file changed, 31 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index d7f57d77bdf5..87e6a32dbb9a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -892,9 +892,10 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct dw_pcie_ob_atu_cfg atu = { 0 };
>  	struct resource_entry *entry;
> +	int ob_iatu_index;
> +	int ib_iatu_index;
>  	int i, ret;
>
> -	/* Note the very first outbound ATU is used for CFG IOs */
>  	if (!pci->num_ob_windows) {
>  		dev_err(pci->dev, "No outbound iATU found\n");
>  		return -EINVAL;
> @@ -910,16 +911,18 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  	for (i = 0; i < pci->num_ib_windows; i++)
>  		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, i);
>
> -	i = 0;
> +	/*
> +	 * NOTE: For outbound address translation, outbound iATU at index 0 is
> +	 * reserved for CFG IOs (dw_pcie_other_conf_map_bus()), thus start at
> +	 * index 1.
> +	 */
> +	ob_iatu_index = 1;
>  	resource_list_for_each_entry(entry, &pp->bridge->windows) {
>  		resource_size_t res_size;
>
>  		if (resource_type(entry->res) != IORESOURCE_MEM)
>  			continue;
>
> -		if (pci->num_ob_windows <= i + 1)
> -			break;
> -
>  		atu.type = PCIE_ATU_TYPE_MEM;
>  		atu.parent_bus_addr = entry->res->start - pci->parent_bus_offset;
>  		atu.pci_addr = entry->res->start - entry->offset;
> @@ -937,13 +940,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  			 * middle. Otherwise, we would end up only partially
>  			 * mapping a single resource.
>  			 */
> -			if (pci->num_ob_windows <= ++i) {
> -				dev_err(pci->dev, "Exhausted outbound windows for region: %pr\n",
> +			if (ob_iatu_index >= pci->num_ob_windows) {
> +				dev_err(pci->dev, "Cannot add outbound window for region: %pr\n",
>  					entry->res);
>  				return -ENOMEM;
>  			}
>
> -			atu.index = i;
> +			atu.index = ob_iatu_index;
>  			atu.size = MIN(pci->region_limit + 1, res_size);
>
>  			ret = dw_pcie_prog_outbound_atu(pci, &atu);
> @@ -953,6 +956,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  				return ret;
>  			}
>
> +			ob_iatu_index++;
>  			atu.parent_bus_addr += atu.size;
>  			atu.pci_addr += atu.size;
>  			res_size -= atu.size;
> @@ -960,8 +964,8 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  	}
>
>  	if (pp->io_size) {
> -		if (pci->num_ob_windows > ++i) {
> -			atu.index = i;
> +		if (ob_iatu_index < pci->num_ob_windows) {
> +			atu.index = ob_iatu_index;
>  			atu.type = PCIE_ATU_TYPE_IO;
>  			atu.parent_bus_addr = pp->io_base - pci->parent_bus_offset;
>  			atu.pci_addr = pp->io_bus_addr;
> @@ -973,34 +977,35 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  					entry->res);
>  				return ret;
>  			}
> +			ob_iatu_index++;
>  		} else {
> +			/*
> +			 * If there are not enough outbound windows to give I/O
> +			 * space its own iATU, the outbound iATU at index 0 will
> +			 * be shared between I/O space and CFG IOs, by
> +			 * temporarily reconfiguring the iATU to CFG space, in
> +			 * order to do a CFG IO, and then immediately restoring
> +			 * it to I/O space.
> +			 */
>  			pp->cfg0_io_shared = true;
>  		}
>  	}
>
> -	if (pci->num_ob_windows <= i)
> -		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
> -			 pci->num_ob_windows);
> -
>  	if (pp->use_atu_msg) {
> -		if (pci->num_ob_windows > ++i) {
> -			pp->msg_atu_index = i;
> -		} else {
> +		if (ob_iatu_index >= pci->num_ob_windows) {
>  			dev_err(pci->dev, "Cannot add outbound window for MSG TLP\n");
>  			return -ENOMEM;
>  		}
> +		pp->msg_atu_index = ob_iatu_index++;
>  	}
>
> -	i = 0;
> +	ib_iatu_index = 0;
>  	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
>  		resource_size_t res_start, res_size, window_size;
>
>  		if (resource_type(entry->res) != IORESOURCE_MEM)
>  			continue;
>
> -		if (pci->num_ib_windows <= i)
> -			break;
> -
>  		res_size = resource_size(entry->res);
>  		res_start = entry->res->start;
>  		while (res_size > 0) {
> @@ -1009,14 +1014,15 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  			 * middle. Otherwise, we would end up only partially
>  			 * mapping a single resource.
>  			 */
> -			if (pci->num_ib_windows <= i) {
> -				dev_err(pci->dev, "Exhausted inbound windows for region: %pr\n",
> +			if (ib_iatu_index >= pci->num_ib_windows) {
> +				dev_err(pci->dev, "Cannot add inbound window for region: %pr\n",
>  					entry->res);
>  				return -ENOMEM;
>  			}
>
>  			window_size = MIN(pci->region_limit + 1, res_size);
> -			ret = dw_pcie_prog_inbound_atu(pci, i++, PCIE_ATU_TYPE_MEM, res_start,
> +			ret = dw_pcie_prog_inbound_atu(pci, ib_iatu_index,
> +						       PCIE_ATU_TYPE_MEM, res_start,
>  						       res_start - entry->offset, window_size);
>  			if (ret) {
>  				dev_err(pci->dev, "Failed to set DMA range %pr\n",
> @@ -1024,15 +1030,12 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  				return ret;
>  			}
>
> +			ib_iatu_index++;
>  			res_start += window_size;
>  			res_size -= window_size;
>  		}
>  	}
>
> -	if (pci->num_ib_windows <= i)
> -		dev_warn(pci->dev, "Dma-ranges exceed inbound iATU size (%u)\n",
> -			 pci->num_ib_windows);
> -
>  	return 0;
>  }
>
> --
> 2.52.0
>
