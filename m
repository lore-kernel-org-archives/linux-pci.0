Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC994CCDEC;
	Mon, 31 Aug 2026 18:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788201181; cv=none; b=BWB9nrn4XPQbLIoGZh4uOJbMFW01SS1B/BcdALk5gFJZ4/p99ownPF9M1VYQ2PO/k/OI6/h1JPb6RFm+k4TeYHN+HRPZJat2fMGkLeCT7z3Fseg+/bkXrRaHZdrdOktH8yZ423L3/hmevzA5xEKC651tkMyzwSZk2j4i5+wRiNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788201181; c=relaxed/simple;
	bh=qhsge+/69E4jNcWl7mZmEyCtLeMfahz3yWtH0cXD0tc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=o//n+1Z9j8HM1WVfS4vMlXBsDfsW0EzHgGPgE5MVujszaQCsBDVEgykzu8xqe44KWXorq2aQyCLyQayQsCkVW0VNPLowpABs1NRVov+rVlUyUIJpolVXyL17KkVqPMbCkpePlSrqxz5niZE10XmC7mRpRMYyb4BQ1xSuJPtHm3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cDbAYu5k; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cDbAYu5k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788201181; x=1819737181;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qhsge+/69E4jNcWl7mZmEyCtLeMfahz3yWtH0cXD0tc=;
  b=cDbAYu5kPhU7GbRbPZa+YpLj5EcfT6RetAM6Eae6GZAsDC0UmGk2BCfH
   WI7sk6vZa5cibXiR98GYINH/MddqgA0wBT7Eq0ySLkzSMx00ogkHPoCdq
   2QsBGkXiPiJw9dLTmiF2jV2E3AGOEtBuoIJyhzJSm3ZkycBuPLVBNKiSC
   q2UUCii7GIth15wb5wtRvY5wq37/N9ZqFIQQGBnZ+6Jaet+hlVUQVZ7LJ
   o2koIU1B1+YLBpB7XeNwl+/7Mma4WULHA8BXrHmFQ7iAPAUGNJ6HAy41U
   jdXIOAssECF7VhvLvUQSeV1cWEtPmzaRW80gpzu7OVLZc2PRRIunrfUgT
   A==;
X-CSE-ConnectionGUID: dEc+X/ovQbyPP2WPCoDhGQ==
X-CSE-MsgGUID: /svSJPkqTSeruCc9xkUg1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88667388"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="88667388"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 11:33:00 -0700
X-CSE-ConnectionGUID: Vkz1x03HQ5+hjPCvMPu67g==
X-CSE-MsgGUID: f6oTpFKnRCqEacANzmAPrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="293708209"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.121])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 11:32:54 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 31 Aug 2026 21:32:51 +0300 (EEST)
To: Geramy Loveless <gloveless@jqluv.com>
cc: =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, alexander.deucher@amd.com, 
    amd-gfx@lists.freedesktop.org, mario.limonciello@amd.com, 
    nra3088@gmail.com, meiling.leung@embeddedllm.com, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Reserve prefetchable window headroom for Resizable
 BARs
In-Reply-To: <1eb85efc-43f4-4929-8390-467308522236@jqluv.com>
Message-ID: <7366a0bc-360b-0667-ee94-af839374dfed@linux.intel.com>
References: <39e09dd8-f73e-4dc2-ba36-8a9228516d26@jqluv.com> <d4c3ea40-d92a-49c4-ab2c-925fc70c4bb9@amd.com> <d6c56ff3-0b83-4d2e-7e6f-f3e65a284341@linux.intel.com> <1eb85efc-43f4-4929-8390-467308522236@jqluv.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-633456053-1788201171=:2637"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-633456053-1788201171=:2637
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 31 Aug 2026, Geramy Loveless wrote:
> On 8/31/26 9:58 AM, Ilpo J=C3=A4rvinen wrote:
> > On Mon, 31 Aug 2026, Christian K=C3=B6nig wrote:
> >
> >> On 8/28/26 23:37, Geramy Loveless wrote:
> >>> Firmware typically sizes prefetchable bridge windows for the boot-tim=
e
> >>> BAR size. Behind a fixed (non-hotplug) PCIe switch fabric, there is t=
hen
> >>> no room for a driver to grow a Resizable BAR afterwards: every window
> >>> from the leaf up to the root is sized for the small BAR, so
> >>> pci_resize_resource() fails with -ENOSPC.=20
> >>>
> >>> Furthermore, a small prefetchable BAR (e.g., a 2 MiB doorbell) sharin=
g a=20
> >>> bridge's single prefetchable window with a much larger one (e.g., a 3=
2 GiB=20
> >>> VRAM BAR) pushes the required window size past the large BAR's alignm=
ent.=20
> >>> Because bridge windows round up to a power of two, this forces a mass=
ive=20
> >>> alignment waste (e.g., 32 GiB + 2 MiB rounds up to a 64 GiB window,=
=20
> >>> wasting ~32 GiB per GPU).
> >>>
> >>> This patch solves both issues to enable ReBAR on cascaded switch fabr=
ics:
> >>>
> >>> 1. Reserve Headroom:=20
> >>> Reserve prefetchable window headroom for the maximum size of each=20
> >>> downstream Resizable BAR during the bridge sizing pass. The device BA=
R=20
> >>> and hardware ReBAR are left at their boot size to prevent tearing dow=
n=20
> >>> firmware-loaded state (e.g., AMD R9700 PSP) before the driver binds.
> >> Yeah that was suggested before but that is clearly not something you c=
an=20
> >> do in common code.
> >>
> >> The ReBAR fields often doesn't reflect the actual needed space but=20
> >> rather the maximum the HW address logic can resolve.
> >>
> >> So what you end up with is allocating multiple TiB for a window which=
=20
> >> just needs few GiB, sometimes even completely overflowing the 64bit=20
> >> address space made available by the root complex.
>=20
> Yeah I could imagine that would be bad, hence I tried to compact the=20
> 64-bit space as well. As far as I understand PCI/PCIe standards its=20
> making this patch difficult.=20

No compacting will save you in some cases. There are setups with many GPUs=
=20
and with VF BARs, the space requirement to fit full-sized ReBARs is way=20
beyond what the root bus resource can hold. Where's your fallback for such=
=20
cases? What are the failure modes of that fallback?

> Christian I'm not sure if you could share these reference documents but=
=20
> that probably would be a better start for me to look at before I update=
=20
> the patch or make changes, also I need to wait for a review on the last=
=20
> patch I submitted too, so that leaves me with some time to review some=20
> standards if you know specifically where to look, if not thats fine too.
>=20
> > Yes. A naive approach to (only) go to the max ReBAR allows just doesn't=
=20
> > work well enough to be usable in general case.
>
> I did not know the max would report above the amount is actually needed=
=20
> because of vendors decisions in the cards, that's interesting.=20

Not just that, using too large size has ripple effects on other resources=
=20
in the system, and those failures are hard to correct (your code doesn't=20
even try to do that).

> > A general algorithm to pick the largests fitting sizes for ReBARs is st=
ill=20
> > under works, a few steps away still, and more if I discover more=20
> > challenges I need address before I can take that final step.
>
> So then I would assume instead of doing the "hack" i'm having to use I=20
> would change it to your new algorithm?

Assuming you meant we apply this kind of naive approach first and later=20
changing to the new algorithm, the problem with that approach is this
"hack" must not break working setups either, but it surely would. If it=20
does break things, the change will just end up reverted. And that end=20
result is same as not doing the "hack" at all.

It's not enough it doesn't break your setup. It generally must not break=20
any setup, which is unfortunately very very high bar.


--=20
 i.

--8323328-633456053-1788201171=:2637--
