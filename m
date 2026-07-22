Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3804E33D6F0
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 08:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784709373; cv=none; b=S9XIzJpajl5EjfBLPL5oPynMbkJjU0KFqliW2fNSTUjui/KLGFgHO8ivKHbahCAsAoHTcjC96XvAaedXzKfylnxSn+i3tFhjV+K1H1DVtoCBYZmAzIb0sr+e7AJezq3owuyofsMQ7zG2dryXaQGMywGXRy6bIjlGsTSEVT/dr1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784709373; c=relaxed/simple;
	bh=tJuscl5Wu1lJYY9r7necCGnAmuSJ+Tr2wp/DYkDlrRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9xECZTn44ywGHfPO8C6D6ooBeUfbzxC3AHOdHIwDKt8SvA0+ZtUWPjeQ7nWxvb56cnbC7Znw/jeJlut7ebuEJMKLfFfR63Z/aThzPgvMnjdHitH7uNYYLh6nI1yuBKr3MrI00JiT9GnqI5UD3m3yThwanrUnLGLy6SUM6/LxCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 05769C1A;
	Wed, 22 Jul 2026 10:36:01 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B9E4962749F5; Wed, 22 Jul 2026 10:36:00 +0200 (CEST)
Date: Wed, 22 Jul 2026 10:36:00 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Jozef Matejcik (Nokia)" <jozef.matejcik@nokia.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Peter Sys (Nokia)" <peter.sys@nokia.com>
Subject: Re: PCI driver - hotplug of multiple devices
Message-ID: <amCA8AHMNorjWDli@wunner.de>
References: <AS4PR07MB85083609845930FF12F5C79593C12@AS4PR07MB8508.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS4PR07MB85083609845930FF12F5C79593C12@AS4PR07MB8508.eurprd07.prod.outlook.com>

On Wed, Jul 22, 2026 at 07:12:24AM +0000, Jozef Matejcik (Nokia) wrote:
> The driver is Broadcom's linux-kernel-bde.

This seems to be an out-of-tree driver, i.e. not something that is
part of the mainline kernel.  The upstream community can only provide
very limited support for such drivers.  The vendor needs to upstream
the driver into the mainline kernel, otherwise there's only so much
we can do.

> The issue:
>  - kernel module is inserted
>  - we de-assert reset of these PCI devices (previously in reset, i.e.
>    effectively powered down)
>  - sometimes, very infrequently, the box freezes for 1-3 minutes and
>    the HW triggers reboot

We'd need logs to say anything about it.

> When we removed the module before de-asserting the resets and then
> inserted it later, the issue did not occur. So we suspect that the
> kernel driver is accessing the device during probe too early and
> this is causing HW freeze.

Or maybe the reset puts the device in a state which is unexpected by
the driver.

> Are PCI drivers expected to handle hotplug events of any number of
> their devices simultaneously?

Yes.  E.g. a global data structure in the driver needs to be properly
locked if accessed concurrently by the probe function for separate
devices.

> Can the issue I described above be considered a bug in vendor's
> implementation?

Sounds like it.  Usually out-of-tree drivers haven't gone through
the rigorous review process by the community and quality may thus
be subpar.  The recommendation is to ask vendors whether driver
support is in mainline already when selecting components for your
products.

Thanks,

Lukas
