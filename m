Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F47CECDE32
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 11:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77422150F
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 11:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E77422150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbeJQTIS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 15:08:18 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49988 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbeJQTIS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Oct 2018 15:08:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40EFE80D;
        Wed, 17 Oct 2018 04:13:05 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (unknown [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CDA53F59C;
        Wed, 17 Oct 2018 04:13:03 -0700 (PDT)
Date:   Wed, 17 Oct 2018 12:12:58 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 00/21] PCI: Cleanup pci-keystone driver
Message-ID: <20181017111258.GA5692@e107981-ln.cambridge.arm.com>
References: <20181017074114.28239-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017074114.28239-1-kishon@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 17, 2018 at 01:10:53PM +0530, Kishon Vijay Abraham I wrote:
> The PCIe controller in AM654 uses Synopsys core revision 4.90a and uses
> the same TI wrapper as used in keystone2 with certain modification.
> Hence AM654 will use the same pci wrapper driver pci-keystone.c
> 
> In preparation for adding AM654 support, cleanup pci-keystone driver
> here.
> 
> Most of the cleanups here are trivial with major modification being
> merging pci-keystone-dw.c and pci-keystone.c
> 
> Cleaning-up irq handling in the RFC series is dropped here as it has
> few comments to be addressed.
> 
> Changes from v1:
> *) remove phy_reset in the cleanup PHY handling patch. It will be sent
>    while adding AM654 support
> *) Add a separate patch for using ERR_IRQ_STATUS instead of
>    ERR_IRQ_STATUS_RAW
> *) Split outbound window configuration into two patches. One which
>    gets the number of outbound windows from DT and the other cleansup
>    outbound window configuration.
> 
> Kishon Vijay Abraham I (21):
>   PCI: keystone: Use quirk to limit MRRS for K2G
>   PCI: keystone: Use quirk to set MRRS for PCI host bridge
>   PCI: keystone: Move dw_pcie_setup_rc out of ks_pcie_establish_link()
>   PCI: keystone: Do not initiate link training multiple times
>   PCI: keystone: Remove unused argument from ks_dw_pcie_host_init()
>   PCI: keystone: Merge pci-keystone-dw.c and pci-keystone.c
>   PCI: keystone: Remove redundant platform_set_drvdata
>   PCI: keystone: Use uniform function naming convention
>   dt-bindings: PCI: keystone: Add bindings to get device control module
>   PCI: keystone: Use syscon APIs to get device id from control module
>   PCI: keystone: Cleanup PHY handling
>   PCI: keystone: Invoke pm_runtime APIs to enable clock
>   PCI: keystone: Cleanup configuration space access
>   PCI: keystone: Get number of outbound windows from DT
>   PCI: keystone: Cleanup outbound window configuration
>   PCI: keystone: Cleanup set_dbi_mode and get_dbi_mode
>   PCI: keystone: Cleanup ks_pcie_link_up()
>   PCI: keystone: Use ERR_IRQ_STATUS instead of ERR_IRQ_STATUS_RAW to get
>     interrupt status
>   PCI: keystone: Add debug error message for all errors
>   PCI: keystone: Reorder header file in alphabetical order
>   PCI: keystone: Cleanup macros defined in pci-keystone.c
> 
>  .../devicetree/bindings/pci/pci-keystone.txt  |   3 +
>  MAINTAINERS                                   |   2 +-
>  drivers/pci/controller/dwc/Makefile           |   2 +-
>  drivers/pci/controller/dwc/pci-keystone-dw.c  | 484 -----------
>  drivers/pci/controller/dwc/pci-keystone.c     | 788 +++++++++++++++---
>  drivers/pci/controller/dwc/pci-keystone.h     |  57 --
>  drivers/pci/controller/dwc/pcie-designware.h  |   4 +
>  7 files changed, 686 insertions(+), 654 deletions(-)
>  delete mode 100644 drivers/pci/controller/dwc/pci-keystone-dw.c
>  delete mode 100644 drivers/pci/controller/dwc/pci-keystone.h

I have applied the series to pci/keystone, tentatively for v4.20.

Thanks,
Lorenzo
