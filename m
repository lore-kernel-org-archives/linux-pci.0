Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42861 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932143AbeCABXX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Feb 2018 20:23:23 -0500
Received: by mail-pf0-f193.google.com with SMTP id a16so1776398pfn.9
        for <linux-pci@vger.kernel.org>; Wed, 28 Feb 2018 17:23:23 -0800 (PST)
Date: Thu, 1 Mar 2018 09:22:46 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Jiancheng Xue <xuejiancheng@hisilicon.com>
Subject: Re: [PATCH v2 0/2] Add power control for pcie-histb driver
Message-ID: <20180301012241.GA28619@dragon>
References: <1516722337-1533-1-git-send-email-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1516722337-1533-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 23, 2018 at 11:45:35PM +0800, Shawn Guo wrote:
> The first patch is a small fix which is useful for the second one.
> This version basically follows Fabio's suggestion to reimplement the
> first version patch, using a regulator that can be backed by GPIO to
> control the power to PCIe port.
> 
> Shawn Guo (2):
>   PCI: histb: fix error path of histb_pcie_host_enable()
>   PCI: histb: add an optional regulator for PCIe port power control
> 
>  .../bindings/pci/hisilicon-histb-pcie.txt          |  1 +
>  drivers/pci/dwc/pcie-histb.c                       | 28 ++++++++++++++++++----
>  2 files changed, 25 insertions(+), 4 deletions(-)

Hi Bjorn,

Did you get a chance to look at the series?

Shawn
