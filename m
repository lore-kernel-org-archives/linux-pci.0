Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010064.outbound.protection.outlook.com [52.101.69.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C659374174;
	Mon,  9 Feb 2026 16:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770654845; cv=fail; b=mKTLh7QDFD3tzlqdqH4WwGj6PdrOqzFAWHWwM5We6n+y0l5m+aQjNMaATgfok/xjgEUROmQrNwjkSCvvXAvuxliSkdTCyYLiYph4wCxljgzhB+hGTToLNwXCIvjNdPJQ4acNqCMC6pJRsAEX4saLVVVfhZNFZr9OlOxZg/42UxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770654845; c=relaxed/simple;
	bh=MD4bB6j156YsKIKlfme7jaZT89QC8dlwruGsWze4It8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AFT7yp8LvKCfO6jkKjhHa0s/9SqEEQDw2vmWrwp5eDDl5ugIu1QzduvugZhIOVdeeCT/D/Ch2oAQTGyZqfNRiu0ifMYYzbBeBll3gcoB+MehoNmYK0vEGflcRqb5fca08cVTkYQbpLJyM9UThUzDd5GSAsSfXd/jAOXAmyu0i2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Cy16EfwJ; arc=fail smtp.client-ip=52.101.69.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cy16EfwJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHwwh0FYt4qr+KCFXVEN/ubgjMIrovrNO9nurasMznCQqOzBqUsEr7DuYqdFNFB4PgQRgdpdieue3VXYRPw8jrBOxGmnhm4fUlQw2Rr0ybeTslo0XdZVG4QjVTgKaoYl2sN2FxEqq5tnrzOlglmXaaQMVfFOsIgVCTIipB831bZobH8R0fKIa76PxO+tbxaDg65jBBxjcq4/3BJNV4FnRtJ4hsviJaBFvcZ5vhXsIgLv+PwOj+FULOvue7n5uLYqwUaypHbH1BplyKgTSpkKxNUYnGM1PNC3Hbnge8RaA3zWkOQ47KwTmYN2/d9SMynF5qkRSkYA54OWbuz9KqocGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxIMIJWEETfVPRtJCxmPLE+EXDs0d33femYZLVwtdN4=;
 b=L6dPFkwQvqS3JbG7ne83GpqG/VBIvpgfTWpdmUjpCnB47Gy6ENeROKb7QaQFrERMDu3/rHlwGHkR5N57pi0vqxXVeAu9DtZnJ2fseE6Mp5fFtyIgbUIbYL/dUqVVysmGSZfPglWijr3Q6v2IUzwmJBXhIUG8VZqU2a/Z66QyTr47Za4JSouuNuUVX+R2ludMbSAt6h4tKmpD2k5uy0IVD6w0uFSsjAeSbPoJkzuzFRMIyQbygU9MHV0PWu8Y06LBChEucaePYT632ukkWGToItguCsX1qTpoeVtQtRSJ6rFA1dKLeQUQ7WLJf8ft+mIcn+oeJuq+u1jOlyNJXvEYBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxIMIJWEETfVPRtJCxmPLE+EXDs0d33femYZLVwtdN4=;
 b=Cy16EfwJf5UptWcAWoKgiG0jlkg+Kp1iDiLhb057kegwIZG9EO9XSgf+49tAUgFwEGopNnuXmFdIHHmitTx+TInKKwKEr+MFiAgkOcFg+GcDQANaST7/SLruXdD0C90maZcuRulupSgwagLdbGNLdcLbbwdvEC3w6ufcD1TUv7EkF9jXnVQzSq1f236MTWVW8lhwhMKFpZWehwB//U1XiXJMFpFHjxCWf6M3vFCbLZ2LAi0K4JuB5ZijkeAP4VrgdkGqy+PdmUKRKrkyRWJx3IPM5eASlKH4JjMVkg+Nv9nMNu3OwZsVDuGWlcPUKBpR/D8PnuXOOPjRMSRpMaN+kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU4PR04MB10575.eurprd04.prod.outlook.com (2603:10a6:10:585::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 16:34:00 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Mon, 9 Feb 2026
 16:34:00 +0000
Date: Mon, 9 Feb 2026 11:33:51 -0500
From: Frank Li <Frank.li@nxp.com>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com, will@kernel.org,
	imx@lists.linux.dev, kernel@pengutronix.de,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 02/11] PCI: host-generic: Add common helpers for
 parsing Root Port properties
Message-ID: <aYoMb89MeP44xV8N@lizhi-Precision-Tower-5810>
References: <20260209082454.2097628-1-sherry.sun@nxp.com>
 <20260209082454.2097628-3-sherry.sun@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209082454.2097628-3-sherry.sun@nxp.com>
X-ClientProxiedBy: PH8PR15CA0021.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::24) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU4PR04MB10575:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f22c93d-ccd8-4788-35c9-08de67f90709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BATJd/mib5NvFqWQa/dUa/6a6S7LO4v94Xh2/NpEUMYOc1QMmHEFzVElXxG9?=
 =?us-ascii?Q?yByxlbaVt1xhEFAejoR2x43DI+94SC8ITSL7Jzb9W/wJGLqxW6EHkoEuKXMe?=
 =?us-ascii?Q?CbQ2Vp20fP7W8zn7dFdUMkcCX/YhwNcOV5P/XnxwZlqbI9gMVy5wewxsAKQJ?=
 =?us-ascii?Q?d3OqwKRdRR7/clWKanu7cbSddRLKyYWe0n1GXQbZydG0eJi03zGMJ64W65bk?=
 =?us-ascii?Q?nIz8LHFl4SBBd5HGEEQ3GZ9RdQEhg87kYxomMcMT2+dHPLc4e2G2YTjOaORl?=
 =?us-ascii?Q?bNMT6HnPGJfR/sYlsvKt+u4rM686R8Nczpqh+o1qInjGr2E1N24sBqeBwiy4?=
 =?us-ascii?Q?aN4li96E3ugiYdjV5l5pStB/jJ3Wd1F76aMZHVQRk0n58N2B4R+sSc/btfGy?=
 =?us-ascii?Q?R2KBjjuKd2tA+jkPaWLvWAUn84yM8PjT2Q1R2tbfdXjQKNKLLBtEUeJwzm8t?=
 =?us-ascii?Q?wDF3a4rHg9Al0UWJiF9eppm7UOojv8Tbj3gKf5GTzt/1K4OY4YOVZO3d/0a8?=
 =?us-ascii?Q?GXHxOZQ2PssV0W18zr9cQ8BwcicTjxzxk+Mno+VxPt9WOfsKMKX69cHdSKte?=
 =?us-ascii?Q?DIokLH3RN2qrtbcX49NgsjHhqqtJk9UZEflMbxQBMC46t/sxulPmEmpBCK5D?=
 =?us-ascii?Q?Ao7wuoC3drVgXUI8lHeIFcvTE6f4kZS/6s/co14/vIaZUz4Sns7Tx64Svebw?=
 =?us-ascii?Q?Fi84j33l/cmlDjoUgMakOBxKGdoVym2U7dbK4Di5BRxYC7psHrNqZakIc9J3?=
 =?us-ascii?Q?GWkKH0mQhlrLrPeuByTDvOmpbICYxgxYkU9E5G7Y5T4+6bKh4roFKMRMkTHT?=
 =?us-ascii?Q?hqj3l/qPMiRNTbHIuTB987qagWI177QBFUSH5fI3QCpvBBVxyY8anuYrj7mw?=
 =?us-ascii?Q?fizU0hVnFJ0ef6v3aDrst1TepeCB4nA3q+v5sUsNOylU+8FNHysaJKMEm0Cs?=
 =?us-ascii?Q?CzI64GmNNOS3zUEjM4bAoROucsNqCA6XrsVrnFRrxCzGxSzC6hLzVbVjLLYO?=
 =?us-ascii?Q?DKZjMefFavSkgOUECBGKRgU5Kuf+UR2yHHLiy9WiFsqdbF11K15wRx5bf1as?=
 =?us-ascii?Q?qhUC6LRlBdTD2Cxwb/1JSrD0UGzVv3a4HGSbnSzOffYQji0rvgohmjS7vCi8?=
 =?us-ascii?Q?yMUcRJjQAH7llhYrhYVskQztQOKH5PGmIycLaqOjNni6lVHqr2lGqVZ0j6Us?=
 =?us-ascii?Q?Sem8XbhpbXJxmIhVzg2WGJRw0LMBaNSEOzgDCuquaVKjaujzXeP6fxRuqEOI?=
 =?us-ascii?Q?vKt10Um8k/VRJgjcT/wmxAaB8LXUjwWPZrUxc2tqIPW24zBK796fivQiJw6U?=
 =?us-ascii?Q?FqZZyPCfU950opHqtRbs82C8eZ8WsuOnQ3o4ZTDMKUmvxD1ZC33A+cPn5o3h?=
 =?us-ascii?Q?Gm5AIyliQ5VwHKy6A+mAyPT6mVZmu8FmxD5/apdpWA5ZHKd9IarTzqsXcMoa?=
 =?us-ascii?Q?vr+zpvPFZNQo/pTPKcHvJ6tFgjznd7b9VQzBrSmGoeAgdWU9qp3pQJsMuOwk?=
 =?us-ascii?Q?d+sCnzoPGp1+88fjnEVr1FQYu2tkwDv3xf40WFROXbuJA8atmVFucsEC9mhZ?=
 =?us-ascii?Q?BKVm7zv9uok5VA9cpDetmI7qqmPptCkevQ6uPtUsbyi/7PNIax+4LyqwlutY?=
 =?us-ascii?Q?2934XNJo83wLvLyXaK/6mFQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RPXO4LZr4I7QGt2tLfxdFd4Hp97qvCd0nwDZIgh/DmWpQ8hwUmhJZHaMwLJC?=
 =?us-ascii?Q?QgRc2bxcQEZFuHbUW6Py68Wwki9cTjpaGqwKtnSE2gz5zMIh45no5pIfekYm?=
 =?us-ascii?Q?PYMhoTjXf9JZNPZlI5z3vWDRGE5UyLDSTpwJMAGJCtX0LxojCH6WZvPtANYr?=
 =?us-ascii?Q?dP3l1VzmR4t23KLHUo/pGcnN0k/2GMCPrW4tnxHP3f1w/p+Fm9SvK3eWUIXa?=
 =?us-ascii?Q?Ez5hfDI4RMJc73ot+Y1fibv+kEqA8NHz1B4aeawPAnOIqoN7BQVHRHpQZK5K?=
 =?us-ascii?Q?fuKLbFVltYheg/AlqAFUcTE/rK1+gw70Qpl9EbcKCMZOyS3nfYzCQzW4JY/A?=
 =?us-ascii?Q?qz17L30E2cGsmnd5Shdqy3uBe+GDdrB2sxNR0t33VpYyCU2R9i9DbZm4s/3m?=
 =?us-ascii?Q?xUvs/SDwkyXojuSZiYOV0IIBhMVfb5VAfs29UqLfr+AqpJrbObH9rZg5LgB8?=
 =?us-ascii?Q?0yn+5uSCTG1XxWU6N4BjXwGbj1wCNqQdgDarnb8MoETr06eAUJyQ29IjOazZ?=
 =?us-ascii?Q?9KuFW+gVb/17YHHykLN2hOJkX4Shv5+61L3aFlVjScjFTmvtyiD6GLacmZ6f?=
 =?us-ascii?Q?Ac8kXKEGUud3PgdB4OSaALT1ahmRyK7gmZyEa1e5s+9ZbpetgXzeC5s1HhBK?=
 =?us-ascii?Q?BcSyniHwvUjx0xWp03oP/8WLXeZ0TBTs4wIb3skRQtly1rhJBvDfX/FtiZzR?=
 =?us-ascii?Q?IUSafxUcdGmZwQ2qKgIWA71oOkDHp8DYSi4EbysSBPeWKsDSKQIrdLjn/7+N?=
 =?us-ascii?Q?fqgnAKvf2jZtQmGACrWNpdr0JYwsqXJ4G3h8CaG/DqUD3kq5wDf3DQca8Rcu?=
 =?us-ascii?Q?kVAhwkwfHscsT7HUXitMFw72g9wox3+DmEoDAY2ErcujFvANIEDO7vx9pUeR?=
 =?us-ascii?Q?9mauIzNQ2wyWQurv51FM8idz3W70o/y/cQJq2r64fMSn2TVkljrKG/j5BScs?=
 =?us-ascii?Q?AV8OL1ZWu+0Glb7cEiVJ8peEwC+uf2k29Fmd6bYmB0El1gI+2h6UuXHtgMrq?=
 =?us-ascii?Q?KhyKhDKrDxlZiXv51eLO2BmsS6zxQaN2DHk2YTAX7UlGCl1m1MFR1h2xCptb?=
 =?us-ascii?Q?L/88a8b0r00+8fgmyhWnS4t/Ps/VenIByARS+NTPvqk1jy8iAiju4qoXdBr2?=
 =?us-ascii?Q?7Rtn0UrXSkj29BjQ5K4i1J7PYfhCbOBUfeiJXcsON3pj9v/KXV7nX+MZaEld?=
 =?us-ascii?Q?EigakSd9s25OMSLw77mYrbFty+YAvLHMh3zaeh7sXYd44sWVTO7kAZ2oVu4I?=
 =?us-ascii?Q?WUzLyvNc1+A24YTO79foCMohnZUkLGFNq+J2pmcELag8bVPHTPQGbJ7X1jro?=
 =?us-ascii?Q?yQWr4np8dKJxOqOfGzztUXBsccOJ1iI6s5XDk/lP6XCZAfz0sbVUFYQWJs6o?=
 =?us-ascii?Q?niIksoK8wBoAcuSsvQjNMwuSKo8uJO171fmynauUteUKrAE3sYRnfDUElE8c?=
 =?us-ascii?Q?IDS+0wvAZLvwbpFHRYtWDuIMc6Td4GIOpm5zhDrdd0jz16ymZuA3KYi+33XR?=
 =?us-ascii?Q?4GO/vO81R82XihKn3u8eorOMIdEoUgOq0VpbiKTsYzYqVgcOcjGkKcDSPcOE?=
 =?us-ascii?Q?uBLUmnMfDaimvuaJho9sB6YwuieXqSKMsiY0GGE//Cr0AlBaeRQuMIK1p0U/?=
 =?us-ascii?Q?KdJ0yKeucPfTNleFPSQ99aa67Y4p3Ulgv8DkFisMS23/9ofh3nJGGaO2WP+u?=
 =?us-ascii?Q?bS6ibs+MZ2N2V2hHFbFD9z1zQh1DL+m9d4GyEEsjsS5jIJAM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f22c93d-ccd8-4788-35c9-08de67f90709
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 16:34:00.0226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0zDGAeXzcHHR46Ofw8MYZepEA67tj2N1etcJOcq9JYGYx5UTypaC5tJGcBcR7nmBdPBtSuV27Qwe2Xl8aSaqOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10575

On Mon, Feb 09, 2026 at 04:24:45PM +0800, Sherry Sun wrote:
> Introduce generic helper functions to parse Root Port device tree nodes
> and extract common properties like reset GPIOs. This allows multiple
> PCI host controller drivers to share the same parsing logic.
>
> Define struct pci_host_port to hold common Root Port properties and add
> pci_host_common_parse_ports() to parse Root Port nodes from device tree,
> pci_host_common_delete_ports() to cleanup the port lists.
>
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/pci/controller/pci-host-common.c | 75 ++++++++++++++++++++++++
>  drivers/pci/controller/pci-host-common.h | 17 ++++++
>  2 files changed, 92 insertions(+)
>
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> index c473e7c03bac..287e92df0092 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c
> @@ -9,6 +9,7 @@
>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_pci.h>
> @@ -17,6 +18,80 @@
>
>  #include "pci-host-common.h"
>
> +/**
> + * pci_host_common_delete_ports - Cleanup function for port list
> + * @data: Pointer to the port list head
> + */
> +void pci_host_common_delete_ports(void *data)
> +{
> +	struct list_head *ports = data;
> +	struct pci_host_port *port, *tmp;
> +
> +	list_for_each_entry_safe(port, tmp, ports, list)
> +		list_del(&port->list);
> +}
> +EXPORT_SYMBOL_GPL(pci_host_common_delete_ports);
> +
> +/**
> + * pci_host_common_parse_port - Parse a single Root Port node
> + * @dev: Device pointer
> + * @node: Device tree node of the Root Port
> + * @ports: List head to add the parsed port to
> + *
> + * Returns: 0 on success, negative error code on failure
> + */
> +static int pci_host_common_parse_port(struct device *dev,
> +				      struct device_node *node,
> +				      struct list_head *ports)
> +{
> +	struct pci_host_port *port;
> +	struct gpio_desc *reset;
> +
> +	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
> +				      "reset", GPIOD_OUT_HIGH, "PERST#");
> +	if (IS_ERR(reset))
> +		return PTR_ERR(reset);
> +
> +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return -ENOMEM;
> +
> +	port->reset = reset;
> +	INIT_LIST_HEAD(&port->list);
> +	list_add_tail(&port->list, ports);

Suppose need spin_lock for link list.

> +
> +	return 0;
> +}
> +
> +/**
> + * pci_host_common_parse_ports - Parse Root Port nodes from device tree
> + * @dev: Device pointer
> + * @ports: List head to store parsed ports
> + *
> + * This function iterates through child nodes of the host bridge and parses
> + * Root Port properties (currently only reset GPIO).
> + *
> + * Returns: 0 on success, -ENOENT if no ports found, other negative error codes
> + * on failure
> + */
> +int pci_host_common_parse_ports(struct device *dev, struct list_head *ports)
> +{
> +	int ret = -ENOENT;
> +
> +	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> +		if (!of_node_is_type(of_port, "pci"))
> +			continue;
> +		ret = pci_host_common_parse_port(dev, of_port, ports);
> +		if (ret) {
> +			pci_host_common_delete_ports(ports);
> +			return ret;
> +		}
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_host_common_parse_ports);
> +
>  static void gen_pci_unmap_cfg(void *ptr)
>  {
>  	pci_ecam_free((struct pci_config_window *)ptr);
> diff --git a/drivers/pci/controller/pci-host-common.h b/drivers/pci/controller/pci-host-common.h
> index b5075d4bd7eb..2c8df230886f 100644
> --- a/drivers/pci/controller/pci-host-common.h
> +++ b/drivers/pci/controller/pci-host-common.h
> @@ -12,6 +12,23 @@
>
>  struct pci_ecam_ops;
>
> +/**
> + * struct pci_host_port - Generic Root Port properties
> + * @list: List node for linking multiple ports
> + * @reset: GPIO descriptor for PERST# signal
> + *
> + * This structure contains common properties that can be parsed from
> + * Root Port device tree nodes.
> + */
> +struct pci_host_port {
> +	struct list_head	list;
> +	struct gpio_desc	*reset;
> +};

I think it should be include/linux/pci.h

struct pci_host_bridge {
	...
	struct list_head ports_header;
}

So all API should pass down struct pci_host_bridge *.

Frank
> +
> +void pci_host_common_delete_ports(void *data);
> +int pci_host_common_parse_ports(struct device *dev,
> +				struct list_head *ports);
> +
>  int pci_host_common_probe(struct platform_device *pdev);
>  int pci_host_common_init(struct platform_device *pdev,
>  			 struct pci_host_bridge *bridge,
> --
> 2.37.1
>
