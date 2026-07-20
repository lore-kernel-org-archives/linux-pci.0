Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D612392838;
	Mon, 20 Jul 2026 20:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784580262; cv=none; b=H+j38twJKaG2RpEfsixOmsOgLYIgG5zg6SgKcR3F5kzRvV5hIx2tyj4Fz95Y2idRsekvk91DKpjgyyq4Wep2dJ+ve90POsWIqFjE+5md5eNPQwuOEc9y3AlbOGPLqZcqsQGCJgRWfpJ7eJUoLJ5CPgXN2WubBs2u2g5DN3VolJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784580262; c=relaxed/simple;
	bh=AAL6FDCzJ8B3dc9n++X3RoIaRR3wsQfAZ0uInZu6yi0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Wzn+gKH54DeQGXNRRicOYyCKk6cPgqa2GDYTdJRoxXsxj8a4SQ6DF8YF1hmUa2zUplTzB3GP0+N10SK3+gvJ185slnvkUpAYWhjTIBbZwkYrJmf4RikbvPen3Q8aaYb5v+pmgvWWMEg8L/vlgIW4P8fqBakUyuNZsu5N7pEOWcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHKZh4sS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHKZh4sS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072A91F000E9;
	Mon, 20 Jul 2026 20:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784580261;
	bh=/b9pN6kht5qZu8FPQFKyxABDbD3yQrAOBxzoj1NBrEE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=XHKZh4sSEgaIVPGVLzgfmpwvROdIfAukRQRecYiPxPEwoU6lEGN+fCdpNrmWs6OYx
	 iY7u/vOID/tKk6woZVaOx1G3IO1NigPT0S1L4IqXBzvdD7fFp1jGR0Lfh6ntk6hUjp
	 mYQDl73GNM540cLlCAH8/5MrUh8gw8z+w35sKHkvL+KEHsOgjl1jKCOQWHYkc8svEM
	 azpUOCdNf8Bg3TotRES8u6gXBZGUFZwBmKKFwK+VXEICpbEy3Vr9XemyoOE7cz8poM
	 m+MiJRXSC+F9BS1pbUPhgchdKJZKwptHaCAok/Q7fG2fiJfibrFyxvPcUHPDrrk+tH
	 EhQiAlX5jX+QA==
Date: Mon, 20 Jul 2026 15:44:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>, Brian Norris <briannorris@chromium.org>
Cc: linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
	linux-pci@vger.kernel.org, David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v2] PCI/portdrv: Allow probing even without child services
Message-ID: <20260720204419.GA426578@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alnnTRldy-deNIFM@wunner.de>

On Fri, Jul 17, 2026 at 10:26:53AM +0200, Lukas Wunner wrote:
> On Thu, Jul 16, 2026 at 12:26:41PM -0500, Bjorn Helgaas wrote:
> > On Mon, Feb 09, 2026 at 05:15:35PM -0800, Brian Norris wrote:
> > > The PCIe port driver fails to probe if it finds no child services,
> > > presumably under the assumption that the driver is not useful in that
> > > case. However, the driver *can* still be useful for power management
> > > support -- namely, it still configures the port for runtime PM / D3,
> > > which may be important for allowing a bridge to enter low power modes.
> > > 
> > > Thus, allow probe to succeed even if no IRQs and no child services are
> > > available. This also mirrors existing behavior for ports that have no
> > > PCIe capabilities, where we'd also probe successfully.
> > > 
> > > This change is a bit more important after commit f5cd8a929c82 ("PCI:
> > > dwc: Remove MSI/MSIX capability for Root Port if iMSI-RX is used as MSI
> > > controller"), because it's common for some DWC-based systems to:
> > > 
> > > 1. have only have the "aer" and "pcie_pme" port services available and
> > > 2. not define legacy INTx interrupts properly in their device tree.
> > > 
> > > After commit f5cd8a929c82, such systems may fail
> > > pcie_init_service_irqs() and so exit with -ENODEV.
> > > 
> > > Link: https://lore.kernel.org/all/nyada24tqwlkzdceyoxbzitzygvp4elvj5oajnqdwb33xkcdwk@76vnrx45fsfd/
> > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > 
> > Applied to pci/portdrv for v7.3, thank you!
> 
> Some thoughts on the version now applied to pci/portdrv:
> 
> * After this patch, the return value of pcie_device_init() is no longer
>   evaluated, so that function should be changed to return void as part
>   of this patch.
> 
> * If no port services are initalized, e.g. because pcie_device_init()
>   failed for all of them, the allocated IRQ vectors are not freed.
>   They're hogged, which may be a problem on systems which only support
>   very few IRQ vectors such as Sophgo SG2042:
> 
>   https://lore.kernel.org/r/0f42afefd9322779af5463b696c55b08d2296ea8.camel@iscas.ac.cn

Seems like a good idea to free IRQ vectors we don't use.  It *looks*
like it should be safe to call pci_free_irq_vectors() here and then
again in pcie_port_device_remove() if a port is removed, but Brian
wasn't sure, and I didn't look any deeper than pci_disable_msix() and
pci_disable_msi().

I guess if we did this we'd need to retain the pcie_device_init().

> * It might be clearer to call pci_clear_master() directly in the
>   if-block which is amended to "goto out".  Then the "goto out"
>   can be changed to a "return 0".  It seems "if (!capabilities)"
>   cannot happen through any other code path, so it's unclear why
>   the "out" label is necessary.

It does look nicer that way.

> * There's a duplicate "have" in the commit message ("have only have").

I fixed this on pci/portdrv.

What do you think, Brian?
