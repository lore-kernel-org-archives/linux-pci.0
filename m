Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012007.outbound.protection.outlook.com [40.107.200.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAF13D9027;
	Mon,  8 Jun 2026 18:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780942614; cv=fail; b=tCnreVZ2n8GI8Pcog0u/MoAOhmBIxJ8fNvYF7NiVn/O9Naf1pD/jPFPaQEs9UtQs2h1kEhz20WGuyle9RorV/3k3rWleulDiNypT+kD49wr6W5yYHtZHEvOVJ+elZfBfXZeD0+1gK7bq7XBqMFqleuZ6OAqcjgjFDWj1uLWDFWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780942614; c=relaxed/simple;
	bh=RUTd2xA1KKZAEmmoQLOFKXaRhtJfZSQH3HwyE1mkmgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ECp7SIIOHxIRgUsgEuQ1J3aX7HV5xBEaklW8pjUlQXAfFUcE2MV38xZetVN4YzMrlj7I2oIvfolpiKOHvIAgg7bB/QTmevEsylv7YtTVNft9TjewEAmLzSpbjBglb8ySNPd7LZb3ZY204iwCB1RUCj2hlw4Z9ZVh75m1ghpB5t8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pyJ287X0; arc=fail smtp.client-ip=40.107.200.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pyJ287X0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEF3l3d/Kn6MH4K0vvtyHSAEXmocs2gMHT8WlbRD+RKlTd8/xHhDXfmuY8cH2t+hzCfUl9jG9ca+mdnyF/kqUb9iS9s4bozAST0Qx1fGqJ3oqtLajfCZNRO+H6dW3709Ta9LZWZ1bWEahwn/fYrtZ6CQwRi++r7N7jpTr5xOLk+404aE1xCvTHcmHvSyw1C6w46h8myx+jRJY8ziLZmie7OyIumx0tTpO73ycOpC0MxizzBXe+QmLfNa88iB78PLKatGf3BfXQqkgaoAHtnxtsZYGJc3rJNKUqqV18ba4z2/PsKxIGYL4kMFdLQ+GbVOszWcBI+lHGMV1m8tNbz4SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUTd2xA1KKZAEmmoQLOFKXaRhtJfZSQH3HwyE1mkmgI=;
 b=BoVsqbp0OsWvzOOcno84yI2yaFYW/TgvCH3Jp3BOPEDJdJDD65uSW+56Wf+uTSFnEJE1byPuQ/TVvkKocYWRkx25ucvKqZ10oNDAZXQq61IVPkGFnLlvx1mjvV1PbCVVcz75SX5hfaq5KvlmsBHJEp8i8e2FyGqPAMAf7+Bi3UflaZU4CbKtlo0KV28kVZuQxpN4pCvRgpTTDwxFq2za4ttSda2qZtFI2KrcMQdkbUsKSQYccB2ip8CmNdO3/Z8QVaeKKTtI7N8UHTeynjFsqehZ5zMWpGVcm8OmQx+7iiUuChGdwkxss6sRhtn7TEn+rrb9X8yhhNo8XPh+IrsvEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUTd2xA1KKZAEmmoQLOFKXaRhtJfZSQH3HwyE1mkmgI=;
 b=pyJ287X0sSlgsC1fj6cKPBJf31gmEtEQuPKLnCsyM0VDJuqbiDW0vef4Rvc69kG0aCVCpdJJtjNAQIrumXi7Sbkm/bmhGYvA4h684wPxt0E+3dxNiD7g5DJt6oCdzqBnvyAx19FqBQmdIpJZPjKW5zDsnrsIun9GzLSiRv2Ofp0PsvkU+SPMQuYk1MCYmG/m2K/PbGG3iVPf0uC+ckzoMaMEcBzIlMpy1LVliJD6m6mYSzajzegNqWbFs8IShhHAt+8T26MijqexxlMHUHzUa0rqTBUrMYAFoNTlcK87RyruLhRgoqXD3FSZ5IDkASQ93GmrNxZ7XONW9JU3DnPsdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH2PR12MB9519.namprd12.prod.outlook.com (2603:10b6:610:27c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 18:16:41 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 18:16:41 +0000
Date: Mon, 8 Jun 2026 15:16:40 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 08/12] PCI: liveupdate: Inherit ACS flags in incoming
 preserved devices
Message-ID: <20260608181640.GO1962447@nvidia.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-9-dmatlack@google.com>
 <aiXWmR-ettxin4LC@google.com>
 <aiaeOVomxQZhoM3K@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiaeOVomxQZhoM3K@google.com>
X-ClientProxiedBy: YT4PR01CA0101.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH2PR12MB9519:EE_
X-MS-Office365-Filtering-Correlation-Id: da483ad3-8fed-4778-0706-08dec58a16e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	S1wpMTpXdj9au2i9KYtZt2LR2lhpBTbyB3UjfjPUoCFIpI9Wy2kUbRn1J6O+aNJkEKtyVwmgOso6L3837FsU87JoQ/AFW06/mVUxaPFrCnYNjzD1pCXDUZ8xeweL3ExiX6gnwnerIIemX/TV8dJQ5tTtrRXzN4Ldm4ttzD5Je0aSiLOn3lehqTdffE/01kQ7YKfgNr4ydjZAd0egMDKiyyarAuhkMrWuMlwqiIwn/zgtQlXyUJdH5jNAAiU797inamr4/BMwNrOQYHTRNY/Q0BxatSWWkw2JCC1bGVDu506sStF3xrBOFRJfmNAKRx7pX/lw0PugAltzyG78G+4revqjQ+uEpFRzkKkYkgBXZezQWPXEvv4eMY8Wu91ZTsHiP/zdRAnC+1YMxexRaNDLpPpzrd7cT3vY/26oIVZhCJzeW0UATPd8c7xjTNhXULuQqmWzM/pNIQxcWxi4ALH2G8MA4sly4W5IDQbNVs2pGjT0DqlFA2inSwaTDQo8GifuwBQxD/9Leya3DNH207pE6cybicHJZWeV4xWTQ8zuB6eSvdgX71T0KWM8NRVY/McJauSZhNFmfYE56qmtaKFZXRRTwFdGZ3fGjqSoDOXuKw+4ETEIQDsEEW9cfHWy5KLlq0tDVxAfGzdw8Sr5UHngkbPlAKPM32D4scGhVibbDIUqcE4TiBQKOhA7UeiF+9zb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v91zFJUXVUAWEFYtnNkQS4FJ7wNBmHiOV7u/Hv/eT2w1V+qb8Z6hnZGRD6fB?=
 =?us-ascii?Q?J72B3xtm4EuwTPxSHZK2CD8WDJcy6f/ENZ9Hm81b/eexbB+IVLOL3llo1WXo?=
 =?us-ascii?Q?T+mM6caXTe15GWhaQPG2K3sBPE6IaDgD5jYgbFJF0S7tM95nTnPzryzaMn7m?=
 =?us-ascii?Q?TIW2Gdh/q0EzD+/PS1RYNpcmV4ocYLyX8s+5zo26spTMGao0Z0ZgMaxyGzGT?=
 =?us-ascii?Q?8odloDRVELlM4I5XyXZg9053MEwSQkcqNU8t5AyyVskST7Y5kflLw8bVj+tG?=
 =?us-ascii?Q?jRT7ItQp6wvgHRw+7+48Lvss1czupZa08Og+8gbBP+sOeGdhuvOV8dWEtF4m?=
 =?us-ascii?Q?h5GVnNaOa1YuZJhajX2RvGPq3KNGfYhX3FzSuLBPB0LWLvSalG+3B/8vSBla?=
 =?us-ascii?Q?Lou+3R1rqfyaNGclCLnR5KhskOclFUhPuRh0c/Uxo+Bbu2xYLCkrjZT3Bt8e?=
 =?us-ascii?Q?rTK6jNgL9XYYGj08C0CC7ni9+O1tRni6E5KkcXxCINAE0Kxfxx6O25W1sIn4?=
 =?us-ascii?Q?XKPqbpEhnF8EJpCffHyoK8iyaPsYoBZEeyHtJXqsuqYzCLmk2FF0rfmf0i7t?=
 =?us-ascii?Q?9ihrlnfmD2maj2NYeQDWgX+GQsKtJUVLVyRsxjuHZ/L/2kageh2yJa7Ticco?=
 =?us-ascii?Q?ZzJTmFIithoNq1PY1gW9lcM0To3HEdC8sQN2yjJgHhVALPFrrsspfTP/Q1HB?=
 =?us-ascii?Q?x4lFSICPYG9x6NJgyxI9cs5TtOg5Wdk0J8/uUMK5/S9OXQAPnbn7M6Qe4ZK+?=
 =?us-ascii?Q?KfiogHWOCqEvBUXwhxoHn9Hdcwys3IeGN1mC5sXcNl8Ii3rtaOk10ZIB/PFP?=
 =?us-ascii?Q?XsmNxX6MP6QLP8i5KD0DEAiUnwkZG9ics+yQo+pmq9FEaghBiDUeCpdN3KFp?=
 =?us-ascii?Q?aPIHHVlELVK0cwgejsqzQcZOjNL1hElOP1b1fe0obQJHHBxTfqhc3/8a3TMD?=
 =?us-ascii?Q?LH/p1y9rrPJPsUuB4XjZjqvpI0FuXj3qZQmLfYdqtBwHiL7CsptLjguCaZgJ?=
 =?us-ascii?Q?a/DDYicrztZwp5wuq7YMiFjrqW02Imm+zs9Oo2/f5O+gTwAhv1NiieXWNTtO?=
 =?us-ascii?Q?o9+veeYtr/HA1vA7wdHD2PghEMM5wL25k1EF3wDxczJJeZONQm51C4noe8km?=
 =?us-ascii?Q?opL/nq2oWXhj36mEkvyFy2jMqFZIlweuhkERdEWWLDoW2bPYJPsEuU55u/dx?=
 =?us-ascii?Q?m6yxTrA+7YNQdwIQcOMxKs3sGrFVci08PV/e7Ic3vlEHXaUo5viQBIqGlOV8?=
 =?us-ascii?Q?xPuVd11aFYXRSjx1v+Q4rEqHAYzldGCysy31Ikm3OaW/VicL4ySfRF7auCFG?=
 =?us-ascii?Q?CfIywBfRLPJPiFo4PfJAwGUqopB6rTPoUnq9cuUpcsXYlAYhVaU7DVuLsdYY?=
 =?us-ascii?Q?UXt24THdVpG1oqJ/qgq+74m7aQfGJ0knsIoGT3v3qNNrOLxqhvrVTRqnIc1+?=
 =?us-ascii?Q?ZhaUbCQM8q+e+YsMjlLiN7H8J72TYyXIy2vaGubB4ReWQFDP3L5hZmpzS5/d?=
 =?us-ascii?Q?W870ODPH5dAOQaHDxPH7tOxjm1UTauzyMjkwAVcfqjhcXFxMTXjOiataWRGt?=
 =?us-ascii?Q?x1nyPsx1/1kwKHpVEML6rP+aCP2zIw7PM/7AKPugsPQnMmnpA40RZMt8ApdA?=
 =?us-ascii?Q?w8MnumOvSIsz1orAh1QEpiixsjJjsCmEegWeJN1a03sNz3b6hxPjuOP8KFAs?=
 =?us-ascii?Q?vc/nxLCjYUHqFyDZ2zFxLvdKUDQndYZGxFLcsN8/4DZx71iW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da483ad3-8fed-4778-0706-08dec58a16e1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 18:16:41.4447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: idmy3wVbR2K+gT66+w26tRJQZYYhpCnjt+2WCjmmjhAi+RM6WFOS9A8GBVJazp+Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9519

On Mon, Jun 08, 2026 at 10:49:29AM +0000, Pranjal Shrivastava wrote:

> My point was that a FW exploit can meddle with the bitfields of the
> ACS_CTRL to spoof and mis-report the ACS flags.

Devices can also ignore the ACS flags. I don't think this is an area
where we should be worrying about devices being actively hostile.

Jason
