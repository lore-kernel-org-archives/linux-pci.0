Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013042.outbound.protection.outlook.com [40.107.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D8730F80C;
	Fri,  8 May 2026 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262136; cv=fail; b=P5QQ9bpbyQxts24e3xZ6e/hcK603lSi/zJkzCkWBDTdWTQ/defMS4cYNa6fTHEBO4xgYofpImhSf3WAeRU6TrxZOhJFTWi3zYMp3kamLeWQ8KYUE8thLRxjEAqVZ9GqyHVJX1EbPhKumx9oxhyOq1yqYRGfoXtgqdxdtdFOv7kU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262136; c=relaxed/simple;
	bh=i6K+BYDZVufHaeN6h5eSDaAwVeOid11DqS4rlTAJhpY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=irLvozOaHEjzbpbie8i4sQr4hIMAPo+5j1k14HtVjliTPV0kfvM4wjO29roLv8s1AedbBWzQSOrdqju0t7Yhhg93U17B4zawx/aCRFNKZiMMvmvT15upWA905U3zuVA4uxhKoTjzL7O2dOkY+4wIJn/DrBbOj5geA+wZyiryB40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IeJyE5yn; arc=fail smtp.client-ip=40.107.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IeJyE5yn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItI19QVwmOh322jpKacqFk54QeJN/JVf/wov5jAtuLBUFTXl5Gi/35dAzzE+cMzLNRJiB18cmpmAeGp2LdJAusENsUdQCsJX0nDWJ+xW/voXG3hymYSr5rSptQnICMjoM7QBRr2IQYivG/vxJzWQaVFIg0O0JipyAAgnrloldQBjhjmwS9PS+YkH7AdEDCIdyI9biy5Vs15n3w4ppBIjuuAXsFrW6qyx3uJ8xGbQcZJsHUwId3JEGntI+Ln6t/HiQcw5CAoj1v3ZyGI/NORDjAMsI1CV3nccKDkn2N1c2gdWxpwuM7SzdHH2kz/9wqV3MfCeHNSteQgPmFv/c3fVsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtnE7vBXYbgA8MHRYxi+gG9ZCMBu/1zFKYJjfnmyJJM=;
 b=XqVQ6qtgM3L0PtO9/q3EFzFGF23beN0y7snY79CPN+hiBrhImgEqyg+onXfSFqPtrIbV4zGcfqMvoruwoeO6ctSj9tXJhNzos8+QIClCWdQObzmXaGeeKjnOV+8BK7RZ8LiWKbnTNdMO8PMSEzJ2qVbH49NqC6OGg6NaBb4RJGuAnf9mA/By4lG2RR75B7WO80C3dhiQvxmlYsV8uiAzjwobrvW5IlSP0z0FCgMUcRfYFR8XR4uiXzMqgj6qMq+gH4KP8ZB6LeJPyctS+EcY14HKMiODMTry1UjVR3jljMdyX+NsVrbT9UhKzGE1VNOM1jDKecKdSp9ZVgAwlhxSiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtnE7vBXYbgA8MHRYxi+gG9ZCMBu/1zFKYJjfnmyJJM=;
 b=IeJyE5ynbMQWxLf0Hwo7++tedSQCHHPgXB6VXb5RrGVqJK5arj4dHtGuVKg2giggrMSO2Rh946sYXTEak1jBtemxrq9bO9RVMHrHOHdNB9SeM4yf/JzHjj2OqJ0dxa7bm1S2NDHpVFIGGnz7QmAW77DfDn3Lpcv15ycCuIPqBqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 17:42:08 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 17:42:08 +0000
Message-ID: <966c9e07-10e6-4abe-9cb5-77b974f31302@amd.com>
Date: Fri, 8 May 2026 12:42:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] usb: xhci-pci: add AMD Promontory 21 PCI glue
Content-Language: en-US
To: Jihong Min <hurryman2212@icloud.com>, Jihong Min
 <hurryman2212@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, linux-usb@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260508143910.14673-1-hurryman2212@gmail.com>
 <20260508143910.14673-2-hurryman2212@gmail.com>
 <ad41d70b-e9c0-446e-8bd0-4528de75b592@amd.com>
 <0d518d40-e239-4d93-8e71-0d2e140f00ca@icloud.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <0d518d40-e239-4d93-8e71-0d2e140f00ca@icloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:610:59::31) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|CYXPR12MB9337:EE_
X-MS-Office365-Filtering-Correlation-Id: a74c9945-ca0b-4d4c-fa83-08dead292012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	HXle4Ed8ZhL4v58i7277fUxSGCpMrQYrurTqH9A4r/HNlQpB+4665vfeMT9Bjmy7gSnHynyRIm4rr8OGFwok6W2I47s49yj/4atoETYWyngSFWeVJ2Gq0zP2VBXvlYlcQCclidV4MmTO1eh0GGImdvsTwnVjONEKE6Y+eisH0RUkk4bOUFxipgA/tzxrRfQ1SUFCd1qNCc00U+36TrqH2lSSX/zqwY0bfKFErpozELS/5YX4E4KIvSvIMlOLkUcZYoI/mJYoROFtzzyq1OOqW8nOp1GSQZu7sX/xvYgRxIR9cTBztdBnHB8LbXbUGq+fsaSmMhIr5iJ0I0t/cLMW07NO41sUAtJrkY6uAXuc5nSK+FDNM9BPxBl7u4mAY3AoClnzLenBfEevxQQeosWn3WLAq0VqOfal3+MJqzupx4hVZVmsgY1tGTBupbrYRmG3yZxKCs9E1B66G11l7TDOcQwLpZsFVieYxSTcGNWTcwIRX/nQdjvq9KLt65M4b3TOwGOEqpqrEm+s6Y+MBHbcjxaOmWbl3uEgoW528dqkXCtBYy+wzWjdH6iue2Mtx18oedjsuOK4CNcHGlBsqIogIBwJ+8o8LHxvgdQm+LjIiTYOZ2KTlbdGIOYx1KVuiljbksiJ0qIvmHF94zva+uyCW6PsYNZkzNxULYBiDXA3I8+DZNg5/CQJAmoZWanogEqX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEFyT2NQbFNWOXVVSGpkbzF1cDA2YmNWVTB4ZEppdHZxREptODA3RGVTN2hh?=
 =?utf-8?B?Z2RaVUFSOU5mZWhxZEV6cmtRdmpDTTgva1dxbi9EZG9mb1NpZ2crNXJKOTN4?=
 =?utf-8?B?Yjd1ZDF5YkROa3dtZGZRQjdybTd6eEIxSHZIaU5BM1FMVGFuS25XUzZQa0Z1?=
 =?utf-8?B?NnROeUczNGlCMVoybThWRit3OG0rSmx3amhMWEk1YTc1clJuNlFMbkZGQWFD?=
 =?utf-8?B?WG9EdkdrdmQyVlE3eXJaSGk0ZVQrdVlPOEQwZHlseE15WmtiUmIzZjBhSndp?=
 =?utf-8?B?bFJBWExDaWt2Mm4wU3loVk13Slo5Y1dNb2xDN2JCL2JxRWQvNzdqa2lSTkgy?=
 =?utf-8?B?a1pmTEF6ZXFQMU5oU0V1NFNvRVZnZStxclRuMjZaZyt4aEVyOVZFUE9iS2N5?=
 =?utf-8?B?K1dtbkZ2elJhcVlERGVuNlRacFN5T0hkbzNhZ1FhWmZ4WGE2WVZVSXZISFJI?=
 =?utf-8?B?L0xRemtCUDA4WkdXSGk3Zk5vLzRxRkRrMUZpK3l0YWlLOTlRMHpDbWRZdlkv?=
 =?utf-8?B?djBiVVMwbmlGNkVLM2k1VlhERXo1VktVOFkvMWE1ZElrQXlKSTNTSjBIaWN5?=
 =?utf-8?B?NWRHcUo5K3U1ZzRhQ3pOcXEydFlCUXF6S1pKS1J2MU9aYmo3d2ppWEhEeXpt?=
 =?utf-8?B?cHRkcXVLd1ZwNnRuaHVqK0FQQ1F5YnJkQ1dMU1Zma1VjTG5VdlF3Z3YyLzVZ?=
 =?utf-8?B?L3A1SlBnNTE3OFkydGE5V0luZElrK0kyQzlpdjExUzd4VXRxaWxhd0RuemZy?=
 =?utf-8?B?cDk3V20rcnlqMWl1bGNpaUZxQWZEblUrend2b3VhMFpxQ1NoTGZGK21XdEEv?=
 =?utf-8?B?blBGdmxucVpGN3c1ZGpHbFpYZEZkRjBnc3lkcUFxaC9DblBHNGJJQW12aG82?=
 =?utf-8?B?ZFcwK0pOaVhUU3NtTzFoanBVL3pPK1BtZDJEUVMwclA4YU5sY1FZdWFVV1Rh?=
 =?utf-8?B?WlBPc3BnVzBtRzFDS1E2NythcWI4andGTGZPdFJib2huVS9wTWVjR3luVkJx?=
 =?utf-8?B?eHRaOURUUVJBQ050Q0t4VUJ4RThyWk5LclJhK05QaXhwQ1R2L0xIb29pdFNP?=
 =?utf-8?B?SkNqaEpia2RxNk5ia0w3bi9lN0h1ZXFMZ3RadXl4T1Z3ampJTzFMQ3BBMFBD?=
 =?utf-8?B?bDh3YmZrM0ZrQjg2QjE5blNUWjZWOXZXV0FoN2lmSFprYWRaWjBWMWFIUEZQ?=
 =?utf-8?B?WWhqWVMvdkwzUm9qY1M2dVFmSE91YXZ4RVpjbmRVdFFTY1MwQ1dNN05UdGNu?=
 =?utf-8?B?aUkvWE9hc1Bpai9HRHhLc2RDMGtSYlduK2xhU01WSHRnV2FldGplWFdJeDNw?=
 =?utf-8?B?M3J5Qjd0TWFmRG9yWEtNS2J2Uk1abEZWNFJJQ24yWTcyT2R3VWZTaGhGQ0FP?=
 =?utf-8?B?MDhVWWZmSkdlV3lUSitoeFdzVzBxc2VydXZNSTNrRTlMaTZxM2VIM2ltSUwy?=
 =?utf-8?B?dUxOY0E1L0E5MVlxNTF6OVVITVBoa1orM3pWdXNweUp3c2NBSVJGNWtjbVdK?=
 =?utf-8?B?d1RJaEllSC9WMGNzSExOcmEraVJQUTVXNmk3bTl4RFBPYjZKVjI4dWg1YWp0?=
 =?utf-8?B?V3NqQzJyeHowNGpoMXVqeThLdUdDNnVPbEFOV1JvaVczVFpUbFBraVpqbnpG?=
 =?utf-8?B?ZGl0U241cFVzTGk5cWNLR0dCbHE2ZVZtQy81R0hqV2VMWmsxWi9RcFN3eVNW?=
 =?utf-8?B?Skx2Mk1iNU5UTEVGZVI2R2N0UCt4U082TFpEMFNuWU8xejM2ZkJJV3ZLblRZ?=
 =?utf-8?B?NnpOR083RXYva3V1UVFZVlBKYU4yYTVRbTk0eHhLYUY4OUt0ZC9LeDJJWU92?=
 =?utf-8?B?NG1ucWhRcnppekUvdnlGQW1WZm9FTnlWMDM2d3ZxYmhvR1cvT2NYMFZONndB?=
 =?utf-8?B?MVFtVFRXSlVzc05uN1pPaHA2SnNJSzRwU0tqZlNBMklraC95UjVLVk5SU2Yy?=
 =?utf-8?B?b1hSZ2RQOTV5bkErcy80U1lVejBKaTRUVEVIU2c0ekVHWGo4azE5YTMvTzVu?=
 =?utf-8?B?MmJBbXlxSDd1OVlwYzdoNnNkRWxYckErL2tsMVp2eThxTjVOUEgvcENFOTBo?=
 =?utf-8?B?SmI2bnNKUTdXcFJ3d1pWMzJ2RVdWLzN4QkVLR1RLREdlZ3dCYmdiTjlkcmdp?=
 =?utf-8?B?aWp4MEZSRGJwSDA2aEpqanNJb3doYlpXUFNxdzRLczJCK01mK3NBZlpNaVpp?=
 =?utf-8?B?RWgrckFUQ0g1WWt5NWE4WmhRQ3hWaHRnQVFMMUlzUjAvbHpjTlNPdnF2ajdi?=
 =?utf-8?B?Ni9SSFlYVlhKaW5McFpiM2ZCL0JnNzRFS09jekI4SG0zOVp5NDVZa0RDZFpJ?=
 =?utf-8?B?R1pYR1ByeW5UVmdZWmE1Z1dzL0VkOXhrL0l5MHVYKzZFSmswWXlPZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a74c9945-ca0b-4d4c-fa83-08dead292012
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 17:42:07.8593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YC/tITJvygaRqUWoYlD00ectm83OeClX2gR1ceN/Pk2olja2JVVBoxs1NUgRiXZukzOfYZKDWv6a+GqAIwTvDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9337



On 5/8/26 12:39, Jihong Min wrote:
>  > This define should be in a common header used by xhci-pci.c and
>  > xhci-pci-prom21.c both.
> 
> Agreed. I moved PCI_DEVICE_ID_AMD_PROM21_XHCI to xhci-pci.h so both
> xhci-pci.c and xhci-pci-prom21.c use the same definition.
> 
> Sincerely,
> Jihong Min
> 

Something else I was thinking about while reviewing this series.

Promontory 21 is only on AMD platforms and AMD platforms are only x86. 
I think the Kconfig should be conditional on AMD CPU support being 
enabled and X86 architecture so that we don't bloat other architectures 
with dead code that will never run.
