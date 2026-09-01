Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013031.outbound.protection.outlook.com [40.107.162.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2938A49DB8B;
	Tue,  1 Sep 2026 19:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788289534; cv=fail; b=B6BXnCp7dxQN8f+SWpNwGScwz/bvYb80zLAxQ6s7L5BbTFwCBhrbdZOotJPE1fjKmbm4K4GBUx8WHi9fPVShKCndxr5FAMBeGGG4dBAuOj4r+RMekjIVj6icZY0dXU3mnnZQmRBKMT8tI6d8CsHtoC72qfUIKNuVmDkbqGlWgXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788289534; c=relaxed/simple;
	bh=uzlpymp1rk/hmSj3hQv94a5fOLFq7Y6qfheoPb8/OE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h+r38EsaSPQySsmrFoum9GT/Y5ZQMzFaPA2FloAqk/XNVhMO/BxJ/eu5Nkx9aeJGEdGArOMgJIJla3WNS3/WYKaPY6/ZjhE2Ld8zZDm0SSE0iKxd+NozXUG8YaLJd+bk2cA1cv6hg4UgHr9FQCicAeQKAqV3IcONNH/EQf7UZCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=juEId7dI; arc=fail smtp.client-ip=40.107.162.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="juEId7dI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdf+tdL00xWTxg2942RuuT9rhB0zi78N2pKaItcg2Q8PhJ/vXFnSalrAxJJwTadsPKQ2v0iymqowuNhl6GnZaIiF445AMEvv43a0ef1VBjYloM2Fg2oZ2miGbdla2Fg+emGu9HkoImPbSIwtu2XTaF+V7xnWtjK+6Anu/K5iVMADz1NHmxS80wwAGAYxkd2n24ijyEN0ooh9YBp882AqUeY/v/ycURcXiqigk7F5LPFTdFUts70HNE1+pcA96CDAZ11qwy5tg7dmz6rfFTLkCBROBgEPGS7PxvSlFzO0b4bcp+306yObErfS4Mm3Pyu0O+3lMUJLOhHvNCQHir4iFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNA7++2csiCKfuLpaxQ4i2RWjtRFn41EPFxfywTZiec=;
 b=SnpNHrQJ3xbThmFjRxT4Tou8oGYj7R/88Ml8sqvY/Wr0W8+h8iC7OEp+2XXSuPwiceGgeL8B49fcYM7hLoHC3qjm9diNr5tbsrm7prttOOpcnCJaxao3l7GpowfJmwC2uHpAiAuRXxWIQ1zYHJOmfg3SFmGxfQf0xbShRGDuMSqAenq7OLvkc/tQoWGFzMzORkXSbi7QK6jZ6zkW3DM/OR+EQA+WSmsI2ql5vmfNA5yQZBB6aH7JLlBd1YZihGqnevSkI5AiK1RUzk3aXUwj295xkW3JLgnDx/QvbJsbDwfXI1UY9E1q48GitxWjgY1POCaRepJpzBlh4B8GPOnd0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNA7++2csiCKfuLpaxQ4i2RWjtRFn41EPFxfywTZiec=;
 b=juEId7dI1Y5m5Dt40XmUUi7xRB0Jqi5y/Nd/VaYV3DgG2UeTmiHIzs4+ySjtoy860n2LObiq6d5dNeDX9EF9K4Ga6nnWuIrN060CaRMY38ZCTVMfvX/d7l9tvhKUgJwwRz2x9giRFziJ5RPnOwQbkPdpqkdy94BI1BvH0SGp604e0DavIoOsJ8hYZESmuo3IM9SwO6ut1055ARXK/JHtdQYxinDtRp0kAYFeJTGQEMeL/ORP4YO4R+IUGhFo6C9jiFowQ1KvZZBUBSNnw9EDXLvrNGOgugL1C2f+Jn5BBGOL1VDT80ss5CVyWKdDQ51OsBCNMZKlql/ZIGJkBvnyfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM7PR04MB6919.eurprd04.prod.outlook.com (2603:10a6:20b:10e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 19:05:24 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 19:05:24 +0000
Date: Tue, 1 Sep 2026 14:05:14 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] PCI: endpoint: pci-epf-vntb: Manage virtual NTB
 and PCI bus lifetime
Message-ID: <apch6kP9Xdvo43O6@SMW015318>
References: <20260901063238.631166-1-den@valinux.co.jp>
 <20260901063238.631166-3-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901063238.631166-3-den@valinux.co.jp>
X-ClientProxiedBy: PH7PR17CA0019.namprd17.prod.outlook.com
 (2603:10b6:510:324::16) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM7PR04MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: 1492c469-c16c-4a11-5228-08df085bf9ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|23010399003|7416014|376014|6133799003|18002099003|22082099003|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	x/oZ5tM4R44weVDwURINamoIVr9cphQsIXA+7xhmmLymC+i1CVeGzPQh1QJwhKvAFia0li+vj2QlJ2Rl7mfKjexGO2Dj/A0i5UfjrxhhRTPBJ82DVkrpdD1W2Hm0sGE5Vqu2wiIWGO/+ki85kd4UBDE+qHt06GrEuDcMeCYdszs4rUyP3CbeMscmpKzG6zaK1s7HvNoJ/Bxp7ujtmYzMVydSYGMiHdjjGoJTn8boylYB7p8dDp25Rg5h01PJJXRaMFhILNapa1eb7hRgvj7h0iWuWaA0nwM31gH4NM9vQYUp/eNQ2/ut0bvG3v7qYH/AsCgwo5nP1Hdib/dpJ5blv97BWBn4XJb3Av8buR82joHwVlOXTqnxlS/fSVWeRrln1X4w2X5ZTizbXfvFJB1IzgXPqRpg+6xwvFDYwL4atoqFOn6hEphJ3DNiuxQ9MDz7Cxotg5ycMSclHW0KB+TGVrPIQ3TPY8NjqIVq59vB3V4y+o9nzKMiO6Ed3VaKGYYNsIk80+ZbRLZk1uMeeP2qAePkuibe9PGAUGAf4fged3I2Zcm8DsT2YXFcQ8zrOa3ZAcvtkOBSUdCmWGUTQ8CaYntPepjZJFDGMIgjHfIZ0BQdmY6n6AtS/dmzRq/UrtK2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(23010399003)(7416014)(376014)(6133799003)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HbqC5osnJN2j2i2yZFGAOv4VRFgo1qLmuIDmWhhfwIia51R8JDOlBTa92ndk?=
 =?us-ascii?Q?+lLLEij0CCH61Q6qnEAnPr1kTSdzM6IZQUfWGoHl4NQ1UbEzqFIDKFF7PvqM?=
 =?us-ascii?Q?JH7JvYNIHLedWmOWpYiD/fKJ4wyf42RXiC5ZWqIuRHbTihT2x/VlEnPBGx34?=
 =?us-ascii?Q?3G2AFGx6VEL1pwtp2dbX54Lzmyx5Sl8zU1FYGlqcJnEZmV3NN7jx2UkYyVdJ?=
 =?us-ascii?Q?9ihja032L6ptWzTS0iLChPJ2DqZEQebtasnKQGXxbwxrCWPI0vZEE1kxZORk?=
 =?us-ascii?Q?WSHuhA0TH2qtq/+yitIbT/iGDtrKKkrMiM01zyD2AsxHQI1TsmWGS749ipIa?=
 =?us-ascii?Q?qDQDwBAuVGNhUIDod4HoCfF4/7dGkKtnc1tuxbVzMAIOzfYeqgYS5aPswlex?=
 =?us-ascii?Q?vOFae9ihK1EFLzCdaOkxy8jBWs8PU0H+7mmqnvvx/mN7G0QHEpiDhaqhOgdo?=
 =?us-ascii?Q?USeLLbJHATCt9h9gM37zg4kvKg31AEaa1LO20CIemKjb+lyM60dGOef93dip?=
 =?us-ascii?Q?f/P4JuIgL6gwcXy5WONAzI8qmwbvmzF6aMQnrowLaSn8eCn+0oBq8mIDmNKY?=
 =?us-ascii?Q?Hb7Mm4dba441ALaZ3J29WMPJkx93oFbi4yhxw94UGaKKIFhdogoxLk98BOqR?=
 =?us-ascii?Q?gbI+UpYi8hYkX7tkaBResyTWNL+05cv7pRvq9gIyaA3cbLZlRSAvuK/GHG8T?=
 =?us-ascii?Q?YhKnDxT4MS05Pa9ksJWhBMTo062UnqnY46HEs/CYcFjUoo0whqY5PRjBYKKr?=
 =?us-ascii?Q?SoSGKOYOAWI33WgvmCJDpbc/HjLSD8VtIPA8XVV7MhikY8fApJS5RUgGFJcx?=
 =?us-ascii?Q?2YouYnXZvoOuPgn0AoBZYj38+0tibe4sGawIn7Ft0KM55JfFQ2N+7Uv5lFVB?=
 =?us-ascii?Q?BiQqZvJacTHtr3VbuZAICASh7hw/yqCj7NOl3RH00/yR9V0HmQSsB03/oqTy?=
 =?us-ascii?Q?rnhyc9EyTBUTzW/BEuW6aWp9mhyTf/lGLN81QYgAfnX6WXg9qcN1vNXCHVoG?=
 =?us-ascii?Q?tmW2+51oSkaUvaJIGIt9pS5/cQLkqLu1J9l4sbEf7nDB9ahdMDQm5Lq7Je6S?=
 =?us-ascii?Q?IqnIgVXV03ERVYCmK5PVk5kpMAgCDTq2fmEGRZj8RMz6jmQtaPPSANd3E317?=
 =?us-ascii?Q?JquMJOEDTyh/Ipdj46vmsw5nNbFaDmfHKEWPT3LldzSutI+AYhtTFmkwzyAU?=
 =?us-ascii?Q?K6c/+o7yK8O5r7lWGlc1Jcspa5V9y6fZzpXQuZqq8xdSif5qjBw223vxFY0Q?=
 =?us-ascii?Q?Ju54mUmf5NniVrYdwIKc6B2WCjNAv7iw3IMYQQXRLSbOVjQHpxmrgtmySlNa?=
 =?us-ascii?Q?wtc07oPqyOTKY/eZXhjBeaxkpP58aAICzdbyhMRlris3QHdG57LLxN7auFuq?=
 =?us-ascii?Q?6Kk0R4Kqh4WbcEvv4hCRsoxz5evhCnI73wvJ+/TxbQQbE8WXr9fsFOzbzW88?=
 =?us-ascii?Q?oeXbC8/XRpheSWG5Qvw0jrr5ZSHWtPhppUvRVvM85ZfD4Lpq8Ji5ghzqSSyi?=
 =?us-ascii?Q?h6/ALIzId6nJm4nxAThChARIbUxaQf/6dmK6U+RBJEcK6ph5qG2e9c8n7tdv?=
 =?us-ascii?Q?96XLHMcPYEuxanGrhOUWTQHlE+qiup1kz0ON/s/tfJVS5J+wcXRjRDk82ppd?=
 =?us-ascii?Q?7JsM8zjoWBjuJ2Nms/PRtUV+h3VggvYC/I2JOh3pH6eJ+a3AM0Z86lMHdYFa?=
 =?us-ascii?Q?Ro5hFG3GokyNdHfBBt9Kv6PaYinK4tzob0nyV10RAP16tA14oC5sbwGmvtG0?=
 =?us-ascii?Q?SnoWSMftKoDn//xP8pdlAJmjRzl/02ikDovSllgURUZgbr5TvSiJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1492c469-c16c-4a11-5228-08df085bf9ed
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 19:05:24.0954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18hMP1zbYD0q2VyU3wIBTCLZEEgmRztk3MShVYhYcmZNCEWjnEk5/sRf9Sdo54o3jMdVZDgLxFa/HfjqLw5pOf6CDtTE97+YTNA0TGo6QfdwkHELjDdsqZOgdpqpIRlj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6919

On Tue, Sep 01, 2026 at 03:32:38PM +0900, Koichiro Den wrote:
> The virtual PCI driver registers an ntb_dev but has no remove callback.
> Unbinding the endpoint function can therefore free BARs while the NTB
> device and its client still use them. It also leaves the virtual PCI
> devices and root bus allocated.
>
> Allocate an ntb_dev for each virtual PCI probe and unregister it from the
> matching remove callback. Start command processing only after registration.
> Publish the device for doorbell IRQs at the same point. During remove, stop
> the command work and drain IRQ handlers before unregistering the device.
>
> Retain the root bus returned by pci_scan_bus() so it can be removed on
> unbind. Unregister the virtual PCI driver before releasing endpoint
> resources. Stop and remove the root bus under the PCI rescan/remove lock,
> then release its host bridge.
>
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> Cc: stable@vger.kernel.org # 6.0+
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v6:
>   - Rework v5 patch 5 on v7.3-rc1.
>   - Publish ntb_dev only after registration, and tie command work and
>     doorbell delivery to its lifetime.
>   - Retain and remove the virtual root bus, then release its host bridge.
>   - Drop v5 patch 4; f7245901de89 ("PCI: Check parent for NULL in
>     of_pci_bus_release_domain_nr()") fixed the bug it worked around.
>     v5: https://lore.kernel.org/r/20260226084142.2226875-6-den@valinux.co.jp/
>
> @Frank, the code changed substantially since v5, so I did not carry your
> R-b tag. I would appreciate another look.
>
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 85 +++++++++++++++----
>  1 file changed, 70 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 412e8cc6fb1d..992f5e7f8d4a 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -132,7 +132,7 @@ struct epf_ntb_ctrl {
>  } __packed;
>
>  struct epf_ntb {
> -	struct ntb_dev ntb;
> +	struct ntb_dev *ntb;
>  	struct pci_epf *epf;
>  	struct config_group group;
>
> @@ -166,10 +166,15 @@ struct epf_ntb {
>  	void __iomem *vpci_mw_addr[MAX_MW];
>
>  	struct delayed_work cmd_handler;
> +	struct pci_bus *vpci_bus;
>  };
>
>  #define to_epf_ntb(epf_group) container_of((epf_group), struct epf_ntb, group)
> -#define ntb_ndev(__ntb) container_of(__ntb, struct epf_ntb, ntb)
> +
> +static struct epf_ntb *ntb_ndev(struct ntb_dev *ntb)
> +{
> +	return ntb->pdev->sysdata;
> +}
>
>  static struct pci_epf_header epf_ntb_header = {
>  	.vendorid	= PCI_ANY_ID,
> @@ -195,7 +200,7 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
>  	else
>  		ntb->reg->link_status &= ~LINK_STATUS_UP;
>
> -	ntb_link_event(&ntb->ntb);
> +	ntb_link_event(ntb->ntb);
>  	return 0;
>  }
>
> @@ -284,7 +289,7 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
>  	     i++) {
>  		if (ntb->epf_db[i]) {
>  			atomic64_or(1 << (i - EPF_IRQ_DB_START), &ntb->db);
> -			ntb_db_event(&ntb->ntb, i - EPF_IRQ_DB_START);
> +			ntb_db_event(ntb->ntb, i - EPF_IRQ_DB_START);
>  			ntb->epf_db[i] = 0;
>  		}
>  	}
> @@ -348,12 +353,18 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
>  static irqreturn_t epf_ntb_doorbell_handler(int irq, void *data)
>  {
>  	struct epf_ntb *ntb = data;
> +	struct ntb_dev *ndev;
>  	int i;
>
> +	/* Pair with smp_store_release() in pci_vntb_probe(). */
> +	ndev = smp_load_acquire(&ntb->ntb);
> +	if (!ndev)
> +		return IRQ_HANDLED;
> +
>  	for (i = EPF_IRQ_DB_START; i < ntb->db_count; i++)
>  		if (irq == ntb->epf->db_msg[i].virq) {
>  			atomic64_or(1 << (i - EPF_IRQ_DB_START), &ntb->db);
> -			ntb_db_event(&ntb->ntb, i - EPF_IRQ_DB_START);
> +			ntb_db_event(ndev, i - EPF_IRQ_DB_START);
>  		}
>
>  	return IRQ_HANDLED;
> @@ -985,7 +996,6 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
>  	}
>
>  	INIT_DELAYED_WORK(&ntb->cmd_handler, epf_ntb_cmd_handler);
> -	queue_work(kpcintb_workqueue, &ntb->cmd_handler.work);
>
>  	atomic64_set(&ntb->peer_db_pending, 0);
>  	enable_work(&ntb->peer_db_work);
> @@ -1340,6 +1350,7 @@ static int vpci_scan_bus(void *sysdata)
>  		pci_unlock_rescan_remove();
>  		return -EINVAL;
>  	}
> +	ndev->vpci_bus = vpci_bus;
>
>  	pci_bus_add_devices(vpci_bus);
>
> @@ -1425,7 +1436,7 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
>  	int ret;
>  	struct device *dev;
>
> -	dev = &ntb->ntb.dev;
> +	dev = &ndev->dev;
>  	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
>  	epf_bar = &ntb->epf->bar[barno];
>  	epf_bar->phys_addr = addr;
> @@ -1563,7 +1574,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
>  			ret = pci_epc_raise_irq(epf->epc, func_no, vfunc_no,
>  						PCI_IRQ_MSI, interrupt_num);
>  			if (ret)
> -				dev_err(&ntb->ntb.dev,
> +				dev_err(&epf->dev,
>  					"Failed to raise IRQ for interrupt_num %u: %d\n",
>  					interrupt_num, ret);
>  		}
> @@ -1681,13 +1692,18 @@ static const struct ntb_dev_ops vntb_epf_ops = {
>
>  static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
> -	int ret;
>  	struct epf_ntb *ndev = (struct epf_ntb *)pdev->sysdata;
>  	struct device *dev = &pdev->dev;
> +	struct ntb_dev *ntb;
> +	int ret;
> +
> +	ntb = devm_kzalloc(dev, sizeof(*ntb), GFP_KERNEL);
> +	if (!ntb)
> +		return -ENOMEM;
>
> -	ndev->ntb.pdev = pdev;
> -	ndev->ntb.topo = NTB_TOPO_NONE;
> -	ndev->ntb.ops =  &vntb_epf_ops;
> +	ntb->pdev = pdev;
> +	ntb->topo = NTB_TOPO_NONE;
> +	ntb->ops = &vntb_epf_ops;
>
>  	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>  	if (ret) {
> @@ -1695,16 +1711,41 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		return ret;
>  	}
>
> -	ret = ntb_register_device(&ndev->ntb);
> +	ret = ntb_register_device(ntb);
>  	if (ret) {
>  		dev_err(dev, "Failed to register NTB device\n");
>  		return ret;
>  	}
>
> +	/* Publish after ntb_register_device() succeeds. */
> +	smp_store_release(&ndev->ntb, ntb);
> +	queue_delayed_work(kpcintb_workqueue, &ndev->cmd_handler, 0);
> +
>  	dev_dbg(dev, "PCI Virtual NTB driver loaded\n");
>  	return 0;
>  }
>
> +static void pci_vntb_remove(struct pci_dev *pdev)
> +{
> +	struct epf_ntb *ndev = pdev->sysdata;
> +	struct ntb_dev *ntb;
> +	unsigned int i;
> +
> +	/* Stop the work reader, then close and drain the IRQ gate. */
> +	cancel_delayed_work_sync(&ndev->cmd_handler);
> +
> +	ntb = xchg(&ndev->ntb, NULL);
> +
> +	if (ndev->msi_doorbell)
> +		for (i = 0; i < ndev->db_count; i++) {
> +			if (epf_ntb_db_irq_is_duplicated(ndev->epf, i))
> +				continue;
> +			synchronize_irq(ndev->epf->db_msg[i].virq);
> +		}
> +
> +	ntb_unregister_device(ntb);
> +}
> +
>  static struct pci_device_id pci_vntb_table[] = {
>  	{
>  		PCI_DEVICE(0xffff, 0xffff),
> @@ -1716,6 +1757,7 @@ static struct pci_driver vntb_pci_driver = {
>  	.name           = "pci-vntb",
>  	.id_table       = pci_vntb_table,
>  	.probe          = pci_vntb_probe,
> +	.remove         = pci_vntb_remove,
>  };
>
>  /* ============ PCIe EPF Driver Bind ====================*/
> @@ -1796,12 +1838,25 @@ static int epf_ntb_bind(struct pci_epf *epf)
>   */
>  static void epf_ntb_unbind(struct pci_epf *epf)
>  {
> +	struct pci_host_bridge *bridge;
>  	struct epf_ntb *ntb = epf_get_drvdata(epf);
>
> +	pci_unregister_driver(&vntb_pci_driver);
> +
> +	if (ntb->vpci_bus) {
> +		bridge = to_pci_host_bridge(ntb->vpci_bus->bridge);
> +
> +		pci_lock_rescan_remove();
> +		pci_stop_root_bus(ntb->vpci_bus);
> +		pci_remove_root_bus(ntb->vpci_bus);
> +		ntb->vpci_bus = NULL;
> +		pci_unlock_rescan_remove();
> +
> +		pci_free_host_bridge(bridge);
> +	}
> +
>  	epf_ntb_epc_cleanup(ntb);
>  	epf_ntb_config_spad_bar_free(ntb);
> -
> -	pci_unregister_driver(&vntb_pci_driver);
>  }
>
>  // EPF driver probe
> --
> 2.51.0
>
