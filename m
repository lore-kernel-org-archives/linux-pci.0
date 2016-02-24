Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0053.outbound.protection.outlook.com ([65.55.169.53]:35130
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753487AbcBXAi3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 23 Feb 2016 19:38:29 -0500
Message-ID: <56CCFB7E.6030307@caviumnetworks.com>
Date: Tue, 23 Feb 2016 16:38:22 -0800
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
	<linux-arm-kernel@lists.infradead.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Daney, David" <David.Daney@cavium.com>
Subject: Re: [PATCH v6 0/3] Add host controller drivers for Cavium ThunderX
 PCI
References: <1454975731-13618-1-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1454975731-13618-1-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn,

I haven't seen any feedback on this revision of the patch set.

Are there any remaining issues that you are aware of that are blocking 
these?

Thanks in advance,
David Daney


On 02/08/2016 03:55 PM, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
>
> Some Cavium ThunderX processors require quirky access methods for the
> config space of the PCIe bridge.
>
> There are now three patches:
>
> 1) Refactor code in pci-host-generic so that it can more easily be
>     used by other drivers.  This splits the driver for CAM and ECAM
>     access methods to a separate file from the common host driver code.
>
> 2) Add the ThunderX PCIe driver to external PCIe buses, which
>     leverages the code in pci-host-generic
>
> 3) Add ThunderX PCI driver for internel SoC buses used on early
>     ThunderX chip revisions.
>
> Changes from v5: Added Acked-by Rob Herring for the device tree
> binding in 3/3.  Fixed typo and split large functions as suggested by
> Bjorn Helgaas.
>
> Changes from v4: Added patch 3/3.  Stylistic changes to 2/3 suggested
> by Bjorn Helgaas.  When expanding config write width to 32-bits, mask
> out unintened writes to W1C bits, also suggested by Bjorn Helgaas.
>
> Changes from v3: Add some Acked-by, rebased to v4.5.0-rc1
>
> Changes from v2: Improve device tree binding example as noted by Rob
> Herring.  Rename pcie-thunder-pem.* to pci-thunder-pem.* for better
> consistency.  Update MAINTAINERS to reflect the changes.
>
> Changes from v1: Split CAM and ECAM code from common driver code as
> suggested by Arnd Bergmann.  Fix spelling errors in
> pcie-thunder-pem.txt
>
> David Daney (3):
>    PCI: generic: Refactor code to enable reuse by other drivers.
>    pci, pci-thunder-pem: Add PCIe host driver for ThunderX processors.
>    pci, pci-thunder-ecam: Add driver for ThunderX-pass1 on-chip devices
>
>   .../devicetree/bindings/pci/pci-thunder-ecam.txt   |  30 ++
>   .../devicetree/bindings/pci/pci-thunder-pem.txt    |  43 +++
>   MAINTAINERS                                        |   9 +
>   drivers/pci/host/Kconfig                           |  18 ++
>   drivers/pci/host/Makefile                          |   3 +
>   drivers/pci/host/pci-host-common.c                 | 194 +++++++++++
>   drivers/pci/host/pci-host-common.h                 |  47 +++
>   drivers/pci/host/pci-host-generic.c                | 181 +----------
>   drivers/pci/host/pci-thunder-ecam.c                | 358 +++++++++++++++++++++
>   drivers/pci/host/pci-thunder-pem.c                 | 347 ++++++++++++++++++++
>   10 files changed, 1053 insertions(+), 177 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/pci/pci-thunder-ecam.txt
>   create mode 100644 Documentation/devicetree/bindings/pci/pci-thunder-pem.txt
>   create mode 100644 drivers/pci/host/pci-host-common.c
>   create mode 100644 drivers/pci/host/pci-host-common.h
>   create mode 100644 drivers/pci/host/pci-thunder-ecam.c
>   create mode 100644 drivers/pci/host/pci-thunder-pem.c
>

