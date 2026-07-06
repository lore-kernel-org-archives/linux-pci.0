Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478F741F7E5;
	Mon,  6 Jul 2026 09:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330893; cv=none; b=n9Cvi5RfptBANtp1d3qbKBePj5AhuqVctneEvx1PZgu4AbjXpaRVANEtmrP2pZwBPVZLE3UqnUZ+TgbFoyAr+KiHS16J4WqWR3qMGSDSjlt9hRoGJ3S6VhIoBc0ekGQOrZgKlXqLk4nisvqaxyZ/ModV7k0fZDOtFw4zm7ZArrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330893; c=relaxed/simple;
	bh=h34R6Lcwv4p/OZOtfrFH2N0tXGTaAUvCHzqULjc+DtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyMeUyOtSOM64QLWDqy0L7Pu5aIpzi41QOFLycPcBvJf4pFtf3ZHCBf8JUiOQRhgn5YKNUxPrRGO1MSBO1JzOhLSXqWpNYhw5GcOcWiYknYaukrjQcLDSJaMiL2G07Iu7iSWkTrMnMhiDLjaIlnPWSlhgXjnmzeuCMv+i7DXZd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id EAD59221B;
	Mon, 06 Jul 2026 11:41:19 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D5305600EA59; Mon,  6 Jul 2026 11:41:19 +0200 (CEST)
Date: Mon, 6 Jul 2026 11:41:19 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Max Lee <max.lee@canonical.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, acelan.kao@canonical.com,
	mani@kernel.org, helgaas@kernel.org, kaihengf@nvidia.com,
	victorshihgli@gmail.com, pandoh@google.com
Subject: Re: [PATCH v3] PCI: Disable ASPM L0s for Realtek RTS525A
Message-ID: <akt4P2C8vAHJzePv@wunner.de>
References: <20260610024723.188514-1-max.lee@canonical.com>
 <20260706025358.516607-1-max.lee@canonical.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706025358.516607-1-max.lee@canonical.com>

On Mon, Jul 06, 2026 at 10:53:58AM +0800, Max Lee wrote:
> The Realtek RTS525A PCIe card reader reports an AER Correctable Replay
> Timer Timeout storm when ASPM L0s is enabled on its link.  On an affected
> HP ZBook Power 16 inch G11, the Root Port received tens of millions of
> AER interrupts from the RTS525A even when the rtsx_pci driver was
> blacklisted and the endpoint was not enabled by a driver.
> 
> Testing with OS-native AER control showed that disabling only L0s on the
> RTS525A link stops new AER interrupt and counter growth while leaving L1
> enabled.  Disabling L1, L1 substates, or Clock PM alone did not stop the
> storm.
> 
> Prevent the broken L0s configuration by removing L0s from the RTS525A
> advertised ASPM capability.  This avoids enabling the non-working ASPM
> state instead of masking the resulting AER Replay Timer Timeout reports.
> 
> Signed-off-by: Max Lee <max.lee@canonical.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org

Thanks for your great analysis in:

https://lore.kernel.org/r/CA+YcyLw0HpR1Dnz-mOL1Ryym89ytc=1a_Ri9buMt3at-9mib+g@mail.gmail.com/

In fact a quick Google search finds other reports of ASPM issues with
this card reader.  This one is for Linux and talks about Receiver Errors
with RTS525A which are fixed by pcie_aspm=off, a more targeted fix was
apparently not developed:

https://github.com/pop-os/pop/issues/3775

And another one for macOS specifically mentioning non-working L0s on
RTS525A:

https://github.com/5T33Z0/OC-Little-Translated/blob/main/Content/04_Fixing_Sleep_and_Wake_Issues/Setting_ASPM_Operating_Mode/README.md

It looks like this product just doesn't support L0s and the vendor
neglected to set the ASPM Support bits in the Link Capabilities Register
correctly.

Thanks,

Lukas
