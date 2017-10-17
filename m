Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:54586 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764586AbdJQWYt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2017 18:24:49 -0400
Date: Tue, 17 Oct 2017 17:24:48 -0500
From: Rob Herring <robh@kernel.org>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: Niklas Cassel <niklass@axis.com>,
        Jesper Nilsson <jespern@axis.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Duc Dang <dhdang@apm.com>, linux-arm-kernel@axis.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] PCI: dwc: artpec6: add support for endpoint mode
Message-ID: <20171017222448.4wfqlr2xaqhjpgiq@rob-hp-laptop>
References: <20171013160914.3220-1-niklas.cassel@axis.com>
 <20171013160914.3220-9-niklas.cassel@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171013160914.3220-9-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 13, 2017 at 06:09:11PM +0200, Niklas Cassel wrote:
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
>  .../devicetree/bindings/pci/axis,artpec6-pcie.txt  |   3 +-

It is preferred to split binding patches. Regardless,

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/pci/dwc/Kconfig                            |  41 +++--
>  drivers/pci/dwc/Makefile                           |   4 +-
>  drivers/pci/dwc/pcie-artpec6.c                     | 202 ++++++++++++++++++++-
>  4 files changed, 233 insertions(+), 17 deletions(-)
