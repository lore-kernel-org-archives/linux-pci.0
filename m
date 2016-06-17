Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH V6 1/7] ACPI: I/O Remapping Table (IORT) initial support
To: Marc Zyngier <marc.zyngier@arm.com>, rjw@rjwysocki.net,
	lorenzo.pieralisi@arm.com
References: <1465828873-23498-1-git-send-email-tn@semihalf.com>
 <1465828873-23498-2-git-send-email-tn@semihalf.com>
 <20160615093127.01c0a2af@arm.com>
Cc: tglx@linutronix.de, jason@lakedaemon.net, bhelgaas@google.com,
	robert.richter@caviumnetworks.com, shijie.huang@arm.com,
	Suravee.Suthikulpanit@amd.com, hanjun.guo@linaro.org,
	al.stone@linaro.org, mw@semihalf.com, graeme.gregory@linaro.org,
	Catalin.Marinas@arm.com, will.deacon@arm.com,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ddaney.cavm@gmail.com,
	okaya@codeaurora.org, andrea.gallo@linaro.org,
	linux-pci@vger.kernel.org
Message-ID: <576403D5.1070902@semihalf.com>
Date: Fri, 17 Jun 2016 16:06:13 +0200
MIME-Version: 1.0
In-Reply-To: <20160615093127.01c0a2af@arm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 15.06.2016 10:31, Marc Zyngier wrote:
> On Mon, 13 Jun 2016 16:41:07 +0200
> Tomasz Nowicki <tn@semihalf.com> wrote:
>
>> IORT shows representation of IO topology for ARM based systems.
>> It describes how various components are connected together on
>> parent-child basis e.g. PCI RC -> SMMU -> ITS. Also see IORT spec.
>>
>> Initial support allows to:
>> - register ITS MSI chip along with ITS translation ID and domain token
>> - deregister ITS MSI chip based on ITS translation ID
>> - find registered domain token based on ITS translation ID
>> - map MSI RID for a device
>> - find domain token for a device
>>
>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> ---
>>   drivers/acpi/Kconfig  |   3 +
>>   drivers/acpi/Makefile |   1 +
>>   drivers/acpi/iort.c   | 386 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/iort.h  |  38 +++++
>>   4 files changed, 428 insertions(+)
>>   create mode 100644 drivers/acpi/iort.c
>>   create mode 100644 include/linux/iort.h
>>

[...]

>> +
>> +static struct acpi_iort_node *
>> +iort_node_map_rid(struct acpi_iort_node *node, u32 rid_in,
>> +		  u32 *rid_out, u8 type)
>> +{
>> +
>> +	if (!node)
>> +		goto out;
>> +
>> +	/* Go upstream */
>> +	while (node->type != type) {
>> +		struct acpi_iort_id_mapping *id;
>> +		int i, found = 0;
>> +
>> +		/* Exit when no mapping array */
>> +		if (!node->mapping_offset || !node->mapping_count)
>> +			return NULL;
>> +
>> +		id = ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
>> +				  node->mapping_offset);
>> +
>> +		for (i = 0, found = 0; i < node->mapping_count; i++, id++) {
>> +			/*
>> +			 * Single mapping is not translation rule,
>> +			 * lets move on for this case
>> +			 */
>> +			if (id->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
>> +				if (node->type != ACPI_IORT_NODE_SMMU) {
>> +					rid_in = id->output_base;
>> +					found = 1;
>> +					break;
>> +				}
>> +
>> +				pr_warn(FW_BUG "[node %p type %d] SINGLE MAPPING flag not allowed for SMMU node, skipping ID map\n",
>> +					node, node->type);
>> +				continue;
>> +			}
>> +
>> +			if (rid_in < id->input_base ||
>> +			    (rid_in > id->input_base + id->id_count))
>> +				continue;
>> +
>> +			rid_in = id->output_base + (rid_in - id->input_base);
>> +			found = 1;
>> +			break;
>> +		}
>> +
>> +		if (!found)
>> +			return NULL;
>
> Why this special case? It would make more sense to use the normal
> epilogue, and update rid_out. Unless not finding a translation for a
> given rid is illegal?

We can use the same strategy as __of_msi_map_rid() which means we simply 
use rid_in in case of any error. I will update accordingly.

>
>> +
>> +		/* Firmware bug! */
>> +		if (!id->output_reference) {
>> +			pr_err(FW_BUG "[node %p type %d] ID map has NULL parent reference\n",
>> +			       node, node->type);
>> +			return NULL;
>> +		}
>> +
>> +		node = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
>> +				    id->output_reference);
>> +	}
>> +
>> +out:
>> +	if (rid_out)
>> +		*rid_out = rid_in;
>> +	return node;
>> +}
>> +
>> +static struct acpi_iort_node *
>> +iort_find_dev_node(struct device *dev)
>> +{
>> +	struct pci_bus *pbus;
>> +
>> +	if (!dev_is_pci(dev))
>> +		return iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
>> +				      iort_match_node_callback, dev);
>> +
>> +	/* Find a PCI root bus */
>> +	pbus = to_pci_dev(dev)->bus;
>> +	while (!pci_is_root_bus(pbus))
>> +		pbus = pbus->parent;
>> +
>> +	return iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
>> +			      iort_match_node_callback, &pbus->dev);
>> +}
>> +
>> +/**
>> + * iort_msi_map_rid() - Map a MSI requester ID for a device
>> + * @dev: The device for which the mapping is to be done.
>> + * @req_id: The device requester ID.
>> + *
>> + * Returns: mapped MSI RID on success, input requester ID otherwise
>> + */
>> +u32 iort_msi_map_rid(struct device *dev, u32 req_id)
>> +{
>> +	struct acpi_iort_node *node;
>> +	u32 dev_id;
>> +
>> +	if (!iort_table)
>> +		return req_id;
>> +
>> +	node = iort_find_dev_node(dev);
>> +	if (!node) {
>> +		dev_err(dev, "can't find related IORT node\n");
>> +		return req_id;
>> +	}
>> +
>> +	if (!iort_node_map_rid(node, req_id, &dev_id,
>> +			       ACPI_IORT_NODE_ITS_GROUP))
>> +		return req_id;
>
> And once you've fixed the special case in iort_node_map_rid, you can
> unconditionally return dev_id.

Right.

>
>> +
>> +	return dev_id;
>> +}
>> +
>> +/**
>> + * iort_dev_find_its_id() - Find the ITS identifier for a device
>> + * @dev: The device.
>> + * @idx: Index of the ITS identifier list.
>> + * @its_id: ITS identifier.
>> + *
>> + * Returns: 0 on success, appropriate error value otherwise
>> + */
>> +static int
>> +iort_dev_find_its_id(struct device *dev, u32 req_id, unsigned int idx,
>> +		     int *its_id)
>> +{
>> +	struct acpi_iort_its_group *its;
>> +	struct acpi_iort_node *node;
>> +
>> +	node = iort_find_dev_node(dev);
>> +	if (!node) {
>> +		dev_err(dev, "can't find related IORT node\n");
>> +		return -ENXIO;
>> +	}
>> +
>> +	node = iort_node_map_rid(node, req_id, NULL, ACPI_IORT_NODE_ITS_GROUP);
>> +	if (!node) {
>> +		dev_err(dev, "can't find related ITS node\n");
>> +		return -ENXIO;
>> +	}
>> +
>> +	/* Move to ITS specific data */
>> +	its = (struct acpi_iort_its_group *)node->node_data;
>> +	if (idx > its->its_count) {
>> +		dev_err(dev, "requested ITS ID index [%d] is greater than available [%d]\n",
>> +			idx, its->its_count);
>> +		return -ENXIO;
>> +	}
>> +
>> +	*its_id = its->identifiers[idx];
>> +	return 0;
>> +}
>> +
>> +/**
>> + * iort_get_device_domain() - Find MSI domain related to a device
>> + * @dev: The device.
>> + * @req_id: Requester ID for the device.
>> + *
>> + * Returns: the MSI domain for this device, NULL otherwise
>> + */
>> +struct irq_domain *
>> +iort_get_device_domain(struct device *dev, u32 req_id)
>> +{
>> +	static struct fwnode_handle *handle;
>> +	int its_id;
>> +
>> +	if (!iort_table)
>> +		return NULL;
>> +
>> +	if (iort_dev_find_its_id(dev, req_id, 0, &its_id))
>> +		return NULL;
>> +
>> +	handle = iort_find_domain_token(its_id);
>> +	if (!handle)
>> +		return NULL;
>
> Can this actually happen? I can't see how, unless you have a race
> between iort_dev_find_its_id and iort_find_domain_token. And given that
> both these functions are only called from here, maybe you're better off
> having a single function:
>
> struct fwnode_handle *iort_dev_find_its_domain_token(struct device *dev,
> 						     u32 rid);
>
> which returns the atomic lookup of the ITS handle. Or is there any
> constraints preventing us from holding the lock?

Yes this may happen, let's say we have one ITS with ID = 0:
1. iort_register_domain_token() fails because of lack of memory (-ENOMEM)
2. iort_dev_find_its_id() would point us to ITS with ID = 0
3. iort_find_domain_token() return NULL due to no element on the list 
for ITS ID = 0

Actually iort_dev_find_its_id() finds out ITS ID related to a given 
device, it only interact with IORT content but not with 
iort_msi_chip_list list. iort_find_domain_token() has its own lock for 
iort_msi_chip_list so I am not sure why we need lock.

Thanks,
Tomasz
