Return-Path: <SRS0=7sgf=Z4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D7BC2D0B1
	for <linux-pci@archiver.kernel.org>; Fri,  6 Dec 2019 10:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF52E21823
	for <linux-pci@archiver.kernel.org>; Fri,  6 Dec 2019 10:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfLFKwE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 6 Dec 2019 05:52:04 -0500
Received: from foss.arm.com ([217.140.110.172]:39402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbfLFKwD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Dec 2019 05:52:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F13D9DA7;
        Fri,  6 Dec 2019 02:52:02 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8801D3F52E;
        Fri,  6 Dec 2019 02:52:01 -0800 (PST)
Date:   Fri, 6 Dec 2019 10:51:55 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, gustavo.pimentel@synopsys.com,
        andrew.murray@arm.com, robh@kernel.org,
        linux-kernel@vger.kernel.org, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH v10 0/3] PCI: Add Intel PCIe Driver and respective
 dt-binding yaml file
Message-ID: <20191206105155.GA20804@e121166-lin.cambridge.arm.com>
References: <cover.1575612493.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1575612493.git.eswara.kota@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 06, 2019 at 03:27:47PM +0800, Dilip Kota wrote:
> Intel PCIe is Synopsys based controller. Intel PCIe driver uses
> DesignWare PCIe framework for host initialization and register
> configurations.
> 
> Changes on v10:
> 	Rebase the patches on mainline v5.4

I meant current mainline (given that the PCI PR for v5.5 is now
merged), not v5.4, patchset does not apply. Given that v5.5-rc1
is coming up, please rebase on top of v5.5-rc1 and repost it I
will try to merge it then.

Thanks,
Lorenzo

> 	Squashed the patch that fixes the below issue to this patch series.
> 
> 	  WARNING: unmet direct dependencies detected for PCIE_DW_HOST
> 	    Depends on [n]: PCI [=y] && PCI_MSI_IRQ_DOMAIN [=n]
> 	    Selected by [y]:
> 	    - PCIE_INTEL_GW [=y] && PCI [=y] && OF [=y] && (X86 [=y] || COMPILE_TEST [=n])
> 	  "reportedby Randy Dunlap <rdunlap@infradead.org>"
> 
> Dilip Kota (3):
>   dt-bindings: PCI: intel: Add YAML schemas for the PCIe RC controller
>   PCI: dwc: intel: PCIe RC controller driver
>   PCI: artpec6: Configure FTS with dwc helper function
> 
>  .../devicetree/bindings/pci/intel-gw-pcie.yaml     | 138 ++++++
>  drivers/pci/controller/dwc/Kconfig                 |  11 +
>  drivers/pci/controller/dwc/Makefile                |   1 +
>  drivers/pci/controller/dwc/pcie-artpec6.c          |   8 +-
>  drivers/pci/controller/dwc/pcie-designware.c       |  57 +++
>  drivers/pci/controller/dwc/pcie-designware.h       |  12 +
>  drivers/pci/controller/dwc/pcie-intel-gw.c         | 545 +++++++++++++++++++++
>  include/uapi/linux/pci_regs.h                      |   1 +
>  8 files changed, 766 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
>  create mode 100644 drivers/pci/controller/dwc/pcie-intel-gw.c
> 
> -- 
> 2.11.0
> 
