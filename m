Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E858F242D6B;
	Fri, 15 May 2026 12:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778849226; cv=none; b=MQ/vu3jtBpf0KF3nSBItAmJ17KOzpKUrU22AMUuYIrfzayF92MgYri/m22LA0OMsLweJZIVzDCsQWPkl+TE4+/ni9pMQT6wPyB+bzAon/YJLQ/7DSzr74Qhx1aXIzl0AZ8LAo5jAyAT4zFb0W1/C2GGNfYLNbGAhIPN2g7/5nQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778849226; c=relaxed/simple;
	bh=pjSIgFOsimvjMljd2+9OjbZPtwyx3iwjB3AVrrNCZkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fq1akhGFW3zw3A4Zbs9fLE1UptZ2RyxYFCZ3wCv5wUNsJqERz61nadRkJXTTV27pj/ErsqpDJ0tsxCoUVfu+BAdInPdiUOUVJa+sO5hCKfcYuO/iYu1oag4fdGHtD5WwzcUJet//uK5tyeQjhr/UAb/b80MCkx8HElQZ0lX2g3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id B72BC1060C;
	Fri, 15 May 2026 14:46:54 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A38256017528; Fri, 15 May 2026 14:46:54 +0200 (CEST)
Date: Fri, 15 May 2026 14:46:54 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Marco Nenciarini <mnencia@kcore.it>,
	Michal Winiarski <michal.winiarski@intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Eric Chanudet <echanude@redhat.com>,
	Jean Guyader <jean.guyader@gmail.com>,
	Alex Williamson <alex@shazbot.org>, Sinan Kaya <okaya@kernel.org>,
	Mario Limonciello <superm1@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1] PCI: Wait for device readiness after D3hot ->
 D0uninitialized transition
Message-ID: <agcVvg1ntQPbivr9@wunner.de>
References: <20260514200625.C6877C2BCB3@smtp.kernel.org>
 <20260514213811.GA434353@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514213811.GA434353@bhelgaas>

On Thu, May 14, 2026 at 04:38:11PM -0500, Bjorn Helgaas wrote:
> On Thu, May 14, 2026 at 08:06:25PM +0000, sashiko-bot@kernel.org wrote:
> > > +		if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
> > > +			pci_dev_wait(dev, "power up D3hot->D0uninitialized",
> > > +				     PCIE_RESET_READY_POLL_MS);
> > 
> > Is it safe to ignore the return value of pci_dev_wait() here?
> > 
> > If the device times out or disconnects, pci_dev_wait() returns -ENOTTY. By
> > ignoring this error, pci_power_up() continues, unconditionally sets
> > dev->current_state = PCI_D0, and can return success (1 for need_restore).
> > 
> > If pci_power_up() returns success, will callers like pci_back_from_sleep()
> > execute pci_restore_state() against an unresponsive device, which could
> > potentially trigger PCIe Master Aborts, AER events, or system crashes?
> > 
> > Should pci_power_up() propagate the error from pci_dev_wait() to prevent
> > this?
> 
> Good point.  I think it should look like this instead:
> 
>     if (state == PCI_D3hot) {
>             pci_dev_d3_sleep(dev);
>             if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET)) {
>                     ret = pci_dev_wait(dev, "power up D3hot->D0uninitialized",
>                                        PCIE_RESET_READY_POLL_MS);
>                     if (ret) {
>                             pci_err(dev, "Not ready after soft reset\n");
>                             dev->current_state = PCI_D3cold;
>                             return -EIO;
>                     }

pci_dev_wait() already emits a warning message on timeout, so the
additional pci_err() is probably not needed.  Otherwise the user
would see duplicate messages, i.e.:

  pci SSSS:BB:DD.F: not ready 60000ms after power up D3hot->D0uninitialized
  pci SSSS:BB:DD.F: Not ready after soft reset

Thanks,

Lukas
