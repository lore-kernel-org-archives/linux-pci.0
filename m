Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012070.outbound.protection.outlook.com [52.101.48.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D7F388E40;
	Fri, 10 Apr 2026 12:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775822716; cv=fail; b=uTCtsgp/jMh4hpXdeZdkyP/0ZuyJLq2T1n0wKAN5ndBEwQbq7qEtnBe1Gdgl3L74Sc/hZTl6vrhDQquQgYdv5+0qhOhPAFGam9nEzfn5rsUeCPSCoDnATA6QXccyG6ARNTgFVQXR+kM/v3uxkWeKBk+nmEztvgaeBy06xf3YSk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775822716; c=relaxed/simple;
	bh=wxdgXtI5ULUaPPZWficCC7vcWYa5991qmRcsFqNetvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J8nb0AM0irCWrRB0U+o8n3piKW1L02YlgN3hrfwKzlfB9j1CIM3H/O7lrAf6hwj5230ffgazphwZ5Pm86DbzqL6YID5Ze8CdJDvUI2z4vhTktkCwJ+SV8OnX6vjFE+hFsACLIE9sYOnJpCLzumpnDYuxQZPXqSENNPGhDADmdNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iCYq12jq; arc=fail smtp.client-ip=52.101.48.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iCYq12jq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4Ce366s8UhnXkLmN3dolgd8+t3XCPcp2Nb4/t9Cm5Dl3NCrYM7wMoRXTRdYakkrcICmJplMmJuFSw0vX2Mw3R1Obk/VVtCvPGkcrPUUx7hqL1hvdoNAXRydBuuyRp4paRAwJSBkWFO6mAke9qQgQELDXdqhcebcMUZO8W8DyroE4fNN1rT6aIz0h7yM/0kFnaO+68HLEU03MOZjYKkdV+kEfoASzwsDN3BDOG1KMry+y03ixUZv0fsXoiaGzqVMpEz5Qn9ZFPrzBCFhOPk/yw5jBOeT9MwsG/QlO/XEs/+dmrwT4SD51jL3tYI/9Pjc1+/xkeRHjm3zilVatErlpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DVWrltULqSjWgzEyse8zg3HmE3jP8nXnImlo8bGpHE=;
 b=XvlXY0xZhE1rzTJB7mvUYiOqvw8EBneZGIAchap/ATNGF0M1hrK5UaPQAryjupVech6q5gEIrYqbv9qVLYjOFG9WD06A8Qr3COqVr7TE48GmcWouy8xxKVJ+ompCVo5X0OlJc9paMoIkPigYeECJNFVX5upfWkTd7sVvwqp/1pkmMl8pzpO4/FX6IBOC8T9ouiTewKJp8TRy03y3Dp3cM+XiDtNiqZQsEwk1cU1pJa3LZ0wewj0OtcYB+4SYAuluTWXwrlUmdNF4a9d/JlfHovgP3//wkqTyYQYzivqGC3ItgGe+fyCUOtgBGb+tomtzpmJVxmQ7QK+Mle8A9m/eow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DVWrltULqSjWgzEyse8zg3HmE3jP8nXnImlo8bGpHE=;
 b=iCYq12jqi4fAScy/xTf2DdmpAnW7hiyJiyKYdYHLVIE33U8zhs0lFKMBme9t6fkouzO684Mqa8hIkwMSQwxrNVp6dCVX0pVJ4rDkoEpBbqCbfkKA9IaAgrux7sMTulHjtMbCYgSKiX8pSODvShh1kORRTmtJbnt6qzwMHP659YeNWlQZJKgT4laVAbc8ddDmocEPH8CQ+9tLCpOoSK7bS9Wb/w4WPd+EVgl82KAdMjxk9hqXHXZgvokyAo7+sIs8ycXwUS2Ty7bWPPIPmvwUQT5A8DyN3sgC2WD7fV51UaP78AXgs5A/cdsL9rdCUEs5pFcWOfrB8p52kJ6PZS2pkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7874.namprd12.prod.outlook.com (2603:10b6:8:141::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.32; Fri, 10 Apr
 2026 12:05:09 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 12:05:09 +0000
Date: Fri, 10 Apr 2026 09:05:08 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"miko.lenczewski@arm.com" <miko.lenczewski@arm.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	Vikram Sethi <vsethi@nvidia.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <20260410120508.GA2588311@nvidia.com>
References: <cover.1772833963.git.nicolinc@nvidia.com>
 <a0dd3e4cc5260f55bbec5b3ed6791def33028735.1772833963.git.nicolinc@nvidia.com>
 <BN9PR11MB5276A6B1B103C4B0201458348C53A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <adgsBgXYy68GmxAf@Asurada-Nvidia>
 <20260409225252.GU3357077@nvidia.com>
 <BL1PR11MB527184E183703E14F6C861118C592@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR11MB527184E183703E14F6C861118C592@BL1PR11MB5271.namprd11.prod.outlook.com>
X-ClientProxiedBy: IA4P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:558::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: 5860b2a1-3839-4674-0530-08de96f9697c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	WIGardqNCvKwIxTnEqDIXhmgoDQ5FqmNAZpOVMmFAC+otPu0HQEVBtTitSL92V0PfFcW8oP7UOClcrBwVb0Azgpk8IhunPP2/0+JdOBDVOEJiAyMga7/gfByiVRZz4DKpUNu9p08pkbJvZhxxqhZYn7MFoki2QCeBJYU081Ic00xWnbJs2xRiyWCdeShR+qdtQgPNMTjNTKViIW/ixH63YBsQs7sSc1hYOqNvwCqfiUckt3uxVNIcNssbxrAIufIhavpjLaUpYURP9cEtNfgV1SSJHnejRV0VTP4gKt2betAOp2kV4+ZdCMnAblsfHcOAzA7T9wbSAvQI8fEwyDoWTZC7liZuvg6C+qwxH8eauz2HgWDyCht/VqMzFDZB9g/DfpgwFRBnPYAoQ/RAlEM+UtLKoMQwkVBDMSI+DKhLJAfULYPbgPokzcZ+CTnzVxHncPhzscPSzQ0ioNnEbSKiYQt65hz22YZq6bkiMk9YU6yU/kFVZzjQmd++vOiQxxF2FsEPmgvuHXIhNbF6lo1+OjM2QPxyPAJ/WSwCBOY0f2DA1H0nAwot2ritv/wjuInZujkcgvbYi9IQOnKfFOzCiPW4dDhjJlZ9l4ewm++gbX+9eVNpiCbc9sgoeRmiu//ItnuJbJRm8MZQQ+FZm/cUN6LiIqCqMMnr6/XJlS7XWYwF1ISghH5uBmsudZhL2y3RdM3pa8UW+gjdJYVoJkO68YzCNak9/Qakf2dNQgVSAY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q4043A5mk/LKiHfdq/dFP578xVB6qRxFpIzTnnGWkNkMyEfYWMoc7eSdQ9mD?=
 =?us-ascii?Q?/hQfusE1sz3nzUTZCPJVnGz66rGPimrhX9Lq7IBk2XUsGX2jxshUJxFfV/IR?=
 =?us-ascii?Q?sxnfsAMxY4A9hiOYsQkjJWUL0AUSgIxU3Iy3g+nmjlcrX2Mx9JlwEIVBgGb6?=
 =?us-ascii?Q?n2irNRikqod+R/aT4y936Eq5+oOOLjcG3crAtGWuqdOim+2294dLRS7EjphB?=
 =?us-ascii?Q?1t2jsGhy4DniJN0YvsC9Y0sz6W3aJCUCnyTi5BX1p2TQLevqTGoHBudQL32d?=
 =?us-ascii?Q?rd48TluVABr/513g38BeACXhz7jqKHkUADpXhmdVrllzPw2qPbU9yqa8zsVx?=
 =?us-ascii?Q?kMphdnezaG/Epn4k36HMqgDG5yRVES8GyS7oV3/RC6LFv1rt+W44z+cRLn6J?=
 =?us-ascii?Q?sWzraa897dMh63XzhYYhsEbZ1XX7E6H2nhKWgFMg3goCcii8jYEHG1Nve3JL?=
 =?us-ascii?Q?SOZT9joFRkFG8n0rh/fCxc2Ne/kHyOiDsZkfk92WmjgGJbTP46m+hQU68Zw+?=
 =?us-ascii?Q?r+8ZlPP8FwLZRuNNQwOYlHjeAuV7vFVjTapzAyChCgfSW8KBBgNcJ2H4dTaU?=
 =?us-ascii?Q?SD2K4J0FSdDhst/1eLHaYOdMYlJcd8030aG9DMsgsQ2Hk+Zk+3ANNCRAmLuS?=
 =?us-ascii?Q?MpIR1inWbQqIHbO04WwT3NhAQeYBNhnKj/kkU6jN3bBRQXTmaS/fOl5xZrMJ?=
 =?us-ascii?Q?RaIdB7r4pZyAV+hEzm/tGvHM6VFyHp1xZ/ZIVML5rQvBfizqJfmUA2sRU1Z3?=
 =?us-ascii?Q?YiIT+zh2f6dMvFw4PsAMkT1Kss2+Fckclfg3SgL29vMDQY6PwJw4+KkJwmSL?=
 =?us-ascii?Q?rTzipww32YFfvOJzjfMgRTUP6EjCw2uiGRg/awlD7SzIK/DadF0uONYxSgFT?=
 =?us-ascii?Q?CGbMJmrz78DiSibWXwI0DzLqIauhEov/U9oxDWdx57oCat6gih9MR+j01N3+?=
 =?us-ascii?Q?a28L9nkqJGQGMEqC2XX47uCuO0Oy6UTZK0maEF8oNGRAVU951IKV0aKKsfL+?=
 =?us-ascii?Q?EeGS7SS/QVyQIJo/cEYcYoiXrmH7sd0yJzwdaVhAxKtwFXb+l/eVLMzPkM+o?=
 =?us-ascii?Q?vdiZheDfPyhlEvRkecv4CbkJFbzNXk2a7z/5mFXRRowlmzKGLSo3VWTgL8FD?=
 =?us-ascii?Q?YfRq54hBbtcYmtSGRYFZ9mg6Tu9PBqKCNGRKQTCSKMHKbxR2XH43i1j6+nQn?=
 =?us-ascii?Q?muupIefD3IzMuyRhlVpl/LI2k84nKfFkBKUhpxcRDrv5whWqLce7/TxHP3s1?=
 =?us-ascii?Q?i1jX28Ib4laPMURLMLI5ZY8jUgZ3DKYS6n3EuaoqXatNMQGQ05AW92VNVsHs?=
 =?us-ascii?Q?QbAZsK7ei7uylu5QiQzYvlZWuwyvqbbqPF1f7QkYkxMEtcENTd6gHjOLqj5m?=
 =?us-ascii?Q?Bx7p6HPyjw4KBB9lozIrJ9I56CDa0dvV5B/Xf9GM/SBEGk43fYchz7E1GkAv?=
 =?us-ascii?Q?wvgkHnYrwEqtKwq+CoCJY0KZEdmOPpVUONSogEXNtMJEmtlxVJ17IcSqCTXh?=
 =?us-ascii?Q?VMfYfHMXgJMMSkN1LqLVO5eAg1CzHo37/NE5KXKEIoZ7CSnQBUtmAiNhDz9C?=
 =?us-ascii?Q?PhKDLVf5NZrinrw229QdZQtpnfiolxlN3dadwi6F2kSE9B62m6UozwvydOZU?=
 =?us-ascii?Q?poL66XSspf9ca/UVPPWkkDq1LDTv9csE+KUw6vCBXTh+MNlVDO6ElKuCnUBW?=
 =?us-ascii?Q?qxeY590H+xqpUqlmUEpS7aPX3cvc/GRX1EEwEVq9uKWuMnps?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5860b2a1-3839-4674-0530-08de96f9697c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 12:05:09.7319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fAmp+LpUoxGfgtwIPnKMr5rg7rqupDhHSdXveY/t+0G+2o6CKy+pMXIcxvdj7jln
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7874

On Fri, Apr 10, 2026 at 03:13:59AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Friday, April 10, 2026 6:53 AM
> > 
> > On Thu, Apr 09, 2026 at 03:45:26PM -0700, Nicolin Chen wrote:
> > 
> > > One question regarding VM case: if a device is ats_always_on, while
> > > VM somehow doesn't set nested_domain->enable_ats. Should the kernel
> > > at least spit a warning, given that it would surely fail the device?
> > 
> > No, just let break, the resulting failure has to be contained to the
> > VM or the platform is broken..
> > 
> > The HV can't turn on ATS because we it can't know what invalidations
> > to push so not much other choice.
> > 
> 
> Taking about in theory - host can append a devtlb invalidation cmd
> after iotlb invalidation (if vcmdq is not used)?

It can't map an ASID to a BDF without shadowing all the STE and CD
tables which we don't do for nesting.

Jason
