Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010036.outbound.protection.outlook.com [52.101.85.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6703B2CCC5;
	Mon, 23 Feb 2026 06:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771826689; cv=fail; b=jesP9y+/zXsOWUBtzOal/Wu5JyZDNVGNPIG7Th+IJaI8HYbE8RGA7bi45iJ5ONT5aVTCws8WW1unLwYbKJHm/1rEAJ9rJVWIE2LX454mlh/wozF6bfYpqbq3Ne2ebC3YXfPaIM7pdn+ZESc+Kf/YEX+JA2HY3KNM3qB3CdrtoGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771826689; c=relaxed/simple;
	bh=i7wB1XB+UzBs6u7BJFGWo+FPlh7er9w2qbkxeV2SvhE=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dism/zYKQ5Wc7HsdFou/FYEv2r6THM53n6QNikAnZTsnW87Epo7ckmtosXLDAQbOVujTabbWW2OBmmUyEKLeas6cdbGhLKQ8qVyoCOd6S0YMp1MM5g2J5OW1/gBj10IPbKnANMg7qAFnyt2vkRtXFbbYrwB9fWwz7gDfo2w1Dws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oImXYerd; arc=fail smtp.client-ip=52.101.85.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oImXYerd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txr/EZiAtE64ja7CLX/xLsQW039l0prlFmgMhBXQMhl438P3hiMGmoJEm6WUrH1DQOFysb3J1n4bIJd2x+/jmk73Du6m4YE45Z+PPtgpaC7/DCa9PKuAp4kaziBv2kaHTCAxAU81Amh9q/lbODgmq/wioj2vXZhtOEI5Z6ptwcrPwqvFyMjS2JowvGkHNUs/2xBeuZZH/RvNBO4rr7fyHrIOAXBBPhW5eExwthbLDMUkbZVs6ioBKyTZQjNRfMmfwVCSdC3mt5SXVGaL9PmbEeS6h7FYVABkpdarH6193dkANQzVq8E/XuZ/i6RpSvKcCL6iNAzfyMNmVfB5CjF6lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1/7LZCife2mPjX+bedqDdGVhGZVEVqI4NbTZ+xMiKo=;
 b=ntKsnwRzP1AVDfAGA5s/74v4Vtt7s4D6NnDkp+DJ3RAtSYwzaiR8/DuJi2FmvTQZeY7taG+y1mK3w50D2ju6l/NlSu7IzabudhgQQkD0BODgIDfn+dvDMGw3dXQtUYYNg+0vxgPEe+Yeth+AsZYyvMam37A2hgSCbDD5wRXPGy30i9C6vne2pGV6GRoj/qezWNak4WxWffJz3isPV8CZz3jlWKXdGoi8XdzkUeJT8UznTsN1GkREKqDCxJP8QTG0WD0+qqBvW30DqRroCJ+2smAUjNfnb8+u9XZ92nLL6c3wD4L4RxuPpFthPXWuUDwjJiejracynibMlqPVjTe+Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1/7LZCife2mPjX+bedqDdGVhGZVEVqI4NbTZ+xMiKo=;
 b=oImXYerdqMK6DBLE/VjZVadBav0FlUZ+1sSWEKSmplZxbdsI+rM8o8FWpG4Z4ym8+4HWljTpEIQIw+XgawNM0ewQn11oc2RXq2tARrcafMsPjdE1HmKDqjgcwMMtx0jh7SegAkkPKD8xsJRrchDKt+vNJ8IAN0LtS04m6fWGG+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by IA1PR12MB9466.namprd12.prod.outlook.com (2603:10b6:208:595::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 06:04:44 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 06:04:44 +0000
Message-ID: <842e6a0a-1288-4b79-88a9-f866d38292f1@amd.com>
Date: Mon, 23 Feb 2026 00:04:46 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PROBLEM] c5.metal on AWS fails to kexec after "PCI: Explicitly
 put devices into D0 when initializing"
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
 Matthew Ruffell <matthew.ruffell@canonical.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 lkml <linux-kernel@vger.kernel.org>,
 Jay Vosburgh <jay.vosburgh@canonical.com>, kengyu@lexical.tw,
 Brian Norris <briannorris@chromium.org>
References: <20260213192607.GA3167656@bhelgaas>
 <a7d03703-04fa-4c26-987a-a34d2e96a4a7@amd.com>
Content-Language: en-US
In-Reply-To: <a7d03703-04fa-4c26-987a-a34d2e96a4a7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR07CA0024.namprd07.prod.outlook.com
 (2603:10b6:610:32::29) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|IA1PR12MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: bf08db12-79c5-4416-5127-08de72a170d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3JNZElLelZmbDNCWW96WDN3TU5BL3lQWmNDZmZGRTE4ejY3N0RpMUpqTnBD?=
 =?utf-8?B?S1VlQ1FDV0RBMWJrQjFYRnprV1BEZnFIeUJlWXp4U1Y1Z1EwZjB6RTZQM1dt?=
 =?utf-8?B?SlI2dWxyTHRkUHlIcExJUVBvZTFvbnB1RFk4ZGVudTdnZi9oTjg3aTUwYjhk?=
 =?utf-8?B?bVhGWWFQOGhYWjNpMkMvVFdsRWZHWnFrRU1XbCsxNGJxeHUxODVTU29nK2Zt?=
 =?utf-8?B?RmFSUmYzZGFYTlQyYU54TEdncURPeXNNTzJ4b3NwRE1OV2t5Y3ZFOE0zTmRK?=
 =?utf-8?B?M3BvUXdTSkU0RnhlMXlkM0MvU3FURWk4cGs1TUpsYlZ3akgzSEF2VzVyTXEx?=
 =?utf-8?B?N05MUzF4TlFGTFQrKzFTdysrci9jbHVVeXpvc1lFNzdQNFNKYjBYL2tyZVJM?=
 =?utf-8?B?Ni9oYVlkOFNVOVlUY1dGSE4wc3hQOHlWRWNLTEJxVSt6L0ZGRkgrSGV0bHE1?=
 =?utf-8?B?cWI2V3QvbmdDKzdzRkZBNVI0d3lXeHIwbmV0QU1iR0s3NkpTS0JZMnRyQWlq?=
 =?utf-8?B?bkp4UnErNTcrZ1hmR2IrNjdLVTY1SVowWXhWM3krSjlYcXUyWG1tMjlUZ0dC?=
 =?utf-8?B?N0hxODVVK0J6bG4zYUNNZm9VejZMWlF5WUZWWUVhaW5rN3J1QWZiUTRBNGdq?=
 =?utf-8?B?SXB1OXFrZGhwYkg1OUlvYURCdDlFMzhnQmU2Ui9zLzJhOXhTV1UzYmFBaVcw?=
 =?utf-8?B?MUQ5NXNVYXhsY2xuTUE2dWxBNno5ZnZvczduclRDdVBTTWZUcUVXK3czUFRh?=
 =?utf-8?B?VGpJaVVON1hYb3FYdDVGU3F6S3JNQXhCRWFiZDByNHZVdmJpS2dNUFBCbkNj?=
 =?utf-8?B?bTFIOGc2S1B3SzRkZ2NkVkRVVC9CazkwMkxqdHFtZWZkMXFpUjl3b2NQa3ZF?=
 =?utf-8?B?RVJiRTArUUlCK29URm5Yd1hpMGFvS0dIMUJ2QzJkMzl0U1craDZ6TUNQMWsy?=
 =?utf-8?B?SDBsNWwwV0Rzb3RuWHlMcGZ3eXByUHBXc0dzZW5lKzlXcUNpY2czRVlJbFBZ?=
 =?utf-8?B?WXRpa0prQ2YwUi9zTzFEYzgyT3UydnVFbklva0tMWDlpTlc2S2ZTT1B3MXl1?=
 =?utf-8?B?K0trWThzRkYrVXRFN0x3b0hYKzVtSElvMlBSdmNKNTRKRnBLTTlEZFd5b2xM?=
 =?utf-8?B?eGRSNGNIS28xb3F0TWpKQll6SGhJVXVSMEx2eHpzT2MyYnN0Nm9tRXlHUnB6?=
 =?utf-8?B?VkpNdWMzbURic1A1c09RSS90d0ZReXVORk5DUTRnK2ZjQ3BYbVVBYkRSdWpK?=
 =?utf-8?B?bWVpTWhzQ3RmTjJmUFh6UUtvaW1ybWF3Z0pnaFdpeURBallGekxzeDdyVDZT?=
 =?utf-8?B?UmtUcEJDaUliZ21VUTNrZ0grVklHVUVLMklKUk0wa2ZEbU5xMU9sKzUvL0lt?=
 =?utf-8?B?M3N1em1mZVZDbUFaYjFNNXN4TldmdERxd2JVQ3M0V2tJc2UzMkFac2k4M0Qz?=
 =?utf-8?B?YlltRmMvSXlJek4zZDNjWmM4dyt4bk5haHowYkRTeGhQemcrb3hRZUZrSTRJ?=
 =?utf-8?B?SDVHQWFNcjYrRGdUSnFoQzdPRk1YdEFHLzdvdFV6cXc2SWR3WjRMaVZUTDRZ?=
 =?utf-8?B?VmFKMEZiR0F5RHduTDJQY1M0MU5DRkVjcnFNTHY4ZUZuY0VwT3Z6UTBndjZw?=
 =?utf-8?B?WnZsRkl1bEw3NWtmWnluOHdIRUNqblhaalNnTmtLbmRHaWhNckhPeGkwd2lT?=
 =?utf-8?B?d3pnVWIwR2dML28yS3RGNEx5LytsNS80Sll4QWhVNXV0RnZPNFgxUG9FNVFC?=
 =?utf-8?B?d0ZWWnhhOXV2ZWJ5MG1SQWFJc2RGMXgzbjJqbkt5ZllrQ2F6cTcrdEJCS2Ju?=
 =?utf-8?B?bkRhcmRZenRGQXUvb3hGVVJyMUlyci9ab3lDL0wrNlpZdWEweDBPNzdSSWdh?=
 =?utf-8?B?OGhBakZPbVpTQjNPeGtMaUlqSDh0K2hQZG12T1FBY2p6LzFSV2hIQTBPMCtV?=
 =?utf-8?B?anVpOG9aY0V3VWxxUDBtaXJ0QS9IOWxxcVdudUQ0Tm1vdG9JM2Jkc1Y2WXZT?=
 =?utf-8?B?RDd6RnhVYXVmSzNFeEIxeWNjdG5aczc0QTUxWlF0N0pSTHFIblhPUmg0aWxk?=
 =?utf-8?B?UTd4KzdBRkxVbE0rQWNFMWE0MkgrN2pWNHZGSXpVWGhTaE16VlQvdnFSL2tp?=
 =?utf-8?Q?Qayk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1EwdTNCME50MHErblY2TENtTEljUEI1dWg2ajhlWldJL3lpemlvei9TMmZl?=
 =?utf-8?B?RjZ2NDhRVks5L25NWUVOSmVvbm9sMzRGUXgvVnR4dDB1bDNDL2pPUCtBeHVR?=
 =?utf-8?B?WkwzenlUMVJMbnEvTXpZY3BCRi81U3QzblRDV1U2cFlDRmFOR0RzQmQ5aHlN?=
 =?utf-8?B?MXRHbUhLNlZmZTBTMFVRK2pRaHh4RURraHFUbkIxa3Nla3JFQ0tSa1dNeSts?=
 =?utf-8?B?U2IvSDZqTVF2TDZ4a2c0TnpTb3VmTEIrL1pEQ3NMTlJ4OUx0OHFFakFONUNK?=
 =?utf-8?B?OU4vcjBRR0E4WGUxYkM2UkRjM0hDNVNYTkloWkp2TTVXaml4UHRMM2phdDJF?=
 =?utf-8?B?SmRDYXBiQTVFOHhsK2c4OG5mNTN0RTZLUzBIU0gwUEtUQys2WTNJKzZVOE1o?=
 =?utf-8?B?aUVOWTcwbDJMZmRxNXNObjd5dS80dlA2NVZOaGJhaFY4elI5VG9sbzYwNjNw?=
 =?utf-8?B?RE1EcE5qaEJmR1BpVk1ydmFIN3pPWnJGV0JvbnExZW95U0lTU2c1VG9qR25U?=
 =?utf-8?B?bFMySnlnU1ZnSlp0SVFGdzJzcDJFN3ZVSldPNlk0QkxYaU1QWXdONFh1R014?=
 =?utf-8?B?Rm5EWWVZS1lsT2lENXRuNmdwcTFLZ3dLcUY3WXJYK0FsZ1hyQ0tMZFFINitr?=
 =?utf-8?B?ckl5cDFscXVlWi91ejN5YU15RXhXUVVsWks3QlNPR29zMFBQR004bDlETENR?=
 =?utf-8?B?cklMMEtXOFFZdmxjMVVJNVhCZVJCcW1SNHRxOXR1aDVJTmFPK0lzeG1wYWVp?=
 =?utf-8?B?NHkrUGphVXNtTW9sN1AvSU95clVZbmVDVlZHNDZjTjdtN3FGdHN0cVk2b2FY?=
 =?utf-8?B?RnFNd0xzNlRIcnp4QmUyWXR0KzluYllNVFA0VFd0bmhNMXNiOHJVS0FTMTdZ?=
 =?utf-8?B?TmwyWERMdDhwQmtFMVRycW5td01mSUZyNWs3bTBqV0RFYjJFYzFvUEVLQ1p1?=
 =?utf-8?B?TFhIbGYyby9MR2xIT0ZURkpqdTRvRVRIaDNrS3FlcFI0L3RPaElvUDNkbm1Z?=
 =?utf-8?B?MmxYQU8wK0hpRDVvOW05SmR1VUZaRzZ6Z08xc2ZaWnJJSDJMMDJrZWViRk9j?=
 =?utf-8?B?cy90R3pidnREZ2o3SGhnR2lFeVFzUUtia09sOXVTNWlLNzlmaXJ5U1pqM1VJ?=
 =?utf-8?B?S3ZKdFFITXJUM2tQRHVRSkNTWXBXeGhESWFQcUdzR2tNa3B0R05PUWQ5engx?=
 =?utf-8?B?N2lIVllLcFdQU2IydlhzMHNJSnh1cjc2OXR6RlpYMFF5TjB2dUZMWG1NTXNt?=
 =?utf-8?B?bzRKZHB5REt6cjFvcmphNnA0ak1NVVBPY2ZKa3BHTUFRdk9oenJyckp1RFpx?=
 =?utf-8?B?RkFBNjk0eTQvN0YvdkpjRTdwSUt2NEE2WUk0UzNoRDB0NWo1TTdsZXgzY3Ja?=
 =?utf-8?B?M21OU1lEc3FleVRKSkFmZExjekxmUlBUM1ljK1g5OHloWXdPMEpZWlhKOGxG?=
 =?utf-8?B?d2RjTys1RE5aRm1hejRuV0hjMmlNZ29BMVBvQTIzU3JyWHFUSlBKZDhNSTZO?=
 =?utf-8?B?QjI2WHZMM2g3VmF4TXhLWk03TVdadUQ4elpKTkNaTGptQTVSQ0VCaW4wMStZ?=
 =?utf-8?B?QzRQYTlWc1hpRjBIME93VThodTlBWWRYa1F1M1BMRkZFVmJ0eEl2T3BOTFIr?=
 =?utf-8?B?OTlQVFNHOTFIUFdIQ3FyQ0lQSDhyeHg5MkdEYkY1bVFZaThHMHRwYmRPZmhW?=
 =?utf-8?B?VjB0dTdtaE9qZWlyaFVSS0trTXpJS1RlSThuaU9HdzJMcDJSK3RSYnJBbVN1?=
 =?utf-8?B?RzcwZHFQRTZpSDA3NlVhR3d3SUFxUUNTeUtVTThXdTcwMFpmMTFXRmI1cTds?=
 =?utf-8?B?cVpjWGpONE5qRGIxWHNnamQwUUljNHFEQnd2RjNmcnlTRzZyTUlpYzVJM0Rw?=
 =?utf-8?B?MXBqMWo5TW5DMjhhZk5PaGdja2lDalZyaEpoS1oyVE1RcnRVVExtQXVjOEdG?=
 =?utf-8?B?bmRWUTVvS0VNSG9SdFE5VVpnRkI5OHl2V3o4TUNiUUV1enhUMEFXOGJLU0xY?=
 =?utf-8?B?cUtsQ0QvZm40ckdZSVZkQ0hNRWh5d3IwR2RwN3RJVTJzQ1V6U0hhdlpSbWdu?=
 =?utf-8?B?a05INmduK3AzNFRKcXBtMXVEOHN5c2hWdmpBYklLdSttSVUrWHpRK1l0U1BO?=
 =?utf-8?B?cG9ObzJTTnR3dEpEcmI2TjJURzdCbUk3aGNON3ZITUVDOWRleVdObkgyWGo4?=
 =?utf-8?B?TDFpTFRmK08reXh0ZDQvSXEzdnlOREw2dVhQcmxOYzhPejJxY2lwYW9hRzgw?=
 =?utf-8?B?elBYL1BpSEI1V0UxamdUOS9RZlo2S283NDRWdjdRbGdSZXFqZVRMRFJiaEtL?=
 =?utf-8?B?Vi9RWHB3WTB3eGF0SVZPRklCdW0wdWI1anZtV2lZdTZQdW8yMVJjUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf08db12-79c5-4416-5127-08de72a170d5
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 06:04:44.3227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RRL+A2oR4QEctnePMpv6n0J4G2sWCIQiVbw+FbCxWNtkZFuspe8kZ9BNaQEdyMaxBRWItNoTKD53AYy1cJBdaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9466



On 2/17/2026 8:36 AM, Mario Limonciello wrote:
> On 2/13/26 1:26 PM, Bjorn Helgaas wrote:
>> [+cc Brian, author of 51c0996dadae ("PCI/PM: Prevent runtime suspend
>> until devices are fully initialized") (though it's not clear to me
>> whether this makes any difference)]
>>
>> On Fri, Feb 13, 2026 at 06:54:13PM +1300, Matthew Ruffell wrote:
>>> Hi Mario,
>>>
>>> I have been doing some experiments with c5.metal on AWS with an
>>> Ubuntu resolute userspace and a 7.0 merge window kernel.
>>>
>>> Amazon AMI:
>>> ami-04080dce0ccaa893d
>>>
>>> Linux HEAD 582a1ef360a05bff4350bbf6e383f61d26b804f0 (Linus's tree).
>>>
>>> $ sudo lspci
>>> https://paste.ubuntu.com/p/mtgbn2HJtW/
>>>
>>> $ sudo lspci -vvv -t
>>> https://paste.ubuntu.com/p/s6NhBz5FZy/
>>>
>>> I noticed that nvme_pci_enable() calls pci_set_master() with the pci
>>> device, and I wondered, is this called with the NVMe device, so I
>>> went and had a look.
>>>
>>> I added your patch:
>>>
>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>> index 595ec12d85df..bd116dccd897 100644
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -1300,6 +1300,7 @@ int pci_power_up(struct pci_dev *dev)
>>>       bool need_restore;
>>>       pci_power_t state;
>>>       u16 pmcsr;
>>> +    u16 old_cmd;
>>>
>>>       platform_pci_set_power_state(dev, PCI_D0);
>>>
>>> @@ -1347,6 +1348,10 @@ int pci_power_up(struct pci_dev *dev)
>>>           udelay(PCI_PM_D2_DELAY);
>>>
>>>   end:
>>> +        pci_read_config_word(dev, PCI_COMMAND, &old_cmd);
>>> +        pci_info(dev, "Bus mastering bit is %sabled in D0\n",
>>> +                (old_cmd & PCI_COMMAND_MASTER) ? "en" : "dis");
>>> +
>>>       dev->current_state = PCI_D0;
>>>       if (need_restore)
>>>           return 1;
>>>
>>> as well as some additional logging in nvme_pci_enable:
>>>
>>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>>> index 80df992d1ae8..2d1898016d40 100644
>>> --- a/drivers/nvme/host/pci.c
>>> +++ b/drivers/nvme/host/pci.c
>>> @@ -2992,6 +2992,7 @@ static bool nvme_pci_update_nr_queues(struct
>>> nvme_dev *dev)
>>>
>>>   static int nvme_pci_enable(struct nvme_dev *dev)
>>>   {
>>> +    dev_info(dev->ctrl.device, "mruffell: nvme_pci_enable() start/n");
>>>       int result = -ENOMEM;
>>>       struct pci_dev *pdev = to_pci_dev(dev->dev);
>>>       unsigned int flags = PCI_IRQ_ALL_TYPES;
>>> @@ -2999,6 +3000,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
>>>       if (pci_enable_device_mem(pdev))
>>>           return result;
>>>
>>> +    pci_info(pdev, "mruffell: nvme_pci_enable() set master\n");
>>>       pci_set_master(pdev);
>>>
>>>       if (readl(dev->bar + NVME_REG_CSTS) == -1) {
>>> @@ -3064,11 +3066,13 @@ static int nvme_pci_enable(struct nvme_dev *dev)
>>>       result = nvme_pci_configure_admin_queue(dev);
>>>       if (result)
>>>           goto free_irq;
>>> +    pci_info(pdev, "mruffell: nvme_pci_enable() end\n");
>>>       return result;
>>>
>>>    free_irq:
>>>       pci_free_irq_vectors(pdev);
>>>    disable:
>>> +    pci_info(pdev, "mruffell: nvme_pci_enable() disable\n");
>>>       pci_disable_device(pdev);
>>>       return result;
>>>   }
>>>
>>> So, booting the system on a clean reboot, we see nvme_pci_enable
>>> does infact get called with the nvme device, and all PCI devices in
>>> D0 with the bus master bit enabled.
>>>
>>> https://paste.ubuntu.com/p/zp3khwfMg2/
>>>
>>> Then I did a kexec.
>>>
>>> https://paste.ubuntu.com/p/SWB5jz6x4g/
>>>
>>> nvme_pci_enable() still gets called, but it doesn't seem to change
>>> anything.  The system still fails to issue I/O to the NVMe and all
>>> pci devices say the bus mastering bit is disabled in D0.
>>>
>>> I then reverted
>>>
>>> commit 51c0996dadaea20d73eb0495aeda9cb0422243e8
>>> Author: Brian Norris <briannorris@chromium.org>
>>> Date:   Thu Jan 22 09:48:15 2026 -0800
>>> Subject: PCI/PM: Prevent runtime suspend until devices are fully 
>>> initialized
>>>
>>> commit 907a7a2e5bf40c6a359b2f6cc53d6fdca04009e0
>>> Author: Mario Limonciello <mario.limonciello@amd.com>
>>> Date:   Wed Jun 11 18:31:16 2025 -0500
>>> Subject: PCI/PM: Set up runtime PM even for devices without PCI PM
>>>
>>> commit 4d4c10f763d7808fbade28d83d237411603bca05
>>> Author: Mario Limonciello <mario.limonciello@amd.com>
>>> Date:   Wed Apr 23 23:31:32 2025 -0500
>>> Subject: PCI: Explicitly put devices into D0 when initializing
>>>
>>> and repeated the tests.
>>>
>>> This time, on a clean reboot I get:
>>>
>>> https://paste.ubuntu.com/p/qm6ZBWNqG5/
>>>
>>> I get no messages about bus mastering at all. I did a kexec reboot
>>> and the system comes up correctly, again with no messages about bus
>>> mastering. So we must return early before the printout.
>>>
>>> I then added some more logging, to see if we can see what state
>>> these devices are in:
>>>
>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>> index bd116dccd897..deed439af6e4 100644
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -1302,10 +1302,16 @@ int pci_power_up(struct pci_dev *dev)
>>>       u16 pmcsr;
>>>       u16 old_cmd;
>>>
>>> +    state = platform_pci_get_power_state(dev);
>>> +    pci_read_config_word(dev, PCI_COMMAND, &old_cmd);
>>> +        pci_info(dev, "Initial: Bus mastering bit is %sabled in %d\n",
>>> +                (old_cmd & PCI_COMMAND_MASTER) ? "en" : "dis", state);
>>
>> If you include "%s", paired with "__func__", in the printf string,
>> we'll get the locations directly.
>>
>>>       platform_pci_set_power_state(dev, PCI_D0);
>>>
>>>       if (!dev->pm_cap) {
>>>           state = platform_pci_get_power_state(dev);
>>> +        pci_info(dev, "mruffell: pci power state is %d\n", state);
>>>           if (state == PCI_UNKNOWN)
>>>               dev->current_state = PCI_D0;
>>>           else
>>> @@ -1349,7 +1355,7 @@ int pci_power_up(struct pci_dev *dev)
>>>
>>>   end:
>>>           pci_read_config_word(dev, PCI_COMMAND, &old_cmd);
>>> -        pci_info(dev, "Bus mastering bit is %sabled in D0\n",
>>> +        pci_info(dev, "mruffell: final: Bus mastering bit is %sabled 
>>> in D0\n",
>>>                   (old_cmd & PCI_COMMAND_MASTER) ? "en" : "dis");
>>>
>>>       dev->current_state = PCI_D0;
>>>
>>> The result for a clean reboot is:
>>>
>>> https://paste.ubuntu.com/p/qh84c8T9ND/
>>>
>>> We seem to skip pci_power_up() entirely for most devices, including
>>> the NVMe drive. Those that enter pci_power_up() are in state 5, or
>>> PCI_UNKNOWN.
>>>
>>> I did a kexec, and we get:
>>>
>>> https://paste.ubuntu.com/p/D2GhjKxDG3/
>>>
>>> Pretty much identical results, and the system comes up correctly.
>>> Each time the bus mastering printout at the very end of
>>> pci_power_up() is never called.
>>>
>>> The only conclusions I can seem to draw from this is when "PCI:
>>> Explicitly put devices into D0 when initializing" is present, all
>>> devices get their bus mastering bit, and are placed into D0, and on
>>> kexec, all devices lose their bus mastering bit and never get it
>>> back again.
>>>
>>> If we revert "PCI: Explicitly put devices into D0 when
>>> initializing", devices that work bypass pci_power_up(), get their
>>> bus mastering bits set correctly, and kexec works.
>>
>> Thanks for all your instrumentation and debugging!
>>
>> I don't think it's safe for the PCI core to indiscriminately enable
>> bus mastering during boot.  That allows devices to DMA to/from system
>> memory even if there's no driver to operate the device.  Bus mastering
>> should only be enabled by a driver.
>>
> 
> It seems to me the problem is a mismatch with the device and what the 
> kernel did in the context of kexec.
> 
> I wonder if instead we should do the inverse - explicitly turn off bus 
> mastering before we put it into D0 at startup.  Because as it stands 
> today there appears to be some devices that the BIOS will have bus 
> mastering enabled, kexec might have turned on bus mastering and we are 
> just "getting lucky" there hasn't been a problem from that.
> 
> This would then also align the kernel behavior to the design pattern of 
> bus mastering should always be off until a driver asks for it.
> 
>> Per D2GhjKxDG3, nvme_pci_enable() is being called after the kexec, as
>> it should be.  We need to figure out why it isn't enabling bus
>> mastering.
>>
>> It looks like something is wrong before we even get to
>> nvme_pci_enable() because it took 80+ seconds to get there after
>> kexec (D2GhjKxDG3), vs 2 seconds for the clean reboot (qh84c8T9ND).
>>
>> Can you please put the entire dmesg log in a pastebin, possibly also
>> with a note about the circumstances and a pointer to another pastebin
>> with the "git diff" from upstream to the kernel?  It's hard for me to
>> pull all the pieces together from the excerpts and keep track of which
>> logs correspond to reboots vs kexecs, etc.
>>
>> Bjorn
> 

Matthew,

Can you please try with this diff that applies my idea?

Thanks,

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1f6fd7c372932..5955a273c9ba7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3196,6 +3196,7 @@ void pci_pm_init(struct pci_dev *dev)
         }

  poweron:
+       pci_clear_master(dev);
         pci_pm_power_up_and_verify_state(dev);
         pm_runtime_forbid(&dev->dev);
