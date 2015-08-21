Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:34752 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807AbbHUTOl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2015 15:14:41 -0400
Received: by igui7 with SMTP id i7so24719203igu.1
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2015 12:14:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150821150751.7525.81766.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150821150557.7525.58923.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<20150821150751.7525.81766.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Date: Fri, 21 Aug 2015 12:14:40 -0700
Message-ID: <CAE9FiQWL_6i5o7Jx5__JdhCU0xcpE-96XRxx3eS29k2jdq1Hwg@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI: Set MPS to match upstream bridge
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Keith Busch <keith.busch@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Austin Bolen <Austin_Bolen@dell.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Myron Stowe <mstowe@redhat.com>, Jon Mason <jdmason@kudzu.us>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 21, 2015 at 8:07 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> From: Keith Busch <keith.busch@intel.com>
>
> Firmware typically configures the PCIe fabric with a consistent Max Payload
> Size setting based on the devices present at boot.  A hot-added device
> typically has the power-on default MPS setting (128 bytes), which may not
> match the fabric.
>
> When adding a new device via pci_device_add(), set its Max Payload Size to
> match the upstream bridge (unless PCIe bus tuning is disabled).  Note that
> pcie_bus_configure_settings() may further change MPS based on the tuning
> policy.
>
> This makes it more likely that a hot-added device will work in a system
> with optimized MPS configuration.
>
> If we hot-add a device that only supports 128-byte MPS, it still likely
> won't work because we don't reconfigure the rest of the fabric.  Booting
> with "pci=pcie_bus_peer2peer" is a workaround for this because it sets MPS
> to 128 for everything.
>
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/probe.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index eb32395..f73dd7a 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1278,7 +1278,7 @@ int pci_setup_device(struct pci_dev *dev)
>  static void pci_configure_mps(struct pci_dev *dev)
>  {
>         struct pci_dev *bridge = pci_upstream_bridge(dev);
> -       int mps, p_mps;
> +       int mps, p_mps, rc;
>
>         if (!pci_is_pcie(dev) || !bridge || !pci_is_pcie(bridge))
>                 return;
> @@ -1294,6 +1294,16 @@ static void pci_configure_mps(struct pci_dev *dev)
>                          mps, pci_name(bridge), p_mps);
>                 return;
>         }
> +

you may need add if the pcie_bus_config == PCIE_BUS_DEFAULT here.

we should not  could set mps extra for _SAFE, _PERFORMANCE, _PEER2PEER

other than that.

For those patches:
Acked-by: Yinghai Lu <yinghai@kernel.org>

> +       rc = pcie_set_mps(dev, p_mps);
> +       if (rc) {
> +               dev_warn(&dev->dev, "can't set Max Payload Size to %d; if necessary, use \"pci=pcie_bus_safe\" and report a bug\n",
> +                        p_mps);
> +               return;
> +       }
> +
> +       dev_info(&dev->dev, "Max Payload Size set to %d (was %d, max %d)\n",
> +                p_mps, mps, 128 << dev->pcie_mpss);
>  }
