Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011053.outbound.protection.outlook.com [52.101.57.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A653D9038;
	Wed, 13 May 2026 08:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778660751; cv=fail; b=NcqbsrYLeqhWwVTscbiVVZtIsVO+gUpWC/hjfJ3yoYK9NVe1ajs6daGweCTtymz7m+gUVFw2TEeP8VwNj/tTse3RuWFsW/X2EgfLwkYJM8DnMHJo3JADqZK2ssRlJ7tdWM75++5SN0YG+2tqVHkw70wRajieI21v5d609GHaYbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778660751; c=relaxed/simple;
	bh=furWzvwuWSj+whvMBogccF2LE2Vf3Oa/SNfw+x2WaOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Xq/N9r/oZPrdw9AldxBOxii6Plpdj6kyM4oxl5JjzRbSSgZbBsumrGPvNE7734xyhkpAdE5ytbhvHrMCYa0VWuV9XajZXAfKK4sLT3zH5umNPQOivBdidVHRaYGQsYkDtN/3H0A6a3lVZ/oqRqCsgZlqAhACTjCAY22BuwacySI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Wkknsgvo; arc=fail smtp.client-ip=52.101.57.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Wkknsgvo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQD+yaHvxiC7CayuwXmah+6f+7GkVOHdAWJjOZHVHaH9jBy39s6a1Mf6bMq8uchW+j5Y4QLh175L8PpGMA4c2tce1zj4D9/WaciPUrdsrRXyHvoxucg3m5NRAFbQDovWjkO5onPDiRr3ZVpbBBP6vxf/wH7fHkz+4dCaRqUdP5EQ9e/3v6sg3L2OPs0QJr4nezMMKcBqxK3h6SqDI0Bj8ePGbomxzTdA8Meuxd4JP7UZwPpJ4qkuG1tV3Fucsu/G4JycxmlQJnS3W50A3HfoDX9ssbvv7rdXkhyUX45rj2vcIB2ISlzcciYRpMvS6chxdpFK9ZFr5PThCRn6hN/K9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuTU5sSUnRZXyXhQ6hDsHZ9kVyUXz6pCXmRvnetnz0k=;
 b=jifuGIB699FSwyUI8rr5Zd9gaWk8T56pITz2PDeg2g9kEEA9CQIVtvgIs7hveJS81ighQ6ZOvwr6S1X2XLBaEYXSmWTjGe1Mk40CsCL0bn5wRiGyR48zBdBkH6tYHGwIeO6jVjkMOyYz2Ytmj8O9bOFMMoMWopes0vonDFk+179bmrk8nUtL5+Od0Zn+emonFpAG+3mLlQ2ZY8Rx2ik8RZ0IXVXbFpMO5YbQ24mCN+I/fQ3kHTl0nVQzbeCyO71PDzHgdr1V4d78KaBQoQXxC9CYbtwASYlgaO9WldJJcUSAebPhuZTAgMyhnDQpQsWIuz7zCZgymlIEhCplG7ok0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuTU5sSUnRZXyXhQ6hDsHZ9kVyUXz6pCXmRvnetnz0k=;
 b=WkknsgvoHfyxkFjXrbINtzSK2s0RbegmC1SDW78s5MOqva3ZjNHQgFZcJ4NSBzBdM9E7bOR5rBk9lrmpGnUd91aYvUyLCKc/HG7r1k/CyssoO2v3s1q99UeCJBOQSkEWkd4HSnLJw+GD/e4f/3oAujgb2J2K8UCp7hVXyBVro0w=
Received: from DS7PR05CA0070.namprd05.prod.outlook.com (2603:10b6:8:57::28) by
 MN2PR10MB4272.namprd10.prod.outlook.com (2603:10b6:208:1dc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 08:25:38 +0000
Received: from DM2PEPF00003FC9.namprd04.prod.outlook.com
 (2603:10b6:8:57:cafe::90) by DS7PR05CA0070.outlook.office365.com
 (2603:10b6:8:57::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Wed, 13
 May 2026 08:25:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DM2PEPF00003FC9.mail.protection.outlook.com (10.167.23.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 08:25:38 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 03:25:38 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 03:25:37 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 13 May 2026 03:25:37 -0500
Received: from [10.24.68.129] (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64D8PYiK3314075;
	Wed, 13 May 2026 03:25:34 -0500
Message-ID: <1e5b0f09-c04d-47e2-9657-70eab3d0e415@ti.com>
Date: Wed, 13 May 2026 13:55:33 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] PCI: cadence: Add debugfs property to provide
 LTSSM status of the PCIe link
To: Hans Zhang <18255117159@163.com>, <bhelgaas@google.com>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<hans.zhang@cixtech.com>
CC: <robh@kernel.org>, <mpillai@cadence.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>
References: <20260508034101.1910036-1-18255117159@163.com>
 <20260508034101.1910036-3-18255117159@163.com>
 <3ab81da4-a745-4e85-8aa3-3a217e3fdcbe@ti.com>
 <75d71086-4d44-4dfa-b685-e18888c0c471@163.com>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <75d71086-4d44-4dfa-b685-e18888c0c471@163.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC9:EE_|MN2PR10MB4272:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d25695f-5f5d-4950-da5e-08deb0c936c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wDSc/nLwuTgrJSUf1VFbCzx4IXkZmDDhOq3r1dlNk5nJQ8q6LI21RVXMjmKQXg7sAFfnlJDmoBlqarZHsZdgMk46v+FOY5W0nCo7j+iJD4+kJVnzjhyEEcl2LpEI3+0uohi4l5mwXiiawcWt3V7JI7+Wfuhmm+nGhft6psG7CvM0msz/7EFjwLhyHmpacqqpcTzCpbcXBnMy4rpZgz3gbSwRYVgdlzOc/LvxmFmGJTABYfdo5EbGKqjQUtI+cLuv7hbGQGrmrplBck7L9I05CbfSNqdMlrglwbnFWxitrouucjpKYsNFp2f5bIcmKysXhx7RKpYBYshds8HmINUxXeyJAFABACzSuG5L9kL0URDAjtW5PZno0sLj5D5yBOnIAnuwpIS6edzufrRjf9zDqbtVRkwP2P/38TEtoA6+Yjoi2tJoucgmsHDJMm36tl4shGWJRcc72uYPp6/iyHQojz3m/FaxPS3bfqJErVeuk03OSn0Ra02YexHSJiyn8EXaB8LUnPFndrkW0aVWtWhdui4OPwhOcoEiEMippmhg0bIFFzJjsjUgdVAT9gaoswN8xDY7M5+dY86tgtqHLiwCSFr3QVKI5hb0hVQbbIxF56j2S6v04BrGsxe0jZgD28O0Z/qgplyXN4CY/5PrqBSq8ik9Eu6TnmWwDgtrwL//yzwx3eKqw3Q+eqKZSPCJZXRdSRcVcjNBEiD1ufj6tl1/gNqlJQJ6/KoiTvUFLBuL62w=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AHp1oI0ssxPHLImlrUD0F4AM7g0+mHEhJ0WTfnck/oavJ0UrRvZBmJI6e+F1q8V5nTg+rBW0q2xwxq2mBG6A822ZhMOIR9sjcFToHKLKKyXc/NpK3lYUw4Zrun0av6g6YEvZtSmiLW1kbANG6gyg2LBX9UEs5nyQS/dhAN/f2ombQqq/+WbVNrQETtzWeoUo+OAzsXnuakFLXse0dMixQiWzI8f5oT89/Foeq0ogNV8Gpzn8vyxkvE2lABl5BL2qdUmcEuKpgVtAoRxGRiJPqpaOPh6w3nbE3qOr8djNXrmfg38BkkFCVmL8gNUEI+XLvLNblHdHP3MtcU7/2Sm/rXf3LoAT3IjSIwhIe7XnIrO1/YgCq/46cARC7NZ8im1BrcLDroiZj2yJuDD1O6gSTm7Jgjjqd0ayCQYHLPXaM0kR7NBrFgFKHCYoMY1woX1M
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 08:25:38.5831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d25695f-5f5d-4950-da5e-08deb0c936c3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4272



On 13/05/26 12:07, Hans Zhang wrote:
> 
> 
> On 5/13/26 13:23, Aksh Garg wrote:
>>
>>
>> On 08/05/26 09:11, Hans Zhang wrote:
>>> Add the debugfs property to provide a view of the current link's LTSSM
>>> status from the Root Port device.
>>>
>>> Test example:
>>>    # cat /sys/kernel/debug/cdns_pcie_a0c0000.pcie/ltssm_status
>>>    L0_STATE (0x29)
>>>
>>> Signed-off-by: Hans Zhang <18255117159@163.com>
>>> ---
>>>   Documentation/ABI/testing/debugfs-cdns-pcie   |   5 +
>>>   drivers/pci/controller/cadence/Kconfig        |   9 +
>>>   drivers/pci/controller/cadence/Makefile       |   1 +
>>>   drivers/pci/controller/cadence/pci-sky1.c     |   3 +
>>>   .../controller/cadence/pcie-cadence-debugfs.c | 208 ++++++++++++++++++
>>>   .../pci/controller/cadence/pcie-cadence-ep.c  |   3 +
>>>   .../cadence/pcie-cadence-host-hpa.c           |  20 +-
>>>   .../controller/cadence/pcie-cadence-host.c    |   9 +-
>>>   drivers/pci/controller/cadence/pcie-cadence.h | 150 +++++++++++++
>>>   9 files changed, 406 insertions(+), 2 deletions(-)
>>>   create mode 100644 Documentation/ABI/testing/debugfs-cdns-pcie
>>>   create mode 100644 drivers/pci/controller/cadence/pcie-cadence- 
>>> debugfs.c
>>>
>>> diff --git a/Documentation/ABI/testing/debugfs-cdns-pcie b/ 
>>> Documentation/ABI/testing/debugfs-cdns-pcie
>>> new file mode 100644
>>> index 000000000000..659ad2ab70e4
>>> --- /dev/null
>>> +++ b/Documentation/ABI/testing/debugfs-cdns-pcie
>>> @@ -0,0 +1,5 @@
>>> +What:        /sys/kernel/debug/cdns_pcie_<dev>/ltssm_status
>>> +Date:        March 2026
>>> +Contact:    Hans Zhang <18255117159@163.com>
>>> +Description:    (RO) Read will return the current PCIe LTSSM state 
>>> in both
>>> +        string and raw value.
>>> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/ 
>>> controller/cadence/Kconfig
>>> index 9e651d545973..cb010bc97aad 100644
>>> --- a/drivers/pci/controller/cadence/Kconfig
>>> +++ b/drivers/pci/controller/cadence/Kconfig
>>> @@ -6,6 +6,15 @@ menu "Cadence-based PCIe controllers"
>>>   config PCIE_CADENCE
>>>       tristate
>>> +config PCIE_CADENCE_DEBUGFS
>>> +    tristate "Cadence PCIe debugfs entries"
>>> +    depends on DEBUG_FS
>>> +    depends on PCIE_CADENCE_HOST || PCIE_CADENCE_EP
>>> +    help
>>> +      Say Y here to enable debugfs entries for the PCIe controller. 
>>> These
>>> +      entries provide various debug features related to the 
>>> controller and
>>> +      the LTSSM status of link can be displayed.
>>> +
>>>   config PCIE_CADENCE_HOST
>>>       tristate
>>>       depends on OF
>>
>> [...]
>>
>>> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/ 
>>> pci/controller/cadence/pcie-cadence.h
>>> index 9a464cbaf073..a1c531fd2061 100644
>>> --- a/drivers/pci/controller/cadence/pcie-cadence.h
>>> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
>>> @@ -42,6 +42,137 @@ enum cdns_pcie_reg_bank {
>>>       REG_BANKS_MAX,
>>>   };
>>> +enum cdns_pcie_ltssm {
>>> +    CDNS_PCIE_LTSSM_DETECT_QUIET        = 0,
>>> +    CDNS_PCIE_LTSSM_DETECT_QUIET_ENTRY    = 1,
>>> +    CDNS_PCIE_LTSSM_DETECT_ACTIVE        = 2,
>>> +    CDNS_PCIE_LTSSM_DETECT_ACTIVE_1        = 3,
>>> +    CDNS_PCIE_LTSSM_DETECT_ACTIVE_2        = 4,
>>> +    CDNS_PCIE_LTSSM_DETECT_ACTIVE_3        = 5,
>>> +    CDNS_PCIE_LTSSM_RCVR_DETECTED_ST    = 6,
>>> +    CDNS_PCIE_LTSSM_RCVR_DETECTED_1        = 7,
>>> +    CDNS_PCIE_LTSSM_POLLING_ACTIVE        = 8,
>>> +    CDNS_PCIE_LTSSM_POLLING_ACTIVE_1    = 9,
>>> +    CDNS_PCIE_LTSSM_POLLING_ACTIVE_2    = 10,
>>> +    CDNS_PCIE_LTSSM_POLLING_ACTIVE_3    = 11,
>>> +    CDNS_PCIE_LTSSM_POLLING_COMPLIANCE    = 12,
>>> +    CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_1    = 13,
>>> +    CDNS_PCIE_LTSSM_POLLING_CONFIG        = 14,
>>> +    CDNS_PCIE_LTSSM_POLLING_CONFIG_1    = 15,
>>> +    CDNS_PCIE_LTSSM_POLLING_CONFIG_2    = 16,
>>> +    CDNS_PCIE_LTSSM_CONFIG_LW_START_RC    = 17,
>>> +    CDNS_PCIE_LTSSM_CONFIG_LW_START_RC_1    = 18,
>>> +    CDNS_PCIE_LTSSM_CONFIG_LW_START_RC_2    = 19,
>>> +    CDNS_PCIE_LTSSM_CONFIG_LW_ACC_RC    = 20,
>>> +    CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_RC    = 21,
>>> +    CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_RC_1 = 22,
>>> +    CDNS_PCIE_LTSSM_CONFIG_LANENUM_ACC_RC    = 23,
>>> +    CDNS_PCIE_LTSSM_CONFIG_LW_START_EP    = 24,
>>> +    CDNS_PCIE_LTSSM_CONFIG_LW_START_EP_1    = 25,
>>> +    CDNS_PCIE_LTSSM_CONFIG_LW_START_EP_2    = 26,
>>> +    CDNS_PCIE_LTSSM_CONFIG_LW_ACC_EP    = 27,
>>> +    CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_EP    = 28,
>>> +    CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_EP_1 = 29,
>>> +    CDNS_PCIE_LTSSM_CONFIG_LANENUM_ACC_EP    = 30,
>>> +    CDNS_PCIE_LTSSM_CONFIG_LANENUM_ACC_EP_1    = 31,
>>> +    CDNS_PCIE_LTSSM_DUMMY_STATE_1        = 32,
>>> +    CDNS_PCIE_LTSSM_CONFIG_COMPLETE        = 33,
>>> +    CDNS_PCIE_LTSSM_CONFIG_COMPLETE_1    = 34,
>>> +    CDNS_PCIE_LTSSM_CONFIG_COMPLETE_2    = 35,
>>> +    CDNS_PCIE_LTSSM_CONFIG_IDLE        = 36,
>>> +    CDNS_PCIE_LTSSM_CONFIG_IDLE_1        = 37,
>>> +    CDNS_PCIE_LTSSM_DUMMY_STATE_2        = 38,
>>> +    CDNS_PCIE_LTSSM_DUMMY_STATE_3        = 39,
>>> +    CDNS_PCIE_LTSSM_DUMMY_STATE_4        = 40,
>>> +    CDNS_PCIE_LTSSM_L0_STATE        = 41,
>>> +    CDNS_PCIE_LTSSM_RECOVERY_RCVR_LOCK    = 42,
>>> +    CDNS_PCIE_LTSSM_RECOVERY_RCVR_LOCK_1    = 43,
>>> +    CDNS_PCIE_LTSSM_RECOVERY_RCVR_CFG    = 44,
>>> +    CDNS_PCIE_LTSSM_RECOVERY_RCVR_CFG_1    = 45,
>>> +    CDNS_PCIE_LTSSM_RECOVERY_IDLE        = 46,
>>> +    CDNS_PCIE_LTSSM_RECOVERY_IDLE_1        = 47,
>>> +    CDNS_PCIE_LTSSM_DISABLE_LINK        = 48,
>>> +    CDNS_PCIE_LTSSM_DISABLE_LINK_1        = 49,
>>> +    CDNS_PCIE_LTSSM_DISABLE_LINK_2        = 50,
>>> +    CDNS_PCIE_LTSSM_DISABLE_LINK_3        = 51,
>>> +    CDNS_PCIE_LTSSM_DISABLE_LINK_4        = 52,
>>> +    CDNS_PCIE_LTSSM_DISABLE_LINK_5        = 53,
>>> +    CDNS_PCIE_LTSSM_DISABLE_LINK_6        = 54,
>>> +    CDNS_PCIE_LTSSM_DISABLE_LINK_7        = 55,
>>> +    CDNS_PCIE_LTSSM_HOT_RESET        = 56,
>>> +    CDNS_PCIE_LTSSM_HOT_RESET_1        = 57,
>>> +    CDNS_PCIE_LTSSM_HOT_RESET_2        = 58,
>>> +    CDNS_PCIE_LTSSM_HOT_RESET_3        = 59,
>>> +    CDNS_PCIE_LTSSM_L0S_ENTRY        = 60,
>>> +    CDNS_PCIE_LTSSM_L0S_1            = 61,
>>> +    CDNS_PCIE_LTSSM_L0S_2            = 62,
>>> +    CDNS_PCIE_LTSSM_L0S_3            = 63,
>>> +    CDNS_PCIE_LTSSM_L0S_4            = 64,
>>> +    CDNS_PCIE_LTSSM_L0S_5            = 65,
>>> +    CDNS_PCIE_LTSSM_WAIT_FOR_LINK_TX    = 66,
>>> +    CDNS_PCIE_LTSSM_TX_FTS_ENTRY        = 67,
>>> +    CDNS_PCIE_LTSSM_TX_FTS_1        = 68,
>>> +    CDNS_PCIE_LTSSM_TX_FTS_2        = 69,
>>> +    CDNS_PCIE_LTSSM_TX_ELEC_IDLE_ST        = 70,
>>> +    CDNS_PCIE_LTSSM_TX_ELEC_IDLE_1        = 71,
>>> +    CDNS_PCIE_LTSSM_TX_ELEC_IDLE_2        = 72,
>>> +    CDNS_PCIE_LTSSM_TX_ELEC_IDLE_3        = 73,
>>> +    CDNS_PCIE_LTSSM_RECOVERY_SPEED        = 74,
>>> +    CDNS_PCIE_LTSSM_RECOVERY_SPEED_1    = 75,
>>> +    CDNS_PCIE_LTSSM_RECOVERY_SPEED_2    = 76,
>>> +    CDNS_PCIE_LTSSM_RECOVERY_SPEED_3    = 77,
>>> +    CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23 = 78,
>>> +    CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_1 = 79,
>>> +    CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_2 = 80,
>>> +    CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_3 = 81,
>>> +    CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_4 = 82,
>>> +    CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_5 = 83,
>>> +    CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_6 = 84,
>>> +    CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_7 = 85,
>>> +    CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_8 = 86,
>>> +    CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_ENTRY    = 87,
>>> +    CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_ENTRY_FROM_RECOVERY = 88,
>>> +    CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_EXIT_1    = 89,
>>> +    CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_EXIT    = 90,
>>> +    CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_1    = 91,
>>> +    CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_2    = 92,
>>> +    CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_3    = 93,
>>> +    CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_4    = 94,
>>> +    CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_5    = 95,
>>> +    CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_ACTIVE    = 96,
>>> +    CDNS_PCIE_LTSSM_L1_ENTRY        = 97,
>>> +    CDNS_PCIE_LTSSM_L1_1            = 98,
>>> +    CDNS_PCIE_LTSSM_L1_2            = 99,
>>> +    CDNS_PCIE_LTSSM_L1_3            = 100,
>>> +    CDNS_PCIE_LTSSM_L1_4            = 101,
>>> +    CDNS_PCIE_LTSSM_L1_IDLE            = 102,
>>> +    CDNS_PCIE_LTSSM_L1_EXIT            = 103,
>>> +    CDNS_PCIE_LTSSM_L2_ENTRY        = 104,
>>> +    CDNS_PCIE_LTSSM_L2_1            = 105,
>>> +    CDNS_PCIE_LTSSM_L2_2            = 106,
>>> +    CDNS_PCIE_LTSSM_L2_3            = 107,
>>> +    CDNS_PCIE_LTSSM_L2_4            = 108,
>>> +    CDNS_PCIE_LTSSM_L2_5            = 109,
>>> +    CDNS_PCIE_LTSSM_L2_IDLE            = 110,
>>> +    CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY    = 111,
>>> +    CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_1    = 112,
>>> +    CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_2    = 113,
>>> +    CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_3    = 114,
>>> +    CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_4    = 115,
>>> +    CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_5    = 116,
>>> +    CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_FROM_RECOVERY = 117,
>>> +    CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ACTIVE    = 118,
>>> +    CDNS_PCIE_LTSSM_LOOPBACK_MASTER_EXIT    = 119,
>>> +    CDNS_PCIE_LTSSM_LOOPBACK_MASTER_EXIT_1    = 120,
>>> +    CDNS_PCIE_LTSSM_LOOPBACK_MASTER_EXIT_2    = 121,
>>> +    CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE0 = 122,
>>> +    CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE1 = 123,
>>> +    CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE2_1 = 124,
>>> +    CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE2_2 = 125,
>>> +    CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE3_1 = 126,
>>> +    CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE3_2 = 127,
>>> +};
>>
>> Hi Hans,
>>
>> The LTSSM state encoding in your patches do not align with the state 
>> encodings for LGA IP. TI SoCs have LGA IP of Cadence PCIe, and when I
>> applied your patches, the LTSSM value in the debugfs for the PCIe
>> subsystem (which have an EP connected to it) came out to be 0x10, which
>> points to the state "PCIE_L0". However, the debugfs prints the state as
>> "POLLING_CONFIG_2 (0x10)", which seems to be incorrect.
>>
>> The LTSSM state encodings for TI SoCs using Cadence PCIe IP is 
>> provided in the J7200 TRM section 12.2.3.4.14 at:
>> https://www.ti.com/lit/pdf/spruiu1
> 
> Hi Aksh,
> 
> Thank you for the information you provided. Could you please tell me how 
> to read this register? Then I will incorporate it into the next version.

The code to read the LTSSM state for LGA IPs in your patch:
```
reg = cdns_pcie_readl(pci, CDNS_PCIE_LM_BASE);
ltssm = FIELD_GET(CDNS_PCIE_LGA_LTSSM_STATUS_MASK, reg);
```
correctly reads the LTSSM state for TI SoCs which uses LGA IP.

> 
> Best regards,
> Hans
> 
>>
>> Regards,
>> Aksh Garg
>>
>>
>>> +
>>>   struct cdns_pcie_ops {
>>
> 

