Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010036.outbound.protection.outlook.com [52.101.201.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585D04A1DF9;
	Thu, 10 Sep 2026 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052261; cv=fail; b=R2PGGPVNjt/mdTz1sKAmcR9EdKdbm5I5dPN0E30Pj04ATWcwIfx7pPTWB6rFcBZBxRdyJpsxv3OBIGfmdhWyRbGfiUFXb/5rq8D6vH786YdIzt86n1yRYSJoEVaJXCIjhHaG3HNdZxI+zZFjUbdYKUsq2npLUm/aCbtxFf99Gdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052261; c=relaxed/simple;
	bh=D1AjtzIRvzUNwZvWBdovxpUzZSRDHSXdU9N6C1Etxow=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dSG4jtYBLq5JbWcIoHIifep+WboghvQdRlhLBhlP38Fls96qQ2DQmLxS1nlmXZE0ZZOoeD1MvxIEdi6rEwNXi4ca+rZf958r7vGk2ckxbz7xbR1UqA2Lba9B56KMsrXZvx7Vlzf7gxbpRfRLLQXA+LSbq61znndWTstL4R9U8ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JY0M9lQj; arc=fail smtp.client-ip=52.101.201.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JY0M9lQj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rRdCAk2Fq+/13RqLNZQVsxCbpuWT+g2W4YG9EYb4d6EdXFHrdiWURjcRCOjdhceO+kUMl8uHj3o4Bn6GiQhxCjyCY3qC5CKmcvbIXcYMjLCJMGCnyRfKI7Oangx/36vaVqt+Wgr/3NruYSKS8zjJL+Goc5R4PxHSAXkbyYqj4zZDG5ni0m6icVtGF39zzkioJtFRMNlcGw9N34uRqCndDJ7MSQJUwN+g5kzeA0QITozVsSE04r0zGTq+a5wsVDmQhatSANGQpdM5CVAzBFMvrMgqpBucJNGmdvi6krYKRAIX7GYfP/bIJwBLTYaQU/2YbbqQquil7NXEyQ4OepuStA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M27KoMW2BdhrJwLzgNuIrPFm0EovMFsSmG+j+Bd7kUI=;
 b=W80POpbjNTffIcqzEthC4tiaIRIdl8QEvi6sDucqETVN69RIfZzqTYe5xEHGPGUzumik+6CFoNNS3N9D7ktM4JZRBjwMQ9ZU1HqVjWr/JYtS24uOipkV/IxloGCBq4OvyUp5MALyNAE6lof69dRR0t0WC3Y9VAqoMgsPtN1PZ20o+Q46dkpA/mAgLemqOCDFN7nzYA1uk8W0is3rhHszjVHUlQsit/S05HU7qh+UVjyUCu/PSBtHuiuHF+aYd7+qQ5MXfZZEj7UCb+H9hRmgunm0y+h2E5rAo8B2QrPJjFOCwpgdmN8F+6P+RBqMcKAALY7dL/EGhKlM2BQDj/LoYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M27KoMW2BdhrJwLzgNuIrPFm0EovMFsSmG+j+Bd7kUI=;
 b=JY0M9lQjLT3zVv2NXpJ2JKbwZJtRnDZUzvM2gCqGEBoqXWpeWyw4ikxrhmKtAXlNV705XyAhN+kPEKYXRllYxXPsKtX5KGG9Tr066p1zkx+yToPRIpcY7j/jPD8S4MwT53t0DSw/QhIT1Jp+6hlZotj9s+2zewttZoo3kmYbmGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by SA3PR12MB324744.namprd12.prod.outlook.com (2603:10b6:806:531::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Thu, 10 Sep
 2026 14:57:37 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%5]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 14:57:37 +0000
Message-ID: <7f560046-02e5-4bb4-9623-409612793cb5@amd.com>
Date: Thu, 10 Sep 2026 09:57:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 1/9] PCI/AER: Introduce AER-CXL protocol error kfifo
To: Jonathan Cameron <jic23@kernel.org>
Cc: Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <djbw@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-cxl@vger.kernel.org,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Len Brown <lenb@kernel.org>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Ben Cheatham <Benjamin.Cheatham@amd.com>, Richard Cheng <icheng@nvidia.com>,
 Robert Richter <rrichter@amd.com>, Lukas Wunner <lukas@wunner.de>,
 linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260902133933.2992457-1-terry.bowman@amd.com>
 <20260902133933.2992457-2-terry.bowman@amd.com>
 <20260908015144.62ee9c1c@jic23-huawei>
 <bb5a6b0a-c30b-4475-8be6-f3e3686c93be@amd.com>
 <20260909230231.3fe72037@jic23-hlaptop>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20260909230231.3fe72037@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0113.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::15) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|SA3PR12MB324744:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b450187-a54a-485c-09de-08df0f4bda85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	eF3xMCtLG4HmbobbBnVWPuDzXZnWY6iEhrnfQQZHKd+PHrth8kYIY86u7QiRrd12nG/zbo1uEQ+ve3u24PuEr7NlTODSOJFNgq/4i5zi6LhvGJkgTGVJUtri451eaH7WLPz8JmVam1PBANJ7aa9l8WDkHkW75QjwBZyS85AqiySf3P6heQj7q48PBNoZIsbIXsCqeg3H/fGr3z41orJdB74X32OSiIEdzeDBBYy0jHEvHZEwJMc+zAiNNyCbwl3y/vAxFNDaZm5ZADexEqF0lBcXab46ENK1N2W/FYmsRPtr2yg+W50dI3zKalz7xQpSoUNhy2oFhch/0D1c9i7dL6PiSEqvvK0l2LXQSYOSzEZ7C487GokYUrW8VmUqxoSKW9+M+uXKIA4r/wTxnz31x2u/GCNDKKGQQK3rZ9jzqMHgSoL34Ch6j4eHb3uUYDSUBnTwG/MquYecRf6UbsS4pwkfrR4uUYkVXVy/FJ7XuXW6An5e1+aSOvlW0oOOWsujFiK0A/ybFkM8Sqi2dGMMStTMPnjmVrCxthr0aqxHhiqAocINrnp0eQhPmrp2qHNd4Tzb2bViQYSW8pMwq+A0dPzrRyMBGWW8+bPh86oGM7d/2daBLFIrqZAcNI9X0gB+e9Mc/oDu237kOue4eyiQMqimq4dgDJZYbeLSG74c4v4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEU0QkVPSDZVbmJqMEN4Nm5ycWtHTUgycEJhNFlsdHg1QnU2SUJ1TXRuMmNX?=
 =?utf-8?B?elo4NHhTdit0amNXVG8yYmZDYmFJMStBSXQxUFdTc3Y0bFlzRFN3VU5RV3BT?=
 =?utf-8?B?ZWM3MGhVT1JvWXpIOFh4Ym1RZWNyNyt0ckhLNElRVGJnR05aL0tzVlRTVWdi?=
 =?utf-8?B?SU1JYXIzaFdCWkZWVXVsT1RkbDU5eS9KanRmZ0hmYTU0S0t1bWZkKzUvdzhn?=
 =?utf-8?B?Rzh3ZmlaYW90bEtpMnl3a3IwUTlJb0dreXErWHhWRU9WSnJqSDN0WVM0SmdW?=
 =?utf-8?B?b2FRZjVEa3lTU3RyME1qbFlyTlk3Nmd5VGNyMUJteEV2OG5VYVdkeGM0Qmt1?=
 =?utf-8?B?VjNtLzU1TzlUZThDYkNSRkh4cDd4dG9jRHRTaUQwRTltdWZFQVRWZzJXdlE5?=
 =?utf-8?B?M0JJelFwY2NHNDZRT1RqZ0UrMFRKSmZFZWtpSlFqYktKZmFlMFMwcVVoanlS?=
 =?utf-8?B?TW85REYreHJtMDc0akRSbCs3ZDdydnZvTFNMcVZsU2JHc1ZucEw4TGpocjZm?=
 =?utf-8?B?cjhhTDNPVnF2K3VrSUFGc2JGN29sNU9HOHlmKzhuOUhucUFzWkZReXpFRTI2?=
 =?utf-8?B?RFVqdjZndWRzbmNMZFp6eEc3UFJnZXBCY2NsNndzNUdicWhhVXdzZkVkWUlh?=
 =?utf-8?B?cUpLRSsvVGlpOCs1bkkwSEM0ckxhZzFrbGdvQ2xzSGxzdGMyTmRxOGRMZm1R?=
 =?utf-8?B?VVFYT20xa3JMdXR1UWlNc09QRmVhL05ndWVSdXMyK2liejJaMUY3TjUyZFZK?=
 =?utf-8?B?S1VUb09qZE1UT3o3UGVKNmRBeC8wZWNNcDJXUTcvN0dHVWRvekZqSEpEL1c3?=
 =?utf-8?B?S3B2ZkpRRFEwVElmY015MktHSlJIMWlmV1cwUlBmT3NEd2lJRS9xVi9xN2Fx?=
 =?utf-8?B?OXlpRU9CY0VjL0dMUkJ5dUE3MGUraGlKbVZsNnNGUjUxUDR0eWJIeWNKNDEr?=
 =?utf-8?B?aktiRnhVK1NmVEFHNmdYQjFxRnhNM29BWExURkpHTTBlNVhkcTEvSnN6MjRL?=
 =?utf-8?B?dmk0U1JseW1Nc2xVTXMxUFN4SUVCcHdFSEpRWXJzNEIwQXNqeXBzTG5HZndS?=
 =?utf-8?B?cjl0bXZMWWxpYkJ4VFRBcjVxSmdmRE5yME5Nb3VxYjhSMTE4RlJka3loTlBF?=
 =?utf-8?B?ZmhDcURZbFNFN3FEUk9XcGFNWW44M1VjcmJleWJJVXF2NE84N2NWSzkzSGNH?=
 =?utf-8?B?Szg3SVlGMlZBcTJrVy9QU0hCRyt6ZW5MZ2Fmc2FtMHhJTitJWmQ2akZiOGtL?=
 =?utf-8?B?M21PYVozSC80S1U5TG9FNFJLREhSeUdHSkFUeTB6d2JOS1lFN0tGeEd0ckpu?=
 =?utf-8?B?MDZQV0REQndGZ25tcFROcEcyMFVSaVdpSzNmeklsZE43Mm5VR0cxMkVWQ2hI?=
 =?utf-8?B?Q29vbmpCYVp1L0FTVnpnb3VvWkVzUkJheldtMEwydThRZDdMaGpHejJFZDVL?=
 =?utf-8?B?cmlMc3JEZjFuVGVLTWNmaEJ4dlhRYXE5QkVIZ01POWJTc3ZPTkdzUXdVTnor?=
 =?utf-8?B?N2xYenMra0lxK3pVbW42R0MvSGZvMEdPUVRPSnBPZEs4SGdRcjF5UUlEMnVr?=
 =?utf-8?B?ckZhb2VINkRNdTM5a2IwRElhY2RiNk9hdE9xSVRabmJxdUcySmorQW1CaExG?=
 =?utf-8?B?TVBySGFIVkt6dzBLMzNTYjhyaFd3Q1lTVHNNOWJ4UnhoNTRReFhGMS9vQktZ?=
 =?utf-8?B?NU45QkxxZHNBV20rcnNIRytRejZUZEx2Z2VLazQwSjMrQzdUQTZhRjI3MFRs?=
 =?utf-8?B?NXlpSzNmS3F6eDBTeS9TWDRxMVE1RCtKcjQ3eGlmTGtCZFJJQ2pOWGt1U3p6?=
 =?utf-8?B?ME0ySkkyNWJleWJTdGdCVnppYlVTMFdtMkxOMFFEK1JzVkxxeGQySGYrb0t0?=
 =?utf-8?B?TjNPbFp3dFcxZ1AxSkFJNlM1TVhDREtuSkIyZVU2dEIyUnZodmtKSmZmc01X?=
 =?utf-8?B?a041YjluVFJFWVF5cDYzaDg4RFRMdXlpbGlLcWIrYmZYTnR2ZWdZVzhESTZP?=
 =?utf-8?B?TEVUNTkyU3JVVTVIU3BGZXFjZERmdGRxemNIREs3b3VDL0JCUXVuc2FYUFRn?=
 =?utf-8?B?ZEJEZWVXRVNDUGJrWVB5bk9qRDFtYnVjZFU1Y211UGhQSlNVQmI1V201MUZH?=
 =?utf-8?B?dGdKZ2dkRHNtVDBKcEhGVklqWi9ZUVhpZWRnaWlhK0pTS2FvYWhLekpydG8w?=
 =?utf-8?B?T0g0NW91U3JNSmtMUm0rZGNxTWFKS3VXM0JBb2ZrT20vcHNDV21BUnJXVEFS?=
 =?utf-8?B?clRNTTlMR0J3WnI2VWpYOUc2NkgwZUlZK3gvUW0zYkQ0SjVoZEV2YmZJcW1B?=
 =?utf-8?Q?T0zuwjlfwo4T15Xcby?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b450187-a54a-485c-09de-08df0f4bda85
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 14:57:37.4066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X783Q9Y0vIpCIPa7HUWjLClShnf4sGiHIkia4kBxJO86eHzvhXMUBSCTVdYJIMV1wNN4w6PNVKdNokblR7gBPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB324744

On 9/9/2026 5:02 PM, Jonathan Cameron wrote:
> Hi Terry,
> 
>>>>
>>>> A subsequent patch wires cxl_forward_error() into handle_error_source().
>>>>
>>>> Add MAINTAINERS entries for aer_cxl_vh.c and aer_cxl_rch.c under the CXL
>>>> entry.  
>>>
>>> I couldn't immediately find any discussion about switching away from panic
>>> on a kfifo overflow.  Was there a reply to an earlier version with a
>>> discussion of that?  I'm not against the change but a 'why' 
>>> here would be good to have.
>>>   
>>
>> The driver panics on kfifo full error during UCE enqueue. This was recommended by you and
>> Richard. Changes are at the link below in cxl_forward_error():
>> https://lore.kernel.org/linux-cxl/20260902133933.2992457-2-terry.bowman@amd.com/
>>
> Panic on UCE is a given and correct. I ran the not panic on correctable via some
> of our folk and they were fine with it (at least so far!).  I just saw that
> you'd stopped panic on this as part of the change log and wondered why.
> 
> Not a problem, just following the breadcrumbs!
> 
> Jonathan

Hi Jonathan,

This area was raised during your and Richard's v18 reviews. The comments:
https://lkml.org/lkml/2026/7/23/446

v19 already implemented the fix from that review: panic on UCE, drop (log) on CE. The 
v18 code had dropped every severity on overflow without panicking, and you and 
Richard pointed out a dropped UCE must not be silently lost.

v20 only tidied the CE branch (early return + clearer log message). The panic policy 
itself is unchanged since v19.

-Terry
