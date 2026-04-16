Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EC7346FB5
	for <linux-pci@vger.kernel.org>; Thu, 16 Apr 2026 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776341781; cv=none; b=nyfTmttfZckXJCafHwW+q9X0kpdWG6ADHdnfJjKokSi0d3SI5Dh6OnILDvRjB+p77xeaFJ2A98cOOayttRePrFmr9ZG6UF34SGkbWZ+WAqiWlHgYSeAs+LNOwQ/hChJdQArg1icFpgAyNs8sSepunudik46ZSiD9vAErPGxjTpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776341781; c=relaxed/simple;
	bh=6yTXq3YM4brCaDe13GHnyt9btEER+c4kciwHNBZ2ISI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mFYq7Iz7Dsrbtsw5IluWT73kfmlIMgo+XpeWDRLFUurS8pX5fBUoYSfq2+Mlupdn9jShf0AEwj8lGJvAgBK5H+1UNNCbfECjTw/BrHn8M/P055YVeCzkYQcjDFJU9RJjC2bFazhe4RscX3MUnNK3V2MT1X3+3VCvIZPFzdf+tkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b1gDPLPE; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b1gDPLPE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776341781; x=1807877781;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6yTXq3YM4brCaDe13GHnyt9btEER+c4kciwHNBZ2ISI=;
  b=b1gDPLPErQaIPfv5zINo6ivyMuZZ0qDisSjyoWS8Jw+VE5bAV7c1XiMD
   UUu/RVCGpaNrbgFcm9QwKMspYUTnuqTaCK7J7+W7W7NXscroAn20PZCcf
   HfXHJ/ehI1KY7fZpAOPNMT0lV/9JFJ4Qb2ABTQkyhHSkaHERBKzK/W1Rk
   dNJJvLrt7/a4yTw7NkoMChxC3M8aAAoC/gP1+fT8rpGatlqqwtyYjZt+d
   WhoHTYTTSrx5oBB/ceDttBBU3+eWQYmIOYgIaD7N/hamJaYsjC7pWvqVk
   lgH8V3gkRq8GOcSI9nJk4A5II8uDtOKLS6L08Cse8/GFVNLqDduqgcTJu
   A==;
X-CSE-ConnectionGUID: y6sGXenXRSCRxm1Fy6BNJQ==
X-CSE-MsgGUID: WP4Sf4MIQNCtZC8+S2O9bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77314091"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="77314091"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 05:16:20 -0700
X-CSE-ConnectionGUID: WuHe+YMFToG6dRRrzTdWFw==
X-CSE-MsgGUID: Xfz7jsFERumxYO8r/W89tg==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.12])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 05:16:11 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 16 Apr 2026 15:16:08 +0300 (EEST)
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <helgaas@kernel.org>, Bernd Schumacher <bernd@bschu.de>, 
    "Alexandre N." <an.tech@mailo.com>, 
    Salvatore Bonaccorso <carnil@debian.org>, 1131025@bugs.debian.org, 
    Uwe Kleine-Koenig <ukleinek@debian.org>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    Alex Williamson <alex@shazbot.org>, regressions@lists.linux.dev, 
    linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Update saved_config_space upon resource
 assignment
In-Reply-To: <aeDH4XNvwcX7RI0m@wunner.de>
Message-ID: <9fcb46ff-56d2-1504-11a1-ad8449c80b2d@linux.intel.com>
References: <febc3f354e0c1f5a9f5b3ee9ffddaa44caccf651.1776268054.git.lukas@wunner.de> <fa331b71-133c-3773-3ec9-1aecc807fd9b@linux.intel.com> <aeDH4XNvwcX7RI0m@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1183682639-1776341768=:1081"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1183682639-1776341768=:1081
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 16 Apr 2026, Lukas Wunner wrote:

> On Thu, Apr 16, 2026 at 02:08:03PM +0300, Ilpo J=E4rvinen wrote:
> > On Wed, 15 Apr 2026, Lukas Wunner wrote:
> > > Bernd reports passthrough failure of a Digital Devices Cine S2 V6 DVB
> > > adapter plugged into an ASRock X570S PG Riptide board with BIOS versi=
on
> > > P5.41 (09/07/2023):
> [...]
> > > Since a2f1e22390ac, config space is saved on enumeration, prior to BA=
R
> > > correction.  Upon passthrough, the corrected BAR is overwritten with =
the
> > > incorrect saved value by:
> >=20
> > I'm wondering if there's something that makes this problem specific to=
=20
> > only standard BARs?
> >=20
> > Can other resources, namely IOV resources or bridge windows, similarly =
be=20
> > updated "too late" and not get correctly updated into the saved config=
=20
> > space?
>=20
> IOV registers are not saved, they're reconstructed from pci_dev->resource=
[]:
>=20
> pci_restore_iov_state()
>   sriov_restore_state()
>     pci_update_resource()
>       pci_iov_update_resource()
>
> Bridge windows are saved when portdrv probes (see call to pci_save_state(=
)
> in pcie_portdrv_probe()) and that happens after the fs_initcall() because
> portdrv is registered from a device_initcall().  So those should be fine
> as well.
>=20
> (FWIW sashiko also flagged the bridge windows not getting saved as an
> (alleged) problem.)
>=20
> Thanks for taking a look!

Okay, fair.

It feels a bit odd they're all handled differently (not a problem when it=
=20
comes to this patch). Maybe it would make sense to eventually restore them=
=20
all from the pci_dev's resource array. Add something like=20
pci_restore_resources() that would restore all the resources that are=20
relevant for the type.=20

I don't know if that's doable when it comes to the order of things,=20
especially with sriov, but if doable, it would prevent them ever getting=20
out of sync again and would avoid the trouble of having to save them=20
elsewhere.

--=20
 i.

--8323328-1183682639-1776341768=:1081--
