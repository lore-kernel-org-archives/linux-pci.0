Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752834AbdFNWeO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Jun 2017 18:34:14 -0400
Date: Wed, 14 Jun 2017 17:34:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        alex.williamson@redhat.com, briannorris@chromium.org
Subject: Re: [PATCH] pci: Disable master abort while waiting for an FLR to
 complete
Message-ID: <20170614223406.GG20778@bhelgaas-glaptop.roam.corp.google.com>
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

I'm slightly hesitant about turning off Master Abort reporting in the
upstream bridge because that potentially affects several devices below
the bridge, not just the one that's being reset.  But maybe it's the
best we can do.

Is there a public problem report we can reference?  It'd be nice to
have "lspci -vvxxxx" output (for future reference since lspci doesn't
decode FRS stuff yet).

Alex W, since you wrote 5adecf817dd6, have you seen similar problems
or do you have any thoughts on this?

I have the same question as Alex D -- why aren't we using CRS in this
path as in pci_bus_read_dev_vendor_id()?  PCIe r3.1, sec 6.6.2, says a
function should use CRS if it requires more time.  I see the comment
about VFs not implementing the first dword, but a VF vendor ID
*should* read as 0xffff, which is distinguishable from a CRS response
(0x0001).

Per sec 6.6.2, a function must complete an FLR within 100ms.  I assume
that means the Intel IGD from 5adecf817dd6 and whatever device is
involved here (what is it, by the way?) are out of spec.  Or is there
some weasel wording that allows devices to take this long after a
reset?

If they're out of spec, it'd be nice to identify them with quirks
(maybe using pci_dev_specific_reset()) instead of changing the generic
code to accommodate them.  That way the code matches the spec better
and we can potentially work on better ways to handle the issue within
the spec, e.g., via something like Function Readiness Status
notifications (sec 6.23.2).

Please repost this eventually with the typo correction and hopefully a
link to the problem report and lspci info.

Bjorn

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
>  	} while (i++ < 10 && id == ~0);
>  
> +	/* restore bridge state */
> +	if (bridge)
> +		pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, bctl);
> +
>  	if (id == ~0)
>  		dev_warn(&dev->dev, "Failed to return from FLR\n");
>  	else if (i > 1)
> 
