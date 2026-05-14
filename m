Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012021.outbound.protection.outlook.com [52.101.66.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7059B279329;
	Thu, 14 May 2026 18:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778784969; cv=fail; b=FSCW0q42O+hFZ4Xvf+2w4lRL5e7Qbp0Hj+zMLd8h8UTiJQkO2hjVOhV7Di8yzOMRIg81Yo2g6KB187oETYfyVUFtfKMKNxXZ4F9AP5pJMckjYQ19bwsi5fz7WCpA0OYVHl4w8w7aim1VI2iToLPYdH1rJv5y024aBo0WVD1LBIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778784969; c=relaxed/simple;
	bh=EQwoTGsbAbyZ5UKxt+NPhliunXId0S/7wxzLRdWnqdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jlJWeHI/RjN5mbaGO8tlu15jodcef7JFyUV+bZebnfMfdukwO053QxVZ6Dtr3k4o8IweS3A+py6VFE9/y8paXkCcQ6fTuyIlCrJkaYjGCteHN3k7b+VcrAeh4BTH4PfjqKnCUvLt1QhOTbRI8TlHuHJykKr5AyGEsPXkikm7l0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZLlQE6w+; arc=fail smtp.client-ip=52.101.66.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZLlQE6w+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHAhSIhyoq1Pd5cJvIdmiO1ibWYCUmOvQhcX39d4YhnImvSpU5tTepWUaMf2dY6Tk9hINzftS++iThri4pYoVUjfTCZl0f52SIQLx5f80yCOhFjku4Vm4lwgK5ZUmx9g9QmAKbGp+AjFC8U4VZfC52HlzNzJRfsjaxYdLCDqswDAnY9dICdz9tEpqK7poZeIt+OXR2MicvFPtwGNFY7u3rQol5p92f5bo9iHoNuNYLXk6AbAbfNLKzWnGFpW7Tukj9Aqy67UKsXngGisSlwpr1k84dKsFBelruqxYtUx6L7/f6VoSHd+lFMjEjLKBgFrwFEnN7ICpnLXNmB17uWHKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Hz2X2lm/Mvdt3B9yszgTqfXPWSCxovS/He8kxqn76M=;
 b=zQjxZWyAjkd+AyKR2IPjmMnZMZjHAYasxNP32FlrE2NDFYdycUWVwMymo9zYiF3/XCVlKlD2mFhgDi1Ie9T+gTmtk3cZE9ETIWwyAInDvd+mp9rZDtLNxquv0OoOHtZ40qG2qouA3y9t+g2NcCYB+NdiUzo0SpeDHPNPtz3MwTTiD5xU76hKW1AnE0NkYG/7JooevW2ZyAiwylnwA8QIY8R4QS0mxiIc6v0qyYO7zIWzj9qfapzHhlfziv2+G5UZhdw2d6kj3VDpMbUIZgDp+s+3jes2eCG4nh/rrlr5AnxHq4xRGe0UEelhDfdYX6+gmxie/LlJ02GVrzMQARjU0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Hz2X2lm/Mvdt3B9yszgTqfXPWSCxovS/He8kxqn76M=;
 b=ZLlQE6w+O3F/eYzBQv1x6d1bchJeRb/s4BFhIqpYAaT0BAWC3zH01zpCX/00fcTfriNdDYqrK+zCja/rs7KyUonvNow2tVhngnppIdh0FvqMUwt3wYVMDaL5U2+bVVKJcMCrUEEB3QgTAFg5QaE2eXcfW/qQyQM575UneXO8vAsRknHKNt9ABN6YWvKp57sMpO7wbZ1QfOMmxByHs/K3/Xgl+socT2h/vPRpB8hXZ34vo4a9Usuu1YGm9KXYRZH5bIbVfOR+/K4xH3VaOK6DSdgTOvLlQh+Ktf23JZBD5kn4Bfe00KWsFZExyjqR5Mn2sOJigzoshufe+f36MZAQuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8355.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 14 May
 2026 18:56:03 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 18:56:03 +0000
Date: Thu, 14 May 2026 14:55:57 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v4 04/12] PCI: endpoint: pci-epf-vntb: Reject unusable
 doorbell counts
Message-ID: <agYavbv1asHSK1RV@lizhi-Precision-Tower-5810>
References: <20260513024923.451765-1-den@valinux.co.jp>
 <20260513024923.451765-5-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513024923.451765-5-den@valinux.co.jp>
X-ClientProxiedBy: SA1P222CA0110.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::22) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: 18316401-ecb2-402b-12ef-08deb1ea729a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|52116014|1800799024|19092799006|38350700014|22082099003|56012099003|18002099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	CnSL3a94mnCbuvTW3wk+rvWVmCMB/we/OD6cqMY/qyCqVCv1kUkEQFUrvTc3bIZTi9puprJcHMOQZhulyaBPjXfNw1HumIbatUVYCw3yLRvRSiIdJJh5sU54PhGj4y3y2UftPOiuW6qvil5gYhp8KPLn3zUVNACZ46hhV6oYVLCChMHsBcNe/sbPoGJQpuiP9ln7eZVCTodWsARGau86+YYEzMyebwy97t1uouXDyP8AL86+3y8ibbcd/BgrjE/8KQXIf6N+JbBHPurKOddPaqUunL3E8X+dXCfYg3mYY41P0LppgoJAF+xteB4WWvN02/znjLITRBH4YC4/e+8/WSqXlb2TZx38miCWPfy2DWF7vFkqJE5Hrb8wM3gbSML/jnMDRO/ZvEOBnCrmTJ07u2ywDquMqxdcHPPxkN01eKd0QMovjc8eBF1eL6/iUVkYUMLh1Dnob+shF7cW/Rn6GnPqlARExgzkdQa2wA97D8Z7XAcWu2NUA5TSOafGZE5+EQGBfJk460NPjhxj099vN0/ebpIEqi9g1m0O9DDkU1UpaQZy9lRWnqhDLul2pt8xI2HJU6Vk29od3tgzK1zuf7ohAf903CwXKdANLLdXEAaPlB7HIgdRSAUY2coMMYU6l3MQskfsVU/JpluBk672VqKF4mSQ3CggdBjt7EZVQ1mbTGa1byb8wGQ5YV+0bIjA8xWuhWd0xrLeic8FY+ZUhexUW7RVcYnwtRv1MwZq3J0FArnBHXnlnDeHlNkDLtcU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(19092799006)(38350700014)(22082099003)(56012099003)(18002099003)(11063799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wgKKvrUBCvz/zMM9MgTusy2a4EbNi407yEXBq0oLRb+RvLRQA3Pq6ZDINIhL?=
 =?us-ascii?Q?KDEHcZzPrCAsGJC5WhY9I3xZsCjvd6aFSAGQNi+ajwC7UV/0aNaGy6+dan5B?=
 =?us-ascii?Q?d1SHJ/uuQYoqw1/UpcWf2Nm3DQK9ihgRmusc8kTnFODDQxLFmh59QhyDiUn0?=
 =?us-ascii?Q?y5IKN/61y6wujnIrykTTNk0smALzTMsM2ZJ1qaJ2l9w13AYQLv6mFsD1Tv6t?=
 =?us-ascii?Q?ZezsQXo9Y5wMEzlk4apTK/pdHmkQivB1rj9Idh6ow0YuMUt++S0ReP225yBF?=
 =?us-ascii?Q?P7i/KnRk/5JDeVUmhj/mx/3RP8JNM2HMv+HTbyM43aKpXp+XsODroK6DCbKh?=
 =?us-ascii?Q?xweLW7Sg2thaRXOU7jr9bVrK1N9BDan/1vd38onFOn3vfQXQoDn2B5I/Dzx2?=
 =?us-ascii?Q?v4iDMa45fV/U5hiaRsySybeJgSkq4+RExVsfJv5tye0XaDVzH/U+APhaVj+7?=
 =?us-ascii?Q?yYuhzMClfoZOcP0daAA/uCO6awjD61rMXej6TgyqGdXc95VyNbTom+CWIUDs?=
 =?us-ascii?Q?z4XaeRLvS9X/B7NxLCRfrGCatwehPKphGBjVYY2IaTaYPSYzrvr0NmEx6nXl?=
 =?us-ascii?Q?brGoTbXGgG1UsFdrcWgFIfLeNAemrpPuY2jCeM4YFYvUu3gYjzHwpQWkdNws?=
 =?us-ascii?Q?rDPEqNQmm9Bt+FYoZEDxhDeYdZ6KM+FaZOMbrjSMGhsPkJNBLK2eMHwuFZPs?=
 =?us-ascii?Q?psQMAxjCcD3emUay/1/rHOYJcm2kkJTNYGpg2COvngYgAdVSiS9NnhrNKGaZ?=
 =?us-ascii?Q?dGjQQkft3/ajIHCCrPv9E8nO0Pxaw1RsSxgMuzaOIJKZBDMJTkDcD+bbekRw?=
 =?us-ascii?Q?TIC/Ojf2XKT2436woM7C1wkS8IZQr+mVfBv9N1svEYnzAdMazO7UYaL9TcEQ?=
 =?us-ascii?Q?90V3WXGgjrdAAjhb+/PRfiC+gZE2qrIWKGypsnTbdCBlMYRKm5fuHXBboGE7?=
 =?us-ascii?Q?e0rdeND7BuRA6/KN6TSzfREWmeqTXX7t6FHpuMK0S4UnvgHma+2/T6+4xQRL?=
 =?us-ascii?Q?8ckNNVngzzNt8XA98frLbNBo3msKxBECaNIxhKwbpRo5F6kts+XdaOuIW+2+?=
 =?us-ascii?Q?b6b8ILfqLm+TpkOO96SeX1mua89YKpzJ6N2uAbKVbYO3b5fIBExrREuuPWAF?=
 =?us-ascii?Q?ZOva5Iir+nARRsB2dCXvgz9YKgRKIa/0v6k1snXrYPKbDlERzYy0frC2haZi?=
 =?us-ascii?Q?jQypGDHA9nVqJMch0jUgcIfBXQXCp1eynJJG/zSq74EzGTX8WIXuXqeaM/Ao?=
 =?us-ascii?Q?DxyEX1zaFqOdnxfZmJvTXXqnZ8+HMxMzWyX6DigsyU6zTLykbL5vI2Jql1lA?=
 =?us-ascii?Q?6PEr1MgObJFVRji04+xug1Iw3YkDetMNK6Sya5Qk9kTX8xuRKqAIRYZe6lIM?=
 =?us-ascii?Q?3TlY0DLZq+jeBtl6EpU9WPX4Tik3LmTIYGLTH+V+IPLljxTLeo6ZC+vxektQ?=
 =?us-ascii?Q?AaIyCAEJdlqEgQNm2sUkNNFO6ktup5THI4dBKHPBG00cDct5mP6senQ0+8LO?=
 =?us-ascii?Q?TDQYLSCkG3mOmFgCEBBDHr6RiWhCNI1Qk5Mvc8Z51hpZKJXiAnuOXx9w5kmq?=
 =?us-ascii?Q?VfnlSZ/2wvxi58CVkdVcKzvlQmd0Coe2k9ek3a6VCSGdWHkZa8/z5Zk8FXWB?=
 =?us-ascii?Q?ZtdnmGRwSUVM8Ex5KmTGTmHHr+3s1Pv2VcxcpCeMqxndXoGvOcQj+5/yMArk?=
 =?us-ascii?Q?aZx8lrC816eUmzOwtR0bSRjrCIiP0p2bP7FqsFbN49SMHHa8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18316401-ecb2-402b-12ef-08deb1ea729a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 18:56:03.7610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aIwKIiB9VHgvra0SM5PxYRqyHIFZnoxW7I4yPmoNFjmiwzg0hOyN1XUQdvesVTukQQHlseXKyco1igWR0klOQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8355

On Wed, May 13, 2026 at 11:49:15AM +0900, Koichiro Den wrote:
> pci-epf-vntb reserves slot 0 for link events and keeps slot 1 unused for
> legacy layout compatibility. A db_count smaller than MIN_DB_COUNT leaves
> no usable doorbell slot after those reservations.
>
> Reject such configurations when configuring interrupts.
>
> While at it, move MAX_DB_COUNT next to MIN_DB_COUNT. They are used as a
> pair in the range check, and keeping them together makes the valid doorbell
> range easier to read.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes since v3:
>   - New patch.
>
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index d31e2eee0869..818ae5999976 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -67,7 +67,6 @@ static struct workqueue_struct *kpcintb_workqueue;
>  #define NTB_MW_OFFSET			2
>  #define DB_COUNT_MASK			GENMASK(15, 0)
>  #define MSIX_ENABLE			BIT(16)
> -#define MAX_DB_COUNT			32
>  #define MAX_MW				4
>
>  /* Limit per-work execution to avoid monopolizing kworker on doorbell storms. */
> @@ -89,6 +88,9 @@ enum epf_irq_slot {
>  	EPF_IRQ_DB_START,
>  };
>
> +#define MIN_DB_COUNT			(EPF_IRQ_DB_START + 1)
> +#define MAX_DB_COUNT			32
> +
>  /*
>   * +--------------------------------------------------+ Base
>   * |                                                  |
> @@ -512,9 +514,9 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
>  		return -EINVAL;
>  	}
>
> -	if (!ntb->db_count || ntb->db_count > MAX_DB_COUNT) {
> -		dev_err(dev, "DB count %d out of range (1 - %d)\n",
> -			ntb->db_count, MAX_DB_COUNT);
> +	if (ntb->db_count < MIN_DB_COUNT || ntb->db_count > MAX_DB_COUNT) {
> +		dev_err(dev, "DB count %d out of range (%d - %d)\n",
> +			ntb->db_count, MIN_DB_COUNT, MAX_DB_COUNT);
>  		return -EINVAL;
>  	}
>
> --
> 2.51.0
>
