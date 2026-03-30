Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011025.outbound.protection.outlook.com [52.101.62.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DA53D3D05;
	Mon, 30 Mar 2026 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876300; cv=fail; b=J7S4p+8AQWPxrhFIvcbmXqsK7dDyZLVZ1p9EJi16MVNkvrTrUEUniYkV0TFl5/iTwmt9f5M7+oU/y/Ry1K3Q1MHzO9wOq2OnfZybY+I0so/KUoUo1aUgxv3JK4JVAyu3swB3iZuGn5eoZvLsW9uCRWvCp5zDC4LeKm5d2heMogg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876300; c=relaxed/simple;
	bh=OumQ4JHqqIIjSSwRQuklKbUkjGiZYBG0X/ddc384aGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uxYDN2C2PIC5fazyqZ/r/HuLbZnM2HjEViE8ZtZq9EnfYIRNjMRHJzcqhDyIiLHURhrLM06/mkG1vjPKjrWtLKguPE2HXl7rmQ6VK9alfxMHmdUN5VpXQVsKFntFl/mFkVhJpA3GCxkTDuVoWnq6BnT2+MqNtGDimUrhWR9079M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cnPpZ0kP; arc=fail smtp.client-ip=52.101.62.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cnPpZ0kP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJ0gfs+U/+YomrZxOMZ1zRIOceL/8ujxn+7Xr9r+WR4FEb78ntzKblXHGK0MtFCSdks1nJJiF2id4W6eSxesXZplXiGfa3a5kuHLeifWpMpi/ti3onFoKlxLH7HqK1Eqjz9HjfK+8LFMzKWBmwLNTfWdgQ7OyqcfAgV8sksxCBfFvUtMDtLDR4+xKgSnat99Mw6IrGtyN0RyT0/5CtWkWIyXWKrtNe7p2Ueoq9aHvCnayoNW52hrxUC7sjtO+1MO6OT5jOqDY2F/5iuvCZITLbIoA3iNSSfKCw5MQE6PEKCNA10pKviSzLpKUR8q9janXaAYh/vjMmTmxe8XNwaaHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krs1Rq2WOz55avZr0ZDq333Yqh9Jvbv4qRbBCNTePKc=;
 b=dS/GJhfPkPCbwzVFtxdIDEuhsPLE4SMAhv1c3ptZ+nkJ5RyfA5f21caBvh22rNcnoycOzK6q/N3KikBn+mGTjUkliRm9Hrcl2MG8DH4k3I2M/MAzUufUR800iOZdsOcS/01+KkEyjEevAN7ArnpSiTzeWVEz7N68A5KO/E6pMtJh10RUVmf6FpR/wd3Sjw/YiZKxCDxPLng6IFqLha9AsxesThfQNbGnALIoaw03LN/lCydyFWz/TC5yBTkdL+qP4oOU98+a3i4CLQjBb/xy0U6lKSTkb3bNnI1nRA0lgeLNsYxEk1Ryo+zEgWTLzskT0KG+b0uFKSR61myr7aQ9pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krs1Rq2WOz55avZr0ZDq333Yqh9Jvbv4qRbBCNTePKc=;
 b=cnPpZ0kPEHS5z++kEC54vu2Mv0oXO733kYcL5QV0zVfuatRro01qNK/Xr5zNhZwKuNJ9/fOv3cI8ql0/YVruPio5WJDXtgQCTAn9WB3USNLGAgWV3FRWJDBaOuAviFlfmZW7pK3Dh9bnhHaHcNJH9yAVK7oJz88n6HuMpQ6RFAFr4w6jOid4sHMu1CWGi3eGCbwHvuCnZXqvmWu/7/KYP2Hp5dsmTIwuEcawo+y59Vw7Hl+FRj2Cr0dhEIrkWj1ZErBkZFZee5lTH1rOG71dWHoXengJvU9H+r6khXjoj/VVxQ6Z+py/G4I3mITDr+ycqPU34+5u7KobGotqaUnHZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB8525.namprd12.prod.outlook.com (2603:10b6:8:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 13:11:29 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 13:11:28 +0000
Date: Mon, 30 Mar 2026 10:11:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Wei Wang <wei.w.wang@hotmail.com>
Cc: bhelgaas@google.com, jonathan.cameron@huawei.com,
	dan.carpenter@linaro.org, akpm@linux-foundation.org, bp@alien8.de,
	rdunlap@infradead.org, alex@shazbot.org, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 3/6] PCI: Consolidate delimiter handling into
 pci_dev_str_match()
Message-ID: <20260330131127.GQ310919@nvidia.com>
References: <SEZPR01MB439931D7320F6C476D181C1EDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
 <SEZPR01MB4399FA7D597B0A619C6F9A7EDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEZPR01MB4399FA7D597B0A619C6F9A7EDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
X-ClientProxiedBy: BL1PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea1edef-8983-4789-4dd3-08de8e5ddaad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	O3VZxK+PIqPjWc2FD7RZ8U+6Ts94//ct9D7kIpksM3OX6r48btCkhbx28ns/ktuf0JbtT4w/QlPnh+uk8SZMXpCnMAnwv84+g7JU8yJt+3Jcxcg6P7uleaEgf66viSJ87Jt/u2OlHsjlURZU7Oyw76aLGWZZ1+zk/hGD9/NBb66/ixsROvwgjOsTBuQEAI7/3OXqPp+WCE3wHT+1SObexsVX0cbD92GmwDGEBYvpZthFM4aOx5Hn1T1N7tQzOji822etTHKt+NiC+n0XWAZ8CCaxRLNxz0Wkt5Fd+YhpuaRxL+R6alc9ukHVP1Vsivib3BQov4mL63truQK4rz+0pZwLiRzCQPmnEehJcuJISh5Um00SJUJnBsTCyl23j14wEXgpW0hmSAuwakHT2F0PwOY7RYp36aL/UskvdMKrQh8WsgULZyWK0SLO5ATeggyWH/IjUs+Uk/9T7Ql4Di3L5WJPukrZtGizs9uCWCmuba9HTA2gvS7SVOCxtz+Q3MSmMJCsHhCUYusurRAQgNatwqqFlQua1nkUzB9+SuWudMZKkzAQ/G9S+dxkYvoFT6ZA+E1+IufNLg40eSKUgbsay/TIZKD+Gq+6cBNyMtZmwkYoqqjTDk+/eNsr98gPLWmrsqZbE0OWtZZB9yd3150JulLfCBuSbYQPaGaQPOeE22xHpkcouSySB9C03s9siIwWADjDcDg3e9aemXRttjvDTtZhCZdcMuJMTSOZ8HWBIMo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oZMn6jaBLPWiK5S0+j0iZRFeZ7MCqH5i3EwTrRgZTViNT1LDaXkVWP0t3CeF?=
 =?us-ascii?Q?F3V5LRcytGTkymTfS+5XOfzCJVWrEEphL+2m8/fch2SO0dKaOaN0PYppU8Hu?=
 =?us-ascii?Q?zboVJJrDJ3cS+RELFU2MgARrFJVclPqFbURpJ98j46+gQMZjtRWsr9JvhSG7?=
 =?us-ascii?Q?rGLREtOd0ZzotjbUJHy70x0ZyiYt0t64M+pcdROs5Rav+Ixj9M0QmqYCR5cy?=
 =?us-ascii?Q?Dq2zBnjaEegpIiQbP0n4uWyQCP5MlnybFPNbtxzmLp5SIJl/SskYqkYDPA6k?=
 =?us-ascii?Q?y1y14u4LE9lateJDW7foFNDzLg91944e/SqfJBOoTW3B1qG+TCoi0OfSVX+Y?=
 =?us-ascii?Q?IncUMiBWWbiDwfX0DjdrJ+V7a0ONYy/RcczRPro+gJy0Vii/0fKJR9upmhTK?=
 =?us-ascii?Q?zoscvRdeFWqvuJv22NdOn+l1dKGBmj4j1id70Vxqy0kkXmYyYwfmUtkCL7bU?=
 =?us-ascii?Q?xPUjYsHOJEAXB1RyBEbuKYsJWwi/MYaHI/f3WXQhrqRGHv/6b+wVrv9plpmU?=
 =?us-ascii?Q?apU6ajsFniQtX238MwytB9VKN416gzb26u+PSfRi1B+Xg/gIQyhewHZDgZSm?=
 =?us-ascii?Q?qoEXfO4GNx6SBr6GTFDluUwYWrvIWJYt4qKdlwX+XKodZBCSYcvkxqcQURvm?=
 =?us-ascii?Q?kLW/mepWqtOUvzPllfSU9ykP7vQPbA1c+wAV5LpD/m9f4AOlJKMj1JBzpRuE?=
 =?us-ascii?Q?MjHEXYtzJo7v4WRytcLOe3X5DSG29Kjn6yqyLTZZE8FDnzjZmvhfaz0qcVmb?=
 =?us-ascii?Q?4ar4rSXgfvEPpdM2wuXGy4tDX7mHNzRyf+PYd/HDKePhcLD5qfShB3mJ7zqd?=
 =?us-ascii?Q?+uVOHNrFMF4bWZb+BLKcWKjiAUwthoA+iFWMq/yB7mQQuJi64UXss4pVDB2h?=
 =?us-ascii?Q?ST5snuZpIJuMUwC9EvynneDpNoLUauaxVDfwztMofTBMgdXsC/zxlgzvpOLw?=
 =?us-ascii?Q?rH/nsRkOgxVmHb9ThfsXJva/MPfmhMJe8TL26c4IEKQ/o5re0RSMctOpmgjj?=
 =?us-ascii?Q?O5louKKZPDPYhvjLEzB6CQUQ58dLVywpw6RYNsuUSKNpYp0Izm837r7Ys3g+?=
 =?us-ascii?Q?I+hdkGOe9ezz+iiimU1hzw7uewXOTMmSOMr5nUt0dHu1uOmWOtDI92kdo07M?=
 =?us-ascii?Q?IyMbtSdxwMPuP1NcJdSWr857XG65CAOE+SUFCa730X1R0aJoxRm/v82mbLFW?=
 =?us-ascii?Q?1yd0WzxuLXeZiIAavFdtbBrLCCDlDxj76odbKUCkwi7OR/Zulh4vBxWsLt8T?=
 =?us-ascii?Q?iuCKDs8vEzrfxhkL6e5aBtH69wLiN0/zR5zJgz2RYxhaLTzLGMUiNNXL6WX2?=
 =?us-ascii?Q?QSw7wFdQJK02HBSY4p2aj8tdODPDoPi/D/etv+6Pv0Dz/7qFE3jEq//m7O3B?=
 =?us-ascii?Q?dOI8M1avBcuY4j5t65EQWKJwJsPXQEntUslQNIgSuXhfwPQyf1x/gwCS9sLq?=
 =?us-ascii?Q?u5RRW3ZT/GeAqVKgutI81WW5zR3OPDYsE1NAGEL/l4reO+nB6verMLoZwNWO?=
 =?us-ascii?Q?FFz8ycz0xv4ooX1FXSj172ymP62yZPBwZ2p2GC6o9OLtwbTann9wvDww1KrI?=
 =?us-ascii?Q?ux8qyMkkSQTjoxcgzvfsi0ho1pKsHmaeM8LFAwqWIOFO1V2U2LX/4Dkr4lKL?=
 =?us-ascii?Q?m3r5l2s+bkRjgTAuFF7Zvfh8lsUDbtEiD2IRpFNzn5RAUu2Es9VlcXYz321D?=
 =?us-ascii?Q?iMhOKuLCTqB+v1AFjeBUr506jA+UPMumePNS81eDv4G/xgoI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea1edef-8983-4789-4dd3-08de8e5ddaad
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 13:11:28.8186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qPcqV99tWBsqUDpuJ6dGpV3fQOQkw57XeBpsjA2Wxu/fugeMQHFZ3rMmoHr9q/1X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8525

On Thu, Mar 12, 2026 at 05:06:34PM +0800, Wei Wang wrote:
> Callers of pci_dev_str_match() manually checked for the ';' or ','
> delimiter and advanced the parameter pointer past it. Move this common
> logic into pci_dev_str_match() so callers no longer need to duplicate it.
> 
> When no delimiter is found (end of parameter list or malformed entry),
> pci_dev_str_match() now returns -ENODEV to indicate that no further entries
> can be parsed, preserving the previous caller behavior of stopping parsing.
> 
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
> ---
>  drivers/pci/pci.c | 46 ++++++++++++++++++++++++----------------------
>  1 file changed, 24 insertions(+), 22 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
