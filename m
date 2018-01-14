Return-Path: <SRS0=p2Eo=EJ=codeaurora.org=poza@kernel.org>
Return-Path: <SRS0=p2Eo=EJ=codeaurora.org=poza@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Sun, 14 Jan 2018 11:05:15 +0530
From: poza@codeaurora.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>, Keith Busch
 <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>, Sinan Kaya
 <okaya@codeaurora.org>, Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v3 1/3] PCI/AER: factor out error reporting from AER
In-Reply-To: <20180113005708.GE205469@bhelgaas-glaptop.roam.corp.google.com>
References: <1515398105-10329-1-git-send-email-poza@codeaurora.org>
 <1515398105-10329-2-git-send-email-poza@codeaurora.org>
 <20180113005708.GE205469@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <ca08c6fea1c38c43078ae5a13c851b37@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2018-01-13 06:27, Bjorn Helgaas wrote:
> On Mon, Jan 08, 2018 at 01:25:03PM +0530, Oza Pawandeep wrote:
>> This patch factors out error reporting callbacks, which are currently
>> tightly coupled with AER.
>> DPC should be able to call these callbacks when DPC trigger event 
>> occurs.
>> 
>> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
>> 
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 6402f7f..fd053e5 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -462,7 +462,7 @@ static void ghes_do_proc(struct ghes *ghes,
>>  				 * use, so treat it as a fatal AER error.
>>  				 */
>>  				if (gdata->flags & CPER_SEC_RESET)
>> -					aer_severity = AER_FATAL;
>> +					aer_severity = PCI_ERR_AER_FATAL;
> 
> Please split the s/AER_FATAL/PCI_ERR_AER_FATAL/ changes into a
> separate patch to reduce the size of this patch.
> 

will do.

> I would name them PCI_ERR_FATAL and PCI_ERR_NONFATAL because that
> matches the usage in the spec, e.g., PCIe r4.0, sec 6.2.2, and the
> symbols like PCI_ERR_UNC_UND in pci_regs.h.
> 

ok will work on that.

>> diff --git a/drivers/pci/pcie/pcie-err.c b/drivers/pci/pcie/pcie-err.c
>> new file mode 100644
>> index 0000000..a76a8bf
>> --- /dev/null
>> +++ b/drivers/pci/pcie/pcie-err.c
>> @@ -0,0 +1,335 @@
>> +/*
>> + * Copyright (c) 2017, The Linux Foundation. All rights reserved.
> 
> Somebody already mentioned using the SPDX thing, which I think you
> should do.
> 
> But I'm confused about this copyright line.  As far as I can tell,
> this basically moves code from aerdrv_core.c to pcie-err.c, which is
> not enough to change the copyright ownership.  But it drops the
> copyright lines from aerdrv.core.c and replaces them with "(c) 2017,
> The Linux Foundation".  ??  Where did that come from?
> 
> If you *add* something non-trivial, I think it's OK to add your own
> new copyright info (though I don't think this is really necessary),
> but I don't think we should *remove* information about other copyright
> owners.
> 

sure will keep original copyright owners info, and SPDX as well.

>> + * This program is free software; you can redistribute it and/or 
>> modify
>> + * it under the terms of the GNU General Public License version 2 and
>> + * only version 2 as published by the Free Software Foundation.
>> +
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
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
>> +
>> +static DEFINE_MUTEX(pci_err_recovery_lock);
>> +
>> +pci_ers_result_t pci_merge_result(enum pci_ers_result orig,
>> +				  enum pci_ers_result new)
> 
> Please do all the renames, e.g., s/merge_result/pci_merge_result/, in
> a separate patch, followed by one that only moves code between files.
> 
> These initial ones will seem trivial, and they are, which is perfect.
> That makes them easy to review, and it will make the "interesting"
> patches much smaller and also easier to review.
> 

ok all the renamed will be made in a separate patch.

> The you can follow up with more patches that do things like add the
> mutex.  It's too hard to review (or even notice) things like that when
> everything is squashed together.
> 

sure.

>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>> index 8f87bbe..3eac8ed 100644
>> --- a/include/linux/aer.h
>> +++ b/include/linux/aer.h
>> @@ -11,10 +11,6 @@
>>  #include <linux/errno.h>
>>  #include <linux/types.h>
>> 
>> -#define AER_NONFATAL			0
>> -#define AER_FATAL			1
>> -#define AER_CORRECTABLE			2
>> -
>>  struct pci_dev;
>> 
>>  struct aer_header_log_regs {
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index c170c92..083408e 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -739,6 +739,10 @@ struct pci_error_handlers {
>>  	void (*resume)(struct pci_dev *dev);
>>  };
>> 
>> +struct pci_err_broadcast_data {
>> +	enum pci_channel_state state;
>> +	enum pci_ers_result result;
>> +};
> 
> Only used in pcie-err.c; should be declared there.
> 
>>  struct module;
>>  struct pci_driver {
>> @@ -1998,6 +2002,23 @@ static inline resource_size_t 
>> pci_iov_resource_size(struct pci_dev *dev, int res
>>  void pci_hp_remove_module_link(struct pci_slot *pci_slot);
>>  #endif
>> 
>> +#define PCI_ERR_AER_NONFATAL		0
>> +#define PCI_ERR_AER_FATAL		1
>> +#define PCI_ERR_AER_CORRECTABLE		2
> 
> Why do these need to be moved to include/linux/pci.h?  I don't really
> want them in include/linux at all.  The only uses outside drivers/pci
> are in ras_event.h and acpi/apei/ghes.c.  I'd rather keep them in
> aer.h with the hope of being able to move them into drivers/pci/pci.h
> eventually.

but if I do PCI_ERR_FATAL in aer.h
how dpc can use that ?
let me see what best I can do because PCI_ERR_AER_FATAL if renamed to 
PCI_ERR_FATAL
then both aer and dpc will use that.

> 
>> +pci_ers_result_t pci_broadcast_error_message(struct pci_dev *dev,
>> +					enum pci_channel_state state,
>> +					char *error_mesg,
>> +					int (*cb)(struct pci_dev *, void *));
>> +int pci_report_mmio_enabled(struct pci_dev *dev, void *data);
>> +int pci_report_slot_reset(struct pci_dev *dev, void *data);
>> +int pci_report_resume(struct pci_dev *dev, void *data);
>> +int pci_report_error_detected(struct pci_dev *dev, void *data);
>> +pci_ers_result_t pci_reset_link(struct pci_dev *dev);
>> +pci_ers_result_t pci_merge_result(enum pci_ers_result orig,
>> +				enum pci_ers_result new);
> 
> The above are only used in pcie-err.c and should be static and not
> declared here.
> 
>> +void pci_do_recovery(struct pci_dev *dev, int severity);
>> +
>>  /**
>>   * pci_pcie_cap - get the saved PCIe capability offset
>>   * @dev: PCI device
>> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
>> index 9c68986..6176e90 100644
>> --- a/include/ras/ras_event.h
>> +++ b/include/ras/ras_event.h
>> @@ -316,10 +316,10 @@
>> 
>>  	TP_printk("%s PCIe Bus Error: severity=%s, %s\n",
>>  		__get_str(dev_name),
>> -		__entry->severity == AER_CORRECTABLE ? "Corrected" :
>> -			__entry->severity == AER_FATAL ?
>> +		__entry->severity == PCI_ERR_AER_CORRECTABLE ? "Corrected" :
>> +			__entry->severity == PCI_ERR_AER_FATAL ?
>>  			"Fatal" : "Uncorrected, non-fatal",
>> -		__entry->severity == AER_CORRECTABLE ?
>> +		__entry->severity == PCI_ERR_AER_CORRECTABLE ?
>>  		__print_flags(__entry->status, "|", aer_correctable_errors) :
>>  		__print_flags(__entry->status, "|", aer_uncorrectable_errors))
>>  );
>> --
>> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm 
>> Technologies, Inc.,
>> a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
>> Linux Foundation Collaborative Project.
>> 
