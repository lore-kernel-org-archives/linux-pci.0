Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:63892 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbaACU5t (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jan 2014 15:57:49 -0500
Received: by mail-ie0-f176.google.com with SMTP id at1so16344784iec.21
        for <linux-pci@vger.kernel.org>; Fri, 03 Jan 2014 12:57:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131227132734.2aa9bc16@nehalam.linuxnetplumber.net>
References: <20131227132734.2aa9bc16@nehalam.linuxnetplumber.net>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 3 Jan 2014 13:57:05 -0700
Message-ID: <CAErSpo4Nt73OhvefjNGoD0d-OYZG_7j_=oQn2RtpnuWoPNt0iw@mail.gmail.com>
Subject: Re: [PATCH pci-next 1/2] pci: make local function static
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 27, 2013 at 01:27:34PM -0800, Stephen Hemminger wrote:
> Using 'make namespacecheck' identify code which should be
> declared static. Checked for users in other driver/archs as well.
> Compile tested only.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
>
> ---
> Patch against next branch of pci git
>
>  drivers/pci/access.c              |    3 -
>  drivers/pci/hotplug/pciehp.h      |    1
>  drivers/pci/hotplug/pciehp_core.c |    2
>  drivers/pci/pci.c                 |   56 +++++++++----------
>  drivers/pci/pci.h                 |    2
>  drivers/pci/probe.c               |  111 +++++++++++++++++++-------------------
>  include/linux/pci.h               |    9 ---
>  7 files changed, 86 insertions(+), 98 deletions(-)
>
> --- a/drivers/pci/pci.c 2013-12-27 12:51:57.592814680 -0800
> +++ b/drivers/pci/pci.c 2013-12-27 13:00:54.784294985 -0800
> @@ -265,7 +265,7 @@ int pci_bus_find_capability(struct pci_b
>   * not support it.  Some capabilities can occur several times, e.g., the
>   * vendor-specific capability, and this provides a way to find them all.
>   */
> -int pci_find_next_ext_capability(struct pci_dev *dev, int start, int cap)
> +static int pci_find_next_ext_capability(struct pci_dev *dev, int start, int cap)
>  {
>   u32 header;
>   int ttl;
> @@ -304,7 +304,6 @@ int pci_find_next_ext_capability(struct
>
>   return 0;
>  }
> -EXPORT_SYMBOL_GPL(pci_find_next_ext_capability);

I added pci_find_next_ext_capability() (44a9a36f6be4) because some extended
capabilities can occur several times and pci_find_ext_capability() can only
find the first one.

The only in-tree user of pci_find_next_ext_capability() is
pci_find_ext_capability(), so we *could* make it static.  But I don't
think there's much to gain by making it static, and I'm afraid doing
so will just encourage people to reimplement it in a driver instead of
using the core interface.

I am a bit dubious about the GPL export, though.  I'm sure I copied
that from pci_find_ext_capability(), but I don't know why either one
needs to be GPL.

> --- a/include/linux/pci.h 2013-12-27 12:51:57.592814680 -0800
> +++ b/include/linux/pci.h 2013-12-27 13:03:11.518137906 -0800
> @@ -386,8 +386,6 @@ static inline int pci_channel_offline(st
>   return (pdev->error_state != pci_channel_io_normal);
>  }
>
> -extern struct resource busn_resource;
> -
>  struct pci_host_bridge_window {
>   struct list_head list;
>   struct resource *res; /* host bridge aperture (CPU address) */
> @@ -799,7 +797,6 @@ enum pci_lost_interrupt_reason pci_lost_
>  int pci_find_capability(struct pci_dev *dev, int cap);
>  int pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap);
>  int pci_find_ext_capability(struct pci_dev *dev, int cap);
> -int pci_find_next_ext_capability(struct pci_dev *dev, int pos, int cap);
>  int pci_find_ht_capability(struct pci_dev *dev, int ht_cap);
>  int pci_find_next_ht_capability(struct pci_dev *dev, int pos, int ht_cap);
>  struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
> @@ -864,7 +861,6 @@ static inline int pci_write_config_dword
>  int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val);
>  int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val);
>  int pcie_capability_write_word(struct pci_dev *dev, int pos, u16 val);
> -int pcie_capability_write_dword(struct pci_dev *dev, int pos, u32 val);

I think we should keep this one to preserve the symmetry of this group of
interfaces.  We could argue about whether drivers should be accessing the
PCIe capability directly in the first place (especially to write to it),
but that's a different discussion.

Bjorn
