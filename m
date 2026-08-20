Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF61D3D7D91;
	Thu, 20 Aug 2026 15:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787241328; cv=none; b=WnrO00M/EzdvYW5GKbOrONTtVEDNKAYlNw0A8dDUuDOba5hmDPcZPaWTJmPGTvcOoLPy2n0YUsfHYCO3tkhrmdh8Y7iFhUuMOd67Pem2BfH+69+zCtcp1+jB+ACE/eLSEQmRPEnd+WxLMI559X418p1/CRXFJHiEo0jHSPSR53k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787241328; c=relaxed/simple;
	bh=I5cRkwDRTNmy/hnXPSTdljezap6WbNp07vduMfs49nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUu1f2eI21GrpwZjfTw9Nc9pzzZ2jWJieL7OehpZusvPSBmaYr6pLrFX7R97/JENqsKw4zUJIMiSHG/4F671Mi53w0DFuCoZani8xV9eo2dzsM6MOwNWeoFW4a4wL4fztp8bjpwrc1HJS/YALyaUClyM+hav/9uPGj1+zdpkODk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id C2E75D6F;
	Thu, 20 Aug 2026 17:55:22 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 908AB61024E6; Thu, 20 Aug 2026 17:55:22 +0200 (CEST)
Date: Thu, 20 Aug 2026 17:55:22 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@hobbes.lan>,
	Ingo Molnar <mingo@elte.hu>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/early-quirks: Scan all functions in
 early_pci_scan_bus()
Message-ID: <aocjajWEF1fV8-_E@wunner.de>
References: <20260817090011.26011-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817090011.26011-3-thorsten.blum@linux.dev>

On Mon, Aug 17, 2026 at 11:00:13AM +0200, Thorsten Blum wrote:
> early_pci_scan_bus() stops scanning a PCI slot when check_dev_quirk()
> returns nonzero, which avoids probing functions 1-7 on single-function
> devices, but also stops scanning when a function is absent on a
> multifunction device.
> 
> This can skip early quirks on multifunction devices with holes in their
> function numbering.
> 
> On iMac13,1 and iMac13,2, the BCM4331 AirPort card is behind root port
> 00:1c.3, also documented by the model list in commit abb2bafd295f
> ("x86/quirks: Add early quirk to reset Apple AirPort card").
> 
> Public lspci output for 2012 iMacs [1][2] shows that 00:1c.0, 00:1c.2,
> 00:1c.3 and 00:1c.4 are present, but 00:1c.1 is missing. The old code
> stops at 00:1c.1 and never reaches 00:1c.3, so the AirPort reset quirk
> is silently skipped on these machines.
> 
> Check function 0 first, and if it indicates a multifunction device, scan
> functions 1-7 independently so that absent functions do not cause later
> ones to be skipped.
> 
> Fixes: 15650a2f644a ("x86/PCI: fixup early quirk probing")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Lukas Wunner <lukas@wunner.de>

I'm wondering if the Fixes tag should rather refer to abb2bafd295f
("x86/quirks: Add early quirk to reset Apple AirPort card"),
or whether it's necessary at all given the relatively small number
of affected machines.

This will slightly lengthen boot time as all 8 functions of
multifunction devices are probed, but that is mitigated by the
existing check for an "all ones" response to the config space read
of PCI_CLASS_DEVICE:  The remainder of check_dev_quirk() is skipped
for non-responsive Functions.

Thanks,

Lukas
