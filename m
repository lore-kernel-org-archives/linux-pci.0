Return-Path: <SRS0=PtP5=DO=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=PtP5=DO=huawei.com=liudongdong3@kernel.org>
Subject: Re: [PATCH V2 2/2] PCI/AER: Fix AER device configuration
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1512467438-42850-1-git-send-email-liudongdong3@huawei.com>
 <1512467438-42850-3-git-send-email-liudongdong3@huawei.com>
 <20171213165525.GE30595@bhelgaas-glaptop.roam.corp.google.com>
CC: <linux-pci@vger.kernel.org>, <stable@vger.kernel.org>,
        <linuxarm@huawei.com>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <601b1c58-82a5-fd7e-3653-14db734ad386@huawei.com>
Date: Mon, 18 Dec 2017 20:55:29 +0800
MIME-Version: 1.0
In-Reply-To: <20171213165525.GE30595@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>



在 2017/12/14 0:55, Bjorn Helgaas 写道:
> On Tue, Dec 05, 2017 at 05:50:38PM +0800, Dongdong Liu wrote:
>> AER driver only binds to root ports. It binds to one device and it also
>> configures other downstream devices.  That opens the door to concurrency
>> issues and makes it really hard to ensure that hotplug works correctly.
>> The aer_probe() path should only touch the device it is binding, it
>> should not use pci_walk_bus().  If we need to configure another device,
>> that should be done in the enumeration path for *that device*.
>> We can use  _HPX to set PCI_EXP_DEVCTL to enable error report and ensure
>> that hotplug works correctly.  For more_HPX details information,
>> we can see ACPI 6.1 section 6.2.9 _HPX (Hot Plug Parameter Extensions).
>
> _HPX is for platform-dependent things.  If Linux has generic AER
> support, i.e., if CONFIG_PCIEAER=y, we should not rely on _HPX to
> enable AER for hot-added devices.
>
> We need some mechanism in Linux for enabling AER on them.  I don't
> *like* the pci_walk_bus(), but we might need it for now because we
> have this ordering:
>
>   1) Enumerate hierarchy, disabling AER on all devices.  Currently I
>   think we only disable AER for Ports, but I propose doing it for all
>   devices.
>
>   2) Install AER driver on Root Ports.  Enable AER on Root Port.  We
>   also need to enable AER on the hierarchy below the Root Port, and
>   pci_walk_bus() seems like the logical way to do it for now.
>
>   3) Hot-add a device.  Currently I think AER will remain disabled on
>   the new device *unless* _HPX enables it.  I think this is wrong --
Yes, if the EP device driver does not call pci_enable_pcie_error_reporting(),
AER will remain diables  *unless* _HPX enables it.

>   Linux should not rely on the platform for this.  We could enable AER
>   via a device-add notifier, but that seems overly complicated.
>
>   I'd rather add a bit in pci_dev like "aer_hierarchy" that is set
>   whenever we turn on AER for the device.  Then pci_aer_init() could
>   enable AER if it is enabled in the upstream device.
It maybe just check the root port devices as AER driver binds to
Root Ports.
>
> Since the AER driver is installed after the whole hierarchy is
> enumerated, we can't use the "aer_hierarchy" bit (or whatever we call
> it) to enable AER on the devices present at boot.
>
> I would ultimately like to enable AER on the Root Ports in
> pci_aer_init() during enumeration instead of installing it as a driver
> after enumeration.  If we could ever do that, then the aer_hierarchy
> bit would work the same way for boot-time and hot-added devices, and
> we wouldn't need to do the pci_walk_bus() thing.

Please correct me if i am wrong.
For boot time. Disable AER in pci_aer_init().
Enable AER for all devices in aer_enable_rootport(), and set "aer_hierarchy"
bit just for Root Ports. It seems we have to use pci_walk_bus() to
enable all devices AER.
For Hot-add a device. Check it's root port "aer_hierarchy" bit in
pci_aer_init(). if the bit is set, enable the device AER in pci_aer_init().

Or as you said above. Enable AER on the Root Ports in pci_aer_init()
during enumeration and set the Root Ports "aer_hierarchy".
Then enable other deivces AER in pci_aer_init(） if it's root port
"aer_hierarchy" bit has been set. This seems that we would not
use pci_walk_bus() and disble/enable AER during enumeration,
the AER driver and EP deivces driver do not need to call
pci_enable_pcie_error_reporting()/pci_disable_pcie_error_reporting().

Thanks,
Dongdong

>
>> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
>> ---
>>  drivers/pci/pcie/aer/aerdrv.c | 49 ++++---------------------------------------
>>  1 file changed, 4 insertions(+), 45 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
>> index 6ff5f5b..cd63025 100644
>> --- a/drivers/pci/pcie/aer/aerdrv.c
>> +++ b/drivers/pci/pcie/aer/aerdrv.c
>> @@ -58,41 +58,6 @@ bool pci_aer_available(void)
>>  	return !pcie_aer_disable && pci_msi_enabled();
>>  }
>>
>> -static int set_device_error_reporting(struct pci_dev *dev, void *data)
>> -{
>> -	bool enable = *((bool *)data);
>> -	int type = pci_pcie_type(dev);
>> -
>> -	if ((type == PCI_EXP_TYPE_ROOT_PORT) ||
>> -	    (type == PCI_EXP_TYPE_UPSTREAM) ||
>> -	    (type == PCI_EXP_TYPE_DOWNSTREAM)) {
>> -		if (enable)
>> -			pci_enable_pcie_error_reporting(dev);
>> -		else
>> -			pci_disable_pcie_error_reporting(dev);
>> -	}
>> -
>> -	if (enable)
>> -		pcie_set_ecrc_checking(dev);
>> -
>> -	return 0;
>> -}
>> -
>> -/**
>> - * set_downstream_devices_error_reporting - enable/disable the error reporting  bits on the root port and its downstream ports.
>> - * @dev: pointer to root port's pci_dev data structure
>> - * @enable: true = enable error reporting, false = disable error reporting.
>> - */
>> -static void set_downstream_devices_error_reporting(struct pci_dev *dev,
>> -						   bool enable)
>> -{
>> -	set_device_error_reporting(dev, &enable);
>> -
>> -	if (!dev->subordinate)
>> -		return;
>> -	pci_walk_bus(dev->subordinate, set_device_error_reporting, &enable);
>> -}
>> -
>>  /**
>>   * aer_enable_rootport - enable Root Port's interrupts when receiving messages
>>   * @rpc: pointer to a Root Port data structure
>> @@ -123,11 +88,8 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
>>  	pci_read_config_dword(pdev, aer_pos + PCI_ERR_UNCOR_STATUS, &reg32);
>>  	pci_write_config_dword(pdev, aer_pos + PCI_ERR_UNCOR_STATUS, reg32);
>>
>> -	/*
>> -	 * Enable error reporting for the root port device and downstream port
>> -	 * devices.
>> -	 */
>> -	set_downstream_devices_error_reporting(pdev, true);
>> +	/* Enable error reporting for the root port device */
>> +	pci_enable_pcie_error_reporting(pdev);
>>
>>  	/* Enable Root Port's interrupt in response to error messages */
>>  	pci_read_config_dword(pdev, aer_pos + PCI_ERR_ROOT_COMMAND, &reg32);
>> @@ -147,11 +109,8 @@ static void aer_disable_rootport(struct aer_rpc *rpc)
>>  	u32 reg32;
>>  	int pos;
>>
>> -	/*
>> -	 * Disable error reporting for the root port device and downstream port
>> -	 * devices.
>> -	 */
>> -	set_downstream_devices_error_reporting(pdev, false);
>> +	/* Disable error reporting for the root port device */
>> +	pci_disable_pcie_error_reporting(pdev);
>>
>>  	pos = pdev->aer_cap;
>>  	/* Disable Root's interrupt in response to error messages */
>> --
>> 1.9.1
>>
>
> .
>
