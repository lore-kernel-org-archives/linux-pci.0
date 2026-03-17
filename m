Received: from mout38.gn-server.de (mout38.gn-server.de [87.238.197.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16CA259CA9;
	Tue, 17 Mar 2026 17:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.238.197.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767399; cv=none; b=sp4Q8k6NtCMGzex7PvxwiFTGXTxdKrU0k+6RTVPktm2Dl7i4G1rnvyCFL89rWei6m2A1u67Aie/AK37+S6DGBLNRBfvtTEP63DfGzGdChnqk+zalw86GNHwbH7g9hifgTK6ODItS7l14Ru9j0wPO1U9lYNXsC22Lz7kGImCvNwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767399; c=relaxed/simple;
	bh=0rF2A/mpmR0RZVfFwlyRCucqxbB+I6a7ysKMr29eWLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqITfJ74dJn0vnQhbql/bATUGsEyhP/2BqHiApWdL0Ek2ggpMC3P44zpbuztqhhrxoSYEBuUlCZkVkZ8PeMSE6l0kNlVxCyFsiVHfqJOWXwAJsBmNQuERsWWDRB9XQiEQ1nK0rKm37DSnWbF9Fw13al9UBXJkq+EKEDT9cjgVsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mageta.org; spf=pass smtp.mailfrom=mageta.org; dkim=pass (2048-bit key) header.d=lc0.greatnet-hosting.de header.i=@lc0.greatnet-hosting.de header.b=bEfHDLJZ; arc=none smtp.client-ip=87.238.197.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mageta.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mageta.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lc0.greatnet-hosting.de header.i=@lc0.greatnet-hosting.de header.b="bEfHDLJZ"
Received: from mout17.gn-server.de ([87.238.194.244])
	by mout38.gn-server.de with esmtps (envelope-from <lkml@mageta.org>)
	id 1w2Xv6-0002MF-2i;
	Tue, 17 Mar 2026 17:09:28 +0000
Received: from lc0.greatnet-hosting.de ([178.254.50.20])
	by mout17.gn-server.de with esmtps (envelope-from <lkml@mageta.org>)
	id 1w2Xv4-0003og-2S;
	Tue, 17 Mar 2026 17:09:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=lc0.greatnet-hosting.de; s=rsa1; t=1773767366;
	bh=0rF2A/mpmR0RZVfFwlyRCucqxbB+I6a7ysKMr29eWLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bEfHDLJZuaiS8NCngPuz7b7sQPSuYP2Utp4HUmIC70XIFW/FEWg7SnurAq7lJn9k3
	 SY6QSVNvPDwCmB0Eky23rhlKrhT10rvosrv553BOS/Ec9zN3mgIeA6QzsfuM6A3H58
	 jXVpClx7Uz88NcwzM4zCDP7q+eIcaH3q5FVlxQaYCViuy5UibrzgEcHm0858SPdKTe
	 zWwGNNT9u6lmLhEyCqtAUua3U+nWBadOwjsuts70P3BgMLg3Vi5l8q6UJMftzhGIyc
	 RWpMpF3d/SmGdpdE7VIIpx5/ruj4VuMvma+woNKVRASfTtA8IaZG6eDyd4W1tkFpiK
	 GE/TdawNZuJ6w==
Received: from chlorum.ategam.org (ategam.org [88.99.83.185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	(Authenticated sender: work@mageta.org)
	by lc0.greatnet-hosting.de (Postfix) with ESMTPSA id CC509E5AD4E;
	Tue, 17 Mar 2026 18:09:25 +0100 (CET)
Date: Tue, 17 Mar 2026 18:09:24 +0100
From: Benjamin Block <lkml@mageta.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Benjamin Block <bblock@linux.ibm.com>,
	Guenter Roeck <linux@roeck-us.net>,
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
Message-ID: <20260317170924.GB3835708@chlorum.ategam.org>
References: <20251216-revert_sriov_lock-v3-0-dac4925a7621@linux.ibm.com>
 <20251216-revert_sriov_lock-v3-2-dac4925a7621@linux.ibm.com>
 <0ca9e675-478c-411d-be32-e2d81439288f@roeck-us.net>
 <20260317090149.GA3835708@chlorum.ategam.org>
 <20260317094656.GI2161595@p1gen4-pw042f0m>
 <20260317113334.GJ2161595@p1gen4-pw042f0m>
 <ablSO1rA8D2blipG@wunner.de>
 <ablUiODohaE7_RKH@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ablUiODohaE7_RKH@wunner.de>
User-Agent: Mutt/2.3 (50e3b1f3) (2026-01-25)
X-GN-Spam: 
X-GN-Spam-Score-INT: 40
X-GN-Spam-Report: Action: no action
 Symbol: ARC_NA(0.00)
 Symbol: R_SPF_ALLOW(0.00)
 Symbol: RCVD_NO_TLS_LAST(0.00)
 Symbol: IP_SCORE(0.00)
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Symbol: RCVD_COUNT_TWO(0.00)
 Symbol: GREYLIST(0.00)
 Symbol: FROM_EQ_ENVFROM(0.00)
 Symbol: R_DKIM_ALLOW(0.00)
 Symbol: RCPT_COUNT_TWELVE(0.00)
 Symbol: TO_DN_SOME(0.00)
 Symbol: ASN(0.00)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: MIME_GOOD(0.00)
 Symbol: FROM_HAS_DN(0.00)
 Symbol: RBL_SPAMHAUS_XBL_ANY(4.00)
 Symbol: DMARC_NA(0.00)
 Symbol: RBL_SENDERSCORE(0.00)
 Message: (SPF): spf allow
 Message-ID: 20260317170924.GB3835708@chlorum.ategam.org
X-GN-Spam-Score: 4.0 (++++)

On Tue, Mar 17, 2026 at 02:18:00PM +0100, Lukas Wunner wrote:
> On Tue, Mar 17, 2026 at 02:08:11PM +0100, Lukas Wunner wrote:
> > However pci_stop_and_remove_bus_device() implicitly unbinds the
> > driver before removing the device.  Remind me, what's the need
> > to unbind before calling that function?
> 
> Never mind, read Günter Röck's e-mail only now.  So this is just
> a bandaid to work around the too coarse-grained pci_lock_rescan_remove().
> 
> I've been arguing for a while that we need to move to more
> fine-grained locking, but it's difficult to get there without
> breaking things, it's difficult to make sense of a lot of old code
> and it's difficult to allocate time to tech debt problems like this
> because employers always want developers to focus on enabling shiny
> new features first. :(

I agree, it's a mess :/

The quick idea here was to prevent the found AB-BA circular lock by
moving the removal of the SR-IOV VFs in front of the call to
pci_stop_and_remove_bus_device_locked(), and that is typically done when
the device driver is unbound (it's the expectation in
pci_device_remove()).

But it's just a quick idea, maybe someone else has a better one. I'm
also not sure this is the only place where we'd need to deal with this
particular AB-BA circular lock scenario (`pdev->dev` and
`pci_rescan_remove_lock`).

I'll run a few more tests, and see if I can scare up some other/new
lockdep warning with this change.

-- 
Best Regards und Beste Grüße, Benjamin Block
               PGP KeyID: 9610 2BB8 2E17 6F65 2362  6DF2 46E0 4E05 67A3 2E9E
