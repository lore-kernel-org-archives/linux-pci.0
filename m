Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013036.outbound.protection.outlook.com [40.107.201.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D813CE49A
	for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 18:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774289922; cv=fail; b=QfN1O5AGlKRDsu4hxCoeu0qVY1U5Imp/tTgt1c4giyzqq6eZZuj4s+oxBHV71DAGO/Tndyjl1vtap2huihGRnKwfpBR/fEFrTU5foZfTbsEn8k0/hlqERJJCBBdGrzQljegyyAD/N/tNe5X8nUuQKNmNMWJiCt1BkyfGh04Z75Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774289922; c=relaxed/simple;
	bh=NBJWWXl3dJDdtQGhrXRs/WoOdjIsGUaE0gmamLJwJWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ajW0Fvns78xpUYg2SzdbMxN7lPHSks1hOvgWoC1BGlkDjGiigQQ7MHv4hBnBgEwGUz3uOMBjy+zdZArfRueC10/aweIBWkIuFnUFYUPGiDCwgr+QG6SQEti4GVGxcvHgw1aRa5ykvO03k1BW9ToyIEFNtEP5YNANTe15Wt/gwL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oRhFJClr; arc=fail smtp.client-ip=40.107.201.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oRhFJClr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQx2EG+NEIoaJ3jzm3fkCb5TCexxVyYTKHeGbANz5TQ2Yka2y4SOtItcnIvCalqCyQ578rmyKm0meI0GbksPHiYf/nx+pG+DCdkDfbbR7Bts4Y7nxA6g8qLyzxe7NJ30W192RaA4delkM9RckO/ovSISbjnqbsQNYMbUgY2HLnldQEtnm8QoxVwyIVhcctDvFvF9aNvoCsLxvyq7dV8qeWFC6itPa8IBgon7YSZ/6JP6uwqG8jjoLbPfOIFRe6uatywQVphjy2ZrbnTuVSZxGOlgvNYUjI8oXfs7UxgZ5ASIfatFf25OTRLH7WUEp/DxfgahVtgd+c6Pi6sddC56Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Z0l/qyUdt68snLtdr4OmEqB4hjAb4y4WPer28VO9+M=;
 b=TFG2de/tvp4lBLCAvYsV4fVva1SinHn3zbOZo/RFYNIvWNt4Z+A6ffvxsP1eJoeAUb6PDlhFosqEBj0Ed2viZo/++b8SqiRotkqAl43VfV1TI/VhEJk3ve5GxgeLYrSbkyoF5Ysqp0kh0TlnHpawjN5NlsTOk/7p/ZWV+mREvL+JghjInV7mR2qzwfEL66CU/gam3NKqL/tO8flp3wxz0IpBM2MqJaNab0/tQM2EjeSSjssilCsVYO/fjz2/R1sZ18Oon+7thvVf/R1gySqzUeoU4sclIy9ofKtEu4qHXVPLsdNJ2v/BUzFVUPPs8X53KTIgBea2ScopAF3Nog3QdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Z0l/qyUdt68snLtdr4OmEqB4hjAb4y4WPer28VO9+M=;
 b=oRhFJClrKHV8sUj75VO4X88/JHvwxtpKI9GjAvrqFkSySQKBSAWtHsM8KBVmz8elFfA+nfYmXWuCscmLIRrw5FlxI5vvco0QpoKDZNdhxP/HKEsJdi/buMyyBluElWFu31cPjeaFjabjyZJawOBc2qtWlmkfCWobxopm62CSaoQtP0qlloGVHrlidF9mPbkyrjs1jy/zFtIWt/jbwe07fngEbFHTLrEvWwy9ciRSPRTNCW9sin4QhwAGGN4xMLRZZNr2RCSwT69DCTwYvlsvXf4MzR/MQAXlTYtWayNk5uo3iaRvtILBXBisv+/xs538gwVHLuk6ZsKZznJS4F3QTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 18:18:33 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 18:18:33 +0000
Date: Mon, 23 Mar 2026 15:18:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, Jakub Kicinski <kuba@kernel.org>,
	linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org, aik@amd.com, aneesh.kumar@kernel.org,
	yilun.xu@linux.intel.com, bhelgaas@google.com, alistair23@gmail.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: Re: [PATCH v2 08/19] PCI/TSM: Add "evidence" support
Message-ID: <20260323181832.GQ7340@nvidia.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-9-dan.j.williams@intel.com>
 <20260314111245.76d18d73@kernel.org>
 <abmaG0jC7b05Lytz@wunner.de>
 <69ba5abaf3ae7_7ee3100d@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69ba5abaf3ae7_7ee3100d@dwillia2-mobl4.notmuch>
X-ClientProxiedBy: IA4P221CA0012.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:559::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: e91895e3-5753-422f-bbc6-08de890897dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EzSPvpiGR1Z9j9Gqw0WQdZ2JxFtIUXl8iqKmrdhFyxYRbHRUBg08p3is2Njd9196m+YNPvZsVPgUmevtdrenaP/Rh97SO9JBBUl0fUgvSvKuDQ5mRv5NP4+fUZFUgO8AVl6p1Vx/BXoXRcUEO1MFYKeJgCyaIoA8SARwxCgDFwYT8MD8HgFsLGmQowdyyOAl9Q3dWjbZAIpbYyl4l70pvo0jgbRrIF2NdSaSHzYG/OU3N384mheT4Xh2D4F++vRaJG+WXXPgYTt4x886diPK/WFDPmr9W2iblnpdDS9pQkGEGLUt8ZeAXhhTdCGPt4pW523DVuefWvaUIifZX0Hwv6XwDsg41ao9gYlLeyvVLVfdlRVoO6hIfBkb565PrMgTZ0yq846hmwgfGcc4ih1fnmoOJ0RJb/fSRYWKVpSoHsEigbpMA5Vkb5cwpqg/K3v21PgRxFV4MVqIyasYbIoklTvIlWmGymyRFTYxKyVJQiHo9RG5H98621Z2C3nR7ImefxY8LEUEQUorU5KS969W6td2qbIZm7wU18UYhP/VD5yebUbDMV5ClNFO1ovkWfwf+nP7L4Xg1YVd1Ua/PUUO1Xrjp+pTMnfd9KlRSBhi4Rl24IRpwHCMOjeU1wS9ArNOJii/DxBeGYakFliPFgZhNDstUdat5C/pSvcgZc+vaBj4DcfhFG0n6K+/1CnqWvGlLASzOljfkPPI5U4zG5G0tIMfGCv72UQ667Zus4weGjA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+nV0kK7XI7t9KSTGy665nDrOFeQbEvAHQFeNOe5B0L0/MXhyt256gRwFwMfI?=
 =?us-ascii?Q?DVSFOePRz29cdP23gYrW/WeKJFTrMMbLum9gi+AVNcHA2xoe3QIxMsIfKpms?=
 =?us-ascii?Q?Kl+XtMMlgo/e/FNxoWgd+UMhti+1a8aL4t6mb1hlSnyv1MOm8RnwhoyVn5I3?=
 =?us-ascii?Q?DO1cXkoJ8s2ueX7oExSUNOMzxqsFTDKHWLw/RQ4e9F3iVO/3VZZgbphCUmEB?=
 =?us-ascii?Q?GSFj0+8tph6e9TN/T+5tq8TL0Jtqyr7068JsBT6rPmmcZqsKD8rxoV76pZYp?=
 =?us-ascii?Q?iZ29D9OsrVXxc43DzpioHRFUWPoWXZKyjdTszKdsiI+/t6803ecO2GS5RSGp?=
 =?us-ascii?Q?jSkQ3HWyx3Sp415Sk6n3vba+utq3ARUllYyx8QBlFr1k3TH7k2A6ppznCR1U?=
 =?us-ascii?Q?c57YrGLCSBAo3WdeEuBD1Udls//Pj7WuGSGYuLqWYPpL/m8cIZe5R6DREz+5?=
 =?us-ascii?Q?Mbt0n/aphF1YVaQWoU+UOG2SasmLjWwJ1CFB9MdqWzio9vffnVTxirYrdmCp?=
 =?us-ascii?Q?SihQ5SxVeTth491rSZeguxyfbnbieQhUe/isL0ZaOmqPwBMi1HK8wBeCO429?=
 =?us-ascii?Q?l+NFCasOTbwjYeRNfsGo61blIQPszeKdwuk9S4M1hEjWuu6gyfFPmEvCHGhH?=
 =?us-ascii?Q?mCiPGtrcap28bLPfUjTu1eEqkeTf5BpkpqHzlJCtV165ZYrWL+hGvIp9HARs?=
 =?us-ascii?Q?moR7O49iq4RPlYwbzCphOddjoEeP1XlU+gMTPwqVxJTffaNY1IILs9h9M+fu?=
 =?us-ascii?Q?QbzQwjYer0TY8xng0EhyDdNVPWFFTPw59ZCogASK2yrSoSKQKTXPQre0DzDJ?=
 =?us-ascii?Q?oTid9doAPtjh9budleTIujgSlpNjhR5/oazW2/dKeYDJ/3JOSEg1mIndGa/r?=
 =?us-ascii?Q?EnkLirjNtviR99X48stW/FTfy2sZDcvsJROc2NcV0ClSUEbD4BtR5McycqDK?=
 =?us-ascii?Q?2KciqTVIKeOTAigK1cHt21rae346h7w4h22J7yNiLXfFJ98E/pWGILxYu/JP?=
 =?us-ascii?Q?HTa5Y0T8UlcQrVMxGpBKcj8nrFAtDa7u6KOLsEu54UFJT54uPOnliWsJe3PP?=
 =?us-ascii?Q?VjpAzzlaMkUVY4dAgv1s2VuX4UHwIWTsR29DW4nXSQ4tj/5WAVU897CwMGry?=
 =?us-ascii?Q?XbuPkAE9eWem7lPjC1DvaX3YLe+SBcuz3nIw8zE/4gV2MgLTObh50BW5Mvx0?=
 =?us-ascii?Q?YLnapCOk4ATg+giKxLw4pp2FoDr1SBQnJSVeBcNDTxNNeGar6o/o476I0CN4?=
 =?us-ascii?Q?Rg1DqXI1LtHfWfITEbVTYQnbdTn5aGTafE5UmC93+JZ0OgDbt8BQKOYWPagk?=
 =?us-ascii?Q?HMPBU+tlW3r/PGQHlfo4ggkRwwqvC1fDRBVtfDDbi93KVPYpr0fMf8qY+c/m?=
 =?us-ascii?Q?S4u3dizTWot6dQdRFGgbzacQEqlaNhVGe2oIfeEEnf1e+o6rSx9bRUbPTgUC?=
 =?us-ascii?Q?Rl0hz3q95fzG3f6Y5miFnLjbbLU3YQeO7BgUyuZzU3Lps7/+8jYiEMMKadLm?=
 =?us-ascii?Q?5X4hRZsxh98qSqyzWlVFzK9fkFXW8yDKS7Wa1lv+FNmOIdppezqO79aOd92T?=
 =?us-ascii?Q?kcNOWc6TPK5Eo4ve2zTWm7DfdpMPRqPwzxDGWQ6pCxeeJ20gxiVhGO1bKLNx?=
 =?us-ascii?Q?zeHHZvZucZlBctNZyvU6Nstqc2Z4WQJsDkBnwpTMB+nwXd75WOx8zQQxpUgL?=
 =?us-ascii?Q?zeOQEGX9OCSVr53+9Vng3mWDazDvTP9BBoS7aFYDdZ9aix2D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e91895e3-5753-422f-bbc6-08de890897dd
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 18:18:33.6336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzCLm2czS0z3zUCJUy3n1DpCeqnxz1hIIjkCt+WSWLZpfbhw4RCXfdv80CsyNX4F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7794

On Wed, Mar 18, 2026 at 12:56:42AM -0700, Dan Williams wrote:
> Lukas Wunner wrote:
> [..] 
> > At this point perhaps your conclusion is that netlink isn't the right
> > protocol for this job. It's great for transmitting sets of small items,
> > some of which may be optional, but it's obviously not well-suited for
> > large items.
> 
> Right, and sysfs is not well suited for transaction in/out semantics.
> 
> > Jason Gunthorpe was quite insistent that we use netlink and you know
> 
> Jason can of course correct me, but the insistence was less that netlink
> was the right tool for the job, and more that sysfs was the wrong tool
> for the job.

+1

netlink is a good starting point, but if it isn't fitting well then
the next stop would be an ioctl char dev..

Jason
