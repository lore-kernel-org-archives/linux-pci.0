Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793920561;
	b=1CbXnX85sXS3aNwkyhlfVSRsaDwVekWgn2cLrz8Ujs+8ucAl0sNqLEz1ppG2aIpXXqZH
	 Hi83GMUNkLUA6GkScYFZVmJ+MSuZKMg+ZSt/XvzvZDqzaHait/EgCGSAk24sfW0RtwBQk
	 +dEFEuCCN1+IMTegSYb/D4VbsbhJtTgaPJXhapQKG7JaVGp0IudZvdI7F0wkTB4KhiRm4
	 3rLuRqzg6nKlbkMBIn/j7qfX3OuSNdQNDd7UktEjnvlQel9xjm3MEFqj7MBfdhZtkkWQs
	 oxVC5qYavnO8nlm6WYr8dksH04mYI3Hgrb/hgHn2EmMz3GDqkkWNn0RN6XicwXWI31g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920561;
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
	bh=E6GxLW5NSQ4ZvABJIB4nQLCcT/wfxIlZCN+ZhDtMCiA=;
	b=kO6aS5WUlO1oY9vhzdWMAiSuRh1522RP7FO8iDhnVPeoNBq7Pmz5zOr3+jXYMwUmLCb1
	 Cbgv+60RJFzQ/mYxDp02TIdxRqyeQi47vyu2iOR1PoHjFs6A9nZSpYpG4zGOkXQGlE/8o
	 ku7eqN3t99ppoD0NwbRSYEO39gKxzUHaUo+NRUa49u37rL9UI/gD2/ifJJTRBpKebrSPx
	 y2tcYIdhR37IrwoorFdhXBl+gcnT42vbLK6IRL2H30dnNQ0ewVET36eMdQkUrPnxHxg1Y
	 HpN12qKkE10BnYMW8vu5wURH4PA4coAydObQlkyOFnk54x9SkFErm9RJIxdwHXcSrfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GUygCxjV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.16
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010016.outbound.protection.outlook.com [40.93.198.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9EE606A31B;
	Thu,  5 Nov 2026 23:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A9EE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GUygCxjV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YzKblt8orWbi0VE56LXHpKfRISQczILbpi6pf5gse9k9KuwH1HT5ChMHfTYaVl/SBeyzj9lsUtO8e8aymO3IqJAyQESFjIbICNAGHyCjp0OpUAFtophg13xHmQLyqLMLXBhxY3C0mT+Wu/N58hCxjTJLJchtJrsRbRGVTKas5t+C5LxoYcroJKXGNjEQ50b6/K5D03QyM1ODA4Ro8Lkqshtrqep/JYhtdyBIJjQq9erkGajuln9d/Hccdf/Xl5SjxIBE30ZkxClRz0IdIFaEZaUwZd98yh07Or3CvRM9VM4Kc2DmU/jIVVkpfyNyrTekWGLtXoPfrnUOjo63zUbu9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6GxLW5NSQ4ZvABJIB4nQLCcT/wfxIlZCN+ZhDtMCiA=;
 b=bNeUHwI8Ojn6ji+pfSSYmGXrQjz0mPFZZYhLJdy9zFJANjKH3BQuVmz6gh8jdZwz/A7pXNcaIyiffacPX1/z/KkypHoswVXFDvTaehihBirMLMohdr689ygP0D0aK1y4/Hsedtdw++Ia9uU9idI30YOmRQQkz6xvynmS4qknsdVIYe9AOyiUQ+YJU9tTFv0YeXHEszBjhF+v2FlCVsxQO9a9jgdsNbEnXGqxh46Bnyyd0AdIpEI2pBLvwME6jpk8Uilh5FCpmJ219Z9WhsiOHXwcD4eW1ovu9aU1BogM73whjBvVTa0d00mD1Tgpo33lX5h9CZ9Zu6OalW5QRZD/hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6GxLW5NSQ4ZvABJIB4nQLCcT/wfxIlZCN+ZhDtMCiA=;
 b=GUygCxjVOpqFddgQaYCjpirD+5Pevt4mi2I/t+CH/4azWKcFhHy3S1MNG1Y8BY2U730hALKJl0Bgh1rsQlDX2/JwcnlLse9TyYvmkgk+SoXWqrmHhdvp0B6XsqVSobaeQyQ2QRJkGOQJanGRHIQLggJDvhHoEM8hA/h3RPWg2nFmklkw4Onr5KicUBGF1dTsQA5ADeq/pGMTIxUfxC9kscQ7Eg9xn2jIk4QyXvz6ZQDAb02DOpj2Nm8npfJ1xH4pnfUqTXXJYfBrzVMyd/z3wB9dfbnJIZ1HYDtRpQcWyQmHpl1g4uybU7Q4PTiOuPOeLDlk/ycPhqxheKgSMFE/DQ==
Received: from CY5PR10CA0018.namprd10.prod.outlook.com (2603:10b6:930:1c::32)
 by CH3PR12MB9196.namprd12.prod.outlook.com (2603:10b6:610:197::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 23:15:53 +0000
Received: from CY7PEPF000000F1.namprd05.prod.outlook.com
 (2603:10b6:930:1c:cafe::9c) by CY5PR10CA0018.outlook.office365.com
 (2603:10b6:930:1c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 23:15:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY7PEPF000000F1.mail.protection.outlook.com (10.167.247.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 23:15:52 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 15:15:36 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 15:15:36 -0800
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Thu, 5 Nov 2026 15:15:33 -0800
Date: Thu, 5 Nov 2026 15:15:30 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Danny Gonzalez <digonzal@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
	David Decotigny <decot@google.com>, Sheena Mohan <sheenamo@google.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jason Gunthorpe
	<jgg@nvidia.com>, Pranjal Shrivastava <praan@google.com>, Joerg Roedel
	<joerg.roedel@amd.com>, Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian
	<kevin.tian@intel.com>
Subject: Re: [PATCH] PCI/ATS: Disable ATS when ACS TB is set upstream
Message-ID: <au0OEn8xLzsIhQIQ@nvidia.com>
References: <20261020181053.2646782-1-digonzal@google.com>
 <20261105230412.GA1450377@bhelgaas>
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
In-Reply-To: <20261105230412.GA1450377@bhelgaas>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F1:EE_|CH3PR12MB9196:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c0362b8-143f-4270-6a5d-08df3b92bce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|7416014|18002099003|22082099003|10067099003|4143699003|261026140227099003|11063799006|261026121527099003|261028144727099003|261021135927099003|56012099006|261009221227099003|261022105027099003|261022075727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	L87CAAjAaSEiyDL3mr2ty2p9QHPa8uofq9oqjZro9/W/1jdAKlLaSVkSogoRPxvWn8gYNOxvYcz2jt4UTJ/vDNf6pdlZNv7q9KlncbnBfEIrTQEOJZ8B2xSc9NwHPFA0+xXx4nrKlgrwKNvEYgcewG8G7ECP6mlAQctamAP7p2GVnRSe4/XP8EN+/HWPE9e85GKm+v4QQ8Dv/K/njyJpSTxTVCypq6khfc54n126T52Mwycys61VzIlJ80J1kx7ficBfD0dGGp9Iz9iSgjYSfPjIFpPQ8FZWX/vaCovcUSxkbD30eYCmB7SJ2EihjwoQ5XJXU951KYz2SbvPT9Yei67KC8ViHvm3loxC8DVdX+Daa7L8+1/76lA38eBCht8DNOxgfhK3Ykj9i2ixJEEi2rjxKHstvfex1rD10HrQaLHQvJr8desE58aX/vUCPqUdu3qJ5fhNsk7VawKfbiWYJQ1xpm+fcB/RIBMMAP2lZ1TQjVavAZRB3+1JP8hmGxNKGJOL9+uTvNGzRXOlpVzFAOd8v9MOpkR89uraDXGkfaHuZPNPcPbx6DcGHElTj0+STAHu99pHNDT3y3z+KZ3ar0uiU0U4BVaJbBIb4Vlcg1x0f1S03YjiMoJsL+3pEmYI8wpd8bCo0FjVWp+oS1YfwI9jqijy6szSs4hBedC9iaR4Y3LkNC253s8wk6Ui7o+ymf+oqd5yj6LtW072/iIBhQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(10067099003)(4143699003)(261026140227099003)(11063799006)(261026121527099003)(261028144727099003)(261021135927099003)(56012099006)(261009221227099003)(261022105027099003)(261022075727099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QAqCTU0rit2IkgxNjRB0q602f8ev+UooF+hdC+SRBoI51eaL3M3lQa9gJthw6cB+2SNL/S4Tz1uWznQlZgJqOy7sC004U2mT+OcD6mp2rsOI8KWV8BngYUfeprxW5mE/VJiQnbH9EjVmKBceBvHmK6xp2qIt29VLk9aNAa5Sxk9bA5+xJ1O2invj0JGL63YvuYR+QCiJqxbw+QFCponO7JXuKSd1ao+FT1KyjW6R0GUZrBAtJjUsU4OZYMQ84yzBTsCg1rtxClEagSz/cflxbRo1R0r/qUo1zDe3yYyFtY74M+Fs6Lpty1fN+IebW1PDfqe+vJBc8CcE+Z60uNR6Ce+vBT/7nhLZ2OjkmW88BSQEzu/l6dCWk9AUuUuksNFOfUqF9lM9EX24rfOUOw7Y6v40LPJj2gQzkNEXDBVQMCWXJzlMlsNtYbUjJzxRxK9z
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 23:15:52.9571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0362b8-143f-4270-6a5d-08df3b92bce9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY7PEPF000000F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9196

On Thu, Nov 05, 2026 at 05:04:12PM -0600, Bjorn Helgaas wrote:
>   * pci_dev_reset_iommu_prepare() vs pci_dev_reset_iommu_done()
> 
>       Different values will make gdev->reset_depth, group->recovery_cnt,
>       group->domain, and gdev->blocked get out of sync.
> 
>       I think it would be better if _iommu_prepare() and _iommu_done()
>       themselves tracked what _iommu_done() needs to do, for example
>       they could do something like this:
> 
>         int pci_dev_reset_iommu_prepare(struct pci_dev *pdev, bool *restore)
>         {
>             if (!pci_ats_supported(pdev) || !dev_has_iommu(&pdev->dev)) {
>                 *restore = false;
>                 return 0;
>             }
> 
>             *restore = true;
>             ...
>         }
> 
>       Then pci_dev_reset_iommu_done() wouldn't need to call
>       pci_ats_supported() or dev_has_iommu(), and users would look like
>       this:
> 
>         int pcie_flr(...)
>         {
>             bool restore;
> 
>             ret = pci_dev_reset_iommu_prepare(dev, &restore);
>             ...
>             if (restore)
>                 pci_dev_reset_iommu_done(dev);
>         }
> 
>       Or I guess we could call pci_dev_reset_iommu_done()
>       unconditionally and pass it 'restore' and it could test it

If the condition here is "an upstream bridge becomes inaccessible
during a reset", then the reset/flr itself fails?

The patch that you acked yesterday handles such a case:
https://lore.kernel.org/linux-iommu/20261105001312.GA1479227@bhelgaas/

Nicolin
