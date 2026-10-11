Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A84C3019CD;
	Sun, 11 Oct 2026 18:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791742447; cv=none; b=KtcOs0npYqmgOeG+EvHJBVPgZjdT0jbKRv3M8v+dDsu07P6PPHlNFiA4m6PpcFBmm9KW8UhWitm8+GC8yx3PTSnAFWFsg9IW3oq4vEyOmOTPGUybNKEl7Uy59/3tOliZG59wqfBEWkeXVnICqNFPOsiqvYpw1LegfySeBuWHMGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791742447; c=relaxed/simple;
	bh=8fkRy+hbx6JROA0AOdzjH5szm2JpRaUNLuktqhFUfFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aswe+K/750iOm6pqFF/XpO0ngRKSKBUqb5IffyRblSmPE4EBsfUcgZgcHtLPbHF0P2xmuvovYQ3mHEzl2fieEuf2azfrnJtjJ2WvFMd7ImhZlgGKAYpIexKHQU+Nezm9Cr9IoOWEv+Imq6qBxEoeB02DpKHzPzbm/uEd+lM36Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 3378C8A47;
	Sun, 11 Oct 2026 20:13:58 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 0B6B5610791C; Sun, 11 Oct 2026 20:13:44 +0200 (CEST)
Date: Sun, 11 Oct 2026 20:13:43 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Alexander Gruhlke <gruhlke@mailbox.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Hui Wang <hui.wang@canonical.com>, Linux-Fan <info@masysma.net>,
	sashiko-bot@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH v2 2/2] PCI: Don't treat ~0 as ready in pci_dev_wait()
 with RRS SV
Message-ID: <asvR10NRftif8A8C@wunner.de>
References: <sashiko-outbox-167316@kernel.org>
 <20261011164955.24425-1-gruhlke@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011164955.24425-1-gruhlke@mailbox.org>

On Sun, Oct 11, 2026 at 06:49:55PM +0200, Alexander Gruhlke wrote:
> On Sun, Oct 11, 2026 at 04:41:42PM +0000, sashiko-bot@kernel.org wrote:
> > Does this cause pci_dev_wait() to exit prematurely for Virtual Functions
> > (VFs) that return ~0 under Configuration RRS Software Visibility?
> 
> Yes, but that's the current behavior for all devices; the patch only
> changes it for non-VFs.
> 
> VFs could be covered by reading the Command register when the Vendor ID
> reads ~0 and waiting while that is ~0, too.  Devices that are ready would
> still need only one read.
> 
> Lukas, Bjorn: should I do that in v3, or keep the current form?

For a patch which is going to be backported to stable (due to the
Fixes tag), changing behavior is not a good idea, so I guess you
were right to read the Command Register on VFs if the return value
is 0xffff.  I apologize for my earlier misleading comments.

You could probably constrain the Command Register read operation
to VFs as those are the only ones that would need it, right?

I've started to wonder if VFs can actually be inaccessible and
thus cause a 0xffff response.  So I looked up where the spec
language in PCIe r7.1 sec 7.5.1.1.1 originates from:

It was introduced in PCIe r5.0 sec 9.3.4.1.2 and then r6.0 moved
spec language to sec 7.5.1.1.1.  As rationale, PCIe r5.0 only says:

   "This field in all VFs returns FFFFh when read. VI software should
    return the VF Device ID (see Section 9.3.3.11) value from the
    associated PF as the Device ID for the VF.
    
    IMPLEMENTATION NOTE: Legacy PCI Probing Software
    Returning FFFFh for Device ID and Vendor ID values allows some
    legacy software to ignore VFs. See Section 7.5.1.1.1."

So it's a little unclear to me whether inaccessibility of VFs can
actually occur, but again, for a patch with a Fixes tag, it's better
to play it safe.

Thanks,

Lukas
