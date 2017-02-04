Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V5 5/5] LPC: Add the ACPI LPC support
To: "zhichang.yuan" <yuanzhichang@hisilicon.com>, <catalin.marinas@arm.com>,
 <will.deacon@arm.com>, <robh+dt@kernel.org>, <frowand.list@gmail.com>,
 <bhelgaas@google.com>, <rafael@kernel.org>, <mark.rutland@arm.com>,
 <brian.starkey@arm.com>, <olof@lixom.net>, <arnd@arndb.de>,
 <linux-arm-kernel@lists.infradead.org>
References: <1485241525-201782-1-git-send-email-yuanzhichang@hisilicon.com>
 <1485241525-201782-6-git-send-email-yuanzhichang@hisilicon.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <781b05af-1bf2-2be5-f614-5aeff0bc3df3@huawei.com>
Date: Sat, 4 Feb 2017 13:20:46 +0000
MIME-Version: 1.0
In-Reply-To: <1485241525-201782-6-git-send-email-yuanzhichang@hisilicon.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
 gabriele.paoloni@huawei.com, minyard@acm.org, benh@kernel.crashing.org,
 zhichang.yuan02@gmail.com, liviu.dudau@arm.com, linux-kernel@vger.kernel.org,
 xuwei5@hisilicon.com, linuxarm@huawei.com, linux-acpi@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-pci@vger.kernel.org, zourongrong@gmail.com,
 kantyzc@163.com
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

+ linux-acpi

Adding linux-acpi list, which should have been originally included.

The patchset threads have had much discussion, here is a pointer: 
http://www.spinics.net/lists/devicetree/msg160611.html

John

On 24/01/2017 07:05, zhichang.yuan wrote:
> The patch update the _CRS of LPC children with the system logical I/O resource
> after the translation from LPC-local I/O. Then the ACPI platform device
> enumeration for LPC can apply the right I/O resource to request the system I/O
> space.
>
> Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
> ---
>  drivers/bus/hisi_lpc.c |  26 ++++++
>  include/linux/extio.h  |   4 +
>  lib/extio.c            | 228 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 258 insertions(+)
>
> diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
> index a96e384..8d52666 100644
> --- a/drivers/bus/hisi_lpc.c
> +++ b/drivers/bus/hisi_lpc.c
> @@ -583,6 +583,32 @@ static int hisilpc_bus_platform_notify(struct notifier_block *nb,
>  	/* register the linux virtual IO range node to list. */
>  	register_extio(io_node);
>
> +	/*
> +	 * For ACPI children, translate the bus-local I/O range to logical
> +	 * I/O range and set it as the current resource before the children
> +	 * are enumerated.
> +	 */
> +	if (has_acpi_companion(dev)) {
> +		struct acpi_device *root, *child;
> +
> +		root = to_acpi_device_node(dev->fwnode);
> +		/* For hisilpc, only care about the sons of host. */
> +		list_for_each_entry(child, &root->children, node) {
> +			ret = acpi_set_extio_resource(child, root);
> +			if (ret) {
> +				dev_err(dev, "set resource failed..\n");
> +				break;
> +			}
> +		}
> +
> +		if (ret) {
> +			list_del(&io_node->list);
> +			kfree(io_node);
> +			dev_err(dev, "notify handling failed..\n");
> +			return NOTIFY_DONE;
> +		}
> +	}
> +
>  	return NOTIFY_OK;
>  }
>
> diff --git a/include/linux/extio.h b/include/linux/extio.h
> index 2ca7eab..c07607e 100644
> --- a/include/linux/extio.h
> +++ b/include/linux/extio.h
> @@ -20,6 +20,7 @@
>
>  #ifdef __KERNEL__
>
> +#include <linux/acpi.h>
>  #include <linux/fwnode.h>
>
>  struct extio_ops {
> @@ -81,5 +82,8 @@ static inline struct extio_node *extio_find_node(struct fwnode_handle *node)
>  #endif
>  extern void register_extio(struct extio_node *node);
>
> +extern int acpi_set_extio_resource(struct acpi_device *adev,
> +		struct acpi_device *host);
> +
>  #endif /* __KERNEL__ */
>  #endif /* __LINUX_EXTIO_H */
> diff --git a/lib/extio.c b/lib/extio.c
> index 46228de..47f5913 100644
> --- a/lib/extio.c
> +++ b/lib/extio.c
> @@ -75,6 +75,234 @@ unsigned long extio_translate(struct fwnode_handle *node,
>  	return port_id;
>  }
>
> +static inline bool acpi_extio_supported_resource(struct acpi_resource *res)
> +{
> +	switch (res->type) {
> +	case ACPI_RESOURCE_TYPE_ADDRESS16:
> +	case ACPI_RESOURCE_TYPE_ADDRESS32:
> +	case ACPI_RESOURCE_TYPE_ADDRESS64:
> +		return true;
> +	}
> +	return false;
> +}
> +
> +static acpi_status acpi_count_extiores(struct acpi_resource *res,
> +					   void *data)
> +{
> +	int *res_cnt = data;
> +
> +	if (acpi_extio_supported_resource(res) &&
> +		!acpi_dev_filter_resource_type(res, IORESOURCE_IO))
> +		(*res_cnt)++;
> +
> +	return AE_OK;
> +}
> +
> +static acpi_status acpi_read_one_extiores(struct acpi_resource *res,
> +		void *data)
> +{
> +	struct acpi_resource **resource = data;
> +
> +	if (acpi_extio_supported_resource(res) &&
> +		!acpi_dev_filter_resource_type(res, IORESOURCE_IO)) {
> +		memcpy((*resource), res, sizeof(struct acpi_resource));
> +		(*resource)->length = sizeof(struct acpi_resource);
> +		(*resource)->type = res->type;
> +		(*resource)++;
> +	}
> +
> +	return AE_OK;
> +}
> +
> +static acpi_status
> +acpi_build_extiores_template(struct acpi_device *adev,
> +			struct acpi_buffer *buffer)
> +{
> +	acpi_handle handle = adev->handle;
> +	struct acpi_resource *resource;
> +	acpi_status status;
> +	int res_cnt = 0;
> +
> +	status = acpi_walk_resources(handle, METHOD_NAME__PRS,
> +				     acpi_count_extiores, &res_cnt);
> +	if (ACPI_FAILURE(status) || !res_cnt) {
> +		dev_err(&adev->dev, "can't evaluate _CRS: %d\n", status);
> +		return -EINVAL;
> +	}
> +
> +	buffer->length = sizeof(struct acpi_resource) * (res_cnt + 1) + 1;
> +	buffer->pointer = kzalloc(buffer->length - 1, GFP_KERNEL);
> +	if (!buffer->pointer)
> +		return -ENOMEM;
> +
> +	resource = (struct acpi_resource *)buffer->pointer;
> +	status = acpi_walk_resources(handle, METHOD_NAME__PRS,
> +				     acpi_read_one_extiores, &resource);
> +	if (ACPI_FAILURE(status)) {
> +		kfree(buffer->pointer);
> +		dev_err(&adev->dev, "can't evaluate _PRS: %d\n", status);
> +		return -EINVAL;
> +	}
> +
> +	resource->type = ACPI_RESOURCE_TYPE_END_TAG;
> +	resource->length = sizeof(struct acpi_resource);
> +
> +	return 0;
> +}
> +
> +static int acpi_translate_extiores(struct acpi_device *adev,
> +		struct acpi_device *host, struct acpi_buffer *buffer)
> +{
> +	int res_cnt = (buffer->length - 1) / sizeof(struct acpi_resource) - 1;
> +	struct acpi_resource *resource = buffer->pointer;
> +	struct acpi_resource_address64 addr;
> +	unsigned long sys_port;
> +	struct device *dev = &adev->dev;
> +
> +	/* only one I/O resource now */
> +	if (res_cnt != 1) {
> +		dev_err(dev, "encode %d resources whose type is(%d)!\n",
> +			res_cnt, resource->type);
> +		return -EINVAL;
> +	}
> +
> +	if (ACPI_FAILURE(acpi_resource_to_address64(resource, &addr))) {
> +		dev_err(dev, "convert acpi resource(%d) as addr64 FAIL!\n",
> +			resource->type);
> +		return -EFAULT;
> +	}
> +
> +	/* For indirect-IO, addr length must be fixed. (>0, 0, 0) */
> +	if (!addr.address.address_length || addr.min_address_fixed ||
> +		addr.max_address_fixed) {
> +		dev_warn(dev, "variable I/O resource is invalid!\n");
> +		return -EINVAL;
> +	}
> +
> +	sys_port = extio_translate(&host->fwnode, addr.address.minimum);
> +	if (sys_port == -1) {
> +		dev_err(dev, "translate bus-addr(0x%llx) fail!\n",
> +			addr.address.minimum);
> +		return -EFAULT;
> +	}
> +
> +	switch (resource->type) {
> +	case ACPI_RESOURCE_TYPE_ADDRESS16:
> +	{
> +		struct acpi_resource_address16 *out_res;
> +
> +		out_res = &resource->data.address16;
> +		out_res->address.minimum = sys_port;
> +		out_res->address.maximum = sys_port +
> +			addr.address.address_length - 1;
> +
> +		dev_info(dev, "_SRS 16IO: [0x%x - 0x%x]\n",
> +			out_res->address.minimum,
> +			out_res->address.maximum);
> +
> +		break;
> +	}
> +
> +	case ACPI_RESOURCE_TYPE_ADDRESS32:
> +	{
> +		struct acpi_resource_address32 *out_res;
> +
> +		out_res = &resource->data.address32;
> +		out_res->address.minimum = sys_port;
> +		out_res->address.maximum = sys_port +
> +			addr.address.address_length - 1;
> +
> +		dev_info(dev, "_SRS 32IO: [0x%x - 0x%x]\n",
> +			out_res->address.minimum,
> +			out_res->address.maximum);
> +
> +		break;
> +	}
> +
> +	case ACPI_RESOURCE_TYPE_ADDRESS64:
> +	{
> +		struct acpi_resource_address64 *out_res;
> +
> +		out_res = &resource->data.address64;
> +		out_res->address.minimum = sys_port;
> +		out_res->address.maximum = sys_port +
> +			addr.address.address_length - 1;
> +
> +		dev_info(dev, "_SRS 64IO: [0x%llx - 0x%llx]\n",
> +			out_res->address.minimum,
> +			out_res->address.maximum);
> +
> +		break;
> +	}
> +
> +	default:
> +		return -EINVAL;
> +
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * update/set the current I/O resource of the designated device node.
> + * after this calling, the enumeration can be started as the I/O resource
> + * had been translated to logicial I/O from bus-local I/O.
> + *
> + * @adev: the device node to be updated the I/O resource;
> + * @host: the device node where 'adev' is attached, which can be not
> + *	the parent of 'adev';
> + *
> + * return 0 when successful, negative is for failure.
> + */
> +int acpi_set_extio_resource(struct acpi_device *adev,
> +		struct acpi_device *host)
> +{
> +	struct device *dev = &adev->dev;
> +	struct acpi_buffer buffer;
> +	acpi_status status;
> +	int ret;
> +
> +	if (!host)
> +		return -EINVAL;
> +
> +	/* check the device state */
> +	if (!adev->status.present) {
> +		dev_info(dev, "ACPI: device is not present!\n");
> +		return 0;
> +	}
> +	/* whether the child had been enumerated? */
> +	if (acpi_device_enumerated(adev)) {
> +		dev_info(dev, "ACPI: had been enumerated!\n");
> +		return 0;
> +	}
> +
> +	/* read the _PRS and convert as acpi_buffer */
> +	status = acpi_build_extiores_template(adev, &buffer);
> +	if (ACPI_FAILURE(status)) {
> +		dev_warn(dev, "Failure evaluating %s\n",
> +				METHOD_NAME__PRS);
> +		return -ENODEV;
> +	}
> +
> +	/* translate the I/O resources */
> +	ret = acpi_translate_extiores(adev, host, &buffer);
> +	if (ret) {
> +		kfree(buffer.pointer);
> +		dev_err(dev, "Translate I/O range FAIL!\n");
> +		return ret;
> +	}
> +
> +	/* set current resource... */
> +	status = acpi_set_current_resources(adev->handle, &buffer);
> +	kfree(buffer.pointer);
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(dev, "Error evaluating _SRS (0x%x)\n", status);
> +		ret = -EIO;
> +	}
> +
> +	return ret;
> +}
> +
>  #ifdef PCI_IOBASE
>
>  #define BUILD_EXTIO(bw, type)						\
>



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
