Return-Path: <SRS0=pWib=7S=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=pWib=7S=huawei.com=liudongdong3@kernel.org>
Subject: Re: [PATCH] PCIe AER: report non fatal errors only to the functions
 of the same device
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1501813106-89672-1-git-send-email-liudongdong3@huawei.com>
 <20170815225007.GS32525@bhelgaas-glaptop.roam.corp.google.com>
CC: <linux-pci@vger.kernel.org>, <gabriele.paoloni@huawei.com>,
        <charles.chenxin@huawei.com>, <linuxarm@huawei.com>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <025ad3e8-7411-6e97-29ba-6e5cfa7665eb@huawei.com>
Date: Wed, 16 Aug 2017 16:50:16 +0800
MIME-Version: 1.0
In-Reply-To: <20170815225007.GS32525@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn

在 2017/8/16 6:50, Bjorn Helgaas 写道:
> On Fri, Aug 04, 2017 at 10:18:26AM +0800, Dongdong Liu wrote:
>> From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>>
>> Currently if an uncorrectable error is reported by an EP the AER
>> driver walks over all the devices connected to the upstream port
>> bus and in turns call the report_error_detected() callback.
>> If any of the devices connected to the bus does not implement
>> dev->driver->err_handler->error_detected() do_recovery() will fail.
>>
>> However for non fatal errors the PCIe link should not be considered
>> compromised, therefore it makes sense to report the error only to
>> all the functions of a multifunction device.
>> This patch implements this new behaviour for non fatal errors.
>
> Why do we bother even with other functions in the same multifunction
> device?  PCIe r3.1, sec 6.2.2.2.2, says non-fatal errors only affect a
> particular transaction, and "devices not associated with the
> transaction in error are not impacted."
>
> A transaction is only associated with one function, so other functions
> in the same device shouldn't be affected, should they?

PCIe r3.1, sec 6.2.4 Error Logging
PCI Express errors are not Function-specific.
"Software is responsible for scanning all Functions in a multi-Function device when it detects one of those errors"

Thanks,
Dongdong
>
>> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
>> ---
>>  drivers/pci/bus.c                  | 38 ++++++++++++++++++++++++++++++++++++++
>>  drivers/pci/pcie/aer/aerdrv_core.c | 13 ++++++++++++-
>>  include/linux/pci.h                |  3 ++-
>>  3 files changed, 52 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
>> index bc56cf1..bc8f8b2 100644
>> --- a/drivers/pci/bus.c
>> +++ b/drivers/pci/bus.c
>> @@ -364,6 +364,44 @@ void pci_bus_add_devices(const struct pci_bus *bus)
>>  }
>>  EXPORT_SYMBOL(pci_bus_add_devices);
>>
>> +/** pci_walk_mf_dev - walk all functions of a multi-function
>> + *  device calling callback.
>> + *  @dev      a function in a multi-function device
>> + *  @cb       callback to be called for each device found
>> + *  @userdata arbitrary pointer to be passed to callback.
>> + *
>> + *  Walk, on a given bus, only the adjacent functions of a
>> + *  multi-function device. Call the provided callback on each
>> + *  device found.
>> + *
>> + *  We check the return of @cb each time. If it returns anything
>> + *  other than 0, we break out.
>> + *
>> + */
>> +void pci_walk_mf_dev(struct pci_dev *dev, int (*cb)(struct pci_dev *, void *),
>> +		  void *userdata)
>> +{
>> +	int retval;
>> +	struct pci_bus *bus;
>> +	struct pci_dev *pdev;
>> +	int ndev;
>> +
>> +	bus = dev->bus;
>> +	ndev = PCI_SLOT(dev->devfn);
>> +
>> +	down_read(&pci_bus_sem);
>> +	/* call cb for all the functions of the mf device */
>> +	list_for_each_entry(pdev, &bus->devices, bus_list) {
>> +		if (PCI_SLOT(pdev->devfn) == ndev) {
>> +			retval = cb(pdev, userdata);
>> +			if (retval)
>> +				break;
>> +		}
>> +	}
>> +	up_read(&pci_bus_sem);
>> +}
>> +EXPORT_SYMBOL_GPL(pci_walk_mf_dev);
>> +
>>  /** pci_walk_bus - walk devices on/under bus, calling callback.
>>   *  @top      bus whose devices should be walked
>>   *  @cb       callback to be called for each device found
>> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
>> index b1303b3..67c3dc0 100644
>> --- a/drivers/pci/pcie/aer/aerdrv_core.c
>> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
>> @@ -390,7 +390,18 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
>>  		 * If the error is reported by an end point, we think this
>>  		 * error is related to the upstream link of the end point.
>>  		 */
>> -		pci_walk_bus(dev->bus, cb, &result_data);
>> +		if ((state == pci_channel_io_normal) &&
>> +				(!pci_ari_enabled(dev->bus)))
>> +			/*
>> +			 * the error is non fatal so the bus is ok, just walk
>> +			 * through all the functions in a multifunction device.
>> +			 * if ARI is enabled on the bus then there can be only
>> +			 * one device under that bus (so walk all the functions
>> +			 * under the bus).
>> +			 */
>> +			pci_walk_mf_dev(dev, cb, &result_data);
>> +		else
>> +			pci_walk_bus(dev->bus, cb, &result_data);
>>  	}
>>
>>  	return result_data.result;
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 4869e66..69e77bb 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1269,7 +1269,8 @@ const struct pci_device_id *pci_match_id(const struct pci_device_id *ids,
>>  					 struct pci_dev *dev);
>>  int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
>>  		    int pass);
>> -
>> +void pci_walk_mf_dev(struct pci_dev *dev, int (*cb)(struct pci_dev *, void *),
>> +		  void *userdata);
>>  void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
>>  		  void *userdata);
>>  int pci_cfg_space_size(struct pci_dev *dev);
>> --
>> 1.9.1
>>
>
> .
>
