Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA941392C56
	for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2026 16:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787068984; cv=none; b=sWVfEIyYrkY22aaUVh5BkKAMZwCfVKn4Ojo9/Zf6dEEb9iYJrtMuU8uWy7wZKuuGhuXUI7SNLEhEkCC6mOI4j0Id4kTsFmUv2MYc0DzWq3jXpJoIqcFWtf5ZusDFBiwz4cOo36qCDGJFCIZyOCQqqJbfF0uQHBQ5FTgtiPPFJ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787068984; c=relaxed/simple;
	bh=u1krH2MgW/rmUMJz5nl//UAxP1FT9KVWwO9LVr/JSCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOQwsclKKlvKFrviDxxwztMPfYqTyVoUcvVToCjm0mJGJLdHJRg6LEo7dwcyjVMCAQfEYOGsX1E6mHnEQsRBQ0BD8wFsvnmldQtw7gZ3DZGppbIuA6/7kHUXC8FqrUohBc1YNlrZXdXk5crR9XBaC7hHcTErGvun5PnBljxUrqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 10C7ACAB;
	Tue, 18 Aug 2026 18:02:52 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D2D05606F46C; Tue, 18 Aug 2026 18:02:51 +0200 (CEST)
Date: Tue, 18 Aug 2026 18:02:51 +0200
From: Lukas Wunner <lukas@wunner.de>
To: sashiko-reviews@lists.linux.dev
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] vfio/pci: Restore standard PCI config space in
 .slot_reset()
Message-ID: <aoSCK2Sy0HeyX_la@wunner.de>
References: <20260817195110.2077698-1-kbusch@meta.com>
 <20260817200404.BB3121F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817200404.BB3121F000E9@smtp.kernel.org>

On Mon, Aug 17, 2026 at 08:04:04PM +0000, sashiko-bot@kernel.org wrote:
> [Severity: High]
> Is this callback reachable under normal single-device circumstances?
> 
> In pcie_do_recovery(), the report_slot_reset broadcast is gated behind
> checking if the combined error status is PCI_ERS_RESULT_NEED_RESET.
> 
> However, vfio_pci_core_aer_err_detected() unconditionally returns
> PCI_ERS_RESULT_CAN_RECOVER. The PCI recovery state machine promotes
> CAN_RECOVER to RECOVERED during the mmio_enabled phase, so the
> condition to call slot_reset evaluates to false unless another driver
> on the same PCIe bridge votes for NEED_RESET.

I have a patch on my development branch so that ->reset_slot() is
also invoked if (state == pci_channel_io_frozen), i.e. on Fatal Errors.

I have another patch pending to allow error recovery for unbound devices.

Both patches are available for testing on this branch and I hope to
submit them in the upcoming cycle:

https://github.com/l1k/linux/commits/aer_unbound/

> [Severity: High]
> Can pci_restore_state() clobber userspace runtime configurations with
> an outdated probe-time snapshot?
> 
> For a VFIO device, pdev->saved_config_space contains the host kernel's
> baseline state captured during vfio_pci_core_enable(). Subsequent
> userspace modifications (like enabling bus master or setting up MSI)
> are recorded in VFIO's virtual cache (vdev->vconfig) but do not update
> pdev->saved_config_space.

I guess the right thing to do is to write vdev->vconfig to config space
after pci_restore_state()?

Thanks,

Lukas
