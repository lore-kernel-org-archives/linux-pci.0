Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409323AA1AE;
	Tue,  3 Feb 2026 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770129238; cv=fail; b=gpLX1C3cyzVgoFH/InaAi4LmEq2K4cwcGRtyNCAMlZ/bl8R80Nco4BxN7W0krl1L2SatIgCY6RbaD5WEz+8x+xAUh+1Hb6gjwgeRSebhf8qX8V7QywdN/YCKFOPGuuWrY6lEG5s5wgWPoXkxbuzvA4DjwVUbqcKNv+wOHjIrg78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770129238; c=relaxed/simple;
	bh=HUvntLpiK9QBSucUK0c60+XxerPwowMMwJhc++QpEQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g8GWSuaiG4SYE/4Da80iqk2Gs44IMw0IDUwb+uS+Rbkrt1fAdutvqhZBzSb/6XtwJMhDZ2KjcGc4fw6/EJFt8wtk55LpnN++5featbDOZCtvnIBxLb/toIRfSJsj/3uepog3hj4Ej5w2yZaIEYrNafvaLsjTD+SOql0lSvFWAGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cVAsCpAI; arc=fail smtp.client-ip=52.101.46.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cVAsCpAI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Us0RRVibIkCjrkOQstR9yw5hBxkNy+F9ZH5R/Ep1yU9GjjDzVmIhi7BCB82iIlXzM/ILkYisLMZB0P+wiZYA6yUA/Q7mvUerHO4sWi7dzdDdAltE8bBDrhsG1kGxPoO8kyw4m1rKmbY0pSCjs87U4YTen6Eud4cBbsstX2HAysJF+r64BQT1EbDNDVvARRfWXnZKSBU1poOOSESqvKWsjAnwDvMVdD+9xYiocFrCp7u+eW879zLS3LIHKSDSbtBVBDP0TZwFRr1nGxAuiJmCbAYNaNBqONCJbt7zUul+ZfnT+kRXadY+GqDba98FIHpoavfGq+IOecvz2LObEYIeDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DX8uB0OhR8lrxHTCcqmh2aIrK2vYNI+yqaFWxSs1AyQ=;
 b=V8oa8ysu3rJzky2jccX4nAR7A9rjqWdWo7/pDa8X0y62cOLH5MjFVKp6QWowJ6XQEjrhu6JbHjOeR3E9nHkKx/nXJGIeKnw1nHskToGmSqVUId6JgS2iw6xUnuPw8g1XLiUoX7zw3KGi26RZFShpPKGU00FlJHFfnwvAQ1qfQRL1xfUWtFOhuk7v9PP7AC1+HTwB86gjTFZgIwhATTnpfxDWrAnuXbkHHulb0X5NlVf+TMc8fYNwzZ85YtJPThRDcWNLo1Wl68lMfJHmaxoa+MROp8VrBj7NfFQ1+WRq84suovFEee6e38kzthTuzP3kC1bS2D3nyaoYRy12W/RzaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DX8uB0OhR8lrxHTCcqmh2aIrK2vYNI+yqaFWxSs1AyQ=;
 b=cVAsCpAITEhr1/kDx+yCFAn07LwXo3WX9iG9UQe8g5Ajc2AzaGB44Fm7aRwJ99FU12QCmCxHkqn40foIgDc7ItukA1MiCJW1xPQTdJCFJUrIps1SrM9T9rKYkUt6pqqJhslcIiEIS2OZoUfFrBKFqdf+gy28DNAvq29yd0DBjXpwrJuIlspRL1wV8jSYdi4z8ryvr0iH7gZhPTWZLTWJynThRP1UMSJOEjRacHwEfYh0gbEk4o2qImKsbzNvfrD3Ls09+s4298Eq5bStxCBg4BKKugvpiJ8teOSVCENXjYAsy6qwjs21nnMGWH1GdcEQxwJv9VOXyBXIEpGgXbjfDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7780.namprd12.prod.outlook.com (2603:10b6:8:152::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 14:33:49 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 14:33:49 +0000
Date: Tue, 3 Feb 2026 10:33:48 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: dan.j.williams@intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	"will@kernel.org" <will@kernel.org>,
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
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH RFCv1 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <20260203143348.GA3931454@nvidia.com>
References: <20260121100307.00004e60@huawei.com>
 <20260121130315.GE1134360@nvidia.com>
 <6971b9406d069_1d33100df@dwillia2-mobl4.notmuch>
 <20260122131432.GJ1134360@nvidia.com>
 <69727e7ded712_3095100ab@dwillia2-mobl4.notmuch>
 <BN9PR11MB527649A0049CA195E7BCF9218C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20260127150440.GF1134360@nvidia.com>
 <69795d0366a9_1d33100d3@dwillia2-mobl4.notmuch>
 <20260128130520.GV1134360@nvidia.com>
 <aYGEDv86r4a6l2Dv@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYGEDv86r4a6l2Dv@Asurada-Nvidia>
X-ClientProxiedBy: BLAP220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::24) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eeeabc9-b6ba-4ac4-3469-08de63313ea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0ZIOWPr6Ogki/ex2qnL2fX3GDtgPFxWPYs8RwMsMEMPxHSoXN4eyZie8uFcD?=
 =?us-ascii?Q?x20iVd9Ap7Cj6kegPKsYcrDc/7usOJvIRz7gBl2lZ4BDJwszO2dNHXFyUNNa?=
 =?us-ascii?Q?rBN37b2X93ziwX/U20MQVROvMNJVxi+3MQAXQ+bb5+h0gYocJX0cyGzndNxp?=
 =?us-ascii?Q?osxOnmAVoL4nUQaUaUyO72MiC0SKu0PDW0VBg/AaW2g4j1/7BcwHkaDzu9ZQ?=
 =?us-ascii?Q?9q7tQiFXpMOzduav6evqLwCbMJZYl26A/zzpW7XfbI0CDxNy8dl6eqZvtUBH?=
 =?us-ascii?Q?U+U5v4K55f96CUpdJ0kZxeh4VqXAoMedSyVWe5YcE9qGSV+EDPBGaw3luoto?=
 =?us-ascii?Q?I7sRL1UgBS1dHnhdRJB9O0kwpLqq4PxnLScClXzhoOGNOD4Gahama1/DGX07?=
 =?us-ascii?Q?zUrJYJbbIJz6kLR0B4oAqaDGRrv7QQXI16SHjdfNJ1/XSh+5hkVwTDOS/vF4?=
 =?us-ascii?Q?zKYMjuVNlxXyGg9l0qRB+mtfyMqfAQy0O871RMOQjE2YF/CalLE9ENNsTS13?=
 =?us-ascii?Q?NYQTor0JDsqjwrVH0UmSXsEKcGOg58vaiYJvhK/WgLzE49rH+1hdnWmEfHkx?=
 =?us-ascii?Q?FPQ4Tuuz/FVt4hIfocPQPvhF/V+dGVqeTaweyDJouSshuSJbJOFSPN2Ex1L2?=
 =?us-ascii?Q?hjaMqsr+Hmi6ecVrjTfyTAxJZmifASAWlUWETBaflpG5wOr2Uv90BEhUj9p3?=
 =?us-ascii?Q?HF0KQFxn5r02l3xK5lvRAkDqsfz5MX6qO85qiivTNd0z0Rs4UuPjvZV9T5uJ?=
 =?us-ascii?Q?CwdtPTj0ieyDuEJMhcRr356Yq9NuuyFNUn3Z8cpCEnryNQRhW8MrxRGvHyfA?=
 =?us-ascii?Q?LI9ehtr1HPVVPz3SpHYBOtyQ0od+yi5YHvsIJlebJnF2n97vs0FN/fgtVo7S?=
 =?us-ascii?Q?3ZcqUn3hPNOod+MyjgI67HfAUjmPARqI9CPyyLc/Iv4OPUJ+PMo7eQojJJi+?=
 =?us-ascii?Q?HRhSZqrpcbPyXEvS/SwsMDOH0qFlblxS8m2nKw+4/gvZQpRPxQUy0KxuVGOJ?=
 =?us-ascii?Q?ps+FpNTpvERAKxM0XWAGIPr714fSmL0d+rBzBj70Xxd9L3YUenMqhK5cUXOT?=
 =?us-ascii?Q?2x38/0z3qxA1vGgqcHCamnEyIVDd/F+jdw+mllDRSy6smfBagqDzfITOeJeQ?=
 =?us-ascii?Q?tIryBtvtdwJ2tAx3k9McCVbMuhbtYVUOGkR6rb6SNQaJxZf7MMNGx8K0oMuk?=
 =?us-ascii?Q?bgHPbcw4uhf8or1pMVbiO6qsaHtg8cPeT3CJXYZslPUlqWfFiwdOfT3/ug2s?=
 =?us-ascii?Q?mizI071+VlIKjeQaS5McHPEIdUEp1NgHrA18MXSg6h73Ck4wC42vBK5G+GCQ?=
 =?us-ascii?Q?sUz/f0VmpiEa+xivrLLE/wUO/qHX2lqy9Bmy4Sx2x9+HjYi29K1Iuz6Dn74c?=
 =?us-ascii?Q?9UbofiF0OF7jAmoKetYq6Rjqlo57iO/RCYed9IqlF14mEzPhJi2qggq9dAmv?=
 =?us-ascii?Q?rq2hbwyTMvjlqW6u5sSFhqq996aCYJ0Ljc56ZYFj9WA5rzMSQjgyjNsxS7Wr?=
 =?us-ascii?Q?uLThssmQKwENKUwKdkqrcV24stwU7smcXmc7h8sZzS0d8CTgW21mfE+s4L9X?=
 =?us-ascii?Q?2jz+vBmaXzDEK/xWJcM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ff5QlxBCs8ldZ59u1SA4g2Y4YV5uu7dmJzf7/RVh1rUE1rCGpXjn48R7g3rW?=
 =?us-ascii?Q?1u32MV08eZffHi5c1PTp7t1n+khD8Idi0nRsMQdQ3JJZTox1s2SNysEmkUMg?=
 =?us-ascii?Q?dqD8s4bSv8OalP5Ztos0qkiSLQj/FHHV1ZUmwglfVDNm8PS29qdtzBO1nFQ5?=
 =?us-ascii?Q?bAziDV7+SzoJMoUqJf5YdpSoLQMg0bHMoudaCNBwhjHzzwMZKWZWcEw/etwc?=
 =?us-ascii?Q?9v8Rqm3Qz73OqzyvY8+sX4iOkyOT+W7HABn8UneDzvHAprBk34mmfP1nJAs+?=
 =?us-ascii?Q?WC8/N9xfaNt7raitd+9Sln4ZSWjhiMyb+y2SrXLNucMp4o35Pe58VAjr6Wqv?=
 =?us-ascii?Q?kHEyBRkgC7dNN41RKW8zVMNp+QeqhZ5NohGVPNBfPXkoVy5R+y7pNVfWl0/C?=
 =?us-ascii?Q?K9VWr2QZR+liDc+/4waap/GxM42bhpdgdZN8MCxRmhC95Rk8GHbiiA+cv1Jz?=
 =?us-ascii?Q?mgkK9dmDe/iHnIoAt4viTmh/V2B34dZlCrpP3Q+6zqyFGe1zKOJtlnEQNXgG?=
 =?us-ascii?Q?CGnWEzfqrQWxj5PbZqKfZPTmFJ/gLdexa+VKx3iAGWdA5indYuzYOZSSJmRf?=
 =?us-ascii?Q?5suePRXlAls2vcarD4CXnukGSoHIIydUWispO7hSpauCWE6eemibm+Awl2Va?=
 =?us-ascii?Q?Gzt+fyd0UlvR6c09/loCicKt6r4vHZ+bJ475N6j7IbrY6xEh2pE5GPhU0GVY?=
 =?us-ascii?Q?MaFoVgVBCPowXgD3eykzspN/uxy5TiOamGYPfSBNDjV89UQptctYy7E/SwU6?=
 =?us-ascii?Q?OZ8Z2EbFzjJcjjBpIGWD87Iy99DOywpjxVAJIBuVbKpQNWZGzzGNgMxFDFGK?=
 =?us-ascii?Q?IlbbIRnMQleLgbwc9oQiRAjaxU3j8kw4b6DBgIRel7BOKnxZAYYAw7HU9lBP?=
 =?us-ascii?Q?d+uVSKiTvZxDuGSfcgh5bBzROKZK3ZZb9YWkWvVO/xEa8HSe/at2/sJvE/FW?=
 =?us-ascii?Q?WlYozQ5vrIgwhpeVhV7H4UoqgvG8Aqhmx5rZf3KuZy+sNtLmqZ4bnpFvbgsD?=
 =?us-ascii?Q?ln23UcAoSnb95q5E9e/88RsO6zsbMhnAZaq850pm5l6RC6/qL3ghwGbnhgiN?=
 =?us-ascii?Q?6QqgkvlZ9Pjt9L22h+r0AB1oopqnRhg1LihVPSRHCpEFVAetOG2OjN78WeWU?=
 =?us-ascii?Q?C6lln9Du0mCl6i9qqqq5qX/gP2gbqQg98Ej6oXPX/sweIqQ86iQ1SWLd2VsY?=
 =?us-ascii?Q?hnfuG/nbvUtGlhGhe1v87KxbHsGmTOn/z3pkurXo2eD8QhMNcbVdsccd2ZCG?=
 =?us-ascii?Q?q21Gra0F/hp2libiOSGyafwwGYCVveNlFSiWu496Fy6K3P3noto1j9qIZMSE?=
 =?us-ascii?Q?9UD/im0JwomODHq8fhPdzxx3wPuUBv/8xvjzZ+u+K2jupQPPTCaaU2ncNnWH?=
 =?us-ascii?Q?O+lhffgPEGN66MwSh/Sg/IWqO8em2albYMnByAWA0eY/1435Q6RnMI5DJk1g?=
 =?us-ascii?Q?1wRSImQzNQYyxQMqAKfL5wT3lAwL0pDlCiRdvOwCkhE4G3R2Upsd49rsS3GM?=
 =?us-ascii?Q?EYf6CB5gOBGaUpV1k7/MAHyaPHnUvPLgrjrKLMYFyv84dnITzrcB7j3h8/2P?=
 =?us-ascii?Q?3LJrNJ+5450bHUQVZdAHVolaf/bYIusNMUPavDadoVN6uNONYjDTm0LnF/Xr?=
 =?us-ascii?Q?U3cO9rw9Jx+bjhluKFETTXCvy/OPAiqays41JLRezFwv1djzJkUbsL+SnT+u?=
 =?us-ascii?Q?w+Smu9HsuvVFOzGziN+yhmzZUwdxqUjkIqH7QnWXLUWUtwtH5a1tJxcxomqW?=
 =?us-ascii?Q?niueL6FYGQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eeeabc9-b6ba-4ac4-3469-08de63313ea0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 14:33:49.0756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZT4HZTdYGStjloUWA+B6DUdCcirsLyyxiJ18lPGbNy5exXvLy0+OSL+gMQ6mHXLm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7780

On Mon, Feb 02, 2026 at 09:13:50PM -0800, Nicolin Chen wrote:
> On Wed, Jan 28, 2026 at 09:05:20AM -0400, Jason Gunthorpe wrote:
> > On Tue, Jan 27, 2026 at 04:49:07PM -0800, dan.j.williams@intel.com wrote:
> > > > Yes, ARM took the position that ATS should be left disabled for
> > > > IDENTITY both because of SMMU constraints and also because it made
> > > > some sense that you wouldn't want ATS overhead just to get a 1:1
> > > > translation.
> > > 
> > > Does this mean that ARM already today does not enable ATS until driver
> > > attach, or is incremental work needed for that capability?
> > 
> > All of the iommu drivers setup an iommu translation and enable ATS
> > before any driver is bound.
> > 
> > We would need to do more work in the core to leave the translation
> > blocked when there is no driver. I don't think it is that difficult
> 
> Hmm, not sure if we could use group->domain=NULL as "blocked..

Definately not, we need to use a proper blocked domain.

> @@ -437,8 +437,6 @@ static int driver_sysfs_add(struct device *dev)
>  {
>  	int ret;
>  
> -	bus_notify(dev, BUS_NOTIFY_BIND_DRIVER);
> -
>  	ret = sysfs_create_link(&dev->driver->p->kobj, &dev->kobj,
>  				kobject_name(&dev->kobj));
>  	if (ret)
> @@ -638,10 +636,12 @@ static int really_probe(struct device *dev, const struct device_driver *drv)
>  	if (ret)
>  		goto pinctrl_bind_failed;
>  
> +	bus_notify(dev, BUS_NOTIFY_BIND_DRIVER);
> +
>  	if (dev->bus->dma_configure) {
>  		ret = dev->bus->dma_configure(dev);
>  		if (ret)
> -			goto pinctrl_bind_failed;
> +			goto bus_notify_bind_failed;
>  	}

We shouldn't need any of these? The dma_configure callback already
gets into the iommu code to validate the domain and restrict VFIO,
no further callbacks should be needed.

When the iommu driver is probed to the device we can assume no driver
is bound and immediately attach the blocked domain.

Jason
