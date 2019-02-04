Return-Path: <SRS0=vmzI=QL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C84C282C4
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 16:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCDB52087C
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 16:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbfBDQlH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:41:07 -0500
Received: from foss.arm.com ([217.140.101.70]:58126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbfBDQlH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Feb 2019 11:41:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CF41EBD;
        Mon,  4 Feb 2019 08:41:06 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 807313F589;
        Mon,  4 Feb 2019 08:41:03 -0800 (PST)
Date:   Mon, 4 Feb 2019 16:40:54 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com
Subject: Re: [PATCH 00/24] Add support for PCIe RC and EP mode in TI's AM654
 SoC
Message-ID: <20190204164054.GA21488@e107981-ln.cambridge.arm.com>
References: <20190114132424.6445-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114132424.6445-1-kishon@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 14, 2019 at 06:54:00PM +0530, Kishon Vijay Abraham I wrote:
> Add PCIe RC support for TI's AM654 SoC. The PCIe controller in AM654
> uses Synopsys core revision 4.90a and uses the same TI wrapper as used
> in keystone2 with certain modification. Hence AM654 will use the same
> pci wrapper driver pci-keystone.c
> 
> This series was initially part of [1]. This series only includes patches
> that has to be merged via Lorenzo's tree. The PHY patches and dt patches
> will be sent separately.
> 
> This series is created over my keystone MSI cleanup series [2] and EPC
> features series [3].

Hi Kishon,

so I would suggest we merge those series first, starting from the MSI
clean-up.

I will mark this series as awaiting upstream, it is on my radar but
we have to get the two others done first.

Thanks,
Lorenzo

> This series:
> *) Cleanup pci-keystone driver so that both RC mode and EP mode of
>    AM654 can be supported
> *) Modify epc-core to support allocation of aligned buffers required for
>    AM654
> *) Fix ATU unroll identification
> *) Add support for both host mode and device mode in AM654    
> 
> [1] -> https://lore.kernel.org/patchwork/cover/989487/
> [2] -> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1883081.html
> [3] -> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1899011.html
> 
> Kishon Vijay Abraham I (24):
>   PCI: keystone: Add start_link/stop_link dw_pcie_ops
>   PCI: keystone: Cleanup error_irq configuration
>   dt-bindings: PCI: keystone: Add "reg-names" binding information
>   PCI: keystone: Perform host initialization in a single function
>   PCI: keystone: Use platform_get_resource_byname to get memory
>     resources
>   PCI: keystone: Move initializations to appropriate places
>   dt-bindings: PCI: Add dt-binding to configure PCIe mode
>   PCI: keystone: Explicitly set the PCIe mode
>   dt-bindings: PCI: Document "atu" reg-names
>   PCI: dwc: Enable iATU unroll for endpoint too
>   PCI: dwc: Fix ATU identification for designware version >= 4.80
>   PCI: keystone: Prevent ARM32 specific code to be compiled for ARM64
>   dt-bindings: PCI: Add PCI RC dt binding documentation for AM654
>   PCI: keystone: Add support for PCIe RC in AM654x Platforms
>   PCI: keystone: Invoke phy_reset API before enabling PHY
>   PCI: endpoint: Add support to allocate aligned buffers to be mapped in
>     BARs
>   PCI: dwc: Add const qualifier to struct dw_pcie_ep_ops
>   PCI: dwc: Fix dw_pcie_ep_find_capability to return correct capability
>     offset
>   PCI: dwc: Add callbacks for accessing dbi2 address space
>   PCI: keystone: Add support for PCIe EP in AM654x Platforms
>   PCI: designware-ep: Configure RESBAR to advertise the smallest size
>   PCI: designware-ep: Use aligned ATU window for raising MSI interrupts
>   misc: pci_endpoint_test: Add support to test PCI EP in AM654x
>   misc: pci_endpoint_test: Fix test_reg_bar to be updated in
>     pci_endpoint_test
> 
>  .../bindings/pci/designware-pcie.txt          |   7 +-
>  .../devicetree/bindings/pci/pci-keystone.txt  |  14 +-
>  drivers/misc/pci_endpoint_test.c              |  17 +
>  drivers/pci/controller/dwc/Kconfig            |  25 +-
>  drivers/pci/controller/dwc/pci-dra7xx.c       |   2 +-
>  drivers/pci/controller/dwc/pci-keystone.c     | 505 ++++++++++++++----
>  drivers/pci/controller/dwc/pcie-artpec6.c     |   2 +-
>  .../pci/controller/dwc/pcie-designware-ep.c   |  55 +-
>  .../pci/controller/dwc/pcie-designware-host.c |  19 -
>  .../pci/controller/dwc/pcie-designware-plat.c |   2 +-
>  drivers/pci/controller/dwc/pcie-designware.c  |  52 ++
>  drivers/pci/controller/dwc/pcie-designware.h  |  15 +-
>  drivers/pci/endpoint/functions/pci-epf-test.c |   5 +-
>  drivers/pci/endpoint/pci-epf-core.c           |  10 +-
>  include/linux/pci-epc.h                       |   2 +
>  include/linux/pci-epf.h                       |   3 +-
>  16 files changed, 587 insertions(+), 148 deletions(-)
> 
> -- 
> 2.17.1
> 
