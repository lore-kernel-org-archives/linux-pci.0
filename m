Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D5E47A0DB;
	Fri, 15 May 2026 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847311; cv=none; b=ZPZjsYnoINUu1rIXD7KUCbujXqUIV0MzY4tHnEzuy0u1r2h1qu/7zZTgWnbTfHhFsQ262e8yQ9gSWmPyrJtWLTr+6sDUB3xsxtlvITnHGeRu+WQeTbqcyRJBLQOYNDnmOBWdTiINQHFo6psCXIgJjTCLGFNuExnm05ewtVldyK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847311; c=relaxed/simple;
	bh=dDyRnV72i6kmAIiy5lgpLJLxg2wKgDOKNGkSOvF6m6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKnswNwnOfb3aL75wCa1r9Z+ib5gdkwcElG0UzcH2fD7rVZbjMW65QBtA3SJFJqJTKrsNR8Qcp/SMZB4OIZqUjuaHDpL9OX9KR2kYbyUWY1gf/tb4oteq6e3UOhXqpUp5Ee66OIWA1F5yhqR2bgrO+8u80uOE87aQ05+/gWPIm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lEg/81GO; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lEg/81GO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778847308; x=1810383308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dDyRnV72i6kmAIiy5lgpLJLxg2wKgDOKNGkSOvF6m6w=;
  b=lEg/81GOwN+LgVJ0Rb8nvBA/h+fT4UwxjAc/3yriOlFr9t8UAWo6G+ZU
   bvuyWOGL8lni0HL8twKjbDrfQ6lmE3iixJSR0ULcSj4PFhXiWbejb1Cvf
   qYwdJOovZhhkejC0c65+Zwhcv2YEPgUVRSur3vwUkUDG3QRH2ynOPmIiZ
   oEkGItfdoJdAWGVMMjIVovdxrBykTcTb/wWdxdUXGVHdUZkRCZ46cQ6iQ
   OYvZ+UvQSUz8qBThCbQlkPKO+pLtyvIctxgwqYxuXz5EkuKWIenlUohNp
   Ohd1a13vx/rjZmWdyZkRkvYbhcqec3j5ZpZ4/QQ5YfjVoCkW0xRaNSHB5
   w==;
X-CSE-ConnectionGUID: /Cvt/y3PRUyUJHuCdONjtQ==
X-CSE-MsgGUID: WN2Bc1LdRH2Hs8gpMeP5XQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="83657076"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="83657076"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:15:07 -0700
X-CSE-ConnectionGUID: o1ADz2HHQlqe/uZsRK035g==
X-CSE-MsgGUID: 5XGYQFe6QuqwzfSq6TpzFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="238787099"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 15 May 2026 05:15:04 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 4A43F95; Fri, 15 May 2026 14:15:02 +0200 (CEST)
Date: Fri, 15 May 2026 14:15:02 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, sashiko-reviews@lists.linux.dev,
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	Marco Nenciarini <mnencia@kcore.it>,
	Michal Winiarski <michal.winiarski@intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Eric Chanudet <echanude@redhat.com>,
	Jean Guyader <jean.guyader@gmail.com>,
	Alex Williamson <alex@shazbot.org>, Sinan Kaya <okaya@kernel.org>,
	Mario Limonciello <superm1@kernel.org>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1] PCI: Wait for device readiness after D3hot ->
 D0uninitialized transition
Message-ID: <20260515121502.GK84797@black.igk.intel.com>
References: <20260514200625.C6877C2BCB3@smtp.kernel.org>
 <20260514213811.GA434353@bhelgaas>
 <20260515114134.GJ84797@black.igk.intel.com>
 <CAJZ5v0igy2g0zCJrY8wsFiDzVvQUkQH=y6EM1M50rPB-04G3MQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0igy2g0zCJrY8wsFiDzVvQUkQH=y6EM1M50rPB-04G3MQ@mail.gmail.com>

On Fri, May 15, 2026 at 01:57:13PM +0200, Rafael J. Wysocki wrote:
> On Fri, May 15, 2026 at 1:41 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > On Thu, May 14, 2026 at 04:38:11PM -0500, Bjorn Helgaas wrote:
> > > On Thu, May 14, 2026 at 08:06:25PM +0000, sashiko-bot@kernel.org wrote:
> > > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > > - [High] Ignored return value of `pci_dev_wait()` masks hardware readiness timeouts
> > > > --
> > > >
> > > > commit 606c3a6294de4df52ee7dc27a7792cef6c8f72c4
> > > > Author: Bjorn Helgaas <helgaas@kernel.org>
> > > >
> > > > PCI: Wait for device readiness after D3hot -> D0uninitialized transition
> > > >
> > > > This commit adds a call to pci_dev_wait() after transitioning a device from
> > > > D3hot to D0uninitialized. This ensures the device is ready to accept config
> > > > accesses, especially for devices with No_Soft_Reset == 0.
> > > >
> > > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > > index 8f7cfcc000901..9d0fc9fbb76a0 100644
> > > > > --- a/drivers/pci/pci.c
> > > > > +++ b/drivers/pci/pci.c
> > > > [ ... ]
> > > > > @@ -1341,10 +1351,14 @@ int pci_power_up(struct pci_dev *dev)
> > > > >   pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, 0);
> > > > >
> > > > >   /* Mandatory transition delays; see PCI PM 1.2. */
> > > > > - if (state == PCI_D3hot)
> > > > > + if (state == PCI_D3hot) {
> > > > >           pci_dev_d3_sleep(dev);
> > > > > - else if (state == PCI_D2)
> > > > > +         if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
> > > > > +                 pci_dev_wait(dev, "power up D3hot->D0uninitialized",
> > > > > +                              PCIE_RESET_READY_POLL_MS);
> > > >
> > > > Is it safe to ignore the return value of pci_dev_wait() here?
> > > >
> > > > If the device times out or disconnects, pci_dev_wait() returns -ENOTTY. By
> > > > ignoring this error, pci_power_up() continues, unconditionally sets
> > > > dev->current_state = PCI_D0, and can return success (1 for need_restore).
> > > >
> > > > If pci_power_up() returns success, will callers like pci_back_from_sleep()
> > > > execute pci_restore_state() against an unresponsive device, which could
> > > > potentially trigger PCIe Master Aborts, AER events, or system crashes?
> > > >
> > > > Should pci_power_up() propagate the error from pci_dev_wait() to prevent
> > > > this?
> > >
> > > Good point.  I think it should look like this instead:
> > >
> > >     if (state == PCI_D3hot) {
> > >             pci_dev_d3_sleep(dev);
> > >             if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET)) {
> > >                     ret = pci_dev_wait(dev, "power up D3hot->D0uninitialized",
> > >                                        PCIE_RESET_READY_POLL_MS);
> > >                     if (ret) {
> > >                             pci_err(dev, "Not ready after soft reset\n");
> > >                             dev->current_state = PCI_D3cold;
> >
> > I wonder if PCI_POWER_ERROR makes sense here?
> 
> Not really, PCI_POWER_ERROR is mostly used by things like
> "target_state" to indicate that nothing has been selected.

Okay. Thanks.
