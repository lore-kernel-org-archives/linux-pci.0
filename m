Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B510A390214;
	Wed,  7 Oct 2026 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791366705; cv=none; b=ietk8LQcoxHYtnQoF1h3qFtlsboahWzcXzb7WtPqMCuOxQAi/MIwFBx2bzRqZzABHaKcWwXD+2tUmmhM8fpmdRcQU9b4YwxfUZFZYrVYuniMIdAvVToR4qSBpFPrs6vBXz4yP3JgdVzbneQPd/McelOIuypltUSttGa932BMdG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791366705; c=relaxed/simple;
	bh=mt+iq0lWCHzQfDYrfrlqEtd5P+ap0Q2mMhBWwH5H8S8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p+wFIY/jAIXqp4wS353DZOBHkMazlSFB5JG3tDxlf5ApJGg+CCqinr/SIwHov4OJ9B5493Uu3CRIDiOjbwvpcV0I0Ktt/VRtoEZVTlgUIPB6faOzJqw0GSGyk9DSu6eIqBw5zTxGn/B493BTWw5m6NlklcU/D7cNkO7+e5Ey3GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fpAlJq6W; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fpAlJq6W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791366696; x=1822902696;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=mt+iq0lWCHzQfDYrfrlqEtd5P+ap0Q2mMhBWwH5H8S8=;
  b=fpAlJq6WPD60vdmA7BB6BK03MIDlY3CiVYRnCaEAtXZxSGSlnCUm3236
   be+dmS/nuQ8BWlCNTrGTr1tmpCCWZ1bx6Y54OKlY6vIjyN16PtNnWlVqP
   j+W60QhDysAMzxpNUJaRcYFtDOfOsS7hg98fYgzZR8+i8jwbqXXXlqnJ9
   cBcxcsEgF2xKeRe1/C4/tKbyPBT7FbO9adc7UoDjL0cTJ2cJTyPt9FBAJ
   o5V5dIiccO4ETWTYDFwr8+6Tn37sYo40xBeSBpRGnsTP5xL/Nu//pRNUo
   XShoxTadaciqe5ZqOQmFpomKxeaBMZieuVCUiwL+fm3kU0cWPK3bYG/vn
   A==;
X-CSE-ConnectionGUID: 3ihVVxCORFyRukF5NM3tDA==
X-CSE-MsgGUID: RBHmERA0RKagm9pe2oyM0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="5199"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="5199"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 02:51:35 -0700
X-CSE-ConnectionGUID: kaBsrKAkS+yZ1OBMmGXWjQ==
X-CSE-MsgGUID: MGf0vOAkRRiC1Xg2PU0PqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="285490563"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.245.246.150])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 02:51:32 -0700
Message-ID: <1c9905719331e6229d0f8eb197f547dc060052fc.camel@linux.intel.com>
Subject: Re: [PATCH v2] PCI: Disable not supported reset methods on DG1
 0x4905
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, intel-gfx@lists.freedesktop.org, Joonas
 Lahtinen	 <joonas.lahtinen@linux.intel.com>, Andi Shyti
 <andi.shyti@linux.intel.com>,  Krzysztof Karas <krzysztof.karas@intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, linux-kernel@vger.kernel.org
Date: Wed, 07 Oct 2026 11:51:29 +0200
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

Hi Ville, Bjorn,

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

@Ville, thank you for providing details of the mentioned workaround (off-
list).  I can see that workaround already included in GuC firmware, =C2=A0
however, it doesn't fix the issue I'm trying to address here.  Then,=C2=A0
disabling problematic PCI reset methods on the affected SKU, as proposed,=
=C2=A0
seems the only feasible solution left, I believe.

@Bjorn, can you please get back to this patch and push it forward?

Thanks,
Janusz


>=20
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
