Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793810126;
	b=WnJJxk3bGh6FsbtzBneKIj50jM6pFvnUdynTEmgMBrsAn+LHB4WadqLd+RCAzadkLQVm
	 qXss0cH+IRiieyCohiys0SWKHvNeGGRHU94gi5tVN34sWLDN+c2bpn2MoshIkt3SV2Mmj
	 eCFzZCuRRW5uYR+Wq/nomeh0yqSM04k3BbpNwC6AsWOcl9wCZGsnrpYQ6V3JP8dlFSAUx
	 /D597sZ3ieThSOQgdBLDt1lAqWd12Y8ZRs1LRk+Q9VBrL83nMP+JK6K5TzBWvkHstSapP
	 yr8+knFwuPlBV3wizGfISIcY63ToKtP3hjSJNvdsRCdmmDNi3pd/WkY+lKrRNDtfaOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810126;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=WaOymruxxDakr9JxoACUT6zSivtOBfYMrBHoy9pW7bo=;
	b=r1y3bQROc4/q+uZb1q6GmZAFF6MMOsZoNfceVzNA/JJuvRpNEcTnIzYFqF2o2CXvs/t5
	 Q6mIstNnM5KMu31qCOBm+IYeNtTG5r1tYov8bRonjbUQlEqZafRcNkSIG5gdJKsqkPjoX
	 f6NAtK8rzp9I3KtSCHaNxQxeVcrtb3hYQ9Tc1+zFKy1C4NDjFWqCRGwweWgzjADugIzNC
	 cdAW+6Fqd76/kA+9kcUSz5OIDNqYVfASoJLvIrHs4moU4y/dMheGwE3BfK+wSG76HcQot
	 Di9iFul7JMF7sPQUQ2SuxY31m35CDw4b+TvA2bjyXFdyBB/5dNAFxMaJuRoY8bPgSLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dqwsf8YT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.48
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013048.outbound.protection.outlook.com [40.107.201.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5AF606A32E;
	Wed,  4 Nov 2026 16:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB5AF606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dqwsf8YT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPGjGhjd6y353EHfObO38vk0qgZwJuNprkoax+ZHG+Y9kLmPoGpE03YsTtBNTU4Xe3eJPJxllXgjVglFxGRaSqxlJokeXwgk11xqcj3PdRD+j+A12EuEUG3BsDv9hYpKYHR9RQRy9tzx087mgpM+iZIfww5aICKYme6Tu8OMC6iXpjhXq60QzkPMMK8qWCB0XrU9brnClpPXlb8N8hlzhnMztchNbBltdWhe8wNqUoh9R2Ea959SxmKPIFyCHje5/lBMTNUJZOkkSnCEwONO9OZIbzoF/yvV/V2rfIvvRSA7DoSfCmC9ux/ipBVU0RggBZevnFfC0AIrB/BEH0hpXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WaOymruxxDakr9JxoACUT6zSivtOBfYMrBHoy9pW7bo=;
 b=AEORHUnv1/m6ZnW7Z9bPh85MxCqKH1UQ309yTmXDCa3fZjE+4etuunOlIFUCkvvw3hTy130w1Pqrz45xZvjMt/wVrHdFp08X5nrxZ+lVux2DAYZO02GzCtaHoyxzyWWk3jACC9Qtau0bFbX0DPtuyz09l2o37bk7lBHUHmhbjfxy6JtkyPMHtRPTz91HmHnjmQL8qLTTeQYB8moKrtdmg1rPLduIvokwvNzZSRisArNGq1E8eCbL0NEWUIVgEwDioJJJraqwXDWnFqtgiYPgH3aQBl/bL4NNB1y5capSd2COuFeQi+4laryoPj3EBAoJ90xopyH0YcO6iHIq4lIM9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaOymruxxDakr9JxoACUT6zSivtOBfYMrBHoy9pW7bo=;
 b=dqwsf8YT4fj9EfzmMgqjoYKhkHd5zUY2m+jpHRfdGIu12nHnR0vBRxHzfsQlwShl2Zmj26djYJNUl9qXJstH/oHMu4sRMeew2Av7tgqlJC5pTEkD0yklAlKwx7DaTvzSrphLJLoOQz9+iFpETaFNWBBZG4OExwkI+2WOSmvORsc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) by
 SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.10; Wed, 4 Nov 2026 16:35:23 +0000
Received: from DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf]) by DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 16:35:22 +0000
Date: Wed, 4 Nov 2026 11:35:14 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] PCI/portdrv: Bind DPC service based on
 host_bridge->native_dpc
Message-ID: <20261104163514.GE716491@yaz-khff2.amd.com>
References: <20261020181924.3003553-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261020181924.3003553-7-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020181924.3003553-7-sathyanarayanan.kuppuswamy@linux.intel.com>
X-ClientProxiedBy: BN9PR03CA0313.namprd03.prod.outlook.com
 (2603:10b6:408:112::18) To DM4PR12MB6374.namprd12.prod.outlook.com
 (2603:10b6:8:a3::18)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6374:EE_|SA0PR12MB4399:EE_
X-MS-Office365-Filtering-Correlation-Id: 216f99c8-e59e-402b-bca3-08df3a919f2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|4143699003|5023799004|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261028144727099003|261022075727099003|261022105027099003|261026121527099003|261026140227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yJrYbirHQ09Z9e1/PiT2y+bqd0jg+eLZZvQ9iuUie+2apQjhYKssW4I0T2GhVQ5LzjAbAPRyLHCOQDZ3cQ1gPYb8JqWfxhELJDa/ANK9XIp5RX5rt1mw2B6yfW8UlL6Ck2uWu6VqW11FTda4hWQV5iq17kdl6QgTuEwPY0ERvYHRq6FG4VJMI7WsoqZvYNUCbm+eU4e5AbE8vMxPGiPb/dtsY6y56zVuY5n+qc8EaBFvrJR73MzgyqzxqpzAdCvoSlKe+gmoZz8Qqtt6vNcFb/wgf/8t/CbDRasXI5r6zfgamL/EA79AxS9gOp6nwGp0CZs4LEx4Ni59rKLTsBuTFj9f5upc+xjQZbbTOGObQNHUbn14jiyicAVtbrgupttaU4lfaScSk5eXqRtcRtzF48ggMrCJcYY1CJDHodTaaRJECYXHTr2QeNeGfvVcIiVflOgfASiQePhr0dqti1Q8xM3X17Hm+c4ajr8za8cMZJU1ZUBuWT8ESNn0bVyyLebsjKKIWctl1Oh982cJrfgLIUudDrhshPPBfjc0qB3UCHQ80Q+ayRSWzpBopOq6CQTQSvb2yUew+QWEni4qD5c1wbb3ZFTCJb2+Cp6/nqWNS+IvgQTzojLQrDEyVpXVfDrobgaxFu2z8K0MlTKyaCWHapncZ05uvxB8l8ka373d/Wg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(4143699003)(5023799004)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261028144727099003)(261022075727099003)(261022105027099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nw4oN8Lf/lmB/Qmb7H5MHyCcMNM/9nbW0DUpIiqgAVKwGqxVuPS1HdlQJoZQ?=
 =?us-ascii?Q?YjkP/hTs+jpHalf96LclC9L7O5JL32KzP7QP0t1kUBQrdQt5dTnic+WEU/QP?=
 =?us-ascii?Q?UZbg1DK+RZWz9d/fmydR8jiIfKEn9/aAOVvjziBCqZF4WUT0ijCtG5YToul+?=
 =?us-ascii?Q?pZji069xv1LN731VkHNk1YymQ5afaTXliArWwlxQzdrSO8zpN3jgdZxWcZTb?=
 =?us-ascii?Q?Yck8M4fwYLTQ5Sjkw3HEV4settsyspVsN4NGMqqnyVv61X+/jA8jMijQ6D2d?=
 =?us-ascii?Q?TxkhWQLW1pgKEJNRxhetvuijSZRUaEx/00eZM6k9SPvienMMDj0TvBr+0Uxy?=
 =?us-ascii?Q?JO5OYjXOTKHbxlFgQ9XQZFWg+TCUEvd2boG87ZXfhryL4lf3qBgmMCELHAB9?=
 =?us-ascii?Q?H16QZdQ+srsbMUgD+gojcnDwvjhOm0oNW6hMq+BASZkDj/QtH0YL9nR71+Mx?=
 =?us-ascii?Q?Hv3rzcc7InikJjGi0GAmssxi0PoG+JR9k05WyNECtOVvwoyS3ZExeDKhyBuK?=
 =?us-ascii?Q?QwbB22qvPv00CYoQ6/N2V1rD2O5CwsXOnUOFRG8HTWo51ScPylcJQEwGp8uc?=
 =?us-ascii?Q?S91RwOkOM797YJhaPHJwBoKhfMo2P9upTl8gnTXy2a/z+zhq+XjlMphFcksm?=
 =?us-ascii?Q?jm3GajScIUhSZL7nCLeiN41lMYcz8s3t7Tg/F+fASxf3ZwDRChKlVdT/HBcI?=
 =?us-ascii?Q?FH/4ZS1+vyFllx9vhnOHOhafzBJ8WxVkw3Dn5ABzX54dn5D7X1005O724ziZ?=
 =?us-ascii?Q?Ubk+QOGclbb8E05Zt6G/GMM6+jS3tACPZXWlrPnfhKzlJrTDJdiQ4YkU1aUf?=
 =?us-ascii?Q?gNxsrCRN5emrUSYaX5axlzApHoCFRVDPV2oRHqWxmrNs2qL/DPZ9P8wAkN9L?=
 =?us-ascii?Q?6vfV0ymFRXu8u1uHmEcwU8AvAtzamLiYbiAaQ7AVpl5PYqNk8h2mS9rlcfpi?=
 =?us-ascii?Q?467zJ9UcmVhOTNFCQjqalLHWidsZQ37RQsVg4Joy9xgmCIuoOqTLbZkdNDL5?=
 =?us-ascii?Q?B2Rq8bPYdj085jx9gES4iU7RlundtWCdPuMW7Y2PBEIXqeGrFvT7r6Mfz9OF?=
 =?us-ascii?Q?g7BNlfIeBcF0bZsLfqRGbSgSp5H0oavDoSnW6L8Nrj2qWxLJVcIaIXmAS593?=
 =?us-ascii?Q?p2AqFmQkrVSfPNSu9+nJpNcupp5EHThAY8+pF38bdaiYW1FhhDCFN4iUZ9Zg?=
 =?us-ascii?Q?AxaPUv4IE6A2Dta/nLsL1gvshAn8Au+I4AGwZb82CtGsihA9/uH65ymHdG3m?=
 =?us-ascii?Q?0ykBBCzMxAv3yrYvA+Dn9VSnjaeEDh0znWu5aClYzSkaLlQVx9c4Mrb8ZHX4?=
 =?us-ascii?Q?Tf9m6qFnNeuKHL9PKou9M2lf3TPgBLAa2Hu2+rkzF58iURLV8/RkGWfUt26b?=
 =?us-ascii?Q?kPgUL76wOD5ERnTKC3A4J/BhyfENvjkQ9ahUtOQCGXER67Sd3lHvQUqskXDl?=
 =?us-ascii?Q?jJoA5EtEQPjaLL1Na0vzKZEcVl6KM5IReUhM3G8cSsaJN7vm2yPyEdyldBDl?=
 =?us-ascii?Q?EpkxEbP/6QKycKiShUop/3AjRqBP/nizxzcgyIxDrZ12KdlK0GczgIeLnfMz?=
 =?us-ascii?Q?IBI9bmwUq4A18/nkvXqBRHG8K+choKZZIFxJJMPHlfCqkXeZFW2vI5rBUYno?=
 =?us-ascii?Q?mZG0SrOgbdFqiqqdxa7iQud7uFINPGSkBda9WFZMG5/SXjkWTeZFtxVqUcRo?=
 =?us-ascii?Q?9Pq+au9L+cKI75kDerEORDUkSHEaoQd3MwqVTTFwtxkC08n+hR0KE7UuIH1G?=
 =?us-ascii?Q?9TATkOOMjA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 216f99c8-e59e-402b-bca3-08df3a919f2a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:35:22.7660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MFCg2YamxlYS/JkUjibg5KZ05P3F2EtZPgpcb2Efq4mwV8gjgO4G/yaUwHwDuNZ8By7ynFCZ2I5FnNRbY5+t+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4399

On Tue, Oct 20, 2026 at 11:19:23AM -0700, Kuppuswamy Sathyanarayanan wrote:
> get_port_device_capability() binds the DPC service if the port has a DPC
> capability and either "pcie_ports=dpc-native" was given or the OS
> controls AER.  This repeats decisions that are already made elsewhere.
> It also ignores host_bridge->native_dpc, which is meant to say whether
> the OS owns DPC.
> 
> Make host_bridge->native_dpc the single decider:
> 
>   - In acpi_pci_root_create(), assume DPC control whenever _OSC grants
>     AER control.  PCI Firmware r3.3, sec 4.5.2.4, requires platforms to
>     retain AER if they retain DPC.  Put the other way, firmware that
>     grants AER does not keep DPC.  PCIe r7.0 sec 6.2.11 recommends that
>     the OS link control of DPC to control of AER.  Commit 97ca178c899d
>     ("PCI/DPC: Allow DPC on all Downstream Ports when OS controls AER")
>     relied on this link.  Keeping it means DPC still works with firmware
>     that predates the _OSC DPC control bit.  Such firmware grants AER but
>     masks DPC.  The OS cannot tell such firmware from firmware that
>     retains DPC on purpose, so log a message when it assumes DPC control
>     that _OSC did not grant.  Only do this if the OS requested DPC
>     control, i.e., if CONFIG_PCIE_DPC is enabled.
> 
>   - "pcie_ports=native" and "pcie_ports=dpc-native" are already folded
>     into the _OSC control mask, so they are reflected in native_dpc.
> 
> Then bind the DPC service if the port has a DPC capability and
> host_bridge->native_dpc is set.
> 
> The only change in behavior is for firmware that grants DPC control but
> retains AER control.  PCI Firmware r3.3, sec 4.5.2.4, does not forbid
> this.  The OS now uses DPC there because firmware granted it.  Since
> "PCI/DPC: Reinstate support for AER-incapable ports", dpc_probe() no
> longer requires AER control.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/acpi/pci_root.c    | 16 ++++++++++++++++
>  drivers/pci/pcie/portdrv.c |  6 +-----
>  2 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 5c674d5b6bb8..b380b6d8874d 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -1056,6 +1056,22 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>  	ctrl = root->osc_control_set;
>  	ext_ctrl = root->osc_ext_control_set;
>  
> +	/*
> +	 * PCI Firmware r3.3, sec 4.5.2.4, requires platforms to retain AER
> +	 * if they retain DPC.  Put the other way, firmware that grants AER
> +	 * does not keep DPC.  PCIe r7.0 sec 6.2.11 recommends that the OS
> +	 * link control of DPC to control of AER.  Firmware that predates
> +	 * the _OSC DPC control bit grants AER without DPC, so assume control
> +	 * of DPC whenever we control AER.
> +	 */

Oh, I see now that this got rewritten.

But it really does repeat the same info from the commit message. So IMO
it can just be removed or summarized further.

> +	if (IS_ENABLED(CONFIG_PCIE_DPC) &&
> +	    (ctrl & OSC_PCI_EXPRESS_AER_CONTROL) &&
> +	    !(ctrl & OSC_PCI_EXPRESS_DPC_CONTROL)) {
> +		decode_osc_control(root, "OS assuming control (AER granted) of",
> +				   OSC_PCI_EXPRESS_DPC_CONTROL);
> +		ctrl |= OSC_PCI_EXPRESS_DPC_CONTROL;
> +	}
> +
>  	/*
>  	 * If the user specified "pcie_ports=native", use the PCIe port
>  	 * services regardless of what _OSC says, i.e., proceed as though the
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index b77680fd3b75..f1beb440a3dc 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -258,12 +258,8 @@ static int get_port_device_capability(struct pci_dev *dev)
>  		pcie_pme_interrupt_enable(dev, false);
>  	}
>  
> -	/*
> -	 * With dpc-native, allow Linux to use DPC even if it doesn't have
> -	 * permission to use AER.
> -	 */
>  	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
> -	    (pcie_ports_dpc_native || host->native_aer))
> +	    host->native_dpc)
>  		services |= PCIE_PORT_SERVICE_DPC;
>  
>  	/* Enable bandwidth control if more than one speed is supported. */
> -- 

Besides my comment on the comment, looks good to me.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
