Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:63121 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755054Ab3EVOuC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 May 2013 10:50:02 -0400
Received: by mail-ob0-f171.google.com with SMTP id ef5so2436789obb.2
        for <linux-pci@vger.kernel.org>; Wed, 22 May 2013 07:50:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1369228358-32580-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369228358-32580-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1369228358-32580-5-git-send-email-thomas.petazzoni@free-electrons.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 22 May 2013 08:49:41 -0600
Message-ID: <CAErSpo5LAOFtWUQpDk4OdfrCPr4gAnp_+nkmZcOib0531Who-A@mail.gmail.com>
Subject: Re: [PATCH 4/4] pci: mvebu: fix the emulation of the status register
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 22, 2013 at 7:12 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> In a PCI configuration header, the 'devsel' bits of the status
> register are read-only, and indicate the timing of the secondary
> interface. Currently, we implement them as read/write, so when the
> Linux PCI core writes all 1's to this register, it gets 11b as the
> 'devsel' value, which is reserved.

I suppose the problem is that pci_scan_bridge() writes 0xffff to the
PCI_STATUS register?

PCI_STATUS is documented as containing either RO or RW1C
(write-1-to-clear status) bits, so it makes sense to write all ones to
clear all status bits.  But there are other RO bits that I think you
should mask out, too: Interrupt Status, Capabilities List, etc.

Maybe if you fix this, it will also fix the Capability List issue you
saw in patch 3/4.

> This commit fixes the PCI-to-PCI bridge emulation of the Marvell PCIe
> driver to ensure those bits remain set to 00b, which indicate a fast
> devsel decoding.
>
> This allows to fix the lspci -v output from:
>
>   Flags: bus master, 66MHz, user-definable features, ?? devsel, latency 0
>
> to:
>
>   Flags: bus master, 66MHz, user-definable features, fast devsel, latency 0
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/pci/host/pci-mvebu.c |    5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index c887598..d730bf4 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -490,6 +490,11 @@ static int mvebu_sw_pci_bridge_write(struct mvebu_pcie_port *port,
>         case PCI_COMMAND:
>                 bridge->command = value & 0xffff;
>                 bridge->status = value >> 16;
> +               /*
> +                * The devsel bits are read-only, and we want to keep
> +                * them set to 0
> +                */
> +               bridge->status &= ~PCI_STATUS_DEVSEL_MASK;
>                 break;
>
>         case PCI_BASE_ADDRESS_0 ... PCI_BASE_ADDRESS_1:
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
