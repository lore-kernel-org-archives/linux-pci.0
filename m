Return-Path: <jeremy.linton@arm.com>
Return-Path: <jeremy.linton@arm.com>
Subject: Re: [PATCH V7 00/11] Support for generic ACPI based PCI host
 controller
To: Tomasz Nowicki <tn@semihalf.com>, helgaas@kernel.org, arnd@arndb.de,
 will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org,
 hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
 jchandra@broadcom.com
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com,
 ddaney@caviumnetworks.com, wangyijing@huawei.com,
 Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linaro-acpi@lists.linaro.org, jcm@redhat.com, andrea.gallo@linaro.org,
 dhdang@apm.com, liudongdong3@huawei.com, cov@codeaurora.org
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <573E0388.7030203@arm.com>
Date: Thu, 19 May 2016 13:18:48 -0500
MIME-Version: 1.0
In-Reply-To: <1462893601-8937-1-git-send-email-tn@semihalf.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 05/10/2016 10:19 AM, Tomasz Nowicki wrote:
>  From the functionality point of view this series may be split into the
> following logic parts:
> 1. New ECAM API and update for users of the pci-host-common API
> 2. Necessary fixes as the preparation for using driver on ARM64.
> 3. Use new MCFG interface and implement generic ACPI based PCI host controller driver.
> 4. Enable above driver on ARM64

Thomasz,

Unless i'm doing something wrong, this patch causes a build break if 
NUMA is enabled in a 4.6+ kernel.

Thanks,



drivers/built-in.o: In function `pci_device_add':
/home/jlinton/linux-main/drivers/pci/probe.c:1744: undefined reference 
to `pcibus_to_node'
drivers/built-in.o: In function `pci_create_root_bus':
/home/jlinton/linux-main/drivers/pci/probe.c:2163: undefined reference 
to `pcibus_to_node'
drivers/built-in.o: In function `cpulistaffinity_show':
/home/jlinton/linux-main/drivers/pci/pci-sysfs.c:123: undefined 
reference to `pcibus_to_node'
/home/jlinton/linux-main/drivers/pci/pci-sysfs.c:123: undefined 
reference to `pcibus_to_node'
drivers/built-in.o: In function `cpuaffinity_show':
/home/jlinton/linux-main/drivers/pci/pci-sysfs.c:114: undefined 
reference to `pcibus_to_node'
drivers/built-in.o:/home/jlinton/linux-main/drivers/pci/pci-sysfs.c:114: 
more undefined references to `pcibus_to_node' follow
Makefile:937: recipe for target 'vmlinux' failed
