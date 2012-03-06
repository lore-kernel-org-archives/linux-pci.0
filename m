Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56929 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031267Ab2CFWpK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Mar 2012 17:45:10 -0500
Received: by ghrr11 with SMTP id r11so2602372ghr.19
        for <linux-pci@vger.kernel.org>; Tue, 06 Mar 2012 14:45:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120306181340.8566.79920.stgit@bhelgaas.mtv.corp.google.com>
References: <20120306181340.8566.79920.stgit@bhelgaas.mtv.corp.google.com>
Date: Tue, 6 Mar 2012 14:45:09 -0800
Message-ID: <CAE9FiQU0b1iLHMyRMyTHTPXdF26H=siytor4o3bi_gJw59GN=g@mail.gmail.com>
Subject: Re: [PATCH RFC] PCI: allow P2P bridge windows starting at PCI bus
 address zero
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 6, 2012 at 10:13 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> This patch is for discussion.  I didn't include a Signed-off-by line
> because I suspect the patch is incomplete as it stands.
>
> cd81e1ea1a4c added checks that prevent us from using P2P bridge windows
> that start at PCI bus address zero.  The reason was to "prevent us from
> overwriting resources that are unassigned."
>
> But I don't think generic code should disallow address zero in either BARs or
> bridge windows, so I think that commit was a mistake.
>
> Windows at bus address zero are legal and likely to exist on machines with an
> offset between bus addresses and CPU addresses.  For example, in the following
> hypothetical scenario, the bridge at 00:01.0 has a window at bus address zero
> and the device at 01:00.0 has a BAR at bus address zero, and I think both are
> perfectly valid:
>
>    PCI host bridge to bus 0000:00
>    pci_bus 0000:00: root bus resource [mem 0x100000000-0x1ffffffff] (bus address [0x00000000-0xffffffff])
>    pci 0000:00:01.0: PCI bridge to [bus 01]
>    pci 0000:00:01.0:   bridge window [mem 0x100000000-0x100ffffff]
>    pci 0000:01:00.0: reg 10: [mem 0x100000000-0x100ffffff]
>
> I don't want to reintroduce whatever bug cd81e1ea1a4c fixed.  So please comment
> on whether my reasoning above is correct and what problem would be caused if we
> applied the following patch.
>
> CC: Yinghai Lu <yinghai@kernel.org>
> ---
>  drivers/pci/probe.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 944e05a..1725866 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -365,7 +365,7 @@ static void __devinit pci_read_bridge_io(struct pci_bus *child)
>                limit |= (io_limit_hi << 16);
>        }
>
> -       if (base && base <= limit) {
> +       if (base <= limit) {
>                res->flags = (io_base_lo & PCI_IO_RANGE_TYPE_MASK) | IORESOURCE_IO;
>                region.start = base;
>                region.end = limit + 0xfff;
> @@ -391,7 +391,7 @@ static void __devinit pci_read_bridge_mmio(struct pci_bus *child)
>        pci_read_config_word(dev, PCI_MEMORY_LIMIT, &mem_limit_lo);
>        base = (mem_base_lo & PCI_MEMORY_RANGE_MASK) << 16;
>        limit = (mem_limit_lo & PCI_MEMORY_RANGE_MASK) << 16;
> -       if (base && base <= limit) {
> +       if (base <= limit) {
>                res->flags = (mem_base_lo & PCI_MEMORY_RANGE_TYPE_MASK) | IORESOURCE_MEM;
>                region.start = base;
>                region.end = limit + 0xfffff;
> @@ -437,7 +437,7 @@ static void __devinit pci_read_bridge_mmio_pref(struct pci_bus *child)
>  #endif
>                }
>        }
> -       if (base && base <= limit) {
> +       if (base <= limit) {
>                res->flags = (mem_base_lo & PCI_PREF_RANGE_TYPE_MASK) |
>                                         IORESOURCE_MEM | IORESOURCE_PREFETCH;
>                if (res->flags & PCI_PREF_RANGE_TYPE_64)
>


yes, you can remove that base checking.

Yinghai
