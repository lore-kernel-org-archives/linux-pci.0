Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010043.outbound.protection.outlook.com [40.93.198.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5395549BD85;
	Thu, 10 Sep 2026 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049574; cv=fail; b=nB7AiLQwFcecBwaK1fvIu2fi1ulHrw8Lb8GKR9uLespvfD12ca1QcOL4Ko/c0h8sbttmCIXTwMXKH8W/vwlSK56cR70xrhtgqtLzsaKftphi53ruwyGeIVaeqTytVaaaqSPB17iPDrGzMu/bN1WJ2kWr8LJQzbsD7vrxTa4L+oE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049574; c=relaxed/simple;
	bh=5+I/hT5F1ezsfcfBMq2rb8ZlsydlWy/dETZxRfxBrPA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hNg0Ok1tu20wNd8wqcVRjIJgge0pLDNmlvb8kGJRKzBkNgn6pfxdd/b/R7k3Ipz5vJklNf1/QzFYDL1py4GNUv2IasU6ct4GAdhItV2VBdTngQyqUsn5APFGxZHqWyeEvNwKp65X5CJBp5v/sOKL4qXS/mXh9w0SNNrynfmNWnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WyYt2VR6; arc=fail smtp.client-ip=40.93.198.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WyYt2VR6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSPApm7RK5NvRXoOVRabmOx9Btsppih+GhNZckwuu4J3QLV6XsiCO1a3C+//vtsIqDFwfK4B9GoelE9G5oj3cuItHenPnvp1WnJOzDA6JrjsOxZSP1w1uvblaJgnZqMC8w+puGAU/zgagxlm8N0ungH5sTVFI2OBxDe+7Yd/qxxnrI0CiOhj3P0gwoIHBcvEc8Vis3oWxjSk4cOuZTmv7UNjmLuvCQlLaVBqtVtAdZDk8c+0VSuRb5o/6YV8s1zjvb8rKPi/uwU3mMu+NPHOa9AAqRxyLJ4GG3y41GSAoElqSpwnHuE+Y5mTok7hMq1o65/r1EmPPfCJK2zj+TXyCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hAGf+KDCLt/M00IvZwt2CXfo5x49L8ZzcrMGcUuv/w=;
 b=GWEt+gCknFUVziWSh9zcjixLN2qHtMfpTEPunURezjO9O6ZFBqEmzjSPO1h05ABj/AYz2kTszEAK+4wyjOMXwx5ayBqGzAEN7YjeHHie6Ga9bQumbgQmp238E0hqgIY2OV0xqAeMKq7KI6ZjgdrU/2wdtsTUpWraOMi6YP7erB/b6wDFQEj1Zphc1mt2TwaylwaplNov1VjErvx5wyHLZ6hFuq7flFEf8i5xb8GPurCJaVvKCI9laJaMI1mNJUvqnd7aXNVX+G3eIFxGagB+pf7gC7/DdK7KGduAFHUEUlVs7CHSEEor/6rJ16hDKUz7edVPA/hB/2yEy/gteL010g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hAGf+KDCLt/M00IvZwt2CXfo5x49L8ZzcrMGcUuv/w=;
 b=WyYt2VR6g0foIHV1dzWKG3+P7dXPOPqqE9/ipPXVTpFB5fRfx3G0Ryk37l1pPsbEiNnNrURLBo/xn5dnzHeTd9AAs6qCOi/A9bj73IDlXMD84S/JEfXhHG0/glpJWuiIIVIzEs6CoahMR3oQe1Xp/wLpjkOCshoeGBzMwOyd8M0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 14:11:58 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%5]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 14:11:54 +0000
Message-ID: <818f9235-99f5-4f18-b10b-921f331a0180@amd.com>
Date: Thu, 10 Sep 2026 09:11:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 10/34] PCI/AER: Update is_internal_error() to be
 non-static is_aer_internal_error()
To: Lukas Wunner <lukas@wunner.de>
Cc: dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com,
 alison.schofield@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, PradeepVineshReddy.Kodamati@amd.com,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, vishal.l.verma@intel.com, alucerop@amd.com,
 linux-pci@vger.kernel.org
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-11-terry.bowman@amd.com> <aqEVTjjAtLYX19Rk@wunner.de>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <aqEVTjjAtLYX19Rk@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0012.namprd11.prod.outlook.com
 (2603:10b6:806:6e::17) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|SJ2PR12MB8650:EE_
X-MS-Office365-Filtering-Correlation-Id: c75a5a90-1190-4025-0086-08df0f457772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|18002099003|22082099003|4143699003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	5BB0cIL5v8xVC+K6msLywqVlQZ6tr2vnJaBxz8LNFV7remRvJiF10NnY+0T+FStCwxIPnNkVAZz1i+WsIwFHt2MhTXEzhYCkB1bpZ5rFVprOSFEefBhxaDDkQmucwEvHqgBL1OEYPHXga2DZtQ706Lv5bk3chUcXzgLDFSr2IQzo0/bm6ODK/F/lFzJxBFFTw2lYrzVYAd5TgDbLf0R589ncvojHfOxFFe0DmZjXs1yNIKqpRPTUl26ZvI7fw4KEBJM3+zi2QizuFP5IihVXXegC+M8qTicb7JdzhBGNsu/f2kcHGA10Rmtcy4zMWLOZC8QIK6cfi7cGmQc0EahA0lW8ypcftCyG7t25Ur1FcD7x1i6ZZ6RymuRy5Y6enyjpKA0Gb0ffT3Elq3NRxLUi0QrhcDpp2oDZQboOIOkPM80rnNCAvJYMeRUzxMm9/kZ0FdzNJ9vuHoLAVSw8OsJSrBcLPPaVlXinEettGmHXYQ/MG8ArivQ5EoLGit7WbJmpd+9p2QoUxeJj8T7tDrbD0jofHVNMSvRAGhaocG3SFwOFSkugcMkCa0c7dmzCh8NL30QpAWjYcUDcGS27W0wcaKZvFNDA/vLIeoWO8fh1TSftg6aICJZORoctYdjLGFY6M42vIeDAg7zWKpcSDNzXg/lzbNra60WjKeY6o/XShUc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnQ4c2t6aGYvYlJML1pqN1JXVlBNMSsvclhwTjdsYXJJeVRwZHZRNTdWb2NY?=
 =?utf-8?B?blVYYXRMdTZmOG9McXpQbGlzK1RNYzQ3UE5GZjdFMDJSckVSOEh3RWlHTCty?=
 =?utf-8?B?ZWFyNlhxY29iNm1ReVRRYW5kcWF6U1VjeXV1cnB6R294TUFTQzVIanFydUdJ?=
 =?utf-8?B?cTlIWUxpUTRtZFBpOExyd2ZzdXpEUHU1ODE0dFltMHVNcGo0ZmZEWlFqZTBS?=
 =?utf-8?B?c1k5bVM3ZUZEMXNmSmxJdjcyUzV4d1pDMTFjNjlsVnhLd3piV1FEODdLTm1O?=
 =?utf-8?B?RThyQWRrY2kzVDBZVzVtMWpCR0l1bnY1SlJrL3RTYmlaRXN0YzRGK2NoSG02?=
 =?utf-8?B?SE5EVnZFVUVuMS9jT1JqUzA4VnZoajE3bGRpU3c4L2h1ck1YTmdGL1h0TG1L?=
 =?utf-8?B?RzU1cUs3V0xmMnVxRUJieE5BL3BtN3oxUzg5RkFMN28rQml2MnlUQW80Ullh?=
 =?utf-8?B?N0k1RW1IenZNSGdNa2p0RllRZjRzVHpjeE1qdDQ3WGc0UXJ6OVB5Wm5QMW1q?=
 =?utf-8?B?QzdudmFnN3ZnK3hIMHIwanRzQVZLcitxTHNtaStBMzB3bkh0N2QvcE96dGs0?=
 =?utf-8?B?U2xad3Y1ZzFNa01MenEzaC9Yd2NxS2dmRzJwNXcraFdKd2VpeWZMMGhpWkZp?=
 =?utf-8?B?VmlvSUkwSDFMZWpaaWJKZzdaWnhVaVBieUh5cG5IRW1KZkRIRG9vRUxEc094?=
 =?utf-8?B?bnZhNDZlN2h0ajlwcFlXQVNNMjhZWTExdlM0NmhOOFI0alRRQnZDR0dNQ2Jh?=
 =?utf-8?B?bkhvU2QxdDN2Ky9WUnpZUGlaWXNwRFJwRXdrYnlWeVNocGR1V1c5cXhzM3FZ?=
 =?utf-8?B?MXdSY3lpRmZ0MFdkaERPOUdmaUNwSmlZVS9nNm52Y3dwYTlKSUNZZm9pUUVS?=
 =?utf-8?B?UlMxdDVRdEFtWVV4d1o2aVZTNWZPRncwOUtBR2x6RWQzbHYvYzluVlNDMVhx?=
 =?utf-8?B?TjExZzJiL252V0dIRk5CVzlBUDJjbjNscWhqdXRpcTRsTk13WTk5L0dnTTM5?=
 =?utf-8?B?bVN4bXgvaWpvcDBycUlBQ3JPbGxmbUR1U0hNU0RVQk81cThhN1VrcVhLcCsr?=
 =?utf-8?B?V2RiZzRYaFFCNXpSNWUweXhiTFNwQWFXWHBHSVJ6YzZGRzJvdGxzWFZPWTJI?=
 =?utf-8?B?YVNxN2xhaUl2dWhMRzhudkN4aUswQnJYWE5tQjAwbXJCeVRzUDVZeTBYOFoz?=
 =?utf-8?B?azZ3YXlJSVBWNmk5bko3RzVWQjNXQ1ZkMWg0WXJSNkcxYXRSUDdxbFlNb1Q2?=
 =?utf-8?B?TlZmam1EMmFYb1drVStsRi9ObjZWYlVjTXVLWU5pMDVxejQ4RnFiaC92V0p5?=
 =?utf-8?B?V282bmdJRU1TbEc3b0JEa3kxZlVMc2dwaDhwSGtIMjE5S3c1VFNDQW9rRmx0?=
 =?utf-8?B?Y2ozaDN4aUpleXduclllK093QnhtREk0M2Nta0d0YXJud05FWmNTRnJPc0FV?=
 =?utf-8?B?ZlVna3JRN2VuMCs4Kzk1OTVpTkNYQm5wTVlzMHpBK2YvQy9hekFoWVphVmN4?=
 =?utf-8?B?WmZjaVNoT0ZXaDdrU2hCOHJUL2VYRUtQV1cra0kzVDM3MkFacWlyaE1MRnFh?=
 =?utf-8?B?LzZFdVU3U1phV3hFdzBGOWZWVElISi9neDU5Y0laRERnRWU3UllCWWpGTENW?=
 =?utf-8?B?c0RXc2VLeStIWFNsWTkzTVh4Z2trSHBjWlRIZ1VFYk9PVGR4YXZpMHloKzFL?=
 =?utf-8?B?VHB2WDVCUmdpRTlhMkZyVXJwaU5NdDlrMHZQcFBLREdHblgrR2syN2g1WnNy?=
 =?utf-8?B?V2RJN0dSSXBqblJpek5ndkNHTXNnQTB3dEEzOUp0Z0Q5OVR4STRkOTRLWlcw?=
 =?utf-8?B?K1pmRSttQVhYMEZta1JQbTBkNm44Y0JKRVJjRDY4M1ZIRFJnTGNvSXJsbEFv?=
 =?utf-8?B?b3ArUEM2ZTZ1NkU4SFgwdUo0TmFzSjN3NmtNTVdZcTVMRXVJZFhCb25qNWEy?=
 =?utf-8?B?VENnTXJkZVBLVXZYMC8zL0x2cXRqTUZZKytwejZKc3JSbGRrNjZRTS85VGJq?=
 =?utf-8?B?aURFYUxJdkt6ZVBXN3piWjhkWGtQbVozOWNIZ0R6YnRsTk9LR01nR3YxbDJk?=
 =?utf-8?B?WGlyK2xPamFSTlBuSDBkOGR6d3NtcmxJUWJHbHMyeGJjTEpPMnFnaFF5eUp2?=
 =?utf-8?B?RVAwNnF0OVo2QmFhVUNxUHRuZ0Y1MWxxZWsxMXhUbklCcnovSHQ2cWpQcW1S?=
 =?utf-8?B?bHRLM0wxK1FEeWVlUGxzVm9TOGZkS3BxdXNjYkRQVzdzK1B5dVl0dXRqb21y?=
 =?utf-8?B?UTkybkdyL0xKZGhMQ0VreitLMlRpbjJqTnNoaWtXWnlQcUpoUXNDU1RMT0F0?=
 =?utf-8?Q?5iSes5kT/pwxJSKyvV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c75a5a90-1190-4025-0086-08df0f457772
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 14:11:54.2541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uaZX6xKBARiGexL7b9DR74rG2w3S5Ivtze08EcPFnQuJnG2iz7XuHYJrQy69E08cZbkJDE/UmttK6W2dl60t0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8650

On 9/9/2026 3:14 AM, Lukas Wunner wrote:
> On Wed, Jan 14, 2026 at 12:20:31PM -0600, Terry Bowman wrote:
>> +++ b/drivers/pci/pcie/portdrv.h
>> @@ -123,4 +123,13 @@ static inline void pcie_pme_interrupt_enable(struct pci_dev *dev, bool en) {}
>>  #endif /* !CONFIG_PCIE_PME */
>>  
>>  struct device *pcie_port_find_device(struct pci_dev *dev, u32 service);
>> +
>> +struct aer_err_info;
>> +
>> +#ifdef CONFIG_PCIEAER_CXL
>> +bool is_aer_internal_error(struct aer_err_info *info);
>> +#else
>> +static inline bool is_aer_internal_error(struct aer_err_info *info) { return false; }
>> +#endif /* CONFIG_PCIEAER_CXL */
>> +
>>  #endif /* _PORTDRV_H_ */
> 
> This has no relation to portdrv and so it's unclear and confusing
> why it was placed in portdrv.h.
> 
> In your pending CXL AER v20 series, you're adding more declarations here.
> 
> We keep declarations that are internal to the PCI core in
> drivers/pci/pci.h.  However since this is just an interface
> between aer.c and aer_cxl_rch.c, maybe drivers/pci/pcie/aer_cxl.h
> would make sense.
> 
> Thanks,
> 
> Lukas

Agreed, it doesn't belong in portdrv.h. I'll introduce drivers/pci/pcie/aer_cxl.h
for the aer.c <-> aer_cxl_rch.c interface and move is_aer_internal_error()
there.
                                                                                                                                                                                                                                                            
I'll also move the additional declarations that the v20 series currently
adds to portdrv.h into the same header so they don't reintroduce this.

-Terry

