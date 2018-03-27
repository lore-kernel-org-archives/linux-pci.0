Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752620AbeC0Rop (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Mar 2018 13:44:45 -0400
Date: Tue, 27 Mar 2018 12:44:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, Fengguang Wu <fengguang.wu@intel.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Ley Foon Tan <lftan@altera.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 04/10] PCI: kirin: struct kirin_pcie_driver can be
 static
Message-ID: <20180327174323.GA7759@bhelgaas-glaptop.roam.corp.google.com>
References: <20180321144254.7406-1-lorenzo.pieralisi@arm.com>
 <20180321144254.7406-5-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180321144254.7406-5-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Ingo]

On Wed, Mar 21, 2018 at 02:42:48PM +0000, Lorenzo Pieralisi wrote:
> From: Fengguang Wu <fengguang.wu@intel.com>
> 
> This was generated from 0-day builder.
> 
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>

Hi Fengguang,

These patches to make things static are awesome :)

There might be a small way to make them even better: change the title
from "struct xxx can be static" to "Make struct xxx static" so it
starts with a capitalized verb and tells what the patch does (not just
what is possible).

This is based on Ingo's suggestions about changelogs [1].

It might be just my personal preference, but I also like to see a
non-empty changelog, even for trivial patches like this, because the
title and the body serve separate semantic purposes and neither should
be empty even if they are both the same.  E.g.,

  PCI: kirin: Make struct kirin_pcie_driver static

  Struct kirin_pcie_driver is only referenced inside pcie-kirin.c, so
  make it static.

  Signed-off-by: ...

[1] http://lkml.kernel.org/r/20120711080446.GA17713@gmail.com

> [robh: add commit msg]
> Signed-off-by: Rob Herring <robh@kernel.org>
> [lorenzo.pieralisi@arm.com: reworked the commit log]
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  drivers/pci/dwc/pcie-kirin.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/dwc/pcie-kirin.c b/drivers/pci/dwc/pcie-kirin.c
> index dcc8cedf6e17..a6b88c7f6e3e 100644
> --- a/drivers/pci/dwc/pcie-kirin.c
> +++ b/drivers/pci/dwc/pcie-kirin.c
> @@ -504,7 +504,7 @@ static const struct of_device_id kirin_pcie_match[] = {
>  	{},
>  };
>  
> -struct platform_driver kirin_pcie_driver = {
> +static struct platform_driver kirin_pcie_driver = {
>  	.probe			= kirin_pcie_probe,
>  	.driver			= {
>  		.name			= "kirin-pcie",
> -- 
> 2.15.0
> 
