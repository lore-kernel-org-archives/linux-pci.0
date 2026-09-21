Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013003.outbound.protection.outlook.com [40.93.201.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3B03E1CE8;
	Mon, 21 Sep 2026 10:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984919; cv=fail; b=GCWiMPF7Xf+HPH7M1uAH32SCFckUXkAMMeOVZWH/F4TzKx1kOuUstZYK1nLq9i4C36JBF8aV54HwG48PjXy9x3ZYp8lmez23qLr1efukgZVK6tB5UnSlI22VaihQvWm+WgJG4NzqLX7qlUtux1sZHYDA0DoCKnbcLmg9tbrpaMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984919; c=relaxed/simple;
	bh=5MQzsy/xfzlVqoGsZiT82FYqOHI5uG85BcQCP6FKxQA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ql0XbOaosttcXH7OPE1+nFPDIQv0y72xcpyXoSzUizoBRUTR2GXXHlwy3D7/AqVNxqiTpiwtyL+Fe7w0UeopTgxfaWPjzJQ4rHD9WCtpx0HuVmwj/yL05RRogJVNjrovC2CwtsyHXklVSwP3pNrb7UPGyGcy5H/roopNCaJHT0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HRtQ6INy; arc=fail smtp.client-ip=40.93.201.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HRtQ6INy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAKA8yMQEwWtThtsR6a4GOlzOyup2SLZFPzrtvNklslqG4oWSmdcrTU628Oh03wJqg2qOZqEBh4y50lzgBmV5eDU+UN7NOJ9Q5xY9Ta/1Mogquop/MD59FBdt2FbYPjKr1DI0HvCRH6lF+svJHn2M9svSa675qz/SHxwTKgmXWXDXmhrGozxst5uNjJzRAMe9pNaZ8R50D7j6iJaBuisAYj0iz3OnvpKq/ZOAgokN6tP3evOAJfQ0D0ZrUvuvvJ+mU7SLDl/sAFEAI4ujcB5d9CMbkiX/Byse3UF+7PZImzeyMLL2/jVdSDv3BNPCtmww83UtkWSto0seigAdl1tTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBR5i/o7j3XwyDHXPyV9WdMq+9u63SSG5IA/+pGs0IU=;
 b=RTkuzaXjPxBc5BxEjifuxmECRH1us3AGLo4KWicPDzeypHAZlLeVIW2pHBHizUT3CxNWRSZgPQ6+vql1XeEs+wibB9mCCiKuI6HGsKjesyTuP3iQBCIliDwsjQN9pKJuk3vhkQQhJC399bHbzrIC/U6D8QO23V1EKDGmHu+a+dr2ZBPyBLygATgAdeE6pdmeQwPkF42iOtJZfvLUE8DXtUo4lt8iPBUszqqYcgymyFtg2dMcT8Fq1cIXkh6Dzi/EQOEUPdXGL676FzInBcRBurqqYCmDDcSE0mLnL+qw0K0W+mnilpcy5yPmF5ivxovegiTNl0C1Hs5bALZ1d/GGiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBR5i/o7j3XwyDHXPyV9WdMq+9u63SSG5IA/+pGs0IU=;
 b=HRtQ6INyhSyvDRGZo6DD+hMXEZzGN4+oy+wvM8H1fnBeq6/o83c/kTMFuYYdWKla/WS9KQnbrxDqlYN+2hmX63FMX1lzS0c6SoP0taPD4OT/Xom/9pRNNYzTCVToNoavy+eYOyXfqiIwFqgHXJR0HYiRQ6DZavjOiahBsmpwXdO21i3lS4b29uHXFY6Whf0dQUCccuy+7mfv4sLgiY+ZxFpIxRrrTNQaNSX4desib+XSOEE0739/Wg7c937wobWX8hNX/0+ePRsQ2lNqQi3bukKOs6kNG90gMQg9LQflOWtUqH/86B8exOoIs/AO8AF91nxAc7cVzOID45nza7kaew==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by IA0PR12MB8974.namprd12.prod.outlook.com (2603:10b6:208:488::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 10:01:50 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 10:01:50 +0000
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
Subject: RE: [PATCH v5 25/27] vfio/cxl: Run the CXL reset at the vfio reset
 points
Thread-Topic: [PATCH v5 25/27] vfio/cxl: Run the CXL reset at the vfio reset
 points
Thread-Index: AQHdRgres5Ma1HVBlU6C3tbUNuoztLbSbDEAgAZnT9A=
Date: Mon, 21 Sep 2026 10:01:50 +0000
Message-ID:
 <IA1PR12MB90304D1E7A9A12835398BBA5BD842@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
 <20260916183540.3813685-26-mhonap@nvidia.com> <aqugLQM43Up9pJsQ@MWDK4CY14F>
In-Reply-To: <aqugLQM43Up9pJsQ@MWDK4CY14F>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|IA0PR12MB8974:EE_
x-ms-office365-filtering-correlation-id: 965c0ff5-697b-4e8f-a4bd-08df17c75b17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|4143699003|38070700021|56012099006|11063799006|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 jMZeKHSe9r8rVQFvxJi2FFmVnqNohySnVa+CQKhW5TvXj96mYUDDLQn65O6+M+EwoZ/g0kZqEUD7y27tjCKYlA0xGg6FUoZ6FkaacNqGqfVkguviJbHnN/9eeVpSeMhK6ZVcyD+xj3DWFa1qwcJ3CYDA8s4ZQL+I52xDwX74hezsI9bbHVnUT9uc8vPh9+oZfX0eaZsaHOCthO9QXgaxXEDI048XzvYkBlVWyRL33b+qZoDPQ+9sZCj217TQwxqP9hBZGayS24JvxZcEbM2v1reiHravf3R1xIhGmq7KYNlwZ63jgTXanpNoDUjEZUQLbjQwZ18zpGI/v42Kxsxnj+mtVmzakrW2aUrzKQo/aqCM1+W7MAsY49bBiMASECXEWpYjnn3dzRSPPh4o3YpaFbN+10OUArH3Vm15rKp/ylWrQPia+PJSQBCHYD6JeRYFkKn7osDYMTcqR95RpqJkqV0xP8QzmS2omXVkGPwVRpkBk3PfX+kDM/dc98xgwavQWkCn2GPEwg9gBwXT4lGz3UIX3vM2ib83ec1KG3Dx1X0PGKK4HGKe3zmA4OgQZ5rzPZsIF0HfYjRTYhGupjh/+mDSF45iGTMY2NZqTsRDiynLeqq/WD5jmMdPpTpOVH3a+QJURHf+8bu4u4rwBsGiWdK0pXSDbW46OfHSKZ67Iab2Cq4nvws3VNMFGuXDzPLLiuskYrc1W2sfyvq66wr4wlUwn3ElhVAoJ8hcPooagyc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(4143699003)(38070700021)(56012099006)(11063799006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?is77/p24x3KzGYKO+2lPVFz1EJ6cxH2tSThNw1gIxiJy4bLMLc4ij2hb5yKU?=
 =?us-ascii?Q?bhZG7HxPdxG+YwZf8YPmvd7MtDCDjrp2ImtaaMd4TPYZXQYfZbof1kG14BGc?=
 =?us-ascii?Q?f4fWzhUCVquZof/+Dc4Ka+22bYguoxqrtrwpsDmIxGB9hkTDrR2TTT3CqjNN?=
 =?us-ascii?Q?vzVLEc5OOG0t9f5n3ha24v/5NCLuW/FinLE6FWNg60Csnai7UBpBTS26Htcx?=
 =?us-ascii?Q?xXvm7QQOSRPF75vIll1GxbbMAHexyFG4a+ISzjdt7rmND/sRnJQnJf/MoY/H?=
 =?us-ascii?Q?IYm9AzUWjM+tLaTCxkWpQCoA9PoyT8rdi9kmKTEkuPoqXwJx1g5Lw2X4GadP?=
 =?us-ascii?Q?/opid3pqANBoeD7hG5H2/nl10R8uQxqzUn0UsB5QrLRkB/7DrhNF0JoQuJ5g?=
 =?us-ascii?Q?bZdTXijzUQGQ+TkGpEMsz7oQku8r4obPtXKdP+NHaukY9v7G3l0loF+G+uJ2?=
 =?us-ascii?Q?86g+y6Bbm3GpdKg5Hz6FyAv37R+WnapLqiLXZQvfSt4eEHYq1g+AiI2pBCOu?=
 =?us-ascii?Q?pzjXWT+efQadM0puIReOb2oK83oN+65Tk7ky/+OSPsT5fpynnOqmi3wmrlA5?=
 =?us-ascii?Q?H+uwR39hiV8jSvWVjvZNDTxTUFQwZRdXKt5ehGNZmDYCo2NAUjKRDa54aVYH?=
 =?us-ascii?Q?aqc0q4V4rzNIwBECL69MN1MoNIvs5XzUoq+wPRQkBnBTviagbnRWjhflmHtc?=
 =?us-ascii?Q?y7N7ezyZ1t9agrq06RKM33eD/MAsikCGIFHimTgHJSoHYgjTwlNa3hopI9Cg?=
 =?us-ascii?Q?GlLWMG2KIs15+viO8LCIr76TvnvOaDE3JOjqM9KYBuNT0DI3jTgm9fVPv1zn?=
 =?us-ascii?Q?94yFeqrOb3tTUuYDduXCz7G0GcmJ6X8k4M8oyHUnP3vKMSREvXRALJxA1hMc?=
 =?us-ascii?Q?W2YVTQMyEPOMHwNH76I7Py8zP7BKMkv6jru3ZNBTP1FPCeKSc6gPRgoHfDW0?=
 =?us-ascii?Q?JBS2bHb7aTPhcIJBBTsrS9SfrRqVGtG3q19NIFftH3Hf3d42qJ2Om7lGy6S+?=
 =?us-ascii?Q?z9lNhgFRosc/B28N+6nGXfweIMMnlfMOyhO2pqlWfrIMJn9IGTBf/YyLfsUy?=
 =?us-ascii?Q?FVrhfIMGfLzVJ4GfIl0nfE+QcLEoW+7rzCBOZQ2oRqJz9eTJCWK2wD5w2CKb?=
 =?us-ascii?Q?w2IUMol3hNe++6Qk13/meohNA3+bos6lw3yGVZzZUBHvFf+WsBMN9Rgiwc2i?=
 =?us-ascii?Q?ln1ehC2mMJlMbMfuTeJCXXM+DS5MCLmrBWUsy0oJCSXZpUpNAa4/0iCdYYzi?=
 =?us-ascii?Q?qluFS8YHVNJjeGjB63cct1mxLht58BCDgRAZZQ03F5zIBn/gFwhH9ASnEr9f?=
 =?us-ascii?Q?mH5pzEO7w23TNEk65ax/CEaJ0g2pbsJq28SdrvTwGGjc2T0aFXvcXYBOkcIJ?=
 =?us-ascii?Q?TAo4ZZ3fHd7FGM5wCN4nYrZKqnGy69F3HH+IrYwXRnwf0H3bDkewyKsU3Y0H?=
 =?us-ascii?Q?OxOoAjAJz/A/Bbl+Ns28yX39DZNjz0IZyRGHagRK/J0gDgyaK50JzPV2wMrs?=
 =?us-ascii?Q?3kAts7eCs8i/dbbNBFqPkV2twlKEMQBp0dG5sbTYi3WqhZDmtKPAoHtVLL6J?=
 =?us-ascii?Q?cLpdUnwu5rUI3/h5/DEGDNvC/m6UvIBTZKTU3OLhs3pnWLUfLPMLpVPP//nw?=
 =?us-ascii?Q?oHdL1zJjWkYqwRV248g46e/ovGDbARsLsaDCimT7b8SBptp189i63lHfXxLk?=
 =?us-ascii?Q?h1Cl5w661PSnUWLUVcv/8mRmogMq2qphHKbL5SKA6A1xvCrG?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 965c0ff5-697b-4e8f-a4bd-08df17c75b17
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 10:01:50.3466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dPG+zjxLMbIKSN7Z9ZIElGl2PwGmhiuQanyvAv8OVAtyVdBUQuYDJFkg4hagRzCA2YwgZ0h3UW0elX+Zt5/iQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8974



> -----Original Message-----
> From: Richard Cheng <icheng@nvidia.com>
> Sent: Thursday, September 17, 2026 1:41 PM
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
> Subject: Re: [PATCH v5 25/27] vfio/cxl: Run the CXL reset at the vfio res=
et
> points
>=20
> On Thu, Sep 17, 2026 at 12:05:38AM +0800, mhonap@nvidia.com wrote:
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > A CXL Type-2 function must not take an FLR: it resets the coherent
> > CXL.mem state and corrupts the HDM decoder. The PCI core already
> > reflects this, ordering cxl_reset ahead of flr in
> > pci_reset_fn_methods[], so a function reset of a CXL device runs the
> > DVSEC reset sequence rather than FLR.
> >
> > Route the vfio function-reset points (VFIO_DEVICE_RESET and the
> > virtualized PCIe/AF FLR writes) through a CXL reset op that runs
> > cxl_reset_dvsec_sequence(). The sequence resets the function, always
> > clearing device memory, and restores the HDM decoder and PCI config
> > state, so it is a complete replacement for pci_try_reset_function() on
> > a CXL device. The op runs under memory_lock and not the PCI device
> > lock, so
> > cxl_reset_dvsec_sequence() can take the device lock itself.
> >
> > Clear hdm_valid for the duration of the reset so a fault cannot insert
> > a PFN into a decoder that is being torn down, and restore it once the
> > sequence has put the decoder back.
> >
> > Assisted-by: LLM
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/cxl/vfio_cxl_core.c | 41 +++++++++++++++
> >  drivers/vfio/pci/vfio_pci_config.c   | 49 +++++++++++++++---
> >  drivers/vfio/pci/vfio_pci_core.c     | 77 +++++++++++++++++++++++-----
> >  drivers/vfio/pci/vfio_pci_priv.h     |  1 +
> >  include/linux/vfio_pci_core.h        |  4 ++
> >  5 files changed, 152 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > index 55fa1f86850d..795362aea344 100644
> > --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > @@ -632,6 +632,45 @@ static void vfio_cxl_reset_done(struct
> vfio_pci_core_device *vdev)
> >  		cxl->hdm_valid =3D false;
> >  }
> >
> > +/*
> > + * Run the CXL DVSEC reset sequence in place of a PCI function reset.
> > +A CXL
> > + * Type-2 function must not take an FLR (it would corrupt CXL.mem),
> > +so the vfio
> > + * reset points route here. The sequence resets the function, always
> > +clearing
> > + * device memory, and restores the HDM decoder. The caller holds
> > +memory_lock,
> > + * and this path does not hold the PCI device lock, so
> > +cxl_reset_dvsec_sequence()
> > + * can take it.
> > + */
> > +static int vfio_cxl_reset(struct vfio_pci_core_device *vdev) {
> > +	struct vfio_cxl_state *cxl =3D vdev->cxl;
> > +	int ret;
> > +
> > +	lockdep_assert_held_write(&vdev->memory_lock);
> > +
> > +	/* Host CPU access to the HDM range is unsafe until the decoder is
> back. */
> > +	cxl->hdm_valid =3D false;
> > +
> > +	ret =3D cxl_reset_dvsec_sequence(vdev->pdev);
> > +	if (!ret)
> > +		cxl->hdm_valid =3D true;
> > +
> > +	return ret;
> > +}
> > +
> > +/*
> > + * The HDM dma-buf may be armed only while the decoder is valid.
> > +After a failed
> > + * reset hdm_valid is clear, so the generic memory-enable re-arm must
> > +skip the
> > + * dma-buf rather than map DMA onto an unrestored decoder.
> > + */
> > +static bool vfio_cxl_hdm_active(struct vfio_pci_core_device *vdev) {
> > +	struct vfio_cxl_state *cxl =3D vdev->cxl;
> > +
> > +	lockdep_assert_held_write(&vdev->memory_lock);
> > +
> > +	return cxl->hdm_valid;
> > +}
> > +
> >  static const struct vfio_cxl_ops vfio_cxl_ops =3D {
> >  	.init		=3D vfio_cxl_init_device,
> >  	.release	=3D vfio_cxl_release_device,
> > @@ -639,6 +678,8 @@ static const struct vfio_cxl_ops vfio_cxl_ops =3D {
> >  	.close_device	=3D vfio_cxl_close_device,
> >  	.reset_prepare	=3D vfio_cxl_reset_prepare,
> >  	.reset_done	=3D vfio_cxl_reset_done,
> > +	.reset		=3D vfio_cxl_reset,
> > +	.hdm_active	=3D vfio_cxl_hdm_active,
> >  	.owner		=3D THIS_MODULE,
> >  };
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_config.c
> > b/drivers/vfio/pci/vfio_pci_config.c
> > index 9a020a768055..8a5a737efa31 100644
> > --- a/drivers/vfio/pci/vfio_pci_config.c
> > +++ b/drivers/vfio/pci/vfio_pci_config.c
> > @@ -630,7 +630,14 @@ static int vfio_basic_config_write(struct
> vfio_pci_core_device *vdev, int pos,
> >  		*virt_cmd &=3D cpu_to_le16(~mask);
> >  		*virt_cmd |=3D cpu_to_le16(new_cmd & mask);
> >
> > -		if (__vfio_pci_memory_enabled(vdev))
> > +		/*
> > +		 * Re-arm the dma-bufs on memory-enable, but keep a CXL
> device's
> > +		 * HDM dma-buf revoked while the decoder is unrestored (a
> failed
> > +		 * reset leaves hdm_valid clear); re-arming would map DMA
> onto a
> > +		 * decoder the fault path still gates. Plain vfio-pci is unchanged.
> > +		 */
> > +		if (__vfio_pci_memory_enabled(vdev) &&
> > +		    (!vdev->cxl_ops || vdev->cxl_ops->hdm_active(vdev)))
> >  			vfio_pci_dma_buf_move(vdev, false);
> >  		up_write(&vdev->memory_lock);
> >  	}
> > @@ -720,7 +727,8 @@ static void vfio_lock_and_set_power_state(struct
> vfio_pci_core_device *vdev,
> >  	}
> >
> >  	vfio_pci_set_power_state(vdev, state);
> > -	if (__vfio_pci_memory_enabled(vdev))
> > +	if (__vfio_pci_memory_enabled(vdev) &&
> > +	    (!vdev->cxl_ops || vdev->cxl_ops->hdm_active(vdev)))
> >  		vfio_pci_dma_buf_move(vdev, false);
> >  	up_write(&vdev->memory_lock);
> >  }
> > @@ -910,8 +918,14 @@ static int vfio_exp_config_write(struct
> vfio_pci_core_device *vdev, int pos,
> >  		if (!ret && (cap & PCI_EXP_DEVCAP_FLR)) {
> >  			vfio_pci_zap_and_down_write_memory_lock(vdev);
> >  			vfio_pci_dma_buf_move(vdev, true);
> > -			pci_try_reset_function(vdev->pdev);
> > -			if (__vfio_pci_memory_enabled(vdev))
> > +			ret =3D vfio_pci_reset_function(vdev);
> > +			/*
> > +			 * Keep the HDM dma-buf revoked if a CXL reset
> > +			 * failed; re-arming would map DMA onto an
> > +			 * unrestored decoder. Mirrors the reset ioctl.
> > +			 */
> > +			if (__vfio_pci_memory_enabled(vdev) &&
> > +			    (!vdev->cxl_ops || !ret))
> >  				vfio_pci_dma_buf_move(vdev, false);
> >  			up_write(&vdev->memory_lock);
> >  		}
> > @@ -995,8 +1009,14 @@ static int vfio_af_config_write(struct
> vfio_pci_core_device *vdev, int pos,
> >  		if (!ret && (cap & PCI_AF_CAP_FLR) && (cap &
> PCI_AF_CAP_TP)) {
> >  			vfio_pci_zap_and_down_write_memory_lock(vdev);
> >  			vfio_pci_dma_buf_move(vdev, true);
> > -			pci_try_reset_function(vdev->pdev);
> > -			if (__vfio_pci_memory_enabled(vdev))
> > +			ret =3D vfio_pci_reset_function(vdev);
> > +			/*
> > +			 * Keep the HDM dma-buf revoked if a CXL reset
> > +			 * failed; re-arming would map DMA onto an
> > +			 * unrestored decoder. Mirrors the reset ioctl.
> > +			 */
> > +			if (__vfio_pci_memory_enabled(vdev) &&
> > +			    (!vdev->cxl_ops || !ret))
> >  				vfio_pci_dma_buf_move(vdev, false);
> >  			up_write(&vdev->memory_lock);
> >  		}
> > @@ -1781,9 +1801,22 @@ static int vfio_cxl_dvsec_write(struct
> vfio_pci_core_device *vdev, int pos,
> >  		status2 |=3D PCI_DVSEC_CXL_CACHE_INV;
> >  	}
> >  	if (ctrl2 & PCI_DVSEC_CXL_INIT_CXL_RST) {
> > +		int ret =3D 0;
> > +
> >  		ctrl2 &=3D ~PCI_DVSEC_CXL_INIT_CXL_RST;
> > -		status2 &=3D ~PCI_DVSEC_CXL_RST_ERR;
> > -		status2 |=3D PCI_DVSEC_CXL_RST_DONE;
> > +
> > +		if (vdev->cxl_ops && vdev->cxl_ops->reset) {
> > +			vfio_pci_zap_and_down_write_memory_lock(vdev);
> > +			vfio_pci_dma_buf_move(vdev, true);
> > +			ret =3D vfio_pci_reset_function(vdev);
> > +			if (__vfio_pci_memory_enabled(vdev) &&
> > +			    (!vdev->cxl_ops || !ret))
> > +				vfio_pci_dma_buf_move(vdev, false);
> > +			up_write(&vdev->memory_lock);
> > +		}
> > +
> > +		status2 &=3D ~(PCI_DVSEC_CXL_RST_DONE |
> PCI_DVSEC_CXL_RST_ERR);
> > +		status2 |=3D ret ? PCI_DVSEC_CXL_RST_ERR :
> PCI_DVSEC_CXL_RST_DONE;
> >  	}
> >
> >  	*pctrl2 =3D cpu_to_le16(ctrl2);
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c
> > b/drivers/vfio/pci/vfio_pci_core.c
> > index f02a5240aa71..8bd4db7afefe 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -643,8 +643,27 @@ int vfio_pci_core_enable(struct
> vfio_pci_core_device *vdev)
> >  		goto out_power;
> >
> >  	/* If reset fails because of the device lock, fail this path entirely=
 */
> > -	ret =3D pci_try_reset_function(pdev);
> > -	if (ret =3D=3D -EAGAIN)
> > +	if (vdev->cxl_ops && vdev->cxl_ops->reset) {
> > +		/*
> > +		 * VM power-on resets a CXL Type-2 device through its DVSEC
> > +		 * sequence. vconfig is not built yet here, so take memory_lock
> > +		 * and call the op directly rather than the wrapper.
> > +		 */
> > +		down_write(&vdev->memory_lock);
> > +		ret =3D vdev->cxl_ops->reset(vdev);
>=20
> CXL reset restores PCI config from pdev's saved state. Where is that stat=
e
> refreshed before this call ?

Hmm, yes, on the enable path it is not refreshed. cxl_reset_dvsec_sequence(=
)
does not snapshot the state before resetting.

For v6, I will add call to pci_save_state() from vfio_pci_core_enable().
The disable path already saves before its reset, so only enable path will n=
eed
the fix.

Thanks,
Manish

>=20
> Best regards,
> Richard Cheng.
>=20
>=20
> > +		up_write(&vdev->memory_lock);
> > +	} else {
> > +		ret =3D pci_try_reset_function(pdev);
> > +	}
> > +
> > +	/*
> > +	 * -EAGAIN means the reset could not run. For a CXL device any reset
> > +	 * error must also fail the open: a failed DVSEC reset can leave the =
HDM
> > +	 * decoder cleared or unrestored, and continuing would expose the
> HDM
> > +	 * region for host access through a decoder in an unknown state.
> > +	 */
> > +	if (ret =3D=3D -EAGAIN ||
> > +	    (vdev->cxl_ops && vdev->cxl_ops->reset && ret))
> >  		goto out_disable_device;
> >
> >  	vdev->reset_works =3D !ret;
> > @@ -845,16 +864,30 @@ void vfio_pci_core_disable(struct
> vfio_pci_core_device *vdev)
> >  	 * overwrite the previously restored configuration information.
> >  	 */
> >  	if (vdev->reset_works) {
> > -		bridge =3D pci_upstream_bridge(pdev);
> > -		if (bridge && !pci_dev_trylock(bridge))
> > -			goto out_restore_state;
> > -		if (pci_dev_trylock(pdev)) {
> > -			if (!__pci_reset_function_locked(pdev))
> > +		if (vdev->cxl_ops && vdev->cxl_ops->reset) {
> > +			/*
> > +			 * VM power-off resets a CXL Type-2 device through
> its
> > +			 * DVSEC sequence. The sequence takes its own device
> lock,
> > +			 * so run it outside the lock below.
> > +			 * vconfig is already freed here, so call the op directly
> > +			 * under memory_lock rather than the wrapper.
> > +			 */
> > +			down_write(&vdev->memory_lock);
> > +			if (!vdev->cxl_ops->reset(vdev))
> >  				vdev->needs_reset =3D false;
> > -			pci_dev_unlock(pdev);
> > +			up_write(&vdev->memory_lock);
> > +		} else {
> > +			bridge =3D pci_upstream_bridge(pdev);
> > +			if (bridge && !pci_dev_trylock(bridge))
> > +				goto out_restore_state;
> > +			if (pci_dev_trylock(pdev)) {
> > +				if (!__pci_reset_function_locked(pdev))
> > +					vdev->needs_reset =3D false;
> > +				pci_dev_unlock(pdev);
> > +			}
> > +			if (bridge)
> > +				pci_dev_unlock(bridge);
> >  		}
> > -		if (bridge)
> > -			pci_dev_unlock(bridge);
> >  	}
> >
> >  out_restore_state:
> > @@ -1592,6 +1625,20 @@ static int vfio_pci_ioctl_set_irqs(struct
> vfio_pci_core_device *vdev,
> >  	return ret;
> >  }
> >
> > +/*
> > + * Reset the function. A CXL device runs the CXL DVSEC reset sequence
> > +in place
> > + * of a PCI function reset: it replaces FLR (which would corrupt
> > +CXL.mem),
> > + * always clears device memory, and restores the HDM decoder. Callers
> > +hold
> > + * memory_lock for write.
> > + */
> > +int vfio_pci_reset_function(struct vfio_pci_core_device *vdev) {
> > +	if (!vdev->cxl_ops || !vdev->cxl_ops->reset)
> > +		return pci_try_reset_function(vdev->pdev);
> > +
> > +	return vdev->cxl_ops->reset(vdev);
> > +}
> > +
> >  static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
> >  				void __user *arg)
> >  {
> > @@ -1614,8 +1661,14 @@ static int vfio_pci_ioctl_reset(struct
> vfio_pci_core_device *vdev,
> >  	vfio_pci_set_power_state(vdev, PCI_D0);
> >
> >  	vfio_pci_dma_buf_move(vdev, true);
> > -	ret =3D pci_try_reset_function(vdev->pdev);
> > -	if (__vfio_pci_memory_enabled(vdev))
> > +	ret =3D vfio_pci_reset_function(vdev);
> > +	/*
> > +	 * Re-arm the dma-bufs on success. A CXL device whose reset failed
> leaves
> > +	 * the HDM decoder unrestored and hdm_valid clear, so re-arming its
> HDM
> > +	 * dma-buf would map device DMA onto a decoder the fault path still
> gates;
> > +	 * keep it revoked until a reset succeeds. Plain vfio-pci is unchange=
d.
> > +	 */
> > +	if (__vfio_pci_memory_enabled(vdev) && (!vdev->cxl_ops || !ret))
> >  		vfio_pci_dma_buf_move(vdev, false);
> >  	up_write(&vdev->memory_lock);
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_priv.h
> > b/drivers/vfio/pci/vfio_pci_priv.h
> > index c268c99aea82..e1ef21806a2f 100644
> > --- a/drivers/vfio/pci/vfio_pci_priv.h
> > +++ b/drivers/vfio/pci/vfio_pci_priv.h
> > @@ -78,6 +78,7 @@ int vfio_pci_set_power_state(struct
> vfio_pci_core_device *vdev,
> >  			     pci_power_t state);
> >
> >  void vfio_pci_zap_and_down_write_memory_lock(struct
> > vfio_pci_core_device *vdev);
> > +int vfio_pci_reset_function(struct vfio_pci_core_device *vdev);
> >  u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device
> > *vdev);  void vfio_pci_memory_unlock_and_restore(struct
> vfio_pci_core_device *vdev,
> >  					u16 cmd);
> > diff --git a/include/linux/vfio_pci_core.h
> > b/include/linux/vfio_pci_core.h index 39a28cc6ae8c..231679dead45
> > 100644
> > --- a/include/linux/vfio_pci_core.h
> > +++ b/include/linux/vfio_pci_core.h
> > @@ -74,6 +74,10 @@ struct vfio_cxl_ops {
> >  	void	(*close_device)(struct vfio_pci_core_device *vdev);
> >  	void	(*reset_prepare)(struct vfio_pci_core_device *vdev);
> >  	void	(*reset_done)(struct vfio_pci_core_device *vdev);
> > +	/* Run the CXL reset (always clears CXL.mem) in place of FLR */
> > +	int	(*reset)(struct vfio_pci_core_device *vdev);
> > +	/* True while the HDM range is valid and its dma-buf may be armed */
> > +	bool	(*hdm_active)(struct vfio_pci_core_device *vdev);
> >  	/* Pinned per bound CXL device so vfio-cxl cannot unload under usage
> */
> >  	struct module *owner;
> >  };
> > --
> > 2.25.1
> >
> >
