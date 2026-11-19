Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795049793;
	b=ffPkLubLdfQdKCThUs74X0suohMiTLILrRp5MiA8wXZUEbGVQPKFLgXBFmO0fh/vVjFH
	 w4Oa0AS8G7BBWSBMljRjRAzY7cfE+NzDzN0DUN1yI8z526Ekj9DQFWkxLskaF0L+Zzqql
	 98hb1qzcRJX3rR4rumJIF7TRfaVgLINaro1ncDZdIPSrJaO38Y5SrAMfDxwz9Q5OCVF4Z
	 3lyLdg0qlNGKy7yswGA2q4DHlisUTYmON44aiaNpecr7Tw8grHaydO7wj0QOemf3valE7
	 my2IgnioG1flDSfgOr+fQx/LSK30/eM8hcnDnka85EwC4kBZdN/h5ElDqbhkatcyplQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795049793;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=t1/l4ujGxLXHOlhsP1teHJo9aFG9Lea7dOQj250ucDc=;
	b=sgIzDwlL+qaZ6v+QZz39kJ/RwOXYbrJ4nVvF9/bjxpnx+ow5WQO33Jz9Dl9eAgZWEb/A
	 CT7p6QAnO/C9/gEmfLK5V82TaeqFR9gkf+XD0ZsVZCgJE09KRztg0qSqfmhsLjqjXPHCL
	 0z6+H3HQcnf3+LDJ3OVUT9ADGGdhPJoUa7PgVZfe0ffpvMk2fzWWsHiL+DJ14Lxi/ueqb
	 WVhLaxTDvqKrrg096UMznemLLuiUhUVtJxGr498NIy74BajVIXfW/G+OywRmwGmkrB2QS
	 k6KY994v1OhkvoeKWDBQT3D0KISZofR5PEbX30jpTBknanqUyyh6XNoymCy1QTdrZdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b="fqZu/mA4";
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B35C606A325;
	Thu, 19 Nov 2026 00:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B35C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=fqZu/mA4
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CF11C40E0184;
	Thu, 19 Nov 2026 00:56:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ptV1qDH5BxCl; Thu, 19 Nov 2026 00:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1795049786; bh=t1/l4ujGxLXHOlhsP1teHJo9aFG9Lea7dOQj250ucDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fqZu/mA47C2ztaW8TP9EtK5uhzPMTaaDHJFDFs3aNn9JWUa1XSNQlggzduAnX4pkw
	 utOuE++ETfLAQ5Jy90U3y4kFjbJFbWhWu7iUzslTArSrcitYvHcQ/SdofodN6Br5n+
	 ljED7kTLjm3wVzDjgYzTJxp9n+3zMctqW34lecZpu+Un5mjFr1ltwfUzPf9tGMBTGn
	 +ry+YFEfI5jMzinlOFETGLxdaNmh11pUsndmqd25RdLF+kAXfqw7+p1D+Gy+YvOAUC
	 V/o2QrK9UR0Bf6yZ7IiKFb7V2g3OMi/OW3UE1wfaMaYxYgOHcFmus5x9KWss6r7h5w
	 PQXENhSMnwK2ipA8zTv2zCNjEHNojaXuk5+qSSB1+U5sBU3nZn0x2YY38+xKMtOaQ7
	 eCmsFei4lEuVcQsm+bYvahNQ8u1AtDtqALfxQVjZqDjfIdt3uRcOfRs/n/5WY1TWgy
	 8+2+0Zdhut9MwmTN3J2tF83pXFcWqnEvorHDq65P/jhpE/jL/DS/aGmqwpvVPhRAxO
	 HnK8p8efa+CCA9wZobhLQzclAUfXLlZLXEJ8heZ/BYJH8zLhEOUftuje9qe3gE8WVo
	 k2cXnXELjMXstT6vGgu3D+Sdp/lfekR3ikJ2TyCd/x+DggnIIbpxfvSaEFRaTDay90
	 WMp6yGxy+amIUJF+yn7zxRh0=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 11F1B40E0140;
	Thu, 19 Nov 2026 00:56:12 +0000 (UTC)
Date: Wed, 18 Nov 2026 16:56:09 -0800
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
Message-ID: <20261119005609.GDav5JKc8mhIet5j_a@fat_crate.local>
References: <20261106004343.457087-2-blum@kernel.org>
 <av3v7KY64vjxDCk1@kernel.org>
 <be480966-3b68-44f5-9afa-f88b3c203092@intel.com>
 <av4bS1QEZpniwlb3@kernel.org>
 <20261118222141.GBav4k9eZ5-QMjOem4@fat_crate.local>
 <av5DE5hlpItQzD8m@kernel.org>
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
In-Reply-To: <av5DE5hlpItQzD8m@kernel.org>

On Thu, Nov 19, 2026 at 01:30:11AM +0100, Thorsten Blum wrote:
> My intention was to get this patch into linux-next for broader testing,
> not to bypass the maintainers. Apologies if it came across that way.

How about all those other things I asked? Any thoughts on them or does
everything remain business-as-usual - you keep hammering us with patches and
nothing really changes?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
