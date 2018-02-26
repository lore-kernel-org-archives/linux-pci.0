Return-Path: <SRS0=dmwJ=FU=codeaurora.org=poza@kernel.org>
Return-Path: <SRS0=dmwJ=FU=codeaurora.org=poza@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Mon, 26 Feb 2018 11:09:18 +0530
From: poza@codeaurora.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Keith
 Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>, Sinan Kaya
 <okaya@codeaurora.org>, Timur Tabi <timur@codeaurora.org>,
 linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH v11 2/7] PCI/AER: factor out error reporting from AER
In-Reply-To: <3e536e31983d0bed397e10bb542f2a72@codeaurora.org>
References: <1519374244-20539-1-git-send-email-poza@codeaurora.org>
 <1519374244-20539-3-git-send-email-poza@codeaurora.org>
 <20180223234232.GP14632@bhelgaas-glaptop.roam.corp.google.com>
 <3e536e31983d0bed397e10bb542f2a72@codeaurora.org>
Message-ID: <c491b315279578a9c5469b33840f65d6@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2018-02-26 11:02, poza@codeaurora.org wrote:
> On 2018-02-24 05:12, Bjorn Helgaas wrote:
>> On Fri, Feb 23, 2018 at 01:53:59PM +0530, Oza Pawandeep wrote:
>>> This patch factors out error reporting callbacks, which are currently
>>> tightly coupled with AER.
>> 
>> Add blank line between paragraphs.
>> 
>>> DPC should be able to register callbacks and attmept recovery when 
>>> DPC
>>> trigger event occurs.
>> 
>> s/attmept/attempt/
>> 
>> This patch basically moves code from aerdrv_core.c to pcie-err.c.  
>> Make it
>> do *only* that.
>> 
> 
> sure.
> 
>>> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
>>> 
>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>> index fcd8191..abc514e 100644
>>> --- a/drivers/pci/pci.h
>>> +++ b/drivers/pci/pci.h
>>> @@ -342,6 +342,9 @@ static inline resource_size_t 
>>> pci_resource_alignment(struct pci_dev *dev,
>>> 
>>>  void pci_enable_acs(struct pci_dev *dev);
>>> 
>>> +/* PCI error reporting and recovery */
>>> +void pcie_do_recovery(struct pci_dev *dev, int severity);
>> 
>> Add this declaration in the first patch, the one where you rename the
>> function.
>> 
> 
> done.
> 
>>>  #ifdef CONFIG_PCIEASPM
>>>  void pcie_aspm_init_link_state(struct pci_dev *pdev);
>>>  void pcie_aspm_exit_link_state(struct pci_dev *pdev);
>>> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
>>> index 223e4c3..d669497 100644
>>> --- a/drivers/pci/pcie/Makefile
>>> +++ b/drivers/pci/pcie/Makefile
>>> @@ -6,7 +6,7 @@
>>>  # Build PCI Express ASPM if needed
>>>  obj-$(CONFIG_PCIEASPM)		+= aspm.o
>>> 
>>> -pcieportdrv-y			:= portdrv_core.o portdrv_pci.o portdrv_bus.o
>>> +pcieportdrv-y			:= portdrv_core.o portdrv_pci.o portdrv_bus.o 
>>> pcie-err.o
>> 
>> Can we name this just "drivers/pci/pcie/err.c"?  I know we have
>> pcie-dpc.c already, but it does get a little repetitious to type
>> "pci" THREE times in that path.
>> 
> 
> sure, will rename.
> 
>>>  pcieportdrv-$(CONFIG_ACPI)	+= portdrv_acpi.o
>>> 
>>>  obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
>>> diff --git a/drivers/pci/pcie/aer/aerdrv.h 
>>> b/drivers/pci/pcie/aer/aerdrv.h
>>> index 5449e5c..bc9db53 100644
>>> --- a/drivers/pci/pcie/aer/aerdrv.h
>>> +++ b/drivers/pci/pcie/aer/aerdrv.h
>>> @@ -76,36 +76,6 @@ struct aer_rpc {
>>>  					 */
>>>  };
>>> 
>>> -struct aer_broadcast_data {
>>> -	enum pci_channel_state state;
>>> -	enum pci_ers_result result;
>>> -};
>>> -
>>> -static inline pci_ers_result_t merge_result(enum pci_ers_result 
>>> orig,
>>> -		enum pci_ers_result new)
>>> -{
>>> -	if (new == PCI_ERS_RESULT_NO_AER_DRIVER)
>>> -		return PCI_ERS_RESULT_NO_AER_DRIVER;
>>> -
>>> -	if (new == PCI_ERS_RESULT_NONE)
>>> -		return orig;
>>> -
>>> -	switch (orig) {
>>> -	case PCI_ERS_RESULT_CAN_RECOVER:
>>> -	case PCI_ERS_RESULT_RECOVERED:
>>> -		orig = new;
>>> -		break;
>>> -	case PCI_ERS_RESULT_DISCONNECT:
>>> -		if (new == PCI_ERS_RESULT_NEED_RESET)
>>> -			orig = PCI_ERS_RESULT_NEED_RESET;
>>> -		break;
>>> -	default:
>>> -		break;
>>> -	}
>>> -
>>> -	return orig;
>>> -}
>>> -
>>>  extern struct bus_type pcie_port_bus_type;
>>>  void aer_isr(struct work_struct *work);
>>>  void aer_print_error(struct pci_dev *dev, struct aer_err_info 
>>> *info);
>>> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c 
>>> b/drivers/pci/pcie/aer/aerdrv_core.c
>>> index aeb83a0..f60b1bb 100644
>>> --- a/drivers/pci/pcie/aer/aerdrv_core.c
>>> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
>>> @@ -23,6 +23,7 @@
>>>  #include <linux/slab.h>
>>>  #include <linux/kfifo.h>
>>>  #include "aerdrv.h"
>>> +#include "../../pci.h"
>>> 
>>>  #define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | 
>>> PCI_EXP_DEVCTL_NFERE | \
>>>  				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
>>> @@ -230,191 +231,6 @@ static bool find_source_device(struct pci_dev 
>>> *parent,
>>>  	return true;
>>>  }
>>> 
>>> -static int report_error_detected(struct pci_dev *dev, void *data)
>>> -{
>>> -	pci_ers_result_t vote;
>>> -	const struct pci_error_handlers *err_handler;
>>> -	struct aer_broadcast_data *result_data;
>>> -	result_data = (struct aer_broadcast_data *) data;
>>> -
>>> -	device_lock(&dev->dev);
>>> -	dev->error_state = result_data->state;
>>> -
>>> -	if (!dev->driver ||
>>> -		!dev->driver->err_handler ||
>>> -		!dev->driver->err_handler->error_detected) {
>>> -		if (result_data->state == pci_channel_io_frozen &&
>>> -			dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
>>> -			/*
>>> -			 * In case of fatal recovery, if one of down-
>>> -			 * stream device has no driver. We might be
>>> -			 * unable to recover because a later insmod
>>> -			 * of a driver for this device is unaware of
>>> -			 * its hw state.
>>> -			 */
>>> -			pci_printk(KERN_DEBUG, dev, "device has %s\n",
>>> -				   dev->driver ?
>>> -				   "no AER-aware driver" : "no driver");
>>> -		}
>>> -
>>> -		/*
>>> -		 * If there's any device in the subtree that does not
>>> -		 * have an error_detected callback, returning
>>> -		 * PCI_ERS_RESULT_NO_AER_DRIVER prevents calling of
>>> -		 * the subsequent mmio_enabled/slot_reset/resume
>>> -		 * callbacks of "any" device in the subtree. All the
>>> -		 * devices in the subtree are left in the error state
>>> -		 * without recovery.
>>> -		 */
>>> -
>>> -		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
>>> -			vote = PCI_ERS_RESULT_NO_AER_DRIVER;
>>> -		else
>>> -			vote = PCI_ERS_RESULT_NONE;
>>> -	} else {
>>> -		err_handler = dev->driver->err_handler;
>>> -		vote = err_handler->error_detected(dev, result_data->state);
>>> -		pci_uevent_ers(dev, PCI_ERS_RESULT_NONE);
>>> -	}
>>> -
>>> -	result_data->result = merge_result(result_data->result, vote);
>>> -	device_unlock(&dev->dev);
>>> -	return 0;
>>> -}
>>> -
>>> -static int report_mmio_enabled(struct pci_dev *dev, void *data)
>>> -{
>>> -	pci_ers_result_t vote;
>>> -	const struct pci_error_handlers *err_handler;
>>> -	struct aer_broadcast_data *result_data;
>>> -	result_data = (struct aer_broadcast_data *) data;
>>> -
>>> -	device_lock(&dev->dev);
>>> -	if (!dev->driver ||
>>> -		!dev->driver->err_handler ||
>>> -		!dev->driver->err_handler->mmio_enabled)
>>> -		goto out;
>>> -
>>> -	err_handler = dev->driver->err_handler;
>>> -	vote = err_handler->mmio_enabled(dev);
>>> -	result_data->result = merge_result(result_data->result, vote);
>>> -out:
>>> -	device_unlock(&dev->dev);
>>> -	return 0;
>>> -}
>>> -
>>> -static int report_slot_reset(struct pci_dev *dev, void *data)
>>> -{
>>> -	pci_ers_result_t vote;
>>> -	const struct pci_error_handlers *err_handler;
>>> -	struct aer_broadcast_data *result_data;
>>> -	result_data = (struct aer_broadcast_data *) data;
>>> -
>>> -	device_lock(&dev->dev);
>>> -	if (!dev->driver ||
>>> -		!dev->driver->err_handler ||
>>> -		!dev->driver->err_handler->slot_reset)
>>> -		goto out;
>>> -
>>> -	err_handler = dev->driver->err_handler;
>>> -	vote = err_handler->slot_reset(dev);
>>> -	result_data->result = merge_result(result_data->result, vote);
>>> -out:
>>> -	device_unlock(&dev->dev);
>>> -	return 0;
>>> -}
>>> -
>>> -static int report_resume(struct pci_dev *dev, void *data)
>>> -{
>>> -	const struct pci_error_handlers *err_handler;
>>> -
>>> -	device_lock(&dev->dev);
>>> -	dev->error_state = pci_channel_io_normal;
>>> -
>>> -	if (!dev->driver ||
>>> -		!dev->driver->err_handler ||
>>> -		!dev->driver->err_handler->resume)
>>> -		goto out;
>>> -
>>> -	err_handler = dev->driver->err_handler;
>>> -	err_handler->resume(dev);
>>> -	pci_uevent_ers(dev, PCI_ERS_RESULT_RECOVERED);
>>> -out:
>>> -	device_unlock(&dev->dev);
>>> -	return 0;
>>> -}
>>> -
>>> -/**
>>> - * broadcast_error_message - handle message broadcast to downstream 
>>> drivers
>>> - * @dev: pointer to from where in a hierarchy message is broadcasted 
>>> down
>>> - * @state: error state
>>> - * @error_mesg: message to print
>>> - * @cb: callback to be broadcasted
>>> - *
>>> - * Invoked during error recovery process. Once being invoked, the 
>>> content
>>> - * of error severity will be broadcasted to all downstream drivers 
>>> in a
>>> - * hierarchy in question.
>>> - */
>>> -static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
>>> -	enum pci_channel_state state,
>>> -	char *error_mesg,
>>> -	int (*cb)(struct pci_dev *, void *))
>>> -{
>>> -	struct aer_broadcast_data result_data;
>>> -
>>> -	pci_printk(KERN_DEBUG, dev, "broadcast %s message\n", error_mesg);
>>> -	result_data.state = state;
>>> -	if (cb == report_error_detected)
>>> -		result_data.result = PCI_ERS_RESULT_CAN_RECOVER;
>>> -	else
>>> -		result_data.result = PCI_ERS_RESULT_RECOVERED;
>>> -
>>> -	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
>>> -		/*
>>> -		 * If the error is reported by a bridge, we think this error
>>> -		 * is related to the downstream link of the bridge, so we
>>> -		 * do error recovery on all subordinates of the bridge instead
>>> -		 * of the bridge and clear the error status of the bridge.
>>> -		 */
>>> -		if (cb == report_error_detected)
>>> -			dev->error_state = state;
>>> -		pci_walk_bus(dev->subordinate, cb, &result_data);
>>> -		if (cb == report_resume) {
>>> -			pci_cleanup_aer_uncorrect_error_status(dev);
>>> -			dev->error_state = pci_channel_io_normal;
>>> -		}
>>> -	} else {
>>> -		/*
>>> -		 * If the error is reported by an end point, we think this
>>> -		 * error is related to the upstream link of the end point.
>>> -		 */
>>> -		if (state == pci_channel_io_normal)
>>> -			/*
>>> -			 * the error is non fatal so the bus is ok, just invoke
>>> -			 * the callback for the function that logged the error.
>>> -			 */
>>> -			cb(dev, &result_data);
>>> -		else
>>> -			pci_walk_bus(dev->bus, cb, &result_data);
>>> -	}
>>> -
>>> -	return result_data.result;
>>> -}
>>> -
>>> -/**
>>> - * default_reset_link - default reset function
>>> - * @dev: pointer to pci_dev data structure
>>> - *
>>> - * Invoked when performing link reset on a Downstream Port or a
>>> - * Root Port with no aer driver.
>>> - */
>>> -static pci_ers_result_t default_reset_link(struct pci_dev *dev)
>>> -{
>>> -	pci_reset_bridge_secondary_bus(dev);
>>> -	pci_printk(KERN_DEBUG, dev, "downstream link has been reset\n");
>>> -	return PCI_ERS_RESULT_RECOVERED;
>>> -}
>>> -
>>>  static int find_aer_service_iter(struct device *device, void *data)
>>>  {
>>>  	struct pcie_port_service_driver *service_driver, **drv;
>>> @@ -432,7 +248,7 @@ static int find_aer_service_iter(struct device 
>>> *device, void *data)
>>>  	return 0;
>>>  }
>>> 
>>> -static struct pcie_port_service_driver *find_aer_service(struct 
>>> pci_dev *dev)
>>> +struct pcie_port_service_driver *pci_find_aer_service(struct pci_dev 
>>> *dev)
>> 
>> Move this rename to a different patch.  The new name should probably
>> start with "pcie" like you did with pcie_do_recovery().
>> 
> 
> sure, will do that.
> 
>>>  {
>>>  	struct pcie_port_service_driver *drv = NULL;
>>> 
>>> @@ -440,107 +256,7 @@ static struct pcie_port_service_driver 
>>> *find_aer_service(struct pci_dev *dev)
>>> 
>>>  	return drv;
>>>  }
>>> -
>>> -static pci_ers_result_t reset_link(struct pci_dev *dev)
>>> -{
>>> -	struct pci_dev *udev;
>>> -	pci_ers_result_t status;
>>> -	struct pcie_port_service_driver *driver;
>>> -
>>> -	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
>>> -		/* Reset this port for all subordinates */
>>> -		udev = dev;
>>> -	} else {
>>> -		/* Reset the upstream component (likely downstream port) */
>>> -		udev = dev->bus->self;
>>> -	}
>>> -
>>> -	/* Use the aer driver of the component firstly */
>>> -	driver = find_aer_service(udev);
>>> -
>>> -	if (driver && driver->reset_link) {
>>> -		status = driver->reset_link(udev);
>>> -	} else if (udev->has_secondary_link) {
>>> -		status = default_reset_link(udev);
>>> -	} else {
>>> -		pci_printk(KERN_DEBUG, dev, "no link-reset support at upstream 
>>> device %s\n",
>>> -			pci_name(udev));
>>> -		return PCI_ERS_RESULT_DISCONNECT;
>>> -	}
>>> -
>>> -	if (status != PCI_ERS_RESULT_RECOVERED) {
>>> -		pci_printk(KERN_DEBUG, dev, "link reset at upstream device %s 
>>> failed\n",
>>> -			pci_name(udev));
>>> -		return PCI_ERS_RESULT_DISCONNECT;
>>> -	}
>>> -
>>> -	return status;
>>> -}
>>> -
>>> -/**
>>> - * pcie_do_recovery - handle nonfatal/fatal error recovery process
>>> - * @dev: pointer to a pci_dev data structure of agent detecting an 
>>> error
>>> - * @severity: error severity type
>>> - *
>>> - * Invoked when an error is nonfatal/fatal. Once being invoked, 
>>> broadcast
>>> - * error detected message to all downstream drivers within a 
>>> hierarchy in
>>> - * question and return the returned code.
>>> - */
>>> -static void pcie_do_recovery(struct pci_dev *dev, int severity)
>>> -{
>>> -	pci_ers_result_t status, result = PCI_ERS_RESULT_RECOVERED;
>>> -	enum pci_channel_state state;
>>> -
>>> -	if (severity == AER_FATAL)
>>> -		state = pci_channel_io_frozen;
>>> -	else
>>> -		state = pci_channel_io_normal;
>>> -
>>> -	status = broadcast_error_message(dev,
>>> -			state,
>>> -			"error_detected",
>>> -			report_error_detected);
>>> -
>>> -	if (severity == AER_FATAL) {
>>> -		result = reset_link(dev);
>>> -		if (result != PCI_ERS_RESULT_RECOVERED)
>>> -			goto failed;
>>> -	}
>>> -
>>> -	if (status == PCI_ERS_RESULT_CAN_RECOVER)
>>> -		status = broadcast_error_message(dev,
>>> -				state,
>>> -				"mmio_enabled",
>>> -				report_mmio_enabled);
>>> -
>>> -	if (status == PCI_ERS_RESULT_NEED_RESET) {
>>> -		/*
>>> -		 * TODO: Should call platform-specific
>>> -		 * functions to reset slot before calling
>>> -		 * drivers' slot_reset callbacks?
>>> -		 */
>>> -		status = broadcast_error_message(dev,
>>> -				state,
>>> -				"slot_reset",
>>> -				report_slot_reset);
>>> -	}
>>> -
>>> -	if (status != PCI_ERS_RESULT_RECOVERED)
>>> -		goto failed;
>>> -
>>> -	broadcast_error_message(dev,
>>> -				state,
>>> -				"resume",
>>> -				report_resume);
>>> -
>>> -	pci_info(dev, "AER: Device recovery successful\n");
>>> -	return;
>>> -
>>> -failed:
>>> -	pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
>>> -	/* TODO: Should kernel panic here? */
>>> -	pci_info(dev, "AER: Device recovery failed\n");
>>> -}
>>> +EXPORT_SYMBOL_GPL(pci_find_aer_service);
>> 
>> This is never called from a module, so I don't think you need to
>> export it at all.  If you do, it should be a separate patch, not
>> buried in the middle of this big one.
>> 
> 
> got it, will see if its really required to be exported.
> but certainly, will remove it from this patch.
> 
>>>  /**
>>>   * handle_error_source - handle logging error into an event log
>>> diff --git a/drivers/pci/pcie/pcie-err.c 
>>> b/drivers/pci/pcie/pcie-err.c
>>> new file mode 100644
>>> index 0000000..fcd5add
>>> --- /dev/null
>>> +++ b/drivers/pci/pcie/pcie-err.c
>>> @@ -0,0 +1,334 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * This file implements the error recovery as a core part of PCIe 
>>> error reporting.
>>> + * When a PCIe error is delivered, an error message will be 
>>> collected and printed
>>> + * to console, then, an error recovery procedure will be executed by 
>>> following
>>> + * the PCI error recovery rules.
>> 
>> Wrap this so it fits in 80 columns.
> 
> I thought of keeping the way it was before (hence did not change it)
> I would change it now.
> 
>> 
>>> + * Copyright (C) 2006 Intel Corp.
>>> + *	Tom Long Nguyen (tom.l.nguyen@intel.com)
>>> + *	Zhang Yanmin (yanmin.zhang@intel.com)
>>> + *
>>> + */
>>> +
>>> +#include <linux/pci.h>
>>> +#include <linux/module.h>
>>> +#include <linux/pci.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/errno.h>
>>> +#include <linux/aer.h>
>>> +#include <linux/pcieport_if.h>
>>> +#include "portdrv.h"
>>> +
>>> +struct aer_broadcast_data {
>>> +	enum pci_channel_state state;
>>> +	enum pci_ers_result result;
>>> +};
>>> +
>>> +static pci_ers_result_t merge_result(enum pci_ers_result orig,
>>> +				  enum pci_ers_result new)
>>> +{
>>> +	if (new == PCI_ERS_RESULT_NO_AER_DRIVER)
>>> +		return PCI_ERS_RESULT_NO_AER_DRIVER;
>>> +
>>> +	if (new == PCI_ERS_RESULT_NONE)
>>> +		return orig;
>>> +
>>> +	switch (orig) {
>>> +	case PCI_ERS_RESULT_CAN_RECOVER:
>>> +	case PCI_ERS_RESULT_RECOVERED:
>>> +		orig = new;
>>> +		break;
>>> +	case PCI_ERS_RESULT_DISCONNECT:
>>> +		if (new == PCI_ERS_RESULT_NEED_RESET)
>>> +			orig = PCI_ERS_RESULT_NEED_RESET;
>>> +		break;
>>> +	default:
>>> +		break;
>>> +	}
>>> +
>>> +	return orig;
>>> +}
>>> +
>>> +static int report_mmio_enabled(struct pci_dev *dev, void *data)
>>> +{
>>> +	pci_ers_result_t vote;
>>> +	const struct pci_error_handlers *err_handler;
>>> +	struct aer_broadcast_data *result_data;
>>> +
>>> +	result_data = (struct aer_broadcast_data *) data;
>>> +
>>> +	device_lock(&dev->dev);
>>> +	if (!dev->driver ||
>>> +		!dev->driver->err_handler ||
>>> +		!dev->driver->err_handler->mmio_enabled)
>>> +		goto out;
>>> +
>>> +	err_handler = dev->driver->err_handler;
>>> +	vote = err_handler->mmio_enabled(dev);
>>> +	result_data->result = merge_result(result_data->result, vote);
>>> +out:
>>> +	device_unlock(&dev->dev);
>>> +	return 0;
>>> +}
>>> +
>>> +static int report_slot_reset(struct pci_dev *dev, void *data)
>>> +{
>>> +	pci_ers_result_t vote;
>>> +	const struct pci_error_handlers *err_handler;
>>> +	struct aer_broadcast_data *result_data;
>>> +
>>> +	result_data = (struct aer_broadcast_data *) data;
>>> +
>>> +	device_lock(&dev->dev);
>>> +	if (!dev->driver ||
>>> +		!dev->driver->err_handler ||
>>> +		!dev->driver->err_handler->slot_reset)
>>> +		goto out;
>>> +
>>> +	err_handler = dev->driver->err_handler;
>>> +	vote = err_handler->slot_reset(dev);
>>> +	result_data->result = merge_result(result_data->result, vote);
>>> +out:
>>> +	device_unlock(&dev->dev);
>>> +	return 0;
>>> +}
>>> +
>>> +static int report_resume(struct pci_dev *dev, void *data)
>>> +{
>>> +	const struct pci_error_handlers *err_handler;
>>> +
>>> +	device_lock(&dev->dev);
>>> +	dev->error_state = pci_channel_io_normal;
>>> +
>>> +	if (!dev->driver ||
>>> +		!dev->driver->err_handler ||
>>> +		!dev->driver->err_handler->resume)
>>> +		goto out;
>>> +
>>> +	err_handler = dev->driver->err_handler;
>>> +	err_handler->resume(dev);
>>> +out:
>>> +	device_unlock(&dev->dev);
>>> +	return 0;
>>> +}
>>> +
>>> +static int report_error_detected(struct pci_dev *dev, void *data)
>>> +{
>>> +	pci_ers_result_t vote;
>>> +	const struct pci_error_handlers *err_handler;
>>> +	struct aer_broadcast_data *result_data;
>>> +
>>> +	result_data = (struct aer_broadcast_data *) data;
>>> +
>>> +	device_lock(&dev->dev);
>>> +	dev->error_state = result_data->state;
>>> +
>>> +	if (!dev->driver ||
>>> +		!dev->driver->err_handler ||
>>> +		!dev->driver->err_handler->error_detected) {
>>> +		if (result_data->state == pci_channel_io_frozen &&
>>> +			dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
>>> +			/*
>>> +			 * In case of fatal recovery, if one of down-
>>> +			 * stream device has no driver. We might be
>>> +			 * unable to recover because a later insmod
>>> +			 * of a driver for this device is unaware of
>>> +			 * its hw state.
>>> +			 */
>>> +			dev_printk(KERN_DEBUG, &dev->dev, "device has %s\n",
>>> +				   dev->driver ?
>>> +				   "no error-aware driver" : "no driver");
>> 
>> This was a pci_printk() before you moved it and it should be the same 
>> here.
>> 
> 
> sure, will correct this.
> 
>>> +		}
>>> +
>>> +		/*
>>> +		 * If there's any device in the subtree that does not
>>> +		 * have an error_detected callback, returning
>>> +		 * PCI_ERS_RESULT_NO_AER_DRIVER prevents calling of
>>> +		 * the subsequent mmio_enabled/slot_reset/resume
>>> +		 * callbacks of "any" device in the subtree. All the
>>> +		 * devices in the subtree are left in the error state
>>> +		 * without recovery.
>>> +		 */
>>> +
>>> +		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
>>> +			vote = PCI_ERS_RESULT_NO_AER_DRIVER;
>>> +		else
>>> +			vote = PCI_ERS_RESULT_NONE;
>>> +	} else {
>>> +		err_handler = dev->driver->err_handler;
>>> +		vote = err_handler->error_detected(dev, result_data->state);
>>> +	}
>>> +
>>> +	result_data->result = merge_result(result_data->result, vote);
>>> +	device_unlock(&dev->dev);
>>> +	return 0;
>>> +}
>>> +
>>> +/**
>>> + * default_reset_link - default reset function
>>> + * @dev: pointer to pci_dev data structure
>>> + *
>>> + * Invoked when performing link reset on a Downstream Port or a
>>> + * Root Port with no aer driver.
>>> + */
>>> +static pci_ers_result_t default_reset_link(struct pci_dev *dev)
>>> +{
>>> +	pci_reset_bridge_secondary_bus(dev);
>>> +	dev_printk(KERN_DEBUG, &dev->dev, "downstream link has been 
>>> reset\n");
>> 
>> This should be a pci_printk() as it was before the move.  There are 
>> more
>> below.
>> 
> 
> yes all will be corrected.
> thanks.
> 
>>> +	return PCI_ERS_RESULT_RECOVERED;
>>> +}
>>> +
>>> +static pci_ers_result_t reset_link(struct pci_dev *dev)
>>> +{
>>> +	struct pci_dev *udev;
>>> +	pci_ers_result_t status;
>>> +	struct pcie_port_service_driver *driver = NULL;
>>> +
>>> +	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
>>> +		/* Reset this port for all subordinates */
>>> +		udev = dev;
>>> +	} else {
>>> +		/* Reset the upstream component (likely downstream port) */
>>> +		udev = dev->bus->self;
>>> +	}
>>> +
>>> +#if IS_ENABLED(CONFIG_PCIEAER)
>> 
>> AER can't be a module, so you can use just:
>> 
>>   #ifdef CONFIG_PCIEAER
>> 
>> This ifdef should be added in the patch where you add a caller from 
>> non-AER
>> code.  This patch should only move code, not change it.
> 
> ok, it can remain unchanged. but reset_link() is called by 
> pcie_do_recovery()
> and pcie_do_recovery can be called by various agents such as AER, DPC.
> so let us say if DPC calls pcie_do_recovery, then DPC has no way of
> knowing that AER is enabled or not.
> in fact it should not know, but err.c/reset_link() should take care 
> somehow.
> 
> I can make it a separate patch to do #ifdef CONFIG_PCIEAER inside 
> reset_link()
> or
> I can add severity parameter in reset_link() so based on severity it
> can find the service.
> 
> but I think you have comment to unify the find_aer_service and
> find_dpc_service into a pcie_find_service (routine)
> so I will see how I can club and take care of this comment. [without
> the need of #ifdef]
> 
>> 
>>> +	/* Use the aer driver of the component firstly */
>>> +	driver = pci_find_aer_service(udev);
>>> +#endif
>>> +
>>> +	if (driver && driver->reset_link) {
>>> +		status = driver->reset_link(udev);
>>> +	} else if (udev->has_secondary_link) {
>>> +		status = default_reset_link(udev);
>>> +	} else {
>>> +		dev_printk(KERN_DEBUG, &dev->dev,
>>> +			"no link-reset support at upstream device %s\n",
>>> +			pci_name(udev));
>>> +		return PCI_ERS_RESULT_DISCONNECT;
>>> +	}
>>> +
>>> +	if (status != PCI_ERS_RESULT_RECOVERED) {
>>> +		dev_printk(KERN_DEBUG, &dev->dev,
>>> +			"link reset at upstream device %s failed\n",
>>> +			pci_name(udev));
>>> +		return PCI_ERS_RESULT_DISCONNECT;
>>> +	}
>>> +
>>> +	return status;
>>> +}
>>> +
>>> +/**
>>> + * broadcast_error_message - handle message broadcast to downstream 
>>> drivers
>>> + * @dev: pointer to where in a hierarchy message is broadcasted down
>>> + * @state: error state
>>> + * @error_mesg: message to print
>>> + * @cb: callback to be broadcast
>>> + *
>>> + * Invoked during error recovery process. Once being invoked, the 
>>> content
>>> + * of error severity will be broadcast to all downstream drivers in 
>>> a
>>> + * hierarchy in question.
>>> + */
>>> +static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
>>> +	enum pci_channel_state state,
>>> +	char *error_mesg,
>>> +	int (*cb)(struct pci_dev *, void *))
>>> +{
>>> +	struct aer_broadcast_data result_data;
>>> +
>>> +	dev_printk(KERN_DEBUG, &dev->dev, "broadcast %s message\n", 
>>> error_mesg);
>>> +	result_data.state = state;
>>> +	if (cb == report_error_detected)
>>> +		result_data.result = PCI_ERS_RESULT_CAN_RECOVER;
>>> +	else
>>> +		result_data.result = PCI_ERS_RESULT_RECOVERED;
>>> +
>>> +	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
>>> +		/*
>>> +		 * If the error is reported by a bridge, we think this error
>>> +		 * is related to the downstream link of the bridge, so we
>>> +		 * do error recovery on all subordinates of the bridge instead
>>> +		 * of the bridge and clear the error status of the bridge.
>>> +		 */
>>> +		if (cb == report_error_detected)
>>> +			dev->error_state = state;
>>> +		pci_walk_bus(dev->subordinate, cb, &result_data);
>>> +		if (cb == report_resume) {
>>> +			pci_cleanup_aer_uncorrect_error_status(dev);
>>> +			dev->error_state = pci_channel_io_normal;
>>> +		}
>>> +	} else {
>>> +		/*
>>> +		 * If the error is reported by an end point, we think this
>>> +		 * error is related to the upstream link of the end point.
>>> +		 */
>>> +		pci_walk_bus(dev->bus, cb, &result_data);
>>> +	}
>>> +
>>> +	return result_data.result;
>>> +}
>>> +
>>> +/**
>>> + * pcie_do_recovery - handle nonfatal/fatal error recovery process
>>> + * @dev: pointer to a pci_dev data structure of agent detecting an 
>>> error
>>> + * @severity: error severity type
>>> + *
>>> + * Invoked when an error is nonfatal/fatal. Once being invoked, 
>>> broadcast
>>> + * error detected message to all downstream drivers within a 
>>> hierarchy in
>>> + * question and return the returned code.
>>> + */
>>> +void pcie_do_recovery(struct pci_dev *dev, int severity)
>>> +{
>>> +	pci_ers_result_t status, result = PCI_ERS_RESULT_RECOVERED;
>>> +	enum pci_channel_state state;
>>> +
>>> +	if (severity == AER_FATAL)
>>> +		state = pci_channel_io_frozen;
>>> +	else
>>> +		state = pci_channel_io_normal;
>>> +
>>> +	status = broadcast_error_message(dev,
>>> +			state,
>>> +			"error_detected",
>>> +			report_error_detected);
>>> +
>>> +	if (severity == AER_FATAL) {
>>> +		result = reset_link(dev);
>>> +		if (result != PCI_ERS_RESULT_RECOVERED)
>>> +			goto failed;
>>> +	}
>>> +
>>> +	if (status == PCI_ERS_RESULT_CAN_RECOVER)
>>> +		status = broadcast_error_message(dev,
>>> +				state,
>>> +				"mmio_enabled",
>>> +				report_mmio_enabled);
>>> +
>>> +	if (status == PCI_ERS_RESULT_NEED_RESET) {
>>> +		/*
>>> +		 * TODO: Should call platform-specific
>>> +		 * functions to reset slot before calling
>>> +		 * drivers' slot_reset callbacks?
>>> +		 */
>>> +		status = broadcast_error_message(dev,
>>> +				state,
>>> +				"slot_reset",
>>> +				report_slot_reset);
>>> +	}
>>> +
>>> +	if (status != PCI_ERS_RESULT_RECOVERED)
>>> +		goto failed;
>>> +
>>> +	broadcast_error_message(dev,
>>> +				state,
>>> +				"resume",
>>> +				report_resume);
>>> +
>>> +	dev_info(&dev->dev, "Device recovery successful\n");
>>> +	return;
>>> +
>>> +failed:
>>> +	/* TODO: Should kernel panic here? */
>>> +	dev_info(&dev->dev, "Device recovery failed\n");
>>> +}
>>> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
>>> index a854bc5..4f1992d 100644
>>> --- a/drivers/pci/pcie/portdrv.h
>>> +++ b/drivers/pci/pcie/portdrv.h
>>> @@ -79,4 +79,5 @@ static inline void pcie_port_platform_notify(struct 
>>> pci_dev *port, int *mask)
>>>  static inline void pcie_port_platform_notify(struct pci_dev *port, 
>>> int *mask){}
>>>  #endif /* !CONFIG_ACPI */
>>> 
>>> +struct pcie_port_service_driver *pci_find_aer_service(struct pci_dev 
>>> *dev);
>> 
>> Should be in a different patch, maybe the one where you rename it.

this can not be in a different patch I suppose, because this patch would 
not compile saying

error: implicit declaration of function ‘find_aer_service’ 
[-Werror=implicit-function-declaration]
driver = find_aer_service(udev);

err.c calls find_aer_service() so it needs to find declaration 
somewhere.
Though I will make a separate patch renaming this as you suggested.

>> 
>>>  #endif /* _PORTDRV_H_ */
>>> --
>>> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm 
>>> Technologies, Inc.,
>>> a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
>>> Linux Foundation Collaborative Project.
>>> 
