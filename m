Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.223.78.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623643;
	b=aM80eYQKP6rvRQUMhJAq5FsR9ZvQvtsGo/liIkd+e/RLzTmimfhSSHBhdMRhm6rIhoL/
	 X1557M8sATD9Om0Tu32m1jCnYdH6PXWGjkt8Ng5xvyicEtvSfrxv7jE0Yldjbg70E/Wkb
	 ZWbHsSssqSE0ts0oneFAeqrXEVCd9jRKdLNPQj5qPKKpfI2B4XFJwQowpd6ZP/F3RnoVp
	 tFf7pzWHS1t7F1hdVIPFVbt3RLrMtgr1EtxjvMQdMKMqpMjQQyhwRrO6Rh75E6LZzf39z
	 Dpsn/7cZRbxO2Rcfyi8GxCoKa5gi6VNE+0vMoutYyhYGdbHy57guCLe8WhsWEd7510g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623643;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=YopVWyX5VhblpHyNu4jnxXTgCb1d9LZknjY531CjpxU=;
	b=fQIJ7U790hPORUlo4OrEKI7AVG12vojz4puJeGxZDhPwaLM8XSDyw1rWbBSDOldgGOOB
	 e8yGOXQY2KITeKaz2p/dR0Uifs7De5tX8Haqdq6ZaVFdaZOj7jkiKHlNH5XN86fAerKss
	 TdUCANNluFbGGkZPd5Kuv761lGPB7ux9v85Qk4flkfuRlhZKb/HWTPhmtEscmYN/hfvEV
	 whNgmcnHYh7gq+snsa1OPDSd8yud/R73XGL4abqyw5V7wxG9WZ1wOPw2PxoSBKptoMHuk
	 UmL2Vi8gmARwyh1EKEN9sQXdMqM5k9N8k0taLoZ8MEqWaJ+wW+sn42YgppBREZ8YrwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=83.223.78.233
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C656606A684;
	Wed, 25 Nov 2026 16:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C656606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 57DDE10DF2;
	Wed, 25 Nov 2026 17:20:40 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 421B0600E3B0; Wed, 25 Nov 2026 17:20:40 +0100 (CET)
Date: Wed, 25 Nov 2026 17:20:40 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Thorsten Blum <blum@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@hobbes.lan>,
	Ingo Molnar <mingo@elte.hu>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Aditya Garg <aditya.garg@linux.dev>,
	Andre Eikmeyer <dev@deq.rocks>,
	Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Subject: Re: [PATCH RESEND v2] x86/early-quirks: Scan all functions in
 early_pci_scan_bus()
Message-ID: <awcK2MvTWjHmkRcl@wunner.de>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awbj4V167BPw0Er-@kernel.org>

[cc += Aditya, Andre, Atharva, start of thread is here:
https://lore.kernel.org/r/20260817090011.26011-3-thorsten.blum@linux.dev
]

On Wed, Nov 25, 2026 at 02:34:25PM +0100, Thorsten Blum wrote:
> And I agree that the patch needs wider testing before it can be
> backported to stable or merged upstream. That's precisely why I'd like
> to see it in tip and linux-next.

There's a fairly active community of kernel hackers trying to improve
support of T2-based Intel Macs.  Perhaps they can help with testing
and reviewing.  I'm adding three of them to cc.

Thanks,

Lukas
