Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010035.outbound.protection.outlook.com [52.101.193.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D600A1A23A6;
	Wed,  5 Aug 2026 00:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785890503; cv=fail; b=ZERexAHkucyK1MLKUw13qzKFfNYpZ4lx5V0C5K5JYj7aFjPjUCgsqcU1ghxb6vSGkhDfScVzeoEOleXSTILMIScHJEiOYssQbDDmIsBAtBUrcGrl7Iw1tht8MboMfkxCdMPRbCBITFFmO3Fd8HAZ5YCMq+uderbwQmIzboOcZ94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785890503; c=relaxed/simple;
	bh=l1/gGhpg7NaOhtpaypq4tOj0cPx0maB0mCgj1As0s8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Kk6Ze0gknImZFnHSLKPee0JiLA7GzzI/DeRnZSQU5/AKlTfJ5iOTLPfWCMrxqAjgp7HeabqrFPoTJIe3JUOILisuX/lXOZCc/8Y8XYXD4I/hqXjt2X4Akiw/HZTB7bf8UItA8FGH7O5RuVk/C99d+HfMGWGuG9m2Elu/Y8EqhKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TEliQUlf; arc=fail smtp.client-ip=52.101.193.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TEliQUlf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VeOy8dqB34E/VMKVjIYeKdxx4SteLdWDilNZt/z7v3FTHy6VUVmN3MoCaYeFUPKfos0d1+WtJtEfQde2ma114WvCQnh2qHCUsVOz/UV8maoXTiagHecgOlbgyhK/KunIIQ5oWnocURvj7weo86NM4Wc9s6oi69vmKRd2PGnu0m5LQo0+NMq34VLpwgFObbAmn7jmkQmkFa13yxtOUpTvi1IzqJyVwuwTF6GD0zcf8qQ7l3GGJSPwx1AUKgEGvWYuYLc6agL+Z6nZUTnteFQwvZ7j3zwDepifzp2LM9U+6RuZfD1AkO64yhgSRX2UEKWhncaugW1acdYwtHYWS5Jz1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4p9ft39X0W9GY6Y1TrkUIE1odMdfYUUsClrB15ANBbQ=;
 b=yyZToTyUfMJZBfLNBPFKWnQQ3rGnb+F59ncSZcLi1REDu7T1zYV8n49XmN8dsHe/fbNOLf8MJyTdyyk2vM0JpKUpmEnUF8SFMd6oAzH8lF7pgmdbMRmxgo+wmIQ8JDEZYgjGJAnL9FOe873auM4ieWxb6HBSrvZ5GKXTTYN0ANvlq7wub6xRbv/7TbH72Zr43cN0MpF8pevMrCK8L57h9DGqnCKsFhWJOSQFmGRLJ02B1RCuooicWxTfKGaYcEugbPfh8uRj7E8XfwRyehpJepiRuzTW0g1Xx7ldPg/EQNtEaIipbrbdng4cSjTbsWqX+1M+hWYF34C9BJNUaOhQSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4p9ft39X0W9GY6Y1TrkUIE1odMdfYUUsClrB15ANBbQ=;
 b=TEliQUlfpJDE+1NjqrmXEqLJ5tUGM4Q41gOgUaWB9XajXY/dDI5GoDIgE7QOroabUNn7reAZmcayWyeYu/7yaZb38k+oWypm6ftd0q4cHoEoApyYeHazGyvjTC3/QQhpo9LNqtTcQHmt4hndeb1+iozR/5wvhedlIWJVMVyRNtKtYC87l9swC/q2V9Fy6ccBPnvFpFNdRp0c7wKFqOsuiuGo4XEBwWoccAiiM4hI5Yr/kApo8G9+udsh2Gmxnkuthm0FtwHlEqBHNtfSUX92rRls/EHDKX1Jp7eOv0/v8ng1DynXUDHwyTY543wOVLa0w37mVGedp2icRBPQKprXLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL1PR12MB5969.namprd12.prod.outlook.com (2603:10b6:208:398::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 00:41:39 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0292.015; Wed, 5 Aug 2026
 00:41:39 +0000
Date: Tue, 4 Aug 2026 21:41:37 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Matt Evans <matt@ozlabs.org>
Cc: Pranjal Shrivastava <praan@google.com>,
	Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>, Alex Mastro <amastro@fb.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Kevin Tian <kevin.tian@intel.com>,
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
Subject: Re: [PATCH v5 3/9] vfio/pci: Add a helper to look up PFNs for DMABUFs
Message-ID: <20260805004137.GL27883@nvidia.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-4-matt@ozlabs.org>
 <amvWXNRtviKEuUoV@google.com>
 <ecf9b355-9fe1-440b-9281-08671a995139@ozlabs.org>
 <cfae30ec-18ed-4f06-bf96-ef294a8c2744@ozlabs.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfae30ec-18ed-4f06-bf96-ef294a8c2744@ozlabs.org>
X-ClientProxiedBy: YT4P288CA0037.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL1PR12MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: 0813e551-ee4c-45a3-dd34-08def28a4f5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|11063799006|5023799004|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	reR2ox+v6akyxc9bRloIkfYzeqlKxNQFfBHKmFJ1hkkrqfmiJLs3qapASQ30TK6rNKH0UNgkYZKm9R8A8Kidm4+fOVmewkRQirDwkDx1kTkMYsIGY0meKh2J5ahg/unZQ9PLgIk1bGSByTdoJbhGjkqEhc3+jqVXp0O7Eofi3NzgBL94Uwry1xbCEfxaKuDuFglE3uT1TlVjcxxh+GhKOmlzTkZ8IVXyd7HMLrBMjtQIv9TVj9LpSnBG6YwJZEQuzGvW6TpOd4z7BTdc3xCLX0f/4EnakG1HoD8aalV20nsJ1NhvJQgOeQvBiSDo/Yj5ba8Yb5y1qO2SocKuS90tjX0e1dERlexdJnS+kvkEzO8zdreRdcoXNrCKmvHwbFOFaBk2v2YgrHT3zq2qnDKOYEGbuGLHMxJKRoUyLsWgjTRIlT0Y5IRDWiA4cyRRVfxgmkI4f3Al/irELp/Ofh1+0eQFOXFO2ivl1xGwtCQupVTbu7fE8LVukid2QlveIyHfsWIFmtrYrS7jI/98S+5O0mzAT07uGHXWTZewCkuB+zipH6BwCs/FsOjelxNfW9CiR/8ebOm8PyJ27/NPTyL2PZZ3EMheSeeYDe8DHt5bxW7h4s/BznfKd5pTAYaUSd7ngyI1WRteG5pmupB99bBb6ejrbhreKlZYhSkaFjwK5no=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(5023799004)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5oxzG6eUKTuoc7/7KzyEtliNERPkORr/nT6gQEtPN0kGnKSinrLzg2AeAcm4?=
 =?us-ascii?Q?zqdReVmdP4ZExKZANQwk+zbuZM2qbd3SUk+cX9Fjw0Lqt7iKMsI5jZDYmCcY?=
 =?us-ascii?Q?Az44VObygF6B00hYZCaTFSQXv4EAMk5wnI1Fe6A4kDtaXWNjbp63YOdbkkDE?=
 =?us-ascii?Q?hbn3GgLLS3oRBBInb5KRSqMAmtsYp83ylGhgS9QRsziJ/lBXOGhp5FqvI1Hs?=
 =?us-ascii?Q?Kai3dp6o0wNyZ0xixz3yibkPcbXf7yLvRMvolc4ZY4l8X+Yr2+kt5qMmcu/t?=
 =?us-ascii?Q?wmvJIRSRzZOVjBWSedu0KcK4Brt4k6A3VgCCJSqmq92Gc4mo0eniUwcxwcvg?=
 =?us-ascii?Q?jI/Ij8rRMSIGupHLEBTF17gUrP7Y2ffMCcyccxlxbV9a66DUWjhcMa8NR8iZ?=
 =?us-ascii?Q?zLWNtij52jPGP1BVHHSkpXQFrWBvbaIlnZ/bsSjX5KwxbVLsrq0N9k/Dt7ZD?=
 =?us-ascii?Q?x9ea5OHgvdnTd2HN6z5TB42QNFj3x5hBX8oC1w3gt/y/KLLlrcDwvS2i0xHh?=
 =?us-ascii?Q?Mjvpe9qewOhCNgvXS2NqEY4nIMekzi3wA9uCulN8FP1wXnVx/uyUyZQUyCnj?=
 =?us-ascii?Q?PEyl/CxjKl3MhlLiqSIeX69+sTf3D8CS7KrtUvxG4NJv9e2rnO0DjO7NilRJ?=
 =?us-ascii?Q?T7a1xcgcOKDtqctmWP6Wp5x47ZxSUfq5VcjbTCPJsKUU7uk6/VxQBZDAwO+e?=
 =?us-ascii?Q?tZaNTVuhAQ/hOTanR1QWp4LlvgEywMDBUsv4N1N77rxsxX4Tw98BT2BfPVdf?=
 =?us-ascii?Q?LhccCOBEQpEM/PPP2SArefg3GX28dgu9arebTxDGD8EigNaZppI4AEzCkoI2?=
 =?us-ascii?Q?Dg1rDx1O8E5Epjdca2BIROzgrkeYmCBhHX9ntVfqzkfOmjFiUwCRfyflbY0J?=
 =?us-ascii?Q?eTS1gztNNp78qHKo/+K6mh1YLlPOB64Wos72ntwXr34g7kSURiSvDyJfXWjM?=
 =?us-ascii?Q?Sdi0gWTxDD+BKj3uwk6/hX2NGYMHdU2WUp1/v9TYbRTpX54MyKt64SlhC4qu?=
 =?us-ascii?Q?/1ORD28HNlty7lXHijy1CHCr5Lhn5VER9FOPXKpWB7gSLg+MQBTQrhT+Cg2e?=
 =?us-ascii?Q?Yzs9rn12Oj/taSbBXpFf+NLQVvTEAWm1fMtE/LdmnTontdNWtQcjt0G24d7N?=
 =?us-ascii?Q?pLDtdz9KNvBt75X+CZ+iRV2yJn0TQ48UOrRoUke5Iw7olGt1fAbtkhVBcWke?=
 =?us-ascii?Q?aLPCadepErFKoGPIVpNtyCWdzooO14pV+ywLJF3BiYiYhhxwT0zpUCYeOqWw?=
 =?us-ascii?Q?9oUrcacHEHD9lKQ7ttTj5oi/fflisigRmtP1OQYp19GyquQeB35K8Pcb5KT2?=
 =?us-ascii?Q?qIQSHLNMS7K74u1WvwP+EAX5r79OxutYviw9MTk1pCP+v+juO1Nbf7n7uOPs?=
 =?us-ascii?Q?qEN4xUs1LY5AVAgb3/rrBS6XMrSmX5Ofxkz5Ezy3FUwso5xcpkqZAqhz4lr6?=
 =?us-ascii?Q?LusUnkZEW8dtxBEd/vMqXWZZuDPM2Ab1HSSZnvtQtbqutoCNwWQ9qbvYAlRD?=
 =?us-ascii?Q?gJKwbuIolYeiYEO7xEQuDqr5cPHDQ6JHYP2bR5aaljZEdYhiChlVNR+wUeOP?=
 =?us-ascii?Q?AVslKYAq9uNpY1GGKy6pVZLRKW9sRyoSct9DnSTWF+XnoTvt6uzYmVnj61uE?=
 =?us-ascii?Q?OiyxulWtYJ8U1TWU2E4bGK7KLtUyXa4sbWqrDAPLq3Q5uIEGGk2nPzl5/d6p?=
 =?us-ascii?Q?e9cJJ3F9rfdI3YN6VNnRuyQm8VElIFYS4DHycfTx2iH6zJHY1CQzb74EaAe9?=
 =?us-ascii?Q?h7/hBv+ehQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0813e551-ee4c-45a3-dd34-08def28a4f5f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 00:41:38.6052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 60sgLsxIJKcdUm9hFCgb95qWbN64mdhekXBcZfZiyQBJwjzRpaSvkSgvn3llr19F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5969

On Mon, Aug 03, 2026 at 07:22:06PM +0100, Matt Evans wrote:
> The second problem is this isn't just a limitation to not do an mmap()
> with offset approaching 1TB, because you could run into trouble just
> mapping, say, a 2TB BAR and then splitting it by unmapping a hole in the
> middle:  the second VMA now has a huge offset.
> 
> It seems a proper fix is easy though:
> 
>  unsigned long vma_off = (vma->vm_pgoff - priv->vma_pgoff_adjust) <<
> 	 		  PAGE_SHIFT;  /* No masking! */
> 
> Then in vfio_pci_core_mmap_prep_dmabuf(),
> 
>  priv->vma_pgoff_adjust = vma->vm_pgoff;
> 
> I.e., if vma_pgoff_adjust just includes the region index up high, it
> cancels out the (same) index in the vm_pgoff.  Thus regular mmap should
> work (up to the 1TB offset), and DMABUF VMAs can have arbitrarily large
> offsets.

This is what I was expecting when I pointed at this stuff in the first
place :)

Jason
