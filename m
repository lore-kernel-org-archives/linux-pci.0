Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012058.outbound.protection.outlook.com [40.107.200.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A2947F786;
	Thu,  3 Sep 2026 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430526; cv=fail; b=PoVxh3DgIUnuRozpcwDOSFP8nAViLTRKZBS2/bozrZRfYaOgxlV8/eEEa7418oOmyY3nGdXnZwBx4j9j4YKqY8MaZz3AqR5XbXWncX5RfqTbUO292n2Q3mx5UqOXp2NmODafOvdcsv0oPPJUH2GZ6X9HLBxKPSTh294kmWgmKRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430526; c=relaxed/simple;
	bh=phoHTZvYAgvA0AFVJjoOfFJL+YLm2k91L1K47wrYNjg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dXvjWDTJKZDWzwZAMS3j+woIeGVAjboVaV99NCwGMJCaA7qUmnG05CX5QUuaq/yTcLFwh6onb0H7nFnhN4w4mf2ABQCWWtLbda7L9zloEkJL+XljhRT9y8p2DJVZ+tcG2LiTVDUEd516JpuU2ejiFwnd16qrX6mt1vB/RsoaCv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=drTTv2sL; arc=fail smtp.client-ip=40.107.200.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="drTTv2sL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYYh+RoodLfYYc9UI9Y3aWgLSJ90MkL1N2pe73zuHhh4pmkC1cmQzl2UNgAI6OtekXJyX+f14ysuO52GJtRVW/BdW7Gyc8rfQvKSOHQP5h28xu2uqjxJG78nzGyUihK/ddqG8uev0/FXsKPr7uwD/gnrZ7H6Lceav9UKwuQ3EpG8ai5q1lSzAZ8cw3kD1id7vINNZNthLUzRUfoDqfnzoRb59oFVzefmtn65StcN0hDMT90xvtS4SKfAHHGAVmceqLz2TVuefSXD+zoRsGxXrsBhUJfpXoUzA5yYUrQXaSKEysxLpS4DzHcTYjgrPfT/pNs/oBUek08qwaFxyIxJXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/kSfnicdlELNUM5olEGxT1WnHiRLL0kznoK3dGpRVI=;
 b=O+JqmM1t2n7ZNaboYEteQRlUhf0GSGq9yb98oodv8pFBvmy3bzH5YbRAYRM4TGugQLKrM6m+sxfO7Mu7R1yXwsWi/bg4MvXpSJ6YG9wSw9Np98avpS14RxnCMQiHqzglcWss+Q45dUpxCYnwpPWsAK2F74Iu80IIIbc1kvCi6klXeWpZZiiHZC+1fEw2aRth6B0vgao+3YKMM2Q2O76lTTauRW9Koi48YjDR3sUABUY9cFlOlphBbDv/9PR5FumcqPKGO2QRMSv7vqVSztycVQYvbkxEEOjaumTANemPSCZ6Yga5ddta+ioHAdxqTH2o0SGNrHSDme5PAKCTFv6PNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/kSfnicdlELNUM5olEGxT1WnHiRLL0kznoK3dGpRVI=;
 b=drTTv2sLFEBoTyIGSVNXeF1OXPntZRJCQYwpYpjI+mlwqYP5cLiIjWIwdD/ptsuKENGqorQeA6GNLLQ5WyiI5x+ENTAwuZxllb6e19uGokO7jZIP9B9Cqga9SCZhQ/oI2VktIaHjdcRnYsKuxmxT8j2+KJYNX68FZCSLyJycjQVl+aKuvuAnNVuUmUsh9GROzMOwTzxsSDzEC4JxJxjsNNtd7Yn8XIgzeYnTTNS3rk06oxWTTOZMdls1z8KigcMI5AQsVmmuL7SiUynBRUOsB/TZ5CLBdgSFVtt46c4/bILgHGXAxe5HwkfAbv0wHvlKcxviEeWgH87dn1Tqmvj/9w==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by LV8PR12MB9405.namprd12.prod.outlook.com (2603:10b6:408:1fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 10:15:09 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 10:15:09 +0000
From: Manish Honap <mhonap@nvidia.com>
To: Alex Williamson <alex@shazbot.org>
CC: "jgg@ziepe.ca" <jgg@ziepe.ca>, Ankit Agrawal <ankita@nvidia.com>,
	"jic23@kernel.org" <jic23@kernel.org>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alejandro.lucero-palau@amd.com"
	<alejandro.lucero-palau@amd.com>, Srirangan Madhavan <smadhavan@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "iweiny@kernel.org"
	<iweiny@kernel.org>, "ming.li@zohomail.com" <ming.li@zohomail.com>, Yishai
 Hadas <yishaih@nvidia.com>, Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
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
Subject: RE: [PATCH v4 22/27] vfio/cxl: Revoke the HDM mapping on reset and
 power transitions
Thread-Topic: [PATCH v4 22/27] vfio/cxl: Revoke the HDM mapping on reset and
 power transitions
Thread-Index: AQHdKwfdXDXm165AWUyZWbiRSnnBnra0GYgAgAiYgZA=
Date: Thu, 3 Sep 2026 10:15:09 +0000
Message-ID:
 <IA1PR12MB9030ADAFFD23B6EDE308D6AABDB62@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-23-mhonap@nvidia.com>
 <20260828155428.2b8bbbf5@shazbot.org>
In-Reply-To: <20260828155428.2b8bbbf5@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|LV8PR12MB9405:EE_
x-ms-office365-filtering-correlation-id: 73f333ab-3351-4445-dbcb-08df09a43bca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 ZAhTjPePM/PBLVyQCoYHsT4BJY+08fLt/oTeGVSCVm/ASKGKDv9/28aJfSEz3a/vadYG0Q04wlIOhgWpndEte83z013NLqifvFjE223osu0ryXDuWckfi6inO6f0p60pVOjBumDNIfyMW7ppLT00/g3u6KXkHerSTjN6wwUbZaZrR1bAmsVa6Osr70nfZAGBFrqZiXZskuxrCTGSCF88iMK6oOyf8aH3yZaOAAOM8GthNKv6Mzslfrzm6s7l+jsXt+E6ZyA8+3QkPZ+9cb3C25K3vlCgug//v7XRSMaZZ+Fhcs2aqlhu19IaHg9cdLk8kB8ZDOkU5F+yaRr0AeDFl++RYCN16CJv2A59QRkswetdpKyh6vgQ7mVRbLttKGYblWJe062wizcLgyaia5mOEaTo2+FyjJjwh6//veFiqrG1gY/miu95w+gX0Zg77SOaZO1pr2vglxoITZVBc/RgCgyKlNEt0AHo4Gpug8+FPPb1nFzugWEqj7APxHkeU0t/hkStIdoZt5s/Dk5BgkWzT2+FvxkVd5NJcDSwXPZX7Gs8gHjcdZhxZMx2Bk3tVW7cW4RBFAK8SHgrQEI4KJE0sBEXvKPyqJSkziD/B2vC6o2VY6GcphZoZbVJVufd7gko3/xmZXd1BXXlllpIHFi9NQAMXTSxhLoyXbf/iHdAJcbzezJqLDZz1hfmSOHoAC8Xq84JyFL/Zqt/Evg20X3VWv2U7bxAIVRk8jojMS9cgNc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZiXGGStNr4Bz2H6Uaxv/UZ7z1b8HHT2oTkzNgPjk9cJtzu0ODORC7BAGilP3?=
 =?us-ascii?Q?MhxjUzJa7L+/P9je7agtf3LIpXfOAK8DY45EEdPTMFnmw71RjDFehKZVJbz8?=
 =?us-ascii?Q?7aJesRwoWh2ZgW08gKTDLL7rvHX4ww1FpbRcyt3XCK5FdidcaE+rnwolem+3?=
 =?us-ascii?Q?PkOs/9W6On58TkSQqkRnwenkfhFbipucVnHM5hRSwb5/ZzAMmaMoEAZb7xLf?=
 =?us-ascii?Q?IC1Yd3DXNi5qCVsdsGanhBl8DHXcEHJNyXld1oNzrMetHApHbT+jsir0iTJC?=
 =?us-ascii?Q?k+SGX9ZX1U0B5u1RjLPI/Y2fQWrZaLkr3Vw4bUK2n0p+zhUTDqxzJ75bdgZE?=
 =?us-ascii?Q?p0s5dwX2oSHJIU9BGV9RFaJU7AgR074IR+j9OadccV6x9+5MudYhVNMSxake?=
 =?us-ascii?Q?HwzbBFYZapZh1WJIU9DoLFrS+bNFBrpmhDg+p7hFeCst8bm9l88eA6q+NDnR?=
 =?us-ascii?Q?eZrLTHCGwM6ztpN2NiHqDtwXxR3nJ/mCv0f2isUvQQyskLkcNLCDKSbqTMx/?=
 =?us-ascii?Q?fjbxSFIdxMmpwAyClUo794xWVMf5kRy2FUqNm18TjOnQ8FfGo48YE808cGEL?=
 =?us-ascii?Q?c8gbWSfYmXKVSRRDiIjRryOwuW5hfAeZ7pumUHGROnPNvuAdgNkisTFmyP3j?=
 =?us-ascii?Q?wGn1dPjwzg7vk718AcH8RBhbZsly/axQ9WeSSvLMxgVncOwojfxjhfq7Zx1p?=
 =?us-ascii?Q?LhXTheVm7/iDCfzFBIS2Rns1BqqXufRXL2kgkdShizxmYVMcENAMxAVFj82R?=
 =?us-ascii?Q?4TTCi1IDuujZk0+jX9uLUM2c/cBCb3p6eavsj0I6ojOihHc7/JPe3mr7Ny9B?=
 =?us-ascii?Q?17SUF9/T/x4QIm0NFDiHiSB0dba2k5VNh6+nuGGTD7ypVflNxQfh2U7fEu6q?=
 =?us-ascii?Q?WsVBdv2En1YHOkqnvMkmQ89Ma/x7Xldh/bGBIFLINGMr/PRjkqpRnrTtwBJH?=
 =?us-ascii?Q?zF6Yo6l1LX/JeYU0D02B6QKPlszD2qOI17+zmwA3Tt3x/7mIuVV+eTtYRGlR?=
 =?us-ascii?Q?SpwzSEo597PdTpy8wlywgVxJqPxsrLUwCMv1ZfEzNcgcskkHhAx0fxDsG6du?=
 =?us-ascii?Q?rNk0CsrLxXPZB5nERDtMyAjXmPufRYpoUGc7gPO43y4Uvtx9ZPDN7xzaW2Zi?=
 =?us-ascii?Q?t7NmUY/YcR9OkFcq8P9VReMeXNO+rONIxxwmHtx8ERU44xNo7cWUJMR5og+x?=
 =?us-ascii?Q?8tZnYgXjbTO1E7BfyljD6sy2WIYvDflph8REKdHJlW6MCf4o/mjrAC+IRioI?=
 =?us-ascii?Q?ry1lPkbm7UzKmVlSaTm2Uc+zXiLF14RCsnu+KXLXoLwJrpXa7XFr2ArNvToi?=
 =?us-ascii?Q?ELGgjFEfq0YxK73ID6BSDRFsoKshF+mcJYoVmP+syHIXntBpekJxzmpwnfQK?=
 =?us-ascii?Q?JNncwWlY4WeKNOMKVjNw8JkLjyElenXI7GQMVK2lqIFB6FKFFgEf8yDCgp1C?=
 =?us-ascii?Q?QNseNKXxFMRoQhjLhgC4lEycHjJXSB1tilhvODOc4/Xgal1NeTh8dTMzIKN3?=
 =?us-ascii?Q?VJ3ZnzAsqZVtDqhkXnolM4YHH36L2e+lD7B9Kb2jIXN4yvDwR4W1KbFNU64f?=
 =?us-ascii?Q?CDxjtlaeaO2B0DvXvI35/e1o6OkKkuw6QTNBBdC3Bv6/UpgvqYlN85AYXdIk?=
 =?us-ascii?Q?wGa1I8UuTVK9rjKY2RXpVvtO+xbXpAa3QnieG+Hj0yNLxU/oCcEyd2/SGs8v?=
 =?us-ascii?Q?MBfdCiEwBugc+Cv2ji+zjITPuM1qgE0tPPmEyubYsoBZmRte?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f333ab-3351-4445-dbcb-08df09a43bca
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 10:15:09.1788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nPmRNqIWDiR9ZheBAE3oZ/thN8GGTAQfHrFFqAttb8B91jqM4DNayPo2+4Rm/AM9sdty3m14LToYt8gYYkb3VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9405



> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Saturday, August 29, 2026 3:24 AM
> To: Manish Honap <mhonap@nvidia.com>
> Cc: jgg@ziepe.ca; Ankit Agrawal <ankita@nvidia.com>; jic23@kernel.org;
> dave.jiang@intel.com; alejandro.lucero-palau@amd.com; Srirangan Madhavan
> <smadhavan@nvidia.com>; corbet@lwn.net; skhan@linuxfoundation.org;
> dave@stgolabs.net; alison.schofield@intel.com; vishal.l.verma@intel.com;
> iweiny@kernel.org; ming.li@zohomail.com; Yishai Hadas
> <yishaih@nvidia.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; kevin.tian@intel.com; bhelgaas@google.com;
> dmatlack@google.com; kees@kernel.org; gustavoars@kernel.org; Neo Jia
> <cjia@nvidia.com>; Krishnakant Jaju <kjaju@nvidia.com>; Vikram Sethi
> <vsethi@nvidia.com>; Zhi Wang <zhiw@nvidia.com>; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; kvm@vger.kernel.org;
> linux-cxl@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kselftest@vger.kernel.org; linux-hardening@vger.kernel.org; alex@shazbot.=
org
> Subject: Re: [PATCH v4 22/27] vfio/cxl: Revoke the HDM mapping on reset a=
nd
> power transitions
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 13 Aug 2026 15:06:26 +0530 <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > The HDM region is a device region, not a BAR, so vfio_pci_zap_bars()
> > leaves its PTEs in place. A runtime-PM entry, a D3 transition, or a
> > reset would then leave the guest with live mappings into a quiesced dev=
ice.
> >
> > Add a zap hook, called alongside the BAR zap under memory_lock, that
> > unmaps the window. The fault path already refuses to re-insert PFNs
> > while the device is suspended or its Memory Space is disabled.
>=20
> We need to think about what happens in the dmabuf mmap world[1].
> Currently there are no device specific regions supporting mmap.
> Zapping is left as a compatibility interface, but the right solution is p=
robably to
> use dmabuf for mmap where we can.  Otherwise zap should likely be handled
> generically for device specific regions supporting mmap rather than as a =
CXL
> one-off.
>=20
> AFAIK, Matt's series is still in the works and this will conflict.
> Thanks,
>=20
> Alex

Agree. I will align it with the dma-buf direction. Kernel-v5 will add a dma=
-buf export
of the HDM region (imported by iommufd) and revoke it on reset via move_not=
ify.

I will coordinate with Matt to resolve this conflict.

Manish

>=20
> [1]https://lore.kernel.org/all/20260715174737.15287-1-matt@ozlabs.org/
>=20
>=20
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/cxl/vfio_cxl_core.c | 29 ++++++++++++++++++++++++++++
> >  drivers/vfio/pci/vfio_pci_core.c     |  8 ++++++++
> >  include/linux/vfio_pci_core.h        |  2 ++
> >  3 files changed, 39 insertions(+)
> >
> > diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > index 0fb5ed5d86b7..f1c6bf06c408 100644
> > --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > @@ -530,6 +530,31 @@ static void vfio_cxl_release_device(struct
> vfio_pci_core_device *vdev)
> >       vdev->cxl =3D NULL;
> >  }
> >
> > +static void vfio_cxl_zap(struct vfio_pci_core_device *vdev) {
> > +     struct vfio_cxl_state *cxl =3D vdev->cxl;
> > +
> > +     lockdep_assert_held_write(&vdev->memory_lock);
> > +
> > +     if (!cxl)
> > +             return;
> > +
> > +     /*
> > +      * Revoke the mapping so a later access re-faults. Do not touch h=
dm_valid
> > +      * here: zap also runs on a plain PCI Memory-Space disable, acros=
s which
> > +      * the committed HDM decoder stays valid (CXL.mem is not gated by=
 PCI
> > +      * Memory-Space). hdm_valid tracks decoder validity and is cleare=
d only
> by
> > +      * the paths that can leave the decoder unrestored (a failed rese=
t or PM
> > +      * restore). A reset or D3 transition holds memory_lock for write=
 while it
> > +      * runs, so no fault races the revoke, and a runtime-suspended de=
vice is
> > +      * caught by the pm_runtime_engaged check on the insert path.
> > +      */
> > +     unmap_mapping_range(vdev->vdev.inode->i_mapping,
> > +                         VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_NUM_REGIONS=
 +
> > +                                                  cxl->hdm_region_idx)=
,
> > +                         range_len(&cxl->hpa_range), true); }
> > +
> >  static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)  {
> >       struct vfio_cxl_state *cxl =3D vdev->cxl; @@ -594,6 +619,9 @@
> > static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
> >       if (ret)
> >               goto err_free_shadows;
> >
> > +     /* Remember where the HDM region landed so it can be zapped by in=
dex.
> */
> > +     cxl->hdm_region_idx =3D vdev->num_regions - 1;
> > +
> >       ret =3D vfio_pci_core_register_dev_region(vdev, VFIO_REGION_TYPE_=
CXL,
> >                                               VFIO_REGION_SUBTYPE_CXL_C=
OMP_REGS,
> >                                               &vfio_cxl_comp_regops,
> > cxl->hdm_len, @@ -738,6 +766,7 @@ static const struct vfio_cxl_ops
> vfio_cxl_ops =3D {
> >       .close_device   =3D vfio_cxl_close_device,
> >       .config_read    =3D vfio_cxl_config_read,
> >       .config_write   =3D vfio_cxl_config_write,
> > +     .zap            =3D vfio_cxl_zap,
> >       .owner          =3D THIS_MODULE,
> >  };
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c
> > b/drivers/vfio/pci/vfio_pci_core.c
> > index 77f8f39dd670..1a54f15d1c2c 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -1832,6 +1832,14 @@ void
> > vfio_pci_zap_and_down_write_memory_lock(struct vfio_pci_core_device
> *vdev)  {
> >       down_write(&vdev->memory_lock);
> >       vfio_pci_zap_bars(vdev);
> > +     /*
> > +      * The HDM region lives in the device-region offset range that
> > +      * vfio_pci_zap_bars() does not cover, so revoke it here too. Oth=
erwise
> > +      * a runtime-PM entry, D3 transition, or reset would leave the gu=
est
> > +      * with live mappings into a quiesced device.
> > +      */
> > +     if (vdev->cxl_ops && vdev->cxl_ops->zap)
> > +             vdev->cxl_ops->zap(vdev);
> >  }
> >
> >  u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device
> > *vdev) diff --git a/include/linux/vfio_pci_core.h
> > b/include/linux/vfio_pci_core.h index 294e95b5e881..8b93949d4484
> > 100644
> > --- a/include/linux/vfio_pci_core.h
> > +++ b/include/linux/vfio_pci_core.h
> > @@ -76,6 +76,8 @@ struct vfio_cxl_ops {
> >                              int count, __le32 *val);
> >       int     (*config_write)(struct vfio_pci_core_device *vdev, int po=
s,
> >                               int count, __le32 val);
> > +     /* Revoke the HDM mapping; paired with the BAR zap */
> > +     void    (*zap)(struct vfio_pci_core_device *vdev);
> >
> >       /* Pinned per bound CXL device so vfio-cxl cannot unload under us=
age */
> >       struct module *owner;

