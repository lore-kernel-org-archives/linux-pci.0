Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4461DFDE;
	Fri,  8 May 2026 00:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778199422; cv=none; b=ZUyXLhqF12rBCiyhVQVIRrrbRQ3LPHeHhzh0LqGVpkpYYi5AIg19pGLnboExISJScRBIUPbo4msGTBY4jlQzK6q/PfVr9XhJ9MBUXS502BvWx2lAXfCsOFXdFkw64+/Zq8mt41OZWnOHYIWSrasErpU/hbrGXxk1Q3Gc9R4sBRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778199422; c=relaxed/simple;
	bh=EAX694TbnIihDhRmh1AkFD7HROfCE45mNPYybohaDUw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hETLOS8+yA9DAfBQlqRAt+tSbR2xeWWEN8yK/V1KaVI0Yl7Wg2XsEvigBhMSMGYu/xR2Ybm1PVYbKG2B2/4L072AWKbx32/h3KN7sVrNrU9Z7nBAOdFq4r40fBH4ZJU+JjWOF6ag9U3Ru+rbAYtvf8PZABIPMhmW+GaOK1REKDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/ajLaHs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/ajLaHs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22ED5C2BCB2;
	Fri,  8 May 2026 00:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778199422;
	bh=EAX694TbnIihDhRmh1AkFD7HROfCE45mNPYybohaDUw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=X/ajLaHswxsScrh0FDX0qAL+t6c27R60O7W9jMJI7iv6aeh3pBTJirrC63F4CPUkc
	 js9mYW2GqwQcgzswEHFGVbYFm0nrqPrneprCtzfcnzhB3oHlkg05Zb5d7leIRcN6Pn
	 RIsEPnTUFheyIrYeUyagIZL9x59XV/xCpZkBgZCXwnMBfRAm9LRTdvA873VB759+vZ
	 aIFedVVsNiqLOtxdBTmzWH1qede79NrgF3ntjyjfEoUD7nzPkD1iiA8jGdZDB96ADO
	 xwzyGu3PPLcOsT4YTIbTWvnbBWDhYB7UJhP6KRdILhTg+fyVIakJvhAW/fYimQscGp
	 M47/32NuTdKDg==
Date: Thu, 7 May 2026 19:17:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, sashiko-bot@kernel.org,
	linux-pci@vger.kernel.org, sashiko@lists.linux.dev,
	Marco Nenciarini <mnencia@kcore.it>,
	Michal Winiarski <michal.winiarski@intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Eric Chanudet <echanude@redhat.com>,
	Jean Guyader <jean.guyader@gmail.com>,
	Alex Williamson <alex@shazbot.org>, Sinan Kaya <okaya@kernel.org>,
	Mario Limonciello <superm1@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI: Drop unnecessary retries when restoring BARs
Message-ID: <20260508001700.GA52868@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hngqvdi2vRB4n5T3sGSPc10eR=1X+UO2QAR=GHYmQo2w@mail.gmail.com>

On Tue, May 05, 2026 at 12:43:17PM +0200, Rafael J. Wysocki wrote:
> On Mon, May 4, 2026 at 11:17 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> ...

> > If pci_power_up() is doing D3cold -> D0, main power is initially
> > off, so platform_pci_set_power_state(PCI_D0) would turn on main
> > power, which is a Fundamental Reset leaving the device in
> > D0uninitialized.  In general the device needs at least 100 ms
> > after that reset before any access, e.g., before the PMCSR read.
> 
> Yes, it does in general, but that should be covered by
> platform_pci_set_power_state() because on some platforms the delay
> can be shorter.

It's surprising to me that platform_pci_set_power_state() takes
care of that delay because there's so much PCIe infrastructure
(dependencies on link speed, RRS polling, Immediate Readiness,
Readiness Notifications, etc), much of which sounds more like
OS-level support than firmware support.

But if platform_pci_set_power_state() does guarantee that the device
is Configuration-Ready, we should document that somewhere.

> > If pci_power_up() is doing D3hot -> D0, the device already has
> > main power, so I suppose platform_pci_set_power_state(PCI_D0)
> > doesn't do anything.
> 
> It may or may not.  Some platforms supply AML to run during D3hot ->
> D0 transitions (and the ACPI spec allows that).

If the device started in D3hot, it never lost main power, and I
assumed platform_pci_set_power_state(PCI_D0) might just leave it in
D3hot.  It sounds like it takes it all the way to D0, although the
subsequent code that checks the PMCSR state does suggest that the
device might *not* be in D0:

    platform_pci_set_power_state(dev, PCI_D0);

    pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
    state = pmcsr & PCI_PM_CTRL_STATE_MASK;
    if (state == PCI_D0)
      goto end;

    pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, 0);
    if (state == PCI_D3hot)
      pci_dev_d3_sleep(dev);
    ...

  end:

If platform_pci_set_power_state(PCI_D0) puts the device in D0 and
takes care of all the delays, "state" should always be PCI_D0, and we
shouldn't need the D3hot and D2 delays here.

Bjorn
