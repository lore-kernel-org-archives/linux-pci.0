Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [144.76.133.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C59628BAB9
	for <linux-pci@vger.kernel.org>; Thu, 12 Feb 2026 21:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770932183; cv=none; b=ZP6VvhSGBAfDWR6J9WF07R2FlbpZoZMyUR33tUYDHG35ZhkB5iNfRex4QvQ93LeEzdQ6O4z1p6BNY9bELKlycslHKFSYuKJ6xFBv0yY5/H6ukBrQxRRST/o87k+8BSaWUgnhuFz2JltV2VPRQqgQgUiPK7zHDiCKwklYPrlymtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770932183; c=relaxed/simple;
	bh=IfHlzDAqeVHJiPRadAPMmDrQmjmAeUzXUyHbm/cWeEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAJNLhK/pmvcW4Ry5hKtJmPgNhFjo1+A4h4ji7rW5kuyz6ULTOikBAxNi4Qd7rlTWg/GFQpqA3SbnTvpjZ+FZq6iEsDcZv+Q7bBMcXX5OzVNh1DZ2/GiFpRzp/bRB5Czd2DE/9+ljE2LziMFvNZRb1uDXAu4Dg6qbhWIw/85n9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=144.76.133.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id B60DD2C003C3;
	Thu, 12 Feb 2026 22:36:12 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 692E23E75E; Thu, 12 Feb 2026 22:36:12 +0100 (CET)
Date: Thu, 12 Feb 2026 22:36:12 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Danielle Costantino <dcostantino@meta.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Keith Busch <kbusch@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI/DPC: Clear Interrupt Status in dpc_reset_link()
Message-ID: <aY5HzFYjhLmOQhs6@wunner.de>
References: <20260212191818.3625264-1-dcostantino@meta.com>
 <20260212191818.3625264-2-dcostantino@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212191818.3625264-2-dcostantino@meta.com>

On Thu, Feb 12, 2026 at 11:18:17AM -0800, Danielle Costantino wrote:
> Clear PCI_EXP_DPC_STATUS_INTERRUPT alongside PCI_EXP_DPC_STATUS_TRIGGER
> in dpc_reset_link().  Both bits are RW1C in the DPC Status register per
> PCIe r6.1, sec 7.9.14.5, so writing them together is safe.  The native
> path is unaffected because dpc_irq() has already cleared the Interrupt
> Status bit before dpc_reset_link() runs.

Hm, doesn't this create a risk that in the native case, an interrupt may
be lost (i.e. cleared without acting on it) if it occurs between clearing
the bit in dpc_irq() and clearing it in dpc_reset_link()?

Maybe I'm missing something and this isn't a problem, but in that case
an explanation in the commit message would be good *why* it's not a
problem.

Thanks,

Lukas
