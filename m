Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.223.95.204
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795507294;
	b=2NggyyuSNd1oKLl/qWKgrZZFNVjE2j+X5PWpybAHP7PRsPAZiVLOlFcNEQ8j0R0MePOR
	 TXytd2J/ai9jFhhyZ5ZDraocQykx+qJL7vO47nvhH+nVX5sdjARMQt9aJaDMaZJ3A01vE
	 KMvVvHi2nVRfuDIhEilXLmWUtk+jGNnE7UWCkqMJvxy9faZ9aAWOfusWuTk3Ga2ojVKKK
	 MePCeo9OapS0vOgDdn3wx+aS+T7VkpGSy6nGEwbUvvs6WHrH0Yuv/O5TA5lWnqIVCHkD3
	 HbVI3Rl2GVN1y+xiyhek9vuT01kQZNZmgztLxnJWNjNVRuUTj9Zr09L/tGfqmneK7iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795507294;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=w60ChxhfjjyfFkUUASsSzKZDcN5aQP+KbDtTX3bjvGw=;
	b=XyKAG8aPOBwfGABlTIYsEqIxJH4F+WJ6duUCwtgvjT0md3Tjas6YGnmd3+fG53CkRsln
	 0ZT9nooiHCy726pvGeeRE2HpI4oLrpme/U9J4xDFcOZyfqtXcpYINUMzMDmB2bMcbhG/y
	 9RgKoqx7Px4bS8fS3ZfuJGYpURIjr3bCPhYlqyTqfN6Z01q9hWGRsyEtkgCJbUd67Gw25
	 WSSBgybcRmzggxKOz8tMyHeI9GiHGLBEpLgF5OgzR31MbyUQ/am2WPquINsdIlHWfhk4L
	 /eQbkGUSNhxMWPhhf0od7jrPSqek/iSBaqrPfqWBxDAlyS3H2w4KUh7fALi9d/ENrZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=83.223.95.204
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69065606A31E;
	Tue, 24 Nov 2026 08:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69065606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 5DDE2383;
	Tue, 24 Nov 2026 09:01:24 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 48EFB6016C52; Tue, 24 Nov 2026 09:01:24 +0100 (CET)
Date: Tue, 24 Nov 2026 09:01:24 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH 4/4] PCI/AER: Hide the "aer" sysfs directory on devices
 without AER
Message-ID: <awVEVPX1dzGZeVya@wunner.de>
References: <awMs4CwlPT2vsDV2@wunner.de>
 <20261123234603.GA1123067@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123234603.GA1123067@bhelgaas>

On Mon, Nov 23, 2026 at 05:46:03PM -0600, Bjorn Helgaas wrote:
> On Sun, Nov 22, 2026 at 06:56:48PM +0100, Lukas Wunner wrote:
> > On Fri, Nov 20, 2026 at 07:31:25PM -0600, Bjorn Helgaas wrote:
> > > If so I might amend this commit log to mention
> > > that, since Lukas's subsequent "PCI/AER: Enable baseline capability
> > > error reporting" enables aer_dev_correctable, aer_dev_fatal, etc even
> > > for non-AER PCIe devices.
> > 
> > With that subsequent patch, the "aer" subdirectory with the ratelimiting
> > knobs appears below every PCIe device (unless allocation of aer_info fails
> > due to high memory pressure), but not e.g. below Conventional PCI devices.
> 
> Are the ratelimit knobs useful for devices other than Root Ports and
> RCiEPs with an AER Capability?  That's the only place we get
> interrupts, isn't it?  I guess DPC also?

Ratelimiting is per-device, hence the ratelimiting knobs appear below
every device capable of error reporting (AER or baseline).  With baseline
capability error reporting, the same messages appear in dmesg and tracing,
albeit with fewer details.

If your question is whether the ratelimiting knobs are useful unless
there is an AER-capable Root Port above the device (or the device is
associated with an AER-capable RCEC, or is itself an AER-capable
Root Port or RCEC) then the answer is indeed no.  They're not useful.
We could hide them if you want.  The same applies to the error statistics
exposed in sysfs.

Without an AER-capable Root Port or RCEC, errors can only be signaled
as System Errors.  This needs to be enabled in the Root Control register
of Root Ports or RCECs (PCIe r7.1 sec 7.5.3.12), either manually by
the user or by platform firmware.  The kernel doesn't set those bits.
It only clears them (in aer_enable_rootport()).

For DPC, there is no ratelimiting implemented.  Recovery from DPC normally
takes on the order of seconds, so the recovery procedure limits the amount
of messages emitted via dmesg or tracing.

The DPC driver does call aer_get_device_error_info(), which would perform
ratelimiting.  But first of all, this is only called if DPC is triggered
by the Downstream Port itself (e.g. upon an ACS Violation), not when
receiving an Error Message from a subordinate device.  I.e. it uses the
Downstream Port's pdev->aer_info struct.  And second, the DPC driver
populates the info->ratelimit_print[0] field with "1" beforehand in
dpc_get_aer_uncorrect_severity(), which means "always print".

Thanks,

Lukas
