Return-Path: <SRS0=ONfx=BX=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=ONfx=BX=huawei.com=liudongdong3@kernel.org>
Subject: Re: [RFC PATCH] PCI/portdrv: Fix switch devctrl error report enable.
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1507885320-122365-1-git-send-email-liudongdong3@huawei.com>
 <20171020193800.GO6332@bhelgaas-glaptop.roam.corp.google.com>
CC: <linux-pci@vger.kernel.org>, <charles.chenxin@huawei.com>,
        <linuxarm@huawei.com>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <7143aa2e-e8f0-cbb0-be56-953768a10443@huawei.com>
Date: Tue, 24 Oct 2017 16:29:34 +0800
MIME-Version: 1.0
In-Reply-To: <20171020193800.GO6332@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn

Many thanks for your review.

在 2017/10/21 3:38, Bjorn Helgaas 写道:
> On Fri, Oct 13, 2017 at 05:02:00PM +0800, Dongdong Liu wrote:
>> Current code has a bug, switch upstream/downstream port error report
>> is disabled.
>>
>> DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>> -[0000:00]-+-00.0-[01]--
>>            \-08.0-[02-07]----00.0-[03-07]--+-04.0-[04]--
>>                                            +-05.0-[05]--
>>                                            +-08.0-[06]--
>>                                            \-09.0-[07]--
>> portdrv_pci.c
>> pcie_portdrv_probe
>> 	--->pcie_port_device_register
>> 		--->get_port_device_capability
>> 			--->pci_disable_pcie_error_reporting
>>
>> aerdrv.c
>> aer_probe
>> 	--->aer_enable_rootport
>> 		--->set_downstream_devices_error_reporting
>>
>> But current code RP AER driver probe is before switch UP/DP portdrv probe.
>> This is a RFC PATCH for discussing.
>
> OK, I think I see the issue you're pointing out.  aer_probe() only
> binds to root ports (".port_type = PCI_EXP_TYPE_ROOT_PORT" in the
> aerdriver struct).
>
> We call aer_probe() for a root port, and it enables AER reporting for
> the root port and any downstream devices:
>
>   aer_probe(root port)                        # only binds to root ports
>     aer_enable_rootport
>       set_downstream_devices_error_reporting(root, true)
>         set_device_error_reporting(root, true)
>           pci_enable_pcie_error_reporting
>             pcie_capability_set_word(root, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS)
>         pci_walk_bus(root->subordinate set_device_error_reporting, true)
>           set_device_error_reporting(dev, true)
>             pci_enable_pcie_error_reporting
>               pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS)
>
> We later call pcie_portdrv_probe() for every downstream bridge (it
> matches PCI_CLASS_BRIDGE_PCI devices, then discards any non-PCIe
> devices), and it *disables* AER reporting:
>
>   pcie_portdrv_probe(switch port)
>     pcie_port_device_register
>       get_port_device_capability
>         pci_disable_pcie_error_reporting
>           pcie_capability_clear_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS)
>
> The result is that we first enable AER for the downstream switch
> ports, then we disable it again.

Yes, that is the reason why upstream/downstream port error report
is disabled.

>
> I agree, that looks like a problem.  I think aer_enable_rootport() is
> broken because it binds to one device and it also configures other
> downstream devices.  That opens the door to concurrency issues and
> makes it really hard to ensure that hotplug works correctly.
>
> I think the aer_probe() path should only touch the device it is
> binding, i.e., it should not use pci_walk_bus().  If we need to
> configure another device, that should be done in the enumeration path
> for *that device*.

It seems that ACPI _HPX can set PCI_EXP_DEVCTL to enable error report
and ensure that hotplug works correctly.
But we still need the RFC PATCH as the pcie_portdrv_probe() is after _HPX setting.
OK, I will also modify aer_probe() code to make sure that the aer_probe() path
should only touch the device it is binding in PATCH V2.

Thanks,
Dongdong

>
>> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
>> ---
>>  drivers/pci/pcie/portdrv_core.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
>> index 313a21d..6bb89ce 100644
>> --- a/drivers/pci/pcie/portdrv_core.c
>> +++ b/drivers/pci/pcie/portdrv_core.c
>> @@ -261,7 +261,9 @@ static int get_port_device_capability(struct pci_dev *dev)
>>  		 * Disable AER on this port in case it's been enabled by the
>>  		 * BIOS (the AER service driver will enable it when necessary).
>>  		 */
>> -		pci_disable_pcie_error_reporting(dev);
>> +		if((pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
>> +		   (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM))
>> +			pci_disable_pcie_error_reporting(dev);
>>  	}
>>  	/* VC support */
>>  	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_VC))
>> --
>> 1.9.1
>>
>
> .
>
