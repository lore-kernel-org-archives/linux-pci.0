Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38342 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932223AbbCPR7J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 16 Mar 2015 13:59:09 -0400
Date: Mon, 16 Mar 2015 18:59:00 +0100
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Fam Zheng <famz@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>,
	Ulrich Obergfell <uobergfe@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH RFC 1/4] pci: disable msi/msix at probe time
Message-ID: <20150316185535-mutt-send-email-mst@redhat.com>
References: <1426526415-13299-1-git-send-email-mst@redhat.com>
 <1426526415-13299-2-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426526415-13299-2-git-send-email-mst@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 16, 2015 at 06:20:27PM +0100, Michael S. Tsirkin wrote:
> commit d52877c7b1afb8c37ebe17e2005040b79cb618b0
>     pci/irq: let pci_device_shutdown to call pci_msi_shutdown v2
> 
> attempted to address the problem of kexec getting
> started after linux enabled msi/msix for a device,
> and drivers being confused by msi being enabled,
> by disabling msi at shutdown.
> 
> But arguably, it's better to disable msi/msix when kexec
> starts - for example, kexec might run after a crash (kdump)
> and shutdown callbacks are not always invoked in that case.
> 
> Cc: Yinghai Lu <yhlu.kernel.send@gmail.com>
> Cc: Ulrich Obergfell <uobergfe@redhat.com>
> Cc: Fam Zheng <famz@redhat.com>
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/pci/pci-driver.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 3cb2210..dac6d47 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -305,6 +305,12 @@ static long local_pci_probe(void *_ddi)
>  	 */
>  	pm_runtime_get_sync(dev);
>  	pci_dev->driver = pci_drv;
> +	/*
> +	 * When using kexec, msi might be left enabled by the previous kernel,
> +	 * this breaks things as some drivers assume msi/msi-x is off at boot.
> +	 * Fix this by forcing msi off at startup.
> +	 */
> +	pci_msi_off(dev);

should be
	pci_msi_off(pci_dev);

obviously.

Which likely means I pushed a wrong tree
to the test machine again, so this wasn't
tested as I thought it is :(

I'll re-test and repost day after tomorrow,
Fam, can you tweak this manually when you are testing?
I don't want to spam the list.

>  	rc = pci_drv->probe(pci_dev, ddi->id);
>  	if (!rc)
>  		return rc;
> -- 
> MST
> 
