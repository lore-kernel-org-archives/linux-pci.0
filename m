Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B1E38F938;
	Mon, 20 Apr 2026 09:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776678440; cv=none; b=VfGshn/FHpTyHHcA7EgjvAjImh0oBhC7I0Y5M+AVJgqhKWmYUEYQptblrQCWEpeRxmkTn5DeUWFCuw7A9qceAyS4dPQZsf8+DS/vryDcDTFCel5pT2dYZrJfKfu0ziV8l2078cb8o0jalG/hWiAu/gNmtpDrWEAqBwYols5VUlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776678440; c=relaxed/simple;
	bh=JFSro+t5cfTihkk1XTLSii/7TZW36jeEtaup6yNEuCs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iy786GrkyOj4AJM2oMlniky3ceMBk5mbP4qWy0cWpEHnjH6E76ucq1LNQeqXplzBFBe/j/jvqNkZHUFyvCk1OsKw5EOKCp58VpKB9RiWm+Tr5kZjl+bEhi1IX3oxnbUCCiqOZfh58Rc/k4YpYd+mRkROwN/XaePd0Ql2OYEDvVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IeTpZsJK; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IeTpZsJK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776678438; x=1808214438;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JFSro+t5cfTihkk1XTLSii/7TZW36jeEtaup6yNEuCs=;
  b=IeTpZsJKCW7gi8p6i/x7aMc+UGgnx37I2kKkCdAukGpGiJcq+kgIl4nX
   GjGc55d4qjR5x5MUlRifk3+XdjCzk7Rel3rsXFATyd/ka8/BOhBISs44+
   vpWbeBtptgOl17ZkSP4US42e1soe5Ut1XoOZAEKCBy7mpA0nHBz8y5CWj
   E6+WvPimyRhJyzhzJ5J+cMewIkj8ReXs5PW6pn92cz6gxU7j0Ij5Iyx3c
   6dsEU7L7Ec8YS9LFAB4Bcoais7e7uvrazVmsmShvqceNwuvWEBTJeXGaH
   6l2cmS2Xp1xiPOxOtVUaD21UVinl9zlyTX/iQa7NvWFBkXoWYVGl9YjPn
   g==;
X-CSE-ConnectionGUID: lAckB8XuQ/CNgZ09Vr86Vw==
X-CSE-MsgGUID: R43JPxmETXKq574wT1f1cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="94991940"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="94991940"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 02:47:17 -0700
X-CSE-ConnectionGUID: Cq4LhFZUQ5GSWTu6mUchiA==
X-CSE-MsgGUID: Dh4SzLQpS522PYXnc5DLtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="231547815"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.150])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 02:47:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 20 Apr 2026 12:47:06 +0300 (EEST)
To: =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>, 
    Manivannan Sadhasivam <mani@kernel.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>, 
    Richard Henderson <richard.henderson@linaro.org>, 
    Christophe Leroy <chleroy@kernel.org>, 
    Madhavan Srinivasan <maddy@linux.ibm.com>, 
    Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
    Dexuan Cui <decui@microsoft.com>, 
    =?ISO-8859-2?Q?Krzysztof_Ha=B3asa?= <khalasa@piap.pl>, 
    Lukas Wunner <lukas@wunner.de>, Oliver O'Halloran <oohall@gmail.com>, 
    Saurabh Singh Sengar <ssengar@microsoft.com>, 
    Shuan He <heshuan@bytedance.com>, 
    Srivatsa Bhat <srivatsabhat@microsoft.com>, linux-pci@vger.kernel.org, 
    linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 07/24] PCI/sysfs: Convert PCI resource files to static
 attributes
In-Reply-To: <20260417114912.GD1625998@rocinante>
Message-ID: <4083baf4-c1f3-e3a7-12f9-f1936b6fc803@linux.intel.com>
References: <20260411080148.471335-1-kwilczynski@kernel.org> <20260411080148.471335-8-kwilczynski@kernel.org> <eca4c119-65a8-ac84-3869-4064aa1f0829@linux.intel.com> <20260417114912.GD1625998@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1542172744-1776678426=:961"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1542172744-1776678426=:961
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 17 Apr 2026, Krzysztof Wilczy=F1ski wrote:

> Hello,
>=20
> > > -=09/* Expose the PCI resources from this device as files */
> > > -=09for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> > > +=09if (!pci_resource_len(pdev, bar))
> > > +=09=09return 0;
> [...]
> > Did you accidently forget to address some of the comments as I thought =
you=20
> > were agreeing to changing this to resource_assigned() but I found no=20
> > resource_assigned() from entire series?
>=20
> I have not.  Sorry for late reply here.
>=20
> When testing resource_assigned() as replacement for pci_resource_len(),
> none of the resource files would be made visible.
>=20
> The resource_assigned() checks res->parent, but the static .is_bin_visibl=
e
> callback runs at device_add() time, called from pci_device_add() during b=
us
> enumeration, so before pci_assign_unassigned_bus_resources() runs and ins=
erts
> resources into the resource tree via pci_claim_resource(), etc.
>=20
> The call sequence in pci_host_probe() is:
>=20
>   pci_scan_root_bus_bridge()
>     pci_scan_child_bus()
>       pci_scan_slot()
>         pci_scan_single_device()
>           pci_scan_device()
>             pci_setup_device()
>               pci_read_bases()        <- res->start/end set from BARs
>           pci_device_add()
>             device_add()              <- is_bin_visible() runs here
>                                          res->parent still NULL
>=20
>   pci_assign_unassigned_root_bus_resources()
>     pci_claim_resource()
>       request_resource_conflict()
>         __request_resource()          <- res->parent set here
>=20
> At that point, the pci_resource_len() would return a non-zero value as
> res->start and res->end would already be set, but the res->parent is
> still NULL (not yet assigned to tree).
>=20
> The old dynamic code ran from pci_sysfs_init() as a late_initcall (after
> assignment), where resource_assigned() would have worked.
>=20
> As such, we can't really use resource_assigned() together with static
> sysfs attributes, at least not without solving the resources evaluation
> order here.
>=20
> Thank you!

Okay, understood (I already saw you coverletter as well).

This however implies there's no guarantee the resource space range is even=
=20
available for the BAR if the check is not based on ->parent. (Hit a=20
problem like this kind of highlights how using pci_resource_len() is=20
definitely hacky.)

I suppose it would be more proper to always recalculate the sysfs
visibilities after resources have been rearranged (released or assigned).
But as with the BAR resize, there's the race window when releasing BARs
so solving it may be non-trivial to get the ordering right (without mass
removing sysfs files prior to running the resource fitting and assignment
algorithm which doesn't seem wise either).

So to conclude, IMO, this series is a major improvement to state of
things as is and solving this pci_resource_len() vs resource_assigned()=20
within the context of this series doesn't seem worth the extra delay and=20
complexity. Thus, I'm fine with using pci_resource_len() for now.

--=20
 i.

--8323328-1542172744-1776678426=:961--
