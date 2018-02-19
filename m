Return-Path: <SRS0=+pYx=FN=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=+pYx=FN=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Jayachandran Nair <Jayachandran.Nair@cavium.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, Robert Richter <Robert.Richter@cavium.com>, Tom Vaden <tom.vaden@hpe.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, George Cherian <george.cherian@cavium.com>
Subject: Re: [PATCH v1 2/2] PCI: Remove redundant probes for device reset support
Date: Mon, 19 Feb 2018 14:00:53 +0100
Message-ID: <5209987.iOvtupYxAV@aspire.rjw.lan>
In-Reply-To: <20180216225018.67295.36860.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20180216224213.67295.2251.stgit@bhelgaas-glaptop.roam.corp.google.com> <20180216225018.67295.36860.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Friday, February 16, 2018 11:50:18 PM CET Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> We probe every device for whether it supports reset so we can tell whether
> to create a sysfs "reset" file for it.  We do that probe in
> pci_init_capabilities() during enumeration and save the result in
> dev->reset_fn.  The result doesn't depend on any other devices on the bus
> and shouldn't change after boot, so we don't need to do the probe again.
> 
> Remove the pci_probe_reset_function() calls and rely on the dev->reset_fn
> we found during enumeration.  No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/pci.c |   15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index f6a4dd10d9b0..4db740e4f50a 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4450,9 +4450,8 @@ int pci_reset_function(struct pci_dev *dev)
>  {
>  	int rc;
>  
> -	rc = pci_probe_reset_function(dev);
> -	if (rc)
> -		return rc;
> +	if (!dev->reset_fn)
> +		return -ENOTTY;
>  
>  	pci_dev_lock(dev);
>  	pci_dev_save_and_disable(dev);
> @@ -4487,9 +4486,8 @@ int pci_reset_function_locked(struct pci_dev *dev)
>  {
>  	int rc;
>  
> -	rc = pci_probe_reset_function(dev);
> -	if (rc)
> -		return rc;
> +	if (!dev->reset_fn)
> +		return -ENOTTY;
>  
>  	pci_dev_save_and_disable(dev);
>  
> @@ -4511,9 +4509,8 @@ int pci_try_reset_function(struct pci_dev *dev)
>  {
>  	int rc;
>  
> -	rc = pci_probe_reset_function(dev);
> -	if (rc)
> -		return rc;
> +	if (!dev->reset_fn)
> +		return -ENOTTY;
>  
>  	if (!pci_dev_trylock(dev))
>  		return -EAGAIN;
> 
> 
