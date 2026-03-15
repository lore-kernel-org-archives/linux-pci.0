Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013047.outbound.protection.outlook.com [40.93.196.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D6133B949;
	Sun, 15 Mar 2026 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773598010; cv=fail; b=Wkr4MA1PVMaNKQdGmZHl9VNFj41L87eeVKHCQ3ZTstwlszokvrNEi8qBzFhGtCy8pe11RGNSBGoSLTo4zKey6dLm3s/sIDz6mM/+1L9YLxLYTvnMUgrrmjFnEex+XMWgHyCP/46REjt9iO6U8n3E7OIUWUe4eyOmReEwpkIXqQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773598010; c=relaxed/simple;
	bh=TZ2d8ex4Wd6hWyNcGovtpCaSw45mR+6Gke86XS6o3hc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uZjLw+1q4aHK9TvFMGzPZojY52yBIR49aHrUikkJ4JWFj0UMYoQOZEh7ZYDWE42N+PYewzos1u07QZEXQQvLUo0+LsKupBJh38zj1dHmYJyBxRAWQuHlTzbk3h1fUgmkjK4f33+0xRkasahApBhnr2ybJzJdo8IBRSps0KVA4ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lyehcL8j; arc=fail smtp.client-ip=40.93.196.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lyehcL8j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMBE8L75/HkkqPPYRzsQxZf0e1E/1+WsL+jPDMgb7IgKr8FCZbCLS32XI6OmdypP0yfXg66BDtUs9GOeBDLfrUEpTtAQWbesGViDNuU0ZJE9xOtwmA9ofrs6sOQkDEwq48nuBeWIr5T6qfakn5p/GVjU0bSmc+a9usd3KIF+4otIytgSE5EH5sYbtrRLwy1hMFizz3shOe7oEVpG+5ee3ivQibQEOsOxwOOwlNLdHVxmeH+lPfjt2Ps3FGzF3RUbQ6Amh9ROI/MzpGfo3xqJohr0sI1mWzeiVSYZB24QTfUZ6sGVoyt4TmK1e/b/M1wVzFmHCFu/0LM61bak+waWEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NZyRpm9qAvTBGaTxhrLJdN9edWEmXQsWA/KBbbKywI=;
 b=KknGOodqQl/xYIp34pBC98yVIXVKklSMhy+QJbXfNOBL0igXr+uAMlTyco6cSXm/uy/VPyF1x5GQsLhgyYY4Ks7cc869sUO4EXgLRSlkZJ5aOCMn9v4SaNQ39SPw2BWhVUiJwaVWmKaJSUQQ/FM4CBLMCf4iV4+8Bo1L19p/mlFIzWx8RyLt0KlYj0PmCLGUUCYqau4RbYjGsJXFUl1oYRr/wPYTags0imU8csQXk3tlOmUz8d9GsXQLFh0zlXVLZjJvDjCtfTEZWpBQtHZWsFjyF3K8sasrfIyit9r+f9lSigfoJ89zlTJilaGT5ncJ1jELddtxJ0exdZUlMXUNyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NZyRpm9qAvTBGaTxhrLJdN9edWEmXQsWA/KBbbKywI=;
 b=lyehcL8jStxFT4tVMKExTBk2+oOoa3OK8uvmRnBoXRAlezMpfvWCNvpey2OKVNoHTFnzMaoA1UnKtri6YjmxxQzwUy/sN/itadiz0G0f/Eih9P/ZUuNx11C+ClxHz+WGeTKMYA5Sft3PfC7Hi2EKZexbE0erxMfSUoXn/0+FkEEJYNgT+n+g9RkOSIPMZoFcI9URFAqCUie2xaXNMqtml/Bugt/NL2oKWzrVDgdOw6Ij2KfMGRMuf5a4R+K1YEA4hCRuUjuDn0KTTZkV2oYMbfQoGkoG6sxtgOFK2VqLtyKz7X5Xonur1j9rpK4QmR5Mj05KZuGPVY9IVhhXXrnrTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 CH2PR12MB4278.namprd12.prod.outlook.com (2603:10b6:610:ab::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.14; Sun, 15 Mar 2026 18:06:43 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.20.9723.014; Sun, 15 Mar 2026
 18:06:43 +0000
Message-ID: <a0b424dd-6b5d-4ef6-839d-0692e2ae6155@nvidia.com>
Date: Sun, 15 Mar 2026 23:36:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 8/9] PCI: tegra194: Add core monitor clock support
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
 <20260303065758.2364340-9-mmaddireddy@nvidia.com>
 <p5eoraarj2v5oh5z4qxvixcs3whlt5vlzlgblytaeasujseupz@zjo4nufie2fy>
Content-Language: en-US
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
X-Nvconfidentiality: public
In-Reply-To: <p5eoraarj2v5oh5z4qxvixcs3whlt5vlzlgblytaeasujseupz@zjo4nufie2fy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::13) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|CH2PR12MB4278:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a408d45-919b-49af-74d7-08de82bd9cf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	pd23FCe/PLNOoZGpxcOP+w3VDUrruMBkZ+T/Au/XPpIry9UXz2708Au3AcCEUn/pum+YLySqlpCFk04l+I1uG6ajnaDG0CDrcjQgf5CUXs/bm9WIlXy0HlfRd+9RU6u76DcH8wuyFdHqcQM3MLz99vOCC+rs+JKFQ+ETyNwioQSyCN+GeSDsnVWqQzrmzS42kTi58NkDuYcAzOr6WBqwvODVfWogBn/3JK+GOvcMAuF7OH5YqTIzoVAd72UtX9nngjoDJPr5+TmLBg7OsyhXKwqy+3cwxUsyEz6HR2swpgj97Xc8axnz5RtkkpOIXxfkVHit+VT35uOo5VgMg/MeWmyNPFXBUXnVVn0oIkAkEQdd6/9djZ9PCAXFjPy7HayARZ6jQxA1G6rgBC3M7/CPPemU+77Z61/PH3Ex+3bXP2CiQ4ibQ0PgVXeSBW17Lxz206jKBzEu/DEsOUiTmYD56loAIfiKKAvch2Gwx9s5OynhrglECvr9s+acxARGmHXPFBbQsm9U9b085A5b+xeRe4NcnK0rscDS2dUSykn35QHRXarEO//+tMkdzZclTctB9jb9yNv2KZhWsEy+kdCwoG6L4he5aYwfgMpMmZd3VZW7cvhXvQnEikoMVg0Y3QdjsuJrUNtLja15BzXXBmn8M7OSnGZjkEyFEkcVPq7Vqgan7t8ESv83qFGClfKFVubM8680304nJ7x4/uMhbNZn9Er3UPKDhafNlY4xA/Qt5cg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0ZjK0tRRHlCdnVGR1NkOWp2SlZJZUNGU1N1bVA4SXRIeVBOSFJYeVlNcHAv?=
 =?utf-8?B?cHlzTkFjcFF1OVg2ZVdVQUxLQnMyZHk1dllLNTd5U1FPUms5TWEwMWVmcWxE?=
 =?utf-8?B?N01ObDZvcm5QbEsyS2xuT3hTM1ZwVitXblN6U1VQeHFCUjgvSGxuNklhWmE5?=
 =?utf-8?B?blk3am1WVm92bFZtT0ZES1RNMmZZTExWRm5JUkhJUlZKNjVKdUpZL2J4VnIw?=
 =?utf-8?B?Tk05bTdPRzk3RVBQbEpDVHNEdjJkaS95aU45S0lxb2NUTjRoa1JLRStwZWk5?=
 =?utf-8?B?eGZUL084blluamRmTDJnaW9WK09iNERxQVV4bkhLcGcyVndPamcwMGplK1gr?=
 =?utf-8?B?Nk9JSFlwV2kwemhTYjBLY1RldG83bVdOOS9BQWgxVGdSV2J1SGxyWVNHOGVh?=
 =?utf-8?B?NWNoMW9Vbk5LdS9xUjE1MFRnekJJWkhlZ3BKV0pXcTI1MzI2bGt2K1pYRlRG?=
 =?utf-8?B?RTYvYWlQVVdrZFo0aGYzMXdUV1RjOVZ1aFo1Yi9HZ011R2Z2TFNpRnp3cGow?=
 =?utf-8?B?UE5QZHFsQXdOOERwcHJCdDQ3emliWWFtdittdXJiR2t4c0JOa2NucitoYUF4?=
 =?utf-8?B?bUhuT1JMdUY2TUxaai83MTZYU1VHSVhubmZsNFdsNHhpemJXZFgvbS9pOVlL?=
 =?utf-8?B?MkVwMTEwTTJHb2J6bHFuMjFRc3FwUmlFc3RjM0tqck9xUDJDbjNObXhkbitr?=
 =?utf-8?B?Um1kRXorVjFMUXZRVEUxbU0wZG1rVStFNXNYMlhLZ0Rza3lscGc4aTRYOVdK?=
 =?utf-8?B?eUdFNGF1K0IzeGZVaHA0RW92amNNcThnSWJkSWp3QWYrcUJpRU5HV3JpdFp6?=
 =?utf-8?B?dlprTnBkbS90WHNmNWtXOWplaFlWNTZGTVZodVREWU9WUXJHWmtzeldqSGZ6?=
 =?utf-8?B?Ri81S0xldDZLZlVveFNrVDNFSU9MWlUwZE1jdGR0MWRGbmVxT2pMZnpSd2p1?=
 =?utf-8?B?QkZ4alQyeTFzdGRDMTVqNk1jeTh0SW0wZTdRUXQzN0xTam9sRXRFdy9YV1Ri?=
 =?utf-8?B?V3FzKzY1U3g4ZHZNbzNFWFZOM1Roc0RlSzJFbFFZVVZnc3JkVXpzMERZVUw5?=
 =?utf-8?B?MktzZUFOZEZrd3NPa2xXVk9tcDB5bnhNRnc1UlJqVEhzSFp4a0RLakRBRkFD?=
 =?utf-8?B?Y05JK2NXT2krbDVLLzYyV3ZqY2s0TE1VRlVaN3owWnFjU1JhWVhoQVpuUHUz?=
 =?utf-8?B?RFoxNi9UOHRJMDVrZmQzdzV0aDA4b21XSEptM2oyQUFyaFRhOXBDdlpCTnJ3?=
 =?utf-8?B?US9ERmlkWDJ5cEVaNEowMVFvbnpub3ZaaW9MU1VzRlYrbW1ZVWJGQjdTRS8v?=
 =?utf-8?B?QTNKeHc0cHpYNnFwN1M0L3FoRU9sUzJGakhUTVllUmlhc2FsbDY5dUhNRUx0?=
 =?utf-8?B?Q0lkY1dPa21ZRTBhOGpxOXdFRk5qMjBwaHMyMFNtQk1TS2QxTzlxMUdsRGZn?=
 =?utf-8?B?VFREaWlTV0txZitoZUd0bUd3NWVqUFk2R2VvTXNtYWtQOWxoT0tSbnIzVjUr?=
 =?utf-8?B?K0hKU2RLOVNkVnM3cUpSdkVxd3Z4VmZHeHhGRlBoNkF6aDNmQVFXU0orRmlJ?=
 =?utf-8?B?cks3WEVhcEFqK2V1eGRZQWtHZzkyV0ZwRHR2T0ZLQ0F5UkdhS2xzVThCWll3?=
 =?utf-8?B?YllwSUNZTnltN2grZ3d5VUtTeE55UStKRW8vVVJJcE5yUkNCc2JueklseEVV?=
 =?utf-8?B?SkdSUEhuUzN5c2N3NGoySzZSdlExZ3M1R1lRTVhnOExXSG1JMEVobFZZL1V0?=
 =?utf-8?B?N0djMWlFZ2JYOGxyTzgxbjcvUnRKWDRjZkxGQ2pmbjZ3cjg5K1poeUcxOUd6?=
 =?utf-8?B?OVVzbzFWQ3VmU0FqTnRPOXJ4dEtjTzQxS3hndENvOE55OGE1QS9yNTdaTmxT?=
 =?utf-8?B?ZXdNOGdFMHA4djlCV0ZPZFprTjZKYTY2NTVVMGZXZWJjQ3laYWRZU1FFMThR?=
 =?utf-8?B?SmtmaWUzblozRjVCSTEzVTQrYkV3anlqRTBtU3VKVTE3bnBzMDdSZlVlTEhj?=
 =?utf-8?B?c2I5QUxia0UzZkZ3ZzRpM1l6N3FEQ2RzQWdRb3RPVGY5ZGZiUE9zQjJnMkVz?=
 =?utf-8?B?T2tUcTkyVGEzZjhza2pyU3FtVVppa2lVb09KQXdobllDM0ZwYXMzMm8xbG9B?=
 =?utf-8?B?V1B5eGw2Zncza3lMczcrSGdqUVVVdTFBT3NjRW1jY3ZWME9pc3RqSzBQTlkr?=
 =?utf-8?B?UVd6TkZoZ0Y2VmdWUWYrckxNV3ZQV3lOQTNjR0xicnpyVVhIYTZHTXg2Mml3?=
 =?utf-8?B?QmN1UGQwRXRSVHBBRmJJcXBSRnpuYUI0cjFUUVcvem1CaE00YTBVaGJ6djYr?=
 =?utf-8?B?aHJwUUs5TUV3c2NUc1VWVUlaQkUwc01NTTllUU1yQ2kwKzNqS3RaQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a408d45-919b-49af-74d7-08de82bd9cf5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2026 18:06:43.0913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EAW6lsJmCEmUGqzTY40ul7ENrHmZvFt7TOf9Dl2178Zri9TAZt0YH/OM/KTCALlabGEPRmo99yKa3WYDTtM9lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4278



On 05/03/26 4:42 pm, Manivannan Sadhasivam wrote:
> On Tue, Mar 03, 2026 at 12:27:57PM +0530, Manikanta Maddireddy wrote:
>> From: Vidya Sagar <vidyas@nvidia.com>
>>
>> Tegra supports PCIe core clock monitoring for any rate changes that may be
>> happening because of the link speed changes. This is useful in tracking
>> any changes in the core clock that are not initiated by the software. This
>> patch adds support to parse the monitor clock info from device-tree and
>> enable it if present.
>>
> 
> Reword the description in imperative mood and avoid 'This patch...'.
> 
>> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
>> Tested-by: Jon Hunter <jonathanh@nvidia.com>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>> Changes V1 -> V7: None
>>
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index 070eb7f4058d..e0455d322166 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -249,6 +249,7 @@ struct tegra_pcie_dw {
>>   	struct resource *atu_dma_res;
>>   	void __iomem *appl_base;
>>   	struct clk *core_clk;
>> +	struct clk *core_clk_m;
>>   	struct reset_control *core_apb_rst;
>>   	struct reset_control *core_rst;
>>   	struct dw_pcie pci;
>> @@ -945,6 +946,8 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
>>   	}
>>   
>>   	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
>> +	if (clk_prepare_enable(pcie->core_clk_m))
>> +		dev_err(pci->dev, "Failed to enable core monitor clock\n");
>>   
>>   	return 0;
>>   }
>> @@ -1017,6 +1020,12 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
>>   		val &= ~PCI_DLF_EXCHANGE_ENABLE;
>>   		dw_pcie_writel_dbi(pci, offset + PCI_DLF_CAP, val);
>>   
>> +		/*
>> +		 * core_clk_m is enabled as part of host_init callback in
>> +		 * dw_pcie_host_init(). Disable the clock since below
>> +		 * tegra_pcie_dw_host_init() will enable it again.
>> +		 */
>> +		clk_disable_unprepare(pcie->core_clk_m);
> 
> Again, this change should be in a separate patch.
This patch is handling only one feature, which is enabling monitor 
clock. Monitor clock is enabled in tegra_pcie_dw_host_init(), this 
function is executed twice when handling DLFE fix, so this line is 
disabling the clock before executing tegra_pcie_dw_host_init() 2nd time.
I think one patch is sufficient for this, otherwise it will introduce 
unbalanced clock enable error.

- Manikanta
> 
>>   		tegra_pcie_dw_host_init(pp);
>>   		dw_pcie_setup_rc(pp);
>>   
>> @@ -1610,6 +1619,7 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
>>   
>>   static void tegra_pcie_deinit_controller(struct tegra_pcie_dw *pcie)
>>   {
>> +	clk_disable_unprepare(pcie->core_clk_m);
>>   	dw_pcie_host_deinit(&pcie->pci.pp);
>>   	tegra_pcie_dw_pme_turnoff(pcie);
>>   	tegra_pcie_unconfig_controller(pcie);
>> @@ -2161,6 +2171,13 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
>>   		return PTR_ERR(pcie->core_clk);
>>   	}
>>   
>> +	pcie->core_clk_m = devm_clk_get_optional(dev, "core_m");
>> +	if (IS_ERR(pcie->core_clk_m)) {
>> +		dev_err(dev, "Failed to get monitor clock: %ld\n",
>> +			PTR_ERR(pcie->core_clk_m));
> 
> To simplify, just do:
> 
> 		return dev_err_probe();
> 
> - Mani
> 

-- 
nvpublic

