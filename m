Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D0C34678E;
	Tue, 17 Mar 2026 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773771591; cv=none; b=retqAmOcEWiKsLbAy8P/8yuxiCsWHJ0M5irZN5Sg15uUTO7F5/PSlKzCY6KlSvsZpcZk/PGEqmNtr3zzVDKP5zT6EI/EaQUgZ/E2vvoJeF1xmp2NdChLKHFrNYqny99xzwsYs3QWW7qIBHgNIRKjSyOo0ZHsrH1cI0hKkPiE1S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773771591; c=relaxed/simple;
	bh=VknSP7AsNhzYAMAu69Qbeg2vfjagirTpnhC0WiUxS2M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aM1sI+AF24Sddcvn3cGkgkJVwIkQxoZGIzoe3UPoZyBdbkGym8z7HWLPnSlD1XsiutNH1plmNcWDCvXGyARGniHxba14PwcXY6In2XnqoR2e0/SsWVcAwRhpQ7fpEtqHKfc4YFN0pkFQGYF5NTuy+Nd/fvCQm/0xY6n4gLuJgXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=cyfwnh6z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ygsBqi+w; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="cyfwnh6z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ygsBqi+w"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BB6AD14001B6;
	Tue, 17 Mar 2026 14:19:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 17 Mar 2026 14:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773771587;
	 x=1773857987; bh=nk3X4rMHnTMPIUl/5W453YKpUlryY9xsURJM/tP0XQU=; b=
	cyfwnh6zqQv3srZ5mpBiI7rvg7j/UIDnUANI45J3vdSDUqVgUMTMKW4v97QXtv7N
	C+Bitrx2hwFhMyV1N4JzbScFnetfRXc4e9Pvau7cO72vL4sCr1pDO7m5XMSmlREO
	URtrw98JG4a931EvBXAuJUJlkzIv5+rOhS7vS765V/9uzExQI4ytZt4X6DKd/sIQ
	jpe4ECTMKv+XFstaGyu1HSS6BvKikWpWv4wUjEk6nd6e1KzeR3QcIGf7lCZFo+vS
	gjv4TFJzS+Gn9uWsFjagRvjDG7aPpJhBLGMQR7uUk0Lrw1+rhWUzwMkKD0yNN/TU
	BNNJ2He/ZtotawmqOQV9PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773771587; x=
	1773857987; bh=nk3X4rMHnTMPIUl/5W453YKpUlryY9xsURJM/tP0XQU=; b=y
	gsBqi+wekwEE6qoD5xHHiNgE8UqF2U5naJhVjOv9jW7MCvoeAvA7M3D/kxmSwkFg
	t8e3v4pG6P297Cn21KH1Vv26a7t6RihzWpLTV96jAggOxua8fmW8ZbkRNiCyqyZF
	/2RtB5JYen8P2ta0v2Hd7EsadPNvDYRADNkXLLgVtArXacrkTjRgRU09srpGHJQ5
	YnJpruIJkUzk8MPO1gXnzkPTw2xoGg9ODXnyLyw/gvaHDQyqdW3iTBLIxpRTLBsO
	X9OzjzZ9XKn8CxVt9tPIGhZwlyA2dFnjVDCX0dAQCNXnj7RgIfeUbk9iVAaVrgQ8
	+0e5GWg2XajWhol6zV36A==
X-ME-Sender: <xms:Q5u5aT0gX2HJ3ItuYWYMg53crkw8HzFSiq3ZQgpcMNAdUd7xAzbKwA>
    <xme:Q5u5aTuPfKBKit9Gjpr-2RJ1iS_2AY0cjGAvhclvuEAdmjWmifKOdmaBknyUumhoE
    h3LDTT87FQslVwRDLcONFxRQyoLqUWFDRz9VV3w78lo_c1b5rf5MrE>
X-ME-Received: <xmr:Q5u5aX_j3dhC8UsY9PUVL-vmfJEfE0lD-0vtFXnicZxvcKB3urkURcheXbM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdduleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeetuefgleefhfdvueegffdtffevhfffgfffiedutdetgffhheejtdekfeek
    ieehgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhg
    pdhnsggprhgtphhtthhopedvfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepug
    grnhdrjhdrfihilhhlihgrmhhssehinhhtvghlrdgtohhmpdhrtghpthhtohepmhhhohhn
    rghpsehnvhhiughirgdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhdrtggrmhgvrh
    honheshhhurgifvghirdgtohhmpdhrtghpthhtohepshhmrgguhhgrvhgrnhesnhhvihgu
    ihgrrdgtohhmpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprh
    gtphhtthhopegurghvvgdrjhhirghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehi
    rhgrrdifvghinhihsehinhhtvghlrdgtohhmpdhrtghpthhtohepvhhishhhrghlrdhlrd
    hvvghrmhgrsehinhhtvghlrdgtohhmpdhrtghpthhtoheprghlihhsohhnrdhstghhohhf
    ihgvlhgusehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:Q5u5afSdA1LVVykEuAWWO0BxIKelWPcXh1r6jH5QnvZ5y5s7dF9JNg>
    <xmx:Q5u5aVAVXi48UkpJRvLfsT9RBo4vno_LqNINbXyEGzKVveuqtYVWJA>
    <xmx:Q5u5aYbmRU36LgDZvOpeUawuOyZRyS-xR3qQp1MrVZz2IoMpDS6B4A>
    <xmx:Q5u5aeKbk8N_yIbHSus5QalIEwb47Th9oGIhEB7DT_iPFQLxoGGUTA>
    <xmx:Q5u5afMYCxrHce5IEJuiPkj82seMOC7Br3aQTFxU0m4bI0RzUcphbS8L>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 14:19:45 -0400 (EDT)
Date: Tue, 17 Mar 2026 12:19:43 -0600
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
Message-ID: <20260317121943.3c404db9@shazbot.org>
In-Reply-To: <69b98960907e9_7ee31003b@dwillia2-mobl4.notmuch>
References: <20260306080026.116789-1-smadhavan@nvidia.com>
	<69b08f8d8eb97_490a10042@dwillia2-mobl4.notmuch>
	<20260310164630.7abeed30@shazbot.org>
	<69b0c934b2793_2132100ec@dwillia2-mobl4.notmuch>
	<IA1PR12MB90304014081461742C3977F4BD41A@IA1PR12MB9030.namprd12.prod.outlook.com>
	<69b98960907e9_7ee31003b@dwillia2-mobl4.notmuch>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Mar 2026 10:03:28 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Manish Honap wrote:
> [..]
> > > The CXL accelerator series is currently contending with being able to
> > > restore device configuration after reset. I expect vfio-cxl to build =
on
> > > that, not push CXL flows into the PCI core. =20
> >=20
> > Hello Dan,
> >=20
> > My VFIO CXL Type-2 passthrough series [1] takes a position on this that=
 I
> > would like to explain because I expect you will have similar concerns a=
bout
> > it and I'd rather have this conversation now.
> >=20
> > Type-2 passthrough series takes the opposite structural approach as you=
 are
> > suggesting here: CXL Type-2 support is an optional extension compiled i=
nto
> > vfio-pci-core (CONFIG_VFIO_CXL_CORE), not a separate driver.
> >=20
> > Here is the reasoning:
> >=20
> > 1. Device enumeration
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > CXL Type-2 devices (GPU + accelerator class) are enumerated as struct p=
ci_dev
> > objects.  The kernel discovers them through PCI config space scan, not =
through
> > the CXL bus. The CXL capability is advertised via the DVSEC (PCI_EXT_CA=
P_ID
> > 0x23, Vendor ID 0x1E98), which is PCI config space. There is no CXL bus
> > device to bind to.
> >=20
> > A standalone vfio-cxl driver would therefore need to match on the PCI d=
evice
> > just like vfio-pci does, and then call into vfio-pci-core for every PCI
> > concern: config space emulation, BAR region handling, MSI/MSI-X, INTx, =
DMA
> > mapping, FLR, and migration callbacks. That is the variant driver patte=
rn
> > we rejected in favour of generic CXL passthrough. We have seen this exa=
ct =20
>=20
> Lore link for this "rejection" discussion?
>=20
> > outcome with the prior iterations of this series before we moved to the
> > enlightened vfio-pci model. =20
>=20
> I still do not understand the argument. CXL functionality is a library
> that PCI drivers can use.

This is a key aspect of the decision to "enlighten" vfio-pci to know
about CXL.  Ultimately the vfio driver for CXL devices is a PCI driver,
it binds to a PCI device.  We've developed macros for PCI devices to
identify in their ID table that they provide a vfio-pci override
driver, see for example the output of the following on your own system:

$ grep vfio_pci /lib/modules/`uname -r`/modules.alias

The catch-all entry is vfio-pci itself:

alias vfio_pci:v*d*sv*sd*bc*sc*i* vfio_pci

A vfio-pci variant driver for a specific device will include vendor and
device ID matches:

alias vfio_pci:v000015B3d0000101Esv*sd*bc*sc*i* mlx5_vfio_pci

Tools like libvirt know to make use of this when assigning a PCI
hostdev device to a VM by matching the most appropriate driver based on
these aliases.  They know they'll get a vfio-pci interface for use with
things like QEMU with a vfio-pci driver option.

If we introduce vfio-cxl, that also binds to a PCI device, how do we
end up making this automatic for userspace?

If we were to make "vfio-cxl" as a vfio-pci variant driver, we'd need
to expand the ID table for specific devices, which becomes a
maintenance issue.  Otherwise userspace would need to detect the CXL
capabilities and override the automatic driver aliases.  We can't match
drivers based on DVSEC capabilities and we don't have any protocol to
define a "2nd best" match for a device alias if probe fails.

> If vfio-pci functionality is also a library
> then vfio-cxl is a driver that uses services from both libraries. Where
> the module and driver name boundaries are drawn is more an organization
> decision not an functional one.

But as above, it is functional.  Someone needs to define when to use
which driver, which leads to libvirt needing to specify whether a
device is being exposed as PCI or CXL, and the same understanding in
each VMM.  OTOH, using vfio-pci as the basis and layering CXL feature
detection, ie. enlightenment, gives us a more compatible, incremental
approach.

> The argument for vfio-cxl organizational independence is more about
> being able to tell at a diffstat level the relative PCI vs CXL
> maintenance impact / regression risk.

But we still have that.  CXL enlightenment for vfio-pci(-core) can
still be configured out and compartmentalized into separate helper
library code.

> > 2. CXL-CORE involvement
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > CXL type-2 passthrough series does not bypass CXL core. At vfio_pci_pro=
be()
> > time the CXL enlightenment layer:
> >=20
> >   - calls cxl_get_hdm_info() to probe the HDM Decoder Capability block,
> >   - calls cxl_get_committed_decoder() to locate pre-committed firmware =
regions,
> >   - calls cxl_create_region() / cxl_request_dpa() for dynamic allocatio=
n,
> >   - creates a struct cxl_memdev via the CXL core (via cxl_probe_compone=
nt_regs,
> >     the same path Alejandro's v23 series uses).
> >=20
> > The CXL core is fully involved.  The difference is that the binding to
> > userspace is still through vfio-pci, which already manages the pci_dev
> > lifecycle, reset sequencing, and VFIO region/irq API. =20
>=20
> Sure, every CXL driver in the system will do the same.
>=20
> > 3. Standalone vfio-cxl
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > To match the model you are suggesting, vfio-cxl would need to:
> >=20
> >   (a) Register a new driver on the CXL bus (struct cxl_driver), probing
> >       struct cxl_memdev or a new struct cxl_endpoint, =20
>=20
> What, why? Just like this patch was series was proposing extending the
> PCI core with additional common functionality the proposal is extend the
> CXL core object drivers with the same.

I don't follow, what is the proposal?
=20
> >   (b) Re-implement or delegate everything vfio-pci-core provides =E2=80=
=94 config
> >       space, BAR regions, IRQs, DMA, FLR, and VFIO container management=
 =E2=80=94
> >       either by calling vfio-pci-core as a library or by duplicating it=
, and =20
>=20
> What is the argument against a library?

vfio-pci-core is already a library, the extensions to support CXL as an
enlightenment of vfio-pci is also a library.  The issue is that a
vfio-cxl PCI driver module presents more issues than simply code
organization.
=20
> >   (c) present to userspace through a new device model distinct from
> >       vfio-pci. =20
>=20
> CXL is a distinct operational model. What breaks if userspace is
> required to explicitly account for CXL passhthrough?

The entire virtualization stack needs to gain an understanding of the
intended use case of the device rather than simply push a PCI device
with CXL capabilities out to the guest.
=20
> > This is a significant new surface. QEMU's CXL passthrough support alrea=
dy
> > builds on vfio-pci: it receives the PCI device via VFIO, reads the
> > VFIO_DEVICE_INFO_CAP_CXL capability chain, and exposes the CXL topology.
> > A vfio-cxl object model would require non-trivial QEMU changes for some=
thing
> > that already works in the enlightened vfio-pci model. =20
>=20
> What specifically about a kernel code organization choice affects the
> QEMU implementation? A uAPI is kernel code organization agnostic.
>=20
> The concern is designing ourselves into a PCI corner when longterm QEMU
> benefits from understanding CXL objects. For example, CXL error handling
> / recovery is already well on its way to being performed in terms of CXL
> port objects.

Are you suggesting that rather than using the PCI device as the basis
for assignment to a userspace driver or VM that we make each port
objects assignable and somehow collect them into configuration on top of
a PCI device?  I don't think these port objects are isolated for such a
use case.  I'd like to better understand how you envision this to work.

The organization of the code in the kernel seems 90%+ the same whether
we enlighten vfio-pci to detect and expose CXL features or we create a
separate vfio-cxl PCI driver only for CXL devices, but the userspace
consequences are increased significantly.
=20
> > 4. Module dependency
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > Current solution: CONFIG_VFIO_CXL_CORE depends on CONFIG_CXL_BUS. We do=
 not
> > add CXL knowledge to the PCI core; =20
>=20
> drivers/pci/cxl.c

This is largely a consequence of CXL_BUS being a loadable module.
=20
> > we add it to the VFIO layer that is already CXL_BUS-dependent. =20
>=20
> Yes, VFIO layer needs CXL enlightenment and VFIO's requirements imply
> wider benefits to other CXL capable devices.
>=20
> > I would very much appreciate your thoughts on [1] considering the above=
. I want
> > to understand your thoughts on whether vfio-pci-core can remain the sin=
gle
> > entry point from userspace, or whether you envision a new VFIO device t=
ype.
> >=20
> > Jonathan has indicated he has thoughts on this as well; hopefully, we
> > can converge on a direction that doesn't require duplicating vfio-pci-c=
ore. =20
>=20
> No one is suggesting, "require duplicating vfio-pci-core", please do not
> argue with strawman cariacatures like this.

I think it comes down to whether the enlightenment maps to the existing
granularity of the core module.  Reset is probably a good example, ie.
how does the device being CXL affect the emulation of FLR, initiated
through device config space, versus the device reset ioctl.  The former
should maintain the CXL.io scope while the latter has an expanded scope
with CXL.
=20
> > [1] https://lore.kernel.org/linux-cxl/20260311203440.752648-1-mhonap@nv=
idia.com/ =20
>=20
> Will take a look...

Thanks!

Alex
