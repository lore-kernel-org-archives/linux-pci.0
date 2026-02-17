Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94C3372B54;
	Tue, 17 Feb 2026 18:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771352552; cv=none; b=DNV4OijHtL8/jQ+IkMx7xzztS34s1MPnsm3bDfWFI+ErJTCgS6F9GaGsIOzHf2/3XqMcdeb7lMRofAU30imtiLPgmY3jvP8mUcxQh2E/UtpA6Z5MzSwfcPXTL29T0YLNKVACIM6oyPE1EaMEaKn83Iw97vKLJPIOqWVk6zemomc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771352552; c=relaxed/simple;
	bh=SyPy8oRFmkNStIpxuilLgf7e6tWLRUzn9jyj9W0ykIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYbUUEPtZq9kEmccvvYYuPBu5rQTeqVdxvBxrADR/jySC8OSD/VnBGbgeK7l4OlCC/M5iGneIC3DWuTYH3AddQnL75zxEaZlg+ABdcKRKfm/E9xSH95+bOH6tq2vhllsWY8gmF8uzphf436eMq27/EZVtYd3lpqtbQS/Wqc0IAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id D414D2005000;
	Tue, 17 Feb 2026 19:22:20 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id CE309DA9D; Tue, 17 Feb 2026 19:22:20 +0100 (CET)
Date: Tue, 17 Feb 2026 19:22:20 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: pciehp: Fix hotplug on Catlow Lake with
 unreliable PME status
Message-ID: <aZSx3NF5gZ0rLIVU@wunner.de>
References: <20260213231428.613164-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <aZAPqQTiGQiDvX52@wunner.de>
 <aZCQsyL9RRessjMI@wunner.de>
 <70533ce4-265e-449c-bd63-06f2d7f5bdf1@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70533ce4-265e-449c-bd63-06f2d7f5bdf1@linux.intel.com>

On Tue, Feb 17, 2026 at 09:01:25AM -0800, Kuppuswamy Sathyanarayanan wrote:
> On 2/14/2026 7:11 AM, Lukas Wunner wrote:
> > I've just realized that pcie_disable_interrupt() isn't called from
> > pciehp_suspend() if pme_is_native() is true.  Should disabling
                                           ^^^^
Sorry, I meant "if pme_is_native() is *false*".
My brain was apparently half asleep when I wrote this.

> > runtime PM cause a power regression, an alternative solution may be
> > to make pcie_disable_interrupt() conditional on a new pme_is_broken()
> > which checks for affected Catlow Lake PCH Root Ports.
> > 
> > The pm_runtime_disable() approach is slightly preferred because
> > it keeps pciehp code clean.
> 
> I think pcie_disable_interrupt() is called from pciehp_suspend() when
> pme_is_native() is true. Looking at the code:
> 
> static void pciehp_disable_interrupt(struct pcie_device *dev)
> {
>         /*
>          * Disable hotplug interrupt so that it does not trigger
>          * immediately when the downstream link goes down.
>          */
>         if (pme_is_native(dev->port))
>                 pcie_disable_interrupt(get_service_data(dev));
> }

What I had in mind is something like:

-	if (pme_is_native(dev))
+	if (pme_is_native(dev) && !pme_is_broken(dev))
		pcie_disable_interrupt(get_service_data(dev));

Again, the pm_runtime_disable() (or pm_runtime_get_sync()) approach
is slightly preferred because it keeps pciehp code clean and confines
the issue to a quirk that only needs to be compiled in on x86.

Thanks,

Lukas
