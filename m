Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795633525;
	b=Nu28LDOmtXdTngPr7j9gxyI7PnG9E9Tk6jbfg39t7tGmZDeTnuFTWZe143r/femtyRVq
	 6Q54ZZo/XFmodWY1PLmHBRLNTrcsMYJUsL7d/GaAq5PGVi+OJXQf1NWobS4aXWNc1hqJW
	 jm22E7IKb78qam8asnlJhG3OM3k4gMEt7qxiOLVmUftZUP+mHa3p5XgjyetKth7482phl
	 x0nHpwY9AWphaAz4glBrnvway72y6IHEwlSXc4nP38Ji+Erho9C2NGFALvy4wZpIByfpB
	 Hh1E80lCiYr2LCwHfO42LvULEqjWe238jw99NyQD5dbNBpOkw2RS6kTE4gK4+PmTmqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633525;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+K9z+JLzMrfJPntuF9FvApZEWHZe8MV7bNkm04mbyAU=;
	b=uOtkFHh+m22Aepl0B19OApb+Kha7X0GFQxZUJMCvXkGtNh5YIluhlA/XnKc8dbf7iPyO
	 dd/2ggvsUpf/Jx3b+jtVJtqdZJ1h3rA3KpAhSWf0A2cAHRkwNA+rOYg6g+c/3NhohacmG
	 iJTSfFNwnYJrwZHBYj7HDrqHmZ0FSWymtvCubdeDMQwxmonJLVmNRBhDKGR3E6z1BduFC
	 8SS7EQVGqCvt7YQ9zZWiEZjzBwl7u5yYplgM260WZdegBVMgzDQC2OE51NCWO+nrYBgLS
	 iyJdLO2SecABFRMXrXor0borEsVxOaovPmz03ZlNh6J4FG3yfeg7aG3BLoL6JPuCz+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=Gs8p8NnI;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D17606A321;
	Wed, 25 Nov 2026 19:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49D17606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=Gs8p8NnI
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id ECE1D40E01F2;
	Wed, 25 Nov 2026 19:05:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9Rd5jfsoAnea; Wed, 25 Nov 2026 19:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1795633518; bh=+K9z+JLzMrfJPntuF9FvApZEWHZe8MV7bNkm04mbyAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gs8p8NnIOoUNQGGEcSK+AK8vteglu9zK3wte1b9wPzfFLPP5M4/bpZv89cTyiUP1f
	 iV3/6be0UoTr5XPAztUNbh8a5mc+ERwx5ddwnB//7rGhJ0FwLnXQ7xiUrFJF4DGEp8
	 BS8JOQXgscDSlR4GLHZ9g8jVxtoiIvvDF+H05cDlkQ/zmWVSFx12F4uAl63bOuK88A
	 1m9oacuoRwonE5xYt+LZfg+yfuN4DuVUXXSRaf0ClzbLf952Lkfv4XvxGPXlO4ZWdi
	 AebQ7ZlacDL/IOt86gcwyilDxJHj4WlDTAquiMrQU4BCPpI5rJ6JzQUk606KXuXP3k
	 3rqifzysOURGn0Vhzk8bPImaQW29ePEQ4O9KDtHpCwvFTg6HqlvTj/U68iCGSj8r9u
	 k7JSEOn9R2p3L1HQj/cUo5NQjPkuCYolgLW/HTqpAi03Brb1HrBzSDvl5NgvEgoOgQ
	 H0MGShoUFZ/OD/YAZz/nmCu5XLjPmgIqvQ13UBazNf57jPjFweqWo/TrTVmvUdGhMc
	 /8hKsBEvUK366ZCmfflFJ0gGwnx1PHn+aLeaKNMVgJt55AWC6ZrtHBkHQoet7eTexl
	 /WlYc+Y6KkqETmEhn/OMO7mKETqGrRrFaUIbWwU5fmBWqS6fDCJvo2RFvtOGMnPPGD
	 PLh00cQnrWAK+CcB21UWO7eE=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 32D9340E01E1;
	Wed, 25 Nov 2026 19:05:05 +0000 (UTC)
Date: Wed, 25 Nov 2026 11:05:02 -0800
From: Borislav Petkov <bp@alien8.de>
To: Thorsten Blum <blum@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@hobbes.lan>,
	Lukas Wunner <lukas@wunner.de>, Ingo Molnar <mingo@elte.hu>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] x86/early-quirks: Scan all functions in
 early_pci_scan_bus()
Message-ID: <20261125190502.GAawcxXra35JYHDvmv@fat_crate.local>
References: <20261106004343.457087-2-blum@kernel.org>
 <av3v7KY64vjxDCk1@kernel.org>
 <be480966-3b68-44f5-9afa-f88b3c203092@intel.com>
 <av4bS1QEZpniwlb3@kernel.org>
 <20261118222141.GBav4k9eZ5-QMjOem4@fat_crate.local>
 <awJLsDWI0OgdWhph@kernel.org>
 <20261122191512.GAawM_QHC5IxcZywvs@fat_crate.local>
 <awbj4V167BPw0Er-@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <awbj4V167BPw0Er-@kernel.org>

On Wed, Nov 25, 2026 at 02:34:25PM +0100, Thorsten Blum wrote:
> I never suggested an immediate stable backport either.

A patch which has CC:stable, means it will be picked up for stable.

Yours needs a whole cycle of testing and more and *then* it can go to stable
after doing a careful backport and testing it there too.

> And I agree that the patch needs wider testing before it can be
> backported to stable or merged upstream. That's precisely why I'd like
> to see it in tip and linux-next.

It is on my todo list after -rc1.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
