Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 29 Aug 2017 14:53:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V13 1/4] PCI: Don't ignore valid response before CRS
 timeout
Message-ID: <20170829195322.GB2304@bhelgaas-glaptop.roam.corp.google.com>
References: <1503855651-17409-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1503855651-17409-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
 linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Aug 27, 2017 at 01:40:48PM -0400, Sinan Kaya wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> While waiting for a device to become ready (i.e., to return a non-CRS
> completion to a read of its Vendor ID), if we got a valid response to the
> very last read before timing out, we printed a warning and gave up on the
> device even though it was actually ready.
> 
> For a typical 60s timeout, we wait about 65s (it's not exact because of the
> exponential backoff), but we treated devices that became ready between 33s
> and 65s as though they failed.
> 
> Move the Device ID read later so we check whether the device is ready
> immediately, before checking for a timeout.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> [okaya: reorder reads so that we check device presence after sleep]
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Applied this series to pci/enumeration for v4.14.  You didn't include a
cover letter, but the series includes:

  [V13 1/4] PCI: Don't ignore valid response before CRS timeout
  [V13 2/4] PCI: Factor out pci_bus_wait_crs()
  [V13 3/4] PCI: Handle CRS ('device not ready') returned by device af
  [V13 4/4] PCI: Warn periodically while waiting for device to become

I made some changes:

  - Renamed pci_bus_crs_visibility_pending() to pci_bus_crs_vendor_id()
    because the CRS completion is not "pending".  It is not waiting
    somewhere for us to do something about it.  The CRS completion has
    already occurred and is over.  All we have now is a magic Vendor ID
    value that tells us that it happened.

  - Split addition of pci_bus_crs_vendor_id() to a separate patch, move
    it to probe.c, and make it static.

  - Pass a pointer, not a value, to pci_bus_wait_crs() so the caller gets
    correct Vendor ID when we're finished waiting.

  - Add in the 100ms mandatory sleep in the delays we print in
    pci_flr_wait() so the printed value reflects the entire time since the
    FLR was started.

> ---
>  drivers/pci/probe.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index c31310d..2849e0e 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1847,17 +1847,18 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
>  		if (!crs_timeout)
>  			return false;
>  
> -		msleep(delay);
> -		delay *= 2;
> -		if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
> -			return false;
> -		/* Card hasn't responded in 60 seconds?  Must be stuck. */
>  		if (delay > crs_timeout) {
>  			printk(KERN_WARNING "pci %04x:%02x:%02x.%d: not responding\n",
>  			       pci_domain_nr(bus), bus->number, PCI_SLOT(devfn),
>  			       PCI_FUNC(devfn));
>  			return false;
>  		}
> +
> +		msleep(delay);
> +		delay *= 2;
> +
> +		if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
> +			return false;
>  	}
>  
>  	return true;
> -- 
> 1.9.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
