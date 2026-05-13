Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010010.outbound.protection.outlook.com [40.93.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620D238F949;
	Wed, 13 May 2026 11:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671824; cv=fail; b=WXGEOhOhY9kNpPl7QJxLvkWf19FY67VwGvVFSHLNyN2bh5kO4U7kWy9csxVVaLOoClA2CrE7/hZdeYSUlTC0rOQQt8oSMX9n36MYFcHV7m1nVl3sG3X2VcQ0T3/byIG3MhqiuJyS+CJgkd3DMpN8r05kd6uBTfGVF1s5OOB7tBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671824; c=relaxed/simple;
	bh=Lf4GqLbOsLgyVlpTea4kFSKGbPUgSMTX/0mfuSqPyKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DV1ab7yZLixSwq5SYqMbJ+1mZeakAt+/KQF5ujGZMTrehAiCg39w5ceacq3ay/ci/Nyl7flv6ebCoNVhCx/8KHC90av+wzkBRxg178XPfcJoa0LWU/InbZOu7UVhbAuFJQ4N6uoob+wTZO+k014QiaADwSZjy9IJqN08RTXKwl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=alZjWyiG; arc=fail smtp.client-ip=40.93.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="alZjWyiG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilI9961cZ6EHTRkcVfH6vCb6VZh/qju5ux3MIf9H7PrOD7ThEKNAChJjyYUMsD4cNsQwB45G45kRzuLoiOYN0qO4SJWjdQ6ReA5D4uMEpM6Mlok8JnGaiduW6tll1McLDMm71RssyrXCubsxuwL+zvM7hoYh3J+g40JGhguHqf66TXGe/KUM81uf/Vn9lkBy2Yhf9j9f4yQkJoFxP4fqH3IeYWKQEp1QuuqSOCtlelfOkary9w+xL0kmUpg2h4oMNwvqrcyDd7Qnc0O2Vpycooru7wnn+iKXqS6aUNkoXL+FdFfy8QUKSH4DcntQMtDK74j4N+FUCVBJPk3HcJp5Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xqs6l9WGUr0ZERbq1hMaZ5JwhJFMjW20ySbyqJvW7xE=;
 b=hNmtNIKlWDuD11M6RJ62ej02kYlu/q5vULQBFL4i2e0z5qu8A4ATrOfZD+c5ccJ/DLwJu5LptYMl4xRsdas52afU/ueZ0KE2qKBy5ix5H5vhTKfVVAvVl+qyCeKD48/EghJfkg6m6Le9JZXNUh5YE278kwU/WiRPRRIZVlhuocd+M1nwNL8niMsZ6ZF+WhhUo69a+T20r0uPiOquk7xXJ1XUPP1O/UUi4Q6ftUpoMCNV+kkYoPe5mb2nsxHFNPihwTPJa5rzD4JrRISSUBcknf+SPAVK8gCuR/WaRRJeT6Lv/tQKk8zoJBZz1VHZvCsTl4PxSXBNmLKEnWbU1p8xWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xqs6l9WGUr0ZERbq1hMaZ5JwhJFMjW20ySbyqJvW7xE=;
 b=alZjWyiG65wWEYIZR9MpHG9P4v/ca+eF+SgysBrY2K5DLwsu+6/bMg+xj2gMr3UyV9OiKqvLB7Xh0cPLiqFNjmABGRwqRKJm2nJnNbFkVFKDXRXtxuI2EUtZ5sNKEk8osuJWjBJUF5f25/T3xzgoL+raxQvyIi9+wG4ox7lFhlw=
Received: from SA1P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::11)
 by PH0PR10MB4712.namprd10.prod.outlook.com (2603:10b6:510:3f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 11:30:20 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:22c:cafe::c6) by SA1P222CA0027.outlook.office365.com
 (2603:10b6:806:22c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 11:30:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 11:30:20 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 06:30:20 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 06:30:19 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 13 May 2026 06:30:19 -0500
Received: from [10.24.68.129] (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64DBUG4t3954306;
	Wed, 13 May 2026 06:30:17 -0500
Message-ID: <31b5f0ad-70a5-4397-8740-6808d0266a7e@ti.com>
Date: Wed, 13 May 2026 17:00:15 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] PCI: cadence: Add debugfs property to provide
 LTSSM status of the PCIe link
To: Hans Zhang <18255117159@163.com>, Manikandan Karunakaran Pillai
	<mpillai@cadence.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>
References: <20260508034101.1910036-1-18255117159@163.com>
 <20260508034101.1910036-3-18255117159@163.com>
 <3ab81da4-a745-4e85-8aa3-3a217e3fdcbe@ti.com>
 <BY5PR07MB6705FFD54E7D97EF5AB0A211A2062@BY5PR07MB6705.namprd07.prod.outlook.com>
 <f8ada2e3-15c2-43b1-b013-2f3fd263f25f@ti.com>
 <c0bd820d-9716-4109-9d5e-7e72e0716cf1@163.com>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <c0bd820d-9716-4109-9d5e-7e72e0716cf1@163.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|PH0PR10MB4712:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b9801e-3670-404b-2496-08deb0e303fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	HbJzHukhG4vo1w5XqhSi7oRmPbhJibLCMmUO+dbURTnif4ueBK9YLt0vAczn16nGswRR2TV39qKXrsQ+bhX/mImYoadUrHFfFvlMz/4Wxx8mA0kcHBG2c4+cKNmqqkXHQn44gHqm45fsG+1WyqhHoBQRFb0+W1kYw5UcMFxCCfehptZgAKEzlEloG62IOld1OP5b6ZawfTJ+cwvzk3QVSKeGEqJqHIh8rM2pk6NocV6IKNSMUTozWq44exVjI8xU/H5LfPhpWDrKCVRvcds2gydfhgYruXOXf798iKbCyFkzm83SmZ/5UhyZQkh3p4L6xoDhHRnuNAfzdGriZCYzUuXEwgsumEQzPX3ETCYArosqMDB8LGiKdXPV6GZsurCatQHCdEjHep4HLfE2am10JOM9DkKqUr07eum2bWsK4srQz2azcHfBoex+1p9FvGvV6ATJFTF+rTOo6KPbLNa8wm1ZLvBtO7nSgAPuAtcdsCcZ/sEWbzPlfKru0utuHEVPidID41kkC4ac7KGpSxQKJvKome45YS9+6EeMnffYdk3Ik/OEW8aBYlAEdvhsl8T9JdNNpU1mJnHrw65GYT2N+pXmo94qAYEIk/fXi6EK9P2TP6luWWxYRwbQC8V1LZyzijoAs5nBKgqDgjPJLPZhSntqVfA5zVvM7COAfoZHWSATpA2Yvmd5X150+BpwhZ47sOo0qZsRV/mVYUj8oRfFr74dSQz+XyC+cygaav+qR7w=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7708Jw8e4Fa9zuEuvKboFXqd9FXZaUCLtDDEtGAI+lFXl5m5nETxHwEjMyIO0EzCaCJXZKgqN6WWH7ek5Wnsvn9xdf/JKCVE7qLGdSwjCWG5kqIHtpyL4JvuiS96S213jXXkoR4uM6do5avKAU3+ePZLQYHfzM3ReujqEkU7DBeiTPRubMyLDLJDbkrfet+JPuVcEYWWD1yhJ16ZsNxxOKme4nhqGP6H0urTUQd6FO3pGe4DwWN7Iw216t/zN9fucdpmaIqEqF2rXq1GSEQDwBlqyV/AkJ0CDPJtW2UbEDQvwv0s3ATHQsUO+rLxQzh+9cJCVpmpmo8CHusWa8uHLhb2o4WStVAvdqkH9zQclIYyQXNkPwBwXiPZU7kcXW3IDga4o3zHWIlpVfmSy6Vynr9pGC3vqCg8RJD021EOrjY4hMKUL2U9+NWERuKMOKYA
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 11:30:20.3397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b9801e-3670-404b-2496-08deb0e303fb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4712



On 13/05/26 14:25, Hans Zhang wrote:
> 
> 
> On 5/13/26 16:34, Aksh Garg wrote:
> 
>>>>
>>>
>>> The above LTSSM states are internal LTSSM encoding states and may not 
>>> be available for software to use.
>>> The LTSSM states in the document pointed by Aksh (TI Soc) are the 
>>> states  available in all cadence controllers.
>>
>> Is this true for HPA IPs as well? The test performed by Hans:
>> root@orangepi6plus:~# cat /sys/kernel/debug/cdns_pcie_a0*/ltss*
>> L0_STATE (0x29)
>> L0_STATE (0x29)
>> L0_STATE (0x29)
>>
>> This implies that the L0_STATE LTSSM state is mapped to 0x29 (41) there,
>> which according to your response is internal LTSSM encoding, and hence
>> the register read should have resulted in 0x10 instead of 0x29.
>>
> 
> Hi Aksh,
> 
> 
> For HPA, my view is similar to that of DWC - it requires a common 
> internal LTSSM state. For each of its own Root Port drivers, a callback 
> can be used to implement the reading of LTSSM. This part can be referred 
> to as the implementation of the function in DWC.
> 
> 
> static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
> {
>      u32 val;
> 
>      if (pci->ops && pci->ops->get_ltssm)
>          return pci->ops->get_ltssm(pci);
> 
>      val = dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0);
> 
>      return (enum dw_pcie_ltssm)FIELD_GET(PORT_LOGIC_LTSSM_STATE_MASK, 
> val);
> }
> 
> 
> static int ltssm_status_show(struct seq_file *s, void *v)
> {
>      struct dw_pcie *pci = s->private;
>      enum dw_pcie_ltssm val;
> 
>      val = dw_pcie_get_ltssm(pci);
>      seq_printf(s, "%s (0x%02x)\n", dw_pcie_ltssm_status_string(val), val);
> 
>      return 0;
> }
> 
> 
> 
> For example, it can be modified as follows. Of course, the function name 
> will start with "cdns".
> 
> For LGA IP, currently we will allow each Root Port driver to implement 
> the corresponding ops::get_ltssm() by itself.
> 
> static int ltssm_status_show(struct seq_file *s, void *v)
> {
>      struct dw_pcie *pci = s->private;
>      enum dw_pcie_ltssm val;
> 
>      if (pci->ops && pci->ops->get_ltssm)
>          val = pci->ops->get_ltssm(pci);
>      else
>          val = dw_pcie_get_ltssm(pci);
>      seq_printf(s, "%s (0x%02x)\n", dw_pcie_ltssm_status_string(val), val);
> 
>      return 0;
> }
> 

The process above tells how to read the register and get the LTSSM
state values. However, my concern is whether we require different LTSSM
state encoding in your debugfs patch, one for LGA, and other for HPA.
This is because the L0_state seems to have different values in the LTSSM
fields of different IPs. On LGA, the L0_state seems to have value as
0x10 in the register (as can be seen in the J7200 TRM). On HPA, the
L0_state seems to have value of 0x29 in the register (as can be seen in
your test logs in the cover letter). Hence, if we want to print the
LTSSM state string in the debugfs, then for LGA IPs, 0x10 value should
print L0_STATE, and for HPA IPs, 0x41 value should print L0_state.

Please correct me if I am missing something here.

> 
> Best regards,
> Hans
> 

