Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010022.outbound.protection.outlook.com [52.101.85.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD3E221D96;
	Sun, 15 Mar 2026 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773580903; cv=fail; b=UgigOroZxYVv/TC+/wofakBLD6frurQ/BqRuOWSTN92jhrsiYtCMsjxw543AhhzWYnHS+TtbEkso3Jua9ShTXOqc5fsCT4uCJDBsSFqdgb7JZZxJlWXciQIH0tUAChxhRI/vXHhBnt9gCPJv111v36d7lIX69zC8uzEDueH4BTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773580903; c=relaxed/simple;
	bh=eZvJQabK/lUTYbpJRwcScT1glntzniDMWTCC47gJz20=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hXd1WGpGAgYcAlDVTYk+r5drjcSHoqaymrubpWidcQaqMz0k6+F9r5KNIqWLjzqxonKqCWnh7id1IPgF0GgWEZNz5X1pWw1VgOM58Nc0ZCRyYs/v1VgtrnpvpjxqaXnFxtwj96FlM1kTyw7RaymwQ5PoApaUL68OnqLTCCOnwsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DCwAV3TV; arc=fail smtp.client-ip=52.101.85.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DCwAV3TV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFkPofyYjNCq4fUSLQvnGpCZa7q0oJF2Px2A2VU+yHsElNQsr8GYYj3J/C9SdOT/kfI4AwnIktxy1MjTYqzCqkRF9fMRNau2Bns0MIKJT3WlPActrbBjWR0Ur4HI795qYWo9PLlaGYtpcszpCklpfuR24yXIc3vOC6gQMoUt1OZNOEdXpXW1EnYZmYhp7+ALg5T6DhXR6IxkpXC7SDSWjMgb1gJfSL7FT/mECdqO8GK21eDPIGbkbjKQMuco8Xlpv5pmBTlXUpK1OT+T2eCcRd4v1ghLtltplXFSM3ZC20gW576pSQbv7X+A7gw0zJT5d3J/J0XBMv4/QVrXl5QT7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6wYsCu8ozFw6lRDWumpQzhuSu5dF4Dt7myKXItUiMg=;
 b=oWbeukjcfGaYWusjpxIS1AMCeImmfndP6M46TwFsGCaZE2ZjdncW2z/QPP02PLim7exZrzSifn/Pqx5XJ+zPtxHeiRL4SlD2CoCpKD3cg4BaU3ArK5WKDfGpIOpa1p4yu0y9KF+QGiKVYFv6BG2TmWrWPA8o8jJmBVGw7ON4tM9X4na71EXDiKHFX8509YNMJlwZC+W/ZQoqTPVqnOPKmYneY4p/quwLidONSJUBfKeUWcA7Pjxb1qOds5856vNgF9Dlht1FBcC6p0gnq5Ctj1d0VPnKmK2Zc+qRnlnBx3HBAACNH0s6sfbudMCA0snqz8ueuJljtldy33T1RTb57A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6wYsCu8ozFw6lRDWumpQzhuSu5dF4Dt7myKXItUiMg=;
 b=DCwAV3TVdCQG8Za1X/of+waXw20CxSDVtKLFufUCaeSVrt7tk9pjqNnLC9Mrrl4kdeGt5+MfEzfF1hHNAVvsEoCvG+pP4UOS5kFiOx2hs+y6ZgPLMAhrN8gqXtuHXY8nN285j+SAAFfQ3BoTAq/xpyllB+N9/oe78iRtXuAtHSUkw0VviOlw88eBuATpA7bjrvgCjjl8XZrGQjeCGWw/rEZNmC9codJrc0fif5yTWVqv7so1923dk9Mt5SHxlbiPbNqr4rhjsWA1aMaJpYXhG7xlDJS4ECZ0pTAsjv5p00bci7Uzy3pGXqYwNgbjjslDwORzKw9xbmgoGEYIm0/GJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8244.namprd12.prod.outlook.com (2603:10b6:930:72::7)
 by DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.13; Sun, 15 Mar 2026 13:21:35 +0000
Received: from CY8PR12MB8244.namprd12.prod.outlook.com
 ([fe80::d30c:fb69:3020:73e3]) by CY8PR12MB8244.namprd12.prod.outlook.com
 ([fe80::d30c:fb69:3020:73e3%5]) with mapi id 15.20.9723.013; Sun, 15 Mar 2026
 13:21:35 +0000
Message-ID: <a917e475-1ae9-4e12-98a1-babc49f042a7@nvidia.com>
Date: Sun, 15 Mar 2026 18:51:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/13] PCI: tegra194: Don't force the device into the
 D0 state before L2
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
 <20260303065448.2361488-4-mmaddireddy@nvidia.com>
 <6ekumkzuh6znxzf4deaawc46mgoen6haxcrvrein2irpw3xqhc@shwkkvjnlj6h>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <6ekumkzuh6znxzf4deaawc46mgoen6haxcrvrein2irpw3xqhc@shwkkvjnlj6h>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b8::17) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8244:EE_|DS0PR12MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: 38e0c8d0-8952-413a-1018-08de8295c77c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MnEtJEPIMf3bgyi7eHdUDeJ1va3bQha0dDP84GtPC2U+YtEoHWtikXHUQHxnGZDl2282L3xjvFJhijr1OaoSO1SGvrOgs9hfDE44viP4i9vQjzDbAvhPeUzxgaOmeH5p8pMUOxulxtckWWMiMHz34lUorz305F0U4zT/Z5sS0/rVH50IIQQjShRZpxTVTxkH8P6tKRYJytgjBDiq4FNV5ZUja/4oKpw6F+kbwcFxxErtxFefOrAQikM7czYTjrtIkmPItLO07CdVGr9Zw1SxnACN3VclbsBLhromBlTf7BqDsRTRunGggMnZtdnAdJt4kt4ll5KJSuaJ3gtjCYYXkVwovVPVSnRAL1/3KzwP2vSCVw4lrD5bM9SHKlyEG8yDjxucCVn+YNjeTZ3k9L9BOKvW1sNPqK74euu6v57Xbg0YSwdlozuhYAiqotty4X6bsnONvEAdk8Fv9aq/odEg6vr45pttYrgeEVKlqCKf6MLW/Y62uox114YQ3BZD2Hvd/4WtwqF8Tx21Hcetx6QOEam2p5rkrkZ7NEeEKdRuSizX7QPFE/qyesjeDThslzMVTggMP5TbesUDid0sy+IoOwZHAmW0d+InBLyDbytll07jqsfLLXivRdKtP7vhgVd9nMr+PySfZALIZ71wrd4kMWsRumMqHn/KZJZYxrwEUBUAUpyyX8PKR6Eiz5e7QjmXYXgekhRthQ35+1m7OKqdAo0MW5l32rLflXx1JFzjbxQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8244.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rk5JQmN2OU4reEc5M2tTNGtKU1F1YXBOVjhoRFNzSEVTMlpTTjFCQ3ljQ0J0?=
 =?utf-8?B?c1VUZUdyMGJKREhQMkZ4VHNFTFpGMWdXSXZ2ek5CWVFDY292OUFKYWpkRE8x?=
 =?utf-8?B?NUFYdVU2bWs0dWZIQ1ZXNjdxTWRLRGZPTTVXNVV0STF3REdsbDJlazVuaEtT?=
 =?utf-8?B?Ujl3aUpQMm1ucDAvaEhGTkFSNEJkOEZieHE4cWovZUpkMmRkMnRSVzM4Q2NZ?=
 =?utf-8?B?YW9DWWtjOTIwbnFTYVhWR2NiaEIxUjJPRUNzQmVVMjF5ZlQ4L08xTlZLVlNx?=
 =?utf-8?B?SDh6akZ5ZGNPdGJ5S1hDaUJIUmlCM24vemV0WjVqWDBWTU1UTWNEZzlTZ0dD?=
 =?utf-8?B?L0lmQTlZWnFRQm9WMkpQNndFeVVqV29FZFg4NEgzSUF2WlBDdDlobE8zU0pY?=
 =?utf-8?B?Q3dmL2IyMXlERGJlcnpwRDRaNXFkV2w1WVZKc1YrYWRNL1NVb1h5RHp5R3l6?=
 =?utf-8?B?MXBLSVp1dGtoOUlmcXJic2UxQXZKallNVzUzTEYwR2VSVkR2YXNaVlk3OEJP?=
 =?utf-8?B?MkFabm5vM1RxV2YzcWxHQS92K0tjNU91TmhyWU5EQVRFM3ZtSnEwYnFzaS9K?=
 =?utf-8?B?VGFzdXZDQnluajVuUTB4OGphTVhPRlZ1ekoxU0RoOUlDbGZaVm13bUp5U21h?=
 =?utf-8?B?OXpmSUZYTzAvMlNFNDQ3SHVFQnF6bzgzTGVQR3V4MHd2SWtoUk5YWnhzRjJL?=
 =?utf-8?B?bnBxUi9pbUNsTHJ4M09yMU1OMWZ6RVFjTDVXOUpFa0ptb3V5dTlPWktISUdk?=
 =?utf-8?B?TUhTckszZHpGcEd4MnE4b0FiOSswRlpEL0dUZWZUdDMwTnIzYm5TVWFrdlNK?=
 =?utf-8?B?dDRwT1pSZTBHd3Z4bzNBejhnN2FPREVBQXlUU2hJT3pVWjJkcTNkZUZ5Z2Ex?=
 =?utf-8?B?di9RMjRBZEoxbVFubmF6WElkU3lKOXMraEgvanQ2ZjJjZFNwbnllZWJzK1Ft?=
 =?utf-8?B?MkVJV2hZaUo3b250RUZvRytOK25rOWhPdXowK29nVDVCWnEzdkN4UGVxUjhx?=
 =?utf-8?B?WmFRK1ZOUHk0eDZ3U1hVcHBoZFVGU2s4TGR2bEl2UW9yVzBJRkNtci94NTdJ?=
 =?utf-8?B?WElsM1RWTXhDQWJUZmR1RllxN0crdXkyWmxIVnZvdU9teWZ0anFsZEFMVFE3?=
 =?utf-8?B?Vk01dytjNXE1VnNaYmFsQXNYc1BEc3dwcmZUcy9wVTdjRFRsZjFzOFZ1WG9s?=
 =?utf-8?B?Yk04NGgvblR0dmRMUllCcXRoTHU0K3lNVEVNdnVwMjQ3VmU5Qjc1UEFFZk5v?=
 =?utf-8?B?R3ExeUJ2VC9idWtIa2RrS2RSTW9SZVdWeTcyTC9qVVY2VkNGYTRON1lnVHkv?=
 =?utf-8?B?NkxMZDk1WmdRYTJXTWVGbXg5a2xtQzZaNmxheHk5MG5SOFBRa3hUSCtnVUw4?=
 =?utf-8?B?RXZDRTdwTlRHYVVQM0dzUXVHb0hrUWFWNzBxdnBMbUhUajhYVXZRaUpCVnNG?=
 =?utf-8?B?bS9LQmlxNm1FU3o4OGF4OVRoMnhsRlJZMnFBZ0xHeXIyOHp4Y1VvVlhveGR1?=
 =?utf-8?B?bTBjRzJhaGpYdFYzVlVvR2FncEcxdjVIQTlBYXNNeHpmUUxXZENhYmVZNEV2?=
 =?utf-8?B?UFEwMXZ4NGtlZWtUYzZmL1VYZDZzaTJTL0xyZkRUeGJ1THpMZitiQk12bEVa?=
 =?utf-8?B?VlVJSmszSG9JRWZVRTdZUTR6YUo2ZnBTWmRDUnNwaVNEMjNTYWNUQmxWYUg2?=
 =?utf-8?B?SHY2VCs3ZmVhbnovcS9XQ2sreUJyb0VHQmc0MXQvNTllKzRVVFlMeG9LRy84?=
 =?utf-8?B?VmV1V2o1aHVPdXNKMGdOWWs0Tmo5RkJqYmhOaXFiakFMWjdERWIxNUg0RXoz?=
 =?utf-8?B?eDVUdy9Tc25JMXRPbkhPS1Noblc2QzhiYlUxTzhZcURLTCt6dnhsc3FIZ1E0?=
 =?utf-8?B?R0YydmdPSVZ0aTlXL2ltVmh1c04xZXJ2Q3Y5UnU3RFZyQ2plWWdaSEYzczhV?=
 =?utf-8?B?S3RzWG1ISzNpUlY1bngzWDQxdER1VTdIRU5YVElwd3lON0dEeEdmcUlrQWpw?=
 =?utf-8?B?WXczRzBWeitZdm8wVGwzay9MVm1xQjFDcjNNUXQyZWJsQjBiZk9UTlZNRHg0?=
 =?utf-8?B?a0dHMDJpOVJzT09kR0ZzRjhDL1BNcHdiMzM5YVhERUt3OXVhU0tFUWxWdGpM?=
 =?utf-8?B?T1o5ZTdIZTJQSm5TSGRhMW5Kb0hVOStyNTBXVzZtdUJYNEVJVW05U05TRGZC?=
 =?utf-8?B?eUxZR1dmaUE4N2xDN0NPcFBGNVk0OHM2WHI2VGh5TnVsa0g5dDZNRnpBZXZq?=
 =?utf-8?B?aFN5YXdKTTMrZStXSVRTelluZWhVTVY0NVEvR3BzZktUeFFqOTRiMHNqTFU2?=
 =?utf-8?B?bzBHN3pXYzJGY3I5aFdiRHdnbnZzZCtVTjJ5S1dhUWhKaVRKYUEwQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e0c8d0-8952-413a-1018-08de8295c77c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2026 13:21:35.4964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/5tftfZdNPboyWqClbXdN3tAhDVr6AshFKxP3b7PV7B78pFyTbFGUlzG60ktLMdJwyC6IGDHb7af0vEPmihbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559



On 05/03/26 3:10 pm, Manivannan Sadhasivam wrote:
> On Tue, Mar 03, 2026 at 12:24:38PM +0530, Manikanta Maddireddy wrote:
>> From: Vidya Sagar <vidyas@nvidia.com>
>>
>> As per PCIe CEM spec rev 4.0 ver 1.0 sec 2.3, the PCIe Endpoint device
>> should be in D3 state to assert wake# pin. This takes precedence over PCI
> 
> WAKE#
> 
>> Express Base r4.0 v1.0 September 27-2017, 5.2 Link State Power Management
>> which states that the device can be put into D0 state before taking the
>> link to L2 state. To enable the wake functionality for Endpoint devices,
>> do not force the devices to D0 state before taking the link to L2 state.
>> There is no functional issue with the Endpoint devices where the link
>> doesn't go into L2 state (the reason why the earlier change was made in
>> the first place) as the Root Port proceeds with the usual flow post PME
>> timeout.
>>
> 
> So the previous claim in the comments is not true?
> 
> I agree with this patch in principle, but just want to know why the comment
> claimed there is an issue if the devices are not in D0 state.
> 
> - Mani
No, previous claim is true. D0 fix is done to fix L2 timeout with a 
specific Endpoint. However, later realized that it is breaking wake 
functionality with other Endpoints. As I mentioned in the commit message 
reverting D0 fix still causes L2 timeout with that specific Endpoint, 
but it doesn't cause any functional issue.

- Manikanta
> 
>> Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
>> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
>> Tested-by: Jon Hunter <jonathanh@nvidia.com>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>> Changes V6 -> V7: Fix commit message
>> Changes V1 -> V6: None
>>
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 41 ----------------------
>>   1 file changed, 41 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index afbc0bdd8a93..831986de584e 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -1258,44 +1258,6 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
>>   	return 0;
>>   }
>>   
>> -static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
>> -{
>> -	struct dw_pcie_rp *pp = &pcie->pci.pp;
>> -	struct pci_bus *child, *root_port_bus = NULL;
>> -	struct pci_dev *pdev;
>> -
>> -	/*
>> -	 * link doesn't go into L2 state with some of the endpoints with Tegra
>> -	 * if they are not in D0 state. So, need to make sure that immediate
>> -	 * downstream devices are in D0 state before sending PME_TurnOff to put
>> -	 * link into L2 state.
>> -	 * This is as per PCI Express Base r4.0 v1.0 September 27-2017,
>> -	 * 5.2 Link State Power Management (Page #428).
>> -	 */
>> -
>> -	list_for_each_entry(child, &pp->bridge->bus->children, node) {
>> -		if (child->parent == pp->bridge->bus) {
>> -			root_port_bus = child;
>> -			break;
>> -		}
>> -	}
>> -
>> -	if (!root_port_bus) {
>> -		dev_err(pcie->dev, "Failed to find downstream bus of Root Port\n");
>> -		return;
>> -	}
>> -
>> -	/* Bring downstream devices to D0 if they are not already in */
>> -	list_for_each_entry(pdev, &root_port_bus->devices, bus_list) {
>> -		if (PCI_SLOT(pdev->devfn) == 0) {
>> -			if (pci_set_power_state(pdev, PCI_D0))
>> -				dev_err(pcie->dev,
>> -					"Failed to transition %s to D0 state\n",
>> -					dev_name(&pdev->dev));
>> -		}
>> -	}
>> -}
>> -
>>   static int tegra_pcie_get_slot_regulators(struct tegra_pcie_dw *pcie)
>>   {
>>   	pcie->slot_ctl_3v3 = devm_regulator_get_optional(pcie->dev, "vpcie3v3");
>> @@ -1625,7 +1587,6 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
>>   
>>   static void tegra_pcie_deinit_controller(struct tegra_pcie_dw *pcie)
>>   {
>> -	tegra_pcie_downstream_dev_to_D0(pcie);
>>   	dw_pcie_host_deinit(&pcie->pci.pp);
>>   	tegra_pcie_dw_pme_turnoff(pcie);
>>   	tegra_pcie_unconfig_controller(pcie);
>> @@ -2335,7 +2296,6 @@ static int tegra_pcie_dw_suspend_noirq(struct device *dev)
>>   	if (!pcie->link_state)
>>   		return 0;
>>   
>> -	tegra_pcie_downstream_dev_to_D0(pcie);
>>   	tegra_pcie_dw_pme_turnoff(pcie);
>>   	tegra_pcie_unconfig_controller(pcie);
>>   
>> @@ -2409,7 +2369,6 @@ static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
>>   			return;
>>   
>>   		debugfs_remove_recursive(pcie->debugfs);
>> -		tegra_pcie_downstream_dev_to_D0(pcie);
>>   
>>   		disable_irq(pcie->pci.pp.irq);
>>   		if (IS_ENABLED(CONFIG_PCI_MSI))
>> -- 
>> 2.34.1
>>
> 

-- 
nvpublic

