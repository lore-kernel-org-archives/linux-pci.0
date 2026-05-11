Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012070.outbound.protection.outlook.com [40.93.195.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4EC3A168E;
	Mon, 11 May 2026 12:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778503920; cv=fail; b=AO3y8aMwx7JH4Mrx2h/T+MuelhlA1C15qnLZ9mDLe1OJpvt5BGidRsduaZxp3HpQHNKlTH+d77ObC0rz//1DhMD7bE/qB4/q35J0MffwsLXsBqueLSfRnSCqfMjoqbUtTmT8h6dklhyHLbePk/5EikGg36NrPAUb6fSxxOw8BaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778503920; c=relaxed/simple;
	bh=AkuP20VptB2kjDH+KqqVESFnMwxF5voXeiDtA25P0WM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J19Hb/V97ENhEV1UxW22vC1l/gFyk+N4pLlKO1ig7SHp80ESI2AF3vG4swFU4RZYBU81TL8D1o88cz0Myb82MhdgDnF0eQ4A3YP4ORRp4PgpYKbZGnJgO+/jRentPAkwBaP7/EnLARdRCZckueF0M7DE7eYZKxExB1zl+H8d0zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wVbJQTLA; arc=fail smtp.client-ip=40.93.195.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wVbJQTLA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5mvYFJp2MJBczPCrBJPyiL9FrhEwcFjVzbzG4LfkK9B5eHTQOnxqs56Aue56UMJJMME+7s+bO3ThwtKoo1RLl//x/vBxOs4Bz376rnCputHYbUeAN0teqKMKp+yOTtDIaH+uevMCeCyYvR3kvoALAsWkPqXqKEqOEAoCHof8x2GZp49Crfg6scwMEBXW5xT+EL6A9kjYYGSqqolAL7BX/tDq9mhz+54XMd+xx62g5QvqWl0qMSbqO3cyKDPvzvTADTQXp7hn2u5O6cae45cxNKmKxJZISs2m0dztOKnD/nbJeKMY5BD1pfxdM0MN0s8M8EVsBAKmSkw1cCX5lhC9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYQ/27qxyDAAcyzlzNdCjW7C48XEZq20UMtCi03ww/I=;
 b=TAoM+rQUQQKSjuTUHPJNWCyrQBHK3J9kRrrztN5QZ1HFO+KIYi2J30BasGZEck/Wn2BKRFZheJuFbKL4C05FKVQKCV8Ze/mG7MHidA218fxWfZ/mtIHG0M/O9HStgp1obmYg+otc+b1FbRLy8T3EWJMrGfepF9289vVY0PmsZeI5+XqtDd2okaC68osZc228nj16W1nB/Kp9w9hu7ktz6obKqb4UrYUna4DagOEWP0IoMUOajCqPkENla4RtAD2iYPEKzXnh9PYJXz20hGk3drxBtaRsTBk5Zgm+gjaMy4D5nTtHsI3jreB3hLD/8lDQrCRcJ8/47DxlOUoOBumyNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYQ/27qxyDAAcyzlzNdCjW7C48XEZq20UMtCi03ww/I=;
 b=wVbJQTLA9KOeMEKTTk64xhnkuMpj97oZ2nSh1k4lFiS+tJeLdXT1WvmK+cjZrOu2ZSQXgqdiWUKIATjJXhXXV9NBkpUDfU9BVa8pNDsQUrJ7sjqoEHjJ0pPO/jkVA3g8bFGU5ERd54WkEIotjZLTr3jteUDsoLNNrAw+iOTQXnY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by MN2PR12MB4421.namprd12.prod.outlook.com (2603:10b6:208:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Mon, 11 May
 2026 12:51:55 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 12:51:55 +0000
Message-ID: <09796934-e093-44e6-b6e2-2d0dd5a29673@amd.com>
Date: Mon, 11 May 2026 07:51:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 02/11] cxl/ras: Unify Endpoint and Port AER trace
 events
To: "Dan Williams (nvidia)" <djbw@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, vishal.l.verma@intel.com,
 alucerop@amd.com, ira.weiny@intel.com, corbet@lwn.net, rafael@kernel.org,
 xueshuai@linux.alibaba.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20260505173029.2718246-1-terry.bowman@amd.com>
 <20260505173029.2718246-3-terry.bowman@amd.com>
 <20260507190836.70197e24@jic23-huawei>
 <8913c666-a343-4717-8ab2-0b8546d1bdfb@amd.com>
 <20260508150533.04e19cf9@jic23-huawei>
 <69feaebd471c3_1b86a100b@djbw-dev.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <69feaebd471c3_1b86a100b@djbw-dev.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0021.namprd05.prod.outlook.com (2603:10b6:610::34)
 To CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|MN2PR12MB4421:EE_
X-MS-Office365-Filtering-Correlation-Id: 99bb5ae2-526f-4ae0-1b9a-08deaf5c14d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|3023799003|18002099003|11063799003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XTgAx5WTEbfDp8myya26lwA875ERJPXndZ2foCnwxWdiqVfHWJUJ0jEeu+WYDu5VKgLyaWusLsEDXMHbEDDS5i54yZtJmgkhWh2hftk3LNawEkhr8QjLadKYZuZ5T9cA2NM+PKiJrQBtJoZ/E+i5soNXOCqf5XW4X/1kGewiWR2nyAwGyGwQrpT0mLnnovkUIhlkSSDAuyvY8qjxp3rvJK1hUIaAeOy4TeKeFdENrm4+6Xv1oyes8EDGriAI3EZ/jqhiI2rmscz88rhZrL2cir+Hr4iUV3gyWMrMpE8tWbv+lLfn9oH89fTLDiRkFzlQlumYSc6y0vqWgC1H3BZ4XXuxRvyV3JXhlN/zSrThYtD9HJ9+YaFIl17+adEJbfwgFzcFE96oqtzx+OWOwgrN+6uSVYdCuXksJSbdCDCFzAy3q/pOdBI+xWPrb8QE6hDatQqWESiYCXA6Vcp0tQacp5lqG+H0bvIPeR+Q8NM1v2Q0QBoJN54ynFJ5MEHUC16l7LdkUJzzmNMZ+LWDAN7uH4Yj3HTrHMWb4zvXfZEKR1nQi2BE39HmRuem/vxzijEFT2XnVyB9iWWq4WwjfbAqRQIeWwM2Hvlo+W8GIfPxB7bDnWQBcz5w1F5OkbmPG8E86VjoOJsaRzYOB7wHqizdTO8HegeQmDKYenxe4UGpT7LZPgAL7oBdVjCjLgwxDC/MNPtXVnOXJ7GJrWQ7pbKBHg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(3023799003)(18002099003)(11063799003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXNwMDFxRW84UUtiQTdYbVlrakpPdnJqMHhzT2dmT3EzekZoLzN5VkJCdmoz?=
 =?utf-8?B?dlVUSWJlcDlKUk8wcjhQZk41MktmdG5iWHE1RnRPMkh1R2FPQWxFcmQzOGtM?=
 =?utf-8?B?MFRHQVpVSFZCSDZTcHZWNXQvUDRQN3RsRXgvK1NFa1lNZTVGeUM4dm1hclpG?=
 =?utf-8?B?eGJPUUdLUW5yU3ArQkR3UDVXdVdhZXo5cHlCdlJPTmtQZGl5MTI1d09zQm1T?=
 =?utf-8?B?MVpKLytUVFJzMUVRR3JvMFpoVG0xaTNDZHRveWV3M2FDcE01aERtVW5yYTl6?=
 =?utf-8?B?Ri9HdmowSWZVc09FdTRXMlJhdnlWSXBrRE9MWWpDQ2NXS2pMY21FRkFJbGpw?=
 =?utf-8?B?akR5U3lURHZJNVJ5MWtyYnVob3FyNzBDVnFpLzhFY2RXdXNydXdhcTM0MGk5?=
 =?utf-8?B?bWJENUVRSHNLbmM3QXMzcUpOYmpZdWp4RVZTWFQ3TUhnaEZqQUpnZjI2Q2pi?=
 =?utf-8?B?bXJlUFVLbXJVRldKZFNrVFpQWXA1ZS9CUGNpbXFQWkdydDB6cTM0MnFxcEgw?=
 =?utf-8?B?QWQvc3NJR1UvalBCbkVsR0FWNTFYc0lLbDByRlY2YzdzdzVPSUtHTlhiemt3?=
 =?utf-8?B?RGt4Yzc0NGkvZTlVcG5xY0lvSGt0cTlyVnNOcFJucTRFYm0xcVAxZks3ZzRr?=
 =?utf-8?B?NTd0RW8wUUNxR21CenZTbC9SZ3VjTW1FWXVCTFB4ZU92bCszMkJrUG1TWE1h?=
 =?utf-8?B?V25wMDZGYTJla2NidHVKZ3dVSzBOaXdzOVRxbFZCNWZ1Y01BK241Z09vRHJB?=
 =?utf-8?B?Sm8wRi9pTWZRWjJDYnhmTFZ2Q0s1eFprVVRrNEFRcUxmZmxqVUFna0JwQndD?=
 =?utf-8?B?QmlXcStpUjZIejNTZTF5OEoxcGFOUjVhalh2bmtadEd5NUtlYk9ZT0JRMFRZ?=
 =?utf-8?B?MEdua2V4OTdMQXlTT0treEoyZnpES2gwRVFIQVE0QWh0cldYZFdjQm5XbFpX?=
 =?utf-8?B?MS82TVJ1RlRHNFdCNmxreCtzQU1KanVKSVpOMERpbmRzQnVRVHFDbndtTG94?=
 =?utf-8?B?K2Z2eDhlWTk2cXFONTlsb0M2OGxRVkNPQituUDFIOWFhRHF3Uk9RcTE1azZy?=
 =?utf-8?B?bTF3L01xWmtLUDhwRTZhd1ZzcXlOME5zZFZBQnlVdHNoTndtTjF0SmZ3VVpT?=
 =?utf-8?B?UDd4ZzBQbXdqTmRkUDNwMm5uZUJDY0QyRHpNRGhPVnZybitRaEs0c1JLRTZv?=
 =?utf-8?B?bmJRUzBwdHZLMjVHQ3FWMVp4UHhTWSt0NWFSeklVUG9qNkVkMW1BU1hYZ2RK?=
 =?utf-8?B?ZFpZTEdsR1U4WktrcW9tWHIzYXYzNEQrdXF4eTFIRDB5aWFYdVpVazAwMmdu?=
 =?utf-8?B?elQ1R0FmKzZDeWl2VTA3TUFZOUREcnArNmt3VEpFZmV6c3dzVlo1U1huRE9t?=
 =?utf-8?B?c01FN2FLWTNySmJNWGsrV1oyWDVKbHBITnFwek1tbDErNDd6QjBXWDFrZ0xI?=
 =?utf-8?B?YXZyWmdEM01LbkF2bzJEdFVHUWU4S2xxSGhhSjdlc0xPamR0WnFCcW5xOW1H?=
 =?utf-8?B?QWtUTldCNHlVQWhLdXFIYkRXdlE4QUk0Vkpaa1ZrWE1xOC9ieHNDNUYyNnFE?=
 =?utf-8?B?cFF0a0tBRzZrTzJDa0xGUVR3NUQ5a3NCRGJhdHg4WUtMVTc1TXhyOVIrOGVi?=
 =?utf-8?B?TUdlenRSaHVmT3o2d0xZL1FaR2M5bHhzeXNSMjF6SHhCVW94MWQrOHpjYkJr?=
 =?utf-8?B?Ym91Qnp5a1FPWHplbDQxK1c0dnk3ZlloYmdtMjRKSU9zc3FkaUdTUUZIUFV1?=
 =?utf-8?B?c3ZMc1ZXakVBMFBRTnRSdStEMW43U3htU3c2bDh6bE1aTEN3blRZc2tkcnpY?=
 =?utf-8?B?MTFsZytYYllRVVVpemFxMXluajdjUDRWdWFiWEhSd21EUktTQ2VWa2htTkdM?=
 =?utf-8?B?eEsyLzV0S0N3OStTMk9OTTBOQWZ2MithRnkrTGZ0RS95Mi9EclpKdnl3ZHpl?=
 =?utf-8?B?NXhvSVRzd0F6Sy9iYkxLM2REUE9GZlJuZjQ1citoSVpWVmRmNldSaEZzdldw?=
 =?utf-8?B?eTRmdW9YbXNlVTV6bjJOU1owUXZSOTFmMGZhTmZRY3J6S0Y5WnpVRFp4NmQ4?=
 =?utf-8?B?RDZmdlBxNEE1Z3E1SFVpbzlwNUtjVjlLdEtjQXIxQ3RSQVJHT1RCMmlSbDd5?=
 =?utf-8?B?ODcrNDBxWHc0Z0pQeDBTUFp0ME1XRGQ4b3RhUFNndDNxc3k5cHpoalREN1cw?=
 =?utf-8?B?aW56V1cya2tGdTd5azk5cXdHYzlIZHQxemFpTEhDNkx2bnlQclQyUk4rdlZ2?=
 =?utf-8?B?THorZ2NyMkUwOFRpTFhjUGZhT25JOGsrNHk1UzVwSVN3RDYxQXFicytaV3F3?=
 =?utf-8?Q?k8b4Tqlt95TCSC7SsV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99bb5ae2-526f-4ae0-1b9a-08deaf5c14d8
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 12:51:55.5996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: frjAC3HSH46VfRZvvbz5ae74jt42BJYycmDlDQB9p/Uab94qMkARzcQx4OOHuo7nAVJj0uuYdd2VNbD80CduTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4421

On 5/8/2026 10:49 PM, Dan Williams (nvidia) wrote:
> Jonathan Cameron wrote:
>> On Thu, 7 May 2026 13:33:45 -0500
>> "Bowman, Terry" <terry.bowman@amd.com> wrote:
> [..]
>>>> This concerns me (sorry I wasn't paying attention to the v16 thread).
>>>> It is a userspace regression against code that is out in the wild and typically
>>>> not updated in sync with the kernel.
>>>>
>>>> If you are suggesting breaking ras-daemon at the very least +CC the maintainer.
> 
> Sorry, that was not the intent, see below.
> 
>>>>
>>>> To get to a unified tracepoint add a new one that does what you want, but
>>>> maintain the existing ones as well.  Userspace can then migrate and maybe
>>>> in 5+ years time we can delete the non unified ones.
>>>>
>>>> No actually comments on the code, just left it all here for Mauro,
>>>>
>>>> Thanks,
>>>>
>>>> Jonathan
>>>>   
>>>
>>> Dan was clear about using a single set of CE and UE handlers for all CXL RAS 
>>> protocol errors. While I understand there may be concerns, please direct any 
>>> objections to Dan and clarify what changes are required to avoid this 
>>> repeatedly going back and forth.
>>>
>>> [1] https://lore.kernel.org/linux-cxl/69cb2d5ba3111_178904100b7@dwillia2-mobl4.notmuch/
>>
>> Sure - Dan's on this thread so I'm sure he'll see it sooner or later.
>>
>> Perhaps I'm missing something that makes this less critical than it appears.
> 
> No, it is breakage and a thinko on my part on the advice to Terry on the
> backwards compatibility rules for tracepoints. At the time I was only
> tracking data type and order of the payload. I.e. string at same
> position. However, the name of the argument is ABI.
> 
> Something like this incremental fixup I think gets this back on track.
> It keeps legacy ABI support for "memdev" field in the payload. It
> incrementally lets updated userspace understand "port" and "dport"
> events. It stops us from growing a new set of events just to update the
> arguments. It enhances the CPER events to now handle switch ports in
> addition to endpoint ports.
> 
> The bulk of the change is passing @port and @dport to the CXL trace
> events instead of a plain @dev.
> 

Thanks Dan and Jonathan,

I have a few questions.

Does this miss logging the Upstream SwitchPort device errors? Add another 
entry "uport=$"?

How does the user know which of the devices (memdev, port, or dport) is the 
erroring device? Do the traces need another string variable inidicating which 
device triggered the error?

And, I need to confirm: the Endpoint is NULL unless the CXL Port is an Endpoint 
Port?

-Terry


> -- >8 --
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index ff39985d363f..ed3a56966369 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -183,9 +183,10 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
>  #ifdef CONFIG_CXL_RAS
>  int cxl_ras_init(void);
>  void cxl_ras_exit(void);
> -bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
> -void cxl_handle_cor_ras(struct device *dev, u64 serial,
> -			void __iomem *ras_base);
> +bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport, u64 serial,
> +		    void __iomem *ras_base);
> +void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport,
> +			u64 serial, void __iomem *ras_base);
>  void cxl_dport_map_rch_aer(struct cxl_dport *dport);
>  void cxl_disable_rch_root_ints(struct cxl_dport *dport);
>  void cxl_handle_rdport_errors(struct pci_dev *pdev);
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 6f3957b3c3af..3857d2fc279d 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -49,20 +49,24 @@
>  )
>  
>  TRACE_EVENT(cxl_aer_uncorrectable_error,
> -	TP_PROTO(const struct device *dev, u32 status, u32 fe, u32 *hl,
> -		 u64 serial),
> -	TP_ARGS(dev, status, fe, hl, serial),
> +	TP_PROTO(struct cxl_port *port, struct cxl_dport *dport, u32 status,
> +		 u32 fe, u32 *hl, u64 serial),
> +	TP_ARGS(port, dport, status, fe, hl, serial),
>  	TP_STRUCT__entry(
> -		__string(device, dev_name(dev))
> -		__string(host, dev_name(dev->parent))
> +		__string(memdev, cxl_trace_memdev_name(port))
> +		__string(host, cxl_trace_host_name(port))
>  		__field(u64, serial)
>  		__field(u32, status)
>  		__field(u32, first_error)
>  		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
> +		__string(port, cxl_trace_port_name(port))
> +		__string(dport, cxl_trace_dport_name(dport))
>  	),
>  	TP_fast_assign(
> -		__assign_str(device);
> +		__assign_str(memdev);
>  		__assign_str(host);
> +		__assign_str(port);
> +		__assign_str(dport);
>  		__entry->serial = serial;
>  		__entry->status = status;
>  		__entry->first_error = fe;
> @@ -72,8 +76,9 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>  		 */
>  		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
>  	),
> -	TP_printk("device=%s host=%s serial=%lld status: '%s' first_error: '%s'",
> -		  __get_str(device), __get_str(host), __entry->serial,
> +	TP_printk("memdev=%s port=%s dport=%s host=%s serial=%lld status: '%s' first_error: '%s'",
> +		  __get_str(memdev), __get_str(port), __get_str(dport),
> +		  __get_str(host), __entry->serial,
>  		  show_uc_errs(__entry->status),
>  		  show_uc_errs(__entry->first_error)
>  	)
> @@ -98,22 +103,27 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>  )
>  
>  TRACE_EVENT(cxl_aer_correctable_error,
> -	TP_PROTO(const struct device *dev, u32 status, u64 serial),
> -	TP_ARGS(dev, status, serial),
> +	TP_PROTO(struct cxl_port *port, struct cxl_dport *dport, u32 status, u64 serial),
> +	TP_ARGS(port, dport, status, serial),
>  	TP_STRUCT__entry(
> -		__string(device, dev_name(dev))
> -		__string(host, dev_name(dev->parent))
> +		__string(memdev, cxl_trace_memdev_name(port))
> +		__string(host, cxl_trace_host_name(port))
>  		__field(u64, serial)
>  		__field(u32, status)
> +		__string(port, cxl_trace_port_name(port))
> +		__string(dport, cxl_trace_dport_name(dport))
>  	),
>  	TP_fast_assign(
> -		__assign_str(device);
> +		__assign_str(memdev);
> +		__assign_str(port);
> +		__assign_str(dport);
>  		__assign_str(host);
>  		__entry->serial = serial;
>  		__entry->status = status;
>  	),
> -	TP_printk("device=%s host=%s serial=%lld status: '%s'",
> -		  __get_str(device), __get_str(host), __entry->serial,
> +	TP_printk("memdev=%s port=%s dport=%s host=%s serial=%lld status: '%s'",
> +		  __get_str(memdev), __get_str(port), __get_str(dport),
> +		  __get_str(host), __entry->serial,
>  		  show_ce_errs(__entry->status)
>  	)
>  );
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 776c50d1db51..83e161d48405 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -101,6 +101,12 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
>  	return is_cxl_memdev(port->uport_dev);
>  }
>  
> +/* trace-event helpers */
> +const char *cxl_trace_memdev_name(struct cxl_port *port);
> +const char *cxl_trace_host_name(struct cxl_port *port);
> +const char *cxl_trace_port_name(struct cxl_port *port);
> +const char *cxl_trace_dport_name(struct cxl_dport *dport);
> +
>  struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
>  					 const struct cxl_memdev_attach *attach);
>  struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index b45e2b539b5f..33e78f155916 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -8,16 +8,20 @@
>  #include <cxlpci.h>
>  #include "trace.h"
>  
> -static void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev, u64 serial,
> -					 struct cxl_ras_capability_regs *ras_cap)
> +static void
> +cxl_cper_trace_corr_prot_err(struct cxl_port *port, struct cxl_dport *dport,
> +			     u64 serial,
> +			     struct cxl_ras_capability_regs *ras_cap)
>  {
>  	u32 status = ras_cap->cor_status & ~ras_cap->cor_mask;
>  
> -	trace_cxl_aer_correctable_error(&pdev->dev, status, serial);
> +	trace_cxl_aer_correctable_error(port, dport, status, serial);
>  }
>  
> -static void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev, u64 serial,
> -					   struct cxl_ras_capability_regs *ras_cap)
> +static void
> +cxl_cper_trace_uncorr_prot_err(struct cxl_port *port, struct cxl_dport *dport,
> +			       u64 serial,
> +			       struct cxl_ras_capability_regs *ras_cap)
>  {
>  	u32 status = ras_cap->uncor_status & ~ras_cap->uncor_mask;
>  	u32 fe;
> @@ -28,10 +32,12 @@ static void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev, u64 serial,
>  	else
>  		fe = status;
>  
> -	trace_cxl_aer_uncorrectable_error(&pdev->dev, status, fe,
> +	trace_cxl_aer_uncorrectable_error(port, dport, status, fe,
>  					  ras_cap->header_log, serial);
>  }
>  
> +static struct cxl_port *find_cxl_port_by_dev(struct device *dev, struct cxl_dport **dport);
> +
>  void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>  {
>  	unsigned int devfn = PCI_DEVFN(data->prot_err.agent_addr.device,
> @@ -40,19 +46,26 @@ void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>  		pci_get_domain_bus_and_slot(data->prot_err.agent_addr.segment,
>  					    data->prot_err.agent_addr.bus,
>  					    devfn);
> +	struct cxl_dport *dport;
>  
>  	if (!pdev)
>  		return;
>  
> -	guard(device)(&pdev->dev);
> -	if (!pdev->dev.driver)
> +	struct cxl_port *port __free(put_cxl_port) =
> +		find_cxl_port_by_dev(&pdev->dev, &dport);
> +
> +	if (!port)
> +		return;
> +
> +	guard(device)(&port->dev);
> +	if (!port->dev.driver)
>  		return;
>  
>  	if (data->severity == AER_CORRECTABLE)
> -		cxl_cper_trace_corr_prot_err(pdev, pci_get_dsn(pdev),
> +		cxl_cper_trace_corr_prot_err(port, dport, pci_get_dsn(pdev),
>  					     &data->ras_cap);
>  	else
> -		cxl_cper_trace_uncorr_prot_err(pdev, pci_get_dsn(pdev),
> +		cxl_cper_trace_uncorr_prot_err(port, dport, pci_get_dsn(pdev),
>  					       &data->ras_cap);
>  }
>  EXPORT_SYMBOL_GPL(cxl_cper_handle_prot_err);
> @@ -222,13 +235,12 @@ static void __iomem *to_ras_base(struct cxl_port *port, struct cxl_dport *dport)
>  
>  static void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port, struct cxl_dport *dport)
>  {
> -	struct device *dev = &pdev->dev;
>  	bool ue;
>  
>  	if (pci_dev_is_disconnected(pdev))
>  		panic("CXL cachemem error: device disconnected during UE recovery");
>  
> -	ue = cxl_handle_ras(dev, pci_get_dsn(pdev),
> +	ue = cxl_handle_ras(port, dport, pci_get_dsn(pdev),
>  			    to_ras_base(port, dport));
>  	if (ue)
>  		panic("CXL cachemem error.");
> @@ -238,7 +250,8 @@ static void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port, struct
>  	pci_aer_clear_fatal_status(pdev);
>  }
>  
> -void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
> +void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport,
> +			u64 serial, void __iomem *ras_base)
>  {
>  	void __iomem *addr;
>  	u32 status;
> @@ -250,7 +263,7 @@ void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  	status = readl(addr);
>  	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>  		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> -		trace_cxl_aer_correctable_error(dev, status, serial);
> +		trace_cxl_aer_correctable_error(port, dport, status, serial);
>  	}
>  }
>  
> @@ -275,7 +288,8 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>   * Log the state of the RAS status registers and prepare them to log the
>   * next error status. Return 1 if reset needed.
>   */
> -bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
> +bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport, u64 serial,
> +		    void __iomem *ras_base)
>  {
>  	u32 hl[CXL_HEADERLOG_SIZE_U32];
>  	void __iomem *addr;
> @@ -302,7 +316,7 @@ bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  	}
>  
>  	header_log_copy(ras_base, hl);
> -	trace_cxl_aer_uncorrectable_error(dev, status, fe, hl, serial);
> +	trace_cxl_aer_uncorrectable_error(port, dport, status, fe, hl, serial);
>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>  
>  	return true;
> @@ -358,7 +372,7 @@ static void cxl_handle_proto_error(struct pci_dev *pdev, struct cxl_port *port,
>  		cxl_handle_rdport_errors(pdev);
>  
>  	if (severity == AER_CORRECTABLE) {
> -		cxl_handle_cor_ras(&pdev->dev, pci_get_dsn(pdev),
> +		cxl_handle_cor_ras(port, dport, pci_get_dsn(pdev),
>  				   to_ras_base(port, dport));
>  		pcie_clear_device_status(pdev);
>  	} else {
> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
> index cbd02cabefbc..1bcd3c491aaa 100644
> --- a/drivers/cxl/core/ras_rch.c
> +++ b/drivers/cxl/core/ras_rch.c
> @@ -113,9 +113,8 @@ void cxl_handle_rdport_errors(struct pci_dev *pdev)
>  
>  	pci_print_aer(pdev, severity, &aer_regs);
>  	if (severity == AER_CORRECTABLE)
> -		cxl_handle_cor_ras(&pdev->dev, pci_get_dsn(pdev),
> +		cxl_handle_cor_ras(port, dport, pci_get_dsn(pdev),
>  				   dport->regs.ras);
>  	else
> -		cxl_handle_ras(&pdev->dev, pci_get_dsn(pdev),
> -			       dport->regs.ras);
> +		cxl_handle_ras(port, dport, pci_get_dsn(pdev), dport->regs.ras);
>  }
> diff --git a/drivers/cxl/core/trace.c b/drivers/cxl/core/trace.c
> index 7f2a9dd0d0e3..df42d119c53d 100644
> --- a/drivers/cxl/core/trace.c
> +++ b/drivers/cxl/core/trace.c
> @@ -2,7 +2,42 @@
>  /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
>  
>  #include <cxl.h>
> +#include <cxlmem.h>
>  #include "core.h"
>  
> +const char *cxl_trace_memdev_name(struct cxl_port *port)
> +{
> +	if (is_cxl_endpoint(port)) {
> +		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
> +
> +		return dev_name(&cxlmd->dev);
> +	}
> +
> +	return "";
> +}
> +
> +const char *cxl_trace_host_name(struct cxl_port *port)
> +{
> +	if (is_cxl_endpoint(port)) {
> +		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
> +
> +		return dev_name(cxlmd->dev.parent);
> +	}
> +
> +	return dev_name(port->uport_dev);
> +}
> +
> +const char *cxl_trace_port_name(struct cxl_port *port)
> +{
> +	return dev_name(&port->dev);
> +}
> +
> +const char *cxl_trace_dport_name(struct cxl_dport *dport)
> +{
> +	if (dport)
> +		return dev_name(dport->dport_dev);
> +	return "";
> +}
> +
>  #define CREATE_TRACE_POINTS
>  #include "trace.h"

