Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012019.outbound.protection.outlook.com [40.107.209.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7123191CF
	for <linux-pci@vger.kernel.org>; Thu,  2 Apr 2026 11:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775128149; cv=fail; b=IfO1oQujTw7HRDrtUAAe39gHBCd9NVvp5fdGF8DAyyh0S+YTEunrLjamF0fRQjG7D5bYov0RbHvX2z9uMCitvEfrY5PdZwSSPml3kkfCfdlec5gIGm/A5V4pdiK5AfmZbj4WUfHl1Y/VZiXLgo7sbN2qtp33Wb8MxDkYT0Pdfhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775128149; c=relaxed/simple;
	bh=CGvgwPiuAGe54Kij1hM7AMvUOHIGSuPHXcahDDaoUsU=;
	h=Message-ID:Date:From:To:Subject:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C4eZSAFyoqqrzSAdLTySa8GkbDIEJIViXDZA0igQ1jHiiMw3WwaCFY9kU4NZsz57vUeQaRc8HqG+xjLFtvtRr5plpO6SCtjQmCAfspTSvbKg7COehe6cZNff6pSKGHgsYeZ6ag0u3xMLzTQ1XFA1Qj5h1HiFA92TmsSPESONWLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1S1FdX5T; arc=fail smtp.client-ip=40.107.209.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1S1FdX5T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6/Vb2GQ0C3T18xzu7vVuumFvqRrJB+3KE74rId+EtoSasz7i9aW54pvaz4Mt3AgcejsV/ilQe7VM4ZC0AZ5z7/urQT8qkKMoQmgw83PBI6NHDXx8KbCsoqcam676WDAjFW7xhww7Vf7fQYUNsb12CJKuYLZtPKOObfeh41ltOcZ6lVYy3xiKwlG3BM+8zWAtWVkQlYjRiPEx2BJlDPjZcjOwhQT5/p1XZa2o6A1gsb+/xHSyOiyol+O8Uvecr4ycoFWko8YxAL5hLOn4alVSaTzHpp1i763ddropwp3ikdJDB/fOMxWeQ3EFwIGhvpt9EHTOKFruXIK8OSLLcGxYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGJ/1Dt4Sh4TtfxxXF8D02Ba8revepSYHvDvRRplFiU=;
 b=SGaxcFAKJLR8I5z2Fwc/oacTm/jbfXp/L3RSnQ47rcdnT/A3QcExMF9HXodVFP0UfOuVbKcsS+FKpVHz6h24/3onLbcRYEWLDEaho/XJOAGkLWukMhFQuzOQ670sj/wpVQTl28t7usQi1eADYhkwIsraDQLb2mkw1v1psCY96RXJ+DYRacBykll2hS3mPKMHobU/SnBMKKlbkgZqKx6Cf+c2Kp/00a+5f7ibTSD+cRYdPn0o3LYKA3GT74mP8tznJagvXdjTW3bQKaJsENF8BgFsnd79Tlj5ZaQr4QXfJRVj4uFA2B6asaBlRq9CJ0tsbv3rWl1VwiASQHw7iyLjog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGJ/1Dt4Sh4TtfxxXF8D02Ba8revepSYHvDvRRplFiU=;
 b=1S1FdX5TrFllNFojvXZ7ttg+FYVmK9fKzwzok5M3EUzoJMR7Dbj+2/VGZi4EXpkz7VVqfuf9gZuiVgs0fGUW0h2ArGWkMQ4Ubn2XB3Ssbckl2TKDueBf5QNmdGzLXeHvTbJQv9qkug/u+1nqIZkZbz8N1TksZQaeA53j6D8r2pE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8292.namprd12.prod.outlook.com (2603:10b6:8:e2::21) by
 CH3PR12MB8329.namprd12.prod.outlook.com (2603:10b6:610:12e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Thu, 2 Apr
 2026 11:09:06 +0000
Received: from DS7PR12MB8292.namprd12.prod.outlook.com
 ([fe80::7b29:2260:340f:35cc]) by DS7PR12MB8292.namprd12.prod.outlook.com
 ([fe80::7b29:2260:340f:35cc%4]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 11:09:06 +0000
Message-ID: <3c74a644-3f01-4586-ac0b-4ba36bca12d8@amd.com>
Date: Thu, 2 Apr 2026 19:08:44 +0800
User-Agent: Mozilla Thunderbird
From: lingshan.zhu@amd.com
To: Zhu Lingshan <lingshan.zhu@amd.com>, bhelgaas@google.com,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Skip devices with RRS Vendor ID(0x0001) on root bus
References: <20260327073659.6160-1-lingshan.zhu@amd.com>
In-Reply-To: <20260327073659.6160-1-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:820:c::23) To CY8PR12MB8299.namprd12.prod.outlook.com
 (2603:10b6:930:6c::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8292:EE_|CH3PR12MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: 4123d526-cdb6-4537-7763-08de90a8391e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	4i2WHqW/3T8Ghjb9+dJ9AuLAJupyQkZK+o8rM0dT9RLZaWzX/glcWIuLm5EsnrtiufmrGgYjWAFxHGxcQWhzwP2NrAXKV/SNGCZt06oeO86R8MlaATDOF8uaei5DpWjVvoXwOxmEyhEAwnnSlkGW1ONsl6xVhd31KUrAgj7C7WLrJA2AN6cjd7sLnVkThOIgFPjnsfOiW4yIRs23nnW4yLiEyke6HR20FK0lb5+x7Dpvns2JL5kAUm6G1gxH/3+/XnKdceILX6xqHr/OfkGYUYwCr8Pdwb6H8NaimBL3PWHT2Dwr/E4GnU4+8/zeBdznNSCxhp8xh8aFNv2RDc2VUOnhQYl1aybd6oNAxHbRFOlOofDuHtG5911/tzE7s6Bl7duELI1HpO8npg/rdkL6WcepaL15N+gT42UhqP7g68L2zKUMP0arhYGTwSLsDUmATZ5StJQ4i8xuSfAQUBgWikrn6tNTqg23ZfrxTrRy3gL2As+vDlc3G7EwVuncmY99dVBDL1Go8ceh6JqhAsAKHyKIXe28QY0Jn+Ur61sqDP/vI3RcgVM6Zt/P5fRkIrpn8g3n+Vx0jQpLkg1lr8TuC9gsEj45pIfUG8L2GRmZAGHZ+rCmLCt1AwaHj+Xz9d8QpmmUV44h6S1byRezNAYwTcA6RqzQVBJlugo9DldrqzCrKWg7XZJgkTYZfeu5KdfATeBysUV8LJsun8USDq3uHseQvQZ/YqI/kiX6+1lfmQo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8292.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHdobi9pS2ZETzNCNTJ1dlpxV3BFUVJZMGNzak1hbFVJaHlDbFROQjR5M1d2?=
 =?utf-8?B?Sm9Jb1pVcGh2eCtTRmQ3V3hsbVdqSFRFVG56MHBray9vWDBVZ1hqYnFwNnJm?=
 =?utf-8?B?UVp1S3dDQzBQTVBjang0VUczNk55d0k5akNaUndtd0VRRjVEU2orRjRSUzdP?=
 =?utf-8?B?a0FweTZRV2N6S3cyUDVCTUxUMU96VVdVZFY2eGxOdmVMbHZSSnYwODA3b05D?=
 =?utf-8?B?UE1VbUVBNTFacWloWUlkT2I4NE12OTdabVVzUk0ySzAxMW5KUDY2cGhESWkx?=
 =?utf-8?B?TGdubmhrWnJHbzNSZmh5S2xrUXV5R0ZVRmg2dFRJMGJORVV0NWlnMTJuMDZL?=
 =?utf-8?B?Y1ZHdjlEYmY0bVV3NVN3aVdMWVF5bkR0dExIQS81akRDL01pV3IrVVVwbGFS?=
 =?utf-8?B?YjF5WWRncTRkQkluejdTWkxvaWtUaENjd05ZcTl2Y0V0aHhKZTY1VGcvYUtS?=
 =?utf-8?B?WFdGeGNVRGlyd1hVd3FUVVUyaU43cURaeVVSQ3U2dGVvSDJLTit2KzJFNjNH?=
 =?utf-8?B?NDRxQU1UOG9uWVJ4Z2kzVE0zV1B6TUVscjFIRit6TWpFbjJJdDVjQmV1N1Fm?=
 =?utf-8?B?RXJEdWM0R216Sll6VVhPMDlmZ1FkTGE4dlhlWVplS0VBZXRIdlVDaDh1TWJk?=
 =?utf-8?B?TXpJMXByaSs3Z2FjNFdUMElLc1pZVzl6WFZNNFN5dHEwMTF4ZFJNZFBIcGRX?=
 =?utf-8?B?WXJCNnJQNHcwY1Q0YmtaQnVXWHRDOFdRT3dBZGc1QTk5U1QvQlBDQnJGaUFw?=
 =?utf-8?B?bzYxMEhhcHlVUVgxSDIxMkZIVnFheENUenIxRmpkTnRFUEJIRHlFdGpJQmRh?=
 =?utf-8?B?dXlRT0FCbGp4V1hZTzBsT0JMam1RMkVNUWtqMmdVYm9iNW51WEZMSmQyNmVz?=
 =?utf-8?B?Y1RsK0lHUnJLbGErSkVpT2NkYVl1UDlDZUVrT1lMN3duSUUxWnkrSjhNUmlP?=
 =?utf-8?B?NENkMk8zSU5SNS81dGhiZlpYK24zRUVOYklhNDNNcG1SYVVaRERqNlhWdmFm?=
 =?utf-8?B?d2VxbnZTcFFSWDJCcmdoSnMwSWJiWkd0ZnFlM09JQWg0WGlEamFQSDFHbnJT?=
 =?utf-8?B?elBDeVRYUEUwNUJTdjJWYm5TNzVwMjZySGJVcHBBaTc4V3BQWmg2eW5KRFNl?=
 =?utf-8?B?L0drR0pnNUQ0R1hpM29ycnIxVVJweFZPa1ZmSG0vWnhCNThJRGt1WVJrTkJm?=
 =?utf-8?B?a01RMTlrbkRRbTdPM3ZmNjI1TWN4ZU1NOFVhblNsL1liakNKTWRTdXZZcVgy?=
 =?utf-8?B?b2xCb0NqNFJQbmR2ODZlVFlqL2YyZVJvSXc4SXlaSDFTZXF5VW1Ld0p5b09B?=
 =?utf-8?B?Q1gxQ0pZbEcwMzlKZ1pydHhUQUJNU1RvUXgwRG1ZOXdMUTM4WHFwaytVYnE3?=
 =?utf-8?B?UGVvK2VBK1lXSjFCYnJmakdQcHBtMWJnR0ZPY3JHbjhpYlZuWkEySDBLRzRu?=
 =?utf-8?B?Rkdkd1IxMGE3T0ZHeXhNR0dBY1UyS3VrY2xVbEZYeWtMNExtL0R4Wm1zSHhh?=
 =?utf-8?B?UGo3dGFnUWpFLzByMW9RVVgzTmh1Tll4d1JCRVN2U2hpUDFGRko5cGlLSGdW?=
 =?utf-8?B?SndPSHhObHQ1U2NGSnk5dlBvL1E5V0pqWlZpTjFvMkZxaFhaRGJEK1hJcUVp?=
 =?utf-8?B?TVQrankwcDJhRTJZZ1VNdjlWU21pWTAwZ05vQ2NGY21Gc1lhck8rY2FFMTd2?=
 =?utf-8?B?MHhyR3pIeWpMUDZDVStQWTREV2wrTFFZVUhqcEl1K0JnWHpGR3FVejNyR1hR?=
 =?utf-8?B?U1Z3VFpFREdaZXRPeXg0b1hpN2V0ZndUampTcTZvNWF4NWxlOGM3TEVheEVY?=
 =?utf-8?B?amRGUmhCbDd3N2VPSmM1Q2kzQmtvS3ZldnY5cVVDVHZabzBOSVdVTXdsNVc3?=
 =?utf-8?B?UkJWd0xvSVBQYmZDUXBBMFpHaWpuYTc5UTFjOHE5N2FyRzFITllCVjhYVTdK?=
 =?utf-8?B?UExWQkxOM1RQMkwxUFhhemtNbEpoRy9UTExNK0FmOW01ZnNoR2s2SHNlT3lW?=
 =?utf-8?B?SFdMRkEyL1JWTERBSHZEM3FVa1kydis0YzVVQTJjZnQ5Y3hBaW1IYmJoTkdh?=
 =?utf-8?B?ZnRYVXRFMkU3eWorY0NVMmswSVIyZU90UkV6T2w2VXduSzAyYXdzc3dmNEVB?=
 =?utf-8?B?V2xhS1NJQmhyMndiOEhIZVNsSTd6YVRNNnVaOUN6cjFFTkNBUjZjZ09BTzFF?=
 =?utf-8?B?VndvZFJ4ZjhWTENpVHM0bW9oU2FrNTNBQnptL2ZLdE5nRWw4dGVSa2ZTdTRj?=
 =?utf-8?B?OHZWNklLMkh1NXdIOGpaellBMXc4cTFpL0xubnFkdk51b1lvdHZmcGxUMklT?=
 =?utf-8?Q?lFTdnzQvUleiswYVAV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4123d526-cdb6-4537-7763-08de90a8391e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8299.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 11:09:05.9137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8x5OGDPkb+FNS3wcL+Z+oIyi9mnNn95BM2GC5rVkrGg2C7IvtsedZOXCLz9DjhcPcKVEKtJkrhdcn98wrGLI6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8329

Gentle Ping

Thanks
Zhu Lingshan

On 3/27/26 3:36 PM, Zhu Lingshan <lingshan.zhu@amd.com> wrote:
> PCIe Request Retry Status (RRS) is a link-layer mechanism where a
> downstream device responds with RRS to indicate it is not ready.
> 
> With RRS Software Visibility enabled, the Root Port translates
> RRS into Vendor ID 0x0001 (reserved by PCI SIG) for the driver.
> 
> Devices on the root bus, for example the root port itself,
> have no upstream PCIe link and can never legitimately return RRS.
> 
> This patch skips any devices with RRS Vendor ID 0x0001
> on the root bus instead of entering the RRS retry loop.
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>  drivers/pci/probe.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index bccc7a4bdd79..2fad89ca594c 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2578,8 +2578,27 @@ bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
>  	    *l == 0x0000ffff || *l == 0xffff0000)
>  		return false;
>  
> -	if (pci_bus_rrs_vendor_id(*l))
> +	if (pci_bus_rrs_vendor_id(*l)) {
> +		/*
> +		 * RRS (Request Retry Status) is a PCIe link-layer mechanism
> +		 * where a downstream device sends a RRS completion status, and the
> +		 * Root Port (with RRS Software Visibility enabled) translates
> +		 * it to Vendor ID 0x0001 for the driver, indicating the
> +		 * device is not ready.
> +		 *
> +		 * Therefore, RRS is a root port feature, and devices on the root bus,
> +		 * for example the root port itself have no upstream PCIe link,
> +		 * so they can never legitimately return RRS.
> +		 */
> +		if (pci_is_root_bus(bus)) {
> +			pr_err("pci %04x:%02x:%02x.%d: invalid Vendor ID %04x (RRS, reserved by PCI SIG) on root bus, buggy device\n",
> +				pci_domain_nr(bus), bus->number,
> +				PCI_SLOT(devfn), PCI_FUNC(devfn),
> +				*l & 0xffff);
> +			return false;
> +		}
>  		return pci_bus_wait_rrs(bus, devfn, l, timeout);
> +	}
>  
>  	return true;
>  }
> 
