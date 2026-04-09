Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011045.outbound.protection.outlook.com [52.101.62.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B1528689B;
	Thu,  9 Apr 2026 22:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775775179; cv=fail; b=DmHMkKY3h33+9isaC0ShR3wU/vyHvgsmov1wMlUJvtpKOsmc0gHram3Kq5mF6XQ78z6yUa5n8aZ3s1EUbXMPQ9nqw5g+tZYVFIGV7CxwttSnTBSnkFcFyQpPCZQyL9Kz8HHgYLewRDIN0vVsr+jt1Pqx659egHOumKda3t6Ej6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775775179; c=relaxed/simple;
	bh=isSQ/El+DSBnQ/csRqbO+m26IrCuR01Ck5pu7M7G8SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z/srH1Fu5jM68hcspOZFvGhy8zjS0nqO+zpTNulO5B0IduzEh42gBGulxwzIVTR0M2xoSE02Y2zGtjvDTNOuytcadKGdqvirvtysW/GVG5tzHpyiz9CJyM2pytWUdACCyE0BN2NmSAgof8Xz6O7jVQ7cLXh7Aa7fYrWzEJ1spHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IEGtC7kW; arc=fail smtp.client-ip=52.101.62.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IEGtC7kW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXpSPF1xOCd8fOnLBFGJuBxU0EZnugSwSgiSTqvC39ZhzlDMrXR3gQkL6ZBhhsfF5UfIgE1BZjYeCoetQFojdwdfN7kLaRa8YlXGRLMZ68uXynQqohBECjOp5LxFL94QF7ZDXMwUmHiFlB/6mYJLdOWfjgRcGSFGF+PC/3CoizGD4K9vHqCt8Ij7oMNG//Syw3o7k4PQ8D8McAN7Hs8QpQJbOudQv1QDd0tiLpqyORnCvdh3zcpMp8jtKrszUqhZC15MiQA1wqHL2p/mLs9kiTDMmb0aKjVtIc29aWrxeIQ7aJUeINrR36EZFAGcseQ6RKCwk9ThDGE4MFwmovVHaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isSQ/El+DSBnQ/csRqbO+m26IrCuR01Ck5pu7M7G8SQ=;
 b=f9lWB78J53A7G4S1N1SzXYquibwBk+4Zr1oifYu5bcEJ9EkF4VSndv8sWMbr7J4MOH15JE5D7zELk07UBFQV1eaExjcThaU+QPhjps5Jju9H1yQRFkSbxU45IqatV7PgMXkLC2CIt6lrOihHIuKpBixz7i3CFiDKSELvDL8YOA07HjmaeCL0S0Fr4B2UWRVnp5UqK1JYZPFsOPr7AP0u8/gl9CycOEJeKAebZLtwtIeneF0ayoReeAKjH+NetM89INSqy6MuC9V3ja0l9SHX/vm/CEN0meZK4Eg+MqAM9UCpksn/ut07lHyW+Lg3X9sm7c0a0TxVOXlOllE1rERFZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isSQ/El+DSBnQ/csRqbO+m26IrCuR01Ck5pu7M7G8SQ=;
 b=IEGtC7kWhu11gHQCEW7/Zn7shoNBf+Ah1ve+7gpakvQUM0zAXeK3orhNLO3AmEOcAusaUMVoyYlc8i6B1W/GW7HFkyPi5uQVjPe3bCit9Ng3webMjrkkBR1x9ZMsdrvYmpXLH69Y9j/lXwACJhZztEVfKNQ70kOGM3G3N4cZ3vWiHgUffQPm4673tDbYlpoqjgvedVoUARFR83SuGzrFyMK/l3Q1nqFbBOspnzdUQSgdP7nbh4u4Ls+3vgyUuZirTKEsQarPqHcTh6dZud3YbV5oJw4heKsivb6d17fHl3o87WNONnknTTR4N4RmfOp11Ps0GXRj4AATY7ClwTVKwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW4PR12MB6777.namprd12.prod.outlook.com (2603:10b6:303:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Thu, 9 Apr
 2026 22:52:53 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9791.032; Thu, 9 Apr 2026
 22:52:53 +0000
Date: Thu, 9 Apr 2026 19:52:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
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
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	Vikram Sethi <vsethi@nvidia.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <20260409225252.GU3357077@nvidia.com>
References: <cover.1772833963.git.nicolinc@nvidia.com>
 <a0dd3e4cc5260f55bbec5b3ed6791def33028735.1772833963.git.nicolinc@nvidia.com>
 <BN9PR11MB5276A6B1B103C4B0201458348C53A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <adgsBgXYy68GmxAf@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adgsBgXYy68GmxAf@Asurada-Nvidia>
X-ClientProxiedBy: YT4PR01CA0217.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW4PR12MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: f1fef8bf-3c81-4888-1e4d-08de968abba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QsjIxJxWKVGAnOvLG+4SZpHNOLL0ApmNTEp4C0bB3SYLmoK87fs5ID5yHYV0CXBhon225y5URo5TguUGt0QUJ9/8pyo0Bh6yFXhG4bKNoasRmdSYcV09r/3zcdFYMZmMyeV1P1v+WqdI1HWaW1qEGogdEbp/5sBU8PCtibcpgPiEpX6yZKczxuEkeCvMMgmINaV2r6sI7/fO2PtsiYbKtIoWBVDmJS71M6DS9xJtP6HZJxIl/sSiEXbVpbPi0gcnmxyJetJuV/e3JDkyHDgV78BR/eZy447rkbjPmagWDVSq3jRLVb5gdVzudzgtF+X5RYob9+D1XE8Kei4ctZFEdEB6QYTSHtRz0mzjUoniMw2S1xHGnDAQH5vRtBUljBh7B5dRIbv1PreeRjZFZ1c7ou9myTPGRcuYFoJiaZWac4wLdoZ0uW3iWHV57nI0F7v8XaBo343z8LbWDKKwpDkTeda3t4PgfWEhAMg/v+/NWRmvtslNR4r5noy2q6QHhdjSs3QZvcVHtQaC2cnhdU0N0ZerrN1s/NRCx8VPnCJYxxecn7/QN3duoZ5OAojKLDYJ6U33z0R4dNFZlPLgZjNFqQVjGiyUpNw63WzyX80lf9g12jNBTmPRU0TwgVKx4BwQ4iLmUEFBOrk+eAxcZO6qKRMAvESHtjlwuz5xWt1C4C8pShymBc6K+C1ruLgSs6MrwN1OlfiKOTXBtotk2LI3luTTeHPQHlRWjC1hOd5nLSg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rkCkrUAsWEFvl47TOscPhKvnjiQMFPeP7EcuMqHNslpSHuUEegGYul+6LAQy?=
 =?us-ascii?Q?MZg2Qiaf2W3y4I/OCnVGadi1BvHKZvzuomJJ1l4H27/E61pdWZqA+eXz1iKU?=
 =?us-ascii?Q?8AXc3FMD9PE1/upksnO6rOKp+V2wqLOzQRYIuI73CsAo0rwrvKQ83crnJ/J5?=
 =?us-ascii?Q?3unskTFAnkwDBYAwmcYhUchMJAM++AGnMFnOudR2LKgj8x/KeuJKMMLor9tb?=
 =?us-ascii?Q?GC8IEK4yumiztBNU5M5ORXQa4zS+aIQwXh6DduBmqrXRcysOTxJyJT/c8RLN?=
 =?us-ascii?Q?9DugumMSKiqFhzqXhiP06o6AX1R2PvBtyRrNuFvGjsXAfiIIUStiz29BRMCI?=
 =?us-ascii?Q?2YmFsYYMKLlffTdurrk52XSBFIm82zgJjQCc6G+wTWwDhF3jxwKDpx+M6+no?=
 =?us-ascii?Q?O3PXpGgBv9rywKv33Xb3nVpMNgFA8rcJCwMa0Aj07xDbGXo3C5TCWtRqoC+L?=
 =?us-ascii?Q?gi3b+VwR5jgNDkOLPuIRMUCl+q7a81omPctoXGwhVh/Z/pitsDwHAYbcLE7c?=
 =?us-ascii?Q?sbKlS2uehFWJKAWaR8eQ8rhbnH5iSJ74UkJEZbOysov2XHuOSvBKACSZaMWM?=
 =?us-ascii?Q?bqQqyxiqqCYpeyZMRVe0hAbS8JWlSDhF+aVthBJJhnawNKrfuB5/dZvBTjUg?=
 =?us-ascii?Q?miiJfD0UcFhrg0VZ/8LtBSNSB4PZ0XC6PSJbIYc+jFVAlThCmYDtiGkEydC2?=
 =?us-ascii?Q?EwNDdZqBu+GBHzdfqdmFQl8vSnjAJfBoTmoRIu+aN1j1vvda4pvd1C4n8T6V?=
 =?us-ascii?Q?Jil/TOkLTBXAOYju+W8sUqaOTxQFl/iDDjFB7J+OQN9D4HUYlCgJhHDUG4c1?=
 =?us-ascii?Q?1TS4RsirdbMtobLr/tjWls0+Ix+fCRVayRXdmELFNWYolUsn4706Oi5xL0T2?=
 =?us-ascii?Q?t8EkBmn29WBoYbZGY1MySDKN5kKOt55tduhxrx/SyvU7V6KS3bJziOpkQtVw?=
 =?us-ascii?Q?emVkXZpbTZURvA6ieqlo7JmhIEsNeFTXaqL/6vx44EzScH6RvokBsRK5L6hO?=
 =?us-ascii?Q?3ycRNaZhB4wphFnov+y3ZBeGUsqK6ksvFSWEPdEpPlfB67JU2Kvt/Q28BHAy?=
 =?us-ascii?Q?xHGlYg9TLAj3tqZcinaQkh6wgDy5rd3IL8ONL509vIb7eyKH67ExP6cMFzdY?=
 =?us-ascii?Q?YJyNrfxpzujBionIi05Zf3oGaK7GeQ7v7wO2HaNvGvRAGZlVPR0US/4Z86Kl?=
 =?us-ascii?Q?+yF6sCw3GU5vL+ElRxfrJxouwGFOLj7pcyAoOub4E9AMitRe8ppTAdA5quzt?=
 =?us-ascii?Q?oDr87mMR+ai6dKpWVyou07EDRI0Wexetgb10/ZEzNqor4fv4S9uajJZhzpqQ?=
 =?us-ascii?Q?jiT9CAmoXd+ti+3nd8RtoQQbwNI8n493OIdIjm2IhaBKg1xKD6PkTdQhue0g?=
 =?us-ascii?Q?bfF83O73eTEv1lnBjRq6zCscHEzrksT7w5CKGdDO61BvouRfNpHYNz7UKOys?=
 =?us-ascii?Q?H2twOmJFpk0qnYUln+Z6hben5HnVo0JVhczg1/Mks2FoeXbLhigXP+KAXY0q?=
 =?us-ascii?Q?mrAHuAldne+9cXmathbz5VrvEe1eT5DvdonIkAyWa/ofy97A8cfAphOauCsU?=
 =?us-ascii?Q?HD2PrWLfYwa8WfDD2pLFQCVxg9hHlJhiiMBEa2CPv4/APn9lYXqktA1+U6gq?=
 =?us-ascii?Q?PFEGkvPf0TMm9Cne5tbNtCYlX3j9NuaDFwtPghINh5qys2TDrlMsSZNyCxhm?=
 =?us-ascii?Q?jTrVZMSccwtK6j/YyWNJOFUc3vcC3Z8vbYl0lS/kmI1vpRhB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1fef8bf-3c81-4888-1e4d-08de968abba7
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 22:52:53.3178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPHleZuFrR+M3KyW3kBqlqcGuEoOs75euA1W7Qw3Zza5wmSwGi8kipZVbu986oUK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6777

On Thu, Apr 09, 2026 at 03:45:26PM -0700, Nicolin Chen wrote:

> One question regarding VM case: if a device is ats_always_on, while
> VM somehow doesn't set nested_domain->enable_ats. Should the kernel
> at least spit a warning, given that it would surely fail the device?

No, just let break, the resulting failure has to be contained to the
VM or the platform is broken..

The HV can't turn on ATS because we it can't know what invalidations
to push so not much other choice.

Jason
