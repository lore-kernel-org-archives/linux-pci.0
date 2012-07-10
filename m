Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:57819 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075Ab2GJDYs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jul 2012 23:24:48 -0400
Received: by lbbgm6 with SMTP id gm6so21398803lbb.19
        for <linux-pci@vger.kernel.org>; Mon, 09 Jul 2012 20:24:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120709202308.28178.58942.stgit@bhelgaas.mtv.corp.google.com>
References: <20120709202308.28178.58942.stgit@bhelgaas.mtv.corp.google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 9 Jul 2012 21:24:26 -0600
Message-ID: <CAErSpo7zprm-iHMRbCp0xh0so_ozqvN1uF8P4UhsDV5c0tu_nw@mail.gmail.com>
Subject: Re: [PATCH 0/3] PCI: P2P bridge window fixes
To: linux-pci@vger.kernel.org
Cc: Yinghai Lu <yinghai@kernel.org>, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 9, 2012 at 2:31 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Two fixes here:
>
> 1) Zero is a legal P2P bridge window base and BAR value and is likely to
> occur when there is an offset between bus addresses and CPU addresses.
> Stop disallowing it.
>
> 2) The Intel-specific 1K I/O window granularity for P2P bridges was
> implemented in a way that precluded reassignment of the window after
> FINAL quirks.  Fix that.
>
> And also replace the sparc pci_cfg_fake_ranges() with the functionally
> equivalent generic version.
>
> ---
>
> Bjorn Helgaas (3):
>       PCI: allow P2P bridge windows starting at PCI bus address zero
>       PCI: reimplement P2P bridge 1K I/O windows (Intel P64H2)
>       sparc/PCI: replace pci_cfg_fake_ranges() with pci_read_bridge_bases()
>
>
>  arch/sparc/kernel/pci.c  |   89 +---------------------------------------------
>  drivers/pci/probe.c      |   31 +++++++++-------
>  drivers/pci/quirks.c     |   39 +-------------------
>  drivers/pci/setup-bus.c  |   11 +++++-
>  include/linux/pci.h      |    1 +
>  include/linux/pci_regs.h |    3 +-
>  6 files changed, 31 insertions(+), 143 deletions(-)

I applied these, as well as Yinghai's patch for 1K support in
pbus_size_io(), to my "next" branch.  Thanks, Yinghai!

Bjorn
