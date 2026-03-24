Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F2E3DCD90;
	Tue, 24 Mar 2026 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774347757; cv=none; b=dn8f9cCbV4z00OBMadVXU+TJSpjbz/kswzBxEczQX/20BeVECcJZ47I13aWftKLCeJRVE9/uXjf/i3Llev17r3jQ4KxhvSrwOdpiVzKJPANRqvcUKtZJ8Qfe5Eb3D0Euq5V/2904eTD+ZFndI1oPTl8nqXwEnt/mg/FsSczRQcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774347757; c=relaxed/simple;
	bh=ZaVpOuqWe+lMTa4ioP4YzsJIB0fj6T3JpZ+eEhkTogM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrzaNJJifv+iNAWjPWzrIoR4osEhd2m8RvlfrGlv86FYZ1HhUVp6ubRLzERp1wWc8RvmmHGH8h1jXTBQAtPIjVwelXeTRYdPc5CUmPwXhof1i1FR9WYNjmXOaf+qijyiWm4OUnpxbbxaj61e3iumaWg3J67eP6BoOgKfnZytsFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 1A338111F;
	Tue, 24 Mar 2026 11:22:26 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 02239602F6DA; Tue, 24 Mar 2026 11:22:25 +0100 (CET)
Date: Tue, 24 Mar 2026 11:22:25 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Maciej Grochowski <mx2pg@pm.me>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>
Subject: Re: [PATCH] Documentation: PCI: Document decoding of TLP Header in
 AER messages
Message-ID: <acJl4UuObg04RbAd@wunner.de>
References: <20260323165038.GA830530@bhelgaas>
 <jlpBGxAZL6_8dQI417NowB0RVfrnwcnuaNvBlTN035buqP4dRBJaaX3fwqtYxZu2evmcNCAJVzj2suZKDA5iriUSrpj_ziWQVWxZS3nEkEg=@pm.me>
 <acJi32zgSVvDPVyK@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acJi32zgSVvDPVyK@wunner.de>

On Tue, Mar 24, 2026 at 11:09:35AM +0100, Lukas Wunner wrote:
> Ilpo (who is cc'ed) amended the kernel last year with commit
> 7e077e6707b3 ("PCI/ERR: Handle TLP Log in Flit mode") to suffix
> the hexdump with " (Flit)" in Flit Mode:
> 
> https://git.kernel.org/linus/7e077e6707b3

Sorry, I should have mentioned that this commit first appeared in
v6.15, so auto-detection of Flit mode logs in user space tools
should be possible from that kernel version onward.

> As an aside:  Prior to that, commit f68ea779d98a ("PCI: Add
> pcie_print_tlp_log() to print TLP Header and Prefix Log")
> changed the log message to prefix each dword with "0x".
> But I tested it and it seems that tlp-tool groks both the
> old and the new format without any code change:
> 
> https://git.kernel.org/linus/f68ea779d98a

This landed in v6.14.

Thanks,

Lukas
