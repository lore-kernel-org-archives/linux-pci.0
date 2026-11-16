Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.223.78.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794830342;
	b=c2ZZJEy0KbO7QdtJh7JXb+Cdqr57x9Gv4vJaGZyEhchivgcEJEnKOY9GSTEsXnwfJZTD
	 FXVAw0qRf6S87E+RmHO7HsTlXLuvlcMPhNkwM7nG1/e4lDVNzrFmPQdB0H3Ts0ApjcXzj
	 +Wr3v3jnO6drNZU0w1GLKAHJj54nT5XA7QHSzfFBEdX2aYDNNVAmJRebGhVqQ2fTHnmYP
	 CCq2QWmeNqivj7HisR3dyUyv+HRxU1mF9n+bDiXqvrd3A6BLxLfZVHiTPPTtHIA1j8zwJ
	 Vrh2xuZ2qnHCOIQ5CdVEgMyRqpevzs+ila9WMIbGRtZpOW5Lz+mWdbYnD6iCHbPoiIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794830342;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NHGeGqCVFN2Tv1lma1Bg8GLYblLTY4Dtm4iduW7dQss=;
	b=4hkhhZ0l8dGVvQVLRWpjF1WTKom8K9XWueMHqQVK87bxi3ZtW0UWPOTNXY7l6JFM3PM4
	 XP3hzRfjEBQiUIDcRFgNN+Fq1/sTdPAc4ujZDK3y+M9hNXz7tYd1bslA1lXyc+pFW8MzK
	 /QI+r65yL081nmJ4nUbsRpBMjCr3Zl89eADLXHSUKVHAg8oQeu5wFiavkpUPXsl+EKdfS
	 Hxc9t/6VjyBgTNSqd+rIsG5yNp9RfXBCSUH8OR5T3OSKoeOIJf7dLOB5TlLaAWWtdkLLe
	 wrx9ynRCtaS+r+yQdPZ78LsWuUXg0+c0PG+mtFe9glq3PXnZY+R30hIIXWyY2i7RxJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=83.223.78.233
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE751606A33F
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 11:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE751606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id BE474283E;
	Mon, 16 Nov 2026 12:58:59 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A33D66031F0E; Mon, 16 Nov 2026 12:58:59 +0100 (CET)
Date: Mon, 16 Nov 2026 12:58:59 +0100
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
Subject: Re: [PATCH 5/7] PCI/AER: Move AER capability check out of
 pcie_aer_is_native()
Message-ID: <avrwA4wokDuOACxx@wunner.de>
References: <cover.1790531238.git.lukas@wunner.de>
 <6a21637111397810d75679d1ca597766f3bf5605.1790531238.git.lukas@wunner.de>
 <7d21f908-ea38-4b8c-9646-0aaaa520206a@linux.intel.com>
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
In-Reply-To: <7d21f908-ea38-4b8c-9646-0aaaa520206a@linux.intel.com>

On Tue, Sep 29, 2026 at 12:47:26PM -0700, Kuppuswamy Sathyanarayanan wrote:
> On 9/27/2026 11:02 AM, Lukas Wunner wrote:
> > When firmware grants control of Advanced Error Reporting to the operating
> > system, that not only encompasses the AER capability, but also error
> > enable/status bits in the Device Control and Device Status registers
> > (PCI Firmware r3.3 table 4-6 bit 3).
> > 
> > PCIe devices without AER capability still support baseline capability
> > error reporting through these enable/status bits (PCIe r7.1 sec 6.2.1),
> > but the bits must not be modified unless AER control was granted.
> > 
> > pcie_aer_is_native() is unsuitable to check for control of AER-incapable
> > devices because it implicitly checks for presence of an AER capability.
> > 
> > Move that check to its callers (where needed) to allow using the function
> > for the imminent baseline capability error reporting.
> 
> Agreed that ownership and AER presence are separate questions, but
> changing the semantics while keeping the name may trip up callers that
> assume "native" implies "present".  Would a separate ownership-only
> helper (e.g. pcie_err_is_native()) be cleaner?  It could also replace
> cxl_error_is_native().

We usually use spec terms in the code to make it easier to connect the
code to the spec.  PCI Firmware r3.3 table 4-6 bit 3 uses the term
"PCI Express Advanced Error Reporting control", so pcie_aer_is_native()
seems apt.  I agree that it is a little non-obvious that it also
encompasses baseline error reporting control, but that's the way it is.

Thanks,

Lukas
