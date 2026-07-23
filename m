Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5422F37A856;
	Thu, 23 Jul 2026 06:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784788068; cv=none; b=Vm2ijDWlPQY5usxmOggpJL4WeE3GnPUqgKBu45T4/UtMEZFLO7HozTi17plfea7iL1oondRdxNROetWCPszFQ9Pa4FROpvOK0Ptbd2clzrE0PCUWCnyQtQSjsofSdTkqXuPN8tu+FueymeeVk8hEcmrND+Pd+jdHz3eFjzv53pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784788068; c=relaxed/simple;
	bh=KYn1cK90jdEH0cZeFZiwiYA4xJrj+TmY9MAHd6M8Y8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ga4GfhdM3XcYq8R3nkeXeYzPnlz7Q9yIS7jrHVLD72ucf11bPZ934x9jHRnvh8Cdkws3bwFmCAaGUxAvhV6/MXd6bwUYenJgovL4l5PO3t/aP47XQFt97PoH6Tu+H7pJgOMMMmhPCMx4kaX8HR8jlqQlo1yv5xpRzykOU1i5t94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id A4F3210DC8;
	Thu, 23 Jul 2026 08:27:41 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 8E75A606F523; Thu, 23 Jul 2026 08:27:41 +0200 (CEST)
Date: Thu, 23 Jul 2026 08:27:41 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	David Matlack <dmatlack@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PCI/portdrv: Allow probing even without child services
Message-ID: <amG0XebAYI-4eDIN@wunner.de>
References: <20260722160942.v4.1.I5fd5d83f518681b3949d8ab2f16ba8244fd3e774@changeid>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722160942.v4.1.I5fd5d83f518681b3949d8ab2f16ba8244fd3e774@changeid>

On Wed, Jul 22, 2026 at 04:09:42PM -0700, Brian Norris wrote:
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -330,7 +330,7 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
>   */
>  static int pcie_port_device_register(struct pci_dev *dev)
>  {
> -	int status, capabilities, i, nr_service;
> +	int status, capabilities, i;
>  	int irqs[PCIE_PORT_DEVICE_MAXSERVICES];

Nit:  Move the amended line below the irqs[] declaration to sustain
inverse Christmas tree ordering.

Otherwise this is
Reviewed-by: Lukas Wunner <lukas@wunner.de>

One caveat, I note there is a pre-existing issue on Loongson LS7A,
which (according to 62b6dee1b44a) suffers from a defect wherein
disabling bus mastering prevents forwarding of MMIO requests downstream.
This happens right now (and continues to happen after the present patch)
if the error path in pcie_port_device_register() is taken.

I also note that pci_enable_device() is only called because per
1ce5e83063bf, it was necessary in 2009 for legacy interrupt initialization
"on some architectures", which sounds fairly vague to me.  In any case,
it seems to suggest that pci_disable_device() should be called if
pcie_init_service_irqs() fails.  Right now that is done, after the patch
it isn't.  I guess portdrv would have to remember on probe whether
pci_enable_device() was called and only then call pci_disable_device()
on remove.  I guess it would be possible to abuse dev_set_drvdata()
to store this status bit (as a fake pointer).  Then again, I'm not
sure pci_enable_device() is still necessary for legacy interrupt
initalization today.  I guess "legacy interrupt" refers to INTx.
A lot has changed in generic and PCI irq code since 2009.
I assume we otherwise don't have a need to access BARs on PCIe ports
currently, but perhaps new port services may come along which do?

Thanks,

Lukas
