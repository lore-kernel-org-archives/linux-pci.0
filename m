Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B3E352032;
	Sat, 10 Oct 2026 17:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791654696; cv=none; b=n2mkPrtI8etsgisi0namNTcXwxPtrmlFgYAZNCWhgFtF10BsrE5xOGScgEJX+ezlQqpTVSVP4MpQWnuqy3BPg2EzTzgmPu9DdzQS337GX4imHGMVEdyCSawoatG85c/6Re94U+dTt1hTdnq80r9be+KMeZc+anYnHThxiwWYv+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791654696; c=relaxed/simple;
	bh=gtq3hPWwqEcezs9xu+97mDKQtbuwwzoRjuirYvK5lZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBjosKzH4D4/kZpU6Ocp9Eahekc0JGDlbUe/4FccxTPSAMqvFpGxAky9r5Ole/xGe8c7cSBXPQD65IjEtAaKwc8MnXNFsTtmqqp63HaCFF1Z1eF/+q6D/e2xr9JSn5mxzqoIlaBgn8W74AQzPJJ97Zxbs4FxmBLoAtoK1a+ngOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 0AF4A10611;
	Sat, 10 Oct 2026 19:51:25 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E42F3610D3AD; Sat, 10 Oct 2026 19:51:24 +0200 (CEST)
Date: Sat, 10 Oct 2026 19:51:24 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Alexander Gruhlke <gruhlke@mailbox.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Hui Wang <hui.wang@canonical.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH 2/2] PCI: Wait for readiness after FLR even with
 Immediate Readiness
Message-ID: <asp7HDfhDSjNtx5p@wunner.de>
References: <20261010160529.27974-1-gruhlke@mailbox.org>
 <20261010160529.27974-3-gruhlke@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010160529.27974-3-gruhlke@mailbox.org>

On Sat, Oct 10, 2026 at 06:05:29PM +0200, Alexander Gruhlke wrote:
> pcie_flr() and pci_af_flr() skip pci_dev_wait() if the device advertises
> Immediate Readiness.  Since commit 10baa9b4df40 ("PCI: Drop unnecessary
> retries when restoring BARs"), the subsequent config restore isn't
> retried, so it is lost if the device isn't ready after all.
> 
> The Samsung 990 PRO [144d:a80c] advertises Immediate Readiness but
> returns ~0 for 1-7 ms after FLR, which breaks VFIO passthrough.  Keep
> skipping the 100 ms delay, but call pci_dev_wait().

The device is incorrectly advertising Immediate Readiness, so I suggest
clearing dev->imm_ready from a DECLARE_PCI_FIXUP_FINAL() quirk and
emitting a message with KERN_INFO severity with something like
"Ignoring incorrectly advertised Immediate Readiness support".

Your patch instead silently works around the problem and that means
whenever a device manufacturer makes this mistake, their validation
engineers don't realize there's a bug and it never gets fixed and
keeps proliferating.  On the other hand, if (as I'm suggesting)
the bug is selectively worked around with a quirk only on affected
devices, then core code isn't polluted with a workaround only needed
by a handful of devices and the emitted message helps validation folks
learn there's a problem and demand a fix from the silicon team.

Thanks,

Lukas
