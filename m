Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79FF140E5F;
	Tue, 10 Mar 2026 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773182798; cv=none; b=flOOLGtJqvMkJIaS9eBr3O+5LqCEhGLCV5BzMc6F1tD2AIB9Wb0+kQx5vW/VspJOTLhHO4itDrVtHZ8hglFQ3Kcb+2nEOdeLz26a25nH1Mws9W4vEZfSbu5L2me3s0Wu8fVonQY3MQ6n+//dwkjqPeNvoTkt8jxEPUXJDZx4Dc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773182798; c=relaxed/simple;
	bh=qsM0fuG94Zt7jiKE8o/9UIQ2RCOVrdk0eYB7pbhlHBI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=maS08ZzxpIGfb+LSWMxD5j9YS0cBSW5LjODaMDR2jsRazK8sFw7Dd/feisWC8FatBJoZWiCN+gplpVqqRqqppxoA2gEIE6Zm/UB4FFvsFeE4JaP07Z2RGt/NCHcTDqjZPzuf19pG3nttjaQsA1TZBb0ni/Gk0NFmrbe8MvEs2lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=b0xvBO0n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m/n/Ccux; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="b0xvBO0n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m/n/Ccux"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0E0CA140006C;
	Tue, 10 Mar 2026 18:46:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 10 Mar 2026 18:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773182795;
	 x=1773269195; bh=OlHiG4EXHo7m5gJvI3icSNymsKZga4tDyKXg8k64YY0=; b=
	b0xvBO0nyZMid2Oqe7Lh4B/J0+G3x1ISXfbM5yVKlS2KEjR/TTN42oxEiR9KuGID
	Ai+SukE2a8wl0NZmFiCn2H2u7xOD79zOmdhp4lsFj1Jd/IX0AS6vKLkUvaf7Ycgv
	WzFAmZZwietaKoM0fHho30DSINzD12zZ4DETZA8Sp3hyNhMxkfJsHZkcOjyE8jC1
	Peu4uE85PNh/CyltNcpluo2eG0FMiaGuxQEaiS5H0n99qpFCvY6hHFSLtK1e9FgT
	o9GEcSuKTAAK4RqBPlqMuonR/7JJuP0C0JH8lzFonazN8b/DimTF2x5GOlSYsOmE
	l3JDxnUmOY/IF6hl/xx2mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773182795; x=
	1773269195; bh=OlHiG4EXHo7m5gJvI3icSNymsKZga4tDyKXg8k64YY0=; b=m
	/n/Ccux7M/JUZ9jsghd00Ms9N4TIoevOnlkfDNCw1r/+AVPq/qN7AtlsBJAr8RDu
	yqig1LBUAkSmi/aoN6W4LVnYTVfpqXNrIMiHoLZh51q6BZi6MtDVAw/CiD2p52Uc
	TjokHM2TirxQ+zqw17ArrRFdvdOPDuKEl+lTQCIFDOT9psHZC/owaO4TzqT8hZjm
	keqX5mmlUw+b9zFaFyOc4BvuxhWkgwwRyKq03AWmDz3+yVBiVY1JVofOf1UHHSHR
	sv++kxPeT/GVURBsVfH3mKJok0lCJBtxblTjidQkM05OSkWf9LQMm/RKW+Csjq3r
	nF1mDu4LjeId5SW7dnohw==
X-ME-Sender: <xms:Sp-waVK0kLzuYT_jltF6QSJ_--59kVsLa4y9gGhuHLi8RfJYSBD9cw>
    <xme:Sp-waSx6_7ggCWxdcY_uCTJb4evoQeCR_qHj3tZA2Z5mgneVpEka2RbxBYv4Ydpfe
    rmOxAaZx_g-P4xPGZ_zN7qFaYYSrELqqqqgSV6EmtwCQxuWNPCsMw>
X-ME-Received: <xmr:Sp-waRxy3HtFrwxk3FXSAEcDqoezVg6x-P6zKl3lvozv1na4YzI65hzJppE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedvvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeegudevhfejueefveduieeuueeifeettdekveekhffgvdetfeelueehgfdt
    heffhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepvdefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrlhgvgiesshhhrgiisghothdrohhrghdprhgtph
    htthhopegurghnrdhjrdifihhllhhirghmshesihhnthgvlhdrtghomhdprhgtphhtthho
    pehsmhgrughhrghvrghnsehnvhhiughirgdrtghomhdprhgtphhtthhopegshhgvlhhgrg
    grshesghhoohhglhgvrdgtohhmpdhrtghpthhtohepuggrvhgvrdhjihgrnhhgsehinhht
    vghlrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnrdgtrghmvghrohhnsehhuhgrfi
    gvihdrtghomhdprhgtphhtthhopehirhgrrdifvghinhihsehinhhtvghlrdgtohhmpdhr
    tghpthhtohepvhhishhhrghlrdhlrdhvvghrmhgrsehinhhtvghlrdgtohhmpdhrtghpth
    htoheprghlihhsohhnrdhstghhohhfihgvlhgusehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:Sp-wac1kQwuoI9VLhUr_IHt4OxB6tRvtws7Nbi4RisoN5jV_a6P_3Q>
    <xmx:Sp-wabW1ONmdF1TJsruwIzE0XMHcKNNUPi3w6adjF3Liql1K3TYu1A>
    <xmx:Sp-waYfvkutzJD4wMpNkdHMEwa_cQHNmPvVerKTlsyeaa0yPJTbD_A>
    <xmx:Sp-waU9XY4sme6WPxxOPVhQ346PaYOANI1pIKaf-kmWBhiIfSs_nsg>
    <xmx:S5-waSDZTqF5IRXhp-Lu8lokuY96dJx8cyu47a5hv86uJD6koUXY6WZ->
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 18:46:32 -0400 (EDT)
Date: Tue, 10 Mar 2026 16:46:30 -0600
From: Alex Williamson <alex@shazbot.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: alex@shazbot.org, <smadhavan@nvidia.com>, <bhelgaas@google.com>,
 <dave.jiang@intel.com>, <jonathan.cameron@huawei.com>,
 <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
 <alison.schofield@intel.com>, <dave@stgolabs.net>, <jeshuas@nvidia.com>,
 <vsethi@nvidia.com>, <skancherla@nvidia.com>, <vaslot@nvidia.com>,
 <sdonthineni@nvidia.com>, <mhonap@nvidia.com>, <vidyas@nvidia.com>,
 <jan@nvidia.com>, <mochs@nvidia.com>, <dschumacher@nvidia.com>,
 <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] PCI/CXL: Save and restore CXL DVSEC and HDM state
 across resets
Message-ID: <20260310164630.7abeed30@shazbot.org>
In-Reply-To: <69b08f8d8eb97_490a10042@dwillia2-mobl4.notmuch>
References: <20260306080026.116789-1-smadhavan@nvidia.com>
	<69b08f8d8eb97_490a10042@dwillia2-mobl4.notmuch>
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

On Tue, 10 Mar 2026 14:39:25 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> smadhavan@ wrote:
> > From: Srirangan Madhavan <smadhavan@nvidia.com>
> >=20
> > CXL devices could lose their DVSEC configuration and HDM decoder progra=
mming
> > after multiple reset methods (whenever link disable/enable). This means=
 a
> > device that was fully configured =E2=80=94 with DVSEC control/range reg=
isters set
> > and HDM decoders committed =E2=80=94 loses that state after reset. In c=
ases where
> > these are programmed by firmware, downstream drivers are unable to re-i=
nitialize
> > the device because CXL memory ranges are no longer mapped.
> >=20
> > This series adds CXL state save/restore logic to the PCI core so
> >
> > that DVSEC and HDM decoder state is preserved across any PCI reset
> > path that calls pci_save_state() / pci_restore_state(), for a CXL capab=
le device. =20
>=20
> The PCI core has no business learning CXL core internals.
>=20
> For example, I have been pushing the CXL port protocol error handling
> series to minimally involve the PCI core. Just enough enabling to
> forward AER events, but otherwise PCI core stays blissfully unaware of
> CXL details. The alternative is maintenance burden to the
> PCI core that I expect is best to avoid.
>=20
> > HDM decoder defines and the cxl_register_map infrastructure are moved f=
rom
> > internal CXL driver headers to a new public include/cxl/pci.h, allowing
> > drivers/pci/cxl.c to use them.
> > This layout aligns with Alejandro Lucero's CXL Type-2 device series [1]=
 to
> > minimize conflicts when both land. When he rebases to 7.0-rc2, I can mo=
ve my
> > changes on top of his. =20
>=20
> I think we need to evaluate where things stand after both the CXL port
> error handling series and the CXL accelerator base series have landed.
> Not that they are functionally dependendent on each other, but there is
> a review backlog that needs to clear, and those establish the precedent
> about where CXL functionality lands between PCI core, CXL core, and CXL
> enlightened drivers.
>=20
> > These patches were previously part of the CXL reset series and have been
> > split out [2] to allow independent review and merging. Review feedback =
on
> > the save/restore portions from v4 has been addressed.
> >=20
> > Tested on a CXL Type-2 device. DVSEC and HDM state is correctly saved
> > before reset and restored after, with decoder commit confirmed via the
> > COMMITTED status bit. Type-3 device testing is in progress. =20
>=20
> It is a memory hot plug event.An accelerator driver can coordinate
> quiescing CXL.mem over events like reset, a memory expander driver can
> not. The PCI core can not manage memory hot plug.  It is the wrong place
> to enable this specific CXL reset because PCI core has no idea about the
> suitability of reset at any given point of time.
>=20
> Now, the secondary bus reset enabling for the CXL did end up with
> changes to the PCI core:
>=20
> 53c49b6e6dd2 PCI/CXL: Add 'cxl_bus' reset method for devices below CXL Po=
rts
>=20
> ...but only to disambiguate that hardware may be blocking secondary bus
> reset by default. However, as the cxl_reset_done() handler shows, there
> is zero coordination. One might get lucky and be able to see those
> dev_crit() messages before the kernel crashes in the memory expander
> case.

A constraint here is that CXL_BUS can be modular while PCI is builtin,
but reset is initiated through PCI and drivers like vfio-pci already
manage an opaque blob of PCI device state that can be pushed back into
the device to restore it between use cases.  If PCI is not enlightened
about CXL state to some extent, how does this work?

PCI core has already been enlightened about things like virtual-channel
that it doesn't otherwise touch in order to be able to save and restore
firmware initiated configurations.  I think there are aspects of that
sort of thing here as well.  Thanks,

Alex
