Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50217 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753224AbaG2Ovp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 29 Jul 2014 10:51:45 -0400
Message-ID: <1406645502.1011.166.camel@ul30vt.home>
Subject: Re: pci_sriov_set_totalvfs question
From: Alex Williamson <alex.williamson@redhat.com>
To: Edward Cree <ecree@solarflare.com>
Cc: linux-pci@vger.kernel.org
Date: Tue, 29 Jul 2014 08:51:42 -0600
In-Reply-To: <53D7A9FC.3040001@solarflare.com>
References: <53D7A9FC.3040001@solarflare.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2014-07-29 at 15:04 +0100, Edward Cree wrote:
> Not sure if this list is the right place to ask, but:
> I'm working on fallback code in the sfc driver where in some
> configurations the device won't support using VFs, but will still
> advertise them as present [1].  This is discovered at PF probe time, and
> what I want to do is just set sriov_totalvfs to 0 in this case.
> 
> As far as I can tell, pci_sriov_set_totalvfs (drivers/pci/iov.c) is the
> function to call, but I'm confused by the comment on that function which
> states "Should be called from PF driver's probe routine with device's
> mutex held."
> 
> Specifically, it's unclear what mutex is meant.  struct pci_dev doesn't
> have one; struct pci_sriov /does/ but the struct is only defined in
> drivers/pci/pci.h which I don't appear to be able to include from a
> driver.  There's also one in the 'struct device dev' member of struct
> pci_dev, but that seems rather unlikely.
> 
> Also, the wording of the comment makes me wonder if being in the PF
> probe routine /implies/ that the mutex is held already, in which case I
> don't have to do anything.  This is supported by the only callers,
> igb_probe (via igb_sw_init and igb_probe_vfs) and ixgbe_probe, not
> appearing to take any mutexes before calling pci_sriov_set_totalvfs.

I believe this is referring to device_lock(), which should already be
held on the PF during probe.  Thanks,

Alex

