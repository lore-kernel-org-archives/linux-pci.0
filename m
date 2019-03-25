Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE5EC43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 09:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9EF20863
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 09:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eC1L1AHd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbfCYJiO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:38:14 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:44054 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729608AbfCYJiO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 05:38:14 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2P9bplU065192;
        Mon, 25 Mar 2019 04:37:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553506671;
        bh=2F76Jty0opKOy0XaMDeKKhXl8J8eHxgXCDlZdXGfFQs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=eC1L1AHdjmXVk9V1y5coFJQY/ASprQ75VavBVK1nGrUEi/k+ApC2ab3RHzzJCHlVP
         qoGwS8q+VbqZqC9y72EfXMt3uDqRzVj5K/ClpfcNRxvVNVMphtGSdpjD86Pkl1fPym
         yAi6zjPceslr3yfTHtZN8f61OR3lgvsJ65VwYG2Q=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2P9bpOk046231
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Mar 2019 04:37:51 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 25
 Mar 2019 04:37:51 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Mon, 25 Mar 2019 04:37:51 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2P9bkvn014520;
        Mon, 25 Mar 2019 04:37:47 -0500
Subject: Re: [PATCH v2 00/26] Add support for PCIe RC and EP mode in TI's
 AM654 SoC
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Murali Karicheri <m-karicheri2@ti.com>
CC:     Jingoo Han <jingoohan1@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-arm-kernel@axis.com>
References: <20190325083501.8088-1-kishon@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <84369fe5-c627-2feb-8da5-1cfbb965c665@ti.com>
Date:   Mon, 25 Mar 2019 15:06:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190325083501.8088-1-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 25/03/19 2:04 PM, Kishon Vijay Abraham I wrote:
> Add PCIe RC support for TI's AM654 SoC. The PCIe controller in AM654
> uses Synopsys core revision 4.90a and uses the same TI wrapper as used
> in keystone2 with certain modification. Hence AM654 will use the same
> pci wrapper driver pci-keystone.c
> 
> This series was initially part of [1]. This series only includes patches
> that has to be merged via Lorenzo's tree. The PHY patches and dt patches
> will be sent separately.
> 
> This series is created over keystone MSI cleanup series [2].
> 
> This series:
> *) Cleanup pci-keystone driver so that both RC mode and EP mode of
>    AM654 can be supported
> *) Modify epc-core to support allocation of aligned buffers required for
>    AM654
> *) Fix ATU unroll identification
> *) Add support for both host mode and device mode in AM654
> 
> Changes from v1:
> *) Support for legacy interrupt in AM654 is removed (see backgrond here [3])
> *) Allow of_pci_get_max_link_speed to be used by Endpoint controller
> driver
> *) Add support to set max-link-speed from DT in pci-keystone driver
> *) Update "Reviewed-by: Rob Herring <robh@kernel.org>" tags.

Looks like I've missed updating the tags in the version that was sent out. I'll
resend the series. Sorry for the noise.

Thanks
Kishon

> 
> [1] -> https://lore.kernel.org/patchwork/cover/989487/
> [2] -> https://lkml.org/lkml/2019/3/21/193
> [3] -> https://lkml.org/lkml/2019/3/19/235
> 
> Kishon Vijay Abraham I (26):
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
>   PCI: OF: Allow of_pci_get_max_link_speed() to be used by PCI Endpoint
>     drivers
>   PCI: keystone: Add support to set the max link speed from DT
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
>  drivers/misc/pci_endpoint_test.c              |  18 +
>  drivers/pci/Makefile                          |   2 +-
>  drivers/pci/controller/dwc/Kconfig            |  25 +-
>  drivers/pci/controller/dwc/pci-dra7xx.c       |   2 +-
>  drivers/pci/controller/dwc/pci-keystone.c     | 577 +++++++++++++++---
>  drivers/pci/controller/dwc/pcie-artpec6.c     |   2 +-
>  .../pci/controller/dwc/pcie-designware-ep.c   |  55 +-
>  .../pci/controller/dwc/pcie-designware-host.c |  19 -
>  .../pci/controller/dwc/pcie-designware-plat.c |   2 +-
>  drivers/pci/controller/dwc/pcie-designware.c  |  52 ++
>  drivers/pci/controller/dwc/pcie-designware.h  |  15 +-
>  drivers/pci/endpoint/functions/pci-epf-test.c |   5 +-
>  drivers/pci/endpoint/pci-epf-core.c           |  10 +-
>  drivers/pci/of.c                              |  44 +-
>  include/linux/pci-epc.h                       |   2 +
>  include/linux/pci-epf.h                       |   3 +-
>  18 files changed, 682 insertions(+), 172 deletions(-)
> 
