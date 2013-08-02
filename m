Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:58618 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753199Ab3HBWwN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Aug 2013 18:52:13 -0400
Received: by mail-ob0-f177.google.com with SMTP id f8so2215155obp.36
        for <linux-pci@vger.kernel.org>; Fri, 02 Aug 2013 15:52:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1375435866-16332-5-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1375435866-16332-1-git-send-email-weiyang@linux.vnet.ibm.com> <1375435866-16332-5-git-send-email-weiyang@linux.vnet.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 2 Aug 2013 16:51:53 -0600
Message-ID: <CAErSpo5zZVDgANFzzoz+pjJk8++rB4JTdc2hH0M-9ku8r+tKaQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] PCI: fix the io resource alignment calculation in pbus_size_io()
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ram Pai <linuxram@us.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 2, 2013 at 3:31 AM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
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
> Here is an example for this case.
>
> Assume:
>         1. pcibios_window_alignment() return 1.
>         2. window_alignment() return PCI_P2P_DEFAULT_IO_ALIGN_1K.
>         3. one of the child device has an IO resource with size of 2K.
>
> Result comparison:
>
>                     Before 462d9303             After 462d9303
>     min_align       1k                          1k
>                                         |
>                              after loop |
>                                         V
>     min_align       2k                          2k
>                                         |
>                          check boundary |
>                                         V
>     min_align       2k                          1k
>
> After applying the change:
>
> Result comparison:
>
>                     with  462d9303             with this patch
>     min_align       1k                          1k
>     io_align        1k                          4k
>                                         |
>                              after loop |
>                                         V
>     min_align       2k                          2k
>     io_align        1k                          4k
>                                         |
>                          check boundary |
>                                         V
>     min_align       1k                          2k
>     io_align        1k                          1k
>
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>

Gavin, can you ack this, since you wrote the original commit involved?

> ---
>  drivers/pci/setup-bus.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index d4f1ad9..6c111e9 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -755,6 +755,10 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
>                 return;
>
>         io_align = min_align = window_alignment(bus, IORESOURCE_IO);
> +       /* Don't exceed 4KiB for windows requesting 1KiB alignment */
> +       if (bus->self->io_window_1k && io_align == PCI_P2P_DEFAULT_IO_ALIGN_1K)
> +               io_align = PCI_P2P_DEFAULT_IO_ALIGN;
> +
>         list_for_each_entry(dev, &bus->devices, bus_list) {
>                 int i;
>
> --
> 1.7.5.4
>
