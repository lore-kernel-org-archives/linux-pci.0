Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010039.outbound.protection.outlook.com [52.101.201.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0115637F8CC
	for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2026 15:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065914; cv=fail; b=cit4M3N4uSMjH6X6CBo9S51THjrmfQGe6F/IzPX0U450rVdRYPzBLBX8TwxEmiO/zt93rR6iaKIE8LHEEL9pa2Z/LPo/UQ6qMk32aCDIRHhWwzLyg9vYxHvrPGqCbqApvuf0F8bRsBd1WKf9Apxuiz6kzmyRldhX5YR8X0NxC/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065914; c=relaxed/simple;
	bh=Lzkx5UMk4e33+c4KNHCbVjk78XH+7BhVI8nA5pZDsl4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F4MNQHHN7gJK4Sz99wQPuhg/X/PohiRzstl3j1JnQbqzBh44FaZObBoBZ8Ftx84WUmkVpuhOgXs0IINoGMbyRNsiESigMKOVmA0Ye1lRkGThwfjt/ZmdQ7TjO2v1fSWmO9lder9D6dEHiA20a2ggyZOEEyErlgebKVJQN9VcOzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CfeOd4xk; arc=fail smtp.client-ip=52.101.201.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CfeOd4xk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dz4kjspNy14kFHN+PTt7zgCO71cV7VOjeT6d7SEk/uSdHOSXANwtxKa7ujrWFYnM9huvcNta+PKvMnhMPN00Sih54NYQBBdPVqp/kxkgiCnSguDkLIItRtrGKuIA7mpMEZZRM70XaaqOaTkRDxe8ZG/c/nIcU4Xxqi0tSyoixEpj2oj41watlZ8ylifruoH8tDpIj9SgD83XlooZzRSLAvmMVVnyS3rT1x6dDBAYj+06sS3dxc/UxKiTXqR3Aae1kUeQN7WE1R7qWtTPxkN5Hm8Z4/AEhkJ0l0sqhqBBWvnHAIGQWmjctxopt/nBxmdMtoOmhATa1f4zmASZqTrABw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcOoHco1uTdHtTiIh3U0Owo1UNy2tLUdjbJYQd89Zco=;
 b=N8hTCwT3y8CHiqq/aCO7ReNDhcNMVdZkp01GTZvESWyJMeMACSoeN2/EooAmdBgKWJf/lyKVsUFlHIKcDeJXsjpSiyxd5SMEl4dqqXYa7UgHwanoIip6RvZDb/MPhB3PDxHOufxdAxtW1lwivh3QCdHflHAzVoFiTXCeo9Ymc1ovzbm6XVdpQDs8efuiGSb0ZdK45lCpShlmslK2zIsmIyOyvBqu8wNlu3K0LIfsS7nrYmSqTTyPYA42frBr46fT9ATWtPH7MREkaixPDHpL12dgAmMxKVPp75gyHKKto/+l+iqGqpGesv1sX7Ou1QxsprIx6ok6Vk5dD23yANc0/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcOoHco1uTdHtTiIh3U0Owo1UNy2tLUdjbJYQd89Zco=;
 b=CfeOd4xkOEgzLrM9jvVxP9g0R+FSo6llkDkfU+K5l38Q/DYMmTYLbdLpRS77bX2P1bdBbwb5lxj5RhzkWasTv/rEeR0bf5TAuFbCZyW32ZVx31Y/6FhygPZIoZeoIddGGEzL0cwY6GLyOTi6/I+C1Euu4aHUcy5Wf+bke9En8ljqnktiLvaZ5fZPHoMhoC3/mF9WIkMr7KQUdeFtMNV4q3LOJf2+RiYXH6Fyzoq6ULmmD/vB7nEEkBtfT12hmYxdzRcetQoj+wOFCLK/go6GbDNJ2Nm32GsKxf9ICOz23jci4l2Pz0/hBuqztDwUkE6s1dfUlzZ00sBLk6Q1dVqklw==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by PH7PR12MB7842.namprd12.prod.outlook.com (2603:10b6:510:27a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 15:11:47 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%5]) with mapi id 15.21.0315.012; Tue, 18 Aug 2026
 15:11:46 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Alex Williamson <alex@shazbot.org>, Keith Busch <kbusch@kernel.org>
CC: Keith Busch <kbusch@meta.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "mattev@meta.com" <mattev@meta.com>,
	"matt@ozlabs.org" <matt@ozlabs.org>, "nekto0n@meta.com" <nekto0n@meta.com>,
	"michal.winiarski@intel.com" <michal.winiarski@intel.com>,
	"satyanarayana.k.v.p@intel.com" <satyanarayana.k.v.p@intel.com>
Subject: RE: [PATCH] vfio/pci: Restore standard PCI config space in
 .slot_reset()
Thread-Topic: [PATCH] vfio/pci: Restore standard PCI config space in
 .slot_reset()
Thread-Index: AQHdLx8uQxGr9tuA5UWZf4/rShvzf7aj5BRw
Date: Tue, 18 Aug 2026 15:11:46 +0000
Message-ID:
 <SJ0PR12MB8614C1D1C03ED17025F58B15ABA62@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260817195110.2077698-1-kbusch@meta.com>
	<20260817155006.5be3b518@shazbot.org>	<aoOXc_vyccUXXptU@kbusch-mbp>
 <20260818083754.7ccf76d9@shazbot.org>
In-Reply-To: <20260818083754.7ccf76d9@shazbot.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|PH7PR12MB7842:EE_
x-ms-office365-filtering-correlation-id: a41e55a9-8f17-47ad-e71b-08defd3b055f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|38070700021|6133799003|10067099003|11063799006|5023799004|4143699003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 fbDgi9egMZ5NPVvbwT+e2yHfqhubaz/3R3mIi7yxWnTvLtG6rYfYqOC/ol64DArqT/uzkWEXggKCFqtlrYJwLJdnDtI/2pwGyMLC/8sFXDbIb7YCZM20FIfInnE69nWHaxjMzp/YGrBpzuSopBEvA1YiPL6vAW7WOdig0/1dWowIDWVJcWQHCCnjswrU6OQviqkqLQH4IO5XtWGka7IVxI/ARK5n3YmLGS4Z8LIJaNRBe28FVk4Aa5PwBg2D0tzLYByehAfJHAaldz9w828m3nCSMslnktRY8NLPuO//6mpJGNb+T6u0O8Q1OFuHmU6mVbOP6FBrRJNguGzc4ikGkf47ZOaBujkjQfYl4ZDGOFuzt5hrqqqsY3kj7yI7s1NR602yI3mZr/mr23UzaU7wz0JS3Oe7xtb3/i/qp+oBb896eC8pGz7SvAJKUKbB635mrT5YmAK/iB/ig5v0amO5n/HnLwgoCTEtMQcuj5rVLRRnhE2LH41Wmainca0qx18v6q4pKv0eKiDQzZW3tJ7gpuBXwXgvrYh+VXrRiY9JyjCu8n+G8Y5Xifjd0NyqNjd+LLCSOlhsXwYkF/gmw1K4Qc9Okj6DZ2Wm22napeel+OVs0UOpw7N0CzYgHFmqYgNqJp6egTXG70qyYNomzIw/6ORdVObN9Bj+rYKf3OVVfbogCl0UA2ny26c+mJOV8X5hJ8lLgzWY/ohXP3Ez4TpWlVpQK5DvsNtS5f+r2emshdA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB8614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(38070700021)(6133799003)(10067099003)(11063799006)(5023799004)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?zJJ+5MFiZx/rXclDVKgItmc9qq3Z0jBAK5TZg7W/V9oFSWV/zpDHY2QFMK?=
 =?iso-8859-2?Q?VbSR7IxF7bSK0iXx+Qtmqi/Tw49OGZFI48QFi28kqA0MkD2poe6azTaGX8?=
 =?iso-8859-2?Q?fdm9OgyleujjA9yEzRv1QhGjYqOv/sIyoaYJKDu+WZ0CTIgux7jlPoNB0E?=
 =?iso-8859-2?Q?EsTqZ1QK98MtwSPPsKioPkI5rri/+2z+HlPdtA2V3tsA/avrvdFtf+fCd3?=
 =?iso-8859-2?Q?gnsviN6r4V6p6lSnd8FSu6w9Hb2yxQfsM0MbljQNmgqTYPwxVULkumPX4z?=
 =?iso-8859-2?Q?0buwf5WkyecheNsAl7I4Huh2TiR4Bl325woZoswDh9jxqVwPiA/has8Usy?=
 =?iso-8859-2?Q?+/Ao0j8rziQbySHFy6MiiJ8csweTgdtnD+Ab4mnEGKLdJBOa8sAw+hKzf3?=
 =?iso-8859-2?Q?XjX+HHPC/nPYO+sgvUPUEteKY2faDl879uPUvAT4RLMZF02/GuxXlzcZLs?=
 =?iso-8859-2?Q?UI3Ppxm1HAopN2xDoXEA1QJFND4J9yxwubUt8mTN8RPGJHx7l+RcxEvPSx?=
 =?iso-8859-2?Q?/kS3kR3Tta1spml2hhWtLyd/qPwiJEbfnfSz1G7GsKsFfo1jg+IyChelM9?=
 =?iso-8859-2?Q?pPfWezYXlnTfs1QKjydeSaflVjgCD7IS+OAc2Q95BG/ykRxXJKVr1Zbhr2?=
 =?iso-8859-2?Q?aBa45t2TPf6DJEd7UVZxi83/PsBOq6sulY953/DoTtLCpB38Fs/7aUbpuq?=
 =?iso-8859-2?Q?F9f9avgup7aGb11XQfWPVp7R/8Vt1oFn858pd+kCVIEVtRRIefO4aSJSKk?=
 =?iso-8859-2?Q?P6Yq+/oMJU0aQbo0ZxIv7GFfaiRy8NqUOlxzKbShl/Zsl7XNf2XyAiPdi3?=
 =?iso-8859-2?Q?56MbbSiC2g6JEUkf6XsxhUoCTkGblDp76dvW/fwK4UQTIu6Xl1fgheuBcA?=
 =?iso-8859-2?Q?zur2+NqLnn2Xkp5Ig8n/FUrgNtjLZvgrn1dPl2/YsMfwjySGIWsKl/Aeek?=
 =?iso-8859-2?Q?kRqFv5tTFLu4uP7/Cfk6LxcDDa843/ADXSoEyixkC5sI13QyVEZyaemby2?=
 =?iso-8859-2?Q?zywgogc/cssqoN8bsGvFe/e8OhnFlOQf5+DE7rd2b7NC9WbkKbvohUL2Ck?=
 =?iso-8859-2?Q?S8X3wl21WAbY30SREDUsprCCDhzi34nZQzjBfNMdz5U9PY37cV8HneQN7H?=
 =?iso-8859-2?Q?PrLjUMl6LZbxTg3n9zrXBYibk0VjO7Fb8+QC7gJtiP0m+QvQ08tuPN1tc8?=
 =?iso-8859-2?Q?eWxAfu/IJBOCGnDsN/6hZ8p3L8XW3GPgLng33BQQ9yILsKmF/7Rr9RA3sU?=
 =?iso-8859-2?Q?mVtcQ3VQgkak5bPEGjjm7JTe5VVvBT7DsRUIjeYseTQfcy3kHuqtsyd/LE?=
 =?iso-8859-2?Q?MZtaq3x1KS5Ig5gtSFz4rXEpbSPhMrhW2SFhjAQsFXpQjf272WMGRDf2O0?=
 =?iso-8859-2?Q?yp1imPOnB5wqjEAjlmUsFfEFly+PyNhusQ7I7LqhgcxH3+VF2IHHfdypGW?=
 =?iso-8859-2?Q?bP50SPe/UC7f9Vaq67FDwK043radgCtg5C2mTTh8iOjmlsiG5/Kk9Fliao?=
 =?iso-8859-2?Q?3TSSx+WE20l9KpaetRgAfJBtOOCFPsPwHkbi+QSMWdKf90LinDrb90S2Ub?=
 =?iso-8859-2?Q?qvh/ZSSVMUBVslLZ3w1BJemzaCclwHn4OXAQU43Uo44jCQOgoSYMvaSLGp?=
 =?iso-8859-2?Q?KVaFqFrEWPjjsZ/yz3ws6gOdneq/Gb8hkgdPr+eAsQPnfmnxUMYN7Nowwn?=
 =?iso-8859-2?Q?ftQ1KwgDE5Q3heRaz/o2ofB8OkXKPyx3B9bjDWiIz/saYN/hsAiZyRrO6L?=
 =?iso-8859-2?Q?zvDgcu9OkRNxNrLjwM9FRMftdpVMD7ZBpLIsUhCfZDnTHCIucyHGoRBTCL?=
 =?iso-8859-2?Q?Xx6PDNO7xQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a41e55a9-8f17-47ad-e71b-08defd3b055f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 15:11:46.8160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yd8F+9BwNrpVUdJfM/lhEYYUB0l6Jr1ws231JAGFkReAZF4MUPYZ/mz9U9bT3t1yiw0PgzSPrsZx6iAuEsER7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7842



> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: 18 August 2026 15:38
> To: Keith Busch <kbusch@kernel.org>
> Cc: Keith Busch <kbusch@meta.com>; bhelgaas@google.com; linux-
> pci@vger.kernel.org; mattev@meta.com; matt@ozlabs.org;
> nekto0n@meta.com; alex@shazbot.org; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>
> Subject: Re: [PATCH] vfio/pci: Restore standard PCI config space in .slot=
_reset()
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> [Cc +Shameer]

Thanks Alex.

>=20
> On Mon, 17 Aug 2026 17:21:23 -0600
> Keith Busch <kbusch@kernel.org> wrote:
>=20
> > On Mon, Aug 17, 2026 at 03:50:06PM -0600, Alex Williamson wrote:
> > > > In scenarios where userspace simply needs the underlying hardware
> > > > restored to its known-good baseline state post-reset, having vfio-p=
ci
> > > > implement .slot_reset() and leverage the existing PCI core snapshot=
 via
> > > > pci_restore_state() bridges this gap cleanly.
> > >
> > > Does it though?  Even for a simple reset to initial state we need to
> > > prevent the host and guest stepping on each other across the reset as
> > > well as tear down user modified state, like interrupts.
> >
> > Specifically considering host-guest interactions, I don't think this
> > scenario is handled at all. After 14 years, this is the state of QEMU:
> >
> >   static void vfio_err_notifier_handler(void *opaque)
> >   {
> >       VFIOPCIDevice *vdev =3D opaque;
> >
> >       if (!event_notifier_test_and_clear(&vdev->err_notifier)) {
> >           return;
> >       }
> >
> >       /*
> >        * TBD. Retrieve the error details and decide what action
> >        * needs to be taken. One of the actions could be to pass
> >        * the error to the guest and have the guest driver recover
> >        * from the error. This requires that PCIe capabilities be
> >        * exposed to the guest. For now, we just terminate the
> >        * guest to contain the error.
> >        */
> >
> >       error_report("%s(%s) Unrecoverable error detected. Please collect=
 any
> data possible and then kill the guest", __func__, vdev->vbasedev.name);
> >
> >       vm_stop(RUN_STATE_INTERNAL_ERROR);
> >   }
> >
> > Is there another common VMM that actually does something useful to
> > continue from this event?
>=20
> Not that I'm aware of, the kernel interface really isn't designed for
> recovery, it's designed only to notify.
>=20
> > Outside virtualization, I'm more interested in enabling user space
> > DPDK-like drivers. I don't want to break anyone, so starting small here=
:
> > restoring the config space to the baseline before the device was handed
> > to a user space driver feels right.
>=20
> But we have no hand-back-to-userspace mechanism currently.  Alone, it's
> certainly a step towards letting the device run again, but we really
> need more uAPI defined to provide coordination.
>=20
> > > > A few questions I'd like to put to the list:
> > > > 1. Since the PCI core already takes responsibility for holding the =
early
> > > >    config space checkpoint, is calling pci_restore_state() during
> > > >    .slot_reset() the appropriate place for vfio-pci to apply it, or
> > > >    should this be explicitly driven/triggered via a VFIO ioctl?
> > > > 2. Does returning PCI_ERS_RESULT_RECOVERED here create subtle state
> > > >    issues if userspace directly modified config space registers tha=
t
> > > >    were not captured in pdev->saved_config_space?
> > > > 3. Should we pair this with an explicit "link restored / reset comp=
lete"
> > > >    eventfd notification so userspace knows exactly when it is safe =
to
> > > >    resume access?
> > > >
> > > > Appreciate any feedback or historical context on how VFIO and PCI e=
rror
> > > > recovery should interact here.
> > >
> > > Certainly the host saved state doesn't take into account user
> > > manipulation of the device since the last snapshot.
> >
> > Yeah, the kernel emits an eventfd that an error occured. The user side
> > should have some baseline from which to proceed. It feels outside the
> > scope of user space to save and restore such low level and early
> > initialization things like the PCI BAR config space.
>=20
> There's a fair bit of config space the user cannot write, particularly
> BARs, so a VM has an obligation to restore the virtualized BARs to make
> a coherent view of the device, but a userspace driver can't effect a
> meaningful value change of the physical BAR register anyway.
>=20
> > Also consider that the user space side may not have even been
> > initialized at the time a PCIe error occured. What happens then?
>=20
> I'd tend to think a userspace driver would consider aborting if the
> device is triggering errors before they've even touched it.  Closing
> the device writes back the state saved on open.
>=20
> > > But also, vfio-pci error handling is currently limited to generating
> > > an event when a non-recoverable error has occurred.  I don't think we
> > > can nudge it forward in any meaningful way by implementing a
> > > .slot_reset to restore a prior host snapshot.  That misses the user
> > > modified state, coordination across error handling, and may not even
> > > match the hand-off state of the device to the user.
> >
> > I totally agree. Lacking a notification, user space can at best poll
> > something specific to their device, but it'd be better to generically
> > coordinate this sequence with the kernel's error handling.
> >
> > Would it be acceptable to introduce additional eventfd's for each part
> > in the pcie error handling? Privately, I've proposed and tested the
> > user-space component to quiesce on .error_detected, then start from
> > scratch after the .slot_reset. But I still need something to restore th=
e
> > config space, and I feel kernel is the right place to do it.
>=20
> Absolutely the kernel needs to provide some restore of the device,
> especially where the user doesn't have access.  We need some mechanism
> for the user to observe the host recovery and know when it can access
> the device again.  I provided my high level vision of that in the link
> I previously shared.  Shameer has also been looking into this and can
> share his plans.

[+Micha=B3, +Satyanarayana]
=20
Right. I am working on a series trying to do much of what Alex described
in the other thread.  Currently in internal review and testing.

On the eventfd question, what I have is one recovery eventfd plus a
feature reporting the state and a sequence number, rather than one
eventfd per callback. The state says whether recovery is in progress,
whether the channel was frozen, whether the device was reset, and
whether it failed. A non-fatal recovery can complete before userspace
reacts to the event, so the state and the sequence are more use than
catching each phase live, I think.

In short:

- error_detected() stops being a single "something went wrong" signal.
  It votes on the actual channel state: CAN_RECOVER for a non-fatal
  error, NEED_RESET for a frozen channel, DISCONNECT for a permanent
  failure, and signals userspace that an event has started.
- slot_reset() restores config space with pci_restore_state(), tears
  down user modified interrupt state so it is rebuilt rather than
  resumed, and records that the device was reset for userspace to read.
- resume() puts PCI_COMMAND back, restores the DMA-BUF exports, unblocks
  access and signals the eventfd again. Userspace reads the state from
  the feature to see the event has finished.
- The device is blocked from user access for the whole sequence: config
  space, BARs, faults on mapped BARs, interrupts, DMA-BUF exports,
  runtime PM. That is most of the series, and getting the locking right
  is the hard part here.

It is opt-in. Until userspace installs the recovery eventfd, vfio-pci
behaves exactly as it does today.

With the state visible, QEMU can virtualise the AER capability to the
guest, through the AER interrupt or GHES, so a non-fatal error the host
recovered from need not end in vm_stop().

I plan to post it as an RFC once the merge window closes.
Would appreciate any comments in the meantime.

Thanks,
Shameer

