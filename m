Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [144.76.133.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF6925A655;
	Fri,  6 Feb 2026 20:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770411222; cv=none; b=AkYdlHUBshOcsPl5R9P5UW+PsWaMVM9SRFBvUiF9IxD+4nEXYFvvTSzf3AwKDIRFhIifc9bPyIVWcaOIBm+3xCnUinqri7XA51idjSwXq+RVQ0UHE/nre1R2jVrSz8EiQPzAGVXTiyfeok86+MD0SxlqJ/F+x3AOtPKyK4Hlkv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770411222; c=relaxed/simple;
	bh=cWVoMK4vE6oudGe98sTeGIP2ed33MCzt8bJUyQqLvpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZnvzVFFAUZi5hOQu9eo2PKtmizoiHPLHr5OB3ENFtBAwxB7JQHQmA8MzaKXU5UCVirXORX+lS7ArGQ2jprptZcICJU7U5jY+jMQiiTz9TPuZghlaStOkZ4jlFplayvesZC+4njdWYAjZV351Fem4NK4wjw5C7GJNoV+j0lCqOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=144.76.133.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 50E4F2C0162F;
	Fri,  6 Feb 2026 21:53:39 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 377E14936; Fri,  6 Feb 2026 21:53:39 +0100 (CET)
Date: Fri, 6 Feb 2026 21:53:39 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Breno Leitao <leitao@debian.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org, dcostantino@meta.com, rneu@meta.com,
	kernel-team@meta.com
Subject: Re: [PATCH] PCI/AER: Add option to panic on unrecoverable errors
Message-ID: <aYZU09qCN3u-_byj@wunner.de>
References: <20260206-pci-v1-1-85160f02d956@debian.org>
 <20260206185232.GA70936@bhelgaas>
 <aYY_hMZyVp7GZvX2@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYY_hMZyVp7GZvX2@kbusch-mbp>

On Fri, Feb 06, 2026 at 12:22:44PM -0700, Keith Busch wrote:
> On Fri, Feb 06, 2026 at 12:52:32PM -0600, Bjorn Helgaas wrote:
> > Are there any other similar flags you already use that we could
> > piggy-back on?  E.g., if we raised the level to KERN_WARNING, maybe
> > the existing "panic_on_warn" would be enough?
> 
> There are many KERN_WARNING messages that don't rise to the level of
> warranting a 'panic' that don't want to enable such an option in
> production. It looks like the panic_on_warn was introduced for developer
> debugging.

panic_on_warn springs into action on WARN() splats, not arbitrary
messages with KERN_WARNING severity.  Also, sysctl kernel.warn_limit
may be used to grant a certain number of panic-free WARNs.

FWIW, the "pcieportdrv.aer_unrecoverable_fatal" parameter introduced
by this patch feels somewhat oddly named.  Something like
"pci.panic_on_fatal" might be clearer and more succinct.

> I agree the curnent INFO level is too low for the generic unrecovered
> condition, though.

At least for unbound devices, I think 918b4053184c went way too far.
I think an unbound device should generally be considered recoverable
through a reset.

As for bound devices whose drivers lack pci_error_handlers, it has been
painful in practice that they're considered unrecoverable wholesale.
E.g. GPUs often expose an audio device as well as telemetry devices,
all arranged below an integrated PCIe switch.  All of these devices
need drivers with pci_error_handlers in order for the GPU to be
recoverable.  In some cases, dummy callbacks were added to render
the whole thing recoverable.

So I wouldn't consider 918b4053184c to have been a universally successful
approach and I fear that this patch goes even further.

Thanks,

Lukas
