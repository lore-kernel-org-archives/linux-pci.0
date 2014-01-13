Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:42205 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbaAMSMm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jan 2014 13:12:42 -0500
Received: by mail-ig0-f182.google.com with SMTP id uy17so3331999igb.3
        for <linux-pci@vger.kernel.org>; Mon, 13 Jan 2014 10:12:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20140111012718.14505.95825.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140111012339.14505.40203.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20140111012718.14505.95825.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 13 Jan 2014 11:12:20 -0700
Message-ID: <CAErSpo5A=Zi2z08XPadt+0KbniwCT1es6HczjCD9X3MT5k_vzg@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] PCI: Remove unused exclusive region support
To: Stephen Hemminger <stephen@networkplumber.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: Yu Zhao <yu.zhao@intel.com>,
	Arjan van de Ven <arjan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 10, 2014 at 6:27 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> From: Stephen Hemminger <stephen@networkplumber.org>
>
> My philosophy is unused code is dead code.  And dead code is subject to bit
> rot and is a likely source of bugs.  Use it or lose it.
>
> This reverts part of e8de1481fd71 ("resource: allow MMIO exclusivity for
> device drivers"), removing these interfaces:
>
>     pci_request_region_exclusive()
>     pci_request_regions_exclusive()
>
> [bhelgaas: split to separate patch, also remove prototypes from pci.h]
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: Arjan van de Ven <arjan@linux.intel.com>

I think I'm going to drop this patch for now and propose that we
instead revert e8de1481fd71 completely.  As far as I can tell, e1000e
is the only driver that  uses any of this, and that's only because of
the bug hunt, not because e1000e is special in any way.

Bjorn

> ---
>  drivers/pci/pci.c   |   46 ----------------------------------------------
>  include/linux/pci.h |    2 --
>  2 files changed, 48 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 6db2f1a441e9..730471a74fba 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2443,28 +2443,6 @@ int pci_request_region(struct pci_dev *pdev, int bar, const char *res_name)
>  }
>
>  /**
> - *     pci_request_region_exclusive - Reserved PCI I/O and memory resource
> - *     @pdev: PCI device whose resources are to be reserved
> - *     @bar: BAR to be reserved
> - *     @res_name: Name to be associated with resource.
> - *
> - *     Mark the PCI region associated with PCI device @pdev BR @bar as
> - *     being reserved by owner @res_name.  Do not access any
> - *     address inside the PCI regions unless this call returns
> - *     successfully.
> - *
> - *     Returns 0 on success, or %EBUSY on error.  A warning
> - *     message is also printed on failure.
> - *
> - *     The key difference that _exclusive makes it that userspace is
> - *     explicitly not allowed to map the resource via /dev/mem or
> - *     sysfs.
> - */
> -int pci_request_region_exclusive(struct pci_dev *pdev, int bar, const char *res_name)
> -{
> -       return __pci_request_region(pdev, bar, res_name, IORESOURCE_EXCLUSIVE);
> -}
> -/**
>   * pci_release_selected_regions - Release selected PCI I/O and memory resources
>   * @pdev: PCI device whose resources were previously reserved
>   * @bars: Bitmask of BARs to be released
> @@ -2552,28 +2530,6 @@ int pci_request_regions(struct pci_dev *pdev, const char *res_name)
>         return pci_request_selected_regions(pdev, ((1 << 6) - 1), res_name);
>  }
>
> -/**
> - *     pci_request_regions_exclusive - Reserved PCI I/O and memory resources
> - *     @pdev: PCI device whose resources are to be reserved
> - *     @res_name: Name to be associated with resource.
> - *
> - *     Mark all PCI regions associated with PCI device @pdev as
> - *     being reserved by owner @res_name.  Do not access any
> - *     address inside the PCI regions unless this call returns
> - *     successfully.
> - *
> - *     pci_request_regions_exclusive() will mark the region so that
> - *     /dev/mem and the sysfs MMIO access will not be allowed.
> - *
> - *     Returns 0 on success, or %EBUSY on error.  A warning
> - *     message is also printed on failure.
> - */
> -int pci_request_regions_exclusive(struct pci_dev *pdev, const char *res_name)
> -{
> -       return pci_request_selected_regions_exclusive(pdev,
> -                                       ((1 << 6) - 1), res_name);
> -}
> -
>  static void __pci_set_master(struct pci_dev *dev, bool enable)
>  {
>         u16 old_cmd, cmd;
> @@ -4183,10 +4139,8 @@ EXPORT_SYMBOL(pci_find_capability);
>  EXPORT_SYMBOL(pci_bus_find_capability);
>  EXPORT_SYMBOL(pci_release_regions);
>  EXPORT_SYMBOL(pci_request_regions);
> -EXPORT_SYMBOL(pci_request_regions_exclusive);
>  EXPORT_SYMBOL(pci_release_region);
>  EXPORT_SYMBOL(pci_request_region);
> -EXPORT_SYMBOL(pci_request_region_exclusive);
>  EXPORT_SYMBOL(pci_release_selected_regions);
>  EXPORT_SYMBOL(pci_request_selected_regions);
>  EXPORT_SYMBOL(pci_request_selected_regions_exclusive);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index f2284f1332db..efd0b8b67705 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1026,10 +1026,8 @@ void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
>                     int (*)(const struct pci_dev *, u8, u8));
>  #define HAVE_PCI_REQ_REGIONS   2
>  int __must_check pci_request_regions(struct pci_dev *, const char *);
> -int __must_check pci_request_regions_exclusive(struct pci_dev *, const char *);
>  void pci_release_regions(struct pci_dev *);
>  int __must_check pci_request_region(struct pci_dev *, int, const char *);
> -int __must_check pci_request_region_exclusive(struct pci_dev *, int, const char *);
>  void pci_release_region(struct pci_dev *, int);
>  int pci_request_selected_regions(struct pci_dev *, int, const char *);
>  int pci_request_selected_regions_exclusive(struct pci_dev *, int, const char *);
>
