Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [144.76.133.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B376335BDB8
	for <linux-pci@vger.kernel.org>; Mon,  2 Feb 2026 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770028952; cv=none; b=eO+IIYn2tggfbSeurfN5/yGMaLgY8EomDUoC4o5t+fh5k1rUAHJEfADBRQpLdVK7bpy3ChECYfCdAFZ9DDq9wdQnv1ed1gWAcEpfXlLZKA5C5GZgT/0UoFumm9fGpLHptbg2W/iZRuPyym9qMJ3anbAPeI82zRd2+CpKaZlPtyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770028952; c=relaxed/simple;
	bh=+slSCtj/zsYfmdj0kQqfv4p3Dtfo8oS+mSFE/2eHJfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/H8NTwMcnuPNaRBWbMWQKC5+T9lCDXvTIuvkGPAEpDv+/Otr6u/Erz0WkSe0jDIaX6S3vbNVwOggP5h4TRSpaL9gaQoiFtVqCxCq32HxMt33NAYW5eZxdFBIAPYP5SMSPudr3CapI+beRlhwvQjEc/g84FY0tcMI5+W8s9WVmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=144.76.133.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 365AE2C02044;
	Mon,  2 Feb 2026 11:42:22 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 09132290CA; Mon,  2 Feb 2026 11:42:22 +0100 (CET)
Date: Mon, 2 Feb 2026 11:42:22 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Terry Bowman <terry.bowman@amd.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-pci@vger.kernel.org, Shuai Xue <xueshuai@linux.alibaba.com>,
	tianruidong@linux.alibaba.com, Keith Busch <kbusch@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] PCI/AER: Clear stale errors on reporting agents upon
 probe
Message-ID: <aYB_jmq7xlyKpBFb@wunner.de>
References: <3011c2ed30c11f858e35e29939add754adea7478.1769332702.git.lukas@wunner.de>
 <20260127230055.GA384686@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127230055.GA384686@bhelgaas>

On Tue, Jan 27, 2026 at 05:00:55PM -0600, Bjorn Helgaas wrote:
> On Sun, Jan 25, 2026 at 10:25:51AM +0100, Lukas Wunner wrote:
> > Correctable and Uncorrectable Error Status Registers on reporting agents
> > are cleared upon PCI device enumeration in pci_aer_init() to flush past
> > events.  They're cleared again when an error is handled by the AER driver.
> 
> Do you think pci_aer_init() is the right time to clear the error
> status bits?  Most of those bits are sticky, so they're not cleared by
> reset.
> 
> I'm thinking about the scenario where a PCIe error occurs is captured
> in the AER error status registers, but the system reboots before the
> AER driver can log the error.  Since the bits are sticky, the new
> kernel might have a chance to find and log the error that happened
> with the previous kernel.

I agree that *reporting* errors instead of just silently *clearing* them
could be useful.

We cannot pinpoint when the errors occurred, so we'd have to mark them
in the log messages as having occurred "during shutdown or early boot"
or "during suspend or resume" (for errors occurring during a system sleep
cycle).  But that could still be good enough and helpful for users.

We could report them with KERN_INFO severity and if that turns out to be
too noisy, demote them to KERN_DEBUG or exempt certain error types
(such as Unsupported Requests).

Shuai Xue and I had a discussion late last year about reporting
versus silently clearing stale errors:
https://lore.kernel.org/all/aPoIDW_Yt90VgHL8@wunner.de/

I think we were both unsure back then whether you would entertain a patch
to report stale errors.  But since you're now raising the issue yourself,
I'd say yes, it's worth pursuing.

However I think the $SUBJECT_PATCH still makes sense:  If I were to submit
a series to report stale errors, I'd still first amend the code to clear
all stale errors (instead of leaving some of them uncleared), then amend it
to report errors prior to clearing them.  The $SUBJECT_PATCH is sort of
a fix that distributions may want to backport, whereas *reporting*
stale errors would be a new feature not eligible for backporting.

> So I wonder if pci_aer_init() should just find the Capability and
> alloc its buffers, and aer_probe() should look for existing errors and
> log them before clearing them.

Devices may be enumerated after aer_probe(), e.g. when they're hot-added
below an AER-capable and hotplug-capable Root Port.  For cases like this,
we'll still have to clear (and in the future report) stale errors in
pci_aer_init().

(The $SUBJECT_PATCH takes this into account and explicitly calls out
this corner case in the commit message.)

Thanks,

Lukas
