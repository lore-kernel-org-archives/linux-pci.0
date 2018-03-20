Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:40378 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751186AbeCTSeT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Mar 2018 14:34:19 -0400
Received: by mail-qt0-f193.google.com with SMTP id y6so2685435qtm.7
        for <linux-pci@vger.kernel.org>; Tue, 20 Mar 2018 11:34:19 -0700 (PDT)
Subject: Re: [PATCH 0/9] PCI DT header refactoring and compile test
 improvements
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>
References: <20180307154243.3205-1-robh@kernel.org>
 <20180320181855.GA24991@e107981-ln.cambridge.arm.com>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <1ab13345-b0bc-1552-43b7-c7927810f833@broadcom.com>
Date: Tue, 20 Mar 2018 11:34:14 -0700
MIME-Version: 1.0
In-Reply-To: <20180320181855.GA24991@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,


On 18-03-20 11:18 AM, Lorenzo Pieralisi wrote:
> Hi Rob, all,
>
> On Wed, Mar 07, 2018 at 09:42:34AM -0600, Rob Herring wrote:
>> This started with just moving private functions from of_pci.h to
>> drivers/pci/pci.h, but I was annoyed with trying to build all the right
>> configs, so I enabled COMPILE_TEST on a bunch of drivers. Then I fixed
>> the fallout from doing that. I'm sending this as all one series, but
>> really there is no dependency for the header refactoring patch.
>>
>> Needless to say, this series is *compile tested* only. This is based on
>> Bjorn's for-linus branch (and the of_pci.h fix there).
> I reworked it and applied on top of v4.16-rc1 in my pci/host/misc
> branch to get a kbot report on it - then we can decide how we can
> merge it.
You should send out v2 of the patch series so it can be reviewed and ack'd?

The v1 of the patch shouldn't be merged into mainline and then have v2 
applied on top of it.  Only v2 should be merged upstream.
>
> Thanks,
> Lorenzo
>
>> Rob
>>
>> Fengguang Wu (2):
>>    PCI: rcar: fix semicolon.cocci warnings
>>    PCI: v3-semi: fix semicolon.cocci warnings
>>
>> Rob Herring (6):
>>    PCI: kirin: remove unnecessary asm/compiler.h include
>>    PCI: iproc: remove dependency on ARM specific struct pci_sys_data
>>    PCI: kirin: fix missing dependency on PCI_MSI_IRQ_DOMAIN
>>    PCI: improve host drivers compile test coverage
>>    PCI: dw: move CONFIG_PCI depends to menu
>>    PCI: move private DT related functions into private header
>>
>> kbuild test robot (1):
>>    PCI: kirin_pcie_driver can be static
>>
>>   drivers/pci/dwc/Kconfig                | 42 +++++++++++++---------------------
>>   drivers/pci/dwc/pci-dra7xx.c           |  1 +
>>   drivers/pci/dwc/pcie-designware-host.c |  1 +
>>   drivers/pci/dwc/pcie-kirin.c           |  3 +--
>>   drivers/pci/host/Kconfig               | 33 ++++++++++++--------------
>>   drivers/pci/host/pci-aardvark.c        |  2 ++
>>   drivers/pci/host/pci-ftpci100.c        |  6 +++--
>>   drivers/pci/host/pci-mvebu.c           |  2 ++
>>   drivers/pci/host/pci-rcar-gen2.c       |  2 ++
>>   drivers/pci/host/pci-tegra.c           |  2 ++
>>   drivers/pci/host/pci-v3-semi.c         |  4 +++-
>>   drivers/pci/host/pci-xgene.c           |  2 ++
>>   drivers/pci/host/pcie-altera.c         |  2 ++
>>   drivers/pci/host/pcie-iproc-bcma.c     |  3 +--
>>   drivers/pci/host/pcie-iproc-platform.c |  1 +
>>   drivers/pci/host/pcie-iproc.c          | 19 ++-------------
>>   drivers/pci/host/pcie-iproc.h          |  4 ----
>>   drivers/pci/host/pcie-mediatek.c       |  2 ++
>>   drivers/pci/host/pcie-rcar.c           |  4 +++-
>>   drivers/pci/host/pcie-rockchip.c       |  2 ++
>>   drivers/pci/host/pcie-xilinx-nwl.c     |  2 ++
>>   drivers/pci/host/pcie-xilinx.c         |  2 ++
>>   drivers/pci/pci.h                      | 40 ++++++++++++++++++++++++++++++++
>>   include/linux/of_pci.h                 | 34 ---------------------------
>>   24 files changed, 108 insertions(+), 107 deletions(-)
>>
>> -- 
>> 2.14.1
>>
