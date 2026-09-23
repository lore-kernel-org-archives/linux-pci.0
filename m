Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010013.outbound.protection.outlook.com [40.93.198.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80573DAABA;
	Wed, 23 Sep 2026 17:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184669; cv=fail; b=StHYSZCfvyu975RnY8pGnAR7nQRNSVfaUSMr+e+z2svg92qqYcR2lvQ/KhjNbegKi5o7Sic+SL/5i3SRh9PivkcrPtvfnRCx8PPx3wd8B5CX3VsPEYAwEIzLjFLTwjGQMVdvYSzUzXi7rJkrcCkVOW80j4xWZzix3g2wJSBut9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184669; c=relaxed/simple;
	bh=3JmeIx266dsjKW8eM2wGEDOEtngzXMnTTkbEUfLiizk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FjbKP/VTalswUIY/htJjrmCOJwHbIB/4VHCy4uR2H3kZIxsoEUg+d+4Jjrlix3ziLw97b+xskfk7mEuwaR2f1UU65FWfhM19bR7w0XKmnM12RLIf/OX36er9ZafzNrRYVEK3m2WThk85NuwNseBYYC6v+NPOZEWxUCM5J7o8c50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cOaiJANN; arc=fail smtp.client-ip=40.93.198.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cOaiJANN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVZB2nQXwu+t/gvbO0tV7rL0MEhnOpIXmlCVRmyo3VoPpR0n6EBbBretKT5Y7Ou8ib1Mr2Ulk8G+fWDW75XsfYcnS0aoTvtmI1XWvlglzy/ZxxciT6TfliZ9zhRy3+avHwfcyabDX9icpEkZ74Eji/Zqo7aNPpmkltx/34G9OZH2dZpiB8/vX87RTMyKDmIAG0dD7IHRKUNMfdg9/K9/irwKRrUDhN2v00oLcXp3ZPUzDKN2u2k+3Q0hxPVSUiWdrk77aJ0CIRjfaxzast4dEuLEsW2gBEprIvT/3ls4N/Qwaj2qtAftJaC91toTkpzkX/CM7paUnxMt0wuODdB/3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqdJ7QqKvCcSzocss7xMk+NpaAOA45xMdVoYJoVveao=;
 b=cMbAvVkZJFkDcz5RNLbFtZTTJQi/fXSi6U8GdxleoenIRPCvbmIA7XZq8Ej4QPxwfiOWtQrW5fpVkZOprPcC+8wCgULf/I5G0M+EWvNEy7cbM/ytkQ+Ph+jr9YsdTchtHbC/m6Hmm4LvyX0y9UvXEIDMo+dQaC9vtga9rVAY+609d6f4hTjHuY/h62yKfm22Uuc6LejKyDlPzEHkAUk8yjnbf/ZPXXZjyqmMkfH8nfYAQNl4BNVuqTc046Z9W/+oKN83deo/cxDzFkb0Gy05pjMPKOvlGP/NV5tVbzGqa3j8KOIBEavFWl4NpZn/jFadrqjd5yYKhbMRYbHlEj1GkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqdJ7QqKvCcSzocss7xMk+NpaAOA45xMdVoYJoVveao=;
 b=cOaiJANNmux72JF36xtxo9nzuePy2FnCm+N9i03zhpWr5SWweRpMAEcgsMhVTSCfacmVFG3jYz+T4KhJEVI4733iLRtZR8r6MFl0n9nTtL4fUmHf14W4mvvG+z2la4YsVkBlEcl+LXqjBcHbNuXCtwVcLLV9ww5ymo3nIuS1XTU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8)
 by SN7PR12MB6911.namprd12.prod.outlook.com (2603:10b6:806:261::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 17:31:03 +0000
Received: from MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b]) by MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 17:31:02 +0000
Message-ID: <04147d52-58d3-49c6-9d93-ce9e63beed35@amd.com>
Date: Wed, 23 Sep 2026 12:30:59 -0500
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
References: <20260923171206.GA1866939@bhelgaas>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260923171206.GA1866939@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::20) To MW4PR12MB6921.namprd12.prod.outlook.com
 (2603:10b6:303:208::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6921:EE_|SN7PR12MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: 12aef23a-4586-416a-dbff-08df199870a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|7416014|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	4XGj4A1p0c4oIjw2pUjUaytzvJoLMjKiys5rM7n480Qg0EaltdbrzwpH6+TnQL5BzNtSjveKRp/nQV9oSjkmyTCH5WAeEXdih8gZ5M0lFfRoYtcZFa3lwX9FvCIaov1rHeMrsUy/ptLfRLPfjqWgFXKbPxhxQPOPMDH8iJckDmsm1lyTe0N//vmJzZwFoM1bPPcqs+AO4uEcXRlAlkh4jtfraVPCEg9V2nM6Z/Cu0fsd2FFyyY2vrsBBu0Zn4VAMOpWSXTu+c8UuuHFEZ3KWz0gzBd+6pX41zEcgLXBoqjlOhCls136IUECUWJchoCzZGygyDJfW/j1KnF0sD8Y15Tu1ZgDW2xSx11RkQm9wW1tMuvxTeIAAbNqBJUNiq0w4eQtXAA4MvIahU5PeaC9ZJP3B16eXWc4VIIfcMZNnYgDJK/AIQEvrXnD/V1pzp17Tc6PjpkK8N9O3CYP2PkOlu9xwqxA3ckjgGLeXXdVnwjfw8D0UNzIQuQgHFuFhJ+0QjNS5Ap6hAvaxMLQ6Zpuz1/yHCB/svjOAuRzrVGYHIqZJbGzZuP8He5fNcNCvLC9/ABDiA9APvpavDs4Saeb6oM9mq9fQviv8Td0vCF3I9zjlecfh4gpcA8AT00aYq0lA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6921.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(7416014)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGdLQ0tPU0FxQ09jKzV3TThnRGFQdUc0ZVgzaGJJQTFwREszQ256OE1CRXJL?=
 =?utf-8?B?SHBkUGlRZmYycHNxZjJrcTBtV2F0QjJkb3lMV2VBWWpzUXBBZ0RNdWJPbnVG?=
 =?utf-8?B?QUMvYnV0RnFhNUJ6VEZOUGE2aGw0OVdmeEZBS3JtSDhUOVB0U2IyUjB0VW5G?=
 =?utf-8?B?NXBnaHlNQVJjRWdFS08yc2x4WVl4aWQyTTd4WjArYWN5LzdSTldtenlqaWxP?=
 =?utf-8?B?UWtBci8yT0ovREM3TGcvZjNEcjlTcUVndmV3WTcydFUxNFZiOUJRbnV4azZF?=
 =?utf-8?B?STBxT0syV2lOc3E3dHB5WU9NTS9rRkdmZnVSNEgzYWZXZnFkRHRsYmpwdmRl?=
 =?utf-8?B?M3FzNFNMdkVJTzZhQjhvWWVSY2l6UUZlbCtPK2J3RWlzQmJEUVp2R0NCMGtR?=
 =?utf-8?B?Wi9rejV3VHZod3JiNmhWdVpCbEhVWTVXQmhhc2FiLzZNb254MWlsTmpqZ1B3?=
 =?utf-8?B?TndJL2xlS3g1NGxiNExuSWJ6MFlWc0J4ZEhsUzhqWjY2LzRkTkQzVmUrb3Ix?=
 =?utf-8?B?Y1dxVnFIME1BRmE3SWxKczg1bWJxZHF3WWZOUFhwR0ZZMlRsVEwxcC9WZFhh?=
 =?utf-8?B?d2RPeUJUeFNHUE1BLzhIc2FjejVqbEU0Y28xN0xseWk2d29LMzJTMDN4ZFlK?=
 =?utf-8?B?VmhxbDlPUGZyTjh6NkNMM1MvdkY2SytzT1NVTUtTRFFjb3hFTUtDZzBsaFVx?=
 =?utf-8?B?eDdPS2FoMVYyelJtUDhTREVoc0pXbHkyTmRxcTZVc2pjNXNTaEhYTTJZVUEx?=
 =?utf-8?B?ZEpnN3ZZZHNtaXhWZ01MSWVndlBYZE92Z04zT25ERldTUWhlNjVsQk14YXJK?=
 =?utf-8?B?dDlBc2tGbG44d3V4dFRJYks0c3JVWEZSM3hLUTN5a3BaUEIvK3ArNUZ6ZTRW?=
 =?utf-8?B?ZkRrbTRaTUtpanZyRnQzMEc0bUE3VFpzcUFtZVBTZUF0NlNYUUVJRHdqdUNa?=
 =?utf-8?B?QkZHQ2FidGRPZnBKWWF4THZIM21VRG91bzJGN3N4YWNtUVVPTHRSb0EwYmh6?=
 =?utf-8?B?aGlNK2FtM1VPOXVPTWFrVGlMcEpsSU9ZTVVGQlgrZ2ZmUE9XVlBsV0N3U0hq?=
 =?utf-8?B?RDFiNmhidGY1T1dSM3hFUFJ5Yi9aMUFLeGRhVUJuUHVMdGhHdDMyaWxGczFP?=
 =?utf-8?B?L0tXQ0sveTNKUWtocDdWRlFvYXliLzRQckl5c0dUcW9WMWl6dk5UVzFNSHNm?=
 =?utf-8?B?cEVvb081ellnMCtwSVRSem95NDlqNGZaOGxJaENQSGwrZkwybktma0lPTFlW?=
 =?utf-8?B?VUNFRVBwNE9SaE1KSmM0c3RTMGFQd3JjU2hNQUQ2YVZ1UnJMbjNLNWRsbG9B?=
 =?utf-8?B?OWpMMmlZdFNKa0h2WVhiSThEVFBtQzJwOVpCakNtVjVaSW9JMWxzbDdmQnhV?=
 =?utf-8?B?OWdxSVNyTkhBcEZZbUltRDhGVVdLNDZHS2xQMGM2ckpXd09YN0YrNDBlUXlL?=
 =?utf-8?B?a1BwWVlEcGdLSFluQUt6YXhnbXZNaXdCckdHenJUc3c3ci9sNkdxcVFCWEph?=
 =?utf-8?B?YWRHbzVVQjRVWnlQUUtNK20xS2FmRytaNEoxV2dkN0ozN0RPYXRiem9vMlNB?=
 =?utf-8?B?dU1lSGZCZjMwUjVyMmkxbWxTWXo3OUxxbXYxRHR3RlRNdXBTSTBMYmVCRGgx?=
 =?utf-8?B?eUU2VURLTWNMVGpsRFJERzdBeFN4eXp1RTRSdmp0ZWg5NkhtY3Q0ZnQxVjFO?=
 =?utf-8?B?M2s4UmJ4cmdjRHdBS3hhSFJEUUFlb2lZelN6NC9DOWZlRThGaXRFRnJ1N1RB?=
 =?utf-8?B?UU82NzFGMC9rRDNkcHVkWUJ5b1loM2RYbTViQTFwTGg0M3lFR1I4eFplN1U1?=
 =?utf-8?B?d3VETjBMazRGckpxelhUc1hkbWtyNE9pVE5uMm5BcUlZYkh1RGVWZHp5VVZY?=
 =?utf-8?B?VnpRcVFWSWg0aER5bGg1NzFxQm9ESGtQb2x4RmRqTFNOMmQ3c210YnJqczZj?=
 =?utf-8?B?Sm5sbXd2bkZBSW16WGlUVkQwM0QrZEVyOVVZcm1PclpOdWQ1NGN3QlFKbjRv?=
 =?utf-8?B?QndQaU5pMWZCUmVzdnd0WGNheStJd0F5VXZIYm95RkhMRW1sM2k1bWRqYytk?=
 =?utf-8?B?cjk1ODd4SGRXMXEwWmphZ0pmeHV5NTlScE80WktnbjZmRlVmTXRhWkRtVlQ4?=
 =?utf-8?B?NWQ1TEMvSFdMQURkeXR1M3ZpdlhsLy9UcUgwc1RrSWFSaXNLRXdOMlNTcjNP?=
 =?utf-8?B?YXBTNTdZQWJqNGpCcnhVeWxtQzNXSnE3NURlSnkrL3Vmd1hwOFU5K0FLbk9K?=
 =?utf-8?B?dEUweW11Z1JVeXQ3MDJRaXA2clFMaFBaRzJiQUhPbVR3OGNYU3BESGR2UWxq?=
 =?utf-8?B?NUhSRGU2cVZscHNtQzJYRmQ0K3NORTV1T1J1YnlvR2VkRklIUDB1dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12aef23a-4586-416a-dbff-08df199870a5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6921.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 17:31:02.7119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4lfrUSsxTj7XnrKVjlkygtCw6UUJ5wzRK7lDLtBfvjawaazReTyiEACvoHpEKDzwqLpOqEB2acoA3HbXB8oxOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6911



On 9/23/26 12:12, Bjorn Helgaas wrote:
> On Tue, Sep 08, 2026 at 02:05:59PM -0500, Mario Limonciello wrote:
>> There have been multiple reports of data corruption that can occur
>> with 64-bit DMA when the IOMMU is enabled. This occurs due to some
>> BIOSes enabling enhanced atomic operations on PCIe ports.
>>
>> When enhanced atomic operations are enabled on PCIe ports for some
>> models, data corruption occurs when the 32-bit IOVA space is exhausted.
>> The problem is reported on storage devices, but can affect any device
>> that uses 64 bit DMA.
>>
>> Disable enhanced atomics using SMN for NBIO 7.7 and 7.11 based models.
> 
> Can this issue happen without IOMMU?  Devices can do 64-bit DMA even
> without an IOMMU being enabled.

Yes; it can technically happen without IOMMU enabled as well.

The issue happens in NBIO /before/ IOMMU decodes it.

> 
> When I asked Gemini to explain this, it suggested that "enhanced
> atomics" is an AMD NBIO feature that translates PCIe AtomicOps into
> native Infinity Fabric atomic transactions.  But I guess the issue
> affects any DMA above 4GB, not just AtomicOps, right?

That explanation isn't 100% correct.  Yes; it is an NBIO feature, but 
the issue is related with how some devices interact with the upper bits 
of MWr64 TLPs.

This feature should not be enabled on any ports on these SoCs being quirked.

> 
>> Cc: david.laight.linux@gmail.com
>> Cc: John Smith <imjohnsmith4000@gmail.com>
>> Cc: Lennert Buytenhek <kernel@wantstofly.org>
>> Cc: Niklas Cassel <cassel@kernel.org>
>> Cc: Roland Waltersson <roland.waltersson@netinsight.net>
>> Reported-by: Mikael Etienne <mikael1022bzh@gmail.com>
>> Closes: https://lore.kernel.org/all/178789300872.392066.15963676631650361573@gmail.com/
>> Reported-by: Arthur Husband <artmoty@gmail.com>
>> Closes: https://lore.kernel.org/linux-ide/20260406222335.379935-1-artmoty@gmail.com/
>> Reported-by: Alvin Lim <alvinwylim@gmail.com>
>> Closes: https://lore.kernel.org/linux-ide/20260621100844.1224301-1-alvinwylim@gmail.com/
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v2:
>>   * Apply to suspend/resume as well.
>> ---
>>   arch/x86/pci/fixup.c | 99 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 99 insertions(+)
>>
>> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
>> index b301c6c8df753..79e4338e4b876 100644
>> --- a/arch/x86/pci/fixup.c
>> +++ b/arch/x86/pci/fixup.c
>> @@ -886,6 +886,105 @@ static void quirk_clear_strap_no_soft_reset_dev2_f0(struct pci_dev *dev)
>>   	}
>>   }
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15b8, quirk_clear_strap_no_soft_reset_dev2_f0);
>> +
>> +/*
>> + * Enhanced atomic operations can cause corruption with 64-bit IOVA
>> + * on these devices.
>> + */
>> +#define RX_ENH_ATOMIC_EN		BIT(8)
>> +
>> +static const u32 nbio_7_7_pcie_smn_addrs[] = {
>> +	0x111401d0,
>> +	0x111411d0,
>> +	0x111421d0,
>> +	0x111431d0,
>> +	0x111441d0,
>> +	0x112401d0,
>> +	0x112411d0,
>> +	0x112421d0,
>> +	0x112431d0,
>> +	0x112441d0,
>> +	0x112451d0,
>> +	0x113401d0,
>> +	0x114401d0,
>> +};
>> +
>> +static const u32 nbio_7_11_pcie_smn_addrs[] = {
>> +	0x112401d0,
>> +	0x112411d0,
>> +	0x112421d0,
>> +	0x112431d0,
>> +	0x112441d0,
>> +	0x112451d0,
>> +	0x113401d0,
>> +	0x113411d0,
>> +	0x113421d0,
>> +	0x113431d0,
>> +	0x113441d0,
>> +	0x113451d0,
>> +};
>> +
>> +static void quirk_amd_nbio_enhanced_atomic(struct pci_dev *host_bridge,
>> +					   const u32 *smn_addrs,
>> +					   size_t nr_smn_addrs)
>> +{
>> +	bool changed = false;
>> +	size_t i;
>> +	u32 data;
>> +	int ret;
>> +
>> +	for (i = 0; i < nr_smn_addrs; i++) {
>> +		ret = amd_smn_read(0, smn_addrs[i], &data);
>> +		if (ret)
>> +			continue;
>> +		if (!(data & RX_ENH_ATOMIC_EN))
>> +			continue;
>> +		data = data & ~RX_ENH_ATOMIC_EN;
>> +		ret = amd_smn_write(0, smn_addrs[i], data);
>> +		if (ret)
>> +			continue;
>> +		if (changed)
>> +			continue;
>> +		ret = amd_smn_read(0, smn_addrs[i], &data);
>> +		if (ret)
>> +			continue;
>> +		if (data & RX_ENH_ATOMIC_EN)
>> +			continue;
>> +		changed = true;
>> +	}
>> +
>> +	if (changed)
>> +		pci_info(host_bridge, "enhanced atomics disabled\n");
>> +}
>> +
>> +static void quirk_amd_nbio_7_7_disable_enhanced_atomic(struct pci_dev *dev)
>> +{
>> +	quirk_amd_nbio_enhanced_atomic(dev, nbio_7_7_pcie_smn_addrs,
>> +				       ARRAY_SIZE(nbio_7_7_pcie_smn_addrs));
>> +}
>> +
>> +static void quirk_amd_nbio_7_11_disable_enhanced_atomic(struct pci_dev *dev)
>> +{
>> +	quirk_amd_nbio_enhanced_atomic(dev, nbio_7_11_pcie_smn_addrs,
>> +				       ARRAY_SIZE(nbio_7_11_pcie_smn_addrs));
>> +}
>> +
>> +/* Phoenix, Hawk Point (NBIO 7.7) */
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14E8,
>> +			quirk_amd_nbio_7_7_disable_enhanced_atomic);
>> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x14E8,
>> +			quirk_amd_nbio_7_7_disable_enhanced_atomic);
>> +
>> +/* Strix, Krackan, Strix Halo (NBIO 7.11) */
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1507,
>> +			quirk_amd_nbio_7_11_disable_enhanced_atomic);
>> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1507,
>> +			quirk_amd_nbio_7_11_disable_enhanced_atomic);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1122,
>> +			quirk_amd_nbio_7_11_disable_enhanced_atomic);
>> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1122,
>> +			quirk_amd_nbio_7_11_disable_enhanced_atomic);
>> +
>>   #endif
>>   
>>   /*
>> -- 
>> 2.43.0
>>

