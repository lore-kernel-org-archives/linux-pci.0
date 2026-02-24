Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FB328D83E;
	Tue, 24 Feb 2026 08:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771921329; cv=none; b=hP0xkJvzQTf5bRfjJyv1hvq9DjYd2g3UQyR5Xcb+gJ7QsDAK4Lc0zgsUX2+K9DChN9ULk+35Jn7P05/rWfp2podkPr/hlvddLA53NdgQguRDqp0hhnjqxHla6T9g4l4GjfeCS5w2D3uYh7dlDhH9RxSlg/O8ReqC4TH7Otvx3aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771921329; c=relaxed/simple;
	bh=wJEZQol6y5BzMo+cZOgPyceDAC0XTndGclwnczNkMsc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gM94dWlyfVgvOSdVdfM38ccLHNKixPSQ4xSurcX0wIhujhjPUTXIUcyoP13Lw5yXq3laMFflaqXUET98Ddw2QzSQnUCHu52ZfFT8AUVcKDnSIeDKdAyLfgBnSbAe03ni0ZMxIXghjZnij02eQ9vTZKlIW5anIScED6ZJFAxBVSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DG63WoVN; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DG63WoVN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771921327; x=1803457327;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wJEZQol6y5BzMo+cZOgPyceDAC0XTndGclwnczNkMsc=;
  b=DG63WoVNoqLCrhpuhOyMvf4HLcLsJ2AMeLqnXp2WV2hj29kiI2H1RN4n
   /ZTpUoZUXV5J99PEmzbjcfrSiWX9OXXiIQEa2FwLkdbgCzk2qtukAC65C
   42vMBZ5RPdVbkaaSHUUVBvpMhHXmim/rXmaKW/iN8GLkyBLbL+if3OWaB
   i1rP49dtVSTVsQ0xMlsGHO9UU1yHnr6GBL4fZzc6DA96cA++6nWReHTes
   rwD4lG8oEb89q4ob61C0XS4AQiKQNmxP6lf357v+H9Qmb4pwvLJQrITMa
   2vHG4kP/uFiPIFx3euX+D8LiZvsbmW5fY+WMHCjy8hTTB013GOIYlI5g3
   w==;
X-CSE-ConnectionGUID: /kJXZjKUR6CorrG9g6m8YA==
X-CSE-MsgGUID: dV4PE3lVTx6FUPL6MbOizA==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="83640134"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="83640134"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 00:22:06 -0800
X-CSE-ConnectionGUID: HW5qFQM/TRO0Clobww6uxg==
X-CSE-MsgGUID: dmY+7rMyT9GviCRT2uwjmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="215847868"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.133])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 00:22:01 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 24 Feb 2026 10:21:57 +0200 (EET)
To: Bart Van Assche <bart.vanassche@linux.dev>
cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, 
    Waiman Long <longman@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    Marco Elver <elver@google.com>, Christoph Hellwig <hch@lst.de>, 
    Steven Rostedt <rostedt@goodmis.org>, 
    Nick Desaulniers <ndesaulniers@google.com>, 
    Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>, 
    Jann Horn <jannh@google.com>, Bart Van Assche <bvanassche@acm.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 27/62] pci: Fix locking in pci_do_resource_release_and_resize()
 error paths
In-Reply-To: <20260223220102.2158611-28-bart.vanassche@linux.dev>
Message-ID: <b9694af8-8b78-c35b-7a31-4a54a45a5363@linux.intel.com>
References: <20260223220102.2158611-1-bart.vanassche@linux.dev> <20260223220102.2158611-28-bart.vanassche@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1792140976-1771921317=:1751"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1792140976-1771921317=:1751
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 23 Feb 2026, Bart Van Assche wrote:

> From: Bart Van Assche <bvanassche@acm.org>
>=20
> Make sure that down(&pci_bus_sem) has been called before
> up(&pci_bus_sem) is called.

Before explaining the solution, it would be useful to mention how this=20
problem can manifest itself (taking one of the early gotos).

> This has been detected by the Clang
> thread-safety analyzer. Compile-tested only.
>=20
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Cc: linux-pci@vger.kernel.org

These (obvious) Ccs are not needed in the commit message, if your workflow=
=20
requires having them, please place them below the --- line so that the=20
maintainer's tools remove them while applying the patch.

> Fixes: 337b1b566db0 ("PCI: Fix restoring BARs on BAR resize rollback path=
")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/pci/setup-bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 61f769aaa2f6..3bb8cd9a581e 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -2346,6 +2346,7 @@ int pci_do_resource_release_and_resize(struct pci_d=
ev *pdev, int resno, int size
>  =09if (ret)
>  =09=09return ret;
> =20
> +=09down_read(&pci_bus_sem);
>  =09pci_dev_for_each_resource(pdev, r, i) {
>  =09=09if (i >=3D PCI_BRIDGE_RESOURCES)
>  =09=09=09break;
> @@ -2367,7 +2368,6 @@ int pci_do_resource_release_and_resize(struct pci_d=
ev *pdev, int resno, int size
>  =09if (!bus->self)
>  =09=09goto out;
> =20
> -=09down_read(&pci_bus_sem);
>  =09ret =3D pbus_reassign_bridge_resources(bus, res, &saved);
>  =09if (ret)
>  =09=09goto restore;

--=20
 i.

--8323328-1792140976-1771921317=:1751--
