Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010042.outbound.protection.outlook.com [40.93.198.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87994350A38;
	Thu,  5 Mar 2026 23:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772755169; cv=fail; b=fv3it1sZD/lUCJgQ0QhVrranRQbS3e+PibKzFyCz4S+8JcRtL6sdiUSDrbkElPd3yo92Xfx/UfF1zIBqbKBO8u+KXs2mnngMBgVHGcoJOODFAEcrqZC1PB1Z4E0N4NEZcambUxqH2hXj1dsNmOURBOm63VdVwpF1qHykLW2tO74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772755169; c=relaxed/simple;
	bh=wywCx78QO4KvK1J3nT8PgR8YHfXjS72tJlfMcgBuhBg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BxiLLrlcgM/ViB8Kn7R7on138WcBLoT74b7lig8CN/NktOz/EhJL2sFo6m1FqEfesMFqytdYEk5sRy4IDfBtJKe6YwsSvlM00fwZx2qA1McNrLDSsFmhN+yy6Kmk1kmrMNvHg369GOHz1Rwi3KM1lw3QCztHgpJ489AEtNw9+bQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BcUdy8fQ; arc=fail smtp.client-ip=40.93.198.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BcUdy8fQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZASKK3S5NAFC4ioxGnbuHoY3m7QUIlGVJAxb9Paai4gbD7547inMQDwfQj3lmPPa3I1fPaqGtYLwZxSuQ8EG336YTkliC71tIa4d0OnE0IpL1Mbvzb2TBlfxPDtwZVaGWfEHKnr79bZ04FqasrczQegwjOBLixDmFWWdWkwNhYNY8hcsA30TZsHnpm7B8HhwfJBGUM7St/KDf3cC1s20R0snedSq5z2vvCOkuembBVtPvwaZhxAn67gjZF8wu/zykX3DygcG83/JPj5AULHq3v4pfybk4mJUMY3nCPvL5qJPCnzsbA0tNZDQfEu9PsajBZkHnJWwolghOjH9a1b7Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHKNuy4PkXrsJ/AiZemQK08LiA1edZMhCYxdGzrELKY=;
 b=v+QA8JX+fpBWIAPtKwULl0ehSDJgQfVNWJPE4LF05eyLE16i0yHugYdG7LGYAg3vQ9Jvx21lEbNo52jtBiTBLbhb+yxU22D4N2relcE3lvZCmPUVoyS1NihXZP06K87MWi14+uFrer1py59za8G9Q2kemOhqPhvHW5uPf0rF1WYsJmgVc/qItq/IDiHv69ra7454xfd+DysmQt/Jd0tyeslcOMyThG5UPAfUC8w3J8W+BMtpDD8sycDhSHDXckoPGSfLfHL78c0IyswB6lQd5xaE8UpWNniGEtNRB6j0Q7EgIis+elvAiR0UjDijNtFGaZyYBALyD2E9Dr9VVxFzaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHKNuy4PkXrsJ/AiZemQK08LiA1edZMhCYxdGzrELKY=;
 b=BcUdy8fQRJ6zLbtiX6sTOJOxejUqA7Emd4fGnSy56WkR7Ik1jW5heR3sZwZnWwvwHWwa/C5zSDsGxTWcXiv4/t3RpxR+CwlWWkpFlXiIdb8yOxiREn0i2JVV6HkE0qmD9Ea1NHZGH+xfXsQwadlplNLb0FhJAUIOgzgc+Ny58vf6l4F1t1I45y2O6Ki+NCuHWg8RBA8NNeYCmI5/t/9CneT922qC1IxcfNnp+XRVBMK0r4LSmZWdDiVwRqK58G73MZM5ICQy4Lvt1j+HDUVC8Y7tlEPp6/O4zTFdhxTYiYOxyajKwiqY/UojFIkVwXmVqgfJZmZ5QvTcKaT67ll7LQ==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 23:59:22 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::a3fc:754b:9159:b13c]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::a3fc:754b:9159:b13c%4]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 23:59:21 +0000
From: Besar Wicaksono <bwicaksono@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "will@kernel.org" <will@kernel.org>, "suzuki.poulose@arm.com"
	<suzuki.poulose@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	Thierry Reding <treding@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>,
	Vikram Sethi <vsethi@nvidia.com>, Rich Wiley <rwiley@nvidia.com>, Shanker
 Donthineni <sdonthineni@nvidia.com>, Sean Kelley <skelley@nvidia.com>, Yifei
 Wan <ywan@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Nirmoy Das
	<nirmoyd@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Yushan Wang
	<wangyushan12@huawei.com>, "shiju.jose@huawei.com" <shiju.jose@huawei.com>
Subject: RE: [PATCH v2 4/8] perf/arm_cspmu: nvidia: Add Tegra410 PCIE PMU
Thread-Topic: [PATCH v2 4/8] perf/arm_cspmu: nvidia: Add Tegra410 PCIE PMU
Thread-Index: AQHcoOcl52v1DoC2JUuGIBHKeCyHprWJzR6AgBbTtNA=
Date: Thu, 5 Mar 2026 23:59:21 +0000
Message-ID:
 <SJ0PR12MB56768F47AE1823F77D93D8C2A07DA@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <20260218145809.1622856-1-bwicaksono@nvidia.com>
	<20260218145809.1622856-5-bwicaksono@nvidia.com>
 <20260219100649.000062ed@huawei.com>
In-Reply-To: <20260219100649.000062ed@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB5676:EE_|DS7PR12MB9473:EE_
x-ms-office365-filtering-correlation-id: 1a1951cf-2ce7-4de0-4135-08de7b13389f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 LI5Xqzr+9BIAXZcoBXL+zyEokd8yx87OXnozSpW+nkJsQpRgZRUbvPbF6eASzs3DyYIyqXQAqvQHTpU1guLKd8ljPBnjR2FCHKW8NlyFk8kcwEM6Z6/qlg5wH2cdiqWjHOWCRpzI1aPjBXIq3aFeBektdOUASqD4EYolXl2oR/t+uo5fHd0jY9Ju70fsW4MvHFBjnxsOw7IxCYXjermc3GVjaRX2SVqs05ZYRSduZBJ/zrx23TW+x6cUcnh4V2W+0Ky29Y0me7tP+zNKPofeRFnasD8kIew0s1XFo76ey79+f6HBWXXxqAbjWc4pmXJrtugJxchIIG0d8fTJ0zGI7XztUfnLcWqrFqgqbg9a1PDHlHchCmUUFFlzZaBMGtbkycpz5PcQwWQaKz4oWe9qAEqKgCHJ0LbGwS4APSxi5+aV/saG28K4i5lhXNZ0WOdi2zBnrLnMhzT5DTD/36jGc+3xkRqBlvzW5JCEuiJmwpvt1CZetBuonqlFE8h55nE5YCJ7TQN3ebn07l3ohiWjPV/t7AZ7/c19O4u+DnSy6mgIk6iakpivwAb3JPfkd8rY1uPRnfdXFxfk2utzCVCCkHamWRAGduKBrQghQ4alpOdx6ckIBwFlyEAlpp861fpFRag25JvYQ/Uxiybnc6kRNWPGlG/HBDodmI3jhMzVKkysvNwZHBwHeguKmwj76W6HjeHWkCzfb9kYLZ6kkzPqPHR8S9hFe8AF74J/dg7rWO3UettjWrcLCVnGR990euvDexvQxbj87Qvym+AOCr+yKo1Fyg/C/Gxet/ezOHLy5PA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?n8D4BvAMFJrt3vgzWKhfQrW9/BUxh+RzbJfjdtHHBftOxkPmk+tpZTqyzvb+?=
 =?us-ascii?Q?3O41MyqoBR9uvmv1k/wQ5fM8AsHOKthgtiyxuzjW57SOU+F9W8c6DDHcvzGe?=
 =?us-ascii?Q?dgLtsLg3Bkx4r01jGxnG+PpvE98uuF8D34nRKbxcvPYLNzjs6PAJIgYlEOjU?=
 =?us-ascii?Q?OyvK87oeFJzncCUFukOi3iVhN8ItySxGrquebuAoQYhzY6NKBixlMAu5dMBf?=
 =?us-ascii?Q?OfLoZrY7w47bMF2dUhL9AOz6GTDuGgNl+Jew0JMe3X/Z/Ib2IGiNhPN7rQCQ?=
 =?us-ascii?Q?xibj1OllK0vhfpSvaaDs5z6EVc2u3ayDGxygK+7ifgntF+6IKVmirh++QwGu?=
 =?us-ascii?Q?KhlJnwuSJyJFGPcYw6VCigG5Dw5PBERfwlHbq2FE3NFBDPQfgnP0jt6F7l4g?=
 =?us-ascii?Q?glXviiPDLjrNEpVc5k5YWGowTcAzAJzAjQTEmUtT4O5llptWBYlzSk+/fzxW?=
 =?us-ascii?Q?s3CkH249DHLPsETDgHHDT0keuHaYFW/zAfOzzr/bgP6YZkB/epsZn5BP2lBJ?=
 =?us-ascii?Q?FEfqs/mch4JV2n3h+81+VlRNlh62aNDpnexfiLc+p1NG8IeFTRVg/QB1iBJh?=
 =?us-ascii?Q?guFqwJldx2HnHF44s8vcYhv/1/lh7yLO3o/LPdclMGI9GG7xsDnZJCcRmTEF?=
 =?us-ascii?Q?e60NOE8YR1PMMQKl7NGWiV4c9sPmZjU2bWRHlV0MS7tqivvs+3FE6aFJNtIZ?=
 =?us-ascii?Q?EQJ3CMrNIEqgEYq0tclay5kptHckaN5LqrIqdXuctNdbP8apvJJFK59AISI3?=
 =?us-ascii?Q?fJQqz8DKCRlkG5cZb/tRbJroOE43pLdiPXVSCfcb0hoPddEkPGOfNy1xfOy0?=
 =?us-ascii?Q?LcHI5d95kQyug044MdPI4rw6cGmXy7Os5iPK+27nmWxPI1/PePnJXaWft/L8?=
 =?us-ascii?Q?cKaGpVlr6vMsjOdVX5xPYQte+MvOtLPsfx89KB8br+y/A4PE5XXGV51Pmugq?=
 =?us-ascii?Q?yRbY8wO71Tj+/Yrc3XJsvaClcst4g1QVugxvZy1Vs9dbZ2PG9WiZFOMLpNA3?=
 =?us-ascii?Q?LbMo03Uu9P7WgYYIQkeQfsdZyj5lad3IX51e7oe+2rFGPnBqSYLb2sGfSO6z?=
 =?us-ascii?Q?rBn6ZX9x5m42CZyIpuQ+rbn2D4V1CVkJYdN4NO6yHMPIbYSsR2HTt7irAaLK?=
 =?us-ascii?Q?UvpUiMbrpSxmhiq8AMF+USiamSRCHArv0S2Zp7cuJKHppWfGgjP1KxIEH7U1?=
 =?us-ascii?Q?Dfpgj1nF5DJv6NCf5RAS1aRyM8kYg4mubXGJAZHOO3O0BSa35S6uIYcyTfXL?=
 =?us-ascii?Q?L++4i1Hn1jP6qbieLn9NEqFIwsexfd3LDiNyH03O3UOOi0rAAxRCcg+ARJN+?=
 =?us-ascii?Q?2RN4rWJ9DWGn+Ypy4ADby92aVHeoRCoBZy7gkInE6TZIhqw/WdXY2Avhx7ew?=
 =?us-ascii?Q?CfWPDo9F55WD7a9dgXj4muk84rwEoXCxulo40jr0tOw3EBb/5gv1MwWpaXkl?=
 =?us-ascii?Q?rLs/cORSZt7WT3fG5OD9DkEJbjHFhFpb0NobeuXzn0RRMAxI9WcysU0c54cQ?=
 =?us-ascii?Q?ygS8vJ1eMehn1m0jlfGkgo8y4uw+yV9qY2rrbMqya4o15wg98pmYLcDEHh4a?=
 =?us-ascii?Q?ZF62OMpGajmkW4ihZCYVDkM/tXp9vEIxoAxr1K6tnkbKEwOpRcUAXbDD/pbn?=
 =?us-ascii?Q?JlAQSuLb+RInO79BuKE04Wk4/ImPB2cCuqZIrX9+9DMC5AetQXt0vhFxDUvY?=
 =?us-ascii?Q?fvzfp4IGgil4aOOJs2r4sFE6a1rQw+8s/yR7eFoMTGIgjkGZz+RDVjHlWJhQ?=
 =?us-ascii?Q?p5v7K7UaoQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1951cf-2ce7-4de0-4135-08de7b13389f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 23:59:21.7191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: riz6Rg417Z2kKXMYYj3T9A98R2EZ0f9NU7lGOxy5W+U/gPx5ytqe/THp7GlkUqggOowNAU6gkNoRfr4Z4EzVxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9473

Hi Jonathan,

Thanks for your suggestions, please see my comments inline.

> -----Original Message-----
> From: Jonathan Cameron <jonathan.cameron@huawei.com>
> Sent: Thursday, February 19, 2026 4:07 AM
> To: Besar Wicaksono <bwicaksono@nvidia.com>
> Cc: will@kernel.org; suzuki.poulose@arm.com; robin.murphy@arm.com;
> ilkka@os.amperecomputing.com; linux-arm-kernel@lists.infradead.org; linux=
-
> kernel@vger.kernel.org; linux-tegra@vger.kernel.org; mark.rutland@arm.com=
;
> Thierry Reding <treding@nvidia.com>; Jon Hunter <jonathanh@nvidia.com>;
> Vikram Sethi <vsethi@nvidia.com>; Rich Wiley <rwiley@nvidia.com>; Shanker
> Donthineni <sdonthineni@nvidia.com>; Sean Kelley <skelley@nvidia.com>;
> Yifei Wan <ywan@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Nirmoy Das
> <nirmoyd@nvidia.com>; Bjorn Helgaas <bhelgaas@google.com>; linux-
> pci@vger.kernel.org; Yushan Wang <wangyushan12@huawei.com>;
> shiju.jose@huawei.com
> Subject: Re: [PATCH v2 4/8] perf/arm_cspmu: nvidia: Add Tegra410 PCIE PMU
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Wed, 18 Feb 2026 14:58:05 +0000
> Besar Wicaksono <bwicaksono@nvidia.com> wrote:
>=20
> > Adds PCIE PMU support in Tegra410 SOC. This PMU is instanced
> > in each root complex in the SOC and can capture traffic from
> > PCIE device to various memory types. This PMU can filter traffic
> > based on the originating root port or BDF and the target memory
> > types (CPU DRAM, GPU Memory, CXL Memory, or remote Memory).
> >
> > Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> > Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
>=20
> Given I've added a bunch of +CC I've left all your patch in place rather
> than cropping to just what I've commented on.
>=20
> Great to see another PCIe related PMU, but this is certainly showing
> the diversity in what such things are!
>=20
> I've expressed a few times that it would be really nice if a standard
> PCI centric defintion would come from the PCI-SIG (similar to the one
> that CXL has) but what you have here is, I think, monitoring certainly
> types of accesses closer to the CPU interconnect side of the RC than
> such a spec would cover.  As mentioned below I've +CC various people who
> will be interested in this. Please keep them cc'd on v3.
>=20

That is correct, this PMU is more on the SOC fabric side connecting the
PCIE RC and the memory subsystem.

> > ---
> >  .../admin-guide/perf/nvidia-tegra410-pmu.rst  | 162 ++++++++++++++
> >  drivers/perf/arm_cspmu/nvidia_cspmu.c         | 211 +++++++++++++++++-
> >  2 files changed, 368 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst
> b/Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst
> > index 7b7ba5700ca1..8528685ddb61 100644
> > --- a/Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst
> > +++ b/Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst
> > @@ -6,6 +6,7 @@ The NVIDIA Tegra410 SoC includes various system PMUs
> to measure key performance
> >  metrics like memory bandwidth, latency, and utilization:
> >
> >  * Unified Coherence Fabric (UCF)
> > +* PCIE
>=20
> It's interesting to see what people put in their PCIe related PMUs.
> Seems we are getting a bit of a split into those focused on the SoC side =
of the
> host bridge
> and those focused on the PCI protocol stuff (so counting TLPs, FLITs, Ret=
ries
> etc).
>=20
> I don't suppose it matters that much, but maybe we need to think about so=
me
> suitable
> terminology..
>=20
> I've +CC linux-pci and Bjorn as those are the folk who are most likely to
> comment
> on generalization aspects of PCIe PMUs.
> >
> >  PMU Driver
> >  ----------
> > @@ -104,3 +105,164 @@ Example usage:
> >    destination filter =3D remote memory::
> >
> >      perf stat -a -e
> nvidia_ucf_pmu_1/event=3D0x0,src_loc_noncpu=3D0x1,dst_rem=3D0x1/
> > +
> > +PCIE PMU
> > +--------
> > +
> > +This PMU monitors all read/write traffic from the root port(s) or a pa=
rticular
> > +BDF in a PCIE root complex (RC) to local or remote memory. There is on=
e
> PMU per
> > +PCIE RC in the SoC. Each RC can have up to 16 lanes that can be bifurc=
ated
> into
> > +up to 8 root ports. The traffic from each root port can be filtered us=
ing RP
> or
> > +BDF filter. For example, specifying "src_rp_mask=3D0xFF" means the PMU
> counter will
> > +capture traffic from all RPs. Please see below for more details.
> > +
> > +The events and configuration options of this PMU device are described =
in
> sysfs,
> > +see /sys/bus/event_source/devices/nvidia_pcie_pmu_<socket-
> id>_rc_<pcie-rc-id>.
> > +
> > +The events in this PMU can be used to measure bandwidth, utilization, =
and
> > +latency:
> > +
> > +  * rd_req: count the number of read requests by PCIE device.
> > +  * wr_req: count the number of write requests by PCIE device.
> > +  * rd_bytes: count the number of bytes transferred by rd_req.
> > +  * wr_bytes: count the number of bytes transferred by wr_req.
> > +  * rd_cum_outs: count outstanding rd_req each cycle.
> > +  * cycles: counts the PCIE cycles.
>=20
> This maybe needs a tighter definition.  Too many types of cycle
> involved in PCIe IPs.
>=20

Yeah, this is supposed to be the clock cycles of the SOC fabric.
I will fix it on V3.

> Would also be good to see how this driver fits with the efforts for
> a generic perf iostat
> https://lore.kernel.org/all/20260126123514.3238425-1-
> wangyushan12@huawei.com/
>=20
> (Added wangyushan and shiju to +CC)
>=20
> > +
> > +The average bandwidth is calculated as::
> > +
> > +   AVG_RD_BANDWIDTH_IN_GBPS =3D RD_BYTES / ELAPSED_TIME_IN_NS
> > +   AVG_WR_BANDWIDTH_IN_GBPS =3D WR_BYTES / ELAPSED_TIME_IN_NS
> > +
> > +The average request rate is calculated as::
> > +
> > +   AVG_RD_REQUEST_RATE =3D RD_REQ / CYCLES
> > +   AVG_WR_REQUEST_RATE =3D WR_REQ / CYCLES
> > +
> > +
> > +The average latency is calculated as::
> > +
> > +   FREQ_IN_GHZ =3D CYCLES / ELAPSED_TIME_IN_NS
> > +   AVG_LATENCY_IN_CYCLES =3D RD_CUM_OUTS / RD_REQ
> > +   AVERAGE_LATENCY_IN_NS =3D AVG_LATENCY_IN_CYCLES / FREQ_IN_GHZ
> > +
> > +The PMU events can be filtered based on the traffic source and destina=
tion.
> > +The source filter indicates the PCIE devices that will be monitored. T=
he
> > +destination filter specifies the destination memory type, e.g. local s=
ystem
> > +memory (CMEM), local GPU memory (GMEM), or remote memory. The
> local/remote
> > +classification of the destination filter is based on the home socket o=
f the
> > +address, not where the data actually resides. These filters can be fou=
nd in
> > +/sys/bus/event_source/devices/nvidia_pcie_pmu_<socket-id>_rc_<pcie-rc-
> id>/format/.
> > +
> > +The list of event filters:
> > +
> > +* Source filter:
> > +
> > +  * src_rp_mask: bitmask of root ports that will be monitored. Each bi=
t in
> this
> > +    bitmask represents the RP index in the RC. If the bit is set, all =
devices
> under
> > +    the associated RP will be monitored. E.g "src_rp_mask=3D0xF" will =
monitor
> > +    devices in root port 0 to 3.
> > +  * src_bdf: the BDF that will be monitored. This is a 16-bit value th=
at
> > +    follows formula: (bus << 8) + (device << 3) + (function). For exam=
ple, the
> > +    value of BDF 27:01.1 is 0x2781.
> > +  * src_bdf_en: enable the BDF filter. If this is set, the BDF filter =
value in
> > +    "src_bdf" is used to filter the traffic.
> > +
> > +  Note that Root-Port and BDF filters are mutually exclusive and the P=
MU in
> > +  each RC can only have one BDF filter for the whole counters. If BDF =
filter
> > +  is enabled, the BDF filter value will be applied to all events.
> > +
> > +* Destination filter:
> > +
> > +  * dst_loc_cmem: if set, count events to local system memory (CMEM)
> address
> > +  * dst_loc_gmem: if set, count events to local GPU memory (GMEM)
> address
> > +  * dst_loc_pcie_p2p: if set, count events to local PCIE peer address
> > +  * dst_loc_pcie_cxl: if set, count events to local CXL memory address
> > +  * dst_rem: if set, count events to remote memory address
> > +
> > +If the source filter is not specified, the PMU will count events from =
all root
> > +ports. If the destination filter is not specified, the PMU will count =
events
> > +to all destinations.
> > +
> > +Example usage:
> > +
> > +* Count event id 0x0 from root port 0 of PCIE RC-0 on socket 0 targeti=
ng all
> > +  destinations::
> > +
> > +    perf stat -a -e nvidia_pcie_pmu_0_rc_0/event=3D0x0,src_rp_mask=3D0=
x1/
> > +
> > +* Count event id 0x1 from root port 0 and 1 of PCIE RC-1 on socket 0 a=
nd
> > +  targeting just local CMEM of socket 0::
> > +
> > +    perf stat -a -e
> nvidia_pcie_pmu_0_rc_1/event=3D0x1,src_rp_mask=3D0x3,dst_loc_cmem=3D0x1/
> > +
> > +* Count event id 0x2 from root port 0 of PCIE RC-2 on socket 1 targeti=
ng all
> > +  destinations::
> > +
> > +    perf stat -a -e nvidia_pcie_pmu_1_rc_2/event=3D0x2,src_rp_mask=3D0=
x1/
> > +
> > +* Count event id 0x3 from root port 0 and 1 of PCIE RC-3 on socket 1 a=
nd
> > +  targeting just local CMEM of socket 1::
> > +
> > +    perf stat -a -e
> nvidia_pcie_pmu_1_rc_3/event=3D0x3,src_rp_mask=3D0x3,dst_loc_cmem=3D0x1/
> > +
> > +* Count event id 0x4 from BDF 01:01.0 of PCIE RC-4 on socket 0 targeti=
ng
> all
> > +  destinations::
> > +
> > +    perf stat -a -e
> nvidia_pcie_pmu_0_rc_4/event=3D0x4,src_bdf=3D0x0180,src_bdf_en=3D0x1/
> > +
> > +Mapping the RC# to lspci segment number can be non-trivial; hence a ne=
w
> NVIDIA
> > +Designated Vendor Specific Capability (DVSEC) register is added into t=
he
> PCIE config space
> > +for each RP. This DVSEC has vendor id "10de" and DVSEC id of "0x4". Th=
e
> DVSEC register
> > +contains the following information to map PCIE devices under the RP ba=
ck
> to its RC# :
> > +
> > +  - Bus# (byte 0xc) : bus number as reported by the lspci output
> > +  - Segment# (byte 0xd) : segment number as reported by the lspci outp=
ut
> > +  - RP# (byte 0xe) : port number as reported by LnkCap attribute from =
lspci
> for a device with Root Port capability
> > +  - RC# (byte 0xf): root complex number associated with the RP
> > +  - Socket# (byte 0x10): socket number associated with the RP
> > +
> > +Example script for mapping lspci BDF to RC# and socket#::
> > +
> > +  #!/bin/bash
> > +  while read bdf rest; do
> > +    dvsec4_reg=3D$(lspci -vv -s $bdf | awk '
> > +      /Designated Vendor-Specific: Vendor=3D10de ID=3D0004/ {
> > +        match($0, /\[([0-9a-fA-F]+)/, arr);
> > +        print "0x" arr[1];
> > +        exit
> > +      }
> > +    ')
> > +    if [ -n "$dvsec4_reg" ]; then
> > +      bus=3D$(setpci -s $bdf $(printf '0x%x' $((${dvsec4_reg} + 0xc)))=
.b)
> > +      segment=3D$(setpci -s $bdf $(printf '0x%x' $((${dvsec4_reg} + 0x=
d))).b)
> > +      rp=3D$(setpci -s $bdf $(printf '0x%x' $((${dvsec4_reg} + 0xe))).=
b)
> > +      rc=3D$(setpci -s $bdf $(printf '0x%x' $((${dvsec4_reg} + 0xf))).=
b)
> > +      socket=3D$(setpci -s $bdf $(printf '0x%x' $((${dvsec4_reg} + 0x1=
0))).b)
> > +      echo "$bdf: Bus=3D$bus, Segment=3D$segment, RP=3D$rp, RC=3D$rc,
> Socket=3D$socket"
> > +    fi
> > +  done < <(lspci -d 10de:)
> > +
> > +Example output::
> > +
> > +  0001:00:00.0: Bus=3D00, Segment=3D01, RP=3D00, RC=3D00, Socket=3D00
> > +  0002:80:00.0: Bus=3D80, Segment=3D02, RP=3D01, RC=3D01, Socket=3D00
> > +  0002:a0:00.0: Bus=3Da0, Segment=3D02, RP=3D02, RC=3D01, Socket=3D00
> > +  0002:c0:00.0: Bus=3Dc0, Segment=3D02, RP=3D03, RC=3D01, Socket=3D00
> > +  0002:e0:00.0: Bus=3De0, Segment=3D02, RP=3D04, RC=3D01, Socket=3D00
> > +  0003:00:00.0: Bus=3D00, Segment=3D03, RP=3D00, RC=3D02, Socket=3D00
> > +  0004:00:00.0: Bus=3D00, Segment=3D04, RP=3D00, RC=3D03, Socket=3D00
> > +  0005:00:00.0: Bus=3D00, Segment=3D05, RP=3D00, RC=3D04, Socket=3D00
> > +  0005:40:00.0: Bus=3D40, Segment=3D05, RP=3D01, RC=3D04, Socket=3D00
> > +  0005:c0:00.0: Bus=3Dc0, Segment=3D05, RP=3D02, RC=3D04, Socket=3D00
> > +  0006:00:00.0: Bus=3D00, Segment=3D06, RP=3D00, RC=3D05, Socket=3D00
> > +  0009:00:00.0: Bus=3D00, Segment=3D09, RP=3D00, RC=3D00, Socket=3D01
> > +  000a:80:00.0: Bus=3D80, Segment=3D0a, RP=3D01, RC=3D01, Socket=3D01
> > +  000a:a0:00.0: Bus=3Da0, Segment=3D0a, RP=3D02, RC=3D01, Socket=3D01
> > +  000a:e0:00.0: Bus=3De0, Segment=3D0a, RP=3D03, RC=3D01, Socket=3D01
> > +  000b:00:00.0: Bus=3D00, Segment=3D0b, RP=3D00, RC=3D02, Socket=3D01
> > +  000c:00:00.0: Bus=3D00, Segment=3D0c, RP=3D00, RC=3D03, Socket=3D01
> > +  000d:00:00.0: Bus=3D00, Segment=3D0d, RP=3D00, RC=3D04, Socket=3D01
> > +  000d:40:00.0: Bus=3D40, Segment=3D0d, RP=3D01, RC=3D04, Socket=3D01
> > +  000d:c0:00.0: Bus=3Dc0, Segment=3D0d, RP=3D02, RC=3D04, Socket=3D01
> > +  000e:00:00.0: Bus=3D00, Segment=3D0e, RP=3D00, RC=3D05, Socket=3D01
> > diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.c
> b/drivers/perf/arm_cspmu/nvidia_cspmu.c
> > index c67667097a3c..42f11f37bddf 100644
> > --- a/drivers/perf/arm_cspmu/nvidia_cspmu.c
> > +++ b/drivers/perf/arm_cspmu/nvidia_cspmu.c
>=20
> >  static struct attribute *generic_pmu_format_attrs[] =3D {
> >       ARM_CSPMU_FORMAT_EVENT_ATTR,
> >       ARM_CSPMU_FORMAT_FILTER_ATTR,
> > @@ -233,6 +270,32 @@ nv_cspmu_get_name(const struct arm_cspmu
> *cspmu)
> >       return ctx->name;
> >  }
> >
> > +#if defined(CONFIG_ACPI)
> > +static int nv_cspmu_get_inst_id(const struct arm_cspmu *cspmu, u32 *id=
)
> > +{
> > +     struct fwnode_handle *fwnode;
> > +     struct acpi_device *adev;
> > +     int ret;
> > +
> > +     adev =3D arm_cspmu_acpi_dev_get(cspmu);
> Not necessarily related to your patch but it would be really nice to get
> clean stubs etc in place so that we can expose this code to the compiler =
but
> then use
>         if (IS_CONFIGURED()) etc to provide the fallbacks.
>=20
> Makes for both easier to read code and better compiler coverage.
>=20
> > +     if (!adev)
> > +             return -ENODEV;
> > +
> > +     fwnode =3D acpi_fwnode_handle(adev);
> > +     ret =3D fwnode_property_read_u32(fwnode, "instance_id", id);
> > +     if (ret)
> > +             dev_err(cspmu->dev, "Failed to get instance ID\n");
> > +
> > +     acpi_dev_put(adev);
>=20
> Not necessarily a thing for this series, but would be nice to have a
> DEFINE_FREE(acpi_dev_put, struct acpi_device *, if (!IS_ERR_OR_NULL(_T))
> acpi_dev_put);
>=20
> > +     return ret;
> > +}
> > +#else
> > +static int nv_cspmu_get_inst_id(const struct arm_cspmu *cspmu, u32 *id=
)
> > +{
> > +     return -EINVAL;
> > +}
> > +#endif
>=20
> > +
> > +static int pcie_v2_pmu_validate_event(struct arm_cspmu *cspmu,
> > +                                struct perf_event *new_ev)
> > +{
> > +     /*
> > +      * Make sure the events are using same BDF filter since the PCIE-=
SRC
> PMU
> > +      * only supports one common BDF filter setting for all of the cou=
nters.
> > +      */
> > +
> > +     int idx;
> > +     u32 new_filter, new_rp, new_bdf, new_lead_filter, new_lead_bdf;
> > +     struct perf_event *leader, *new_leader;
> > +
> > +     if (cspmu->impl.ops.is_cycle_counter_event(new_ev))
> > +             return 0;
> > +
> > +     new_leader =3D new_ev->group_leader;
> > +
> > +     new_filter =3D pcie_v2_pmu_event_filter(new_ev);
> > +     new_lead_filter =3D pcie_v2_pmu_event_filter(new_leader);
> > +
> > +     new_bdf =3D pcie_v2_pmu_bdf_val_en(new_filter);
> > +     new_lead_bdf =3D pcie_v2_pmu_bdf_val_en(new_lead_filter);
> > +
> > +     new_rp =3D FIELD_GET(NV_PCIE_V2_FILTER_PORT, new_filter);
> > +
> > +     if (new_rp !=3D 0 && new_bdf !=3D 0) {
> > +             dev_err(cspmu->dev,
> > +                     "RP and BDF filtering are mutually exclusive\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (new_bdf !=3D new_lead_bdf) {
> > +             dev_err(cspmu->dev,
> > +                     "sibling and leader BDF value should be equal\n")=
;
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* Compare BDF filter on existing events. */
> > +     idx =3D find_first_bit(cspmu->hw_events.used_ctrs,
> > +                          cspmu->cycle_counter_logical_idx);
> > +
> > +     if (idx !=3D cspmu->cycle_counter_logical_idx) {
> > +             leader =3D cspmu->hw_events.events[idx]->group_leader;
> > +
> > +             const u32 lead_filter =3D pcie_v2_pmu_event_filter(leader=
);
> > +             const u32 lead_bdf =3D pcie_v2_pmu_bdf_val_en(lead_filter=
);
>=20
> The kernel coding standards (not necessarily written down) only commonly
> allow
> for declarations that aren't at the top of scope when using the cleanup.h=
 magic
> (so guards, __free() and stuff like that).   So here I'd pull the declara=
tion
> of leader into this scope as well.
>=20
>=20

Sure, will do on V3.

> > +
> > +             if (new_lead_bdf !=3D lead_bdf) {
> > +                     dev_err(cspmu->dev, "only one BDF value is suppor=
ted\n");
> > +                     return -EINVAL;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  enum nv_cspmu_name_fmt {
> >       NAME_FMT_GENERIC,
> > -     NAME_FMT_SOCKET
> > +     NAME_FMT_SOCKET,
> > +     NAME_FMT_SOCKET_INST
>=20
> Add the trailing comma just to avoid the extra line change like the one y=
ou just
> made.   The only exception to this is if the enum has a terminating entry=
 for
> counting purposes.
>=20

Sure, will do on V3.

> >  };
> >
> >  struct nv_cspmu_match {
> > @@ -430,6 +601,27 @@ static const struct nv_cspmu_match
> nv_cspmu_match[] =3D {
> >               .init_data =3D NULL
> >         },
> >       },
> > +     {
> > +       .prodid =3D 0x10301000,
> > +       .prodid_mask =3D NV_PRODID_MASK,
> > +       .name_pattern =3D "nvidia_pcie_pmu_%u_rc_%u",
> > +       .name_fmt =3D NAME_FMT_SOCKET_INST,
> > +       .template_ctx =3D {
> > +             .event_attr =3D pcie_v2_pmu_event_attrs,
> > +             .format_attr =3D pcie_v2_pmu_format_attrs,
> > +             .filter_mask =3D NV_PCIE_V2_FILTER_ID_MASK,
> > +             .filter_default_val =3D NV_PCIE_V2_FILTER_DEFAULT,
> > +             .filter2_mask =3D NV_PCIE_V2_FILTER2_ID_MASK,
> > +             .filter2_default_val =3D NV_PCIE_V2_FILTER2_DEFAULT,
> > +             .get_filter =3D pcie_v2_pmu_event_filter,
> > +             .get_filter2 =3D nv_cspmu_event_filter2,
> > +             .init_data =3D NULL
>=20
> A side note that I didn't put in the previous similar case.
> If a NULL is an 'obvious' default, it is also acceptable to not set
> it at all and rely on the c spec to ensure it is set to NULL.
>=20
> > +       },
> > +       .ops =3D {
> > +             .validate_event =3D pcie_v2_pmu_validate_event,
> > +             .reset_ev_filter =3D nv_cspmu_reset_ev_filter,
> > +       }
> > +     },
> >       {
> >         .prodid =3D 0,
> >         .prodid_mask =3D 0,
> > @@ -453,7 +645,7 @@ static const struct nv_cspmu_match
> nv_cspmu_match[] =3D {
> >  static char *nv_cspmu_format_name(const struct arm_cspmu *cspmu,
> >                                 const struct nv_cspmu_match *match)
> >  {
> > -     char *name;
> > +     char *name =3D NULL;
> >       struct device *dev =3D cspmu->dev;
> >
> >       static atomic_t pmu_generic_idx =3D {0};
> > @@ -467,13 +659,20 @@ static char *nv_cspmu_format_name(const
> struct arm_cspmu *cspmu,
> >                                      socket);
> >               break;
> >       }
> > +     case NAME_FMT_SOCKET_INST: {
> > +             const int cpu =3D cpumask_first(&cspmu->associated_cpus);
> > +             const int socket =3D cpu_to_node(cpu);
> > +             u32 inst_id;
> > +
> > +             if (!nv_cspmu_get_inst_id(cspmu, &inst_id))
> > +                     name =3D devm_kasprintf(dev, GFP_KERNEL,
> > +                                     match->name_pattern, socket, inst=
_id);
> > +             break;
> > +     }
> >       case NAME_FMT_GENERIC:
> >               name =3D devm_kasprintf(dev, GFP_KERNEL, match->name_patt=
ern,
> >                                      atomic_fetch_inc(&pmu_generic_idx)=
);
> >               break;
> > -     default:
>=20
> Why this change?  to me it doesn't add any particular clarity and is
> unrelated to the rest of the patch.
>=20

I changed the name initialization to NULL, so the default case handling is =
no longer
needed.

Regards,
Besar

> > -             name =3D NULL;
> > -             break;
> >       }
> >
> >       return name;
> > @@ -514,8 +713,10 @@ static int nv_cspmu_init_ops(struct arm_cspmu
> *cspmu)
> >       cspmu->impl.ctx =3D ctx;
> >
> >       /* NVIDIA specific callbacks. */
> > +     SET_OP(validate_event, impl_ops, match, NULL);
> >       SET_OP(set_cc_filter, impl_ops, match, nv_cspmu_set_cc_filter);
> >       SET_OP(set_ev_filter, impl_ops, match, nv_cspmu_set_ev_filter);
> > +     SET_OP(reset_ev_filter, impl_ops, match, NULL);
> >       SET_OP(get_event_attrs, impl_ops, match, nv_cspmu_get_event_attrs=
);
> >       SET_OP(get_format_attrs, impl_ops, match,
> nv_cspmu_get_format_attrs);
> >       SET_OP(get_name, impl_ops, match, nv_cspmu_get_name);

