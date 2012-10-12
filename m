Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:43624 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755828Ab2JLAPZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 11 Oct 2012 20:15:25 -0400
Received: by mail-qc0-f174.google.com with SMTP id d3so1837695qch.19
        for <linux-pci@vger.kernel.org>; Thu, 11 Oct 2012 17:15:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1349957007-9920-1-git-send-email-wangyijing@huawei.com>
References: <1349957007-9920-1-git-send-email-wangyijing@huawei.com>
Date: Thu, 11 Oct 2012 17:15:24 -0700
Message-ID: <CAPoiz9zYt6givdPEu7nMumSSJp6-o098_YnAQ3RmPi8s6ZUE4g@mail.gmail.com>
Subject: Re: [PATCH V2] PCI: print pcie max_payload_size default setting info
 to help diagnosis
From: Jon Mason <jdmason@kudzu.us>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jon Mason <jon.mason@intel.com>, linux-pci@vger.kernel.org,
	Hanjun Guo <guohanjun@huawei.com>, jiang.liu@huawei.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 11, 2012 at 5:03 AM, Yijing Wang <wangyijing@huawei.com> wrote:
> PCIe device mps maybe not equal to its bridge mps after doing hotplug.
> This may result unexpected problem like
> http://marc.info/?l=linux-scsi&m=134788365823217&w=2. So add mps log for current
> mps setting to help diagnosis an issue like this.
>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/pci/probe.c |   29 +++++++++++++++++++++++++++++
>  1 files changed, 29 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ec909af..a31e615 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1533,6 +1533,33 @@ static void pcie_write_mrrs(struct pci_dev *dev)
>                         "with pci=pcie_bus_safe.\n");
>  }
>
> +static int pcie_mps_info(struct pci_dev *dev, void *data)
> +{
> +       int mps, mpss;
> +
> +       if (!pci_is_pcie(dev))
> +               return -EINVAL;
> +
> +       mps = pcie_get_mps(dev);
> +       mpss = 128 << dev->pcie_mpss;
> +       dev_printk(KERN_DEBUG, &dev->dev, "PCI-E Max_Payload_Size Supported %d, "
> +                       "Max_Payload_Size %d\n", mpss, mps);
> +
> +       return 0;
> +}
> +
> +static void pcie_dump_mps_info(struct pci_bus *bus)
> +{
> +       int mps, mpss;
> +
> +       mps = pcie_get_mps(bus->self);
> +       mpss = 128 << bus->self->pcie_mpss;
> +       dev_printk(KERN_DEBUG, &bus->self->dev, "PCI-E Max_Payload_Size Supported %d, "
> +               "Max_Payload_Size %d\n", mpss, mps);
> +
> +       pci_walk_bus(bus, pcie_mps_info, NULL);
> +}
> +
>  static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
>  {
>         int mps, orig_mps;
> @@ -1564,6 +1591,8 @@ void pcie_bus_configure_settings(struct pci_bus *bus, u8 mpss)
>         if (!pci_is_pcie(bus->self))
>                 return;
>
> +       pcie_dump_mps_info(bus);
> +

The patch looks fine, but a better way of doing things would be to
create a new default pcie_bus_config state (PCIE_BUS_WARN) that:
* prints the default MPS of the device
* prints the suggested MPS
* notifies the user that they would be better off running
PCIE_BUS_SAFE (if that is the case).

I have a rough version of this in my tree already.  I'll try and push
it out tonight.

Thanks,
Jon


>         if (pcie_bus_config == PCIE_BUS_TUNE_OFF)
>                 return;
>
> --
> 1.7.1
>
>
