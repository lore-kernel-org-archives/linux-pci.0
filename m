Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <5A2A6AB10200007800195D4F@prv-mh.provo.novell.com>
Date: Fri, 08 Dec 2017 02:34:25 -0700
From: "Jan Beulich" <JBeulich@suse.com>
To: "Govinda Tatti" <Govinda.Tatti@Oracle.COM>
Cc: <roger.pau@citrix.com>, <bhelgaas@google.com>,
        <xen-devel@lists.xenproject.org>, <boris.ostrovsky@Oracle.COM>,
        <konrad.wilk@Oracle.COM>, "Juergen Gross" <jgross@suse.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V3 2/2] Xen/PCIback: Implement PCI flr/slot/bus
 reset with 'reset' SysFS attribute
References: <20171207222145.9769-1-Govinda.Tatti@Oracle.COM>
 <20171207222145.9769-3-Govinda.Tatti@Oracle.COM>
In-Reply-To: <20171207222145.9769-3-Govinda.Tatti@Oracle.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>>> On 07.12.17 at 23:21, <Govinda.Tatti@Oracle.COM> wrote:
> Due to the complexity with the PCI lock we cannot do the reset when a
> device is bound ('echo $BDF > bind') or when unbound ('echo $BDF > unbind')
> as the pci_[slot|bus]_reset also takes the same lock resulting in a
> dead-lock.

It took me a moment to figure that here you're referring to the
process of (un)binding, not the state. To avoid that ambiguity in
wording, how about "... we cannot do the reset while a device is
being bound (...) or while it is being unbound ..."?

> --- a/Documentation/ABI/testing/sysfs-driver-pciback
> +++ b/Documentation/ABI/testing/sysfs-driver-pciback
> @@ -11,3 +11,18 @@ Description:
>                  #echo 00:19.0-E0:2:FF > /sys/bus/pci/drivers/pciback/quirks
>                  will allow the guest to read and write to the configuration
>                  register 0x0E.
> +
> +What:           /sys/bus/pci/drivers/pciback/reset
> +Date:           Dec 2017
> +KernelVersion:  4.15
> +Contact:        xen-devel@lists.xenproject.org 
> +Description:
> +                An option to perform a flr/slot/bus reset when a PCI device
> +		is owned by Xen PCI backend. Writing a string of DDDD:BB:DD.F

SSSS:BB:DD.F (or else the D-s are ambiguous, the more that "domain"
in Xen code is ambiguous anyway - I continue to be mislead by struct
pcistub_device_id's domain field)

Also I assume the SSSS part is optional (default zero), which
probably can and should be expressed in some way.

> --- a/drivers/xen/xen-pciback/pci_stub.c
> +++ b/drivers/xen/xen-pciback/pci_stub.c
> @@ -313,6 +313,102 @@ void pcistub_put_pci_dev(struct pci_dev *dev)
>  	up_write(&pcistub_sem);
>  }
>  
> +struct pcistub_args {
> +	const struct pci_dev *dev;
> +	unsigned int dcount;

The sole use of this field is for a debug message. Why not drop it
and make "dev" the "data" argument without further indirection?

> +static int pcistub_device_search(struct pci_dev *dev, void *data)
> +{
> +	struct pcistub_device *psdev;
> +	struct pcistub_args *arg = data;
> +	bool found = false;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&pcistub_devices_lock, flags);
> +
> +	list_for_each_entry(psdev, &pcistub_devices, dev_list) {
> +		if (psdev->dev == dev) {
> +			found = true;
> +			arg->dcount++;
> +			break;

Neither here nor in the caller I can see a check whether the device
is currently assigned to a guest. Ownership by pciback alone imo is
not sufficient to allow a reset to be performed.

> +static int pcistub_device_reset(struct pci_dev *dev)
> +{
> +	struct xen_pcibk_dev_data *dev_data;
> +	bool slot = false, bus = false;
> +	struct pcistub_args arg = {};
> +
> +	if (!dev)
> +		return -EINVAL;
> +
> +	dev_dbg(&dev->dev, "[%s]\n", __func__);
> +
> +	/* First check and try FLR */
> +	if (pcie_has_flr(dev)) {
> +		dev_dbg(&dev->dev, "resetting %s device using FLR\n",
> +			pci_name(dev));
> +		pcie_flr(dev);

The lack of error check here puzzled me, but I see the function
indeed returns void right now. I think the prereq patch should
change this along with exporting the function - you really don't
want the device to be handed to a guest when the FLR timed
out.

> +		return 0;
> +	}
> +
> +	if (!pci_probe_reset_slot(dev->slot))
> +		slot = true;
> +	else if ((!pci_probe_reset_bus(dev->bus)) &&
> +		 (!pci_is_root_bus(dev->bus)))

Too many parentheses for my taste.

> +static ssize_t reset_store(struct device_driver *drv, const char *buf,
> +			   size_t count)
> +{
> +	struct pcistub_device *psdev;
> +	int domain, bus, slot, func;
> +	int err;
> +
> +	err = str_to_slot(buf, &domain, &bus, &slot, &func);
> +	if (err)
> +		return err;
> +
> +	psdev = pcistub_device_find(domain, bus, slot, func);
> +	if (psdev) {
> +		err = pcistub_device_reset(psdev->dev);
> +		pcistub_device_put(psdev);
> +	} else {
> +		err = -ENODEV;
> +	}
> +
> +	if (!err)
> +		err = count;
> +
> +	return err;
> +}
> +static DRIVER_ATTR_WO(reset);

Would it be worth for reads of the file to return whether the device
can be reset this way (i.e. the result of the checks you do before
actually doing the reset)?

Jan
