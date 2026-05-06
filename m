Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013075.outbound.protection.outlook.com [52.103.43.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332033B8D75;
	Wed,  6 May 2026 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778084040; cv=fail; b=jFWpM4p/d2ilGtZKD1OwHv96gjt/uc1OdRUCVAQZTg3bEfQV3PdtGHZ/aWOyWcjwonD11MbOm2G8FVXWYt50RFKG2J9kh1FPtvtQZWjEjlebVZjaorUlsSoSsJm9NYMHLEOZ5nrB+SL8igHzIuuvefh2BhWgdd3U/R0iGjhDRnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778084040; c=relaxed/simple;
	bh=8tcxrnSJ4YcMrseVPUJpfqc+nzDd6pytI4ZKLQZVGKU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bLV6WpoHmPF/SHkAja7xipBF6ixYv7TE1zKTbL2Zc+bLMu49l+Xuuib3SJEli/dBJsZTJQq7jNpYtu36Msawupqj2Nqy9liKxP8B8ThMMK+S6noFCI6VXCfEOyHvzvuGy7RMGketYITJeefsH+9OufprT42RTPiXgvtr1255kfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=JQvx4P24; arc=fail smtp.client-ip=52.103.43.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="JQvx4P24"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9BCFMaM3BNizsM8aWg4oId0yqTYUBFn8GczxR2vnepDYxOeWd6BxsJyZ9wf8BZrpNnvJ5PPOHTDKnCoTbikNnHZdZOTHgBFt5yQV8Z2WliIYfTMZ0N4OXBiWmCSlEgxs4O81nU9nbVdhh9eftPlnzdawFkCH38qX6oReVDM6bAevWmaDBQY5GNik8y7UadYWfGj/kGNQ7GjgoDMARnMurAJyHKVVr/+mESjiKMBV+L2neQ/o439uh2wtxEeoJZ8tkBVUZ16KZAtPy5/zZVrpYKDhbAn/d4+nLAJ3QuNCrWiBU+8RRp9cAvsFSf6ogV3+sljYqvbssctYfvLnEfsDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ffY29iS305ymJnJKSI2h09PbNPw57pPfCGcfDH8FOs=;
 b=jCVX2gE2UIGJ329jBqm7dWFW4Lhh4/Qj+oX9Hb4XhtL3EJQ4wWTwNBnUqKlQ80ewRWkpfmExrrtVCdVlJOTBkljmAn+8NFJBSVckkmm99ytrFcDwqShbH7c5LMNOPL4LR2vlnQAwP6vqwTS7mdPt5ucL9YsQgJGaaDQAbAYewTDOZL9A56jaCYVdmSGLmuZS3Fv6xhd2ksj3lD3vYDqn+nofW6N9APboWg9oggGl7WVRwldBx2xKBBdmDfpY7fw+JOv7SVKg9brm7gLu7QNKLZbvnd1mLdf6ljcpLHIBtnfZ4PwBioHygX7QkgM/RuC12oavDk7xXHGJTrx00eYVCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ffY29iS305ymJnJKSI2h09PbNPw57pPfCGcfDH8FOs=;
 b=JQvx4P24VpL5Sl2xGHnPmtbPVsl0ehjnGp0/EGEHxzMmkctJGuONe/gtrgA/sRpbr5CQ7+1jBCnyGDorXBc9NSM4eoYpwpECmZ5564NnS3MoIUCLaCe63RCii9hF964a8tluN39c8/INw7AGrESK1c/wN1+1oNUJUVahCnAUjBXrVBmyLJFgza4ONCXVVppCfLnyqJ9rA8U5xkgAZ2e8UaYpfMVad828f84L4TTL+8Ah/N4nEsdcIF+dU5AlQyxGvtVcoVwmasRAxkMybLGZ9ie4F6sIKYwFYd+oQVnjUJCkJIDXX8J40Zffc6GX7HfKf+ImvfIdlrbDQcKJdZao6A==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by PUZPR01MB5119.apcprd01.prod.exchangelabs.com
 (2603:1096:301:105::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 16:13:44 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 16:13:44 +0000
Message-ID:
 <SI2PR01MB4393B9C7E14B3C3727A692EFDC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Date: Thu, 7 May 2026 00:13:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/6] PCI: Consolidate delimiter handling into
 pci_dev_str_match()
To: bhelgaas@google.com, jgg@nvidia.com, jonathan.cameron@huawei.com,
 dan.carpenter@linaro.org, akpm@linux-foundation.org, bp@alien8.de,
 rdunlap@infradead.org, alex@shazbot.org, kevin.tian@intel.com,
 manivannan.sadhasivam@oss.qualcomm.com, kwilczynski@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <SI2PR01MB439385689A32A1DDA9CEABE1DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB43933D93A8B638C86C84D405DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Language: en-US
From: Wei Wang <wei.w.wang@hotmail.com>
In-Reply-To: <SI2PR01MB43933D93A8B638C86C84D405DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYWPR01CA0003.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::8) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <82e89b9b-9010-4c0f-a0cd-c6697e7932f7@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|PUZPR01MB5119:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c369ff-9892-4da4-995c-08deab8a71ab
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|19110799012|8060799015|15080799012|23021999003|55001999006|45011099003|51005399006|37011999003|461199028|5072599009|6090799003|7042599007|1602099012|40105399003|4302099013|440099028|3412199025|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkZOSUgzMEJqd1VqTVViUW00TE1iblF2eUJjUXIxY25lM1hDRjZpS2NDSld1?=
 =?utf-8?B?d1JmRDlQWEtwNllHM2FVdHo3NEE4bmRGSHBKQmY2MjZydGJIT2lJZUpER3I3?=
 =?utf-8?B?SDdKV3RuaDBac1NKemduQXFjYnpTeG85U0djMUVlVjBhV1c2Tjl0ZWNTK3hB?=
 =?utf-8?B?VDY1ZDJzbWl0cGFtUzN6RU5ka3IrR1VTNlJQU0o5cEV1d0k0bHZDNkk4OFFz?=
 =?utf-8?B?ZGVSb0hobTRzb1d4UkxvMUt3Y0V6NW54cXM2bWJraDF5SEVlZ3pRODBxRnBw?=
 =?utf-8?B?K3VSd3BuVnVxcW1tNzV6N0o0VXlkd0Nuc09QeVlpUlJzdjIrK3NIbWZEMXFK?=
 =?utf-8?B?eUpSaVVLaG5tWWpCVFd3S3ExQ3NjTWhscGtjZjdxSXBvRTBjK0dYcUcxc2lw?=
 =?utf-8?B?cWZ0TW5ESFhKWFR4bUhtOGY0NVVMQXMwWUNNalVGeE1tRE4yZEY5c1c5RWdO?=
 =?utf-8?B?MmowOUkwd01mL1lhOVg5YkF4aVphdVY3bm9pRjIxYVhHaGtJMTgrNWFmN1dI?=
 =?utf-8?B?TE1wVUpoMno1Q2lWUzNib3BGZzVMMDROSkppWHZLUDVjc1pUc1dEcWxBRXNp?=
 =?utf-8?B?UkZBS1h5SEtRUWJoVHJSNnJmMEJUWndMTWFMeEhQZy8vSk5WalJiYzhrRlUy?=
 =?utf-8?B?Vi9UWjZ1YS85WmhMOFRyTGkzL1E0TTNrZGZldTFlRHRoc3NiUllWamFiQTBI?=
 =?utf-8?B?NDdsKzMvQTduNDlSVDI5NzB5NVBBRHFQL1lpR1duTCtyQ09SM3FhQ0RxUVVn?=
 =?utf-8?B?TDBiN3R6bUZyOVhMOTNvd0VUeXJCY3c0T1pBaHdhVXhmbkM0RHJMa2lpOCs1?=
 =?utf-8?B?QWdrakRaUzdIS0liMHYrWnhSazYxR3hJb2NLbDUrLzBaYjFtWTNGbzd2OEdm?=
 =?utf-8?B?M0hObnFiYXJ5RURWZWQwK01aamhlMDd5dHdDMGRuZzZIMlZPNHRvRGk2cWpF?=
 =?utf-8?B?Y3JyNU1WQVM4S0oxa1hMM3dnN2hFRk5uRWZ3dkRQZkpQMlQ4bnpyYitIU294?=
 =?utf-8?B?RWIwYWJDWmJBV1pxTTUzdDRGdGIxMkVEV1NlQkRXWGZ2dndXc0VpaExFaW5r?=
 =?utf-8?B?R3c2bnh4S0p3VlZ6ZTJYTFdRRy9hYW1MSUJKVjlTRjR0cDh3N0lmdHVYQ3dG?=
 =?utf-8?B?aVJzZm0yR09pTy9UbzdEWllqM1l6NU4vZWxwWlMxRG0weS9YR2cycVkyMmg1?=
 =?utf-8?B?Wm52d3RmLzlWSkRoMlVnMWRibVZwUmpETXpMcmxVb3FDbklhL0ptZ1BZUlpC?=
 =?utf-8?B?bkdOZUxkaC9PQzNtdjN3UU1DeW1QNUVENXI5NUZPVDNUaDA1TEd3ME9KZ3JH?=
 =?utf-8?B?MEhXMFpjb2pFTWthVjZrOXJ1N25ZR0xyMjV6aUMralN5aFBpU0tzdWJWMXk5?=
 =?utf-8?B?QmpldERUVkVrSWM4UThvd1g2SFdUM3htZkdJdmF3YllTcUZvVnY0Y1dUcHBS?=
 =?utf-8?B?ZWVOVit1Vm5mNEl0VXh3WkVIaU9vN0J6bUFXVmdWU09vQlJnWndzdlo2a1Zq?=
 =?utf-8?B?TzF6YmJCT2lSWWt6T3cva2VQSFVVMEZHTXhKcS85VU54NEF1b003dlhDR1FS?=
 =?utf-8?Q?0qqbZfRZxDapDqUt5jj4MSgHKU+ZLvuxAoxOPqb3OPJ6gH?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1JQQ2FvRkhhQWxpR25qNFV6aTY0OU9tb0RIMjdCcDhJQkpNVisvdjIyV1NB?=
 =?utf-8?B?WlhwaFJoemhscjVHZVN2WW5FaDFxL0l0alJ0NE85QXRXSCt0YmMzTU0zZUc4?=
 =?utf-8?B?aGVPMW9jNmpzTDBjSDAwb2krY3BZZzI2UTN2SXE1U2p1TDZVcTU2K2o0dHJZ?=
 =?utf-8?B?WngrbERBZnZtZ3hadDlGMlp4ekRGWGtyZllBZ1NtbkcybzZPRnpMVlNYRy9I?=
 =?utf-8?B?SjhUZmlJZzNHM0dkSXdUVHFuZmU2Rk1pdmF2S2lCMHZ4SzlmRm1oZmU5UTht?=
 =?utf-8?B?MkhvSVlyclIreHNPTzREeTUxMnRMeEh6K1EwNys2d3dOSUZrWEN6S29GeEdh?=
 =?utf-8?B?QUNzT3FRRlhxdmlaMVl0OGlQR1kyaEhqeUM2RnBpand0aGplaEc3WHVIZ3Fo?=
 =?utf-8?B?b1hVbzFaOTFzWE9rK0wxc0FJdzV0UDNMZ2IxY0l6eW5OQjJVa2FPNzZ2YjBD?=
 =?utf-8?B?ZEF6RWh6d1A3NllyeFRLRVVQaXpMZDRyWmJKN29Sc0FmSG9DWFB4L2ZPWVRE?=
 =?utf-8?B?RXFLWWtvRVBWVjVwMUY1NmVWRDUwSDNUK1BZKzVOMVBKMEhpWWNWVHVSczY1?=
 =?utf-8?B?eFAvZkNDL1phQkZ4aG9VbGdMam5VYlZUeUZrNGZTbnRFUDRBNjM4YWhrRHha?=
 =?utf-8?B?MW1CemFtYmEzakQxZ3lyeW1OZnQ5OGxzcVNvVURUZmNqbFBrQ3E2bzIxbWRj?=
 =?utf-8?B?bXR4TFYxQnhLRS94aEIrUDJrQUQ3ZjJvK1RtS1NRd01adUlHcW5BZEVJcnZ6?=
 =?utf-8?B?aktMV0pBd2twT0dPbEQyNUgxNTF1TTNEMTIyZ20xa0I4Q0wvKzhYckJabWxN?=
 =?utf-8?B?aUgvQUwwOVBXU0hLdU8yYUswWTlLRVp3a1dFbk5CaHdFR3hib0ZNdzJZVGpj?=
 =?utf-8?B?TjAycXo5Mi9MazNJa1FZdUZUQ1N1RGJLYVFPb2gvQkhCUjI1Z1JwdUo2ajVU?=
 =?utf-8?B?SU5MUmJSUlBaWlFWR29vd3hUN3NKc1dzLzRxcTRQbytYRWp2V0RJVEFnQndk?=
 =?utf-8?B?Vk1IZFRBWE9jc2ZRMHE1Q09oMmhLTGpWeWEvZ1ZIK3FsR3ExbmlNd01XeTVm?=
 =?utf-8?B?SVFxZnNzOGlaTDlwalp3TWZ4S3RHTXZRWk9sSmRVbGtsdWZ2eUN5OGRUaTZm?=
 =?utf-8?B?UkRGdzE0KzA0bXEwcEswTklpVDdTeVdURnp5ZWNCb3lLS25VdGxsQmhxNDVP?=
 =?utf-8?B?U1JTbXpXcDE0UGNMNzI0eC80bjhEbTVVZElxWDZKSGkrdWkxYit0N3d6cDd3?=
 =?utf-8?B?WU04cG8zQXgvMUFVODVMMDJLM21xcnc0a1RrSm9mMzN2T2tnRFp2ZkNOQ0VB?=
 =?utf-8?B?T0tXUGxNTktnYWI3RFpSL010MGJ6SFRLSHFJQ1ppR3VlS1B6d1FQNWJlWHVT?=
 =?utf-8?B?TUtmTkE5R20waHZaU3d2MzNnK0VzTi9xMktiaXhycnZzQmQraDZrNXZFSy9l?=
 =?utf-8?B?bWlHa0FudnJRb3FsNFIxVUtBb1J1YWhxbVNKRjJHb3dlWVlEcjZ5ZzBWaDZG?=
 =?utf-8?B?ck5aam5QN3pCYUd6N0RnejNTeWRpc1drTDlSZ2VlcS90ek9sUWFSK2txZXRI?=
 =?utf-8?B?UHFZUmt2RklJS0hKMHhWN1AweWRpU2tiL25hUk9SUkZrYjliOEtrQko2Q2Jz?=
 =?utf-8?B?OVZhWlFSU2pkZy9abmV4TFBrUXVnN0I1UnllZm1BamkyWm9QSXd6aDZ4bHhu?=
 =?utf-8?B?aStuL3VrV2puazVwbHVpb2xsU3BJb2ZKeWY0WENhUHU1TzNkNzBYSUk4c0Jj?=
 =?utf-8?B?d2Jzc085d0JpSGdXaGdQenhwL2RMUzQ0THREYWYyYk96dkhKcjJGRmRSaE1T?=
 =?utf-8?B?aWV5dWRwR2lGajdRVHRKOEhpb05CN0JXWS9mNmpoYm5VSWN0VXhPZXoxYkxX?=
 =?utf-8?Q?vJbQr+7JePc62?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c369ff-9892-4da4-995c-08deab8a71ab
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 16:13:44.1754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR01MB5119



On 5/6/26 10:10 PM, Wei Wang wrote:
> Callers of pci_dev_str_match() manually checked for the ';' or ','
> delimiter and advanced the parameter pointer past it. Move this common
> logic into pci_dev_str_match() so callers no longer need to duplicate it.
> 
> When no delimiter is found (end of parameter list or malformed entry),
> pci_dev_str_match() now returns -ENODEV to indicate that no further entries
> can be parsed, preserving the previous caller behavior of stopping parsing.
> 
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/pci/pci.c | 46 ++++++++++++++++++++++++----------------------
>   1 file changed, 24 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e017200694d8..ebd1e81264d2 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -334,7 +334,7 @@ static int pci_dev_str_match_path(struct pci_dev *dev, const char *path,
>    * pci_dev_str_match - test if a string matches a device
>    * @dev: the PCI device to test
>    * @p: string to match the device against
> - * @endptr: pointer to the string after the match
> + * @endptr: pointer to the string after the match, with the delimiter skipped
>    *
>    * Test if a string (typically from a kernel parameter) matches a specified
>    * PCI device. The string may be of one of the following formats:
> @@ -374,8 +374,10 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
>   			     &subsystem_vendor, &subsystem_device, &count);
>   		if (ret != 4) {
>   			ret = sscanf(p, "%hx:%hx%n", &vendor, &device, &count);
> -			if (ret != 2)
> -				return -EINVAL;
> +			if (ret != 2) {
> +				ret = -EINVAL;
> +				goto not_found;
> +			}
>   
>   			subsystem_vendor = 0;
>   			subsystem_device = 0;
> @@ -390,6 +392,9 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
>   		    (!subsystem_device ||
>   			    subsystem_device == dev->subsystem_device))
>   			goto found;
> +
> +		/* No matching string found */
> +		ret = 0;
>   	} else {
>   		/*
>   		 * PCI Bus, Device, Function IDs are specified
> @@ -397,16 +402,28 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
>   		 */
>   		ret = pci_dev_str_match_path(dev, p, &p);
>   		if (ret < 0)
> -			return ret;
> +			goto not_found;
>   		else if (ret)
>   			goto found;
>   	}
>   
> -	*endptr = p;
> -	return 0;
> +not_found:
> +	if (ret < 0)
> +		pr_err("PCI: Can't parse parameter: %s\n", p);

Hi Krzysztof,

Apologies, I just saw your feedback here:
https://lore.kernel.org/all/20260504052005.GA2312220@rocinante/#t

For some reason, it bypassed my inbox before I sent out v7.
I'll review your comments and we can continue the discussion on
that thread.

Thanks!

> +
> +	if (*p != ';' && *p != ',') {
> +		/*
> +		 * End of param or invalid format. Return -ENODEV so the caller
> +		 * stops parsing.
> +		 */
> +		return -ENODEV;
> +	}
> +
> +	*endptr = p + 1;
> +	return ret;
>   
>   found:
> -	*endptr = p;
> +	*endptr = *p == '\0' ? p : p + 1;
>   	return 1;
>   }
>   
> @@ -933,18 +950,11 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
>   
>   		ret = pci_dev_str_match(dev, p, &p);
>   		if (ret < 0) {
> -			pr_warn_once("PCI: Can't parse ACS command line parameter\n");
>   			break;
>   		} else if (ret == 1) {
>   			/* Found a match */
>   			break;
>   		}
> -
> -		if (*p != ';' && *p != ',') {
> -			/* End of param or invalid format */
> -			break;
> -		}
> -		p++;
>   	}
>   
>   	if (ret != 1)
> @@ -6387,16 +6397,8 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
>   			align = 1ULL << align_order;
>   			break;
>   		} else if (ret < 0) {
> -			pr_err("PCI: Can't parse resource_alignment parameter: %s\n",
> -			       p);
>   			break;
>   		}
> -
> -		if (*p != ';' && *p != ',') {
> -			/* End of param or invalid format */
> -			break;
> -		}
> -		p++;
>   	}
>   out:
>   	spin_unlock(&resource_alignment_lock);

