Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <0dad6b43476c1a70944e3e7c245040243ddc2a04.camel@perches.com>
Subject: Re: [PATCH v2 7/9] PCI: dwc: Replace lower into upper case
 characters
From: Joe Perches <joe@perches.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date: Mon, 09 Apr 2018 03:25:46 -0700
In-Reply-To: <a28d463d04b198f51c64c1a7eb5b3f77da2d4ab9.1523266508.git.gustavo.pimentel@synopsys.com>
References: <cover.1523266508.git.gustavo.pimentel@synopsys.com>
         <a28d463d04b198f51c64c1a7eb5b3f77da2d4ab9.1523266508.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2018-04-09 at 10:41 +0100, Gustavo Pimentel wrote:
> Replaces lower into upper case characters in comments and debug printks.
> 
> This is an attempt to keep the messages coherent within the designware
> driver.

It'd be nice to make all the dwc drivers use the same
message wording.

For instance:

drivers/pci/dwc/pci-keystone.c: dev_err(dev, "phy link never came up\n");
drivers/pci/dwc/pcie-designware.c:      dev_err(pci->dev, "phy link never came up\n");
drivers/pci/host/pcie-xilinx-nwl.c:     dev_err(dev, "PHY link never came up\n");
