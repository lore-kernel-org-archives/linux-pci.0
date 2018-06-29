Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <1530214274-21139-4-git-send-email-okaya@codeaurora.org>
References: <1530214274-21139-1-git-send-email-okaya@codeaurora.org>
 <1530214274-21139-4-git-send-email-okaya@codeaurora.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 30 Jun 2018 00:43:32 +0300
Message-ID: <CAHp75VcYbeRTiggEiQnEV6DKR=F47RxNR0FZ+E-XKPpq8VNpqw@mail.gmail.com>
Subject: Re: [PATCH V4 4/7] PCI: Unify try slot and bus reset API
To: Sinan Kaya <okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>,
 "open list:VFIO DRIVER" <kvm@vger.kernel.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, linux-pci@vger.kernel.org,
 Dennis Dalessandro <dennis.dalessandro@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 open list <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Doug Ledford <dledford@redhat.com>, Zhenyu Wang <zhenyuw@linux.intel.com>,
 linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 28, 2018 at 10:31 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> Drivers are expected to call pci_try_reset_slot() or pci_try_reset_bus() by
> querying if a system supports hotplug or not. A survey showed that most
> drivers don't do this and we are leaking hotplug capability to the user.
>
> Hide pci_try_slot_reset() from drivers and embed into pci_try_bus_reset().
> Change pci_try_reset_bus() parameter from struct pci_bus to struct pci_dev.

> +/**
> + * pci_try_reset_bus - Try to reset a PCI bus
> + * @pdev: top level PCI device to reset via slot/bus
> + *
> + * Same as above except return -EAGAIN if the bus cannot be locked
> + */
> +int pci_try_reset_bus(struct pci_dev *pdev)
> +{
> +       bool slot = false;
> +
> +       if (!pci_probe_reset_slot(pdev->slot))
> +               slot = true;
> +
> +       return slot ? __pci_try_reset_slot(pdev->slot) :
> +                       __pci_try_reset_bus(pdev->bus);

This can be as simple as

  return pci_probe_reset_slot(pdev->slot) ?
    __pci_try_reset_bus(pdev->slot) : __pci_try_reset_slot(pdev->bus);


> +}
>  EXPORT_SYMBOL_GPL(pci_try_reset_bus);


-- 
With Best Regards,
Andy Shevchenko

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
