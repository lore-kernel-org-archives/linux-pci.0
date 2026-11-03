Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793731505;
	b=xW62dBhc1IQa9jT4Bd1D2Ih9aQ+Gs+SBMe2XgjGXWuAej+cWxD3JSddeAFWZMfC6U3UE
	 WK7A13nWkHygT4sbdhOAGqjL4dJnMqMkVJIP0NU6AtKNkRK6TqOrW9MbCmbQnIa1CLxGB
	 U7FlaRtwl5CT8fA6uVOvNagVXArHFrl76uy1HVX5NiK5Rj6trjVwzISsmqcI6Dk5afQtR
	 b7MWH7K7htPl/s1JyKi1SuXWspSJ43d1GTjqDEQ2aLKYtoyX8OxH5lYhJixXc7V7AOLzQ
	 RDcsZqmnH7gl2pdWMdq0e7LUCuV1nWfwrICgK19D/nPVo9ExEDxRFnIOq29A/kmcrgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793731505;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-NV-OnPremToCloud:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=UAJXeuBuEJYUIUWAM/1VKg2o5KMuSDYvbpSUQpIO8Fo=;
	b=OxWFfnQ2pYmht626Qbkv7qItNzANBf4Rm52z3xXBZthUE4aMzTGQ6AWIa58XDvfEpEma
	 C2bHWoK/oAN9A+FlQeAR7aLU4WB4RAlVRR4E94+XjhA/oij0U3FCxqX70/Z/d+a+Il1Xv
	 6X/3XZudGb+dSizc9HLrT6qb6PH4a+74JkJqaoNxLyp5TkQ4LOFT0skWaocdTLZgPp14G
	 b0N+ysANod+E5tuKZGxS6JEsJJHo+oxPZMrTEgMW/CBc4YOmtHHj0Dns1KvvI43FX+PF0
	 Tct5lR51eEaUaXJj17wJakXAT7f/w6RwisjkegrgVnW5clB3sUET/RodBCmdbDE6Rng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=h7A+V2V9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.55
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013055.outbound.protection.outlook.com [40.93.196.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD470606A31B;
	Tue,  3 Nov 2026 18:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD470606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=h7A+V2V9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBHexpLKaveJ8Yeq2Ds///gB9TN/HW9exp3HwctZyoC0vpnQmqK+Yq4KZDMf3fBB+IaTvItMVT+M408C34hRFNT0pQZ2ddYL1a6wWhFNJkX/3507I9yfHvUtPzu3Pt7yoMblqrM14IeaX9H/VqcycYONdJjlGRl+oAUWQo50AnByOfZ6BhLsj7/mJmjIZCH9oak7zukfeU6co4mWG1mW4AigAKA+bIYDox0RnFe2A95r1W1NDcD9ya5krPvp78J21gxEDerbMYXrguSkDIjaA8NoJznzmzaM2SPfNdiz0Pj+sipyBzzeW21gI1rwU34BzGrQBf5Q96HApegC85f1zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAJXeuBuEJYUIUWAM/1VKg2o5KMuSDYvbpSUQpIO8Fo=;
 b=xeEG5iuzrf+ahAI/b1dZOAloyOdtuG5XaHC6NKKcsoHA0HV/FJAZkltCQDCdse7tffAT5jha47RmAEsd29+vy8FEEeKc4IHUWJhwTD3dt0uLAHBJDPxKXqdmG1Hmv81YZVsDNIKiao0T7wKtGUKKbySuIudE4FqHdNfRBfCMiHjj6pDod0kKhaQLClfz/iQu/ljEB+ezGFCXtUTaU+7Z5jYdDzmpmcJNaQzctoZn8/tkDuw/GkI+OE81UK+yetEanACWJqb4abyb5P1+w5S/UfHrw0iFJhRx4fPXryZrrm2VlFshG0oz6wWlLTTWqZoOylqupdS0R0KKMsy8nZLALg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAJXeuBuEJYUIUWAM/1VKg2o5KMuSDYvbpSUQpIO8Fo=;
 b=h7A+V2V9ryqBpEx940plekN6oyLWrnd72RyIwwSQlqTNdb3o3Hbj0guJfobNZC7L8bjU+Hs+roYjvqUvi7teTvuCZJooXt91ramIPVCHjbjXwZF9YpiFepkHNHiRamnYQsdpyBIXRfuIedE2KIx0tWrTFyK92KvK5M58gP9t9AJgaT3ayGl7Qb6OqnPUTV+zgA5woYPtns01rELu8Kvy5D9Gf+Gik2LnNdrBOW6hSTegh2FGnTbjS5O2Q0WswfGFnJKZ9UDVMhJJa2MoH03xxDny9vqSUpXwp0I4MBWhtgRhp6XXsRpCVzHFMFoLhouNpe0yiWrvy/Y8jhAYzVWvFQ==
Received: from MW4PR02CA0024.namprd02.prod.outlook.com (2603:10b6:303:16d::9)
 by CY1PR12MB9583.namprd12.prod.outlook.com (2603:10b6:930:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 18:44:55 +0000
Received: from SJ1PEPF000037AF.namprd03.prod.outlook.com
 (2603:10b6:303:16d:cafe::42) by MW4PR02CA0024.outlook.office365.com
 (2603:10b6:303:16d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 18:44:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000037AF.mail.protection.outlook.com (10.167.244.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 18:44:55 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 10:44:35 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 10:44:35 -0800
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Tue, 3 Nov 2026 10:44:32 -0800
Date: Tue, 3 Nov 2026 10:44:29 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, <joro@8bytes.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Joerg Roedel <joerg.roedel@amd.com>, Kevin Tian <kevin.tian@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Dan Williams <djbw@kernel.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v1 2/5] PCI/CXL: Probe the underlying bus reset in
 cxl_reset_bus_function()
Message-ID: <auorjXgbVPXZNHZL@nvidia.com>
References: <cover.1793729707.git.nicolinc@nvidia.com>
 <6c09d2f78d4bb9db7f49fa14a6550f5176721121.1793729707.git.nicolinc@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6c09d2f78d4bb9db7f49fa14a6550f5176721121.1793729707.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AF:EE_|CY1PR12MB9583:EE_
X-MS-Office365-Filtering-Correlation-Id: 44111012-f6e2-4990-9c32-08df39da8dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|82310400026|36860700016|261022105027099003|4143699003|56012099006|261009223027099003|261009221227099003|261028144727099003|261021135927099003|261022075727099003|261026121527099003|261026140227099003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	S7NQam2mSTwXawhip3hRcMdUXGfU5fH2JwaMGiV0UU/fREPH9VbeNeW4YvHFdSUquk2IyKWkKB8uHISqI7ooGq1To+hEY7vwVHqlRrIhVKZcbUojB1CjT7Fkv4zxSoIZahX1sKr5B6bq3oPK4U9tUzXlJ70//FdR7yJRWCVWa8p+Nrt8/8K3oI94DW/szL2oV010kKy5DDQX9GFkxP5PVVX7ZTEzg2s1PnGK1sSS3PiBzPt2o7N7b3dz4Dipn6JwoIG5pg+OhO+tSOU8/SnYAvX6GVX84NTwlvE2P/3u7et9j8bDiALTM/tjDbSYHsF7Uc8s4toXwi4HWYntpM8AaRQ3JislSVbGyUIsQvepYJ/C9axuiJoNJCsG/+wwC4oqhQcF1eBSwGREIPikLitfdVCmadD8w5dTHwI9IvtQKLttTyryG4MVey/e0Pf/G3A230eA6RJRYZvjhNpXZ9ZBX8VZGvP4PA2G0029JgDR+WDnQhz6kJR5SBXLJ7X+GBFdHUqrnJCKKYOyRwvD11QEEERGWu/0PZDVMCJwqwzA8r+2bjxPlJ0ENm++FcG0iQz5BGFt0uezPrH+wyFw7mz3AkB0oCdIoCOr4Ki7vGqSl7E6s9ibV0WGsSh+tvkJCpzZQ/kBbVDsMKgdOwib7iB1GmsDEApA5Qkvjn30MXn+BeilwUqQcFWk54+6VIL0/0TDAh2yh7Sc5PVvUTKNgcugLA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(261022105027099003)(4143699003)(56012099006)(261009223027099003)(261009221227099003)(261028144727099003)(261021135927099003)(261022075727099003)(261026121527099003)(261026140227099003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PU2cD42C6OPMSOGOPTKjdfPDnMQNGCn/3Qb4bJKoySfQn0wBVyNWa3WBfWPXHJMVWhBqbc+Qo9Qj8d+BLczZ5I5/1hTGON/LH0HwGRK2+nd/rFlVLa8XPzfswcvjbw4tIDfhIW7GBp/oF5zQ6KWUyHyX+RNbG9tGA2kTPjMhpMcvpk9rc/LN48+cKxowI9cAX4WBQGZc4eZyhxLg8m8U1hLkEI8RBAqW5Gi/87gHviISQLXpz0pC1COnnBa9cSI4U7wP31EymVFCc26z946XeA7/wodKPIEmcP2qbQHWdt3LNJKRrC9hxMAvyswQCeTyZUzblzuoVpSgnkt7X/BqBJwB2y1usQfuda9PRrrX33smVOtv/bKmPravpRqTinyDHNUOQH3/t6ss34t5VYxAlF6tWkSPaqsF4+lvFNyMOdvbL28OFtVXjctVIjZRKiJc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 18:44:55.3363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44111012-f6e2-4990-9c32-08df39da8dcf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037AF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9583

On Tue, Nov 03, 2026 at 10:33:43AM -0800, Nicolin Chen wrote:
> cxl_reset_bus_function() reports "supported" to a probe after checking only
> that the upstream bridge carries a CXL port DVSEC. The underlying bus reset
> can still be unavailable, e.g. on a bus shared with other devices, so both
> the reset_methods[] array and the reset_method sysfs node end up listing a
> "cxl_bus" that is guaranteed to fail with -ENOTTY when it is attempted.
> 
> Probe the underlying pci_dev_reset_slot_function() and then, if it is not
> applicable, pci_parent_bus_reset(). These are the same two checks that the
> actual reset runs, so a shared-bus CXL device no longer advertises a method
> that can never succeed.
> 
> Probing via pci_reset_bus_function() would not work: its cxl_sbr_masked()
> check rejects every CXL port with a masked SBR, while the do-reset path in
> this function unmasks the SBR before resetting. Such a port would wrongly
> probe as unsupported.
> 
> Move the port control register read above the probe branch as well, so that
> probe runs the same checks. That read asserts no reset, and a failure means
> the device cannot be reset this way, which is a probe-time answer.
> 
> Also pass an explicit PCI_RESET_DO_RESET at the do-reset call site, since
> probe is always false at that point.
> 
> Fixes: 53c49b6e6dd2e ("PCI/CXL: Add 'cxl_bus' reset method for devices below CXL Ports")
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Ah, I missed Jonathan's review tag during the split:
https://lore.kernel.org/linux-iommu/20260926001311.7c4be583@jic23-hlaptop/

Jonathan, would you mind giving another review tag here? It's the
exact same patch that you reviewed. Sorry for the inconvenience.

Nicolin
