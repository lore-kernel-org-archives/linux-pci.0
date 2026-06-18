Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011060.outbound.protection.outlook.com [40.93.194.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA51348C6A;
	Thu, 18 Jun 2026 21:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781818021; cv=fail; b=AdJ550iIt8D5IoAHFlC6BFjsEhlU9+cCa2/LA2v9nEsd3An/t3vCItdEpGg7kYB3ZRmTv8ki2awy1yt8Q7QqF+X/QItpyfyEu5EV5j9AvlmtSs9ymOKt+xp45Ke51JzKOruW2R7Tod0oM0NI8UiVOGUpqW3MNtWBhICy1pL4wDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781818021; c=relaxed/simple;
	bh=/wSLFzIQQKQJZsyxY8gy7GDt5cpwaW3bpdshyaiYJyA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nz1F2DgIn3z2/IzshGuL0cze7uGnJHeI1oBk4EsqqLqGkequj0X+iWESiMsIGLE8Ns8YTbaTDtzfJVKzWkvC1YtkSN0UwraQWlSbUzEyrjQSFazR6iMH8cugBU0W/Aqf6YedJ68vOxQIl3r/VrQxCcMrBYOC3UkeP+f93bKJYSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jeihHvmE; arc=fail smtp.client-ip=40.93.194.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jeihHvmE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/LqcIJKpIssoBTRki1HZB9joIgUH71CTR+tRuEpUbnNb66213r4lcXjfaPpdBsW1MRazwpopIr3wLNC34aqGeizNiOZyhBUNLp41aq2E2Xbk+3Rp6HZBpry/8PyBsEeM+qXqqHC0YPHJJ3zp7pDa3ljHRw9gTYBkzSvtEt9Ts+sBCOXq9Xuo9TNJ9SXyAH5G1hf8aHKeuwiLtpKpjfhDJg0xl3iJs8Ng70U8YoEdpnwFdfW9lYcI1psZiGHjyp9GRmDJdUgQgGYIiBWjQsn5sjaDeYquLpEe3cpR32ezVh0AjM5YJibCAvAx1/SI7sZr8tbqhQrQsL3hwQCoxZNRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzVi4eP/Ybz38+N3G9RM0s+S6hCrLhHshZfW5/X6c3I=;
 b=na43bU6ZqHyZdERDEkT6hKNrm8R7mFjm6XKymeakaa8bJyGfbsj9n6LPB01UuPnfV20DMHmhZLAxsDthoUZD3jQ90RH+bPySw1hi1eA/b4JI4C0EIpvybdCB5BIjAfmTIBbrfm5OnF0xaC7lCL4NTxXzKNh6sP35AeDdSxvklJL2UU31PzjgD9EwojRwa7ai8tBOHJNsz+XdxPzO2P7Zd0TweBy+g8ylsDBQ0KkFrrjQ4o9/9nFsynn+OaLZBVcb7TM4QhLyWdP7SI0rGvzF8CtJp8RhejUN11l1rbY3KxJcBHmgQkFMSgCc69HUyBnRQEwAj6bf1z25g9p914yq8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzVi4eP/Ybz38+N3G9RM0s+S6hCrLhHshZfW5/X6c3I=;
 b=jeihHvmEMtouOcVYOAeaxU26LBO5I3u4EQRiEg2oVMnUN13V8s9K0KiLmuWPg4VzyUFsGZ2619NNc2XYqZ3nRUnykxA3JofUEPPPLOcMx4kffXRM6ZD/S5PipaCzUqcvEe5td6NIeogxzJT1Y7J11I9HaIKu23n26Zul1c2r7bs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by PH0PR12MB5645.namprd12.prod.outlook.com (2603:10b6:510:140::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 21:26:53 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%3]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 21:26:53 +0000
Message-ID: <e8ca6204-46a4-4c9f-a4d6-efb1d4f87c3c@amd.com>
Date: Thu, 18 Jun 2026 16:26:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/2] PCI/CXL: Enable usage of RDPAS to shortcut
 error device discovery
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, jic23@kernel.org, djbw@kernel.org
References: <20260618170723.2010490-1-dave.jiang@intel.com>
 <20260618170723.2010490-3-dave.jiang@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20260618170723.2010490-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0040.namprd04.prod.outlook.com
 (2603:10b6:610:77::15) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|PH0PR12MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: c5d6a38e-7536-434e-db67-08decd805156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|22082099003|3023799007|11063799006|56012099006|18002099003|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	WkyXyKi01kVBvo4+MBbdUQ/8SmMaR3EYVKc+rRnUK1hPhDl8V4dzfD+8L7bmhzBMSbR1Ses8uJeAqym1rm7kA9PnENBC6+g/rwPz5YprDOfkUPS2WDdynt9J1uUJDCz0NERCTTooaJ4OFzmUFoxKmgXtp1e34u5S+I5cIJ6zdEGAVmCvTIFCiMUmu4O7mAOqME51cI0wMEWZ09W5yIIvkYB7KZS/T6+lEkoldSMBdEpX9W3yovtvHGi44DmiaxDEUH8Rv5ANQIGF62EjlGZMDkZzrkm8L27sYqjcwbwE1WcHunE8n/cMBDPgYIWLiumL9rR6HdhH47W2uW8wHztSjHEcoJFC1u4/GUu8WvcVUrDj9EhKNd2aiS7/Ik/0i8uMBM4xo1jDlZpGsVfYnIaxp/I2EmykfXQ/PqUlPz5y+I+15pJ3sbk3xouqm92e6ZyhBEmopsgdzRJi4uXEO+f/ZzHc6pTzWqStFNAGttrVteHIiXFHoxMyO5QgWtrpHMyITilMHNh5cN6jxja/Z+tl7INa6nuc4raRlOwBabw3la7rJqGvbr5Co8/+Rwdn/aXZ5TpbBJ2d0NfzfTx0tJsjPHTEmFKM3gXkklPmgK4AHDOy1pabhmi5QI2holRayudXZyc8tctjK5O+64mjjblpMNxvw5MCXa5tt73ThRtAGzQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(3023799007)(11063799006)(56012099006)(18002099003)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTRaSlVrQUFRellCQU10djNCdnpSc20rYnZlM3RSazhLaUdMelNnbVpwai91?=
 =?utf-8?B?cFJJOE5SV2JDUktNanBvdDdhWkp3OW9taDZ3MFRGMTFFOVZPYjM2cFJUQjFa?=
 =?utf-8?B?Y1VubzBrWEpmaUhja0c4ejZnZ3NoOXM2cytjbjh3WlpWZGlhN1dVLzRldkFw?=
 =?utf-8?B?TFhQYzlvZEtSTS9yZ256bnZadGVSd1JmbHFudE44Uys0Q2NOa3Zub1NiSzBT?=
 =?utf-8?B?MUFmYmNXVnBmck5ITkZZKzl2Wi9hNXkxZVhBZk1oOEJlSFZ2QjFLcms2c2tT?=
 =?utf-8?B?TVhON0kyOURFVVh3OWNTY0ZCblBXaGZ3MmlpbkZ2bGNDcWNsWWd0UHZpZkJM?=
 =?utf-8?B?SUVQcWNhYlRhVERGZ2NvYldWWXJFd2R6d3VZWlRVSkhrV29OSnMzR2hRSEx1?=
 =?utf-8?B?YnNXQWtZUFJQZ0xSVjdFZnRLTGdTZW1RUHA2N2RRbU1DNGxvak8yVmc4R0I5?=
 =?utf-8?B?TnpyaGJSR3FJY1NtV3hZUUtKRlFaaC81b1dIcXhOc081WWhhUFVqNGJacEFL?=
 =?utf-8?B?ZnhVeGNjbTFOeXFzYk1MT1JEdkxHWExud1VWSVphcFVhSlVMUVI4QS9pc0JZ?=
 =?utf-8?B?Rzc2SGNPRys0VVVPZVMzbWo1ajR5Q0VkZUtndmtLWVltMUdwWXRlL3BOa0ZG?=
 =?utf-8?B?M1c5NmtkTFJuQzd3ekF6bkIyK21uZlNQVjk2ekJwOHp3M0Yzck9vRVdsQVZ6?=
 =?utf-8?B?U3ZjNkFSbE4zQnAyTzFkSVZIRW1TL2p0aHlGMmNjR2FEa0V4M0JzWFlPckxH?=
 =?utf-8?B?cnMwYzBQM010bjk2bmRyZEZwQzFMSnVyL01BY1VUTWptTHhURHBoSEx4aWpQ?=
 =?utf-8?B?TlRHamk1RzE1R3JqQzU2MWI3N3dnUDl1YlowWGF3QTIwMUdiVEdxbEgxeXRJ?=
 =?utf-8?B?bThqazVQU3I4L1BqWVpVYzRXK2NSZ3lOSzVYREVqLzlRbVJacmZmV1JDUDA0?=
 =?utf-8?B?VXpNTmhYNW1TWnZyQmpEUUdKcTBxbXYwY294cHdtYkVWYjBhbkpLVzJ0ajkz?=
 =?utf-8?B?ZUM0QzJiZ1BPRzM2eWY2WC84MmJBM3U3ellvakRIcTBSTEJ0K1VManV6bkw5?=
 =?utf-8?B?STVmVGFBREdLVEdhdVRpejJQWlQrNUZGbE1kNmJ6T25jVFlST2x3RE5ISEVL?=
 =?utf-8?B?Qm5aWCt0b2pkR3BBUmNPV1FTS2xxWjBKTkRoUzd4Y0ZVcjN2bEhlTWxpMGk3?=
 =?utf-8?B?WGRyaGVvRXJJMDV2MG5NS280VEM5b0tvUHkvd0VDSkNqdFVZYXZucjY3R0VV?=
 =?utf-8?B?a0cvTFpESFZkTzZvVHBhK0w0MGdoWkdCeHJ5amtxSGl4NUZaK0xwcHFtSStk?=
 =?utf-8?B?b1ZkbUlxSkF6SHl3Q0Y3dE9uWldtQkxxaTJwRDNIMHBHM3llc1lVSVc0bHVa?=
 =?utf-8?B?OVhFUXc5cFUzZWxLWStVUzBwNlIyWmFQSEYvR3QrVjV1QzZpOTgyRzdHeGtw?=
 =?utf-8?B?a2F3WTZPWUxsTjhlYUUremZoZFJzTjY1dHg3T3puQ3hqYndPdmo3Z1d3bFFP?=
 =?utf-8?B?MDhFNGxMamhldWc1Rm10Z3FxZm0rMk9RUmFhR0ZLeDcrMEFpekRMY29nWXdw?=
 =?utf-8?B?K2xXYm44RWQyaFJFTTZPcFZ0MW81dTJNSEdZemJDdXpPTVR6Z0RrKzNuQmho?=
 =?utf-8?B?ZkNaeHZ1dVJqd2RmNnVFRGdSUWxLVTlMTm9qNFdEZVhna29OaStoM1lDZGNI?=
 =?utf-8?B?bXh3T1ZvRTRHSEhlc09RNXJXMHBveWo2Yk0xUWdBdFV3S0s5Wmhmb2NLVThD?=
 =?utf-8?B?VFpoWXBKakFGV3JZdzR0Qk9IS1NQdWluQ1NrOUlTaU5tQTVyaGZJa2VIdElM?=
 =?utf-8?B?TjB1THdad1gvWm5sS0s2eFB1YTNzY1kyVWlLUUZUbnNqWnpzSmV5TXpCVzdm?=
 =?utf-8?B?R09reDJzK3JMNi9IWWhGTDA4SytaL0dtdlNqU3c1bnBOWldpM21vdGdWMTRz?=
 =?utf-8?B?b2cvbkorbXQyMEttV21EWWVxZ2U0cnl3bStkYVNLUERUUVRzS0hzbU9HdHJC?=
 =?utf-8?B?bVJzb1NQeGwxWllVc0RncW9wQXhEclB2R2grZU85b1U5UWNuTHVrWDQybFBC?=
 =?utf-8?B?cXpCN3lmYjMrSWN6Q0pZcXcrUjV0Ti9ha0NSY3R1NWo3VDN4bW0zd3E3ZUlx?=
 =?utf-8?B?SjNFcjZRTGxyZEJIbVdOU0VXSjNkRWNRU09OTE4wWTFNQ0MxdVFjUmEvV2FH?=
 =?utf-8?B?M091WTdiTkpyQVBGa3BORnB6OXBwNHJtRis3ZmN2cUZFMHNYMTJVdlArYlRt?=
 =?utf-8?B?M01XT1E3WjAvUm9YbXhHbEFibEc1S2ttTXZ6elVNaldwZDY2aW5mbnA3VE9m?=
 =?utf-8?Q?CNs7ya0AvH5uAPZHRm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d6a38e-7536-434e-db67-08decd805156
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 21:26:53.8223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B0MshyiZISfYtEh0xKpL1savAdk048SM6Z37LjZy178uMP85BnlXyGEraB+Tb2JQFGxdTFfj2OJ5sXwxmlWmnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5645

On 6/18/2026 12:07 PM, Dave Jiang wrote:
> The RDPAS allows the CXL RCH error handler to find the device directly
> instead of iterating through a set number of RCiEP in order to discover
> which device triggered an error. For the CXL.io protocol, the base
> address provided from the cxl_rdpas xarray points to the RCRB of the
> device. The RCRB mirrors the configuration space of the device via MMIO.
> The error handler can walk the RCRB to find the AER capability block and
> therefore read the root status as well as the error source in order
> to determine the BDF of the error device.
> 
> The entries with cxl.cachemem protocol is ignored because the base address
> provided by the RDPAS structure points to the Component Base Register Base
> and does not provide a way for th ecode to identify the device that
> triggered the error.
> 

I see. The protocol explanation is here. And cachemem is ignored.

> Change the current RCH error handler behavior so it will probe the
> RCRB first to see if the error device can be discovered quickly
> before falling back to the current method of iterating through RCiEPs.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2:
> - Add boundary checks for MMIO reads (sashiko)
> - Add checks for surprise removal of devices (sashiko)
> - Use aer_info to also check severity. (Ming)
> - Update to iterate list of RPs under a RCEC entry.
> ---
>  drivers/pci/pcie/aer_cxl_rch.c | 152 ++++++++++++++++++++++++++++++++-
>  1 file changed, 148 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
> index eaab7698217e..f295e4eefbba 100644
> --- a/drivers/pci/pcie/aer_cxl_rch.c
> +++ b/drivers/pci/pcie/aer_cxl_rch.c
> @@ -118,7 +118,7 @@ int cxl_rdpas_init(struct device *host)
>  }
>  EXPORT_SYMBOL_FOR_MODULES(cxl_rdpas_init, "cxl_acpi");
>  
> -static struct cxl_rdpas_rcec __maybe_unused *cxl_get_rdpas_by_rcec(struct pci_dev *rcec)
> +static struct cxl_rdpas_rcec *cxl_get_rdpas_by_rcec(struct pci_dev *rcec)
>  {
>  	unsigned long index;
>  
> @@ -166,6 +166,143 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>  	return 0;
>  }
>  
> +static u16 rcrb_to_aer(void __iomem *rcrb)
> +{
> +	/*
> +	 * The extended capability space is SZ_4K and each capability header
> +	 * is dword aligned, so the chain can hold at most SZ_4K / 4 entries.
> +	 * Bound the walk by that count to avoid spinning on a malformed,
> +	 * looping capability list.
> +	 */
> +	int entries = SZ_4K / 4;
> +	u16 offset;
> +	u32 cap_hdr;
> +
> +	/* Start from PCIe extended capabilities at offset 0x100 */
> +	offset = PCI_CFG_SPACE_SIZE;
> +	cap_hdr = readl(rcrb + offset);
> +	if (cap_hdr == 0 || PCI_POSSIBLE_ERROR(cap_hdr))
> +		return 0;
> +
> +	while (PCI_EXT_CAP_ID(cap_hdr) != PCI_EXT_CAP_ID_ERR) {
> +		if (--entries <= 0)
> +			return 0;
> +
> +		offset = PCI_EXT_CAP_NEXT(cap_hdr);
> +		if (!offset)
> +			return 0;
> +
> +		if (offset >= SZ_4K)
> +			return 0;
> +
> +		cap_hdr = readl(rcrb + offset);
> +		if (cap_hdr == 0 || PCI_POSSIBLE_ERROR(cap_hdr))
> +			return 0;
> +	}
> +
> +	return offset;
> +}
> +
> +DEFINE_FREE(iounmap, void __iomem *, if (_T) iounmap(_T))
> +static u16 cxl_rch_get_err_src_id(u64 rcrb_base, struct aer_err_info *info)
> +{
> +	u32 root_status, err_src;
> +	void __iomem *aer_base;
> +	u16 aer_offset;
> +
> +	void __iomem *rcrb __free(iounmap) = ioremap(rcrb_base, SZ_4K);
> +	if (!rcrb)
> +		return 0;
> +
> +	aer_offset = rcrb_to_aer(rcrb);
> +	if (!aer_offset)
> +		return 0;
> +
> +	aer_base = rcrb + aer_offset;
> +	if (aer_offset + PCI_ERR_ROOT_STATUS + sizeof(u32) > SZ_4K)
> +		return 0;
> +
> +	root_status = readl(aer_base + PCI_ERR_ROOT_STATUS);
> +	if (!(root_status & (PCI_ERR_ROOT_COR_RCV | PCI_ERR_ROOT_UNCOR_RCV)))
> +		return 0;
> +
> +	if (aer_offset + PCI_ERR_ROOT_ERR_SRC + sizeof(u32) > SZ_4K)
> +		return 0;
> +
> +	err_src = readl(aer_base + PCI_ERR_ROOT_ERR_SRC);
> +
> +	if (info->severity == AER_CORRECTABLE &&
> +	    root_status & PCI_ERR_ROOT_COR_RCV)
> +		return FIELD_GET(GENMASK(15, 0), err_src);
> +
> +	/* Assume at this point the info->severity points to UNCOR */
> +	if (root_status & PCI_ERR_ROOT_UNCOR_RCV)
> +		return FIELD_GET(GENMASK(31, 16), err_src);
> +
> +	return 0;
> +}
> +
> +static bool cxl_rch_forward_error_by_dsp(struct pci_dev *rcec, u64 rcrb_base,
> +					 struct aer_err_info *info)
> +{
> +	u8 bus, devfn;
> +	u16 segment;
> +	u16 src_id;
> +
> +	src_id = cxl_rch_get_err_src_id(rcrb_base, info);
> +	if (!src_id)
> +		return false;
> +

!src_id (0000:00.0) is valid. May want to use ~0.


> +	/* Try uncorrectable error source first, then correctable */
> +	segment = pci_domain_nr(rcec->bus);
> +	bus = FIELD_GET(GENMASK(15, 8), src_id);
> +	devfn = FIELD_GET(GENMASK(7, 0), src_id);
> +
> +	struct pci_dev *pdev __free(pci_dev_put) =
> +		pci_get_domain_bus_and_slot(segment, bus, devfn);
> +	if (!pdev)
> +		return false;
> +
> +	/*
> +	 * The error source id resolves to whatever BDF the root port logged,
> +	 * which is not guaranteed to be a natively handled CXL.mem device.
> +	 * Apply the same gating as the RCiEP walk fallback before forwarding.
> +	 */
> +	if (!is_cxl_mem_dev(pdev) || !cxl_error_is_native(pdev))
> +		return false;
> +
> +	cxl_forward_error(pdev, info);

Ok, I see the tie to kfifo cxl_forward_error().

> +	return true;
> +}
> +
> +static bool cxl_rch_handled_error_by_rdpas(struct pci_dev *rcec,
> +					   struct aer_err_info *info)
> +{
> +	struct cxl_rdpas_rcec *rdpas_rcec;
> +	struct cxl_rdpas_entry *entry;
> +	bool handled = false;
> +
> +	rdpas_rcec = cxl_get_rdpas_by_rcec(rcec);
> +	if (!rdpas_rcec)
> +		return false;
> +
> +	/*
> +	 * The RCEC aggregates multiple downstream ports. Each CXL.io
Maybe:
'The RCEC aggregates multiple downstream ports' errors. Each CXL.io'

> +	 * downstream port associated with this RCEC exposes the RCRB at its
> +	 * base address; walk them all and forward the error from every port
> +	 * that reports a valid error source.
> +	 */
> +	list_for_each_entry(entry, &rdpas_rcec->ports, list) {
> +		if (entry->protocol != ACPI_CEDT_RDPAS_PROTOCOL_IO)
> +			continue;
> +
> +		if (cxl_rch_forward_error_by_dsp(rcec, entry->address, info))
> +			handled = true;
> +	}
> +

I was surprised we had to do another list traversal. For some reason I thought
RDPAS would gift us an index for direct access to a RCH RCRB. The advantage to
RDPAS looks to be the EP doesnt have to be accessed is all. Is that correct?

> +	return handled;
> +}
> +
>  void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  {
>  	/*
> @@ -173,9 +310,16 @@ void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  	 * RCH's downstream port. Check and handle them in the CXL.mem
>  	 * device driver.
>  	 */
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
> -	    is_aer_internal_error(info))
> -		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
> +	if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC)
> +		return;
> +
> +	if (!is_aer_internal_error(info))
> +		return;
> +
> +	if (cxl_rch_handled_error_by_rdpas(dev, info))
> +		return;
> +
> +	pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>  }
>  
>  static int handles_cxl_error_iter(struct pci_dev *dev, void *data)

Looks good.

-Terry

