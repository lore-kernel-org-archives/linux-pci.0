Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43037309F1C;
	Thu,  2 Jul 2026 05:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782969427; cv=none; b=L4clIAHJXFyXVdfCD2/dVtq/kxdhMaET8n0MGy2G/TpJ3tr4qwTXn2kXXlC58JDvA3KN0Pz3jPGYN8RqwTSVfQpuENO6Vr9NFyzClbyF47Q9qXPTseWVvAoM72czxZV5MpHqC6e56iu6TLarbbBI/s1M/6RWxQM8semeFYWVotw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782969427; c=relaxed/simple;
	bh=Hv/Tg68BR/p6J7KoZcWW6I0o4dgoEHYJYxF1jYcYt60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSXPrsCwZ0otNB8PSzAK9bD1T8GSkIHE7PFv6fAocYbT1iwjdefuOsalMDRdSy61kBG3i/Eg9anIPkozH+Qh7QpUcX6CTOPKk09Ennzeqx187mGunxrG3Ucm3hiILAWoTiLks3hElfXZEzqo7+pXBPL7vF20+PghTTW48gl3K5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id C750110E41;
	Thu, 02 Jul 2026 07:10:46 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id AA686602C804; Thu,  2 Jul 2026 07:10:46 +0200 (CEST)
Date: Thu, 2 Jul 2026 07:10:46 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Max Lee <max.lee@canonical.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	acelan.kao@canonical.com, Kai-Heng Feng <kaihengf@nvidia.com>,
	Victor Shih <victorshihgli@gmail.com>,
	Jon Pan-Doh <pandoh@google.com>
Subject: Re: [PATCH v2] PCI: Mask Replay Timer Timeout for Realtek RTS525A
Message-ID: <akXy1gsijpfslOJm@wunner.de>
References: <oc3i3yn4c22s5c3gtqgs7a4wrpqiywwvboxstdf7josxddqmpd@y43m75ovby2t>
 <20260701204201.GA302478@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701204201.GA302478@bhelgaas>

On Wed, Jul 01, 2026 at 03:42:01PM -0500, Bjorn Helgaas wrote:
> On Wed, Jul 01, 2026 at 08:27:13AM +0200, Manivannan Sadhasivam wrote:
> > On Wed, Jun 10, 2026 at 10:47:23AM +0800, Max Lee wrote:
> > > The Realtek RTS525A PCI-Express SD card reader (10ec:525a) generates
> > > excessive Correctable Error (Replay Timer Timeout) AER events during
> > > PCIe link initialization. On systems where firmware enables AER
> > > reporting (CERptEn+), this causes an AER storm of ~240K error events
> > > within 11 seconds of boot, overwhelming the kernel error handler and
> > > blocking shutdown/reboot.
> 
> Specifically, I guess these error events are the AER interrupts.  We
> rate-limit the actual *messages*, but not the interrupts, so we can be
> overwhelmed by handling them.

Ratelimiting went into v6.16.  It would be good to know whether
the behavior described in the commit message occurs only with
older kernels or persists with ratelimiting.

It would also be good to know whether the "overwhelming" occurs
with OS-native AER handling (aer_print_error()) or with Firmware
First AER handling (pci_print_aer()).

The PCIe port driver is registered in a device_initcall, which happens
much later than PCI device enumeration in a subsys_initcall.  Do these
errors occur before the port driver registers?  If they do, then the
"overwhelming" likely happens through the Firmware First code path.
Or perhaps "within 11 seconds of boot" is when portdrv probes and
registers the AER driver?

It would be good to have full dmesg output for analysis because this
is all a little murky.

> Based on the flowchart in PCIe r7.0, sec 6.2.5, it looks like an
> Endpoint that detects a Correctable Error but lacks an AER Capability
> sets PCI_EXP_DEVSTA_CED and, if PCI_EXP_DEVCTL_CERE is set, sends
> ERR_COR upstream.
> 
> I suspect that what we need here is:
> 
>   - Mask PCI_ERR_COR_REP_TIMER in Endpoint to prevent it from sending
>     ERR_COR
> 
>   - Mask PCI_ERR_COR_REP_TIMER in upstream bridge to prevent it from
>     sending ERR_COR
> 
>   - If the upstream bridge is not the Root Port, mask
>     PCI_ERR_COR_REP_TIMER in Root Port to prevent AER interrupt if it
>     receives ERR_COR, e.g., if the Endpoint or bridge lacks AER

The last bullet point doesn't sound quite right:  Per table 6-4 in
PCIe r7.0 sec 6.2.7, Replay Timer Timeout is detected by the Transmitter.
This can only be the Endpoint or its upstream bridge.  If the upstream
bridge is not the Root Port, masking PCI_ERR_COR_REP_TIMER in the
Root Port doesn't help.

If the Endpoint or its upstream bridge don't support AER, one has to
clear Correctable Error Reporting Enable in the Device Control Register
to suppress the Replay Timer Timeout errors.  Obviously this will
suppress reporting of any other Correctable Error as well.

> I wonder if aer.c should disable the AER interrupt by temporarily
> clearing PCI_ERR_ROOT_CMD_COR_EN if it detects a storm.  Maybe that
> could avoid device quirks for transient issues like this.

The hierarchy below the Root Port might be deeper and we'd risk
losing errors reported by other devices in that hierarchy while
interrupt generation is temporarily disabled.

Thanks,

Lukas
