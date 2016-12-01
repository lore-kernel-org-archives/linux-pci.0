Return-Path: <SRS0=1MXK=XQ=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=1MXK=XQ=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH V1 1/2] PCI: thunder: Enable ACPI PCI controller for
 ThunderX pass2.x silicon version
To: Bjorn Helgaas <helgaas@kernel.org>, Tomasz Nowicki <tn@semihalf.com>
References: <1479201298-25494-1-git-send-email-tn@semihalf.com>
 <1479201298-25494-2-git-send-email-tn@semihalf.com>
 <20161201002812.GB9409@bhelgaas-glaptop.roam.corp.google.com>
Cc: will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org,
 Lorenzo.Pieralisi@arm.com, arnd@arndb.de, jchandra@broadcom.com,
 ard.biesheuvel@linaro.org, robert.richter@caviumnetworks.com,
 mw@semihalf.com, ddaney@caviumnetworks.com, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
 andrea.gallo@linaro.org, jeremy.linton@arm.com, liudongdong3@huawei.com,
 gabriele.paoloni@huawei.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, jcm@redhat.com, msalter@redhat.com,
 Christopher Covington <cov@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <19e244f2-22f9-be94-0929-a9d96844b801@codeaurora.org>
Date: Wed, 30 Nov 2016 20:00:12 -0500
MIME-Version: 1.0
In-Reply-To: <20161201002812.GB9409@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 11/30/2016 7:28 PM, Bjorn Helgaas wrote:
> Actually, that raises a question for qualcomm and hisi: in the DT
> model, we use non-ECAM config accessors in the driver, but in the ACPI
> model, we use ECAM accessors.  It seems like the accessors should be
> the same regardless of whether we discover the bridge via DT or ACPI.

For servers, we are only setting up the PCIe controller in ECAM mode in FW.
If somebody wants to use DT with QCOM Server (unsupported but possible),
they need to use pci-host-ecam-generic driver.

Here is an example:

	pcie3 {
		compatible = "pci-host-ecam-generic";
		device_type = "pci";
		#address-cells = <3>;
		#size-cells = <2>;
		bus-range = <0x0 0xff>;
		linux,pci-domain = <3>;

		// CPU_PHYSICAL(2)  SIZE(2)
		reg = <0xC00 0x00000000  0x0 0x10000000>;
 	...
	}

I think you are referring to this driver here.

obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o

This driver is only in use by the mobile products.

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
