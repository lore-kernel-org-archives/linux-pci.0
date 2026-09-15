Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013027.outbound.protection.outlook.com [40.93.201.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FC9388869;
	Tue, 15 Sep 2026 12:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475742; cv=fail; b=TqshzGmfPTnRH7d0hT9/EbZ3bjl6+CrXRwqBDXrcWSCHeXKjMJspOLwRrFD6f0Y6nDxS353GyuNiJ1YIOdsE3TMkOCiytr0bVEbkVBZ7zHqE5GmJKMgxAtD/2yly0KDzuP1WT+DBEUfylNUaSd9c7Vmt+pleGs6wpxck8tBYXKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475742; c=relaxed/simple;
	bh=eCcU+aaUapiQDrqXCs9m7JwSFYKajjBmN3A+z4wtLp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CwwISl2dF4p6MxUWTqEWZ4e0eeGgzeesozEhYuR6NzAXLtrkrEE125vwoLrcVAicB1fOwHxrcoQPmRnkCdiGyAzFR3ugQZn3hH5B3Aa26r8iEhnAE6rjI1007XqNYoXjw24P5PQIpjAVzfhyic/JJbfpx0qhFLx4M46yJNBNZ6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NszW7EnK; arc=fail smtp.client-ip=40.93.201.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NszW7EnK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwFPvK/4Uyw7THpn7fQTR/0NFefqD0RL2JtfspX91FlumwqGxXybcC96yRzQ4R6qIAZs3l9JzAHIdhGfuc7N05bxHIb3QNfa2ahvoiyULDfdzL4eeQk6A2K/Efri6hcY3XYKGt3b0pCwcBUD4BX0E872njy8JUrypEm53n8JW0AKKuf29WsMYo84S+KvUzjRXvJLB6RZUTjRBsNAtY4uXYjIbe8oMhuPfi7Z/PuM2geb4BtLA0CNX54FNZhdjwEKAP9RNoOVVerjlQzOz5ZPuBy1z7Nvj7LHg28ewXQMo+1glXYHrO+GdbFQysJ82yJluKI0gd4wcJHMFPbV9H9dBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHyxs1l/Cb1Cpk+5WQfeX6JtTRVTsfYJjkFzaJUfOhY=;
 b=rCB26eaTdw82AKnM29itBQGu6fvUpvc79WVZoqnjQVROzV/P6pUdJCush9M8rTKyRqkk6GDkw2WLdLNPpcOGDoZwl8gdAJHyZvO+e4/BvFn4g0q6Ttuhto2c8OmLzbq5wZyUUjPDBCXS4af6raNgjszoXFAWgM6FaoL3WEU07jRPiMMk8Ttl1s+P6M7ejFPM6ny5/Mcm/EvpDw0FH5QLzfwd/D//FCQfYYsdEAH+aGfap7QZup1MuAKa6JBt12o5hoStgPaPeassnMbDYewS6+xtUwOzD5PTw4Ki6GjwjbdS19LrGHRu/f6eG55CRMRuX/DEKfavj6cR9OjjQPUz/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHyxs1l/Cb1Cpk+5WQfeX6JtTRVTsfYJjkFzaJUfOhY=;
 b=NszW7EnKwTiuP6vK/ULkLakXkaXpJ3RmDDORXl53TR8s3cvCCxV69RiEzvg54dCDxbJwEqi1pkfiUlNiln1nbkG3Br+YSPcg2P2Uic6cOd60R0ESvEvEhdTmAzpvnUV3jrsqzUvA54C9zxhUY3Q8CRgTGMHYnAJSplQp9FGmD3yH2g9xSET1/XFHDvBpGxdHnxnfSNua89gJ7LjKiIS7lQtIC//ZA59FimVQt9PfkHJQUwWcsr+cIOe+R7vnJo3a96Sk84eejLftH8wLEypEJo+nCyDhxjtctb2pKxEdforKpCOv54QJb/IG47Fd1WMiS+Q9WJIgIlEsyeeNq2c+rQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by SA0PR12MB4415.namprd12.prod.outlook.com
 (2603:10b6:806:70::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 12:35:37 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 12:35:37 +0000
Date: Tue, 15 Sep 2026 09:35:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Matt Evans <matt@ozlabs.org>
Cc: Leon Romanovsky <leon@kernel.org>, Alex Williamson <alex@shazbot.org>,
	Alex Mastro <amastro@fb.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Pranjal Shrivastava <praan@google.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 9/9] vfio/pci: Permanently revoke a DMABUF on request
Message-ID: <20260915123517.GS3968357@nvidia.com>
References: <20260911214200.33793-1-matt@ozlabs.org>
 <20260911214200.33793-10-matt@ozlabs.org>
 <20260913165244.GW13683@unreal>
 <20260914113647.GL3968357@nvidia.com>
 <20260914115456.GY13683@unreal>
 <f21c409d-5675-4c87-8b16-850bcb9474df@ozlabs.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f21c409d-5675-4c87-8b16-850bcb9474df@ozlabs.org>
X-ClientProxiedBy: YT4PR01CA0416.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::15) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|SA0PR12MB4415:EE_
X-MS-Office365-Filtering-Correlation-Id: 08bb8c57-35be-4f26-3de1-08df1325cca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|18002099003|22082099003|4143699003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	gIpgkj7pkT3cQtEUnti9okPdNGMJQAqUvopE+5dklG5y7dvNqg1q2aPrqpZHE7u8CVutV2suY5l6Yn54yvkpOyo2VIlOv+jvvBu+s5L/oR3LlS5fMGPrjTz8MLdODSEs9+x7kHijut/nbOcZm5fvzqRgNM0VIaukV5tUdCSCQRobBqeC4Rkb+TN5mHuYrrTHvdjc2JVz12Q+/G6MSiMrmNxEqc55PXPEGtEnZGf6V7SUUQuaxZ+8A2xO52W8SRjMCt7b+y8X4uj8tEBK1b+HJqO3SdOvK1DV689KqXKQOdTHU2bFnC8SCCD3RR7AGep6za9WRp6b0fG52AI38lwL5KJdrg9WUwom/rgFxAWHqQrGqY7QHlTZWixf5mWUFekyKl6ptAvyRgfm+spKMyYMqUJOhQqPGpwM9ngKRk0l5Nqt5s2yhpC5jgZaK7QFQqKnIEq2hYRC4qCeDz1H5TXFdSXkG4TwBMys0CIgYU2moBE34PCAo9UlxeWnqDNSWF5nVMTW3pzgsWs5Z8frIz/orPHg6ttYOAkmDFW7MZAO5OdATznOfaHuT5/vDo2bTtIehFXyAjLap6P43tY3AVwVtUTi20PDYz7YhEb+SLJmO6SDv+qpn2Aj9cBXORG7TqCnGomJTR6sSJOb9wS4ZV74/LHTO08C92ytPtAVjdKQ11A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(4143699003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1eWR1DoH90ciC/q44Fcy01YXHaZxyV1kPzUHUDArvZyZWAOpvq0/ErnP72We?=
 =?us-ascii?Q?NX5pxPwVNWzCfmkGR8TxpjoKZ8YVgTtk8pDRoxE+zEwxq3qMpHuV7PbSNPOH?=
 =?us-ascii?Q?OUDD4Ku2YFtLbiftY2af4cdVhQksoD/+jRVk4BjPb2IJtdLnOQA79xzaGhGu?=
 =?us-ascii?Q?INeUs0aZBdWuwHpYctQkuLikTrpyG2F3R+VUEk/5cWNNdIh+rz7tnA77vdNG?=
 =?us-ascii?Q?zP5lBoaSZ9BUT2e5f/2v/s1jObXlspmsbDMu8gXIlNP7pvFzOVaVcFAUWbOM?=
 =?us-ascii?Q?cc9uMZSTYcsDZGoGNTeyxt5bcLsH14LTvOiCosvjS4n5Dt1cWqxNneLKGYbJ?=
 =?us-ascii?Q?Zrq9XK8L6qCfMIn3jevRCyQUGflyuWeW08sq3kJKHw9GhFgW2Zl/TLrYf5Ja?=
 =?us-ascii?Q?hs1mPkafQnv9yFB4j+onNkGgkOlzpnl+fCsBVxt8hEsVf3b60kR7kAjPhZ/C?=
 =?us-ascii?Q?qwp2cVzJ5deFHBffjrKoRTrIGKi5d9S2zaJUfWpLd0QFiAcMTSvjlbf7CX0s?=
 =?us-ascii?Q?JlOmG32xj/JP3VG0F2oTRZ0vA72b2D7a43+fFDwxbIjhjUE+pIYBd4xha81v?=
 =?us-ascii?Q?GOUnvcQmUH+8nFE87WZJRKmmOnTSBLBTg0tzUzapcfG/TXYY90Xmwvkh3MSK?=
 =?us-ascii?Q?nkY+Ot7vmb3M4Y8ZzEWbnFc1m+f6NPaLSllY8cADOEcczmNiQ+3ca+QrkZOp?=
 =?us-ascii?Q?dfu/wfs/os3SxqUFrtXFE1g4ViQeE3a47KXcSoFgFz0tRDybe8Pk9IbGCyvs?=
 =?us-ascii?Q?7ZWkqXiUBNv5bPwwwKjEAj8CZT9A2E3oV0OOt2LaAPfPLBBq9ZpQoicjSPH9?=
 =?us-ascii?Q?WKk68fXsShkzw7Q9w4Wk6ZH32qbHM3KwjDsCz/fwgCtWMGzrLNY5puTkcGN4?=
 =?us-ascii?Q?N1RwSph/1+htqZLR8iUwoSY5tEBLNFojfpK5Rtd5FJxjWHx+p3bR8rZUhgk/?=
 =?us-ascii?Q?xmo8StKGdOwNUyXh2ypMJlfG64AGcjqrXYynDzHLp+T7YUUQNfpJkW6oxQg3?=
 =?us-ascii?Q?VSLKKAfGe4PUnlbcoDaOeHa/d2PxTHb7FPG7aur5iHeya0xYcKmXEiq5iBGv?=
 =?us-ascii?Q?JxXXGpOccqFwHOZ2pWPALojxlD5sZAm0IRacV7s4zes3Q/Xa0ATdPs/gzuFL?=
 =?us-ascii?Q?Xm8waJ4rt0hcS02S1PgMmJqtChblCyznSob1e1uqgkoB5vvO/o9LaBoBMzbW?=
 =?us-ascii?Q?BUEUEMOKd/kmJXN5I3sFfZ+885TtdK//gVWBKWthMFrBcbUY/yd9W5aDqbFk?=
 =?us-ascii?Q?Jb/3RnYgD0A6udaZCtrNUPKssM+mE2iFPHpZ3uOK34xwJ3UtJiKI2o6vVQNl?=
 =?us-ascii?Q?06m48DjOS+bFTh9exOVcUTxM2w7FJ15AFpWTP8PA0xTsMBI7fotwKdqzszBX?=
 =?us-ascii?Q?6wfsUkLTtyCMRY4FFmcKPDlhXU2wCB40fwFTyH/iwg6D5eQTQqyWMN3eWIDm?=
 =?us-ascii?Q?gKfF0mUXccC9aIqfvpJytKhoEsMT3lLDFBP0uvyqsQM1WnSLCkbWbFC4NZ5F?=
 =?us-ascii?Q?TQqLiVCg/lhP+VkLwbLilE5t8yYG7cmidxL7R+CZzll/oaCXbym8ZNvf3vRw?=
 =?us-ascii?Q?ShGecnxtXrJepKzvLCM2kiruJhArrScgx+8hXvC2XuPoMDHPzlfZsQlVzJPV?=
 =?us-ascii?Q?DBp3Gurre4WbIxEpEi/2TYJBbjyu8YAVIIPEmue/DZ0gGtGWCc4w1OaghB0Y?=
 =?us-ascii?Q?F5pDTzvw+Yls2MSdOXehResqEFueEWrEY/SagLDkJ1A/ZfvF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08bb8c57-35be-4f26-3de1-08df1325cca8
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 12:35:17.9141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: In3CKsuJIK9HVNWhsULaKQyIWFknsB3uMtJwga4W+84G3VTjUjBs0getdHio/8Oo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415

On Mon, Sep 14, 2026 at 01:13:36PM +0100, Matt Evans wrote:
> "This is useful for lifecycle management, to reclaim VFIO PCI BAR
> ranges previously delegated to a subordinate client process: by
> revoking, the driver process can ensure that the loaned resources are
> made inaccessible when the client is deemed "done".  The original
> DMABUF is defunct, and BAR resources can then be safely re-exported
> for use by new clients."

This makes the point clear, you want a way to permanently revoke a
specific dmabuf fd and render it forever unable to access any
underlying memory.

You want to do this so the vendor can fence the vendee without
requiring its co-operation.

"temporary revoke" ie what VFIO already does around reset is a
different thing.

Jason
