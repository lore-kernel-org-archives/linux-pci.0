Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:52128 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755577Ab3HAQx2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 Aug 2013 12:53:28 -0400
Received: by mail-ob0-f177.google.com with SMTP id f8so4224203obp.8
        for <linux-pci@vger.kernel.org>; Thu, 01 Aug 2013 09:53:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1375364659-3228-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375364659-3228-1-git-send-email-thomas.petazzoni@free-electrons.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 1 Aug 2013 10:53:07 -0600
Message-ID: <CAErSpo7Y+OE8_NT3npC1DCQz3PrOT9Nz=6MavY+zS63pGN3x9g@mail.gmail.com>
Subject: Re: [PATCH 3.11-rc] pci: mvebu: disable prefetchable memory support
 in PCI-to-PCI bridge
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	Lior Amsalem <alior@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 1, 2013 at 7:44 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> The Marvell PCIe driver uses an emulated PCI-to-PCI bridge to be able
> to dynamically set up MBus address decoding windows for PCI I/O and
> memory regions depending on the PCI devices enumerated by Linux.
>
> However, this emulated PCI-to-PCI bridge logic makes the Linux PCI
> core believe that prefetchable memory regions are supported (because
> the registers are read/write), while in fact no adress decoding window
> is ever created for such regions. Since the Marvell MBus address
> decoding windows do not distinguish memory regions and prefetchable
> memory regions, this patch takes a simple approach: change the
> PCI-to-PCI bridge emulation to let the Linux PCI core know that we
> don't support prefetchable memory regions.
>
> To achieve this, we simply make the prefetchable memory base a
> read-only register that always returns 0. Reading/writing all the
> other prefetchable memory related registers has no effect.
>
> This problem was originally reported by Finn Hoffmann
> <finn@uni-bremen.de>, who couldn't get a RTL8111/8168B PCI NIC working
> on the NSA310 Kirkwood platform after updating to 3.11-rc. The problem
> was that the PCI-to-PCI bridge emulation was making the Linux PCI core
> believe that we support prefetchable memory, so the Linux PCI core was
> only filling the prefetchable memory base and limit registers, which
> does not lead to a MBus window being created. The below patch has been
> confirmed by Finn Hoffmann to fix his problem on Kirkwood, and has
> otherwise been successfully tested on the Armada XP GP platform with a
> e1000e PCIe NIC and a Marvell SATA PCIe card.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Reported-by: Finn Hoffmann <finn@uni-bremen.de>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Please merge along with your other pci-mvebu.c changes.

> ---
> This patch fixes a regression introduced in 3.11-rc, so it should be
> applied to 3.11.
> ---
>  drivers/pci/host/pci-mvebu.c | 27 +--------------------------
>  1 file changed, 1 insertion(+), 26 deletions(-)
>
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index 13a633b..7bf3926 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -86,10 +86,6 @@ struct mvebu_sw_pci_bridge {
>         u16 secondary_status;
>         u16 membase;
>         u16 memlimit;
> -       u16 prefmembase;
> -       u16 prefmemlimit;
> -       u32 prefbaseupper;
> -       u32 preflimitupper;
>         u16 iobaseupper;
>         u16 iolimitupper;
>         u8 cappointer;
> @@ -419,15 +415,7 @@ static int mvebu_sw_pci_bridge_read(struct mvebu_pcie_port *port,
>                 break;
>
>         case PCI_PREF_MEMORY_BASE:
> -               *value = (bridge->prefmemlimit << 16 | bridge->prefmembase);
> -               break;
> -
> -       case PCI_PREF_BASE_UPPER32:
> -               *value = bridge->prefbaseupper;
> -               break;
> -
> -       case PCI_PREF_LIMIT_UPPER32:
> -               *value = bridge->preflimitupper;
> +               *value = 0;
>                 break;
>
>         case PCI_IO_BASE_UPPER16:
> @@ -501,19 +489,6 @@ static int mvebu_sw_pci_bridge_write(struct mvebu_pcie_port *port,
>                 mvebu_pcie_handle_membase_change(port);
>                 break;
>
> -       case PCI_PREF_MEMORY_BASE:
> -               bridge->prefmembase = value & 0xffff;
> -               bridge->prefmemlimit = value >> 16;
> -               break;
> -
> -       case PCI_PREF_BASE_UPPER32:
> -               bridge->prefbaseupper = value;
> -               break;
> -
> -       case PCI_PREF_LIMIT_UPPER32:
> -               bridge->preflimitupper = value;
> -               break;
> -
>         case PCI_IO_BASE_UPPER16:
>                 bridge->iobaseupper = value & 0xffff;
>                 bridge->iolimitupper = value >> 16;
> --
> 1.8.1.2
>
