Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020120.outbound.protection.outlook.com [52.101.228.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166432D0614;
	Mon,  6 Apr 2026 16:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775493691; cv=fail; b=EKGRZEwMnlQmrIAqDtyYIoa8aGRUjMEaz97i4KcWKngHOv3zDJpdeRa8/WIXIXBeewzwREJqM13bBSjh5V7VlC542A5SdjgJgucdScNYp7glqQEcEJalRbpQ/Jtz0AyMYFO//LlNGzW7CSodOuPhyISg201aIb7JukJuETRk0rU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775493691; c=relaxed/simple;
	bh=wZxi+5kORTI/sh2/vjHLn/TMzp986O36ji3KwM26GWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bOGEQMyNL3BhOjZSbCAmxcXulVS0kGfs1upUP6g+U2VK60KjaBP5MVRQEof9vY5kkE0W6UmT5VbZDTbWNEDUt66sODgzTXPQIuUPAmuusI95kBevTfcJ5ID9krVUr06GaISwtF5TXlEJ4/HK/ybz5e1o+DTfOkPuNWVqRorJ+eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=WLoKoNnF; arc=fail smtp.client-ip=52.101.228.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="WLoKoNnF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pOzk5+J797k14049X1o92GovvJSypdAU10FuWYznhKtprCJ8XvdWZHgJP+cvZy+ycHAuGTLyOLSuxDv9vRzW11OXpaiTt9P3oyhNjFsdbSmThtOJkgJ0BvChFSh87QlqTUwDWRBAs+kLqxG7tMfnf0cYHTa4EuWw5tk/rZLd6NSQxqYFlNC3z58vdy+wbOLE0dsG2dxQ98mnAwiiqW0gevuAdJNKu6RGBmx3xVmjXL//9sml7OIsxXU17YA7mvTUnC9/5tiBWQVqW2DuhQW8RCjgna3hhxmPaoWJssYC9W37SMri5sNjJThDMpovgeIaC5MaCRkWRU/c0HUbNAye1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlCoK7/Cr2H1sA+VMxSwne6n95oPxvfmjQZBco9hIDA=;
 b=w68zFdu1fucCqHyAJ+H0m0+vQ4I9cXSaOaRXmFD8iZtCagpEiXrsmQCuKca1NaawziYMadRN4bNk4tErwFqQF4kNt7FxbR8n3NcX9txD7675l6iM3URhBWXgv+/b6Ryi0oQkrIy7NkwtgXDyv45o71hkPyz1shHRm0lY0flrrgqOC0g+Lfet80H8fyAN6n2ppjmSiv/EiWVkFV6DzIgfNYi1qIAydJfK4YaPLensgHaqG1DiiVEVHFq2gaXnxRBc2tEtx1dXo/aeFOggF2xryjS6YfOcRhzKu6olrtA/WhEU9WD6Bde042SP74xQpriOF+jrTOam8bgoKF/UaaY+3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlCoK7/Cr2H1sA+VMxSwne6n95oPxvfmjQZBco9hIDA=;
 b=WLoKoNnFCLiUcMT6Cu3ogFmyeLaFvzTDBe1DGIhzQbbfu0DSLz8oB+vyY1oYimk12S5UXmcpk25DKn4alV8T6WyYME0XGH5OGk1/hQRTNX1zcxU7SjczMeGmkUpIlGhUOQz4dWrV9ai1YfyAnePY5xnLCLbsZFW2scDxYyGJ0GA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2674.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:255::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 16:41:28 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 16:41:28 +0000
Date: Tue, 7 Apr 2026 01:41:27 +0900
From: Koichiro Den <den@valinux.co.jp>
To: carlos.bilbao@kernel.org
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org, 
	arnd@arndb.de, gregkh@linuxfoundation.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bilbao@vt.edu
Subject: Re: [PATCH 2/2] misc: pci_endpoint_test: remove dead BAR read before
 doorbell trigger
Message-ID: <2rowocnj6nigbikgdgydd4lvlcvyqyhawwhnkqsjthgh2ilsf7@sthpcml5jjef>
References: <20260404012002.111873-1-carlos.bilbao@kernel.org>
 <20260404012002.111873-3-carlos.bilbao@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404012002.111873-3-carlos.bilbao@kernel.org>
X-ClientProxiedBy: TYCPR01CA0121.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2674:EE_
X-MS-Office365-Filtering-Correlation-Id: c39bd4b8-f7a6-43e4-8f7e-08de93fb598c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	/d0DG3jiyETyn0roHBGV0ETlvvswsWNnicXgNAiGxT8GJhp0m+Q8rRus5s+qwwz26WVTnk1069tyulIzZv9sWeS1ifxDDe4liC5XnefB+D8lsR9duMeCVVDCNvEo4m9Xh+kOJRYfzO19cOMr17h0BM6B6qDWbHHmLN3gn1+eMUnI43MsHuRvps12x22B2/pwEseHnAYQ6SpyjbWS9slLY/HzHrlcnkaHsFnNw4Mvs7QCAiTgSdMn8bm/gZY49ekvMJpxdT2SHQdDcB2/QCNHKl558P3EFOWJEqM73ekSw/zLxLze3vg+AtmE2nar/EYErV0d+Ra7WWCZsAUFZuCoFc4fu3AV0HrnHwDbttO42omVwRa45zR9cx0ZXhLQSIpjYNsuAI99E7Zq44uN9k6Kn6arZRq174vgmODxIdRz4DJTEHK3CoziN04C8aGTrC5g7SPu7t+BbfOjvq3t2jaIUEQRIFHFjGf17XYW5HdB+IHH7HuJOys/fpTGu6R4xLQXeGkH5m/5YFqo+wVawFbk/tLKBJaaJLJH1k56qUu6ADhfJNVMTlNXZoKp6gr1u71+vsXrRc8EA/PbN79mkfRwzJqg1SvV+1rTRMovuwab2WaCfsne2SZ7zJVcUiZd2bzNjfKg7f90zjTXTraPnVxeNS8qXVJjsy0WZuv45LTS83I5WNmcmz746I7iftHGjDE77Ts1wye2athrhWXvDqcanAzMsfEh4nLjH05NCxKfalY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UZ0Mxh4/xb/JqvjQfRCsMRTwHpiGf9YBSJc3tWdGF1zh8h5+8/42YR80Av5O?=
 =?us-ascii?Q?Po/4WMOC+PNGWZR9QhgRH6PSglFQBGsKxSbDxcVS5aGiQZwtYKkWFPzE25Yp?=
 =?us-ascii?Q?RV3LPy0m9OelSguEi4i1eDS2suGfj/mqDUZxZV3SzPaoPsSwVJnmt4CLq8cH?=
 =?us-ascii?Q?GT/Cu9lqeo4+X/7YS6zB4vAtc6NU1mUSj/9iv8ViMriI5qdJup/O4GTksBqV?=
 =?us-ascii?Q?mE0bFvqSk7Y2+ys5CWE+Shatsfy28tWPN1vqaYncz5wxAX/IeZ3gq+kbVgGU?=
 =?us-ascii?Q?DnX991aEA9YTQLUcAAMmoYIgfPe6VgxgDw89Yq2TPA3PVeiGFKCEI6nnszhK?=
 =?us-ascii?Q?xZ8QlUj2VOlAk+Mhw+Tasi0SRj7zrajAojfM6c8yip9aYql0yzV+RcJs59H1?=
 =?us-ascii?Q?GoYGVz4XOhaksal/klh67iNmp0DWqNwoIv7roMzG7bB+bgTQKoK73rPqJqZM?=
 =?us-ascii?Q?ZWaHzy7FD1Vc5SDIa5xQKAyuYKjIXLnFY/UBqgNrNM5RLLi0tbbVgWSFsFOd?=
 =?us-ascii?Q?7d/rIGMSdddp21YwZdsd0C2o+PB2HMcdpx3wexi2LkdRgfrxQAjYplZ69IWD?=
 =?us-ascii?Q?J1pH/mgJmKViu0y7sGpmwX4JNC2RX2hLpiq8rNqk4bPe+nRYC0OXFK6iqV03?=
 =?us-ascii?Q?+y3R3XFvPiDpn+3zuBWbMkeU4lXlXqCzQJp/X4XfmkZNuigkJgxtA3nBVLTw?=
 =?us-ascii?Q?r0WvfBhAHzueyOOrdfJRue0N0/w0YVHXL0yBveidlYaXk4SFfISnkoGqWp+L?=
 =?us-ascii?Q?nYQbqX47kjvp8G+FH6+u9VzSwR7kmXt8dg8ogf3E4J0iJvukMkdC1sjyhWaE?=
 =?us-ascii?Q?gotFgidjgMcIjNoYcO3efdMCMT8nQwsQFiqnpHhaxqYj6f5x5CPxwb1O4rnK?=
 =?us-ascii?Q?hgsKZ8KusE8wLmcB5aidpc6gFQEXb6FOdycUq9nfubWllyn1w4MK5sqLkytG?=
 =?us-ascii?Q?1hLTeVUM0SRHCX8fQgqDKvmankZxKonVOD6lvaeHO/JykbEgeYV1QqaB2CC2?=
 =?us-ascii?Q?ypp8KXTCpwHWdxxiPeLWylBw9b60pLOhSuUnGdkLJXQXzRMhFDkzyWc4purn?=
 =?us-ascii?Q?J8sF0sjZdiCzBhthueM+0trXUNEymITohf1wARCSCVjk+GpjGFRC6sSITWRv?=
 =?us-ascii?Q?Hx9Pg/si7EnEcBuvob1awuOLNaVAzh6j9i6AszFTvVWuXc8J/lc1Y5hYa0xJ?=
 =?us-ascii?Q?QeB0IdmEutAdv3/LNjoDoDzq0Nlip98EBbm7dY0FHHC/f9fsSEgt7pFGcZ4N?=
 =?us-ascii?Q?ap93rTsLIrwdnJU3c9VsqDpXY9mTheMNFzkeQiPJjyblcPqAVO6whdINhL3w?=
 =?us-ascii?Q?v6c0CKhexJ+OenoOexwJowsjPhBlHSeMsLiDUnu+zx6Gfu7Ejw+bqYy09ZK3?=
 =?us-ascii?Q?dwpPUraRNEPNlVKcF8rufQnn2JrC2g8YIYlpun7jJVcEa8E7E3VMeYye5Y4K?=
 =?us-ascii?Q?Q2Allwk8WDi3OIAk/YhsYKLUUEaRjdhck1oew4oIuuCnvkGW26uIdusccpoY?=
 =?us-ascii?Q?2jGqQV9nGOslP08uf/kgyMz3TXi3ORFKgcI+z/7FTXwvZKfBFQTqw5N0ebaT?=
 =?us-ascii?Q?esg94ed9yxhB9OMiraIkdPPq1PCBDomg6wdvWNwDYk5vVC2Q/zDbS6/NlU0z?=
 =?us-ascii?Q?jjOVSsuQxyjRUPnG4F1tWHVcmeQ7e3hwjf1oIbvk8u2yY3wZG5YU8emHVPib?=
 =?us-ascii?Q?fgA8ccOlQqVysOQpbtfQ7LSsVbp+dkYtsVWgqlV8hoZju1z14q7U8kXQaIEa?=
 =?us-ascii?Q?aKGO2gx83hJKuh5jGh6RCMEtCEbdbeuluVPcaEA9In39oNOs/hRo?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c39bd4b8-f7a6-43e4-8f7e-08de93fb598c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 16:41:28.2239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iUb0cdKrOjQ1aRg2P2c5X0L934ZYU4G1ky4jhInOzEJ+C4lT2BzwnaaE7ZdCMrwotZF9uwITu22E0yvADGAlJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2674

On Fri, Apr 03, 2026 at 06:20:02PM -0700, carlos.bilbao@kernel.org wrote:
> From: Carlos Bilbao <carlos.bilbao@kernel.org>
> 
> The assignment before the writel sequence is dead code (bar is
> unconditionally overwritten by the re-read immediately after) so remove the
> call entirely.
> 
> Note that the DB_BAR register is a plain value written by the endpoint
> firmware; reading it carries no side effect.
> 
> Signed-off-by: Carlos Bilbao (Lambda) <carlos.bilbao@kernel.org>

Reviewed-by: Koichiro Den <den@valinux.co.jp>

> ---
>  drivers/misc/pci_endpoint_test.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 276bed3f1c18..07c5f19d5c5a 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -1081,7 +1081,6 @@ static int pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
>  
>  	data = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_DATA);
>  	addr = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_OFFSET);
> -	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
>  
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
> -- 
> 2.43.0
> 
> 
