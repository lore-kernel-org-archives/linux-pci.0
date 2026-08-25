Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010014.outbound.protection.outlook.com [52.101.61.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846C238B7D8;
	Tue, 25 Aug 2026 11:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787658611; cv=fail; b=QwzzSPaG2U3j3wudRJ8mMm8sZYOzD9weFqvtpK5hqGfLF2wReemoKIxlci4RbZ6TGqpZhFnCIZp2OwOxwU7Trz/I3QqPZE4kGJDkrVjIjCBnzhUTHvPGXLvX1P9c18AJE0I5ElPd1hpCTrrHn8swIgXTiDI7cpa6N1m2JJOteVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787658611; c=relaxed/simple;
	bh=8OgZjLfYfFBkWEkXvgxDqyog49r3bW3bEw/n+WzFxDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DlwRkgHxGohJX9a5UVsmBiclkMTZB3WIcjnxQy39m3n4jJ23alQ7VjiTFvKkRSU124csK2Qvr8ltmeoMmPv2KFKsFKbxQZqo6ZlI5ZvMz7Va394zptMxSUbup598k9x0Z7Ul+khFeK/dhgf6EWyistXLUSQSj+28dSmJPltMLoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gtelDWTb; arc=fail smtp.client-ip=52.101.61.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gtelDWTb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pr8lq+axRn2fcSDfe21wKiHtvggaCwnGezhM313PRnq1WEtz/4MUHrgVT5m/2aYEDs+bPnzdsFYXdTTKJhiNzIF3WohxQFFxR8prhn9h1CaUJwEGfj7ga2txXPXdJjDlgffAmD5E6XAQQvnL2Sz6m9Q3DNC5sOx5LQFCckoFzZVzbFaC8ulWkWW6EFbzPSoBGb/EowzdpWNtlc2oRX6qZbIh1fEOo2+nWqHn6dplYQ41snIKHU8kJc1w/54g0z0sJFiQi2Uil2cfaRQuEwJoz1LmUKHtwVxaD1bZ3sTf5xecSxht7p4Mm1TFzIVf3Z7GhhUQLE6YEx7TgVWBbMYxXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEXCBVzVltSPcmFl3EB1ql2g+HP7sicNvMdUfMWTWWM=;
 b=W1ByfJD6n9NDS+EVWzX6OJtL+vpXU+bgV2U9Vv+tam+cQqQGuOQBvNGQqqP3TQPCEN0rGW86x5h97FVNiEc4XA3N0vz9PCDDBjXE/x1nNzWmRGuzQPY/e4Xn53Dv7X8nPJ8Liw0arzO4lnpHjSoApEfqyCslrv6Q8om6BAS2p5xNtaNITPB8+Q9q6nnlcEtwxeKaDWBHTXi8V2eMSlh5ISo3Po39a990uv54hRCYlNx/V+xnNZPMZ/SA3jGVffHeNZGQZL4vIJHMpquhLAbtP+bDezbExBwdsFTK4lHdBf4gSQeyg0aYSkOR9ttzhl0Rl0Qy8nOq6acKVGz6UivdsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEXCBVzVltSPcmFl3EB1ql2g+HP7sicNvMdUfMWTWWM=;
 b=gtelDWTbanziGT3Xj7PJb3Zn1BCHJLGuTmEDspgfHo5fvvkpC7Z4fknOG0/Zz3Mre7TzPKWdE+ex9ZQHn2KhXUXhQzfelXVT40BeRv7yUSOT0cAoWrS8ftPg8D3yFjuUfQWlPHWm02sxx4TbeUfjx/tKtTMm6B0dE8rqhATe32+uzcsSpZ8DBIC0PaF9LIFlLe7kDow+2B4QL7cexd2nRHRcGYYyb/TvW3Vd+r9di//obBjVFsRaY8dk2J1wcMxt0j53k2tYl6Ml4gO3zfyzxAZHEAlD/gxtMx8nd4O6maqHQersaBV1MA+js/2H71WkMlSo75muvF/HiQLxI3totw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB7687.namprd12.prod.outlook.com (2603:10b6:208:421::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 11:50:05 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 11:50:05 +0000
Date: Tue, 25 Aug 2026 08:50:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Ankit Soni <ankit.soni@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v3 1/5] iommu/amd: Refactor device probe and capability
 initialization
Message-ID: <20260825115004.GU244917@nvidia.com>
References: <20260824122347.1588592-1-praan@google.com>
 <20260824122347.1588592-2-praan@google.com>
 <178759520116.3131778.9383172724893797706.b4-review@b4>
 <ao1tUKdiMZSoM82a@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao1tUKdiMZSoM82a@google.com>
X-ClientProxiedBy: MN2PR08CA0008.namprd08.prod.outlook.com
 (2603:10b6:208:239::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: c9fcae98-98c1-461a-78c5-08df029f016b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|11063799006|10067099003|4143699003|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3clzdUsTGA4mXo+GtNSg+u3y7c8aVi/oE8LdyzJczg0bcRdkJJKBnE0KDegkTZ6i8fCYE/dHyfY4cuhutiRSKt31WNQrsjfvjFGvem/Rk0lCRgUke3k1uicDJO1bNkVCqGYffI5NF00yI6IV8AHQ5uYZ6PXAqZ3Z76eIQxbhNi/qy33le8zoL3kHMaSwTZiLNH1BXIx5K5AP1JGgheXYBLf8mE4jgr3VBwc11egChX2QSF/43kimSsJmWmkTDRt/HGdPjzwBEdA3hN99GS6XO8SzUePQ074GPQTKLwGMjrvTh63xOA6Ud3/Ag+GHGwv0PGev339uYMJIsUkzeYjfbbxFpDF+Hijliq7PfIOijmvgKKu+17bT6a4KtYRnigTaFXcxeYiRJgYxs/2sUsfdHc+8d6AboeDd9LsvPh6DFG3/sVdDHoR7tYD0dc+Guxx/sXhxPLbrYKNI8Bc6Lo1fahqE+SJIv2EaxDRKV2Ha8+y7+VqVnGhkqXgPAElzhnUobdSmgyXFmewXwbT7r5ZWrh2l5qByu4yZEJr3ZbjwVs6HY9qDpHVRRWFhTOdnJ6R0EfQEBDRdkTLLbZxr0g3YKGyWOfj/k0q2+HZHE1dXOXwpF8k8JdwvzeUl3bEc5wW/mqsZAM7vskL0X8/uZQZwZhqkMHl7iuwZQA8mTHCGasM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(11063799006)(10067099003)(4143699003)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NoueWGVLsnUboJ6jtCW1i2sIWXgwiT78GBouIlHXNVWXEf+/CVionNX/0zpR?=
 =?us-ascii?Q?UzwBFeph2rBDytYwFGt0LWIQema9wQrwhePf9JCvNpEN/Sqis1S30Diy0My4?=
 =?us-ascii?Q?jCBHygWLi9UYrxcVOJSHYFOYtatfJgP9Zo+4TJwXTjyP2UhocSx/PNgY2PK1?=
 =?us-ascii?Q?sw6vyJU6fFoQhPDWXCYef/UZ5s/DVDpXBtX2KZQUlo+Va96bqpJfhFoflqy1?=
 =?us-ascii?Q?jtUELW4VrEy+DmyRT5lqb4x9GTntcRjfhD9xN365/dz3TJH38bzM8cpbFU3M?=
 =?us-ascii?Q?0KhE2IuiDLYBLH0e5/BMWLGl1m0wuGVUWze82GMsDs6lZ9Ek+x7cOSoh2Z/D?=
 =?us-ascii?Q?fCKAYypTi3ib5i6TG5yDrRRG3tAhSuICSnVfe/hYRnIiU50/7xX7TkrCnyb0?=
 =?us-ascii?Q?03usLN3uaTyIYAaLDrdl+Jdyh49XhtHIoAYZ70gz+dLqvyqZ2QNXgv+uiol4?=
 =?us-ascii?Q?je0Na9rfrrZIsOjQ5ZG+BAgF0Vmt4lKFxSQtAlzrOYhECo9Y+5/oZ55VVYK8?=
 =?us-ascii?Q?xPYxzULWq1WJKcOzq4chUnC79TrzyZImrVLzJolNEmuoJVh8uarEBIDn/u8p?=
 =?us-ascii?Q?69q8N0mI20v2emTBOV4VsMNzpzfJ+zDEf136g+kKXv6SHZlXuZyFnVajGJlD?=
 =?us-ascii?Q?WDDrQRhinJIX38LKW8uXDK6UznQu3MDWlwwhBriyuNP5A+ZUXifm+9NBkabT?=
 =?us-ascii?Q?YMGtQcWOUdMb9WHJXHKCciOz1fUQpDyP6Aretf74pFMa1rrGtZdgKwLX7aKm?=
 =?us-ascii?Q?ZtSMGv5lKsI/mLSSHQBFjq2lcskDth/6CmxrAAKuGBr4naUfuMnGJ6RD7U6S?=
 =?us-ascii?Q?mLLt79eJA7fi3yXPPgQlKDvHsrBI8hRssR7E3Aucael9zHUDaIEZ32eaUGu8?=
 =?us-ascii?Q?3/DDluajRWHoUW92Hh8bMLZbxfHa+zlGF6W4Y4dmPtHkiQrUUIeI3zRxWlfL?=
 =?us-ascii?Q?W9898MQEMNLLuL9y9uwPBunpgCptIUzJUk8TXnyHya1ABz0+DuzpFGN+PtMZ?=
 =?us-ascii?Q?8xon9kw5cazyq6BZTW38WjcYy4DEb30TTHe7JHeW4lgxAJrMHLm/dPeCQuIz?=
 =?us-ascii?Q?ISdki2051rtVmJfhZTNdcvSNHV7x+o2348b/meMlq6u5QwL2FyIptYF/m3iC?=
 =?us-ascii?Q?ovcHqVPBaxP9WhrDvTZubDDdyh7YJiH3fVAMXgSnlv3NaV/9VnCsVMR39dyC?=
 =?us-ascii?Q?yTZAF3YuXIm8Stlkxdr9/AalunZkvvbdANCFJgo1GgUrfHDTWJozCqII8fGo?=
 =?us-ascii?Q?aUmngbG14G307ecyCirFrIoqM49LXzFT7DyiEvL0AnuszV7p149mAC3HgwAw?=
 =?us-ascii?Q?D1yDHzeC1ScL2CbOMt1TxFQTKcKlJQp4mgiZse2cC2p8okmTYO3lNsuI3Dut?=
 =?us-ascii?Q?2yz01R/yEqUT9gucuJOxQp1m2MD3vCNyIVmYQBeL1Cjzzj8ddXFFLVfH+q5u?=
 =?us-ascii?Q?q+3dzVjM1/sDwqF/Ve0fHRWsQw5FFmiuQADkomFDGpZ4fkl7lq5oiUcJTbYO?=
 =?us-ascii?Q?wekTpXvKEDjbC8vp4Qg3lyZn9YtyaZwi2fJIUOzypaff/vS7fFab7CzyXtLv?=
 =?us-ascii?Q?hUB0iu/eF/5VV2DW6en9qF23WhygHBM+6Q8WTiGIJpGHPo02NV9Ob3jdYbCr?=
 =?us-ascii?Q?DtLQDRWnltp6/ZmxLzdtJE1d9/J2O2w4j7XCPtgeYrC96c6L0svJR4FOhKdd?=
 =?us-ascii?Q?QhYCyrcY3H6JygYj1yw6KwKb8yF1fS3A77i7Vuof9eB5xoEx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9fcae98-98c1-461a-78c5-08df029f016b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 11:50:05.7991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zyl9+KubdPSXC3zCf3qx5z7bv78skW1wZoqn5IoCcSA9bZmdWWlgwTvZ7vrkrsIR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7687

On Tue, Aug 25, 2026 at 10:24:16AM +0000, Pranjal Shrivastava wrote:
> On Mon, Aug 24, 2026 at 03:13:21PM -0300, Jason Gunthorpe wrote:
> > > [ ... 14 lines skipped ... ]
> > > @@ -675,7 +675,8 @@ static void pdev_disable_caps(struct pci_dev *pdev)
> > >   * This function checks if the driver got a valid device from the caller to
> > >   * avoid dereferencing invalid pointers.
> > >   */
> > > -static bool check_device(struct device *dev)
> > > +static bool iommu_lookup_device(struct device *dev,
> > > +				struct amd_iommu **iommu_out, u16 *devid_out)
> > >  {
> > 
> > If we are touching the names driver functions should not be called
> > iommu_*, it is confusing..
> > 
> 
> Ack. So just lookup_device works?

Yeah that seems a little common in this driver, amd_xxx would be OK
too

Jason
