Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A2D18A6CF;
	Sat,  8 Aug 2026 08:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786177013; cv=none; b=YcQb9GFPV/cdhK9OvqumePozCcO1ZXnZ8PyKSaMXADLdoNDSFe+7wybcWyhZ7G51TzbKhh1Cqg+01Mp1pI6ZysDatyRdSNpNktZ9hSGMF16WYU5DMrrZesJu3RLbJeoY2VkJgNB5VnDkT/GHoIhfmIMjHbO0k5N/Pp6NxQZqnr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786177013; c=relaxed/simple;
	bh=p9kPq5CdDiEfes4ZCJEd5qRdu3FhJdJ3v66HITtK//I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EylxSf/DrGQju3Djn1gNS0W1LVMjfJ3yOKVJFxfkZUYclz+aiHsf3k6SbMJezu8VK7e6pdnND1QZlqnf78jR8PYX0mDLFgo62OP/xUMjqU+wnvsnwwd0TOJICx1Wmk3xNp7jXaZS0+I5ilHVNDNxGA3+T6kKLTlv++JpTvWHhiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 4A67C1A02;
	Sat, 08 Aug 2026 10:16:42 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3257360A8A5F; Sat,  8 Aug 2026 10:16:42 +0200 (CEST)
Date: Sat, 8 Aug 2026 10:16:42 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Derek John Clark <derekjohn.clark@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pci: quirks: Disable native PCIe hotplug on MSI Claw
 A8 root bridge
Message-ID: <anbl6j9DWiyVQLqS@wunner.de>
References: <20260806214808.1202819-1-derekjohn.clark@gmail.com>
 <anWdGzfD7HxglsOB@wunner.de>
 <CAFqHKTm_dHnSP-ceJhbsm3Zsiif+vxM-xqK27b4eXQGQo1Y7Eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqHKTm_dHnSP-ceJhbsm3Zsiif+vxM-xqK27b4eXQGQo1Y7Eg@mail.gmail.com>

On Fri, Aug 07, 2026 at 05:31:04PM -0700, Derek John Clark wrote:
> [   25.686128] rtsx_pci 0000:c2:00.0: pciehp: pdev subsystem vendor ID mismatch
[...]
> reg=0x525a10ec expected=0x14af1462

The subsystem vendor ID was 0x1462 (MSI) when the card reader was
enumerated on boot and it is 0x10ec (Realtek) on resume.

Likewise the subystem device ID was 0x14af on boot, 0x525a on resume.

It's another bug in the MSI BIOS (in addition to marking the Root Port
hotplug-capable):  The BIOS neglected to re-initialize the subsystem
vendor/device ID registers in config space on resume to the same
values that it set on boot.  The card reader was likely reset while
going through the system sleep transition and its config space
thus needs to be re-initialized.

What happens is that pciehp marks the card reader disconnected
because it assumes that it was replaced during system sleep.
It then synthesizes a Presence Detect Changed event:

https://elixir.bootlin.com/linux/v7.2-rc6/source/drivers/pci/hotplug/pciehp_core.c#L300

So the pciehp interrupt thread pciehp_ist() will remove the
rtsx_pci driver and de-enumerate the device.

Replacing or removing PCIe devices during system sleep happens
all the time (e.g. with Thunderbolt) and we haven't seen issues
with regards to that.  The likelihood is higher that the lockup
is caused by rtsx_pci.

Maybe rtsx_pci_remove() blocks somewhere and prevents forward
progress of the resume transition.  In particular, it calls
pm_runtime_get_sync() and cancel_delayed_work_sync(), which are
blocking calls, i.e. they wait for something else to happen.
You could try commenting those calls out and see if it avoids
the lockup:

https://elixir.bootlin.com/linux/v7.2-rc6/source/drivers/misc/cardreader/rtsx_pcr.c#L1608

Another possibility is a crash due to a NULL pointer deref or
GPF somewhere in that driver.  This is pretty difficult to debug
if there's no possibility to see any dmesg output.

Even if we manage to find the root cause of the lockup, as long as
the BIOS isn't fixed, the card reader will always be de-enumerated
and re-enumerated on resume and consequently the card will briefly
disappear.  This will make it impossible to use the card as root
filesystem.

> I've been using a SanDisk Ultra 32GB microSDHC UHS-I Card. And yes, it
> only happens when the card is present.

If you go to sleep and resume without SD card, do you then see in dmesg
that the card reader was de-enumerated and re-enumerated?  Normally
there should be at least a "Card not present" / "Card present" message
from pciehp, if it sensed a replaced device.  ("Card" refers to PCIe card,
not SD card.)

Also, what's the subsystem vendor/device ID as seen with lspci after
a successful system sleep transition (successful = without SD card)?

Thanks,

Lukas
