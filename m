Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A172848B374;
	Wed,  6 May 2026 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778080262; cv=fail; b=DqjVefOogU7lBNlZEMnaCfPBvJde/KnfAoH+7kCaIGP69WAFCNFC0ZIwKgSoXniP3T9Cq/abdJg+iwGtVvgQ1Uy6rcMFyWUVUXK7nA1DpP0TN0IvcwQAqsUbILNFDSbvaU7l15cXLm7hCcPlBKWXnRWGIn/oxumOQyqcBA5mkB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778080262; c=relaxed/simple;
	bh=If4Au5WH9srLn+dr0TRMOEC8gKh5Kjw2a1JKM53FA2s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=igrhWJW6iawfzikLizj6bFLgXXONCkZs7Z7cSG9fMqTEEI4uPrzVe9jtO0uAabHhQEkFr5XaWTQz/D6yYVMaACKSX2VXWz8sazODupVJcN/ZplXyoXrmYcCzxAVM3K+12oX4wBtcSurYfbLkiiaXoT7/N5Nz6DRkTdyAcu6uKLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XJj3dViS; arc=fail smtp.client-ip=52.101.62.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XJj3dViS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AahUNVKsZoElDl7cm0PvhkteBZD6ndB2R5fAko8qPgjjPEEOFmDk0lBexRuiBGwgnwQwPYNjt9EtjVokXk/EmUTk5JFgYeERiv6T13ip3jFmilyvYam2WNelkDZGM7jvRboaeplyx/j094F00KKQmlOF6RlMARI8d8iAGEZ0hlJcH5E1Xc8Ggl5A8RdQPSo8iJqBhHvVMziNZizv6oOYhtqaJhI/U0VB8cUq7f4tatwd0l1SFedKunBpKsuSGLxs7Xve4CUhZO+1GrTw1Md2xA0bLjzMq6p5zDGV9pIuzZfzT/BquQEirBBrJr+1ScYujk1hh7U/cQkVe3/DKbGXPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zw4xULxDHWSbvPNfNBFW9GkOrMmrbVe4FWoK1wJK3bU=;
 b=MASGQ1fcUT8TsJHM+yuk0eAko0TY/6ILox/vWDWiQXaE5L7uXcxHUy4KNMVMh6P8fi6ucRkhbQN+tEZ5WiGM2GLSH3/XYmGEOm2WG2BG3lRLKaQe4LMC8+nSxsu3EauC2U7j6dMr6x08691cI4D5jWEJBTVRYO+78Joy22sbLAGUNfq86p9VEF1JplenbfjH+p2j+9yTqv7FNFsi2d6qb2IZ17mTCLnKgx5lcIcJEzbbzdZknNl1lXThDAMdNPVRgdUK+UTSXNmpd2ygo2wtGg5kedmryYwYLI3BgK3/krjd9dPxD1DUbSuC00rgMVbVr9r0PVz1AUzVWPvRQEjY3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zw4xULxDHWSbvPNfNBFW9GkOrMmrbVe4FWoK1wJK3bU=;
 b=XJj3dViSX/2Dp2DQ79ZgzdMUPj6fEYvZqoWQKkEFmgM7vRpIHZ1jPU0gKGdHo6C2oSYMjT/xtgCCWxfT0DH0MizBCSDoD2jDDEDtYE501rduWy4rsA3nCyKMbO5DxIGElnN4xeiSX49Pic4r8rzIEzG7GkHRT4DjI+1RD9/2B8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 15:10:49 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 15:10:49 +0000
Message-ID: <a6ffd678-65ee-43a0-a9f2-99d45126f5b0@amd.com>
Date: Wed, 6 May 2026 10:10:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/ASPM: Enable L0s/L1 for removable devices when BIOS
 didn't configure ASPM
Content-Language: en-US
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>,
 linux-pm@vger.kernel.org
References: <20260504225246.480921-1-mario.limonciello@amd.com>
 <CAJZ5v0h2NKNU2NTkXbH0FrBsYQJXVbNVxKCMtUUkNcSkFuMQLg@mail.gmail.com>
 <20260506045356.GH6785@black.igk.intel.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260506045356.GH6785@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0161.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::16) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|SJ2PR12MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: e9abac8b-3f68-4038-2400-08deab81a791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DJePB2Dcd+Sz5NXaNSn4ScrX3DGkfI/V6YCzE5cbTL6uxlNbSUbe+25pjE+AXiAsnXBocsjCKbxglYZQ9N7YsQmI0YxFW8+dBnJGJvF0e8bAQ9tENUtuyXvqzhDKNCewtEkmdBpPyfJxkxCZNfFRbP6OPkIz0F4rkMN41blgSD5M51LBmMyBjvjIQX3FybiHga+ln2UaqFuUl4dGpx+6FuWyRpzd6Y5rt4BuuuGdq8b2jt+WitTT5YC79qr5UN8m0zVCH299MagTwhEsLW0ekPF0jL2oaBXb88mJVU1joClQcXdu5XXL4r3agYhEIndPdbrzWcxaYTfogJ5Ta6tkGB163v9rvzrUBQJY3eW+RH/LX6J4ZjdHyJcILo0MpNH8wZI6DypBb9tH5zKus1FeHmZh8+zLFClPGoauVkpVef1lbgutuvhT1n2gIxZo8+XliazGTZAN4A63T3+xnrdPQLL3BjqbcLbmL/28/3q6yw6Dalt6tn4yuMsle7LLys0reT9LTa/kLiEV/BcAo64O3BnI+RGe+rk05uycUFB7imGLh5WdOBfS/MnTUlHapo3qpmVz6UOr7fR54n3LW8O7hAmhCCusSQV4v1XvVMnMSebo3onC/b/WxE7b7huE6AqevWX1bZmcH1XumQjiPlI25OSGm5pbOPXzWNaKt9YEqXFSAr2gV0ct9NMlcJMdGmIG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWxlalhSUmRyekJFWU5CbFJQNVd0Mk9vRUhQSVFSbEc3ejNlSGRVTTBiSXBJ?=
 =?utf-8?B?WFNvcXl5MWpNamkrSzczME5aeWZtNTlnK2xGN0FuTFR4bjVRWnNyem5Dc05D?=
 =?utf-8?B?VmlOQzY0NFFzVFBNSWVSd3RFWTlpM3JPWVdPb3FaM2NTTlhjTUJYd2tOZ0hF?=
 =?utf-8?B?TktuWHREbmRIaHZhR3F2dURJUjJYcTc3SDJDbkFMOUdONGF4dmZqWWlVR0c0?=
 =?utf-8?B?OERISFlSeEUxU3V3Z2RZOWdTOGo3YWlaL01RN0IxNUh3eHNnQ1Rsb3pEb3o0?=
 =?utf-8?B?c0MvaWdLUmV0SjFDZE5iaEI3NlRSMnU5RS9LSDAwSFU4bVhyb2tMSEJVL3RX?=
 =?utf-8?B?OGY4WmxNcEZyRzdjak14Y2pLeTk1OUoreUdvZngxVHF5Y1FFaUw5NlljTmdv?=
 =?utf-8?B?YU5VbnMzdEcvL1hDdEI3Vk8rSFV0b01PZGhlVDBscFQ0K2pCaEU5ZnQ4VzNP?=
 =?utf-8?B?YXlFelZaUnRUNHJ1QU1EclYzL2x5LzdhNTNrbzdvQ1JhVG5ndDdPdVhYeFlh?=
 =?utf-8?B?TXlwZWZLRUZBbG14ZnlnMmdJUWxhYzJvZXNUZEh2VHhZdWdkRGhFQUpMd3B6?=
 =?utf-8?B?NENkT1FhUTRpU0lCVERVU3h4QkZheGhZdzVBaU01WmhyNGkvQStNeU1FWHFZ?=
 =?utf-8?B?SWtmM3JwcFNud1ZvQTZUV0xscmRwenAwdHlwTFZZbGlCb0dyVFZYYzZsR3oy?=
 =?utf-8?B?ZXRWMUN1bWNNSGRWWDBJaVhOYTNKTWdNbU1LaEVTZDNCL3o2eWtBeFRnOHNQ?=
 =?utf-8?B?WTJFY1JrVHVKbHpsSmhJd2ZsbmVHY292MUg3SW9NUzFHb3Nwa2RkRWdVdWJZ?=
 =?utf-8?B?WTdrajNZR3pkeUJjbzZTNjZVSzRIbzZOd1o2QmpaZGpQUldHbUV1aitJMGlk?=
 =?utf-8?B?ZThvUVp4RlRwdTVHbEN6cko3STJTaDVmTWQycXdMY1NVWU5Od1ZWRGFTV0pD?=
 =?utf-8?B?ZGozdjdNRTBjOUpOOUxSQjRRNStjRW9LNWhRU3dXdkw2VEtFSktWZUlhbWx5?=
 =?utf-8?B?U3NLaFhTeUkxREdvWDBKU3ZjUjUvTlBTdDhZRldDQTZ5a2dNSlZ6eGY5U2Z4?=
 =?utf-8?B?cXU4czVDQkh5L2lUTHErQnlybi9VaVl6ZmgrcGZiRk9vK1RIR2wyNUFHRHRI?=
 =?utf-8?B?WG1KSTUrNy9aeHN2cWpiZEhnOXVDT0wrWCtXenRKdC9SeU50N0Fod1dhT3BG?=
 =?utf-8?B?Mzc1RXp5NWxabXgxYVdWSFFZZEV2eUx3SGZWYlBzS21hK2xtQmwrTVNHV1hN?=
 =?utf-8?B?QWRvYlA3TU9wdndYVVlLR2Rwaks4M2Vsd3cvcGVFMVBTYjhuVm9UejdVQlcv?=
 =?utf-8?B?eEhIbEg3MWs4UXNvRTRtbG55aHFZSS84NDdBRlkrRHJoSy9DcnVCQ1VCMit0?=
 =?utf-8?B?L0tTY3FsbzNKVnRKWEtRc3RVMDZwMnpwVE91Y0QvdGx6cWk3THFzUWJ2ZEZP?=
 =?utf-8?B?WitGbFFqNlcrWnVhbUtna21TbFY1T3h1VjQvcTVUajYzR09DZkVpYW1uTUg1?=
 =?utf-8?B?U0N0Z2g3bndTSlo2cFlaNmlOMnNORFpXeHRza0Y2ME5ZdUFrZGVaaXF3bzRJ?=
 =?utf-8?B?bHNJZzEyc2JkNFVsNlA1TWYvNWY2SUIvQWJmWUpkZnIyV29RNG1lbEo3UkE2?=
 =?utf-8?B?TjhjN3NTeG9wV3RBbG5yS2ErYyt2QXFDcHR3T1cvVVlyUjFwY0Jzb0lBNHFF?=
 =?utf-8?B?SEZrWWpsVlFkb1ZoT3VSQmxCMVJNVzVvZDZDbWNUMWRUMVF0TmN3RDhhaVV0?=
 =?utf-8?B?YTFEcjg3T0JmbVpPMDRjN2RuRkhoTXNmTkpUeCtXVytuczFYQTB4MzU4cUZF?=
 =?utf-8?B?Njl6a1VTQ3ByYmVQTlZWR2JtSm5GM2Y1bzJDdnJWTHliTnkvYmg5djFPNWE4?=
 =?utf-8?B?MjN1Tksvdk1oek5qTnZYU3VnMlBoemZHQXAwWTd2Q3ZZcXRGdmRFWDBDK3R1?=
 =?utf-8?B?NkF2SEdDbEtudlhoYi9KQlhZWDBaa1JCeW5zQTgydFVqV0w5clZ0dEQySXR5?=
 =?utf-8?B?NHFKSmVVdTYvT1pKcVZRcVkzNnRuTWhtc1E2MytVVXhzRVQxL0hCOVZaOTZr?=
 =?utf-8?B?NExPck5vWXJ4MzdnZXlQaEtxeFBYQnBuN1A1elVxc2djeHZiWGxoblhPRGU2?=
 =?utf-8?B?M0VDWGFoMWlxN29YSFB1ZDVGMXQycEtRSTQxTWVmbVZRV2duWFhpNkxDc254?=
 =?utf-8?B?WW9QN3REM1VTcTVBS2R4YVNDOXZFeDRkRXN2NEhldUVPdDltM3FjUHNXejAr?=
 =?utf-8?B?azhRNURkWS9sN3hQcDlqOEJDcmVIYjU4TTU1RWRWWXJCazNjZ3o3NkJYU1M3?=
 =?utf-8?B?UEMvVlpBbCtRdmxzL3lRRmZiYkFrRGpzdXdtNTk2cVBTNDcyeG5PQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9abac8b-3f68-4038-2400-08deab81a791
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 15:10:48.8870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KFuqSOYF9GhzFzySHeVBj3bMuvz3K+k2rqW4vt8YgjGvQHocSktTsuz/IaqWC/8F0ZrMuD5ctUy+2ou3nyWgVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8943



On 5/5/26 23:53, Mika Westerberg wrote:
> Hi,
> 
> On Tue, May 05, 2026 at 08:09:22PM +0200, Rafael J. Wysocki wrote:
>> +Mika Westerberg
>>
>> On Tue, May 5, 2026 at 12:53 AM Mario Limonciello
>> <mario.limonciello@amd.com> wrote:
>>>
>>> When comparing lspci output between Windows and Linux for hotplugged
>>> Thunderbolt 5 eGPU devices, Windows enables ASPM L1 but Linux doesn't:
>>>
>>>    Windows: LnkCtl: ASPM L1 Enabled
>>>    Linux:   LnkCtl: ASPM Disabled
>>>
>>> This difference in ASPM configuration can cause behavioral differences
>>> between the two operating systems for the same hardware.
>>>
>>> The root cause is that Linux's default ASPM policy (POLICY_DEFAULT) relies
>>> on firmware/BIOS configuration. For hotplugged devices like Thunderbolt/USB4
>>> eGPUs, the BIOS may not have configured ASPM since the device wasn't present
>>> at boot time. As a result, link->aspm_enabled is 0, link->aspm_default is
>>> set to 0, and Linux never enables ASPM for these devices.
>>>
>>> Devicetree platforms already have special handling to enable L0s/L1 by
>>> default regardless of firmware configuration. Extend this same logic to
>>> removable devices when firmware hasn't configured any ASPM states.
>>>
>>> This makes Linux behavior more consistent with Windows for hotplugged
>>> Thunderbolt/USB4 devices.
>>>
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221319
>>> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>   drivers/pci/pcie/aspm.c | 11 +++++++++--
>>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>>> index 925373b98dff0..77497d90be0b7 100644
>>> --- a/drivers/pci/pcie/aspm.c
>>> +++ b/drivers/pci/pcie/aspm.c
>>> @@ -804,8 +804,15 @@ static void pcie_aspm_override_default_link_state(struct pcie_link_state *link)
>>>          struct pci_dev *pdev = link->downstream;
>>>          u32 override;
>>>
>>> -       /* For devicetree platforms, enable L0s and L1 by default */
>>> -       if (of_have_populated_dt()) {
>>> +       /*
>>> +        * For devicetree platforms, enable L0s and L1 by default.
>>> +        *
>>> +        * For removable devices (e.g., Thunderbolt/USB4), enable L0s and L1
>>> +        * by default if BIOS didn't configure any ASPM states. This handles
>>> +        * hotplugged devices where firmware may not have configured ASPM.
>>> +        */
> 
> Only L1 is supported over TB/USB4 tunnel (no L0s, no L1 substates). The
> PCIe endpoint and the downstream port it connects to of course can support
> the full range as that's a real PCIe link.
> 

OK - the comment should be updated but I do expect that below code 
(link->aspm_support) should remain OK.

>>> +       if (of_have_populated_dt() ||
>>> +           (dev_is_removable(&pdev->dev) && !link->aspm_enabled)) {
>>>                  if (link->aspm_support & PCIE_LINK_STATE_L0S)
>>>                          link->aspm_default |= PCIE_LINK_STATE_L0S;
>>>                  if (link->aspm_support & PCIE_LINK_STATE_L1)
>>> --
>>> 2.43.0
>>>

