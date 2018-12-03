Return-Path: <SRS0=SeHV=OM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09F2C04EB9
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 11:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A39820850
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 11:58:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A39820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbeLCL7k (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:59:40 -0500
Received: from foss.arm.com ([217.140.101.70]:35594 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbeLCL7k (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Dec 2018 06:59:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AD81165C;
        Mon,  3 Dec 2018 03:58:55 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3F2A3F59C;
        Mon,  3 Dec 2018 03:58:52 -0800 (PST)
Date:   Mon, 3 Dec 2018 11:58:50 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCH 00/23] PCI: refactor the Mobiveil driver and add PCIe
 support for NXP LX SoCs
Message-ID: <20181203115850.GB8040@e107981-ln.cambridge.arm.com>
References: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 06, 2018 at 01:19:03PM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> This patch set is aim to refactor the Mobiveil driver and add
> PCIe support for NXP LX series SoCs.
> 
> Hou Zhiqiang (23):
>   PCI: mobiveil: uniform the register accessors
>   PCI: mobiveil: format the code without function change
>   PCI: mobiveil: correct the returned error number
>   PCI: mobiveil: remove flag MSI_FLAG_MULTI_PCI_MSI
>   PCI: mobiveil: correct PCI base address in MEM/IO outbound windows
>   PCI: mobiveil: replace the resource list iteration function
>   PCI: mobiveil: use WIN_NUM_0 explicitly for CFG outbound window
>   PCI: mobiveil: use the 1st inbound window for MEM inbound transactions
>   PCI: mobiveil: correct the inbound/outbound window setup routine
>   PCI: mobiveil: fix the INTx process error
>   PCI: mobiveil: only fixup the Class Code field
>   PCI: mobiveil: move out the link up waiting from mobiveil_host_init
>   PCI: mobiveil: move irq chained handler setup out of DT parse
>   PCI: mobiveil: initialize Primary/Secondary/Subordinate bus number
>   dt-bindings: pci: mobiveil: change gpio_slave and apb_csr to optional
>   PCI: mobiveil: refactor the Mobiveil driver
>   PCI: mobiveil: continue to initialize the host upon no PCIe link
>   PCI: mobiveil: disabled IB and OB windows set by bootloader
>   PCI: mobiveil: add Byte and Half-Word width register accessors
>   PCI: mobiveil: change prototype of function mobiveil_host_init
>   dt-bindings: pci: Add NXP LX SoCs PCIe controller
>   PCI: mobiveil: add PCIe RC driver for NXP LX series SoCs
>   arm64: dts: freescale: lx2160a: add pcie DT nodes
> 
>  .../devicetree/bindings/pci/lx-pci.txt        |  52 ++
>  .../devicetree/bindings/pci/mobiveil-pcie.txt |   2 +
>  MAINTAINERS                                   |  10 +-
>  .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 157 ++++
>  drivers/pci/controller/Kconfig                |  11 +-
>  drivers/pci/controller/Makefile               |   2 +-
>  drivers/pci/controller/mobiveil/Kconfig       |  34 +
>  drivers/pci/controller/mobiveil/Makefile      |   5 +
>  drivers/pci/controller/mobiveil/pci-lx.c      | 222 +++++
>  .../controller/mobiveil/pcie-mobiveil-host.c  | 622 +++++++++++++
>  .../controller/mobiveil/pcie-mobiveil-plat.c  |  54 ++
>  .../pci/controller/mobiveil/pcie-mobiveil.c   | 245 +++++
>  .../pci/controller/mobiveil/pcie-mobiveil.h   | 221 +++++
>  drivers/pci/controller/pcie-mobiveil.c        | 861 ------------------
>  14 files changed, 1625 insertions(+), 873 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/lx-pci.txt
>  create mode 100644 drivers/pci/controller/mobiveil/Kconfig
>  create mode 100644 drivers/pci/controller/mobiveil/Makefile
>  create mode 100644 drivers/pci/controller/mobiveil/pci-lx.c
>  create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
>  create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
>  create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.c
>  create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.h
>  delete mode 100644 drivers/pci/controller/pcie-mobiveil.c

Subrahmanya,

for the records, this is the driver *you* are maintaining, aren't you ?

We ask developers to be added to the MAINTAINERS list in order to hold
them accountable, merging a driver upstream means that you need to
actively maintain it, which in turn means reviewing series affecting
its code, like this one.

I will have a look too but it is your responsibility to review these
patches and ACK them accordingly.

So I strongly suggest you start doing it please.

Thanks,
Lorenzo
