Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD4D328B61;
	Fri, 17 Jul 2026 08:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784276824; cv=none; b=qSHnvfW6+vrhseZgUuPKvtKwgTJxgbj7MdOfQYHz2UcJIGFp125aA5phWDoWAxUnIYE2pC3V2cErxQKeAUKWqcLXS6GDtmAY/6cWBIYvXXzNUfkAI3WqXCT4sMUtFFnATRbWIXipuMyEP6I3LrrD/oxXSO864Ztr1QEFTY18y3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784276824; c=relaxed/simple;
	bh=SZpvxKaGw+MkAMyQrY7eCnjAOu2pAQPjLqS2PNbJuqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEpSxP6UEQF3He4vQ8Vfn+KfL4PpeERofcEgB8IGNszhQ+KLoeTizJ0AWDb1KhS1Ewn+wcTSrJMDjjRmgjNyD2mNfQaCrfNSK5ji1IGnx1k29pXp1lkAd9Q3ByPEsR5cbhum2pebd2yRW5jCtVBdhClWPEeQKZ3qhUgG0NwIegc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 47200372;
	Fri, 17 Jul 2026 10:26:53 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 2DFD8603E05C; Fri, 17 Jul 2026 10:26:53 +0200 (CEST)
Date: Fri, 17 Jul 2026 10:26:53 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Brian Norris <briannorris@chromium.org>, linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v2] PCI/portdrv: Allow probing even without child services
Message-ID: <alnnTRldy-deNIFM@wunner.de>
References: <20260209171535.v2.1.I5fd5d83f518681b3949d8ab2f16ba8244fd3e774@changeid>
 <20260716172641.GA100369@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716172641.GA100369@bhelgaas>

On Thu, Jul 16, 2026 at 12:26:41PM -0500, Bjorn Helgaas wrote:
> On Mon, Feb 09, 2026 at 05:15:35PM -0800, Brian Norris wrote:
> > The PCIe port driver fails to probe if it finds no child services,
> > presumably under the assumption that the driver is not useful in that
> > case. However, the driver *can* still be useful for power management
> > support -- namely, it still configures the port for runtime PM / D3,
> > which may be important for allowing a bridge to enter low power modes.
> > 
> > Thus, allow probe to succeed even if no IRQs and no child services are
> > available. This also mirrors existing behavior for ports that have no
> > PCIe capabilities, where we'd also probe successfully.
> > 
> > This change is a bit more important after commit f5cd8a929c82 ("PCI:
> > dwc: Remove MSI/MSIX capability for Root Port if iMSI-RX is used as MSI
> > controller"), because it's common for some DWC-based systems to:
> > 
> > 1. have only have the "aer" and "pcie_pme" port services available and
> > 2. not define legacy INTx interrupts properly in their device tree.
> > 
> > After commit f5cd8a929c82, such systems may fail
> > pcie_init_service_irqs() and so exit with -ENODEV.
> > 
> > Link: https://lore.kernel.org/all/nyada24tqwlkzdceyoxbzitzygvp4elvj5oajnqdwb33xkcdwk@76vnrx45fsfd/
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> 
> Applied to pci/portdrv for v7.3, thank you!

Some thoughts on the version now applied to pci/portdrv:

* After this patch, the return value of pcie_device_init() is no longer
  evaluated, so that function should be changed to return void as part
  of this patch.

* If no port services are initalized, e.g. because pcie_device_init()
  failed for all of them, the allocated IRQ vectors are not freed.
  They're hogged, which may be a problem on systems which only support
  very few IRQ vectors such as Sophgo SG2042:

  https://lore.kernel.org/r/0f42afefd9322779af5463b696c55b08d2296ea8.camel@iscas.ac.cn

* It might be clearer to call pci_clear_master() directly in the
  if-block which is amended to "goto out".  Then the "goto out"
  can be changed to a "return 0".  It seems "if (!capabilities)"
  cannot happen through any other code path, so it's unclear why
  the "out" label is necessary.

* There's a duplicate "have" in the commit message ("have only have").

Thanks,

Lukas
