Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B0C2877F6
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 04:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778128022; cv=none; b=igeY3JEG6L9t/n2WDe5pm6RaXdYb7ASbKE404kt3BcNC4q26JncgBeAUDK4lRr5R8v3NIeScYo3TYItpj8MjNr9qroQEGojn8R6ujZSu6uwlWJGUNkvHTxav3/bcplYg5kGAUL/pEuBiov99X0gBQhUyoSSaeyhDYshff7yFPNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778128022; c=relaxed/simple;
	bh=6ewJc/uusRRO/VtAEty4Pm1J+/yRwUII0I8++sZii10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xj66GDyA40zOCsErAAz8YPovsHE7l8N7jH3LlIewViyBuH1QC5+VjIO+CxMG1YjgRMr1OlSpQL4dlmRviTAFLK1NDg6pjklr1gHmx87f7crtB/RNRetA5kqjW1C+BQSzLzV4hm5DCGFW3O7+0ve7Tjnmc5xyTp9nEAgPi5sBZp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id EDD1EC23;
	Thu, 07 May 2026 06:26:56 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B916C6024CB5; Thu,  7 May 2026 06:26:56 +0200 (CEST)
Date: Thu, 7 May 2026 06:26:56 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: bhelgaas@google.com, "Mario Limonciello (AMD)" <superm1@kernel.org>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Disable link and turn off slot power while
 removing
Message-ID: <afwUkP1P-HNfMulV@wunner.de>
References: <20260506164353.1278571-1-mario.limonciello@amd.com>
 <afuAjeWepSkzO12O@wunner.de>
 <9cfc10f8-de54-4af9-8436-35ebeef4faf6@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cfc10f8-de54-4af9-8436-35ebeef4faf6@amd.com>

On Wed, May 06, 2026 at 02:16:10PM -0500, Mario Limonciello wrote:
> On 5/6/26 12:55, Lukas Wunner wrote:
> > Moreover there are products where Presence Detect is hardwired to zero,
> > see commit 80696f991424 ("PCI: pciehp: Tolerate Presence Detect hardwired
> > to zero").  So we have to rely on a link change to detect that a new device
> > has been plugged in after slot poweroff.  That won't work if the link is
> > disabled.
> 
> How would you feel about turning off link detect somewhere specific to the
> shutdown path?

I *think* shutdown is performed bottom-up in the hierarchy and so
this might work.  But it's not great to introduce such a change
for everyone just because a single product needs it.  It would
be better to root-cause the issue.  Maybe the vendor is able to
provide a BIOS update which resolves it?

Thanks,

Lukas
