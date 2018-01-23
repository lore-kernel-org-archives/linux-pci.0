Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f174.google.com ([74.125.82.174]:45253 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751285AbeAWBMp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jan 2018 20:12:45 -0500
MIME-Version: 1.0
In-Reply-To: <1516669477-20151-1-git-send-email-shawn.guo@linaro.org>
References: <1516669477-20151-1-git-send-email-shawn.guo@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 22 Jan 2018 23:12:44 -0200
Message-ID: <CAOMZO5DFR=qJ_Q9ag+6Ov92VMZL3wiLSQJee=nKUJFtZ1mW1RQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: histb: add power control GPIO for PCIe slot
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>, project-aspen-dev@linaro.org,
        Jianguo Sun <sunjianguo1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Shawn,

On Mon, Jan 22, 2018 at 11:04 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> From: Jianguo Sun <sunjianguo1@huawei.com>
>
> Besides the GPIO for controlling reset, there is also possibly another
> GPIO for turning on/off the power of PCIe slot.  Let's add the support
> for that with another optional device tree property 'power-gpios'.

It seems that a better approach would be to add regulator support
instead as it is more general.

We do this in drivers/pci/dwc/pci-imx6.c.
