Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013047.outbound.protection.outlook.com [40.107.159.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9782E11D2;
	Tue, 10 Mar 2026 18:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773167362; cv=fail; b=MdGbK6eemk+aG/ThzrtPUFzIXLog04pbXG0Kq0HszBHZhlWV7Lud4ucTfEbbN9B90K0l25dO4FI7dI7j61W4ixvxtxXnytsfD45yKkG1od/xWlNlVP+ccZnSCY/tF14EiXUWTH47vsIteaMgQjs+M+Y1UNp0elMt97zStpDY/H8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773167362; c=relaxed/simple;
	bh=2iT6nbxXqh9Jj09ppsCOAUW8gcnsVozyQiQDqG87cRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SK2Pdl0S8YO2o5AbOr8EmdsFGUaW8VbalvCyzHua24TmupntT7h1ZyBnIKFMcSRW4Ge/F3WEH+PqY4lT4JOwZO7yaWNGeRSlgXyXYGIW4g1TKOOBREkZfOl6Xk6EWIqUvURBnBhEd2fcI7ErlvLZg/rko3pFJkvpNNcYjgOBE8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UXucI1Lh; arc=fail smtp.client-ip=40.107.159.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UXucI1Lh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rodW3joy5j8jyyCeEkqGh2jDs/tHGxldEXMWaoospiNptoZSx/bdeGVAE5GYz6FKRgT+LAt9bOiZzrtoV/b1Bqb8QUYIjNOQ41R6/6GAzHPNL78mYpPm1RQ8p+ixIkwECYBDMx+JDKcV8/+qKZ3Z8HXGTqWa+6B/urfZQqZQhN85NW5Tl2iI0L9znuM1Z9GsehEz7gbwOk8P6DvveiUsKUKdTXlOnwcJd/c/fCyxu5bvz5avQqmaxf+PEolFopFrjuIbN7a4qnnnn4KxBng3l/h9x2WJnTtCKLj4i9pzaVrylB8V6c10TQZV+fMRyMutOwm69rt87dubVewNiHPVtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpqc9LFbKEFKY/ggZV6nVrbLGMlneCVAvM3TxdYW01I=;
 b=QL0nreO0CXJ4cpx3KefMUHgs6kstyeNuMndZiiYN1OgyCpg9uAoQTW3NSnZg0cEoxfzRjMnoiUjeapZOHJ/aGI3sYtCyrNfhdZS4rGoJk9n70x/z/6/DWA7bKA3iLfY2I4XvAJVjFMu5ET2SP63y2QD2nF/8gkzaSgM0J2XNdqEPmOpqq3fFzNOKlABfcu5OjHvdqPrp1KdxTRQrPc6jzzZfEPlanhKt/cjiSmBAGJydZpry+098af5Fjdu0f4NQtZbuDlAo+eVti6f8NfsR1KabTyf5ogEda4kBTisdjCc+l7Hc/ADMk6wHhwxdx1BT8UTIhQlCQgPB0FfN50Wygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpqc9LFbKEFKY/ggZV6nVrbLGMlneCVAvM3TxdYW01I=;
 b=UXucI1LhkBO3iWONGjTTBZan4EDR50Rn3zNerHuR9B80BlNzK11sMDxhR8qxONowr2myobObl5VI5XG1xLZxSjm2P9j5tADy4EP5nJ1/D+3gDeE6LHb5M+dlIf1wyuhi5aITj17UuAvIacjhs5yLea+cU2FVTPfCujAbyGm0c1AZFM78BoXmKT+o0jVxPjNzB240iG7GAFFwyHBDQcN5rd5Z8f82GSh5PZylJJ3lvj9yIhWmMla7C/yEChUXlCdIScg5WPMCZte2C41Oz7f5XdmA5zKuLk/Huz7ku7UA20pcwZHNA4hqdTP5TXrt3SkJVEJ1kaIY+X6STdUwDpNADw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM0PR04MB6929.eurprd04.prod.outlook.com (2603:10a6:208:181::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 18:29:16 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9678.017; Tue, 10 Mar 2026
 18:29:16 +0000
From: Frank Li <Frank.Li@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	Frank.Li@nxp.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: Frank Li <frank.li@nxp.com>,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 02/13] PCI: host-generic: Add common helpers for parsing Root Port properties
Date: Tue, 10 Mar 2026 14:28:53 -0400
Message-ID: <20260310182854.2226939-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310015426.365675-3-sherry.sun@nxp.com>
References: <20260310015426.365675-3-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::19) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM0PR04MB6929:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c7e284b-016e-4f19-c8ba-08de7ed2ef9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|52116014|366016|7416014|1800799024|18002099003|22082099003|56012099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	4SZn8aq5yJf01JXJ2sJdkhJ0nZJyuTmxc+gifGVtl2rD2fgB9ZCFhHmiok7Zf67zobcB4cJC21vBAB2+4Frp5ZPj/boxG39EMxBAXhNmXoZRyboOfDl9ZrYJEDpa9WxPPVo/taglzRdUj9RyvhhCBiRfrJNIydQIjZ3/8etWDirxmCRpkZlGGF0NTrcNl1BKy8YpXRSL9TRWbn6DY4yUG70W3wYgdYAFJxBMIyjLkllPZJDpO7aVqr6MuA79Hpzwhq1tP3HeiLVzk3yUJN8Z2OYMCXrEaon6D2mMNJl/QhLFi/padmUhOEUUDT4qCeg7CKeo+QblQt8QHw6BuA+5WjhePrsKy5/xGD+RM8UkSUbuYOPMjBUYh6IfqTOVq6jholf6+cjnQVIXbAnww0q0gnQn6GYNLS8F7m58xYv7a12Ft54+euM+3PUZgsWZTfVvcSksxmNgXQbvPIdxxF3p8FSjGq9l5/yk1SmHjmfOYn2skPmCdmP9O2SmbxM2KXkflQq2tXLQnipmi+CaC7URt0mSXQcMH3HyGJnKU8HEbzDD7P9gpGOTe0LoAI9khLIUyfm6swaTLX0wnGjb2Ke0qXpztfc0VNs0YfZ39ptGXp/uwMvfntExk/q9sWs+5xCZJISmK39jS3wCD0UELHuYr3otw1BRXg62n1dSnaRt8oGBAOnNhJIsIY/Kj8iK9PtzHMMXeFYJiV1zd6g2AGFE6aQiBAPLEBvtkRRyueHNZGekUE7xSNqJHFvFXU8anuCOiQ4Yv2k8YqTmSe4OB0m+f11ofjbKYZ0tywZjOP3KzngaTQ5sv14ZqAusimSQvn+E
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(52116014)(366016)(7416014)(1800799024)(18002099003)(22082099003)(56012099003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1nCP/AI2w2JjTGpDGKmSygH+8NmebOuy3AIiEzooueEziwhLlDb3ez9yS4UU?=
 =?us-ascii?Q?bganJAtqBOB0Jt/LriWkFN709VA27t55UKc6faazUcC1bboPbCdy26dRIJ5H?=
 =?us-ascii?Q?unEuhb4TCdihAPbe19jvMlM3nDNtu8ZOxPBVjOWRBYOvBcGHvvDRQ1nO+/Nc?=
 =?us-ascii?Q?BVeE+C2ZKEptRT5Hz+Lr7uKdzV0dPeg1RZepMO1Ad+tDd12+tBeWcqoWx+DY?=
 =?us-ascii?Q?YrnS2t+ToFaWisEYCuZ2kH0nVelb+zW5wegR1lBm4o31ceRfpN1bOsXX0u0k?=
 =?us-ascii?Q?rvI+eUvQtVpx5SaAmVzzZGsO+QcnhV4ZvhYmPoTNDExee8YxmgDJZ9yRxcKS?=
 =?us-ascii?Q?m/bN7fvBQPCImEWBnXLWbIk6lx7hZBuuECFLYHP+luPxct1Ewjx6BI28Eq91?=
 =?us-ascii?Q?lbUSpNCC3RM7ce1JcUf0NaiBVGGEMRzqPUU90ZaO2iJ3FraAnvyQfjUO0TOj?=
 =?us-ascii?Q?scIvi/VQ5bwr5nfvL7Tpe4QgstAWbWUSWNR2l1j1Y/Sz7xrexoQx7+HeAAgY?=
 =?us-ascii?Q?jWEVMe/0KtbvPS2d+7KSdBJjXaFMa4tSCLz8brhxUz2X9obbwrmg4p9FgEcx?=
 =?us-ascii?Q?TF+hbrBnoAWKz1vQ0LCY8gpFW2JQUh2LDFpBsgDzc9PuKWe+xVYAqGsPibdl?=
 =?us-ascii?Q?FivaEppbRyTHwHYzdl+nuxrt0H5E44dBS5WDGYC1DP2CEZI55QNPIHeivG/F?=
 =?us-ascii?Q?GK1V2cQI3x2ib4eFYBqyFTEFdErSl0PyopEHkDgNb3iBbR3rCw1T47tDmLsD?=
 =?us-ascii?Q?f1Eb5DfNv3TtJvGdBUxeDqBeUVdOx9fC9W8Mg7aIXM55HvSjC9fo5xrIdELQ?=
 =?us-ascii?Q?gMvZcW4zO3v/2ezXSv01GaOYcol4P7lk/Nm0fAgiZtxa7gBVJGPo8F2kIdD+?=
 =?us-ascii?Q?W8Qfr1AxyKCB+fNvOjLQ7OVekvpLPJbzzXLFGdbajPdhKs4gtVMZcqS2lsBA?=
 =?us-ascii?Q?0xa3OsUBE8dkGCqkZQvdkxw/qXuHsVE0TiFOXlucvbt0LmsxqPYVoykBPCBW?=
 =?us-ascii?Q?WiO3V7uVYkE2d4abE0jOkdeVceg198wbsU59z3s7vTXGU+BR3G7gOAVzs1nl?=
 =?us-ascii?Q?7E6k+UT3TFMX6cou5FVKWxY0jAhS88UtHEue/eFwKj+RzevK9FRPLewy7QeC?=
 =?us-ascii?Q?NyZORPjDCbyhbIfxBrfCpaDLQBkCeN709UIVB+tJc2O2WDVzLdq2gvDl5GMP?=
 =?us-ascii?Q?aDKao0hX6+p9+LWyZc2aRiNit5gjzE/SWTqPfGp0wV+lMz63riOcHEgiaevf?=
 =?us-ascii?Q?PsQzpMU+IFJ8KaCzkvho6TK6tw+1C5GNRdRYja9qmHAfXyF1ccY0vSPFg3gZ?=
 =?us-ascii?Q?6f2AfuxjeYIJWLbmpbuYcCh3ckP86rtZ1DPYmHfdBF+5EO5R6tsgu/R4MSXE?=
 =?us-ascii?Q?/9EMoUD43iX2j8LxCirSZOrYefOAmIIXRG015BBR1zX0I68gNU3B1IRmt+md?=
 =?us-ascii?Q?w2ru7EkOD5+otx4IQD/1ojYdwm9IQLe+/QX53gz/TT39wGVSSIi2yS8BQpJS?=
 =?us-ascii?Q?gDS2FJFNi0AgkTpo84s8LlYj4jTeV1KCHJHl/cTdlrzXqukuSCiRoqYdtknm?=
 =?us-ascii?Q?PFHX1qtmfY4Wx7QNTZfwrUzURfE0jiJSFWL3vI4XEaenHuAMzRi3ETsL4K41?=
 =?us-ascii?Q?BE7EpTKWySYqg7Dm2rnmriVqzTEnVUwC0K+kWVxw5vRwPj3NKDpJrnYpU1wl?=
 =?us-ascii?Q?d4JYqqSrhrU+FAXFPr5pPyH0Jl3LmFz4ZA7GeQ9K3E0fL7RQCqHFTV2VUnQb?=
 =?us-ascii?Q?MSvJrhB8bw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7e284b-016e-4f19-c8ba-08de7ed2ef9b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 18:29:16.4619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7HRAJzPjkfu14dsyolKfPbtX/CP/sFtA607jtFA0M9PxR9aWMK8hyXWdkmMSAtT+IjpgQxq1f58+5bDLUD3Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6929

From: Frank Li (AI-BOT) <frank.li@nxp.com>

> +int pci_host_common_parse_ports(struct device *dev, struct pci_host_bridge *bridge)
> +{
> +	int ret = -ENOENT;
> +
> +	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> +		if (!of_node_is_type(of_port, "pci"))
> +			continue;
> +		ret = pci_host_common_parse_port(dev, bridge, of_port);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return ret;
> +}

AI: Returning -ENOENT when no ports are found may be unexpected by callers.
Consider whether this should return 0 (success, zero ports parsed) or if
callers must explicitly handle -ENOENT. Document the semantics clearly.

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index bccc7a4bdd79..9cc3f4ebb370 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -647,6 +647,7 @@ static void pci_release_host_bridge_dev(struct device *dev)
>
>  	pci_free_resource_list(&bridge->windows);
>  	pci_free_resource_list(&bridge->dma_ranges);
> +	pci_free_resource_list(&bridge->ports);

AI: pci_free_resource_list() expects struct resource_entry nodes. The ports
list contains struct pci_host_port nodes. This will corrupt memory or
crash. Use list_for_each_entry_safe() with proper cleanup, or define a
dedicated pci_free_host_ports() function.


Frank
