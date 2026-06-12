Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA7A3A0B1D;
	Fri, 12 Jun 2026 09:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781256641; cv=fail; b=XN9rYXZg2KbVBePJiNsVoqhDQIzgtH8i2gP7KR2kR9Kjiqeo999moND4eZscOtFsZXqW3yeoin6vycVnQ3GI703CDRHRI6ZtqnmfZU9wTnEEg537PBd3U5xDEBl4h9nU3Zm73mC7hgRFa2UjMiTOSsU2Y0oczWc9RJ1992id/sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781256641; c=relaxed/simple;
	bh=2LIuG5vZr0nQI2voz6KesMnDHECdhjP1LLYYaNKR2go=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IUerf1VUlW8V42eOIUCyVXMLrjL1pZ8IDx/jg2WUTUf5JNSDuJy5QZLZ4+KzOiwX2ACURy36aTQ47nHA811Cwr7+4R5kn8uy088igEfu2rLGWkckgDmBOWMlTbSuOEc+Ets610a5wA2fAmQNo3C/uPhKKOJNyF4OmrZ3xIcRHYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Mh2B+oSM; arc=fail smtp.client-ip=52.101.52.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Mh2B+oSM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BeQlG0oz7OFHFxZ1noBbm1DnOAotbgWyta1O5v3lDwFKGHhzf/Fsqh03s4NC1W6P/DutPCzKQOMH4sV8NxJQEs2ftNZslFhNh+Vg+LSY0YBiNSUX8q5tp4r5QHtnLXNI25Sc//6mEoYaUc3/1IUIcrHBlxt6ol4gLJ+Qk+Qvfm//sXeQ6KzWjj+DqM5nwvK/GlYuBlEUiJgJtcBYp+JBHaovjzFSRnYflRbfFc2gxkrNBLwyk05GHGK21iAQYp5KrTCDcfBPRa716iDMbqgV8UAkXuJ2Ghe0RMSBrlKZBLPu4pTYXRdQQMsLJ2Zt70B+sMBpEir+xwTp6d4F3nt0yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egGhdVD7aDifg9XzPL+QYYZq0ZaiWOwQfHoxnScbCEs=;
 b=uK5BFruiWDjh7ZdL8trDYmxxCMGq5VK0i7XqvCLMmCF876ibNzNZ/8riiEWepCD/0LsTpPzn9mtsY1hJ6ygViBO5Jlx0+f6F2ki0UeM+/watrpi9RMeTU6gJa/MNS9kErS7NAA3FXoooFxf4uybFWDG6mgv79PdBzahcjFcJoq8PwLW7zWaQdJpScDFuvt8d4QLMTvkRI+MlbLttpzti/lym8kW5l1k/quYGIzKJ6XFoKIdMmI0osoL+GhXhRMie/8G7xiYTdnq8sPKF041a2lSfT9/wJHE09uHt4cOO5dEeq7BAtH+VKpJpvu2EpSv4x4/2WxvyEW/3UIQ5jVfveQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egGhdVD7aDifg9XzPL+QYYZq0ZaiWOwQfHoxnScbCEs=;
 b=Mh2B+oSMkJnu9Dp+ZJeGVZQ515BO1fkrgbOq3znaX6ntzdEizMelPaQ/XD7u9rtxRoKuL7D9OtVpQKnLNOTS5eTtT9V3M7h/9j6Sa85nZa+NrWlG+1s9t5XYKoJ7cAG1/a3pzL7QvADj5FQ9vTZHmlir8ozSetY46fimlpX9p00=
Received: from BL1PR13CA0403.namprd13.prod.outlook.com (2603:10b6:208:2c2::18)
 by DS7PR10MB5949.namprd10.prod.outlook.com (2603:10b6:8:86::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.14; Fri, 12 Jun 2026 09:30:37 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:208:2c2:cafe::f) by BL1PR13CA0403.outlook.office365.com
 (2603:10b6:208:2c2::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.15 via Frontend Transport; Fri,
 12 Jun 2026 09:30:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 09:30:36 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 12 Jun
 2026 04:30:36 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 12 Jun
 2026 04:30:35 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 12 Jun 2026 04:30:35 -0500
Received: from [10.24.68.129] (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65C9UWL33215381;
	Fri, 12 Jun 2026 04:30:33 -0500
Message-ID: <d0feedff-b0f6-4a1a-a9df-fae9e2d58abd@ti.com>
Date: Fri, 12 Jun 2026 15:00:32 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] PCI: cadence: Add LTSSM debugfs
To: Hans Zhang <18255117159@163.com>, <bhelgaas@google.com>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>
CC: <robh@kernel.org>, <mpillai@cadence.com>, <s-vadapalli@ti.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260611165933.20071-1-18255117159@163.com>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <20260611165933.20071-1-18255117159@163.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|DS7PR10MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ecdc8c1-d0aa-41c2-5472-08dec865429a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Sw55LqCy3ysunrl7BebzKJtHTuOCkkt5rntPah+uo78VuiaHGZY+Dy3kwTTfCTZLVb0wgiB/M+jo4sU3H6dhRKDhiAU5PJjt0sUHaWyt3+JMyc2YCmsCkz7EqTNdNu3FcthE2VAnsopl6wXbceil2BoYvHEAfxMYRzNe+H+Bmtq9F7OyFOUf/T4XA91y/T+8T+5w9eWH1UN/X3AH1ttJDyQuriAf8LlDKxlkRlLvC/04Fz5Of1UulQ3aH5bc0wybX+uGblNZIARAXHc+XRlk8ylndMzCnEeUCfQSArO31THiY+y2fx9hx+QuCZjZ4tfARwQs6vFfy4vb3BMeCjud+7P1lGJxCRqwOWxs0FFahrIQWGaQ80dvLdxXA+E6NhoUm9zav3XsP16aOonczVTGY3frMLiYQLT6OSA9vTQpvmJ9AXrs9kBcMaQZCYgzYSoZM2deKVWAyldpoceXScXfVVZvTHfdaz2NMTq3ynryxEFZ8T5lt9GqqenSGVvIax4NPkok1jb7TMke+O9mmD0JKMKO/jHN35jA5n2v6SBzTwGQUDNd/boyzaCD/CLTWDlXqD/mrH3M5VJgNgRO8ulIGDbZuYqZvq7SBnMh2AA4+WaC9IP/UuV8+3lZ0Rm0fL//9NY4QnW7udvYGb3iI+67wd9g2uvX81juMHz8F6SaW3q+DfFOG2lcQCEMfyNhlni/ET6g6m+BSLbb3f7TE6OQ19nDcUgPcPrF24igmJi8AQI=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FJjUxkHxpjY83SSbvyyP9fZIEQCHJllDQL38upvBqFgod2qcZxVkNX5Y5LlmBwWfbZW6dK5zldpbXk+d+h+yyUiBxUOKkHluRtF9XJU4IATFBojJPGpy7mwlD1orWhrbMhCIrLJaIHEzkbfzkzmZoMTcnexJpVuKsQjsvrELULBfnKCJi21MMsYPLE7BGg3Q7Np8dwZIkeZiEm9F77WjP9M1x8CCecWP/Zr9rf+FSuU6XQ21ER31YFAHre6Er9LZICJKXtSeaNlBWzLdFXRMQUbTukCBofdpz0ivX6TV/QB3VA7lLncqEhvqyMqexJ/aGsSyG5jftO9DRbZGaw9pPqgFB0xmBcDcv1cYUu6aGmVPkLn9ZLUiuRJBWBvp2LDLxNSUZv3BwxsUK8M9coLPtEmn4GUIylTmzBP1Hgm7PxnwbRlqbmJ0GALs+ExhGhzj
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 09:30:36.6594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ecdc8c1-d0aa-41c2-5472-08dec865429a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5949



On 11/06/26 22:29, Hans Zhang wrote:
> Hi,
> 
> This series adds debugfs support to the Cadence PCIe controller driver,
> allowing users to read the current LTSSM state of the link for debugging
> purposes.
> 
> Patch 1 introduces a new flag 'is_hpa' in the cdns_pcie structure to
> distinguish HPA (High Performance Architecture) IP platforms from LGA
> (Legacy Architecture) IP platforms, as they have different register
> layouts for LTSSM status.
> 
> Patch 2 implements the debugfs file "ltssm_status" for HPA IP under a
> per-device directory. It reads the LTSSM state from the appropriate
> hardware register based on the 'is_hpa' flag and displays both a
> descriptive string and the raw value.
> 
> Patch 3 adds LTSSM debugfs support for LGA IP, utilizing a new callback
> 'get_lga_ltssm' in cdns_pcie_ops to read the LTSSM state from the LGA
> register. The debugfs interface now supports both IP types seamlessly.
> 
> =====================
> Test:
> root@orangepi6plus:~# ls -l /sys/kernel/debug/cdns_pcie_a0*
> /sys/kernel/debug/cdns_pcie_a010000.pcie:
> total 0
> -r--r--r-- 1 root root 0 Jan  1  1970 ltssm_status
> 
> /sys/kernel/debug/cdns_pcie_a0c0000.pcie:
> total 0
> -r--r--r-- 1 root root 0 Jan  1  1970 ltssm_status
> 
> /sys/kernel/debug/cdns_pcie_a0e0000.pcie:
> total 0
> -r--r--r-- 1 root root 0 Jan  1  1970 ltssm_status
> root@orangepi6plus:~#
> root@orangepi6plus:~#
> root@orangepi6plus:~# cat /sys/kernel/debug/cdns_pcie_a0*/ltss*
> L0_STATE (0x29)
> L0_STATE (0x29)
> L0_STATE (0x29)
> root@orangepi6plus:~#
> root@orangepi6plus:~# uname -a
> Linux orangepi6plus 7.1.0-rc3-00007-ge3963f3f4e31 #62 SMP PREEMPT Tue May 19 20:28:24 CST 2026 aarch64 aarch64 aarch64 GNUx
> =====================
> 
> ---

Hi,

I have tested the series for LGA IP:

Tested-by: Aksh Garg <a-garg7@ti.com>

Regards,
Aksh Garg


