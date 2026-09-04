Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D56483832;
	Fri,  4 Sep 2026 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788524439; cv=none; b=sxL4Xq0ZdIBIqMQIgNi1HFG5dPZxuxL/YkHW5dfj7F9KTAv79T9z4kRe1QaH5vV3dbLVG2avgQr+RsaURYVC6cn59BAI3uQtytwTmaQvAhzlPifowTQM2QSVPlZOO0EM6chsOARM44xrUY32L07g9Z5PcNm23K+5qXFhXhXh37M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788524439; c=relaxed/simple;
	bh=BWZ6i/BCkDtoIDOeUcHgCiyajvc+C+i6mtW8StARfS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1OUlPxRTIUExVJCTFWEKnekIV/Zh/94DztRhbasbVSJL16A69MWKjhayecEihTZ9XM6bgCw38HgpcqhWDivpaIHAco+x99VAAEYsCflJ1PRv9LL+yxMVYlrntNMk2eYgOhW0oteLRq0j1sZvJLbYWf9jRoFtGmCGPFc463Szf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id F1D841DF4;
	Fri, 04 Sep 2026 14:20:33 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B958F61A11B5; Fri,  4 Sep 2026 14:20:33 +0200 (CEST)
Date: Fri, 4 Sep 2026 14:20:33 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Yury Murashka <yurypm@arista.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, James Sewart <jamessewart@arista.com>
Subject: Re: [PATCH] PCI: Stop waiting for link status after config read
 failure
Message-ID: <apq3kd9_qsURNpKu@wunner.de>
References: <20260904111318.1063858-1-yurypm@arista.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904111318.1063858-1-yurypm@arista.com>

On Fri, Sep 04, 2026 at 11:13:18AM +0000, Yury Murashka wrote:
> With a nested PCIe topology with multiple layers of hotplug, a link can go
> down near the bottom of the topology shortly before a link above it goes
> down. In that case, pcie_wait_for_link_status() can wait for the full
> timeout while every read of the link status register fails because the
> device has disappeared.
> 
> Return immediately when reading the link status fails so event processing
> can continue.
[...]
> +++ b/drivers/pci/pci.c
> @@ -4580,7 +4581,8 @@ static int pcie_wait_for_link_status(struct pci_dev *pdev,
>  
>  	end_jiffies = jiffies + msecs_to_jiffies(PCIE_LINK_RETRAIN_TIMEOUT_MS);
>  	do {
> -		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
> +		if (pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta))
> +			return -ENODEV;
>  		if ((lnksta & lnksta_mask) == lnksta_match)
>  			return 0;
>  		msleep(1);

It might be clearer if you check for pci_dev_is_disconnected() directly
instead of relying on a PCIBIOS_DEVICE_NOT_FOUND return value which is
generated as a side effect of the device being gone.

Thanks,

Lukas
