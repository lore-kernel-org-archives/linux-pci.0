Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ECA36EA94;
	Sun,  5 Apr 2026 08:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775379564; cv=none; b=BnXX3xGb7vtJiPlnpZdYoqDc2R1HUmVJ3S9ZDz23mAYaUmBJgpYjXI0nv3yofhRgO15fxgGpgPYHzmzRAjzwJP8pP1W4Lcku9w+chFLSdabMNnX3WSDnYZQiBpN1rfkFtoweZIpKjGyMc8Q6U+A8/5jRugEsWLuo2XBdHokeeG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775379564; c=relaxed/simple;
	bh=jfQMt0UKF+Ud0FMYQqhhLxfaFeSqAEtzw/kuxU5jpSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZhiJErpEzUQD7Z3nPoUdJ/vURD/Diabu6cKb37IS0e7JKfMO1CxFEL+Fpj/rbnSlZkIwOkikb0xsTlW9w22dSgv46Kykh98h8W6mmDVZKXF0oaowSDHadwR9ogjmASJQ9hiUD/Vq9//Skdm0eGP6zAUt6TEXVXy2o0jrHlYwWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id E8B9B10609;
	Sun, 05 Apr 2026 10:59:20 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D878F6029C49; Sun,  5 Apr 2026 10:59:20 +0200 (CEST)
Date: Sun, 5 Apr 2026 10:59:20 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Georg Klima <Georg.Klima@durst-group.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"thunderbolt@lists.linux.dev" <thunderbolt@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"georg_klima@gmx.at" <georg_klima@gmx.at>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Rene Sapiens <rene.sapiens@linux.intel.com>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
Subject: Re: [BUG] Thunderbolt runtime resume during PCIe removal causes IRQ
 warning and shutdown failure.
Message-ID: <adIkaExcG-T5XACV@wunner.de>
References: <AM9PR10MB42316BF3E59B29E1EA3E5600B756A@AM9PR10MB4231.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR10MB42316BF3E59B29E1EA3E5600B756A@AM9PR10MB4231.EURPRD10.PROD.OUTLOOK.COM>

[cc += Mika, Rene, Alan; start of thread is here:
https://lore.kernel.org/all/AM9PR10MB42316BF3E59B29E1EA3E5600B756A@AM9PR10MB4231.EURPRD10.PROD.OUTLOOK.COM/
]

On Thu, Mar 26, 2026 at 04:09:05PM +0000, Georg Klima wrote:
> I am reporting a reproducible shutdown issue involving Thunderbolt,
> PCIe hotplug, and runtime PM on a Lenovo ThinkPad P16.
> System fails to power off cleanly when PCIe ASPM is enabled.
> After the kernel prints "Power off", it emits warnings and does not
> complete shutdown.

The dmesg output shows that the problems start much earlier than
on shutdown:  The discrete "Barlow Ridge" Thunderbolt controller
is hot-removed at the 08:44:29 timestamp in a noisy fashion:

> Mar 26 08:44:28 fedora kernel: usb 3-3: reset full-speed USB device number 2 using xhci_hcd
> Mar 26 08:44:29 fedora kernel: pcieport 0000:80:1b.4: Data Link Layer Link Active not set in 100 msec
> Mar 26 08:44:29 fedora kernel: pcieport 0000:80:1b.4: pciehp: Slot(25): Card not present
> Mar 26 08:44:29 fedora kernel: ------------[ cut here ]------------
> Mar 26 08:44:29 fedora kernel: thunderbolt 0000:8a:00.0: interrupt for TX ring 0 is already enabled
> Mar 26 08:44:29 fedora kernel: xhci_hcd 0000:b1:00.0: Controller not ready at resume -19
> Mar 26 08:44:29 fedora kernel: xhci_hcd 0000:b1:00.0: PCI post-resume error -19!
> Mar 26 08:44:29 fedora kernel: xhci_hcd 0000:b1:00.0: HC died; cleaning up
> Mar 26 08:44:29 fedora kernel: WARNING: drivers/thunderbolt/nhi.c:147 at ring_interrupt_active+0x246/0x2f0 [thunderbolt], CPU#3: kworker/u96:5/1092

The controller is then re-discovered after the link goes back up.
The actual shutdown doesn't seem to start until the 08:45:26 timestamp.

Going forward please use "dmesg" to collect kernel output, not journalctl,
so that we get timestamps with usec granularity.

>   *   Hardware: Lenovo ThinkPad P16 (21RQ003BGE)
>   *   BIOS: N4FET30W (1.11) 10/03/2025
>   *   Kernel: 6.19.10-200.fc43.x86_64
>   *   Distribution: Fedora 43
>   *   Platform: Intel (Meteor Lake)
>   *   Thunderbolt controller: 0000:8a:00.0

It looks like this isn't Meteor Lake but Arrow Lake-S:

0000:80:1b.4 - Arrow Lake-S (800 Series) PCH Root Port #21
  0000:88:00.0 - Barlow Ridge Upstream Port
    0000:89:00.0 - Barlow Ridge Downstream Port to NHI
      0000:8a:00.0 - Barlow Ridge NHI

The Specification Update for this PCH doesn't list anything
ASPM-related so far:

https://cdrdv2-public.intel.com/832375/832375-004.pdf

But perhaps the issue lies with the Barlow Ridge controller?
In any case this looks like something that Intel needs to
try to reproduce internally in the lab to see if there are
ASPM or other compatibility issues between Arrow Lake-S PCH
and Barlow Ridge.

Thanks,

Lukas
