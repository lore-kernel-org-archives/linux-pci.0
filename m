Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013067.outbound.protection.outlook.com [40.93.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B7A3655F1;
	Wed, 13 May 2026 05:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778649961; cv=fail; b=nAaAatVVuU5Cli0Au5sD125kSXxexvFSg1/Bpe69XzVbhhIHpA24531TuAQt1Oq/A/1Xc8nwigdef6+3kYeiZOOjwzm2p99P2BUHDZUrpMk5DcQtImtw8eFVXm3nJczkjKrZ7GKCzCpIJu6hnKok55u9TkuIGBpoStrVc/d+IPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778649961; c=relaxed/simple;
	bh=YW+bM/4y9ICwC9yUNM3vE96saDXFBXT3PZmp0SLDiFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QB53aoWG7b1jRo7chDfTU/ljJ9KlLai0wFo3s4vl98iYScPdJ3ppk/0HzVG46Q4rrHRo8yjhf3p5BvcwKy69Rm/NtYkb5f0ahwDavRHd6B2/6gHu8FXtwD0JwVHDZb5JJEPRt+riV+LCEohbLMZ5ayZbkpBlHlOcKLT89VkJnWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JEIV2s51; arc=fail smtp.client-ip=40.93.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JEIV2s51"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8HQbswHUuEhNpHLVxe7KBycKvE+XRQ6wUqOM9/hxZ0R35L0pOnJsYwpz2ysXwOcDEhjWkbLC1I6q/VPqZ7ielvz8ffleJSWZzJr0bbkyVMja0MNRUU5ouHvN59aQXsum19BEA7F3yP5IxsfV+DIZuiG7ZbrxSdBsWt3YetXmsHGONXltYLCkCGwE4cSGXC1UaSaHVS0bcKCYukWJU7z8EZ6Yn3nsbjtSMg/79zsv7vA7WhQkDO6y7MrD8oF2aUA3czhm/0KRthwjmMXx15JZd2BkTs8VIoHuk3qlo9WisRYATIoy6Im/kFS38UokXusOYTd0oQv8XnVXqpJDzfYvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIu5iGyDPmMXCutew2jsT0c9RACB3QlgDaxYtJVeMV4=;
 b=sU2aBGhOat1cnM38at9eJFPL3j3oKC7Oq7uNFAdrhWTpjKmUONd6qjrPVGI8zTH8jrHMPywrroyp0XDjfWvBVcmn6L318g6gluGTejjcFLCZvCSZhpXF/ZgiCG0xNesO3y2eL8EM9YpnwfoJoX1vtWfsTQjVJiTDUdsvoX90DByNp50Z0Y2t3OgfiJiAFEt6GgVMF7qMARtFzAyQsU2Z1BTsY0ynZfsri3sozvSlSOL4ZAswyViDIw27HK+P7cmJKXuL3OniXpOsPSakUb54rSGcpjhyC3t3jMZJLOrv5KSyxB2Nq/W9N6qHJ3WtjldMJ7SWItwIOS5hgPDxSUgsbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIu5iGyDPmMXCutew2jsT0c9RACB3QlgDaxYtJVeMV4=;
 b=JEIV2s51Sz+6Xbq0NzC4FRQ+9VFjJFdtV3nuBosGgd9PsmdHiu2aeNTEZLG+sy3pLZTiPPYvXgMuZQsunuE76rWq9thFlJj9c+Z7P50ykjvV4/DaY8o52ZR2zfC3PbwDoFb93+0tln1weXIEoe9idVrenUGGE7cH7bhtNK+gLXE=
Received: from BL1PR13CA0196.namprd13.prod.outlook.com (2603:10b6:208:2be::21)
 by SJ0PR10MB4463.namprd10.prod.outlook.com (2603:10b6:a03:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Wed, 13 May
 2026 05:23:56 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::28) by BL1PR13CA0196.outlook.office365.com
 (2603:10b6:208:2be::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.17 via Frontend Transport; Wed, 13
 May 2026 05:23:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 05:23:55 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 00:23:55 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 00:23:55 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 13 May 2026 00:23:55 -0500
Received: from [10.24.68.129] (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64D5NpCY3370605;
	Wed, 13 May 2026 00:23:52 -0500
Message-ID: <3ab81da4-a745-4e85-8aa3-3a217e3fdcbe@ti.com>
Date: Wed, 13 May 2026 10:53:50 +0530
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
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <20260508034101.1910036-3-18255117159@163.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|SJ0PR10MB4463:EE_
X-MS-Office365-Filtering-Correlation-Id: 217e162d-760f-4c6b-ea80-08deb0afd429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	zbXueZWCEyPkKHutDhulFFWlox6XLo9U6L8rjY5AI9QbV2Cr2cCgNXjXOWgiYqTK5A/I9fufsKbrVyq/6w+G7JWKuODbox/FbuPPfbyg0+h6FJJbWg7dY8F/TXRCQIqIggVHLvFi9QRT93HjqUSPM13aAPi4AJrYVhrSrkATxyJw08BjuudSHfzTiWCTtHJCLackdsqCBjpQ90VraWQBwdxRWWVZXKxWPxuVSvhEni8F8DNpFOcKJ5xGYgaRsvMcZtFvxKve2MZ5Z9loMuX2wr7AhkjoKFgoQYS/+INJOY2FMlkPzwBqPGYL0aXO8SgJ5EiSOQ1Xp9OajEE+4Q9hGZ2C4Oxq148c/vMHKIWZZe8ES+Tx++UayPuaNX+sZm9LZbkFT+7VYPEYrk5EegpLg7LRxT+rt3KP9H+Po1hIyOQA9LcSSXiqFDSGSvmnB85oHomtyxchSvWy1BbIp+uJepp1BXLS6v3DsNVPdrJJoSUpCspmIPkNge4ERqYOlUwHbvLbvKUTPpjYoeTXnd89DSYMAURsdrkpG2mKV6Cn0PgbbagoxxjNzVvuxptH0mr+XXJriU0cJAO8M7fSgkoLhmJhSwX1E2ec/ZzbVPmlkt5zeKkyFpbQPjI/DlwQsL+z2XiXGaJDI8alUi9m/e5pM98xTOT1fQ8sYrfCoY+fSq9C7Iub3fCu5jtfo2sa+K4iYOsaAFwy5G6Ug77ZqRDtawbUwNU3Yv3m/LoMQC9cT6g=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aVDdpljtpIYqN/s1dq4ADSF+E3ZJYpgRpUIrhLb8dxKqXAFiHCxSL/tQDu0H3ic8pjeGcUD1r4Q12+jcR2EyEcw7XIdUzng3IVXZI0366sWXA0BunHD3HuiGSVl0stJhqLjHCXYJjEyfFr6Ier7J0U+vAzpgb2juTGB4VuuW8aksqYsR/gG9u/XzS/GBLN4PCtIRjEq8yuZGtDm3o+iWTBQk26yCRVHLtQHz6IkR5kGM4LF01ugEzZYK2NtQ8Dd7XWlcy4hhhkMXohGpf6xpqB0Bc2L/RAfDl9gXRlUV7Gm7JcMk38CUoG9it28gxf2ean00TlzOu+hKewdE47ltStMw2noIB3sWR64mZQwVORy1FyIlwJdBv8xlxsfuRjKcWbcOSsBSxzZq3238zEwgxGCa746K9OGqny/zZ8q3m6XENHYqSBjIIMIiX3nVT0yE
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 05:23:55.7257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 217e162d-760f-4c6b-ea80-08deb0afd429
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4463



On 08/05/26 09:11, Hans Zhang wrote:
> Add the debugfs property to provide a view of the current link's LTSSM
> status from the Root Port device.
> 
> Test example:
>    # cat /sys/kernel/debug/cdns_pcie_a0c0000.pcie/ltssm_status
>    L0_STATE (0x29)
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>   Documentation/ABI/testing/debugfs-cdns-pcie   |   5 +
>   drivers/pci/controller/cadence/Kconfig        |   9 +
>   drivers/pci/controller/cadence/Makefile       |   1 +
>   drivers/pci/controller/cadence/pci-sky1.c     |   3 +
>   .../controller/cadence/pcie-cadence-debugfs.c | 208 ++++++++++++++++++
>   .../pci/controller/cadence/pcie-cadence-ep.c  |   3 +
>   .../cadence/pcie-cadence-host-hpa.c           |  20 +-
>   .../controller/cadence/pcie-cadence-host.c    |   9 +-
>   drivers/pci/controller/cadence/pcie-cadence.h | 150 +++++++++++++
>   9 files changed, 406 insertions(+), 2 deletions(-)
>   create mode 100644 Documentation/ABI/testing/debugfs-cdns-pcie
>   create mode 100644 drivers/pci/controller/cadence/pcie-cadence-debugfs.c
> 
> diff --git a/Documentation/ABI/testing/debugfs-cdns-pcie b/Documentation/ABI/testing/debugfs-cdns-pcie
> new file mode 100644
> index 000000000000..659ad2ab70e4
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-cdns-pcie
> @@ -0,0 +1,5 @@
> +What:		/sys/kernel/debug/cdns_pcie_<dev>/ltssm_status
> +Date:		March 2026
> +Contact:	Hans Zhang <18255117159@163.com>
> +Description:	(RO) Read will return the current PCIe LTSSM state in both
> +		string and raw value.
> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
> index 9e651d545973..cb010bc97aad 100644
> --- a/drivers/pci/controller/cadence/Kconfig
> +++ b/drivers/pci/controller/cadence/Kconfig
> @@ -6,6 +6,15 @@ menu "Cadence-based PCIe controllers"
>   config PCIE_CADENCE
>   	tristate
>   
> +config PCIE_CADENCE_DEBUGFS
> +	tristate "Cadence PCIe debugfs entries"
> +	depends on DEBUG_FS
> +	depends on PCIE_CADENCE_HOST || PCIE_CADENCE_EP
> +	help
> +	  Say Y here to enable debugfs entries for the PCIe controller. These
> +	  entries provide various debug features related to the controller and
> +	  the LTSSM status of link can be displayed.
> +
>   config PCIE_CADENCE_HOST
>   	tristate
>   	depends on OF

[...]

>   
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index 9a464cbaf073..a1c531fd2061 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -42,6 +42,137 @@ enum cdns_pcie_reg_bank {
>   	REG_BANKS_MAX,
>   };
>   
> +enum cdns_pcie_ltssm {
> +	CDNS_PCIE_LTSSM_DETECT_QUIET		= 0,
> +	CDNS_PCIE_LTSSM_DETECT_QUIET_ENTRY	= 1,
> +	CDNS_PCIE_LTSSM_DETECT_ACTIVE		= 2,
> +	CDNS_PCIE_LTSSM_DETECT_ACTIVE_1		= 3,
> +	CDNS_PCIE_LTSSM_DETECT_ACTIVE_2		= 4,
> +	CDNS_PCIE_LTSSM_DETECT_ACTIVE_3		= 5,
> +	CDNS_PCIE_LTSSM_RCVR_DETECTED_ST	= 6,
> +	CDNS_PCIE_LTSSM_RCVR_DETECTED_1		= 7,
> +	CDNS_PCIE_LTSSM_POLLING_ACTIVE		= 8,
> +	CDNS_PCIE_LTSSM_POLLING_ACTIVE_1	= 9,
> +	CDNS_PCIE_LTSSM_POLLING_ACTIVE_2	= 10,
> +	CDNS_PCIE_LTSSM_POLLING_ACTIVE_3	= 11,
> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE	= 12,
> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_1	= 13,
> +	CDNS_PCIE_LTSSM_POLLING_CONFIG		= 14,
> +	CDNS_PCIE_LTSSM_POLLING_CONFIG_1	= 15,
> +	CDNS_PCIE_LTSSM_POLLING_CONFIG_2	= 16,
> +	CDNS_PCIE_LTSSM_CONFIG_LW_START_RC	= 17,
> +	CDNS_PCIE_LTSSM_CONFIG_LW_START_RC_1	= 18,
> +	CDNS_PCIE_LTSSM_CONFIG_LW_START_RC_2	= 19,
> +	CDNS_PCIE_LTSSM_CONFIG_LW_ACC_RC	= 20,
> +	CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_RC	= 21,
> +	CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_RC_1 = 22,
> +	CDNS_PCIE_LTSSM_CONFIG_LANENUM_ACC_RC	= 23,
> +	CDNS_PCIE_LTSSM_CONFIG_LW_START_EP	= 24,
> +	CDNS_PCIE_LTSSM_CONFIG_LW_START_EP_1	= 25,
> +	CDNS_PCIE_LTSSM_CONFIG_LW_START_EP_2	= 26,
> +	CDNS_PCIE_LTSSM_CONFIG_LW_ACC_EP	= 27,
> +	CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_EP	= 28,
> +	CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_EP_1 = 29,
> +	CDNS_PCIE_LTSSM_CONFIG_LANENUM_ACC_EP	= 30,
> +	CDNS_PCIE_LTSSM_CONFIG_LANENUM_ACC_EP_1	= 31,
> +	CDNS_PCIE_LTSSM_DUMMY_STATE_1		= 32,
> +	CDNS_PCIE_LTSSM_CONFIG_COMPLETE		= 33,
> +	CDNS_PCIE_LTSSM_CONFIG_COMPLETE_1	= 34,
> +	CDNS_PCIE_LTSSM_CONFIG_COMPLETE_2	= 35,
> +	CDNS_PCIE_LTSSM_CONFIG_IDLE		= 36,
> +	CDNS_PCIE_LTSSM_CONFIG_IDLE_1		= 37,
> +	CDNS_PCIE_LTSSM_DUMMY_STATE_2		= 38,
> +	CDNS_PCIE_LTSSM_DUMMY_STATE_3		= 39,
> +	CDNS_PCIE_LTSSM_DUMMY_STATE_4		= 40,
> +	CDNS_PCIE_LTSSM_L0_STATE		= 41,
> +	CDNS_PCIE_LTSSM_RECOVERY_RCVR_LOCK	= 42,
> +	CDNS_PCIE_LTSSM_RECOVERY_RCVR_LOCK_1	= 43,
> +	CDNS_PCIE_LTSSM_RECOVERY_RCVR_CFG	= 44,
> +	CDNS_PCIE_LTSSM_RECOVERY_RCVR_CFG_1	= 45,
> +	CDNS_PCIE_LTSSM_RECOVERY_IDLE		= 46,
> +	CDNS_PCIE_LTSSM_RECOVERY_IDLE_1		= 47,
> +	CDNS_PCIE_LTSSM_DISABLE_LINK		= 48,
> +	CDNS_PCIE_LTSSM_DISABLE_LINK_1		= 49,
> +	CDNS_PCIE_LTSSM_DISABLE_LINK_2		= 50,
> +	CDNS_PCIE_LTSSM_DISABLE_LINK_3		= 51,
> +	CDNS_PCIE_LTSSM_DISABLE_LINK_4		= 52,
> +	CDNS_PCIE_LTSSM_DISABLE_LINK_5		= 53,
> +	CDNS_PCIE_LTSSM_DISABLE_LINK_6		= 54,
> +	CDNS_PCIE_LTSSM_DISABLE_LINK_7		= 55,
> +	CDNS_PCIE_LTSSM_HOT_RESET		= 56,
> +	CDNS_PCIE_LTSSM_HOT_RESET_1		= 57,
> +	CDNS_PCIE_LTSSM_HOT_RESET_2		= 58,
> +	CDNS_PCIE_LTSSM_HOT_RESET_3		= 59,
> +	CDNS_PCIE_LTSSM_L0S_ENTRY		= 60,
> +	CDNS_PCIE_LTSSM_L0S_1			= 61,
> +	CDNS_PCIE_LTSSM_L0S_2			= 62,
> +	CDNS_PCIE_LTSSM_L0S_3			= 63,
> +	CDNS_PCIE_LTSSM_L0S_4			= 64,
> +	CDNS_PCIE_LTSSM_L0S_5			= 65,
> +	CDNS_PCIE_LTSSM_WAIT_FOR_LINK_TX	= 66,
> +	CDNS_PCIE_LTSSM_TX_FTS_ENTRY		= 67,
> +	CDNS_PCIE_LTSSM_TX_FTS_1		= 68,
> +	CDNS_PCIE_LTSSM_TX_FTS_2		= 69,
> +	CDNS_PCIE_LTSSM_TX_ELEC_IDLE_ST		= 70,
> +	CDNS_PCIE_LTSSM_TX_ELEC_IDLE_1		= 71,
> +	CDNS_PCIE_LTSSM_TX_ELEC_IDLE_2		= 72,
> +	CDNS_PCIE_LTSSM_TX_ELEC_IDLE_3		= 73,
> +	CDNS_PCIE_LTSSM_RECOVERY_SPEED		= 74,
> +	CDNS_PCIE_LTSSM_RECOVERY_SPEED_1	= 75,
> +	CDNS_PCIE_LTSSM_RECOVERY_SPEED_2	= 76,
> +	CDNS_PCIE_LTSSM_RECOVERY_SPEED_3	= 77,
> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23 = 78,
> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_1 = 79,
> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_2 = 80,
> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_3 = 81,
> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_4 = 82,
> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_5 = 83,
> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_6 = 84,
> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_7 = 85,
> +	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_8 = 86,
> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_ENTRY	= 87,
> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_ENTRY_FROM_RECOVERY = 88,
> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_EXIT_1	= 89,
> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_EXIT	= 90,
> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_1	= 91,
> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_2	= 92,
> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_3	= 93,
> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_4	= 94,
> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_5	= 95,
> +	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_ACTIVE	= 96,
> +	CDNS_PCIE_LTSSM_L1_ENTRY		= 97,
> +	CDNS_PCIE_LTSSM_L1_1			= 98,
> +	CDNS_PCIE_LTSSM_L1_2			= 99,
> +	CDNS_PCIE_LTSSM_L1_3			= 100,
> +	CDNS_PCIE_LTSSM_L1_4			= 101,
> +	CDNS_PCIE_LTSSM_L1_IDLE			= 102,
> +	CDNS_PCIE_LTSSM_L1_EXIT			= 103,
> +	CDNS_PCIE_LTSSM_L2_ENTRY		= 104,
> +	CDNS_PCIE_LTSSM_L2_1			= 105,
> +	CDNS_PCIE_LTSSM_L2_2			= 106,
> +	CDNS_PCIE_LTSSM_L2_3			= 107,
> +	CDNS_PCIE_LTSSM_L2_4			= 108,
> +	CDNS_PCIE_LTSSM_L2_5			= 109,
> +	CDNS_PCIE_LTSSM_L2_IDLE			= 110,
> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY	= 111,
> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_1	= 112,
> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_2	= 113,
> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_3	= 114,
> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_4	= 115,
> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_5	= 116,
> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_FROM_RECOVERY = 117,
> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ACTIVE	= 118,
> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_EXIT	= 119,
> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_EXIT_1	= 120,
> +	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_EXIT_2	= 121,
> +	CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE0 = 122,
> +	CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE1 = 123,
> +	CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE2_1 = 124,
> +	CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE2_2 = 125,
> +	CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE3_1 = 126,
> +	CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE3_2 = 127,
> +};

Hi Hans,

The LTSSM state encoding in your patches do not align with the state 
encodings for LGA IP. TI SoCs have LGA IP of Cadence PCIe, and when I
applied your patches, the LTSSM value in the debugfs for the PCIe
subsystem (which have an EP connected to it) came out to be 0x10, which
points to the state "PCIE_L0". However, the debugfs prints the state as
"POLLING_CONFIG_2 (0x10)", which seems to be incorrect.

The LTSSM state encodings for TI SoCs using Cadence PCIe IP is provided 
in the J7200 TRM section 12.2.3.4.14 at:
https://www.ti.com/lit/pdf/spruiu1

Regards,
Aksh Garg


> +
>   struct cdns_pcie_ops {


