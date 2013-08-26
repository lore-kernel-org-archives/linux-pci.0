Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:50129 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599Ab3HZVSz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 26 Aug 2013 17:18:55 -0400
Received: by mail-ie0-f176.google.com with SMTP id s9so5643694iec.7
        for <linux-pci@vger.kernel.org>; Mon, 26 Aug 2013 14:18:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1377505986-7484-2-git-send-email-wangyijing@huawei.com>
References: <1377505986-7484-1-git-send-email-wangyijing@huawei.com> <1377505986-7484-2-git-send-email-wangyijing@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 26 Aug 2013 15:18:34 -0600
Message-ID: <CAErSpo70=Sr2mEmLum_aYQKebTnb8Pfs=QL61vrUDLXhh=e5TQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] PCI: Print warning message if unsafe mps detected
To: Yijing Wang <wangyijing@huawei.com>
Cc: Jon Mason <jdmason@kudzu.us>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Jiang Liu <jiang.liu@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 26, 2013 at 2:33 AM, Yijing Wang <wangyijing@huawei.com> wrote:
> Some broken BIOS configures incorrect mps for devices,
> eg. bridge mps larger than connected Endpoint device mps.
> So TLP packets maybe discarded by Endpoint device.
> These devices may not work normally. Joe Jin reported
> these problems, reference:
> http://lkml.kernel.org/r/4FFA9B96.6040901@oracle.com
> http://lkml.kernel.org/r/509B5038.8090304@oracle.com
> For easy detect this issue, try to detect the unsafe mps
> (unequal mps between device and its bridge device)
> setting. If unsafe mps setting found, print warning message.
>
> Reported-by: Joe Jin <joe.jin@oracle.com>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> Cc: Jon Mason <jdmason@kudzu.us>

Applied with minor tweaks to pci/yijing-mps-v8

> ---
>  drivers/pci/probe.c |   25 ++++++++++++++++++++++---
>  1 files changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 21ca9a1..e442744 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1587,6 +1587,23 @@ static void pcie_write_mrrs(struct pci_dev *dev)
>                         "with pci=pcie_bus_safe.\n");
>  }
>
> +static void pcie_bus_detect_mps(struct pci_dev *dev)
> +{
> +       int mps, p_mps;
> +
> +       if (!dev->bus->self)
> +               return;
> +
> +       mps = pcie_get_mps(dev);
> +       p_mps = pcie_get_mps(dev->bus->self);
> +
> +       if (mps != p_mps)
> +               dev_warn(&dev->dev, "Non-optimal MPS value of %d being used. "
> +                       "If problems are experienced, try running with "
> +                       "pci=pcie_bus_safe.\n", mps);
> +       return;
> +}
> +
>  static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
>  {
>         int mps, orig_mps;
> @@ -1594,6 +1611,11 @@ static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
>         if (!pci_is_pcie(dev))
>                 return 0;
>
> +       if (pcie_bus_config == PCIE_BUS_TUNE_OFF) {
> +               pcie_bus_detect_mps(dev);
> +               return 0;
> +       }
> +
>         mps = 128 << *(u8 *)data;
>         orig_mps = pcie_get_mps(dev);
>
> @@ -1621,9 +1643,6 @@ void pcie_bus_configure_settings(struct pci_bus *bus)
>         if (!pci_is_pcie(bus->self))
>                 return;
>
> -       if (pcie_bus_config == PCIE_BUS_TUNE_OFF)
> -               return;
> -
>         /* FIXME - Peer to peer DMA is possible, though the endpoint would need
>          * to be aware of the MPS of the destination.  To work around this,
>          * simply force the MPS of the entire system to the smallest possible.
> --
> 1.7.1
>
>
