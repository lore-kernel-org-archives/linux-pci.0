Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9184DAFB5
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 19:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791832681; cv=none; b=foW1eHcOB249Zs6bvSZwx61daIln0ibfjtUivKxgZHRDL19czUWOqEjCwyJP5ZPOfzUO9gS5d9DA37+eknHICKfO66io1be5pSL80g32jbC9OjBEYG1kWtc1tAnQslmkAskLitQ6/ivk6P/w7mN2rpiucBQWPBqZEDEJBzgiWHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791832681; c=relaxed/simple;
	bh=K4id5UADxuIm+cZfX/9TDt96uKy8AK07St9j6L3NBCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Thi2ZUE/HiCg5IQaz5o54EDRHbk9SPaWLBmIugx36AGo/gsnKU744W4Ixu27Swak4JkJrWhD1aR7aBl8KhMSoPGhxPjmezeULMg4BpZv2piUvQIqhgZm2UpZTWl1SYvSo/GaPfSGpio5BZx/z8W3j5+OqNr+mIw6Zf7aNE2wsDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 9854285EA;
	Mon, 12 Oct 2026 21:17:49 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7611860000B7; Mon, 12 Oct 2026 21:17:49 +0200 (CEST)
Date: Mon, 12 Oct 2026 21:17:49 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Alex Deucher <alexdeucher@gmail.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	amd-gfx@lists.freedesktop.org, Aditya Garg <aditya.garg@linux.dev>,
	Jason Perlow <jperlow@gmail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH for-linus] PCI/AER: Skip error recovery on false alarms
Message-ID: <as0yXccnanni6KZe@wunner.de>
References: <ash0Rn78gwlQ87Fg@wunner.de>
 <20261009150724.GA974326@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009150724.GA974326@bhelgaas>

On Fri, Oct 09, 2026 at 10:07:24AM -0500, Bjorn Helgaas wrote:
> On Fri, Oct 09, 2026 at 06:57:42AM +0200, Lukas Wunner wrote:
> > Apple products with a T2 Secure Enclave will require a separate patch
> > which avoids enabling Advisory Non-Fatal Errors on this particular device.
> > A quirk, in other words.
> > 
> > I think the firmware on the T2 is upgradable in principle, but Apple isn't
> > going to do us the favor to fix it.  So we don't have any other option
> > than keeping a blacklist for ANFE-incompatible devices, with the T2 being
> > the first device on that blacklist and maybe others to follow.
> 
> OK, it sounds like two separate issues needing two separate patches to
> fix.  So I think I'll ask Linus to pull this fix today and watch for
> the quirk next week.

In case it's not obvious, the quirk necessary for the Apple T2
was submitted by Aditya here:

https://lore.kernel.org/r/20261010172301.12764-1-aditya.garg@linux.dev/

Also, Jason attached a functionally identical patch to this e-mail:

https://lore.kernel.org/r/CABZrw2H+3yt2Y7xiq6OyAWaJM7P9ox-2nJxoQuJMwoJHLgi+YQ@mail.gmail.com/

Either patch is a viable fix for this problem.

Thanks,

Lukas
