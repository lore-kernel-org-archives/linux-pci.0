Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:47025 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756211Ab3EVOjY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 May 2013 10:39:24 -0400
Received: by mail-oa0-f42.google.com with SMTP id i10so2737173oag.15
        for <linux-pci@vger.kernel.org>; Wed, 22 May 2013 07:39:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1369228358-32580-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369228358-32580-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1369228358-32580-4-git-send-email-thomas.petazzoni@free-electrons.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 22 May 2013 08:39:03 -0600
Message-ID: <CAErSpo6gFf9ou-VtZ=F0+1GqcSoPS_dDMGphhgv=8mD602=BRA@mail.gmail.com>
Subject: Re: [PATCH 3/4] pci: mvebu: emulate an empty capability list
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
> Currently, our PCI-to-PCI bridge emulation doesn't emulate a proper
> capability list, which leads 'lspci -v' to show:
>
>   Capabilities: [fc] <chain broken>
>
> In order to fix this, this commit improve the PCI-to-PCI bridge

s/improve/improves/

> emulation to emulate an empty capability list. It might be later
> extended to expose things like the PCI Express Capability header, but
> an empty capability list is sufficient for now.
>
> lspci -v now shows the much nicer:
>
>   Capabilities: [40] #00 [0000]

It'd be even better if you could make the Capabilities List bit in the
Device Status register be zero.  Then lspci wouldn't even try to read
the Capabilities Pointer at 0x34, and you wouldn't have to deal with
reads of 0x40.

> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/pci/host/pci-mvebu.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index c21ca84..c887598 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -440,6 +440,16 @@ static int mvebu_sw_pci_bridge_read(struct mvebu_pcie_port *port,
>                 *value = 0;
>                 break;
>
> +       case PCI_CAPABILITY_LIST:
> +               /* Offset of the capability list */
> +               *value = 0x40;
> +               break;
> +
> +       case 0x40:
> +               /* We have no element in our capability list */
> +               *value = 0;
> +               break;
> +
>         default:
>                 *value = 0xffffffff;
>                 return PCIBIOS_BAD_REGISTER_NUMBER;
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
