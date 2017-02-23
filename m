Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751195AbdBWWvN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Feb 2017 17:51:13 -0500
Date: Thu, 23 Feb 2017 16:43:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Keith Busch <keith.busch@intel.com>,
        Myron Stowe <myron.stowe@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Wei Zhang <wzhang@fb.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <stephen.bates@microsemi.com>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] switchtec: Add sysfs attributes to the Switchtec
 driver
Message-ID: <20170223224317.GA21548@bhelgaas-glaptop.roam.corp.google.com>
References: <1486058763-7730-1-git-send-email-logang@deltatee.com>
 <1486058763-7730-4-git-send-email-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486058763-7730-4-git-send-email-logang@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 02, 2017 at 11:06:02AM -0700, Logan Gunthorpe wrote:
> This patch adds a few read-only sysfs attributes which provide
> some device information that is exposed from the devices. Primarily
> component and device names and versions. These are documented in
> Documentation/ABI/testing/sysfs-class-switchtec.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Stephen Bates <stephen.bates@microsemi.com>
> ---
>  Documentation/ABI/testing/sysfs-class-switchtec |  96 ++++++++++++++++++++
>  MAINTAINERS                                     |   1 +
>  drivers/pci/switch/switchtec.c                  | 113 ++++++++++++++++++++++++
>  3 files changed, 210 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-switchtec
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-switchtec b/Documentation/ABI/testing/sysfs-class-switchtec
> new file mode 100644
> index 0000000..48cb4c1
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-switchtec
> @@ -0,0 +1,96 @@
> +switchtec - Microsemi Switchtec PCI Switch Management Endpoint
> +
> +For details on this subsystem look at Documentation/switchtec.txt.
> +
> +What: 		/sys/class/switchtec

This path seems a little generic.  I don't see other cases where a
product brand name ("Switchtec") appears at the top level of
/sys/class/...

My question is based on "ls Documentation/ABI/testing/sysfs-class*",
not on any great knowledge of sysfs, and I see Greg has already given
a Reviewed-by for this, so maybe this is the right approach.

It does seem like the path could include a clue that this is related
to PCI.

Is there a link to the switch PCI device itself, e.g., to
/sys/devices/pci*?  Should these attributes simply be put in a
subdirectory there, e.g., in

  /sys/devices/pci0000:00/0000:00:00.0/stats/...

instead of in /sys/class/?  It seems like it'd be useful for userspace
to be able to connect this info with the switch somehow.

> +Date:		05-Jan-2017
> +KernelVersion:	v4.11
> +Contact:	Logan Gunthorpe <logang@deltatee.com>
> +Description:	The switchtec class subsystem folder.
> +		Each registered switchtec driver is represented by a switchtecX
> +		subfolder (X being an integer >= 0).
> +
> +
> +What:		/sys/class/switchtec/switchtec[0-9]+/component_id
> +Date:		05-Jan-2017
> +KernelVersion:	v4.11
> +Contact:	Logan Gunthorpe <logang@deltatee.com>
> +Description:	Component identifier as stored in the hardware (eg. PM8543)
> +		(read only)
> +Values: 	arbitrary string.
> +
> +
> +What:		/sys/class/switchtec/switchtec[0-9]+/component_revision
> +Date:		05-Jan-2017
> +KernelVersion:	v4.11
> +Contact:	Logan Gunthorpe <logang@deltatee.com>
> +Description:	Component revision stored in the hardware (read only)
> +Values: 	integer.
> +
> +
> +What:		/sys/class/switchtec/switchtec[0-9]+/component_vendor
> +Date:		05-Jan-2017
> +KernelVersion:	v4.11
> +Contact:	Logan Gunthorpe <logang@deltatee.com>
> +Description:	Component vendor as stored in the hardware (eg. MICROSEM)
> +		(read only)
> +Values: 	arbitrary string.
> +
> +
> +What:		/sys/class/switchtec/switchtec[0-9]+/device_version
> +Date:		05-Jan-2017
> +KernelVersion:	v4.11
> +Contact:	Logan Gunthorpe <logang@deltatee.com>
> +Description:	Device version as stored in the hardware (read only)
> +Values: 	integer.
> +
> +
> +What:		/sys/class/switchtec/switchtec[0-9]+/fw_version
> +Date:		05-Jan-2017
> +KernelVersion:	v4.11
> +Contact:	Logan Gunthorpe <logang@deltatee.com>
> +Description:	Currently running firmware version (read only)
> +Values: 	integer (in hexadecimal).
> +
> +
> +What:		/sys/class/switchtec/switchtec[0-9]+/partition
> +Date:		05-Jan-2017
> +KernelVersion:	v4.11
> +Contact:	Logan Gunthorpe <logang@deltatee.com>
> +Description:	Partition number for this device in the switch (read only)
> +Values: 	integer.
> +
> +
> +What:		/sys/class/switchtec/switchtec[0-9]+/partition_count
> +Date:		05-Jan-2017
> +KernelVersion:	v4.11
> +Contact:	Logan Gunthorpe <logang@deltatee.com>
> +Description:	Total number of partitions in the switch (read only)
> +Values: 	integer.
> +
> +
> +What:		/sys/class/switchtec/switchtec[0-9]+/product_id
> +Date:		05-Jan-2017
> +KernelVersion:	v4.11
> +Contact:	Logan Gunthorpe <logang@deltatee.com>
> +Description:	Product identifier as stored in the hardware (eg. PSX 48XG3)
> +		(read only)
> +Values: 	arbitrary string.
> +
> +
> +What:		/sys/class/switchtec/switchtec[0-9]+/product_revision
> +Date:		05-Jan-2017
> +KernelVersion:	v4.11
> +Contact:	Logan Gunthorpe <logang@deltatee.com>
> +Description:	Product revision stored in the hardware (eg. RevB)
> +		(read only)
> +Values: 	arbitrary string.
> +
> +
> +What:		/sys/class/switchtec/switchtec[0-9]+/product_vendor
> +Date:		05-Jan-2017
> +KernelVersion:	v4.11
> +Contact:	Logan Gunthorpe <logang@deltatee.com>
> +Description:	Product vendor as stored in the hardware (eg. MICROSEM)
> +		(read only)
> +Values: 	arbitrary string.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0ab858d..d39b7fd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9514,6 +9514,7 @@ M:	Logan Gunthorpe <logang@deltatee.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/switchtec.txt
> +F:	Documentation/ABI/testing/sysfs-class-switchtec
>  F:	drivers/pci/switch/switchtec*
>  
>  PCI DRIVER FOR NVIDIA TEGRA
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index e4a4294..354ddfd 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -485,6 +485,118 @@ static void mrpc_timeout_work(struct work_struct *work)
>  	mutex_unlock(&stdev->mrpc_mutex);
>  }
>  
> +static ssize_t device_version_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct switchtec_dev *stdev = to_stdev(dev);
> +	u32 ver;
> +
> +	ver = ioread32(&stdev->mmio_sys_info->device_version);
> +
> +	return sprintf(buf, "%x\n", ver);
> +}
> +static DEVICE_ATTR_RO(device_version);
> +
> +static ssize_t fw_version_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct switchtec_dev *stdev = to_stdev(dev);
> +	u32 ver;
> +
> +	ver = ioread32(&stdev->mmio_sys_info->firmware_version);
> +
> +	return sprintf(buf, "%08x\n", ver);
> +}
> +static DEVICE_ATTR_RO(fw_version);
> +
> +static ssize_t io_string_show(char *buf, void __iomem *attr, size_t len)
> +{
> +	int i;
> +
> +	memcpy_fromio(buf, attr, len);
> +	buf[len] = '\n';
> +	buf[len + 1] = 0;
> +
> +	for (i = len - 1; i > 0; i--) {
> +		if (buf[i] != ' ')
> +			break;
> +		buf[i] = '\n';
> +		buf[i + 1] = 0;
> +	}
> +
> +	return strlen(buf);
> +}
> +
> +#define DEVICE_ATTR_SYS_INFO_STR(field) \
> +static ssize_t field ## _show(struct device *dev, \
> +	struct device_attribute *attr, char *buf) \
> +{ \
> +	struct switchtec_dev *stdev = to_stdev(dev); \
> +	return io_string_show(buf, &stdev->mmio_sys_info->field, \
> +			    sizeof(stdev->mmio_sys_info->field)); \
> +} \
> +\
> +static DEVICE_ATTR_RO(field)
> +
> +DEVICE_ATTR_SYS_INFO_STR(vendor_id);
> +DEVICE_ATTR_SYS_INFO_STR(product_id);
> +DEVICE_ATTR_SYS_INFO_STR(product_revision);
> +DEVICE_ATTR_SYS_INFO_STR(component_vendor);
> +
> +static ssize_t component_id_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct switchtec_dev *stdev = to_stdev(dev);
> +	int id = ioread16(&stdev->mmio_sys_info->component_id);
> +
> +	return sprintf(buf, "PM%04X\n", id);
> +}
> +static DEVICE_ATTR_RO(component_id);
> +
> +static ssize_t component_revision_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct switchtec_dev *stdev = to_stdev(dev);
> +	int rev = ioread8(&stdev->mmio_sys_info->component_revision);
> +
> +	return sprintf(buf, "%d\n", rev);
> +}
> +static DEVICE_ATTR_RO(component_revision);
> +
> +static ssize_t partition_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct switchtec_dev *stdev = to_stdev(dev);
> +
> +	return sprintf(buf, "%d\n", stdev->partition);
> +}
> +static DEVICE_ATTR_RO(partition);
> +
> +static ssize_t partition_count_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct switchtec_dev *stdev = to_stdev(dev);
> +
> +	return sprintf(buf, "%d\n", stdev->partition_count);
> +}
> +static DEVICE_ATTR_RO(partition_count);
> +
> +static struct attribute *switchtec_device_attrs[] = {
> +	&dev_attr_device_version.attr,
> +	&dev_attr_fw_version.attr,
> +	&dev_attr_vendor_id.attr,
> +	&dev_attr_product_id.attr,
> +	&dev_attr_product_revision.attr,
> +	&dev_attr_component_vendor.attr,
> +	&dev_attr_component_id.attr,
> +	&dev_attr_component_revision.attr,
> +	&dev_attr_partition.attr,
> +	&dev_attr_partition_count.attr,
> +	NULL,
> +};
> +
> +ATTRIBUTE_GROUPS(switchtec_device);
> +
>  static int switchtec_dev_open(struct inode *inode, struct file *filp)
>  {
>  	struct switchtec_dev *stdev;
> @@ -699,6 +811,7 @@ static struct switchtec_dev *stdev_create(struct pci_dev *pdev)
>  	dev->devt = MKDEV(MAJOR(switchtec_devt), minor);
>  	dev->class = switchtec_class;
>  	dev->parent = &pdev->dev;
> +	dev->groups = switchtec_device_groups;
>  	dev->release = stdev_release;
>  	dev_set_name(dev, "switchtec%d", minor);
>  
> -- 
> 2.1.4
> 
