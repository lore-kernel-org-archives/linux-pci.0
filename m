Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:58787 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932885Ab3HNQ71 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 14 Aug 2013 12:59:27 -0400
Received: by mail-wg0-f53.google.com with SMTP id c11so7746284wgh.8
        for <linux-pci@vger.kernel.org>; Wed, 14 Aug 2013 09:59:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1376470912-40264-3-git-send-email-wangyijing@huawei.com>
References: <1376470912-40264-1-git-send-email-wangyijing@huawei.com>
	<1376470912-40264-3-git-send-email-wangyijing@huawei.com>
Date: Wed, 14 Aug 2013 09:59:26 -0700
Message-ID: <CAPoiz9zBktaJTwKuRw2F3QYbYEFF60_An+eK0Hv_hnf1u9oqyA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] PCI: update device mps when doing pci hotplug
From: Jon Mason <jdmason@kudzu.us>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, jiang.liu@huawei.com,
	stable@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 14, 2013 at 2:01 AM, Yijing Wang <wangyijing@huawei.com> wrote:
> Currently we don't update device's mps vaule when doing

Spelling nit, "value"

> pci device hot-add. The hot-added device's mps will be set
> to default value (128B). But the upstream port device's mps
> may be larger than 128B which was set by firmware during
> system bootup. In this case the new added device may not
> work normally. This patch try to update the hot added device
> mps euqal to its parent mps, if device mpss < parent mps,

Spelling nit, "equal".

> print warning.
>
> References: https://bugzilla.kernel.org/show_bug.cgi?id=60671
> Reported-by: Yijing Wang <wangyijing@huawei.com>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: stable@vger.kernel.org # 3.4+
> ---
>  drivers/pci/probe.c |   50 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 49 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 0699ec0..0d47b4a 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1621,6 +1621,45 @@ static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
>         return 0;
>  }
>
> +static int pcie_bus_update_set(struct pci_dev *dev, void *data)
> +{
> +       int mps, p_mps, mpss;
> +       struct pci_dev *parent;
> +
> +       if (!pci_is_pcie(dev) || !dev->bus->self)
> +               return 0;
> +
> +       parent = dev->bus->self;
> +       mps = pcie_get_mps(dev);
> +       p_mps = pcie_get_mps(dev->bus->self);
> +
> +       if (mps >= p_mps)

I'm probably overly paranoid, but I worry what would happen in the >
case.  Should we try and force the device MPS to a sane value or are
we confident that this will never happen?

> +               return 0;
> +
> +       /* we only update the device mps, unless its parent device is root port,
> +        * and it is the only slot directly connected to root port.
> +        */
> +       if ((128 << dev->pcie_mpss) >= p_mps) {
> +               pcie_write_mps(dev, p_mps);
> +       } else if (pci_pcie_type(parent) == PCI_EXP_TYPE_ROOT_PORT &&
> +                       pci_only_one_slot(dev->bus)) {
> +               mpss = 128 << dev->pcie_mpss;

OCD nit, you could move the above line up 4 lines and reuse the
variable in the first if-statement.

> +               pcie_write_mps(parent, mpss);
> +               pcie_write_mps(dev, mpss);
> +       } else {
> +               dev_warn(&dev->dev, "MPS %d MPSS %d both smaller than upstream MPS %d\n"
> +                               "If necessary, use \"pci=pcie_bus_peer2peer\" boot parameter to avoid this problem\n",
> +                               mps, 128 << dev->pcie_mpss, p_mps);
> +       }

Nit, braces are unnecessary in the else.  I think
scripts/checkpatch.pl would've complained if you ran it on the patch.

If you/Bjorn want to disregard my paranoia and nits, it looks fine to me.

> +       return 0;
> +}
> +
> +static void pcie_bus_update_setting(struct pci_bus *bus)
> +{
> +       if (bus->self->is_hotplug_bridge)
> +               pci_walk_bus(bus, pcie_bus_update_set, NULL);
> +}
> +
>  /* pcie_bus_configure_settings requires that pci_walk_bus work in a top-down,
>   * parents then children fashion.  If this changes, then this code will not
>   * work as designed.
> @@ -1632,8 +1671,17 @@ void pcie_bus_configure_settings(struct pci_bus *bus, u8 mpss)
>         if (!pci_is_pcie(bus->self))
>                 return;
>
> -       if (pcie_bus_config == PCIE_BUS_TUNE_OFF)
> +       if (pcie_bus_config == PCIE_BUS_TUNE_OFF) {
> +               /* Sometimes we should update device mps here,
> +                * eg. after hot add, device mps value will be
> +                * set to default(128B), but the upstream port
> +                * mps value may be larger than 128B, if we do
> +                * not update the device mps, it maybe can not
> +                * work normally.
> +                */
> +               pcie_bus_update_setting(bus);
>                 return;
> +       }
>
>         /* FIXME - Peer to peer DMA is possible, though the endpoint would need
>          * to be aware to the MPS of the destination.  To work around this,
> --
> 1.7.1
>
>
