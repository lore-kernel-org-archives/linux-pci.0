Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751298AbeERVmO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 May 2018 17:42:14 -0400
Date: Fri, 18 May 2018 16:42:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Scott Branden <scott.branden@broadcom.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v4] PCI: improve host drivers compile test coverage
Message-ID: <20180518214211.GD41790@bhelgaas-glaptop.roam.corp.google.com>
References: <20180405193154.27897-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180405193154.27897-1-robh@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rob,

On Thu, Apr 05, 2018 at 02:31:54PM -0500, Rob Herring wrote:
> Add COMPILE_TEST on driver config options with it. Some ARM drivers
> still have arch dependencies, so we have to keep those dependent on ARM.
> 
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

>  config PCIE_ALTERA
>  	bool "Altera PCIe controller"
> -	depends on ARM || NIOS2
> -	depends on OF_PCI
> +	depends on ARM || NIOS2 || COMPILE_TEST

Did you intend to drop the OF_PCI dependency?

I see that CONFIG_OF_PCI doesn't exist, so that looks bogus.

But drivers/pci/host/pcie-altera.c still uses
devm_of_pci_get_host_bridge_resources(), so I think this should probably
still depend on CONFIG_OF?
