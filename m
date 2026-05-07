Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013037.outbound.protection.outlook.com [40.107.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7DB3ED5BD
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 12:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778157072; cv=fail; b=XNstrk0sBDmcNIPAHwlXe8kOXODnPwFMavLCxmKIjdi4aAFRWsKjRkORqNPHyhiu4aE0v9JYWTzRj9K2uPqdhfZF9f/yq5T5BSk25bwkq+dkuUSFmbI53pfFKDqrDsdgfa23H9sfEZotrYVe810o1BDPubPwwoebUgciMdcH/ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778157072; c=relaxed/simple;
	bh=XCmhJNVg7AuhgO3zrqZ/BYdLvyHN0tnZSXd6OCtMKH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ieQGc0l/i/LWdLu6ljqnOhf6fkAQXjEO5x3USyYM2DrTPYLreiC3Y0lzEjRxEb0ydKLNi0zR/2dtUBOyoau2whvSRxg0JWzMvVGALcGoLgcHlvTk9AqYKZcekltO2gtEy9g9mSHCZq1mQOmP5NlJJNSCfN5XMfyzI+8aja95ZZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lrOO16qw; arc=fail smtp.client-ip=40.107.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lrOO16qw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t3gT1RbgDeGfRyXTOfRZdefncXQR8RLmbg4kpcQ5lErKSZomf8e1zxvFD1rUS+i8KNxPgB5oj1IXqOf7dC9S/irADmvyHS7aPBgRdTVthAYzG2eslIfIqXRHA1TAKKzVV9S3eeJMV/pso5RrFyjbyGEM6qJGg3SdVM7Qpv99IzLf2VHCSQzNP13dpCJjhjBvLDLpERpT/kNzcrC7wJDCkG6/UuBS/2KmNM4r195NxYGQXR5FoZydzz78avuYWx4W/PBqf2fWKxW9lB3M2z7sjhjj8e6W0GqZn5GRFyJv4+7gcXYDYnrs5Xraj5QJstmSmt/uBOoi3UYZALxO7gBATw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXkuWUka7DA2VDgDIywXpdJlqPyunrF+21AqLcPS0VQ=;
 b=SQ8AUD2FuvSjQIYtRm/QN4uJCDn1xb6m/vGY9O8W0RgjI23tWOTREkoXHkfwXS8TeQiNgY/E2XDotZwp6EKYY3DH/0zTu4aCaZzrNqBsMXoHuuImDyDO93R4lgxyv0rcYaEQBD4PrSoPFhjw2FFE7kzSAUVb+YjrZ/gUIzZCuZ5Q1OTsR3/ZmSsd1rTzM/lSNKZMtk8Re2yw/BWrnnl/qnl9uPEQH2Cc7KUmoCnMH7ElLFRNL37TCK2ROge9n8ifiMlHTOvkAPfxzBb9ZSuQSBgFVe5HtaDbLkYp3FDvSDrBRzahgJMxsfoI5KfxPOY9spO2jcytyIgqh91KeLzfEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXkuWUka7DA2VDgDIywXpdJlqPyunrF+21AqLcPS0VQ=;
 b=lrOO16qw1Dva9VTvBBsdmZHWuWiapwq2MxOIqXiJA4Hym+84ilqRW8zE07s3sSowtPDMbXOYEK3xVe0/jLgsTBorXWnfbd7+TTCGnRlbHD8i07UjQQOlAxdyGc/EbinoDsqzfQQiayXwCGWFkNEzLDgiynjBHO5C2NX8pehIhfg=
Received: from BL1PR13CA0334.namprd13.prod.outlook.com (2603:10b6:208:2c6::9)
 by IA1PR10MB7286.namprd10.prod.outlook.com (2603:10b6:208:3ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 12:31:07 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::54) by BL1PR13CA0334.outlook.office365.com
 (2603:10b6:208:2c6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.11 via Frontend Transport; Thu, 7
 May 2026 12:31:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 12:31:06 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 7 May
 2026 07:31:06 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 7 May
 2026 07:31:06 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 7 May 2026 07:31:06 -0500
Received: from [10.24.68.129] (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 647CV3DN3621932;
	Thu, 7 May 2026 07:31:04 -0500
Message-ID: <181c2204-dfb6-4484-b4e4-069d8c7445fd@ti.com>
Date: Thu, 7 May 2026 18:01:02 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: cadence: Use cdns_pcie_find_capability() to get PCIe
 Cap offset in host driver
To: Hans Zhang <18255117159@163.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Siddharth Vadapalli <s-vadapalli@ti.com>
CC: <sashiko@lists.linux.dev>, <linux-pci@vger.kernel.org>
References: <20260506171227.GA797577@bhelgaas>
 <a791e1d8-f17a-4e8c-8afe-d1da338f4c5e@163.com>
 <2e92d011-02fa-433f-92e3-142880d5d0d2@163.com>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <2e92d011-02fa-433f-92e3-142880d5d0d2@163.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|IA1PR10MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: 880aad1a-53af-41f1-d1e9-08deac3482f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	vmisWw1ha10L+YMlQ1vGv8ZFftxWh+Hm3v7vSzu9NDCSiNg++n6UoJgmhWK3ccP5vPrecGxL5oC7z1cMrpI9VBGUxAVL8Zbw8fEKrdAyxRqE8c9yXnEUOlfziXPPqbhw01VJDC+RaU2uB/qeK4QYlenau7InqJL68DjjwME/JTJvUdJNbNH3TF6ASjtzVszW9Q9SAmhd8hkjICzqOHOhoIHaOcizGPykiBAb866bw3l3/J+GJDWhRQlAA3Ro5RvLS62PapT7n8BqcqhcVlblE5Vmf7TO5thwElp/7WhPS4kO8M+t+QR4c9h9OIdDGNRwinRZdnuZA933H35oCMR4v6LX9WLd6OB33B9k/mAoOOmd7mubjeZSQWFRM88EUXULcxCOrr3P1zC3XY55djxWMQZXBMRvnHoK+rAIUvJsNVKdKMT5GDqrCmAvDbdqq1gueWAaLtq12YyZPMr+V0ljnxZx3mSbdm8sZq8uz9b1mXifbL52/6osJWoutNha6tD3wXZ2c6uChrhOH+fTzWLm/GM3DuYF4nADndO1xnXTdXgC+o+3u9z5k95o7SAg0lkr+tlpRFiXA1NWMp0MKWU5pz8QS27Aa6n8+1fbRFWrahyt7vg0sydFF2Tfea3OyhcuuJjKzuiBE5NGTKKq+NDh1pm5RPdqhZLJ/XRGTJtFkukMvpUuqLbiGAV8eX22jyTjKMhjriWUDTtZncL1uWX2aPXWyEsbcKSSqyxshXAS+m8=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Lw1Ih1tYBJEuiUUwttlq0gpIVwzVMd1sNZSlkarWcWmZtJZO/hbTXoYjuCEGPZgTV5nBroUj7U1/Onw/388FsO7AEL/okmEPbYog68cV9tLtHyIIKfv07AB8ZEQo5CCY0it+nz6fZwmjXcq8lg5bVSQaw3mkvFce8BF1d1YVIcpYbJd5+43OpudYtJnScbRWbk/HxYDPjcbVHkOpzPEbJt8DEhxp8D3IPC7X19W6A4RTuO6hlirtOmHhvRVVoy9QmW0YMKk4Clxv8X0nMNnjxrwK0VEaIgl8ea/AAYvTJYaDb28eJRFwD864BYsxaGF//TWuXGfuVs7IL7VaQ2OYutRbZU5Sxf/rsON8GAAsjK8g5JQneX9UNGLmW9ufgacB8zzgT6B5BrGvCDR3Edlve91yAcHjSisL6gtWiSF9T/QdsWZPnLVjiWr8ZFElmg40
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 12:31:06.7629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 880aad1a-53af-41f1-d1e9-08deac3482f8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7286



On 07/05/26 09:18, Hans Zhang wrote:
> 
> 
> On 5/7/26 11:31, Hans Zhang wrote:
>>
>>
>> On 5/7/26 01:12, Bjorn Helgaas wrote:
>>> On Thu, May 07, 2026 at 12:04:34AM +0800, Hans Zhang wrote:
>>>> On 5/6/26 05:23, Bjorn Helgaas wrote:
>>>>> On Mon, May 04, 2026 at 04:22:26PM +0800, Hans Zhang wrote:
>>>>>> On 5/4/26 00:52, sashiko-bot@kernel.org wrote:
>>>>>>> Thank you for your contribution! Sashiko AI review found 1
>>>>>>> potential issue(s) to consider:
>>>>>>>
>>>>>>> - [Critical] cdns_pcie_find_capability() searches the wrong
>>>>>>> register space in Host mode and its return value is not validated,
>>>>>>> leading to Root Port configuration space corruption.
>>>>>>> -- 
>>>>>>>
>>>>>>> commit 09b3c64b8f5892eb365acd13030a8067652a15e8
>>>>>>> Author: Hans Zhang <18255117159@163.com>
>>>>>>>
>>>>>>> PCI: cadence: Use cdns_pcie_find_capability() to get PCIe Cap 
>>>>>>> offset in host driver
>>>>>>>
>>>>>>> This commit replaces the hardcoded CDNS_PCIE_RP_CAP_OFFSET with a 
>>>>>>> dynamic
>>>>>>> lookup using cdns_pcie_find_capability() in Cadence PCIe host- 
>>>>>>> related
>>>>>>> functions. The goal is to ensure correct operation across various 
>>>>>>> SoC designs
>>>>>>> where the capability might not reside at offset 0xC0.
>>>>>>>
>>>>>>>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host- 
>>>>>>>> common.c b/drivers/pci/controller/cadence/pcie-cadence-host- 
>>>>>>>> common.c
>>>>>>>> index 2b0211870f02..5013d3fe23b5 100644
>>>>>>>> --- a/drivers/pci/controller/cadence/pcie-cadence-host-common.c
>>>>>>>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
>>>>>>>> @@ -26,14 +26,14 @@ EXPORT_SYMBOL_GPL(bar_max_size);
>>>>>>>>     int cdns_pcie_host_training_complete(struct cdns_pcie *pcie)
>>>>>>>>     {
>>>>>>>> -    u32 pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
>>>>>>>>         unsigned long end_jiffies;
>>>>>>>>         u16 lnk_stat;
>>>>>>>> +    u8 cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_EXP);
>>>>>>>
>>>>>>> Does this capability search scan the correct register space when
>>>>>>> operating in host mode?
>>>>>>>
>>>>>>> Looking at the helper function, it uses cdns_pcie_read_cfg() which
>>>>>>> reads directly from the base address without the Root Port offset:
>>>>>>>
>>>>>>> drivers/pci/controller/cadence/pcie- 
>>>>>>> cadence.c:cdns_pcie_find_capability() {
>>>>>>>        return PCI_FIND_NEXT_CAP(cdns_pcie_read_cfg, 
>>>>>>> PCI_CAPABILITY_LIST,
>>>>>>>                                 cap, NULL, pcie);
>>>>>>> }
>>>>>>>
>>>>>>> However, the Root Port configuration registers are physically
>>>>>>> located at pcie->reg_base + CDNS_PCIE_RP_BASE. Could this cause
>>>>>>> the search to scan the Local Management register space instead,
>>>>>>> failing to find PCI_CAP_ID_EXP and returning 0?
>>>>>>
>>>>>> I don't think we need to worry about this issue.
>>>>>>
>>>>>> As per PCIe r7.0, sec 7.5.1.1.11, Since all PCI Express Functions
>>>>>> are required to implement the PCI Express Capability structure,
>>>>>> which must be included somewhere in this linked list;
>>>>>>
>>>>>> So, it won't return 0 here.
>>>>>
>>>>> It's true that all Root Ports must have a PCIe Capability, but
>>>>> that's not related to this issue.
>>>>>
>>>>> cdns_pcie_host_init_root_port() accesses PCI_EXP_LNKCAP at the
>>>>> address:
>>>>>
>>>>>     pcie->reg_base + CDNS_PCIE_RP_BASE + CDNS_PCIE_RP_CAP_OFFSET + 
>>>>> PCI_EXP_LNKCAP
>>>>>
>>>>> but when we search with cdns_pcie_find_capability(pcie, 
>>>>> PCI_CAP_ID_EXP),
>>>>> we start reading at:
>>>>>
>>>>>     pcie->reg_base + PCI_CAPABILITY_LIST
>>>>>
>>>>> It should be starting at:
>>>>>
>>>>>     pcie->reg_base + CDNS_PCIE_RP_BASE + PCI_CAPABILITY_LIST
>>>>>
>>>>> Previously, cdns_pcie_find_capability() and
>>>>> cdns_pcie_find_ext_capability() were only used for endpoints, and I
>>>>> assume they work fine there.  There is pcie->is_rc, so there should be
>>>>> a way to make this work for both endpoints and Root Ports.
>>>>
>>>> The reason for using the "is_rc" tag is that for Cadence IP, it is 
>>>> not only
>>>> applicable to the RC or EP mode, but also there are significant 
>>>> differences
>>>> between the LGA and HPA generations of IP. Including register offset 
>>>> values,
>>>> definitions, etc., it fails to achieve good compatibility. It is not 
>>>> like
>>>> Synopsys IP, where compatibility has been handled very well. It was 
>>>> truly
>>>> out of necessity.
>>>
>>> I think cdns_pcie_find_capability(pcie, PCI_CAP_ID_EXP) fails on Root
>>> Ports because it doesn't include the CDNS_PCIE_RP_BASE offset.  Do you
>>> have hardware where you can test that?
> 
> Hi Siddharth,
> 
> Could you please test the functions mentioned above? It would be great 
> if you could help test it and give us your feedback. (pci-j721e.c)
> 
> I guess the following changes might need to be made.
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/ 
> pci/controller/cadence/pcie-cadence.h
> index 574e9cf4d003..bb01761749f1 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -298,6 +298,9 @@ static inline int cdns_pcie_read_cfg_byte(struct 
> cdns_pcie *pcie, int where,
>   {
>          void __iomem *addr = pcie->reg_base + where;
> 
> +       if ((pcie->is_rc) && (!pcie->is_hpa))
> +               addr += CDNS_PCIE_RP_BASE;
> +
>          *val = cdns_pcie_read_sz(addr, 0x1);
>          return PCIBIOS_SUCCESSFUL;
>   }
> @@ -307,6 +310,9 @@ static inline int cdns_pcie_read_cfg_word(struct 
> cdns_pcie *pcie, int where,
>   {
>          void __iomem *addr = pcie->reg_base + where;
> 
> +       if ((pcie->is_rc) && (!pcie->is_hpa))
> +               addr += CDNS_PCIE_RP_BASE;
> +
>          *val = cdns_pcie_read_sz(addr, 0x2);
>          return PCIBIOS_SUCCESSFUL;
>   }
> @@ -314,7 +320,12 @@ static inline int cdns_pcie_read_cfg_word(struct 
> cdns_pcie *pcie, int where,
>   static inline int cdns_pcie_read_cfg_dword(struct cdns_pcie *pcie, int 
> where,
>                                             u32 *val)
>   {
> -       *val = cdns_pcie_readl(pcie, where);
> +       void __iomem *addr = pcie->reg_base + where;
> +
> +       if ((pcie->is_rc) && (!pcie->is_hpa))
> +               addr += CDNS_PCIE_RP_BASE;
> +
> +       *val = cdns_pcie_read_sz(addr, 0x4);
>          return PCIBIOS_SUCCESSFUL;
>   }
> 
> 
> "is_hpa" flag I added it in another series. As mentioned before, the 
> compatibility of Cadence IP is not very good. It is divided into LGA and 
> HPA IP. And there are many differences between the Root Port and the 
> Endpoint.
> 
> https://patchwork.kernel.org/project/linux-pci/ 
> patch/20260406103237.1203127-2-18255117159@163.com/
> 
> Best regards,
> Hans
> 

Hi Hans,

I have tested this on J7200 and J721E SoCs, which uses pci-j721e.c
driver for their PCIe controllers. The patch alone fails to find the
capabilities using cdns_pcie_find_capability() for Root Port.

With the "is_hpa" flag patch, and the patch "PCI: cadence: Use
cdns_pcie_find_capability() to get PCIe Cap offset in host driver" along
with the diff suggested above:

Tested-by: Aksh Garg <a-garg7@ti.com>


I would also like me to be included in the CC list for future
correspondence regarding Cadence PCIe Controller patches.

Regards,
Aksh Garg

>>
>> Hi Bjorn,
>>
>> The attachment contains the dmesg and lspci -vvv log from the test.
>>
>> Here is the test code:
>>
>> diff --git a/drivers/pci/controller/cadence/pci-sky1.c b/drivers/pci/ 
>> controller/cadence/pci-sky1.c
>> index cd55c64e58a9..0d0c42309127 100644
>> --- a/drivers/pci/controller/cadence/pci-sky1.c
>> +++ b/drivers/pci/controller/cadence/pci-sky1.c
>> @@ -130,6 +130,39 @@ static const struct cdns_pcie_ops sky1_pcie_ops = {
>>       .link_up = sky1_pcie_link_up,
>>   };
>>
>> +void cix_pcie_test_cap(struct sky1_pcie *pcie)
>> +{
>> +    u16 offset;
>> +
>> +    printk(KERN_EMERG"[HANS] fun = %s, line = %d ........... \n", 
>> __func__, __LINE__);
>> +    /* capability */
>> +    offset = cdns_pcie_find_capability(pcie->cdns_pcie, PCI_CAP_ID_PM);
>> +    printk(KERN_EMERG"[HANS]pm offset = 0x%x\n", offset);
>> +    offset = cdns_pcie_find_capability(pcie->cdns_pcie, PCI_CAP_ID_MSI);
>> +    printk(KERN_EMERG"[HANS]msi offset = 0x%x\n", offset);
>> +    offset = cdns_pcie_find_capability(pcie->cdns_pcie, 
>> PCI_CAP_ID_MSIX);
>> +    printk(KERN_EMERG"[HANS]msix offset = 0x%x\n", offset);
>> +    offset = cdns_pcie_find_capability(pcie->cdns_pcie, PCI_CAP_ID_EXP);
>> +    printk(KERN_EMERG"[HANS]exp offset = 0x%x\n", offset);
>> +
>> +    printk(KERN_EMERG"[HANS] fun = %s, line = %d ........... \n", 
>> __func__, __LINE__);
>> +    /* extend capability */
>> +    offset = cdns_pcie_find_ext_capability(pcie->cdns_pcie, 
>> PCI_EXT_CAP_ID_ERR);
>> +    printk(KERN_EMERG"[HANS]aer offset = 0x%x\n", offset);
>> +    offset = cdns_pcie_find_ext_capability(pcie->cdns_pcie, 
>> PCI_EXT_CAP_ID_VC);
>> +    printk(KERN_EMERG"[HANS]Virtual Channel offset = 0x%x\n", offset);
>> +    offset = cdns_pcie_find_ext_capability(pcie->cdns_pcie, 
>> PCI_EXT_CAP_ID_DSN);
>> +    printk(KERN_EMERG"[HANS]Device Serial Number offset = 0x%x\n", 
>> offset);
>> +    offset = cdns_pcie_find_ext_capability(pcie->cdns_pcie, 
>> PCI_EXT_CAP_ID_PWR);
>> +    printk(KERN_EMERG"[HANS]pwr offset = 0x%x\n", offset);
>> +    offset = cdns_pcie_find_ext_capability(pcie->cdns_pcie, 
>> PCI_EXT_CAP_ID_REBAR);
>> +    printk(KERN_EMERG"[HANS]resize bar offset = 0x%x\n", offset);
>> +    offset = cdns_pcie_find_ext_capability(pcie->cdns_pcie, 
>> PCI_EXT_CAP_ID_SECPCI);
>> +    printk(KERN_EMERG"[HANS]second exp offset = 0x%x\n", offset);
>> +    offset = cdns_pcie_find_ext_capability(pcie->cdns_pcie, 
>> PCI_EXT_CAP_ID_L1SS);
>> +    printk(KERN_EMERG"[HANS]L1ss offset = 0x%x\n", offset);
>> +}
>> +
>>   static int sky1_pcie_probe(struct platform_device *pdev)
>>   {
>>       struct cdns_plat_pcie_of_data *reg_off;
>> @@ -141,6 +174,7 @@ static int sky1_pcie_probe(struct platform_device 
>> *pdev)
>>       struct sky1_pcie *pcie;
>>       int ret;
>>
>> +    printk(KERN_EMERG"[HANS] fun = %s, line = %d ........... \n", 
>> __func__, __LINE__);
>>       pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>>       if (!pcie)
>>           return -ENOMEM;
>> @@ -202,6 +236,8 @@ static int sky1_pcie_probe(struct platform_device 
>> *pdev)
>>
>>       dev_set_drvdata(dev, pcie);
>>
>> +    cix_pcie_test_cap(pcie);
>> +
>>       ret = cdns_pcie_hpa_host_setup(rc);
>>       if (ret < 0) {
>>           pci_ecam_free(pcie->cfg);
>> @@ -230,7 +266,7 @@ static struct platform_driver sky1_pcie_driver = {
>>       .driver = {
>>           .name = "sky1-pcie",
>>           .of_match_table = of_sky1_pcie_match,
>> -        .probe_type = PROBE_PREFER_ASYNCHRONOUS,
>> +        // .probe_type = PROBE_PREFER_ASYNCHRONOUS,
>>       },
>>   };
>>   module_platform_driver(sky1_pcie_driver);
>>
>>
>> For the LGA IP, an offset address CDNS_PCIE_RP_BASE needs to be added. 
>> And the HPA IP requires an offset address of CDNS_PCIE_HPA_RP_BASE, 
>> but it is equal to 0;
>>
>> drivers/pci/controller/cadence/pcie-cadence-hpa-regs.h
>>
>> /* Root Port register base address */
>> #define CDNS_PCIE_HPA_RP_BASE            0x0
>>
>> Therefore, for "drivers/pci/controller/cadence/pci-sky1.c", it is normal.
>>
>>
>>
>> Using the following code for work is also normal. Later, I will re- 
>> unify it into the same operation.
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/ 
>> pci/controller/cadence/pcie-cadence.h
>> index 574e9cf4d003..723ea79fb02e 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence.h
>> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
>> @@ -314,7 +314,9 @@ static inline int cdns_pcie_read_cfg_word(struct 
>> cdns_pcie *pcie, int where,
>>   static inline int cdns_pcie_read_cfg_dword(struct cdns_pcie *pcie, 
>> int where,
>>                                             u32 *val)
>>   {
>> -       *val = cdns_pcie_readl(pcie, where);
>> +       void __iomem *addr = pcie->reg_base + where;
>> +
>> +       *val = cdns_pcie_read_sz(addr, 0x4);
>>          return PCIBIOS_SUCCESSFUL;
>>   }
>>
>>
>> Best regards,
>> Hans
>>
>>
> 

