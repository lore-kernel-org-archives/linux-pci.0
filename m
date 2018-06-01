Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55988 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751465AbeFAOaG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Jun 2018 10:30:06 -0400
Date: Fri, 1 Jun 2018 08:30:00 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH v2 2/3] PCI: Allow specifying devices using a base bus
 and path of devfns
Message-ID: <20180601083000.62d10d14@t450s.home>
In-Reply-To: <20180531235010.5279-3-logang@deltatee.com>
References: <20180531235010.5279-1-logang@deltatee.com>
        <20180531235010.5279-3-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 31 May 2018 17:50:09 -0600
Logan Gunthorpe <logang@deltatee.com> wrote:

> When specifying PCI devices on the kernel command line using a
> BDF, the bus numbers can change when adding or replacing a device,
> changing motherboard firmware, or applying kernel parameters like
> pci=assign-buses. When this happens, it is usually undesirable to
> apply whatever command line tweak to the wrong device.
> 
> Therefore, it is useful to be able to specify devices with a base
> bus number and the path of devfns needed to get to it. (Similar to
> the "device scope" structure in the Intel VT-d spec, Section 8.3.1.)
> 
> Thus, we add an option to specify devices in the following format:
> 
> path:[<domain>:]<bus>:<slot>.<func>/<slot>.<func>[/ ...]
> 
> The path can be any segment within the PCI hierarchy of any length and
> determined through the use of 'lspci -t'. When specified this way, it is
> less likely that a renumbered bus will result in a valid device specification
> and the tweak won't be applied to the wrong device.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Stephen Bates <sbates@raithlin.com>
> Acked-by: Christian König <christian.koenig@amd.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  12 ++-
>  drivers/pci/pci.c                               | 101 +++++++++++++++++++++++-
>  2 files changed, 107 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index e58cc671ff92..bc51b316f485 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2989,9 +2989,10 @@
>  
>  				Some options herein operate on a specific device
>  				or a set of devices (<pci_dev>). These are
> -				specified in one of two formats:
> +				specified in one of three formats:
>  
>  				[<domain>:]<bus>:<slot>.<func>
> +				path:[<domain>:]<bus>:<slot>.<func>/<slot>.<func>[/ ...]
>  				pci:<vendor>:<device>[:<subvendor>:<subdevice>]
>  
>  				Note: the first format specifies a PCI
> @@ -2999,9 +3000,12 @@
>  				if new hardware is inserted, if motherboard
>  				firmware changes, or due to changes caused
>  				by other kernel parameters. The second format
> -				selects devices using IDs from the
> -				configuration space which may match multiple
> -				devices in the system.
> +				specifies a path from a device through
> +				a path of multiple slot/function addresses
> +				(this is more robust against renumbering
> +				issues). The third format selects devices using
> +				IDs from the configuration space which may match
> +				multiple devices in the system.
>  
>  		earlydump	[X86] dump PCI config space before the kernel
>  			        changes anything
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 85fec5e2640b..39f11bd0ee03 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -184,22 +184,111 @@ EXPORT_SYMBOL_GPL(pci_ioremap_wc_bar);
>  #endif
>  
>  /**
> + * pci_dev_str_match_path - test if a path string matches a device
> + * @dev:    the PCI device to test
> + * @p:      string to match the device against
> + * @endptr: pointer to the string after the match
> + *
> + * Test if a string (typically from a kernel parameter) formated as a
> + * path of slot/function addresses matches a PCI device. The string must
> + * be of the form:
> + *
> + *   [<domain>:]<bus>:<slot>.<func>/<slot>.<func>[/ ...]
> + *
> + * A path for a device can be obtained using 'lspci -t'. Using a path
> + * is more robust against renumbering of devices than using only
> + * a single bus, slot and function address.
> + *
> + * Returns 1 if the string matches the device, 0 if it does not and
> + * a negative error code if it fails to parse the string.
> + */
> +static int pci_dev_str_match_path(struct pci_dev *dev, const char *path,
> +				  const char **endptr)
> +{
> +	int ret;
> +	int seg, bus, slot, func;
> +	char *wpath, *p;
> +	char end;
> +
> +	*endptr = strchrnul(path, ';');
> +
> +	wpath = kmemdup_nul(path, *endptr - path, GFP_KERNEL);
> +	if (!wpath)
> +		return -ENOMEM;
> +
> +	while (1) {
> +		p = strrchr(wpath, '/');
> +		if (!p)
> +			break;
> +		ret = sscanf(p, "/%x.%x%c", &slot, &func, &end);
> +		if (ret != 2) {
> +			ret = -EINVAL;
> +			goto free_and_exit;
> +		}
> +
> +		if (dev->devfn != PCI_DEVFN(slot, func)) {
> +			ret = 0;
> +			goto free_and_exit;
> +		}
> +
> +		/*
> +		 * Note: we don't need to get a reference to the upstream
> +		 * bridge because we hold a reference to the top level
> +		 * device which should hold a reference to the bridge,
> +		 * and so on.
> +		 */
> +		dev = pci_upstream_bridge(dev);
> +		if (!dev) {
> +			ret = 0;
> +			goto free_and_exit;
> +		}
> +
> +		*p = 0;
> +	}
> +
> +	ret = sscanf(wpath, "%x:%x:%x.%x%c", &seg, &bus, &slot,
> +		     &func, &end);
> +	if (ret != 4) {
> +		seg = 0;
> +		ret = sscanf(wpath, "%x:%x.%x%c", &bus, &slot, &func, &end);
> +		if (ret != 3) {
> +			ret = -EINVAL;
> +			goto free_and_exit;
> +		}
> +	}
> +
> +	ret = (seg == pci_domain_nr(dev->bus) &&
> +	       bus == dev->bus->number &&
> +	       dev->devfn == PCI_DEVFN(slot, func));
> +
> +free_and_exit:
> +	kfree(wpath);
> +	return ret;
> +}

Cool, I'm glad this worked.  I note though that there's really not much
difference between:

[domain:]bus:slot.fn

and

[domain:]bus:slot.fn[/slot.fn[/slot.fn[/...]]]

IOW, what's defined here as the "path:" specification doesn't require
that we start at a root bus device, it can really specify a path
starting anywhere, including the target device directly.  So can we
simply extend domain:bus:slot.fn to support paths without a separate
identifier?  Thanks,

Alex

> +
> +/**
>   * pci_dev_str_match - test if a string matches a device
>   * @dev:    the PCI device to test
>   * @p:      string to match the device against
>   * @endptr: pointer to the string after the match
>   *
>   * Test if a string (typically from a kernel parameter) matches a
> - * specified. The string may be of one of two forms formats:
> + * specified. The string may be of one of three formats:
>   *
>   *   [<domain>:]<bus>:<slot>.<func>
> + *   path:[<domain>:]<bus>:<slot>.<func>/<slot>.<func>[/ ...]
>   *   pci:<vendor>:<device>[:<subvendor>:<subdevice>]
>   *
>   * The first format specifies a PCI bus/slot/function address which
>   * may change if new hardware is inserted, if motherboard firmware changes,
>   * or due to changes caused in kernel parameters.
>   *
> - * The second format matches devices using IDs in the configuration
> + * The second format specifies a PCI bus/slot/function root address and
> + * a path of slot/function addresses to the specific device from the root.
> + * The path for a device can be determined through the use of 'lspci -t'.
> + * This format is more robust against renumbering issues than the first format.
> +
> + * The third format matches devices using IDs in the configuration
>   * space which may match multiple devices in the system. A value of 0
>   * for any field will match all devices.
>   *
> @@ -236,7 +325,15 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
>  		    (!subsystem_device ||
>  			    subsystem_device == dev->subsystem_device))
>  			goto found;
> +	} else if (strncmp(p, "path:", 5) == 0) {
> +		/* PCI Root Bus and a path of Slot,Function IDs */
> +		p += 5;
>  
> +		ret = pci_dev_str_match_path(dev, p, &p);
> +		if (ret < 0)
> +			return ret;
> +		else if (ret)
> +			goto found;
>  	} else {
>  		/* PCI Bus,Slot,Function ids are specified */
>  		ret = sscanf(p, "%x:%x:%x.%x%n", &seg, &bus, &slot,
