Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D941944685D;
	Fri, 28 Aug 2026 11:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787918025; cv=fail; b=Tzuf8MLTzzRMOYgPHctY1le9Nw0ApaE4YkPoUXjc0B1hUhISbvzw2dxX7I7AVcNE+I/j99TPFsHvZfr5ixdCvXpX/nnpg0OvIJoURx3DfU0mT/kiHzOIPL6AfrP0vCH6pjkkOMwPUdxIwNfbEg5zlJuWNwTA3+56Tr/qJMsbOO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787918025; c=relaxed/simple;
	bh=b5i91ObM3s17zyDJeQrte/ot0a2e8dg6fkuOupzvHxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ERBneRk3mVemQkQeKcLg50HZi9D8kr6aY5b4EYJKu9tEO5pPH17+cDZUc77XZGsovJA1Rq4WeRCgGhPpHJ9u3UmxFJqtBKpgw20mdt586Jy3V3fg9772n7y7oLzwLIh388/fX/ULoevJscQ6qotyKcKuWX5jb2CCjc1HDTKfsf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F4A6dqMF; arc=fail smtp.client-ip=52.101.43.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F4A6dqMF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1DurnBdXsv4lKMNt62jRL4ddjxk/fyW6ZPk9MctJ8GKc+r6g2FIvbPCOh5EpZlDQs+MRLSYblEPW+d2OH7DYai9Xu/97vrrqFqVNtG/o64opau+t8y/GeMVjqO2NWZ9kKMjosYjPomCQ1eJ5TejQyF4+POn0XAuHABku3Xb414/cFURpx+0tXguQrUASHlQhJOsDETTMThn7jZF7y0Qk4WLUB3uRXmnxB9Aw8ljhxbxBUN180t2POA2No3F2j+9XCt/dCx1jPXbwJ27SM9w5iDsoDdenggOUSxDdHJyb5sYmXTqizX3MnJ/pfGiSEOgaXQ+N2K3uVcYREqzkxw9Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZaPisrZJjKFJJwx9ZY8dCeoPgw1xD3pS3/Y+oO2bJw=;
 b=XkmIB8J6F6cZzPvpf6yPsgmeMacGYfxoA3EECbeJA9vsIPdrSHdNU0aAuQARq7h3p1FdiH8+sRxChmyyjlhZaqLR1Hhg5xiQT9kwaWhVGWGoNFWTCQSJl91SipyOTEt3YqGF0J8UWiiyzW6zPcboDjHqzZfMNwc3BkHLxIKB+823pVA5fNdwc3HpUMtkBvSm+x2zgJdy0riM2AJ8xr209nMzCYbuzwRL/HVV4wT24+qQZ4D0VrIM9Kh7Y/1k3uCc/BaoiFa3LnS+nKwMabn+56SI2nyHlspVY/pvGwi+3HPqEgk7/PMgs1Ks3Y/cO63gc8OdbPcfLopQAbrFiGYyVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZaPisrZJjKFJJwx9ZY8dCeoPgw1xD3pS3/Y+oO2bJw=;
 b=F4A6dqMF8sTOsLmQPEkM6WpSDg/PBtckSZpxYPDF+7ctiaxbAH/OF8Bk0cifFGPBhIA+Sgubw8sEqLx/9XUCND3VFZuZ14lTNDLr2Im+u4zAFrPVGHyrXsBPgJH+2dse//QJcNAIvaMzpPyITsWl/87qUsV5+jrhtAQLtDcLSzNApM1ICqZ57vEAE15QLHn70H4C09GLdn7m+jKRN8LcGNEev+tSkeh8m9SD+R+cNirwd66N//v8ieIcvxIP1YHVC0ssidYQheqkrhKXMAnA9sDemmq1dZF38go+48RidMlMIKObKMeyWUoyfXbQZXeqfckiSXMwFHrhBg2DAdZaeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM6PR12MB4387.namprd12.prod.outlook.com (2603:10b6:5:2ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 11:53:33 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 11:53:33 +0000
Date: Fri, 28 Aug 2026 08:53:31 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Ankit Soni <ankit.soni@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>, sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] iommu/amd: Fix DTE clearing and rename
 iommu_ignore_device()
Message-ID: <20260828115331.GC3922654@nvidia.com>
References: <20260824122347.1588592-3-praan@google.com>
 <178759520117.3131778.15279605903087565179.b4-review@b4>
 <ao1vJxkZsJpr1qXG@google.com>
 <20260825114916.GT244917@nvidia.com>
 <ao3RF0w_AXo5EXxv@google.com>
 <20260825175315.GD3325090@nvidia.com>
 <ao3oHn8HiXIx5Wrl@google.com>
 <50ffc453-f918-47f8-9556-9813308690a9@amd.com>
 <20260826122147.GA3666382@nvidia.com>
 <bfb7be5b-2da3-4bd3-8146-9bd079011a75@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfb7be5b-2da3-4bd3-8146-9bd079011a75@amd.com>
X-ClientProxiedBy: BN9PR03CA0251.namprd03.prod.outlook.com
 (2603:10b6:408:ff::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM6PR12MB4387:EE_
X-MS-Office365-Filtering-Correlation-Id: a8145b51-596e-43dd-5baf-08df04fafbff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+1W8DCpc18KBtzSa/DXeS04jmhuBDuODzezLDp235L9Tmk+hpUFCKiGh9UgRGe0ci5Kocnqu3F4Ur49Vy1VUAbz8ImN7VycYONyc9JHOC5JfWJEYWv5QYEIIpjQZjKdjon+GSrNE3daa2tD4IKzL0CQRmimzfqUUGXJqPrvM2MCMXM2a6SunVOX900OHexTXMjBYVqVMjcI+veSiJzxHj3+Jqno4uI6v0l7PSy/pSiiO5sjXY5mRbksxq06weWGVKCtfXuSm3uOwOq1e+rtJreSXBzM2HqZeXJ2/kgRZszsoiurKoJhWw6mKWUprxx6ltbVqHBFqgPgnTs1YRJHCTHtd5/3/TaY0U7hA6rPwWOfqgJ6VBBcJHms0aDh/KdshMhPVqa1qgYYP3eyrYJuHjkIv9vbW6l6tPKVazWyqBywU1m33DyZ8WTazg+LLWnx4wX9TmuFiMPa2hGHXw0lmUY6YndkHRCyu1PkTlRgiWVWpATq9/O1uEmxn3U9ohAA+ypDtQuelWVkKQFyWiw0TddrAl2lToqNGacZpP9rcwiWPUqRLDDFzZg8RErcp/HSD9qzbVdGV+uRS6LFbt1Us6hPPCbcrmmeQgYM8Bwyb1DlFRKS68JWxjLXu7LAjVakYp8Jl0NfnSsdNqobpjjm7Xjbn+QyHtfecvrp6IdhFJXU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XSAHJq0qq0aX/vFh1rewVAnbWT9EtMEz4YU1YAF+f/RH7OHMOuKvVq9Pgmd5?=
 =?us-ascii?Q?6xyWTZYfUkVkDL+42t2ltdEJlhsrDaQ8dSt0tKsliYaE2tNaXKHY+IF3Aox+?=
 =?us-ascii?Q?vCV3C+QthFV9RtF7SaUL8+kR9W/lap/yZWz1RoxsHrgycI2HWw+b1pEjUFU7?=
 =?us-ascii?Q?yODjljhXaDkblwIyf3CRzgypa/e/m4jBSCcPXwIJVZvkoLk0EF8bk/77kj6c?=
 =?us-ascii?Q?Q/7Q0RJKDg/FOYEeGdJgAlZH4y6MIyau/NaIx50eHZ2+RKhdv6TijiKQ1eWh?=
 =?us-ascii?Q?UtdbX4DB7Nob2RNw3scosx3lH0NHFBbn7JWpTEqJtZgZ/CDaBfyXWs3HrM3P?=
 =?us-ascii?Q?Kwhwz7zQi6j1BsWco11lpBh8naUSiDr8n6aeTgMKtgGEz3ka7pyUApgZo0fz?=
 =?us-ascii?Q?1txYhJFC8B2wqVuGCycYwgUTw3GM37DG9f+jrLFgKQGFKNtO7VUtgY1uxOjG?=
 =?us-ascii?Q?E39IBYowAGyjxxVGuz3te7Ob1INHNS2TF+AosGZd7jgu3TwvjNTv5M0xnJrK?=
 =?us-ascii?Q?yhAmEOKCatGUTXVs8TqMoZkUW2J2zOFQaKEbStyNFDgTJTHrZmTBOxiQdmmF?=
 =?us-ascii?Q?N5BQtTYf2YKxmN+5RPeY4e0mjtgt0i7TcSnR4Zd+bOlRObCAo+EXeYbTMpnm?=
 =?us-ascii?Q?QKc0a6EwTmkWkkumQiUeisZAtsv5LXdXfuTtdlrANMRX/iVFiWFA1AbZkAIG?=
 =?us-ascii?Q?LKPNZi71Hoz2a1qQf7ze+QOGen4lQeB1SGxeL/wjuScx8GMUPlv9033OGHPq?=
 =?us-ascii?Q?2sRO2Z3ryvRFxyvwj9kN0PqG/UDFTZQRbpLeCctBPm26hCp7uu4E3EYtatL1?=
 =?us-ascii?Q?Mf5FxzdAO1YsIAIYCnhnrMWYdsWCKQaq9WXp+kyVxSqfVOWt2PcxhE+WYqwB?=
 =?us-ascii?Q?eRNIr3FweKYRGQvb/6qe/Rl7mH+HU7js8+WZk69QvUcA/L6hjZCHJew8JkVU?=
 =?us-ascii?Q?SM/ayhBXLRhT+6ubQdh3Mcn5H83ire2DlwBhFXHaNErOeweWpT4XxNZrhIPq?=
 =?us-ascii?Q?Rzh4o1Hydtw2MxpejJFJ0HZ8D+YSDIBwPD+KE1gClf68PCXiJBZxOFnpnLoJ?=
 =?us-ascii?Q?uE862fq9/O+8pM0OslrI5GKLCV/4/GGmA7sAO8PQ+atM1p+p5601+uIyWS+h?=
 =?us-ascii?Q?YFdkMJOz84jZjFxTw01IA2paND+YMjSrp+O0mY/aQmHtOXwaDo0O3bdhB12m?=
 =?us-ascii?Q?mk9miZ7sQYvdSFq8OoI6ffLOGiL2s0W17lZTsSaArXKkpi9Xm2/wGLxvjk5A?=
 =?us-ascii?Q?GIckmSSNXTCnGGKqnK+xngSeDBtDbRrmip+KnNHVLcoz9I+1o+LUUf7jVOWK?=
 =?us-ascii?Q?x1hUa1lW5CrtJ/7fs8LNm7smd/vhNaOjPOUBkXs2nAcqQe5wCWUGfDWkV99L?=
 =?us-ascii?Q?VfEsGC3XwpaNiAwxom1gtGh0scsF03KIu025aUyhtHaNByPfdyPggxYJ7QM7?=
 =?us-ascii?Q?RTUtiY2B/eqQb8jzp+mryilYXRyfQExgWIm/l73HpSFOBp9jgHXD0zqsk/EI?=
 =?us-ascii?Q?rQoZR2uLQ7nN6qPV/ybcvBBtCYZTT5b6D309pKZ079wKJwJX+bh12c1Z+VHs?=
 =?us-ascii?Q?+Gs3KlbvaK36QajByBtvUCYUTH0EvYs4WLN8UmDLmu2Hz1d5gtgYWHrsIEAm?=
 =?us-ascii?Q?DAGpgdwPoP79szntSP778rlWBjLwGl+LbTtrg3865aLrA76un0B9R2p4bBUS?=
 =?us-ascii?Q?Hsr7NBoZZmD6FBRqOrHsI0McTNoJp7CZMRNVigI6rnU1vMl8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8145b51-596e-43dd-5baf-08df04fafbff
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 11:53:32.9817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cikLGdJIEC/BGIWAhurNlWb/U6nxzBIZ+dWcCwYeQxBzvVcAlnvUajnKVPu7eXFr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4387

On Fri, Aug 28, 2026 at 10:46:48AM +0530, Vasant Hegde wrote:
> > Having the driver boot up with all DTEs programmed to identity (eg
> > 0'd) and then try to fix them to blocking after the iommu probes
> > devices is security backwards.
> 
> During boot, it only sets dte.v bit.

First it clears it to fully 0, what does 0 do in HW?

It doesn't make sense that you'd pass over the DTEs after
probing if the original 0'd DTE was actually blocking?

Jason
