Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC5E3E3C4D;
	Sun, 13 Sep 2026 12:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789302275; cv=none; b=STZD1KSgjUJ8rsEHsV/SAu4MKLrKD9/I8eTuhT8tKP82NSPt+SvfW0sqlaAUi6faXxmd74OABw1ngKuRd+nBKqslckfoBhcEOaEH0W/Rp3x8C5GCuRSIz4XSomvMczZ3dhHzl2gYEhTX6hrDOjsCXh5xC8wImUHWEsFhp7kPz+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789302275; c=relaxed/simple;
	bh=k+RsmAfCfv/FYsBY3zwcwryj7UemjM+L3mT6TXL3EPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WA6h7UnOwMnLyH2uRD9YbBx6oaM6I8n+cSXqWFB0ge52jyUcsI+3cLTyZcldE0e95ebv42Iiyny2btbM0TzgYP/CXFfNifg9UCoUflAuT2nmgiF91TsrAdI3IQP+52WbCR3+7d3Wz/qg7VYxLBLijw7hiMSIm1ar0NGtBjrob8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 87B2410DC4;
	Sun, 13 Sep 2026 14:24:21 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 54B8061BE888; Sun, 13 Sep 2026 14:24:21 +0200 (CEST)
Date: Sun, 13 Sep 2026 14:24:21 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Hongbo Yao <andy.xu@hj-micro.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, peter.du@hj-micro.com,
	jemma.zhang@hj-micro.com, rick.yan@hj-micro.com
Subject: Re: [RFC PATCH] PCI: pciehp: Allow more time for link activation
 after slot power-on
Message-ID: <aqaV9TeD6iw-bY4w@wunner.de>
References: <20260910015151.1876630-1-andy.xu@hj-micro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910015151.1876630-1-andy.xu@hj-micro.com>

On Thu, Sep 10, 2026 at 09:51:51AM +0800, Hongbo Yao wrote:
> The OCP NIC 3.0 Specification, version 1.6.0, Figure 132 [1], requires
> an interval greater than one second between Main Power Valid and PERST#
> deassertion.  The diagram labels this interval T_PVPERL.  PCIe link
> activation requires additional time after PERST# is deasserted.

The 1 sec delay implemented by:

  board_added()
    pciehp_power_on_slot()          # turn on the power
    pciehp_check_link_status()
      pcie_wait_for_link()
        pcie_wait_for_link_delay()  # wait 1 sec for DLLLA,
				    # then wait another 100 msec

... is specified by PCIe r7.0 sec 6.7.3.3, which is referenced by
sec 6.7.1.8 ("Power Controller").

In particular, sec 6.7.3.3 says:

 "The Data Link Layer State Changed event must occur within 1 second
  of the event that initiates the hot-insertion. If a power controller
  is supported, the time out interval is measured from when software
  initiated a write to the Slot Control register to turn on the power.
  [...] Software is allowed to time out on a hot add operation if the
  Data Link Layer State Changed event does not occur within 1 second."

So I think the delays observed by pciehp are conforming to the spec.

The PCIe CEM Spec r6.0.1 sec 2.11.2 specifies Tpvperl as "min 100 ms".

I don't know why the OCP NIC Spec says "> 1s" instead, but that number
isn't what the PCIe CEM Spec says and that's the authoritative document.

So I'm inclined to say the number in the OCP NIC Spec is wrong and
needs to be fixed.

> This is observed with an OCP ConnectX-7 (MT2910 family) adapter.  On the
> affected platform, power-on to PERST# deassertion takes about 1.2 seconds,
> followed by a few hundred milliseconds for link activation, exceeding
> the existing polling budget.

Which platform are we talking about?  A chassis from HJ Micro?
Has this already been shipped to customers or is it still in
internal validation?  If it's still in validation, please fix
the hardware to shorten the delays in accordance with the PCIe
Base and CEM Spec, ignoring the bogus value in the OCP NIC spec.

If it's already in customers' hands, can you fix this through
a firmware update or something like that?

I'd like to avoid lengthening the delays in pciehp beyond what
the spec prescribes, only to work around non-conforming platforms.

Thanks,

Lukas
