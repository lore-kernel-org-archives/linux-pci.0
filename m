Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F27F378D78
	for <linux-pci@vger.kernel.org>; Thu, 16 Apr 2026 12:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776342935; cv=none; b=H8kwiZFkrPgxaI7ryfFZSwy3vHNMP+kJQlcsvd/YQOwKjMOgJYDw2ODybTcCDbip+iqMAR6+Sk2irtPzjHWMWIUCiPSIYwrvGL1TN+ZpEbtDjGQ6BgeTieLUf8NfYM35Idrs8WzsF1VXUIR9wbZwu9KW60wcBGBQT3OL2QIod3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776342935; c=relaxed/simple;
	bh=heBzkJdeIOXNs6nZLdou7dU2vW2e3qd4H+2Fnrh4KhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSZaFRqDKDBrR6brsVOJXurm2Jm4eqkj2KQLyfu9IUldf1SQO4dbaQ3QZwcqo5slNSAlgndQkHNFE9zy3nudYz48K0GrBjXmMg7sZPepYs1tNuW1gGDPRAHPX0INDBa+B7KXeYk+hQe4OndZSGqbLpjKADhiguCjUcpRpMP3yZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id E265235C;
	Thu, 16 Apr 2026 14:35:30 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C30C86010C9B; Thu, 16 Apr 2026 14:35:30 +0200 (CEST)
Date: Thu, 16 Apr 2026 14:35:30 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bernd Schumacher <bernd@bschu.de>,
	"Alexandre N." <an.tech@mailo.com>,
	Salvatore Bonaccorso <carnil@debian.org>, 1131025@bugs.debian.org,
	Uwe Kleine-Koenig <ukleinek@debian.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Williamson <alex@shazbot.org>, regressions@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Update saved_config_space upon resource assignment
Message-ID: <aeDXktnNLEtmYsbh@wunner.de>
References: <febc3f354e0c1f5a9f5b3ee9ffddaa44caccf651.1776268054.git.lukas@wunner.de>
 <fa331b71-133c-3773-3ec9-1aecc807fd9b@linux.intel.com>
 <aeDH4XNvwcX7RI0m@wunner.de>
 <9fcb46ff-56d2-1504-11a1-ad8449c80b2d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9fcb46ff-56d2-1504-11a1-ad8449c80b2d@linux.intel.com>

On Thu, Apr 16, 2026 at 03:16:08PM +0300, Ilpo Järvinen wrote:
> On Thu, 16 Apr 2026, Lukas Wunner wrote:
> > IOV registers are not saved, they're reconstructed from
> > pci_dev->resource[]:
[...]
> > Bridge windows are saved when portdrv probes (see call to pci_save_state()
> > in pcie_portdrv_probe()) and that happens after the fs_initcall() because
> > portdrv is registered from a device_initcall().  So those should be fine
> > as well.
> 
> It feels a bit odd they're all handled differently (not a problem when it 
> comes to this patch). Maybe it would make sense to eventually restore them 
> all from the pci_dev's resource array. Add something like 
> pci_restore_resources() that would restore all the resources that are 
> relevant for the type. 
> 
> I don't know if that's doable when it comes to the order of things, 
> especially with sriov, but if doable, it would prevent them ever getting 
> out of sync again and would avoid the trouble of having to save them 
> elsewhere.

I did consider restoring standard BARs from pci_dev->resource[],
but the calculations and iterations involved looked expensive to me,
compared to the cheap copying from pci_dev->saved_config_space[]
that we currently do.  It didn't look like something that lends itself
well for a fix that needs to be backported.

A different approach that I'm dwelling on is to amend accessors such as
pci_write_config_dword() to update pci_dev->saved_config_space[]
implicitly if the offset in config space is < 64.  And also implicitly
update pci_dev->saved_cap_space[].  The former is easy, the latter isn't.

The end goal would be to remove pci_save_state() everywhere, except to
populate the saved state once on enumeration.  I think originally the
idea was, we go to system sleep, so we save state.  We resume, we restore
state.  But then error handling came along and that means we cannot always
save the state before reset recovery, so ideally we want to save whenever
we write to config space so that cache is never stale.

I'm thinking of having a helper in <linux/pci.h> to determine whether
a register write needs to be saved.  Basically, return true for everything
with offset < 64 and for Control registers in capabilities, return false
for everything else such as Status registers.  By having that in a header, 
the compiler could deduce at compile time whether saving is necessary
or can be skipped.

The problem is that to save registers in capabilities, the hlist needs
to be searched, which is expensive.  Maybe we can speed it up by using
an xarray.  Or cache the offset of all capabilities whose registers are
saved.  We already cache e.g. aer_cap, but other offsets are not cached.
Hmmmm...

Thanks,

Lukas
