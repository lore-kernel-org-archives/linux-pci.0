Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD4B25B0B6;
	Wed, 13 May 2026 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778683733; cv=none; b=F0Q56HjnCd86u54NzAx5HiTrnRTtHJqq1YRpPvfNQKReCdZf3P2HnUzmUMMHBdDcw37dUQK6GyCs2zCaX+a41BJQbjz+TL2OQ8FpLazEDqe9zfBJXTyqwEwPm15h2V59G5YaBGfCI+c0r5JWoaFFwOdqXzaDZZqgFNbJ96joHt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778683733; c=relaxed/simple;
	bh=ykGdJ8cXkbJJE2UzOEUH+vK4xWORellzvzyNIe/AE0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDXzegVyjed+DiMyQJb05y8Ps5oQ0VpnF8MmMd7dmhSeLYT0mVK/9un/lHFdn06iqYijexnxGTOwsK2R9SnRaAfPKehncXhlA+TcB6lbN5TYCgjYKblpvgbrSfzd/Puo3ZJoa9clR8zmalUIlrUvU8eDP2f0cgmv+az/edAbEzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 190E11060C;
	Wed, 13 May 2026 16:39:24 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 078286016B8F; Wed, 13 May 2026 16:39:24 +0200 (CEST)
Date: Wed, 13 May 2026 16:39:24 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: bhelgaas@google.com, alex@shazbot.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PCI: Add D3cold as general reset method
Message-ID: <agSNHLc_Sc_G-7vz@wunner.de>
References: <20260513122349.268753-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513122349.268753-1-jtornosm@redhat.com>

On Wed, May 13, 2026 at 02:23:48PM +0200, Jose Ignacio Tornos Martinez wrote:
> Add D3cold power cycle as a general PCI reset method, available for
> single-function devices. This provides a more robust reset mechanism
> than D3hot for devices where a full power cycle is beneficial.
> 
> The implementation uses pci_set_power_state(dev, PCI_D3cold), which
> automatically handles platform differences:
> - Platforms WITH _PR3 ACPI power resources: true D3cold (power cycle)
> - Platforms WITHOUT _PR3: automatic fallback to D3hot transition

Why fall back to D3hot, even though the name of the reset method
suggests it uses D3cold?  If D3cold isn't supported, I'd just not
expose the new reset method.

> Reset hierarchy with this change:
> 1. device_specific
> 2. acpi
> 3. flr
> 4. af_flr
> 5. pm (D3hot via config space)
> 6. bus (SBR)
> 7. cxl_bus
> 8. d3cold (NEW - power cycle with D3hot fallback)

I'd call it "powercycle" for clarity but that's just my preferred
bikeshed color.

> +static int pci_d3cold_reset(struct pci_dev *dev, bool probe)
> +{
> +	int ret;
> +
> +	if (dev->multifunction)
> +		return -ENOTTY;
> +
> +	if (probe) {
> +		if (!pci_pr3_present(dev))
> +			pci_dbg(dev, "d3cold reset: no _PR3 support, will use D3hot fallback\n");
> +		return 0;
> +	}

So I'd just return -ENOTTY here in the !pci_pr3_present() case
and I'd do that for probe == 0 as well.

Thanks,

Lukas
