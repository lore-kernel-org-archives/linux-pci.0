Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:59055 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751071AbdBOLZQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Feb 2017 06:25:16 -0500
Subject: Re: [PATCH] PCI/PME: Restore pcie_pme_driver.remove
To: Yinghai Lu <yinghai@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20170215051748.3346-1-yinghai@kernel.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Message-ID: <eca6b976-1577-8578-5b1d-9b22c78253c1@intel.com>
Date: Wed, 15 Feb 2017 12:25:12 +0100
MIME-Version: 1.0
In-Reply-To: <20170215051748.3346-1-yinghai@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2/15/2017 6:17 AM, Yinghai Lu wrote:
> Found 4.9 and later, removing pci device for pcie port via /sys failed:
> ------------[ cut here ]------------
> kernel BUG at drivers/pci/msi.c:370!
> invalid opcode: 0000 [#1] SMP
> Modules linked in:
> CPU: 1 PID: 14509 Comm: sh Tainted: G    W  4.8.0-rc1-yh-00012-gd29438d
> RIP: 0010:[<ffffffff9758bbf5>]  free_msi_irqs+0x65/0x190
> ...
> Call Trace:
>   [<ffffffff9758cda4>] pci_disable_msi+0x34/0x40
>   [<ffffffff97583817>] cleanup_service_irqs+0x27/0x30
>   [<ffffffff97583e9a>] pcie_port_device_remove+0x2a/0x40
>   [<ffffffff97584250>] pcie_portdrv_remove+0x40/0x50
>   [<ffffffff97576d7b>] pci_device_remove+0x4b/0xc0
>   [<ffffffff9785ebe6>] __device_release_driver+0xb6/0x150
>   [<ffffffff9785eca5>] device_release_driver+0x25/0x40
>   [<ffffffff975702e4>] pci_stop_bus_device+0x74/0xa0
>   [<ffffffff975704ea>] pci_stop_and_remove_bus_device_locked+0x1a/0x30
>   [<ffffffff97578810>] remove_store+0x50/0x70
>   [<ffffffff9785a378>] dev_attr_store+0x18/0x30
>   [<ffffffff97260b64>] sysfs_kf_write+0x44/0x60
>   [<ffffffff9725feae>] kernfs_fop_write+0x10e/0x190
>   [<ffffffff971e13f8>] __vfs_write+0x28/0x110
>   [<ffffffff970b0fa4>] ? percpu_down_read+0x44/0x80
>   [<ffffffff971e53a7>] ? __sb_start_write+0xa7/0xe0
>   [<ffffffff971e53a7>] ? __sb_start_write+0xa7/0xe0
>   [<ffffffff971e1f04>] vfs_write+0xc4/0x180
>   [<ffffffff971e3089>] SyS_write+0x49/0xa0
>   [<ffffffff97001a46>] do_syscall_64+0xa6/0x1b0
>   [<ffffffff9819201e>] entry_SYSCALL64_slow_path+0x25/0x25
> ...
>   RIP  [<ffffffff9758bbf5>] free_msi_irqs+0x65/0x190
>   RSP <ffff89ad3085bc48>
> ---[ end trace f4505e1dac5b95d3 ]---
> Segmentation fault
>
> Bisect to commit d7def2040077 ("PCI/PME: Make explicitly non-modular").
> That commit did extra thing like remove the .remove for pcie_pme_driver.
>
> Put back pcie_pme_remove and restore to pcie_pme_driver fix the problem.
>
> Fixes: d7def2040077 ("PCI/PME: Make explicitly non-modular")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>

ACK

> diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
> index 7175293..2dd1c68 100644
> --- a/drivers/pci/pcie/pme.c
> +++ b/drivers/pci/pcie/pme.c
> @@ -433,6 +433,17 @@ static int pcie_pme_resume(struct pcie_device *srv)
>   	return 0;
>   }
>   
> +/**
> + * pcie_pme_remove - Prepare PCIe PME service device for removal.
> + * @srv - PCIe service device to remove.
> + */
> +static void pcie_pme_remove(struct pcie_device *srv)
> +{
> +	pcie_pme_suspend(srv);
> +	free_irq(srv->irq, srv);
> +	kfree(get_service_data(srv));
> +}
> +
>   static struct pcie_port_service_driver pcie_pme_driver = {
>   	.name		= "pcie_pme",
>   	.port_type	= PCI_EXP_TYPE_ROOT_PORT,
> @@ -441,6 +452,7 @@ static struct pcie_port_service_driver pcie_pme_driver = {
>   	.probe		= pcie_pme_probe,
>   	.suspend	= pcie_pme_suspend,
>   	.resume		= pcie_pme_resume,
> +	.remove		= pcie_pme_remove,
>   };
>   
>   /**

Thanks,

Rafael
