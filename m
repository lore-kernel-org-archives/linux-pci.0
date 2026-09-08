Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012066.outbound.protection.outlook.com [40.93.195.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D92859651D;
	Tue,  8 Sep 2026 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895195; cv=fail; b=SPA2FQ8osb2vKYD+zd3gm4Tu2HtsxMpIyr3/b6mYV4AkF4Vo8CQXskogAPsUNwLC9CjCW4aQvFw0qQ1KfDWgRjefenjeCcJ9lEY3Ix9mu5DYhu++e/BVC2rckRWgSeKB3kr4IrNDn8z/2b54CGZq8mcqM9jHaXGrwRROp2OapcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895195; c=relaxed/simple;
	bh=pD0Gx9aEgVcJv7e3UsHyR5t6iwKSan7gkt+gXHb1uAg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oFCy8diBzuzE09Vzb7SlYtZvTFIyUWhksQeLXz6/hlWTssO8o7aWzuuNk0j/YxU2V/yYiJQ6/HxppLkG9XzuFBAzpx7YsRjARmyVbpdsL+WYW4bZ52+zkCYWj59DcmbW3bo3FduXlNnnAiEmgJvwhexh5iDIpOI+JOIrJdULT64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A6vH2p45; arc=fail smtp.client-ip=40.93.195.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A6vH2p45"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Clj2Do0Vnq0EPrDvCR2M6xMfW1Po5K7MpuUlESfb/2DmOHzm/3Z3As2NNvTR92YyWd7sbxGGwGOzAm3kLf9j2j3k4CbfGoXesBYfSr1GMZV60z+PXbeUo1nny7p5WZwsFNz1jfcsZk383OR/eiUW5BatceAnx+SI/q2HRnvxcWez+n5UrTJE8RgA9wgM8/GHPvTctLPu+JR1Yk44NkbjM4jTKfZTo20CCWwM3j5thV6fqY/AVpyOjx7Vq7knclMLJcbWmL0bT6R0KngxQwmj481Ys94/u8DONoZq5yq4wftndYz/AczGX79l5v3Jh8IAP06v8f6Lk5qEWa3GguzG4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNrWJCMRb+ur+L+9SNwV4EAXaps3RCt7caCTVHRXGsQ=;
 b=T6bYOG0iFW16N1ixOqDQ+CW2Sj8OjVNRmgTq0SR5krdJ9nJdfhWJ1wGKXJ5g6K0Jp7x0RPWA3zq43Nn/SZYE62H2zWTVIGI5OUbXcX3hT8YoAV+KHmnDg6mVq9kiaSRLKvHKcf86boQ9HLouzailml4ejdaOp1j7Pr237soYDqmNcop3ofjSLfq4iJvjnL7/QDoj33BuIsWmafGDh4nF/6ZM8CR8gBxdfiFTVvH1mrst3aAprx5wsRKl1LAHISRXnSWan/5Myt3xyu4rd+eTkawxTNqz1EMGIA+fBQEHnco47E91I18VC9syydkohdgv00psQy1wPgO+1rQC5De53Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNrWJCMRb+ur+L+9SNwV4EAXaps3RCt7caCTVHRXGsQ=;
 b=A6vH2p45dOADIImV18CNIJiDzaVHvAZs/4KyyfacCxGoCqF9OvY4tYkVw48P2pSj/LQsa/sRwpp1dTVD3vf54j9c9IQR3+o+9qr+INS4HQKu/LG0RdfmjVUrzvnMuNAIxAjhHpOdYDX3Ko9VxiXpOzt04D5vCSl2N8tEpVvL8rE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CY1PR12MB9559.namprd12.prod.outlook.com (2603:10b6:930:fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 19:19:49 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 19:19:49 +0000
Message-ID: <269d2580-634e-480a-862e-5772d9aa36ff@amd.com>
Date: Tue, 8 Sep 2026 14:19:45 -0500
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 1/2] x86/PCI: Disable enhanced atomics on some AMD PCIe
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
References: <20260908191804.GA2734734@bhelgaas>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260908191804.GA2734734@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: QR0P297CA0018.MEXP297.PROD.OUTLOOK.COM
 (2603:10b6:3d0:16::15) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CY1PR12MB9559:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c7e2c50-e897-4b66-78ee-08df0dde2696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|18002099003|22082099003|56012099006|5023799004|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	3uzVcUpD3a+ybdbhnKhZaO4OloMWTNnFNZt5WcGoYk3tQ34MOXFaOw5/CPGRbXtBxvI5wEMj5uW7Sw5HZ3yF87lsKy/rhAPrYkwF0MUgWIPY+iQjcmPuoerRWW6iBTJEfnKVKbX+2qIJRNsCns+OOqjpp7JaoBUMfE1Xl8srmZt0qkFp8dNgYM1Gu2JWPf9vGr29T0iF59dLpvyUVeTeFgP/tkJP/tE/EyfbGsRgFbJnfPDgiZppq7I8SRbsTwiW1tZ86pCgWnu3ZeDLN64aJsrwcTchSWg/W2dNm7mThBcw+amUA8niKk66LJMXFofh3l2zS5tHbbXUPp0ZgVQvJOaIyLaGvayCyJ48CYQko6Ipn37cBduB3PeE2NZH2uIgUZhewxaEbz8UVYnJ5GOtIBPFfUWUObZ+bSod5U3GaAB+zlNWgIbtLnn0vee4M1+R010tQmB2B0K2lgniP2fLTy+bh6gIxJ8gCrlvPc3GquAL9R7Pa+vvPJm3wNPGIRG3mQmZvv4zMj3l1uJg8YNVU7YCMKobediGaCbhmX1VbdZwUmHkb2oMDUowqyZpkMouAFd9ZZLLNEVlr+BFnVReFJp8Ki1NQSJCUCrmIsBnE36QDtdke/rYWO6x8v5MKsKldfManuiDRtsMKSg+2bzTZb5Z6m4X/9KeDUYDOCj4ScI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzFBaGNlY0g5UHJuVU1OdGJxL1FwbDA5Ry8rMlZFRlg5N2pPbEhtS0k4ZEpa?=
 =?utf-8?B?VlNsbk1JbHE3cU85aHNpaGdsVDhPVzdHZjNBbDJxcUZqSzZ6TTBzVGQ3WWF4?=
 =?utf-8?B?ZjduODlKQURsVVpySVkvZjdpa1Y3b0VXQVdpVmo4UjVsSC9nV1FxeFcyM1Y3?=
 =?utf-8?B?cjlackc0MUx1VVVqb0dZaTNXbWFDeEVhaktITEE5QTBOZHJKYURuUHM0UEhm?=
 =?utf-8?B?VlJDQ1QzTlFuTDRuWEFkSzF1TXpTc1J3cWZVd00rZC9yT1B4Z1VUa1dqVVhC?=
 =?utf-8?B?NWdjNFZyczRYZEhySVZjeDhyT0NFUitTeGdqcGo0dStEajhlbnBBS1RQOWRO?=
 =?utf-8?B?NUZqV1FSdlF6L2RpR0hCT3lWbVZrckZ5N3hYU3hoRkkydFVDdlkwbFN6alF4?=
 =?utf-8?B?RitqT1NuOHFDRHRIQkFBU21BVkJIL09tcTkvUG9jS2t2akFJQXR3d3F3dkw2?=
 =?utf-8?B?Unh4Qy9RZDhyaVAyL21kbUpRU2prMFdUTHZGcURSdFZsSVpvR0ZJd2ZZSXpL?=
 =?utf-8?B?VEJ2aWY4dVROcUJhejArNnU2TEpRN3QxeEEzMjA4RVpnRDUxY0Q0bkVJRTAv?=
 =?utf-8?B?Q2hTZ0ozV1RLcFJDWmFNMkUvS1FOckUxekJaQ1Q3SjNqM3F0ejNpQ0F2aVpv?=
 =?utf-8?B?MTdkSlIrcWZKMWdVU3U3a3lGUnJ2eUZ3U1g4RHJhQUZNR1A3SW1JcHlxVk11?=
 =?utf-8?B?MGh1OUxiSVBtanVXbWFKMVZqV1ZxLzhqWURLSDBDR2xsM3g0aGdTU1ZlZmlI?=
 =?utf-8?B?cnp1VWxMTmZXY3kwYk1rOGFXeThTOE1rdURweDhXejFTMWJicXErc3RKb2xr?=
 =?utf-8?B?MkxUL3RpNDh3VVVZRG9GRXlLNVBObGZBM05NNDJtMElQMTFJV0t2YTRTQ05u?=
 =?utf-8?B?YSs3RUxvRHNKSEFKeFlOMDJ3b3R4R2VpNzBnVHhBTWMzMm5vNi9ob3JrUFZp?=
 =?utf-8?B?Zm5EY29rZG4rRE9vK29peHRjWWJSRlVyQklsOGNIaEYxY2lORHBqQlMyYUJL?=
 =?utf-8?B?eVp1SmEza1gzbUo1WjJTTnNZNTIzcDNqTGNLME9QT242US9zbndtSkwyTUFD?=
 =?utf-8?B?a0E2YkdDUGVWZXg3WnhZcTd1bUVtVTVQQ1UxNE5hK2dmbHcvdEJ0L3N4bXlo?=
 =?utf-8?B?UkpYT3lIVFUxUEUyVTRTSHFrYUNjVTN4d1FxVk8xRjIvVlFpTHVSRm8xbCtk?=
 =?utf-8?B?cVBocXFrYmNCaFArYldpOTVoczVIWENpQmxpb1RSd0hlU01jUUEyZDMrL3ow?=
 =?utf-8?B?ZzAybTVydFhKbUVZZEtCd0JlYXV4MjZCcUgxZ0RoeTliODc1OWxBMk5kN3ND?=
 =?utf-8?B?MEhaUlpkc3dLRThZcU9rNGVVQ1cweWpnTDVIa2ZzbjdSc25mU2FNSHo0QWd3?=
 =?utf-8?B?MVhZREdYeTF4ZmlGWE1rM29YYmVEM0prOHZSMDNFeFVKZUZtS2FBY0twSU9t?=
 =?utf-8?B?ZWlLYm83WDk5RnFhaEYzcitPcWJwcGQyZEpnWXFEMFpyaGxRSGFiYnNlQnp2?=
 =?utf-8?B?Ny9KWmZjUkFBckdvZ0ZUWUcwckRXMlV4bTNRMnF1YWlJQUtFSHFvaGtJcHdW?=
 =?utf-8?B?d2lXM1dBZ1NXdk9UMTBrYVFBMEE3N0FtT2J6VjV4VmNaUTVMdHdjc1hZZXlK?=
 =?utf-8?B?RmcwMUJvRkRvL0Rhc0cyWW54SEV2a2pqbzN6ck0wZ0VmRlpUaUUveDRSQlU3?=
 =?utf-8?B?RjV0V25FdythWmxzTGMxbHRCUjBMLzgyMnhDVUVFQVhDeDRnVU5jN3YvMndr?=
 =?utf-8?B?TFVvdDBsb3htYjk4Tzg0VjRSVUhCaytQL0VRVTcxamZLbjBnNm90TVFmY2Iv?=
 =?utf-8?B?akJUbmJIWi9OZ2IvaitHeUtCdVZsN2ovbG1NUVdJYVphZHgzSU82blNBSjJt?=
 =?utf-8?B?M2lPdFc4VE9DbjFWZFJodVo0ZU84NEhwQXZQdFZTeUhkVzRKNVM5RE1UczZR?=
 =?utf-8?B?bkVhbG1tbzlrZW96c1VJSTBDNFRRY2NOUDRwcThWVmN3K05lWHVRcm9ac3lx?=
 =?utf-8?B?aW0yWlJ2MUpQeWszMHFKNE91V1FteUUrRWlvSzMvK2tGeWtoQm9ZYkN5VFdJ?=
 =?utf-8?B?WHFFUDd1QWN2WXc2ZENDRU5Ya0s2NHh4aHI5V255cFcvUU9aSUkyUVdkeTV5?=
 =?utf-8?B?UmFvKzA2clN6K1I3V3Z5MkhwaWN1SGQ4amVaQ1p4ZVg4VDh6cC9WVlRkTUEw?=
 =?utf-8?B?WmI4MWdDNGJHODFWVFFaeXZWMU4yeXpuek5QQ3JZcDlOREdHUW16bU14ZzFZ?=
 =?utf-8?B?emhmbENITUJtKy9EUHdWcUU5bko3Szc4U0NYSDdCbkQ1N3IxdlBtd0xDWE56?=
 =?utf-8?B?T2NsVDcwc2VmMjh6c2JpSmh5WHlXR2RSWVFSQUk0R1ZBdHNVdHlJQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7e2c50-e897-4b66-78ee-08df0dde2696
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 19:19:49.3788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bjUA/iiEEW+IHN0rY1mu+8MwttDH2WHV+JOvEi80voA4Cz9iC8asmVKHPRq8/jc7TticHZTziBOzCRZQAplkqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9559



On 9/8/26 14:18, Bjorn Helgaas wrote:
> On Tue, Sep 08, 2026 at 12:00:34PM -0500, Mario Limonciello wrote:
>> There have been multiple reports of data corruption that can occur
>> with 64-bit DMA when the IOMMU is enabled. This occurs due to some
>> BIOSes enabling enhanced atomic operations on PCIe ports.
>>
>> When enhanced atomic operations are enabled on PCIe ports for some
>> models, data corruption occurs when the 32-bit IOVA space is exhausted.
>> The problem is reported on storage devices, but can affect any device
>> that uses 64 bit DMA.
> 
> I assume this means there's an erratum where NBIO doesn't handle
> 64-bit DMA correctly when some AMD-specific "enhanced atomics" are
> enabled?
> 
> Nothing to do with the atomic operations defined by the PCI specs?

Correct; nothing to do with atomic operations in PCI spec.

Note: I did post a v2 as Sashiko found a (valid) problem that this 
policy fixup needs to be applied during resume as well.

> 
>> Disable enhanced atomics using SMN for NBIO 7.7 and 7.11 based models.
>>
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
>>   arch/x86/pci/fixup.c | 93 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 93 insertions(+)
>>
>> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
>> index b301c6c8df753..0857fd9365ec2 100644
>> --- a/arch/x86/pci/fixup.c
>> +++ b/arch/x86/pci/fixup.c
>> @@ -886,6 +886,99 @@ static void quirk_clear_strap_no_soft_reset_dev2_f0(struct pci_dev *dev)
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
>> +
>> +/* Strix, Krackan, Strix Halo (NBIO 7.11) */
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1507,
>> +			quirk_amd_nbio_7_11_disable_enhanced_atomic);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1122,
>> +			quirk_amd_nbio_7_11_disable_enhanced_atomic);
>> +
>>   #endif
>>   
>>   /*
>> -- 
>> 2.43.0
>>

