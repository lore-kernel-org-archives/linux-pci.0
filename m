Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011061.outbound.protection.outlook.com [52.101.57.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A472EB10;
	Thu, 24 Sep 2026 01:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790212394; cv=fail; b=B4GfcGSn458e7p/xar7hjuCKy8Ss1Snzw6aOoA8cmXIVDmLUgCZB74thfJUD0WtkOYpV0H4yuD+EkkIoR3mS9W4F3OGk2JvXwGW8cSuP/CPduiXdezH9WaCx+kWWFICXadpLL8gwc5z0uWVWprH2g6ZfVXCag/6FFd5TosIsyP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790212394; c=relaxed/simple;
	bh=ecZgC27yD65p15E6/GAguDMQsG3VMI7IamB/VQBe98w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJ83mWgZDqqbljv06ATQ2PstFFdyDAtvUTAQmb09n0+5NNvwad3/da2SbKTSxxB56c6lzI9IBAeGExs2QktHVhZTm9qNLHUl8wsVB02ipDrx1JQIfr4OSqyz7UCSWfJTGmOrUUrN9TtGMka6Wok9j7VtqvMEk/3/8OIhctDAFfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=axq3GHVB; arc=fail smtp.client-ip=52.101.57.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="axq3GHVB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUv+QhBl54ZEfjR59S88kYWpj2hXLy5Ma7snuQeQVxCfVAqVWndS3qJ7fqI/SKISu8jQzqApDR43kdmStQAoKOAI12IZwxpeMl8XwaFY274pgaEaZimp8h7BdLFey6X4f8nk1R47x2EqXys7kTLnPQ3qSj+1BglMvQJBldcRLJ2ZjiI/kQ/djIS8OS+Vwum/kDjsCBkDhWNbEcw7cq7ZaDbO2TXtcfZcf6HaFS8CFWWJn4QvzJKXx9s9PI4k9dWNiXdsRjLQTTni7Rhpf/5rjwqHQzjWzNAqEqBmeMDsL4SoPQxhmYql8xstGKDOLmAdOtk1C7VAdkLNOeao/v9/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sl2xvVIedJEjyfwl/EQXfbImMRrTKUBs1pyI1PBKbJ8=;
 b=fbFDHANoczwIIIzZ7d2//+GZM9VgTEnwFuNZM9UQwLF0iVcPjs4Rjo0EPi8MW2woRNMVcTlWllWdlJyE8LqOHGDznsULdU0YBxxDSGq/zIWSxsAV1FUd28GA8o0znKc1K1BrH8AIJxU5/lWtDlL00R76dTHpe15WFGce8yXskfeGvzFECAg4f2yYnoM7teWWiwSA99y/S5Jk7NN490PStdvchx9GQlKG4chos/jluTdiXLXaW7s8Fz4+vmc2y/bHo+W8Pbcli4h0yusiGhp/exOxwieKJMPrf+oCbrkW9E4nH9s/eaoAU5HKHpM95zS0V7xBmPHt9lDkbODxFSNfXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sl2xvVIedJEjyfwl/EQXfbImMRrTKUBs1pyI1PBKbJ8=;
 b=axq3GHVBvUcslMNcX6omn6Y4EGWTZ4wxJ5QQ5WDp9/em7Y7cuay1QpLqeZFxw5r6UiKihALlYVYNoDsPTnNy6TSHDDiHaXOyLZUmgCkIz/GwFllmH/b5Xz5UfY55fkqrqa6zar1K+LDE3c786P+ll7UHW1T58G6sdo+HYwVIRbkAsWIcevpWswS3dQsc+veSx/lEIe8jm2ulJ6SiZw8wrt8LJtY/RjXMhu2i3QuD+Bg0B7/wZN4Z9RVw0YGKRWKR+ZWw8d/CVfSEfuhpsHN8I7Pfpl5MZp15pJaXUwgZrk+SOnZ/8b7+KKbG7+J5vAH2S9PKFXgTzzN9w5N+fJOTLw==
Received: from BN0PR02CA0014.namprd02.prod.outlook.com (2603:10b6:408:e4::19)
 by BL1PR12MB5850.namprd12.prod.outlook.com (2603:10b6:208:395::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Thu, 24 Sep
 2026 01:13:04 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::44) by BN0PR02CA0014.outlook.office365.com
 (2603:10b6:408:e4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Thu,
 24 Sep 2026 01:13:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 01:13:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 18:12:48 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 18:12:47 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 18:12:46 -0700
Date: Wed, 23 Sep 2026 18:12:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>, <joro@8bytes.org>,
	<bhelgaas@google.com>, <praan@google.com>, <kevin.tian@intel.com>,
	<kees@kernel.org>, <smostafa@google.com>, <baolu.lu@linux.intel.com>,
	Jean-Philippe Brucker <jpb@kernel.org>, Eric Auger <eric.auger@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<skaestle@nvidia.com>, <mmarrid@nvidia.com>, <skolothumtho@nvidia.com>,
	<bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: Re: [PATCH v5 08/15] iommu/arm-smmu-v3: Disable the queue IRQs
 before disabling the SMMU
Message-ID: <arR5DFw1Jfl9G1o9@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
 <0ca69e93a9370e4e172e4335104859648b8755c2.1789446520.git.nicolinc@nvidia.com>
 <179018862539.3334538.4925881940702512638.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <179018862539.3334538.4925881940702512638.b4-review@b4>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|BL1PR12MB5850:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ba8340-3617-4db7-3e22-08df19d8fc2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|36860700016|82310400026|1800799024|56012099006|7136999003|3023799007|10067099003|11063799006|5023799004|4143699003|18002099003|11062099010|22082099003;
X-Microsoft-Antispam-Message-Info:
	ISLjcELuG9JXyKQs8nWLw2nXM0ZR+P2+ExDFTWeOFNd8ke6UCvCXi7bTC5Y1qNmtQakOd/YDzAfcasEC15aPGVPfrsxL4O/L4+/8BXZjVqEuTNPR7AD9qTXeNh6mL7tghEesOA7ROJjyKbTz5c8jBxtigoG+xe0pcf8DUOYLQabHc59GwaXsnV2WSfut8hH6NFbqbIy30+nGp76eSHt8Ri2bPRiKaXK2jncky6ezprd8gnVwITf0FjWBpvKFhYnf8mS/9NkEEoeAeE+JNQTxj0Upu6YT0IXhxo41bvbGdFsipl+y1kFk//cPy7sR06HfW5cba8Bo++pGX6scekj3/IOFKIElBzKQ9UqKpqM9mFePnW+jwVAR+SjGOkWDpNZj8cNPbvY8rEiiOaF6o/uK8uaVGaLrRQGLSwoqTDzGto1afsxPAnq4U2NCGBQcC5LFHoR1xwuh7Oiqj3n5YimY/AwE4EdFGViGDjU/XxC9pE5Y+HAzy9YdCO1kXr4cUfEP5K1bYMNghhnGfFU3mjF8v2L2thUxbnDYeeMVLJyL8a9i5iGdbksnHTQiXonjQHOcXvJXTbulZtw2Z+q7Jfi827kjfXIFQ+cF55do8nNlbIIthf6Ly+zkrn6lIJyQidz9Z0LZNtyiNyvOtOBWmoxgIkX4xQsOV6mH4QEJxvf0oeWvysNu0j6Ik7Mnc7K3qyvezPwnW308qPpsUi02T5Xp9A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(36860700016)(82310400026)(1800799024)(56012099006)(7136999003)(3023799007)(10067099003)(11063799006)(5023799004)(4143699003)(18002099003)(11062099010)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1SE+8EL5IJWd5Txikkc8v3phsH3dPwvs/lxG71bQuIxe1JCYqdNXuOnU+9Wbg+9sCzv6kO/bIRCcfbMRr/vsRKzAo/zqt83tpMiPLLTP4+ksEzGFeVYNPPoI/Ue09fWc5lJj/YflXZIjTCMZhvuNUs5idop9uZ8wFKcETMyv6xrXG1YcKZYMIZ2hf5vlDnfbJ8TZ6JDvv662/4NoUwdyhf2fjf9jjWHMVMr1GVVJuiM1TJjZpL4Qk976PUYrfFJlkHJ4lNZ4SlvIDWGXPN8hzmcf+56Tnz7HNAgUTJENne6Hq0qB5qMpdmqhlxZVO8rPu8uPiuvNkw3g2cNnH6NmhuFBds1QRDn6cEwbuEYMHDD0wKIMyZ0dv8tQtWQsIfPe6zAKxb7PgZLenJWxpR18M8nW/Ys88EeQXwmMA4o5ojSqwMYDGRG1uRBmkLei0swj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 01:13:04.2502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ba8340-3617-4db7-3e22-08df19d8fc2c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5850

On Wed, Sep 23, 2026 at 03:37:05PM -0300, Jason Gunthorpe wrote:
> > The EVTQ, PRIQ and combined IRQ handlers are threaded and issue commands of
> > their own, e.g. a CMDQ_OP_PRI_RESP for a page request. Disabling the SMMU
> > while one is in flight hands that command to a queue consuming nothing, so
> > its poll waits out a full timeout.
> 
> This seems like a sashiko hallucination?
> 
> There are no PRIs during probe. The initial STE table does not permit
> it.

Checked my long rework history. Yes... my bad..

> > Two paths disable the SMMU while those IRQs are still requested: a failing
> > arm_smmu_device_reset() returns to a probe that disables the device itself,
> > and arm_smmu_disable_action() covers an unbind or any later probe failure.
> > Both can run after arm_smmu_setup_irqs() requested the IRQs.
> 
> That's fscking devm again. Do not mix devm and non devm CALLS. It
> doesn't work:
> 
> 	ret = arm_smmu_device_reset(smmu);
> 	if (ret) {
> 		arm_smmu_device_disable(smmu);   <-------------------
> 		return ret;
> 	}
> 
> 	/* Register last so it unwinds first, while the CMDQ is still up. */
> 	ret = devm_add_action_or_reset(smmu->dev, arm_smmu_disable_action, smmu);
> 	if (ret)
> 		return ret;

This seems requiring a reorder.

> When devm is devm'ing properly the existing devm irq handlers will be
> torn down before disable_action and we don't need to open code a
> disable_irq

I see. Yes.

> That just leaves shutdown, and I'm not sure how that is supposed to
> work, we can't just halt the SMMU while there are any threads running
> around still poking at it. I forget the context shutdown runs in, but
> if concurrency is shut down already then its fine to not disable the
> irqs.
> 
> If not, it doesn't work safely for lots of reasons, and disable_irq is
> not going to fix it enough.
> 
> Maybe that is something to tackle after the power management series as
> shutdown is sort of like power down.

OK. Let's leave it.

Thanks
Nicolin
