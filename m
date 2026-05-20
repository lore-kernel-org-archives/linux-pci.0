Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011058.outbound.protection.outlook.com [52.101.57.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E2C34FF45;
	Wed, 20 May 2026 07:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779261998; cv=fail; b=G+AFb44svQMJj4fTLANHhOFW6NAvurCWsUL0CuhCzL+QZ629yaqdanBPGdVpcNQHPQUriMDaRm1LC6RmiV5rF7iv36V7SvQN3fVQTNRa9Zj9U4nYCqHrTQ87O7n4ppgDLGImxouUBvc586W9k7qkARf4doMl0MP8vnJL7Am6hjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779261998; c=relaxed/simple;
	bh=1/o4Mlr+Ako4SKdt2uFQllkK0fQZZNi97hvCJF6ts6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XKlbTFxGNXySEnlaOdsifCnqdp+uqy9sVIcRUS9WN4WLiZwG1fNrTCdU9OLpWRhvZgV1gCW6qNJHRAizm/2LeIDGVZl1tpusG9amf3lVAZH7yslvjKoIuYGSsEJd0w3kLB5VvcmvCQi9aYPaB5c+XLdKr0du49VlcQxxNmCVY6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DSGg2mK2; arc=fail smtp.client-ip=52.101.57.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DSGg2mK2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9aNKOAx8fFva9TgXke+rezcEZE80uHoa0xJvTpBy2J1UWbrASp/EblqN1xrbXB9af4c64eehc0EbR/2GnRZGGh7EVQrNsIS9dewF2QXOoFyMEBBRQFDf/cXMgKjWr1mZgW2qmEdIvbhdxviFMxlYVHge28ZGG76Isp8fDf348rqU2uuz0jfKB2oW8jZQWsYYwmcXO5o2ah0uf9VRnOhj8Zt3hW9gSiWP7cVZPCxyhS+tPRxPDPsEVXk1lopHnSzX1n5uwG/hI4jmr8gudG9nfbuylLb60kgd/0TVfEszT8PGQL2u6jSTZGsC/V3N6MpNyeWSL6cvV7l9Mq12VY/og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhINc6+btcs9YUjdQSqPKwcuT20k3iSMuiJkmrIoSY8=;
 b=inyosO9Ufnp1YCfTabpXem7GPoB/INm2RfAQ0vrrW7ZLCDQMfaIXU1PsLn84URLKtz0nBlX8DF+FyGBV0yi7D+nzKeAx0fLOwbIIoJyYK77v1zNNMp6+w5zGp7WJ1MRh3WkuB8yNyvejAAT8+8+DeahjVeFBylKKfSX9uMhwqmHodeHsBF9ZC9e34T0nTaE7T9Wl2seIL9DpEESh4z4vYSCRyHVkbIwJjJHndr7FpM3fiWUz0d8S2ohHi6nq2P0VBHP4a88UswxcjyGy1Pv2VETUHef1WJqfrzLANXJugS8WUO9dce02ga3cwq2sVKnkJVxaSPMBg93Qux00NoMbaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhINc6+btcs9YUjdQSqPKwcuT20k3iSMuiJkmrIoSY8=;
 b=DSGg2mK2cgQQzSjsZe5FaYAp232im8c0lT+K2s/YtpgYld7uRP5IVtSWpP5MUseT8al3um0KeeHSoelc3DhyYccOpxkCNE3BdHC5YR+KYn0GmARKGyO2FyLooWIyizV2fndSQMBjy0GUq9NYjeGGGCFPFT6P2eZiHlqcIKpK3TA=
Received: from BLAPR03CA0078.namprd03.prod.outlook.com (2603:10b6:208:329::23)
 by IA0PR10MB6818.namprd10.prod.outlook.com (2603:10b6:208:439::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 07:26:34 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::70) by BLAPR03CA0078.outlook.office365.com
 (2603:10b6:208:329::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Wed, 20
 May 2026 07:26:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 07:26:32 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 20 May
 2026 02:26:21 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 20 May
 2026 02:26:21 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 20 May 2026 02:26:21 -0500
Received: from [10.24.68.129] (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64K7QHto981615;
	Wed, 20 May 2026 02:26:18 -0500
Message-ID: <d9d4aa30-8d30-4025-abde-0325e102fd8d@ti.com>
Date: Wed, 20 May 2026 12:56:17 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] PCI: cadence: Add HPA IP debugfs for LTSSM status
To: Hans Zhang <18255117159@163.com>, <bhelgaas@google.com>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>
CC: <robh@kernel.org>, <mpillai@cadence.com>, <s-vadapalli@ti.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260519123609.1595280-1-18255117159@163.com>
 <20260519123609.1595280-3-18255117159@163.com>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <20260519123609.1595280-3-18255117159@163.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|IA0PR10MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: ee9f67ea-0f12-45bd-74c7-08deb6411e11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|4143699003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	vkieLusJhNagptVvo1jgfLG5e5i+MfP9UKKTaRw+iRjvtFCKW97WUe3whzi4lsSBoSZxttfef/JPopJtwBf0vBgtmZzDushnjMZ3p7JQlhjwuYnrJMbk//9Tq4gpxrYEPZ0dJA+uxvLShOLWQYhAX6YX/xb/VzSm0S2HsQK7AEBm4B5P/3+sBL/AXLXM8tjikJGMZi1OMxud3/KvBBxOTPmQEe34P+rvLS+YvtOruCx98mVy2D5divJFjJcK7UzNDaYl6doWLiaAkou2UrnI5386OeR4wpyPIg3/IHXCBZtA6ur8VTH6pOB/rH3Wrie9g7v9PzvwrkL/7qeiE7ua1ENVMeOhD21x5XGujY2S5kbW/4uB3gI9LDNEGrFmpyftefbcaeIMzg5ARuy2QrXbep21N2OodR3r8b9xJewwsDhu+PVzNaf7722OocUwKIIMmuo216c+kXfVk31QtxphMbsoqEghX4M6wNxBNsZXHGDXuIqgOGZk2x+G4pLn2q3K5aYpzMh0YQwbplGH368ln4DfCVbrZ+Z0v3Hu8konRIpo0esAKVWKTDjodfBlA/bWBQSFyyOeqewdRbn4RTwoNi9AApeNEYbVh3uhkjMVHQcrJ34P2cl6Vx35Hqb+vd9laIHrijNnaxYRFXo5Yo4lRnVh7lJx0IQXC4G45Zqyq0jIE3c7QhNRCpGM6uLCOKlU9vtdx59CHqBREPeZGBi6POUSifcfx+JYgh32WjPi6Jc=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(4143699003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HU5rLePKsFyf+JB5gDTmQ8eOvzEw56zfs+UWABv2GFGDa/tkRd81RP8l+6x6bi6IifZK73sk8FI8bExTiyFs+irvCGoc9ACqb76H6o+K5YeWqg8BHtyokGaOyaCe1UQDETdpnGeFVvwBhfG7jaL2LJkyCZ6SR3OS8YfSsFC4q6UcOQAzZlDLKLx+SxJBg6wtruutXY4aG9LXMfLCIY5ek7s6+1hZySMqWSVVRbnc6i9Qa5i0OtH3nqth2BSe/3z2/asaEzIZ8ldYVC6BQYxkiVFuybSiJXhSk7be9ieMAfDrebZ5MPwTJ3nEDSnHg9zJ0+6VJWCQ432oED6uphvndlzhpU6JM+uncpihKbgaHAQH2+cAqZQXx9G1yuGpNCw6j9hmRhPs/tUuEfcSy3T64Dkr2K5svYDHAMC53cyxIhydqvjGWwHtV1Br46EnNu50
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 07:26:32.5609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9f67ea-0f12-45bd-74c7-08deb6411e11
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6818



On 19/05/26 18:06, Hans Zhang wrote:
> Add debugfs support for HPA-based Cadence PCIe controllers. A new file
> 'ltssm_status' is created under debugfs, allowing users to read the
> current LTSSM state as a string and raw value.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>   Documentation/ABI/testing/debugfs-cdns-pcie   |   5 +
>   drivers/pci/controller/cadence/Kconfig        |   9 +
>   drivers/pci/controller/cadence/Makefile       |   1 +
>   drivers/pci/controller/cadence/pci-sky1.c     |   4 +
>   .../controller/cadence/pcie-cadence-debugfs.c | 208 ++++++++++++++++++
>   .../cadence/pcie-cadence-host-hpa.c           |  19 +-
>   drivers/pci/controller/cadence/pcie-cadence.h | 153 +++++++++++++
>   7 files changed, 398 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/ABI/testing/debugfs-cdns-pcie
>   create mode 100644 drivers/pci/controller/cadence/pcie-cadence-debugfs.c
> 
> diff --git a/Documentation/ABI/testing/debugfs-cdns-pcie b/Documentation/ABI/testing/debugfs-cdns-pcie
> new file mode 100644
> index 000000000000..c1104e28e4ee
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-cdns-pcie
> @@ -0,0 +1,5 @@
> +What:		/sys/kernel/debug/cdns_pcie_<dev>/ltssm_status
> +Date:		March 2026
> +Contact:	Hans Zhang <18255117159@163.com>
> +Description:	(RO) Read will return the current PCIe LTSSM state in both
> +		string and raw value.
> \ No newline at end of file
> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
> index 9e651d545973..cb010bc97aad 100644
> --- a/drivers/pci/controller/cadence/Kconfig
> +++ b/drivers/pci/controller/cadence/Kconfig
> @@ -6,6 +6,15 @@ menu "Cadence-based PCIe controllers"
>   config PCIE_CADENCE
>   	tristate
>   
> +config PCIE_CADENCE_DEBUGFS
> +	tristate "Cadence PCIe debugfs entries"
> +	depends on DEBUG_FS
> +	depends on PCIE_CADENCE_HOST || PCIE_CADENCE_EP
> +	help
> +	  Say Y here to enable debugfs entries for the PCIe controller. These
> +	  entries provide various debug features related to the controller and
> +	  the LTSSM status of link can be displayed.
> +
>   config PCIE_CADENCE_HOST
>   	tristate
>   	depends on OF

Sashiko pointed the compilation issues when this is build as a module.
The linkage issue needs to be resolved if we want this as a module.
Also, if we build it as m, it would requires MODULE_LICENSE() and 
MODULE_DESCRIPTION().

> diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
> index b8ec1cecfaa8..2cdc4617e0c2 100644
> --- a/drivers/pci/controller/cadence/Makefile
> +++ b/drivers/pci/controller/cadence/Makefile
> @@ -4,6 +4,7 @@ pcie-cadence-host-mod-y := pcie-cadence-host-common.o pcie-cadence-host.o pcie-c
>   pcie-cadence-ep-mod-y := pcie-cadence-ep.o
>   
>   obj-$(CONFIG_PCIE_CADENCE) = pcie-cadence-mod.o
> +obj-$(CONFIG_PCIE_CADENCE_DEBUGFS) += pcie-cadence-debugfs.o
>   obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host-mod.o
>   obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep-mod.o
>   obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
> diff --git a/drivers/pci/controller/cadence/pci-sky1.c b/drivers/pci/controller/cadence/pci-sky1.c
> index e1f4a98e2ab6..b8632f1d3156 100644
> --- a/drivers/pci/controller/cadence/pci-sky1.c
> +++ b/drivers/pci/controller/cadence/pci-sky1.c
> @@ -221,6 +221,10 @@ MODULE_DEVICE_TABLE(of, of_sky1_pcie_match);

[ ... ]

>   /**
> @@ -447,6 +583,7 @@ void cdns_pcie_host_disable(struct cdns_pcie_rc *rc);
>   void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
>   			       int where);
>   int cdns_pcie_hpa_host_setup(struct cdns_pcie_rc *rc);
> +void cdns_pcie_hpa_host_disable(struct cdns_pcie_rc *rc);
>   #else
>   static inline int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
>   {
> @@ -472,6 +609,10 @@ static inline void cdns_pcie_host_disable(struct cdns_pcie_rc *rc)
>   {
>   }
>   
> +static inline void cdns_pcie_hpa_host_disable(struct cdns_pcie_rc *rc)
> +{
> +}
> +
>   static inline void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
>   					     int where)
>   {
> @@ -535,4 +676,16 @@ bool cdns_pcie_hpa_link_up(struct cdns_pcie *pcie);
>   
>   extern const struct dev_pm_ops cdns_pcie_pm_ops;
>   
> +#ifdef CONFIG_PCIE_CADENCE_DEBUGFS

Use "#if IS_ENABLED(CONFIG_PCIE_CADENCE_DEBUGFS)" to resolve the 
compilation error when building as a module.

> +void cdns_pcie_debugfs_deinit(struct cdns_pcie *pci);
> +void cdns_pcie_debugfs_init(struct cdns_pcie *pci);
> +#else
> +static inline void cdns_pcie_debugfs_deinit(struct cdns_pcie *pci)
> +{
> +}
> +static inline void cdns_pcie_debugfs_init(struct cdns_pcie *pci)
> +{
> +}
> +#endif
> +
>   #endif /* _PCIE_CADENCE_H */

