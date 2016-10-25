Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52488 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751039AbcJYSmT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Oct 2016 14:42:19 -0400
Date: Tue, 25 Oct 2016 12:42:18 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrei Grigore <andrei.grg@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jayme Howard <g.prime@gmail.com>
Subject: Re: [PATCH] PCI: pci-stub: accept exceptions to the ID- and
 class-based matching
Message-ID: <20161025124218.2696e55a@t450s.home>
In-Reply-To: <20161025182419.22910-1-lersek@redhat.com>
References: <20161025182419.22910-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 25 Oct 2016 20:24:19 +0200
Laszlo Ersek <lersek@redhat.com> wrote:

> Some systems have multiple instances of the exact same kind of PCI device
> installed. When VFIO users intend to assign these devices to VMs, they
> occasionally don't want to assign all of them; they'd keep a few for
> host-side use. The current ID- and class-based matching in pci-stub
> doesn't accommodate this use case, so users are left with either
> rc.local-style host boot scripts, or QEMU wrapper scripts (which are
> inferior to a pure libvirt environment).
> 
> Introduce the "except" module parameter for pci-stub. In addition to
> "ids", users can specify a list of Domain:Bus:Device.Function tuples. The
> tuples are parsed and saved before pci_add_dynid() is called. The pci-stub
> probe function will fail for the listed devices, for the initial and all
> later (explicit) binding attempts.
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Andrei Grigore <andrei.grg@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Jayme Howard <g.prime@gmail.com>
> Reported-by: Andrei Grigore <andrei.grg@gmail.com>
> Ref: https://www.redhat.com/archives/vfio-users/2016-October/msg00121.html
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  drivers/pci/pci-stub.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/drivers/pci/pci-stub.c b/drivers/pci/pci-stub.c
> index 886fb3570278..120c29609c44 100644
> --- a/drivers/pci/pci-stub.c
> +++ b/drivers/pci/pci-stub.c
> @@ -26,8 +26,44 @@ MODULE_PARM_DESC(ids, "Initial PCI IDs to add to the stub driver, format is "
>  		 "\"vendor:device[:subvendor[:subdevice[:class[:class_mask]]]]\""
>  		 " and multiple comma separated entries can be specified");
>  
> +#define MAX_EXCEPT 16
> +
> +static unsigned num_except;
> +static struct except {
> +	u16 domain;
> +	u16 devid;
> +} except[MAX_EXCEPT];
> +
> +/*
> + * Accommodate substrings like "0000:00:1c.4," MAX_EXCEPT times, with the comma
> + * replaced with '\0' in the last instance
> + */
> +static char except_str[13 * MAX_EXCEPT] __initdata;
> +
> +module_param_string(except, except_str, sizeof except_str, 0);
> +MODULE_PARM_DESC(except, "Comma-separated list of PCI addresses to except "
> +		 "from the ID- and class-based binding. The address format is "
> +		 "Domain:Bus:Device.Function (all components are required and "
> +		 "written in hex), for example, 0000:00:1c.4. At most "
> +		 __stringify(MAX_EXCEPT) " exceptions are supported.");

So a user needs to specify both a set of set of vendor:device ids AND an
exception list?  Wouldn't it be easier to make a list of _included_
devices by address, w/o needing an ids= list?  FWIW, I think the reason
this hasn't been done to date is that PCI bus addresses (except for
root bus devices) are not stable.  Depending on the system, the address
of a given device may change, not only based on the slot where the
device is installed, but whether other devices in other slots are
populated.  This is why when ACPI needs to describe a PCI device (such
as in the DMAR tables), it does so via paths.  We don't know the bus
number that will be assigned to a device, but we do know
deterministically how to traverse to it, for instance root bus -> root
dev.fn -> intermediate dev.fn -> target dev.fn.  Thanks,

Alex

> +
> +static inline bool exception_matches(const struct except *ex,
> +				     const struct pci_dev *dev)
> +{
> +	return ex->domain == pci_domain_nr(dev->bus) &&
> +	       ex->devid == PCI_DEVID(dev->bus->number, dev->devfn);
> +}
> +
>  static int pci_stub_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  {
> +	unsigned i;
> +
> +	for (i = 0; i < num_except; i++)
> +		if (exception_matches(&except[i], dev)) {
> +			dev_info(&dev->dev, "skipped by stub\n");
> +			return -EPERM;
> +		}
> +
>  	dev_info(&dev->dev, "claimed by stub\n");
>  	return 0;
>  }
> @@ -47,6 +83,33 @@ static int __init pci_stub_init(void)
>  	if (rc)
>  		return rc;
>  
> +	/* parse exceptions */
> +	p = except_str;
> +	while ((id = strsep(&p, ","))) {
> +		int fields;
> +		unsigned domain, bus, dev, fn;
> +
> +		if (*id == '\0')
> +			continue;
> +
> +		fields = sscanf(id, "%x:%x:%x.%x", &domain, &bus, &dev, &fn);
> +		if (fields != 4 || domain > 0xffff || bus > 0xff ||
> +		    dev > 0x1f || fn > 0x7) {
> +			printk(KERN_WARNING
> +			       "pci-stub: invalid exception \"%s\"\n", id);
> +			continue;
> +		}
> +
> +		if (num_except < MAX_EXCEPT) {
> +			struct except *ex = &except[num_except++];
> +
> +			ex->domain = domain;
> +			ex->devid = PCI_DEVID(bus, PCI_DEVFN(dev, fn));
> +		} else
> +			printk(KERN_WARNING
> +			       "pci-stub: no room for exception \"%s\"\n", id);
> +	}
> +
>  	/* no ids passed actually */
>  	if (ids[0] == '\0')
>  		return 0;

