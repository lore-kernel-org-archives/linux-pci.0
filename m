Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B3439792B
	for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2026 20:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566570; cv=fail; b=e7wwc78YThmx0ZXRza7bpsCzO4k73y+PppG1OiGoKb02ed6A+Nd4DboiZWvKtuSM1ZapIvTzxiOT9DWWhKoXFn6V7XBO5Ts9z3FS3ytJ95LMRFGHQYL0qZzqulvGn1DRgD+529fnu3qwlEqJ/CqLGvScStdnrDKT71UlX0S2zFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566570; c=relaxed/simple;
	bh=UQtz1ka/aY01Q8/Nmv/TO7hKVuXRLoy2XasWpPmyP3Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UO6eIQrg0uHxFiWQPb2SU8NpPjNK21oLLhbub3NX1hHKuJGus9UuqWrGYIs7s0hONMZcyHtKtBk1tmlTx2WvGgdMzr5N6ChFBBZd/QPJS5piiCf226Q1d6EKdI0d6v473BBk/kJge8TjTZl/AktDlrZ8j1xeSbQRDfVHfpNultE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GGudsVKn; arc=fail smtp.client-ip=52.101.62.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GGudsVKn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1u+BzcKkzSAMYtQVHnbjd2NGb3L7YGlT6ijUY2l18u/mIPql8Tvup8ORTy9X3wf0PqHcR6MgxzcySGF8ecZG1L5wdwBUlJL4EO0fLF8oFS8Y0CA4/PnbPhOsEgTsCVepXUQed1onlHJW0laMma/o78OL0+tw09oJq/YpYC3ZOV4V8QFswaN+u25nCAOD7n+oGw20TCax/4UwIlQv9Q+hxiCzisWQUkKYK09HV+soJhBE1lXudNi4sNT8mCawiCHzbYyLp3Ul6mVUWS0MF+tLPcsAKgBOhfV0GHRVw+8l4qHpiJYRxhzJzKwAAr1XR9IC9al7Ad5ag2curlbC16hmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oB1Sqi2BG9pc7l8SsXUyoq+/O3PYwk5SKOvxHKFSETc=;
 b=SXR/dPMg2kxN64E+37zp9dxGcBEhQXii0Hi6UNRW9DqD7lSaP+qpOzaHcKFX3W5Nk9/vT0jj8zHM4uH7RUQoE10i76eP6zS/mY/82MJtelsGjWrVsr1ghMY+TMTkYS4joeZzU8QQcqyDottVxeZ4N7vUPAWQypMyZtVJ9Dxamhaem5KMhUUQ1rc8fIETBchE3PsvPYv8D/BifUSDg39xCfxQVZIgu7zUhJUAGgy3fHlRsdO7FQ5ky5q5qxt1yU59+lNz3KdnUCwUOQej3K4kFsUwPTCMxgBJ/QgiELT1V4K4A1gXgIojn5YXJj+uphhOOVVLrlQ+3BPPgocDu2/2Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oB1Sqi2BG9pc7l8SsXUyoq+/O3PYwk5SKOvxHKFSETc=;
 b=GGudsVKnbuzMHUEAFyMF4p3/x+wyy51cvcouMfEYlRYYBBuFmctHagebjvgrIri6yjiEVyGzVpsBxwOSHyCyjkumaXXuP2hm2Vfh9A5hC9UrXLU/qmp4MOfH9cOIVYiF1L3a//OOcs3AAyMZjsYl26/I0XCs8fU75RL2PnXJFG0=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by IA1PR12MB9063.namprd12.prod.outlook.com (2603:10b6:208:3a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 20:29:24 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%3]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 20:29:24 +0000
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
 AQHdGmrXXVaTvXvBoEGo7Q2TpyKmibZ8ya8AgAP/o4CAAK8DAIAA7JgAgAAKzQCAAOUFgIAADS2AgAKVz4CACMDmAIAA4oQAgAAtKPCAAAlpAIAABJCggAARRACACxOBUA==
Date: Wed, 12 Aug 2026 20:29:24 +0000
Message-ID:
 <BN9PR12MB51463D56248A4DE952E6DCA2F7DC2@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <f4355034-d40a-4d11-ab98-eef0f2991f33@amd.com>
 <838281e9-8ee7-433a-b06c-68675e9b285f@amd.com>
 <2f400c7f-eada-45e3-9079-7b5727ecb5c3@amd.com>
 <bacdf160-8ab2-4bd6-aa9d-ab63b16527fa@amd.com>
 <08f2e48e-6e98-4fde-af71-cb8cde666bdf@amd.com>
 <20260805010706.GC28508@ziepe.ca>
 <39ce2a2f-3bb8-43e7-9446-a67551cce104@amd.com>
 <BN9PR12MB5146934D584CF0A2A9DD8CFCF7D32@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20260805175308.GD28508@ziepe.ca>
 <BN9PR12MB51467229315BC8D731239E80F7D32@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20260805191116.GE28508@ziepe.ca>
In-Reply-To: <20260805191116.GE28508@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-12T20:19:55.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|IA1PR12MB9063:EE_
x-ms-office365-filtering-correlation-id: 3f833b8d-3be3-49f2-43fa-08def8b06606
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|38070700021|10067099003|5023799004|11063799006|4143699003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 jJ81hiKxi2lDSCktT1CnMDESepY4OYTYSuyXGA54s7kTxT+bOCPh2yAnEA1c3r739TKbw+zlM7h64UT7A4YmskXm5FxfMpgIXGzPM5g4SisNwUp4lICCnMUuPjte4fOWu+d0XbF21MvstMlkukljrZ1r/z3m1JixcqOtbvgCBudCbxQDr/Vv0NiFy0tHQ/iopMt8RVRinbHXmaH8AkOFcKtlcLFhHzV04FyGebaMc3B1+yhFpVRuoJuiWA/WHtmEnoG4q6gxpwxr5GiZ9qRoTphRn/wQQ5P9XoxU6QcHrMikf6x/AX1aeMxu8+HpnmS9lM2GIQ8ZjoRc5nV1/P6aXJ3S0SQd29jt3ipgMIF9oZs7MFnRuo1oaewVg/y8nexRj5iOMTzz+K3VbkB7Wcxt6ft4SerjK0LRDPKMVJI0RZna9qnZrSY7OmBC3pU8nCjZ5+Y6xulz2cAfk6MdZ/NhE0YkV8q154PLd4kyVi+jwG7Rkr9Ev3plmfIov1KRS8uku8e2cnBM62W93nt19fGTygj7UqjrwPTSl4XF86k3yNAGz1EfEx9JLhTV+moZm6zAHj/nT0MeDGk01mcT0jlMLdLRhnwLG9Mx8HbNJU52/GcIhYyzrKJCtPUOveiqjb1UO/t5j8LXWJfZGSTkThSTGfv5jwW2BGAqENZzgMMoG9AJl8H1ivOerqoJXICAyyDJ7FqPyuRUNRJB1FTDrunbthzgdE7znLr2O8dwjT7wdiI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5146.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7HI1Prxr+DNsmA4eLJ/NewZOBmJ1WJMx8kz0U0xJiz3SpunpQpy0ZRBLXv3I?=
 =?us-ascii?Q?DgmEhLi/wqAo/nWPTLMfVA2pR32CVt6MMnbHfs+BXarCUkq5gKkwpHLZ+JZt?=
 =?us-ascii?Q?HyqkWoQkgPjsyr32biesbefkXJljVwKe+Adss+KR48vpNDrsCPU8+fQDf+g3?=
 =?us-ascii?Q?hTaeNwkAG6yZwTRB1rrM5TOElA1N1GbdSZnAFaeKVRoYJEwg9A/8ScdN+Ter?=
 =?us-ascii?Q?yM0hTTgNlqw4zUw92ACVxZDu+s10+VdCRR8MTbiDOACoCaW2+BoGAaa7148c?=
 =?us-ascii?Q?fGCWSoah4aXKMZLQRfjOxomlF6F3YAlx/sOXinp0eLmZNuBfoVpbDwfAcC/C?=
 =?us-ascii?Q?/grreNcCztWexyVuFdSsJQNeeEPWSgS9h96710MawPvFOxFlPyDofHqhL5zy?=
 =?us-ascii?Q?dreBmsz2ExSuu8DpPVYSMhl1sXoo/cPtoLmooag6MisX24ntpwGqUlrr3IjJ?=
 =?us-ascii?Q?LrfXuzlPVogbEKqb0/d4d9OXh0gkEaoDdmt0hZ9JM8Of3/RcojBn4fKXANZy?=
 =?us-ascii?Q?EgQULDf9ILkINQTfsj73zuSFj/9mcPmaFOe7Ee5R7KCE6RyDexxS3bqm2YqV?=
 =?us-ascii?Q?RFSg7YYdi2lCZq7GWIKWNqKUyOyGTxE2Xq0cj6rO0B4rf8BdytH1/d/18A77?=
 =?us-ascii?Q?aa+HCAaG3PauNQQlKVxZV2QLO1fDsvumW7zpSUSIfkBvkarxxZ0ueYG4MFs/?=
 =?us-ascii?Q?Jw+N69gqoOiUWVityl8TV0LoNEWQGqk4MLrblQMhjWg21J2o4u9yqnHLfIZP?=
 =?us-ascii?Q?7FrlIMuxiMEpFYB/Ehdm3LMnfUGx5Q1a5cdWtWB89oOYX5MrEVFdWbAf1QxB?=
 =?us-ascii?Q?VwLWL7GYAZiES5Dp7Qhrkv4YTTBvhkhjgy9Httb7lC2DD8OK9ciWoQgwjlmt?=
 =?us-ascii?Q?HU1cNx0cXnCgq1HUNDv6m/YWjK9pOhyg0b4C/CSU2AswkeAhZGwtim99ideh?=
 =?us-ascii?Q?kG+bNPQNXqYd9rQBGWojMMM7uuOp0YteexTikuRJ/APWxqI39G2kOFIEQSo6?=
 =?us-ascii?Q?E/dysDOUVhkTtrhBDAjGnlgBxMA+KtNx4IAloScz/bliR0TNvSLQjHPgbtc2?=
 =?us-ascii?Q?EhiDX8CHXmWlD9g0LNZEQ6GRoqXfCsCdJh1b9KB2Pn2WGC1qIquPy/gGOeIy?=
 =?us-ascii?Q?U0Wlf3ysRSLuoxLqBhsyu26drMhGAnzPiQJtnCWPDSYV13bT0WTySs+wz9t0?=
 =?us-ascii?Q?t+/nQK57NppXM6AIHk9iUzOOW5zsmM6RUUPNb+XBJOCyPe70go0l+mYCONHW?=
 =?us-ascii?Q?OH4vbTZgQJLonwHC8eq5eAcM3PeIVGhC0DXTZhOQ97YDStQT8upJrbKBa8K1?=
 =?us-ascii?Q?o9VKa61IZ7LodJ8+E80wrosih5Sz7q0cBJbjjOa4VgFiO5Ui36d3uHAIhO2K?=
 =?us-ascii?Q?qPb1qsG1DKvc2c/ak8AElZF+exksa/PX+IANorhzOKVkRw9HspHZ73bdYsCs?=
 =?us-ascii?Q?98QKx38f9KrCTYlh40fZKEBaXf7XiAmmXp5qYLXSz6LRVTQg8OdQBLqORlLN?=
 =?us-ascii?Q?R7ewVOPhDQ1GkYk60XkNGRqKk7lVcZ119rglRWx3RASRFi2VpGqZpNaiHDYP?=
 =?us-ascii?Q?m1OQOAvBzLL/Gp5ZJZt9Sb5IOMjjSimtuYGcpps96morJ19BPn/ryDKNrqkK?=
 =?us-ascii?Q?26i1HbqQtBfdE/qkUQ1U27UUqexcUmeiZpUrRUGl5o1q7F17M1/xtBbHuE2f?=
 =?us-ascii?Q?pf1r79J+g4LYyt4NGIrpjc0FDOw3wGIbJrZKRU64w2XfcNgO?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f833b8d-3be3-49f2-43fa-08def8b06606
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 20:29:24.2383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: meptvDjhXskKyyfYFpMIPPczKfQ583CuDTjcF9M1HcD4AHGCoX6NC6t1iCtE1W1cUor+vRGILL+NeNPnKTawDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9063

AMD General

> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Wednesday, August 5, 2026 3:11 PM
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
> On Wed, Aug 05, 2026 at 06:12:05PM +0000, Deucher, Alexander wrote:
>
> > > On Wed, Aug 05, 2026 at 05:22:22PM +0000, Deucher, Alexander wrote:
> > >
> > > > IIRC, they supported SME, but it wasn't usable due to other
> > > > limitations (e.g., the requirement for identity mappings due to
> > > > the display hw bug and the latency impact of encryption for
> > > > displays in system memory).  Do you could effectively pick either S=
ME or
> displays.
> > >
> > > IMHO the GPU driver should fail if it cannot work because it can't
> > > reach the IOVA space requried for SME ...
> > >
> > > I don't think this should be a iommu problem to deal with
> >
> > That means no display for the user which is a not a good user
> > experience. Most users of systems with integrated graphics would
> > probably prefer displays over SME.
>
> You said IOVA translation doesn't work at all on these devices due to a b=
ug, so
> what is the iommu even supposed to do? It can't select identity because t=
he
> device doesn't work that way and it can't select paging because it doesn'=
t work
> that way either.
>
> Or are you saying paging sort of works enough to do something half-busted=
?

IOVAs worked fine for everything on the GPU (gfx, video enc/dec, etc.) exce=
pt for displays.  You could avoid the problem by limiting displays to carve=
 out, but many of these platforms shipped with so little carve out that tha=
t it wasn't feasible to use carve out for displays beyond the UEFI splash s=
creen.  That's what we did on Linux initially until lots of OEMs started sh=
ipping platforms with minimal carve out and no way to change it.

>
> Why did AMD even offer SME in the BIOS on these systems if it doesn't eve=
n
> work and turn it into Linux's problem?

These were client products running windows and windows enabled neither IOMM=
U nor SME at the time.

Alex

