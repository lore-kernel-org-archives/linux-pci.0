Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:56988 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939Ab3G2SkP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jul 2013 14:40:15 -0400
Received: by mail-oa0-f49.google.com with SMTP id n16so2452997oag.36
        for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2013 11:40:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1375102331-23905-10-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1375102331-23905-1-git-send-email-jeffrey.t.kirsher@intel.com> <1375102331-23905-10-git-send-email-jeffrey.t.kirsher@intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 29 Jul 2013 12:39:54 -0600
Message-ID: <CAErSpo4SML99Gs=oa9m_dS8Bum4WaE-9Jhxc0muRoEHXuKQMDg@mail.gmail.com>
Subject: Re: [net-next 09/15] pci: move enum pcie_link_width into pci.h
To: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: David Miller <davem@davemloft.net>,
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev <netdev@vger.kernel.org>, gospo@redhat.com,
	sassmann@redhat.com,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 29, 2013 at 6:52 AM, Jeff Kirsher
<jeffrey.t.kirsher@intel.com> wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
>
> pcie_link_width is the enum used to define the link width values for a pcie
> device. This enum should not be contained solely in pci_hotplug.h, and this
> patch moves it next to pci_bus_speed in pci.h
>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/linux/pci.h         | 13 +++++++++++++
>  include/linux/pci_hotplug.h | 13 -------------
>  2 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 95ff993..fc2d1fb 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -186,6 +186,19 @@ enum pci_bus_flags {
>         PCI_BUS_FLAGS_NO_MMRBC = (__force pci_bus_flags_t) 2,
>  };
>
> +/* These values come from the PCI Express Spec */
> +enum pcie_link_width {
> +       PCIE_LNK_WIDTH_RESRV    = 0x00,
> +       PCIE_LNK_X1             = 0x01,
> +       PCIE_LNK_X2             = 0x02,
> +       PCIE_LNK_X4             = 0x04,
> +       PCIE_LNK_X8             = 0x08,
> +       PCIE_LNK_X12            = 0x0C,
> +       PCIE_LNK_X16            = 0x10,
> +       PCIE_LNK_X32            = 0x20,
> +       PCIE_LNK_WIDTH_UNKNOWN  = 0xFF,
> +};
> +
>  /* Based on the PCI Hotplug Spec, but some values are made up by us */
>  enum pci_bus_speed {
>         PCI_SPEED_33MHz                 = 0x00,
> diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
> index 8db71dc..64e61e0 100644
> --- a/include/linux/pci_hotplug.h
> +++ b/include/linux/pci_hotplug.h
> @@ -28,19 +28,6 @@
>  #ifndef _PCI_HOTPLUG_H
>  #define _PCI_HOTPLUG_H
>
> -/* These values come from the PCI Express Spec */
> -enum pcie_link_width {
> -       PCIE_LNK_WIDTH_RESRV    = 0x00,
> -       PCIE_LNK_X1             = 0x01,
> -       PCIE_LNK_X2             = 0x02,
> -       PCIE_LNK_X4             = 0x04,
> -       PCIE_LNK_X8             = 0x08,
> -       PCIE_LNK_X12            = 0x0C,
> -       PCIE_LNK_X16            = 0x10,
> -       PCIE_LNK_X32            = 0x20,
> -       PCIE_LNK_WIDTH_UNKNOWN  = 0xFF,
> -};
> -
>  /**
>   * struct hotplug_slot_ops -the callbacks that the hotplug pci core can use
>   * @owner: The module owner of this structure
> --
> 1.7.11.7
>
