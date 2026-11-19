Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.223.78.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795080524;
	b=tOfsYfQfk191wCQdbLBTxw0uSQhVho4BKHPEWNyBg3IkPyVWBGWYbSRGDwb4quH9Dq1x
	 T5PmLMBZsCyV2FjyvUTsCsbPZKkUpVWxYPYCF1JfowGxO/YnvFR3eKzsVCJXLYcqTewEg
	 9jz2PrCbOLhtYOeqVDx3QgTAkY6LANOzFYZZjWKKnJwa1Djt3hrH3pwNmSsR8d/cRy0Ch
	 s7T+rk3/S9pjibZd5bMqaKrEEe9j+P7ZUECBrZXm1+MKqEKNXUX70lH0zUPxPwi8I8boP
	 RuZH1P2X3JMAsFninCB1vnacTeKxl0lBOy4nkZkmHyiMNQ423XmMGvno1xKcfsiYvJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795080524;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=byE0VjoE/rHcx9os4z7iiHhAfs0Wpk3Gs/H3+lC2rTw=;
	b=3yuA2HglEqMHvW4mJrpouYmsb0/ifa8eOcylFxit5m0W3BiX76eBiX3xRckgZk0q48o9
	 ETbYQIAQofJSC2RbGZyB3oax6C2lVLLu9ytam0GcOZjKRh6xkF23Mbz1G6ADfiF8srRfz
	 p32d+muhCp2AfqlG1cfMg4zmfnb4j36Ypnlyr4IvqN1IErl0I1s2kKT1e9wVQnQeioG2k
	 DLvtoObp7pE/hkeAxcE1ybucsaIFwp4YGC3QMoxORpJTKwEfeAC5fdMSPUcBwqxFLopt7
	 BgZMzw1gC+2jWFJNGxqyC2XsoMqkr0x3NvYFzoztDbX4kEZ0BfKm8s+bGSF0E03ThCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=83.223.78.233
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7B8606A320;
	Thu, 19 Nov 2026 09:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E7B8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 866C38AD2;
	Thu, 19 Nov 2026 10:28:36 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 71A4D60003F9; Thu, 19 Nov 2026 10:28:36 +0100 (CET)
Date: Thu, 19 Nov 2026 10:28:36 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] PCI/DPC: Decide DPC ownership with
 host_bridge->native_dpc
Message-ID: <av7BRHcVkXOGT6yp@wunner.de>
References: <20261118181718.3907441-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261119001042.GA759430@bhelgaas>
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
In-Reply-To: <20261119001042.GA759430@bhelgaas>

On Wed, Nov 18, 2026 at 06:10:42PM -0600, Bjorn Helgaas wrote:
> On Wed, Nov 18, 2026 at 10:17:12AM -0800, Kuppuswamy Sathyanarayanan wrote:
> > This series makes host_bridge->native_dpc the single decider for whether
> > Linux uses DPC, as Bjorn asked during the review of "Simplify PCIe native
> > ownership".
[...]
> > Patches 1-2 are the two DPC patches from v2 of Lukas's "Error reporting
> > for AER-incapable devices", which are included here directly.
> > 
> >   https://lore.kernel.org/r/34c9ee153876bac953135b4518035194b7c07c6c.1794997749.git.lukas@wunner.de
> >   https://lore.kernel.org/r/58d8a99cc6c2ecba6dadc450ecb4501d47816732.1794997749.git.lukas@wunner.de
> 
> Applied to pci/aer for v7.5, thank you!

Hm, it looks like you applied to pci/portdrv instead of pci/aer.

Note that the first two patches in Sathya's series are identical to
the first two patches of this other pending series...

https://lore.kernel.org/r/cover.1794997749.git.lukas@wunner.de

...and so if/when that other series gets applied to pci/aer,
the two patches will have to be applied once more as otherwise
the last (7th) patch in that series doesn't apply cleanly.

If on the other hand you move the patches from pci/portdrv to pci/aer,
the first two patches in my series need not (and should not) be applied.

> B4 seems to collect historical things, e.g., Yazen's reviewed-by and
> another Fixes: tag on "PCI/DPC: Reinstate support for AER-incapable
> ports".  I *guess* that's all great, but I didn't dig out where they
> originally came from.  I don't see them in the v3 thread on lore
> (https://lore.kernel.org/all/20261118181718.3907441-1-sathyanarayanan.kuppuswamy@linux.intel.com/),
> so they must be from a previous posting.

Right, Yazen's Reviewed-by was sent in reply to v2 of Sathya's series:

https://lore.kernel.org/r/20261103201449.GB314988@yaz-khff2.amd.com

And the additional Fixes tag was from Sathya in reply to v1 of my series:

https://lore.kernel.org/r/02a33171-b901-400b-921a-c40fe167b424@linux.intel.com

But I think both extra tags are fine.

Thanks,

Lukas
