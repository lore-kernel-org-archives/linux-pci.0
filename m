Return-Path: <SRS0=PSar=FV=codeaurora.org=poza@kernel.org>
Return-Path: <SRS0=PSar=FV=codeaurora.org=poza@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 27 Feb 2018 14:09:43 +0530
From: poza@codeaurora.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Keith
 Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>, Sinan Kaya
 <okaya@codeaurora.org>, Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v11 6/7] PCI: Unify wait for link active into generic pci
In-Reply-To: <20180224154115.GT14632@bhelgaas-glaptop.roam.corp.google.com>
References: <1519374244-20539-1-git-send-email-poza@codeaurora.org>
 <1519374244-20539-7-git-send-email-poza@codeaurora.org>
 <20180224154115.GT14632@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <44250c485313bd1240d8617511f5888c@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2018-02-24 21:11, Bjorn Helgaas wrote:
> In subject:
> 
> s/pci/PCI/
sure.
> 
> On Fri, Feb 23, 2018 at 01:54:03PM +0530, Oza Pawandeep wrote:
>> Clients such as pciehp, dpc are using pcie_wait_link_active, which 
>> waits
>> till the link becomes active or inactive.
> 
> Use "()" after function names so we have a visual clue that they are
> functions.
> 
>> Made generic function and moved it to drivers/pci/pci.c
>> 
>> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
>> 
>> diff --git a/drivers/pci/hotplug/pciehp_hpc.c 
>> b/drivers/pci/hotplug/pciehp_hpc.c
>> index 18a42f8..de9b0ea 100644
>> --- a/drivers/pci/hotplug/pciehp_hpc.c
>> +++ b/drivers/pci/hotplug/pciehp_hpc.c
>> @@ -231,25 +231,11 @@ bool pciehp_check_link_active(struct controller 
>> *ctrl)
>>  	return ret;
>>  }
>> 
>> -static void __pcie_wait_link_active(struct controller *ctrl, bool 
>> active)
>> +static bool pcie_wait_link_active(struct controller *ctrl)
>>  {
>> -	int timeout = 1000;
>> -
>> -	if (pciehp_check_link_active(ctrl) == active)
>> -		return;
>> -	while (timeout > 0) {
>> -		msleep(10);
>> -		timeout -= 10;
>> -		if (pciehp_check_link_active(ctrl) == active)
>> -			return;
>> -	}
>> -	ctrl_dbg(ctrl, "Data Link Layer Link Active not %s in 1000 msec\n",
>> -			active ? "set" : "cleared");
>> -}
>> +	struct pci_dev *pdev = ctrl_dev(ctrl);
>> 
>> -static void pcie_wait_link_active(struct controller *ctrl)
>> -{
>> -	__pcie_wait_link_active(ctrl, true);
>> +	return pci_wait_for_link(pdev, true);
>>  }
>> 
>>  static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index f6a4dd1..f8d44b4 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -4176,6 +4176,37 @@ static int pci_pm_reset(struct pci_dev *dev, 
>> int probe)
>>  	return 0;
>>  }
>> 
>> +/**
>> + * pci_wait_for_link - Wait for link till its active/inactive
> 
> s/its/it's/
sure.
> 
>> + * @pdev: Bridge device
>> + * @active: waiting for active or inactive ?
>> + *
>> + * Use this to wait till link becomes active or inactive.
>> + */
>> +bool pci_wait_for_link(struct pci_dev *pdev, bool active)
> 
> I think this should be "pcie_wait_for_link()".  There's no concept of a
> link in conventional PCI.
> 
>> +{
>> +	int timeout = 1000;
>> +	bool ret;
>> +	u16 lnk_status;
>> +
>> +	for (;;) {
>> +		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
>> +		ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
>> +		if (ret == active)
>> +			return true;
>> +		if (timeout <= 0)
>> +			break;
>> +		timeout -= 10;
>> +	}
>> +
>> +	dev_printk(KERN_DEBUG, &pdev->dev,
> 
> pci_info().  Distros often seem to have logging configured so
> KERN_DEBUG things aren't captured, and this definitely seems worth
> capturing.
> 
>> +		   "Data Link Layer Link Active not %s in 1000 msec\n",
>> +		   active ? "set" : "cleared");
>> +
>> +	return false;
>> +}
>> +EXPORT_SYMBOL(pci_wait_for_link);
> 
> I don't think this needs to be exported.
> 
sure.
>>  void pci_reset_secondary_bus(struct pci_dev *dev)
>>  {
>>  	u16 ctrl;
>> diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
>> index 5c01c63..e15bcda 100644
>> --- a/drivers/pci/pcie/pcie-dpc.c
>> +++ b/drivers/pci/pcie/pcie-dpc.c
>> @@ -120,19 +120,9 @@ static int dpc_wait_rp_inactive(struct dpc_dev 
>> *dpc)
>> 
>>  static void dpc_wait_link_inactive(struct dpc_dev *dpc)
>>  {
>> -	unsigned long timeout = jiffies + HZ;
>>  	struct pci_dev *pdev = dpc->dev->port;
>> -	struct device *dev = &dpc->dev->device;
>> -	u16 lnk_status;
>> 
>> -	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
>> -	while (lnk_status & PCI_EXP_LNKSTA_DLLLA &&
>> -					!time_after(jiffies, timeout)) {
>> -		msleep(10);
>> -		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
>> -	}
>> -	if (lnk_status & PCI_EXP_LNKSTA_DLLLA)
>> -		dev_warn(dev, "Link state not disabled for DPC event\n");
>> +	pci_wait_for_link(pdev, false);
>>  }
>> 
>>  /**
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 024a1be..cb674c3 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1195,6 +1195,7 @@ int pci_add_ext_cap_save_buffer(struct pci_dev 
>> *dev,
>>  int pci_request_selected_regions(struct pci_dev *, int, const char 
>> *);
>>  int pci_request_selected_regions_exclusive(struct pci_dev *, int, 
>> const char *);
>>  void pci_release_selected_regions(struct pci_dev *, int);
>> +bool pci_wait_for_link(struct pci_dev *pdev, bool active);
> 
> I don't think this needs to be available outside the PCI core, so this
> could probably be declared in drivers/pci/pci.h
> 

thanks, will move it.

>>  /* drivers/pci/bus.c */
>>  struct pci_bus *pci_bus_get(struct pci_bus *bus);
>> --
>> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm 
>> Technologies, Inc.,
>> a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
>> Linux Foundation Collaborative Project.
>> 
