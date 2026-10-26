Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039840;
	b=2cANUdRmanymPxZUtiKO1EnH12Wd98ssv8ytC+YFaYhO4FSjNoUAFsvMUzuUP3dnITbY
	 TNdw/enK0uMG4ZPyJUF173jcn0+4kkwvLHJO6+EtxJlS4uR5PwwkgXAkptoNLtVIL/zBh
	 Cs5Eo7y6YTxof1qlruzUGpX6x+fNzcJH/ETLBLl8nTLIwXJRxwMoFAX0N7+z37PrD2w9J
	 AgMt2x5VzkPyIBM9xES/firGqKjY2z0o7m2mm5DAv70b7ANRmj0c8W2dGlq8d815mNASV
	 glYc7xwmdIIclVbpr/LY7YX//tWrw5U7eBfXvgPeGPNmdHTT/REiD3fnkPEu8gHsKHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039840;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Kb+i0dehyGP8y6ZgLQAfXJ/ELyQ0v/y9crVmQDJxX9Q=;
	b=tKmEDCdU/1+c0bi2RZHrO4w+UmBSRpJ5WTmVU1ZANwRXd0KXwXbUcWZ4g65gnYiGBzhe
	 gst6steW29rq6Yt4WOu08pecR4eg482aoll4Gc2Q746tyyOElg6E0wrjKx/3LxuzzAbaP
	 m/ilxiTgOVdQ9EpgFBBWeo5XUr7Qvty8QwPhpaM52X11p51eezakpfjJNKvfSjuxU0zEt
	 U9uDSEY794ir9kOeBI1VgwKZL/oTYdI4B+WeRC5doT5IUbS5EcMsf1OGUl8BWTzg+uRbZ
	 KFIvaOXck5WkTUpQX4e1HUOn0wn7fbLmWVko4vDurHVpMUvyTzH2I1AvlGYsF2Kf9mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KEfOZiqd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E04606A31D;
	Mon, 26 Oct 2026 18:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KEfOZiqd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01801F01825;
	Mon, 26 Oct 2026 18:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793039840;
	bh=Kb+i0dehyGP8y6ZgLQAfXJ/ELyQ0v/y9crVmQDJxX9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=KEfOZiqdb04mNcmXdV03bHX2QadJmb7mf29bXsoHNUygzQRyROcy5KdYYdm6Y8akC
	 6rUCID+Q9XTb7ahJ8TUhUvL1RZk+qpECeWcjEgG0lU/FI+o9U4h991B3Va24DpJXvG
	 kw0YLXFuQ82zMLufNab4w8zFxmQj6rHNyLw+ZzbgEu7ZOflLEUNYW1OckGgYx0fxxx
	 eo7Z7ph4MOqgMoZkom5zPW2GR1gaZ8vYLhYJOt2Hxiq9msrx/duw8KikQeh2fUcJnF
	 dY7rmaQaLKXPRDIamuBg1GAriYJYWdVBZkqUdbt81u/xrl8xysrtTT+tXpvKFDQmbJ
	 wayxn7ajcHpag==
Date: Mon, 26 Oct 2026 13:37:18 -0500
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
Message-ID: <20261026183718.GA335290@bhelgaas>
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
In-Reply-To: <20260916100206.92853-2-blum@kernel.org>

On Wed, Sep 16, 2026 at 12:02:07PM +0200, Thorsten Blum wrote:
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
> Signed-off-by: Thorsten Blum <blum@kernel.org>
> Link: https://forum.libreelec.tv/thread/26799-wifi-not-detected-on-2012-imac-in-11-0/ [1]
> Link: https://zoringroup.com/forum/5/7170/ [2]
> Reviewed-by: Lukas Wunner <lukas@wunner.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Let me know if you'd prefer this to be merged via the PCI tree.

> ---
> Changes in v2:
> - Add iMac13,x background information and supporting links (Lukas)
> - v1: https://lore.kernel.org/r/20260807094601.263450-2-thorsten.blum@linux.dev/
> ---
>  arch/x86/kernel/early-quirks.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
> index 6b6f32f40cbe..c641f38eca3a 100644
> --- a/arch/x86/kernel/early-quirks.c
> +++ b/arch/x86/kernel/early-quirks.c
> @@ -795,12 +795,14 @@ static void __init early_pci_scan_bus(int bus)
>  	int slot, func;
>  
>  	/* Poor man's PCI discovery */
> -	for (slot = 0; slot < 32; slot++)
> -		for (func = 0; func < 8; func++) {
> -			/* Only probe function 0 on single fn devices */
> -			if (check_dev_quirk(bus, slot, func))
> -				break;
> -		}
> +	for (slot = 0; slot < 32; slot++) {
> +		/* Only multifunction devices may have functions 1-7 */
> +		if (check_dev_quirk(bus, slot, 0))
> +			continue;
> +
> +		for (func = 1; func < 8; func++)
> +			check_dev_quirk(bus, slot, func);
> +	}
>  }
>  
>  void __init early_quirks(void)
