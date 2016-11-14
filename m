Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752754AbcKNWlh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Nov 2016 17:41:37 -0500
Date: Mon, 14 Nov 2016 16:41:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: keith.busch@intel.com, linux-pci@vger.kernel.org
Subject: Re: [PATCHv2] PCI/VMD: Use SRCU as a local RCU to prevent delaying
 global RCU
Message-ID: <20161114224132.GL9868@bhelgaas-glaptop.roam.corp.google.com>
References: <1478905725-219032-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478905725-219032-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 11, 2016 at 04:08:45PM -0700, Jon Derrick wrote:
> SRCU lets synchronize_srcu depend on VMD-local RCU primitives,
> preventing long delays from locking up RCU in other systems. VMD
> performs a synchronize when removing a device, but will hit all irq
> lists if the device uses all VMD vectors. This patch will not help VMD's
> RCU synchronization, but will isolate the read side delays to the VMD
> subsystem. Additionally, the use of SRCU in VMD's isr will keep it
> isolated from any other RCU waiters in the rest of the system.
> 
> The patch was tested using concurrent fio and nvme resets:
> [global]
> rw=read
> bs=4k
> direct=1
> ioengine=libaio
> iodepth=32
> norandommap
> timeout=300
> runtime=1000000000
> 
> [nvme0]
> cpus_allowed=0-63
> numjobs=8
> filename=/dev/nvme0n1
> 
> [nvme1]
> cpus_allowed=0-63
> numjobs=8
> filename=/dev/nvme1n1
> 
> while (true) do
> 	for i in /sys/class/nvme/nvme*; do
> 		echo "Resetting ${i##*/}"
> 		echo 1 > $i/reset_controller;
> 		sleep 5
> 	done;
> done
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

Applied with Keith's reviewed-by to pci/host-vmd for v4.10, thanks!

> ---
> v1->v2: Kconfig depends on SRCU
> 
>  drivers/pci/host/Kconfig |  2 +-
>  drivers/pci/host/vmd.c   | 26 ++++++++++++++++++++------
>  2 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index d7e7c0a..e020359 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -286,7 +286,7 @@ config PCIE_ROCKCHIP
>  	  4 slots.
>  
>  config VMD
> -	depends on PCI_MSI && X86_64
> +	depends on PCI_MSI && X86_64 && SRCU
>  	tristate "Intel Volume Management Device Driver"
>  	default N
>  	---help---
> diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
> index 6614b3552..af4eca2 100644
> --- a/drivers/pci/host/vmd.c
> +++ b/drivers/pci/host/vmd.c
> @@ -19,6 +19,7 @@
>  #include <linux/module.h>
>  #include <linux/msi.h>
>  #include <linux/pci.h>
> +#include <linux/srcu.h>
>  #include <linux/rculist.h>
>  #include <linux/rcupdate.h>
>  
> @@ -39,7 +40,6 @@
>  /**
>   * struct vmd_irq - private data to map driver IRQ to the VMD shared vector
>   * @node:	list item for parent traversal.
> - * @rcu:	RCU callback item for freeing.
>   * @irq:	back pointer to parent.
>   * @enabled:	true if driver enabled IRQ
>   * @virq:	the virtual IRQ value provided to the requesting driver.
> @@ -49,7 +49,6 @@
>   */
>  struct vmd_irq {
>  	struct list_head	node;
> -	struct rcu_head		rcu;
>  	struct vmd_irq_list	*irq;
>  	bool			enabled;
>  	unsigned int		virq;
> @@ -58,11 +57,13 @@ struct vmd_irq {
>  /**
>   * struct vmd_irq_list - list of driver requested IRQs mapping to a VMD vector
>   * @irq_list:	the list of irq's the VMD one demuxes to.
> + * @srcu:	SRCU struct for local synchronization.
>   * @count:	number of child IRQs assigned to this vector; used to track
>   *		sharing.
>   */
>  struct vmd_irq_list {
>  	struct list_head	irq_list;
> +	struct srcu_struct	srcu;
>  	unsigned int		count;
>  };
>  
> @@ -224,14 +225,14 @@ static void vmd_msi_free(struct irq_domain *domain,
>  	struct vmd_irq *vmdirq = irq_get_chip_data(virq);
>  	unsigned long flags;
>  
> -	synchronize_rcu();
> +	synchronize_srcu(&vmdirq->irq->srcu);
>  
>  	/* XXX: Potential optimization to rebalance */
>  	raw_spin_lock_irqsave(&list_lock, flags);
>  	vmdirq->irq->count--;
>  	raw_spin_unlock_irqrestore(&list_lock, flags);
>  
> -	kfree_rcu(vmdirq, rcu);
> +	kfree(vmdirq);
>  }
>  
>  static int vmd_msi_prepare(struct irq_domain *domain, struct device *dev,
> @@ -646,11 +647,12 @@ static irqreturn_t vmd_irq(int irq, void *data)
>  {
>  	struct vmd_irq_list *irqs = data;
>  	struct vmd_irq *vmdirq;
> +	int idx;
>  
> -	rcu_read_lock();
> +	idx = srcu_read_lock(&irqs->srcu);
>  	list_for_each_entry_rcu(vmdirq, &irqs->irq_list, node)
>  		generic_handle_irq(vmdirq->virq);
> -	rcu_read_unlock();
> +	srcu_read_unlock(&irqs->srcu, idx);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -696,6 +698,10 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  		return -ENOMEM;
>  
>  	for (i = 0; i < vmd->msix_count; i++) {
> +		err = init_srcu_struct(&vmd->irqs[i].srcu);
> +		if (err)
> +			return err;
> +
>  		INIT_LIST_HEAD(&vmd->irqs[i].irq_list);
>  		err = devm_request_irq(&dev->dev, pci_irq_vector(dev, i),
>  				       vmd_irq, 0, "vmd", &vmd->irqs[i]);
> @@ -714,11 +720,19 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	return 0;
>  }
>  
> +static void vmd_cleanup_srcu(struct vmd_dev *vmd)
> +{
> +	int i;
> +	for (i = 0; i < vmd->msix_count; i++)
> +		cleanup_srcu_struct(&vmd->irqs[i].srcu);
> +}
> +
>  static void vmd_remove(struct pci_dev *dev)
>  {
>  	struct vmd_dev *vmd = pci_get_drvdata(dev);
>  
>  	vmd_detach_resources(vmd);
> +	vmd_cleanup_srcu(vmd);
>  	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
>  	pci_stop_root_bus(vmd->bus);
>  	pci_remove_root_bus(vmd->bus);
> -- 
> 1.8.3.1
> 
