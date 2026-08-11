Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D9935C69C;
	Tue, 11 Aug 2026 05:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786425566; cv=none; b=lfaElOTB14Op4S7lSyVx3j/enMSLfpA/4fZTEPk9dlABzE2e5zwjiC/wHrCNikhSY70wDvx3funT/L5lAb7Fiae5yqlCKFVMqGGwIgQxuChKv+0O3rXMYqKfNq2r6WcNsvEYDFv1/wRwe3vPSGyMttPC4/3FQR/gRw+ZV+uSqvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786425566; c=relaxed/simple;
	bh=TuxC9jgWBfX3E+O5//1PSBSJK3WACnZSyv8ZyI8Lg84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dV7tQeoXg4k1nVNnXO6iPJChYxEZcNpTn3Pddp2GVIWajDZL8mLqCHHHaG4WrCyyv44lasbqHyAqwskE/2/5wqFvQg14JUsKWWi2+vcXf8TLgR8kXBs80n/6kDhhoHwjAFV6thhSMYofV+tTViKR6EahgUNYvknl8HBvHQhiIWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 32FEFC34;
	Tue, 11 Aug 2026 07:19:13 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 02724607CEA7; Tue, 11 Aug 2026 07:19:12 +0200 (CEST)
Date: Tue, 11 Aug 2026 07:19:12 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Derek John Clark <derekjohn.clark@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pci: quirks: Disable native PCIe hotplug on MSI Claw
 A8 root bridge
Message-ID: <anqw0M6cQLEA0J6d@wunner.de>
References: <20260806214808.1202819-1-derekjohn.clark@gmail.com>
 <anWdGzfD7HxglsOB@wunner.de>
 <CAFqHKTm_dHnSP-ceJhbsm3Zsiif+vxM-xqK27b4eXQGQo1Y7Eg@mail.gmail.com>
 <anbl6j9DWiyVQLqS@wunner.de>
 <CAFqHKT=ZzWRdnNCixY5BeLsVE2JUhfmPSNnpw5TFjzu76AocrA@mail.gmail.com>
 <angci4oGyGFtvbSQ@wunner.de>
 <CAFqHKTkTYtu7U39W7epZptPWBBC0fQyfA-5mOBTi4RTA1Bb1WA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqHKTkTYtu7U39W7epZptPWBBC0fQyfA-5mOBTi4RTA1Bb1WA@mail.gmail.com>

On Mon, Aug 10, 2026 at 01:57:58PM -0700, Derek John Clark wrote:
> I was able to drill down further. When the mmc device gets to
> blk_report_disk_dead() in block/genhd.c there is an xa_for_each loop.
> On the second loop of that it seems to hang in bdev_mark_dead(). That
> sets a callback that runs fs_bdev_mark_dead() which then runs
> sync_filesystem(). This is all hit because the "surprise" bool is set
> to false unconditionally in __del_gendisk().
> 
> Commenting out this from __del_gendisk():
> if (!test_bit(GD_DEAD, &disk->state))
>  blk_report_disk_dead(disk, false);
> 
> Avoids the hang.

Thank you so much, you've root-caused the issue:  We're missing a call
to blk_mark_disk_dead() at the top of rtsx_pci_sdmmc_drv_remove()
if the underlying pci_dev is marked disconnected.  Let me get back
to you with a fix in a bit.

> I'm not sure how much further we want to go down into this as we've
> moved quite far out of the driver space and are now well into the
> block subsystem. I'm working on a proof of concept that would allow
> the driver to inform the mmc core that this was a surprise, but I'm
> not sure how that would land. From what I've read the mmc core was
> intentionally detached from higher level drivers, though a few
> notification methods do exist. If I get that fully working I'll post
> it here but it will probably be a few days as I've run into some other
> obligations this week.

It's fine, you don't need to invest any more time into that and
I understand your frustration about how much effort is necessary
to fix this.

The issue you've found affects anyone removing e.g. a Thunderbolt-
attached dock with an MMC card reader during system sleep.  So it's
useful and important to have root-caused and fix that.  Unfortunately
kernel development often means getting sidetracked like this.

> I suppose that is true, but in that case we still wouldn't be able to
> use it as the root fs since it gets removed/re-added during a suspend.
> Would the quirk I submitted not have this compromise?

Okay I wasn't sure that using the MMC card as root filesystem
is even possible on this product.  If that's a potential use case,
it needs a separate fix.  I'll come up with a proposal for that one
as well.

Thanks,

Lukas
