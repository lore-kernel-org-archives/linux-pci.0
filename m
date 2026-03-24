Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800203E0C66;
	Tue, 24 Mar 2026 10:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774346983; cv=none; b=oSptlbp1g93kqOadjbzHarPZLsnypDATdMTbzxUe0FWPOYtQnLd2MfzQspFMuM4iZvBFPL2eUDUKEwIOzLa45v0qT7zYSOdFrLiLY7WchycY9Ii2K6n7KgdszH6kGKzPvbD0NajA5zKD1IMaPWqMvPjsVjxsy7JS/4gAKq2NcsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774346983; c=relaxed/simple;
	bh=pmsrmIHgYeHFG0kURoZevA5M15R4F0uqCB8leN/RxYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijqcXKQJ+CaDTLlAvIuLwOxp8vNXrFUjlrug+t5ZXExGm1AxH8YccGIQqyI+hIp5Qy8e0VcbH28szeHXWn/ENRB3DuFb5buHpEJops86iIrNWOiUvcZ0qUduOhpdUuYv2w0pv+lFYgVsQiJZH5MTwuB9ZmUuqLp6Qh7e7kMLUgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id EE43610632;
	Tue, 24 Mar 2026 11:09:35 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id DB61D602F6DA; Tue, 24 Mar 2026 11:09:35 +0100 (CET)
Date: Tue, 24 Mar 2026 11:09:35 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Maciej Grochowski <mx2pg@pm.me>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>
Subject: Re: [PATCH] Documentation: PCI: Document decoding of TLP Header in
 AER messages
Message-ID: <acJi32zgSVvDPVyK@wunner.de>
References: <20260323165038.GA830530@bhelgaas>
 <jlpBGxAZL6_8dQI417NowB0RVfrnwcnuaNvBlTN035buqP4dRBJaaX3fwqtYxZu2evmcNCAJVzj2suZKDA5iriUSrpj_ziWQVWxZS3nEkEg=@pm.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jlpBGxAZL6_8dQI417NowB0RVfrnwcnuaNvBlTN035buqP4dRBJaaX3fwqtYxZu2evmcNCAJVzj2suZKDA5iriUSrpj_ziWQVWxZS3nEkEg=@pm.me>

On Tue, Mar 24, 2026 at 05:53:30AM +0000, mx2pg@pm.me wrote:
> One thing worth calling out: starting with PCIe 6.0, Flit Mode is
> mandatory at 64.0 GT/s and supported at all PCIe link speeds, so a
> Flit-capable PCIe 6.x link may operate below 64.0 GT/s and still be
> in Flit Mode.  The raw TLP Header bytes do not encode the framing —
> the same four bytes decode to entirely different packet types in   
> non-Flit vs Flit framing.  The negotiated mode can be read from the
> Flit Mode Status bit in Link Status 2, or via lspci -vv on a recent
> pciutils build.

Thanks Maciej for chiming in.

Ilpo (who is cc'ed) amended the kernel last year with commit
7e077e6707b3 ("PCI/ERR: Handle TLP Log in Flit mode") to suffix
the hexdump with " (Flit)" in Flit Mode:

https://git.kernel.org/linus/7e077e6707b3

Any chance you could amend tlp-tool to auto-detect Flit Mode
if the suffix is present?

As an aside:  Prior to that, commit f68ea779d98a ("PCI: Add
pcie_print_tlp_log() to print TLP Header and Prefix Log")
changed the log message to prefix each dword with "0x".
But I tested it and it seems that tlp-tool groks both the
old and the new format without any code change:

https://git.kernel.org/linus/f68ea779d98a

But we need to be careful going forward not to break user space
tooling that might rely on the syntax.

Thanks,

Lukas
