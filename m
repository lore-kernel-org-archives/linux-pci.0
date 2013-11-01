Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:64547 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811Ab3KAP1u (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 Nov 2013 11:27:50 -0400
Received: by mail-ie0-f171.google.com with SMTP id tp5so7696897ieb.16
        for <linux-pci@vger.kernel.org>; Fri, 01 Nov 2013 08:27:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1382808205-843-1-git-send-email-amurray@embedded-bits.co.uk>
References: <1382808205-843-1-git-send-email-amurray@embedded-bits.co.uk>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 1 Nov 2013 09:27:30 -0600
Message-ID: <CAErSpo6+YD4TRYcgbcvAr5vmNgt5L8vrm2tAqHmoiF4qGDnqZw@mail.gmail.com>
Subject: Re: [PATCH] pci: update pcie_ports 'auto' behavior for non-ACPI platforms
To: Andrew Murray <amurray@embedded-bits.co.uk>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Karicheri, Muralidharan" <m-karicheri2@ti.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Oct 26, 2013 at 11:23 AM, Andrew Murray
<amurray@embedded-bits.co.uk> wrote:
> The pcie_ports parameter, which defaults to 'auto', allows a user
> to specify if PCIe port services are disabled ('compat'), always
> enabled ('native'), or only used when allowed by the BIOS
> ('auto').
>
> Where CONFIG_ACPI isn't enabled, as is often the case for non
> x86/ia64 platforms, the 'auto' behavior results in that of
> 'compat'. Thus in order to use port services on these platforms
> 'pcie_ports=native' must be added to the kernel command line.
>
> This patch results in the 'native' behavior being followed where
> 'auto' is selected and ACPI is not enabled.
>
> Signed-off-by: Andrew Murray <amurray@embedded-bits.co.uk>

Applied to pci/misc.  I'll probably include this in the v3.13 pull
request.  Thanks!

Bjorn

> ---
>  drivers/pci/pcie/portdrv_core.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 31063ac..08d131f 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -260,13 +260,14 @@ static int get_port_device_capability(struct pci_dev *dev)
>         if (pcie_ports_disabled)
>                 return 0;
>
> -       err = pcie_port_platform_notify(dev, &cap_mask);
> -       if (!pcie_ports_auto) {
> -               cap_mask = PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP
> -                               | PCIE_PORT_SERVICE_VC;
> -               if (pci_aer_available())
> -                       cap_mask |= PCIE_PORT_SERVICE_AER;
> -       } else if (err) {
> +       cap_mask = PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP
> +                       | PCIE_PORT_SERVICE_VC;
> +       if (pci_aer_available())
> +               cap_mask |= PCIE_PORT_SERVICE_AER;
> +
> +       if (pcie_ports_auto) {
> +               err = pcie_port_platform_notify(dev, &cap_mask);
> +               if (err)
>                         return 0;
>         }
>
> --
> 1.8.1.2
>
