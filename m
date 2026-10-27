Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793133074;
	b=H8b+9DHcNEbKFQkj5BqCo1RF+CiV+vz+TzUQ7nEYw5QNuZmRbMS6NotLi43feLs7WbYo
	 2BNQGCuxinMdXehqRTEdwlZEftXu6a7bpmNvHVQASfqKJrNhEJW1qfPcVm/DmgFQHzGfj
	 M8Z008nIihBRmysN3d5d/dm9+dE4ndv2jxduI1xvrBYFasWHr81fr7o+t0XZDnUTqjSAS
	 +pXYBW4tJj4CkZI3V6XNV9bhE8y6EHMEI0T8c/8vfUI0OxnXwjSU6AN3f2jmX5p6bSU5/
	 Igtd9iwe94OijO5iMbmctaVJrd50MHfCfVnQ7WoNiJ0UQF9PFPMqjg0RJF76ub5eeKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793133074;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4OFsko6upF7VY9Qy0g86hzBopotlU/4nWSBZUwNeVDk=;
	b=ZY3ncn21tOVN5B+qrClmFm+4kRiY1HaIKOjV1hcSNEl+uuaNZzL0RLep4neGYnCwZ4ny
	 SrrVOTKYYMXW0fwGSPVuL/A+tOhJ8mXea7Ct7yb+v5kS3hS71dwtyuefRAHk+J8nWjowh
	 znO9nsx9soPukTWQn/sZWmJGiB0/eG3UIwpuPhu0+1BA+4J+SSLecUCaTIAwmgzsSeLBI
	 zCloLLxBCGkewGiGqLjEh1R/dBFj5FpuwODd+YrNwb/KtS/Vo+sSovr6QlOYg5s9tlr9K
	 mL/5ywNH4s5GmKOxAmZxTSCfkyVXLa6aZULDFgn6+GBgvoMeZ/0hoEYdHsHxIQaCDKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LqY2vkED;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4880C606A31A;
	Tue, 27 Oct 2026 20:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LqY2vkED
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0431F01825;
	Tue, 27 Oct 2026 20:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793133073;
	bh=4OFsko6upF7VY9Qy0g86hzBopotlU/4nWSBZUwNeVDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LqY2vkED3z6g4Dn+I4JvmgE3lrXNGPbsvz/ztFZ0rysq0cmZALuJXKf5kjiVVBY+I
	 gH3EG4QsjRQ9GfJuVNJWWuhvz/fBKZ0bOY6mNAcIsoq2dZQiG4QD/PoShp2oga0VXj
	 XXlaC4t0uKKBPSBUq5TVwz2BvzC8EVq6Yts1yX1SFyZPKHMOKxuZbqMtEFLdE7AXJM
	 DuFffs+MS/GcSdLp0hDGapBEFBbxS4uIV0S/L2u4JxFctr7X9ALGnia+Eeae9r+Qtq
	 47Y+tQtosii97R/4kUbq/l6LuPMcSqV+AGIFieAp/tKHzxrkyxQVWeNQdxRo+3ZC1M
	 /69SuLCOm8ySQ==
Date: Tue, 27 Oct 2026 21:31:07 +0100
From: Thorsten Blum <blum@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@hobbes.lan>,
	Lukas Wunner <lukas@wunner.de>, Ingo Molnar <mingo@elte.hu>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] x86/early-quirks: Scan all functions in
 early_pci_scan_bus()
Message-ID: <auEKCw1oW6fXzLZQ@kernel.org>
References: <auB_h07OAckfI7gV@kernel.org>
 <20261027201338.GA485510@bhelgaas>
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
In-Reply-To: <20261027201338.GA485510@bhelgaas>

On Tue, Oct 27, 2026 at 03:13:38PM -0500, Bjorn Helgaas wrote:
> On Tue, Oct 27, 2026 at 11:40:07AM +0100, Thorsten Blum wrote:
> > Hi Bjorn,
> > 
> > On Mon, Oct 26, 2026 at 01:37:18PM -0500, Bjorn Helgaas wrote:
> > > On Wed, Sep 16, 2026 at 12:02:07PM +0200, Thorsten Blum wrote:
> > > > early_pci_scan_bus() stops scanning a PCI slot when check_dev_quirk()
> > > > returns nonzero, which avoids probing functions 1-7 on single-function
> > > > devices, but also stops scanning when a function is absent on a
> > > > multifunction device.
> > > > 
> > > > This can skip early quirks on multifunction devices with holes in their
> > > > function numbering.
> > > > 
> > > > On iMac13,1 and iMac13,2, the BCM4331 AirPort card is behind root port
> > > > 00:1c.3, also documented by the model list in commit abb2bafd295f
> > > > ("x86/quirks: Add early quirk to reset Apple AirPort card").
> > > > 
> > > > Public lspci output for 2012 iMacs [1][2] shows that 00:1c.0, 00:1c.2,
> > > > 00:1c.3 and 00:1c.4 are present, but 00:1c.1 is missing. The old code
> > > > stops at 00:1c.1 and never reaches 00:1c.3, so the AirPort reset quirk
> > > > is silently skipped on these machines.
> > > > 
> > > > Check function 0 first, and if it indicates a multifunction device, scan
> > > > functions 1-7 independently so that absent functions do not cause later
> > > > ones to be skipped.
> > > > 
> > > > Fixes: 15650a2f644a ("x86/PCI: fixup early quirk probing")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Thorsten Blum <blum@kernel.org>
> > > > Link: https://forum.libreelec.tv/thread/26799-wifi-not-detected-on-2012-imac-in-11-0/ [1]
> > > > Link: https://zoringroup.com/forum/5/7170/ [2]
> > > > Reviewed-by: Lukas Wunner <lukas@wunner.de>
> > > 
> > > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > > 
> > > Let me know if you'd prefer this to be merged via the PCI tree.
> > 
> > Thanks for the Ack.
> > 
> > I'd appreciate it if you could take this through the PCI tree.
> 
> I don't mind doing that but would like to have an ack from the x86
> folks.

Does the Acked-by: from H. Peter Anvin count?

https://lore.kernel.org/lkml/74A9835A-4B16-409E-B13A-4C34FAB5DC8E@zytor.com/
