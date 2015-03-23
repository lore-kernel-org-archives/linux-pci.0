Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38886 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751291AbbCWEyb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 23 Mar 2015 00:54:31 -0400
Date: Mon, 23 Mar 2015 12:54:26 +0800
From: Fam Zheng <famz@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Yinghai Lu <yhlu.kernel.send@gmail.com>
Subject: Re: [PATCH v2 0/4] pci: fix unhandled interrupt on shutdown
Message-ID: <20150323045426.GA21164@ad.nay.redhat.com>
References: <1426786724-22241-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426786724-22241-1-git-send-email-mst@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 03/19 19:57, Michael S. Tsirkin wrote:
> Fam Zheng noticed that pci shutdown disables msi and msix of a device while
> device is still active. This was intended to fix kexec with fusion devices but
> had the unintended effect of breaking even regular shutdown when using virtio.

Series:
Reviewed-by: Fam Zheng <famz@redhat.com>

> 
> The same problem would affect any driver which doesn't register
> a level interrupt handler when using msix.
> 
> I think the fix is to avoid touching device on shutdown:
> we clear bus master anyway, so we won't get any more
> msi interrupts, and bus reset will clear the msi/msix
> state eventually anyway.
> 
> The patches seems to all work well for me.  Given they affect all pci devices,
> and the bug has been there since 2.6 times, I think there's no rush: we can
> merge them for 4.1.
> 
> At the same time, once merged, they will likely make a good
> stable candidate.
> 
> Michael S. Tsirkin (4):
>   pci: disable msi/msix at probe time
>   pci: don't disable msi/msix at shutdown
>   pci: make msi/msix shutdown functions static
>   virtio_pci: drop msi_off on probe
> 
>  include/linux/pci.h                | 4 ----
>  drivers/pci/msi.c                  | 4 ++--
>  drivers/pci/pci-driver.c           | 8 ++++++--
>  drivers/virtio/virtio_pci_common.c | 3 ---
>  4 files changed, 8 insertions(+), 11 deletions(-)
> 
> -- 
> MST
> 
