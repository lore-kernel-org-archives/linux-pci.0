Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013051.outbound.protection.outlook.com [40.93.201.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B091834A3AB;
	Fri,  1 May 2026 23:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777679211; cv=fail; b=TCEVK9LPO+LD2Ei0rIPuVCPD0UnE3Bj89uiL3BasXVLHx/vulZtyMzYn9FYTybFMKqpNjTk0BfT1OHLu7UeYEkGlHFlsopcNBCzAVfLJSfE/AcyqLuvsKVSpgLK4ONaT44qBVfEh4C2RKWQ5JizsMNlywkuySfcIITmS0VIkLx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777679211; c=relaxed/simple;
	bh=LnMTtrYCr1sI6ocNilePtKJzlX9/3v5UotqlFD/eYdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kduB5wVUfMn13p0pIm6ZFIzLHb2KWtClDbAk8orE01JKbmdQRho9wUYP3AWob8BdV4aBvrlbkIDbFz3FOqCpfvdHDeob5YWuXHxeqIRc5xejz2bkRq5OigyPBHz0ZI2W17Tc0uIRLblLbBrOHm7ZMSLFyvBMJ1vjvHzl83iD340=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bn/J6+ms; arc=fail smtp.client-ip=40.93.201.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bn/J6+ms"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jP0ztPxXA7qXMWrOI+VRADHgvcI43/iSTW6nXTBi54q1vfwCZoH7MElKXUaZvl/O5LdTOW352lPBiNS2xHjoA1Rfdo8gHVuUIpvTmnu7WT7iQEpbpEOt91ZHc/B6x+bbdzl03qdbvwqVuQVs6kvMNVuqUOPOa+4LQ537S2HLDey1zC+57qMDICoO+6iXuETMugZxmva8EsU8oua+eSnpWnuAyRWW/GdbH29pRArviCac8WBsh94fVohLsg0eYnV3ngdivP6bHaz0x1UL5jl2AOSncrukbMvsHZr5ASOC8iV7lyQZFuCpOxsoxtBYqafAT5NymZtIcBo6Z9y4Ke831w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOW+3LD3hVmaVzm1BjhUO50sBN+CcYoYiT5kIe678Gs=;
 b=K6OHQTGSL1qCDmAQQLCZla1mlXFf+1Gb6XWdIdixfkPrSYNglnlJ0VOxodKY9XqsgzYoEY/MhLLQN12FvUZ8fY8/MpT9O7XFlikz0D2IKFX6BO8tY/mGpKL0dg5/tVOqtrY6gypAzeznFDzfepk7NjafWjbs6YOugZZAoqzwUsM/vXi9195kd+6J9WAT4NmZbFF5wKDTbw01Mc/X8iCqg0mxB4VCTY822u1eZ8ZLY4QacWkbkZc0Dz+1d0d0ZRViuh7/Bhkh2SiDYKzmYF2+Ej1WMbUElrnNR3DxA0Hp0bvXrrtQ+v36OJGxp7lzr+CCPU5BmLVbavGkuI6hOCkAsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOW+3LD3hVmaVzm1BjhUO50sBN+CcYoYiT5kIe678Gs=;
 b=bn/J6+ms8QQwa5/ZxOikHQ1+zDaE+op2Ld+S8HzJiJDL5qkaOv7wAuV3AyjSK5Ikp9WHGMdUA23LL8oL5MUvvJo2qtTY5rBuCOKrbyBtHM1iilRr8aAB53Cv+tyoYqGifeCneuOx5c+asEujzQcQ5dOyJhyx7mVKgaF3znh+FFEdRgD7USiQBTxIm215ugNrNP/6/vcy3clorRaP+XY2QaxcyilZNPUC+6JqthBsgnjrMqM17wq7gAo3EtR+goqGEa9WA7PJ8vpynx8HKzxBOUm9WdyPYtYYkRKFOSiaFeZzHJQPObBkp3lf7gUcEp3wGQZ5qQi80LohW7AkSN+I3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7511.namprd12.prod.outlook.com (2603:10b6:8:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Fri, 1 May
 2026 23:46:44 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 23:46:44 +0000
Date: Fri, 1 May 2026 20:46:41 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Dan Williams (nvidia)" <djbw@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, bhelgaas@google.com, joro@8bytes.org,
	praan@google.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, vsethi@nvidia.com,
	linux-cxl@vger.kernel.org, nirmoyd@nvidia.com
Subject: Re: [PATCH v4 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <20260501234641.GB1381708@nvidia.com>
References: <cover.1777269009.git.nicolinc@nvidia.com>
 <f6734b9dad0050138676f11ecd14e9db1cf6b697.1777269009.git.nicolinc@nvidia.com>
 <69f3cc82926_3291a910039@djbw-dev.notmuch>
 <afPlkW5zlTSHwQCT@Asurada-Nvidia>
 <69f536ed263dd_3291a910017@djbw-dev.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69f536ed263dd_3291a910017@djbw-dev.notmuch>
X-ClientProxiedBy: BYAPR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::42) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: beb77938-ca07-4a0f-0309-08dea7dbe68e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	hS2bgXcGDxf/kF7zL3sfzYG9anhY9Vt2jXN4+eaUL1jbULq3wN7ys/XbKg20Oe3EGZ6SuhLb0Bioggu/kByif5PRivhPxYOGSXtNuDcoCwf0rM7m/8KwCsl0m1UKTvy+P9pcnOVgpaRZP1tkX0m5DBm5dDxEvGKT3avUyvLee5LCIF2HeF+0B8weyZtVhsXzb8hwlAkofauuosHzyqHe6nzIhgKp0LlfTYxZ7hb7R7vxHKhTdJaK4uQDwpktcBqDa/TAIx9xzJPFJuAcH79/Bb4utCIL+oyK80Z23m9ItZRWJk4Nn1EB9ytxTksDrg/9w8hH8GF4CtnyNqd1fpZoPLgqr42simArpVydM8ULW2iHmHJ906Y5erQ719xHkgiJi9JcLDovMMfO/kYo8L9/UY5mLUdTcO+LOwYOWheg9FIpglvMgrKnZ+VKescYu7Xzb5Br/UO4oBMnWhFpcxf5Ei3qIPiDJV37AgQNUHlw2HSeU2i1nSk/ADJEvZKsBsRRLqxGoWyCzGRLPGX20V2+M8MfaX6N0AGRP7foIig6MtV2L49DthPe85n6pMh5RQuADpxPrEQV56XlpC2QCttZsTREPvMSi/zDTdjQAUiQh3SCqfoMgp7HRBg9OI+lAvc4Tpd3sTZ7tCJUHhPaV9OvL+wXWmiwYRLyfSCzJ52qsf2HXU7SC2FeZKVDs5O9Jbgj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JHzNKDww8fbfTiSI1pTp+Mmbej/3EBeRSXlML8XpoD4w4WQpQ4xlPxssV4R5?=
 =?us-ascii?Q?G5qapwUgsHhVwqeD1d3q/rxNa7Fft/W/6h8zVzzgPpvW1oN2Ukdjwsf0lx09?=
 =?us-ascii?Q?ZCsDvjiFlT8uII5Gl3ODPkj5N9+zeodNrZNEr08lPpDAOnNIDHx5vjzIiIjk?=
 =?us-ascii?Q?BguBpPTkI2R0a0Ad+gJCKPQOhgMgCbvIpW9foShPJdnEGuLBToA3pap9pmps?=
 =?us-ascii?Q?ymtLzjkmPoEpy4vmewZmRhiEq+jYvoTNODOnk/72XEBb+sGU0k5uVGXCB2rS?=
 =?us-ascii?Q?4bnOkR+/hQtBeBsd0/Rv1fqbVMala7rf4C5bduy2CS+kl8xemhZP/TEBQCtG?=
 =?us-ascii?Q?gA/YAgLLy2600bifdbFbzO09GDa0kvYDz8fdJ4LVIkvT3Azps83rvjkdohhP?=
 =?us-ascii?Q?1IfqH8wluitigdlkpz1P9p+bkBVd6eHTAlkkgkZuUjEsnYbjuwKdCWlUEsEu?=
 =?us-ascii?Q?Hu4LHuXdtkO4k2TyVdzbO2/EyjQk7mlPsteqCitTXwaDvibQWpQiGEnYY5pP?=
 =?us-ascii?Q?fs0rVbWd8DjBlueHISxoRbTHVghgj8woXmUdomeeU8LRz+6y6AsX+SJJt+FZ?=
 =?us-ascii?Q?Jokj8D1DDIPL7xVeoCZ1v5FYySjutoEg2jemkdsV21oJyZnc2GyUbSxpT/9j?=
 =?us-ascii?Q?9Uf9Wa4Gc7Q2kXq+KTT7eICOEXIEH2s3Sl/bGJfk479P0ACuyroK3xMglecw?=
 =?us-ascii?Q?4nTyEZ2uAoMruG7w+LOHqiuriXYjEmBmAXvt6tnN43NW57tQLX2OivNW9Fz8?=
 =?us-ascii?Q?7rQiW312mhxJHfrP3R6k1V0BVK4dk4RcG1Gy7R5YyBR6VWCi5hvd08uf11FR?=
 =?us-ascii?Q?x2qBm45d046D13Qep0RBzmSi/blXLmkfogdS9Z33udHLovlLvUZbpK2nYo3z?=
 =?us-ascii?Q?nu7oI1Zl8Vdfq8q2Yb4nqokeB/HxeCJzzR5iOtNtwA2bFDJSMN996AvYynFR?=
 =?us-ascii?Q?Yo0+gDNrq4wm/5tNysmw4F+EP9Y7B4mPUuOtR6E4VYz6mMNS2+bVxbSObLY6?=
 =?us-ascii?Q?lEU++OlfgBQn1fI9qAGgAqWuQL6sHF/JgEO9lPAxcm4d4DgNmMsXmLUCQ9pZ?=
 =?us-ascii?Q?bkyKzBnIoWfRmwJKbTex13ygVr1bG0LL9ibcwMtwmWZiAQ1aRUihZNbbV3AJ?=
 =?us-ascii?Q?/oZJskSnUyr2GjA4r+p3unmgf3t9l7Htfg6p2ygZwO8yVJqYYMvd2si/Hpqi?=
 =?us-ascii?Q?/W0YT34tWIE0aEk73+3jBs0uwj7OYe11msXH8JJXBOYQu9OlwDdU2I8Gp1hS?=
 =?us-ascii?Q?8JI15SPP+uibV1kNx8lONur/6X9Kk+fOAd6wtkxor/lPRak+qC68/w9O5tkd?=
 =?us-ascii?Q?iJEWrMUbXrwqWpAxoIJF+Z3nbV1yxG84BH1V+GR/GNqxxNIlsrZeWAOY4yzw?=
 =?us-ascii?Q?yDbFzBzJyrQ90Lx92AFUyvkEWwbxMoxgaPEjsXZIoJnXFSjrULYo+VvPPZsk?=
 =?us-ascii?Q?MTKcVt3M28KRLLZBloMf/ZcgVcSINxwWTfYYFLq44pudaG0Y3B4/AiitabBi?=
 =?us-ascii?Q?gyxG29WBfO7d2uYe80VKLK+cjgQWc9NAKu5cRKgMyd4BKKSKNfx7wIIJ2kIb?=
 =?us-ascii?Q?gcE++xGHh6Zu+3m6C93s73AHqYIUD1khzQdU+sjTw3EHIXnYHZEu8hBJmXYb?=
 =?us-ascii?Q?nSOG2M3cRDWFaXPhuFP9eYXTvYeB7aYrNW5F3XBJKWIkqe2eGfvOQLInE6Y3?=
 =?us-ascii?Q?8ZXJjYcUB7lAJjpu0+2veOC3K78V9NO/oPqTzjjNch/W6Dtu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb77938-ca07-4a0f-0309-08dea7dbe68e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 23:46:44.3134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yAW3b12MGineqXgNod5Q1XfQUYPCDZ05OZlESTx1zOKn2nNm4Ya4TDfSFlTkK4o9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7511

On Fri, May 01, 2026 at 04:27:41PM -0700, Dan Williams (nvidia) wrote:

> You appear to be confusing Cache_Capable and Cache_Enabled.
> 
> "8.2.1.3.1 DVSEC Flex Bus Port Capability" != "8.2.1.3.3 DVSEC Flex Bus Port Status"
> 
> Cache_Capable is only a capability. To check that the device has
> actually trained the CXL.cache alternate protocol you need to look at
> the status register.

The capable is probably a reasonable choice here unless you are
confident the status will never change after the device is first
discovered? ATS is being set early in the boot sequence.

It is pretty safe to be over eager with the ATS enablement, less safe
to get it off when it needs to be on.

Jason
