Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:46666 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750943AbeBWGb2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Feb 2018 01:31:28 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 23 Feb 2018 12:01:26 +0530
From: poza@codeaurora.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v9 2/7] PCI/AER: factor out error reporting from AER
In-Reply-To: <e2d8d85a-d044-cece-4da4-4c8e3e4d9ce1@infradead.org>
References: <1519285571-5634-1-git-send-email-poza@codeaurora.org>
 <1519285571-5634-3-git-send-email-poza@codeaurora.org>
 <e2d8d85a-d044-cece-4da4-4c8e3e4d9ce1@infradead.org>
Message-ID: <412cdd104d1e1cd1ca7e0d873c4b5a7b@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-02-23 00:53, Randy Dunlap wrote:
> On 02/21/2018 11:46 PM, Oza Pawandeep wrote:
> 
> Hi,
> Just minor stuff:
> 
>> diff --git a/drivers/pci/pcie/pcie-err.c b/drivers/pci/pcie/pcie-err.c
>> new file mode 100644
>> index 0000000..a532fe0
>> --- /dev/null
>> +++ b/drivers/pci/pcie/pcie-err.c
>> @@ -0,0 +1,334 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * This file implements the error recovery as a core part of PCIe 
>> error reporting.
>> + * When a PCIe error is delivered, an error message will be collected 
>> and printed
>> + * to console, then, an error recovery procedure will be executed by 
>> following
>> + * the PCI error recovery rules.
>> + *
>> + * Copyright (C) 2006 Intel Corp.
>> + *	Tom Long Nguyen (tom.l.nguyen@intel.com)
>> + *	Zhang Yanmin (yanmin.zhang@intel.com)
>> + *
>> + */
>> +
>> +#include <linux/pci.h>
>> +#include <linux/module.h>
>> +#include <linux/pci.h>
>> +#include <linux/kernel.h>
>> +#include <linux/errno.h>
>> +#include <linux/aer.h>
>> +#include <linux/pcieport_if.h>
>> +#include "portdrv.h"
> 
>> +static int report_error_detected(struct pci_dev *dev, void *data)
>> +{
>> +	pci_ers_result_t vote;
>> +	const struct pci_error_handlers *err_handler;
>> +	struct aer_broadcast_data *result_data;
>> +
>> +	result_data = (struct aer_broadcast_data *) data;
>> +
>> +	device_lock(&dev->dev);
>> +	dev->error_state = result_data->state;
>> +
>> +	if (!dev->driver ||
>> +		!dev->driver->err_handler ||
>> +		!dev->driver->err_handler->error_detected) {
>> +		if (result_data->state == pci_channel_io_frozen &&
>> +			dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
>> +			/*
>> +			 * In case of fatal recovery, if one of down-
>> +			 * stream device has no driver. We might be
>> +			 * unable to recover because a later insmod
>> +			 * of a driver for this device is unaware of
>> +			 * its hw state.
>> +			 */
>> +			dev_printk(KERN_DEBUG, &dev->dev, "device has %s\n",
>> +				   dev->driver ?
>> +				   "no error-aware driver" : "no driver");
> 
> or:
> 			dev_printk(KERN_DEBUG, &dev->dev, "device has no%s driver\n",
> 				   dev->driver ? " error-aware" : "");
> 
>> +		}
>> +
>> +		/*
>> +		 * If there's any device in the subtree that does not
>> +		 * have an error_detected callback, returning
>> +		 * PCI_ERS_RESULT_NO_AER_DRIVER prevents calling of
>> +		 * the subsequent mmio_enabled/slot_reset/resume
>> +		 * callbacks of "any" device in the subtree. All the
>> +		 * devices in the subtree are left in the error state
>> +		 * without recovery.
>> +		 */
>> +
>> +		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
>> +			vote = PCI_ERS_RESULT_NO_AER_DRIVER;
>> +		else
>> +			vote = PCI_ERS_RESULT_NONE;
>> +	} else {
>> +		err_handler = dev->driver->err_handler;
>> +		vote = err_handler->error_detected(dev, result_data->state);
>> +	}
>> +
>> +	result_data->result = merge_result(result_data->result, vote);
>> +	device_unlock(&dev->dev);
>> +	return 0;
>> +}
> 
>> +/**
>> + * broadcast_error_message - handle message broadcast to downstream 
>> drivers
>> + * @dev: pointer to from where in a hierarchy message is broadcasted 
>> down
> 
>             I would drop ^^ "from" ...                   is broadcast 
> downstream
> 
>> + * @state: error state
>> + * @error_mesg: message to print
>> + * @cb: callback to be broadcasted
> 
>                     to be broadcast
> 
>> + *
>> + * Invoked during error recovery process. Once being invoked, the 
>> content
>> + * of error severity will be broadcasted to all downstream drivers in 
>> a
> 
>                         will be broadcast
> 
>> + * hierarchy in question.
>> + */
>> +static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
>> +	enum pci_channel_state state,
>> +	char *error_mesg,
>> +	int (*cb)(struct pci_dev *, void *))
>> +{
>> +	struct aer_broadcast_data result_data;


Thanks for the comments, will take care of it.
