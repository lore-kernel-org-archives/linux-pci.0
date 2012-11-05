Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:47584 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932954Ab2KEW3N (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Nov 2012 17:29:13 -0500
Received: by mail-we0-f174.google.com with SMTP id t9so2866906wey.19
        for <linux-pci@vger.kernel.org>; Mon, 05 Nov 2012 14:29:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1347994314.9011.1.camel@joe2Laptop>
References: <1347994314.9011.1.camel@joe2Laptop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 5 Nov 2012 15:28:52 -0700
Message-ID: <CAErSpo6+dnxjCaqE=hiYUfDTKi3SCg0SYfuoHVuCse6_nG1mEA@mail.gmail.com>
Subject: Re: [PATCH] pci: Convert pci_resource_<foo> macros to static inlines
To: Joe Perches <joe@perches.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 18, 2012 at 12:51 PM, Joe Perches <joe@perches.com> wrote:
> Get the compiler to verify the argument type of struct pci_dev *.
>
> Signed-off-by: Joe Perches <joe@perches.com>

I applied this to my pci/misc branch as v3.8 material.  Thanks!

> ---
>
> Another possible improvement is to range check index.
>
>  include/linux/pci.h |   36 ++++++++++++++++++++++++++----------
>  1 files changed, 26 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 5faa831..971d0e9 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1396,16 +1396,32 @@ static inline struct pci_dev *pci_dev_get(struct pci_dev *dev)
>
>  /* these helpers provide future and backwards compatibility
>   * for accessing popular PCI BAR info */
> -#define pci_resource_start(dev, bar)   ((dev)->resource[(bar)].start)
> -#define pci_resource_end(dev, bar)     ((dev)->resource[(bar)].end)
> -#define pci_resource_flags(dev, bar)   ((dev)->resource[(bar)].flags)
> -#define pci_resource_len(dev,bar) \
> -       ((pci_resource_start((dev), (bar)) == 0 &&      \
> -         pci_resource_end((dev), (bar)) ==             \
> -         pci_resource_start((dev), (bar))) ? 0 :       \
> -                                                       \
> -        (pci_resource_end((dev), (bar)) -              \
> -         pci_resource_start((dev), (bar)) + 1))
> +static inline resource_size_t
> +pci_resource_start(const struct pci_dev *dev, int index)
> +{
> +       return dev->resource[index].start;
> +}
> +
> +static inline resource_size_t
> +pci_resource_end(const struct pci_dev *dev, int index)
> +{
> +       return dev->resource[index].end;
> +}
> +
> +static inline unsigned long
> +pci_resource_flags(const struct pci_dev *dev, int index)
> +{
> +       return dev->resource[index].flags;
> +}
> +
> +static inline resource_size_t
> +pci_resource_len(const struct pci_dev *dev, int index)
> +{
> +       if (pci_resource_start(dev, index) == 0 &&
> +           pci_resource_end(dev, index) == 0)
> +               return 0;
> +       return resource_size(&dev->resource[index]);
> +}
>
>  /* Similar to the helpers above, these manipulate per-pci_dev
>   * driver-specific data.  They are really just a wrapper around
>
>
>
