Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40623 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932421AbdACJfZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Jan 2017 04:35:25 -0500
Message-ID: <1483435737.20054.6.camel@suse.com>
Subject: Re: Thunderbolt adapter fails to instantiate USB and device
 enumeration if already connected at boot time
From: Oliver Neukum <oneukum@suse.com>
To: Chris Murphy <lists@colorremedies.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org
Date: Tue, 03 Jan 2017 10:28:57 +0100
In-Reply-To: <CAJCQCtTGYUFCvwPzugJ4TUtFPGKTy7r+HJr_1o8s=cbASa4zUA@mail.gmail.com>
References: <CAJCQCtS5gQObZr1j0stEnx9+U890_N-2FBFx_fZCZtmD8-2qJQ@mail.gmail.com>
         <Pine.LNX.4.44L0.1701021626410.28032-100000@netrider.rowland.org>
         <CAJCQCtTGYUFCvwPzugJ4TUtFPGKTy7r+HJr_1o8s=cbASa4zUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2017-01-02 at 14:45 -0700, Chris Murphy wrote:
> I see these lines in the problem case, which don't occur in the
> working case.
> 
> [    0.561046] pci_bus 0000:37: busn_res: [bus 37-ff] end is updated
> to 37
> [    0.561047] pci_bus 0000:37: busn_res: can not insert [bus 37]
> under domain [bus 00-ff] (conflicts with (null) [bus 00-fe])
> 
> [    0.579446] pci 0000:37:00.0: can't claim BAR 0 [mem
> 0xb0000000-0xb000ffff]: address conflict with PCI Bus 0000:00 [mem
> 0x40000000-0xdfffffff window]
> 
> [    0.602277] pci 0000:37:00.0: can't derive routing for PCI INT A
> [    0.602280] pci 0000:37:00.0: PCI INT A: not connected
> [    0.612304] pci 0000:37:00.0: xHCI HW not ready after 5 sec (HC
> bug?) status = 0xffffffff

Have you tried "pci=realloc"?

	Regards
		Oliver


