Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C975540BD;
	Tue,  8 Sep 2026 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788881292; cv=none; b=eprihgnZcv1xx1sJ+4+ZrsYyqMBYzVSz14I1mYH5DVSY3FcHqEObP9QbpAIFqd9tG4J4QDG6TGonV5fWoxfdBSscVLWx/qthy5w2ZN6KfIGlsqjeFPDLfO1ZspmR5Sc3gX6mw2MjbbPgeJ/PSwGCmybd2iooSHI8zPO53Kl/I20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788881292; c=relaxed/simple;
	bh=2Pf4PkZDzmSCOfuNpjDKK6J4/gWo2OsDAMD6+QijGuw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i4tFhhjbxJRj+2qScuDafYzfAnu5IX/KyKNwjX9wozDNz3t10bXw9NY60NINYiTUejWl5xobJBcx6K2q3R2v9GC0Zk1U2RsSCbLOL/j8coX/W+FPLj6zCWJqAS6pIhv+TLIuOeGIklJ5VsmWsPdGvg0w+DxL/R0KlUyeghzyPZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TS5AbTzD; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TS5AbTzD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788881288; x=1820417288;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=2Pf4PkZDzmSCOfuNpjDKK6J4/gWo2OsDAMD6+QijGuw=;
  b=TS5AbTzDUZbJmrvDG7R9be2zQVHUf7Jhcc4Hm3nVwYpCR79qbTKUF+5z
   lGtzLhpXbxXsrE4HXWjLGhSIxhWahZNrfl8Xcd9tWHKlEnRvo2nv0a9UU
   D9kmUcJpBM2TDB1If7PyLWp7MeWeLHDnO8gy7rcwa4/axmu3OGheAun2P
   ia49Oi9SleYJMSW9lhHoawWeL/4kd/7SFQg1cuzI2utswpXEyyD9D4Vom
   jLoWxvQ3cTCY1kJAjZ0dwd1l74zejMw7WOS6dFmT7/3AW+OUv/fJLi23t
   CO+S3xLtxKTQTG8WHc1BL1oCn1WnOs9VpP7OSEVrWNP2JDw8o6oNZ/UPA
   A==;
X-CSE-ConnectionGUID: j/QaeMsVRy2aLWKyQq7sGg==
X-CSE-MsgGUID: qiWDC0idSOK7l83D11VlJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="100641852"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="100641852"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 08:28:04 -0700
X-CSE-ConnectionGUID: oCVwWjKVTuufgpdk3XigTQ==
X-CSE-MsgGUID: za2ZcT1hS4GQoadUYRMbuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="276270451"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.245.246.101])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 08:28:01 -0700
Message-ID: <c3f23838e78de7c6300bc4c82088ff738167027b.camel@linux.intel.com>
Subject: Re: [PATCH v2] PCI: Disable not supported reset methods on DG1
 0x4905
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, Joonas Lahtinen	
 <joonas.lahtinen@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
  Krzysztof Karas <krzysztof.karas@intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, linux-kernel@vger.kernel.org, Daniele
 Ceraolo Spurio	 <daniele.ceraolospurio@intel.com>
Date: Tue, 08 Sep 2026 17:27:59 +0200
In-Reply-To: <ap_nbJWGXWTI8ARq@intel.com>
References: <20260907090249.1348552-2-janusz.krzysztofik@linux.intel.com>
	 <ap_nbJWGXWTI8ARq@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-08 at 13:46 +0300, Ville Syrj=C3=A4l=C3=A4 wrote:
> On Mon, Sep 07, 2026 at 10:59:18AM +0200, Janusz Krzysztofik wrote:
> > DRM CI consistently reports failing device reset attempts on Intel DG1
> > discrete graphics adapters.  Manual reproduction attempts allowed to
> > narrow down the scope of that problem to a specific revision of that
> > hardware, SKU 8086:4905.  It has been confirmed that both reset methods
> > claimed by the device, i.e., flr and bus, suffer from that issue.
>=20
> IIRC the documented workaround for the issue is some kind of magic
> register write after the FLR to unblock some internal state machine,
> but the CPU isn't allowed to do that write and instead it has to be
> performed by the GuC. That means we'd somehow have to reinitialize
> the GuC very early after the FLR, which sounds rather difficult.
>=20

Hmm, maybe i915 initialization order could be re-arranged to apply that=C2=
=A0
workaround via GuC before touching the blocked hardware.  If that was=C2=A0
possible then maybe we only needed to use a PCI quirk to block consecutive=
=C2=A0
FLRs before the workaround is applied in order to prevent a hardware=C2=A0
freeze.

I'm adding Daniele to the loop.

Thanks,
Janusz

> >=20
> > Since consecutively failing device resets may lead to system hangs,
> > disable both useless reset methods.  A respective CI test will then be
> > skipped instead of aborting whole CI jobs.
> >=20
> > Suggested-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/118=
14
> > Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
> > Reviewed-by: Krzysztof Karas <krzysztof.karas@intel.com>
> > Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
> > ---
> > v2: Fix commit description wording (Andi)
> >   - add Suggested-by: tag missing from v1,
> >   - add collected Reviewed-by: tags.
> >=20
> >  drivers/pci/quirks.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index de9bbccda21fd..e55475374c6fd 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -3811,6 +3811,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TI, 0xb005=
, quirk_no_bus_reset);
> >   */
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ASMEDIA, 0x1164, quirk_no_bus_r=
eset);
> > =20
> > +/* Intel DG1 0x4905 may not recover from bus reset */
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4905, quirk_no_bus_res=
et);
> > +
> >  static void quirk_no_pm_reset(struct pci_dev *dev)
> >  {
> >  	/*
> > @@ -5597,6 +5600,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x44=
3, quirk_intel_qat_vf_cap);
> >   * AMD Neural Processing Unit 0x1502 0x17f0
> >   * Intel 82579LM Gigabit Ethernet Controller 0x1502
> >   * Intel 82579V Gigabit Ethernet Controller 0x1503
> > + * Intel DG1 Discrete Graphics Adapter 0x4905
> >   * Mediatek MT7922 802.11ax PCI Express Wireless Network Adapter
> >   * Mediatek MT7925 802.11be PCI Express Wireless Network Adapter
> >   */
> > @@ -5612,6 +5616,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1502=
, quirk_no_flr);
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x17f0, quirk_no_flr);
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x4905, quirk_no_flr);
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MEDIATEK, 0x0616, quirk_no_flr);
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MEDIATEK, 0x7925, quirk_no_flr);
> > =20
> > --=20
> > 2.54.0
