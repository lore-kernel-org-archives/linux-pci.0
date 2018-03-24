Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:45898 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751891AbeCXOHy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Mar 2018 10:07:54 -0400
Received: by mail-qk0-f194.google.com with SMTP id s9so15825906qke.12
        for <linux-pci@vger.kernel.org>; Sat, 24 Mar 2018 07:07:53 -0700 (PDT)
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>
Cc: "'Rob Herring'" <robh@kernel.org>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Linus Walleij'" <linus.walleij@linaro.org>,
        "'Xiaowei Song'" <songxiaowei@hisilicon.com>,
        "'Ray Jui'" <rjui@broadcom.com>,
        "'Scott Branden'" <sbranden@broadcom.com>,
        "'Jon Mason'" <jonmason@broadcom.com>,
        "'Joao Pinto'" <Joao.Pinto@synopsys.com>,
        "'Thomas Petazzoni'" <thomas.petazzoni@free-electrons.com>,
        "'Tanmay Inamdar'" <tinamdar@apm.com>,
        "'Shawn Lin'" <shawn.lin@rock-chips.com>,
        "'Ley Foon Tan'" <lftan@altera.com>,
        "'Fengguang Wu'" <fengguang.wu@intel.com>
References: <20180321144254.7406-1-lorenzo.pieralisi@arm.com> <20180321144254.7406-11-lorenzo.pieralisi@arm.com>
In-Reply-To: <20180321144254.7406-11-lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 10/10] PCI: Move private DT related functions into private header
Date: Sat, 24 Mar 2018 10:07:51 -0400
Message-ID: <000501d3c379$7fc08960$7f419c20$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, March 21, 2018 10:43 AM, Lorenzo Pieralisi wrote:
> 
> From: Rob Herring <robh@kernel.org>
> 
> The functions in linux/of_pci.h are primarily used by host bridge
> drivers, so they can be private to drivers/pci/.
> 
> The remaining functions are still used mostly in host bridge drivers
> that still live in arch specific code. Hopefully someday, those will get
> moved into drivers/pci as well.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han


> ---
>  drivers/pci/dwc/pci-dra7xx.c           |  1 +
>  drivers/pci/dwc/pcie-designware-host.c |  1 +
>  drivers/pci/host/pci-aardvark.c        |  2 ++
>  drivers/pci/host/pci-ftpci100.c        |  2 ++
>  drivers/pci/host/pci-mvebu.c           |  2 ++
>  drivers/pci/host/pci-rcar-gen2.c       |  2 ++
>  drivers/pci/host/pci-tegra.c           |  2 ++
>  drivers/pci/host/pci-v3-semi.c         |  2 ++
>  drivers/pci/host/pci-xgene.c           |  2 ++
>  drivers/pci/host/pcie-altera.c         |  2 ++
>  drivers/pci/host/pcie-iproc-platform.c |  1 +
>  drivers/pci/host/pcie-mediatek.c       |  2 ++
>  drivers/pci/host/pcie-rcar.c           |  2 ++
>  drivers/pci/host/pcie-rockchip.c       |  2 ++
>  drivers/pci/host/pcie-xilinx-nwl.c     |  2 ++
>  drivers/pci/host/pcie-xilinx.c         |  2 ++
>  drivers/pci/pci.h                      | 40
> ++++++++++++++++++++++++++++++++++
>  include/linux/of_pci.h                 | 34 -----------------------------
>  18 files changed, 69 insertions(+), 34 deletions(-)
> 

<.....>
