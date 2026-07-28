Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CB73B27C1;
	Tue, 28 Jul 2026 10:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785236182; cv=none; b=aw2qQA5CNYx21GK5h2TuVtwQy7ybtRb1SkuxlbFfn3t//LgJsXQl47Q8cRnKTklFMJPcCh5hk0dAw/59bw4HcTMQtfLB7V78435qMWYC0bnj06LWu1G9602wb4htUJ463nGukz8N2ivaX9icbP/o2Gzj2KyDZ/z9ZMeTyYsicqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785236182; c=relaxed/simple;
	bh=Ay9EAlKod0UJ6+5FwZaME8U/P/TOlNLjGYZUyZeV3lM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bwvWtIH0Ak1efe0capWpQIRyRpHdNu9Ih8khi592SlaViSIoj2jF98spDopOdl+tR6ilN+hry62mf8s1TNF66gdt44pWlSKqa8PRx/jRJ3RwfQuupAvW+URPjytpkSWfSVeWaOISstPNRIxK6yNXvnvnEnmrMwIqm2np6Bw+BM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fyr/WPcO; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fyr/WPcO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785236180; x=1816772180;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=Ay9EAlKod0UJ6+5FwZaME8U/P/TOlNLjGYZUyZeV3lM=;
  b=fyr/WPcOTlcnEH0bP1zKLLK0cTmYS/TL2ik0bsJnJ409PjykuzPNMuYw
   POXTXINSh+5Ywgr1Uhy9wxZGxndjfWZdPoc4nBnDHmrWF8BMUwar6C7dY
   pGA1bls6cNwWInHgDLFGF6yZncYZr+1Q+LNF6HAPovB+Xv7z0DLwvwsRy
   Xooyup96EhlIzi9ix7JyanjcNXEAFdrmwTuG+uIxMrHMwN4la9QndssnE
   k2Rj6MTTkstifodK28ubDr8dFqzWFKV1lYvL5oyw8ZdZX9sFJc6kgasoA
   YWbSpZ0xy1PhfcJQhzx74PUfDL5SO2LVZA88At14IT0eqqrj4oAUbLj0S
   A==;
X-CSE-ConnectionGUID: GEIKfpFzTR6ELSILIfkZlA==
X-CSE-MsgGUID: w64Wa7nnSY2pPSsaQPsing==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="89637230"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="89637230"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 03:56:18 -0700
X-CSE-ConnectionGUID: hl/DN0ndSuS6n83LgSi8DA==
X-CSE-MsgGUID: GLOMtuFATfyEw1YllpGZEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="256327656"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.129])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 03:56:16 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 28 Jul 2026 13:56:12 +0300 (EEST)
To: Anthony Pighin <anthony.pighin@nokia.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Don't report fully optional resources as assignment
 failures
In-Reply-To: <20260727193940.599340-1-anthony.pighin@nokia.com>
Message-ID: <fef3d3a9-f049-5616-6490-d603df995e92@linux.intel.com>
References: <20260717180029.1829888-1-anthony.pighin@nokia.com> <0d249665-2d76-7609-f78b-71ec1a94b507@linux.intel.com> <20260727193940.599340-1-anthony.pighin@nokia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-2136576882-1785235308=:1174"
Content-ID: <ba66a0f6-9eef-059d-e2d8-46d3229ce986@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2136576882-1785235308=:1174
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <2cbf890b-58e7-9edc-6810-acd732a5a8ec@linux.intel.com>

On Mon, 27 Jul 2026, Anthony Pighin wrote:

> v2: https://lore.kernel.org/linux-pci/20260727193714.598562-1-anthony.pig=
hin@nokia.com/
>=20
> On Mon, 20 Jul 2026, Ilpo J=E4rvinen wrote:
>=20
> > This part seems valid, the resource should not be left into enlarged
> > state if the assignment fails.
>=20
> Kept in v2.  reassign_resources_sorted() saves the required size and
> restores it when the optional attempt fails.
>=20
> > > +=09=09if (fail_head && resource_size(res) &&
> > > +=09=09    !pci_resource_is_optional(dev, pci_resource_num(dev, res))=
) {
> >
> > This, however, will break some cases I think.
> >
> > We first want to try fitting also optional resources, if those optional
> > resources never go into fail_head, there won't be new pass and not enou=
gh
> > upstream bridge windows will be released so the algorithm won't really =
end
> > up even trying to fit the optional resources after this change if FW le=
ft
> > some bridge window too small.
> >
> > Only after that has been tried, it should try to fallback into fitting
> > only required resources.
>=20
> You're right about the pci_resource_is_optional() check.  It also covers
> IOV BARs and disabled ROMs, which have a real requested size, so it would
> have kept them out of fail_head and killed the release/retry rounds they
> depend on.  The effect is worse in the root bus path, where a pass failin=
g
> only on optional resources would break the loop before the iteration that
> passes add_list.  v2 drops it and keeps only the zero-size check.
>=20
> The case where FW left a window too small should still work, though.
> pbus_size_mem() sizes the window from the required child resources, so
> such a window has a non-zero required size and still reaches fail_head
> and the retry round. So does a child BAR that fails to fit.  Only a
> window with required size 0, where nothing downstream needs that type at
> all, is skipped.

So a window which contains only optional BARs would not result another=20
pass to retry? While probably rare, there are such bridge windows=20
because we recently hit that corner case in pbus_size_mem_optional() where=
=20
the entire window was optional with required size being zero, and I had to=
=20
fix the logic there. Even if there wouldn't be such devices, I think your=
=20
reasoning is still not entirely sound.

> reassign_resources_sorted() also still tries the enlarged window where it
> always did, so the optional fit is attempted as before; v2 only restores
> the size when that attempt fails.  What v2 gives up in the size-0 case is
> the extra pass, which releases live sibling windows to win headroom
> nothing requested.
>=20
> > I don't even know what that issue is since you don't show what happens
> > with the extra pass after release and why it fails.
>=20
> Apologies, v1 omitted it.  v2 carries the full sequence.

Unfortunately, v2 didn't tell me what happened to igb's BAR (in the end)=20
as you cut the log out after the driver failed.

> The extra pass
> does not fail to assign, it succeeds, and that is the problem.  The
> failing reserve is on 00:03.5, but pci_prepare_next_assign_round()
> releases the window of its parent bus, so every non-prefetchable window
> on bus 00 goes with whole_subtree, along with every BAR below them, and
> each bridge is reprogrammed right away.  The reassignment only covers the
> hotplugged bridge, so none of that is restored.  00:03.5 ends up with a
> 2MB window nothing asked for, and the igb loses its BARs while its driver
> is bound.

So the entire fitting and assignment operation moved the igb BAR or igb's
BAR is entirely gone (partial assignment failure)?

In any case, the resource fitting algorithm should not be touching BARs=20
that are in use! ...But we likely lack check for that, which should be=20
fixed. I'm not even entirely sure though how that can be checked, is it=20
enough the check if a BAR has at least one child resource?

I would not be very surprised if there are other similar problems that=20
can only occur in hotplug case where it goes to tear down something that=20
is in use. For bridge windows, there's some attempt to prevent releasing=20
windows that still have children, but for the actual BARs, I don't recall=
=20
seeing effort to prevent releasing them. Maybe it could be placed into=20
something generic such as pci_release_resource(), not all its callers seem=
=20
to handle errors from it though so some extra work to deal with those is=20
required as well.

And as mentioned in v2 email, release_child_resources() works on a wrong=20
level to be able to detect things properly so a PCI level replacement may=
=20
have to be added to be able to access PCI level structs to know what=20
resource is BAR, bridge window and what is a child resource for BAR.

--=20
 i.
--8323328-2136576882-1785235308=:1174--
