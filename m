Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B303BBFCC;
	Mon, 17 Aug 2026 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954765; cv=none; b=CBUxMf8xWRV1y2FWNV8HZbLdICUDya0dp/VakgSe4cyM2OrTRVrA3BSNFtEKouK2P3B/gVwe/b4jPNKLz2AD1eZXPnuKzbOfM1dG8Bi+HmjqYBqIQ0tEhgEeJCXnrZ6LYJhkZ2X5UUvHBD7kr6wz21OP2a0OFLKGs8bBl0T/nxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954765; c=relaxed/simple;
	bh=EvfSUyISHXmlcBiDJWCfjmBOGJS52ldqkUdbrxldp/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNUbbnxznV/XoUmzzwFBPharF4LLbsXeMs0g1S/rFUZwt+SAmDMF0g33TGcSyBR84PUU8oknpYWbR8NTpmNZyh+c4ohvXu65tXoqd0UvI3g4eR4AaI2WEnZ8smF510XVWytQ05CdlQCgFOne0qucdrkXPhjDp1MhxBVys8gl2T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 237F5C88;
	Mon, 17 Aug 2026 10:19:13 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id DB382602C817; Mon, 17 Aug 2026 10:19:12 +0200 (CEST)
Date: Mon, 17 Aug 2026 10:19:12 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@hobbes.lan>,
	Ingo Molnar <mingo@elte.hu>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/early-quirks: Scan all functions in
 early_pci_scan_bus()
Message-ID: <aoLEAD_8GgzuDtYK@wunner.de>
References: <20260807094601.263450-2-thorsten.blum@linux.dev>
 <aoFJwldO-_qttr0P@wunner.de>
 <aoIiEZmqsOOwS6KX@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoIiEZmqsOOwS6KX@linux.dev>

On Sun, Aug 16, 2026 at 10:48:17PM +0200, Thorsten Blum wrote:
> On Sun, Aug 16, 2026 at 07:25:22AM +0200, Lukas Wunner wrote:
> > On Fri, Aug 07, 2026 at 11:46:02AM +0200, Thorsten Blum wrote:
> > > early_pci_scan_bus() stops scanning a PCI slot when check_dev_quirk()
> > > returns nonzero, which avoids probing functions 1-7 on single-function
> > > devices, but also stops scanning when a function is absent on a
> > > multifunction device.
> > > 
> > > This can skip early quirks on multifunction devices with holes in their
> > > function numbering.
> > 
> > Which device do you need this for?  We should only scan additional
> > Functions if a quirk needs to applied to them because this extends
> > boot time.  It requires a justification and shouldn't be done "just
> > because".
> 
> On iMac13,1 and iMac13,2, the BCM4331 AirPort card is behind root port
> 00:1c.3, also documented by the model list in abb2bafd295f ("x86/quirks:
> Add early quirk to reset Apple AirPort card").
> 
> Public lspci output for 2012 iMacs [1][2] shows that 00:1c.0, 00:1c.2,
> 00:1c.3 and 00:1c.4 are present, but 00:1c.1 is missing. The old code
> stops at 00:1c.1 and never reaches 00:1c.3, so the AirPort reset quirk
> is silently skipped on these machines.
> 
> [1] https://forum.libreelec.tv/thread/26799-wifi-not-detected-on-2012-imac-in-11-0/
> [2] https://zoringroup.com/forum/5/7170/

Thanks for the explanation.  Please include all of this information
in the commit message when respinning.
