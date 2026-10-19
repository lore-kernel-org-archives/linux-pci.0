Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010005.outbound.protection.outlook.com [52.101.193.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECDA4D956F;
	Mon, 19 Oct 2026 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408790; cv=fail; b=OzHZlKGURQ3ajINaW88vj+kZT5RsDc8NeDp1tQnM5ofhZ8CL+x/yYAXKq2mkVpAfP4t2QEVKpJWFQ0JiZIYk17SjwUNUsu160kX/ii8or5qpaKmziBlbpZd7o72bDx1P4l7DxAyWfkvqG4sfWAghHHq7H0Pq7bW78NTediTksXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408790; c=relaxed/simple;
	bh=j9N2mROrQMBU8LP/Er8zlVVZv6fqarg0KJUcfbSNOMk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VxolMLOSoa2n3RHLHkGlMIdUYFtCwJqoPvXkVqHOBSqOHSVbmFUjRZlZAXCynsTnS9MzguygvwbxGg+Wf2O0s6Ta0TFZcGTzIpKDomLoVi0ccAqtMdq4xNmto29cOxyEQAzWbSjdKvZDiPXbtzyCP49A0eyIABbUW2jlrLl3y1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YvFwfrPp; arc=fail smtp.client-ip=52.101.193.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YvFwfrPp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RnaZRVNsH+wt/njm/2CcfF/n33384IBJqZRobwjij+ct4B2Th7sxQODUkN/V2vxRF4KDcD0yvz058wkPsZM8uMer9r5VwDVGgeMMNJcSaNxxxJv5V8j9yVBeFgp+O77217+NCLdUb6m47GMLuLHx4BPWq5vkzWJ9KxVzyZ+fJHImAbAOnIyqPyEZWjQRhlUuJRxHj+5YAFoKGvjjxOjC+Ly8Vw+9BsbhF/1swdhs3cKohEk+P+nygMfc9hZzbZA3Cxih8gFb2cO0mn9P2NNvw+ALlmaXioppfD+ThgcUqhVqKeHHvzhs66vvM8fTUC8lvGI8BATvTCjjDwmH3BMIZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvMWBOLBTr0Cug8bhKZun/c0zMyWNhe1FrjwlLgQoc8=;
 b=TArNPlwk9BIYn6nDBZllg5sSlwxk0RPZXifIOAO+9iuQn7W2x6gb029fwZWLF3VHsKRMkQzb3oUEzg4mwwtvTWvUCUMPsRQSZqlgrAWhiTsaax4EEc57RoYnS/574oGFcncWSh9NW0QWAG15cvDh2N5nZ5E31Si538MWsJd4nZIBE7Nb4nJ55TuMIn0fdBQotCNTlswyWzBj1d9Fzfpxc3Vh9x6/XeNWXcFo2Dx84Vj0qTKViDsEnzfSrC/0sIVEYrjGZzaNdnrislFxX0LyLlkK6ndQ9278GRJ9E3IsnAf907Y2Aj2u1/u5xay1iC0cwAF7LvNHOh3WhaJqjvcj2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvMWBOLBTr0Cug8bhKZun/c0zMyWNhe1FrjwlLgQoc8=;
 b=YvFwfrPpaWNrVwZpokeBkuMY2Ml3PTvH9WMxkUzsQ/fgDsZbKHGYe9k1S51W46OcsQdWO9UUQeI9hLXdH25eEEO8o+ReCnEsdarM5cvyo+3yuGIAFx2K65np4t/3MpocgGYm0dmQWpCIK+zbhhGi/IcbDrfjQmcur1FLP+aMJdz67VemksuvR00IqhEg9GUHsFMujJ6O6hJesI4CYsk67horujxWjGN3tyrlg44Thpor9xpex2jOthkEPyNXjMHn+bzCy2iNVulNkxxsuNzt/82ZeQr8bMP2WBDW5zBUgZQi/miCQ+KSB8nhYrIRnQgDSoMuH8SUJSM6m2h78KujyA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 IA0PR12MB9012.namprd12.prod.outlook.com (2603:10b6:208:485::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 11:19:42 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 11:19:42 +0000
Message-ID: <14bc9d0e-ece4-4cd5-99b6-b53b9ce27157@nvidia.com>
Date: Mon, 19 Oct 2026 16:49:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] PCI: tegra194: Notify Endpoint functions on PERST#
 assert
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof Wilczynski <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
 Jon Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>,
 Niklas Cassel <cassel@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20260923072554.1141864-1-mmaddireddy@nvidia.com>
 <20260923072554.1141864-4-mmaddireddy@nvidia.com>
 <ogerzdjwq5wus3eb436x5gylxyfekmir7rz72ycywd2xoaiank@h7ayvhizjpu7>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <ogerzdjwq5wus3eb436x5gylxyfekmir7rz72ycywd2xoaiank@h7ayvhizjpu7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::19) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|IA0PR12MB9012:EE_
X-MS-Office365-Filtering-Correlation-Id: be1fcb15-24f2-4d69-1689-08df2dd2df0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|18002099003|22082099003|10067099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	LLWjbOsy0MJxaagNQ8kbmsSFNIhPe+k32McIx72Z1CLXsYRztC3vgoS7j02hVtaNMhupgQUX07Mg1MWqj/Mwrir0TcOj+JWVGuYHioHEPacxuSJsyOQPTWajbthHPqgt50TD28Kk4f93f/DKn3+5nfYq9jjhcVVK0neeVZ4zD6qM+hR+pHm6koYZ3KmHeJrNXpTCMghdgPYJblXy9WT5qtFCgOCWpuFhbSufz0NGCLJp+Xt19amp5TcO2Lll14wRONhG+TxZuCLJ5Tyh79jUXekAa8NeLXToI82Ue+es3O5YU4qyWqCt5kegdohmchVRldsLc+yJrCkzH5CRN2+GY8XMhUsO6Ql59Ug4+ofhYhxaRvCZ0zkkI/sGKK86mcUOux+PgbDN1/LEFblhzKbeElymB2Vp35dwQBLTsd7dW81ztgt0kn0Ym7EXTGv7225UaonTAmRtj+0nB1HQzTC8mTkphwIGguk+wE5oCoVhdtG+bcsYFsNd3zh8gie3Ss1oqKH4ap6+Mr4EnTDG0W8m5n7KG24m2OGmx4hXjmrnK0c2QciFk9v3080CigqSJwwi4qO4q3JU/m0vQdVIO6Wdhs2OLpF5OELrubV0EGAkPlp8l28QSH3wWYnLeQ+kZRUTrsP2cPJxe0XqpQaknZcg4Eeb5zRWuW5IqnkPEDQ5dtQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(18002099003)(22082099003)(10067099003)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUZNbVpEeDdxRUNhcjlvazAwWW5ZcW9neVJhTVB5M281OTZrN2t3SUExaTg4?=
 =?utf-8?B?THltZWZoU1FYMC9SM1JvcE5JbVk1K0NNb1Jwd3JoaWRob1REMXdveVhoU2Fs?=
 =?utf-8?B?WDdWbkF0Q0pNNVRIV2RQNU1pQXpsRmZ4ZUIwS2puamdzZE0rbnV2TGMvM25S?=
 =?utf-8?B?bit4NitNTmxocGF4aGlYbVh4TDJ0bzl4aWxOV1BBU1lGaElGdWRsTTJPQ2pI?=
 =?utf-8?B?bkpzN0VJY2pEN0VxaE8vVklYQzZ2b3VBdmtESERiOWs3VWRCam1pS3Rzc1BN?=
 =?utf-8?B?U1VyN3hCb1VHOUUyZ0xONVM0c1plbTIyWllma2ZsWkgxbjRqNFF2SlEwOGE4?=
 =?utf-8?B?eTU2ak1hcXVMb0J0WTIwQVEzYzlTd0pLZlR2a1A3R3VqM2s1NGxsRjZxazc3?=
 =?utf-8?B?Zk1UcVRwZytBWExQazRJV2EwRjBjcFZlWm9XM0o4OGcxUWY4T3RJVjVLZDlP?=
 =?utf-8?B?Q1p4bnZsUmpvQ1RKMXhBZDZIdEZSOE45S0F1R2FLVkErcCtja2pYOEhZdlo2?=
 =?utf-8?B?K1g5VTE5d1VSdUc1aWtzL2NoM3g5cmlZNjVkQUt0WXlzek1pR2FUcmd3TjZw?=
 =?utf-8?B?SHFDWEExQ0VVVkhZdHdtMkc1T2FTaGpkUW85bERKdGtLSWNSaHhGaXNFNE5w?=
 =?utf-8?B?QXc5dFhhTUZJd0RVQUxERXo0c2dEZWJsK28wMkhoeEJXc1M4b3pOU25ER3Ur?=
 =?utf-8?B?Y3d3NnEzd3JFbmdkdUo3anBIa3BWNFB1QnhOeHpubWlueVE5SkxJMHIyTGFV?=
 =?utf-8?B?QUsrSUloRWUrYkgrZElERTZvY0svL2JvQUZFc0RTN0xPVW44Q055dGNKUzI3?=
 =?utf-8?B?VGZVZjUyb1FOaXhBdWdTWXM2a2RsQ3N4eU9JeEl2K2M3dWlvcmJZc3lEREZl?=
 =?utf-8?B?SXVrdWE0N0tBYTZ0MkFWcHhFWm9vR1A3Z0FMM1ZjQ2RsWWlvUW5Oblpqekdt?=
 =?utf-8?B?bHN4Y2toaFlyQ0VaMXhaTUxDQkpjSC9RbVhXaFpXbFpxbFV1YU4yYlhubFNI?=
 =?utf-8?B?bVlaSXlXV2xhem1LODVoQ2NQaDM3TEgzQlBPclpCY0xJcUVLTE1qWlJCNzAx?=
 =?utf-8?B?ZU41ZDhjMVJTSzYvbGlpUVlkL0s2ZnQ0Q05lVTdjakRJZjY2YmV4bGpUMG1w?=
 =?utf-8?B?RldTRGYxKzZUWHBaNE8zNUFPNit0ZXZKQ2FsTlg1WFdZN0dBbGNBbzNnNXY0?=
 =?utf-8?B?cUJMVk1IYnVnMzBSd3dhekowTFlUUzZHQlJKa1ZNVHowTFUzUDMvbnBPa0ky?=
 =?utf-8?B?K3E0aktOU1Eyazlobng5QVNxNmRScUtSSXhxMFNxVjFySWpsanJvYzhWZk5h?=
 =?utf-8?B?L1VyS0xKelVMRUdEWHNTYjR4MCtjb0Mxa0VML0xMaDZrOCtsWklDWTZVSmc4?=
 =?utf-8?B?bnl0RGdGQ0VtQkVhN2J3ZDRMSmJlVy83T2dLNlAzSkQ1R1FhU3pzWVZJRDk0?=
 =?utf-8?B?MGpPekxRa1ZYUmUyMm5YdU9oajFWQ0toK0NzRGRNc0NrMFZ4VUpNTk5WK1lM?=
 =?utf-8?B?UW5SaGc5c1JjMnphK1BJOG56dUk5MHUxY0M0MHArOFBIdEQ2ZVMwRHJIS3Rz?=
 =?utf-8?B?L1R2VlhFVTc1M2dQa2ZhVWppYnJZV0dDUnc4b0xTVHBaWkFKenF0K1daMjJR?=
 =?utf-8?B?TG80UU5pWFVpcHA5Q1RZVjBlMkdxUHNHcmFqZmphbUw0VE1BYkM3TG9STXg1?=
 =?utf-8?B?bXoyZUZBZjJ4bjgyMldqSnN6U2UwNnR1d09acDA2MFQ3RSswMElFZXdId2R1?=
 =?utf-8?B?QXB6UnFyQjFRaXlOUDJyUWdjUlUyaFRrZ1NlWEptaExVTFVDNzVmelZEbm1o?=
 =?utf-8?B?ZHBVeWdqRjdMNjJINkdhS2tkOGhCVUhxKzJZRUI2T0FCYkdteXYyR055ajdJ?=
 =?utf-8?B?S1plNkMvZ0VEdElMelRLMUQvckZ1dG5kVTQ1TVFZaUZ3T3ZuUlhEU3ozT3RQ?=
 =?utf-8?B?aHEreVFFMkdHck40aHRLV20xOXZPREdxLy9lazNVKzUrbGNWcmh2d1RzNHVm?=
 =?utf-8?B?a2NHUzljR1RINy90WjFZenFxM0MrdHk5S3lMK1hMN05DdmJtV3M2bHRuNnRJ?=
 =?utf-8?B?eWpndVlFdmJxRkpWK1dzbGQyOFBwSVF4TUUxWU1ibE11c1ZlTFBhbFJodWpT?=
 =?utf-8?B?WjVCL2M4WWE1TmdYYzhNTnlseWt0TUNMbmxvQzBITVBwR3Z5SkRnT1pLWUZR?=
 =?utf-8?B?VHZIUUsyRC9KdzFCeks5Y0lZQk9wcHhzNC8rSmZGV2lHSmNHTm9HZFFOVUx5?=
 =?utf-8?B?RlNKZWFROElzZkRkb2NmZkhRZmYrbmcrYnRpMjNxd3JjUnZYZ1lYN29BVWxI?=
 =?utf-8?B?b3hxVEVlZ2labzdQOUdVZUJXaEFnRk4yM01COE5nazFzY3pYeFRqZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1fcb15-24f2-4d69-1689-08df2dd2df0e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 11:19:41.9714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZ0Mp0LqcIrpMSW6WSdYYDBnUgOWYWwyLnBNxLoN/cRn8PwcRMOSYW6c+sEe1N+ixpT8Z91RpxRv/2Ohm8p5Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9012



On 17/10/26 2:52 pm, Manivannan Sadhasivam wrote:
> On Wed, Sep 23, 2026 at 12:55:54PM +0530, Manikanta Maddireddy wrote:
>> Tegra Endpoint mode powers the controller down when the host asserts
>> PERST#. EPF drivers must be told about link down before that happens,
>> otherwise remove while PERST# is asserted can free EPC resources while
>> EPF work is still active.
>>
>> Use pci_epc_linkdown() directly in the PERST# assert path. It is a
>> software-only EPF notification
> 
> Not entirely true. The EPF drivers can still access the hardware registers in
> the link_down() callback. But most likely they won't access any DBI registers,
> so that access may still be OK without REFCLK.

Agreed, “software-only” is too strong. The direct notification avoids 
the DWC helper’s DBI accesses, but EPF callbacks still need auditing for 
operation without REFCLK. I’ll correct that wording and remove both the 
unrelated deinit paragraph and pointer cleanup.

- Manikanta>
>> and avoids dw_pcie_ep_linkdown(), which
>> reinitializes non-sticky DWC registers and touches DBI while the host
>> REFCLK may be disappearing.
>>
>> Keep pci_epc_deinit_notify() in the PERST# deassert path, after core
>> reset is deasserted, because EPF deinit callbacks can clear BARs and
>> therefore need register access. If remove runs while the controller is
>> already powered down, pex_ep_event_pex_rst_assert() returns because
>> ep_state is disabled; that is safe because the link-down notification
>> was sent at the earlier PERST# assert.
>>
>> The final dw_pcie_ep_deinit() does not require Tegra register access
>> today: Tegra uses its own MSI-X address-match window instead of the
>> DWC MSI iATU, and the supported DTs do not register a DWC eDMA device.
>>
> 
> Is the last paragraph related to this patch?
> 
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index dd3f4c30ba52..3e9d46850a78 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -1724,6 +1724,7 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
>>   
>>   static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
>>   {
>> +	struct dw_pcie_ep *ep = &pcie->pci.ep;
>>   	u32 val;
>>   	int ret;
>>   
>> @@ -1745,6 +1746,8 @@ static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
>>   	if (ret)
>>   		dev_info(pcie->dev, "LTSSM state: 0x%x detect timeout: %d\n", val, ret);
>>   
>> +	pci_epc_linkdown(ep->epc);
>> +
>>   	/*
>>   	 * Deassert LTSSM state to stop the state toggling between
>>   	 * Polling and Detect.
>> @@ -1913,7 +1916,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>>   	}
>>   
>>   	/* Perform cleanup that requires refclk and core reset deasserted */
>> -	pci_epc_deinit_notify(pcie->pci.ep.epc);
>> +	pci_epc_deinit_notify(ep->epc);
> 
> Unrelated change.
> 
> - Mani
> 

-- 
nvpublic

