Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011045.outbound.protection.outlook.com [40.107.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CA62C9D;
	Wed,  5 Aug 2026 00:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785889894; cv=fail; b=lJvEiGkSKmYK/GHaHZ1/JqSdbyzmdg22ktPLjgcgxJBodtv7T6inbqoU+wGUIH2UodTVxf7zyJMufOUDLoWcK1Ssp4btQx94rCFTRiKaTheNnhJzIZPs2S0y4614btbdQ7M+blqYQK9nc9iXEHYVlJ3mOCSKp6jxVq42WBNVpm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785889894; c=relaxed/simple;
	bh=JV0rqBPAxCNdEjNvr1pgLjnnehvL7gThk1sNg0BXgOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gk3W+IwVJzHO9ztqQ6t2DbJww/dw+ZWOWx5yJTx8DqhnQBYtUzCzdcO5aC7wd3mKkqxPgF+3DugWl4Jk8eRS+zQYPSXIDYgK3FY/fx9rnoZqUz6I19BEulaSOwp9VFm2BcN2ep/J+fT0a9xzU2iV3iE/2T0J5LrDuqLbtT29wCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gi3EywTO; arc=fail smtp.client-ip=40.107.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gi3EywTO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/VWBmXDRF4VtpqX64xJ8bfcf+EPW3Rs/etGxmPmQMBu838diGfwotYsqtKXHCgVERqS3c08m63tCpEcrAzHh3HJU9xFZEAdPnaAaixBOVm9lfz9pCjTQnqVVGG/sGSqpYH1rNSZNsGNEeTyHcP3oscCqcmyWVfAB6AQXoSaxDr7ENYVli6v1kFf6aa3/tqmQrqUC+V+nGOTSzKqQbhGBbmpMyhN8VVhOscBFLuULEru7UklnWwr+B4yQcZx+BBm9lzo8NfD9Qz2JW5tqK/5E6B0Mb28pldnm/7SBtEO7+VDh4Q0wXcpFsd1mdTGGM/qmhXMyOMt6k5+chWuXqwFTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYU4P+GYPulSFJaSVmTLP9g7qHzI5DRa7qet0RyvrzE=;
 b=yRvfQfF5vciCKpBwivxS576/CMsCuEfry+mzFRviW8SOuMsmfvp+GcRJ19hOFU4CL/0V7mhF23TMvgck4ikeOupjP7sM2Na9V/O5C8cXJ7ks8bjQ5N3lrQ0I6M1red9ZBvn+QHk1UFYAP5mHqheEtSl3cPaTUPHO/7T7oL9YtHmZ4Xkc1v4R+6bUoPoQbxG7RZ4+MEIZIv9UC0lJ1m+rJUFAF/3Axxd5gVuCYz/S9WokGTAMRl2R57QNxw4ZMb4AOaP0Q6AyaiGQ0Ql/e4QDh6+sC5jSaFG80tL0QSM67K5+7Xg5WDyN5BBmw2hcRkysCOKxCU9gMgkeX3kdz8Gjxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYU4P+GYPulSFJaSVmTLP9g7qHzI5DRa7qet0RyvrzE=;
 b=gi3EywTO+TKihzslrS+JqGf2pB3/dEanUqcTmFcwO7/R/SwH3aYaVxCT8jJCpPCN+2S0j/4nhepf9lDpu1Ql//e327ZP6t4V7DtYJsOKeuv6bjC2LUc8IiZy6qyT33+s0wNzyxCJzuGgpXTJLGB36EAxLzRiQZvmmkfxCkso8WpcLi6FExtnwrEXcJOHrxWXsekT86DTMPMrtoiuufx1CUkbvbmJlKzUWKJcVGl1l3cLvf/yZGFXlB9y+vPJZUqRmBRU0Z32T61IxdWOVOfALekptsQHxClki9knzXjm4rQ0NIc7CCt+GOF8YC6+lWf+k2NIZGLoNmfZYFvnW//zvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7020.namprd12.prod.outlook.com (2603:10b6:510:1ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Wed, 5 Aug
 2026 00:31:29 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0292.015; Wed, 5 Aug 2026
 00:31:29 +0000
Date: Tue, 4 Aug 2026 21:31:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Alex Williamson <alex@shazbot.org>, Matt Evans <matt@ozlabs.org>,
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
Subject: Re: [PATCH v5 1/9] PCI/P2PDMA: Split pool-related cleanup out of
 pci_p2pdma_release()
Message-ID: <20260805003127.GJ27883@nvidia.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-2-matt@ozlabs.org>
 <20260728163343.2a39a8d1@shazbot.org>
 <20260729100840.GM12003@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729100840.GM12003@unreal>
X-ClientProxiedBy: MN0P221CA0019.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::33) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a425439-cfd9-42b9-858f-08def288e3d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|56012099006|10067099003|4143699003|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+DiBM4lVDeL0hk/0nHcW4nVS/E2UP3U3iCBON2IGwE1s0R7uD0p2R7HWnhdBnAO4DyVyu0hS5cJXgml2EThnF/gIiNH3dlWn5CcDW9WFKKPb0tzeC1SyxhjJ9KGwNfRHk0Eb/2x5JbAYhPOgK1neZiDvCoAfTaYSkRZ9aBv6bHMqmOrCV7kVUdykeEhIR/Y+NTEnUXDAzzYxcT7bltcfBrFMz8Qz8msDp+Tz8J20QVtimYRh3qGtduxIKa2fTCLkAk+ia8souO1JwM5aAg9na8F18oy0Z5NHaQ/aVZaQ3NlorcScJsaMBgiqTQNUDRyjgAp28Yccc9DWAKSXuafyPDqvK9Rj+3fbH4SLaWtXOpJFDnWUiq04Jca/y1YgUAaKts5M55D5TT2gSok1OZVF5dzG3c5hH8SDkjT5PzUQ3cu4NNvxbqygXoJusRviUWKLCUAT2l4KbPfNT9yZcmE5H8h5ppnJxUiujGeaJ63RA8t4FZgHy4cZYz4Iu5WB60jm9YcOVXVIFgtndFSpTqK7Y+OGEGzUGEOaD8LwkvUGc6hKTcqPWIktdxNGRJU5O+6xL25Pik92foRlslWmL23ighVW0cwuwDRg1gwfRT29/cbqKDEtWjqLIVwCbT0nUn5O95lS+B45jpzwKF9oyb3lydAKAjW76t1tSfNXCb9WMGY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(56012099006)(10067099003)(4143699003)(5023799004)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pSqoRAMR+5KUZxiGWN6MC3LZJr/O1bKOrF0dsPE4bIE6ZZY70CPrLitBkEFz?=
 =?us-ascii?Q?XTucMxn0GCmMK0gFCBeCqPKhFn07lF9F9cEWh0rMOvU+6U1+0uNxI0rRBIKu?=
 =?us-ascii?Q?O26hb40DpBwkAy1I3E8CBeiiOADHCTOhJY0qYXQ6N3HKtl7+bq9Nc/+ZyuY4?=
 =?us-ascii?Q?Jec4NITHYcj7yNnDQ+GoUys7oArJkTlgqLT16sYW1JWKnL7LoOsSli64RNRm?=
 =?us-ascii?Q?xsf54HZ3aieMwdloiWOBXBXZ4n04czsrb4QOxL8BCk3x/l3i3QEnBjkomihd?=
 =?us-ascii?Q?nt/zQ0eewChvpKU0yThkQYoYMO0sRh9zZbMuzaOx72jBiz2ZJahT6X5pl8KP?=
 =?us-ascii?Q?br97Ve0sDb/9u2b1Le8kN3FNxX6ysnGaisQ1mHM5I7F5kPXsJAKtVME8iQeW?=
 =?us-ascii?Q?k7s+C4IyNwW0Bl+wcICOedE+18HeK1afYlLe3bwWAiKClTXuYc1rHnINm7OE?=
 =?us-ascii?Q?kpB6TDeJEe2S5dFrFGmzuE8ppK/vmkVbG8LcfU8ZiQyRLb6Wh76FPIAnaEf5?=
 =?us-ascii?Q?TlchUy8w7vNip7GBPrOpxZLOwD/Vv7u0Vqg/BNUC++K06FaZEccT2x1Bkn2h?=
 =?us-ascii?Q?/oVb7G86KTNE02qfNCddOmp/iCBQIjyREIfsgm7ZmBUUmJSEgWYZCqhk+6N+?=
 =?us-ascii?Q?tKBn3t6ki/UBqAl/m34ib7IEPVyY58OeAYBDSiPrLqXK0JLtNVsRlhM2MJq4?=
 =?us-ascii?Q?ABdFyV8UKSoYueoI4yMz3mOD7vH7Yx6wf3syZKBNKRbKinFlOEQKpuTcJ+uP?=
 =?us-ascii?Q?jdLuqQrAG2leqqbid+iQ4Q89NIbm5yKl13dGLDxwhAFFMOdqEyEerELTPuCF?=
 =?us-ascii?Q?j+78hex6pvoCbKNymrf22nQOXMxAcfnInFIlIWTHSIHKBzBWVHLOVIEUB/cN?=
 =?us-ascii?Q?kurkzdcDP/PGinHQjsZfOamto19MPuB/8Gf4SPEEWuPV/Mb8T6+hWl4094pb?=
 =?us-ascii?Q?eu14DJQp3AHsipED/zqZ4sae/9i+q+q4bLv0HyBwi3KzwSzYoIlEC8V87jRZ?=
 =?us-ascii?Q?zBj18d0O1A7vLzEUrsMPlHAejAmQVA6poblRlX5DVZ0xriSlHlXXVh8fp+1Y?=
 =?us-ascii?Q?a3xbJmN4LbQISCEkQ+IW3jvdsBGxfOGDi7vhYxXiEkGXmhnhgA1+ZWIoXGiG?=
 =?us-ascii?Q?2irXKou3nxDqpo9v+SA4i0MeXbdO6qF8yzRLkj2kbyjdBGFdNNMzbzfpI/fm?=
 =?us-ascii?Q?P+aYI3s62j3D102uxBzHtWRJjC0mE+b5slNNWQO4j5EnVfNpZMvuZID0spIj?=
 =?us-ascii?Q?WLiKlYccRivFoPa/OSiiIMLQMrjKuhJ3QnZZzKrN23lAa7W6Fq125rjqfgnQ?=
 =?us-ascii?Q?BGIdWmPMBSLYJKfsyAFDzCw+kpoNctgWaIhwz/gA66caIs+6qF9SwnBY0MwA?=
 =?us-ascii?Q?wv98YhIgavWuFcx9T3hKMLxhajMzC08t1u8Qyxnr9GqL1Y46sOIobIks5S9G?=
 =?us-ascii?Q?hYehOJJ/l2g3iWECQmmJDMjgqkpAaK8o+HAxlC63fpaWI9cW6TSDMVKibSsN?=
 =?us-ascii?Q?1VQ1+JZMn3Bjo3Pm1wp390JMzsLqPv+4zcN57tkLXq6SSCJ0oeT4qkwFMVvk?=
 =?us-ascii?Q?RL4Vb7xRxTpSc1K2iPJTjKyZKdyc8dq84Z442qr/aOSduwmaRJ2SIhDMikqr?=
 =?us-ascii?Q?5Nd4xIF28X6TTqCa26YRMUOi/1ghxyoaL7YfsHIeYwy1w3hysEqY6d112kXq?=
 =?us-ascii?Q?bv1xhsvL4nknqBHnEQ0Ff7eRAltmayGT5H5fiw2fk+1HefT1r7pEspXTxc02?=
 =?us-ascii?Q?+6XUvTfg2w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a425439-cfd9-42b9-858f-08def288e3d0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 00:31:28.8152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMuyn9RJNjXGhplYeOa5Z4CfTe5tS7arb0cVzWuJwVhy+dy4TXRvDD8r0En0MGzW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7020

On Wed, Jul 29, 2026 at 01:08:40PM +0300, Leon Romanovsky wrote:
> I remember this concern when I wrote the patches and wanted to remove
> RCU entirely. I revisited the Sashiko report, but reached the same
> conclusion again.
> 
> The "bug" reported by Sashiko does not exist. The two-layer split
> ensures that p2p is bound to the driver's lifecycle. As a result,
> pdev->p2pdma is assigned and cleared only once during the lifetime of
> pdev.
> 
> In this case, the RCU primitives are effectively NOPs, since nothing
> will ever update that pointer.

This sounds right to me too.

The lowest layer has no need of RCU at all, it just remains RCU
because the genalloc layer wants it as part of its locking scheme.

So long as the genalloc gets the synchronize_rcu on destruction there
is no bug.

Jason
