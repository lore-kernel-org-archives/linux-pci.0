Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010047.outbound.protection.outlook.com [52.101.193.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34513876A7;
	Wed, 13 May 2026 08:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661285; cv=fail; b=mL1P5kuEK98zyfsv6ZkzNBZIGdK0s9s7RYgFy/zprhnBnV2oZ308YJNGiMIb1hyH0wWLr82krDsMEwXxI8C0JmQ/b42ZiEiMvmSwfciVWimInCRod+fLymdZkCA3ZICLk77YYV3dKlsEzVoGwU5+zgxkLYgtTBImTRU1nFmrVWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661285; c=relaxed/simple;
	bh=MR0Ej4Iy6Z1KwlBi++IgCcLmKRDy7zocQmBOOiCjiPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bFDjvmHibPXYG5BHkWtfry4a7ZSfLEgQZ92OP3YqBvVR1E5/fvv0XRM5jlF8FN38NCCE2JMKKJDTt6iDDrh3r/hD8twe/UgCVLtBhkBd00s46AbOxJIwUqLNq1wfumX0qKJWbm0phklDdM75GHaQZ/2G6H6HJa2EVQZoF9T4Q9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ORS7mkUu; arc=fail smtp.client-ip=52.101.193.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ORS7mkUu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqZSWS2c5G5CtzR7sebfiR29YVWpuqS8xXXmwp6B0UqwLQ4yM3Pt/brGwsu0kA1OS+JTDDd3Zc1j2uLPRvCnSxmf9B34bQg0584jzzDI0NyCj7CivfLQC7DEyMILPaMc/3cCYDfPtbU8nsrfIqswfeSW78DCO6AmQmt4nmJlX+5tTv7ckIpAkIinwkizDxtKkQdaXOS4QdaWZBFmg87cFI8nrQnQ/7aRMKCnZt9zvz7UBkC989qgNLATWUUMVv1jvstVKeeEI5+ok567KJnR6UhiLFyHkqTIt/kqrbVV+jMbNhRGI/lNDojUy3p0Ac9Fn6KghJ7h2fdvUAhuIWvezA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIQXHfSNgespriHzEZvgkSnRtOWOz1tqPwDfieuyo7E=;
 b=ufEetJ20tZ4kv5OYjX7heR1rYmWOt6LnFpRak+ALLwRpJeJoJNJUtttB9sVQ2NLzjPYTH/hXMuSXlvJs832y+MQJRCEI4g5FYsUlPYaH/rLepFjhnH2k4YdDbdmFgtVNkBJheR6yeOCdEgHSA8oWxKKsmExxYwN8itxTB17TwbDu4pjlRzaxWcaA3i6uAPEaE1a4i1VcddmqwkLDzyjveKDkJ4hSFqBVEGoWU4bzkL6C3TDMF5PKg5b+LUuTBrPKKffAXDum+OwLmMYahNa936WSxDRlGZu6izyrfD7hNEJYKEois45MlT2to3Aj7lmYLeAOX5BY565NK5PU5lqjcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIQXHfSNgespriHzEZvgkSnRtOWOz1tqPwDfieuyo7E=;
 b=ORS7mkUu9wHkcUX+lqX79Io2c2CjqlrpJeS5Z+PFEgdl61bSxfq9xuOHu2MEuZMXFUo7zTAhOE2nU5bPRLUrDkVB/DDVey9ArJQQfhhDDVPsoaBR7RbKlJDx4wXfIx07lL9akDABaSLFnR1SdnsOa5ciXUp035VjuNj506xuy6A=
Received: from SJ0PR05CA0126.namprd05.prod.outlook.com (2603:10b6:a03:33d::11)
 by IA4PR10MB8397.namprd10.prod.outlook.com (2603:10b6:208:566::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Wed, 13 May
 2026 08:34:36 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:33d:cafe::43) by SJ0PR05CA0126.outlook.office365.com
 (2603:10b6:a03:33d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.14 via Frontend Transport; Wed, 13
 May 2026 08:34:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 08:34:35 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 03:34:30 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 03:34:30 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 13 May 2026 03:34:30 -0500
Received: from [10.24.68.129] (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64D8YQaT3331280;
	Wed, 13 May 2026 03:34:27 -0500
Message-ID: <f8ada2e3-15c2-43b1-b013-2f3fd263f25f@ti.com>
Date: Wed, 13 May 2026 14:04:26 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] PCI: cadence: Add debugfs property to provide
 LTSSM status of the PCIe link
To: Manikandan Karunakaran Pillai <mpillai@cadence.com>, Hans Zhang
	<18255117159@163.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"hans.zhang@cixtech.com" <hans.zhang@cixtech.com>
CC: "robh@kernel.org" <robh@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>
References: <20260508034101.1910036-1-18255117159@163.com>
 <20260508034101.1910036-3-18255117159@163.com>
 <3ab81da4-a745-4e85-8aa3-3a217e3fdcbe@ti.com>
 <BY5PR07MB6705FFD54E7D97EF5AB0A211A2062@BY5PR07MB6705.namprd07.prod.outlook.com>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <BY5PR07MB6705FFD54E7D97EF5AB0A211A2062@BY5PR07MB6705.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|IA4PR10MB8397:EE_
X-MS-Office365-Filtering-Correlation-Id: 90815a01-1808-4134-4bd8-08deb0ca7690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	g8wSKR3mZz4cyJMA9RP3i1JoADaD/m+0oCSQyUBYctLhp087uqj8EUkfFwiaae3V81d/Gp3wDZW5USACW5Ro3BrqpU5boD85Pp9wcesxb3iOUFETZmGSo50RynTI2EeZqZAzJKUhbLArj/d3tmZ/iSLq6MzqAK/aESIL8xn1bdKt0nexvw66x2+Bbr9x8BUeVKxxJUjYJAdId9AxawPtfuaMoNU5xyAHa5q8Ld4xsUQwhbE3rjsbedW9Zu76/HeJ1bXLAPa1XYe07l3vIqItCrS98xwqUUePasDbbjpAHT4fm4jlARD/OEaha74fR8hTm8RNiY/FNPZppl1c+o6Blnzf3gtidCzF4mllANHRAGAk0DcJ/pqxOX25/kmUGOFkfa8UjevQqcDUsJbswGowizXM5N3voPfkmFSHFXWZE1Nn6HgynJhRTJfIgD9FZuZvnFB7XryxNKiJtqrFJP/ntH8enwobi/vR2/V6Vsq0ghyHr50pL4DuC8TpE8k0I3xHq6zHaC6KduehYsycc/5gbqG03XN1ifsex1VM6c25htj097RaV9d8/W1R/YLtyn9ODe2Za+sKIGl/5b0z5P3MUAPd9S+c6j8rU6zslgJKipY6RdT3h/FmeKmgSfCIP4LyA/uq3NE2OoGJo1z6ob+xn8oKjoxzp5RVR3EztpG3HXpJBM2I948wA4B0s516aQ+gyz35JqO+eGGU2ptq7NLL9Wf7Rddjgv7F3FNHbLRfuq8=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IEQIdISh1XaNhHtzwdd26Soq22/KZgYKZH+f1lxJ9ZuL1xmMkmwLVM/6afwZO+n026YMYFo5m0NkKAIh//Yd1KBM5G7m8e21dDQrs8xMnQhcqPTnj6IoVWJz3zxk40XWMsNbse2CoOArIC6bTDQ5lZlFNbz5K1Vx2lWjOQw3Pecg/LJWuRCEV7bwyHIDDkUMOkqtY4U6yhbOJBvlO/lp62KaMOGmHOHy+ryKTZ1P8KtI2j1zVtCZ6AnACoEF0NaXZiXrGN7ppas2vE4Z4F7RpFSJrAODvJQYPmgUt3GBsxTjkkl/Jnk0iZIFoG6Sz+R0YAcM7ant/vbqDnAWJfv4irYN/PY59b0uXn+X48GeL2G6q6XWTfxJ6qNfIAs6FzZ3QKEt2gkqik/pJGj6Juj8OkZdpaJ7++FFwZ+H4MFDPJfjpwCPQ4BJyWQyzNZlJ0PW
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 08:34:35.0978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90815a01-1808-4134-4bd8-08deb0ca7690
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8397



On 13/05/26 11:41, Manikandan Karunakaran Pillai wrote:
>> On 08/05/26 09:11, Hans Zhang wrote:
>>> Add the debugfs property to provide a view of the current link's LTSSM
>>> status from the Root Port device.
>>>
>>> Test example:
>>>     # cat /sys/kernel/debug/cdns_pcie_a0c0000.pcie/ltssm_status
>>>     L0_STATE (0x29)
>>>
>>> Signed-off-by: Hans Zhang <18255117159@163.com>
>>> ---
>>>    Documentation/ABI/testing/debugfs-cdns-pcie   |   5 +
>>>    drivers/pci/controller/cadence/Kconfig        |   9 +
>>>    drivers/pci/controller/cadence/Makefile       |   1 +
>>>    drivers/pci/controller/cadence/pci-sky1.c     |   3 +
>>>    .../controller/cadence/pcie-cadence-debugfs.c | 208 ++++++++++++++++++
>>>    .../pci/controller/cadence/pcie-cadence-ep.c  |   3 +
>>>    .../cadence/pcie-cadence-host-hpa.c           |  20 +-
>>>    .../controller/cadence/pcie-cadence-host.c    |   9 +-
>>>    drivers/pci/controller/cadence/pcie-cadence.h | 150 +++++++++++++
>>>    9 files changed, 406 insertions(+), 2 deletions(-)
>>>    create mode 100644 Documentation/ABI/testing/debugfs-cdns-pcie
>>>    create mode 100644 drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>>>
>>> diff --git a/Documentation/ABI/testing/debugfs-cdns-pcie
>> b/Documentation/ABI/testing/debugfs-cdns-pcie
>>> new file mode 100644
>>> index 000000000000..659ad2ab70e4
>>> --- /dev/null
>>> +++ b/Documentation/ABI/testing/debugfs-cdns-pcie
>>> @@ -0,0 +1,5 @@
>>> +What:		/sys/kernel/debug/cdns_pcie_<dev>/ltssm_status
>>> +Date:		March 2026
>>> +Contact:	Hans Zhang <18255117159@163.com>
>>> +Description:	(RO) Read will return the current PCIe LTSSM state in both
>>> +		string and raw value.
>>> diff --git a/drivers/pci/controller/cadence/Kconfig
>> b/drivers/pci/controller/cadence/Kconfig
>>> index 9e651d545973..cb010bc97aad 100644
>>> --- a/drivers/pci/controller/cadence/Kconfig
>>> +++ b/drivers/pci/controller/cadence/Kconfig
>>> @@ -6,6 +6,15 @@ menu "Cadence-based PCIe controllers"
>>>    config PCIE_CADENCE
>>>    	tristate
>>>
>>> +config PCIE_CADENCE_DEBUGFS
>>> +	tristate "Cadence PCIe debugfs entries"
>>> +	depends on DEBUG_FS
>>> +	depends on PCIE_CADENCE_HOST || PCIE_CADENCE_EP
>>> +	help
>>> +	  Say Y here to enable debugfs entries for the PCIe controller. These
>>> +	  entries provide various debug features related to the controller and
>>> +	  the LTSSM status of link can be displayed.
>>> +
>>>    config PCIE_CADENCE_HOST
>>>    	tristate
>>>    	depends on OF
>>
>> [...]
>>
>>>
>>> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h
>> b/drivers/pci/controller/cadence/pcie-cadence.h
>>> index 9a464cbaf073..a1c531fd2061 100644
>>> --- a/drivers/pci/controller/cadence/pcie-cadence.h
>>> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
>>> @@ -42,6 +42,137 @@ enum cdns_pcie_reg_bank {
>>>    	REG_BANKS_MAX,
>>>    };
>>>
>>> +enum cdns_pcie_ltssm {
>>> +	CDNS_PCIE_LTSSM_DETECT_QUIET		= 0,
>>> +	CDNS_PCIE_LTSSM_DETECT_QUIET_ENTRY	= 1,
>>> +	CDNS_PCIE_LTSSM_DETECT_ACTIVE		= 2,
>>> +	CDNS_PCIE_LTSSM_DETECT_ACTIVE_1		= 3,
>>> +	CDNS_PCIE_LTSSM_DETECT_ACTIVE_2		= 4,
>>> +	CDNS_PCIE_LTSSM_DETECT_ACTIVE_3		= 5,
>>> +	CDNS_PCIE_LTSSM_RCVR_DETECTED_ST	= 6,
>>> +	CDNS_PCIE_LTSSM_RCVR_DETECTED_1		= 7,
>>> +	CDNS_PCIE_LTSSM_POLLING_ACTIVE		= 8,
>>> +	CDNS_PCIE_LTSSM_POLLING_ACTIVE_1	= 9,
>>> +	CDNS_PCIE_LTSSM_POLLING_ACTIVE_2	= 10,
>>> +	CDNS_PCIE_LTSSM_POLLING_ACTIVE_3	= 11,
>>> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE	= 12,
>>> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_1	= 13,
>>> +	CDNS_PCIE_LTSSM_POLLING_CONFIG		= 14,
>>> +	CDNS_PCIE_LTSSM_POLLING_CONFIG_1	= 15,
>>> +	CDNS_PCIE_LTSSM_POLLING_CONFIG_2	= 16,
>>> +	CDNS_PCIE_LTSSM_CONFIG_LW_START_RC	= 17,
>>> +	CDNS_PCIE_LTSSM_CONFIG_LW_START_RC_1	= 18,
>>> +	CDNS_PCIE_LTSSM_CONFIG_LW_START_RC_2	= 19,
>>> +	CDNS_PCIE_LTSSM_CONFIG_LW_ACC_RC	= 20,
>>> +	CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_RC	= 21,
>>> +	CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_RC_1 = 22,
>>> +	CDNS_PCIE_LTSSM_CONFIG_LANENUM_ACC_RC	= 23,
>>> +	CDNS_PCIE_LTSSM_CONFIG_LW_START_EP	= 24,
>>> +	CDNS_PCIE_LTSSM_CONFIG_LW_START_EP_1	= 25,
>>> +	CDNS_PCIE_LTSSM_CONFIG_LW_START_EP_2	= 26,
>>> +	CDNS_PCIE_LTSSM_CONFIG_LW_ACC_EP	= 27,
>>> +	CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_EP	= 28,
>>> +	CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_EP_1 = 29,
>>> +	CDNS_PCIE_LTSSM_CONFIG_LANENUM_ACC_EP	= 30,
>>> +	CDNS_PCIE_LTSSM_CONFIG_LANENUM_ACC_EP_1	= 31,
>>> +	CDNS_PCIE_LTSSM_DUMMY_STATE_1		= 32,
>>> +	CDNS_PCIE_LTSSM_CONFIG_COMPLETE		= 33,
>>> +	CDNS_PCIE_LTSSM_CONFIG_COMPLETE_1	= 34,
>>> +	CDNS_PCIE_LTSSM_CONFIG_COMPLETE_2	= 35,
>>> +	CDNS_PCIE_LTSSM_CONFIG_IDLE		= 36,
>>> +	CDNS_PCIE_LTSSM_CONFIG_IDLE_1		= 37,
>>> +	CDNS_PCIE_LTSSM_DUMMY_STATE_2		= 38,
>>> +	CDNS_PCIE_LTSSM_DUMMY_STATE_3		= 39,
>>> +	CDNS_PCIE_LTSSM_DUMMY_STATE_4		= 40,
>>> +	CDNS_PCIE_LTSSM_L0_STATE		= 41,
>>> +	CDNS_PCIE_LTSSM_RECOVERY_RCVR_LOCK	= 42,
>>> +	CDNS_PCIE_LTSSM_RECOVERY_RCVR_LOCK_1	= 43,
>>> +	CDNS_PCIE_LTSSM_RECOVERY_RCVR_CFG	= 44,
>>> +	CDNS_PCIE_LTSSM_RECOVERY_RCVR_CFG_1	= 45,
>>> +	CDNS_PCIE_LTSSM_RECOVERY_IDLE		= 46,
>>> +	CDNS_PCIE_LTSSM_RECOVERY_IDLE_1		= 47,
>>> +	CDNS_PCIE_LTSSM_DISABLE_LINK		= 48,
>>> +	CDNS_PCIE_LTSSM_DISABLE_LINK_1		= 49,
>>> +	CDNS_PCIE_LTSSM_DISABLE_LINK_2		= 50,
>>> +	CDNS_PCIE_LTSSM_DISABLE_LINK_3		= 51,
>>> +	CDNS_PCIE_LTSSM_DISABLE_LINK_4		= 52,
>>> +	CDNS_PCIE_LTSSM_DISABLE_LINK_5		= 53,
>>> +	CDNS_PCIE_LTSSM_DISABLE_LINK_6		= 54,
>>> +	CDNS_PCIE_LTSSM_DISABLE_LINK_7		= 55,
>>> +	CDNS_PCIE_LTSSM_HOT_RESET		= 56,
>>> +	CDNS_PCIE_LTSSM_HOT_RESET_1		= 57,
>>> +	CDNS_PCIE_LTSSM_HOT_RESET_2		= 58,
>>> +	CDNS_PCIE_LTSSM_HOT_RESET_3		= 59,
>>> +	CDNS_PCIE_LTSSM_L0S_ENTRY		= 60,
>>> +	CDNS_PCIE_LTSSM_L0S_1			= 61,
>>> +	CDNS_PCIE_LTSSM_L0S_2			= 62,
>>> +	CDNS_PCIE_LTSSM_L0S_3			= 63,
>>> +	CDNS_PCIE_LTSSM_L0S_4			= 64,
>>> +	CDNS_PCIE_LTSSM_L0S_5			= 65,
>>> +	CDNS_PCIE_LTSSM_WAIT_FOR_LINK_TX	= 66,
>>> +	CDNS_PCIE_LTSSM_TX_FTS_ENTRY		= 67,
>>> +	CDNS_PCIE_LTSSM_TX_FTS_1		= 68,
>>> +	CDNS_PCIE_LTSSM_TX_FTS_2		= 69,
>>> +	CDNS_PCIE_LTSSM_TX_ELEC_IDLE_ST		= 70,
>>> +	CDNS_PCIE_LTSSM_TX_ELEC_IDLE_1		= 71,
>>> +	CDNS_PCIE_LTSSM_TX_ELEC_IDLE_2		= 72,
>>> +	CDNS_PCIE_LTSSM_TX_ELEC_IDLE_3		= 73,
>>> +	CDNS_PCIE_LTSSM_RECOVERY_SPEED		= 74,
>>> +	CDNS_PCIE_LTSSM_RECOVERY_SPEED_1	= 75,
>>> +	CDNS_PCIE_LTSSM_RECOVERY_SPEED_2	= 76,
>>> +	CDNS_PCIE_LTSSM_RECOVERY_SPEED_3	= 77,
>>> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23 = 78,
>>> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_1 = 79,
>>> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_2 = 80,
>>> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_3 = 81,
>>> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_4 = 82,
>>> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_5 = 83,
>>> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_6 = 84,
>>> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_7 = 85,
>>> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_8 = 86,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_ENTRY	= 87,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_ENTRY_FROM_RECOVERY = 88,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_EXIT_1	= 89,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_EXIT	= 90,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_1	= 91,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_2	= 92,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_3	= 93,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_4	= 94,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_5	= 95,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_ACTIVE	= 96,
>>> +	CDNS_PCIE_LTSSM_L1_ENTRY		= 97,
>>> +	CDNS_PCIE_LTSSM_L1_1			= 98,
>>> +	CDNS_PCIE_LTSSM_L1_2			= 99,
>>> +	CDNS_PCIE_LTSSM_L1_3			= 100,
>>> +	CDNS_PCIE_LTSSM_L1_4			= 101,
>>> +	CDNS_PCIE_LTSSM_L1_IDLE			= 102,
>>> +	CDNS_PCIE_LTSSM_L1_EXIT			= 103,
>>> +	CDNS_PCIE_LTSSM_L2_ENTRY		= 104,
>>> +	CDNS_PCIE_LTSSM_L2_1			= 105,
>>> +	CDNS_PCIE_LTSSM_L2_2			= 106,
>>> +	CDNS_PCIE_LTSSM_L2_3			= 107,
>>> +	CDNS_PCIE_LTSSM_L2_4			= 108,
>>> +	CDNS_PCIE_LTSSM_L2_5			= 109,
>>> +	CDNS_PCIE_LTSSM_L2_IDLE			= 110,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY	= 111,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_1	= 112,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_2	= 113,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_3	= 114,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_4	= 115,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_5	= 116,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_FROM_RECOVERY =
>> 117,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ACTIVE	= 118,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_EXIT	= 119,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_EXIT_1	= 120,
>>> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_EXIT_2	= 121,
>>> +	CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE0 = 122,
>>> +	CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE1 = 123,
>>> +	CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE2_1 = 124,
>>> +	CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE2_2 = 125,
>>> +	CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE3_1 = 126,
>>> +	CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE3_2 = 127,
>>> +};
>>
> 
> The above LTSSM states are internal LTSSM encoding states and may not be available for software to use.
> The LTSSM states in the document pointed by Aksh (TI Soc) are the states  available in all cadence controllers.

Is this true for HPA IPs as well? The test performed by Hans:
root@orangepi6plus:~# cat /sys/kernel/debug/cdns_pcie_a0*/ltss*
L0_STATE (0x29)
L0_STATE (0x29)
L0_STATE (0x29)

This implies that the L0_STATE LTSSM state is mapped to 0x29 (41) there,
which according to your response is internal LTSSM encoding, and hence
the register read should have resulted in 0x10 instead of 0x29.


> 
>> Hi Hans,
>>
>> The LTSSM state encoding in your patches do not align with the state
>> encodings for LGA IP. TI SoCs have LGA IP of Cadence PCIe, and when I
>> applied your patches, the LTSSM value in the debugfs for the PCIe
>> subsystem (which have an EP connected to it) came out to be 0x10, which
>> points to the state "PCIE_L0". However, the debugfs prints the state as
>> "POLLING_CONFIG_2 (0x10)", which seems to be incorrect.
>>
>> The LTSSM state encodings for TI SoCs using Cadence PCIe IP is provided
>> in the J7200 TRM section 12.2.3.4.14 at:
>> https://urldefense.com/v3/__https://www.ti.com/lit/pdf/spruiu1__;!!EHscmS1
>> ygiU1lA!AudWpZJoYT3_nfvc33jiZrUFh75KB4DU-
>> na_9SNZTib3etI9BNC3Jq8RlPxVouCPY2Rt7SyqrNI$
>>
>> Regards,
>> Aksh Garg
>>
>>
>>> +
>>>    struct cdns_pcie_ops {
>>
> 

