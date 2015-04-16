Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:34066 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063AbbDPTmt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Apr 2015 15:42:49 -0400
Received: by iget9 with SMTP id t9so15363325ige.1
        for <linux-pci@vger.kernel.org>; Thu, 16 Apr 2015 12:42:49 -0700 (PDT)
Date: Thu, 16 Apr 2015 14:42:45 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Ulrich Obergfell <uobergfe@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v6 04/10] PCI/MSI: Don't disable MSI/MSI-X at shutdown
Message-ID: <20150416194245.GB20701@google.com>
References: <20150410223533.20848.95316.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150410225446.20848.51279.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150413093708.GE17059@ad.nay.redhat.com>
 <CAErSpo7ARr7GHNUCMAa04Mk-cG-dufE=_ajB1txTuGRxzCqZwA@mail.gmail.com>
 <87twwkugd0.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87twwkugd0.fsf@x220.int.ebiederm.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 13, 2015 at 11:45:31AM -0500, Eric W. Biederman wrote:
> ...
> The thing is not disabling msi interrupts for the case described in the
> buzilla report is the wrong fix.
> 
> The report is about a buggy driver doing the wrong thing.  Until someone
> ships a system that is msi native (aka no intx support) disabling msi
> interrupts as shutdown is the right thing to do.  If there is something
> that handles intx interrupts it is not an msi native system.
> 
> The real bug is probably disabling bugging interrupt detection on the
> kernel command line.
> 
> Beyond that to handle kexec cleanly something needs to stop the
> interrupts and stop the the DMA transfers.   Which in the short term
> means someone probably needs to write a shutdown method for the buggy
> driver.
> 
> An interrupt coming in almost always implies a DMA having completed,
> and if that DMA completed in the wrong spot the kexec'd kernel will be
> toast.
> 
> We disable interrupts at boot so that a kernel started with
> kexec-on-panic (which doesn't shut anything down) can boot.  There are
> probably other valid use cases (like native msi interrupts) but I am not
> aware of them.  But according to the pci spec shutting down msi
> interrupts at boot should be a noop.
> 
> So in summary not disabling MSI/MSI-X at shutdown is the wrong fix,
> and someone needs to fix a buggy driver.

Are you saying that:

  - pci_device_shutdown() should continue to call pci_msi_shutdown() and
    pci_msix_shutdown() as it does today, and

  - virtio_pci_driver should implement a .shutdown method?

I'm missing a lot of the context, and this is really outside my normal
sphere, so I'm trying to figure out the scenario we're talking about.
Here's my pitiful guess (Michael/Fam, please correct me where I'm wrong):

  qemu emulates machine with virtio device X, e.g., [1af4:1001]

  guest Linux startup
    guest virtio-pci driver claims device X
      virtio_pci_probe
	register_virtio_device		# adds new device Y on virtio_bus

  guest Linux virtblk_probe		# virtio_driver.probe for device Y
    init_vq
      ...
	vp_find_vqs
	  vp_try_to_find_vqs
	    vp_request_msix_vectors
	      pci_enable_msix_exact	# enables MSI-X for qemu virtio device X
	      request_irq(..., vp_config_changed, ...)

  guest Linux shutdown
    kernel_halt
      ...
	pci_device_shutdown		# device X
	  drv->shutdown
	  pci_msi_shutdown
	  pci_msix_shutdown
	    clear PCI_MSIX_FLAGS_ENABLE

  qemu virtio device X generates interrupt
    virtio_pci_notify
      if (!msix_enabled)		# qemu reads MSIX_ENABLE_MASK
	pci_set_irq
	  pci_irq_handler		# assert INTx in guest

  guest Linux virtio-pci has no ISR for INTx

So now the guest Linux has INTx asserted, but it has no ISR for it, so the
CPU receiving the IRQ is stuck calling do_IRQ() endlessly.

Bjorn
