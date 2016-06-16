Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34553 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752815AbcFPWTQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jun 2016 18:19:16 -0400
Date: Thu, 16 Jun 2016 17:19:14 -0500
From: Rob Herring <robh@kernel.org>
To: Po Liu <po.liu@nxp.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Roy Zang <roy.zang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
	Stuart Yoder <stuart.yoder@nxp.com>,
	Yang-Leo Li <leoyang.li@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Minghuan Lian <minghuan.lian@nxp.com>,
	Murali Karicheri <m-karicheri2@ti.com>
Subject: Re: [PATCH v3 1/2] nxp/dts: add pcie aer interrupt-name property in
 the dts
Message-ID: <20160616221914.GA2602@rob-hp-laptop>
References: <1464242406-20203-1-git-send-email-po.liu@nxp.com>
 <1465892645-32381-1-git-send-email-po.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465892645-32381-1-git-send-email-po.liu@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 14, 2016 at 04:24:04PM +0800, Po Liu wrote:
> NXP some platforms aer interrupt was not MSI/MSI-X/INTx
> but using interrupt line independently. This patch add a "aer"
> interrupt-names for aer interrupt.

Please put your explanation why this is okay to change in the commit 
message.

> 
> Signed-off-by: Po Liu <po.liu@nxp.com>
> ---
> changes for v3:
> 	- None;
> 
>  .../devicetree/bindings/pci/layerscape-pci.txt         |  4 ++--
>  arch/arm/boot/dts/ls1021a.dtsi                         |  6 ++++--
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi         | 18 +++++++++---------
>  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi         | 16 ++++++++--------
>  4 files changed, 23 insertions(+), 21 deletions(-)
