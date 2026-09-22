Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011062.outbound.protection.outlook.com [52.101.57.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323C831E848;
	Tue, 22 Sep 2026 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091359; cv=fail; b=oWjCfSOpK9NIhgrb+JxwtG9ogb+mu2wtHfOr8qiHINBD7WLPvoA+gZ0avMPG2eNrjnLKNItXMsHXJCbL8Jc0v1yCuY2qd8jaUUbFqlJBpz4TAqeuF4JAwaO9JmQopT9J1BWLaYFXG0KYlYzfjd59Ll9f6tTjXlZ7FYql2naHKq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091359; c=relaxed/simple;
	bh=QkO0IMc5T4Y3IDnGivsBLRnlgFhFrJLKJ54P5vOVfk8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nSTEiAcE7MDqbNx+KU/G7nOqrnUHpgiEiidpa8Fii/KIunQuHDaEyb8OELquBVa/mkXwL3vJyFyFKcjyMqeh0FhCGMeSOIedWy9mFZ1E3AyGcqyeaecYngLY69e6GglWr9hlS/Aa6akXi6Z26TVO1Ifb0C2XgMIBcp587mdANEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SuMv7A/f; arc=fail smtp.client-ip=52.101.57.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SuMv7A/f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PsSbSqdeWuTg1VwxmYNTSRV6/yGzR2cCrM4I/8Tml39ZWxDgCbQjtldXDlQDY0NQODp3W4m8Ua7vYnOcCqztPKjk/d+RR5aXLxzruFdFI1qJ+2NHoyQZz6AlWoMxkfVyRT33UKxgaKflNR0t6yMGxSCcRlDsu3bu1kIT4CcUas0J1diVkn/sTC9QI5UGQEVZA2S0uW0ei90qFOpx18mL6yh24PO0DnWPDCOpxEgT/W3ynvApuyc5hX76nTcewPLOzGZF2cM0RTGmBnZXu0+LNWFbJPKNSf6ZsrCiKqiIqVbtTgt4FG5YDQv7anRwjq+AASt4C+6qkj5lUZN6ICxE+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLLl1Yt0DEww7uFjEindFrQ316faU6+daShnIaNtoYY=;
 b=GFdaqr+0CN9m2rwWusH80E5diYFFxOE0mLfoLyyQ7RIoYOGG6I/fUZv5pYHqqGhzSgwBJU259AH5HxfOXIndR5Z8q4UBCngzvwj+5eguZJ98lN6FcWg3pGRSoBetNNnNEpBmsL1kXOhkli3HGlFeHPT81KHYuINsnIDmkKqJOrbHaZYsCKE/OggUh+w4sg+r+MDYgI5O0NajbXGIjm74uKa25nT8eVk2gvaIN159FZVsTuIfcV87YBx6AybJ8ki3dqsoZaWTJbkMKAJi6VMqy+ZfPnEoMV2479ndcuXKXLKZpa9p+APAYsIQhWszzCl21BK6pBEjOQJxZ0U/nQlpAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLLl1Yt0DEww7uFjEindFrQ316faU6+daShnIaNtoYY=;
 b=SuMv7A/fwSmdvPHN2BVwpNqoM9B+YceEUV5dv3jxXM7/Pf1eqcoQq8vAE7n0o8rFfel59IimLUtO5EbKbOREzv8aGEqyY63BmfBz646nwLICLdpyUwaSYjYwdTySl1odysCr349DHyIDOBrq2CexjvmYeZio4iF7hrA2GIpPTBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DM4PR12MB9733.namprd12.prod.outlook.com (2603:10b6:8:225::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 15:35:53 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 15:35:53 +0000
Message-ID: <4e2ac992-bbaf-4412-ab71-182b0b1abc79@amd.com>
Date: Tue, 22 Sep 2026 10:35:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/PCI: Disable enhanced atomics on some AMD PCIe
 ports
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
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
 <artmoty@gmail.com>, Alvin Lim <alvinwylim@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
References: <20260908190600.226485-1-mario.limonciello@amd.com>
 <20260908190600.226485-2-mario.limonciello@amd.com>
 <ed334568-d741-4374-b953-29a97a82963c@amd.com>
In-Reply-To: <ed334568-d741-4374-b953-29a97a82963c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR19CA0008.namprd19.prod.outlook.com
 (2603:10b6:610:4d::18) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DM4PR12MB9733:EE_
X-MS-Office365-Filtering-Correlation-Id: 51eaa79f-c5f5-413b-814c-08df18bf2ff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	n1b2kvrWtQkMBIf83I6EYizcN8RweQ1TVQrb+foVdmQ1YsDsHDMetoU10W5IzCrWEI0QksGJoL9tw4k8vn0ZcIt6yAbCvr5AKIGJLEZcjCQcDlAWovRUZSj2z5+ckvnVCM5yV8HcEHSLY1s/7RQBQRTCb4vDGBYdkafmGw2eWC7ad7AB1f7Skv4bzOvftc3uGkSxZJFHi23HsY3uxQZxeMvCZIV7C+eFoNWbgNR/z/kwa1DW1A4o9hA8g16a8Qzf9TAGfjYyjvONc8fxfjxzz9muEePO39EQsNU3sNyNfTzywYZ54Kg75s1xsJ9QcizINM75ciR5B8FgKBphpARBjJc5rOoyAxv8NHcfRBUT0Fm9lWdnqMHsJ+BgrjrzhBuXZpjEKxIk02P8aCqUuG3fysVPPRvRZ/lgvkG+t8kaYinvq8kB60mjM8V+JVI8nR+INt/QIAhbVryNNZ1ZMlbqwUySe9EZBYiXPz2XkFc8dctqwe/r5kcwM1CWFFAnHGYn39lJMP/ICelX0xqb9ar4B/m8IeuByHoBU4sOZDml7796uwJsFLG2JJWqfZs0VHs5xJcdBPaUBvaTRNbyrpEKwF7mqg2dm6f+wNAbaLyvhZk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OG1FQlQwUkZEbytoWC9xRnZRY20veFVTRWRJOWJnMDc3VXBURTgwQXAvbzVS?=
 =?utf-8?B?MzlVeDJ2VFkrUVpHVGJEQVZUU1o5WmxFaEFmQyt4V0tCMks5NjZiU1VuY3Vr?=
 =?utf-8?B?Nm85SXVJazJNbXZ2VzIwLzRHSVorQk51TldnckdLN1lmMm9OR0d1ek94SE0z?=
 =?utf-8?B?NlM3UkY1K3NFSG5wa09OVWFzUklsL3hKcWk1WUhUaytsbi9SeUlVZGo2eFFp?=
 =?utf-8?B?QWs3cU1JbkowTzYzQTZnRGZKa0F1RW1EMlEzVWxsbnlnTE0ySXlJWkIxcHZy?=
 =?utf-8?B?YWR0ampEN1ZrSDBTSlFLazZtR3dkNE9mUHp0VEx3dkxoWTA3Wlk0dTE3dFN6?=
 =?utf-8?B?QjBDbGVvSW9mODl2RXhYeUh6S3dIUDN4SDNxODFNSzZWUlliQTY4R1ZjLzAx?=
 =?utf-8?B?UG13QTg1dWh1dGhOT3NSd2xRdHZsTGxQUnhaTS84ZWxKN1pOUE1GeW1RRVA3?=
 =?utf-8?B?cnB4bm1jTmU0dWJYVHV0c1pMWmFhaHhSeU04OVVhRk5pZENOMGM0VmhheXI1?=
 =?utf-8?B?bW8vZVpHdnUzTmQ0K1ZPR1JCSFF4bXNxRzVnc0tVekFzeEpPS2hVZTRpdXZ2?=
 =?utf-8?B?eEVFWUFUc3d2dVd3SzB4YzdaZ3k3dXFDK2hWUzlhNlR1NDJXTzZ4UStNTlNQ?=
 =?utf-8?B?LzNiQjZDQm5CaTRaQzlmbmxRNk01dGpOV0Mwd1VyWndtSUJmSmw2WjVNSGpT?=
 =?utf-8?B?eEJ6aUYwRE02eEY1VWxNSkhiZEZNZkw3QjgyTGVjNVJVM0wydCtDQzJiOGZr?=
 =?utf-8?B?SFR3YTdzUkJrejl3czJRSkkya0gwalNnN0hiM09OYTRiaVQ2eVRWM09uZVFY?=
 =?utf-8?B?RGhDK3hrcXBXVEQwc2dhOUp0aHdzRXhFOFhwLytESTV6dnZqeEIyMHV5di90?=
 =?utf-8?B?M0NmNitPWFBXSkpWYzVncFVzbFRvVjk5Q25nNXdsM0c4WHNpVFZiMkhscUNr?=
 =?utf-8?B?bEJzL0dpeUFKR2lwa3J1TmNyNlVsS2VYSzdZV0F0V3Nna1NVTjltZ00vSm8x?=
 =?utf-8?B?SmJrWW5FQm0zZFJmcWdydmVlYkpuT0tibnBwRDRwL3pQdzhtRllKV1l6K3hu?=
 =?utf-8?B?c1RoMnN3N0xJdTNabWRyZDdHSDZhZEloS1RIQXF0bEZCZ3JwdFFmbjVBeUVo?=
 =?utf-8?B?Um00SEhNNDBIY2xnbkZaaUczSDhtN0huRWJrQ2pESjFIaW8xRy9wWk41UHBx?=
 =?utf-8?B?c1dJcWJHaVRnOGxUTjVnNUZ4c0dHcWlzaEI4YmlYNklSYVJiQkVZVUIyVWtj?=
 =?utf-8?B?MzlNR2JoTjRCbUtoRURVMWJ3ZXNKd1V5SkFWekw5b2ZYUGJrYXQxY2hlR3FF?=
 =?utf-8?B?THR4eFlmYksxejVPYjV6YXFLQTRLdUZXcTVxV0hnMWhsZEgyWjJKTG1LZ3di?=
 =?utf-8?B?elNsclIvcGJQcGJ1K2c2VGdpRXdKTDI3RERIRFB1K2FjRVI5a0RpM0UzTGxG?=
 =?utf-8?B?SklqWGc1VUcrQkNiQm9URWJqTTZLaHg4NWFXTVBtZEJUdVc0cFN2aGR1RWx5?=
 =?utf-8?B?b29pOVh2eVdtTUlYRVp3Qkd5WndwOGE2SytuaUdrMVA1VDNrbnFFeUN2cDc5?=
 =?utf-8?B?Tm9uZ2JrbnVJOEViaFBGcUFyVy94WHJtVjdVUWlremJQbHBVLzI2OWlzWVpz?=
 =?utf-8?B?MXptWnFIZWh1Z0dnakcrcDFtcWJZKytMSlhZT3h2NFN2L0E5M1pNYzEzejlD?=
 =?utf-8?B?K0ErTENSYkEwMGR4RVRKOVl3U3hNOXJ5RUcwMjRLMzU2cHRJUzVDRkJGV2Q2?=
 =?utf-8?B?c0xMTUtKbVc5WGpyQ0tIdFZpVnJGRmVFcG9SbHNLQ0ZoZUc3QU52Mk01WWNB?=
 =?utf-8?B?dTIydGJ3Z1BFdDhSakhlRXVranFoeDJRWStFQ3RsZWttK1dXNUNpRVMxcjVO?=
 =?utf-8?B?OFZYdXM4aHJVc0Z1NE9zY2syT3NJRFh4emFlYzBSNG56dUtJNENvOHlGQlh4?=
 =?utf-8?B?c083OGN5a29PaU9tL1pYNXlBcTZvQlN0YUdzVlpidi9hTnJqUDdEL05JSTVO?=
 =?utf-8?B?eklKTkhGb1I4aFNJV0g0R0VVMHNsTDdCQUdLMFBYZEFzTWxCSTV1am1hV3dn?=
 =?utf-8?B?Q3pRdk1SeGlGT056OSs4NTdEc3hrdjFMeXRWRlQ0MkxkNUdLVUVORmJxOG5h?=
 =?utf-8?B?ZmdIaXFGWUlsUDY1NmxsWE9mNDl6VkRwK2VML2pSZm9rdHRRTXhqaGdVY3RK?=
 =?utf-8?B?Q2RDWmlJV3dVUE5xZnppNmI2NXczb3NtbVR3MXFiV2pHbXJhWG03L2wyZXpY?=
 =?utf-8?B?cVVJSEpkbnlWYlRObUVpNVhtMzBNNWxqa1pMd28wVWo2M2NHelIwakFVcmc0?=
 =?utf-8?B?TnUrN2l0blFTc3ArTFQxc3h3WlF2UU1DSVdEczVXUWhBYnYrdXFNZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51eaa79f-c5f5-413b-814c-08df18bf2ff4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 15:35:53.4870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMc3ylXtBvgEBPpAJSMNi6X0WtC5rQxsRkAjz+4xtOYQN4iXMIcoiS/MoOx6JlFiTen5p7SspKjkZWp7JPkfzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9733



On 9/14/26 11:57, Mario Limonciello wrote:
> 
> 
> On 9/8/26 14:05, Mario Limonciello wrote:
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
>>
>> Cc: david.laight.linux@gmail.com
>> Cc: John Smith <imjohnsmith4000@gmail.com>
>> Cc: Lennert Buytenhek <kernel@wantstofly.org>
>> Cc: Niklas Cassel <cassel@kernel.org>
>> Cc: Roland Waltersson <roland.waltersson@netinsight.net>
>> Reported-by: Mikael Etienne <mikael1022bzh@gmail.com>
>> Closes: https://lore.kernel.org/ 
>> all/178789300872.392066.15963676631650361573@gmail.com/
>> Reported-by: Arthur Husband <artmoty@gmail.com>
>> Closes: https://lore.kernel.org/linux-ide/20260406222335.379935-1- 
>> artmoty@gmail.com/
>> Reported-by: Alvin Lim <alvinwylim@gmail.com>
>> Closes: https://lore.kernel.org/linux-ide/20260621100844.1224301-1- 
>> alvinwylim@gmail.com/
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
> 
> There was a contingent of eager responders on the original issue added 
> to CC.
> 
> Those of you on CC - any progress with testing this?  Does it help you?
> 
> Internal AMD team did come up with a reproducer workload that we have 
> confirmed it helps.
> 
>> v2:
>>   * Apply to suspend/resume as well.
>> ---
>>   arch/x86/pci/fixup.c | 99 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 99 insertions(+)
>>
>> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
>> index b301c6c8df753..79e4338e4b876 100644
>> --- a/arch/x86/pci/fixup.c
>> +++ b/arch/x86/pci/fixup.c
>> @@ -886,6 +886,105 @@ static void 
>> quirk_clear_strap_no_soft_reset_dev2_f0(struct pci_dev *dev)
>>       }
>>   }
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15b8, 
>> quirk_clear_strap_no_soft_reset_dev2_f0);
>> +
>> +/*
>> + * Enhanced atomic operations can cause corruption with 64-bit IOVA
>> + * on these devices.
>> + */
>> +#define RX_ENH_ATOMIC_EN        BIT(8)
>> +
>> +static const u32 nbio_7_7_pcie_smn_addrs[] = {
>> +    0x111401d0,
>> +    0x111411d0,
>> +    0x111421d0,
>> +    0x111431d0,
>> +    0x111441d0,
>> +    0x112401d0,
>> +    0x112411d0,
>> +    0x112421d0,
>> +    0x112431d0,
>> +    0x112441d0,
>> +    0x112451d0,
>> +    0x113401d0,
>> +    0x114401d0,
>> +};
>> +
>> +static const u32 nbio_7_11_pcie_smn_addrs[] = {
>> +    0x112401d0,
>> +    0x112411d0,
>> +    0x112421d0,
>> +    0x112431d0,
>> +    0x112441d0,
>> +    0x112451d0,
>> +    0x113401d0,
>> +    0x113411d0,
>> +    0x113421d0,
>> +    0x113431d0,
>> +    0x113441d0,
>> +    0x113451d0,
>> +};
>> +
>> +static void quirk_amd_nbio_enhanced_atomic(struct pci_dev *host_bridge,
>> +                       const u32 *smn_addrs,
>> +                       size_t nr_smn_addrs)
>> +{
>> +    bool changed = false;
>> +    size_t i;
>> +    u32 data;
>> +    int ret;
>> +
>> +    for (i = 0; i < nr_smn_addrs; i++) {
>> +        ret = amd_smn_read(0, smn_addrs[i], &data);
>> +        if (ret)
>> +            continue;
>> +        if (!(data & RX_ENH_ATOMIC_EN))
>> +            continue;
>> +        data = data & ~RX_ENH_ATOMIC_EN;
>> +        ret = amd_smn_write(0, smn_addrs[i], data);
>> +        if (ret)
>> +            continue;
>> +        if (changed)
>> +            continue;
>> +        ret = amd_smn_read(0, smn_addrs[i], &data);
>> +        if (ret)
>> +            continue;
>> +        if (data & RX_ENH_ATOMIC_EN)
>> +            continue;
>> +        changed = true;
>> +    }
>> +
>> +    if (changed)
>> +        pci_info(host_bridge, "enhanced atomics disabled\n");
>> +}
>> +
>> +static void quirk_amd_nbio_7_7_disable_enhanced_atomic(struct pci_dev 
>> *dev)
>> +{
>> +    quirk_amd_nbio_enhanced_atomic(dev, nbio_7_7_pcie_smn_addrs,
>> +                       ARRAY_SIZE(nbio_7_7_pcie_smn_addrs));
>> +}
>> +
>> +static void quirk_amd_nbio_7_11_disable_enhanced_atomic(struct 
>> pci_dev *dev)
>> +{
>> +    quirk_amd_nbio_enhanced_atomic(dev, nbio_7_11_pcie_smn_addrs,
>> +                       ARRAY_SIZE(nbio_7_11_pcie_smn_addrs));
>> +}
>> +
>> +/* Phoenix, Hawk Point (NBIO 7.7) */
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14E8,
>> +            quirk_amd_nbio_7_7_disable_enhanced_atomic);
>> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x14E8,
>> +            quirk_amd_nbio_7_7_disable_enhanced_atomic);
>> +
>> +/* Strix, Krackan, Strix Halo (NBIO 7.11) */
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1507,
>> +            quirk_amd_nbio_7_11_disable_enhanced_atomic);
>> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1507,
>> +            quirk_amd_nbio_7_11_disable_enhanced_atomic);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1122,
>> +            quirk_amd_nbio_7_11_disable_enhanced_atomic);
>> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1122,
>> +            quirk_amd_nbio_7_11_disable_enhanced_atomic);
>> +
>>   #endif
>>   /*
> 

Bjorn,

Ping on this patch.  There are active reports of data loss from this 
BIOS bug, so I would like to get the W/A merged soon if we can.

We have an A-b from Niklas on 2/2.

Thanks,

