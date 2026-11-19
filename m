Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795106390;
	b=UiX6iALB6FZbQQTgzGowuGpiE/XmTSV9o4AK6hL2Ykim+zqpv0pbzcgkCByFxoOdyYii
	 PBYaNp4EQG62LkaXdfnt3YSyOj3sfpQvfrNsVbTdB2NK+UlfsxQEHkl995zPx+XNBdmfD
	 btakmk4fY84l18TRkGjzNl5iw2eUzY1p4Tsg7FUv558LDzecByQvuCLbc4oFUfoakeOlg
	 pyVzFpdNWLTYYoEw9QlosBg6FaclEgecttKIF8+rmWV3K0ulXgn7LLh0nKLe7SH1io7ni
	 6YEZoKEWHvLiHrv7laoVr9AuB/zbf1LNuJtocOxRbLcm8XTg5FM3F3wEsi4I5RN6U/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106390;
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
	bh=kn/dK24Qe1uKj0FjgQU4/HEVvppIQ1y0U9NPAOLPehc=;
	b=RjW7AZKcH2UYis1fFNLwSkyR9JwLq71zl/htJkFG9A3pg1MGLPQPq+nJgkhLY1I46QSW
	 H8mGbj4+2LdPNrZ2ohZJ5baiTq7eNNZYOhNiANZ1q5oZSLzgDjiyyih4jz8nKovl+TTZ3
	 Y6lYcghwDpX3NeUM7nWRkCjJ63GabfujvQtcbo4hdeR8gmQK//p0HfVtvT2xDHxpUcWID
	 nSG69vkPU+mZ6Ta1nOG8OtiMoxkfYzD7bfCSL2VZC/qZ19kMoxvm3YJWQfex39vYnpPgx
	 W3JyFnIa5uH1J0EqjW1keV9SAVhxoBX6P4Cv6e+da7vBg7R7CrfntJ98X3o439yr2wg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JOxZ0QGG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.45
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010045.outbound.protection.outlook.com [52.101.56.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33791606A320;
	Thu, 19 Nov 2026 16:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33791606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JOxZ0QGG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmNZ7FEaYmqT5WMItb/bUIMzQcOLmcrK1EtQMvFiQWESBxSVVD1XDelYiIEGABu9vx+gq+4IJxrdchgHMYDkBFafnkRvLbW3TgJtHnZ2nlMGfeBBIx7JkqVygxNYbh2RuqTFVNRUMlQm6phfFuVaZGmRauNxbFRgD9I2UJWqR5kQMOSib89PqQ8wEgnApaTZH9/t/e1/o1HUv+5+tfgcpRAIOHkyW9FX/phbEytztaru+b6p92/unTWU6B7NW8+hCNxZEWJ2g1B2ARqSfAjTp9UyVQCTkh346fk64rs89du2euD1nfgrXkhKoIg4LrOo20O+6kkBRgvh5sFa3bh9pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kn/dK24Qe1uKj0FjgQU4/HEVvppIQ1y0U9NPAOLPehc=;
 b=GOJslwJd4h7uRM0sFyEX5vL7FgO8RQTjRuJR7aOHoYicNvzXvsjpq+x1MSXbPjNtC1IxYa33XHXgCVVZiFADExZ/urvnkDzv51uKUeXOtKV13jte7/jDbG2cp6xpwUV/p4KQiqjvafCBJYpYZcsfLZadKpEaQuAb/+xRN5JSi3ojni1E+Gbz2s42G//JbxvNYdkVvZ6asJ5PXu018j7kytMhcK8+K4V7MdXKIAO5VVcV7c5QukR6wp/687McX3UDKKmpWtSiFIHnunKB69UOBE4Uj7KwBsdWkuL4TeU1Dj1TVWu9GvwxQO/y1+XoYi8THz5ihjiAa7XABZ6zQ2CpTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kn/dK24Qe1uKj0FjgQU4/HEVvppIQ1y0U9NPAOLPehc=;
 b=JOxZ0QGGdAbKjgaN+RmtpmnDsGejmoNI+uDF8NQb/FlWVMSHxXtbsF1cK+MfwBg6XDTtRQBkzP6/C0JDW6oKRBxznO2+5zXiVGUqfj4nc6d9pgHowv5gdMi7aQvN8hX7J5Vdemyi/QEJ8FWABB+qP49M3yXBsoBOtM2Iau/pGe9Lrwnpk/B66nNqB28bM1h2aG0aMdyDsrPezH8bWqKEzCchj0DaIJ0lLSqgumRy1ojhsanF4zrmCZc89O21jNvJ1Yir+FGveHMLGOns6J8fnC+8X8GeLroJZFtIBFQ1KC3C3+lQXJWRsTU73pKBAAmx3SV7pXSe6loy9jCtNiKJoQ==
Received: from BN9PR03CA0676.namprd03.prod.outlook.com (2603:10b6:408:10e::21)
 by SA1PR12MB999107.namprd12.prod.outlook.com (2603:10b6:806:4a2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 16:39:43 +0000
Received: from BN7PEPF00000093.namprd03.prod.outlook.com
 (2603:10b6:408:10e:cafe::11) by BN9PR03CA0676.outlook.office365.com
 (2603:10b6:408:10e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 16:39:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN7PEPF00000093.mail.protection.outlook.com (10.167.245.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 16:39:43 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 08:39:16 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 19 Nov
 2026 08:39:16 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Thu, 19 Nov 2026 08:39:15 -0800
Date: Thu, 19 Nov 2026 08:39:13 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Vidya Sagar <vidyas@nvidia.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>, "Dave
 Jiang" <dave.jiang@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Joerg Roedel <joerg.roedel@amd.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, "Kevin Tian" <kevin.tian@intel.com>,
	<vsethi@nvidia.com>, <kthota@nvidia.com>, <mmaddireddy@nvidia.com>,
	<kumarahul@nvidia.com>, <sagar.tv@gmail.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V1 2/4] PCI: Don't run IOMMU reset hooks when only
 probing reset methods
Message-ID: <av8mMSeRUyobKMgJ@nvidia.com>
References: <20261119100628.1948990-1-vidyas@nvidia.com>
 <20261119100628.1948990-3-vidyas@nvidia.com>
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
In-Reply-To: <20261119100628.1948990-3-vidyas@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000093:EE_|SA1PR12MB999107:EE_
X-MS-Office365-Filtering-Correlation-Id: fe1ced02-0d9e-4c35-de21-08df465bb6d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|23010399003|261026140227099003|260925021311599003|260925021911599003|260925022911599003|56012099006|11063799006|4143699003|261021135927099003|261026121527099003|261021121427099003|261022105027099003|5023799004|261102123227099003|261022075727099003|261009223027099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OQ+2VKKRW0IFh3YnfjWGH+6qoe3RGZKjjNXBZUJz2PN7fBNmpoSFo/+DOZMZ1qZ5xd/r6Jkbdea9gUuWwY58RhmEp1wmLPaGE6sSWRAWmyH/MYaCHp0p60nGMh/zh6wSI09bcPG/UhC9IdZYh5ov7lRklqLBcCxMIP2Szt3J1mak0ha4zr5RvbrxaD35571KIQYb2oUomCo2uNtddbmFQbAzcfuA7wgY/O2S/KUp1lwaPd0ls120CME/fJjFoUc6tUn9pDwvE4w1rmGlX3lgrq3ekRiXqfKtUVK8AWpFsfmTZl9QKBDphB5R6zjVB8puVSaXA83IzWm/Cbhz4bSg222IrDmwajQI1OfKKQuVBPJorZN4+uFiLk+h//jopFTwFzDB2mD6nCl+Pw7ZNO/m72MWY4NaE8AFc1EIYtJfxaVnFNVH7V+qRL9WBHx+8rcMHIDhZ+xZBTnGc3HQ4WjS+Pcr6I553GZyj9M0JeLbhiOP2pCIeI7dNj76GzazxUGnvIkl5ZnM7nSu0TTMqNQ5nnaNvsQueUIZtAJ/0LC/Z+XB0Tr5WAJBgsBdmVI5wBqA3KIFFsnvnRfblgHA5nR48UEbnFupk10DqY9HhiGqkbYRZr1/aAgGx9+wfGTnsUxQFnkC5hx13C0PyTM/xFdd19IsCmpqxOnpb+czihYdZ0WgTPKzpzYmOdHb71O5XslwSlYt51Pwt0uMv5O0UzvCnw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(23010399003)(261026140227099003)(260925021311599003)(260925021911599003)(260925022911599003)(56012099006)(11063799006)(4143699003)(261021135927099003)(261026121527099003)(261021121427099003)(261022105027099003)(5023799004)(261102123227099003)(261022075727099003)(261009223027099003)(261028144727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IU+dcgqr8r3usKPxpXD6Tc29D4smojW37hWkL42gnCaUePnn3BW+UQU5BTVt89DeTbvm3X8VfRnzN42PBPzuAvQkoe7pBCM4kL1gAjq45QyAZsSsTvyVqGpYluG9QpocMcFmp1mXWLPiMQVwGGpdgqR08NctdASecVMupPGDMm5b0SJrNPKbaLFGG+h6J/tP8rEvy1E+H2r8MUEFTQgfLeeUjDwTbNhaVp108Bp7foxCh1NCRha4v5MgIcBoJeyj/et5Y2f++zgaCryWtwTTfCJPnJ60/dFyZdkWUZ4JeWba9+h7gTBwjOicvnt1TTI8k59xwgTQE5Gh/wJ2sA4WzadID4rryLJOobNIr3Z+6FswftOJd43ZILLK0LHLGE5zH2S6AcFOHoFyVCy3rhN/+DCIOLBnMOk33InG5ilfwDdqthBzpzazEZrhNLb1u4Wg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 16:39:43.1701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1ced02-0d9e-4c35-de21-08df465bb6d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF00000093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999107

On Thu, Nov 19, 2026 at 03:36:26PM +0530, Vidya Sagar wrote:
> pci_reset_bus_function() and __pci_dev_specific_reset() call
> pci_dev_reset_iommu_prepare() and pci_dev_reset_iommu_done() even when
> "probe" is set and no reset follows.  The other reset methods that use
> these hooks, pcie_flr(), pci_af_flr(), pci_pm_reset() and
> pci_dev_acpi_reset(), only call them when actually resetting.
> 
> Reset methods are probed at enumeration, before the IOMMU is set up, but
> also whenever "reset_method" is written in sysfs.  For an ATS-capable
> device behind an IOMMU, each such probe of "bus" or of a device-specific
> reset attaches the blocking domain and then re-attaches the device's
> domains.  That blocks any DMA in the window and, on arm-smmu-v3, sends
> ATC invalidations, even while a driver is bound and using the device.
> 
> Return before the IOMMU hooks when probing, as the other reset methods
> do.
> 
> Fixes: f5b16b802174 ("PCI: Suspend iommu function prior to resetting a device")

We already have a similar fix here that Bjorn acked:
https://lore.kernel.org/linux-iommu/c66d5221a8e4356316d4f614c8584a80dc9d71b6.1793729707.git.nicolinc@nvidia.com/

I am waiting for Joerg to take the series.

Nicolin
