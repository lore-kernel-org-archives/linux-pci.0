Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:33402 "EHLO
	mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753056AbcHNQOM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 14 Aug 2016 12:14:12 -0400
Received: by mail-ua0-f196.google.com with SMTP id u13so2581233uau.0
        for <linux-pci@vger.kernel.org>; Sun, 14 Aug 2016 09:14:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160805175055.3e8800b8@free-electrons.com>
References: <20160805175055.3e8800b8@free-electrons.com>
From: Pratyush Anand <pratyush.anand@gmail.com>
Date: Sun, 14 Aug 2016 21:44:11 +0530
Message-ID: <CAHM4w1=qomK0XF0H6npREUPCp76xNpdNjU7jj6HdvGm+svJ4xg@mail.gmail.com>
Subject: Re: pcie-designware msi_controller->dev handling
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Thomas,

Sorry for delayed response.

On Fri, Aug 5, 2016 at 9:20 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Jingoo, Pratyush,
>
> I was going to some of the MSI handling code in the pcie-designware
> driver, and stumbled across the following part of the code:
>
> static struct msi_controller dw_pcie_msi_chip = {
>         .setup_irq = dw_msi_setup_irq,
>         .setup_irqs = dw_msi_setup_irqs,
>         .teardown_irq = dw_msi_teardown_irq,
> };
>
> [...]
>
> int dw_pcie_host_init(struct pcie_port *pp)
> {
>         [...]
>
>         if (IS_ENABLED(CONFIG_PCI_MSI)) {
>                 bus = pci_scan_root_bus_msi(pp->dev, pp->root_bus_nr,
>                                             &dw_pcie_ops, pp, &res,
>                                             &dw_pcie_msi_chip);
>                 dw_pcie_msi_chip.dev = pp->dev;
>         [...]
> }
>
> I am a bit surprised by the dw_pcie_msi_chip.dev assignment here.
> Indeed, there is only one global dw_pcie_msi_chip structure, but the
> function dw_pcie_host_init() can be called several times, once for each
> PCIe controller available on a platform.
>
> This means that the dw_pcie_msi_chip.dev will point to the last
> Designware PCIe controller that was registered.
>
> If the MSI controller is indeed part of the PCIe controller IP, I think
> the msi_controller structure needs to be dynamically allocated, so that
> you have one instance for each PCIe controller.

I think, you are right. Probably, we can make "struct msi_controller"
as part of "struct pcie_port", and can initialize it in
dw_pcie_host_init().

Thanks a lot for finding it.

~Pratyush

>
> Am I missing something?
>
> Best regards,
>
> Thomas
> --
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
