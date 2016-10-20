Return-Path: <ray.jui@broadcom.com>
Return-Path: <ray.jui@broadcom.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: alex.barba@broadcom.com,
 BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
From: Ray Jui <ray.jui@broadcom.com>
Subject: About configuring the PCIe device MPS
Message-ID: <3d7bc589-76ca-f557-c18b-2c5a47969d68@broadcom.com>
Date: Thu, 20 Oct 2016 15:54:04 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Alex Barba (CCed in the email thread) from Broadcom discovered that PCIe 
endpoint devices attached to our ARM64 based iProc platforms are not 
configured to their optimal MPS size. Through some digging in the PCIe 
stack of the kernel, I found that:

1. For ARM32 based PCIe core code, 'pcie_bus_configure_settings' is 
called from 'pci_common_init_dev' before the devices are added to be bus

2. For ARM64 based PCIe core code, 'pcie_bus_configure_settings' is 
called similarly in 'pci_acpi_scan_root' for ACPI based ARM64 platform

3. But for ARM64 platforms that have not yet supported ACPI, there does 
not appear to be a common place for this configuration. Obviously, we 
have the option of calling it in our iProc PCIe host driver (right 
before devices are added to the bus). I'd like to check with you if 
that's the expected way of handling it. We do see a couple PCIe host 
drivers already handle it this way.

Thanks,

Ray
