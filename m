Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69273ED5D0
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 17:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778090136; cv=none; b=ovB4+wCXbZQHFo21usjIfd4eDN79ncCqLt6lN0v0vhuDwuw9F6fertBlGcEWfQUCUEQmCUXxbpWWjrlDylMxDPevIfGFteTmyyphxPjHNvdyzSpDS73yvRlDvb73YWLyRKjyLZB9gp0wO8ZrJSO+gMoFoH52L0o/xnYxurQLSrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778090136; c=relaxed/simple;
	bh=y/i+9ekkzA4CkL1WZ2NxQ2XZUK27a+le4xY9dGCIOQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLSmkKUFI0VIVmGAdDBd6uz1N/KeScnTu6+yx48NsxC6FX/HkX6BdfsoYGKTghmUhoEzP3O6RcUhQalsAkkIRuD9pxsXkzgsAvTkbdn0qxe0fqSRDPJlyAGXFpr2oIA9wN0zpJINjpbPGkNO3wT+ML8Hs1Kj4b25jkuGJ+5VZMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 26B4314C5;
	Wed, 06 May 2026 19:55:25 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 22127601C799; Wed,  6 May 2026 19:55:25 +0200 (CEST)
Date: Wed, 6 May 2026 19:55:25 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: bhelgaas@google.com, "Mario Limonciello (AMD)" <superm1@kernel.org>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Disable link and turn off slot power while
 removing
Message-ID: <afuAjeWepSkzO12O@wunner.de>
References: <20260506164353.1278571-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506164353.1278571-1-mario.limonciello@amd.com>

On Wed, May 06, 2026 at 11:43:50AM -0500, Mario Limonciello wrote:
> When a hotplug slot is removed, pciehp still leaves both the slot and link
> active. If a device is still physically connected, platform firmware
> may continue to poll the link. On some systems with Thunderbolt 3 devices
> connected this prevents the system from shutting down until the device is
> disconnected.

"On some systems" is a little vague.  Which ones?  What is platform firmware
doing there exactly, is this something in AML?

> To fix this add code to pciehp_power_off_slot() to reverse the init
> sequence from pciehp_power_on_slot() (power on, then enable link becomes
> disable link, then power off).

Unfortunately it's not as easy as that.  You're essentially reverting
commit b1811d2455f3 ("PCI: pciehp: Don't disable the link permanently
during removal"), so you'll regress those products for which the commit
deliberately removed link disablement on slot poweroff.

Moreover there are products where Presence Detect is hardwired to zero,
see commit 80696f991424 ("PCI: pciehp: Tolerate Presence Detect hardwired
to zero").  So we have to rely on a link change to detect that a new device
has been plugged in after slot poweroff.  That won't work if the link is
disabled.

Thanks,

Lukas
