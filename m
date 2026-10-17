Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011036.outbound.protection.outlook.com [52.101.62.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174872C026C;
	Sat, 17 Oct 2026 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792261039; cv=fail; b=WsSFDyDort/O7U0ZIyHmHQpi2cg4/ZrRoiPR0CHq4f+oQeJAC+JGtwb4zz4f8IA/upcmUkGasKSuZoi2u+PnVecC88Ar/4zD679d8YnytmTJiUOzoumyj5S1neYQXV1PQGZWDsT6jNythBSQcvfb81rkqpg2ijuT49LKj0yB6fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792261039; c=relaxed/simple;
	bh=XdFPmmzzMSkuWJqd2nTOHHfi2VdHNMB8iwnhCLwvLPs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOPx3DL1nzhp1UMkXHIsl4flgB/TpNWaZ0viGKLK3lnnDUiZrs5a05XhNrxbGSUjYaMiSPv28adpiwkdk2UgBdK1Tt10LnhcrXl/KYw6aYgkMknHX9BDb4zjlFXrJTR2lufbYSYTxHlmokEZla9hIEvC/LkZ9UKnqHtuDOSJBLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bBZzbY1M; arc=fail smtp.client-ip=52.101.62.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bBZzbY1M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkFaFyE40d5DXEUCI49IRKaYF646vw6y90ggXKbTdPT8k5FebjP9cgwujPA54YFAjLNDmJ6pSE/UKs2uXHyxGatkga0ZbtvSCe0fHSPbE7+bDBjH/DKF3c1s2zkO9S2zXxRzuuDgJFKPoX12/VXsj9MSY6O81ygwA3Wh0N5ilUbq+h5xUXPf7MQD6TKiE61GZnGN/dBeipLS2fC4GJAt6VU0h+WYEQh0z7vXmoHKAqkTHJ2MNmtjRFRVEufwL3iShBxaYjmnOnYIc7HqhezhjlaMEJ1z4+5yh3uqx9mYvAduWjw/vps8SUgXtLUahI93wDiv6TQ9lyogZeDRrKQIPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYjPQ3YxWnKnf8GbYnY1r6L7faIrZd0wqJX8FJ2o+Ls=;
 b=h6S7ccgbQW10RIhQbLHfIOUcHmb7tKn9RryTdKJ90c8j+k9gRhhC3tgJeLuDqQWDbVZ5CnkZhIqEN2Y9yKujmI1fKvyvMPQ8s/2hmxPnEh7M/GRUvQjLRBHfXBwNCyaV/Gc2yFh29XScZkVdnz0C6f2nyXgUzVdAs3Qs8m8aAWoOr9ukuH7I+6xpu2UfwOe1juLe+AwnHHIluMOoueOXVe6y4PUW5FMYrPRxk3kOE6iwW/rYTqNhcfeS7KCg2CjrzTOQMdAn5pvP+GO6NFOp7N8NdC8wLCwN6ID4VSm3aHHjN95+ipzhB2jgtUa9jtB+nJcx0GnV2b1lD9kquY17/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYjPQ3YxWnKnf8GbYnY1r6L7faIrZd0wqJX8FJ2o+Ls=;
 b=bBZzbY1Mgim9x97CayqL3gxWY7Ud9F7uMFJisBtEYTnGZfWdcBQBWSO8dhl3SBjUmjDvG9mhFHNaemHnkzbtdEv8w2YzUB+ysG9KTDrxHOyGBAK2u9J+wDq+2yNV4ezODqbhHTRg/yFUfuxU07JaYYhitrV+/UapbEGJMPrf50KpcLhJ+zqNTTck+jeThNJx5zvHbvn6p9cloloVsMnvAf4YI6TWbU86FsbHe4OqHUKV58yycfRmKUMklKXsCtVK9ZJysFIKHaqbtGSrtSh+nQXJyI5tic2KUm4atCXH45n2qZnpx79/HKoxx9qqddsnDS5sJ5qjqvPsHHh1quEs/g==
Received: from DS7PR03CA0010.namprd03.prod.outlook.com (2603:10b6:5:3b8::15)
 by CH0PR12MB8505.namprd12.prod.outlook.com (2603:10b6:610:193::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Sat, 17 Oct
 2026 18:17:02 +0000
Received: from CY6PEPF0000004E.namprd03.prod.outlook.com
 (2603:10b6:5:3b8:cafe::75) by DS7PR03CA0010.outlook.office365.com
 (2603:10b6:5:3b8::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.18 via Frontend Transport; Sat,
 17 Oct 2026 18:17:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY6PEPF0000004E.mail.protection.outlook.com (10.167.247.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Sat, 17 Oct 2026 18:17:02 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sat, 17 Oct
 2026 11:16:50 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sat, 17 Oct
 2026 11:16:49 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Sat, 17 Oct 2026 11:16:48 -0700
Date: Sat, 17 Oct 2026 11:16:45 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Pranjal Shrivastava <praan@google.com>, <iommu@lists.linux.dev>, "Will
 Deacon" <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, Robin Murphy
	<robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>, Daniel Mentz
	<danielmentz@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>, Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, <rafael@kernel.org>, "Danilo
 Krummrich" <dakr@kernel.org>, <driver-core@lists.linux.dev>
Subject: Re: [PATCH v11 11/16] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to
 gate CMDQ submissions
Message-ID: <atO7jTV+XNReShT+@nvidia.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-12-praan@google.com>
 <ar1yNtr7Kp2OTcDd@nvidia.com>
 <ar3yWUmi8E0k37Ml@google.com>
 <ar6gY9grmdMZcN/M@nvidia.com>
 <20261002164748.GD3481470@ziepe.ca>
 <asAeCz_rmpe5hbsh@google.com>
 <asUvUf4PZJ7JCLXp@nvidia.com>
 <20261017174912.GK14213@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261017174912.GK14213@ziepe.ca>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004E:EE_|CH0PR12MB8505:EE_
X-MS-Office365-Filtering-Correlation-Id: c3805e99-f6b8-4eaf-5b36-08df2c7ad7ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|23010399003|82310400026|56012099006|260925021311599003|260925021911599003|260925022911599003|4143699003|11063799006|261009223027099003|261009221227099003|10067099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	uOnMmTUM0lC85dP4zNzXyFbQrigkwAMK0BjDuOc8lNWnSCFptK53dtV5ItXxfdp96J42JPt/8zYs/+RR7ikxJbpu7vwLIZwQV49OlX+wnOwKHektXHDweXsxZ4g7SCfEQ4Grthg8XuqtyqMAlWO/1wxXgRY3rJtuvhjC4iIxq+EahRQSsQR4AM2aWBmLURiTigQkrlzwD/VBbW3Pb0s3j3DfOP3GrHOdPyskB7HYN7hkLjlTGuZTIL7QLsYdlbeaYuHFfEJDnM076Ggi8qT68R/cv4SJcINzdD167HD//eePvdlN6LmyqTF4yvGJWatMILkY48ctgMPusg3r2ocjs4pG/D0JXM6HI3ar7FNWS2gvRkrqgmQSonFckmodfcWtvfWJYuEi9delQq5HrgnvCbhDFQ8P4zMR4+sioC7Rd2mFwKrBX9+6ta5MewIMfhUjbAOWtpCm3Nc99CRMOKoqygXS/kwppkmA9GZ71NpzVDpLqa8RZwijHP+omW+KUyZlNw0RDiw/ZpFkl30QUcmD82e607o51OSr1l8rA6SY0a/VVi/AWtUOdk/VOSp+0KNXh5pYQewMPlNHtezb4tiNfhHXvJcYWniHZ1XcsioA3FivXjRDjWNnEGODOsi8GIPao2GOGCrKeIZSE7vXV0DRgIOKKI06aibaeDWPMEm1uPTaA0PoZTg221GMfIKjgwVvL6Vd0MD1SQnMUVX2nsq/Ow==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(23010399003)(82310400026)(56012099006)(260925021311599003)(260925021911599003)(260925022911599003)(4143699003)(11063799006)(261009223027099003)(261009221227099003)(10067099003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tKmPJ94/yib+oDkYUZ4q/qRqc8UHRoOrSzrpoWonyqiDU3FGiJKQISya5TapoLmtIOT2AxkY4PKkN3Z7ikUsI6SYXtyRCcztHiUMlrU+feYrzNCFWeUYHxjQnF9P9Z1USxfW8aAnYj8wCSUPtoj5RQYWSXdn22Cm1vC/KYxdPJSEX1B4zDxMRXL2NDw8d1cSFr4FTR3Bc6UwKk46gEHTDsqaFZ5+vAahTA6smTnN0vdLs5uIuYc5lnLuZlQC9akBmVJidn5LqdgePY+Qr/yu8xzoGN822OIdhWbyvD7Jhr3+rH+cdzcPhZIY4kZ8NkOGPw5Xks42pPOqGmF767ykZbVbyElATlSXefy4aCD5UYA9lqwcP8cDP9sFJeB9CqdcKQuYUFamcmtZmSXuhyNdiCJNvMLQuARpFiUFqYvffUBeMYR8Yu1oUWWM96/5nfDz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 18:17:02.4686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3805e99-f6b8-4eaf-5b36-08df2c7ad7ac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF0000004E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8505

On Sat, Oct 17, 2026 at 02:49:12PM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 06, 2026 at 10:26:41AM -0700, Nicolin Chen wrote:
> > > pci_dev_reset_iommu_prepare/done() pair (with slight refactoring) in EP's
> > > suspend/resume?
> > 
> > That sounds right to me, though a different API for suspend/resume
> > will be required. And call them in pci_pm_runtime_suspend/resume()
> > maybe.
> > 
> > Jason, how do you think about this?
> 
> Maybe lets just start by refusing power management when ATS is on? For
> PCIe devices too?
> 
> It isn't just ARM that has this issue, every iommu is busted if you
> suspend the PCI device while an ATS domain is still active..

So, should we put that refuse guard in pci_pm_runtime_suspend()?

I am thinking about splitting the iommu and pci patches out of my
smmmuv3_atc_timeout series. They could be get merged alone.

Then, we add a new API for pci_pm_runtime_suspend/resume() with a
new BLOCKED_SUSPEND reason in the list:
https://lore.kernel.org/linux-iommu/bf5ccc916593357c640cd7fcdffabfb46fdf4c64.1790188510.git.nicolinc@nvidia.com/

Nicolin
