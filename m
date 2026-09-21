Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013017.outbound.protection.outlook.com [40.93.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B10457E6F;
	Mon, 21 Sep 2026 09:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984712; cv=fail; b=TyyFAi1OJ2iaC+GY1ZoCdam+SnXfY1X0veNTbeHMUzmdUZUUMP9w31bN2sdG14fCx2fS6mRz2r1ygN4yOZe2Um0976A5BB/mDlpVEWdsz/C9AzxvEGLDY4CcXm+vJKh4RrmRLDDKXisCFsROA0LhQ+pQRBKtVxnnhMTBLh3zwGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984712; c=relaxed/simple;
	bh=nzzMT5o1xqDhDv/eCkcbrpaMLy8W6HbMVHiXZ/Oedo4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d48DUgtUILBU8kJeoOZHzu1ApYt98YDpImNpXHGZ4obW6LA/kabIZH4m88lpmEhdJmItqlJ+yqlknVVqseBmKOPsSpMMOatkHIHUOHWlLwllFR5bvtoPvRQdxQN38O2kESJ+KrHxetYH6d3s6JgQfRkwzV4hW+6jCG8Krdvax8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rp3XkHnA; arc=fail smtp.client-ip=40.93.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rp3XkHnA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8AQXF4MaXAsUdTe9DQ57IZty0O715oTeH+zTJt6S87cAaQ3xK/vWtS7lO4Cleu29VmDyzJ+zXG2tEy93HsRaTzhI2vri/5K6vtWLxwVKvXLybIlaZmePey0/ZvsSPC/5ztkgf9AtbN0PtH4h+t0DjKCwYUQGldV1iKSiV/vVvh7fR8HYzsvEZgsqNJ4sv+PQ9u1cvSbD8vLsNtREcuUR9WJG7EOFazALZGw+6Z2l5xBeZWiWLTu35b+3yUd4lmE0yAPreTkJe4UC+v3LlBm+3L+UVawTlAl6A3DGFiqDgnXaLA78yT63CKxRBsrUsr+Q6b8t6Db1wKvTafuh83DYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nhb/2cwYTRQ4GVoWc6rLo2wgkCB1hd9lVMfmoZ1HWik=;
 b=p/hAhVSh57AvRmfkvUtQwe2fXLj5hikRxvKHRpH+407V0M+C9rGZC27hNhO7/J/8Sjrxia7mKE471xbWwHV2bwCnkBzOievbfZ8j5J1n+WBfhcg0+EJT3lgU460O7Fha7yt5993CtgLi05km4p+MgXZHdJJ4ePvypCRmfFEt7gLfUV/DbhZjWt0C8dJjianNPkLimdxPEKXSjWLhc+7JkuEX5q9iEWTiwOn12mAmiN/gEa5cYzUfiz5Ug6gJGuler0oQfGp6rFXnQpLkFouqgqLX/F30Qs49vETVNCzGSoNKPSMJJMKiA2zuAZdxWEhYuVrC+U8Dpq8J/JkACryCPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nhb/2cwYTRQ4GVoWc6rLo2wgkCB1hd9lVMfmoZ1HWik=;
 b=rp3XkHnATHs/+72bsdEKRWuavfAoK2wz1y7eZjhOIRs00Yg1/Y8izf6OvPAQ/6e3/F0PL4MKozAlotIAEv8yU0qIuTqGqVzpGSOwc0VLQPKKgFjBPOrI72oKk9Q852y8eY69oZ0JXKThX1imMqT49C1ONrAWI6mOA8/M40o6CnMwWK5vzttFtCchSiqUxEJURPgfpY3mZO5kLkQ08oH7PQKOz9D4OZIaLBde1izWIELmKK5IgwBcOSnZQGeBbBessPoCyTC1MRmybtjZ7Li2alzV+ppkQ9A1DxZYIBubHmHFbHxKbXqqp3xz1NHcAN8vzYqSIwIWrhASsV+rdpDHXw==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by IA0PR12MB8974.namprd12.prod.outlook.com (2603:10b6:208:488::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 09:58:24 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 09:58:23 +0000
From: Manish Honap <mhonap@nvidia.com>
To: Richard Cheng <icheng@nvidia.com>
CC: "alex@shazbot.org" <alex@shazbot.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	Ankit Agrawal <ankita@nvidia.com>, "jic23@kernel.org" <jic23@kernel.org>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alejandro.lucero-palau@amd.com" <alejandro.lucero-palau@amd.com>, Srirangan
 Madhavan <smadhavan@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "iweiny@kernel.org" <iweiny@kernel.org>,
	"ming.li@zohomail.com" <ming.li@zohomail.com>, Yishai Hadas
	<yishaih@nvidia.com>, Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "dmatlack@google.com" <dmatlack@google.com>,
	"kees@kernel.org" <kees@kernel.org>, "gustavoars@kernel.org"
	<gustavoars@kernel.org>, Neo Jia <cjia@nvidia.com>, Krishnakant Jaju
	<kjaju@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Zhi Wang
	<zhiw@nvidia.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, Manish Honap <mhonap@nvidia.com>
Subject: RE: [PATCH v5 24/27] vfio/cxl: Export the HDM memory region as a
 dma-buf
Thread-Topic: [PATCH v5 24/27] vfio/cxl: Export the HDM memory region as a
 dma-buf
Thread-Index: AQHdRgrZTjLdWfOzhk+c622+TE9nlbbSZ7IAgAZrDkA=
Date: Mon, 21 Sep 2026 09:58:23 +0000
Message-ID:
 <IA1PR12MB9030641A2CDC768DDB53BCFEBD842@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
 <20260916183540.3813685-25-mhonap@nvidia.com> <aquaxVHh2O8SUCvj@MWDK4CY14F>
In-Reply-To: <aquaxVHh2O8SUCvj@MWDK4CY14F>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|IA0PR12MB8974:EE_
x-ms-office365-filtering-correlation-id: 9b98f968-9274-4cda-ccaf-08df17c6dffb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|4143699003|38070700021|56012099006|3023799007|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 3G4ovS+N/HuLERAhs9rq6tUHcAaek9LBhwjTJ1uBbqLBf88/LwosJRvEH4Isr5TPiGQ49h9I9ETwhR6+KnG7gj+ZmHN9XdtcRBjWtyBL86DSwOXmfKKbCVR/qUC5ywI7/IEljK3E3Lg/zU8bFc6VAQGS7XvW1Hr+r6HHpo2Sh15r8Cc3hLi43EEZ1V8zS0oXQCqco6CBtqUSyaDEknO5LVVKuN/TtNDDQLQf+C9Shiv/bULnKCpUlhZYR+0GjGZTUR9RSquE8miLOBOPCqEDD/fUe/nBLejbKqFDjRL768EERhEiAbxDKjyrYytKjLAfsQ3c4X0OevYAjE7+pwhukknn2erFxWAC6cI598APb0+EFFGqpbqJd0BTrYZ6KMbw3MiShmFD83Tv/hVcsOXAR41Nel2MYi5G1jZo6frIZm67f0hxGuG9aXijXcIHx5YLKg8AlNkB/RiHTBaPOYEHQdX7skrXT/iRoh1lW0uP8qqu23o1G6DfhHHH/TSq/QppiDF7g5H+W8FTU+wANyw0IS4PUj/14H+ul1rjeAzJE7TOENT5E66KNc5AN7n3JwAT+YBwlHP+2ILrcY5z2rm3z+MxuDor0GC6xsTbsd17byfw4QPF4z+aXXOza06cnIiib/Q8jNJAvsHrVtPiwhN6l0w2PuOrxTzT30odiVC/qdOwttytVwKPFj04jHMxNH70IwoaMkdoDk/SS1zEEiyPmzhcJ2fHFYP3gZ/Ha9X3HYo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(4143699003)(38070700021)(56012099006)(3023799007)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MRWpdG6pj9LRwpUQspc4S+lQHGfU3Kbn5SM1iJFteymfmGNeoYBtTWNflpop?=
 =?us-ascii?Q?FOI11CVJuaPc5NRz8NuzoN+R6FjaCrigIj5YbN3zYov2N8saysTfGbAkEp9f?=
 =?us-ascii?Q?sINsXxzQGWL9T8XEgSbBUlr4NvovqEglw2WNYl64IyEIZI4dyJzYhNUkLd4E?=
 =?us-ascii?Q?ZX4Gdb4U3NNPHZfJv4fPTpxeb5A3Xh58U9c3A8HkD3Hx2ZirZw5/9gldjK+v?=
 =?us-ascii?Q?KCRZ5QFeCb+06RovaXTA908aWeJxOu+T8tZixAPyugBsOnG0uT4VjjIYwx7m?=
 =?us-ascii?Q?vPc2/ajxM8s885bQl1Ss7QtNWYGhl1Vn3cTDo/weFc88C/qtFlOdj+8um5dM?=
 =?us-ascii?Q?R8yWKqVLyrGk1NTIxGDxnK0jC+Dutf7j4zz9MZgqtYV7lvp//jY1Jz1hGC6T?=
 =?us-ascii?Q?L3mh+4FMVHC4vpmwWx3Wl75OoV/yshCyfk50S+r0rBxGrkymzYjFxzA8+0li?=
 =?us-ascii?Q?b8sEZ5gBfiYBdbZGJ0tOG/uGW/U5ye5fXr8jM0GDQqyIEQYmhBWoa+j1Hi2C?=
 =?us-ascii?Q?bF6JeuWTQRkGJyeMEnE6XTLE1cRaV9y/BZeFeDqDqP/ATzJBAUnHVAP4S/nW?=
 =?us-ascii?Q?fIMaLshaDYm+O/GmArH1+SqCKMhHnViQYyK/RjzwrkszBhhRydUMG8F4gQt/?=
 =?us-ascii?Q?oVy+8EEP4JjCXAMbQ6r8BOeawZK8qrQuB2Rnifba7oOanrCJzNPEOYDT9i36?=
 =?us-ascii?Q?o4q6xj8IiWysk0JBUkShT4LrUy8L+5r+CN8SnEhXgpLmdKHuhIHrZ2XVffNa?=
 =?us-ascii?Q?wmBd/tYoQrE3D/j20kQDMB0Hz0AcrPqyMnYfXwuENe3zKra/ffnicXMXQNeU?=
 =?us-ascii?Q?iT3kEGQgbO1rFCPwzc0IBTDYga21TxPC7YX/gKpcSyG7Wl4gOl1W5IZMg9Wv?=
 =?us-ascii?Q?+WEt5UrFieY5BHdbFSTfHNfO8zD+bjbrTj11bHgfgze6+PKktE7uqF1YWU+A?=
 =?us-ascii?Q?Q28ZVk+x6AicvNQV9KhgxY7RexdI4+RhWYPi7IPQTkJhNKUnsww/h5uJWYAk?=
 =?us-ascii?Q?/xy15VFqEPJEIVGv5rJEsnivy1O5LKgqhkqTPyxiSmwmVvj3VNTO8vPrs7AW?=
 =?us-ascii?Q?9QVqaZoWYUA8p6+4cEnxCEAHAdFIY4CQfuEIfOYKFxEtSdDNvkpvCKuDQRPl?=
 =?us-ascii?Q?CyGrI63YSJ5PdZvudtjGILH9dicFFZ7Q4DsYiml8O02R36CzPNS5sWHN274W?=
 =?us-ascii?Q?3TWAVH4EBlyodvtadA7TlPzLTJHWDc24C+qIsbTW+xMtkO3ve9XHxww/+5/B?=
 =?us-ascii?Q?bUJX28mLgUKG7bDD/xV8jo9ZJQK33ZGtEn+dzl4Qy4t5v/tE4nCma2nSut/H?=
 =?us-ascii?Q?dhodWNWmfZPQIcEn1CdTHsyRVju2aAkl4nItilYompm8/y0uXXC6lWYXhVwA?=
 =?us-ascii?Q?LYoemAkmFlBJTlZlt9xv8gHBWpHb0WtPTKq2a1kZJs4fPuraHHxngNcg6vEl?=
 =?us-ascii?Q?Q0yQln4HHshC/poRCrDXX1fp6IBcSCCRuJzRovyjreKm4m9GqQK71+qIGphi?=
 =?us-ascii?Q?A9jj7xauC1ioTkS2yq64VAU4kOUdxbBvU2AdrL4A3Zjp0Tdycu+N3LhQhvam?=
 =?us-ascii?Q?jR0F3xhsfkfvAKgKvPGCa1gNz2twHOlJwQjEritVAH4Mip3BrreWevxKjkvD?=
 =?us-ascii?Q?aL7PGUgAuh10qoECV+lpwdD5y3kh7QzJ6rG0dj8+2niVTCZaVv2XlBcKwOqu?=
 =?us-ascii?Q?/Tjcc4Ef9RxGKVwqiPxTAzUW7wp6LnTQiC1S64E1fBVnSfQh?=
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
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9030.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b98f968-9274-4cda-ccaf-08df17c6dffb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 09:58:23.8240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: POhPd4FNHqjSw8eylaDyYSOftRjFjqhof+70YPVrOcYeFkUb7n/IV+nUmxLejnVmnAeM/dFvnjxZieoc2tybxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8974



> -----Original Message-----
> From: Richard Cheng <icheng@nvidia.com>
> Sent: Thursday, September 17, 2026 1:25 PM
> To: Manish Honap <mhonap@nvidia.com>
> Cc: alex@shazbot.org; jgg@ziepe.ca; Ankit Agrawal <ankita@nvidia.com>;
> jic23@kernel.org; dave.jiang@intel.com; alejandro.lucero-palau@amd.com;
> Srirangan Madhavan <smadhavan@nvidia.com>; corbet@lwn.net;
> skhan@linuxfoundation.org; dave@stgolabs.net; alison.schofield@intel.com;
> vishal.l.verma@intel.com; iweiny@kernel.org; ming.li@zohomail.com; Yishai
> Hadas <yishaih@nvidia.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; kevin.tian@intel.com; bhelgaas@google.com;
> dmatlack@google.com; kees@kernel.org; gustavoars@kernel.org; Neo Jia
> <cjia@nvidia.com>; Krishnakant Jaju <kjaju@nvidia.com>; Vikram Sethi
> <vsethi@nvidia.com>; Zhi Wang <zhiw@nvidia.com>; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; kvm@vger.kernel.org;
> linux-cxl@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kselftest@vger.kernel.org; linux-hardening@vger.kernel.org
> Subject: Re: [PATCH v5 24/27] vfio/cxl: Export the HDM memory region as a
> dma-buf
>=20
> On Thu, Sep 17, 2026 at 12:05:37AM +0800, mhonap@nvidia.com wrote:
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > A Type-2 accelerator issues ATS-translated DMA to addresses inside its
> > own HDM window, so that coherent host range must be present in the
> > guest's IOAS (the iommufd IOAS backing the nested SMMU stage-2).
> > iommufd maps a struct-page-less range only by fd, via
> > IOMMU_IOAS_MAP_FILE over a dma-buf; a userspace-VA
> IOMMU_IOAS_MAP of
> > the HDM mmap is rejected because the VMA is VM_IO | VM_PFNMAP.
> Without
> > a dma-buf the range could only be mapped through an out-of-tree PFNMAP
> work-around.
> >
> > vfio-pci already exports BAR memory as a P2P dma-buf, but the exporter
> > is BAR-only: vfio_pci_core_feature_dma_buf() rejects any region index
> > at or above the ROM index, and vfio_pci_core_get_dmabuf_phys()
> > resolves the physical range from a PCI BAR. The HDM memory region is a
> > dynamic device-specific region, not a BAR.
> >
> > Let a device-specific region reach the device's get_dmabuf_phys(): a
> > region index at or above VFIO_PCI_NUM_REGIONS skips the BAR-resource
> > check and is validated by the driver instead, bounded to the regions
> > that exist. Install a CXL-aware get_dmabuf_phys() in the vfio-cxl
> > provider that returns cxl->hpa_range for the HDM memory region and
> > delegates real BARs to the core, keeping the BAR path unchanged and
> > the core free of CXL knowledge.
> >
> > The HDM window is coherent host memory with no p2pdma provider of its
> > own, so borrow BAR 0's, matching nvgrace-gpu's handling of its non-BAR
> > device memory. The iommufd importer does not consume the provider; the
> > scatterlist map path (real peer DMA) is left to a follow-up once
> > upstream grows a negotiated interconnect for coherent CXL memory.
> >
> > Assisted-by: LLM
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/cxl/vfio_cxl_core.c | 60
> ++++++++++++++++++++++++++++
> >  drivers/vfio/pci/vfio_pci_dmabuf.c   | 27 +++++++++++--
> >  2 files changed, 83 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > index 5fe8e35c63c4..55fa1f86850d 100644
> > --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/mm.h>
> >  #include <linux/module.h>
> >  #include <linux/pci.h>
> > +#include <linux/pci-p2pdma.h>
> >  #include <linux/range.h>
> >  #include <linux/slab.h>
> >  #include <linux/uaccess.h>
> > @@ -27,6 +28,7 @@
> >   * @hdm_regs: mapped HDM decoder registers, read live by the decoder
> region
> >   * @hdm_len: length of the HDM decoder register block
> >   * @hdm_valid: true when host CPU access to the HDM range is safe;
> > under memory_lock
> > + * @mem_region_index: vfio region index of the mmap-able HDM memory
> > + region
> >   */
> >  struct vfio_cxl_state {
> >  	struct cxl_dev_state cxlds;
> > @@ -36,6 +38,7 @@ struct vfio_cxl_state {
> >  	void __iomem *hdm_regs;
> >  	u32 hdm_len;
> >  	bool hdm_valid;
> > +	unsigned int mem_region_index;
> >  };
> >
> >  static unsigned long vfio_cxl_mem_pgoff(struct vm_area_struct *vma,
> > @@ -289,6 +292,50 @@ static void vfio_cxl_release_hpa(void *data)
> >  	release_mem_region(cxl->hpa_range.start,
> > range_len(&cxl->hpa_range));  }
> >
> > +/*
> > + * Resolve the physical range that backs a dma-buf export. The core
> > +exporter
> > + * only knows BARs; teach it the HDM memory region so a guest IOAS
> > +can map the
> > + * coherent window by fd (IOMMU_IOAS_MAP_FILE) instead of the
> removed
> > +PFNMAP
> > + * work-around. Real BARs stay on the byte-identical core path.
> > + */
> > +static int vfio_cxl_get_dmabuf_phys(struct vfio_pci_core_device *vdev,
> > +				    struct p2pdma_provider **provider,
> > +				    unsigned int region_index,
> > +				    struct phys_vec *phys_vec,
> > +				    struct vfio_region_dma_range
> *dma_ranges,
> > +				    size_t nr_ranges)
> > +{
> > +	struct vfio_cxl_state *cxl =3D vdev->cxl;
> > +
> > +	/* Real BARs go through the core P2P exporter unchanged. */
> > +	if (region_index < VFIO_PCI_NUM_REGIONS)
> > +		return vfio_pci_core_get_dmabuf_phys(vdev, provider,
> > +						     region_index, phys_vec,
> > +						     dma_ranges, nr_ranges);
> > +
> > +	/* Of the device regions, only the HDM memory window is exportable.
> */
> > +	if (region_index !=3D cxl->mem_region_index)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * The HDM window is coherent host memory, not BAR MMIO, so it
> has no
> > +	 * p2pdma provider of its own. Borrow BAR 0's: the P2P properties
> match
> > +	 * and the iommufd importer does not consume the provider. The sgt
> map
> > +	 * path (real peer DMA) is not supported for the HDM window.
> > +	 */
> > +	*provider =3D pcim_p2pdma_provider(vdev->pdev, 0);
>=20
> I think of a weird scenario which might make peer DMA work, not sure if t=
hat's
> possible.
>=20
> userspace can give this dma-buf fd to an NIC driver or so to do RDMA ? us=
e
> HDM memory as network buffer ?
>=20
> If that's the case and direct P2P addressing is selected, it applies BAR =
0's bus
> offset to HDM physical address.
>=20
> Maybe explicitly reject peer-DMA mapping would be safer ?

Yes, I think this will require handling.

For v6, I will tag the HDM export with no_peer2peer and vfio_pci_dma_buf_ma=
p()
return -EOPNOTSUPP for it, so a peer-DMA mapping is refused cleanly instead=
 of being
handed a wrong address.

Thanks,
Manish

>=20
> Best regards,
> Richard Cheng.
>=20
>=20
> > +	if (!*provider)
> > +		return -EINVAL;
> > +
> > +	return vfio_pci_core_fill_phys_vec(phys_vec, dma_ranges, nr_ranges,
> > +					  cxl->hpa_range.start,
> > +					  range_len(&cxl->hpa_range));
> > +}
> > +
> > +static const struct vfio_pci_device_ops vfio_cxl_pci_dev_ops =3D {
> > +	.get_dmabuf_phys =3D vfio_cxl_get_dmabuf_phys, };
> > +
> >  static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)  {
> >  	struct pci_dev *pdev =3D vdev->pdev;
> > @@ -483,6 +530,19 @@ static int vfio_cxl_open_device(struct
> vfio_pci_core_device *vdev)
> >  	if (ret)
> >  		return ret;
> >
> > +	/* Record where the HDM memory region landed for the dma-buf
> export. */
> > +	cxl->mem_region_index =3D VFIO_PCI_NUM_REGIONS + vdev-
> >num_regions -
> > +1;
> > +
> > +	/*
> > +	 * Override the device ops so a dma-buf export of the HDM memory
> region
> > +	 * resolves to the coherent host range. This is done at open, not ini=
t:
> > +	 * vfio_pci_probe() resets pci_ops after vfio_alloc_device() returns,=
 so
> > +	 * an override installed during init would be clobbered. Only a CXL
> device
> > +	 * reaches this hook (cxl_ops is set on init success), so a fallback =
to
> > +	 * plain vfio-pci keeps the core ops.
> > +	 */
> > +	vdev->pci_ops =3D &vfio_cxl_pci_dev_ops;
> > +
> >  	ret =3D vfio_cxl_add_region(vdev,
> VFIO_REGION_SUBTYPE_CXL_COMP_REGS,
> >  				  &vfio_cxl_comp_regops, cxl->hdm_len,
> >  				  VFIO_REGION_INFO_FLAG_READ |
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > index c16f460c01d6..436c616d5b66 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -178,6 +178,15 @@ int vfio_pci_core_get_dmabuf_phys(struct
> > vfio_pci_core_device *vdev,  {
> >  	struct pci_dev *pdev =3D vdev->pdev;
> >
> > +	/*
> > +	 * This resolver only handles PCI BARs. A device-specific region inde=
x
> > +	 * (>=3D PCI_STD_NUM_BARS) would index pdev->resource[] out of
> bounds via
> > +	 * pcim_p2pdma_provider(), so reject it; a driver that exports such a
> > +	 * region installs its own get_dmabuf_phys.
> > +	 */
> > +	if (region_index >=3D PCI_STD_NUM_BARS)
> > +		return -EINVAL;
> > +
> >  	*provider =3D pcim_p2pdma_provider(pdev, region_index);
> >  	if (!*provider)
> >  		return -EINVAL;
> > @@ -227,6 +236,7 @@ int vfio_pci_core_feature_dma_buf(struct
> vfio_pci_core_device *vdev, u32 flags,
> >  	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> >  	struct vfio_pci_dma_buf *priv;
> >  	size_t length;
> > +	u32 index;
> >  	int ret;
> >
> >  	if (!vdev->pci_ops || !vdev->pci_ops->get_dmabuf_phys) @@ -
> 243,13
> > +253,22 @@ int vfio_pci_core_feature_dma_buf(struct
> vfio_pci_core_device *vdev, u32 flags,
> >  	if (!get_dma_buf.nr_ranges || get_dma_buf.flags)
> >  		return -EINVAL;
> >
> > +	index =3D get_dma_buf.region_index;
> > +
> >  	/*
> > -	 * For PCI the region_index is the BAR number like everything
> > -	 * else.  Check that PCI resources have been claimed for it.
> > +	 * A fixed region index is the BAR number; only a BAR can be exported
> > +	 * and its PCI resource must be claimed. A device-specific region (in=
dex
> > +	 * >=3D VFIO_PCI_NUM_REGIONS) has no BAR resource and is validated
> by the
> > +	 * device's get_dmabuf_phys instead, but the index must name a
> region
> > +	 * that exists.
> >  	 */
> > -	if (get_dma_buf.region_index >=3D VFIO_PCI_ROM_REGION_INDEX ||
> > -	    IS_ERR(vfio_pci_core_get_iomap(vdev,
> get_dma_buf.region_index)))
> > +	if (index < VFIO_PCI_NUM_REGIONS) {
> > +		if (index >=3D VFIO_PCI_ROM_REGION_INDEX ||
> > +		    IS_ERR(vfio_pci_core_get_iomap(vdev, index)))
> > +			return -ENODEV;
> > +	} else if (index - VFIO_PCI_NUM_REGIONS >=3D vdev->num_regions) {
> >  		return -ENODEV;
> > +	}
> >
> >  	dma_ranges =3D memdup_array_user(&arg->dma_ranges,
> get_dma_buf.nr_ranges,
> >  				       sizeof(*dma_ranges));
> > --
> > 2.25.1
> >
> >
