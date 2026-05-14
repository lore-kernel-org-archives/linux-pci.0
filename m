Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D398E3DDDAB
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 13:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778764476; cv=none; b=Rx69bdAhPNo+gHrqTHJ9PiH9OzEjRWmbnDhAqoMZ9hdYebpi2cU+J/fy8/YGuY9fG1Ez2zDwr/5yGHIy/FnLNxluSwPCHN6NXQAWUA1YktWlBsJYE4knIQrieUd89ok0fbKC7HFDngmcCfW7qgVZ1k7q5SPgrWiqaGBnAhQ4bJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778764476; c=relaxed/simple;
	bh=yx/cPMS1qJ5xcr0TGlPslnMkQCE425HEeu6EigOp36M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHcJblka5/L0XGaOP/fF9HMz3BUcXzMvZWcjk379F0BRpfSTvF8XVYcP0Rgu6ZhRa3AgC1nLNV8/htaJxkQcn2iTWcF6wwSiP9RXtneO1XV0aSsPvHRTPVIBMu/MJsVJRP6RjzlhvWTxeI+C2ZyXZtXLUYixO4MracuU2+DPAeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id CBD9DC24;
	Thu, 14 May 2026 15:14:30 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A338E6016B85; Thu, 14 May 2026 15:14:30 +0200 (CEST)
Date: Thu, 14 May 2026 15:14:30 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Alistair Francis <alistair23@gmail.com>
Cc: sashiko@lists.linux.dev, linux-pci@vger.kernel.org, ojeda@kernel.org
Subject: Re: [PATCH 10/18] PCI/CMA: Validate Subject Alternative Name in
 certificates
Message-ID: <agXKtgC7iG9BoiW8@wunner.de>
References: <20260508031710.514574-11-alistair.francis@wdc.com>
 <20260508035806.0EE8DC2BCB0@smtp.kernel.org>
 <CAKmqyKMti4wxuU-uRcLXLnXpXTHGajHkx=7zt54FDLUry+mP6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmqyKMti4wxuU-uRcLXLnXpXTHGajHkx=7zt54FDLUry+mP6Q@mail.gmail.com>

On Thu, May 14, 2026 at 12:45:46PM +1000, Alistair Francis wrote:
> On Fri, May 8, 2026 at 1:58 PM <sashiko-bot@kernel.org> wrote:
> > > +++ b/drivers/pci/Makefile
> > > -obj-$(CONFIG_PCI_CMA)                += cma.o
> > > +obj-$(CONFIG_PCI_CMA)                += cma.o cma.asn1.o
> > > +$(obj)/cma.o:                        $(obj)/cma.asn1.h
> > > +$(obj)/cma.asn1.o:           $(obj)/cma.asn1.c $(obj)/cma.asn1.h
> >
> > If CONFIG_PCI_CMA is configured as a loadable module, will Kbuild compile
> > two separate modules (cma.ko and cma.asn1.ko)?
> >
> > Because the ASN.1 compiler does not export the cma_decoder symbol, would
> > the cma.ko module fail to link during modpost with an undefined symbol
> > error?
> >
> > Should these objects be bundled into a composite object instead? For
> > example:
> >
> > cma_module-y := cma.o cma.asn1.o
> > obj-$(CONFIG_PCI_CMA) += cma_module.o
> 
> This seems correct

Hallucination alert:

CONFIG_PCI_CMA is bool, so cannot be configured as a loadable module.

> > > +     if (tag != ASN1_UTF8STR ||
> > > +         vlen != ctx->expected_len ||
> > > +         memcmp(value, ctx->expected_name, vlen) != 0) {
> >
> > Does this perform a strict case-sensitive comparison of the Subject
> > Alternative Name?
> >
> > If a device vendor provisions the certificate using uppercase hexadecimal
> > letters (a common standard for hardware IDs), could this strict memcmp()
> > erroneously reject a valid device?
> 
> This is incorrect though, as the case is specified in the PCI spec

Right.  Another hallucination.

> > > +     len = snprintf(name, CMA_NAME_MAX,
> > > +                    "Vendor=%04hx:Device=%04hx:CC=%06x:REV=%02hhx",
> > > +                    pdev->vendor, pdev->device, pdev->class, pdev->revision);
> >
> > The commit message mentions handling devices that mutate their identity
> > at runtime, but this string is constructed using cached software state
> > from probe time (like pdev->vendor).
> 
> This I'm not clear on. Do we need to call pci_bus_read_dev_vendor_id()
> to get updated values?

If the device mutates its device identity in Config Space at runtime,
e.g. as a result of an FPGA update or hot replacement, it is necessary
to re-enumerate the device either through the standard hotplug
mechanism or manually via sysfs.  Otherwise authentication simply fails
because of the mismatch between (cached) Config Space and Subject
Alternative Name.

I think this is the correct thing to do.  The alternative would be that
we'd just carry on using the device normally even though the mismatch
tells us something's not right.

pciehp_device_replaced() already checks whether device identity in
(unsigned) Config Space has changed after resume from system sleep
and after error recovery and automatically triggers a hot unplug event.
CMA will make this check even more useful because we can trigger
hot unplug also when the device was previously authenticated but now
no longer is, e.g. because of a Subject Alternative Name mismatch.

> > Since pci_get_dsn() reads the live hardware state, could a mutated device
> > result in an inconsistent string containing a stale vendor/device ID but
> > a new DSN? Will reauthentication fail without a full PCI rescan?

I think it doesn't really matter whether we use cached data or read it
from Config Space, we just want to detect a mismatch with the Subject
Alternative Name.

> > Additionally, snprintf() returns the number of characters that would have
> > been written, not the actual bytes written.
> 
> This is true
> >
> > If the inputs ever exceed the 79-byte CMA_NAME_MAX buffer (for instance,
> > if a quirk mutates pdev->class to exceed 6 hex characters), the string
> > will be truncated but len will reflect the untruncated size.
> 
> That's true, but I don't see how the fixed length format string could
> exceed the size.

Right.

> > Could this cause the later memcmp() check in pci_cma_note_san() to read
> > out of bounds of the ctx->expected_name stack buffer? Should scnprintf()
> > be used here instead to track the actual length written?
> 
> scnprintf() should be used instead, just in case.

The assumption that pdev->class may exceed 6 hex characters
is a hallucination as the 24-bit size is prescribed by the spec.

Should the expected name ever change, the CMA_NAME_MAX macro
at the top of cma.c needs to be amended.  So I don't really
see the need for scnprintf().

> > > +     if (pdev->hdr_type == PCI_HEADER_TYPE_NORMAL)
> > > +             len += snprintf(name + len, CMA_NAME_MAX - len,
> > > +                             ":SSVID=%04hx:SSID=%04hx",
> > > +                             pdev->subsystem_vendor, pdev->subsystem_device);
> >
> > PCIe Type 1 devices (bridges) can also implement the Subsystem Vendor ID
> > capability.

Hallucination.

> > > +     serial = pci_get_dsn(pdev);
> > > +     if (serial)
> > > +             len += snprintf(name + len, CMA_NAME_MAX - len,
> > > +                             ":%016llx", serial);
> > > +
> > > +     return len;
> > > +}
> >
> > Looking at pci_get_dsn(), it returns 0 both when the DSN capability is
> > missing and when the device's legitimate serial number is 0.
> >
> > If a device implements the capability with a valid DSN of 0, will this
> > check evaluate to false, omit the field, and reject a valid device?
> >
> > Would it be safer to explicitly check for the capability's presence via
> > pci_find_ext_capability() instead?
> 
> I see your point, but I don't think so.

PCIe r7.0 sec 7.9.3.2 defines the Device Serial Number as an EUI-64.

In the corresponding IEEE spec on EUIs on page 11 in section
"Unassigned and NULL EUI values", it says:

   "Many applications have found it useful to define a distinct null
    identifier, most often indicating the absence of a valid EUI-48 or
    EUI-64 value. As an example, a null value might be the power-on state
    for an integrated circuit register, until the hardware or firmware
    initializes the register with a valid EUI.
    [...]
    The all-zeros EUI-48 value (00-00-00-00-00-00) and EUI-64 value
    (00-00-00- 00-00-00-00-00), though assigned to an organization,
    have not been and will not be used by that assignee as an EUI.
    (They can be considered as assigned to the IEEE Registration Authority.)"

    https://standards.ieee.org/content/dam/ieee-standards/standards/web/documents/tutorials/eui.pdf

PCIe r6.1 sec 6.31.3 says the Device Serial Number shall be included
in the Subject Alternative Name if it is "implemented".  It is debatable
whether it can be considered implemented if the vendor neglected to
initialize it to a valid number, but I'm inclined to consider that
"not implemented".  The vendor made a mistake and signed an invalid
Device Serial Number.  That can't be considered a valid certificate then.

> > Also, pci_get_dsn() performs two separate 32-bit reads without a lock:
> >
> > pci_read_config_dword(dev, pos, &dword);
> > dsn = (u64)dword;
> > pci_read_config_dword(dev, pos + 4, &dword);
> > dsn |= ((u64)dword) << 32;
> >
> > Could a concurrent mutation of the device identity result in a torn
> > 64-bit read during this check?
> 
> Really?

Again, it doesn't matter whether the data is cached or read from
Config Space.  We just want to detect a mismatch with the Subject
Alternative Name.

Thanks,

Lukas
