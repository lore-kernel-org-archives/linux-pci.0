Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:45710 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964787Ab2HQDAt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Aug 2012 23:00:49 -0400
Received: by qaas11 with SMTP id s11so1212180qaa.19
        for <linux-pci@vger.kernel.org>; Thu, 16 Aug 2012 20:00:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1343180997-9483-5-git-send-email-shangw@linux.vnet.ibm.com>
References: <1343180997-9483-1-git-send-email-shangw@linux.vnet.ibm.com>
	<1343180997-9483-5-git-send-email-shangw@linux.vnet.ibm.com>
Date: Fri, 17 Aug 2012 11:00:48 +0800
Message-ID: <CADLM8XOiHMfwnxBvZU_YF8S9QomcXjy5fb6JyxCrNCjr+sbYOw@mail.gmail.com>
Subject: Re: [PATCH 4/8] pci: weak function returns alignment
From: Wei Yang <weiyang.kernel@gmail.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	benh@kernel.crashing.org, linuxram@us.ibm.com,
	Richard Yang <weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

2012/7/25 Gavin Shan <shangw@linux.vnet.ibm.com>:
> The patch implements the weak function to return the default I/O
> or memory alignment for P2P bridge. Currently, I/O window has 4KiB
> alignment and memory window is 4MiB aligned by default. On the other
> hand, those platforms (e.g. powernv) that have special requirements
> on the alignment could override the function by themselves.
>
> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  drivers/pci/setup-bus.c |   21 +++++++++++++++++++++
>  include/linux/pci.h     |    2 ++
>  2 files changed, 23 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 8fa2d4b..c0fb9da 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -690,6 +690,27 @@ static resource_size_t calculate_memsize(resource_size_t size,
>         return size;
>  }
>
> +resource_size_t __weak pcibios_window_alignment(struct pci_bus *bus,
> +                                               unsigned long type)
> +{
> +       return 1;
> +}
> +
> +static resource_size_t window_alignment(struct pci_bus *bus,
> +                                       unsigned long type)
> +{
> +       resource_size_t align = 1, arch_align;
> +
> +       if (type & IORESOURCE_MEM)
> +               align = 1024*1024;      /* 1MiB */
> +       else if (type & IORESOURCE_IO)
> +               align = 4*1024;         /* 4KiB */
> +

If this is a constant, could we use define a macro?
So we don't use to calculate the value every time.
Maybe some compile will be smart enough to optimize this,
still think it is better to give a result.

> +       arch_align = pcibios_window_alignment(bus, type);
> +
> +       return max(align, arch_align);
> +}
> +
>  /**
>   * pbus_size_io() - size the io window of a given bus
>   *
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 9acea4b..34ff2bb 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -988,6 +988,8 @@ int pci_cfg_space_size_ext(struct pci_dev *dev);
>  int pci_cfg_space_size(struct pci_dev *dev);
>  unsigned char pci_bus_max_busnr(struct pci_bus *bus);
>  void pci_setup_bridge(struct pci_bus *bus);
> +resource_size_t pcibios_window_alignment(struct pci_bus *bus,
> +                                        unsigned long type);
>
>  #define PCI_VGA_STATE_CHANGE_BRIDGE (1 << 0)
>  #define PCI_VGA_STATE_CHANGE_DECODES (1 << 1)
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Richard Yang
Help You, Help Me
