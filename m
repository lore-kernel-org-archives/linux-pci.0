Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:59988 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729Ab2FLPXD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jun 2012 11:23:03 -0400
Received: by lbbgm6 with SMTP id gm6so454758lbb.19
        for <linux-pci@vger.kernel.org>; Tue, 12 Jun 2012 08:23:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120612035930.11801.98916.stgit@bling.home>
References: <20120612035930.11801.98916.stgit@bling.home>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 12 Jun 2012 09:22:40 -0600
Message-ID: <CAErSpo5gbTNb=L81jgyfnOtAWiWEv16QqToNNeE-P8RRvLsFEg@mail.gmail.com>
Subject: Re: [PATCH] PCI: Fix allnoconfig with PCI DMA source quirk
To: Alex Williamson <alex.williamson@redhat.com>
Cc: wfg@linux.intel.com, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 11, 2012 at 10:00 PM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> When CONFIG_PCI_QUIRKS is not defined we want to keep the reference
> counting the same for callers of pci_get_dma_source.  But I forgot to
> account for !CONFIG_PCI where we then need to make an inline for
> pci_get_dev.  This fixes it.
>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>
>  include/linux/pci.h |    3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 95479cd..35884f27 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1368,6 +1368,9 @@ static inline struct pci_dev *pci_get_bus_and_slot(unsigned int bus,
>  static inline int pci_domain_nr(struct pci_bus *bus)
>  { return 0; }
>
> +static inline struct pci_dev *pci_dev_get(struct pci_dev *dev)
> +{ return NULL; }

I folded this into patch [1/5] and will rebase "next" today.
