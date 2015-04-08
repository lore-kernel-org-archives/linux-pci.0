Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49401 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752973AbbDHWQi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 8 Apr 2015 18:16:38 -0400
Date: Thu, 9 Apr 2015 00:16:34 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Fam Zheng <famz@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v5 00/10] pci: fix unhandled interrupt on shutdown
Message-ID: <20150408164704-mutt-send-email-mst@redhat.com>
References: <1427641227-7574-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427641227-7574-1-git-send-email-mst@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Mar 29, 2015 at 05:01:35PM +0200, Michael S. Tsirkin wrote:
> Fam Zheng noticed that pci shutdown disables msi and msix of a device while
> device is still active. This was intended to fix kexec with fusion devices but
> had the unintended effect of breaking even regular shutdown when using virtio.
> 
> The same problem would affect any driver which doesn't register
> a level interrupt handler when using msix.
> 
> I think the fix is to avoid touching device on shutdown:
> we clear bus master anyway, so we won't get any more
> msi interrupts, and bus reset will clear the msi/msix
> state eventually anyway.
> 
> Patches 1-6 work well for me.
> Given they affect all pci devices, and the bug has been there since 2.6 times,
> I think there's no rush: we can merge them for 4.1.
> 
> At the same time, once merged, patches 1-4 will likely make a good stable
> candidate: the problem was actually observed in the field,
> although the BZ in question isn't public yet.
> Patches 7-10 compiled only, will need maintainer ack.

Looks like people don't bother to review until it's merged.

Bjorn, what do you think about this patchset?
Could you merge it for 4.1?


> 
> Please review, and consider at least 1-6 for 4.1.
> 
> changes from v4:
> 	Yijing Wang <wangyijing@huawei.com> noted that
> 	early fixups rely on pci_msi_off.
> 	Split out the functionality and move off the
> 	required part to run early during pci_device_setup.
> Changes from v3:
> 	fix a copy-and-paste error in
> 	  pci: drop some duplicate code
> 	other patches are unchanged
> 	drop Cc stable for now
> Changes from v2:
> 	move code from probe to device enumeration
> 	add patches to unexport pci_msi_off
> 
> Michael S. Tsirkin (10):
>   pci: export functions for msi/msix ctrl
>   pci: move pci_msi_init_pci_dev to pci.c
>   pci: drop some duplicate code
>   pci: don't disable msi/msix at shutdown
>   pci: make msi/msix shutdown functions static
>   virtio_pci: drop msi_off on probe
>   ntb: drop pci_msi_off call on probe
>   mic: drop pci_msi_off call on probe
>   pci: drop pci_msi_off calls from quirks
>   pci: unexport pci_msi_off
> 
>  drivers/pci/pci.h                  | 25 +++++++++++++++++
>  include/linux/pci.h                |  5 ----
>  drivers/misc/mic/host/mic_intr.c   |  2 --
>  drivers/ntb/ntb_hw.c               |  2 --
>  drivers/pci/msi.c                  | 57 ++++++++------------------------------
>  drivers/pci/pci-driver.c           |  2 --
>  drivers/pci/pci.c                  | 25 ++++-------------
>  drivers/pci/probe.c                | 15 ++++++++++
>  drivers/pci/quirks.c               |  2 --
>  drivers/virtio/virtio_pci_common.c |  3 --
>  10 files changed, 57 insertions(+), 81 deletions(-)
> 
> -- 
> MST
> 
