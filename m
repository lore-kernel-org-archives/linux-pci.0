Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793134781;
	b=RP9VcmsTTB4I/Vz4gWBpMm3hbs/ZpLkylLkH1H4sZXek3KvUY36SRGyvEu/433l2Aun7
	 004DcFNRCxpifbYYaF2zlonnakuRXcf4KnA+MyjFNgo5irpzc/P7T3w68Zfvp4TUIyLVm
	 aEuNy+YlTgJf4fOGhFI8ps+b4ZAS6DXSUmG+EQ36DhsO/okFpV1JjY1Gy82miKS3ktS1t
	 Arw5CbElJ3KzqXmWOAMVW2q/gB7Dd2KLmU1g91N2zv4StoUI/sN5pY92xRvaiwGWfutFM
	 CLKMhBnzKZSlIl8WkSbHa25HDuvIeSSn8ANdWMkZQL15r1gSIil3y5dfvI/WLT+lZRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793134781;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=IifkB4Q17JOJAFSomoXrO8XezYyOvYby0T1n5Hm9s+U=;
	b=3hArPi/69ael6BdDKdnjUnYOzBU6FtLbDvNMRbNZ+bX28d1Zgs6VIVFqhH+x5o7DotAk
	 I1ChSVXVXWkPjZMWmwmzgfVPgPTLB+BXVAKGBwUf6/zyz4nKl5TVosmrf3rEqydRw8z6Y
	 GlcHbzcrCXnTh3W4RKaIbnXAFUBcw6zLHjcz+GCGbBtlxmuYgKbItst/BAg4SGvlu/pFB
	 rftmaa4hQneJHmRTAmPEk1cNldn6TULj15YbVHLBdTV/WmJOm4PNJMtxyMa91IC9t6lfg
	 IWAEv5RNebx9VMIN/c6CEGnf9zXK5h9sVxKhPXIX5my8qjbCXuwp1YMSJFe3L/1eneA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ghe1hVCo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3238D606A31A;
	Tue, 27 Oct 2026 20:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ghe1hVCo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B7A1F01825;
	Tue, 27 Oct 2026 20:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793134781;
	bh=IifkB4Q17JOJAFSomoXrO8XezYyOvYby0T1n5Hm9s+U=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ghe1hVCoC8u96Ev4Gzl45wb/t5nD8r3GnWOSFZEOCGCryEMhZJxscxUHSjlq+kscc
	 ryxLe/uEeNGk/2w9YovZkB5RRpfSeLyb1YaX7DVD9fgYIFpax8LmhKV/wQUYXf/VXo
	 fToA8j0MP0WapmfRnsRLeRDAj+T83pFNM/OxHm3KyNM6ae+KcDh9L4dIuI0zylIYMJ
	 DdJPdhOg4knwuu8vTWGu6lLIGPgICIaTkVom5Ql3OTSUepPapkGGD/Ooy/qCID1FGA
	 Kq8cUzQOTZx+b8ejJbo7LXQcqcOb7EQjqPyiCFj6Dwi03m5mH+qInkheSP7Ns97qmd
	 uI0lRaTACJbYw==
Date: Tue, 27 Oct 2026 15:59:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thorsten Blum <blum@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@hobbes.lan>,
	Lukas Wunner <lukas@wunner.de>, Ingo Molnar <mingo@elte.hu>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] x86/early-quirks: Scan all functions in
 early_pci_scan_bus()
Message-ID: <20261027205939.GA494260@bhelgaas>
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
In-Reply-To: <auEKCw1oW6fXzLZQ@kernel.org>

On Tue, Oct 27, 2026 at 09:31:07PM +0100, Thorsten Blum wrote:
> On Tue, Oct 27, 2026 at 03:13:38PM -0500, Bjorn Helgaas wrote:
> > On Tue, Oct 27, 2026 at 11:40:07AM +0100, Thorsten Blum wrote:
> > > On Mon, Oct 26, 2026 at 01:37:18PM -0500, Bjorn Helgaas wrote:
> > > > On Wed, Sep 16, 2026 at 12:02:07PM +0200, Thorsten Blum wrote:
> > > > > early_pci_scan_bus() stops scanning a PCI slot when check_dev_quirk()
> > > > > returns nonzero, which avoids probing functions 1-7 on single-function
> > > > > devices, but also stops scanning when a function is absent on a
> > > > > multifunction device.
> > > > > 
> > > > > This can skip early quirks on multifunction devices with holes in their
> > > > > function numbering.
> > > > > 
> > > > > On iMac13,1 and iMac13,2, the BCM4331 AirPort card is behind root port
> > > > > 00:1c.3, also documented by the model list in commit abb2bafd295f
> > > > > ("x86/quirks: Add early quirk to reset Apple AirPort card").
> > > > > 
> > > > > Public lspci output for 2012 iMacs [1][2] shows that 00:1c.0, 00:1c.2,
> > > > > 00:1c.3 and 00:1c.4 are present, but 00:1c.1 is missing. The old code
> > > > > stops at 00:1c.1 and never reaches 00:1c.3, so the AirPort reset quirk
> > > > > is silently skipped on these machines.
> > > > > 
> > > > > Check function 0 first, and if it indicates a multifunction device, scan
> > > > > functions 1-7 independently so that absent functions do not cause later
> > > > > ones to be skipped.
> > > > > 
> > > > > Fixes: 15650a2f644a ("x86/PCI: fixup early quirk probing")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Thorsten Blum <blum@kernel.org>
> > > > > Link: https://forum.libreelec.tv/thread/26799-wifi-not-detected-on-2012-imac-in-11-0/ [1]
> > > > > Link: https://zoringroup.com/forum/5/7170/ [2]
> > > > > Reviewed-by: Lukas Wunner <lukas@wunner.de>
> > > > 
> > > > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > > > 
> > > > Let me know if you'd prefer this to be merged via the PCI tree.
> > > 
> > > Thanks for the Ack.
> > > 
> > > I'd appreciate it if you could take this through the PCI tree.
> > 
> > I don't mind doing that but would like to have an ack from the x86
> > folks.
> 
> Does the Acked-by: from H. Peter Anvin count?
> 
> https://lore.kernel.org/lkml/74A9835A-4B16-409E-B13A-4C34FAB5DC8E@zytor.com/

I saw that and intended no slight to Peter, but MAINTAINERS says
"reviewer", suggesting he might want less responsibility.  I was
hoping for Thomas, Ingo, Boris, or Dave to step up, especially since
Dave did ask a question.

I'm guessing this is v7.5 material since 15650a2f644a dates to 2008
and abb2bafd295f dates to 2016?
