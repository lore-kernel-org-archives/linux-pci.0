Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41350 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754212AbbDPHaX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 16 Apr 2015 03:30:23 -0400
Date: Thu, 16 Apr 2015 09:30:18 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fam Zheng <famz@redhat.com>, linux-pci@vger.kernel.org,
	Rusty Russell <rusty@rustcorp.com.au>,
	Ulrich Obergfell <uobergfe@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v6 04/10] PCI/MSI: Don't disable MSI/MSI-X at shutdown
Message-ID: <20150416092325-mutt-send-email-mst@redhat.com>
References: <20150410223533.20848.95316.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150410225446.20848.51279.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150410225446.20848.51279.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

OK, a couple more tweaks to the changelog.

On Fri, Apr 10, 2015 at 05:54:47PM -0500, Bjorn Helgaas wrote:
> From: Michael S. Tsirkin <mst@redhat.com>
> 
> d52877c7b1af ("pci/irq: let pci_device_shutdown to call pci_msi_shutdown
> v2") disabled MSI/MSI-X at device shutdown to address a kexec problem.
> 
> The problem is that after we disable MSI, the device may assert INTx, and
> if the driver hasn't registered an interrupt handler for it, the interrupt
> is never deasserted and causes a kernel hang.

I think we should drop "and causes a kernel hang" from this sentence:
most configurations can work around this by disabling the irq
line in the apic.

>  In particular, this was
> observed with virtio.
> 
> We now disable MSI/MSI-X for all devices during enumeration regardless of
> CONFIG_PCI_MSI.  This solves the kexec problem in the new kernel, not the
> old one.
> 
> Stop disabling MSIs at shutdown to avoid the kernel hang.

And replace this one with:
  Stop disabling MSIs at shutdown to avoid conflicting with
  drivers.


> XXX bugzilla reference, details about how the hang happens?

Add:
See bugzilla https://bugzilla.kernel.org/show_bug.cgi?id=96571
(that one's for a kernel that lacks
 1e77d0a1ed7417d2a5a52a7b8d32aea1833faa6c, so
 it doesn't recover by disabling the irq line).

> 
> [bhelgaas: changelog]
> Reported-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: Yinghai Lu <yhlu.kernel.send@gmail.com>
> CC: Ulrich Obergfell <uobergfe@redhat.com>
> CC: Rusty Russell <rusty@rustcorp.com.au>
> ---
>  drivers/pci/pci-driver.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 3cb2210de553..38a602cb9fb7 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -450,8 +450,6 @@ static void pci_device_shutdown(struct device *dev)
>  
>  	if (drv && drv->shutdown)
>  		drv->shutdown(pci_dev);
> -	pci_msi_shutdown(pci_dev);
> -	pci_msix_shutdown(pci_dev);
>  
>  #ifdef CONFIG_KEXEC
>  	/*
