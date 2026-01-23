Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012049.outbound.protection.outlook.com [52.103.66.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A202FF677;
	Fri, 23 Jan 2026 01:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769130445; cv=fail; b=qFUBopj95J68rFnVg7vtb9aROEGadY6xVVU5ORXH+IaBahT/8mChBtu3nvXo2jOH9lMjTeaftuHcLPGnc38aV3NedtZkZP5ASYwa/6u3QiBkHetv8mPbEQ+Bn79OwhKlun1UvWtol2tICofDbAYHc1os9LliHF3t6UrprULcIrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769130445; c=relaxed/simple;
	bh=VyoyHkMfNx4igR2WtD2QTGWPUjAF+vKVmzT4jwhSeIo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KChKidCLK4mlXwaZ6gu48SNcScy0F3kykKXY7OcGJoES/OdzdRTwF+FStlkHOHoSh24SklV8H8zxw19hEAQdm3+DyG0i0PX0p86YyGhRtDuFt95YJjdLNtxY3c48fSndnfLs2Bx67jDs8NVPdvpb2ZHYyxmaSMqig3JF+fNGd8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=R6pUisd1; arc=fail smtp.client-ip=52.103.66.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="R6pUisd1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTQpqiZ5we/Eo2WlfrorsVDc5iKOaIbGd/h8BQKQes0ex0dHKYUbXMQjzX2dvJKyXMoy30doVhZN9Ur3XeLomcFvOqYlhDEDFChzg0QSegCrem62qdEdsrWGzDiyfaszoN4hBQolrppO2fEKqOYjHX0TU6OsEoSznq8sjB/rlo1lQng9q8G1r2azQpFJElwieiS/SRIbrqCHXiaFtWdcKDnAlslYLUFrpolBijkzSTXCxof2bPtt0jT9oRwO/Kn9z8IP9k7Rxnquo64GPBiP9+FDNgBURMpovodj2ioj4PJf3TC6Taw2oQB7rI/TcfMdwh7bmRdzfwZo/FUlirSnLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7yeTY8lBKM5XvB/DTia5ApnA9ElQShD/QW0wEmwKU4=;
 b=kN8XlPmx4G0hKR6qWP+JDHOcss7xainXP/LOhf7UwlXJkKqox0l7GI2IPz9VRTihtEtYWCETHuPSckofWK42KSjJzOImt3HDM4IX9QHlZVaRr5b9BwsXp1krZNKaZivpyR8GlQSVkcagHs9pj2Qd6VOZ5hS83npAZ59SBek6bVF1+VAcml0Wc8b07Ya4kcb53h3hNYkmOcGlg8dsoGj94PXtgzzr+WwAYIGHrSPzx5qwl699DB2zJO9PwHvc9gS0ByY54+EnZC4xtVEapRlZrZD774KQj0nwoF6foPI8eGqX0p83ILZpCN8SEHVcAmwkZ4Yab3K86Ma1XBiWRuFJOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7yeTY8lBKM5XvB/DTia5ApnA9ElQShD/QW0wEmwKU4=;
 b=R6pUisd1Qdel6ECz8itsKH+8z5lZDg0IWAmFlldStRmC29hRNlaw1L4Z7mpjpGjMFLXxxw//iqY8jaY17jfhV5iyymGv4urUR+G53mSRQqqFFm6UPj5SZGdiA2cjiFyNWDhYwlDyx0m/qE6kDzoxV81/bd34s3SQf0yAjWlkR/cLWUX1CLF4xD8QuC8NUo2BXgoP+TxRvpREUZN9o2X83z2lF3mxBb9LAe6+dE0/IdO5r+snXIDm6qSwLKhqGTDuJ7kDxafzKqgrIQSO09GFWEN/H7zC8ji+A4SNE2nUqeJpFDokVTuLfcHrV3CO+lw0LBdJP3i58SdvHmpGDp6gAg==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by OSNPR01MB7603.apcprd01.prod.exchangelabs.com
 (2603:1096:604:31e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 01:07:12 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 01:07:11 +0000
Message-ID:
 <SI2PR01MB4393B8FFD7BB58420514E9DDDC94A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Date: Fri, 23 Jan 2026 09:06:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PCI: Add support for ACS Enhanced Capability
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: bhelgaas@google.com, akpm@linux-foundation.org, bp@alien8.de,
 rdunlap@infradead.org, alex@shazbot.org, kevin.tian@intel.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <SI2PR01MB43931A911357962A5E986FFEDC8CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20260120164112.GD1134360@nvidia.com>
 <SI2PR01MB4393709A1FFDD137DEBFA883DC96A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20260122153953.GP1134360@nvidia.com>
Content-Language: en-US
From: Wei Wang <wei.w.wang@hotmail.com>
In-Reply-To: <20260122153953.GP1134360@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0027.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::14) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <d873cf49-3bf6-439a-bf19-26490937c7fe@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|OSNPR01MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fec32d2-4b84-4533-c59c-08de5a1bbca2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|37102599003|51005399006|6090799003|19110799012|12121999013|8060799015|5072599009|41001999006|23021999003|15080799012|461199028|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2V1S3o3YXc4aGwyQ1lqVUdSNFhFV3pRL0p3S1RGR252d3NsZW5rdXVlZkN4?=
 =?utf-8?B?UVdGUXBub3RLYmo3L2laSnlkbDJ6cmJtSXYxTFd1Ry9Zc0hhMnZoOE9ydDlF?=
 =?utf-8?B?UGpVUHpIRGg2VlJZc1QzdnZIckpMMzVNZjVOOC9SN29TTXlnSUFGKzZtV0tF?=
 =?utf-8?B?aTcybHFIU1MrRkZQRkhOSjRyeE9KZHRyL1F2T1dkZXJHOGdrbmlZdWNuRSs1?=
 =?utf-8?B?bkYvMGhzSWFYZzByVThCSjZmcnNIQnVHMWpneDZKOUFPWmNFUWl6bFhLY25F?=
 =?utf-8?B?cm1PMGtPYWVlSmxqNGEvcmozZjlMM3VzQ0NBRzhiTTRzU0pNendPN2Z6YTZB?=
 =?utf-8?B?ZXhQeG1PRUNyLzN5K2NNNjAyUk5rM0hTREs1djZja2NnMmhBdWJDSmZ1dXBl?=
 =?utf-8?B?M0VnZGJTcWZxZEw1Q1p1RmhveFJtTW5RdkprWWY2blRPZU96VVZHOWxNcTgw?=
 =?utf-8?B?U2lKbXRiR0U4TUxJdmY0YkowVG9RNElWeFgzQjMzOFRYbVFJNVBlbGFESTJs?=
 =?utf-8?B?VVkyT2VJcEl0ZW00QVg4MklxdFVnY2xzK0pDZGVsYXJodEUwZ2xlcERDdkp4?=
 =?utf-8?B?TXZzSEp3MWU5L2MvREhIaEcxQmxZVi9mUFhQYUliZ3BROE5BUzlQREJlZHIy?=
 =?utf-8?B?Wi96aWNOQmdlL2JHWDl4eXBDUnBGa1F0WE8rbGE4RFNMVDgyYnF1dDNNbGM4?=
 =?utf-8?B?ai83cW5JSTlNVndXMjY5cEtCM1JuaVpkNGxoREZRaUI2UGVCQkNhQ3dtTE5K?=
 =?utf-8?B?dTBmZGpVcWsyRkErRGl2U2oraFZWV3hSK1d6eXVyV1dHR1lkelU0QklCb3Zu?=
 =?utf-8?B?SVJmWit2VHMzYkRuNHRHV1FsSnRXQ1R6WlRvUTdnZkRhc25iRnBjTVRTR1l5?=
 =?utf-8?B?WGNFeFFrb1JZcVRXa1UyRVBzTUF1eHZURGt1N2c5dlBYUVFwOXBkOUU1ZHpL?=
 =?utf-8?B?c2lDSzBqamZ4c24vZzQybVVJbHJjK3YrWXp0a3lFNUc3ZHFkQ2hNK2p2MkZK?=
 =?utf-8?B?cHJPTEhENDdHajlUYzFTWmcvcGNNbjFKelQyazlnQ095NDlpL1dxZmFMbjRL?=
 =?utf-8?B?RW9KbFV0TDB1YlVJKzBFdWZvb0RVLzdpZDFZcW9qTythaTl4bmpDcFFudU5M?=
 =?utf-8?B?OEhiY3h2ZjFJR2RBeTNYWnphc2tkQnBvemRvM1BTVXBmTEpQaXgxa1hERSto?=
 =?utf-8?B?VWtSUXFrc253OHE1MDdVcGpPYWJtdEgwYjJaRGhpWEgzZzI0cHp2WTgzaEpG?=
 =?utf-8?B?K0VHLzRFWlU0RFV3eDBPd3JCZlBYaXNtZVlwMkoya1cwbFZNWVE4YzB2eFB4?=
 =?utf-8?B?MWVLOG12VDhyVTZMN2VnaWFTdVZHWXJqQlRadVFocFB6K0sxekVSY2QrTmY0?=
 =?utf-8?B?U1dXQkpJWUpYM01BdVVNcUxJOStQZ2daWXdJOTBZajVkeXVnbWVyOTNiWTl6?=
 =?utf-8?B?bFczNlZhR2ZvdCs5R09uNDFvTFNnVXZKRUduUGMrVHBNckU3d3pqYXJJakNC?=
 =?utf-8?B?bW9URnErUlJOeHNGUGNEaXVzaU51Zlh0Y1pwcDVXSjJ3d2tOOUw0b2Mrb2lv?=
 =?utf-8?B?cGhvL2J6N09XOG1BU0t2QmZtT0VtZkovdUdXZjdEWFRMYmFjNGh1YlF3QThM?=
 =?utf-8?B?L1c0blZyaXd0dFpNaklCVWdINWhHSFQyc25VUXV3T0lkVlhWTkhMYm15eHNT?=
 =?utf-8?B?SGxuamJFT095MTltVmtScDhnQkRQTlRvSzAxaUpCY0xyL2VkZ0tROXlBMVAz?=
 =?utf-8?Q?6bM7DqobQumUVru36Q=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2diOVlFU2JZdUV2RXJCVjhEK0o0djN3TTlaUzd3VGdPMHY1cWZtK2M0WjQr?=
 =?utf-8?B?eVNOdVBJTEFXa1Y4ZjRjamhxRlUrSU9ZTFpjY1lYMCtSd284d2wyNFc4eFFx?=
 =?utf-8?B?N3RCbjVGblR6cDBiaGZ5UHBWaTNoS3BVUC9ndlNMOTRpWkdVRlR4YWhTd0pm?=
 =?utf-8?B?NU56TU5tRWRJc1Jucm5ZZ1hPMWM0WnlJMzZ3NWx5Qll5R01PbVNPY3JGSW5E?=
 =?utf-8?B?aXFIUFU5NkZjSkErdEhWbTRQdTlmWmcrNzJZdmxrWjY2cjh2ZjVKOCtYY2oy?=
 =?utf-8?B?MVZVOHhhRVR6QW1yWFFydnkrVHZmbjh5eGFzaFBBK0xXUWp6UHNjV1ZQTkJT?=
 =?utf-8?B?RzFTc3VKVkNSTUdrMmFiWjJlY3E0cWFXLy9XZUZaT0hHbDBZVk9Ud0s5ZHRY?=
 =?utf-8?B?d0FkK01MNmpVMnVZZnlPcDdxRmNpeERMMkFzQ1FlOEU4S1dPaXA3blZPSk8y?=
 =?utf-8?B?N0wyOEI3QTBDREl4dU5hTUlyd0R6Q3Y2NnNOTFBjQTR2RXVaZ3d6aUt0bG1D?=
 =?utf-8?B?czVManlWZUxtUEhVdlF5Z05JTTQwc0RVanhmeDY2VnhYUHRMUDJmcTd5NTBh?=
 =?utf-8?B?aDcyL0V6QXZWbFpjM2kxaWs0eVRKSGxpdzY4VUhGOVZ3UDdxd0JmcmtPL0hM?=
 =?utf-8?B?Ym14czMrUGJMK1FQYjQ0ZFhSNThuU3dISDA3UzJVSFRoQ2d6V1drRE5SZXVZ?=
 =?utf-8?B?b2t6NTIzU2JUZ1pUcXBEU0ZzczRkd2FyWTBsMVNBSFdyRE91T2VRQ0dOaVFG?=
 =?utf-8?B?Q21ycWoxMlc4RUNTdHBLWWVMbGR6RUJJS2NFeEhLZll2ZVhISVBoaXBCQlBF?=
 =?utf-8?B?L2NxUVIwaGRZZmd6bHlpQmlqTk9JaDN0QnU5dUZJMU83RjJDVENwRnA1Rm9T?=
 =?utf-8?B?MUROdDVRY2hDUWlBOWhPUmdpOHREUlVOWDR5bGZsbXFFOG5CUFpSYXRhQVp1?=
 =?utf-8?B?cTlHcFlYd1VpNW1ybDhwYVhKL1dudUVZRGE3QVhPbnVhZ25mT0wzUEN1djhI?=
 =?utf-8?B?Tk5YZGpkdlExTkIydTd2b08xVzZFUDd0c2o0TVV4c1hocU1tdmZrendsb0F5?=
 =?utf-8?B?V0d0WXc3N2JCWUc2Z2Rva1Y2VGQyTnQzbEo3V2FPSEdCQlNHbHV2c2VITDZj?=
 =?utf-8?B?c1JSd3lVcFQ5dTRpSmxZcWxZVjFDZ1VTQzhGbmhRYW52RmZ0aU4xZVRkcEx4?=
 =?utf-8?B?N2NiTjlpSHllbStSUHlHRGUyOC9yNkdhbEFoekhVcnlwWVViZFQyc1o2ZXhV?=
 =?utf-8?B?NmxUMm14NEoxMFpYMTl0L0dYdmpxS0RzRUgzeUhmejVJVlJxK0xLakxpVFNW?=
 =?utf-8?B?NW43OTRhTEdTb3ArQWdETW9BNHBXL2VrSGRsYmI5NjROT2pYMGlXTVJQdDhr?=
 =?utf-8?B?ZXJkcDJ1UFlHTzJFemsxS0dXTVNXS21UNnBGS1k2WC8wUGsyYnVOcnN6QTcr?=
 =?utf-8?B?UTNYVytOMjZWZDhrdmtsRDBIMlVXanJNeW5UNHovN3RBZGkybkVHT1A4cDRX?=
 =?utf-8?B?c0laZjZWWjZaYXV0RXg3VkdtTVNhR3dBQmE5MmxzbUE4b1Rtb2hmUUJTY0Rj?=
 =?utf-8?B?MjhlSHBuVTJ5WXVmZ016Yy9xNlg2bitJa0syM1ZQQlFHMFcwMTdtcHo5VkV3?=
 =?utf-8?B?UUxDZHgxUnQxWlY5bGo0T2VZRCtVcU5oQmxvRU1DV2I4ZXF2ejJvRS9QWGpp?=
 =?utf-8?B?RFJOeDEzZU9uaXp4RzhRTlZGUnhFR1BpSnhZdjVJb2p1d1VXQXRxUVBqb1ha?=
 =?utf-8?B?c2JGWFB3WXlFQWRRbHM2N2lXSTZKSkNkdXprNHFaQy9rSWsrWVZlaHIzWXBT?=
 =?utf-8?B?TmEydVE2cXAwK1k4aEZpeFdrS3cxVXZ4Mzd5UlRHcHZYYnRwNXdmRVN0UnFK?=
 =?utf-8?Q?OVUVcXRHHiHr0?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fec32d2-4b84-4533-c59c-08de5a1bbca2
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 01:07:11.7904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR01MB7603

On 1/22/26 11:39 PM, Jason Gunthorpe wrote:
> On Wed, Jan 21, 2026 at 05:18:46PM +0800, Wei Wang wrote:
>> On 1/21/26 12:41 AM, Jason Gunthorpe wrote:
>>> On Tue, Jan 20, 2026 at 02:11:30AM +0800, Wei Wang wrote:
>>>> Add support for the ACS (Access Control Services) Enhanced Capability,
>>>> introduced with PCIe Gen 5. These new configuration options can be
>>>> controlled via the config_acs= boot parameter.
>>>>
>>>> By default, the ACS Unclaimed Request Redirect Control (URRC) bit is
>>>> enabled if supported by the hardware (i.e., if the ACS Enhanced Capability
>>>> is present). This setting is particularly important for device passthrough
>>>> in virtualization scenarios.
>>>
>>> The memory target access bits should be set to request redirect as
>>> well. Linux's grouping logic effectively has assumed the enabled behavior
>>> forever.
>>>
>> Yes, sounds good, thanks.
>> I think the REQ_ACS_FLAGS also needs to include the check.
> 
> That would make a mess, I think leave it alone. I tried to make some
> patches for it once but it is going to be problematic..
> 

What problems did you encounter? I've prepared a new version that adds 
the enhanced ACS controls check to pci_acs_enabled() (not via 
REQ_ACS_FLAGS though). I can post it soon so we can see if the issues 
you ran into still apply.
