Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013072.outbound.protection.outlook.com [52.103.74.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20FC37CD25;
	Thu,  7 May 2026 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778160825; cv=fail; b=V8XHNCdumjRtS1WuFjUwKhbL1WuUg0HxHSJYSUe0wfiS5W5KvtO6oyGIWeuBjRlItFC2hvJuCBIyxk4/C5M6RHta/awF3Ovjq2ZGPK6Xa7MQcAM/aU779I1eaburybXXnswje7zFRa5lbqEgcop0f7tkZrmeDnmc+Ceum2WHsW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778160825; c=relaxed/simple;
	bh=dabuVM3I6vXnjIPTmclJ4RnGadvYWMc9OlqGwTPYr4g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IP5222rNs9SeFKOYdH8TDGQz0hoVjIeNuM2Gq9FG378wik2FQd99QbPgOZl/z6l2Zdwxl4cRCxyfHvksd/JcWJLQHGZZjjE+6xYB7RmhKyyu1GOK9GXoeQhAjdw1Awp3FKk9wsZujFa4q6uq/s1Up+Gv9mJsrmWSeAXqUkqKDIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=IIz6v4Nf; arc=fail smtp.client-ip=52.103.74.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="IIz6v4Nf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLNek+sxsT0SSqnhLJUJ/ceyiIyikhMHLHSttlu+yNrtdlnpRASC1wPZ8k69+SmDt7RsdgGh2gX2286OD+YxrI7gdFiLXwnhfydTQVKsNIj+kh4DYIYMrSNBhaSFXmty61tMsSdscrHujpPALCiNHLkYrB2/hdqPgNysiZJGoas7gCbXTgw1VpbZ/9PRapysk5jzz4fOQuPaYU4tH7/QyCSPnUouFnGSMMYqcezUZ8khiI2o2g9JyvCR5q+MP3KxJL3WspuVUyz7fcA2u1WXe0UnqkOcj3dRxyIn9B7ZF2CDQrFyHAAuqmQ3Jbk9hZmn6GfKl9DRXccIoBi1gndx7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0xVo8r65oX5olWuKyQB4r1Jb3MSnbarKT4T0vgPOW0=;
 b=D0/8oPCg+H5L1sMOv1AsoJSr6ADPpLUcGQ9n5tWBKvl+no2he0IGTPn6OU5qQAghnsZcD1mB7MKVDtrdyRrjPdZeh32q1QRZkBJ+Hzp6RwQsr2lX75e4Er/5M9Fy+r9SsrI2I3+Tb1qrG1mTDj1b89BD75LRd74iuHCVy0dkLOmdMSoGxkE8wLfPSHnOHU44+G7PjGljkMUT9U6Ils9NmglPW4TMoJ3TCxMjoruOfGKApakwrVptqavycI8NG5N0yeENTj7jPsthGTPz2xGXi73ePd+KZ7IQh+cSi6Wjjud7v9C8bGzex0cer64JWPZXZ3xUVmsfbXVISTM7KFxomg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0xVo8r65oX5olWuKyQB4r1Jb3MSnbarKT4T0vgPOW0=;
 b=IIz6v4NfHqoje24f1DUXGIFv/Rzl+ooxMJo8LqEQl530qKDBTqLzB5kIHASW81ah8NVoX21+izHwYrSRaNqdSrDbkXoJ9+Bt1X3kCVkuaanUgIRkl05zhoIH/azOsr0bHQGJK/8sK2mMzOAhyStOdT/y4K+pd0r4B1f7Lq7c8JrNRcueGQYfjBxbgeL1014Etcjt4NAQmOzSAkynUvq2inq0Exba8Rt1a7sQnfhP+9FWEHPdej/VMuCKmIju+em7F8yS3O5FxmFill3B8Y5PFg0hVMPRhgcBAeOiX97XDBECLIAgfmr4rkWBiPAMcsj5NS8RrRnlT2BFDVGsjMiBOQ==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by PUZPR01MB5425.apcprd01.prod.exchangelabs.com
 (2603:1096:301:102::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Thu, 7 May
 2026 13:33:33 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 13:33:33 +0000
Message-ID:
 <SI2PR01MB4393CDDC650AE355BBEE3C54DC3C2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Date: Thu, 7 May 2026 21:33:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/6] PCI: Consolidate delimiter handling into
 pci_dev_str_match()
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: bhelgaas@google.com, jgg@nvidia.com, jonathan.cameron@huawei.com,
 dan.carpenter@linaro.org, akpm@linux-foundation.org, bp@alien8.de,
 rdunlap@infradead.org, alex@shazbot.org, kevin.tian@intel.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <SEZPR01MB439931D7320F6C476D181C1EDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
 <SEZPR01MB4399FA7D597B0A619C6F9A7EDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
 <20260504052005.GA2312220@rocinante>
Content-Language: en-US
From: Wei Wang <wei.w.wang@hotmail.com>
In-Reply-To: <20260504052005.GA2312220@rocinante>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0220.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::20) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <df6e5f70-ba6f-4481-a5f0-7872e09eda4f@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|PUZPR01MB5425:EE_
X-MS-Office365-Filtering-Correlation-Id: 03fc5563-bbfe-4676-9494-08deac3d3b8d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7042599007|6090799003|51005399006|37011999003|55001999006|45011099003|2604032031799003|23021999003|19110799012|15080799012|461199028|41001999006|5072599009|8060799015|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1hsRSs2bFFERHkwSE1Rc0ZpaEg0cmg0YVVjMHFIbVJ5VTNVYWd6ME5KTFQv?=
 =?utf-8?B?SnhGUzhrWTdvb2hzbk1GcWw3cHRxenFlWnUrRWZUdjBCY1F3NUExbGlOak1W?=
 =?utf-8?B?UFB2MGRLc251TmtBZmthUVI1eW53ejVQVzdxYkphQngrRGhMWHhXRWJseWNi?=
 =?utf-8?B?MFppaFNna29Qd1dQMGppWXA2Qzlsc25sWjkyQTlPeTczZFNpVUFRQ0FJcTZW?=
 =?utf-8?B?b29kUHpSMUxTNlA4Tzk3Y2pzZldITmpIWHZOa05DUU1jbjYyblhIbEc4aE1V?=
 =?utf-8?B?YmJEKzhDRFBqOHVwOUM3ZVpNbkhZZzYveVNnV2F0c01EL2loNkpZVFZJMStE?=
 =?utf-8?B?ZWlNUE1YNVV1a0tEbzFnRllVdXIzZVlINS8rYVVMU0Fhdkc4RnUwcFo1RGd2?=
 =?utf-8?B?aDAxcGdZOW5naU9SUEdqTnRrSEpGcUs2c3BzYURvNVh5ZWRsSEFoU2VsVlNr?=
 =?utf-8?B?S2pISkswNHhxZy9uZUt2WWJKZzYxVitEUTc4eFhuSjk4Q2xWMnFNTnRYTVUx?=
 =?utf-8?B?cUQvaTdBdE9rSzVZQjNpWjBWQlJYTElJelZHUjF4d242SFJlekt3OGpFdUh2?=
 =?utf-8?B?SDAwRTRqS2lua2h1QWd1bkZSWGlEU2tPMXZoeitKTUNKY2t0ZFJkbS9BcDdH?=
 =?utf-8?B?OEh0dnBLeGQrVXFrMzgrQkZnY3R5OE1ncDllN2JtWk5uaEIrNnJJbklCOStj?=
 =?utf-8?B?Sk5HL3BOV3IwaXBlWVUyaXplSnhXR1dzVWU2VndFNHFRWlhLZmt5cFpPd1l6?=
 =?utf-8?B?bHBka1pxQWtGdy90U0svRUlQeWJYZVlTTU51eFl1QkRkT3lNNHltRGJaQzJZ?=
 =?utf-8?B?SVl2SG1URkJoaE1qZWltTmFFR0ZueElWU0JOQWZkVDVodlpIRnhtZlRvaCs0?=
 =?utf-8?B?WnFtT2tEV0hpM0Q1WWlqOEpTZ2lyNkhLOXJnQ2ZqNHZQejlPOVB1a3NNMG05?=
 =?utf-8?B?R0taaUZXSTVlTWliMnpaeU5nQjdjaGpRU3duTkMzWjdjMlI3QjNXQ0UrNmtI?=
 =?utf-8?B?bThjNVR5OXp3RWQ1RVAxdzczV0dWZ2k4QW5vMmVZdkNYMjRjaHcyK3dvb2xK?=
 =?utf-8?B?b0xpa3I4RmJLZlhpdHFXYnFobGhYWXB1NExDNTV2anN0YVVic2hKMjdWQW5J?=
 =?utf-8?B?eWFJSkh5QlhSS2VucWtHS3dHdjRsdG54S2xSMmxNclRyMC9nRVFiWUdCTmQ2?=
 =?utf-8?B?TjBXMlBDTUtCa093L3NSem4xNmJsZ1QwU1ZsamFoSGFBSFpkbW8ycGpqalBv?=
 =?utf-8?B?RzI1anoyV2ZaOWJHV0pPVUVPeXI5cW9rRXlnQzh1b1lacCs0aGY1c3BXZlRL?=
 =?utf-8?B?clp3N294cDFNNmpxWXF6bzBTOVlUZlFoQ0hWVzNLK3c3WWVQelJNVHZqdmdT?=
 =?utf-8?B?STR1OUNoUExIME90MFRDajU2YkFmZlVGODZocG0wNzA4NndGaW1LaDN1NVFm?=
 =?utf-8?B?dmx3TXUrZVliRzNVSW5ReWl5bERxeTBvbTU3NG9UdUlWRnR4TTNWNEdmdXdI?=
 =?utf-8?B?UlVVMExSYTN0b2FOUXhHdi9QYXBleFpnVFVPSzBXMTZIN1creGswY0tHSE44?=
 =?utf-8?B?eXlaQT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHBEVHRNUzdmYVQ2V3Rtakp5RGRMd2JrV1ZNQ2dFdDFwWEhJSVpYRFBoNS96?=
 =?utf-8?B?MVRtWS9GRWdCVDF1N3paM05pVERraUwxYWhnOWFjS2pNNEVZY2F4WVN1cUZO?=
 =?utf-8?B?RkMzL1VvbGs5aVFkRHIvWktraWhnMnVKWHIxR2dZbTVPSnE5NWRCNUI4Rm9x?=
 =?utf-8?B?UWlaeks4STI0cnRXa2sxNHlWMTN1K1l2NS9TRWNKa3FvSUpkQkNVa0NIc0t6?=
 =?utf-8?B?cU9VWlJ0cHVmOXBoTDZCVnRHeStmS2VUaXgzbVo4T090WTFOM1AzQ1cvWEx0?=
 =?utf-8?B?UU9rUVlaa0VSSnQxMDJ2OVVNcThmZFVxdXlYQ09udGFEUFFSWFpMNGdLVktJ?=
 =?utf-8?B?QWk3N29zM3hidzJsdW1ha1V0NmdaREpvdVJ2WUJUU2hUS1hoODRpcXpEZTB5?=
 =?utf-8?B?d2tnT3lXczRGeFE2NmR2aXJxeUthUVhIVmkrOUVlOHBrVlI4a3lEWTh1WWV1?=
 =?utf-8?B?eEFIWUVYZk9BQmJFMFBTZS93ZkhJUWh1TGFKUFdwTmRtOUdFcmZYejBPVWV6?=
 =?utf-8?B?Q3pVREVnbTBOSkl5NE5qc1lMN2V3VFMzWjBvekFJZHRqTDRpQy9IVTJEMDY4?=
 =?utf-8?B?OTNySGRCQ3JiUG1CSFRWZVgvQ3lTMjFrOEswWjV4R2FQNEh0aERDdm9uUk1t?=
 =?utf-8?B?VDBnYmRDVGgrVTRITmlnWEx3YTVVU2dEV1VYT1FGSEZlMjNDNnVlanU4V0pT?=
 =?utf-8?B?ZHV3b2poSEpIS1VOU1U0emVsdXdCSzhVZUJINE9VcGxsRVREbjVzZDA0OWdm?=
 =?utf-8?B?b1Zqb0dUM2tpLzVqWW0vaUhlL21lT1YzUThYQjJZZ0NKUFVJWlVKdDVMdytE?=
 =?utf-8?B?bENyM0JHVmxuUW5iVnlGdThiRUtnSmVMYUxFVGFqODdwbVNPdEc1Y09pZVZO?=
 =?utf-8?B?ajh6SXgvWDhOSWNTWUM4dHZCb0gwRmUwMC9rMUJ4d2ZvUVFWNkpTMlRHVnlY?=
 =?utf-8?B?ajd2OHdHWC9vT21ySXl0YzlBeFhtTHhtWjNIUTMzMS9ZN2ZYTXZvNGR6a1J2?=
 =?utf-8?B?RWo1VzNvWEkvTWVucUFGWnJPNlhxSFVuckNvT1VsTm85ZCszRndWbnZGdHdO?=
 =?utf-8?B?NjFpVk8wd1FHT3Q5S2p4V0tGeVlLZldnakZVbzM0N0tzUW96N25pMlRlK21n?=
 =?utf-8?B?RDk1ZGJkdkpHZ1pWZ2pyOGZtanZmU0d1STVqc1FROWlEOUNkczI0U3oyeVpX?=
 =?utf-8?B?b1EzNVJ2VCtyVUNyOVplK2w0Q2JnQVEySVlrb2JCNHpSMk1UdUNjUC90UmlF?=
 =?utf-8?B?cE14cTZDVEExU3l0Vis0WVVTa0lSNmhwVjQrL0o3b0Juc1JoNDg0T1djdkc0?=
 =?utf-8?B?cEo3dk1xNlZ1cDVydnlJSERSMEtuRE85UmNNZHc2aXdJUXV3OWlzVkhwS09S?=
 =?utf-8?B?V09ja2xLQlFIa1dkcnNROGRaT3RsdHVsMTZ0eWZ4di9mTllMU2p0ZFQxYjZs?=
 =?utf-8?B?QVcrSGhoMy8zK0psa3RPMDJydFhRV2RiQXpxY0ZaNTBKS08vdjhSbmg2Rm1H?=
 =?utf-8?B?VldMbklMRkgzTFJxRWtVdzZCdktzR2JxQ3VxUDVPc2Jnb2JZaUNkWTd2cWRq?=
 =?utf-8?B?d1RqOVBIRCtZbVR4K0ttNU1HVzFEUldyYlRxZ2QwQVBLSUw1VGx3RXJxSmJZ?=
 =?utf-8?B?SC8raU9xMWQ0U1lWQmZlcTJiUUFNemtCQURCcTNHUURlV0I0aGJoTk0wQlFp?=
 =?utf-8?B?Z083Y0dBbVZOcWtLalVmZXU0WE5NdXl1Ymc4TFJHR0pBSzdiaUJHdTZyNXZU?=
 =?utf-8?B?RVZIVzV5Z21pY3h1ZEYwcUI1a1JlQVlYQnZIQXl0WUg4K3RscFBUSmxIUTFm?=
 =?utf-8?B?WE9TVkhpUVA1aU8ySGVpOEhobFhnWVhPNUI4ZmtPQ3hNNWlIbnEvNHhRT0Z1?=
 =?utf-8?Q?ad/tUWKohBJSA?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 03fc5563-bbfe-4676-9494-08deac3d3b8d
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 13:33:33.5869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR01MB5425

On 5/4/26 1:31 PM, Krzysztof Wilczyński wrote:
> Hello,
> 
>> +not_found:
>> +	if (ret < 0)
>> +		pr_err("PCI: Can't parse parameter: %s\n", p);
> 
> Two issues here:
> 
>    - At this time, when this messages is to be shown, the p can be already
>      at the NULL-terminator, as a result of parsing, so if the entire
>      parameter is some garbage value, then it will show nothing in dmesg.

Thanks for catching this. A simple fix is to store the original pointer at the
start of the function, e.g.,  "const char *orig_p = p;" and print orig_p instead.


> 
>    - This new per_err() is not rate-limited, like the old messages were,
>      so if the parameter is invalid or malformed, and you have... 30, or
>      more on servers and serious hardware, devices in the system, then
>      it will print for every single one of them.
> 
> Albeit, the second issue might not be an issue, and it might have been on
> purpose.  However, I am not convinced it was.

OK. Using pr_warn_once() matches the previous behavior in __pci_config_acs().

> 
>> +	if (*p != ';' && *p != ',') {
>> +		/*
>> +		 * End of param or invalid format. Return -ENODEV so the caller
>> +		 * stops parsing.
>> +		 */
>> +		return -ENODEV;
>> +	}
> 
> [...]
>> @@ -943,18 +960,11 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
>>   
>>   		ret = pci_dev_str_match(dev, p, &p);
>>   		if (ret < 0) {
>> -			pr_info_once("PCI: Can't parse ACS command line parameter\n");
> 
> 
> [...]
>> @@ -6392,16 +6402,8 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
>>   			align = 1ULL << align_order;
>>   			break;
>>   		} else if (ret < 0) {
>> -			pr_err("PCI: Can't parse resource_alignment parameter: %s\n",
>> -			       p);
> 
> For the two above - it was nice to have the information about which
> parameter to what kernel boot option was actually causing issues.  The
> new code will only print a generic message.

Yes, it currently just prints the BDFs that encounter an error. I'm thinking about bringing the caller
info into the log for more contexts, and seems __builtin_return_address(0) isn't a good fit here
due to the possibility of function inlining. If no better options, I'll move the error print to each
caller.
