Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <56E34518.5020800@caviumnetworks.com>
Date: Fri, 11 Mar 2016 14:22:16 -0800
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>
CC: David Daney <ddaney.cavm@gmail.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>,
	Dann Frazier <dann.frazier@canonical.com>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v7 0/3] Add host controller drivers for Cavium ThunderX
 PCI
References: <1457130708-3231-1-git-send-email-ddaney.cavm@gmail.com> <20160311221848.GG4725@localhost>
In-Reply-To: <20160311221848.GG4725@localhost>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/11/2016 02:18 PM, Bjorn Helgaas wrote:
> On Fri, Mar 04, 2016 at 02:31:45PM -0800, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> Some Cavium ThunderX processors require quirky access methods for the
>> config space of the PCIe bridge.
>>
>> There are now three patches:
>>
>> 1) Refactor code in pci-host-generic so that it can more easily be
>>     used by other drivers.  This splits the driver for CAM and ECAM
>>     access methods to a separate file from the common host driver code.
>>
>> 2) Add the ThunderX PCIe driver to external PCIe buses, which
>>     leverages the code in pci-host-generic
>>
>> 3) Add ThunderX PCI driver for internel SoC buses used on early
>>     ThunderX chip revisions.
>>
>> Changes from v6: Updated 3/3 to support Thunder pass-2.x silicon.
>>
>> Changes from v5: Added Acked-by Rob Herring for the device tree
>> binding in 3/3.  Fixed typo and split large functions as suggested by
>> Bjorn Helgaas.
>>
>> Changes from v4: Added patch 3/3.  Stylistic changes to 2/3 suggested
>> by Bjorn Helgaas.  When expanding config write width to 32-bits, mask
>> out unintened writes to W1C bits, also suggested by Bjorn Helgaas.
>>
>> Changes from v3: Add some Acked-by, rebased to v4.5.0-rc1
>>
>> Changes from v2: Improve device tree binding example as noted by Rob
>> Herring.  Rename pcie-thunder-pem.* to pci-thunder-pem.* for better
>> consistency.  Update MAINTAINERS to reflect the changes.
>>
>> Changes from v1: Split CAM and ECAM code from common driver code as
>> suggested by Arnd Bergmann.  Fix spelling errors in
>> pcie-thunder-pem.txt
>>
>>
>> David Daney (3):
>>    PCI: generic: Refactor code to enable reuse by other drivers.
>>    pci, pci-thunder-pem: Add PCIe host driver for ThunderX processors.
>>    pci, pci-thunder-ecam: Add driver for ThunderX-pass{1,2} on-chip
>>      devices
>>
>>   .../devicetree/bindings/pci/pci-thunder-ecam.txt   |  30 ++
>>   .../devicetree/bindings/pci/pci-thunder-pem.txt    |  43 +++
>>   MAINTAINERS                                        |   9 +
>>   drivers/pci/host/Kconfig                           |  18 +
>>   drivers/pci/host/Makefile                          |   3 +
>>   drivers/pci/host/pci-host-common.c                 | 194 ++++++++++
>>   drivers/pci/host/pci-host-common.h                 |  47 +++
>>   drivers/pci/host/pci-host-generic.c                | 181 +--------
>>   drivers/pci/host/pci-thunder-ecam.c                | 407 +++++++++++++++++++++
>>   drivers/pci/host/pci-thunder-pem.c                 | 347 ++++++++++++++++++
>>   10 files changed, 1102 insertions(+), 177 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/pci/pci-thunder-ecam.txt
>>   create mode 100644 Documentation/devicetree/bindings/pci/pci-thunder-pem.txt
>>   create mode 100644 drivers/pci/host/pci-host-common.c
>>   create mode 100644 drivers/pci/host/pci-host-common.h
>>   create mode 100644 drivers/pci/host/pci-thunder-ecam.c
>>   create mode 100644 drivers/pci/host/pci-thunder-pem.c
>
> These all look great!
>
> I applied them to pci/host-thunder for v4.6.
>
> I did split up the first patch into three:
>
>    PCI: generic: Move structure definitions to separate header file
>    PCI: generic: Add pci_host_common_probe(), based on gen_pci_probe()
>    PCI: generic: Expose pci_host_common_probe() for use by other drivers
>
> simply to make them smaller and easier to review, bisect, and revert.  I
> verified that the result was identical to your original patch, but
> hopefully I didn't break anything in the intermediate states.  The zero-day
> build robot should catch obvious goofs.
>

Thank you for having the patience to work through all these patch 
revisions with me.

David Daney
