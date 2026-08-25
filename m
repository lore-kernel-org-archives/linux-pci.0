Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0FC38DC77;
	Tue, 25 Aug 2026 17:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787680418; cv=fail; b=ZhhHE3HldtvK32A4HU8qFBWJAwK0QYqGmv4hX1SvsA0qGhHZmXOFbiVK3HLiVe6iMWsQZDpKOc0+gTdHeKRvCLhwckhiE8qo9XG1UslX3SgcuW27vOJvCnsq9qhGT4d0tBmAKfaKMcHdLeaU8IUd3g73iKLcQsqgoUiAweGkawY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787680418; c=relaxed/simple;
	bh=FsS3xGAXH5d0bSQTrTkeuc772yBE1Rc5NpK3TzgP/ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zgm5wiHF2LXyZiRWJKN/KLEkzh3hoVJfvmyDhQq6Ydl/spWnsc0eL/qbcruVnPFCQO99AeKhIamJbGqusoydQzmUNy7dF7tELCcdDBgbI1AT7fVCevDTJfof5PiqfmKFHvRIeKRw6XV7ivwnS7Es04+8idLjj96n0ZSnEOsafm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=utqJBnag; arc=fail smtp.client-ip=52.101.56.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="utqJBnag"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIQtfbEIfvvKfvCOMqHFPodMK0tO7Uce+KQocv4jNmqHFCRurZ9RdX9vi6IiAOYkSPXKqWYxZE3mE6gnfqVKtjVXniR12i8aQSdaJDrdPiYkOoMFVu7HDa/CaFVpdYms6qzeRy2lHqfqDa2pyjEwML1SOSwP8ALAEau6BVrff2glancdk6MEFLSAnUlm24fgvYT1lFzwQeRTuEpodjJKCf8VxMznsiT/6DrzXxIjoMDL/1vGYe72IsGc4Q0VCljekyYhpKqodJWN0rl3C66uIEVbmYDHuBlg0nr9f9wHCQzQ9c09HD/5fm+qYqmSGjs5qWwyPBpaBeXwTXqa7h4xRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NK6Ghj74RUzB+ik6DatOmPmEeatC1W/2kQqqDgC9dX4=;
 b=oeQLWK3CybAC406kKINHxJCiR988yLSoH8mu7YW5kUn2NcrGhYIhIjmWVHBgBGujI6LttqNbzVkUAhDyIYPN1/U1Bd7XdJ5GaKgDHub70BBX49r6nFVzpS9TpPWOuht9JF7TlGYtIx1vVqLf9j2W4zPGE9u9KH7NakeMg/6Jcybm6y7fCVZrtLv+PQHnCKmMeqh+aVX0jxG4qZiszYlbN59WY/Y6H7QWESEyD4e/i3FLyc9jnUhgNGzO3sPmhdd8/sqKJQ7U+VRro48S0R2KppLxt33Ng9r244Wjpuiqqs/Xh8FTXdkIHiyqV2wRRYcrxLicnoDjTuQIjAr6ibWwKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NK6Ghj74RUzB+ik6DatOmPmEeatC1W/2kQqqDgC9dX4=;
 b=utqJBnagiKAm1352K8OjgTzM98uc4wBKsXTJJx140ENQOanRmZ77iv18fD5wmkagJYpfEFF80lHSbQZVnHdv3HACbtchymcXIYPKUdQNK3TZV7Q2Mgym5x++o0h7W5VXFIbMP55oMaGE4vpB+0WS7wGWhkHQTHMI2JL2b+RCNieLdAcFPzD2vz3hn2atQeJOFNAlbYAhNPvppX4SmW4z8zQY08GyC/f+0HsZTbO/UjX41W/G4GKvHhSljWnyrvR42FRBlSaHxOFlvb3FQ4IisXfwKmT7dkBZ4ISaFH2BPA6Mnvfm0ppIwe69023orPq4qCJP3OIdscDTMW/B9ePu5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB6687.namprd12.prod.outlook.com (2603:10b6:a03:47a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 17:53:23 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 17:53:18 +0000
Date: Tue, 25 Aug 2026 14:53:15 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Ankit Soni <ankit.soni@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>, sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] iommu/amd: Fix DTE clearing and rename
 iommu_ignore_device()
Message-ID: <20260825175315.GD3325090@nvidia.com>
References: <20260824122347.1588592-1-praan@google.com>
 <20260824122347.1588592-3-praan@google.com>
 <178759520117.3131778.15279605903087565179.b4-review@b4>
 <ao1vJxkZsJpr1qXG@google.com>
 <20260825114916.GT244917@nvidia.com>
 <ao3RF0w_AXo5EXxv@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao3RF0w_AXo5EXxv@google.com>
X-ClientProxiedBy: BY3PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:a03:254::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB6687:EE_
X-MS-Office365-Filtering-Correlation-Id: 69de0155-4136-41fe-a211-08df02d1be8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|18002099003|22082099003|11063799006|56012099006|6133799003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	M5BEwzQoId3AmmTwLSiPl1aXTpwGxABRTZWlICiTN8sbEIkmjPq37m4R4MDKgyucNE+J+9LpA1G3ZvyCdbXbkrNOYAayvk50mLfJPzv/EHTGyabAcHwACciGLD++mCJYQA5dbROIhMbUrAwzSZhmQPxu1/OcdhWMeZIzN7OuQqQpuglNcVBsjrRCueLYVfg2ylBdi+0MDpODVRBM3JkfPJMDToO5d0IhJgVAYS64EFsSgv7ZIhIpWlZZLheevp3RMoUPmFp95LSITtWZrVAiG+oCpEMgZfecanejDZVKHxcUdKW8s/KTsohg1jxKDlfnVPYtAAgtliJU0WnIPfIfb4wLu35Q29UZRCDuxbdkwR9Mk3EoiDq7CckYZZxJUjKVW0asGGeXc8Zl8K640L8bvoKBwopr5DgtVKLj+Qov8j//+1id448HwI+F3GiS4ibok9pqtNWyJkJEhux3EJKOk8kXa+Fz3+7uNa26il3gzS66QytlSeLWSIfFM1aruCkTuZi9MutJk0lLGtFxfIkaSx26/lf9X7u4Dp1icz4AvH+1ar5tTnOisVRkKki1kgxr9dPy+8bqWu759EzIw/Lvg1QadB/lbdS8cc6BxEQ0+8HcBz9klwiE4+MS4jq/JbUOjqkxCKgBD6JNgEbfeJuMPDKff0WSebMiFA9u2PJdLeQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?feVhep3OxJeR/imaXqbT5kZVMphWK/3O2LykNh7AueH50c1v9oDqY1Laq+uu?=
 =?us-ascii?Q?0tkaLPEnVR8yHGgk6TwjZxTgrNrWK2P5N41CuOnFcH2cXfjbEKopDYJYFDu2?=
 =?us-ascii?Q?A34qN8fJknvRakQvaIbMlGyJwaZh+WQD82GqTifTbPX1jQucrzC9GbMyz+LU?=
 =?us-ascii?Q?/DJA0CgbGj1MhRHm8HqmKN15pbqVhyimDqtbZOM8QQ+S/HOYWSJUfk9oMe4x?=
 =?us-ascii?Q?Wnx5I/L/MIHyykHKDZIc41cvmGayEj9aqGQJpIMCKNvSfFG/n41HtmCLqRiD?=
 =?us-ascii?Q?ic9daSlL4IE7u6dJ4Ok9DaevoFBrbMkRp89zIK+l1YylZxJ2ZkqeIua6+N41?=
 =?us-ascii?Q?8a6cAVEctgiMb5zD4ZohsknRWIn+9pxQ1bjwkXsqxrP0rSoBTfgpT1BQNXtN?=
 =?us-ascii?Q?eb9Lh567ifikn85DqlfuhhLX1rM1fSI0tecvf5ErhStmJ43NGsMKcu/ssYmD?=
 =?us-ascii?Q?A4A8y9xBWOVYQnWgaHYlXn4tlAHg9IEPrsnRf4wqsA/f0CkhgwxR1kjTIYms?=
 =?us-ascii?Q?HH83V+y1ZtejWE9XmlXRi7+qiSW++2vhAt8ANWIo8vi5mCl3sChAGTlqp9Kr?=
 =?us-ascii?Q?fqLEKT2+sAN/tjZH5O5DceWq5QeRnhPXoMJtj8MZSKbRTjtDnXbECv8yyM5w?=
 =?us-ascii?Q?XozzKoGjO+vpXY0g8Uf0vIMPya9qaJ8r/GpZC87EhAFzmbNxsYTqUevW1MJB?=
 =?us-ascii?Q?N9AJ3I6uVFHo70CBhsT+1CD57SpwTXh0rbKXx1k7Gp6Zry79WyopXbrrq8dN?=
 =?us-ascii?Q?9U1xI4p4v/i9NKq61YNES1ebxV4naWvVgvKnj4hwG1yVnRGLobOim8DDLMge?=
 =?us-ascii?Q?3XvZ6Y1lG8vc5h9wHJLLue/CE/N7tOCP4M9P+ZZlIQCtxvsncRVoy54YBWVi?=
 =?us-ascii?Q?11RUO9/w0Dz2YTMwWOUXdFSXUZriqov9aEfATeqCroXVequ01Ph9xAKhKJdI?=
 =?us-ascii?Q?lkfeu4j8FkjlMamTmZmvN4XfoDLziGZ3wNvZJMe4KkCgyCCbpd13vw3BujEu?=
 =?us-ascii?Q?0zY6lAqQQeGYFCrNJWIGc42c1Y0nn81H8Gds37ZWx7jMgwXgGXTm43LEYIMu?=
 =?us-ascii?Q?KySjYU3jqyZ5+/AdQLVX6fnqxcdS0RcqooZVdamrIYzLyukXFipywaY6F72e?=
 =?us-ascii?Q?PwpXT22bohr40YnCJvu9wfNLJ4Eq7ubOSWSYWbOhKB6sjcqdpVZVskvrDeXN?=
 =?us-ascii?Q?V/jKx/D8Wnavuwg6pddLcCpzPeCyjzBlC8cl7GBxv6RlBF0f5iiIS8xnm6sG?=
 =?us-ascii?Q?ZIBWfFrsO/C0qoQLULoFglu0yTF0Sy3GvOMHP73//Y+VB7uVRzC4Aqd0ASDb?=
 =?us-ascii?Q?j6y1cFb7WlUoeRjWmIJ/FO7kM46tufINvU598ZViMK42AxxXWYcKjuGJzNt1?=
 =?us-ascii?Q?PkhiKjYvtYxkF9+vKdwlk3Om2t+ml5Yq7GmWSnBPRJp2w7IX56FXziJy+bDU?=
 =?us-ascii?Q?Iicl1pKbnIUYw1g8l5vTTW5vAOX7mIcZD0CmEPmZrU/fjSc9pGE+mM8va5Al?=
 =?us-ascii?Q?Mem5jGQi9swANEVaSJC2T3aStqeZL2xsqpbsT+H2Q5jxueuUjwpyecWeMC1J?=
 =?us-ascii?Q?DQvxLYy+4uIsVQb9y/7Xl2rHISaoJVG6KewDCw+nS7Wppvnj7fRpcGOZ3QgR?=
 =?us-ascii?Q?cYANwxJ085QwftRMqkxS/D3hf0yXI6Y0jwZ7gMHtWaPm2ssG4lH+vbLZDESR?=
 =?us-ascii?Q?NcxRwsnQe3mFlEsrILQZgOI8zAxT0F7Tb6XNeprU2B14+GNl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69de0155-4136-41fe-a211-08df02d1be8a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 17:53:18.0554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 01cjM1NuBbck/OzzAs62rgc9mjtTIs7iW2a8G/TV6L8qWexKWFOmHkOmsIRbxmny
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6687

On Tue, Aug 25, 2026 at 05:29:59PM +0000, Pranjal Shrivastava wrote:

> I agree, but I wonder why the existing code used memset here 
> (in ignore_device):
> 
> memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
> 
> I was thinking it might've been done for probe failures in a kdump
> kernel (normal kexec would've called shutdown for clearing all DTEs).
> (I see this was added long time back and existed when PCI segments were
> added [1]).

For kdump you'd want to keep the original translation running in this
case.
 
> Are you suggesting to remove the DTE clearing from this path entirely?

Yes

Jason
