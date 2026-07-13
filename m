Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013071.outbound.protection.outlook.com [40.93.196.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E863B1B4138;
	Mon, 13 Jul 2026 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783968662; cv=fail; b=Xw4Q25fg/KeCO11O1w25WZOR6mEidfsi6wrpbZgB5CIqf1qKevMWMvNRUMsk7yqZltWeK9E/VsOkzjQ27wmTXgBw8XCndnokc5q8hQzLsRynFJSx15f2DGgyWF3FmpO5d47yXqqAmGsLYx0Bhl0lTiXMWGlx8NdDdRdfnR4vTSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783968662; c=relaxed/simple;
	bh=UcC2o2B0rZl3M8hNiGZxTh7tmSF+ENJA1ZCuhNJGtJ0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaSlWEN4vN3P4QvGC2eoSsUkIIyUwAHmx9NINHds61aoaryE6pEraPXqkyccBm3F7XYmP7vak9iq9Y/gitbLjKinQ2tPee4RSMpKqndWhU63uU2BMne/EroF5X72a9qE6gSG2Tq50/G0cOOHvuyGK5CYaEfIp6Uy/RjIzP6mAbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oETTL/mn; arc=fail smtp.client-ip=40.93.196.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oETTL/mn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5qD45F9BwKJ2BbYHE9hi/rb8VzrDlCnR/wj50NVFBe9DCuojKRIi3ewP9y3h2HoRgCoWx15z7T8Ka8PI/74TyWXkQ4b+LyW7EGB2VPSpBOO0IW+WmAma6VxcHQPJGKWpufSrmbfcKxP981XJ3aL1ESLtS/h+ALx5zo3e9vezItsTg+Y1CFDns8DFdDQciPXSapcLamO5dM6t1FmjRD2M8PGN5k7+S7kv0I0cIicXfD+LnkW0iWGThI5cp9bRorDzFKa+ZJEZ5Y2GTn3nvPCrn1fKPALu+47OeEqBZUBCWlC+SQwqtv3L5fuRDIA9RUeWvy4qwgCy0J1rua/2gXkKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xCUAaF3E+q9DGG0d5+j0bvgDxHGS+6lEf8jecnHXHw=;
 b=g1rvG+KKlgwJ1XYB7FbUIDDaX8zGet5WX3GBIWG3qOijiuEs14mxOrUi1YfCI1/lGupC4povrQmVAgACFtFaIIlvZHBjyfT7Hu+wGKaFMInLLIa1zrl/DRlBhuFQXDu3mg76wRD2MtMp57fT5POZchCi/Iob1I45+y0qKbpBHFnfqf5MKPU4S3zXUwWpm4jAgfXN8eE47WdLbgahACuQsXOHx10wiApNQOf4cdLY7jcH0uw7AKii2hkkHcxvaoupC9HVg8zpJhyPMON4iwvnyHx2YNO86za4eyUh4Je/os5WaLnfqxyKX7Tm1xiAtLCdD+/P4Sy3+SbPAXWPFwXPJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xCUAaF3E+q9DGG0d5+j0bvgDxHGS+6lEf8jecnHXHw=;
 b=oETTL/mn1khXGHHdQEX10Mr0AR+Rl7ZBhdFAPSjX9PiGwmC5dSRKtMRObrc4sIlhQzMPfUQ1d+HqULH28IdWT6TC3NSNdILi6vZk6lRzQRgB4SBEZYZIEtVNSoI5at5ZE2MpXgJ3U41+eeGVuxNz6E+r5YsPbuEddJ28hDCs5ttXT4Vdv/EJo/T7x5TjDoHetGpw272qwcv03Qc86d4mbg4pg260OiIP2S5gJEsFUBxfWhzGw6tzqG1Jf2s5btQfg5+PuciDJ945TFIpBkeXGOyg6YuSBBdW7I6G/G9oqGrctsxvGEXhSI3SCZDYioLFpE559ZOHaOZJMhlDWfbHbw==
Received: from DS7PR05CA0083.namprd05.prod.outlook.com (2603:10b6:8:57::29) by
 PH7PR12MB6635.namprd12.prod.outlook.com (2603:10b6:510:210::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 18:50:55 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:8:57:cafe::8b) by DS7PR05CA0083.outlook.office365.com
 (2603:10b6:8:57::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Mon, 13
 Jul 2026 18:50:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 18:50:54 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 13 Jul
 2026 11:50:40 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 13 Jul 2026 11:50:39 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Jul 2026 11:50:37 -0700
Date: Mon, 13 Jul 2026 11:50:35 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Rafael J . Wysocki" <rafael@kernel.org>, "Len
 Brown" <lenb@kernel.org>, Pranjal Shrivastava <praan@google.com>, "Mostafa
 Saleh" <smostafa@google.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vsethi@nvidia.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v5 18/18] iommu/arm-smmu-v3: Block ATS for a master upon
 an ATC invalidation timeout
Message-ID: <alUzeyRh5FnzMiQ4@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <939885143f3064811685b3f31f6f30f8a713c89e.1783044582.git.nicolinc@nvidia.com>
 <9a85cccd-29ed-4c51-b9cb-140631966d20@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9a85cccd-29ed-4c51-b9cb-140631966d20@linux.intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|PH7PR12MB6635:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f400e3-6169-4edb-0c08-08dee10fab34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|82310400026|1800799024|36860700016|18002099003|56012099006|4143699003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info:
	ASxgbWdqTuZobAGV7J22zT4aQdD9OCzmimID3DtlttfZQxrtkMT0x6pSTaMs1s8O2sC++lJCxbhTsWOif/TH047sdr6Q3rUGwZR5d8mERUTvyc+5GcdD9QjVqMpcmWPUjrOgPkEcNwNysdU4u9cjX2NMGAwXUCaFuyMiuKLUyu/tlx4iQa/abUzlmjL2iGNfbg1+CG2E85FSYhqyfCCr1gtEPYJzpZ99es0HKt67fXw+tou/W1Rqpv6NSeU5Stp59wxeL993xBnCdrzZsUmcRnAAnlW/xtKsmLJO9HDsT8flybLxw4fPnmJtf6B6kXSozNTP+Em9R09AuIVQ7lDOuSaJUDZSWhdHmpNHwUnyebdb7uj68k+X+l8o/Mj28OlovaS5C3ownAAewwgCPMWAxRE5yCcfe7/ZpzJM30vErwwqHsSiuk/4pg64ficiXsyw1jTt7KRuL27eHuqDyqri6uWxqXCNsTodx9Whi6dh+0WHADJs0kzNbkiyFrDAWOhGe8KTF5BSaq/GmlWCvNHiPHv4FHdopUoLlkMXRKVTcteZJSS0O9uq+mQDskKeqlOb7afPJy1+o4Qboj9X5kTkbwmgLzcTFRJKyZOpuB2RIjAQdLUSRK/OxUzNvf5Ahx1H7REMG/iZYF8+FcdvDuakdF1NqXay0Yo3fxpjAiHHTZcBleMpMhoAGaZSG+Vwabyp+f3jHV1/6v74awktKNGcmg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(56012099006)(4143699003)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	O0bZ6NkaOvW7NvRp4oJwjvIrggbpn3epr8qkauqprYP2XF2iaDsqQbL07UGxtZFCXGuWUhGmxht7yTOJHV2ZeQiO1JQqAC94+b/GvL3vmLTMvnVXybdatCvUAZFs+NTtz0eId0UKnwCl7yJnMM9+54UwYqju0tvL9mZCCObaVjbLaKVchvAzo7Vzn+KRgpsQ03K5+FjLcaZ3WY7rst7PRuePZS/1gh+O2I8Z/dsh1Jjd9pXicCtTaiNfU2l8sffFTmhipMWEFBHFCi0sukpCiUWseOyBVE6xgiN6xUxG7VaUmLz7xXYmwFxZcaIMBlHbvNitYpVHfh4Ed3ry54BUWQaOjsLHBLi1L60iY+n7NZv1utOg06xMRS/pJP9zFMBVondDWE9tLlXKltV+qgzZ1jgcptwY6cOatfr8HUeHbTeUm8Jdwm2Gux14jCmvhiij
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 18:50:54.4921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f400e3-6169-4edb-0c08-08dee10fab34
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6635

On Mon, Jul 13, 2026 at 08:20:29PM +0800, Baolu Lu wrote:
> My understanding of the sequence to quarantine a faulty ATS device is
> to:
> 
> 1. Identify the devices that encountered an ATC invalidation timeout
>    failure.
> 2. Have hardware block incoming DMA transfers and translation requests
>    by clearing the corresponding bits in the device's context/
>    translation table entries.
> 3. Have software prevent the driver from submitting new invalidation
>    requests or re-attaching a new domain to the device.
> 
> If this understanding is correct, then while steps 1 and 2 are hardware-
> and driver-specific, step 3 seems completely generic.

Step 3 is kinda driver-specific too for a few reasons:
a. This is in the iommu_unmap() context; called right before that
   function puts the kernel page. So, all the steps must be done
   before kernel reclaims the page (potentially to a new ATS for
   the same device whose ATC is stale).
b. Invalidation can be an IRQ context. So, can't use group->mutex,
   which a generic helper would likely need.
c. Given (a) and (b), extra driver-level spinlocks are required:
   streams_lock and master_domains_lock in this patch.
d. Step 3 actually has two small steps: disable ATS at the driver
   level; disable ATS entries in the invalidation array, either of
   which are currently driver-specific.

Jason has a view of moving the arm_smmu_invs to the core. So, maybe
step 3.2 (disabling it in the invalidation array) can be generic in
the future.

Nicolin
