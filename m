Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B20C282C3
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 14:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D528B218AE
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 14:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfAXOwZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 09:52:25 -0500
Received: from foss.arm.com ([217.140.101.70]:57990 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727755AbfAXOwZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jan 2019 09:52:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A11D4A78;
        Thu, 24 Jan 2019 06:52:24 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41D6F3F5AF;
        Thu, 24 Jan 2019 06:52:22 -0800 (PST)
Date:   Thu, 24 Jan 2019 14:52:19 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Alan Douglas <adouglas@cadence.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/15] PCI: endpoint: Cleanup EPC features
Message-ID: <20190124145219.GD23362@e107981-ln.cambridge.arm.com>
References: <20190107064148.10152-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107064148.10152-1-kishon@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 07, 2019 at 12:11:33PM +0530, Kishon Vijay Abraham I wrote:
> Hi Lorenzo,
> 
> The Endpoint controller driver uses features member in 'struct pci_epc'
> to advertise the list of supported features to the endpoint function
> driver.
> 
> There are a few shortcomings with this approach.
>   *) Certain endpoint controllers support fixed size BAR (e.g. TI's
>      AM654 uses Designware configuration with fixed size BAR). The
>      size of each BARs cannot be passed to the endpoint function
>      driver.
>   *) Too many macros for handling EPC features.
>      (EPC_FEATURE_NO_LINKUP_NOTIFIER, EPC_FEATURE_BAR_MASK,
>       EPC_FEATURE_MSIX_AVAILABLE, EPC_FEATURE_SET_BAR,
>       EPC_FEATURE_GET_BAR)
>   *) Endpoint controllers are directly modifying struct pci_epc
>      members. (I have plans to move struct pci_epc to
>      drivers/pci/endpoint so that pci_epc members are referenced
>      only by endpoint core).
> 
> To overcome the above shortcomings, introduced pci_epc_get_features()
> API, pci_epc_features structure and a ->get_features() callback.
> 
> Also added a patch to set BAR flags in pci_epf_alloc_space and
> remove it from pci-epf-test function driver.
> 
> Tested on TI's DRA7xx platform.

Hi Kishon,

I have no major objections to this series but I would like to see some
testing done in EP mode (on test platforms other than DRA7XX) to make
sure it does not break anything.

Please do help Kishon get some testing done.

Thanks,
Lorenzo

> Thanks
> Kishon
> 
> Kishon Vijay Abraham I (15):
>   PCI: endpoint: Add new pci_epc_ops to get EPC features
>   PCI: dwc: Add ->get_features() callback function in dw_pcie_ep_ops
>   PCI: designware-plat: Populate ->get_features() dw_pcie_ep_ops
>   PCI: pci-dra7xx: Populate ->get_features() dw_pcie_ep_ops
>   PCI: rockchip: Populate ->get_features() dw_pcie_ep_ops
>   PCI: cadence: Populate ->get_features() cdns_pcie_epc_ops
>   PCI: endpoint: Add helper to get first unreserved BAR
>   PCI: endpoint: Fix pci_epf_alloc_space to set correct MEM TYPE flags
>   PCI: pci-epf-test: Remove setting epf_bar flags in function driver
>   PCI: pci-epf-test: Do not allocate next BARs memory if current BAR is
>     64Bit
>   PCI: pci-epf-test: Use pci_epc_get_features to get EPC features
>   PCI: cadence: Remove pci_epf_linkup from Cadence EP driver
>   PCI: rockchip: Remove pci_epf_linkup from Rockchip EP driver
>   PCI: designware-plat: Remove setting epc->features in Designware plat
>     EP driver
>   PCI: endpoint: Remove features member in struct pci_epc
> 
>  drivers/pci/controller/dwc/pci-dra7xx.c       | 13 +++
>  .../pci/controller/dwc/pcie-designware-ep.c   | 12 +++
>  .../pci/controller/dwc/pcie-designware-plat.c | 17 +++-
>  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
>  drivers/pci/controller/pcie-cadence-ep.c      | 25 +++---
>  drivers/pci/controller/pcie-rockchip-ep.c     | 16 +++-
>  drivers/pci/endpoint/functions/pci-epf-test.c | 80 ++++++++++---------
>  drivers/pci/endpoint/pci-epc-core.c           | 52 ++++++++++++
>  drivers/pci/endpoint/pci-epf-core.c           |  3 +
>  include/linux/pci-epc.h                       | 30 +++++--
>  10 files changed, 185 insertions(+), 64 deletions(-)
> 
> -- 
> 2.17.1
> 
