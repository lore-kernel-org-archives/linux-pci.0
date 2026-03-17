Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BA133067A;
	Tue, 17 Mar 2026 11:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773748075; cv=none; b=IpzIUAzjz7AaJIGT9QieFZZDM27rKRAK/YpXzoaEk+iDPtrcPP3RBvbG4Wjg34Dbfk3p/IA96dHY+sImmXQY1keRND8FbnDjeJ9DyECWmXvNFwJMpfYEpwmeRWrCGizSKSVIYzqacBQKFX9chPz2lJOEzlYzxL/C+k9QDV82ACU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773748075; c=relaxed/simple;
	bh=JdQasyzbMwQG4UJ6BxEFeSmYOOI5nM9Nngo91aNREe4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hOby9TVlMI3y/K8F/89/BDLsbw2xNjUgPgpjPmrk2WKYEw1WPRPI7/CcYmWa06MKlglG2wU/TFIfGZ6H8jIEHbK4IjMicYa5y4r8MVdix61uQhAIsDSn2lKpqhU6M6oCLLYZkapzeeGoNqbbZHjWHNorNKsPx5+QISz1fZNihaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aJUpCofq; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aJUpCofq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773748074; x=1805284074;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=JdQasyzbMwQG4UJ6BxEFeSmYOOI5nM9Nngo91aNREe4=;
  b=aJUpCofqHY+HWqwh996zR8i7kSfnrK6G/UaywDrtiISkgejpu5YN/B9u
   yxAjIvpJro1Y/zj1jChWV/pIDFiUZXhMOUly6uV35vz5ALCrasVYgLH2P
   M9Xrt5ZD6Hbx4km5q+4WF+LQqfO9GH364Llaq35U5oQWXPwqssh5A8d+a
   X3jvQiiOOeQ/bs5uqYGtmslvalnHnxB33l0rx25knds1hpNJ94+17IWGr
   xQJg37yoa00DB1x2pcJ3jIE8yjCWOuYwiUjIkYvmqbac4Kqv2xN9ZrHPv
   dc4qXV/fTFdRBB9sLto4HhMnBNbxi1r6ZSleyloq2+urEABqFKcl469Oj
   g==;
X-CSE-ConnectionGUID: 1kVz/8rVRH+4sKLo7W6+cw==
X-CSE-MsgGUID: VhxcF7yxSNqXqGpwKXo5OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74894413"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74894413"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 04:47:53 -0700
X-CSE-ConnectionGUID: xoXiTkqNTdiMkqPkFoJ4kQ==
X-CSE-MsgGUID: JCFW171WTKSqFvCJxs7QSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="227217242"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.161])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 04:47:51 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 17 Mar 2026 13:47:46 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: =?ISO-8859-2?Q?Micha=B3_Pecio?= <michal.pecio@gmail.com>, 
    linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    LKML <linux-kernel@vger.kernel.org>, regressions@lists.linux.dev
Subject: Re: [REGRESSION 6.14] Some PCI device BARs inacessible
In-Reply-To: <20260316201651.GA23314@bhelgaas>
Message-ID: <12da4009-3f6e-3fea-8d21-f8c9d66f7102@linux.intel.com>
References: <20260316201651.GA23314@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1619845209-1773747867=:968"
Content-ID: <74457b6c-5b44-7f35-8488-74f2c85f7fe9@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1619845209-1773747867=:968
Content-Type: text/plain; CHARSET=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <5749c0c7-bac2-95bc-1be3-cdfecc78e941@linux.intel.com>

On Mon, 16 Mar 2026, Bjorn Helgaas wrote:

> [+cc Ilpo, +bcc bugzilla reporters and commenters]
>=20
> On Fri, Apr 18, 2025 at 10:29:26AM +0200, Micha=B3 Pecio wrote:
> > Hi,
> >=20
> > This is a heads up that an apparent PCI regression has been reported
> > and mistakenly assigned to USB in the kernel bugzilla:
> >=20
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D220016
> >=20
> > Visible symptom is missing USB devices, but the whole controller fails
> > to probe, apparently due to devm_request_mem_region() returning NULL,
> > see drivers/usb/core/hcd-pci.c and usb_hcd_pci_probe().
> >=20
> > Same systems also show a similar failure with some AHCI controller.
> > It seems specific to particular ASUS AMD motherboards.
> >=20
> > Somebody found that disabling CONFIG_PCI_REALLOC_ENABLE_AUTO helps.
> >=20
> > That's all I know, reporters can be reached via bugzilla.
>=20
> I see some activity in the bugzilla but no resolution.  Ilpo has done
> a lot of work in this area since v6.14, though, so I wouldn't be
> surprised at all if this has been fixed.=20
>=20
> Would anybody be interested in testing v6.19 or v7.0-rc to see if this
> problem still exists?

My plan was to look at this ticket again anyway (or has been for like a=20
few months now but there has been higher prio items get in the way of=20
looking the ticket up).

(It went to lower prio bin once it was determined it was not a real
regression but fc enabling pci=3Drealloc. Despite that, I'd still want to=
=20
have it fixed eventually.)

--=20
 i.
--8323328-1619845209-1773747867=:968--
