Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011062.outbound.protection.outlook.com [40.93.194.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66275511E70;
	Tue,  8 Sep 2026 10:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788865140; cv=fail; b=dZaJoPeOHjOjUiIa2p14CwCLCX5WCwuyTYLLxXqx8EoZ7lqsdla0RqEDKjLHP9AF8WbEbgYV48HClUpfHq+G0yALLkf1VG3D4mIbBQ64Z9NU875zfH5g0QB/tVrVZM7d3UKglYWwVnvY4TOZ9vClBgG9pUHzY3yd02rZMpRm49Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788865140; c=relaxed/simple;
	bh=7YdYoh7yq+NplutQw/dZ8F48xnTS4uT8d/nR4wQp+Co=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ttU5yUpnGCHrHCdVr4fwePmK9PT7j18ulroLHZcF2gNwQVY2UBg9vQY8M4pFqAfX93Q4EISxj4T5IZpWUHcwXapDPDWYg2V2JRdqRrOXparSDdr8utwUMJ1bG1REHky8pLNN/S0JaQsnJ9/bPKoMthQzkoMg3rQxy5WDEXfCVhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mBc7ielr; arc=fail smtp.client-ip=40.93.194.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mBc7ielr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZE7Bw2qGRQr+PPuzOqk+9U0mX1JzE8Jn03TulBhTk3yasMunKZtl6A1Wwz9HTDOtNuWcy1agcdLihDit+9fEIMzP6KLtyOcD/cD33/3hd9J9HuF+gKGo77VYQ/2528ls0EuvmEuWeURaM9XeTkqYVO0h4e7LhyBalMl+c9MqaMPuYMiOsEt5tHjyi/hNdhU0J8se3TyESDIW5xj+VzUvB/4TIPqe4x6g2tjt/+X8k/AhdXabbwews8NfEA+q9ZI1T7A7lqnAErD1AWU19es7+f8No5YBsTaQcyR3OMarZBuapEk822j+VROF1uCHfMfNPjiep3Q3NO8M0MptyfPqPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMm/WtqRoFseDgAH/zx5EhUYWeKDfCZrBPeSFRxGGq0=;
 b=m1igTD1Gfj7DPXJY3jd+lTrqJ+7fAyfr1NzBQhGIm80MzZE2PJPNkPNHFanwf84UXel/hnOqcSiZQnDD2Ur1ztqocSdAzDnp+4j6mD67dJJAisVwcFn5usy3d+VmucEY+Dqg8ZiBN4DR91+R9DAEIy0iS3Ril3uwphQVXWnXolF07b3dKr9Pk87CPc1ABQFlUblIHF4+2iUoMdlb54XV+eCgw1hxngRNgNSvIr5rUM+uo+TK8M9MmTOlwf8yRC9qu6Tkz+Vj/4t72SMi+40z+5XXGE5kyv75kenLOSuvRM17LbcmjCQgbIIX8Tb+TinQAV50i/bot2mi7h61Q9CC6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMm/WtqRoFseDgAH/zx5EhUYWeKDfCZrBPeSFRxGGq0=;
 b=mBc7ielrMxRcFn1he4Owm/Ce9/v3G2F68mx3V4Zf5JkL32ow02q5IUsiRbg9Au4qb0qjtpNPg3rSYbT/oZ1ryj9nsx5OB86+qlwVUbpHEscfCP/pfezdljziLQgIXTJ9p6G8KJIdrfYCYaxiMELKBXeujTTep4LqSmHbp03xYV9hwxirrZ5sCRuYgpBP6yFpJOD17ZI7p9E+6yFQNG+bM1athbtxOfq6/h7pxnlWtIackpI0rmUNWwmjjwjQSJt5ne8/h7evgtWLiYuPSG2iTDs5kvM58TZOk7w8S8d3DcmRsIBG08N91P8eOn1/TXBJa/gZhbmrvFr9A2UcSNYbtg==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by DS7PR12MB5813.namprd12.prod.outlook.com (2603:10b6:8:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 10:58:49 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%5]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:58:49 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Alex Williamson <alex@shazbot.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "kbusch@meta.com"
	<kbusch@meta.com>, "michal.winiarski@intel.com" <michal.winiarski@intel.com>,
	"satyanarayana.k.v.p@intel.com" <satyanarayana.k.v.p@intel.com>, Sonang Patel
	<sonangp@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
	<mochs@nvidia.com>, "mike.malyshev@gmail.com" <mike.malyshev@gmail.com>
Subject: RE: [RFC PATCH 00/19] vfio/pci: Handle PCI error recovery and report
 state to userspace
Thread-Topic: [RFC PATCH 00/19] vfio/pci: Handle PCI error recovery and report
 state to userspace
Thread-Index: AQHdPKDu3EL6GNr7AUKHBFJoVw5VDrbC2cZggAGqmhA=
Date: Tue, 8 Sep 2026 10:58:49 +0000
Message-ID:
 <SJ0PR12MB86146247A7BB4F62AE75C199ABB12@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
 <20260904130927.2e234a21@shazbot.org>
 <SJ0PR12MB861421F7FA18CA04BFE996FDABB22@SJ0PR12MB8614.namprd12.prod.outlook.com>
In-Reply-To:
 <SJ0PR12MB861421F7FA18CA04BFE996FDABB22@SJ0PR12MB8614.namprd12.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|DS7PR12MB5813:EE_
x-ms-office365-filtering-correlation-id: f1bbf860-2e17-433f-1b9a-08df0d9829a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|38070700021|10067099003|11063799006|5023799004|4143699003|56012099006|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info:
 oMyv3YAdQn/N4tAjQm6GH4vCCX5RyPobAvRGaBhOSAyWCOiyP9qaT0i8VcGu6l5y8jnymfLDOL4Q8ma1XPsM5hFeMHRAEYSgpZAYZS/gdoEM/fvRSCp3ZDRTPqSuhdJkBm062edZ9DFQ3CpgaOnxeI9KLleYP0PdE7hz5OWtcNo3/cmtYRPqJuscyH683Qgq7jOefIairt8/VVxdEUisSYdMIleezS4TE3ySGiIfMFxWK+xD9cIghuSd/mL+GveBrVHio1Yc0flgnGqWzVrXYSABlUdG0CW3F4yEY/rT6EQw0Fk2vH8m72acY7y8WRJewvgbfYwzOunJMXKedWsCMUQlujuNPpADlPU7yuI1iS0bRLgXddkHqXw2J8gjkpDoUVd6bUvLos4gNqrVO0isttQ+sRplXdnGxjNkwMZiWiqHC15xvBSN57gzoM/sSB5gL9gat3YtQeA01ikdMS0dGfwpR4Sbg+FcS1W2utjyFb8Ixoqx9lIm4zKd3u/51cYSr1xwKUuEfyCivXjmV4sUCnpHLBD33AUXBh8HYb/2EtGfnzFfPOwVreVXosllTQqEIGzafA2yhVAOccQlnnYJFx7j1GZ/5YUKphPKsia4VBPFXCSfcyz1ChLj9+dyvW0VrjB7ZZqy+GCZ4VznvdZNX3F3sYOcpe1sSFCgpWFS4lpjWJ9rqokkipyQka/26A9RxIHlU7WkA3KJ7xgIdloqDhVEls7ETBU+snNol4ukkIw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB8614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(38070700021)(10067099003)(11063799006)(5023799004)(4143699003)(56012099006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nrV6gpGrhlILIDftvjhIxy2itDTy9H5OrU/JcXqRyoVD2JBYrTcL5Qo0DDEu?=
 =?us-ascii?Q?AZFnhEKfbI+9/6Cv5yXlHhyVFG8lWDd6oXeRAEEY66sbILx/SmzsJPlrj/Jz?=
 =?us-ascii?Q?eR0PSJeJkmg8QUSKxkBOavzHu87QTRkglxMVn3GOqXG++fS3Dqn+r8kWVdkG?=
 =?us-ascii?Q?u2k7YyXSNJt4IhCXuzvBiyovMuHe2oJbZOM8F5Kyq4r5BtMbTL84xPZ4Dl66?=
 =?us-ascii?Q?xdbt9AfGTnX0iPn09nLf9q+iQuSLi34VKcRRuoS/MxVNFA1w2HbAUZn+Ckac?=
 =?us-ascii?Q?mjrdsnZoXSxo2f0z8mzt8pKam/00Gh5jdLlk3lXKoXo5FpqvjYWls5MjGxxV?=
 =?us-ascii?Q?/MzFcUDlPtsKERYmk3fUQf7K6YCNVrLGu4y5GxGElVuCiGElxoYX8W1G9Brt?=
 =?us-ascii?Q?u2Aw+YStR664bqi4XOdEdemvW41dyhy+Eib7hEoT4WLR/XV5gs6E8y8CnkFo?=
 =?us-ascii?Q?YcEzDAY3Zxmi1hfog2IbsKNQLhbfOf/HVr1TsNZ6yTBU7CwkrCR1sLXHVPpH?=
 =?us-ascii?Q?s2SeHBiwqkbPvjMrZd3ShQjym3KDSNArSF4bfaOwKMDTSD3R6QJthxzPyKUy?=
 =?us-ascii?Q?GfP/XwUqqnW3UY2DHpxaXzDOykPpbVUqPmnuPjGR+rSp5AgP7vVQ8mJRb6zu?=
 =?us-ascii?Q?UmYP3Gl+CVYCSJC5W+H/L5yvBhkaGpieUsGUaWN+hQiojdPpKktvYY5zEiLA?=
 =?us-ascii?Q?jg1eGbqbB6/H7bi6mwagxZk9IhaYBaVRX9If28sFi1gzxnR6JlTaVtAMiHzC?=
 =?us-ascii?Q?IKVoBfFzWHcRyk37J3rzIXHe4EN60I2CQoH9cqBAxoRRNUXtMVDvS5bdomZ7?=
 =?us-ascii?Q?bgAOJXZxzjVyOVaEtX9j2vr6svSLA7ZoauIrrjPKBdAlGxwa1yOzC77yBxUy?=
 =?us-ascii?Q?0itx56aHSFnPRrXy9/a/UpWBZo4/FeE/g1OPiNGNWX2LxKnx8EVH2fDedvqd?=
 =?us-ascii?Q?hpgsmbKS5KfaNoHxxhge3y9t8y6gj8N37d+yXmgdVNzRj2KniIOvDrZl/7pQ?=
 =?us-ascii?Q?m6IsYUpCEbWv7/p5B3WvxDss4I3IrS1o1KSx6Zyb6I1t88Kz96iAAwOmu6+s?=
 =?us-ascii?Q?rzhatF/2rIDwNINqSsEH1UiQyBYkOMPjO0vdlB1K/VE/xgdnCafLfOERu4lD?=
 =?us-ascii?Q?bFExS/3Rxe0pKN3WibQRteLL33r3N/6HLhhYmnkklIaw4mVSUt4ZrYK4JH9g?=
 =?us-ascii?Q?hkCMwfBzF2h618e9umYr46ouyEPlDRvzl1McBGVDU3BbOC92CJ3Pmn0FXa4G?=
 =?us-ascii?Q?oJ94sJZ41bTOgbAUTQtHR+8Ic/QJg2x054WpiThrIa4e7+jGjr33B+Qgl3Lr?=
 =?us-ascii?Q?gq+w+JPGbV8cr0Sja2QgAoIkJ72sHdgve2MMx4siRPDE7wVdTOTtsweKsu/k?=
 =?us-ascii?Q?NCHli1UNATmnr58xRVd1mo31ipaP1pEaD3ximhGtlKnoOkfR0NCYhZG5ckVQ?=
 =?us-ascii?Q?femzOn9hZBxhhEZpZ3A+ZRPAl13fmzdLNTke3xaLLD2NDrqfpha2PDCCyOxw?=
 =?us-ascii?Q?whG7d2lI3ROqYVvoPUjA0Rx92+rldu+uRzBfQKvQ94MQn7rvTnuuhfmCtGuj?=
 =?us-ascii?Q?7mxGpHEUQ5sKy45r6Dd0hVDxERbL1dSFNvgZI2xgGifWUy/mUGoc6UnXYXMn?=
 =?us-ascii?Q?uGpE+v947O83yYvzaPw/KurWa68725mvAGcC+uF9YxfL40n1gDpzd9DjQCqF?=
 =?us-ascii?Q?/0bg25KBslwbpooTluR14tzHopUTO2JcUV/l6TLPjl1QBKYwooIUyCMPLt5P?=
 =?us-ascii?Q?ir4iu1zvwA=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1bbf860-2e17-433f-1b9a-08df0d9829a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 10:58:49.4664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: als9miNxLJlmdISb4WVJv7oZRW167gdVVp21UVQa77JNBV4yeoc89RMsFojzWSz0GQcbgfVO02LJKohKv7aZXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5813



> -----Original Message-----
> From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Sent: 07 September 2026 10:39
> To: Alex Williamson <alex@shazbot.org>
> Cc: kvm@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; jgg@ziepe.ca; kevin.tian@intel.com;
> kbusch@meta.com; michal.winiarski@intel.com;
> satyanarayana.k.v.p@intel.com; Sonang Patel <sonangp@nvidia.com>;
> Nathan Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>
> Subject: RE: [RFC PATCH 00/19] vfio/pci: Handle PCI error recovery and re=
port
> state to userspace
>=20
>=20
>=20
> > -----Original Message-----
> > From: Alex Williamson <alex@shazbot.org>
> > Sent: 04 September 2026 20:09
> > To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> > Cc: kvm@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org; jgg@ziepe.ca; kevin.tian@intel.com;
> > kbusch@meta.com; michal.winiarski@intel.com;
> > satyanarayana.k.v.p@intel.com; Sonang Patel <sonangp@nvidia.com>;
> > Nathan Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
> > alex@shazbot.org
> > Subject: Re: [RFC PATCH 00/19] vfio/pci: Handle PCI error recovery and
> report
> > state to userspace
> >
> > External email: Use caution opening links or attachments
> >
> >
> > On Tue, 1 Sep 2026 10:31:58 +0100
> > Shameer Kolothum <skolothumtho@nvidia.com> wrote:
> >
> > > Hi,
> > >
> > > Currently, vfio-pci takes almost no part in PCI error recovery. It
> > > implements error_detected() and neither of the other two callbacks. T=
hat
> > > one callback ignores the pci_channel_state_t it is given, signals the
> > > error eventfd, and returns PCI_ERS_RESULT_CAN_RECOVER for every error=
,
> a
> > > permanent failure included. Nothing implements slot_reset() or resume=
(),
> > > so vfio-pci never learns that the host reset the device, or that
> > > recovery finished.
> > >
> > > Userspace gets one eventfd signal with nothing attached to it. It can=
not
> > > tell a non-fatal error the host recovered from apart from a permanent
> > > failure, and it is never told when recovery is over. With nothing to =
go
> > > on, QEMU assumes the worst and calls
> > vm_stop(RUN_STATE_INTERNAL_ERROR),
> > > which the VM cannot come back from.
> > >
> > > Any device assigned through vfio-pci can hit this. A non-fatal
> > > uncorrectable error is reported, the host AER path recovers the devic=
e
> > > fine, and the VM is killed anyway.
> > >
> > > This series lets userspace observe host recovery state, and keeps it =
off
> > > the device while recovery is running. With that state visible, usersp=
ace
> > > can decide what to do with the guest rather than assuming the worst.
> > >
> > > The approach here comes from an earlier discussion with Alex.
> > >
> > > https://lore.kernel.org/qemu-
> > devel/20260707161234.23ed28db@nvidia.com/
> > > https://lore.kernel.org/all/20260818083754.7ccf76d9@shazbot.org/
> > >
> > > Design
> > > ------
> > >
> > > The VMM watches recovery. It does not take part in it. The kernel run=
s
> > > the recovery sequence and tells userspace what happened and when it i=
s
> > > done.
> > >
> > > vfio-pci already has error_detected(). This series extends it and add=
s
> > > the other two callbacks:
> > >
> > >   - error_detected() now records the channel state, blocks new device
> > >     access, revokes BAR mappings and exported DMA-BUFs, and quiesces
> > >     INTx. It still signals err_trigger as it does today. It votes on
> > >     severity rather than always claiming it can recover: CAN_RECOVER =
for
> > >     a non-fatal error, NEED_RESET for a frozen channel, DISCONNECT fo=
r a
> > >     permanent failure, and NONE if our own quiesce failed, which leav=
es
> > >     the rest of the domain alone.
> > >   - slot_reset() is new. It restores config state after the host has
> > >     reset the device. Nothing does that today, which is why a device
> > >     comes back from an AER reset with its config lost.
> > >   - resume() is new. It restores PCI_COMMAND, unblocks access and wak=
es
> > >     waiters.
> > >   - A new device feature reports the state and carries an eventfd.
> > >
> > > A non-fatal error gets the same quiesce as a frozen one. The host has=
 not
> > > finished deciding what the error was, and can still escalate to a res=
et,
> > > so the device is not the user's again until resume() says so.
> > >
> > > The support is opt-in. Until userspace installs the recovery eventfd,
> > > generic vfio-pci behaves as it does today. error_detected() takes its
> > > existing path and signals the same eventfd. VFIO variant driver suppo=
rt
> > > is not added for now.
> > >
> > > The uAPI is VFIO_DEVICE_FEATURE_PCI_ERROR_RECOVERY. It carries the
> > > eventfd and reports a status word plus a sequence number, so userspac=
e
> > > can tell coalesced notifications apart. IN_PROGRESS is set while a
> > > recovery is running. CHANNEL_FROZEN says the link went down.
> > > DEVICE_RESET says the host reset the device. FAILED says the device
> > > cannot be used again until close and reopen. ENABLED says userspace h=
as
> > > opted in.
> > >
> > > A non-fatal recovery can complete before userspace reacts to the even=
tfd,
> > > so IN_PROGRESS may already be clear by the time the feature is read. =
Work
> > > from the sequence number and the status bits rather than expecting to
> > > catch the event while it runs.
> > >
> > > Patches
> > > -------
> > >
> > >   1-3    the groundwork: the recovery state fields, the open and clos=
e
> > >          lifecycle so a callback never sees a half built or half torn
> > >          down device, and the access guards the rest of the series us=
es
> > >   4-13   close the access paths one at a time: function reset, config
> > >          space, ioeventfd, BAR faults, BAR and ROM, interrupts, hot
> > >          reset, runtime PM, info queries, DMA-BUF
> > >   14-18  the error handler callbacks: slot reset, the INTx helpers an=
d
> > >          the quiesce that uses them, then resume and error_detected
> > >   19     the uAPI a user opts in through
> > >
> > > Locking
> > > -------
> > >
> > > Blocking access is the hard part of this series, and it comes down to
> > > one rule.
> > >
> > >   recovery_lock can be held while publishing state, and while drainin=
g
> > >   operations that are already under way. It cannot be held across a r=
eset,
> > >   or across anything else that reaches pci_bus_sem.
> > >
> > > The reason is the order AER arrives in. It enters the driver already
> > > holding device_lock, and pci_bus_sem too when the device sits under a
> > > bridge with a subordinate bus, and only then takes recovery_lock. A
> > > secondary bus reset reaches pci_bus_sem. So a vfio path which holds
> > > recovery_lock across a reset ends up taking those two the other way
> > > round.
> > >
> > > Seven places needed reshaping for this rule: device close, slot_reset=
(),
> > > open, VFIO_DEVICE_RESET, the guest triggered config space FLR,
> > > VFIO_DEVICE_SET_IRQS, and a guest write putting the device back in D0=
,
> > > which reaches pci_bus_sem through pcie_aspm_pm_state_change().
> > >
> > > Most access takes recovery_lock for reading and checks whether a reco=
very
> > > or a reset is blocking the device. A few places cannot take the lock =
and
> > > read that state directly instead. All of them fail safe. A stale read
> > > costs an extra refusal or retry, never an unguarded access.
> > >
> > > Interrupt teardown is the one deliberate exception. It flushes the gl=
obal
> > > virqfd workqueue with recovery_lock held, which can make the hold las=
t as
> > > long as a reset on another vfio device. It costs latency, not
> > > correctness.
> > >
> > > I am not sure this is the best way to handle it, and would welcome
> > > suggestions.
> >
> >
> > Thanks for tackling this, Shameer.  The recovery_lock wrapping all
> > these accesses does make me nervous, both in lock complexity and
> > overhead.  Wouldn't it be a better solution to decouple the user
> > interface from the device by replacing the access path via SRCU then
> > doing zap/move/interrupt teardown?
> >
> > Such a solution would have utility beyond the error path.  We could use
> > it for surprise removal/DPC, we could allow a policy to remove the
> > device from the user on unbind, in place of or in addition to the
> > request eventfd we use currently.  In the error case, the intention
> > would be to temporarily suspend access to the device, but if it falls
> > off the bus after recovery, it may turn into a permanent removal.
> >
> > What do you think?  Thanks,
>=20
> Agree. As it stands, it looks not that maintainable due to the lock
> complexity and dependencies.  Let me look at replacing the
> recovery_lock with SRCU and see how that evolves.
>=20
> The generalisation makes sense too. I will keep this series to the error
> path but make sure the mechanism is not tied to it.

One more thing I want to highlight.

This series mostly does fail access if recovery is in progress. Config
space, trapped BAR read and write, the ioctls and DMA-BUF export all
return -EIO while access is blocked.

The one exception is a guest fault on an mmap'd BAR. See patch 7, where
it returns VM_FAULT_RETRY and waits for recovery to finish rather than
failing, and the reason is that failing is not currently useful to the
VMM. On arm64 a failed BAR fault returns a bare -EFAULT from KVM_RUN
with no KVM_EXIT_MEMORY_FAULT, so the VMM gets no address, cannot tell
which device faulted, and cannot map the failure to a device under
recovery.

(+Mike)

However I think it is fixable, as discussed here [1]. That proposes a
KVM exit to userspace with KVM_EXIT_MEMORY_FAULT, filling
run->memory_fault via kvm_mmu_prepare_memory_fault_exit().

I will take a look at the arm64 part, since that is what makes failing
the access actually useful. Once the VMM can resolve the address to a
device and query the recovery state, switching the fault path from wait
to fail is a minimal change, I think.

Thanks,
Shameer

[1] https://lore.kernel.org/all/178221517808.3589966.15538835749975810737@g=
mail.com/#t
