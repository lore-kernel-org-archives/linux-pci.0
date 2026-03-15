Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012066.outbound.protection.outlook.com [40.107.209.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F3574BE1;
	Sun, 15 Mar 2026 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773595091; cv=fail; b=NLAj7FA4Rev/gJZCBxq5ZcnuuYDzY6KylsYWq5l2yKXnK2eWe8472kxaQBK0qSlNjMS0q3aZX+yGYiiDSIq8ggY1yJoCtie5Nx3I4UPbwgtL32IDCx/uVS39NRDqNkN2rVQf58Giha5toKDRZJ6PhC2TnqWaqZZt9wc+vJZoORQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773595091; c=relaxed/simple;
	bh=i5P2yvLDy6lxZwEXPsvyWiZ7Oq0grcT2Urw3jlVN5nw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HO7LubMmP7bqIvNo1g7tyLw8/SEzrlp2+k4rJ7VQNh8X3G/6ZEwxd4Bw2yhOjH5QxbrkTJKPqk9X4qet3J50mJMsSIEBZyl7+l1s1P28KBRn7SbHtVs10P8UZ3Zna7zp0PdvWoylCdvkYpqjnHsWi9I3Djx2CezWWObfeV3HJxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tvo7aARU; arc=fail smtp.client-ip=40.107.209.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tvo7aARU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCOulrg7Jv9wfwlnCTsaYsPQQBC319CMR7IAGVC9GPw8vIESgyxqB8soLWJjqK0fnHK8BiiHCT3Q6vbDIUXHgXHFcpRUpA2cK/+UKAlLme/8bIZzxRLwNY43r0e9rVJl6TsZ4VzGmAyLN8xuRwFcjvBFYRR8w59Q2wA5L0hIFT2nK6/N62Ih3aIvVrP1WXZ2VTh/KMwGcQqjwlrf5qtYkPvK/qttmpb11by80VAqsq9gKpcbRcG+XqWQ1KtTeQdx8WbGRHsBTtseqiRhEKjvmVa1TlvGJiTbC9yKKe0zjp669LoWJZQiQnvY6JZpOKGJxHkoDSJtFenZBc0nGvrXlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMzcsiiDiUT+usJ5Fq984cngARNMu1NksRUvi85he3I=;
 b=DzBrSCowTY4+WE8ND+5o+quXwU59Sh/lMUTRqbuVIeheeUmhg+IhaX4BcJ1D9C5CyL+vUs31QhpSPRGaSM7bD1vmFwf4fS1D0TH0LcVU0XLT1doGhuL2d+aheJ78fb/okA4KH6vj0linD+JgQDNe/kzJFXSHbtPAqiEyV64NeeZ0uzG0WM38lLzn9UX8hW+6QZxbSbze8FAMQPVCFvUrq7UDJZVHvTaHR8aBPYnrXkVlLUnwKXWSOFQ/D2JGo1GZLd6mmX/MWqE4U9DRscBH6FAxWUfdgj8Uh78RnlKnqoNaN97yhx8LbuPvRJRUmibwjiYDV7aWfgjkO9Wt7taHkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMzcsiiDiUT+usJ5Fq984cngARNMu1NksRUvi85he3I=;
 b=Tvo7aARUj2bFL72IsTHX6mXjBh3QtjsuL5g2v/iw0hh0VPP9maq2SVAdeR4UA5U9VQxR1lNZx/rNLSyAGK+jWwig5DnGULPejUWZncTnlidNgWKvlvdwYMbFpYgwPZzTvWwYaGcAAKZS9paVi87K4/CpyWFYfHnTRN5rApASmp4aXDBBiPVHy0nOHqnJXQIMf2fc6utpCPPb5i3ixf16lkFaUQ/DwpUfPStSLzcToyJwG7ibjor2Rx5MpQ0FSqQ8spZTAaBLbXchCV7ed6EsBfyshNWlDxz0mArlI364vTTeOvaqgCBNIl4rMiM4SdkAuXh9JdNmtZuRyYBrr8J5DA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 CY8PR12MB7683.namprd12.prod.outlook.com (2603:10b6:930:86::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.7; Sun, 15 Mar 2026 17:18:07 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.20.9723.014; Sun, 15 Mar 2026
 17:18:07 +0000
Message-ID: <761e473a-983f-40f8-b141-8d648be8497b@nvidia.com>
Date: Sun, 15 Mar 2026 22:47:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/9] PCI: tegra194: Calibrate P2U for Endpoint mode
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
References: <20260303065758.2364340-1-mmaddireddy@nvidia.com>
 <20260303065758.2364340-3-mmaddireddy@nvidia.com>
 <x7w2a766h4m56kocibxz24uwjdlssbccg3z2pfcse4prk6c6fu@xwz7axizktyv>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <x7w2a766h4m56kocibxz24uwjdlssbccg3z2pfcse4prk6c6fu@xwz7axizktyv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0016.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::27) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|CY8PR12MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b5861f6-1f95-4458-eec7-08de82b6d31d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	s47n1iX1WCUnIok6CbYYj5rADnlpAyMclLFPmLy+tmefS5JH94HdzfRDjiFq3w+h07hdKHncW4qSJIUSqS0J0UQQy3TpM2W5dKq5B4pvgCZgNwaT1zOH1myzmUuQeFaG4UU9KAFIS8EBODBKeY1Sbz/ieffCWaXKzWVBEIq1t9BlcM/HKkcpkMnVjEopTqVw7iCLPkEAqkg7MCtzb7fRvFHBORvt9ymsqiuqHdDCtXCv3CQMhCHkP0d8XspZpIczZDHFHQe63x1Bp26E9LUF+fjbv2s/Y+NWY1UwWRvRgTw5o7S95rO66B0xInCyzFcau4x8GRON5wD8zysZYjhjjBKwKE1A0nG4oonUfT1ghzbcvTF8cEQYeUomBNQMt5FUbQ2QSMtMW+T6U9AzaOsx96HrOYUBzDR3FFTm0/QnBXLOqE5iC38wVw1gkqnk+fO8X6Z9rpVLoZNA+Cbl7NKWhlTvDpDcRnkBBXoVOAIoEmgJ1A8506P7UDqfkhkh36fZlixp6DTjrVHVbtUWUA6jBdLXg2S7C+fWaAZBaPh5aEKg6jLwUd9ziEYUxKyn/7qPGm2oCZxUSdjVsj1bCX3x2xAHqrys6sH4bltCLyiy/yV3fN+dEqyNiJmkGmJmo8kDkdPz4dW7zFGoZnVyAurYJtTbpC8+EQ3EGqeQvwRGijN5ieuCVEtPtnu2eytokwLWuUkxASwItZxVJTnjs8wMrUVpkq5xzp6QhIRbByI3L0M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFREa2Ercm15VzNSdnV5T0hIU2tEb0ZaaUEvQnRBdGhIaGJhVHRqYlhZSjlH?=
 =?utf-8?B?bERVVGJqNGVzdFduVkpvRHRtNUxvRU1mcnduSUNMNlV2dDdtS3loMVFlTGwv?=
 =?utf-8?B?YnJWWForcTBmMVd4VEFnR1BFRTAvQUtFMm5LeTlvQ3hRdHVBaEh5ak0wcjBC?=
 =?utf-8?B?RXQreXQ4MGZiNlF5a3NDZ3N5Tkg0TEJmVURrZG9RdlU0MVBTTTgvNFpGS3Fr?=
 =?utf-8?B?MjZ3UGpJeUlwVUw5WUhSUWR5SVNZN1hQa01KM1dxWkg2ZFloQ3hNSXlMd0Fa?=
 =?utf-8?B?Q0NsV3ZnY2l5V2c2dGhqZFUweDlJRGRrMU9YL2hLZ3REM0kwWDRMMU0rV243?=
 =?utf-8?B?MFFqeUsvdURKMXBrNXU5OXRJTW01bndyMHU4R0VmdWJDOXZNdGhYSVRaM2Iw?=
 =?utf-8?B?SlBabE4wek91ZkllWmIzb3RzRnRpUHU0M1B3TEFxbkthT2MwYUl6NlZLN3BB?=
 =?utf-8?B?K0JMdnNTeGFGK2pvNmNrVnJwZXdUOTBzL3NIZVZZeXJ5OTZYY3poNHBYWlFN?=
 =?utf-8?B?cnB6aGVKWStXblRBOUJpNlR0dXo1SCs2OHZkY3d4K25Ddmd0ZVJyZlA5Ty9Y?=
 =?utf-8?B?TVFuc3FYbGw1YVdjM01yZ3lxVHBMUXN3ZjVlbGFNSTMwYXdQMXZQMVEzM1pm?=
 =?utf-8?B?TFdNNWw4bzhtL3V5MW02RjhaYUlGbEpWVjM1eHJlWUovV2pReXpBUmFuL29j?=
 =?utf-8?B?U0dhaWEyVHlsQW9NK004NHp0OU84UEQ0M2ZDcytuTU9DM0RHdm9mU0ZGSU1v?=
 =?utf-8?B?cUJJM0VoTGJSd28zNlYveWIyN2diRkNGWTAzM1RWOTJPQmVHMjdJcUd6TlBV?=
 =?utf-8?B?NWNndnpLemFXL3BkU2VEU0xuZXlia2dpZlFUYmZGc0hWZWpOd0lQeEtSakhj?=
 =?utf-8?B?MW5aR1ZZUmZGSy9SaFBEa3hSeklML0xUYlVSNFBXL2xldGVmcmVURDhNSjlp?=
 =?utf-8?B?SFVldklLYVN3M2ZJZTJxN1FjandLZWlFZUdrSFZCb21VeTg3cWk2U2xvYUhp?=
 =?utf-8?B?cmxmWGRDazh5OHRnZjlkMkloYUYzOXd4b0VzL3RTZ3pZSDd6dWJnMEFYWDlw?=
 =?utf-8?B?Qlh5dDFyVDNGbXpxRWZIVXBPSDE2S1JIVGFHdXpkemN1LzhiU29yS0ZvTUNv?=
 =?utf-8?B?M1RKVUJocTRSQ1hJYXhaY2tEbnpkUWYvRFptUTJ5R0VYQ3ptMUdERFR4UGVo?=
 =?utf-8?B?UHc2ZkN4WFVPd2NjRTVpM21uUGxIOFhJM0MwUEowams2VS9UVFdFRTR2aUdZ?=
 =?utf-8?B?MTduejFlaXhFVytFcW9VTnFBL25lcjVzYTJidEJDYVd4aURyVTFNWDZFK2NX?=
 =?utf-8?B?NDhuaHUxZ3lLODFrWVU3MjJXdUlBOEhlZXdNUldpTUNJK0FrTHJGZWxOa2VB?=
 =?utf-8?B?RTdDTVk1cFF3K25pdVloYnFJbUxtU3EvN0REbXoxQ0dKTEgza0xiZUpCM3ls?=
 =?utf-8?B?b3ozWEtrUWZJWGZVTmdVWEEwc1JzbGVZdTRneTBoY1o2WjJUdzF6YmxPaFBZ?=
 =?utf-8?B?blZZUjU4WFdQcXI3YVJNNnJCQ0JEU2R4bXhYaFhvajlrZDVIY2NkNlJOZHU0?=
 =?utf-8?B?eGFWclREcEprSXgyV0N4eVYxc1pkdmJqV2cxNHZhOURvbWFtNVRMTnJtS0R5?=
 =?utf-8?B?WjdnT0hhcnkyUG56czZ3bytwM1U4VEdYZ2orQmVxMWo0eWZCRjcwQmRxaHFT?=
 =?utf-8?B?bWtnOTRsNm1JT3hHMkFITWE3ZW1RckxQUXNsaUlUZDZMNFZseHAyVmtITita?=
 =?utf-8?B?dm4rTzVXV2Vob0RLSTJrSVR1TUpNNnYvUXlXNzBpY1NqczdJRGNNL21UanJa?=
 =?utf-8?B?YmlsWHhHZ1RNSUl6Q2FXQmdUVUVkNUg4bFhhZXBxSFlOZDRtNzNzZ29CZGFi?=
 =?utf-8?B?YmNVRlRCVURmTjdkQ3FZRWpJbXFKZkJkd1Eza2xiUkw1WFF3YXdrcTZNOWJp?=
 =?utf-8?B?N21MUUxKTDlDL1FZczArUjlhMzFQTlZMdVhmc29UaGtYRmlWMXE4eU5xYWlX?=
 =?utf-8?B?a3lYckhNZkQxN0RCUGF2K2U2TXExUTJVTmdKdDM2WmV2NXZiVk9qNnoxQ01C?=
 =?utf-8?B?bkFjcVUxZU0vSytzUU5pa2J2VFk4Y2VXSDdIN09rc05FYVZYZGRLdkJjOTM0?=
 =?utf-8?B?c2JwcElzRzgzc3RhbXVDV2RTMHdxWlIwZXFSbTRyajlpdFRwQUNTMmswcFVo?=
 =?utf-8?B?WUNhalNvRHRWcXptQ2FuUEJrbk5laFFHTlBMUkxXTGlIQVlTN09OWXA0WGkw?=
 =?utf-8?B?VE4wUjYxWVNVbm4wd0JiS1AzOXhUMlZodEFGaVNab2Q1R2VZWlBJdHVwVDMy?=
 =?utf-8?B?ZHBuaE51VGl2NHhLdWVzTWxCOTlNcnZ1M0Q2KzdSTkR0TTJsSUNBUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5861f6-1f95-4458-eec7-08de82b6d31d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2026 17:18:07.1894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /LUNWVlFjY9uBokUkrZ4Fvlwq8JDJJeWk3Mjb/Mu4M7ZfnloWuLY4PUF2bEoMGfS5eI4lpaCFvoscfqENSbE5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7683



On 05/03/26 4:29 pm, Manivannan Sadhasivam wrote:
> On Tue, Mar 03, 2026 at 12:27:51PM +0530, Manikanta Maddireddy wrote:
>> From: Vidya Sagar <vidyas@nvidia.com>
>>
>> Calibrate P2U for Endpoint controller to request UPHY PLL rate change to
> 
> What is P2U?
> 
> - Mani
It is pipe to "universal PHY(analog PHY)" wrapper which connects DWC 
core and UPHY.

- Manikanta
> 
>> Gen1 during initialization. This helps to reset stale PLL state from the
>> previous bad link state.
>>
>> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
>> Tested-by: Jon Hunter <jonathanh@nvidia.com>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>> Changes V1 -> V7: None
>>
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index 2f1f882fc737..980988b7499c 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -1054,6 +1054,9 @@ static int tegra_pcie_enable_phy(struct tegra_pcie_dw *pcie)
>>   		ret = phy_power_on(pcie->phys[i]);
>>   		if (ret < 0)
>>   			goto phy_exit;
>> +
>> +		if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
>> +			phy_calibrate(pcie->phys[i]);
>>   	}
>>   
>>   	return 0;
>> -- 
>> 2.34.1
>>
> 

-- 
nvpublic

