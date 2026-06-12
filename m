Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6103A3E9C2B;
	Fri, 12 Jun 2026 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781265028; cv=none; b=HHujfr2NLpfGM/u18ru457R5zbk10y0qHnVEWiBZZb8u/W0ea5IbX3s9QGugVAd+wVvsS8T8OBfaFqMqkGIuSeYUbSXjDGxk2CbigjLKwMEKFS62ZWSE1FSIfyk++dM5Zfg4IouaJRuHBpj1O39Vy/ggJfg3+2oUMe24+VsdY70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781265028; c=relaxed/simple;
	bh=J6GLAr2FW67tGJ9wFG3aEziqOWOjQ80L6GvpcFfNQns=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qJTWNVGyAOOFTwCvCoKwPEBIpJ9/KFjLW/GOunLtZQB2QB+joOg0jlokSNGsaFPewzqbBKpvvsOc+mr9wt8Ml4Ro9f7gbQIJVYblayyXXflA022TKXWr8Yr3t1lCBvfOQI2RhaBb4HURIu2UZpKYa6Nm7fppPJgUL/xiJ5c6YBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c5C/AuUr; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c5C/AuUr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781265026; x=1812801026;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=J6GLAr2FW67tGJ9wFG3aEziqOWOjQ80L6GvpcFfNQns=;
  b=c5C/AuUrpk+oFHca94fpgCymdMARM+zFPD+ahygsOQibdcVKIBnzn6sK
   VvuR7nydkmR5sfmvZr5vsG7PKzf9V333mWdqTIboVQVIupaJS3ftxot6v
   4i9KgP8SPjah9nzw2SWEpfRHaaAaFMhRN5pFlds3UXXkfzjLevZRmGBWg
   ChPB9PDh3sMLKWpke+eytJ1YwxTkMhty3WUU1spRGbUkL5EtK37Gq+lF9
   L82ab1Y2BCpBnimiYKzX8dTL1UeCAItjlYVvC7agrYYnvyVpE+xBTLdlg
   BBMVS2T1hLqL7PRJq/IaPggitW9KtGG5O1khZBz43sCLq7PkWek7EI0j+
   g==;
X-CSE-ConnectionGUID: 4SIRm6RMTcuZBowr5GQpUA==
X-CSE-MsgGUID: QnDlr2pCSpKMjkxNJp3Tzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="84661978"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="84661978"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 04:50:25 -0700
X-CSE-ConnectionGUID: 9qzTIavXSZmlXNMa03/diA==
X-CSE-MsgGUID: njm1IhwSS0GiY/IEb9WuOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="242420679"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 04:50:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 12 Jun 2026 14:50:17 +0300 (EEST)
To: Bjorn Helgaas <bhelgaas@google.com>
cc: linux-pci@vger.kernel.org, Shawn Jin <shawn.jin@asteralabs.com>, 
    linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
    Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/11] PCI: Lower bound bridge window alignment
In-Reply-To: <20260429122617.7324-11-ilpo.jarvinen@linux.intel.com>
Message-ID: <4a35f669-b13b-c07a-fbd6-a8ea1ce9a38b@linux.intel.com>
References: <20260429122617.7324-1-ilpo.jarvinen@linux.intel.com> <20260429122617.7324-11-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-143881065-1781265017=:1266"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-143881065-1781265017=:1266
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 29 Apr 2026, Ilpo J=C3=A4rvinen wrote:

> pci_resource_alignment() does not consider bridge windows special,
> yet their alignment is subject to different requirements from BAR
> alignment.
>=20
> Add lower bound to bridge window alignment to help callers out to
> always have large enough alignment.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Hi Bjorn,

Could you please pull this change and the subsequent one, the commits in=20
pci/resource:

ae09d28ecbbc ("PCI: Lower bound bridge window alignment")
cf996b886675 ("PCI: Return valid alignment for assigned resources")

The rest of the changes in this series seem okay and can proceed if you're=
=20
okay with keeping a partial series.

The reason for this request is the dev->bus vs dev->subordinate issue=20
sashiko mentioned in its review.

I've tried to come up with a solution to that but it has become so ugly
I have not been very happy with it. Maybe there's no other way but the=20
problem boils down with pci_min_window_alignment() having to be capable of=
=20
dealing two cases, each lacking one of the key pointers (bus or bridge=20
dev):

1) root bus without bus->self
2) bridge without a subordinate bus struct (if subordinate bus' alloc=20
   failed)

Only way to solve that I could think of is passing both the bus and the=20
bridge device to pci_min_window_alignment() and the related arch side=20
function pcibios_window_alignment(). The ugliest parts then involve=20
getting a bus pointer compatible with both of those cases, like this:

=09struct pci_controller *phb =3D pci_bus_to_host(bus ? bus : bridge->bus);

But it's too late in the cycle now to try even that, IMO, so better to=20
wait to the next cycle.

--=20
 i.

--8323328-143881065-1781265017=:1266--
