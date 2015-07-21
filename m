Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 21 Jul 2015 13:09:19 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jordan Hargrave <jharg93@gmail.com>
Cc: jdelvare@suse.de, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Jordan_Hargrave@dell.com
Subject: Re: [PATCH] Add support for reading SMBIOS Slot number for PCI
 devices
Message-ID: <20150721180919.GE21967@google.com>
References: <1436565766-21820-1-git-send-email-jordan_hargrave@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436565766-21820-1-git-send-email-jordan_hargrave@dell.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 10, 2015 at 05:02:46PM -0500, Jordan Hargrave wrote:
> From: Jordan Hargrave <Jordan_Hargrave@dell.com>
> 
> There currently isn't an easy way to determine which PCI devices belong to
> system slots.  This patch adds support to read SMBIOS Type 9 (System Slots).
> 
> Signed-off-by: Jordan Hargrave <Jordan_Hargrave@dell.com>
> ---
>  drivers/firmware/dmi_scan.c | 39 ++++++++++++++++++++
>  drivers/pci/pci-label.c     | 89 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/dmi.h         |  1 +
>  3 files changed, 129 insertions(+)
> 
> diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
> index ac1ce4a..8f95897 100644
> --- a/drivers/firmware/dmi_scan.c
> +++ b/drivers/firmware/dmi_scan.c
> @@ -356,6 +356,41 @@ static void __init dmi_save_extended_devices(const struct dmi_header *dm)
>  	dmi_save_one_device(*d & 0x7f, dmi_string_nosave(dm, *(d - 1)));
>  }
>  
> +static void __init dmi_save_dev_slot(int instance, int segment, int bus, int devfn, const char *name)
> +{
> +	struct dmi_dev_onboard *slot;
> +	
> +	slot = dmi_alloc(sizeof(*slot) + strlen(name) + 1);
> +	if (!slot) {
> +		printk(KERN_ERR "dmi_save_system_slot: out of memory.\n");

You've got lots of data that might be useful in the printk: segment, bus,
devfn, name.

> +		return;
> +	}
> +	slot->instance = instance;
> +	slot->segment = segment;
> +	slot->bus = bus;
> +	slot->devfn = devfn;
> +
> +	strcpy((char *)&slot[1], name);
> +	slot->dev.type = DMI_DEV_TYPE_SYSTEM_SLOT;
> +	slot->dev.name = (char *)&slot[1];
> +	slot->dev.device_data = slot;
> +
> +	list_add(&slot->dev.list, &dmi_devices);
> +}
> +
> +
> +static void __init dmi_save_system_slot(const struct dmi_header *dm)
> +{
> +	const char *name;
> +	const u8 *d = (u8*)dm;
> +	
> +	if (dm->type == DMI_ENTRY_SYSTEM_SLOT && dm->length >= 0x11) {
> +		name = dmi_string_nosave(dm, *(d + 0x04));
> +		dmi_save_dev_slot(*(u16 *)(d + 0x09), *(u16 *)(d + 0xD), 
> +				  *(d + 0xF), *(d + 0x10), name);
> +	}
> +}
> +
>  static void __init count_mem_devices(const struct dmi_header *dm, void *v)
>  {
>  	if (dm->type != DMI_ENTRY_MEM_DEVICE)
> @@ -437,6 +472,10 @@ static void __init dmi_decode(const struct dmi_header *dm, void *dummy)
>  		break;
>  	case 41:	/* Onboard Devices Extended Information */
>  		dmi_save_extended_devices(dm);
> +		break;
> +	case 9:         /* System Slots */
> +		dmi_save_system_slot(dm);
> +		break;
>  	}
>  }
>  
> diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
> index 024b5c1..38dfb45 100644
> --- a/drivers/pci/pci-label.c
> +++ b/drivers/pci/pci-label.c
> @@ -125,14 +125,103 @@ static struct attribute_group smbios_attr_group = {
>  	.is_visible = smbios_instance_string_exist,
>  };
>  
> +static int smbios_getslot(struct pci_dev *pdev)
> +{
> +	struct pci_dev *sdev;
> +	struct dmi_dev_onboard *dslot;
> +	const struct dmi_device *dmi;
> +	u8 sub, sec, bus;
> +
> +	dmi = NULL;
> +	if (pdev->is_virtfn) {
> +		/* Get Physical device for SR-IOV */
> +		pdev = pdev->physfn;
> +	}

Use pci_physfn().

> +	bus = pdev->bus->number;
> +	while ((dmi = dmi_find_device(DMI_DEV_TYPE_SYSTEM_SLOT, NULL, dmi)) != NULL) {

This loop doesn't match my naive expectation of how we should find a slot.
I expected something like:

  - Look for DMI info that's an exact match for my D:B:D.F
  - Walk bridges upstream towards the root, looking for a subtree that
    includes pdev

> +		sec = sub = -1;
> +
> +		dslot = dmi->device_data;
> +		sdev = pci_get_domain_bus_and_slot(dslot->segment, dslot->bus, dslot->devfn);

This acquires a reference on the dev returned, so you need to dispose of
that somewhere.

> +		if (sdev == NULL)
> +			continue;
> +
> +		if (sdev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
> +			pci_read_config_byte(sdev, PCI_SECONDARY_BUS, &sec);
> +			pci_read_config_byte(sdev, PCI_SUBORDINATE_BUS, &sub);

We should not have to read this out of config space; busn_res in struct
pci_bus has this information already.

> +			if (bus >= sec && bus <= sub) {
> +				/* device is child of bridge */
> +				return dslot->instance;

If you have a slot name for 0000:00:00.0 and a device at 0001:00:00.0, this
will erroneously associate the domain 0 name with the domain 1 device.

> +			}
> +		}
> +		if (pci_domain_nr(sdev->bus) == pci_domain_nr(pdev->bus) &&
> +		    sdev->bus->number == pdev->bus->number &&
> +		    PCI_SLOT(sdev->devfn) == PCI_SLOT(pdev->devfn)) {
> +			/* Match domain:bus:dev.  If PCIE root, only match function */

The PCIe part of this comment doesn't seem to match the code.

> +			if (PCI_FUNC(sdev->devfn) == PCI_FUNC(pdev->devfn) ||
> +			    pci_pcie_type(sdev) != PCI_EXP_TYPE_ROOT_PORT) {
> +				return dslot->instance;
> +			}
> +		}
> +	}
> +	return -ENODEV;
> +}
> + 
> +static ssize_t smbiosslot_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> + 	struct pci_dev *pdev;
> +	int slot;
> + 
> + 	pdev = to_pci_dev(dev);
> +	slot = smbios_getslot(pdev);
> +	if (slot > 0) {
> +		return scnprintf(buf, PAGE_SIZE, "%d\n", slot);
> +	}
> +	return 0;
> +}
> +
> +static umode_t smbios_slot_exist(struct kobject *kobj, struct attribute *attr,
> +				 int n)
> +{
> +	struct device *dev;
> +	struct pci_dev *pdev;
> +
> +	dev = container_of(kobj, struct device, kobj);
> +	pdev = to_pci_dev(dev);
> +
> +	return (smbios_getslot(pdev) > 0) ? S_IRUGO : 0;
> +}
> +
> +static struct device_attribute smbios_attr_slot = {
> +	.attr = {.name = "slot", .mode = 0444},
> +	.show = smbiosslot_show,
> +};
> +
> +static struct attribute *smbios_slot_attributes[] = {
> +	&smbios_attr_slot.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group smbios_slot_attr_group = {
> +	.attrs = smbios_slot_attributes,
> +	.is_visible = smbios_slot_exist,
> +};
> +
>  static int pci_create_smbiosname_file(struct pci_dev *pdev)
>  {
> +	int rc;
> +
> +	rc = sysfs_create_group(&pdev->dev.kobj, &smbios_slot_attr_group);
> +	if (rc != 0)
> +		return rc;
>  	return sysfs_create_group(&pdev->dev.kobj, &smbios_attr_group);
>  }
>  
>  static void pci_remove_smbiosname_file(struct pci_dev *pdev)
>  {
>  	sysfs_remove_group(&pdev->dev.kobj, &smbios_attr_group);
> +	sysfs_remove_group(&pdev->dev.kobj, &smbios_slot_attr_group);
>  }
>  #else
>  static inline int pci_create_smbiosname_file(struct pci_dev *pdev)
> diff --git a/include/linux/dmi.h b/include/linux/dmi.h
> index 5055ac3..09f42e7 100644
> --- a/include/linux/dmi.h
> +++ b/include/linux/dmi.h
> @@ -22,6 +22,7 @@ enum dmi_device_type {
>  	DMI_DEV_TYPE_IPMI = -1,
>  	DMI_DEV_TYPE_OEM_STRING = -2,
>  	DMI_DEV_TYPE_DEV_ONBOARD = -3,
> +	DMI_DEV_TYPE_SYSTEM_SLOT = -4,
>  };
>  
>  enum dmi_entry_type {
> -- 
> 1.8.3.1
> 
