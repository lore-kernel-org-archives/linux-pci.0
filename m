Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:32921 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757952AbdEOQg3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2017 12:36:29 -0400
Received: by mail-pf0-f175.google.com with SMTP id e193so65703417pfh.0
        for <linux-pci@vger.kernel.org>; Mon, 15 May 2017 09:36:29 -0700 (PDT)
Date: Mon, 15 May 2017 09:36:24 -0700
From: Brian Norris <briannorris@chromium.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        alex.williamson@redhat.com, Jeffy Chen <jeffy.chen@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] pci: Disable master abort while waiting for an FLR to
 complete
Message-ID: <20170515163623.GA15237@google.com>
References: <20170512181107.13853.34680.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170512181107.13853.34680.stgit@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 12, 2017 at 11:13:57AM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This patch is meant to address issues seen when performing on FLR on some
> systems as the long wait can result in a master abort when reading a
> function that is not yet ready.
> 
> To prevent the master abort from being reported up we should disable
> reporting for it while waiting on the reset. Once the reset is completed
> then we can re-enable the master abort for the bus.
> 
> Fixes: 5adecf817dd6 ("PCI: Wait for up to 1000ms after FLR reset")
> 
> Reported-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
> 
> I haven't been able to test this code as I don't have a system that can
> reproduce the issue. The fix itself is based on the issue as reported by
> Brian so I am hoping he can test this on the Samsung Chromebook Plus with
> RK399 OP1 that this was seen on.

FYI, it's "RK3399" not "RK399". No harm done :)

>  drivers/pci/pci.c |   17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7904d02ffdb9..acbdbabeaa0e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3758,14 +3758,31 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
>   */
>  static void pci_flr_wait(struct pci_dev *dev)
>  {
> +	struct pci_dev *bridge = dev->bus->self;
>  	int i = 0;
> +	u16 bctl;
>  	u32 id;
>  
> +	/*
> +	 * Disable MasterAbortMode while we are waiting to avoid reporting
> +	 * bus errors for reading the command register on a device that is
> +	 * not ready (in some architectures)

I assume it's intentional to only do this *after* you've started the
reset (but before you start polling)?

> +	 */
> +	if (bridge) {
> +		pci_read_config_word(bridge, PCI_BRIDGE_CONTROL, &bctl);
> +		pci_write_config_word(bridge, PCI_BRIDGE_CONTROL,
> +				      bctl & ~PCI_BRIDGE_CTL_MASTER_ABORT);
> +	}
> +
>  	do {
>  		msleep(100);
>  		pci_read_config_dword(dev, PCI_COMMAND, &id);

IIUC, the patch works fine, in that I no longer get an abort from the
RC.

>  	} while (i++ < 10 && id == ~0);

BTW, the RK3399 host controller doesn't actually return all 1's on
aborted transactions. So this loop doesn't really work for it at all.

I take it that this (seemingly widely used) pattern all derives from the
PCI spec, which notes:

  "The host bus bridge, in PC compatible systems, must return all 1's on
  a read transaction and discard data on a write transaction when
  terminated with Master-Abort."

RK3399 is far from a "PC compatible system", but I don't know if that's
a real excuse here...

>  
> +	/* restore bridge state */
> +	if (bridge)
> +		pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, bctl);
> +
>  	if (id == ~0)
>  		dev_warn(&dev->dev, "Failed to return from FLR\n");

And there's no actual error code returned here; so since several of the
error cases I can trigger on my hardware seem to never actually recover
(no longer how long I wait and/or poll), it seems like we should
propagate the error upward. Right now, we still unconditionally continue
with the pci_dev_restore(), even though that's doomed to abort too...

So there may be several implementation bugs with RK3399. I don't know
how much can be fixed on Rockchip's side, vs. how much can be
accomodated in the PCI core.

Brian

>  	else if (i > 1)
> 
