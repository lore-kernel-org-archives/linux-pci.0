Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012014.outbound.protection.outlook.com [52.101.48.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046FB18DB2A;
	Tue,  2 Jun 2026 00:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780359352; cv=fail; b=ovjVVwh4RNVmzAJTvR5Te2ohuHN4Mt0P3H/BoAQ66Ig9wV4DckA9CJ99G6Ruuh9mvWY8qpJLEOwwvssrHqPMPozV67BJVvLwk/1FfoWE/BbY5au4UPp6tqaCPTGgToITnNyWQ7L5LhmVJgu/E4+Iayz583noQTRejS6Qkhob9qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780359352; c=relaxed/simple;
	bh=4QqnDzbUEek3Ac07ZOj5URDDjwyDYP+ZCclIcFCRA8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OoSB37DUaq2Q3KKxLONgIumW3NIOO4wyWXClTjYucWrg7l0XVmthjhRliEsneBdMMbuSmVd/FSEGW4Mi13m5axhuw9TwZJyVZwLBqLYE/nr/QzaZxRjl+JJj28PJrmmDF2iFibQ8aSGKnEjcTMzq335Py2wvNUYXYdrOO0rmhsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hdQ0Xs5v; arc=fail smtp.client-ip=52.101.48.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hdQ0Xs5v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PtCW7hbVl8Kea9cykfQ4kqHNb0asBvMwRaWLN5M76OwbyS9B3V1iWhOMBk2XBSvGsWDpqiAObiu5yQp40E94GBUbET6WV7R91Jl0CMt7pShar8P+KtvbtZ5yIG08o/tVXndmMg+opn4XbX6eeb3h8/2m5cb4fz1tA5dYPVa/eUKO0s5jwMU0zVCQKVNJvH6xY04ywoHiGUg6+I8eH1x6VSLsuLZc8FMbHQKvwi0uNIL/0l0dVknKej6Hcn8guVdRdtoz14oWrAOagM42xs+WJaqpi4r2XHnlLe5x1fABhvUoFsZr9R6SmwsqErJh4fQ4nRcBn3uKFzhFtAmXMNE94w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKVvW8n29hgtAT3LaTeOf+M92+kD5pqNrK3aoHS4eac=;
 b=lavLVfzzHNNOVCSVmTRM0y1DPCuFigsUVTptX1Ox+/zQHVb/FwmIXnBBsthWqD17RAOiJIEjyd8ztj567VY+tjEenaI4u4zTUgwKtgIt0XqNYj9ci2B6F4rAxcFw/wlQLA6dQW8jxBciRU03ZFN7HYBW3Z7B3IRgW18kQLJlmHiBjxOSyvjWGBhe+a2qe3wgJPJpaI7sWMqK1XCo8ryncd9Hv1BzxeRKBHgFVjAYuHDtvY5wpdYxNZ9oxY/m2WdrjomN3bkhuoSCOtjAlByeT68F1AzJkh1rn7+o4d0H7pn2TYVvktOIqyWl6Wo6+a1A4KVewsqrD7jQznbuupTmZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKVvW8n29hgtAT3LaTeOf+M92+kD5pqNrK3aoHS4eac=;
 b=hdQ0Xs5vAE8VqCqgTtaOeG/JMJYHS6gfyZMUMpzI3oR34SCxfmS9IboM4LdOWdcJBBCGNimpjStXBFtKNKkHHjuBfLxvOIluVWp3H3fyMO+JD8oTPXP+pVIwGY5tLdiqrKitYYwttf+bVDP4FSghaLXUninKO+Luj4NLFB1kKvKCG/n1/fVER29x4GYsLcxy2QJGkU7Rjwef2sp0IRWIBP8T1tLRNN/BZmiYDHkNKAIZuQnAHsM4scIDCudmGo9X2/EpELT1j7MP16K5UgCt9f7vC35SEgIMeYrBFBzS3ryq0wkEN+uZKwN/M7wxw9J7fBwH0Y6KkHgp7cf8F2V9OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA4PR12MB9810.namprd12.prod.outlook.com (2603:10b6:208:551::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 00:15:48 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 00:15:48 +0000
Date: Mon, 1 Jun 2026 21:15:47 -0300
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
Subject: Re: [PATCH v4 18/24] iommu/arm-smmu-v3: Introduce master->ats_broken
 flag
Message-ID: <20260602001547.GR3195266@nvidia.com>
References: <cover.1779161849.git.nicolinc@nvidia.com>
 <49dde0a2e2dc88e421a3010956db33d47cc92aa8.1779161849.git.nicolinc@nvidia.com>
 <20260519120658.GB3477375@nvidia.com>
 <aho9DB6it2R5O5Nm@Asurada-Nvidia>
 <20260601123231.GG3195266@nvidia.com>
 <ah3udmX5SIO9lAXR@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah3udmX5SIO9lAXR@Asurada-Nvidia>
X-ClientProxiedBy: BN9PR03CA0585.namprd03.prod.outlook.com
 (2603:10b6:408:10d::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA4PR12MB9810:EE_
X-MS-Office365-Filtering-Correlation-Id: c4e369ea-fd91-4116-4d28-08dec03c18db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	7hRBJ7dzsd9oVJFFP3RygVeZaEjJ1YkurAdx7Qst1Cjctl+eRPRni648kVsp95bxQpiDcw5iZxdto2IvFDM3aimw4cfvvZ2i75MM9U1wTZGCpGniIaqsgzGdEBmAlyTS0K24VpsVQGI/5iYcQLgg+YCg33P6EdzUbTQc76G9AogYZgSJJ3AyN+EERahNTVTBZKAKN2PeQeRvZY6JJzaNl3GAJEcGas1hOrU6dtSv/SfkcFDRgU593fXQP9gajNcqTdydC9LhR/oXlMkUzrOil6lJAa+al3E9mAtziVsHeXDTHJkJcdHdsd9b5J6yL35NeAdYMGfHW8R5RArBNBsWXHqe5pl353tJDfmso0lwrBlj4oEp2kB1xFJ1dCqLx39eXtnuHNlbg8Mn/IYV+OwksVrrNC06zZ0OFEYFSxevQD6keHk5HBMaShIAbdSmjNKny0ApCFuy65W2QoOav2UNtib8kD0k1z5OajnCM7lrzrDzcA8YsMpUVDXxmgmGQNDGnqd7pSxu9PewC0bfSrmVEVIUz+lsiat9IO3AjYfR/Ssbrg5EcjNXNb3K6q5fQZm+taPPBORNiHeqNepA89G2zTieAEqW5rluJcbOwmYgJIwqhPlXHWAPkrKYlC9bjj4WBGEw6Uv/HLEh7fMFWyo9mEE/0C6JyaIzz6/gQw1Qt9IyvvUw5mA0pGCFEkPqDxKA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mrhf4IRbvKSieY4lN43Te3xeVcH3xwiQ2ev9lCXnvIzMjg0HKlyzjaQpAii/?=
 =?us-ascii?Q?jkwK/KoUFkSI4nV6TsLJVcQ+zMVWTBobLrXnHRPiTdNZTVUMmWHu9gM2a5XT?=
 =?us-ascii?Q?+Qrl2gp8/PP9uBXqIKIaUnCcT2Kp/+wD6LIZKl1E/FaBpq5BfASA069DjRCo?=
 =?us-ascii?Q?nRXAb91XgsEbomWdgoQzvPVExCveVsf+jC1M3Jy7LRbnSUxk/dOiqY7NXv2K?=
 =?us-ascii?Q?8kxwk+aNSfZ0zBBUUg84ibsNCd+giFXRTmyaxJ+jirPGlphqkrDuQXti/Vvg?=
 =?us-ascii?Q?KagHH78pAgr5swRn1VYAFkJ9OmjUoCZwMhhfwxTYe8h5xDEukcmGHcliTuJn?=
 =?us-ascii?Q?Q+NvK+uypks1vUUPLzm8umza/Xmq3g2yNUdXMIq/u5hO2ep4XgfdejcDfpSJ?=
 =?us-ascii?Q?+ddyg6AWRB+HZT0z1IzhsOJlBFV07zhpPYOviqcIMJpn0cHEmvmSPr9Purea?=
 =?us-ascii?Q?TvKT4B/mDbh5BL+CUWa9br4i4oIo1hpfT+xEUQTUf7Oj8Z8s8Lilacw07MvS?=
 =?us-ascii?Q?Sv8ghtenF2L/VYtTj/mVWYkJZ4WAbavx/SagxTMeQbFb0+yz8+S6X0IBjrhG?=
 =?us-ascii?Q?LzJyvjR7ziOOs+y5W504ggzLH3FXYev3e8R4eq2g4GuWtSu8hHsSdEjrPLaO?=
 =?us-ascii?Q?AJQHmNGcMqpjy/VSov+f69PBx80EizH9WNpgh8Tgo3+qJO2BBsT3h0bwrbCj?=
 =?us-ascii?Q?21tR2QWnGEDawHHPZ0ihoB+bSw8jtqIPqmkYfj+PTh/kD0Oi0H/Ck2qWW3k2?=
 =?us-ascii?Q?CAMjVPEruc/LRc+MU5YleIOvkbT1Ar+tZtzHpEK1EC8bEEyECVR9s+lFnZLJ?=
 =?us-ascii?Q?widKLud7gEARU51ORCxI1gtkmXYc+R/e1PTDPkcTrH09Ia3bo71xx88g/v/Y?=
 =?us-ascii?Q?CUsHyrdL1LZARkTEw8kDBVQDBnyjx3Y1AB0EmlW0hD74fuKtHOm1i/lE0eKH?=
 =?us-ascii?Q?nN4BEWCjF9r9dO1PmoaA520LkMj2dYLP8TRRjldAR/tPp8/PUensHYtxVg/O?=
 =?us-ascii?Q?GTnbJA5TdJMYNs/6zTjjWwiMu1C3M5P90AAI0AYXdLOJ5qkJsyHFHncOBFRB?=
 =?us-ascii?Q?YOMXCILUkUf3dgBPjo7jbFFSLWq3axH9RIRvbzf6+Wv5Sk9sBnxDxclO1TTh?=
 =?us-ascii?Q?my+YRdTguzRZ+kB9rumDy45P2AT+6SUpCAkVIQTzobs4I+cxaSQouHBQ79um?=
 =?us-ascii?Q?vTqs7DTANOGir/daWLZ7fak6908NDotFFCmERG3VtpMLS93lm4USu8/chKNR?=
 =?us-ascii?Q?9ynUxWj4yg38GVaGkb6ISBs3OSnKG0Ofu5BF1IJEb472SNBJY2tmwlnCgcYX?=
 =?us-ascii?Q?DBMiOqVrfnPZc64vX+j0R3QaNnbjM9BHUdHC285e8x3/IYisgaeD6+lxSxr+?=
 =?us-ascii?Q?UUEqMIh3SBEeqyhvqISMShTgXw/3nHwuJr7++MNhD/AMY/f+ar3jRuGVQWIq?=
 =?us-ascii?Q?mK7fVROwLD81XeJjYIlj1YxArkmOSjXmOecGr+JynnOpcwO8rMKYvQO7BPHU?=
 =?us-ascii?Q?DF8KigqOk24fExPlGGTMGdjPD/a8ovUT4ynyOTe3OetX3lGaH6ey519M8Ick?=
 =?us-ascii?Q?Xe6vxgRMDcEZWBJZRnqRfMwFuNwdAydOC/zJOb0QZ4QmpVUn+sGnvv6sl31h?=
 =?us-ascii?Q?ENBGhQPk+ZYMThTP5RSx8jH/edRfhT71RPa2TXLn1TKelFDzYhKX9IpZGceO?=
 =?us-ascii?Q?FY6j3BTxxUZMYM1vkXCcyMYOwNfIp7WEfqFfrSM2If8cl+S4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e369ea-fd91-4116-4d28-08dec03c18db
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 00:15:48.2543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3SWCqB69sN1dK7aoot4/G5mc1YSq70rFYBXi2Hu8LN3Yn6vMKzr59FT3COUHkmfB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9810

On Mon, Jun 01, 2026 at 01:41:26PM -0700, Nicolin Chen wrote:
> On Mon, Jun 01, 2026 at 09:32:31AM -0300, Jason Gunthorpe wrote:
> > On Fri, May 29, 2026 at 06:27:40PM -0700, Nicolin Chen wrote:
> > > On Tue, May 19, 2026 at 09:06:58AM -0300, Jason Gunthorpe wrote:
> > > > On Mon, May 18, 2026 at 08:39:01PM -0700, Nicolin Chen wrote:
> > > So I've tried INV_TYPE_ATS_BROKEN: during per-domain invalidation,
> > > each batch is built from domain->invs so it can carry the "invs";
> > > if the batch times out, we can immediately mutate its ATS entries.
> > > 
> > > But I realized a limitation. E.g., if a device attaches to two SVA
> > > domains on two SSIDs. An invalidation timing out on one of the SVA
> > > domains could mark INV_TYPE_ATS_BROKEN in its own invs, but not in
> > > the other SVA domain's invs?
> > 
> > You'd have to mark all the S1's sharing the STE.
> 
> That would be a bit convoluted as we would have to go through all
> other domains' invs arrays.

Ok, that is certainly an annoying problem.

I don't have a better idea than storing the master unfortunately

But I think the locking for that is going to be tricky, I'm not sure it does
actually fully work..

Jason
