Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:61156 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728Ab3HER7L (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Aug 2013 13:59:11 -0400
Received: by mail-oa0-f47.google.com with SMTP id g12so7015629oah.34
        for <linux-pci@vger.kernel.org>; Mon, 05 Aug 2013 10:59:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1375435866-16332-5-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1375435866-16332-1-git-send-email-weiyang@linux.vnet.ibm.com> <1375435866-16332-5-git-send-email-weiyang@linux.vnet.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 5 Aug 2013 11:58:50 -0600
Message-ID: <CAErSpo5Lv7-Op3hg_ZRgSjzMNYZpZGphQFJyxxP6B8xLpwrSkw@mail.gmail.com>
Subject: Re: [PATCH 4/4] PCI: fix the io resource alignment calculation in pbus_size_io()
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ram Pai <linuxram@us.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Yinghai]

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

Presumably this fixes a bug, but you don't say what it is.  "different
from the original" is not a description of a problem.  You need
something like "with the current code, we allocate the wrong window
size in situation X, or we allocate a window with incorrect alignment
in situation Y, etc."

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

I don't think it makes sense to set "min_align = window_alignment(bus,
IORESOURCE_IO)" before the loop.  "io_align" is a function of the
bridge and is independent of downstream devices and is computed by
window_alignment().  "min_align" is a function of the downstream
devices and bridges and should be zero when entering the loop.

> +       /* Don't exceed 4KiB for windows requesting 1KiB alignment */

This comment doesn't make sense to me.  The code changes io_align from
1024 to 4096, so I don't understand where the "don't exceed 4KiB" part
comes from.  io_align doesn't exceed 4096 anyway, unless
pcibios_window_alignment() gives us a larger alignment, and in that
case, this patch has no effect because io_align is not 1024.

> +       if (bus->self->io_window_1k && io_align == PCI_P2P_DEFAULT_IO_ALIGN_1K)
> +               io_align = PCI_P2P_DEFAULT_IO_ALIGN;
> +

>         list_for_each_entry(dev, &bus->devices, bus_list) {
>                 int i;

This list_for_each_entry() loop computes the alignment required by
downstream devices and bridges.  The result is "min_align".

After the loop we have this (added by Yinghai in fd5913411):

    if (min_align > io_align)
        min_align = io_align;

I don't understand this.  There are three cases:

1) No downstream bridges: min_align <= 256 because I/O BARs are
limited to 256 bytes.
2) All downstream bridges have 1K extension: min_align = 1024.
3) At least one downstream bridge requires 4K alignment: min_align = 4096.

"io_align" is the minimum alignment enforced by the bridge.  This is
independent of any devices below the bridge, so "io_align >= 1024" in
all cases.

Therefore, the "min_align = io_align" assignment only happens in case
3, when a downstream bridge requires 4K alignment and *this* bridge
supports the 1K extension.  But that seems wrong.  The downstream
bridge's 4K requirement also applies to all bridges all the way
upstream.

It looks to me like this test should instead be:

    if (min_align < io_align)
        min_align = io_align;

> --
> 1.7.5.4
>
