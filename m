Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011027.outbound.protection.outlook.com [52.101.57.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E73430CD95;
	Thu, 18 Jun 2026 21:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781817996; cv=fail; b=JCyq3zsMrsO4xeSD3kfQxrdTVXl1ITimZZWY48ZLNjqeflL/A0zyFX0DTTiwUnCL9EEkHpDH3EeG2XMGspMMEsD7xWQOWhcIBkPh+ZCH3ttvRHVXYmTLj7QqxcQ5OUj82tm8MptOI4+rNGpHEVrNro8GPsWSCdgMHsdoG3HFAkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781817996; c=relaxed/simple;
	bh=bzbag7fJzaUtINft6YTsrlwYLB8H0a//aqFQ6F8DXKI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ALoLt1Li3cUwzwXNbOlsX54XkMVO1HhBC9qlGsBmgw4BkxtLkLt/EyLNQD/kLfNkxXjMIB6DEBuTgQs7M6Eo4zy0TDFnW5XNNIsTEdez4sxrSN5zgeTwrES6cNkOR8Nc4/Q9LOnWHlyKOsvyTG9gUaAexUZM5hROz/N2fmQL4lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pKeP6W9V; arc=fail smtp.client-ip=52.101.57.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pKeP6W9V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RV3xZRzbXgGXzPvMOd2TXEsEhH0jmHml+GXXxGdDOLqK493WG8j0mfACaGtzu98UyeOpvABZbAz/R6O0Ut9hQEb6586YWQEbhyISlMXU4BijurOxfCOsjlc06IR+3l9dE9mrhUs0WhRcGqI7ZOVoxBnJk1Y4glocYL8SbLBlAa2Rj25XqNcbi5DDKXCGKQsSUMtcaATy01rB+3kUPuQE1WnlSsx/n2uGSbmgg1ZAOPlPl626lpdCuiQ6AM3hZzgoiHKiF8fwE0jVvIGmhBzgFvBuHUTD/X7kPi7raz1xzBowh9rwWMTdOTrDIqWVnHVmtECLfVSNG4MapnFcS7EuIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sY4odMf1ucu5lvBbc9tZbK77tw288Wf9nvIUMpaEamo=;
 b=ucPjqrhprwEgBSsBFEqew9mJu5g5qwamymM25vKExvsSZHwBL6ZDhUaQCBhQFPlYrxevKkk1ywodAcG+NDaPWbJnr/M/7g7OAk8nsUGYvtMBuGKb3GudSGH3tzXgNQflmykNoPD3jdW1SZw/gVtfVxyWkik6iS2fMaXJmAUwCJAsxeMKPvAygHMWTYMLG38uMggsIysLYaXxCRFd3keZv9z+kMPGW7Er8EGCjOLnA66W9h/GKdvtXuQ44dRo65B22QTBSWrNQLz49BcT2P6EajCb+wuJx+42414zE/qq5XN5LrGr+d9HdfdK9Bp1ygruuXLtxOHiMtbVsYFZ2Hxweg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sY4odMf1ucu5lvBbc9tZbK77tw288Wf9nvIUMpaEamo=;
 b=pKeP6W9V4S5izwCUzfqXn1XFpqZgtudAXpY8naBgqwFGhU/ntml92bs4PdlmhNvhGRZMc0/4j3yBASCiUYXeEqyicNVE+FnwzCvTgKHZYrmvgRTPhdhPOI6Ig+eUspE54Q1Ai2RbCSk8zM3MuW1vfZJTXKKDFxE885hMqCfW0So=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by PH0PR12MB5645.namprd12.prod.outlook.com (2603:10b6:510:140::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 21:26:31 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%3]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 21:26:31 +0000
Message-ID: <c952069a-0cca-44ca-8cb3-d4305e0b844c@amd.com>
Date: Thu, 18 Jun 2026 16:26:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/2] PCI/CXL: Add RDPAS parsing support
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, jic23@kernel.org, djbw@kernel.org
References: <20260618170723.2010490-1-dave.jiang@intel.com>
 <20260618170723.2010490-2-dave.jiang@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20260618170723.2010490-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0033.namprd04.prod.outlook.com
 (2603:10b6:610:77::8) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|PH0PR12MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: 862d33d3-0214-4791-613e-08decd8043f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|22082099003|3023799007|11063799006|56012099006|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	xwnC+bPyTGqQjtSYUWPN/5OvFAC2jGlrs4J3im3nvEtddHGIpg34TLtvtAalaWyi3K+N29j2KOBHx6ydkrwTLfdU22SWczvEVFGk+d0Exn5U9izzxUoAFNsO+NmDSpgjtFJs2PKkmOaWSy7z+9MtauOB8vmC41kWF9GCFvrbNsbKgIv+6ROXszWlaFxf78Gp9rGYA0x1AD2wskuifCweT333dmWVWrTrNPxBhzryQCFaArD4Hx4n1UdPj6T1m68khKIM9hUhpRCdkHU8Eb//H4HnyWWJKzay5rOOd6JtexBJgph6inru9+Tqbjv+WcO/AwUjU07ozms2QSld/d4bSuCUNzSueJJZrlG9mskKqaHjRcbObFSO/c7ZMGESIlThnSAPOOWkn6WxA42TgGvijrrMRejv2ybLDE4fMmFEBWzwK3fVStKGNIdFwTUs4nNChWm594dqRd2Qtd8MSn8xheKxznyLnpSWSDE69mY+0vQSCqaUYAWgn8S667DkHV+gwz90QAWqhWOAQeuEjccWT171sCsmTjygMZCrjTxT1aK9djFHoJFfkFFjWI0cS1rpoUkG4xq7gyO75rtARheuzX/0oTPfk3nPNnNE0HofdlA3mzAVK7EH+sRsMewtF/8fkKV13pQZaWIuFFYR/kNa9npP4/+zpQMMu8CSXyiPlXc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(3023799007)(11063799006)(56012099006)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3BoRGNlNWtBQUNTYmlHUW1FMWlERFlaRGxvSzJrOVlIOTQ5RVNxNkFRbklF?=
 =?utf-8?B?SFc1YVVTbVRnTlcxRm1WQ2JTbE83SndjS3lpUHdUK3k2T2dsdGtMejFPbHk3?=
 =?utf-8?B?Q0Z4VUtoN0ZIL0tqREQreWRXdzlMSDZSaWRXUDJQS2VUU2lpWkp3cXdiampy?=
 =?utf-8?B?NmUwOHNUcHRIZGlydlljLzA2MkdGUERxZ2ozMEZpVE9mU3YvM0s0ZTc3NnBp?=
 =?utf-8?B?TFBYN09rL0dBM3BuMy9pRkR1OWRIZGxJRXl3dGxLRHZoVzZSeXdubDdIZnZq?=
 =?utf-8?B?MFFpQkhxbjFCS0E1d3dEVmxwUnZZa3hGSDRnUUxlemJMcUg5Z25MTm0zd01p?=
 =?utf-8?B?a3pSN3QvanVSVXBTVGtZRGNKbVZtUmppTnJuZDdZbkFRZGk4VWJFSjBUYVhU?=
 =?utf-8?B?TXNTaE93d0NvdEc5LzN2YnVpU1crMVhwdnRhbXRaaUlRS2lhOGRTQkFRVFdy?=
 =?utf-8?B?YWoxNGZ5NHBUKzZMc2dmNTladklDVHZnZUlkbnNWa01peU1HNUpXOE9hckU4?=
 =?utf-8?B?ZnRmN21UNUxOZGpKbW5Rbm5XbERqejJQRlN1VFFMeGF0WHRSOFp3Qlo0bFJD?=
 =?utf-8?B?ZC9rd3BwSUw3WERaZkVFWkdCMStEcFg2MzkvRGp5YjlDTURJSy9BTmQ2bXNS?=
 =?utf-8?B?Ni9ZNmNKVktCQmwrV0trOUZXK3hHdit1S3poaWNac3BFYTZub0xHOGNDRkdM?=
 =?utf-8?B?dDh1MVhoU2dXT3dBRUNqOExPTG10TUEvOEFuQzAyQWxOK0t4VFRuSFpvekx3?=
 =?utf-8?B?T1hWcElEOGNLRUtuNlRqVDg2SE8wd3hoU1k3cWNnVGtmTmRzeUNkK0VvV1JZ?=
 =?utf-8?B?OFdLNWx5T2padGZYdjRUeDFabnB2akpyc0puTERYQXZpY2h6S0ZFalZHWW44?=
 =?utf-8?B?QjhjVlM3R3FiUmpzRXA2eitSK1RMcUNlYVRiYklyWE1JblFyWHdYU1FlSlYz?=
 =?utf-8?B?NUN0UTdJd0w4bFB4cGs5eHJROXFmdUF4eHVGa21HUWw1YTJ2TXh5ck5kN1Mz?=
 =?utf-8?B?Y2R0elRnMlVvd2h3dTJ1OTdpVU9aN0lHeml1OGVHY1ZPVjZmYURpZVRGVXcz?=
 =?utf-8?B?d2t5SUxyU1oxWlo5dXh6ekUwM202TlN4MmE4SUFPM2dIeVQzOGhHNVBQK3dq?=
 =?utf-8?B?eVlJY1BJZDFPa2hWa0E4WnZxeUptb0ZrcmNtNi8rckdrMHRvQmEzYWsveUVR?=
 =?utf-8?B?di9vU0QyTWhaNDlBVll1dWVnRTR3QzBGTHY4ejZTVGN3Q2lOUnRIUzJZTGlL?=
 =?utf-8?B?THEydy8yTWZaZWtiM2RzdVRKbWdkcHRodDFRajVlY3RsMm1scnZxWllrRDB6?=
 =?utf-8?B?TFNhTnp0OGZJNFpNVXlWaXFxeWUrVkNEU0hWUGN0cjZWR2RsSGh3Snl5S3VJ?=
 =?utf-8?B?cWdNVmpuU1k3Q2V4U0lObTRpWUkxaFJwd1BCQ2tjTTg2UnQ0M0JjUGZWaWN1?=
 =?utf-8?B?aCtvWTF0NTFvUmdhbVFzamw0ZGJPQXhtazFqaXE5UXp1T2dhRndLeHlqaVVz?=
 =?utf-8?B?eDlIZStTYmgwcHJQMXIzVFRkN1daZzJKU1kzdlJEaU5LNG1ZeGE4U0d4ZU1Q?=
 =?utf-8?B?K0VaQU1oa2RzNDY0MnlWZUppZHJCOFZ0bzdubGdEaU4vYTRBaEs1MnBnNjla?=
 =?utf-8?B?YjNjSS9EN2lXNXZ5OXUrREp2SitzRmtyKzRQUUpqZHlnSkpJUWZFZkY0di9H?=
 =?utf-8?B?dkpGNmVHdkF2RzM1RmVoUHRyOHkvOUhEeHU0MkxYV3RETXZ5WlNwTWN5ZVNX?=
 =?utf-8?B?cDJyRHBxYzhJTmRIQmVrWkpvN0t4TDJNSXF4c3ZyLzN2MENuVm5hVEtXN2RE?=
 =?utf-8?B?MWYxeG03UFFXMTh1amh3RXh5L2MveVh5VVlBeTR3Z3hibmdVSmM5WmJRTWY3?=
 =?utf-8?B?WldLWVFpb3JiQ0E3VGJOUTk0bkJvUlkzdUtZZXhHdkQwRU1pZjZUVWF4TWpa?=
 =?utf-8?B?aElCbjJDT0lYcE1NS3ppNHE5UXFsVGszRHRxdDR6NmFyYkxPZE1nZHJwSlo5?=
 =?utf-8?B?Zll6cGhWREZFb0V6MVFMd29yZ3FUVmQ5dUJSMGkrbVlpOUJEQ1cvTC9XS1BW?=
 =?utf-8?B?RDZzb3NjN29BaTN3UVJlRWtSWHdUWG83S1I1U24xT3h3RnJ1U2Urek9Xbi9C?=
 =?utf-8?B?dk1tdEhYSGFaeGFLbGlqQmluZjNHeVFOVnU2ZnFrakx4aTdGellMSjVML2lH?=
 =?utf-8?B?WkVmVkJjTW5zOXBvcS9NaTNIaEpJUG1jM1pQeXFNMWFMNGQzYXpSWlUwZWg5?=
 =?utf-8?B?aElZbEhOOEtud1IwdVZjdXY0QkZMNUxxZ1BHNXRYcnhKR015S1BpalpmMk1K?=
 =?utf-8?B?Wlp6NzdJYXhWcmEyWU94NzErUm9VZlRySVFkcGZ3QzY4eXhmQ0Jjdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 862d33d3-0214-4791-613e-08decd8043f4
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 21:26:31.3839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rA666u+kkLxnqsA4Ju5nWR7zYvQoFmedysRYuPMx0VUI05WHEl4Knwi+Rkd0TuEx5ziwukCQvG1gteEO/NQi+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5645

On 6/18/2026 12:07 PM, Dave Jiang wrote:
> Add parsing of the RCEC Downstream Port Association Structure (RDPAS),
> which is a structure defined in the CXL spec r4.0 9.18.1.5. This
> structure allows error handler to locate the downstream port(s)
> that report errors to a given Root Complex Event Collector (RCEC).
> The structure is part of CXL Early Discovery Table (CEDT) and can
> be parsed like other CEDT tables.
> 

Maybe mention this is used only in RCH mode.

> A base address is provided in the RDPAS structure where depending on
> the protocol field, it is the RCRB base associated with the downstream
> port for CXL.io or the Component Base Register base associated with the
> downstream port for CXL.cachemem.
> 
> Per the spec, "For every RCEC, zero or more entries of this type are
> permitted", so a single (segment, BDF) maps to multiple downstream
> ports. Each RDPAS structure is stored as a per-port list node hung off
> a per-RCEC container in an xarray indexed by the combination of the
> RCEC segment plus the BDF in a 32bit field. Both the base address and
> protocol type are recorded for every entry so the error handler can
> walk all ports associated with an RCEC and dispatch per protocol.
> It's stated here but I missed that a RCEC list must still be walked. May
want to compare to the existing method using RCiEP.

> The parsed table is meant to live the entire life of the kernel, so the
> xarray is not cleaned up when cxl_acpi unloads.
> 
> A helper is also added to retrieve the per-RCEC container based on the
> segment and BDF of the RCEC.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> RFC v2:
> - verify table length (sashiko)
> - store multiple downstream ports per RCEC in a list (sashiko)
> - Add a gate to initialize the xarray only once per boot.
> - Add support for multiple DSP per RCEC. (sashiko)
> ---
>  drivers/cxl/acpi.c             |   5 ++
>  drivers/pci/pcie/aer_cxl_rch.c | 121 +++++++++++++++++++++++++++++++++
>  include/cxl/ras.h              |  18 +++++
>  3 files changed, 144 insertions(+)
>  create mode 100644 include/cxl/ras.h
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 127537628817..e09706275d85 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -7,6 +7,7 @@
>  #include <linux/acpi.h>
>  #include <linux/pci.h>
>  #include <linux/node.h>
> +#include <cxl/ras.h>
>  #include <asm/div64.h>
>  #include "cxlpci.h"
>  #include "cxl.h"
> @@ -933,6 +934,10 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>  	if (rc < 0)
>  		return -ENXIO;
>  
> +	rc = cxl_rdpas_init(host);
> +	if (rc < 0)
> +		dev_dbg(host, "No RDPAS entries found or failed to parse\n");
> +
>  	rc = add_cxl_resources(cxl_res);
>  	if (rc)
>  		return rc;
> diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
> index 83142eac0cab..eaab7698217e 100644
> --- a/drivers/pci/pcie/aer_cxl_rch.c
> +++ b/drivers/pci/pcie/aer_cxl_rch.c
> @@ -4,9 +4,130 @@
>  #include <linux/pci.h>
>  #include <linux/aer.h>
>  #include <linux/bitfield.h>
> +#include <linux/acpi.h>
> +#include <linux/list.h>
> +#include <cxl/ras.h>
>  #include "../pci.h"
>  #include "portdrv.h"
>  
> +/*
> + * CXL r4.0 9.18.1.5: "For every RCEC, zero or more entries of this type are
> + * permitted." A single (segment, bdf) therefore maps to multiple downstream
> + * ports, each with its own base address and protocol. The xarray value is a
> + * per-RCEC container holding the list of associated downstream ports.
> + */
> +struct cxl_rdpas_rcec {
> +	struct list_head ports;
> +};
> +
> +/* One per RDPAS structure, i.e. per associated downstream port */
> +struct cxl_rdpas_entry {
> +	struct list_head list;
> +	u64 address;
> +	u8 protocol;
> +};
> +
> +static DEFINE_XARRAY(cxl_rdpas);
> +static bool rdpas_parsed;
> +
> +/* CXL r4.0 9.18.1.5 Table 9-24. The segment and the BDF belongs to the RCEC */
> +static unsigned long __rdpas_index(u16 segment, u16 bdf)
> +{
> +	return FIELD_PREP(GENMASK(31, 16), segment) |
> +	       FIELD_PREP(GENMASK(15, 0), bdf);
> +}
> +
> +static unsigned long rdpas_index(u16 segment, u8 bus, u8 device, u8 function)
> +{
> +	return __rdpas_index(segment,
> +			     FIELD_PREP(GENMASK(15, 8), bus) |
> +			     FIELD_PREP(GENMASK(7, 3), device) |
> +			     FIELD_PREP(GENMASK(2, 0), function));
> +}
> +
> +static int __cxl_parse_rdpas(struct acpi_cedt_rdpas *rdpas, struct device *dev)
> +{
> +	struct cxl_rdpas_rcec *rdpas_rcec;
> +	struct cxl_rdpas_entry *entry;
> +	unsigned long index;
> +	int rc;
> +
> +	if (rdpas->header.length < sizeof(struct acpi_cedt_rdpas))
> +		return -EINVAL;
> +
> +	index = __rdpas_index(rdpas->segment, rdpas->bdf);
> +
> +	rdpas_rcec = xa_load(&cxl_rdpas, index);
> +	if (!rdpas_rcec) {
> +		rdpas_rcec = kzalloc(sizeof(*rdpas_rcec), GFP_KERNEL);
> +		if (!rdpas_rcec)
> +			return -ENOMEM;
> +
> +		INIT_LIST_HEAD(&rdpas_rcec->ports);
> +		rc = xa_insert(&cxl_rdpas, index, rdpas_rcec, GFP_KERNEL);
> +		if (rc) {
> +			kfree(rdpas_rcec);
> +			return rc;
> +		}
> +	}
> +
> +	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> +	if (!entry)
> +		return -ENOMEM;
> +
> +	entry->address = rdpas->address;
> +	entry->protocol = rdpas->protocol;
> +	list_add_tail(&entry->list, &rdpas_rcec->ports);
> +
> +	dev_dbg(dev,
> +		"RDPAS entry: PCI %04x:%02lx:%02lx.%ld %s CXL addr %016llx\n",
> +		rdpas->segment, FIELD_GET(GENMASK(15, 8), rdpas->bdf),
> +		FIELD_GET(GENMASK(7, 3), rdpas->bdf),
> +		FIELD_GET(GENMASK(2, 0), rdpas->bdf),
> +		rdpas->protocol == ACPI_CEDT_RDPAS_PROTOCOL_IO ?
> +				   "CXL.io" : "CXL.cachemem",
> +		rdpas->address);
> +

This logging will be helpful.

> +	return 0;
> +}
> +
> +static int cxl_parse_rdpas(union acpi_subtable_headers *header, void *arg,
> +			   const unsigned long end)
> +{
> +	struct acpi_cedt_rdpas *rdpas = (struct acpi_cedt_rdpas *)header;
> +	struct device *dev = arg;
> +
> +	return __cxl_parse_rdpas(rdpas, dev);
> +}
> +
> +/*
> + * The CEDT is a single static system-wide firmware table, so RDPAS is parsed
> + * exactly once for the lifetime of the kernel. cxl_acpi may probe more than
> + * once (re-bind or multiple ACPI0017), but the global xarray is populated only
> + * on the first call; subsequent calls are no-ops. There is no teardown: the
> + * data describes the platform and remains valid until the kernel exits.
> + */

You may want to change the ACPI0017 reference. There is only one ACPI0017 per system.


> +int cxl_rdpas_init(struct device *host)
> +{
> +	if (rdpas_parsed)
> +		return 0;
> +
> +	rdpas_parsed = true;
> +
> +	return acpi_table_parse_cedt(ACPI_CEDT_TYPE_RDPAS, cxl_parse_rdpas, host);> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_rdpas_init, "cxl_acpi");
> +
> +static struct cxl_rdpas_rcec __maybe_unused *cxl_get_rdpas_by_rcec(struct pci_dev *rcec)
> +{
> +	unsigned long index;
> +
> +	index = rdpas_index(pci_domain_nr(rcec->bus), rcec->bus->number,
> +			    PCI_SLOT(rcec->devfn), PCI_FUNC(rcec->devfn));
> +
> +	return xa_load(&cxl_rdpas, index);
> +}
> +
>  static bool is_cxl_mem_dev(struct pci_dev *dev)
>  {
>  	/*
> diff --git a/include/cxl/ras.h b/include/cxl/ras.h
> new file mode 100644
> index 000000000000..661307b0230a
> --- /dev/null
> +++ b/include/cxl/ras.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2026 Intel Corporation. */
> +
> +#ifndef __CXL_RAS_H__
> +#define __CXL_RAS_H__
> +
> +#include <linux/acpi.h>
> +
> +#ifdef CONFIG_CXL_RAS
> +int cxl_rdpas_init(struct device *host);
> +#else
> +static inline int cxl_rdpas_init(struct device *host)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
> +
> +#endif

The /include/cxl/ras.h addition will be helpful. I'll use this for 
the CXL-AER definitions, instead of /include/linux/aer.h.

LGTM

-Terry
