Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010000.outbound.protection.outlook.com [52.101.201.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299743D810C;
	Thu, 21 May 2026 13:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371061; cv=fail; b=IqoA98GbAaMcM637t0sKyYC/gMNuxuL4IMLfFrKP23lQeOQzOghx0auPNtDB7VnulKrh34RzSeIPqcckR4lX/Z/JGx8mbcnu53KAtP7t3kZoqRZRls5AveEvI+mJqZunlBIJdz9HV5WC9BqDYe8S9hpgAaRHKbK+96WLhqwt0N4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371061; c=relaxed/simple;
	bh=R8GyqL6jI2/9YSgmmKIK3V+IfXOKNny8Pd3AkQFmDfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iOwEDcwkCTTK7mICHjjKVKrnaQ3/I9WzxgFkweZ2VRe6vnCu46cB+pZKnBuw+BTWG+/hOCc0CdmP+fzVbLpqEOv3q4aNOMNW0fzSR32PJKOhjpPyliBTLPaxyhRT6l+SGSUPmhIIPUjZ7bQvPAvHjb9/Fukv9GitKUYvJgfjx3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uOTiGsd9; arc=fail smtp.client-ip=52.101.201.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uOTiGsd9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHYmRJPaZIk62Iwc+9stwrrU1ZhYABC+zHqjr8kS1LQwaPgcddH334HQGEDDHFZ51qqHmFlhjGoVCx2zCzZP5EkP60gU8vfCLcH/AAJzJIMlE9q7Vc4o2BsaVvsLov5I45TWNUCP6l/kG6KEEN3Ill0mo3cZCR2p2hq9DDkYiKLC2zR1jwxHhkUpl1+iJHYU1fspg3146qUfhsQ0tvWzPriNl52xZw1kxnLIuUK42FyIsKwGgIC5w4WBsbVcvzPqecAI9AYzVddcbpO9d7KlypPfxFrihIJH3aDgm9v3xB6KyDnfrR2jHlj5QL41UAMbsrhqFXmB0gAx+IBjNGykAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8Fa5f40kITuSEbGVJ1r+/ITpMWCupP24sZx+4tXY10=;
 b=QWKed5xFGOl2Y0o99/1sVN0mDYmTow6prI6EGMHwycwoamW/0a/o9yZrd4fdZw8a4XDe5E10Ev3E4N+FrN4iFzZATvQJQ5nTbnVsxNYJBywAHy28AVsEjqPyCsvErIsBNtt7Gqoh64WxeXGSpVgNSADAakDlz8Ifj1kCEx0RyXqXSUdax/48QNwlnHT4pwFsfl+HwTBs1mn5GSYZ277D1awkUfj4dtm8ei4IMPU/o3kiNor0vZutvjtEaN8dVF4NSwORu3VeJDxshxro3lLRA3VaOIKuAnrXPDITuCUzo+4MUNqVyjr4f8KS8a/aojyhGY5Bs+49G2iW8V+7k/wI3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8Fa5f40kITuSEbGVJ1r+/ITpMWCupP24sZx+4tXY10=;
 b=uOTiGsd9bOGY2l9vJtjqHZpME/bsSFF7zZZCdBaH26NZbbNwVzprnYJC0Dcr1GEeCYq9CB1fny4xao+7XOIttmjX0S4XwD3XGjxnoJwgHpXZg6KVW4q2ngGjlsUwmdaP+5xyx9H+3b30uQ6zkZSZmo/sJ2wDS0jbePtglpZGncNwstWN2VdfA7WwmZ90+0SyvYPMZ8TqDxl2YNVgg53Mr+p0ENobgJA18Zo1meQ+2JoeNwbaeZlpuxXpkRQWbK9Swd4HvG88v55sxvn7IWhrUQsmhkXCkp/cIJDckXJtiQghUnUAaW+VC/j5EL4knaT+BxCeFdnJ6pRhyGn9izLEBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 13:44:11 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 13:44:11 +0000
Date: Thu, 21 May 2026 10:44:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, joro@8bytes.org, bhelgaas@google.com,
	robin.murphy@arm.com, praan@google.com, baolu.lu@linux.intel.com,
	kevin.tian@intel.com, miko.lenczewski@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	dan.j.williams@intel.com, jonathan.cameron@huawei.com,
	vsethi@nvidia.com, linux-cxl@vger.kernel.org, nirmoyd@nvidia.com
Subject: Re: [PATCH v5 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Message-ID: <20260521134409.GG3602937@nvidia.com>
References: <cover.1779304390.git.nicolinc@nvidia.com>
 <b6d2f24356621c504e47633d9e96a7274c2859f3.1779304390.git.nicolinc@nvidia.com>
 <ag43NP4UiS7Z9T6q@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag43NP4UiS7Z9T6q@Asurada-Nvidia>
X-ClientProxiedBy: BN9PR03CA0775.namprd03.prod.outlook.com
 (2603:10b6:408:13a::30) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d13a84e-a6b6-4e00-e06c-08deb73f09cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|56012099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	FjkQ1yw3nllFgl2xKtKJM4LCq9w8L4rz9tbtTuLhePoABF1hIImBMsGZUORuxwcDo+UQgMVBdb8GJgu+x0qMYYorSEGffC6JZ5qal/lKWU6V9uQyRSwkrD9xffaBqHCKhKPmbFsLjKicSsttv/6J+s5KrVoLK3IfjMebxgBL9P3K+xmb+a6/Qia3XAzTMuFNMHtjBkTTUMYAakqgxaPXf+hpruMEGa+srA1Uk7qYETmrBzvBzz+fjfWGJbCIJrd+ihzfZ/l1yiZA2rSk56YB8wVy0XVQIOKNo6imv3GccGVdP0qC2g3AgLk5yXSsnXn44APs7rur3tT50IR5h6VRyzuHtMvFE8OzO9EWpgYe9ryA+3v0QGdq1Hcb2ETjOXMfAY/YT0xsL0nhKYt+UOvfJOHCnKZ+ME1DJ1ZJ+eLkEUOoqzEvFgyQaVkhWf+gV0FqHpinoIdvSBh5/2oGc8YAsFpWeyiLkxES5ZTN3FKRGQrIvcbJr3+5zS2r3ZMyCNKy3EwUmD4YP9gFdEJiCHGWsZmhC1C9Yd9+mfhHkTukqYrrrb/5fzV9wK6NvAW/3ufHyuCgsQRaXLJr/lFKWidR4MZqeIQstgyMCoHUJaCb0aLX4AA5C4INFC/77K8PLADHguUbIRRDz6l77gA+JdDwgVZnePugQpniKLjrVQ+tqbUkYNVphY7gvDJx6p5Uunr6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/TKIQihKz8r23lQP2WSz4pmks4g/sWBhWej55/BmwLkeoLTVAdorzdPBAUnc?=
 =?us-ascii?Q?LVkBJuNH/1mDamYIAMNRQsM6qzBHPiUBbcg5eObqBPZ+BEGR9fFyjt9aZE7x?=
 =?us-ascii?Q?oTULmet7PEJRhZbZJJx+CD51ePPvROuPPWNHl/dSitufDL6AyU8PNuhRoSUw?=
 =?us-ascii?Q?U/XDxx/Ml00Esfd/8B1QWGKzi1TJpC98pOtldt3+16qGk5gQc04PrUWmgp13?=
 =?us-ascii?Q?nXR8YTAGn79pGhor8capfDKlLXXzmmo+QOJMmVfwP2pB5HuorGVROenc46qS?=
 =?us-ascii?Q?VflcEi6MNqo69Lk0vlfOswI87l7VEbli26DwgmETddw0ShR+z87ZGC1rwrg9?=
 =?us-ascii?Q?nPDfWU9Yr2GrysldtCGK8+GcVOdNYWLUpA0na2y1qZwQS0mkozOCiScZHFP8?=
 =?us-ascii?Q?U474ttaWn/Vrp0J9HrVEj1vqVS4k32lQtO7BkjlHZac9aoSE3mgewnlc1Wpw?=
 =?us-ascii?Q?mag8v5jqN5ADTr0JIy8ls99UMXCUP4AXRNsTQYqxMa8hax7dpYU71WCz0jId?=
 =?us-ascii?Q?U+OqMIQEaCtveg1KZpJIwfMKPow1kXOQMkFfdMGSusK6um1F3mWpDwxKEZ1M?=
 =?us-ascii?Q?plAXeC07+HWO3nC8zFTVrBhOXf8nzObwU1uY1zpavnxkC3ZGrWnjGefVGFaK?=
 =?us-ascii?Q?fvO8vZLTKmkGdg4/5aCqQonia5LprOucIW8VCy644nG/I8M2LpkyRRN25x+J?=
 =?us-ascii?Q?wneUDh5dp6uEygAOxj2VCZcQJ0aLnrgFfDL2E2r+ZazBu4f/R0bDVnjiZagU?=
 =?us-ascii?Q?YttBKryUh2xdKH6cjN2t0LxXwDPlBprcAD/sjmpWH2z9fFbUKdn9Bqv07Y38?=
 =?us-ascii?Q?+cT08OyoSjY2QKsloG/Zxie3ERDA/QUobdVxvUPMfRIWSqI9OUdRFLKw2XJJ?=
 =?us-ascii?Q?YbT4Bkx6qMrcO4QFKnO/CTOWDBMKe+AStYfO9x7NaOngAv0vTKyPizmYoL9h?=
 =?us-ascii?Q?emRxWYblqxVjavCsE0qD1J5Abnm6DxP4TvOVzOkzZtsXJmD/kROkxAl/b1eb?=
 =?us-ascii?Q?cPin55f/+bpKpYbGYpKeCWJU0+rgZcZwEbg4H+1Kdj8a8P/cr1JhuM6JpvTC?=
 =?us-ascii?Q?g2ex05fjKcHvCLBs2f55zFWx95xXYllwl4acBpQLYznMm0sQbdOtsJQH1yJX?=
 =?us-ascii?Q?irPTUnQYVOZ7tOEhMkEASPtb8+XPHoKTOmXZ9lKTSbWO9a6dnrdhii2zf+6L?=
 =?us-ascii?Q?5brPRYn90PMn2b4Oat/a78lUCai4C2xSRExoEKVHt+Pxe5zj+GyuvgLjWbpk?=
 =?us-ascii?Q?2ZZuacTuqz9/hoJhVq3wDnnwuugVfM56gWKACK4H1A7EzaujWLcVeSGobHVn?=
 =?us-ascii?Q?l75ZXG9n70xq7O7R//Ahr8ydp+XZxRGQuE6/1KmocGKF7EUpiQuyVF14HciR?=
 =?us-ascii?Q?lqirkiLR8PxyqZTfZqFnms3XH4WKdVa9MITsgnV6TKkcEfcKVqv8+LOdV1J9?=
 =?us-ascii?Q?tXA4TkaEsSkmRclQY5taCOa6OAqkqLmfBCCI1SBkvilHoKmULcnzRRgngwKb?=
 =?us-ascii?Q?co10vqF21lyPHadAkuSt1ti8KXyaBKRcgMdfeByeqkLlkiOeayC009KpN1Tb?=
 =?us-ascii?Q?9fPakepCQ/3ghrF9UhmCEgi9SR58dLRxvpCjo2WM1s8njMVzBaZb8fA63IlS?=
 =?us-ascii?Q?sq5C5D/b8rwW4JvOxxExs71vk9CjvyQiHTFmyF5SlKybF3UVwe0Q6Hfa3Kls?=
 =?us-ascii?Q?JNcMIY7bLZ1uhxyTR1nzkSyNtVfLJZay0gEspID5qpTTa8IZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d13a84e-a6b6-4e00-e06c-08deb73f09cc
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 13:44:11.0598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WN2cuEpLCbji/p3aHkkH8HriZHGSPCuc7m3p8msJPsbFJuGCta+fSfte6S8Uw+E6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354

On Wed, May 20, 2026 at 03:35:32PM -0700, Nicolin Chen wrote:
> @ -3870,13 +3870,15 @@ static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
>          * When the last user of the CD table goes away downgrade the STE back
>          * to a non-cd_table one, by re-attaching its sid_domain.
>          */
> -       if (!master->ats_always_on &&
> -           !arm_smmu_ssids_in_use(&master->cd_table)) {
> +       if (!arm_smmu_ssids_in_use(&master->cd_table)) {
>                 struct iommu_domain *sid_domain =
>                         iommu_driver_get_domain_for_dev(master->dev);
> +               bool ats_always_on = master->ats_always_on &&
> +                                    sid_domain->type != IOMMU_DOMAIN_BLOCKED;
> +               bool downgrade = sid_domain->type == IOMMU_DOMAIN_IDENTITY ||
> +                                sid_domain->type == IOMMU_DOMAIN_BLOCKED;
> 
> -               if (sid_domain->type == IOMMU_DOMAIN_IDENTITY ||
> -                   sid_domain->type == IOMMU_DOMAIN_BLOCKED)
> +               if (!ats_always_on && downgrade)
>                         sid_domain->ops->attach_dev(sid_domain, dev,
>                                                     sid_domain);

Only identity should remain with the CD S1DSS STE, BLOCKED should
attach the normal blocking domain still

Jason
