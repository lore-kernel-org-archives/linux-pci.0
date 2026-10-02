Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011044.outbound.protection.outlook.com [52.101.52.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453813B47D0;
	Fri,  2 Oct 2026 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790934522; cv=fail; b=uzjhFo2jXpcYsoPEZSkM3YupTRmUn6Dh9HH0XX05NlJJvwqttKZs9Mr2JlbjFofvELD95y1/yfrg//XGJ1e/zM9Nznxeg7pKKHGK++OtM88sytQxQM32uQ/n5sINhrICuyMmsBIdUx4CU/bxZ+3z59YUHYdgy+9M9gI6D9eLbEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790934522; c=relaxed/simple;
	bh=L9tHmxpWxdSR54AcDxoF3IQuE6pcGDbUZR3DQjvOtfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RfMrJsLMhIJKnSOMYONTXfVsK7pDWDvro6PqWJ9PiptM8BGDeweEwyTtfZ+80p93J0QfPBK/ShesQ2FOFV645fkg0c98JpIt+Iruxs1BxlQaloyfbCoA/1sNCaeCAtGm1DlwCt3AVeiOk+90zYGh5AJ6d5YstwA7R6aDvGGkC8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GH1g1Iwo; arc=fail smtp.client-ip=52.101.52.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GH1g1Iwo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkHcJ6YK3RWfG84mfyB5wiNWBfFit/rbgym2L8isnFJzIC7dTwIT4pNWQbs6vyS2UQuz5nwnjBi4GZ+71C+VNkZyEFlwq0bjcb6nZEEyyZiXXV4s15aKDmx0O4Ain3et1MmkXFjrfBlcC0w2qQIInZQyaHUMhRHzg++GFwNfBhwfuK6mJTe+PUNFZQ1f3bGIzig89zdrX0VIP6n19Zm1rW43caSmn1L/CgJF5PTs9qN/R11hKImZld1ahjy/a9sQXP8U9Bov6/O9kKKljS70mQBVqIVSti007+INFe7O9oVsz6Vfe3TywQZaEC8CNAfSLjyaWcpORgdxZb8Fp4GkcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGXlJQ+5Cruwp2DRWD+B/XFtw23U54f0X8YItDNBQEY=;
 b=lBfe9BGXKlnX9sLpG8UWspg3t2Ahr+M2Ph1zUTT5Qxe4zG8Qi8ybwh8QeApRy+mdoFxSSHu7PuXySfSDuhl3ecWeriAu4viCjCjUitXyfXJAP6+kFsd9QuXnboZmeOFEqY4BrFy0bgDaGayZmSSlvJkB6sMbIGqSoqR6abqjiTsHPB6VKA17V3I3VBKVbJDuFf5+uz7tECnLb8RIeVxH6om40sr7oI1xpYPPlYLKmgtx2f/N2VgyHBh8QoJnMQkraomqyn6U7rEwBHnjMNswFC9GMSg+2Yrdoi6/tdlCQFNWuLRHGBeWqzjgOQQUI0flralY60GSphFx/GzPi69EkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGXlJQ+5Cruwp2DRWD+B/XFtw23U54f0X8YItDNBQEY=;
 b=GH1g1Iwo2YH4uG2NO/49kFeEwJludxnqeKs305ZkPTf4PDtBIwQlHWtDsSGcXNR6NAl+Lo6Ku+8mOB5ssGU9lmCwtkWv2xqfJH8chMM/+vrwY6RkYsMt1cjt7qvTk8Zc7idjFmGbf/GUaOswcm0dqgygcsdn8nO75NrY42sJCStQCt5zDVxq40h861IVi0tt6l0OnFjDsB0Kl3qQLnex59gZ+R/uzNTvrqSHOEq8v+cCy+OdcMG6B3t0FieGG+CoqIka6DUCsyQ1H1CHq5Qk6qjwqa30fD+K5Kpn4OmOi83VSwhWQ6RnMXVsb7Dw/ZIq4Z2b/sgtPTEXmK5iRSKtdw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DSVPR12MB999260.namprd12.prod.outlook.com (2603:10b6:8:41d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 09:48:37 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 09:48:36 +0000
Date: Fri, 2 Oct 2026 17:48:30 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>, 
	Jonathan Cameron <jic23@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com, alwilliamson@nvidia.com, 
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, 
	Manish Honap <mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, linux-tegra@vger.kernel.org, 
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v14 02/16] cxl: Share CXL port upstream PCI device lookup
Message-ID: <ar99Pn5kNcSupIWW@MWDK4CY14F>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-3-smadhavan@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001092227.3004747-3-smadhavan@nvidia.com>
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DSVPR12MB999260:EE_
X-MS-Office365-Filtering-Correlation-Id: d9d99e11-4b26-41eb-f392-08df206a5462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|10067099003|11063799006|56012099006|4143699003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nFIR0zk9TkiSs5aaskdPbtS0kGhJIj1IB1qWtmWOrlyVJlePHnoV/DCN4tpGdkAmAUFW3WXp1Yu9azUGvgInIu7US5afTgMx6/zCjhhAPIiAnTnwJJeG2TL6iVb7w6SIuzttmkvMtZR/U+lqDbeRKihDftU1xFpcHxn3FSwHzRoVX2IwHbkLtmZ7vs1y6SixWnMW5W3AyqLAci9eFYpFzRBb0DgBpP/G7GZmajk4m9VCmgjV829olAAmcH61v/L1pwwbzR39/5UvK8mRvcFNZo7V0mdj5J1ce3/8CPLwxEO0tWqXbDvSBj1ZZU0QG1WdvdmuBtaRBuMSX7T7H2u/uee2tnEpNMe3HOsP/GXCuvfMFZxt43u7wUDWP8MC8rgK+0Ir0oxN0hI7yjjvco3Y1qAycojpIjjeP++E/6IP5Zh5+R4l3hIBi9nvXAvaXW27sgi7LhOP6HiVlUDok16NxyfEpdmHy0kNJju9CL7LupTbhJpPqyvSGt8WBMRxRkGTxJ8LrIORDj6aE5SzeFe388lLL6/9MNwZNl+EE3OzUageYcQ081xkVjZF3q514YmYtF8DocDky7jSPCtyFJpY+Gl3BAUiWUEqMC/jWumt5l4rb/KXvGTWqaWhCvEpjyzB+u/Eovy7nOrtNGDqvavvuVYGBOb6W+xfZFq7eulvRPk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(4143699003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KyjHqzELxVr2Vw40EvW52rWgCwPRaF/2HbD2Q6grZls8nzDjZpg+1HVEddKL?=
 =?us-ascii?Q?uz9Xij9BO4cZnlxnzdtGdlXotFaPPGpZHC3cqQB7e8YtaBE/ZSpRkK/4G5YR?=
 =?us-ascii?Q?RVU0RZ6JGiB/JVju/PVqUQdCGhPE7ZFUeN0EViR6G9xp/PE8N/z58BNZOViY?=
 =?us-ascii?Q?brlKctceOiq4b5ysfJWO7J9Me2sHUpS15WSxDamBaYGqciUqGH9VVgY/kYEm?=
 =?us-ascii?Q?Z5a9AAMLqvNXpdya/by8kALZxbYz01YpgtirygVr9SNXoQJGnCrgByuBx6Sl?=
 =?us-ascii?Q?4zn/Tj/KPLa4+nb2kq+OIX0dRKRipp0q87AkQoScqLIYZVOdjoPeD4i3SBoF?=
 =?us-ascii?Q?KNkjJZTAd2JqGUhfSx8IoUy7kVn0OmjEojdlP4Qk0JPWt71XL1kT7N+WnQzC?=
 =?us-ascii?Q?RM3vZeiKikktEtSBetKD7e6iWlj7a8PFLPluLODDdOOpB+a63ZXZdSgUeZZv?=
 =?us-ascii?Q?AXeOSvZbiWrDpWeHEghErmwQOIuEd5oSzqQOv/IQ5G9V1MxoYXserTs5sBVF?=
 =?us-ascii?Q?eaFexb8z8ARTfcrz1tnoVTwhlCfwAzVgHMUi280dNu4sHR+4Q8DImAPZVj8b?=
 =?us-ascii?Q?9JZdafYmSM8C9n0Nfgamd6WNPdE0TIyRlXRajM8LqgevwZxaD6JA3P+3gRLD?=
 =?us-ascii?Q?3Lw0901kFJbYuDD42XvQqqU71yn2Z/by8e2xj/ROSRyd+bxhVPCWhsRf+GeS?=
 =?us-ascii?Q?OiKlSIygFudZrXONoNfe6GPWiEUSxUqPYHPHDSWDBIHEl7OCMblR396mi2Fl?=
 =?us-ascii?Q?4rljZjPe5SituHKOCbi9QdkOSzD6rRk1JEflrB2Bq2ggGLd/ZmGDmmHRMVa/?=
 =?us-ascii?Q?ruQw7v27nIGG0RYgdHGk7dU4xdZP/mHgvKFFvxwF6wyJrW9fpBluEa1TtDfu?=
 =?us-ascii?Q?W1DfQvCv/aC8/UMQi4yXMbrVJExa89Zv9YDN1W5zEJkBY59L+30KIu1t+bYA?=
 =?us-ascii?Q?wu+q/wFYDZAu8u8qQEeGUcN6ose9ETG9YBuYlSPPgdnyyBqG3H43altJav5z?=
 =?us-ascii?Q?cCDaEtbseG04aVkLFUZeHy9ckplEYXBklEmb8iyIDVoN3Ivfyn0Rh3cu+b25?=
 =?us-ascii?Q?unDm6oggwzyr/d3KezXoPW7oLDGYZXms3tlTHXz41HNV20d5E+JEI3KF0rB4?=
 =?us-ascii?Q?25Efs1nH0BU7rB57+jZ8iIOpjb2OVe+eKfkEtr9Qr/k3UQJG1c8NgDe0lmr8?=
 =?us-ascii?Q?qB6TBsSMOiZtK+D+3Dy1UPA2GsaEHTKWX4ELvf3FawrTYvkseKh1O0FHPPiJ?=
 =?us-ascii?Q?R9svU5MWMYs7d1rjRRcEVH3PUufwrLzFnzCCAf7hMup1I9nucLQZ8yJ3AOcD?=
 =?us-ascii?Q?dEX9o0jeuVjR7bf9FHEa7zsPoKAwsGlk2TyKDFWtDJ+mkayM9qYjliDT1NUC?=
 =?us-ascii?Q?KMsTY7a9zKL2sWV9Ii5LHADMHGZ8CkLFbWTBSj7f3itkP4a4VYNrpPv7wBz1?=
 =?us-ascii?Q?T0HSAqMKJR2B4xHAZ4mwzO/vIakpEtX5liBBO+HxQe9t3zl6CSI3L9/euX4n?=
 =?us-ascii?Q?m+67zmiFjytRvYxksKIIeO8dJvxUgjQhxQKE4FVJbFx/pcp03F1whdbQykc2?=
 =?us-ascii?Q?vPt/DLBx3luHQC1xpOCArpdneYUmbReZaausdd3cgKde8UFbLxDWhIwFIWle?=
 =?us-ascii?Q?FGVXkFpPMachZWF1Rh7nyTsPRxDIC83IN0w3HdCJ4D2Wqrnel4XJXYcgNlP2?=
 =?us-ascii?Q?0du3hPE1HBPoGVguM6WVzxXlEM5VYaWnR6NtVaVF459mQm0gf6y1B6EkDPpW?=
 =?us-ascii?Q?Qu50YUyNyQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d99e11-4b26-41eb-f392-08df206a5462
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 09:48:36.7773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YD3jHnZRgQXuJfPFyw9EZfJfSNXfW6MUA4+Yy8JqU++OsvrNaW6vOfpmgjeN5Jr3HbEuhl2NzST30b5kpL2a2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999260

On Thu, Oct 01, 2026 at 09:22:13AM +0800, Srirangan Madhavan wrote:
> read_cdat_data() resolves a CXL port's upstream device to its backing PCI
> device. HDM cache updates need the same mapping.
> 
> Factor the lookup into cxl_port_get_uport_pci_dev() and return a referenced
> PCI device to make caller ownership explicit.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Richard Cheng <icheng@nvidia.com>


> ---
>  drivers/cxl/core/core.h |  1 +
>  drivers/cxl/core/pci.c  | 19 +++++--------------
>  drivers/cxl/core/port.c | 26 ++++++++++++++++++++++++++
>  3 files changed, 32 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 35eaf636adc9..983d7690c3a5 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -157,6 +157,7 @@ long cxl_pci_get_latency(struct pci_dev *pdev);
>  int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
>  int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>  					struct access_coordinate *c);
> +struct pci_dev *cxl_port_get_uport_pci_dev(struct cxl_port *port);
>  
>  static inline struct device *port_to_host(struct cxl_port *port)
>  {
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9d807c1a002c..99c8b02d42e5 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -564,26 +564,13 @@ static unsigned char cdat_checksum(void *buf, size_t size)
>   */
>  void read_cdat_data(struct cxl_port *port)
>  {
> -	struct device *uport = port->uport_dev;
> +	struct pci_dev *pdev = cxl_port_get_uport_pci_dev(port);
>  	struct device *dev = &port->dev;
>  	struct pci_doe_mb *doe_mb;
> -	struct pci_dev *pdev = NULL;
> -	struct cxl_memdev *cxlmd;
>  	struct cdat_doe_rsp *buf;
>  	size_t table_length, length;
>  	int rc;
>  
> -	if (is_cxl_memdev(uport)) {
> -		struct device *host;
> -
> -		cxlmd = to_cxl_memdev(uport);
> -		host = cxlmd->dev.parent;
> -		if (dev_is_pci(host))
> -			pdev = to_pci_dev(host);
> -	} else if (dev_is_pci(uport)) {
> -		pdev = to_pci_dev(uport);
> -	}
> -
>  	if (!pdev)
>  		return;
>  
> @@ -591,6 +578,7 @@ void read_cdat_data(struct cxl_port *port)
>  				      CXL_DOE_PROTOCOL_TABLE_ACCESS);
>  	if (!doe_mb) {
>  		dev_dbg(dev, "No CDAT mailbox\n");
> +		pci_dev_put(pdev);
>  		return;
>  	}
>  
> @@ -598,6 +586,7 @@ void read_cdat_data(struct cxl_port *port)
>  
>  	if (cxl_cdat_get_length(dev, doe_mb, &length)) {
>  		dev_dbg(dev, "No CDAT length\n");
> +		pci_dev_put(pdev);
>  		return;
>  	}
>  
> @@ -625,11 +614,13 @@ void read_cdat_data(struct cxl_port *port)
>  	port->cdat.table = buf->data;
>  	port->cdat.length = length;
>  
> +	pci_dev_put(pdev);
>  	return;
>  err:
>  	/* Don't leave table data allocated on error */
>  	devm_kfree(dev, buf);
>  	dev_err(dev, "Failed to read/validate CDAT.\n");
> +	pci_dev_put(pdev);
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
>  
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 625e4aa427db..5dc2815d82d8 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -34,6 +34,32 @@
>  static DEFINE_IDA(cxl_port_ida);
>  static DEFINE_XARRAY(cxl_root_buses);
>  
> +/**
> + * cxl_port_get_uport_pci_dev - get the PCI device for a port's upstream device
> + * @port: CXL port to map to a PCI device
> + *
> + * Return: A referenced PCI device, or NULL if the upstream device is not PCI.
> + * The caller must release the returned reference with pci_dev_put().
> + */
> +struct pci_dev *cxl_port_get_uport_pci_dev(struct cxl_port *port)
> +{
> +	struct device *uport = port->uport_dev;
> +	struct device *host;
> +
> +	if (is_cxl_memdev(uport)) {
> +		struct cxl_memdev *cxlmd = to_cxl_memdev(uport);
> +
> +		host = cxlmd->dev.parent;
> +	} else {
> +		host = uport;
> +	}
> +
> +	if (!host || !dev_is_pci(host))
> +		return NULL;
> +
> +	return pci_dev_get(to_pci_dev(host));
> +}
> +
>  /*
>   * The terminal device in PCI is NULL and @platform_bus
>   * for platform devices (for cxl_test)
> -- 
> 2.43.0
> 
