Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:34351 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbaEMBis (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 May 2014 21:38:48 -0400
Received: by mail-ie0-f170.google.com with SMTP id ar20so4524507iec.1
        for <linux-pci@vger.kernel.org>; Mon, 12 May 2014 18:38:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1399942683-23898-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1399942683-23898-1-git-send-email-gwshan@linux.vnet.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 12 May 2014 19:38:28 -0600
Message-ID: <CAErSpo5brfq1uPqPs3es_-S=awxuAX_f8ruSvL8Mnr=Vv1SAPw@mail.gmail.com>
Subject: Re: [PATCH] PCI: Fix return value from pci_user_{read,write}_config_*()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Greg]

On Mon, May 12, 2014 at 6:58 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
> PCI accessors from user space pci_user_{read,write}_config_*()
> return negative error number, which was introduced by commit
> 34e32072 ("PCI: handle positive error codes"). That patch coverts
> all positive error numbers from platform specific PCI config
> accessors to -EINVAL. The upper layer calling to those PCI config
> accessors hardly know the specific cause from the return value
> when hitting failures.
>
> The patch fixes the issue by doing the conversion (from positive
> to negative) using existing function pcibios_err_to_errno().
>
> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  drivers/pci/access.c | 12 ++++--------
>  include/linux/pci.h  |  6 ++++--
>  2 files changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 7f8b78c..8c148f3 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -148,7 +148,7 @@ static noinline void pci_wait_cfg(struct pci_dev *dev)
>  int pci_user_read_config_##size                                                \
>         (struct pci_dev *dev, int pos, type *val)                       \
>  {                                                                      \
> -       int ret = 0;                                                    \
> +       int ret = PCIBIOS_SUCCESSFUL;                                   \
>         u32 data = -1;                                                  \
>         if (PCI_##size##_BAD)                                           \
>                 return -EINVAL;                                         \
> @@ -159,9 +159,7 @@ int pci_user_read_config_##size                                             \
>                                         pos, sizeof(type), &data);      \
>         raw_spin_unlock_irq(&pci_lock);                         \
>         *val = (type)data;                                              \
> -       if (ret > 0)                                                    \
> -               ret = -EINVAL;                                          \
> -       return ret;                                                     \
> +       return pcibios_err_to_errno(ret);                               \
>  }                                                                      \
>  EXPORT_SYMBOL_GPL(pci_user_read_config_##size);
>
> @@ -170,7 +168,7 @@ EXPORT_SYMBOL_GPL(pci_user_read_config_##size);
>  int pci_user_write_config_##size                                       \
>         (struct pci_dev *dev, int pos, type val)                        \
>  {                                                                      \
> -       int ret = -EIO;                                                 \
> +       int ret = PCIBIOS_SUCCESSFUL;                                   \
>         if (PCI_##size##_BAD)                                           \
>                 return -EINVAL;                                         \
>         raw_spin_lock_irq(&pci_lock);                           \
> @@ -179,9 +177,7 @@ int pci_user_write_config_##size                                    \
>         ret = dev->bus->ops->write(dev->bus, dev->devfn,                \
>                                         pos, sizeof(type), val);        \
>         raw_spin_unlock_irq(&pci_lock);                         \
> -       if (ret > 0)                                                    \
> -               ret = -EINVAL;                                          \
> -       return ret;                                                     \
> +       return pcibios_err_to_errno(ret);                               \
>  }                                                                      \
>  EXPORT_SYMBOL_GPL(pci_user_write_config_##size);
>
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index aab57b4..1682cb1 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -518,7 +518,7 @@ static inline int pcibios_err_to_errno(int err)
>         case PCIBIOS_FUNC_NOT_SUPPORTED:
>                 return -ENOENT;
>         case PCIBIOS_BAD_VENDOR_ID:
> -               return -EINVAL;
> +               return -ENOTTY;
>         case PCIBIOS_DEVICE_NOT_FOUND:
>                 return -ENODEV;
>         case PCIBIOS_BAD_REGISTER_NUMBER:
> @@ -527,9 +527,11 @@ static inline int pcibios_err_to_errno(int err)
>                 return -EIO;
>         case PCIBIOS_BUFFER_TOO_SMALL:
>                 return -ENOSPC;
> +       default:
> +               return -err;
>         }
>
> -       return -ENOTTY;
> +       return -ERANGE;
>  }
>
>  /* Low-level architecture-dependent routines */
> --
> 1.8.3.2
>
