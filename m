Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A2B22D4E9;
	Thu,  2 Apr 2026 21:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775163699; cv=none; b=mSHVAosksSCN1cS7DBcpBni4hzVNyPWC6qOmEXDv8oMx/Bq9spFHV59+AW7kbrDb+c/Ch+iKHes9n9VnKDBxJsqI6/SGzLCpug9k3AOMjCfX0sWOL8axuGGT1s4GsYLaVPp9jwdw62yk167X7gVDnBJYniniTx10CHrlau13mMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775163699; c=relaxed/simple;
	bh=3vTaVly+w4XUeC4VeC+Btf1yllZgbSp+sAOkzDviCKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p5pWeKO1OMwE9SS0a6RodbMZ6dOAbgk4b4yYbDal3Z0L8l3V8rQZhSGI7V67d9lR62DywJkuQn4oe742FlDnnX3ivHgQlNB7uy+rsTkCf31yEAWkPtArxCA2AYgG0isO/q6mqUqmm0m1zAtOP/EN812u0NqHi17HFkyTi9n3L3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=VMPibOT0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=diSYRH28; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="VMPibOT0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="diSYRH28"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id BBE15EC011D;
	Thu,  2 Apr 2026 17:01:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 02 Apr 2026 17:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775163694;
	 x=1775250094; bh=OT4udMRoIcAPCd2IxpIhbg8hVlpJN7yE34DwUQAmWRg=; b=
	VMPibOT0iA7iFR0wIhqE2X4qRmYVHmxiwCno3cqqZhAQhgYpg5TonaGx0zGZIwcQ
	NT5rvscSSIwNCl1Zls2c71PbsBhGK3XXGkNR56Ho3G0ce76GDaAaYn/5UKx+HRKp
	0xFTORU9XqxwpZkVn7/Cqerm8TYBfwNKrusrKE3ewpvcNIfWHD9iCFG9RradeaKn
	/oOzjOO5Bv7U9mMkZlyO1Tdh7Jyf/0jgEg+AkzX1lt+TwtmKkHyRvP87U39eC50p
	rfmVUSdvpfpAhj3OzBvM0H0EK9vLBvCk19dKramnqm1enurdng+YiGEbtzVagSAY
	0QooRSHycvIxEPsnUsFexA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775163694; x=
	1775250094; bh=OT4udMRoIcAPCd2IxpIhbg8hVlpJN7yE34DwUQAmWRg=; b=d
	iSYRH28DlmcHWClHxhkEXBnE5X2VOa/ib+uc3N1yHOhSjr/7sxWwOGvpor4WPwTa
	nbdKfnE5GbR+InC3jQZKRXdUwH+GuVkUFjFhrnLcYrI86whR20C5JEiZCBK6xjuP
	C6r6XoV63b/GXwMeBZZeE0NjIHE9Rg8/QNGuroPC9NDlFGdWy/caUo4ce8Ghw1tz
	42d4zM0kxgrxv93p50zhjCt6+2BMtyaeomPN6iNK2Bi+NNBRXHbyn0Po4fN3Uwll
	YC/7GpaMt2pU7wMYL+WzUll1hCY95eZm448HrdKA7lGrcAQdKFITQlZ3pPb5efFz
	dgnAuFLV8cdMdcRzOGeog==
X-ME-Sender: <xms:LdnOafiFZ3awlQNAyrLzAeXshtzSz4tf9sK-Iv1Z5yk18cVElFxdAw>
    <xme:LdnOadrh2RKGiOcVbpDx5A4NKQFMJMxx6Rq-9tONPsVMbcTcHoJ7qPHaJqYc_NqI6
    ZaUsgpbxG1vVBiQuOvVVJHUzlnbAQPW5DPqdsdp62eW1gjxIywS>
X-ME-Received: <xmr:LdnOaTLraG-TKY2kKLRRxesqKxzcWYjD-PV7a5lGqXR0lhBmYYa29l6nngw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpeetlhgvgicuhghi
    lhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrghtth
    gvrhhnpeetuefgleefhfdvueegffdtffevhfffgfffiedutdetgffhheejtdekfeekieeh
    gfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhgpdhn
    sggprhgtphhtthhopedvfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnh
    drjhdrfihilhhlihgrmhhssehinhhtvghlrdgtohhmpdhrtghpthhtohepmhhhohhnrghp
    sehnvhhiughirgdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhdrtggrmhgvrhhonh
    eshhhurgifvghirdgtohhmpdhrtghpthhtohepshhmrgguhhgrvhgrnhesnhhvihguihgr
    rdgtohhmpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtph
    htthhopegurghvvgdrjhhirghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehirhgr
    rdifvghinhihsehinhhtvghlrdgtohhmpdhrtghpthhtohepvhhishhhrghlrdhlrdhvvg
    hrmhgrsehinhhtvghlrdgtohhmpdhrtghpthhtoheprghlihhsohhnrdhstghhohhfihgv
    lhgusehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:LtnOaSu3JKdDJfwBX352cr_BGCjhyit5wPp5vh6ReH9a7vbl_-TNxg>
    <xmx:LtnOabs70Rr_Mi-kIxyg3dFr65hNiGv4ova16ii5WDlKpaZRk9BTMA>
    <xmx:LtnOaRVkdaOklAHRhD_WOB2z_ZhwH4W_dpcGsIBFfgI6EgYFrX7Scg>
    <xmx:LtnOacWLbuJr8hanW7KC_OAvFYzryi7Vw4ZzXpsGOPeFQ1PCuXd7WQ>
    <xmx:LtnOaRYwpSmALwTnagB5em4psfi-E5HQQERT4VfgmS8MZSbsdlnU_x4f>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 17:01:32 -0400 (EDT)
Date: Thu, 2 Apr 2026 15:01:31 -0600
From: Alex Williamson <alex@shazbot.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Manish Honap <mhonap@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, Srirangan Madhavan <smadhavan@nvidia.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "dave.jiang@intel.com"
 <dave.jiang@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
 "alison.schofield@intel.com" <alison.schofield@intel.com>,
 "dave@stgolabs.net" <dave@stgolabs.net>, Jeshua Smith <jeshuas@nvidia.com>,
 Vikram Sethi <vsethi@nvidia.com>, Sai Yashwanth Reddy Kancherla
 <skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Shanker
 Donthineni <sdonthineni@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Derek Schumacher
 <dschumacher@nvidia.com>, "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH 0/5] PCI/CXL: Save and restore CXL DVSEC and HDM state
 across resets
Message-ID: <20260402150131.0abe12e0@shazbot.org>
In-Reply-To: <69cdc273ca48e_1b0cc610042@dwillia2-mobl4.notmuch>
References: <20260306080026.116789-1-smadhavan@nvidia.com>
	<69b08f8d8eb97_490a10042@dwillia2-mobl4.notmuch>
	<20260310164630.7abeed30@shazbot.org>
	<69b0c934b2793_2132100ec@dwillia2-mobl4.notmuch>
	<IA1PR12MB90304014081461742C3977F4BD41A@IA1PR12MB9030.namprd12.prod.outlook.com>
	<69b98960907e9_7ee31003b@dwillia2-mobl4.notmuch>
	<20260317121943.3c404db9@shazbot.org>
	<69cdc273ca48e_1b0cc610042@dwillia2-mobl4.notmuch>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hey Dan,

On Wed, 1 Apr 2026 18:12:19 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Alex Williamson wrote:
>=20
> Hey Alex, sorry for the lag in responding here...
>=20
> > On Tue, 17 Mar 2026 10:03:28 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >  =20
> > > Manish Honap wrote:
> > > [..] =20
> > > > > The CXL accelerator series is currently contending with being abl=
e to
> > > > > restore device configuration after reset. I expect vfio-cxl to bu=
ild on
> > > > > that, not push CXL flows into the PCI core.   =20
> > > >=20
> > > > Hello Dan,
> > > >=20
> > > > My VFIO CXL Type-2 passthrough series [1] takes a position on this =
that I
> > > > would like to explain because I expect you will have similar concer=
ns about
> > > > it and I'd rather have this conversation now.
> > > >=20
> > > > Type-2 passthrough series takes the opposite structural approach as=
 you are
> > > > suggesting here: CXL Type-2 support is an optional extension compil=
ed into
> > > > vfio-pci-core (CONFIG_VFIO_CXL_CORE), not a separate driver.
> > > >=20
> > > > Here is the reasoning:
> > > >=20
> > > > 1. Device enumeration
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >=20
> > > > CXL Type-2 devices (GPU + accelerator class) are enumerated as stru=
ct pci_dev
> > > > objects.  The kernel discovers them through PCI config space scan, =
not through
> > > > the CXL bus. The CXL capability is advertised via the DVSEC (PCI_EX=
T_CAP_ID
> > > > 0x23, Vendor ID 0x1E98), which is PCI config space. There is no CXL=
 bus
> > > > device to bind to.
> > > >=20
> > > > A standalone vfio-cxl driver would therefore need to match on the P=
CI device
> > > > just like vfio-pci does, and then call into vfio-pci-core for every=
 PCI
> > > > concern: config space emulation, BAR region handling, MSI/MSI-X, IN=
Tx, DMA
> > > > mapping, FLR, and migration callbacks. That is the variant driver p=
attern
> > > > we rejected in favour of generic CXL passthrough. We have seen this=
 exact   =20
> > >=20
> > > Lore link for this "rejection" discussion?
> > >  =20
> > > > outcome with the prior iterations of this series before we moved to=
 the
> > > > enlightened vfio-pci model.   =20
> > >=20
> > > I still do not understand the argument. CXL functionality is a library
> > > that PCI drivers can use. =20
> >  =20
> [..]
> > If we were to make "vfio-cxl" as a vfio-pci variant driver, we'd need
> > to expand the ID table for specific devices, which becomes a
> > maintenance issue.  Otherwise userspace would need to detect the CXL
> > capabilities and override the automatic driver aliases.  We can't match
> > drivers based on DVSEC capabilities and we don't have any protocol to
> > define a "2nd best" match for a device alias if probe fails. =20
>=20
> I can see the argument, and why it makes sense to attempt this way
> first. Point conceded.
>=20
> Now a follow on concern is the plan to manage a case of "PCI operation
> is available, but CXL operation is not. Does the driver proceed?" Put
> another way, I immediately see how to convey the policy of "continue
> without CXL" when there is an explicit driver distinction, but it is
> ambiguous with an enlightened vfio-pci driver.

As an enlightenment to vfio-pci, CXL support must in all cases degrade
to PCI support.  Manish's series proposes a new flag bit in the
DEVICE_INFO ioctl for CXL (type2 specifically) that would be used in
combination with the existing PCI flag.  If both are set, it's a PCI
device with CXL.{mem,cache} capability, otherwise only PCI would be set.
=20
> > > If vfio-pci functionality is also a library
> > > then vfio-cxl is a driver that uses services from both libraries. Whe=
re
> > > the module and driver name boundaries are drawn is more an organizati=
on
> > > decision not an functional one. =20
> >=20
> > But as above, it is functional.  Someone needs to define when to use
> > which driver, which leads to libvirt needing to specify whether a
> > device is being exposed as PCI or CXL, and the same understanding in
> > each VMM.  OTOH, using vfio-pci as the basis and layering CXL feature
> > detection, ie. enlightenment, gives us a more compatible, incremental
> > approach. =20
>=20
> Ok, to make sure I understand the proposal: userspace still needs to to
> end up with knowledge of CXL operation, but that need not be resolved by
> module policy.

It's a single module as far as userspace is concerned, and the decision
lies with userspace whether to take advantage of the CXL features
indicated by the device flag.
=20
> Userspace also just needs to be ok with the unsightliness of the CXL
> modules autoloading on systems without CXL.

I'm open to suggestions here.  The current proposal will pull in CXL
modules regardless of having a CXL device.

We could build vfio_cxl_core as a module with an automatic
MODULE_SOFTDEP in vfio_pci_core.  We could then do a symbol_get around
CXL code so that we never CXL enlighten a device if the module isn't
loaded, allowing userspace policy control via modprobe.d blacklists.
We could also use a registration mechanism from vfio-cxl-core to
vfio-pci-core to avoid symbol_gets.

> > > The argument for vfio-cxl organizational independence is more about
> > > being able to tell at a diffstat level the relative PCI vs CXL
> > > maintenance impact / regression risk. =20
> >=20
> > But we still have that.  CXL enlightenment for vfio-pci(-core) can
> > still be configured out and compartmentalized into separate helper
> > library code. =20
>=20
> Yes, modulo some of the proposal here to enlighten the PCI core with CXL
> specifics that I want to give more scrutiny.
>=20
> > > > 2. CXL-CORE involvement
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > >=20
> > > > CXL type-2 passthrough series does not bypass CXL core. At vfio_pci=
_probe()
> > > > time the CXL enlightenment layer:
> > > >=20
> > > >   - calls cxl_get_hdm_info() to probe the HDM Decoder Capability bl=
ock,
> > > >   - calls cxl_get_committed_decoder() to locate pre-committed firmw=
are regions,
> > > >   - calls cxl_create_region() / cxl_request_dpa() for dynamic alloc=
ation,
> > > >   - creates a struct cxl_memdev via the CXL core (via cxl_probe_com=
ponent_regs,
> > > >     the same path Alejandro's v23 series uses).
> > > >=20
> > > > The CXL core is fully involved.  The difference is that the binding=
 to
> > > > userspace is still through vfio-pci, which already manages the pci_=
dev
> > > > lifecycle, reset sequencing, and VFIO region/irq API.   =20
> > >=20
> > > Sure, every CXL driver in the system will do the same.
> > >  =20
> > > > 3. Standalone vfio-cxl
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >=20
> > > > To match the model you are suggesting, vfio-cxl would need to:
> > > >=20
> > > >   (a) Register a new driver on the CXL bus (struct cxl_driver), pro=
bing
> > > >       struct cxl_memdev or a new struct cxl_endpoint,   =20
> > >=20
> > > What, why? Just like this patch was series was proposing extending the
> > > PCI core with additional common functionality the proposal is extend =
the
> > > CXL core object drivers with the same. =20
> >=20
> > I don't follow, what is the proposal? =20
>=20
> Implement features like CXL Reset as operations against CXL objects like
> memdevs and regions. For example, PCI reset does not consider management
> of cache coherent memory, and certainly not interleaved cache coherent
> memory. Other CXL drivers also benefit if these capabilities are
> centralized.

I think "CXL Reset as operations against CXL objects" is large already
proposed as [1].  However, it's specifically for type2 devices, so we
can ignore some of the complications, such as interleaved cache
coherence, of a type3 use case. =20

[1]https://lore.kernel.org/all/20260306092322.148765-1-smadhavan@nvidia.com/

> > > >   (b) Re-implement or delegate everything vfio-pci-core provides =
=E2=80=94 config
> > > >       space, BAR regions, IRQs, DMA, FLR, and VFIO container manage=
ment =E2=80=94 =20
> > >=20
> > > What is the argument against a library? =20
> >=20
> > vfio-pci-core is already a library, the extensions to support CXL as an
> > enlightenment of vfio-pci is also a library.  The issue is that a
> > vfio-cxl PCI driver module presents more issues than simply code
> > organization. =20
>=20
> Understood. As I conceded above my concerns are complications that a
> vfio-cxl module does not solve cleanly.
>=20
> > > >   (c) present to userspace through a new device model distinct from
> > > >       vfio-pci.   =20
> > >=20
> > > CXL is a distinct operational model. What breaks if userspace is
> > > required to explicitly account for CXL passhthrough? =20
> >=20
> > The entire virtualization stack needs to gain an understanding of the
> > intended use case of the device rather than simply push a PCI device
> > with CXL capabilities out to the guest. =20
>=20
> Agree.
>=20
> > > > This is a significant new surface. QEMU's CXL passthrough support a=
lready
> > > > builds on vfio-pci: it receives the PCI device via VFIO, reads the
> > > > VFIO_DEVICE_INFO_CAP_CXL capability chain, and exposes the CXL topo=
logy.
> > > > A vfio-cxl object model would require non-trivial QEMU changes for =
something
> > > > that already works in the enlightened vfio-pci model.   =20
> > >=20
> > > What specifically about a kernel code organization choice affects the
> > > QEMU implementation? A uAPI is kernel code organization agnostic.
> > >=20
> > > The concern is designing ourselves into a PCI corner when longterm QE=
MU
> > > benefits from understanding CXL objects. For example, CXL error handl=
ing
> > > / recovery is already well on its way to being performed in terms of =
CXL
> > > port objects. =20
> >=20
> > Are you suggesting that rather than using the PCI device as the basis
> > for assignment to a userspace driver or VM that we make each port
> > objects assignable and somehow collect them into configuration on top of
> > a PCI device?  I don't think these port objects are isolated for such a
> > use case.  I'd like to better understand how you envision this to work.=
 =20
>=20
> No, simply that CXL operations relative to that assigned PCI device are
> serviced by the CXL core. The object to manage over reset is subject to
> CPU speculative reads and potentially interleave, I think it breaks the
> PCI expectations of local device scope operations.
>=20
> If CXL Reset in particular stays out of the PCI core it at least
> requires something CXL enlightened to be loaded, and at a minimum I do
> not think that "something CXL enlightened" should be the PCI core.
>=20
> There is a reason the CXL specification decided to block secondary bus
> reset by default.
>=20
> > The organization of the code in the kernel seems 90%+ the same whether
> > we enlighten vfio-pci to detect and expose CXL features or we create a
> > separate vfio-cxl PCI driver only for CXL devices, but the userspace
> > consequences are increased significantly. =20
>=20
> Agree.
>=20
> > > > 4. Module dependency
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >=20
> > > > Current solution: CONFIG_VFIO_CXL_CORE depends on CONFIG_CXL_BUS. W=
e do not
> > > > add CXL knowledge to the PCI core;   =20
> > >=20
> > > drivers/pci/cxl.c =20
> >=20
> > This is largely a consequence of CXL_BUS being a loadable module. =20
>=20
> Yes, the question is why does that matter for CXL enlightened operation?
> Simply do not burden the PCI core to learn all the CXL concerns.

How do we then proceed relative to save/restore of CXL state based on a
PCI reset?  Should CXL core register a save/restore handler with PCI
core or does PCI core reach out for a symbol from CXL core to support
save/restore?

If CXL core is not loaded, are we ok with silently losing CXL state
across a PCI reset, ie. assume that state is unused currently and accept
the risk of losing preconfigured decoders?

Does PCI core need to be involved in suppressing SBR?

Thanks,
Alex
