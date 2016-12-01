Return-Path: <SRS0=1MXK=XQ=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=1MXK=XQ=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH V1 1/2] PCI: thunder: Enable ACPI PCI controller for
 ThunderX pass2.x silicon version
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1479201298-25494-1-git-send-email-tn@semihalf.com>
 <1479201298-25494-2-git-send-email-tn@semihalf.com>
 <20161201002812.GB9409@bhelgaas-glaptop.roam.corp.google.com>
 <19e244f2-22f9-be94-0929-a9d96844b801@codeaurora.org>
 <20161201034817.GA19681@bhelgaas-glaptop.roam.corp.google.com>
Cc: Tomasz Nowicki <tn@semihalf.com>, will.deacon@arm.com,
 catalin.marinas@arm.com, rafael@kernel.org, Lorenzo.Pieralisi@arm.com,
 arnd@arndb.de, jchandra@broadcom.com, ard.biesheuvel@linaro.org,
 robert.richter@caviumnetworks.com, mw@semihalf.com,
 ddaney@caviumnetworks.com, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
 andrea.gallo@linaro.org, jeremy.linton@arm.com, liudongdong3@huawei.com,
 gabriele.paoloni@huawei.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, jcm@redhat.com, msalter@redhat.com,
 Christopher Covington <cov@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <84119c18-b130-0b32-029b-bd9169a25960@codeaurora.org>
Date: Wed, 30 Nov 2016 23:26:29 -0500
MIME-Version: 1.0
In-Reply-To: <20161201034817.GA19681@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 11/30/2016 10:48 PM, Bjorn Helgaas wrote:
> On Wed, Nov 30, 2016 at 08:00:12PM -0500, Sinan Kaya wrote:
>> Hi Bjorn,
>>
>> On 11/30/2016 7:28 PM, Bjorn Helgaas wrote:
>>> Actually, that raises a question for qualcomm and hisi: in the DT
>>> model, we use non-ECAM config accessors in the driver, but in the ACPI
>>> model, we use ECAM accessors.  It seems like the accessors should be
>>> the same regardless of whether we discover the bridge via DT or ACPI.
>>
>> For servers, we are only setting up the PCIe controller in ECAM mode in FW.
>> If somebody wants to use DT with QCOM Server (unsupported but possible),
>> they need to use pci-host-ecam-generic driver.
>>
>> Here is an example:
>>
>> 	pcie3 {
>> 		compatible = "pci-host-ecam-generic";
>> 		device_type = "pci";
>> 		#address-cells = <3>;
>> 		#size-cells = <2>;
>> 		bus-range = <0x0 0xff>;
>> 		linux,pci-domain = <3>;
>>
>> 		// CPU_PHYSICAL(2)  SIZE(2)
>> 		reg = <0xC00 0x00000000  0x0 0x10000000>;
>>  	...
>> 	}
>>
>> I think you are referring to this driver here.
>>
>> obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
>>
>> This driver is only in use by the mobile products.
> 
> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/ecam&id=2bb62a60711e
> says it's for the Qualcomm QDF2432.  Is pcie-qcom for that same
> device, or is it for something different?

They are different controllers.

Qualcomm QDF2432 only supports ECAM mode only and is designed for
ACPI based server products by the Data Center division. 

If somebody really needs device tree for QDF2432 server chip even though
we don't officially support it, generic host driver with ECAM mode
is the way to go.

Even there, we need a small patch to pci_generic_ecam_ops as follows due
to quirky HW.  Generic host driver won't work out of the box.

struct pci_ecam_ops pci_generic_ecam_ops = {
        .bus_shift      = 20,
        .pci_ops        = {
                .map_bus        = pci_ecam_map_bus,
-                .read           = pci_generic_config_read,
+                 .read           = pci_generic_config_read32,
-                .write          = pci_generic_config_write,
+                .write          = pci_generic_config_write32,
        }
};

This is essentially what pci_32b_ops is. Since device-tree is not officially
supported, we didn't bother making changes to the generic host bridge driver.

https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/ecam&id=2bb62a60711e

is the only thing needed for QDF2432.

> 
> I assume it's probably different because pci-host-ecam-generic uses
> the standard ECAM accessors (pci_generic_ecam_ops), while the quirk
> requires non-standard ones (pci_32b_ops).
> 
> If these are two different controllers, that's fine.  If it's the same
> controller in both cases, the controller should be configured the same
> way (either by FW or by the DT driver) and we should use the same
> accessors.
> 
> If you have to use different accessors for the same controller, you
> would need some explanation for the difference because it's a
> maintenance headache to operate a device in different modes depending
> on the environment or which driver you're using.
> 
> Bjorn
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
