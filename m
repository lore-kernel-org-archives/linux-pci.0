Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:41129 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbaLKQuT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 11 Dec 2014 11:50:19 -0500
Received: by mail-qa0-f44.google.com with SMTP id i13so3847707qae.31
        for <linux-pci@vger.kernel.org>; Thu, 11 Dec 2014 08:50:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1418277792-4090-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1418277792-4090-1-git-send-email-gwshan@linux.vnet.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 11 Dec 2014 09:49:57 -0700
Message-ID: <CAErSpo4y=MjRkAmxFChD4mOqQ_okkib5MLjTy-m=adXvnJqf4w@mail.gmail.com>
Subject: Re: [PATCH RFC] PCI: Turn off BARs when disabling device
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rafael Wysocki <rjw@sisk.pl>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gavin,

On Wed, Dec 10, 2014 at 11:03 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
> When unbinding PCI device mlx4 from its driver, the PCI device is
> disabled by pci_disable_device() and the BARs (IO and memory) should
> be disabled at the point. However, the memory BARs are still active
> after the mlx4_core driver is unloaded as following logs show.
>
>  # lspci -vv -s 0003:0f:00.0
>  0003:0f:00.0 Network controller: Mellanox Technologies \
>               MT27500 Family [ConnectX-3]
>  Subsystem: Mellanox Technologies Device 0061
>  Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- \
>           ParErr+ Stepping- SERR+ FastB2B- DisINTx+
>     :
>  Kernel driver in use: mlx4_core
>  # echo 0003:0f:00.0 > /sys/bus/pci/drivers/mlx4_core/unbind
>  # lspci -vv -s 0003:0f:00.0
>  0003:0f:00.0 Network controller: Mellanox Technologies \
>               MT27500 Family [ConnectX-3]
>  Subsystem: Mellanox Technologies Device 0061
>  Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- \
>           ParErr+ Stepping- SERR+ FastB2B- DisINTx-
>
> The patch turns off all BARs (IO and memory) in do_pci_disable_device().
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  drivers/pci/pci.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 625a4ac..8d2924b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1496,12 +1496,14 @@ void __weak pcibios_penalize_isa_irq(int irq, int active) {}
>
>  static void do_pci_disable_device(struct pci_dev *dev)
>  {
> -       u16 pci_command;
> +       u16 cmd, flags = (PCI_COMMAND_IO |
> +                         PCI_COMMAND_MEMORY |
> +                         PCI_COMMAND_MASTER);
>
> -       pci_read_config_word(dev, PCI_COMMAND, &pci_command);
> -       if (pci_command & PCI_COMMAND_MASTER) {
> -               pci_command &= ~PCI_COMMAND_MASTER;
> -               pci_write_config_word(dev, PCI_COMMAND, pci_command);
> +       pci_read_config_word(dev, PCI_COMMAND, &cmd);
> +       if (cmd & flags) {
> +               cmd &= ~flags;
> +               pci_write_config_word(dev, PCI_COMMAND, cmd);

Does this fix an actual problem?  If so, I'd like to see details about
what the problem is.

I'm a bit concerned about turning off IO/MEMORY/MASTER unconditionally
because we have code that is a bit careful to avoid that in some
cases.  Search for "mmio_always_on" and see commit 253d2e549818 ("PCI:
disable mmio during bar sizing").

So if this patch fixes a problem, all well and good, but we do need to
make sure we don't introduce another problem at the same time.

Bjorn

>         }
>
>         pcibios_disable_device(dev);
> --
> 1.8.3.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
