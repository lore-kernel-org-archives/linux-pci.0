Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010070.outbound.protection.outlook.com [52.101.85.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5281D2580F2;
	Thu, 19 Feb 2026 17:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771522906; cv=fail; b=kQpdFj9YK19qEymUDi4I47SQ1UjgEssRt4lfVkMTjPsk1SMKDdw0vZkDcJbZaorEdesG8VggvwFw58DEK34F1mGMB17zmF6JSF3wOArkqqGFRsOvIyXGlkv25SZTQj5jv0YvlC+RSPianUA5f3onTWee/8Dt+rvlvOg2BdrfMx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771522906; c=relaxed/simple;
	bh=/3KhFX/YagTd76v4W0a9apAP5axeKNfn0x+v64kh4Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h1QhO7ZZv9ZbdxK8K657/ky961EE9X9GDfpkG4k73HjnoBeX5nmtRLzCZpVT+ve3KC0xat3Q9hi1p2PRHAFUwPVIPvyzMnb+4NF7sxlsykrDANrub2kdNwYOrK5R9y/ewRbcnJqnTNMiB8ORwWF/nhDbdKY3c0Yrm2Ok6yutZ1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LVKM4UPk; arc=fail smtp.client-ip=52.101.85.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LVKM4UPk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A84k5k7oVbry9tMeeKRcvVxp0dmjuJZsJWsokOoKa4FilLizmQPXyR1OK7+qdPxPf+a4/pyBOm1IlMXDmUGTnkR/c7wcFHNIUNIEJudTMt7+ee+61kK5ChwqTTrbcO9eXfRdiDTZMVTXZM8qfyeHjqwE0qMyK5Na0yBdZwC14KUTRuP1UuLClNxpP0yb00eqkmZ/kFf3yYSuFYdOJN31TG0eOa26LzpV8z8OtcAotvMdoD2l3H7q53jaZV9ZJLcL5n0pDgK9v99lAZ85YuxcLucb8HuBVukd8GiEVnjtarPp0a9+FmQb857UxmzBW/2RwWZgf6MflWTjy8xTd69E3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3KhFX/YagTd76v4W0a9apAP5axeKNfn0x+v64kh4Io=;
 b=JtEE+OvHPWcPab4EJHDvV0psuIti3SOn/pBfF3QEBVe/7DLBol2l0/srTQPgAKMyKXKZvCWTjSzcxeUcHLzH6HSGWiS6SoV93FrQLA1V4Jja4BrnugppHhq7VI4ptVvRoiJ3EXozRV0MmBSblm2+CldjAHL0i8i/D/jx21iZlbQc5gxCB4+FYguzOVMxo1Ia/EWkOUMO8MlYNPjy5t2H5ddJD/ed5otKkZ6GeFhz4SM20WWkQo0OESAiJpLpgNsEHfYvnM4zGw2cphF6k2irukFuwmhjUhn2PiILbU3aEnpGFxUm3b5d4hUvn9qMq1u/4vYU6ucRfjcaj0+F/Z2AOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3KhFX/YagTd76v4W0a9apAP5axeKNfn0x+v64kh4Io=;
 b=LVKM4UPkWXsaW8GFOBlFXSjMweGAhDlnT2r8nX6XIOGme7amKvhwnCHFdMWSJvpT7zGQe6x2CSeuSqIi6bz2eZ359M6ad94yoCzi5UspHoMkSSat+8pAsRl6eTLBgsy1fL2XHq6GG/dFcRS4RuN6+GMoglHTS6EKf0KnT3vj5EOaFMiydxOH7YyCXRGErkpJOmYCjnCT7uTxGWytNvI+zaI7b1LQIOJ5/qlKBaJ9nXQpKRsHtjRb8VmVRgIF2fqfwv+DK6m3zgKDqQSBsTjE7zmYJneSOeNFkuNTY4kMD0Rxn6mT/WbPiJ0bDgPz91u3u9WFoIWttTUmVrUyVzX2eQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB9470.namprd12.prod.outlook.com (2603:10b6:806:459::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 17:41:40 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9632.015; Thu, 19 Feb 2026
 17:41:40 +0000
Date: Thu, 19 Feb 2026 13:41:39 -0400
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
Message-ID: <20260219174139.GI723117@nvidia.com>
References: <20260127150440.GF1134360@nvidia.com>
 <69795d0366a9_1d33100d3@dwillia2-mobl4.notmuch>
 <20260128130520.GV1134360@nvidia.com>
 <aYGEDv86r4a6l2Dv@Asurada-Nvidia>
 <20260203143348.GA3931454@nvidia.com>
 <aYI0LUdXqrjmRcMo@Asurada-Nvidia>
 <20260203175540.GC3931454@nvidia.com>
 <aZZDo3BeuBKh9q24@nvidia.com>
 <20260219143737.GG723117@nvidia.com>
 <aZc//6kvH3Eqfwfe@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZc//6kvH3Eqfwfe@nvidia.com>
X-ClientProxiedBy: BL1P223CA0020.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::25) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB9470:EE_
X-MS-Office365-Filtering-Correlation-Id: 23ef8db3-9100-4098-e87c-08de6fde2382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zIISix7D9BmkZ0PR69yibavysv6SIMx9CfbATkV+4p5MkmJ0IWvHRfIRejd+?=
 =?us-ascii?Q?Pt/w+ZRF0+r0er2wZGrDnRFPuwIY80FmP1NIXMoylT6rXRVMSqAvhjqrag6W?=
 =?us-ascii?Q?Wovo4q8vDa293nh2qSI3fi3RmcOhoG5noUXCUdk2/uxyb8CxUPhCDFDQQ2wy?=
 =?us-ascii?Q?Udopf1BBOnj15PoE23viQ2hG6crLQFQ2xVVImKiECV9EAkaS1fAMuN9RjVRt?=
 =?us-ascii?Q?nUiNd2pbi7zSMYboasP0Yccv7+czu8MdDycHXoPdHcoJgyl1dWkniG7+lHic?=
 =?us-ascii?Q?UDkid5RLnFjFJbAVnKDwiDBRFDMXSBLTd/o6A5KFxTKRtv6MckaymuL5NRbj?=
 =?us-ascii?Q?5lN8L5wnjqZVJNWnD1QNADnEvzDFfNBIclbVusLAOjnvktJs1I2wBhECPXnW?=
 =?us-ascii?Q?q19R2cPj9UVKWS9y3+fM6qb0Zq+sPfoRvrpqmeqsNI9UogMW/E/9sSqKRX8H?=
 =?us-ascii?Q?g0X7u2A17jOTOM8M7qwCBsqiFG6L4nTgLRKA1TcfKR7DP8CopJv3t7yZ89Be?=
 =?us-ascii?Q?g/3VL7Nf7aRJ0flEt0RJmkGxWVsHFVTX4nOOZtfs0aK/RhnZ7zOQIilBAd+U?=
 =?us-ascii?Q?z9PbFrDvr/o+22ofWDmD3ngWvIWHHAtLIT+19tsFuUWdgcGxzDPdaRKapbEX?=
 =?us-ascii?Q?dk39l7hNyVRKnSQJBesz+O0AAsgo0nqIkHEVdfv4xlYIiptEbIMgFUu4mBBX?=
 =?us-ascii?Q?lm1Dmk0I4uxMHS9RvINkrcjlnUmx+pA9m/dKNrQZ1eoozuHQesOaZoUrlXLd?=
 =?us-ascii?Q?b+VkKcX8m7MaaI0PWWRO22l649LmlbIQbJ75MXZdSqA7LLD2pJVnTtzB3x7o?=
 =?us-ascii?Q?y1//76ow+d5b11RssGAA3oeipu5LQ5CokI+WUvvqVtIkRcBrz0Nmq0cmWdLi?=
 =?us-ascii?Q?2sJDDffzQL0LVIkjOEkMFBl3OrAnB5Y2O8UtzYeKmdg3KWdZvf6l5HXKrWMe?=
 =?us-ascii?Q?mW68LyYTyPwauGuaj63CS1hS3cr+i+iVl33sO5v/LkxIDfxRghnqLbQzBwvl?=
 =?us-ascii?Q?J8XWJI3IZX8xiFd2ms+iThmFTFDmsKuiX346rPWkabIOOU2hJMQcWALdmjgC?=
 =?us-ascii?Q?FVk8jSI9uSq9DUFyos04DAnq0qqLlVYzpyZ0HffxWHpracCgkwY//xh2Gkzs?=
 =?us-ascii?Q?BMEm+ZxSD6fhJpzsvbCM95c7YHoUMaBVvK+XINV81vAcBSHs1Wp3rm+l2/n2?=
 =?us-ascii?Q?8fv367RnOc+xxoqufxJA0cU2SQElSwNh54gHQ4rguLoaNCqElcJ5X8zFKAg0?=
 =?us-ascii?Q?H7jcMKRfB8ZXoHq75u1Oa+tUj9HJF0UOcggIpVLzxZrED2FwBWv3TTUkoMwP?=
 =?us-ascii?Q?wF4zx+dF7txGCo2YmJcSNneM6vhm6LIaJUgV/FTm+XT45IcB1qyefc9SU8+a?=
 =?us-ascii?Q?Jn6GurhVVkzSbig/3UcGPpthpEbfCvxO/tZh/GNpVPFaJMMzhd1SCSIw2BIh?=
 =?us-ascii?Q?QJgdWbAmpsz5e/ZINiqShWRobDRfaMi2Ib3z98WhgML4QdY0m+dvmVuXcfA3?=
 =?us-ascii?Q?oiNHXaDcgCKOhuBeXsF5wK24+ZUzrCyWA6gBrvF51FVWQdwyYEon49lw/Qbt?=
 =?us-ascii?Q?rO9zGZudPoVfIKa2sp8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Obes76O15kVFupX2NeOYBXoeT6ZCQkW9wwvvccROsG/1h6LjpIoy1U6mA68s?=
 =?us-ascii?Q?spj+7kv/0XF9i6D1m78FU7pi65K3OXW8Rgb/DH4HBSpDRxm25yV3P7AXYWAs?=
 =?us-ascii?Q?woZoBKTwaJkqiADOhg5Rwo0IzPPgGfnUvjOdg0tjYOVacCxYezkM2OdvRL5i?=
 =?us-ascii?Q?o40CwDSFCyYe1o+oDvw6qM5sNUFn980qGoEBRGgyXc2Wg4ZMQpY/tkiFSnDP?=
 =?us-ascii?Q?PwbilUPG7PS2sxmgIjMJlQmZXvTyHjerVIoFJsFWmuC6V0M2FxzM6P6wz/gV?=
 =?us-ascii?Q?ot3iECDwTiE3W0RokZ31Bq5Tk86ZsGCXV4SOsnVVyEoTydtOqMuZYuqHreIr?=
 =?us-ascii?Q?V3+47sPz1mfgNV2yzvxsIJPOTteaCGAzD327fEBxXIOinx9lECGZuayNOpo9?=
 =?us-ascii?Q?xZExJzDbIpZgTyqAWLwhiq5JRXQeXjahIbHuHDrWXmQn26TELT2PkDBKiMPV?=
 =?us-ascii?Q?dEGJGzIGRDEiwa3pw+EYKx6m+RknFZA1V5xFUlcYbw5meyLQVTwx5eqDpSPI?=
 =?us-ascii?Q?rhg9mYRnRbIf+56ZXD/JuZXLM/qkRzH0MqAkVWWKT6DMb6WNA8SeTxKFKhmn?=
 =?us-ascii?Q?1X3vp5E4JQAiRqc3fjoumouRNc7aHx80xKgy7h5qJMJQC90qANBUEzZ9MHMb?=
 =?us-ascii?Q?P3KfExv/LGz2zx/hOb2sNEgFbaJ10RdlnBEq3V2MoSBFW5e98MNlEmJsdthz?=
 =?us-ascii?Q?0oYEnU0G3pTkBIOpbIcSJJ+Ho1559xsm/ypsT91gG4uw5BI6ZCiaGHU047Q2?=
 =?us-ascii?Q?s4QIffndCaV0Mea51atXbk+1BwGZckSDA8HX5bLDJjAOktB2rLJv9LdIv5uy?=
 =?us-ascii?Q?JnUK6KcRBPRqGqSH0LHikqZPUAYLfRSeLuvaiYvSueeTpknrUwJ9eF+IaOId?=
 =?us-ascii?Q?MavH2tnZOQiGJkY4if+mSbhpaqVL8jQISF7SdjyMc9KC4Gi8u4Cn1pykflxx?=
 =?us-ascii?Q?Y+/ncq+Drk7fRrhi1wTDsWTz0GtudTkeKmNcxSt9KfHWSYyDJJtHXdIKhTCa?=
 =?us-ascii?Q?gjEau+7+IQQy9WZrV7gf6NvYGzRoDPUAfdv9AufPXh0tPnsz4hiTrTgJnDGP?=
 =?us-ascii?Q?GcpJfP2br/bJmARV9Ev1uf5S72sMcpXJT3TA1Mpo7aFq9pJ43VB8mCOk2Dqr?=
 =?us-ascii?Q?yhK2Rs/BD1BnybZbtxmfX0gPfRaofsq5NZkK/z+umVsIdfO3f9FuU0kI709i?=
 =?us-ascii?Q?5UOMMuhWxVeuYRPZDBnDE4X/rMCTMoPWpwSiCakPQknZGz29mOEg+YeM6mXB?=
 =?us-ascii?Q?eNn1CJMx3F2VekFwL1Wuv8nXkMCsJfTabEwSU6bAEXLPn9SHjXRJAFLVa1+y?=
 =?us-ascii?Q?CA5gu8NjX8F6392G0AEktmejiFeuZJCAaP6mfjKwShhmyoZSDXMBHFFhHmRi?=
 =?us-ascii?Q?uOBj5UOtCYqSGkEZ6u2iVdq9/Apxdrs/UMbMK17dm/VmiRLW5nDHSKU7Y7rl?=
 =?us-ascii?Q?ufYGm7nbPDvdhCQwLC58hbYpcjUbboBNhqEcWSBKy8jCbjqAAKPvFIqvjzET?=
 =?us-ascii?Q?nAeJEKts20Nnrk8HcEDG63Aa6qMkIXlV/wNXCYWsvXo13KAB1V2INIITcaGo?=
 =?us-ascii?Q?9r0dcWlYlyckdhHOlYP9tqURIdFseqbubxMdyLQqBEoFnDEdr8CZoQN1Umr8?=
 =?us-ascii?Q?cD2BL8H70WuVh+qWI9J0JlXkg/CobUKE0kV0ZJxO0+jW/BI3/RscjCI2xWjm?=
 =?us-ascii?Q?4g8xA1g+hGlqPTLPlfwuLHAfWz6MBSNMYh+mgVtf2FSac1t3k5lypvEUTegD?=
 =?us-ascii?Q?PA7M/yQAKw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ef8db3-9100-4098-e87c-08de6fde2382
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 17:41:40.4695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f904I8aPNnLwuCq2WMXGgyGzNcNTMcA9fUkCQ+x1PX29F93MSGcMLxcTQcoYVY3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9470

On Thu, Feb 19, 2026 at 08:53:19AM -0800, Nicolin Chen wrote:
> The thing is that those driver_managed_dma callbacks don't call
> iommu_device_use_default_domain(). So, the iommu core loses the
> trigger to switch domain from BLOCKED/empty-DMA to DMA/IDENTITY.

But they don't use DMA API at all so it doesn't matter to them.

Your issue is that BLOCKED breaks MSI on ARM. That is fixed by using
an empty-DMA API domain as default.

What is missing is to bring back the IDENTITY performance optimization
in a secure way.

Jason
