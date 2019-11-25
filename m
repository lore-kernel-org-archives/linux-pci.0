Return-Path: <SRS0=V+Ja=ZR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCE3C432C0
	for <linux-pci@archiver.kernel.org>; Mon, 25 Nov 2019 17:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA812082F
	for <linux-pci@archiver.kernel.org>; Mon, 25 Nov 2019 17:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbfKYRDt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Nov 2019 12:03:49 -0500
Received: from foss.arm.com ([217.140.110.172]:52950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728889AbfKYRDt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Nov 2019 12:03:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D59331B;
        Mon, 25 Nov 2019 09:03:49 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 567403F68E;
        Mon, 25 Nov 2019 09:03:47 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:03:45 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     gustavo.pimentel@synopsys.com, andrew.murray@arm.com,
        helgaas@kernel.org, jingoohan1@gmail.com, robh@kernel.org,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        linux-kernel@vger.kernel.org, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH v9 0/3] PCI: Add Intel PCIe Driver and respective
  dt-binding yaml file
Message-ID: <20191125170345.GB30891@e121166-lin.cambridge.arm.com>
References: <cover.1574314547.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574314547.git.eswara.kota@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 21, 2019 at 05:31:17PM +0800, Dilip Kota wrote:
> Intel PCIe is Synopsys based controller. Intel PCIe driver uses
> DesignWare PCIe framework for host initialization and register
> configurations.
> 
> Dilip Kota (3):
>   dt-bindings: PCI: intel: Add YAML schemas for the PCIe RC controller
>   dwc: PCI: intel: PCIe RC controller driver

"PCI: dwc: ..."

You should follow other commit logs in history as a general
rule to make them uniform, I reordered it.

>   PCI: artpec6: Configure FTS with dwc helper function
> 
>  .../devicetree/bindings/pci/intel-gw-pcie.yaml     | 138 ++++++
>  drivers/pci/controller/dwc/Kconfig                 |  10 +
>  drivers/pci/controller/dwc/Makefile                |   1 +
>  drivers/pci/controller/dwc/pcie-artpec6.c          |   8 +-
>  drivers/pci/controller/dwc/pcie-designware.c       |  57 +++
>  drivers/pci/controller/dwc/pcie-designware.h       |  12 +
>  drivers/pci/controller/dwc/pcie-intel-gw.c         | 545 +++++++++++++++++++++
>  include/uapi/linux/pci_regs.h                      |   1 +
>  8 files changed, 765 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
>  create mode 100644 drivers/pci/controller/dwc/pcie-intel-gw.c

Applied to pci/dwc, we should be able to merge it for v5.5.

Lorenzo
