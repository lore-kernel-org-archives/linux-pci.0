Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9B1345CC0;
	Tue, 17 Mar 2026 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773753484; cv=none; b=S0njJaTen4HNDMDZT6kgnhtqe/FWPdDGc0UfuTz8ln/IQVWYMzPOzIfhUQzP4ZLw9HyuuWBdkk+jo6Hhg1WwsZBYrRwzaxZNDv8NIORsiP/+ktk6owIC5+BZEJHk8vpysfOLSVbv4NaYGoftfTh9naFnFUf87qWnIGOcSB5b9KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773753484; c=relaxed/simple;
	bh=V0KfKc0tx2pD+fULE8+TW1twmQfnGWEWe0zenSJhRHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5jyD9wxJ4+ZP2s8u8R3W1SKE3sa0v9Pvme1wBrfn4oPyG47I9D+eJP3Dwlih3JWS3YxuvtuIl7UOHsNlSMaLA3LzBnT2hBdkyYU9Vc5nZGbfOBH/SwJcaYWKhanEkawzJj2y1rD4JxpFKpbqoxEaGvBhd5F4DYyYLbAINC8gOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 014101058F;
	Tue, 17 Mar 2026 14:18:01 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E661C6015C0D; Tue, 17 Mar 2026 14:18:00 +0100 (CET)
Date: Tue, 17 Mar 2026 14:18:00 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Benjamin Block <bblock@linux.ibm.com>
Cc: Benjamin Block <lkml@mageta.org>, Guenter Roeck <linux@roeck-us.net>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Ionut Nechita <ionut.nechita@windriver.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PCI/IOV: Fix race between SR-IOV enable/disable
 and hotplug
Message-ID: <ablUiODohaE7_RKH@wunner.de>
References: <20251216-revert_sriov_lock-v3-0-dac4925a7621@linux.ibm.com>
 <20251216-revert_sriov_lock-v3-2-dac4925a7621@linux.ibm.com>
 <0ca9e675-478c-411d-be32-e2d81439288f@roeck-us.net>
 <20260317090149.GA3835708@chlorum.ategam.org>
 <20260317094656.GI2161595@p1gen4-pw042f0m>
 <20260317113334.GJ2161595@p1gen4-pw042f0m>
 <ablSO1rA8D2blipG@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ablSO1rA8D2blipG@wunner.de>

On Tue, Mar 17, 2026 at 02:08:11PM +0100, Lukas Wunner wrote:
> However pci_stop_and_remove_bus_device() implicitly unbinds the
> driver before removing the device.  Remind me, what's the need
> to unbind before calling that function?

Never mind, read Günter Röck's e-mail only now.  So this is just
a bandaid to work around the too coarse-grained pci_lock_rescan_remove().

I've been arguing for a while that we need to move to more
fine-grained locking, but it's difficult to get there without
breaking things, it's difficult to make sense of a lot of old code
and it's difficult to allocate time to tech debt problems like this
because employers always want developers to focus on enabling shiny
new features first. :(

Thanks,

Lukas
