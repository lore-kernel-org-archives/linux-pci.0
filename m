Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010065.outbound.protection.outlook.com [52.101.193.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2724A093F;
	Wed, 23 Sep 2026 18:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187959; cv=fail; b=aEOQVtLthlxVpUszgVfI1MLrGULYfrUCZioLVJFpPoYWOoSxJz3QtdmBtGCumnI4BmgpQxSOM+C0ARqM5cXOPYNIDcY14ho5nBxPPZCzLaCWVsa3fpvl6fliWZKJPPwy0/pK9fN3XitH88HPSVm8uUuY7NUtVrzXzUmlOzrL5Qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187959; c=relaxed/simple;
	bh=DkY19b6VyaoVMme+y/CZCPAu5fA9VsnoRt8ezzxyYOU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VkNitLH8esRKA0hUZWYNdtqIamxVNACA4rWhw+73sHh16ahzHqXLtzRODNk+IMTHYPfMJqGlmEajI9q1VFZTFoNoD6qGNhUJHT49bADvUc5zd3QUx2CkEJfF5FEv62fem4h3QzFVnHgftDaHTM6VUiwknmz4uhfu+tsaZYWZGUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gfWdCdKy; arc=fail smtp.client-ip=52.101.193.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gfWdCdKy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBZQlKglsdzRPZTs4IKSnavSWPXFUANWBDZNjvTfbn2aOe6wQopgpMEh1o0M/83E0qcG8Dcr+dDlK1zimJj1ImIizvlmfL4Vcy/0QflBMD+hHwOizFsY+7eW+wI52411nI8OP5DWjbpW8Ghz5DwteUbfuUM13aQ5H9WgiQc8wBaWuq255mIT0XGJ1fpk0g1SeCDa3Y7g3ar2kvA+p/7QTLPPwTxlw6XMa87nj/HpnzPXNRfvx+fwWipJpwv1ikc2nrJz44tIIuPUGaUiq5Io33FbEB1q+TuYlpaD8WWYD6x3ANfahrzKLaynodP5C/yg1RjgVBOKMh2+Nn0kPJNlpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tKNdP2sfmRMuocqOn6osaoIQUcw+7ztS8rGjUJQAA8=;
 b=RWYe/Xg/BuX6SACbGLaZFyPtLuk8FT6buYx3nyQFQBJpdGBzjiy61cdmkncR9tnQPvQZsfvviLu/pnVGF7C1E7N28F3nd3/wNk8JX2CN5+rqkHV0hhGmnWMLtuSTmdbvt2XlnEX6V2vyCdeJwAFa9PLlNkNez3o3TVr6+mU58kk16GQAlGxEpfg61aXLnROYrYfCsZQtMsd7wwc/h5cpdaBd/RrV6FBGFg4Mstw8Uz1sL5exINM4VuayqtpAqFYUM6z8+AcEM9tmpLzG+vMXOIFvZCnYmfJkYWnT8lnpHW7n95UNwOh78csmpGeOpEMVU3oDlbPtKaYeUFKilclx7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tKNdP2sfmRMuocqOn6osaoIQUcw+7ztS8rGjUJQAA8=;
 b=gfWdCdKyEzKkqJC8fHXrGxlYozaC9NFjtwBi1pVrPSOMJ+NGtC2M0dFebct3PLXN9+vTHD885Zmb+aprfssNVejfDfbM4+6u9KinL3e/lZS7pxsPUhIZx6XK4VyS0vsBZEKwbzPw74v8dDsPi6PWQ8R+fWAjRvjOkcQODNqf4B4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8)
 by SA3PR12MB8802.namprd12.prod.outlook.com (2603:10b6:806:314::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 18:25:50 +0000
Received: from MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b]) by MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 18:25:50 +0000
Message-ID: <75749d19-1839-4a62-8062-c47d6b85fd0c@amd.com>
Date: Wed, 23 Sep 2026 13:25:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/PCI: Disable enhanced atomics on some AMD PCIe
 ports
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)"
 <linux-ide@vger.kernel.org>, david.laight.linux@gmail.com,
 John Smith <imjohnsmith4000@gmail.com>,
 Lennert Buytenhek <kernel@wantstofly.org>,
 Roland Waltersson <roland.waltersson@netinsight.net>,
 Mikael Etienne <mikael1022bzh@gmail.com>, Arthur Husband
 <artmoty@gmail.com>, Alvin Lim <alvinwylim@gmail.com>
References: <20260923180543.GA1874684@bhelgaas>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260923180543.GA1874684@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::16) To MW4PR12MB6921.namprd12.prod.outlook.com
 (2603:10b6:303:208::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6921:EE_|SA3PR12MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: 1812db95-61a3-478b-99db-08df19a01843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	Y5XMPaa3UNAKWC/yzsun7qnrHMQAEm0X2+bgb1QONNU3brpFpNZDrjpEFJnVFyAGSR783Q0LOV70UlJAlmxk2vXurqglFMTUYNcvFScMt9mboKY+G9fk64z7R1u9Y0Jff0Gisd9z/WcJI0JTqHQ6Phb/8wNZwgjTW18HyUR/HR+yeXADSRPs1whqs5tk20qjJp966yluugwMzeOMXuf7+fO/c8puR1k4f5XSOt+jAmrLaPB/ebbRvCuARVlepkSO7dGc5ZbX4dYzrsehU1xkQ/BxKrl/e4wsAXuvTZK54NxrkDAt7fI8Oy1EGtJMvmCQYwnUJulxfHqByY4jMd1pHBjmp3eRvd2BIxUPUd+aWdnWO8Ui0erbqizvq66jGhDlH/t4GsQeE2G4h/0wOCnKJIaMAooLMaaYfBc6RSe4ls01FbIryC8+Ah+fN2WaKQb/5R2cE0NO0iR17G8lYU40Ejy/VK5bwOb6ra6+b6vZt8hfTPxGCoJojYlz54zveUw0QKhM8sccv9Whd2ymffHQuX0iD+MGEaULOt1RIv309RNodZajJ8X9LWg/a4z/xl+xlkfDMR7HHUOb0+nSEQ3OO9ZubyBKz4KS7vO2AfO7d3z+o/6CBOuAm98z8aa+8z6/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6921.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mi9DMDFCK3V2QUVsb0hNT0VuWVZUOXRQTXBCMkg2QkNCNjVZRTM0azFDditk?=
 =?utf-8?B?ek1LR1oreHEvbVgvQURaOGl3TGREVGhvVlFEdXdaZGduVDNROFMvWmJ3WnlO?=
 =?utf-8?B?UGZhQlQ2VkJhZzFTS1FqUTFlWmg0YlBuSURtSWFqT2o0ellGSG1DdG91YXdM?=
 =?utf-8?B?YVpIWDcvTUk4TFpwcUJycExvTFVWOWNxRmRKME51TElNUyt1aVVOL2YzZEg1?=
 =?utf-8?B?dDZUZlJLc1k4VWF1aWRPVGQ1TTQ5UFJpd3praWxweXd5TE9lVHhDcG1VN05I?=
 =?utf-8?B?WHBSZmJ1MWpaRG1YK0wzSitLNGt4UjR4TW1ieTVHbGg3aVk0WWk1WmxEYVlR?=
 =?utf-8?B?MzAxZWJ3TEJyUHJjYXhKOTM0Vmx2YldSRmhTcFNiZHRoczFXbDF4bUx5WHZQ?=
 =?utf-8?B?eG85KzBPSFhDbm5MNW92NFBKbDNJZjJnU1pHMWZJWXhGd2lndFo4OGZpUFBl?=
 =?utf-8?B?UGMzNFpSMCtUVEhISnZ4bWYrNVdzTExhcjNEbkJYdktJazZKOFhlMm95cGZz?=
 =?utf-8?B?dnNOOVdIWnVSZVpxelhrTDkwRTUySklRMm5aall2Z1llWVVFcFJCYlhyYjkv?=
 =?utf-8?B?SHpMZVlyZWxpcWlKbi9sUEJsSWZQMFBrS29WcGdDTnN0NnV0TkpnbWhoNWZL?=
 =?utf-8?B?RFNlNTdtYjRra3FXcXI3WXBTbHVMYlBOaEgzMzJIcDlnQ2p5Q0FxUzZNWGtL?=
 =?utf-8?B?L2ZDOHEzT2RDTTJZUlFQZjFxa1BBWU5UZVBtZWZsbDBpcHJzUWVNUW9YZHBR?=
 =?utf-8?B?MzJFWXRHTU4yZmtqSDNPOVZEblc1THpBSEtFTUJDUHdtNC85Uk1ReHRRTFhM?=
 =?utf-8?B?OVhYeHI0a0NWaFl2Y1grK0U4QVVMM0N1MmtRTHFlbis2T0lRNXk3Nnk4amY2?=
 =?utf-8?B?OHVKRGtUclYxTG9wSVFuL09DbmYxQUR5MExSenJVWHJtd2FEckhMOEFUQk9a?=
 =?utf-8?B?Y2F2TWR5UUJWa2lYcVRta0dXVmxXN1E0bnZVUHg5a0x5R2hCWlBZUjN5U3dQ?=
 =?utf-8?B?U1c0SDhuVytSOHhVMzlrcmR0d2NRZ0xNZEpOenNLRUpyYjdXS2NtV2FDL2Fq?=
 =?utf-8?B?U0ZpMi80cFFGdVh1QzBaNzNCU1pUenJrelJ1b3d3QjBnQzFnMTk0ODJQaVpB?=
 =?utf-8?B?UHFVeW56TjNUQ1BmbURjYkNJcVR3NUY1a1kvL3hHYUFuZTViRTcxRDlOOTZz?=
 =?utf-8?B?Nng4RzZkQmloYnNzeWhPNDRBRmtqeTlFS0tLalpialhHRSsxMENhcmkvNUdp?=
 =?utf-8?B?VGVuTTZobnplZy8wSFEwazNCd0lYR0dRYWVCNnRrRHV4aG5tbGh0emdUT2Ft?=
 =?utf-8?B?bDI0SVd1ODFTT0NIbmJqRmdnOTZQRzJSNzEwQXVHMll6R2wxUlBTd1dNVW5k?=
 =?utf-8?B?QlZvTDBCekJKL1VURVc0UDhmQXV6RHl5QTVKZVFaNENTOEFkSEJhRFpxNktI?=
 =?utf-8?B?NHFiaVpmNnVsKzFnZ2dqOGNveUtmUUhOZzVwNXNXaEZldVk1ZFFkWXNMOWVW?=
 =?utf-8?B?QjZvSTFqRkI0dnhiOHpPQlZITHZVZmt5bXNpelIwYW1mcVU4RjZwdG9kSHQ5?=
 =?utf-8?B?UnNzYmx1VzdvaURvWFR0QjVWQnA1dk5FTTRKMWtZbnY4Zk4wRFpiZEx4ekgy?=
 =?utf-8?B?dURuZkJ5b1YxdCtBb3BJQXpuOE5RRFU3Tlg3S3VYVlgrK09mdDJhMjlTeUpT?=
 =?utf-8?B?SEhpQ3ExSnpoUzNlaGNydFVpMDB0RjhFUzJaV1dMUGs0ZTBNOXVNeXJuL3V1?=
 =?utf-8?B?L0FvbVMxTFV6RDZGS2pHcFEzemhYUm0xbTJBcW5rbHhCeGZIN01udDF1UEU1?=
 =?utf-8?B?Y3dNSmV6ei9RdUxGaXkxRm8wd0ZvbnR0eVhMcEMyVGJScnJUTisvTnJyUjhQ?=
 =?utf-8?B?Y056NExPRitVdEp4NzJOV21jYSs4UksxUGlvdFo4RTVHTWlrQTJzN3owbGFp?=
 =?utf-8?B?cGFQYldYZmdleUxGQVp5Y3FOTnNOcUpJSEcwQW13b2JEc1Z0MklNRitLMFlu?=
 =?utf-8?B?S1FuaC9ubkFyWGxmd3E2WTBoQmhHRWNINnFHZjZwM2RBS3ZlRGhkdDM3ZFJy?=
 =?utf-8?B?M0RHMDZqb2RyUkxjWUpyV01MemdaQWNEOS93bkZ4eGFPWEVsTmZjcEk2YmVw?=
 =?utf-8?B?eWtVTWhrcmlYdklCSXRFaGhYMVZvRE15QURRVlpYQXBCa2p3ZXV0bXEvcGlJ?=
 =?utf-8?B?TEhvOFlVOUdFTUd3MUtFQ0RkRnFoQlZZSGxqVFg5L3dkWVlEbXdlaExZMmNo?=
 =?utf-8?B?Y2RyYmI3MEZ0UmwrVzBwYnRUSWhEb2hwVFlnL1lFTUdQRTVBaThCc0RGQiti?=
 =?utf-8?B?d09NWEg3L1FjZGp0c3Ryc1dIT2k2VDExckEvQzAvQlRxQnNHSEFGZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1812db95-61a3-478b-99db-08df19a01843
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6921.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 18:25:50.4102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7cR5Z+mB4TNeOoCCEOlFKn7bHOoR08Vm7eBh8vx4U0MdBdCQy5fAth5EX+dc2K871vJtLuEz+IlZtjWbvtpe1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8802



On 9/23/26 13:05, Bjorn Helgaas wrote:
> On Wed, Sep 23, 2026 at 12:30:59PM -0500, Mario Limonciello wrote:
>> On 9/23/26 12:12, Bjorn Helgaas wrote:
>>> On Tue, Sep 08, 2026 at 02:05:59PM -0500, Mario Limonciello wrote:
>>>> There have been multiple reports of data corruption that can occur
>>>> with 64-bit DMA when the IOMMU is enabled. This occurs due to some
>>>> BIOSes enabling enhanced atomic operations on PCIe ports.
>>>>
>>>> When enhanced atomic operations are enabled on PCIe ports for some
>>>> models, data corruption occurs when the 32-bit IOVA space is exhausted.
>>>> The problem is reported on storage devices, but can affect any device
>>>> that uses 64 bit DMA.
>>>>
>>>> Disable enhanced atomics using SMN for NBIO 7.7 and 7.11 based models.
>>>
>>> Can this issue happen without IOMMU?  Devices can do 64-bit DMA even
>>> without an IOMMU being enabled.
>>
>> Yes; it can technically happen without IOMMU enabled as well.
>>
>> The issue happens in NBIO /before/ IOMMU decodes it.
>>
>>> When I asked Gemini to explain this, it suggested that "enhanced
>>> atomics" is an AMD NBIO feature that translates PCIe AtomicOps into
>>> native Infinity Fabric atomic transactions.  But I guess the issue
>>> affects any DMA above 4GB, not just AtomicOps, right?
>>
>> That explanation isn't 100% correct.  Yes; it is an NBIO feature, but the
>> issue is related with how some devices interact with the upper bits of MWr64
>> TLPs.
>>
>> This feature should not be enabled on any ports on these SoCs being quirked.
> 
> What do you think of the log below?  Since it can happen without
> IOMMU, I think it's better to omit it so people don't think disabling
> the IOMMU is a workaround.
> 
>    x86/PCI: Disable enhanced atomics on AMD NBIO 7.7 and 7.11
> 
>    Multiple users report data corruption during 64-bit DMA transfers on
>    systems with AMD NBIO 7.7 and 7.11 controllers.
> 
>    This occurs when BIOS enables AMD "enhanced atomic operations" on PCIe Root
>    Ports. When enhanced atomics are enabled, any 64-bit DMA access may be
>    corrupted.
> 
>    Disable enhanced atomics using SMN for NBIO 7.7 and 7.11 based models.
> 

That's great, thanks.

> 
>>>> Cc: david.laight.linux@gmail.com
>>>> Cc: John Smith <imjohnsmith4000@gmail.com>
>>>> Cc: Lennert Buytenhek <kernel@wantstofly.org>
>>>> Cc: Niklas Cassel <cassel@kernel.org>
>>>> Cc: Roland Waltersson <roland.waltersson@netinsight.net>
>>>> Reported-by: Mikael Etienne <mikael1022bzh@gmail.com>
>>>> Closes: https://lore.kernel.org/all/178789300872.392066.15963676631650361573@gmail.com/
>>>> Reported-by: Arthur Husband <artmoty@gmail.com>
>>>> Closes: https://lore.kernel.org/linux-ide/20260406222335.379935-1-artmoty@gmail.com/
>>>> Reported-by: Alvin Lim <alvinwylim@gmail.com>
>>>> Closes: https://lore.kernel.org/linux-ide/20260621100844.1224301-1-alvinwylim@gmail.com/
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>> v2:
>>>>    * Apply to suspend/resume as well.
>>>> ---
>>>>    arch/x86/pci/fixup.c | 99 ++++++++++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 99 insertions(+)
>>>>
>>>> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
>>>> index b301c6c8df753..79e4338e4b876 100644
>>>> --- a/arch/x86/pci/fixup.c
>>>> +++ b/arch/x86/pci/fixup.c
>>>> @@ -886,6 +886,105 @@ static void quirk_clear_strap_no_soft_reset_dev2_f0(struct pci_dev *dev)
>>>>    	}
>>>>    }
>>>>    DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15b8, quirk_clear_strap_no_soft_reset_dev2_f0);
>>>> +
>>>> +/*
>>>> + * Enhanced atomic operations can cause corruption with 64-bit IOVA
>>>> + * on these devices.
>>>> + */
>>>> +#define RX_ENH_ATOMIC_EN		BIT(8)
>>>> +
>>>> +static const u32 nbio_7_7_pcie_smn_addrs[] = {
>>>> +	0x111401d0,
>>>> +	0x111411d0,
>>>> +	0x111421d0,
>>>> +	0x111431d0,
>>>> +	0x111441d0,
>>>> +	0x112401d0,
>>>> +	0x112411d0,
>>>> +	0x112421d0,
>>>> +	0x112431d0,
>>>> +	0x112441d0,
>>>> +	0x112451d0,
>>>> +	0x113401d0,
>>>> +	0x114401d0,
>>>> +};
>>>> +
>>>> +static const u32 nbio_7_11_pcie_smn_addrs[] = {
>>>> +	0x112401d0,
>>>> +	0x112411d0,
>>>> +	0x112421d0,
>>>> +	0x112431d0,
>>>> +	0x112441d0,
>>>> +	0x112451d0,
>>>> +	0x113401d0,
>>>> +	0x113411d0,
>>>> +	0x113421d0,
>>>> +	0x113431d0,
>>>> +	0x113441d0,
>>>> +	0x113451d0,
>>>> +};
>>>> +
>>>> +static void quirk_amd_nbio_enhanced_atomic(struct pci_dev *host_bridge,
>>>> +					   const u32 *smn_addrs,
>>>> +					   size_t nr_smn_addrs)
>>>> +{
>>>> +	bool changed = false;
>>>> +	size_t i;
>>>> +	u32 data;
>>>> +	int ret;
>>>> +
>>>> +	for (i = 0; i < nr_smn_addrs; i++) {
>>>> +		ret = amd_smn_read(0, smn_addrs[i], &data);
>>>> +		if (ret)
>>>> +			continue;
>>>> +		if (!(data & RX_ENH_ATOMIC_EN))
>>>> +			continue;
>>>> +		data = data & ~RX_ENH_ATOMIC_EN;
>>>> +		ret = amd_smn_write(0, smn_addrs[i], data);
>>>> +		if (ret)
>>>> +			continue;
>>>> +		if (changed)
>>>> +			continue;
>>>> +		ret = amd_smn_read(0, smn_addrs[i], &data);
>>>> +		if (ret)
>>>> +			continue;
>>>> +		if (data & RX_ENH_ATOMIC_EN)
>>>> +			continue;
>>>> +		changed = true;
>>>> +	}
>>>> +
>>>> +	if (changed)
>>>> +		pci_info(host_bridge, "enhanced atomics disabled\n");
>>>> +}
>>>> +
>>>> +static void quirk_amd_nbio_7_7_disable_enhanced_atomic(struct pci_dev *dev)
>>>> +{
>>>> +	quirk_amd_nbio_enhanced_atomic(dev, nbio_7_7_pcie_smn_addrs,
>>>> +				       ARRAY_SIZE(nbio_7_7_pcie_smn_addrs));
>>>> +}
>>>> +
>>>> +static void quirk_amd_nbio_7_11_disable_enhanced_atomic(struct pci_dev *dev)
>>>> +{
>>>> +	quirk_amd_nbio_enhanced_atomic(dev, nbio_7_11_pcie_smn_addrs,
>>>> +				       ARRAY_SIZE(nbio_7_11_pcie_smn_addrs));
>>>> +}
>>>> +
>>>> +/* Phoenix, Hawk Point (NBIO 7.7) */
>>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14E8,
>>>> +			quirk_amd_nbio_7_7_disable_enhanced_atomic);
>>>> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x14E8,
>>>> +			quirk_amd_nbio_7_7_disable_enhanced_atomic);
>>>> +
>>>> +/* Strix, Krackan, Strix Halo (NBIO 7.11) */
>>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1507,
>>>> +			quirk_amd_nbio_7_11_disable_enhanced_atomic);
>>>> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1507,
>>>> +			quirk_amd_nbio_7_11_disable_enhanced_atomic);
>>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1122,
>>>> +			quirk_amd_nbio_7_11_disable_enhanced_atomic);
>>>> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1122,
>>>> +			quirk_amd_nbio_7_11_disable_enhanced_atomic);
>>>> +
>>>>    #endif
>>>>    /*
>>>> -- 
>>>> 2.43.0
>>>>
>>

