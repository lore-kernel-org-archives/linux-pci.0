Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752759AbdHXQV4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Aug 2017 12:21:56 -0400
Date: Thu, 24 Aug 2017 11:21:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Varadarajan Narayanan <varada@codeaurora.org>
Cc: bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        svarbanov@mm-sol.com, kishon@ti.com, sboyd@codeaurora.org,
        vivek.gautam@codeaurora.org, fengguang.wu@intel.com,
        weiyongjun1@huawei.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v9 0/3] Add support for IPQ8074 PCIe phy and controller
Message-ID: <20170824162153.GD31858@bhelgaas-glaptop.roam.corp.google.com>
References: <1503041393-19593-1-git-send-email-varada@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503041393-19593-1-git-send-email-varada@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 18, 2017 at 12:59:50PM +0530, Varadarajan Narayanan wrote:
> v9:
>   Incorporate Stanimir's feedback for
> 	PCI: dwc: qcom: Add support for IPQ8074 PCIe controller
> 
>   Add Stanimir's Ack for
> 	PCI: dwc: qcom: Use block IP version for operations
> 	PCI: dwc: qcom: Add support for IPQ8074 PCIe controller
> 
>   Add Rob's Ack for
> 	dt-bindings: pci: qcom: Add support for IPQ8074
> 
> v8:
>   Incorporate Stanimir's feedback for
> 	PCI: dwc: qcom: Add support for IPQ8074 PCIe controller
> 
> v7:
>   Skip PHY patches as they are already included by Kishon
> 
>   Incorporate Stanimir's feedback for the below patches
> 	PCI: dwc: qcom: Use block IP version for operations
> 	PCI: dwc: qcom: Add support for IPQ8074 PCIe controller
> 
> v6:
>   Added 'Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>' and fixed
>   white space issues as mentioned by Vivek.
> 	phy: qcom-qmp: Fix phy pipe clock name
> 	dt-bindings: phy: qmp: Add support for QMP phy in IPQ8074
> 
> v5:
>   dt-bindings: phy: qmp: Add support for QMP phy in IPQ8074
>         Renamed phy_phy clock as common clock
> 
>   phy: qcom-qmp: Fix phy pipe clock name
>         Moved the DT get into the registering function
> 
>   phy: qcom-qmp: Add support for IPQ8074
>         Place the IPQ8074 related structs similar to existing SoC.
>         Renamed phy_phy clock as common clock
> v4:
>   phy: qcom-qmp: Fix phy pipe clock name
> 	Based on Vivek's comments, return failure only for
> 	PCI/USB type of phys.
> 	Removed Ack.
> 
>   phy: qcom-qmp: Handle unavailable registers
> 	Removed this patch.
> 	Incorrectly used a block of code that is not applicable
> 	to IPQ8074, hence had to avoid an "unavailable" register.
> 	Since that is addressed using 'has_phy_com_ctrl' this
> 	patch is not needed.
> 
>   phy: qcom-qmp: Add support for IPQ8074
> 	Set 'has_phy_com_ctrl' to false
> 	Remove ipq8074_pciephy_regs_layout
> 
> v3:
>   PCI: dwc: qcom: Add support for IPQ8074 PCIe controller
> 	Incoporate Stan's feedback:-
> 	 - Add SoC Wrapper and Synopsys Core IP versions
> 
> v2:
>   dt-bindings: phy: qmp: Add output-clock-names
> 	Added Rob H's Ack
> 
>   dt-bindings: phy: qmp: Add support for QMP phy in IPQ8074
> 	Removed example
> 	Added IPQ8074 specific details
> 
>   phy: qcom-qmp: Fix phy pipe clock name
> 	Added Vivek's Ack
> 
>   phy: qcom-qmp: Handle unavailable registers
> 	No changes
> 
>   phy: qcom-qmp: Add support for IPQ8074
> 	No changes
> 
>   PCI: dwc: qcom: Use block IP version for operations
> 	Added new patch to use block IP version instead of v1, v2...
> 
>   dt-bindings: pci: qcom: Add support for IPQ8074
> 	Removed example
> 	Added IPQ8074 specific details
> 
>   PCI: dwc: qcom: Add support for IPQ8074 PCIe controller
> 	Incorporated Bjorn's feedback:-
> 	 - Removed reset names, helper function to assert/deassert, helper
> 	   function to R/M/W register.
> 	 - Renamed sys_noc clock as iface clock
> 	 - Added deinit if phy power on fails
> 
> v1:
> Add definitions required to enable QMP phy support for IPQ8074.
> 
> Add support for the IPQ8074 PCIe controller.  IPQ8074 supports
> Gen 1/2, one lane, two PCIe root complex with support for MSI and
> legacy interrupts, and it conforms to PCI Express Base 2.1
> specification.
> 
> Varadarajan Narayanan (3):
>   PCI: dwc: qcom: Use block IP version for operations
>   dt-bindings: pci: qcom: Add support for IPQ8074
>   PCI: dwc: qcom: Add support for IPQ8074 PCIe controller
> 
>  .../devicetree/bindings/pci/qcom,pcie.txt          |  23 ++
>  drivers/pci/dwc/pcie-qcom.c                        | 346 +++++++++++++++++----
>  2 files changed, 302 insertions(+), 67 deletions(-)

Applied to pci/host-qcom for v4.14, thanks!

I made minor tweaks to match existing code style in pcie-qcom.c.
