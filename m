Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.223.78.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794848608;
	b=zAYocQqAzYYI0ZJCVAA/GCRRXEuNmk60BonC4BSmqDxmCDcZxcp6FHmV0KEyKk1Jn8nr
	 oOvBmO2EayUSpcl0rCkA33JZmsEXvyfQL75EOPuTPwMkgnn4ZsiXDLKRMpIz7VkqSBnx9
	 YpxWNs2Q/lWMfc4c3HM5z5hbUD1ccObJnJfWdSIDeemtKmZ71CLD5THDGn3rNnXqz/OTI
	 5QGlS9UNLg9LfJr3jjvsr0z7vqU/+vfFKaAXuXf2CdUQzJMudHlAna9YkklJuzuWgyAMh
	 dLxgQtf6kwUBl2+4WXccAuZ/QnAGABb4LColV/oZf+wZo3+mR+4/0747/rFYqjugVLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794848608;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=poTgbj/foQ9K1AKRlBJ3oT0vb+LsbWUWIzTIhB6fW9A=;
	b=nFK2/FUyki1dpkoRxHjWnkex+HUPPHKKn+nIRpDMFOWziM3RtMxiG//4HeryderZRg3l
	 G14HuSLEnIPvtrAnbbvPCDY0KWR8XYOpOqmF6FK81Ga2nwEOO+m0hiz6xsf05rgTW8Gly
	 fV7evs41S4u5KHIasIq/BgJ+SWD6ooExIRA0fgQBI49n+v9bGf2Ck73H/LOw1ZUzD1drl
	 X08Pbpe3iyFJHpFe4iog+loN7wmpCj++tHDkBFhcZbJg2tFHlFGNnSegI1dGcj1hNL4q4
	 IlvWbR02HkSHrh+inmrre2Tu4oaXhV2cLWmR0BMB+6TvCU9+oGpxDdT8UzjjN2TZO1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=83.223.78.233
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8674B606A88E;
	Mon, 16 Nov 2026 17:03:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8674B606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id D7D6412E3;
	Mon, 16 Nov 2026 18:03:25 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C1763609C751; Mon, 16 Nov 2026 18:03:25 +0100 (CET)
Date: Mon, 16 Nov 2026 18:03:25 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Aviv Bakal <avivb@amazon.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Zeev Zilberman <zeev@amazon.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI/PM: Keep hotplug ports that can't wake from
 D3hot out of D3
Message-ID: <avs3XRxXT7BtbZse@wunner.de>
References: <20261115171831.1498006-1-avivb@amazon.com>
 <avnqWd1gVH-i2Jkk@wunner.de>
 <20261116165627.2775780-1-avivb@amazon.com>
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
In-Reply-To: <20261116165627.2775780-1-avivb@amazon.com>

On Mon, Nov 16, 2026 at 06:55:22PM +0200, Aviv Bakal wrote:
> On Sun, Nov 15, 2026 at 07:22:33PM +0100, Lukas Wunner wrote:
> > Intel Catlow Lake suffers from a similar issue:
> >
> > https://lore.kernel.org/all/20261103193136.2410148-1-sathyanarayanan.kuppuswamy@linux.intel.com/
> >
> > Please try to follow the approach taken there.
> 
> Thanks Lukas. In the Catlow Lake case the Root Ports still signal the
> hot-add with a PME interrupt, and only PME Status is unreliable. Our
> ports are switch downstream ports that advertise PME from D3hot but
> never send a PM_PME message, so the Root Port gets no interrupt and a
> pcie_pme_irq() hook would never run. Keeping these ports out of D3
> looks like the only option for the existing devices.

We cache the power states which support PME in struct pci_dev::pme_support.
Have you considered just modifying that in a DECLARE_PCI_FIXUP_FINAL()
callback?  See e.g. pci_fixup_no_d0_pme(), pci_fixup_no_msi_no_pme(),
pci_fixup_amd_ehci_pme(), pci_fixup_amd_fch_xhci_pme().

> I sent a v2 that fixes a runtime PM imbalance in patch 1 when NO_D3 is
> set by a FINAL fixup.

Please wait one or two weeks before respinning to allow time for the
community to review your proposed changes and provide feedback.

Thanks,

Lukas
