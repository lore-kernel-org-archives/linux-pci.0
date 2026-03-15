Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010036.outbound.protection.outlook.com [40.93.198.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD2B1A6820;
	Sun, 15 Mar 2026 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773582605; cv=fail; b=FBdE6MApAcZ87RRTBMOL+bwSwQ00n/8ysKRVS9vRO9KZjfw7DKBx71w3J6l0stnVv1CLzctiaEZMLqfL3tyaRtqv64ENL+Qw6br2sYxei9Wufv9J6IreNV0ksX4OvwJHFusXYom5MuvjXO6vPGTz15mNpLBHFsuua4qNob0zokQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773582605; c=relaxed/simple;
	bh=hPuwc+ud/laqrskCCrIoq7HR2cxJ38TyUDiZ3Tji67I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YhIY4c0g4a9XuaV/Q5q+PvAiRhrGkAkpko6ZGUMAm4eBszMyDtmKHcnwheoYAsy20bRsoaDUhSQtC4WdXPUJH/onIbDJo4RtOLMnFgValWJEyJi9HrJCnQBDoOWw+KThNK4A+0L3tSieBv2NKGDFvmHs4XuJJX6ngAvucY1NbXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RTW7YP+q; arc=fail smtp.client-ip=40.93.198.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RTW7YP+q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLA9B40A371Q/ZlzeDVFb4S32qKLpG/7gHRs/zG5XWZ1zg34wI7lE36LdmE8bBtsdhWvN4td6Xy5lIMta55mAFWdXGrloP89s44CyENW5OodrqkRYK7vpbxYfXADrIO796nUjvuqF5L69iCjV24oklo0YnG1lelacNpCEnnZ2vCnHKQSJ1davCc4xck/r9tEp9+/ElKH1oyqoTH5Uba2ksuKlcOXUvBYTera6fgM9tajGLNqzXuZr85noN5v85/BY7joOJG9JYFwNrXDnXm1cLuDKAhB5JP12fXmEdUSe64wLbiI8LhI7RB/5djNyh4bW9YwMT66ZMnPFUXAC/WXlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsspOQh+WG2jdoanmMtRX2ocgN1dA4l//iyC8C0Owtc=;
 b=B7AY4pgAbXoxAxQVFuLqWmXeMBlNaok7jQjWexw6PTb8yvczRsVkv5hdV+Tb7S0buzGywA0vsLuTeveIyHyMxGLbd/GOgMrRiP4OVCwHSsYkBfq6s5ay3G/PSjculCdnoSTFSAHL4Ph9DwZJiKyv/nCsU0YPuXfzSZPz0Vi4yZnOqW8TtEkb++lJ7Wh3I7tF9II0pq0qOBoWPgi9c/4T+faXoVgFj+jBGcFHvqVDnpHMxmtltjE4cddvzJiEPfzMwY/sEPwyKIXjwrs0/uThE9Ul7YF2ishhKmNM4EhyTb+OQ8HBeDV0oJsshd6DHTcLJkR/IyEXO3iYu0ExhRaSGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsspOQh+WG2jdoanmMtRX2ocgN1dA4l//iyC8C0Owtc=;
 b=RTW7YP+qCSanHQ2Kt7my5kUq0Y9VD2f4CHsBIdTeMlcWaNZ6AMfPPoGhzF8VkjF0Tglzbh7ur7q5i4YSXOfybIkujupDEs51gC/aYJMa8Yl6vzkNZ1J8ZMO6lupHZLpggX7pIpPP8K27VXyQ6yngFnJ6gFNRmwoDhzjY8JamEOkDDRkpN8LsobyyvBXso2iYk7YvjET9n3g5TG3O77VxdEpNYTWdVXTpXdI/A0AVQACZ8TRGs/qGmic9Lrm3GeNNg9UzaiAX80WruLaQxfQFRd5uKVrs9DmfexB4ES2agMj/9rTIVJvsWE9qqJIMPGr9MQaLC+bjZ+M7A2hldQVDWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8244.namprd12.prod.outlook.com (2603:10b6:930:72::7)
 by SN7PR12MB6816.namprd12.prod.outlook.com (2603:10b6:806:264::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Sun, 15 Mar
 2026 13:49:59 +0000
Received: from CY8PR12MB8244.namprd12.prod.outlook.com
 ([fe80::d30c:fb69:3020:73e3]) by CY8PR12MB8244.namprd12.prod.outlook.com
 ([fe80::d30c:fb69:3020:73e3%5]) with mapi id 15.20.9723.013; Sun, 15 Mar 2026
 13:49:59 +0000
Message-ID: <e05d3b86-8c80-4ae2-bbdf-c346afd32c6d@nvidia.com>
Date: Sun, 15 Mar 2026 19:19:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/13] PCI: tegra194: Set LTR message request before
 PCIe link up
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 Jon Hunter <jonathanh@nvidia.com>, "kishon@kernel.org" <kishon@kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "Frank.Li@nxp.com" <Frank.Li@nxp.com>, "den@valinux.co.jp"
 <den@valinux.co.jp>, "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
 "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
 Vidya Sagar <vidyas@nvidia.com>, "cassel@kernel.org" <cassel@kernel.org>,
 "18255117159@163.com" <18255117159@163.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
 <20260303065448.2361488-8-mmaddireddy@nvidia.com>
 <x5m2omsus72plxulgt66hov5giw2t5madb6zfzyr2e2o5ojm4b@uhyuycoa6gpw>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <x5m2omsus72plxulgt66hov5giw2t5madb6zfzyr2e2o5ojm4b@uhyuycoa6gpw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0131.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::19) To CY8PR12MB8244.namprd12.prod.outlook.com
 (2603:10b6:930:72::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8244:EE_|SN7PR12MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ac5dfad-e7e5-4d76-abcb-08de8299bf90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	mhcIM9UJIESt1PRnB5O0AKABQrBaDe9fOAfGyCpMXsU70UIpzTMNr3c85ryC7mueTIY3M8oN/yA/Op1Uai9hSgp+KDohSRpxJVZoN0sTbMrMxwU2rRhJXvEoET9Ig0gSfdufe9lYGrRrSJKGVFQZu4NpbwiZqfLjdwreNwos8CdnTO/1/aq6wrFQ8E1xvFxybZn4RwnavnokjaYB71W/5d1CAiLl+8ylP9WRjgLKLnAb/YwouGdCqL4e6xDImWlE6T5B4aTWOirMd2lKdcEsbyixLq975ef146CLa8l5LUdjwHFbbOVbseEW7fIHsMB5emk2wf/e/YL3txKH1+5FnI9bHwdQm0ViplbXuS60hbU3DtoWw4S5iPPUgxvJU/8KbJ00zPxqPw+RNWoQcnNlNBqN8g9olRexNhEffw0F+PEMjDW0Z/RJnN8w69Wf2TZUUBPpU2+FsqLb+VX5/upbIGSzUY4Te/vZcdNfv7gtkYrlFSbFxRIie48H+R8Vrp5Syv/yMH9Y7PsLtOYvz+MlwSKx+UM6SQeHtcpiDb2bdloz/oxJBm4h5WaEtryff+k94qEU0kStJYSDgZ5s5Et3nbqcd5dalYhvE7V/4HXlO4/pXnUsgIdJx+U8UpSzB64/XiwJyRK5cOAtTY2iGbXUHQkWrReD/j5tc6WFvx/ZRmjmBBLXSDME9kltUiii1NP3TcECR9rHlDRw3Emm4z5T9oldYsPGM3fvd2pJ3/KxDyU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8244.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0c0SXc2bnZVMGxKNmlrWE9IVzJnYnUveUtsU3ZTRTNFcFV1TGJtaUxkQUdB?=
 =?utf-8?B?c00vS3d0VUdGdTZ0SGtyV3pCbXZkZEFkdHRReW4xeEd2aUo4R2xqSnlYa3Nr?=
 =?utf-8?B?U1JkWjVqRDRraGQrclpkamkzMlF0Sm91K0FFMzVwbTNNUUt0SkFiN3VlaFE3?=
 =?utf-8?B?RlZrcEdFZlRWNGZEMWFlVVNDV0RqNTk0UHdTakdKWi9OUW1lTjMyNzQ3ODN4?=
 =?utf-8?B?YU81VEl6VGRldEd1clI4M21BR0NMMHBqTDMrZmxIUEtRWVNLUENhR2xSYWZs?=
 =?utf-8?B?ZDV5S2YxNUFINXRpcTJWcGZrUXZpVDZCd29MYmJneGdQajJUS0pNWjJVT3FI?=
 =?utf-8?B?WkkrTlNTUkVQbXMrQ0U5VjlkS2s4dVg2eVlJYTAyMkQrd21LODRXVWtIRlAz?=
 =?utf-8?B?cnYySHhUSlVIcWpHRlJ0RGFvVUxSUStLak5pS3U0dkpDQ3M0VHpHWHV1dHEw?=
 =?utf-8?B?ZG1abkFBNU9meHZHYXdoTi9HdGpZWTJVanJxSVNrOEZYSml0NWZHdTJwbHgx?=
 =?utf-8?B?UlRmWTVoTldLK0RjY1pBb0tnaGMxL3g2dFphVVc5cmNRSHh4cmlYRW9NRm9w?=
 =?utf-8?B?eldBYU1qcmg5Qld3ZUhSTFFibjZJTTBqQXBNMGR4bXgrQnVjc1FPUUcyY1Vv?=
 =?utf-8?B?TzZKaHhyUzdhbnRDRlN0dHEyT2tDQnJvTXlxQUFDdDgrWFU3dkZoUm0xcmVY?=
 =?utf-8?B?UFhFK0F5ZGU2WC82VFhUWTVhYXpra1BwSUhjZkcwWDN0cnc4RUM3ZFZvLytK?=
 =?utf-8?B?V0dKQzZLR2drVVZwK1Z3Vnd3TjI1U1FSZFhhdm5oYVRBbTEwM1FKOS9hUFBr?=
 =?utf-8?B?cCtCOWtTZDdRVkdiK3FVOGRYMDVqZTd4aFpuZWdjNk9HbS81WGdSS2tabzNP?=
 =?utf-8?B?MjBORFUvOWZaL0xUb3JzWXVHbGlnbmYrLzJjY1ZUQ3lEYjQ4enNkQXlIZ3ls?=
 =?utf-8?B?d1hKZ2lHaTludVZvUjZSUG9EZk9oakJjakJnY29TekFxUFFCMWhTbm9xYjBR?=
 =?utf-8?B?ZlppN090VE9LbXpQNEpGb0RSWEhNNVcvaTYxOWR6YmhqaytWKzF2K0lBVWlC?=
 =?utf-8?B?WEY5WnFjR2NFU05NdzlPcFF1cm1jdG5vYVI4aXhkUU5UYmsxRDNFd3gxSnZJ?=
 =?utf-8?B?T1loVk5nQWFNNys0cXJ1YWFGUjBHN0pIU0xISUJkdTZwYkRtT1BXZ2RueUgw?=
 =?utf-8?B?aEpJMWVzbjhMdlEyNmNSbGFwWDUyWURUQVR1cklRdDVkQVFMdEZTK0UwSVdj?=
 =?utf-8?B?M0pvQ2NucFI3Y3lJZCt1WHhwOXNwTkR6RnEzb0NMam9lSkFPTHVIT0JxdHhX?=
 =?utf-8?B?NzZ2d1JMVllTbkttWnN3ekcrQU5BQ3A1UWVmRytSQXQ3KzNndk1NeVBkVndt?=
 =?utf-8?B?VzI2bFVHRjNVcEJ6bVh2Q3RiYzhpeXgzZ1hyUnlmWjFyWi96d2x4U1lhNnJ4?=
 =?utf-8?B?TGcvSUY2QjhFN2FvYjJjUmRveVVEcEIxODUxRzFQRzEwTVV2bCtZV05YZ1Ns?=
 =?utf-8?B?Ync5cTRMM2pXSWN2Q2xzOGN5aTU2THg4RG40bC9uVVB0WENDYnhDRFpIY1dK?=
 =?utf-8?B?NzlUMWoreFZoV3JHOE5IeXY1dmNqcmZMVC9nUDJIZnRrMWRpNXNkRFlsaVJl?=
 =?utf-8?B?eGhvQU1jNFdrYk8zbmNNQy9UR2NJcUc5clQ1NTlqQk5QMm1QWldvT3FkRk4w?=
 =?utf-8?B?MFVrbmtYSHBxWDV0aFNseGxwV0pEaExINFd4aFZIQXdUYlRHdTJYaW9YcFVY?=
 =?utf-8?B?R1g0aTJ6U3NkZU80UlNFTnBxczMzMXYyYVFwTVYzdnBsQkQ4Q05YUm1kaVRZ?=
 =?utf-8?B?V0tOaFJuaTBqZit3blJvRG1UQVlxMnhITkhyR2paMGY0K3JJd3FlUHJONXZq?=
 =?utf-8?B?RXJJTXcrYlpUSU5lQ1FndmRNaGJSbFkwQzlHOEtRUTV6U1RJQVpPaGxhZXBY?=
 =?utf-8?B?aWFIMVpSYmFGRExRaURMcDJoYUV1U00wRmZ5Zmt6d2wvTzVrQnI1dXMwT2c5?=
 =?utf-8?B?alpadXhqeml0RjdNdWI4aU1mWXZKUlpCYzUvbXVOVDlkUTVSRDN5WFIrSDEw?=
 =?utf-8?B?blpKWjkyaXVMemIvYVcvb29vaFJqN3NjaW9ycXlmMklITGk3OTE3ZFh2MnBG?=
 =?utf-8?B?QnBxUTVTNDBybVJzSm9pZ0JLUHJFV2Z6bUpCVmd5NDF3ZnlKZFFUK1JLc21x?=
 =?utf-8?B?cDBLeXVRamxMNmxjcWQvRkp5NE9XSzNnajVkaDV2Z2d5QjZVS1FOZEdCMkxn?=
 =?utf-8?B?cTd4cUR0djR1SkdnaERtVGdXWm9tSE1MZXdjeHphZnQ3SmlYb0EvRG85TkFw?=
 =?utf-8?B?NTBqTHJoNFlPNTI4YnNKQlZWbUZienpiVjZpaGdQeVE4RlRJcXJpQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac5dfad-e7e5-4d76-abcb-08de8299bf90
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8244.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2026 13:49:59.1873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k9iGDyoV/CJgk54pPsnUAt5sLd0YslAbXIuMvcDxBYlX5gUyO3+jC3AnQqppzzQaWJDGXFIxSGfdbRTo4VdACw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6816



On 05/03/26 3:48 pm, Manivannan Sadhasivam wrote:
> On Tue, Mar 03, 2026 at 12:24:42PM +0530, Manikanta Maddireddy wrote:
>> From: Vidya Sagar <vidyas@nvidia.com>
>>
>> LTR message should be sent as soon as the Root Port enables LTR in the
>> Endpoint. Set snoop & no snoop LTR timing and LTR message request before
>> PCIe links up. This ensures that LTR message is sent upstream as soon as
>> LTR is enabled.
>>
> 
> 
> 
>> Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
>> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
>> Tested-by: Jon Hunter <jonathanh@nvidia.com>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>> Changes V6 -> V7: Retain FIELD_PREP() usage
>> Changes V1 -> V6: None
>>
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 18 +++++++++---------
>>   1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index 2da3478f0b5f..b50229df890e 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -485,15 +485,6 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
>>   	if (val & PCI_COMMAND_MASTER) {
>>   		ktime_t timeout;
>>   
>> -		/* 110us for both snoop and no-snoop */
>> -		val = FIELD_PREP(PCI_LTR_VALUE_MASK, 110) |
>> -		      FIELD_PREP(PCI_LTR_SCALE_MASK, 2) |
>> -		      LTR_MSG_REQ |
>> -		      FIELD_PREP(PCI_LTR_NOSNOOP_VALUE, 110) |
>> -		      FIELD_PREP(PCI_LTR_NOSNOOP_SCALE, 2) |
>> -		      LTR_NOSNOOP_MSG_REQ;
>> -		appl_writel(pcie, val, APPL_LTR_MSG_1);
>> -
>>   		/* Send LTR upstream */
>>   		val = appl_readl(pcie, APPL_LTR_MSG_2);
>>   		val |= APPL_LTR_MSG_2_LTR_MSG_REQ_STATE;
>> @@ -1803,6 +1794,15 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>>   	val |= APPL_INTR_EN_L1_0_0_RDLH_LINK_UP_INT_EN;
>>   	appl_writel(pcie, val, APPL_INTR_EN_L1_0_0);
>>   
>> +	/* 110us for both snoop and no-snoop */
>> +	val = FIELD_PREP(PCI_LTR_VALUE_MASK, 110) |
>> +	      FIELD_PREP(PCI_LTR_SCALE_MASK, 2) |
>> +	      LTR_MSG_REQ |
>> +	      FIELD_PREP(PCI_LTR_NOSNOOP_VALUE, 110) |
>> +	      FIELD_PREP(PCI_LTR_NOSNOOP_SCALE, 2) |
>> +	      LTR_NOSNOOP_MSG_REQ;
> 
> As per the spec, the device is not permitted to request Snoop/No-Snoop latencies
> greater that the Max Snoop/No-Snoop latencies set by the host depending on the
> platform requirement.
> 
> But here the driver is just using a hardcoded value without reading Max values.
> It may be assuming that the host is always going to be another NVidia platform,
> so it sends out fixed LTR latencies, but that's not going to be true always.
> 
> Also, the host can update the Max latencies at any point of time during runtime.
> 
> - Mani
> 
Agree, but this patch is only addressing case where max latencies are 
not yet programmed by the host.  Without this programming Endpoint sends 
0 latencies to the host. Once host sets max latencies in the config 
space, HW compares the above latencies and the max latencies configured 
by host and sends appropriate values to the host.

- Manikanta

-- 
nvpublic

