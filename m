Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D757B358D37;
	Sun, 11 Oct 2026 18:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791741637; cv=none; b=UBPznoxGoYeXF3eHGnJE4Nixw3e38zxHG0I24y8ZFerLtsewXo8GBRD3dMTyHRfkLZU5s/V66SW+Lhi+BDW255O5BbtHk5JRRTUdXim+xyK+ZLP5qg3d73Bzxs5kjgW1rB65/6xo1r+6Q6I1VIgZKYAyu8ncmkKTLNnhMbqJgPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791741637; c=relaxed/simple;
	bh=J89NQxL812jQCeCCVredyUVicXwKkIfeowFct8t4w1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aundPkU3AO34kspJZo/7Rvlq+M0cGDDoxDNgmNtrdCbKf4aSSXi89o/gK7pHMubj6fQ9bBu3uO4q2VUPQrL56NoUKiyO77b0Fr453KFz8prBMUNkDOJDPkCC0UnegMDjY3YyZYCgoHwvfgM/aGMVZZe7NXWLdqicj1ULtXuoSEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 4FFC31A29;
	Sun, 11 Oct 2026 20:00:32 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 26B9D6107912; Sun, 11 Oct 2026 20:00:32 +0200 (CEST)
Date: Sun, 11 Oct 2026 20:00:32 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Alexander Gruhlke <gruhlke@mailbox.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Hui Wang <hui.wang@canonical.com>, Linux-Fan <info@masysma.net>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH v2 1/2] PCI: Ignore Immediate Readiness on Samsung 990
 PRO NVMe
Message-ID: <asvOwGIE9bBkGtfL@wunner.de>
References: <20261011163249.18479-1-gruhlke@mailbox.org>
 <20261011163249.18479-2-gruhlke@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011163249.18479-2-gruhlke@mailbox.org>

On Sun, Oct 11, 2026 at 06:32:48PM +0200, Alexander Gruhlke wrote:
> The Samsung 990 PRO [144d:a80c] advertises Immediate Readiness, so
> pcie_flr() doesn't wait after FLR, but the drive returns ~0 for up to
> 7 ms.  Since commit 10baa9b4df40 ("PCI: Drop unnecessary retries when
> restoring BARs"), the config restore after FLR is lost, which breaks
> VFIO passthrough of the drive.  Firmware 8B2QJXD7 responds right after
> FLR, but older firmware such as 1B2QJXD7 doesn't, and the firmware
> version isn't visible here.

If a firmware update is available from the vendor, we generally
refrain from adding a quirk and instead tell users to update.

OTOH, the offending patch breaks setups that worked before,
which is annoying.

It's also a bit of a bummer that the quirk can't check the
firmware version.  Has the upgrade changed the Revision ID
in the Config Space header?  If it did, that could be used
to identiy non-broken devices, but usually it's only incremented
for new silicon revisions.

Up to Bjorn what to do here.

FWIW,
Reviewed-by: Lukas Wunner <lukas@wunner.de>
