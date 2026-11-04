Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793808821;
	b=IK1UeQtnHD3zGF7VuBMpiguxAVomT9CgTfEnLJytAtXhl5io9EwYHS7e3fOW/4W1kCbn
	 ph3ak9nDuotLgVk6wAa5ZKQwTBtKL4xUry7qLZNso9bXLd1ihmTbBycNq0Us5pZB95V3L
	 XZoESHfpvio/d06y1D7oRV9Q2quXTPoEEGKh3wLDDHtSQ/11OlU13+g9+nzkBJyjkHJiB
	 qiHMcE1y96HZRDH/bWtEmEXQioL5yNRUXRyJGb3lYtNx8CKh+rhm23FtHe7HfnOZm8wrr
	 ItwPiBS+/thMIJucN8a+5CWu9shEBm4PHoWkHAB2nNqRVqtBkVm3nHsNF4tbncc0PrQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793808821;
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
	bh=B/Wc65ga6/AJUV43LYhViruii/yJNN/DbwlgCiwaLkU=;
	b=U2XwBtDZXqKErVDYDoxT4JEJeeQrH9Wfpe/FoOoC499RZoMM6Ru0NBBJ86qFgiFhHu6s
	 ZTv/yra+1zBNz2Yc61+woeEEDAVBSbPFBWi+ZwKDDihteF7LGFYZ0TkBNLmknjPDOZ/nI
	 PDNL7v2swqMGJLeTriJEz8daZcdA28XQxVCEhdvEjhvZzqNhgIgODEMMO1Mx+4swkh7dM
	 IrA887KnPJECpnfD3Rl9YOO+9WinWkRnvMUKaYj9qO1VwmAjUZH/WGfN+rcHz/vjNV8t0
	 4SqTN485YMNE6vTSOBGnoU0RUjh1KOFtoVZspsPevHORqaffBFR4QPWrtJEOmc2b/LQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wqx5NNV9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.61
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011061.outbound.protection.outlook.com [52.101.52.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2739D606A336;
	Wed,  4 Nov 2026 16:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2739D606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wqx5NNV9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=joR0mwnaxeZGwz9ToVSo4tu7aX6Cz5yFPRwwsfvSxgmDV57K1Qw6SEEJUksdS/66Rkqpj1xIxT5w51Dx6+9bMwnFBNQGEafK+Af4FLN28Xwgl7V6YAOVNGp8idW8kPQy1VKtd7I+iqEMU7PqhzNK/TCA/oeAiEAEDZiEoyrpQsjv7Z5DppCi3lZqOzPSTcOvnecLRmIqJij/yMRTYjpNTCDc4yWaThgT2lSOPRhDZGRZtflCb9P5li5xv0C6TyiDRS/FwO8TWUdw0Gmx8uJonNeYicrCC3Sh00VMDUGxlT291pOSzPPA3v/nuN+lbvV8i39iit5vRR0D3/rLyZF29Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/Wc65ga6/AJUV43LYhViruii/yJNN/DbwlgCiwaLkU=;
 b=lSPlFCHgHdAYVmnD+s+IySEUU7lsph8+M+vzmy8PJ68ijVK7X5bhq3CLLov07MIEq2jTCtYgyK6/ygsHsYSozb5HRH0Igx+9FOLfzSaQOk06sPGUA/frcyVVGSbbpobsKaa7wSFV2a9VLSt6HNDf19wPU4/4HHudkhHOphsnY4znVAQr+a7Kr1WvCLBRjqMY7aNte/0Cux+XIhmuqJemuOy+6ScFhi/X6yGbWA3NeT+1YTJAeOfcg8vA57+RIPGGNnUNXGYy9X3vqJBxQAhoTdxp8DHkDI/9BWcMe2kIR3/tZGv2TwAeCY+7UHWdt6H6q+Di9nv+UJc7ntb2NGMveQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/Wc65ga6/AJUV43LYhViruii/yJNN/DbwlgCiwaLkU=;
 b=wqx5NNV9Wg+jYTyY5dGs2T1AaeGn4ycNsZ4nJVt+77GfQdUfira8vQb8vUioDq+TMM9IFBquo9sFpT2XpyWSp7RmZAlsW+Xekg+EvFRgwL6TlXjjephmGeYuQVqquzulAtav7xMALeYSgPB1gbgiqYI9RHqTSBtm9kewgyIR9pE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) by
 CY8PR12MB7436.namprd12.prod.outlook.com (2603:10b6:930:50::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.9; Wed, 4 Nov 2026 16:13:34 +0000
Received: from DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf]) by DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 16:13:32 +0000
Date: Wed, 4 Nov 2026 11:13:23 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] PCI/ACPI: Request DPC control only together with
 AER control
Message-ID: <20261104161323.GD716491@yaz-khff2.amd.com>
References: <20261020181924.3003553-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261020181924.3003553-6-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020181924.3003553-6-sathyanarayanan.kuppuswamy@linux.intel.com>
X-ClientProxiedBy: MN2PR18CA0004.namprd18.prod.outlook.com
 (2603:10b6:208:23c::9) To DM4PR12MB6374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB6374:EE_|CY8PR12MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: 309e20a1-471d-48c7-0d49-08df3a8e91fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|11063799006|4143699003|56012099006|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261022105027099003|261026121527099003|261028144727099003|261026140227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	k+zdTpniRqBVFZn7HbKRWncUvIu3uYAqSVjBeNGx386+d47Yi3IIFPeAr1rXfq4leHIQWOUw4QDmhOI0/Z/OLtpQb62xRm4H+l512Mplg9C/03bennT60JatyzYEavGhd4yPJq2pqgk7Pi50FvjSV+VAM4lCvOWx5mMek6xJIdHcnHUDwVVzmXk7fLO/wqlnfyeAQhc7b7M95JEtP3UGuGSpfJDTQ6wx4doDYyLDDTW+ewX2dkJa1xEjk9mgzGecG7hcdpNS6npxnvn2cjoBSLI18g0Y0wkXeS89q0UyerbFeXcIFIc6O9ULAQLQIDFD12vLc5zko8DOZfHdpjBmdmhkl6OKvvbpU7pPdZIKmLwawUAa4tGBCregdGlD1onbhv+pystdgYAFPllEQVmhF9iBIcYzlfedpeVlmW70LkWnA+sDVh3yiVmAUMeXtMjIqDx2xKu6GToILCanUEInC3g4y1YPMlb9vjyGknurRd7IQ2SmhUIH7pJu4ayTorOY/FYnXBsQsSrClGTH8yeCXYXZOynHuj/wc23sbG1rFpobhsSZ10FC9YZCTB2SwK44OQODOEzMhvveeCCuVLh4C9m0jgSTjJ3PJkdZUOIuTFYb+UOsM3Nf6PF9524O9HNaeCz6a1dz5AAokoe9FpCLw5HRuCII7H25EEncUaJUljg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(11063799006)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261022105027099003)(261026121527099003)(261028144727099003)(261026140227099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h6osvO/l8KKuPeoOXYeIEduqr2FR9ckltfPeLAVlhQ5je707b9dCa3hZcfHa?=
 =?us-ascii?Q?ijOGWxIAzfMyktGoGa9ndNnwOPqyU6KJ1raYyj21LE1wWGsBtc3cIV/PBLIU?=
 =?us-ascii?Q?KHlHbgxJ4a0uJxuoAdK/1LYY5UA9nfe9G7wKBBBgkviMhXXBab20sN9xiJY2?=
 =?us-ascii?Q?c5Arta1u/Dr+HjjZ0QA8Klciqzg5kQOAKq4CnDdbGcanBPDfPegYtnGoNRPI?=
 =?us-ascii?Q?DGSWk6DiZLyMALIu82M9+qFGepXla4IG2pfXiVp93bYpC9Hv1auHrqZ6MnxG?=
 =?us-ascii?Q?H2QBcNa55l/Jplv0KdDVs8opCv6PqFeqebTO6RjLKV/HEJbpG4UCPUBzMNMo?=
 =?us-ascii?Q?yvPeR/qWIT8g4EKFkIXcql5Kv3JrV5CvoZwOLCkOGe/lMamo5Pr/ECfnUBE1?=
 =?us-ascii?Q?jvLbDhc7Plu2GsUXBvXsMo6SjWW3q3KoY9JvRtpZfhcMKkPZQd6RF+7Hg11n?=
 =?us-ascii?Q?hX/dyyOsKU4OT/NxYQsGqySPRbkBHIo+r5dyfHHazvcvB68cpCLQKeQ/zF8r?=
 =?us-ascii?Q?8GpORcGXl2SpCbyeuZeAghDDVF8W25reqm3tZe+Mgz74ZWFXkzyeBEWaW/se?=
 =?us-ascii?Q?mZNFkHwvpORKolaDbpw7OU86o7bkMSBXqVNN9ER1wgffvcoeEefwC+/NJyDw?=
 =?us-ascii?Q?pr3XdIXeX+1rAua12P+7ktWjGVshuw/ol2gwGjBPixfmJO/Zi7Ev2GaYT/Ug?=
 =?us-ascii?Q?y4yEggVGMdzAAumauK7qYefoFDuHfp2BmHNzBSexh4bEQMZX+FYWQAuz8b5V?=
 =?us-ascii?Q?UC2fv5cEmtAHoZWux12EDTMyaEygMrARMMDQwzaHHTQTAhGTOKzBH3RodgpM?=
 =?us-ascii?Q?ivGqIOc095BakluSM+Gv6ffWdYmLLsgFTtfcATbi+LqDW2JixNsaqESi9bf6?=
 =?us-ascii?Q?BcJdX/m7KRxj2e3B844Ou38Xgs6D84yRCAgbMWqyIzh8wbsCQ5p0UueOzoZc?=
 =?us-ascii?Q?qmpSI+lZD6dAarf+NttPmfubqbNPbQkY+MFp1fMbP1SmuHrLC+q2AGJ6V0Ki?=
 =?us-ascii?Q?PdBQTvhvM9TWOHSssksxafcQttRFthMVsvpclLnDaS9eQUO8+2GZYvzBDrpH?=
 =?us-ascii?Q?/eUtZgWcyhQWfnOQqfLUmCLmwH+s2dew2KVd2M4eUgqP87scXTxLKXcZSJNv?=
 =?us-ascii?Q?z9V9FqaIaJ/zB4zMi7Q4BObjH1x1AcVJJAtIwdupZ7rF8vD3Bq2Mxx+hXOwz?=
 =?us-ascii?Q?ltLBrHJ4bRre13wVlXOiFMGowdW62/r1UThYGt55dHnRyrjBmnsc7SoRJis1?=
 =?us-ascii?Q?C+noMl3wFkNfP6LXz7D3LcfpfXyaMpthmZ+Hq+pVo15ofAfjBB6rg5kgfl3X?=
 =?us-ascii?Q?YQTdKRJOHB/qmEJz2R/NEKnUey9G3V01HmjUIFTh+9HRDoT9wM+QgTRd5gT0?=
 =?us-ascii?Q?Pw3JHczbjgUsWcLR7BKY9BN1pXCebjNRjcIl3xJE0L+GBRKmL3D+P4o8F6tq?=
 =?us-ascii?Q?ErN+4fLP/aW0DP9hFbpS/qrtGGoRc1yWlouv8Ry6XVbfSF+m6tUOKYlshrWL?=
 =?us-ascii?Q?IB19R04gLw59/QhBursGtMlRDNpLwtBaTgeZV3LsoKzt3W0rGkqFY9rKCZZB?=
 =?us-ascii?Q?9FN/IVKtuWJKlwUKPaU/auz2JIvzF4CQesbykTeMwM9DRa2Yh6YLuMEG1cSL?=
 =?us-ascii?Q?CSnXtT8YQEpp2Kqm+nXZmiFKMRmXycApEpYq/Mvfdn4WFRN/PEZlauT3zxjL?=
 =?us-ascii?Q?9GAT5LFBxv4VYVXaMNMn06YZ43WNBBm+LdWYKtwXl7IadWv1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 309e20a1-471d-48c7-0d49-08df3a8e91fc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:13:32.2571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivLqka2taTUPaCz6oCi71o3JUq4x3CipR8sa9vAbulx4dlq3xyY8eOurcvyrAvf9yA2I5ha++q6tkvQkYtrBdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7436

On Tue, Oct 20, 2026 at 11:19:22AM -0700, Kuppuswamy Sathyanarayanan wrote:
> PCI Firmware r3.3, sec 4.5.2.4, requires the OS to request AER control
> when it requests DPC control.  calculate_control() requests DPC control
> whenever CONFIG_PCIE_DPC is enabled, even if it does not request AER
> control, e.g., with "pci=noaer" or when MSI is disabled.
> 
> Request DPC control only if AER control is also requested.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> ---
>  drivers/acpi/pci_root.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index b0e0b33e3254..5c674d5b6bb8 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -516,8 +516,12 @@ static u32 calculate_control(void)
>  	 * the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-5,
>  	 * OSC_PCI_EXPRESS_DPC_CONTROL indicates the OS supports both DPC
>  	 * and EDR.  EDR is always built with DPC on ACPI systems.
> +	 *
> +	 * PCI Firmware r3.3, sec 4.5.2.4, requires the OS to request AER
> +	 * control while requesting DPC control.

What about folding this last line into the rest of the comment above?

Or maybe just drop the spec details and leave that for the commit
message?

>  	 */
> -	if (IS_ENABLED(CONFIG_PCIE_DPC))
> +	if (IS_ENABLED(CONFIG_PCIE_DPC) &&
> +	    (control & OSC_PCI_EXPRESS_AER_CONTROL))
>  		control |= OSC_PCI_EXPRESS_DPC_CONTROL;
>  
>  	return control;
> -- 

Otherwise, looks good to me.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
