Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012036.outbound.protection.outlook.com [40.107.200.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54082DF156;
	Thu,  1 Oct 2026 23:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790899145; cv=fail; b=VHf+HdEGJ75rs45uD/l69vkTRYfC9cON3jgd9nBoTSoUkPXGpTGJBxRS/hpC/9iKmPAi2GPYK5nwfGN0I6I4DziaLMqFAc9p1hKIAVsTTzmZReCRC/XUA/4TTbdmqOHlPLB0MeUTM2nXR7hfGyzzzE1Up2OIlh8BLzW4Hh7utWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790899145; c=relaxed/simple;
	bh=3UkpyIjtFM5MHaR0GJIHmz3SGYOrHOxgi7SLv1aQEBw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DSgcgnIYLa/dv8pGRo/RvbMma6NfI6Ng83W5++XPY4r40V6CFQ9yHKfvULAheZbgl6nzVQJnDas9GKPEZ6XdhK3+g1TLyhPZxkxN9L5Pc33CG55ygwg65qVbhfrI0ZD5R7+WKJqhbBTFBSwS5vUmXafWLDKnjhPDGnD3CFXtCG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LAl2GNp6; arc=fail smtp.client-ip=40.107.200.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LAl2GNp6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HeWHnBPJ4IG1u63ihncDImfUXLHWZcQCK372QrOb17Pseqtk6zS/pLHnt5pE3vRFfMEo5Y4odpwUKmoCICXMZWaw2eByBpfGAhVnEUqwXotPKmwz6klkigDIKEF37q0n+hoLr2Zh+XBWgusnzETJuQfdpw0ubw9QfwxdbVStnjsuBMSH81sBzxeHJahq9oAAzfhwcKkSczlqPsvTabDr44SeY/g+DboFh0DzgjRHtURoTHSAmpYiFygEtWBvbGFy1DRRCokzXNWC4L6j9/tcJJBp4MSvHV5NSbB4Rvh6LwRmGsI+qB+YKzTSiK+rfXiGdTm+1CwxPJZv/JUbYY/VQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tc4rmfn8KMSAmT1LWQOsyBVRAPtXDRffm16UN+fQA04=;
 b=kMU3ZP/2jc3hc59dH5NJ+ycz4H1hrEZ/3YnWbGi/+RLiFnH46yIl4jHkD221sJnDyNiBAnMDWFRe+lFUSHAw0v3OilaWlflz+pk/lrUOnBer9O62fOKcUMRrVGHt915tqMsCb0PS5ktpQnsrH6K+iwh61XWr1pLelhuysM5Ip1A9NdDk8WPI3KynbwmU4VcT/iaHBKJK1fP/lNKfoeDQCV7TPhzynNg6EMND+wSsgrvpQxIZFCZ6NvAR06C6P+6e+M0Ai161T420sZrHw09NAtRxthly2us0FHuhg22ZWuHw8wQv3DqU3Apfnkni0+fKCZBpZBsWrb0iX934R8GcQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tc4rmfn8KMSAmT1LWQOsyBVRAPtXDRffm16UN+fQA04=;
 b=LAl2GNp6A9f2Fc9NL3zuEtyTVpFyAh6kF46YkBzbk0Gposoc6+RcYDCrpimwSmgk3HMCfeg7msEQaF362yYy3d47p5bhQS2HNFGXDnGLWG7blA2qAcSfCIXY+jPzTtBMZpoMgpXwkaSzQ7SyL/c+sfPxOHBZC2PeJ14JMXHz4GNbMlb7qI4tWaDPAGoFP+VZ/rDNp/9FROZN6lQi4I6pK4XNASHRsY1+YTiURdQCtY+/u29n7jiCPTA/A5H+T6+bIghqc6YXgu3Guu3N1ZiokH7JhdiciSPKuFcSyDd7rRCeWBAhFBYMW5B+4eTXJ09n2EyPuxout191v1O+Jz052A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by MW4PR12MB6923.namprd12.prod.outlook.com
 (2603:10b6:303:208::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.27; Thu, 1 Oct
 2026 23:58:48 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 23:58:48 +0000
Message-ID: <b86977ee-e66b-4b03-b687-7f0659d47584@nvidia.com>
Date: Thu, 1 Oct 2026 16:58:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 13/15] cxl: Restore CXL state after PCI reset
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-14-smadhavan@nvidia.com>
 <20260924045010.3c1b299f@jic23-hlaptop>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <20260924045010.3c1b299f@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::10) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|MW4PR12MB6923:EE_
X-MS-Office365-Filtering-Correlation-Id: 0094f2cb-c786-423c-6e75-08df2017ef5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|6133799003|22082099003|18002099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	vxxweWdBwEL5/9/1/AqimpG1lZW8isV/0wXVBVc+YmsoqaGhWLH32trSOg05776QEx/Scg008GWjlqTGkHgn8NqDUtQQEj9KVCFQgKsw+10krRgljMlRDUwlhni9civ5dGkJpmRSDgXP6suAvppcXSNmud1QPZhbKkDdzZsiZozLyVr8QAq6AYC/0SkMvvBX7QpMWSaVk15PYqGxCw1B6DObnZ68nzypzs+4Z/RYLsj877AIoTOrEzWpB1H/wS4D9UmSNU/kRkWUlJhcvX1wiCI0AVLexa7CDxFRK/z6rtkiYEYXh3q5ZvOwdYc7mlthFkVrlaDE1HPzt3uqv6dHTHUip4K19bnL7ZIV9VXUr0gJZPh/hKlzZ4y65xbWeAVPAheQv1or6mKZWzTRCuAYRT9KtkkTrjfgFIbebOO/cmYQYJ87puVX8Bj2ziGc9xtUGSbfpJiP4XCM55XuAgZHlsVdfEhAWKjiY1pHfsnYWNmxCiCtniOb3fNkOhaU1raC2W5J8NUCqM0Z7zb4B8NalIc5Ompdm/xa4KTjksuRzTtb/ZZZd3r1yFbQ6a/KqxvjI8BH/Y/+Hn6KMM/XrtNz+hOg/DTicP1/3wtWyEG82miFKJxVVFhQpNi8EWg3U3yB4TxjBWiJfwzPt9781PClJs7GmvkOek0ZPIg2/4km018=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFVyRHludjVGbG1PL3ZFZ3Jyd01Oc3ZRUG9Kd1VIcWFldXdNeW12ZDhGeEFF?=
 =?utf-8?B?eG5ML1JxK29udDlRZjRIMUZFbnBOQnFoZkNzcnBHT0FQbFBVOUh0czlVOVFZ?=
 =?utf-8?B?UXFqa1ozZjgxUmR3Z2ZWcG9NRW0rZlVuS1prKzJzYWU1eitEMHFPOUNGWVln?=
 =?utf-8?B?WkVNbVZFc2o2b3BiUmFuSVcrQWxTVnlsM1AxRTBWa2dxOElySWVFa05rZ2VC?=
 =?utf-8?B?citxOHhyeTFwUlRmbkZlYlduZm1maHlhM2xwSVVLYVRZRW5qeU5hMGpVRkVz?=
 =?utf-8?B?TUt3OFkrN0VkSWFqMEx2Vld0U1cxUy9sZGZ2dmdxSnB0U1dUaWZaRGFaMkd6?=
 =?utf-8?B?aFh6bEtmRE00UHRSbkU0NU45VUh5R3A3Y3BDTnl0R0p6cUwyRjZHNXJuakQ1?=
 =?utf-8?B?b3Iwb0dDbTRWMmU3MHhzbElqVUt3MlBuWEZSZ043ZUNlTzdWRzA1emJjRkNS?=
 =?utf-8?B?S2pBVzNPcmpKemJRNkpQcnBFVzc2bUdnT0VlRGxpVDRoa2dpUThCbUs2T0Yw?=
 =?utf-8?B?ZDZSbjJCQ1VvWnFZVG1GbkVJeW9jNVlnenIrSHMrd1V1bG1hY09md0tXekZv?=
 =?utf-8?B?YlUvaDlTWmRUY295c2V5ZFhhUkVqU20ybkNVZksvaFF0NE5WWU5HV1NNbHRp?=
 =?utf-8?B?MWlMNUpoZWJOOXhiWUxZcGUxNlV5K3RlVnRNbmthZEhFeTVuTzdPSmpHT0x3?=
 =?utf-8?B?RTRLcGZiNU1wUlJjUG9Pb1lQazZsYXJSc3hOMUI1TVMweHl3NHhkcUszMFd6?=
 =?utf-8?B?OXNhUytTK3JzQVNiclZVSHZiZ1QxK1ZoWVhNaWxyZzFzOHhxc2lDVk5yL1JX?=
 =?utf-8?B?SjNKTkF0N1pGMGNGajIvVDdVaFpocmxVQjlZMjdpdU5BeklQVVlwSG93ems5?=
 =?utf-8?B?blFrNUVyNkltVzFKNEJMNWRMQXdhNHFINUM4Q213WDhscG5xcE9CRnJsSW43?=
 =?utf-8?B?OVBSdTJDVHBqZVZ1Q0FmdlRBV2FrODlBMWxFTnRwUzNGOEwzK0FlTjdjM28x?=
 =?utf-8?B?ZUVoNHIvZW5oUXY1S3c3QnpzbEpxano3YmdYVzlaTDJQbFlzcDNpYXEzL05R?=
 =?utf-8?B?Ky9oRm1RRjRhS2FjbDd5QzdLZ2NqMGE2cHFZTkhseFBwVGQ5YXFjQWJheWlh?=
 =?utf-8?B?WGJEMWVoZ2k0R3ZFQTdrZ21XcGhXeWZqU0FKNzB0dXVMeVNxR0l4YWc5enhE?=
 =?utf-8?B?RUdIK1N1SzJkRk0vZUladW1aZFJpSUJPVk5VeW9zeUR0UDFNdGRtdGlvNmp3?=
 =?utf-8?B?aWJETUpVVzRRWU1ab3NpZHlaTG5wbjJsUUtvQmxzMjJ4eUdXUU9QY0tuaGho?=
 =?utf-8?B?ZEJrajFOTmtzcE0rSisxQWZDWTYrejdnUTkxSFhkRkVmQlljVG4wS1N0enBw?=
 =?utf-8?B?TUtIVlc0K2JFdHhGUklzNXh6ZWE0L0xmZTB6R2M5bVFmaUVkQ0Fab053Q3dJ?=
 =?utf-8?B?SFhQUG4rNEFjN0FSRzRwc093QTVTcGU2YW42Syt5cWwzWlFPVWhuaWZwSzI0?=
 =?utf-8?B?SWxPbzMwWGNTd0dmdW9UWEdNSUsvSHNDSVllYTlCUDcxR2RXR09PeGV3N281?=
 =?utf-8?B?VElMSmZaSDRwSDVhOFdwcmtMV3FodUI5RTNvRm5VMnlpODZBVE1TaForbDdk?=
 =?utf-8?B?enhhZW8zR0FhcEQwTVp5ZitrUW9KbTR4eFk2TERUTyszdzgrTGZ5OExuRExL?=
 =?utf-8?B?dC9hMGkvUDFQZ2VNczMxb1BySlI5NW80aHhqemVPK0d3MkJFbjJ1VmtGNk11?=
 =?utf-8?B?b0VVL0NiY3RUVXlSbi9kVTdua3dvWEtlZ3NNU2EvWWE1V0d6aFRqbG9hOG1F?=
 =?utf-8?B?cEZidnlOZGtuRFdncm1UcGc0UUcrTzg1V0t0ckgyMmY3b1gwbnl4eFRGdTU1?=
 =?utf-8?B?MlJyTE5OdE9BMENSaTUvQStpQ1pSSUFNM0NFQ1grVC9OcktqalZNVnpJV0FX?=
 =?utf-8?B?QkkvbWNoZnM0YnJMcVo5V0ZFTnB2blNiVzlUSks5R2tQcDhGdmdUOEwrTEYr?=
 =?utf-8?B?Ry9NRHVNU0NKUXFjQmREaVoraCtZVWVKelBPMlR4cFBKc2xrRkF5dUV4bmR0?=
 =?utf-8?B?TTBrVDk5VittME5iaTZ0aHdlL1lqai9OTWZWQ3JuZXJwZzBjak9kSVlnQldx?=
 =?utf-8?B?ZDlsTHNHQzZNMEFKRXJYdlp2bDFjbzNhdEp4R3lzRkR3bGMyMHRyRVFIYncy?=
 =?utf-8?B?SE0rcU1qZEhqM2htSlovUDRDVGhiWFhhbGVKMGl1bkZaOEtBWldjaDFhNGRF?=
 =?utf-8?B?bVBhVzN2RnJZSVd6TEMyU053S21oZEtiUHBnVHlKbG1aSlg1a1RsU2JOUkJO?=
 =?utf-8?B?Z1p0UjMyV1JkY0R1TGgwZ1YyRkdwTzJhNHJuc3VuNnZNeVlEeCt5Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0094f2cb-c786-423c-6e75-08df2017ef5c
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 23:58:48.3439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/g02+h6rENqwLWdExO02hxpF+8UR92n2NbGdX8r+rlbbHuaM98JubaRskYkGrSb4qSNZWWU1LwlcKhSO17X8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6923

On 9/23/26 8:50 PM, Jonathan Cameron wrote:
>> Signed-off-by: Srirangan Madhavan<smadhavan@nvidia.com>
> Hi Srirangan,
> 
> I'm out of time for today so main request it to take a look at that
> final function. It is running quite a complex statemachine with a bunch
> of ownership transfers. That's the sort of single function that takes
> too much energy to review. Please have a revisit and see if there
> is a simpler stepwise way to do that.
Hi Jonathan!

I've reworked this in v14 patch 14. Reset execution and state 
restoration are separate steps, and cxl_reset_execute() retains 
ownership of the snapshot and range context through cleanup. The 
cross-function cleanup handoffs and goto state machine are gone now.
Please let me know if this is better now.

Thank you.

-- 
Regards,
Srirangan
