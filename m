Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:55396 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbaBEIuz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Feb 2014 03:50:55 -0500
MIME-Version: 1.0
In-Reply-To: <1390902468-7753-3-git-send-email-ben.dooks@codethink.co.uk>
References: <1390902468-7753-1-git-send-email-ben.dooks@codethink.co.uk>
	<1390902468-7753-3-git-send-email-ben.dooks@codethink.co.uk>
Date: Wed, 5 Feb 2014 17:50:53 +0900
Message-ID: <CANqRtoRy9bEUMCDqMtbfa3NvLuuLxda5RN=CZs9V37caNnwdWw@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI: rcar: add error interrupt handling
From: Magnus Damm <magnus.damm@gmail.com>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	SH-Linux <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 28, 2014 at 6:47 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> Add option to enable interrupts to report any errors from
> the AHB-PCI bridge to help find any issues with the bridge
> when in use.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Valentine Barshak <valentine.barshak@cogentembedded.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> ---
>  drivers/pci/host/Kconfig         |  9 ++++++
>  drivers/pci/host/pci-rcar-gen2.c | 60 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+)
>
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 47d46c6..6d4c46e 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -33,4 +33,13 @@ config PCI_RCAR_GEN2
>           There are 3 internal PCI controllers available with a single
>           built-in EHCI/OHCI host controller present on each one.
>
> +config PCI_RCAR_GEN2_ERRIRQ
> +       bool "Enable error reporting interrupt support"
> +       depends on PCI_RCAR_GEN2
> +       help
> +         Say Y here to enable support for the bus-error interrupts from
> +         the PCI controller bridge.
> +
> +         This is here for aiding in debugging issues with the hardware.
> +

Thanks for your patches. Handling errors sounds good. About this
particular one, I'm not so keen on introducing Kconfig options for
each driver. Instead I'd prefer to handle this during runtime or as
Valentine suggested using CONFIG_PCI_DEBUG.

Cheers,

/ magnus
