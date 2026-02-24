Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [144.76.133.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DCA187346;
	Tue, 24 Feb 2026 06:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771915244; cv=none; b=or30D4LAHgL+Di3e4dOA9Nutl5tW2CQjPB5cDbVCgy/CEte0vtAmTicdUBNG9ra2OK0XVGtX7yiJCKLjyB9q+T4mpSCLb6gXzwefJ8QcdLzo7wDHuckkaBTAJ6bqLmvHCJmK6GmJzXhPXPBAKTKerhSgByQehq1thSMo1ysSi7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771915244; c=relaxed/simple;
	bh=aW73ehYSG/4D71LBcs7P6ENWNQK+qLc5YhKkES4PI6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbGvQoAgM4eeU/cMBbMnDIRdm8r2H3f8irdScYmD1KaObaxYjFGr1XaWYzkm43jLE6f0V1RgMDMWdI1yCr+1gYhSIMl1PE50hjp675ybiT+CUc/9KPQilCrmYR1jH+6w4Q0lgtA/oxHtMssRy60ikzLhdGoIAT6Ye8tHKmbMV8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=144.76.133.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 4D2652029B57;
	Tue, 24 Feb 2026 07:40:33 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E8C93168D5; Tue, 24 Feb 2026 07:40:32 +0100 (CET)
Date: Tue, 24 Feb 2026 07:40:32 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ziming Du <duziming2@huawei.com>
Cc: bhelgaas@google.com, okaya@kernel.org, keith.busch@intel.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	liuyongqiang13@huawei.com,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] PCI: Fix AB-BA deadlock between aer_isr() and
 device_shutdown()
Message-ID: <aZ1H4IMMW_4w60EH@wunner.de>
References: <20260109095603.1088620-1-duziming2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109095603.1088620-1-duziming2@huawei.com>

On Fri, Jan 09, 2026 at 05:56:03PM +0800, Ziming Du wrote:
> During system shutdown, a deadlock may occur between AER recovery process
> and device shutdown as follows:

The subject is slightly misleading as this isn't an AB-BA deadlock,
which involves two locks.  It's a deadlock involving a single lock
(device_lock), where one task (shutdown) acquires the lock, then
waits for the AER interrupt thread to finish, but that thread is
waiting on the lock.

device_shutdown() acquires the device_lock to avoid invoking a driver's
->shutdown() callback while its ->probe() callback is still running or
while the driver is being removed, cf. d1c6c030fcec.  That seems
reasonable.

It's unclear why pci_bus_reset() needs to acquire device_lock.  This was
introduced by 090a3c5322e9.  I'm adding Alex (the author) to cc.

Another question to ask is whether it makes sense at all to attempt
error recovery when the system is shutting down.  Maybe we should log
the errors, but no longer try to recover from them?

It's possible to determine whether shutdown is in progress by querying
system_state (set by kernel/reboot.c).  However we can't just skip
calling pci_bus_error_reset() in aer_root_reset() if system_state
indicates shutdown because it would still be racy.  The only race-free
solution would be to register a notifier with reboot_notifier_list
which sets a flag that shutdown is in progress and waits for the
interrupt thread to finish.  It's quite a complicated solution just
to work around a deadlock, so I suggest to first look into removal of
device_lock acquisition in pci_bus_reset().

Simply using trylock doesn't seem bullet-proof.

Thanks,

Lukas
