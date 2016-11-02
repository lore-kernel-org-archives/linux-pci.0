Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38588 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756346AbcKBXpK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Nov 2016 19:45:10 -0400
Subject: Re: [PATCH] PCI: pci-stub: accept exceptions to the ID- and
 class-based matching
To: Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20161025182419.22910-1-lersek@redhat.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrei Grigore <andrei.grg@gmail.com>,
        Jayme Howard <g.prime@gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <47a80091-bede-9245-18f9-a1bd88032925@redhat.com>
Date: Thu, 3 Nov 2016 00:45:06 +0100
MIME-Version: 1.0
In-Reply-To: <20161025182419.22910-1-lersek@redhat.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/25/16 20:24, Laszlo Ersek wrote:
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
> 

Ping -- I don't "insist" on getting this patch in, but I'd like to see a
clear decision about it. Leaving it hanging is terrible.

Please follow up with a clear ACK, or a clear NAK, or advice for
improving the patch. (Again, I don't mind if it gets nacked, but I'd
like to see it explicitly.)

(I think I responded to Alex's earlier points acceptably; IOW the ball
shouldn't be in my court ATM.)

Thanks
Laszlo
