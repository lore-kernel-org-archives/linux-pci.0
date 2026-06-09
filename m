Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBB231D759;
	Tue,  9 Jun 2026 03:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780976478; cv=fail; b=XSq9fY+ureXTe8KWjWLGigTe8Dkxg/SgxkOeoo9QMLY8Dy8rMQ348eWk/S2tlEwu0/7lbgzI0wjqOTpmQhuZ/oyzNM5FMCkmk/I4WOLSsUShtclW/gBw9iM9IWU0aHjjU0dKsObvX31wzSeL4gMUjR+BZ+vPRUhm/c6QFLEeWOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780976478; c=relaxed/simple;
	bh=EDUFHNa8VyZyKWIIuzOuZjSCSrhsJ8IuN7drYEwV3pU=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n602sOYwwS8A4ESOm6VQj5qc9aNh5oo5juZrgLsRLPwtNO1KDo6kYMRja3unzGDAGgAEjj0BkeRwzblG1okxIpsuRxdow6VQDOiY6lxjh42Y1zGsNfWp3F7TThlcuk+JYHpHJupM0rxDYBWOB0HvFMiJRQzU3Za/qVJgZdvozqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=b5ZNV0R7; arc=fail smtp.client-ip=52.101.52.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="b5ZNV0R7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6y4ATtsxjG+UziZXgBIIN0oDaRIeL3SpojlPH+CbszLmNTi7KCoABUR51dhfAc0LfwBtn3hEC2xQN23IOxWqIXcRcpsa24iMqFGpTYpcF7YGczm3IQFyGCdmNs1jC817yRKDf/8LfBfaQ249lBuuk9s35eTbHQRatK7qMC6R6i6faq8HaYgPdOa7C9gQdjqMielECuUoDxnkYLrp95ClLFGP0YgCOLDywNhi6kofIWoRpOr89srntq4XEnVoNr7yNX4ONrffyDzNNGAX9LS25X8WFCAT7aggGdLrIc4Aw3Bh+s10d7mTH9WwqSAjLwN30E+K/JyiXjjj5yRxaJayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZOjnHACVTon1pbpnkxGmBB0lMQWx3+ggQ4jgwjjkCA=;
 b=s3LqVLsTDBsUwJj5WUB9gmOvnxbMwWyOghLQbS9uKjJaJcl2F2CaQfT5kRddjXBLbhL+88TFDEzi6KoMALWQsu/rqPBA9LJo/xHMJ1bRYgHlKF1tU9efLqd7NICccESj7ZEkz7BDhydiXqg2zvIuMJ6mB1vVsFvVB8WSh1vdKH8ErI2NeHjRKTX4xvIMjpP9Olc0asy9BvUZkFMUHsUAfTOww+zq0DLfinv4mGb6Co/cRIEnOt9gz7wm5+gVWbDWlFzGJvrFNMsEMs70IwS3IyN9F+DXFyreua27GLpB21siiV9vBwrqMRJKteg9DRF9EKQ0LNCotCth9BZARWDi7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZOjnHACVTon1pbpnkxGmBB0lMQWx3+ggQ4jgwjjkCA=;
 b=b5ZNV0R798j3EyP7LZJnJ7gR2Hanv5K/GG+qXB8yXRR84rVIqKbsTLM6Zxs2iQ5006nKPRFZ599jP5DF2osSSZ7bzjDx7ARTBr7yDwsjhyghAbtp0Q4HhGoC9HfeWv3OPggmAliA8CkNRNhtZpBU3rLhaxYY463geMD+zZ2OrjY=
Received: from CH0P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::24)
 by CH3PR10MB7716.namprd10.prod.outlook.com (2603:10b6:610:1ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 03:41:11 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::62) by CH0P221CA0023.outlook.office365.com
 (2603:10b6:610:11c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.14 via Frontend Transport; Tue, 9
 Jun 2026 03:41:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 03:41:10 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 8 Jun
 2026 22:40:19 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 8 Jun
 2026 22:40:19 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 8 Jun 2026 22:40:19 -0500
Received: from [10.24.68.110] (uda0492258.dhcp.ti.com [10.24.68.110] (may be forged))
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6593eEZO785862;
	Mon, 8 Jun 2026 22:40:15 -0500
Message-ID: <19ded2fa-4560-4b38-975c-6b490328e992@ti.com>
Date: Tue, 9 Jun 2026 09:12:46 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <vigneshr@ti.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <bhelgaas@google.com>,
	<mpillai@cadence.com>, <unicorn_wang@outlook.com>, <me@ziyao.cc>,
	<18255117159@163.com>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<danishanwar@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH] PCI: cadence: skip the link polling when endpoint not
 connected
To: Aksh Garg <a-garg7@ti.com>
References: <20260605071922.1724499-1-a-garg7@ti.com>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20260605071922.1724499-1-a-garg7@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|CH3PR10MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ea9202f-5a9f-4958-539c-08dec5d8f29a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|32650700020|376014|1800799024|7416014|82310400026|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8gi4xglmsF322nNjlLtrXlN8KtIehV9ZyVyEc6c8uyBZ+SUEVFtJMXXMjVqXZXlFlpqmqaxiKwj2LMXT9RcmZIsVzNCHWG1AlwXUsiqPyebaTySBVBGUBt0fTPb3a7hVs42L83vzfQlNIar2F6aXkzgRJy1qzK+VoxL80nGxjTfo7UEQ706rxL8UbeXPmJ++dycfNqn0lnknQkoIBAWhEHJrRu4w69vlGO3p8u/HbLkEegoqolpBiFkUuDBgeHpdwgp6TrYEpRoOy1BEbHqlFKpUIpQAvjzEGvv+0+VAh3SW1XojpWFghBlmXGN2QtAtWqjpKvCpgei2gWD7C9FZu2bAEOIDqfTzbLZYCDZpU/gBg2Ts4KtQbEA29DQ7dmLSaI50Y8t3rnj1OfMUyw/ezZueUcAxb5JFxw0D3cN6dNXQ1HmDx5wMdY7vc5L/KSrCEISMkveMWSPg1R4fgDj8XQl8dAQYTVf/3MrzMgNNYsA3cQIUFMh+Z5T+DhQLx6sJhaE97WZ7rw9lrU1bo23E3R6JTGIvoSJcSDaIoDQwR7h/69nGNCyJRDwcH5j64voJfCYZ/wUiBc/JIG2vAuSXk/oH+5mvk7AZGcZ5uBSeOV2GjB2R9z9k4TPMIYstyZSk63cafYCUxzyA70vnUeX+WG5QYOfUYD9fg8er0Pm6kH0zOxrWvOGkQtBq10iDkrsLmOe1aTf5caQQ3p6W+cUt/aTKlv5W9G04VaX1v8+U5gI=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(32650700020)(376014)(1800799024)(7416014)(82310400026)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3byYDm7D/8d9Z4Z5Yg3CfMoV9QbWoH2it2OZ7fz8RdbmItjxGgMOE+FZLjGUFphXl47+sARLrvJZDNxZHOXFmDHgbo3gfD5B9nybeOWMkTwQLGzqp1syUMZ2cUDOCcYbzHsC7n/G+cuxB0v+DkkWTGUdWO9odI0EVTvnw5azIJc5htPu50hpTnlnPltbWflY3Y2L/WUAJOm/7hNyD01xsSiMsf8x1iwbQa1IBJLmHZ3FiN6FbtMEHESaPh8hgAyg/swv6Lj5UiCVRh7onb14Y5UZ8mKNx/0iPnDy3vGvYzgZ6A3AuEpbflEqFDa7tHQnAxweP2NpLrACNr6K0xN96otZL/pX5JoNBAu1/21f6p0U1fmXJqjzI34+it0/eO8mIcwolpXYbyBlQJy2oZvwdJywYxQ0MmVtu+ysI9bMDcKFj15vs0dNIMtFjkS+rTRB
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 03:41:10.5945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea9202f-5a9f-4958-539c-08dec5d8f29a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7716

On 05/06/26 12:49, Aksh Garg wrote:
> cdns_pcie_host_wait_for_link() polls on link-up for 10 retries with a
> delay of 90-100ms each (~1 second). A call to cdns_pcie_host_link_setup()
> during the resume operation blocks the resume operation unnecessarily for
> ~1s even when no endpoint device is connected.
> 
> Add skip_link_polling flag to track link state across suspend/resume
> cycles. If link was down before suspend, skip the expensive polling
> in resume since no endpoint was present.
> 
> Signed-off-by: Aksh Garg <a-garg7@ti.com>
> ---
>   drivers/pci/controller/cadence/pci-j721e.c             | 5 +++++
>   drivers/pci/controller/cadence/pcie-cadence-host-hpa.c | 3 +++
>   drivers/pci/controller/cadence/pcie-cadence-host.c     | 3 +++
>   drivers/pci/controller/cadence/pcie-cadence.h          | 3 +++
>   4 files changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index bfdfe98d5aba..849eb8bb9e45 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -686,6 +686,11 @@ static int j721e_pcie_suspend_noirq(struct device *dev)
>   	struct j721e_pcie *pcie = dev_get_drvdata(dev);
>   
>   	if (pcie->mode == PCI_MODE_RC) {
> +		struct cdns_pcie_rc *rc = cdns_pcie_to_rc(pcie->cdns_pcie);
> +
> +		/* If link is down before suspend, skip polling in resume */
> +		rc->skip_link_polling = !j721e_pcie_link_up(pcie->cdns_pcie);
> +

Please consider the following scenario:
1. Endpoint device is not connected initially and we suspend with 
'skip_link_polling' set to true.
2. We resume and skip link polling.
3. An Endpoint device is connected to the PCIe Connector a while later.
4. We perform a bus rescan, but with skip_link_polling still set (in 
resume), wouldn't we skip polling for the link to be up?

Shouldn't 'skip_link_polling' be set to false on resume, after we skip the 
polling initially, in order to allow waiting for a link up for a newly 
connected device? Although this may not be done in practice and the 
Endpoint device may always be left connected from the start, I am wondering 
if we should clear 'skip_link_polling' on resume to account for the 
aforementioned scenario. Let me know if I am overlooking something here.

>   		gpiod_set_value_cansleep(pcie->reset_gpio, 0);
>   		clk_disable_unprepare(pcie->refclk);
>   	}

[TRIMMED]

Regards,
Siddharth.
