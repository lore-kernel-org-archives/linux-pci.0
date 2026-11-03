Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793736908;
	b=rmSfxgLUHTPw03MDd4d6XbiJKUXZTP1EougjU1manOOFmTVOzfoXONczR+K4nKQoEkbX
	 AH3Zcw+GQzmBbTzGqEDzLLvE3sbcEkdCogegHqWRJBXPGScK/YHpSb/AGERyxwxLrnw4Y
	 r1mNg1zWjKqYYSr7kyaXlcJo90IVhVVCDEeLQzpzxVz6na5m4dKFQ3NSDc/D3MKvH9Wss
	 dyl2cM4cj5GHKgE70rO+y/BGhpeN7cfC6lq+1XtqYsUYNQ8lc5vGI1MH7+hJQmeqvAhyJ
	 QcN7RPcJC1ri3BN6jHKiBMuogC5ABqKUEIQkn0cGY0wh78NexUGUuLyrGGNtc6S+NVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793736908;
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
	bh=T0H1tbkp0dPwN0jPk8G7Kp00Wae5TSZlMatjuqlE9IM=;
	b=RckuEbyGNQezKAOw9/ahHqjPWyiLmcclZHFZUVnIDUOHU3phNFiZHMXXoU9Rc23pxhWn
	 qD0K8Z+vLLFSUnTma5fY7mCs3FXgAYUkaPujpyQOxp3QM8QYoaRveZfgGrwD/tdWgTxdM
	 eL5CThpjktd0SD4fU3OFzurWoBKXi0zViGHf7fsBRJLm/MHAMlxxgRbulrJYCI2kk8Zvv
	 NKvy2bWOhAYDcY+1C17qsQfLrdtJzy0mS/kxuJoi9/Pix+BQzrmP/4VLe1LDG5RYXlhE3
	 JnwykSkLCn5YwnqlbFqpxp3feXGYWsM6UwSV4IRijsl68HHUHxzynYWdxrrz0lmBMNA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=q7Ljzzxs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.20
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010020.outbound.protection.outlook.com [52.101.61.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0902A606A332;
	Tue,  3 Nov 2026 20:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0902A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=q7Ljzzxs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqfTSkP4F3mOWCrL+MmBfO3uEr4UB6IuybsmwpVTdWvYdNVNMmBXpa6zXoRXuy5xz5sLmJVtHZGOn7TbXf95D1XeKG7XUwSBd2YN2XXwjcmvuOrX582wBz6rVZ/E2CFUVtFoxlNRyHcHc3hbBEqz50wsfw7u04Ms+RngvW1H3rClTCICC8OSv+0Z/bmXqRoVD2ItNICWPkGesH569vn5oWC85OhQmqZyAI5V9nicaIIpx1bBdcsWzqgmCaAUTy8WCFyB49v5f1f6e0NGnE31TMyCzMZUcL6JD92lJB/rjrfCkT/rajIwqD2VCh7woUShPhdxYV8biH0NJX8R/QJ0Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0H1tbkp0dPwN0jPk8G7Kp00Wae5TSZlMatjuqlE9IM=;
 b=H2KFo8FuUzmANvOewW7b29dQQ+ZJOJ4Td9yFM/cOW9faCZO6UnnCj86f4W9sbb4Vn2lw5Mv7BLwOUv7KZ+nF6w6oPyiXbxEnYni0IjsDJS2mxqG/48v/XJ411ydAx14NfdYyb9a8LrXQkpqXUKKouYIiQksxwFFH0Av4Jq7Q9AedIDiu5Z3/fu45rqmqfzUhDrvDB14sQnSOZa/1JUz2Gx5EvUg4XeJla5wb2nG6WmSEqKuvfjCQ8knXZd3iYARfaIvVb7ZkcR7tdQTV4k9eOB9D3RTUJkpUvza0k77Sn4sZ9S1avv3BOMWWCcynjh3JhKKzgDlDuCCKvRpqtzVfXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0H1tbkp0dPwN0jPk8G7Kp00Wae5TSZlMatjuqlE9IM=;
 b=q7Ljzzxs91n0VA9mSg4uzAkJtxbqdqPqAzcDyPfJfaIfv7AkW7rnbGpQGDhxHmQCMf2rZhdf15c8WL00FBaLtPWBJB+h9E9Asl29e13bR/VPtwhGs4AdOEfKnL1bk4VTsN2JI0bMO5aRWg0wRF7GBFJtt8Ft2rGQS1v1jtcpuJc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) by
 PH7PR12MB9176.namprd12.prod.outlook.com (2603:10b6:510:2e9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.8; Tue, 3 Nov 2026 20:14:58 +0000
Received: from DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf]) by DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf%5]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 20:14:58 +0000
Date: Tue, 3 Nov 2026 15:14:49 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] PCI/DPC: Reinstate support for AER-incapable ports
Message-ID: <20261103201449.GB314988@yaz-khff2.amd.com>
References: <20261020181924.3003553-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261020181924.3003553-3-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020181924.3003553-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0196.namprd13.prod.outlook.com
 (2603:10b6:208:2be::21) To DM4PR12MB6374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB6374:EE_|PH7PR12MB9176:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ffb426-9657-4bdf-58c6-08df39e72252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|6133799003|10067099003|22082099003|18002099003|56012099006|4143699003|11063799006|5023799004|261022075727099003|261021121427099003|261028144727099003|261102123227099003|261026121527099003|261026140227099003|261021123027099003|261009223027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	4MnCs6VOervaCN4EHBQc3BIaFSuJ9hsjky2c6sVYckA7PJgEDreciizFdqwK59Mk1PObJXFDMzEcYKTfKUFzP30dPxJO8TCaw8FI5suA/gURaZhbKSDsPE0e5wTL4Rr6eILvDRloDkvKWWjNEhZXx3YOji/Tqpgp2mbQTVMxCp/wDPX33r5GfaDBb9LBRoqb5Q/TntXUxTKNHeG+dkjyWzGlPWiN/1j229N+aUlMIuQTy+C01OTP9sqkIyMd3m7yXuEeGz+bAWA2nxhLt0VcUp6+KXj8KwBVG/mkOsRHK3rlZLfe/NiGOZktZmrPt9/ima/RR/OSXE0wKofXr2kW5cp/JEx1aShJzGdaarLJHGa6AOlB/CRYBb0tCe9ydt98iE/etNiPV0eK4OSgXoMr3ITYbjRhXVkPg9XAHz0D/jhLVROsILLBYr/pykt2oRWVUwJpiPPOpjiSkkcSNspYZIafdVgOtLmDFO1qhfe/veiu6Zw8SxYAOz81r3Qj6jiHP+8TDkvbqp8dZ06/EqqfT8V/X2Pb6aR7IWPdr07AVltGdCjm+vCMDjsXRfoJuFPe02bRCtbYx0L3+AKDwaPMxql2ggsZpzN0IH9+xAopeDW2C47f/e6jChEC1i+VdcxI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(5023799004)(261022075727099003)(261021121427099003)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261021123027099003)(261009223027099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HXs7ITzs3b2u2AIV/XsbAFqrZjEWOMUmjG5/djcfVHhLfdfl0BCUm2EZGijl?=
 =?us-ascii?Q?xmV2k2Cou2Gis3jHaSm98JJYcZ4Xlt7Z8OEUJ6mD4eD+zIpRW09XRgRhIpE7?=
 =?us-ascii?Q?Q/U2b90NWf0KcS5fYTLvf9R4DJTDFa10kW5D5lWRHwfPowu1vbsaSyMrPSNr?=
 =?us-ascii?Q?MkM/JQKeQYaTpF30NUl72Jn7tNWhc6HHPoMV9KF6pnZ8DE56LQ6uuzM07wJw?=
 =?us-ascii?Q?sopbP6EPQpUtpwK6GBssA/c6eVG1xjg1Cdw6kmqTG8FuC/J4Tsv/muEKMVpK?=
 =?us-ascii?Q?p0b8aev5eR/mR+pZfHJe6s0ITxIO0xhoxdiAtghFBzTxy6YBV2YfGAygpSsB?=
 =?us-ascii?Q?8/LTgXMji5LGajjtoyH5WRVK6ccZGoq89z1qxuZuec37GdJd+MpDZRL+AbFf?=
 =?us-ascii?Q?ipydcxkUS0D2RmmrVjvjalwyGFQva8eEkqBFOffudJDa7NyK/Ef3niiycioZ?=
 =?us-ascii?Q?ySAJajh0xd2YRcN5Q9/hha2N2zKtGTlUm0Jjve0lbSi8YrTR7f7NnHWoy2OZ?=
 =?us-ascii?Q?RToEzD0td4h9ve+NUIblaJH/D8gdJZFWOmsPaJJVH+UuUkYkzZF5sMKDviMp?=
 =?us-ascii?Q?z8eDE7Dm/7Tp26HLnkepoc0oS0C16PjAm0whW8apPsnz/5ra6o4VdyG/jnXq?=
 =?us-ascii?Q?7ZeFryryDyDGVPlmpn+GU2Kv8c66p5ILhA9sE8FFhV33WCHPfQu2CDAG/J9Q?=
 =?us-ascii?Q?AVP/uxF3zuoZJYgNnbv+floB2MPdxLdEOjREHmoFLtNkYSZYdv6QW42A7bkZ?=
 =?us-ascii?Q?votwPnNQUVbC48R3PPaxn2T1r+CbNfr2IpUw0ggFzOTtva9V7QDKHzqCBBkT?=
 =?us-ascii?Q?PODvAC+Ve+dNdLghKOxd/UF+6rFZmXmq/elgOkw5lGSL50An5CmPpFozRF4v?=
 =?us-ascii?Q?R7tAj3Q5M6pm2VLduOoIjB4YizNjdoycSTQdI9yk+o21Vb4WFbBqkXUiPEPD?=
 =?us-ascii?Q?9I7gHocUTsQk7x0n9SDqpovPJcqpQ3hq6blyB0zmDFkkxLtStGib9b2C5lvM?=
 =?us-ascii?Q?i41a0CNxDwEmLDgm2E+hkYwX4eFbQp2qysEiNKGMHjvdHdJ6PflcUZINswse?=
 =?us-ascii?Q?QpGldWhw8dRiA5R77Hs7cDw/43OjDbHLtayKITGFkGcsHx9vzJlDnMYjbheI?=
 =?us-ascii?Q?809S0iQF6IEnivy3xsBcW422QWqsMClAeM/kxbTp5zobrgp4WNhaYBtwbI9h?=
 =?us-ascii?Q?CrNGRG4NL5YVDfpCe2ZgHVlsJv9ikXKjX3O+Tx+OSdDi4loHSD+v5EueHziN?=
 =?us-ascii?Q?hoZuyib+/6tg//p+TP0Qwh9Lfab3Chk03TLBEjXeaZgFJCvsYjjbakJodVIQ?=
 =?us-ascii?Q?6PvyRIZD+kX7WZncjPDHs2KgEhYp34ctwNdKt1HSV2hq+B2/h51odngVuQKC?=
 =?us-ascii?Q?Qu/xS72XqdM8Zi4NyW0T4TqfEcmeibbeFjgQ+zjHQ1UzyfYjkctfI6Bavnby?=
 =?us-ascii?Q?wS11+QjsGLGnovqO16UL9x4FU7iTYcsmhCubzkQtDxydDp/baBYHgoLgwOHC?=
 =?us-ascii?Q?91k7Dg6VdzL9XW/JGJO2Y9j+nEif2HC3wJbzNkE4toCFOfaOKY2+SqssrDWb?=
 =?us-ascii?Q?xJPppsjPfWm9OwR4z6qyEXYnh1HH0AdCOIx7sCTC2FDfsGgSXWRmOy8cdT+e?=
 =?us-ascii?Q?7nL8N8he5AEjBSH5tmbFg6rVOeQl9Oda/z/0m172cbVhi8sRp52GuvUZLah0?=
 =?us-ascii?Q?TSCQ5jeXPpfwUqgv/dNQ8BossfGuhaGyoPEv1PGkEoM4zVEV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ffb426-9657-4bdf-58c6-08df39e72252
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 20:14:58.7710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xz/EhoQuQBVnqE4ji/PMgZlXU9Z/Z+M3Uk9VRWFF2lLT4Fpn8LxMyZybC9Y2Fgc+Q1EzipF2Wm0a5hlQuN794g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9176

On Tue, Oct 20, 2026 at 11:19:19AM -0700, Kuppuswamy Sathyanarayanan wrote:
> From: Lukas Wunner <lukas@wunner.de>
> 
> Downstream Port Containment does not mandate presence of an Advanced Error
> Reporting capability, so a Downstream Port may support DPC, but not AER
> (PCIe r7.1 sec 6.2.11.2).
> 
> Commit 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST parsing for AER
> ownership") seemingly inadvertently constrained DPC to AER-supporting
> Downstream Ports by inserting a call to pcie_aer_is_native() in
> dpc_probe(), which implicitly checks for presence of an AER capability.
> 
> Drop the call.  It is superfluous because it duplicates the conditions
> applied by the PCIe port service driver when it decides whether to
> instantiate a DPC port service (see get_port_device_capability()).
> If the conditions are not met, no port service is instantiated and
> dpc_probe() isn't executed.
> 
> The only difference between the conditions in dpc_probe() and the ones in
> get_port_device_capability() is the check for the AER capability, so by
> removing the checks from dpc_probe(), DPC is supported on AER-incapable
> Downstream Ports again.
> 
> Fixes: 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST parsing for AER ownership")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v5.8+

Another open question from the other set:
https://lore.kernel.org/all/02a33171-b901-400b-921a-c40fe167b424@linux.intel.com/

Maybe the issue is more about how to handle the Fixes tag?

The recent commit is where this seems to functionally break.

The older commit is where this logically broke. 

> ---
>  drivers/pci/pcie/dpc.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 793a799053f1..104ff2b91f1f 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -474,9 +474,6 @@ static int dpc_probe(struct pcie_device *dev)
>  	int status;
>  	u16 cap;
>  
> -	if (!pcie_aer_is_native(pdev) && !pcie_ports_dpc_native)
> -		return -ENOTSUPP;
> -
>  	status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
>  					   dpc_handler, IRQF_SHARED,
>  					   "pcie-dpc", pdev);
> -- 

But I agree this is okay otherwise.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
