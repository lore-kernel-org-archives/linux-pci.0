Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010071.outbound.protection.outlook.com [52.101.56.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA7E4C6EEE;
	Tue, 19 May 2026 12:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779192765; cv=fail; b=ZbBCH91BtTtpRsRCoArT9NC7JM9DQaVUb/kU9p1HcYEKT9LIxA+aqkgLfLi6ck+P6XwefpeZVgiYVfivYNvK/Uvx532su5E161hFQZZEUD7sD7h2Ok2D8vpqY/SzoCIZvMR7rP+Px2p1uSNuapIUjp9JkbqI2XHh5PoSUs+vbdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779192765; c=relaxed/simple;
	bh=z0O9lIxDvY6BfoJlQPUCLcx431ZZe2dc5Nd4dhL9NWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tk7ziRPMjtSbHkohtbXanJf9FwL6iMDkoHfkF5ys6+cuE7C5DWKkrhCsIU536Jtjnej8BCOfJB8/70Mgmrc/onp0WZSPFVOP28ZZhVE4KaZY2SYw1tfHjeDVsJB0Cu/eJXrQn6rLmC5Adr2Q8u3ZudW2J4Lkxi7LwDB8eswvya8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ks/8EEwj; arc=fail smtp.client-ip=52.101.56.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ks/8EEwj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F66wixQPTaCQ2xkqUnJu4ZMppR5OmsgeANwDtemtiSHG8nrqcwlGlSrS9D7xHbhN2OxP5tZAjJcwQdxszGPKDBYl2oVhvMEnltahAhjGrbxWsd9Kh04MIPRQSRPgePjm8qPZ6XhnmfYDvy4X69d4BRbadPBad3O9+iQ3a8bhq2FQQpmDfmLOWSY5WmDBX5Y6OFTs5YOQqGrVvRlvokKVFB9XYmJFpyY1w20uVAhfjl9s3ODG6tiwAteHHt9NeCOTy1qpSe3AEJY+/hsULamnh3MlrMMRuEB0S2GxtSN0j2/BrCyAVbAgHX3rr/5fHq6u87W0x226OUQhujpTS7EC+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Ut9TFsHCPp2pghbLCPrvM5ZSOVYj5F9lhffKg/iEN0=;
 b=ioheSlxbARzduzncLjaU6ncKVuR9ZmrGJB48Tar8qOB7VTOHu8jgO2+fMs44+KD/Vpu7KTIa5VHPGEG1UC9N4J273XghxCHhBQzJCiHGxeiMcpWGh6E8CeZLTwQ+FRpyJny4KK+uCkqQaIzsUz4g40qkvad8RZhQL6xG9DOMMMPGeGG4edBON/JKs/3jRkHlUzxjGcATUS3c9HViRNtG6VD/Q4w/dG5VPinE0lQrClpUzVN2bHFVmbJB5cF0accKb4+7C52jvHs/ZJUsXf582GWrHok8wi5DQev/FbOo6omaXlAIEoP1ioj7YQq8Vmg7f9bxI3PwidIxufeeK10LSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ut9TFsHCPp2pghbLCPrvM5ZSOVYj5F9lhffKg/iEN0=;
 b=ks/8EEwjcKUAX5E8LVYWmzNFVGVoqiEEt1O974fpcLvpcNlyP2z7YUXILUAQo+QBELuKNPpNBFrlDvOnhVDHegSbPxwpgASS6dIIjl5+88QPjDZF2oklLDknypux7dNr8qXDDe/8nD55kjtMljksPB0wigRyhop3BxhvUsHd29c9L4SqhrlSTLrq4OuPrah4ELYu5gxZWDMrLtX5kKOL9I8bc3KSI7mWsWnh/nPt6CCcRv2Tc3z3J4fURmS0oJgsGFZexWAB8l1KU9WLr3EfMhOvamsJLEQLn6DyNpgm6M3AMc7GOkXszS7R8igW+uhuRPcl1x4CDaoE4dBPhia6FA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB9431.namprd12.prod.outlook.com (2603:10b6:610:1c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Tue, 19 May
 2026 12:12:37 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 12:12:37 +0000
Date: Tue, 19 May 2026 09:12:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Pranjal Shrivastava <praan@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, vsethi@nvidia.com,
	Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v4 22/24] iommu/arm-smmu-v3: Introduce master->ats_invs
Message-ID: <20260519121236.GS787748@nvidia.com>
References: <cover.1779161849.git.nicolinc@nvidia.com>
 <7fb3652c6448d757aa4b5e7bf32018333e1db1a9.1779161849.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fb3652c6448d757aa4b5e7bf32018333e1db1a9.1779161849.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0138.namprd03.prod.outlook.com
 (2603:10b6:208:32e::23) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB9431:EE_
X-MS-Office365-Filtering-Correlation-Id: 013de08a-c280-4a86-2edd-08deb59fea55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|4143699003|22082099003|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	j+lRrGx/q4EF4BZoYM2ZBWqaEFs+DhQjzCveULZSyr0trFS2RaE+KJfxRlIeRQovDZcnYNouR8iRxLzu1FVYyou3wg3mPC23b4yK2BfBbBmF2ubFxPH5+vqo9BVUdRMAEvC81GR116Ag069rpZPxOsl82d+3+haVVrNoJOaMFG3fV4V0OL0zjPvTPBSNqnUkxisk0O5TyFb/hCm4hwat+gNmHMw3gCtAGIMN4Jc/njx7oTrHZl37Tb62l2PvZ9TNPWYQr1MMh+Wnvt7tZetLdvpuWpxkIT0g0FQUDeG5xeh57YiisFdcX8HYXG0NfVvtxbxXbZn95qZiQcbAeqLJFemIGyVXeB/bc/GDthh6xKWKtMSQohFyA0R0cogoL1uQcDWDxQDf2jM3zi46f5+x20n2wyZ+etCujHbwutigeIC/g426xlkCnvMnYvBXjgFU2jDSC7AtZOdxX7wyeJM4tkumS0vy5ZqgupLP5lJ9L4RkYLdgX2YGNLJxj+7B8LR8SyUmBeDc5KMQQYIZc7caWHXZXFs3jO5YyFS6+S1LokAjmW5VQfAbOs+17PJrHDxiCTLYY0HRXqNuwrpCtZA0WA2qpvFx5FovrUvuP/9FvZSJxAPWLeQHifj/64JlV13B7k05rPHXT67eZnhOt3DDBDDEUD/lOl2Wh9lqnxRLTtILN/KN+XjlYCgOyDgw0Jf/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(4143699003)(22082099003)(56012099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MT8u8zou4LGmKvZ5vSSVOBNTcSd9xMNOCu7Fyzx9fIhdWCFK/rlJa448Hsqf?=
 =?us-ascii?Q?421Oc9TmqPRAsAW7Mhx3eTTJi5fY9x/Qr2c+SQrkHxPVZ0/81OpqbhdRdx0w?=
 =?us-ascii?Q?RduFeT4qgwq67rqhotq8peBe5Gbqat7wqRdD+cZFWetgND2ug2whCn6bTKTp?=
 =?us-ascii?Q?3PbJ4b/CDqUL3UNohLRJ2XdCTz5h+Q5WzCOFGOy7See3WJn0nAft4O0sUJYV?=
 =?us-ascii?Q?nYiE1TQGeyZ0WplIMmKLjjNXun23fIaulxW+AzaZV9CTP2RFSC3zZ3Y+0WwB?=
 =?us-ascii?Q?p1SZaGPMfLN4/Y9+cHdonWv7DqsV6e2Yf5hgJkEXLxB3RSNnqfAwMLDXCdLc?=
 =?us-ascii?Q?nENCbrFbqsgZYrogeo7wmRXONFKU2QV0/JytW750Yy3KiVfkFrzHDv1U9oMr?=
 =?us-ascii?Q?KBhOldBtnHfre367rVUedjistC/SCvWpRFolLDw0T6bqF6K9FwEeYXILfHD5?=
 =?us-ascii?Q?ik49aLRx3GRn9wxZw+p1zDjTxHoHrMi24z9pn0i8BFYpyfH0gd9dkt18pC+K?=
 =?us-ascii?Q?3pHqAMIg9jdZGwio1/mt7QjJH7VjWmQISZFUY3j02rZ4i3Mx8oyUs3kcSMFI?=
 =?us-ascii?Q?U6JfJm56m5dYTj6/5a+i1swjxjk4SUDKChKozd0FgDK9OIesfhpDIn5Uwocm?=
 =?us-ascii?Q?rZX8ws2aTZX6xoHbfW4l3JyggzzrnENNQuFz7JRAtv5xDIiXXEZ9QqIT/lIn?=
 =?us-ascii?Q?wQJ8KkWCkONnlSpDL32gAYLQzrYk28z6+fURVtkVFEblwLm+eHHARRZfTTsL?=
 =?us-ascii?Q?71lUVt9ZkSewOwt/PPLIv+EAYWK+wlkgZ1v6menqiqgD46eeSNFXKu4pAez3?=
 =?us-ascii?Q?qEqjleuJfcyaxFqKlXb4NjdL5DzEuf/pg/yn0eE3nSWrR3pBeT4Lgzkvk3wA?=
 =?us-ascii?Q?oK28XU2T4H7z1M/23Wco6wp0M1gE1uPngon+oBVF1JwwtFPzkqVpCZAR6yn1?=
 =?us-ascii?Q?VQLT8+DbU7ck3OPJuoi7+fKXTwQz4e5+jpJudCGjJkAIsy7TRgT84ISRH1Pe?=
 =?us-ascii?Q?mquMxkr08EyXusx62xfjHoQOXJvpVCOnEH68efnosMCoZt7TOjNMiHbA/4II?=
 =?us-ascii?Q?hJioBxSNDfxSYiWMTZtcBCKAEg+ze9T4LMAuCwLM/Mcq8ECRQasvd/5KK2A3?=
 =?us-ascii?Q?F4GU9qWYwyg8nnXMsWLKf1y8Roa9oaUWbsaIsx1qN4FWwP+mS2jFxRpzdJkD?=
 =?us-ascii?Q?suW9zOz45jNzbTgpxUMLT9xjYD8M+wqqKh7059N+rRUR+kPOAI648u907l65?=
 =?us-ascii?Q?5o8VkASmNd5T2LPTUUmbyeMJP/lnkqGXlqvRWH3XRk8sgC3BbPeLvjn9QEZk?=
 =?us-ascii?Q?UXzJIgv9RC96eP2wPfF19OOM4okcQfB0APHhQ8C5vO9Y47CXcZ5Guxvl2N7j?=
 =?us-ascii?Q?cuT4NAnonX9BM+A1v4Zd3Fohn2xwf7eQ3PH4llZcHSVXGmM/mC+hKyN1nXxW?=
 =?us-ascii?Q?p7kAca9NtE8XZVUZpblwzsB18WehWip6UU7Gu++8yoY2pvl9sElz31oybDE8?=
 =?us-ascii?Q?9GyWYHTj4RAap2vtu73MDNBl4jPv5zpU5nZHPDHcARDN4mAz4S/UH9YvmgBS?=
 =?us-ascii?Q?6g3A80/JDS0tse78wLRylpi06d5myf928InW4kMUO0b6HTTTsS7tS2nz2fHi?=
 =?us-ascii?Q?a8T4aKsYDx9juwh0zusxmIGrvxzU4Xt/xK++Wti9fAQMB3wK6vui3t5ssA5n?=
 =?us-ascii?Q?wHYh/sHTTC/TjtETixXQ7N1qNVptTggakea8NzU/LCTswVDm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 013de08a-c280-4a86-2edd-08deb59fea55
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 12:12:37.0772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: naLh+b4JfiVcKYxF025YtE3Zf5z/A3iEqIXyv+O4XLvX9L5vfpKJMCX+ofxiJEgg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9431

On Mon, May 18, 2026 at 08:39:05PM -0700, Nicolin Chen wrote:
> Similar to master->build_invs used by a per-domain invalidation, add a new
> master->ats_invs to be used by arm_smmu_atc_inv_master().
> 
> Since arm_smmu_cmdq_batch_init_cmd() now takes an invs pointer, pass it in.
> 
> This will be useful by arm_smmu_cmdq_batch_issue() to backtrack the master
> pointer from a timed out ATC invalidation command in a subsequent change.

Again this is a good place to just use the SID and get back to the
master through the rbtree under a spinlock.

Jason
