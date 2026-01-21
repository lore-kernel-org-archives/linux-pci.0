Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012013.outbound.protection.outlook.com [52.101.48.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9A81F91E3;
	Wed, 21 Jan 2026 11:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768995673; cv=fail; b=NQ6jJ/4MqrwkpvyayFNbD3VADZvC2+1o0YxxFSNtWEzKxZ019S0/iX9ToIDa2NXLRY/0uCKM8OnZTj/mDTakdsL4yXBoI6JbXV1yR8AD0WZIeh0BAzMbq+AwkIMqPRyhxUQXh5VQ0CJsfckzMBkJlFxwUyyJnv1kV+RucPVIoCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768995673; c=relaxed/simple;
	bh=mKgJgOXtBMtfcJQMIUGX9nDRpqDhYoPGr0TvgbaS0Tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SNzEqQBweHRxUhgUOuWuwzQ5nSKiWDbr/Z9iGTGRG3Sf2RyBUnHd5Lvbhj9jevfTjhS0s+GwyacdgUyC+ZYcj4/d2J7ia8r4bYC1PJXpXvdclsDqZL4xLIywuAenK0yiHSwXVD+KnXn4qhlsn7/MwjI1XnV+cFqYrhqcfbJll6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WPCfr7eW; arc=fail smtp.client-ip=52.101.48.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WPCfr7eW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVtwxeWXSnsS1wEBaCcmhjXjI61APKEYBG9Mbi1cljXtaub8QOkWzSvNx2egpOmEYRRJy2nXUnJ0cUTiq9a6rKgzGtz9iXQryxJsTdKnKqVPOCD8aqXNWUMLpceZHI/wEKyyiSWz7um/TtK7Hy9dVxGv9sRoo/fhRPwJO8F3uYZ+zNTNx4d4A6ga7+SOwrmA4nVTVUDzYROH1JHlee25gZO5t+nfGu+mWhf6vhvXlm6PD+JpU86tmawbK2V5RolOntexbTK4YjGTybyIgV+QPBHuqIzHkpKrgmcPwJkjQ5/2WzA/Dmzlk5haYMsY1UX7pivtxH3o6AQfWIW22UQiDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yeWATVxIbgoyPwSDxgcLbwpwnGjCImvnVnZ03Uv+wLs=;
 b=MOxjQhH49EkiLat+FKQd4d/pZlFbjsq05/Vcv738htyjplxXusAhI8iIf1b3LVoSBv65Iknq3+7dw7rMKwcpkz8CU3G5rfBe0lkKE/kIth+F+J3knz89D3N7yJKDoXAnIyXmM4kkyeV1TN8Z3PZ9nD2VAHa+Dy14YP26xQ8tTGrExzTeQYgivL2xdRoYooB9eUAss4iPI4nQ064krbi7f7MXKyzVC6ffBQ+Xd6O1xvtmaBQQpq58cdLL1+dqT+zatMwldJJxs4mptZyHq52qROuq6eV/oxCTFp5SJVDWu49+eJEPEK6rdnFA9dHL14m8yeKmMvtaoBGf8Q+OVmyqrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeWATVxIbgoyPwSDxgcLbwpwnGjCImvnVnZ03Uv+wLs=;
 b=WPCfr7eWrLxbeX/cFh6G0pICegl+NM/oj6NJrSu97/EIJg9rTpzNUxyObJFVquRT+XVZ/jIj+BYT2hOtpWwdL0kQIWOUOe43mcPhHdEnuGirCIol/kh91ETHA5qE4IRbnO0P1SS9G4PzxNE0RVRwKIXm66M/wzkB+bWE4yIP7qQ=
Received: from SJ0PR13CA0149.namprd13.prod.outlook.com (2603:10b6:a03:2c6::34)
 by SJ5PPFB3F166793.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7c4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 21 Jan
 2026 11:41:05 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::45) by SJ0PR13CA0149.outlook.office365.com
 (2603:10b6:a03:2c6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via Frontend Transport; Wed,
 21 Jan 2026 11:41:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 11:41:03 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 05:41:00 -0600
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 05:40:59 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 21 Jan 2026 05:40:59 -0600
Received: from [172.24.231.225] (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60LBeuYQ2940934;
	Wed, 21 Jan 2026 05:40:56 -0600
Message-ID: <d22c37a1-0b75-4f8b-a846-f20bc9a9cca7@ti.com>
Date: Wed, 21 Jan 2026 17:10:55 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: dwc: ep: Fix resizable BAR support for multi-PF
 configurations
To: Niklas Cassel <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>
References: <20260121054214.274429-1-a-garg7@ti.com>
 <20260121054214.274429-2-a-garg7@ti.com> <aXCjP8KZw1ig8i-W@ryzen>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <aXCjP8KZw1ig8i-W@ryzen>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|SJ5PPFB3F166793:EE_
X-MS-Office365-Filtering-Correlation-Id: b45e663b-6ca7-4bcf-ceba-08de58e1f55e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1BSaDQwckF0TEx1bE9hZHZYajdBUFh0TUJ2UXI4SGdJTzFldTgwMTdCR25C?=
 =?utf-8?B?Sk9FUk1vSmNoSzk2WTNNNkxOdlprdDM0Y20vL2U3VVRKWWhLQ05LM044aFc5?=
 =?utf-8?B?Tk14RjRtQ2c0aHF0R1RvU1hEZFU5VVdqUXF6aXIrNElsZFROT1FqTXdFUnhr?=
 =?utf-8?B?dDdtWGVqZzlsemQ0TmFOWVFQMWlkTmxiaFBpZXJZWmtJRDM2MFhZZWErbFlU?=
 =?utf-8?B?NEJ6ZEtqRHVrc2lPc0FlN1VHRzhEdnNRcllQZmM5TWpYUWJpbVNTQzVpVFZ3?=
 =?utf-8?B?aEVUZFpQVVFFcnJaMkNlRCtUa001MHROcHllRHhiMGZEb0lkZTRqZGxLejBY?=
 =?utf-8?B?QloycjBTbTRGUmg5VmVrcHBzTDVmZXBVU3lYd0NPN1lTU0I4UktPNnQ4NHpi?=
 =?utf-8?B?NDJRdEN3MjlVNEVlZnBjRlZzWFM4dWR1dWRLRG9JYXBOaHRRR2hlVE93b3RC?=
 =?utf-8?B?clJ4bjRpK1RNR2FqNURReERINmNKSmdqRWsxSzVjeWtBN0NsZnVEM3FEbUMy?=
 =?utf-8?B?ZnlpV1UxOXR6bHRKUEw2YTIyYjM5K3o5emwzdS9YMDJWYzM0M3FQSXloVE0w?=
 =?utf-8?B?bi9nTUwxSkVYTkMvelBPR1VFRmV5RG9tNzdLVDRqMjJyNWhJWjg0clpCd1FR?=
 =?utf-8?B?MWJVeUhWRVVGS2hta0tVVHJQelFWTEsxa1hhWWFDcVc3WC81WVFpZ2NGTy92?=
 =?utf-8?B?blRBTEZNTnRTVHQzMnhwTUVWQ2hoSm93UzJMWWcyelJPQUVNY0FCelJnRU5k?=
 =?utf-8?B?bDRmQnBUQ0F1WW1nZ2loWmNwbkt3TXI3SHhVSWpoZVc5RkhXYUVTY0RuSlZT?=
 =?utf-8?B?RStWMlBGQnc4bFhqaEw0TG4yanZPNFYxNTcwK0tuMU9iUFRxS09zWHpiN0l4?=
 =?utf-8?B?L1lLSFhtYmYrR3J2bDNLUXRKUGwvWFBzeS8xbEZBeDBzc1pkTEtvMDRFZi9H?=
 =?utf-8?B?ZXZMV0hiS25KR3ZCWmN6dTd6aVVrb0FYdG5TY2RVOUdZeVhGWXR1dlRvMlNS?=
 =?utf-8?B?T2J2ZHRvQ29YZGxTZDZCYnFac1ZIM2Y1UlY5bHJOc3FXVnJYa1FDTnVHM3lh?=
 =?utf-8?B?cGxTOU1EOHRUYXVFcFhvMUphOGs4bDhualMxNUt3ZnlaQzdzeGoxTWR1MzBQ?=
 =?utf-8?B?VFBRTEtrUXFhN1Ywc0hicW4yMTNVTDlIdGp1MFJ3Y0Y0aFZVRHRSby9oTm9p?=
 =?utf-8?B?RDNrNkZhTm5xZmtmR1Y2VFhHZnBTVGZpMml3bGlLU1VRQ1JFS0YyK05uanE3?=
 =?utf-8?B?Sy9LZkdlbTBzR1VTNEZRekwwWGRwUTdkTVZQWHR5TENKYlUrUXBUb05KRDNL?=
 =?utf-8?B?QU9lTERCR0YvZlAzVHNpcDV5ckZ6WllpSHZpb2t4QjIyWTAxRUdOMXE5WGx2?=
 =?utf-8?B?Y1BSME9lTkNNVml1Uy9ReDJEWWxzRFJJaHBiSzdzZFV6NXBYTW9uNk1FVEhU?=
 =?utf-8?B?azNkb093dmluUG5oeGhLcGFuUGFGTjlORjlJYTRwM1NmNjF1eGRTblNrQzd1?=
 =?utf-8?B?dXptS2VFSXR1U05IbWlYNVF0SU9mSDE4YTErTjduUDUyd1I5TEc3dUJPZGtN?=
 =?utf-8?B?dGR4NjVEeUJib09zNW9NYWFLOHkrOUVDSzBnRkh3bG5Wem9XTisrL3R1cWhP?=
 =?utf-8?B?QjNNNk5yQlZlaW43d1V1dzRyKzNvWndrOU5yb0o3RkRoZEdIN0VIVjQ2TFdZ?=
 =?utf-8?B?NFcxY0txckRlUWMyUWJQbHVBcUVFVHlYK09hQll0Zm8rbys5TC9KTXhXbmw4?=
 =?utf-8?B?RTg3VHdFSU9JVlNlYW53cmZXbGJudHR6RnVuR1N2K2h4SVJtMDRxazhJaVNn?=
 =?utf-8?B?TmNMWHpCR05oZzlaSmFkRW1xU2pyNldDUCtOem1uRGx1Vmw2UmhSZGRPV3Yw?=
 =?utf-8?B?OENuQ21ZMzRJcVk3MU1aQWNVTkRLN001dkJ3U0pTRlhHY3cyWTBwNVJ3SEZ0?=
 =?utf-8?B?ejMwaGFaSk1xTHBkSHZoc2tRQXprN0JwclpUWEJrSXRmaXJ6YzRzK2FYV3Vt?=
 =?utf-8?B?Q2s5UE40QkJHYzVaUW9jUmpZdTE2REFralRVREhiQVpoSVVkZ2dMK05QWjlT?=
 =?utf-8?B?blRaNHJoN0IzVDYzV29aTlNHWGxYSXZKWHFUa3IyR1JRYTMxbDR3bTFscmQw?=
 =?utf-8?B?Rk1kQWVPTnpPdWhBclJLQ0pCUjdNOFRLL1EvN21NRitiVGFCc3l2YmROdE5T?=
 =?utf-8?B?S2RaTm1EQjVyWFl2MHlLRzYxWVVyek9FOUpDNzBUNGh6MUFLdjBkTEZ0bmdN?=
 =?utf-8?B?SkpVaU00aFZ5UHBVN1FMbVl6a1lBPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 11:41:03.9313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b45e663b-6ca7-4bcf-ceba-08de58e1f55e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFB3F166793



> On Wed, Jan 21, 2026 at 11:12:13AM +0530, Aksh Garg wrote:
>> +static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
>> +{
>> +	struct dw_pcie_ep *ep = &pci->ep;
>> +	u8 func_no, funcs;
>> +
>> +	funcs = ep->epc->max_functions;
> 
> Initialize this on the same line as the variable is declared.
> u8 func_no; will be on a separate line.
> 

I will fix this nit.

> 
>> +
>> +	dw_pcie_dbi_ro_wr_en(pci);
>> +
>> +	for (func_no = 0; func_no < funcs; func_no++)
>> +		__dw_pcie_ep_init_non_sticky_registers(ep, func_no);
>>  
>>  	dw_pcie_setup(pci);
>>  	dw_pcie_dbi_ro_wr_dis(pci);
>> -- 
>> 2.34.1
>> 
> 
> 
> Thank you for fixing this!
> 
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> 
> 
> You do need another patch in this series though, that fixes:
> https://github.com/torvalds/linux/blob/v6.19-rc6/drivers/pci/controller/dwc/pcie-designware-ep.c#L972-L986
> 
> As currently, ptm_cap_base is fetched using dw_pcie_find_ext_capability()
> instead of your new dw_pcie_ep_find_ext_capability() which takes a func_no.
> 

Thank you for pointing this out. I will add a patch for this fix as well.

> 
> Kind regards,
> Niklas
> 

