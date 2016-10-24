Return-Path: <liudongdong3@huawei.com>
Return-Path: <liudongdong3@huawei.com>
Subject: Re: [PATCH V3 2/2] PCI/ACPI: hisi: Add ACPI support for HiSilicon
 SoCs Host Controllers
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1476933034-46044-1-git-send-email-liudongdong3@huawei.com>
 <1476933034-46044-3-git-send-email-liudongdong3@huawei.com>
 <CAJZ5v0iHGYCuQmJjkrk1Chu15VMoJSA0yKe14XkSrLV9jX_XNQ@mail.gmail.com>
 <5809B1DC.2070605@huawei.com> <20161021160838.GA29335@red-moon>
CC: "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas
	<helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Tomasz Nowicki
	<tn@semihalf.com>, <wangzhou1@hisilicon.com>,
        <pratyush.anand@gmail.com>, Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List
	<linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>,
        Jon Masters <jcm@redhat.com>, <gabriele.paoloni@huawei.com>,
        <charles.chenxin@huawei.com>, Hanjun Guo
	<hanjun.guo@linaro.org>,
        <linuxarm@huawei.com>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <580DB0A5.20406@huawei.com>
Date: Mon, 24 Oct 2016 14:56:37 +0800
MIME-Version: 1.0
In-Reply-To: <20161021160838.GA29335@red-moon>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>


Hi Lorenzo

Many thanks for your review.
在 2016/10/22 0:08, Lorenzo Pieralisi 写道:
> On Fri, Oct 21, 2016 at 02:12:44PM +0800, Dongdong Liu wrote:
>
> [...]
>
>>>> +static int hisi_pcie_init(struct pci_config_window *cfg)
>>>> +{
>>>> +       int ret;
>>>> +       struct acpi_device *adev = to_acpi_device(cfg->parent);
>>>
>>> Why is this expected to be struct acpi_device?
>>
>> I use this acpi device(Device (PCI2)) to get it's child acpi device(Device (RES2)), then
>> obtain rc base addresses from PNP0C02 as subdevice of PNP0A03.
>>
>> The procedure to get the value of cfg->parent is as the below.
>> arch/arm64/kernel/pci.c
>> pci_acpi_scan_root(struct acpi_pci_root *root)
>> 	--->pci_acpi_setup_ecam_mapping(root, ri);
>> 		--->pci_ecam_create(&root->device->dev, &cfgres, bus_res, ecam_ops);
>> 			--->cfg->parent = dev
>> ;
>> PCIe DSDT table defines as below.
>> Device (PCI2)
>> {
>> 	Name (_HID, "PNP0A08") // PCI Express Root Bridge
>> 	Name (_CID, "PNP0A03") // Compatible PCI Root Bridge
>> 	......
>> 	Device (RES2)
>> 	{
>> 		Name (_HID, "HISI0081") // HiSi PCIe RC config base address
>> 		Name (_CID, "PNP0C02") // Motherboard reserved resource
>> 		Name (_CRS, ResourceTemplate (){
>> 			Memory32Fixed (ReadWrite, 0xa00a0000 , 0x10000)
>> 	})
>> 	......
>> }
>>>
>>> Shouldn't it be a "physical" device whose companion is an ACPI device object?
>>
>> Sorry, I don't understand.  What do you mean ?
>
> I think Rafael meant the physical node (that in this case is the pci
> bridge device) that is associated with the acpi device (the struct
> pci_config_window.parent pointer points at the PNP0A03/PNP0A08 acpi
> device object though, not the RES2 acpi device that's what you need).
>
> Have a look at:
>
> Documentation/acpi/enumeration.txt
> Documentation/acpi/namespace.txt

Thanks for explaining this.

>
>> It should be a "physical" device. but I have not saw about
>> ACPI_COMPANION_SET() of this device.
>
> The PNP0A08 acpi_device (that is what is pointed at by
> struct acpi_device = to_acpi_device(pci_config_window.parent)
> is the respective pci bridge device companion.
>
> arch/arm64/kernel/pci.c (pcibios_root_bridge_prepare()).
>
> Now for something completely different :), your RES2 pseudo-device.
>
> IIUC platform device (physical node) is created by the ACPI enumeration
> code for your RES2 pseudo-device and its resources are already
> initialized (by parsing its _CRS) in acpi_create_platform_device().

This is not right. About RES2 pseudo-device,it's _CID is PNP0C02,
this will attach acpi_pnp_attach() (drivers/acpi/acpi_pnp.c) .
acpi_pnp_attach() return 1;ret = acpi_scan_attach_handler() will return 1.
So this will not call acpi_default_enumeration(),
this also will not call acpi_create_platform_device().

drivers/acpi/scan.c
static void acpi_bus_attach(struct acpi_device *device)
{
......
	ret = acpi_scan_attach_handler(device);
	if (ret < 0)
		return;

	device->flags.match_driver = true;
	if (!ret) {
		ret = device_attach(&device->dev);
		if (ret < 0)
			return;
	
		if (!ret && device->pnp.type.platform_id)
			acpi_default_enumeration(device);
	}
......
}

Dongdong
Thanks
>
> This means that by the time you match the PNP0A03/PNP0A08 child with an
> acpi_device with _HID == "HISI0081", you can get its associated
> physical node and get its resources IOMEM through the physical
> node (ie platform device and related resources) instead of re-parsing
> the _CRS if I am not mistaken (and that's an IF because I did not
> test it).

As above said this does not re-parse the _CRS for RES2 pseudo-device.

Dongdong
Thanks
>
> Regardless, I am not entirely sure there are kernel drivers/control
> paths already using this mechanism to handle child devices (keeping in
> mind that RES2 is not a real device at all, it is there to represent
> PNP0A03 sub-address space for PCI quirks), so it would be good to get
> Rafael's agreement on this approach to prevent abusing the current ACPI
> platform devices glue code assumptions.
>
> It would also be good to agree on the whole approach soundness.
>
> Thanks,
> Lorenzo
>
> .
>
