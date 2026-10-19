Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010046.outbound.protection.outlook.com [52.101.201.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2FC4DD3CD;
	Mon, 19 Oct 2026 11:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408573; cv=fail; b=kY3h3GEps84JYVUkDVxp4DPC2Rsc7gNJfIUEFuDb+T6xw23Vsex+T2bjkIWzsEdJFUUpwOknEnA72a15V1BQwkB6IFe923i/8n3VdTWgSd+CGW4yCqUGZjZV4MX2QAnb8xox05WD/qH2Pi2uvw5hqAaxYDVgkYUk6BeMde1utAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408573; c=relaxed/simple;
	bh=ONnP6kVvSEWyQC6p7tpxgfBPeBW9bNZJgn7p2e7JsG4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=umVA80e1rbyRH/zyGdqPOHWCvRFK0yH/+CyQ3njG3K5lNBV9lCWigRJNs6VFrr6+TnYwUFR7CXegHqMTFQJBzPgSSEY1oHB8vlGHwr5OnH09INAfxTl+Ov8UUjfMXBkwSaeU0jmdM8qS2bGwsuJ7Z7bhFbsxHyIcq3kWibIyCe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mC2tGMYv; arc=fail smtp.client-ip=52.101.201.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mC2tGMYv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hI1LoorDyA5jUlSamSZlVyZyhvbnUvrHYzo1cbq+8/nTRw5Vd286GbggoSlk3czXd+bNCrF3PVyT4D/J8ECSUWm7cwwph/bxNxMSsEEYeUuty/wZS8+HWqQ0BWnNRrsb+m+bLvNwjXJ9guy9VkIZw+vsI2aVKjc4qZo1qNJsweYUhB2MG1HBez5ZR7GHjX3EHJxplcUN1SL+EulUK5njyRIyXALcPDRFSy7ZB+j5ccg6qn6YJirEPwj7a4jVMnt7A/IKsTMM2j3z7V+5p12zL4QfuukUKNi086M2a6S9k0kTAIKlibULpFvf5uXp1+qWkT19r7ElVDpKjpyhvJBA9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nsh72XS6tqaHYif0XeAKVWePLkZL7l0kNOfyVSSWWhY=;
 b=GwVglnP0LNrtGVQYuavkV27yL2LbBDM9rKZPgZa3wVdmAbvceAVSDlcWEyYJ3woPvvFArBTKuED8Yf8vRXNM3sVz3bVyvrLb4MBd5k30giyMrXoQqs8OonQDIxDeeF4WV+iVbersYa76DLQsxFE96CPj/qAGOrW7gx+Ik/JXvUrnzbF6R7pFR8y1hj34Xig12RsWxCBBVRhCJaE2fLN27Aq0Uheto5IL7c+WwWG2usZ2swyaH4qbWMnjx+Dk4wQnz8Vygd0Xp2JeWWxtmMwMk6hLF3Q6R2IqMXpDhgRdKJJWVOzGOG4X5UR1V2Ro5kf3ppFxi91n7zBCclrY/fVenA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nsh72XS6tqaHYif0XeAKVWePLkZL7l0kNOfyVSSWWhY=;
 b=mC2tGMYvoduAYv1tipXd3BrGIbvR6X91jzOh0AWYYi8IqHUSnF94aQg6Yox1mqPAX3+fpawIepg8qujV/8xDIcAPR6lv7bQ7xvdvih/9J4O+zULTPqtH3iRsvmoqbTY9EOTT0Mji7E398PgU5O3BrvJkt1sZZir+ko1C+3qWE9GWjsU4s+BidZStblEq/WzKff+7skg0YUywfJfdHJUeMTNnVzSlvhT4/GykXZRwqGwaeU33ByRDi1VplOfnXyESwq4Tx5c+bmY1PUe3In+nmvbLiuljiKDU97GG/5atn8WZwaOHwMUZDScuHp6HT/3X1sC3FYlMBDI8xYGAwMpD5Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 SA3PR12MB8045.namprd12.prod.outlook.com (2603:10b6:806:31d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.24; Mon, 19 Oct 2026 11:16:07 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 11:16:07 +0000
Message-ID: <3df397d8-5cec-448e-8dcd-59252ff240d6@nvidia.com>
Date: Mon, 19 Oct 2026 16:45:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] PCI: dwc: Add Endpoint reinit helper
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
 <20260923072554.1141864-2-mmaddireddy@nvidia.com>
 <dee53d7no6nmzsaousuoqleg6dhigkejvkxmpyihc4v4piipwt@opa366n2sakq>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <dee53d7no6nmzsaousuoqleg6dhigkejvkxmpyihc4v4piipwt@opa366n2sakq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::21) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|SA3PR12MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d284e5d-7079-4eb8-afd3-08df2dd25ee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|5023799004|10067099003|6133799003|56012099006|4143699003|11063799006|18002099003|261009223027099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7f/D9bmsN9cKOjYnC+CbFHvhdnIC684gMPRLTQsaoGJVcvCwLq7jqs7Re4AK1VI5QKn+nnG/uQRl9OR30wR2W2u9XBUaLOkg1Et663quPi0ozegXAuK1KMDo/ZPo98ziwEqRG2SJTy7eC4y7MKUKoP3hmu/v/85l2ZZfvuYRJdZkxs6+775sYjaf8PrzQ3Cgq4QVqa6DfLRV3lQA+c6fVLWIoGFNM2yQCVFDrzoxOa0de9H5n2CxnJDw3h0+yKwTf1VfoREowtiQKuW306nsWdaVJoPmlmQUa3reCbfZ+X3DFJeMtQB4G32tfehgL4L6dtJxUSdOXi9o0BiuzjYRgOPoeSjW/6hS9CMESBVtbFeDk1wZPrZfsJq2Kdd+iQ0/KxH/7W94iBIfcllCRrxMGYYGis5cib6swqSFQSc3/vk/yNiZ9PK5Exje2fOQJl6QdZYFjn0dlom5c8LtsqLcyUUvaHJyNcU/U3AvR8D0RksMqqsBrTytnyMC/IO2qQZPOQw2h59C807zs/0xxKUpqL4KRSJG1I5ozE7ob3xy1a8850roa45qNX1x27glR/Vshz0eVtfC7lMBIGUkyeQEsLjAIBRyi8FXD1/bn2Wm8N3MVB96eRRi5BalXNdmQZjz4ok6QiH+ax7D+mgAhXTHW3HLzylls6WAqgL+i0g+ZXQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(5023799004)(10067099003)(6133799003)(56012099006)(4143699003)(11063799006)(18002099003)(261009223027099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2VBMGNvM2RjMVJLdVNOcmM5Z282TEtwMjhvMlIzbHhjRkpicG1OOGZkNnE2?=
 =?utf-8?B?RHlwanBYbXlpbzU1Njh2WmxIcTN2RzQvOXdSQzFRWE4vWTgvZU9ONUVUeHBY?=
 =?utf-8?B?OHFyeGFrb0tFS2RORElsbWRvV256bE5KMWk1YkZvdnFZd3Jvay94M2lXMWFJ?=
 =?utf-8?B?TTU0YVlhaVZPUXpudG1JNnlRMkpySWtIT0dSWUJvd2UwbVFIWk5qbUhWUnVE?=
 =?utf-8?B?QmZIODNUWjI5aTZHNDl3emt4NDNqejRlWXlOVWFkRDBBVXhGTnc3OTJ6R0F5?=
 =?utf-8?B?ZVBiMjgzWlZkL0Z2VXNMUldBVlZoWlhwWjFuQ0ZycFNpdTIzd2ZEbGlyeU5x?=
 =?utf-8?B?R3doTDZ0ZzArcklBN2g4czIvWWsvTGpRcis3czlXZXVVYmEwTVBlbnl0c0tI?=
 =?utf-8?B?UDM2NTNtUVN3TndTRXhabmtzR0RiV2NucldFWFFxY3BNTm9GcVlmNWJyMFl1?=
 =?utf-8?B?aFdhMGZOQ0UyTEl5Q1F5NDNJR2NHY3RsZ0lTQXhvbnRtL3NTUEprQXVPKzBF?=
 =?utf-8?B?NEtYeVhmR2svM1VRcC9YdnN5V3N0cGtRUHpNc0ZzdW4xamM4QS9RWmlQbnU1?=
 =?utf-8?B?aXJscTJiM1hJdDVSRURJMEFuSnppeER5YjNqZ01abENLNkhETXduWm4rOTBY?=
 =?utf-8?B?QkNxbmtVK011d2E0KzNrVjkvMk9FcmU5NEFGNSt3aDczcXp6R3FTaTRnZlE3?=
 =?utf-8?B?bElFY0pFVTdicVFIK0U3WTVOaXlmTkpRNGYrUGVQQXBwcUptN1FEaXczUnBR?=
 =?utf-8?B?ck1GS212bExvWTNkbCtuVXpqYU40LzJ0SzRGTlhTUHlqclBEaHVHSDQ2dmtP?=
 =?utf-8?B?eEpyYTRXaVlCakZDR3E2cmZmNkxoeDhlM1FpQXpuMHZ5M2ZzL0pDRTdqTDl2?=
 =?utf-8?B?c21aWDNYOUV4cFVyZ3o5Y0JqRzNuRWRNRWVJUEtvNEhUWGRid2w5QS9od0s5?=
 =?utf-8?B?ZndsMVdjbGQ3WmRzU3pGRWR3eWQ3dUc5c1hwNVJYckZRZzl0enI4RFFadDRN?=
 =?utf-8?B?cnAzOVZnWThkcGFCSk8ycUEvNTBucmsvNTlOczV4ZG5rdU5laGNjTVg1S1M3?=
 =?utf-8?B?UXR4Mm5Ld1k5SzFNam5iN1hsZ25ld3A2dFZBRUNzc092ZzY4VFR2K0dzQkFk?=
 =?utf-8?B?Um91VmNaK1EwRDNSQ01zVmdRMDlOcFozNmxlelFwUThPbHFEd0dsYWg2dHBs?=
 =?utf-8?B?WU5aeFlUckluNHpSUTdvMzFuQ2hGdzFNUW91d1Y3U0lOa0hoME9vUU9Ga2FK?=
 =?utf-8?B?RzNlR0ZZSngxV2xsaGRKMXRLV2MzVWh6OG9TY3Q2QWI5eFF5REYydVJhWHRX?=
 =?utf-8?B?OXM2R2JoZ25WZXJlbTRqbmN5eElTZ2l2K1dRbEZ1K3RNTnF5S1A2c0UyRnJ6?=
 =?utf-8?B?OUtoYnRLaFQ5bUVxRXhPVVB5UkJ5eklBTHZVTjFTTUNvdzlRNEdjUVFoVlB1?=
 =?utf-8?B?Z0RhbmpvNDE0ZzJxb1BmeTV6cjdwSEFPN0VUR2VwNEg0RzYxK0JuQ1VuU0Fo?=
 =?utf-8?B?MG9EcVJDYVV5TjJvcVFpdTNicHZmMXl4Sit2dkxtT25DVVNIY2g4REpsSXZm?=
 =?utf-8?B?V1o0UHJPT0Q2WnRxZWtOZDNxbjBjdWM2QUxqaHBTbkNwcWZhaW1KUHJ2V0RR?=
 =?utf-8?B?ZDJwR2xFbnNqclhHSWhSek50dUNMVWpjZzZ2RC9UWG1zcnhMYXFsTTA2VzNS?=
 =?utf-8?B?SUhVSEh5M1V6Y2t1UnNYUGdqWCtYNUtEUExtTHphWU9ucG9MYjJWem15b0Ny?=
 =?utf-8?B?MVJnZGozcDd6OUh6Rmp5OHNIVjMxQURMMFRPVTgwanhKUC9GbjVuZnlHTTFC?=
 =?utf-8?B?K1lKcVlpNWdIdVAwTUVjU0dxajhNMVFLd0kzaWgxSmFMbEY1RzhGMlMwQ1Bp?=
 =?utf-8?B?L1FZZUdYeFgvcTNMYzZiVExVRnpRQXpPRzNnM1MyVGxCcVoxV0U4S2k5RmM0?=
 =?utf-8?B?RWlEVjBIMFlRdklHUVlWNmhpaUFoYnBPVjEvSnhIQjROdXljYWRZeU0wbDJa?=
 =?utf-8?B?Ty9zcThFTDlMQlFsZ1cyMGFObWwrcENIcFkwdDhyQUZCV3pmclZMMmZKK2hi?=
 =?utf-8?B?QjB6SUNlWnJpS0txVThRdWdTYUVXWFJkTCtUK3MxdmRoUk10clBYbWJuZHZ1?=
 =?utf-8?B?S0NtT0t1UmFuekRTVG0vU1ZkTStkUUZNNEdtZXo4NE5jV0hST1pZcVQ2Z2sy?=
 =?utf-8?B?RlJ4YlE2UkpFUmN0SXdIUlpkd2p6TWhISjQ0Zi9RbWhJNWRSOFF0a3B3ZU9a?=
 =?utf-8?B?SzhJbkRybzlDSWF6dDc3YkhxazNsb3BBaFV6QjZPZFdoV1djdlRhaEloREtT?=
 =?utf-8?B?U1JPelFvZUF4TlNYRC9lQ05OeHlXY0UydDNpQU1nSEs5eERsc1pFUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d284e5d-7079-4eb8-afd3-08df2dd25ee6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 11:16:07.1775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dMbmrIlr5pkqO9rpvMLV+p05vhrhTQzTVR8ifUJSGGsoBsGtIDZfiFfme/bR2WblUNH0Rr4tBokrmeAJqBMVfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8045



On 17/10/26 2:57 pm, Manivannan Sadhasivam wrote:
> On Wed, Sep 23, 2026 at 12:55:52PM +0530, Manikanta Maddireddy wrote:
>> Endpoint controllers can receive a fundamental reset while software
>> resources such as eDMA, debugfs and function state must live for the
>> controller lifetime.
>>
>> Track whether DWC Endpoint resources are initialized and add helpers
>> that perform full initialization once, then reinitialize only reset-lost
>> registers on later fundamental reset cycles.
>>
>> A fundamental reset also clears outbound iATU programming. Clear the
>> cached outbound window map, outbound address array and MSI iATU cache
>> before reinitializing registers so stale software state cannot hide a
>> window that was reset by hardware.
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>   .../pci/controller/dwc/pcie-designware-ep.c   | 152 +++++++++++++-----
>>   drivers/pci/controller/dwc/pcie-designware.h  |  13 ++
>>   2 files changed, 124 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
>> index de8ee3db4360..7ba40220b821 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
>> @@ -1155,6 +1155,28 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>>   }
>>   EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_msix_irq);
>>   
>> +static void dw_pcie_ep_clear_msi_iatu(struct dw_pcie_ep *ep)
>> +{
>> +	ep->msi_iatu_mapped = false;
>> +	ep->msi_iatu_mapped_offset = 0;
>> +	ep->msi_msg_addr = 0;
>> +	ep->msi_map_size = 0;
>> +}
>> +
>> +static void dw_pcie_ep_clear_outbound_atus(struct dw_pcie_ep *ep)
>> +{
> 
> I don't think this function clears the OB iATU mappings. It is done in
> dw_pcie_ep_unmap_addr().
> 

Correct, this helper only resets the software bookkeeping after a 
fundamental reset has cleared the hardware iATU configuration. It does 
not disable live mappings. I’ll rename it to 
dw_pcie_ep_reset_outbound_state() and clarify that prerequisite in the 
comment and commit message.

>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +
>> +	if (ep->ob_window_map)
>> +		bitmap_zero(ep->ob_window_map, pci->num_ob_windows);
>> +
>> +	if (ep->outbound_addr)
>> +		memset(ep->outbound_addr, 0,
>> +		       pci->num_ob_windows * sizeof(*ep->outbound_addr));
>> +
>> +	dw_pcie_ep_clear_msi_iatu(ep);
>> +}
>> +
>>   /**
>>    * dw_pcie_ep_cleanup - Cleanup DWC EP resources after fundamental reset
>>    * @ep: DWC EP device
>> @@ -1169,11 +1191,12 @@ void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep)
>>   
>>   	if (ep->msi_iatu_mapped) {
>>   		dw_pcie_ep_unmap_addr(ep->epc, 0, 0, ep->msi_mem_phys);
>> -		ep->msi_iatu_mapped = false;
>> +		dw_pcie_ep_clear_msi_iatu(ep);
>>   	}
>>   
>>   	dwc_pcie_debugfs_deinit(pci);
>>   	dw_pcie_edma_remove(pci);
>> +	ep->resources_initialized = false;
>>   }
>>   EXPORT_SYMBOL_GPL(dw_pcie_ep_cleanup);
>>   
>> @@ -1307,6 +1330,89 @@ static void dw_pcie_ep_disable_bars(struct dw_pcie_ep *ep)
>>   	}
>>   }
>>   
>> +static void dw_pcie_ep_init_ptm(struct dw_pcie_ep *ep)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +	u32 ptm_cap_base, reg;
>> +
>> +	/*
>> +	 * PCIe r6.0, section 7.9.15 states that for endpoints that support
>> +	 * PTM, this capability structure is required in exactly one
>> +	 * function, which controls the PTM behavior of all PTM capable
>> +	 * functions. This indicates the PTM capability structure
>> +	 * represents controller-level registers rather than per-function
>> +	 * registers.
>> +	 *
>> +	 * Therefore, PTM capability registers are configured using the
>> +	 * standard DBI accessors, instead of func_no indexed per-function
>> +	 * accessors.
>> +	 */
>> +	ptm_cap_base = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
>> +
>> +	/*
>> +	 * PTM responder capability can be disabled only after disabling
>> +	 * PTM root capability.
>> +	 */
>> +	if (ptm_cap_base) {
>> +		dw_pcie_dbi_ro_wr_en(pci);
>> +		reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
>> +		reg &= ~PCI_PTM_CAP_ROOT;
>> +		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
>> +
>> +		reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
>> +		reg &= ~(PCI_PTM_CAP_RES | PCI_PTM_GRANULARITY_MASK);
>> +		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
>> +		dw_pcie_dbi_ro_wr_dis(pci);
>> +	}
>> +}
>> +
>> +/**
>> + * dw_pcie_ep_reinit_registers - Reinitialize DWC EP reset-lost registers
>> + * @ep: DWC EP device
>> + *
>> + * Reinitialize the EP registers lost after a fundamental reset without
>> + * reallocating EP resources that live until dw_pcie_ep_deinit(). The
>> + * caller must only use this after hardware has reset the iATU; this
>> + * helper invalidates software iATU state but does not disable live
>> + * windows.
>> + */
>> +int dw_pcie_ep_reinit_registers(struct dw_pcie_ep *ep)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +	int ret;
>> +
>> +	dw_pcie_ep_clear_outbound_atus(ep);
>> +
>> +	if (ep->ops->init) {
>> +		ret = ep->ops->init(ep);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	dw_pcie_ep_disable_bars(ep);
>> +	dw_pcie_ep_init_ptm(ep);
>> +	dw_pcie_ep_init_non_sticky_registers(pci);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(dw_pcie_ep_reinit_registers);
>> +
>> +/**
>> + * dw_pcie_ep_init_or_reinit_registers - Initialize or reinitialize DWC EP
>> + * @ep: DWC EP device
>> + *
>> + * Initialize DWC EP resources on first use. If resources are already
>> + * initialized, reinitialize only the reset-lost registers.
>> + */
>> +int dw_pcie_ep_init_or_reinit_registers(struct dw_pcie_ep *ep)
>> +{
> 
> This function name looks awkward. Can you fold it inside
> dw_pcie_ep_init_registers() instead?
> 
> - Mani
> 
Agreed. I’ll move the selection into dw_pcie_ep_init_registers() and 
keep the register restoration helper internal. Tegra can then retain its 
existing initialization call and omit the full cleanup on each PERST# cycle.

- Manikanta

-- 
nvpublic

