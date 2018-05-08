Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:44177 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755288AbeEHO3j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 May 2018 10:29:39 -0400
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 0/7] Add endpoint driver for Rockchip PCIe controller
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1524796697-160764-1-git-send-email-shawn.lin@rock-chips.com>
 <20180508115229.GA10653@e107981-ln.cambridge.arm.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <abbd0c7a-c592-b628-e2ab-3df6a5ca33a4@rock-chips.com>
Date: Tue, 8 May 2018 22:28:57 +0800
MIME-Version: 1.0
In-Reply-To: <20180508115229.GA10653@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=gbk; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On 2018/5/8 19:52, Lorenzo Pieralisi wrote:
> Hi Shawn,
> 
> On Fri, Apr 27, 2018 at 10:38:17AM +0800, Shawn Lin wrote:
>>
>> Hi Lorenzo,
>>
>> This's the 6th try to upstream endpoint driver for Rockchip PCIe
>> controller. V6 is rebased by droping the rename change.
>>
>> Thanks.
>>
>>
>> Changes in v6:
>> - rebase
>>
>> Changes in v5:
>> - export symbol to fix error reported by Kbuild robot
>> - PCIE_ROCKCHIP depends on PCI
>>
>> Changes in v4:
>> - remove empty line
>> - keep rockchip's order next to cadence and dwc, but
>>    we will try to resort it later when reconstructing
>>    the directories
>>
>> Shawn Lin (7):
>>    PCI: rockchip: Separate common code from RC driver
> 
> There seems to be no patch (1) on linux-pci list, not sure what
> happened, mind resending the whole series possibly with
> commit logs updated as discussed ?

Sure! Will send v7 for updating commit logs.

> 
> Thanks,
> Lorenzo
> 
>>    PCI: rockchip: Split out common function to parse DT
>>    PCI: rockchip: Split out common function to init controller
>>    dt-bindings: PCI: rockchip: Rename rockchip-pcie.txt to
>>      rockchip-pcie-host.txt
>>    PCI: rockchip: Add Endpoint controller driver for Rockchip PCIe
>>      controller
>>    dt-bindings: PCI: rockchip: Add DT bindings for Rockchip PCIe endpoint
>>      controller
>>    arm64: defconfig: update config for Rockchip PCIe
>>
>>   .../devicetree/bindings/pci/rockchip-pcie-ep.txt   |   62 +
>>   .../{rockchip-pcie.txt => rockchip-pcie-host.txt}  |    0
>>   MAINTAINERS                                        |    4 +-
>>   arch/arm64/configs/defconfig                       |    3 +-
>>   drivers/pci/host/Kconfig                           |   19 +-
>>   drivers/pci/host/Makefile                          |    2 +
>>   drivers/pci/host/pcie-rockchip-ep.c                |  642 ++++++++
>>   drivers/pci/host/pcie-rockchip-host.c              | 1141 +++++++++++++
>>   drivers/pci/host/pcie-rockchip.c                   | 1683 +++-----------------
>>   drivers/pci/host/pcie-rockchip.h                   |  338 ++++
>>   10 files changed, 2406 insertions(+), 1488 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/pci/rockchip-pcie-ep.txt
>>   rename Documentation/devicetree/bindings/pci/{rockchip-pcie.txt => rockchip-pcie-host.txt} (100%)
>>   create mode 100644 drivers/pci/host/pcie-rockchip-ep.c
>>   create mode 100644 drivers/pci/host/pcie-rockchip-host.c
>>   create mode 100644 drivers/pci/host/pcie-rockchip.h
>>
>> -- 
>> 1.9.1
>>
>>
> 
> 
> 


-- 
Best Regards
Shawn Lin
