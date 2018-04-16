Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 16 Apr 2018 16:35:03 -0500
From: Rob Herring <robh@kernel.org>
To: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@axis.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: artpec6: Add reset-gpios for PERST# control
Message-ID: <20180416213503.im3dfmbqnqho32w7@rob-hp-laptop>
References: <20180415185621.GR16746@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180415185621.GR16746@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Apr 15, 2018 at 08:56:21PM +0200, Jesper Nilsson wrote:
> Some devices need an optional external gpio for controlling
> the PERST# signal to bring up for example a PCIe switch
> after a soft reset.
> 
> Without this, some boards (the ARTPEC-6 master devboard)
> would not get the PCIe link back after a soft reset.
> 
> Signed-off-by: Jesper Nilsson <jesper.nilsson@axis.com>
> ---
>  .../devicetree/bindings/pci/axis,artpec6-pcie.txt    |  4 ++++
>  drivers/pci/dwc/pcie-artpec6.c                       | 20 +++++++++++++++++++-
>  2 files changed, 23 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
