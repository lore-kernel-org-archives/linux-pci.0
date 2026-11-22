Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795374937;
	b=cyTAW888wX+lXHCOgJtDN023ztmRfny+61WQcXsb+//ENz71z8QzUzuWfbwWYNUO7WBF
	 kgdO7b1ARRLBBLKmSUBcDlGB/rqC5f/9rszWGFto62AoKMMr0AoUFZXN6px1RPa1JnQOb
	 CkD+cH4MTD2VbXmPn4E/+h4iehlIDt+TYCZLBYfAqM2Nfv4F97g7ZBF2B1SLJTOAu/voH
	 /4wx9TBenxGA4sySyx1xmVtD2swpjB4sedVXJ/5DVmsTbppFq+wCkiU+2u4EeJzvIUn8F
	 ufOwz6cXY3yEcH1DpX6JK86VvxW3kUUIetYD5LOYQnvhVnQ6zO+D4y/fwr5cttPbiug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795374937;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=s3JQ1PN2z01hyjHidBbqppesEqKekrIDRVgMibkj+Gc=;
	b=iptCuMagaiJ4Zltyrx0ngONCWXiCCoAkeyHXNWbsDVRMbUWRx/giJciVgFQF3Nifc9Gw
	 BQnu4CYsDnfXnwzXM1yapSNQAfy1kfc+aQUTNY78S645H1DlkobIBcqsGmthjI6CVgOJl
	 IsCSOjvRdI0EJmyqrurIpeX/S5CYsvRhZfKGyeg+4PRIwSGydCxPUtU+X4BqAbL79YbTN
	 9IMfNho03AZAIxI3Mbr7lgbYcpv/p1YhjvwAyiE9gyNaZ0xyuRBDp/0Ga/OGUCsdw34t8
	 EfMva4oZEZdE3wu7UKt6FIKvHm6/OnrPJef5QI1HPVfmEQhFoSIGCuE1gfH42uQTeCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=kZUT+wyd;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1166606A31D;
	Sun, 22 Nov 2026 19:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1166606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=kZUT+wyd
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6BAA840E00C2;
	Sun, 22 Nov 2026 19:15:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id B6I9E6U9dvJZ; Sun, 22 Nov 2026 19:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1795374928; bh=s3JQ1PN2z01hyjHidBbqppesEqKekrIDRVgMibkj+Gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kZUT+wydZnszj8d2WyOgTudBXbkef4VcEkgM+lF7Hxrc2vOcaXfhOwxHCEp+5h9K5
	 XYro5vqyWOsAZyaRfcTRI7cqaTk9XEg/hIAUoebaK+vzaEhQEPR3a+blm4rY/TKEbK
	 Y57ZIUupapPwiN7XQDt6+DZZHtOL93ehGFXViLPc7Xg3hcLwpVpqBywzn/QuNPiagM
	 jMtbHy9b4tUMrFNdv1ZxoDjBPerah83pXxaHWmlHLYftjnRHFSoATZEIAkN7jcPNZ4
	 VNlxNEJDx9/JDPe2ihc+hSjE6iJZBpMvxm3GG/CHLo5u9TFCpr/P2PskgyZAdQvJvI
	 CVCu5dbH0oI9lLEcKI/BGS8B6D2iCncNjE72yIcQ0AuD/ZHvn9f7WTOCXjwotOp7/4
	 SSUuSpYe1PN2pfDDWI8JULi33C3utb9IFfYBMymZgtUxkLxcdBidInVhoGmdHYraHO
	 J9DOxJeWcmFz1WRbdCJp5is7R8+ryy3VGJN6QHXwqpyjF6Hm8laIRlj0bkhJajirtK
	 k2VMttWogotg5rHXW3kri2QnPKMgKQst7KbgpHH/eyLCl3Q2pCc2B2XXYI9aBjsXE5
	 /nTLwovhCY76lP0aFNmwwkXztwkw6/bgGlwL0EPFJ5czq0+aQjFlhrhospUyv1CS4n
	 TiFdD5EgWuRyrUKJ93g4chlQ=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2FF3040E015B;
	Sun, 22 Nov 2026 19:15:15 +0000 (UTC)
Date: Sun, 22 Nov 2026 11:15:12 -0800
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
Message-ID: <20261122191512.GAawM_QHC5IxcZywvs@fat_crate.local>
References: <20261106004343.457087-2-blum@kernel.org>
 <av3v7KY64vjxDCk1@kernel.org>
 <be480966-3b68-44f5-9afa-f88b3c203092@intel.com>
 <av4bS1QEZpniwlb3@kernel.org>
 <20261118222141.GBav4k9eZ5-QMjOem4@fat_crate.local>
 <awJLsDWI0OgdWhph@kernel.org>
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
In-Reply-To: <awJLsDWI0OgdWhph@kernel.org>

On Sun, Nov 22, 2026 at 02:56:00AM +0100, Thorsten Blum wrote:
> I never suggested the patch had to be taken immediately. And 3+ months
> doesn't seem particularly immediate to me for a bug either.

Did you not read my mail?

"So just from looking at the diff, that patch will definitely NOT go to stable
but needs to stay in tip for at least a cycle so that it is tested as widely
as possible.

Because if you break other systems with it, we will have to revert and fix up
after you."

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
