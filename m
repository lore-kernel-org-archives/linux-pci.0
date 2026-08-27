Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011049.outbound.protection.outlook.com [52.101.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E0E351C25;
	Thu, 27 Aug 2026 21:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787865523; cv=fail; b=K/faehPNgkQYGdTJFaT7sJTWvQW4qsGRIAW7+6kE4xjpgwQLNb3kJ7m335e/OA6UqSeKflQCosiCdFgqDOyDFPmjnNkRZDQsOJoCPAlUY9+Y6F3fucvw1mie8U/KXYQYiLO9lYka+/wrm6S1JQdsCMBc+/ih8o5LO7stLNLgAUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787865523; c=relaxed/simple;
	bh=wjU10iIBiJbSFUk78H1U6aBHSXCGVeTyqFjnkMgbMVo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1YW1kRwzI7o813yKQx7N+qt3Un6mDCHxOji1HpiWiq1a762Ylrng4prQv5unKOvnVs4qlOk8itLhBqQhZe/G+xiG9B/rqWnoTPn9ClDMCFugSpaH/Q0t+bewLXIoAcv+QC+SYWT3EH1EI57WDOPj171sRaS8wnlgmTgGETXYg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QBSzRNqD; arc=fail smtp.client-ip=52.101.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QBSzRNqD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPJMJRL2J9r/2wxD9iVCZaXSik8piIUdZscp9a0tu7s+xGLPe1wawJUXWOwiRyDVZkot4Z169rOxl3GHUSwFreL2I50X61bjVeuthN57XwTxBavtpnsyvXTWxmlAYjocs8rTUl2tdefrNeMz/dj3GEqyoDOkMDmAVubi83SY0d65Hlnwd3n9KVYQ3VJxQcguJ+LQo/7duCwTPxSYb55lBsEc6QY3lYlkGJ8mGmlF4ZHekEYl8n82QEo4ujK5p0x4nQTkQzIxTxo8sUCTQpo8b8tjEX2PnZLKK9cgo1KrrVq/WePeebbEyb5dOjxwqcZoDWbqYVylkWpWhdrX/0uKxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXK9lcH5CMfHUok0XqeobXGMAZjRbc686Z1IhY6QlVo=;
 b=EJJjJIrgwcSEzHGjSQIE1dTmqtIXgr7CQImIF+FW9sa0VLtNw6g+JgJMT10B7HkjFwOEc8cMFrf1KDetn+lAT0EBmPoFH6mVrIHZpaKqYR2dUPOmIAHyiEoLvwRSwoFZMbSZvZa9zqp4s/Mz5NwKLvW1Tyn3wCUJF0vFPJXuAaEreamS5zvAVjha7CKF4M30/yTUuReKTy29ZhzAm0JbPRMk6ibsk/3G0w/7SecOLVF8+59RMLy6zHKSt7wPts/nxJQYjoML+jrmq9XIrB0vQa+QCnhwq+BpT4RdQ1jjhIf+ty2SjWvKo+0n2+/VKOAeomfltixxN0fzJrgA9R67Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXK9lcH5CMfHUok0XqeobXGMAZjRbc686Z1IhY6QlVo=;
 b=QBSzRNqDVKhBPphQQqEAALim5hBANzYAJY3RBX1lhRkXib2Xde8y6U3PErvowX5Duccracr1tu2G/9cf87SZO6weSSwPzeJFmtnsU91j4r31dytpC6htw/TWVRc8Z+a2lcECxMLWCchwsFMzSQAnW4dfrbDxdEDyNQErLKMjEE+ucJLROAw883DLPJS4ap0bOjOrTQbzOQp5dIG9B2GIpHo6TMG5HqyJ2MerLLumOfB01yJqm3u0iuVb5cHqwlJyHiJtDbLx2A6ZOh6DcRC6mKGgfuTaTv0sr40VCj3mCDz6GjIzQo9VFV997+arTu/VJmLFcfzNae5I+DWWFg9yvQ==
Received: from BN9PR03CA0446.namprd03.prod.outlook.com (2603:10b6:408:113::31)
 by IA1PR12MB6412.namprd12.prod.outlook.com (2603:10b6:208:3af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Thu, 27 Aug
 2026 21:18:33 +0000
Received: from BN7PEPF0000009F.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::40) by BN9PR03CA0446.outlook.office365.com
 (2603:10b6:408:113::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 21:18:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN7PEPF0000009F.mail.protection.outlook.com (10.167.248.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 27 Aug 2026 21:18:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 27 Aug
 2026 14:18:10 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 27 Aug
 2026 14:18:10 -0700
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Thu, 27 Aug 2026 14:18:08 -0700
Date: Thu, 27 Aug 2026 14:18:08 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J .
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, "Pranjal
 Shrivastava" <praan@google.com>, Mostafa Saleh <smostafa@google.com>, Lu
 Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vsethi@nvidia.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v5 03/18] PCI: Propagate FLR return values to callers
Message-ID: <apCpkJaysSLVY4mr@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <b00acbe0755fa5999491368eaac26a78d522e2ed.1783044582.git.nicolinc@nvidia.com>
 <178786269177.3808739.6763094519382046767.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <178786269177.3808739.6763094519382046767.b4-review@b4>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009F:EE_|IA1PR12MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f248a6e-dbd5-470a-5c7a-08df0480bfcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|23010399003|6133799003|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rKwPuLNcjaITRMMjGbIjDz5KN4Pc+ODlkeby4T+QLxy1mh0oNKgz+cojqyxBeNKHfN/fb9YYrsYVGfnHawK+l1yG39m9BJrNjZ6ZZG8MBaxWejSYFB0HvnTQGj4P+kaWnccYn/jsaZbtC2SfcXDp4ZW6Vpi1J/x25V243NifhzQKjXxJWZhsOfQC2wFEv2zlNLqzTWh3Plot/kfGwU6oOWmRItNihVU5tYzpZkiJP3OwHjtewc6e9nLM7VJqET/fS4VXb158nZiP3unTAlxdOauxSSEHB0sYeRujm0QwZ84Ke/4WXDWSISd+BNl4dK2rcoVauFe0tbLPsRzKWbE6PWNlZpEd5EjOrjyKWDtmz5iJR0LgheETenI8OsPjMuWlg3bDx4i5DalV1CTykV+XDSwZydAphO+mX5fNnO0+zkEAVCfQV+/kyYMl0KDyX72ockkk4RT03xIVxKjmGThrCsLHUpAhyS+dQXPAfdJ3QlwINfusffqGN71ItC9+l9JXjbDzXFUbbaajaOPhnmbWVE2gFVlEHVTEqwIVPE6Qe6IjeqcKpJLO1ux6/K1hXCMeHbYZNh3iOOPHAl+fRdk33YIp+9tXiPQCr4U+MAUAvNhPIMXwv5R+Zy7H62Ykjg9W3ovACkANoakCqQwF2nZI4Y8XBOhkB/rNO78Fr3cYfWZuXWxhjdJ8y6cNj5TjZ0C0wNnvd3MnuAb8SJHO1Y4XDA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(23010399003)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jdibQtJz9ZzzVAZeD/qLLVJhxmY3dRdS5zuQi1FCTdNfK6MEAHxNVujhfvKPX8zxQLUPt+sPtxzKivuVw2x/zwRjCrVCIIfVLKbuAuVW7/vw4m+YRZcsmNfbf07H8g+coRye1kC0Sd2bezk8til6p/UAo5wSX8JMzdqCA73osH6EWOnRbN93rLAledNQKfzvAuP5RIi7xSLZUMFrdyeaF6ATpvb3APw0/Kdydz7lOiZkmH3gGKbFdkPOSViszmJUoeL50hbvhSUgYkQD9y1CpPGU2UHCLkfKu/N/5rIb19La2K5PMA9Qa7ixNt3Zn9mcHMHkYsDnHUIsS4N8g3ov6Fl5QxsGdfdxlx1F73Bv0rxNVaj6Mr59pO5v5rAcLXZ3WkIN1DioAd5xP68SluTjX60gNn07G1JYaaZQB6C32G+PpXHQ7mKoP9pO/hJ/BGiD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 21:18:32.8425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f248a6e-dbd5-470a-5c7a-08df0480bfcf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF0000009F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6412

On Thu, Aug 27, 2026 at 05:31:31PM -0300, Jason Gunthorpe wrote:
> > [ ... 24 lines skipped ... ]
> > Since these quirks have always returned success, escalating
> > would be a new and harmful behavior: the next method is typically the plain
> > "flr" method, which would re-run the same FLR without the extra steps the
> > quirk wraps around its pcie_flr() call. Add quirk_flr_err() converting that
> > -ENOTTY to -ETIMEDOUT, so the cascade still stops at the quirk as before.
> > The early "not applicable" -ENOTTY returns are left intact, and they still
> > ask the caller to try the next method.
> 
> This seems like a very suspect AI conclusion to me.
> 
> I think I'd drop this patch
> 
> > Convert it at the quirk level rather than in pcie_flr() or pci_dev_wait(),
> > because those also serve the native "flr"/"af_flr"/"pm" methods, where the
> > -ENOTTY on timeout is deliberate per commit 91295d79d658 ("PCI: Handle FLR
> > failure and allow other reset types"): a timed-out native FLR escalates to
> > a stronger reset (e.g. bus reset), which skips no workaround there and may
> > recover the device. Converting in the core would also change the value seen
> > by every direct pcie_flr() caller.
> > 
> > This is not a bug fix, since these functions have always returned success
> > and the propagated values are only consumed by incoming work.
> 
> In what way? The quirks flows always succeed and it can keep always
> succeeding. If anyone finds this problematic they can properly
> propogate the error.
> 
> Squashing the error just for quirks makes little sense.

PATCH-5 forwards the return values to pci_dev_reset_iommu_done(),
so IOMMU can keep a device blocked on a nonzero result. Dropping
this patch would leave the three VF quirks here always reporting
success, reopening the stale-ATC issue this series is fixing for
them.

Or do you think it's okay?

Thanks
Nicolin
