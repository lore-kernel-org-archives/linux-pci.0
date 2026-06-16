Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011034.outbound.protection.outlook.com [52.101.65.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540873876CF;
	Tue, 16 Jun 2026 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628733; cv=fail; b=FmjUOTyycpCuqwXnzENrlIRd7uiowfRLCXekOiErG0f+DaP0LGHzL+2DX6PZuQpq4bXwWwj0vR5Y9sKu8frjemjSHDzZnH9Z+7U/Nka8UF73hQY5cA1nl78PIQ5hnb5X5/epumbShzQxGjhrr5xnxebl606SJiFfmvCjDHEOTyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628733; c=relaxed/simple;
	bh=dq6W/UUBTxzw2uPBgly+Pyl6nqrhx50MHxjP8vkah/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mfaODcx8ESj0Zz1uVcXkOvwCxWfdIZPjpm9Http63fWzEE63ubGj7cFzRYf0VQdHi4VQz6lH8vfXesxzbWdlEo2UGYcvnjksXjxyez5CYoRoZoRo5VX+3iiTRx2TxlZKq5Xxacok4sH6o+YBgpliVqAu8kh5k2xXxFA422YuMXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Ix3AXxc0; arc=fail smtp.client-ip=52.101.65.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ix3AXxc0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IqeuGujmMtSuy9NT2ETvS6/nrJ/oGInWtCa8VisQ3ECFOyGD31xv8ZqLG4aizj6uIvYMO92utGSrs9r0n9R/Txpxk9pg+coolTTJynDlssipxi4W1i0Qi0KrDC0jS7jx9QkUl5GbFOd4kKnnFzjH24pGhjPpPSCM1bElKZ9emXwJyYpLjcxru180u+DSNY1C7ZPe2yCRRIXUCRbPMj4rjj8YK38fgmmJt4W7I2iag0lF0WfU6BpYoRUoGYk2VHsCQalGKsYm92ME1bzjITBIpJGMGDacjjbj3OE6DacbVvY4RqHeggnwQQ+5gdgm8zVGICMfMmGYVLkOEPK7/L5mdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udeVsWW08wfTrG3dzS7oOYyzYXBbiX2UWL72z56GSn0=;
 b=NvExpKmQhYpWHO2TmRb6tUjhtMVr5Xr7TgFGbroybmFRCq2CxboRu2LP2KspqF64toH7sNnP6dxATl0Qdv5WRK7j/gLjlkz8BEx1GK3sXqPgFoPzzbXWbTaWJbOA8DpoO6yTLUwXHuBh+ZI3RlffUYduD1U5vSIzYw4BEqHChltpCvRNsq8FkUyUMkqi+BZmGHRp32SLidNZs9tUEocOlZmjKDOelJMUgLV8pkan226uHrYRe2OZ7fMn/+Bu+9mmipZJUjv8QIALlqmbkAoX3BaSAxkESmL2V3L9zh6KnJDJzMV5yANuXMVfPPgAUrPgVXseavHbkrKOHJNnOoyifw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udeVsWW08wfTrG3dzS7oOYyzYXBbiX2UWL72z56GSn0=;
 b=Ix3AXxc0Hb04aIx6CJQHh4Dse+B5XokQlpWm81PdTkkNmTmcvc2YF6VtnV8YQJfa2vB9moKK9QThTEPOZssFlgJ4FIFUgSJYB+yvVuH8NyT7d+XNrhMayaQwJZqS0LEruMXVxeIMVYClzBHG92IwyqXHMEtdzVZ1E3Rz5nnTj2EE5z507EOuT+UKdazJ1p1IkFG3yBSg8699wk0CNs0ueumJrl4WiKd3RC2UvFjxREIAM6433RHGjDPfKpbpEBVEqwk84VE/OOmapZxl571CqypxxfA9JTvcZG3xNqS/i++iD7IU2/bQ8Rss9/MkJBjLd/Wi+ccbZ2Jfh6pJBaL5dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI2PR04MB10666.eurprd04.prod.outlook.com (2603:10a6:800:27f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 16:52:07 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 16:52:07 +0000
Date: Tue, 16 Jun 2026 12:51:59 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sherry Sun <sherry.sun@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: imx6: fix building against host-common
Message-ID: <ajF_LyjOnINAHvA3@lizhi-Precision-Tower-5810>
References: <20260616164049.3656435-1-arnd@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616164049.3656435-1-arnd@kernel.org>
X-ClientProxiedBy: SA1P222CA0099.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::13) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI2PR04MB10666:EE_
X-MS-Office365-Filtering-Correlation-Id: e5044454-647f-4077-bef3-08decbc799b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|19092799006|23010399003|376014|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	56BfpJ7mHMIJrp37XZLUrN0ThC/scMFFGedWR62jTLEyk6ugpSIHBGA7Yng77f1sCu3qc7/AhUy1Cpya1q2TCx6/ZY+Sn+kWs5pcTgWYTIwlRWlWmky2TfuiuoMP46jfbc3862NUC0YELG2ZADbrWOmIpNSk5F2kuE2SpESQvBzJDnXBPaByrQlj87eMMvpSDP9+NyoFY52Lorzvl4P1zEb2jrpSRcGrrtYrk4iob+td8Sl+A0xtoSqC9GAd9ESh4/5utPHCM17WQsjyM4Nop02NhWI1sTB2Zs9/pJcayqrPZjwFAKbEeGIsoiNe5SAj1OiQfZ+xOJQ4jWyv6UaYCrxmy/stSwqYmzHt5+W25R5qrE4QnHAjienWsKAQgRNcCNFwOz88gFs3E5btcxRq/YmCsrwtWadY0prwA7VVgHx9sw+UpuVmZ1AB5buhl/fQRs6VS0ARVtW4Z8ZDLyNGOj5p7vxN+aaf8SHFNW6PmeeSGeLBFXzuzkrUchZTbqBuXyerrIb9YjD0bhqPhOmT6Z3vj9I1EiclkhI2MnzHiuvZEwFBfqsexZyB5CXW0mzy0pFR7XLrivpPYe5CdWnuaPe4QbwELXM61YgAQTuaHh6Co2z8NKNlSXfbif105K3eR/5BNW5Nt6MOLg5LXeoB9uAS1LRjKpKvBTRGqyieRaolMDD3yK4f+FpsKQOTQ/0N
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(19092799006)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i+KFOhKrAAXSsAYhA2CK4bXYgsxOVEo2QZmbx0C5ctUMIkKeKgPU3MHIioFm?=
 =?us-ascii?Q?yhgjRADxUqXUp4Y/rKnB6Bnjgv9l6zMqT18AX6Lltr2RtgbJbuMEeu/8cjwH?=
 =?us-ascii?Q?akD7t/IOicaTVsOxywAZaMIY4eOpQKjNnDIXcnHwHVxvSD3NOcr9rOU829+/?=
 =?us-ascii?Q?dpw6qf/hXGjW2Jy+WgkpE4Xs7lIDXsJrPFI0Mx6xakGe6NSCNuOmvH6fpuDW?=
 =?us-ascii?Q?JcDNOPepr0YcUud5cF71yGXjRo63EbIAEK/qwAW/mhU3bpTU1eU/ZZ5N+zQq?=
 =?us-ascii?Q?L8y9ATkH6q4OPnFWlk2WfUX8H6Eu6mQG222udbTJOgwOa7RVFF7leTFkyMVT?=
 =?us-ascii?Q?qIXggd92VuGqfzZblV4PwgJFowg9JSnOBG4NzDe2Ax8GSXfiyouffuFoJ0i2?=
 =?us-ascii?Q?VNaEVGIK7NSUWtT8x0chbvB/wX0YcCIHa0VYwbEXurnKmA/tOLX9J2tgJMol?=
 =?us-ascii?Q?FC6UXEBB0oQDZNLJAOqsHyuDV+87CQ+O1fIcWsLKZhQFWw7Ql5JJwDL7Knd9?=
 =?us-ascii?Q?9MJPPXOPe+caLlN9Au8EVsS/AUxnBnqnNz0FWBaucBhaygnWJFrbYyZMabbm?=
 =?us-ascii?Q?6TrLFPCk16UaSU9ekjYVhk3108NB7LQ5vxhxw8zaauLmQamYSVvpTwZ8QTei?=
 =?us-ascii?Q?Un4eDkLlXPPSrTuFxW8IkwmMCYjoSX/aOWGFSdndhPfJsjP6U4Mr+Ls5Fi6J?=
 =?us-ascii?Q?FlvN5kyLNx1Rj00p7tMh72FGdXXVzuSpGmqJhMHCNvRcRlkzEzYoS6MULAMD?=
 =?us-ascii?Q?XEowFMLJjWQ88R9BqiPoxomZtATLx8onXe4vgcHnRE9swfp+420cgHhj4KG6?=
 =?us-ascii?Q?1JmSfWkybjTZSTwbR1p8nwJVkjfbi7fEfmFsTBkdrelGQpWKK4j0Wc3E4edh?=
 =?us-ascii?Q?eZlwv/mqp1po/CBv3uyJT+hON9I4o/+VIPO2JfYQ3A+w1Oe0IiI82AlgT5Ty?=
 =?us-ascii?Q?qbuXvx1rzfdrDEah7eE2FWwws7WrebtfA2YylMKs7ZpmqNmbK13zgcltcZVN?=
 =?us-ascii?Q?+C3p3CqbYv/AIbiUpMZKiXi7m9ecvzesJPF+eM25gvjXmbbYgrcoJKI0ohYr?=
 =?us-ascii?Q?4Bjec8vfxxdV27vyKva6rOvww5dH1QfVyVVSshmB4SLVEHzxAeECSJLweQbP?=
 =?us-ascii?Q?5hb+H61mQHdI5L6lsMswK1lJdrLAhPtr44zEAJsz39dxsW6FaOS2NcZPyctD?=
 =?us-ascii?Q?m3A45XskV6OuS5sqDDnZvW6JjBUnzjqYEjZIOOZn/unKP3robOBeRFZdtnnS?=
 =?us-ascii?Q?uAGZMWLd/8zQ6YqfRvPg3OvPNaIEF1H+7RxTvt7etjitsswAwPaY1WRZ73t8?=
 =?us-ascii?Q?e1OpBgCxQiIlGK6t7y+MYmhC9bQPxxbPqIG2dWCinjX/0J3nqY6tcp0svMYS?=
 =?us-ascii?Q?T1q3f1eDwL6MpGxldXyZjEDTHzxktQbQQMxp3rbIfRk1lIDG+fBmg6lFfZ2J?=
 =?us-ascii?Q?cvcuWA+s/XgnCBtZiBMbE+nbJY2vT+QKwXsjC02cSMdFtKx0ID0SoFltg/MM?=
 =?us-ascii?Q?aAETz9TMPLUW3OHF8/aPIO8TsrO03cBbeKM7s5TTa6rMvsKXeMTXHmJTo4EI?=
 =?us-ascii?Q?zInXi02qFzBMuIrUdnmfPPiKFZCI3A8/rAFS3DF/mYVvP1sMynw8nn8NXq/l?=
 =?us-ascii?Q?0z9Kj+VCmlk6RlhfC/DSarCp6aCIZguMOFNAlRGCPyAZA6xTaROy+RsZbG5w?=
 =?us-ascii?Q?DmtzVHfDypkR7TjyUX3bnGFocU/f0bA5lV8QkJXmCvSGxUwFvZbPTP7y8BO/?=
 =?us-ascii?Q?05zG14HC60GGHSLxw2AHZJcJg4TtoWvko3lvGF19UpGX7eeWIvGg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5044454-647f-4077-bef3-08decbc799b6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 16:52:07.4146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zj3OsFsrnlPavWbned3DwR/RvQMRgxJJUe5IjZpeW6t5T0LbZTas+k4/6ZK4pCkz6GSTv1M1bUa+EJVSiSgUTbv98elOi1auv8WzjviYF0+TUTqTWfvpmogir7LY8pXA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10666

On Tue, Jun 16, 2026 at 06:39:59PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> When CONFIG_PCI_HOST_COMMON is set to =m, the i.MX6 PCIe driver
> fails to link. This can happen when only i.MX endpoint mode is
> enabled but not host mode, which would indirectly enable the
> host-common driver itself.
>
> ld.lld: error: undefined symbol: pci_host_common_parse_ports
> >>> referenced by pci-imx6.c
> >>>               drivers/pci/controller/dwc/pci-imx6.o:(imx_pcie_host_init) in archive vmlinux.a
>
> ld.lld: error: undefined symbol: pci_host_common_delete_ports
> >>> referenced by pci-imx6.c
> >>>               drivers/pci/controller/dwc/pci-imx6.o:(imx_pcie_host_init) in archive vmlinux.a
> >>> referenced by pci-imx6.c
> >>>               drivers/pci/controller/dwc/pci-imx6.o:(imx_pcie_host_init) in archive vmlinux.a
>
> Select the common module from the endpoint support directly.
>
> Fixes: 250eea5c06f5 ("PCI: imx6: Parse 'reset-gpios' in Root Port nodes")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/controller/dwc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index aa0b784c85b4..7d49027c6736 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -126,6 +126,7 @@ config PCI_IMX6_EP
>  	depends on ARCH_MXC || COMPILE_TEST
>  	depends on PCI_ENDPOINT
>  	select PCIE_DW_EP
> +	select PCI_HOST_COMMON
>  	select PCI_IMX6
>  	help
>  	  Enables support for the PCIe controller in the i.MX SoCs to
> --
> 2.39.5
>
