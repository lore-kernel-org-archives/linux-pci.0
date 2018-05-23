Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 23 May 2018 04:24:31 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org, ryan@finnie.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI/portdrv: do not disable device on remove()
Message-ID: <20180523022431.GA15069@wunner.de>
References: <1527011883-21320-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1527011883-21320-1-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 22, 2018 at 01:58:00PM -0400, Sinan Kaya wrote:
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -409,7 +409,6 @@ void pcie_port_device_remove(struct pci_dev *dev)
>  {
>  	device_for_each_child(&dev->dev, NULL, remove_iter);
>  	pci_free_irq_vectors(dev);
> -	pci_disable_device(dev);
>  }

Shutdown aside, pci_disable_device() is also not called in the ->remove
path with this patch, right?  Seems wrong.  E.g. when unbinding the driver
from the root port device, or when unplugging a port (happens all the time
with Thunderbolt).

Thanks,

Lukas
