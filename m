Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44169 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751625AbcAEVmK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 5 Jan 2016 16:42:10 -0500
Date: Tue, 5 Jan 2016 15:42:06 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Russell King <linux@arm.linux.org.uk>,
	Rob Herring <robh+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: Re: [PATCH v5 0/5] Qualcomm PCIe driver and designware fixes
Message-ID: <20160105214206.GA23814@localhost>
References: <1450442339-18765-1-git-send-email-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1450442339-18765-1-git-send-email-stanimir.varbanov@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 18, 2015 at 02:38:54PM +0200, Stanimir Varbanov wrote:
> Hi,
> 
> I'm sending v5 with following changes:
> - in 1/5 - replace wmb() call with PCIE_ATU_CR2 register read.
> - in 3/5 - addressed comments from Born Helgaas about usage of a
> standard PCI capabilities register names and rename link training
> function to the way that other Designware based drivers use.
> - in 5/5 - addressed a comment from Bjorn Andersson about regulator
> label duplication.
> 
> Comments are welcome!
> 
> The previous v4 of the patch set can be found at [1].
> 
> regards,
> Stan
> 
> [1] https://lkml.org/lkml/2015/12/3/370
> 
> Stanimir Varbanov (5):
>   PCI: designware: ensure ATU is enabled before IO/conf space accesses
>   DT: PCI: qcom: Document PCIe devicetree bindings
>   PCI: qcom: Add Qualcomm PCIe controller driver
>   ARM: dts: apq8064: add pcie devicetree node
>   ARM: dts: ifc6410: enable pcie dt node for this board
> 
>  .../devicetree/bindings/pci/qcom,pcie.txt          |  233 ++++++++
>  MAINTAINERS                                        |    7 +
>  arch/arm/boot/dts/qcom-apq8064-ifc6410.dts         |   26 +
>  arch/arm/boot/dts/qcom-apq8064.dtsi                |   36 ++
>  drivers/pci/host/Kconfig                           |   10 +
>  drivers/pci/host/Makefile                          |    1 +
>  drivers/pci/host/pcie-designware.c                 |    7 +
>  drivers/pci/host/pcie-qcom.c                       |  617 ++++++++++++++++++++
>  8 files changed, 937 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.txt
>  create mode 100644 drivers/pci/host/pcie-qcom.c

Applied to pci/host-qcom for v4.5, with Pratyush's ack on the first patch.
Thanks!
