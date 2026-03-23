Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013030.outbound.protection.outlook.com [52.101.83.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4561332694E;
	Mon, 23 Mar 2026 18:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291702; cv=fail; b=p8ClTpJsOlUjgNCWYLggtCbWVf2qayFNHIuSHzaXOz5Q7z1Bat7zQCviA3EHnvesUoPQ2YjJg5vcI2hTGHZi2M3nv8SLOriY3TjkQ6ciDd3tSKoShF51pBCRbc09J0wKqSe9W/jL1LCL7BrTrT1eP6MUL1ljVcFevzOdk3hlt/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291702; c=relaxed/simple;
	bh=THhVkMmnDh6nkymzdlChh5fC4kwtiYSM6+h2DaaaE0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U41dy7OcHcG5KaIiNMMa4sXT8b6xPnGBWXHrxVluIzfptu/9XzIyK4cpxo4IVx/CmRW1o7f7jXj1jAs5mZzjK0RnQ7lunPx5jp3HGRH/rYa9Kqaa2yMXSaRDRhr8n5DQNyDfEV+ueJrcFhP+wlvKYeiAnUjQFU9JBs6qzUwArSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IAb+1NZh; arc=fail smtp.client-ip=52.101.83.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IAb+1NZh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8sq77YU4P0SmmmS4ZbBVK5ZFOT3rY40uth8eSMF1sVDlI/h5tckmREwdz62fL1Ft3gRG78SWqf3dS+nAC8ng1Vk6UszgUdALR2ZCNWSBajZVWmTCnsvIwUh3Jj4MykrFBK9qnBO0Vj1d5G0xf9PNwWKLkU+zOrhqZ/4YK/cN72UVcY7t5CT/ULErEkkeLCSlkd0z97I6SrpG0xynWB6fv5rgagxTeeKxPC4Y2Zr8qKvp3RX95bS8wCtQ2pgy5kD/myGu4VbtpR6fGObaBNceA1PsSVCJaXTfRP/uUG5gLH4PoobJ+c1GEgLC76ucSM4KBjRQeA31+95owjXDfHQ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUkGrgSMu50OzF1mxhLJCctRYdfsGr3GS9A4baxOxFA=;
 b=chruOrMtTnOZX+jaeXlK0jw5h0sum/FBfOoUY9SwWb+oNqJRiNrlalWaFTpTnx0e7Ar+pZD7hlhxwejtLRTblAfwWBgNxF2eZ5GKreDg8YvydtcElrarPpsl/C6Wi8M4MN31sd+DqO4VYu9Xv7LOz9rH3u5s/mbdnPcpGhtYHQECA4c8qQau9kVrIM8d97lY/2mziFynIsQ3tLDDUlBLxsOBSIiBhupGPiEo2qidd+OHz3OrIEJj7t/y1NSDpcvaUt3iOGReXgm36+f1ys/bKCga0oqRQJFDfz8pUIR/6NfPe3iIEH4vP9/1uc/kEQjtmV8JDYkLwau5/qF4pXHxqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUkGrgSMu50OzF1mxhLJCctRYdfsGr3GS9A4baxOxFA=;
 b=IAb+1NZhC0S2q0wbjMQl7mjqgEhiq1+9MJOXm5QkAFOrx+dcbdrrxym5RrlAQuRRGuSUxqkYACYz1C5CKnugHjJTUzzUic06tfMDCDrl4vlGnhS3xmCkc9w9ETE3T8CEXxaYeWdQbOPgecU9eP6jfQ3YKUG7GOVfF3aIUn4w4/bEAX3R052RQORtTXq/GP29+RxujkQ5ng725aqKo1NZg5+riD5/oDBSnkbalR+qadYuOx0By3qftF3zlusUzzE9Jrb30da3UHCV1xpNX4Qn3wQNgZT9KGWBZ34bApZ3bCZxnJfoFwjVcMLXVu2LbHcGgw/S17GBPTxFQ9Hj4F3Kmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 18:48:03 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 18:48:10 +0000
Date: Mon, 23 Mar 2026 14:48:10 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>, Niklas Cassel <cassel@kernel.org>,
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: Re: [PATCH v10 7/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell
 fallback
Message-ID: <acGK6rUIyuJP6gF7@lizhi-Precision-Tower-5810>
References: <20260302071427.534158-1-den@valinux.co.jp>
 <20260302071427.534158-8-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302071427.534158-8-den@valinux.co.jp>
X-ClientProxiedBy: SN7PR04CA0068.namprd04.prod.outlook.com
 (2603:10b6:806:121::13) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB9422:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a9d85fc-3247-4a60-dcc6-08de890cbae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|7416014|376014|38350700014|56012099003|22082099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	xXvLKPAEEmJhm7AVmLhSYhnrbr/ImJk+EjfNM6usOYMiVNmsajX/l4LJa7zGU0wN+ToMjGAnIy0C+RFtYak50S5LkYDZ9uelPZ8T0gB9S80qr3kGiYAOAfbLE6cPMnBgFTxHLwhplYqs0+UmtaJpjTvGbY4Cs0CVpHTS2yobENLyHnVAYiFaTFnEW3OHJES7cuI4uf3bk4AP7sqzxG69qOm5wbp4x3y+CM8WnHQeokCfCpYs8UG7/UoSZTs7jWaM60gUcjiAbHBKsgf6J08BYOGmFlMJTujjB1zuY3L9FSLlhMDg/yWCMU8pCt4iNXTieT7KVSVxe4iMkTQxTQb1ovu/Y87IkLGP0Uo0KYpHICOSQVALVhtLNQxeqPg5WqLJHNfc5T0BGYVRiO6NHvWf/RJ7S7Z1lc9iXOBPlv9a4oVCvZnzdXVOZnxW5pRtcilD4f2sY61MTWUTfXqr2VfAnbm1V9dnQzqURH6wfd+ZuIyTKL4fJtGv/wlM73L0d3j04DXxMKuwerEWdbmckU0X696AzYBqCuF5GG1IbaWF4Q2AKAWb1Mu9qAOLar20fmO7aWVFiAAdCTCoqZBM/Zih7NdYA3uBCCDh6I3A1RurjVM2rLON3f7bwPolAlvn71KvXiNShpJhoFQP4Drwsrbu4LaMvvTKUTGNjOVuRGHTz6Z/TinHPts794pFsX+zsWWexkK4ZZULmWP30hmg35POgEyM5tgo40hac26iDb0R4sChdoaL+S3XFKhDBtjK1sxFhEhsJck534r9SHFFBArDnRXRMm1H7yEadzMk5RwiVWk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(7416014)(376014)(38350700014)(56012099003)(22082099003)(18002099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zKUJ9m/08qrvwmqfYC7oCQXc1GSgIgyBalOY2PRN3ygzeXfv5wBVHKIzQIXr?=
 =?us-ascii?Q?42K0C76hU8qa9CdURs8o3m+iIrS04GiNaa2a5CsiyoQG8QrpdXAA2jFTSeQC?=
 =?us-ascii?Q?rwvaUpefhN7FJ4NSDiDJKVY0vdZukfp0w3XGnuUah6ddlxiuO7W4AXGWuGTp?=
 =?us-ascii?Q?UKoLP9q+N9bqTDsOa0Xl6HGYux6VFoWtvSzKgcjZYg+SpoqkIFCvvcFwGSzZ?=
 =?us-ascii?Q?nx8tIeiv7QEF4DLVgDlNNKwSiLGE+7LEbe9Va5nqpHlN49kCKSb+YAgC3iqr?=
 =?us-ascii?Q?UIc/s0Nbv/zBtyTs0j0eBqUfy0Eu1AUrLBSall0wBmOKs7KTm6ZVzrdapLkP?=
 =?us-ascii?Q?h2IWcT8UUG2H0SOWLeNP7ZAZvWl5pJtklLhBCN1VMvnge13tgceI8G+pdWud?=
 =?us-ascii?Q?yml3/8fRUO+21gISTAjz3KR2+4d2vTulHAfllHh+eGeu4GAbovDPx8+iHO0g?=
 =?us-ascii?Q?qRxLyWRuE0ot/8MRCeaIgPgI9sPgbgCZgKJzXZJNv1urGA1tYIDd7tML/a9q?=
 =?us-ascii?Q?qQj82vjMXAnZqqajo6zYrp7b/Kptv01km96xRXIEUKUk+jU98YX8YNQxlQX6?=
 =?us-ascii?Q?Mw3c7G8oohwTi1iUEa/6DJDW+u47MBjHDQwFMiCFqPSPpnHL+6EpNXNjmifq?=
 =?us-ascii?Q?Bt8QTn+wgluQCmdcfZmV/zaRlI40vVbUKq+Gmamdd+GQuAJ0uOFKh6mNy+Dr?=
 =?us-ascii?Q?h1j3LOSfkMelfoUMJ8r2YiXeJFf2MgwGNSpeV+GQCHczZIMQOei7sYS4dkiy?=
 =?us-ascii?Q?E5zNDHJwhB6AMOlsDMypJGtp64jBToeb7Jv8CS5N9V285pl/3/5qfEq0cA5w?=
 =?us-ascii?Q?dLxo5IGXkUauyDnxvEPO8U+NQDCc5RV8Zx7IMAtOqVsXPVNN41T+QIvSP9w6?=
 =?us-ascii?Q?73ugOdB9ZVssJzJLSeWIu6t/FvOt7t7ntw4mAYd8mj7BMST/VhSEk7BJargQ?=
 =?us-ascii?Q?JJJecVn7NO2xhUMuSbvIc1dw5iD4LQONlfav2c1LMF0WsBJcTa0RH0dfhZHf?=
 =?us-ascii?Q?FKrRL/DVeOu63Ov2km5ROdfShBMlfiTpK4y4YeZU4O7c8jPT6tkEPySfxXL6?=
 =?us-ascii?Q?fOQfqPFDrOMuAwjF26Ig+w8TRdTgEW7VdDJXYepyqungZ27gm2OGkSsETmLc?=
 =?us-ascii?Q?oZevacFCTFRS15vgTC137ch9Eoe+KrT6wevnYKGugLpuXns78Bdg/GDbfyoQ?=
 =?us-ascii?Q?IwmDfpyzuGtenfi5zH8FrePnt0MbElZIbFp2WYei3ibbhh7L+gdGVB9I30II?=
 =?us-ascii?Q?JULHTYMsF6KX4j7u3m9ULYGL4uKKkSDPMKf3Ag8dB9/gW3o/ruGoj+JE/k9i?=
 =?us-ascii?Q?tWXU53+C3tJ7oc59Y/IlSlUvwokIiNR14bLuy6hy4vFS7J84k5RMqmB7uJef?=
 =?us-ascii?Q?8elGmTAOCLhk1YeSu9iF3GhKI1OhWVP3UISOrlOcSbUgAIoiHNb3yYHm3BXN?=
 =?us-ascii?Q?ZzqZ4Av9PVWwXUMwvGCttv7gdh+8kMsdMIEo7LvzGqUQOB9c8QpUkzJGFMOr?=
 =?us-ascii?Q?mlGinBZEjzF1YmK+UUxqMWHAqSofsoWW1HLT68xj2Kj/HUBthMK0m3+0Qfs4?=
 =?us-ascii?Q?tn1FuG8+DtsVxNETqSj6gkTN4N9i6Oh0p6RpAmagNfGLE8t4SquFfxPjqNQu?=
 =?us-ascii?Q?H057Iv2xdADReBRNcjFRrPTwPikvPVl/4zRxGs91/9bvizpNRBA37rifKOnO?=
 =?us-ascii?Q?V4wXVOu4R80w8aSnZLzVBhTUgwo+niY2pc3Z+kfLokVUpUq/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a9d85fc-3247-4a60-dcc6-08de890cbae9
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 18:48:10.4348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWP20sGEQfMIgpl5DNwO1TV2aKMpLIFDSvUbOzgVaR6rHL3F5FbBUf7mbfJ6E2OEH59NGaJ0ybkGcWErzjFkYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9422

On Mon, Mar 02, 2026 at 04:14:27PM +0900, Koichiro Den wrote:
> Some endpoint platforms cannot use platform MSI / GIC ITS to implement
> EP-side doorbells. In those cases, EPF drivers cannot provide an
> interrupt-driven doorbell and often fall back to polling.
>
> Add an "embedded" doorbell backend that uses a controller-integrated
> doorbell target (e.g. DesignWare integrated eDMA interrupt-emulation
> doorbell).
>
> The backend locates the doorbell register and a corresponding Linux IRQ
> via the EPC aux-resource API. If the doorbell register is already
> exposed via a fixed BAR mapping, provide BAR+offset. Otherwise provide
> the DMA address returned by dma_map_resource() (which may be an IOVA
> when an IOMMU is enabled) so EPF drivers can map it into BAR space.
>
> When MSI doorbell allocation fails with -ENODEV,
> pci_epf_alloc_doorbell() falls back to this embedded backend.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
...
> +	 */
> +	if (doorbell->bar == NO_BAR) {
> +		phys_base = addr & PAGE_MASK;
> +		off = addr - phys_base;
> +		map_size = PAGE_ALIGN(off + sizeof(u32));
> +
> +		iova_base = dma_map_resource(epc->dev.parent, phys_base,
> +					     map_size, DMA_FROM_DEVICE, 0);

DB should write. Is it DMA_TO_DEVICE?

Frank
>
>  /**
> --
> 2.51.0
>
