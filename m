Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010032.outbound.protection.outlook.com [52.101.46.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7F436607D;
	Thu, 30 Jul 2026 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785426474; cv=fail; b=bDlwbOpjI4Kwh68tBen17HG3zn6zx+qPpxHZfHaLCQ4om+xlZnv7QHUuQclp0soOwRsRr3uCZ83GD/tCKEPZ43AukuyDL4GPB42swUQjws6Vgap2LXhzSiyf7J0RgEJYCUueWDlPDISRhjZRvDwpWIzVCYPG/T8LNMmOCBp9oIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785426474; c=relaxed/simple;
	bh=NCmq1Mkl9Mu5yaE3JlhzcPsIyWIjb9K1HHSbfSjpc1k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kwToSBpwT9BxhwUhlPldkHIK/y3xRS5CYFtjd6UFugdkysyjuT4+0vhiWeMHmVk4rwDCGGuMCBWBPFo5S3W5mblSnwQCkBdtvmiNxiUG3wcsSNIYQlcwoP3k8CuPYrrgiqsPw5pkDQiANOEIgoyPOKSfoF6ct6WPczdgo+aW5wM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rpyJadvK; arc=fail smtp.client-ip=52.101.46.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rpyJadvK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CF221FpJ8UQobuI4Lm2gCkSrt8/1QGu0ok4RN9uMtVFt9FSipVlEOAxPtIkqjjBv0+VMbBkwmwQk4tRcXxC6oKVo2RWeDkEXYN1t3H4kdGl1bahL9HJvYO8wWwI6gmYl7fXrgLNmIGsMqU7/4YRi4ohAR4D+ICc+KJOy/DHtM88SmcFh9jXd+F77G+JtvCkEadprBig5yTorXGPqdz9/+2+oUK715c6JVfqZKEFWolKhQF6lZIgOCDUwEoHAaqW2gOkioqwVV8U3lCoMQhaR+3GBcBioyGbkB1ARM0Dt6RagGoW3PI191VMyzxA9gUonC3zlFlapyrV9p2poR+e1zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrESVmZUnUcl8+KMjSIPT1iIaQl9wwslvKafnthjKZ0=;
 b=C0BqkCZ2ZekEe08ooO2DfGTzjbQRpZs2boXW0T2TqvY4YK+RofKUFVTmR+XoOL3Y12sQ4rVkDzeXMbN9Zp0BRos8GAM2sedMtsc4mdi7ngowA3DxCKNqtcTA7beboRoxVzJ3zCwzEPTmgbAuo7C57LMvajfT22Yx8dvh8reQ651cz7qkwr3o9xebEE1bnudcGMUwsgsOCbKG4tZuA8PDU4rHuBEEKIt5EyyVHml5qsDqf2Q9Vknzba76TO7eyHyBN2zuJCVHE8yIP6Ll0ex4d0xyiOSljn/3SrpKiFJGEceGICO909iU2LJeW0MvKAHAhnY21rPh05O29W36Q5LqJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrESVmZUnUcl8+KMjSIPT1iIaQl9wwslvKafnthjKZ0=;
 b=rpyJadvKxG/Kd2/yWT5p2ieFLlxcZ0SK1SDSsyDijJdhKK4T9JVmwkCTrrCvobaY0O5j9wl9dOCkw+vg6arOlwIFQ7yBbJuDeQle5rvJJChGHh6RjF2Rjn+FjSZkTUmE2SI/pfDIlMjQAuK0WnQ+QrNvipYjtC2bUvrn9HkrFYc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by SA1PR12MB8945.namprd12.prod.outlook.com (2603:10b6:806:375::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 15:47:49 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%5]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 15:47:49 +0000
Message-ID: <69c78f52-9860-4250-9dc8-73ce033cf04d@amd.com>
Date: Thu, 30 Jul 2026 10:47:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 07/13] PCI/CXL: Add RCH support to CXL handlers
To: Richard Cheng <icheng@nvidia.com>
Cc: sashiko-reviews@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-8-terry.bowman@amd.com>
 <20260717224321.1BB411F000E9@smtp.kernel.org>
 <3ed4793a-b1a6-4459-b1ca-03979ae8af3e@amd.com> <amGWvnoT5XNIBMMb@MWDK4CY14F>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <amGWvnoT5XNIBMMb@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0398.namprd03.prod.outlook.com
 (2603:10b6:610:11b::29) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|SA1PR12MB8945:EE_
X-MS-Office365-Filtering-Correlation-Id: ee3c30d8-741c-453d-61ab-08deee51e896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|56012099006|10067099003|18002099003|22082099003|6133799003|11063799006|5023799004|4143699003|3023799007;
X-Microsoft-Antispam-Message-Info:
	h6ZuzaTaoUHqW/5TTE7oXMSbhXBeWYDLARd0vwYPcBg7GYgck0wuodDjru/8VhKPw1Wrj0Dgo3fJCE99fsfEkC2OjBE2jN87awhCiSMwts9+imwm0PhqMg20u9htArQbZgeEOlIMg+YWMz6fwg/6WwYThuEz0QP/qt8wmId7otYKEn4RrFMt1UidOPfjDPXtt5ojCv3CB8SHUvLyPLYiXvnRW/2wEGuk4HnKTBQgY7LgmydsjbWqbfP7u3D2XqbMgZut8s7miYpgreOnXuconagYyJfowdkzGk4LusO0I40GlGlCxlDyaB4U7QhLzf92XJXdfy4eZFd6tfsvlbnf+SR6T8CuEClg0n7qgtPpQysshmKUFGFU7+SV40KzFkdPWBA1YGOPkOLf7gcDQPKcWPmSFKP1GOl3ByMEcqwhWo0CHlRtdHHnN70uU89N265NnuTbCFhBNhUJDvb4KZyDPjLiTzaQR4+GhQI3cES/01l7z4DnqVd961XFyAq6ltd+NoC8sp25cpfks95rfdUWEglKeVsIxbjXqQFSH/hERAkiNgTMaWQNPYmh+oFK6jkGRs46epazSf/chzhvM4qlGn8+GLfqPqX4SFgeM/hEq6+IJePymuO4DYUJNh1aoTwTS+CqI611Dq9PyANMH4WDqNJW0O7B5pIsnyj3ADtwjQw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003)(11063799006)(5023799004)(4143699003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmZJUXozSlN3cXhCWEJqTkZSeDl2Vi9kRjRyQnNodTQzUWdOSEE3Z2owMXEy?=
 =?utf-8?B?VW9SakFBdnNtOG4rTzArUkd3elByZEx6amVPRUFYQWVhcHdxRVpuY3RFcUZh?=
 =?utf-8?B?b25JbE1wdUw5VjQ5SUQ5aTFVTEdhMUgzZGRtQnU4cUg0WmloRTVuc1Vxd0R5?=
 =?utf-8?B?QWFUd01UTTV3MXJBMDNhSGk4d1ZzdkIwWmhzcTFaRXZ6aENONHdJUXo1L2Ns?=
 =?utf-8?B?VS8zRitsdHlvVERyZ1d4QXZrTlJOTmR0aEN2a2NQaHFLaFNPcVpxekhSaGxs?=
 =?utf-8?B?U0pKN2RmZ0YwQTJuQUcvS3p3N2QrQk1Rck5yN0pFVDdGaThCdXU3RUlMMXNi?=
 =?utf-8?B?RldZekdVRVkrZm5TZ1I1dGkzSER2MzJTSHlWbUt2VzZiRnYzcmVpUU5kRkdR?=
 =?utf-8?B?UFoybmtkaG1GOFFzZWZyZVFDaE81U0Z6WkhkL3ZwWkpQelUyQU5tYStPSFJZ?=
 =?utf-8?B?Z1NvRG5DWFhTeTNmZjEyV0IwQTl3d1hjRG5BT3VDZUo5QXM0aHVCSnBPTGFS?=
 =?utf-8?B?N3BBZC9TU0thR3FNNk1kMjFKdUp0Q2tqQ0VUOFM4M3R2cmZJWkVBaG9nTWs0?=
 =?utf-8?B?WXlTL0FQOStHQmowRSt5R2tWTVY3VFhKVUd3eVcvSTlYTllzNFRpcEUyVXoz?=
 =?utf-8?B?N3UrS3lvZFRFZ3V5TFpIM3d5T05iVUE1eWFFU0ZkUTdWZkgwUXh3WjFOSm9S?=
 =?utf-8?B?UEsxOW1rSXpEMHpFclVLUEJuVnhIRllIMlphWXA5ME5tbGUzclZxQUVXYTZi?=
 =?utf-8?B?b0xVQUhrQVAvZlkyRmV4SXRqOXNuRDBxaWZHN0JoRWtHaVJsdmEvWVhZWFFo?=
 =?utf-8?B?aUpvS3ZYUFhuVjZneGdNbVpIeDFwd2V1MlZOTFlqOXMvUC9ZSEJaMm45eUFG?=
 =?utf-8?B?ekMxMThQU1dOZlRzQ2tuZnJ6c1VyOHlOdnJFTm9FeHlOeTN1MURiWTVFbzJO?=
 =?utf-8?B?V0p4Q0hpRVJwQkJpdzQ5YnNLcTNjU0N5RC9Bay82VlhwRDQ5ZTF5Y2pTZU9C?=
 =?utf-8?B?QWt4WXNPUkNNMVZIS2tZM3RRdkFBS004T2ZwdkdEelF4UVBXMjFmTldwbGg0?=
 =?utf-8?B?VUtvaTlqVXVpaWNTZUdSNVIwNkJYN3pSN0FxQjA2UGt1OTdFZVBtRG1uNmtX?=
 =?utf-8?B?NkVXWWs3MVhMdHRkQmlObXE2T0FyL0dLMHNLM1JGcU5mWTNXd1JMRi92VTUx?=
 =?utf-8?B?L3hwZU5lQ2pTTG5DUVE2ZVFsWmREU0pPYjQwcFRGOTluRnpsejZtUlVsZmVR?=
 =?utf-8?B?UnVsT3RER2plblQyMWZpYnBMT054aHZHbkJDcmpqa0swUWFjZnRuU0xUMFJI?=
 =?utf-8?B?RHhaTTF2SENmcEVUa0ZDOUJBMUFyR25kR1RtNDBvVWcvdUlPc1pEVFVzcHNx?=
 =?utf-8?B?RWpNUXBSRC9lbmNwaTNhRmtLZUNkdjN4UVJERnFVd3JFbkc0ZklPNHVNVzVI?=
 =?utf-8?B?ckpvY0huVHZudm9OTjVNZE1VdUU0ZzBWVEtSY29lN1crZ2RNVlRJV3A0ZWlv?=
 =?utf-8?B?b2UxMEhlUTdFU25TSkRMd3MxMW0zMjVqNzJIWjJJck1MSEEvM24zbHdKR2Fy?=
 =?utf-8?B?TzFPelVLbkp0SEFSWFg3Ti8xYWpFc2MvQThMR20xa3VwQkN2aU40RW9xTTRk?=
 =?utf-8?B?U0xUTlIvT1JZbGFoRE16UWhSWEZBampIamNuUU5kWlNPdEJNcXFyMGxDdW1y?=
 =?utf-8?B?dThFSE92MVJWaFBKdDBFcklwRDRMZmpsT2tHeC9GakdSVHByeGtpY1hoenpi?=
 =?utf-8?B?Yk9NVk1JRmVyazBjeDllQW41TTFkcTJQcm5FYThQWTVjM1A0R1ZMdlg2Q3A4?=
 =?utf-8?B?SHV5c1QvbnYvODFYZ1NORVFtWW9kcUUxNUNYMTRXZFlnOGY0NjZseCtwdWYw?=
 =?utf-8?B?a3lLWFlqaVdDTTA1ZTdpSzVkODEybkc2QW1JUldWcGk2ZEdoenpnclhKY3E4?=
 =?utf-8?B?Tk80YWdxcTdtQkh6dEpOT0VSVC9JMHl0d1I5QzNiQWVDTFFPRzVVd0lOT1la?=
 =?utf-8?B?WEsrRjlhNWxHNUlqbEFjSW1QcVJOUlVRcUdCMDBkY3B6WndZVzlOc0hpdXNM?=
 =?utf-8?B?cUhocVFxQVFGbjEzdFRiQ3RYT1kzcjlaU0R4dG5hYXBnWWluTkg4RjQxQUZs?=
 =?utf-8?B?NzVoN3hnYkhpM1A3cW9RSTdDTDJUc3VlUms1Z1dxRjBCUkpIM2gveHp6N1dK?=
 =?utf-8?B?akwrcy8yNjdGcDY0Y0pyTkhlUFNGaVhYRkwxMlRzUGpvUDF2QWo5WGlEeG5H?=
 =?utf-8?B?TEIzUDlBUWdDV2UrZkxvVG9lYzNjTGN3WVZ1ZkExTXk1L25kWlpWcXpDaFBF?=
 =?utf-8?Q?1upYXv/nAYsPkKl/Rf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee3c30d8-741c-453d-61ab-08deee51e896
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 15:47:49.6680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ms+aRMX1pMb7OGO6P6VywAih83hZSsthQEC0kgqlJHlwQgDllFG58NHScTJw21QKF7gdkmuyQh9S0/B2ERuaJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8945

On 7/23/2026 12:35 AM, Richard Cheng wrote:
> On Mon, Jul 20, 2026 at 10:06:34AM +0800, Bowman, Terry wrote:
>> On 7/17/2026 5:43 PM, sashiko-bot@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>>>
>>> New issues:
>>> - [High] Removal of explicit PCI error handler forwarding for RCH devices leaves RCDs bound after a fatal PCI error.
>> This is a false positive. device_release_driver() is called in cxl_pci_error_detected() 
>>
>>>
>>> Pre-existing issues:
>>> - [High] Preexisting lockless dereference of `dport` returned by `cxl_pci_find_port()` and `cxl_mem_find_port()` leading to Use-After-Free.
>> This is existing issue and is not planned to be fixed in this series.
>>
>>> --
>>>
>>> --- Patch [7]: [PATCH v18 07/13] PCI/CXL: Add RCH support to CXL handlers ---
>>> commit 6a99c70b18865d01d350aa367342e701ebe6dde2
>>> Author: Terry Bowman <terry.bowman@amd.com>
>>>
>>> PCI/CXL: Add RCH support to CXL handlers
>>>
>>> Restricted CXL Host (RCH) error handling is folded into the new CXL Port
>>> error handling flow. RCH protocol errors are forwarded through the AER-CXL
>>> kfifo, and the manual CXL.mem error handler invocation is removed.
>>>
>>>> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
>>>> --- a/drivers/cxl/core/ras_rch.c
>>>> +++ b/drivers/cxl/core/ras_rch.c
>>>> @@ -96,18 +95,21 @@ static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
>>>>  	return false;
>>>>  }
>>>>  
>>>> -void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>>>> +void cxl_handle_rdport_errors(struct pci_dev *pdev)
>>>>  {
>>>> -	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>>>>  	struct aer_capability_regs aer_regs;
>>>>  	struct cxl_dport *dport;
>>>>  	int severity;
>>>>  
>>>> -	struct cxl_port *port __free(put_cxl_port) =
>>>> -		cxl_pci_find_port(pdev, &dport);
>>>> +	struct cxl_port *port __free(put_cxl_port) = cxl_pci_find_port(pdev, NULL);
>>>>  	if (!port)
>>>>  		return;
>>>>  
>>>> +	guard(device)(&port->dev);
>>>> +	dport = cxl_find_dport_by_dev(port, pdev->dev.parent);
>>>
>>> [Severity: High]
>>> This is a pre-existing issue, but while this change correctly closes a
>>> lockless Use-After-Free window for dport here, does the same vulnerability
>>> still exist in cxl_pci_setup_regs() and rcd_pcie_cap_emit()?
>>>
>>> In cxl_pci_setup_regs(), cxl_rcrb_get_comp_regs() dereferences the dport
>>> returned by cxl_pci_find_port() before any lock is taken.
>>>
>>> Similarly, in rcd_pcie_cap_emit(), dport->regs.rcd_pcie_cap is dereferenced
>>> entirely locklessly, and then the function takes guard(device)(root_dev)
>>> instead of the required &root->dev lock.
>>>
>>> Since rcd_pcie_cap_emit() is reachable via sysfs attributes, could an
>>> unprivileged local user trigger a Use-After-Free by reading sysfs during a
>>> concurrent device hot-unplug?
>>>
>>> [ ... ]
>>>
>>
>> This is existing issue and is not planned to be fixed in this series.
>>
>>>> diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
>>>> --- a/drivers/pci/pcie/aer_cxl_rch.c
>>>> +++ b/drivers/pci/pcie/aer_cxl_rch.c
>>>> @@ -34,42 +34,37 @@ static bool cxl_error_is_native(struct pci_dev *dev)
>>>>  	return (pcie_ports_native || host->native_aer);
>>>>  }
>>>>  
>>>> +struct cxl_rch_error_ctx {
>>>> +	struct aer_err_info *info;
>>>> +	bool enqueued;
>>>> +};
>>>> +
>>>>  static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>>>>  {
>>>> -	struct aer_err_info *info = (struct aer_err_info *)data;
>>>> -	const struct pci_error_handlers *err_handler;
>>>> +	struct cxl_rch_error_ctx *ctx = data;
>>>>  
>>>>  	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
>>>>  		return 0;
>>>>  
>>>> -	guard(device)(&dev->dev);
>>>> -
>>>> -	err_handler = dev->driver ? dev->driver->err_handler : NULL;
>>>> -	if (!err_handler)
>>>> -		return 0;
>>>> -
>>>> -	if (info->severity == AER_CORRECTABLE) {
>>>> -		if (err_handler->cor_error_detected)
>>>> -			err_handler->cor_error_detected(dev);
>>>> -	} else if (err_handler->error_detected) {
>>>> -		if (info->severity == AER_NONFATAL)
>>>> -			err_handler->error_detected(dev, pci_channel_io_normal);
>>>> -		else if (info->severity == AER_FATAL)
>>>> -			err_handler->error_detected(dev, pci_channel_io_frozen);
>>>> -	}
>>>> +	if (cxl_forward_error(dev, ctx->info))
>>>> +		ctx->enqueued = true;
>>>
>>> [Severity: High]
>>> Does removing the explicit invocation of the err_handler leave RCDs bound
>>> after a fatal PCI error?
>>>
>>> The standard pcie_do_recovery() on an RCEC does not iterate over its
>>> associated RC_END (RCD) devices, so this manual invocation used to handle the
>>> CXL.mem driver fallback. Now that errors are routed solely through the CXL
>>> protocol error work queue (__cxl_proto_err_work_fn()), the work queue only
>>> panics on uncorrectable cachemem errors.
>>>
>>> Does the work queue replicate the PCI recovery state machine's fallback
>>> behavior, such as calling device_release_driver() to unbind the CXL.mem
>>> driver on frozen channel states?
>>>
>>>>  	return 0;
>>>>  }
>>>
>>
>> The change to forward CXL errors through Kfifo using schedulable work is 
>> intentional. This series does not exactly *replicate* the PCI handling.
>>
>> The device_release_driver() is called in cxl_pci_error_detected() for 
>> pci_channel_io_frozen. cxl_pci_error_detected() serves as the PCIe error 
>> handler for Endpoints, including RCDs.
>>
>> Terry
>>
> 
> Hi Terry,
> 
> I agree with you on this part, but what I can't find after this patch is the
> path that invokees it for an associated RCD.
> 
> you replace all error_detected() for associated RCD with cxl_forward_error()
> and queue CXL RAS work, what if a fatal case where it finds no RAS UCE?
> 
> It'll return normal and RCD driver will remain bound won't it ?
> 
> --Richard
>  

Hi Richard,

Rereading your question, let me give a fuller explanation of the Endpoint UCE
paths.

CXL Endpoint UCEs (both VH and RCD) are handled by the AER handlers, including
pcie_do_recovery() calling cxl_pci_error_detected(), for both severities - so
the Endpoint is not left bound. The two severities take different
call paths:

UCE non-fatal
=============
The AER status is readable, so the event is classified as CXL and forwarded to
the kfifo. Below is the UCE fatal AER path:

handle_error_source()
   cxl_forward_error()            [enqueue kfifo]
   cxl_proto_err_wait_for_empty() [drain]
      cxl_do_recovery() -> cxl_handle_ras()
   pci_aer_handle_error()
      pcie_do_recovery(io_normal)
         cxl_pci_error_detected() -> cxl_handle_ras()
            return CAN_RECOVER        [normal -> recoverable, driver stays bound]

UCE fatal
=========
The uplink is unstable, so the AER core cannot read the source's AER status.
is_cxl_error() cannot classify the event as CXL, so it is handled as a PCIe
error (not forwarded to the kfifo). It still reaches cxl_pci_error_detected()
via pcie_do_recovery(), which releases the CXL.mem driver on the frozen
channel. Below is the UCE non-fatal path:

handle_error_source()
   pci_aer_handle_error()
      pcie_do_recovery(io_frozen)
         cxl_pci_error_detected() -> cxl_handle_ras()
            device_release_driver()   [frozen -> unbind CXL.mem]

So the Endpoint is not left bound after a fatal (frozen) error.

The non-fatal case does call the RAS handler twice (kfifo + AER path), but this
is benign since the CXL RAS status is W1C.

Thanks for the careful review.

Terry  

