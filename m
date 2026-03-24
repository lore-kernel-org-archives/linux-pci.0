Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010027.outbound.protection.outlook.com [52.101.85.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0506F5B5AB;
	Tue, 24 Mar 2026 00:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774310609; cv=fail; b=ZxM0LRU9cqUnGwPmJvGEBKywki+EuzYvjbGe3dAaNjo3lQGrfl1SKXohKRtuG3AKeHY7Xv02RFOC9XaHeGt8V5aHzc3xGZGR7rpGoCutzifZon7QSfiuEXhSqcpPwS52S7Rk54mXhD4N4F3VBa3jmvRVt1JcGIqG6vCVoFtTk0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774310609; c=relaxed/simple;
	bh=wmDxEOCZAzz4/PgRg8R36ghkVGZzeowvStPMUFHTGAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=URwInkIErJAJDqmmWWUofgsbBF8kb5lfla2rcJ2fj56lqlD5Tiher7bE9uYsKcc9k/NhtP2/El3QJCNuym32WQ67kC4KXL7GyiX57EujIs8QPwjjuEbD27j3Mf7hsyo9yLegCVWywvh24L3bAL5ccIY0o7LsE3DbogPHcqv3yRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pMZbV4jb; arc=fail smtp.client-ip=52.101.85.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pMZbV4jb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNbK5A6RAGNk3LsBFFc2W/rEEXZ0G32p2GTup0LkJtJTBmALAv8BCZAObt4OifKbqJTUz+cFFXx6NZ1n4PUtWhe7kfOFJBGnSClKAdnJqw+AbBBhkVb8V1BOtRUm32kWdt41plnDUx8tMGixtww01BQ+1PhsjwrPo0xS9UqFyJ3G+ag/26f/MUGARMoFIUdpz+xS6bISd+DxFmEcsRaxKQneZAvEuz/LukVl6WBj+vewkhhVx8+59yCugZl7EJY3abUONTl1sxSB+bzxVV64gXkmeMOc9dbmSftxz0sKvwktD5d4WTNf2P8PC3S4l/vQLMZJqFHtmlLIRzwN79PpGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/KTRl1JIVHYqE+oqLLDDD8kWLDWL33PTRmZoWjH3Sg=;
 b=IXLGioMzj3JNiZ7/Dgk6syZ6Tz5CnuF2PffqMEY/u8cUikWdHD2WAXV7j3w1NQ7qsmjzsu6Cy+72QAdtBqCyKMmShHkH3il0S+toU6Otj29BLRe8c86m8SMooGa5OE7BO2V9rpDHoIa/pFR8mWqEBltyMwzbxhKKq2ZSyUaUAO5dCC83yBmMlbugE+s2JTkqzhz1ElhWGZnjpILeLM/CsSi1L8m6G6WMgl7B4pEmBtiPy74p6yXs+eRQDNoYcg5lW5cMWEwWY0GJB991WEFgsXvJ+t1MsdCZXeJ6eJrPJrxCIr1sVLt6h3fqV9wZL0YD+5gk6sGBvcWrsDZef4b94A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/KTRl1JIVHYqE+oqLLDDD8kWLDWL33PTRmZoWjH3Sg=;
 b=pMZbV4jb2kgkucgogK9dNsPU/6LucrwwtOlJk31GeJfL1xxKT2jrB3lfDrNuG1HgkobYFsnkTrQbG+IZ8Y5mQJPfvhUCGz7jKI6yLIH7fFUO7vkrSyhn9MX7xitLSHFHX1HFarOgHhxJtO6QoUTxbE61d9nhp2Gl5wypt2T1ujrQPngApBGmCv+HlEYkZPhMNV8Hejz7kOivp2REK0dmk9pIJlaCNhNWay/+ISygGe+ewiP0Q0ObOHxSTUditCZgMMdFYip+wEsaTMMJOVioZP2+bAvQaxzjvUPKpO2NucuN1YxM70Qw+xTz3Wka+qzvDDXYqSuj4aUPP0xqFyv7/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW6PR12MB8998.namprd12.prod.outlook.com (2603:10b6:303:249::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 00:03:22 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 00:03:22 +0000
Date: Mon, 23 Mar 2026 21:03:21 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Vikram Sethi <vsethi@nvidia.com>
Subject: Re: [PATCH v2 0/7] iommu/arm-smmu-v3: Quarantine device upon ATC
 invalidation timeout
Message-ID: <20260324000321.GX7340@nvidia.com>
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <BN9PR11MB52762F94146776026CA203248C4EA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <absFXmFcpG8O7uNB@Asurada-Nvidia>
 <BN9PR11MB52764771C48B39C09F129F218C4FA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <abtpCXAnqLRnbG1z@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abtpCXAnqLRnbG1z@Asurada-Nvidia>
X-ClientProxiedBy: BL1P223CA0010.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW6PR12MB8998:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a3516be-0daf-4c33-33d0-08de8938c36e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	QRPjVcq4gUV6KIFSua/4sa2IJO1cTNwDpI/iNAK+tG45oKgKGRe0qy3n5iSQ4X+MDphGwuYnVXGv8ntilcA9nLUiBYyHaf0u2Oq0db0q6mB6ugUF+om1vr4+liQmGozDf7vwlCrvc0MwL3Q1N52QIKDlz53vAHZuo7iG9MNsbxB97RRszHiMYQvxfonVSJ2+Rwxch6wMjU6hNlvgX6Ao0KeesyVDMTWrldvuH/6Ff/nnYr6IX+6pyXm8N+Wu4hftozdfsqydqjRElZXAReMIAE5Evx5aE7gWpqUnqpTAN3DTVR3NaykiPt2Pr1Ylon5Jgj+uT/hIy03veWjsJi0EHoTuUU61gQ6C6tmwArXCPbfVAgofQwfDM3Tr8Oijf7v/uFDJZB0/+MOeHDkhzBE9VrZ0v6jzFIEYZWlZmVuxO+ptYukY/03sVzJCDLzAUeW7YrO79JEZf9ndOLTQeOPDx/+HuTjZ57DY/7KfFbIGNMmNvcdhvX/kFeE7GNSQgCG60V3pe8xotP9PKOZ1NsuohxZOft5LwIXjpULr56CyzsWZRn7upW90MxRKeXANbH+4m1MdERQ5Fq9sN0TK5BYEQtBA5Z0f1kbHrAG2C0efXC/d2zTu9hQ58N/37yBA5iCgOYdbyuhNOpn6e+gLo4jZTC3dFry4NoTEp21ZgOgtDNSnOXjoQ4CzZAgGWjjvSH8pUcPHL0/b5G8eRHCN+k0VUOrTdzVUqNaBseteGddl4kY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t6iDwGcciomIFNlN9nQIYV60X/a29OpwioEsTYdHMtGtD0QUxD6OOqUYBQCQ?=
 =?us-ascii?Q?1Mu36ri4GmQTQkO4NM/7L/xPvn16cu9yUwh6sPA6+2QKoMljLo5DzytdPNI6?=
 =?us-ascii?Q?xTbTFR59bbQqQQEIOCRFTZHJNiIfI2ewg6wUPm3cu/zR+LbHLWC0kX7n7iHP?=
 =?us-ascii?Q?fl6NOkKSNTy4D9oFG8QE1Z8kGVd1HW7RbjZ3K2Gblm881fi5h83506BKoKZf?=
 =?us-ascii?Q?ncU7F7sCR70cUSqoPxeL8lRbWYPtKPTFLLANxbcrpbNgAfA4HTWzGnDDAlfZ?=
 =?us-ascii?Q?Cobyo2SH2h3E5m0/jOWRkBIQW2b55iBVAggv12J7hUoRBlbTUXIH4XiKjrgO?=
 =?us-ascii?Q?jT1YpkWovvhe1CDQFZHej5nuDS2iuaYve96nWt2Yj2U1woqLoh/nxcGNvN6Y?=
 =?us-ascii?Q?bLlnseDARi+B7rjCtMNx2AEF20gBynKk4zaSoglpVTVRG/ob9akreiZo8JI1?=
 =?us-ascii?Q?6gNZMpQfoFXOdiaAyUfoz3ejb8LYV0tNgm8sbU/vxUUOPoHNn16IS1QiwkL/?=
 =?us-ascii?Q?BZfvw3GibAC/cCVQfT306B8mm6mxJMN1XkP76HAfGwnsqEwGz8Vl7nZY5DNF?=
 =?us-ascii?Q?MOTSv7bywhsf4prNiUBT4kM6mAODy7t6XyOXqZk7tpwUIP/AZJ3NbSre38M8?=
 =?us-ascii?Q?v/0wyngUIq/qmxEeOd559/n9KSTjyCUYpT+aSbeGYMbHKJwQ+hsvM4/l6BCN?=
 =?us-ascii?Q?oq99XQASC29O1ZHUDTsbLwuAnzXlo7kdAa3SuC1VaKJsBEx1D3F1+XvReLl2?=
 =?us-ascii?Q?v8XMDKecpe+jXpp1sMUYOtkwLNYWq/5O0ykNXObC8GQqwVbJra74hrGzdpit?=
 =?us-ascii?Q?DheapxIfQwB1Sn5G7q1Aa2DeQIpyJ0DX4vobYIyOgeAHPO7pzlvfQ6Bs2mdM?=
 =?us-ascii?Q?N4+AGYJ3hFIeysBgmqUBk7Pz9F20m+KG9V3F8eKN+YFibnJ+CSWA+fIc0Kvt?=
 =?us-ascii?Q?ycVqvp9kaZFdBAHVsQ13V9rFGd3U7qJuhMvi3wm2Mj1VblYctNpRtwQGaTyX?=
 =?us-ascii?Q?6qLfH1IN62Np7BgtkBI0+kz2m42B+Mp0krLkK21+4iiFQwaIHQfIxT8dwu5e?=
 =?us-ascii?Q?/AbiHwhjhKFA8avGTizXht4L9ZukHLAzY4FClAIB3C5qVPnF5lJPLg7MFQD+?=
 =?us-ascii?Q?a0YIx8OAvUzROTeSij2UwU5nP7fETrJgyuQ+nKvKR3NE+C/yU3mJFnQp0lE8?=
 =?us-ascii?Q?JFKD19LZoqpA8u32cx/QWiispblatrxv/lonu8Mtb6s+HIq8WAu5Ovl16PuN?=
 =?us-ascii?Q?WvCF8YuvCt2eQifUNJMd+e/BTBlrSSa4ur5brMfC6ZjUjPf550QafVu7v7Hc?=
 =?us-ascii?Q?Ju/C7IVXtvq197TUh59VThFaF51pyXbR3iHOoOBHx2a/TYrLJcOGSaEllsnp?=
 =?us-ascii?Q?Mnv4gQR+YZbs4dpRIZkvMTJ/TexoQTesvMtlT10YQqhQdxTQekwfWnXqygP3?=
 =?us-ascii?Q?t6hJ3+bM6Zj9DrHYb2dQZyvjpwQsqUP3JZ4gQVy3RIV39vdpx1yCT93iWdah?=
 =?us-ascii?Q?YiBpzQWaVbQDXRoWPmsdMMEUN3Gfpg+NO85RvJRkk7+UavEamO9ZPKinf6Kn?=
 =?us-ascii?Q?0qQYnJwKGstQHYTkliDFXMLd4gDE4jmimiJPSvSihsXS2+C1JN2kKYZoIs0q?=
 =?us-ascii?Q?NjydzYpBGp7MvAuqLUHkbd35X9LmQRZ+GkSYE/2N9k8qWze7szkhn3AdUaU1?=
 =?us-ascii?Q?QvWuN9BmuJ0O8aAR9j8U3e07+CJYB1DnaqrSXGF41uR4rIA/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3516be-0daf-4c33-33d0-08de8938c36e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 00:03:22.5910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMZOkCpir7JuVrVid1INP41bCdLijbSaBgNL4S8OAyX80T81V1FBRbij7APhHqE5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8998

On Wed, Mar 18, 2026 at 08:10:01PM -0700, Nicolin Chen wrote:
> On Thu, Mar 19, 2026 at 02:29:38AM +0000, Tian, Kevin wrote:
> > > > > This series addresses a critical vulnerability and stability issue where an
> > > > > unresponsive PCIe device failing to process ATC (Address Translation
> > > Cache)
> > > > > invalidation requests leads to silent data corruption and continuous
> > > SMMU
> > > > > CMDQ error spam.
> > > > >
> > > >
> > > > None of the patches in this series contains a Fixed tag and cc stable.
> > > 
> > > Hmm, I guess AI overly polished the cover letter so it sounds too
> > > strong?
> > > 
> > > This is essentially a vulnerability (potential memory corruption).
> > > And none of these patches actually fixes any regression. The PATCH
> > > 7 even requires the arm_smmu_invs series which has not been merged
> > > yet :-/
> > > 
> > 
> > Fixes tag and backporting are not just for regression. People certainly
> > want to see reported vulnerabilities fixed in stable kernels...
> 
> Well, maybe I'll just leave additional line telling people that this
> can't be a bug "fix" because it's written on another unmerged series?

I think this is more of a feature (RAS support for SMMUv3) than a
specific fix.

Jason
