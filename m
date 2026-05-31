Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D767633B6C9
	for <linux-pci@vger.kernel.org>; Sun, 31 May 2026 20:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780260535; cv=none; b=sBILNkfAnL04mSYbZizPHULGmnBTU0qiBJJz9rqtUZnsfQxrlMOiyR2XI1l0wAuJQ3rGOC6OtlWRq8pMY8ulFdVKBFYyOA4wPgCHTy882pCr24NrxyUg4DyLD2QsJnvEs8ZheUBYKmdHMSk4Ck89iZ01/0L0Wn0sESVPKejnVB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780260535; c=relaxed/simple;
	bh=A/3Ndw/QNFZQki1U23VUVmD30t5e7rQNDVkmvPlwrHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLhga0bC81vjCCFa7zEzAGIVAejflHr0/MkT8fi05ZR16vHKv4MtS2Mxlo71YZFx9W1gA2TylBlekol9P9WU24aL/a1qXzE/CDIngkLEqwFrP0fcxEunmAp3nwIaFJr2t0oJ8N4SPCsvgnJNJHfhY0b2+TEvCZC7j/NrLX6TohU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 91D1DC07;
	Sun, 31 May 2026 22:48:44 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4E93E601807C; Sun, 31 May 2026 22:48:44 +0200 (CEST)
Date: Sun, 31 May 2026 22:48:44 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Filippe Duke <fduke@greennet.ua>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"superm1@kernel.org" <superm1@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"tiwai@suse.com" <tiwai@suse.com>
Subject: Re: [REGRESSION][BISECTED] HDA controller MMIO unreadable on Intel
 5-series PCH (Ibex Peak) since v6.16
Message-ID: <ahyerEqlBdIbQN9u@wunner.de>
References: <5e54aea4a97f1cbbe866d9d8f3f25f9f2958e1c9.camel@greennet.ua>
 <cf379972-6b2d-42e5-9660-32d031516862@kernel.org>
 <e05ab19cf41224661325a8acb5f10d31a1d8fbf0.camel@greennet.ua>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e05ab19cf41224661325a8acb5f10d31a1d8fbf0.camel@greennet.ua>

On Sun, May 31, 2026 at 07:49:59PM +0000, Filippe Duke wrote:
> 00:1b.0 Audio device: Intel Corporation 5 Series/3400 Series Chipset High Definition Audio (rev 05) (prog-if 00 [HDA compatible])
> 	Subsystem: Acer Incorporated [ALI] Device 0357
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupts: pin B disabled, MSI(X) routed to IRQ 34
> 	Region 0: Memory at cc100000 (64-bit, non-prefetchable) [size=16K]
> 	Capabilities: [50] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
> 		Address: 0000000000000000  Data: 0000

MSI is enabled but address is zeroed.  Please provide "sudo lspci -vvv"
output of a working kernel so that we can see whether there's no MSI
address configured there either.

Thanks,

Lukas
