Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012016.outbound.protection.outlook.com [40.93.195.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99026207A38;
	Thu, 19 Feb 2026 14:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771511865; cv=fail; b=rnROgk8gcvQklQyEz98FQcOkwMUH3cezwCYAfJNsgjAJhQhFdNOf40kgHvCXBUbfNnZtOa1LzydT7+a2W/e6RdY9cM0qlGvUyebr4rJs7ZGX05VUeIahryfGEbawLG1OZh3Bu1Ds8Oo0on/7YUiUxRniHjrdSH6vs3zxDJE9tm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771511865; c=relaxed/simple;
	bh=T6ZMz5r4y0z8M+PsPh/f4Lnp5NDevSErjys/B3vpzD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b43xi2zXdUfjFvIs4R21qKwp1y7c5Wp1g5Fzbu+GKpHS1Yh3K8B/fIFnoeBmoKg5fPA61M4F4mE+947gulnJuxC212iBjXy4sNoEONfy46242WYadvQAkmUVAPsM3o5+xiTk/AS+yhZ1wR7wAdjtoiS+2kRv2kLePTlZMg2nxYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hCiwJt7K; arc=fail smtp.client-ip=40.93.195.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hCiwJt7K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIyGDCxqLGvKTIsHxUqZrUCFpouYiJnMmELCNoMsxE9FeGzeK4gUdTEj/V/ocVWEkOrrz6UzoW49MHYJwrgRxBKIWaLTud6L/PqvV/cEwbm39qpZN4DwVvDfpl1I+FItlQXKCtIhijzTJDHtNqrFFUCwBVIS+nbB/hboDRNtcmaciYYcwWzCzsIc+wdnwIj3/sPY+uf6qMbLJKCk1Lso2h/626jZ2c/BZmBHT/M8KHTi6PlxWa47XswhuzKG1TupIN9EZaadKlsXD6QelVRCLrB/+3Nz/9S2srC29FNdmKYTueXndMi3GzA4VcUWDEJuDMVh+J4lNuC0k8pkoV95Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRNVeDVZeNq/1WnXzci8Pt86Sy9lNtsovgf7ek4MRLQ=;
 b=B5EKc1fwEI2A1WvJUaDfJsl1v4FQedGZtrje27WAIBj/2ETuCITBgkyG+MOME+5mZm7SpyP+Q9DJA6wV9Q+G8NTZtTgs586vhvZooFyJxoMiXqvKW7TJB1gEWs55INYw2U9z6Wx3R2jupjFt/cRpqGFbkAaisQKbitYfRaVUft+dEhm6Rt/ZX34pezK24LqlFMtvatyqQ957OhlyENRiePGBg/Gck5xcRfMeKCUidzT9fC+6eSrjLPPs6LMPL8HAbFxpQpcNCLIChJ4QeY/eaN8PaLLxdlZKyJlt2tB10B1lyEROu2Q+ifLj5sIWKoSnQX4Egz/vbvDk5B1+Ld+njw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRNVeDVZeNq/1WnXzci8Pt86Sy9lNtsovgf7ek4MRLQ=;
 b=hCiwJt7KlRZD5lVxxpTKJORvkcj656Vw0hJ7VCpymRdgwVKXd7PtUQ+mGxKzXV51ZA21hT/cAXVhkOIxBKEH9mFLLBTbT7+XT5OzbuLfqy3JFZzAKpe81+5FD3X5QQ9/rV2mEmSUIL1rhenjmQlPDf9hdaw/1WDZAAoBPZI3xUNdn4B161fQHlH8xcCDKWXm5Dnw4nB7sH7hMCb1ZHZT0+kPVQWaFld2XFOCZyhhru2gDOGRPqTnqSmtUj6LhmqnxdDjybe7yGvG++hJenLU6P7pAOSaLvz7+25mwmE7MKvH5HBBhob89q1ejRgcetNMzzAvwXvLH20u8nqilopF9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Thu, 19 Feb
 2026 14:37:39 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9632.015; Thu, 19 Feb 2026
 14:37:39 +0000
Date: Thu, 19 Feb 2026 10:37:37 -0400
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
Message-ID: <20260219143737.GG723117@nvidia.com>
References: <69727e7ded712_3095100ab@dwillia2-mobl4.notmuch>
 <BN9PR11MB527649A0049CA195E7BCF9218C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20260127150440.GF1134360@nvidia.com>
 <69795d0366a9_1d33100d3@dwillia2-mobl4.notmuch>
 <20260128130520.GV1134360@nvidia.com>
 <aYGEDv86r4a6l2Dv@Asurada-Nvidia>
 <20260203143348.GA3931454@nvidia.com>
 <aYI0LUdXqrjmRcMo@Asurada-Nvidia>
 <20260203175540.GC3931454@nvidia.com>
 <aZZDo3BeuBKh9q24@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZZDo3BeuBKh9q24@nvidia.com>
X-ClientProxiedBy: MN2PR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:208:c0::49) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN0PR12MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d0c1e58-f213-499d-d5eb-08de6fc46e58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?odSJTh8fOC+N6AfZG7oaL1chD4n9ipXHIFI+6LwZa1iobKMlLr/c6QUR/WhH?=
 =?us-ascii?Q?Q9v/AeaElUyozMKVW5BZK/kOVg7OgR1Pa3U1MBQYY1RxiZFgoNsdo4OE9lYS?=
 =?us-ascii?Q?tGf3JOkk80ZH8tmzE/aZC/ZnAfZx8RMVum5iGmZeA7Gbqk+KXrMbDOJN8Nlk?=
 =?us-ascii?Q?OK0+2AhEMe09gSBclPPA8oVjF620FP6VxrF/IRj8ZxX8O2lTFnenx67DqfuB?=
 =?us-ascii?Q?DrCp52j/Vea7+c5NDswhP0jIcbuy16y0pFYXI5FSKSHabHIlgzEb1YJYidDI?=
 =?us-ascii?Q?Vx+CvBkLZyHJzv/Qis5E5H1yphBsk5w/AEN/YF0ze6buo0pH1VpFF74dfT6N?=
 =?us-ascii?Q?ygEwfMwqU9uEz4q6je17qkYKUVCKvU9bl4pMCb2QDzFeBCw/UKuXiitcK2IB?=
 =?us-ascii?Q?WdIPwjHqLiefKn4IWM/z/pJzQzhkKujQNY62qCmU8WtlTqg53CqsqUKJN7h9?=
 =?us-ascii?Q?1n3lIK6gid9RcidTU7isnNrJmY40zibKJlcPaGj5Te2tXsxk359EnxIE06V3?=
 =?us-ascii?Q?xRzOTMpJ+z0/jx1inAfdMQSZCrbY8z2BcItwQsTFO+B+Umo4vvzMnEOwDP3S?=
 =?us-ascii?Q?0F8drnLGzCeE+s3f7sVMWK29ZR7JtVsQUd6MJc+2c5YnrBEVyQceuHUG4ngt?=
 =?us-ascii?Q?E7fCOyZXlK1oaeDXDoZY1vcgmsbNT2hnTWWLKhjaVpeCNRhhjiuQ2Iw4W7Tx?=
 =?us-ascii?Q?L2ul22ETQa0zeXTmZq30UrKakhE7Rml/pue/ZeFTRAMPcfc9Kmo4hZ/kHaoQ?=
 =?us-ascii?Q?/tUuu2Kq5lfx0Vyhwm2IGVFk3XJ612nb0yq8fpRBVG6MG5nuOQXet9yi1Ue9?=
 =?us-ascii?Q?xXuRTOkapRC+r1/dSriMcTaPE7UIzLdCW5zQKDBGQEeWJUxSZzSpDuWP1J2u?=
 =?us-ascii?Q?fDWhEU2XbMl7HUj7TXiIWjmuUgR5kv3BZ6Bdo6/jn/7u1OJUDRhr/ImteGCN?=
 =?us-ascii?Q?TZKrli9iP8E0dznRCI1+wzqGnYHjkDwBckQAMb9VNytV0GG/wNBq1dHgG29Z?=
 =?us-ascii?Q?GbckkAzW0QKs8owPL43Ik1mwo50d2kLh/1F3vHw5uIHd14lD0k72qyNgGh74?=
 =?us-ascii?Q?tO2wcIgbFfXZQuNOEouIpVI5kzyZ500nFNhOQob7s+THxPrRTbNTnglrVk8c?=
 =?us-ascii?Q?12E05aXzRuTUps6igoYP5D3UDvw09/DogOnOu+LqeLTAvVmvGX+7Ov8nNxk+?=
 =?us-ascii?Q?A32cGva81rd00nRACC75WImwU+KR70zV/orW3n3eIZVWsMz/I83ZYoyS5fz3?=
 =?us-ascii?Q?Iq2NIXCUzKtv2vCwCxgG5iJknBJUyzCXzx9ksN3hKJDYXZB/EGdSwiLzDx4p?=
 =?us-ascii?Q?pqZmsrY2JZTgqjVg4hlQkcXrFrDjKOkoLm/CGutQvUBNWVCci3U/Uqjqahwo?=
 =?us-ascii?Q?nJfBTSqZb/WEVvyF8cINxh3sBTIENd9Hz6UO4gRlD8KZTE5NFI7T+1OWPdkb?=
 =?us-ascii?Q?OkYV++PZz47ZbYlFF3tmxMw0qKohheBQfv+pPh3XeKkZjDRzwMxA58+9qgIX?=
 =?us-ascii?Q?B7hS74wyVFpwa4NkbconIlyD0wVaDLK8yBI1jkpH6sWaeKtTpjHTHL/Wzv7S?=
 =?us-ascii?Q?GKXGRT3Zno9hpPsUXg4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wno0Om9BITxilNCkMbRcvZYyvj0vb1/r+SSZf9HtShAyWGTwaPBLmuC4zzgF?=
 =?us-ascii?Q?BOpIg+auTsJUF/rdbPqT+iOfVFN7RAHq795M0cC+Rl/XLEKDAepgGC4y5xj/?=
 =?us-ascii?Q?OE2LSAoJf3QB1TivUmTZCW9oVUp+1YGShJVHU/y3XroQH+/0NnDVfXr1NRVM?=
 =?us-ascii?Q?GQJvELuQAXXinR1cyq29ABnNzx+yxMINIA+7cOjcOudS9XW5w5BzWWVI1L/0?=
 =?us-ascii?Q?5JIMX9uK312U5+g82CDsgBbIrAwzmDmA0clqP7rbLNWpSCMHz05U66YU4paJ?=
 =?us-ascii?Q?a9kOPKZfmoS/4SbuFyaniUnSxwB7zXQy5TsJE4dOncqJkEXG8e3CM8nJ+5li?=
 =?us-ascii?Q?zsHlwxEqnG5maGZDBhfIMtzJv3QcN/pZYO3E7Ld1WrR2tGCJ2c+7JCN0Ahc9?=
 =?us-ascii?Q?sXOpPDHUas7USuUMv4c4aFtjV21OCkDOrNWNHjCd+0+lr56Ivt/VY67PtpIF?=
 =?us-ascii?Q?pYRBUI9MDIyjVK0x+NI6wbZYmN0X29u/LGSFbx/nz5/0DgkylK9SW4+FwAke?=
 =?us-ascii?Q?vfofIzN1nr7pwUESdQxvkimHyq6H4tvvvkwDUbQk/L2s2SUf0mdMX3JeT13m?=
 =?us-ascii?Q?n9mA+m5G8ttrMXswxuUR9ZBtbRfvZ0aAy3zrIF+VcfR5gxcl4IsPo/IZ8fON?=
 =?us-ascii?Q?qqOLr27sLkJv/2LKSohJE1Gx657rVMVoTAXqKHmPvom4o4mjcHjE8E6DOTpG?=
 =?us-ascii?Q?SAglD6pvsfqQzKOU+Wz0KKx0kGRcx2DT3ufmcx+px8mGQvKDcBZrrzjGWr5T?=
 =?us-ascii?Q?tYleVgDrQZq6YZD5KiCT0LelQJwE4RGhgc/zpF3CVqVIfPJhvJ8KjI6RWpzI?=
 =?us-ascii?Q?pggxMfCzqolrKqLLApYX/JyItFttL+zP1XrTp8IBOEZ3XF967xpv8Qwrseag?=
 =?us-ascii?Q?MoDhOFJMJaWvGihw6LeRNyZyHwNskI68JnerNmdTzZXAATh6tBrFtObrOAom?=
 =?us-ascii?Q?WRAZc+ZfC5FbqAVkbIkaaS1kceCBlCt8dN/MqakJo/d8XYWaMIr9KwIQIhJA?=
 =?us-ascii?Q?UuSPRfSRYM9fAa3IfIRLjV5aZodaJGyRNXHfv2sRpA+hu7jRdyQHLXK3D/Uq?=
 =?us-ascii?Q?5dSwW8pQerMC27bnuii1DoHkGq/ZO1VUbWX8Xl95WAiGo3rrWxS6hZGWmbut?=
 =?us-ascii?Q?7vqkzGckq4rKFz/0OU788lHGQS7/nAfTGySPOZpRpc1qOw1cempvZmEe31YJ?=
 =?us-ascii?Q?yIIB4cFoYsmyIWr2TbIdVOwtZS0VuTCjIqDSyVu64DCOe08IgQ0331h9X23G?=
 =?us-ascii?Q?9BwfA9aCQJx7KILfWbHhYkn3GO2HTL2rO/oUM6IfuiaSnqaJJMQtJmoNEOaU?=
 =?us-ascii?Q?JGfMFuvXIV4fQwpzoyqKkn2o2zjB6C0slr14LIxIoeqgdjNAePp4GP30qS2E?=
 =?us-ascii?Q?yU2b7MVfdDvjUyYkjCIFJxpi1LOoVDgPL7jKCG4c9xTLbzPV02h2Thn9xiR/?=
 =?us-ascii?Q?WXGRM3Ongbxoq85OoqZ4Jjw2O1HMbyeTDQhbVss25WULWW4RNYOK3lr7qcGR?=
 =?us-ascii?Q?ie9B/qPBOGmUfToNZNbQMsK89eFpu0VpaO43nLl93OY9Pd4a4em+pIXq2jgB?=
 =?us-ascii?Q?taVib6JGyBdSibtQZFS9vkR54aP7bbOzjJkTbqrsTNSO9UNfCHEe2/n0lszE?=
 =?us-ascii?Q?tGcQxl0ceUI037hKa//hNon99uJAFLeuAtzkRH+ZXCqG0RlnzJ1jrQEpm2CO?=
 =?us-ascii?Q?QQqcZdit2tXe23KhDNvEkAOLwW6TgQBq69wOJ+TwmB+kGsSNNK0gwYD2MVlX?=
 =?us-ascii?Q?O58SzoMY4w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0c1e58-f213-499d-d5eb-08de6fc46e58
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 14:37:39.0911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70pJTnuhmCA0XDEOe8qs45odUrs5bhBhazu6k3m7GT8przoK2sjfxxeTZ8EeNBFL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5977

On Wed, Feb 18, 2026 at 02:56:35PM -0800, Nicolin Chen wrote:
> On Tue, Feb 03, 2026 at 01:55:40PM -0400, Jason Gunthorpe wrote:
> > On Tue, Feb 03, 2026 at 09:45:17AM -0800, Nicolin Chen wrote:
> > > Btw, attaching to IOMMU_DOMAIN_BLOCKED/group->blocking_domain is not
> > > allowed in general if require_direct=true. I assume this case can be
> > > an exception since there's no point in allowing a device that has no
> > > driver yet to access any reserved region?
> > 
> > If require_direct is set then we have to disable this mechanism..
> 
> I found a corner case, which might be another exception here?

I don't think this blocking security work needs to be part of this
series. We just need to disable the mechanism for untrusted devices.

> Most of dma_configure callback functions don't use default domain
> when driver_managed_dma is set. And this breaks MSI on pcieports.

The ARM MSI aperture need is some special case here. Those drivers
don't use DMA at all so of course they don't have the DMA API setup,
but they do use the MSI aperture on ARM.

Broadly here we were talking about blocked domains for unattached
drivers, but an empty DMA domain is the same thing and still continues
to allow the MSI vectors to work.

So we can reframe this a little bit into more like

if the user requests IDENTITY then the IDENTITY domain is not
installed until just before the driver binds. Up until then it is in
the DMA domain. Meaning if userspace controls driver binding then
unbound drivers have their DMA access blocked by an empty DMA domain.

ie we dynamical shift modes for security.

This would only work on singleton groups.

Jason
