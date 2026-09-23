Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012041.outbound.protection.outlook.com [40.93.195.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2A5423EB7;
	Wed, 23 Sep 2026 21:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790199596; cv=fail; b=AFWwyr1MiNZqW4Y48Dxr1i9p+tyGb/R6FxIi/YJ8taecZvtKpHkQVAqfPMiKYv83zwZzADb+91FMxP98s5cbhTRjXb5GPuKRnIZE3s2F6trCg/h4G4abUgQiT9NIGyAg+i43Z1VAzue16yxdbqlmL8Zzsbylj9ENBSD6149dTaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790199596; c=relaxed/simple;
	bh=uKra9SwPL/+PDBrgbHAqxArme4knDmiu5ntrGVo20T8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=hi+gycmgbLqoa6wTqCpVEH898x89brRyqjFfpHKYVZGOcfvT/I8o/5Fafinv/ZuU4AU8Ejr9Qng5OrkcfKIotz9tjp2L7LG9krFymcHU8m3Ipw72cNXvhtWeXoddlvdjD7vSiqtxjkNHffYrDtn8e6YoapzLRiV7lHtp6ZytNXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wdgcpY1P; arc=fail smtp.client-ip=40.93.195.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wdgcpY1P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBafVWfyfwve9cEi9szY3xnm2s4AL0kD/96vCiHSjq1/LbP2sRMhAfF2ptmY8LS355BAJmI9F3KP1+ygVrdXQIQwtRJwS0BZZleINgOh7OdWwjgTgksw1df5Wt9cq6b7EeYojsLGu2+SSbqNAz18dL6BR0T2JEv0OhEdegbyU2zXGCcT7GHQrvLNZFroeiBlgKyyG91WVI6KDz2gTkgzUtiB1f88GaarQLB37NX/XbgxYyHgUpowz55hBxc1iDbieipbHBYDT0/zdGoAvDrppvccSHrO7Hklg41l8bnNoFxM7AfHDCrtXCH3uPePaPMYSBakXk9okhtO8IX0TOHD6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOE785YDgwxJCSTXs2YsXMLadAlVRzJYBJpCiWtwR4o=;
 b=ynSL4u+cjmw9+kp0cJ+MMvAQyt+ZWFQjIPOlikUylsXsXE4fYFAeUjQgRhdmAxliCrzYH/SOI2WWvkmKvo9dTpE0DX/Mc+RUO/Knutp/7mSP7tOCuR1a2EYIS/UAkmslDyRRwr921UnEGkLjNWAyLDafgTZLMjCZGOIiMr8eSVvweo4/QxzSxQfiYra9cFuAwWQpk34cMuT4/PSJ/Fs6yuXVj1gIFknPSJ8u9IFbfr0H1M3QpBsiWWf+nX1vmt8qZnr4R/iggWxIpCZu9NSET0WX0fDo528sKPI9oNvBldtZhwCtMZnqFG+bvo/3+Tn/E/bERc3O9NBUOyVqFc7QTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOE785YDgwxJCSTXs2YsXMLadAlVRzJYBJpCiWtwR4o=;
 b=wdgcpY1PoWavdlceka2q/N47e7l3MNatbaXwToFCGKyUmHmK+Pbou4z0MGd4LLKExEEtQFskB216x3PA48QmEX1poZ3VojpLydoSs5Pk9ZgfZX4v9BYT4imPE6xuJsk23Vt/d8aqPyNqbZdhosYjPtIgzlCIrQEOS5/rzTln40I=
Received: from BYAPR21CA0016.namprd21.prod.outlook.com (2603:10b6:a03:114::26)
 by CY5PR12MB6226.namprd12.prod.outlook.com (2603:10b6:930:22::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Wed, 23 Sep
 2026 21:39:47 +0000
Received: from SJ1PEPF000037AA.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::66) by BYAPR21CA0016.outlook.office365.com
 (2603:10b6:a03:114::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 21:39:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AA.mail.protection.outlook.com (10.167.244.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 21:39:46 +0000
Received: from [10.236.178.170] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 16:39:44 -0500
Message-ID: <63e196f0-7175-4421-8677-5ae30cbfbacf@amd.com>
Date: Wed, 23 Sep 2026 16:39:44 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v13 02/15] cxl: Share CXL port upstream PCI device lookup
To: Srirangan Madhavan <smadhavan@nvidia.com>, Alison Schofield
	<alison.schofield@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang
	<dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny
	<ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Alex Williamson <alex.williamson@redhat.com>, <vsethi@nvidia.com>,
	<alwilliamson@nvidia.com>, Sai Yashwanth Reddy Kancherla
	<skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Manish Honap
	<mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, Richard Cheng
	<icheng@nvidia.com>, <linux-tegra@vger.kernel.org>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-3-smadhavan@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260922083924.2451158-3-smadhavan@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AA:EE_|CY5PR12MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d75fea-01ee-4682-21b0-08df19bb301b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|7416014|11063799006|3023799007|10067099003|4143699003|56012099006|22082099003|921020|18002099003;
X-Microsoft-Antispam-Message-Info:
	9pNMcRW9D6PpT9BfB3B1bgalAvJcqdXcLD5YscATFt0ssvewK3qfGvBqIJ2+VRohuOgLzdOjgLSJKBs1+AAAnpF0opV3vmCB+kNZWvDcuN7dk1IYTHRvP5KNT0R/0xz8RnZC0GUVgWwKiNXwyglwJ6LSY+yr7C/8GRE2eQ35hu51LnmqWFARDVSlNO3jxX8pSCYXabG9Uveb8OhrCHc1n9MIkhznkc1kbTcQ5AA7O9/CbuuLsAHRxSiBXiypTwC24hqE2+10uXXCQGI6y/+aIWrj6o4FFq7dpMX0weJt/GGDx60IJnwvA8PmRlOQ7XLuav489LHGEnz072/OhS0bdDG5Jz5uX4FdbBF7R6qrmo/7DCKjnTFsHWsHg7KJcK8vAdBX8mo/72VIeWAGvvzTX1QM2W5V2EIc3D9esUZvNxRCzAL2V9R0DBvWGlxz6s9kALza34gN3uCZ3IlMFX3m0xy3r7hm2YOgJKhlPmiQLCjji+r/6luuAbY2LIHWzfcip00ciFgHgqymUZqA8ztxFbP2HvxktS2auA+9SaBOyvWsVvxWpl+jopDuP9j6i/rY6byswWXDiwZ/q4o0zQqVHrb7USzqRu7VwDK08QMsbhSx+2H1DI+E5o5a+2JcJ0a0ARJXDJ6PP0yRtXK+zCvJ8CEYBunwHHffQy0k8qMuhrHhxJxjL/hbjhv2rOCcAQHa8UWRdIXuQEapvLQlaybptPizioSpS41KIL5c7turP/xtnixcACioXj1LMwyFLMGC
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(7416014)(11063799006)(3023799007)(10067099003)(4143699003)(56012099006)(22082099003)(921020)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cmkQYdw6zun/Pt6urWGUqoJzNFzlNwttYC+fhI+ScVrKJDkyZnpXJtIxCEgyGvCYBGhEFXrglKZJh+UhOgpj3nA1fIJSkLjKzBeug7klSBqbYvbV602PSOpoEP6BxN/Q2Y4wPi6sly1QTF8vA8wRGeqJM/oMJTMXIhfUZjOercE2ONAwDLOcjIeFbWgfJ2ZVMXgz/VA7dAD750kgn2c7kd5vPOMPn4xIsABX2HubMj/xFoBxV1wNTneLj3T91hCtgTNRMESfRcwVtHR6AsEs+eEUJ2PTZ6K1Z/yVtRnS5TUWrYQsbsC1ZbkvxQZT2tpafA/X7ONS3PXTOpHbMcFZM5VJg2z944JqWaWzEv/33hugD0LjD6lj0IRRCGIJE55qZpYKbVXbCuN5dTwwp187+fk2jfLlVCgFZ2N+W0Zy1tmdW/l044uS/zr44zAJcbsW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 21:39:46.5300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d75fea-01ee-4682-21b0-08df19bb301b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6226

On 9/22/2026 3:39 AM, Srirangan Madhavan wrote:
> read_cdat_data() resolves a CXL port's upstream device to its backing PCI
> device. HDM cache updates need the same mapping.
> 
> Factor the lookup into cxl_port_get_uport_pci_dev() and return a referenced
> PCI device to make caller ownership explicit.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---

Notes on the actual changes below, but is read_cdat_data() the only place that could use
this helper? If not, then I would like for you to do the same for other locations; or at
least explain why only this location is being refactored.

>  drivers/cxl/core/core.h |  1 +
>  drivers/cxl/core/pci.c  | 23 ++++++-----------------
>  drivers/cxl/core/port.c | 26 ++++++++++++++++++++++++++
>  3 files changed, 33 insertions(+), 17 deletions(-)
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
> index 9d807c1a002c..bf7fc77626d9 100644
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
> @@ -591,14 +578,14 @@ void read_cdat_data(struct cxl_port *port)
>  				      CXL_DOE_PROTOCOL_TABLE_ACCESS);
>  	if (!doe_mb) {
>  		dev_dbg(dev, "No CDAT mailbox\n");
> -		return;
> +		goto out;
>  	}
>  
>  	port->cdat_available = true;
>  
>  	if (cxl_cdat_get_length(dev, doe_mb, &length)) {
>  		dev_dbg(dev, "No CDAT length\n");
> -		return;
> +		goto out;
>  	}
>  
>  	/*
> @@ -625,11 +612,13 @@ void read_cdat_data(struct cxl_port *port)
>  	port->cdat.table = buf->data;
>  	port->cdat.length = length;
>  
> -	return;
> +	goto out;
>  err:
>  	/* Don't leave table data allocated on error */
>  	devm_kfree(dev, buf);
>  	dev_err(dev, "Failed to read/validate CDAT.\n");
> +out:
> +	pci_dev_put(pdev);

I'd use __free() instead of introducing another goto, especially since this is the ideal
use case for it. There should be a free action defined for this, but I can't remember what
it's called.

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

