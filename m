Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:40758 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751833AbeA3AHo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jan 2018 19:07:44 -0500
Date: Mon, 29 Jan 2018 18:07:43 -0600
From: Rob Herring <robh@kernel.org>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        project-aspen-dev@linaro.org
Subject: Re: [PATCH v2 2/2] PCI: histb: add an optional regulator for PCIe
 port power control
Message-ID: <20180130000743.xj43cyaoltj2lqmj@rob-hp-laptop>
References: <1516722337-1533-1-git-send-email-shawn.guo@linaro.org>
 <1516722337-1533-3-git-send-email-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1516722337-1533-3-git-send-email-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 23, 2018 at 11:45:37PM +0800, Shawn Guo wrote:
> The power supply to PCIe port are often controlled by GPIO on some board
> designs.  Let's add an optional regulator which can be backed by GPIO to
> control the power.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  .../bindings/pci/hisilicon-histb-pcie.txt           |  1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/pci/dwc/pcie-histb.c                        | 21 +++++++++++++++++++++
>  2 files changed, 22 insertions(+)
