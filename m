Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012001.outbound.protection.outlook.com [52.101.43.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C700481AB0
	for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2026 21:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786568645; cv=fail; b=sBW+7c8meQelg2hjhTYtiMPLpZEtbmAvGax07gQJKISd2aeLTE5KzfVPas5NHnXiAm3mr5dPO5J6sN9P51vnQdf05adNueSwMJC2pxW6hu5oJn412B4H3k418iWejkpEBk7MmZES4cL4NkmV8VdIOJ0uufhUDcB+V8PSckFvgkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786568645; c=relaxed/simple;
	bh=cQ7WeLElogdUqTVUgauqhbHb0RHhAtDdXlkUDLkprv0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XuvuOGjrSKA7u4pViyuvKvBX6iV7mQIFpeNNhcfQo2EhPTBZS8k0o+yE9+QQpFLd7b1XTcEjRIp8shh6n3jpPQTdTxZW3d3pf7Fv39GQCGRWd6wj8KC/sROkwrfZ9mv30B1jpD1rgjPs/bFx8gafxQURbo8ICmbr/CotI0fVvKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oSOqLAK9; arc=fail smtp.client-ip=52.101.43.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oSOqLAK9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kl0aBJaNwqmQ4il42ixEZ4OA/p9OW7uJXQDSEJC/qT1Mwv+EDVspZrrkHJqxl7wz0qTGBoFIcpIjllXDxYhFyqfIrxoPGY0oKWTxoSClMRe1FpOiyZZ2TlNfTA3kiNNsvGJJnN3Q80a1Hb6J/1tC0/0wT1oxiZisiUBrEvsw90rThs1D/TGJxuKufkkEih0hoTT+UoJFWZs5VmOWyvpT1x4ZmFH+oYOi2ASgTxN0FRVD+TB1BPQbOq+q6nYZeRAa41CXvc1Bm6Sis022UNFQ6DcCT9TMtBTP6AJ4GExxlbuM55jA9hhZVp4n5JZEtIPQ2g9rMhYqqvWj+W30WffEkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EKIUNu+yMAf8b0IkBY5C6R4Tz44B9HmA/ucLdOOoC4=;
 b=ghgNYriA4Lb7MhiGZ49Nhl2I0ldi8W7XSn5zLj5o5KFLfUhGx0p4olyqB36aaKA7QI7c//4c/tGceIOUOEmCoFs4f9yxCQC9dZX49Sn6IWsgPVfNuP+0GJ2oELEI7OWJ4RMejoDnJWLGTChPHwf4iPa+1UXXlfIXxoEGD3/JLsYMDQkf3HQuz3adfmqtaqZP/J7FWU0nfBUAGDrZM07yXR3z/VuJI3kW8//bX8nosohhReuwbUX1lbhfFf1jWNBB+iShhxt/rHaIol/ndCaLZbEs3RenFTVYQUfl+mZzwn6hBcEpIAknGQAwxAwBAK2VYAh7OZrkgwt+LcE4jdF2FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EKIUNu+yMAf8b0IkBY5C6R4Tz44B9HmA/ucLdOOoC4=;
 b=oSOqLAK90onOhCCzmLeotMcaY0Djzk9W24K1q8Ft3oK79yWgMJOYbPEJWat1TiIHgD691WgVLmbGotX4XGAUNyzgYLuXTzxyPQ+CGyXKTzmUSCxSikFSFsruGjoQ8j8QldFBMzjosnVG+SGA4AB29YIA6mRmplqQVDLToO0iUlI=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 21:03:58 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%3]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 21:03:58 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: "Hegde, Vasant" <Vasant.Hegde@amd.com>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org"
	<joro@8bytes.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "Suthikulpanit, Suravee"
	<Suravee.Suthikulpanit@amd.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"Longia, Amandeep Kaur" <AmandeepKaur.Longia@amd.com>
Subject: RE: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
Thread-Topic: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs
 only
Thread-Index:
 AQHdGmrXXVaTvXvBoEGo7Q2TpyKmibZ8ya8AgAP/o4CAAK8DAIAA7JgAgAAKzQCAAOUFgIAADS2AgAKVz4CACMDmAIAA4oQAgAAtKPCAAAlpAIAABJCggAARRACACxOBUIAACoiAgAAAudA=
Date: Wed, 12 Aug 2026 21:03:58 +0000
Message-ID:
 <BN9PR12MB5146253D30587DC820486F4FF7DC2@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <2f400c7f-eada-45e3-9079-7b5727ecb5c3@amd.com>
 <bacdf160-8ab2-4bd6-aa9d-ab63b16527fa@amd.com>
 <08f2e48e-6e98-4fde-af71-cb8cde666bdf@amd.com>
 <20260805010706.GC28508@ziepe.ca>
 <39ce2a2f-3bb8-43e7-9446-a67551cce104@amd.com>
 <BN9PR12MB5146934D584CF0A2A9DD8CFCF7D32@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20260805175308.GD28508@ziepe.ca>
 <BN9PR12MB51467229315BC8D731239E80F7D32@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20260805191116.GE28508@ziepe.ca>
 <BN9PR12MB51463D56248A4DE952E6DCA2F7DC2@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20260812205737.GG662699@ziepe.ca>
In-Reply-To: <20260812205737.GG662699@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-08-12T21:00:18.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|DM6PR12MB4234:EE_
x-ms-office365-filtering-correlation-id: 2108afc5-f4e2-4e82-2c1c-08def8b53a30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|5023799004|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 kijmW2f8BxE+rTdwRpM9wWjPmqV4yrz+QQhayFMw9hRCGKxYLDvkHwshh3C+5kGV05JtDbAAztJFp/83f3bqiIuhKdNoMvG6W5eZ7QD7jhmN0vYEhZlAyWOhiVr0YqyhqS5wFdTQ53yJ8JH2Na8HchS9NsvDq/IEmcFXVJ68He0Lim9BmoQYmb3tat1DzV5IoToTWcn9K5SegzJibOGYYZ3Re3N7pLqT2YOVay7+EIyn6icZyfSn/usmD4Guu34QgrQR5dqDTT28C14B5OPZqKbjFRV/aUPiBRTk9gF//GQ7e9AKqpp6rkHICbHf4iyG+n27JceVhhwDHUQ7u41Z9AdQyNyRFq+93hXhDSZu43L87LRl7Y4vrvxrR8WiaGD29jHYAS/jvJNsTZep3+6KzqU9dhUxNZAIclsoUPUJ21vRp2TO220x8Fc5oFPtiW4+9qKUPgW5CyrgvDE4JWCFhhDWudNovomAJ/s9mlZvdrgvdqrEUDWDmQfBWU+aDqXz+nGRqrSueurAw6NHgW0MnFxbMB/i77/e00Jfb3nlftgAeg86SsbVI9Ti93CDVrTjEw6YF2gZw4aGxNeZxoFKOoGQ6ZdY/n0IGugz7Y3c1EMuVrvfL2HZ5NJ6XII+7fcd3oKvaXJMcF+ypVLJvK8IvC5aYGu5wKeQQUFQDlJdf4l9BDEQBJMCqOGvUBnsUF7vga/fGlTO8GqwW5cTyk268TEi9CYZ15jvPjl/G+1HR38=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5146.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(5023799004)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?N6XVgMipf1yKalBia7IEa2GezpFeSR669Xbd79dTQd8TcainR0qYiMekCuF8?=
 =?us-ascii?Q?46G4Cw4UzmagKcuAw1aZeAmoDM5ht9K684qrmbFRfLfvK0Y/B8fgDsIsVET4?=
 =?us-ascii?Q?8kfvhQzfzJ6f9SEBTkVGlHOQti6i1BY4c1upoauGy0aWZgxCNnet1juTNhbC?=
 =?us-ascii?Q?+Fw/dQfz0C9+ZpStdO3S9aYDLncXdnv6G80VWbISOwaEKt0d/QYKsXK5ff5J?=
 =?us-ascii?Q?tolko3WgNXZ9RB59JxipBVGUr86sC3wmJ1KJ6PsTr5eipMTbEEI4rGPi3J3i?=
 =?us-ascii?Q?auotD8lwZpsbqcH5LaohLDVLBoFxF0WLckTPyclwWpmyTC8d8+bNfCFbVuCi?=
 =?us-ascii?Q?4C1VHhG4MW/5jdRibwSkJBBCJfgmY2rrQjlXlarLTK7Ygd8Prx8GZRDZFR1U?=
 =?us-ascii?Q?Nr2avzYM0jjZheYr9cuUfN4HhJ33aqtf4eijSIGQj87r839Z2EcAQsTYVO5T?=
 =?us-ascii?Q?zNk9UGOApug5aB7fH0Kpca/hB7vfOSXd4HVNFca4RPN7YQoo2Bl9WRISdnoU?=
 =?us-ascii?Q?Ac881oBTiFc3Tol8wQq03nAwdK276m2HfSUfr+NUvQbLQG/MmDIvxXvQqZdE?=
 =?us-ascii?Q?tK6VSTrDCdNNtzNZg6c0OpoA69tvcGAjgR02iHv9gQxbEqyOMWNlc/3VUfzH?=
 =?us-ascii?Q?rcZtoVqAfqjovTFVacIKczCaKHrhG2K+6OGp+E0BwzkOtYYxVvd1Is/1HBWB?=
 =?us-ascii?Q?d6CW2QNnwwj0EMKNFe3b8Pw9rLmr73hKunvHjOTvCP86OGr4cuOA47b2symJ?=
 =?us-ascii?Q?f/KThWh0ZNVRhZi8K9H2/MKeyCZtwK28JhXywS+4Gsrucp6rjbiDobw+EnsY?=
 =?us-ascii?Q?yJvA1Jz+S5OEWiG34NlIPzVSM4HUf7GmzFEyV31FesQwh3YgqTK5diQ2wMmS?=
 =?us-ascii?Q?6ZAR1jlxdqAHkf3YCBtGYCwJDn3e3sRBm7rdKm/mJ00+z6HF1KrAQ0EHDzlw?=
 =?us-ascii?Q?//O9HI+Mhsgth/vP5N3w+94AFjtOrQ5qkMZpQh1btLqHjMdTqGb75LcSbFR7?=
 =?us-ascii?Q?2Ge48QUrm0HQZCPkHk+lNUDwikehSvsETQZhsPG2w6Ob9flbJyUTtAJyjj/b?=
 =?us-ascii?Q?XbxEnMC12bwqxie/4HScecPNphJv7TT19D2L3Zya5YUvKGqN0d+NhocLEEgt?=
 =?us-ascii?Q?AqiS0yzrKGaJb2TE50ZIucYyoNWS2yGQ+VeDJYKCyjfKbaZ13weAIbwXtlxF?=
 =?us-ascii?Q?HafLM655MW6xOEBC5XIcs0Az621XPkR6itApmDREhR4/h8VDAM1Zaloe/xbl?=
 =?us-ascii?Q?DPmmNyD9J4V+uNyg8u8gXD4ACycNwlKeBiUTqR+71Yk78G9MJgTqdT1g1zr4?=
 =?us-ascii?Q?cX7NWtnGNUucQF1t0W57rrXj0NU2/8Yg7EeWYWc7A3yXc+jCGmDnvfHl49dK?=
 =?us-ascii?Q?b2wk9CAoRuvwm6I2Wq8EHf2goki6CIuA4F4pTFGrRcfEc28K7qD025Gi4a5o?=
 =?us-ascii?Q?KA5NIwtB+sEWmZm9HskqcPxDSjwkUNg7vna/9uHHPsseR1GIEz1QqoSHieZo?=
 =?us-ascii?Q?pAexjud9RrOYyIpRWZUxVFtMo2DOgjqOi4J8MqOwdn6BsD3aaX7fIDIN8XZc?=
 =?us-ascii?Q?FICjH0MxdjcUn6sOCQ3nIUngBh0ztXS4lkYouqrbGdf2EFbqhrslJ6kvYWzL?=
 =?us-ascii?Q?uLHDSfoXd7tL70XcAKFg/EjJwDWfVq0hyKGG5dH1uP9hUdfXB1id61tE5yV8?=
 =?us-ascii?Q?gYr4ttIbMV047N8U0+FP7NrVoWppORfLJQPhe7c5QjNvA8Oy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2108afc5-f4e2-4e82-2c1c-08def8b53a30
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 21:03:58.1470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HdYaVgFqxBNE1awrKUG6fVZDtnUZQ1wEf0UHSWtbjLndEaJIBuWWwbuBACZc8/ZKC4YqcSiJZNjx80pEjLX/jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234

Public

> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Wednesday, August 12, 2026 4:58 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: Hegde, Vasant <Vasant.Hegde@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>;
> iommu@lists.linux.dev; joro@8bytes.org; linux-pci@vger.kernel.org;
> will@kernel.org; robin.murphy@arm.com; Suthikulpanit, Suravee
> <Suravee.Suthikulpanit@amd.com>; bhelgaas@google.com; Longia,
> Amandeep Kaur <AmandeepKaur.Longia@amd.com>
> Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs
> only
>
> On Wed, Aug 12, 2026 at 08:29:24PM +0000, Deucher, Alexander wrote:
> > AMD General
> >
> > > -----Original Message-----
> > > From: Jason Gunthorpe <jgg@ziepe.ca>
> > > Sent: Wednesday, August 5, 2026 3:11 PM
> > > To: Deucher, Alexander <Alexander.Deucher@amd.com>
> > > Cc: Hegde, Vasant <Vasant.Hegde@amd.com>; Limonciello, Mario
> > > <Mario.Limonciello@amd.com>; Kuehling, Felix
> > > <Felix.Kuehling@amd.com>; iommu@lists.linux.dev; joro@8bytes.org;
> > > linux-pci@vger.kernel.org; will@kernel.org; robin.murphy@arm.com;
> > > Suthikulpanit, Suravee <Suravee.Suthikulpanit@amd.com>;
> > > bhelgaas@google.com; Longia, Amandeep Kaur
> > > <AmandeepKaur.Longia@amd.com>
> > > Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected
> > > GPUs only
> > >
> > > On Wed, Aug 05, 2026 at 06:12:05PM +0000, Deucher, Alexander wrote:
> > >
> > > > > On Wed, Aug 05, 2026 at 05:22:22PM +0000, Deucher, Alexander
> wrote:
> > > > >
> > > > > > IIRC, they supported SME, but it wasn't usable due to other
> > > > > > limitations (e.g., the requirement for identity mappings due
> > > > > > to the display hw bug and the latency impact of encryption for
> > > > > > displays in system memory).  Do you could effectively pick
> > > > > > either SME or
> > > displays.
> > > > >
> > > > > IMHO the GPU driver should fail if it cannot work because it
> > > > > can't reach the IOVA space requried for SME ...
> > > > >
> > > > > I don't think this should be a iommu problem to deal with
> > > >
> > > > That means no display for the user which is a not a good user
> > > > experience. Most users of systems with integrated graphics would
> > > > probably prefer displays over SME.
> > >
> > > You said IOVA translation doesn't work at all on these devices due
> > > to a bug, so what is the iommu even supposed to do? It can't select
> > > identity because the device doesn't work that way and it can't
> > > select paging because it doesn't work that way either.
> > >
> > > Or are you saying paging sort of works enough to do something half-
> busted?
> >
> > IOVAs worked fine for everything on the GPU (gfx, video enc/dec,
> > etc.) except for displays.  You could avoid the problem by limiting
> > displays to carve out, but many of these platforms shipped with so
> > little carve out that that it wasn't feasible to use carve out for
> > displays beyond the UEFI splash screen.  That's what we did on Linux
> > initially until lots of OEMs started shipping platforms with minimal
> > carve out and no way to change it.
>
> Sure, but the end result is the GPU and SME are inherently incompatible, =
we
> can't really fix it.
>
> What's wrong with blowing up at boot with a clear message that Linux must
> have SME disabled on this HW printed to the UEFI console?

It's not very user friendly, plus it would break working systems.  I'm not =
sure the average user would know what to do.  You aren't likely to want SME=
 in the first place on one of these laptops.  Why not flip the logic and pr=
int a clear message that if the user wants SME they have to explicitly enab=
le it via the kernel command line.

Alex

