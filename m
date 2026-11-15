Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.223.95.204
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794764971;
	b=WaOuOkbHMc07T+6JAIZo56yeqx7xsoguKeACSsqJpp+UKy4lMGMSEBwUTDCRuh/98JGc
	 YAB3rY63lSYXf99cJb9BTrNR2sn9Z5+kTBTARh9cn8eXkBsyKb3FdyVzAmH9D3RqS+TsX
	 OtcYXTlEa/E2U+XA/NNX/Qb+L0gUTJDFI+xncNtQlW0xMriBWFed7Yn96dmX1HGcb5Hdq
	 xF+sk6RHmLlLh866DxLwbDxf1vSMGDqUQ2WVqz8aD0JyKNzgcwqYcSM4v/eQz+OOAqH+H
	 LiI+h+vgUEOi8srsTITqeLZQebyBjoFsOoOU/Ls0qkAzoKyc4NZBJQo5/SLiiSmwM7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794764971;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=pZAgF01SM5lIexqBmUoxE9oWzEW7iDQOMWgBWjnXcuw=;
	b=tDZu9QS1xhvgO65Jiqh7hC9yur+uq2neix3u28iJIYZNHzBK5lK2E/YiRF2BruPn9W0s
	 ufJO8izkh02HjOuG7marHc+DUIdgomZoHHQZgYCa5F2eNJCzJlvjIeDp7Y6PDOhjmUMRy
	 rbruHcizApx690FcqJwaDUvI8dK5AuWv45BXZD66H6EC+dGQRVcrKBIVCdaql1Tqr+I2Q
	 qiFnb9OvqTWaFzF6rVfeo8MnV/yYZBBGFBFkdkHIFIoXPfMYLv3xBXSEKgzyDQyYAzami
	 gFuz03D5aYA0VCa4Do8DPPk/n9x9Dr67wyvXM2UaGu84nzXv5RzklLSlwndnBPgYDPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=83.223.95.204
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AD4606A31E
	for <linux-pci@vger.kernel.org>; Sun, 15 Nov 2026 17:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1AD4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 2BAD5F62;
	Sun, 15 Nov 2026 18:49:23 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 14ECF6024661; Sun, 15 Nov 2026 18:49:23 +0100 (CET)
Date: Sun, 15 Nov 2026 18:49:23 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Raag Jadav <raag.jadav@intel.com>,
	Riana Tauro <riana.tauro@intel.com>,
	Yury Murashka <yurypm@arista.com>,
	Matthew W Carlis <mattc@purestorage.com>, linux-pci@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Aravind Iddamsetty <aravind.iddamsetty@intel.com>,
	Srinivasa Adatrao <srinivasa.adatrao@intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/7] PCI/DPC: Avoid access to non-existent AER capability
Message-ID: <avnwo7TeDBimPwWG@wunner.de>
References: <cover.1790531238.git.lukas@wunner.de>
 <ae05fe2df3a3182594c4a9638daba1c72cf40358.1790531238.git.lukas@wunner.de>
 <74fe0d79-dc90-4c05-ba9c-9a0eec1ada48@linux.intel.com>
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
In-Reply-To: <74fe0d79-dc90-4c05-ba9c-9a0eec1ada48@linux.intel.com>

On Tue, Sep 29, 2026 at 11:49:40AM -0700, Kuppuswamy Sathyanarayanan wrote:
> On 9/27/2026 11:02 AM, Lukas Wunner wrote:
> > Downstream Port Containment does not mandate presence of an Advanced Error
> > Reporting capability, so a Downstream Port may support DPC, but not AER
> > (PCIe r7.1 sec 6.2.11.2).
[...]
> > - dpc_get_aer_uncorrect_severity() uses it to discern whether a Fatal or
> >   Non-Fatal Error triggered DPC.  Access the Device Status Register
> >   instead, in accordance with PCIe r7.1 sec 6.2.5.
> 
> This changes behavior not only for AER-incapable ports, but also for
> the AER-capable ones.  PCIe r7.1 sec 7.5.3.5 says for the Fatal/
> Non-Fatal Error Detected bits:
> 
>   "For Functions supporting Advanced Error Handling, errors are logged
>    in this register regardless of the settings of the Uncorrectable
>    Error Mask register."
> 
> The old code only considered unmasked errors, the new code also picks
> up masked ones.  So a masked Fatal error (e.g. Surprise Down) alongside
> the unmasked Non-Fatal error which triggered DPC is now reported as
> Fatal.  Stale bits from earlier masked errors can have the same effect.
> 
> Since this is tagged for stable, how about keeping the AER-based logic
> when dev->aer_cap is present and using DEVSTA only as a fallback?

An excellent observation, I've changed it as you've suggested.
Thanks for the thoughtful review!

Lukas
