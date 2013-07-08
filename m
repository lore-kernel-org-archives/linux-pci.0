Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:37586 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087Ab3GHVPe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Jul 2013 17:15:34 -0400
Received: by mail-ob0-f181.google.com with SMTP id 16so5990736obc.26
        for <linux-pci@vger.kernel.org>; Mon, 08 Jul 2013 14:15:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1372691432-6440-5-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1372691432-6440-1-git-send-email-weiyang@linux.vnet.ibm.com> <1372691432-6440-5-git-send-email-weiyang@linux.vnet.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 8 Jul 2013 15:15:13 -0600
Message-ID: <CAErSpo5O6CdzSw3bQyuKXsP+H0deJtGL1kXU+ddf_reA+ECq6w@mail.gmail.com>
Subject: Re: [PATCH 4/4] PCI: fix the io resource alignment calculation in pbus_size_io()
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ram Pai <linuxram@us.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 1, 2013 at 9:10 AM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
> In commit 462d9303 ("PCI: Align P2P windows using pcibios_window_alignment()"),
> it introduce a new method to calculate the window alignment of P2P bridge.
>
> When the io_window_1k is set,  the calculation for the io resource alignment
> is different from the original one. In the original logic before 462d9303,
> the alignment is no bigger than 4K even the io_window_1k is set. The logic
> introduced in 462d9303 will limit the alignment to 1k in this case.
>
> This patch fix this issue.
>
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> Reviewed-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> Reviewed-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  drivers/pci/setup-bus.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index bd0ce39d..5c60ca0 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -755,6 +755,10 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
>                 return;
>
>         io_align = min_align = window_alignment(bus, IORESOURCE_IO);
> +       /* Don't exceed 4KiB for windows requesting 1KiB alignment */
> +       if (bus->self->io_window_1k && io_align == PCI_P2P_DEFAULT_IO_ALIGN_1K)
> +               io_align = PCI_P2P_DEFAULT_IO_ALIGN;

Please explain why we need this change, with some actual values that
show the problem.  We need to know what the problem is, not merely
that the code behaves differently than it did before 462d9303.

It appears to me that this change will break the ability to use 1K
windows.  For example, assume a bridge that supports 1K windows.
Assume we're using the default pcibios_window_alignment().  Currently
window_alignment() on the secondary bus returns
PCI_P2P_DEFAULT_IO_ALIGN_1K (0x400, which is 1K), so io_align = 0x400.

With your change, I think io_align will be bumped back up to 4K in
this case, so we'll lose the ability to allocate a 1K window.

>         list_for_each_entry(dev, &bus->devices, bus_list) {
>                 int i;
>
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
