Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.223.95.204
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793726954;
	b=3sCHvx1Ls9l2WaKQGQiGAO3unzciQrSlMLaiFBaVwBCa4ck/ssyc5YwQIhZi36m5a8Vh
	 /0W/QipKt39qOuDXgcRjZvtGnHMiCL7Hae4Xb3am0W51nbf6IkDHKbgqK2lg1CLGwMJqf
	 cEhqWwLrmDq2ShvD9I6s2qcVyZh3VkLXExWmk6+2Sep81e/wJxQtxs6d0p/+evuHvZAul
	 3UmONFYtPVCO3c8YwzWXNSUgccKdh/nI/gztCj6ps/9foYxSOW6rT61H3dDI404qLhJdv
	 YWgci1DJfnW98d4grG9OZJECi/qae4R+/axldPcH4Giudo3f31NEbNMm5KRnqGT1etg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793726954;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cC12UYzCu8sy1bCE6Lezkt3f0flNvCrpYHTMzDNInOs=;
	b=CxQhFHN+VRYMu22FY4jvd+M4qQZsQRV6pqkm7YLjRZUNHnTdeRjWUYgWAtlx8fKtzGCF
	 aSYlbsGN4tlCnW1RnyUOeihy9BtuoDsjI0YkfZlCnDzfkhNYT1vGUfaOFl3oag1dXdarC
	 6qI4Gpo4g/Lu8M1Vz76q9c3TIdNQKF/VeD/0kCeEdyRlUC6U4h41CqXll6Z80a6jUiDfO
	 9+mseaJUp4WXRnDJKjPzYYYEpnGLNucqGyfdWvcstiFpY7QoLqst/FhG5Y0n2XPdWxXRr
	 HzaMaUqf/dxGf6e9awe3ECaXk7PmILZFSPQx/5Zj6P+3z/GvXWHLRkkw2f2r5WWjTfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=83.223.95.204
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECE3606D80B
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 17:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ECE3606D80B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 5218963D;
	Tue, 03 Nov 2026 18:29:09 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3DABC602D90B; Tue,  3 Nov 2026 18:29:09 +0100 (CET)
Date: Tue, 3 Nov 2026 18:29:09 +0100
From: Lukas Wunner <lukas@wunner.de>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI/AER: Check validity of Error Source ID register
Message-ID: <auoZ5fjqShIeGzje@wunner.de>
References: <cover.1793697480.git.lukas@wunner.de>
 <27a3876874161204e7a37ab63e7b27ee9783261f.1793697480.git.lukas@wunner.de>
 <sashiko-outbox-195012@kernel.org>
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
In-Reply-To: <sashiko-outbox-195012@kernel.org>

On Tue, Nov 03, 2026 at 10:11:52AM +0000, sashiko-bot@kernel.org wrote:
> > -	/*
> > -	 * When bus ID is equal to 0, it might be a bad ID
> > -	 * reported by Root Port.
> > -	 */
> > -	if ((PCI_BUS_NUM(e_info->id) != 0) &&
> > +	/* Some Root Ports report an invalid Error Source ID */
> > +	if (e_info->id_valid &&
> >  	    !(dev->bus->bus_flags & PCI_BUS_FLAGS_NO_AERSID)) {
> >  		/* Device ID match? */
> >  		if (e_info->id == pci_dev_id(dev))
> 
> Can this cause a false positive match on the Root Port itself and skip
> searching the subordinate hierarchy when a buggy Root Port reports 0x0000
> (or loses the bus number of a downstream error source)?
[...]
> With this change, aer_isr_one_error_type() sets info->id_valid via
> source_id_valid(), which returns true whenever pci_dev_id(root) == id. On
> platforms where the Root Port itself is at 00:00.0 (such as many SoC PCIe
> controllers or VMD domains), pci_dev_id(root) is 0x0000.

I am only aware of Intel and AMD silicon reporting an invalid Error Source
ID, not of any ARM or other SoCs misbehaving in this way.  On Intel and
AMD silicon, bus 0 is generally the root bus and never the subordinate
bus of a Root Port, so an Error Source ID with bus 0 will continue to be
considered invalid after this patch, unless it matches the Root Port's ID.

In the log output I've seen so far, the slot and function number of the
invalid ID is always 0 and there's generally no Root Port at 0000:00:00.0
on Intel and AMD platforms, so the Root Port's ID isn't matched.

It would be possible of course to always search the hierarchy if the Root
Port's ID is found in the Error Source ID register, but I'm inclined not
to do that unless there's a need.  If anybody knows that this can actually
occur or feels strongly that it should be handled, please let me know.

Thanks,

Lukas
