Return-Path: <SRS0=LMI9=EM=codeaurora.org=poza@kernel.org>
Return-Path: <SRS0=LMI9=EM=codeaurora.org=poza@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Wed, 17 Jan 2018 13:54:40 +0530
From: poza@codeaurora.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Keith
 Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>, Sinan Kaya
 <okaya@codeaurora.org>, Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v4 2/5] PCI/ERR: Rename error reporting to generic pci
 naming
In-Reply-To: <20180117011624.GG10860@bhelgaas-glaptop.roam.corp.google.com>
References: <1516096723-8013-1-git-send-email-poza@codeaurora.org>
 <1516096723-8013-3-git-send-email-poza@codeaurora.org>
 <20180117011624.GG10860@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <553ef73a25bbbd6e0211c9bc6867a4a7@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2018-01-17 06:46, Bjorn Helgaas wrote:
> On Tue, Jan 16, 2018 at 03:28:40PM +0530, Oza Pawandeep wrote:
>> This patch renames error reporting to generic function with pci prefix
>> 
>> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
>> 
>> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c 
>> b/drivers/pci/pcie/aer/aerdrv_core.c
>> index 4fda843..5ed9575 100644
>> --- a/drivers/pci/pcie/aer/aerdrv_core.c
>> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
>> @@ -285,7 +285,7 @@ static void handle_error_source(struct pcie_device 
>> *aerdev,
>>  			pci_write_config_dword(dev, pos + PCI_ERR_COR_STATUS,
>>  					info->status);
>>  	} else
>> -		do_recovery(dev, info->severity);
>> +		pci_do_recovery(dev, info->severity);
>>  }
>> 
>>  #ifdef CONFIG_ACPI_APEI_PCIEAER
>> @@ -349,7 +349,7 @@ static void aer_recover_work_func(struct 
>> work_struct *work)
>>  			continue;
>>  		}
>>  		cper_print_aer(pdev, entry.severity, entry.regs);
>> -		do_recovery(pdev, entry.severity);
>> +		pci_do_recovery(pdev, entry.severity);
>>  		pci_dev_put(pdev);
>>  	}
>>  }
>> diff --git a/drivers/pci/pcie/pcie-err.c b/drivers/pci/pcie/pcie-err.c
>> index 76e66bb..5792a9f 100644
>> --- a/drivers/pci/pcie/pcie-err.c
>> +++ b/drivers/pci/pcie/pcie-err.c
>> @@ -20,12 +20,12 @@
>>  #include <linux/pcieport_if.h>
>>  #include "portdrv.h"
>> 
>> -struct aer_broadcast_data {
>> +struct pci_err_broadcast_data {
>>  	enum pci_channel_state state;
>>  	enum pci_ers_result result;
>>  };
>> 
>> -pci_ers_result_t merge_result(enum pci_ers_result orig,
>> +pci_ers_result_t pci_merge_result(enum pci_ers_result orig,
> 
> Most of these functions started out static in aerdrv_core.c and should
> remain static.  Therefore, they do not need to be renamed.  Same for
> the struct aer_broadcast_data.
> 
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 46fd243..babcd89 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1998,7 +1998,7 @@ static inline resource_size_t 
>> pci_iov_resource_size(struct pci_dev *dev, int res
>>  void pci_hp_remove_module_link(struct pci_slot *pci_slot);
>>  #endif
>> 
>> -void do_recovery(struct pci_dev *dev, int severity);
>> +void pci_do_recovery(struct pci_dev *dev, int severity);
> 
> This one started out static and now needs to be non-static so you can
> call it both from aerdrv_core.c and pcie-dpc.c.
> 
> But it should not be exposed outside the PCI core, so the declaration
> should go in drivers/pci/pcie/aer/aerdrv.h or at most
> drivers/pci/pci.h.
> 
> The rename should happen before the move out of aerdrv_core.c, i.e.,
> reorder patches 1 and 2.

ok so let me confirm. you would like to see renaming but that should 
happen right in patch1.
and then move all the error reporting to pcie_err.c
is that correct ?


besides, I am thinking to move
pci_do_recovery and removing everything from include/linux/pci.h  (which 
you suggested already)
but along with that....following defines will move in driver/pci/pci.h

#define PCI_ERR_AER_NONFATAL           0
#define PCI_ERR_AER_FATAL              1
#define PCI_ERR_AER_CORRECTABLE        2
#define PCI_ERR_DPC_NONFATAL           4

because, error codes have to be unified at one place.

will work on this and post the patch-set soon.

Regards,
Oza.

> 
>>  /**
>>   * pci_pcie_cap - get the saved PCIe capability offset
>> --
>> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm 
>> Technologies, Inc.,
>> a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
>> Linux Foundation Collaborative Project.
>> 
