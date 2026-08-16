Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693C83C454F;
	Sun, 16 Aug 2026 05:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786857927; cv=none; b=B9XVBQorRO3M/yoHHcpYyoyEWaH5u7ooOQ7YCo4toVFDZDLJkiHObQMagWLyMbIaQUxr2VRyDHZ8K8cnrFTVrlgComGPEUp53+zPQrsTqksTFGj0Fa0lwnMsCiZb9Xvb2b/Bq1qIXfEwNmfa6aMOzUxQrd3J/VMZptVqVCyDkfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786857927; c=relaxed/simple;
	bh=j9v8cWd6Ca+sA0loWq6hOvOAxZAWWcLUMF4SBGCvOoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ss+QwlFlHaT1vIfsRL1uC6SM+Rm8lprt2lQH5nqkAsrhWE7GH/SkkOi96ccg6uTLI8w/OrV5fLNSrtCQVpD4Pr0iWi4+vqeutVbiiHk4ZFMJs128TfJFNdxNaq6DFIsPLEO3lr0jE1mIUvt+SpBzHCKaBx3K3uIjpW+TzuCdYkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 39F5CC2A;
	Sun, 16 Aug 2026 07:25:23 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 02111629CE22; Sun, 16 Aug 2026 07:25:22 +0200 (CEST)
Date: Sun, 16 Aug 2026 07:25:22 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@hobbes.lan>,
	Ingo Molnar <mingo@elte.hu>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/early-quirks: Scan all functions in
 early_pci_scan_bus()
Message-ID: <aoFJwldO-_qttr0P@wunner.de>
References: <20260807094601.263450-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807094601.263450-2-thorsten.blum@linux.dev>

On Fri, Aug 07, 2026 at 11:46:02AM +0200, Thorsten Blum wrote:
> early_pci_scan_bus() stops scanning a PCI slot when check_dev_quirk()
> returns nonzero, which avoids probing functions 1-7 on single-function
> devices, but also stops scanning when a function is absent on a
> multifunction device.
> 
> This can skip early quirks on multifunction devices with holes in their
> function numbering.
> 
> Check function 0 first, and if it indicates a multifunction device, scan
> functions 1-7 independently so that absent functions do not cause later
> ones to be skipped.

Which device do you need this for?  We should only scan additional
Functions if a quirk needs to applied to them because this extends
boot time.  It requires a justification and shouldn't be done "just
because".

Thanks,

Lukas
