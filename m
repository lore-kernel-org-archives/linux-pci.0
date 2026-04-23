Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013057.outbound.protection.outlook.com [40.107.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257D9375AAB;
	Thu, 23 Apr 2026 04:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776918595; cv=fail; b=BA7VywoNhcP/65Fzku/3bOQ0o1zMyI8Q0eQgInCPHEKjdm/Z1mrBd5jf498V1boZueces5bAo9UZ2GjoSMbiEhgZdQTFC6p2mRyS+zlyKT3UMJ+3He2f/a9CwvCa8JN1MuSUFvUuTTFRV4fEaim4aKRxvh0DnpS/YA5f08srngg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776918595; c=relaxed/simple;
	bh=ltsuNTt9fjLOOX4ENkM1/rc0hKF7o7CQL/xKItf4Ca0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzhu+lpRj4yeQhzY+H2hVJYYVPHge1YQSXWCk9R4cRtt3on7Oo5NnC4gpF0sQ63xh97SrhjXONhwDq/F0bc9MW16JJwohJMgVV/iRDdNpo/mv2PoeFtxiInur3xTtqBenfVZ+1DA5yfpfcWVEGVPK2pkkVvICFlGZMlv1yGwuaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vn1OkmM4; arc=fail smtp.client-ip=40.107.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vn1OkmM4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChXRyXbmQ0hYqDY7lZk6pQIvc8pAz3Ntf/H7Ms6om4zSGRHfkqduq8InFsVMnn8uIsnnFqq3b+WcyypPnpdMzU5UGbLl6DkGoecuz3w+PMh9pYhGewbmiBLkzo3XJcXNBxH0L5ffPLQXdWBNccYIT7Mkm1dEyz+jGkZIpGve8XjGFljMrnrcQ5twghbvCy73AWVST/IM2b9DwBmZGBPNTOYXQW6aOM8Pybo4QW4+PkNOuZCVTiffVZKyTxX6CKBuFlBY+y/bPLhhkk6fQyZfW4Xr0xR6/NUjnT++B6CmO+C3uQkI36w9SOePSRvDFx7/J1OJPOjJiiGkDFebTuZgEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8azOsazaS+ID5+k4LSRaQ3uIeuSff7JsVjZcxmxhOU=;
 b=nsBezngxMk4F9VixMODjyIo47nZcod4e8uv8JCUWAnAklhNrtecPpGwblWTj3/PX9ud7NHdrqaL/T63qLs2mofSCUX3KapEFJlTrR+fgdUFold4l6Nnmi9str6ksatxFppEPPm+0d//VUR6HX17Bfu+hp0Z/zq+EamGUvU/dis9iqhxHe8+AAKnwZtoV6fcC0QaclBGyWEHjf5HsxmatNygCqiUqKNCdYso0Sgcu8dpejGffmyzHsR9AHksxQOCj933XogirxLe6G/ghOjhxxQiuwds+PR14UxQAIq/HLuprgLn67f1GjQysM81SsRR5I245cdqmhqUo1gJBV7MBHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8azOsazaS+ID5+k4LSRaQ3uIeuSff7JsVjZcxmxhOU=;
 b=Vn1OkmM4SdNySV/FxAWrWPspNXSr85XrLKFuTjLZOKJq6WZ6vhk4POSYPnh2OaAYEanBt6Tt88AcqKeK5RC2XkvYzQzBgooRRl1TSuulv1UHp2I3h7DzlCoHSV6aqUE9k/sTHFhn0YLwBxI5sl4iVaWsb7b7tZmDz5zLRj5WANmgMqSxvvxXWD6d5Da9bjJmKnB+uVK5GXSmAaa8lBYSiizkQJuw4B3RI68DhJC1ZtrlQSpY1MKhTEChzR8hqqiw52Ax6TvORuP9Q5BoKTmmLuBGIr+7fKmaiOBO/fGNtjF1+dJMypt83LEpaSTVpjcFHdd6PkKy91w6ZKfV2SzxiQ==
Received: from PH8PR07CA0043.namprd07.prod.outlook.com (2603:10b6:510:2cf::28)
 by SA1PR12MB7198.namprd12.prod.outlook.com (2603:10b6:806:2bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 23 Apr
 2026 04:29:48 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::a4) by PH8PR07CA0043.outlook.office365.com
 (2603:10b6:510:2cf::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Thu,
 23 Apr 2026 04:29:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 23 Apr 2026 04:29:48 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Apr
 2026 21:29:38 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Apr
 2026 21:29:38 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Apr 2026 21:29:37 -0700
Date: Wed, 22 Apr 2026 21:29:35 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Rafael J . Wysocki" <rafael@kernel.org>, "Len
 Brown" <lenb@kernel.org>, Pranjal Shrivastava <praan@google.com>, "Mostafa
 Saleh" <smostafa@google.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vsethi@nvidia.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v3 01/11] PCI: Propagate FLR return values to callers
Message-ID: <aemgLxV+bCIaLGfI@Asurada-Nvidia>
References: <cover.1776381841.git.nicolinc@nvidia.com>
 <8bc784e505dc04ca81582307c4a70babbf58eca0.1776381841.git.nicolinc@nvidia.com>
 <cbcbea4e-c857-4b75-a55d-ba3f89cdf22d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cbcbea4e-c857-4b75-a55d-ba3f89cdf22d@linux.intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|SA1PR12MB7198:EE_
X-MS-Office365-Filtering-Correlation-Id: bc7fb18a-3f6e-4a06-4b5d-08dea0f0f424
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JD1AbeDfTButLGUJlpUBnbTm4q0kSkGFB5iXVLP+TzAa5Wl3IXl4yPVcxARwx0i3Zf5oJtuAErdddpibEXtPcVut7uUkNqoN0bRAsq8GFeByW2ahHOJtwB+0sxzIVd+ruBomox9w+hsyVj3k3fwXLyllijwK5oE7+xZcZ+C6FEnVxK1QgZIbGsZwy1xARxB2vxbForMMO1B6mk9GoUGPIzZe8GeuIucteOHDiErUSm2TmgDocC9cwn+O/gy8C1k9PUYRERMXPFSZLqhKDwmKvfIxyNLzyhO9q3QPRNBV+0yfiMt6aZcTN1Mp5d/elfZ0F5gxAClKN3ft8/828ktXg5dkqwY7rc5sfc2LvghHPgcUg1SGsaxTt3VsyEizXnQASnaBbJ9/YfTujqlFWudMD41jBoVn3hNmi7QEqU8g0MXXiTf7PmDpSTi3m8LYRg/5qsdnyacjPvR9Svzr8tozrGrM64t2j/IfIYnzzWcADYWwaGfUWnBJ5zzmsouxOo1XmnROn0WalyCOtx36b4HM3M0IMRn4mb9RVVn7adLeStSG+8HaZowPg5iOFmwElP6kQj8K9uSDmPHhDhUwpPXFimDQnkuHiluq14hUv+51hLQY5tDb9LDkVDlkDkb0s/PS+ibdGLD52WVmHGbe2U0FN2XUHnMGO9s4XZsHtcIuJyguOtPvCYRDzhGp51EMvLISEgl8KHDQwNkvNbPFPd7Q4j/B2mcQzIPzLxcitZB2Vb8rqLvLJs06YH+T91JYzNcEWDbS7CB7kcc0yXYjWySulg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cGF+pptuGjS5mhaWo3/YSD54cDWIWND0UQsfvzF5w7jmKHZC7dOO3EnkTDr9G3FHvc97WmOVKmQR2pisi2Ju/y3ORFY383V62X7u5DaUAiDM1CgtIJtBdPuIHg7OvTZatLL6IxoKgavdetZMBdAmXm0I7/zWfCDlnT/YjCLQavKbZ68OCsSlqsK6RPj6AG6uasEtYWGMf1wcTPd+oArxnQc3k56/5kpD22n1gKksPxhfEyzDipjBs1WrW4EGNoi98Ut9QuXqovSE/RyA07HUVC1g7MvmkKSzw3NuUdN4HYvHcJEIylH6y3SUpPOqYs4Ltjy62UUO6GEM1N5c2AsVySDX48akZtLy2ObHW1YikqUe9OjhnYr/yr+P1aV1Du5pe0V8zNkg4tfi3wLqF/gfjN5IyKVZ5pRznhl2pafEKAjXwgq79BLWdh+Rce3cX9+F
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 04:29:48.0580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7fb18a-3f6e-4a06-4b5d-08dea0f0f424
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7198

On Wed, Apr 22, 2026 at 02:13:49PM +0800, Baolu Lu wrote:
> On 4/17/26 07:28, Nicolin Chen wrote:
> > @@ -4060,7 +4061,7 @@ static int reset_chelsio_generic_dev(struct pci_dev *dev, bool probe)
> >   				      PCI_MSIX_FLAGS_ENABLE |
> >   				      PCI_MSIX_FLAGS_MASKALL);
> > -	pcie_flr(dev);
> > +	ret = pcie_flr(dev);
> 
> It makes more sense to return early here on failure. There is no need to
> perform the subsequent steps if pcie_flr() fails. Would something like
> the following work?
[...]
> @@ -4060,7 +4061,9 @@ static int reset_chelsio_generic_dev(struct pci_dev
> *dev, bool probe)
>                                       PCI_MSIX_FLAGS_ENABLE |
>                                       PCI_MSIX_FLAGS_MASKALL);
> 
> -       pcie_flr(dev);
> +       ret = pcie_flr(dev);
> +       if (ret)
> +               return ret;

Yea, I was a bit worried to change the behavior, skipping the rest
part. But that's probably the right thing to do.

Thanks
Nicolin
