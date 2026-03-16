Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011071.outbound.protection.outlook.com [40.107.208.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E711A23A4
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 05:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773638387; cv=fail; b=qttbvh40Iv9eWHdW6Ca+vWzuHvsjkL28iK1iqp/c8RHdCJr/zyT5QTO+8QzwJAlyep0fDFlfbf05NfpzFk3ntkeslarhTL2hK6cXpmqVG7D89gBty6RrewjpxFz7bhhhQazuox6iA06rWTdFk2989+FHt/2kFyK3WgkPN+O9mlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773638387; c=relaxed/simple;
	bh=69uOeb4cIMHMpJVoUNLLo4lArz0oJNJKv4Uj8vUELLc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i6EvWPuWQSC2HDW+avQb4j5nvomA3YHKIV5AxXWf0PjxZQ+nxzP50XDqc9ZkCow1MatoOAFqVqYapR83jZsF9RLIpxUL3mD0UkY8XsSpDFxMNwRepleHemZyDTUnefBctQxgW2hmXB5hXyXs31+nNWRTETcdb7vBVmY6mu2zOYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AtepUR6/; arc=fail smtp.client-ip=40.107.208.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AtepUR6/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ScbKXXMwTOK11D4jHwBcrDBNn38KhZHWDZenlriNF/J5OgArK4EPx8M+RqcFRI+M73poRk8D9RMQ9ofoznhRXMQgYHOudgxtM34n9g+bgvuOLQaklPOKlRvD0Xul9RCmKBjk4XmBIKJa8h/A3glJEusnSpi6beS88yJJ7+yZ731c7jH3KRdMu9KPkmm5FWn7i3atunItYKODmEj257v5ezgPSFA/vIX9y8GvFGqf05Tm+6iUMGdWNvIgT063quzaEVVWZFS0ZAkRo/UzKajb90H2JXhBDNX9vpszMdVaH+QFqydY0dGOG3w7i6KdGGhOA/jRnUGGU84cx8glrrlbOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uetbjVPevf3IgJLzaRsP+54MS/ghD8vfYJnDFDa86wQ=;
 b=JhmZO394LgoeR5CoFn4fVD2jlmo5+a92LpuY21nU88IAkH6hJSGokqNgminycAHdoIZQaWHlLVhOSWtcINMic5CHUTAtIHHbkCuIGuthoo9AUMmbsCJffavcmJbh4KTrVPqri7IoB8fR/10SmR3U8L6Qiyz8ztune08S5ub3RweVyGzahTTV3vH/d15gjpjxMrkX3DwC8q4zh7naZ1mCVNWd6/xWX7jYA65b6t3jY95laQbqI9SIVk7LUT4YgKqyU4Jv8MnvO2XFC1dogXNJUGQn7cQfk1QlI/5lomllFDC18KVmDiQY8lOzU0fdYt+EGNtXJOFw5qnmJ+MwmTAQ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uetbjVPevf3IgJLzaRsP+54MS/ghD8vfYJnDFDa86wQ=;
 b=AtepUR6/GMXKfzO1oFc/+bq3CzTOYvvkxkO2Zd9lb5fUR0Ct+PaHBe8QOLPkspCOfBewoOYdgf/cMtPtuqfCtjs+XaM1TWHHydJh41V+siPz8CsSntQFEzhef1ryt/1h/orBWdMWIyvv/w1OfvR01cUIK3taHGJy96Ldrp1WPDQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV3PR12MB9213.namprd12.prod.outlook.com (2603:10b6:408:1a6::20)
 by DS0PR12MB8019.namprd12.prod.outlook.com (2603:10b6:8:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 05:19:41 +0000
Received: from LV3PR12MB9213.namprd12.prod.outlook.com
 ([fe80::e33:c841:8825:50e1]) by LV3PR12MB9213.namprd12.prod.outlook.com
 ([fe80::e33:c841:8825:50e1%4]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 05:19:41 +0000
Message-ID: <228298b7-76bc-4ffb-bec0-0c35fd487c4c@amd.com>
Date: Mon, 16 Mar 2026 16:19:30 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/19] PCI/TSM: Support creating encrypted MMIO
 descriptors via TDISP Report
To: Xu Yilun <yilun.xu@linux.intel.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org, bhelgaas@google.com,
 alistair23@gmail.com, lukas@wunner.de, jgg@nvidia.com,
 Arnd Bergmann <arnd@arndb.de>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-10-dan.j.williams@intel.com>
 <yq5a4imuanoa.fsf@kernel.org> <abPlt8oNUOqGvbA3@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <abPlt8oNUOqGvbA3@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0115.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:20b::20) To LV3PR12MB9213.namprd12.prod.outlook.com
 (2603:10b6:408:1a6::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9213:EE_|DS0PR12MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c4f9d0f-c6c1-4168-fb1b-08de831ba07c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	1hM/oGijo5LpaVD438rMmHpkM37rBbLZCytCbLYmR2XF3hca/Dn1VuOAfpp9MUmaUOjnvaD4Pnl9C28hZ7CsoaNTpDjdrVYo6xxMgyI9vzKkthFYoolm6RHOi0tubnPLP9p8fWsj/FTSKEjoYTKpXJ85vem5zTkfAyNHU/og0PkWGlBGTzdwgLaQCTQJEh90dxmIJ1RaqMmkMSPIu8HVLWnQLJqd29M9SAyO/Vyqwto6SxLfxOGl2bm5zEoX525/5MyhNrhob8KqoBs4TM0S2CbMaLOfH6gYQWLJrUr/dZADcnHmUFD4zawd02se1E2FWWsGw/mKwnCeUho+mAk2x38qKBDKY2XTXdRvXzvizw+vfbPcXRKualgoSOk+fyLMNQKTCt0oiIE/FeW3D2D+onHKqhYzH1ruVLL3ATzIB0gNDgyDvCJqRKdoPlmDffYWikssilk52n4bw2YiEx029wofFzWOOkUwMOZMmvUUc8wqdxfxxQTXJrkLSA+vLllaFBKwUB0QsomMlEGBxrsgWc9ex2eAL9wegElAeX//70YqpF0U1TDk+9VEqNZMTHDkkAlIiyUcQA6maPv6TXaCyYlC61SqSg9sAkfaltVG0vUd0DjwMuBi0ZKn4G6wK9VtosZgAyOSpOQ3N+l9xErjHZVaB/3gaeon2BSxSiou8BtMUlfhqvOUbm644ZunRcp4rMmaI4Pye+VDHszcb32MwMUA8jq+8/Jd1H5gOktfZf0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9213.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkVqTEFRaFBaNStOTEpoTDJTU1pGeXo3cjVSK3BRcmUwTzZJM1Z5VFVVV0xk?=
 =?utf-8?B?ZzNLS2JzbGNmNUxZZzlBMFZuWXVDdi91OGxOL0M0UEZNQnVmbkZYT1l5SllH?=
 =?utf-8?B?TDdUQVhsRDNzV2tXSkFiTGtWbkJKN2p0UTFTN3IvYytiNmVSdGRIbW9LOHpK?=
 =?utf-8?B?TERtS3c3YnlXVmtGM2x2R1M5UVlKYlJaeDlIRmNDQng0MndjdjJWS3l1Slhu?=
 =?utf-8?B?VWdWc1FnTTg0WDZHTjk0TDRBeURQd1IwUEVEdlh5QWtGQXU0bVl6V2tuTHNR?=
 =?utf-8?B?RVpxTUROTVYwd1kvSTNNeHZGN3lBUkRxNWltNFRCenBrdFJkSkhwRmxPbEdN?=
 =?utf-8?B?SVNOdU4xNFFQckZNZ2p5NjJrbnN2MEhEaGRpdEExWFdMUUt2dWoyZUVCWmJL?=
 =?utf-8?B?YXRjdzA5YnhCcUQ3TUJvUFBrOVZLTmIyOUJleEM0TGc2UzRicFZnVW1QME01?=
 =?utf-8?B?bURSdUgydTlEL2RscHFYTUl6c3F6cENHb0R6b25RQlVNUjlmcG83SGltRTY5?=
 =?utf-8?B?dnNva1ZEUUFKWFVJemE2aTROMzR2R3phWVN2RnRNRTdFd3oreVZkU3ArdEwx?=
 =?utf-8?B?NkMrcTlHcGJTSmhKZVNSMDlhdjdvWUdDNThKNU5iWDd5WDd0WFFYTWlCVmVi?=
 =?utf-8?B?L005V24vaHl6UHM2ZFlKa3ovUStQdmo0b0I3UklHL3ZQa3gzMitPODcwdjJU?=
 =?utf-8?B?dVJJT0dZWGpmSGFiNHBieHM5Vng0eXh5TkhGUTV2bUlFWWsyVkhyL0hYYmJw?=
 =?utf-8?B?dUQ5RTJaeDFObFdnYVRYWnZ0ZUFRL1kyeXZEU25ydjZRVThjOFJCQmtPcTJE?=
 =?utf-8?B?NnpPWktNRVJ3KzVrbWs5aFpLVXVFTHprSlp5THYwd09NNkZXZW43cFQ0NStW?=
 =?utf-8?B?ajAyQTNZbmVQdWd1bldjR09PL2xjdW5MT1N1VzN6cGxwaHJ4VmEwNGlOV0Jz?=
 =?utf-8?B?aXpRUk91NEt6NGJKVzM0bGxrOGVhYXZNd3hZNFVFU1RFd2FWODJUTU5mc3pS?=
 =?utf-8?B?SG9tN0xIYTFSSUFqbU05UWJvTkRWUGloUTFwbGs1MzJYS3J2dVFoeU1Yb3RK?=
 =?utf-8?B?ckVJMXhyeXcxZW1OL0E4dFMwUi9laGpLL21UNTg2RWdSallvb3pOV3NSNm45?=
 =?utf-8?B?bjZNeW5waFZuVWFQMWk0VDBkSitTMk5aWWdPVUhJQWpSbnEyZnQ4Nm5SM29q?=
 =?utf-8?B?SmtVM1lTSGNTSWp0ZEg2b0NyWVRJYkN6UHcvSTEyVTRuRllmQk9rKzRpem0z?=
 =?utf-8?B?dkhLMDdFSDFUOGczcC9RbVdpT2JSSitVcmpMUnBBdmZheC9HRkp1Wmoxayth?=
 =?utf-8?B?eEY2NlNXd2VmY2g2RTkxWTEzS2VqL3JtZVpQYzl4Y01mTkFEc0VIZGNLODJI?=
 =?utf-8?B?SVRudVhyTGVXRExXUU1YY1ZUOXdia3hDVytGZmJMbkJhdVJqYmpxdmtwQnFl?=
 =?utf-8?B?Q3ZablVuaDV4WHVVTkk0RXMzWHFXdGs4SmRLcFhTNVdQRVhaamlPYXpmdGRF?=
 =?utf-8?B?Vitoai9YSDg2UVlXTG0yS3k3NzNrNzg2UEE3a3dld1M1bW0zaXYxWVJRU2RI?=
 =?utf-8?B?V2hxeGhBNERxcjVVV2xwZnJpY29Ucm5HbnFRRkRVbjNkOWNJeVd4QURuTjlo?=
 =?utf-8?B?SFpPNzFGdmpsV3AxcG5aNmMyOTFRY29IK0lDb1ErdWEwb2FxTCt4UXhzNkFo?=
 =?utf-8?B?K0tFTkFVaW5hazVUYXA3UzVyZ0x5cVUwVVVpWTU3M1NwR2pxVGhlcGdkd2Za?=
 =?utf-8?B?TFZmcmY4MDBhWE1IU3FFU2oybmZadHBGVmJMakxlc25XN0RaT1NPOXVHdGRC?=
 =?utf-8?B?QzRDYmlFc1c3eDJiNjd3Q2E5SERKYWErbm9MT0xsajM4NDNZWkdtSnlmeVky?=
 =?utf-8?B?MnVFZEpCbjJka3dqVktkdTVRRk43Z1RHYVpjWDVNVEYrZW03RktzZkswQUph?=
 =?utf-8?B?ZGhKVUVaT0ZYK0NVMFozZ3MzUjgyNW0rbGpXT01pekNqMWh4T1dkU0FpUlZM?=
 =?utf-8?B?RzN0Y0ZzV2FpeFh4NWNtdy9SOG16cGpYRitWQzJUQ20rc1hPYUtDYmw5UWtO?=
 =?utf-8?B?R3k0cm9oc2NiaDNNUW1zbnQ2emx1cnoxRXAveVE0bUlYalNIdWRHWk9PaEt0?=
 =?utf-8?B?QnZTNzhOV2wraXNhUTNqeVJKVnJBRDA1L1lCTzc0S3RwRWNyVkJnMlNzUnRk?=
 =?utf-8?B?cGpQSmRtTzVnd1hHMHlkM3dEYmhDRDk2TTJlSUNxd0xSNmdLeGcwT3FpWm5W?=
 =?utf-8?B?Q2Zod1ExU0pJRGw2YnZFTDczb2hheVVUdnFTRGpWT0J1SVpxSTZneW5IMk1H?=
 =?utf-8?B?ZnpTYjFHWjJhS0xkelJhei9Idmo5VWgxSUc4U2p3REx1TzJ1VzVNUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c4f9d0f-c6c1-4168-fb1b-08de831ba07c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9213.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 05:19:41.5940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8a4JOJis4H8G5PliIEwEhFQLCxTL1s4EN8PmL7xFX9Pr3GuVpOFRqWWcXhYNfFKbmg0TB5kLEY6Ab3EeDTJ/0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8019



On 13/03/2026 21:23, Xu Yilun wrote:
>>> +		if (last_bar < bar) {
>>> +			/* transition to a new bar */
>>> +			last_bar = bar;
>>> +			/*
>>> +			 * The tsm_offset for the first range of the BAR
>>> +			 * corresponds to the BAR base.
>>> +			 */
>>> +			reporting_bar_base = tsm_offset;
>>> +		} else if (tsm_offset < last_reporting_end) {
>>> +			pci_dbg(pdev, "Reporting ranges within BAR not in ascending order\n");
>>> +			return NULL;
>>> +		}
>>>
>> ....
>>> +		range_off = tsm_offset - reporting_bar_base;
>>>
>> range_off will always be zero? Should we do
> 
> tsm_offset comes from Device Interface Report, MMIO RANGE, First 4k
> Page.

It is not the first 4K though if the actual first 4K (or whatever) of that BAR is MSIX which the device is mandated to skip in the report if MSIX is not "locked".

> How do you interpret the exact meaning of this field?
> 
> My understanding is, it is the obfuscated host start pfn of this range,
> if this range has offset to the BAR start, this field should also be
> offsetted.
>
> But if the first range in the BAR should be aligned to BAR, otherwise
> there is no way for guest to position the range in the BAR.
>> So the logic here is:
> 
>    reporting_bar_base:	the first obfuscated pfn for the BAR, the BAR pfn
>    tsm_offset:		the current obfucated pfn for the BAR.
>    tsm_offset - reporting_bar_base: the offset to the BAR.
>>
>>   		range_off = tsm_offset & (pci_resource_len(pdev, bar) - 1);
>>
>>
>> So that we correctly handle if the interface report is reporting a range
>> within a bar. The only requirement here is bar address should be aligned
>> to its size and mmio_reporting_offset should not add offsets in that range.

and btw this only works if the entity generating the MMIO reporting offset (==TSM) knows about BARs sizes, which is not the case for AMD - the FW has no access to the config space (so the HV needs to feed this to the FW? may be). Thanks,


-- 
Alexey

