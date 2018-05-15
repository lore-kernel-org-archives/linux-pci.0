Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from david.siemens.de ([192.35.17.14]:60343 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752215AbeEOIhP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 May 2018 04:37:15 -0400
Subject: Re: [PATCH v3 6/8] PCI: Rework of_pci_get_host_bridge_resources() to
 devm_of_pci_get_host_bridge_resources()
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <cover.1526363896.git.jan.kiszka@siemens.com>
 <4ae78ed8c3d866446f8322c1df4a19c2ca4fef58.1526363896.git.jan.kiszka@siemens.com>
 <c4272d78-780b-ab9e-8ecb-0de4983bb757@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b82f93d6-5e3b-865f-7fe9-a660fcf355b9@siemens.com>
Date: Tue, 15 May 2018 10:36:36 +0200
MIME-Version: 1.0
In-Reply-To: <c4272d78-780b-ab9e-8ecb-0de4983bb757@mentor.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-05-15 09:54, Vladimir Zapolskiy wrote:
> Hi Jan,
> 
> On 05/15/2018 08:58 AM, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> of_pci_get_host_bridge_resources() allocates the resource structures it
>> fills dynamically, but none of its callers care to release them so far.
>> Rather than requiring everyone to do this explicitly, convert the
>> existing function to a managed version.
>>
>> CC: Jingoo Han <jingoohan1@gmail.com>
>> CC: Joao Pinto <Joao.Pinto@synopsys.com>
>> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> [snip]
> 
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index 4f21514cb4e4..00f42389aa56 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -244,7 +244,8 @@ EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
>>  
>>  #if defined(CONFIG_OF_ADDRESS)
>>  /**
>> - * of_pci_get_host_bridge_resources - Parse PCI host bridge resources from DT
>> + * devm_of_pci_get_host_bridge_resources() - Resource-managed parsing of PCI
>> + *                                           host bridge resources from DT
>>   * @dev: host bridge device
>>   * @busno: bus number associated with the bridge root bus
>>   * @bus_max: maximum number of buses for this bridge
>> @@ -253,8 +254,6 @@ EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
>>   * address for the start of the I/O range. Can be NULL if the caller doesn't
>>   * expect I/O ranges to be present in the device tree.
>>   *
>> - * It is the caller's job to free the @resources list.
>> - *
>>   * This function will parse the "ranges" property of a PCI host bridge device
>>   * node and setup the resource mapping based on its content. It is expected
>>   * that the property conforms with the Power ePAPR document.
>> @@ -262,12 +261,11 @@ EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
>>   * It returns zero if the range parsing has been successful or a standard error
>>   * value if it failed.
>>   */
>> -int of_pci_get_host_bridge_resources(struct device *dev,
>> +int devm_of_pci_get_host_bridge_resources(struct device *dev,
>>  			unsigned char busno, unsigned char bus_max,
>>  			struct list_head *resources, resource_size_t *io_base)
>>  {
>>  	struct device_node *dev_node = dev->of_node;
>> -	struct resource_entry *window;
>>  	struct resource *res;
>>  	struct resource *bus_range;
>>  	struct of_pci_range range;
>> @@ -278,7 +276,7 @@ int of_pci_get_host_bridge_resources(struct device *dev,
>>  	if (io_base)
>>  		*io_base = (resource_size_t)OF_BAD_ADDR;
>>  
>> -	bus_range = kzalloc(sizeof(*bus_range), GFP_KERNEL);
>> +	bus_range = devm_kzalloc(dev, sizeof(*bus_range), GFP_KERNEL);
>>  	if (!bus_range)
>>  		return -ENOMEM;
>>  
>> @@ -300,7 +298,7 @@ int of_pci_get_host_bridge_resources(struct device *dev,
>>  	/* Check for ranges property */
>>  	err = of_pci_range_parser_init(&parser, dev_node);
>>  	if (err)
>> -		goto parse_failed;
>> +		return err;
> 
> In my opinion allocated by pci_add_resource() and pci_add_resource_offset()
> resource entries are leaked on error paths, and pci_free_resource_list() should
> be called.

Indeed, I overshot with removing also pci_free_resource_list. v4 will
follow.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
