Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551323CA486;
	Sun, 16 Aug 2026 05:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786857297; cv=none; b=SIqVEy3emzfKK8p8tLUXMPGPYgJ5YhjBvJikX/jktVUJWKXaFeDNYI+coRu9cdH3lgjS2SXDEF82ICQlbF/pi90pzVtP8Gw1RWt97dGNvWBC1hstKHk0TA3g5d0Nq4YkloZ3807EuPzFGs8vJSPwHDCi3WJYWt0RoFzMb0xdjhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786857297; c=relaxed/simple;
	bh=iF4Rna0g/RRFckmYepdHiqfykzEDaoLS4xWWjyZSoNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euopWYCecapzd3ptAKHQR4z9DN3KE8cegcw1cmh+jpzOdHNFe9wqs+g7h6vY+E6yUNeDHL2082NUTEl5qwSaQ3vZTiU4nFGh7rzbVeO/97Tgtz0ejkiq9/OKHvWHAMqHcX2Ld5Clb7rvykoSP5NWGrLUK4X/MkunKMOCIgoT98M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id DB15E574;
	Sun, 16 Aug 2026 07:14:44 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B8E36629CE21; Sun, 16 Aug 2026 07:14:44 +0200 (CEST)
Date: Sun, 16 Aug 2026 07:14:44 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: xen-devel@lists.xenproject.org, jgross@suse.com, sstabellini@kernel.org,
	oleksandr_tyshchenko@epam.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xen/pcifront: Fix PCI device reference leak in AER
 handling
Message-ID: <aoFHREl-0XGl0uNG@wunner.de>
References: <20260813153138.3953222-1-ruoyuw560@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813153138.3953222-1-ruoyuw560@gmail.com>

On Thu, Aug 13, 2026 at 11:31:38PM +0800, Ruoyu Wang wrote:
> pci_get_domain_bus_and_slot() increments the reference count of the
> returned PCI device. pcifront_common_process() drops that reference only
> when the device or its driver is missing. All paths for a bound device
> either return directly after invoking an error recovery callback or fall
> through without calling pci_dev_put(). Consequently, each AER request for
> a bound device leaks a reference and can keep the device allocated after
> removal.
> 
> Store the callback result, release the reference after callback dispatch,
> and then return the result. This keeps the device alive while its callback
> runs and balances the lookup on every successful path.

Please use __free(pci_dev_put) instead, it'll simplify this patch
and the resulting function considerably.

Thanks,

Lukas
