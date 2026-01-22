Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010012.outbound.protection.outlook.com [40.93.198.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF0035CB83;
	Thu, 22 Jan 2026 06:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769062836; cv=fail; b=BZVDrobokM5Xm3tD232+K8ya7Zy4EMyID5Glmy0iu9kLF+86QQXHBFcPOgZ2feDCpM4KPE+G8zoOTIGUDz6ZETcZF1yFEv5Z0/J/xBKlNA5nKFriNTjnxSpAY0KSOhhAks5qSSctt9M11cwQPW8uf+86Q6TfzhAo+mqhZg69ZHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769062836; c=relaxed/simple;
	bh=oinXXD96DQ4cHFJakZ2Iq0l8CftE6wWXxsNH1FD4QjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BhkLrcN55JF4/S0uCgQ2jbGGL4o1mT+Pm5rhY9DGOmOomAzZGvsFGKcN8i22cvnQrYNxWp+ccqRQdiI4goeIhBFxNEWnRJ5s4any60BXkAr7MqkwSZaiUxhYABzBxS7dDn5HRwtj8VxBfEv1yFKk0lZ8mKwF70WUHZT7ZWC+CWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wCrN046I; arc=fail smtp.client-ip=40.93.198.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wCrN046I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMCbqXQOlLxbwTvaAzuoIRKM9KJCbHfY6D4fMN6AnkkEEzDyjlmhFfC1yha9rZbCTs95r3h2IZ9RqdVArY9KxPccUVlieaYYaq1ZXgPkN76xN1NRZyXlXCaKU5uCDsmOz2qvrzlDwhR6CVrLBY4wWPpv5P67u2fkQC61bUjC+bfVpAaNeHYe+M5Tk1QALMzZ1SozSf05hXAreJ87J0HyQlOsTcoL35SiOu3Q6CAaBuQfF+B2RrZ8JJhlMQ72eLuBiJNNJ5+7iKrTwbjTmTZzTNAuLMYdiq74JmMhWUm6It2MulUrCoD5wyHKXMI9GF8BtIeC951XHHGzdC2FTuC2FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbgY85Ow+mn0MOSFnouYhIX1yjJSoRppxbiOuGRuFV8=;
 b=TocGxzx3rg+nD+L0hxLKC86wBuR4cUdWGXbW7eyX+zKSFHwANX/ZHNgioI41XUBpeKwqTWGpo3+hix1l3eSORVxcqgcVZOCc81jvKWgPuxoLNFRoiur++mwHYKryOd+BwUAHoF97apOYWZg2Asmx6yrq9OoSveCMwdrM7Z73BrG6HJY7rG7inw7aT0V4Yz42pC5fEyl1loah4c4bijFe4PlVF5aka5CjBUNeItSayvamjrW0GLH9xHQqM90W1j96VEt8MTgRz1yWrXPr+zb6Ahyp3HbvOw+KWIgwVpoxX4AGX4EpzF7Jp3YdfyHRwin8IfRKDWEy1pJnN/Xk+fMgaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbgY85Ow+mn0MOSFnouYhIX1yjJSoRppxbiOuGRuFV8=;
 b=wCrN046Ik998isUUD4D1dCfI2r9GfWsmzJrK9udpGzhkanjD9/hsNypSGc5gIvowusba6hYStSY+Vyt2NF0zOdSB+OP2AYA8vm4E8Pnf/hVLfLD0azXu9lWMKuIpKBPOOX/tO0JePQilaWWLis3g3WFE1EL/Am0ZmzmsWCCLEDU=
Received: from SA1PR05CA0021.namprd05.prod.outlook.com (2603:10b6:806:2d2::21)
 by IA3PR10MB8137.namprd10.prod.outlook.com (2603:10b6:208:513::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 06:20:32 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:2d2:cafe::84) by SA1PR05CA0021.outlook.office365.com
 (2603:10b6:806:2d2::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via Frontend Transport; Thu,
 22 Jan 2026 06:20:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 06:20:30 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 00:20:22 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 00:20:22 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 22 Jan 2026 00:20:22 -0600
Received: from [172.24.231.225] (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60M6KJbt4154576;
	Thu, 22 Jan 2026 00:20:19 -0600
Message-ID: <d4cc4884-9684-4ec9-beb6-4ff2b2169322@ti.com>
Date: Thu, 22 Jan 2026 11:50:18 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: dwc: ep: Fix resizable BAR support for multi-PF
 configurations
To: Niklas Cassel <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>
References: <20260121054214.274429-1-a-garg7@ti.com>
 <20260121054214.274429-2-a-garg7@ti.com> <aXCjP8KZw1ig8i-W@ryzen>
 <5f83a07a-ef35-47e9-b40f-fc7617a4488c@ti.com>
 <F757BE07-47EB-49B0-BEA6-03ED01C4497C@kernel.org>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <F757BE07-47EB-49B0-BEA6-03ED01C4497C@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|IA3PR10MB8137:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cdedb86-24f9-42e0-c140-08de597e57b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVAwc1Q1eEQwMXp6VEc0ai9RQ0doY0tVQTZpbTlMdmxIWVRoZllCMi9SOTlN?=
 =?utf-8?B?OXp3ZE9DSkx5V0VOa0NUaFRkakYvUUJ3SFRuL0g1TmJtMDlGaHIxRGpNL0lY?=
 =?utf-8?B?TGlncmVUdWtTVHJBU2dLZ01kNFJjQmVoMjcydVdRY3Ntc21BWDI3QTJJYURs?=
 =?utf-8?B?RzcwVWFsTEFDaGY0ejNsTytOWG5HSFE4bHcxK3p1S1diNy9iVUEvZWRBWDJo?=
 =?utf-8?B?SVFJYkJWSmRuTS82ZVY3VksvNnAycU5IUFIxRDNIYmx3WTZXTXVVSEZDcGQ2?=
 =?utf-8?B?MU1NUkhZRllUUmFRaXAvSWxHSHNDTmRCQm1yUDluVU84ZCtKSkNkMGdHT3A5?=
 =?utf-8?B?SkRvRnIzNXBGT3krbGZZam1TOFEya1hXOVZKemRDbzNvVktEb0pnT3U4eVlY?=
 =?utf-8?B?WEV6aExhODNaK0NjTi8ya1owdGtkR1pVRldiNStWVjNLeUdnNGpVQ2RiTmhZ?=
 =?utf-8?B?QWpTaENBYURtTFkySS80VmcySDlKWStDM0NTVHladnhlOXpKQUp6TnZ4RzNY?=
 =?utf-8?B?azVCc3JWZDBkdG11OCszek5kM2VQaSthWE9Nb2hnWWkvWEFBME9TN1dLWnpv?=
 =?utf-8?B?Sjl0K2tlQUlnWW83aHd6Wm9HTytSYmQralYvL0Zmc0tCelN3QlhtcjRsNytX?=
 =?utf-8?B?SldBMkdvSS9GS1RHeW1wc1V2bEpNVTNEanpuNXhRZElVZ0VMUHV0bWV1c080?=
 =?utf-8?B?UThHUmkzcS94WnNNMngvZ1VFV3JMNHpJaDRaeXRyZDk0WDBPbDZmaUNSaCtL?=
 =?utf-8?B?TU9OM01rYi9xMlBrTWlkM1hkM2xzK0dKTS9UeGlmaHNQbHM5REZOcG5yZVYz?=
 =?utf-8?B?WTFGUDd0UmtRNWZXKy9vUzE5d3NlTjJUK09zUU9hdzdhUTZoT1U0L216VkFj?=
 =?utf-8?B?aytmZjVZeGYwd0t0VkZLT2kxRjh0cjhISlpyQ2RkWEpOMWJWWFhPWDNKQmhR?=
 =?utf-8?B?V0JhKytuSjUvWFBBbDJFalEzNDJnWlJ6d2FRT3IrT0hGblQyRWE3aDBBWmFW?=
 =?utf-8?B?RVdUdWQyS3VvQ1NNeEFsU3FzSXhBNlo2ZlhWbDdzbEdRQjNjSVdPK2RGWFFF?=
 =?utf-8?B?NHd3UFMrODRpcm1NWGwrSmlTMnZTTTJvNk5rYzBiKzloa3pGOXJTY05JejBU?=
 =?utf-8?B?NlpCcnVhd0dFZG5ic2RlaUl2ZWV0TWNtV2I2Z0MvTU8xK1JMU1lsVW9mS2g5?=
 =?utf-8?B?MEJzaXMvRThpWEljSWRtREY5OHJJVlBUa3A3YW1qRXkzT1dUeG5EY21YR2Vu?=
 =?utf-8?B?dTgvQW94L3J0b081bnQ5SzBJeGs4Y3FkNFVMRTNoVVYwRmg4eEw5cjdMeE1T?=
 =?utf-8?B?TElKT2JVaDFWYTFpT1lzUWlyZzE0UTBjR0w1V1gvM0ZkTWF1RU1LcG9vaGlE?=
 =?utf-8?B?SkU2bHd6UUxNb3ErMkV6MkhONzJTTDhBL25xUFQzbU9ORUNwM0hvUjZTM3pI?=
 =?utf-8?B?c2t4aVlQVnhWZUgxQ21DVFBvbVJudlFOT0RydTc5QU9JQlYrZVgyZm5pOXcz?=
 =?utf-8?B?R04wbDluTWFneWk3TzFwbE9UeXV0QU9mOHQwZkN4MnBYcmdCWVBMOUFVZ3Fa?=
 =?utf-8?B?RmZrQlI0QWZLNERLWFdxdjdTRkRheGt1T3Z1WDNPTVlXUWJ1VDVEUWcwcHd0?=
 =?utf-8?B?SnNzVXZud3JQcmMyNnVkRkl4dXllcHF0eFRycW9qMFdqMytkR2ZWR21GMnRz?=
 =?utf-8?B?K1JneXBBNkdYYkovOWd5NU85eTgwcFNxZ1Q2N09NSHUyYllHYVhUb1RXNnRz?=
 =?utf-8?B?enhxQlVPSTUrRGdxOVl3UUR5UGYwM21UaHhXK21OTEEzT2ZnaTRqVTA0L3Bj?=
 =?utf-8?B?WGt5blpmR1V5RTYvN04zaFh1dUgxSDJxZmhOdSs3OHNNd2MxVHZ0KzBwdTF3?=
 =?utf-8?B?bGhmK3lRYWxzVFptaTl5dHFKOTh0Z2FPY2g0U1N0QWV0STc0TVh3YllHK0ox?=
 =?utf-8?B?T0xkenJCTGhkODVZc05rNVBQM3h4Y285WlVUS2JzWm9CTThRZDIrQXg2Mkth?=
 =?utf-8?B?N25rOWRhUlZCQVZHVXNiWFF0dWg0OGJLcmd5Y1J6SWJiT3RWZGczK3M4cGJW?=
 =?utf-8?B?U3E3ZmtwelpjcCt4TEJoK1kzUFgreDc1WXl1Rm5FS2dlYjJ2Y1Q4STRiKzh4?=
 =?utf-8?B?c0hIR3VVd1BsTHFtakRUTTVQWXV0aStsRkZxRTErd2VaM3g4Q2ROYmdmcEpB?=
 =?utf-8?B?TkhRVmN0ekpvZFNLV2NBQ2Z0RFdmNUlHNktzREpYd2VocDJWZDNMaldHZFFB?=
 =?utf-8?Q?GCd14gN6dZ7sNmicuau0pbFZ0ThFVJl0ByGPqkpwF8=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 06:20:30.4812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cdedb86-24f9-42e0-c140-08de597e57b7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8137



>>>> -- 
>>>> 2.34.1
>>>> 
>>> 
>>> 
>>> Thank you for fixing this!
>>> 
>>> Reviewed-by: Niklas Cassel <cassel@kernel.org>
>>> 
>>> 
>>> You do need another patch in this series though, that fixes:
>>> https://github.com/torvalds/linux/blob/v6.19-rc6/drivers/pci/controller/dwc/pcie-designware-ep.c#L972-L986
>>> 
>>> As currently, ptm_cap_base is fetched using dw_pcie_find_ext_capability()
>>> instead of your new dw_pcie_ep_find_ext_capability() which takes a func_no.
>>> 
>>
>>I examined the register spaces across different PFs to check whether all the PFs have the PTM capability registers, and confirmed that PTM capability registers exist only in PF0. PCIe r6.0 section 7.9.15 'Precision Time Management Extended Capability (PTM Capability)' states that " For Endpoints and Switch Upstream Ports that support PTM, this Capability is required in exactly one Function of the Upstream Port and that Capability controls the PTM behavior of all PTM capable Functions associated with that Upstream Port". This indicates that PTM capabilities are controller-level registers rather than per-function registers. Hence, in my opinion, ptm_cap_base does not require modification, since dw_pcie_find_ext_capability() and dw_pcie_*_dbi() already correctly access PF0's register space, which is the expected behavior for controller-level PTM management.
> 
> 
> Hello Aksh,
> 
> Thanks a lot for digging in to this.
> 
> Since commit:
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/dwc&id=86291f774fe8524178446cb2c792939640b4970c
> 
> Together with your patch,
> there will only be a single call site in pcie-designware-ep.c that uses dw_pcie_*_dbi() instead of dw_pcie_ep_*_dbi() remaining.
> 
> Thus, I think we should at least add a comment explain why this is the only place in the whole file that can ignore func_no.

Yes, I agree that a comment should be added with the above explanation.
I will add a patch for this in the series.

Regards,
Aksh Garg

> 
> 
> Kind regards,
> Niklas
> 

